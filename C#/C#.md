# C# Notes

## How to see what dependencies are installed

`dotnet list package`

## How to remove a dependency

`dotnet remove package (package name)`

## Reverse engineering a remote database

There are some
[tools](https://docs.microsoft.com/en-us/ef/core/miscellaneous/cli/dotnet) which
allow us to reverse engineer the models defined in our database. To to this
ensure that you have the tool installed `dotnet tool install --global dotnet-ef` and then
run the command:  
`dotnet ef dbcontext scaffold "server=localhost:3306;database=Wiki;user=root;password=muhR00T!" Pomelo.EntityFrameworkCore.MySql -o Model`

## Data

### Trim

Typically objects from FE may or may not come with their values trimmed. If you're taking it as a model a recommendation would be do use a backing field:

```c#
public class Pages
{
    public int PageID { get; set; }

    private string _folderName;
    public string FolderName
    {
        get { return _folderName; }
        //The ? checks for nulls.
        set { _folderName = value?.Trim(); }
    }
}
```

## Testing

Typically for tests what I do is:

```c#
//Test File
        [Theory]
        [ClassData(typeof(CreateUserAsAdminTestData))]
        public void HasPermissionToMakeUser_Admin(UserToCreateModel userToCreateModel, bool expected)
        {
            var userServiceSut = instantiateUserService();
            var sampleAdminUser = new UserModel
            {
                Id = 1,
                UserRoles = new UserRoleModel[]
                {
                    new UserRoleModel
                    {
                        Id = 1,
                        RoleId = (int) Constants.Role.Admin
                    }
                }
            };
            mockUserRepository.Setup(s => s.GetUserIdBySub()).Returns(Task.FromResult(sampleAdminUser));
            var result = userServiceSut.HasPermissionToMakeUser(userToCreateModel).Result;

            Assert.Equal(expected, result);
        }
// Test Data file
    class CreateUserAsHi55AdminTestData : IEnumerable<object[]>
    {
        public IEnumerator<object[]> GetEnumerator()
        {
            yield return new object[] { new UserToCreateModel { CompanyId = 1, RoleId = (int) Constants.Role.Owner }, true };
            yield return new object[] { new UserToCreateModel { CompanyId = 1, RoleId = (int) Constants.Role.User }, true};

            yield return new object[] { new UserToCreateModel { CompanyId = 2, RoleId = (int) Constants.Role.Owner }, true };
            yield return new object[] { new UserToCreateModel { CompanyId = 2, RoleId = (int) Constants.Role.User }, true };
        }

        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
    }
```
package tests
{
    import flexunit.framework.TestCase;

    // This is an example TestCase file to demonstrate the various assertions available
    // and give you something to run out of the box.
    //
    // Run your tests with the "rake test" command in your project root
    public class ExampleTest extends TestCase
    {
      
      private var someString:String;
      
      // This function is automatically called before each test is run
      override public function setUp():void
      {
        // Initialize any variables you might need across multiple tests
        someString = "some string";
      }
      
      // This function is automatically called after each test is run
      override public function tearDown():void
      {
        // You really don't need to do this.
        someString = null;
      }
      
      public function testAssertTrue():void
      {
        assertTrue(true);
      }
      
      public function testAssertFalse():void
      {
        assertFalse(false);
      }
      
      public function testAssertNull():void
      {
        assertNull(null);
      }
      
      public function testAssertNotNull():void
      {
        assertNotNull("anything but null");
      }
      
      // Compare with ==
      public function testAssertEquals():void
      {
        assertEquals(someString, "some string");
      }
      
      // Compare with ===
      public function testAssertStrictlyEquals():void
      {
        assertStrictlyEquals(someString, someString);
      }
      
      // And, for good measure, a failing test.
      public function testFailure():void
      {
        assertTrue(false);
      }
    }
}
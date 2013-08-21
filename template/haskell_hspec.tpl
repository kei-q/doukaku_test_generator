import Test.Hspec

import Solver (solve)

main :: IO ()
main = hspec $ do
  describe $ do
{{#tests}}
    it "test {{no}}" $ do
      solve "{{input}}" `shouldBe` "{{output}}"

{{/tests}}
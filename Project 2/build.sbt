// libraryDependencies += "org.scalatest" %% "scalatest" % "3.0.0" % "test"

// resolvers += "Central" at "https://central.maven.org/maven2/"

// scalacOptions := Seq("-unchecked", "-deprecation", "-feature", "-language:postfixOps")

val scala3Version = "3.5.1"

lazy val root = project
  .in(file("."))
  .settings(
    name := "project",
    version := "0.1.0-SNAPSHOT",

    scalaVersion := scala3Version,

    libraryDependencies += "org.scalameta" %% "munit" % "1.0.0" % Test
  )


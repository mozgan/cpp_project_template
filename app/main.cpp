#include <iostream>

#include "buildinfo.h"

auto main() -> int {
  std::clog << "Commit SHA: " << BuildInfo::kCommitSha << std::endl;
  std::clog << "Timestamp : " << BuildInfo::kTimestamp << std::endl;
  std::clog << "Version   : " << BuildInfo::kVersion << std::endl;

  return 0;
}

From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/powerplay: Zero initialize some variables
Date: Sun,  4 Aug 2019 13:37:13 -0700
Message-ID: <20190804203713.13724-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Clang warns (only Navi warning shown but Arcturus warns as well):

drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1534:4: warning:
variable 'asic_default_power_limit' is used uninitialized whenever '?:'
condition is false [-Wsometimes-uninitialized]
                        smu_read_smc_arg(smu, &asic_default_power_limit);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:588:3: note:
expanded from macro 'smu_read_smc_arg'
        ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu), (arg)) : 0)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1550:30: note:
uninitialized use occurs here
                smu->default_power_limit = asic_default_power_limit;
                                           ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1534:4: note:
remove the '?:' if its condition is always true
                        smu_read_smc_arg(smu, &asic_default_power_limit);
                        ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:588:3: note:
expanded from macro 'smu_read_smc_arg'
        ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu), (arg)) : 0)
         ^
drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1517:35: note:
initialize the variable 'asic_default_power_limit' to silence this
warning
        uint32_t asic_default_power_limit;
                                         ^
                                          = 0
1 warning generated.

As the code is currently written, if read_smc_arg were ever NULL, arg
would fail to be initialized but the code would continue executing as
normal because the return value would just be zero.

There are a few different possible solutions to resolve this class
of warnings which have appeared in these drivers before:

1. Assume the function pointer will never be NULL and eliminate the
   wrapper macros.

2. Have the wrapper macros initialize arg when the function pointer is
   NULL.

3. Have the wrapper macros return an error code instead of 0 when the
   function pointer is NULL so that the callsites can properly bail out
   before arg can be used.

4. Initialize arg at the top of its function.

Number four is the path of least resistance right now as every other
change will be driver wide so do that here. I only make the comment
now as food for thought.

Fixes: b4af964e75c4 ("drm/amd/powerplay: make power limit retrieval as asic specific")
Link: https://github.com/ClangBuiltLinux/linux/issues/627
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 2 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 215f7173fca8..b92eded7374f 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1326,7 +1326,7 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 				     bool asic_default)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t asic_default_power_limit;
+	uint32_t asic_default_power_limit = 0;
 	int ret = 0;
 	int power_src;
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 106352a4fb82..d844bc8411aa 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1514,7 +1514,7 @@ static int navi10_get_power_limit(struct smu_context *smu,
 				     bool asic_default)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t asic_default_power_limit;
+	uint32_t asic_default_power_limit = 0;
 	int ret = 0;
 	int power_src;
 
-- 
2.23.0.rc1

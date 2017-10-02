From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: build failures on drm-next
Date: Mon, 2 Oct 2017 09:49:45 -0400
Message-ID: <c4ee0f01-1c09-a978-01b9-4bc92c4459e8@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------BCD4239B6FDAB25E48121EE2"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--------------BCD4239B6FDAB25E48121EE2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

The lastest good commit is

commit f5a16c561fb8a15e94a4384e880b9d84a2657098
Author: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Date:   Thu Sep 28 14:46:17 2017 +0100

     drm/radeon: make functions alloc_pasid and free_pasid static

     The functions alloc_pasid  and free_pasid are local to the
     source and do not need to be in global scope, so make them static.

     Cleans up sparse warnings:
     warning: symbol 'alloc_pasid' was not declared. Should it be static?
     warning: symbol 'free_pasid' was not declared. Should it be static?

     Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
     Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>


I see errors (e.g., attached) when building from the tip of drm-next.

Cheers,
Tom

--------------BCD4239B6FDAB25E48121EE2
Content-Type: text/x-log;
 name="drmnext_build.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="drmnext_build.log"

  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     scripts/mod/devicetable-offsets.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/bounds.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC [M]  drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_services.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.o
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:23:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c: In function ‘rv_populate_clock_table’:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:424:44: error: passing argument 1 of ‘smum_send_msg_to_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr->smumgr,
                                            ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/pp_debug.h:39:9: note: in definition of macro ‘PP_ASSERT_WITH_CODE’
   if (!(cond)) {   \
         ^~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:31:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:99:12: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 extern int smum_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg);
            ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:23:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:428:44: error: passing argument 1 of ‘rv_read_arg_from_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  PP_ASSERT_WITH_CODE(!rv_read_arg_from_smc(hwmgr->smumgr,
                                            ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/pp_debug.h:39:9: note: in definition of macro ‘PP_ASSERT_WITH_CODE’
   if (!(cond)) {   \
         ^~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:37:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/rv_smumgr.h:54:5: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 int rv_read_arg_from_smc(struct pp_hwmgr *hwmgr, uint32_t *arg);
     ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:23:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:434:44: error: passing argument 1 of ‘smum_send_msg_to_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr->smumgr,
                                            ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/pp_debug.h:39:9: note: in definition of macro ‘PP_ASSERT_WITH_CODE’
   if (!(cond)) {   \
         ^~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:31:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:99:12: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 extern int smum_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg);
            ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:23:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:438:44: error: passing argument 1 of ‘rv_read_arg_from_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  PP_ASSERT_WITH_CODE(!rv_read_arg_from_smc(hwmgr->smumgr,
                                            ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/pp_debug.h:39:9: note: in definition of macro ‘PP_ASSERT_WITH_CODE’
   if (!(cond)) {   \
         ^~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:37:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/rv_smumgr.h:54:5: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 int rv_read_arg_from_smc(struct pp_hwmgr *hwmgr, uint32_t *arg);
     ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:23:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c: In function ‘rv_print_clock_levels’:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:629:45: error: passing argument 1 of ‘smum_send_msg_to_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr->smumgr,
                                             ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/pp_debug.h:39:9: note: in definition of macro ‘PP_ASSERT_WITH_CODE’
   if (!(cond)) {   \
         ^~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:31:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:99:12: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 extern int smum_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg);
            ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:23:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:633:45: error: passing argument 1 of ‘rv_read_arg_from_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   PP_ASSERT_WITH_CODE(!rv_read_arg_from_smc(hwmgr->smumgr,
                                             ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/pp_debug.h:39:9: note: in definition of macro ‘PP_ASSERT_WITH_CODE’
   if (!(cond)) {   \
         ^~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:37:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/rv_smumgr.h:54:5: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 int rv_read_arg_from_smc(struct pp_hwmgr *hwmgr, uint32_t *arg);
     ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:23:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:648:45: error: passing argument 1 of ‘smum_send_msg_to_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr->smumgr,
                                             ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/pp_debug.h:39:9: note: in definition of macro ‘PP_ASSERT_WITH_CODE’
   if (!(cond)) {   \
         ^~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:31:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:99:12: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 extern int smum_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg);
            ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:23:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:652:45: error: passing argument 1 of ‘rv_read_arg_from_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   PP_ASSERT_WITH_CODE(!rv_read_arg_from_smc(hwmgr->smumgr,
                                             ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/pp_debug.h:39:9: note: in definition of macro ‘PP_ASSERT_WITH_CODE’
   if (!(cond)) {   \
         ^~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:37:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/rv_smumgr.h:54:5: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 int rv_read_arg_from_smc(struct pp_hwmgr *hwmgr, uint32_t *arg);
     ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c: In function ‘rv_read_sensor’:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:904:30: error: passing argument 1 of ‘smum_send_msg_to_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   ret = smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_GetGfxclkFrequency);
                              ^~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:31:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:99:12: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 extern int smum_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg);
            ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:906:25: error: passing argument 1 of ‘rv_read_arg_from_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
    rv_read_arg_from_smc(hwmgr->smumgr, &sclk);
                         ^~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:37:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/rv_smumgr.h:54:5: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 int rv_read_arg_from_smc(struct pp_hwmgr *hwmgr, uint32_t *arg);
     ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:913:30: error: passing argument 1 of ‘smum_send_msg_to_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   ret = smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_GetFclkFrequency);
                              ^~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:31:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:99:12: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 extern int smum_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg);
            ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:915:25: error: passing argument 1 of ‘rv_read_arg_from_smc’ from incompatible pointer type [-Werror=incompatible-pointer-types]
    rv_read_arg_from_smc(hwmgr->smumgr, &mclk);
                         ^~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c:37:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/rv_smumgr.h:54:5: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 int rv_read_arg_from_smc(struct pp_hwmgr *hwmgr, uint32_t *arg);
     ^~~~~~~~~~~~~~~~~~~~
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.o
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c: In function ‘vega10_enable_didt_config’:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c:1246:40: error: passing argument 1 of ‘vega10_enable_smc_features’ from incompatible pointer type [-Werror=incompatible-pointer-types]
    result = vega10_enable_smc_features(hwmgr->smumgr, true, data->smu_features[GNLD_DIDT].smu_feature_bitmap);
                                        ^~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c:27:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vega10_smumgr.h:60:5: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 int vega10_enable_smc_features(struct pp_hwmgr *hwmgr,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c: In function ‘vega10_disable_didt_config’:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c:1293:40: error: passing argument 1 of ‘vega10_enable_smc_features’ from incompatible pointer type [-Werror=incompatible-pointer-types]
    result = vega10_enable_smc_features(hwmgr->smumgr, false, data->smu_features[GNLD_DIDT].smu_feature_bitmap);
                                        ^~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c:27:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vega10_smumgr.h:60:5: note: expected ‘struct pp_hwmgr *’ but argument is of type ‘struct pp_smumgr *’
 int vega10_enable_smc_features(struct pp_hwmgr *hwmgr,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/basics/fixpt31_32.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/basics/fixpt32_32.o
cc1: some warnings being treated as errors
distcc[19873] ERROR: compile drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.c on localhost failed
scripts/Makefile.build:302: recipe for target 'drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.o' failed
make[4]: *** [drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/rv_hwmgr.o] Error 1
make[4]: *** Waiting for unfinished jobs....
cc1: some warnings being treated as errors
distcc[19715] ERROR: compile drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c on localhost failed
scripts/Makefile.build:302: recipe for target 'drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.o' failed
make[4]: *** [drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.o] Error 1
scripts/Makefile.build:561: recipe for target 'drivers/gpu/drm/amd/amdgpu' failed
make[3]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
scripts/Makefile.build:561: recipe for target 'drivers/gpu/drm' failed
make[2]: *** [drivers/gpu/drm] Error 2
scripts/Makefile.build:561: recipe for target 'drivers/gpu' failed
make[1]: *** [drivers/gpu] Error 2
Makefile:1019: recipe for target 'drivers' failed
make: *** [drivers] Error 2

--------------BCD4239B6FDAB25E48121EE2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------BCD4239B6FDAB25E48121EE2--

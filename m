From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/6] drm/amd/pp: Implement update_dpm_settings on Polaris
Date: Fri, 23 Feb 2018 16:55:56 +0800
Message-ID: <1519376159-946-3-git-send-email-Rex.Zhu@amd.com>
References: <1519376159-946-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1641103388=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519376159-946-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--===============1641103388==
Content-Type: text/plain; charset="a"
Content-Transfer-Encoding: 8bit

v2: lock dpm level when update pptable by SW method

use SW method to update DPM settings by updating SRAM
directly on Polaris.

Change-Id: I90f0cadd60f4e9d62399616e29a254d7c4799597
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 1.txt                                              | 1321 ++++++++++++++++++++
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |   97 ++
 2 files changed, 1418 insertions(+)
 create mode 100644 1.txt

diff --git a/1.txt b/1.txt
new file mode 100644
index 0000000..42cac14
--- /dev/null
+++ b/1.txt
@@ -0,0 +1,1321 @@
+commit 86aba506b1038d738f85725ef7920493930fcbcf
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Jan 24 14:48:17 2018 +0800
+
+    drm/amd/pp: Add a new smu backend function
+    
+    it is used for adjust part of dpm settigs
+    to get better performance under different
+    workloads.
+    
+    Change-Id: I6159b8a5849a2e1592fec951cc538dacd9da8c82
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+
+commit 9d48da910b6114ebcd10222bb4287d109769e6d7
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Feb 22 17:45:11 2018 +0800
+
+    drm/amd/pp: Add a pp feature mask bit for AutoWattman feature
+    
+    Change-Id: I6812aee70f9f06cb31b581361a737d2c48b0e897
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+
+commit ff9e3091c5f0ef0905894547722ed2c4eaecd577
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Feb 2 17:13:02 2018 +0800
+
+    drm/amd/pp: Restore power profile mode in auto dpm level on Vega10
+    
+    As auto power profile mode still not support on vega10, so
+    just restore default profile mode in auto dpm level.
+    
+    Change-Id: Ie2bb8bf1149ce5f1e09d010ca7b998e4a8e25370
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+
+commit ba17b26bc8e44cac37224b65d323c23360631094
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Jan 29 18:04:18 2018 +0800
+
+    drm/amd/pp: Expose set/get_power_limit for DGPU
+    
+    User can change power limit between
+    [0, 1] * max power limit.
+    
+    Set power limit to 0, restore to max power limit.
+    
+    Change-Id: I494bc65fc38bf5e052af078a0dda692d72c9a9de
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+
+commit 957c7a8e631efdc681c8252c57988b8f7201ffb4
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Feb 6 14:38:38 2018 -0500
+
+    drm/amd/powerplay: add mmhub powergating by smu in powerplay
+    
+    new generic interface is added in powerplay.
+    
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit bdfdb645e8970f16a090b55d3274089c3b964693
+Author: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
+Date:   Tue Feb 6 15:35:00 2018 +0300
+
+    drm/amd/powerplay: delete some dead code
+    
+    We deleted some code in e154162ef75d ("drm/amd/powerplay: refine pp code
+    for raven") but there were a few related bits that were missed.  Let's
+    delete them as well.
+    
+    Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit bf5b43419b19c726f2b64eee74e7a845013255f1
+Author: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Jan 24 17:44:48 2018 -0500
+
+    drm/amdgpu/pp: remove the get_temperature API
+    
+    This is also supported with the read_sensor API and there
+    were no more users of the get_temperature API.
+    
+    Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit a6704dcf5299ee6978928f01f0558310f32d31ff
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Jan 11 15:02:15 2018 +0800
+
+    drm/amd/pp: Add hwmgr interface for edit dpm table
+    
+    Add odn_edit_dpm_table function
+    points for setting user assigned clock/voltage.
+    
+    Change-Id: I29d336123d1a78384b74b54d34f34f1e60dc5f51
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+
+commit 8b221cdc1ac752ab7ff885b7e00070fad0958c35
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Jan 4 16:42:06 2018 +0800
+
+    drm/amd/pp: Add a new pp feature mask bit for OD feature
+    
+    when this bit was set on module load,
+    driver will allow the user over/under gpu
+    clock and voltage through sysfs.
+    
+    by default, this bit was not set.
+    
+    Change-Id: I491c468eb0a8c1ab1accf0f390a9bc73c23301ca
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+
+commit fd31264f2ccc2532001ddbe91279fee8bd0aebb8
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Jan 5 19:02:48 2018 +0800
+
+    drm/amd/pp: Store stable Pstate clocks
+    
+    User can use to calculate profiling ratios when
+    set UMD Pstate.
+    
+    Change-Id: I6e98983c95b08a7441c628da8913095d68bdc9d3
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+
+commit 07ff791e46b0b3caa3f011da0cb65411603afd64
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Jan 10 18:48:06 2018 +0800
+
+    drm/amd/pp: Add custom power profile mode support on Vega10
+    
+    v2: delete uncessary blank line.
+        Add static const modifiers to an array
+    
+    Change-Id: Ib37b73baba0275e3c7ef9fcfe66ca76279c2804b
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+
+commit 8df6b4d557f577d87c177e066059d05c2fb56268
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Jan 3 17:24:36 2018 +0800
+
+    drm/amd/pp: Add a helper to convert VID to voltage value
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 79638417a0dbdcc98b4ce374b9e0521bcc2312f9
+Author: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Dec 28 14:20:05 2017 +0800
+
+    drm/amd/powerplay: new hw manager interface for retrieving device specific thermal range
+    
+    Added a new callback for asic specific backends to specify the temperature ranges.
+    
+    Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 2f73b068d165d56eebbbadff87a2cbaf4d281e25
+Author: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Dec 29 14:46:13 2017 +0800
+
+    drm/amd/powerplay: removed hwmgr_handle_task unused parameter and given a better name for
+    other parameter
+    
+    Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit d100033b2a48ac0bdbb19719ee474bea73855a99
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Dec 19 14:04:24 2017 +0800
+
+    drm/amd/pp: Move smu_version to common code
+    
+    Move the smu_version to struct hwmgr, so it can be shared
+    by other asics.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 29411f05c6594d363620b01922d90b5494411046
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Dec 18 15:03:23 2017 +0800
+
+    drm/amd/pp: delete dead code of arbiter overdriver clk
+    
+    for sclk/mclk, can be adjusted through sysfs.
+    for uvd/vce clk, will be adjusted case by case when
+    requested.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit e83dcf1051ea81e93f9486a1d50c193f3f1d344c
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Oct 9 12:21:30 2017 +0800
+
+    drm/amd/pp: add new function point in hwmgr.
+    
+    used for notify SMU the allocated buffer address.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 538fdf1fe7bea0e3a1cfde4ebf6ded9f397a1914
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Sep 20 17:29:23 2017 +0800
+
+    drm/amd/powerplay: move macros to hwmgr.h
+    
+    the macro is not relevant to SMU,
+    so rename SMU_WAIT_FIELD_UNEQUAL to
+    PHM_WAIT_FIELD_UNEQUAL and move to hwmgr.h
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 57d13f794dcf918d9710923d0c64edb14e370271
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Sep 20 17:04:33 2017 +0800
+
+    drm/amd/powerplay: move PHM_WAIT_VFPF_INDIRECT_FIELD to hwmgr.h
+    
+    the macro is not relevant to SMU, so move to hwmgr.h
+    and rename to PHM_WAIT_VFPF_INDIRECT_FIELD
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 554d95da398b6b998f8801daf0d0ace5caab34ff
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Sep 20 17:00:50 2017 +0800
+
+    drm/amd/powerplay: move SMUM_WAIT_VFPF_INDIRECT_FIELD_UNEQUAL to hwmgr.h
+    
+    the macro is not relevant to SMU, so move to hwmgr.h
+    and rename to PHM_WAIT_VFPF_INDIRECT_FIELD_UNEQUAL
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit b05720cbf6458450700d1c3e91d2b2620b4f6295
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Sep 20 19:28:29 2017 +0800
+
+    drm/amd/powerplay: move SMUM_WAIT_INDIRECT_FIELD_UNEQUAL to hwmgr.h
+    
+    the macro is not relevent to SMU, so move to hwmgr.h
+    and rename to PHM_WAIT_INDIRECT_FIELD_UNEQUAL
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit d92cb1629bcc8cdf4d616f144ced399723816ba3
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Sep 20 19:22:01 2017 +0800
+
+    drm/amd/powerplay: add new helper functions in hwmgr.h
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit b3b030520df05fca7f2dcca455c9628f483a1f95
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Sep 26 13:28:27 2017 -0400
+
+    drm/amd/powerplay: refine powerplay code.
+    
+    delete struct smumgr, put smu backend function table
+    in struct hwmgr
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 221c89f980ea96a6baf80b17b6c6a618fc366e73
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Sep 20 15:41:33 2017 +0800
+
+    drm/amd/powerplay: delete dead code in hwmgr.h
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 2a5b64c9fcd7adf6133e76966250ef3ab139f98b
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Sep 15 16:38:49 2017 -0400
+
+    drm/amd/powerplay: add register thermal interrupt in hwmgr_hw_init
+    
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit f93f0c3a7e8635a507b3f084f5f8b48441c79c9d
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Sep 6 16:08:03 2017 +0800
+
+    drm/amd/powerplay: use struct amd_pm_funcs in powerplay
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 698f88e697cc8852558d120fdecfdb38c18c2ff7
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Sep 4 18:22:02 2017 +0800
+
+    drm/amd/powerplay: delete dead code in powerplay
+    
+    delete functiontable related codes
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 1ab4720441ed6a918c06c4ddf882ef8bc50c8ef0
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Sep 4 16:25:48 2017 +0800
+
+    drm/amd/powerplay: refine code for thermal control in powerplay
+    
+    add function point start_thermal_controller in hwmgr,
+    delete thermal function table and related functions
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 9947f7047f2b57735fa5c76d63728642a1850527
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Aug 29 16:08:56 2017 +0800
+
+    drm/amd/powerplay: add UMD P-state in powerplay.
+    
+    This feature is for UMD to run benchmark in a
+    power state that is as steady as possible. kmd
+    need to fix the power state as stable as possible.
+    now, kmd support four level:
+    profile_standard,peak,min_sclk,min_mclk
+    
+    move common related code to amd_powerplay.c
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit df1e63942063a0638a5813e5904988d834db2665
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Sep 1 13:46:20 2017 +0800
+
+    drm/amd/powerplay: delete eventmgr layer in poweprlay
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 841e3be124b58c6e86fe288bce4dfe58d5574fd3
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Aug 25 16:58:10 2017 +0800
+
+    drm/amd/powerplay: notify smu once display changed on Rv.
+    
+    when User turn off display or screen idle timeout,
+    smu need this message to start S0i2 entry.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit b59eb8984f3080c01b2022772005874446d29646
+Author: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Jul 28 09:40:08 2017 +0800
+
+    drm/amd/powerplay: add vclk/dclkSoftMin support for raven
+    
+    Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 5746f36dacde7ff6aee807bfe59a2df502aaa8f0
+Author: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue May 23 18:32:30 2017 +0800
+
+    drm/amd/powerplay: update magic number for rv hw backend
+    
+    Signed-off-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 96cda84a6762a8caa9aee9381022e28adb3ea1ef
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Apr 21 13:14:01 2017 +0800
+
+    drm/amd/powerplay: add new clock type in struct gfx_arbit.
+    
+    Add the new clock type to the gfx arbitor so we can determine
+    the proper clock floors for it.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit a960d61cbd62544c04adb4fe6513577601ff4535
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu May 11 16:38:38 2017 -0400
+
+    drm/amd/powerplay: add raven support in hwmgr. (v2)
+    
+    hwmgr handles the GPU power state management.
+    
+    v2: squash in updates (Alex)
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit adfc7f077d9ac9aab6e4ac15e34ab84519d98b0d
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Sun Feb 5 18:50:22 2017 +0800
+
+    drm/amd/powerplay: add ppt_v3 define
+    
+    defines clock dependencies for raven.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit fbf66a3c9c100cedf4942384fa6877be70fb0e7c
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed May 10 21:51:24 2017 +0800
+
+    drm/amd/powerplay: Add Vega10 Powertune Table v3 support.
+    
+    Handle the latest powerplay table format; includes Boost
+    State support.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewws-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 2fde9ab218b7f8446c2428b7f9dad602afce8be6
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri May 5 16:50:36 2017 +0800
+
+    drm/amd/powerplay: refine pwm1_enable callback functions for vi.
+    
+    Use the new enums for setting and getting the fan control mode.
+    Fixes problems due to previous inconsistencies between enums.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 652bd0c3441d861402bf7347088c846b6799c5b8
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed May 3 15:38:58 2017 +0800
+
+    drm/amd/powerplay: delete dead code in powerplay.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 1dfc41d44c20dc3efbd0139d7f991d13c6daa875
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Apr 27 15:46:35 2017 +0800
+
+    drm/amd/powerplay: add disable_smc_ctf callback in hwmgr.
+    
+    export disablesmcctf to eventmgr.
+    need to disable temperature alert when s3/s4.
+    otherwise, when resume back,enable temperature
+    alert will fail.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit f83a9991648bb4023a53104db699e99305890d51
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Mar 6 14:03:02 2017 -0500
+
+    drm/amd/powerplay: add Vega10 powerplay support (v5)
+    
+    Adds power management support for vega10.
+    
+    v2: squash in fan control and led config fixes from Rex
+    v3: squash in dead code removal and socvid fixes from Rex
+    v4: squash in dpm force level fix from Rex
+    v5: squash in latest headless, gpu load fixes from Rex
+    
+    Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit d018772748fc474b2265ce333a704620b17df3fd
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Mar 6 13:13:48 2017 -0500
+
+    drm/amd/powerplay: add some display/powerplay interfaces
+    
+    New interfaces needed to handle the new clock trees and
+    bandwidth requirements on vega10.
+    
+    Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit e29922795f0987b0ebd109a604e77d3474b50ba6
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Mar 6 12:34:32 2017 -0500
+
+    drm/amd/powerplay: add some new structures for Vega10
+    
+    Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit dd4bdf3b35dd8c33dfc41b9917f202f6602dfa48
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Mar 1 15:49:31 2017 -0500
+
+    drm/amd/powerplay: add voltage change support through pp_table
+    
+    Disable avfs to make voltage change take effect.
+    
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 9f8df7d71e382c9afa808a08c11a990e90ac7df4
+Author: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Feb 9 14:29:01 2017 -0500
+
+    drm/amd/amdgpu: Update read_sensor calls to have size parameter (v3)
+    
+    This update allows sensors to return more than 1 value and
+    indicates to the caller how many bytes are written.
+    
+    The debugfs interface has been updated to handle reading all
+    of the values.  Simply seek to the enum value (multiplied
+    by 4) and then read as many bytes as the sensor provides.
+    
+    (v2):  Don't set size to 4 before reading GPU_POWER
+    (v3): agd: rebase
+    
+    Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit cd7b0c66ce35e8693a0018b4ce0bc59f46f97bd1
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Feb 7 16:37:48 2017 -0500
+
+    drm/amd/powerplay: change parameter type pointer from int32_t to void in read sensor
+    
+    As well as fix print format for uint32_t type.
+    
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 34bb2734d1bc3c72e4739234481c0efab0941d14
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Sep 12 16:17:44 2016 -0400
+
+    drm/amd/amdgpu: add power profile sysfs entry
+    
+    Add the sysfs entries pp_gfx_power_profile and
+    pp_compute_power_profile which give user a way to set
+    power profile through parameters minimum sclk, minimum mclk,
+    activity threshold, up hysteresis and down hysteresis only
+    when the entry power_dpm_force_performance_level is in
+    default value "auto". It is read and write. Example:
+    
+    echo 500 800 20 0 5 > /sys/class/drm/card0/device/pp_*_power_profile
+    
+    cat /sys/class/drm/card0/device/pp_*_power_profile
+    500 800 20 0 5
+    
+    Note: first parameter is sclk in MHz, second is mclk in MHz,
+    third is activity threshold in percentage, fourth is up hysteresis
+    in ms and fifth is down hysteresis in ms.
+    
+    echo set > /sys/class/drm/card0/device/pp_*_power_profile
+    To set power profile state if it exists.
+    
+    echo reset > /sys/class/drm/card0/device/pp_*_power_profile
+    To restore default state and clear previous setting.
+    
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 570272d2296ce42b7d0b4c5afa5b668100930507
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Jan 6 13:32:49 2017 +0800
+
+    drm/amdgpu: extend profiling mode.
+    
+    in profiling mode, powerplay will fix power state
+    as stable as possible.and disable gfx cg and LBPW feature.
+    
+    profile_standard: as a prerequisite, ensure power and thermal
+    sustainable, set clocks ratio as close to the highest clock
+    ratio as possible.
+    profile_min_sclk: fix mclk as profile_normal, set lowest sclk
+    profile_min_mclk: fix sclk as profile_normal, set lowest mclk
+    profile_peak: set highest sclk and mclk, power and thermal not
+    sustainable
+    profile_exit: exit profile mode. enable gfx cg/lbpw feature.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit a5b580e1193e057a7ee82eae376cbb8c5c3c2518
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Dec 29 15:30:38 2016 +0800
+
+    drm/amd/powerplay: change function name to make code more readable
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit a0aa70463e49ed9069c402d7907bba892dd8ef7f
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Dec 28 20:15:45 2016 +0800
+
+    drm/amd/powerplay: fix memory leak in smu7_hwmgr
+    
+    add pp_smu7_thermal_fini function to free related
+    data when smu7_hwmgr_fini.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 6f4dc24a88a015ca31c8dbb79f9ad3bcc34f386e
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Dec 28 19:50:58 2016 +0800
+
+    drm/amd/powerplay: not use module parameter in powerplay.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 1c86380248467b99a0d9a9f7fdd0834fa0c6c5aa
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Dec 28 19:43:23 2016 +0800
+
+    drm/amd/powerplay: refine powerplay interface.
+    
+    v2: add pp_check function to check pp_instance
+       valid.
+    
+    1. powerplay export two new interface to amdgpu,
+       amd_powerplay_create/amd_powerplay_destroy.
+    2. create pp_instance/smumgr/hwmgr/eventmgr in
+       early init, destroy them when lata_fini.
+    3. in sw_init, create and init asic private smumgr
+       data, and free them when sw_fini.
+    4. in hw_init, create and init asic private hwmgr
+       data, and free them when hw_fini.
+    5. export powerplay state: PP_DPM_DISABLED.
+       when user disabled powerplay or hwmgr/eventmgr
+       init failed, powerplay return this state to amdgpu.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 167112bff8a753f0b1e5f649a3dfb48246bc6afe
+Author: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Dec 14 16:26:54 2016 +0800
+
+    drm/amd/powerplay: add callbacks to move smc firmware request into sw_init phase
+    
+    Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit cf54d6d9f811a2776c26f149752faa4a05bd2510
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Nov 2 13:18:54 2016 +0800
+
+    drm/amd/powerplay: add mask bit for fan control mode.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 55ff54837845ddb5387e70b0ae1231e499b85c69
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Nov 2 13:24:02 2016 +0800
+
+    drm/amd/powerplay: use mask bit for deepsleep/power tune feature.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 53b963b603d7839556ea51cbb1db755882796e95
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Oct 27 17:48:49 2016 +0800
+
+    drm/amd/powerplay: add new bit mask to ctrl clock stretch feature.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 0d8de7ca0b01332c404d3b5877db89727618c3d0
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Oct 12 15:13:29 2016 +0800
+
+    drm/amdgpu: use same vce state definition in dpm and powerplay
+    
+    Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 3de4ec57271a1979b5d960d8610939fff7dc38f9
+Author: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Sep 19 12:48:52 2016 -0400
+
+    drm/amd/powerplay:  Replace per-asic print_performance with generic
+    
+    Replace per-asic print_current_performance() functions with generic
+    that calls read_sensor.  Tested on Tonga and Carrizo for aesthetics
+    and accuracy.
+    
+    Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit a6e3695221446cf825d12db9c6ad3502c45fb9de
+Author: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Sep 15 10:07:34 2016 -0400
+
+    drm/amd/powerplay: Add read_sensor() callback to hwmgr (v3)
+    
+    Provides standardized interface to read various sensors.
+    The API is extensible (by adding to the end of the
+    amd_pp_sensors enumeration list.
+    
+    Support has been added to Carrizo/smu7
+    
+    (v2) Squashed the two sensor patches into one.
+    (v3) Updated to apply to smu7_hwmgr instead
+    
+    Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 4be051aeb3964146d3922238fff0ed1e4a9656d1
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Sep 6 16:41:44 2016 +0800
+
+    drm/amd/powerplay: use smu7 hwmgr to manager polaris10/11
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit b1c8e1e21f421653971c18fdafa22f2553899ca9
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Aug 24 11:28:41 2016 +0800
+
+    drm/amd/powerplay: add pp_table_version in hwmgr.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 41698abb4d418b83b4d9fdae1172e00b91e46b54
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Aug 11 17:56:56 2016 +0800
+
+    drm/amd/powerplay: delete duplicated function and definition.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 026c881046a352c9ac4f68bb84a5f6c9bc4a7d73
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Aug 16 21:38:19 2016 +0800
+
+    drm/amd/powerplay: wrap get evv voltage functions
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 8bea2527faa13dad21e4307af77b292a8e4ded2f
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Sep 12 15:17:37 2016 +0800
+
+    drm/amd/powerplay: add helper function to get voltage id in votage table
+    
+    Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 9597f40365760873bf7fc399bb5c40c3d9949359
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Sep 6 16:35:01 2016 +0800
+
+    drm/amd/powerplay: initialize platform caps in hwmgr_init.
+    
+    Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 6429fb6685d72356cfacbbdb748c977d2e63a709
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Aug 16 18:13:57 2016 +0800
+
+    drm/amd/powerplay: add feature flags in hwmgr to enable/disable special features.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 48d7b759a8bc96054b59fc07098e05dcca0c93bb
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Aug 31 17:27:11 2016 +0800
+
+    drm/amd/powerplay: add vce state tables initialize for ppt v1.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 791a57db3e5eda12e30a5f496c84c1a9e20e8c0c
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Aug 31 17:25:49 2016 +0800
+
+    drm/amd/powerplay: refine struct name for code style reason.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 075f101ceec0446b4a651ae4a22d4de11b7e7cd6
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Aug 22 20:47:28 2016 +0800
+
+    drm/amd/powerplay: simplify struct amd_pp_init.
+    
+    delete the members not needed when amd_powerplay_init.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 08bd8b9f6f11e5b4f13580805ef3a38848e7fed7
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Jul 29 16:30:04 2016 +0800
+
+    drm/amd/powerplay: delete useless code in hwmgr.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit af223dfaf0d93e7a0ed75bed4f69e5db198b741e
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Jul 28 16:51:47 2016 +0800
+
+    drm/amdgpu: add module parameters to ctrl powerplay feature
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 5e580523d9128a4d8364fe89d36c38fc7819c8dd
+Merge: c11dea5 523d939
+Author: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+Date:   Tue Jul 26 17:26:29 2016 +1000
+
+    Backmerge tag 'v4.7' into drm-next
+    
+    Linux 4.7
+    
+    As requested by Daniel Vetter as the conflicts were getting messy.
+
+commit e8c1fe9f503bf2a6de9e752c33634cea5fc5e782
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Jun 13 14:31:27 2016 -0400
+
+    drm/amd/powerplay: remove useless pp_table codes for Tonga/Fiji/Polaris10
+    
+    Due to uploading pptable implementation changed, the generic codes in
+    previous commit have been used intead of the Asic specific codes.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 4dcf9e6f2e33fe33ee6da247682b345cf8aa9a84
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Jun 1 17:08:07 2016 -0400
+
+    drm/amd/powerplay: add uploading pptable and resetting powerplay support
+    
+    Necessary for re-initializing dpm with new pptables at runtime.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 80597521e61e2dc08586bccf8b6efec982530ade
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue May 31 17:31:12 2016 -0400
+
+    drm/amd/powerplay: add event task of disable dynamic state management
+    
+    Add an interface to disable dpm so that we can disable dpm before
+    updating pptables at runtime.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit f2bdc05f773ea68d31e2d50b9e791b7c7dcd1dfa
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue May 24 15:11:17 2016 -0400
+
+    drm/amdgpu: add the common code to support mclk OD
+    
+    This implements mclk OverDrive(OD) through sysfs.
+    The new entry pp_mclk_od is read/write. The value of input/output
+    is an integer of the overclocking percentage.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 6bb6b2972d0affe1f86881d64c787627b916c17e
+Author: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue May 24 13:47:05 2016 +0800
+
+    drm/amdgpu: add powercontainment module parameter
+    
+    This patch makes powercontainment feature configurable. Currently, the
+    powercontainment is not very stable, so add a module parameter to
+    enable/disable it via user mode.
+    
+    Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 428bafa86c99f1888254aec63bbcb1a2001e8770
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu May 12 14:51:21 2016 -0400
+
+    drm/amdgpu: add powerplay sclk OD support through sysfs (v2)
+    
+    Add a new sysfs entry pp_sclk_od to support sclk overdrive(OD) overclocking,
+    the entry is read/write, the value of input/output is an integer which is the
+    over percentage of the highest sclk.
+    
+    v2: drop extra semicolon
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 83a7af6dcfd2d84066c6d19bf2bd837f7be4a5ca
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Jun 23 11:05:00 2016 +0800
+
+    drm/amd/powerplay: disable FFC.
+    
+    SMC need use VBI signal for MCLK switching
+    Send 2 x frame time as vbi timeout
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 8b41e7a03a306d93276f91c1dae39dc51a1af58d
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue May 10 15:37:00 2016 +0800
+
+    drm/amd/powerplay: move asic unrelated function to hwmgr.c.
+    
+    It's generic and used by multiple asics.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit edf600dac65eecb6c8bcf21fa986db30ee21a2ac
+Author: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue May 3 15:54:54 2016 +0200
+
+    drm/amd: cleanup remaining spaces and tabs v2
+    
+    This is the result of running the following commands:
+    find drivers/gpu/drm/amd/ -name "*.h" -exec sed -i 's/[ \t]\+$//' {} \;
+    find drivers/gpu/drm/amd/ -name "*.c" -exec sed -i 's/[ \t]\+$//' {} \;
+    find drivers/gpu/drm/amd/ -name "*.h" -exec sed -i 's/ \+\t/\t/' {} \;
+    find drivers/gpu/drm/amd/ -name "*.c" -exec sed -i 's/ \+\t/\t/' {} \;
+    
+    v2: drop changes to DAL and internal headers
+    
+    Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 1551019523a01f477888835b9ed363d3a2e73d7b
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Apr 15 15:02:54 2016 -0400
+
+    drm/amd/powerplay: revise caching the soft pptable and add it's size
+    
+    This fixes a bug in the pptable access interface that could lead to
+    a crash.  Check the pointer before using it.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 5632708f4452eb9afb985b245b98dac9a5feeac2
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Apr 12 14:57:23 2016 -0400
+
+    drm/amd/powerplay: add dpm force multiple levels on cz/tonga/fiji/polaris (v2)
+    
+    Allows you to force multiple levels rather than just one via the new
+    sysfs interrface.
+    
+    v2: squash in:
+    drm/amd/powerplay: ensure clock level set by user is valid.
+    From Rex.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 65f85e7d8216afe458e7d798ad12e7a82a55162f
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Feb 11 15:54:45 2016 -0500
+
+    drm/amd/powerplay: add GFX per cu powergating support through SMU/powerplay
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit e90b62277b17207fa3854c4d8c3763d9974e7f47
+Author: Nils Wallménius <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+Date:   Sun Apr 10 16:30:03 2016 +0200
+
+    drm/amd/powerplay: mark phm_master_table_* structs as const
+    
+    Also adjust phm_construct_table to take a const pointer
+    
+    Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Nils Wallménius <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit e273b041174c70aa2c7fd4c279596a07c21b8f16
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Dec 7 18:44:23 2015 +0800
+
+    drm/amd/powerplay: export interface to DAL.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 47329134ae7b16cba16a5501fb7685320da08878
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Dec 10 16:49:50 2015 +0800
+
+    drm/amd/powerplay: change struct name.
+    
+    amd_pp_dal_clock_info to amd_pp_simple_clock_info.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit f3898ea12fc1f18a4fa9034b169076e8e72d122a
+Author: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Dec 11 16:24:34 2015 -0500
+
+    drm/amd/powerplay: add some sysfs interfaces for powerplay.
+    
+    The new sysfs interfaces:
+    pp_num_states: Read-only, return the number of all pp states, 0 if powerplay is not available.
+    pp_cur_state: Read-only, return the index number of current pp state.
+    pp_force_state: Read-write, to write a power state index will switch to selected state forcedly and
+    		enable forced state mode, disable forced state mode. such as "echo >...".
+    pp_table: Read-write, binary output, to be used to read or write the dpm table, the maximum
+    		file size is 4KB of page size.
+    pp_dpm_sclk: Read-write, reading will return a dpm levels list, to write an index number will force
+    		powerplay to set the corresponding dpm level.
+    pp_dpm_mclk: same as sclk.
+    pp_dpm_pcie: same as sclk.
+    
+    And add new setting "manual" to the existing interface power_dpm_force_performance_level.
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit e1d32e607b5ce25a7852bef4ab4de2a80f30c546
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Dec 29 11:22:34 2015 +0800
+
+    drm/amd/powerplay: enable power down asic task. (v2)
+    
+    v2: AGD: rebase on upstream
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 14f634110fa68120ec66e24f1e423e3cc2109c9f
+Author: Eric Yang <eric.yang2-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Dec 1 13:23:07 2015 -0500
+
+    amd/powerplay: Add structures required to report configuration change
+    
+    Add required structures for amd_powerplay_display_configuration_change
+    
+    Signed-off-by: Eric Yang <eric.yang2-5C7GfCeVMHo@public.gmane.org>
+
+commit 1c9a90820beb63f75ac7dabf75533f425aadc3fa
+Author: Vitaly Prosyak <vitaly.prosyak-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Dec 3 10:27:57 2015 -0500
+
+    amd/powerplay: Fix get dal power level
+    
+    Simplify data struct for get dal power level
+    
+    Signed-off-by: Vitaly Prosyak <vitaly.prosyak-5C7GfCeVMHo@public.gmane.org>
+
+commit c4dd206be1560ebb6eef9cf2200d10a4577cef3f
+Author: Vitaly Prosyak <vitaly.prosyak-5C7GfCeVMHo@public.gmane.org>
+Date:   Mon Nov 30 16:39:53 2015 -0500
+
+    amd\powerplay Implement get dal power level
+    
+    Implement get dal power level and simple clock info
+    
+    Signed-off-by: Vitaly Prosyak <vitaly.prosyak-5C7GfCeVMHo@public.gmane.org>
+
+commit 17c00a2fed1bcc80949e0e68607bcea6af3c5358
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Dec 3 14:16:01 2015 +0800
+
+    drm/amd/powerplay: move shared function of vi to hwmgr. (v2)
+    
+    v2: agd: rebase on upstream
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+
+commit 73c9f222889986d6f0ba0708115337a0284a5b61
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Thu Nov 19 13:46:01 2015 +0800
+
+    drm/amd/powerplay: add new function point in hwmgr.
+    
+    1. for set_cpu_power_state
+    2. restore display configuration
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
+
+commit 9c0bad907413f5e3bea19d062beaab65b3dbf98f
+Author: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Nov 13 23:51:40 2015 -0500
+
+    drm/amd/powerplay: implement smc state upload for CZ
+    
+    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 09b4c872fe16d5e396de8636f5810078014dbd3f
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Nov 4 11:07:34 2015 +0800
+
+    drm/amd/powerplay: add and export hwmgr interface to eventmgr to check hw states.
+    
+    Interface between hwmgr and eventmgr.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
+
+commit c28eae26b54cb864310a4088ce4d999b66208b8c
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Oct 16 11:46:51 2015 +0800
+
+    drm/amdgpu/powerplay: add new function point in hwmgr_funcs for thermal control
+    
+    Add the interface for fan and thermal control.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit b1132013ce4c8263e1692841223ff022cf8bf18f
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Sep 30 13:28:49 2015 +0800
+
+    drm/amd/powerplay: add new function point in hwmgr_func for CG/PG.
+    
+    Add callbacks interface for clock and powergating.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit e8c7de5bf6f69e7bf3bf2d2aac64daa97e51d36c
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Fri Oct 16 14:51:09 2015 +0800
+
+    drm/amdgpu/powerplay: add function point in hwmgr_funcs for program display gap
+    
+    Displaygap support is required for proper mclk switching.
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit c82baa28184356a75c0157129f88af42b2e7b695
+Author: yanyang1 <young.yang-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Aug 18 15:28:32 2015 +0800
+
+    drm/amd/powerplay: add Tonga dpm support (v3)
+    
+    This implements DPM for tonga.  DPM handles dynamic
+    clock and voltage scaling.
+    
+    v2: merge all the patches related with tonga dpm
+    v3: merge dpm force level fix, cgs display fix, spelling fix
+    
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: yanyang1 <young.yang-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
+
+commit 28a18bab2ed6e143a4671fec12ff3feeb0dc205e
+Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+Date:   Wed Sep 23 15:14:38 2015 +0800
+
+    drm/amd/powerplay: add CG and PG support for carrizo
+    
+    This adds clock and powergating support for CZ.
+    
+    v2: squash in fixes
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
+
+commit 3bace359149391c6547cefe3bf729f365bcf3ef6
+Author: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
+Date:   Tue Jul 21 21:18:15 2015 +0800
+
+    drm/amd/powerplay: add hardware manager sub-component
+    
+    The hwmgr handles all hardware related calls, including clock/power
+    gating control, DPM, read and parse PPTable, etc.
+    
+    v5: squash in fixes
+    v4: implement acpi's atcs function use cgs interface
+    v3: fix code style error and add big-endian mode support.
+    v2: use cgs interface directly in hwmgr sub-module
+    
+    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
+    Signed-off-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
+    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index bfb2c85..ae07b5d 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -2575,6 +2575,102 @@ static int polaris10_populate_requested_graphic_levels(struct pp_hwmgr *hwmgr,
 				array_size, SMC_RAM_END);
 }
 
+static int polaris10_update_dpm_settings(struct pp_hwmgr *hwmgr,
+				void *profile_setting)
+{
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct polaris10_smumgr *smu_data = (struct polaris10_smumgr *)
+			(hwmgr->smu_backend);
+	struct profile_mode_setting *setting;
+	struct SMU74_Discrete_GraphicsLevel *levels =
+			smu_data->smc_state_table.GraphicsLevel;
+	uint32_t array = smu_data->smu7_data.dpm_table_start +
+			offsetof(SMU74_Discrete_DpmTable, GraphicsLevel);
+
+	uint32_t mclk_array = smu_data->smu7_data.dpm_table_start +
+			offsetof(SMU74_Discrete_DpmTable, MemoryLevel);
+	struct SMU74_Discrete_MemoryLevel *mclk_levels =
+			smu_data->smc_state_table.MemoryLevel;
+	uint32_t i;
+	uint32_t offset, up_hyst_offset, down_hyst_offset, clk_activity_offset, tmp;
+
+	if (profile_setting == NULL)
+		return -EINVAL;
+
+	setting = (struct profile_mode_setting *)profile_setting;
+
+	if (setting->bupdate_sclk) {
+		if (!data->sclk_dpm_key_disabled)
+			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_SCLKDPM_FreezeLevel);
+		for (i = 0; i < smu_data->smc_state_table.GraphicsDpmLevelCount; i++) {
+			if (levels[i].ActivityLevel !=
+				cpu_to_be16(setting->sclk_activity)) {
+				levels[i].ActivityLevel = cpu_to_be16(setting->sclk_activity);
+
+				clk_activity_offset = array + (sizeof(SMU74_Discrete_GraphicsLevel) * i)
+						+ offsetof(SMU74_Discrete_GraphicsLevel, ActivityLevel);
+				offset = clk_activity_offset & ~0x3;
+				tmp = PP_HOST_TO_SMC_UL(cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, offset));
+				tmp = phm_set_field_to_u32(clk_activity_offset, tmp, levels[i].ActivityLevel, sizeof(uint16_t));
+				cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, offset, PP_HOST_TO_SMC_UL(tmp));
+
+			}
+			if (levels[i].UpHyst != setting->sclk_up_hyst ||
+				levels[i].DownHyst != setting->sclk_down_hyst) {
+				levels[i].UpHyst = setting->sclk_up_hyst;
+				levels[i].DownHyst = setting->sclk_down_hyst;
+				up_hyst_offset = array + (sizeof(SMU74_Discrete_GraphicsLevel) * i)
+						+ offsetof(SMU74_Discrete_GraphicsLevel, UpHyst);
+				down_hyst_offset = array + (sizeof(SMU74_Discrete_GraphicsLevel) * i)
+						+ offsetof(SMU74_Discrete_GraphicsLevel, DownHyst);
+				offset = up_hyst_offset & ~0x3;
+				tmp = PP_HOST_TO_SMC_UL(cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, offset));
+				tmp = phm_set_field_to_u32(up_hyst_offset, tmp, levels[i].UpHyst, sizeof(uint8_t));
+				tmp = phm_set_field_to_u32(down_hyst_offset, tmp, levels[i].DownHyst, sizeof(uint8_t));
+				cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, offset, PP_HOST_TO_SMC_UL(tmp));
+			}
+		}
+		if (!data->sclk_dpm_key_disabled)
+			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_SCLKDPM_UnfreezeLevel);
+	}
+
+	if (setting->bupdate_mclk) {
+		if (!data->mclk_dpm_key_disabled)
+			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_MCLKDPM_FreezeLevel);
+		for (i = 0; i < smu_data->smc_state_table.MemoryDpmLevelCount; i++) {
+			if (mclk_levels[i].ActivityLevel !=
+				cpu_to_be16(setting->mclk_activity)) {
+				mclk_levels[i].ActivityLevel = cpu_to_be16(setting->mclk_activity);
+
+				clk_activity_offset = mclk_array + (sizeof(SMU74_Discrete_MemoryLevel) * i)
+						+ offsetof(SMU74_Discrete_MemoryLevel, ActivityLevel);
+				offset = clk_activity_offset & ~0x3;
+				tmp = PP_HOST_TO_SMC_UL(cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, offset));
+				tmp = phm_set_field_to_u32(clk_activity_offset, tmp, mclk_levels[i].ActivityLevel, sizeof(uint16_t));
+				cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, offset, PP_HOST_TO_SMC_UL(tmp));
+
+			}
+			if (mclk_levels[i].UpHyst != setting->mclk_up_hyst ||
+				mclk_levels[i].DownHyst != setting->mclk_down_hyst) {
+				mclk_levels[i].UpHyst = setting->mclk_up_hyst;
+				mclk_levels[i].DownHyst = setting->mclk_down_hyst;
+				up_hyst_offset = mclk_array + (sizeof(SMU74_Discrete_MemoryLevel) * i)
+						+ offsetof(SMU74_Discrete_MemoryLevel, UpHyst);
+				down_hyst_offset = mclk_array + (sizeof(SMU74_Discrete_MemoryLevel) * i)
+						+ offsetof(SMU74_Discrete_MemoryLevel, DownHyst);
+				offset = up_hyst_offset & ~0x3;
+				tmp = PP_HOST_TO_SMC_UL(cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, offset));
+				tmp = phm_set_field_to_u32(up_hyst_offset, tmp, mclk_levels[i].UpHyst, sizeof(uint8_t));
+				tmp = phm_set_field_to_u32(down_hyst_offset, tmp, mclk_levels[i].DownHyst, sizeof(uint8_t));
+				cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, offset, PP_HOST_TO_SMC_UL(tmp));
+			}
+		}
+		if (!data->mclk_dpm_key_disabled)
+			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_MCLKDPM_UnfreezeLevel);
+	}
+	return 0;
+}
+
 const struct pp_smumgr_func polaris10_smu_funcs = {
 	.smu_init = polaris10_smu_init,
 	.smu_fini = smu7_smu_fini,
@@ -2599,4 +2695,5 @@ static int polaris10_populate_requested_graphic_levels(struct pp_hwmgr *hwmgr,
 	.is_dpm_running = polaris10_is_dpm_running,
 	.populate_requested_graphic_levels = polaris10_populate_requested_graphic_levels,
 	.is_hw_avfs_present = polaris10_is_hw_avfs_present,
+	.update_dpm_settings = polaris10_update_dpm_settings,
 };
-- 
1.9.1


--===============1641103388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1641103388==--

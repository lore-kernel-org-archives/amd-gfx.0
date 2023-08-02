Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BD3C04A6A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A5210E507;
	Wed,  2 Aug 2023 07:20:19 +0000 (UTC)
Received: from out28-128.mail.aliyun.com (out28-128.mail.aliyun.com
 [115.124.28.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CB610E1E5;
 Wed,  2 Aug 2023 02:09:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07440748|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.0531706-0.0119323-0.934897;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047192; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6LRrkh_1690942184; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6LRrkh_1690942184) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 10:09:45 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drivers/amd/pm: Clean up errors in smu8_smumgr.h
Date: Wed,  2 Aug 2023 02:09:43 +0000
Message-Id: <20230802020943.9322-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 02 Aug 2023 07:20:04 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 48 ++++++++--------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 36c831b280ed..5d28c951a319 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -191,8 +191,7 @@ static void sumo_construct_vid_mapping_table(struct amdgpu_device *adev,
 }
 
 #if 0
-static const struct kv_lcac_config_values sx_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values sx_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{  1,       4,        1    },
 	{  2,       5,        1    },
@@ -204,32 +203,27 @@ static const struct kv_lcac_config_values sx_local_cac_cfg_kv[] =
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_values mc0_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values mc0_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_values mc1_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values mc1_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_values mc2_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values mc2_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_values mc3_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values mc3_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_values cpl_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values cpl_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{  1,       4,        1    },
 	{  2,       5,        1    },
@@ -260,39 +254,32 @@ static const struct kv_lcac_config_values cpl_local_cac_cfg_kv[] =
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_reg sx0_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg sx0_cac_config_reg[] = {
 	{ 0xc0400d00, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 
-static const struct kv_lcac_config_reg mc0_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg mc0_cac_config_reg[] = {
 	{ 0xc0400d30, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 
-static const struct kv_lcac_config_reg mc1_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg mc1_cac_config_reg[] = {
 	{ 0xc0400d3c, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 
-static const struct kv_lcac_config_reg mc2_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg mc2_cac_config_reg[] = {
 	{ 0xc0400d48, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 
-static const struct kv_lcac_config_reg mc3_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg mc3_cac_config_reg[] = {
 	{ 0xc0400d54, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 
-static const struct kv_lcac_config_reg cpl_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg cpl_cac_config_reg[] = {
 	{ 0xc0400d80, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 #endif
 
-static const struct kv_pt_config_reg didt_config_kv[] =
-{
+static const struct kv_pt_config_reg didt_config_kv[] = {
 	{ 0x10, 0x000000ff, 0, 0x0, KV_CONFIGREG_DIDT_IND },
 	{ 0x10, 0x0000ff00, 8, 0x0, KV_CONFIGREG_DIDT_IND },
 	{ 0x10, 0x00ff0000, 16, 0x0, KV_CONFIGREG_DIDT_IND },
@@ -1173,9 +1160,9 @@ static void kv_calculate_dfs_bypass_settings(struct amdgpu_device *adev)
 					pi->graphics_level[i].ClkBypassCntl = 2;
 				else if (kv_get_clock_difference(table->entries[i].clk, 26600) < 200)
 					pi->graphics_level[i].ClkBypassCntl = 7;
-				else if (kv_get_clock_difference(table->entries[i].clk , 20000) < 200)
+				else if (kv_get_clock_difference(table->entries[i].clk, 20000) < 200)
 					pi->graphics_level[i].ClkBypassCntl = 6;
-				else if (kv_get_clock_difference(table->entries[i].clk , 10000) < 200)
+				else if (kv_get_clock_difference(table->entries[i].clk, 10000) < 200)
 					pi->graphics_level[i].ClkBypassCntl = 8;
 				else
 					pi->graphics_level[i].ClkBypassCntl = 0;
@@ -1825,7 +1812,7 @@ static void kv_set_valid_clock_range(struct amdgpu_device *adev,
 			if ((new_ps->levels[0].sclk -
 			     table->entries[pi->highest_valid].sclk_frequency) >
 			    (table->entries[pi->lowest_valid].sclk_frequency -
-			     new_ps->levels[new_ps->num_levels -1].sclk))
+			     new_ps->levels[new_ps->num_levels - 1].sclk))
 				pi->highest_valid = pi->lowest_valid;
 			else
 				pi->lowest_valid =  pi->highest_valid;
@@ -3333,8 +3320,7 @@ static const struct amd_ip_funcs kv_dpm_ip_funcs = {
 	.set_powergating_state = kv_dpm_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version kv_smu_ip_block =
-{
+const struct amdgpu_ip_block_version kv_smu_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_SMC,
 	.major = 1,
 	.minor = 0,
-- 
2.17.1


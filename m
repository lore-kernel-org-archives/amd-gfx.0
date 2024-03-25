Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AC9C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95BC510E70A;
	Mon, 25 Mar 2024 10:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wtS6gXsB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C999C10E70A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 10:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGxc9E8mICKguphOej9kJGC0Op9yG7SufrxWzf3Pw7mwk34pR3Rrathk4wnfuY/BzUbJAsEqAn75ecWittlADRiSXX2ohJebEb8hGxp091hYMOYAfviy1B2dEBRmwps2pkP265RW9BcXFLS7dGblo06T6TDrgg4KmV20yKrXSVoCe487TvJVlBQRR8z64mMQIBGoDd3U569aZ7lP6J0D2hmvLxrauVMuKQwgJMt73jsJJNDvggRvQHk73WwXAYH9A/9AooKatGh1u1qWJ95c3ctLvglFPjV6+LNtBvOt/veb2z9G8yn0kyhb8m091fjt89R+eS+jjMs2+4EWIz1ubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4+qMwOHEhucO3IvK7DdlGZ1ecoO26fm66yUAwLt01Y=;
 b=lm+2PQDmBzQtVXPbiEDCSzvB1crr5St8YJBwLi880FXM20MhYbtLM+YnXgx8wG2TsnxEg90kD5egttRFPiy1Jw742cCLcKQUcNyqZIVVmKh9pRgLSJQLUbkZTni5MvSjdYkGJ5R8pYMY9eEfCmv1SV1DxeTGer+OFBblPyXVMp3bkdYnypPIuwR5d6/L7+YCKxKle5Dvd/NOFZd5k9RnNWUEBYTGE+YWaLtstrzp6ZysK0wf1OQlehFCiawTadWK/xepaUyMH6IGK+1T5X3CCKcCkzATR+ZK8MVk/Aaz68mBUgS6XfFRthg/37UPCLIHIRmf5i2kjUhyZ/JaY1MgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4+qMwOHEhucO3IvK7DdlGZ1ecoO26fm66yUAwLt01Y=;
 b=wtS6gXsBz0I+M44gFKoxgicrKt+nllgFueEOVbMWQqMSWh+ZQH9litX4Dtp4kQe8qdKsLc7Bvkdkhbjakn1G2MYJ5kFwgvuiiDtH9qD/MMq2nlD0sYr3IzmlJOfe7bVKIVclReqetHQIKrGqfK07LRVCXo9ngJ3fMRtQpYvlVuE=
Received: from BYAPR06CA0022.namprd06.prod.outlook.com (2603:10b6:a03:d4::35)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Mon, 25 Mar
 2024 10:16:27 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::aa) by BYAPR06CA0022.outlook.office365.com
 (2603:10b6:a03:d4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 10:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 10:16:25 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 05:16:23 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/pm: Change the member function name of
 pp_hwmgr_func
Date: Mon, 25 Mar 2024 18:15:56 +0800
Message-ID: <20240325101559.2807629-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325101559.2807629-1-Jun.Ma2@amd.com>
References: <20240325101559.2807629-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b9ef62-21aa-4cb7-67b9-08dc4cb4a12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+VtdpxZDqvvzve7O78Y0IEwBp0+zi/sXDC9xBzxEEIVy1l619BVCe6Q+IUAl76AZ3GpROGVp1UrC7kJQ8HyAXN/JX3/rs8ixi1nW7SEAFREVX2exwySzZSYNvqzQz8YoO5pjXVRFT4jgtZBcIRtNl2C8RMwryS6zFAikRIn+7viuZRj8ALpU8pvV2rH4mgwPjWr6P3J5iiXLak6itCB9Yp3b+dVBxe8vBifYUGDRgWrSG4a70JPgGHI0fXM5sGJwX4gHpGt6rW+I2aROHDAlQPvia1cZf/edWuJEfQJKSPXQB7YqFpUtvBB11erhY2ANdxDXgmYQz6rNmK4z+zLDAzh3fI5hy3PlmJEf3pzIrFFYa2Ca1I8uQpfZ9mZFnG7lhDS8Ht1R9061VWzMHSqfrC8cRnOCe3jBsqc+BTqDpjIWPJi0fISzmHKmhFTR6yMWxeg/WtTLLweLek5rwdJLhtnmZp4SmYD2dilNa/gB2B1twk7BbVhEnz9EZ5lZzZHpR5ESZDvdL9s0MmJpQWbbEx5B08J52x6e+8MrQj+HrkhTTertprkZmrOrkDr14GT3lPTRQzMGFHV6HA1WUPwLLiJHK8NHlxtiqeyukp16yqswYmk+rLe3JcxgKljJiOrKDBr3ZS+lX6rIHseY94bGk/GE8HRM6RrjkB5byLX0U+VVWaSylVmHPshg+CYwv7XWUsoFa8dr5WIb9TdxpwYK49eBDkWJ8kFoCI49OSVnRrFqsIEi7LtbwJKhMSFw3eH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 10:16:25.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b9ef62-21aa-4cb7-67b9-08dc4cb4a12d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change the member function name of pp_hwmgr_func to
keep consistent with the function in pptable_funcs

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c      | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c    | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h    | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c    | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h    | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c  | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h  | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h          | 2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index aed0e2cefbf9..fafd4e0b7908 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1379,10 +1379,10 @@ static bool pp_get_asic_baco_capability(void *handle)
 		return false;
 
 	if (!(hwmgr->not_vf && amdgpu_dpm) ||
-		!hwmgr->hwmgr_func->get_asic_baco_capability)
+		!hwmgr->hwmgr_func->baco_is_support)
 		return false;
 
-	return hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr);
+	return hwmgr->hwmgr_func->baco_is_support(hwmgr);
 }
 
 static int pp_get_asic_baco_state(void *handle, int *state)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
index e8a9471c1898..1ab4fbfe0cde 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
@@ -33,7 +33,7 @@
 #include "smu/smu_7_1_2_d.h"
 #include "smu/smu_7_1_2_sh_mask.h"
 
-bool smu7_baco_get_capability(struct pp_hwmgr *hwmgr)
+bool smu7_baco_is_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
index 73a773f4ce2e..df142c2eec8e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool smu7_baco_get_capability(struct pp_hwmgr *hwmgr);
+extern bool smu7_baco_is_support(struct pp_hwmgr *hwmgr);
 extern int smu7_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int smu7_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index aa91730e4eaf..ae7032d43169 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5791,7 +5791,7 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
 	.get_power_profile_mode = smu7_get_power_profile_mode,
 	.set_power_profile_mode = smu7_set_power_profile_mode,
 	.get_performance_level = smu7_get_performance_level,
-	.get_asic_baco_capability = smu7_baco_get_capability,
+	.baco_is_support = smu7_baco_is_support,
 	.get_asic_baco_state = smu7_baco_get_state,
 	.set_asic_baco_state = smu7_baco_set_state,
 	.power_off_asic = smu7_power_off_asic,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
index c66ef9741535..687cd80ebad8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
@@ -28,7 +28,7 @@
 #include "vega10_inc.h"
 #include "smu9_baco.h"
 
-bool smu9_baco_get_capability(struct pp_hwmgr *hwmgr)
+bool smu9_baco_is_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg, data;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
index 9ff7c2ea1b58..24461f1e3b01 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool smu9_baco_get_capability(struct pp_hwmgr *hwmgr);
+extern bool smu9_baco_is_support(struct pp_hwmgr *hwmgr);
 extern int smu9_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 6d6bc6a380b3..e86f27b06f23 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5756,7 +5756,7 @@ static const struct pp_hwmgr_func vega10_hwmgr_funcs = {
 	.set_power_limit = vega10_set_power_limit,
 	.odn_edit_dpm_table = vega10_odn_edit_dpm_table,
 	.get_performance_level = vega10_get_performance_level,
-	.get_asic_baco_capability = smu9_baco_get_capability,
+	.baco_is_support = smu9_baco_is_support,
 	.get_asic_baco_state = smu9_baco_get_state,
 	.set_asic_baco_state = vega10_baco_set_state,
 	.enable_mgpu_fan_boost = vega10_enable_mgpu_fan_boost,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 460067933de2..386c1d7f52d5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -2966,7 +2966,7 @@ static const struct pp_hwmgr_func vega12_hwmgr_funcs = {
 	.start_thermal_controller = vega12_start_thermal_controller,
 	.powergate_gfx = vega12_gfx_off_control,
 	.get_performance_level = vega12_get_performance_level,
-	.get_asic_baco_capability = smu9_baco_get_capability,
+	.baco_is_support = smu9_baco_is_support,
 	.get_asic_baco_state = smu9_baco_get_state,
 	.set_asic_baco_state = vega12_baco_set_state,
 	.get_ppfeature_status = vega12_get_ppfeature_status,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index dad4c80aee58..bc0ff417921b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -36,7 +36,7 @@ static const struct soc15_baco_cmd_entry clean_baco_tbl[] = {
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_7), 0, 0, 0, 0},
 };
 
-bool vega20_baco_get_capability(struct pp_hwmgr *hwmgr)
+bool vega20_baco_is_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
index bdad9c915631..006eb6633ce8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool vega20_baco_get_capability(struct pp_hwmgr *hwmgr);
+extern bool vega20_baco_is_support(struct pp_hwmgr *hwmgr);
 extern int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 extern int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 3b33af30eb0f..bfecff6afc24 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -4422,7 +4422,7 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs = {
 	.notify_cac_buffer_info = vega20_notify_cac_buffer_info,
 	.enable_mgpu_fan_boost = vega20_enable_mgpu_fan_boost,
 	/* BACO related */
-	.get_asic_baco_capability = vega20_baco_get_capability,
+	.baco_is_support = vega20_baco_is_support,
 	.get_asic_baco_state = vega20_baco_get_state,
 	.set_asic_baco_state = vega20_baco_set_state,
 	.set_mp1_state = vega20_set_mp1_state,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 6f536159df4d..83f903d8e994 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -351,7 +351,7 @@ struct pp_hwmgr_func {
 	int (*set_hard_min_fclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*set_hard_min_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*set_soft_max_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
-	bool (*get_asic_baco_capability)(struct pp_hwmgr *hwmgr);
+	bool (*baco_is_support)(struct pp_hwmgr *hwmgr);
 	int (*get_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 	int (*set_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 	int (*get_ppfeature_status)(struct pp_hwmgr *hwmgr, char *buf);
-- 
2.34.1


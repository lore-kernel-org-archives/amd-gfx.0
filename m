Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1BCC77B6D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881D210EFC8;
	Thu, 30 Mar 2023 19:27:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAB410E3BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5bU3VdJ6pomzSeEPFZCzi7zPO7eEFE7RYeV5KOiaL/tOrsPg7Ya/uV1vMA+2xCOVdeCkW9op3hJ99Ag9JZAJopY+4dAkcEWJgtCR28kUAnlIObKEISB0By5y6aI92eG7C6XUbF3Cj08rq84TYa6qgJoLBpEeIpEfAqSB8p7pDGOc+r6QN1PHPIxdmPbuVfP3hraIwtZjCFHD+BpkBulmnuz2ynwUwpFNB342ODq79JZvapbfbkyJ0AHLWOF1hFAeMrjyCldDQ5K74rCeg9LzLr+iG6IwqI4r+GKrL5NS6o3j8XqmVRtdRxWFm3ePxAoaY0s1Gshpl26v1u9KM+Peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdKb/IbUWKejhzIZZnWw38N9VxBlTy18M25O0OuSh9o=;
 b=cb5GHdTqDD6cKmoVvsfVLq01visq2v6a9ytb/O9pIMmuT5pl14o/BSNQeaV2AS7xhqBjKdA7TYTRcHB+E90wWEMecBbw5FUOr9zgGvqkLBQlVa+WTLA0DFTbvatI6wia4Ah2ARmlqqlhl42NIfJRweW8KHw2O4BxY+h/lxr+Ch30xqvpgVD1spPZ3euOMdIS3svhpSGL5zywkZ7X0f8log9YQpAw5Xpt+e+rmOh/WHpmYD0cy2EErkj+N5nQUOj1je+42e01YHyvbUAnr/TtGYz0Qe1v2wCXfmqqtJyyBCoZnMAcbG/MKfWi67j+PyW0Mx8E/uPTvbzKmkBEREyJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdKb/IbUWKejhzIZZnWw38N9VxBlTy18M25O0OuSh9o=;
 b=a4Q+3lguB8UjZrKaupZXP8Ta3V9/zCl1wLqyBkn9HfRZtenCKgJym99oxAjXKN43lWjXLlue9h2jkY2sFJmly3ynz/DZheyxFUli5TN5TOPkv+GzI6dTpHSC+/4yAWNyU2wFuU/VREyX6hTkyS2iFZov9UY5y2FnR3ZPm8tWuLs=
Received: from BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:27:15 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::c1) by BN8PR12CA0012.outlook.office365.com
 (2603:10b6:408:60::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 19:27:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:27:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 9/9] drm/amdgpu: Rename xcc specific functions
Date: Thu, 30 Mar 2023 15:26:57 -0400
Message-ID: <20230330192657.1134433-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330192657.1134433-1-alexander.deucher@amd.com>
References: <20230330192657.1134433-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: cefce650-1f26-447b-132a-08db3154c4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: al5qZruUWIRNt7CmjICttGtILCYoUwRQZna8vARMDxj441S9hA5yMhzO86MnjBMAw2Y7DBDFSt0oxqQwWUO4nRuVR2KB4ufGvVNWAprLjtKuHfdS+Mo6tjnVlgO9j0L8fQ5yuOYQdM2KHNl4ighfPI7diqJn4hBxYXnerHxKZ3xu+lpJTZXKN9FeLyOl4USvBATPkm25CTsSe2+rQ1BFpUKL8EFEbPJAGReGOohwld9nFCmcvUie9x9hHbO39PnOJYO2TQTOSCWgozlGcp2rLyhWIr9EoK72ZjvLSF/a+8876rEs9fZ5A4EbMDZRFB59hKkyGpOOlyowP2r3gVsX9VoCf4QhWufPbziRcJE+9J248dwvmiQFVTrZJQfV55Abnay2kQypue2Ai5SHt+OjDNlMCNa4Oh1g25FotM9GgRTdd+AJcQ0I34GbnjgrS6DmwGfU5EbsAkvvLBMsHmUndkQUkOGOyvArX9BvIDmA0oMk+oDeSlw3KCBxiWSU86vwwIjOpeOuIUjv0heREvGqBWTxL/hJoeQpkDZQOCDEIDil8IADx12i2M15LjXhDxR4cvD+23yOkako2vuxZkWHqq+7avJAwcr8ywHEohfCtVjPpu0Pflc+H3IB5fyvT7G/+m/J/mIpmf92XVkfV9mOPSNxYkvunD4k+un+V/lKb9ChoKeOgpoIM06YaWHQ3r5mNYSEXSKTC+8cxA5u0Znc5Iuk0KZW30GBSoUh/2DVFUM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(30864003)(83380400001)(2616005)(426003)(336012)(26005)(1076003)(40480700001)(81166007)(186003)(47076005)(16526019)(82310400005)(86362001)(356005)(82740400003)(8676002)(36756003)(478600001)(36860700001)(8936002)(6666004)(4326008)(7696005)(54906003)(5660300002)(70206006)(41300700001)(70586007)(40460700003)(6916009)(316002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:27:15.3564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cefce650-1f26-447b-132a-08db3154c4ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add 'xcc' prefix to xcc specific functions to distinguish from IP block
functions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 205 +++++++++++++-----------
 1 file changed, 113 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 4450377adfa4..a54411ddc17c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -511,11 +511,8 @@ static int gfx_v9_4_3_mec_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v9_4_3_select_se_sh(struct amdgpu_device *adev,
-				    u32 se_num,
-				    u32 sh_num,
-				    u32 instance,
-				    int xcc_id)
+static void gfx_v9_4_3_xcc_select_se_sh(struct amdgpu_device *adev, u32 se_num,
+					u32 sh_num, u32 instance, int xcc_id)
 {
 	u32 data;
 
@@ -683,7 +680,7 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 
 static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
         .get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
-        .select_se_sh = &gfx_v9_4_3_select_se_sh,
+	.select_se_sh = &gfx_v9_4_3_xcc_select_se_sh,
         .read_wave_data = &gfx_v9_4_3_read_wave_data,
         .read_wave_sgprs = &gfx_v9_4_3_read_wave_sgprs,
         .read_wave_vgprs = &gfx_v9_4_3_read_wave_vgprs,
@@ -906,7 +903,8 @@ static int gfx_v9_4_3_sw_fini(void *handle)
 }
 
 #define DEFAULT_SH_MEM_BASES	(0x6000)
-static void gfx_v9_4_3_init_compute_vmid(struct amdgpu_device *adev, int xcc_id)
+static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
+					     int xcc_id)
 {
 	int i;
 	uint32_t sh_mem_config;
@@ -944,7 +942,7 @@ static void gfx_v9_4_3_init_compute_vmid(struct amdgpu_device *adev, int xcc_id)
 	}
 }
 
-static void gfx_v9_4_3_init_gds_vmid(struct amdgpu_device *adev, int xcc_id)
+static void gfx_v9_4_3_xcc_init_gds_vmid(struct amdgpu_device *adev, int xcc_id)
 {
 	int vmid;
 
@@ -1005,25 +1003,26 @@ static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 	mutex_unlock(&adev->srbm_mutex);
 
 	for (i = 0; i < num_xcc; i++) {
-		gfx_v9_4_3_init_compute_vmid(adev, i);
-		gfx_v9_4_3_init_gds_vmid(adev, i);
+		gfx_v9_4_3_xcc_init_compute_vmid(adev, i);
+		gfx_v9_4_3_xcc_init_gds_vmid(adev, i);
 	}
 }
 
-static void gfx_v9_4_3_enable_save_restore_machine(struct amdgpu_device *adev,
-						   int xcc_id)
+static void
+gfx_v9_4_3_xcc_enable_save_restore_machine(struct amdgpu_device *adev,
+					   int xcc_id)
 {
 	WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id), RLC_SRM_CNTL, SRM_ENABLE, 1);
 }
 
-static void gfx_v9_4_3_init_pg(struct amdgpu_device *adev, int xcc_id)
+static void gfx_v9_4_3_xcc_init_pg(struct amdgpu_device *adev, int xcc_id)
 {
 	/*
 	 * Rlc save restore list is workable since v2_1.
 	 * And it's needed by gfxoff feature.
 	 */
 	if (adev->gfx.rlc.is_rlc_v2_1)
-		gfx_v9_4_3_enable_save_restore_machine(adev, xcc_id);
+		gfx_v9_4_3_xcc_enable_save_restore_machine(adev, xcc_id);
 
 	if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_PG |
 			      AMD_PG_SUPPORT_GFX_SMG |
@@ -1036,7 +1035,7 @@ static void gfx_v9_4_3_init_pg(struct amdgpu_device *adev, int xcc_id)
 	}
 }
 
-void gfx_v9_4_3_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
+void gfx_v9_4_3_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 
@@ -1045,7 +1044,8 @@ void gfx_v9_4_3_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCPC_PSP_DEBUG, data);
 }
 
-static void gfx_v9_4_3_program_xcc_id(struct amdgpu_device *adev, int xcc_id)
+static void gfx_v9_4_3_xcc_program_xcc_id(struct amdgpu_device *adev,
+					  int xcc_id)
 {
 	uint32_t tmp = 0;
 	int num_xcc;
@@ -1079,7 +1079,7 @@ static bool gfx_v9_4_3_is_rlc_enabled(struct amdgpu_device *adev)
 	return true;
 }
 
-static void gfx_v9_4_3_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
+static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 	unsigned i;
@@ -1096,7 +1096,8 @@ static void gfx_v9_4_3_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
 	}
 }
 
-static void gfx_v9_4_3_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
+static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev,
+					   int xcc_id)
 {
 	uint32_t data;
 
@@ -1113,8 +1114,8 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev,
-					   int xcc_id)
+static void gfx_v9_4_3_xcc_wait_for_rlc_serdes(struct amdgpu_device *adev,
+					       int xcc_id)
 {
 	u32 i, j, k;
 	u32 mask;
@@ -1122,16 +1123,17 @@ static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev,
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v9_4_3_select_se_sh(adev, i, j, 0xffffffff, xcc_id);
+			gfx_v9_4_3_xcc_select_se_sh(adev, i, j, 0xffffffff,
+						    xcc_id);
 			for (k = 0; k < adev->usec_timeout; k++) {
 				if (RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SERDES_CU_MASTER_BUSY) == 0)
 					break;
 				udelay(1);
 			}
 			if (k == adev->usec_timeout) {
-				gfx_v9_4_3_select_se_sh(adev, 0xffffffff,
-							0xffffffff, 0xffffffff,
-							xcc_id);
+				gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff,
+							    0xffffffff,
+							    0xffffffff, xcc_id);
 				mutex_unlock(&adev->grbm_idx_mutex);
 				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
 					 i, j);
@@ -1139,7 +1141,8 @@ static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev,
 			}
 		}
 	}
-	gfx_v9_4_3_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, xcc_id);
+	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
+				    xcc_id);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	mask = RLC_SERDES_NONCU_MASTER_BUSY__SE_MASTER_BUSY_MASK |
@@ -1153,8 +1156,8 @@ static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev,
 	}
 }
 
-static void gfx_v9_4_3_enable_gui_idle_interrupt(struct amdgpu_device *adev,
-						 bool enable, int xcc_id)
+static void gfx_v9_4_3_xcc_enable_gui_idle_interrupt(struct amdgpu_device *adev,
+						     bool enable, int xcc_id)
 {
 	u32 tmp;
 
@@ -1176,8 +1179,8 @@ static void gfx_v9_4_3_rlc_stop(struct amdgpu_device *adev)
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), RLC_CNTL, RLC_ENABLE_F32, 0);
-		gfx_v9_4_3_enable_gui_idle_interrupt(adev, false, i);
-		gfx_v9_4_3_wait_for_rlc_serdes(adev, i);
+		gfx_v9_4_3_xcc_enable_gui_idle_interrupt(adev, false, i);
+		gfx_v9_4_3_xcc_wait_for_rlc_serdes(adev, i);
 	}
 }
 
@@ -1208,7 +1211,7 @@ static void gfx_v9_4_3_rlc_start(struct amdgpu_device *adev)
 
 		/* carrizo do enable cp interrupt after cp inited */
 		if (!(adev->flags & AMD_IS_APU)) {
-			gfx_v9_4_3_enable_gui_idle_interrupt(adev, true, i);
+			gfx_v9_4_3_xcc_enable_gui_idle_interrupt(adev, true, i);
 			udelay(50);
 		}
 
@@ -1231,7 +1234,8 @@ static void gfx_v9_4_3_rlc_start(struct amdgpu_device *adev)
 	}
 }
 
-static int gfx_v9_4_3_rlc_load_microcode(struct amdgpu_device *adev, int xcc_id)
+static int gfx_v9_4_3_xcc_rlc_load_microcode(struct amdgpu_device *adev,
+					     int xcc_id)
 {
 	const struct rlc_firmware_header_v2_0 *hdr;
 	const __le32 *fw_data;
@@ -1272,11 +1276,11 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
 		/* disable CG */
 		WREG32_SOC15(GC, GET_INST(GC, i), regRLC_CGCG_CGLS_CTRL, 0);
 
-		gfx_v9_4_3_init_pg(adev, i);
+		gfx_v9_4_3_xcc_init_pg(adev, i);
 
 		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 			/* legacy rlc firmware loading */
-			r = gfx_v9_4_3_rlc_load_microcode(adev, i);
+			r = gfx_v9_4_3_xcc_rlc_load_microcode(adev, i);
 			if (r)
 				return r;
 		}
@@ -1346,8 +1350,8 @@ static bool gfx_v9_4_3_is_rlcg_access_range(struct amdgpu_device *adev, u32 offs
 					ARRAY_SIZE(rlcg_access_gc_9_4_3));
 }
 
-static void gfx_v9_4_3_cp_compute_enable(struct amdgpu_device *adev,
-					 bool enable, int xcc_id)
+static void gfx_v9_4_3_xcc_cp_compute_enable(struct amdgpu_device *adev,
+					     bool enable, int xcc_id)
 {
 	if (enable) {
 		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, 0);
@@ -1359,8 +1363,8 @@ static void gfx_v9_4_3_cp_compute_enable(struct amdgpu_device *adev,
 	udelay(50);
 }
 
-static int gfx_v9_4_3_cp_compute_load_microcode(struct amdgpu_device *adev,
-						int xcc_id)
+static int gfx_v9_4_3_xcc_cp_compute_load_microcode(struct amdgpu_device *adev,
+						    int xcc_id)
 {
 	const struct gfx_firmware_header_v1_0 *mec_hdr;
 	const __le32 *fw_data;
@@ -1372,7 +1376,7 @@ static int gfx_v9_4_3_cp_compute_load_microcode(struct amdgpu_device *adev,
 	if (!adev->gfx.mec_fw)
 		return -EINVAL;
 
-	gfx_v9_4_3_cp_compute_enable(adev, false, xcc_id);
+	gfx_v9_4_3_xcc_cp_compute_enable(adev, false, xcc_id);
 
 	mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
 	amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
@@ -1408,7 +1412,7 @@ static int gfx_v9_4_3_cp_compute_load_microcode(struct amdgpu_device *adev,
 }
 
 /* KIQ functions */
-static void gfx_v9_4_3_kiq_setting(struct amdgpu_ring *ring, int xcc_id)
+static void gfx_v9_4_3_xcc_kiq_setting(struct amdgpu_ring *ring, int xcc_id)
 {
 	uint32_t tmp;
 	struct amdgpu_device *adev = ring->adev;
@@ -1563,7 +1567,8 @@ static int gfx_v9_4_3_mqd_init(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v9_4_3_kiq_init_register(struct amdgpu_ring *ring, int xcc_id)
+static int gfx_v9_4_3_xcc_kiq_init_register(struct amdgpu_ring *ring,
+					    int xcc_id)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
@@ -1668,7 +1673,8 @@ static int gfx_v9_4_3_kiq_init_register(struct amdgpu_ring *ring, int xcc_id)
 	return 0;
 }
 
-static int gfx_v9_4_3_kiq_fini_register(struct amdgpu_ring *ring, int xcc_id)
+static int gfx_v9_4_3_xcc_kiq_fini_register(struct amdgpu_ring *ring,
+					    int xcc_id)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int j;
@@ -1707,13 +1713,13 @@ static int gfx_v9_4_3_kiq_fini_register(struct amdgpu_ring *ring, int xcc_id)
 	return 0;
 }
 
-static int gfx_v9_4_3_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
+static int gfx_v9_4_3_xcc_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
 	struct v9_mqd *tmp_mqd;
 
-	gfx_v9_4_3_kiq_setting(ring, xcc_id);
+	gfx_v9_4_3_xcc_kiq_setting(ring, xcc_id);
 
 	/* GPU could be in bad state during probe, driver trigger the reset
 	 * after load the SMU, in this case , the mqd is not be initialized.
@@ -1731,7 +1737,7 @@ static int gfx_v9_4_3_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 		amdgpu_ring_clear_ring(ring);
 		mutex_lock(&adev->srbm_mutex);
 		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, xcc_id));
-		gfx_v9_4_3_kiq_init_register(ring, xcc_id);
+		gfx_v9_4_3_xcc_kiq_init_register(ring, xcc_id);
 		soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 		mutex_unlock(&adev->srbm_mutex);
 	} else {
@@ -1741,7 +1747,7 @@ static int gfx_v9_4_3_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 		mutex_lock(&adev->srbm_mutex);
 		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, xcc_id));
 		gfx_v9_4_3_mqd_init(ring);
-		gfx_v9_4_3_kiq_init_register(ring, xcc_id);
+		gfx_v9_4_3_xcc_kiq_init_register(ring, xcc_id);
 		soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 		mutex_unlock(&adev->srbm_mutex);
 
@@ -1752,7 +1758,7 @@ static int gfx_v9_4_3_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 	return 0;
 }
 
-static int gfx_v9_4_3_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
+static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
@@ -1793,7 +1799,7 @@ static int gfx_v9_4_3_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 	return 0;
 }
 
-static int gfx_v9_4_3_kiq_resume(struct amdgpu_device *adev, int xcc_id)
+static int gfx_v9_4_3_xcc_kiq_resume(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_ring *ring;
 	int r;
@@ -1808,7 +1814,7 @@ static int gfx_v9_4_3_kiq_resume(struct amdgpu_device *adev, int xcc_id)
 	if (unlikely(r != 0))
 		return r;
 
-	gfx_v9_4_3_kiq_init_queue(ring, xcc_id);
+	gfx_v9_4_3_xcc_kiq_init_queue(ring, xcc_id);
 	amdgpu_bo_kunmap(ring->mqd_obj);
 	ring->mqd_ptr = NULL;
 	amdgpu_bo_unreserve(ring->mqd_obj);
@@ -1816,12 +1822,12 @@ static int gfx_v9_4_3_kiq_resume(struct amdgpu_device *adev, int xcc_id)
 	return 0;
 }
 
-static int gfx_v9_4_3_kcq_resume(struct amdgpu_device *adev, int xcc_id)
+static int gfx_v9_4_3_xcc_kcq_resume(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_ring *ring = NULL;
 	int r = 0, i;
 
-	gfx_v9_4_3_cp_compute_enable(adev, true, xcc_id);
+	gfx_v9_4_3_xcc_cp_compute_enable(adev, true, xcc_id);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
@@ -1831,7 +1837,7 @@ static int gfx_v9_4_3_kcq_resume(struct amdgpu_device *adev, int xcc_id)
 			goto done;
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v9_4_3_kcq_init_queue(ring, xcc_id);
+			r = gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -1852,12 +1858,12 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-		gfx_v9_4_3_enable_gui_idle_interrupt(adev, false, i);
+		gfx_v9_4_3_xcc_enable_gui_idle_interrupt(adev, false, i);
 
 		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-			gfx_v9_4_3_disable_gpa_mode(adev, i);
+			gfx_v9_4_3_xcc_disable_gpa_mode(adev, i);
 
-			r = gfx_v9_4_3_cp_compute_load_microcode(adev, i);
+			r = gfx_v9_4_3_xcc_cp_compute_load_microcode(adev, i);
 			if (r)
 				return r;
 		}
@@ -1868,13 +1874,13 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 				adev, amdgpu_user_partt_mode);
 
 		/* set the virtual and physical id based on partition_mode */
-		gfx_v9_4_3_program_xcc_id(adev, i);
+		gfx_v9_4_3_xcc_program_xcc_id(adev, i);
 
-		r = gfx_v9_4_3_kiq_resume(adev, i);
+		r = gfx_v9_4_3_xcc_kiq_resume(adev, i);
 		if (r)
 			return r;
 
-		r = gfx_v9_4_3_kcq_resume(adev, i);
+		r = gfx_v9_4_3_xcc_kcq_resume(adev, i);
 		if (r)
 			return r;
 
@@ -1885,16 +1891,16 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 				return r;
 		}
 
-		gfx_v9_4_3_enable_gui_idle_interrupt(adev, true, i);
+		gfx_v9_4_3_xcc_enable_gui_idle_interrupt(adev, true, i);
 	}
 
 	return 0;
 }
 
-static void gfx_v9_4_3_cp_enable(struct amdgpu_device *adev, bool enable,
-				int xcc_id)
+static void gfx_v9_4_3_xcc_cp_enable(struct amdgpu_device *adev, bool enable,
+				     int xcc_id)
 {
-	gfx_v9_4_3_cp_compute_enable(adev, enable, xcc_id);
+	gfx_v9_4_3_xcc_cp_compute_enable(adev, enable, xcc_id);
 }
 
 static int gfx_v9_4_3_hw_init(void *handle)
@@ -1938,12 +1944,13 @@ static int gfx_v9_4_3_hw_fini(void *handle)
 			soc15_grbm_select(adev, adev->gfx.kiq[i].ring.me,
 					adev->gfx.kiq[i].ring.pipe,
 					adev->gfx.kiq[i].ring.queue, 0, GET_INST(GC, i));
-			gfx_v9_4_3_kiq_fini_register(&adev->gfx.kiq[i].ring, i);
+			gfx_v9_4_3_xcc_kiq_fini_register(&adev->gfx.kiq[i].ring,
+							 i);
 			soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, i));
 			mutex_unlock(&adev->srbm_mutex);
 		}
 
-		gfx_v9_4_3_cp_enable(adev, false, i);
+		gfx_v9_4_3_xcc_cp_enable(adev, false, i);
 	}
 
 	/* Skip suspend with A+A reset */
@@ -2030,7 +2037,7 @@ static int gfx_v9_4_3_soft_reset(void *handle)
 		adev->gfx.rlc.funcs->stop(adev);
 
 		/* Disable MEC parsing/prefetching */
-		gfx_v9_4_3_cp_compute_enable(adev, false, 0);
+		gfx_v9_4_3_xcc_cp_compute_enable(adev, false, 0);
 
 		if (grbm_soft_reset) {
 			tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
@@ -2117,8 +2124,9 @@ static int gfx_v9_4_3_late_init(void *handle)
 	return 0;
 }
 
-static void gfx_v9_4_3_update_medium_grain_clock_gating(struct amdgpu_device *adev,
-						      bool enable, int xcc_id)
+static void
+gfx_v9_4_3_xcc_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						bool enable, int xcc_id)
 {
 	uint32_t data, def;
 
@@ -2186,8 +2194,9 @@ static void gfx_v9_4_3_update_medium_grain_clock_gating(struct amdgpu_device *ad
 	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
 }
 
-static void gfx_v9_4_3_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
-						      bool enable, int xcc_id)
+static void
+gfx_v9_4_3_xcc_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
+						bool enable, int xcc_id)
 {
 	uint32_t def, data;
 
@@ -2238,31 +2247,35 @@ static void gfx_v9_4_3_update_coarse_grain_clock_gating(struct amdgpu_device *ad
 	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
 }
 
-static int gfx_v9_4_3_update_gfx_clock_gating(struct amdgpu_device *adev,
-					    bool enable, int xcc_id)
+static int gfx_v9_4_3_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
+						  bool enable, int xcc_id)
 {
 	if (enable) {
 		/* CGCG/CGLS should be enabled after MGCG/MGLS
 		 * ===  MGCG + MGLS ===
 		 */
-		gfx_v9_4_3_update_medium_grain_clock_gating(adev, enable, xcc_id);
+		gfx_v9_4_3_xcc_update_medium_grain_clock_gating(adev, enable,
+								xcc_id);
 		/* ===  CGCG + CGLS === */
-		gfx_v9_4_3_update_coarse_grain_clock_gating(adev, enable, xcc_id);
+		gfx_v9_4_3_xcc_update_coarse_grain_clock_gating(adev, enable,
+								xcc_id);
 	} else {
 		/* CGCG/CGLS should be disabled before MGCG/MGLS
 		 * ===  CGCG + CGLS ===
 		 */
-		gfx_v9_4_3_update_coarse_grain_clock_gating(adev, enable, xcc_id);
+		gfx_v9_4_3_xcc_update_coarse_grain_clock_gating(adev, enable,
+								xcc_id);
 		/* ===  MGCG + MGLS === */
-		gfx_v9_4_3_update_medium_grain_clock_gating(adev, enable, xcc_id);
+		gfx_v9_4_3_xcc_update_medium_grain_clock_gating(adev, enable,
+								xcc_id);
 	}
 	return 0;
 }
 
 static const struct amdgpu_rlc_funcs gfx_v9_4_3_rlc_funcs = {
 	.is_rlc_enabled = gfx_v9_4_3_is_rlc_enabled,
-	.set_safe_mode = gfx_v9_4_3_set_safe_mode,
-	.unset_safe_mode = gfx_v9_4_3_unset_safe_mode,
+	.set_safe_mode = gfx_v9_4_3_xcc_set_safe_mode,
+	.unset_safe_mode = gfx_v9_4_3_xcc_unset_safe_mode,
 	.init = gfx_v9_4_3_rlc_init,
 	.resume = gfx_v9_4_3_rlc_resume,
 	.stop = gfx_v9_4_3_rlc_stop,
@@ -2291,8 +2304,8 @@ static int gfx_v9_4_3_set_clockgating_state(void *handle,
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 4, 3):
 		for (i = 0; i < num_xcc; i++)
-			gfx_v9_4_3_update_gfx_clock_gating(adev,
-						state == AMD_CG_STATE_GATE, i);
+			gfx_v9_4_3_xcc_update_gfx_clock_gating(
+				adev, state == AMD_CG_STATE_GATE, i);
 		break;
 	default:
 		break;
@@ -2559,10 +2572,9 @@ static void gfx_v9_4_3_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 						   ref, mask);
 }
 
-static void gfx_v9_4_3_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
-						       int me, int pipe,
-						       enum amdgpu_interrupt_state state,
-						       int xcc_id)
+static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
+	struct amdgpu_device *adev, int me, int pipe,
+	enum amdgpu_interrupt_state state, int xcc_id)
 {
 	u32 mec_int_cntl, mec_int_cntl_reg;
 
@@ -2670,28 +2682,36 @@ static int gfx_v9_4_3_set_eop_interrupt_state(struct amdgpu_device *adev,
 	for (i = 0; i < num_xcc; i++) {
 		switch (type) {
 		case AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP:
-			gfx_v9_4_3_set_compute_eop_interrupt_state(adev, 1, 0, state, i);
+			gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
+				adev, 1, 0, state, i);
 			break;
 		case AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE1_EOP:
-			gfx_v9_4_3_set_compute_eop_interrupt_state(adev, 1, 1, state, i);
+			gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
+				adev, 1, 1, state, i);
 			break;
 		case AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE2_EOP:
-			gfx_v9_4_3_set_compute_eop_interrupt_state(adev, 1, 2, state, i);
+			gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
+				adev, 1, 2, state, i);
 			break;
 		case AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE3_EOP:
-			gfx_v9_4_3_set_compute_eop_interrupt_state(adev, 1, 3, state, i);
+			gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
+				adev, 1, 3, state, i);
 			break;
 		case AMDGPU_CP_IRQ_COMPUTE_MEC2_PIPE0_EOP:
-			gfx_v9_4_3_set_compute_eop_interrupt_state(adev, 2, 0, state, i);
+			gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
+				adev, 2, 0, state, i);
 			break;
 		case AMDGPU_CP_IRQ_COMPUTE_MEC2_PIPE1_EOP:
-			gfx_v9_4_3_set_compute_eop_interrupt_state(adev, 2, 1, state, i);
+			gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
+				adev, 2, 1, state, i);
 			break;
 		case AMDGPU_CP_IRQ_COMPUTE_MEC2_PIPE2_EOP:
-			gfx_v9_4_3_set_compute_eop_interrupt_state(adev, 2, 2, state, i);
+			gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
+				adev, 2, 2, state, i);
 			break;
 		case AMDGPU_CP_IRQ_COMPUTE_MEC2_PIPE3_EOP:
-			gfx_v9_4_3_set_compute_eop_interrupt_state(adev, 2, 3, state, i);
+			gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
+				adev, 2, 3, state, i);
 			break;
 		default:
 			break;
@@ -3096,7 +3116,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 			mask = 1;
 			ao_bitmap = 0;
 			counter = 0;
-			gfx_v9_4_3_select_se_sh(adev, i, j, 0xffffffff, 0);
+			gfx_v9_4_3_xcc_select_se_sh(adev, i, j, 0xffffffff, 0);
 			gfx_v9_4_3_set_user_cu_inactive_bitmap(
 				adev, disable_masks[i * adev->gfx.config.max_sh_per_se + j]);
 			bitmap = gfx_v9_4_3_get_cu_active_bitmap(adev);
@@ -3129,7 +3149,8 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 			cu_info->ao_cu_bitmap[i % 4][j + i / 4] = ao_bitmap;
 		}
 	}
-	gfx_v9_4_3_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
+	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
+				    0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	cu_info->number = active_cu_number;
-- 
2.39.2


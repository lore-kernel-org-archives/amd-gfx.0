Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BADD1093179
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 06:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06D310EA65;
	Fri, 20 Mar 2026 06:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YM9njloi";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013059.outbound.protection.outlook.com
 [40.107.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BABAB10E9B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 06:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VB6Gg19Dta89Xc3yAMXdAg0OM46ZOTljNh0O2hww9OuOC+YI7hb36YibSMNggWRxwx+CI3C+LWuxYogyk/sTvCeScMXP4qs+CSkF0l4+CO1Fl1WTV2vNvt6sEP7MHKmnWr/NFSIHaCtqBI4ULahEsc8ntacerr+3VDcDnzYZX/cEi6X9vZu0xZFBCBYFkVRhqOKwSaPbZmCCkkVgF+5+iI9SAtKLlFDU+299I5cSJS6aAMuvBoMYRMfaoQw1cmf3YQOjTo7pF8TL/wUWZ6MGWQXsZwa9XUC2HKyQF33bRDqt9snOAM3/REA3IEOT9YSdPsT/ZFU52+s8VLBbp+otZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWSDhjE3dJIcU9jMPYMl0ICwoJkelM5iQLt+unEdTi8=;
 b=b5AJj7X9GYqWzJdpAyoXUjojB9A7xoWzzMM2gqE5onXoPoWyXIHdnMn3XVjSKCvXgu/ZsXHQvi1YMYWrLnj3vJxQXPN68CIESkkTdOrjALr8WV+FDiQxsR7Ytn5e/fBl/Fen3Yut5J0SvHbxoDQ7fZ5zRPrKOq8pHIvQ/kj+w9HvsD5UblyG2eNAQnmqsh+q7RXW6s6OKt3pKJw38j4rZY0jDLGQLFG+8RyMCMh+660wOuMz4EfcmpPaMc566WBo1yT2IBGz21FAmSde8VaxVcN+O4XRsx1pSRMLUuxLy9O+1/xDOQqIDRHLX48CtAXE900IPvFdyOGdynTV7Y4whw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWSDhjE3dJIcU9jMPYMl0ICwoJkelM5iQLt+unEdTi8=;
 b=YM9njloi4v6L4frX1nBSrCynfKWKSyoycnctNFcXWZGC6u7h0YXdhyOw66aAFQMlHOp0Q+0ZOkBSiE41PzHMb5J6/6a7aFPMeYjyyG35HJDnorhDhQB9L/EuyLoSa7M7UMm6rR/rrjbeYe1yF1SWeg92ZpDQwDWptwA7T8M1SNA=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 06:04:28 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::3c) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 06:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 06:04:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 01:04:25 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Unify version check in SMUv11
Date: Fri, 20 Mar 2026 11:34:07 +0530
Message-ID: <20260320060409.616702-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b192c3-c18b-43c4-e4ee-08de86468b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZdrWx1zw8gpgY5ZmhJtG/39mvuWx1ULgoNDxLX/H1xZquF9MrpdXb175OyxWbqrAOPguP09Ir9h79e2s9zFvgy9yHvwKz+ueH8CRSErQwYyD+xvuu6dox2q3MLXFkAEppvaeel6OPOR1ZmRpn+LoSdYif7WntOa41bQHOt4xwpzvvSH49wZ2e4Au8PwFAgaTfNoAWCElDAGk0E8vuApBU8KYxDMZgN3mk7VMZsFcUDKdSB2yCkNE0lvUrbaLBAN4Ar+CiZyKUun/4wWAXq43V2h2xZwb2Dr3PGbMEVG9WNHEmJL/2NcmbSgM9qlNE/b0LGl9aBfSpRyzt4ZJmxTVOed88Y7mI/oqkoJLA43NkTmyifUrjxkXj5GL5VwA+2+fe4rzbhpDmBd1/Tviw3rkH0zaG4FJLjnUsnuccBQmwjt0yn2QolOJ9eyG8QygG0DAFbqZe/cOISra0DQEGlNskyQVR4szDJ52xuKa1yAW7YlaxkYn8DAO3SSrsAEkPoflWlxp2x7uXilJVYKER60w55bZ0D0cxkyRz43KhyWyLpQ2ljA4qW+KEtGGAYfUy6LBWxgEUn+p61xl7p96eMWCShgR4D0LEAX03tbNL5msDx2XNGwr1wnUXpVoSaBPq7frUnXIFfN/tP+o7F60+IppqSge6+kEArNmaJsiNSgLKD+Zu6jZGp/NG9IFzUSt8mdcKq3gxNtoOl6VVXUYrar+rt76RgTaxysppxS2a4nASjkgdmnEM/E6P0xGZyt3FBJICesRsjd370APAU19TN9AOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NBjW8/v677YEsO+k4I/nX1j7KZzNeHzPTlpHOxEfEPwjV5EzLDbRI+kenuna/pvJmRd7HuwmucCFVbsttLm9pg4cSl+fIEXE5DAty9XvEWlPUo7mwIOXJ+0unQgwd/9r6ZAQt3zNUtKABWwi7NtManG+4Hk7zClZyrVrHoyO8oi6lK9KwT7wdHiyzwMIJHBLoCwDduIX9A8K1uKwFB6Xc9QxSgtI1eK8k744HAeCGH57JiegRYe3yZGb2mk9j57OvBzpiHLpCzPAJSfG/hDUhdkWPF4e2f2qQ+MkSDv/UFVPsz/RF3/HVUlweBRCHKq5LZPd+JoxljCppOm/sb94PJZPadoSnQuiw9PCW/doXwVHWJkKEu28B1bXWnZNea70NthNK4mHNAdNPOxzX/E75qgc2mSekOVW5S3QI9MfFmfX6X1f/ppREWOIrGMiVFzJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 06:04:27.7520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b192c3-c18b-43c4-e4ee-08de86468b6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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

Use common helper function for firmware version check and logging in
SMUv11

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  | 14 ----
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  5 +-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 21 +++++-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 ++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 75 -------------------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  3 +-
 7 files changed, 52 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index 7c1701ed3e11..dd94e8a9e218 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -25,18 +25,6 @@
 
 #include "amdgpu_smu.h"
 
-#define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU11_DRIVER_IF_VERSION_ARCT 0x17
-#define SMU11_DRIVER_IF_VERSION_NV10 0x37
-#define SMU11_DRIVER_IF_VERSION_NV12 0x38
-#define SMU11_DRIVER_IF_VERSION_NV14 0x38
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x40
-#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE
-#define SMU11_DRIVER_IF_VERSION_VANGOGH 0x03
-#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
-#define SMU11_DRIVER_IF_VERSION_Beige_Goby 0xD
-#define SMU11_DRIVER_IF_VERSION_Cyan_Skillfish 0x8
-
 /* MP Apertures */
 #define MP0_Public			0x03800000
 #define MP0_SRAM			0x03900000
@@ -148,8 +136,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu);
 
 int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
 
-int smu_v11_0_check_fw_version(struct smu_context *smu);
-
 int smu_v11_0_set_driver_table_location(struct smu_context *smu);
 
 int smu_v11_0_set_tool_table_location(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 0c4afd1e1aab..d73c3c191e9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -65,6 +65,8 @@
 #define SMU_FEATURES_HIGH_MASK       0xFFFFFFFF00000000
 #define SMU_FEATURES_HIGH_SHIFT      32
 
+#define SMU11_DRIVER_IF_VERSION_ARCT 0x17
+
 static const struct smu_feature_bits arcturus_dpm_features = {
 	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
 		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
@@ -1906,7 +1908,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* pptable related */
 	.setup_pptable = arcturus_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.check_fw_version = smu_v11_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.write_pptable = smu_cmn_write_pptable,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
@@ -1959,5 +1961,6 @@ void arcturus_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = arcturus_table_map;
 	smu->pwr_src_map = arcturus_pwr_src_map;
 	smu->workload_map = arcturus_workload_map;
+	smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
 	smu_v11_0_init_msg_ctl(smu, arcturus_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 87953a4d0a43..1cc26cc79454 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -582,7 +582,7 @@ cyan_skillfish_get_enabled_mask(struct smu_context *smu,
 static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
-	.check_fw_version = smu_v11_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
 	.init_smc_tables = cyan_skillfish_init_smc_tables,
@@ -605,5 +605,6 @@ void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
 	smu->ppt_funcs = &cyan_skillfish_ppt_funcs;
 	smu->table_map = cyan_skillfish_table_map;
 	smu->is_apu = true;
+	smu->smc_driver_if_version = MP1_DRIVER_IF_VERSION;
 	smu_v11_0_init_msg_ctl(smu, cyan_skillfish_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 737bfdfb814c..f2ce8de58cb9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -73,6 +73,10 @@ static const struct smu_feature_bits navi10_dpm_features = {
 
 #define SMU_11_0_GFX_BUSY_THRESHOLD 15
 
+#define SMU11_DRIVER_IF_VERSION_NV10  0x37
+#define SMU11_DRIVER_IF_VERSION_NV12  0x38
+#define SMU11_DRIVER_IF_VERSION_NV14  0x38
+
 static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,			1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,		1),
@@ -3310,7 +3314,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.setup_pptable = navi10_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.check_fw_version = smu_v11_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.write_pptable = smu_cmn_write_pptable,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
@@ -3363,11 +3367,26 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
+
 	smu->ppt_funcs = &navi10_ppt_funcs;
 	smu->clock_map = navi10_clk_map;
 	smu->feature_map = navi10_feature_mask_map;
 	smu->table_map = navi10_table_map;
 	smu->pwr_src_map = navi10_pwr_src_map;
 	smu->workload_map = navi10_workload_map;
+
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(11, 0, 0):
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV10;
+		break;
+	case IP_VERSION(11, 0, 9):
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV12;
+		break;
+	case IP_VERSION(11, 0, 5):
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV14;
+		break;
+	}
+
 	smu_v11_0_init_msg_ctl(smu, navi10_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6268bc5ed3e6..68255cfcb04d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3120,7 +3120,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.setup_pptable = sienna_cichlid_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.check_fw_version = smu_v11_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.write_pptable = smu_cmn_write_pptable,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
@@ -3177,13 +3177,36 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.mode2_reset = sienna_cichlid_mode2_reset,
 };
 
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid  0x40
+#define SMU11_DRIVER_IF_VERSION_Navy_Flounder   0xE
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
+#define SMU11_DRIVER_IF_VERSION_Beige_Goby      0xD
+
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
+
 	smu->ppt_funcs = &sienna_cichlid_ppt_funcs;
 	smu->clock_map = sienna_cichlid_clk_map;
 	smu->feature_map = sienna_cichlid_feature_mask_map;
 	smu->table_map = sienna_cichlid_table_map;
 	smu->pwr_src_map = sienna_cichlid_pwr_src_map;
 	smu->workload_map = sienna_cichlid_workload_map;
+
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(11, 0, 7):
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Sienna_Cichlid;
+		break;
+	case IP_VERSION(11, 0, 11):
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
+		break;
+	case IP_VERSION(11, 0, 12):
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish;
+		break;
+	case IP_VERSION(11, 0, 13):
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Beige_Goby;
+		break;
+	}
+
 	smu_v11_0_init_msg_ctl(smu, sienna_cichlid_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 1eec1a88e05f..98e7109bbc95 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -192,81 +192,6 @@ int smu_v11_0_check_fw_status(struct smu_context *smu)
 	return -EIO;
 }
 
-int smu_v11_0_check_fw_version(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t if_version = 0xff, smu_version = 0xff;
-	uint8_t smu_program, smu_major, smu_minor, smu_debug;
-	int ret = 0;
-
-	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-	if (ret)
-		return ret;
-
-	smu_program = (smu_version >> 24) & 0xff;
-	smu_major = (smu_version >> 16) & 0xff;
-	smu_minor = (smu_version >> 8) & 0xff;
-	smu_debug = (smu_version >> 0) & 0xff;
-	if (smu->is_apu)
-		adev->pm.fw_version = smu_version;
-
-	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-	case IP_VERSION(11, 0, 0):
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV10;
-		break;
-	case IP_VERSION(11, 0, 9):
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV12;
-		break;
-	case IP_VERSION(11, 0, 5):
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV14;
-		break;
-	case IP_VERSION(11, 0, 7):
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Sienna_Cichlid;
-		break;
-	case IP_VERSION(11, 0, 11):
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
-		break;
-	case IP_VERSION(11, 5, 0):
-	case IP_VERSION(11, 5, 2):
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
-		break;
-	case IP_VERSION(11, 0, 12):
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish;
-		break;
-	case IP_VERSION(11, 0, 13):
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Beige_Goby;
-		break;
-	case IP_VERSION(11, 0, 8):
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Cyan_Skillfish;
-		break;
-	case IP_VERSION(11, 0, 2):
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
-		break;
-	default:
-		dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\n",
-			amdgpu_ip_version(adev, MP1_HWIP, 0));
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_INV;
-		break;
-	}
-
-	/*
-	 * 1. if_version mismatch is not critical as our fw is designed
-	 * to be backward compatible.
-	 * 2. New fw usually brings some optimizations. But that's visible
-	 * only on the paired driver.
-	 * Considering above, we just leave user a verbal message instead
-	 * of halt driver loading.
-	 */
-	if (if_version != smu->smc_driver_if_version) {
-		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
-			"smu fw program = %d, version = 0x%08x (%d.%d.%d)\n",
-			smu->smc_driver_if_version, if_version,
-			smu_program, smu_version, smu_major, smu_minor, smu_debug);
-	}
-
-	return ret;
-}
-
 static int smu_v11_0_set_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)
 {
 	struct amdgpu_device *adev = smu->adev;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 08179840697e..0349c73eb000 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2512,7 +2512,7 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
-	.check_fw_version = smu_v11_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.init_smc_tables = vangogh_init_smc_tables,
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.init_power = smu_v11_0_init_power,
@@ -2562,5 +2562,6 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = vangogh_table_map;
 	smu->workload_map = vangogh_workload_map;
 	smu->is_apu = true;
+	smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION;
 	smu_v11_0_init_msg_ctl(smu, vangogh_message_map);
 }
-- 
2.49.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A34109317A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 06:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0188810EA7C;
	Fri, 20 Mar 2026 06:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ox01V2kY";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012050.outbound.protection.outlook.com
 [40.93.195.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC79910EA7C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 06:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A36QsiGSJp9Iym1DdvXKtbZH3YecTDJGHI8O6Ucgyznzb+Ee5ixfBgLRcfSQ0w/JEb/Z4Rl9M3zZ3PWUiSWTaKbSl2XQ5UStWCnZ/HsUnt2rmS3L0KxwJFGKCeL1WdI7EsXHkBy5382xbPI5k8Qx92FHGeDC7unI99IMB454S9fysiuHYD3bm2PCgKGlq0fn21bHrn7MKP9J4CEHfEmtlEdfX90oZwbNKOk/k/5WexjBwlL2H3uheKH3CF9z8jZDvmSQRSWOq69uGJF/gJ492FOxgvr5mBfqcX1T6e1BplqnWLJrtU5zXR4eORRuUxYJQ9ToOom0BQQEPXbB4E6kjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b94V6owcf0DMvY37VZy/m7hqcvnQRIiUrLpW4+06x8E=;
 b=EtEnIQS0l5y4cCftQos/9cUMcwzpAbJnBgAkK7MHFhnrLd1vrwSTi3uDOsogc81NFa7cwm297Pnrtj+YUsM0xNkMbPESb+zhbKOkNxGnRdvmKiQL5N4tyIHuPnW3bRbqXPbLeWiLd3b1/zdt27bQQSarGE5whMxUlVJKB92T6GMzgk+OLKmhtO0A7SgO30OmQIYSuqLwUyNQHaUC+RKxWHBtO+mUMc8vUNKsJUNb5+z5ZwuSyIIR+I5GImbw8cD/pxH+rRa97f6yep3B1FOc/f22rwSw6X8/WZdoDI0bwMOMiIBF1j4FgymMq6Rmj7ilkdI+QGC1tg8gKO31XjwfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b94V6owcf0DMvY37VZy/m7hqcvnQRIiUrLpW4+06x8E=;
 b=ox01V2kYxOqSM1aGnY8ts0xXXNDFpnwDUR6f+Mqlrw1E96upwtxYk52gmP2jGnk2DwhYRj4ennrxX80ZR0ONUPTgtWrDXyEyBICrfQXdUF3b+qQbHitfbBt13bWkI8oeScovIumMk3zP7VTISjqVomNaKcKFVv4Zqi6S8aha0Qg=
Received: from SJ0PR03CA0041.namprd03.prod.outlook.com (2603:10b6:a03:33e::16)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 06:04:32 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::18) by SJ0PR03CA0041.outlook.office365.com
 (2603:10b6:a03:33e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 06:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 06:04:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 01:04:29 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Unify version check in SMUv14
Date: Fri, 20 Mar 2026 11:34:09 +0530
Message-ID: <20260320060409.616702-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260320060409.616702-1-lijo.lazar@amd.com>
References: <20260320060409.616702-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbd72ca-2623-468e-71d7-08de86468dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kL6G6pyIiYE6w1NcelMXQ3IpoiQNay98Xbjhdw3CbX6+ZtsU5WnCnVYqxqWMrw+ovdx2stzUaoxkURDdGXHW0vChucwxpDlvqfXeBkkm+iriw6l9brXHO/xrrGHeydt+OPvO//kSXVD2qWNM4YG+x8NE92GQkbUtG1jBfjRdm2vSBLZO/fSbHU93m0oeqyYVwnJmgsxaNivq6/n1GxF8NEeyJgk3ZwU6xNqynFyLp2rcIhZ/GwFck/zP44PEpll32RwE1j5jK271Xhbt7mUrsbBeHSsO8VhwxeMiVR63IStjPORNW1qxtr4b4pnrs7kYw0Arn9HLXJNRF/PAhfyr6KmW/7U+GHOijiyV3Gr3TfR8JEHWQ9wuBeAx8wEoXBLpFOcZe6DpjCgfmDWJoIpeErlCDHTQOvF1STR0F8TarSOR9wh5ualRdKB84WO4NqQju/I810jUDi/H5weT74aHH7LPGCBbfQb2QEGzm5aOG6NhKW9bF0xUbAcCO0ycuk2qqQT3KJt9w9kCmD5t7B1iRR1FS9mesjFwgQizm+96QZYUOu0ITa2HeOPznivbzPpuQnxsegsRyz2iclpxW3Dd8Zg6saWELBWCz90Db9Bj0BC8jKoaLH9fW80C7K7y989dN4FzQT4uuH0RRale1EnA9XHoPTuBl5wmjA9OvppSu6+aXgamLjGQcpt8LSQ+3cNlTqx6NPHnrDCCFRvZUY/mo21HhrZ7wNgX7PcByQzOb89+62G/Q1LyrUlVU+1GZnLfE7AwcOhrT4N5fHdRiBeHhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aOjIFpwPXhPYW1Vy3thrMlf9EG31+GR3+G6wnYEvIHoELGpMSWgGibt4QcEf20Y7IxZXdLo1l++FiEZ2I9tKohInnmUwY6rQSvSHSyCVu9ewBGPAtVa5CstctJEMV+xu63gbn+DdEcrFr8qHE0SpSWM9/+IzlR0WzeIwBeZz89eTvwecHVcn5l7PHDVM0Y10r1bEROTyeZbdDLsmNL2fYIWiz4cqoRTp18nNVZpb0ooPoaXbF+o4bPfv7BRet67ZiMPu8+ECvIfER6kHsoiFuoEerin8LLmYMTKc5Q+5r8cZ6U53QhsZN6xdGAA3V5jif8nBzYpMcLBBpOu1GctsmlRs3P0F6j/CDvKeIu7o6p3Ar27adfEIX3QRQMEoEV8EeFTCFPOKASWE5WMoDOwrdQGthIcGBx0WPgnJvRYAgTed54/DuPcjPK4yFGB565li
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 06:04:31.5906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbd72ca-2623-468e-71d7-08de86468dc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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
SMUv14

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  7 ---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 60 -------------------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 18 +++++-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  5 +-
 4 files changed, 21 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index b453e6efc7c9..4eb40ff8aff2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -25,11 +25,6 @@
 
 #include "amdgpu_smu.h"
 
-#define SMU14_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_0 0x7
-#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_1 0x6
-#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x2E
-
 #define FEATURE_MASK(feature) (1ULL << feature)
 
 /* MP Apertures */
@@ -124,8 +119,6 @@ int smu_v14_0_setup_pptable(struct smu_context *smu);
 
 int smu_v14_0_get_vbios_bootup_values(struct smu_context *smu);
 
-int smu_v14_0_check_fw_version(struct smu_context *smu);
-
 int smu_v14_0_set_driver_table_location(struct smu_context *smu);
 
 int smu_v14_0_set_tool_table_location(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 9f01bed3970e..61655841c2e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -229,66 +229,6 @@ int smu_v14_0_check_fw_status(struct smu_context *smu)
 	return -EIO;
 }
 
-int smu_v14_0_check_fw_version(struct smu_context *smu)
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
-	case IP_VERSION(14, 0, 0):
-	case IP_VERSION(14, 0, 4):
-	case IP_VERSION(14, 0, 5):
-		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
-		break;
-	case IP_VERSION(14, 0, 1):
-		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_1;
-		break;
-	case IP_VERSION(14, 0, 2):
-	case IP_VERSION(14, 0, 3):
-		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_2;
-		break;
-	default:
-		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
-			amdgpu_ip_version(adev, MP1_HWIP, 0));
-		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_INV;
-		break;
-	}
-
-	if (adev->pm.fw)
-		dev_dbg(smu->adev->dev, "smu fw reported program %d, version = 0x%08x (%d.%d.%d)\n",
-			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
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
-		dev_info(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
-			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
-			 smu->smc_driver_if_version, if_version,
-			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
-	}
-
-	return ret;
-}
-
 static int smu_v14_0_set_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)
 {
 	struct amdgpu_device *adev = smu->adev;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index dbdf7653cc53..c76b1f07885e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -65,6 +65,9 @@
 
 #define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
 
+#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_0 0x7
+#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_1 0x6
+
 #define SMU_14_0_0_UMD_PSTATE_GFXCLK			700
 #define SMU_14_0_0_UMD_PSTATE_SOCCLK			678
 #define SMU_14_0_0_UMD_PSTATE_FCLK			1800
@@ -1699,7 +1702,7 @@ static int smu_v14_0_0_restore_user_od_settings(struct smu_context *smu)
 
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.check_fw_status = smu_v14_0_check_fw_status,
-	.check_fw_version = smu_v14_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.init_smc_tables = smu_v14_0_0_init_smc_tables,
 	.fini_smc_tables = smu_v14_0_0_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v14_0_get_vbios_bootup_values,
@@ -1750,10 +1753,23 @@ static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
 
 void smu_v14_0_0_set_ppt_funcs(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
+
 	smu->ppt_funcs = &smu_v14_0_0_ppt_funcs;
 	smu->feature_map = smu_v14_0_0_feature_mask_map;
 	smu->table_map = smu_v14_0_0_table_map;
 	smu->is_apu = true;
 
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 4):
+	case IP_VERSION(14, 0, 5):
+		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
+		break;
+	case IP_VERSION(14, 0, 1):
+		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_1;
+		break;
+	}
+
 	smu_v14_0_0_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 23a143b36fd0..236ccb9d7d89 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -64,6 +64,8 @@ static const struct smu_feature_bits smu_v14_0_2_dpm_features = {
 		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT) }
 };
 
+#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x2E
+
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
 #define DEBUGSMC_MSG_Mode1Reset        2
 #define LINK_SPEED_MAX					3
@@ -2768,7 +2770,7 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.fini_power = smu_v14_0_fini_power,
 	.check_fw_status = smu_v14_0_check_fw_status,
 	.setup_pptable = smu_v14_0_2_setup_pptable,
-	.check_fw_version = smu_v14_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.set_driver_table_location = smu_v14_0_set_driver_table_location,
 	.system_features_control = smu_v14_0_system_features_control,
 	.set_allowed_mask = smu_v14_0_set_allowed_mask,
@@ -2833,5 +2835,6 @@ void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v14_0_2_table_map;
 	smu->pwr_src_map = smu_v14_0_2_pwr_src_map;
 	smu->workload_map = smu_v14_0_2_workload_map;
+	smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_2;
 	smu_v14_0_2_init_msg_ctl(smu);
 }
-- 
2.49.0


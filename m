Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607CBC4345F
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Apr 2024 23:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7ADB10F551;
	Sat, 13 Apr 2024 23:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wh0F8b3N";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA4010F4FD
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Apr 2024 23:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlOT6dGue9nH6UsRuHEfL9Qocp/rpHXJlh3kUx36Ett79ZRlKWAEEKgYU3TrGkGtxI+OTx4rDDRHFZQe/Ljqhta6RtwQFa4hyy1/i6fqJWkNIa3Yd1Smy/wVcFXsKfDTiIfzNU5O+h0vOn3jd/u1swtafDeQYPzjQCpVskW0ZsB+eCVHiVYlvd9nBHyY8zEEK7tdLGHSLrSkhXBg6XnuiEHZUFMb8t99Vg/h1GuhvPUFHcqHyRcex3izMP9uZfnRSgKyR2if5vGiwH2NYH5Ob0R/ifdnDgnzJ0jjXunvx7Vj4Ur9MTsBe1sYj1/61HjQO8y0hO20RUqVZHTpQ7dhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Cp/m3prycoWQSVh1wAbDpyPLIXjX8NhxH+0sxWPQdU=;
 b=PGVQ3ADAXLwHyqELvS/sAXSJ9MEV9vjqOXAev2JLmiaA1eQ7SD7k4d14zDCXkNsJysmQmRC6t9ePZugo/PKKrFKnqFlH6uITE53P1nXyrmyNKGyoV9RnkKQlDpKOUFKDKpBpJaHzsLcPuvZhHbL9A6w4qMuOS+Cc84IUPKxEBTU5M6zu5qWeZmtYoh47ThiTIgCafsflcSI0rs3bCvJ3G3WaynkpKAbXe0iqTN1I2g9ZrVyWYnMdFs6uVo8tIPk0pbibA+pGbZbYqCEMtupVf2SzMb3x5IJK+qTl0X5nMX+nn55RPeVKTugtdnblIzjDU3ujZkOZ+2ehUbWZQess0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cp/m3prycoWQSVh1wAbDpyPLIXjX8NhxH+0sxWPQdU=;
 b=Wh0F8b3N+lnTD9ZvU4RJ1rOm/PldK2LGYmxnb5lWdrXbrybubwGs2wophK2Ji6z7ZVpze1hL2GIrU6VNh6HiuCiyEpQQn/vNdG0BKEOQ3INhc92kOl/BU3rO551ovsGMCSG75UV+19nkGVINtlf4zlzHrJ6l0Fe8ArxJiRuwmAY=
Received: from BY5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:1d0::12)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 23:40:20 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::e0) by BY5PR04CA0002.outlook.office365.com
 (2603:10b6:a03:1d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Sat, 13 Apr 2024 23:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 23:40:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 13 Apr
 2024 18:40:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amd/swsmu: add smu14 ip support
Date: Sat, 13 Apr 2024 19:39:39 -0400
Message-ID: <20240413233945.4002886-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: b6555cc3-a9c5-4a8c-f35b-08dc5c1314b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ygjy8pO/1GAlcPzXqtnEDvoF1r4Vc5PDo36RpeDYu+uv7c8r47WEWMVru82BjFCloqZM5aBGHNVWZOj6pJE9DN9tWHvS3g5VcURV4uSrIthSf98NlNHR1x+3PNHR/AZ/enqQdpAXR2gzZcbtJvBgzE9RjgM8jJB8JnPY31vwWCMbf2FFzLqCIcz/sjmmq++mBdqjQHaOhY9BvYtzPDbXXOlwU05J8nwyNjRSW0jfQi34DSv5786e9J15zXmJ75NvNwP/iwAEPn4SWfBWRA+SB+CcP4TsXPlOiAW8au7KEiRbppquJHDra5eNVz+yDdUlJYfgUfZ3Q7QPjAxGno2QmV6qvovdZxCKLyfNvuyj21XI77vBA/A9nb1RKHF9V0pZ4QrWsqwjG7klp9/CUhrLRI21NhKd0Jn31vzqV2F2AiIZs+08f+npyuT4FSwaD8+KKx55q8Me6QzvclrwnWLBjcZwh8Bhq5k+fU9s5rMULXyNd+Zh+RaezgoBQ8/o9L5US7qxoiDBRV1u8Fsgp6wHqj8Wq1SUHovAu278gOaCSXfwENKWip8Jbr77QEPD3SptJL02Td0iWWHNv927BfljaYlj8LJmMzV1EaNn3ejVIZZGqtBGHEVs+Wadt1eCnKSK2iyZHRlTU29a4OtJbYiEQ4PJUc3pYSFg1D6e0glzyyCMuzFc8k5uJgWBsX0siJAtw7fy3O4os9KyLNwDaTNoT5plWifpq0WVHR7TYJGM2Whz28lPjrKSj43gG9vKCAAm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 23:40:20.0342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6555cc3-a9c5-4a8c-f35b-08dc5c1314b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
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

From: Kenneth Feng <kenneth.feng@amd.com>

Add initial swSMU support for smu 14 series ASIC.

v2: rebase (Alex)

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 77 +++++++++++++------
 2 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 6cdfee5052d9a..be5b24d3dabdb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -39,7 +39,8 @@
 #define MP1_SRAM			0x03c00004
 
 /* address block */
-#define smnMP1_FIRMWARE_FLAGS		0x3010028
+#define smnMP1_FIRMWARE_FLAGS_14_0_0	0x3010028
+#define smnMP1_FIRMWARE_FLAGS		0x3010024
 #define smnMP1_PUB_CTRL			0x3010d10
 
 #define MAX_DPM_LEVELS 16
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 2c3517397b141..33fc0331fac2d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -38,8 +38,13 @@
 #include "amdgpu_ras.h"
 #include "smu_cmn.h"
 
-#include "asic_reg/mp/mp_14_0_0_offset.h"
-#include "asic_reg/mp/mp_14_0_0_sh_mask.h"
+#include "asic_reg/mp/mp_14_0_2_offset.h"
+#include "asic_reg/mp/mp_14_0_2_sh_mask.h"
+
+#define regMP1_SMN_IH_SW_INT_mp1_14_0_0			0x0341
+#define regMP1_SMN_IH_SW_INT_mp1_14_0_0_BASE_IDX        0
+#define regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0            0x0342
+#define regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0_BASE_IDX   0
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -52,6 +57,7 @@
 #undef pr_debug
 
 MODULE_FIRMWARE("amdgpu/smu_14_0_2.bin");
+MODULE_FIRMWARE("amdgpu/smu_14_0_3.bin");
 
 #define ENABLE_IMU_ARG_GFXOFF_ENABLE		1
 
@@ -59,7 +65,7 @@ int smu_v14_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	char fw_name[30];
-	char ucode_prefix[15];
+	char ucode_prefix[30];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
 	const struct common_firmware_header *header;
@@ -106,7 +112,6 @@ void smu_v14_0_fini_microcode(struct smu_context *smu)
 
 int smu_v14_0_load_microcode(struct smu_context *smu)
 {
-#if 0
 	struct amdgpu_device *adev = smu->adev;
 	const uint32_t *src;
 	const struct smc_firmware_header_v1_0 *hdr;
@@ -131,8 +136,12 @@ int smu_v14_0_load_microcode(struct smu_context *smu)
 		    1 & ~MP1_SMN_PUB_CTRL__LX3_RESET_MASK);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		mp1_fw_flags = RREG32_PCIE(MP1_Public |
-					   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
+			mp1_fw_flags = RREG32_PCIE(MP1_Public |
+						   (smnMP1_FIRMWARE_FLAGS_14_0_0 & 0xffffffff));
+		else
+			mp1_fw_flags = RREG32_PCIE(MP1_Public |
+						   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
 		if ((mp1_fw_flags & MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
 		    MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
 			break;
@@ -142,9 +151,7 @@ int smu_v14_0_load_microcode(struct smu_context *smu)
 	if (i == adev->usec_timeout)
 		return -ETIME;
 
-#endif
 	return 0;
-
 }
 
 int smu_v14_0_init_pptable_microcode(struct smu_context *smu)
@@ -198,7 +205,11 @@ int smu_v14_0_check_fw_status(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t mp1_fw_flags;
 
-	mp1_fw_flags = RREG32_PCIE(MP1_Public |
+	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
+		mp1_fw_flags = RREG32_PCIE(MP1_Public |
+					   (smnMP1_FIRMWARE_FLAGS_14_0_0 & 0xffffffff));
+	else
+		mp1_fw_flags = RREG32_PCIE(MP1_Public |
 					   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
 
 	if ((mp1_fw_flags & MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
@@ -227,16 +238,15 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 		adev->pm.fw_version = smu_version;
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-	case IP_VERSION(14, 0, 2):
-		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_2;
-		break;
 	case IP_VERSION(14, 0, 0):
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
 		break;
 	case IP_VERSION(14, 0, 1):
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_1;
 		break;
-
+	case IP_VERSION(14, 0, 2):
+		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_2;
+		break;
 	default:
 		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
 			amdgpu_ip_version(adev, MP1_HWIP, 0));
@@ -738,9 +748,9 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
 	struct amdgpu_device *adev = smu->adev;
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
+	case IP_VERSION(14, 0, 2):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
@@ -841,9 +851,15 @@ static int smu_v14_0_set_irq_state(struct amdgpu_device *adev,
 		// TODO
 
 		/* For MP1 SW irqs */
-		val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
-		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 1);
-		WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, val);
+		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0)) {
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 1);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0, val);
+		} else {
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 1);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, val);
+		}
 
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -851,14 +867,25 @@ static int smu_v14_0_set_irq_state(struct amdgpu_device *adev,
 		// TODO
 
 		/* For MP1 SW irqs */
-		val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT);
-		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID, 0xFE);
-		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VALID, 0);
-		WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT, val);
-
-		val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
-		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 0);
-		WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, val);
+		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0)) {
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_mp1_14_0_0);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID, 0xFE);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VALID, 0);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_mp1_14_0_0, val);
+
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 0);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0, val);
+		} else {
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID, 0xFE);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VALID, 0);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT, val);
+
+			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
+			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 0);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, val);
+		}
 
 		break;
 	default:
-- 
2.44.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9341C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 07:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5804610EF17;
	Wed, 15 Jul 2026 07:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AKsiO1gt";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9884010EF17
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 07:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqYmGp64DN9wT8oIEYJbLVjS/Lqcrlw8/r85POQESPgeobSZmlcUCOzf9meTfcmDAPaOBg5FXaK+a9bu24eNwPmvU81W2mEBMjlQOFrLrLhiSM7vBDvo0wlIeSe/+rDgm8cooHFbME1D2qHVYQS8VwVa8uAcC7iWB90+De+li9l8R3SYQjbGBuR2mp6Cg5ItMamOr/NdTi7/ElFEs0S56y2TAZCFaGLmvI+KWcVNv+4/mf8EOYmye1CD910KL3auMYCnnfXfD8P+l8+SJIQ6SYQpCHYf8pzo3SBVXlNx008oxwPz0sTFAo/kQ6vlDAenI7VnyIswARqphS8msfYWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpcqOw4TpmPYSrrFT/Rn7PFesnIscTzA6YwPYccaDwI=;
 b=USU5UFY6qrsS/zR+o1CmDa9nt+LL0MhZGZUFAmxoz70z3RHs4l8KesOyTelwzsiRXSYyrSh6w++tdNFE3phzz5vXGsIN06AMUsT1YjlRjboQ9Lv7V5FhKMaJlAQKGmtDtNYtn5jBOgjscpnZIclmvE+cAoq8JTaispN8WzDnyhkJA44adkFw50ljG1B7scXHsr1qRO23pCpP37ETAP/cSjc8ZUv8wJtSkaAKxfzbz4RDDOlDAF9DZYfUd56q54KMTf1o9y0sx/0gb3Bom3zabWxxvzjFzimoAGIDyme2ki19MytaIf4Qy9cMBJecdY/672PVL3xYtC90HnDzQe9vcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpcqOw4TpmPYSrrFT/Rn7PFesnIscTzA6YwPYccaDwI=;
 b=AKsiO1gtYGrUIQHJI+VLPeEvZljfZi7XZPlM3SHRYgUbRZgbMOrhpP1jmxqpiVLTTcWm8/f3eAtry13NM1MM/j7hshpS9U9CpxRKmk1y0Fy7zYklZ6VkyNJp6Ivwz3JyjhRnNdLhm9JYiRwgKh5moFHdruDrIPjfivFd/8gOjdI=
Received: from BL1P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::28)
 by SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 07:47:48 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::4) by BL1P221CA0008.outlook.office365.com
 (2603:10b6:208:2c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 07:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 07:47:47 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 02:47:46 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/5] drm/amd/ras: update flip bit setting for uniras
Date: Wed, 15 Jul 2026 15:47:31 +0800
Message-ID: <20260715074734.2668631-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715074734.2668631-1-tao.zhou1@amd.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SN7PR12MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: a93b3d45-ec34-4a8e-22dd-08dee2455d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: GQj0+u4g0duo3g8mKcgNXTTaew1XCpji1FIIyv74Ip68jjlY7RkpsuAsB4FFiLdT0u85iByZXtHOel+9eGCtWhvP083JQHtNZMwHB5AK3dI2OcVtqrd0G+HIyxK/SGSq+WyrOIeNR93TiQxAd39Xfi70szevSqZjQgURDdATgbtp5IeG7jk3x6exSJH2+KKn28xjnro6lX+WSyABOF/hMuiBg9mqXJoj53tEUcMFtIodPZcMeSRkFAVFGx6SoEGxfcxoYrPgq9JS39gyltmhkqOGCxdOWBPXYr+tnPwp4Pn+RFfawGhdhKyXBvMflCwFPcG3eGei/c/AvTMWzPAQLnrPygOP6W35MdgjANSOoKvZnabCOmX9IIzvIv7sSOGmjAas+sQTFbYm09JrKC+zSYUTRKn8CMuwBbyTSlKUcFkoaccxklX6ZeWx9mEXs7tlz2MSXkQ2DHS58Tt4w7Oq29deNr5qB2T1M7gMBGAJimgA/xz8dierv0DZZaKE33l/VKhY9hu6VDrwYrsPpgyyCKSK/KlKVOyzO7n5bSbH4V0aDvv+3koVIVxRzRQ4yiZJVT/6rsiMcKhXHJR893MQdfjUNE9GDDkEjXenGVtZSauhRX+72f+CCG2YpEjtqGftX122PMQnO2D8tJbc5OJYYReMLwHUSF3Xu1Z64S0aPKboSS7TjSkfBSaQgQs/HSt/RbxPWqfIYNnJsbMbzIhIuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1rtvxcVuFEUg6ICwntzTXeQPDe548xjV+TgYMPYQGewsK69O8EE6+15sBmOzBjf76ZfUwjvJnnyvz809+UcFnwf4ull9Jm0HMs8NqXrWT5wW9w5hGFbMlf31JaBWhKH9QBq6fAUhSpMx5vPcUBcLXDxqkG2M6Fv7CAwG77R5T8bTAGdHGmdTwfoFkOqaDglihGb4+iFPYQSkNw0i/KptG5f4zbA2BJqDAx+tG1ELkVZzujkXYxjdwZuZbebw+0OBW1SGjxVfe9Ke+tCA04ULeZ7gvDtNxqc1nhxzQsOETDEPo5wlr9jwBzo9UfwyJhc6exL+Zf/ToUube+tZFBiB6y5OIG3BerCxgXhO559zQ59sz4Q+xlrSF2l++eigxrYGDC6gAnxUp65Fq8kxMPwSbdgEwtkM/ZRTn+ZRGfJw/BE6P5k+e/AN4Dp19Nir58/B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:47:47.5637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93b3d45-ec34-4a8e-22dd-08dee2455d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909
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

The flip bit setting is different if umc number is half of original
configuration.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |   1 +
 drivers/gpu/drm/amd/ras/rascore/ras.h         |   1 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     |   1 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |   1 +
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   | 114 ++++++++++++------
 5 files changed, 84 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 60412da69b2b..c55288c2df9a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -284,6 +284,7 @@ static int amdgpu_ras_mgr_init_umc_config(struct amdgpu_device *adev,
 	struct ras_umc_config *umc_cfg = &config->umc_cfg;
 
 	umc_cfg->umc_vram_type = adev->gmc.vram_type;
+	umc_cfg->num_umc = adev->gmc.num_umc;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 5869bad978b0..5719bc1b6167 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -277,6 +277,7 @@ struct ras_psp_config {
 
 struct ras_umc_config {
 	uint32_t umc_vram_type;
+	uint32_t num_umc;
 };
 
 struct ras_eeprom_config {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index e366fb97293e..dd7a37163110 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -691,6 +691,7 @@ int ras_umc_hw_init(struct ras_core_context *ras_core)
 	ras_umc->umc_err_data.umc_nps_mode = nps;
 
 	ras_umc->umc_vram_type = ras_core->config->umc_cfg.umc_vram_type;
+	ras_umc->num_umc = ras_core->config->umc_cfg.num_umc;
 	if (!ras_umc->umc_vram_type) {
 		RAS_DEV_ERR(ras_core->dev, "Invalid UMC VRAM Type: %u!\n",
 			ras_umc->umc_vram_type);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index ee7100f25f51..71b6703193f5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -137,6 +137,7 @@ struct ras_umc_err_data {
 struct ras_umc {
 	u32 umc_ip_version;
 	u32 umc_vram_type;
+	u32 num_umc;
 	const struct ras_umc_ip_func *ip_func;
 	struct radix_tree_root root;
 	struct mutex  tree_lock;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index b809a2f21d73..809cbd846883 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -64,51 +64,97 @@ static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
 			struct umc_flip_bits *flip_bits)
 {
 	uint32_t vram_type = ras_core->ras_umc.umc_vram_type;
-
-	/* default setting */
-	flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
-	flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
-	flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
-	flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
-	flip_bits->flip_row_bit = 13;
-	flip_bits->bit_num = 4;
-	flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
-
-	if (nps == UMC_MEMORY_PARTITION_MODE_NPS2) {
+	uint32_t num_umc = ras_core->ras_umc.num_umc;
+
+	if (num_umc == 16) {
+		/* default setting */
+		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
+		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
+		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
+		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
+		flip_bits->flip_row_bit = 13;
+		flip_bits->bit_num = 4;
+		flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
+
+		if (nps == UMC_MEMORY_PARTITION_MODE_NPS2) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+			flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
+		} else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
+		}
+
+		switch (vram_type) {
+		case UMC_VRAM_TYPE_HBM:
+			/* other nps modes are taken as nps1 */
+			if (nps == UMC_MEMORY_PARTITION_MODE_NPS2)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+			else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+
+			break;
+		case UMC_VRAM_TYPE_HBM3E:
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+			flip_bits->flip_row_bit = 12;
+
+			if (nps == UMC_MEMORY_PARTITION_MODE_NPS2)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+			else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
+
+			break;
+		default:
+			RAS_DEV_WARN(ras_core->dev,
+				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
+			break;
+		}
+	} else if (num_umc == 8) {
+		/* default setting */
 		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
 		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
 		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+		flip_bits->flip_row_bit = 12;
+		flip_bits->bit_num = 4;
 		flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
-	} else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4) {
-		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
-		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
-		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
-		flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
-	}
 
-	switch (vram_type) {
-	case UMC_VRAM_TYPE_HBM:
-		/* other nps modes are taken as nps1 */
-		if (nps == UMC_MEMORY_PARTITION_MODE_NPS2)
+		if (nps == UMC_MEMORY_PARTITION_MODE_NPS2) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
+		}
+
+		switch (vram_type) {
+		case UMC_VRAM_TYPE_HBM:
 			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-		else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4)
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
 
-		break;
-	case UMC_VRAM_TYPE_HBM3E:
-		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-		flip_bits->flip_row_bit = 12;
+			/* other nps modes are taken as nps1 */
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
 
-		if (nps == UMC_MEMORY_PARTITION_MODE_NPS2)
+			break;
+		case UMC_VRAM_TYPE_HBM3E:
 			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-		else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4)
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
+			flip_bits->flip_row_bit = 12;
+
+			if (nps == UMC_MEMORY_PARTITION_MODE_NPS2)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
 
-		break;
-	default:
+			break;
+		default:
+			RAS_DEV_WARN(ras_core->dev,
+				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
+				break;
+		}
+	} else {
 		RAS_DEV_WARN(ras_core->dev,
-			"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
-		break;
+			"Unsupported UMC number(%d), failed to set RAS flip bits.\n",
+			num_umc);
 	}
 }
 
-- 
2.34.1


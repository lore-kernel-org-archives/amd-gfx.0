Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42C6C5DF74
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D30F10F733;
	Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nUC2HmLf";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D170410F72E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/0fx7MQVcTgLgvqnwriVIlBnqEwJsQzDFzzaIXnOkMMeahTzLb35/sPi4uTQRVa7Kv6ivSkcAa7abQuqUckBwpHxcfoGV/kMe91jOujw/rFs/cYc7zOu4pBz2VaOt0UX9eAFnXA8D02sjeOJaBnjNyHhQeMTG11oBfmBBClD/iXpvd7gdM5lwcTkcq+dmutFKGr0KDgsB52Zxy3zi2WZtG0l8mPzeTgKsd6tUQHF3XHCaNxKRRCi0Gi8Uu8O2rwJX53I7RKuMCGEFLxNlrV2WA8VsQlavJ5EhSGDMaddKr1TRVxUL6vQEix82llDBhDUt3X1sgicU199KFNitRauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2000zyF2b11ZPwatVAJxJ4STrxGAbW76mqEqNOsjV7Y=;
 b=XGFh+FChu2n0wKfshKOEuSjrSS7HuaWRXtnaCMRRN0JJhakkeJL8r7XQ8dqN4pcx0jhO7zzABm2iQ+8Yij2yBNGPI2cE8zqiqGM/EztCuNLIpgVfOBq9ieyI1fbBQnOJOfJ1i8WgorLTyBRIRGzUFJ/hftBPd683Wd+YuO825UKIjZmWWj+x/psKjV1aFT72xSpiIizYNS7PQD35nPHpWiGTMvxca6VgDo89bt+yk2k2B87n9PjzcHTze+NdkznICk17hnPEhyYf7DITAXGlqFhWYJ3/erHeoQbngcpFrznaAfldIQ6BqpKym2EIYlnNpYz5FvoK5vdYdLz2cXN29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2000zyF2b11ZPwatVAJxJ4STrxGAbW76mqEqNOsjV7Y=;
 b=nUC2HmLf1Ejp1VDgsLF+4zPxonJW66bzi/sNLsQEFdCO2udmpZ157Rq/vfoDp1GVMrqvWE88nWYtIheTtq6rkE364tmHknZa9IErFiXAtZZQQJp6Zh/ZU0T0wfBT5ujNL5pKScC3HyNA+TqOWW0xFk/Ho6jxCXFa4363RMMroJo=
Received: from BN0PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:143::28)
 by SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 14 Aug
 2026 21:03:54 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::7b) by BN0PR10CA0027.outlook.office365.com
 (2603:10b6:408:143::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 088/109] drm/amd/ras: add module parameter for uniras
Date: Fri, 14 Aug 2026 17:02:25 -0400
Message-ID: <20260814210246.3067612-89-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SA5PPF80B25317E:EE_
X-MS-Office365-Filtering-Correlation-Id: eea0ab5d-9dd7-4bcf-3c6d-08defa478cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: vnnkiYg0xA7RX9DSQ8Dp55zcOAqSI9JsDf9xjY5lg+GRh9iVQqJxyft7ciTk8KelLrpKiWtiwKFfJSwoYGgQ/M27TVDYJHNChcRaYlFBpqeyC4XUeEqH3QRkso9QNK62ZhXvumjMWEN2OB+wmS0w9aXeJygD1sB9couHXFPDd5wV8wMVCz8t94rKNDmedkSNnueDKquQjXn6SEOi869+b7SVZSudrKOOxioWNJrZRE68rnbOtlibYZF+6Xku8zQ4ampxSJUnddrm237yBWXmC0UaKrLsn86EzJKcLthFiXKaPoZlc3lDthmClRxXqMB960HEboJ7ytbjce3PxOOUI9avvTEdj29X3Fb9VUw5JIx7UeBF+EkxhSdZ07bq87KeR1PL9LKFeR+NuemiJw66vNjX2W8+rKe3sLrAlBQuL2F0tHiFt9tXcwXqFCyIIXM5X94VLSphRSfogr3+kQsJjOpY1ShM7+CD3WV2E7atHdws/5IEUir8yJgDrsfHw/waQEreKO1nAFhNQFBwQ2es+ZMV8OSDHtlU6cOMtQxdqd14xd0Jn3XrE4hbDxP3alu2xwTgkqahtjCF7bUAKZ8ZslzqqTWAVXc4sSozR5iOr/LOdNdjdM0ubiMejfWrXM5O2af2SAvyVpKig6PZhu65GZycNzE9gViwtvJxmATgqY/vTjuisnYOE2rO4tfsvyzCFDiK2pviMWo4tqmPhrMAQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2aKRrg2g+V0ZemKAvO77mbMHyhe5OpYxNZowyRgOofrQ0inhOXngSt4WdrK9tez2yxn3uOcYhAh/fJ6HlreFZevP3XT/xLcL4x5LpPUvgV3M9vZg2KgNZwAtYO745loOOzX04jcXDxzEPC/9PY/kDi6xoDMrWPLzxbyjD9VmhpxzZ6XpzTIYriLtgSeMmS+cC/olNZgrskLV7MYhIEnlFNFniCbPeYpqLZah/02g1aTo50xPpGcgpGzlbAo1dricy6z6PQGrSCLCyWYp1u7suWEf1cDWEouqIhCK/A+hb1+Suhqkk2AOoueLg45K0KjWYMbsyrg3ktSlkjHWrFGNXPXxcNN3hQK5wPIcE+mwpG/bUwYKX0/2gHnyaZq6QRleGrqN6vitSdfEdEXgFod1zhKYL/rQZnKLVSDXwNapiHKzA1rOHODFKGRT7Ya4+KsP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:54.5585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea0ab5d-9dd7-4bcf-3c6d-08defa478cdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF80B25317E
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add module parameter for uniras.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  6 +++-
 drivers/gpu/drm/amd/ras/core/core.c           | 20 +++++++++++-
 drivers/gpu/drm/amd/ras/core/ras.h            | 11 +++++++
 .../amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c   | 27 +++++++++++-----
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 31 ++++++++++++++++---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  3 +-
 6 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 13297b6f062b6..4def1bf489c3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3570,6 +3570,7 @@ static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device *adev)
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_module_param param = {0};
 	int r;
 
 	if (con)
@@ -3593,7 +3594,10 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_check_supported(adev);
 
-	amdgpu_ras_mgr_sw_init(adev);
+	param.ras_feature_enable = amdgpu_ras_enable;
+	param.ras_feature_mask = amdgpu_ras_mask;
+	param.ras_bad_page_threshold = amdgpu_bad_page_threshold;
+	amdgpu_ras_mgr_sw_init(adev, &param);
 
 	if (!con->uniras_enabled &&
 	    (!adev->ras_enabled || adev->asic_type == CHIP_VEGA10)) {
diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index 662a3a17a6b6a..e03f6889e1db5 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -783,14 +783,21 @@ int ras_core_get_eeprom_version(struct ras_core_context *ras_core,
 uint64_t ras_core_get_ras_caps(struct ras_core_context *ras_core)
 {
 	uint64_t ras_hw_caps,  ras_drv_caps;
+	struct ras_module_param param = {0};
 
 	if (!ras_core)
 		return 0;
 
+	if (ras_core_get_module_param(ras_core, &param))
+		return 0;
+
+	if (!param.ras_feature_enable)
+		return 0;
+
 	ras_hw_caps = ras_psp_get_hw_ras_caps(ras_core);
 	ras_drv_caps = ras_aca_get_parser_caps(ras_core);
 
-	return ras_hw_caps & ras_drv_caps;
+	return ras_hw_caps & ras_drv_caps & param.ras_feature_mask;
 }
 
 bool ras_core_poison_supported(struct ras_core_context *ras_core)
@@ -826,3 +833,14 @@ int ras_core_eeprom_early_init_service(struct ras_core_context *ras_core)
 
 	return ras_core_eeprom_recovery(ras_core);
 }
+
+int ras_core_get_module_param(struct ras_core_context *ras_core,
+		struct ras_module_param *param)
+{
+	if (!ras_core || !ras_core->config || !param)
+		return -EINVAL;
+
+	memcpy(param, &ras_core->config->mod_param, sizeof(*param));
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 238a587447ff4..6ae23a677f57b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -350,6 +350,13 @@ struct ras_eeprom_config {
 	const struct ras_eeprom_sys_func *eeprom_sys_fn;
 };
 
+struct ras_module_param {
+	/* driver installation option parameter */
+	int ras_feature_enable;
+	u64 ras_feature_mask;
+	int ras_bad_page_threshold;
+};
+
 struct ras_core_config {
 	u32 aca_ip_version;
 	u32 umc_ip_version;
@@ -370,6 +377,8 @@ struct ras_core_config {
 	struct ras_psp_config psp_cfg;
 	struct ras_eeprom_config eeprom_cfg;
 	struct ras_umc_config umc_cfg;
+
+	struct ras_module_param mod_param;
 };
 
 struct ras_core_context {
@@ -478,4 +487,6 @@ bool ras_core_poison_supported(struct ras_core_context *ras_core);
 bool ras_core_in_early_init(struct ras_core_context *ras_core);
 bool ras_core_early_init_service_enabled(struct ras_core_context *ras_core);
 int ras_core_eeprom_early_init_service(struct ras_core_context *ras_core);
+int ras_core_get_module_param(struct ras_core_context *ras_core,
+		struct ras_module_param *param);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
index 14817de696a39..d2c9fc525af57 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
@@ -81,9 +81,12 @@ static int ras_eeprom_i2c_config(struct ras_core_context *ras_core,
 		struct ras_eeprom_param_config *cfg)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct ras_module_param mod_param = {0};
 	u64 badpages, badpages_per_record = 0;
 	u8 i2c_addr;
 	u32 ip_version;
+	int badpage_threshold = 0;
+	int ret;
 
 	ip_version = amdgpu_ip_version(adev, MP1_HWIP, 0);
 
@@ -136,8 +139,16 @@ static int ras_eeprom_i2c_config(struct ras_core_context *ras_core,
 		}
 	}
 
+	ret = ras_core_get_module_param(ras_core, &mod_param);
+	if (ret) {
+		RAS_DEV_ERR(adev, "Failed to get module option parameter.\n");
+		return ret;
+	}
+
+	badpage_threshold = mod_param.ras_bad_page_threshold;
+
 	/*
-	 * amdgpu_bad_page_threshold is used to config
+	 * badpage_threshold is used to config
 	 * the threshold for the number of bad pages.
 	 * -1:  Threshold is set to default value
 	 *      Driver will issue a warning message when threshold is reached
@@ -152,21 +163,21 @@ static int ras_eeprom_i2c_config(struct ras_core_context *ras_core,
 	 *      A user-defined threshold is set
 	 *      Driver will halt runtime services when this custom threshold is reached.
 	 */
-	if (amdgpu_bad_page_threshold == NONSTOP_OVER_THRESHOLD) {
+	if (badpage_threshold == NONSTOP_OVER_THRESHOLD) {
 		cfg->work_mode_over_thresh = RAS_WORK_MODE_OVER_THRESH_NORMAL;
 		badpages = ESTIMATE_BAD_PAGE_THRESHOLD(adev->gmc.mc_vram_size);
-	} else if (amdgpu_bad_page_threshold == WARN_NONSTOP_OVER_THRESHOLD) {
+	} else if (badpage_threshold == WARN_NONSTOP_OVER_THRESHOLD) {
 		cfg->work_mode_over_thresh = RAS_WORK_MODE_OVER_THRESH_STRICT;
 		badpages = COUNT_BAD_PAGE_THRESHOLD(RAS_RESERVED_VRAM_SIZE_DEFAULT);
-	} else if (!amdgpu_bad_page_threshold) {
+	} else if (!badpage_threshold) {
 		cfg->work_mode_over_thresh = RAS_WORK_MODE_OVER_THRESH_DEBUG;
 		badpages = 128;
-	} else if (amdgpu_bad_page_threshold > 0) {
+	} else if (badpage_threshold > 0) {
 		cfg->work_mode_over_thresh = RAS_WORK_MODE_OVER_THRESH_RMA;
-		badpages = amdgpu_bad_page_threshold;
+		badpages = badpage_threshold;
 	} else {
-		RAS_DEV_ERR(adev, "Invalid amdgpu_bad_page_threshold value(%d)\n",
-			amdgpu_bad_page_threshold);
+		RAS_DEV_ERR(adev, "Invalid badpage_threshold value(%d)\n",
+			badpage_threshold);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ccfa213816da7..bda1f76d2dbf9 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -81,6 +81,24 @@ static void amdgpu_ras_mgr_init_event_mgr(struct ras_core_context *ras_core)
 		amdgpu_put_xgmi_hive(hive);
 }
 
+static int amdgpu_ras_mgr_init_module_param(struct amdgpu_device *adev,
+		struct ras_core_config *config, struct ras_module_param *param)
+{
+	struct ras_module_param *mod_param = &config->mod_param;
+
+	if (param) {
+		mod_param->ras_feature_enable = param->ras_feature_enable;
+		mod_param->ras_feature_mask = param->ras_feature_mask;
+		mod_param->ras_bad_page_threshold = param->ras_bad_page_threshold;
+	} else {
+		mod_param->ras_feature_enable = -1;
+		mod_param->ras_feature_mask = U64_MAX;
+		mod_param->ras_bad_page_threshold = -1;
+	}
+
+	return 0;
+}
+
 static int amdgpu_ras_mgr_init_aca_config(struct amdgpu_device *adev,
 		struct ras_core_config *config)
 {
@@ -250,7 +268,8 @@ static int amdgpu_ras_mgr_init_umc_config(struct amdgpu_device *adev,
 	return 0;
 }
 
-static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_device *adev)
+static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_device *adev,
+			struct ras_module_param *param)
 {
 	struct ras_core_config init_config;
 
@@ -278,6 +297,7 @@ static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
 		amdgpu_ras_is_poison_mode_supported(adev);
 	init_config.ras_debug_mask = amdgpu_debug_mask;
 
+	amdgpu_ras_mgr_init_module_param(adev, &init_config, param);
 	amdgpu_ras_mgr_init_aca_config(adev, &init_config);
 	amdgpu_ras_mgr_init_eeprom_config(adev, &init_config);
 	amdgpu_ras_mgr_init_mp1_config(adev, &init_config);
@@ -288,7 +308,7 @@ static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
 	return ras_core_create(&init_config);
 }
 
-int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev)
+int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev, struct ras_module_param *param)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_mgr *ras_mgr;
@@ -300,7 +320,10 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev)
 	/* Disabled by default */
 	con->uniras_enabled = false;
 
-	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
+	/* Disable ras via driver installation option */
+	if (param && !param->ras_feature_enable)
+		return 0;
+	else if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6))
 		con->uniras_enabled = true;
@@ -317,7 +340,7 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev)
 	con->ras_mgr = ras_mgr;
 	ras_mgr->adev = adev;
 
-	ras_mgr->ras_core = amdgpu_ras_mgr_create_ras_core(adev);
+	ras_mgr->ras_core = amdgpu_ras_mgr_create_ras_core(adev, param);
 	if (!ras_mgr->ras_core) {
 		RAS_DEV_ERR(adev, "Failed to create ras core!\n");
 		ret = -EINVAL;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 32416c9d6086e..442d628ccfece 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -61,7 +61,8 @@ struct amdgpu_ras_mgr {
 
 extern const struct amdgpu_ip_block_version ras_v1_0_ip_block;
 
-int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev);
+int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev,
+		struct ras_module_param *param);
 int amdgpu_ras_mgr_sw_fini(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_early_init_service(struct amdgpu_device *adev);
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
-- 
2.55.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A11C7EE2E
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Jun 2023 10:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA0010E0D3;
	Sun, 11 Jun 2023 10:46:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2030D10E0D3
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Jun 2023 10:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlL1dRSOMXWWtWgGT65XNQw3Xyqd7acwNW/lrxDHBWKnFyZrzp0pCVQ5y/+jjrOMt3Hwa/pDt4fsXcC2RlgMsNSV3hcKXW5VffB8eGtRPtM6R1F49LkBLVDh47LZdO2YzIuYxzcv0BzHz3ZyfGhMiyQgH2wkh0YpmJx+uPZ+c245YGuXGLu4kc+3ufw2UVTNDQPhFd91r3qq8O1t4p1ST8xr7DLRfr2riuLou9s2BlOi9cM3FD06ow2Jr1w8/0hKWCH4ga7DTpp+weog1wEBHomtuHafoh7q9YQVrgotCKHJgfdQfankkh024hWReUabf3y+PY07CdFrzYaLYDyp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GJ9wZps7b4AYxvJDxyNKWSLt1dmByL1Cg2Rx+r807c=;
 b=Jndv4khtiLXVxawSoSwz2yVfM7hz5Isca4Zn2pr2PPkGfmBIaxjrSerzklaN1b4YnSXmQ91N3BzTCZge44R2Qfkw3dAqbVJTTV6eIyAW4Kkec3RIdPg7fVsd0CcDgBWqT/I7zOoRrE+sfhmSTo7yr+StiIqAE2vSBV4jAi3ZliguLVcGSW9hHlIX0r4Cgvk5g0gXAkiFcm/OInj6fW9ilpIqI6HeKh1+R/upUiGHRjwcFGsFRnXdy/WbK6YsLLIncx6q667DcyVA87o8mFYS/1ZwF8k7zSgXIKgdnjTtx0HCoCpgv3JYxrnG0e6615QxmfqKsKoLpr/CFZcUjHOLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GJ9wZps7b4AYxvJDxyNKWSLt1dmByL1Cg2Rx+r807c=;
 b=JIxriP0JmpJgXLt3ryXQWJ7hcvoLC8zu3WUoIdOoSerGzv4t6C833hxgLuYZtVRhHWb5kavACAyVjcih9N1/C2ivo5K8jAIEb2zuvnOc1lm+Y2Jw6PFLiOCgBZ8ENHfq1bxGmVEi2RR1ja7fbcwAuphtHKpnT0gF4bWsDg7aQKk=
Received: from DS7PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:3b5::35)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sun, 11 Jun
 2023 10:46:16 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::a9) by DS7PR03CA0060.outlook.office365.com
 (2603:10b6:5:3b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.31 via Frontend
 Transport; Sun, 11 Jun 2023 10:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Sun, 11 Jun 2023 10:46:15 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 11 Jun 2023 05:46:12 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Stanley Yang <Stanley.Yang@amd.com>,
 Candice Li <Candice.Li@amd.com>, Thomas Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable gfx v11_0_3 ras if poison mode is
 supported
Date: Sun, 11 Jun 2023 18:45:46 +0800
Message-ID: <20230611104546.7383-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230611104546.7383-1-Hawking.Zhang@amd.com>
References: <20230611104546.7383-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7f93cc-00ea-45fa-ed78-08db6a6914f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ha/zZlxzAiCdzZL5JlwHH70WpH5+hBVaUL55YnDvFrZfcltXahJIqb5brBPZJMde6zCxiwCwVuWGkBHOg6FyFz+pdFKV379bdM8kpQV4JCJ1qXfLcpGrM2ZUQjAXP6uMPHRTbyON1taGLoSKTuWKI7g8qKNpn4+Ivj/rwtvE8e+XastT0D/ZDvg1b4ImAwyR0/mV4j3BFOnPP/oaZT0ilKkeW9HJtlJxSIBskMInMiVdeN/G47x5GsXb6GfoOF5oH1MLAehEbsnx10dIFGve2K5ibtGDIgp+ab3k9zTO5cKfIEZoKIs1Wy/BsW7kFvEglZ8T5uiqRpP6Mg1SnSsYPcja7SM0xW1t2bswmD2w5JtMzsyCHJx9MbRYTEvntdMD4s+eyUaRwV0PYt3NoAgY6NAH57gQwbY6h1nWtAt3l83eFoerhxf9+22JcQg4131ZZiVzPxUf43OWJuU6SdJ8Q+KCP324rbnPLEWnsaWIGZTLGOl0FJxRHEALh6139GI7xHm2ISrhdakG+xTsFK80XrDQetwssjVJK3R2k7TCF6dOY+0c41UA3iWYVu3cNgTtXOrBZjSZ7fz8ELl717Cn6veiJHEMMdOtfuJMu5Mh+xn0K42GFy/pxtL3nQqlncbAlby31VPU5blRX2D82XsUqN4Gcnl6l9YXlqDuLE2b0jB6yzMkZXdLi+dBaBCn8QMVeDScUtsdzUKubvDDDCnu3/UE9tpV3f13ual7q8wBDMxoafIDd1pfVo1PeUaqpOHsCafNjxGSq3FKAmj2Fu1I6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(1076003)(26005)(16526019)(186003)(2616005)(426003)(47076005)(83380400001)(36860700001)(82310400005)(336012)(6666004)(356005)(81166007)(2906002)(82740400003)(70206006)(70586007)(41300700001)(7696005)(40460700003)(5660300002)(8936002)(36756003)(8676002)(110136005)(86362001)(478600001)(316002)(40480700001)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 10:46:15.7866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7f93cc-00ea-45fa-ed78-08db6a6914f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX v11_0_3 ras needs to be enabled if poison mode
is supported. Driver doesn't need issue an feature
enable call in gfx_v11_0 late init phase. The ras
late init call is already centralized to
amdgpu_ras_late_init.
In addition, move poison_mode check out of common
helper like amdgpu_ras_is_supported and
amdgpu_ras_is_feature_allowed ensure only GFX RAS
is enabled when poison mode is supported.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 49 ++++++++-----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 26 -------------
 2 files changed, 16 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index dd7cdc234d7e..35e70860d628 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -126,6 +126,7 @@ static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
 				uint64_t addr);
 static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 				uint64_t addr);
+static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev);
 #ifdef CONFIG_X86_MCE_AMD
 static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev);
 struct mce_notifier_adev_list {
@@ -757,16 +758,6 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_ras_check_feature_allowed(struct amdgpu_device *adev,
-		struct ras_common_if *head)
-{
-	if (amdgpu_ras_is_feature_allowed(adev, head) ||
-		amdgpu_ras_is_poison_mode_supported(adev))
-		return 1;
-	else
-		return 0;
-}
-
 /* wrapper of psp_ras_enable_features */
 int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 		struct ras_common_if *head, bool enable)
@@ -797,7 +788,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	}
 
 	/* Do not enable if it is not allowed. */
-	if (enable && !amdgpu_ras_check_feature_allowed(adev, head))
+	if (enable && !amdgpu_ras_is_feature_allowed(adev, head))
 		goto out;
 
 	/* Only enable ras feature operation handle on host side */
@@ -2420,9 +2411,9 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 }
 
 /*
- * this is workaround for vega20 workstation sku,
- * force enable gfx ras, ignore vbios gfx ras flag
- * due to GC EDC can not write
+ * Common helpers for device or IP specific RAS quirks including
+ * a). Enable gfx ras on D16406 or D36002 board
+ * b). Enable gfx ras in gfx_v11_0_3 if poison mode is supported
  */
 static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
 {
@@ -2431,10 +2422,16 @@ static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
 	if (!ctx)
 		return;
 
+	/* Enable gfx ras on specific board */
 	if (strnstr(ctx->vbios_version, "D16406",
 		    sizeof(ctx->vbios_version)) ||
-		strnstr(ctx->vbios_version, "D36002",
-			sizeof(ctx->vbios_version)))
+	    strnstr(ctx->vbios_version, "D36002",
+		    sizeof(ctx->vbios_version)))
+		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__GFX);
+
+	/* Enable gfx ras on gfx_v11_0_3 if poison mode is supported */
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 3) &&
+	    amdgpu_ras_is_poison_mode_supported(adev))
 		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__GFX);
 }
 
@@ -2502,6 +2499,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 					   1 << AMDGPU_RAS_BLOCK__MMHUB);
 	}
 
+	amdgpu_ras_query_poison_mode(adev);
+
 	amdgpu_ras_get_quirks(adev);
 
 	/* hw_supported needs to be aligned with RAS block mask. */
@@ -2659,8 +2658,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
 
-	amdgpu_ras_query_poison_mode(adev);
-
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
 		goto release_con;
@@ -3115,26 +3112,12 @@ int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_co
 int amdgpu_ras_is_supported(struct amdgpu_device *adev,
 		unsigned int block)
 {
-	int ret = 0;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	if (block >= AMDGPU_RAS_BLOCK_COUNT)
 		return 0;
 
-	ret = ras && (adev->ras_enabled & (1 << block));
-
-	/* For the special asic with mem ecc enabled but sram ecc
-	 * not enabled, even if the ras block is not supported on
-	 * .ras_enabled, if the asic supports poison mode and the
-	 * ras block has ras configuration, it can be considered
-	 * that the ras block supports ras function.
-	 */
-	if (!ret &&
-	    amdgpu_ras_is_poison_mode_supported(adev) &&
-	    amdgpu_ras_get_ras_block(adev, block, 0))
-		ret = 1;
-
-	return ret;
+	return (ras && (adev->ras_enabled & (1 << block)));
 }
 
 int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 690e121d9dda..11e0c574b9f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4650,26 +4650,6 @@ static int gfx_v11_0_early_init(void *handle)
 	return gfx_v11_0_init_microcode(adev);
 }
 
-static int gfx_v11_0_ras_late_init(void *handle)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct ras_common_if *gfx_common_if;
-	int ret;
-
-	gfx_common_if = kzalloc(sizeof(struct ras_common_if), GFP_KERNEL);
-	if (!gfx_common_if)
-		return -ENOMEM;
-
-	gfx_common_if->block = AMDGPU_RAS_BLOCK__GFX;
-
-	ret = amdgpu_ras_feature_enable(adev, gfx_common_if, true);
-	if (ret)
-		dev_warn(adev->dev, "Failed to enable gfx11 ras feature\n");
-
-	kfree(gfx_common_if);
-	return 0;
-}
-
 static int gfx_v11_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -4683,12 +4663,6 @@ static int gfx_v11_0_late_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 3)) {
-		r = gfx_v11_0_ras_late_init(handle);
-		if (r)
-			return r;
-	}
-
 	return 0;
 }
 
-- 
2.17.1


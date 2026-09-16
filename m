Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4029C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B3A10ECCE;
	Wed, 16 Sep 2026 17:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OweTzZIA";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A6F010ECC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hR+TCtpopx4rW+Kusx4RRypM/W8qlo9x/4pcr6jh3DWfCmgn+2MtalBaldAvZWMwIkWud893TUkXBuzPIHhtkJhCwg8QZ8YnLaKO9hCD8PgpkhSzwMXD8PWl4NFXo95F1DIW9RW3yzy75mu0KHbQW0P4GtufLvRBMN8vWW+QR5GwkQKMUbSoIRVNujmtc44WNviKXpSb2WaWQlfIj21w2b2RmR3GDBXJB/PgIKzzNFE1eWGasHrrSTCJ5Ja8jjusI6SCECIwmHFuQK/1mS4l29nNiN3leeA5bvWnAHKDCnvFPa5MwsVIQ+83u+zK1V12EnqE8Jus6N7niuPeU0mp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DWv47ECP0dIaKsYl3ur6/IOfYYTbuqBjMtt33yzX64=;
 b=nNpY4eu3VaCsLu48nPdaQxEsjpCnm27A/b/K40ao1fgFvyb4xCWo2beuW4/HQq9+C+60sXn9EMnGQ2WBhHdiGHujhiBIA7OPUeiTAzu38WTy3sGJACDA9IEADB659/63e1UBWwN7TysNx7BQkp7d/RRKHrVs7QMsNlNcywz80NJw8UBAn6P2YqnIppQDKSXa7vDV3L/MeL3h9Y4w7IDg5Fz1nNdcpg0hSSO5YDNnDvDJQFTiHKzQXHhchiZfGys7MzjlJ+onTgOpXPA32zvLYmOQrI/ZoIsHWVChdgoD4v9WIfwgxWybEN+DAg3Hro4UemB99AEq+0ToDEqaOxkqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DWv47ECP0dIaKsYl3ur6/IOfYYTbuqBjMtt33yzX64=;
 b=OweTzZIAI3rWW4tN2jIX8b8HpzPyyq3rQJfF6LopKEptTnyKtCfBGu30OfjaYtDOCyv7ThZj7HTLW/9c6m3Hb4232Z5JxrDFUap1cD4KywYiJ2vN9tVmAlAz2D4A//mG0aX+yQnrUcFBEhQ/XBZQajTFF1wuRlOi0HNy1VRrkak=
Received: from CH0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:610:e4::9)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Wed, 16 Sep
 2026 17:53:00 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::3c) by CH0PR03CA0184.outlook.office365.com
 (2603:10b6:610:e4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:59 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:47 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 43/64] drm/amd/display: Fix KUnit connector warnings
Date: Wed, 16 Sep 2026 13:51:58 -0400
Message-ID: <20260916175301.368306-44-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f98e2f-182c-46f7-5c32-08df141b58d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: guZ/zJpFP5qFONfrFG8Bk9tPexjJKqBUJV6Ay6PYAmYZuH9FTQRfaKL/uUE6VFzNoxWsnGd3IfskAHqUOgJxVA5WgYapjPb5kA6ySr0hZdHbPiUvea3qQ1xYSeplY3QqVDP0mCU+t1mcxAzKU0DezLZ0SnfsKmzk8Fe2Z9EFvfTxfbdOO2pg+UkYltFENE+npUNnOKHGG6O5AQPnwkh8Mlv+KvqL6D1BmzeuL6G+axtJwrJRLy+KuvC/AZFpyuFSbVarpdt1Z3xixNH76FTLT2dY+H3k0zO4lwNGFqlCn8MWJ/MD0bkWNTEQBom9oA2HvAXcYr5JPErLqZsiCXckY02c+oKQRLZBGIEGTz657Ejlsr7USBhy6o62jZoy8JRV1G39ArTxPrL/yC2BR/cA3T//Ua6UTMNa01cEEyc9dNDjZnLOpugwr+W0OeiFyDdq/K33DGdB+qnyagHqxKHwWSYchN+VAOIyQaOIUw9iyKLTQ9TvTZ95vl6UTiHitRzMOjLGm8z3NEijYjqwlSaQ7npB1nGL7lgzeuDKjWt5iWa4KMygkpMQpmheBmphUN6rBL1B3HE3UIijuvXvyNfhnF65Gbnr3vkTtyhtHpXLyN23o+4zDhsqgtc4omgrpSleafh/8oLSXHQIgPLgT20QPEduc5FdDRZM9MNKgMVYBGc3eu3P8QNBCek2+uKc/7faddRvDOxwOVQ4d5qwC4ziYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yzy/J32Dn94iK5/97h2aTMrMWAqfnngUHpgyF1ruIz2KHGQWoyjmDKlV1awxAQcL9hl5Pz2e43bAmX023kQr+ODudFoWW/6/rMe9d1AUXYy99Wmd8fh/UmI64uFkKst8SuYDAwoh4Eu3tKt4SIlVeZsqlF8tPXs/jrLzE+UDRWJyCtQ/U3K9hBVloyRJXKE3E4ti8S/LyXyMjv3/EeXcd1tsAMdPBA1T6l4KpR9FCFrCFhm9BZ3iN3BPtgpLPB7vSLU6OF9TnlY1VJRbeThauA6GsOJX1y+Zgh2/DDGhw40+jTRIR7BDjQuDYoyEuYSXdaANEsxyOYL1FoU05e4l99jCHaakLQ2OniP+eloPa9taelb2+Rpm50N3goTmUNeJArzgKq8HljlEVO0aSYMcwpXFLBomJE3eGgVj4pSJdok+lM0OugOqWDbPuUCGT6Js
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:59.6398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f98e2f-182c-46f7-5c32-08df141b58d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
Connector mode population without mode_config.mutex produces warning
stack traces. Legacy property reads also warn on atomic DRM devices.

[HOW]
Lock mode-population calls and release the mutex before assertions.
Read stored property values with the atomic-compatible default getter.

Assisted-by: Copilot:GPT-6-Astra
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 53 +++++++++++++++----
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 1848b81e45a9..ff22e79e7c92 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -2735,7 +2735,7 @@ static void dm_test_update_subconnector_dp_with_sink(struct kunit *test)
 
 	update_subconnector_property(aconnector);
 
-	KUNIT_EXPECT_EQ(test, drm_object_property_get_value(&aconnector->base.base,
+	KUNIT_EXPECT_EQ(test, drm_object_property_get_default_value(&aconnector->base.base,
 				aconnector->base.dev->mode_config.dp_subconnector_property,
 				&val), 0);
 	KUNIT_EXPECT_EQ(test, (int)val, (int)DRM_MODE_SUBCONNECTOR_VGA);
@@ -2778,7 +2778,7 @@ static void dm_test_update_subconnector_dp_no_sink(struct kunit *test)
 
 	update_subconnector_property(aconnector);
 
-	KUNIT_EXPECT_EQ(test, drm_object_property_get_value(&aconnector->base.base,
+	KUNIT_EXPECT_EQ(test, drm_object_property_get_default_value(&aconnector->base.base,
 				aconnector->base.dev->mode_config.dp_subconnector_property,
 				&val), 0);
 	KUNIT_EXPECT_EQ(test, (int)val, (int)DRM_MODE_SUBCONNECTOR_Unknown);
@@ -2827,7 +2827,7 @@ static void dm_test_update_subconnector_non_dp_noop(struct kunit *test)
 	update_subconnector_property(aconnector);
 
 	/* Non-DP connector: value must remain what we seeded */
-	KUNIT_EXPECT_EQ(test, drm_object_property_get_value(&aconnector->base.base,
+	KUNIT_EXPECT_EQ(test, drm_object_property_get_default_value(&aconnector->base.base,
 				aconnector->base.dev->mode_config.dp_subconnector_property,
 				&val), 0);
 	KUNIT_EXPECT_EQ(test, (int)val, (int)DRM_MODE_SUBCONNECTOR_VGA);
@@ -3339,7 +3339,7 @@ static uint64_t dm_test_panel_prop_value(struct kunit *test,
 	uint64_t val = ~0ULL;
 
 	KUNIT_EXPECT_EQ(test,
-		drm_object_property_get_value(&ctx->aconnector->base.base,
+		drm_object_property_get_default_value(&ctx->aconnector->base.base,
 			ctx->drm->mode_config.panel_type_property, &val), 0);
 	return val;
 }
@@ -5733,9 +5733,11 @@ static void dm_test_native_mode_copies_preferred(struct kunit *test)
 	mode->clock = 148500;
 	mode->hdisplay = 1920;
 	mode->vdisplay = 1080;
+	mutex_lock(&ctx->drm->mode_config.mutex);
 	drm_mode_probed_add(&ctx->aconnector->base, mode);
 
 	amdgpu_dm_get_native_mode(&ctx->aconnector->base);
+	mutex_unlock(&ctx->drm->mode_config.mutex);
 
 	KUNIT_EXPECT_EQ(test, ctx->aenc->native_mode.hdisplay, 1920);
 	KUNIT_EXPECT_EQ(test, ctx->aenc->native_mode.vdisplay, 1080);
@@ -5788,8 +5790,10 @@ static void dm_test_add_common_modes_non_edp_noop(struct kunit *test)
 	ctx->aenc->native_mode.hdisplay = 1920;
 	ctx->aenc->native_mode.vdisplay = 1200;
 
+	mutex_lock(&ctx->drm->mode_config.mutex);
 	amdgpu_dm_connector_add_common_modes(&ctx->aenc->base,
 					     &ctx->aconnector->base);
+	mutex_unlock(&ctx->drm->mode_config.mutex);
 
 	KUNIT_EXPECT_EQ(test, ctx->aconnector->num_modes, 0);
 }
@@ -5809,8 +5813,10 @@ static void dm_test_add_common_modes_edp_adds(struct kunit *test)
 	ctx->aenc->native_mode.hdisplay = 1920;
 	ctx->aenc->native_mode.vdisplay = 1200;
 
+	mutex_lock(&ctx->drm->mode_config.mutex);
 	amdgpu_dm_connector_add_common_modes(&ctx->aenc->base,
 					     &ctx->aconnector->base);
+	mutex_unlock(&ctx->drm->mode_config.mutex);
 
 	KUNIT_EXPECT_EQ(test, ctx->aconnector->num_modes, 10);
 }
@@ -5887,12 +5893,18 @@ static struct amdgpu_dm_connector *dm_test_fs_setup(struct kunit *test)
 static void dm_test_add_fs_modes_generates(struct kunit *test)
 {
 	struct amdgpu_dm_connector *aconnector = dm_test_fs_setup(test);
+	unsigned int count, duplicate_count;
 
 	aconnector->min_vfreq = 20;
 	aconnector->max_vfreq = 60;
 
-	KUNIT_EXPECT_EQ(test, (int)add_fs_modes(aconnector), 8);
-	KUNIT_EXPECT_EQ(test, (int)add_fs_modes(aconnector), 0);
+	mutex_lock(&aconnector->base.dev->mode_config.mutex);
+	count = add_fs_modes(aconnector);
+	duplicate_count = add_fs_modes(aconnector);
+	mutex_unlock(&aconnector->base.dev->mode_config.mutex);
+
+	KUNIT_EXPECT_EQ(test, count, 8);
+	KUNIT_EXPECT_EQ(test, duplicate_count, 0);
 }
 
 /**
@@ -8404,9 +8416,13 @@ static void dm_test_get_modes_noedid_default(struct kunit *test)
 {
 	struct dm_test_gm_ctx *ctx =
 		dm_test_gm_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	int count;
+
+	mutex_lock(&ctx->drm->mode_config.mutex);
+	count = amdgpu_dm_connector_get_modes(&ctx->aconnector->base);
+	mutex_unlock(&ctx->drm->mode_config.mutex);
 
-	KUNIT_EXPECT_GT(test,
-			amdgpu_dm_connector_get_modes(&ctx->aconnector->base), 0);
+	KUNIT_EXPECT_GT(test, count, 0);
 }
 
 /**
@@ -8422,10 +8438,12 @@ static void dm_test_get_modes_noedid_128b_adds_more(struct kunit *test)
 		dm_test_gm_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
 	int n_8b, n_128b;
 
+	mutex_lock(&ctx->drm->mode_config.mutex);
 	n_8b = amdgpu_dm_connector_get_modes(&ctx->aconnector->base);
 
 	ctx->link_srv->dp_get_encoding_format = dm_test_gm_enc_128b;
 	n_128b = amdgpu_dm_connector_get_modes(&ctx->aconnector->base);
+	mutex_unlock(&ctx->drm->mode_config.mutex);
 
 	KUNIT_EXPECT_GT(test, n_128b, n_8b);
 }
@@ -8444,7 +8462,9 @@ static void dm_test_get_modes_noedid_analog_adds_common(struct kunit *test)
 	struct dc_sink *sink;
 	int n_base, n_analog;
 
+	mutex_lock(&ctx->drm->mode_config.mutex);
 	n_base = amdgpu_dm_connector_get_modes(&ctx->aconnector->base);
+	mutex_unlock(&ctx->drm->mode_config.mutex);
 
 	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, sink);
@@ -8452,7 +8472,9 @@ static void dm_test_get_modes_noedid_analog_adds_common(struct kunit *test)
 	ctx->aconnector->dc_sink = sink;
 	ctx->link->link_id.id = CONNECTOR_ID_VGA;
 
+	mutex_lock(&ctx->drm->mode_config.mutex);
 	n_analog = amdgpu_dm_connector_get_modes(&ctx->aconnector->base);
+	mutex_unlock(&ctx->drm->mode_config.mutex);
 
 	KUNIT_EXPECT_GT(test, n_analog, n_base);
 }
@@ -8469,6 +8491,7 @@ static void dm_test_get_modes_with_edid(struct kunit *test)
 	struct dm_test_gm_ctx *ctx =
 		dm_test_gm_ctx_alloc(test, DRM_MODE_CONNECTOR_eDP);
 	const struct drm_edid *drm_edid;
+	int count;
 
 	drm_edid = drm_edid_alloc(dm_test_uad_edid, sizeof(dm_test_uad_edid));
 	KUNIT_ASSERT_NOT_NULL(test, drm_edid);
@@ -8478,8 +8501,11 @@ static void dm_test_get_modes_with_edid(struct kunit *test)
 	ctx->aenc->native_mode.hdisplay = 1920;
 	ctx->aenc->native_mode.vdisplay = 1200;
 
-	KUNIT_EXPECT_GT(test,
-			amdgpu_dm_connector_get_modes(&ctx->aconnector->base), 0);
+	mutex_lock(&ctx->drm->mode_config.mutex);
+	count = amdgpu_dm_connector_get_modes(&ctx->aconnector->base);
+	mutex_unlock(&ctx->drm->mode_config.mutex);
+
+	KUNIT_EXPECT_GT(test, count, 0);
 
 	drm_edid_free(drm_edid);
 	ctx->aconnector->drm_edid = NULL;
@@ -10068,6 +10094,7 @@ static void dm_test_conn_init_get_modes_hook(struct kunit *test)
 		dm_test_conn_init_ctx_alloc(test, SIGNAL_TYPE_HDMI_TYPE_A);
 	const struct drm_connector_helper_funcs *helper;
 	struct drm_connector *connector = &ctx->aconnector->base;
+	int count;
 
 	KUNIT_ASSERT_EQ(test,
 			amdgpu_dm_connector_init(ctx->dm, ctx->aconnector, 0,
@@ -10077,7 +10104,11 @@ static void dm_test_conn_init_get_modes_hook(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, helper);
 	KUNIT_ASSERT_NOT_NULL(test, helper->get_modes);
 
-	KUNIT_EXPECT_GT(test, helper->get_modes(connector), 0);
+	mutex_lock(&ctx->drm->mode_config.mutex);
+	count = helper->get_modes(connector);
+	mutex_unlock(&ctx->drm->mode_config.mutex);
+
+	KUNIT_EXPECT_GT(test, count, 0);
 	KUNIT_EXPECT_GT(test, ctx->aconnector->num_modes, 0);
 }
 
-- 
2.55.0


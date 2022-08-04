Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC6FC19F2B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Aug 2022 08:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D9D8D1EA;
	Thu,  4 Aug 2022 08:57:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D680B91EA2
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Aug 2022 08:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnnq0K9oV8pv+BFtjT8DBK/3ul6N3HKCTVT+PclCI292DCKfGvrQWXSsiMi0AQUcF6bJEYS9sAZPgO0N53qLXAoqB8vXhDlfEs5a0D2m0dUOjvRn1w93B+8uAz9UXOrnTKer036FeVFFBwBYhGTt+gCAVIUrIog6aYv0UZTWyQbkE8I1yCPKuoR985oQ1ULM9wRUHlYj6c6L3BKTKbmGWqTjKgysT1AwHd8GO+uafoiZw0KNFzwG/flEjPsLSDrjQstN6NbV3Btw5C19iO2F5YYQ7cD96Vql7zo22fkhDIadELEI0nvSarHkxvSiGJi8UH0VKXTH8S1daOB4T/fiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ctrquwx17K7EWGAfmyGDHWik2IkyHvwh6wvL81B8oe8=;
 b=I656rolnSrxLrFtJ3+EbnGxQAS0qj4WaR4r0oxxkd60E3p+OhYWd1PazHZWQK1JiafNfaD4DFh0UWshQZ08tW4Yk7QP4yuYRaGXsRoBvc/KRFTTfCojDCMvDBGIh8QTehaXTqSgTfTo5YTR2hBQHOe2xanFB2V/1T709jrQWztvNiGyd3hgjo5rsUeV70+f3Qmfyzj2rczDRjc0OW4SsKRHeU2dEyNxjHp44mY04+tatfnYnhV1aIuA7dqy3/rQho7og9THFUhG7TRddbykrrjMW+C7rE8/ATdnWewPOC2KoRsgGUlgccdkAH34usn3AeN5RQCZ8SAjBr9W/PeQRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctrquwx17K7EWGAfmyGDHWik2IkyHvwh6wvL81B8oe8=;
 b=AAtX4QaaVvJRFc6GtkP3zmTwBb5EnK7MosEBY93jqjpL00QCaBCO13WVWM+AbMbm1e1G0KqVbp9skkjLi4g3Z7X1eI6yFMvw7qXv6q3AXIvichS/z96P0pNqcDzSOF+SkZ3r2m3TB7ZU1UykTdXxxjo/WPTUIMLG9D/nK2A9kyU=
Received: from DM6PR07CA0058.namprd07.prod.outlook.com (2603:10b6:5:74::35) by
 MN2PR12MB3101.namprd12.prod.outlook.com (2603:10b6:208:c4::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Thu, 4 Aug 2022 08:56:43 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::87) by DM6PR07CA0058.outlook.office365.com
 (2603:10b6:5:74::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Thu, 4 Aug 2022 08:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 08:56:42 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 4 Aug
 2022 03:56:39 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: change family id name for DCN314
Date: Thu, 4 Aug 2022 16:49:15 +0800
Message-ID: <20220804084915.3734321-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de66fd63-f943-42a5-591a-08da75f740b3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3101:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNGH43aqfjMPZZgHjntbVbFE4TX83LvZGv8B/h4U2X0x0LD7CCqClFfTn8BS8DyJ1OR0ksBAWcc7pzcCahWsMaZgePjYE8+9k5IcjcExCCck3DaDdI9/0GBgPwo0MajaFOLDHt6yVLX5P5wWSWVgM+5FPXcObLZTUhCC0KKBcuFxfP+X6ul7RoEtlKXXGxwRPjLQaxsuevNuMk5vl7/w2dpykLrypZBpBmENcelj48QpH5ho/uaUrLbOf3G1sAHvBN0bFzsjerZuo//S9WVYEo1Z8MmCn0HbFE5RFvzM0qr06b18X8xOGSntsew6tlsByvaUTJvLnqeYRry85IgJV2RpPbHS/RgKgVQfrFc98anSOAX/YqYDSqsfMIU0yPE6965YyRwvFElZmRRwAiRCw+XlAwIae7v/4WVdp3odV9Z+2sIi5FRNNm1xshz9+JYi/QjBqBkZqG67Ki4OJhsEpWEgbSeIJO5RqtrvHDjOtQmaE7v4W1FkxDz5YYlSRGa4GpYeIfoL2fsGvmI7MqWqDx7jx4xkqKwvPYgx2uIwpyejGrf3zmYUtXSnsZoxEjtNc5WVghupjBvUhXbySk7r/P4MWJmWkdsgcbJt1GpylipfnVxZeSkW9raWk4HgHXsviTGiR+oht6KTmw2FkXLHLGPlPm5REKTquLJEVkMKLfk7KeURwTeL9UObrLxX2Qla9WsuFxERiIHIfRmZ/IQJF54t+yXiIa0u+43OtXgjtPQz5Y5FvCe3tOy7VgwawJMpqxiGxblnoq4skDMGnI+xEPADP80f7IEi6FX9zqNjAnfUzQF1AA7pvH5Hy0GQ1o3zpzqBlhnv9VswwGy8Uk4mSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(40470700004)(16526019)(1076003)(82310400005)(186003)(2616005)(41300700001)(7696005)(6666004)(2906002)(36756003)(40480700001)(36860700001)(5660300002)(478600001)(4326008)(70206006)(8676002)(70586007)(86362001)(8936002)(356005)(40460700003)(47076005)(83380400001)(336012)(316002)(426003)(26005)(81166007)(54906003)(82740400003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 08:56:42.8276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de66fd63-f943-42a5-591a-08da75f740b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3101
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Roman.Li@amd.com,
 Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GC version is 11.0.1 rather than 11.0.2

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c        | 4 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c                | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h       | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 516739bc0a96..3b4bf131bab1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -660,7 +660,7 @@ static int get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_ty
 			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
 		break;
 	case AMDGPU_FAMILY_GC_11_0_0:
-	case AMDGPU_FAMILY_GC_11_0_2:
+	case AMDGPU_FAMILY_GC_11_0_1:
 		add_gfx11_modifiers(adev, mods, &size, &capacity);
 		break;
 	}
@@ -1408,7 +1408,7 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 		}
 		break;
 	case AMDGPU_FAMILY_GC_11_0_0:
-	case AMDGPU_FAMILY_GC_11_0_2:
+	case AMDGPU_FAMILY_GC_11_0_1:
 		switch (AMD_FMT_MOD_GET(TILE, modifier)) {
 		case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
 		case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 4c76091fd1f2..f276abb63bcd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -337,7 +337,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	    break;
 	}
 
-	case AMDGPU_FAMILY_GC_11_0_2: {
+	case AMDGPU_FAMILY_GC_11_0_1: {
 		struct clk_mgr_dcn314 *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
 
 		if (clk_mgr == NULL) {
@@ -397,7 +397,7 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
 		dcn32_clk_mgr_destroy(clk_mgr);
 		break;
 
-	case AMDGPU_FAMILY_GC_11_0_2:
+	case AMDGPU_FAMILY_GC_11_0_1:
 		dcn314_clk_mgr_destroy(clk_mgr);
 		break;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e42f44fc1c08..5d84adb6ea52 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4292,7 +4292,7 @@ bool dc_is_dmub_outbox_supported(struct dc *dc)
 	    !dc->debug.dpia_debug.bits.disable_dpia)
 		return true;
 
-	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_2 &&
+	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_1 &&
 	    !dc->debug.dpia_debug.bits.disable_dpia)
 		return true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 9e51338441d0..66d2ae7aacf5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3372,7 +3372,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 		switch(link->ctx->asic_id.chip_family) {
 		case FAMILY_YELLOW_CARP:
 		case AMDGPU_FAMILY_GC_10_3_6:
-		case AMDGPU_FAMILY_GC_11_0_2:
+		case AMDGPU_FAMILY_GC_11_0_1:
 			if(!dc->debug.disable_z10)
 				psr_context->psr_level.bits.SKIP_CRTC_DISABLE = false;
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ffc0f1c0ea93..7dbab15bfa68 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -169,7 +169,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 		if (ASICREV_IS_GC_11_0_2(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_3_21;
 		break;
-	case AMDGPU_FAMILY_GC_11_0_2:
+	case AMDGPU_FAMILY_GC_11_0_1:
 		dc_version = DCN_VERSION_3_14;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 468a893ff785..aedff18aff56 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2153,7 +2153,7 @@ static bool dcn31_resource_construct(
 		pool->base.usb4_dpia_count = 4;
 	}
 
-	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_2)
+	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_1)
 		pool->base.usb4_dpia_count = 4;
 
 	/* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index ab06c7fc7452..e054f3494087 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -244,7 +244,7 @@ enum {
 #define ASICREV_IS_GC_10_3_7(eChipRev) ((eChipRev >= GC_10_3_7_A0) && (eChipRev < GC_10_3_7_UNKNOWN))
 
 #define AMDGPU_FAMILY_GC_11_0_0 145
-#define AMDGPU_FAMILY_GC_11_0_2 148
+#define AMDGPU_FAMILY_GC_11_0_1 148
 #define GC_11_0_0_A0 0x1
 #define GC_11_0_2_A0 0x10
 #define GC_11_UNKNOWN 0xFF
-- 
2.37.1


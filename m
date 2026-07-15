Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD55CC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6811B10F081;
	Wed, 15 Jul 2026 13:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2DwTxw8C";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA82D10F081
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6ILwfr6F5Tj6abanZx3/fUwMTyIvoNECT7WPBVbWkdQ+wKXfRchDY8kHoTczkx9MgOxZjxF/3lm0uJJ4AsEAoQ86DL4HPc/Vm1EVH6B+hr+GEvsBQHxL2iHvYq+9zIRIKeKOKjr7dm34ppFF5eGgOk5DRhdAJjZGugYofQ9SSidNOmyjPY5BXL11UpFxYsl0Gw6BZm9gUYu55Wy/8g0mCiRmlcQvQ+U/IcG06jYoLRXCuSTxAyL7yx2Tzmpt37se/D7LuoR6ZxmvO39MPWJs5UCukkcGjVq53NcN379D0c0ydfxMkt3zBxgPuV2qrQZF8gNJWErM86uAgySm5nZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGeeufwkWcDEBV4PqWJ/tkZowMaOBcWpffm//eovTKc=;
 b=UI245Iilv5iGBPgous/3utQJgg8WcZIrsjoN5fTjzpk0+I/0pmd7v1NVfEEUcCyGYqIRtAkaVeUsSqYQFdG2DgwR1o2IrxzEqmo28ZjK88TkcKOEcqdtRmygKMwqiWTjW0yXT4GmQbsnezFMhhU19Fd0kFxgnJHlnnoM83DjtCEtpQv3bXa9TxAKkhYTrOkPka5FOzBy6Q4O4u/SnSvkZsI2xsbbyefGrBFgcbMfeoqHPDFBR25bnk4kPbGOrMy73FRviMJPeLF9Co4Mx3gZIx2ge1d9iyCUcWK90TMCnM8h8EwucnUz61JIJcwOJVv2pw7YHckP5Db6KABPJYbsag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGeeufwkWcDEBV4PqWJ/tkZowMaOBcWpffm//eovTKc=;
 b=2DwTxw8C4Gi+gWI8SQ8oTziSFFQ3qWR0BCk+ou7+vlSUdiW5MzBMpufXUIeQH8HhyE4QqgvuRa2eI7U7+PWbVs4MS4j470jVY2nHmxa4t8mptjk5aHDRdclJa7c86w1ORO6RpJEo0lzsOSMjBc//1M+y1vq+Ai+ejXmnkneOWs8=
Received: from PH8P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::16)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:46:22 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::9b) by PH8P220CA0022.outlook.office365.com
 (2603:10b6:510:345::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:08 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 20/70] drm/amd/display: Add encoder helper tests for connector
Date: Wed, 15 Jul 2026 21:37:30 +0800
Message-ID: <20260715134432.1975118-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: ff484073-fdb8-4b6a-d3c6-08dee2777478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: VB3xKFTVjwp+phw0YXX4sPlqti2crIqxXdeLpM51p7A813gNHppyi5/XcEehIPi3wbaMUz+Dy14c2ElVvxAHCYqCZcIzrRYVBPJRHZ+4W98B5oJa/L4cjtDEHLco6sU9e+Dpai9w7i7xubbDqkvfaB3p6qTb9FyX9lvTT3icf+Z4TnC+VGf7FCF9iZas9wdR2KZMFP+1k7KlIi0TxtQUxU8iOyUFzkYc8lKjcyB7OXpB8jgIFCx90Xg/y4o79HsLijE+It50h7H5FfdZPTJlMJtjl8SgwZSmp9IlxQVxX7HBXDEP9MAS2mIwoDVauuBwVbFt9AhVEiQk4fuz1ERyXozp2HsAyrwzpY6Cw6zelxr7Ozfg39XrnRiZX7TcnyzzqxRePis2xi0VEAm5Mol8mRygHqm81o7HjjANRhJ8IyUvCN2U/itwPiiqxGJ6WTAoqkKoBmFMOGhrj8TpKSDTZf+3Mv3p05/+1mBWIFfAx1SLO8f4Lqbg/gE+4RRq9RkNVNCpypG/ekp+kcm26RRtr9dHioggJ1G+9Owo+UAE99qH+sBlTtK4R2Lr9VQb73K3ouHYXDDI7onolM6nnaxhbUm0j6nY6KfWv5WstAB8eH+Qu1Z7cNkqJEnVBKjCB+EWsp0e5bzEqdoMqRrlfKhqgrVJz1r0pHmd8UoQQU9c12LCw2xDEp5V2SgqWA45Z72uwF2XAvV4cl9B+xjFX9JqSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4DExNH8iDg8vzLMK1eWld62Oz/gwJIW/llyzUI/JmKfLp5BwFYXCbdW0+KQoKZt/T8d6iCq1vwvEW7Pkt3pBb1ss3W481gqSpJeEK38Ct1HkknnzwDEHKOcsHy/XprVuqbzyeGOVYXDo5Bg3c7L1pwphrOEbItu3J7JAOU4VNkH7uxZSL8n+f4xcK/4HGN5Wt04Qwenn3imtag8obNzxTBHFtnvYMTMWUjqERuVHYlnfGg8NyMb3tUHrdvCZtEmRJsehT8E+A2JY9J5lBGiwufUKxOVA+Kg4qYCK4ZJj+9wusksO6QB0Il95g9GZ4n/5MSQ8/vy4Fr5M44JORC97TemNQ5uFTPi1Io8YISPPxDlfSQaGuxaFD0j+qy4figcRn2m5MFjUpPDOaaKgooNEf6hOeGjJ9UYqc9PhpkRXm++SoMIWdGjXxwJn5P+iCVG7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:21.5569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff484073-fdb8-4b6a-d3c6-08dee2777478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Add KUnit coverage for the encoder helpers dm_encoder_helper_disable()
and dm_encoder_helper_atomic_check(): disable no-op, eDP native keeps
scaling, LVDS non-native enables scaling, and the non-MST zero return.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   6 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   4 +
 .../tests/amdgpu_dm_connector_test.c          | 139 ++++++++++++++++++
 3 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index d1c95199d598..a4648acde71b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -90,11 +90,12 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
 	.destroy = amdgpu_dm_encoder_destroy,
 };
 
-static void dm_encoder_helper_disable(struct drm_encoder *encoder)
+STATIC_IFN_KUNIT void dm_encoder_helper_disable(struct drm_encoder *encoder)
 {
 }
+EXPORT_IF_KUNIT(dm_encoder_helper_disable);
 
-static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
+STATIC_IFN_KUNIT int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 					  struct drm_crtc_state *crtc_state,
 					  struct drm_connector_state *conn_state)
 {
@@ -164,6 +165,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	}
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_encoder_helper_atomic_check);
 
 const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs = {
 	.disable = dm_encoder_helper_disable,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 22423e878b64..a5fff31b23bf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -146,6 +146,10 @@ int amdgpu_dm_encoder_init(struct drm_device *dev,
 			   uint32_t link_index);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+void dm_encoder_helper_disable(struct drm_encoder *encoder);
+int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state);
 enum drm_mode_subconnector get_subconnector_type(struct dc_link *link);
 void update_subconnector_property(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_fbc_init(struct drm_connector *connector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index efaf5730e893..441180d427c9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4134,6 +4134,139 @@ static void dm_test_destroy_releases_dc_em_sink(struct kunit *test)
 	dc_sink_release(sink);
 }
 
+/* Tests for dm_encoder_helper_disable() */
+
+/**
+ * dm_test_encoder_disable_noop - Test the disable hook is a no-op
+ * @test: The KUnit test context
+ *
+ * dm_encoder_helper_disable() has an empty body; calling it must neither touch
+ * the encoder nor crash.
+ */
+static void dm_test_encoder_disable_noop(struct kunit *test)
+{
+	struct drm_encoder *encoder;
+
+	encoder = kunit_kzalloc(test, sizeof(*encoder), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, encoder);
+
+	dm_encoder_helper_disable(encoder);
+}
+
+/* Tests for dm_encoder_helper_atomic_check() */
+
+/*
+ * dm_encoder_helper_atomic_check() reads back through to_amdgpu_encoder(),
+ * to_amdgpu_dm_connector() and to_dm_connector_state(), so the encoder,
+ * connector and connector-state are stacked in their containers and wired
+ * together through conn_state->connector.
+ */
+struct dm_test_atomic_check_ctx {
+	struct drm_device *drm;
+	struct amdgpu_encoder *aenc;
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_connector_state *dm_state;
+	struct drm_crtc_state *crtc_state;
+};
+
+static struct dm_test_atomic_check_ctx *
+dm_test_atomic_check_ctx_alloc(struct kunit *test, int connector_type)
+{
+	struct dm_test_atomic_check_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->drm = dm_test_alloc_drm(test);
+
+	ctx->aenc = kunit_kzalloc(test, sizeof(*ctx->aenc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aenc);
+	ctx->aenc->base.dev = ctx->drm;
+
+	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	ctx->aconnector->base.connector_type = connector_type;
+
+	ctx->dm_state = kunit_kzalloc(test, sizeof(*ctx->dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dm_state);
+	ctx->dm_state->base.connector = &ctx->aconnector->base;
+
+	ctx->crtc_state = kunit_kzalloc(test, sizeof(*ctx->crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_state);
+
+	return ctx;
+}
+
+/**
+ * dm_test_atomic_check_edp_native_keeps_scaling - Test native eDP mode is left alone
+ * @test: The KUnit test context
+ *
+ * On an eDP connector whose adjusted mode matches the panel's native mode,
+ * drm_crtc_helper_mode_valid_fixed() returns MODE_OK so scaling is untouched.
+ */
+static void dm_test_atomic_check_edp_native_keeps_scaling(struct kunit *test)
+{
+	struct dm_test_atomic_check_ctx *ctx =
+		dm_test_atomic_check_ctx_alloc(test, DRM_MODE_CONNECTOR_eDP);
+
+	ctx->aenc->native_mode.hdisplay = 1920;
+	ctx->aenc->native_mode.vdisplay = 1080;
+	ctx->crtc_state->adjusted_mode.hdisplay = 1920;
+	ctx->crtc_state->adjusted_mode.vdisplay = 1080;
+	ctx->dm_state->scaling = RMX_OFF;
+
+	KUNIT_EXPECT_EQ(test,
+		dm_encoder_helper_atomic_check(&ctx->aenc->base,
+					       ctx->crtc_state,
+					       &ctx->dm_state->base), 0);
+	KUNIT_EXPECT_EQ(test, (int)ctx->dm_state->scaling, (int)RMX_OFF);
+}
+
+/**
+ * dm_test_atomic_check_lvds_non_native_enables_scaling - Test non-native LVDS turns on scaling
+ * @test: The KUnit test context
+ *
+ * On an LVDS connector whose adjusted mode differs from the native mode and is
+ * currently RMX_OFF, the check enables RMX_ASPECT scaling and still returns 0.
+ */
+static void dm_test_atomic_check_lvds_non_native_enables_scaling(struct kunit *test)
+{
+	struct dm_test_atomic_check_ctx *ctx =
+		dm_test_atomic_check_ctx_alloc(test, DRM_MODE_CONNECTOR_LVDS);
+
+	ctx->aenc->native_mode.hdisplay = 1920;
+	ctx->aenc->native_mode.vdisplay = 1080;
+	ctx->crtc_state->adjusted_mode.hdisplay = 1280;
+	ctx->crtc_state->adjusted_mode.vdisplay = 720;
+	ctx->dm_state->scaling = RMX_OFF;
+
+	KUNIT_EXPECT_EQ(test,
+		dm_encoder_helper_atomic_check(&ctx->aenc->base,
+					       ctx->crtc_state,
+					       &ctx->dm_state->base), 0);
+	KUNIT_EXPECT_EQ(test, (int)ctx->dm_state->scaling, (int)RMX_ASPECT);
+}
+
+/**
+ * dm_test_atomic_check_non_mst_returns_zero - Test non-MST connectors short-circuit
+ * @test: The KUnit test context
+ *
+ * A non-eDP/LVDS connector with no MST output port hits the early ``return 0``
+ * before any topology state is touched.
+ */
+static void dm_test_atomic_check_non_mst_returns_zero(struct kunit *test)
+{
+	struct dm_test_atomic_check_ctx *ctx =
+		dm_test_atomic_check_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+
+	ctx->aconnector->mst_output_port = NULL;
+
+	KUNIT_EXPECT_EQ(test,
+		dm_encoder_helper_atomic_check(&ctx->aenc->base,
+					       ctx->crtc_state,
+					       &ctx->dm_state->base), 0);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -4350,6 +4483,12 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_destroy_minimal),
 	KUNIT_CASE(dm_test_destroy_releases_dc_sink),
 	KUNIT_CASE(dm_test_destroy_releases_dc_em_sink),
+	/* dm_encoder_helper_disable */
+	KUNIT_CASE(dm_test_encoder_disable_noop),
+	/* dm_encoder_helper_atomic_check */
+	KUNIT_CASE(dm_test_atomic_check_edp_native_keeps_scaling),
+	KUNIT_CASE(dm_test_atomic_check_lvds_non_native_enables_scaling),
+	KUNIT_CASE(dm_test_atomic_check_non_mst_returns_zero),
 	{}
 };
 
-- 
2.43.0


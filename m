Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B70C5DF98
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE5810ECD0;
	Tue, 18 Aug 2026 20:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v7H/Refa";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A22310E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbjKrJrjUlL0lNSoEI7f733esWsym/2+UMmG77MRJzzRAEWBlXZY8CGdK18fAOI2708+xTrZOe2Qi7vC57WOXcRgkqxv9KCbMaa6wJOya5KoMC8LR3UBNyLTwIXJDdZ4chD4mSlY5NWbq3z9lqF0gRV/W+90zru4v2J+PFYPhz+42f/0JJsL0da6qxggqFMp4sZ6ioRfh9CBIOzwr1dmiqQkBQpR76TY+uHb+19/bxw7jUBDaRwfgiMNzOCgLTOATqeWBPEJ7/6eMGQnCAYTJvuJnRnMUnNhZl0LKHpfX/1lg+LtVD3PuP21/rVlC8jGoUJyQglR7MitxLtSI0Oc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfN2y70+3fppIliyda6A4VVJsvNDmIJBpzkMQmcDiHA=;
 b=YqyWiRG5V21kNO/nokNg37C+wNDw0aQs4bEH5KhU5gF+jNGWd7+vpNwEaVcXW0oMUsDXwkQoVMC42IyxeNAl5ncQQgxxZFMgmCQfIyvvaofdKAKis2+EecUKwbTAVapPwWAlHQZOHN6c7pVR3Esq2EXfGG+gz2draOzQsIM7TxC0Bevp8ciylYd6k5b3ipzEKC7ed7T1+wyWOZ97XCxvUxSzE93rj13S0RoYip4lmrgk3/NcUST0+eednYil+Jh1EtszdvXrnNIMglfcO40sjBkJc5dru4QepmIS07RDZMetBNnnowXrqA4dDbKCOgDUSsa/12huA+M6mKgLOD1v1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfN2y70+3fppIliyda6A4VVJsvNDmIJBpzkMQmcDiHA=;
 b=v7H/RefalbbRE2zLpDhQkUvf/zmPNlciuwAJpQtxxrlXTPo82xPEt5c4LDCMVdD/dzGd1jGQavgsg+OgM/JEyvGlnRntnEkSiPXjUE0ZsNCSUmmOLjfu1AyQTivAiSI1dkBbBHAXbZ6wrb3u5Bcx07moFc2r83NR5CFZF0gvrOk=
Received: from BN9PR03CA0333.namprd03.prod.outlook.com (2603:10b6:408:f6::8)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Tue, 18 Aug
 2026 20:22:44 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::6f) by BN9PR03CA0333.outlook.office365.com
 (2603:10b6:408:f6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:33 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:33 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 56/82] drm/amd/display: Cover atomic_check modeset triggers
Date: Tue, 18 Aug 2026 16:15:48 -0400
Message-ID: <20260818202139.4172592-57-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 60959eda-f9a7-4b8a-b422-08defd6675d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L2sH1ZBaaRsCfW+5RVnkHBrpvAmBYdUFy+ID4ihUsh6G7+DhIhHyGTkku2nPh5yNq/jdgf0hRAfYSem+p0+X5rJHJFJwPFgjKi+NINQr36KRlOC5z5XMqDkcwzKg3xSTEomzO932rHbx9CA8GvoIAcuqvn5j3BREcvTQZnNKCTHJTFrNtvbbE1JdDOz6i2sSHOYzHse7JP9mPovvOHa+ucSM5e69kZuSsLg9LRBS4lAW0S7PHCYfJRZm74+mFPxN5v+UWg1O1PO6y5ePCQb7IR0BBHzK8kmLlFs+2mo3SV/3kbjhrnLhD7OBguXIBzPdRSihHuLw3H3rO8O+pS4fSg86BduMycB482GB7HNz1RnrnA2VcSz8WNpaZfEM8P7GC/fqgSNNBcIAyxcYdc5e1Leaw1b+3JWgcmsCdEJAyVPeXbE02iY6ib1UCZtWT2SGvPPUCq97TlHs5uJZnQmI6Q9QxLWOhMrd6W8vgFVvyduF5RTvWwA3nP8O0qmlqY+Lvzuxai35ZJXvbp6e+JZHZp/d0S/nitb7+LTlHINiw+gJ19qoBKNGvgms+HBe0mqhQvfXFY2ujChpWWK+gRTymcvrOZmWiBZpQ7xFGuerH70bXwo9XiELNmOerCngqwpjlCByluS+dI86Otx+IviERP81RAPERJTsjgjnoWP9jPFNrztu6guEcgOw87yucjXQWlFmTNgyzGyIlvGZk8A04A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QmYHxMfV5nPfj1HlXkAhDjXUAnVBu7Y01ZE1Q723LwJLiCqbO6PabGRlVkVNIEh3UFBtnpEyiVDqlKBvlxElcQNASJA9oR9JzaQSVDWKWG88pAhsWnYjYVgRUFGooAWmprL6gQkMdjY4hh9/JXfB44zazsACZckWCQocY0Q8nP3cyj50svB6XMBIdyfEmSjrt5XSbLlPf9S7FDzXPiYc7ZAako8sHoFnYKakNuKypEwICGjyjLogQ0kr5cc6a6rfs2VAm0t62va6X8qyOF4w2XvSzJxvsz5vFICotTLrFOq65BKTc0LdVbq+kGGoWEXFPCo+zTB3e891HUKEYzNqcfCztLLVIskH47FmahhHM7lbIYMwEnk9Su6MwHG2rkq21MNQluB/3xrsfHGZ8aWr/HGszu8kPsD8vy45V5raLpW3IlNcH/+0fVBoCi0zt7ih
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:43.8061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60959eda-f9a7-4b8a-b422-08defd6675d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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

Add KUnit tests for the amdgpu_dm_connector_atomic_check() properties
that force a modeset: privacy-screen, colorspace and content-type
changes, plus the HDR-metadata exit and fill-error branches.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 47c6caba46889..f7ea6aa801bc8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -6476,6 +6476,8 @@ struct dm_test_conn_ac_ctx {
 	struct drm_atomic_commit *state;
 	struct drm_connector_state *old_state;
 	struct drm_connector_state *new_state;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
 };
 
 static struct dm_test_conn_ac_ctx *
@@ -6568,6 +6570,146 @@ static void dm_test_conn_atomic_check_no_change(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
+/*
+ * Bind a crtc to the commit with a pre-populated crtc slot so
+ * drm_atomic_get_crtc_state() returns @crtc_state via its new-state fast path
+ * rather than locking and duplicating through absent crtc funcs.
+ */
+static void dm_test_conn_ac_bind_crtc(struct kunit *test,
+				      struct dm_test_conn_ac_ctx *ctx)
+{
+	ctx->crtc = kunit_kzalloc(test, sizeof(*ctx->crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc);
+	ctx->crtc_state = kunit_kzalloc(test, sizeof(*ctx->crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_state);
+
+	ctx->state->crtcs = kunit_kcalloc(test, 1, sizeof(*ctx->state->crtcs),
+					  GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state->crtcs);
+	ctx->state->crtcs[0].ptr = ctx->crtc;
+	ctx->state->crtcs[0].new_state = ctx->crtc_state;
+
+	/* Only needs to be non-NULL to satisfy the get_crtc_state() WARN. */
+	ctx->state->acquire_ctx = (void *)ctx;
+
+	ctx->new_state->crtc = ctx->crtc;
+}
+
+/**
+ * dm_test_conn_atomic_check_privacy_change - Test privacy toggle forces modeset
+ * @test: The KUnit test context
+ *
+ * A changed privacy-screen software state pulls in the crtc state and flags a
+ * modeset.
+ */
+static void dm_test_conn_atomic_check_privacy_change(struct kunit *test)
+{
+	struct dm_test_conn_ac_ctx *ctx =
+		dm_test_conn_ac_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	int ret;
+
+	dm_test_conn_ac_bind_crtc(test, ctx);
+	ctx->new_state->privacy_screen_sw_state = PRIVACY_SCREEN_ENABLED;
+
+	ret = amdgpu_dm_connector_atomic_check(&ctx->aconn->base, ctx->state);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->mode_changed);
+}
+
+/**
+ * dm_test_conn_atomic_check_colorspace_change - Test colorspace change forces modeset
+ * @test: The KUnit test context
+ *
+ * A changed output colorspace pulls in the crtc state and flags a modeset.
+ */
+static void dm_test_conn_atomic_check_colorspace_change(struct kunit *test)
+{
+	struct dm_test_conn_ac_ctx *ctx =
+		dm_test_conn_ac_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	int ret;
+
+	dm_test_conn_ac_bind_crtc(test, ctx);
+	ctx->new_state->colorspace = DRM_MODE_COLORIMETRY_BT2020_RGB;
+
+	ret = amdgpu_dm_connector_atomic_check(&ctx->aconn->base, ctx->state);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->mode_changed);
+}
+
+/**
+ * dm_test_conn_atomic_check_content_type_change - Test content-type change forces modeset
+ * @test: The KUnit test context
+ *
+ * A changed content type pulls in the crtc state and flags a modeset.
+ */
+static void dm_test_conn_atomic_check_content_type_change(struct kunit *test)
+{
+	struct dm_test_conn_ac_ctx *ctx =
+		dm_test_conn_ac_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	int ret;
+
+	dm_test_conn_ac_bind_crtc(test, ctx);
+	ctx->new_state->content_type = DRM_MODE_CONTENT_TYPE_GRAPHICS;
+
+	ret = amdgpu_dm_connector_atomic_check(&ctx->aconn->base, ctx->state);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->mode_changed);
+}
+
+/**
+ * dm_test_conn_atomic_check_hdr_exit - Test exiting HDR forces a modeset
+ * @test: The KUnit test context
+ *
+ * Clearing previously set HDR metadata makes the metadata unequal; the fill
+ * succeeds for the empty new state and the enter/exit rule flags a modeset.
+ */
+static void dm_test_conn_atomic_check_hdr_exit(struct kunit *test)
+{
+	struct dm_test_conn_ac_ctx *ctx =
+		dm_test_conn_ac_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct drm_property_blob *blob;
+	int ret;
+
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+
+	dm_test_conn_ac_bind_crtc(test, ctx);
+	ctx->old_state->hdr_output_metadata = blob;
+
+	ret = amdgpu_dm_connector_atomic_check(&ctx->aconn->base, ctx->state);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->mode_changed);
+}
+
+/**
+ * dm_test_conn_atomic_check_hdr_fill_error - Test infopacket fill errors propagate
+ * @test: The KUnit test context
+ *
+ * A new HDR metadata blob with no payload makes the infopacket fill fail, and
+ * that error is returned before the crtc state is touched.
+ */
+static void dm_test_conn_atomic_check_hdr_fill_error(struct kunit *test)
+{
+	struct dm_test_conn_ac_ctx *ctx =
+		dm_test_conn_ac_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct drm_property_blob *blob;
+	int ret;
+
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+
+	dm_test_conn_ac_bind_crtc(test, ctx);
+	ctx->new_state->hdr_output_metadata = blob;
+
+	ret = amdgpu_dm_connector_atomic_check(&ctx->aconn->base, ctx->state);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
 /**
  * dm_test_update_after_detect_mst_noop - Test MST connectors are left to drm_mst
  * @test: The KUnit test context
@@ -7249,6 +7391,11 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_conn_atomic_check_no_crtc),
 	KUNIT_CASE(dm_test_conn_atomic_check_dp_mst),
 	KUNIT_CASE(dm_test_conn_atomic_check_no_change),
+	KUNIT_CASE(dm_test_conn_atomic_check_privacy_change),
+	KUNIT_CASE(dm_test_conn_atomic_check_colorspace_change),
+	KUNIT_CASE(dm_test_conn_atomic_check_content_type_change),
+	KUNIT_CASE(dm_test_conn_atomic_check_hdr_exit),
+	KUNIT_CASE(dm_test_conn_atomic_check_hdr_fill_error),
 	/* amdgpu_dm_connector_atomic_set_property */
 	KUNIT_CASE(dm_test_set_property_scaling_center),
 	KUNIT_CASE(dm_test_set_property_scaling_aspect),
-- 
2.43.0


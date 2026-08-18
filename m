Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1867AC5DF8E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D3910ECE3;
	Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iZTujEaS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB21710EC9D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcCtmRLcmT4835StwgArY6Prfpf2iXEH+B9Ox+wj1SWGStMYVlOzs33vXrLtMuwOKdQN1QZS1xF6CSxpZSkixvfSXeNZaLXRVuBQociF7a/QEZ2vbEKzlBieu1same7YW9u/Lc9WDLA1ktIqYL9CZK6IwWisz5KYTtnABXqvxd4u8AlKZYXt9aJoXUJAsLmC9LiB5+HwiVWaxCHkArHKlS2UnXv54AglMpnHz0XY97Vvs93lH4wcAP5jOvNMYZAei7LwcbND1iklUc1X8l/qhbMM6giJnqSZO0EBspXRUysZS6WJStcTZom9nfnp7zcryKEle+7cQeG0JMtvtLIcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx+ZkUNViby6bGHW0CfkyVdofYc/By/NG6mnC2bEI2k=;
 b=kJZs++5pHb5gz062j/BmsTktl6x7VklsMkF5150uf7UXrHXWwFEHIwVS1UyZ79eA6cCUUu57cN+OrrphW50lLNI9Vne24I18GTQIurC5EmiRhFA+21NgvfC2x/titF7W1/4hDjBvHG3H8W0GBXM8BWbZNR58etjjPVg8noYxS+dr8yazDWmfrVE8o5RjmrE/gTdDXVbvOW8zR2zpZYCtH1/9c3rN46bGCLLqax28Cc2CPIVZYeJNTb3XYAaMYEumTGQiIVeS774BxMD7c9KXmTft+B83jeJhr2Nh3+WONlPX6EaQlvVeFGagQ3ZSywEKBwUVjJ/8zrN2RyFjy5zRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx+ZkUNViby6bGHW0CfkyVdofYc/By/NG6mnC2bEI2k=;
 b=iZTujEaST/b6sZpljPqQQ5JceuJZ1pIZbiSdO00+uyq5z0LPvOWOaPlS1X6EZ4ccLQ8vyBxtbQQBvCQyn8/3ah6IWvrtSeDDXoEBchCdyKti/vP1HKtxeSheClDOyK2FLzdDsj8/oTBm2iKRId9iPDlGXYbSOiBP+0BW7LlND+Y=
Received: from CH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::17)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:26 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::59) by CH5P222CA0008.outlook.office365.com
 (2603:10b6:610:1ee::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:19 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:19 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 36/82] drm/amd/display: Cover
 amdgpu_dm_create_validate_stream_for_sink
Date: Tue, 18 Aug 2026 16:15:28 -0400
Message-ID: <20260818202139.4172592-37-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c1f2e7-56bb-4bdc-4a93-08defd666b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5wZBY/nF2KGhugyuH99bwJK2awQKZPZLUfptQV5ktHTe38Os6HrQo/GSUN+Y9HQy/MIGclsjoee/pkAF3kY/vqYusiR7GL6hGeGJ+cW+NCcObsS4OjkWbY8oRcwiATqNMhPOuLkiSzxddpIw6JCkLRf+HVG0vRJ8EJBVatsy3dg3F25aOo5mXNgb0CjTJpt/PpvP4Y9UhNTrcCLOIb5TN5nYbRhz6NPF1/HBiATSxxgC8i+AbYJVG1QfaGBL0sXD2kH05IuUXRNCpcQvdQXIF3ADjt5tPcTGmlcFwVN02PcgMNM7H/KsvSuLIuYRqX+dQJ63oVqL6fqsDMQBpPpDsYbUKRSdcyzfjjn8N4DFJXohpdD02NrgvEHJozQoZp5QYZ8r9U5TGyVID3pWC24ShNZuq3uE0c1cr9E503ZILRDCbuWzHPthwAh1RjFJRL8ZwwYaxwJQ+eSrxv50El1MVkihl01Aprzyq2uBPhuUlsi06yyRdep7qOyR85evT0dkvvPHNxpCWz1H1AKxibAtUduf/3RKBWGrlfUXiqLefCHoeLFVvS7YvbjuNKwmOLZ7kxr+dgtCE+ON0tNzvZcvyuGiWyIakkMvY+2HVbNM5X8yy2goXBSmTW+ogZGJreGnPtO4sz8SRzdr9iytHr3gq5dL6lOtUew/9DVQ/wF6r9uVlvb9e7y+Vd6AQ3qXKtMN7sb3upiP5X7UnVlK2tlTUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S7jGtP9+8xcc31838Z38qbi8ee7S+87C6Ob6XS2dcweBrW+ctqHAOgRrUeVB2nR9GU7aQz5btc4GThnaL3PgTMBvcYPHehX4Dr9dcc8A6gXd92f1ZQBU31PVFPt5IyYIsCnA2mfzUfMD+EEad+Kh9ryIQ16HsM6sm4c2U899v9HLUKekJEhsnWL7OA/YohrryhDWsiH5kSnpZGrUQt6clAxgc6AuTr1xLrOXrZ9NGzlN9puRNT6VQmNueg3bmIZ/1VvbJYOQq5bRRjpGJNcGLz3zcAVQ7Xbt38mxZeBeoGes7CgCdIgBLHjl+CRPkQNpoy19YybValIzMFb489P0s10THDAPCBHGWOt9ShaRv7tvCJ+7htuspxc/EJSzGBsUboLk4mqkZcIrfPPvUcmhr5f9JTN2rty/e94deL2XZgwYN7zSdV/T9xnZY9qMxRg4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:25.8784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c1f2e7-56bb-4bdc-4a93-08defd666b24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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

Add KUnit tests for amdgpu_dm_create_validate_stream_for_sink()
covering the writeback connector path, the colour-depth downgrade when
no valid bpc is found, the HDMI YCbCr and forced YCbCr420/422/444
output paths, and the timing/context prune-and-retry loops.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 416 ++++++++++++++++++
 1 file changed, 416 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 54d6d2acdd7dc..b9b32194a657f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -5854,6 +5854,414 @@ static void dm_test_create_validate_stream_null_dm_state(struct kunit *test)
 								    NULL, NULL, NULL));
 }
 
+/* Tests for amdgpu_dm_create_validate_stream_for_sink() */
+
+/*
+ * Build a connector embedded in an amdgpu_device (so drm_to_adev() resolves)
+ * carrying a dc_link but a deliberately low atomic-requested bpc. Every
+ * candidate colour depth then exceeds that cap, so bpc_mask ends up empty and
+ * the enumeration returns NULL before create_stream_for_sink() and
+ * dc_validate_stream() (and thus the unpopulated dc handle) are ever reached.
+ * This lets the encoding/bpc mask-building branches be exercised on their own.
+ */
+struct dm_test_cvs_ctx {
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+	struct dm_connector_state *dm_state;
+	struct drm_display_mode *mode;
+};
+
+static struct dm_test_cvs_ctx *
+dm_test_cvs_ctx_alloc(struct kunit *test, int connector_type)
+{
+	struct dm_test_cvs_ctx *ctx;
+	struct device *dev;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	ctx->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+			sizeof(*ctx->adev),
+			offsetof(struct amdgpu_device, ddev),
+			DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
+	ctx->adev = drm_to_adev(ctx->drm);
+
+	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector),
+			GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	KUNIT_ASSERT_EQ(test,
+			drmm_connector_init(ctx->drm, &ctx->aconnector->base,
+			&dm_test_connector_funcs, connector_type,
+			NULL), 0);
+
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	ctx->aconnector->dc_link = ctx->link;
+
+	ctx->dm_state = kunit_kzalloc(test, sizeof(*ctx->dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dm_state);
+	ctx->dm_state->base.max_requested_bpc = 4;
+
+	ctx->mode = kunit_kzalloc(test, sizeof(*ctx->mode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->mode);
+	ctx->mode->hdisplay = 1920;
+	ctx->mode->vdisplay = 1080;
+
+	return ctx;
+}
+
+/**
+ * dm_test_create_validate_stream_writeback - Test the writeback stream path
+ * @test: The KUnit test context
+ *
+ * A writeback connector has no sink EDID to enumerate, so the helper builds and
+ * returns a single RGB stream directly instead of running the validation loop.
+ */
+static void dm_test_create_validate_stream_writeback(struct kunit *test)
+{
+	struct amdgpu_dm_wb_connector *wbcon;
+	struct dm_connector_state *dm_state;
+	struct drm_display_mode *mode;
+	struct dc_stream_state *stream;
+	struct amdgpu_device *adev;
+	struct dc_context *dc_ctx;
+	struct drm_device *drm;
+	struct dc_link *link;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*adev),
+			offsetof(struct amdgpu_device, ddev),
+			DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	adev = drm_to_adev(drm);
+
+	wbcon = drmm_kzalloc(drm, sizeof(*wbcon), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, wbcon);
+	KUNIT_ASSERT_EQ(test,
+			drmm_connector_init(drm, &wbcon->base.base,
+			&dm_test_connector_funcs,
+			DRM_MODE_CONNECTOR_WRITEBACK, NULL), 0);
+
+	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_ctx);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	link->ctx = dc_ctx;
+	link->connector_signal = SIGNAL_TYPE_VIRTUAL;
+	wbcon->link = link;
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	dm_state->scaling = RMX_OFF;
+
+	mode = kunit_kzalloc(test, sizeof(*mode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	mode->hdisplay = 1920;
+	mode->vdisplay = 1080;
+	mode->clock = 148500;
+
+	stream = amdgpu_dm_create_validate_stream_for_sink(&wbcon->base.base,
+							   mode, dm_state, NULL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_validate_stream_no_valid_bpc - Test the exhausted-mask path
+ * @test: The KUnit test context
+ *
+ * On a plain DisplayPort sink using the default RGB encoding but a bpc cap below
+ * every candidate depth, no (encoding, bpc) pair is attempted and the helper
+ * returns NULL without touching the dc handle.
+ */
+static void dm_test_create_validate_stream_no_valid_bpc(struct kunit *test)
+{
+	struct dm_test_cvs_ctx *ctx =
+		dm_test_cvs_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dc_stream_state *stream;
+
+	ctx->link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	stream = amdgpu_dm_create_validate_stream_for_sink(&ctx->aconnector->base,
+							   ctx->mode,
+							   ctx->dm_state, NULL);
+	KUNIT_EXPECT_NULL(test, stream);
+}
+
+/**
+ * dm_test_create_validate_stream_hdmi_ycbcr - Test the HDMI encoding mask
+ * @test: The KUnit test context
+ *
+ * A native HDMI sink advertising YCbCr 4:4:4 and 4:2:2 exercises HDMI endpoint
+ * detection and the YCbCr444/YCbCr422 mask branches; the low bpc cap still
+ * prunes every depth, so the helper returns NULL.
+ */
+static void dm_test_create_validate_stream_hdmi_ycbcr(struct kunit *test)
+{
+	struct dm_test_cvs_ctx *ctx =
+		dm_test_cvs_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_stream_state *stream;
+
+	ctx->link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	ctx->aconnector->base.display_info.color_formats =
+		BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
+		BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
+
+	stream = amdgpu_dm_create_validate_stream_for_sink(&ctx->aconnector->base,
+							   ctx->mode,
+							   ctx->dm_state, NULL);
+	KUNIT_EXPECT_NULL(test, stream);
+}
+
+/**
+ * dm_test_create_validate_stream_force_ycbcr420 - Test the forced YCbCr420 mask
+ * @test: The KUnit test context
+ *
+ * force_yuv_pixel_format pins the encoding mask to YCbCr420 even on an RGB sink;
+ * the low bpc cap prunes every depth, so the helper returns NULL.
+ */
+static void dm_test_create_validate_stream_force_ycbcr420(struct kunit *test)
+{
+	struct dm_test_cvs_ctx *ctx =
+		dm_test_cvs_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dc_stream_state *stream;
+
+	ctx->link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	ctx->aconnector->force_yuv_pixel_format = PIXEL_ENCODING_YCBCR420;
+
+	stream = amdgpu_dm_create_validate_stream_for_sink(&ctx->aconnector->base,
+							   ctx->mode,
+							   ctx->dm_state, NULL);
+	KUNIT_EXPECT_NULL(test, stream);
+}
+
+/**
+ * dm_test_create_validate_stream_force_ycbcr422 - Test the forced YCbCr422 mask
+ * @test: The KUnit test context
+ *
+ * With the sink advertising YCbCr 4:2:2, a force_yuv override pins the encoding
+ * mask to YCbCr422; the low bpc cap prunes every depth, so the helper returns
+ * NULL.
+ */
+static void dm_test_create_validate_stream_force_ycbcr422(struct kunit *test)
+{
+	struct dm_test_cvs_ctx *ctx =
+		dm_test_cvs_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dc_stream_state *stream;
+
+	ctx->link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	ctx->aconnector->force_yuv_pixel_format = PIXEL_ENCODING_YCBCR422;
+	ctx->aconnector->base.display_info.color_formats =
+		BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
+
+	stream = amdgpu_dm_create_validate_stream_for_sink(&ctx->aconnector->base,
+							   ctx->mode,
+							   ctx->dm_state, NULL);
+	KUNIT_EXPECT_NULL(test, stream);
+}
+
+/**
+ * dm_test_create_validate_stream_force_ycbcr444 - Test the forced YCbCr444 mask
+ * @test: The KUnit test context
+ *
+ * On a native HDMI sink advertising YCbCr 4:4:4, a force_yuv override pins the
+ * encoding mask to YCbCr444; the low bpc cap prunes every depth, so the helper
+ * returns NULL.
+ */
+static void dm_test_create_validate_stream_force_ycbcr444(struct kunit *test)
+{
+	struct dm_test_cvs_ctx *ctx =
+		dm_test_cvs_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_stream_state *stream;
+
+	ctx->link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	ctx->aconnector->force_yuv_pixel_format = PIXEL_ENCODING_YCBCR444;
+	ctx->aconnector->base.display_info.color_formats =
+		BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
+
+	stream = amdgpu_dm_create_validate_stream_for_sink(&ctx->aconnector->base,
+							   ctx->mode,
+							   ctx->dm_state, NULL);
+	KUNIT_EXPECT_NULL(test, stream);
+}
+
+/*
+ * Drive the enumeration loop far enough to reach create_stream_for_sink() and
+ * dc_validate_stream() by providing a valid bpc plus a minimal fake dc. The
+ * connector carries a dc_link with a dc_context so a fake VIRTUAL sink and its
+ * stream can be built; adev->dm.dc is wired with just enough resource_pool /
+ * timing_generator / link_service state for dc_validate_stream() and
+ * dm_validate_stream_and_context() to run without a real pipe allocator.
+ */
+struct dm_test_cvs_dc {
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+	struct dm_connector_state *dm_state;
+	struct drm_display_mode *mode;
+	struct dc *dc;
+	struct timing_generator_funcs *tgfuncs;
+	struct link_service *link_srv;
+};
+
+static bool dm_test_cvs_validate_timing_fail(struct timing_generator *tg,
+					     const struct dc_crtc_timing *timing)
+{
+	return false;
+}
+
+static bool dm_test_cvs_validate_timing_ok(struct timing_generator *tg,
+					   const struct dc_crtc_timing *timing)
+{
+	return true;
+}
+
+static enum dc_status dm_test_cvs_validate_mode_timing_ok(
+		const struct dc_stream_state *stream,
+		struct dc_link *link,
+		const struct dc_crtc_timing *timing)
+{
+	return DC_OK;
+}
+
+static struct dm_test_cvs_dc *dm_test_cvs_dc_alloc(struct kunit *test)
+{
+	struct timing_generator_funcs *tgfuncs;
+	struct resource_funcs *rfuncs;
+	struct resource_caps *rcaps;
+	struct resource_pool *pool;
+	struct timing_generator *tg;
+	struct dc_context *dcc;
+	struct dal_logger *logger;
+	struct dm_test_cvs_dc *c;
+	struct device *dev;
+
+	c = kunit_kzalloc(test, sizeof(*c), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	c->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+			sizeof(*c->adev),
+			offsetof(struct amdgpu_device, ddev),
+			DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, c->drm);
+	c->adev = drm_to_adev(c->drm);
+
+	c->aconnector = drmm_kzalloc(c->drm, sizeof(*c->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->aconnector);
+	KUNIT_ASSERT_EQ(test,
+			drmm_connector_init(c->drm, &c->aconnector->base,
+			&dm_test_connector_funcs,
+			DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
+	c->aconnector->base.display_info.bpc = 8;
+
+	dcc = kunit_kzalloc(test, sizeof(*dcc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dcc);
+	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, logger);
+	logger->dev = c->drm;
+	dcc->logger = logger;
+
+	c->link = kunit_kzalloc(test, sizeof(*c->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->link);
+	c->link->ctx = dcc;
+	c->link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	c->link->ep_type = DISPLAY_ENDPOINT_UNKNOWN;
+	c->aconnector->dc_link = c->link;
+
+	pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pool);
+	rfuncs = kunit_kzalloc(test, sizeof(*rfuncs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, rfuncs);
+	rcaps = kunit_kzalloc(test, sizeof(*rcaps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, rcaps);
+	tg = kunit_kzalloc(test, sizeof(*tg), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tg);
+	tgfuncs = kunit_kzalloc(test, sizeof(*tgfuncs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tgfuncs);
+	c->tgfuncs = tgfuncs;
+	c->link_srv = kunit_kzalloc(test, sizeof(*c->link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->link_srv);
+
+	tg->funcs = tgfuncs;
+	pool->funcs = rfuncs;
+	pool->res_cap = rcaps;
+	pool->timing_generators[0] = tg;
+	pool->timing_generator_count = 0;
+
+	c->dc = kunit_kzalloc(test, sizeof(*c->dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->dc);
+	c->dc->ctx = dcc;
+	c->dc->res_pool = pool;
+	c->dc->link_srv = c->link_srv;
+	c->adev->dm.dc = c->dc;
+
+	c->dm_state = kunit_kzalloc(test, sizeof(*c->dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->dm_state);
+	c->dm_state->base.max_requested_bpc = 8;
+	c->dm_state->scaling = RMX_OFF;
+
+	c->mode = kunit_kzalloc(test, sizeof(*c->mode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->mode);
+	c->mode->hdisplay = 1920;
+	c->mode->vdisplay = 1080;
+	c->mode->clock = 148500;
+
+	return c;
+}
+
+/**
+ * dm_test_create_validate_stream_prune_timing - Test the dc_validate_stream prune
+ * @test: The KUnit test context
+ *
+ * A built stream fails dc_validate_stream() (timing_generator rejects the
+ * timing), so every candidate is pruned and released and the helper returns
+ * NULL once the enumeration is exhausted.
+ */
+static void dm_test_create_validate_stream_prune_timing(struct kunit *test)
+{
+	struct dm_test_cvs_dc *c = dm_test_cvs_dc_alloc(test);
+
+	c->tgfuncs->validate_timing = dm_test_cvs_validate_timing_fail;
+
+	KUNIT_EXPECT_NULL(test,
+			  amdgpu_dm_create_validate_stream_for_sink(&c->aconnector->base,
+								    c->mode,
+								    c->dm_state,
+								    NULL));
+}
+
+/**
+ * dm_test_create_validate_stream_prune_context - Test the context-validation prune
+ * @test: The KUnit test context
+ *
+ * dc_validate_stream() succeeds but dm_validate_stream_and_context() fails (no
+ * pipe allocator), exercising the DC_OK sub-branches and MST check before the
+ * candidate is pruned; the exhausted enumeration returns NULL.
+ */
+static void dm_test_create_validate_stream_prune_context(struct kunit *test)
+{
+	struct dm_test_cvs_dc *c = dm_test_cvs_dc_alloc(test);
+
+	c->tgfuncs->validate_timing = dm_test_cvs_validate_timing_ok;
+	c->link_srv->validate_mode_timing = dm_test_cvs_validate_mode_timing_ok;
+
+	KUNIT_EXPECT_NULL(test,
+			  amdgpu_dm_create_validate_stream_for_sink(&c->aconnector->base,
+								    c->mode,
+								    c->dm_state,
+								    NULL));
+}
+
 /**
  * dm_test_update_after_detect_mst_noop - Test MST connectors are left to drm_mst
  * @test: The KUnit test context
@@ -6716,6 +7124,14 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_s3_handle_hdmi_cec_resume),
 	/* amdgpu_dm_create_validate_stream_for_sink */
 	KUNIT_CASE(dm_test_create_validate_stream_null_dm_state),
+	KUNIT_CASE(dm_test_create_validate_stream_writeback),
+	KUNIT_CASE(dm_test_create_validate_stream_no_valid_bpc),
+	KUNIT_CASE(dm_test_create_validate_stream_hdmi_ycbcr),
+	KUNIT_CASE(dm_test_create_validate_stream_force_ycbcr420),
+	KUNIT_CASE(dm_test_create_validate_stream_force_ycbcr422),
+	KUNIT_CASE(dm_test_create_validate_stream_force_ycbcr444),
+	KUNIT_CASE(dm_test_create_validate_stream_prune_timing),
+	KUNIT_CASE(dm_test_create_validate_stream_prune_context),
 	/* amdgpu_dm_update_connector_after_detect */
 	KUNIT_CASE(dm_test_update_after_detect_mst_noop),
 	KUNIT_CASE(dm_test_update_after_detect_sink_unchanged),
-- 
2.43.0


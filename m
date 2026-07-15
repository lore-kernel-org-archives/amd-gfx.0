Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1945C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A8610F07F;
	Wed, 15 Jul 2026 13:46:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yf6xeWyh";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013064.outbound.protection.outlook.com
 [40.93.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D8AB10E1B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuFXPjSW465TV9rn3mNJjP/gqwb0LTAKcOe9fKCUK7HBFj03vxIm4W4ru2e0uU4bFhnmJlnMGxFbO9Sh/x620UOZ1WHI8BpLzBEplY5SuWh2r+13VxmUsNmqbR0Kja2PVDmLkGXWLwTvxDKgWJpWNukBRvW99GynMg5HnWDjDiVNeAb6t48GEIo/a11dItxFK5g4U1u1+1s0hahxf8025XPUWqjOG6CLGQTSRgpOoC9gB22xLgxhAPD6PT11lbXtNGZcUtpoGIIK7Xp72TDtEZ8T1DlUi46g+cMY4xqUJc6zpXVRrkB/rStArq+S7iCn5YPCBoZoYhoVXn6WRXD0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvqL3qBxqoiOMoVNG4aC2tH4HZFg6O6QSB2JopWSy+E=;
 b=hyRceb0AoVmpf4lWdr075H0is00u8sTeHZ3/SGi2bIuGImdyefaXKXf7fk7ODCynM2fiMYYn1oA9IeAEQ8niJrrXNDKZvWK6HfJ7awY+Pvm1Bp/23HiM2JG7XcG0QQsPH4iwrkMwICtLvMNi0+aECr3iESk5FjmsTCRWiTbp2AGFOvbv1Ohu9G43MuAUYGkgOEpBG+I0o3yJHtTRlLLQXQ2wGU0HjJnFv142+Mp0cNgufYKvZeX9RVuWVb4Tz0hb+nAIqq8Zxk9leQeOyCtGXI1skFHLJV6gLvamP69MyTVvObS3Eticke5t7U7dUGQzYcqNI6zlSnkx2QwIrJ4xSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvqL3qBxqoiOMoVNG4aC2tH4HZFg6O6QSB2JopWSy+E=;
 b=yf6xeWyhMf/5iAdyjagWWOIQNbfvz49v/V9WUdTaeh3dAjrdvUn2B9Y4jrvqcHWRfW15wVgetnW4OG6Jro+Y1hsmw7tyygIw16f10YlFWfCZYUJKTRsTtwVDjRJWdiixbNiB1LTVeeyc9qfCktJis5nY5dc+nLMMRldQGdQlppo=
Received: from SJ2P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::9)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Wed, 15 Jul 2026 13:46:17 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::41) by SJ2P220CA0012.outlook.office365.com
 (2603:10b6:a03:5da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:05 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:01 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 19/70] drm/amd/display: Add destroy tests for connector
Date: Wed, 15 Jul 2026 21:37:29 +0800
Message-ID: <20260715134432.1975118-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 295b5808-be05-441b-8d84-08dee27771b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|5023799004|6133799003|56012099006|18002099003|22082099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: NMi9AGV25hrZAEXyjAfdlOigx8q4iX7fxj4VryBdVWZm83otXG+NGFiIYBHShnM3jAZP1+/BtHNTKEV7KUEMdKs3/nO5KHK8PDccVWtIv6kJO2DdWM9AhB8YDBnVPVXnrd6zl6DS8OO9lNWJKBdUs0mzC4HnmJuLNYBIPhRrzsMDRWrLd5ZlMfewQmCX9MRw2SJG14Ob5XEFqQ4PhtIJFrBD4o+DBiEksEiX9b2ek4WzlbDrmTp50xJuS1vahS7b8l6BTwz6UeDj6UDtFGThOASj7VEpo84cySneh5RDMqtU4g0WB/lV1bCSJxZOjU7okO7YUDTF0w5LbgnNaPXfr7m07OyWajp60rq77i0efcF3bWcdswlEnqEb1LkO9yJ4a7GWePUYU00Q4zmd2xvSQwqaoW7Kezq4/xAZYNWhVBmm9Jn6POGfWXw0c0XvbSTIzgu8GiZu0g9/Iju9eopN4J+llWhCmhZzlD/zdADTPENkq10Y86mMVmd5n8kxcNf35T5v8sX55wvD6/5KDCpU+USN4MY8S2Mk7j3XIZ90WCbxY5FDDpSWvJdi3VqQDXJj/d0uJZSWNP7UM/vQeCwOklaTS9UZng9k94aHdNiXxzrBj80c4K4YwGBaZSNnTAZJXW1sJMLWcu4TC/JTB6lbdE7HPL2zpT250zwDSy6J8lUaSPQO11IeV/KXGZ4a/f/eWr5JLYv7imNvqL1ECTb3VQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(5023799004)(6133799003)(56012099006)(18002099003)(22082099003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cr71zjTkW0KefYAT1hzdyaW3NNnpT7u4NE3RzNDJXTkrFs7ABl6v525MG2c3mp1tHVEpMf0wbDUsq37+/4F9b5d4QYcIm0yC/JtZcWb1r/2Zf1YplE+wOpR6vQxzWrfFuNKYzyEAemmUGm4uPoXrZtlrkP0U+D9a0QNu9cF6QXTVwT1ID5HpEGmv2XFXF1vLnwapV6y8u6cfUNF4W4pHEzZ+jQCgIMQnq8xOouh2Ecy5UyPd7VqFd3a9RDNjQGqa+JrAzN1bvJoS0dnkRTCu2dw8AXNI6AZnIEVAljR8HptmkMD4qulJzQPrdhxPzZb3gjouUMhP+iBr/FjCeZfyTsRdmE+B269ZQazZVbuJcdPWdrytcVEfEQDYscGyoLp6L4bd/Zgc+4EZtiRbSsLPK9Hrm0xTVUTFkwteP1Pygf3WCc6vxvXXRYC6o4ns/9uk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:16.8762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 295b5808-be05-441b-8d84-08dee27771b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
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

Add KUnit coverage for amdgpu_dm_connector_destroy(): minimal
teardown plus releasing the dc_sink and dc_em_sink references.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 149 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c |   1 +
 4 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 131387524aa9..d1c95199d598 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1776,7 +1776,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_unregister(struct drm_connector *conne
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_unregister);
 
-static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
@@ -1817,6 +1817,7 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 
 	kfree(connector);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_destroy);
 
 void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index f7057e83b4d5..22423e878b64 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -170,6 +170,7 @@ enum drm_connector_status
 amdgpu_dm_connector_detect(struct drm_connector *connector, bool force);
 void amdgpu_dm_connector_unregister(struct drm_connector *connector);
 int amdgpu_dm_connector_late_register(struct drm_connector *connector);
+void amdgpu_dm_connector_destroy(struct drm_connector *connector);
 enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state);
 bool adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 645347994734..efaf5730e893 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -3989,6 +3989,151 @@ static void dm_test_unregister_non_dp_noop(struct kunit *test)
 	amdgpu_dm_connector_unregister(&aconnector->base);
 }
 
+/* Tests for amdgpu_dm_connector_destroy() */
+
+/*
+ * amdgpu_dm_connector_destroy() ends with drm_connector_cleanup() followed by
+ * kfree(connector), so the connector must be initialised with the unmanaged
+ * drm_connector_init() and allocated with kzalloc() (the function frees it, so
+ * kunit_kzalloc() would double free at teardown). It is embedded in an
+ * amdgpu_device so drm_to_adev() resolves and a dc_link carries a dc_context so
+ * dc_sink_create() works for the sink-release branches.
+ */
+struct dm_test_destroy_ctx {
+	struct drm_device *drm;
+	struct dc_context *dc_ctx;
+	struct dc_link *link;
+};
+
+static struct dm_test_destroy_ctx *dm_test_destroy_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_destroy_ctx *ctx;
+	struct amdgpu_device *adev;
+	struct device *dev;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	ctx->drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*adev),
+						       offsetof(struct amdgpu_device, ddev),
+						       DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
+
+	ctx->dc_ctx = kunit_kzalloc(test, sizeof(*ctx->dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc_ctx);
+
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	ctx->link->ctx = ctx->dc_ctx;
+
+	return ctx;
+}
+
+/*
+ * Allocate a connector the destroy path can free. Uses kzalloc() (not
+ * kunit_kzalloc) and the unmanaged drm_connector_init() because the function
+ * under test calls drm_connector_cleanup() + kfree(connector).
+ *
+ * drm_connector_init() requires funcs->destroy to be set, so a dedicated funcs
+ * table wires it to amdgpu_dm_connector_destroy() (the test invokes it
+ * directly; the connector is removed from the device before teardown).
+ */
+static const struct drm_connector_funcs dm_test_destroy_funcs = {
+	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.destroy = amdgpu_dm_connector_destroy,
+};
+
+static struct amdgpu_dm_connector *
+dm_test_destroy_connector(struct kunit *test, struct drm_device *drm)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	KUNIT_ASSERT_EQ(test,
+		drm_connector_init(drm, &aconnector->base,
+				   &dm_test_destroy_funcs,
+				   DRM_MODE_CONNECTOR_VGA), 0);
+	aconnector->bl_idx = -1;
+
+	return aconnector;
+}
+
+/**
+ * dm_test_destroy_minimal - Test destroy tears down a bare connector
+ * @test: The KUnit test context
+ *
+ * With no MST, backlight, sinks or registered AUX/CEC, destroy must clean up
+ * and free the connector without crashing.
+ */
+static void dm_test_destroy_minimal(struct kunit *test)
+{
+	struct dm_test_destroy_ctx *ctx = dm_test_destroy_ctx_alloc(test);
+	struct amdgpu_dm_connector *aconnector =
+		dm_test_destroy_connector(test, ctx->drm);
+
+	amdgpu_dm_connector_destroy(&aconnector->base);
+}
+
+/**
+ * dm_test_destroy_releases_dc_sink - Test destroy releases the dc_sink
+ * @test: The KUnit test context
+ */
+static void dm_test_destroy_releases_dc_sink(struct kunit *test)
+{
+	struct dm_test_destroy_ctx *ctx = dm_test_destroy_ctx_alloc(test);
+	struct amdgpu_dm_connector *aconnector =
+		dm_test_destroy_connector(test, ctx->drm);
+	struct dc_sink_init_data sink_init = { 0 };
+	struct dc_sink *sink;
+
+	sink_init.link = ctx->link;
+	sink_init.sink_signal = SIGNAL_TYPE_VIRTUAL;
+	sink = dc_sink_create(&sink_init);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	/* Extra reference so the sink survives destroy for inspection. */
+	dc_sink_retain(sink);
+	aconnector->dc_sink = sink;
+
+	amdgpu_dm_connector_destroy(&aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, (int)kref_read(&sink->refcount), 1);
+	dc_sink_release(sink);
+}
+
+/**
+ * dm_test_destroy_releases_dc_em_sink - Test destroy releases the emulated sink
+ * @test: The KUnit test context
+ */
+static void dm_test_destroy_releases_dc_em_sink(struct kunit *test)
+{
+	struct dm_test_destroy_ctx *ctx = dm_test_destroy_ctx_alloc(test);
+	struct amdgpu_dm_connector *aconnector =
+		dm_test_destroy_connector(test, ctx->drm);
+	struct dc_sink_init_data sink_init = { 0 };
+	struct dc_sink *sink;
+
+	sink_init.link = ctx->link;
+	sink_init.sink_signal = SIGNAL_TYPE_VIRTUAL;
+	sink = dc_sink_create(&sink_init);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	dc_sink_retain(sink);
+	aconnector->dc_em_sink = sink;
+
+	amdgpu_dm_connector_destroy(&aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, (int)kref_read(&sink->refcount), 1);
+	dc_sink_release(sink);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -4201,6 +4346,10 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_late_register_non_dp_succeeds),
 	/* amdgpu_dm_connector_unregister */
 	KUNIT_CASE(dm_test_unregister_non_dp_noop),
+	/* amdgpu_dm_connector_destroy */
+	KUNIT_CASE(dm_test_destroy_minimal),
+	KUNIT_CASE(dm_test_destroy_releases_dc_sink),
+	KUNIT_CASE(dm_test_destroy_releases_dc_em_sink),
 	{}
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
index 436d033361ab..79b9738e9c68 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
@@ -61,6 +61,7 @@ void dc_sink_retain(struct dc_sink *sink)
 {
 	kref_get(&sink->refcount);
 }
+EXPORT_IF_KUNIT(dc_sink_retain);
 
 static void dc_sink_free(struct kref *kref)
 {
-- 
2.43.0


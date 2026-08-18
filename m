Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062F4C5DF86
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A5710EC94;
	Tue, 18 Aug 2026 20:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MM65k9iI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C973010EC94
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNKw9apKeEQ4SZkbNpIuuHxMwh3yaBHyZGyYMVOXgA0OS1oXzuVDgmHI/DPRzpULWjNq80dm6tmjfNP1/9cxxwB1h/SNj/chtEQuYjfuVQgAaqrkinHNgSe3y8WC9cnCoO3GFbyrU24lO59/RrEZMeSgPrC3bcWEbEOE03u9DvOmy28NYQv+Kyt2fHEPIn2pRPtnjtGQcC+IdCDDA+0/i3XflV05wtDOwwdMQcqt0jnRNqMIzNqpVEatXx4YfPOCwuauOy0yUIbtwP353DsMeyUAT99eu96fiwXWU3IYCguHENqPkx+eYCOTYnl7oRfgprK/No7YdYL3bhaXCN+2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naoGM88KK9CY55c0hnknNyCHb0HX4kHi/o15gpnNG04=;
 b=QIhKUabIOFjykwumP0F5kGiSawUXnTuOrmmyeEn15XttdFYP8NoAwvFj/xGVXUbyKXUoVCqeuNcWHCWKwV0c2N3vYg1EZE1wZMH4HwOZezEaVTdYBSslBi5XrINSoqDSpiEjJTkojw2tGFCw01i+6bX5mvezbSIs1I6K3PiKS//6AcDMyqADLIoRG7q/DXZJJpxFfBlePG1Gf7HM/zE1WaIkpZMe8pTDm+DTl0tyvsWPw6bLAjQA8YHviwP7owagpzgY56s0Ko8HWK5hzruGRzOHMvYOrTWGY6FGtMeqorgARjbTIpcDSTebjF9JAqt5O6brXHDNwNdRd/I0K7+TXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naoGM88KK9CY55c0hnknNyCHb0HX4kHi/o15gpnNG04=;
 b=MM65k9iI4G5sxIKwPuK3vjygOu7B/jMXpK/AZWmoGw5owRh5ZcYgWOksY7Y+YUJMMYzfYmJWHkmBR/VVtCC/1SteI/abUPOJIgAWwILyoQYm2GkR9vr6hvBNi3pOUtQoFPSvgeX4dnrGrQzl8T5GfSwOIGvgjYn0ALpOIHjsvfU=
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:11 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::40) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:02 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:01 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 12/82] drm/amd/display: Cover
 amdgpu_dm_update_connector_after_detect
Date: Tue, 18 Aug 2026 16:15:04 -0400
Message-ID: <20260818202139.4172592-13-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: d02f7110-fbd7-4c72-c717-08defd66623d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: T7hn+Gsu6VSYYo2kk0IyT+0e6nMNmlclduPO1Q7B92mbw9PrJOCBUMSEsd/tuJ0Hzqi9KHOHqFAx76+TCL5OBOmAy5BztxBii7/iyta6EXgQPkXzmMIhSQiaKVopFHowp8GZkvP52EdQAB2LSoMt3Jek2YACcNuBeL2/0rD+ZiQYX8LTYQP+B+xAbbdNs0AmyVjI7aB44eA43Mx+Ay1OIrgNSuGHyiar4YRmP4vMzMuCsn62y54LWddFdFtj/OImtDDUdkLDTigy92OBGHJenYptEnk4uKOjT2fARk5yElpweye+KUe2VxArhhBY99NPPc0zkb3xoxvCzx1Q3/FyncEKa9arhF81UfdGFB2Flzx1YoHndGMMhATrZKMSObuLhjmnVMhh02VjrAFiUwxZBfxKasl+IRZDKu4vxOAGqHCpZ+NSkvKK550khospDu9qIpADVK3ec2Yq+R3QmHViYhCQUrbNrB+zlq1yVF1JRTgm22fX0Odxs1MwYlLk52c7Rc8y7Zqo3OG2Cwhc/UYpzERmzbz9KYsLjfxPaaab6Wj2BlzxLPbc06d6rjfCEmC+4kUugYrvMLuw10aGrNoBncaKWZOhqpFFVSlNLRCf/9+U5hwfdy4E0fAqfBLXmZ5T7fzluCR3teJ4/juc4TY/K3RATELtvHi7ev0Wfjf8W/J2yfnnBdBk7hTNib24W531mFKPZAS7V5QN9W0+anK2nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dWckEZD2qyjxRzBWGKFlxahPyNUUc2ACt3g/IuQPaFEmmR49lvWyoizXK+aKHGdPnEz2PNep1Y9N4I4gLhzBE5esVL2BRMhw4P4FN6hYFMOE1JBfuS8rEMji2n+H//UqoGTTosaYS6HBiw8ZANMQeR4YySb+3gq3uQQiT7q9nqOWg2T4mJkyik/9qiXfgS+H7n2/HNVvfx5v8qJEp8hRRlcfdDq+DdbseOL7Dv+Im/wFOqQ8dkFdd+rjVisfk+LHeW7X4EwO/5/OgAlYVzlaFyBD3V4PTujzNFSCBLOWwMlq0cZ3tc8ECH1q0pdGpFOCh9o7SA5+IImK4JmVdYZP4IswrRPfO5ZeRsKE2jyuc9ZYHR74ykote50+tBOfuy5KP+mkK7E+PKSbasLyXNUIpRdeGjvUs0yJ0ipCXbD6uA4mKx33fVgOqNNMnd0fl7sN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:10.9499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d02f7110-fbd7-4c72-c717-08defd66623d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
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

Add KUnit tests covering amdgpu_dm_update_connector_after_detect(): the
MST-sink early return, connect with and without EDID, disconnect teardown,
and the four forced emulated-sink paths. Sinks the function releases to
zero use real allocations while retained sinks use kunit-managed memory to
keep dc_sink refcounting balanced.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 331 ++++++++++++++++++
 1 file changed, 331 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 14240e6485049..61cd1ebe9fcd1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -5516,6 +5516,329 @@ static void dm_test_update_after_detect_sink_unchanged(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, aconnector->dc_sink);
 }
 
+/* Tests for amdgpu_dm_update_connector_after_detect() */
+
+/*
+ * A minimal but structurally valid 128-byte EDID base block (correct header
+ * and checksum) so drm_edid_alloc()/drm_edid_connector_update() accept it when
+ * exercising the "sink carries EDID" branch.
+ */
+static const u8 dm_test_uad_edid[128] = {
+	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x04, 0x21, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x04, 0x80, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5c,
+};
+
+/*
+ * Build an amdgpu_dm_connector registered against a real kunit drm_device that
+ * is embedded in an amdgpu_device, so drm_to_adev()/adev_to_drm() resolve for
+ * amdgpu_dm_update_connector_after_detect() and all of its helpers.
+ *
+ * bl_idx is forced to -1 and adev->dm.freesync_module is left NULL so the
+ * backlight, CEC and freesync helpers take their early-return paths and the
+ * test stays focused on the sink-adoption logic.
+ */
+struct dm_test_uad_ctx {
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+};
+
+static struct dm_test_uad_ctx *
+dm_test_uad_ctx_alloc(struct kunit *test, int connector_type)
+{
+	struct dm_test_uad_ctx *ctx;
+	struct device *dev;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
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
+	/* Keep the backlight/CEC/freesync helpers on their early-return paths. */
+	ctx->aconnector->bl_idx = -1;
+
+	return ctx;
+}
+
+/* A real (non-kunit) sink the function is expected to free via dc_sink_release. */
+static struct dc_sink *dm_test_uad_owned_sink(void)
+{
+	struct dc_sink *sink = kzalloc_obj(*sink, GFP_KERNEL);
+
+	if (sink)
+		kref_init(&sink->refcount);
+	return sink;
+}
+
+/* A kunit-managed sink that stays referenced (never released to zero). */
+static struct dc_sink *dm_test_uad_kept_sink(struct kunit *test)
+{
+	struct dc_sink *sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+
+	if (sink)
+		kref_init(&sink->refcount);
+	return sink;
+}
+
+/**
+ * dm_test_update_after_detect_mst_sink - Test an MST sink is left to drm_mst
+ * @test: The KUnit test context
+ *
+ * A local sink reporting SIGNAL_TYPE_DISPLAY_PORT_MST is handled by the
+ * drm_mst framework, so the function returns before adopting it.
+ */
+static void dm_test_update_after_detect_mst_sink(struct kunit *test)
+{
+	struct dm_test_uad_ctx *ctx =
+		dm_test_uad_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_sink *sink = dm_test_uad_kept_sink(test);
+
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	sink->sink_signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
+	ctx->link->local_sink = sink;
+
+	amdgpu_dm_update_connector_after_detect(ctx->aconnector);
+
+	KUNIT_EXPECT_NULL(test, ctx->aconnector->dc_sink);
+}
+
+/**
+ * dm_test_update_after_detect_connect_edid - Test adopting a new sink with EDID
+ * @test: The KUnit test context
+ *
+ * A freshly detected DisplayPort sink carrying EDID is adopted: the connector
+ * takes the sink, allocates a drm_edid and a requested-timing structure.
+ */
+static void dm_test_update_after_detect_connect_edid(struct kunit *test)
+{
+	struct dm_test_uad_ctx *ctx =
+		dm_test_uad_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_sink *sink = dm_test_uad_kept_sink(test);
+
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	sink->sink_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	memcpy(sink->dc_edid.raw_edid, dm_test_uad_edid, sizeof(dm_test_uad_edid));
+	sink->dc_edid.length = sizeof(dm_test_uad_edid);
+	ctx->link->local_sink = sink;
+	ctx->link->aux_mode = true;
+
+	amdgpu_dm_update_connector_after_detect(ctx->aconnector);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_sink, sink);
+	KUNIT_EXPECT_NOT_NULL(test, ctx->aconnector->timing_requested);
+
+	kfree(ctx->aconnector->timing_requested);
+	ctx->aconnector->timing_requested = NULL;
+}
+
+/**
+ * dm_test_update_after_detect_replace_no_edid - Test replacing a sink with no
+ * EDID and HDMI compression auto
+ * @test: The KUnit test context
+ *
+ * When a new EDID-less sink replaces an existing one, the old sink is released
+ * and, with hdmi_comp_auto set, an HDMI sink signal is promoted to FRL.
+ */
+static void dm_test_update_after_detect_replace_no_edid(struct kunit *test)
+{
+	struct dm_test_uad_ctx *ctx =
+		dm_test_uad_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_sink *old_sink = dm_test_uad_owned_sink();
+	struct dc_sink *new_sink = dm_test_uad_kept_sink(test);
+
+	KUNIT_ASSERT_NOT_NULL(test, old_sink);
+	KUNIT_ASSERT_NOT_NULL(test, new_sink);
+
+	ctx->aconnector->dc_sink = old_sink;
+	new_sink->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	new_sink->dc_edid.length = 0;
+	ctx->link->local_sink = new_sink;
+	ctx->link->aux_mode = true;
+	ctx->aconnector->hdmi_comp_auto = true;
+
+	amdgpu_dm_update_connector_after_detect(ctx->aconnector);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_sink, new_sink);
+	KUNIT_EXPECT_EQ(test, (int)new_sink->sink_signal,
+			(int)SIGNAL_TYPE_HDMI_FRL);
+}
+
+/**
+ * dm_test_update_after_detect_disconnect - Test tearing down on unplug
+ * @test: The KUnit test context
+ *
+ * With no local sink but an existing dc_sink, the disconnect path releases the
+ * sink, clears modes/timing, downgrades content protection and notifies audio.
+ */
+static void dm_test_update_after_detect_disconnect(struct kunit *test)
+{
+	struct dm_test_uad_ctx *ctx =
+		dm_test_uad_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_sink *old_sink = dm_test_uad_owned_sink();
+	struct dc_crtc_timing *timing = kzalloc_obj(*timing, GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, old_sink);
+	KUNIT_ASSERT_NOT_NULL(test, timing);
+
+	mutex_init(&ctx->adev->dm.audio_lock);
+	ctx->aconnector->dc_sink = old_sink;
+	ctx->aconnector->timing_requested = timing;
+	ctx->aconnector->num_modes = 3;
+	ctx->aconnector->audio_inst = 5;
+	ctx->link->local_sink = NULL;
+
+	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
+	ctx->aconnector->base.state->content_protection =
+		DRM_MODE_CONTENT_PROTECTION_ENABLED;
+
+	amdgpu_dm_update_connector_after_detect(ctx->aconnector);
+
+	KUNIT_EXPECT_NULL(test, ctx->aconnector->dc_sink);
+	KUNIT_EXPECT_NULL(test, ctx->aconnector->timing_requested);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->num_modes, 0);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->audio_inst, -1);
+	KUNIT_EXPECT_EQ(test,
+			(int)ctx->aconnector->base.state->content_protection,
+			(int)DRM_MODE_CONTENT_PROTECTION_DESIRED);
+}
+
+/**
+ * dm_test_update_after_detect_force_em_adopt - Test forced eml_sink adoption
+ * @test: The KUnit test context
+ *
+ * A forced connector with an emulated sink adopts a newly reported local sink
+ * under the mode_config lock.
+ */
+static void dm_test_update_after_detect_force_em_adopt(struct kunit *test)
+{
+	struct dm_test_uad_ctx *ctx =
+		dm_test_uad_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_sink *em_sink = dm_test_uad_kept_sink(test);
+	struct dc_sink *sink = dm_test_uad_kept_sink(test);
+
+	KUNIT_ASSERT_NOT_NULL(test, em_sink);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	ctx->aconnector->base.force = DRM_FORCE_ON;
+	ctx->aconnector->dc_em_sink = em_sink;
+	ctx->link->local_sink = sink;
+
+	amdgpu_dm_update_connector_after_detect(ctx->aconnector);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_sink, sink);
+}
+
+/**
+ * dm_test_update_after_detect_force_em_replace - Test forced eml_sink replace
+ * @test: The KUnit test context
+ *
+ * A forced connector that already has a dc_sink releases it before adopting the
+ * newly reported local sink.
+ */
+static void dm_test_update_after_detect_force_em_replace(struct kunit *test)
+{
+	struct dm_test_uad_ctx *ctx =
+		dm_test_uad_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_sink *em_sink = dm_test_uad_kept_sink(test);
+	struct dc_sink *old_sink = dm_test_uad_owned_sink();
+	struct dc_sink *new_sink = dm_test_uad_kept_sink(test);
+
+	KUNIT_ASSERT_NOT_NULL(test, em_sink);
+	KUNIT_ASSERT_NOT_NULL(test, old_sink);
+	KUNIT_ASSERT_NOT_NULL(test, new_sink);
+
+	ctx->aconnector->base.force = DRM_FORCE_ON;
+	ctx->aconnector->dc_em_sink = em_sink;
+	ctx->aconnector->dc_sink = old_sink;
+	ctx->link->local_sink = new_sink;
+
+	amdgpu_dm_update_connector_after_detect(ctx->aconnector);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_sink, new_sink);
+}
+
+/**
+ * dm_test_update_after_detect_force_em_fake - Test forced fallback to eml_sink
+ * @test: The KUnit test context
+ *
+ * A forced connector with no local sink and no dc_sink falls back to using the
+ * emulated sink so a headless stream can still be faked.
+ */
+static void dm_test_update_after_detect_force_em_fake(struct kunit *test)
+{
+	struct dm_test_uad_ctx *ctx =
+		dm_test_uad_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_sink *em_sink = dm_test_uad_kept_sink(test);
+
+	KUNIT_ASSERT_NOT_NULL(test, em_sink);
+
+	ctx->aconnector->base.force = DRM_FORCE_ON;
+	ctx->aconnector->dc_em_sink = em_sink;
+	ctx->link->local_sink = NULL;
+
+	amdgpu_dm_update_connector_after_detect(ctx->aconnector);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_sink, em_sink);
+}
+
+/**
+ * dm_test_update_after_detect_force_em_keep - Test forced no-sink keeps dc_sink
+ * @test: The KUnit test context
+ *
+ * A forced connector with no local sink but an existing dc_sink keeps that sink
+ * (the emulated-sink fallback is skipped).
+ */
+static void dm_test_update_after_detect_force_em_keep(struct kunit *test)
+{
+	struct dm_test_uad_ctx *ctx =
+		dm_test_uad_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_sink *em_sink = dm_test_uad_kept_sink(test);
+	struct dc_sink *dc_sink = dm_test_uad_kept_sink(test);
+
+	KUNIT_ASSERT_NOT_NULL(test, em_sink);
+	KUNIT_ASSERT_NOT_NULL(test, dc_sink);
+
+	ctx->aconnector->base.force = DRM_FORCE_ON;
+	ctx->aconnector->dc_em_sink = em_sink;
+	ctx->aconnector->dc_sink = dc_sink;
+	ctx->link->local_sink = NULL;
+
+	amdgpu_dm_update_connector_after_detect(ctx->aconnector);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_sink, dc_sink);
+}
+
 /* Tests for amdgpu_dm_update_stream_scaling_settings() */
 
 /**
@@ -6007,6 +6330,14 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* amdgpu_dm_update_connector_after_detect */
 	KUNIT_CASE(dm_test_update_after_detect_mst_noop),
 	KUNIT_CASE(dm_test_update_after_detect_sink_unchanged),
+	KUNIT_CASE(dm_test_update_after_detect_mst_sink),
+	KUNIT_CASE(dm_test_update_after_detect_connect_edid),
+	KUNIT_CASE(dm_test_update_after_detect_replace_no_edid),
+	KUNIT_CASE(dm_test_update_after_detect_disconnect),
+	KUNIT_CASE(dm_test_update_after_detect_force_em_adopt),
+	KUNIT_CASE(dm_test_update_after_detect_force_em_replace),
+	KUNIT_CASE(dm_test_update_after_detect_force_em_fake),
+	KUNIT_CASE(dm_test_update_after_detect_force_em_keep),
 	/* amdgpu_dm_update_stream_scaling_settings */
 	KUNIT_CASE(dm_test_update_scaling_null_mode),
 	KUNIT_CASE(dm_test_update_scaling_fullscreen_default),
-- 
2.43.0


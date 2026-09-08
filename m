Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36032C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA1C810EB53;
	Tue,  8 Sep 2026 11:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rCYbdT0l";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010071.outbound.protection.outlook.com
 [52.101.193.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7FE10EB54
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGrNLpr4tvZv+yFqxSh/DkA9H02MV//GE0PPfKRKt8P7fKJ/sGP9NTTpC0y/57ezBeHhFojS+yOigChcAOrRq7i2pnokDrajWnTBcK0aO3WRJeoC/zPUFM9/hL5LY8Dg5sW2i6pH7xUYbwjx3/f6rkVkiadmpx+32dDsWiuIN4uuvpP9pLyYLsT5tKRD0vLAZCEqyCn7ve0GwyxaNjX3ATKQlWRr8DEuqxe8B3kKyWckORhyo8GqvtkrrqrIA+biJSYTxmPQr0jPaLK+SL8oOC8GFnEvoacLJOREpcP1mPLZ1nM1qF6up+u76ssTJMtIXd/9LZmvAuJJF4kEu3b/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEcP+Pdd3iQLWb+SmZps5BZD6rSE7LAM0RYz4uEzUok=;
 b=hqipQy8A1UQus8HvkTfvBC/VhPSys9aBBVZpeucLvm04J/saJtczc84QfO552BB3CwuqsY6rB2oGK8DsBsVwnCDVCvFfxXqO+Y+4ISRea6hRZIOqhXc4dJtx47gUM12jvyuB8GfNFj0xUQTh4ijZobHHg+qwHXwSSXUT7mHh9tG+xHgF83WB5B2oc3IK0Ltf1hgwvXhBrp9qZHtU+HyBZ8L5YVqU/D6zofoDnCK+n2Em8e7q4IApAuzXb+nZg2bxxB9Hj7ARsYJAr3v6GYYKUoWO4NnlED9E0dSzwF4nVyj5Pmtpju8cZgf4zRJ6ea8m8KU8FGl6ayNrQmQH4s7xcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEcP+Pdd3iQLWb+SmZps5BZD6rSE7LAM0RYz4uEzUok=;
 b=rCYbdT0lJj026VITVmnt5Tutwmgx3CNTBS3dDk043d6o/lXCxm7TDGxAEbuW8Pf5GglXRtLAM44cwwh2Yip0NDs5Z23+2w0isddS2O7EBH4f7zJtSGQqSMBYiq4BaYduhKlePPUT2oOgE9DU3/FgE2gPMXfTDnCs+CJLrnKq/rI=
Received: from BL1PR13CA0220.namprd13.prod.outlook.com (2603:10b6:208:2bf::15)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:38:15 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::84) by BL1PR13CA0220.outlook.office365.com
 (2603:10b6:208:2bf::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:38:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:38:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:38:13 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:38:05 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 30/66] drm/amd/display: Test per-link DSC configs
Date: Tue, 8 Sep 2026 19:31:23 +0800
Message-ID: <20260908113338.2433445-31-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: d075253e-6477-4a80-bcea-08df0d9dab26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: guvhTCW66C7EOquwYvVGFZoV634+lD5c3JnC/MICF2mAyaSB7LAhU2Mt3h8pRybtXq9cPSR1wR07yZFheapN2Dfqcemt1VoB7sZeohz2GgpEiUWKkSHsBHkhdgocu0EoXp8QMhGrvpa9snv3q5p0i+qLLFWSBx8MBqXgkV2dTeoE1dLw0VrxcjG6bojEdlbFlN+N3TS9RC2LXUzceZ8B78DjxFWvr5vLqJOCxnHIhQUYnr6rUPPjlEtTGw6w+V7EKhzuRZEw+NqYtFyPN1eZi+/SdkDsHiEFu+xjg04rMHHTMPoDKhvs42RqFPP/reY+OjhXWc99aYTkdKF6E2XrmCR6O9bIq9lG+jCIEox7vJpa8pwBd2Hr6kDclHLGucdt4MZf6y1PG8cmLefkSaxW9x9GyLZInAeyCRoxDk3OSivXGbwXBQtYC6ZBK6d/MZyKJXJbKYHcgq+n4RLTBDjF+ajwmqQD90uB4ZUfrLBuOR8pdxDbT/HTVCAKotpR3AGd93MjQh9du2WAlgNwd6QRNfCBmKaWPLAkdoQmHTHvX2kUaITtq74Acqd41Pxj521eKOuxEG/L0vRxlabQV6V/k0ww9lT0B4PUtlNv1HLkXe5tdSPiVISSK5eHO+cOo516hL9ChHwt+4L2ppBxZ6M4QIEYTi5Ll/h3c2pzhKoU05krGZMAIgAUmQtfVC9G9HGBAWUHuWi/rTWtVt8UqFJeDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aKlXZKCsz9NroWQNf2PoBWdsWBscnKDNO9e7ZULqtAXN2lxRhT6j7m0r1vHK7wlyhIjtHtvDZwpAK8/92Py0bnVJsSbtG7QOfSCw4/31Dnw4tF/HUidqx5qAwAi1hOk2Fwcq45gnE8Y2URk96bQLCmuxYP2zY0ldqpytZjMfZwU6eRY8UXiVDEKH1BmJTbwoicNK4nCbo1DLpTB0U4bn0HXBrR/CzqxjPyn7j/bGghFlSWLmvwVHCvTjzJnzelexBZc9GYeQRa5eJQqDKFF5ZGWLg5hfyziNBcJ0VzVMRiLsuud+N+wPuiX4cnscNbuZ00N0jCn+mUwR0JvJ2vlryB/fQy5ZQSuQ3OHK5+/pdGA9tLrI6pUZrgFtiNZNn3lxmEaZ2rimT5owNnbqx9r9k9c3NpsRJnjp0/Ajw7OfcStwPMvnJpTE5do9Y8cJb8Kw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:38:14.1954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d075253e-6477-4a80-bcea-08df0d9dab26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
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

[WHAT]
Add KUnit tests for pre_compute_mst_dsc_configs_for_state() covering an
SST stream, a stream with an incomplete topology and a link that does
not need a recompute, and for compute_mst_dsc_configs_for_link()
covering a mode that fits uncompressed, a link that needs compression,
a link that runs out of time slots, forced DSC, forced DSC on an
already compressed stream, a bits per pixel overwrite, disabled
compression and a target that lands between the DSC limits.

[HOW]
Build an MST topology with a payload allocation and a DC state holding
the streams under test, and bind the connector to a CRTC through the
atomic helpers so the state teardown keeps the reference counts
balanced. Each path is then selected by varying the available time
slots and the per stream DSC policy.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   7 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   3 +
 .../tests/amdgpu_dm_mst_types_test.c          | 402 ++++++++++++++++++
 3 files changed, 409 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8dc4f81f1716..b6b7fd7f8bca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1689,9 +1689,9 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(compute_mst_dsc_configs_for_state);
 
-static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
-						 struct dc_state *dc_state,
-						 struct dsc_mst_fairness_vars *vars)
+STATIC_IFN_KUNIT int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
+							   struct dc_state *dc_state,
+							   struct dsc_mst_fairness_vars *vars)
 {
 	int i, j;
 	struct dc_stream_state *stream;
@@ -1741,6 +1741,7 @@ static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state
 
 	return ret;
 }
+EXPORT_IF_KUNIT(pre_compute_mst_dsc_configs_for_state);
 
 STATIC_IFN_KUNIT int find_crtc_index_in_state_by_stream(struct drm_atomic_commit *state,
 							struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 90efb1cf90e1..4436d256a2ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -115,6 +115,9 @@ int find_crtc_index_in_state_by_stream(struct drm_atomic_commit *state,
 bool is_dsc_precompute_needed(struct drm_atomic_commit *state);
 bool is_dsc_need_re_compute(struct drm_atomic_commit *state, struct dc_state *dc_state,
 			    struct dc_link *dc_link);
+int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
+					  struct dc_state *dc_state,
+					  struct dsc_mst_fairness_vars *vars);
 bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector);
 bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector);
 bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 9bd33317ec1e..382eafab2d43 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -8,9 +8,11 @@
 #include <kunit/test.h>
 
 #include <drm/drm_drv.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_mode_config.h>
@@ -3638,6 +3640,393 @@ static void dm_mst_test_pre_validate_dsc_not_needed(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, dm_state);
 }
 
+/* Tests for pre_compute_mst_dsc_configs_for_state */
+
+/**
+ * dm_mst_test_pre_compute_configs_skips_sst - non-MST streams are not considered
+ * @test: KUnit test context
+ */
+static void dm_mst_test_pre_compute_configs_skips_sst(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dc_stream_state *stream;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	stream = dm_mst_test_add_link_stream(test, ctx.dc_state, ctx.link, ctx.aconnector);
+	stream->ctx = ctx.dc->ctx;
+	stream->signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	KUNIT_EXPECT_EQ(test, pre_compute_mst_dsc_configs_for_state(ctx.state, ctx.dc_state, vars), 0);
+}
+
+/**
+ * dm_mst_test_pre_compute_configs_skips_incomplete - streams without a sink are skipped
+ * @test: KUnit test context
+ */
+static void dm_mst_test_pre_compute_configs_skips_incomplete(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dc_stream_state *stream;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	stream = dm_mst_test_add_link_stream(test, ctx.dc_state, ctx.link, ctx.aconnector);
+	stream->ctx = ctx.dc->ctx;
+	stream->signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
+
+	KUNIT_EXPECT_EQ(test, pre_compute_mst_dsc_configs_for_state(ctx.state, ctx.dc_state, vars), 0);
+}
+
+/**
+ * dm_mst_test_pre_compute_configs_no_recompute - an unchanged topology is left alone
+ * @test: KUnit test context
+ *
+ * The stream is DSC capable but is_dsc_need_re_compute() reports no change, so
+ * the precompute leaves the existing configuration in place.
+ */
+static void dm_mst_test_pre_compute_configs_no_recompute(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	ctx.link->type = dc_connection_single;
+	dm_mst_test_add_mst_dsc_stream(test, &ctx, NULL);
+
+	KUNIT_EXPECT_EQ(test, pre_compute_mst_dsc_configs_for_state(ctx.state, ctx.dc_state, vars), 0);
+}
+
+/* Tests for compute_mst_dsc_configs_for_link */
+
+static const struct drm_connector_funcs dm_mst_test_dsc_link_conn_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static enum dp_link_encoding dm_mst_test_mst_encoding_format(const struct dc_link *link)
+{
+	return DP_8b_10b_ENCODING;
+}
+
+struct dm_mst_test_dsc_link_ctx {
+	struct drm_modeset_acquire_ctx acquire_ctx;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_atomic_commit *state;
+	struct dc_stream_state *stream;
+	struct drm_device *drm;
+	struct dc_state *dc_state;
+};
+
+static void dm_mst_test_dsc_link_drop_locks(void *data)
+{
+	struct dm_mst_test_dsc_link_ctx *ctx = data;
+
+	ctx->drm->mode_config.acquire_ctx = NULL;
+	drm_modeset_drop_locks(&ctx->acquire_ctx);
+	drm_modeset_acquire_fini(&ctx->acquire_ctx);
+}
+
+static void dm_mst_test_destroy_mst_mgr(void *data)
+{
+	struct drm_dp_mst_topology_mgr *mgr = data;
+
+	mgr->mst_state = false;
+	drm_dp_mst_topology_mgr_destroy(mgr);
+}
+
+/*
+ * Full fixture for the DSC bandwidth sharing loop: a real DRM pipe and atomic
+ * state (the DRM MST helpers need private object locking), a real topology
+ * manager, and one MST stream whose 1920x1080 timing does not fit
+ * uncompressed. @total_avail_slots decides which compression pass succeeds.
+ *
+ * The context is KUnit allocated because the modeset locks are dropped from a
+ * deferred action, long after the test body has returned.
+ */
+static struct dm_mst_test_dsc_link_ctx *
+dm_mst_test_alloc_dsc_link_ctx(struct kunit *test, int total_avail_slots)
+{
+	struct dm_mst_test_dsc_link_ctx *ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	struct link_service *link_srv;
+	struct resource_pool *res_pool;
+	struct drm_dp_mst_port *port;
+	struct drm_plane *primary;
+	struct drm_crtc *crtc;
+	struct dc_sink *sink;
+	struct dc_link *link;
+	struct device *dev;
+	struct dc *dc;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	ctx->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						       sizeof(struct amdgpu_device),
+						       offsetof(struct amdgpu_device, ddev),
+						       DRIVER_MODESET | DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
+
+	primary = drm_kunit_helper_create_primary_plane(test, ctx->drm, NULL, NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
+	crtc = drm_kunit_helper_create_crtc(test, ctx->drm, primary, NULL, NULL, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+
+	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	KUNIT_ASSERT_EQ(test,
+			drmm_connector_init(ctx->drm, &ctx->aconnector->base,
+					    &dm_mst_test_dsc_link_conn_funcs,
+					    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
+	drm_mode_config_reset(ctx->drm);
+
+	KUNIT_ASSERT_EQ(test,
+			drm_dp_mst_topology_mgr_init(&ctx->aconnector->mst_mgr, ctx->drm,
+						     &ctx->aconnector->dm_dp_aux.aux, 16, 4,
+						     ctx->aconnector->base.base.id), 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_mst_test_destroy_mst_mgr,
+						  &ctx->aconnector->mst_mgr), 0);
+
+	drm_modeset_acquire_init(&ctx->acquire_ctx, 0);
+	ctx->drm->mode_config.acquire_ctx = &ctx->acquire_ctx;
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_mst_test_dsc_link_drop_locks, ctx), 0);
+
+	ctx->state = drm_kunit_helper_atomic_state_alloc(test, ctx->drm, &ctx->acquire_ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->state);
+
+	crtc_state = drm_atomic_get_crtc_state(ctx->state, crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+	crtc_state->enable = true;
+	crtc_state->active = true;
+	crtc_state->mode_changed = true;
+
+	conn_state = drm_atomic_get_connector_state(ctx->state, &ctx->aconnector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+	/* Takes the connector reference that the state teardown drops again. */
+	KUNIT_ASSERT_EQ(test, drm_atomic_set_crtc_for_connector(conn_state, crtc), 0);
+
+	ctx->mst_state = drm_atomic_get_mst_topology_state(ctx->state, &ctx->aconnector->mst_mgr);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mst_state);
+	/* One time slot per 10 PBN keeps the slot counts small and exact. */
+	ctx->mst_state->pbn_div.full = dfixed_const(10);
+	ctx->mst_state->total_avail_slots = total_avail_slots;
+	/* Needed for the payload limit check; mst_primary stays NULL. */
+	ctx->aconnector->mst_mgr.mst_state = true;
+
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+
+	link_srv->mst_decide_link_encoding_format = dm_mst_test_mst_encoding_format;
+
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	dc->link_srv = link_srv;
+	dc->res_pool = res_pool;
+	dc->current_state = dm_kunit_alloc_dc_state(test);
+
+	link = dm_kunit_alloc_link(test);
+	link->dc = dc;
+	link->ctx = dc->ctx;
+	link->type = dc_connection_mst_branch;
+
+	sink->ctx = dc->ctx;
+	dm_mst_test_setup_dsc_caps(test, dc, sink);
+
+	/* The payload allocation takes a reference, so start above zero. */
+	kref_init(&port->malloc_kref);
+	port->mgr = &ctx->aconnector->mst_mgr;
+	port->connector = &ctx->aconnector->base;
+	port->full_pbn = 2000;
+
+	ctx->aconnector->dc_link = link;
+	ctx->aconnector->dc_sink = sink;
+	ctx->aconnector->mst_output_port = port;
+
+	ctx->dc_state = dm_kunit_alloc_dc_state(test);
+	ctx->stream = dm_kunit_alloc_stream(test, link);
+	ctx->stream->ctx = dc->ctx;
+	ctx->stream->sink = sink;
+	ctx->stream->dm_stream_context = ctx->aconnector;
+	ctx->stream->signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
+	dm_mst_test_set_dsc_timing(&ctx->stream->timing);
+	ctx->dc_state->streams[0] = ctx->stream;
+	ctx->dc_state->stream_count = 1;
+
+	return ctx;
+}
+
+/**
+ * dm_mst_test_dsc_link_fits_uncompressed - plenty of time slots means no DSC
+ * @test: KUnit test context
+ *
+ * The first pass allocates the uncompressed peak PBN and the MST check
+ * succeeds, so DSC is left disabled for the stream.
+ */
+static void dm_mst_test_dsc_link_fits_uncompressed(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dm_mst_test_dsc_link_ctx *ctx;
+
+	ctx = dm_mst_test_alloc_dsc_link_ctx(test, 64);
+
+	KUNIT_EXPECT_EQ(test, pre_compute_mst_dsc_configs_for_state(ctx->state, ctx->dc_state, vars), 0);
+	KUNIT_EXPECT_FALSE(test, vars[0].dsc_enabled);
+	KUNIT_EXPECT_EQ(test, (u32)ctx->stream->timing.flags.DSC, 0U);
+	KUNIT_EXPECT_PTR_EQ(test, vars[0].aconnector, ctx->aconnector);
+}
+
+/**
+ * dm_mst_test_dsc_link_enables_compression - a tight link is compressed
+ * @test: KUnit test context
+ *
+ * The uncompressed allocation does not fit, so the driver falls back to
+ * maximum compression and then optimises the bits per pixel back up. DSC ends
+ * up enabled with a bpp above the policy minimum.
+ */
+static void dm_mst_test_dsc_link_enables_compression(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dm_mst_test_dsc_link_ctx *ctx;
+
+	ctx = dm_mst_test_alloc_dsc_link_ctx(test, 30);
+
+	KUNIT_EXPECT_EQ(test, pre_compute_mst_dsc_configs_for_state(ctx->state, ctx->dc_state, vars), 0);
+	KUNIT_EXPECT_TRUE(test, vars[0].dsc_enabled);
+	KUNIT_EXPECT_GT(test, vars[0].bpp_x16, 0);
+	KUNIT_EXPECT_EQ(test, (u32)ctx->stream->timing.flags.DSC, 1U);
+}
+
+/**
+ * dm_mst_test_dsc_link_out_of_slots - even max compression can be too big
+ * @test: KUnit test context
+ *
+ * When the fully compressed stream still exceeds the available time slots the
+ * -ENOSPC from the MST check is propagated to the caller.
+ */
+static void dm_mst_test_dsc_link_out_of_slots(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dm_mst_test_dsc_link_ctx *ctx;
+
+	ctx = dm_mst_test_alloc_dsc_link_ctx(test, 10);
+
+	KUNIT_EXPECT_EQ(test, pre_compute_mst_dsc_configs_for_state(ctx->state, ctx->dc_state, vars), -ENOSPC);
+}
+
+/**
+ * dm_mst_test_dsc_link_forced_dsc - forced DSC discards the uncompressed pass
+ * @test: KUnit test context
+ *
+ * With DSC forced on from debugfs the uncompressed allocation is not applied
+ * even though it fits. The MST check returned 0 rather than -ENOSPC, so the
+ * helper returns that success without programming a DSC config.
+ */
+static void dm_mst_test_dsc_link_forced_dsc(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dm_mst_test_dsc_link_ctx *ctx;
+
+	ctx = dm_mst_test_alloc_dsc_link_ctx(test, 64);
+	ctx->aconnector->dsc_settings.dsc_force_enable = DSC_CLK_FORCE_ENABLE;
+
+	KUNIT_EXPECT_EQ(test, pre_compute_mst_dsc_configs_for_state(ctx->state, ctx->dc_state, vars), 0);
+	KUNIT_EXPECT_FALSE(test, vars[0].dsc_enabled);
+	KUNIT_EXPECT_EQ(test, (u32)ctx->stream->timing.flags.DSC, 0U);
+}
+
+/**
+ * dm_mst_test_dsc_link_forced_dsc_stays_on - forced DSC is never disabled again
+ * @test: KUnit test context
+ *
+ * Once compression is needed, try_disable_dsc() only reconsiders streams left
+ * at the default DSC clock setting, so a forced stream keeps DSC enabled.
+ */
+static void dm_mst_test_dsc_link_forced_dsc_stays_on(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dm_mst_test_dsc_link_ctx *ctx;
+
+	ctx = dm_mst_test_alloc_dsc_link_ctx(test, 30);
+	ctx->aconnector->dsc_settings.dsc_force_enable = DSC_CLK_FORCE_ENABLE;
+
+	KUNIT_EXPECT_EQ(test, pre_compute_mst_dsc_configs_for_state(ctx->state, ctx->dc_state, vars), 0);
+	KUNIT_EXPECT_TRUE(test, vars[0].dsc_enabled);
+}
+
+/**
+ * dm_mst_test_dsc_link_bpp_overwrite - a forced bpp overrides the computed one
+ * @test: KUnit test context
+ */
+static void dm_mst_test_dsc_link_bpp_overwrite(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dm_mst_test_dsc_link_ctx *ctx;
+
+	ctx = dm_mst_test_alloc_dsc_link_ctx(test, 30);
+	ctx->aconnector->dsc_settings.dsc_bits_per_pixel = 10 * 16;
+	ctx->aconnector->dsc_settings.dsc_num_slices_h = 2;
+	ctx->aconnector->dsc_settings.dsc_num_slices_v = 4;
+
+	KUNIT_EXPECT_EQ(test, pre_compute_mst_dsc_configs_for_state(ctx->state, ctx->dc_state, vars), 0);
+	KUNIT_EXPECT_EQ(test, ctx->stream->timing.dsc_cfg.bits_per_pixel, 10 * 16);
+	KUNIT_EXPECT_EQ(test, (u32)ctx->stream->timing.dsc_cfg.num_slices_h, 2U);
+	KUNIT_EXPECT_EQ(test, (u32)ctx->stream->timing.dsc_cfg.num_slices_v, 4U);
+}
+
+/**
+ * dm_mst_test_dsc_link_compression_disabled - forcing DSC off keeps it off
+ * @test: KUnit test context
+ *
+ * A stream whose DSC clock is force disabled is allocated its uncompressed
+ * bandwidth in the max compression pass as well.
+ */
+static void dm_mst_test_dsc_link_compression_disabled(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dm_mst_test_dsc_link_ctx *ctx;
+
+	ctx = dm_mst_test_alloc_dsc_link_ctx(test, 30);
+	ctx->aconnector->dsc_settings.dsc_force_enable = DSC_CLK_FORCE_DISABLE;
+
+	KUNIT_EXPECT_EQ(test, pre_compute_mst_dsc_configs_for_state(ctx->state, ctx->dc_state, vars), -ENOSPC);
+}
+
+/**
+ * dm_mst_test_dsc_link_bpp_between_limits - spare slots raise the bits per pixel
+ * @test: KUnit test context
+ *
+ * With only part of the slack available the optimisation loop hands out a fair
+ * share of the free time slots and derives the resulting bits per pixel from
+ * the new PBN, landing between the policy minimum and maximum.
+ */
+static void dm_mst_test_dsc_link_bpp_between_limits(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dm_mst_test_dsc_link_ctx *ctx;
+
+	ctx = dm_mst_test_alloc_dsc_link_ctx(test, 63);
+	/* Smaller slots leave the fair share below the full slack. */
+	ctx->mst_state->pbn_div.full = dfixed_const(4);
+
+	KUNIT_EXPECT_EQ(test, pre_compute_mst_dsc_configs_for_state(ctx->state, ctx->dc_state, vars), 0);
+	KUNIT_EXPECT_TRUE(test, vars[0].dsc_enabled);
+	KUNIT_EXPECT_GT(test, vars[0].bpp_x16, 8 * 16);
+	KUNIT_EXPECT_LT(test, vars[0].bpp_x16, 16 * 16);
+}
+
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -3771,6 +4160,19 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_compute_configs_no_recompute),
 	/* pre_validate_dsc tests */
 	KUNIT_CASE(dm_mst_test_pre_validate_dsc_not_needed),
+	/* pre_compute_mst_dsc_configs_for_state tests */
+	KUNIT_CASE(dm_mst_test_pre_compute_configs_skips_sst),
+	KUNIT_CASE(dm_mst_test_pre_compute_configs_skips_incomplete),
+	KUNIT_CASE(dm_mst_test_pre_compute_configs_no_recompute),
+	/* compute_mst_dsc_configs_for_link tests */
+	KUNIT_CASE(dm_mst_test_dsc_link_fits_uncompressed),
+	KUNIT_CASE(dm_mst_test_dsc_link_enables_compression),
+	KUNIT_CASE(dm_mst_test_dsc_link_out_of_slots),
+	KUNIT_CASE(dm_mst_test_dsc_link_forced_dsc),
+	KUNIT_CASE(dm_mst_test_dsc_link_forced_dsc_stays_on),
+	KUNIT_CASE(dm_mst_test_dsc_link_bpp_overwrite),
+	KUNIT_CASE(dm_mst_test_dsc_link_compression_disabled),
+	KUNIT_CASE(dm_mst_test_dsc_link_bpp_between_limits),
 	{}
 };
 
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2D2C79FAD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A496E10EB4D;
	Tue,  8 Sep 2026 11:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lWy+xJmX";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6362E10EB4D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOt040f5zL6DDc0Ocg8nAYtP3tcg++9TRVunL7DmAwjgrj+/cjly/UIx0COKm7eAe74JOlU1jPmxbRM7cAPmGlvLi/eZMdwkNr1vcFkzDZqxpUJq23dFFajIHfGtCzTknwyQPGCZz5x2xLC+hotdHC4bRL/QQeg4C2hCUiJLMYvhwWu2YGf+BydOdqNIHHShg7FsUAl51kwyPvPTOJbBFHZHh4KOfwpntzsHSi7lyqjdY9oVn2YBOE2lFR9JgedRzsPa2Y3+TlEeBuJWm+gLJPFriqHMPQWuTWszl/VnH24TC7hBbQR+uvv+90prjD54auNrjDch/7rZ2crfXr7HlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njGp1f0x5Em5EMMPcJS5WRtrnW5CLa3DNszAMtzo5RM=;
 b=LjZDkibBLuvk/KzZI2vtPt1uif36hDajpc7msF/W4dSzX6WmvRbG6u+E1HQiLMdj3NB6n0mjDhHMzlfYjFOuD6arleQnccKO8YlnlK+ayj3wKvdOjHkWhts+fObf3SdCXCeIcw4OuHFZyc6pX8w0LeeUMNMEaFvApm64x3+k0jcg5wJwujvMoBHBWHctC45HKPGyR+HYGNMg+pLIDaZhfGeEQdtKviDFd36xAL1SDGdccnbVWgixN1z9pmDYHDe6O/io1mpoV7yFxIAfil8CAaxV07T5MLItZmkjKvbwrmN8UInBcEZD9TBKlfIX1G4EO7I01HVP/LWGYeIyi4P0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njGp1f0x5Em5EMMPcJS5WRtrnW5CLa3DNszAMtzo5RM=;
 b=lWy+xJmXhRaBy3qDD0+HF9qZtesJxTzLbaKDuMzvlrLdidxTA1Fnk+qDPf5lF5+x7Qw+jh29zYl+FCTIHXJ06Orb60zwuICsEdBGkVATZv/l4hvsm2Rx7jrb5QmQuEzwA+6O/WwXYK680X42ylz2F4vCk9X1fMDWbDF3OLHxkcI=
Received: from BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:37:23 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::67) by BY3PR05CA0017.outlook.office365.com
 (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:37:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:37:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:37:20 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:37:11 -0500
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
Subject: [PATCH 24/66] drm/amd/display: Test DSC caps validation
Date: Tue, 8 Sep 2026 19:31:17 +0800
Message-ID: <20260908113338.2433445-25-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d52956c-5942-4fa6-cccb-08df0d9d8c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|6133799003|3023799007|22082099003|18002099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: blQhL5tdkNLJBrK+tQbCCnK38V7g9yGIi3NR5uzIitEUYGUtzUO1l99CqWdvpcaDkVXx1E1wh5n0TnqnH/NV0AqhGzNROSZA+vNm5uBlabOqi3aJe7KkNHpt15r9bYKarwUpQZqWbSkxEyatJTMnyknoHngoqlQ0CUBj+BUZww2TnV+XeSNwY+VPMdv/NW0rlhEX3dDYxiIIX6y6PBP1Ms2G2OflvSYplab69RVRe4Xd2Tg6fwUQHOtHhGEEYIrNv4rgEjmo1ZjXkLXy+YR3KKssVGfE3Gw/YzsCJ/Uy6GnNVjbI4Gd02XR20A1VzOAVnPMYAa/gtVv/0lRaBe2IWA1+T/fEOP4u2XSZX2E+13c0aaVfluj1yqKfmYbGHPyLNCBX9JOOj/3ozyjClILcEmuYrdEBRycPpDGm5QPygEZ74cSFgte7bWuBTjRTLx7PuAkhuRJM4w1qDUmsm1jz1ivMJOmc9zQ3GcZCm8vu64cKeAmX+RM9sK10y0+Ougd9cHjT2Bcu+PBxqMncW/sic0IfEE/qyKRa/QCXSJuzmggduilL0Vnur4oldCtzTE4XrCPFzzw6+NYrgamiAYjESfbEOS2Edk18cUm252e5487bMI16Zv8aw6k2sUeYM8LRLqu5n57DwigZMoeePwsdVFrDoAxR8XgPVAPvJdDvlkYGIhT8zkXRlVipyFJov0ahTWDD+/hosqWQQRn4CEvfCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6b7FwpNZTa2hHMRlweKW8HBPFa9KWa89MuhPfj073RD/zCvW4l22KD2d9GdfzYDUMhJaywerhki1xWHY1hD2C6gPb5hdM3beKzvH3Dsj0GuB1Fftj0Ij+qt5HMX/QOACAeDN2Ybpg/usewicntALC1t/+eo2KeOVJRFWa5hmS0z4dLGIFy4x0iGjEIsuWbZBgNxG/DSBQp69CJXtgRRmVkQZn+FrfoerR6GA7xXPotYrGaU4KWFYkjHuDKyipLr+ZNnFzwAp031zKXhZGJOfKohxgn2XlxHGki6XTvNxFMaXwnRimv1kwKA+NKXqYICJXUR5IWSLFcMAfJDBKjYS3i36C/T9HfVIeS44N65/OPQa7DCvmwMkyC0b/KMD4IoRH/xYFdz/tbhHoXAvQKmuOFe768SHup9KtWD6iYXzV1SU6spebBXZgZboxtEL4t2o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:37:22.8673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d52956c-5942-4fa6-cccb-08df0d9d8c93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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
Add KUnit tests for validate_dsc_caps_on_connector() covering a port
without a DSC AUX channel, the branch AUX workaround, the cascaded
Panamera hub override, a DSC caps read failure and a decoder that does
not advertise DSC.

[HOW]
Attach the absolute DPCD fake to both the root and the port AUX
channels and populate the DSC capability block, then select each path
by tuning the branch descriptor and the topology, and check which AUX
channel is recorded along with the parsed DSC capabilities.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   1 +
 .../tests/amdgpu_dm_mst_types_test.c          | 153 ++++++++++++++++++
 3 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index c584906c8bb0..cb202b28a37c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -295,7 +295,7 @@ STATIC_IFN_KUNIT bool is_synaptics_cascaded_panamera(struct dc_link *link, struc
 }
 EXPORT_IF_KUNIT(is_synaptics_cascaded_panamera);
 
-static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_sink *dc_sink = aconnector->dc_sink;
 	struct drm_dp_mst_port *port = aconnector->mst_output_port;
@@ -339,6 +339,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 
 	return true;
 }
+EXPORT_IF_KUNIT(validate_dsc_caps_on_connector);
 #endif
 
 STATIC_IFN_KUNIT bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index f2e36807f0da..76db9a8330e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -107,6 +107,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 void amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector);
 bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_mst_port *port);
 bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw);
+bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector);
 bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector);
 bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector);
 ssize_t dm_dp_aux_transfer_result(ssize_t result,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 2e562c545c30..f74d263cfabf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -2473,6 +2473,153 @@ static void dm_mst_test_synaptics_cascaded(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, is_synaptics_cascaded_panamera(link, port), param->cascaded);
 }
 
+/* Tests for validate_dsc_caps_on_connector */
+
+struct dm_mst_test_dsc_ctx {
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_dm_connector *root;
+	struct drm_dp_mst_port *port;
+	struct dc_sink *sink;
+	struct dc_link *link;
+};
+
+/*
+ * Build an MST endpoint whose port hangs directly off the primary branch. With
+ * an all-zero DPCD, drm_dp_mst_dsc_aux_for_port() finds no DSC-capable AUX, so
+ * each test can steer the driver's own fallbacks in isolation.
+ */
+static void dm_mst_test_init_dsc_ctx(struct kunit *test, struct dm_mst_test_dsc_ctx *ctx)
+{
+	struct drm_dp_mst_branch *branch;
+	struct dc *dc;
+
+	dm_mst_test_reset_dsc_dpcd();
+
+	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	ctx->root = kunit_kzalloc(test, sizeof(*ctx->root), GFP_KERNEL);
+	ctx->sink = kunit_kzalloc(test, sizeof(*ctx->sink), GFP_KERNEL);
+	branch = kunit_kzalloc(test, sizeof(*branch), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->root);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->sink);
+	KUNIT_ASSERT_NOT_NULL(test, branch);
+
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	ctx->link = dm_kunit_alloc_link(test);
+	ctx->link->ctx = dc->ctx;
+
+	ctx->port = dm_mst_test_alloc_mgr_port(test);
+	ctx->port->parent = branch;
+	dm_mst_test_init_dsc_aux(&ctx->port->aux, "dm_mst_test_port_dsc_aux");
+	dm_mst_test_init_dsc_aux(&ctx->root->dm_dp_aux.aux, "dm_mst_test_root_dsc_aux");
+
+	ctx->aconnector->dc_link = ctx->link;
+	ctx->aconnector->dc_sink = ctx->sink;
+	ctx->aconnector->mst_output_port = ctx->port;
+	ctx->aconnector->mst_root = ctx->root;
+}
+
+/* Make needs_dsc_aux_workaround() accept the link. */
+static void dm_mst_test_arm_dsc_aux_workaround(struct dc_link *link)
+{
+	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
+	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
+	link->dpcd_caps.sink_count.bits.SINK_COUNT = 2;
+}
+
+/**
+ * dm_mst_test_validate_dsc_caps_no_aux - no DSC AUX means no DSC capabilities
+ * @test: KUnit test context
+ *
+ * When neither the DRM helper, the Synaptics workaround nor the cascaded hub
+ * quirk yields a DSC AUX channel, validation must fail without touching DPCD.
+ */
+static void dm_mst_test_validate_dsc_caps_no_aux(struct kunit *test)
+{
+	struct dm_mst_test_dsc_ctx ctx;
+
+	dm_mst_test_init_dsc_ctx(test, &ctx);
+
+	KUNIT_EXPECT_FALSE(test, validate_dsc_caps_on_connector(ctx.aconnector));
+	KUNIT_EXPECT_NULL(test, ctx.aconnector->dsc_aux);
+}
+
+/**
+ * dm_mst_test_validate_dsc_caps_aux_workaround - MST dock AUX fallback is used
+ * @test: KUnit test context
+ *
+ * A DSC capable dock in front of a non-DSC display leaves the DRM helper
+ * without an AUX, so the driver must fall back to the MST root's AUX and parse
+ * the DSC capabilities read from it.
+ */
+static void dm_mst_test_validate_dsc_caps_aux_workaround(struct kunit *test)
+{
+	struct dm_mst_test_dsc_ctx ctx;
+
+	dm_mst_test_init_dsc_ctx(test, &ctx);
+	dm_mst_test_arm_dsc_aux_workaround(ctx.link);
+	dm_mst_test_dsc_dpcd[DP_DSC_SUPPORT] = DP_DSC_DECOMPRESSION_IS_SUPPORTED;
+
+	KUNIT_EXPECT_TRUE(test, validate_dsc_caps_on_connector(ctx.aconnector));
+	KUNIT_EXPECT_PTR_EQ(test, ctx.aconnector->dsc_aux, &ctx.root->dm_dp_aux.aux);
+	KUNIT_EXPECT_TRUE(test, ctx.sink->dsc_caps.dsc_dec_caps.is_dsc_supported);
+}
+
+/**
+ * dm_mst_test_validate_dsc_caps_cascaded_hub - cascaded hub uses the mgr AUX
+ * @test: KUnit test context
+ *
+ * On a cascaded Synaptics Panamera hub the DSC decoder lives on the primary
+ * branch, so the topology manager's AUX must win over every other fallback.
+ */
+static void dm_mst_test_validate_dsc_caps_cascaded_hub(struct kunit *test)
+{
+	struct dm_mst_test_dsc_ctx ctx;
+
+	dm_mst_test_init_dsc_ctx(test, &ctx);
+	dm_mst_test_arm_dsc_aux_workaround(ctx.link);
+	dm_mst_test_set_panamera_ids(ctx.link, DP_BRANCH_DEVICE_ID_90CC24, 0x50,
+				     SYNAPTICS_CASCADED_HUB_ID);
+	dm_mst_test_dsc_dpcd[DP_DSC_SUPPORT] = DP_DSC_DECOMPRESSION_IS_SUPPORTED;
+
+	KUNIT_EXPECT_TRUE(test, validate_dsc_caps_on_connector(ctx.aconnector));
+	KUNIT_EXPECT_PTR_EQ(test, ctx.aconnector->dsc_aux, ctx.port->mgr->aux);
+}
+
+/**
+ * dm_mst_test_validate_dsc_caps_read_error - a failed DSC caps read is fatal
+ * @test: KUnit test context
+ */
+static void dm_mst_test_validate_dsc_caps_read_error(struct kunit *test)
+{
+	struct dm_mst_test_dsc_ctx ctx;
+
+	dm_mst_test_init_dsc_ctx(test, &ctx);
+	dm_mst_test_arm_dsc_aux_workaround(ctx.link);
+	dm_mst_test_dsc_aux_fail = &ctx.root->dm_dp_aux.aux;
+
+	KUNIT_EXPECT_FALSE(test, validate_dsc_caps_on_connector(ctx.aconnector));
+	KUNIT_EXPECT_PTR_EQ(test, ctx.aconnector->dsc_aux, &ctx.root->dm_dp_aux.aux);
+}
+
+/**
+ * dm_mst_test_validate_dsc_caps_unsupported - a sink without DSC is rejected
+ * @test: KUnit test context
+ *
+ * The AUX resolves but the sink reports no decompression support, so parsing
+ * the raw capabilities fails and the connector must not be marked DSC capable.
+ */
+static void dm_mst_test_validate_dsc_caps_unsupported(struct kunit *test)
+{
+	struct dm_mst_test_dsc_ctx ctx;
+
+	dm_mst_test_init_dsc_ctx(test, &ctx);
+	dm_mst_test_arm_dsc_aux_workaround(ctx.link);
+
+	KUNIT_EXPECT_FALSE(test, validate_dsc_caps_on_connector(ctx.aconnector));
+	KUNIT_EXPECT_FALSE(test, ctx.sink->dsc_caps.dsc_dec_caps.is_dsc_supported);
+}
+
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -2561,6 +2708,12 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE_PARAM(dm_mst_test_link_current_set_bw, dm_mst_link_bw_gen_params),
 	/* is_synaptics_cascaded_panamera tests */
 	KUNIT_CASE_PARAM(dm_mst_test_synaptics_cascaded, dm_mst_panamera_gen_params),
+	/* validate_dsc_caps_on_connector tests */
+	KUNIT_CASE(dm_mst_test_validate_dsc_caps_no_aux),
+	KUNIT_CASE(dm_mst_test_validate_dsc_caps_aux_workaround),
+	KUNIT_CASE(dm_mst_test_validate_dsc_caps_cascaded_hub),
+	KUNIT_CASE(dm_mst_test_validate_dsc_caps_read_error),
+	KUNIT_CASE(dm_mst_test_validate_dsc_caps_unsupported),
 	{}
 };
 
-- 
2.43.0


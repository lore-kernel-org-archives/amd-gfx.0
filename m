Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74548C5DF89
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058FA10ECA2;
	Tue, 18 Aug 2026 20:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3GgX/6vC";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C475F10EC93
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opeM8NsdXhylxVCO3c4brl9vlcJaaYZfcfAwOQwGnhziLaAE9n0GyXHcfvFjmEjH5HCkEmEabMyPB0zoMcrPNQBSpyAOmdu3ZVGNoIQtHPRwlLm93YWtUzz48BZesMaYMRB0jXmiDDd6yVQT5ORfY9P5rTinH1v30ta7d2I+EibbMvEuQ9O7uGFrky+fRKwn6NnUbjuiFOP9aj+bG7gVU0nW9TTHvqHXa6GMLVaB2EPOEW9HkqIXVTqLJ11reX2HURTKL2KjrEaJOKR4QvgPzS0NwV4nJ+exCqOnKSRsuTtZEl8wDIfo8Vjk84A2ePv64pvhj3GqYPZw0ykHgvjkVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0xSkNJ9F3EfMAR1uleZwf+9tnH363bmCCB4XowtxlE=;
 b=QDDWfQ5mp42IXh4ybbDOMmlZiwhlWpocfHoGNo9mFvZ7cv+WBzOSHL2SVP3Tl516fejG+m4DBhwrcOTDBYNWuzKkDdgXjUxY7jgVzAqbqkZoIF6xxKqHymNeGFhcDzU/2WBjLjBC40x1/QDcJ1zOmqKvhvN+Ng8D/Fq17QvEAKBJO5RGDzWxFcn1f6FkFISX7Mj+uFJdMQ+YBA5Db0IPIid/Z2MEk11P9c7f6gA8H+3qzyzOzg4fqGJDZIPqokMlcsTgbmp64AQpwGyjabXR5ya8F26p5sGJCOMUZK9OJZy7s9h/U1GChi6zx3J1Jf0UhKlUf1y6rD/UtkxQXWRYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0xSkNJ9F3EfMAR1uleZwf+9tnH363bmCCB4XowtxlE=;
 b=3GgX/6vCjiMd4cFFiZI0SjhRQmLrq2sJy5gzD2Jn9osxQTAj1jBE/AIVNnhmlByBPeXsg2bDUxp0/1X6SRE2cJR8HQy9ImIChFPmS+MNaFdmr0vFkm447i5K05Tnmffu/gQAkDVCFdevlKuD3yyO8cZYjYYh+0t+UTy7ZqcI2a4=
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Tue, 18 Aug
 2026 20:22:07 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::a1) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:07 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:00 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:21:59 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 09/82] drm/amd/display: Cover MST path in encoder atomic_check
Date: Tue, 18 Aug 2026 16:15:01 -0400
Message-ID: <20260818202139.4172592-10-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1109b0-715e-41d4-6801-08defd665ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|22082099003|3023799007|10067099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: q0xfeG96nW/vJPi291s2/xkXgRF6BJLxsP2xF37QkpAKhSrYOVlbn3GiZtGM+o/VwetzJGTa8byEYbrS4Y6dCHfn82NFJYPEncY3mnmSH1EZ8YzhkG+saRyKuvcBoCcY+/iyc7uaMTetJ2rL6WwxgYIXNLan/QP0NZRvvr4M2+SBWY93MZ1D+6QnVEBu1zF7jyv8YojQ61qlz300jv+RURyQBW9d4wo5e6gMA/GEbw+1Yg7Cg+P8NE78FodSrLMGZCjx3VGijYMF/VUTYI1qy4JCHoIcIDLbgOZMmLS+ZUncrYy0r6J8p6ogXMl7F1iRXyte9SDtIFpdDQWHlGjJGvAGEXSeqvE1Y5M4Tjcs3Zd1ysryLeLo4zt1oSmxkmm26Cn+P0FeLFWxMaZHl/zqiBFEM+BITzFQn3KCNZkEvNmpL3yrLNNj669E+3/WJdGV/B2HxhO9yYepOV8IHZVfj+yRjzu9TnhptjLyuug2PMV8WunyUGJ6D395xYfHBpG5bORg5340F2o1m1IKVENdJTI5VtlQmNGaAMyTRESf8vSM32z5nN0V+4ADErr6OjzU1IilyE2O2SBZvpg7vG9OIdIBS1fVtRih+cmjDsrBS1/sb4SGDEk9tJ1anedrLV9ONqmMC0IMBu7q+kyh3e1BbE1wCH/WLHoqq5KaXqjLGHZZERk+PXBZY167SWe6kw7+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(3023799007)(10067099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z1s9ZpDJgdr9/a0G1YtZ74h1cooVTzXo1yIj5zFqJuC4640a1Pwl9LDYDNUQXgMQTn0J3VHhixwl6k7YcqsCT97yznJdAFhgswWouRlJSqnAj3+0K//Git53n2WMr9f9jWipq6tvhLDg/3eq9OS6u6D6DCvSKZxi/6dwcZSHolsBkNUdOLOCaag6G+PFV500ABVw1T/do3Qv/AiBYO/DXUnw4pdQsydsuZ/D/XHbctUqb/7p3jgDqY6m0M4xhV7yYtbWDjWW16aAAMr563Ut3Wu05EufdR48a65OIqKK0G/5a7RNrgJAF80PZfA/PwquB8yljxWSqWMfMrk+oWiz4BD+wTwucBJKvkHImCi1nqtwdS735zohERqKa0+IWCTpvk4WJdHF4WHPPYDRyUTpb3ddr1Do+0iYVItrXZXrlmjRIlDbnwL+22b8dB7+W8iT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:07.1235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1109b0-715e-41d4-6801-08defd665ff6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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

Add KUnit tests for the multi-stream transport validation path in
dm_encoder_helper_atomic_check(). A shared scaffold builds a fully faked
DRM atomic state (private objs, connectors, MST payload list) plus a fake
DC link so the PBN divider is non-zero, exercising the topology-state
lookup, color-depth/PBN compute, VCPI slot allocation, and both the
topology-error and negative-vcpi_slots failure branches.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 252 ++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index a54fd9529dc9e..d209e26b684eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -29,6 +29,7 @@
 #include "amdgpu_dm_backlight.h"
 #include "include/grph_object_id.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
+#include "inc/link_service.h"
 
 /* Tests for get_subconnector_type() */
 
@@ -4394,6 +4395,252 @@ static void dm_test_atomic_check_non_mst_returns_zero(struct kunit *test)
 					       &ctx->dm_state->base), 0);
 }
 
+/**
+ * dm_test_atomic_check_mst_no_change_returns_zero - Test MST no-change short-circuit
+ * @test: The KUnit test context
+ *
+ * An MST connector (mst_output_port set) whose CRTC state reports neither a
+ * connectors nor a mode change hits the ``return 0`` before any topology state
+ * is fetched.
+ */
+static void dm_test_atomic_check_mst_no_change_returns_zero(struct kunit *test)
+{
+	struct dm_test_atomic_check_ctx *ctx =
+		dm_test_atomic_check_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct drm_dp_mst_port *mst_port;
+	struct amdgpu_dm_connector *mst_root;
+
+	mst_port = kunit_kzalloc(test, sizeof(*mst_port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mst_port);
+	mst_root = kunit_kzalloc(test, sizeof(*mst_root), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mst_root);
+
+	ctx->aconnector->mst_output_port = mst_port;
+	ctx->aconnector->mst_root = mst_root;
+	ctx->crtc_state->connectors_changed = false;
+	ctx->crtc_state->mode_changed = false;
+
+	KUNIT_EXPECT_EQ(test,
+		dm_encoder_helper_atomic_check(&ctx->aenc->base,
+					       ctx->crtc_state,
+					       &ctx->dm_state->base), 0);
+}
+
+
+static uint32_t dm_test_atomic_check_dp_link_bandwidth_kbps(
+	const struct dc_link *link,
+	const struct dc_link_settings *link_settings)
+{
+	return 4320000;
+}
+
+static const struct dc_link_settings *dm_test_atomic_check_dp_get_verified_link_cap(
+	const struct dc_link *link)
+{
+	return &link->verified_link_cap;
+}
+
+/* Fake fully-wired MST atomic state for the deep dm_encoder_helper_atomic_check() path. */
+struct dm_test_mst_scaffold {
+	struct drm_atomic_commit *state;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_dp_mst_atomic_payload *payload;
+	struct drm_dp_mst_port *mst_port;
+	struct amdgpu_dm_connector *mst_root;
+	struct __drm_private_objs_state *priv_objs;
+};
+
+/*
+ * dm_test_atomic_check_mst_scaffold - build a fake MST atomic state.
+ * @map_success: when true the topology manager maps to a valid topology state
+ *               and a fake DC link/link-service is wired so the PBN divider is
+ *               non-zero; when false the manager maps to an error pointer so
+ *               drm_atomic_get_mst_topology_state() reports failure.
+ */
+static void dm_test_atomic_check_mst_scaffold(struct kunit *test,
+		struct dm_test_atomic_check_ctx *ctx,
+		struct dm_test_mst_scaffold *s,
+		bool map_success)
+{
+	struct drm_modeset_acquire_ctx *acquire_ctx;
+	struct link_service *link_srv;
+	struct dc *dc;
+	struct dc_link *link;
+	struct drm_connector *port_conn;
+	struct drm_crtc *crtc;
+	struct drm_connector_state *port_conn_state;
+	struct __drm_connnectors_state *conns;
+
+	memset(s, 0, sizeof(*s));
+
+	s->mst_root = kunit_kzalloc(test, sizeof(*s->mst_root), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, s->mst_root);
+	s->mst_root->mst_mgr.dev = ctx->drm;
+
+	s->mst_port = kunit_kzalloc(test, sizeof(*s->mst_port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, s->mst_port);
+
+	ctx->aconnector->mst_root = s->mst_root;
+	ctx->aconnector->mst_output_port = s->mst_port;
+
+	acquire_ctx = kunit_kzalloc(test, sizeof(*acquire_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acquire_ctx);
+
+	s->state = kunit_kzalloc(test, sizeof(*s->state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, s->state);
+	s->state->dev = ctx->drm;
+	s->state->acquire_ctx = acquire_ctx;
+
+	s->priv_objs = kunit_kzalloc(test, sizeof(*s->priv_objs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, s->priv_objs);
+	s->priv_objs[0].ptr = &s->mst_root->mst_mgr.base;
+	s->state->num_private_objs = 1;
+	s->state->private_objs = s->priv_objs;
+
+	ctx->crtc_state->state = s->state;
+	ctx->crtc_state->connectors_changed = true;
+
+	if (!map_success) {
+		s->priv_objs[0].new_state = ERR_PTR(-ENOMEM);
+		return;
+	}
+
+	/* Fake DC link so dm_mst_get_pbn_divider() yields a non-zero divider. */
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	link_srv->dp_get_verified_link_cap =
+		dm_test_atomic_check_dp_get_verified_link_cap;
+	link_srv->dp_link_bandwidth_kbps =
+		dm_test_atomic_check_dp_link_bandwidth_kbps;
+	dc->link_srv = link_srv;
+	link->dc = dc;
+	s->mst_root->dc_link = link;
+
+	s->mst_state = kunit_kzalloc(test, sizeof(*s->mst_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, s->mst_state);
+	INIT_LIST_HEAD(&s->mst_state->payloads);
+	s->priv_objs[0].new_state = &s->mst_state->base;
+
+	/* Pre-seed a payload so find_time_slots() skips the port kref alloc path. */
+	s->payload = kunit_kzalloc(test, sizeof(*s->payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, s->payload);
+	s->payload->port = s->mst_port;
+	list_add(&s->payload->next, &s->mst_state->payloads);
+
+	/* Wire a connector+crtc so find_time_slots() can resolve the crtc mask. */
+	port_conn = kunit_kzalloc(test, sizeof(*port_conn), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	port_conn_state = kunit_kzalloc(test, sizeof(*port_conn_state), GFP_KERNEL);
+	conns = kunit_kzalloc(test, sizeof(*conns), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, port_conn);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, port_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, conns);
+	port_conn->index = 0;
+	crtc->index = 0;
+	port_conn_state->crtc = crtc;
+	s->mst_port->connector = port_conn;
+	conns[0].new_state = port_conn_state;
+	s->state->num_connector = 1;
+	s->state->connectors = conns;
+}
+
+/**
+ * dm_test_atomic_check_mst_finds_vcpi_slots - Test the MST time-slot allocation path
+ * @test: The KUnit test context
+ *
+ * With a fully wired MST atomic state and connectors_changed set, the check
+ * computes the color depth/PBN, allocates VCPI time slots and returns 0.
+ */
+static void dm_test_atomic_check_mst_finds_vcpi_slots(struct kunit *test)
+{
+	struct dm_test_atomic_check_ctx *ctx =
+		dm_test_atomic_check_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dm_test_mst_scaffold s;
+
+	dm_test_atomic_check_mst_scaffold(test, ctx, &s, true);
+	s.state->duplicated = false;
+	ctx->dm_state->base.max_requested_bpc = 8;
+
+	KUNIT_EXPECT_EQ(test,
+		dm_encoder_helper_atomic_check(&ctx->aenc->base,
+					       ctx->crtc_state,
+					       &ctx->dm_state->base), 0);
+	KUNIT_EXPECT_GE(test, ctx->dm_state->vcpi_slots, 0);
+}
+
+/**
+ * dm_test_atomic_check_mst_duplicated_skips_pbn - Test the duplicated-state fast path
+ * @test: The KUnit test context
+ *
+ * When the atomic state is duplicated the color depth/PBN recompute block is
+ * skipped, but time slots are still allocated and the check returns 0.
+ */
+static void dm_test_atomic_check_mst_duplicated_skips_pbn(struct kunit *test)
+{
+	struct dm_test_atomic_check_ctx *ctx =
+		dm_test_atomic_check_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dm_test_mst_scaffold s;
+
+	dm_test_atomic_check_mst_scaffold(test, ctx, &s, true);
+	s.state->duplicated = true;
+	ctx->dm_state->pbn = 0;
+
+	KUNIT_EXPECT_EQ(test,
+		dm_encoder_helper_atomic_check(&ctx->aenc->base,
+					       ctx->crtc_state,
+					       &ctx->dm_state->base), 0);
+}
+
+/**
+ * dm_test_atomic_check_mst_topology_err_propagates - Test topology-state error propagation
+ * @test: The KUnit test context
+ *
+ * When drm_atomic_get_mst_topology_state() returns an error pointer, the check
+ * propagates the error code back to the caller.
+ */
+static void dm_test_atomic_check_mst_topology_err_propagates(struct kunit *test)
+{
+	struct dm_test_atomic_check_ctx *ctx =
+		dm_test_atomic_check_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dm_test_mst_scaffold s;
+
+	dm_test_atomic_check_mst_scaffold(test, ctx, &s, false);
+
+	KUNIT_EXPECT_EQ(test,
+		dm_encoder_helper_atomic_check(&ctx->aenc->base,
+					       ctx->crtc_state,
+					       &ctx->dm_state->base), -ENOMEM);
+}
+
+/**
+ * dm_test_atomic_check_mst_vcpi_error_propagates - Test VCPI allocation error propagation
+ * @test: The KUnit test context
+ *
+ * A pre-existing payload marked for deletion makes drm_dp_atomic_find_time_slots()
+ * fail; the negative vcpi_slots result is propagated back to the caller.
+ */
+static void dm_test_atomic_check_mst_vcpi_error_propagates(struct kunit *test)
+{
+	struct dm_test_atomic_check_ctx *ctx =
+		dm_test_atomic_check_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dm_test_mst_scaffold s;
+
+	dm_test_atomic_check_mst_scaffold(test, ctx, &s, true);
+	s.state->duplicated = true;
+	ctx->dm_state->pbn = 100;
+	s.payload->delete = true;
+
+	KUNIT_EXPECT_EQ(test,
+		dm_encoder_helper_atomic_check(&ctx->aenc->base,
+					       ctx->crtc_state,
+					       &ctx->dm_state->base), -EINVAL);
+}
+
 /* Tests for hdmi_cec_unset_edid() */
 
 /**
@@ -5611,6 +5858,11 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_atomic_check_edp_native_keeps_scaling),
 	KUNIT_CASE(dm_test_atomic_check_lvds_non_native_enables_scaling),
 	KUNIT_CASE(dm_test_atomic_check_non_mst_returns_zero),
+	KUNIT_CASE(dm_test_atomic_check_mst_no_change_returns_zero),
+	KUNIT_CASE(dm_test_atomic_check_mst_finds_vcpi_slots),
+	KUNIT_CASE(dm_test_atomic_check_mst_duplicated_skips_pbn),
+	KUNIT_CASE(dm_test_atomic_check_mst_topology_err_propagates),
+	KUNIT_CASE(dm_test_atomic_check_mst_vcpi_error_propagates),
 	/* hdmi_cec_unset_edid */
 	KUNIT_CASE(dm_test_hdmi_cec_unset_edid_no_notifier),
 	/* create_eml_sink */
-- 
2.43.0


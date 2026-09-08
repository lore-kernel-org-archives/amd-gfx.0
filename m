Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C2BC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C3410EB50;
	Tue,  8 Sep 2026 11:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s2KY83eb";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C51C10EB50
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpuIPtDl2gCSj2PPYME4tloUg7rvWIzN59CJXhgaFvHrK6KIyLyiTVAuY9ZkdDA79zayXeuq8ZGis4RbxXYRjfpXVFRIVvy2oPoBTWWbQYF/NZdmMecmflMPttnhEVkvCZz8oaePDUa7KqirMl5TXDuk+5I9IYJVXk/psw81nvWUufuu/+nN8CRbhWW+l9bk+9VTBUMpfs/5ON4IPqFJ0PiP10XecNk/7uZK8rR+C9zEcbXRTMsENtQNj63o5GA2Zn0kB8ekFUv5KZmZqtWxnVdX73QGcitN/uxMa2guV+k7R1YOsZHWyZ6BZCZutQogRyDozdVaPuIl0gG/09I+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiQVIdzD8xrkNpVrG/9Av+3h+rfDqztbH71gsvhg95w=;
 b=rjXrwZJGjKkCEt9RS7SFhgg7sh7VvLwkghW6Ipr7r4b/3psqHjnWgW3Hq9moUM7HWH2fD2HX1MxF2J8OsnFg6xgycxNAIUxHvwFlPkc54LUPB8WmYBNx4DW0WfDgRcxF8q27CorRUkEA46Kiz8S4OCpQI6bZUe3QAg4Vw6i2u/z1GtpehPox0HS8i131CKyk9biMeV78coazbBe0TlKIq6AUrBmGosJ5oPk7tSNyLO7ewTh6rZW9A3flZn29Ccn8eT34JQ1MGWGI05+gMW7rTw6HVUlQtamczb54EJEvDkCEhSPS4fPLJHILrv6xr5TuuDLcqyP6bGrvMi1dNnTQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiQVIdzD8xrkNpVrG/9Av+3h+rfDqztbH71gsvhg95w=;
 b=s2KY83eb024lE1J8XL77iJki/o0yNW71wzRMU6plVJu9iCmCFW9XXHOcvu2dwRscvppqx0Ol2rCi3CdIhBWAZRrtgaDBXwiiGPGGQEWkmAiIvy2+1bCYCGZcPKZtlUW7W+ZvjrZ7kPyN1+NtKSzhXMWTDuKEJnr+ADwkGhp8/uM=
Received: from BL1PR13CA0443.namprd13.prod.outlook.com (2603:10b6:208:2c3::28)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 11:37:56 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::5b) by BL1PR13CA0443.outlook.office365.com
 (2603:10b6:208:2c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:37:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:37:55 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:37:47 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 28/66] drm/amd/display: Test DSC recompute check
Date: Tue, 8 Sep 2026 19:31:21 +0800
Message-ID: <20260908113338.2433445-29-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a1f780-ba2e-48cc-f54c-08df0d9da077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|6133799003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tY15TFIfA1gghENr0WYSqBmv0qLh3QyRK5ulR1aG6pqBtgZKhO2Xyclobz7W9Ss2olERFElrPhPKsHcFRN4GjxvOIk+hd2EZgunUfP5GSujv518p3KZNeWRFyDaxE75ioulIDU5jnFlUM+PRCZ130ORcRRew+GXqQTC6cQsswDwSSBMI7vpQd3IeBnByf3eTHJ1eXMUor01JdsTYqMCMcHwzkLFWXOtPyOMN7ry87KWh3mlxQfGIPa/esItiqs52CyOUC6Jy7B+CzQQaIU87N3YVGc9flQxyjufi558IRLoJ2ildq23yu7VPay0QJYrIv0UtxI8jX4VpOIxMTHknXzi7kJ1i+srk0cLJh4D+cNYrEXavqZkYgf6JykDV1C1+NYZwqmIunKCkIQzNiPM0r0GzAXciKhjUSkJLNwvG3qKfS0pao0/U4b+fMiGCBTqH+nZ4AdZWV7jqBj+j5iCzzGF3pu4NA+yWwW3g4zlc370soQwSc016EDMleIojr2y0BvYqIdaRADvyGtMvxitpI9N6ghqj5H84asRAOzvlShQDnRJeIDWQ98ZEYtjYlSfuiBq5jUgKzc7hpX2lo9pYEvP8tgUUlveVdtIblRJigJl2gSkfZfY8T+bJVU6hMrZ1kYfagW6AKjEmbPc7qWkDgxx8gUGoDqeo72JJOL5GZJFdcEjU0B7yuJIvIWffI3N/NCsilo3SGFAh1uoEWFiiVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(6133799003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oljk2dRE77EmltKHe7xbsLkUnSqfjqPytcYbZiM0SRKa+BXk1jH6hCGzvTeQdMDOvImeLRp4tXvEbC9H8y92zIiRzMA3SsP3Dl++YJ2xZmnJbpNUSrXRC64Bo/kcZxgrMpHQYI7X7ewqoHe6KBasBAXiU96u1IRxma9tZ+4mSEal+aT66r/SVCoMeC/Aml5yLIgFYrgHhaaFxSAwnhx+wtNcpeMZfwv6Qu4oUUmLEehG+8vJ9/W90DjiWWJWS54MCb3PRDJhc9vhVrec0i7vWu/ai1FQWS2ckUiKKaho9Dn0flXkP0zbsb4rgIOGrpjliFjLAFmcgcWQkC1FH3gj2oiullHlzDetRIfLXw94PbPZUPQ3M4Qa0/Fp12kJ0NSWQ2gu7M8d2Tmx8V2GWSyhBT5Z7Doh3RySpXlRqkawvQxTzXeXjmsrQua1LSQme43R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:37:56.2713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a1f780-ba2e-48cc-f54c-08df0d9da077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
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
Add KUnit tests for is_dsc_need_re_compute() covering a non MST branch,
a legacy hub without DSC support, a state with no stream on the link, a
mode change, an unchanged stream, a removed stream, a stream without a
connector and a connector without a CRTC.

[HOW]
Build a DC state carrying streams on the link under test together with
a matching drm_atomic_commit, then vary the topology, the connector to
CRTC mapping and the mode changed flag to select each path.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   2 +
 .../tests/amdgpu_dm_mst_types_test.c          | 228 ++++++++++++++++++
 3 files changed, 232 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index f5085a0036af..fc71f8e567c9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1485,7 +1485,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_commit *state,
 	return 0;
 }
 
-static bool is_dsc_need_re_compute(
+STATIC_IFN_KUNIT bool is_dsc_need_re_compute(
 	struct drm_atomic_commit *state,
 	struct dc_state *dc_state,
 	struct dc_link *dc_link)
@@ -1616,6 +1616,7 @@ static bool is_dsc_need_re_compute(
 
 	return is_dsc_need_re_compute;
 }
+EXPORT_IF_KUNIT(is_dsc_need_re_compute);
 
 int compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
 				      struct dc_state *dc_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index b1d7a21a37e3..90efb1cf90e1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -113,6 +113,8 @@ void log_dsc_params(int count, struct dsc_mst_fairness_vars *vars, int k);
 int find_crtc_index_in_state_by_stream(struct drm_atomic_commit *state,
 				       struct dc_stream_state *stream);
 bool is_dsc_precompute_needed(struct drm_atomic_commit *state);
+bool is_dsc_need_re_compute(struct drm_atomic_commit *state, struct dc_state *dc_state,
+			    struct dc_link *dc_link);
 bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector);
 bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector);
 bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index d91863d5416d..9af4fd84e69c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -3276,6 +3276,225 @@ static void dm_mst_test_dsc_precompute_needed(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, is_dsc_precompute_needed(ctx.state), param->needed);
 }
 
+/* Tests for is_dsc_need_re_compute */
+
+struct dm_mst_test_recompute_ctx {
+	struct amdgpu_device *adev;
+	struct drm_atomic_commit *state;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	struct dc_state *dc_state;
+	struct dc_link *link;
+	struct dc *dc;
+};
+
+/*
+ * One MST connector on one CRTC, with an empty new dc_state and an empty
+ * current dc_state. Tests populate the streams they need and adjust the CRTC
+ * state flags to select the branch under test.
+ */
+static void dm_mst_test_init_recompute_ctx(struct kunit *test,
+					   struct dm_mst_test_recompute_ctx *ctx)
+{
+	struct drm_crtc *crtc;
+
+	ctx->adev = dm_kunit_alloc_adev(test);
+	ctx->adev->ddev.mode_config.num_crtc = 1;
+
+	ctx->dc = dm_kunit_alloc_dc_with_ctx(test);
+	ctx->dc->current_state = dm_kunit_alloc_dc_state(test);
+	ctx->dc_state = dm_kunit_alloc_dc_state(test);
+
+	ctx->link = dm_kunit_alloc_link(test);
+	ctx->link->dc = ctx->dc;
+	ctx->link->type = dc_connection_mst_branch;
+
+	ctx->aconnector = dm_kunit_alloc_connector(test, ctx->adev, ctx->link);
+	ctx->conn_state = kunit_kzalloc(test, sizeof(*ctx->conn_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	ctx->crtc_state = kunit_kzalloc(test, sizeof(*ctx->crtc_state), GFP_KERNEL);
+	ctx->state = kunit_kzalloc(test, sizeof(*ctx->state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state);
+
+	ctx->state->dev = &ctx->adev->ddev;
+	ctx->state->crtcs = kunit_kzalloc(test, sizeof(*ctx->state->crtcs), GFP_KERNEL);
+	ctx->state->connectors = kunit_kzalloc(test, sizeof(*ctx->state->connectors), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state->crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state->connectors);
+
+	crtc->dev = &ctx->adev->ddev;
+	ctx->crtc_state->crtc = crtc;
+	ctx->state->crtcs[0].ptr = crtc;
+	ctx->state->crtcs[0].new_state = ctx->crtc_state;
+	ctx->state->crtcs[0].old_state = ctx->crtc_state;
+
+	ctx->conn_state->connector = &ctx->aconnector->base;
+	ctx->conn_state->crtc = crtc;
+	ctx->state->connectors[0].ptr = &ctx->aconnector->base;
+	ctx->state->connectors[0].new_state = ctx->conn_state;
+	ctx->state->num_connector = 1;
+}
+
+static struct dc_stream_state *dm_mst_test_add_link_stream(struct kunit *test,
+							   struct dc_state *dc_state,
+							   struct dc_link *link,
+							   struct amdgpu_dm_connector *aconnector)
+{
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, link);
+
+	KUNIT_ASSERT_LT(test, dc_state->stream_count, MAX_PIPES);
+	stream->dm_stream_context = aconnector;
+	dc_state->streams[dc_state->stream_count++] = stream;
+
+	return stream;
+}
+
+/**
+ * dm_mst_test_recompute_not_mst_branch - only MST branches are recomputed
+ * @test: KUnit test context
+ */
+static void dm_mst_test_recompute_not_mst_branch(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	ctx.link->type = dc_connection_single;
+
+	KUNIT_EXPECT_FALSE(test, is_dsc_need_re_compute(ctx.state, ctx.dc_state, ctx.link));
+}
+
+/**
+ * dm_mst_test_recompute_legacy_hub_without_dsc - old hubs without DSC are skipped
+ * @test: KUnit test context
+ *
+ * A hub matching the no-virtual-DPCD workaround but reporting neither DSC nor
+ * DSC passthrough support cannot use MST DSC at all.
+ */
+static void dm_mst_test_recompute_legacy_hub_without_dsc(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	dm_mst_test_arm_dsc_aux_workaround(ctx.link);
+
+	KUNIT_EXPECT_FALSE(test, is_dsc_need_re_compute(ctx.state, ctx.dc_state, ctx.link));
+}
+
+/**
+ * dm_mst_test_recompute_no_stream_on_link - no stream on the link, nothing to do
+ * @test: KUnit test context
+ *
+ * The new state only drives another link, so this hub keeps its current DSC
+ * configuration.
+ */
+static void dm_mst_test_recompute_no_stream_on_link(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+	struct dc_link *other_link;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	other_link = dm_kunit_alloc_link(test);
+	dm_mst_test_add_link_stream(test, ctx.dc_state, other_link, ctx.aconnector);
+
+	KUNIT_EXPECT_FALSE(test, is_dsc_need_re_compute(ctx.state, ctx.dc_state, ctx.link));
+}
+
+/**
+ * dm_mst_test_recompute_on_mode_change - a modeset on the link forces a recompute
+ * @test: KUnit test context
+ */
+static void dm_mst_test_recompute_on_mode_change(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	dm_mst_test_add_link_stream(test, ctx.dc_state, ctx.link, ctx.aconnector);
+	ctx.crtc_state->enable = true;
+	ctx.crtc_state->active = true;
+	ctx.crtc_state->mode_changed = true;
+
+	KUNIT_EXPECT_TRUE(test, is_dsc_need_re_compute(ctx.state, ctx.dc_state, ctx.link));
+}
+
+/**
+ * dm_mst_test_recompute_unchanged_stream - an untouched stream needs no recompute
+ * @test: KUnit test context
+ *
+ * The same stream is present in both the new and the current state and its
+ * CRTC reports no change, so the existing DSC configuration still applies.
+ */
+static void dm_mst_test_recompute_unchanged_stream(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	dm_mst_test_add_link_stream(test, ctx.dc_state, ctx.link, ctx.aconnector);
+	dm_mst_test_add_link_stream(test, ctx.dc->current_state, ctx.link, ctx.aconnector);
+	ctx.crtc_state->enable = true;
+	ctx.crtc_state->active = true;
+
+	KUNIT_EXPECT_FALSE(test, is_dsc_need_re_compute(ctx.state, ctx.dc_state, ctx.link));
+}
+
+/**
+ * dm_mst_test_recompute_stream_removed - dropping a stream forces a recompute
+ * @test: KUnit test context
+ *
+ * A stream that is on the link in the current state but absent from the new
+ * state frees up bandwidth, so the remaining streams must be recomputed.
+ */
+static void dm_mst_test_recompute_stream_removed(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+	struct amdgpu_dm_connector *gone;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	gone = dm_kunit_alloc_connector(test, ctx.adev, ctx.link);
+	dm_mst_test_add_link_stream(test, ctx.dc_state, ctx.link, ctx.aconnector);
+	dm_mst_test_add_link_stream(test, ctx.dc->current_state, ctx.link, gone);
+	ctx.crtc_state->enable = true;
+	ctx.crtc_state->active = true;
+
+	KUNIT_EXPECT_TRUE(test, is_dsc_need_re_compute(ctx.state, ctx.dc_state, ctx.link));
+}
+
+/**
+ * dm_mst_test_recompute_stream_without_connector - streams need a DM connector
+ * @test: KUnit test context
+ *
+ * A stream on the link whose DM context is not set cannot be attributed to a
+ * connector, so it does not count towards the streams on the link.
+ */
+static void dm_mst_test_recompute_stream_without_connector(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	dm_mst_test_add_link_stream(test, ctx.dc_state, ctx.link, NULL);
+
+	KUNIT_EXPECT_FALSE(test, is_dsc_need_re_compute(ctx.state, ctx.dc_state, ctx.link));
+}
+
+/**
+ * dm_mst_test_recompute_connector_without_crtc - a disabled connector is skipped
+ * @test: KUnit test context
+ */
+static void dm_mst_test_recompute_connector_without_crtc(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	dm_mst_test_add_link_stream(test, ctx.dc_state, ctx.link, ctx.aconnector);
+	dm_mst_test_add_link_stream(test, ctx.dc->current_state, ctx.link, ctx.aconnector);
+	ctx.conn_state->crtc = NULL;
+
+	KUNIT_EXPECT_FALSE(test, is_dsc_need_re_compute(ctx.state, ctx.dc_state, ctx.link));
+}
+
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -3393,6 +3612,15 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_find_crtc_index_no_match),
 	/* is_dsc_precompute_needed tests */
 	KUNIT_CASE_PARAM(dm_mst_test_dsc_precompute_needed, dm_mst_precompute_gen_params),
+	/* is_dsc_need_re_compute tests */
+	KUNIT_CASE(dm_mst_test_recompute_not_mst_branch),
+	KUNIT_CASE(dm_mst_test_recompute_legacy_hub_without_dsc),
+	KUNIT_CASE(dm_mst_test_recompute_no_stream_on_link),
+	KUNIT_CASE(dm_mst_test_recompute_on_mode_change),
+	KUNIT_CASE(dm_mst_test_recompute_unchanged_stream),
+	KUNIT_CASE(dm_mst_test_recompute_stream_removed),
+	KUNIT_CASE(dm_mst_test_recompute_stream_without_connector),
+	KUNIT_CASE(dm_mst_test_recompute_connector_without_crtc),
 	{}
 };
 
-- 
2.43.0


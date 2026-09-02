Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C083DC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D73410E455;
	Wed,  2 Sep 2026 05:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E4fo0vEb";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010044.outbound.protection.outlook.com
 [40.93.198.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8911F10E455
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZX1kIQk7xNiQg33/KCdwzBJ3pgVa93gJ8+4ArUFcMn6I0yDy0xKERqYpoaGHGDTUmyo2AA0CPFbUrjfJkKQJl7tYXzOI4jsyeKMTiTqQG2HprXf57BDo7WnUVWHSoCsnYfx6elLsUlmiC6hXwsw9zk0pjv7w19T2RSOnAAjgtSgk7X0pHYP175k66htb0yRxbS8HrvWStLJvaa3atWN+Qc+n6UleQ7cI1F7a3w66lMuWsTCUAMLDVzNJgn0sg5svmZz7WLNXZz5+R3/u6iESsz9T17MI1ynPcKEdYa6p3cEebL/SXI79Rds6ZNkGldHZNVXtrlnnMRXbiunQD65/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yStCR/F/vm8RLKcbTLXyw/eZOtHFfuQYJ91qq5lNTPs=;
 b=i7OP5MK3uQ+U690ku9OhbYolZOj+/5QQxMqA1qMSXmQAz/J6h31drrBOOBjqtWIgvInVBda/hsOlKgA6EuFufHioDEsmOlw3eq6gfzDzpupV3k8Ew4OGHWCjjL7ZorhpoiNwS9RLyKUlvlxBiCnGaLRLWTmZ0AKDoB57siIWM0Hl8CVsVyDeTgy8mXFO26jkvWrpniNUuJP6/b77Bya/3NYwvJy1jP92x7G4Ndixbfj3h91ArTkHTiL902e29fZMMZ8uDBS2PeWHe17FjNRbAMbQEGg43RT1xCGji80MitL8zY4yUhicBPqF4XIT/rlbagwJ3kTOqgKLzsAonHMuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yStCR/F/vm8RLKcbTLXyw/eZOtHFfuQYJ91qq5lNTPs=;
 b=E4fo0vEbDDFsk1nI4S/1caWz80uGE/1OOqXjVF5WFAoU1Y2zUYtg3gmIGTRA3lZTC5tpdpcNGnII4CAgoUPV4xCMIQ1JpXS+wH5+kEf6P2boCgqh0QB2JrnxaOgJZiXnks0pvSIjafvcS8QUV7/avvpzZf24v3i/KS7Ui4MqLNQ=
Received: from BL1PR13CA0307.namprd13.prod.outlook.com (2603:10b6:208:2c1::12)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:05:01 +0000
Received: from BN1PEPF0001854B.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::79) by BL1PR13CA0307.outlook.office365.com
 (2603:10b6:208:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Wed, 2
 Sep 2026 05:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0001854B.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:04:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:04:59 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:04:50 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 04/40] drm/amd/display: Test self refresh entry
Date: Wed, 2 Sep 2026 12:58:26 +0800
Message-ID: <20260902050411.3473916-5-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854B:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf86711-0eee-481d-5927-08df08afbd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: enhD2v1Y3r25OoV5qghUl8wACNML2OfSsmLa8lSpHaeozTubtlIipX6MXfTqu9HUD1DYlBqeosXrtpSyu44Kaw/lh6Ese3Vwpo4TY9ky2g6ZnEY0QwcAhGrMqbDlUGnWINNym/9GPz+J6UvMx5TafekyHVzMHtCMOqrjlQiNKzxBwzajH1zhBkUjYNVJ3efA6Mto5byFx/aSLPkBBiAYo7e2IRmgbHUMpkl1tIgr/XBGFka6satB1vHS1oq9xCGsSg3CtfoT2b/wVEHCjPoHHZKK2Brff03O3LYxkXke2XBeIW+34dZIoQUjbxuVApNIodfjtVSUPU23W17FnQfrAyQ5rHDVFeq7zTl7jtyxR7N3yCRjUL8GxbKAfv/MGEZqTozOMFB7qcKtCuOW/zzKAX+XZbjaCsZzFj0cQjCsBgdnhTVE/IBvXa3SWIDAFVYgkn+utEzDc566Tl3ro7XzG0MJsXEWuPnYJqZq99rfuP4JUYEPN6u8eOpsUhY2+rwiiYe1nuWn2Y37zXzSrUXs7JhxZ9w1Oil04HQlO1QQG5vfec7ArkjxIgUzQ521AUzQWDnVqF+/dxS3kDVtTSpTCfWH8KowkYaD4cVQ40LJ6laUsxR17XHhe0AHfCmdrL1NUG5MfYA3ju0JHLQTSlmbIVEDf9v0gQzgHnP3vRuzuSqGrKnd6otZZz/AzWFdGpPQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cCY1sTsbHnNrwUxNRRvh+4C/dbsvA0MF0pqrcCN32WgL7cqsSKrHYKUQCQZbZnb3j3OtZ/RB/4YOuxW2jaKNKEFkwitNlHcaQv9c/GJQPDtiX9V4byEqpka0hUFVum4qIgWI3jlPHHCg54siadNv51JgrT/c53Ogi30Yu6EmkRVbcdlaLlCCiECScPRTxgiD1c+6CPoeMjXYOCc80pnZ8xV2Bd2vjOv2e93kKn3xUHZZoY2MYaiKwZJupqJL5cF3rGT7LlmmZxdR0OxVXB4l9Gyu6iKC7r2j1/998Ht+l8sTvVofosp9WGRAxN8ds/FHpHBo7yumpWqkWlIMLzk9Z0FWrR0SCKwfEMk70j3LqL7IAXyZMtgwdOuMwhji02xd5JXpheY1EQXsSArD1YfJVDRhvliITpQvQiktCZNI5usxlt+tI1sAxq4wKxmlNBiS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:04:59.6009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf86711-0eee-481d-5927-08df08afbd32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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

[Why]
Add KUnit tests for amdgpu_dm_enable_self_refresh(), covering the full
update and unsupported link blocks, the skip count gating, the damage
settle window, and a Replay capable link.

[How]
The power module stays NULL, which every mod_power entry point treats as
a no-op, so the event updates can be reached without a live power
module.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6 Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 148 ++++++++++++++++++
 3 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e793dd0426b1..7a06486cec9e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3722,10 +3722,10 @@ STATIC_IFN_KUNIT void amdgpu_dm_update_cursor(struct drm_plane *plane,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_update_cursor);
 
-static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
-					  struct amdgpu_crtc *acrtc_attach,
-					  const struct dm_crtc_state *acrtc_state,
-					  const u64 current_ts)
+STATIC_IFN_KUNIT void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
+						    struct amdgpu_crtc *acrtc_attach,
+						    const struct dm_crtc_state *acrtc_state,
+						    const u64 current_ts)
 {
 	struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
 	struct replay_settings *pr = &acrtc_state->stream->link->replay_settings;
@@ -3761,6 +3761,7 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
 		acrtc_attach->dm_irq_params.allow_sr_entry = false;
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_enable_self_refresh);
 
 STATIC_IFN_KUNIT void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
 					  struct dm_crtc_state *acrtc_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ad72dc182e93..9399f71c528e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1266,6 +1266,9 @@ int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *state, struct dc_
 				     struct dsc_mst_fairness_vars *vars);
 void manage_dm_interrupts(struct amdgpu_device *adev, struct amdgpu_crtc *acrtc,
 			  struct dm_crtc_state *acrtc_state);
+void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
+				   struct amdgpu_crtc *acrtc_attach,
+				   const struct dm_crtc_state *acrtc_state, const u64 current_ts);
 int load_dmcu_fw(struct amdgpu_device *adev);
 int dm_sw_init(struct amdgpu_ip_block *ip_block);
 int dm_late_init(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 4daa187fbd0a..3c975ca2710d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3803,6 +3803,147 @@ static void dm_test_plane_info_layer_and_blending(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->plane_info.global_alpha_value, 0x7f);
 }
 
+/* Tests for amdgpu_dm_enable_self_refresh() */
+
+struct dm_test_sr_ctx {
+	struct amdgpu_display_manager *dm;
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state *acrtc_state;
+	struct amdgpu_dm_connector *aconn;
+	struct dc_link *link;
+};
+
+/*
+ * A fast-update CRTC whose stream has a self-refresh capable link. The power
+ * module stays NULL, which every mod_power entry point treats as a no-op.
+ */
+static struct dm_test_sr_ctx *dm_test_sr_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_sr_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->dm = dm_kunit_alloc_dm(test);
+	ctx->acrtc = kunit_kzalloc(test, sizeof(*ctx->acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->acrtc);
+	ctx->acrtc_state = kunit_kzalloc(test, sizeof(*ctx->acrtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->acrtc_state);
+	ctx->aconn = kunit_kzalloc(test, sizeof(*ctx->aconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconn);
+
+	ctx->link = dm_kunit_alloc_link(test);
+	ctx->acrtc_state->stream = dm_kunit_alloc_stream(test, ctx->link);
+	ctx->acrtc_state->stream->dm_stream_context = ctx->aconn;
+	ctx->acrtc_state->update_type = UPDATE_TYPE_FAST;
+
+	return ctx;
+}
+
+static void dm_test_enable_sr(struct dm_test_sr_ctx *ctx, u64 current_ts)
+{
+	amdgpu_dm_enable_self_refresh(ctx->dm, ctx->acrtc, ctx->acrtc_state,
+				      current_ts);
+}
+
+/**
+ * dm_test_self_refresh_full_update - Test a full update blocks self refresh
+ * @test: The KUnit test context
+ */
+static void dm_test_self_refresh_full_update(struct kunit *test)
+{
+	struct dm_test_sr_ctx *ctx = dm_test_sr_ctx_alloc(test);
+
+	ctx->acrtc_state->update_type = UPDATE_TYPE_FULL;
+	ctx->link->psr_settings.psr_feature_enabled = true;
+	ctx->acrtc->dm_irq_params.allow_sr_entry = true;
+
+	dm_test_enable_sr(ctx, 0);
+
+	KUNIT_EXPECT_FALSE(test, ctx->acrtc->dm_irq_params.allow_sr_entry);
+}
+
+/**
+ * dm_test_self_refresh_unsupported_link - Test a link without PSR or Replay
+ * @test: The KUnit test context
+ */
+static void dm_test_self_refresh_unsupported_link(struct kunit *test)
+{
+	struct dm_test_sr_ctx *ctx = dm_test_sr_ctx_alloc(test);
+
+	ctx->acrtc->dm_irq_params.allow_sr_entry = true;
+
+	dm_test_enable_sr(ctx, 0);
+
+	KUNIT_EXPECT_FALSE(test, ctx->acrtc->dm_irq_params.allow_sr_entry);
+}
+
+/**
+ * dm_test_self_refresh_decrements_skip_count - Test the skip count gates entry
+ * @test: The KUnit test context
+ */
+static void dm_test_self_refresh_decrements_skip_count(struct kunit *test)
+{
+	struct dm_test_sr_ctx *ctx = dm_test_sr_ctx_alloc(test);
+
+	ctx->link->psr_settings.psr_feature_enabled = true;
+	ctx->aconn->sr_skip_count = 2;
+
+	dm_test_enable_sr(ctx, 0);
+
+	KUNIT_EXPECT_EQ(test, ctx->aconn->sr_skip_count, 1);
+	KUNIT_EXPECT_FALSE(test, ctx->acrtc->dm_irq_params.allow_sr_entry);
+}
+
+/**
+ * dm_test_self_refresh_allows_entry - Test a drained skip count allows entry
+ * @test: The KUnit test context
+ */
+static void dm_test_self_refresh_allows_entry(struct kunit *test)
+{
+	struct dm_test_sr_ctx *ctx = dm_test_sr_ctx_alloc(test);
+
+	ctx->link->psr_settings.psr_feature_enabled = true;
+	ctx->aconn->sr_skip_count = 1;
+
+	/* Well past the 500ms settle window, so the events are cleared. */
+	dm_test_enable_sr(ctx, 2ULL * NSEC_PER_SEC);
+
+	KUNIT_EXPECT_EQ(test, ctx->aconn->sr_skip_count, 0);
+	KUNIT_EXPECT_TRUE(test, ctx->acrtc->dm_irq_params.allow_sr_entry);
+}
+
+/**
+ * dm_test_self_refresh_within_settle_window - Test a recent damage change holds off
+ * @test: The KUnit test context
+ */
+static void dm_test_self_refresh_within_settle_window(struct kunit *test)
+{
+	struct dm_test_sr_ctx *ctx = dm_test_sr_ctx_alloc(test);
+
+	ctx->link->psr_settings.psr_feature_enabled = true;
+	ctx->link->psr_settings.psr_dirty_rects_change_timestamp_ns = 1;
+
+	dm_test_enable_sr(ctx, 2);
+
+	KUNIT_EXPECT_TRUE(test, ctx->acrtc->dm_irq_params.allow_sr_entry);
+}
+
+/**
+ * dm_test_self_refresh_replay_link - Test a Replay capable link takes the same path
+ * @test: The KUnit test context
+ */
+static void dm_test_self_refresh_replay_link(struct kunit *test)
+{
+	struct dm_test_sr_ctx *ctx = dm_test_sr_ctx_alloc(test);
+
+	ctx->link->replay_settings.replay_feature_enabled = true;
+
+	dm_test_enable_sr(ctx, 2ULL * NSEC_PER_SEC);
+
+	KUNIT_EXPECT_TRUE(test, ctx->acrtc->dm_irq_params.allow_sr_entry);
+}
+
 /* Tests for manage_dm_interrupts() */
 
 struct dm_test_irq_mgmt_ctx {
@@ -4836,6 +4977,13 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_plane_info_bad_color_encoding),
 	KUNIT_CASE(dm_test_plane_info_rotations),
 	KUNIT_CASE(dm_test_plane_info_layer_and_blending),
+	/* amdgpu_dm_enable_self_refresh */
+	KUNIT_CASE(dm_test_self_refresh_full_update),
+	KUNIT_CASE(dm_test_self_refresh_unsupported_link),
+	KUNIT_CASE(dm_test_self_refresh_decrements_skip_count),
+	KUNIT_CASE(dm_test_self_refresh_allows_entry),
+	KUNIT_CASE(dm_test_self_refresh_within_settle_window),
+	KUNIT_CASE(dm_test_self_refresh_replay_link),
 	/* manage_dm_interrupts */
 	KUNIT_CASE(dm_test_manage_interrupts_offdelay),
 	KUNIT_CASE(dm_test_manage_interrupts_offdelay_fallback),
-- 
2.43.0


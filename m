Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A4DC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E778010EE52;
	Wed, 26 Aug 2026 23:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hzPTckYI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0BBF10EE52
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxzTQALXC8aILhafSm/RHkyOUCfUIregZJSSx4Rgho4OqVd62/jqc0m7qBDCsl5Q+KqYC+GGBX7Eb+KebtB44lP1VyeyCVKmAmupDaqVFiJoRomZUM5dhVCfiKvZb1DbiZTrWV/Si1A/2c5asKDKrxvT82N+Uw+ZgbK2t7wk/uyRqeyu/PxggwNn3WV2yX7++SuGatEBZcFcn11+i+YG6nerFvQqFcMhG4DplY8+cKNBGGAbPqLefYYaeB4vMKUBtbFTcHGpXWKBjplNVIlTNO/cQXcVtZr/AVNaVC4rp9QB2rYYIXhxRP5GtE/FnL2rSf6FgYVdvj1tObU1+Ktj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWhYIn0gkKvoJmCFLEXPUOyvxAycR9FdEJtAXGwssmE=;
 b=kl10GdPFh0z0I3/YqPfWBz7KMfdITz/SRTDjQnz5jygb9pZqbTbF+lwHWw48QtO7waTklwSTxoSok+BdPWI3HzuRgfmz/ntAhJMDFHMz2qwaD2lMX0+JmTHWanjLeBtqnR9XcC4tn8rDiWay3s4BQZ4In0NzKeBQoN9Tt0xfJIQXWgokcdJlW+Mwft9FA5TOw8Y8CNcuwfTUS6aSYZUsS54rc2B70bTs/pos3H5TjDKEpnGNDTuX+sk6U7ZDjEM4nHR31Xqkub/zwIDdB747WR0AlFOXwGWwDryq5dbYZNiwmuQhcjhBHlxTUF8Nuh2Oub6VijF7XmLxRj1H4AU5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWhYIn0gkKvoJmCFLEXPUOyvxAycR9FdEJtAXGwssmE=;
 b=hzPTckYIwfmQkGvhJsd8tN0s0Sa0sLdn9MCEGGeA3FLOMihXg/oigk8kuDa3zbs9q8iIxPOoTsyUhzUBmU1UY9mZLhqe0O1l/O8+eDS3cvaYl89l8l+efaR8b1QBIitNmLulaLAdyrXyiXwmC+PjXgtf7vj45a8if6qDh9lhqYs=
Received: from SN7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::35)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:26:49 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::53) by SN7P222CA0025.outlook.office365.com
 (2603:10b6:806:124::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:26:49 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:26:43 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 33/59] drm/amd/display: Test vblank event arming
Date: Wed, 26 Aug 2026 17:05:04 -0600
Message-ID: <20260826231519.881949-34-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: b0fff071-d741-4fb8-224f-08df03c980b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: FA5qQ1kFaaBCKChKuZSadZMKEwhpa5Uzn0DEAgVPRht4BQp2F6V2Rkd1eZ59xJalk3zxKprat8Rj8Bv9wAOOie5rq8vbgrnoDEwQUvjPIzzRoxhplLtn/STLOl3NJzR7eV+ZdQag1sKSI4vjKuFQj+QkVtqDTkqjZ/OG/B2blTpnw5kmLGy/YYLf9eu7hACuVNAtY8QzpUvmDi7q7R8P4yo0i8vQuulK+tScGI4DDcog0QU72kLVK1EB5uPCrJEJu21aIBUyL4NlugipAPbQm+A2ot+1+v2qEpeWkl0QQKuBB80gFtSNiNEXCRzhdNtlvm8mpKHU5Vk3TfLiHXWtjoKNzYB6JraPuDi8Be96q/xczHJnww5pYUEwwrdspNUkb1xBea6DFLgI5bFBSVfTq7XeJWaAuqwjx/7AqtoPAksS7rC+0GyrfOv7qENyWDummEKiTNYv2L7Jtg+iRvIdSaN1XU/qR7AleRFC2nueCZi6xVCUDX63341vK/cvdcq2k619oLCAlYvwRl0f7XTesKtunzi4/0ovcU1rrIqmDrEVU2KsG9wQhdOjs+F02dS5x6lQGrdMIVITtCq17jqa+ZNwopZTRZDBfBpkoW3xo0FS0faMnsc6Y070swOoVCUfStoEuGGm0rT7Rs9OeOqFqxARU7e83ll/9GtMvadZ0mKDVrhA47DFtF80FrUgPZY1BNuTT1PiNDihDDXy75ekhA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WeXkmEkq1hu8PoLjOj6hsj66Dom34YDNGj776FqlKMQBgoXwk6fkw0RRotFYfy8PNwAtHXT+DGTAKLqapTTX46k+biwGMvlfkdgYByMh39Y8itau+Yf7L26cvRcuVeVDPiJ/nfGiYEfJSJuACGycW84gIIoVPbLOlB5TLlMIDlKaMd55nhPz2ZSurAxAVpcNFCWhR6EQAfTxWbzgp2jnnnS4YSBk7yvu5S8ZYoC7lKqmygoFJ+9SCcOGl8qKi7fa+p7hjltqi0mb5xQPtqj+Rd5uVL6NgATLLV7YxP7+dVEzO/sDJdju79P5DNHzefS9Wg6jiH7Lvd1cvxfmMpmpMLv79pKmm9GDE3/iHvUwnoAOG0rNWP8pIk553xf4Uoo71t/G15MLc8SLG6J6KfIAu838jcJIrOsMNlor3u2WveOA/7ngP5FbS4Z731HzJsy/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:26:49.1004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fff071-d741-4fb8-224f-08df03c980b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273
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

[WHAT]
Add KUnit tests for dm_arm_vblank_event() and
dm_arm_vblank_event_pre_programming() covering missing events, inactive
CRTCs, page-flip and cursor updates, and vblank reference acquisition.

[HOW]
Use one pending-event fixture. Initialize DRM vblank state only for the
pre-programming tests and release every acquired reference.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 185 ++++++++++++++++++
 3 files changed, 201 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 08f2cc7fec68..1eb2f0973aac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3723,10 +3723,10 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
 	}
 }
 
-static void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
-				struct dm_crtc_state *acrtc_state,
-				bool pflip_update,
-				bool cursor_update)
+STATIC_IFN_KUNIT void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
+					  struct dm_crtc_state *acrtc_state,
+					  bool pflip_update,
+					  bool cursor_update)
 {
 	assert_spin_locked(&acrtc->base.dev->event_lock);
 
@@ -3749,6 +3749,7 @@ static void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
 		acrtc->base.state->event = NULL;
 	}
 }
+EXPORT_IF_KUNIT(dm_arm_vblank_event);
 
 /**
  * dm_arm_vblank_event_pre_programming - Prepare for programming
@@ -3761,10 +3762,10 @@ static void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
  * be programmed. Do this before programming so the HW is not in any
  * idle-optimized state (such as PSR).
  */
-static void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *acrtc,
-						struct dm_crtc_state *acrtc_state,
-						bool pflip_update,
-						bool cursor_update)
+STATIC_IFN_KUNIT void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *acrtc,
+							  struct dm_crtc_state *acrtc_state,
+							  bool pflip_update,
+							  bool cursor_update)
 {
 	assert_spin_locked(&acrtc->base.dev->event_lock);
 
@@ -3774,6 +3775,7 @@ static void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *acrtc,
 	if (pflip_update || cursor_update)
 		drm_crtc_vblank_get(&acrtc->base);
 }
+EXPORT_IF_KUNIT(dm_arm_vblank_event_pre_programming);
 
 static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 				    struct drm_device *dev,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ed2341b387d9..e4b67a0b98c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1176,6 +1176,12 @@ void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state);
 void amdgpu_dm_update_cursor(struct drm_plane *plane,
 			     struct drm_plane_state *old_plane_state,
 			     struct dc_stream_update *update);
+void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
+			 struct dm_crtc_state *acrtc_state,
+			 bool pflip_update, bool cursor_update);
+void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *acrtc,
+					 struct dm_crtc_state *acrtc_state,
+					 bool pflip_update, bool cursor_update);
 int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
 			       struct drm_crtc *crtc);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index a2671ad90bfe..648db4a58509 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1552,6 +1552,183 @@ static void dm_test_update_cursor_disables_stream(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, update->cursor_attributes);
 }
 
+/* Tests for dm_arm_vblank_event() */
+
+struct dm_test_vblank_ctx {
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state *acrtc_state;
+	struct drm_pending_vblank_event *event;
+};
+
+/*
+ * A CRTC with one active plane and a pending vblank event. There is no
+ * initialised vblank, so drm_crtc_vblank_get() fails, which the function under
+ * test ignores.
+ */
+static struct dm_test_vblank_ctx *dm_test_vblank_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_vblank_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->adev = dm_kunit_alloc_adev(test);
+	ctx->acrtc = kunit_kzalloc(test, sizeof(*ctx->acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->acrtc);
+	ctx->acrtc_state = kunit_kzalloc(test, sizeof(*ctx->acrtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->acrtc_state);
+	ctx->event = kunit_kzalloc(test, sizeof(*ctx->event), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->event);
+
+	ctx->acrtc->base.dev = &ctx->adev->ddev;
+	ctx->acrtc->base.state = &ctx->acrtc_state->base;
+	ctx->acrtc_state->base.event = ctx->event;
+	ctx->acrtc_state->active_planes = 1;
+
+	return ctx;
+}
+
+static void dm_test_arm_vblank(struct dm_test_vblank_ctx *ctx, bool pflip_update,
+			       bool cursor_update)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->adev->ddev.event_lock, flags);
+	dm_arm_vblank_event(ctx->acrtc, ctx->acrtc_state, pflip_update,
+			    cursor_update);
+	spin_unlock_irqrestore(&ctx->adev->ddev.event_lock, flags);
+}
+
+static void dm_test_arm_vblank_pre_programming(struct dm_test_vblank_ctx *ctx,
+					       bool pflip_update, bool cursor_update)
+{
+	struct dm_crtc_state *state = ctx->acrtc_state;
+	struct amdgpu_crtc *acrtc = ctx->acrtc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->adev->ddev.event_lock, flags);
+	dm_arm_vblank_event_pre_programming(acrtc, state, pflip_update, cursor_update);
+	spin_unlock_irqrestore(&ctx->adev->ddev.event_lock, flags);
+}
+
+/**
+ * dm_test_arm_vblank_pre_programming_no_event - Test missing event takes no reference
+ * @test: The KUnit test context
+ */
+static void dm_test_arm_vblank_pre_programming_no_event(struct kunit *test)
+{
+	struct dm_test_vblank_ctx *ctx = dm_test_vblank_ctx_alloc(test);
+	struct drm_vblank_crtc *vblank;
+
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&ctx->adev->ddev, 1), 0);
+	vblank = drm_crtc_vblank_crtc(&ctx->acrtc->base);
+	ctx->acrtc_state->base.event = NULL;
+
+	dm_test_arm_vblank_pre_programming(ctx, true, false);
+
+	KUNIT_EXPECT_EQ(test, atomic_read(&vblank->refcount), 0);
+}
+
+/**
+ * dm_test_arm_vblank_pre_programming_no_planes - Test inactive CRTC takes no reference
+ * @test: The KUnit test context
+ */
+static void dm_test_arm_vblank_pre_programming_no_planes(struct kunit *test)
+{
+	struct dm_test_vblank_ctx *ctx = dm_test_vblank_ctx_alloc(test);
+	struct drm_vblank_crtc *vblank;
+
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&ctx->adev->ddev, 1), 0);
+	vblank = drm_crtc_vblank_crtc(&ctx->acrtc->base);
+	ctx->acrtc_state->active_planes = 0;
+
+	dm_test_arm_vblank_pre_programming(ctx, false, true);
+
+	KUNIT_EXPECT_EQ(test, atomic_read(&vblank->refcount), 0);
+}
+
+/**
+ * dm_test_arm_vblank_pre_programming_update - Test an update takes a vblank reference
+ * @test: The KUnit test context
+ */
+static void dm_test_arm_vblank_pre_programming_update(struct kunit *test)
+{
+	struct dm_test_vblank_ctx *ctx = dm_test_vblank_ctx_alloc(test);
+	struct drm_vblank_crtc *vblank;
+
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&ctx->adev->ddev, 1), 0);
+	vblank = drm_crtc_vblank_crtc(&ctx->acrtc->base);
+
+	dm_test_arm_vblank_pre_programming(ctx, true, false);
+
+	KUNIT_EXPECT_EQ(test, atomic_read(&vblank->refcount), 1);
+	drm_crtc_vblank_put(&ctx->acrtc->base);
+}
+
+/**
+ * dm_test_arm_vblank_event_no_event - Test a commit without an event is a no-op
+ * @test: The KUnit test context
+ */
+static void dm_test_arm_vblank_event_no_event(struct kunit *test)
+{
+	struct dm_test_vblank_ctx *ctx = dm_test_vblank_ctx_alloc(test);
+
+	ctx->acrtc_state->base.event = NULL;
+
+	dm_test_arm_vblank(ctx, true, false);
+
+	KUNIT_EXPECT_NULL(test, ctx->acrtc->event);
+}
+
+/**
+ * dm_test_arm_vblank_event_no_active_planes - Test an event is left armed without planes
+ * @test: The KUnit test context
+ */
+static void dm_test_arm_vblank_event_no_active_planes(struct kunit *test)
+{
+	struct dm_test_vblank_ctx *ctx = dm_test_vblank_ctx_alloc(test);
+
+	ctx->acrtc_state->active_planes = 0;
+
+	dm_test_arm_vblank(ctx, false, true);
+
+	KUNIT_EXPECT_NULL(test, ctx->acrtc->event);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->acrtc_state->base.event, ctx->event);
+}
+
+/**
+ * dm_test_arm_vblank_event_pflip - Test a page flip arms the flip ISR
+ * @test: The KUnit test context
+ */
+static void dm_test_arm_vblank_event_pflip(struct kunit *test)
+{
+	struct dm_test_vblank_ctx *ctx = dm_test_vblank_ctx_alloc(test);
+
+	dm_test_arm_vblank(ctx, true, false);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx->acrtc->event, ctx->event);
+	KUNIT_EXPECT_NULL(test, ctx->acrtc_state->base.event);
+	KUNIT_EXPECT_EQ(test, (int)ctx->acrtc->pflip_status,
+			(int)AMDGPU_FLIP_SUBMITTED);
+}
+
+/**
+ * dm_test_arm_vblank_event_cursor - Test a cursor update consumes the event
+ * @test: The KUnit test context
+ */
+static void dm_test_arm_vblank_event_cursor(struct kunit *test)
+{
+	struct dm_test_vblank_ctx *ctx = dm_test_vblank_ctx_alloc(test);
+
+	dm_test_arm_vblank(ctx, false, true);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx->acrtc->event, ctx->event);
+	KUNIT_EXPECT_NULL(test, ctx->acrtc_state->base.event);
+	KUNIT_EXPECT_EQ(test, (int)ctx->acrtc->pflip_status,
+			(int)AMDGPU_FLIP_NONE);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -1637,6 +1814,14 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_commit_cursors_updates_cursor),
 	KUNIT_CASE(dm_test_update_cursor_no_framebuffer),
 	KUNIT_CASE(dm_test_update_cursor_disables_stream),
+	/* dm_arm_vblank_event */
+	KUNIT_CASE(dm_test_arm_vblank_event_no_event),
+	KUNIT_CASE(dm_test_arm_vblank_event_no_active_planes),
+	KUNIT_CASE(dm_test_arm_vblank_event_pflip),
+	KUNIT_CASE(dm_test_arm_vblank_event_cursor),
+	KUNIT_CASE(dm_test_arm_vblank_pre_programming_no_event),
+	KUNIT_CASE(dm_test_arm_vblank_pre_programming_no_planes),
+	KUNIT_CASE(dm_test_arm_vblank_pre_programming_update),
 	{}
 };
 
-- 
2.43.0


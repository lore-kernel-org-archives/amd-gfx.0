Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CA5C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BCB510F092;
	Wed, 15 Jul 2026 13:47:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QnC6L6OA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C15810F08D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nalqIRjNDU2tN2uwiXRN0VI9LMNTYOxCWO4HYmB06zQuGkg/+xt8fI/3nHaQW0D8GseU4WuvGepetBApnqh1KEFnLkl0sDZWbzSnFb3Ug0u/zlTy1BGOzSMe2Z/eWLowoK7e+CrXq/8lk1Hnv8hzCgHSPJ2oCbaUXZg/aRZdjNrNm9hwDn9IlrDZ/TpX7Aaxngo2HkeNfgcrY69+R12qmr+CuAG5TqmXQFYxpotTCAqdZCnHIpDVuVhIbuQBK6oeUXxFMmUDzgT87GB2UNqIf/PUJuL70AZqwwGZW/2Z7cRsHHOvQTFPKWGu1eedWHY44OdXsmg7/HjaFUQqiF7hCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxFkugpYVf+qRM3mgFynIVDW++Lb8YZhJNL8gmJTKZw=;
 b=dKHZ8jtrkco5xPbMfnhK5f2FdfpxKVKt/WRruG9+O/ObBCEJvnbLOl/iLCLLhanqhkI9AF0IuiulASuC3D7xetxTiFJlP4VOihxtU64hrHnx/gt9JCkqQ1xJG+znv9Yeg36y5Et2qWL8YQRyHlYr4Jl86L8Bl9MmgMHyUwyQZ+pgjrn8jRd7XYAHmkdzVhtvFbrmxO3lZl95INI9/aiCtbPqZSbvbuxMha2cysgmaIlNCcFU993rW1Vm2EmPfUhz82cx+Cj31RQmKQmDEBSFzVq+vGQAh4n1IVnh6BbnKnoETD6HTPiqYiswRzEPgGrnvAM4S+G+xPvwnvv/izsdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxFkugpYVf+qRM3mgFynIVDW++Lb8YZhJNL8gmJTKZw=;
 b=QnC6L6OAN4p7WIl6A1yuFVDb4jdbzGEUimSQdQxUoWDpOR2hHMUQo/3GdqqB3r+/NhlcGRshA8hzvPZFxzlDgNB9WubpERmFr8LLMgFBq3wcKomL0gCM9j6840BjLA9byT2As3HjJBSivyrNfUMky8PJvZdahZ9kM8vkV8R33Us=
Received: from CY5PR18CA0002.namprd18.prod.outlook.com (2603:10b6:930:5::25)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:47:02 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::5c) by CY5PR18CA0002.outlook.office365.com
 (2603:10b6:930:5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:01 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:58 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 34/70] drm/amd/display: add KUnit tests for HDCP state diffing
Date: Wed, 15 Jul 2026 21:37:44 +0800
Message-ID: <20260715134432.1975118-35-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da637a1-872f-4862-f867-08dee2778cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|22082099003|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: +ERrvDjJBrykCKp/FNipN0WdZL+5L1s7f+skJWy5IFFExTfZH0DlPS5/8AMLIWSCPVBmtuYYVYfkVcDLAiejkG0hWysVABKZ+1Q5WPM4ixakBYc5S/8R7p7ER8zkaHX692/Vnf8ZwWfJNZDgcGTDH0FiYy9YzsfQY8HXTUZODAIIowSLuC09HPk6R34iytc4KpKG+mNuV65ePa8pR5hdkhhHKF7D6r2A56yd7FQrh+j955KKzRrVcPGGipsnHjGVarK3h2Wxmqpfs8Wq4cLGKhePZl7NhsC1YUUdLcR49mAOvnyKzUelb0xkkvq69UlYRlZI6eScZDchNOGdNJQO+ACTuWFW4cCnWtl5WQ6Lzr4n0YEoCn5me2JVIgZOjHzvPpT093Q8VV4G9PiyJxOzqfi2L2R+BvWR6snYq+GKNJX2hXZldJlFWACA5z50I71PgZAv1KTpYj+pUwiamjKvOW8JxpGk0P2xaAmOuhC31H8t2FKe0sjG/gXKbSgGkktNR2bUzR3g/ueuB+v386SN2hndwZZf2NiJlF659E3U/QeYGATZ+KLC3Aa3/vPC/Sq2x+S6CuRkQ94a574OTjXBFB4k5CgDATPetKqwUmlNm0OoYo8cktX3UKJfFWR9wVHgD08bo7pGXy/BySEVtmW91A25O2EzJYyqlMCsNRIl9/d++SSEDayJFCYlxxQpM3BaeUvkagoCtPokQOupq7+ZYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kxn2QUG6BOcOP9VigX+LT0qxlrB8+n1O72Zlf58UTWf2WIft71lhB59NmlgJBMSVVFRC4+bu4UOQYDAYctJ4dpFfZxcQ+ImEY5/hpGkrHgeHLCmjdh7wqrgF6okNzgrKDSRJVvnJD74Rfg+9VB+J9TSsC+fDQ9q+MywpPdaYOwpTkQl+7Iy4iebCQ5pvBtwK1bbpDdXhIDxFKhxrysXw9goOdDtXMvpeexa5UMV93MvSl4kdDPRp+HMSIV6SCJcV7yK7xTeIMBqBUTX0v07UoPkx9h1TcwJLEsI+EbcXRolvj96zzaC3W5SwyfubCjzuztmyubnlGGdyyqg3F7uJRWdS/nsCOEl/Do6f9u2pBMXRzkS/oVUzEeONqrDTu8r87GIRY+EoklkZ9dlpZlMoFRSTU2fSjwIf7Gc6uP/CQZaoKqXUmFE9uwzgl7CXFn6T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:02.2617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da637a1-872f-4862-f867-08dee2778cbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
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
Add KUnit tests for is_content_protection_different using a shared
connector/crtc fixture. Cover the content-type change, ENABLED->DESIRED
re-enable (with and without modeset), UNDESIRED and DESIRED steady
states, the update_hdcp hot-plug and stream re-enable paths, and the
S3/DESIRED/UNDESIRED enable transitions.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 237 ++++++++++++++++++
 3 files changed, 252 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fc1a73435203..03b9079ce818 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3653,12 +3653,13 @@ is_scaling_state_different(const struct dm_connector_state *dm_state,
 }
 EXPORT_IF_KUNIT(is_scaling_state_different);
 
-static bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
-					    struct drm_crtc_state *old_crtc_state,
-					    struct drm_connector_state *new_conn_state,
-					    struct drm_connector_state *old_conn_state,
-					    const struct drm_connector *connector,
-					    struct hdcp_workqueue *hdcp_w)
+STATIC_IFN_KUNIT bool
+is_content_protection_different(struct drm_crtc_state *new_crtc_state,
+				struct drm_crtc_state *old_crtc_state,
+				struct drm_connector_state *new_conn_state,
+				struct drm_connector_state *old_conn_state,
+				const struct drm_connector *connector,
+				struct hdcp_workqueue *hdcp_w)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
@@ -3772,6 +3773,7 @@ static bool is_content_protection_different(struct drm_crtc_state *new_crtc_stat
 	pr_debug("[HDCP_DM] DESIRED->ENABLED %s :false\n", __func__);
 	return false;
 }
+EXPORT_IF_KUNIT(is_content_protection_different);
 
 static void remove_stream(struct amdgpu_device *adev,
 			  struct amdgpu_crtc *acrtc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index bef9663caf6e..c508f0be1b55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1178,6 +1178,13 @@ bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 				struct dm_crtc_state *new_state);
 void set_multisync_trigger_params(struct dc_stream_state *stream);
 void set_master_stream(struct dc_stream_state *stream_set[], int stream_count);
+struct hdcp_workqueue;
+bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
+				     struct drm_crtc_state *old_crtc_state,
+				     struct drm_connector_state *new_conn_state,
+				     struct drm_connector_state *old_conn_state,
+				     const struct drm_connector *connector,
+				     struct hdcp_workqueue *hdcp_w);
 #endif
 
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 724d03db2736..1caacad43106 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1425,6 +1425,231 @@ static void dm_test_update_scaling_underscan(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, stream->dst.height, 1048);
 }
 
+/* Tests for is_content_protection_different() */
+
+struct dm_test_cp_ctx {
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_connector_state *new_dm;	/* also connector->state */
+	struct dm_connector_state *old_dm;
+	struct drm_crtc_state *new_crtc;
+	struct drm_crtc_state *old_crtc;
+};
+
+static struct dm_test_cp_ctx *dm_test_cp_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	ctx->new_dm = kunit_kzalloc(test, sizeof(*ctx->new_dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->new_dm);
+	ctx->old_dm = kunit_kzalloc(test, sizeof(*ctx->old_dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->old_dm);
+	ctx->new_crtc = kunit_kzalloc(test, sizeof(*ctx->new_crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->new_crtc);
+	ctx->old_crtc = kunit_kzalloc(test, sizeof(*ctx->old_crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->old_crtc);
+
+	/* connector->state must be the new dm connector state */
+	ctx->aconnector->base.state = &ctx->new_dm->base;
+	ctx->aconnector->base.dpms = DRM_MODE_DPMS_ON;
+
+	return ctx;
+}
+
+static bool dm_test_cp_diff(struct dm_test_cp_ctx *ctx)
+{
+	return is_content_protection_different(ctx->new_crtc, ctx->old_crtc,
+					       &ctx->new_dm->base,
+					       &ctx->old_dm->base,
+					       &ctx->aconnector->base, NULL);
+}
+
+/**
+ * dm_test_cp_diff_hdcp_type_change - Test an HDCP content-type change forces true
+ * @test: The KUnit test context
+ */
+static void dm_test_cp_diff_hdcp_type_change(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx = dm_test_cp_ctx_alloc(test);
+
+	ctx->old_dm->base.hdcp_content_type = 0;
+	ctx->new_dm->base.hdcp_content_type = 1;
+	ctx->new_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_cp_diff(ctx));
+	KUNIT_EXPECT_EQ(test, (int)ctx->new_dm->base.content_protection,
+			(int)DRM_MODE_CONTENT_PROTECTION_DESIRED);
+}
+
+/**
+ * dm_test_cp_diff_reenable_mode_changed - Test ENABLED->DESIRED with modeset forces true
+ * @test: The KUnit test context
+ */
+static void dm_test_cp_diff_reenable_mode_changed(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx = dm_test_cp_ctx_alloc(test);
+
+	ctx->old_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+	ctx->new_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_crtc->mode_changed = true;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_cp_diff(ctx));
+	KUNIT_EXPECT_EQ(test, (int)ctx->new_dm->base.content_protection,
+			(int)DRM_MODE_CONTENT_PROTECTION_DESIRED);
+}
+
+/**
+ * dm_test_cp_diff_reenable_no_change - Test ENABLED->DESIRED without modeset restores ENABLED
+ * @test: The KUnit test context
+ */
+static void dm_test_cp_diff_reenable_no_change(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx = dm_test_cp_ctx_alloc(test);
+
+	ctx->old_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+	ctx->new_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_crtc->mode_changed = false;
+
+	KUNIT_EXPECT_FALSE(test, dm_test_cp_diff(ctx));
+	KUNIT_EXPECT_EQ(test, (int)ctx->new_dm->base.content_protection,
+			(int)DRM_MODE_CONTENT_PROTECTION_ENABLED);
+}
+
+/**
+ * dm_test_cp_diff_undesired - Test UNDESIRED->UNDESIRED needs no update
+ * @test: The KUnit test context
+ */
+static void dm_test_cp_diff_undesired(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx = dm_test_cp_ctx_alloc(test);
+
+	ctx->old_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
+	ctx->new_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
+
+	KUNIT_EXPECT_FALSE(test, dm_test_cp_diff(ctx));
+}
+
+/**
+ * dm_test_cp_diff_desired_mode_changed - Test DESIRED->DESIRED with modeset forces true
+ * @test: The KUnit test context
+ */
+static void dm_test_cp_diff_desired_mode_changed(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx = dm_test_cp_ctx_alloc(test);
+
+	ctx->old_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_crtc->mode_changed = true;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_cp_diff(ctx));
+}
+
+/**
+ * dm_test_cp_diff_desired_no_change - Test steady DESIRED->DESIRED needs no update
+ * @test: The KUnit test context
+ */
+static void dm_test_cp_diff_desired_no_change(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx = dm_test_cp_ctx_alloc(test);
+
+	ctx->old_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_crtc->mode_changed = false;
+
+	KUNIT_EXPECT_FALSE(test, dm_test_cp_diff(ctx));
+}
+
+/**
+ * dm_test_cp_diff_update_hdcp_hotplug - Test the update_hdcp hot-plug path forces true
+ * @test: The KUnit test context
+ */
+static void dm_test_cp_diff_update_hdcp_hotplug(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx = dm_test_cp_ctx_alloc(test);
+	struct dc_sink *sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	ctx->old_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_dm->update_hdcp = true;
+	ctx->aconnector->base.dpms = DRM_MODE_DPMS_ON;
+	ctx->aconnector->dc_sink = sink;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_cp_diff(ctx));
+	KUNIT_EXPECT_FALSE(test, ctx->new_dm->update_hdcp);
+}
+
+/**
+ * dm_test_cp_diff_stream_reenabled - Test the stream removed-and-re-enabled path forces true
+ * @test: The KUnit test context
+ */
+static void dm_test_cp_diff_stream_reenabled(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx = dm_test_cp_ctx_alloc(test);
+	struct drm_crtc *crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	crtc->enabled = true;
+
+	ctx->old_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_dm->update_hdcp = true;
+	ctx->old_dm->base.crtc = NULL;
+	ctx->new_dm->base.crtc = crtc;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_cp_diff(ctx));
+	KUNIT_EXPECT_FALSE(test, ctx->new_dm->update_hdcp);
+}
+
+/**
+ * dm_test_cp_diff_s3_undesired_to_enabled - Test the S3 UNDESIRED->ENABLED path forces true
+ * @test: The KUnit test context
+ */
+static void dm_test_cp_diff_s3_undesired_to_enabled(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx = dm_test_cp_ctx_alloc(test);
+
+	ctx->old_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
+	ctx->new_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_cp_diff(ctx));
+	KUNIT_EXPECT_EQ(test, (int)ctx->new_dm->base.content_protection,
+			(int)DRM_MODE_CONTENT_PROTECTION_DESIRED);
+}
+
+/**
+ * dm_test_cp_diff_desired_to_enabled - Test DESIRED->ENABLED needs no update
+ * @test: The KUnit test context
+ */
+static void dm_test_cp_diff_desired_to_enabled(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx = dm_test_cp_ctx_alloc(test);
+
+	ctx->old_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+
+	KUNIT_EXPECT_FALSE(test, dm_test_cp_diff(ctx));
+}
+
+/**
+ * dm_test_cp_diff_desired_to_undesired - Test DESIRED->UNDESIRED forces update
+ * @test: The KUnit test context
+ */
+static void dm_test_cp_diff_desired_to_undesired(struct kunit *test)
+{
+	struct dm_test_cp_ctx *ctx = dm_test_cp_ctx_alloc(test);
+
+	ctx->old_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	ctx->new_dm->base.content_protection = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_cp_diff(ctx));
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_is_idle),
@@ -1505,6 +1730,18 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_update_scaling_rmx_aspect_letterbox),
 	KUNIT_CASE(dm_test_update_scaling_rmx_center),
 	KUNIT_CASE(dm_test_update_scaling_underscan),
+	/* is_content_protection_different */
+	KUNIT_CASE(dm_test_cp_diff_hdcp_type_change),
+	KUNIT_CASE(dm_test_cp_diff_reenable_mode_changed),
+	KUNIT_CASE(dm_test_cp_diff_reenable_no_change),
+	KUNIT_CASE(dm_test_cp_diff_undesired),
+	KUNIT_CASE(dm_test_cp_diff_desired_mode_changed),
+	KUNIT_CASE(dm_test_cp_diff_desired_no_change),
+	KUNIT_CASE(dm_test_cp_diff_update_hdcp_hotplug),
+	KUNIT_CASE(dm_test_cp_diff_stream_reenabled),
+	KUNIT_CASE(dm_test_cp_diff_s3_undesired_to_enabled),
+	KUNIT_CASE(dm_test_cp_diff_desired_to_enabled),
+	KUNIT_CASE(dm_test_cp_diff_desired_to_undesired),
 	{}
 };
 
-- 
2.43.0


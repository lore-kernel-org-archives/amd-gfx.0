Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84DAC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6236810EB51;
	Tue,  8 Sep 2026 11:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XfsydG6f";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BD110EB51
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmvveQ+3wWIbCjOGOUJxQTxdlI1yOE/pwcfnuLdFG/zsATq1v/cjGbzxVeJuOeDkc2ZCUM143igJgTCinJZdznTssJrdAPHHjrHhaV/bVC2mA5sWNMb3GfdMphqo4H67Pg17MLD9JjWO00CloMSSLUVladGndUqh8TCkzNZYP0ec8m2AdrgHebHXDDXvDBjdyKAkGPRHLO6lZkmVRSmpZtqeDT87yk8Gd6EUt36fuX5WIOxqbdbsuuOSRur0old8WbD/ogdwQizuCBgXB5s5hZJOxDcGRJ2eDYgMpm7IsQlnTbFH9C8TV6zKFJNk4Myq8gKVuN4x3ymkCOqBUm3J+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd9656zj2TtZPH6bqmJhzpPNgPvtMwBtGHm4qsk0MYo=;
 b=lFp6VCG9IoObA8M7i6sFejpR7RQRx02YiuKufvprBwxiURPAPuE06RKIl56eEwSuBoZkPUpvrl2Z90KjBdHKNJMIpKqfn/s3klx1Nv6367emS/BX1p5Iq/vaOvMHk8Q5h3kt0QTse+u5QEloopifsHOEmwYRrav2IZjhNRRg2AJ03hNF6n42t4N2pi20s48JECN7DgIrdhX/1Fin4HLy9j///wMQALhgk+L4wc8zu4Jq/yUED1prTGZ/BtAETCgWVupZxthovxVJWWrqs5gdUucisxGAqvpA15LjJiumW6Unq1IIk+I+si4CEOQ5Ae5LS6K8kjMa86n3oiGu7iEEXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd9656zj2TtZPH6bqmJhzpPNgPvtMwBtGHm4qsk0MYo=;
 b=XfsydG6fDvLO8UupPe6XTVi6Ytx/zdUCRtkXr3b/iQZZ60u92KcvIle+MP0AkBuY+z9hIS1pivM0zdhyQwU+gTrvjmEyc+utFfQFp5L9ZNx9cJmt1Sz3t/2RIH1EsOuxR1Rgfnk2z5Xrwz5iXAc84uJkwCCcMxCVAq5BpfmX5Y8=
Received: from SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:37:48 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::8a) by SJ0PR13CA0069.outlook.office365.com
 (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:37:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:37:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:37:46 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:37:38 -0500
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
Subject: [PATCH 27/66] drm/amd/display: Test DSC precompute helpers
Date: Tue, 8 Sep 2026 19:31:20 +0800
Message-ID: <20260908113338.2433445-28-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac7da43-bfa2-4251-2239-08df0d9d9b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: f2MEeaNf/rwCEdCW6ko3+oPAjRs40D7XiEnVXYDk7AkOIJwAIZIpgD9dvi7XcjeVRMnw8vKKJMqWX1fdM3Z19YrIcmVJhdVC7WhydDvBD6OnW0DVd/qh+VMEAsvrWp7mHJpM9fFOdR9A2I++c9gTbmY74x/kdWXLn+1FzJ4uP/+uBr6OguTzkbDMT90DbTVVEuf+WSXKhuBlBUoBQ1zh6aj5OiGgrtV4ZwMtGssiMagAzSFqKVvBPTBrw+y3xk+b4qr3GmuAu1DbIjd8Tu8JO3UEmfGcaJyAMXGN5wCz/NXUYQtdvUyhkIfIpc+hkgFg5bh2ZXfMxAK3SiPACaqVohzuVMTzVIsg9hOQy9VrgHKKEhF8TzgS1HLW452Vi42aYOV2M8vxk+nOSvsrxvAkQAQcd19BFOo3OPpB0C3MCX4bx+IToYT+pSaETc5GOdUZTP+yC8Nw7mD07qhfQKHQXw7mdIVjuRZbVM81EANo5Q7e+2BVKTrb8KXehZez03wT+4SEcfZhngrK3FDnvAgjMKI3vAe75vE8eh+7jxAACg9LG+UfW2tPSmIsSle0OB8/Z+Ef815XuXdqbja3R7cOElnyYAIZxXy9HbpLB/LNIo3sAZQZkZtqck2O6VwBK4meZ5ISEae2z3gtPZL2wiY+uYJCG69cNPvXRSbJ0ABH5XH0e8JJDNIryJwrnKeNhb0yIrtW7nbNfiGsHbpQiax6CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GTpC240T5mPJ9wF0hfg7O7uXfxkJ6RJSSpcvTXM5gde4BydbZSuUk56mZQ3kdlC8UmOrQryPqO2Q1EK+pWx2QdGX7RW1dFze9xX8JQxD09Q9P+tfpzWKBx1CDinyHMoj7igK4PJwEaVrIBMLIhtQD6iMfrcppUweRdCJhwW7un6fzj9jmkvBY3I9M9rmr4HJHRn2FcahgcSjGTvifvno97c8rl1pEarw2q0B6wq4gWlfCcb39UIi+QPaYLw3TjrxCdtEL+AcHxmeQUqIL26YaVSPYKOoyZtNabQ38BKDB5+3JhhD529rgOry4QJ0nXo8GMqDdhgVqEs29DnMYtsqL46wKHvOnXmNXQF3ba6VKUVZ3vwzIKplhQLRGKYfeZsM/TpkPbSzkP9NiDXnqh+IC9j6JJwv05DN3TGMZRat6kbyP9BRPUp0UXtey6e5vibk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:37:47.8646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac7da43-bfa2-4251-2239-08df0d9d9b82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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
Add KUnit tests for log_dsc_params(), for
find_crtc_index_in_state_by_stream() with a matching and a missing
stream, and for is_dsc_precompute_needed() covering an empty state, a
stream without a link, a non MST link, an MST link whose CRTC is not
in the state and an MST link that needs the precompute pass.

[HOW]
Hand build a drm_atomic_commit with CRTC states and DC stream states so
the stream to CRTC lookup can be driven directly, and reuse it for a
table driven is_dsc_precompute_needed() test that varies the link
signal type and whether the CRTC is present.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  11 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   4 +
 .../tests/amdgpu_dm_mst_types_test.c          | 174 ++++++++++++++++++
 3 files changed, 185 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 4c6e7c28e4f8..f5085a0036af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1303,7 +1303,7 @@ static void build_frl_mst_dsc_params(struct amdgpu_dm_connector *aconnector,
 	}
 }
 
-static void log_dsc_params(int count, struct dsc_mst_fairness_vars *vars, int k)
+STATIC_IFN_KUNIT void log_dsc_params(int count, struct dsc_mst_fairness_vars *vars, int k)
 {
 	int i;
 
@@ -1311,6 +1311,7 @@ static void log_dsc_params(int count, struct dsc_mst_fairness_vars *vars, int k)
 		DRM_DEBUG_DRIVER("MST_DSC DSC params: stream #%d --- dsc_enabled = %d, bpp_x16 = %d, pbn = %d\n",
 				 i, vars[i + k].dsc_enabled, vars[i + k].bpp_x16, vars[i + k].pbn);
 }
+EXPORT_IF_KUNIT(log_dsc_params);
 
 static int compute_mst_dsc_configs_for_link(struct drm_atomic_commit *state,
 					    struct dc_state *dc_state,
@@ -1739,8 +1740,8 @@ static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state
 	return ret;
 }
 
-static int find_crtc_index_in_state_by_stream(struct drm_atomic_commit *state,
-					      struct dc_stream_state *stream)
+STATIC_IFN_KUNIT int find_crtc_index_in_state_by_stream(struct drm_atomic_commit *state,
+							struct dc_stream_state *stream)
 {
 	int i;
 	struct drm_crtc *crtc;
@@ -1754,6 +1755,7 @@ static int find_crtc_index_in_state_by_stream(struct drm_atomic_commit *state,
 	}
 	return -1;
 }
+EXPORT_IF_KUNIT(find_crtc_index_in_state_by_stream);
 
 static bool is_link_to_dschub(struct dc_link *dc_link)
 {
@@ -1770,7 +1772,7 @@ static bool is_link_to_dschub(struct dc_link *dc_link)
 	return true;
 }
 
-static bool is_dsc_precompute_needed(struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT bool is_dsc_precompute_needed(struct drm_atomic_commit *state)
 {
 	int i;
 	struct drm_crtc *crtc;
@@ -1790,6 +1792,7 @@ static bool is_dsc_precompute_needed(struct drm_atomic_commit *state)
 	}
 	return ret;
 }
+EXPORT_IF_KUNIT(is_dsc_precompute_needed);
 
 int pre_validate_dsc(struct drm_atomic_commit *state,
 		     struct dm_atomic_state **dm_state_ptr,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index e1a25afb570c..b1d7a21a37e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -109,6 +109,10 @@ bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_mst_port
 bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw);
 bool get_conv_frl_bw(struct amdgpu_dm_connector *aconnector,
 		     uint32_t *bw_in_kbps, uint32_t *dsc_bw_in_kbps);
+void log_dsc_params(int count, struct dsc_mst_fairness_vars *vars, int k);
+int find_crtc_index_in_state_by_stream(struct drm_atomic_commit *state,
+				       struct dc_stream_state *stream);
+bool is_dsc_precompute_needed(struct drm_atomic_commit *state);
 bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector);
 bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector);
 bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 0e5dd4ca9aed..d91863d5416d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -3109,6 +3109,173 @@ static void dm_mst_test_conv_frl_bw_bottleneck(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dsc_bw_in_kbps, 6000U);
 }
 
+/* Tests for log_dsc_params */
+
+/**
+ * dm_mst_test_log_dsc_params - logging the fairness vars leaves them untouched
+ * @test: KUnit test context
+ *
+ * log_dsc_params() only traces, so the only observable contract is that it
+ * walks @count entries starting at @k without modifying them.
+ */
+static void dm_mst_test_log_dsc_params(struct kunit *test)
+{
+	struct dsc_mst_fairness_vars vars[3] = {
+		{ .pbn = 100, .dsc_enabled = false, .bpp_x16 = 160 },
+		{ .pbn = 200, .dsc_enabled = true, .bpp_x16 = 192 },
+		{ .pbn = 300, .dsc_enabled = true, .bpp_x16 = 256 },
+	};
+
+	log_dsc_params(2, vars, 1);
+
+	KUNIT_EXPECT_EQ(test, vars[1].pbn, 200);
+	KUNIT_EXPECT_EQ(test, vars[2].bpp_x16, 256);
+}
+
+/* Tests for find_crtc_index_in_state_by_stream and is_dsc_precompute_needed */
+
+struct dm_mst_test_crtc_state_ctx {
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtcs;
+	struct dm_crtc_state *crtc_states;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+};
+
+/*
+ * Hand-build an atomic state with @num_crtc CRTCs, each carrying a DM CRTC
+ * state. drm_atomic_state_alloc() would need a fully registered mode config,
+ * and the helpers under test only walk the crtcs/connectors arrays.
+ */
+static void dm_mst_test_init_crtc_state_ctx(struct kunit *test,
+					    struct dm_mst_test_crtc_state_ctx *ctx,
+					    unsigned int num_crtc)
+{
+	struct amdgpu_device *adev;
+	unsigned int i;
+
+	adev = dm_kunit_alloc_adev(test);
+	adev->ddev.mode_config.num_crtc = num_crtc;
+
+	ctx->state = kunit_kzalloc(test, sizeof(*ctx->state), GFP_KERNEL);
+	ctx->crtcs = kunit_kcalloc(test, num_crtc, sizeof(*ctx->crtcs), GFP_KERNEL);
+	ctx->crtc_states = kunit_kcalloc(test, num_crtc, sizeof(*ctx->crtc_states), GFP_KERNEL);
+	ctx->connector = kunit_kzalloc(test, sizeof(*ctx->connector), GFP_KERNEL);
+	ctx->conn_state = kunit_kzalloc(test, sizeof(*ctx->conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_states);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->connector);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
+
+	ctx->state->dev = &adev->ddev;
+	ctx->state->crtcs = kunit_kcalloc(test, num_crtc, sizeof(*ctx->state->crtcs), GFP_KERNEL);
+	ctx->state->connectors = kunit_kzalloc(test, sizeof(*ctx->state->connectors), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state->crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state->connectors);
+
+	for (i = 0; i < num_crtc; i++) {
+		ctx->crtcs[i].dev = &adev->ddev;
+		ctx->crtc_states[i].base.crtc = &ctx->crtcs[i];
+		ctx->state->crtcs[i].ptr = &ctx->crtcs[i];
+		ctx->state->crtcs[i].new_state = &ctx->crtc_states[i].base;
+		ctx->state->crtcs[i].old_state = &ctx->crtc_states[i].base;
+	}
+}
+
+/* Attach the context's connector to @crtc so the CRTC looks driven. */
+static void dm_mst_test_attach_connector(struct dm_mst_test_crtc_state_ctx *ctx,
+					 struct drm_crtc *crtc)
+{
+	ctx->conn_state->crtc = crtc;
+	ctx->state->connectors[0].ptr = ctx->connector;
+	ctx->state->connectors[0].new_state = ctx->conn_state;
+	ctx->state->num_connector = 1;
+}
+
+/**
+ * dm_mst_test_find_crtc_index_matches - the CRTC driving a stream is found
+ * @test: KUnit test context
+ */
+static void dm_mst_test_find_crtc_index_matches(struct kunit *test)
+{
+	struct dm_mst_test_crtc_state_ctx ctx;
+	struct dc_stream_state *stream;
+
+	dm_mst_test_init_crtc_state_ctx(test, &ctx, 3);
+	stream = dm_kunit_alloc_stream(test, NULL);
+	ctx.crtc_states[2].stream = stream;
+
+	KUNIT_EXPECT_EQ(test, find_crtc_index_in_state_by_stream(ctx.state, stream), 2);
+}
+
+/**
+ * dm_mst_test_find_crtc_index_no_match - an unknown stream yields -1
+ * @test: KUnit test context
+ */
+static void dm_mst_test_find_crtc_index_no_match(struct kunit *test)
+{
+	struct dm_mst_test_crtc_state_ctx ctx;
+	struct dc_stream_state *stream;
+
+	dm_mst_test_init_crtc_state_ctx(test, &ctx, 2);
+	stream = dm_kunit_alloc_stream(test, NULL);
+
+	KUNIT_EXPECT_EQ(test, find_crtc_index_in_state_by_stream(ctx.state, stream), -1);
+}
+
+struct dm_mst_precompute_param {
+	const char *name;
+	bool connector_attached;
+	bool has_stream;
+	enum dc_connection_type link_type;
+	bool dsc_support;
+	bool dsc_passthrough;
+	bool needed;
+};
+
+static const struct dm_mst_precompute_param dm_mst_precompute_params[] = {
+	{ "no_connector", false, true, dc_connection_mst_branch, true, false, false },
+	{ "dsc_hub", true, true, dc_connection_mst_branch, true, false, true },
+	{ "dsc_passthrough_hub", true, true, dc_connection_mst_branch, false, true, true },
+	{ "sst_link", true, true, dc_connection_single, true, false, false },
+	{ "mst_without_dsc", true, true, dc_connection_mst_branch, false, false, false },
+	{ "no_stream", true, false, dc_connection_mst_branch, true, false, false },
+};
+
+KUNIT_ARRAY_PARAM_DESC(dm_mst_precompute, dm_mst_precompute_params, name);
+
+/**
+ * dm_mst_test_dsc_precompute_needed - precompute needs a driven DSC MST hub
+ * @test: KUnit test context
+ *
+ * A DSC or DSC passthrough capable MST branch that a connector in the state
+ * drives needs its bandwidth precomputed. A CRTC no connector drives aborts
+ * the scan, and SST links or MST branches without DSC never need it.
+ */
+static void dm_mst_test_dsc_precompute_needed(struct kunit *test)
+{
+	const struct dm_mst_precompute_param *param = test->param_value;
+	struct dm_mst_test_crtc_state_ctx ctx;
+	struct dc_link *link;
+
+	dm_mst_test_init_crtc_state_ctx(test, &ctx, 1);
+	if (param->connector_attached)
+		dm_mst_test_attach_connector(&ctx, &ctx.crtcs[0]);
+
+	if (param->has_stream) {
+		link = dm_kunit_alloc_link(test);
+		link->type = param->link_type;
+		link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT =
+			param->dsc_support;
+		link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT =
+			param->dsc_passthrough;
+		ctx.crtc_states[0].stream = dm_kunit_alloc_stream(test, link);
+	}
+
+	KUNIT_EXPECT_EQ(test, is_dsc_precompute_needed(ctx.state), param->needed);
+}
+
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -3219,6 +3386,13 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_conv_frl_bw_not_hdmi_port),
 	KUNIT_CASE(dm_mst_test_conv_frl_bw_sink_without_frl),
 	KUNIT_CASE(dm_mst_test_conv_frl_bw_bottleneck),
+	/* log_dsc_params tests */
+	KUNIT_CASE(dm_mst_test_log_dsc_params),
+	/* find_crtc_index_in_state_by_stream tests */
+	KUNIT_CASE(dm_mst_test_find_crtc_index_matches),
+	KUNIT_CASE(dm_mst_test_find_crtc_index_no_match),
+	/* is_dsc_precompute_needed tests */
+	KUNIT_CASE_PARAM(dm_mst_test_dsc_precompute_needed, dm_mst_precompute_gen_params),
 	{}
 };
 
-- 
2.43.0


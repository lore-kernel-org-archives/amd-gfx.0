Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9A2C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9C810E6BE;
	Fri, 17 Dec 2021 21:24:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496D310E650
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0yxcBrG+KJIhYeMI73bRLjXr0A6XTZrERWjfUbpwNfz14bqkRxSYavg85mgXtT93y/F6eWX0nv0SaKTCQi9MduadO7DrygfVJDFVg9JHg+uIIFdLLEES+IHF5C2/JHotr0A5YomzDlhyvE+lvALKQRRmf9OJG7g/tCD8PnWj79pC8Rox7YsCZjiogPTx0GyY5nV07XLGN9NqsH9RcXgXkEVzJiqTJnLN7lmSEbeBzp17LNZZOK1oCGXT6IL45slIVJu1kZJJojI7ht0eCJj47YLO+r/Y7Ybws5xgKnSsBN9UxelSzE7zgvKhHw3rW0lBSuABz3VTF642fOLLvTl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY6m6zWHQ8XVEcUivYk1u12U+xHsznld6lcOcsLbXy0=;
 b=n9hxh6OFeO6yFHkzGn1bVIohmcfo5xJibYemWQzdBIjfaGj3GG6htfewgthBzZ4wcgfvPD1SAiB3+/Iq9IZ2pBf0fPKRTrJAWpRych+XCKDygy7qVHXXZyHYyFYp5k/T4lKvAmVCzDKlUhlFjHyqzXYJQgyCRwTb3JhY54ZNGyVO4JRzP+Zb64zituCSzbllUegS/gnyLyt0s9ZkP4qXSffjGZmA06ZgDzTciT1QktxDymZiDENbXqNQd1MJwa66e2P4Ji/xmL6yCg0syMKnN2YHQjdb8JfNTZARSf28Sh39xeufcd67xjO+qbhCYNohUZQxv/c3Dcth4WEb37cQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY6m6zWHQ8XVEcUivYk1u12U+xHsznld6lcOcsLbXy0=;
 b=qsYa6Pq/Bhnj10fIzI3Mn1MvXDF2DF8+gsDJXk3CPdfU99NNHL9paKPySUi/2aw/mes2/+vQVqUe7RfoqaSQNG00OYFsmwnuQkANtIJoo6oeWB8+Sii7iBKNv25J7bsDnBxvbHfkKuARxGmUjVhcJi/oXtAOEVbNGjNIwOvhNSM=
Received: from CO2PR06CA0057.namprd06.prod.outlook.com (2603:10b6:104:3::15)
 by BY5PR12MB3730.namprd12.prod.outlook.com (2603:10b6:a03:1ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 21:24:43 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::61) by CO2PR06CA0057.outlook.office365.com
 (2603:10b6:104:3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:43 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:41 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/19] drm/amd/display: access hpo dp link encoder only
 through link resource
Date: Fri, 17 Dec 2021 16:24:05 -0500
Message-ID: <20211217212407.3583190-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd9ef5d1-18e3-4a07-eaca-08d9c1a3a490
X-MS-TrafficTypeDiagnostic: BY5PR12MB3730:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37302E4460A5924C0B8059A698789@BY5PR12MB3730.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xcs7yqaloEWTb7wF6uJaUr+aHbv5O/PHiQm7oXiOr4OALvyJ2bCtleuQztHMRrE/GeVjb5bHUL33lB5iw9u/fOz2mrOfDAwGc/Lfv6g3Y/duSyKBdBvO6dlicf50HEsViDUbfv/vdF4SjnU2fTkWanayVYb9j2j1gguMNTgBofS92DffLoT5nEeTu/W6zagM0B1R5IKzXkjeo+HJjCgfNpO2LhhU+V53S9QroDo9zoi++ldEOfcVTOEMK0UewrBQvMkF6H1JkQYqQn8SxhthQFUZ3mh0DhbmnYs9GWYQ/C4RpVS8x/DH4+5Sf56Vmlc4fEkV/LxaZl8QuYd48rHfbgFmqza0//sY7jLT23vbGJAigHCQy9oZ7/BKVqvHggzWBAgmzLSoQdrmrwCfm+qK6DQVxUrBgwc/upVg98mA57U+v+Y0D9/dVBWnoF4iMERdXrEHeKkjKZpkgtdgRVEqF9UqTCMMPkMFQaPgPtf66SkaLu21TYlEgmA8rLHVmPulAP9aRB/ZCNQUxwIkL/jYJNSfTN5es4YpX8C2Rw7V1blbGJtkmIbKhjb/eSB+tnitMfkJCqKMqCNw6CaEikVK6R22WXacrtai6hB5UmC86vYNnobtRDI0CYwJd3Yiap2wvGXm/fY6H4Reden+Z5apmOE46gJwhoxhYHVYbli+w/jJ5CFMzUWpRlHRlIbTNjw6f+KEhO7fCtXn4vY22Jxlnh7JzhwP9duFSPUPNbwkN3hdg8h6wfE0tT4Qw2hRWfqIfdaCCeL/LQ/GK+Ph36baanqgowDZDdmCnRPyZOY1kuY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(26005)(36860700001)(83380400001)(6916009)(47076005)(8936002)(426003)(82310400004)(54906003)(1076003)(8676002)(36756003)(508600001)(16526019)(40460700001)(336012)(2906002)(81166007)(316002)(70206006)(86362001)(30864003)(4326008)(5660300002)(6666004)(356005)(2616005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:43.2814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9ef5d1-18e3-4a07-eaca-08d9c1a3a490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3730
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Update all accesses to use hpo dp link encoder through link resource
only.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 22 +++++++-------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 12 +++++---
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 30 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 14 +++------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  2 +-
 .../gpu/drm/amd/display/dc/dml/dml_wrapper.c  |  2 +-
 7 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a394946ef513..9197dd73c6d2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3426,7 +3426,7 @@ static enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx,
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
-	struct hpo_dp_link_encoder *hpo_dp_link_encoder = link->hpo_dp_link_enc;
+	struct hpo_dp_link_encoder *hpo_dp_link_encoder = pipe_ctx->link_res.hpo_dp_link_enc;
 	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
 	struct link_mst_stream_allocation_table proposed_table = {0};
 	struct fixed31_32 avg_time_slots_per_mtp;
@@ -3508,7 +3508,7 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct link_encoder *link_encoder = NULL;
 	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	struct hpo_dp_link_encoder *hpo_dp_link_encoder = link->hpo_dp_link_enc;
+	struct hpo_dp_link_encoder *hpo_dp_link_encoder = pipe_ctx->link_res.hpo_dp_link_enc;
 	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
 #endif
 	struct dp_mst_stream_allocation_table proposed_table = {0};
@@ -3838,7 +3838,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct link_encoder *link_encoder = NULL;
 	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	struct hpo_dp_link_encoder *hpo_dp_link_encoder = link->hpo_dp_link_enc;
+	struct hpo_dp_link_encoder *hpo_dp_link_encoder = pipe_ctx->link_res.hpo_dp_link_enc;
 	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
 #endif
 	struct dp_mst_stream_allocation_table proposed_table = {0};
@@ -4164,12 +4164,12 @@ static void fpga_dp_hpo_enable_link_and_stream(struct dc_state *state, struct pi
 		proposed_table.stream_allocations[0].hpo_dp_stream_enc = pipe_ctx->stream_res.hpo_dp_stream_enc;
 	}
 
-	stream->link->hpo_dp_link_enc->funcs->update_stream_allocation_table(
-			stream->link->hpo_dp_link_enc,
+	pipe_ctx->link_res.hpo_dp_link_enc->funcs->update_stream_allocation_table(
+			pipe_ctx->link_res.hpo_dp_link_enc,
 			&proposed_table);
 
-	stream->link->hpo_dp_link_enc->funcs->set_throttled_vcp_size(
-			stream->link->hpo_dp_link_enc,
+	pipe_ctx->link_res.hpo_dp_link_enc->funcs->set_throttled_vcp_size(
+			pipe_ctx->link_res.hpo_dp_link_enc,
 			pipe_ctx->stream_res.hpo_dp_stream_enc->inst,
 			avg_time_slots_per_mtp);
 
@@ -4674,11 +4674,9 @@ void dc_link_set_preferred_training_settings(struct dc *dc,
 	if (link_setting != NULL) {
 		link->preferred_link_setting = *link_setting;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-		if (dp_get_link_encoding_format(link_setting) ==
-				DP_128b_132b_ENCODING && !link->hpo_dp_link_enc) {
-			if (!add_dp_hpo_link_encoder_to_link(link))
-				memset(&link->preferred_link_setting, 0, sizeof(link->preferred_link_setting));
-		}
+		if (dp_get_link_encoding_format(link_setting) == DP_128b_132b_ENCODING)
+			/* TODO: add dc update for acquiring link res  */
+			skip_immediate_retrain = true;
 #endif
 	} else {
 		link->preferred_link_setting.lane_count = LANE_COUNT_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 98835d6c9036..05e216524370 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3211,9 +3211,11 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link,
 	if (link_enc)
 		link_enc->funcs->get_max_link_cap(link_enc, &max_link_cap);
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (max_link_cap.link_rate >= LINK_RATE_UHBR10 &&
-			!link->hpo_dp_link_enc)
-		max_link_cap.link_rate = LINK_RATE_HIGH3;
+	if (max_link_cap.link_rate >= LINK_RATE_UHBR10) {
+		if (!link_res->hpo_dp_link_enc ||
+				link->dc->debug.disable_uhbr)
+			max_link_cap.link_rate = LINK_RATE_HIGH3;
+	}
 #endif
 
 	/* Lower link settings based on sink's link cap */
@@ -7016,8 +7018,10 @@ struct fixed31_32 calculate_sst_avg_time_slots_per_mtp(
 
 bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx)
 {
+	/* If this assert is hit then we have a link encoder dynamic management issue */
+	ASSERT(pipe_ctx->stream_res.hpo_dp_stream_enc ? pipe_ctx->link_res.hpo_dp_link_enc != NULL : true);
 	return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
-			pipe_ctx->stream->link->hpo_dp_link_enc &&
+			pipe_ctx->link_res.hpo_dp_link_enc &&
 			dc_is_dp_signal(pipe_ctx->stream->signal));
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 10d7f986011d..dd69e8f22e75 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -243,7 +243,7 @@ void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	struct hpo_dp_link_encoder *hpo_link_enc = link->hpo_dp_link_enc;
+	struct hpo_dp_link_encoder *hpo_link_enc = link_res->hpo_dp_link_enc;
 #endif
 	struct link_encoder *link_enc;
 
@@ -366,8 +366,8 @@ void dp_set_hw_lane_settings(
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (dp_get_link_encoding_format(&link_settings->link_settings) ==
 			DP_128b_132b_ENCODING) {
-		link->hpo_dp_link_enc->funcs->set_ffe(
-				link->hpo_dp_link_enc,
+		link_res->hpo_dp_link_enc->funcs->set_ffe(
+				link_res->hpo_dp_link_enc,
 				&link_settings->link_settings,
 				link_settings->lane_settings[0].FFE_PRESET.raw);
 	} else if (dp_get_link_encoding_format(&link_settings->link_settings)
@@ -412,8 +412,8 @@ void dp_set_hw_test_pattern(
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	switch (link_encoding_format) {
 	case DP_128b_132b_ENCODING:
-		link->hpo_dp_link_enc->funcs->set_link_test_pattern(
-				link->hpo_dp_link_enc, &pattern_param);
+		link_res->hpo_dp_link_enc->funcs->set_link_test_pattern(
+				link_res->hpo_dp_link_enc, &pattern_param);
 		break;
 	case DP_8b_10b_ENCODING:
 		ASSERT(encoder);
@@ -797,8 +797,8 @@ void enable_dp_hpo_output(struct dc_link *link,
 		}
 	} else {
 		/* DP2.0 HW: call transmitter control to enable PHY */
-		link->hpo_dp_link_enc->funcs->enable_link_phy(
-				link->hpo_dp_link_enc,
+		link_res->hpo_dp_link_enc->funcs->enable_link_phy(
+				link_res->hpo_dp_link_enc,
 				link_settings,
 				link->link_enc->transmitter);
 	}
@@ -814,11 +814,11 @@ void enable_dp_hpo_output(struct dc_link *link,
 		phyd32clk = get_phyd32clk_src(link);
 		dc->res_pool->dccg->funcs->enable_symclk32_le(
 				dc->res_pool->dccg,
-				link->hpo_dp_link_enc->inst,
+				link_res->hpo_dp_link_enc->inst,
 				phyd32clk);
-		link->hpo_dp_link_enc->funcs->link_enable(
-					link->hpo_dp_link_enc,
-					link_settings->lane_count);
+		link_res->hpo_dp_link_enc->funcs->link_enable(
+				link_res->hpo_dp_link_enc,
+				link_settings->lane_count);
 	}
 }
 
@@ -828,12 +828,12 @@ void disable_dp_hpo_output(struct dc_link *link,
 {
 	const struct dc *dc = link->dc;
 
-	link->hpo_dp_link_enc->funcs->link_disable(link->hpo_dp_link_enc);
+	link_res->hpo_dp_link_enc->funcs->link_disable(link_res->hpo_dp_link_enc);
 
 	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		dc->res_pool->dccg->funcs->disable_symclk32_le(
 					dc->res_pool->dccg,
-					link->hpo_dp_link_enc->inst);
+					link_res->hpo_dp_link_enc->inst);
 
 		dc->res_pool->dccg->funcs->set_physymclk(
 					dc->res_pool->dccg,
@@ -844,8 +844,8 @@ void disable_dp_hpo_output(struct dc_link *link,
 		dm_set_phyd32clk(dc->ctx, 0);
 	} else {
 		/* DP2.0 HW: call transmitter control to disable PHY */
-		link->hpo_dp_link_enc->funcs->disable_link_phy(
-				link->hpo_dp_link_enc,
+		link_res->hpo_dp_link_enc->funcs->disable_link_phy(
+				link_res->hpo_dp_link_enc,
 				signal);
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1be74d6223df..288e7b01f561 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -691,6 +691,7 @@ struct dc_debug_options {
 	/* TODO - remove once tested */
 	bool legacy_dp2_lt;
 	bool set_mst_en_for_sst;
+	bool disable_uhbr;
 	bool force_dp2_lt_fallback_method;
 #endif
 	union mem_low_power_enable_options enable_mem_low_power;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 2d470f524367..f19015413ce3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -468,8 +468,6 @@ void dcn10_log_hw_state(struct dc *dc,
 	log_mpc_crc(dc, log_ctx);
 
 	{
-		int hpo_dp_link_enc_count = 0;
-
 		if (pool->hpo_dp_stream_enc_count > 0) {
 			DTN_INFO("DP HPO S_ENC:  Enabled  OTG   Format   Depth   Vid   SDP   Compressed  Link\n");
 			for (i = 0; i < pool->hpo_dp_stream_enc_count; i++) {
@@ -500,18 +498,14 @@ void dcn10_log_hw_state(struct dc *dc,
 		}
 
 		/* log DP HPO L_ENC section if any hpo_dp_link_enc exists */
-		for (i = 0; i < dc->link_count; i++)
-			if (dc->links[i]->hpo_dp_link_enc)
-				hpo_dp_link_enc_count++;
-
-		if (hpo_dp_link_enc_count) {
+		if (pool->hpo_dp_link_enc_count) {
 			DTN_INFO("DP HPO L_ENC:  Enabled  Mode   Lanes   Stream  Slots   VC Rate X    VC Rate Y\n");
 
-			for (i = 0; i < dc->link_count; i++) {
-				struct hpo_dp_link_encoder *hpo_dp_link_enc = dc->links[i]->hpo_dp_link_enc;
+			for (i = 0; i < pool->hpo_dp_link_enc_count; i++) {
+				struct hpo_dp_link_encoder *hpo_dp_link_enc = pool->hpo_dp_link_enc[i];
 				struct hpo_dp_link_enc_state hpo_dp_le_state = {0};
 
-				if (hpo_dp_link_enc && hpo_dp_link_enc->funcs->read_state) {
+				if (hpo_dp_link_enc->funcs->read_state) {
 					hpo_dp_link_enc->funcs->read_state(hpo_dp_link_enc, &hpo_dp_le_state);
 					DTN_INFO("[%d]:                 %d  %6s     %d        %d      %d     %d     %d\n",
 							hpo_dp_link_enc->inst,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index a17fe8ab2904..4991e93e5308 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2414,7 +2414,7 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->map_stream_to_link(
 				pipe_ctx->stream_res.hpo_dp_stream_enc,
 				pipe_ctx->stream_res.hpo_dp_stream_enc->inst,
-				link->hpo_dp_link_enc->inst);
+				pipe_ctx->link_res.hpo_dp_link_enc->inst);
 	}
 
 	if (!is_dp_128b_132b_signal(pipe_ctx) && link_enc)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
index 91810aaee5a3..789f7562cdc7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
@@ -1274,7 +1274,7 @@ static void dcn20_adjust_adaptive_sync_v_startup(
 static bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx)
 {
 	return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
-			pipe_ctx->stream->link->hpo_dp_link_enc &&
+			pipe_ctx->link_res.hpo_dp_link_enc &&
 			dc_is_dp_signal(pipe_ctx->stream->signal));
 }
 
-- 
2.25.1


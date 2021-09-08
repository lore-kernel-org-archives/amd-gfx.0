Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45714C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1415D60724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1415D60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7496E1BC;
	Wed,  8 Sep 2021 14:54:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04796E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUUR3S5LcPGMQVREPOHVIjapHgEH9ZTtk13t4YyqF8IhGdqdbPDIKaEMDgOKs97o6wLrahT6CLWMLwQR6qzxxuVOcnwqpbZzwji/y5EoHMa2oVBtjbtOcVjnkLlypIpLr8/gbfjkPrfJIvSXHmbB06URhiW1X6ghjt4yBW+uZ/8ONLTwIkjzmCXtInNUwy9Rt2NDVC8dsDeBNEB/k3B+GX7g77qKGwtOKqGeSQqtonAEDIAIUMyJ7Etp7tx2npDXkQdtQQphQ5C+HjFpcpn30j83D7lN5LP/YwAHrYaDWT7uhhgJPOc3PUepaXQOjtXB+1P4eShdJ7GAq4EAHHgYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=orHUYCVVEpmVQg7x/WEtEqDL9J3giL2OrmZ8pMkMsjM=;
 b=Wc1estCYAtewcTR/herKKoWQ1ZZw59/ILsK/h6v7VR25dlK+bpTMNjIMM30H6UTeStGzsl+Bvg7TDK5UoH1DSXusJRIzAkj9FwPZDDXTrwojO0//w7SVO6+Vgsg7DIUvQEJKBIVhi1ymj8jBXscG6YlUL86fBi6P1Zz3rUT2au7uR4MHXRCySjDp35PxWRRyj1+ukk1Ax62vnvCo3NW6yJbb45AIAy3r8qNadVXdKj+LeE/zTyPysgHhncZ2zDHt3HsaExZMzH7mdMTDdthay2D1ZYebkpp60rpNeg9aDcwW5aE6xVJqdQ98q9BKavQQB8npggA1TPahqspIXe9P0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orHUYCVVEpmVQg7x/WEtEqDL9J3giL2OrmZ8pMkMsjM=;
 b=qw/zSTjJFK7UHPArlIH/9rxP7GCSRBpgzd+f/FDoJl2tvWWt26cg6t5P1VIOFvfd5b6ptVmAnPv+HHfgADPLhf56e0AfA+Tk/wszqlPWJMHY35xYE/yUT9nGugMhd9PhnFy3COXo+Kl35pji2CExnXVbszhssGQy/PILWo3rJz4=
Received: from DM5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:3:23::34) by
 MN2PR12MB3503.namprd12.prod.outlook.com (2603:10b6:208:cf::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19; Wed, 8 Sep 2021 14:54:51 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::60) by DM5PR13CA0024.outlook.office365.com
 (2603:10b6:3:23::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:51 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:44 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 09/33] drm/amd/display: Fix dynamic link encoder access.
Date: Wed, 8 Sep 2021 10:54:00 -0400
Message-ID: <20210908145424.3311-10-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ad8b040-d81a-4e55-f666-08d972d89c5a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3503:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3503FBC3372680DD938320F2E4D49@MN2PR12MB3503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jwob5s6uiaMFOq2AgCRGuGNiUzLbtLdPAtnDCbmVkzi+0T46S5tDtnhIylmpH7Vao75T6FLKwxg8+KLr3MJ/vmM3vzttgmxm5qHPUSQHImhYDfyCHHRB2u1YY2Ip7SecueIyJ/wJ7wGkkFyjuBA45Z1yA5lA6m/vKee5inDEWGb8SWuhCXAQEEKfUxvHQRSK8ojoGIqClYjf9Yso3qI9dJBgQaVRBNfLx0XCDpgoojdQsMFGwHS4uyRtM3hqBmKxlg9IIMGaoLjjyz5+xycWIDlRh8Q5X3top8PMAiy4iUbJ04sC77zEn9r1UisO2B54VSpCTa6E/mJr3CzUs0ZA0GgeKGE8djsGmcfl8sJhv4hFXOebKW7NLZ/raYvivgj88DXS7ShMNxo1FHiP0jTmL9A/SIXiFzIsJgY+APkrmeJoKDCYjocGEmChEG5ZCkg/12PGGisdXey0+6pk5DgyniBg88H6OP9SK1WH5YMDONicRzBQhr5VIoXk+QjTxoUsqBq6PIhB4X453HOMXGY5gSkC55FnDCOFtPbxIGmhJaYiC0LpqvLHnEVJuEkLl7ub9WtyVRqCTXDBE8Sn5XBiIO311rRSvxBQZ2td3jtMXwtBnGzIcXE87Z+xJkGVOHMGNG+HZh7KWCIHMxJrW3hnwkJCyolL49PLZc26LbXmCtdh28iTxLbTc5b056gprmZHXCc+y3VkcQd/e1imtFScHyIRPNaysWS5KvcLUHu8kaA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(54906003)(83380400001)(82740400003)(86362001)(316002)(2906002)(4326008)(36860700001)(82310400003)(44832011)(36756003)(186003)(2616005)(336012)(1076003)(70206006)(70586007)(8936002)(426003)(26005)(16526019)(8676002)(6666004)(47076005)(81166007)(6916009)(478600001)(5660300002)(30864003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:51.0435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad8b040-d81a-4e55-f666-08d972d89c5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3503
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Assuming DIG link encoders are statically mapped to links can cause
system instability due to null pointer accesses.

[How]
- Add checks for non-null link encoder pointers before trying to access
them.
- When a hardware platform uses dynamic DIG assignment (i.e. resource
function 'link_encs_assign' defined) and a link supports flexible
mapping to DIGs, use the link_enc_cfg API to access the DIG assigned to
a link or stream.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 42 +++++++++++++++----
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 36 ++++++++++++++--
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 25 ++++++-----
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  7 ++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  3 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 22 +++++++---
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 13 ++++--
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 20 ++++++++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  9 +++-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  5 +++
 12 files changed, 147 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 15491e3ca11a..1414da4b95d7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -87,7 +87,7 @@ int dcn31_get_active_display_cnt_wa(
 		const struct dc_link *link = dc->links[i];
 
 		/* abusing the fact that the dig and phy are coupled to see if the phy is enabled */
-		if (link->link_enc->funcs->is_dig_enabled &&
+		if (link->link_enc && link->link_enc->funcs->is_dig_enabled &&
 				link->link_enc->funcs->is_dig_enabled(link->link_enc))
 			display_count++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 5d9460e0dbab..3c8eb3e659af 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3457,6 +3457,10 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 {
 	struct cp_psp *cp_psp = &pipe_ctx->stream->ctx->cp_psp;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	struct link_encoder *link_enc = NULL;
+#endif
+
 	if (cp_psp && cp_psp->funcs.update_stream_config) {
 		struct cp_psp_stream_config config = {0};
 		enum dp_panel_mode panel_mode =
@@ -3468,8 +3472,21 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 		config.dig_be = pipe_ctx->stream->link->link_enc_hw_inst;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		config.stream_enc_idx = pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA;
-		config.link_enc_idx = pipe_ctx->stream->link->link_enc->transmitter - TRANSMITTER_UNIPHY_A;
-		config.phy_idx = pipe_ctx->stream->link->link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+		if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY) {
+			link_enc = pipe_ctx->stream->link->link_enc;
+			config.phy_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+		} else if (pipe_ctx->stream->link->dc->res_pool->funcs->link_encs_assign) {
+			/* Use link encoder assignment from current DC state - which may differ from the DC state to be
+			 * committed - when updating PSP config.
+			 */
+			link_enc = link_enc_cfg_get_link_enc_used_by_stream(
+					pipe_ctx->stream->link->dc->current_state,
+					pipe_ctx->stream);
+			config.phy_idx = 0; /* Clear phy_idx for non-physical display endpoints. */
+		}
+		ASSERT(link_enc);
+		if (link_enc)
+			config.link_enc_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 		if (is_dp_128b_132b_signal(pipe_ctx)) {
 			config.stream_enc_idx = pipe_ctx->stream_res.hpo_dp_stream_enc->id - ENGINE_ID_HPO_DP_0;
 			config.link_enc_idx = pipe_ctx->stream->link->hpo_dp_link_enc->inst;
@@ -3576,6 +3593,7 @@ void core_link_enable_stream(
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->sink->link;
 	enum dc_status status;
+	struct link_encoder *link_enc;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
 #endif
@@ -3585,15 +3603,22 @@ void core_link_enable_stream(
 			dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
 
+	if (dc->res_pool->funcs->link_encs_assign && stream->link->ep_type != DISPLAY_ENDPOINT_PHY)
+		link_enc = stream->link_enc;
+	else
+		link_enc = stream->link->link_enc;
+	ASSERT(link_enc);
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (!dc_is_virtual_signal(pipe_ctx->stream->signal)
 			&& !is_dp_128b_132b_signal(pipe_ctx)) {
 #else
 	if (!dc_is_virtual_signal(pipe_ctx->stream->signal)) {
 #endif
-		stream->link->link_enc->funcs->setup(
-			stream->link->link_enc,
-			pipe_ctx->stream->signal);
+		if (link_enc)
+			link_enc->funcs->setup(
+				link_enc,
+				pipe_ctx->stream->signal);
 		pipe_ctx->stream_res.stream_enc->funcs->setup_stereo_sync(
 			pipe_ctx->stream_res.stream_enc,
 			pipe_ctx->stream_res.tg->inst,
@@ -3748,9 +3773,10 @@ void core_link_enable_stream(
 #else
 		if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
 #endif
-			stream->link->link_enc->funcs->setup(
-				stream->link->link_enc,
-				pipe_ctx->stream->signal);
+			if (link_enc)
+				link_enc->funcs->setup(
+					link_enc,
+					pipe_ctx->stream->signal);
 
 		dc->hwss.enable_stream(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 4d1ac9836dca..6fc0e12a715a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2625,13 +2625,27 @@ static enum dc_link_rate get_lttpr_max_link_rate(struct dc_link *link)
 
 bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap)
 {
+	struct link_encoder *link_enc = NULL;
+
 	if (!max_link_enc_cap) {
 		DC_LOG_ERROR("%s: Could not return max link encoder caps", __func__);
 		return false;
 	}
 
-	if (link->link_enc->funcs->get_max_link_cap) {
-		link->link_enc->funcs->get_max_link_cap(link->link_enc, max_link_enc_cap);
+	/* Links supporting dynamically assigned link encoder will be assigned next
+	 * available encoder if one not already assigned.
+	 */
+	if (link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign) {
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		if (link_enc == NULL)
+			link_enc = link_enc_cfg_get_next_avail_link_enc(link->dc, link->dc->current_state);
+	} else
+		link_enc = link->link_enc;
+	ASSERT(link_enc);
+
+	if (link_enc && link_enc->funcs->get_max_link_cap) {
+		link_enc->funcs->get_max_link_cap(link_enc, max_link_enc_cap);
 		return true;
 	}
 
@@ -2647,9 +2661,23 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	enum dc_link_rate lttpr_max_link_rate;
 #endif
+	struct link_encoder *link_enc = NULL;
+
+	/* Links supporting dynamically assigned link encoder will be assigned next
+	 * available encoder if one not already assigned.
+	 */
+	if (link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign) {
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		if (link_enc == NULL)
+			link_enc = link_enc_cfg_get_next_avail_link_enc(link->dc, link->dc->current_state);
+	} else
+		link_enc = link->link_enc;
+	ASSERT(link_enc);
 
 	/* get max link encoder capability */
-	link->link_enc->funcs->get_max_link_cap(link->link_enc, &max_link_cap);
+	if (link_enc)
+		link_enc->funcs->get_max_link_cap(link_enc, &max_link_cap);
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (max_link_cap.link_rate >= LINK_RATE_UHBR10 &&
 			!link->hpo_dp_link_enc)
@@ -2868,7 +2896,7 @@ bool dp_verify_link_cap(
 	 * PHY will sometimes be in bad state on hotplugging display from certain USB-C dongle,
 	 * so add extra cycle of enabling and disabling the PHY before first link training.
 	 */
-	if (link->link_enc->features.flags.bits.DP_IS_USB_C &&
+	if (link->link_enc && link->link_enc->features.flags.bits.DP_IS_USB_C &&
 			link->dc->debug.usbc_combo_phy_reset_wa) {
 		dp_enable_link_phy(link, link->connector_signal, dp_cs_id, cur);
 		dp_disable_link_phy(link, link->connector_signal);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index de80a9ea4cfa..49b17bbea8d1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -139,7 +139,7 @@ static struct dc_stream_state *get_stream_using_link_enc(
 	for (i = 0; i < state->stream_count; i++) {
 		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
 
-		if (assignment.valid && (assignment.eng_id == eng_id)) {
+		if ((assignment.valid == true) && (assignment.eng_id == eng_id)) {
 			stream_idx = i;
 			break;
 		}
@@ -254,7 +254,7 @@ struct dc_link *link_enc_cfg_get_link_using_link_enc(
 	for (i = 0; i < state->stream_count; i++) {
 		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
 
-		if (assignment.valid && (assignment.eng_id == eng_id)) {
+		if ((assignment.valid == true) && (assignment.eng_id == eng_id)) {
 			stream_idx = i;
 			break;
 		}
@@ -274,7 +274,6 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
 {
 	struct link_encoder *link_enc = NULL;
 	struct display_endpoint_id ep_id;
-	int stream_idx = -1;
 	int i;
 
 	ep_id = (struct display_endpoint_id) {
@@ -283,20 +282,15 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
 
 	for (i = 0; i < state->stream_count; i++) {
 		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
-
-		if (assignment.valid &&
+		if (assignment.valid == true &&
 				assignment.ep_id.link_id.id == ep_id.link_id.id &&
 				assignment.ep_id.link_id.enum_id == ep_id.link_id.enum_id &&
 				assignment.ep_id.link_id.type == ep_id.link_id.type &&
 				assignment.ep_id.ep_type == ep_id.ep_type) {
-			stream_idx = i;
-			break;
+			link_enc = link->dc->res_pool->link_encoders[assignment.eng_id - ENGINE_ID_DIGA];
 		}
 	}
 
-	if (stream_idx != -1)
-		link_enc = state->streams[stream_idx]->link_enc;
-
 	return link_enc;
 }
 
@@ -313,3 +307,14 @@ struct link_encoder *link_enc_cfg_get_next_avail_link_enc(
 
 	return link_enc;
 }
+
+struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream(
+		struct dc_state *state,
+		const struct dc_stream_state *stream)
+{
+	struct link_encoder *link_enc;
+
+	link_enc = link_enc_cfg_get_link_enc_used_by_link(state, stream->link);
+
+	return link_enc;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index b9570b7c557b..dae0ab761b61 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -452,9 +452,10 @@ void dp_retrain_link_dp_test(struct dc_link *link,
 			if ((&pipes[i])->stream_res.audio && !link->dc->debug.az_endpoint_mute_only)
 				(&pipes[i])->stream_res.audio->funcs->az_disable((&pipes[i])->stream_res.audio);
 
-			link->link_enc->funcs->disable_output(
-					link->link_enc,
-					SIGNAL_TYPE_DISPLAY_PORT);
+			if (link->link_enc)
+				link->link_enc->funcs->disable_output(
+						link->link_enc,
+						SIGNAL_TYPE_DISPLAY_PORT);
 
 			/* Clear current link setting. */
 			memset(&link->cur_link_settings, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 57420bf10786..8766b124d4b0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2970,7 +2970,8 @@ enum dc_status dc_validate_stream(struct dc *dc, struct dc_stream_state *stream)
 		res = DC_FAIL_CONTROLLER_VALIDATE;
 
 	if (res == DC_OK) {
-		if (!link->link_enc->funcs->validate_output_with_stream(
+		if (link->ep_type == DISPLAY_ENDPOINT_PHY &&
+				!link->link_enc->funcs->validate_output_with_stream(
 						link->link_enc, stream))
 			res = DC_FAIL_ENC_VALIDATE;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 2ce668a23fe8..102f76462752 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -46,6 +46,7 @@
 #include "transform.h"
 #include "stream_encoder.h"
 #include "link_encoder.h"
+#include "link_enc_cfg.h"
 #include "link_hwss.h"
 #include "dc_link_dp.h"
 #if defined(CONFIG_DRM_AMD_DC_DCN)
@@ -1192,6 +1193,7 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	struct link_encoder *link_enc = NULL;
 
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal)) {
 		pipe_ctx->stream_res.stream_enc->funcs->stop_hdmi_info_packets(
@@ -1213,6 +1215,13 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 
 	dc->hwss.disable_audio_stream(pipe_ctx);
 
+	/* Link encoder may have been dynamically assigned to non-physical display endpoint. */
+	if (link->ep_type == DISPLAY_ENDPOINT_PHY)
+		link_enc = link->link_enc;
+	else if (dc->res_pool->funcs->link_encs_assign)
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+	ASSERT(link_enc);
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
 		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->disable(
@@ -1220,13 +1229,15 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		setup_dp_hpo_stream(pipe_ctx, false);
 	/* TODO - DP2.0 HW: unmap stream from link encoder here */
 	} else {
-		link->link_enc->funcs->connect_dig_be_to_fe(
-				link->link_enc,
+		if (link_enc)
+			link_enc->funcs->connect_dig_be_to_fe(
+				link_enc,
 				pipe_ctx->stream_res.stream_enc->id,
 				false);
 	}
 #else
-	link->link_enc->funcs->connect_dig_be_to_fe(
+	if (link_enc)
+		link_enc->funcs->connect_dig_be_to_fe(
 			link->link_enc,
 			pipe_ctx->stream_res.stream_enc->id,
 			false);
@@ -1666,8 +1677,9 @@ static void power_down_encoders(struct dc *dc)
 		if (signal != SIGNAL_TYPE_EDP)
 			signal = SIGNAL_TYPE_NONE;
 
-		dc->links[i]->link_enc->funcs->disable_output(
-				dc->links[i]->link_enc, signal);
+		if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY)
+			dc->links[i]->link_enc->funcs->disable_output(
+					dc->links[i]->link_enc, signal);
 
 		dc->links[i]->link_status.link_active = false;
 		memset(&dc->links[i]->cur_link_settings, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 7daadb6a5233..f37551e00023 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1296,7 +1296,7 @@ struct stream_encoder *dcn10_find_first_free_match_stream_enc_for_link(
 			 * in daisy chain use case
 			 */
 			j = i;
-			if (pool->stream_enc[i]->id ==
+			if (link->ep_type == DISPLAY_ENDPOINT_PHY && pool->stream_enc[i]->id ==
 					link->link_enc->preferred_engine)
 				return pool->stream_enc[i];
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index ffc0b9ab976f..c0aed7d07eeb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2381,6 +2381,13 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	uint32_t active_total_with_borders;
 	uint32_t early_control = 0;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+	struct link_encoder *link_enc;
+
+	if (link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign)
+		link_enc = pipe_ctx->stream->link_enc;
+	else
+		link_enc = link->link_enc;
 
 	/* For MST, there are multiply stream go to only one link.
 	 * connect DIG back_end to front_end while enable_stream and
@@ -2397,9 +2404,9 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 				link->hpo_dp_link_enc->inst);
 	}
 
-	if (!is_dp_128b_132b_signal(pipe_ctx))
-		link->link_enc->funcs->connect_dig_be_to_fe(
-			link->link_enc, pipe_ctx->stream_res.stream_enc->id, true);
+	if (!is_dp_128b_132b_signal(pipe_ctx) && link_enc)
+		link_enc->funcs->connect_dig_be_to_fe(
+			link_enc, pipe_ctx->stream_res.stream_enc->id, true);
 
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 7bab88356df4..e69f553d680f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -87,6 +87,7 @@
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
 #include "vm_helper.h"
+#include "link_enc_cfg.h"
 
 #include "amdgpu_socbb.h"
 
@@ -1596,12 +1597,29 @@ static void get_pixel_clock_parameters(
 	const struct dc_stream_state *stream = pipe_ctx->stream;
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
+	struct dc_link *link = stream->link;
+	struct link_encoder *link_enc = NULL;
 
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 		opp_cnt++;
 
 	pixel_clk_params->requested_pix_clk_100hz = stream->timing.pix_clk_100hz;
-	pixel_clk_params->encoder_object_id = stream->link->link_enc->id;
+
+	/* Links supporting dynamically assigned link encoder will be assigned next
+	 * available encoder if one not already assigned.
+	 */
+	if (link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign) {
+		link_enc = link_enc_cfg_get_link_enc_used_by_stream(stream->link->dc->current_state, stream);
+		if (link_enc == NULL)
+			link_enc = link_enc_cfg_get_next_avail_link_enc(stream->link->dc,
+				stream->link->dc->current_state);
+	} else
+		link_enc = stream->link->link_enc;
+	ASSERT(link_enc);
+
+	if (link_enc)
+		pixel_clk_params->encoder_object_id = link_enc->id;
 	pixel_clk_params->signal_type = pipe_ctx->stream->signal;
 	pixel_clk_params->controller_id = pipe_ctx->stream_res.tg->inst + 1;
 	/* TODO: un-hardcode*/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 2434232fb3f5..83f223d745fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -157,6 +157,9 @@ void dcn31_init_hw(struct dc *dc)
 		 */
 		struct dc_link *link = dc->links[i];
 
+		if (link->ep_type != DISPLAY_ENDPOINT_PHY)
+			continue;
+
 		link->link_enc->funcs->hw_init(link->link_enc);
 
 		/* Check for enabled DIG to identify enabled display */
@@ -184,7 +187,8 @@ void dcn31_init_hw(struct dc *dc)
 						     &dpcd_power_state, sizeof(dpcd_power_state));
 			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
 				/* blank dp stream before power off receiver*/
-				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
+				if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY &&
+						dc->links[i]->link_enc->funcs->get_dig_frontend) {
 					unsigned int fe;
 
 					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
@@ -248,7 +252,8 @@ void dcn31_init_hw(struct dc *dc)
 			for (i = 0; i < dc->link_count; i++) {
 				struct dc_link *link = dc->links[i];
 
-				if (link->link_enc->funcs->is_dig_enabled &&
+				if (link->ep_type == DISPLAY_ENDPOINT_PHY &&
+						link->link_enc->funcs->is_dig_enabled &&
 						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
 						dc->hwss.power_down) {
 					dc->hwss.power_down(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
index 883dd8733ea4..2472c9aed095 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -88,4 +88,9 @@ struct link_encoder *link_enc_cfg_get_next_avail_link_enc(
 	const struct dc *dc,
 	const struct dc_state *state);
 
+/* Return DIG link encoder used by stream. NULL if unused. */
+struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream(
+		struct dc_state *state,
+		const struct dc_stream_state *stream);
+
 #endif /* DC_INC_LINK_ENC_CFG_H_ */
-- 
2.25.1


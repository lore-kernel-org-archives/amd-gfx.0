Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B397C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3668E60F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3668E60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A006EE7B;
	Fri, 17 Sep 2021 19:25:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B82D46EE7A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLPBSWBivDq8r1gLTHMY4Ry5u78K9Ah0ngA/SUWPw4tc0bwDhbPsK9KcMwaQtXwBhvSH6IJPCTThW+Hlf5UO/DJ4aVuIoq/M6HY5qUHTwrkxAnFpThv9+Oimaz8qT2LgEgoRk6fnDcztpvnjA8K1Tj5VUohJmIUZppcNBihgthlwZWqONvSRts6TIatNOK2OhzZOLxD8sTnKFiBGh1UB+Xwi4tOyQrPqmyuUT35OIn6gEoqah5GdWDgcqiZfThBgilnQaX7F5Kgnfjq4D6Ls2AIf+AlrUn1Vr0gGb/C8hXur/tGLz3vWIeZW1/BHMlvEhy2VScEGGJjfsZuB1P00+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=HlD6oZ0FHra9umC7NPanV3iU39qw0sNTJpnn1li9bnM=;
 b=UA5C2ExW8vmXM5DXsLSXDfk3wsvdQIxDwN3zE2HxeumiMzoLijaSord0+yIQ+hmMmSYluTeF+AXnPdmTqBHNeotKzZnG1OtiLKkH814T0bg+kYj5ZzmmOOw2u9n7LQ2NZdaqmfFKvC8dZJZw6eetzglVTXjK36cAV1ukGGgsLWfQqdKoBEzgk8ROykQzGXhTryUmKttVhd3P+nz2DGISUGCwZnUKn9kqhqhiu3LUGiJLTax3JO7Sf7pTK9Tte/54wzSZ21A/9OmEiwhX4BATbmMWm+r1qrHme7UreOdrO6+CIJLoUC+gn4r8T6fHoUvS8Nk7OQ0/JyW+sgC5fw2Pew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlD6oZ0FHra9umC7NPanV3iU39qw0sNTJpnn1li9bnM=;
 b=ieQfj/gO/ka+EPxpvYVxr1IfixlGxBDSDK5xya9RkH531gxgMbKjKjfIzSWPEpXi9fVzFTtcey4y9e6oJZheDybp9mJSrho/dbyLmlwOTKMBmz3zwI4pPOY+ElqFAn/j6chB1DtA1CH44cxONoip8gqNsrTDTQmXnTZa1I/dekM=
Received: from BN9PR03CA0916.namprd03.prod.outlook.com (2603:10b6:408:107::21)
 by BYAPR12MB3141.namprd12.prod.outlook.com (2603:10b6:a03:da::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:25:53 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::f8) by BN9PR03CA0916.outlook.office365.com
 (2603:10b6:408:107::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:53 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 07/18] drm/amd/display: Fix dynamic encoder reassignment
Date: Fri, 17 Sep 2021 15:25:13 -0400
Message-ID: <20210917192524.3020276-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 808f3956-388a-44a1-41f7-08d97a10f722
X-MS-TrafficTypeDiagnostic: BYAPR12MB3141:
X-Microsoft-Antispam-PRVS: <BYAPR12MB31410185D3CA607134396C2D98DD9@BYAPR12MB3141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpGc6oke2MRKR0SyW4wNOVPaZhi9NY1qrLWZsZ5QfGeXpCJW+FdtC68uTiS5n796jqyiHPBxde0wVhuhtaMcNteJ/UpuaYvZAz1mj2mbDuJ+Bs6+qHwqSuigbA+HagrrVDDYpWNRWyHpE2V7JYH+jBEc+LduKdQr5yjDuYoe3DTcOxr+F9pNIpmxZiZriSXt37xpb/qW/sosw7TlUKbGliuW2k/MlQXFX8zuRa3Zfg8W8C2+1xcbZKShkUwbBu8/ivQavFoTC74vLRvY9oQBck8Bnecw6P36deCrkKOAErnJW73a5DGeOr80fI4nD1Vqfz3TafITh7tGNJnyfQt2wd7mFol7fz3BBhj+55s3Ts95uP/g2MiPVHldM4Nsb7jpHxiGu+iA6XXDnGdeVAwHSzJgDiePgmwN+euUizrSEM5Ek8FC1XznlGQpdWxjBYZbLqxpGyTujbRLbEx9/JisEWFP9oE63+JGtCCOTtB+mMILZr9w38PQXghtST9DuOx67eXBU7NLtwXwSvP9yTyqro8tjvFqkiI1iNA/T2L9H/4aP2jTuU9IVb6L+7rz3VjBDYw+fhvpNjaqQ5frE5J94H85xp8QeMylhRqgpK7wgKJ4i3aVUnd2mkoOKHJIZKfRMInZqEQpxk4wOvrU/sblRTVJHVKBW64MP2RzxCSkK7eq1WWx/u51ou/U7V2J4SqhgmmCYWdr02OSLRne/SdaLlYajC4u9WLwG89qFBNoTnw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(316002)(70586007)(6916009)(4326008)(82310400003)(81166007)(508600001)(6666004)(8936002)(70206006)(86362001)(47076005)(36756003)(2906002)(336012)(2616005)(426003)(186003)(16526019)(83380400001)(5660300002)(30864003)(36860700001)(54906003)(356005)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:53.3469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 808f3956-388a-44a1-41f7-08d97a10f722
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3141
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
Incorrect encoder assignments were being used while applying a new state
to hardware.

(1) When committing a new state to hardware requires resetting the
back-end, the encoder assignments of the current or old state should be
used when disabling the back-end; and the encoder assignments for the
next or new state should be used when re-enabling the back-end.

(2) Link training on hot plug could take over an encoder already in use
by another stream without first disabling it.

[How]

(1) Introduce a resource context 'link_enc_cfg_context' which includes:
- a mode to indicate when transitioning from current to next state.
- transient encoder assignments to use during this state transition.

Update the encoder configuration interface to respond to queries about
encoder assignment based on the mode of operation.

(2) Check if an encoder is already in use before attempting to perform
link training on hot plug.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  13 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  27 +--
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 178 +++++++++++++-----
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   6 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  15 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   5 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |   6 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   4 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  18 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   5 +
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  20 +-
 13 files changed, 215 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 222509557672..4ec3de34bd67 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3490,11 +3490,8 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 			link_enc = pipe_ctx->stream->link->link_enc;
 			config.phy_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 		} else if (pipe_ctx->stream->link->dc->res_pool->funcs->link_encs_assign) {
-			/* Use link encoder assignment from current DC state - which may differ from the DC state to be
-			 * committed - when updating PSP config.
-			 */
 			link_enc = link_enc_cfg_get_link_enc_used_by_stream(
-					pipe_ctx->stream->link->dc->current_state,
+					pipe_ctx->stream->ctx->dc,
 					pipe_ctx->stream);
 			config.phy_idx = 0; /* Clear phy_idx for non-physical display endpoints. */
 		}
@@ -3619,7 +3616,7 @@ void core_link_enable_stream(
 		return;
 
 	if (dc->res_pool->funcs->link_encs_assign && stream->link->ep_type != DISPLAY_ENDPOINT_PHY)
-		link_enc = stream->link_enc;
+		link_enc = link_enc_cfg_get_link_enc_used_by_stream(dc, stream);
 	else
 		link_enc = stream->link->link_enc;
 	ASSERT(link_enc);
@@ -4216,14 +4213,14 @@ bool dc_link_is_fec_supported(const struct dc_link *link)
 	 */
 	if (link->is_dig_mapping_flexible &&
 			link->dc->res_pool->funcs->link_encs_assign) {
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
 		if (link_enc == NULL)
-			link_enc = link_enc_cfg_get_next_avail_link_enc(link->dc, link->dc->current_state);
+			link_enc = link_enc_cfg_get_next_avail_link_enc(link->ctx->dc);
 	} else
 		link_enc = link->link_enc;
 	ASSERT(link_enc);
 
-	return (dc_is_dp_signal(link->connector_signal) &&
+	return (dc_is_dp_signal(link->connector_signal) && link_enc &&
 			link_enc->features.fec_supported &&
 			link->dpcd_caps.fec_cap.bits.FEC_CAPABLE &&
 			!IS_FPGA_MAXIMUS_DC(link->ctx->dce_environment));
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 920ae2b0b165..938bfd8761d1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -282,7 +282,7 @@ static enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *li
 	 */
 	if (link->is_dig_mapping_flexible &&
 			link->dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
 	else
 		link_enc = link->link_enc;
 	ASSERT(link_enc);
@@ -317,7 +317,7 @@ static enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *li
 	 */
 	if (link->is_dig_mapping_flexible &&
 			link->dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
 	else
 		link_enc = link->link_enc;
 	ASSERT(link_enc);
@@ -2363,7 +2363,7 @@ bool perform_link_training_with_retries(
 	 * link.
 	 */
 	if (link->is_dig_mapping_flexible && link->dc->res_pool->funcs->link_encs_assign)
-		link_enc = stream->link_enc;
+		link_enc = link_enc_cfg_get_link_enc_used_by_stream(link->ctx->dc, pipe_ctx->stream);
 	else
 		link_enc = link->link_enc;
 
@@ -2645,9 +2645,9 @@ bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_
 	 */
 	if (link->is_dig_mapping_flexible &&
 			link->dc->res_pool->funcs->link_encs_assign) {
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
 		if (link_enc == NULL)
-			link_enc = link_enc_cfg_get_next_avail_link_enc(link->dc, link->dc->current_state);
+			link_enc = link_enc_cfg_get_next_avail_link_enc(link->ctx->dc);
 	} else
 		link_enc = link->link_enc;
 	ASSERT(link_enc);
@@ -2676,9 +2676,9 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 	 */
 	if (link->is_dig_mapping_flexible &&
 			link->dc->res_pool->funcs->link_encs_assign) {
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
 		if (link_enc == NULL)
-			link_enc = link_enc_cfg_get_next_avail_link_enc(link->dc, link->dc->current_state);
+			link_enc = link_enc_cfg_get_next_avail_link_enc(link->ctx->dc);
 	} else
 		link_enc = link->link_enc;
 	ASSERT(link_enc);
@@ -2860,7 +2860,13 @@ bool dp_verify_link_cap(
 	enum link_training_result status;
 	union hpd_irq_data irq_data;
 
-	if (link->dc->debug.skip_detection_link_training) {
+	/* Accept reported capabilities if link supports flexible encoder mapping or encoder already in use. */
+	if (link->dc->debug.skip_detection_link_training ||
+			link->is_dig_mapping_flexible) {
+		link->verified_link_cap = *known_limit_link_setting;
+		return true;
+	} else if (link->link_enc && link->dc->res_pool->funcs->link_encs_assign &&
+			!link_enc_cfg_is_link_enc_avail(link->ctx->dc, link->link_enc->preferred_engine)) {
 		link->verified_link_cap = *known_limit_link_setting;
 		return true;
 	}
@@ -5658,7 +5664,7 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, bool ready)
 	 */
 	if (link->is_dig_mapping_flexible &&
 			link->dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
 	else
 		link_enc = link->link_enc;
 	ASSERT(link_enc);
@@ -5705,8 +5711,7 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 	 */
 	if (link->is_dig_mapping_flexible &&
 			link->dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(
-				link->dc->current_state, link);
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
 	else
 		link_enc = link->link_enc;
 	ASSERT(link_enc);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 5536184fff46..4dce25c39b75 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -63,6 +63,18 @@ static bool is_dig_link_enc_stream(struct dc_stream_state *stream)
 	return is_dig_stream;
 }
 
+static struct link_enc_assignment get_assignment(struct dc *dc, int i)
+{
+	struct link_enc_assignment assignment;
+
+	if (dc->current_state->res_ctx.link_enc_cfg_ctx.mode == LINK_ENC_CFG_TRANSIENT)
+		assignment = dc->current_state->res_ctx.link_enc_cfg_ctx.transient_assignments[i];
+	else /* LINK_ENC_CFG_STEADY */
+		assignment = dc->current_state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
+
+	return assignment;
+}
+
 /* Return stream using DIG link encoder resource. NULL if unused. */
 static struct dc_stream_state *get_stream_using_link_enc(
 		struct dc_state *state,
@@ -72,7 +84,7 @@ static struct dc_stream_state *get_stream_using_link_enc(
 	int i;
 
 	for (i = 0; i < state->stream_count; i++) {
-		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
 
 		if ((assignment.valid == true) && (assignment.eng_id == eng_id)) {
 			stream = state->streams[i];
@@ -98,15 +110,15 @@ static void remove_link_enc_assignment(
 		 * link_enc_assignments table.
 		 */
 		for (i = 0; i < MAX_PIPES; i++) {
-			struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+			struct link_enc_assignment assignment = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
 
 			if (assignment.valid && assignment.stream == stream) {
-				state->res_ctx.link_enc_assignments[i].valid = false;
+				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].valid = false;
 				/* Only add link encoder back to availability pool if not being
 				 * used by any other stream (i.e. removing SST stream or last MST stream).
 				 */
 				if (get_stream_using_link_enc(state, eng_id) == NULL)
-					state->res_ctx.link_enc_avail[eng_idx] = eng_id;
+					state->res_ctx.link_enc_cfg_ctx.link_enc_avail[eng_idx] = eng_id;
 				stream->link_enc = NULL;
 				break;
 			}
@@ -130,14 +142,14 @@ static void add_link_enc_assignment(
 		 */
 		for (i = 0; i < state->stream_count; i++) {
 			if (stream == state->streams[i]) {
-				state->res_ctx.link_enc_assignments[i] = (struct link_enc_assignment){
+				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i] = (struct link_enc_assignment){
 					.valid = true,
 					.ep_id = (struct display_endpoint_id) {
 						.link_id = stream->link->link_id,
 						.ep_type = stream->link->ep_type},
 					.eng_id = eng_id,
 					.stream = stream};
-				state->res_ctx.link_enc_avail[eng_idx] = ENGINE_ID_UNKNOWN;
+				state->res_ctx.link_enc_cfg_ctx.link_enc_avail[eng_idx] = ENGINE_ID_UNKNOWN;
 				stream->link_enc = stream->ctx->dc->res_pool->link_encoders[eng_idx];
 				break;
 			}
@@ -157,7 +169,7 @@ static enum engine_id find_first_avail_link_enc(
 	int i;
 
 	for (i = 0; i < ctx->dc->res_pool->res_cap->num_dig_link_enc; i++) {
-		eng_id = state->res_ctx.link_enc_avail[i];
+		eng_id = state->res_ctx.link_enc_cfg_ctx.link_enc_avail[i];
 		if (eng_id != ENGINE_ID_UNKNOWN)
 			break;
 	}
@@ -170,7 +182,7 @@ static bool is_avail_link_enc(struct dc_state *state, enum engine_id eng_id)
 	bool is_avail = false;
 	int eng_idx = eng_id - ENGINE_ID_DIGA;
 
-	if (eng_id != ENGINE_ID_UNKNOWN && state->res_ctx.link_enc_avail[eng_idx] != ENGINE_ID_UNKNOWN)
+	if (eng_id != ENGINE_ID_UNKNOWN && state->res_ctx.link_enc_cfg_ctx.link_enc_avail[eng_idx] != ENGINE_ID_UNKNOWN)
 		is_avail = true;
 
 	return is_avail;
@@ -190,6 +202,28 @@ static bool are_ep_ids_equal(struct display_endpoint_id *lhs, struct display_end
 	return are_equal;
 }
 
+static struct link_encoder *get_link_enc_used_by_link(
+		struct dc_state *state,
+		const struct dc_link *link)
+{
+	struct link_encoder *link_enc = NULL;
+	struct display_endpoint_id ep_id;
+	int i;
+
+	ep_id = (struct display_endpoint_id) {
+		.link_id = link->link_id,
+		.ep_type = link->ep_type};
+
+	for (i = 0; i < state->stream_count; i++) {
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
+
+		if (assignment.valid == true && are_ep_ids_equal(&assignment.ep_id, &ep_id))
+			link_enc = link->dc->res_pool->link_encoders[assignment.eng_id - ENGINE_ID_DIGA];
+	}
+
+	return link_enc;
+}
+
 void link_enc_cfg_init(
 		struct dc *dc,
 		struct dc_state *state)
@@ -198,10 +232,12 @@ void link_enc_cfg_init(
 
 	for (i = 0; i < dc->res_pool->res_cap->num_dig_link_enc; i++) {
 		if (dc->res_pool->link_encoders[i])
-			state->res_ctx.link_enc_avail[i] = (enum engine_id) i;
+			state->res_ctx.link_enc_cfg_ctx.link_enc_avail[i] = (enum engine_id) i;
 		else
-			state->res_ctx.link_enc_avail[i] = ENGINE_ID_UNKNOWN;
+			state->res_ctx.link_enc_cfg_ctx.link_enc_avail[i] = ENGINE_ID_UNKNOWN;
 	}
+
+	state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_STEADY;
 }
 
 void link_enc_cfg_link_encs_assign(
@@ -221,7 +257,7 @@ void link_enc_cfg_link_encs_assign(
 		dc->res_pool->funcs->link_enc_unassign(state, streams[i]);
 
 	for (i = 0; i < MAX_PIPES; i++)
-		ASSERT(state->res_ctx.link_enc_assignments[i].valid == false);
+		ASSERT(state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].valid == false);
 
 	/* (a) Assign DIG link encoders to physical (unmappable) endpoints first. */
 	for (i = 0; i < stream_count; i++) {
@@ -258,8 +294,8 @@ void link_enc_cfg_link_encs_assign(
 				struct dc_stream_state *prev_stream = prev_state->streams[j];
 
 				if (stream == prev_stream && stream->link == prev_stream->link &&
-						prev_state->res_ctx.link_enc_assignments[j].valid) {
-					eng_id = prev_state->res_ctx.link_enc_assignments[j].eng_id;
+						prev_state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[j].valid) {
+					eng_id = prev_state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[j].eng_id;
 					if (is_avail_link_enc(state, eng_id))
 						add_link_enc_assignment(state, stream, eng_id);
 				}
@@ -291,7 +327,7 @@ void link_enc_cfg_link_encs_assign(
 			 * endpoint. These streams should use the same link encoder
 			 * assigned to that endpoint.
 			 */
-			link_enc = link_enc_cfg_get_link_enc_used_by_link(state, stream->link);
+			link_enc = get_link_enc_used_by_link(state, stream->link);
 			if (link_enc == NULL)
 				eng_id = find_first_avail_link_enc(stream->ctx, state);
 			else
@@ -301,6 +337,15 @@ void link_enc_cfg_link_encs_assign(
 	}
 
 	link_enc_cfg_validate(dc, state);
+
+	/* Update transient assignments. */
+	for (i = 0; i < MAX_PIPES; i++) {
+		dc->current_state->res_ctx.link_enc_cfg_ctx.transient_assignments[i] =
+			state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
+	}
+
+	/* Current state mode will be set to steady once this state committed. */
+	state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_STEADY;
 }
 
 void link_enc_cfg_link_enc_unassign(
@@ -320,12 +365,12 @@ void link_enc_cfg_link_enc_unassign(
 }
 
 bool link_enc_cfg_is_transmitter_mappable(
-		struct dc_state *state,
+		struct dc *dc,
 		struct link_encoder *link_enc)
 {
 	bool is_mappable = false;
 	enum engine_id eng_id = link_enc->preferred_engine;
-	struct dc_stream_state *stream = get_stream_using_link_enc(state, eng_id);
+	struct dc_stream_state *stream = link_enc_cfg_get_stream_using_link_enc(dc, eng_id);
 
 	if (stream)
 		is_mappable = stream->link->is_dig_mapping_flexible;
@@ -333,30 +378,43 @@ bool link_enc_cfg_is_transmitter_mappable(
 	return is_mappable;
 }
 
-struct dc_link *link_enc_cfg_get_link_using_link_enc(
-		struct dc_state *state,
+struct dc_stream_state *link_enc_cfg_get_stream_using_link_enc(
+		struct dc *dc,
 		enum engine_id eng_id)
 {
-	struct dc_link *link = NULL;
+	struct dc_stream_state *stream = NULL;
 	int i;
 
-	for (i = 0; i < state->stream_count; i++) {
-		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct link_enc_assignment assignment = get_assignment(dc, i);
 
 		if ((assignment.valid == true) && (assignment.eng_id == eng_id)) {
-			link = state->streams[i]->link;
+			stream = assignment.stream;
 			break;
 		}
 	}
 
-	if (link == NULL)
-		dm_output_to_console("%s: No link using DIG(%d).\n", __func__, eng_id);
+	return stream;
+}
 
+struct dc_link *link_enc_cfg_get_link_using_link_enc(
+		struct dc *dc,
+		enum engine_id eng_id)
+{
+	struct dc_link *link = NULL;
+	struct dc_stream_state *stream = NULL;
+
+	stream = link_enc_cfg_get_stream_using_link_enc(dc, eng_id);
+
+	if (stream)
+		link = stream->link;
+
+	// dm_output_to_console("%s: No link using DIG(%d).\n", __func__, eng_id);
 	return link;
 }
 
 struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
-		struct dc_state *state,
+		struct dc *dc,
 		const struct dc_link *link)
 {
 	struct link_encoder *link_enc = NULL;
@@ -367,41 +425,74 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
 		.link_id = link->link_id,
 		.ep_type = link->ep_type};
 
-	for (i = 0; i < state->stream_count; i++) {
-		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct link_enc_assignment assignment = get_assignment(dc, i);
 
-		if (assignment.valid == true && are_ep_ids_equal(&assignment.ep_id, &ep_id))
+		if (assignment.valid == true && are_ep_ids_equal(&assignment.ep_id, &ep_id)) {
 			link_enc = link->dc->res_pool->link_encoders[assignment.eng_id - ENGINE_ID_DIGA];
+			break;
+		}
 	}
 
 	return link_enc;
 }
 
-struct link_encoder *link_enc_cfg_get_next_avail_link_enc(
-	const struct dc *dc,
-	const struct dc_state *state)
+struct link_encoder *link_enc_cfg_get_next_avail_link_enc(struct dc *dc)
 {
 	struct link_encoder *link_enc = NULL;
-	enum engine_id eng_id;
+	enum engine_id encs_assigned[MAX_DIG_LINK_ENCODERS];
+	int i;
+
+	for (i = 0; i < MAX_DIG_LINK_ENCODERS; i++)
+		encs_assigned[i] = ENGINE_ID_UNKNOWN;
 
-	eng_id = find_first_avail_link_enc(dc->ctx, state);
-	if (eng_id != ENGINE_ID_UNKNOWN)
-		link_enc = dc->res_pool->link_encoders[eng_id - ENGINE_ID_DIGA];
+	/* Add assigned encoders to list. */
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct link_enc_assignment assignment = get_assignment(dc, i);
+
+		if (assignment.valid)
+			encs_assigned[assignment.eng_id - ENGINE_ID_DIGA] = assignment.eng_id;
+	}
+
+	for (i = 0; i < dc->res_pool->res_cap->num_dig_link_enc; i++) {
+		if (encs_assigned[i] == ENGINE_ID_UNKNOWN) {
+			link_enc = dc->res_pool->link_encoders[i];
+			break;
+		}
+	}
 
 	return link_enc;
 }
 
 struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream(
-		struct dc_state *state,
+		struct dc *dc,
 		const struct dc_stream_state *stream)
 {
 	struct link_encoder *link_enc;
 
-	link_enc = link_enc_cfg_get_link_enc_used_by_link(state, stream->link);
+	link_enc = link_enc_cfg_get_link_enc_used_by_link(dc, stream->link);
 
 	return link_enc;
 }
 
+bool link_enc_cfg_is_link_enc_avail(struct dc *dc, enum engine_id eng_id)
+{
+	bool is_avail = true;
+	int i;
+
+	/* Add assigned encoders to list. */
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct link_enc_assignment assignment = get_assignment(dc, i);
+
+		if (assignment.valid && assignment.eng_id == eng_id) {
+			is_avail = false;
+			break;
+		}
+	}
+
+	return is_avail;
+}
+
 bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 {
 	bool is_valid = false;
@@ -418,7 +509,7 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 
 	/* (1) No. valid entries same as stream count. */
 	for (i = 0; i < MAX_PIPES; i++) {
-		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
 
 		if (assignment.valid)
 			valid_count++;
@@ -431,7 +522,7 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 
 	/* (2) Matching stream ptrs. */
 	for (i = 0; i < MAX_PIPES; i++) {
-		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
 
 		if (assignment.valid) {
 			if (assignment.stream == state->streams[i])
@@ -443,14 +534,15 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 
 	/* (3) Each endpoint assigned unique encoder. */
 	for (i = 0; i < MAX_PIPES; i++) {
-		struct link_enc_assignment assignment_i = state->res_ctx.link_enc_assignments[i];
+		struct link_enc_assignment assignment_i = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
 
 		if (assignment_i.valid) {
 			struct display_endpoint_id ep_id_i = assignment_i.ep_id;
 
 			eng_ids_per_ep_id[i]++;
 			for (j = 0; j < MAX_PIPES; j++) {
-				struct link_enc_assignment assignment_j = state->res_ctx.link_enc_assignments[j];
+				struct link_enc_assignment assignment_j =
+					state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[j];
 
 				if (j == i)
 					continue;
@@ -470,11 +562,11 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 
 	/* (4) Assigned encoders not in available pool. */
 	for (i = 0; i < MAX_PIPES; i++) {
-		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
 
 		if (assignment.valid) {
 			for (j = 0; j < dc->res_pool->res_cap->num_dig_link_enc; j++) {
-				if (state->res_ctx.link_enc_avail[j] == assignment.eng_id) {
+				if (state->res_ctx.link_enc_cfg_ctx.link_enc_avail[j] == assignment.eng_id) {
 					valid_avail = false;
 					break;
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index dae0ab761b61..64f76f57c85d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -87,7 +87,7 @@ void dp_enable_link_phy(
 
 	/* Link should always be assigned encoder when en-/disabling. */
 	if (link->is_dig_mapping_flexible && dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(dc, link);
 	else
 		link_enc = link->link_enc;
 	ASSERT(link_enc);
@@ -247,7 +247,7 @@ void dp_disable_link_phy(struct dc_link *link, enum signal_type signal)
 
 	/* Link should always be assigned encoder when en-/disabling. */
 	if (link->is_dig_mapping_flexible && dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(dc, link);
 	else
 		link_enc = link->link_enc;
 	ASSERT(link_enc);
@@ -391,7 +391,7 @@ void dp_set_hw_test_pattern(
 	 */
 	if (link->is_dig_mapping_flexible &&
 			link->dc->res_pool->funcs->link_encs_assign)
-		encoder = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		encoder = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
 	else
 		encoder = link->link_enc;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b4e986f736ad..adc656fc4848 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -41,6 +41,7 @@
 #include "set_mode_types.h"
 #include "virtual/virtual_stream_encoder.h"
 #include "dpcd_defs.h"
+#include "link_enc_cfg.h"
 #include "dc_link_dp.h"
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
@@ -2826,8 +2827,18 @@ bool pipe_need_reprogram(
 #endif
 
 	/* DIG link encoder resource assignment for stream changed. */
-	if (pipe_ctx_old->stream->link_enc != pipe_ctx->stream->link_enc)
-		return true;
+	if (pipe_ctx_old->stream->ctx->dc->res_pool->funcs->link_encs_assign) {
+		bool need_reprogram = false;
+		struct dc *dc = pipe_ctx_old->stream->ctx->dc;
+		enum link_enc_cfg_mode mode = dc->current_state->res_ctx.link_enc_cfg_ctx.mode;
+
+		dc->current_state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_STEADY;
+		if (link_enc_cfg_get_link_enc_used_by_stream(dc, pipe_ctx_old->stream) != pipe_ctx->stream->link_enc)
+			need_reprogram = true;
+		dc->current_state->res_ctx.link_enc_cfg_ctx.mode = mode;
+
+		return need_reprogram;
+	}
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 102f76462752..af3e68d3e747 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1219,7 +1219,7 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	if (link->ep_type == DISPLAY_ENDPOINT_PHY)
 		link_enc = link->link_enc;
 	else if (dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
 	ASSERT(link_enc);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index c0aed7d07eeb..fc83744149d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -54,6 +54,7 @@
 #include "hw_sequencer.h"
 #include "inc/link_dpcd.h"
 #include "dpcd_defs.h"
+#include "inc/link_enc_cfg.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -2385,9 +2386,10 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 
 	if (link->is_dig_mapping_flexible &&
 			link->dc->res_pool->funcs->link_encs_assign)
-		link_enc = pipe_ctx->stream->link_enc;
+		link_enc = link_enc_cfg_get_link_enc_used_by_stream(link->ctx->dc, pipe_ctx->stream);
 	else
 		link_enc = link->link_enc;
+	ASSERT(link_enc);
 
 	/* For MST, there are multiply stream go to only one link.
 	 * connect DIG back_end to front_end while enable_stream and
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e69f553d680f..cb49375d83c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1610,10 +1610,9 @@ static void get_pixel_clock_parameters(
 	 */
 	if (link->is_dig_mapping_flexible &&
 			link->dc->res_pool->funcs->link_encs_assign) {
-		link_enc = link_enc_cfg_get_link_enc_used_by_stream(stream->link->dc->current_state, stream);
+		link_enc = link_enc_cfg_get_link_enc_used_by_stream(stream->ctx->dc, stream);
 		if (link_enc == NULL)
-			link_enc = link_enc_cfg_get_next_avail_link_enc(stream->link->dc,
-				stream->link->dc->current_state);
+			link_enc = link_enc_cfg_get_next_avail_link_enc(stream->ctx->dc);
 	} else
 		link_enc = stream->link->link_enc;
 	ASSERT(link_enc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 77b81f6c24b9..03f0290d41f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -367,7 +367,7 @@ void dcn31_link_encoder_enable_dp_output(
 	enum clock_source_id clock_source)
 {
 	/* Enable transmitter and encoder. */
-	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
+	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
 
 		dcn20_link_encoder_enable_dp_output(enc, link_settings, clock_source);
 
@@ -383,7 +383,7 @@ void dcn31_link_encoder_enable_dp_mst_output(
 	enum clock_source_id clock_source)
 {
 	/* Enable transmitter and encoder. */
-	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
+	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
 
 		dcn10_link_encoder_enable_dp_mst_output(enc, link_settings, clock_source);
 
@@ -398,7 +398,7 @@ void dcn31_link_encoder_disable_output(
 	enum signal_type signal)
 {
 	/* Disable transmitter and encoder. */
-	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
+	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
 
 		dcn10_link_encoder_disable_output(enc, signal);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index d3598ce1f5de..0713910a3aa9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -48,6 +48,7 @@
 #include "dc_link_dp.h"
 #include "inc/link_dpcd.h"
 #include "dcn10/dcn10_hw_sequencer.h"
+#include "inc/link_enc_cfg.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -599,4 +600,7 @@ void dcn31_reset_hw_ctx_wrap(
 				old_clk->funcs->cs_power_down(old_clk);
 		}
 	}
+
+	/* New dc_state in the process of being applied to hardware. */
+	dc->current_state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_TRANSIENT;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index ed254c2771f0..8cff054db29f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -384,6 +384,17 @@ struct pipe_ctx {
 	bool vtp_locked;
 };
 
+/* Data used for dynamic link encoder assignment.
+ * Tracks current and future assignments; available link encoders;
+ * and mode of operation (whether to use current or future assignments).
+ */
+struct link_enc_cfg_context {
+	enum link_enc_cfg_mode mode;
+	struct link_enc_assignment link_enc_assignments[MAX_PIPES];
+	enum engine_id link_enc_avail[MAX_DIG_LINK_ENCODERS];
+	struct link_enc_assignment transient_assignments[MAX_PIPES];
+};
+
 struct resource_context {
 	struct pipe_ctx pipe_ctx[MAX_PIPES];
 	bool is_stream_enc_acquired[MAX_PIPES * 2];
@@ -391,12 +402,7 @@ struct resource_context {
 	uint8_t clock_source_ref_count[MAX_CLOCK_SOURCES];
 	uint8_t dp_clock_source_ref_count;
 	bool is_dsc_acquired[MAX_PIPES];
-	/* A table/array of encoder-to-link assignments. One entry per stream.
-	 * Indexed by stream index in dc_state.
-	 */
-	struct link_enc_assignment link_enc_assignments[MAX_PIPES];
-	/* List of available link encoders. Uses engine ID as encoder identifier. */
-	enum engine_id link_enc_avail[MAX_DIG_LINK_ENCODERS];
+	struct link_enc_cfg_context link_enc_cfg_ctx;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool is_hpo_dp_stream_enc_acquired[MAX_HPO_DP2_ENCODERS];
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 23af9640c544..bb0e91756ddd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -215,6 +215,11 @@ struct link_enc_assignment {
 	struct dc_stream_state *stream;
 };
 
+enum link_enc_cfg_mode {
+	LINK_ENC_CFG_STEADY, /* Normal operation - use current_state. */
+	LINK_ENC_CFG_TRANSIENT /* During commit state - use state to be committed. */
+};
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 enum dp2_link_mode {
 	DP2_LINK_TRAINING_TPS1,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
index 09f7c868feed..83b2199b2c83 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -70,29 +70,35 @@ void link_enc_cfg_link_enc_unassign(
  * endpoint.
  */
 bool link_enc_cfg_is_transmitter_mappable(
-		struct dc_state *state,
+		struct dc *dc,
 		struct link_encoder *link_enc);
 
+/* Return stream using DIG link encoder resource. NULL if unused. */
+struct dc_stream_state *link_enc_cfg_get_stream_using_link_enc(
+		struct dc *dc,
+		enum engine_id eng_id);
+
 /* Return link using DIG link encoder resource. NULL if unused. */
 struct dc_link *link_enc_cfg_get_link_using_link_enc(
-		struct dc_state *state,
+		struct dc *dc,
 		enum engine_id eng_id);
 
 /* Return DIG link encoder used by link. NULL if unused. */
 struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
-		struct dc_state *state,
+		struct dc *dc,
 		const struct dc_link *link);
 
 /* Return next available DIG link encoder. NULL if none available. */
-struct link_encoder *link_enc_cfg_get_next_avail_link_enc(
-	const struct dc *dc,
-	const struct dc_state *state);
+struct link_encoder *link_enc_cfg_get_next_avail_link_enc(struct dc *dc);
 
 /* Return DIG link encoder used by stream. NULL if unused. */
 struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream(
-		struct dc_state *state,
+		struct dc *dc,
 		const struct dc_stream_state *stream);
 
+/* Return true if encoder available to use. */
+bool link_enc_cfg_is_link_enc_avail(struct dc *dc, enum engine_id eng_id);
+
 /* Returns true if encoder assignments in supplied state pass validity checks. */
 bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state);
 
-- 
2.25.1


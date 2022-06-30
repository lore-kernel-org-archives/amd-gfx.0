Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE63ACCA47B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3336512A73E;
	Thu, 30 Jun 2022 19:14:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1BF88F0D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZgKCKWkVg/sDQVjbFhlhndOLruzxP4XzEbfBFh+Y+gtDZ3l1fRkkGFzCVv5dQdUiTHse+nydtN8EA/mezAi+ySeSnOC76BZPBXE7VE9kaquyCkcNZaCkW9U5a6XLPmPj/r3/Y+Zjm/RHY0zTFS/rZpEyOCh7CDWTKYvssujWrhJP2tp8FFEK3QYDIofpmMjEsliGnAt20SUHfknzZe9c2Mk0GUM6SydageDZkkddD+N8zQrCvSmszZMqC+QZWVUCH+50FL7t+IVAXMbUmVRu7eCkG2NLbdVYYutXB71kZedef8zOp2kX/zvaI7xh6fKHbtBsGwWrdEPNi8lh0O4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DPUKfES08uxA63rNs82LL1wD7PX53Y64neBkoeqay4=;
 b=VUJXknZprnSmrYtShxgB8FRZiO37bP9dkkOv8qxw1hmBJEW9umJFKZ0/wxLN/dw3sdLrFoLSYvUpDfHKo0Lutz4eax83P950OpuuYEbCjQNCmhBBIi4DagpDTuSq1EllnKSGMqA4WPG77lVRXHS97Z3Sw8IXkGp22mQA+MuYSt8WEu1u8HKznMlAzpmKlEU/9pT77S8e+3Hd9wbPJwUXtIr9Ty0nP511ttH7nGmVTyi/76HApX5UOCTEwlRB9Cb+nlZlCmPZQk8EX2C5wH4U335YOdHulBF599pfaNPWdMRGk5Qz7bNWDM9D0p+1VS79Iz+vnxCeXKdP7dPS9ziWyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DPUKfES08uxA63rNs82LL1wD7PX53Y64neBkoeqay4=;
 b=C7uIEHfd6i7tI2CeWt1o4U1Z8EwQb12QHKEd3qoo6FMK4ODOB2/cCd9ielVoyc/rJgcgpwiGAS/m24BarzhORN99OCnxDg8fH0b7iodmKPXuxIqlQATQxc2T67G0ZxZJulm3An28tA8vJtnm4Wag8Lv5X4FBHDWf4d+yRON/Qqo=
Received: from BN9PR03CA0146.namprd03.prod.outlook.com (2603:10b6:408:fe::31)
 by MN2PR12MB3503.namprd12.prod.outlook.com (2603:10b6:208:cf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:14:07 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::1a) by BN9PR03CA0146.outlook.office365.com
 (2603:10b6:408:fe::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:06 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:04 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/40] drm/amd/display: Maintain consistent mode of operation
 during encoder assignment
Date: Thu, 30 Jun 2022 15:12:59 -0400
Message-ID: <20220630191322.909650-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9148d46-800e-45a5-e39c-08da5accb426
X-MS-TrafficTypeDiagnostic: MN2PR12MB3503:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIVOy7scESvJQXxu9Hs9Qz9JfGyZUWsu/Y0uD0qTRP8pbh+sGpk4HLpBQscsDy/uteym1+oBE1RsktuU28iyIM4Yq/QLfnq9LRsi+MmbruT4lWjyrWKnUYxFxJm6URWjh+hO5DvLKTOy3kIQlyuCrXZ0luOIXyocHDdwF83rutl+JXwYWdr5iqc3XstVlvT88S6bERmvXLX5h6bSNL+807Ttwj/eTyO9p9radBiCiFdaZPfCoLPkiVWwJN8v5qGRNgUH6ZEv++MxNLZZNOLKPkssOBgiRJIIFhTH6rMiQBfiG+uCAboMXRczMhAXg73DJ3SWFOUXy7Ad9CKNXwvMae7MDYGfb9uJWDEUcWslpAYBAwsdX7mwLToBX/hHdB811YGURom7V/wXALJO6XR09ahVVzARv0weZi3Q8yUKswON7nPATv3ZPQp9YjrjshnI6UmLeoQHrdOi0iTj3LvGBB6KCTyHFGnSdHDgUw3IOD8PDYeU1IvLcleVjVAhKbQf86cFlA6KQ25LOhu412X0uztO1SqUKQEVzPdSKyNJmmxoHsTdMGw8Aa7JvO8D+dcnUzsW9jjrstGrkoqG9NhMZRDJhQlraO80q2RjE5tXJhrWbj4pDJSRk1Qzs208Pw3oTKQaY6B6OeOLq0xemiQfCeD86F9FqxJuHpE2g50Qwi/N0oONS4BV0jLUnRYZjDATBzdLCqKsdlO8RrmxeeVOSU+6JfP0V6zzO58trV+wlEVVCnCCTRLOdN4IyRHN+lXip0UbVD/xFLzmbfJwHxmgqnRDCK02gNv4CrE5RSZuwcZP1tc7aVcWRzf/5jfApCpiS9ZXHFp2LLDGij2+S1moI6pkKW4vA00aSW5fC+SS/0Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(40470700004)(6916009)(54906003)(36756003)(478600001)(70586007)(316002)(70206006)(86362001)(82740400003)(36860700001)(356005)(40460700003)(41300700001)(6666004)(81166007)(47076005)(82310400005)(336012)(83380400001)(426003)(1076003)(26005)(40480700001)(7696005)(5660300002)(2906002)(16526019)(186003)(8936002)(4326008)(8676002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:06.7997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9148d46-800e-45a5-e39c-08da5accb426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
While applying a state to hardware, there is a transition period where
the back-end is reset using the old state; then enabled using the new
state.

Generally, the link encoder configuration module queries
stream-to-encoder assignments in either the new or old state based on a
mode variable. During the transition there is a need to query both
states, however toggling this mode variable can lead to incorrect
programming of encoders.

[How]
- Add new function to explicity query stream-to-encoder assignment
in the current state rather than intermittently switch the mode
of operation of the link encoder assignment module.
- Add additional checks for encoder assignment defects.
- Explicitly reset the mode of operation if application of state
to hardware ends prematurely.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 ++-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 32 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  7 ++--
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  5 +++
 4 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 34a3e1eeb5c4..8ed208e5def2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1750,8 +1750,11 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 
 	result = dc->hwss.apply_ctx_to_hw(dc, context);
 
-	if (result != DC_OK)
+	if (result != DC_OK) {
+		/* Application of dc_state to hardware stopped. */
+		dc->current_state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_STEADY;
 		return result;
+	}
 
 	dc_trigger_sync(dc, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 639a0a276a08..614f022d1cff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -292,6 +292,7 @@ void link_enc_cfg_link_encs_assign(
 	int j;
 
 	ASSERT(state->stream_count == stream_count);
+	ASSERT(dc->current_state->res_ctx.link_enc_cfg_ctx.mode == LINK_ENC_CFG_STEADY);
 
 	/* Release DIG link encoder resources before running assignment algorithm. */
 	for (i = 0; i < dc->current_state->stream_count; i++)
@@ -561,6 +562,31 @@ struct link_encoder *link_enc_cfg_get_link_enc(
 	return link_enc;
 }
 
+struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream_current(
+		struct dc *dc,
+		const struct dc_stream_state *stream)
+{
+	struct link_encoder *link_enc = NULL;
+	struct display_endpoint_id ep_id;
+	int i;
+
+	ep_id = (struct display_endpoint_id) {
+		.link_id = stream->link->link_id,
+		.ep_type = stream->link->ep_type};
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct link_enc_assignment assignment =
+			dc->current_state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
+
+		if (assignment.valid == true && are_ep_ids_equal(&assignment.ep_id, &ep_id)) {
+			link_enc = stream->link->dc->res_pool->link_encoders[assignment.eng_id - ENGINE_ID_DIGA];
+			break;
+		}
+	}
+
+	return link_enc;
+}
+
 bool link_enc_cfg_is_link_enc_avail(struct dc *dc, enum engine_id eng_id, struct dc_link *link)
 {
 	bool is_avail = true;
@@ -595,6 +621,7 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 	uint8_t dig_stream_count = 0;
 	int matching_stream_ptrs = 0;
 	int eng_ids_per_ep_id[MAX_PIPES] = {0};
+	int ep_ids_per_eng_id[MAX_PIPES] = {0};
 	int valid_bitmap = 0;
 
 	/* (1) No. valid entries same as stream count. */
@@ -630,6 +657,7 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 			struct display_endpoint_id ep_id_i = assignment_i.ep_id;
 
 			eng_ids_per_ep_id[i]++;
+			ep_ids_per_eng_id[i]++;
 			for (j = 0; j < MAX_PIPES; j++) {
 				struct link_enc_assignment assignment_j =
 					state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[j];
@@ -644,6 +672,10 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 							assignment_i.eng_id != assignment_j.eng_id) {
 						valid_uniqueness = false;
 						eng_ids_per_ep_id[i]++;
+					} else if (!are_ep_ids_equal(&ep_id_i, &ep_id_j) &&
+							assignment_i.eng_id == assignment_j.eng_id) {
+						valid_uniqueness = false;
+						ep_ids_per_eng_id[i]++;
 					}
 				}
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 332110bb1286..b67fdb31f75f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3015,12 +3015,11 @@ bool pipe_need_reprogram(
 	if (pipe_ctx_old->stream->ctx->dc->res_pool->funcs->link_encs_assign) {
 		bool need_reprogram = false;
 		struct dc *dc = pipe_ctx_old->stream->ctx->dc;
-		enum link_enc_cfg_mode mode = dc->current_state->res_ctx.link_enc_cfg_ctx.mode;
+		struct link_encoder *link_enc_prev =
+			link_enc_cfg_get_link_enc_used_by_stream_current(dc, pipe_ctx_old->stream);
 
-		dc->current_state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_STEADY;
-		if (link_enc_cfg_get_link_enc_used_by_stream(dc, pipe_ctx_old->stream) != pipe_ctx->stream->link_enc)
+		if (link_enc_prev != pipe_ctx->stream->link_enc)
 			need_reprogram = true;
-		dc->current_state->res_ctx.link_enc_cfg_ctx.mode = mode;
 
 		return need_reprogram;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
index 7beb14169f92..dc650be3837e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -104,6 +104,11 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream(
 /* Return DIG link encoder. NULL if unused. */
 struct link_encoder *link_enc_cfg_get_link_enc(const struct dc_link *link);
 
+/* Return DIG link encoder used by stream in current/previous state. NULL if unused. */
+struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream_current(
+		struct dc *dc,
+		const struct dc_stream_state *stream);
+
 /* Return true if encoder available to use. */
 bool link_enc_cfg_is_link_enc_avail(struct dc *dc, enum engine_id eng_id, struct dc_link *link);
 
-- 
2.25.1


Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF87C35657
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39252067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PLZZzEap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39252067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E4356F4C3;
	Fri, 21 Feb 2020 16:04:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3C76F4C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR5IclNvxhRZ+ob+ZiyWIFUvcupbI/HgY9eeEXqdRy5IoNJJpnWuX/NP+3p9gucCYJy38e04o/21mbIN2czM+IsoFfL7yWX2daDh8ytXMWuczKX0SL3KOCA7r/wy3qQBqVqSz6Te9+HSNbLsRJ7MmmmB9x/IFautDH3oeNsom1Dle9BpWHXW5Jrw4kdAvGiB/6OltXvGUTynjtrfNmVt47w7VzCJX9O9vCjpMK3Ib6hqhZUWQhClxeCVfgHIK17+WZHFuC27q7K/181kuNrw3RAyn8Cd/Z1EIilXXqXt44rabgZ/1GLx1OgYN0bv3KjlsS8bEKvJsqymIFes3fm+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ORsPwvq+hb7Rt91HrQOqiBZm8y4VvQMRIGgPce/P4w=;
 b=Te/nyxXDKsJsDGt16gqIAkXO7jr6lvEKLwSNyQfXeMMAs8K1Dfl+JXHWuQhAleESoL0RW4hWKVfHX+6WjbRPLWMPZF8W3cKh43z0iYX2bpiF0b97y+ufOvkZP6jCgFOPH6lOhXpeguk9P9AysWQ2wH27DFyJZd+heyiAA6AwqsWLf7wwBDIY2ZDL87a9XKOJVyWJAbyB8rxcZozhabzMk95yHZUSsYX3szw5jAbVAtrdFVVkIgx3yV4p51i2UnkanUXtxdMnK66bhjMyNy3z7NcoT9VAFlKuxZoBWIvLmQjEeIaA8tCkbj9obRaNKBH0eQ5XdHNyXOXS3gh1N3Q75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ORsPwvq+hb7Rt91HrQOqiBZm8y4VvQMRIGgPce/P4w=;
 b=PLZZzEapdm9Y2H8pvcpHBNDCjc3STbNtDjwynBPRjLwQKV181JuJTe7OXObmVs+P9ff/N8k+gxlT2msyVp19VASTA1GADFzofgmwjDbtCK4Kbr14c91zOccalkATzX3rH7GD3GIgQQge75GEJHrnQohKo53EE3txzCQ/vo8aQlE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:51 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:51 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/35] drm/amd/display: Temporarily disable stutter on MPO
 transition
Date: Fri, 21 Feb 2020 11:03:22 -0500
Message-Id: <20200221160324.2969975-34-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:15 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8f9d2ea-ab93-48d3-fbbd-08d7b6e7b356
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25727FADF954BE7F695C611298120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LP57XFzGus5jyrzK0bzt/wELVSSdYos9ckkJIlp0ee2aHzH+19TD6KGR6JNTp4rV7nFHDkwRoAa4pCtk8z3MB3GGbtBygVK0W/A4wkLdtUyNbJt5sczE5uyUqOcEC4Pr/91ildx7mXY8CLOWuAhpN+kGwTQJc/QpocrlvKncArUsx8KhYZzbe4LxoPC0FCZzIBbgwuufHGKkovKMh5ZnREGWz4JqYutJh5QXY+tSj2r2aYy4BoL7SAgbcEnAKfv5Wr7Uv40k0fcdUBE+qbEDgb6zPFZ+WEsO1JEB51KuCLQ6ZChse3I8GRDEyCy8uNhG3hheD6P+q3vzZD8IwXJUxObu64hOMnsmCmCD2VjxHCXZPOoPpR+P4BH8MaITJ4ScryIjKRpi+74FhNyaAK94Lsa6l0WS8/X0X+OTYm+rShXx7HzNlK43bdVIfso496Bb
X-MS-Exchange-AntiSpam-MessageData: z2e39yi1xUe5QDFGZnp+aqc4+lrWO+jclCJ7NqKetNmiJB79mEY5xta98V4nlLfBjltsEuQbdFxSVtoM3076IdvsAp5EX77RectB0x0daziD+IS2+lPUxhRx1hjNKdzymfu6f5TfyWHODsbkWt+fpw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f9d2ea-ab93-48d3-fbbd-08d7b6e7b356
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:16.0586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoYuwRBvkVCh/R3oSKNSmv8MDX0dLGI0bmeHXWDN8Vo8R9PAbGbWpYdAfsxVDohH9/oSLS/EX+PxpnwO4gagAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Eric Yang <eric.yang2@amd.com>, Sunpeng.Li@amd.com,
 Tony Cheng <tony.cheng@amd.com>, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Underflow sometimes occurs during transition into MPO with stutter
enabled.

[How]
When transitioning into MPO, disable stutter. Re-enable stutter within
one frame.

Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 14 ++++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 19 ++++++++++++++++++-
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |  1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |  3 +++
 5 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c381d347208f..c31ea11f10fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2925,6 +2925,7 @@ void dcn10_update_pending_status(struct pipe_ctx *pipe_ctx)
 	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	bool flip_pending;
+	struct dc *dc = plane_state->ctx->dc;
 
 	if (plane_state == NULL)
 		return;
@@ -2942,6 +2943,19 @@ void dcn10_update_pending_status(struct pipe_ctx *pipe_ctx)
 		plane_state->status.is_right_eye =
 				!tg->funcs->is_stereo_left_eye(pipe_ctx->stream_res.tg);
 	}
+
+	if (dc->hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied) {
+		struct dce_hwseq *hwseq = dc->hwseq;
+		struct timing_generator *tg = dc->res_pool->timing_generators[0];
+		unsigned int cur_frame = tg->funcs->get_frame_count(tg);
+
+		if (cur_frame != hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied_on_frame) {
+			struct hubbub *hubbub = dc->res_pool->hubbub;
+
+			hubbub->funcs->allow_self_refresh_control(hubbub, !dc->debug.disable_stutter);
+			hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied = false;
+		}
+	}
 }
 
 void dcn10_update_dchub(struct dce_hwseq *hws, struct dchub_init_data *dh_data)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index cf13b1db1025..97c0c8ced8e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1584,6 +1584,7 @@ void dcn20_post_unlock_program_front_end(
 {
 	int i;
 	const unsigned int TIMEOUT_FOR_PIPE_ENABLE_MS = 100;
+	struct dce_hwseq *hwseq = dc->hwseq;
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 
@@ -1611,8 +1612,24 @@ void dcn20_post_unlock_program_front_end(
 	}
 
 	/* WA to apply WM setting*/
-	if (dc->hwseq->wa.DEGVIDCN21)
+	if (hwseq->wa.DEGVIDCN21)
 		dc->res_pool->hubbub->funcs->apply_DEDCN21_147_wa(dc->res_pool->hubbub);
+
+
+	/* WA for stutter underflow during MPO transitions when adding 2nd plane */
+	if (hwseq->wa.disallow_self_refresh_during_multi_plane_transition) {
+
+		if (dc->current_state->stream_status[0].plane_count == 1 &&
+				context->stream_status[0].plane_count > 1) {
+
+			struct timing_generator *tg = dc->res_pool->timing_generators[0];
+
+			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub, false);
+
+			hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied = true;
+			hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied_on_frame = tg->funcs->get_frame_count(tg);
+		}
+	}
 }
 
 void dcn20_prepare_bandwidth(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index 8440975206e0..5e2d14b897af 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -702,6 +702,7 @@ static const struct hubbub_funcs hubbub21_funcs = {
 	.wm_read_state = hubbub21_wm_read_state,
 	.get_dchub_ref_freq = hubbub2_get_dchub_ref_freq,
 	.program_watermarks = hubbub21_program_watermarks,
+	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
 	.apply_DEDCN21_147_wa = hubbub21_apply_DEDCN21_147_wa,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index f453de10aa2d..aa73025c1747 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1564,6 +1564,7 @@ static struct dce_hwseq *dcn21_hwseq_create(
 		hws->shifts = &hwseq_shift;
 		hws->masks = &hwseq_mask;
 		hws->wa.DEGVIDCN21 = true;
+		hws->wa.disallow_self_refresh_during_multi_plane_transition = true;
 	}
 	return hws;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index c5511e6157af..b1d736cbcd5a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -40,10 +40,13 @@ struct dce_hwseq_wa {
 	bool false_optc_underflow;
 	bool DEGVIDCN10_254;
 	bool DEGVIDCN21;
+	bool disallow_self_refresh_during_multi_plane_transition;
 };
 
 struct hwseq_wa_state {
 	bool DEGVIDCN10_253_applied;
+	bool disallow_self_refresh_during_multi_plane_transition_applied;
+	unsigned int disallow_self_refresh_during_multi_plane_transition_applied_on_frame;
 };
 
 struct pipe_ctx;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

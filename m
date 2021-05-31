Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B435C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 07:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A806124B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 07:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A806124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E826E8B1;
	Tue,  1 Jun 2021 07:59:10 +0000 (UTC)
X-Greylist: delayed 1070 seconds by postgrey-1.36 at gabe;
 Mon, 31 May 2021 09:48:16 UTC
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF3088584
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 09:48:16 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ftqdy65Zrz1BGsJ;
 Mon, 31 May 2021 17:25:42 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 17:30:18 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 17:30:18 +0800
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Remove the redundant initialization of local
 variable
Date: Mon, 31 May 2021 17:30:06 +0800
Message-ID: <1622453406-50092-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 01 Jun 2021 07:59:08 +0000
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
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Local variable 'i' and 'j' will be initialized in the for loop, so
remove the redundant initialization.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4713f09bcbf1..e4f2a2d3a819 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -304,7 +304,7 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_crtc_timing_adjust *adjust)
 {
-	int i = 0;
+	int i;
 	bool ret = false;
 
 	stream->adjust.v_total_max = adjust->v_total_max;
@@ -332,7 +332,7 @@ bool dc_stream_get_crtc_position(struct dc *dc,
 {
 	/* TODO: Support multiple streams */
 	const struct dc_stream_state *stream = streams[0];
-	int i = 0;
+	int i;
 	bool ret = false;
 	struct crtc_position position;
 
@@ -539,7 +539,7 @@ void dc_stream_set_dyn_expansion(struct dc *dc, struct dc_stream_state *stream,
 		enum dc_dynamic_expansion option)
 {
 	/* OPP FMT dyn expansion updates*/
-	int i = 0;
+	int i;
 	struct pipe_ctx *pipe_ctx;
 
 	for (i = 0; i < MAX_PIPES; i++) {
@@ -597,7 +597,7 @@ void dc_stream_set_dither_option(struct dc_stream_state *stream,
 
 bool dc_stream_set_gamut_remap(struct dc *dc, const struct dc_stream_state *stream)
 {
-	int i = 0;
+	int i;
 	bool ret = false;
 	struct pipe_ctx *pipes;
 
@@ -614,7 +614,7 @@ bool dc_stream_set_gamut_remap(struct dc *dc, const struct dc_stream_state *stre
 
 bool dc_stream_program_csc_matrix(struct dc *dc, struct dc_stream_state *stream)
 {
-	int i = 0;
+	int i;
 	bool ret = false;
 	struct pipe_ctx *pipes;
 
@@ -640,8 +640,7 @@ void dc_stream_set_static_screen_params(struct dc *dc,
 		int num_streams,
 		const struct dc_static_screen_params *params)
 {
-	int i = 0;
-	int j = 0;
+	int i, j;
 	struct pipe_ctx *pipes_affected[MAX_PIPES];
 	int num_pipes_affected = 0;
 
@@ -896,7 +895,7 @@ static void disable_all_writeback_pipes_for_stream(
 static void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *context,
 					  struct dc_stream_state *stream, bool lock)
 {
-	int i = 0;
+	int i;
 
 	/* Checks if interdependent update function pointer is NULL or not, takes care of DCE110 case */
 	if (dc->hwss.interdependent_update_lock)
@@ -1156,7 +1155,7 @@ static void enable_timing_multisync(
 		struct dc *dc,
 		struct dc_state *ctx)
 {
-	int i = 0, multisync_count = 0;
+	int i, multisync_count = 0;
 	int pipe_count = dc->res_pool->pipe_count;
 	struct pipe_ctx *multisync_pipes[MAX_PIPES] = { NULL };
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30349C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 12:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D7E8FABA;
	Tue, 26 Jul 2022 12:54:23 +0000 (UTC)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C579711BBE3;
 Tue, 26 Jul 2022 07:27:27 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0VKUJQq0_1658820441; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VKUJQq0_1658820441) by smtp.aliyun-inc.com;
 Tue, 26 Jul 2022 15:27:23 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Subject: [PATCH 15/20] drm/amd/display: Clean up some inconsistent indenting
Date: Tue, 26 Jul 2022 15:25:50 +0800
Message-Id: <20220726072555.91323-15-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
References: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 Jul 2022 12:54:21 +0000
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, airlied@linux.ie,
 Xinhui.Pan@amd.com, Abaci Robot <abaci@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No functional modification involved.

smatch warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c:1728 dcn20_program_front_end_for_ctx() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c   | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 3b26962637d0..68690e2118cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1715,15 +1715,13 @@ void dcn20_program_front_end_for_ctx(
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	/* Carry over GSL groups in case the context is changing. */
-       for (i = 0; i < dc->res_pool->pipe_count; i++) {
-               struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-               struct pipe_ctx *old_pipe_ctx =
-                       &dc->current_state->res_ctx.pipe_ctx[i];
-
-               if (pipe_ctx->stream == old_pipe_ctx->stream)
-                       pipe_ctx->stream_res.gsl_group =
-                               old_pipe_ctx->stream_res.gsl_group;
-       }
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *old_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream == old_pipe_ctx->stream)
+			pipe_ctx->stream_res.gsl_group = old_pipe_ctx->stream_res.gsl_group;
+	}
 
 	if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-- 
2.20.1.7.g153144c


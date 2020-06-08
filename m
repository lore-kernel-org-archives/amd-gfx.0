Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0DFC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CD220774
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtAsqnww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CD220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1992889CA0;
	Mon,  8 Jun 2020 23:06:29 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB0889CA0;
 Mon,  8 Jun 2020 23:06:28 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 166602078C;
 Mon,  8 Jun 2020 23:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591657588;
 bh=UCFZxBdhCTtSOkMISHI4v+UNZnsH2SbHB6zuHhVW3k0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mtAsqnwwW8w0PJZJ/QPy3ydNyMHWR1vbtLSzpCWvTPMBbM6HBKCBxN1rzRJYONT29
 uGirI0Op+8T0D7FmcXXRpm7lWiF4Kt++dWwROywi1XhxwdMxMERe+6CwYWc4IKeCdz
 ogNNw9aTGkaoY+StqgtprTwNJ+CAN09Hp326017k=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 016/274] drm/amd/display: Force watermark value
 propagation
Date: Mon,  8 Jun 2020 19:01:49 -0400
Message-Id: <20200608230607.3361041-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Joshua Aberback <joshua.aberback@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Jun Lei <Jun.Lei@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[ Upstream commit 868149c9a072cbdc22a73ce25a487f9fbfa171ef ]

[Why]
The HUBBUB watermark registers are in an area that cannot be power
gated, but the HUBP copies of the watermark values are in areas that can
be power gated. When we power on a pipe, it will not automatically take
the HUBBUB values, we need to force propagation by writing to a
watermark register.

[How]
 - new HUBBUB function to re-write current value in a WM register
 - touch WM register after enabling the plane in program_pipe

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 5 ++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index a023a4d59f41..c4fa13e4eaf9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1478,8 +1478,11 @@ static void dcn20_program_pipe(
 	if (pipe_ctx->update_flags.bits.odm)
 		hws->funcs.update_odm(dc, context, pipe_ctx);
 
-	if (pipe_ctx->update_flags.bits.enable)
+	if (pipe_ctx->update_flags.bits.enable) {
 		dcn20_enable_plane(dc, pipe_ctx, context);
+		if (dc->res_pool->hubbub->funcs->force_wm_propagate_to_pipes)
+			dc->res_pool->hubbub->funcs->force_wm_propagate_to_pipes(dc->res_pool->hubbub);
+	}
 
 	if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw)
 		dcn20_update_dchubp_dpp(dc, pipe_ctx, context);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index f5dd0cc73c63..47a566d82d6e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -144,6 +144,8 @@ struct hubbub_funcs {
 	void (*allow_self_refresh_control)(struct hubbub *hubbub, bool allow);
 
 	void (*apply_DEDCN21_147_wa)(struct hubbub *hubbub);
+
+	void (*force_wm_propagate_to_pipes)(struct hubbub *hubbub);
 };
 
 struct hubbub {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

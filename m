Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1149BC53200
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 13:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111F010EC20;
	Wed, 29 Jul 2026 13:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="NDS3ATay";
	dkim-atps=neutral
X-Greylist: delayed 448 seconds by postgrey-1.36 at gabe;
 Wed, 29 Jul 2026 06:42:19 UTC
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [91.218.175.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A9510EAAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 06:42:19 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785306929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DdWQssPSqZdb7sOqrtH8PFNHfBVcOEVomAVniJbTXFA=;
 b=NDS3ATay3NArX+C9XVtjs+zulQTkR/nSL/prFpVnqcnfWptgMP+PlH9dYONExj7xqD9Pug
 2iqgE79Ofng74bunbLFc80FUErj1BEqCPaKdXZv8ho9kthzM3lsg8mPPjCLhQ3gOiHiVTu
 KvaxTMkefXFS9xYCFsJOqjYG9ORaSiY=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
 mario.limonciello@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH 6.6.y] drm/amd/display: Fix dcn32 DTB DTO update breaking live
 pixel rate sources
Date: Tue, 28 Jul 2026 23:34:52 -0700
Message-ID: <20260729063452.9411-1-matthew.schwartz@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 29 Jul 2026 13:16:19 +0000
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

From: Harry Wentland <harry.wentland@amd.com>

commit 76a2db58e95e328007043f54ac3c7336ccbee440 upstream.

dcn32_update_clocks_update_dtb_dto() reprograms the DTB DTO of every
timing generator in the context whenever the DTBCLK reference changes,
passing a zeroed pixel rate and never setting is_hdmi.
dccg32_set_dtbclk_dto() treats a zero pixel rate as a disable request,
and that branch drives PIPE_DTO_SRC_SEL to the DP DTO source. A timing
generator actively scanning out an HDMI stream therefore has its pixel
rate source re-muxed out from under the live raster, and the OTG stops
on the spot.

Two displays where only one runs a 128b/132b link hit this reliably.
is_dtbclk_required() holds the DTBCLK reference high while both are
active, and the moment the 128b/132b stream is torn down (compositor
switch, display disable, hot-unplug) the next safe_to_lower pass drops
the reference to the lowest DPM level and the DTO walk freezes the
surviving screen. On Navi31 the DAL mailbox then goes deaf on the
DISPCLK hard-min that follows the walk in dcn32_update_clocks(),
stranding both SMU mailboxes until reboot.

Set is_hdmi for HDMI and DVI signals so the disable path leaves the
pixel rate source selection on the HDMI path, and pass the real pixel
rate for 128b/132b streams so a reference change rescales their DTO
instead of disabling it.

Fixes: 128c1ca0303f ("drm/amd/display: Update DTBCLK for DCN32")
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ mschwartz: dcn32 clk_mgr hunk only, as 6.6.y predates the dcn35
  clk_mgr. The rest is HDMI FRL enablement, absent before 7.2, so the
  FRL conditions and the req_audio_dtbclk_khz assignment they guard are
  dropped and the FRL-centric changelog is rewritten. Added the
  pipe_ctx->stream check the new dereferences need. ]
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
6.6.y predates the dcn35 clk_mgr, so only the dcn32 hunk applies. The
6.12.y, 6.18.y and 7.1.y equivalent is sent alongside this one. Tested
on Navi31 with a DisplayPort UHBR monitor and an HDMI TV.

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 084994c650c4..285689d7ecc4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -276,13 +276,20 @@ static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 		struct dtbclk_dto_params dto_params = {0};
 
 		/* use mask to program DTO once per tg */
-		if (pipe_ctx->stream_res.tg &&
+		if (pipe_ctx->stream && pipe_ctx->stream_res.tg &&
 				!(tg_mask & (1 << pipe_ctx->stream_res.tg->inst))) {
 			tg_mask |= (1 << pipe_ctx->stream_res.tg->inst);
 
 			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
 			dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
 
+			if (dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx))
+				dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+
+			if (dc_is_hdmi_signal(pipe_ctx->stream->signal) ||
+					dc_is_dvi_signal(pipe_ctx->stream->signal))
+				dto_params.is_hdmi = true;
+
 			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
 			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
 		}
-- 
2.50.1


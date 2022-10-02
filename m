Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A48C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  2 Oct 2022 22:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD6710E168;
	Sun,  2 Oct 2022 22:52:35 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D426810E168;
 Sun,  2 Oct 2022 22:52:32 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5A01260EB6;
 Sun,  2 Oct 2022 22:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B5EC43470;
 Sun,  2 Oct 2022 22:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664751151;
 bh=jDTWO7/A4ILbQOGos8cOKJRfLSJ/u0dfe62xH/2E/WM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AIhATSwIiEYvIQ85SzuTVZyRO2368VS086XV2/GQ1EeEkymwfDjahJKnggtZyoqLl
 29tW/f3WLv6OEr3NRVfORwbsH0Tjpgyb6OWIWASv5tBRKeJ5e8YBN1UaxVhm2j5OJh
 a921zcNP7d3dVDtAgsU0kOJOoif2q9mRpa6iVDH0w8ZV5ogtEJ0BhCvmB23w744Qq4
 MXTk/XRcmrwTFt7On20iLttZA8itR6Z6YP0RxJ8czIdHEw836tffBPV/4HhyayeaOx
 UlrzTwexTI1xy+7xzgSb2e56i6u+NtiJ9eqbXFPY8C7m7AA2KzwmxG2XuVetHmRt7T
 Mc8Iabbo4vmjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 13/14] drm/amd/display: update gamut remap if
 plane has changed
Date: Sun,  2 Oct 2022 18:51:54 -0400
Message-Id: <20221002225155.239480-13-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221002225155.239480-1-sashal@kernel.org>
References: <20221002225155.239480-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
Cc: Aric.Cyr@amd.com, wenjing.liu@amd.com, dri-devel@lists.freedesktop.org,
 Yi-Ling.Chen2@amd.com, Jun.Lei@amd.com, airlied@gmail.com,
 Sasha Levin <sashal@kernel.org>, jiapeng.chong@linux.alibaba.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com, Alvin.Lee2@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, duncan.ma@amd.com, mwen@igalia.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Sungjoon.Kim@amd.com,
 Hugo Hu <hugo.hu@amd.com>, Xinhui.Pan@amd.com, christian.koenig@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, daniel@ffwll.ch,
 Wayne Lin <wayne.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Nicholas.Kazlauskas@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

[ Upstream commit 52bb21499cf54fa65b56d97cd0d68579c90207dd ]

[Why]
The desktop plane and full-screen game plane may have different
gamut remap coefficients, if switching between desktop and
full-screen game without updating the gamut remap will cause
incorrect color.

[How]
Update gamut remap if planes change.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Hugo Hu <hugo.hu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 3d778760a3b5..8f66eef0c683 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1481,6 +1481,7 @@ static void dcn20_update_dchubp_dpp(
 	/* Any updates are handled in dc interface, just need
 	 * to apply existing for plane enable / opp change */
 	if (pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed
+			|| pipe_ctx->update_flags.bits.plane_changed
 			|| pipe_ctx->stream->update_flags.bits.gamut_remap
 			|| pipe_ctx->stream->update_flags.bits.out_csc) {
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
-- 
2.35.1


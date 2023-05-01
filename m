Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CA9C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 02:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B8D10E237;
	Mon,  1 May 2023 02:59:57 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F5910E22F;
 Mon,  1 May 2023 02:59:54 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BF126616F8;
 Mon,  1 May 2023 02:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC06C4339B;
 Mon,  1 May 2023 02:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682909993;
 bh=K3C3CZOk2uST1KWyrsVqSkZoMOGDoKDo7Ge12lkhx88=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HJ9uvbI1xlO6scGD1zNKRn7jkgD2J/NkkYZP9LT7hzOjHIwkV9eN8u9FwVi0sAOWI
 /otPthNRJInAV3m9nqDRoMjkpLGgi7meS2rcw2EOKzEq+cphlxST/lpQJbTWZMsedF
 DOJxrBqUlwWHvT7cOdFBPubc2cR/r0NRhMJlPUZqLpDX1J5SjhFTPkMMyY3f7KuJf8
 D54/Lh350WWMWQUZsJWKFN+fg5jhNVfV0cu+oHTl3f3j66QeWZNvlCnBxdxsU2qpNx
 Lc+MimOupbUHm+tZ8YK/WHQfFZaE7+B8/oPtx9IQTOXZ1J2pShvgPTnqV8K2XKHWQc
 iCn2c9EFluoog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 02/37] drm/amd/display: populate subvp cmd info
 only for the top pipe
Date: Sun, 30 Apr 2023 22:59:10 -0400
Message-Id: <20230501025945.3253774-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025945.3253774-1-sashal@kernel.org>
References: <20230501025945.3253774-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org,
 sunpeng.li@amd.com, airlied@gmail.com, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 Max.Tseng@amd.com, Ayush Gupta <ayush.gupta@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>, Jun.Lei@amd.com,
 harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ayush Gupta <ayush.gupta@amd.com>

[ Upstream commit 9bb10b7aaec3b6278f9cc410c17dcaa129bbbbf0 ]

[Why]
System restart observed while changing the display resolution
to 8k with extended mode. Sytem restart was caused by a page fault.

[How]
When the driver populates subvp info it did it for both the pipes using
vblank which caused an outof bounds array access causing the page fault.
added checks to allow the top pipe only to fix this issue.

Co-authored-by: Ayush Gupta <ayush.gupta@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Ayush Gupta <ayush.gupta@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 6ccf477d1c4dc..1141c50fa2b1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -750,7 +750,8 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 					!pipe->top_pipe && !pipe->prev_odm_pipe &&
 					pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				populate_subvp_cmd_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
-			} else if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_NONE) {
+			} else if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_NONE &&
+				    !pipe->top_pipe && !pipe->prev_odm_pipe) {
 				// Don't need to check for ActiveDRAMClockChangeMargin < 0, not valid in cases where
 				// we run through DML without calculating "natural" P-state support
 				populate_subvp_cmd_vblank_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
-- 
2.39.2


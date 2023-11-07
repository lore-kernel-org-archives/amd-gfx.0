Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A613C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 12:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AEEC10E55D;
	Tue,  7 Nov 2023 12:24:47 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B27C10E55D;
 Tue,  7 Nov 2023 12:24:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AC4006117F;
 Tue,  7 Nov 2023 12:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DEEC433C8;
 Tue,  7 Nov 2023 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699359884;
 bh=5n1YHjOipinAQSpJfGvIDHIhNO8xp3lHM3hN1IvtOqQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aWXaAHp0Rm10/qyRVfABy4mY2waeFFHoDg6xGy1GWwr0S4+Ghu8WD/c8bSmoY6V0Q
 hXI8iOPKsEA1YG8BchWM3BpjU8L0t+qWmuoOiqqPmGg+DMyg3FVqimJbUM/a4KvCUo
 I1KDyDbPkQ1TTwRmwnYcCzUfAVTISy+l/m56htvzEvQmQrPBX6SQmcnQysTMA7FIBW
 Ty5zY+YQ3BuTFdzk30cs9gkWC6/pFBaqO5SnM3ufUuxgQHoM8DWMnrBWn03EfqphSi
 ugXgjzUn2UchiHFw+TnKKdG8Eesrn4BJ40jn1jtzfOJQSG4jozg1H7Pv3cPvH5WLM/
 Y88/QSoJmLnZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 05/37] drm/amd/display: Don't lock phantom pipe on
 disabling
Date: Tue,  7 Nov 2023 07:21:16 -0500
Message-ID: <20231107122407.3760584-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122407.3760584-1-sashal@kernel.org>
References: <20231107122407.3760584-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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
Cc: wenjing.liu@amd.com, Samson Tam <samson.tam@amd.com>, hamza.mahfooz@amd.com,
 moadhuri@amd.com, airlied@gmail.com, Sasha Levin <sashal@kernel.org>,
 Rodrigo.Siqueira@amd.com, syed.hassan@amd.com, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 harry.wentland@amd.com, Stylon Wang <stylon.wang@amd.com>, sunpeng.li@amd.com,
 mwen@igalia.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 dri-devel@lists.freedesktop.org, Wesley.Chalmers@amd.com,
 qingqing.zhuo@amd.com, Xinhui.Pan@amd.com, christian.koenig@amd.com,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 nicholas.kazlauskas@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit cbb4c9bc55427774ca4d819933e1b5fa38a6fb44 ]

[Description]
- When disabling a phantom pipe, we first enable the phantom
  OTG so the double buffer update can successfully take place
- However, want to avoid locking the phantom otherwise setting
  DPG_EN=1 for the phantom pipe is blocked (without this we could
  hit underflow due to phantom HUBP being blanked by default)

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 9834b75f1837b..79befa17bb037 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -111,7 +111,8 @@ void dcn10_lock_all_pipes(struct dc *dc,
 		if (pipe_ctx->top_pipe ||
 		    !pipe_ctx->stream ||
 		    (!pipe_ctx->plane_state && !old_pipe_ctx->plane_state) ||
-		    !tg->funcs->is_tg_enabled(tg))
+		    !tg->funcs->is_tg_enabled(tg) ||
+			pipe_ctx->stream->mall_stream_config.type == SUBVP_PHANTOM)
 			continue;
 
 		if (lock)
-- 
2.42.0


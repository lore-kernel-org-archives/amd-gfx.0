Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27707CA5FFE
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 07:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEC110EBCC;
	Mon,  5 Oct 2026 07:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="YbrNijNw";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570C510E68E
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:37:59 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-149241d04f5so301311c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790969878; x=1791574678;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EGgEtdhM8SzSotKxZXA7cTlPWzHiA22Nw8COOnRZiR4=;
 b=YbrNijNwfSR6sfus5TS9ZHAS/skpcmKrf1L0xFtrnxgf7PuGmHZqCUKTBPwYcFBhCA
 ieDICpdw5oLwr14rMyQoJey12qQ+IWF+loaJN4t79YZGnEZr783nHQzSuB8oePECD5K8
 V2QsJnOD3Gg49FNF87Vxu1r0SXdDUXROiPvDVjE0j3aCoOK0zHFP0UL0Hwha7YWOJvj3
 0by/nvgh0fHB0Mm/A+ifL+Vv0UZ7MUFQDBTqcCNhxpOVCbzn5hiyPUpG+c+1JgQ/eGzD
 9Z1/gUD8Q3WRaXEDQMx0nhHezy5xCWDO+8v0o+CZo3ammyCOkdgXDbPRfQS5G+NNDKz/
 Txtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790969878; x=1791574678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EGgEtdhM8SzSotKxZXA7cTlPWzHiA22Nw8COOnRZiR4=;
 b=m8d47pQV1LQA8aVE9vKj6FBbcEqT/YwYeg1rCqn5unW0n4XDIbhE2G/KVyW9pzoYZn
 za04G5cFLU7ogDh0iw5fKDxJYamylPGwsOFo337Ed5vuZS0fYUiDoql9a+ofb8qkHQc3
 B9z9b4sry7SeAGM1jHykMbGFcNoaVYj8/WVyVpcRkKhTVUd7JhAqM9FFyg0Js7zdaWZJ
 d7GQGj+LLqbuSROHkp7Rw6Ii0URl9l/lcfRfgmTEjFnmoO7O2dBa8HMGjPiOnAq9Og0M
 q5LNjBw6Dx6p5Rmf1pPYM3jtPzAntEsRvLS7Gf+ZLbZTHfOlLx96WZ7Rj10mS0qGxvwd
 zsXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOlF0478E9VMpLBact3+W75G9GCLc0mzF1h08l0CuaL02hd3qWd03nAg8NQO9T2rmp9mtleKyy@lists.freedesktop.org
X-Gm-Message-State: AFuF++n88xlJa8Lt6NTuYnpqxUPx8zH7xgVx147a5R+fap7diuZ9xWw6
 QoEm90qRyH/KPRurHO0hAQ0yvRZaf1XLe2eyxOQtwqUiGSztqP0AkK6SivMyBPQFqKE=
X-Gm-Gg: AYBFou3HFpmlDHYtmMJvzGnJpRnA9Rs5JRAP8uQPmrZXWCWBtKlZJFpGqtBC7UpoIHu
 AQ+F9Tv1MnMFPQ79v8QBo21qd4es/xri8v7CkdP25bAA0XsJ7V+GQevNAShnx5aHUs2sguYyIIA
 5wB9TkFOg79nqpELEJxmNh072A4Y3veQzhwSXIOzfbMzUtzDbymHlhwzoam2KZopgIcydCRpK4v
 16pcgZjv1H681t/s+FSVgNrFoWFpXzk3YWpg09XhQXLz1ZLgYwVAuBySyrgCsKmdrPg0nFYcHVx
 A5y2fW5LWz5LH4HgcW/GFvnMU70+dKs6YQ2T85JaN1Vrd9sCcQJ6qGUtDWFIRzX/JUPGnk+Fa/Q
 Q81Djwp9j5iXT+UTHyD8PAkTiFcynQkiNiXuT0vanXroCrBzItTcvG7EdCXNRkjpBAjArj1t6lj
 9oiSjhqvyvzlkK99I4u43fvvxCJHO5hRQ4OLfnQFz1U/R1QLVbWMlZ0kNnIrto4xzdGRPj7hOa/
 F64yRr5BYDfvPENwkMAEsy7r3o+XC/bgTCAsk55WeWNOd5ehsVPjJoOE3xsBqWs4vVc9SdU9mMR
 fc19nA==
X-Received: by 2002:a05:701b:4518:20b0:149:49c:233 with SMTP id
 a92af1059eb24-151c38af23amr469208c88.27.1790969878266; 
 Fri, 02 Oct 2026 12:37:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14fae9b3dfesm6642483c88.11.2026.10.02.12.37.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Oct 2026 12:37:57 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <xinhui.pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6.1.y] drm/amd/display: Validate function returns
Date: Fri,  2 Oct 2026 15:37:52 -0400
Message-ID: <20261002193753.20239-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Oct 2026 07:28:12 +0000
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c ]

[WHAT & HOW]
Function return values must be checked before data can be used
in subsequent functions.

This fixes 4 CHECKED_RETURN issues reported by Coverity.

[ Backport to 6.1.y: adapted the visual-panel, watermark, and
  link-detection checks to their older locations. The upstream DMUB
  run-list/D3 path is absent; the older dc_dmub_srv_cmd_queue() already
  checks and logs idle-wait failures but, unlike upstream, still retries
  the queue once afterwards. No DMUB queue change is included. ]

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-46775. It carries the three return-value
checks that map to 6.1.y: visual-panel validation, p-state watermark
propagation, and sink-detection validation during link-training retries.

The upstream DMUB run-list/D3 path does not exist here. I left 6.1.y's
older dc_dmub_srv_cmd_queue() unchanged. It already checks and logs the
idle-wait result, but unlike upstream it still re-queues once after a
failed wait, and checks that re-queue's status.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-46775
Upstream: 673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c    | 3 +--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c        | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 82b747c0ed693b..1d3d9a82c4637d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2808,8 +2808,7 @@ bool perform_link_training_with_retries(
 		if (status == LINK_TRAINING_ABORT) {
 			enum dc_connection_type type = dc_connection_none;
 
-			dc_link_detect_sink(link, &type);
-			if (type == dc_connection_none) {
+			if (dc_link_detect_sink(link, &type) && type == dc_connection_none) {
 				DC_LOG_HW_LINK_TRAINING("%s: Aborting training because sink unplugged\n", __func__);
 				break;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 31bb7e782c6b1d..35e8f22d30204b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -396,7 +396,8 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 	enum dmub_status status;
 	unsigned int panel_inst = 0;
 
-	dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst);
+	if (!dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst))
+		return;
 
 	memset(&cmd, 0, sizeof(cmd));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index aacb1fb5c73eb5..d2eebe39a55e33 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -595,7 +595,8 @@ static bool hubbub2_program_watermarks(
 		hubbub1->base.ctx->dc->clk_mgr->clks.p_state_change_support == false)
 		safe_to_lower = true;
 
-	hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
+	if (hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
 
 	REG_SET(DCHUBBUB_ARB_SAT_LEVEL, 0,
 			DCHUBBUB_ARB_SAT_LEVEL, 60 * refclk_mhz);
-- 
2.39.5

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCAEC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 16:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5670A10EA49;
	Fri, 12 Apr 2024 16:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="POMymU/G";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84DD810EA7B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Cf9OAN3j+PPU9zyQb0wmJfFdXe5mG59QCDv7qu3QWFQ=; b=POMymU/GSy7FTMYqurLDKnp2Gb
 pIchPr8KTEXEk7h/n/FZz187mhGTbJKHbKTFi1Qpbkb3DJVjOQNrTUYiAtQbd9jcd7D9LV7LwpfpH
 5dMp7odnU3/ZoZ3ZNOU/CyPpPRJ6bp1gzBmrR+inZPzvT+4BIzP5KXy6bnVGWNkjNBAehjO4p5fDL
 jaLG8OoMnRPxqCeNYUbmgpFm2n1eqNcQKQTxPfHjZtAtFjTvkUU1TCrrEpTpgny5MA7vqG7e3+tvS
 +T447GBJH2tCEJHNLbDZr45x3uovN6JEORvPXnnGbB69PY6QpvAu89YEZGkOsf4l552cRufbLVi4c
 HxFEAnIg==;
Received: from [189.6.17.125] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rvJw7-003xFS-5e; Fri, 12 Apr 2024 18:39:35 +0200
From: Melissa Wen <mwen@igalia.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: [PATCH] drm/amd/display: use mpcc_count to log MPC state
Date: Fri, 12 Apr 2024 13:39:09 -0300
Message-ID: <20240412163928.118203-1-mwen@igalia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

According to [1]:
```
DTN only logs 'pipe_count' instances of MPCC. However in some cases
there are different number of MPCC than DPP (pipe_count).
```

As DTN log still relies on pipe_count to print mpcc state, switch to
mpcc_count in all occurrences.

[1] https://lore.kernel.org/amd-gfx/20240328195047.2843715-39-Roman.Li@amd.com/

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 3940f25f7d9f..088224571029 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -367,7 +367,7 @@ static void dcn10_log_color_state(struct dc *dc,
 		 dc->caps.color.dpp.ocsc);
 
 	DTN_INFO("MPCC:  OPP  DPP  MPCCBOT  MODE  ALPHA_MODE  PREMULT  OVERLAP_ONLY  IDLE\n");
-	for (i = 0; i < pool->pipe_count; i++) {
+	for (i = 0; i < pool->mpcc_count; i++) {
 		struct mpcc_state s = {0};
 
 		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 87b43cb50c1e..a38333152654 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -155,7 +155,7 @@ void dcn20_log_color_state(struct dc *dc,
 	DTN_INFO("MPCC:  OPP  DPP  MPCCBOT  MODE  ALPHA_MODE  PREMULT  OVERLAP_ONLY  IDLE"
 		 "  OGAM mode\n");
 
-	for (i = 0; i < pool->pipe_count; i++) {
+	for (i = 0; i < pool->mpcc_count; i++) {
 		struct mpcc_state s = {0};
 
 		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 40391dd16944..ed9141a67db3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -166,7 +166,7 @@ void dcn30_log_color_state(struct dc *dc,
 		 "C21        C22        C23        C24        "
 		 "C31        C32        C33        C34        \n");
 
-	for (i = 0; i < pool->pipe_count; i++) {
+	for (i = 0; i < pool->mpcc_count; i++) {
 		struct mpcc_state s = {0};
 
 		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
-- 
2.43.0


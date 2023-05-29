Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D004C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 13:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506F910E38C;
	Tue, 30 May 2023 13:50:29 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr
 [80.12.242.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5023810E215
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 07:19:03 +0000 (UTC)
Received: from pop-os.home ([86.243.2.178]) by smtp.orange.fr with ESMTPA
 id 3X9eqYgEzMDzt3X9eq4QMn; Mon, 29 May 2023 09:19:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1685344740;
 bh=ToQuNxvWCS00We22b4WvFzbjWsFm90sAaGVlSiXzZ6A=;
 h=From:To:Cc:Subject:Date;
 b=N0OGot8XgN/sgaRBBPtv8sAmxBbjCRQT9O8f739VgP6/PefDcz4qn4+sQQ4buhqA8
 fAc/X2jePdXNNBWmTWvgbUp9Ryp8kHWEDgJmdzV8ZHE8c1YY413djR6ZWGI8tjM7GY
 fQLYY7JVDeWvBPzsWhh3RHmI0aLvzF0lmu23syr3EuHsiPzq+pwh17fxnJCmfsb7/j
 iuwSEeqSG/cl3+zCv29bZ+NSC0beKhU3a8viZBb92BUsu6ZKRr/ioSKfkXVgzCf4ft
 vipwGXayXPCFv1AUaJfDRHr8JmJ2AbFb3IS6GFQko1QKSbRwVykQrP2aT2+cJnfe+V
 vbfQ3xCVLrLbQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 09:19:00 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 1/3] drm/amd/display: Fix an erroneous sanity check in
 get_dmif_switch_time_us()
Date: Mon, 29 May 2023 09:18:54 +0200
Message-Id: <e0a2240f863279b65a1fdc7f8c27ede9f8e37893.1685342739.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 May 2023 13:50:27 +0000
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
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is likely that there is a typo in the sanity check for 'v_total'.

If it is 0, then 'pixels_per_frame' will also be 0, and in this case,
we also return 'single_frame_time_multiplier * min_single_frame_time_us'.

So test for !v_total which looks much more logical.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 4cdd4dacb761..091f0d68a045 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -683,7 +683,7 @@ static uint32_t get_dmif_switch_time_us(
 	/*return double of frame time*/
 	const uint32_t single_frame_time_multiplier = 2;
 
-	if (!h_total || v_total || !pix_clk_khz)
+	if (!h_total || !v_total || !pix_clk_khz)
 		return single_frame_time_multiplier * min_single_frame_time_us;
 
 	/*TODO: should we use pixel format normalized pixel clock here?*/
-- 
2.34.1


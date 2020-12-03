Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3489C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 20:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424E6221F2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 20:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424E6221F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBAE76E03D;
	Thu,  3 Dec 2020 20:15:39 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C186E03D
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Dec 2020 20:15:38 +0000 (UTC)
Date: Thu, 03 Dec 2020 20:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1607026536;
 bh=dQRaL6zjtBhuQnId89EMhjdrob21NccxS7MUTMVUGxs=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=bbeULpfNkLDrDT3LsTB9uLUNdg8eCf7rQG5gZ7Mc8gzpBO1N0XPiSYK9R7FRGFIK3
 1dzwbEkH7RGQzoF6sHirsu0hQQdPZokjnYR3i8Sby5jqPdsqxC6aoFvAM9NTkS8lI4
 Gy7r8XafCXE43GCD+iGTcaa4OW/1OmGOQUn4JzGgAhSsgldc+Ym0jgSJCSwi6EVYH/
 7ujVhScAITtp9c287xMr+R3Oh8vidcv9TbOWQD04lVmQ4XuumKt6bkEmP96WaN3AVr
 hJY5c7b4xPnb4tUghHvlxw2gS+ZBkXixy52AWBUUw+JTTu7s5u3on4RgnP4rVZM3bu
 saddXKaO8Uk1A==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH] drm/amd: print error on convert_tiling_flags_to_modifier
 failure
Message-ID: <j1fYvGbEZdykS0AhDWeyCo79c5aqNmrQBIuTcljx8@cp3-web-016.plabs.ch>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If this function fails, it means the tiling flags didn't make sense.
This likely indicates a user-space bug. Log the error alongside with the
provided tiling flags to make debugging easier.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 2ef9734eb119..467ff1655341 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -901,8 +901,11 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 	if (dev->mode_config.allow_fb_modifiers &&
 	    !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
 		ret = convert_tiling_flags_to_modifier(rfb);
-		if (ret)
+		if (ret) {
+			dev_err(&dev->pdev->dev, "Failed to convert tiling flags 0x%llX to a modifier",
+				rfb->tiling_flags);
 			goto fail;
+		}
 	}
 
 	for (i = 1; i < rfb->base.format->num_planes; ++i) {
-- 
2.29.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

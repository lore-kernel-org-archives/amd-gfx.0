Return-Path: <SRS0=sK2M=GF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF743C433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Jan 2021 14:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260B622482
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Jan 2021 14:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260B622482
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966048979D;
	Sat,  2 Jan 2021 14:02:18 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261A689580
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Jan 2021 14:02:17 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id r7so26448098wrc.5
 for <amd-gfx@lists.freedesktop.org>; Sat, 02 Jan 2021 06:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o7zKydJb0Dcw2Io6v+je4B87Ru1VW10/8CbqarypUlc=;
 b=ZMk7e3sBGmIkoz2Xsc36XN4Gp0GUKT3ZbdwVUvd4NHh5R/ImNgVCBkaN5TBJV9AKFO
 /W5BuNuMN7mCXAbHlXcEDdp91QIJhryd+pvjcsQEy7Lzues1An4W39KBpNU0Kyl7AZFi
 1WyKTGJN3Ol7gEPl55LQlMUUoaPq9WeTvG1rQAcSsrFSDED3aVwNquILafswg0W97g7Z
 OsHa/v8a5zNAo7av3WvzmXgXrIh9O0FTl9m9lYkEI3ptaGV4Hfxemul8EjJrg3rOxHze
 M+mRYcGvZWEb+N8ovwhaCuEvhLZsPliziyZA9YkC8JhNR/vTcXWwVaOJf/UtoSRdrM6q
 8LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o7zKydJb0Dcw2Io6v+je4B87Ru1VW10/8CbqarypUlc=;
 b=TZ6UUR3Sot4qG1lGDK7JPDOd7o0icbrVC5MfvQv17tYDBrSvxM9ALLnxoXvN1lt4oI
 Jo1Upzcpy9rAOfOieoB1FGS8Sq6ojy0iynEICpK6Tk4BYMiPmy0kFw6gYKIRIvZLODJc
 nGuEhDQEUmyTe3KOLnmLXRh9CDuVokTpN0bJE0Hi7ZY6CsSf5B0UxanQQRFeVO2kngJq
 IiR/sy46mKCZigii6d/8AzOyEiDYzEIDSjjm+IAmXfTAfOH6XDB5/RXQtPmtXrfE7gBL
 BTr3BehmmQ60zZ+xT5S0UEjzNkHv4Ck5QxYbpXN1qhd/jl7nvH4gyNqMXsRgzzdnSYiR
 Qjog==
X-Gm-Message-State: AOAM530MtDfu1Tp3Hzk2D4Tb0nJGXLmsaRDwboD3DTvKzRHJt5AVxxut
 DIGdjd4szBoPSNU/ko7tEEPiqw==
X-Google-Smtp-Source: ABdhPJw0HQuTYaIfp0n4UcVwK7cHb10Oi6dDLM4N82ru4gYFeAJhwA07gykh7kCKcwShKilDJoUCUQ==
X-Received: by 2002:adf:f88d:: with SMTP id u13mr74567521wrp.161.1609596135709; 
 Sat, 02 Jan 2021 06:02:15 -0800 (PST)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id e15sm80603402wrx.86.2021.01.02.06.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Jan 2021 06:02:14 -0800 (PST)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Check actual format for legacy pageflip.
Date: Sat,  2 Jan 2021 15:02:35 +0100
Message-Id: <20210102140235.514039-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.29.2
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
Cc: mario.kleiner.de@gmail.com, daniel.vetter@ffwll.ch, zhan.liu@amd.com,
 amd-gfx@lists.freedesktop.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 alexander.deucher@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With modifiers one can actually have different format_info structs
for the same format, which now matters for AMDGPU since we convert
implicit modifiers to explicit modifiers with multiple planes.

I checked other drivers and it doesn't look like they end up triggering
this case so I think this is safe to relax.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Fixes: 816853f9dc40 ("drm/amd/display: Set new format info for converted metadata.")
---
 drivers/gpu/drm/drm_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index e6231947f987..f5085990cfac 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1163,7 +1163,7 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
 	if (ret)
 		goto out;
 
-	if (old_fb->format != fb->format) {
+	if (old_fb->format->format != fb->format->format) {
 		DRM_DEBUG_KMS("Page flip is not allowed to change frame buffer format.\n");
 		ret = -EINVAL;
 		goto out;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

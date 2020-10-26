Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65FBC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 14:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFDF20878
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 14:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGIbfHM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFDF20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25B688C07;
	Mon, 26 Oct 2020 14:30:49 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5D588C07
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 14:30:48 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id r7so8466653qkf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b2AkHHAA4Al1UL8ht6GUvVwg1qlOzoz8XCDA3QXImvI=;
 b=gGIbfHM/t+T2VY3yt5mOa57S5XfUV5kGAf69VJipEfRm3tPSS1wLXCRF8VmaUbI6CT
 zm1wzClApem5AFRJxeZkY6MDoXiwT1a3cz7lqPyltq87kIfBIdLu06ja1DQ6dzusaI0G
 nCRkFxEuB5x6JafIBj5jJnNwE7lS5aVH9H3gja2tZaXYcAvylSVUgTF0Q7Qm9aKV0XB3
 /XwXFQzhC5loUw6jK5NpL+I+uIFMzVog/UfvrJgoh6ydxVUuQNGYNMWfEUDxrO/G9sJR
 lNJkI97FhDHmsH+MbAkEGDO30CFL8u1smZjTqv9Sx9z0ibPhXYzL9fp23GHZ0A2+iBWC
 oHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b2AkHHAA4Al1UL8ht6GUvVwg1qlOzoz8XCDA3QXImvI=;
 b=GUMkD+xeQNLGvR1fTVu1hHII/kS7hdbE5ZXQ7jgXrA3G1Osg7qyuULqMVO+Dep/3Uo
 m02d869o7lRreax0y6UJnAHqJThrnbLmC2hCug5Oj+pPUjTmZu6Z+qW27UL98Rf3WLDu
 xTJB9tIOGYNRfICiM648i3zZdOLf+ve64/5Yk9GpNGpJFl01dvDqN/08IgOsdMauWHl+
 hh5ex0qBA5yC2+Away62TE5ViD4MZ/l52g7ve/Ufk0qxM+XyJAIPjyGv6qsh8TO06QUw
 wF9cfADXtK2Tx39ru5KGPaQfZ1/GSAmMjrI3NmkFC3ZfThXVlUy3twIHnMXxHE/2qSxi
 JIHQ==
X-Gm-Message-State: AOAM531MvLz0Wk+7zIeGWLiqPKK3nSfURrqJ4sMnuoEqyaw3kFtKonSF
 dty1YX/4kZCmN2moApFW01BCnLW16RU=
X-Google-Smtp-Source: ABdhPJzdmTCp6a1/kFpaWA0Z8S0IEGB+9B9uAjzOmsahGymLajTTvc8XHr4+StLVOpq5l39zVBaoFg==
X-Received: by 2002:a37:a38b:: with SMTP id m133mr18423215qke.45.1603722647228; 
 Mon, 26 Oct 2020 07:30:47 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d129sm6489689qkg.127.2020.10.26.07.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 07:30:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: use kvzalloc again in dc_create_state
Date: Mon, 26 Oct 2020 10:30:40 -0400
Message-Id: <20201026143040.887736-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Alex Xu <alex_y_xu@yahoo.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It looks this was accidently lost in a follow up patch.
dc context is large and we don't need contiguous pages.

Fixes: e4863f118a7d ("drm/amd/display: Multi display cause system lag on mode change")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Aric Cyr <aric.cyr@amd.com>
Cc: Alex Xu <alex_y_xu@yahoo.ca>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7ff029143722..64da60450fb0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1564,8 +1564,8 @@ static void init_state(struct dc *dc, struct dc_state *context)
 
 struct dc_state *dc_create_state(struct dc *dc)
 {
-	struct dc_state *context = kzalloc(sizeof(struct dc_state),
-					   GFP_KERNEL);
+	struct dc_state *context = kvzalloc(sizeof(struct dc_state),
+					    GFP_KERNEL);
 
 	if (!context)
 		return NULL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

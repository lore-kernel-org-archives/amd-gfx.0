Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56511C44501
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 12:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E925D10E89C;
	Mon, 13 Jul 2026 12:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WHP7+GHV";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B30610E62F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:58:49 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493ec555a26so20412885e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783947527; x=1784552327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kyn9O1pwIsT+lRxrQav83mRh9kcKOfr6CDA7+SuVIJE=;
 b=WHP7+GHVnWixOCejhTSJUE9pssdcTV6O7hk8xia5DhJO0GTD55O8XTjLOqSpjwX+V/
 o2/ywQQOhKUVkBOxy2UG7Xzkj2WK5AtAM3o7rI4wGTEwt5gAVvjMOXFxRqJ2LT91ynP0
 TdB/LCH0n5e1thbq/XqlEAapDccslHaN7tufHBeV3+L5DI3QvqmccVY/Lj6p9b2r87ie
 /ELTaKSwsfhmhqgU1uI5kTpMURAIwo4t8FRxswb1ZsJicFM3Nvl9qyEYc8HNfAmWJgWI
 SoHMm/HrVDWPriuL7h1DA7hZHQN9ijMQp8ks6ArcnW9n8SglNnFAmKxxfiOOO6nvuGEu
 FsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947527; x=1784552327;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kyn9O1pwIsT+lRxrQav83mRh9kcKOfr6CDA7+SuVIJE=;
 b=IPu4b4XvcCTcvuqgaZljXq2zMAxAMTFlycmhkUHKGhOLTrjeDBK1euerzat0VSskRi
 FyEm1Zv5/Kj6Z6SAnCGFPLtzt01bXcchWKQ9II0LQHp109YROXtVrK02fI5oHJk12Nst
 KSk4qf/SAUu1hbvufdGnWwK/+Vdk+0F6lvrl2EHpiRjDvX2SgbtVsI06SfPfIW/hbZFW
 d6yKh7WLD2gH2PixUf+BYnakelOr62ZtYE1/OeXJnC2jU2f26gWPZZouda2emNse//9V
 QZl+sdXXKHQRWhjFd/7cTIKHchBd87SbAl92AopHMKikK3xHSu2tRbxWtWOnY+C1h8Mm
 juLg==
X-Gm-Message-State: AOJu0YzpipF1bYHuwxbZdaD15Cx4ehtaF8oONfTk5dUpN8kKKdXLTGx+
 pCLhHqHZ7mM9AwQ2eHXIkL4Esr0qE9wX7o5GGSbnUw/hGoXA5Vb8FrLjKQFfBw==
X-Gm-Gg: AfdE7ckQfUgk+6zOO+B/bKUcm18/tDlGRxq9+dS1yPzRjDoR/rhfmM+Q4jP+1YpzTZT
 3Vz7NU4/J1ZyUzTJ2ztoXMRRdwP4tdyH+FTfajq6MouUjEzUd/EiesPloznsi3MrmhdJj1QlB0V
 kfbHmTQuEapCf4QZN40X5vpft0pa7usfjX9JVcl2S6PSke21V8MvCa4p3348fBY4Bt4qIGFYFYm
 1S1yH/gDv25nb0m7tU0GJ72b8t0IojQyV00IM6UX4VjGkPr4bdWRrSnRd6wLN8uy7joaLKHsOkW
 jtMnFw11Q+lT5Ow0ELOIewvqPPaHU91AN9CId9a0stImdITGUu3o4SBTYLcVp3P6VozsLyVbZaC
 lSlUJ5pWv3keIew6JKo/miwNvFbyYmr1ZntsHFvubcPxsLQa72wUUDSuHxWO2zYHx81azevxxEl
 oJi+ris+oMuUhpikFmtVc0ClTVppjiUjLCUqTumxV8Y1ZNr8rY0scmoQ==
X-Received: by 2002:a05:600c:348e:b0:493:bd37:1cdf with SMTP id
 5b1f17b1804b1-493f87d6219mr93703245e9.2.1783947527447; 
 Mon, 13 Jul 2026 05:58:47 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm80456918f8f.10.2026.07.13.05.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:58:46 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/9] drm/amdgpu/gfx7: Return error code when compute ring
 tests fail
Date: Mon, 13 Jul 2026 14:58:32 +0200
Message-ID: <20260713125838.30607-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713125838.30607-1-timur.kristof@gmail.com>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The gfx_v7_0_cp_compute_resume() function should only return
success when all compute rings are actually functional.
This will be especially important for soft reset which needs
this to know whether the reset was successful.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 9c4b3ac27e1f..a1a9f3fc4567 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3019,12 +3019,14 @@ static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
 
 	gfx_v7_0_cp_compute_enable(adev, true);
 
+	r = 0;
+
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
-		amdgpu_ring_test_helper(ring);
+		r |= amdgpu_ring_test_helper(ring);
 	}
 
-	return 0;
+	return r;
 }
 
 static void gfx_v7_0_cp_enable(struct amdgpu_device *adev, bool enable)
-- 
2.55.0


Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F84C00454
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF9720663
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Olt1rhlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF9720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665F36EC18;
	Fri, 13 Dec 2019 18:49:07 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A0A6E2ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 18:49:05 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id p2so146483qvo.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 10:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uh/gvkL9myFYQ2H9uWVR23BQNhi7IaX3i8MjsnmnbOM=;
 b=Olt1rhlNFBQDSJp2PqnblbZNjg2vh4tq/zryapbR/9EIoPJiNU4agP2t3sXIvwNkGt
 lpYoRjg3XGGivH/DWSzyKBj55AP5yk8gwDoys1icaZiGbWjunrjS/DwjUKOjwKqvIUo8
 EXUnfErnM/OaHyEb73hXl8/AFNlnT8EjrXN1A8PgbplUsFTR6UqUbiM9C0VVD8OrjtKF
 9+53jQePvxdDrgDh+iFWfiSj329V2/uzhV1ScOqFOcS2tikbpSM+W9+e5QMeg6HRDN/P
 G+puCoAaL2w2BrfkFb9eIeStBpiuY+Ida23qL7oMMvZQboYQDuszWNJtbPLS7a6mgG3u
 sLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uh/gvkL9myFYQ2H9uWVR23BQNhi7IaX3i8MjsnmnbOM=;
 b=QRRJwvx0ogHLAnz729HCR8gKUbrhPafoCULoLyuc/TLIWEhj8ZMq8PqPa65GtPoTOd
 rsSjAM1R7g9jWyP9dvP4S2fu/EW6UEjT+zF+d59C2DZi60lietn+zQ+KFcy+HKDFg3h+
 o8ClGWRQtKGgocql4thB0hvpdt+6Ynl3R0B/G63nmhYYtK1gVDeSCi/lmtW/ZcA+/OSQ
 0WHAcY9uDhWUkSqtKNo+b5j4dgy6cCT85fTqKjR7DVCUQcGoGqPHz7hjhP1PKsGpWMVw
 AtAHOv7h/AIn+9bpzeCe0zGk9WXC7zyauLBW6Vfs9ld0QuyR9ychaXXGIxOcv2WsPDpA
 latA==
X-Gm-Message-State: APjAAAX6Cw2NKUr/WP3AoDidahraeZwdA65VTkV0L1c8yMkB96ed6ip+
 77NOOOYN4yI/mE9GVe7R4lJJitoX
X-Google-Smtp-Source: APXvYqxHpGWwrTlyqoF/n1wTt04w1UKsXYgq71pHlNEb+onesDrDRifMsGTrvj8ovMNhy73LXQRKzA==
X-Received: by 2002:ad4:58ac:: with SMTP id
 ea12mr14833607qvb.126.1576262944100; 
 Fri, 13 Dec 2019 10:49:04 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id 200sm3098563qkn.79.2019.12.13.10.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 10:49:03 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/sdma5: make ring tests less chatty
Date: Fri, 13 Dec 2019 13:48:54 -0500
Message-Id: <20191213184854.3901-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191213184854.3901-1-alexander.deucher@amd.com>
References: <20191213184854.3901-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We already did this for older generations.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 64c53eed7fac..1b502396fcd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -907,16 +907,9 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 			udelay(1);
 	}
 
-	if (i < adev->usec_timeout) {
-		if (amdgpu_emu_mode == 1)
-			DRM_INFO("ring test on %d succeeded in %d msecs\n", ring->idx, i);
-		else
-			DRM_INFO("ring test on %d succeeded in %d usecs\n", ring->idx, i);
-	} else {
-		DRM_ERROR("amdgpu: ring %d test failed (0x%08X)\n",
-			  ring->idx, tmp);
-		r = -EINVAL;
-	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+
 	amdgpu_device_wb_free(adev, index);
 
 	return r;
@@ -981,13 +974,10 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		goto err1;
 	}
 	tmp = le32_to_cpu(adev->wb.wb[index]);
-	if (tmp == 0xDEADBEEF) {
-		DRM_INFO("ib test on ring %d succeeded\n", ring->idx);
+	if (tmp == 0xDEADBEEF)
 		r = 0;
-	} else {
-		DRM_ERROR("amdgpu: ib test failed (0x%08X)\n", tmp);
+	else
 		r = -EINVAL;
-	}
 
 err1:
 	amdgpu_ib_free(adev, &ib, NULL);
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C41D61015
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 12:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7137E10E857;
	Thu, 29 Jan 2026 12:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CEA8pvBe";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADAD910E0F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 12:53:31 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so589725f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769691210; x=1770296010; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eCatf3kZ9R2kEtEw/Wv+LNz85pHjPaNXxk/Iveih3JI=;
 b=CEA8pvBewfH9cRStZ+G8J+45D1CEyjZ2JhYIIXBcdXS57GrO6d50Fc6pIpUkhmu/SC
 puHP60WA3WS8kHTBd7IoioNYg3mWK4VNOD2Qj6nfi1JlGLbG/Tj+8k1dUSBEvjKGlUyY
 NElv7SZp5SK9oe1gS3DVr4eZbc3uqphUgR5aVZSGhaTnjMEQz7OkXanaIU11+pkBsDAO
 5Qg+CvMSlZV5GhRNLEDNM6r3gtvXW9DjOkAzf6hH+mo7MsXFepaSvvSPlVU11osyVGAr
 ns0CqMSBOJhk4OiHRRG0ONgtKwA7GR1GBSE/wei3l1K23V7fm3sixX8yP7BDh4kUwjiu
 0HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769691210; x=1770296010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eCatf3kZ9R2kEtEw/Wv+LNz85pHjPaNXxk/Iveih3JI=;
 b=mkepmw4xTgbkoXI7rEqq9K17iAVVjGvtdb0TCYOnMWA1XUoEWaBNril8oaDK+mUtBe
 Sm++HgaJRfPeiptdRvjzORgUXIWczTmxOwtPhs207HC+jDvBQuRV1Ad6U31h7294adIh
 0AkXL1dVIgSVR2kdq65eNgV/TLEtSD5JQvfuTRjjb/fOQ67X/se83GHqMcW3pooxjP+k
 kjPpgq8xXtohYurbpp6KuUFcIW2O4qPDuE5+LYgUB7FFai46jDzHflJWSdcjopydSMvz
 S2iNSV3lsH3UK1hXBs/fQRJbKZGacMyXh1F1kJV6seCJ5t1mltjheWt4F2au9jdaExlC
 kE1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Yjt+jaoO6Dz7pBRahfmQnZc3Wd77QOzfMK1aTnq8eo6h8TqQ9VxFykQHPAKwOIRfU1gCTXpu@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxv04r9rbuwbPUqyVaAOEekYzRN6wd9x6gcNPvDbMh1vmCOYMB2
 88olof5QJZ8p0kOt3yPi48cpwr9GL3gkkmap6a5dzx/L4Ireb5NS6WE7
X-Gm-Gg: AZuq6aKhvf9axMiN8kgYMZ0vl8oyZPpc0pvG+yQtgb+RscyY77pjLJiKdawzsKTvRFz
 LQJp7vSdx3+LGgOB83QCOKgXtBLxZjp+wpcz1597okD4OHy+4W/6eDeKp4Dk6xzwtrXDLNZchi6
 7P8NHaH4V5JRpg0+zIQQqZFfKKSdaIvO4WjjyseNR1UXiqUfVvpV1f3LWY1eon5cZECduO1wW9a
 qL1NL4QTRnnZ/q7UITz+boYxQvzm5lJUr6tTwjbMhu0P1+1s6S2lk+17dj3BGqGYvqDZbSYAq22
 2ci29A31Tmv7Dt+Bp4O0ktryxnbjJonsITQBBeIUf80PZLJ9uanlX0jt0a8RYF1Of/Y45CcKtFI
 kyagZ67qp//+jYlT4mw3uIgiUW+zAUs446XLoVa7QtaVij8UxR6az4RwVZ+wiUr0Zogh32OcdkW
 icSeKIGMcXen6uh6wkjZZCrRBR
X-Received: by 2002:a05:6000:22c9:b0:431:8f8:7f24 with SMTP id
 ffacd0b85a97d-435dd0b8222mr13803206f8f.39.1769691210039; 
 Thu, 29 Jan 2026 04:53:30 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1522:e200:97e2:f9c5:ae8b:8e89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354114sm15442569f8f.42.2026.01.29.04.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 04:53:29 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu: fix amdgpu_userq_evict
Date: Thu, 29 Jan 2026 13:53:23 +0100
Message-ID: <20260129125327.11786-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129125327.11786-1-christian.koenig@amd.com>
References: <20260129125327.11786-1-christian.koenig@amd.com>
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

Canceling the delayed synchonized can deadlock!

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8feeaeea1c36..af3922e9caea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1337,13 +1337,8 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 	/* Signal current eviction fence */
 	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
 
-	if (evf_mgr->fd_closing) {
-		cancel_delayed_work_sync(&uq_mgr->resume_work);
-		return;
-	}
-
-	/* Schedule a resume work */
-	schedule_delayed_work(&uq_mgr->resume_work, 0);
+	if (!evf_mgr->fd_closing)
+		schedule_delayed_work(&uq_mgr->resume_work, 0);
 }
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
-- 
2.43.0


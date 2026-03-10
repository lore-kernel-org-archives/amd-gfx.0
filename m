Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BD1FD4F16
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 19:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7810110E2D7;
	Tue, 10 Mar 2026 19:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QHb51L2r";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAB110E2D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 19:13:38 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4853fd7b59aso14678465e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773170017; x=1773774817; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CZu4RikCmEnYYj73gZG+UCVZN1HPfdZ8WGgpejbbzKw=;
 b=QHb51L2rLNlO5SvVgSQCU13osYCcvT3Huq5XaYOtjiICFFbFCndEwkPOscTn+Znm7A
 7rT3clxsf0kNUQz2cQWgbd/lcbrmEXgUu6s9SZZ3odEhvbmJKLG2YUhDg0RW9AhKXSQp
 Y0fiOLwbJ6YSYmHV0+qQsQiL19R7OhdtVLMyVslouusBrwGStWsRcbpHeSpGWB28brlG
 FMh6/sKCKNbT2hFklI+P9HI7hiIXjB2uqrjI7teJDdl7+eV+kRGg5WIUsT0zi0LsWEIe
 F1h3fE676Mogaop5M3oOoPd4wZhXJ6i+l6q065qEx/IMaUOo9RtP5szWwCVpxCk88gM8
 SQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773170017; x=1773774817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CZu4RikCmEnYYj73gZG+UCVZN1HPfdZ8WGgpejbbzKw=;
 b=B3wdtYHq1wOnqWVdaSXHliWhcnlyU9IVP5NsXZ0nkR4wqyuJkBQRxq0h5YfllpX2mZ
 lZ8rSUY5C/qpuwPxLjD4G6cXDQaGkJm7fO66IFRg9Ewu435hVBMmqrd5Y8IQybV2FGB3
 fd1G1d9Y9Uun92z5k+QV0TxmYd0PoePNfQziDHt/xE2cXSZNFVFE035QyHWn5rXtq4y9
 uUiNTjM7rl9gtm2pIyQJ4UFqa3zleVv3D+/DbN9XEnQwX1UCRYcrZeL92Zw1v/+pTmxj
 SO4JmZTUYjdk8JDGvfyS30oxlTI4e5KrENeD+/XKoxoOQC81N85IVujTpHHEbfbgVK9t
 URKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuCbCGaKZw3gJXY8/aZS2sGCnWjGeod02/NAypngvkrxgQFMlVB6Me8g8/jKtZ0125tGN+DBp+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUPdf0IKvyPQa7XffgXTt8yCIMyJ8N1Ydu5mrU2md+OUuEv95o
 RB3NjOMWni2FGLWW9V6qGsVkQsx5daee/rzwJdK2rx9xNEY9IUdvuq3t
X-Gm-Gg: ATEYQzx1rdMtq/ReSV1cv7NQsIsPfxF6rQkSSNlHpg3eiLHVUWxM3VYKCcDKctrbe9I
 pJR/4Ylwqi2Dmk6hf5f/Ym3ITdUHy83AKEp/rKrDdxvghAQLfYqY5D/0ek/PgwLc+5GIMPTEGzK
 Di+OVZmAC8cDqM/XLMek7rESZFLFXqAMeoROCc5yVfJgCunlblTN//oZl6kCy71QFEIRDQ1A96S
 cRb+AGWVvmtrBYO9DOgf52Zm91C93puGdrtJihMpBe0ZXdx2go8vlt3Se/qRbAW2r398T80fUiu
 R8tD13LOA7LmzGW+LxDZA4P29vGcfvEtJaz0x7SVAWATCmyWhKeaPqW4uESvpup8KtF4svLQU8n
 Cr7L1x1rEKDkOLdN8qzw30QDoH0hcVUSkkVrFtRVzDeFbKFxX20nF0Fgft0Xce/oLs/Le/H8CNL
 vU4rrlLibIYj4vNJ9gP+i8ASv+kYxkFU5AzTY=
X-Received: by 2002:a05:600c:1e2a:b0:483:c771:10e with SMTP id
 5b1f17b1804b1-48526957d6cmr257387515e9.20.1773170016805; 
 Tue, 10 Mar 2026 12:13:36 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d0:d800:5198:df3e:59ca:cf4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a3079efsm2601625e9.7.2026.03.10.12.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 12:13:36 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/11] drm/amdgpu: annotate eviction fence signaling path
Date: Tue, 10 Mar 2026 20:13:25 +0100
Message-ID: <20260310191327.2279-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310191327.2279-1-christian.koenig@amd.com>
References: <20260310191327.2279-1-christian.koenig@amd.com>
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

Make sure lockdep sees the dependencies here.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 6598823ec619..e5aaa5156069 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -67,8 +67,17 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 		container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct dma_fence *ev_fence;
+	bool cookie;
 
 	mutex_lock(&uq_mgr->userq_mutex);
+
+	/*
+	 * This is intentionally after taking the userq_mutex since we do
+	 * allocate memory while holding this lock, but only after ensuring that
+	 * the eviction fence is signaled.
+	 */
+	cookie = dma_fence_begin_signalling();
+
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
 	amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
 
@@ -78,6 +87,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	 * next fence.
 	 */
 	dma_fence_signal(ev_fence);
+	dma_fence_end_signalling(cookie);
 	dma_fence_put(ev_fence);
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCDACCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A774F10EB99;
	Fri, 31 Oct 2025 13:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BukoC9gv";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96A310EB8E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:11 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-475dc0ed8aeso15411575e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918310; x=1762523110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOlOmqRHN76msO6RGrvDtrbpjelQuT0RCQu/MYKK0XQ=;
 b=BukoC9gv8Dv42OnKCeDQuJqzANe524FOfrRtY0Pl3wQQ6pwjm7xfh/4qTArulFuClD
 p8wi1/zFMUN8qQ8l9uzq7SRYpYN2MXmUHFnm8814vwUgFCNuPcJxLTtn14E0Ub0TNIku
 Misk2SqxD8vQedXRUCBwufVscWeRECdh1MVUwYTa5H4N2Sp2LRkCFNED+KOIBKdhENqr
 x3ns8BZelCySn0GaSbTxWde858mc79moPQ6O7YaruxMETP/3csqrjtYhvtKV93XMlNvj
 GRX6oXrHoQT1tgQaGCJp6lmSbVhCTO/TFrp4TWLsATSikhgBbMQWAs5Ma/q4MedM8hh5
 Vniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918310; x=1762523110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOlOmqRHN76msO6RGrvDtrbpjelQuT0RCQu/MYKK0XQ=;
 b=stTKSqAILgfZGhGSRodfWFFHf7klD14WwW2TXr99g+dAfWFf2rYz6BDwAaSPJKfY9j
 khdk8C/hScA3j6A5z9DI7189x4ztrKZdTlNdg8uFnfM9y1tutpn/7oGi7dwdBduxVD4H
 CLwuvvBC8jnP4BBYgFvLXP2T9EfwxKwLFz0w87xZrCflKZCgiF7gbfN+vcZAu7+RG20s
 uSEKwfjg5FizJbiiHH8G8JsTo8/sC8x/c3IFNZbSCSXlxDlGx6lt0sf3zyk0/5KkX9Q0
 3bUmq3N8NwYkdLIiIb8WngITIVzWiO92d52freex5wjpdPhc1pbdbStiQW9HTUxu9lFH
 KlYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYC0gWL9b/6CpUjH45LB3Ia/rEgdV2F5wOyRCUBkYfxk2dQgR6MCxpO4nv/4WI6O7f6WDyWpwi@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPFP3HzxTB1U/7rkm++dhQGq+NG4fFThvWiTKKfVdzw9pcNziy
 HW6ZBDbfL2dosjB/DuI6+LnCS8AbAfPdgNCsS6l418ZU8Up9mQUCmoF0LySueX/qQdQ=
X-Gm-Gg: ASbGncu/a1hnTbNXxJlqpfW2+E1yzwLBctOgImkSSE9eVfDru1JQOgvIBdTlC4LcQum
 gTJ4tSUzEqLcJfKotsrY/quZjAC0YxgFVKxTw3ojyfUHX+h5FDoKDPGXmM97XlipH+qSzhB5knf
 8Rl0d+iZIGst2L22T6kjzTNpr+eCgw48iobLZieCEW7JoWgMvCElGwyseMHJvxGJAI4W1GNMyJk
 BST0kFWmA04AwyXLDVzL3YAaGvrHWZ0P0nDlZrznJ+2i7fueDr1X52V0AaWPG+YcvAzTaTu//b/
 kXNUVKBVfVhBXuYJHfpM16mLJyqoTSFm0Tq0ABE/MKNivACVj/Ab/TBZwoSb6ix1jS4EuYeSXZ8
 YMYaSn6IkkdfpZvsfrKqtTJqWUxELdrjHVP8lsa6jWPgvoUfNhuuqUdq19/oR+ne9oGgM5Wrtks
 UpEHCHnulrDoVHGuN/lZut4AD3rOgIDJymVVM=
X-Google-Smtp-Source: AGHT+IHlnv2fTY4fjsc9w/nk5RUsuImJ1PUsHeNvrc1Jr0wa0yIqxIsPy0JmrOK+TW6xR8vVjDZ2hA==
X-Received: by 2002:a05:600c:6389:b0:475:de05:6611 with SMTP id
 5b1f17b1804b1-47730793c68mr35813385e9.7.1761918310069; 
 Fri, 31 Oct 2025 06:45:10 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:45:08 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/20] drm/amdgpu: independence for the amdgpu_eviction_fence!
Date: Fri, 31 Oct 2025 14:16:47 +0100
Message-ID: <20251031134442.113648-14-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031134442.113648-1-christian.koenig@amd.com>
References: <20251031134442.113648-1-christian.koenig@amd.com>
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

This should allow amdgpu_fences to outlive the amdgpu module.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 23d7d0b0d625..95ee22c43ceb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -167,9 +167,8 @@ amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
 
 	ev_fence->evf_mgr = evf_mgr;
 	get_task_comm(ev_fence->timeline_name, current);
-	spin_lock_init(&ev_fence->lock);
 	dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
-			 &ev_fence->lock, evf_mgr->ev_fence_ctx,
+			 NULL, evf_mgr->ev_fence_ctx,
 			 atomic_inc_return(&evf_mgr->ev_fence_seq));
 	return ev_fence;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index fcd867b7147d..fb70efb54338 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -27,7 +27,6 @@
 
 struct amdgpu_eviction_fence {
 	struct dma_fence base;
-	spinlock_t	 lock;
 	char		 timeline_name[TASK_COMM_LEN];
 	struct amdgpu_eviction_fence_mgr *evf_mgr;
 };
-- 
2.43.0


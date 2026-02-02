Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ECDE73164
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 12:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8313A10E4C7;
	Mon,  2 Feb 2026 12:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e4KpUrcH";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFF710E4C5
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 12:51:58 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so37410365e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 04:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770036717; x=1770641517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CZu4RikCmEnYYj73gZG+UCVZN1HPfdZ8WGgpejbbzKw=;
 b=e4KpUrcHzeXKMnB10JuQuVCquR7nwWZubNdRpbOXqhkRYDUqD+6mA/J7yRRjowtt5G
 LUbaID7BvuxXgzBvHUvb/R4JwxivMShxVNzd1/H92UMHclZFQkOsmks+wJonv7xFx1Dz
 qIW8jYO3ysAZuxAICOUtnX/J67lgvRc6+eEisclUNz74bfTDPyPjAiJ+GvK6tnNO1Rbx
 JdXR0O1aR5FpMlWoGpGR8gzKBDLY/PiW1OHPQ17nXEz8jOFLSFMRaiQUrETU6SOncijF
 CMxx2RdTWri7eaZMLR7mf37LB/pA7PtmgZQ7nmxt+eUwy2zv8GAnFa2OX++jWsUVOyaP
 1tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036717; x=1770641517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CZu4RikCmEnYYj73gZG+UCVZN1HPfdZ8WGgpejbbzKw=;
 b=Yug5JnOp97zY2NcrCc36K07cMjVvhAWktbMuZLRl4zZvzMpu7pb1ao+PNsULJof5MX
 IDcefsENjxshqm32V/jV4OU3R5TA9Km9M+uVU3WSxF+wZTv4pG2SY+NKJLfSMpZPAsF+
 FXAoPBZ+QyJu+uUd2d9MPkHBX5+d1zUe6RfdB8rv65RkA1DJCHKq5zX98HIvDqO7Tdnm
 qvToebsLMlkPsczrPGazuk4+hIG0H7PMd9qGJSxiFkLC6gTTUHC2vAZg8qrNwxfPM/bo
 ezZjJsWREryYpuLqn417qBFKjfPBZ8OtK+/TiaKnW/55ZDU4fmfk7crKht3Q0ilr9qrS
 auQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhtr30tKJOj+KCVxYA7dQWGBoSOgWvuQtw+QslwIqdA/HmKoASyu9gvAk7bFdueF1NU6x7sogK@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9bnendn4NrE3LiKHZxrfcfhkU7oinXXNyi9WvFIP7cm4zdlQA
 NSLzzmZZ9dzVb3nNGb8UvNqbzxBxtSVuTS2IV9pFOPURaBzDxILFf5A0
X-Gm-Gg: AZuq6aIUcjzrbpwWT9txnppehJfxtPdnrbZi1A2YGC4ljxmjvfG8WngtFqHWhm3Qezj
 mhWvt7P6lBfoCZOF49HDa2n8L7WrfhFRS98aPyxuF971nQc4JX2WRYkcUmsuBR8O6Sj1lVm76YX
 MQyTWQZFuii0ZcGVcA9EHM3UiQ5wkUKpTt6JnQt6blADUbEfTbuK2AXT+EUX2KCqT7jt+pk4hoA
 RqBe+LdyNYwI7EoRaIz3s2FmJ1EQs8gq1oPtk/671c7rMEzt44bK8En3Prscf6pnkLopDw0iDvd
 pSU4lRW05xR+ZmFeMT2S/z3rA7T3iq9/jjBYW4ivzkSRiep4DIRsRFGafG8YcVNGyxzwkKvVbH8
 00T/zvkA1dCjZUSQq6cmDliWHsxRSP3Wau9eTCTo9qrBFS/zTciURxtGBWviI+ZxyZGOhAe/rvv
 LEoNQu88up44Y+jxtuYgMFY5o=
X-Received: by 2002:a05:600c:34c1:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-482db491eecmr147287985e9.33.1770036716855; 
 Mon, 02 Feb 2026 04:51:56 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1570:8200:7824:9bef:268:2d37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482da6a042csm126165535e9.0.2026.02.02.04.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:51:56 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 9/9] drm/amdgpu: annotate eviction fence signaling path
Date: Mon,  2 Feb 2026 13:51:49 +0100
Message-ID: <20260202125149.2067-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202125149.2067-1-christian.koenig@amd.com>
References: <20260202125149.2067-1-christian.koenig@amd.com>
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


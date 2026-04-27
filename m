Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D79FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 18:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75BC10E8BE;
	Mon, 27 Apr 2026 18:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qNeE+idA";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F41AB10E8BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 18:27:26 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so127020955e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777314445; x=1777919245; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=efa/Nf5VaqVSS7sFfizXzcVpgmfDr73rqlHWioRm2Sg=;
 b=qNeE+idADxAPzG2fqY+Ow4fUBpNQf7RvuFT9oaBUpKRdh5kDgQ1Nqwyj/K0qaeM6Ru
 qP7fNUfYKgfMJ/m1a6pJtWVV6NDk8RqvwXPO+/PYVOlUHH2hWC3xr2z1M/SIv15Dd/Ce
 +snqAnI8hdiJttSQ4OLuhhSph808A7VwPiRV7NqmlZ6BUlPT4kvHhl317Vk6BdUHu7tN
 QotKRsUBFZ/WNGaJQ/EwXdsnZ2b6+aK8lOeoH61id7QX18LuO4Xj2E5UMQH2+3Ub7xIx
 6WWAQyzfcO0DwvPK9UzD9f1yv3zybs8/kE5Mlfg3kWI4VqW6RmMtnABe3gscbObIeGSp
 HMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777314445; x=1777919245;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=efa/Nf5VaqVSS7sFfizXzcVpgmfDr73rqlHWioRm2Sg=;
 b=SJuMNd2PjPXsg5oZ4y5SDgkUu5WxSuNER1XI933sdKNajxdEZ+h/LcgXxwXUkhzpbR
 CYOHQcAUwDRRzJsIXwjGLM6F4NPxndcQiVa9JYDNIizUIRJi6CDGtEcAvi6bEDKAPJAs
 13TlMpZ3ieQ4tHUT/ybJQPyRVSKQMauZ5vd7dAUkQOnuwXWHdzuGGoqgUNyYkdAwwFHC
 1I8wAE6fI02Ma67kxoFteEIE40NOEu+mg8scOnufcIhLzd4YdBZd9FAC3Zbu98l2qSVV
 2JGoIxZ96cbXobD2yUMpUgBCWRtJGOLTKye+OtV9CEoO7VfswgpIoSF0uLi08MwdzDZz
 a4dg==
X-Gm-Message-State: AOJu0YzGPYU9arrVmU0HqanJ/27DSf1j9zqbi0Afci32t2STdYtApwnW
 F2FgFcJTTROpMVGlqHHKpqp2UEWMArPW7+AYcTD9zzxUTDK1Cx0qQ+ud
X-Gm-Gg: AeBDievVpC+W4E3B+BGMLr+exSB53jFbTrSGjnUrzKZw/g/MoZ2LzJDrAZqm2GPwFtu
 xdCMCjuGBuHHQTOgsddsXn3qeOeMdxV8GKf7cLAEPAqY2aMmFuDUAJDRDaWYVYhwxYrilX6MG6+
 I9VuU3gBe2x025f452msSHFLBt47QMgIDu0DgGCIHJRgiZrpZ/UPlJ6wVJZX0Vtw75bN1HVRmab
 gJ2YrXzj5ZUeXzHxOrjqTEVGDjx5lCfjlRjZnrBhCavjZ1m5btjtQkk9RkKQBDhuMwdiwVeZ2qV
 /SFfB6ojeZqjhLRMlYs0Hp6DBhIuDrLwizNGM+2ANo5XTe1MweI+nQgsjeg52K4k5PPf5CpCssp
 RGcG3wenJQNn1Tp8gSbjD5twa4LC9TdPyrfC5bCC713jPYQa8IPga2feKhTKbu54W61pvCp6hE5
 njjlp+O0QYp3AHMtKpU42BvN2kb111NOLMz7i6Hp9UhT9OyTlAnOw5rsrd
X-Received: by 2002:a05:600c:a101:b0:48a:53ea:13df with SMTP id
 5b1f17b1804b1-48a76f45f59mr6410775e9.2.1777314445414; 
 Mon, 27 Apr 2026 11:27:25 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:153b:d200:96aa:46be:4d7:72d2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773af5c5sm6046165e9.5.2026.04.27.11.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 11:27:25 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] drm/amdgpu: remove deadlocks from amdgpu_userq_pre_reset
Date: Mon, 27 Apr 2026 20:27:17 +0200
Message-ID: <20260427182723.1715-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427182723.1715-1-christian.koenig@amd.com>
References: <20260427182723.1715-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The purpose of a GPU reset is to make sure that fence can be signaled
again and the signal and resume workers can make progress again.

So waiting for the resume worker or any fence in the GPU reset path is
just utterly nonsense.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++++------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 58b9477c0346..a34b1df513d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1510,23 +1510,21 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 {
 	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm;
 	unsigned long queue_id;
 
+	/* TODO: We probably need a new lock for the queue state */
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-		uqm = queue->userq_mgr;
-		cancel_delayed_work_sync(&uqm->resume_work);
-		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
-			amdgpu_userq_wait_for_last_fence(queue);
-			userq_funcs = adev->userq_funcs[queue->queue_type];
-			userq_funcs->unmap(queue);
-			/* just mark all queues as hung at this point.
-			 * if unmap succeeds, we could map again
-			 * in amdgpu_userq_post_reset() if vram is not lost
-			 */
-			queue->state = AMDGPU_USERQ_STATE_HUNG;
-			amdgpu_userq_fence_driver_force_completion(queue);
-		}
+		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
+			continue;
+
+		userq_funcs = adev->userq_funcs[queue->queue_type];
+		userq_funcs->unmap(queue);
+		/* just mark all queues as hung at this point.
+		 * if unmap succeeds, we could map again
+		 * in amdgpu_userq_post_reset() if vram is not lost
+		 */
+		queue->state = AMDGPU_USERQ_STATE_HUNG;
+		amdgpu_userq_fence_driver_force_completion(queue);
 	}
 }
 
-- 
2.43.0


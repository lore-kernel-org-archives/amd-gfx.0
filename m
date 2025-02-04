Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656FAC02197
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 14:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1356510E662;
	Tue,  4 Feb 2025 14:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="REOKPXnL";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC0510E662
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 14:31:17 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so56541825e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 06:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738679476; x=1739284276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EAaOjDZDnto02DFdfDuMbl1+hvvoMCrd7FHl32n+QAo=;
 b=REOKPXnLH5JEHEtMBTJahlBVFjvsZdsnlxTacCyt5nmcsmH+PSnxDtnPYBVxfIRqMF
 UU9a6MqtVqrduHNNImnc0BamsUGEkXPbvd3SHfTz9GNwnvyP6/6XoJVpCsUuYcMIKR57
 g0XOwt18Fc81iHQzFX+JTFEI6Rp1ZqfG7f3lC7bZgatTlZPQ9CevSY2Rw0QeZ/TedeMz
 AYy+tVTxylD0tOiESZPpMwFj2DnQrUJ2XqhcWQ/jY4eoL2pugNP7hDMKOQmsU3InDik1
 gfLR4/PTVmJVfytcfrYEjC1mm4Gp0/wLGE1f5caRwOoaU3869zSXSRLSic+e5gbr4O0u
 fWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738679476; x=1739284276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAaOjDZDnto02DFdfDuMbl1+hvvoMCrd7FHl32n+QAo=;
 b=eDbYzi3exlHdRu9EqclKjhYjZ5aC4maRwrNYrjRNNpcQSC+Kk53VYQLAk3GA8UGDYS
 pVqXm7UKh62zGFMjICUTCrLjBOR9PgE/9Lkv8mYWWouc8HKXmfLi9J4PIilY8AWAgosw
 BADZFjiDEv1KvsbV2heFW25fnshvfPF02IhJ0Yv296wC7iq8qASJ5BpDF4L/OcGX3zUu
 NaSufOmUdTLGKgYEjZBCv7/QqbY5nMDUTAeT9ragip6q78xWq7ohj9f0kMsbLigIb5kx
 UiaLz6yB06zZxG+Vj/OlK44PzN13QmElc4svseCGVKgyLwPTzGoRFcGCn2B/GQF6Nfqk
 SX5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0xCD1sALbSD44FwJ7jboQ30JX895vPw7o0hvvc8X+pffxGqubJkplexJ77yf0PbR7IrXVvJJX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJxVJIy9vlstMUjK7VbvqSuXCuqhYMZsVm+7rTvibkDKagdpXs
 2wYsWWGsCJk2HyXGrbOTIb9jQsZvuv9qJRelYREWAXuVoHWCaO9J
X-Gm-Gg: ASbGncuQgoxZdaXTP2h/F+7wXvsRU124pyaN88yL0urdmAlT5cNORLMTCwyQMKrZwQv
 6U+e1+C8+59gKZyuL7zZDoiHbs6Szrn+wreWk1tJpqZzhmkjgBeKnY0teQ+/MV7Scs8MtA5Icjq
 9vIiHuZmERrzpqjcGwxHqOREIoK7NhgqtXzjUA56iX+dzMO4sT2g8WaQA+Oj+WYHIpS3y6sWJNJ
 N2rYs3ZMA/MmIfHZuqV9ufngcghDlFxYdqNu7eJDcjlBHzPXruaCyb531EhkDq7OlFHwqlpXwE1
 jzc9vt3ct67Yd6DYYR7Z/nkVuBIL
X-Google-Smtp-Source: AGHT+IGG5LpZv7GBHa9LUQlePD6MwND4AwEvzsIqGMSATKrrijfdy+8DCza+XWuKOqEyC2M1FE7xMg==
X-Received: by 2002:a05:600c:5127:b0:434:e9ee:c2d with SMTP id
 5b1f17b1804b1-438dc41dae3mr192913005e9.26.1738679475965; 
 Tue, 04 Feb 2025 06:31:15 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15d3:1100:15c3:7ea2:8ff1:462c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244eb0dsm194169135e9.27.2025.02.04.06.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:31:15 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: timur.kristof@gmail.com, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: rework queue reset scheduler interaction
Date: Tue,  4 Feb 2025 15:31:09 +0100
Message-Id: <20250204143113.6320-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204143113.6320-1-christian.koenig@amd.com>
References: <20250204143113.6320-1-christian.koenig@amd.com>
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

Stopping the scheduler for queue reset is generally a good idea because
it prevents any worker from touching the ring buffer.

But using amdgpu_fence_driver_force_completion() before restarting it was
a really bad idea because it marked fences as failed while the work was
potentially still running.

Stop doing that and cleanup the comment a bit.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 685c61a05af8..400e27ec14d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -133,25 +133,24 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	/* attempt a per ring reset */
-	if (amdgpu_gpu_recovery &&
-	    ring->funcs->reset) {
-		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
-		/* stop the scheduler, but don't mess with the
-		 * bad job yet because if ring reset fails
-		 * we'll fall back to full GPU reset.
+	if (amdgpu_gpu_recovery && ring->funcs->reset) {
+		dev_err(adev->dev, "Starting %s ring reset\n",
+			s_job->sched->name);
+
+		/*
+		 * Stop the scheduler to prevent anybody else from touching the
+		 * ring buffer.
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_stop(&ring->sched, s_job);
 			atomic_inc(&ring->adev->gpu_reset_counter);
-			amdgpu_fence_driver_force_completion(ring);
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_start(&ring->sched, 0);
+			drm_sched_wqueue_start(&ring->sched);
+			dev_err(adev->dev, "Ring %s reset worked\n",
+				ring->sched.name);
 			goto exit;
 		}
-		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
+		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
-- 
2.34.1


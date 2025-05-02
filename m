Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D9EC3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 16:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D4810E1EA;
	Fri,  2 May 2025 16:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iQaQhsCv";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B775910E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 16:17:23 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso326847366b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746202642; x=1746807442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bYefFBr4oF96MxOKU27/oliq65pIS4bbhFcmmebAI4g=;
 b=iQaQhsCvEhZ0F/N52l3UIEhrnWqPfu1+EWgAt8ZFUWhsgH1MaxoeVdW+NPQ52a4CjA
 WlJsHjn+Wnz2LaJXvtTax0PmvG+b6VYzQy7U42vAl0DjvWRjS7QxH/DnVU9K+WFRCpOz
 pAN6xCA69euUniQmbcnCIap5GNBT7Pm2YVAhk4NdQUbO8DkQgpgWCcIDsA8Fmu54s4SA
 Sg5XRC0PSVn3I9+H0zAQja9MU5kKThx0JGMZE+4+Gh0AYysr7+pl56MZyInKCZZkeS8f
 JwIgsS9J1ZDqtFj/IZcrQOrMQYJvgS8bdpG/caHo0vIihqgDIp1+Nwwl0hjd7pAdTIQi
 dnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746202642; x=1746807442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bYefFBr4oF96MxOKU27/oliq65pIS4bbhFcmmebAI4g=;
 b=MMyMtpNwgcMYtUCnx9Umy7NqI67ApwWVXXENdgoFGdaCIbaVry4YPVtXilNQpAnYL6
 32KrmF3sbElGx7jyhk8k3KfJRb3EtwqbhwVhFUZOkleiwAMWgJiL/pPba0mbP6Lk6OTY
 GPlrdW5WUt9EB8xx+9i5w2VncU4PgxZyADBe9pYDY6GcNOol510zrNe0i4WA8FLMssFf
 99ty/ck3HwT0XhpX+/GyLceFvODM84iTU5nsalRTl2BnMVR/klrNAnmiJWyVa+Psx/f6
 QiNyFbHreSb8UDXZycLghVv9AkNhsr0GnjytHfoyNV5y0ldN/z/As3NWpJkaD2p2DND1
 eCsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc5SuqiOKj8xZt/YhH4uaw/qGX858I8AFnaXnyq1zmGGduYHQ3QZxzP3erDRg2hoGjPHnEIBKT@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywpr0KF1Kq2YThdLx/pwaRdN8P3xx7fnWzsiWrt0xKYjYKYXNSm
 bkDoZhHPId3f3P/sDCHnOgN2lJpoT5/MOlaaQV0KHl6pRDVjhdsY
X-Gm-Gg: ASbGncu6nV8zbYzdtxyOyfQIh+EDiZ46VxzcIFpAno4cNlu5DaN79C3Q8yRyuu+HSB7
 Ixck/C6dNpwTe5FR4NoblEdKfPk5ZHbv3XD+l2f3mOmKXEypkbutmn3sqF8OQG5u7BEAUdPc+zv
 tyOd5ZjPFeig43T4vpyc6pRHH5gPTz2pCipkpZ7nJJCjeSjIeLQL2nJqi5qoZspQx2Iiwwt9rmR
 21ucneEf+7tvDlLlQk9mJPt5Z7H+CILmUqGWxaTKqoub41NgeYHaLeP/6sWCM6WFJevua/LtpiZ
 t/GQ0xLzPF84orNwfR8RiABE7bwhJZchUfZLEb+tl7T4D5WwroaQbg==
X-Google-Smtp-Source: AGHT+IGKN1B9uLEB76qfl279BIu9jP9A1avoGNDT+sckrFYMp5QkkEBjL0cKbBHu7fiGCDbgpqa+CA==
X-Received: by 2002:a17:907:3ea2:b0:ac3:17bb:34fc with SMTP id
 a640c23a62f3a-ad17af47f81mr346805366b.52.1746202641767; 
 Fri, 02 May 2025 09:17:21 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b1:4a00:5585:4c76:3645:c6fa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189509088sm68748766b.146.2025.05.02.09.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:17:21 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: rework queue reset scheduler interaction
Date: Fri,  2 May 2025 18:17:16 +0200
Message-Id: <20250502161720.1704-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 27 ++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index acb21fc8b3ce..a0fab947143b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		bool is_guilty;
 
-		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
-		/* stop the scheduler, but don't mess with the
-		 * bad job yet because if ring reset fails
-		 * we'll fall back to full GPU reset.
+		dev_err(adev->dev, "Starting %s ring reset\n",
+			s_job->sched->name);
+
+		/*
+		 * Stop the scheduler to prevent anybody else from touching the
+		 * ring buffer.
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 
@@ -157,19 +159,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_stop(&ring->sched, s_job);
-			if (is_guilty) {
+			if (is_guilty)
 				atomic_inc(&ring->adev->gpu_reset_counter);
-				amdgpu_fence_driver_force_completion(ring);
-			}
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_start(&ring->sched, 0);
-			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
-			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+			drm_sched_wqueue_start(&ring->sched);
+			dev_err(adev->dev, "Ring %s reset succeeded\n",
+				ring->sched.name);
+			drm_dev_wedged_event(adev_to_drm(adev),
+					     DRM_WEDGE_RECOVERY_NONE);
 			goto exit;
 		}
-		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
+		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
-- 
2.34.1


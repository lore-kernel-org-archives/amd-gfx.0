Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CD0C28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 14:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9986410E7D1;
	Wed,  2 Apr 2025 14:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fapsmv8T";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B92A10E7D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 14:02:18 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5e5e34f4e89so12819821a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Apr 2025 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743602536; x=1744207336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=uFCphIXPOBBH29KBsqJNdhdJNMmgTsSu3jhi+xaCso4=;
 b=fapsmv8TireXQvF2cOotqfb7421y5wi6HRpcwHZrQIDrR7YrO22g+lz6I6bawwzlCc
 opGoL6indvFAatJwzdUeDxlNzrXSCgGeuKYVrkkoM+q488lVcqJKKAbFPzb/04DiebJT
 ofTw3Vh5r4HjmRmUbmEZ0YlVWtMtQEGqAuYKh43zPPw5y/Lg5hlavTPCCJI0yxNf7t2H
 EQ+SbqmtCxqC2+h1i8mrG3bbkOiGjBvAqPJtL+H2etjqSqABsY0EluCjyYRRSKEgBpOt
 BQya0Zvmp+KuuCWiiLcV0BWy/agwKyDI4quW3i9BwVC61V0t6NAg+o0QcOlq8dXoH3Dx
 bK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743602536; x=1744207336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uFCphIXPOBBH29KBsqJNdhdJNMmgTsSu3jhi+xaCso4=;
 b=bEPwJ1qbIn4Tf8YyOnRtH08YkLQ/hPR3iVqwPPrLWGAYnL1cEo37ouWtNnJlqtDUFA
 3YwXiwEqhDwZPo2JnEEIC9uc3NVptrlTAwBkWSyTi6CFctPKImg5q9LmxrJyFVo2nJ4x
 FV1NpADKs+CtJOm6n7I9eBonaJwO4FZTi+LU08P7Lm6ZZ9+EpsIzox2VhJGwdaDy7ypZ
 b9Ed24mzop710ZdqoXQpUZbBaP+Lp6RkqSQWcM/4PaDZlMGa8BP1KXQeuGyHD2mIRmEG
 79I0zIDiM20SNDpuS2qWqHRp2l7A/0MB18/GCDJmA0kBQMnQXLAk2v+UPAlPE/lpFd8i
 fqQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZnNJ0GdElLRhI7rrtSgS0Sjntryu55pQeU6ZjgUHHbB+SDSOKl9u78ctttUlo2V8uj+ZMgLRl@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1uKfV4+1tlQiIjiNveLEuAqBhPjlhsbIWDJ41EptdEUnj8vi6
 hWLQNvDxB2oxA7cjTO0jp5B91Fgi9EL+Vvp+ZyNR3Il9Dv6x5+1fuycDpg==
X-Gm-Gg: ASbGncuArHqAXiHSpOvHn5ooEHXz8Q9EetneKyBvEyOEO69GRFwJIH/nnpJfxlcj14b
 eUMoB99Hohd/mGM+boAw83u2HA9C1eQjbRhRN7/7SYrBHMce7FEFXCrKOMZzV6aPrekhKgj7ZJt
 UV0S8YYDnBQLEnXIm1YVyQyImGl2se00pmanHsmdvgJWKNMkPDuFx/JwcAfXHqY+UQwUP432kHN
 yWg/6d9xX6KpYBSGGFztaPUB5EhN5ATbggZHKAeM1a18xLNasiMjLShJE2LuDx81o3J8yAYcxHg
 6r0J7haPlxoX8Vxk/RexIYFiFYEbtKGpFq4l5BbtFX1gOZ85juoOr3sC2fo0q+FY6Fpp
X-Google-Smtp-Source: AGHT+IHxJafOdJn861PTVDJ/wjmmxNud9ehTtd6s3cv2Y9kXEIzriqhXobkkZMmzBcBR2woC+e5ofA==
X-Received: by 2002:a05:6402:210f:b0:5ec:cc79:84f5 with SMTP id
 4fb4d7f45d1cf-5f04eaa791cmr2292928a12.7.1743602534537; 
 Wed, 02 Apr 2025 07:02:14 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154c:cd00:1f79:1a00:3adf:1a77])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc17e05d8sm8366944a12.74.2025.04.02.07.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 07:02:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: use a dummy owner for sysfs triggered cleaner
 shaders v2
Date: Wed,  2 Apr 2025 16:02:12 +0200
Message-Id: <20250402140213.13455-1-christian.koenig@amd.com>
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

Otherwise triggering sysfs multiple times without other submissions in
between only runs the shader once.

v2: add some comment

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f64675b2ab75..9a24be43e035 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1439,9 +1439,11 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct drm_gpu_scheduler *sched = &ring->sched;
 	struct drm_sched_entity entity;
+	static atomic_t counter;
 	struct dma_fence *f;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
+	void * owner;
 	int i, r;
 
 	/* Initialize the scheduler entity */
@@ -1452,9 +1454,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 		goto err;
 	}
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
-				     64, 0,
-				     &job);
+	/*
+	 * Use some unique dummy value as the owner to make sure we execute
+	 * the cleaner shader on each submission. The value just need to change
+	 * for each submission and is otherwise meaningless.
+	 */
+	owner = (unsigned long)atomic_inc_return(&counter),
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
+				     64, 0, &job);
 	if (r)
 		goto err;
 
-- 
2.34.1


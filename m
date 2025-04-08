Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8338FC369A2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 15:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C48710E23F;
	Tue,  8 Apr 2025 15:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PguGPcwP";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57AE710E23F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 15:30:21 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so39990325e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Apr 2025 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744126220; x=1744731020; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JwEY8rh2q4zDoVNACS5cKIMZYh2B0sgLn/jSrx5mMCQ=;
 b=PguGPcwP94ZbJYLconfKN3reta+0kKljCzobFrnebIgOY+vM130TM2xBjjOniAvxT0
 ZAXsrB6xu7YZh78wa6C11fs7ry5aIqKubx0maX5zeqPS6qPXz6glkzlfc4mITpBC+zy5
 DfWD0lPxuaW4BO6CDgD9dc05AcXCEh8LHSIo8bCY6JhsiaZ1qK/tXjHsrlSa5TPIHqTL
 5aZLbEsLTlvMLX+Mu82SgKwZnfupxHibWOstkoycxfVANsM6JJJ9YC+MvxX39p+bNnSU
 aJF2CUrukTEz9+FI3VVPawJ7jsiRL59ZhMZtQ10ViqLXP7Vvd/hkuhlYTQy+nZASDEPz
 Y6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744126220; x=1744731020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JwEY8rh2q4zDoVNACS5cKIMZYh2B0sgLn/jSrx5mMCQ=;
 b=lA4c0XpmenJw89GiuG28Ee33sOxBsgcisJPtd/t1LDZdt/C8c9WSicRst02+k7v0a1
 mgnVaiQfMn+DcmQ9FKCw9Drpo3tG0lCZooOOnYRh+tOrxRLAeuHa2GlZVC9b/YRg+Avu
 E38+/UR1ydMJUgWygT29bQCQsUSJXJP3H9GIZPsXqctvzAXmCZ6YKyXy8bE2tEx2IXry
 /q3pgxuVE7XhrfY0gUFIUEZF24RlrTPve5uQxBS+ADYVi7GhnnoLWiaWzfT47WsNXQwk
 g+qKBB5McqkssxIVC7APTsCChgAiQLLnqcWboGikGYUM611Sd6uw1n/oo8p5bbAR+HzK
 VD4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFtydM6050ejOCzmCOi2oE/ZSvJJDrYoVKdaRoKpx6Avh4YvuWZ1axsR5GvN/VxWHSKCdKLrMn@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1mvpaB+VB5jck4FOdZDnU6SCJkFAsV4zGV1gbed5Q8UMnsbBo
 Cn29Y7fdp34tQOeJSV02turh4iBLEwXF/iRQ63SfpUvM5C/Wtk9+
X-Gm-Gg: ASbGnctKq+dEgrsY3TQlpAYbxOREvHEz7yFJF+bw5aismHPFX0UKYpYU50kFw22703Z
 FlMeJuGxAoW3v2QFImbNGdpqTQMA3hlKLdFr2Gl7iTBlmAaqFskSO5RazukRvhL8a0kQbZvvowk
 so4nBJFV0KsF99uXEVGoRBegZRuHOljX0h3ZagUTbxFULIH1PNw7VsqaFpGGDg0OTmgevU4Ljg8
 6EBLSDG+wJUXc8aThN7i2uL/rqX2tcc0NyyVsfhlz1AD/XE4A3EmjmSNDP2mDXOwKXFyvvCY3go
 eVRcFERBFMtpU5Unm6eK4VOCpFAowIqXbwvBMZryXuxCObRqrw8XVCpdtA==
X-Google-Smtp-Source: AGHT+IECYEgkmBdXJpZ9n1n0E54r1fd7ivP3vhzgr+UNaU83WS9ueKtyNCzjraVRDFqpIX03d9qnKw==
X-Received: by 2002:a5d:64c6:0:b0:39c:30d8:3265 with SMTP id
 ffacd0b85a97d-39d820ba07emr3299645f8f.15.1744126219618; 
 Tue, 08 Apr 2025 08:30:19 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15c5:ac00:7bc3:87c3:a7e6:fa57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7045sm15423747f8f.39.2025.04.08.08.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 08:30:19 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: use a dummy owner for sysfs triggered cleaner
 shaders v3
Date: Tue,  8 Apr 2025 17:30:17 +0200
Message-Id: <20250408153018.1770-1-christian.koenig@amd.com>
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
v3: re-add missing cast

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f64675b2ab75..76237961a08f 100644
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
+	owner = (void *)(unsigned long)atomic_inc_return(&counter),
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
+				     64, 0, &job);
 	if (r)
 		goto err;
 
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5EDC3600B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 13:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F306410E036;
	Mon, 31 Mar 2025 13:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jzE9K3yR";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D305C10E036
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 13:01:56 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso7277137a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743426115; x=1744030915; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PyYV+6i1M742MKfW1g8R4e1vz5xYGl0MG2XdbLrX/Cg=;
 b=jzE9K3yRaaVrUZa/Rw/foOsmm96bBDD+yXpdfv/Dh+yuZ0Jd0QHZYjB34YjMo3ieJK
 c3//if/j2VrqYWQjR1uSKUW7Dqq4WqEQD6kR3UiFDA/Qlo6q0hsnDFrjk0ep06MnZ8hR
 x+epWrsvPcvC8QU2Ihm1MGoh+xiyr3F3mQyX65Zp36RiwVCVWEeBi6WDPZm+MzzU9Egf
 GN150z40AvD0+B6cb3t/G2yPJS/zK7NDj1tjQkqPPGLzAv5ZQR5J6T738iskioFjYNtu
 okuaiF1IqYvbza/XWpqYWO2wwjiVwME9fI56l0I4Zb253czn9+jThh8ZxsPil9hUFilw
 K+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743426115; x=1744030915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PyYV+6i1M742MKfW1g8R4e1vz5xYGl0MG2XdbLrX/Cg=;
 b=WXe+Mgc0YTAx4KNG2Q1LsAUlWo5ahmf0E5/IhqURfru24TFjMgWXYv3eVnYQEumQj6
 BVoVtgIu+dwES5faB5LTl7i1dJrJflaaPMH7+bYxLjkYjgNgN01QaPRlnfUDCgdXQpWI
 YDojtCHYXqmcrGYVsODr2BaCo8gQVn6VxalrD6/II91eO01NkNJxlFNnhkIbpcByGeof
 uwGxeyM9BJjbCCfzdxU9aVZDsb/tgHMujxRT9Wn7u6W4doldpwcJ6dAHigJWJpYFaK8F
 NgeCXDxKQGfo+A1Fkex2Em2tluYnHOxroum8b7hj+Kgz7P9QBsNIdlDJlT9lHUofzFht
 XMEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhdI3p771AaHBb4gtn3wWZ4xv/jw5HKkNDGBzN6nVSYumcTx3x6sJBVwYda7cSjotMuHaTfhMW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxZJvEwNe5omZ7IsBZfcAKTYeZv+oy02JIVuMWiA3DybdQpjYu
 4h7Hs8IxVMgL5Ki+FMxVXKy0WCpXPTr76Ag6fhdrL1bMCXblmeBU
X-Gm-Gg: ASbGncu9TGV1dC6V6L0APPAQN3dlYH/lZAYdPurKcFxRwIdEZjEXlD2Kyq36j58002N
 m3AGdaeSmxOnNpB+XTv4XA0IJY7TSrjEnUWITvGcaKmyPMZMOPquCHukaNsH8qBQq8/9Haj4Jai
 gzdl/ijq2LORlSLDE3Q51FWdBUIe9ocZD2a2YDcNLybm5JReuRLp1sX6Gj2jMTG4vMkNaaon0aw
 bZ0aT86qliiztnkSFvZOLyO0W2bX6J+3T9zj6fc/3HbotNX0l79H28LJiUSr+9RtgdfHdP9NWBL
 YwHNGFJFJ1d+PeFTVrnzyN+U1aI9Jo8QJkWI/cpCLiV1E7rJWcsaPk4e4g==
X-Google-Smtp-Source: AGHT+IHCOS5gnTUqLdd9JsHhwfKBKv/zX3tdhM8e/X6w+8OF0DiBT7FF3mBScJJhIFPNpoAQ6Wg3FQ==
X-Received: by 2002:a05:6402:51ca:b0:5e5:4807:5441 with SMTP id
 4fb4d7f45d1cf-5edfdd16b01mr8817975a12.30.1743426114924; 
 Mon, 31 Mar 2025 06:01:54 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1526:9900:4cdf:63ca:5640:79f6])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc16ed61esm5598206a12.34.2025.03.31.06.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:01:54 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: use a dummy owner for sysfs triggered cleaner
 shaders
Date: Mon, 31 Mar 2025 15:01:51 +0200
Message-Id: <20250331130152.2342-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f64675b2ab75..9d81eeef61e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1439,6 +1439,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct drm_gpu_scheduler *sched = &ring->sched;
 	struct drm_sched_entity entity;
+	static atomic_t counter;
 	struct dma_fence *f;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
@@ -1452,9 +1453,9 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 		goto err;
 	}
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
-				     64, 0,
-				     &job);
+	r = amdgpu_job_alloc_with_ib(ring->adev, &entity,
+				     (void *)(long)atomic_inc_return(&counter),
+				     64, 0, &job);
 	if (r)
 		goto err;
 
-- 
2.34.1


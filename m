Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170C5C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 15:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11C710E21B;
	Tue, 18 Mar 2025 15:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H0s5RwQK";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1612F10E21B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 15:19:18 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so8656630a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742311156; x=1742915956; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VNXTURsqKcxVawfVHXohmAyxUVdMygyIW22jNYpimKE=;
 b=H0s5RwQKjYkCoj8xaNJTcID72RDRUyc2HFjLBsFLjy0QioyaB0sQwjUPmPZIcipbwz
 YqT/uxmY+UbLKopEHXIWYc9U87pZEY1gBpSP9wrd4xPy8JjZhF/dA2kLpswcY4tQIJmn
 fctH/aKo8EflfDwgHGh9zPR+KqB2Ol/KovZo0MEufliz0WqagH8BjUpnrkZp4fFHfqT6
 Z4zos7oUpUe9mHYQcdsizFqPtv8KF6HOqKvQITLE8yoX0ST/AmtI2+qPub1zpseOr6q9
 ZlZXTlLWuBi5iGfT0ZWxRy8Tg1Ylx0UbHs5juj5ruzAh7DEaDA53jTa+2W6ME5Jb5iue
 6iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311156; x=1742915956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VNXTURsqKcxVawfVHXohmAyxUVdMygyIW22jNYpimKE=;
 b=Ul1NyPKkXb7rk1U9hD1qxZ8O47lNjQHu9foh79WzwnFo7kJWZNs1Z2xvjDwDNjJDTN
 9h2QRGGYsMKPNekOJy8jsib9mmnjCpv2qKL52IGyaCCvj36Ig29tnBuHXi0g/2V+ujMZ
 piLBV9SweOI1SQnQCUGnt5bS5F1gFF0fgIeIt4i0k2kNvHSTb4dJrySMZ1kvX0P6gixD
 0YaiH8gUeQPAPHxPhhA+TcSllg0/bMxMDJJ5v4NBNAXFAtAUvGQuPArN4CC81yal4+Fs
 JlgcCQtpFyonIdjWViJftH2EABO5tnVvByfPVDSXY/0bv5wLdxzyL/jT7wgBmSejCzcB
 3jYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfhhFn4yxWyRS8ensWAtkgdJGranW2pwk1xJlFYZKYVd7PuJyfPYeqxtEpa6DfBJ6pOAp8lMdI@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyafmv3rv5ehNnbt0pW7WnKqvkJnHPAZVd7/nxI1Rv/k2Y+mcgk
 ZmIwDKFOj+Pzezs744MUdmOcK+t3KJ9W/0E90WZEiZH75aPGB+P1Dys7rdpu
X-Gm-Gg: ASbGncuHhEdy6jX2XJXflcJrtZ+jUzR5kN6FJ71L3FEs7Z+2qj42cOHUAKwFy3JVzyi
 8lzLgJPDiHIl8E3WZPZRjHB75/hPzxllXhpTG5KwsjkK95W19rAchmynUEOJhYASfoeVrjPMOot
 vgFSK7Ri9EpMl+71MXNC/Yiud9a+qSe6nJ17bAoE4WO6m+Dk0DpMHlGk25f+zePVyzYB1n90krj
 j7ZEbPlwv3MZViMlPDTaSyCjKjxxaxcOXY6a72uSxJmH2v7u761MXGbG2gEEJbU3bsJEldbUKa9
 jWqAGZOBwOYhoF3EVyNkWtEKgL4kDF/Aepc2gaIHGCoSdvbu/WUmOYNlDA==
X-Google-Smtp-Source: AGHT+IEZTNVvqMEaDrgZWzYFLj76qGXE/bXnJvfg/4PYVcbNmLSYEH8K/DTVUmlxgGRGLe+XEhgMaA==
X-Received: by 2002:a05:6402:518d:b0:5e5:bdfe:6c00 with SMTP id
 4fb4d7f45d1cf-5e89fa52e16mr15972639a12.19.1742311156153; 
 Tue, 18 Mar 2025 08:19:16 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1527:7100:dc64:6e75:5ed1:a43e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e816974b63sm7846852a12.28.2025.03.18.08.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 08:19:15 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: remove invalid usage of sched.ready
Date: Tue, 18 Mar 2025 16:19:14 +0100
Message-Id: <20250318151915.5413-1-christian.koenig@amd.com>
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

I can't count how often I had to remove this nonsense.

Probably doesn't need an explanation any more.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 65fa583c34a4..9cb499195fff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2675,7 +2675,6 @@ static int gfx_v12_0_cp_gfx_resume(struct amdgpu_device *adev)
 	u32 tmp;
 	u32 rb_bufsz;
 	u64 rb_addr, rptr_addr, wptr_gpu_addr;
-	u32 i;
 
 	/* Set the write pointer delay */
 	WREG32_SOC15(GC, 0, regCP_RB_WPTR_DELAY, 0);
@@ -2730,12 +2729,6 @@ static int gfx_v12_0_cp_gfx_resume(struct amdgpu_device *adev)
 
 	/* start the ring */
 	gfx_v12_0_cp_gfx_start(adev);
-
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		ring->sched.ready = true;
-	}
-
 	return 0;
 }
 
@@ -3083,10 +3076,6 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	if (r)
 		goto done;
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		ring->sched.ready = true;
-	}
 done:
 	return r;
 }
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC67C36010
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 14:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D90F10EBD1;
	Fri,  4 Apr 2025 14:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WrIX6hgz";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B4D10EBD1
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 14:16:12 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso22169455e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Apr 2025 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743776170; x=1744380970; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JwEY8rh2q4zDoVNACS5cKIMZYh2B0sgLn/jSrx5mMCQ=;
 b=WrIX6hgzwTBYgtBk3SdBq3g6UQ2C0cvYvU34Sf4bF0ee3hv9QC5MSyzuafHDI3FU6i
 ajmZae5sZ4BmGB56jguzRT/QfR6MU1+b22jkPpKWwCVxJJYtZ5A6vrb9P+hL19/d591t
 Rjv0Q0n+GJta7aC4xZaf2A4xJFnMA12qoAOcH/hMMOINmsNdpx6jScmo0lde+LZ9zbBr
 njX6QvC8xnJAFUDVMBk4flxU3Yx/k4UeLIOF2MQS+AUaRK0nQl0bjKrJTMQVC5pVED8G
 mo7b3kzPbbziKco/V/+sgN9dbq7bmzToawth5ET50w4Dl7B+MdvQXdA4mpDnpXVlx0n/
 3jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743776170; x=1744380970;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JwEY8rh2q4zDoVNACS5cKIMZYh2B0sgLn/jSrx5mMCQ=;
 b=sqBksQ0FNNseGgguNhgoBykMHk8aq2Wy/52TSSIT/ozEjKvbb/ijWDGWbAMdHI59MQ
 17eOx7OVY3B4d54qjkXcaHZO9RW+3AOUuL0wZMTunAIcSFRnDVdL/u4F+bkSaDsHtNID
 GCWIr4DuRVVkl4GGWM0X4NphJSjUziYNrB+M7dWuXlUXfHIxfA+XLdDFfng/XMGXJomq
 8bsQVlH+5lgo1nLfCHSKsNGf0xQy44GwWXcszBT8O/GqVJMssSO8HmGVrv/wI+9xWHc3
 +brGDBdRU/ZDjPXnzosRQQsDDAcRmfP0+mg3D5mamFmxjjhz/ZY/dWrUdcWgFbK7OCYd
 cp5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU971Zejj69B1+Kx9TFgQQKBgNE6aMXbROUpZxg9iuVEDiM8MRQW2J41ZEgN8dKJc/I5xq/1HoH@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yychi6Jdscggw7Cl1MHQxAhyGKbSQ9HfyDBuXrADw3dFLUda91T
 KHGt98CXlgye8HAymDowHr3sCGTIk880ww0iVb335soX+Wbp2AP8
X-Gm-Gg: ASbGncsYKQMixZ2PipXKn+qSQQ2oAWEHE7h6mdmk3v/f5sgSJ5fUF7akSJ4TXXytigy
 xYgYFxdwvePYXlR4RxML5/g4OGXRahHC8PKw2WDNV1e4FuhZ61/N9vOadeBzeRpyzpvuq4m5IP+
 1y4nJX0EQl4lGRRxn0ASoUYORI4RC3a2uxbDNH3cU0WVXRR+KOPHfftEGU8hunDz1TRdjAqKII3
 e64u6P9nkrpYrNmYq1krPRbfLdedB2jyvl9CxcQbrzfiXKfjd7VHPvUYsU5IAr1j0Mm0niJYwV7
 bep0nPjYzTabtprUXuTq0rJXwrVvhY84AU1ia3ikod96ty95U/ul6hnQXA==
X-Google-Smtp-Source: AGHT+IE9iEkpyuydaHsCXloIHObghvWyvUijbZU8vXckuTY9volr4psUAkZIyFP9FI5RlCUNgG9HFQ==
X-Received: by 2002:a05:600c:3d98:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-43ed0bc78e8mr36153955e9.10.1743776170299; 
 Fri, 04 Apr 2025 07:16:10 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:157c:e200:b2b3:568d:2234:72c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364ec90sm47005485e9.27.2025.04.04.07.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 07:16:09 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: use a dummy owner for sysfs triggered cleaner
 shaders v3
Date: Fri,  4 Apr 2025 16:16:06 +0200
Message-Id: <20250404141607.1451-1-christian.koenig@amd.com>
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


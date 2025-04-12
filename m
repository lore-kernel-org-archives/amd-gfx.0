Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9010CC369B2
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Apr 2025 16:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B68710E2E4;
	Sat, 12 Apr 2025 16:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aojnun1L";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC07D10E1B0
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 14:39:37 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so1520780f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744468776; x=1745073576; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nm2H6iLUjvnbWXFUPqhKNdAW5lLeAEyGiUbQz3duIYw=;
 b=aojnun1LH6pxhQHeApgWfMfYkTyDzzs5enuEom35MbN7TFOPwSf47NGxPVTwhVyqwq
 LhLdpl5tnzXPdaxcYQ43qHs+ICigiNfeYuPQmr/w41FabJ5AvrOPNHJB2Axup/NXyWVS
 s7XAq9uqxFRXyaE7QNHtKSywoIca6dp+nSs76v3h1x8qLD+nR+RXLaHZI6T+6gEn2TkB
 tJ09ldlp2qwAyWzHMheOwXvGfG8nYstjZS8wvn1rZmuzUPQvRvnPpbZwmT4qx/k4sh+2
 rcfMaeeJvclEn/CBvP/ScWQP30pINpA/0uRViyOnE0jYWHJp6tlagK5s7CYep2SLKneU
 5P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744468776; x=1745073576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nm2H6iLUjvnbWXFUPqhKNdAW5lLeAEyGiUbQz3duIYw=;
 b=Hu/mWmi42d+gQY/j+aMvOUv0Dnngvdd/l0GZSzkX3L32ybjkxR23+3GxsQvDRt9JaU
 n7NnXcW6S7OrVfjhdfdljEyKzdoFB5dMMuJEEzDo14vgvzZnGPqyeRx4+RRy+0kozQTA
 e4OWLLHK0rW0Ov/GkE+pZze9ejCtgrfW56SO6oA2JgC7YVfClbzhOB/Y5q4+IeUMeo78
 VA0KeCfN/wQC7XIZajujWkJ4qANRE94R+NKM/B9hImR5pWetRQPA1/RHnWFJCJ7+P9gt
 HRJUhL90cwcooe+dxFBIyuIqNx/Rlo1n8hwAh8ToZyn8H67SRPHSxeNNQfPPq5y1WLnI
 /9sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoALj755dRSZ7RjMlBh4TNTYlJhhYJbjHT9dSHbcaodIkS9X93HtA3/t7pk1oGxx5tYXxv2YTk@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8AFP51AE7DoBxBb0CsFD5iysYA1ErsP/zLDzHdrZ7WAT4WZCK
 wyYmJcPI9PMs1AcdC6w//zdrH2zHIcNq1I/JVfdApbPkUaHsc727KXMxVcaSJxU=
X-Gm-Gg: ASbGncsfl6PeN8C+WbUKiqGJetKoUrDuqTXrRNe5zGfE+CHcK7Lhy2u+w9a6/Jrr38f
 BZRDRmNHNrr1xYLMtBzKVyiazQoGg1AU2rAN4F6iizlZbwpTc2noRUFWbbKnqlrBOMAYg+FsO8r
 4A7K02Qhi743mMsC3RbpA51L2ARKRto5VrFcLlYBioYNnvN7g/sUHiDUiR6+8iraX4T/MxYwqSk
 x0qJ4WG86fXk3ncpjGPhPj6ORnyMAqXOOc1DuuFh7ogjvMHdGt+ZxgGUcczk/21AFuTv4jKgIDn
 4hIF22VpnzpoYBOOAw6L8SsMsQjgiW3aNv6A8846D+croA==
X-Google-Smtp-Source: AGHT+IFPnZPQh+rWoYat/40mbIFtQogM3jyiLm0FL3fS2Hmqy/RSAmRPjVkSRty4HpjLKUq4NyrWdQ==
X-Received: by 2002:a5d:6d88:0:b0:38d:e401:fd61 with SMTP id
 ffacd0b85a97d-39eaaecab8bmr4810516f8f.49.1744468776133; 
 Sat, 12 Apr 2025 07:39:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43f235a5b08sm120684135e9.33.2025.04.12.07.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 07:39:35 -0700 (PDT)
Date: Sat, 12 Apr 2025 17:39:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arvind Yadav <Arvind.Yadav@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/amdgpu: Fix double free in
 amdgpu_userq_fence_driver_alloc()
Message-ID: <d4583e103f65e850f886babcf1b290b0855ba04c.1744468610.git.dan.carpenter@linaro.org>
References: <cover.1744468610.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1744468610.git.dan.carpenter@linaro.org>
X-Mailman-Approved-At: Sat, 12 Apr 2025 16:07:59 +0000
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

The goto frees "fence_drv" so this is a double free bug.  There is no
need to call amdgpu_seq64_free(adev, fence_drv->va) since the seq64
allocation failed so change the goto to goto free_fence_drv.  Also
propagate the error code from amdgpu_seq64_alloc() instead of hard coding
it to -ENOMEM.

Fixes: e7cf21fbb277 ("drm/amdgpu: Few optimization and fixes for userq fence driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: No change.

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a4953d668972..b012fece91e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -84,11 +84,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	/* Acquire seq64 memory */
 	r = amdgpu_seq64_alloc(adev, &fence_drv->va, &fence_drv->gpu_addr,
 			       &fence_drv->cpu_addr);
-	if (r) {
-		kfree(fence_drv);
-		r = -ENOMEM;
-		goto free_seq64;
-	}
+	if (r)
+		goto free_fence_drv;
 
 	memset(fence_drv->cpu_addr, 0, sizeof(u64));
 
-- 
2.47.2


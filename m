Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCF7C369B4
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Apr 2025 16:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F149210E2CB;
	Sat, 12 Apr 2025 16:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bA/r0IVx";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D665310E2B7
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 14:39:47 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-39c31e4c3e5so1832485f8f.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744468786; x=1745073586; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/0APbTrVqZTQ7b+tNHxNW9om5cpeJ+hNOY66GU+x9GE=;
 b=bA/r0IVx2JUlL8YecfHUjtA9eEWFkiDQqKWiL8oXlsYdEaPB/I2zbNCl4O56WnMtqS
 TSHGAYHPmVwFecvVgIGNCI7Tbvz4CGLQYB1XTiU1t0ZX6msr6z+MsmoEXnk1LZMOsczm
 idh72Y2KsLPf6B0jZGsu0e6o2J2A/i120v5ThkfdEs6gnc5hbvKecakC/5k+sDExPgpo
 ctUlZxRqR8c9yzaox8Av9pzU/aMaTn1lMcHl1rgOQPcSOJCquPYRGiKVcbYoWA+m8lgt
 Zl7RxKUGArW8QoRQCjdtotANvB+CdFyexCWZNttWvaGhx+IzZAWgVPZYirROkmjxx7IX
 Qkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744468786; x=1745073586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0APbTrVqZTQ7b+tNHxNW9om5cpeJ+hNOY66GU+x9GE=;
 b=smYzqZsq9LJsNh3mvDcXmkok33khIyH9y3NI8i5Lik4UQBxY1BfzSjCrWftoNlLQSs
 Z5vFKQ27aHfvuoh/oer9GTiBU4f2vnaolb0FAbSdgeZpmVy+dBMuxYSSjYOQb+XCUS3f
 9mQ5VLNhJBv3pVG07HGhvl1YPSvIpY0aRWaFrNE/Y1r+xYbAlIMcFWyOxLg9oXkdWc6a
 q6Fna8ZnFiAT/46ZF07BARRWfvyBvQPrETSQTR5FkP7FRV/H/9WcCAfSV2cWttvkkGvy
 VBaNveGnL+Tw6XG+GSSjs69HfI9+EeFG45tZkfHIh5wqAtVCFqt3xvDJZrT2MaqizSv2
 Qx8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCViY+NFNwPlQo0a9eTf2GwyUkZ11tNRNO/n78zU8nBACn7SBzobY9K+1/8evaFPBnmGPJvWk8rn@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9/5kCYJdsw2Z8lagJX+uDJMqoMpiCuk5ISK1oEmWITA/TvdP/
 D+JbiRGjyonyLA8NoInE/i59YP5WzlSmf47AVu4nsTOlCC+ViFryk5gpJdloyDI=
X-Gm-Gg: ASbGncu2w2wxj0KOymJzwcL8i/Ua7LF0Eq/t+Dn5qydrkqL2kGk5MitRnMci92/NaeJ
 clR2UMGBapp0ijwsZr5q3E4z6V+G2aqGYZCzMszmlpFBkxKCuDVG89sV2AGNeKoQPR7lSC9oQvD
 jKh9U9OuQQdXQgYpOx28TRWE+m5coqfaCA8y3lw7rO9Hsv3CAp2Ov8S98PyWOHT2M5KkpODH1yb
 2ty2GXLKhK+q0KHkZ6rAiPvXEgi8Z4Eg9sximJfK0gFtWJCHYEmOMZ9xWV3kuQk6kThsWiyNcPF
 DwjE9ydpbBDyGRLPDSVn9IELiUkPnoM1wiSUjkvzFZo7Eg==
X-Google-Smtp-Source: AGHT+IEIPIweCgA9/UK8lpvU9btA6Cbv8a80TioEApKtzRIcWdW/8sHJOEnuxUXW7drGXCEjT/WBmA==
X-Received: by 2002:a05:6000:1a8f:b0:391:a74:d7dc with SMTP id
 ffacd0b85a97d-39eaaecab96mr5356300f8f.50.1744468786353; 
 Sat, 12 Apr 2025 07:39:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-39eae963fccsm5179479f8f.3.2025.04.12.07.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 07:39:46 -0700 (PDT)
Date: Sat, 12 Apr 2025 17:39:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Arvind Yadav <Arvind.Yadav@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/amdgpu: Clean up error handling in
 amdgpu_userq_fence_driver_alloc()
Message-ID: <b9adf038b3ccf058c49e7e74e1998bc2216e0678.1744468610.git.dan.carpenter@linaro.org>
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

1) Checkpatch complains if we print an error message for kzalloc()
   failure.  The kzalloc() failure already has it's own error messages
   built in.  Also this allocation is small enough that it is guaranteed
   to succeed.
2) Return directly instead of doing a goto free_fence_drv.  The
   "fence_drv" is already NULL so no cleanup is necessary.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: New patch

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index b012fece91e8..86eab5461162 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -75,11 +75,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	int r;
 
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
-	if (!fence_drv) {
-		DRM_ERROR("Failed to allocate memory for fence driver\n");
-		r = -ENOMEM;
-		goto free_fence_drv;
-	}
+	if (!fence_drv)
+		return -ENOMEM;
 
 	/* Acquire seq64 memory */
 	r = amdgpu_seq64_alloc(adev, &fence_drv->va, &fence_drv->gpu_addr,
-- 
2.47.2


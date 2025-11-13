Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B4FCD8C82
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FFEE10E849;
	Thu, 13 Nov 2025 14:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SBjR81W0";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C98510E840
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:43 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b733707e0b5so131220366b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045622; x=1763650422; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RL6rVAENXblPP/WtJ2kkdTszLuUIj+9DJtEA2dEhVX8=;
 b=SBjR81W0Ba0J1OLbBHCBwkHko+hcFBaYL1IoUh6UlvcUBM1+fNl8bIk1BaSU/+hU7s
 ho1uj2lgnRabICPVX8L6LF8+5A5Py4sOdnEFtPWuvuZduiiBA0MkxRej5cLrfhffCM+o
 jRWqbM/eXIF6XJsPdJbvk4gwIKuMd0+w7TojYXO/PYmcI01/eIiCr1N2T7EWvNATHdaH
 wH9AYN0QnqmARozuW8rL4eGkDdayoeFfeGdHf1oXgUVVcLh+VNO9bQ6PsDchO5d57zkL
 YVqkTUfTKNicETeMC7s8YignHt8r3ZsX0lEHc7U+lYopRS2bM2LnZ1XINWdBqrzhRIJj
 JB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045622; x=1763650422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RL6rVAENXblPP/WtJ2kkdTszLuUIj+9DJtEA2dEhVX8=;
 b=LSaamQLqPemiXO2kcGR8zw7pbCJLBYDOI11Ob9E8SPP6snKttvgH26LEw1DKti7CGW
 TcKkWcqyz1JK3H4JMJAIKTW+P5S+ARsLEK1I/FKRkurQLCrqMcuVSkNTFDIbZKmj5Z6A
 OyWRCxdZpbNLCeWB+ij6rDXkmFl9t5Y4B3ZoQd0QPzk/3XjuHdFg040VVc5KEwDrjyOx
 iyI30mzqguzQUkMYvJIBeg1ngDC/o2ugd94OHXQ9//2g4Pqt8oek7FcC0T0Qnx8cyh+k
 vuIiL8K8D+HnMU4m2aiUn7Byhy68SzJsyeq2C9U02T59Sz3C1eme0jtxgVSdiXAYVxQX
 J4LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhvXZHU+3yIXttDG7ta5VzhBDYVyelcB3McR4i4khIS6OOyvQ4qe2Q2OBm2hnC0ilHhsSK55BB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSaGa2Ua3fs/QShWXKsSZweRhJeB2SZZEO0HQscVjqnjhZn7J2
 4AOLDgBcZKkbxI4+FiSDv1zBF0WCySakDx0lHIh4i5U8/yGOhS3nwIHbG+kYtQ==
X-Gm-Gg: ASbGnctnyUEvvzpl6uJB75xaEvRjB8nfIJM5ls3glFTbN9Y+Z1larDwK4CLcZ5Detrk
 JYa7Cs6uMyyNxiiDFiPaIFD/MG1C+8CIxIJYWwlBKULXqMlnLt4wufjrN9qJjZgV8+eV1tRlbzS
 bk+uIZQu1nMlzFZ2rgrtByUdZ+HqIt+kpYcElwmAFkrtWlfTLZdPIST/pIPWyEKStGzEJQGMFvU
 sQyQbz7Y+yFaV3Iw66wg7X/sm9I95tsZerfTtQSBSl3aVXPZ1I3oXa4iZyOAeFZNmqplLL+IyBa
 dc10PAHNxSEXuiw64b948IK4+cAY5mvIYF2iRFZwFuU9NH6Z6LflYR9L8lmPQRYwq9zyqXv1mVx
 JJ+A1B7CupL/IhoB9XOTwounFCgiEdq7KUrmK38UQw8MFjvnKZ41nolaRGASapx6CA+B6WZCwvz
 3avGeZUH+SDy0=
X-Google-Smtp-Source: AGHT+IGYQ0sKPnZptZ94g0b4Qw3M0eMfY5NZER2npxVtf37GPZpeeMZ5KtmaqoxHfAiQ/F3so5ZQuQ==
X-Received: by 2002:a17:907:1c1b:b0:b37:4f78:55b2 with SMTP id
 a640c23a62f3a-b7331b5f2b8mr710287666b.34.1763045621980; 
 Thu, 13 Nov 2025 06:53:41 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:41 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 09/18] drm/amdgpu: fix KFD eviction fence enable_signaling path
Date: Thu, 13 Nov 2025 15:51:46 +0100
Message-ID: <20251113145332.16805-10-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113145332.16805-1-christian.koenig@amd.com>
References: <20251113145332.16805-1-christian.koenig@amd.com>
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

Calling dma_fence_is_signaled() here is illegal!

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..09c919f72b6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -120,12 +120,6 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
 {
 	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
 
-	if (!fence)
-		return false;
-
-	if (dma_fence_is_signaled(f))
-		return true;
-
 	if (!fence->svm_bo) {
 		if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, f))
 			return true;
-- 
2.43.0


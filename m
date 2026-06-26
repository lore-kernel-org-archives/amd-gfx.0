Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3813EC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 18:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4C510E1D3;
	Fri, 26 Jun 2026 18:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Op5CM0e7";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D9A10E1D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 18:01:49 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so9159195e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782496907; x=1783101707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bjNcVdogKowolH8yQ6NJxiWkK0L8/1k4D+ynFdthgJM=;
 b=Op5CM0e7w85g8lod4dHks9BP8U5AFkQfzo/rDJoddfZyX9U2qhVc9JT0VW4XUMEl2o
 5ek+IQpQf0eYk1BiWey2K6e915LgwQI1+u7FwajtGQ1/BaVf4xn+xNSzQDRowIWFktFZ
 2nwBkdLzWSwcYK5ugx/iCYyM5DDTn3zWwbn/LdkkiiM2OmcoX8MROy4KOPSM7ywa5rpQ
 rSOXx5O6uwSqMuZWrhTtGK5qBuZA9eXen+XIn+nmff3hqwdYMtwroDkWwZpPnRZ5L+S3
 ehcdsfQYxBgteLFTIcl3jol/HMxii7LMt1ssYPtJP47EwkPGOR8nxFuCSyn/H5Qi2MWR
 zlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782496907; x=1783101707;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjNcVdogKowolH8yQ6NJxiWkK0L8/1k4D+ynFdthgJM=;
 b=dd2gjR7n03bEu+p/+PTDH/GukS6MoWHa85dJwnENqoYQ7I43Z5A1swJqLKb9gpyjxw
 Yd+RDUE7u4ZAl5/Z0ymRsNLk/uKDaONcrpqUiKzzSsjzHmbnK+1nNu54sxz8KrcN6L13
 VKAUmPnzRp3MHhDe0Zda+gnnv6XKmymblgIw+VcZqiexwImGZrg9AZoqBFpOQLU0La0Z
 IDFwE7uoScGz2wS83EtBiTw7FloKpUlvSFIX5MwnwfSD23UUD1x5IKg07yQom6JaUIQW
 0X7eD5+Zl/zJj98Kz1JHVMwqiJWmo/3FEPQKp8AQNVvwIIlhAHWkLGBJVti6++KchwED
 U21A==
X-Forwarded-Encrypted: i=1;
 AFNElJ910YZErRrO6A5p/QrTn6U0MuBNQ2+wFfkySg3MNRmAczoKQjmuHthbDNz4z4DEd/54SP0fhWeP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbZZ3cyN+dyYZ1jJ7BCQJz4ctkqFHaWcYHFi/sx9VidD82EGdF
 PzciNNdpYrQkqj8G2eji7ecvVfgmLVoT0En3w4QnJnHzeL8F5FCn7jog
X-Gm-Gg: AfdE7cngqfZMoHqQd6NTMyiFcl8J6jAnml4a86Eiu4GvosSBj+Il7cmPU1BzdXQ8odw
 7fvyWwb5YDq+JH9u7K/Ia7hCy6FMeYBNycyQR/EbKbf2qMKnh9DyytHj8p7GZYx3ybDP/voOBpl
 z1ODwfp7QGqNDgy/Bbru2tL8Iwh1OOgMyy1KJR5qIacwhOc8B697oz/0h8+j0TP6t85rNxrG3va
 H2HA3MI1KksPXV9TLkKf5sx6NvDtErCF01Onea+QWGs9Q20mNXhTS6CSF8dfIlWJYK1WD4GpiOV
 u5VlFrWA+Ect0HT0X19Z7gnxLqSHeYJb52QMger4eAeB3q4akq01j49SNmIOxZr3AR2k3zJkI/O
 b62ypXJCn/vMvq2maRITNtZJwlbfFei7qwmMG/TkDoVBlsxF0RnyWm2eic9TgkZ4ouMyKqdyENe
 +lE+j0vSTvISh12dz0526GLOoDGQ==
X-Received: by 2002:a05:600c:c1d7:10b0:492:4667:8c40 with SMTP id
 5b1f17b1804b1-492668638c1mr94256995e9.8.1782496907306; 
 Fri, 26 Jun 2026 11:01:47 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bd:3800:b096:88fa:fcaa:6745])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d93eesm25602334f8f.20.2026.06.26.11.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 11:01:46 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx
Date: Fri, 26 Jun 2026 20:01:45 +0200
Message-ID: <20260626180145.6213-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For a short moment during alloc/free the userptr BO is not part of his VM,
so bo->vm_bo can be NULL.

Keep a reference to the VM root PD as parent of the userptr BO so that
we can always use that to wait for all submissions of the VM instead of
only the one involving the userptr BO.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 5cd5f99b7b9b ("drm/amdgpu: fix waiting for all submissions for userptrs")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 28f89ae8ca74..686be2bb8c37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -535,6 +535,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	bo = gem_to_amdgpu_bo(gobj);
 	bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
 	bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
+	bo->parent = amdgpu_bo_ref(fpriv->vm.root.bo);
 	r = amdgpu_ttm_tt_set_userptr(&bo->tbo, args->addr, args->flags);
 	if (r)
 		goto release_object;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index b38788228d0b..eaf02f90fddf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -67,7 +67,6 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_interval_notifier *mni,
 {
 	struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, notifier);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	struct amdgpu_bo *vm_root = bo->vm_bo->vm->root.bo;
 	long r;
 
 	if (!mmu_notifier_range_blockable(range))
@@ -78,7 +77,7 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_interval_notifier *mni,
 	mmu_interval_set_seq(mni, cur_seq);
 
 	amdgpu_vm_bo_invalidate(bo, false);
-	r = dma_resv_wait_timeout(vm_root->tbo.base.resv,
+	r = dma_resv_wait_timeout(bo->parent->tbo.base.resv,
 				  DMA_RESV_USAGE_BOOKKEEP, false,
 				  MAX_SCHEDULE_TIMEOUT);
 	mutex_unlock(&adev->notifier_lock);
-- 
2.43.0


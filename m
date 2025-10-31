Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4C6CCFA07
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BBA10EB7F;
	Fri, 31 Oct 2025 13:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MAEwbRJg";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9881910EB7F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:12 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47710acf715so11738995e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918311; x=1762523111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Is8QZraj0UZR9B5lS7sUfkvx3WgTUsZAN2+odc02EU=;
 b=MAEwbRJg6EaavF492+fWvTm5DrJPUQIMoD7XbwuxQXX9Ki1jbpUbf18u0SUv8GY+/5
 Mf7pwCoUfugSG33HVDUdpHVG++4mGPkku6wa6Kvr1OJJerBI+nRDIcQfFPuPbtGZufCH
 u260n9/B8KYgHTH0MJCgQplyH0iKoHnT44/P/Aa/33IKiofNTt1LcApxCrdrTRYJ+d/h
 oUTlWkbsJi4JY9m+hIiOxXUwwldQSNgeuZcjzLP1EXE0kiNcNY+fMNZtq+d4LdIHTx5M
 3yzERZ5PaHVIjelwnEDSWOzw3DeTuMhm1OsGeh4HKol0Ip6zbegvg4DYdGQhb25KidLI
 Tqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918311; x=1762523111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Is8QZraj0UZR9B5lS7sUfkvx3WgTUsZAN2+odc02EU=;
 b=XMak49hdgp85DKwhBr1rincfE3YnYTcMu/leOi3uTsRNeEEFDZEiv1UXXsSVR6jPwh
 Dg2EkGb5cNLSaYTgeP4r6H/5N0OMxiRxVY59/CA/zA11TYOO1cttdxzUYFrUOpbeYWtc
 /bjqsNnWsttsOA64S9ZL9iABFPjCdPvd7dCaUPDEkPqQoJZXR0keaqic2VVgIZmvCyk7
 Y8ShE+YcyY0my5pQ103kG08BrvIIotPf/a+zLFp6Qswm/vsga9TEylmYV6wj43flTWT0
 HK8Lym7dSa9Hd8xOkHAVpJnJfbP9TGQPBUwPrG2aR9w2gMNNAA7J6C5nv3xfYz4m7hna
 X7eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrfrmKU1XHrUzgrF79NFR5gCxOXRQvarYCr+lEC/DDbmDG/7yIR6F0gUibZOh1d/9Ji/vWyicI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgiYb079M4ryPHDQ2VkupUJcJAUjc35ezCLqegD0KkUMShPSnc
 jfVM2/W28VrUw1ZnuFfJ4SD1IgSeuCCHvMUndNqZca2XrvU8A6wCZf38
X-Gm-Gg: ASbGncsAzCTN7GRGu2+4LYc9pjeUOrCHebVtE6hshGHzhOCISsb/J1AjCTsrplxzI/K
 mTPOddGBBW4GISrFWDC+GjnTNpDQhvx2OrVA9X6Xcy/dheMcWg8DUD0526UJLPr7ho7cJUXnGjG
 cIgQU/WcAwUpzqF1eilUes1yhFrlppZRMWEhvDgdNEgnDUiukDAkdnlOvlkP9Dc3CbJqEQfE08u
 4dKhYE+Yg4wMXz7dVpZaafQteIt9BLNYPNoaxhE4iOVklIXRJZa3TgrzeTEGEcNj4Kbqy2pFZ/3
 Fg/Y20XiZtjmnPOo49QizxPjXCOfcbe5gEqFfvOPjg3NUTtnDPavwgxxbyKRF3iYy4c5az/KfLm
 MsSCWXHTwDcIw5eYajXLGk6gLtdKkR87mD9eqa1gtPdgPx+xe9MppszskKbK0Wt6SAqZkuk0GBd
 QBfg9OPvg5L5ch9g12ElLaLF3v
X-Google-Smtp-Source: AGHT+IH8UgoD+vHobMF5u6+WO4Mm01IMnQX3xovxS5J6ZPw3YsiZ27ptFzDepNRTKHhfXqw9BZFp8Q==
X-Received: by 2002:a05:600c:450e:b0:477:19ad:61f4 with SMTP id
 5b1f17b1804b1-477307e2292mr31676895e9.12.1761918311034; 
 Fri, 31 Oct 2025 06:45:11 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:45:10 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/20] drm/amdgpu: independence for the amdgpu_vm_tlb_fence!
Date: Fri, 31 Oct 2025 14:16:48 +0100
Message-ID: <20251031134442.113648-15-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031134442.113648-1-christian.koenig@amd.com>
References: <20251031134442.113648-1-christian.koenig@amd.com>
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

This should allow amdgpu_vm_tlb_fences to outlive the amdgpu module.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
index 5d26797356a3..27bf1f569830 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -33,7 +33,6 @@ struct amdgpu_tlb_fence {
 	struct amdgpu_device	*adev;
 	struct dma_fence	*dependency;
 	struct work_struct	work;
-	spinlock_t		lock;
 	uint16_t		pasid;
 
 };
@@ -98,9 +97,8 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
 	f->dependency = *fence;
 	f->pasid = vm->pasid;
 	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
-	spin_lock_init(&f->lock);
 
-	dma_fence_init64(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
+	dma_fence_init64(&f->base, &amdgpu_tlb_fence_ops, NULL,
 			 vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
 
 	/* TODO: We probably need a separate wq here */
-- 
2.43.0


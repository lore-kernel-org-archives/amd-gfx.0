Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E0BCD6E7D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C246310E850;
	Thu, 13 Nov 2025 14:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G9MlpPx4";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB3610E834
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:45 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-64165cd689eso3401273a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045624; x=1763650424; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xwyu8SCiFn4mAgJ3pD0lgYvgHMUO+OEdoQazcZIs6fA=;
 b=G9MlpPx4OXjFXCOBgEFoASGNE23CR8mLrm1E03GzrnG8+3egiemaKIu1N+NBb7Deqe
 FG+AuoXvmCtNqQENabuLlU3LbbnEEwdfLlU51JJu0fHynvjE+k0R7kl7wzPYqH1iq9f6
 e53rSrCqjT+OjlZZCSSVGmXusvLr6NOfNhd95rEl9Yz44QfCvO59zvFFbgGuTbsfE9Su
 XlKJF1pduHHA0fKE1cTumJ3gHeMBoXQNzULp4hYOTTotP219kEUoEvwyx2iFW4z2+Ofd
 61d27DNB7JRtxdaj/43DzP1N1ABdtFTESIZlL+Ig1+7dkUsIUHThdQz0gauTRLzIWwMF
 0R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045624; x=1763650424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xwyu8SCiFn4mAgJ3pD0lgYvgHMUO+OEdoQazcZIs6fA=;
 b=OX3L3NfBxLEfgHlR1aMjRTg52/9J+wy97muUDijYA3FStwAYOHslGxe6D+L+aAw8OD
 qp4p/ykKryeLY6lPA87xbrG33DB+9ALxo8/BSW1+Y2OvEljRyUowRL4aFWDOC9/uklM0
 cVpkqDLYNmM057ieQZ+H3NWOfslqzZ2wNJ2+EHG2dZVJ8ftjnqEfCuZML6VnD41uzrAW
 89mp/LKoKnz8gIw2zTB4asbHoq8atcNk186qTf0LGm1spud1Pczo0LQgQmSPfmvjNlY1
 RauBmtjPz0/nlpxpovomkIFPrM1RspxXGrM43OVG6OwCfTqC2tO1FLaHqGDqY2vH97kj
 iqdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiLNL/VnumBr7CFYa4k23Ghu/drgfnx/nM0yp7bteVagwBGN5pxes2l/DeaKhNGaBj3B7hmMoO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjP2oVK8+4LZAzTl+MbfmxvKzCprHjFf4PsD5zlCY9m+dnZfjc
 u/SNeaptE61Chx1Wpb6ueoAc8H7Xa1u9ypp4kVEYIZC4GlEr8Oqk3VIS
X-Gm-Gg: ASbGncu03aNBN7OXLuTlwIsBCa+LyAvl3/SXYHGWAkHtcOc0oprS/lPWjeLgkQOFA/j
 ZHj0K2lOzI6l4iLNDH7RyelGfwRZVBQmtkUDzECsWTXcKOrf0xrVFe2qzqxot2O7pYEZ90mVBR8
 G/lkIu0G3j1iiruTgyOnLEEh8yf/3HX4MqV9RGd9G3NQtr10a2mduMXVPb7FnhRQnEhrI+Z8kvl
 tejYO66QABAU8rUis2en8W34R9gDP8g5rNEmNIpSg8mvhMVfj2U1qPHYB8VxlzQ2SGXjSmXrPIi
 PD1fdxKPHimHSg/yzyl9DaymaZi+AmbiGCtbRr5sLnbQ359N+SbVScTVu130dKFBZjCNElYJa6D
 RMp2/DTOX0Ax/BIeg03HQOFY3d89Lu+dsWnd2f7yftv6Q6i27kPvW/Qu44ERpScE2UQuCVqeKIC
 eckUOIO4r+baE=
X-Google-Smtp-Source: AGHT+IEw4YS4smpt6WicO5Q6hlDrx5fmWS4sNTZNppd+ozXro9T4f2MOiNnNLcV7TyOpypzG5Un2eg==
X-Received: by 2002:a17:907:2d14:b0:b04:48b5:6ea5 with SMTP id
 a640c23a62f3a-b734816d1fcmr419558266b.17.1763045624277; 
 Thu, 13 Nov 2025 06:53:44 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:43 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 12/18] drm/amdgpu: independence for the amdgpu_vm_tlb_fence!
Date: Thu, 13 Nov 2025 15:51:49 +0100
Message-ID: <20251113145332.16805-13-christian.koenig@amd.com>
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

This should allow amdgpu_vm_tlb_fences to outlive the amdgpu module.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
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


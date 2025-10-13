Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39D5CCD193
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8CD10E48B;
	Mon, 13 Oct 2025 14:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RVBUAbNG";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A086410E47F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:15 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-63a10267219so1364130a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366114; x=1760970914; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Is8QZraj0UZR9B5lS7sUfkvx3WgTUsZAN2+odc02EU=;
 b=RVBUAbNGcVm4d3tHGZ09+m5xA2qh+3BWoj1IUfeHBOLD+0HMss14isH6SHxkJk6KqX
 Is6sV6wOkj1FE6bCWEhS9dZGy1omsj+6njMDIbOamcG2AsUheqV7YHqLWoIYyh5iEDYA
 5v/uVTNe7duX6SsWe+vnSiUTD8trWth5Wkmt8/MLGixDLLOTwZSPneJG3dK2NzU39xp+
 a23TIVRCOFnMl329WOb6BSDdQ0v26pcqWyYmL11KpXQsN7mXjp0rdo+7+gBTdSKzIlPc
 vfcANxaFZhfJyR/GLxbrI6GPVGsMCvyCMfrTvUPlT9aJtarmferBejD2qt2MQ+xec+Fk
 awng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366114; x=1760970914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Is8QZraj0UZR9B5lS7sUfkvx3WgTUsZAN2+odc02EU=;
 b=JHfWBNWNeTiV7Q5IJ5R6neXe7XXkOkDnuAjwHJq4In5VB1q7SyOqDhDAuUPq5XMa+D
 SWXDjzHeO8MjHzR87xFIsxoLo+IUkTPq6Y9EIjMIZsPAdbW3ckH2nh6p83PTH8O2ncAK
 5kVKZaTEpF6zvVc7NarBOouLsO9tgJ8rrlRs5ZAoaNuB+Gu3kg6dpqzy5CmODKVYAsrr
 u1PXU7Uv5WrOZ8AePTiP9o2ltzwFo0p9NqyrfmU8JytyS1XRYH7GacUc8Z4qwYEW7LVp
 kOdLXj909XO+Ago/VqdlXAT36xW0h6aT04StZhNxjq/sXd4Mtz+V904njHqUCOzxgWEa
 B7dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPVXNCBaIuc64j8SUmpcWDnZCU9kVj+z5RyC4+greDH8CHCvXj8lpgvmcxz2pyu28Gi2C8hWIM@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzr7Xa6S6rsQM7Csc2E4gSfP3jIKuWjlCIydJYgudhB6yJPWJsH
 GH6vJRtWQclS8bHto5ZPSwOl1UuklH/hLR9ch1tkZ0pSJlvEZjep2jfx
X-Gm-Gg: ASbGnctYvqpyeGZ/2JKpNfALZMOs48ohbcVdeu7MH//g8gc0js3WdmwJ1V8w7/sOkZU
 4mRw7kU0VBQguQD9sslTGkUOokwo6QFWqjRxZm3t+v6mZqcCGw6ZFYzgPRpmF5hNi2tpiTtrlD1
 N+rY9HDsR41Gf19XLS/HxdI4Tl923l93lfluVYccMeGiO5AkN16ijgerN82rLnQHfsMGbBaF9nA
 f2tXr/Jt06UdkOic6a/8moBFDpPC4wTmUpP+OOu6tnL3zAZUPuqalZi40FU/FGSx5oWcElPJYYi
 TJwFl8luYQdDtxlCH9dTtq4bimFkwNSiiF54JGzoebk1DQPUTXaLfpcDQWlRPH0ChQQJNCvDXHM
 RPvrBHXZ6cg3Xl2GuxIk8PHUNGgMeGI+J89ci7DeNasqGcVw3Xy3KAMGDMIQjY6S1+Q==
X-Google-Smtp-Source: AGHT+IEHkjewj8JA1w5ONaRwGzsRRsO2qleReikOPcD9Iw8BZ1OG14hM7qC5770R/LT9jH/Mbzod6g==
X-Received: by 2002:a05:6402:202f:b0:634:bff4:524c with SMTP id
 4fb4d7f45d1cf-639bb134f57mr17333324a12.9.1760366114086; 
 Mon, 13 Oct 2025 07:35:14 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/15] drm/amdgpu: independence for the amdgpu_vm_tlb_fence!
Date: Mon, 13 Oct 2025 15:48:40 +0200
Message-ID: <20251013143502.1655-14-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013143502.1655-1-christian.koenig@amd.com>
References: <20251013143502.1655-1-christian.koenig@amd.com>
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


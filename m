Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9634CC04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E1C10E02C;
	Thu, 25 Aug 2022 13:31:58 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4916510E023
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 13:31:50 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id kk26so9874901ejc.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=zSvHFbj8Jj/2GkiIIoYhX+QU8HIZGxASz4FTnsYcUx4=;
 b=aVUIgbVZfz0595hfsFhoJXNBp91W2jeicy0lGr75OBm4B1IvpqIZ4SYQ6Vn/icxq/1
 tkceBT3UZpRFgX222KiE6d+DWQgcLY5d038zM4AUmh+hHGT/D9L3xq+44lss+sovxRby
 ktWNgAg8vUv2QfqAn31PH24enMAAXmX/ZDNPK0vLDeUyzKSda/a95UHSVsSduhkFmkig
 ERp1q4ngYkga75Zjh42LiwyQw4idqopSAO6JNgr4MRH7+s1/z8vMPKGeURFKchBMgJme
 WPXSllNeACazj9qYim3FZMqz0ru0NAJr8/dhnEfa7Q3fez4i7Qm0ANdEsXsG2G4OvI4S
 qDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=zSvHFbj8Jj/2GkiIIoYhX+QU8HIZGxASz4FTnsYcUx4=;
 b=u4lv+K+lJsLSMsUYBkaVRWb/pSsleGls2/ZS9PQUBSkGxPCKQfO+Fuo89B/DwCa9OF
 wRWz44Fiy7qGj/h2p2zGGKMHgwS84dRHIV3t90Im0oMFopEZyLhVMtwVGa2yLCki2IeN
 W47N272MBHZOIUVvGQAnTe6AuKJnASi58JXr+YWpVZgIPwLQF/2PRWF16zOOWYoZ9Jgt
 1U/hvlk7iJf2Ccgu6o95pFkra/aNJhMocVDjN5oWONaWCPQUItnO4AYkysqCyw5c6l8d
 d9Ttvi40si7bUQJikjyZafDLKenaGsOjNfnaGsW4gVzu5i01coy9frE+8Y0WOFas/8fV
 OANQ==
X-Gm-Message-State: ACgBeo3y66BE5v1iOuYs514TC+rkycNtDobqpC7C057io2xrom9HYtnA
 KesBjjg81Qw8AUeRZ/NhyNSKGKfypXAEvQ==
X-Google-Smtp-Source: AA6agR4C0OCbMi2Kr3Qu6xh2BWywz+/JTcxhRwD0Nk3uffo1oPjduwokKd5M10/Xe0iKJePCCtydfQ==
X-Received: by 2002:a17:906:98d4:b0:73d:7f33:98a8 with SMTP id
 zd20-20020a17090698d400b0073d7f3398a8mr2485093ejb.90.1661434308855; 
 Thu, 25 Aug 2022 06:31:48 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a509b12000000b004404e290e7esm4913471edi.77.2022.08.25.06.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Aug 2022 06:31:48 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/11] drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP
Date: Thu, 25 Aug 2022 15:31:34 +0200
Message-Id: <20220825133142.8272-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825133142.8272-1-christian.koenig@amd.com>
References: <20220825133142.8272-1-christian.koenig@amd.com>
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
Cc: Alexander.Deucher@amd.com, bas@basnieuwenhuizen.nl, timur.kristof@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Trigger.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use DMA_RESV_USAGE_BOOKKEEP for VM page table updates and KFD preemption fence.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cbd593f7d553..85eb68ec692e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -297,7 +297,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	 */
 	replacement = dma_fence_get_stub();
 	dma_resv_replace_fences(bo->tbo.base.resv, ef->base.context,
-				replacement, DMA_RESV_USAGE_READ);
+				replacement, DMA_RESV_USAGE_BOOKKEEP);
 	dma_fence_put(replacement);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 1fd3cbca20a2..03ec099d64e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -112,7 +112,8 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 		swap(p->vm->last_unlocked, tmp);
 		dma_fence_put(tmp);
 	} else {
-		amdgpu_bo_fence(p->vm->root.bo, f, true);
+		dma_resv_add_fence(p->vm->root.bo->tbo.base.resv, f,
+				   DMA_RESV_USAGE_BOOKKEEP);
 	}
 
 	if (fence && !p->immediate)
-- 
2.25.1


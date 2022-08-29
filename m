Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2E5ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 13:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E52310F1E8;
	Mon, 29 Aug 2022 13:18:43 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1937A10F1C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 13:18:29 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id se27so7903219ejb.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=zSvHFbj8Jj/2GkiIIoYhX+QU8HIZGxASz4FTnsYcUx4=;
 b=Ng80ttPQ9LsYc+7I6UbcfH7sYYevEaPoxIU2T+B/DUqFnzcg5nHRmY9LYMSe91H54b
 V+UWLZYbpm4QLt8pRb6rNpdVh48IS1MO6nZ+y9H9cEHLmDqEG168DdYlSfeNHQhRhbMs
 7ng3v80u9n/tumczDOYfIVmVG311+DA0I3AtJsplu6UHhHCoUY0ZLaBGv/R//V/sBoUK
 c2YTcRO6agp9YfqocTwpCQtFxFHXeu7BlJkY7cPgjy0pOpyTIM70mtfmwqQNsiEO99LV
 ZOCmvmUuaDycR3nqy4zLVA4MpImvDfY58AMjiVqJHwu1jsx45EWCPMy/RtszsYLOHRSK
 /BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=zSvHFbj8Jj/2GkiIIoYhX+QU8HIZGxASz4FTnsYcUx4=;
 b=Ot1Mp8mU/2uE0MD73kM9KWBegch5cpT6Gpw5qdtG9McXHYMX5gDM0DfQWmjOPzhC7T
 sLJrm97Jhpxu1advgfg0WFy7gRxdCw119Gi5dfrnd4RW5dSEKPQjUCvHtBO/quijlXCK
 0W3jabrIJ5j5NF2IFbOyywgs/XcqOaWFNfRwdDfzs66aN/g2/48yzo7XSRVEAzViMtTQ
 /WFnLkxeDa00Sjtrg+BYL4N6ARHv7f0TjXLnCUrYmzT1dTsk+EmLa5pQDFiLKaEnqkAB
 ViZ2UyzEjwxZa3Ib750as3qlxaM3IrYxS2iugj4ffFPAzZN/KAZ/PD6f9ARrg4pl8xud
 1wig==
X-Gm-Message-State: ACgBeo1Itg3Qi2a47Ae0FB9S4uDAJvFIcc2djo0WU+JvMYSFLnbhfEdq
 fsTn68TWvU+55x8Bbzsrgoo=
X-Google-Smtp-Source: AA6agR6lobMfpxZ1BHGdYzwn//GeM3bOhY9SMHgg6NmAk4fVuPu20gELWVmt9Vly9tuiNGPgeLgjKQ==
X-Received: by 2002:a17:906:730d:b0:73d:c8a1:a6ae with SMTP id
 di13-20020a170906730d00b0073dc8a1a6aemr14021829ejc.540.1661779107657; 
 Mon, 29 Aug 2022 06:18:27 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a50cd16000000b00445f9faf13csm5726218edi.72.2022.08.29.06.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 06:18:27 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ruijing.Dong@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/11] drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP
Date: Mon, 29 Aug 2022 15:18:13 +0200
Message-Id: <20220829131821.2049-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829131821.2049-1-christian.koenig@amd.com>
References: <20220829131821.2049-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
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


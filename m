Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90691C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 10:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F5FA4504;
	Thu, 14 Jul 2022 10:39:12 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC36A4586
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 10:39:10 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id r6so1836208edd.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bEM4O6fL8TrEuec7hcIMgqyfBF1EtfhleKeiv3fWxLs=;
 b=mTADyEYPjscselwf/fFhjXvdsAF4XGHVw3OBtyR5lRGA61oKBJrDpm6eX4C/PRK8xL
 yw03rxBpAhmfKR4b47URkJpR23M6j3Qv06UIHbJqLKMPYhyfXJTM74MfHc6j7VLYwYLz
 0FExtDx3EYOkUVFDf5QMvm8RZ1FBfIY+ItwjdRe8rFWHqysRCRxErHFzrnVxwlfIoNAT
 q0BnBV16AFu/oRhg6qjg4NKiv/EZsDtuIy5nAEGpH2LBTYByyMs1LwgSoFzG2RJOcAHi
 POP6OTGcjXLM4LMy/J+OuD4aBdIUhtDSYL5xc5j4Cba3veJPj4MRyKL2OeEC3Hyu20Z+
 bkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bEM4O6fL8TrEuec7hcIMgqyfBF1EtfhleKeiv3fWxLs=;
 b=BGB1ba2bR/v+Z3d4CBdGifpxINL/8b2raCGpoBoMC7Pmvij2t81WNfKYhhGQLdFXqh
 Vhz03p9GC8+kXG+r3xZX8NjcMRWsPPc0oD5mTkNsCnZ0NmTOvBbpxi3ZFnrjul+NSZUX
 iDSxaiYzgMDji3aNCwruZEvO3ZwnqX+APpQZAWjkP0Eh5t2hVGgmlt+583sec/t2BzUD
 v6JKmU7j9IpOBefGfpgIYbJ3l+zgN/RdIu25hrJZqW7gxf2fGbIz9MeMO9oQXNiUIv6Y
 PxZDS6D/mcTUgJrH6PnI1S6ydCnef4b1VD6djT872MUANKGOzimd9tHcVT6NzoDZzdXo
 dfUg==
X-Gm-Message-State: AJIora+sQjlR/EqIUmkBFq/LZfv3OihcDc63e70RsZVzz728oSmoTB2Q
 BVHAddEvRwcBEiQtXW7EeTyHGhBo76M=
X-Google-Smtp-Source: AGRyM1vAG2PKee6ZU94/DvX2WzxB7qKBWXlJEQBRf/zmndb9XrbsBqTsXwrCOybIvJpXjoEXJsfYBQ==
X-Received: by 2002:a05:6402:13:b0:439:ffe8:bec9 with SMTP id
 d19-20020a056402001300b00439ffe8bec9mr11604293edu.297.1657795148998; 
 Thu, 14 Jul 2022 03:39:08 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
 by smtp.gmail.com with ESMTPSA id
 z13-20020aa7d40d000000b0043adc6552d6sm799487edq.20.2022.07.14.03.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 03:39:08 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com,
 timur.kristof@gmail.com, andrey.grodzovsky@amd.com,
 Yogesh.Mohanmarimuthu@amd.com
Subject: [PATCH 04/10] drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP
Date: Thu, 14 Jul 2022 12:38:56 +0200
Message-Id: <20220714103902.7084-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714103902.7084-1-christian.koenig@amd.com>
References: <20220714103902.7084-1-christian.koenig@amd.com>
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
index 581c7ae41102..c6de30cffa2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -314,7 +314,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
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


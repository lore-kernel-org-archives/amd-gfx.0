Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF66C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 09:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D2910F293;
	Thu, 31 Mar 2022 09:47:35 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFC810F28D
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 09:47:32 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id u26so27474079eda.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 02:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b/o/4Q7FbPZIXfLgLHXP6RWr+2P2tSBzio2EmZkDcVs=;
 b=A0pQSGWp74dP0rqpOmENU6TXoZW1xsjfMiWfad/TZDBDV2VIQKoVG803ER4KvuLcyi
 sovUF/hT8cymXYyYA2kgB5pMn6svnuqmMUeoMRFKsjOVhhFnk9EfTXYg0yP2m/n4eklp
 m+1kV6BzOVjaQtOTqxKO0RQBvnPy2smJXZHO05VjABu1Z9ffM+zih8bqWHjH/2w3UVYD
 660hPXDPPVH8P+5JQLGth58h47YdqWHfg8BVoajuOQ/tlpQwerhkp/wy9d11AIyaF9gh
 gB6ZVamzHQMlk9T5zJbN2l/15bomTauTRafgcc0QEVtKKU6MVjLti8A6jWnoQXuj9BEI
 inGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b/o/4Q7FbPZIXfLgLHXP6RWr+2P2tSBzio2EmZkDcVs=;
 b=YbKIxEXcsq+GkW4tnvZfqDtefXS2bzqfF2EzpwyuVdr0yf9SReLUNVjWnap6k6SQeR
 sescVKyWaRVrkIlkbGJH5GU44MK0Hb6tSnf6Efe5y0ceoVFK4n2py6ynNsDx+AOtdGOs
 gAYhYR4jEpXCaYMSEGVE6ntGn8umz0CJD/mZb0Hpi2FGoU8yHDJ7EOYb92qqgxYSe3XW
 Th3NLAAK44vuBUGLa1D1nrhOqqSL7Zt0mMVIj/SHUsviq1+1Nmjj/ft8AlhlEdBvJiVy
 JN66HEFp+oEur184T4utrxlyd/6dXrWn6kUq/7pqrrxGVExcT5ObiMUmD4mUAAgkyJXA
 3qWQ==
X-Gm-Message-State: AOAM5333/F9fXDmPQW4JYc7Hn034RsuwUDE9fl6hSGokukC9oQQRifMA
 5CdDMHGF6SWTYFZbe6l9C4w=
X-Google-Smtp-Source: ABdhPJwTjf6C0SfAKK0WezqOchDBIQ8ifWednyo3Lrg4hQAF4uIgZqXupCjmz/oBmzHaMssoIiE8oA==
X-Received: by 2002:a05:6402:909:b0:416:6f3c:5c1d with SMTP id
 g9-20020a056402090900b004166f3c5c1dmr15749783edz.108.1648720051071; 
 Thu, 31 Mar 2022 02:47:31 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 qk30-20020a1709077f9e00b006dfae33d969sm9249202ejc.216.2022.03.31.02.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 02:47:30 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: bas@basnieuwenhuizen.nl, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: add separate last_clear tracking
Date: Thu, 31 Mar 2022 11:47:24 +0200
Message-Id: <20220331094727.27153-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331094727.27153-1-christian.koenig@amd.com>
References: <20220331094727.27153-1-christian.koenig@amd.com>
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

Add separate tracking of last cleared of freed mappings and use this as
dependency when freeing GEM handles.

Still heavily oversyncing, but better than undersyncing.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 14 +++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 ++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2e16484bf606..4509a59d499a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -232,12 +232,12 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 		fence = NULL;
 	}
 
-	r = amdgpu_vm_clear_freed(adev, vm, &fence);
+	r = amdgpu_vm_clear_freed(adev, vm, NULL);
+	fence = vm->last_clear;
 	if (r || !fence)
 		goto out_unlock;
 
 	amdgpu_bo_fence(bo, fence, true);
-	dma_fence_put(fence);
 
 out_unlock:
 	if (unlikely(r < 0))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 11ebfef6962f..3f73e6097e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1286,15 +1286,17 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		}
 	}
 
-	if (fence && f) {
+	if (!f)
+		return 0;
+
+	if (fence) {
 		dma_fence_put(*fence);
-		*fence = f;
-	} else {
-		dma_fence_put(f);
+		*fence = dma_fence_get(f);
 	}
 
+	swap(vm->last_clear, f);
+	dma_fence_put(f);
 	return 0;
-
 }
 
 /**
@@ -2084,6 +2086,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	else
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	vm->last_update = NULL;
+	vm->last_clear = NULL;
 	vm->last_unlocked = dma_fence_get_stub();
 
 	mutex_init(&vm->eviction_lock);
@@ -2198,6 +2201,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	}
 	dma_fence_put(vm->last_update);
+	dma_fence_put(vm->last_clear);
 	vm->last_update = NULL;
 	vm->is_compute_context = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 1a814fbffff8..be82ef170926 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -272,12 +272,13 @@ struct amdgpu_vm {
 
 	/* BO mappings freed, but not yet updated in the PT */
 	struct list_head	freed;
+	struct dma_fence	*last_clear;
 
 	/* BOs which are invalidated, has been updated in the PTs */
 	struct list_head        done;
 
 	/* contains the page directory */
-	struct amdgpu_vm_bo_base     root;
+	struct amdgpu_vm_bo_base root;
 	struct dma_fence	*last_update;
 
 	/* Scheduler entities for page table updates */
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD513CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 12:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3BB10E7EF;
	Tue, 13 Oct 2026 12:38:21 +0000 (UTC)
Received: from smtpout3.mo536.mail-out.ovh.net
 (smtpout3.mo536.mail-out.ovh.net [51.210.91.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648CF10E7EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 12:38:14 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4j3v5013JNz823H;
 Tue, 13 Oct 2026 12:38:12 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Tue, 13 Oct 2026 12:38:11 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.178.179])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j3v4z6q6Fz6MYc; Tue, 13 Oct 2026 12:38:11 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.10])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 889F18E1F7E; 
 Tue, 13 Oct 2026 12:38:11 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005cbf66111-eca4-4d59-b2b5-477a155000e6,
 44FB1AB537259644B014B36C627AC91C42160B90) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Nuke bo_va->last_update
Date: Tue, 13 Oct 2026 14:37:55 +0200
Message-ID: <20261013123755.1072382-1-nat@pixelcluster.dev>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 2752543799511441908
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEIaSqqbY2+M7pduwnq0b5HHjaYIf/ewQRy/9iwubkW8VsewncD7yq789WV5MM4iLfTNiBW6wqrOW2hn5AGUVc0VBtaBfY6xb0SlGwfCX8HLkNfkj9ERhOkN0C2AFQG0ziGUqShFpwJ8i1vgZOyElyzuZb5N6I0QymBY9AOnr0vMXCqbeBW63lGIyBZkxH8/0ArDNBI7N58vO+5XTfoad9QHIXaRY7lTuEzhCxidiD5s4sQTuyGPVr8WEU3dkehco595pZ66eGgZdEbwSAOET4/HBrW0jjEdaOeeCS3qpLrW1lMHDWWx8bxPmkIEQK5YZCDQD3wxGp7aOq3RQ874xXtf14SL/LIqtzUjje+MSim7bncvZaIyOuIyd+CZsTzeJyP1Mbphq/JsNR2tAmYx3vKQzMzYCLx+Hgs+RdE8/eYSV5lZlSAVow/fvRt/RpsYBVtY0jaZsSNwyaN3DtBJVRjvXec2lv9ZghR5Qs/dq24OQHHDeeJwaNvWkUHLhynASVUW21ouIStpR/9nlww4B6jL2Xcwt1IX38mqTv9N5fvYlr/FS9MJDZgOmpz9eGxHHXi7mlyqLBzbES5/0zfYQafgLValZdRmmmzt8f/i4vdwdtCK4eIul08trnYl1+k7y2HPw2Qq7oeD5Iu7WVgQHSoVpQatYOpNPVRgWUhobfPzA
DKIM-Signature: a=rsa-sha256; bh=dWRkuWvZv0tkV6r4ONxT9atNcFW5aBDIbwdA7Yy6XXk=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1791895092; v=1;
 b=AmXhfXOQ0qcljiEN0EDRnNNv97lT5s5Bo/rcBVUjCwkly++k15dc2uKfGSwOxSBvgLVGUqB2
 nS2rWHEaC9dqlAJQ59uLTCHPWXSo7tdJ9uIHQnvCBu+JcqUJk1w/WLIVbxY5BNmbWgU+GtiFLqJ
 1RVCBxY9KpuYdiaL83WFxf974c0Os77V//hG6qqtQzg48CHsD1GgV36HN/uRx75GBFcKTvEpjmI
 dKhYDpa6Ryye6vwj08lyiCV4Bggu1WkGMkVorlEY5lI/q03qDjp92xGIqt7V7tHSZ3e38fumdGa
 nq/csgEVUN0AAX+0xwLtGxemHsa44maKiP8UTSaohW9pw==
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

Tracking the last update per bo_va was an optimization for apps that
keep lots of buffer objects around that never make it onto the buffer
list. This isn't a very common usecase (anymore), since usage of
VM_ALWAYS_VALID buffers is much more prominent nowadays.

Since it complicates lots of things, just remove it.

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 15 -------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 21 +------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 13 ------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 17 +++------------
 6 files changed, 7 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a5d1d83ee5d32..11ecaace3f3d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1285,9 +1285,9 @@ static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
 	if (!amdgpu_vm_ready(vm))
 		return 0;
 
-	(void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
+	(void)amdgpu_vm_clear_freed(adev, vm, &vm->last_update);
 
-	(void)amdgpu_sync_fence(sync, bo_va->last_pt_update, GFP_KERNEL);
+	(void)amdgpu_sync_fence(sync, vm->last_update, GFP_KERNEL);
 
 	return 0;
 }
@@ -1311,7 +1311,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 		return ret;
 	}
 
-	return amdgpu_sync_fence(sync, bo_va->last_pt_update, GFP_KERNEL);
+	return amdgpu_sync_fence(sync, bo_va->base.vm->last_update, GFP_KERNEL);
 }
 
 static int map_bo_to_gpuvm(struct kgd_mem *mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d059e0c928669..c4f1a49b8519e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1142,21 +1142,11 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_fence(&p->sync, fpriv->prt_va->last_pt_update,
-			      GFP_KERNEL);
-	if (r)
-		return r;
-
 	if (fpriv->csa_va) {
 		bo_va = fpriv->csa_va;
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
-
-		r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
-				      GFP_KERNEL);
-		if (r)
-			return r;
 	}
 
 	/* FIXME: In theory this loop shouldn't be needed any more when
@@ -1172,11 +1162,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
-
-		r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
-				      GFP_KERNEL);
-		if (r)
-			return r;
 	}
 
 	r = amdgpu_vm_handle_moved(adev, vm, &p->exec.ticket);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 374f1322c3ee4..a35f641a554f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -836,26 +836,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	if ((operation == AMDGPU_VA_OP_MAP ||
-	     operation == AMDGPU_VA_OP_REPLACE) &&
-	    !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
-
-		/*
-		 * For MAP/REPLACE of non per-VM BOs we need to sync to both the
-		 * bo_va->last_pt_update and vm->last_update or otherwise we
-		 * potentially miss the PDE updates.
-		 */
-		fence = dma_fence_unwrap_merge(vm->last_update,
-					       bo_va->last_pt_update);
-		if (!fence) {
-			/* As fallback in OOM situations */
-			dma_fence_wait(vm->last_update, false);
-			dma_fence_wait(bo_va->last_pt_update, false);
-			fence = dma_fence_get_stub();
-		}
-	} else {
-		fence = dma_fence_get(vm->last_update);
-	}
+	fence = dma_fence_get(vm->last_update);
 
 	return fence;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 2e6a8e6f577a7..ef13a7bc55034 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -80,7 +80,6 @@ struct amdgpu_bo_va {
 	unsigned			ref_count;
 
 	/* all other members protected by the VM PD being reserved */
-	struct dma_fence	        *last_pt_update;
 
 	/* mappings for this bo_va */
 	struct list_head		invalids;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e29823ae8672e..e674309599f44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1188,19 +1188,6 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
-	/*
-	 * We need to wait for all VM updates to finish before restarting the
-	 * queues. Using the idle list like that is now ok since everything is
-	 * locked in place.
-	 */
-	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status)
-		dma_fence_wait(bo_va->last_pt_update, false);
-	/*
-	 * The PRT bo_va is kept off the state lists, so its PTE update fence
-	 * lands in prt_va->last_pt_update rather than vm->last_update; wait on
-	 * it explicitly (as the CS path syncs it) before restarting queues.
-	 */
-	dma_fence_wait(fpriv->prt_va->last_pt_update, false);
 	dma_fence_wait(vm->last_update, false);
 
 	xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7d3659ef11e53..5756d4d9f9ba6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1287,7 +1287,6 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	struct amdgpu_bo_va_mapping *mapping;
-	struct dma_fence **last_update;
 	dma_addr_t *pages_addr = NULL;
 	struct ttm_resource *mem;
 	struct amdgpu_sync sync;
@@ -1359,11 +1358,6 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		uncached = false;
 	}
 
-	if (clear || amdgpu_vm_is_bo_always_valid(vm, bo))
-		last_update = &vm->last_update;
-	else
-		last_update = &bo_va->last_pt_update;
-
 	if (!clear && bo_va->base.moved) {
 		flush_tlb = true;
 		list_splice_init(&bo_va->valids, &bo_va->invalids);
@@ -1393,7 +1387,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 					   !uncached, &sync, mapping->start,
 					   mapping->last, update_flags,
 					   mapping->offset, vram_base, mem,
-					   pages_addr, last_update);
+					   pages_addr, &vm->last_update);
 		if (r)
 			goto error_free;
 	}
@@ -1770,7 +1764,6 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	amdgpu_vm_bo_base_init(&bo_va->base, vm, bo);
 
 	bo_va->ref_count = 1;
-	bo_va->last_pt_update = dma_fence_get_stub();
 	INIT_LIST_HEAD(&bo_va->valids);
 	INIT_LIST_HEAD(&bo_va->invalids);
 
@@ -2018,8 +2011,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	if (valid)
 		list_add(&mapping->list, &vm->freed);
 	else
-		amdgpu_vm_free_mapping(adev, vm, mapping,
-				       bo_va->last_pt_update);
+		amdgpu_vm_free_mapping(adev, vm, mapping, vm->last_update);
 
 	return 0;
 }
@@ -2243,12 +2235,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 	list_for_each_entry_safe(mapping, next, &bo_va->invalids, list) {
 		list_del(&mapping->list);
 		amdgpu_vm_it_remove(mapping, &vm->va);
-		amdgpu_vm_free_mapping(adev, vm, mapping,
-				       bo_va->last_pt_update);
+		amdgpu_vm_free_mapping(adev, vm, mapping, vm->last_update);
 	}
 
-	dma_fence_put(bo_va->last_pt_update);
-
 	if (bo && bo_va->is_xgmi)
 		amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MIN);
 
-- 
2.56.0


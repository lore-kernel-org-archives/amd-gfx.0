Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE7CCD4F25
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 16:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2357410EB88;
	Tue, 12 May 2026 16:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M7CL/mgD";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABE110EB81
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 16:27:15 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45ae6a0e523so665991f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778603233; x=1779208033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RhJN4E9jQbv28dLu4tO0gFzC2NjmiWnPF+N21Fc3GOA=;
 b=M7CL/mgDnNeX97pARkG0rEBEzNeLuKzbmdX/3R0EppCmAyAJBa2K4ta6YSPpLCIKNq
 tzqVQgliSACQdATbgsSWf/FX6+uBHbnbyOTyRUukaJ6/uiXqcUDzOQwss5jek/b9yxh6
 mqyhbHbJuLo8m0ErdGt4VzCVx8sgnXjjoc+QE1z2LoFzmywqc5e1bEH7LEmi03nEpnlK
 1FcPPjcp3fY57hJzDx/P3D1QaYiBdXl+biYePsrrH3xHsLCpZVguKELmS6QqC+RMSe2R
 rCNLeMrlCIeoVj5NGFw+cRMoy47OHri/ziOCx/aPkcRYr521dw7phzi36j4QRiqaRQFk
 qkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778603233; x=1779208033;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RhJN4E9jQbv28dLu4tO0gFzC2NjmiWnPF+N21Fc3GOA=;
 b=bV01/oC+V6nTyHp78B6ThcpEiFO8ORMLbk46bhuDVfTBEB5vwvLh70Egx+PA0EsKJN
 3b+25gLHpnmsE9+6dBf71rSBaE/mDWpKRFLr/vuQxY9WjTTsYU8rh+suWdQLp5vw8KfO
 rZygY+eVIZgk7PnHDgkoKHktzfqY+wWPij7KFWLlTHCK1jl0GgPhctSGcRuwbxRe1ORa
 cIejxZ+W+Vt/jqerTw69o4B6hjKFhVEsfvelG/ssTa/+NR7XRrwQlfYhfystLYP3J5pj
 2FHbGixt8Pq8pi41zAE2bvybGCs3i28GxYCAdVFKLmNTH3z1mHQ+J/HjnRfP10XQqcuI
 WMOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kfqLdT4yzI9zsubTqYmPZ2j+L8R5Qu9zHbx3OCVT7poCsR38SlNlQcvjPN0MBpmaw06dI88v/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6WyvNVFD8+QTy26zrvqljsa324jZUXKIUDl2BLPfQWOyx40oM
 JcrAB9Fmt8NSjxhXIhl3iyE5eico8E7sFhjs+WQ+lD3NjkkXfy66nwgo
X-Gm-Gg: Acq92OHxuaRQGRgv4gTpjzs45bq16ezK89QyuC8xECJ+mdDdu3BcAf0zKJBbx+m5x63
 Ed/7F46mn+5pNprL3BWFGoZq1gsB1TeLur4fI4LZ0OEsUJJgQrPTLRMh0CpZJwLcnjbDkJOuqlZ
 k+5KAEiqzWktiVmG2eQofz8WkRZqn1d/V0PPHrVXOzayrOAmi0m7aK6T9b0x+5F0HZLcNJqEkUm
 wdvyqVoNCRgiZ7fW1mKbAIZ9EfeHFXyeBowjes9Q8Q4xHOPfHXEn6IzHEs080oUjGgknfbPdU0E
 QPtBnV6czBgN8+XHsWEK65XL27TGG55zicswxfoTOQCo04ea/WJMJsrfeJohs1zNbHpA/AaoSKb
 ziaNYTN5ROZFIVfir9Rhl/1Hm+OiXexgvn6mBIUah7en3IwltHKFPUR0HKDpK5frdLb6zYutVfG
 +4tPTHPFeTumdKmBoOI61sgoLVz5jGfWCaD4Hv
X-Received: by 2002:a05:6000:1847:b0:43d:a37f:8d5c with SMTP id
 ffacd0b85a97d-456974835dfmr22891767f8f.17.1778603233422; 
 Tue, 12 May 2026 09:27:13 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b9:5900:3e99:f03a:ee63:3e8e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120ec0asm33019349f8f.17.2026.05.12.09.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 09:27:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: vprosyak@amd.com
Subject: [PATCH 2/4] drm/amdgpu: fix calling VM invalidation in
 amdgpu_hmm_invalidate_gfx
Date: Tue, 12 May 2026 18:27:09 +0200
Message-ID: <20260512162711.51118-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512162711.51118-1-christian.koenig@amd.com>
References: <20260512162711.51118-1-christian.koenig@amd.com>
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

Otherwise we don't invalidate page tables on next CS.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index eb470e252399..5d72878c8fe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -76,6 +76,7 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_interval_notifier *mni,
 
 	mmu_interval_set_seq(mni, cur_seq);
 
+	amdgpu_vm_bo_invalidate(bo, false);
 	r = dma_resv_wait_timeout(bo->tbo.base.resv, DMA_RESV_USAGE_BOOKKEEP,
 				  false, MAX_SCHEDULE_TIMEOUT);
 	mutex_unlock(&adev->notifier_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 82a1c19350ee..cd82541ad5d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1631,6 +1631,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_va *bo_va;
 	struct dma_resv *resv;
+	struct amdgpu_bo *bo;
 	bool clear, unlock;
 	int r;
 
@@ -1650,11 +1651,13 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
-		resv = bo_va->base.bo->tbo.base.resv;
+		bo = bo_va->base.bo;
+		resv = bo->tbo.base.resv;
 		spin_unlock(&vm->status_lock);
 
 		/* Try to reserve the BO to avoid clearing its ptes */
-		if (!adev->debug_vm && dma_resv_trylock(resv)) {
+		if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
+		    dma_resv_trylock(resv)) {
 			clear = false;
 			unlock = true;
 		/* The caller is already holding the reservation lock */
-- 
2.43.0


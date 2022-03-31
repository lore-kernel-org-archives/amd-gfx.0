Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E51C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 09:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB53C10F28D;
	Thu, 31 Mar 2022 09:47:32 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86EA910F28D
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 09:47:31 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id c10so28506701ejs.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N2tgfwtfyhZda621948VgUHaCj8sb8lbdIhBgirGfNA=;
 b=dvCav8fMiYJgyczSpskLWJbtyN6jnZE0xYCX7vuPwSho1Sco4Z/EXLqjGBJA1992Hi
 hs3FHkTf6DUkYU3/Iz5oj88CcbTagBb2vndfsN0vTEGoBd86g0Pt+wJX5CLj7pktxtqa
 pda+wjEz5Xq59yPZejKnrTe3OXAH5NVxibmgHM67k1nkjdrA3s5NwTlYoUPLTVoU1JrW
 YtL6uPWx8G1IJ/L+ytr2L49g4Y13SPnII2/3Tt/ZdAP29hQ8/1gxKw8RDTsN/LtkZjVA
 ADsApjjX0D99wFvLXAtXGpEuhexxXNbxaianwlHYw8oAdSaqV9NsFdw+43024DcBL+k6
 l+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N2tgfwtfyhZda621948VgUHaCj8sb8lbdIhBgirGfNA=;
 b=FPTeHXRt7/oEpyuAZ7C+W0Pq9OUVJyl05IVwxZU6yPz6l623Xq240V+DWyyWERAunI
 8soEqc/Z7br/YVWXVCNhqFtIFrBGCLzfRMG+r3FGyCjEjPOqbpGuhfMqOkiMAniaoO6g
 ocKuSEefxZZ7V+QaKm1BazsfC6TBCksTyDY6KQbkOgdEqw8OOVMTqaBS3vUA79NyEl6v
 NFhyBPx6Q4x3Bxj5K8uZOQr/XRmrmEJZqX7nE1ee9eG0/uQ+EGaXSSCPjVl6DJhe5j8/
 K20wzkJwy/5durvUy1mTErj3gJAeUIe/xVYpTKRnEmQUsQSHFVQDv3iMZNlv9jzRVKy8
 Yc+g==
X-Gm-Message-State: AOAM532AgjSDuIbXnvCcq78mhygSdP/8riAAq6aOuJhhC2vkU3S6r77Y
 roTgReOa3UdPrXAxy53ol6WDikK5s6U=
X-Google-Smtp-Source: ABdhPJwKciFK9KELBXdA/LUH552G7ZXU2R4v2GZHAZRzEIf03Ut1OjIsTmNPuWuFEHX8IvaCFmxkaA==
X-Received: by 2002:a17:907:2d89:b0:6df:b7d1:a365 with SMTP id
 gt9-20020a1709072d8900b006dfb7d1a365mr4534845ejc.386.1648720049957; 
 Thu, 31 Mar 2022 02:47:29 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 qk30-20020a1709077f9e00b006dfae33d969sm9249202ejc.216.2022.03.31.02.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 02:47:29 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: bas@basnieuwenhuizen.nl, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: cleanup freeing delayed mappings
Date: Thu, 31 Mar 2022 11:47:23 +0200
Message-Id: <20220331094727.27153-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

Move the list_del() to a central place and use list_move for the rest.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1cac90ee3318..11ebfef6962f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1215,6 +1215,7 @@ static void amdgpu_vm_free_mapping(struct amdgpu_device *adev,
 				   struct amdgpu_bo_va_mapping *mapping,
 				   struct dma_fence *fence)
 {
+	list_del(&mapping->list);
 	if (mapping->flags & AMDGPU_PTE_PRT)
 		amdgpu_vm_add_prt_cb(adev, fence);
 	kfree(mapping);
@@ -1269,7 +1270,6 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 	while (!list_empty(&vm->freed)) {
 		mapping = list_first_entry(&vm->freed,
 			struct amdgpu_bo_va_mapping, list);
-		list_del(&mapping->list);
 
 		if (vm->pte_support_ats &&
 		    mapping->start < AMDGPU_GMC_HOLE_START)
@@ -1597,13 +1597,12 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
-	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
 	trace_amdgpu_vm_bo_unmap(bo_va, mapping);
 
 	if (valid)
-		list_add(&mapping->list, &vm->freed);
+		list_move(&mapping->list, &vm->freed);
 	else
 		amdgpu_vm_free_mapping(adev, vm, mapping,
 				       bo_va->last_pt_update);
@@ -1803,14 +1802,12 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 	spin_unlock(&vm->invalidated_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
-		list_del(&mapping->list);
 		amdgpu_vm_it_remove(mapping, &vm->va);
 		mapping->bo_va = NULL;
 		trace_amdgpu_vm_bo_unmap(bo_va, mapping);
-		list_add(&mapping->list, &vm->freed);
+		list_move(&mapping->list, &vm->freed);
 	}
 	list_for_each_entry_safe(mapping, next, &bo_va->invalids, list) {
-		list_del(&mapping->list);
 		amdgpu_vm_it_remove(mapping, &vm->va);
 		amdgpu_vm_free_mapping(adev, vm, mapping,
 				       bo_va->last_pt_update);
@@ -2258,7 +2255,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 			prt_fini_needed = false;
 		}
 
-		list_del(&mapping->list);
 		amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
 	}
 
-- 
2.25.1


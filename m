Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733C4CA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 15:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0157110E8F3;
	Mon, 28 Sep 2026 15:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LET67C2A";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A48D10E8F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 15:10:47 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4887f6cf16bso1945972f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790608245; x=1791213045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Qkvx6iMKqvzyE0haJvDT6sjlZuPzw+/RRd1RnrIRPbo=;
 b=LET67C2AuynxYaQtFLyTRst5VaEAZK+iKCJbrOgDtGpQS6w0WOQYDG/KuP72Xi3ClP
 fyodk+jJ99aHo5w1G1wa8+I6bW5o2Xyl2v8mh8I31AflCb+XOzHcBOKLAJcb2TH7P4UK
 zEEiuL4PPYRZSHpjnrsL5Tn1M8bq7LlGurEyitBg5fxs6n5d3S70CnYiUnooFI+dxD/S
 3egtto1CVgSRAXNSWSsJwsT3q/YCQp0tAHMHLjFyOYHaGouaLskYMSoB4sZshMWZFsMJ
 hEF3nbhfJ1Pl9TxqqgPC1/k7LU8d85THieyflKbygKqn47mIgKjoCFJLQ1BkPlzfPHOx
 LXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608245; x=1791213045;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qkvx6iMKqvzyE0haJvDT6sjlZuPzw+/RRd1RnrIRPbo=;
 b=mhWK2bt7hh8SiiECfZpStS8RLiSuhqcry3mOmltbuDHEkpXIPNcPpKXOSM1L9aqpxf
 O8003wHK1XZ9dqFQ4U2ky2ggkGa/DEjfaPquDlrPajyR/dYRVTL5C+XjRJW0MKrm4XuY
 KDN0ckIx0qMSpqQheXsm31UGL88ER7Dj14ZrOdkkHfndCp+DmNH603xDYj4Z9N9sLPeI
 LLfyUBXrkXJd8MBH2haGh/z7vQTU4DN7VT/xGtxVabXP4W9pJ7qYkZ5ATW1nFulHW5W5
 SKLrDX3XFVXPDSGkNBM04hGlusysBxV87vOlHi4qkv2psK7Dcm4jreKEI2cIOEVw14aw
 4Xlg==
X-Gm-Message-State: AFq9FYIYHKowSaPKb632h1LLgubENqKV7LTXgcPJRSZkncjAIVcoMGi0
 BLhIY/yGW4jC/LmypKJzrORafnTXRj/NAbLAZVjDTMjh/FuKVESU2k4y
X-Gm-Gg: AYBFou2pQEspR/4lTCWjSCffnuqtksPrC12Uu3KChkAFLDPdk+jkQF+Xo3QDROjRUf9
 ejd+C/qxZnRw6nXrE9u8lMn2ngONSRPGrpjwgI1BVf9N6JUoM6yB++rZNFmAughUpyG+M+wPSqx
 JRWDYWyDjvfAnyFJ6h4U+QMgPiu7GyJyOi6UAMG4YdkjsIG3bzUeigMoraheDesZ5TfqfFkUdF0
 sMzlGzdLSTOJkXFTB014Ybc2GfbZieq9pnxoZ+11CrTtnx9Xzh8DmaXe8eML4WOSnQzSwxz4pEX
 CttDSLmPSJRgdUUG+rR5cCNR7yrXtvegb31QUrNVS60gkdVDgdyQlMRu+luU1Kzk0iaLzvMAFPi
 8+kYy5nDQRo1xlsyomq3JKbpA4OExoIQu8PQY1xIo7Rar73L/OObVNg+5LTx/LpfY/RThOccQZS
 gIciwtU1ABKBvgCap4MTCsE4k0oo/iG548uxgc5d9MY7260awCHAwzJWtzJ4OmIQMgNrSKHtzCL
 hu0/cRsnFE=
X-Received: by 2002:a05:6000:5c4:b0:488:79b8:d1d9 with SMTP id
 ffacd0b85a97d-4887da06d19mr19665748f8f.15.1790608245421; 
 Mon, 28 Sep 2026 08:10:45 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:152b:4800:8072:ed4c:898d:d82d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm31513965f8f.20.2026.09.28.08.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:10:45 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/9] drm/amdgpu: allocate and fill dummy PDs/PTs
Date: Mon, 28 Sep 2026 17:10:35 +0200
Message-ID: <20260928151041.1857-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928151041.1857-1-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
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

Allocate some PDs/PTs which just point to the dummy page.

Those can be used in page faults to redirect recoverable page faults
to the dummy page.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 11 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  7 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 57 +++++++++++++++++++
 4 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7b9494375649f..f02a99b753c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2908,8 +2908,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
  *
  * Initialize the VM manager structures
  */
-void amdgpu_vm_manager_init(struct amdgpu_device *adev)
+int amdgpu_vm_manager_init(struct amdgpu_device *adev)
 {
+	int r;
+
 	/* Concurrent flushes are only possible starting with Vega10 and
 	 * are broken on Navi10 and Navi14.
 	 */
@@ -2921,6 +2923,10 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->vm_manager.prt_lock);
 	atomic_set(&adev->vm_manager.num_prt_users, 0);
 
+	r = amdgpu_vm_pt_alloc_dummies(adev);
+	if (r)
+		return r;
+
 	/* If not overridden by the user, by default, only in large BAR systems
 	 * Compute VM tables will be updated by CPU
 	 */
@@ -2940,6 +2946,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #else
 	adev->vm_manager.vm_update_mode = 0;
 #endif
+
+	return 0;
 }
 
 /**
@@ -2951,6 +2959,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
  */
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
+	amdgpu_vm_pt_free_dummies(adev);
 	amdgpu_vmid_mgr_fini(adev);
 	amdgpu_pasid_mgr_cleanup();
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 98cdd7e3475fb..c59647554b416 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -411,8 +411,11 @@ struct amdgpu_vm_manager {
 	int					vm_update_mode;
 
 	/* Global registration of recent page fault information */
-	struct amdgpu_vm_fault_info	fault_info;
+	struct amdgpu_vm_fault_info		fault_info;
 	unsigned int				npa_vmid;
+
+	struct amdgpu_bo			*dummy_pd[AMDGPU_VM_PTB + 1];
+	uint64_t				dummy_dst[AMDGPU_VM_PTB + 1];
 };
 
 struct amdgpu_bo_va_mapping;
@@ -424,7 +427,7 @@ struct amdgpu_bo_va_mapping;
 extern const struct amdgpu_vm_update_funcs amdgpu_vm_cpu_funcs;
 extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
 
-void amdgpu_vm_manager_init(struct amdgpu_device *adev);
+int amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 8ebb0b033291e..3c48a3401e2a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -130,6 +130,8 @@ void amdgpu_vm_pt_free_work(struct work_struct *work);
 void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params);
 int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+int amdgpu_vm_pt_alloc_dummies(struct amdgpu_device *adev);
+void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
 
 /**
  * amdgpu_vm_begin_critical - start the critical section of the update
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index e8f441e018839..285f17c7705b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -990,3 +990,60 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	return 0;
 }
+
+/* amdgpu_vm_pt_alloc_dummies - allocate dummy PDs/PTs
+ *
+ * @adev: the amdgpu device pointer
+ *
+ * Allocate some dummy PDs/PTs which can be used to redirect page faults to the
+ * dummy page.
+ */
+int amdgpu_vm_pt_alloc_dummies(struct amdgpu_device *adev)
+{
+	struct amdgpu_vm_manager *vm_mgr = &adev->vm_manager;
+	int r;
+
+	for (int level = AMDGPU_VM_PTB; level != vm_mgr->root_level; level--) {
+		size_t size =  amdgpu_vm_pt_size(adev, level);
+		uint64_t addr, flags;
+		void *ptr;
+
+		r = amdgpu_bo_create_kernel(adev, size, 0,
+					    AMDGPU_GEM_DOMAIN_VRAM,
+					    &vm_mgr->dummy_pd[level],
+					    &vm_mgr->dummy_dst[level],
+					    &ptr);
+		if (r)
+			return r;
+
+		if (level == AMDGPU_VM_PTB) {
+			addr = adev->dummy_page_addr;
+			/*
+			 * TODO: We want to have separate dummies for reads and
+			 * writes.
+			 */
+			flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
+				AMDGPU_PTE_SYSTEM | AMDGPU_PTE_EXECUTABLE |
+				AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE;
+		} else {
+			amdgpu_gmc_get_pde_for_bo(vm_mgr->dummy_pd[level + 1],
+						  level, &addr, &flags);
+		}
+
+		for (int i = 0; i < amdgpu_vm_pt_num_entries(adev, level); i++)
+			amdgpu_gmc_set_pte_pde(adev, ptr, i, addr, flags);
+	}
+
+	return 0;
+}
+
+void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev)
+{
+	struct amdgpu_vm_manager *vm_mgr = &adev->vm_manager;
+	void *ptr;
+
+	for (int level = AMDGPU_VM_PTB; level != vm_mgr->root_level; level--)
+		amdgpu_bo_free_kernel(&vm_mgr->dummy_pd[level],
+				      &vm_mgr->dummy_dst[level],
+				      &ptr);
+}
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2744CCA5FC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A557910F3F3;
	Wed, 30 Sep 2026 13:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nBVBPnYL";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9779210F3ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:19 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a006bb267eso17691085e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775198; x=1791379998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eGaZ8+Gv1qkWr3xWb0p5+XKexyfYyeS753KL8Dvpoqk=;
 b=nBVBPnYLRfXnza4O9INFPaBv5RwaDl/pdWhTGhj7Ybp/s3KjvxjvsYeIMHgsOt3+8j
 umdTZ23HOmtlrn0+oo7XHsE3zmvUf0gcfoP/jm+08ZlKNld8+ycwLO0tKHiT9UPtp2Nq
 ztfDAWfZ6pl77VmHWefSVKLAeWE53xn+VAL6h/jOGz8NLjnmNU2nF9rkg+5ijzWtI50s
 uzWiXmQdNThLet9xZ2px6xwezIsLLgSMtH++Yo1Gscd8oxMJD6nGj8+luzDTN2o6cgVX
 zJr8L1pMpieoCZ9X9UF5jD5Hyhqgsl0qusc9j2US20NFQsdHRxnCkNy0lILwReiT3Syp
 +KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775198; x=1791379998;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eGaZ8+Gv1qkWr3xWb0p5+XKexyfYyeS753KL8Dvpoqk=;
 b=S8s42eb/An75g3efSYDI6nGYdzjttsQ8PW4ue2DCRSEyuamK5WPzNitWvqRgj9XkDL
 xShZ5J8JoA54lAgMDbLN7LUOTXahNsEQZ1e8oUazXD+PwmPuR7Iuf+re0MfLJnOyeL5q
 zXfTV+HTBWxt2SHuQXgwOM3By0zgtdMeDfBVi6iu8Rov8BoZ1S1etNhnnleFJ3tgbOnc
 KgTq193SpGpnlJT9Yb3YuK0h87sNrKJwlren6lc78yYMMAcJ/Q4EIoogtX93EKJCNt+H
 U+eqkp5RkV6xTdOvOEhDeiBT5qZRHN75FmH0P6/QeAoKJlFF48uFY5B95m2+NClZ5FvI
 x99g==
X-Gm-Message-State: AFuF++nZqJbGEGLm2IlFFj7vUt/V3Ztp9FQWZad2fQK3FL21P1NsXOq/
 ZGVnLoKhn6Ez63r+iG9xirBrUVInuo8xBemMvu+DQIDZoiTBcOHjlZIo
X-Gm-Gg: AYBFou1AnWa6lyix4Vswv/7Z2saWeFEoLc6B0rm7/usfOirRnG3yN0MskLndbX6VWUa
 jQeKrjRKTxn8jCmCOIMMvKOxLBIgyv8H0+PC4naY0Rprx7Imd6leTYjscC32HX7+xalACXtUFTh
 ++XKMeBWsfFI18HcIY34RFgwvfnpix1OQOF7uMl2jgpv+sYVA97nAD6euTEnRQXHphjbS3Dnoez
 /owMfjgWp5mrs/5stKJZp4RW6x0evl3mWlBcOfYjQJHhSSwtsNHK8uK2C1ERrRcHEvuO7QbHIT2
 ZHhCvPIwljcvIyb26orbX6FCMf1uNnVuWf260RElkGo0TsrxDlyX9yUI5O0JJ+JjIHhGtR/lN0I
 29ajz+1tjfq8G1LAv79yLrx9z3CPof/TQpehdc4EB5+BkS4GgPIF29DPnenBg/KEevm2JXPNY1k
 kvfcPTeAiM70UwvDUMWnnrae9PNLpyF4Ze9WDXglJPRnsSDmbRoCNclC+iGGFvanzBPQdoGX+Jg
 y/5n/hMS3227DpUe/O5yw==
X-Received: by 2002:a05:600c:8b88:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-4a01adddfa5mr22691115e9.10.1790775197897; 
 Wed, 30 Sep 2026 06:33:17 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:155e:6500:f261:39ca:dadd:d0c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01771cf9fsm60407975e9.14.2026.09.30.06.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com, olivier.kaloudoff@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] drm/amdgpu: allocate and fill dummy PDs/PTs v2
Date: Wed, 30 Sep 2026 15:33:08 +0200
Message-ID: <20260930133315.12270-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930133315.12270-1-christian.koenig@amd.com>
References: <20260930133315.12270-1-christian.koenig@amd.com>
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

v2: use init_pte_flags

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 11 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  7 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 58 +++++++++++++++++++
 4 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 29187fabc240b..c0cf10d030c36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2902,8 +2902,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
@@ -2915,6 +2917,10 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->vm_manager.prt_lock);
 	atomic_set(&adev->vm_manager.num_prt_users, 0);
 
+	r = amdgpu_vm_pt_alloc_dummies(adev);
+	if (r)
+		return r;
+
 	/* If not overridden by the user, by default, only in large BAR systems
 	 * Compute VM tables will be updated by CPU
 	 */
@@ -2934,6 +2940,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #else
 	adev->vm_manager.vm_update_mode = 0;
 #endif
+
+	return 0;
 }
 
 /**
@@ -2945,6 +2953,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
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
index e8f441e018839..710c813c3a045 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -990,3 +990,61 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
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
+			flags = adev->gmc.init_pte_flags;
+			flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
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


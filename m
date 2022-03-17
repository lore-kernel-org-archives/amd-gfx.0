Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3042C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 13:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CEE10EBD0;
	Thu, 17 Mar 2022 13:50:50 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1CE410EBD0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 13:50:48 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id qa43so10785534ejc.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LhUTTqOcCQpMX/ZrE09r/anfVvJe3SKbIk3Tnu9XfDs=;
 b=Wfu9dwioEADQE5qLLt6cLLoQmrAl4zPU5BAusfjjgAAuPpnL6o9iLdiCv/2np+7ImK
 zEwvYhGy4hBdmOwTlrgCr0ilmfOHzEEhxoko6IBgjRBeqyky7uvQSELuF6IW3L31SxxB
 IT20zOqbqS7RaTpp9Ogt/02pT31xhUIJjUTzjCINH1VCtLyTKW6+YayGj0cIJSvW4Xl9
 1yRztjrE7wt4STZu0Or/rR5+qzLO+Pufpu9IlsvRpR2UDAUb9w6IJOJhlcErLnedT+MF
 W4n2OkoGpVznTuHJMTq6G1kyPSeNxj15ONFGVAL3fCYQXr9hLzwAdDSIMQJFHd2dFWwf
 y3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LhUTTqOcCQpMX/ZrE09r/anfVvJe3SKbIk3Tnu9XfDs=;
 b=hbn/PeddtD62gdJl/6PjyHiFZjJAciHWjqmMF723kVww34hx0/67WVFMau/kiNX79G
 xFdl1S5kL5PC0IpVzsRdZN1qjTsBbXAlSwnfBy9VF/Y2Rmp5LG53AaiHoeOZ1osuJgJY
 oyw1Jjyg8H8+c/qco/L4Htji7FP39WL5SNBAug+GsjQpJHke4pw80VCqDVKHqf/XIzlH
 6JON4vFzkB6S4s+DagLGJtwE1S8cmr13jieGlK8wWLVXvo1jUlkRj4zeQPo0S//6OGLE
 q5nrqJ9Gol328j6S9kvyYLau9bVUXKp4g005uCXKwZmkVdR5B/Y1hs1Yz6hO0SeZmXT+
 d67A==
X-Gm-Message-State: AOAM531uI/09Qa3xH4k2N6YcrQ8RzWftNYtKd7dIeTOUhBL/DwDQBFWt
 cOmwEPpBRVcj12KhARoFhBVuqh8eDpA=
X-Google-Smtp-Source: ABdhPJzAt+W4+9BTQyLAA+OrOilYbJeoqybHdf7JaWtr0PBmZYiRVg7FyR+RA42eK2TLCUysFfRmwQ==
X-Received: by 2002:a17:906:2859:b0:6b8:d27c:8e58 with SMTP id
 s25-20020a170906285900b006b8d27c8e58mr4293678ejc.609.1647525045983; 
 Thu, 17 Mar 2022 06:50:45 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056402254900b00416b0ec98b5sm2706721edb.45.2022.03.17.06.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 06:50:45 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix.Kuehling@amd.com
Subject: [PATCH 1/7] drm/amdgpu: move VM PDEs to idle after update
Date: Thu, 17 Mar 2022 14:50:38 +0100
Message-Id: <20220317135044.2099-1-christian.koenig@amd.com>
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

Move the page tables to the idle list after updating the PDEs.

We have gone back and forth with that a couple of times because of problems
with the inter PD dependencies, but it should work now that we have the
state handling cleanly separated.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 42 ++++++--------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index fc4563cf2828..eb9b86466336 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1363,25 +1363,6 @@ static int amdgpu_vm_update_pde(struct amdgpu_vm_update_params *params,
 					1, 0, flags);
 }
 
-/**
- * amdgpu_vm_invalidate_pds - mark all PDs as invalid
- *
- * @adev: amdgpu_device pointer
- * @vm: related vm
- *
- * Mark all PD level as invalid after an error.
- */
-static void amdgpu_vm_invalidate_pds(struct amdgpu_device *adev,
-				     struct amdgpu_vm *vm)
-{
-	struct amdgpu_vm_pt_cursor cursor;
-	struct amdgpu_vm_bo_base *entry;
-
-	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry)
-		if (entry->bo && !entry->moved)
-			amdgpu_vm_bo_relocated(entry);
-}
-
 /**
  * amdgpu_vm_update_pdes - make sure that all directories are valid
  *
@@ -1398,6 +1379,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate)
 {
 	struct amdgpu_vm_update_params params;
+	struct amdgpu_vm_bo_base *entry;
 	int r, idx;
 
 	if (list_empty(&vm->relocated))
@@ -1413,16 +1395,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 
 	r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
 	if (r)
-		goto exit;
-
-	while (!list_empty(&vm->relocated)) {
-		struct amdgpu_vm_bo_base *entry;
-
-		entry = list_first_entry(&vm->relocated,
-					 struct amdgpu_vm_bo_base,
-					 vm_status);
-		amdgpu_vm_bo_idle(entry);
+		goto error;
 
+	list_for_each_entry(entry, &vm->relocated, vm_status) {
 		r = amdgpu_vm_update_pde(&params, vm, entry);
 		if (r)
 			goto error;
@@ -1431,12 +1406,15 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	r = vm->update_funcs->commit(&params, &vm->last_update);
 	if (r)
 		goto error;
-	drm_dev_exit(idx);
-	return 0;
+
+	while (!list_empty(&vm->relocated)) {
+		entry = list_first_entry(&vm->relocated,
+					 struct amdgpu_vm_bo_base,
+					 vm_status);
+		amdgpu_vm_bo_idle(entry);
+	}
 
 error:
-	amdgpu_vm_invalidate_pds(adev, vm);
-exit:
 	drm_dev_exit(idx);
 	return r;
 }
-- 
2.25.1


Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C644EC4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 16:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB4023AC8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 16:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB4023AC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786406E96B;
	Tue,  8 Dec 2020 16:06:09 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A436E964
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 16:06:08 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id 7so12277238qtp.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Dec 2020 08:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ASvcYPxQtXrrxmzeO4xj8psrAHCi2SdInHl+hsyUbJk=;
 b=MBlIUmvZOuy2L7XJOr2SHNCiX46J7pUqaTnztaJq4bxPOok3UNAPF3nCcfFoIbHyME
 Wj3ISCN43FOwxY1ptvnRHVErI9ovwFVbQeBlbETEUlcfvZbO99q5TNjaG7EjwnRV1nNi
 k7RUHBBxFTJFj5LBBpnxsgrpcpQMuwBzsyAfniKXYC/0NqmVcBdlUB6qsqY0fqdz1h8G
 6QmXz2KEcJ9dz/PG5an/6m/pZ3sd/GpYzOrRAdOvQTwdOOFk843nD4l7RfPkJ38wWjY7
 Rsbl+FaaQlsWBOyE8FAUdGf5sCYmJHWGFVvLNhYXJgNIWE3S/uiYKFbPfcf1Yt5Tj8N+
 ldvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ASvcYPxQtXrrxmzeO4xj8psrAHCi2SdInHl+hsyUbJk=;
 b=HkNicQaBAR9ujGFagyArmcd11oHC81BaaPs3DXrnXG9Ils0fxHsmaJDpXy0jdCXSsr
 7HTfMjnE3RlhMxuPv2NuUfjweq46Qjp4UPkYBX8ZSBSAUidUG6AjdqKXmlQHakNJVI7l
 xHFBZAm+XlwclYnKtUdRKfYigZBSLCiyrdMG22AyGN0TVxa0G9djXy5BXJEJpVrfiyWR
 Z/gySxSARGajj5sv/EPr6OFYKD3P/9RKtmrZtL2b2X9JYSzfSG5ivi+v7e2HjVh4O/nk
 yEz2Noe0z3m/EaDHx1PC9i903hiuDBvh6JgeM4nUIMmIhnBiv6v0Gi6sPtCBvlmNGuQR
 kB0Q==
X-Gm-Message-State: AOAM533pivAF0JsAgE6DD6zUeT8E43FDse45BwHhRacqeJY9RXpEZBgr
 MQ444KBM6XoYvgXtX9/VqbELSW1H6X4=
X-Google-Smtp-Source: ABdhPJwXg8tlBIOEqThrqoA9ITwGzpoVycCa6TvB7f0mBJX8Ew39Px5cmIRFcVwOUyOmbVewJGXlGw==
X-Received: by 2002:ac8:5c15:: with SMTP id i21mr30783989qti.190.1607443567329; 
 Tue, 08 Dec 2020 08:06:07 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id u26sm1702482qke.57.2020.12.08.08.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 08:06:06 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: remove amdgpu_ttm_late_init and
 amdgpu_bo_late_init
Date: Tue,  8 Dec 2020 11:05:55 -0500
Message-Id: <20201208160556.39899-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201208160556.39899-1-alexander.deucher@amd.com>
References: <20201208160556.39899-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No longer used.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 17 -----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  2 --
 9 files changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fd7a93c32235..25ec4d57333f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1074,23 +1074,6 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
 	return amdgpu_ttm_init(adev);
 }
 
-/**
- * amdgpu_bo_late_init - late init
- * @adev: amdgpu device object
- *
- * Calls amdgpu_ttm_late_init() to free resources used earlier during
- * initialization.
- *
- * Returns:
- * 0 for success or a negative error code on failure.
- */
-int amdgpu_bo_late_init(struct amdgpu_device *adev)
-{
-	amdgpu_ttm_late_init(adev);
-
-	return 0;
-}
-
 /**
  * amdgpu_bo_fini - tear down memory manager
  * @adev: amdgpu device object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index a5a7992b5773..2bfef286fda4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -269,7 +269,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 void amdgpu_bo_unpin(struct amdgpu_bo *bo);
 int amdgpu_bo_evict_vram(struct amdgpu_device *adev);
 int amdgpu_bo_init(struct amdgpu_device *adev);
-int amdgpu_bo_late_init(struct amdgpu_device *adev);
 void amdgpu_bo_fini(struct amdgpu_device *adev);
 int amdgpu_bo_fbdev_mmap(struct amdgpu_bo *bo,
 				struct vm_area_struct *vma);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6be131df21f5..b719b4281cc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2021,13 +2021,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-/*
- * amdgpu_ttm_late_init - Handle any late initialization for amdgpu_ttm
- */
-void amdgpu_ttm_late_init(struct amdgpu_device *adev)
-{
-}
-
 /*
  * amdgpu_ttm_fini - De-initialize the TTM memory pools
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index bdca2970173e..d2987536d7cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -131,7 +131,6 @@ int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
 				      uint64_t start);
 
 int amdgpu_ttm_init(struct amdgpu_device *adev);
-void amdgpu_ttm_late_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
 void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
 					bool enable);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5317efc942a4..f12c2224cdbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -717,8 +717,6 @@ static int gmc_v10_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	amdgpu_bo_late_init(adev);
-
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 95a9117e9564..b6f95dfdec69 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -791,8 +791,6 @@ static int gmc_v6_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_bo_late_init(adev);
-
 	if (amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS)
 		return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index d9cb887b3a91..959b61af4251 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -961,8 +961,6 @@ static int gmc_v7_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_bo_late_init(adev);
-
 	if (amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS)
 		return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 65d7bc108151..319f99015976 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1062,8 +1062,6 @@ static int gmc_v8_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_bo_late_init(adev);
-
 	if (amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS)
 		return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 07126b2b46c2..e1531d97f486 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1177,8 +1177,6 @@ static int gmc_v9_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	amdgpu_bo_late_init(adev);
-
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

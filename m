Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE49CC4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 14:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CDE810E012;
	Wed, 10 Jan 2024 14:31:55 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CD010E012
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 14:31:54 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a28b0207c1dso337906766b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 06:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704897112; x=1705501912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=w3P5wEoA4t7fBbanC8dBZreTJKUcVszdddLkhLz5SOE=;
 b=a+pYnTmfFeOSr3qtZTiSaf9Zvduaj8dKHcA7HQ9eI+txnfhUKC/SUHI1kP43+x/nfR
 NfX8DPyoVrFR8xXlryBZCBks6RmAxDFVm1N53E/847qBSe1GBB45yiJf1o0mY8HjAIJ1
 bI+fopXLdwsPWxMRcsJGXDkbnqpQH3zh6oFOaSbMRnPq+KJzIbESXf5RbvvI9whcCVgB
 HDCtCUUyWwrNoGNX8S97IiUpwAnJ2ZUyyDDTYU9NVpwLrjEiOmiZjyhnlAZyAimBnZbm
 Cgbpraw/BqYsflJeiUjPPCUKIH3y0dvOnhHe+KavRUFBeY+5V7Xmr6uqO1kDnLRd+tQs
 e37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704897112; x=1705501912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w3P5wEoA4t7fBbanC8dBZreTJKUcVszdddLkhLz5SOE=;
 b=R8jEg5ILahzM0bCDfZaqEhT0PPrkc61TVB6Yt6AfJiE5kZXbBlB5tSNp/p2cyDkcar
 xXIql12Xr4Y4FiSQZs5HSnb9ehk55V0diTzIuq/rkBQ5+7bJzxn7lYuTNFsVMzWn3DKs
 JJL77SW8+oJabF4eTXH+o0weEkIz1nYo7ENEnlJutQaVVQrXbirKwm94K7JPtzhncXxE
 IQJeeecLTViHdKz5DyS3vXYasYvmdQXdy/2W8pi01NdSzvGjorASESun3Bh+hiwAP+Lx
 uonS6cT4pEiysyXzfj7rVNJ0xBvFEUKytTEXacIeUPuM99d67eZF2gF868jkuHOa5l0I
 JOPg==
X-Gm-Message-State: AOJu0YzVfwIZIcAa1pkFLIRIdUXaygnNkGqSn80dk0Nav9N5ZsupHzDO
 4I3KfEv2OVHxPFBzQ2pY1hI=
X-Google-Smtp-Source: AGHT+IFIoHi8x5HF3LHJ2PftHusOmIZEo+/X3EGhG6MTCt3hMoLLRf6xMmCJNt+DdWALL0wjaxL0iw==
X-Received: by 2002:a17:907:cb07:b0:a2c:4bb:5d94 with SMTP id
 um7-20020a170907cb0700b00a2c04bb5d94mr264955ejc.36.1704897112280; 
 Wed, 10 Jan 2024 06:31:52 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1508:d200:1766:59b4:a7b7:3141])
 by smtp.gmail.com with ESMTPSA id
 i22-20020a170906091600b00a28148beabdsm2146227ejd.102.2024.01.10.06.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 06:31:51 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Lijo.Lazar@amd.com, YiPeng.Chai@amd.com, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: revert "Adjust removal control flow for smu
 v13_0_2"
Date: Wed, 10 Jan 2024 15:31:49 +0100
Message-Id: <20240110143149.2446-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Calling amdgpu_device_ip_resume_phase1() during shutdown leaves the
HW in an active state and is an unbalanced use of the IP callbacks.

Using the IP callbacks like this can lead to memory leaks, double
free and imbalanced reference counters.

Leaving the HW in an active state can lead to DMA accesses to memory now
freed by the driver.

Both is a complete no-go for driver unload so completely revert the
workaround for now.

This reverts commit f5c7e7797060255dbc8160734ccc5ad6183c5e04.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 +---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 32 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  1 -
 4 files changed, 1 insertion(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a39c9fea55c4..313316009039 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5232,7 +5232,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset, skip_hw_reset, vram_lost = false;
 	int r = 0;
-	bool gpu_reset_for_dev_remove = 0;
 
 	/* Try reset handler method first */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
@@ -5252,10 +5251,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 	skip_hw_reset = test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
 
-	gpu_reset_for_dev_remove =
-		test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->flags) &&
-			test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
-
 	/*
 	 * ASIC reset has to be done on all XGMI hive nodes ASAP
 	 * to allow proper links negotiation in FW (within 1 sec)
@@ -5298,18 +5293,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		amdgpu_ras_intr_cleared();
 	}
 
-	/* Since the mode1 reset affects base ip blocks, the
-	 * phase1 ip blocks need to be resumed. Otherwise there
-	 * will be a BIOS signature error and the psp bootloader
-	 * can't load kdb on the next amdgpu install.
-	 */
-	if (gpu_reset_for_dev_remove) {
-		list_for_each_entry(tmp_adev, device_list_handle, reset_list)
-			amdgpu_device_ip_resume_phase1(tmp_adev);
-
-		goto end;
-	}
-
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		if (need_full_reset) {
 			/* post card */
@@ -5543,11 +5526,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
-	bool gpu_reset_for_dev_remove = false;
-
-	gpu_reset_for_dev_remove =
-			test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->flags) &&
-				test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
@@ -5585,7 +5563,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			list_add_tail(&tmp_adev->reset_list, &device_list);
-			if (gpu_reset_for_dev_remove && adev->shutdown)
+			if (adev->shutdown)
 				tmp_adev->shutdown = true;
 		}
 		if (!list_is_first(&adev->reset_list, &device_list))
@@ -5670,10 +5648,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-		if (gpu_reset_for_dev_remove) {
-			/* Workaroud for ASICs need to disable SMC first */
-			amdgpu_device_smu_fini_early(tmp_adev);
-		}
 		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
 		/*TODO Should we stop ?*/
 		if (r) {
@@ -5705,9 +5679,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		r = amdgpu_do_asic_reset(device_list_handle, reset_context);
 		if (r && r == -EAGAIN)
 			goto retry;
-
-		if (!r && gpu_reset_for_dev_remove)
-			goto recover_end;
 	}
 
 skip_hw_reset:
@@ -5763,7 +5734,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_ras_set_error_query_ready(tmp_adev, true);
 	}
 
-recover_end:
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 					    reset_list);
 	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 852cec98ff26..b7de48effe7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2336,38 +2336,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 		pm_runtime_forbid(dev->dev);
 	}
 
-	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 2) &&
-	    !amdgpu_sriov_vf(adev)) {
-		bool need_to_reset_gpu = false;
-
-		if (adev->gmc.xgmi.num_physical_nodes > 1) {
-			struct amdgpu_hive_info *hive;
-
-			hive = amdgpu_get_xgmi_hive(adev);
-			if (hive->device_remove_count == 0)
-				need_to_reset_gpu = true;
-			hive->device_remove_count++;
-			amdgpu_put_xgmi_hive(hive);
-		} else {
-			need_to_reset_gpu = true;
-		}
-
-		/* Workaround for ASICs need to reset SMU.
-		 * Called only when the first device is removed.
-		 */
-		if (need_to_reset_gpu) {
-			struct amdgpu_reset_context reset_context;
-
-			adev->shutdown = true;
-			memset(&reset_context, 0, sizeof(reset_context));
-			reset_context.method = AMD_RESET_METHOD_NONE;
-			reset_context.reset_req_dev = adev;
-			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-			set_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context.flags);
-			amdgpu_device_gpu_recover(adev, NULL, &reset_context);
-		}
-	}
-
 	amdgpu_driver_unload_kms(dev);
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index b0335a1c5e90..19899f6b9b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -32,7 +32,6 @@ enum AMDGPU_RESET_FLAGS {
 
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
-	AMDGPU_RESET_FOR_DEVICE_REMOVE = 2,
 };
 
 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 6cab882e8061..1592c63b3099 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -43,7 +43,6 @@ struct amdgpu_hive_info {
 	} pstate;
 
 	struct amdgpu_reset_domain *reset_domain;
-	uint32_t device_remove_count;
 	atomic_t ras_recovery;
 };
 
-- 
2.34.1


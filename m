Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DF2CA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 08:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DECDE10FF6E;
	Fri,  9 Oct 2026 08:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="u/5KXGiv";
	dkim-atps=neutral
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF18C10E961
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 22:11:20 +0000 (UTC)
Received: by mail-dy2-f4.google.com with SMTP id
 5a478bee46e88-3535936351fso229276eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 15:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1791497480; x=1792102280;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:content-language:subject:cc
 :to:from:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J+DeZALYQDrGNmq6Vo6tBsQx3QUc7m/841o6VhiFuF8=;
 b=u/5KXGivDHJN3TG72QlcNbN7duh4S4vDM/SsoDAVYIxu0gQmT9LDQ+PI/R9UemjFzc
 d803NAec/v+ZGeuNHaTGjgBglcYWkOVCQhlDI6kCReMcbiPre/71Fbnu8BGsQzC93CdX
 yT328ANwgAyjIOhUdUhTEDEl9DWTgLY/GQDeVaq4qqXpb2hM464UxHFNepx0UuhBjX/v
 3gFleDnqRy7dm8zXGfLvzeUqhBnVf2k95TgjOtYDmCTiuLhcplDUV6oezdg9PWsmYZYU
 1ME2+zIfDOSNBdOp16NsP+pKMmffgfNk38wViUZXfzJyh5NI68uwgB6V4rzDjpgqxiPh
 w/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791497480; x=1792102280;
 h=content-transfer-encoding:content-type:content-language:subject:cc
 :to:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J+DeZALYQDrGNmq6Vo6tBsQx3QUc7m/841o6VhiFuF8=;
 b=xXoh1G9h9AGsl0hJo9tEvqiiqEffk648mcS/MlBic5qCtv5KDC+nMdfxXt2zPY5Twv
 j9FTwp3JpsIqXYzpEeIs/Tqrd/cgWE7q6953lo6POyDjQBLSft70sZJ+vPjaprssTY+u
 0MaWkztdE5SDEvIF0k1V5f6Zmwu++lu7KxMHdxbcQqlYBhmIAUiBE6tOnqvI8L85Vyhm
 +3R7WxVlsHAYkLxHv9rXfe6jjiPP1J+6ApcIPWulG81qi2i46X4MnsIFWvkuepdtp63d
 jN5uSaAkS9LJaMHjJRTfh5oFPPq9qf7fehu9c3TLxJsVjWRW9OJX3GqElCDI9zgT60OI
 7U8A==
X-Gm-Message-State: AFuF++mvaAugz1+9KOZTv4/NdNVNRsD7n61DH0puljovX5fPybdCBuBS
 zH90PFxTAWjpL/GWFl8cX7u8wjLUO/hTh1w0DcZT0SYhMvLyOFOvgL4LbHnehKhq76uXKm9a4v5
 62Z/Cp8N55xq4Vo4=
X-Gm-Gg: AYBFou2S2bwq2yNwwfBTTVkJew8uzWCttA1nNHzwIbZk0yKVUIwJyCYMIPKHL494Af9
 9ia4weeuynPBAdAxhbc96Mi5hVwk4zTF7gtFBTToyG3TlXyTrIikH6qkENi8hhqIwjZOQUfx2zt
 pzdibSv+TbZb04bSUj2q+9QAvAOMfMC6mBvmzUJymFi1awmC0WTRR/+MwW8HWuDxQIn6I3Tuvqg
 xYa2tr0MWY+L1TRUAS4AjCyf2c4dYfuzyp7OsD5l+KlEoiRW8ONShGfINNB7Sx0fjlq7StqBxlz
 OvTHX7fBMJcD36EP+slYPLd/Z5cEMKaOvGkY3wjtiZnLPOP5LnrdUKBy9SRozXU1WjkhHUtJnOB
 GZjOPctXL7wOGnefUtT1jOeOTiEELijNRPLpcteqHCkxNUp9Yhr+FIKxAjcElTQr5VYTJznxGKO
 ERKoMcOPOc7yDRlqrpOnJ4msG6/9DYKVA+CXzCdPu4BzG91SRpJaGboD01Nv9rGtdBKneWOvWXi
 zR/6FZm0F+vqjhIK9I+HGB8H38f248FNgkqYowxxpM7v6jmiSMxRrMwICfQh8ZIjaBC
X-Received: by 2002:a05:7022:ea8a:b0:151:2e62:fe8d with SMTP id
 a92af1059eb24-16205cc1e4bmr7143226c88.9.1791497479755; 
 Thu, 08 Oct 2026 15:11:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:1782:ba0:1510:b088:cef9:53a6?
 ([2600:1700:1782:ba0:1510:b088:cef9:53a6])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becefdsm947450c88.7.2026.10.08.15.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 15:11:19 -0700 (PDT)
Message-ID: <01534506-891e-4d0d-8d0c-fb5e82264c03@jqluv.com>
Date: Thu, 8 Oct 2026 15:11:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Geramy Loveless <gloveless@jqluv.com>
To: amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdkfd: place GFX12 compute queue MQDs in CPU-visible VRAM
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 08:12:18 +0000
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

KFD sub-allocates the MQD of every GFX12 user compute queue from its
GTT pool, so the MQD is in system memory. The CP accesses the MQD while
it runs the queue. A dispatch that exactly fills a shader engine is
retired through a path that accesses the MQD, so with the MQD in system
memory that dispatch pays the PCIe/host-link latency.

Measured with an empty kernel, median of 200 dispatches, on a Radeon AI
PRO R9700 (gfx1201), for a dispatch of 253-256 workgroups x 256
threads:

  - stock Linux (MQD in GTT): 26 us, against 7.9 us for 252
    workgroups.
  - Thunderbolt-attached R9700 to MacOS running mac_linuxgpu running the same amdgpu code under a
    different host OS: 51 us with the MQD in system memory, 17 us with
    the MQD in VRAM.

On dGPUs, allocate GFX12 compute queue MQDs with
amdgpu_bo_create_kernel() in VRAM. That sets CPU_ACCESS_REQUIRED, so
the BO is placed in the CPU-visible part of VRAM, which is needed
because the CPU writes the MQD. Flush HDP after CPU writes to the MQD:
at the end of update_mqd() (init_mqd() ends with it), in restore_mqd(),
and in a new update_mqd_gpu_addr().

Add GC 12.0.0 and 12.0.1 to mqd_on_vram() so the existing S4 handling
(unpin at suspend, repin on resume) covers these MQDs, and implement
update_mqd_gpu_addr() for v12 so the MQD base address is fixed up after
a repin.

This follows existing practice: KFD already places compute queue MQDs
in VRAM on GFX 9.4.2, 9.4.3, 9.4.4 and 9.5.0 (mqd_on_vram()), and
amdgpu places its kernel compute queue MQDs in VRAM on GFX10+
(amdgpu_gfx_mqd_sw_init()).

Only GFX12 (GC 12.0.x) is affected. SDMA, HIQ and DIQ MQDs are
unchanged, as are APUs that prefer GTT.

Testing: compile-tested on amd-staging-drm-next. The patched kernel has
not been measured on Linux yet; the VRAM number above is from the other
host OS.

for macos r9700 support reference where i prove the gains:
https://github.com/lemonade-sdk/mac_linuxgpu

Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 54 ++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 9b7859a77..e6b45950e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -326,6 +326,8 @@ bool mqd_on_vram(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
 		return true;
 	default:
 		return false;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 6ea09b031..d3a8c2aed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -92,6 +92,37 @@ static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 	return mqd_mem_obj;
 }
 
+/*
+ * The CP accesses the MQD while the queue is running, so keep compute queue
+ * MQDs in VRAM. The CPU writes the MQD, so it must be CPU visible.
+ */
+static struct kfd_mem_obj *allocate_cp_mqd(struct mqd_manager *mm,
+					   struct queue_properties *q)
+{
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
+	struct amdgpu_device *adev = mm->dev->adev;
+	struct kfd_mem_obj *mqd_mem_obj;
+	struct amdgpu_bo *bo = NULL;
+
+	if (!mqd_on_vram(adev))
+		return allocate_mqd(mm, q);
+
+	mqd_mem_obj = kzalloc_obj(*mqd_mem_obj);
+	if (!mqd_mem_obj)
+		return NULL;
+
+	if (amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM, &bo,
+				    &mqd_mem_obj->gpu_addr,
+				    (void **)&mqd_mem_obj->cpu_ptr)) {
+		kfree(mqd_mem_obj);
+		return NULL;
+	}
+	mqd_mem_obj->mem = bo;
+
+	return mqd_mem_obj;
+}
+
 static void init_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -242,6 +273,23 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	set_priority(m, q);
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
+
+	if (mqd_on_vram(mm->dev->adev))
+		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
+}
+
+static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
+				struct kfd_mem_obj *mqd_mem_obj,
+				struct queue_properties *qp)
+{
+	struct v12_compute_mqd *m = get_mqd(mqd);
+	u64 addr = mqd_mem_obj->gpu_addr;
+
+	m->cp_mqd_base_addr_lo = lower_32_bits(addr);
+	m->cp_mqd_base_addr_hi = upper_32_bits(addr);
+
+	if (mqd_on_vram(mm->dev->adev))
+		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
 }
 
 static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
@@ -409,6 +457,9 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 		*gart_addr = addr;
 
 	qp->is_active = 0;
+
+	if (mqd_on_vram(mm->dev->adev))
+		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
 }
 
 static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
@@ -454,7 +505,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
 	switch (type) {
 	case KFD_MQD_TYPE_CP:
 		pr_debug("%s@%i\n", __func__, __LINE__);
-		mqd->allocate_mqd = allocate_mqd;
+		mqd->allocate_mqd = allocate_cp_mqd;
 		mqd->init_mqd = init_mqd;
 		mqd->free_mqd = kfd_free_mqd_cp;
 		mqd->load_mqd = load_mqd;
@@ -465,6 +516,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
 		mqd->get_wave_state = get_wave_state;
 		mqd->mqd_stride = kfd_mqd_stride;
 		mqd->restore_mqd = restore_mqd;
+		mqd->update_mqd_gpu_addr = update_mqd_gpu_addr;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
-- 
2.43.0


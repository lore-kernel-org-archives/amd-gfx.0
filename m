Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A960FC4727E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 14:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F1123772
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 14:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhiP3DMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F1123772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F035D6E8C1;
	Wed, 23 Sep 2020 14:18:56 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582B46E9B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 14:18:54 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id f142so22910345qke.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z+brxmuONDPuezozZa008sbuhBXkmAFFHOFdcOERRGM=;
 b=hhiP3DMYSFX8eRc4YtWMAu+Wo80bmC0EQHSsq9x4QLUviGlXZcpa1jqG4DicvrWRXK
 QbCFtDZokuyQNx1Umhlwgkbrdc4XWDZS5rl+yhq6fDDNpoiXzgS2g9W5l7/41UVWbwnD
 ZIwuarsZE4l+0+kXvktffYrKq6qvhSNH6T3BKA0CaIZgcGmH3J87PN0g/dBE9FszNXBi
 2l4bW4C9Qi9C+afs5gn4wvQLiLWzNjzjTc7hAd/wWOPij9B9L/rbPxmAmtqnc7W5hUZ7
 468a1ZhrZmJpVATLvfUEJ+bEpkRjLX33Aa8y5nHZ3aGNRpPzFwZr4phmUrDksxYPD6UI
 eYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z+brxmuONDPuezozZa008sbuhBXkmAFFHOFdcOERRGM=;
 b=a/SBh54AZG/WIRQgXZuLtq1tpaMRWfBP7Em/wVhsIKSOkoZhxwub9sBLLcM0pOV1tw
 UjT8BnPTMpeiTNNLN3hY1fQGIveGsveciSIaqE21oJtNPBoMeOSoKN6VReZEHJNJlur3
 A4bWMBqzhpbPd6c5jhos7hPvqaXMkeyB9MBQBxb/s1IYznB+jVo26kAaDcyNQ6pNO2Fg
 9Dj9NC3TFgve2ULY7XS5RX2aw7Mnx6Cueye4QWICebo38H25QErxMSDoDMlOSjwCHq47
 UHbnFshKuajpoAmUO0bkdPZJ57H+wbZaN9fAWE+ZIponIAIW5BUd9fJAb+YInySxFI7p
 sKRQ==
X-Gm-Message-State: AOAM532XxzbQWhiZxndips2bqblPQmBKZjfw2MABnuHP4rHNO/QnI39w
 YiDco39ir7bSwTKGaUHgl+M9aW6wrE4=
X-Google-Smtp-Source: ABdhPJyJCfCI8JbroyqFoXKuUtsTuC9PsyfgiF5TR0laMIvJWjqXFqusRXMsrYsDuHMS1GgVsIlsGA==
X-Received: by 2002:ac8:544f:: with SMTP id d15mr184397qtq.378.1600870147991; 
 Wed, 23 Sep 2020 07:09:07 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w128sm59033qkb.6.2020.09.23.07.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 07:09:06 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: store noretry parameter per driver instance
Date: Wed, 23 Sep 2020 10:08:57 -0400
Message-Id: <20200923140858.1193427-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

This will allow us to have different defaults per asic
in a future patch.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  2 ++
 .../drm/amd/amdkfd/kfd_device_queue_manager_v9.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  2 ++
 16 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 53d5aa2d96bf..3c0e43f548fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -581,6 +581,13 @@ uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd)
 	return adev->rev_id;
 }
 
+int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+
+	return adev->gmc.noretry;
+}
+
 int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 				uint32_t vmid, uint64_t gpu_addr,
 				uint32_t *ib_cmd, uint32_t ib_len)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index a10507ecb750..bc9f0e42e0a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -181,6 +181,7 @@ uint64_t amdgpu_amdkfd_get_unique_id(struct kgd_dev *kgd);
 uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd);
 uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd);
 uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
+int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
 
 /* Read user wptr from a specified user address space with page fault
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2ff43a3d52fc..70c6593aa634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1267,6 +1267,8 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
 	}
 
+	amdgpu_gmc_noretry_set(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 213ef090bb0e..3572629fef0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -413,6 +413,20 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	}
 }
 
+/**
+ * amdgpu_noretry_set -- set per asic noretry defaults
+ * @adev: amdgpu_device pointer
+ *
+ * Set a per asic default for the no-retry parameter.
+ *
+ */
+void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
+{
+	struct amdgpu_gmc *gmc = &adev->gmc;
+
+	gmc->noretry = amdgpu_noretry;
+}
+
 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 				   bool enable)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index d61bbde4c7d2..aa0c83776ce0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -239,6 +239,7 @@ struct amdgpu_gmc {
 
 	struct amdgpu_xgmi xgmi;
 	struct amdgpu_irq_src	ecc_irq;
+	int noretry;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
@@ -300,6 +301,7 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
 
 extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
+extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
 
 extern void
 amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index bccaf4f77647..a5aaff15f7ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -177,7 +177,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 			break;
 		case CHIP_VEGA10:
 			/* turn runpm on if noretry=0 */
-			if (!amdgpu_noretry)
+			if (!adev->gmc.noretry)
 				adev->runpm = true;
 			break;
 		default:
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4d65cbed31d4..f7958f6603d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2557,14 +2557,14 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 			tmp = REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,
 					    SH_MEM_ALIGNMENT_MODE_UNALIGNED);
 			tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, RETRY_DISABLE,
-					    !!amdgpu_noretry);
+					    !!adev->gmc.noretry);
 			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, tmp);
 			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, 0);
 		} else {
 			tmp = REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,
 					    SH_MEM_ALIGNMENT_MODE_UNALIGNED);
 			tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, RETRY_DISABLE,
-					    !!amdgpu_noretry);
+					    !!adev->gmc.noretry);
 			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, tmp);
 			tmp = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,
 				(adev->gmc.private_aperture_start >> 48));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 529e46386a50..40b17da6a357 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -245,7 +245,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index b882ac59879a..fa279d559b72 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -318,7 +318,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 237a9ff5afa0..6dc7a040ed7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -319,7 +319,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 45a902b1acb7..f84701c562bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -268,7 +268,7 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 2d88278c50bf..4120f9478707 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -374,7 +374,7 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index c2ef8142136e..66748bb01b52 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -330,7 +330,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
 				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
 				    i * hub->ctx_distance, tmp);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 135001a404bc..903170e59342 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -718,6 +718,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	kfd->unique_id = amdgpu_amdkfd_get_unique_id(kfd->kgd);
 
+	kfd->noretry = amdgpu_amdkfd_get_noretry(kfd->kgd);
+
 	if (kfd_interrupt_init(kfd)) {
 		dev_err(kfd_device, "Error initializing interrupts\n");
 		goto kfd_interrupt_error;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 309f63a0b34a..eca6331efa94 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -61,7 +61,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 		qpd->sh_mem_config =
 				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
-		if (amdgpu_noretry &&
+		if (dqm->dev->noretry &&
 		    !dqm->dev->use_iommu_v2)
 			qpd->sh_mem_config |=
 				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 739db04080d0..56f92cfff591 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -317,6 +317,8 @@ struct kfd_dev {
 
 	struct ida doorbell_ida;
 	unsigned int max_doorbell_slices;
+
+	int noretry;
 };
 
 enum kfd_mempool {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

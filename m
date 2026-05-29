Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958F7CD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 10:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FA310FCB2;
	Fri, 29 May 2026 10:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dNsepYlh";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988F910FCAE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 10:31:05 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4909e3fa4b2so4269055e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780050664; x=1780655464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p837/lFS70xLMfSkTKfE/acMSIHLlxb2QCE340X9Rjg=;
 b=dNsepYlhL5eQuK/+kgoH+HZ8UKR/iStckHoHdDTAoADrut59nvMwTTD2uEYj43oTxL
 CszeP0vKdRNNEPJPrcwBj5Rs41zGD9d29YwVqnDj8fwkAOW7iygUfgSqeOodnompzKJP
 RP9Z82AlvmMuyUCwYGV6oF1bph3FmE83hvdYi7R8MkAKzeh8MO9Rr7/hESqMOaQU+fdZ
 g8ni+AIWav+MLVUlAbsmHIm4I5RFEi06dhWad0DAVQ4+xiAvkaiKxrhTXnd1lHf6nLML
 r2b63KuKVlVFbHtAIp1qGbfwGG83q4H2zZkSJeGUPuhAy6/ivOc/k3/PpQ4QRo9Sgrca
 kWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780050664; x=1780655464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p837/lFS70xLMfSkTKfE/acMSIHLlxb2QCE340X9Rjg=;
 b=SckOn48hCGTH0yFV2e1yNIRhW0ilGmgJByG8DJExTs9xkztPvVVZHzs1MIvZPmKH0/
 zrE0luRxegD1bdYxEdxhy+p0429gNqnJ9A3oI8A6RWFRO4zm+tvCLXOZoUoG8GXHw85x
 nx7oXO/HK2R6XFYhryn2hp46OQSXVQQJHsge+YAjgFjH4DL45/gtkFjqB6rnVGHTi/Ck
 TfKy1LKgvyLuQ52Ut2pSyaoQz0PlpQj5GILM2BzKuHJmIzIKe1M6XkhwahIhqCsZmV3E
 Pl2F09RNgdjmwo1qZDEZp5z/jUGVV1niVFypX4331DtpyEjl8EEj1GpAfh5bl0KowAwN
 oaFw==
X-Gm-Message-State: AOJu0Yznu2lSb+T63uuiuv4USs8xylejZFNXfY09/dI6b002oJtlG9t1
 jaB/EOiGMpNMpOYDkfbCgNUcL1NldZvJ4CTTIGVirXgpdyEJs0UH5yWjOoKeiQ3GnVo=
X-Gm-Gg: Acq92OHniSSib9X58iIZ5ncjwFCGRAvNAg5xZUIL070RefIMQXBFiu1axLdNJT1dld3
 3gym1NQG5GlIDJRmasDDxqO4WRLpmAX54nukImRQJf9EezHnvekmEH0KB2igwaCKpGeDQyabwdx
 h5bP9oSYSfuszs+OwI6jfHzC8PlFmQ5qUqQOQVyO0A51vaAmK1J3cVvjghnkp07bfsyQv/HqDoz
 ZTASr1wLEL/s3RuwHujjy1Ix9YP0MzxvhqQocaSd60UnWjAplj1y5VexTMovSxwowOJY037LtsH
 7+bSp0VNxV4lkTTssz0L1nESedem2YEyyepm/9NWYvmSiUy5fzP+qX/7rqUOEaC40VxKE+bWPnc
 dMeIMHssqzFVQwz4ZAn8iy/fd5q6IsbhIT5hYwFepRQuQ/PfgdxomZuwbv/yGnoGSsvCeazX9VP
 RnwvqU2PP1rsK/+pf3Us+6nWRKdArZbCoO2tbiGF6qmplgPZBVqjXfRqArvfHfgbcgNAltXGbBW
 wka1QuxEiqCbhe8
X-Received: by 2002:a05:600c:5697:b0:48f:d5e8:758c with SMTP id
 5b1f17b1804b1-4909c0b3493mr28779845e9.16.1780050664006; 
 Fri, 29 May 2026 03:31:04 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0a89sm40895945e9.7.2026.05.29.03.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:31:03 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/7] drm/amdgpu/vm: Add fence argument to
 amdgpu_vm_handle_fault()
Date: Fri, 29 May 2026 12:30:53 +0200
Message-ID: <20260529103059.21470-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529103059.21470-1-timur.kristof@gmail.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
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

Allow the caller to respond to when the VM update is finished.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d790b7619ccd4..26aea960e2759 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -564,7 +564,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 		}
 
 		ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-					     addr, entry->timestamp, write_fault);
+					     addr, entry->timestamp, write_fault, NULL);
 		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
 		if (ret)
 			return 1;
@@ -587,7 +587,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 		 * tables
 		 */
 		if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-					   addr, entry->timestamp, write_fault))
+					   addr, entry->timestamp, write_fault, NULL))
 			return 1;
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b523a7b97d6f1..8c3ba7213eb22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2962,13 +2962,14 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
  *           GFX 9.4.3.
  * @addr: Address of the fault
  * @write_fault: true is write fault, false is read fault
+ * @fence: optional resulting fence, signaled after update is done
  *
  * Try to gracefully handle a VM fault. Return true if the fault was handled and
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
-			    uint64_t ts, bool write_fault)
+			    uint64_t ts, bool write_fault, struct dma_fence **fence)
 {
 	bool is_compute_context = false;
 	struct amdgpu_bo *root;
@@ -3034,6 +3035,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 
 	r = amdgpu_vm_update_pdes(adev, vm, true);
 
+	*fence = vm->last_update;
+
 error_unlock:
 	amdgpu_bo_unreserve(root);
 	if (r < 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index cc096c005e348..72da6b3d98c70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -589,7 +589,7 @@ void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
 
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
-			    bool write_fault);
+			    bool write_fault, struct dma_fence **fence);
 
 struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
 					  struct amdgpu_bo **root, u32 pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 855cd29cbffaa..da18c02013966 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -155,7 +155,7 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 			cam_index = entry->src_data[3] & 0x3ff;
 
 			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-							addr, entry->timestamp, write_fault);
+							addr, entry->timestamp, write_fault, NULL);
 			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
 			if (ret)
 				return 1;
@@ -178,7 +178,7 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 			 * tables
 			 */
 			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-						   addr, entry->timestamp, write_fault))
+						   addr, entry->timestamp, write_fault, NULL))
 				return 1;
 		}
 	}
-- 
2.53.0


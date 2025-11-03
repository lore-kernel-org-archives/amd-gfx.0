Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7852CCFA04
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651E410E4C3;
	Mon,  3 Nov 2025 22:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TvkgEe7L";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3669010E4C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:24:08 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso8857184a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208647; x=1762813447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kVIEVTmEwnZdHXAWkRY5qhlmNokGDBKXHhE7HxZS6Do=;
 b=TvkgEe7L35Lh9iIBi7o1bRHhhG+kXS9VGbYGBL7dSCh83o7yzm8Pj3YbsAKyk+OtKD
 /F91jCrgpHUO0B43l2WxrBwptkbM/QlGvzsn6NihYgIggBzSIVzHYF6JXb0XFxqbKGI0
 UnQ9Suh3DZiaXh/1ewKdr+CZ1Zgk+UENiN0Wey9AZ/FHZ1wtv4oP9gC00IYpoTkbMpAI
 1UE3+GGOb8e5qok5B7yO6yc9KG5InijHireBKOpQb8dE3F9R3SzVT9GmcgsY1qxVT0Ki
 OtUGw0MmRoGaohy9DsqQYk76k2j4Dcy/YYZOKr4SZyDWw9cg3JbMIWq9bEmjVxuwA8sz
 nqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208647; x=1762813447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVIEVTmEwnZdHXAWkRY5qhlmNokGDBKXHhE7HxZS6Do=;
 b=MaPULovTGRJiJQxaai1ddmyHvJVkY0ClesyR96VJ56FtJ4/8jCS5j043Y2DsohOMq2
 8cj8pELDO3QGC42GXco8YtMOQJaQFwq3giql10NfIbjC25GCX+UvKhxEaS6bKwluDLHY
 /7Z/P3Mr4aGrOMg8Jd6eaM+0Gi1UIhHHVSHRdjTP4jYT7GfjpKJ2eSIrySZsSJbP0iUS
 QFsJ+8vqdFfCtpLCOzIupat7Fh8Uxqen4INd2kDMnVT0t5V5m+drP0VeZzNpN9S2Lkhr
 ctNMEcuU1WXTSATYDgH7Y4dGznNAVSpclzINWn0MuU7X2uBEvyXeU6LHyxYKHqHpSb/c
 cvOw==
X-Gm-Message-State: AOJu0YwIVFmstltLzxIn7NCjEOFm4j5jW2bPHUWPNQScrI98rufvqOLz
 e1nCv2xKeor1OV5mzHng9LOfakjVJvtyC08fiC9HSwHs2LUXjAU3NQT5QYoyAza+
X-Gm-Gg: ASbGncvYp4t0JmMwDPghnEcpqwLQfkBnfallW0YaEDKOdHLJjS+7diO6KatLtJJ9Fh1
 5pfFZGIP9LiWzw7aqWTDJD9UEvQbX53fuU2aKggUO9KLERksMxGgaLPX9e7/oUVNtV+5eJ9PFsQ
 bjtUQyJXvJT0wvOcfL3fmeOs3IFWecwbDeIWcO/FiWtBgmG1p1zN79NsiIV0BYY2d8P5iuL9mRY
 sXGULHZFQXPQA1fFNUOa8REEfQu93ZrFIZU/4sxpDhIsJGd4T2UybYhMDqhdDVJ32C6xTbIjMGw
 tD9lLpf3eBNPy1aW2AvDmFb5l7gIZKp/MbdKzOnxK1515FR6DmRtAP7t8DjR1YdoxhOTQXU1UJk
 pMdOfiiJxvVpevluekWGMY2yrHneOjSOZeXZbR4P8cl+nl5qxRLLFvbhLUDBXtzhiVhFcR1Ab6x
 uy9X39FUL6+SFOTHKBY3snOPGT96EHLg==
X-Google-Smtp-Source: AGHT+IEVVB1IZADk5zV+LIf8kMaSJNjctyn9R2P5fTc5jgQv1aFFDdoQxlsRX24QbCAbdVawseeWWg==
X-Received: by 2002:a05:6402:12d0:b0:640:e7bc:d3ce with SMTP id
 4fb4d7f45d1cf-640e7bcd612mr360901a12.11.1762208646684; 
 Mon, 03 Nov 2025 14:24:06 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:24:05 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 08/16] drm/amdgpu/vce: Save/restore and pin VCPU BO for all
 VCE (v2)
Date: Mon,  3 Nov 2025 23:23:25 +0100
Message-ID: <20251103222333.37817-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103222333.37817-1-timur.kristof@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
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

VCE uses the VCPU BO to keep track of currently active
encoding sessions. To make sure the VCE functions correctly
after suspend/resume, save the VCPU BO to system RAM on
suspend and restore it on resume.

Additionally, make sure to keep the VCPU BO pinned.
The VCPU BO needs to stay at the same location before and after
sleep/resume because the FW code is not relocatable once it's
started.

Unfortunately this is not enough to make VCE suspend work when
there are encoding sessions active, so don't allow that yet.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 44 ++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   | 52 ++++---------------------
 2 files changed, 24 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 2297608c5191..4beec5b56c4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -206,6 +206,10 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 	if (!adev->vce.fw)
 		return -ENOENT;
 
+	adev->vce.saved_bo = kvmalloc(size, GFP_KERNEL);
+	if (!adev->vce.saved_bo)
+		return -ENOMEM;
+
 	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_VRAM |
 				    AMDGPU_GEM_DOMAIN_GTT,
@@ -254,6 +258,9 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev->vce.gpu_addr,
 		(void **)&adev->vce.cpu_addr);
 
+	kvfree(adev->vce.saved_bo);
+	adev->vce.saved_bo = NULL;
+
 	return 0;
 }
 
@@ -290,13 +297,19 @@ int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
  */
 int amdgpu_vce_suspend(struct amdgpu_device *adev)
 {
-	int i;
+	int i, idx;
 
 	cancel_delayed_work_sync(&adev->vce.idle_work);
 
 	if (adev->vce.vcpu_bo == NULL)
 		return 0;
 
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		memcpy_fromio(adev->vce.saved_bo, adev->vce.cpu_addr,
+			      amdgpu_bo_size(adev->vce.vcpu_bo));
+		drm_dev_exit(idx);
+	}
+
 	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i)
 		if (atomic_read(&adev->vce.handles[i]))
 			break;
@@ -316,40 +329,17 @@ int amdgpu_vce_suspend(struct amdgpu_device *adev)
  */
 int amdgpu_vce_resume(struct amdgpu_device *adev)
 {
-	void *cpu_addr;
-	const struct common_firmware_header *hdr;
-	unsigned int offset;
-	int r, idx;
+	int idx;
 
 	if (adev->vce.vcpu_bo == NULL)
 		return -EINVAL;
 
-	r = amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
-	if (r) {
-		dev_err(adev->dev, "(%d) failed to reserve VCE bo\n", r);
-		return r;
-	}
-
-	r = amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr);
-	if (r) {
-		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
-		dev_err(adev->dev, "(%d) VCE map failed\n", r);
-		return r;
-	}
-
-	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
-	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
-
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
-			    adev->vce.fw->size - offset);
+		memcpy_toio(adev->vce.cpu_addr, adev->vce.saved_bo,
+			    amdgpu_bo_size(adev->vce.vcpu_bo));
 		drm_dev_exit(idx);
 	}
 
-	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
-
-	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 2d64002bed61..21b6656b2f41 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -448,14 +448,8 @@ static int vce_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-		unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
-
-		adev->vce.saved_bo = kvmalloc(size, GFP_KERNEL);
-		if (!adev->vce.saved_bo)
-			return -ENOMEM;
-
-		hdr = (const struct common_firmware_header *)adev->vce.fw->data;
+		const struct common_firmware_header *hdr =
+			(const struct common_firmware_header *)adev->vce.fw->data;
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCE].ucode_id = AMDGPU_UCODE_ID_VCE;
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCE].fw = adev->vce.fw;
 		adev->firmware.fw_size +=
@@ -506,11 +500,6 @@ static int vce_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	/* free MM table */
 	amdgpu_virt_free_mm_table(adev);
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		kvfree(adev->vce.saved_bo);
-		adev->vce.saved_bo = NULL;
-	}
-
 	r = amdgpu_vce_suspend(adev);
 	if (r)
 		return r;
@@ -561,20 +550,7 @@ static int vce_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int r, idx;
-
-	if (adev->vce.vcpu_bo == NULL)
-		return 0;
-
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
-			void *ptr = adev->vce.cpu_addr;
-
-			memcpy_fromio(adev->vce.saved_bo, ptr, size);
-		}
-		drm_dev_exit(idx);
-	}
+	int r;
 
 	/*
 	 * Proper cleanups before halting the HW engine:
@@ -609,25 +585,11 @@ static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 static int vce_v4_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int r, idx;
-
-	if (adev->vce.vcpu_bo == NULL)
-		return -EINVAL;
-
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
-			void *ptr = adev->vce.cpu_addr;
+	int r;
 
-			memcpy_toio(ptr, adev->vce.saved_bo, size);
-			drm_dev_exit(idx);
-		}
-	} else {
-		r = amdgpu_vce_resume(adev);
-		if (r)
-			return r;
-	}
+	r = amdgpu_vce_resume(adev);
+	if (r)
+		return r;
 
 	return vce_v4_0_hw_init(ip_block);
 }
-- 
2.51.0


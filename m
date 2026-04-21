Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78ACF8FA71
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 12:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4802E10E1BA;
	Tue, 21 Apr 2026 12:55:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T7NnjwJd";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5122210E1BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 12:55:19 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488ba840146so39798245e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 05:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776776118; x=1777380918; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wIReNIDj/1Am+F1I7OeYCc1B+avnS1KWJhnT6nZ6llc=;
 b=T7NnjwJdNHz41Co/3zhCUILKkN6mbjdckxA0/EMNI6o5L9HnEiKDrk8o7cWYRWRDCr
 pxWObwcIk3ln4dKmJOiDflLXBET7h2Ay48lQUUcEq+vZ46w6nMRuwndV0GniRf0kTsJh
 JqvSnH/P/BZCko7KbedZFtA6ohykzeu5z7P/nGZnC0XJYl7CcnUHvtzI11C6lXGg896b
 r+HktamIAxt4Db8RI4ec1JUpv1kgWs0ZWdfX2MaVgpmPviEWwrNkKGl92C7V4MmMI6Iz
 sQKMAovlikKm+t3IhK1Fu9stc/ayLAiKMSC42S/0SSNaWsfj7p9pwBkm/PXHpbkKt5JW
 OWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776118; x=1777380918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIReNIDj/1Am+F1I7OeYCc1B+avnS1KWJhnT6nZ6llc=;
 b=V1zB7etfFlGasLNWMsGQh5TrA53u0SHLX/+vqE/ZA4sJn2sa5GgrxyekfndGz+Jslz
 63S8PD8GqxQGUUJatoHhnB+Jf02FVEQfjXHg9zRTLh5wqxtn6zJaCDYofxPSQmkq9wYO
 CKhZ1l93JE4ilHJ0Fp2VelDmpoRkf2SkCUYumF2lAwQ00SYJykGOJQe9rURETUxBYyDt
 hsQcDrG4xp5M3Unhh2RRnNJ0sCyEjf0f6n3Pezr/tl86G7Br37N8jtd9UPckAPA5o4TG
 VwtBRCmDEE2s9WuQ1xrXKGasr0SEvXzkXDct4d6oKDPvfhOhbnXJZeKcS8tlFkq4fv4Y
 0hVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xh9gtuKjr44jhMSy+v7yUFBT4ylZ6QorOm8/IHwa03W6Wd108QbiaPSDgxC4Irl5N+WnQTLJi@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywju+f4AJwz0G8y9MlCNmGKU2qR+KVNus79ALmk5a3cclbOBFjB
 uA5WW7SSCQcYhsk9XMWohLIOro4rzHblUXtuKGepe677UuY9H+neg2hi
X-Gm-Gg: AeBDietT96q6ORj3i2KIPSLwLBwR0HRV0psvu24d6ogtps3PWEvjOXqcND6ro+uBh8Q
 ZLqctzxACiRXVFBJiCYncrgpne9HjIezAExrFbkSfQXSIx1D1VLArzoiKBR+7cUkrQDUfvpvO0v
 cIPV752n2e9z2ZL8xEVddk9jrH7r9iUyWHQrsWOcvzjyu1yQf2aa4jv9NMUXPtGL39/u3IiF0ng
 Fh/Uercj/8AEKj7L8otJDjTLhZ9XrVumQteF02EBVhGfzTuqsBFnQ1tlDpAJu5yU8u6deQNoXFq
 hw+eYtl3ydZHXO13vrhSFtS5Vmjun5EnTDKwffLLZ9Fq9UjmjdkTqaBnW4eS/jskvR9H2Ydibwz
 QjpFyDbyfcUUzWosr9xJ4Cih95Cr0NkHbb7QYXnEa8yhUcfP0Xun1oHse4wV3qoOehYvsLp4suL
 LFNEP5Y+XPBKq2hWCdpEV+vLlGETCsuaPqCyFXnWhJbNL2jHO0788LJ1lh+g==
X-Received: by 2002:a05:600c:8115:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-488fb77e27cmr217672055e9.22.1776776117502; 
 Tue, 21 Apr 2026 05:55:17 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15aa:5a00:935c:42ec:dfce:89a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb79ecb9sm154777915e9.8.2026.04.21.05.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:55:15 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [PATCH 01/11] drm/amdgpu: fix AMDGPU_INFO_READ_MMR_REG
Date: Tue, 21 Apr 2026 14:55:03 +0200
Message-ID: <20260421125513.4545-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

There were multiple issues in that code.

First of all the order between the reset semaphore and the mm_lock was
wrong (e.g. copy_to_user) was called while holding the lock.

Then we allocated memory while holding the reset semaphore which is also
a pretty big bug and can deadlock.

Then we used down_read_trylock() instead of waiting for the reset to
finish.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 9e823f307074 ("drm/amdgpu: Block MMR_READ IOCTL in reset")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 57 +++++++++++--------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d88e4994c8c1..24526e92f9b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -873,68 +873,59 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				    ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_READ_MMR_REG: {
-		int ret = 0;
-		unsigned int n, alloc_size;
-		uint32_t *regs;
 		unsigned int se_num = (info->read_mmr_reg.instance >>
 				   AMDGPU_INFO_MMR_SE_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SE_INDEX_MASK;
 		unsigned int sh_num = (info->read_mmr_reg.instance >>
 				   AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SH_INDEX_MASK;
-
-		if (!down_read_trylock(&adev->reset_domain->sem))
-			return -ENOENT;
+		unsigned int alloc_size;
+		uint32_t *regs;
+		int ret;
 
 		/* set full masks if the userspace set all bits
 		 * in the bitfields
 		 */
-		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK) {
+		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK)
 			se_num = 0xffffffff;
-		} else if (se_num >= AMDGPU_GFX_MAX_SE) {
-			ret = -EINVAL;
-			goto out;
-		}
+		else if (se_num >= AMDGPU_GFX_MAX_SE)
+			return -EINVAL;
 
-		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK) {
+		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK)
 			sh_num = 0xffffffff;
-		} else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE) {
-			ret = -EINVAL;
-			goto out;
-		}
+		else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE)
+			return -EINVAL;
 
-		if (info->read_mmr_reg.count > 128) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (info->read_mmr_reg.count > 128)
+			return -EINVAL;
 
-		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
-		if (!regs) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs),
+				     GFP_KERNEL);
+		if (!regs)
+			return -ENOMEM;
 
+		down_read(&adev->reset_domain->sem);
 		alloc_size = info->read_mmr_reg.count * sizeof(*regs);
-
 		amdgpu_gfx_off_ctrl(adev, false);
+		ret = 0;
 		for (i = 0; i < info->read_mmr_reg.count; i++) {
 			if (amdgpu_asic_read_register(adev, se_num, sh_num,
 						      info->read_mmr_reg.dword_offset + i,
 						      &regs[i])) {
 				DRM_DEBUG_KMS("unallowed offset %#x\n",
 					      info->read_mmr_reg.dword_offset + i);
-				kfree(regs);
-				amdgpu_gfx_off_ctrl(adev, true);
 				ret = -EFAULT;
-				goto out;
+				break;
 			}
 		}
 		amdgpu_gfx_off_ctrl(adev, true);
-		n = copy_to_user(out, regs, min(size, alloc_size));
-		kfree(regs);
-		ret = (n ? -EFAULT : 0);
-out:
 		up_read(&adev->reset_domain->sem);
+
+		if (!ret) {
+			ret = copy_to_user(out, regs, min(size, alloc_size))
+				? -EFAULT : 0;
+		}
+		kfree(regs);
 		return ret;
 	}
 	case AMDGPU_INFO_DEV_INFO: {
-- 
2.43.0


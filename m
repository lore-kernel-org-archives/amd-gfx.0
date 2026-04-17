Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354AAF436A8
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 14:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6DBD10EA10;
	Fri, 17 Apr 2026 14:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FNUVd8rg";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 089D510EA10
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 14:06:36 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so529193f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776434794; x=1777039594; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=53yDVIV6hW5ROSbEpiEWFbadmmNFkg02Ky+QCOMfrcc=;
 b=FNUVd8rg/S0k5wJw2GjPEGxyPzezE4rMnylyzfkqEB51uRIgucQH5shtNRPGvDAt48
 CCjLM9pd32GTFG8SQbOz0d0IV+rB8uvNe9N6PzVecyQES3oSsmvm9r0jn+zHXZb1Tp7x
 jQLU7OC2wh2TkcXKmm5C18qZzWvJ+8uKtE41k+2IELktp55YwUfoLTN9CvwmqehVvGiI
 tiMqeqijNYJsizqCChPQz5HhWqDrhE0aGL+U9f0CbTXchgH4d4scWBGtSkO0pdPDjrKW
 ISXhnBDfHxe4g8bKsAMvrSdZE+r2wVfMSykmXw+nr11q6CicyZ2TQtUcinLjDfK3DwL2
 uPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776434794; x=1777039594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53yDVIV6hW5ROSbEpiEWFbadmmNFkg02Ky+QCOMfrcc=;
 b=ZND2eMhZMmJM0wO+poc3dSc5pr2doVrmWdTiAMyMOE9JW+Ep0weOuPbhCS2+UMaFk4
 Ms2t+72yEovEMJdS1JUJEGrncYspZ1HMbnE9vRgxIhm1xKgs8ts52q4itCEA8bYHcK24
 sklRdUL3HOz37GD3bgGrMzCyRZ9ppNtn7iHX96AYWgWcT2UIWvL8xBDwg9j7o7Ji4dlU
 OpTQHMKpShO4uZOLyt9EiV3NNr/doMQ0D6nRT3NBs6BYLlb3whyo9n8+vNQ2PSFYiAuq
 EJXKJb14UEup6JlzaTEjThzoQkbEbolVnkky/VW4s4q/7ENb8hFrhyygqvodXNT2BUj+
 pfOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YU9rGiO9+AH+gG1AE2/IVHS4XWcmVqRMP52Rm73vCVx1+dPBXZ9yJnl4DKWN80BmkaRssV1Nf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRDSxj8Ku3AWSuamCG25DbN5iunqGW3Z5GLwhArg84q1A8vjW9
 tJG1KsPhp/yLm8pLLMvGCLa/hx3PEQCqq7fQr5TXtDvQ6G8GUg9kkwq1
X-Gm-Gg: AeBDietljOmAuiW0mRl4+2ZghZidQePIe3MWnvKixtnj9xhjIskDrbU66UbAl02Hvwj
 2TmCN9/QVle1VhK7Lvb7qToIZHYCgyVxDrjjIfQ1M1vYm92/+7ML6a5cC1WtTpOiVbyKE+Xf+O8
 ODK/KTpZQDm703IZOXZz4cbKyULXm+ZzFxkCWeTEMNepDh8+BunQ4MvumwhEXXxzzd9zPO1LMHa
 IK7J0G6Uox+iEZrWQUYrRIwixWDprkJ69HIKrURPlmMYByX3FcSnCVMrsHft5uYBTRD3Map8mNa
 9FD3JnJy5blhNOkd2Utk24j4Nt89r/433RZZoW9YHcTt0GnTwGPjLxIMPRLbYwhB1R4YRp/n1lO
 9+pvCEZCftBIvmKrJwu3dZwOF4pVP9C++eC18kCt4JBmN2Q7n0whXQ5D9PkJIe0XhDTx8qmWHkp
 bTB2SMBg1aIEU01LBcv5Md75ycEJG0cQN+prvPOooBuS+Kb5g=
X-Received: by 2002:a05:6000:2502:b0:43e:b0f8:c564 with SMTP id
 ffacd0b85a97d-43fe3dbd756mr4514957f8f.9.1776434794233; 
 Fri, 17 Apr 2026 07:06:34 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154c:ce00:6b71:1e67:470a:419b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a397sm5278090f8f.23.2026.04.17.07.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 07:06:33 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: victor.skvortsov@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [PATCH] drm/amdgpu: fix AMDGPU_INFO_READ_MMR_REG
Date: Fri, 17 Apr 2026 16:06:32 +0200
Message-ID: <20260417140632.1476-1-christian.koenig@amd.com>
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


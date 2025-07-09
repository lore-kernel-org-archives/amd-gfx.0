Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C69C83F03
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jul 2025 12:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E1510E081;
	Wed,  9 Jul 2025 12:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKSTHmdc";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1415010E081
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jul 2025 12:51:22 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso7018985e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Jul 2025 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752065480; x=1752670280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nvBN3P2ZtNaRGhseSY8gEyJ47w2RBpiwyVFP3mednUQ=;
 b=fKSTHmdccKbxx4zOjlhfIi1rRFoLh9u00yqX2wpVZjnSQQHseaK0Z0pP0Gs1tpDUGs
 +SXkHB5yQrJJpJdWqcIWegAI7FXsCmaXz6yL6wGqqgF0MkYrVX0Lq5nOMiIaavHB8j9D
 b282LfuUEC2cBe4YM8vKJ4Wo2a3zZ9sWAjWXjn2L7uXSyOTGOV5lH3DNBZjcLt7BSLpG
 hdsANmbShg0FwMlDxctcSgnEo/2T6XKw9f6O4nOvKiidVHABxEHCdhw3pvEkluVnNZXz
 rplMMt5suQYDaodwideMJScdyqUNymPzwKoExEFN3sdi+RZjPRw/ZSeUp0cWQ84vuFer
 0Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752065480; x=1752670280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nvBN3P2ZtNaRGhseSY8gEyJ47w2RBpiwyVFP3mednUQ=;
 b=euNvPtKDK/2Jy1Iz7u11xXGymg2AZpy7kqBwZUoB22v1g5MOJT9Pb6QFMY1bRVAsJw
 QvYiIIHoU4/xjOvcfWGqcTfTQgKsRt9xLTNbiTvSRljLo40ueR4ylNFWOp1t9lb25JDq
 OxrR6Z8laOlMiczuO2jZkwkTNCIWEKbDBywOQMCuEas7MOFZ8OlaGJNmOHjKCfJqP4kR
 Ufr69qQmvxKhO6umvoYiXuv0X+y7U5lchUmvFJYkxwc5ptBj2FAh3440PqK1NsTQWPGU
 qhfoCrXXY60wzgi44CbKMpN/JEis/In/6GkfQQ1cdAjdbw2i83ckN+lSP+TVMIg/Ur5k
 fSGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWee6HN2HHitT0WXBil3ma9bHjijVC27+xgieRVdTr/bheaw+pY2Inhr4nu3WJNqBFToV7mBcaX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGeMKH6ez+0YF+TbQvKqWBIHvmqKDI87gVDIlvOF+mKV18MXVm
 R6Mz7lg+E8WOFaL+4EJWe7TWEQ+mf+Gojs0+KYgswt3o/OlML4EnehkA00kN7g==
X-Gm-Gg: ASbGncvDzZV/qpjhq+yhoG0yAwgo6Ar1UK4R6CSTT/rLYLXmcF3LepjBbao0ns26b9B
 6cWGwBrPOAi1HvUk+gkCajdl37h6nFGLERKIhbeCd56IzsBAqDvCP+J0ox2SZ4jkOSr0bogDmxC
 OMqjDPygV0YZVUG8l+EwL9nSi9+H2IWXvLaZQuJMiq19aFlf1ykys34/qBmHykiBDbxuqOhW/Pu
 NvaselelsezalXaF6iJVIuiTIYiFLWjzeMITUwzLDh7j951Tu451nTczMJ3Sg5Z+CrcghQvebWX
 xf2FSWWxT1kIjbQzTyXI3i6H+D/GAER2KUIjnSyE0LTMyGQl8Hxm+eajU2YzzMbXHnPGYqKiZj5
 tygnBVgpGpg==
X-Google-Smtp-Source: AGHT+IFbbs8LDUi6/jjwjq9igZg4mPfG0dn5xazRfZroUjjiiHDn7SYwP7QmnwDggNAiN8CqGym7wQ==
X-Received: by 2002:a05:6000:24c6:b0:3a5:5130:1c71 with SMTP id
 ffacd0b85a97d-3b5e43939a3mr2081612f8f.0.1752065480335; 
 Wed, 09 Jul 2025 05:51:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151c:7900:7436:f040:34aa:3634])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225a491sm15728798f8f.76.2025.07.09.05.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 05:51:19 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, david.francis@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: rework gmc_v9_0_get_coherence_flags v2
Date: Wed,  9 Jul 2025 14:51:18 +0200
Message-Id: <20250709125119.1606-1-christian.koenig@amd.com>
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

Avoid using the mapping here.

v2: use amdgpu_xgmi_same_hive() as suggested by Felix

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 380b7b81ac1f..71f134d54fe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1124,8 +1124,8 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 }
 
 static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
+					 struct amdgpu_vm *vm,
 					 struct amdgpu_bo *bo,
-					 struct amdgpu_bo_va_mapping *mapping,
 					 uint64_t *flags)
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
@@ -1135,7 +1135,6 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 				     AMDGPU_GEM_CREATE_EXT_COHERENT);
 	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
-	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
 	unsigned int mtype_local, mtype;
 	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
 	bool snoop = false;
@@ -1165,7 +1164,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 					mtype = MTYPE_UC;
 				else
 					mtype = MTYPE_NC;
-				if (mapping->bo_va->is_xgmi)
+				if (amdgpu_xgmi_same_hive(adev, bo_adev))
 					snoop = true;
 			}
 		} else {
@@ -1257,7 +1256,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 	}
 
 	if ((*flags & AMDGPU_PTE_VALID) && bo)
-		gmc_v9_0_get_coherence_flags(adev, bo, mapping, flags);
+		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.vm, bo,
+					     flags);
 }
 
 static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
-- 
2.34.1


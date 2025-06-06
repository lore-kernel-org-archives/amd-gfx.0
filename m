Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492BFC61DB2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 12:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D8310EA95;
	Fri,  6 Jun 2025 12:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kTAKFpiT";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B2189208
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 12:57:27 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so1073919f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jun 2025 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749214646; x=1749819446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lMohLp1CGNk7W7O/aqHyTTARLuimczaO+auXgQJGlDE=;
 b=kTAKFpiTrCRmOQzoO1Qw48WUJ6gAvYIMlaIyt1csyPGFaYbB2GJzpqWBEYVlaYQ2xz
 hXNGe1z+S5tySHewPwfOPDU0I2s4pfYqYM24jc+2h8ZI6AqA+C2bW4z6ExVbmc1VSnGO
 7X4YCUihGc3gaHEOv9b5X8ijczcxUsqKYrPk+nhGyLoAzIa2yjozuvJUiiyXxnKOIGDX
 jFJqsLup9WiywFNYMUZcuds3RC35+4sJQ8mjQ+yRK9/uLfCzATLFGzEQivMfElonIjBo
 NGQB0EkqR8n+eR3PwrDz4S+wLbNch5RvTNgvsoggCmpxn8JSwtn5iFE/2vwR/9dMJnD9
 R9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749214646; x=1749819446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lMohLp1CGNk7W7O/aqHyTTARLuimczaO+auXgQJGlDE=;
 b=Q7KNcSYpvS22Mvipwwyfmbtxb8q/o/Q1FecWoICllkF3tKBgVIh/Z1rJQdwPgMQDOt
 8X4/PhThUYpaShdpqmQ3b2foixIVAFC0ub9GLtKI4JqNnTLpqllK+f4wz4QYK1xUhER+
 KaHjojky4EuAg8S5uAxGCX3Zotdu1NnYq6XPyCsGp4QZOWLlUMnzf++DhhtWopO8XRjU
 oOJ2ljT6DDMA8vMPlifHIaxx3I4jNY/JkqvIIjdNScC+mYP5UIxwLhP81Kwn29czAK6g
 8SfysnTsIH+VWbQKIUNlTEBV/p/yXicpmxcUPy7bWF/Yrfl5tGWaV2+8H6NBKjRL44Oy
 zq/w==
X-Gm-Message-State: AOJu0YyMtRnEdbU2ncFhnZfbsVC8VazcFqdSoG/VBBp9C5O3Y5Sksg+B
 UH/YAJAudIVF3osbgKgsvgzgDkNSv4nM3EjWDOTUAFcAr6bcoHGeIjoiAaU++Q==
X-Gm-Gg: ASbGncsxEG6zyujtAxVH5gK0kbDHdQhifI2b/ld7qQLQlG7QdR5jenoHpt96pCrCuAG
 eUSTto8srauwBD92KAPrdkox30eG00g9VQAwDuEV7ynJtKCl1QfTxyAcQPi2iwZ51TcUQlivN7A
 7Gt8UENDlvNTmjbkcjKGG3XtILHMunjJifLVx/kEOT1AeOI9QuiMJJFVMu6CNtzdhIIks000Zsn
 En0iNfVcvluc9H46rrjf5xF4xw/KSX4xZjPR3z8N1zCUViuNKFImw+m0K6GPoJuVVfKv2FwITQe
 GJwKrOBKLH2yf+BA6VwL/9N3pwf3onVMcquHhRMOSPZkZi4p1/2wmZ62vhNfinf9CEvHF0j+/GY
 =
X-Google-Smtp-Source: AGHT+IF/7Zc6S8svtTphOnfpmpWw3TzlYhNMDfDBtqUYRGDZJ2sJ7tkAnLp4bGZBTXS82s1se6BjTg==
X-Received: by 2002:a05:6000:144d:b0:3a4:f8fa:9116 with SMTP id
 ffacd0b85a97d-3a53178495amr2419114f8f.8.1749214645234; 
 Fri, 06 Jun 2025 05:57:25 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1565:ad00:26a5:e8c7:a8d0:1cac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6d6dsm23539075e9.3.2025.06.06.05.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:57:24 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, rajneesh.bhardwaj@amd.com,
 felix.kuehling@amd.com, david.francis@amd.com
Subject: [PATCH 1/3] drm/amdgpu: rework gmc_v9_0_get_coherence_flags
Date: Fri,  6 Jun 2025 14:57:21 +0200
Message-Id: <20250606125723.7822-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e691cc61ef6e..cad014c3bbf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -30,6 +30,7 @@
 #include "gmc_v9_0.h"
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_gem.h"
+#include "amdgpu_dma_buf.h"
 
 #include "gc/gc_9_0_sh_mask.h"
 #include "dce/dce_12_0_offset.h"
@@ -1131,8 +1132,8 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 }
 
 static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
+					 struct amdgpu_vm *vm,
 					 struct amdgpu_bo *bo,
-					 struct amdgpu_bo_va_mapping *mapping,
 					 uint64_t *flags)
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
@@ -1142,7 +1143,6 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 				     AMDGPU_GEM_CREATE_EXT_COHERENT);
 	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
-	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
 	unsigned int mtype_local, mtype;
 	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
 	bool snoop = false;
@@ -1172,7 +1172,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 					mtype = MTYPE_UC;
 				else
 					mtype = MTYPE_NC;
-				if (mapping->bo_va->is_xgmi)
+				if (amdgpu_dmabuf_is_xgmi_accessible(adev, bo))
 					snoop = true;
 			}
 		} else {
@@ -1264,7 +1264,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 	}
 
 	if ((*flags & AMDGPU_PTE_VALID) && bo)
-		gmc_v9_0_get_coherence_flags(adev, bo, mapping, flags);
+		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.vm, bo,
+					     flags);
 }
 
 static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
-- 
2.34.1


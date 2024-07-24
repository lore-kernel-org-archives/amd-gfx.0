Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93F2C3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 07:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE7F310E2DA;
	Wed, 24 Jul 2024 07:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZGD2DOa";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 720D010E333
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 07:50:50 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-367963ea053so4690800f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 00:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721807449; x=1722412249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iDaISWn73gg0XHzgrTtUaGoVUuMsXFDTottSzqiiETg=;
 b=kZGD2DOaFyY0lX6XO2i9mvJfQm69zldqcO46shZOGOj2+C61ynK8QJh9KHprN+IHIF
 NEb+U63Qm9ZW1uPbGWeL0WAaIOxelQLZc7aX+jrIaZl6d+SXgb/Tz0dFuil3mRm8oasK
 dkEiDT2SrN4EphXY+xmz6ZKGKVLbthMCi3q0o9vmSRlcctbA9mmthwdVNXGxHLaMPdWc
 NRv/ZOcL2c/D1Z2aHWriMxAmCFmvEmfv4TiVpmhFgnhszIWnT/O23oWZo3yIHRf87T92
 DyCcja7VoRb9Id+mG5/aVSSt/HQz3uZZsrrjPeT5YOEItfrsISdishUm97db9stqVrih
 f5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721807449; x=1722412249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iDaISWn73gg0XHzgrTtUaGoVUuMsXFDTottSzqiiETg=;
 b=LlCpjiiaxPCPhYn/7FGzV0J+kfgayCWiZNyghiPT49SnWhcTW+ZiZMq2aFI879eVX8
 M7McDNgGWh7SX7hTkbtdESz9k0dJ/advYgMoHCt/L0sMDBxtHpPDs1cco2+5wCEsXSub
 zHam08sioRV4jHodQxdn6nYi8+fbhJ/XYmJBxzvzs1DrY5qAM3TfhtOp9Ox0eJjwlUSq
 Szw1iqi7ir9L/RFeFb7dOr47W9JOc3V/q9Uw+aqlJZT/4m3ZcfGvUK1JA+4ncz0/3yTS
 qkp5G/eC6YbdxQoL4IYZsOG7xDbDS8QZVdwuO5yfwtxcY2g+HRsTaNNpY5nXEZXSOO6m
 fC6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX//4UaBxUyGErVNKbXGdNQiXSdoo/JfzSFpp8RDGbpPVRsuuGCMy+Wn7XaFLZNhO6KMFuYHfXKHAvHPoygo1lUD3W1IKXCaUp9cbapog==
X-Gm-Message-State: AOJu0YwhQ3wIz0BOtTVQb2DXBSMpNDX2a5zxwYSPUF7S6LUfXw8Z+9Im
 VIHIXbmK3D5oQyii/2cvGS8mc/nhWvRYXJVB6nLwYLX0jdG6OKU10nvN4Wkz
X-Google-Smtp-Source: AGHT+IH/rOuwJS1fp9+nwhnzAUQKXm/HywdGU/UivllAXsMcP9q5z27OtRI7VBEvxHXgXzRRYZAwNA==
X-Received: by 2002:adf:ea04:0:b0:368:37aa:50be with SMTP id
 ffacd0b85a97d-369f0a99084mr1543226f8f.52.1721807448454; 
 Wed, 24 Jul 2024 00:50:48 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1555:fa00:797b:ac79:ae76:76fe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ebab0sm13641906f8f.92.2024.07.24.00.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 00:50:48 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: airlied@gmail.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix contiguous handling for IB parsing
Date: Wed, 24 Jul 2024 09:50:47 +0200
Message-Id: <20240724075047.57198-1-christian.koenig@amd.com>
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

Otherwise we won't get correct access to the IB.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ec888fc6ead8..41055224930f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1763,7 +1763,7 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_va_mapping *mapping;
-	int r;
+	int i, r;
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1778,13 +1778,12 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != &parser->exec.ticket)
 		return -EINVAL;
 
-	if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
-		(*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
-		amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
-		r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
-		if (r)
-			return r;
-	}
+	amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
+	for (i = 0; i < (*bo)->placement.num_placement; i++)
+		(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
+	r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
+	if (r)
+		return r;
 
 	return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
 }
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6EECCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF01710EAFE;
	Fri,  7 Nov 2025 15:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JgJwtYz0";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E81310E0E5
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:57:57 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-477442b1de0so5945845e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531076; x=1763135876; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dCrbnWh+EGSj9vJg1Bb1SWr+vMTakV4QgqHGgI8vgj0=;
 b=JgJwtYz0bCFEHEHXnsA+F26nQ9IpIT0dn0L7/xLNtgwi4kNLvyJUrZrDi8RZkwwlNm
 jOMuFql/OJA+/3VeKiXZUAZcaIWdiCLLeNsImu1La7VvdrOA1sn3fpfq0QNcGD0Ewp9Q
 qkyfP2rGfJyDTtxeWvyYbmD4SHawIHe1MJT3aKEGrNufrB09dwI6oTTIMWLaQhcrQin0
 hOUiYE286Yb4/zuXiC2O2RwHySZW9KtmY/L/tTnwB/hzwG+k1aqpnPgf8v+iLbLqTIMs
 7PkpHWfeld5BjQ17K1Xm+1L2kbl8y2chXrGlWmH/x1z7L+ySaC0FEy+WAm/HYzNKPeuf
 PtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531076; x=1763135876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dCrbnWh+EGSj9vJg1Bb1SWr+vMTakV4QgqHGgI8vgj0=;
 b=G9vm2hR6luLvEZbLzgBr2Z+wgvgWt5elHMwvr9bxKez/8oZUS2CXCycZvzE1aBr00S
 sM4kyqTVh/3wWaR83YNK/Dv9YKlJRhPQjjTIPEw8PRpKm/kqPj1cj3KHCCTZoahYILPS
 tP/YqDpN82sxRf1p4I42EgugnQDs0CcIkyquZLZJrTARtD/tB5/8pyf73ZayUf8ucUhG
 Nkha7pjt+OqnnMtOT9m3MSBM21lf/Oj+MdbxFRH1rkjA8SPjm8IRMoB949kPWAWnD2OO
 kN3lngvIc5+tbm3l3aeRRcIG48RadDKH+uKJrhbafaZAeexET8dexbXoysKitJztugFP
 GzWA==
X-Gm-Message-State: AOJu0YxgBiKdbeRl3U29PUa8/vsFOH6yS3ZtcYqDaEzPrGBHhfkfwTMX
 xWo7bmxq87gpsFo8lZZjkpD9tX+dOU+2STG6Yl3MAZzvbnA93JZ5caQq/aLZEA==
X-Gm-Gg: ASbGncv7emU7wi27rMWdPmncK+LoNSPHMddovfxRNv6V//1QorBjKMv3kyAWivjHOo9
 v4AYGrUvAopX+eZLngnqJEnJGuVVEiGFTcvx9OO87S0HXfz5+4+nD4L3LqhxB+DyLs8FlmEH9XP
 CHBA+1+ne+RWGBk2VvvH+o9UEHnCpkwVyyiVA6fM1DidY7L3RxjBKVzTJIwoegnH7s74uokOR8a
 +hhO/OhHsJokocyyH1ZtH7gY+xbuzEmV8eGkYlC/RtC9w9a46URW9hr9Oi896pL4CPlYFZCXPFy
 3iNMqdzMaPV9C7Xkpf3PMxqerJNalmBvIfcfIB/+lCE6/JEy6unYmmUSYCXyoKVkA3Os5uXeQ/n
 u7wZIdOAZesvAJz10fO3F7zZkkL0OqC2zF8CwaBclVxdyIDqJR7XaSsyeTaw9cP+hE5Ae7beVxq
 GRilD6j2nxYTwb2cq656k=
X-Google-Smtp-Source: AGHT+IEdR3ie1La1Q6Njp9/OhsXqiVQsTsR/SnGjiTkRYbJYpWKisfsIOcDJdHJeVh6VIzKxoYOqvA==
X-Received: by 2002:a05:600c:6287:b0:46e:2801:84aa with SMTP id
 5b1f17b1804b1-4776bc22ca2mr32064995e9.0.1762531076049; 
 Fri, 07 Nov 2025 07:57:56 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:57:55 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 03/12] drm/amdgpu/ttm: Use GART helper to map VRAM pages (v2)
Date: Fri,  7 Nov 2025 16:57:36 +0100
Message-ID: <20251107155745.8334-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107155745.8334-1-timur.kristof@gmail.com>
References: <20251107155745.8334-1-timur.kristof@gmail.com>
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

Use the GART helper function introduced in the previous commit
to map the VRAM pages of the transfer window to GART.
No functional changes, just code cleanup.

Split this into a separate commit to make it easier to bisect,
in case there are problems in the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e226c3aff7d7..84f9d5a57d03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -188,7 +188,6 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	struct amdgpu_job *job;
 	void *cpu_addr;
 	uint64_t flags;
-	unsigned int i;
 	int r;
 
 	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
@@ -254,16 +253,9 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 		dma_addr = &bo->ttm->dma_address[mm_cur->start >> PAGE_SHIFT];
 		amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags, cpu_addr);
 	} else {
-		dma_addr_t dma_address;
-
-		dma_address = mm_cur->start;
-		dma_address += adev->vm_manager.vram_base_offset;
+		u64 pa = mm_cur->start + adev->vm_manager.vram_base_offset;
 
-		for (i = 0; i < num_pages; ++i) {
-			amdgpu_gart_map(adev, i << PAGE_SHIFT, 1, &dma_address,
-					flags, cpu_addr);
-			dma_address += PAGE_SIZE;
-		}
+		amdgpu_gart_map_vram_range(adev, pa, 0, num_pages, flags, cpu_addr);
 	}
 
 	dma_fence_put(amdgpu_job_submit(job));
-- 
2.51.0


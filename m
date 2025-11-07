Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5316ECCFA18
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBBAF10E0E5;
	Fri,  7 Nov 2025 15:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eX5QCx7X";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6EA10EB00
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:57:56 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so7613525e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531075; x=1763135875; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qP4H6b8idNhc5NlCtQyib5SKH/dkiNYhjeyEL1D1w+k=;
 b=eX5QCx7XVmejdmOyX17chPPw1Y34+BR8XkXvwg5Ey9yfvMCVq/TWutV4pal8k4kJ4x
 06Vmr31qNqC+1b0a4CinNy3OekiPmj8KRlYy5feT26BaY+tNRC3YXSiF2EP+tIiDdm85
 l38EonRdzdtqTSnR/ZJsecd9JWEiYhhYLCrKQXljloYqxt7QfpPtc46PjHGmT9lPZVAu
 D7CM6PPzClpwXeR4l0jcJtGz7F8u/CUdbcyUB4AooiQOfX1fZpabWR++bO2Bfv8jivK5
 cOGiS23IM8yleuUjolCCgGeO4Dh2lCaZNqbOytn5rhVNqAQac1uxvBPBWa0IcMN4UTLk
 I3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531075; x=1763135875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qP4H6b8idNhc5NlCtQyib5SKH/dkiNYhjeyEL1D1w+k=;
 b=gfTqBzJYfX0FR21QE1GQNAc5/jxRdN5xckyUPjm5I27SRXvOMYJqzgkqXwnGpgYwTn
 BsRhtDdYLynZpVedOksrUIMznyvU1djOSELg10M5YEbExd3g4jyFTdYoeA0AbEzSKfeY
 BbjEPJKd852JJQzRQAEP2HXOpnKSDZloxk/FaS0Ixr9Lc2pCoOJzjEF0sDzUYb2ZY04A
 OSz+nAhjrek/pMtoQyDT3x6YxKsnB0Q2kbmV5DVc9RFq4shDj4GNEal3mk1Svxy0Algl
 8EaRq8eLk4nUJiWQjO9LssYc8hyThTLRfAChmMN3hKsErnIX74GVce5R6tgoSs5wxnqz
 zDBw==
X-Gm-Message-State: AOJu0YwHn5ZSdgtlbmajR7c2Gtn9RMPkylefSUhhJhwE3pzbe34vQzFY
 EHCz/5uZglAdm3oZO5blfAaYVB3BGzPxIOIk+tgQSKr2GcQyvctOGsUtDg5keA==
X-Gm-Gg: ASbGncuxoNJUrrZsDxtG8swzs3vi/1zlmLS4hJXF7LchaNvYotIPoxuoWDJI+nHOu5X
 EPU/Wd8hR/cQ+FQVbhDXm8NvGWTlFHNaWZ/uWGbcmOTMxHp/9fI6hlbPkRft4XNMHQp9mUiNgHQ
 NUjFbxMpqVQnVoBwjqiPbWWkPw2EsbSQoC35NmKXUp0QEUH4oleqkK7+BOvZ9/zT4Uh9wrtcJ+K
 kfcu00M2C+Pn50sIzBa8Q4jsae83spW//hYZxNT0XAvmy+VUOpNno93G3lIu/S6gnZEhhY5qF/X
 su7IcXeFFK2hZqaAi9aSZXS+thK8ZFkH8zmPbEs7jTxw1gGCVFUgzpyqhfAOM6AJ0Zl3jQwjgW7
 /81NTZIUW31QlRJrc66bLVxNQbg9S/HAQcX8CgcvN9Ux9LJzW8jWj1/c+pPHGJ89HpuBQThiJRF
 /7G+nlWlydQFqSpFq92wE=
X-Google-Smtp-Source: AGHT+IEntsmUf1991Lu5pAEG6s3YGF2flORWBfffF6XiRVMj8oaKslpCzATjmnZnn5q8qEMqjhsHsQ==
X-Received: by 2002:a05:600c:354c:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-4776bcba3e5mr29346125e9.9.1762531075112; 
 Fri, 07 Nov 2025 07:57:55 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:57:54 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 02/12] drm/amdgpu/gart: Add helper to bind VRAM pages (v2)
Date: Fri,  7 Nov 2025 16:57:35 +0100
Message-ID: <20251107155745.8334-3-timur.kristof@gmail.com>
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

Binds pages that located in VRAM to the GART page table.

Useful when a kernel BO is located in VRAM but
needs to be accessed from the GART address space,
for example to give a kernel BO a 32-bit address
when GART is placed in LOW address space.

v2:
- Refactor function to be more reusable

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 36 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h |  3 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 83f3b94ed975..d2237ce9da70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -367,6 +367,42 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 	drm_dev_exit(idx);
 }
 
+/**
+ * amdgpu_gart_map_vram_range - map VRAM pages into the GART page table
+ *
+ * @adev: amdgpu_device pointer
+ * @pa: physical address of the first page to be mapped
+ * @start_page: first page to map in the GART aperture
+ * @num_pages: number of pages to be mapped
+ * @flags: page table entry flags
+ * @dst: CPU address of the GART table
+ *
+ * Binds a BO that is allocated in VRAM to the GART page table
+ * (all ASICs).
+ *
+ * Useful when a kernel BO is located in VRAM but
+ * needs to be accessed from the GART address space.
+ */
+void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
+				uint64_t start_page, uint64_t num_pages,
+				uint64_t flags, void *dst)
+{
+	u32 i, idx;
+
+	/* The SYSTEM flag indicates the pages aren't in VRAM. */
+	WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
+
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		return;
+
+	for (i = 0; i < num_pages; ++i) {
+		amdgpu_gmc_set_pte_pde(adev, adev->gart.ptr,
+			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
+	}
+
+	drm_dev_exit(idx);
+}
+
 /**
  * amdgpu_gart_bind - bind pages into the gart page table
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
index 7cc980bf4725..d3118275ddae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -64,5 +64,8 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 		     void *dst);
 void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		      int pages, dma_addr_t *dma_addr, uint64_t flags);
+void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
+				uint64_t start_page, uint64_t num_pages,
+				uint64_t flags, void *dst);
 void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
 #endif
-- 
2.51.0


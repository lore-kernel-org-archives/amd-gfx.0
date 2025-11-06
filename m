Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58868CCFA13
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 18:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C555010E9BA;
	Thu,  6 Nov 2025 18:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f4Jxe5+J";
	dkim-atps=neutral
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C1F10E9B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 18:45:42 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-54bc08ef45dso812660e0c.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 10:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762454741; x=1763059541; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qP4H6b8idNhc5NlCtQyib5SKH/dkiNYhjeyEL1D1w+k=;
 b=f4Jxe5+JrbzDS/8yF5kZKe1VWoRCy8nPnvZdAtjb2UKtSi0cVSVinwZBTwmrpI6fqL
 QZ20DhEU93tyO4yRzj2l2GGG84Wr0NdvjGp9RAMJNh4V1Gwii6GaAJMl65BvYQb1W70Y
 ecJ8MU6Vm+QZbUIaJH2250mk0DYjuyE+VZgNS0ySBQfo8bgsqNWQzl90vH3x6MtSxh9N
 EZBl4lL7IBjAeQnOtPnAyPV8qT7gu9Zj9n0x8vokuR5UVFEoPDmcBc9lVHuidWU6DNHS
 qyhdravGf2+eJ+RK52B3rsYJojRZ87H7Xd+PKakKzfOJVsT7/fcop5Wl9wXLhHIFX/ik
 FMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454741; x=1763059541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qP4H6b8idNhc5NlCtQyib5SKH/dkiNYhjeyEL1D1w+k=;
 b=UyddnN8e+1KGMmWonkhCDgExwJzYxvEhnGb/VHC7MZ2QToyXDaZaYHKBL5h8TGgugi
 tWkTu7hwmLxF96l5NbXZQA3uIG7YCZq5qPbgiplh31sN7rnvnE0RE88ZC+uxe3G3C6LD
 aDQ9ZCTA2jItAQR1CHGv4gBTQSVQfWbhmBqyUZ05RLalCbOYgFB7UiDz6jyx7MtQjwoj
 PZKqJTytUuqgPBGR0bbm3XQnwiG6AFh1a28j3lN5aaGTZhm6PP6b8PQW7SeoXOxHsD6g
 NIEiuHrs9nYM0Rva8OmCZuBiQ61dq695He/+hK6XtupYyPLJGetng4sqPdpOJAiA2J3m
 zJyg==
X-Gm-Message-State: AOJu0Ywemoa4f9Q9oCM7L2+gncTzWzfQwkzBkCTgGA0BUTXs0nWCAZhZ
 XnuvI2pHAr7BlSBsQw8/M4vr2uSRD8TMGyLQSgz86KuHE5gLwQve2xzJFyE8Gj1a
X-Gm-Gg: ASbGncs/c5r+ztGrQIjXvnEl4jJ0w84P8zDAPwCnljWOPM3m3F8sLGZC6ofxhRQNPBQ
 sf66On/XMQ/ACFc9wOW2xkVbbKJ6zv3MKBShkJ9u/0Yd1GHtCxNjYRibPphQ5NC5jQZlda5n7kP
 6OuR05hLL6MqFFidX6jfEKn7xuo2zUbuZVO5yTcuAL2ZHsRDDjYv56WT44A1i0SrqTxswCtVKBh
 /Sdkjx4gEJPRwVcvzFXuTHgz0lijPAZ1vC6cKWyQYaapztU0i2i/58Odwu972ObCj6EJxiz/Pot
 zHZGyuf0NHJx372bvxcLxV2LVVZYTcOJNv/9kRjeVVQz6ZNUgYUMl7Uc22EBccWfYqDQit3a18Q
 c4s2Pf2l1zkXzSHNZZNN/Sh5TT5wM/X6Z9eure/ClipbtF4ipDar520kiqDi+hfibePuKOerixN
 J+HD+kujjMzevevmH7crc=
X-Google-Smtp-Source: AGHT+IHPEGWu2EalZarFpb0b6tcgy91EqTJkRX5js4Zxwaf5Tk5VESph3QBfBlTIRRBd/rj8fXFoYQ==
X-Received: by 2002:a05:6122:2a12:b0:556:3bd1:85aa with SMTP id
 71dfb90a1353d-559a3ac2387mr252561e0c.8.1762454741276; 
 Thu, 06 Nov 2025 10:45:41 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-559957fb3c1sm1810004e0c.12.2025.11.06.10.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:45:41 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 02/13] drm/amdgpu/gart: Add helper to bind VRAM pages (v2)
Date: Thu,  6 Nov 2025 19:44:37 +0100
Message-ID: <20251106184448.8099-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106184448.8099-1-timur.kristof@gmail.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
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


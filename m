Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC242C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 13:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE9B10E19E;
	Mon, 31 Jan 2022 13:52:53 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3274910E408
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 13:52:52 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id ah7so43168952ejc.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 05:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3v+wX7aNkIBRad4bYqjgoGQ0DI+ZPATqqloFXqpr1Io=;
 b=f53F1mu8FgZ6yqd3jInr42vtkkqF6UMRvYTJVxNgQpmpMkkoNaM6K+sN4lghmSQP1m
 4e6wimyxdFIbwvdLqIkHTusAU3n2Ca3VLU3Kq1EqA9o52ypLaqJl1C+6+7Ggd36s5tKO
 Rq5g2GRYU9iVxe2kHtk9S5sOCZQmcJvjrEbjWnRlW4Q++bPNjHcRs0CDweyhmSkKmvxQ
 VQbAf6PEcSzcykpNVEtuwdWk/SR8vDH/eRvMw3ZxbCvr7NPqzJHIVO4JRuDqLVT3Gx3Y
 Aycs9DVzPt2OAifJ3SuoPGkBGHUYFloffOCUAkPhQgH/H2Nkfh4TYFZtcy2kEdCucgQW
 ph6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3v+wX7aNkIBRad4bYqjgoGQ0DI+ZPATqqloFXqpr1Io=;
 b=ou+aewY2Qb2dQsvRcC9J4UAgGFOvKEsPJwcMn9KxC+2EN+hpVh5lqJnoXu3xRhTPLq
 TJN6ZsTX3bkA7kxa5oyamGtjx89LKDct/PzLqEqal4UgApJaqGfxvTIexB/YbR8RcpLM
 922LrLay5sKlf3nHdkZVJy/LYdlNpW3QwqwmiIViy+91FO6eXc0PqGAv1zD3FGSoaKWT
 T8iaVoDkvzDg/utYzgwYCHI9PC8lqaugh+gOfyNNCedjNWSOKA0qhXs5lsy+P9HmUN7e
 /xiXolinlCOFrHuGEyT8hOA02gP9hSV0f9/c5w8R8FSqwf+N5hHHIOKF7c4flDwd9C9e
 C4TQ==
X-Gm-Message-State: AOAM531mtGbnZUyD9/tTLuRthCXLO8WRYJLeUn1+pWQki4647qw8g+QB
 vpAjX3oJ3JxvO9lDot5kDWlIcdNvHmw=
X-Google-Smtp-Source: ABdhPJyMqcJFQ2eHPcLQ6/4yqB924kHlKp0llnwgNceZlys6JhQgG6nXg5spa6yIsIZ476NTNexRog==
X-Received: by 2002:a17:907:1b0f:: with SMTP id
 mp15mr17275898ejc.493.1643637170758; 
 Mon, 31 Jan 2022 05:52:50 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id co19sm17893557edb.7.2022.01.31.05.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jan 2022 05:52:50 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: harish.kasiviswanathan@amd.com, benjaminadam.price@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 3/4] drm/amdgpu: rework GART copy window handling
Date: Mon, 31 Jan 2022 14:52:45 +0100
Message-Id: <20220131135246.1521-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220131135246.1521-1-christian.koenig@amd.com>
References: <20220131135246.1521-1-christian.koenig@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of limiting the size before we call the mapping
function let the function itself limit the size.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 49 ++++++++++++-------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index bc10b3f9015a..26c521cd1092 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -175,10 +175,10 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
  * @bo: buffer object to map
  * @mem: memory object to map
  * @mm_cur: range to map
- * @num_pages: number of pages to map
  * @window: which GART window to use
  * @ring: DMA ring to use for the copy
  * @tmz: if we should setup a TMZ enabled mapping
+ * @size: in number of bytes to map, out number of bytes mapped
  * @addr: resulting address inside the MC address space
  *
  * Setup one of the GART windows to access a specific piece of memory or return
@@ -187,15 +187,14 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 				 struct ttm_resource *mem,
 				 struct amdgpu_res_cursor *mm_cur,
-				 unsigned num_pages, unsigned window,
-				 struct amdgpu_ring *ring, bool tmz,
-				 uint64_t *addr)
+				 unsigned window, struct amdgpu_ring *ring,
+				 bool tmz, uint64_t *size, uint64_t *addr)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_job *job;
-	unsigned num_dw, num_bytes;
-	struct dma_fence *fence;
+	unsigned offset, num_pages, num_dw, num_bytes;
 	uint64_t src_addr, dst_addr;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
 	void *cpu_addr;
 	uint64_t flags;
 	unsigned int i;
@@ -214,10 +213,22 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 		return 0;
 	}
 
+
+	/*
+	 * If start begins at an offset inside the page, then adjust the size
+	 * and addr accordingly
+	 */
+	offset = mm_cur->start & ~PAGE_MASK;
+
+	num_pages = PFN_UP(*size + offset);
+	num_pages = min_t(uint32_t, num_pages, AMDGPU_GTT_MAX_TRANSFER_SIZE);
+
+	*size = min(*size, (uint64_t)num_pages * PAGE_SIZE - offset);
+
 	*addr = adev->gmc.gart_start;
 	*addr += (u64)window * AMDGPU_GTT_MAX_TRANSFER_SIZE *
 		AMDGPU_GPU_PAGE_SIZE;
-	*addr += mm_cur->start & ~PAGE_MASK;
+	*addr += offset;
 
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
 	num_bytes = num_pages * 8 * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
@@ -298,9 +309,6 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 			       struct dma_resv *resv,
 			       struct dma_fence **f)
 {
-	const uint32_t GTT_MAX_BYTES = (AMDGPU_GTT_MAX_TRANSFER_SIZE *
-					AMDGPU_GPU_PAGE_SIZE);
-
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	struct amdgpu_res_cursor src_mm, dst_mm;
 	struct dma_fence *fence = NULL;
@@ -316,29 +324,20 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 
 	mutex_lock(&adev->mman.gtt_window_lock);
 	while (src_mm.remaining) {
-		uint32_t src_page_offset = src_mm.start & ~PAGE_MASK;
-		uint32_t dst_page_offset = dst_mm.start & ~PAGE_MASK;
+		uint64_t from, to, cur_size;
 		struct dma_fence *next;
-		uint32_t cur_size;
-		uint64_t from, to;
 
-		/* Copy size cannot exceed GTT_MAX_BYTES. So if src or dst
-		 * begins at an offset, then adjust the size accordingly
-		 */
-		cur_size = max(src_page_offset, dst_page_offset);
-		cur_size = min(min3(src_mm.size, dst_mm.size, size),
-			       (uint64_t)(GTT_MAX_BYTES - cur_size));
+		/* Never copy more than 256MiB at once to avoid a timeout */
+		cur_size = min3(src_mm.size, dst_mm.size, 256ULL << 20);
 
 		/* Map src to window 0 and dst to window 1. */
 		r = amdgpu_ttm_map_buffer(src->bo, src->mem, &src_mm,
-					  PFN_UP(cur_size + src_page_offset),
-					  0, ring, tmz, &from);
+					  0, ring, tmz, &cur_size, &from);
 		if (r)
 			goto error;
 
 		r = amdgpu_ttm_map_buffer(dst->bo, dst->mem, &dst_mm,
-					  PFN_UP(cur_size + dst_page_offset),
-					  1, ring, tmz, &to);
+					  1, ring, tmz, &cur_size, &to);
 		if (r)
 			goto error;
 
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC595CCD1BF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B11910E67E;
	Tue, 28 Oct 2025 22:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P/3XlpHQ";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CF810E67E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:42 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-63c0c9a408aso10585722a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689201; x=1762294001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jKTOpVQOxdvg7bEaoHloWZG5m3QGYtmC8Ais7CXrFgU=;
 b=P/3XlpHQZj2nd/eNp7m3ggF0phhwmu3/mS5vBOQdq5l+qlFKXBrKm4RbIeYc+w7/P4
 cnrauxumIhu4qjjbIk+6wYGw7N9cEuYmVAGNiiDFe0immumRvzhGhNCGi2q5tGh9dcWj
 V9bnUyb7fozkR+LKtSJoJA84MNc1lB8MIPNV6GKM5n+KvZ8dhGS5iTlniVhEuHMEGRh9
 9b6zQl/lrRCMEOyb4GP+CJuYPhzS7CJogljEmV7h0Ybzs8ZlsT9kFq4EYZ9ee0pP5WvY
 9kg4iIzvmTGLsU3jMg8D3LnqVJwMokSLXMuY9JRyQTGXU9Fdfd75/Ni710icgKzOgvg7
 Tg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689201; x=1762294001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKTOpVQOxdvg7bEaoHloWZG5m3QGYtmC8Ais7CXrFgU=;
 b=hJoV/SeDt8RdklMSSWgU3AGnT3ftbt6v/K34EbU84u9Ifsjw2JyWXLkX7Prvy38U7t
 fxOBlkiLvCwI5f6m9M6s8s9E6Zhh06CWR9LQdm2iW0WTFDdnbUvioqtdiW7YI5ikB0LG
 KlzeBd8kuuCjZIeiqP4zbSP62VZxWRb2fJaLq8INzQILhXxlnnH7X0RDmOU7HBcWdSHz
 4Xe4wRJpjIzjmRbsl9Y4MqG50JMLpEW2sDN573tZyEcuad8YYWBKFjkdqydeVU0+5mFV
 Rzcz/Pc2B2Quhy2SSwiDaZ67zUCYJZnhcmOOGHeho0p24OhGeD3SzcymNVaP9ifXELON
 BZ5A==
X-Gm-Message-State: AOJu0YzYfzkBa/t9QE937O/7QUYLWxYIdc0Srr5jxS3ac2cGIb53Fxb8
 4gxEu130ifDi/OeQFnnrU7GVpq6Qnd96xWyqDe0LWbTY2uCHiEtB9QD3HPFPJA==
X-Gm-Gg: ASbGncuS20eBpqLHpenmUBLzyDTi98ygOSnrLkiTd5q1ZZyhBicX7V42OsmqT5YKTav
 eeoxo40iFGFNTcK9mrCxqOAKashMqbigCUxt3Sd7QOQIPrqYmLRNT4RUVuvk0477WKGbc81+Oue
 J6SojozHRctD6Soq+j9wJfjxBwcTOrQ5HuoKwNHB2jwczkNuAT+Yy/Eqk79ANl50LLC2axWV1zS
 Yz4MzHVqIQueBZgwz4rWscFW6gO1L1M5pG4h0qor89utOt/ETXTR3aDIEkayOYMpZgb8AG43/4M
 Cm59THwaboc/moACtDsJlII9JbzZoQyNtKmCsOn6Cmem+db8bKt/lux9V6WsgRZ59rmmuNrjNUu
 ibABQAo1WY5i+JzA3VidZj0Jquax5fuTyMQL8H/kKh99BncytWYbF1ZEqbupBBMGswjt2tCiFGn
 05kqWXmaI1DQjh5CC501ZTgU8flf/N961NnwOvlsJp6tSN5uz01lUEfGdpOJXlZUTnn6v3N/xBv
 4RPQJAP
X-Google-Smtp-Source: AGHT+IGvUdstdBL1N35MmQHV81UEfCTM2v+xNpgKO60x0V3nTDLyTfE1iwzavzhgJ+ZfdnPI1Epskg==
X-Received: by 2002:a05:6402:50d0:b0:638:74dc:cf78 with SMTP id
 4fb4d7f45d1cf-64044380bd9mr576820a12.34.1761689200968; 
 Tue, 28 Oct 2025 15:06:40 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:40 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 04/14] drm/amdgpu/gart: Add helper to bind VRAM BO
Date: Tue, 28 Oct 2025 23:06:18 +0100
Message-ID: <20251028220628.8371-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028220628.8371-1-timur.kristof@gmail.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
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

Binds a BO that is allocated in VRAM to the GART page table.

Useful when a kernel BO is located in VRAM but
needs to be accessed from the GART address space,
for example to give a kernel BO a 32-bit address
when GART is placed in LOW address space.

Co-developed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 41 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 83f3b94ed975..19b5e72a6a26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -390,6 +390,47 @@ void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 	amdgpu_gart_map(adev, offset, pages, dma_addr, flags, adev->gart.ptr);
 }
 
+/**
+ * amdgpu_gart_bind - bind VRAM BO into the GART page table
+ *
+ * @adev: amdgpu_device pointer
+ * @offset: offset into the GPU's gart aperture
+ * @bo: the BO whose pages should be mapped
+ * @flags: page table entry flags
+ *
+ * Binds a BO that is allocated in VRAM to the GART page table
+ * (all ASICs).
+ * Useful when a kernel BO is located in VRAM but
+ * needs to be accessed from the GART address space,
+ * for example to give a kernel BO a 32-bit address
+ * when GART is placed in LOW address space.
+ */
+void amdgpu_gart_bind_vram_bo(struct amdgpu_device *adev, uint64_t offset,
+		     struct amdgpu_bo *bo, uint64_t flags)
+{
+	u64 pa, bo_size;
+	u32 num_pages, start_page, i, idx;
+
+	if (!adev->gart.ptr)
+		return;
+
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		return;
+
+	pa = amdgpu_gmc_vram_pa(adev, bo);
+	bo_size = amdgpu_bo_size(bo);
+	num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
+	start_page = offset / AMDGPU_GPU_PAGE_SIZE;
+
+	for (i = 0; i < num_pages; ++i) {
+		amdgpu_gmc_set_pte_pde(adev, adev->gart.ptr,
+			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
+	}
+
+	amdgpu_gart_invalidate_tlb(adev);
+	drm_dev_exit(idx);
+}
+
 /**
  * amdgpu_gart_invalidate_tlb - invalidate gart TLB
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
index 7cc980bf4725..756548d0b520 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -64,5 +64,7 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 		     void *dst);
 void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		      int pages, dma_addr_t *dma_addr, uint64_t flags);
+void amdgpu_gart_bind_vram_bo(struct amdgpu_device *adev, uint64_t offset,
+		     struct amdgpu_bo *bo, uint64_t flags);
 void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
 #endif
-- 
2.51.0


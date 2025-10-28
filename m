Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0175BCCF9F1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B256510E67D;
	Tue, 28 Oct 2025 22:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RYHwUx3u";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EDED10E67A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:39 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-63c0eb94ac3so11586487a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689198; x=1762293998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rygbqPSTkTaRF2YXh0oPW0/6GhhbiO7ShaOt1NDQFjs=;
 b=RYHwUx3uPPxTxVwgc9PXqnV5YHqGLP/gUHWA9erFm1PYMbtv7aokOnIT/TgoK94KZp
 0TGshm78VUWOi5qVPyCgmqEB4IvS/Ca2VNmmtB8/UgbIehGmGIbaq9CLOXive1bChucL
 cCzmKaDbt5jRWHpAtbKKDiYUIECm5zYRvqvdRk/YQyPG1ZRo+hTINrhKWB+Dm4POc2+b
 lI67QOhcuDUmdZuM1Dw9dEE6gAdUih+jUr7U0eOxwoSgOp51YJVNY1mSkxaPHDKFZjPA
 CROpLwrIRViktQcBjo14/tnPqFBr6m7cO0xyifU5Su5yQrVvrMLE5Yse35WqOi/YT55f
 fuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689198; x=1762293998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rygbqPSTkTaRF2YXh0oPW0/6GhhbiO7ShaOt1NDQFjs=;
 b=t2rtY0E6B7b0+IIE04IbY25Y/s4Run9d7XVrJn05mt4J445rxxX90be8IxyPWSvuMr
 eP/daBjNvv3NiAnAi07SkVwFJyNPjasU2IuQjS185l+JTWokl9QF8PlFpLKRQcXvjgQb
 vtfJ/pQeAWh9XYngkD5x1VGQgwLXDamRWlZdad7wyF4SGUor9pBkq09gLdWYafpDXRvI
 4XSxnwYlKw8c8vjb/HPUQhL4+RWk9snFu1+JOGkvcDy5nyMHYERAaarWDXmFgdLYvZWL
 ZSbCK7OC/s9ggKY7DL4ffXAh2Oe2rfiPoSTTyxBCQUeCmITxTFpDXuuyIHmKyFhVuafi
 +/GQ==
X-Gm-Message-State: AOJu0YykttTJ4PwlAVNstHOkdAP+JMJAYVleIFWN97CxRRK2hS5A12aU
 ouvviodaErR6ED7JvRWysEBvkOwhN9gEi2gzE2IbM8fRK8GCCHhiPyVcqxLZBA==
X-Gm-Gg: ASbGnctknnfHlhCXkmUu9nzgZOctiwWZUIwyT8ire5BZmvH0CLq/H8NA1b3xpBJrsyn
 KlKq3zxtbVIHX1oTSasREIm2icikBJecr9n9bXE1oOJfiIKaTtfqwVW7MPO19HEqrGAoXOX6LeQ
 kskfRxC63+LddJhTrv7P/vBhMZrCS52+elarMyBVjDkc6f33RXCGnUgCBQHY001nH9TJmCH7lbh
 ydGe+x6AgMhB/+WT3zYzJX3amOC7JKF09t03bkMpfB5kP4gt2yi3VFgvTJig6iwK36JlTgVRhYb
 xWa1OHu+TFORCAW7lo2SrPOzzl2552hmGbMNFf7IXAm62YiFlLWHP0XZ7M0ycNjtyMRuhPoZ3S/
 0WDSRt1FGdZpXc3/GGUtglp2TZGAF6DJQcZxsRXGPONHsFpfDwEnZB9WEWdKO3YG4xnxJELaoM/
 5lf4nFk75JK/oXoIsehd6jSrp4gfMDyiacmN7LV6gUMNZFDfIhJX22J5eKq64LEfu9ZqVWTI3n7
 /k2LKvZ
X-Google-Smtp-Source: AGHT+IFsoR0H+3hvpXXempgyLz6SNwF9ZZU9qdhMRcOX5K2Z25nHlkuJcGda05pb3Az1QW911UoCRg==
X-Received: by 2002:a05:6402:d0e:b0:639:ffb5:3606 with SMTP id
 4fb4d7f45d1cf-640443752c1mr426297a12.33.1761689197627; 
 Tue, 28 Oct 2025 15:06:37 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:37 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 01/14] drm/amdgpu/gmc: Don't hardcode GART page count before
 GTT
Date: Tue, 28 Oct 2025 23:06:15 +0100
Message-ID: <20251028220628.8371-2-timur.kristof@gmail.com>
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

GART contains some pages in its address space that come before
the GTT and are used for BO copies.

Instead of hardcoding the size of the GART space before GTT,
make it a field in the amdgpu_gmc struct. This allows us to map
more things in GART before GTT.

Split this into a separate patch to make it easier to bisect,
in case there are any errors in the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 97b562a79ea8..bf31bd022d6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -325,6 +325,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 		break;
 	}
 
+	mc->num_gart_pages_before_gtt =
+		AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
 	mc->gart_start &= ~(four_gb - 1);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
 	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 55097ca10738..568eed3eb557 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -266,6 +266,7 @@ struct amdgpu_gmc {
 	u64			fb_end;
 	unsigned		vram_width;
 	u64			real_vram_size;
+	u32			num_gart_pages_before_gtt;
 	int			vram_mtrr;
 	u64                     mc_mask;
 	const struct firmware   *fw;	/* MC firmware */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 0760e70402ec..4c2563a70c2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -283,7 +283,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
 
 	ttm_resource_manager_init(man, &adev->mman.bdev, gtt_size);
 
-	start = AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
+	start = adev->gmc.num_gart_pages_before_gtt;
 	size = (adev->gmc.gart_size >> PAGE_SHIFT) - start;
 	drm_mm_init(&mgr->mm, start, size);
 	spin_lock_init(&mgr->lock);
-- 
2.51.0


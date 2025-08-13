Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CB7CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 00:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399B410E662;
	Wed, 13 Aug 2025 00:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PQVoaDaV";
	dkim-atps=neutral
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80CC10E496
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 00:02:03 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-53987d78f0bso1584315e0c.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 17:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755043322; x=1755648122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKyW2YcLjR0GWTiX0RJcn7/DDKlgut6xH8dur/30r28=;
 b=PQVoaDaVtCeugmswIHuNUwRNdBA1izVBW5WQvop7pBxFsb5iSWYvkl9OT2QdN3ah1Q
 MY+x4MkL/6L70q4B2CzPa8wVB9ACTiuRj8RFls7mf4QLk4VU+NzT+6kvKAYk/b1qyxqG
 MiWMPBu0WYfE+PaWBhoP7Ckyu2nccIfZl10TuPxdY4vFu/8L6dcmxzxqMPsXMB4AFRwQ
 82KdVZX7VhZH+V5BUH1tlAaBW8jHjb0CbeX+c3MSyu7Lz0tmHFJAipW1fk1lm39BxlkP
 pVK/gjOls1XPX7d0kGuS+G3VcYpVPMhpf3ZbQskraMW43fB2EmbgWASJtFbxL8IOGqf7
 71+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755043322; x=1755648122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKyW2YcLjR0GWTiX0RJcn7/DDKlgut6xH8dur/30r28=;
 b=eZU4x4iY0tza1UjCdv2W5rxABoaeHQ1kdrnt8g/B5Wg7H4l/xjUbFoRRburNIFRfHK
 MJNg/K9f68aPselGt7z0dNxSXNnVPckv9UoH5EkxLtZa9MVN3KGTdE0i8YziA3oDNfpj
 cYdAvNNMywP68E+H8SzApWRpM6rRV6ZyceLDQ8rryidH1Ceu2NhfKWqFnVb9QV5+3kDY
 hLCDCxbQCVPT9o6Uk8bDoqVOsZL/vH2QDhnCrS23FEvMANu93sO90lXj+Rp3YvJlxGer
 ySiECKnuGmdlQnq/8BOl6FqWJ3Rhk7L76o+ji4Ii4BnmGu/b+uiDbymM4qOfTi5R0quN
 6ONw==
X-Gm-Message-State: AOJu0YwFAFm+yYWtGPnMhdEIDM2NlOmypFi6Pboox45hyrpVIdC2WqKX
 Ibw5bPBYmEBvOkJG/R2me1y81/uzYiasm1xeehzsmiS09RuR8c4c12KQOoP6YPw6
X-Gm-Gg: ASbGncskAVDflr3a3bQV8g6b8arzW9JI9QKcxmQMT2nNiOAIV3er13XCP9UF3tHYJMM
 whd0obcv1WNJKdLrD7oLAjD5RtanPf81VOlJacwq/BIsZVJyU2RfhfNeiXTTU3Iw7mgq6uL2cEG
 Zm0sbWhKz4fhTKwTsd/u5XCeymBZK3UtiMez9s8k0ZfkUO6gr6HxdsCGsEb9/9uJKKS17sw/2VF
 sDjRnKqu/IrtA81euOMomtYqZThrG1fX/OMoZbvD9QktubBfuOckTWnxTm9sulPeDeQwY0rDovJ
 4iiMwwDOXX970aLN7W+rzrwJhiFKzIitsPzSUj4Tk5rO9FdcQCE20Qa4fLQW5XDoDVPrVRy52qe
 nqEZanLHwMVgdDb30oODmy1zqXT9TO+lrCSqq7A==
X-Google-Smtp-Source: AGHT+IHj08O86zoRMFgAOi3C9bHGO01ESzSN0O0372hKmUarnJv9vvuoUkzyLmds/i3Gw0WJE1poAw==
X-Received: by 2002:a05:6122:1d86:b0:539:52d1:1f65 with SMTP id
 71dfb90a1353d-53b0b609075mr351348e0c.9.1755043322395; 
 Tue, 12 Aug 2025 17:02:02 -0700 (PDT)
Received: from Xander ([104.251.39.208]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ce3a099sm185937416d6.81.2025.08.12.17.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 17:02:01 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH 2/4] drm/radeon: rename ring to ring_idx in
 radeon_fence_driver_start_ring()
Date: Tue, 12 Aug 2025 20:01:39 -0400
Message-ID: <20250813000141.105508-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813000141.105508-1-alexandre.f.demers@gmail.com>
References: <20250813000141.105508-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

This is done to better distinguish ring indexes from rings themselves.
It will be useful in an upcoming patch to use the rings' name.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_fence.c | 38 +++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 8ff4f18b51a9..1be8364b2a97 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -798,50 +798,50 @@ void radeon_fence_note_sync(struct radeon_fence *fence, int dst_ring)
  * ready for use on the requested ring.
  *
  * @rdev: radeon device pointer
- * @ring: ring index to start the fence driver on
+ * @ring_idx: ring index to start the fence driver on
  *
  * Make the fence driver ready for processing (all asics).
  * Not all asics have all rings, so each asic will only
  * start the fence driver on the rings it has.
  * Returns 0 for success, errors for failure.
  */
-int radeon_fence_driver_start_ring(struct radeon_device *rdev, int ring)
+int radeon_fence_driver_start_ring(struct radeon_device *rdev, int ring_idx)
 {
 	uint64_t index;
 	int r;
-
-	radeon_scratch_free(rdev, rdev->fence_drv[ring].scratch_reg);
-	if (rdev->wb.use_event || !radeon_ring_supports_scratch_reg(rdev, &rdev->ring[ring])) {
-		rdev->fence_drv[ring].scratch_reg = 0;
-		if (ring != R600_RING_TYPE_UVD_INDEX) {
-			index = R600_WB_EVENT_OFFSET + ring * 4;
-			rdev->fence_drv[ring].cpu_addr = &rdev->wb.wb[index/4];
-			rdev->fence_drv[ring].gpu_addr = rdev->wb.gpu_addr +
+	radeon_scratch_free(rdev, rdev->fence_drv[ring_idx].scratch_reg);
+	if (rdev->wb.use_event || !radeon_ring_supports_scratch_reg(rdev, ring)) {
+		rdev->fence_drv[ring_idx].scratch_reg = 0;
+		if (ring_idx != R600_RING_TYPE_UVD_INDEX) {
+			index = R600_WB_EVENT_OFFSET + ring_idx * 4;
+			rdev->fence_drv[ring_idx].cpu_addr = &rdev->wb.wb[index/4];
+			rdev->fence_drv[ring_idx].gpu_addr = rdev->wb.gpu_addr +
 							 index;
 
 		} else {
 			/* put fence directly behind firmware */
 			index = ALIGN(rdev->uvd_fw->size, 8);
-			rdev->fence_drv[ring].cpu_addr = rdev->uvd.cpu_addr + index;
-			rdev->fence_drv[ring].gpu_addr = rdev->uvd.gpu_addr + index;
+			rdev->fence_drv[ring_idx].cpu_addr = rdev->uvd.cpu_addr + index;
+			rdev->fence_drv[ring_idx].gpu_addr = rdev->uvd.gpu_addr + index;
 		}
 
 	} else {
-		r = radeon_scratch_get(rdev, &rdev->fence_drv[ring].scratch_reg);
+		r = radeon_scratch_get(rdev, &rdev->fence_drv[ring_idx].scratch_reg);
 		if (r) {
 			dev_err(rdev->dev, "fence failed to get scratch register\n");
 			return r;
 		}
 		index = RADEON_WB_SCRATCH_OFFSET +
-			rdev->fence_drv[ring].scratch_reg -
+			rdev->fence_drv[ring_idx].scratch_reg -
 			rdev->scratch.reg_base;
-		rdev->fence_drv[ring].cpu_addr = &rdev->wb.wb[index/4];
-		rdev->fence_drv[ring].gpu_addr = rdev->wb.gpu_addr + index;
+		rdev->fence_drv[ring_idx].cpu_addr = &rdev->wb.wb[index/4];
+		rdev->fence_drv[ring_idx].gpu_addr = rdev->wb.gpu_addr + index;
 	}
-	radeon_fence_write(rdev, atomic64_read(&rdev->fence_drv[ring].last_seq), ring);
-	rdev->fence_drv[ring].initialized = true;
+	radeon_fence_write(rdev, atomic64_read(&rdev->fence_drv[ring_idx].last_seq), ring_idx);
+	rdev->fence_drv[ring_idx].initialized = true;
+
 	dev_info(rdev->dev, "fence driver on ring %d uses gpu addr 0x%016llx\n",
-		 ring, rdev->fence_drv[ring].gpu_addr);
+		 ring_idx, rdev->fence_drv[ring_idx].gpu_addr);
 	return 0;
 }
 
-- 
2.50.1


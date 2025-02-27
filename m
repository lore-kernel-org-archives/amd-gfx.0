Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B7FC19F32
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 05:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EDA10EA38;
	Thu, 27 Feb 2025 05:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fd4Yt1/s";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9AED10E1CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 05:06:15 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-6dd1962a75bso4775036d6.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 21:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740632774; x=1741237574; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E6NWwRzxwXTQXzOrIh7dG1VtiJQWUD4FDfWrI47c4oI=;
 b=Fd4Yt1/sMMmo5qPAsVu0TugEu7hwjcTah71Gv+FP7JgsX8eccCznSE+l4ZFL/vAEmb
 WuiVznvY58u5ykN467eK8cQFqzSzJeaTUkmDuDqNjtNnU1tNKR9EMIAJegazGNm00Eps
 Z8rTZr3gqVZbNE2ENf2nZv9z6OxudYxPt9LPqnn4iaQYrReQ3UKtPAlNvL81rf1l/cSV
 X8K88sfVFTSql4ueWU/4A5l+0R/drW+CMpmgrWTghpWsauAhyuhFailkisUOX42MC3vS
 K8tFP4dg5FNXj0gQxc8pncC6Ao4QNkQHlNb7wjlEwE6OSeaLeDzppvWO6PCy8UWv6V8r
 2w/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740632774; x=1741237574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6NWwRzxwXTQXzOrIh7dG1VtiJQWUD4FDfWrI47c4oI=;
 b=ADAZsUVQqUB7AdmDNGXRgmNe2VSrC1scfTCHxCOQ4YCNAoBAAqo/TYTvDvVQ/fW9cN
 3bEvpL7vka70HP3ibG6uhAAmzrZ6NnvT6AQ8GV58qK4FIYQ7cFf2sCLUgy48hjPkWgNt
 bZ8FnTZ2lxc56B5NZkL77WjkQYfh+s7RoxMGShgXW4ysnCXs5jDcmylsQeT4wpGmCUPq
 X+5hkleLvgl3e0d8qvmVnBF4tddWGHG+h1TpBiTz6b+jBbdog/YOhPEKc29Ci0XlUe8i
 K8CP8OHB1LnflgmTpH3Qk35Yg5rBXuFPt7a+B4QSw4ZbkGkt7Parj8xottez0zrz7ACj
 NzQg==
X-Gm-Message-State: AOJu0YwvuNP5gwdRCgJlES4hNBHjb/jOdLTaBs/LDQa2Z6cEO6xKi+ql
 ZeBNmmowvA8MNW1DdURp4krIrsoB5kNhZxhW24h1Y+VIfXT8XbYhYPo3hg==
X-Gm-Gg: ASbGncuG5+DvsCQifLUnnzaEhxRT9yguFnsJ/k7DkWVTQLACH3dMCAd2eht5+wR8qfw
 sSwoj162s56oP2177FwyfUcS0VGuB52tmV+kMAi28sMCLRzGsZLCuIbv9eiCAXodYWxA2B0jzGM
 E8Fsy6UboCn3stMBD13X96IkEDfvedblYALkutCqantdC38+R6PGckKrnvfU2IIolOzb0FLJBrM
 rsirSs/nHR+xewePGGhpl7tcHbyhoeeUcDcszCS/AQoTmueTDVJ96rPcqE7OOMKhZry0Evld2Mc
 kefn2yCwSTqPbKWa4Yryea++enN4bVM13GJITh3tHNZzbk/v
X-Google-Smtp-Source: AGHT+IE1aGlqZF5kznWQ//bJvu0zaU+T+oPOrKjegZOsZ3WSF0Olmsu9zjKg//ktfLwJGY9kvMupfQ==
X-Received: by 2002:a05:6214:b67:b0:6e8:9378:94cf with SMTP id
 6a1803df08f44-6e8937897bcmr49280786d6.21.1740632774437; 
 Wed, 26 Feb 2025 21:06:14 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976cca63sm6066906d6.89.2025.02.26.21.06.13
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 21:06:14 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/radeon: fix typos
Date: Thu, 27 Feb 2025 00:05:05 -0500
Message-ID: <20250227050506.167299-2-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227050506.167299-1-alexandre.f.demers@gmail.com>
References: <20250227050506.167299-1-alexandre.f.demers@gmail.com>
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

Found some typos while exploring radeon code.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_device.c | 6 +++---
 drivers/gpu/drm/radeon/radeon_fence.c  | 2 +-
 drivers/gpu/drm/radeon/si.c            | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 6f071e61f764..40b49bd4a10b 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -530,7 +530,7 @@ int radeon_wb_init(struct radeon_device *rdev)
  * @mc: memory controller structure holding memory informations
  * @base: base address at which to put VRAM
  *
- * Function will place try to place VRAM at base address provided
+ * Function will try to place VRAM at base address provided
  * as parameter (which is so far either PCI aperture address or
  * for IGP TOM base address).
  *
@@ -557,7 +557,7 @@ int radeon_wb_init(struct radeon_device *rdev)
  *
  * Note 3: when limiting vram it's safe to overwritte real_vram_size because
  * we are not in case where real_vram_size is inferior to mc_vram_size (ie
- * note afected by bogus hw of Novell bug 204882 + along with lots of ubuntu
+ * note affected by bogus hw of Novell bug 204882 + along with lots of ubuntu
  * ones)
  *
  * Note 4: IGP TOM addr should be the same as the aperture addr, we don't
@@ -594,7 +594,7 @@ void radeon_vram_location(struct radeon_device *rdev, struct radeon_mc *mc, u64
  * @rdev: radeon device structure holding all necessary informations
  * @mc: memory controller structure holding memory informations
  *
- * Function will place try to place GTT before or after VRAM.
+ * Function will try to place GTT before or after VRAM.
  *
  * If GTT size is bigger than space left then we ajust GTT size.
  * Thus function will never fails.
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index daff61586be5..8ff4f18b51a9 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -840,7 +840,7 @@ int radeon_fence_driver_start_ring(struct radeon_device *rdev, int ring)
 	}
 	radeon_fence_write(rdev, atomic64_read(&rdev->fence_drv[ring].last_seq), ring);
 	rdev->fence_drv[ring].initialized = true;
-	dev_info(rdev->dev, "fence driver on ring %d use gpu addr 0x%016llx\n",
+	dev_info(rdev->dev, "fence driver on ring %d uses gpu addr 0x%016llx\n",
 		 ring, rdev->fence_drv[ring].gpu_addr);
 	return 0;
 }
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 6c95575ce109..789f3b2fdf5c 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -6198,7 +6198,7 @@ static inline u32 si_get_ih_wptr(struct radeon_device *rdev)
 
 	if (wptr & RB_OVERFLOW) {
 		wptr &= ~RB_OVERFLOW;
-		/* When a ring buffer overflow happen start parsing interrupt
+		/* When a ring buffer overflow happens, start parsing interrupt
 		 * from the last not overwritten vector (wptr + 16). Hopefully
 		 * this should allow us to catchup.
 		 */
-- 
2.48.1


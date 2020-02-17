Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBBC34021
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 15:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C954214D8
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 15:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUbMGhlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C954214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D0A36E982;
	Mon, 17 Feb 2020 15:02:23 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3756E983;
 Mon, 17 Feb 2020 15:02:22 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a6so18832243wme.2;
 Mon, 17 Feb 2020 07:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1BQ3RLCCPj8Vx5ymm6Uw4hsRHsW/TZRnV/QBxLYgzPE=;
 b=iUbMGhlgJv1IOLSm6/QsHrMW7bkandIDoxFtpRy/WEEyLaHdmT3M3xUw8i4SWuQnrY
 JUG6bpqApYRHtvxOICJCd9Y2n8jZfExQtGlzVoK4VhCcBQ0y6acPuVgZCx0Yi0u69qnh
 MEFM5cBTJEBC0ozzTG97/Kg/hfFFiGqw2Bu4jv3YIRLFrXQVg4xBTv6d9yyTbSaNifq+
 fu5mKz3tjlTe62p4BvW9xvE0SpfSnI1bwjJBBdpn4xtacy4ka+3+sEgD0Jgs6yif7IBR
 a9JE5Sk1yhn/E15WlTmpy1QFQZPmuwl6ZT5HtDzdCQg+b8lda70j8SileutIlXbnbP+z
 smlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1BQ3RLCCPj8Vx5ymm6Uw4hsRHsW/TZRnV/QBxLYgzPE=;
 b=s+V2KtkVKIzD8oSdX1KVzY2/88PbFvyEoRLp3RyzcELbHfbo4xFeqH/MInCejYk2xQ
 3B909wN+6LleiyLVmGh0CxLL+aSWg3Gx0pOV6467hU1eDEptzv3dhq2qbD0P0j8K0tx5
 VSJCOh/qtj4BnWvYjQRipmAjYkuWXsb3EGDforTflp4INNihFVpyZvpxuBrbg9yRpfF0
 h11XbBoNBrd9wMq18PAzJ/ttxB7zhpsKrviZfkATux0XoOq9J+JLyIu2b4gBC9Kgj83o
 s+FfYPdGtoB/4Id+6e1V3/5qPN/WwjRVcQ5yk1BRdhogFU2sevuRyL4HeCpPBPplvv1I
 GuCQ==
X-Gm-Message-State: APjAAAXOOxI+TOccV7cKwItG/49GvLjckuZ6VpTqJVzuoYue6YQ6t3fA
 odJ2aH5USh/byzuM4fVM5IxBKcltDHx0NQ==
X-Google-Smtp-Source: APXvYqxFWTGBWRqqBOAQ5NBWojO4UubxrjFaGScPFg4f981ceKbmsPL10iGhz2lGJPY3p22DAl2vcA==
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr22837777wml.55.1581951739182; 
 Mon, 17 Feb 2020 07:02:19 -0800 (PST)
Received: from brihaspati.fritz.box (pD9566D64.dip0.t-ipconnect.de.
 [217.86.109.100])
 by smtp.gmail.com with ESMTPSA id j15sm1441099wrp.9.2020.02.17.07.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 07:02:18 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 8/8] drm/ttm: do not keep GPU dependent addresses
Date: Mon, 17 Feb 2020 16:04:27 +0100
Message-Id: <20200217150427.49994-9-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217150427.49994-1-nirmoy.das@amd.com>
References: <20200217150427.49994-1-nirmoy.das@amd.com>
MIME-Version: 1.0
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, airlied@linux.ie,
 kenny.ho@amd.com, brian.welty@intel.com, maarten.lankhorst@linux.intel.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sean@poorly.run, christian.koenig@amd.com,
 kraxel@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GPU address handling is device specific and should be handle by its device
driver.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c    | 7 -------
 include/drm/ttm/ttm_bo_api.h    | 2 --
 include/drm/ttm/ttm_bo_driver.h | 1 -
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 151edfd8de77..d5885cd609a3 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -85,7 +85,6 @@ static void ttm_mem_type_debug(struct ttm_bo_device *bdev, struct drm_printer *p
 	drm_printf(p, "    has_type: %d\n", man->has_type);
 	drm_printf(p, "    use_type: %d\n", man->use_type);
 	drm_printf(p, "    flags: 0x%08X\n", man->flags);
-	drm_printf(p, "    gpu_offset: 0x%08llX\n", man->gpu_offset);
 	drm_printf(p, "    size: %llu\n", man->size);
 	drm_printf(p, "    available_caching: 0x%08X\n", man->available_caching);
 	drm_printf(p, "    default_caching: 0x%08X\n", man->default_caching);
@@ -345,12 +344,6 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 moved:
 	bo->evicted = false;
 
-	if (bo->mem.mm_node)
-		bo->offset = (bo->mem.start << PAGE_SHIFT) +
-		    bdev->man[bo->mem.mem_type].gpu_offset;
-	else
-		bo->offset = 0;
-
 	ctx->bytes_moved += bo->num_pages << PAGE_SHIFT;
 	return 0;
 
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index b9bc1b00142e..d6f39ee5bf5d 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -213,8 +213,6 @@ struct ttm_buffer_object {
 	 * either of these locks held.
 	 */
 
-	uint64_t offset; /* GPU address space is independent of CPU word size */
-
 	struct sg_table *sg;
 };
 
diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index c9e0fd09f4b2..c8ce6c181abe 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -177,7 +177,6 @@ struct ttm_mem_type_manager {
 	bool has_type;
 	bool use_type;
 	uint32_t flags;
-	uint64_t gpu_offset; /* GPU address space is independent of CPU word size */
 	uint64_t size;
 	uint32_t available_caching;
 	uint32_t default_caching;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

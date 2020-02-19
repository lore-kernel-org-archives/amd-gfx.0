Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C72C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 13:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB9420801
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 13:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6PePbxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB9420801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE85E6EBF9;
	Wed, 19 Feb 2020 13:50:57 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995906EBF9;
 Wed, 19 Feb 2020 13:50:56 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id c9so606291wrw.8;
 Wed, 19 Feb 2020 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1BQ3RLCCPj8Vx5ymm6Uw4hsRHsW/TZRnV/QBxLYgzPE=;
 b=K6PePbxrFjWbY03tih5qY6w88t4RI3CnQQWh6Bpio3HdR0POP9J1PZwyjxERD+zJYR
 hA6Sh9ajIlAQpUpY1raNQDzxFaGKgPMol5Hd7FfSynBF9D1VR0hYvCaXqyj6+Co83FUG
 GK+GLQE0ywdD7xOvU/hNI2rFI6N6MR6ymHHtJsPnRibK0NKrZSzerUHihyXpnpPKTIwf
 GeBx6uWr71leEaZ0336KWakBAfABTSnAhtebLX9oOu4hbkxYdBvsdQLV0CJNT2wIYIhp
 bHLp2qNqKghZLZ5dEhGUO+jJ9ZMF6ax55UAuknqZUi3zbn33yAVy4+MwiAz4U0XmP/qP
 DEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1BQ3RLCCPj8Vx5ymm6Uw4hsRHsW/TZRnV/QBxLYgzPE=;
 b=dawViytkcb18ZE5LG6pxWeipdeRicZw1xBBZTZaGApNEWQduldtVIrLTNHke0pZazD
 +lP1IaumNSPuPJ94LS1uF1SwHJFKdEPZi4z1dKnw3XzNAsuaDgA45FoTQbY00bI4kbiv
 UKW+Uu7ilo+7kgCMJdSe3agQ9heWyGg08zel/EouJzLFjKWK67bMOCUbb1rnn6SpFKTI
 P2zI5w0KhXJqIHZewj7xJFrdsVxZ1JkBnpCgbwf2Wq4xbScVJ0fphm3ERhkldqVXNKzb
 vzIfSCK3JGOTBjeqH+T0TBBEuc1JIvITVG53uTYokug3ZaeprPgHI1RwMnKta8k0+9gP
 0g2Q==
X-Gm-Message-State: APjAAAXiKajpckRbIFDByyV15mGbRQxmd3JBNK/VVRI4WqV3KrILjvc0
 PwcuIgEhD3V5sJAWTkHkX+ye9UdAgpTX4g==
X-Google-Smtp-Source: APXvYqwrxRMqCWIUMRToOvWkusgU3QGsOnPV/TQM3PpZjWapGBRqrbuZrAhmeWchZZTsO0FLN3aAhw==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr35535578wrr.418.1582120254836; 
 Wed, 19 Feb 2020 05:50:54 -0800 (PST)
Received: from brihaspati.fritz.box (p5DE53754.dip0.t-ipconnect.de.
 [93.229.55.84])
 by smtp.gmail.com with ESMTPSA id y1sm3061881wrq.16.2020.02.19.05.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 05:50:54 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 8/8] drm/ttm: do not keep GPU dependent addresses
Date: Wed, 19 Feb 2020 14:53:22 +0100
Message-Id: <20200219135322.56463-9-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219135322.56463-1-nirmoy.das@amd.com>
References: <20200219135322.56463-1-nirmoy.das@amd.com>
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

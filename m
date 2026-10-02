Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CB7CA5FE2
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 12:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E05410F835;
	Fri,  2 Oct 2026 12:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PchpSqVh";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B0C10E3B3
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 02:18:02 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49c5a927a1fso3518935e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2026 19:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790907481; x=1791512281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K3VaIb3BtBdftLmeTIXBSMEw6OrRCg+sJcH/2TWbb2M=;
 b=PchpSqVhMDNMvnT2jyoCBoKAcihCJzRbwLyxMBBA8uRGM5eFH6AsawRfcdVAkA09ww
 CVG6FmvdSBRon0a9OoTwPophn9lATJWy3TL8wH121A9GbxZT4MGZ4NK2hozDn9pvQdi3
 Y2HqRCfOUTt7wiYB0MGuFXFcA4gDs45YXxf0W8pe+sKacq67TJIV9uPRyqhCYTHqwOzb
 NNU0rEGR7wHSKY9QBKBiskrn3WzJzqmMKdPNCbiHPxnUdhWKMojU346kpBKX96KWgCVk
 ja93wZCMeoE0QIRqbmGcT2uQNfKj1e2h9jbLcM7OXVY9kl1rnigi1bARd25txb8KjrCI
 8ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790907481; x=1791512281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K3VaIb3BtBdftLmeTIXBSMEw6OrRCg+sJcH/2TWbb2M=;
 b=n9VeDb/pYmiQ4fJDwbK4pQ7fOIgbl9MfjFNFurj28uzYt4VlZtISOPMe+O+an5cmCP
 YCPhCw8jrFXAdfrCBRXaM+Q53tdQN4muBg7iagh43oA8oZqnqS4Gu2gt+ECcBN0Afgj1
 3QlkZY9vG4D+JaPWnxo25LY0sRQIABQyvzji5Y4S4w7zHZ9GCUKtIspRawnOmWT/5+cl
 y/Q0p6wotA51K/DOdeeO5L5COU3bf+jG3QB+UBXOlHoQGwTUQfDtv4iPhDJOfX1XdyYQ
 eS0dcWhFG/wx3d0onKPNywV19whLf/I0fsML6WprHuLDI6x8OyzHhtPsrdCJvI4d/TQK
 bfsA==
X-Gm-Message-State: AFq9FYJb5HYXv7FtyDZBk/P1As7XuTMMCvbplQZxowjk1kRGKTAtrx5b
 P1GX45LXjxiIj543s8t+1GyYifSbhRLXw+xAqnDFvLK+F1jpe930r8fzIxJYebtefUWmlA==
X-Gm-Gg: AYBFou2C5A5pcP4Nj5rJR0glotq5Wk9BOpsOeZbrEqWZSbKHPzFJumqmjCjujcOp+iw
 UAFW7PX8KnDzDnVAMrTkOo+cqwy/qBeY+kj59YKwSYbxIFKYH5LFUXVBkpY58wpRU4ZcilYjpp3
 NyHxDG45pM9oYTX9e7fRtI9ZEEm1F0N9SqK7A5YMUQUWUvyzDIiJDqkGozJzPHObFiW1RMDjTaX
 mRf7WTy6ubV1f2K/u/h48sLEARJpIeDtYvRSHImrqvzrOMApUTtonbz2QUEAk7jk9PvUiGwyRlr
 7LEAU17Faf1DWa378MxAz73ZnHCzTSPP8DdUhuuNYny/dpxQ064veQ0qcPOeFWo1SagPuCfZFBM
 EWWqlMxdE9pskd/l21hGjqz89oR1y3UzdSs72GY33UIdjInrGnSikN3y8sVpnXkYhGwmpX63XXs
 t6NSJM3irMzGoOkhAY5c3iGa46Qz3T8glYXhrKrpUXTMEI1UyvDPBtG5Vfytlo896wuoWWHrLq/
 FYpJ1YnsOfLKC5W/kv3jw==
X-Received: by 2002:a05:6000:2007:b0:48a:f4c1:4301 with SMTP id
 ffacd0b85a97d-48b127206d0mr2096245f8f.6.1790907480475; 
 Thu, 01 Oct 2026 19:18:00 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.71.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b82253e6bsm1605411f8f.6.2026.10.01.19.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 19:18:00 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, emmaonana18@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] drm/amd/display: fix kernel-doc warnings for cgs register
 typedefs
Date: Fri,  2 Oct 2026 03:17:50 +0100
Message-ID: <20261002021750.13596-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:52:19 +0000
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

kernel-doc reports prototype mismatches for the cgs register accessor
typedefs, whose comments do not use the documented typedef format, e.g.:

  drivers/gpu/drm/amd/include/cgs_common.h:89 ... expecting prototype
  for cgs_read_register(). Prototype was for uint32_t() instead

Use the typedef comment format for all four accessors (also restoring
the dropped _t suffix) and replace the wrong @offset with the real
@space/@index params in the two indirect-register comments.

Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 drivers/gpu/drm/amd/include/cgs_common.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/cgs_common.h b/drivers/gpu/drm/amd/include/cgs_common.h
index f40b6a03fe63..3a25c3c75a3a 100644
--- a/drivers/gpu/drm/amd/include/cgs_common.h
+++ b/drivers/gpu/drm/amd/include/cgs_common.h
@@ -81,7 +81,7 @@ struct cgs_firmware_info {
 typedef unsigned long cgs_handle_t;
 
 /**
- * cgs_read_register() - Read an MMIO register
+ * typedef cgs_read_register_t - Read an MMIO register
  * @cgs_device:	opaque device handle
  * @offset:	register offset
  *
@@ -90,7 +90,7 @@ typedef unsigned long cgs_handle_t;
 typedef uint32_t (*cgs_read_register_t)(struct cgs_device *cgs_device, unsigned offset);
 
 /**
- * cgs_write_register() - Write an MMIO register
+ * typedef cgs_write_register_t - Write an MMIO register
  * @cgs_device:	opaque device handle
  * @offset:	register offset
  * @value:	register value
@@ -99,9 +99,10 @@ typedef void (*cgs_write_register_t)(struct cgs_device *cgs_device, unsigned off
 				     uint32_t value);
 
 /**
- * cgs_read_ind_register() - Read an indirect register
+ * typedef cgs_read_ind_register_t - Read an indirect register
  * @cgs_device:	opaque device handle
- * @offset:	register offset
+ * @space:	indirect register space
+ * @index:	register index
  *
  * Return:  register value
  */
@@ -109,9 +110,10 @@ typedef uint32_t (*cgs_read_ind_register_t)(struct cgs_device *cgs_device, enum
 					    unsigned index);
 
 /**
- * cgs_write_ind_register() - Write an indirect register
+ * typedef cgs_write_ind_register_t - Write an indirect register
  * @cgs_device:	opaque device handle
- * @offset:	register offset
+ * @space:	indirect register space
+ * @index:	register index
  * @value:	register value
  */
 typedef void (*cgs_write_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
-- 
2.43.0


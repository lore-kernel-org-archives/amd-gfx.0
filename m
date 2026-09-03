Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDA4C624DB
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7880310F5F1;
	Thu,  3 Sep 2026 13:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ogGsxa/+";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1B410F60D
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 13:44:18 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so2364077f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788443057; x=1789047857; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8EdCrSCj77M32Pu3SEBs0Nl7Jw7mm9Bq+OEkpl3c1Aw=;
 b=ogGsxa/+tyxPYrJKDu1RbrMSVZtr5w7pHsOf3kCbqcPVSU9mh1AHjaqqTBFslTJJWr
 TgiYVJUshKSlf4UTJS8XT9MQRzvf2Xr2xXpMuLYiIgZCMiUGgjhU8fkU2spzhdXh7sOp
 LRPfw9DG/EwXnhs42h5iO1//fh9I1RrT4kz+Bus9ADcAnOlMNb4bAQinXirugjgyub5V
 CTrcfkyTTflMMVV4n5EJofWFbkxoVS3UJklS6hPCryEL2JnzAoMeirpBOYbblk891kaA
 YToWoiAbq/xMaJp70j9cxKQooMds+/iMPf18Sf4JtkZ+irNW3o4Y0bjSFU8uaQ77qjCy
 7JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443057; x=1789047857;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8EdCrSCj77M32Pu3SEBs0Nl7Jw7mm9Bq+OEkpl3c1Aw=;
 b=OL0ygEaRQcT/lOFoE4ZQEwwj5akYYTZOTqbh/j4jGnhjFXyQ1MqfLzSaOz9Mu/jxA+
 D8g8uQjlkjGKIGpcwtkQz1q7qOKQuDKoBneQGTFjukeaL0JqevaVtweX/nm8D7PGCgVm
 8m/QaVeBuTaWwZ6XOUWAeSl39ORntxJDevPUB10FAkv7xWAVERSK2pVKLWAHFjptt3aA
 RCsIxIvA6OzN3w04odP887GGX3KvfmmUqzBM+c7yYoTTed9wS/BH8XssjlTwaDyknXzX
 gvb1hBEhXZzKjQwarrTLuaZhOrbpjEa2BFHgzuuiFlF53at78H7GghruRrsi2pBmwOIY
 Y9Hg==
X-Forwarded-Encrypted: i=1;
 AKwUvByfBYSe6kKLErwU5jvExzxxGFxB1bmXExgkKd1TpYVKAxLYKBhjuJU84oT4YtdgxSMfuwUM9pxm@lists.freedesktop.org
X-Gm-Message-State: AFuF++k2P+MIR4b4N0ENVVfaEbf/s+d/+xfMWaqkFOokoK18dNdsuXVr
 DQgPiEA2mmhYTEv7cMOhY1Kv3irBHIgV/L2Y4oA3P8bMr0psBggnOYNL
X-Gm-Gg: AYBFou036iEx7IJFntz4bFQuZvd+rm6gbtJL73s+nM+Pe9znC8E7BKviDm75KdFLZ1s
 wew+ILHuueTQzLQCXLY8l+6kPqDnsKsh6TtFvN1LuWYhNqJ/gbnoGASMj4tIhjIQt3XJN68F9hW
 r+tW0JTc4qQ1jD9Df5Km34W4mn8GLTAdUMEz5zZTorgWT03V3pWo2Mou2zOsFmLmQHfxPa286I1
 8iNvLMbL28hbp2YOwVFvenTlEw9ppr+qgRvP3UUjPKnuwcoWrVTLDe157oBxb/AEbS02oiiFQJ1
 qEtgnUrVaRneLhe7il9RAKIRXxl6Suf4zkzsiyweiWxgrCYdU0C+URMK0iRnZLXoJqNdU2VAYlM
 86Qn56Lc7ubZIhWJEqyFbY91BkW1TgSw0UADMKL0rwvMJarGwrJv9wYo9cfM935/ijg6fa5i0pg
 zSgbS6eoUGPbLjCVt3CgsGaH8ohprc9+F3ugnUT0AJpO1dNzbwZ2PeZ/fi8dkoNZ4NR7m6h9iRh
 A==
X-Received: by 2002:a5d:6f12:0:b0:485:81fd:734c with SMTP id
 ffacd0b85a97d-485860fa3afmr542807f8f.24.1788443056987; 
 Thu, 03 Sep 2026 06:44:16 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm13597080f8f.5.2026.09.03.06.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:16 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/11] drm/mode_config: Use dma_resv_alloc for lockdep
 annotation
Date: Thu,  3 Sep 2026 15:28:01 +0200
Message-ID: <20260903134408.105317-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903134408.105317-1-christian.koenig@amd.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace the stack-allocated dma_resv in the lockdep annotation code
with a dynamically allocated one using dma_resv_alloc(). This aligns
with the move away from embedded dma_resv structures and towards
reference-counted dynamic allocation.

The lockdep annotation block in drmm_mode_config_init() is used to
establish lock ordering dependencies between modeset locks and dma_resv
locks. Since this only runs when CONFIG_LOCKDEP is enabled and the resv
is immediately freed after use, the change is straightforward.

If allocation fails, return -ENOMEM early. The existing dma_resv_put()
at the end of the block properly handles the cleanup.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/gpu/drm/drm_mode_config.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 312d5e9675f0..de424b755c62 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -658,10 +658,12 @@ int drmm_mode_config_init(struct drm_device *dev)
 	if (IS_ENABLED(CONFIG_LOCKDEP)) {
 		struct drm_modeset_acquire_ctx modeset_ctx;
 		struct ww_acquire_ctx resv_ctx;
-		struct dma_resv resv;
+		struct dma_resv *resv;
 		int ret;
 
-		dma_resv_init(&resv);
+		resv = dma_resv_alloc();
+		if (!resv)
+			return -ENOMEM;
 
 		drm_modeset_acquire_init(&modeset_ctx, 0);
 		ret = drm_modeset_lock(&dev->mode_config.connection_mutex,
@@ -672,16 +674,16 @@ int drmm_mode_config_init(struct drm_device *dev)
 		might_fault();
 
 		ww_acquire_init(&resv_ctx, &reservation_ww_class);
-		ret = dma_resv_lock(&resv, &resv_ctx);
+		ret = dma_resv_lock(resv, &resv_ctx);
 		if (ret == -EDEADLK)
-			dma_resv_lock_slow(&resv, &resv_ctx);
+			dma_resv_lock_slow(resv, &resv_ctx);
 
-		dma_resv_unlock(&resv);
+		dma_resv_unlock(resv);
 		ww_acquire_fini(&resv_ctx);
 
 		drm_modeset_drop_locks(&modeset_ctx);
 		drm_modeset_acquire_fini(&modeset_ctx);
-		dma_resv_put(&resv);
+		dma_resv_put(resv);
 	}
 
 	return drmm_add_action_or_reset(dev, drm_mode_config_init_release,
-- 
2.43.0


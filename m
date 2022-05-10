Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BEDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 11:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E280910F81D;
	Tue, 10 May 2022 11:36:53 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54E9210F4B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 11:36:53 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 k126-20020a1ca184000000b003943fd07180so1224503wme.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UQTzOQRhD1qMG/OTgJSdb7Z7eAAhFUrisEScQxgrLEE=;
 b=FJKrnNC+Dcs7gQSyOlUeL/cBB5QoftOdvuhQl+8R2IPY28xwm3I6lvwDb0HsdWM+YD
 5Smub6M+TAO0E6k3rrmrZpNoSAQ39kbDrpIXQJ0jHXxhWMa1JXNsZ/gdde+Unk02Vuz4
 +WzuQmbp2VyOCt70QMxidIw6t/DlkYrRqfZK0xb7WLn97bwFaRXut2wzdzQy6mscoJ5S
 LcPolQAwY59yWbN48Jg2xbL+Srn+CWFddEH+hP4VFUbonaOL5S0jlBfuEg3W3Qpi0l3x
 fypgiF32ulgXQla9rWlU9BF9k1Pvdwe8D8FUZzTV40eN+qrMJAlDyPev/pFt9i9PoNCN
 GUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UQTzOQRhD1qMG/OTgJSdb7Z7eAAhFUrisEScQxgrLEE=;
 b=BDAqpbToCsX0bcSoZON5AwJ6ZaI7OvjrCMG9wy+JREkVSfsvPdLjhZZa7XOo91J28Y
 Hn+D25UjXgi1vw7mvOSYtDOEB5SrACjSARK4PST9nb+45bYXf9kJy1riOlJzMGM9y1XH
 cP1bQIndiQ98cCcCjIgha1T8Wz54fVg+SeL3ZfLVj+ZRd2F1APXXob7yvNCUaSgdfEJi
 yZssBCOp6sGWOFP3oMFJcc21IJY1CBibZx+YTdvpha6LbOu0hIDcRNmsdfgTat2T36+u
 zvM4hqadStDaDIlnSwctabvQqsmyblM0aQ0OIyEa+PexoPuugkAlhABgTKdL4zVgtNU2
 X1/A==
X-Gm-Message-State: AOAM533qsHtmLG6ZKexXrk0VfqSSsKGB8hNUZrfDvFiHLTLPRvTJmi3s
 WzbS5Od5EXRK7UDiKS1rSNg=
X-Google-Smtp-Source: ABdhPJx8kCaJDpwReRM4gooSYfoXidsrW35jfQWzwuc8IjtpObYtfft3+q6JrE+/X3R9Z6OM3aN/fQ==
X-Received: by 2002:a7b:c5d6:0:b0:381:4127:84d3 with SMTP id
 n22-20020a7bc5d6000000b00381412784d3mr26756547wmk.24.1652182611784; 
 Tue, 10 May 2022 04:36:51 -0700 (PDT)
Received: from able.fritz.box (p57b0b3fd.dip0.t-ipconnect.de. [87.176.179.253])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a1c4e09000000b003942a244ec1sm2308924wmh.6.2022.05.10.04.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 04:36:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: arunpravin.paneerselvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: move internal vram_mgr function into the C
 file
Date: Tue, 10 May 2022 13:36:49 +0200
Message-Id: <20220510113649.879821-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510113649.879821-1-christian.koenig@amd.com>
References: <20220510113649.879821-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to have those in the header.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 29 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h | 27 ------------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 51d9d3a4456c..7a5e8a7b4a1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -50,6 +50,35 @@ to_amdgpu_device(struct amdgpu_vram_mgr *mgr)
 	return container_of(mgr, struct amdgpu_device, mman.vram_mgr);
 }
 
+static inline struct drm_buddy_block *
+amdgpu_vram_mgr_first_block(struct list_head *list)
+{
+	return list_first_entry_or_null(list, struct drm_buddy_block, link);
+}
+
+static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
+{
+	struct drm_buddy_block *block;
+	u64 start, size;
+
+	block = amdgpu_vram_mgr_first_block(head);
+	if (!block)
+		return false;
+
+	while (head != block->link.next) {
+		start = amdgpu_vram_mgr_block_start(block);
+		size = amdgpu_vram_mgr_block_size(block);
+
+		block = list_entry(block->link.next, struct drm_buddy_block, link);
+		if (start + size != amdgpu_vram_mgr_block_start(block))
+			return false;
+	}
+
+	return true;
+}
+
+
+
 /**
  * DOC: mem_info_vram_total
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
index 9a2db87186c7..4b267bf1c5db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
@@ -53,33 +53,6 @@ static inline u64 amdgpu_vram_mgr_block_size(struct drm_buddy_block *block)
 	return PAGE_SIZE << drm_buddy_block_order(block);
 }
 
-static inline struct drm_buddy_block *
-amdgpu_vram_mgr_first_block(struct list_head *list)
-{
-	return list_first_entry_or_null(list, struct drm_buddy_block, link);
-}
-
-static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
-{
-	struct drm_buddy_block *block;
-	u64 start, size;
-
-	block = amdgpu_vram_mgr_first_block(head);
-	if (!block)
-		return false;
-
-	while (head != block->link.next) {
-		start = amdgpu_vram_mgr_block_start(block);
-		size = amdgpu_vram_mgr_block_size(block);
-
-		block = list_entry(block->link.next, struct drm_buddy_block, link);
-		if (start + size != amdgpu_vram_mgr_block_start(block))
-			return false;
-	}
-
-	return true;
-}
-
 static inline struct amdgpu_vram_mgr_resource *
 to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
 {
-- 
2.25.1


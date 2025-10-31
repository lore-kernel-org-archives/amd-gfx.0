Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD15CCFA04
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484CA10EBB7;
	Fri, 31 Oct 2025 13:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KHkckEzg";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E10FE10EB8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:22 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47109187c32so11936275e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918321; x=1762523121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvIMk872eUcGrvr4oYbCLqZzU34y/qoctkmyPmiR2qE=;
 b=KHkckEzgHgKs0uhcUWjbK9L9XE2COTdfHCjBFW1NNiwvcpxUjQBC1dMeW8NEaOoWfa
 xfGldVT7qg+45tjsctvUHpE2YYVO03glX/rQbL58HErYAmFFrUfAOC1BkB7q5k4/ac7M
 rlEQ2O1vWzl7GuuLwPz4V7YwDNAzTYMyVSKrQJpnFkuhkm/npck+ZyXhuJCD8oNGKTH3
 EbFSlMv3IsfQ4iInH5R44KeBAR9kicRC22eNTv+WWBY/jA/112sf0t86JBEqML4MVWhI
 PDUqKj6y7hhGFvHByKDYSbmaKZqesSzrWTn6sojDbdUpvx9x2AT8iAL7eFP/Io67klIL
 X27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918321; x=1762523121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VvIMk872eUcGrvr4oYbCLqZzU34y/qoctkmyPmiR2qE=;
 b=s2wb68ipSpURTtAfxg48FhI11RDBllpW6yV8dNw2mBWVkXAUeZMFGL5/zHX6+5Dt/Q
 2s70baAhBN60zfLWGk9zbl0ydLOeytOBgXbbaDz50o27sC36yFfDUXPmKcd+z/k4GgtB
 5RaUq4yxKoFGdxe5kqPkSa7i2qDhlmTElZw30Z9lQO+K7t7n6TOReyNRMRPvFwMR8ShG
 WMu/RFpL4k12y6k73tELhvX42pUMO5tj5LgOhHXgZUJnL6jafiqDbZjjQoY1mI1p4Euu
 snyicJoslvXt58/cKNDgRqiJF4iAlzYiwkySZco2mnCdQc/ansh/rjyI41xqU80yiwxX
 IKVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwRLVPAyJHYYXQmuKpyIgQVqdT8GKMMw5R6hXhf7onmf0pOo4eec2kj4VSJXMK9d4BC8mbQHlQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLKTvYSnq7AJsVntA4G6CdpsM2dfghegO4ROn1q9HE3nVfHIqH
 ko3tQIfJF9BT73rpG1rcDGmA6dtb9od9nZ1gMv+bOZDedHzSfIXCwgd3
X-Gm-Gg: ASbGncswrOF1P3LkVMg7e6PnR9VF2Hv4t6jHRvbsBw7uRjecQT1q7fnCbdT3u/fSxMk
 pHWmyD55DFWb4YCc1tNLR/9BLQGpj53tJTAhEAnSGBXySKH9Nemqn8DRzWcar/+WUs9Sfv+hsLp
 AsvQtIZLm3xUgH+8gXi4RhDaMf10YqluVVuP51EjJ/+7ggCqKx2o7NEKBr8VaeMCP9PyPHMRStr
 P0z3ZOWqwM9vT8xNbRhqatY7YQBhlApl8BwH1R4ADDDNuZOJjnwg7dmSFJq0kfR4dC2VKuaBWae
 +hCPNWBwDXI3eqrHPwWFcp5YOeWiGS7kbq8n7NQfyQcfWrhwPUkfIHGsm/SFHcfjRqKnVEia045
 DFP1i7kUAV8r+uC1K9gK29CWMwSQhUHCUss4wYVqtzG3eFT+ay+a41w3lIZvgomuq+LeOjsPn8r
 23esjeBy2iLYUtBQ==
X-Google-Smtp-Source: AGHT+IHYTAqcnzKdwrHIjwP0e7LE0KQcWN9px01yCeXyNDCjyUVslw3LMbRSCkFV3fZj2afZNaoSlQ==
X-Received: by 2002:a05:600c:a43:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-4773087b051mr33944955e9.21.1761918321189; 
 Fri, 31 Oct 2025 06:45:21 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:45:20 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/20] drm/xe: Finish disconnect HW fences from module
Date: Fri, 31 Oct 2025 14:16:54 +0100
Message-ID: <20251031134442.113648-21-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031134442.113648-1-christian.koenig@amd.com>
References: <20251031134442.113648-1-christian.koenig@amd.com>
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

From: Matthew Brost <matthew.brost@intel.com>

Be safe when dereferencing fence->xe.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_hw_fence.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_fence.c
index f5fad4426729..8181dfc628e4 100644
--- a/drivers/gpu/drm/xe/xe_hw_fence.c
+++ b/drivers/gpu/drm/xe/xe_hw_fence.c
@@ -159,9 +159,7 @@ static struct xe_hw_fence_irq *xe_hw_fence_irq(struct xe_hw_fence *fence)
 
 static const char *xe_hw_fence_get_driver_name(struct dma_fence *dma_fence)
 {
-	struct xe_hw_fence *fence = to_xe_hw_fence(dma_fence);
-
-	return dev_name(fence->xe->drm.dev);
+	return "xe";
 }
 
 static const char *xe_hw_fence_get_timeline_name(struct dma_fence *dma_fence)
@@ -175,10 +173,13 @@ static bool xe_hw_fence_signaled(struct dma_fence *dma_fence)
 {
 	struct xe_hw_fence *fence = to_xe_hw_fence(dma_fence);
 	struct xe_device *xe = fence->xe;
-	u32 seqno = xe_map_rd(xe, &fence->seqno_map, 0, u32);
+	u32 seqno;
+
+	if (dma_fence->error)
+		return true;
 
-	return dma_fence->error ||
-		!__dma_fence_is_later(dma_fence, dma_fence->seqno, seqno);
+	seqno = xe_map_rd(xe, &fence->seqno_map, 0, u32);
+	return !__dma_fence_is_later(dma_fence, dma_fence->seqno, seqno);
 }
 
 static bool xe_hw_fence_enable_signaling(struct dma_fence *dma_fence)
-- 
2.43.0


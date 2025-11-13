Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DF7CD6E7D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12CE910E83F;
	Thu, 13 Nov 2025 14:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PmRGo1ok";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 433DA10E837
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:41 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b73301e6ab5so117978966b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045620; x=1763650420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ok2RdBzpSpHLhzykCdEYH0j446EshY49nM35p1BHvz8=;
 b=PmRGo1okMEZ58QYnLKMm7o0nisCwhjekgHnaSNC/6CkCZRWDGxD/ZI7O16aPqVR7Qb
 JZfrz0DUORngcHGm6XODlxFYM9S3vkY1PJGIFOWqKjoax1QgDcoXklxFLg6xevqcfHBl
 l/RdIC/LITYHGuAB8rFA2vZLcZMxycdJ6TWi8dH4Z79Mklf8xGxaN5JwWZvkwQFOSvlA
 HMSrkyv2EQeAnJKSraHCxRcclk6L3Y/nSOJkZQXOEmmk1xnpfKdb1j6tVgYmxCYhSvlz
 3GzPIose4LNbUY2X3z+Ym54R3EqCwgx/3L6vVJKQ7Ygbqvbsb1sArLUylW0ihFAjBJSr
 MvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045620; x=1763650420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ok2RdBzpSpHLhzykCdEYH0j446EshY49nM35p1BHvz8=;
 b=qvlLX0TjOr9l1+ZbUEAk3zxC6jVianA8QSfqynBszVO9sYkqIPRF26pZ6fMYfPZRyj
 yB/CKxSf4LCpZA7iHmBH/lrUJduUOyf8FvIOeO9iS4tE8JFKJ6WS++ctWzw/jgAw/bzp
 ksM1lWsvhg695RdYwrZFYbRUwYfsiXee72kBEV4W0H7hIY5EQI8Wx88JtbaFDn7XWXUF
 hruOeNWdDqkoLd6ALpEDHRcMYG0Y/y0dvA9Z/uLqL/QTffRoICvL63gE1FKKe1Yt1wvp
 CjX79CtnOknX2yPdxGPwNV96zoGkMgUfvVC9yTDklX3xM5czfbceVFSfrLYNo697+e1T
 wsmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNdqY8GpijEGQxi0y5wtnV8GyZa/m2JdKg5YYQmo+U1NozuwAEVLwPF83j/WgB0AaaJJZ6qb4K@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyVqKN3QZOIFOwusiT+KDOYzKh4zNfrqkpnjrH4j7HLtTYfu/w
 8XLzLnnI4HTtwzA6F5Vucwwz9YSutUYbwNZdU5MLNm1GegTR4wxM0OG4
X-Gm-Gg: ASbGncsWto/zUbB5VtdDU0WghUvPxP2IhSA4JlrK0AaLKum8LbMVMD2klNNbWIQw+/k
 YuRrsRQRJlUx1LKAZWUisOECiE981JaiZPX4gM56dSPQkWieO/TxsWqbDWslaaHYKW5BRnDJeqY
 T/dSBdUtio94bKKBKSMrg6X7jgn/vRmSYA+grmsdQlo/pXV+Lh3tTKA6KprjSpSRHAV9Gt6Os/t
 fWtv1So5VQrmIXgYfIHNB/s0pWONP/rkLwm72aHvspHQOx/EZwQNApVDTHp+beXnHHVjI3yJNPp
 ZF+Xf9aezuFruebnF9tO5jbHILuDMYQl/+rpNOZrY6iQ5JsidgYZNrB1FoFyWDwL6I7fIqiLjuK
 kQBzv0ePKrieiYXlVpI4N5n4SbSEHysOjwkR27JJVJqfO6gQmZDT8RQniVIsXxBleFC/uYQoWEm
 BzdFajsCmRjC4=
X-Google-Smtp-Source: AGHT+IEVO0VWis3bbMJUiE8uRIugN/ybdSy0+PSRpX0sJIqHqRSuLB5xwAdqwXMsQNdKZzGuzi4zRQ==
X-Received: by 2002:a17:907:6ea6:b0:b72:91bc:9b35 with SMTP id
 a640c23a62f3a-b7331b5f4e2mr767267466b.39.1763045619679; 
 Thu, 13 Nov 2025 06:53:39 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:39 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 06/18] dma-buf: use inline lock for the dma-fence-array
Date: Thu, 13 Nov 2025 15:51:43 +0100
Message-ID: <20251113145332.16805-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113145332.16805-1-christian.koenig@amd.com>
References: <20251113145332.16805-1-christian.koenig@amd.com>
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

Using the inline lock is now the recommended way for dma_fence implementations.

So use this approach for the framework internal fences as well.

Also saves about 4 bytes for the external spinlock.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/dma-buf/dma-fence-array.c | 5 ++---
 include/linux/dma-fence-array.h   | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
index 6657d4b30af9..c2119a8049fe 100644
--- a/drivers/dma-buf/dma-fence-array.c
+++ b/drivers/dma-buf/dma-fence-array.c
@@ -204,9 +204,8 @@ void dma_fence_array_init(struct dma_fence_array *array,
 
 	array->num_fences = num_fences;
 
-	spin_lock_init(&array->lock);
-	dma_fence_init(&array->base, &dma_fence_array_ops, &array->lock,
-		       context, seqno);
+	dma_fence_init(&array->base, &dma_fence_array_ops, NULL, context,
+		       seqno);
 	init_irq_work(&array->work, irq_dma_fence_array_work);
 
 	atomic_set(&array->num_pending, signal_on_any ? 1 : num_fences);
diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
index 079b3dec0a16..370b3d2bba37 100644
--- a/include/linux/dma-fence-array.h
+++ b/include/linux/dma-fence-array.h
@@ -38,7 +38,6 @@ struct dma_fence_array_cb {
 struct dma_fence_array {
 	struct dma_fence base;
 
-	spinlock_t lock;
 	unsigned num_fences;
 	atomic_t num_pending;
 	struct dma_fence **fences;
-- 
2.43.0


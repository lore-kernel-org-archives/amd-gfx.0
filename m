Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDF4CD6E74
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A13810E839;
	Thu, 13 Nov 2025 14:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="blCMidlA";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ACB10E837
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:40 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b72bf7e703fso143742366b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045619; x=1763650419; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kf5nUbmsJlQk2pLkhNRD+8n7Z/+gOPuUpYrxnOVZvxo=;
 b=blCMidlAFfD93KPu1pe7sRP3lf9ciC9imE3fZ/qCyWRImD9xHtUmFmKThPvJLLsypQ
 frQvScSpcX94A1fNrKpzZ1+6RoV/0hQrKF4XWFdc+tgAxPnpvKVx36YvaWZt940XJNvi
 o/st+m9f3iW1lECmrrCVkeplTSvTAIO6tWorA8qcJirJaoEopG5uu7ZWES1aSX0D9Cn3
 gVVmaPRoh4iZn35IfumwUG6x4fszL1ekt8GjW2juZrTKNXiOzdUQtFmeZS9BrELNW9Zj
 1Yhd8ZWl7q9Eie0VmQ9ict7n3nXNv4AkJUdtKmQokYs3OtBpYt8aWmropXT8EFmqZTJb
 GoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045619; x=1763650419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kf5nUbmsJlQk2pLkhNRD+8n7Z/+gOPuUpYrxnOVZvxo=;
 b=Ygt5lLgDqrzptEqJPiW9JwTq0nEeANXhNpri9fPS+X8gyVNuj1ak5cl13PejR7AAt8
 0eOny1bBjdx/tSMLpPN+6qJf9R3l0l9C3NwrrG07u5FYGkCU/beyTh8FC6LEWu0TKEN9
 GcABkEOEZ/4BbH9rDvJgHGAM094zWHaABaepejgfC5qzyco8b3QkVbxqUNH5XJq5sfy+
 JKc6Arkr/fbKPdrTzDgE4z3TMuHiaD0O42CCRcDJpK7sa8pYPp9bFRWa9KkFRp+Qz7En
 VDteC1Nf3dtMOCOFZW6ccLZTdL0oNxGnQkzbdXqTpZxE9HV+mk5P4vvU2pBAM//TVkZz
 iacQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqkgvStxttTNlSo5zkAeBRVK/VfO2+OUvDKXqE7I670qy7G94O3+xupSvF/ialGDlUyn529gRb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwwvXX0qe5Fzb30FIxSEPRDlCURl+nduLZ2uv4xPVSQaGPEK8l
 NlOpEefaLuGaFyFfsCc7uZCzvIr5MAMZ15mm6JXmZ/eB0s6hMecr80+t
X-Gm-Gg: ASbGncvhjTVTwH1b/+yOCaZTk9uQa5yr4y2mWKQAoeSyjiILfEzkckVShsOAx6ABp7K
 mjSHmaNqlqFh3wNnJfW398NHuXBGvpit/mi3jMd3dgH5BK4AKTjKhJOkALpAtjtv7BE5OgF31oz
 XuE1N0mFMsa3OBZncKsSQYMXZjts6jM4jGhaYDiIMar3lIuCLHmo5PbGD+Cv+HEKtvmfyGW+OA9
 3BFdGVhJcl0JuYThNzQfLzVoPE+bGBf12fyqSvkKhrGhGs+Lb4HL4VBTge942/NXxIduYNzOtJT
 DwDR/Abi6Pua/Ke+N+VAeS+FEjCGmrmu6a3ojf4K9BSufzE125CjYHD9o0Qkx7OtzlA7lLrwIlA
 jQ7QXnYtB/W2MwgfLiQDN5Gffr8HldalYKpxDtbsQdPCjI5cbdkeVcOWcCrrEp4AOIIfGV6uWG+
 aIZtiogywZ+e8=
X-Google-Smtp-Source: AGHT+IGFi4syHFjqiuoZ0USYNWW31Yq7gTAM89aYi7X38qHdJnJn/ojNMUB0T9kSadkfKYlQFb0oYg==
X-Received: by 2002:a17:907:60d3:b0:b72:eaba:aac2 with SMTP id
 a640c23a62f3a-b7331974fa5mr762979966b.26.1763045618777; 
 Thu, 13 Nov 2025 06:53:38 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:38 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 05/18] dma-buf: use inline lock for the stub fence
Date: Thu, 13 Nov 2025 15:51:42 +0100
Message-ID: <20251113145332.16805-6-christian.koenig@amd.com>
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
 drivers/dma-buf/dma-fence.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 9a5aa9e44e13..e6d26c2e0391 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -24,7 +24,6 @@ EXPORT_TRACEPOINT_SYMBOL(dma_fence_emit);
 EXPORT_TRACEPOINT_SYMBOL(dma_fence_enable_signal);
 EXPORT_TRACEPOINT_SYMBOL(dma_fence_signaled);
 
-static DEFINE_SPINLOCK(dma_fence_stub_lock);
 static struct dma_fence dma_fence_stub;
 
 /*
@@ -123,12 +122,8 @@ static const struct dma_fence_ops dma_fence_stub_ops = {
 
 static int __init dma_fence_init_stub(void)
 {
-	dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops,
-		       &dma_fence_stub_lock, 0, 0);
-
-	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
-		&dma_fence_stub.flags);
-
+	dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops, NULL, 0, 0);
+	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT, &dma_fence_stub.flags);
 	dma_fence_signal(&dma_fence_stub);
 	return 0;
 }
@@ -160,16 +155,9 @@ struct dma_fence *dma_fence_allocate_private_stub(ktime_t timestamp)
 	if (fence == NULL)
 		return NULL;
 
-	dma_fence_init(fence,
-		       &dma_fence_stub_ops,
-		       &dma_fence_stub_lock,
-		       0, 0);
-
-	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
-		&fence->flags);
-
+	dma_fence_init(fence, &dma_fence_stub_ops, NULL, 0, 0);
+	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT, &fence->flags);
 	dma_fence_signal_timestamp(fence, timestamp);
-
 	return fence;
 }
 EXPORT_SYMBOL(dma_fence_allocate_private_stub);
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4998ACCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA63D10E469;
	Mon, 13 Oct 2025 14:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mlSozhbj";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B2F610E45E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:08 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6394938e0ecso7013730a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366107; x=1760970907; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMqpKkdL6ZBRa5OiGdzGfwCdJ5Bw5+ePeaPQokiKa3M=;
 b=mlSozhbjaecRzOPoFLtXeWaKkzTnpg8RuNov1BHfyyEtrjI6TmKokeoU2mNzi4EtAI
 JWHIcKOmu9Ul2FiO2cmpkP8GmTO89+TYdKGIush8B9FSAX4u8HI2Tr8h6jwnC9JD5z44
 MtAiHXVURwZ9rsg2d9TXCz/fsMzOKu+xDN7k0BpasTN6PxEc5Ci8wsmPi9wmn3dZwzQa
 uzoVolxJ57OWZFXGTHVSxRAwcMnkx1WKCt6j39eZM0gkqDo763Z5tp/KGYEF/V+8HYXL
 UlSasNLuVrxOqT5HjXAu3QW8q0hZ/HrgxYnMyQ7wQkFlerWsCwf5P0Vay8ee0rl0dsds
 jZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366107; x=1760970907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMqpKkdL6ZBRa5OiGdzGfwCdJ5Bw5+ePeaPQokiKa3M=;
 b=ZcNN9oaI4WZyAPEBB1cBNbfL/aFUlQnPu8NO2xP7D2dxkKm2g+fqvjVlZdrKuw++5K
 uvXtz7YeXV5UXe7788DCZ2dQo0O+ZQcJPhGL1oOdaaL607gmKEQfP+gE9lI1X2zc/x9t
 a/d++n5yYiqa9ffv96BwBY+fbEqMBNZLWuLQ/dss4aRS1q+sBrxszIzL0yPQ5KIQNV2L
 SOMikP2QL1oj9XbEaB0T1zJILycmb/9uRz+SOSg5HuYYFfc6RCczzgnHU2tb6jGekkaL
 NxLZNqn66bgYbDZ7BlVf+DUOkm5bYTC6kZbuRQSmmGzSDgmXFVTgSgj5ACbgz6XbFDlN
 d1ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr0QD3hQ3P5eO8wu07QPvDvHI0LRzWy7PrrTifBNxofK0Ryn5nZ1FFtn1buDwwrestrKB1ER7J@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUS+dMI/Rs3gV7CKOMiot/oe6XoZGoDFrRbQ8YhST6jNFdGR7c
 +WaqucFTI5u2XOS7Ys/B2tbad8fPV5Z8RaMCeUjQ+wgvuTl+zg7F/e9AEMYbVQ==
X-Gm-Gg: ASbGnctooy1eW+p0mIeGteOWT5dOiwm16Wi5L4agkipL/ybaH/uOtq4ND90IbWLoHFo
 rsYj29V8X5F3fDz1mJY6XICENA4P0cr+Wt+VxxDr11EFSuSjnVJeRVDwBXCIcYYoTsOv6u2u2FL
 52ZmUzCDQuET+5Zt6rc8V2K2qIH0OkxcjQFlr3J9tyhu5nKoIJ4F0K1QQb66AgLJ4OXuP7B7+no
 TluZx7o+tcrI7dZy0vDYZI/9r2Fbm+r8yL/NVaQ/3KDZzIxmqEVaL6etkHoZ7JxS2NsRnbWRDY+
 ITKPY6jdAX7sFAueTHeXjn1K2JCf1A4HSjSnoZ6WMyMwJ/V4VWr44bhxIngiGM3c1iqQ/UJHPdN
 b0jGcbw8+L3Wx39Brj8guJoSzDCb6vuR0btXAcQX8BJZUVyj3YzDlRgQfRZtmsrHMnEtV3DhNer
 /t
X-Google-Smtp-Source: AGHT+IEV48NzA+YJBNB8eWl6C5nP0fMs0kn0nxEPC7hBgx75AXDeIY4WUcq0HKdMM9yQ6ZUNqABFyQ==
X-Received: by 2002:a05:6402:518c:b0:62f:67e0:55 with SMTP id
 4fb4d7f45d1cf-639d5c371demr20012302a12.24.1760366106514; 
 Mon, 13 Oct 2025 07:35:06 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:06 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/15] dma-buf: rework stub fence initialisation
Date: Mon, 13 Oct 2025 15:48:29 +0200
Message-ID: <20251013143502.1655-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013143502.1655-1-christian.koenig@amd.com>
References: <20251013143502.1655-1-christian.koenig@amd.com>
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

Instead of doing this on the first call of the function just initialize
the stub fence during kernel load.

This has the clear advantage of lower overhead and also doesn't rely on
the ops to not be NULL any more.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index f0539c73ed57..51ee13d005bc 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -121,29 +121,27 @@ static const struct dma_fence_ops dma_fence_stub_ops = {
 	.get_timeline_name = dma_fence_stub_get_name,
 };
 
+static int __init dma_fence_init_stub(void)
+{
+	dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops,
+		       &dma_fence_stub_lock, 0, 0);
+
+	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
+		&dma_fence_stub.flags);
+
+	dma_fence_signal_locked(&dma_fence_stub);
+	return 0;
+}
+subsys_initcall(dma_fence_init_stub);
+
 /**
  * dma_fence_get_stub - return a signaled fence
  *
- * Return a stub fence which is already signaled. The fence's
- * timestamp corresponds to the first time after boot this
- * function is called.
+ * Return a stub fence which is already signaled. The fence's timestamp
+ * corresponds to the initialisation time of the linux kernel.
  */
 struct dma_fence *dma_fence_get_stub(void)
 {
-	spin_lock(&dma_fence_stub_lock);
-	if (!dma_fence_stub.ops) {
-		dma_fence_init(&dma_fence_stub,
-			       &dma_fence_stub_ops,
-			       &dma_fence_stub_lock,
-			       0, 0);
-
-		set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
-			&dma_fence_stub.flags);
-
-		dma_fence_signal_locked(&dma_fence_stub);
-	}
-	spin_unlock(&dma_fence_stub_lock);
-
 	return dma_fence_get(&dma_fence_stub);
 }
 EXPORT_SYMBOL(dma_fence_get_stub);
-- 
2.43.0


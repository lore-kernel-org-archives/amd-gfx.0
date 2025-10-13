Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27FBCCD190
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE21410E45E;
	Mon, 13 Oct 2025 14:35:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UCJJA4fh";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6587010E45E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:07 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6364eb29e74so7569562a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366106; x=1760970906; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQtHjJp1O7GpUAzN2iykGYE0b3+FU8GN7LOq9lJ7IHw=;
 b=UCJJA4fhybiTQH+ckuDJKATmhg4kTPpXQUS36OvHCjyC+hm2lSXulyhtygcf5MRiNl
 Ki+TR7911YDFbqj2ZwFscMmP0LCxo4KbRYdhs59EeTRx9QY3zWUj7vyyyh4ow00kGqyi
 VnTfVBokW2cSBxaDy6xe48IpzvCRskC5VwmSNlxBKF/4zjBuR2+u7BeoPJq1oE+WQvoc
 5rmlYjLzKhmYn7wdYMeZB6Z+izauy0b/sf7FcsW8HVULrU6o0FCMQ4qNRlyAmSuqAt/E
 XKcVJl9CMH6Zpv5Dx3HooAQbqhbZMrgIeofFIGDV2iV5Qts7B6yjA9kYiE/gJedoAI42
 7TFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366106; x=1760970906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQtHjJp1O7GpUAzN2iykGYE0b3+FU8GN7LOq9lJ7IHw=;
 b=QeoxL8tTBUFN9Rt4H81QzJlWFTWpqchLs8uOyDKg/Bh8NcHicTveIticUjKQKMZ7dO
 CM8SK4xkrtTxgwNautGpWDTE+Wu5Ar5wQXxCaAUnktevCrjeIAxkajHnenW8gfyOLEge
 FYGBcvEYn2upgp83yT3ZYuBJGiF5U5+qWAWo8fJ0N9NQkLzfaNJp7GPeyDUVI624ZC8L
 eTC/1ba0bDGnKezHBzIE5bH9nbyDExrj1TK9XJPF8fMwl0tdBgsMXR2NY8ND+klP7lky
 Zhaq5YaaTZ6StahQjFExKtz6u0Z1nw9Fl0b7Sw5RHqpb6wFPlPruwEZuC5YRlkTGlBEm
 95Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx9RpfTBPu/NN+sZshkMUFlWod/piDs3sk4J5K6alH5bdcijYG5os5o3kyVQJBMX6Qx9pCPtGX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKSS/hchcM9SG+XvdnndemBsgtGsIdA13pANCSyA3EqwYZVzxg
 kXF2eklfPdlyp3PjSdUg1aOdW2ooj8yM+vrqFFLwkN0GF0DRxlEdqm6i
X-Gm-Gg: ASbGncvlN3Sa4V2XlwVViIQuuAofykUfDGWAMmxXgJav/6hiZkppXnlBJrrV2OTFqkB
 8xY01SQcJMpr27CJHAKk8GdanlGgEddcEVWIm60RgWRlRN432OGeGyV5rwMhAy3xRVh3sRkG578
 PXJPSH39Jm0XJhC9a4PKxcE5njTFlcXz0KtUlPahzqbhmJiM/tLmInLkXgFytN244s/y5EXyI++
 xHGwR0Qrh66BQ295MgT6Uz5CsTy8TqEQnrSWO4IMFncDxO25SsSVHouzqn+HHVrRnFowzrYM9rt
 FSVFju+7uP7mHPCc1dDkub7Tv4W0dkgAw0jnOAzZNPB75FAICO9DEjITPwDI1i5QynKVlXsxFpI
 4aCYaCA3bVLoZHWAfnRFTBGWA5voopZ+BAC92RjfL28PYWQZo39w7jZw=
X-Google-Smtp-Source: AGHT+IGIi7Zl6P+yRsWAAfp4mosqDDBFQEEBdgfFdC6fr3sC/6OUGUGBlLtDGHhY6yklOfAgGtpqKg==
X-Received: by 2002:a05:6402:5645:b0:637:ef70:a111 with SMTP id
 4fb4d7f45d1cf-639d5c5af44mr13661304a12.30.1760366105827; 
 Mon, 13 Oct 2025 07:35:05 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:05 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/15] dma-buf: cleanup dma_fence_describe
Date: Mon, 13 Oct 2025 15:48:28 +0200
Message-ID: <20251013143502.1655-2-christian.koenig@amd.com>
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

The driver and timeline name are meaningless for signaled fences.

Drop them and also print the context number.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 3f78c56b58dc..f0539c73ed57 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1001,17 +1001,18 @@ void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq)
 {
 	const char __rcu *timeline;
 	const char __rcu *driver;
+	const char *signaled = "un";
 
 	rcu_read_lock();
 
 	timeline = dma_fence_timeline_name(fence);
 	driver = dma_fence_driver_name(fence);
 
-	seq_printf(seq, "%s %s seq %llu %ssignalled\n",
-		   rcu_dereference(driver),
-		   rcu_dereference(timeline),
-		   fence->seqno,
-		   dma_fence_is_signaled(fence) ? "" : "un");
+	if (dma_fence_is_signaled(fence))
+		timeline = driver = signaled = "";
+
+	seq_printf(seq, "%llu %s %s seq %llu %ssignalled\n", fence->context,
+		   timeline, driver, fence->seqno, signaled);
 
 	rcu_read_unlock();
 }
-- 
2.43.0


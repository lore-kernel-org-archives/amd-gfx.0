Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B17CD6E73
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F2D10E833;
	Thu, 13 Nov 2025 14:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XfAho2e/";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A74410E820
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:37 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-64162c04f90so1578626a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045615; x=1763650415; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RPR3UfrNYxFDjh6mqln5EMxB6otbdQrc1I1BewMqrEE=;
 b=XfAho2e/nX+bRY8iMN4A4VOZcFlVc8Jfnt2m9ROi3WNuU12aWNImah5pquy0k3jHW0
 oZoip1NdEHaYKrUcnZf7Vz5s1eJ34hnJaWxWKTGtvjtrG4MZN9iYo8lW6IKDaBon1dVC
 vtEY/M/PdeloeAMClHQewjHmgrmQQYGwYx5I3xoIcyVm6AxZA0Ux6C++IyuD9sJZ81mS
 e8rhO+eP2aCbqUyPUuBX9+5mjKEdiUbpuKFLCHrzuLgy+PPfwkEiYJBlRyYlEj0MRlxl
 Y1k2wyjpuL9kHRLotQAsTA1HvPgHmNZ2auP833xEJmqwme5Y60Tx4Ox4rvL6l4fzTSV6
 W1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045615; x=1763650415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RPR3UfrNYxFDjh6mqln5EMxB6otbdQrc1I1BewMqrEE=;
 b=QqVTegRdVuemH+GXinXB3sA9Mu3ktJ+b/Ba4YS+ebA0oVVOqoNHiDr2/ma8/REeOeW
 WoPikKdsbIWRgYH30sDPzr5pV4fypUDKUD1SuBV2+MRTaMvr0NvwkItsN5B/N8gLTUV1
 CPLhKp9J8nzcJJHJO8+q6qaWE4bE9L2Vyf85v/bMNmXo2VdkZAnZTVH115IGYw9NGgFm
 Ft9gVq5RwVRiyrkZaS9ItQv3mmSrGhGRMhXnY6KIQ2Ze9cqM5nn6GiyyQHxqt89+awSK
 r5/jZVE5ua7oxeWWRYjUNyeQeGgikH01whtrhQyGYz7slqxSO/WspdO1nSvxRXDt/TJd
 PR/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0svwBah79qjgOd+cFDEHHHGlWJ71F8LEPhQNZBPWzxdpqN2G1vh2hq6rL3sBStrVUOuEgo2Ol@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmpJLyx+KJ4RdKR30hDB/Qo1HQCjGbNxxP8Sh4KvXb106rgEqf
 N1d1UU64cY0qWgXP8zuyGphQWR1vH8PFlLnGie/MY5YZlE76kUMPACtg
X-Gm-Gg: ASbGncuxBStddfL5tYzD7iv8YIvp9HBjUK6XjZfFaXZateohqGOH7lidXv8aIsS4G3T
 qL+62QSZyFtsv88NwzbQIEeRYgXXTJGqyBeRZ3oBAVQRNV9D57YpdJAxUYVUhN76CxdjeKFlxfI
 jEUFI7XyFNBQo+OIwD2WjSAZqbHNqS8h9PEZqQqHPsY1i0/s1H7ExUQlhqPJm5aqLSwLDqilCeF
 iAmBGd56t79HW8GqysQV3q20f5NrIJJsmRz0jxpj/2NTUFBm22vVwMAHEzTU4wwa9eydgyJyF9D
 Lny9CeIEtUCczuTXgCcD6vKBPXbnz+FIpfS9l/gjXTjdKsDLJpyr1Mnx7/UW34SekZfeTSDUAUr
 cdw6uWSQ+2logeK+AryJAp+se66N4A1N9nwhKIh4kcpjCWKcgTIp5I1zOQKW7OQMuRJPN2LMJZE
 ZjYW1mkvC9Jo9rMOsnjLBhgA==
X-Google-Smtp-Source: AGHT+IH3EaxLSnCv9gLMHoWsafC+66G7Zf4PqH9YrKbECxXDf49gDk8XCoLQwGvA4IfFvykHWqo2Nw==
X-Received: by 2002:a17:907:60d1:b0:b73:21af:c0e7 with SMTP id
 a640c23a62f3a-b7331af147bmr800895766b.53.1763045615330; 
 Thu, 13 Nov 2025 06:53:35 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:34 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 01/18] dma-buf: cleanup dma_fence_describe v3
Date: Thu, 13 Nov 2025 15:51:38 +0100
Message-ID: <20251113145332.16805-2-christian.koenig@amd.com>
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

The driver and timeline name are meaningless for signaled fences.

Drop them and also print the context number.

v2: avoid the calls when the BO is already signaled.
v3: use same format as trace points for context and seqno.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index c5d1478b28dd..b4f5c8635276 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -997,19 +997,21 @@ EXPORT_SYMBOL(dma_fence_set_deadline);
  */
 void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq)
 {
-	const char __rcu *timeline;
-	const char __rcu *driver;
+	const char __rcu *timeline = "";
+	const char __rcu *driver = "";
+	const char *signaled = "";
 
 	rcu_read_lock();
 
-	timeline = dma_fence_timeline_name(fence);
-	driver = dma_fence_driver_name(fence);
+	if (!dma_fence_is_signaled(fence)) {
+		timeline = dma_fence_timeline_name(fence);
+		driver = dma_fence_driver_name(fence);
+		signaled = "un";
+	}
 
-	seq_printf(seq, "%s %s seq %llu %ssignalled\n",
-		   rcu_dereference(driver),
-		   rcu_dereference(timeline),
-		   fence->seqno,
-		   dma_fence_is_signaled(fence) ? "" : "un");
+	seq_printf(seq, "%llu:%llu %s %s %ssignalled\n",
+		   fence->context, fence->seqno, timeline, driver,
+		   signaled);
 
 	rcu_read_unlock();
 }
-- 
2.43.0


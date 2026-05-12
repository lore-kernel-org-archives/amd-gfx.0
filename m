Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C30CD4F24
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 16:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1712A10EB28;
	Tue, 12 May 2026 16:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XOOJBl+I";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A30210EB28
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 16:27:14 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so57390255e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778603233; x=1779208033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ik6+/19tH6y9POcs788qlWg9BZEkOoMIy7j1IXRGQQU=;
 b=XOOJBl+Itsmc1DwmFhXpY6+zmvJKJwz4BqpGhKarahM7v5idGgnHHkXzf8JU2h6duy
 EoDeRCI2RY34ffbHTWi9ECwJ/mDjqOPPWzLvrCi2t9nde7pNwiN2uQISzOy8/4T7Dcd7
 yUxhWIzGcjunI5AgXjiDzmcakIznsWtj1x36xlcgFw/BSnMwJhiQz9WlzjBDJ2JR1JoX
 t79wvMKRfsQM3JPPeA2MDkpGMWJMemOfZsWissS/qafXBKnCQBgQJC2V7AZARpNv2xnh
 DnMztfVfAvod73I4kOXNZpnH5fAhfci7XlxF4JGRtnjga/8enP1RbCjsRL5gsHL1/Nt4
 Dd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778603233; x=1779208033;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ik6+/19tH6y9POcs788qlWg9BZEkOoMIy7j1IXRGQQU=;
 b=CXv8C7+F5NDSzriV/XNxtTJHb4UpcHN3jjjVNXHCQC3k/VJS+uX7NnzMWWXAwso936
 5TNDsQvLedeyd+MBlywHLerFzgnpEUFcBMtasdA2EqDahn71LBzG3FeSCoYfCWRVsOa4
 4bvH1qJvV/ozZiPS92mTRDE8ZtHSjNCc+Ci2CtJiBgf+hd9jHpthz9kP2bRPciEmiSqa
 /e1g02SvNuT7ZQMqEKPTTY5HPn8CPMmDy7f1BMp3yJ6V9km78mGfBiS3aT5MywIt9bvC
 ImrYdxOy5bTAO6Yb+/YeI49Nnml+JzHOt2Z7yab9U6ypRsMpE7v5bKWX+9cnJbzn3C8U
 G5Ig==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8DP68jV64aPGGkdxdYg4MFUVX+By8darsYRbIcI+WmqHH/3bFSdJJNK1uJh8GaNFQgzo1+kaN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyU2h64afktaesvBo03aWx7LpxIzfQWmwf4iHnzjg3xyC7vLiUt
 a6AA8trTd5M0F6yf5ypUIsJUcOUvwp3kVHjpovcnk1IUqE3QuJySYwyamAkmOQ==
X-Gm-Gg: Acq92OGzCgzwpsPk1sCiuuIj40eKU5oFFFcN8TrHfzb9QPc8HXUtMhX7TcVAQTalJ38
 gOCLHWJnUAWF7zLTzk0B6GPqnqf+EguWp48Wn+wYaAjpKQhC69OP+f275ePOFWyIYJdple50aky
 JlHpB0tos3vNhG5Z9TuXN7orIn+Z/ya5XnUmXDhktXb6nG4XwvJc4URDRMYdGoYU1OD7Y82Fu/a
 orsZmaJ4dM9UNXJ6cdlPuNY5l90CsrW4jgGwvuW6jT70cKSmTorhS5Y0AFmCR+4m+mugMkX0VUD
 gRLTgARZNyYY0LNSfl5eaeD7foFnoA8WgCzh3lv5xuKoZGyqjuYHz3i8Ble/T0BUAt81ULJUMQ9
 HzACnQOkAilvZ0NGdxNxoMzdY8dYYVoiDYy74K7uOfeBwZTiZ1T0ZE56/9IZ9c86GBJ2FbveKxa
 U/SdSIrQEdrLu++TLFqNIj5K9tbE5f0cCPhjjx
X-Received: by 2002:a05:600c:198b:b0:48a:592c:e63d with SMTP id
 5b1f17b1804b1-48e676a5245mr331545345e9.14.1778603232865; 
 Tue, 12 May 2026 09:27:12 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b9:5900:3e99:f03a:ee63:3e8e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120ec0asm33019349f8f.17.2026.05.12.09.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 09:27:12 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: vprosyak@amd.com
Subject: [PATCH 1/4] drm/amdgpu: fix amdgpu_hmm_range_get_pages
Date: Tue, 12 May 2026 18:27:08 +0200
Message-ID: <20260512162711.51118-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

The notifier sequence must only be read once or otherwise we could work
with invalid pages.

While at it also fix the coding style, e.g. drop the pre-initialized
return value and use the common define for 2G range.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 90d26d820bac..eb470e252399 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -51,8 +51,6 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_hmm.h"
 
-#define MAX_WALK_BYTE	(2UL << 30)
-
 /**
  * amdgpu_hmm_invalidate_gfx - callback to notify about mm change
  *
@@ -170,11 +168,13 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       void *owner,
 			       struct amdgpu_hmm_range *range)
 {
-	unsigned long end;
+	const u64 max_bytes = SZ_2G;
+
+	struct hmm_range *hmm_range = &range->hmm_range;
 	unsigned long timeout;
 	unsigned long *pfns;
-	int r = 0;
-	struct hmm_range *hmm_range = &range->hmm_range;
+	unsigned long end;
+	int r;
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
 	if (unlikely(!pfns)) {
@@ -191,8 +191,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	end = start + npages * PAGE_SIZE;
 	hmm_range->dev_private_owner = owner;
 
+	hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
 	do {
-		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
+		hmm_range->end = min(hmm_range->start + max_bytes, end);
 
 		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
 			hmm_range->start, hmm_range->end);
@@ -200,7 +201,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 
 retry:
-		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
 		r = hmm_range_fault(hmm_range);
 		if (unlikely(r)) {
 			if (r == -EBUSY && !time_after(jiffies, timeout))
@@ -210,7 +210,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 
 		if (hmm_range->end == end)
 			break;
-		hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
+		hmm_range->hmm_pfns += max_bytes >> PAGE_SHIFT;
 		hmm_range->start = hmm_range->end;
 	} while (hmm_range->end < end);
 
-- 
2.43.0


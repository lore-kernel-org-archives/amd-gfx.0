Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F7DC44509
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 19:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346A010E22A;
	Fri, 10 Jul 2026 19:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YlzW18S5";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489EC10E22A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 19:07:59 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47defd0c1c5so895831f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783710477; x=1784315277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/fM2g6hrSRmJlUHgqQyOMFyX9IRPiNo3S9XYkHpe50w=;
 b=YlzW18S5//ZZ2aOznE5k4eERw0ydZMLwncIxPbPUJxS8azu7h+oYjXI38AFycvVfM5
 uAFTfmdJms5cG6FNli/ggg4PTpAAkN1wR/+6vt/JYQIq7dHpY3gbuLuKi6cKMk+g8VZ1
 rO3SLKLmQtsxz8fNeQ+Oo+2W2SjmhU152CwAPXqV+n58djQJAEuQO0he9GWLYJ/VTv5Q
 VPW0mZUmzG5UxpKWSsyL3hijxB48fmvo8InF2JG4oGxg3/aFNWsil1avE8TV64K4/C9m
 bLwUl9yaySc7GcNPjQvmJW2ZYDnpikA7yqvAW/UY2CQCy+Dqs3zK3Dzqx8ANJNtC2xFn
 tKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710477; x=1784315277;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/fM2g6hrSRmJlUHgqQyOMFyX9IRPiNo3S9XYkHpe50w=;
 b=BetLevojBrV2SbSS8tOCKRLksyIpfDVQfWiJBz017ATqwLAKv5mAj2gL+H4tmnycHA
 r9IL6MaXJaXi3SfRUs9QyjOMUqOxfwl1da/XEYT7VOtuM7acEH2T/zxGCYNYwTQPa3+y
 29C4OZ/9lWiXfOL7Ct+61mRxQfkDztczx/RMPW1Tz357OLrY/xTXMxPIT7HvBCN0ktj7
 dadB0deeEIt4TL3vwOa31nbNY6D/h42t8odOXqSNwx376fwNyQoHkz63tE5oIlcR1BpY
 ExFSg4JOBIebAxOYC8cIGcGO7VrqOUYw2omajrD0NK58mEIFu2CbRgaWxkMR+W6kUOY1
 rjuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqA4QDTPRYfG38+IL5uiuHMsXlH2wi2IUCrQqpPyokaQBmus1WDI9flXSXIixkHfobhsNmS0fe7@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2HZRBt4UFUSTotjk0z5+PF2/NILVVuZDtL6XdrNDBVuDxu2+i
 RP5dMiKy1EQv4ILsIewAh/EN+bY3d8P4Lmk7kIy6FTrVfpm5kG48MIFK
X-Gm-Gg: AfdE7cneNZchvsLoofK8cnVmgdAFv7fvl7HkcBVukDuUpGFvAw7w1aN/0u+0pBJweie
 IzECHEph2UOpQgeM00qCNoyQEVVehc7jvj/RxojnmmiaYXjF8BaZ9OfHa4B0BfgFOz75Xq0GmkU
 Zf0poc8upJ/O3zJJpV0gjlypct3KCywB5B1HCJY778Pu8MXvMVpZBYduSo0lB9ab8oJABFiTBX5
 Xht6Ic35I0nTfVT3TDrlEtre6X9KpR4jdpSYw6/W7iqmIi1N8+uiaE2aHbRivVE97o82ZuZJarr
 qVxjvogWAjUBH6v2TJS3vuOyw4n6HDWjuNEsIgybOIxaxKb6XC3ztqlW7RXX2c3mlGhyFOMmEC8
 8mLQd5r+nxQ9HHkIOSvGGUp0KQTcKLGffhDLmouezc6U5WPQGMr5g5Ri81o06C6X/u8C6RqhXcz
 iFiGqE/GxZQHh9So5+32mvzRdfcg==
X-Received: by 2002:a05:600c:821a:b0:493:bba7:e9f4 with SMTP id
 5b1f17b1804b1-493f881ddfbmr1001965e9.18.1783710477135; 
 Fri, 10 Jul 2026 12:07:57 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154f:ec00:aa08:de24:db33:4496])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm55000755e9.6.2026.07.10.12.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:07:56 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 simona@ffwll.ch, matthew.brost@intel.com, nat@pixelcluster.dev,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/12] dma-buf/tests: Convert st-dma-resv tests to use
 dma_resv_alloc
Date: Fri, 10 Jul 2026 20:52:42 +0200
Message-ID: <20260710190752.2355-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710190752.2355-1-christian.koenig@amd.com>
References: <20260710190752.2355-1-christian.koenig@amd.com>
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

Update all test cases in st-dma-resv.c to use the new dma_resv_alloc()
API instead of stack-allocating dma_resv objects. This demonstrates the
proper usage of the new allocation and reference counting interface.

All five test functions now:
- Use dma_resv_alloc() to allocate objects
- Check for allocation failure with KUNIT_ASSERT_NOT_NULL
- Clean up with dma_resv_put() which handles freeing

This change also provides better test coverage for the reference
counting implementation.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/dma-buf/st-dma-resv.c | 90 +++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/drivers/dma-buf/st-dma-resv.c b/drivers/dma-buf/st-dma-resv.c
index 2c43d2d2b0169..b843d90417822 100644
--- a/drivers/dma-buf/st-dma-resv.c
+++ b/drivers/dma-buf/st-dma-resv.c
@@ -41,7 +41,7 @@ static struct dma_fence *alloc_fence(void)
 
 static void test_sanitycheck(struct kunit *test)
 {
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	struct dma_fence *f;
 	int r;
 
@@ -53,20 +53,22 @@ static void test_sanitycheck(struct kunit *test)
 	dma_fence_signal(f);
 	dma_fence_put(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+
+	r = dma_resv_lock(resv, NULL);
 	if (r)
 		KUNIT_FAIL(test, "Resv locking failed\n");
 	else
-		dma_resv_unlock(&resv);
-	dma_resv_put(&resv);
+		dma_resv_unlock(resv);
+	dma_resv_put(resv);
 }
 
 static void test_signaling(struct kunit *test)
 {
 	const struct dma_resv_usage_param *param = test->param_value;
 	enum dma_resv_usage usage = param->usage;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	struct dma_fence *f;
 	int r;
 
@@ -75,33 +77,35 @@ static void test_signaling(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+
+	r = dma_resv_lock(resv, NULL);
 	if (r) {
 		KUNIT_FAIL(test, "Resv locking failed");
 		goto err_free;
 	}
 
-	r = dma_resv_reserve_fences(&resv, 1);
+	r = dma_resv_reserve_fences(resv, 1);
 	if (r) {
 		KUNIT_FAIL(test, "Resv shared slot allocation failed");
 		goto err_unlock;
 	}
 
-	dma_resv_add_fence(&resv, f, usage);
-	if (dma_resv_test_signaled(&resv, usage)) {
+	dma_resv_add_fence(resv, f, usage);
+	if (dma_resv_test_signaled(resv, usage)) {
 		KUNIT_FAIL(test, "Resv unexpectedly signaled");
 		goto err_unlock;
 	}
 	dma_fence_signal(f);
-	if (!dma_resv_test_signaled(&resv, usage)) {
+	if (!dma_resv_test_signaled(resv, usage)) {
 		KUNIT_FAIL(test, "Resv not reporting signaled");
 		goto err_unlock;
 	}
 err_unlock:
-	dma_resv_unlock(&resv);
+	dma_resv_unlock(resv);
 err_free:
-	dma_resv_put(&resv);
+	dma_resv_put(resv);
 	dma_fence_put(f);
 }
 
@@ -111,7 +115,7 @@ static void test_for_each(struct kunit *test)
 	enum dma_resv_usage usage = param->usage;
 	struct dma_resv_iter cursor;
 	struct dma_fence *f, *fence;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	int r;
 
 	f = alloc_fence();
@@ -119,23 +123,25 @@ static void test_for_each(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+
+	r = dma_resv_lock(resv, NULL);
 	if (r) {
 		KUNIT_FAIL(test, "Resv locking failed");
 		goto err_free;
 	}
 
-	r = dma_resv_reserve_fences(&resv, 1);
+	r = dma_resv_reserve_fences(resv, 1);
 	if (r) {
 		KUNIT_FAIL(test, "Resv shared slot allocation failed");
 		goto err_unlock;
 	}
 
-	dma_resv_add_fence(&resv, f, usage);
+	dma_resv_add_fence(resv, f, usage);
 
 	r = -ENOENT;
-	dma_resv_for_each_fence(&cursor, &resv, usage, fence) {
+	dma_resv_for_each_fence(&cursor, resv, usage, fence) {
 		if (!r) {
 			KUNIT_FAIL(test, "More than one fence found");
 			goto err_unlock;
@@ -158,9 +164,9 @@ static void test_for_each(struct kunit *test)
 	}
 	dma_fence_signal(f);
 err_unlock:
-	dma_resv_unlock(&resv);
+	dma_resv_unlock(resv);
 err_free:
-	dma_resv_put(&resv);
+	dma_resv_put(resv);
 	dma_fence_put(f);
 }
 
@@ -170,7 +176,7 @@ static void test_for_each_unlocked(struct kunit *test)
 	enum dma_resv_usage usage = param->usage;
 	struct dma_resv_iter cursor;
 	struct dma_fence *f, *fence;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	int r;
 
 	f = alloc_fence();
@@ -178,25 +184,27 @@ static void test_for_each_unlocked(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+
+	r = dma_resv_lock(resv, NULL);
 	if (r) {
 		KUNIT_FAIL(test, "Resv locking failed");
 		goto err_free;
 	}
 
-	r = dma_resv_reserve_fences(&resv, 1);
+	r = dma_resv_reserve_fences(resv, 1);
 	if (r) {
 		KUNIT_FAIL(test, "Resv shared slot allocation failed");
-		dma_resv_unlock(&resv);
+		dma_resv_unlock(resv);
 		goto err_free;
 	}
 
-	dma_resv_add_fence(&resv, f, usage);
-	dma_resv_unlock(&resv);
+	dma_resv_add_fence(resv, f, usage);
+	dma_resv_unlock(resv);
 
 	r = -ENOENT;
-	dma_resv_iter_begin(&cursor, &resv, usage);
+	dma_resv_iter_begin(&cursor, resv, usage);
 	dma_resv_for_each_fence_unlocked(&cursor, fence) {
 		if (!r) {
 			KUNIT_FAIL(test, "More than one fence found");
@@ -231,7 +239,7 @@ static void test_for_each_unlocked(struct kunit *test)
 	dma_resv_iter_end(&cursor);
 	dma_fence_signal(f);
 err_free:
-	dma_resv_put(&resv);
+	dma_resv_put(resv);
 	dma_fence_put(f);
 }
 
@@ -240,7 +248,7 @@ static void test_get_fences(struct kunit *test)
 	const struct dma_resv_usage_param *param = test->param_value;
 	enum dma_resv_usage usage = param->usage;
 	struct dma_fence *f, **fences = NULL;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	int r, i;
 
 	f = alloc_fence();
@@ -248,24 +256,26 @@ static void test_get_fences(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+
+	r = dma_resv_lock(resv, NULL);
 	if (r) {
 		KUNIT_FAIL(test, "Resv locking failed");
 		goto err_resv;
 	}
 
-	r = dma_resv_reserve_fences(&resv, 1);
+	r = dma_resv_reserve_fences(resv, 1);
 	if (r) {
 		KUNIT_FAIL(test, "Resv shared slot allocation failed");
-		dma_resv_unlock(&resv);
+		dma_resv_unlock(resv);
 		goto err_resv;
 	}
 
-	dma_resv_add_fence(&resv, f, usage);
-	dma_resv_unlock(&resv);
+	dma_resv_add_fence(resv, f, usage);
+	dma_resv_unlock(resv);
 
-	r = dma_resv_get_fences(&resv, usage, &i, &fences);
+	r = dma_resv_get_fences(resv, usage, &i, &fences);
 	if (r) {
 		KUNIT_FAIL(test, "get_fences failed");
 		goto err_free;
@@ -282,7 +292,7 @@ static void test_get_fences(struct kunit *test)
 		dma_fence_put(fences[i]);
 	kfree(fences);
 err_resv:
-	dma_resv_put(&resv);
+	dma_resv_put(resv);
 	dma_fence_put(f);
 }
 
-- 
2.43.0


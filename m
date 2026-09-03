Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1139DC79F85
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1A110F5EF;
	Thu,  3 Sep 2026 13:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DRG3yNha";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1CB10F5F7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 13:44:15 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so1563301f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788443054; x=1789047854; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CD9a3ia2fXGSFrB7/OAMwjwWKzwE2gfTckbIpnOOYNQ=;
 b=DRG3yNha2Lh2s1MQ0G//mspKmuh9XxHUwO6YTCCOwKeuUF8MF9nztV5MvTHqu11sGY
 M/ebI//UTZcohkk66YFE+NrVcJO9ZvKk+/Vr+lorU/hQr6TqfHzrcNnGfyWb21d49Xjl
 OLfNMjz3ZVPNXkzA9qYziCPfwkVqsK2Xrqh4LqjsoZDABgFoFTE2qrxT7WEhSUCEpOs0
 TnBVppI0jza5ykcN5N8dfDmp9Wdkg7YzTj0Yc6d0tbOF3rTadkoS3a1UXB1+oBy2Y0bJ
 pFEmYC7orixKSBWXEB8ElTg8bQoYb3iloHyRxSTdsgjRVBWV8nD++6SlU2KzbiRs2dak
 AWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443054; x=1789047854;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CD9a3ia2fXGSFrB7/OAMwjwWKzwE2gfTckbIpnOOYNQ=;
 b=abfTRkBCO99qIJFqV/a/WKKf0RSM7u79j1J3Q1GuXqnpUz43Drfdzl+tGmexj8Lulu
 BviuslIKL4G8RA2qCLmJFt8FC80woQkYt5ZZVMsJfQwCDacddk+YNSyRGT+fffTwz2qU
 V12yTVFz63xu9EKNPwHfAF+PSq/604HpsO380IrENyCzMMMEBQv4fy0qjIztDvraxyVV
 VYWKzAtbd0vK4XDySoV8SCNYBRMWgE+WFNYm3brKvZoTJseT24QVTHCXAzhgeJBjwI6z
 ab9ZmPyaerLvlqV9hmMu6I0OHBvJmqJrT+Oh81tMp47nTINHydVdcYIwNliGyRKPECy7
 4FzA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQ78gNX1DPRA5XSZ4rQ3+dBlqjwXdMIUQ+24OMMmPaOxjlxKaxXf8c4sGrY3xAT2j2cQw07jn4@lists.freedesktop.org
X-Gm-Message-State: AFuF++lPtjKyZL7HaP2FOFPqL6aap4nfe2d/gqYFpG/gVp4DvmNohwgl
 N6aTaSVz8yBjylMlm6g0eOQOdfCulMpF3dqNjNjhHOjYVZItcPyIoXde
X-Gm-Gg: AYBFou3XMkNBiXa5hNP/oRNfLt4/gEopBVFr1tROtsKHwYDIEDdgsdf+O0QvHrmhTic
 f6qW7mT5Tzr7MRoTBdPWtRnBEjPJRGmtvEQseTad0ZELL7LsjNNCz+cx0whjQoBjR1JcErXgFMw
 CUUwizbyhVEBoHZy0oEXVmSzezxT5FqF/C9xAZN/eT/j7N6f50wGc7KwiKQEGxTF+dPHj6nOIoR
 mUKdT82AeQR1/P/CqH6Q7UC8YtWLiBlD599Ee+VLGBj9eTTrHDeX10IXTs884FPjjbgJ/YFeDUO
 9NqYqaIdZya301RBn1wQ1dVMw73ty5sRvD+jfIO4SLZEoIgEz2YW9gniypZQ3H4noONB9td13pZ
 i8NFSRANayvcJ2G8eNDVq2z1V7JUXnLNcij2KtXl72pPEUJXHy8z6dDAMrvkg1WAFvttC1Uvyzi
 xQFzL3/ZTpqan6V6VZb360DqoIy4GUekfDiDIanrk83sUis9eoBsN+VrLmojKOennyoki7w3XYe
 A==
X-Received: by 2002:adf:e008:0:20b0:485:7ca5:b870 with SMTP id
 ffacd0b85a97d-4857ca5b8acmr12689972f8f.4.1788443053873; 
 Thu, 03 Sep 2026 06:44:13 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm13597080f8f.5.2026.09.03.06.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/11] dma-buf/tests: Convert st-dma-resv tests to use
 dma_resv_alloc v2
Date: Thu,  3 Sep 2026 15:27:58 +0200
Message-ID: <20260903134408.105317-4-christian.koenig@amd.com>
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

Update all test cases in st-dma-resv.c to use the new dma_resv_alloc()
API instead of stack-allocating dma_resv objects. This demonstrates the
proper usage of the new allocation and reference counting interface.

All five test functions now:
- Use dma_resv_alloc() to allocate objects
- Check for allocation failure with KUNIT_ASSERT_NOT_NULL
- Clean up with dma_resv_put() which handles freeing

This change also provides better test coverage for the reference
counting implementation.

v2: add proper error handling when dma_resv_alloc() fails

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/dma-buf/st-dma-resv.c | 102 +++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 40 deletions(-)

diff --git a/drivers/dma-buf/st-dma-resv.c b/drivers/dma-buf/st-dma-resv.c
index 2c43d2d2b016..48c158cc5011 100644
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
 
@@ -75,33 +77,38 @@ static void test_signaling(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	if (!resv) {
+		KUNIT_FAIL(test, "Resv allocation failed");
+		goto err_free;
+	}
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
 
@@ -111,7 +118,7 @@ static void test_for_each(struct kunit *test)
 	enum dma_resv_usage usage = param->usage;
 	struct dma_resv_iter cursor;
 	struct dma_fence *f, *fence;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	int r;
 
 	f = alloc_fence();
@@ -119,23 +126,28 @@ static void test_for_each(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	if (!resv) {
+		KUNIT_FAIL(test, "Resv allocation failed");
+		goto err_free;
+	}
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
@@ -158,9 +170,9 @@ static void test_for_each(struct kunit *test)
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
 
@@ -170,7 +182,7 @@ static void test_for_each_unlocked(struct kunit *test)
 	enum dma_resv_usage usage = param->usage;
 	struct dma_resv_iter cursor;
 	struct dma_fence *f, *fence;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	int r;
 
 	f = alloc_fence();
@@ -178,25 +190,30 @@ static void test_for_each_unlocked(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	if (!resv) {
+		KUNIT_FAIL(test, "Resv allocation failed");
+		goto err_free;
+	}
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
@@ -231,7 +248,7 @@ static void test_for_each_unlocked(struct kunit *test)
 	dma_resv_iter_end(&cursor);
 	dma_fence_signal(f);
 err_free:
-	dma_resv_put(&resv);
+	dma_resv_put(resv);
 	dma_fence_put(f);
 }
 
@@ -240,7 +257,7 @@ static void test_get_fences(struct kunit *test)
 	const struct dma_resv_usage_param *param = test->param_value;
 	enum dma_resv_usage usage = param->usage;
 	struct dma_fence *f, **fences = NULL;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	int r, i;
 
 	f = alloc_fence();
@@ -248,24 +265,29 @@ static void test_get_fences(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	if (!resv) {
+		KUNIT_FAIL(test, "Resv allocation failed");
+		goto err_resv;
+	}
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
@@ -282,7 +304,7 @@ static void test_get_fences(struct kunit *test)
 		dma_fence_put(fences[i]);
 	kfree(fences);
 err_resv:
-	dma_resv_put(&resv);
+	dma_resv_put(resv);
 	dma_fence_put(f);
 }
 
-- 
2.43.0


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F58606A320
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Nov 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qV0mMbut
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8178E10E0F6;
	Sun,  8 Nov 2026 15:02:43 +0000 (UTC)
Received: from mail-pi2-f6.google.com (mail-pi2-f6.google.com [74.125.227.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20AF010E256
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Nov 2026 05:23:49 +0000 (UTC)
Received: by mail-pi2-f6.google.com with SMTP id
 41be03b00d2f7-cdb536daf59so102845a12.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 07 Nov 2026 21:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794115428; x=1794720228; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nPcc1C6VpjmCET3tBtMp/wreo0ZSVB6OHb06Azdk0dk=;
 b=qV0mMbutnaItxUe5JxptVO5bLEfKpy6Vg3UERY7pMc85uKwt0wwQ6D0vhBihBzPs0T
 VEyOpesuDtuOg+QYK03E49SylxwOEcWzuvg2gMW4QJi7XWYTQNu0w2bYrAP5UpraiimJ
 tUnFNMsE3YTmEJkliwauXaebFUNMPkaxYp0Y1U77DXIeqrVAFfAKbLiEQwQc8UalLNZL
 12bfQlNHE8XQrvBTGLAe763d8AJWAOFC+c9EETZXZOlfWDNFyfdC2ax2EDyOPR1KP0Ex
 YRQL0CaT88LgnAlOCaqsKp+seckab0geM6NcPAWDGMWBzF9E9oI9aFDgx0Mg43pdTfXt
 qyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794115428; x=1794720228;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nPcc1C6VpjmCET3tBtMp/wreo0ZSVB6OHb06Azdk0dk=;
 b=1IEhgv9uLXQ468xk/8SYmg+0iQv1Q9cm/q78ufISo8xCicU7jpQZdb33J306T2YrQR
 O/lesyd09ERTqkx8RjHRR1R8GVydLfbONxWnzi867u9wS9qKCXvdb1+yCrsnX0jUpYbI
 G44qDgYu+KgG6XV+/ULksmCcc1mB1LfFamN/Lx0ch70u6HpaDxGO2afVWjJEOmNi5h9G
 UYN6ThnKsKGwccHTfqtCKKkEYJGKBDWmkEqGWg6+yIQHlM4h6xpCBkVrJEAi6thbt0D4
 Z6PYIhQ27CtCRfMcnaDs/dFMvNpmuHooY2HVtwVDExqZVt+OyFCIU4ODYithm2dK1y9M
 z0qg==
X-Forwarded-Encrypted: i=1;
 AL+hErE4oLqbHdDqx0V8qwrKWk229txCYcfQ6QrH9gfCEYcLn/EnT/iPSdKc99/poIhVb6xX7Yb3oQCR@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+J+PwuPOImXbBc4dHjiRYhjSEQhXrG3/4A3d4sCOE8I0Drxn/U
 VtYjHJcbUike/VzdoPdcEEqVai7TTJNBxFm+ku8UZ7rEx9WN9VgFOQLt
X-Gm-Gg: AYBFou3PWebfenzROxcIybp73XQ7dSS0EUXqBFAMPU6uqLBW5LyQ2da/v2c0ZOSoujL
 iwCzCFXlhYIeviALqTqKNR1JQZT/rUg6aCrGx7akKOl8jPgBeSRNTygT5VALcRMClEn17GWY8MP
 IS2v1pIuV4B36a0QpCXRApcPFIJiuKPDDPMBz0I5Y22eJykCcJzHtn9ZfqXZmFdxpYcRtbTiAfU
 kAfbrt1CRzZ/2JnyGqkx8YS6TC1riV3FU7iINZbcC5FE4IE3yfa2lmxsKb/SZMomGRPSojPIDvN
 0d3StIM8VCJbQMSSz8Mwp3htK5FHDCZLdOc5g5crp4pRHk2zLvnbuHL9QNbHjInKxcfxyroOPdn
 3X6bfQ2rOiVi7wdjyd25Kf2M5WPFyhEAS5BuXcKffa6ixX7B9L2oNhceS1D7RlC7cRxn6oGGlC7
 K0JDp0PbX0Qr57lHQ+xeIJLj5xaPxXi8e2mW5IC1p+zRwCt7vAsVOVX9csg1N52rQdT20LB7Ux3
 +wzVkh2/DfssXZ0J13m/CHmf5ZQQww8GPC6PKkzYuzAk8N5nf1V6f5hkJvpK/HoXzTDfofEip+M
 iFcMTnC7TfRdqyTOkSOhrnCsCvfcozb/NwwXBkHAy/bqABK0g8eXUd8yQhsxdl0w6G2T4cZ/J4+
 rTVC5l/5+uoCTWA868N4U+ygMBysvXVP5x2C0MsZxrSUH53A=
X-Received: by 2002:a05:6a00:3313:b0:890:a995:1f61 with SMTP id
 d2e1a72fcca58-8b66ef0603fmr596011b3a.15.1794115428353; 
 Sat, 07 Nov 2026 21:23:48 -0800 (PST)
Received: from [192.168.50.20] (42-98-155-143.static.netvigator.com.
 [42.98.155.143]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b646bd4af6sm281341b3a.2.2026.11.07.21.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 21:23:48 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Sun, 08 Nov 2026 16:13:33 +1100
Subject: [PATCH 1/2] drm/amdkfd: handle SVM interval notifier registration
 failures
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-kfd-svm-baseline-errors-20261107-v1-1-9ef4008019ab@gmail.com>
References: <20261108-kfd-svm-baseline-errors-20261107-v1-0-9ef4008019ab@gmail.com>
In-Reply-To: <20261108-kfd-svm-baseline-errors-20261107-v1-0-9ef4008019ab@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Philip Yang <Philip.Yang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, 
 honghuan@amd.com, honglei1.huang@amd.com, psirt@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Sun, 08 Nov 2026 15:02:42 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,SUBJECT_DRUG_GAP_L,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The first interval notifier registration for an mm can fail while
initializing the interval tree. svm_range_add_notifier_locked() ignores
that error, so SET_ATTR and retry-fault handling can publish an SVM range
without a registered notifier. Subsequent HMM access can then dereference
an uninitialized notifier.

Propagate the registration error and register staged ranges before
publishing the SET_ATTR transaction. Remove successful registrations on
failure before freeing the staged ranges, preserving the original ranges
and the existing memory-accounting rollback. Also free an unpublished
retry-fault range and return its registration error.

Fixes: b1c46c7d622b ("drm/amdkfd: validate svm range system memory")
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 56 +++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed5e3318877b..8184cbbb829e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -106,16 +106,21 @@ static void svm_range_unlink(struct svm_range *prange)
 		interval_tree_remove(&prange->it_node, &prange->svms->objects);
 }
 
-static void
+static int
 svm_range_add_notifier_locked(struct mm_struct *mm, struct svm_range *prange)
 {
+	int r;
+
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms,
 		 prange, prange->start, prange->last);
 
-	mmu_interval_notifier_insert_locked(&prange->notifier, mm,
+	r = mmu_interval_notifier_insert_locked(&prange->notifier, mm,
 				     prange->start << PAGE_SHIFT,
 				     prange->npages << PAGE_SHIFT,
 				     &svm_range_mn_ops);
+	if (r)
+		prange->notifier.mm = NULL;
+	return r;
 }
 
 /**
@@ -2257,6 +2262,7 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
 /**
  * svm_range_add - add svm range and handle overlap
  * @p: the range add to this process svms
+ * @mm: the process address space, write locked by the caller
  * @start: page size aligned
  * @size: page size aligned
  * @nattr: number of attributes
@@ -2285,7 +2291,8 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
  * 0 - OK, otherwise error code
  */
 static int
-svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
+svm_range_add(struct kfd_process *p, struct mm_struct *mm,
+	      uint64_t start, uint64_t size,
 	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
 	      struct list_head *update_list, struct list_head *insert_list,
 	      struct list_head *remove_list, struct list_head *remap_list)
@@ -2373,17 +2380,38 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	}
 
 	/* add a final range at the end if needed */
-	if (start <= last)
+	if (start <= last) {
 		r = svm_range_split_new(svms, start, last,
 					READ_ONCE(max_svm_range_pages),
 					&new_list, update_list);
+		if (r)
+			goto out;
+	}
+
+	/* Register all notifiers before publishing any of the new ranges. */
+	list_for_each_entry(prange, &new_list, list) {
+		r = svm_range_add_notifier_locked(mm, prange);
+		if (r)
+			goto out;
+	}
+	list_for_each_entry(prange, insert_list, list) {
+		r = svm_range_add_notifier_locked(mm, prange);
+		if (r)
+			goto out;
+	}
 
 out:
 	if (r) {
-		list_for_each_entry_safe(prange, tmp, insert_list, list)
+		list_for_each_entry_safe(prange, tmp, insert_list, list) {
+			if (prange->notifier.mm)
+				mmu_interval_notifier_remove(&prange->notifier);
 			svm_range_free(prange, false);
-		list_for_each_entry_safe(prange, tmp, &new_list, list)
+		}
+		list_for_each_entry_safe(prange, tmp, &new_list, list) {
+			if (prange->notifier.mm)
+				mmu_interval_notifier_remove(&prange->notifier);
 			svm_range_free(prange, true);
+		}
 	} else {
 		list_splice(&new_list, insert_list);
 	}
@@ -3011,8 +3039,12 @@ svm_range *svm_range_create_unregistered_range(struct kfd_node *node,
 	if (is_heap_stack)
 		prange->preferred_loc = KFD_IOCTL_SVM_LOCATION_SYSMEM;
 
+	r = svm_range_add_notifier_locked(mm, prange);
+	if (r) {
+		svm_range_free(prange, true);
+		return ERR_PTR(r);
+	}
 	svm_range_add_to_svms(prange);
-	svm_range_add_notifier_locked(mm, prange);
 
 	return prange;
 }
@@ -3203,11 +3235,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			goto retry_write_locked;
 		}
 		prange = svm_range_create_unregistered_range(node, p, mm, addr);
-		if (!prange) {
+		if (IS_ERR_OR_NULL(prange)) {
 			pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
 				 svms, addr);
 			mmap_write_downgrade(mm);
-			r = -EFAULT;
+			r = prange ? PTR_ERR(prange) : -EFAULT;
 			goto out_unlock_svms;
 		}
 	}
@@ -3839,7 +3871,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	mutex_lock(&svms->lock);
 
 	/* Add new range and split existing ranges as needed */
-	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
+	r = svm_range_add(p, mm, start, size, nattr, attrs, &update_list,
 			  &insert_list, &remove_list, &remap_list);
 	if (r) {
 		mutex_unlock(&svms->lock);
@@ -3847,10 +3879,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		goto out;
 	}
 	/* Apply changes as a transaction */
-	list_for_each_entry_safe(prange, next, &insert_list, list) {
+	list_for_each_entry_safe(prange, next, &insert_list, list)
 		svm_range_add_to_svms(prange);
-		svm_range_add_notifier_locked(mm, prange);
-	}
 
 	list_for_each_entry(prange, &update_list, update_list)
 		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);

-- 
2.56.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3F3C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 13:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA08310E3EF;
	Tue, 15 Nov 2022 13:39:10 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6766F10E3EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 13:38:58 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id d9so19599081wrm.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 05:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D01ueQCn0m3t6f6wDD2p/wYCPMfQBqENpr9DvZb0XPY=;
 b=C18CVoyIa6sDIcmtXKWIm8wP2nYAD+T3bzxYxVgROstUdjPXBbB06BKLGwm2lyAT+p
 fTDdH5K5SWAuqeAuiv/qcK5o2p3aBqffFgebijsLNa6MrqBAcjN2jPuyN3l/C5CxN9ab
 XP46s3l45tVC5hf5b9gdSxAku+GUqJ5Eey1TQJhvVeg+3/6V8me9jDG/tEw8JmIrWFZy
 nRxO4aZFlC+G86tfq2ElSSmM3KUI3YA33ET5ZH9eb9UoB30JE9VMVOyBbhNIeN+/cVA8
 EltlUJO90Eb9LsrXkIrEmWo6V+wXkSS2Oipm23u5pKnb+iZWIZlP+vE2hxRbLnc4RX89
 ZAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D01ueQCn0m3t6f6wDD2p/wYCPMfQBqENpr9DvZb0XPY=;
 b=zTP74HlTzIGnjgUz0Q969hE3OU/OsQ/DgnjYNkewHOsw2oK7/YEsgiWNXMmWmwz3PF
 /JHW8fJNzZMBzgMczXXjmvL+BH5FpGV9kT0EEzP+s/NNyjdqjLDaKUDF18vBuqGOd04f
 n/g8aBBGUE5CHtJxt+jQ9F8dv25Iyhy2e4YPYgR8zg2G6uZVwA3amVmZ7xTDfH9QvEC+
 KRMyhD4n0Um5Q4zClDwFfE7aEGWyq90szgDFLanUW707YSOR3uEz60qopaHuOpd/cqOX
 JjZWDQ8Ulska+snfFwLdEE1JaBlb60DZMWSSRMNBp++JS8py2k5Jj8+DgNU64uqHjuir
 /g0A==
X-Gm-Message-State: ANoB5plkireehxPVNrjbWz/4Ur6bys4g7ioVX/uTB2rtxCBuLXlgVizO
 A5ZF7EuZ9NwPouaekzK9DZM=
X-Google-Smtp-Source: AA0mqf4RgylAcZ9Y0Nop4I9hNy5hw1mHYj8OlloZVQWxdgLo8MNaoEfNmr5gskE/MPCdneYvnLSYug==
X-Received: by 2002:a05:6000:9:b0:236:bd21:44a with SMTP id
 h9-20020a056000000900b00236bd21044amr11437602wrx.616.1668519538040; 
 Tue, 15 Nov 2022 05:38:58 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a1c3507000000b003c6f1732f65sm20405469wma.38.2022.11.15.05.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Nov 2022 05:38:57 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: mikhail.v.gavrilov@gmail.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: cleanup amdgpu_hmm_range_get_pages
Date: Tue, 15 Nov 2022 14:38:53 +0100
Message-Id: <20221115133853.7950-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115133853.7950-1-christian.koenig@amd.com>
References: <20221115133853.7950-1-christian.koenig@amd.com>
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

Remove unused parameters and cleanup dead code.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 14 +++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h |  7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  5 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  6 +++---
 4 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index a68072f766c7..a48ea62b12b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -158,10 +158,9 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
 }
 
 int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
-			       struct mm_struct *mm, struct page **pages,
-			       uint64_t start, uint64_t npages,
-			       struct hmm_range **phmm_range, bool readonly,
-			       bool mmap_locked, void *owner)
+			       uint64_t start, uint64_t npages, bool readonly,
+			       void *owner, struct page **pages,
+			       struct hmm_range **phmm_range)
 {
 	struct hmm_range *hmm_range;
 	unsigned long timeout;
@@ -194,14 +193,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 
 retry:
 	hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
-
-	if (likely(!mmap_locked))
-		mmap_read_lock(mm);
-
 	r = hmm_range_fault(hmm_range);
-
-	if (likely(!mmap_locked))
-		mmap_read_unlock(mm);
 	if (unlikely(r)) {
 		/*
 		 * FIXME: This timeout should encompass the retry from
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
index 4e596a16d288..13ed94d3b01b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
@@ -31,10 +31,9 @@
 #include <linux/interval_tree.h>
 
 int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
-			       struct mm_struct *mm, struct page **pages,
-			       uint64_t start, uint64_t npages,
-			       struct hmm_range **phmm_range, bool readonly,
-			       bool mmap_locked, void *owner);
+			       uint64_t start, uint64_t npages, bool readonly,
+			       void *owner, struct page **pages,
+			       struct hmm_range **phmm_range);
 int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
 
 #if defined(CONFIG_HMM_MIRROR)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8f5ceab43882..5cc9b9528afc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -691,9 +691,8 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
 	}
 
 	readonly = amdgpu_ttm_tt_is_readonly(ttm);
-	r = amdgpu_hmm_range_get_pages(&bo->notifier, mm, pages, start,
-				       ttm->num_pages, range, readonly,
-				       true, NULL);
+	r = amdgpu_hmm_range_get_pages(&bo->notifier, start, ttm->num_pages,
+				       readonly, NULL, pages, range);
 out_unlock:
 	mmap_read_unlock(mm);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d069e6c096b6..2dc3b04064bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1596,9 +1596,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		next = min(vma->vm_end, end);
 		npages = (next - addr) >> PAGE_SHIFT;
 		WRITE_ONCE(p->svms.faulting_task, current);
-		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
-					       addr, npages, &hmm_range,
-					       readonly, true, owner);
+		r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
+					       readonly, owner, NULL,
+					       &hmm_range);
 		WRITE_ONCE(p->svms.faulting_task, NULL);
 		if (r) {
 			pr_debug("failed %d to get svm range pages\n", r);
-- 
2.34.1


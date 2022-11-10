Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0D9C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 13:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15C610E791;
	Thu, 10 Nov 2022 13:00:22 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF18310E78E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 13:00:17 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 m7-20020a05600c090700b003cf8a105d9eso1083971wmp.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 05:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjS531zWog5BKsAuxNoMdOZgA/BQbBksbRCdfm1G87w=;
 b=HOUy3M7/LsCOnw4dJFN6dhrcqG3jWlSgYlcDsH/h2a1ZW1pnWTSz4ajEG9B9edK244
 qATknMK6YXuu6hgylUU/kp8I/unlVEIzPquXCXnkZFsE7tri/FTZ6dIK7TtsJyafdDop
 O3X6qw2nQ11jxzjhI1PRNjmY+A1hLYTzqxdz894BRciWGg3DofF7v8/WBG8MfZ1qqYg0
 b8jlQKi5EIB5LH/+lUNRj2/ZIvYPqMXPO4pyoXTAOZAKxfuxojBBylCAmqhRQH2J2uFX
 UrrZr/Uf+MaRGlNstNKyXoHXqcElj3Asy3d/sRYCpvPNFfeSv7G6t9u7nf4PqCcAwIDm
 +dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjS531zWog5BKsAuxNoMdOZgA/BQbBksbRCdfm1G87w=;
 b=nH6zalolnQsLi5AGEzViKiPvlqNmkVSeTj3jvwX08FBimfL3BzEWUIFYY2TIksfleH
 c59R1a2sF2/akMgWkgtlx4WjvDXfHeI4Dft27vo3M+Ww2XeQffxtoL0TY8yGWoRf0ICR
 0k7FXaXDg8Hokra08d+Ybg1vsK/e2Er6yvvOH2ljGJSruhQWlS45/Rd7F4kAdA7ylPC4
 7a+azziEMCQ4ifUtv7+uw94wLWeDrY7KQzBkUVd4koqiaJzmiBT13lNXG1agx9cwR11o
 DBZPwn6gqLZ2DPaEG+obXPqpK+G8KGMAzLbTHx7NQuJ9H7/7CdDp+3TYNC2Vkwft3pNV
 Kz2Q==
X-Gm-Message-State: ACrzQf2ZGqNV352KX721hD+0pPU0ueY4uF10eVuaqGcqOJtJQdmFg/56
 meEw0XTN6CjiRpy/4fCTc76ufwBqLPc=
X-Google-Smtp-Source: AMsMyM5zIEnjKHkgGzqE/A3RMq1y+GuPa+1gj77qCHR+/6Z0M98s213E3Q7bSAqjhaIx5AmyE0W3Og==
X-Received: by 2002:a1c:acc5:0:b0:3c6:eebf:feee with SMTP id
 v188-20020a1cacc5000000b003c6eebffeeemr43948073wme.122.1668085216247; 
 Thu, 10 Nov 2022 05:00:16 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 az11-20020a05600c600b00b003b4cba4ef71sm5318965wmb.41.2022.11.10.05.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Nov 2022 05:00:15 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: cleanup amdgpu_hmm_range_get_pages
Date: Thu, 10 Nov 2022 14:00:09 +0100
Message-Id: <20221110130009.1835-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110130009.1835-1-christian.koenig@amd.com>
References: <20221110130009.1835-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused parameters and cleanup dead code.

Signed-off-by: Christian König <christian.koenig@amd.com>
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
index 0668b09d7394..804eb04cac2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -688,9 +688,8 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
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


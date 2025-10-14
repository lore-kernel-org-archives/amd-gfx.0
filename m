Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6C5CCD187
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 07:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E9710E0B5;
	Tue, 14 Oct 2025 07:43:58 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCF110E0B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 07:43:56 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 59E7hj69421373; Tue, 14 Oct 2025 13:13:45 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 59E7hjJE421366;
 Tue, 14 Oct 2025 13:13:45 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v1] drm/amdgpu: add the kernel docs for alloc/free/valid range
Date: Tue, 14 Oct 2025 13:13:37 +0530
Message-Id: <20251014074337.421304-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

add kernel docs for the functions related to hmm_range.

functions:
amdgpu_hmm_range_valid
amdgpu_hmm_range_alloc
amdgpu_hmm_range_free

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 04f02e0c8bb3..419f0dbb38ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -227,6 +227,19 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	return r;
 }
 
+/**
+ * amdgpu_hmm_range_valid - check if an HMM range is still valid
+ * @range: pointer to the &struct amdgpu_hmm_range to validate
+ *
+ * Determines whether the given HMM range @range is still valid by
+ * checking for invalidations via the MMU notifier sequence. This is
+ * typically used to verify that the range has not been invalidated
+ * by concurrent address space updates before it is accessed.
+ *
+ * Return:
+ * * true if @range is valid and can be used safely
+ * * false if @range is NULL or has been invalidated
+ */
 bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
 {
 	if (!range)
@@ -236,6 +249,19 @@ bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
 					range->hmm_range.notifier_seq);
 }
 
+/**
+ * amdgpu_hmm_range_alloc - allocate and initialize an AMDGPU HMM range
+ * @bo: buffer object to associate with this HMM range
+ *
+ * Allocates memory for amdgpu_hmm_range and associates it with the @bo passed.
+ * The reference count of the @bo is incremented.
+ * In case the @bo is passed as NULL, caller is responsible of taking care of
+ * the reference of associated bo.
+ *
+ * Return:
+ * Pointer to a newly allocated struct amdgpu_hmm_range on success,
+ * or NULL if memory allocation fails.
+ */
 struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
 {
 	struct amdgpu_hmm_range *range;
@@ -248,6 +274,15 @@ struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
 	return range;
 }
 
+/**
+ * amdgpu_hmm_range_free - release an AMDGPU HMM range
+ * @range: pointer to the range object to free
+ *
+ * Releases all resources held by @range, including the associated
+ * hmm_pfns and the dropping reference of associated bo.
+ *
+ * Return: void
+ */
 void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
 {
 	if (!range)
-- 
2.34.1


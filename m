Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DC1CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 19:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB53310E220;
	Fri, 24 Oct 2025 19:07:14 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6AFA10E220
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 19:07:12 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 59OJ72aS2343968; Sat, 25 Oct 2025 00:37:02 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 59OJ71l02343961;
 Sat, 25 Oct 2025 00:37:01 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v3] drm/amdkfd: fix the clean up when amdgpu_hmm_range_alloc
 fails
Date: Sat, 25 Oct 2025 00:37:01 +0530
Message-Id: <20251024190701.2343948-1-sunil.khatri@amd.com>
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

we need to unreserve the bo's too during clean up along
with freeing the memory of context.

Fixes: c549912cd8 (drm/amdkfd: add missing return value check for range)
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7f0ab73e2396..35c592024a01 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1738,14 +1738,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 			WRITE_ONCE(p->svms.faulting_task, current);
 			range = amdgpu_hmm_range_alloc(NULL);
-			if (unlikely(!range)) {
-				r = -ENOMEM;
-				goto free_ctx;
-			}
-
-			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
+			if (likely(range))
+				r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
 						       readonly, owner,
 						       range);
+			else
+				r = -ENOMEM;
 			WRITE_ONCE(p->svms.faulting_task, NULL);
 			if (r) {
 				amdgpu_hmm_range_free(range);
-- 
2.34.1


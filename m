Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B03CCF9E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 12:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC77410E3B2;
	Tue, 28 Oct 2025 12:13:46 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D903010E3BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 12:13:44 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 59SCDYTg3023072; Tue, 28 Oct 2025 17:43:34 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 59SCDYAs3023071;
 Tue, 28 Oct 2025 17:43:34 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v2 1/2] drm/amdkfd: clean up the code to free hmm_range
Date: Tue, 28 Oct 2025 17:43:29 +0530
Message-Id: <20251028121330.3023032-1-sunil.khatri@amd.com>
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

a. hmm_range is either NULL or a valid pointer so we
do not need to set range to NULL ever.

b. keep the hmm_range_free in the end irrespective of
the other conditions to avoid some additional checks
and also avoid double free issue.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ffb7b36e577c..fb3daa7cd326 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1744,11 +1744,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			else
 				r = -ENOMEM;
 			WRITE_ONCE(p->svms.faulting_task, NULL);
-			if (r) {
-				amdgpu_hmm_range_free(range);
-				range = NULL;
+			if (r)
 				pr_debug("failed %d to get svm range pages\n", r);
-			}
 		} else {
 			r = -EFAULT;
 		}
@@ -1767,14 +1764,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		 * Override return value to TRY AGAIN only if prior returns
 		 * were successful
 		 */
-		if (range && !amdgpu_hmm_range_valid(range) && !r) {
+		if (range && !amdgpu_hmm_range_valid(range) && !r ) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 		}
-		/* Free the hmm range */
-		if (range)
-			amdgpu_hmm_range_free(range);
 
+		/* Free the hmm range */
+		amdgpu_hmm_range_free(range);
 
 		if (!r && !list_empty(&prange->child_list)) {
 			pr_debug("range split by unmap in parallel, validate again\n");
-- 
2.34.1


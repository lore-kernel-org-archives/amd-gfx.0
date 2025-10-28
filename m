Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7257CCD1BF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 08:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A7710E5AC;
	Tue, 28 Oct 2025 08:23:19 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF2310E5AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 08:23:17 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 59S8NCcN2842035; Tue, 28 Oct 2025 13:53:12 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 59S8NCYe2842006;
 Tue, 28 Oct 2025 13:53:12 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v1] drm/amdkfd: use function return value for clean exit
Date: Tue, 28 Oct 2025 13:53:11 +0530
Message-Id: <20251028082311.2841813-1-sunil.khatri@amd.com>
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

Instead of setting range=NULL and using that for a cleaner
exit on failure better to use the return value r for cleanup
and proper return.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ffb7b36e577c..b036e22e0ec0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1746,7 +1746,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			WRITE_ONCE(p->svms.faulting_task, NULL);
 			if (r) {
 				amdgpu_hmm_range_free(range);
-				range = NULL;
 				pr_debug("failed %d to get svm range pages\n", r);
 			}
 		} else {
@@ -1767,12 +1766,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		 * Override return value to TRY AGAIN only if prior returns
 		 * were successful
 		 */
-		if (range && !amdgpu_hmm_range_valid(range) && !r) {
+		if (!r && range && !amdgpu_hmm_range_valid(range) ) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 		}
 		/* Free the hmm range */
-		if (range)
+		if (r)
 			amdgpu_hmm_range_free(range);
 
 
-- 
2.34.1


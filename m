From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] GPU-DRM-Radeon: Use seq_putc() in
 radeon_sa_bo_dump_debug_info()
Date: Tue, 2 May 2017 22:06:35 +0200
Message-ID: <a3bf9b46-ca44-d9b3-d0de-bf580fbf265b@users.sourceforge.net>
References: <74d2df52-f509-e6d2-5b35-e25b7cbd1fbe@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <74d2df52-f509-e6d2-5b35-e25b7cbd1fbe@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 May 2017 21:35:48 +0200

A few single characters should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/radeon/radeon_sa.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_sa.c b/drivers/gpu/drm/radeon/radeon_sa.c
index 197b157b73d0..67bc3618798d 100644
--- a/drivers/gpu/drm/radeon/radeon_sa.c
+++ b/drivers/gpu/drm/radeon/radeon_sa.c
@@ -406,18 +406,15 @@ void radeon_sa_bo_dump_debug_info(struct radeon_sa_manager *sa_manager,
 	list_for_each_entry(i, &sa_manager->olist, olist) {
 		uint64_t soffset = i->soffset + sa_manager->gpu_addr;
 		uint64_t eoffset = i->eoffset + sa_manager->gpu_addr;
-		if (&i->olist == sa_manager->hole) {
-			seq_printf(m, ">");
-		} else {
-			seq_printf(m, " ");
-		}
+
+		seq_putc(m, (&i->olist == sa_manager->hole) ? '>' : ' ');
 		seq_printf(m, "[0x%010llx 0x%010llx] size %8lld",
 			   soffset, eoffset, eoffset - soffset);
 		if (i->fence) {
 			seq_printf(m, " protected by 0x%016llx on ring %d",
 				   i->fence->seq, i->fence->ring);
 		}
-		seq_printf(m, "\n");
+		seq_putc(m, '\n');
 	}
 	spin_unlock(&sa_manager->wq.lock);
 }
-- 
2.12.2


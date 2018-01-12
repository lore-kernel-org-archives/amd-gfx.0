From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] drm/amdgpu: Use seq_putc() in two functions
Date: Fri, 12 Jan 2018 22:22:51 +0100
Message-ID: <c7ec76b3-3020-80c3-1f43-5f29714f87f2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Alex Xie <AlexBin.Xie@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Junwei Zhang <Jerry.Zhang@amd.com>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@amd.com>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nicolai.haehnle@amd.com>, Yong Zhao <Yong.Zhao@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 12 Jan 2018 22:08:50 +0100

A few single characters should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c  | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 10805edcf964..7ac233f5abe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -806,8 +806,8 @@ static int amdgpu_debugfs_gem_bo_info(int id, void *ptr, void *data)
 	pin_count = READ_ONCE(bo->pin_count);
 	if (pin_count)
 		seq_printf(m, " pin count %d", pin_count);
-	seq_printf(m, "\n");
 
+	seq_putc(m, '\n');
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index 3144400435b7..57ce42d960ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -419,11 +419,8 @@ void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
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
 
@@ -431,7 +428,7 @@ void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
 			seq_printf(m, " protected by 0x%08x on context %llu",
 				   i->fence->seqno, i->fence->context);
 
-		seq_printf(m, "\n");
+		seq_putc(m, '\n');
 	}
 	spin_unlock(&sa_manager->wq.lock);
 }
-- 
2.15.1

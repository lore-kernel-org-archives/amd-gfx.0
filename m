From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amdkfd: fix null pointer dereference on dev
Date: Wed, 29 May 2019 16:07:34 +0100
Message-ID: <20190529150734.18120-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Oak Zeng <Oak.Zeng@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The pointer dev is set to null yet it is being dereferenced when
checking dev->dqm->sched_policy.  Fix this by performing the check
on dev->dqm->sched_policy after dev has been assigned and null
checked.  Also remove the redundant null assignment to dev.

Addresses-Coverity: ("Explicit null dereference")
Fixes: 1a058c337676 ("drm/amdkfd: New IOCTL to allocate queue GWS")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index aab2aa6c1dee..ea82828fdc76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1572,10 +1572,9 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
 {
 	int retval;
 	struct kfd_ioctl_alloc_queue_gws_args *args = data;
-	struct kfd_dev *dev = NULL;
+	struct kfd_dev *dev;
 
-	if (!hws_gws_support ||
-		dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
+	if (!hws_gws_support)
 		return -EINVAL;
 
 	dev = kfd_device_by_id(args->gpu_id);
@@ -1583,6 +1582,8 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
 		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
 		return -EINVAL;
 	}
+	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
+		return -EINVAL;
 
 	mutex_lock(&p->mutex);
 	retval = pqm_set_gws(&p->pqm, args->queue_id, args->num_gws ? dev->gws : NULL);
-- 
2.20.1

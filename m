From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] drm/amdkfd: fix typing in (*hqd_destroy)
Date: Tue, 24 Apr 2018 15:14:16 +0200
Message-ID: <20180424131416.1702-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

The method (*hqd_destroy) is defined as using an 'uint32_t'
as 3rd argument but the the actual implementation of this
method and all its calls actually uses an 'enum kfd_preempt_type'
for this argument.

Fix this by using 'enum kfd_preempt_type' for (*hqd_destroy) too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 237289a72..2890e8581 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -298,7 +298,7 @@ struct kfd2kgd_calls {
 	bool (*hqd_is_occupied)(struct kgd_dev *kgd, uint64_t queue_address,
 				uint32_t pipe_id, uint32_t queue_id);
 
-	int (*hqd_destroy)(struct kgd_dev *kgd, void *mqd, uint32_t reset_type,
+	int (*hqd_destroy)(struct kgd_dev *kgd, void *mqd, enum kfd_preempt_type reset_type,
 				unsigned int timeout, uint32_t pipe_id,
 				uint32_t queue_id);
 
-- 
2.17.0

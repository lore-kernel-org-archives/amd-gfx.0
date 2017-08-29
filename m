From: Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] drm/amdkfd: remove memset before memcpy
Date: Wed, 30 Aug 2017 00:33:35 +0530
Message-ID: <1504033415-25608-1-git-send-email-himanshujha199640@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie
Cc: alexander.deucher@amd.com, oded.gabbay@gmail.com, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

calling memcpy immediately after memset with the same region of memory
makes memset redundant.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 1cae95e..03bec76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -143,7 +143,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	int num_queues = 0;
 	struct queue *cur;
 
-	memset(&q_properties, 0, sizeof(struct queue_properties));
 	memcpy(&q_properties, properties, sizeof(struct queue_properties));
 	q = NULL;
 	kq = NULL;
-- 
2.7.4

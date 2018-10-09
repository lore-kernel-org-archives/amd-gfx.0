From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdkfd: Remove set but not used variable 'preempt_all_queues'
Date: Tue, 9 Oct 2018 01:53:00 +0000
Message-ID: <1539049980-186978-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: oded.gabbay@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c: In function 'destroy_queue_cpsch':
drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:1366:7: warning:
 variable 'preempt_all_queues' set but not used [-Wunused-but-set-variable]

It never used since introduct in 
commit 992839ad64f2 ("drm/amdkfd: Add static user-mode queues support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4f22e74..06d38b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1363,9 +1363,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 {
 	int retval;
 	struct mqd_manager *mqd_mgr;
-	bool preempt_all_queues;
-
-	preempt_all_queues = false;
 
 	retval = 0;

From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] drm/amdkfd: Make function kfd_dev_is_large_bar() static
Date: Fri, 30 Mar 2018 02:25:27 +0000
Message-ID: <1522376727-136554-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: oded.gabbay@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes the following sparse warning:

drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:1150:6: warning:
 symbol 'kfd_dev_is_large_bar' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cd679cf..fb5d997 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1147,7 +1147,7 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
 	return ret;
 }
 
-bool kfd_dev_is_large_bar(struct kfd_dev *dev)
+static bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 {
 	struct kfd_local_mem_info mem_info;

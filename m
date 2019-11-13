From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 3/7] drm/amdgpu: remove set but not used variable 'count'
Date: Wed, 13 Nov 2019 20:44:30 +0800
Message-ID: <1573649074-72589-4-git-send-email-yukuai3@huawei.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Rex.Zhu@amd.com, evan.quan@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdkfd/kfd_device.c: In function
‘kgd2kfd_post_reset’:
drivers/gpu/drm/amd/amdkfd/kfd_device.c:745:11: warning:
variable ‘count’ set but not used [-Wunused-but-set-variable]

'count' is never used, so can be removed. Thus 'atomic_dec_return'
can be replaced as 'atomic_dec'

Fixes: e42051d2133b ("drm/amdkfd: Implement GPU reset handlers in KFD")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 4fa8834..209bfc8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -742,7 +742,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 
 int kgd2kfd_post_reset(struct kfd_dev *kfd)
 {
-	int ret, count;
+	int ret;
 
 	if (!kfd->init_complete)
 		return 0;
@@ -750,7 +750,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	ret = kfd_resume(kfd);
 	if (ret)
 		return ret;
-	count = atomic_dec_return(&kfd_locked);
+	atomic_dec(&kfd_locked);
 
 	atomic_set(&kfd->sram_ecc_flag, 0);
 
-- 
2.7.4

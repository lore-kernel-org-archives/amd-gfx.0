From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 4/7] drm/amdgpu: remove set but not used variable 'invalid'
Date: Wed, 13 Nov 2019 20:44:31 +0800
Message-ID: <1573649074-72589-5-git-send-email-yukuai3@huawei.com>
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

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c: In function
‘amdgpu_amdkfd_evict_userptr’:
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:1665:6: warning:
variable ‘invalid’ set but not used [-Wunused-but-set-variable]

'invalid' is never used, so can be removed. Thus 'atomic_inc_return'
can be replaced as 'atomic_inc'

Fixes: 5ae0283e831a ("drm/amdgpu: Add userptr support for KFD")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ae6f544..a1ed8a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1662,10 +1662,10 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
 				struct mm_struct *mm)
 {
 	struct amdkfd_process_info *process_info = mem->process_info;
-	int invalid, evicted_bos;
+	int evicted_bos;
 	int r = 0;
 
-	invalid = atomic_inc_return(&mem->invalid);
+	atomic_inc(&mem->invalid);
 	evicted_bos = atomic_inc_return(&process_info->evicted_bos);
 	if (evicted_bos == 1) {
 		/* First eviction, stop the queues */
-- 
2.7.4

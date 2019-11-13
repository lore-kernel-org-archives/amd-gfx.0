From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 0/7] various '-Wunused-but-set-variable' gcc warning fixes
Date: Wed, 13 Nov 2019 20:44:27 +0800
Message-ID: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Rex.Zhu@amd.com, evan.quan@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

This patch set fixes various unrelated gcc '-Wunused-but-set-variable'
warnings.

yu kuai (7):
  drm/amdgpu: remove set but not used variable 'mc_shared_chmap' from
    'gfx_v6_0.c' and 'gfx_v7_0.c'
  drm/amdgpu: remove set but not used variable 'amdgpu_connector'
  drm/amdgpu: remove set but not used variable 'count'
  drm/amdgpu: remove set but not used variable 'invalid'
  drm/amdgpu: remove set but not used variable 'threshold'
  drm/amdgpu: remove set but not used variable 'state'
  drm/amdgpu: remove set but not used variable 'us_mvdd'

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c         |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c               |  3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c               |  3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c             |  4 ++--
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c  |  7 ++-----
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 12 ------------
 7 files changed, 8 insertions(+), 27 deletions(-)

-- 
2.7.4

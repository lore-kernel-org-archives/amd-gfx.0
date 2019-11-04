From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 0/7] fix various gcc warnings
Date: Mon, 4 Nov 2019 21:27:19 +0800
Message-ID: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Jammy.Zhou@amd.com, tianci.yin@amd.com, sam@ravnborg.org, luben.tuikov@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

This patch set fixes various gcc warnings. 

yu kuai (7):
  drm/amdgpu: remove 4 set but not used variable in
    amdgpu_atombios_get_connector_info_from_object_table
  drm/amdgpu: add function parameter description in
    'amdgpu_device_set_cg_state'
  drm/amdgpu: add function parameter description in 'amdgpu_gart_bind'
  drm/amdgpu: remove set but not used variable 'dig_connector'
  drm/amdgpu: remove set but not used variable 'dig'
  drm/amdgpu: remove always false comparison in
    'amdgpu_atombios_i2c_process_i2c_ch'
  drm/amdgpu: remove set but not used variable 'mc_shared_chmap'

 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 20 ++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c     |  5 -----
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c    |  5 -----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c        |  3 +--
 6 files changed, 5 insertions(+), 30 deletions(-)

-- 
2.7.4

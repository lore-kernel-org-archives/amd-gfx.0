From: Wambui Karuga <wambui.karugax@gmail.com>
Subject: [Outreachy][PATCH 0/2] sparse warning cleanup
Date: Mon, 28 Oct 2019 12:20:03 +0300
Message-ID: <20191028092005.31121-1-wambui.karugax@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, outreachy-kernel@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

This patchset addresses the sparse warning about the
`amdgpu_exp_hw_support` variable and corrects the mispelling of the
word "_LENTH".

Wambui Karuga (2):
  drm/amd: declare amdgpu_exp_hw_support in amdgpu.h
  drm/amd: correct "_LENTH" mispelling in constant

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.17.1

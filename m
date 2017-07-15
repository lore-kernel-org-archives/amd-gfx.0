From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/5] constify drm pci_device_id
Date: Sat, 15 Jul 2017 12:42:17 +0530
Message-ID: <1500102738-23274-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie, amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

Arvind Yadav (5):
  [PATCH 1/5] drm: radeon: constify pci_device_id.
  [PATCH 2/5] drm: vmwgfx: constify pci_device_id.
  [PATCH 3/5] drm: nouveau: constify pci_device_id.
  [PATCH 4/5] drm: via: constify pci_device_id.
  [PATCH 5/5] drm: hisilicon: constify pci_device_id.

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c           | 2 +-
 drivers/gpu/drm/radeon/radeon_drv.c             | 2 +-
 drivers/gpu/drm/via/via_drv.c                   | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c             | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.7.4

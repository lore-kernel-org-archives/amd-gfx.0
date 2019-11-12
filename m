From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH V3 0/3] drm: replace magic numbers
Date: Tue, 12 Nov 2019 11:35:00 -0600
Message-ID: <20191112173503.176611-1-helgaas@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Frederick Lawler <fred@fredlawl.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>, linux-pci@vger.kernel.org, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: amd-gfx.lists.freedesktop.org

From: Bjorn Helgaas <bhelgaas@google.com>

amdgpu and radeon do a bit of mucking with the PCIe Link Control 2
register, some of it using hard-coded magic numbers.  The idea here is to
replace those with #defines.

Since v2:
  - Fix a gpu_cfg2 case in amdgpu/si.c that I had missed
  - Separate out the functional changes for better bisection (thanks,
    Michel!)
  - Add #defines in a patch by themselves (so a GPU revert wouldn't break
    other potential users)
  - Squash all the magic number -> #define changes into one patch

Since v1:
  - Add my signed-off-by and Alex's reviewed-by.

Bjorn Helgaas (3):
  PCI: Add #defines for Enter Compliance, Transmit Margin
  drm: correct Transmit Margin masks
  drm: replace numbers with PCI_EXP_LNKCTL2 definitions

 drivers/gpu/drm/amd/amdgpu/cik.c | 22 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/si.c  | 22 ++++++++++++++--------
 drivers/gpu/drm/radeon/cik.c     | 22 ++++++++++++++--------
 drivers/gpu/drm/radeon/si.c      | 22 ++++++++++++++--------
 include/uapi/linux/pci_regs.h    |  2 ++
 5 files changed, 58 insertions(+), 32 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

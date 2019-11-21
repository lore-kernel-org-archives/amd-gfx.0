From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 0/7] PCI: Prefer pcie_capability_read_word()
Date: Thu, 21 Nov 2019 08:02:13 -0600
Message-ID: <20191121140220.38030-1-helgaas@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: Alex Deucher <alexdeucher@gmail.com>, Frederick Lawler <fred@fredlawl.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>
List-Id: amd-gfx.lists.freedesktop.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use pcie_capability_read_word() and similar instead of using
pci_read_config_word() directly.  Add #defines to replace some magic
numbers.  Fix typos in use of Transmit Margin field.

These are currently on my pci/misc branch for v5.5.  Let me know if you see
any issues.


Bjorn Helgaas (5):
  PCI: Add #defines for Enter Compliance, Transmit Margin
  drm/amdgpu: Correct Transmit Margin masks
  drm/amdgpu: Replace numbers with PCI_EXP_LNKCTL2 definitions
  drm/radeon: Correct Transmit Margin masks
  drm/radeon: Replace numbers with PCI_EXP_LNKCTL2 definitions

Frederick Lawler (2):
  drm/amdgpu: Prefer pcie_capability_read_word()
  drm/radeon: Prefer pcie_capability_read_word()

 drivers/gpu/drm/amd/amdgpu/cik.c | 95 +++++++++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/si.c  | 97 ++++++++++++++++++++------------
 drivers/gpu/drm/radeon/cik.c     | 94 +++++++++++++++++++------------
 drivers/gpu/drm/radeon/si.c      | 97 ++++++++++++++++++++------------
 include/uapi/linux/pci_regs.h    |  2 +
 5 files changed, 243 insertions(+), 142 deletions(-)

-- 
2.24.0.432.g9d3f5f5b63-goog

From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 0/2] drm: replace magic nuumbers
Date: Thu,  7 Nov 2019 16:20:45 -0600
Message-ID: <20191107222047.125496-1-helgaas@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Frederick Lawler <fred@fredlawl.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
List-Id: amd-gfx.lists.freedesktop.org

From: Bjorn Helgaas <bhelgaas@google.com>

amdgpu and radeon do a bit of mucking with the PCIe Link Control 2
register, some of it using hard-coded magic numbers.  The idea here is to
replace those with #defines.

I haven't signed off on these because the first one actually changes the
bits involved because the existing code looks like it might have a typo.
But I have no way to know for sure.

I don't intend the Target Link Speed patch to change anything, so it should
be straightforward to review.

Bjorn Helgaas (2):
  drm: replace Compliance/Margin magic numbers with PCI_EXP_LNKCTL2
    definitions
  drm: replace Target Link Speed magic numbers with PCI_EXP_LNKCTL2
    definitions

 drivers/gpu/drm/amd/amdgpu/cik.c | 22 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/si.c  | 18 +++++++++++-------
 drivers/gpu/drm/radeon/cik.c     | 22 ++++++++++++++--------
 drivers/gpu/drm/radeon/si.c      | 22 ++++++++++++++--------
 include/uapi/linux/pci_regs.h    |  2 ++
 5 files changed, 55 insertions(+), 31 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

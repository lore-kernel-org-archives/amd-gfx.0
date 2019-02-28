From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 33/81] drm/radeon: check if device is root before getting pci speed caps
Date: Thu, 28 Feb 2019 10:07:25 -0500
Message-ID: <20190228150813.10256-33-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit afeff4c16edaa6275b903f82b0561406259aa3a3 ]

Check if the device is root rather before attempting to see what
speeds the pcie port supports.  Fixes a crash with pci passthrough
in a VM.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=109366
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 5 +++--
 drivers/gpu/drm/radeon/si_dpm.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index d587779a80b4d..a97294ac96d59 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5676,7 +5676,7 @@ int ci_dpm_init(struct radeon_device *rdev)
 	u16 data_offset, size;
 	u8 frev, crev;
 	struct ci_power_info *pi;
-	enum pci_bus_speed speed_cap;
+	enum pci_bus_speed speed_cap = PCI_SPEED_UNKNOWN;
 	struct pci_dev *root = rdev->pdev->bus->self;
 	int ret;
 
@@ -5685,7 +5685,8 @@ int ci_dpm_init(struct radeon_device *rdev)
 		return -ENOMEM;
 	rdev->pm.dpm.priv = pi;
 
-	speed_cap = pcie_get_speed_cap(root);
+	if (!pci_is_root_bus(rdev->pdev->bus))
+		speed_cap = pcie_get_speed_cap(root);
 	if (speed_cap == PCI_SPEED_UNKNOWN) {
 		pi->sys_pcie_mask = 0;
 	} else {
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 8fb60b3af0158..0a785ef0ab660 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -6899,7 +6899,7 @@ int si_dpm_init(struct radeon_device *rdev)
 	struct ni_power_info *ni_pi;
 	struct si_power_info *si_pi;
 	struct atom_clock_dividers dividers;
-	enum pci_bus_speed speed_cap;
+	enum pci_bus_speed speed_cap = PCI_SPEED_UNKNOWN;
 	struct pci_dev *root = rdev->pdev->bus->self;
 	int ret;
 
@@ -6911,7 +6911,8 @@ int si_dpm_init(struct radeon_device *rdev)
 	eg_pi = &ni_pi->eg;
 	pi = &eg_pi->rv7xx;
 
-	speed_cap = pcie_get_speed_cap(root);
+	if (!pci_is_root_bus(rdev->pdev->bus))
+		speed_cap = pcie_get_speed_cap(root);
 	if (speed_cap == PCI_SPEED_UNKNOWN) {
 		si_pi->sys_pcie_mask = 0;
 	} else {
-- 
2.19.1

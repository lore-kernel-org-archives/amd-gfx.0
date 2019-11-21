From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] drm/amd: Fix Kconfig indentation
Date: Thu, 21 Nov 2019 21:29:30 +0800
Message-ID: <20191121132930.29544-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/amd/acp/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/acp/Kconfig b/drivers/gpu/drm/amd/acp/Kconfig
index d968c2471412..19bae9100da4 100644
--- a/drivers/gpu/drm/amd/acp/Kconfig
+++ b/drivers/gpu/drm/amd/acp/Kconfig
@@ -2,11 +2,11 @@
 menu "ACP (Audio CoProcessor) Configuration"
 
 config DRM_AMD_ACP
-       bool "Enable AMD Audio CoProcessor IP support"
-       depends on DRM_AMDGPU
-       select MFD_CORE
-       select PM_GENERIC_DOMAINS if PM
-       help
+	bool "Enable AMD Audio CoProcessor IP support"
+	depends on DRM_AMDGPU
+	select MFD_CORE
+	select PM_GENERIC_DOMAINS if PM
+	help
 	Choose this option to enable ACP IP support for AMD SOCs.
 	This adds the ACP (Audio CoProcessor) IP driver and wires
 	it up into the amdgpu driver.  The ACP block provides the DMA
-- 
2.17.1

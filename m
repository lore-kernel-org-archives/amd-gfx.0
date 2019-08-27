From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] drm/amd: remove meaningless descending into amd/amdkfd/
Date: Tue, 27 Aug 2019 15:44:25 +0900
Message-ID: <20190827064425.19627-1-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=8F=AB=D3nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Since commit 04d5e2765802 ("drm/amdgpu: Merge amdkfd into amdgpu"),
drivers/gpu/drm/amd/amdkfd/Makefile does not contain any syntax that
is understood by the build system.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpu/drm/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 9f0d2ee35794..3f9195b7ad13 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -62,7 +62,6 @@ obj-$(CONFIG_DRM_TTM)	+= ttm/
 obj-$(CONFIG_DRM_SCHED)	+= scheduler/
 obj-$(CONFIG_DRM_TDFX)	+= tdfx/
 obj-$(CONFIG_DRM_R128)	+= r128/
-obj-$(CONFIG_HSA_AMD) += amd/amdkfd/
 obj-$(CONFIG_DRM_RADEON)+= radeon/
 obj-$(CONFIG_DRM_AMDGPU)+= amd/amdgpu/
 obj-$(CONFIG_DRM_MGA)	+= mga/
-- 
2.17.1

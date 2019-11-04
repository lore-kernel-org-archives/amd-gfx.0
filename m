From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 4/7] drm/amdgpu: remove set but not used variable 'dig_connector'
Date: Mon, 4 Nov 2019 21:27:23 +0800
Message-ID: <1572874046-30996-5-git-send-email-yukuai3@huawei.com>
References: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Jammy.Zhou@amd.com, tianci.yin@amd.com, sam@ravnborg.org, luben.tuikov@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/atombios_dp.c: In function
‘amdgpu_atombios_dp_get_panel_mode’:
drivers/gpu/drm/amd/amdgpu/atombios_dp.c:364:36: warning: variable
‘dig_connector’ set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
index 6858cde..9426530 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
@@ -361,7 +361,6 @@ int amdgpu_atombios_dp_get_panel_mode(struct drm_encoder *encoder,
 			       struct drm_connector *connector)
 {
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
-	struct amdgpu_connector_atom_dig *dig_connector;
 	int panel_mode = DP_PANEL_MODE_EXTERNAL_DP_MODE;
 	u16 dp_bridge = amdgpu_connector_encoder_get_dp_bridge_encoder_id(connector);
 	u8 tmp;
@@ -369,8 +368,6 @@ int amdgpu_atombios_dp_get_panel_mode(struct drm_encoder *encoder,
 	if (!amdgpu_connector->con_priv)
 		return panel_mode;
 
-	dig_connector = amdgpu_connector->con_priv;
-
 	if (dp_bridge != ENCODER_OBJECT_ID_NONE) {
 		/* DP bridge chips */
 		if (drm_dp_dpcd_readb(&amdgpu_connector->ddc_bus->aux,
-- 
2.7.4

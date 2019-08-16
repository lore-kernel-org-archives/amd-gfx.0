From: Colin King <colin.king@canonical.com>
Subject: [PATCH][drm-next] drm/amd/display: fix a potential null pointer dereference
Date: Fri, 16 Aug 2019 23:10:11 +0100
Message-ID: <20190816221011.10750-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

Currently the pointer init_data is dereferenced on the assignment
of fw_info before init_data is sanity checked to see if it is null.
Fix te potential null pointer dereference on init_data by only
performing dereference after it is null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: 9adc8050bf3c ("drm/amd/display: make firmware info only load once during dc_bios create")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index bee81bf288be..926954c804a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1235,7 +1235,7 @@ static bool calc_pll_max_vco_construct(
 			struct calc_pll_clock_source_init_data *init_data)
 {
 	uint32_t i;
-	struct dc_firmware_info *fw_info = &init_data->bp->fw_info;
+	struct dc_firmware_info *fw_info;
 	if (calc_pll_cs == NULL ||
 			init_data == NULL ||
 			init_data->bp == NULL)
@@ -1244,6 +1244,7 @@ static bool calc_pll_max_vco_construct(
 	if (init_data->bp->fw_info_valid)
 		return false;
 
+	fw_info = &init_data->bp->fw_info;
 	calc_pll_cs->ctx = init_data->ctx;
 	calc_pll_cs->ref_freq_khz = fw_info->pll_info.crystal_frequency;
 	calc_pll_cs->min_vco_khz =
-- 
2.20.1

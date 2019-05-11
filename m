From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] drm/amd/display: Make two functions static
Date: Sat, 11 May 2019 10:17:37 +0800
Message-ID: <20190511021737.8796-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, fatemeh.darbehani@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Fix sparse warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_clk_mgr.c:260:5:
 warning: symbol 'dcn10_set_dispclk' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_clk_mgr.c:286:5:
 warning: symbol 'dcn10_set_dprefclk' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c
index 9f2ffce..ae8c40c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c
@@ -257,7 +257,8 @@ static void dcn1_update_clocks(struct clk_mgr *clk_mgr,
 #define VBIOSSMC_MSG_SetDispclkFreq           0x4
 #define VBIOSSMC_MSG_SetDprefclkFreq          0x5
 
-int dcn10_set_dispclk(struct clk_mgr *clk_mgr_base, int requested_dispclk_khz)
+static int dcn10_set_dispclk(struct clk_mgr *clk_mgr_base,
+			     int requested_dispclk_khz)
 {
 	int actual_dispclk_set_khz = -1;
 	struct dce_clk_mgr *clk_mgr_dce = TO_DCE_CLK_MGR(clk_mgr_base);
@@ -283,7 +284,7 @@ int dcn10_set_dispclk(struct clk_mgr *clk_mgr_base, int requested_dispclk_khz)
 
 }
 
-int dcn10_set_dprefclk(struct clk_mgr *clk_mgr_base)
+static int dcn10_set_dprefclk(struct clk_mgr *clk_mgr_base)
 {
 	int actual_dprefclk_set_khz = -1;
 	struct dce_clk_mgr *clk_mgr_dce = TO_DCE_CLK_MGR(clk_mgr_base);
-- 
2.7.4

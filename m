From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 022/167] powerplay: Respect units on max dcfclk watermark
Date: Tue,  3 Sep 2019 12:22:54 -0400
Message-ID: <20190903162519.7136-22-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: David Francis <David.Francis@amd.com>, Harry Wentland <harry.wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: David Francis <David.Francis@amd.com>

[ Upstream commit f191415b24a3ad3fa22088af7cd7fc328a2f469f ]

In a refactor, the watermark clock inputs to
powerplay from DC were changed from units of 10kHz to
kHz clocks.

One division by 100 was not converted into a division
by 1000.

Signed-off-by: David Francis <David.Francis@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
index 2aab1b4759459..a321c465b7dce 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
@@ -674,7 +674,7 @@ int smu_set_watermarks_for_clocks_ranges(void *wt_table,
 		table->WatermarkRow[1][i].MaxClock =
 			cpu_to_le16((uint16_t)
 			(wm_with_clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz) /
-			100);
+			1000);
 		table->WatermarkRow[1][i].MinUclk =
 			cpu_to_le16((uint16_t)
 			(wm_with_clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz) /
-- 
2.20.1

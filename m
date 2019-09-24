From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 15/50] drm/amd/display: fix issue where 252-255 values are clipped
Date: Tue, 24 Sep 2019 12:48:12 -0400
Message-ID: <20190924164847.27780-15-sashal@kernel.org>
References: <20190924164847.27780-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190924164847.27780-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Anthony Koo <Anthony.Koo@amd.com>, Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Anthony Koo <Anthony.Koo@amd.com>

[ Upstream commit 1cbcfc975164f397b449efb17f59d81a703090db ]

[Why]
When endpoint is at the boundary of a region, such as at 2^0=1
we find that the last segment has a sharp slope and some points
are clipped at the top.

[How]
If end point is 1, which is exactly at the 2^0 region boundary, we
need to program an additional region beyond this point.

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 5d95a997fd9f9..f8904f73f57b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -292,9 +292,10 @@ bool cm_helper_translate_curve_to_hw_format(
 		seg_distr[7] = 4;
 		seg_distr[8] = 4;
 		seg_distr[9] = 4;
+		seg_distr[10] = 1;
 
 		region_start = -10;
-		region_end = 0;
+		region_end = 1;
 	}
 
 	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
-- 
2.20.1

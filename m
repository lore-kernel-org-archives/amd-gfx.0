From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 049/258] drm/amd/display: calculate stream->phy_pix_clk before clock mapping
Date: Mon, 28 Jan 2019 10:55:55 -0500
Message-ID: <20190128155924.51521-49-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>

[ Upstream commit 08e1c28dd521c7b08d1b0af0bae9fb22ccc012a4 ]

[why]
phy_pix_clk is one of the variable used to check if one PLL can be shared
with displays having common mode set configuration. As of now
phy_pix_clock varialbe is calculated in function dc_validate_stream().
dc_validate_stream() function is called after clocks are assigned for the
new display. Due to this during hotplug, when PLL sharing conditions are
checked for new display phy_pix_clk variable will be 0 and for displays
that are already enabled phy_pix_clk will have some value. Hence PLL will
not be shared and if the display hardware doesn't have any more PLL to
assign, mode set will fail due to resource unavailability.

[how]
Instead of only calculating the phy_pix_clk variable after the PLL is
assigned for new display, this patch calculates phy_pix_clk also during
the before assigning the PLL for new display.

Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ea6beccfd89d..87bf422f16be 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1917,6 +1917,8 @@ enum dc_status resource_map_pool_resources(
 		}
 	*/
 
+	calculate_phy_pix_clks(stream);
+
 	/* acquire new resources */
 	pipe_idx = acquire_first_free_pipe(&context->res_ctx, pool, stream);
 
-- 
2.19.1

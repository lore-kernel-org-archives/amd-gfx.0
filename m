From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 040/141] drm/amd/display: set link->dongle_max_pix_clk to 0 on a disconnect
Date: Fri, 19 Jul 2019 00:01:05 -0400
Message-ID: <20190719040246.15945-40-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Samson Tam <Samson.Tam@amd.com>, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Samson Tam <Samson.Tam@amd.com>

[ Upstream commit 233d87a579b8adcc6da5823fa507ecb6675e7562 ]

[Why]
Found issue in EDID Emulation where if we connect a display using
 a passive HDMI-DP dongle, disconnect it and then try to emulate
 a display using DP, we could not see 4K modes.  This was because
 on a disconnect, dongle_max_pix_clk was still set so when we
 emulate using DP, in dc_link_validate_mode_timing(), it would
 think we were still using a dongle and limit the modes we support.

[How]
In dc_link_detect(), set dongle_max_pix_clk to 0 when we detect
 a hotplug out ( if new_connection_type = dc_connection_none ).

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6072636da388..1367e2679082 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -922,6 +922,12 @@ bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
 
 		link->type = dc_connection_none;
 		sink_caps.signal = SIGNAL_TYPE_NONE;
+		/* When we unplug a passive DP-HDMI dongle connection, dongle_max_pix_clk
+		 *  is not cleared. If we emulate a DP signal on this connection, it thinks
+		 *  the dongle is still there and limits the number of modes we can emulate.
+		 *  Clear dongle_max_pix_clk on disconnect to fix this
+		 */
+		link->dongle_max_pix_clk = 0;
 	}
 
 	LINK_INFO("link=%d, dc_sink_in=%p is now %s prev_sink=%p dpcd same=%d edid same=%d\n",
-- 
2.20.1

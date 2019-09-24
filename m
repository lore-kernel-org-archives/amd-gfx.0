From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 07/70] drm/amd/display: add monitor patch to add T7 delay
Date: Tue, 24 Sep 2019 12:44:46 -0400
Message-ID: <20190924164549.27058-7-sashal@kernel.org>
References: <20190924164549.27058-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190924164549.27058-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Anthony Koo <anthony.koo@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Anthony Koo <anthony.koo@amd.com>

[ Upstream commit 88eac241a1fc500ce5274a09ddc4bd5fc2b5adb6 ]

[Why]
Specifically to one panel,
TCON is able to accept active video signal quickly, but
the Source Driver requires 2-3 frames of extra time.

It is a Panel issue since TCON needs to take care of
all Sink requirements including Source Driver. But in
this case it does not.

Customer is asking to add fixed T7 delay as panel
workaround.

[How]
Add monitor specific patch to add T7 delay

Signed-off-by: Anthony Koo <anthony.koo@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc_types.h          | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index b0dea759cd860..8aecf044e2ae8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -154,6 +154,10 @@ bool edp_receiver_ready_T7(struct dc_link *link)
 			break;
 		udelay(25); //MAx T7 is 50ms
 	} while (++tries < 300);
+
+	if (link->local_sink->edid_caps.panel_patch.extra_t7_ms > 0)
+		udelay(link->local_sink->edid_caps.panel_patch.extra_t7_ms * 1000);
+
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 6c2a3d9a4c2e7..283082666be51 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -202,6 +202,7 @@ struct dc_panel_patch {
 	unsigned int dppowerup_delay;
 	unsigned int extra_t12_ms;
 	unsigned int extra_delay_backlight_off;
+	unsigned int extra_t7_ms;
 };
 
 struct dc_edid_caps {
-- 
2.20.1

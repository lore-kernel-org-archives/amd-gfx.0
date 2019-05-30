From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amd/display: remove redundant assignment to status
Date: Thu, 30 May 2019 17:12:19 +0100
Message-ID: <20190530161219.2507-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Koo <anthony.koo@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The variable status is initialized with a value that is never read
and status is reassigned several statements later. This initialization
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 65d6caedbd82..cf6166a1be53 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2367,7 +2367,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	union down_stream_port_count down_strm_port_count;
 	union edp_configuration_cap edp_config_cap;
 	union dp_downstream_port_present ds_port = { 0 };
-	enum dc_status status = DC_ERROR_UNEXPECTED;
+	enum dc_status status;
 	uint32_t read_dpcd_retry_cnt = 3;
 	int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
-- 
2.20.1

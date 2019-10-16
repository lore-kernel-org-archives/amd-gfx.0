From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: Make dc_link_detect_helper static
Date: Wed, 16 Oct 2019 19:15:41 +0800
Message-ID: <20191016111541.20208-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Jun.Lei@amd.com, Anthony.Koo@amd.com, Eric.Yang2@amd.com, Wenjing.Liu@amd.com, David.Francis@amd.com, nikola.cornij@amd.com, Chris.Park@amd.com, martin.leung@amd.com, david.galiffi@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Fix sparse warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:746:6:
 warning: symbol 'dc_link_detect_helper' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fb18681..9350536 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -743,7 +743,8 @@ static bool wait_for_alt_mode(struct dc_link *link)
  * This does not create remote sinks but will trigger DM
  * to start MST detection if a branch is detected.
  */
-bool dc_link_detect_helper(struct dc_link *link, enum dc_detect_reason reason)
+static bool dc_link_detect_helper(struct dc_link *link,
+				  enum dc_detect_reason reason)
 {
 	struct dc_sink_init_data sink_init_data = { 0 };
 	struct display_sink_capability sink_caps = { 0 };
-- 
2.7.4

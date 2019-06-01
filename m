From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: Use kmemdup in dc_copy_stream()
Date: Sat, 1 Jun 2019 07:22:08 +0000
Message-ID: <20190601072208.193673-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, hanghong.ma@amd.com, Jun.Lei@amd.com, Wenjing.Liu@amd.com, Krunoslav.Kovac@amd.com, nicholas.kazlauskas@amd.com, David.Francis@amd.com, Bhawanpreet.Lakha@amd.com
Cc: YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Use kmemdup rather than duplicating its implementation.

Detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index a002e690814f..b166c732b532 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -167,12 +167,11 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
 {
 	struct dc_stream_state *new_stream;
 
-	new_stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
+	new_stream = kmemdup(stream, sizeof(struct dc_stream_state),
+			     GFP_KERNEL);
 	if (!new_stream)
 		return NULL;
 
-	memcpy(new_stream, stream, sizeof(struct dc_stream_state));
-
 	if (new_stream->sink)
 		dc_sink_retain(new_stream->sink);

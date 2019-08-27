From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 2/3] drm/amd/display: remove unused function setFieldWithMask
Date: Tue, 27 Aug 2019 15:09:25 +0800
Message-ID: <20190827070925.16080-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Anthony.Koo@amd.com, ahmad.othman@amd.com, eric.bernstein@amd.com, yuehaibing@huawei.com, aric.cyr@amd.com, alvin.lee3@amd.com, Harmanprit.Tatla@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

After commit a9f54ce3c603 ("drm/amd/display: Refactoring VTEM"),
there is no caller in tree.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 .../drm/amd/display/modules/info_packet/info_packet.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 5f4b98d..d885d64 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -114,25 +114,6 @@ enum ColorimetryYCCDP {
 	ColorimetryYCC_DP_ITU2020YCbCr  = 7,
 };
 
-void setFieldWithMask(unsigned char *dest, unsigned int mask, unsigned int value)
-{
-	unsigned int shift = 0;
-
-	if (!mask || !dest)
-		return;
-
-	while (!((mask >> shift) & 1))
-		shift++;
-
-	//reset
-	*dest = *dest & ~mask;
-	//set
-	//dont let value span past mask
-	value = value & (mask >> shift);
-	//insert value
-	*dest = *dest | (value << shift);
-}
-
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet)
 {
-- 
2.7.4

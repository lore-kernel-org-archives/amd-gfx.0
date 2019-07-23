From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: Make pow_buffer_ptr static
Date: Tue, 23 Jul 2019 22:37:41 +0800
Message-ID: <20190723143741.35064-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Krunoslav.Kovac@amd.com, Aric.Cyr@amd.com, Anthony.Koo@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Fix sparse warning:

drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c:62:5:
 warning: symbol 'pow_buffer_ptr' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index ed894cd..5332168 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -59,7 +59,7 @@ static struct translate_from_linear_space_args scratch_gamma_args;
  */
 static struct fixed31_32 pow_buffer[NUM_PTS_IN_REGION];
 static struct fixed31_32 gamma_of_2; // 2^gamma
-int pow_buffer_ptr = -1;
+static int pow_buffer_ptr = -1;
 
 static const int32_t gamma_numerator01[] = { 31308,	180000,	0};
 static const int32_t gamma_numerator02[] = { 12920,	4500,	0};
-- 
2.7.4

From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: Fix old-style declaration
Date: Mon, 11 Nov 2019 20:28:01 +0800
Message-ID: <20191111122801.18584-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Jun.Lei@amd.com, David.Francis@amd.com, Dmytro.Laktyushkin@amd.com, nicholas.kazlauskas@amd.com, martin.leung@amd.com, Chris.Park@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Fix a build warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:75:1:
 warning: 'static' is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1fdba13..0d8c663 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -69,7 +69,7 @@
 #define DC_LOGGER \
 	dc->ctx->logger
 
-const static char DC_BUILD_ID[] = "production-build";
+static const char DC_BUILD_ID[] = "production-build";
 
 /**
  * DOC: Overview
-- 
2.7.4

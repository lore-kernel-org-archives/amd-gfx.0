From: Krzysztof Wilczynski <kw@linux.com>
Subject: [PATCH] drm/amd/display: Move static keyword to the front of declaration
Date: Thu,  5 Sep 2019 20:33:06 +0200
Message-ID: <20190905183306.32670-1-kw@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei <Jun.Lei@amd.com>, David Francis <David.Francis@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>, Anthony Koo <anthony.koo@amd.com>, Aidan Wood <Aidan.Wood@amd.com>, Chris Park <Chris.Park@amd.com>, Eric Yang <Eric.Yang2@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Move the static keyword to the front of declaration of DC_BUILD_ID,
and resolve the following compiler warning that can be seen when
building with warnings enabled (W=1):

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:75:1: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com

 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 87ca5a290d12..a5a89bc0e1d1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -72,7 +72,7 @@
 #define DC_LOGGER \
 	dc->ctx->logger
 
-const static char DC_BUILD_ID[] = "production-build";
+static const char DC_BUILD_ID[] = "production-build";
 
 /**
  * DOC: Overview
-- 
2.22.1

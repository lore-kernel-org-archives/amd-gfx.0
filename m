From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] drm/radeon: Change the default to PCI on PowerPC
Date: Tue, 24 Apr 2018 21:55:11 +0200
Message-ID: <20180424195512.491-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mathieu Malaterre <malat@debian.org>, Alex Deucher <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

AGP mode is unstable on PowerPC. Symptoms are generally of the form:

[ 1228.795711] radeon 0000:00:10.0: ring 0 stalled for more than 10240msec

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index b28288a781ef..2a7977a23b31 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -168,7 +168,12 @@ int radeon_no_wb;
 int radeon_modeset = -1;
 int radeon_dynclks = -1;
 int radeon_r4xx_atom = 0;
+#ifdef __powerpc__
+/* Default to PCI on PowerPC (fdo #95017) */
+int radeon_agpmode = -1;
+#else
 int radeon_agpmode = 0;
+#endif
 int radeon_vram_limit = 0;
 int radeon_gart_size = -1; /* auto */
 int radeon_benchmarking = 0;
-- 
2.11.0

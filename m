From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amdkfd: fix potential null pointer dereference on pointer peer_dev
Date: Sat, 29 Jun 2019 14:31:14 +0100
Message-ID: <20190629133114.14271-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The call to kfd_topology_device_by_proximity_domain can return a NULL
pointer so add a null pointer check on peer_dev to the existing null
pointer check on peer_dev->gpu to avoid any potential null pointer
dereferences.

Addresses-Coverity: ("Dereference on null return value")
Fixes: ae9a25aea7f3 ("drm/amdkfd: Generate xGMI direct iolink")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 4e3fc284f6ac..cb6b46cfa6c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1293,7 +1293,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	if (kdev->hive_id) {
 		for (nid = 0; nid < proximity_domain; ++nid) {
 			peer_dev = kfd_topology_device_by_proximity_domain(nid);
-			if (!peer_dev->gpu)
+			if (!peer_dev || !peer_dev->gpu)
 				continue;
 			if (peer_dev->gpu->hive_id != kdev->hive_id)
 				continue;
-- 
2.20.1

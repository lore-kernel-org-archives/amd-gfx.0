From: Lyude Paul <lyude@redhat.com>
Subject: [WIP PATCH 07/15] drm/nouveau: Remove bogus cleanup in nv50_mstm_add_connector()
Date: Thu, 13 Dec 2018 20:25:36 -0500
Message-ID: <20181214012604.13746-8-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Ilia Mirkin <imirkin@alum.mit.edu>, Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Trying to destroy the connector using mstc->connector.funcs->destroy()
if connector initialization fails is wrong: there is no possible
codepath in nv50_mstc_new where nv50_mstm_add_connector() would return
<0 and mstc would be non-NULL.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 26af45785939..641252208e67 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1099,11 +1099,8 @@ nv50_mstm_add_connector(struct drm_dp_mst_topology_mgr *mgr,
 	int ret;
 
 	ret = nv50_mstc_new(mstm, port, path, &mstc);
-	if (ret) {
-		if (mstc)
-			mstc->connector.funcs->destroy(&mstc->connector);
+	if (ret)
 		return NULL;
-	}
 
 	return &mstc->connector;
 }
-- 
2.19.2

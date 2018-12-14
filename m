From: Lyude Paul <lyude@redhat.com>
Subject: [WIP PATCH 08/15] drm/nouveau: Remove unnecessary VCPI checks in nv50_msto_cleanup()
Date: Thu, 13 Dec 2018 20:25:37 -0500
Message-ID: <20181214012604.13746-9-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Sean Paul <seanpaul@chromium.org>, Karol Herbst <karolherbst@gmail.com>, Ilia Mirkin <imirkin@alum.mit.edu>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

There is no need to look at the port's VCPI allocation before calling
drm_dp_mst_deallocate_vcpi(), as we already have msto->disabled to let
us avoid cleaning up an msto more then once. The DP MST core will never
call drm_dp_mst_deallocate_vcpi() on it's own, which is presumably what
these checks are meant to protect against.

More importantly though, we're about to stop clearing mstc->port in the
next commit, which means if we could potentially hit a use-after-free
error if we tried to check mstc->port->vcpi here. So to make life easier
for anyone who bisects this code in the future, use msto->disabled
instead to check whether or not we need to deallocate VCPI instead.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 641252208e67..0f7d72518604 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -704,14 +704,17 @@ nv50_msto_cleanup(struct nv50_msto *msto)
 	struct nv50_mstc *mstc = msto->mstc;
 	struct nv50_mstm *mstm = mstc->mstm;
 
+	if (!msto->disabled)
+		return;
+
 	NV_ATOMIC(drm, "%s: msto cleanup\n", msto->encoder.name);
-	if (mstc->port && mstc->port->vcpi.vcpi > 0 && !nv50_msto_payload(msto))
+
+	if (mstc->port)
 		drm_dp_mst_deallocate_vcpi(&mstm->mgr, mstc->port);
-	if (msto->disabled) {
-		msto->mstc = NULL;
-		msto->head = NULL;
-		msto->disabled = false;
-	}
+
+	msto->mstc = NULL;
+	msto->head = NULL;
+	msto->disabled = false;
 }
 
 static void
-- 
2.19.2

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdgpu: fix structurally dead code vcn_v2_5_hw_init
Date: Tue, 1 Oct 2019 12:16:35 -0500
Message-ID: <20191001171635.GA17306@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Notice that there is a *continue* statement in the middle of the
for loop and that prevents the code below from ever being reached:

	r = amdgpu_ring_test_ring(ring);
	if (r) {
		ring->sched.ready = false;
		goto done;
	}

Fix this by removing the continue statement and updating ring->sched.ready
to true before calling amdgpu_ring_test_ring(ring).

Notice that this fix is based on
commit 1b61de45dfaf ("drm/amdgpu: add initial VCN2.0 support (v2)")

Addresses-Coverity-ID 1485608 ("Structurally dead code")
Fixes: 28c17d72072b ("drm/amdgpu: add VCN2.5 basic supports")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---

Any feedback is greatly appreciated.

 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 395c2259f979..47b0dcd59e13 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -258,6 +258,7 @@ static int vcn_v2_5_hw_init(void *handle)
 		adev->nbio_funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 						     ring->doorbell_index, j);
 
+		ring->sched.ready = true;
 		r = amdgpu_ring_test_ring(ring);
 		if (r) {
 			ring->sched.ready = false;
@@ -266,8 +267,7 @@ static int vcn_v2_5_hw_init(void *handle)
 
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 			ring = &adev->vcn.inst[j].ring_enc[i];
-			ring->sched.ready = false;
-			continue;
+			ring->sched.ready = true;
 			r = amdgpu_ring_test_ring(ring);
 			if (r) {
 				ring->sched.ready = false;
@@ -276,6 +276,7 @@ static int vcn_v2_5_hw_init(void *handle)
 		}
 
 		ring = &adev->vcn.inst[j].ring_jpeg;
+		ring->sched.ready = true;
 		r = amdgpu_ring_test_ring(ring);
 		if (r) {
 			ring->sched.ready = false;
-- 
2.23.0

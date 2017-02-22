From: Lyude <lyude@redhat.com>
Subject: [PATCH RESEND] drm/radeon/dp_auxch: Ratelimit aux transfer debug messages
Date: Wed, 22 Feb 2017 16:37:16 -0500
Message-ID: <20170222213717.21220-1-lyude@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: xorg-driver-ati@lists.freedesktop.org
Cc: Lyude <lyude@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Aux transfers always fail with non-zero status flags when there's
nothing connected on the port, so we don't usually need to see all of
the debugging information from it. Also, we try reprobing a -lot-, so
without ratelimiting most of the kernel log is filled up with messages
from radeon_dp_aux_transfer_native.

Signed-off-by: Lyude <lyude@redhat.com>
---
 drivers/gpu/drm/radeon/radeon_dp_auxch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_dp_auxch.c b/drivers/gpu/drm/radeon/radeon_dp_auxch.c
index 474a8a18..12eac4e 100644
--- a/drivers/gpu/drm/radeon/radeon_dp_auxch.c
+++ b/drivers/gpu/drm/radeon/radeon_dp_auxch.c
@@ -168,7 +168,8 @@ radeon_dp_aux_transfer_native(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg
 		goto done;
 	}
 	if (tmp & AUX_RX_ERROR_FLAGS) {
-		DRM_DEBUG_KMS("dp_aux_ch flags not zero: %08x\n", tmp);
+		DRM_DEBUG_KMS_RATELIMITED("dp_aux_ch flags not zero: %08x\n",
+					  tmp);
 		ret = -EIO;
 		goto done;
 	}
-- 
2.9.3

From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Subject: [PATCH] drm/core: Fail atomic IOCTL with no CRTC state but with signaling.
Date: Fri, 9 Jun 2017 17:30:19 -0400
Message-ID: <1497043819-28591-1-git-send-email-Andrey.Grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Problem:
While running IGT kms_atomic_transition test suite i encountered
a hang in drmHandleEvent immidietly follwoing an atomic_commit.
After dumping the atomic state I relized that in this case there was
not even one CRTC attached to the state and only disabled
planes. This probably due to a commit which hadn't changed any property
which would require attaching crtc state. This means drmHandleEvent
will never wake up from read since without CRTC in atomic state
the event fd will not be singnaled.
This point to a bug in IGT but also DRM should gracefully
fail  such scenario so no hang on user side will happen.

Fix:
Explicitly fail by failing atomic_commit early in
drm_mode_atomic_commit where such problem can be identified.

Signed-off-by: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
---
 drivers/gpu/drm/drm_atomic.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index a567310..32eae1c 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1933,7 +1933,7 @@ static int prepare_crtc_signaling(struct drm_device *dev,
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
-	int i, ret;
+	int i, c = 0, ret;
 
 	if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY)
 		return 0;
@@ -1994,8 +1994,17 @@ static int prepare_crtc_signaling(struct drm_device *dev,
 
 			crtc_state->event->base.fence = fence;
 		}
+
+		c++;
 	}
 
+	/*
+	 * Having this flag means user mode pends on event which will never
+	 * reach due to lack of at least one CRTC for signaling
+	 */
+	if (c == 0 && (arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2179,6 +2188,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 		drm_mode_object_unreference(obj);
 	}
 
+
+
 	ret = prepare_crtc_signaling(dev, state, arg, file_priv, &fence_state,
 				     &num_fences);
 	if (ret)
-- 
2.7.4

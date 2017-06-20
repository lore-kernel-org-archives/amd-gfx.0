From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Subject: [PATCH v2] drm/core: Fail atomic IOCTL with no CRTC state but with signaling.
Date: Tue, 20 Jun 2017 13:57:06 -0400
Message-ID: <1497981426-27203-1-git-send-email-Andrey.Grodzovsky@amd.com>
References: <0d603149-3fb0-3d48-89e5-77e3f7686415@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0d603149-3fb0-3d48-89e5-77e3f7686415@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com
Cc: amd-gfx@lists.freedesktop.org, seanpaul@chromium.org, daniel@ffwll.ch, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Problem : While running IGT kms_atomic_transition test suite i encountered
a hang in drmHandleEvent immediately following  an atomic_commit.
After dumping the atomic state I relized that in this case there was
not even one CRTC attached to the state and only disabled
planes. This probably due to a commit which hadn't changed any property
which would require attaching crtc state. This means drmHandleEvent
will never wake up from read since without CRTC in atomic state
the event fd will not be signaled.

Fix: Protect against this issue by failing atomic_commit early in
drm_mode_atomic_commit where such probelm can be identified.

v2:
Fix typos and extra newlines.

Change-Id: I3ee28ffae35fd1e8bfe553146c44da53da02e6f8
Signed-off-by: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
---
 drivers/gpu/drm/drm_atomic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index a567310..48145bf 100644
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
 
-- 
2.7.4

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AEFE98E0A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A92810E28C;
	Mon, 23 Feb 2026 08:29:16 +0000 (UTC)
Received: from MTA-13-4.privateemail.com (mta-13-4.privateemail.com
 [198.54.127.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80D910E2BD;
 Fri, 20 Feb 2026 17:16:31 +0000 (UTC)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
 by mta-13.privateemail.com (Postfix) with ESMTP id 4fHcNb0JH6z3hhTQ;
 Fri, 20 Feb 2026 12:16:31 -0500 (EST)
Received: from localhost.localdomain
 (bras-base-toroon4332w-grc-26-174-91-51-28.dsl.bell.ca [174.91.51.28])
 by mta-13.privateemail.com (Postfix) with ESMTPA;
 Fri, 20 Feb 2026 12:16:03 -0500 (EST)
From: Hamza Mahfooz <someguy@effective-light.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <someguy@effective-light.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Alex Hung <alex.hung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] drm/amd/display: add vendor specific reset
Date: Fri, 20 Feb 2026 12:15:13 -0500
Message-ID: <20260220171518.711594-2-someguy@effective-light.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220171518.711594-1-someguy@effective-light.com>
References: <20260220171518.711594-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:29:06 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We now have a means to respond to page flip timeouts. So, hook up
support by trying to reload DMUB firmware if
drm_atomic_helper_wait_for_flip_done() fails. Also, send out a wedged
event if the firmware reload fails.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
v2: send a wedged event instead of attempting a GPU reset.
v3: read return value of drm_atomic_helper_wait_for_flip_done().
v4: only send wedged event if firmware reload fails and send out "fake"
    page flip completes.
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7c51d8d7e73c..0ae6ada22fb0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -87,6 +87,7 @@
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_edid.h>
@@ -10829,6 +10830,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct drm_connector_state *old_con_state = NULL, *new_con_state = NULL;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	int crtc_disable_count = 0;
+	struct amdgpu_crtc *acrtc;
 
 	trace_amdgpu_dm_atomic_commit_tail_begin(state);
 
@@ -11085,8 +11087,26 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	/* Signal HW programming completion */
 	drm_atomic_helper_commit_hw_done(state);
 
-	if (wait_for_vblank)
-		drm_atomic_helper_wait_for_flip_done(dev, state);
+	if (wait_for_vblank &&
+	    drm_atomic_helper_wait_for_flip_done(dev, state)) {
+		mutex_lock(&dm->dc_lock);
+		if (dm_dmub_hw_init(adev))
+			drm_dev_wedged_event(dev, DRM_WEDGE_RECOVERY_REBIND |
+					     DRM_WEDGE_RECOVERY_BUS_RESET,
+					     NULL);
+		mutex_unlock(&dm->dc_lock);
+
+		spin_lock_irqsave(&dev->event_lock, flags);
+		drm_for_each_crtc(crtc, dev) {
+			if (acrtc->event) {
+				drm_crtc_send_vblank_event(crtc, acrtc->event);
+				acrtc->event = NULL;
+				drm_crtc_vblank_put(crtc);
+				acrtc->pflip_status = AMDGPU_FLIP_NONE;
+			}
+		}
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+	}
 
 	drm_atomic_helper_cleanup_planes(dev, state);
 
-- 
2.53.0


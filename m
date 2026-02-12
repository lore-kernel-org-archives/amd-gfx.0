Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94D8EF48E8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Feb 2026 08:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68AF410E7B8;
	Fri, 13 Feb 2026 08:46:33 +0000 (UTC)
Received: from MTA-15-3.privateemail.com (MTA-15-3.privateemail.com
 [198.54.122.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B623110E2C9;
 Thu, 12 Feb 2026 23:10:18 +0000 (UTC)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
 by mta-15.privateemail.com (Postfix) with ESMTP id 4fBrcV0y0Lz3hhSx;
 Thu, 12 Feb 2026 18:10:18 -0500 (EST)
Received: from localhost.localdomain
 (bras-base-toroon4332w-grc-26-174-91-51-28.dsl.bell.ca [174.91.51.28])
 by mta-15.privateemail.com (Postfix) with ESMTPA;
 Thu, 12 Feb 2026 18:09:50 -0500 (EST)
From: Hamza Mahfooz <someguy@effective-light.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Hamza Mahfooz <someguy@effective-light.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] drm/amd/display: add vendor specific reset
Date: Thu, 12 Feb 2026 18:09:00 -0500
Message-ID: <20260212230905.688006-2-someguy@effective-light.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212230905.688006-1-someguy@effective-light.com>
References: <20260212230905.688006-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Fri, 13 Feb 2026 08:46:32 +0000
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
support by sending out a wedged event if
drm_atomic_helper_wait_for_flip_done() fails.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
v2: send a wedged event instead of attempting a GPU reset.
v3: read return value of drm_atomic_helper_wait_for_flip_done().
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7c51d8d7e73c..06d8353cb616 100644
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
@@ -11085,8 +11086,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	/* Signal HW programming completion */
 	drm_atomic_helper_commit_hw_done(state);
 
-	if (wait_for_vblank)
-		drm_atomic_helper_wait_for_flip_done(dev, state);
+	if (wait_for_vblank) {
+		if (drm_atomic_helper_wait_for_flip_done(dev, state))
+			drm_dev_wedged_event(dev, DRM_WEDGE_RECOVERY_REBIND |
+					     DRM_WEDGE_RECOVERY_BUS_RESET,
+					     NULL);
+	}
 
 	drm_atomic_helper_cleanup_planes(dev, state);
 
-- 
2.53.0


Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B72FC4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 13:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E651760232
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 13:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E651760232
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE7E46E52E;
	Mon,  2 Aug 2021 13:40:16 +0000 (UTC)
X-Greylist: delayed 906 seconds by postgrey-1.36 at gabe;
 Mon, 02 Aug 2021 07:58:35 UTC
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7106E328;
 Mon,  2 Aug 2021 07:58:35 +0000 (UTC)
X-UUID: bf244a08b01545c0a3c76fca0c5f9e7b-20210802
X-UUID: bf244a08b01545c0a3c76fca0c5f9e7b-20210802
X-User: lizhenneng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
 (envelope-from <lizhenneng@kylinos.cn>) (Generic MTA)
 with ESMTP id 439848347; Mon, 02 Aug 2021 15:41:48 +0800
From: Zhenneng Li <lizhenneng@kylinos.cn>
To: 
Cc: Zhenneng Li <lizhenneng@kylinos.cn>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: Update pitch for page flip
Date: Mon,  2 Aug 2021 15:43:10 +0800
Message-Id: <20210802074310.1526526-1-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Add_By_Label_Mail_Nextpart_001"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Aug 2021 13:40:13 +0000
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

--Add_By_Label_Mail_Nextpart_001
Content-Type: text/plain;
Content-Transfer-Encoding: 8bit


When primary bo is updated, crtc's pitch may
have not been updated, this will lead to show
disorder content when user changes display mode,
we update crtc's pitch in page flip to avoid
this bug.
This refers to amdgpu's pageflip.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
---
 drivers/gpu/drm/radeon/evergreen.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 36a888e1b179..eeb590d2dec2 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -28,6 +28,7 @@
 
 #include <drm/drm_vblank.h>
 #include <drm/radeon_drm.h>
+#include <drm/drm_fourcc.h>
 
 #include "atom.h"
 #include "avivod.h"
@@ -1414,10 +1415,15 @@ void evergreen_page_flip(struct radeon_device *rdev, int crtc_id, u64 crtc_base,
 			 bool async)
 {
 	struct radeon_crtc *radeon_crtc = rdev->mode_info.crtcs[crtc_id];
+	struct drm_framebuffer *fb = radeon_crtc->base.primary->fb;
 
-	/* update the scanout addresses */
+	/* flip at hsync for async, default is vsync */
 	WREG32(EVERGREEN_GRPH_FLIP_CONTROL + radeon_crtc->crtc_offset,
 	       async ? EVERGREEN_GRPH_SURFACE_UPDATE_H_RETRACE_EN : 0);
+	/* update pitch */
+	WREG32(EVERGREEN_GRPH_PITCH + radeon_crtc->crtc_offset,
+	       fb->pitches[0] / fb->format->cpp[0]);
+	/* update the scanout addresses */
 	WREG32(EVERGREEN_GRPH_PRIMARY_SURFACE_ADDRESS_HIGH + radeon_crtc->crtc_offset,
 	       upper_32_bits(crtc_base));
 	WREG32(EVERGREEN_GRPH_PRIMARY_SURFACE_ADDRESS + radeon_crtc->crtc_offset,
-- 
2.25.1


--Add_By_Label_Mail_Nextpart_001

Content-type: Text/plain

No virus found
		Checked by Hillstone Network AntiVirus

--Add_By_Label_Mail_Nextpart_001--

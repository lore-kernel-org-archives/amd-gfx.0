Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC92C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 18:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C586410E45C;
	Tue, 15 Feb 2022 18:53:40 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7616310E45C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 18:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 7F5822020E3;
 Tue, 15 Feb 2022 19:53:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id hJGAE5RH1yZ9; Tue, 15 Feb 2022 19:53:37 +0100 (CET)
Received: from kaveri (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id D54662020DB;
 Tue, 15 Feb 2022 19:53:37 +0100 (CET)
Received: from daenzer by kaveri with local (Exim 4.95)
 (envelope-from <michel@daenzer.net>) id 1nK2xF-007rSP-8e;
 Tue, 15 Feb 2022 19:53:37 +0100
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH] drm/amd/display: For vblank_disable_immediate,
 check PSR is really used
Date: Tue, 15 Feb 2022 19:53:37 +0100
Message-Id: <20220215185337.1873778-1-michel@daenzer.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michel Dänzer <mdaenzer@redhat.com>

Even if PSR is allowed for a present GPU, there might be no eDP link
which supports PSR.

Fixes: 9b510908e420 ("drm/amdgpu/display: Only set vblank_disable_immediate when PSR is not enabled")
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cd8b0d9eb19c..df86517dd532 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4256,6 +4256,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	}
 #endif
 
+	/* Disable vblank IRQs aggressively for power-saving. */
+	adev_to_drm(adev)->vblank_disable_immediate = true;
+
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
@@ -4301,19 +4304,17 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 				update_connector_ext_caps(aconnector);
 			if (psr_feature_enabled)
 				amdgpu_dm_set_psr_caps(link);
+
+			/* TODO: Fix vblank control helpers to delay PSR entry to allow this when
+			 * PSR is also supported.
+			 */
+			if (link->psr_settings.psr_feature_enabled)
+				adev_to_drm(adev)->vblank_disable_immediate = false;
 		}
 
 
 	}
 
-	/*
-	 * Disable vblank IRQs aggressively for power-saving.
-	 *
-	 * TODO: Fix vblank control helpers to delay PSR entry to allow this when PSR
-	 * is also supported.
-	 */
-	adev_to_drm(adev)->vblank_disable_immediate = !psr_feature_enabled;
-
 	/* Software is initialized. Now we can register interrupt handlers. */
 	switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
-- 
2.34.1


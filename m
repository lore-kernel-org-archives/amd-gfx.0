Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5F2CD4F50
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 16:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C96910E91B;
	Mon, 18 May 2026 16:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=daenzer.net header.i=@daenzer.net header.b="tT1pC+dT";
	dkim-atps=neutral
X-Greylist: delayed 4255 seconds by postgrey-1.36 at gabe;
 Mon, 18 May 2026 16:59:07 UTC
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AEE510E8F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 16:59:07 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gK2JV3v49zLjn;
 Mon, 18 May 2026 17:48:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daenzer.net;
 s=20251126; t=1779119290;
 bh=QGDAbvOWF4Bo4FiivAm6DGvIEYEPLfoJb8o1rGEK4cs=;
 h=From:To:Cc:Subject:Date:From;
 b=tT1pC+dTIPfelkTdyIzqeZtsfyHhtdbOxPHXypJoJjEmtASdlQiney0VhhjCfRNDn
 S8H1xRexy3G0Nzi8pZr3f5xvyJEwbH+lxp5CUq0mv6F7jElXZSKDFdq364E5J02S4l
 /c5dcXPlrQR0A91o7mEOzX/qF5qTl2aXC/LQHsnZjZnfqtm6xh8G0e8KgwizknRd41
 mfvExEU/I4OPnWOdbDaNUyqbgDYSyQjqDshLQW4T7eI7NUWdLVR3MDtWfzM6C7b3ET
 bqiel89gqZQhYAMhpyiK2CA25s+vsew7goCZ5FM7lIDcJvvCNTWya8MlWLQg6cxRn5
 LBqzPrARI+CnQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gK2JT6bfBz8wx; Mon, 18 May 2026 17:48:09 +0200 (CEST)
Received: from unknown by kaveri with local (Exim 4.99.2)
 (envelope-from <michel@daenzer.net>) id 1wP0CP-00000002liK-2uBO;
 Mon, 18 May 2026 17:48:09 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Consult MCCS FreeSync cap only if requested
 & supported
Date: Mon, 18 May 2026 17:48:09 +0200
Message-ID: <20260518154809.660061-1-michel@daenzer.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Michel Dänzer <mdaenzer@redhat.com>

When the do_mccs parameter is false, we don't call
dm_helpers_read_mccs_caps, so sink->mccs_caps.freesync_supported is
unlikely to be true.

Fixes: 6f71d5dd3206 ("drm/amd/display: Read sink freesync support via mccs")
Bug: https://gitlab.freedesktop.org/drm/amd/-/work_items/5286
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---

I suspect this logic might not be quite right yet, it fixes the
regression and should be a step in the right direction though.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e0d209d016cd..9d4692e4ea26 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13468,17 +13468,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	}
 
 	/* Handle MCCS */
-	if (do_mccs)
+	if (do_mccs) {
 		dm_helpers_read_mccs_caps(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
 
-	if ((sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
-		as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) &&
-		(!sink->edid_caps.freesync_vcp_code ||
-		(sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)))
-		freesync_capable = false;
+		if (sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)
+			freesync_capable = false;
 
-	if (do_mccs && sink->mccs_caps.freesync_supported && freesync_capable)
-		dm_helpers_mccs_vcp_set(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
+		if (sink->mccs_caps.freesync_supported && freesync_capable)
+			dm_helpers_mccs_vcp_set(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
+	}
 
 update:
 	if (dm_con_state)
-- 
2.53.0


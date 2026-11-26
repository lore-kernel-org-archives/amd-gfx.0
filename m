Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D03606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EN2Az69Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96FFE112109;
	Thu, 26 Nov 2026 08:09:42 +0000 (UTC)
Received: from mta1.migadu.com (out-169.mta1.migadu.com [95.215.58.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7038410E30A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 05:43:01 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=m6qTjx8a24ZfFdxxfcU1dhByNvTgWI0c6mQn9ekCErU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795671779; v=1; x=1796276579;
 b=EN2Az69YdeP89VIAhkYEUrDuHzVKoLqTy3fHIgf80u+kzhoNw5f50bkuQD25eJsazUD8aCxA
 drS7UmwAMGYpZ6Pq89oXf5/On757QxOocnJ4nciL0wZM8PfNzIzX4PQszsyUPAnloQZzeicjZnt
 V9DDm1E1tSH1qhPiVN6Hw+oI=
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 99d92dd9318bc90a;
 Thu, 26 Nov 2026 05:36:55 +0000
X-Mizu-Trace-ID: 99d92dd9318bc90a
X-Migadu-Flow: FLOW_OUT
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Pei-Hsin Yang <peihsiny@valvesoftware.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH 1/2] drm/amd/display: Rebuild the VRR vtotal limits on a
 modeset
Date: Wed, 25 Nov 2026 21:36:05 -0800
Message-ID: <20261126053606.12286-2-matthew.schwartz@linux.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126053606.12286-1-matthew.schwartz@linux.dev>
References: <20261126053606.12286-1-matthew.schwartz@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mod_freesync_build_vrr_params() returns early when the VRR state, the
calculated refresh limits and the fixed refresh target are unchanged,
so a modeset between two modes with the same refresh rate keeps the old
mode's v_total_min/max while VRR stays active. With BTR enabled they
are recalculated on the next flip or the vupdate after it. Without BTR
they stay until six flips come in below the refresh range. Going from
1080p60 to 4K60 on a 40-60 Hz sink, where BTR is off, leaves limits of
1125 and 1687 lines on a 2250-line timing, and they are programmed into
the OTG on every vupdate.

Commit 33c995709121 ("drm/amd/display: Allow VRR params change if
unsynced with the stream") resynced the limits for the inactive state
only. Clear the saved VRR params on a modeset so they are always
rebuilt from the new stream.

Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 318b0c5c1dcb..c4f5670fab38 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -408,6 +408,16 @@ void amdgpu_dm_update_stream_irq_parameters(
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 	vrr_params = acrtc->dm_irq_params.vrr_params;
 
+	/*
+	 * The vtotal limits are in lines of the timing they were calculated
+	 * for. Rebuild them when a modeset replaces that timing.
+	 */
+	if (drm_atomic_crtc_needs_modeset(&new_crtc_state->base)) {
+		memset(&vrr_params, 0, sizeof(vrr_params));
+		vrr_params.adjust.v_total_min = new_stream->timing.v_total;
+		vrr_params.adjust.v_total_max = new_stream->timing.v_total;
+	}
+
 	if (new_crtc_state->vrr_supported &&
 	    config.min_refresh_in_uhz &&
 	    config.max_refresh_in_uhz) {
-- 
2.54.0 (Apple Git-157)


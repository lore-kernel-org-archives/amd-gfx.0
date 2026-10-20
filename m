Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA24606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=it3dAH3Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DAC210F424;
	Tue, 20 Oct 2026 09:19:22 +0000 (UTC)
Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D583A10E55C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 02:52:13 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=fsZ2/yenWE23lLF5ERPoPxL2ipGisj4oFvey0hg8b8A=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792464732; v=1; x=1793069532;
 b=it3dAH3ZMxrI7Ziv1YT1K+vhANaclun94m3Oy0mza6jQNcj3AoOWuxlNkrF3i5GJySyOYXK+
 phl65PhO7/ZVXESYu/Pff8ssVuEt2yk5iAvLolA3GAn/BeeeegXY5f4GyHfltUgCkL8032bD70U
 eVJAIccA8+e0vMRHeQ4hFg2o=
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 3d6d3202044fb8f7;
 Tue, 20 Oct 2026 02:52:12 +0000
X-Mizu-Trace-ID: 3d6d3202044fb8f7
X-Migadu-Flow: FLOW_OUT
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, ivan.lipski@amd.com, jerry.zuo@amd.com,
 aurabindo.pillai@amd.com, Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH] drm/amd/display: Keep the nominal vtotal while VRR is inactive
Date: Mon, 19 Oct 2026 19:51:57 -0700
Message-ID: <20261020025157.2700490-1-matthew.schwartz@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 09:19:18 +0000
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

Commit 33c995709121 ("drm/amd/display: Allow VRR params change if
unsynced with the stream") derives the inactive vtotal from
max_refresh_in_uhz and rounds it up. The round trip through integer
rates can add a line even with VRR off. The ASUS ROG Xbox Ally X20's
120.0004 Hz mode exceeds its 120 Hz EDID maximum, so 1152 lines
become 1153 and the CRTC vblank counter measures 119.89 Hz.

Take both limits from stream->timing.v_total, as
mod_freesync_build_vrr_params() does, which keeps the resync to the
stream's timing. Active VRR keeps the helper's rounding.

Fixes: 33c995709121 ("drm/amd/display: Allow VRR params change if unsynced with the stream")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 4bd060e30799..f154a619b533 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1281,10 +1281,8 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 	 * If VRR is inactive, set vtotal min and max to nominal vtotal
 	 */
 	 if (in_out_vrr->state == VRR_STATE_INACTIVE) {
-		in_out_vrr->adjust.v_total_min =
-			mod_freesync_calc_v_total_from_refresh(stream,
-				in_out_vrr->max_refresh_in_uhz);
-		in_out_vrr->adjust.v_total_max = in_out_vrr->adjust.v_total_min;
+		in_out_vrr->adjust.v_total_min = stream->timing.v_total;
+		in_out_vrr->adjust.v_total_max = stream->timing.v_total;
 		return;
 	}
 }
-- 
2.56.0


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C96606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XbEjNALX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D0D6112119;
	Thu, 26 Nov 2026 08:10:04 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Thu, 26 Nov 2026 05:43:00 UTC
Received: from mta1.migadu.com (out-168.mta1.migadu.com [95.215.58.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7721710E1F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 05:43:00 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=Hs7oZtdnHvx+m75uYZQg7898V/1o9cnjKz45ugOSxVQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795671778; v=1; x=1796276578;
 b=XbEjNALXImF/IZQQwKTXcUiQSUFywi/ZBVuY69itP0z1HEpy6OVX8zuejyBsCsr0NpszZGPU
 FkMzDwEfXv/ISq9+5cBjdx8h6Ngf4I+jOQhjf9JgH2ofY9UPn1NEAGPjEERTdQIV/ttfpljdQhV
 11ASjl2THhDk//W2zeDzLuJU=
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id c5e46d6a2a4de310;
 Thu, 26 Nov 2026 05:36:52 +0000
X-Mizu-Trace-ID: c5e46d6a2a4de310
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
Subject: [PATCH 0/2] drm/amd/display: Rebuild the VRR vtotal limits on a
 modeset
Date: Wed, 25 Nov 2026 21:36:04 -0800
Message-ID: <20261126053606.12286-1-matthew.schwartz@linux.dev>
X-Mailer: git-send-email 2.54.0
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A modeset between two modes with the same refresh rate keeps the
previous mode's v_total_min/max when VRR stays enabled across it, since
mod_freesync_build_vrr_params() only rebuilds them when the VRR state or
refresh range changes. Commit 33c995709121 handled this for the inactive
state. With VRR active and no BTR, the old limits stay in use for as
long as the client keeps flipping at the refresh rate.

This came up with gamescope, which keeps VRR_ENABLED set across mode
changes and, with its adaptive_sync_idle_hold option, presents on every
vblank while the Steam UI is focused. Switching from 1080p60 to 4K60 in
Steam's display settings then gave no picture on a number of HDMI
displays, a Dell S2721QS (40-60 Hz) and an LG CX among them. In the
Dell's log the atomic commit intervals after the switch were 8.3 ms,
12.5 ms and 20.8 ms. Those are 1125, 1687 and 1125 + 1687 lines of the
4K timing, the 1080p limits for 60 and 40 Hz. Without the hold the idle
UI flips slowly enough to reach the fixed refresh path, which rebuilds
the limits, so the problem stayed hidden.

Tested on an ASUS ROG Xbox Ally X20 (internal panel, 30-120 Hz) with a
7.3.1-based kernel and a small KMS test. It sets two 50 Hz modes with
vtotals of 2764 and 2592, turns VRR on in the first and flips at full
rate across a modeset to the second. Without patch 1 the second mode
flips every 21.33 ms, which is the first mode's v_total_min, until VRR
is toggled. With it the interval is 20.1 ms.

Patch 1 clears the saved VRR params on a modeset so they are rebuilt
from the new stream. Patch 2 adds KUnit cases for it.

Matthew Schwartz (2):
  drm/amd/display: Rebuild the VRR vtotal limits on a modeset
  drm/amd/display: Test VRR vtotal limits across a modeset

 .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 10 ++++
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 52 +++++++++++++++++++
 2 files changed, 62 insertions(+)


base-commit: da37959f4a22c6bb25a337fcc7946101c8a10f7b
-- 
2.54.0 (Apple Git-157)


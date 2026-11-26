Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAB606A696
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=verwilst.be header.i=@verwilst.be header.a=rsa-sha256 header.s=protonmail3 header.b=ZrhumbKF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3828112960;
	Fri, 27 Nov 2026 09:58:48 +0000 (UTC)
X-Greylist: delayed 23466 seconds by postgrey-1.36 at gabe;
 Thu, 26 Nov 2026 17:32:36 UTC
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2644E112356
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verwilst.be;
 s=protonmail3; t=1795714353; x=1795973553;
 bh=fWcGytLtp6sHJd3wiHdue6bSMBIZlUEhwE7MfN5xazc=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ZrhumbKFG/zDtJ2uZnvvK/6EYtKvFB3HpQbdZAT4IbzBcQ+yQYz6G4asKuaUdzXGZ
 cSKQ/9e6iRLkse2jwY/ForOhNWbkPpYAAvx37X1KGlghMp3kwDPmu5Tgnjqm6WrDpa
 2sL1r4etcMtcPcgDoYzxLQOjWpB734gX2Ifapz1McpGmLUN8TmqWW35L0Eid/4Mvcj
 SOPlLT4SSXURH+HMImI8ShySsLkbZ0DI+w4io+h2nl2EpY4hIfZurqFQLRiZmb8FhU
 zPEHYNpIZoTsb8lXHZjFfx8QwQxHuOuOOaNqvaXQkzULsrmMf35JlfM+9rzwP0wo8M
 sBy/RJEDW93MA==
X-Pm-Submission-Id: 4jb3XG4ysjz1DDLg
From: Bart Verwilst <bart@verwilst.be>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, Wayne.Lin@amd.com
Subject: [PATCH v3 0/2] drm/amd/display: fix GPU hang on SST<->MST switch of
 the same sink
Date: Thu, 26 Nov 2026 18:31:54 +0100
Message-ID: <20261126173156.13147-1-bart@verwilst.be>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 09:58:44 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Toggling Picture-by-Picture on a Samsung Odyssey Neo G9 57" switches
the sink between SST (PbP) and MST (fullscreen) on the same UHBR link. On
an RX 9070 XT (DCN 4.0.1) it hard-locked the machine every time: the
stale stream of the previous mode is torn down after the new mode's
stream is lit, and that teardown powers the sink down and turns the PHY
off under the new stream. Analysis and logs are in
https://gitlab.freedesktop.org/drm/amd/-/work_items/5671

Patch 2 fixes the teardown. Patch 1 makes the MST payload release in
amdgpu_dm safe against releasing a payload twice or one that was never
added. The tested sequences hit both, and without patch 1 payload_count
underflows.

Tested on 7.3.5 with the equivalent code in link_dpms.c, with DP AUX
debug logging: PbP off and on, and DPMS sleep/wake in both modes,
including a wake where the first UHBR13.5 training fails with channel EQ
timeouts and the link recovers after re-detection. No hangs, the payloads
always start at slot 0, and the "kept up" path only triggers when the
other mode's stream is enabled.

Changes in v3:
- 1/2: when there are no time slots to release, still drop the port
  malloc reference of a deleted payload and mark it unallocated, as
  drm_dp_remove_payload_part2() does. drm_dp_mst_destroy_state() skips
  deleted payloads, so skipping part2 entirely leaked the reference.
  The two teardowns this guards against run on different MST state
  copies, so each copy still drops its own reference exactly once.
- 1/2: add Fixes: tag.
- 2/2: unchanged.

Changes in v2 (thanks to the Sashiko review of v1):
- Detect a stale stream by checking the current state for an enabled
  stream of the other mode on the same link, instead of comparing the
  signal with link->type. link->type is temporarily SST during
  detection, so v1 also skipped the teardown during destructive link
  verification on an MST link and released the payload twice.
- Use link_set_dsc_on_stream() for the stale stream so the sink's
  DP_DSC_ENABLE is left alone.
- Skip deallocate_usb4_bandwidth() for the stale stream.
- Clear the stale stream encoder's VC rate and hblank settings when the
  link runs 128b/132b.
- New patch 1/2.

v2: https://lore.kernel.org/amd-gfx/20261126110042.14612-1-bart@verwilst.be/
v1: https://lore.kernel.org/amd-gfx/20261125184208.36789-1-bart@verwilst.be/


Bart Verwilst (2):
  drm/amd/display: don't release an MST payload that holds no time slots
  drm/amd/display: don't tear down a shared link for a stale SST/MST
    stream

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 31 +++++-
 .../drm/amd/display/dc/link/link_dpms_v1.c    | 96 +++++++++++++++++--
 2 files changed, 118 insertions(+), 9 deletions(-)

-- 
2.56.1


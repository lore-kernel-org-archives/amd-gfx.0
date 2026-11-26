Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858A606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=verwilst.be header.i=@verwilst.be header.a=rsa-sha256 header.s=protonmail3 header.b=ZdMPv899
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7660111243C;
	Thu, 26 Nov 2026 13:49:07 +0000 (UTC)
X-Greylist: delayed 58712 seconds by postgrey-1.36 at gabe;
 Thu, 26 Nov 2026 11:01:09 UTC
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch
 [109.224.244.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B803210E3A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verwilst.be;
 s=protonmail3; t=1795690867; x=1795950067;
 bh=A3f74+4FnrGE2x0I5qvPaJCeDAAW9/tqbWysHjKYFrY=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ZdMPv899efRxn4sNN9NEfeTbYGL6fmLbZxKirynV7sQhU4KdMSi/oCDrIyxQCfpBr
 3nMEi2mSFt/HvI58qm3FzQev/9l0x6mAD6XZfbBRV52TrhnORRpuDC6mrka2Jo5Ci3
 hGXuVKCQs78898AfKZZfAFqLQimiWpenrv9MOr1Wu/5EIugnBw6a9bZ3MPsuSz7gcV
 110mJbeDU8XF6jYXoRUnAIkYIGVY9xiWvz36RsHpN6yz824kYTB5ajyHIJSE9KWwaL
 xZv4aV27vkPCrTeR2uM/SK/GUOidacauujKHthxsgNk5YsLYDDPAXnwTTWoJ6qzukS
 KO4aTX7OvptVw==
X-Pm-Submission-Id: 4jZtrc1C3zz2ScQK
From: Bart Verwilst <bart@verwilst.be>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, Wayne.Lin@amd.com
Subject: [PATCH v2 0/2] drm/amd/display: fix GPU hang on SST<->MST switch of
 the same sink
Date: Thu, 26 Nov 2026 12:00:40 +0100
Message-ID: <20261126110042.14612-1-bart@verwilst.be>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:48:49 +0000
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

v1: https://lore.kernel.org/amd-gfx/20261125184208.36789-1-bart@verwilst.be/


Bart Verwilst (2):
  drm/amd/display: don't release an MST payload that holds no time slots
  drm/amd/display: don't tear down a shared link for a stale SST/MST
    stream

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 16 ++++
 .../drm/amd/display/dc/link/link_dpms_v1.c    | 96 +++++++++++++++++--
 2 files changed, 106 insertions(+), 6 deletions(-)

-- 
2.56.1


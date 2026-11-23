Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64B606A337
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=okonski-org.20260707.gappssmtp.com header.i=@okonski-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KdVAqtaG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 474AB10F365;
	Tue, 24 Nov 2026 08:40:26 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6A510ECAE
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 22:11:35 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b8786bb305so4707375a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 14:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=okonski-org.20260707.gappssmtp.com; s=20260707; t=1795471893; x=1796076693;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wrbZvtX9auyLdMA7XsHgJrd1m9Tl2lVAyzPMGYT9XzM=;
 b=KdVAqtaGHU38hYen/WRWC+pU9/wWeCOP063HxXlVccClruksQTLzR9mxifDMIV8e8f
 eNeiS3NRrTmsqWMbqg98gAMwYXkKFQJNy3aqdenYkEILVWom59YcW2b67Yi2uAUCeYu1
 E6/IbUl2M9Tj9eHIkg7DEn8P9C3vPJxfZO+QvUhB/sVYLp+0vaggh6PUfWPT9rWZGkif
 3S29MK3Z/NfzSjTZ7LPnJjQ/OKt4fLLZPaNCDWGddAcfZrs5nCZHMXmR30Pk4+SVryVr
 iRBIukFEWclft84eSjXbrCNunxXoCh6XPK+Twu8Pj56iwtYLzAyrWn/+o4nIn9MRMk5i
 CInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795471893; x=1796076693;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wrbZvtX9auyLdMA7XsHgJrd1m9Tl2lVAyzPMGYT9XzM=;
 b=NHMm7JifNAuauIZ+4bp4aj72Hr02sUILPUBeT/chgpA+eXZ56hHtKNNs071xo4npq9
 GasnqjH03L7PnmABqSRRO1QfJiWJcVIQXsJoQRpYGkDr3r7FOaZ16+GjH/lTJuMxcQip
 skM3dg62Sxk4T18EfK7hU2MmIFlgPTASJAvpCw9HfOhBi+NrevBap49+RXXoY0qu7pWZ
 /kiPaGXCrK7WDJiMvUW9e0IN06bgW2T5YRSZM+86SYSlfZC8wKZ34SGXng8/7qvn64bz
 H8i1PywQY9TGoVtbrkajg57HLrtsjDVb5frgLy2KMBoi/vNhAHmfBxwGI7CX07uCzfU3
 F6zQ==
X-Gm-Message-State: APuU4Z+sG+F7gUgTj3SyHUOBgVf5e/s5sIdwLHhpm36SjD6XZKEY433l
 xPxIrvgWp2Ai3Tm1LCFJcacM2p0WoTuxITjJYfBTQ0pmmSEg2e6u6bg73cY1ReGTxk5GbxvM4hz
 Lof7dUuP/bg==
X-Gm-Gg: AZFdTZcDePnALw2fm/yMDjKn1W7zIhPwTosH7Ka3eTgiqf5Ug49QSlTiKzEQkGEdxBf
 uAXXcj+NKtx3SpHcvS2+2nQvxxzh3S8x2j2BRt8PHrBk16gVQSIBk/nPPVcK+H05yB+qTyckQWE
 YG8wizl5WEDnAszshrG5ENN1VbAVbyxZNWbd7G+YfGQopLprZonEqR7wacTinkdFmo8paG0DGMX
 pEvQHbPFHPGBdZq7PjwDtVoOGH9bU0ZB9/QuOpuVvdWvQnjavjwwCmIaHN1gnydajmkRyr3kLef
 upEpitfXEFJsznOWV7Chl/nxy5ai9Q1hM3YAqqfZMcbf0Mnrdh/X7xYmZtwqN8qzbIKnk3m740t
 dROgCgglIM7PLDWgcWM4oPjCX+ERw4LQnMMsBV3kU85mYxIgPQeq27lScnOrOZ9F9+u0EGEaSWo
 g1HI6jkXKzyrq7HNNBONaUx2ZyOuvQw0uGk6FgD2y5IxtB8UGedLqDNb28R+MroBnFO8fC95FKF
 4msROmVLylG433G9jjVMJeoMTzR0bg6qLc2vyIhjQRtlvbc9PNRaUNfN0wA9l2g6vWcEwhRFSrP
 svxshONt0vW8dIF0caAPTSBi/O10Ov0N7GtZQxvEYTkCGQ21NWPV5gD83PVIU3kbKkCuxol/OcC
 IwO5t+gKhX+UbNCENgvjGGnjpZojpaTE6gFV1+0O4ZNOG8Q==
X-Received: by 2002:a05:6402:1ed6:b0:6ba:8541:e530 with SMTP id
 4fb4d7f45d1cf-6ba8541e8ccmr5020204a12.45.1795471893197; 
 Mon, 23 Nov 2026 14:11:33 -0800 (PST)
Received: from vautera ([2a02:21a0:10:748:2::2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba37109b55sm5678828a12.32.2026.11.23.14.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 14:11:31 -0800 (PST)
From: =?UTF-8?q?Jakub=20Oko=C5=84ski?= <jakub@okonski.org>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Subject: [RFC PATCH 0/2] drm/amd/display: avoid flip_done waits on TEST_ONLY
 commits
Date: Mon, 23 Nov 2026 23:09:11 +0100
Message-ID: <20261123220913.937402-1-jakub@okonski.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:40:19 +0000
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

(bear with me because it's the first patch I've ever sent over email)

I tested overlays on KWin 6.8 and noticed a big latency tail for
DRM_MODE_ATOMIC_TEST_ONLY | NONBLOCK checks that KWin does to plan the
frame and decide whether it needs composition or direct scanout.
The testing happened on an RX 6900 XT RDNA2 GPU. The stalls happen
whenever planes move on or off an overlay or change geometry with the
previous commit still pending.

The stall happens in amdgpu_dm_atomic_check(): dm_update_plane_state()
sets needs_dc_state_realloc, which calls do_aquire_global_lock() and
waits for both hw_done and flip_done on the CRTC's newest commit, even
though TEST_ONLY publishes no state and mode-only DC validation takes
<= ~0.1 ms.

This RFC adds a test_only bit to struct drm_atomic_commit (1/2) and
skips the flip_done wait in do_aquire_global_lock() for non-modeset
TEST_ONLY checks (2/2), keeping all locks, the hw_done wait, and the
full drain for modeset tests and real commits.

I tested my 7.3.4 kernel at stock and with this series. A recorded
desktop session lasting ~26 seconds and replayed with libinput replay.
A browser window navigating to a page and interacting with it causing
redraws in response to input. farnoy.dev/tools/mouse-latency.

Captured stalls from this scenario break down like this:

+--------------------------+-----------+----------+
|                   Metric | Unpatched |  Patched |
+--------------------------+-----------+----------+
|              Replay runs |        10 |        5 |
|         Presented frames |      5943 |     3019 |
|         TEST_ONLY ioctls |     51305 |    25627 |
| TEST_ONLY stalls >= 2 ms |        13 |        2 |
|          flip_done waits |         9 |        0 |
|            hw_done waits |         4 |        2 |
+--------------------------+-----------+----------+

No flip timeouts or atomic commit failures were observed.

The remaining two long waits were on hw_done: tracing the previous
commit worker showed 99.3% of each ~7 ms wait inside
dc_update_planes_and_stream(), returning 9-19 us after a late flip.

Patches written by an LLM, reviewed and tested by me.
Compile-tested on amd-staging-drm-next 8dd68a79583a.

I was told Harry is working on this specific area but I'd already tested
this change by then, so I'm pushing in case this is useful. I have no
idea whether this works on <=gfx9 or >gfx10, and I have not attempted to
improve the hw_done waits.

Jakub Okoński (2):
  drm/atomic: record TEST_ONLY ioctl intent in drm_atomic_commit
  drm/amd/display: Skip flip_done wait for non-modeset TEST_ONLY checks

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++-------
 drivers/gpu/drm/drm_atomic_uapi.c                 |  1 +
 include/drm/drm_atomic.h                          |  7 +++++++
 3 files changed, 16 insertions(+), 7 deletions(-)


base-commit: 8dd68a79583aaf6df6fe4feea3ee9e9f26b02993
-- 
2.56.0


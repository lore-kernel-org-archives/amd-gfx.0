Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988C2F3D5FF
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 09:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B5010E3C2;
	Sun, 29 Mar 2026 09:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oPiMeThJ";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B4710E0C2
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 04:40:22 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5a1307438ddso3676320e87.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 21:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774759221; x=1775364021; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcGJbj7h0oQzFh8oX9WEnAzHe8+hA/L2+cZvZJQO7s4=;
 b=oPiMeThJkRoXDbdXHv/j5x4Ap3kGdAMsG9dOV0q9KnVPEgWRxa2e19l//R/re/2Ba4
 WovDjtoZKe+mDUxadoFt+61OH8wWZl6+LPfzRS/1FAmGnrBfd3aytsWOAa9smKsTNW7d
 aHc07DgoIgsayuLBiwErFxM0pKW2eOJ2AlZUojF630Dp+Am7AkwCCXS4fPdtWJLw5oFo
 CKnElCoxVgUH+x3a5lo3lJiddoHKc17UkjM57ZqUnQnPafhVDJMN9QyoUDvIBKBSF0uR
 Q7iHwrG2BQdeXdbU7CFN8nVD4lkjPYUpoN7s4MdRzEDIj1WziIH9fOgQ6pSA3sncqJXx
 3yHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774759221; x=1775364021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HcGJbj7h0oQzFh8oX9WEnAzHe8+hA/L2+cZvZJQO7s4=;
 b=m1fKygcztlY516LJgwr9qEmSdV8rtbETVTGllYHs6gs0HzdRmWLlPJA1GP8unfPnEM
 3fz7WIrMZMjD9JpkFgpJAYTG12zJKHdumk9/H6EKODQ6nv7LVaRN2HadqCf3Zz8L38BV
 nhghGScCxYa6iTWET72/ppQd/yHdyKRqOVmUFCFqCH2Et6d5HWeKEY3IclS/CI0k5nyR
 lPTONvNwH4Edx5FudQtKY2QeDH+4jvxg0yCQY3cX07DCE9om9PRW0yUyh/JJwUC1xaVY
 Y5HDSxG75LZLImeLdBUQk0TQtazPAZM17bn1K3S95YYgdr0tPAU70PTXkIZeqRN87K1m
 HW/Q==
X-Gm-Message-State: AOJu0Yw1mm+mArpN4/P6mh2NJypmPlwouuqk3iQQBpni8LfMB0lBFOKF
 SsCwVrc2MWe2RWXmFLpEAtQbJr1v1hwRJIuwn8vR5lT2ZDuly9NbXeVtTShYVo0=
X-Gm-Gg: ATEYQzxCUQeJDLV8qNTorOXoomYhWWgkzrQ1pBhrDwz925psMlDwAM/O2Z9CZx6v7K+
 lIYmBqaACCUtRyQZTBhBL3DWU6achSWuV1terdAI/vrkpDpiKBUUtWamgeTqXKHmHUnDhzr7s9M
 RcRKjBJOLOC5x+IIxHv7witpmJc7klILeO88ZFWdCELSuOrF+UZN+t6dfjW6JcJn4SkIKKqyk5o
 Dlz1dyGOgV64zQmIP1skdEoVgvopVmchSfL2Fzdp6WQbUjYZk77UutggOVS0eBZ+6Ig4S9y0S0L
 m1WGNA58C1w2H+FVdk5g9bhoEnSzMBjQjZZPMytcDpgxY235z4Xm0geuFLTYAAIjcg/jsu6OADt
 SCVM0bOV+vas9jd9atlJzsNgKl+qZzc3S8wHwydDhK++AshljqtKFjuWAVL/O/ghzfGc4++DjKf
 KXR64CQl0EYouytqxDzB1Z8SBisLA=
X-Received: by 2002:a05:6512:ac9:b0:5a2:b57d:9522 with SMTP id
 2adb3069b0e04-5a2b57d97a3mr25512e87.23.1774759220478; 
 Sat, 28 Mar 2026 21:40:20 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b145772fsm836212e87.71.2026.03.28.21.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 21:40:20 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Sbenazar <voroninan95ton@gmail.com>
Subject: [PATCH v3 0/4] drm/amd/display: fix Panel Replay artifacts on DCN
 3.14 (Phoenix/Hawk Point)
Date: Sun, 29 Mar 2026 07:40:04 +0300
Message-ID: <20260329044014.30276-1-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:57:18 +0000
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

Changes since v1:
- Patch 1: expanded commit message to mention PSR impact too (code
  unchanged).
- Patch 2: rewritten. Instead of piggybacking on psr_dirty_rects_change
  _timestamp_ns, add a dedicated replay_disabled_timestamp_ns field to
  struct replay_settings. The re-enable guard in
  amdgpu_dm_enable_self_refresh() now checks the replay timestamp
  separately from the PSR timestamp, so neither feature can interfere
  with the other's timing.
- Patch 3: drop redundant NULL check on stream — the caller already
  guarantees it is non-NULL (code simplified).
- Patch 4: new. Add the same 500ms timestamp guard to the
  vblank_control_worker path (amdgpu_dm_crtc_set_panel_sr_feature),
  which was unprotected and could re-enable Replay too soon when vblank
  events were toggled during animations.

This series fixes visual artifacts caused by Panel Replay on AMD Phoenix
APUs (Radeon 780M, DCN 3.14). The artifacts appear as brief
green/purple horizontal bands during screen updates — workspace
switches, browser scrolling, window management. They are widely reported
across vendors (Framework 16, Lenovo T14, HONOR MagicBook) and tracked
as drm/amd#5087.

Root cause analysis identified two driver bugs, one missing guard, and
one firmware issue:

1. sr_skip_count is never reset after non-fast updates, allowing
   Panel Replay (and PSR) to be re-enabled on the very first fast commit
   following a full-frame update that disabled it. During compositor
   animations (e.g., GNOME workspace switch), this causes Replay
   to reactivate mid-animation.

2. The 500ms re-enable guard in amdgpu_dm_enable_self_refresh() uses
   psr_dirty_rects_change_timestamp_ns, which is only updated in the
   PSR-SU code path. For Panel Replay, this timestamp is never set,
   so the guard always passes — making it ineffective.

3. The vblank_control_worker path (amdgpu_dm_crtc_set_panel_sr_feature)
   can re-enable Panel Replay without any timestamp guard at all.

4. The DMCUB firmware on DCN 3.14 produces corruption during
   selective updates within FreeSync Replay.

Patches 1–2 fix the timing bugs, patch 4 closes the vblank worker
re-enable hole, and patch 3 works around the firmware issue by forcing
full-frame dirty rects on DCN 3.14.

With all four patches, Phoenix/Hawk Point systems can use Panel Replay
without artifacts and without the amdgpu.dcdebugmask=0x410 workaround
that currently disables Replay entirely.

Tested-on: HONOR MagicBook Art 14 (FMI-XX), AMD Ryzen 7 8845HS,
           Radeon 780M, Fedora 43, kernel 6.19.9

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5087
Link: https://community.frame.work/t/workaround-graphical-corruption-with-780m-igpu/61750

Sbenazar (4):
  drm/amd/display: reset sr_skip_count on non-fast updates
  drm/amd/display: add replay-specific timestamp for re-enable guard
  drm/amd/display: force full frame updates for Replay on DCN 3.14
  drm/amd/display: add timestamp guard to vblank_control_worker for
    Replay

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 32 +++++++++++++++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  8 ++++++
 drivers/gpu/drm/amd/display/dc/dc_types.h          |  2 ++
 3 files changed, 40 insertions(+), 2 deletions(-)

--
2.48.1


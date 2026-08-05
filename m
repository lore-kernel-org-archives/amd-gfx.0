Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA34C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 06:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A89510F0E4;
	Thu,  6 Aug 2026 06:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nnWN0+eu";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A8B10EE1E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 11:53:17 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d01663d816so7872275ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785930797; x=1786535597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WGEjJRPxBUpZE9ODlFiAwB4aCcOEMOBGe+ZlT7mRGvE=;
 b=nnWN0+euqEeBN7aRc+dsSRdE/XLuwRUWEynVpWGrvRjAKYkpHBg7cC+gpOYjRqQhKX
 p2UzlVuzN2EGapn1+n6XsuzO5DojUmLlZz5/ey+owuwiP7DlUGXUcu80uCtV1rCJtcYt
 JF7/O7ZOXjV1B1K36pgirvjkn+I1/jcs7dnTClzXZa0yj+yYQtJoZeU+7Lke/IdbUj69
 PrOmYEH6o58U6m9BYiSpMCj+qI4E0KOKMch3iPp287wlgSsspOsQ5fPhX4Z+fXkblEji
 vdA/ESUjl2/092DXR30KMmZj+Dnn9vBQYUUF8bRFxDprHnL2pX1D9eaea0Sgc7/obriR
 B4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785930797; x=1786535597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WGEjJRPxBUpZE9ODlFiAwB4aCcOEMOBGe+ZlT7mRGvE=;
 b=SeQ186BwkdaQAL9xZ10ZPI6gXesNYrlanukKDvUJ9GGHsZfYFRpTV+vOh1gc3sA7NC
 7GispN5a0zKYIfok5DU255K47CvPJEJBpVjtRAH4kK9am6XrzoyBe9OBa3O5+KPH4Rmv
 yWdxX7nG/pBsd47BEFFoUVAZ+fmW1/d3y5OtslpANrG0RcrRhXiMUAyVt1Fva1S0BG/V
 DSOVdTkE5siXETQd7GUJx/YW+fENFuUSSOX7X/nrfNe4d6V3R8nhJIK5jsWyjOP133MY
 7S1RgbbQNgdar9+Nr2/SKbep6Yv6mYEspDmWjAPeE4bUNRzfS1+4QJeamFpgGApcM1Pc
 rImA==
X-Gm-Message-State: AOJu0YwaqY/N6YEBZ+PonhQ6m9zPG/pr7cQw2xKGNZtz/wfnumGKHPF9
 2T2kl8Z1xig5XTpRsnU7KuEQJxL0X7IivkEnOXV/MmY4pYxI2MWILUXj+xcypz55oj4=
X-Gm-Gg: AR+sD10+mnUCnkuuPdtQjKqjWk10+JPgb7CJJDxUJTT3+ZFz8QPLzrTmUM24jJI4bNF
 UdlfcbUyHSVha3M5KdNBiZWiHH+ZpLGkRg/XmmM+yuRoe6Peaufd8IPH8rvHGjHo5IOT2mI1/rk
 ekHv6ZPegvGzIANjuX5Bip6Zs0mk+6QSWcHpRD+WsRSMrr3Zx9cv26PL6+TPn9zJnL4Uz1TBQw/
 aA2YddhQCxrj6dMD8SZs3Q57+uuC9X7bC5q1UF+vWB9qZyQ0D0npu4xWWXqSYLRSbnCUm2uHU14
 8Y541sLKll/MFGh0fyaWp454RlQ+1sdOZ4AUs6w2TzPpjk/aMwT+veh2hWaXfON2I+KB+F6pSGa
 GPKzO+8Di30yuXKR+4b76CGgKlmbW/IHUbYe5SWyD15QkOi/C2YftZBGuRUGhWsXsTcV5kX3hvQ
 6FE/fpqga7ouBUswNCMvEMZ/Yjm+wOadsZE0QRDmBgfmrpIpqsNVGE0J8kMzpw46LetW4JObJDl
 TJOonjk2rUTakhdRsC21/mz
X-Received: by 2002:a17:90b:4f91:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-3903c542f49mr5540437a91.2.1785930796828; 
 Wed, 05 Aug 2026 04:53:16 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38febfdae56sm4667245a91.2.2026.08.05.04.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 04:53:16 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 someguy@effective-light.com, David Weber <weber.aulendorf@gmail.com>
Subject: [RFC PATCH 0/5] drm/amd/display: recover from PSR-related display
 stalls
Date: Wed,  5 Aug 2026 13:52:43 +0200
Message-ID: <cover.1785929873.git.weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:55:47 +0000
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

Hi,

I am still trying to find every PSR problem on my system by running
different stress tests.

One thing that has always bothered me about PSR failures is that I cannot
recover from them.  Automatic recovery does not kick in, and manually
requesting GPU recovery has never brought back a working graphical
session for me.  I always have to restart the machine.  I would like to
change that.

This RFC comes from a reproducible eDP failure on a Lenovo system with an
AMD Ryzen 5 PRO 7540U and Radeon 740M Graphics (DCN 3.1.4).  On this
machine, the observed failure starts with DMCUB errors while PSR is enabled
and leaves a page flip permanently pending.  Atomic commits then block,
KWin repeatedly reports page-flip timeouts, and the display freezes for
good.

The first three patches fix problems I found while tracing this failure.
In particular, PSR state polling currently nests two
1001-iteration retry loops.  Since each GPINT transaction can busy-wait
for 30 us, an intended roughly 500 ms transition wait can occupy a CPU
for roughly 30 seconds.  The changes remove the nested retry, propagate
an unconfirmed transition back to the caller, track whether the cached
request is valid, and invalidate that cache when DMUB is reset or resumed.

This bounds the wait and lets a later policy request retry, but it does
not recover a display pipeline which is already stuck.  Patch 4 tries to
do that.  It handles a failed bounded PSR exit and a flip timeout on a
PSR-capable eDP link, disables PSR for the rest of the driver instance,
queues a full GPU reset through the AMDGPU reset domain, deals with the
stuck flip/commit state, and forces a modeset afterwards.  Patch 5 adds
two debugfs controls for fault injection so the recovery path can be
tested without waiting for a natural failure.  These controls are only
for debugging.

Patch 4 puts failure detection, the persistent PSR fallback, and GPU
recovery into one patch so the whole idea can be discussed together.

I kept the PSR recovery separate from the generic
dm_helpers_dmu_timeout() callback.  There is already another proposal
which uses that callback to reinitialize DMUB locally:

  https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg142429.html

There is also a proposal which tries a full modeset after a generic page
flip timeout:

  https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg142493.html

I would especially like feedback on these questions.

1. Could this be upstreamed?

   Are the bounded polling and cache fixes in patches 1-3 useful on their
   own?  Is a PSR-specific recovery path like patch 4 a reasonable way to
   deal with failures which have already wedged scanout?

   Is testing on one DCN 3.1.4 system enough for this RFC, or do PSR,
   DMUB, and reset handling differ enough between DCN generations that
   testing on more hardware is necessary?

2. Is the approximately 530 ms PSR transition bound appropriate?

   The old roughly 30-second wait looks like an accidental result of the
   nested retries, not an intentional timeout.  However, PSR policy
   transitions can also happen through the ABM/backlight path, and valid
   DMUB operations have been reported to take longer than shorter timeout
   limits.  Should this use a wall-clock deadline, a different limit for
   each path, or simply a larger limit?

3. Which failures should trigger a full recovery?

   The direct trigger only fires when a bounded synchronous PSR disable
   fails after software had previously confirmed PSR as enabled.  The
   flip-timeout trigger is less certain: it fires on an eDP CRTC whose
   link still has PSR enabled as a feature.  The cached allow-active
   request is not proof of firmware state because it may describe an exit
   which firmware never completed.  Is eDP plus PSR-feature-enabled a
   reasonable trigger, or is that too broad because the flip could have
   stalled for another reason?

4. What should the recovery escalation and DRM-state handling be?

   Restarting DMUB may make commands work again without clearing the
   pending HUBP flip or DRM commit state.  A manually requested full GPU
   reset completed on this system, including DMUB initialization and ring
   tests, but still did not bring the display back.  This RFC therefore
   adds handling around the existing full-reset path and performs another
   modeset afterwards.  The complete sequence recovered one natural
   failure, but I do not yet know which extra step made the difference.

   Would a smaller step-by-step recovery be better, for example:

     a. a forced modeset,
     b. DMUB-local reinitialization,
     c. full GPU recovery, and
     d. a post-reset forced modeset?

   If restarting DMUB works, how can the kernel reliably tell whether
   scanout and atomic commits are moving again?

   The current code keeps a reference to the exact timed-out commit.  It
   resets first so scanout is stopped and rebuilt, then retires only that
   flip if its original event is still pending.  It waits for a post-reset
   vblank before falling back to a synthetic event.  Is this an acceptable
   way to release the atomic commit, or does DRM need a separate way to
   abort one?

   The successful recovery included the forced modeset, but that does not
   prove it was needed after DM's normal reset restore.  I kept it for now
   and verify that its flip really completes.  Should it stay, only run
   after a failed progress check, or be removed until an A/B test proves
   it is needed?  Should some of this instead be shared through AMDGPU
   display pre-reset/post-reset hooks or with the generic DMUB-timeout and
   page-flip-timeout work linked above?

   The worker currently holds all modeset locks across the full GPU reset
   to stop another atomic commit from racing recovery.  This works because
   DM's reset-specific suspend path does not take those locks again, but it
   makes recovery depend on that behavior.  Is that safe enough, or should
   reset and commit serialization be handled differently?

5. Is halting DMUB useful fault injection for this failure?

   Patch 5 can either call the recovery worker directly or enter PSR,
   halt DMUB, and request a synchronous PSR exit.  On my system the latter
   looks similar to a natural stall: the PSR exit receives no valid state
   replies and needs the same recovery path.  Recovery from the injected
   failure also works reliably.

   Halting all of DMUB is still more severe than the natural failure and
   can affect unrelated features.  It also does not reproduce the pending
   flip seen during a natural stall.  Is it nevertheless close enough to
   be useful for testing recovery from a stalled PSR exit?  Is there a
   better way to inject that failure without stopping all of DMUB, and is
   this a reasonable debug-only interface to include upstream?

   The two controls can be triggered with:

     echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_trigger_psr_recovery
     echo 0xDEADDEAD > \
       /sys/kernel/debug/dri/0/amdgpu_dm_halt_dmub_for_psr_recovery

   The second control is deliberately destructive.  The magic value is a
   safety cookie, and the control refuses to halt DMUB if GPU recovery
   is unavailable, there is no reset domain, or PSR recovery is already
   running or stopping.

Current test status
-------------------

Test system:

  Lenovo 21F8CTO1WW
  AMD Ryzen 5 PRO 7540U / Radeon 740M Graphics
  DCN 3.1.4 / amdgpu
  internal eDP panel
  Plasma/KWin Wayland
  Linux v7.2-rc4

Tested on this system:

  - Patches 1-3 expose failed PSR transitions promptly instead of
    spending tens of seconds in the nested busy-wait.
  - Patch 4 recovered a natural stall with a submitted flip.
    MODE2 recovery reinitialized DMUB and the GPU rings.  No post-reset
    vblank arrived within one second, so recovery retired the exact stuck
    flip, its commit cleanup completed, and the forced modeset and flip
    validation succeeded.  The existing Plasma session remained usable
    afterwards without any observed problems.  Once the flip timeout was
    detected, recovery took 2.1 seconds and produced an AMDGPU device
    coredump.

    An abridged log was:

      [   94.193436] [drm] *ERROR* [CRTC:376:crtc-0] flip_done timed out
      [   94.193454] [drm] *ERROR* [CRTC:376:crtc-0] eDP flip timeout: link=0 psr=1 request_valid=1 request=1 submitted=1
      [   94.193504] [drm] PSR recovery: recorded 1 commits and 1 submitted flips
      [   95.212736] amdgpu: GPU reset(1) succeeded!
      [   96.219900] [drm] [CRTC:376:crtc-0] no vblank after PSR recovery; retiring flip without one
      [   96.219922] [drm] PSR recovery: retired 1 recovered flips
      [   96.219926] [drm] PSR recovery: recorded commits quiesced
      [   96.220247] [drm] PSR recovery: PSR disabled after reset (sink writes=1)
      [   96.259603] [drm] PSR recovery: forced modeset and flip validation returned 0
      [   96.259928] [drm] PSR display recovery completed
  - I ran the injected DMUB-halt recovery from patches 4 and 5 many times.
    Recovery completed successfully each time, and the existing Plasma
    session remained usable afterwards without any observed problems.
    One run also exercised the retained-flip refresh: the initial snapshot
    recorded one commit and no submitted flip.  After reset, recovery found
    the newly submitted flip belonging to that retained commit, retired it,
    and its cleanup completed.  The forced modeset and flip validation
    succeeded.  Once the PSR exit timeout was detected, this recovery took
    5.3 seconds and produced an AMDGPU device coredump.
  - The post-modeset PSR fallback remained effective after that recovery;
    debugfs reported "Driver support: no" for the eDP link.

Not tested:

  - The IRQ-sensitive failure path with CONFIG_PROVE_LOCKING and lockdep.
  - Merging a later exact flip timeout into recovery which was first
    requested by a synchronous PSR transition timeout.
  - Hardware other than this DCN 3.1.4 system.

The series is based on v7.2-rc4 because it regularly produces natural PSR
stalls on my system without fault injection.  If this looks suitable for
a non-RFC revision, I will rebase it onto the latest
amd-staging-drm-next.

AI assistance
-------------

I am learning more about the AMD display code while working on these
problems, but this series is still way over my head.  All patch code in
this RFC was generated with AI assistance.  I did my best to understand
and review the changes, connect them to failures I can reproduce, and
test them on the affected hardware so this is not just generated slop.
Still, it is difficult for me to judge many of the locking, lifetime,
DRM-state, and recovery decisions.  That is also why I am sending this
as an RFC and asking for help with the overall direction.

David Weber (5):
  drm/amd/display: avoid nested retries when polling PSR state
  drm/amd/display: retry unconfirmed PSR transitions
  drm/amd/display: invalidate PSR request cache after DMUB reset
  drm/amd/display: recover from fatal PSR-related display timeouts
  drm/amd/display: add PSR recovery fault injection

 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 135 +++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  19 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 177 ++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  10 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  14 +-
 .../amdgpu_dm/amdgpu_dm_psr_recovery.c        | 754 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 115 +--
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   8 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   1 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 .../dc/link/protocols/link_dp_irq_handler.c   |  21 +-
 .../link/protocols/link_edp_panel_control.c   |  42 +-
 .../drm/amd/display/modules/inc/mod_power.h   |   5 +-
 .../drm/amd/display/modules/power/power_psr.c | 190 +++--
 20 files changed, 1372 insertions(+), 143 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr_recovery.c


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.54.0


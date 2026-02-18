Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E94E9A04A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 08:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6324310E57D;
	Wed, 18 Feb 2026 08:09:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="H1siHJCN";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F32110E2BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 00:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1771374678; bh=MmRvqvg7/kbJMQDHUKLb3b55sX1rPDH91P90bjLwuNE=;
 h=From:To:Cc:Subject;
 b=H1siHJCNkhe7/qWMudJcaeQ2dZVYiGeKa07F+o+q12Gw6bMLcgEKUGtpVgsUPeLdB
 UPyY/qDMHheWq4SiLtTbNUGOtu/D6B3JB9cIYxuZJ3A0JMamfjX+8IdbayM3H4ileB
 PvaBTNXCzn+3mmzBcLNKd6uclS+OFXzYvWsKtVP5vEAAO/O5V29gWcLtzX7bJ+F65k
 vCN/IxcmkG5M5tgabbVZ2rKKzIp0Tv+hKHj/H/24L5nZEm89ITiQ6hOPNHAlaRXt/p
 87Qw8uU1zduRFZB2BT3ZZEqNUkYxnZ6ebpRCrxPTIE4dPdJCi89SkIt/QG1ripuzOh
 wUlSV35L2metg==
From: Michele Palazzi <sysdadmin@m1k.cloud>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 sunpeng.li@amd.com, Michele Palazzi <sysdadmin@m1k.cloud>
Subject: [PATCH 1/1] drm/amd/display: complete cursor vblank events immediately
Date: Wed, 18 Feb 2026 01:31:04 +0100
Message-ID: <20260218003104.1256473-1-sysdadmin@m1k.cloud>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Feb 2026 08:09:39 +0000
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

Intermittent flip_done timeouts have been observed on AMD GPUs
since kernel 6.12.

Analysis with bpftrace reveals that amdgpu_dm_crtc_handle_vblank() can
incorrectly consume events meant for plane flips during cursor-only
updates. This happens because cursor commits defer event delivery to
the vblank handler, which checks (pflip_status != SUBMITTED). Since
AMDGPU_FLIP_NONE also matches this, cursor events can "steal" the
event slot for subsequent plane flips, leading to timeouts.

The potential for a race was present since commit 473683a03495
("drm/amd/display: Create a file dedicated for CRTC"), then
commit 58a261bfc967 ("drm/amd/display: use a more lax vblank enable
policy for older ASICs") made it happen by reducing vblank
off-delay and making disables happen much more frequently
between commits.

Fix this by sending cursor-only vblank events immediately in
amdgpu_dm_commit_planes(). Since cursor updates are committed to
hardware immediately, deferring the event is unnecessary and
creates race windows for event stealing or starvation if vblank
is disabled before the handler runs.

Tested on DCN 2.1, 3.2, and 3.5.

Fixes: 58a261bfc967 ("drm/amd/display: use a more lax vblank enable policy for older ASICs")
Signed-off-by: Michele Palazzi <sysdadmin@m1k.cloud>
---
I've been chasing intermittent flip_done timeouts on AMD GPUs (7900 GRE first, 9070 XT now)
since kernel 6.12. The hang occurs during normal desktop usage but is much easier to
trigger under specific conditions involving cursor movements and plane updates.

Partially tracked in https://gitlab.freedesktop.org/drm/amd/-/issues/3787

Hardware: Ryzen 7 7800X3D, Radeon RX 9070 XT
Dual DP monitors, 2560x1440, 144Hz
Desktop: KDE Plasma Wayland

The hang was initially observed while using Cisco Webex
(XDG_SESSION_TYPE=x11 /opt/Webex/bin/CiscoCollabHost %U), start a meeting
and screen share a window running Omnissa Horizon client. Then move the cursor
around between the two monitors and the shared window.
Under these conditions the hang usually occurs within a few hours.

Enabling drm.debug masks the issue entirely, the overhead
changes timing enough to close the race window.
So i added debug printks to amdgpu_dm.c and used a small bpftrace script to log the
pageflip lifecycle with per-thread tracking to debug.

bpftrace script:

  config = { missing_probes = "warn" }
  BEGIN { printf("=== flip_done tracer started ===\n"); }
  kprobe:drm_crtc_vblank_on_config       { printf("%lu drm_crtc_vblank_on_config\n", nsecs/1000000); }
  kprobe:drm_vblank_disable_and_save     { printf("%lu drm_vblank_disable_and_save\n", nsecs/1000000); }
  kprobe:dm_pflip_high_irq               { printf("%lu dm_pflip_high_irq\n", nsecs/1000000); }
  kprobe:drm_crtc_send_vblank_event      { printf("%lu drm_crtc_send_vblank_event\n", nsecs/1000000); }
  kprobe:drm_vblank_put                  { printf("%lu drm_vblank_put\n", nsecs/1000000); }
  kprobe:drm_atomic_helper_commit_hw_done { printf("%lu drm_atomic_helper_commit_hw_done\n", nsecs/1000000); }
  kprobe:manage_dm_interrupts            { printf("%lu manage_dm_interrupts\n", nsecs/1000000); }
  kprobe:drm_atomic_helper_wait_for_flip_done {
      @wait_start[tid] = nsecs;
      printf("%lu drm_atomic_helper_wait_for_flip_done ENTER [tid=%d]\n", nsecs/1000000, tid);
  }
  kretprobe:drm_atomic_helper_wait_for_flip_done {
      $start = @wait_start[tid];
      $ms = $start > 0 ? (nsecs - $start) / 1000000 : 0;
      if ($ms > 100) {
          printf("%lu drm_atomic_helper_wait_for_flip_done TIMEOUT waited %lums [tid=%d]\n",
                 nsecs/1000000, $ms, tid);
      } else {
          printf("%lu drm_atomic_helper_wait_for_flip_done EXIT %lums [tid=%d]\n",
                 nsecs/1000000, $ms, tid);
      }
      delete(@wait_start[tid]);
  }
  interval:s:60 { printf("%lu HEARTBEAT\n", nsecs/1000000); }
  END { printf("=== stopped ===\n"); clear(@wait_start); }

The timeout was captured at 17:35:41 CET. The trace timestamps
match dmesg exactly (9942110ms = dmesg 9942.110s).

dmesg output from the timeout:

  [ 9942.110360] [FLIP_DEBUG] wait_for_flip_done took 10329ms!
  [ 9942.110380] [FLIP_DEBUG]  crtc:0 pflip_status=0 event=00000000a0636a23
                  vbl_enabled=1 vbl_refcount=1 vbl_count=1428659
                  disable_immediate=0 active_planes=1

pflip_status=0 (AMDGPU_FLIP_NONE) but event is still non-NULL. The flip was never completed
but the status was already reset to NONE. vblank was enabled, refcount was held, so vblank
IRQs were firing throughout the wait.

The bpftrace captured the exact sequence leading up to the hang. Here's the critical
timeline at ~17:35:31 (9931771), about 10 seconds before the timeout fired:

  9931755 drm_atomic_helper_commit_hw_done
  9931755 drm_atomic_helper_wait_for_flip_done ENTER [tid=35929]
  9931756 dm_pflip_high_irq                           <- normal plane flip, last good one
  9931756 drm_crtc_send_vblank_event
  9931756 drm_vblank_put
  9931756 drm_atomic_helper_wait_for_flip_done EXIT 1ms [tid=35929]
  9931771 drm_vblank_disable_and_save                 <- vblank timer fires
  9931771 drm_crtc_send_vblank_event                  <- event sent WITHOUT dm_pflip_high_irq
  9931771 drm_vblank_put
  9931771 drm_atomic_helper_commit_hw_done
  9931771 drm_atomic_helper_wait_for_flip_done ENTER [tid=35929]
  9931771 drm_atomic_helper_wait_for_flip_done EXIT 0ms [tid=35929]  <- instant, already done
  9931773 drm_atomic_helper_commit_hw_done
  9931773 drm_atomic_helper_wait_for_flip_done ENTER [tid=36929]     <- new commit
  9931777 dm_pflip_high_irq                           <- pflip fires, completes the wrong one
  9931777 drm_crtc_send_vblank_event
  9931777 drm_vblank_put
  9931777 drm_atomic_helper_wait_for_flip_done EXIT 3ms [tid=36929]
  9931781 drm_atomic_helper_commit_hw_done
  9931781 drm_atomic_helper_wait_for_flip_done ENTER [tid=36929]     <- THIS ONE HANGS
  ... 10328ms of silence ...
  9942110 drm_atomic_helper_wait_for_flip_done TIMEOUT waited 10328ms [tid=36929]

The drm_crtc_send_vblank_event at 9931771 fires without dm_pflip_high_irq. This is
amdgpu_dm_crtc_handle_vblank() sending a cursor-only event. The problem is that the
cursor-only commit path in amdgpu_dm_commit_planes() stores the event in acrtc->event
and defers delivery to the vblank handler. This creates two race conditions:

- The vblank handler checks (pflip_status != SUBMITTED) which also
  matches NONE, so it can consume events meant for plane flips. The subsequent
  dm_pflip_high_irq finds no event, and the next commit hangs.

- If vblank is disabled by the off-delay timer before the handler
  runs, the PENDING cursor event is never delivered and the commit hangs.

The fix is to send cursor-only events immediately via drm_crtc_send_vblank_event()
in amdgpu_dm_commit_planes() instead of deferring to the vblank handler. The cursor
update is already committed to hardware at this point, so immediate delivery is correct.
This eliminates both race conditions by removing cursor events from the deferred
delivery path entirely:

- Plane flips: SUBMITTED -> dm_pflip_high_irq delivers (unchanged)
- Cursor updates: sent immediately in commit_planes (no deferral, no races)

From git history the check in amdgpu_dm_crtc_handle_vblank() has been like this since
473683a03495 ("drm/amd/display: Create a file dedicated for CRTC", 2022)
which moved this code from amdgpu_dm.c, but it was practically impossible to trigger
because the default drm_vblank_offdelay was 5000ms.
Commit 58a261bfc967("drm/amd/display: use a more lax vblank enable policy for older ASICs") in 6.12
changed all ASICs to use drm_crtc_vblank_on_config() with a computed off-delay
of roughly 2 frames (~14ms at 144Hz).
This made drm_vblank_disable_and_save fire hundreds of times more often, turning
a theoretical race into reality. The bpftrace log is full of drm_vblank_disable_and_save
events interleaved with the commit sequence.

This fix was tested on DCN 2.1 (4700U), DCN 3.2 (7600M XT), and DCN 3.5 (9070 XT).
Under high-frequency glxgears + cursor jiggling test the patch successfully intercepted
the race thousands of times without a single timeout.
Also running this on the main system without issues.

This instead https://lists.freedesktop.org/archives/amd-gfx/2026-February/138636.html was
my previously rushed attempt to do something about this that is no longer needed.

Patch applies cleanly on top of tag v6.19.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a8a59126b2d2..35987ce80c71 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10168,8 +10168,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	} else if (cursor_update && acrtc_state->active_planes > 0) {
 		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
 		if (acrtc_attach->base.state->event) {
-			drm_crtc_vblank_get(pcrtc);
-			acrtc_attach->event = acrtc_attach->base.state->event;
+			drm_crtc_send_vblank_event(pcrtc, acrtc_attach->base.state->event);
 			acrtc_attach->base.state->event = NULL;
 		}
 		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
-- 
2.53.0


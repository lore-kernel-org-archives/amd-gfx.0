Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A65FD9E3A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 19:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7139D10EC20;
	Fri, 27 Feb 2026 19:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ki4vp0PZ";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD2F10EC20
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 19:43:39 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2bdbe6bcf4dso107756eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 11:43:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772221418; cv=none;
 d=google.com; s=arc-20240605;
 b=QRKk9mWtrZ1Ce5ExYG4nwbTDLGwCpwOCgdDV0ajaopVbRvuSENxFHm/fRl5UkuPO11
 XqA/RHD4CL3hwjOSsGBrZqp50PxVqzXCA2bbSb4gzPe+D+RRz+LU7mOPaedq/kXmVIIO
 Hzr+NlaD9oD6YqvAeDfAs440cIdfjBh1+1MnXDk7VTJK+ZIQADpKpQ9qp8sBHl+qBMzW
 vs7bjkzwgwnEctb6ewFQNXypBO1IN+8iPoiGbQu50GFWcbEjZ8xhtz4q0YTlKMJXaXTK
 H7LNQvMNNyWz7cI0yLa/5ix5H7kPAa9yeQgO8kOMXZ+OEFak5LeRvUyit+gdlCFJf4pB
 /KYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qPpm4ml/ANElhoGEKVkEdQV9VxB27deAxEwQ/Z6/ENU=;
 fh=H4F3r3p6qGQTC6LG155grTT6qFqsfQ8H2OYZkQq7pPU=;
 b=Sgzs3exV0oZ10sDj9sbgTiPuikajwBJl3/3ED1xIbELYbpwJJzdVNFHO9uxWN7bmjf
 0qbMKlCS4z8jqcMPYRooOhNUMgevNYGIe/J5OPL/nPJXL/YxA6xd92EgIkT6FwogIR2u
 kLa8uetSiid4qD3mfXbjb0I8SFv46jsJFbOmQ0TnHRMeYeWxCi64MbsjQUzP1HpyFSi3
 /AbUe1IgA1zrIigS5JKcEwAEzpOVozPW9FlJbLH/20Mc/E2F5TDxfzXWzmuYEf6b79Po
 GMNszvJylnOzluc9dM5+gdXj5oHm4dDJpxoJf9+S+KM6ejIzozLbwozpYWD661LKW/ZJ
 ohFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772221418; x=1772826218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPpm4ml/ANElhoGEKVkEdQV9VxB27deAxEwQ/Z6/ENU=;
 b=ki4vp0PZQx8RP73pwFGdpxHxalhEJuDz4LgAUdnI3SUS6CwMqWhTcZz3jOHbFFW3uP
 iOH1YDVzTS1KL5gAmbSt6HQamqkwDgFH2/kexaXOoY8tv5pn1A/YDwjW6/8Q2pUeKe9x
 XfyH4cZRZdJxL0sGZiepRnw6LGX+mosqPWcbDjdsv+5SQIQKF+IVdgYSvsGDei2P9Rdd
 jE3DegkyMWTw1msUXWyjBYlnTUq8m3mu4y3oxhOKIHP73kYiDkm8cYyHOddyVpSgTCAs
 YNashatOuedt9BLU3WkJI2C7uqddVk2NCkRXn4R8YN77IdC1PdV8WSOzg0ha2/aPejEc
 CzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772221418; x=1772826218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qPpm4ml/ANElhoGEKVkEdQV9VxB27deAxEwQ/Z6/ENU=;
 b=L2qr1UZz+VZKRsH3jUoVKs7kgddekx1cFd5Azj/CxZRxDziMYiSTEbX+wDZTdXqP55
 RHPc9qa5g6s7UCanOTfprlCKcQMxYCpV3mHiYDNU7eU1+4kg2z/M7MhUSDqcid6ryc8D
 DgOw54VInGuK4TIABO5+FR/Qm1z8v0UOEljWQdxuakY3Q3VCF1b2g+4PCOj07UqkQ9Md
 hvuSMH+YKTMBciPMslSftLYaAzDiM0SmEs4rBLmYHtpgQwDOSsO3TtFtHExzNNKvgLpX
 Lai0rMmaRCz/cfu7CXAen/QcfUZYekEakZgRdSxpRekn3cUQG1DFdfBg+OM/HR3rF3Q1
 ihhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz89SLGRSd2ZJlWthR5tZPwQ6CIE1GavYsx1DmNpatJ+P2SjzBcSHD8UIOuDvDqCVqtxqPkJ89@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoT1wXI8m3wcBztOMCMkDobCrI3+VTblVVqbos3ANcP0h/AdcR
 AzZWp85CmJksfku75PlK5BDQ8eHzge0navEQkpH9I6R1+TXBe1lvKhKvssBengryevYaiwksglf
 R8XwEOXphSfvIBPcnUc8DUJ/u6mYqCaM=
X-Gm-Gg: ATEYQzz2XGK/6WU1kLgYHILDkwHljxGHWq8N7Mq1HIp13Z4qZeinx3XweOe7OFmv7Bg
 Va6Mn0CsKQX4fHdTGTpszFwJ7bgHvM3B/GjmZneuL9rD4iNbAQ8rV+YrvHxl4/X0W/pgPGFDfLv
 4x6CShC3jNyQHGbYOWkbQ2tsMzHDqTirncXewWPmvDcS22paebVZcufZduMw+5arpMMU5FKXIKe
 vmJWLMBE8T+X5w09PfpCDEjYH3XZV2Wbr2ofJa/rdoJGU6CJCe4xlPyNO0vLZUTKGPZsZ8SnKU1
 Ua+5ZMMd/rdraG6HnxPjznMvnICdujKrTpZ8ySbYucHGVsjYLFDNMyQxmgiMLHo1WsmNyg==
X-Received: by 2002:a05:7301:6784:b0:2bd:bc33:ca32 with SMTP id
 5a478bee46e88-2bde1d0f044mr800349eec.4.1772221418159; Fri, 27 Feb 2026
 11:43:38 -0800 (PST)
MIME-Version: 1.0
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
In-Reply-To: <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 27 Feb 2026 14:43:25 -0500
X-Gm-Features: AaiRm51RUXvO1t-V46PUgFqSbOfifrWEjDanCn7_3H32iMbr7qSpvdwMOrNBd6k
Message-ID: <CADnq5_NCJ8v95HFKT4Vy0GvGsSJ8J7u6nwt417C1dXf9PuZTGQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>
Cc: Michele Palazzi <sysdadmin@m1k.cloud>, amd-gfx@lists.freedesktop.org, 
 harry.wentland@amd.com, rodrigo.siqueira@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 23, 2026 at 11:04=E2=80=AFAM Leo Li <sunpeng.li@amd.com> wrote:
>
>
>
> On 2026-02-17 14:16, Michele Palazzi wrote:
> > Intermittent flip_done timeouts have been observed on AMD GPUs
> > since kernel 6.12.
> >
> > Analysis with bpftrace reveals that amdgpu_dm_crtc_handle_vblank() can
> > incorrectly consume events meant for plane flips during cursor-only
> > updates. This happens because cursor commits defer event delivery to
> > the vblank handler, which checks (pflip_status !=3D SUBMITTED). Since
> > AMDGPU_FLIP_NONE also matches this, cursor events can "steal" the
> > event slot for subsequent plane flips, leading to timeouts.
> >
> > The potential for a race was present since commit 473683a03495
> > ("drm/amd/display: Create a file dedicated for CRTC"), then
> > commit 58a261bfc967 ("drm/amd/display: use a more lax vblank enable
> > policy for older ASICs") made it happen by reducing vblank
> > off-delay and making disables happen much more frequently
> > between commits.
> >
> > Fix this by sending cursor-only vblank events immediately in
> > amdgpu_dm_commit_planes(). Since cursor updates are committed to
> > hardware immediately, deferring the event is unnecessary and
> > creates race windows for event stealing or starvation if vblank
> > is disabled before the handler runs.
> >
> > Tested on DCN 2.1, 3.2, and 3.5.
> >
> > Fixes: 58a261bfc967 ("drm/amd/display: use a more lax vblank enable pol=
icy for older ASICs")
> > Signed-off-by: Michele Palazzi <sysdadmin@m1k.cloud>
> > ---
> > I've been chasing intermittent flip_done timeouts on AMD GPUs (7900 GRE=
 first, 9070 XT now)
> > since kernel 6.12. The hang occurs during normal desktop usage but is m=
uch easier to
> > trigger under specific conditions involving cursor movements and plane =
updates.
> >
> > Partially tracked in https://gitlab.freedesktop.org/drm/amd/-/issues/37=
87
> >
> > Hardware: Ryzen 7 7800X3D, Radeon RX 9070 XT
> > Dual DP monitors, 2560x1440, 144Hz
> > Desktop: KDE Plasma Wayland
> >
> > The hang was initially observed while using Cisco Webex
> > (XDG_SESSION_TYPE=3Dx11 /opt/Webex/bin/CiscoCollabHost %U), start a mee=
ting
> > and screen share a window running Omnissa Horizon client. Then move the=
 cursor
> > around between the two monitors and the shared window.
> > Under these conditions the hang usually occurs within a few hours.
> >
> > Enabling drm.debug masks the issue entirely, the overhead
> > changes timing enough to close the race window.
> > So i added debug printks to amdgpu_dm.c and used a small bpftrace scrip=
t to log the
> > pageflip lifecycle with per-thread tracking to debug.
> >
> > bpftrace script:
> >
> >   config =3D { missing_probes =3D "warn" }
> >   BEGIN { printf("=3D=3D=3D flip_done tracer started =3D=3D=3D\n"); }
> >   kprobe:drm_crtc_vblank_on_config       { printf("%lu drm_crtc_vblank_=
on_config\n", nsecs/1000000); }
> >   kprobe:drm_vblank_disable_and_save     { printf("%lu drm_vblank_disab=
le_and_save\n", nsecs/1000000); }
> >   kprobe:dm_pflip_high_irq               { printf("%lu dm_pflip_high_ir=
q\n", nsecs/1000000); }
> >   kprobe:drm_crtc_send_vblank_event      { printf("%lu drm_crtc_send_vb=
lank_event\n", nsecs/1000000); }
> >   kprobe:drm_vblank_put                  { printf("%lu drm_vblank_put\n=
", nsecs/1000000); }
> >   kprobe:drm_atomic_helper_commit_hw_done { printf("%lu drm_atomic_help=
er_commit_hw_done\n", nsecs/1000000); }
> >   kprobe:manage_dm_interrupts            { printf("%lu manage_dm_interr=
upts\n", nsecs/1000000); }
> >   kprobe:drm_atomic_helper_wait_for_flip_done {
> >       @wait_start[tid] =3D nsecs;
> >       printf("%lu drm_atomic_helper_wait_for_flip_done ENTER [tid=3D%d]=
\n", nsecs/1000000, tid);
> >   }
> >   kretprobe:drm_atomic_helper_wait_for_flip_done {
> >       $start =3D @wait_start[tid];
> >       $ms =3D $start > 0 ? (nsecs - $start) / 1000000 : 0;
> >       if ($ms > 100) {
> >           printf("%lu drm_atomic_helper_wait_for_flip_done TIMEOUT wait=
ed %lums [tid=3D%d]\n",
> >                  nsecs/1000000, $ms, tid);
> >       } else {
> >           printf("%lu drm_atomic_helper_wait_for_flip_done EXIT %lums [=
tid=3D%d]\n",
> >                  nsecs/1000000, $ms, tid);
> >       }
> >       delete(@wait_start[tid]);
> >   }
> >   interval:s:60 { printf("%lu HEARTBEAT\n", nsecs/1000000); }
> >   END { printf("=3D=3D=3D stopped =3D=3D=3D\n"); clear(@wait_start); }
> >
> > The timeout was captured at 17:35:41 CET. The trace timestamps
> > match dmesg exactly (9942110ms =3D dmesg 9942.110s).
> >
> > dmesg output from the timeout:
> >
> >   [ 9942.110360] [FLIP_DEBUG] wait_for_flip_done took 10329ms!
> >   [ 9942.110380] [FLIP_DEBUG]  crtc:0 pflip_status=3D0 event=3D00000000=
a0636a23
> >                   vbl_enabled=3D1 vbl_refcount=3D1 vbl_count=3D1428659
> >                   disable_immediate=3D0 active_planes=3D1
> >
> > pflip_status=3D0 (AMDGPU_FLIP_NONE) but event is still non-NULL. The fl=
ip was never completed
> > but the status was already reset to NONE. vblank was enabled, refcount =
was held, so vblank
> > IRQs were firing throughout the wait.
> >
> > The bpftrace captured the exact sequence leading up to the hang. Here's=
 the critical
> > timeline at ~17:35:31 (9931771), about 10 seconds before the timeout fi=
red:
> >
> >   9931755 drm_atomic_helper_commit_hw_done
> >   9931755 drm_atomic_helper_wait_for_flip_done ENTER [tid=3D35929]
> >   9931756 dm_pflip_high_irq                           <- normal plane f=
lip, last good one
> >   9931756 drm_crtc_send_vblank_event
> >   9931756 drm_vblank_put
> >   9931756 drm_atomic_helper_wait_for_flip_done EXIT 1ms [tid=3D35929]
> >   9931771 drm_vblank_disable_and_save                 <- vblank timer f=
ires
> >   9931771 drm_crtc_send_vblank_event                  <- event sent WIT=
HOUT dm_pflip_high_irq
> >   9931771 drm_vblank_put
> >   9931771 drm_atomic_helper_commit_hw_done
> >   9931771 drm_atomic_helper_wait_for_flip_done ENTER [tid=3D35929]
> >   9931771 drm_atomic_helper_wait_for_flip_done EXIT 0ms [tid=3D35929]  =
<- instant, already done
> >   9931773 drm_atomic_helper_commit_hw_done
> >   9931773 drm_atomic_helper_wait_for_flip_done ENTER [tid=3D36929]     =
<- new commit
> >   9931777 dm_pflip_high_irq                           <- pflip fires, c=
ompletes the wrong one
> >   9931777 drm_crtc_send_vblank_event
> >   9931777 drm_vblank_put
> >   9931777 drm_atomic_helper_wait_for_flip_done EXIT 3ms [tid=3D36929]
> >   9931781 drm_atomic_helper_commit_hw_done
> >   9931781 drm_atomic_helper_wait_for_flip_done ENTER [tid=3D36929]     =
<- THIS ONE HANGS
> >   ... 10328ms of silence ...
> >   9942110 drm_atomic_helper_wait_for_flip_done TIMEOUT waited 10328ms [=
tid=3D36929]
> >
> > The drm_crtc_send_vblank_event at 9931771 fires without dm_pflip_high_i=
rq. This is
> > amdgpu_dm_crtc_handle_vblank() sending a cursor-only event. The problem=
 is that the
> > cursor-only commit path in amdgpu_dm_commit_planes() stores the event i=
n acrtc->event
> > and defers delivery to the vblank handler. This creates two race condit=
ions:
> >
> > - The vblank handler checks (pflip_status !=3D SUBMITTED) which also
> >   matches NONE, so it can consume events meant for plane flips. The sub=
sequent
> >   dm_pflip_high_irq finds no event, and the next commit hangs.
> >
> > - If vblank is disabled by the off-delay timer before the handler
> >   runs, the PENDING cursor event is never delivered and the commit hang=
s.
> >
> > The fix is to send cursor-only events immediately via drm_crtc_send_vbl=
ank_event()
> > in amdgpu_dm_commit_planes() instead of deferring to the vblank handler=
. The cursor
> > update is already committed to hardware at this point, so immediate del=
ivery is correct.
> > This eliminates both race conditions by removing cursor events from the=
 deferred
> > delivery path entirely:
> >
> > - Plane flips: SUBMITTED -> dm_pflip_high_irq delivers (unchanged)
> > - Cursor updates: sent immediately in commit_planes (no deferral, no ra=
ces)
> >
> > From git history the check in amdgpu_dm_crtc_handle_vblank() has been l=
ike this since
> > 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC", 2022=
)
> > which moved this code from amdgpu_dm.c, but it was practically impossib=
le to trigger
> > because the default drm_vblank_offdelay was 5000ms.
> > Commit 58a261bfc967("drm/amd/display: use a more lax vblank enable poli=
cy for older ASICs") in 6.12
> > changed all ASICs to use drm_crtc_vblank_on_config() with a computed of=
f-delay
> > of roughly 2 frames (~14ms at 144Hz).
> > This made drm_vblank_disable_and_save fire hundreds of times more often=
, turning
> > a theoretical race into reality. The bpftrace log is full of drm_vblank=
_disable_and_save
> > events interleaved with the commit sequence.
> >
> > This fix was tested on DCN 2.1 (4700U), DCN 3.2 (7600M XT), and DCN 3.5=
 (9070 XT).
> > Under high-frequency glxgears + cursor jiggling test the patch successf=
ully intercepted
> > the race thousands of times without a single timeout.
> > Also running this on the main system without issues.
> >
> > This instead https://lists.freedesktop.org/archives/amd-gfx/2026-Februa=
ry/138636.html was
> > my previously rushed attempt to do something about this that is no long=
er needed.
> >
> > Patch applies cleanly on top of tag v6.19.
>
> Really nice debuging work, thanks for catching this!
>
> Ideally, the cursor event should be delivered when hardware latches onto =
the new
> cursor info and starts scanning it out. The latching event fires an inter=
rupt
> that should be handled by dm_crtc_high_irq().
>
> dm_pflip_high_irq() handles an interrupt specifically for when hardware l=
atches
> onto a new fb address; I don't think it actually fires when there's a
> cursor-only update. I think if we really want to do it right, we can have
> another "acrtc_attach->cursor_event" just for cusror-only updates, and de=
liver
> the event in crtc_high_irq().
>
> In any case, I don't foresee any major issues with delivering the event e=
arly.
> And since it fixes an ongoing issue:
>
> Reviewed-by: Leo Li <sunpeng.li@amd.com>

Leo, I assume you are planning to push this?

Alex

>
> Thanks!
> Leo
>
> >
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index a8a59126b2d2..35987ce80c71 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -10168,8 +10168,7 @@ static void amdgpu_dm_commit_planes(struct drm_=
atomic_state *state,
> >       } else if (cursor_update && acrtc_state->active_planes > 0) {
> >               spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
> >               if (acrtc_attach->base.state->event) {
> > -                     drm_crtc_vblank_get(pcrtc);
> > -                     acrtc_attach->event =3D acrtc_attach->base.state-=
>event;
> > +                     drm_crtc_send_vblank_event(pcrtc, acrtc_attach->b=
ase.state->event);
> >                       acrtc_attach->base.state->event =3D NULL;
> >               }
> >               spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>

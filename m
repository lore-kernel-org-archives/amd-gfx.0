Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F98AC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 19:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E5C208E4
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 19:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E5C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD01A6F991;
	Fri, 29 Nov 2019 19:20:33 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632346F98D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 19:20:31 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z7so32973434wrl.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 11:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y3URCHIofqnuc2sGk2KkeatG5lPXGtz80xmLzMNvNyU=;
 b=dhZavPzUBW+Zo/ExxJ1E5pv2/KK2KOUtUDqZKyYDzbCNf26NBEB+6YkOthf2bmjzIj
 SAU32IkusxbCJNk5npCx46iC0/Hba290HCfbm+JtV7kuPdsGRNmOIIaxpIXO01oKuYlx
 cIje1usu4SJ7l8kVEuDXJe9XxzJj7ExCH8D7AoC7Fv9rVOKXmOj2wOd/O9C8OnztLl6d
 95ga0Uo0SUeJs3K7f6IaG4CoSjRUZd4HallHEZubdZ5X0VgfOhtkESQFsILH+gb2Aug7
 zPFzJtQA0Aen/i9mLoBrsVZ8wd209wryh0dLic1JdE2sTZv42LKUNU7dKHagwh3W6YJq
 8LgQ==
X-Gm-Message-State: APjAAAWlZW/3VDuBbuOQSmwjgkRC1IAfNc8pTcpsnM9yeR8crWdpPV0I
 kSroaWvKnHHaYfET5ECljyoAl5UAUdEs8XnLvJJtszTF
X-Google-Smtp-Source: APXvYqz84OSyFnLoL/9CY5s2L6qjjZwqkV5H+25h4nDLFMVSNdlvrf1SitvqB/r+GaTtCJ5mFmBe+jr7vloJgHeTsmA=
X-Received: by 2002:adf:e886:: with SMTP id d6mr3512063wrm.352.1575055229977; 
 Fri, 29 Nov 2019 11:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20191105153416.32049-1-sunpeng.li@amd.com>
 <c93c503d-48dc-1ea5-19f7-42ff9392e162@amd.com>
 <ed7b7f5e-4a53-f3e1-912f-e0ae5181288c@amd.com>
In-Reply-To: <ed7b7f5e-4a53-f3e1-912f-e0ae5181288c@amd.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Fri, 29 Nov 2019 20:20:18 +0100
Message-ID: <CAEsyxyhe6VLWRTQy3p2brpmemRUMMTGb5SJ-mWrTOXy1FozM6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Send vblank and user events at
 vsartup for DCN
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=Y3URCHIofqnuc2sGk2KkeatG5lPXGtz80xmLzMNvNyU=;
 b=bNjZifazHKoCnC5TVkJ2n7R7uWb5saTQAJRw11AF/XnBkCJWop9ffCKMmDP90hSxjN
 S1iMF43wflRbgMg06HfIviRx5XQvNqOzRf/9K2YbgfJ8XXGxBARhOPgFS5vPv4aT0YOi
 TElLW6xWm56t092dSQyDYCI9nfV8LP3dXGAKn/Qw35TmTYPUuQvH3TLpTiKm4MzAKLKj
 0EMb+qvgPDzboAlX5HZkwVaplGuy6TiDnuRqCSf2hxgUqBXlRLQJ80PDDl0t6XzIm9DO
 pe8qkg1q9LEAqOs5q0mkkgv3xFHppSpmvNNfIu5UIX2RcHztw/BpIo2yKHErpJx7CuLA
 XnUA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0671872427=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0671872427==
Content-Type: multipart/alternative; boundary="0000000000007c088d0598811f86"

--0000000000007c088d0598811f86
Content-Type: text/plain; charset="UTF-8"

Hi Leo and others,

sorry for the late reply. I just spent some time looking at your patches
and testing them on a Raven DCN-1.

I looked at how the vstartup line is computed in the dc_bandwidth_calcs
etc., and added some DRM_DEBUG statements to the dm_dcn_crtc_high_irq and
dm_pflip_high_irq handlers to print the scanline at which the handlers get
invoked.

From my reading and the results my understanding is that VSTARTUP always
fires after end of front-porch in VRR mode, so the dm_dcn_crtc_high_irq
handler will only get invoked in the vsync/back-porch area? This is good
and very important, as otherwise all the vblank and timestamp calculations
would often be wrong (if it ever happened inside front-porch).

Could you give me some overview of which interrupts / hw events happens
when on DCN vs DCE? I intend to spend quite a bit of quality time in
December playing with the freesync code in DC and see if i can hack up some
proof-of-concept for precisely timed pageflips - the approach Harry
suggested in his XDC2019 talk which i finally found time to watch. I think
with the highly precise vblank and pageflip timestamps we should be able to
implement this precisely without the need for (jittery) software timers,
just some extensions to DRR hw programming and some trickery similar to
what below-the-range BTR support does. That would be so cool, especially
for neuro-science/vision-science/medical research applications.

My rough undestanding so far for DCN seems to be:

1. Pageflips can execute in front-porch, ie. the register double-buffering
can switch there. Can they also still execute after front-porch? How far
into vsync/back-porch? I assume at some point close to the end of
back-porch they can't anymore, because after a flip the line buffer needs
time to prefetch the new pixeldata from the new scanout buffer [a]?

2. The VSTARTUP interrupt/event in VRR mode happens somewhere programmable
after end of front-porch (suggested by the bandwidth calc code), but before
VUPDATE? Is VSTARTUP the last point at which double-buffering for a
pageflip can happen, ie. after that the line-buffer refill for the next
frame starts, ie. [a]?

3. The VUPDATE interrupt/event marks the end of vblank? And that's where
double-buffering / switch of new values for the DRR registers happens? So
DRR values programmed before VUPDATE will take effect after VUPDATE and
thereby affect the vblank after the current one ie. after the following
video frame?

Is this correct? And how does it differ from Vega/DCE-12 and older <=
Polaris / <= DCE-11 ? I remember from earlier this year that BTR works much
better on DCN (tested) and DCE-12 (presumably, don't have hw to test) than
it does on DCE-11 and earlier. This was due to different behaviour of when
the DRR programing takes effect, allowing for much quicker switching on
DCN. I'd like to understand in detail how the DRR
switching/latching/double-buffering differs, if one of you can enlighten me.

There's one thing about this patch though that i think is not right. The
sending of pageflip completion events from within dm_dcn_crtc_high_irq()
seems to be both not needed and possibly causing potentially wrong results
in pageflip events/timestamps / visual glitches due to races?

Two cases:

a) If a pageflip completes in front porch and the pageflip handler
dm_pflip_high_irq() executes while in front-porch, it will queue the proper
pageflip event for later delivery to user space by drm_crtc_handle_vblank()
which is called by dm_dcn_crtc_high_irq() already.

b) If dm_pflip_high_irq() executes after front-porch (pageflip completes in
back-porch if this is possible), it will deliver the pageflip event itself
after updating the vblank count and timestamps correctly via
drm_crtc_accurate_vblank_count().

There isn't a need for the extra code in your patch (if
(acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED) {...}) and indeed i can just
comment it out and everything works fine.

I think the code could be even harmful if a pageflip gets queued into the
hardware before invocation of dm_dcn_crtc_high_irq() (ie. a bit before
VSTARTUP + irq handling delay), but after missing the deadline for
double-buffering of the hardwares primary surface base address registers.
You could end up with setting acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED,
missing the hw double-buffering deadline, and then dm_dcn_crtc_high_irq()
would decide to send out a pageflip completion event to userspace for a
flip that hasn't actually taken place in the hw in this vblank. Userspace
would then misschedule its presentation due to the wrong pageflip event /
timestamp and you'd end up with the previous rendered image presented one
scanout cycle too long, and the current image silently dropped and never
displayed!

Indeed debug output i added shows that the dm_pflip_high_irq() handler
essentially turns into doing nothing with your patch applied, so pageflip
completion events sent to user space no longer correspond to true hw flips.

I have some hw measuring equipment to verify flip timing independent of the
driver and during a few short test runs i think i observed this glitch at
least once, suggesting the problem is real.

thanks,
-mario

On Tue, Nov 5, 2019 at 7:32 PM Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
wrote:

>
>
> On 2019-11-05 11:15 a.m., Kazlauskas, Nicholas wrote:
> > On 2019-11-05 10:34 a.m., sunpeng.li@amd.com wrote:
> >> From: Leo Li <sunpeng.li@amd.com>
> >>
> >> [Why]
> >>
> >> For DCN hardware, the crtc_high_irq handler is assigned to the vstartup
> >> interrupt. This is different from DCE, which has it assigned to vblank
> >> start.
> >>
> >> We'd like to send vblank and user events at vstartup because:
> >>
> >> * It happens close enough to vupdate - the point of no return for HW.
> >>
> >> * It is programmed as lines relative to vblank end - i.e. it is not in
> >>    the variable portion when VRR is enabled. We should signal user
> >>    events here.
> >>
> >> * The pflip interrupt responsible for sending user events today only
> >>    fires if the DCH HUBP component is not clock gated. In situations
> >>    where planes are disabled - but the CRTC is enabled - user events
> won't
> >>    be sent out, leading to flip done timeouts.
> >>
> >> Consequently, this makes vupdate on DCN hardware redundant. It will be
> >> removed in the next change.
> >>
> >> [How]
> >>
> >> Add a DCN-specific crtc_high_irq handler, and hook it to the VStartup
> >> signal. Inside the DCN handler, we send off user events if the pflip
> >> handler hasn't already done so.
> >>
> >> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> >> ---
> >>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 65 ++++++++++++++++++-
> >>   1 file changed, 64 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 00017b91c91a..256a23a0ec28 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -485,6 +485,69 @@ static void dm_crtc_high_irq(void
> *interrupt_params)
> >>      }
> >>   }
> >>
> >> +
> >> +/**
> >> + * dm_dcn_crtc_high_irq() - Handles VStartup interrupt for DCN
> generation ASICs
> >> + * @interrupt params - interrupt parameters
> >> + *
> >> + * Notify DRM's vblank event handler at VSTARTUP
> >> + *
> >> + * Unlike DCE hardware, we trigger the handler at VSTARTUP. at which:
> >> + * * We are close enough to VUPDATE - the point of no return for hw
> >> + * * We are in the fixed portion of variable front porch when vrr is
> enabled
> >> + * * We are before VUPDATE, where double-buffered vrr registers are
> swapped
> >> + *
> >> + * It is therefore the correct place to signal vblank, send user flip
> events,
> >> + * and update VRR.
> >> + */
> >> +static void dm_dcn_crtc_high_irq(void *interrupt_params)
> >> +{
> >> +    struct common_irq_params *irq_params = interrupt_params;
> >> +    struct amdgpu_device *adev = irq_params->adev;
> >> +    struct amdgpu_crtc *acrtc;
> >> +    struct dm_crtc_state *acrtc_state;
> >> +    unsigned long flags;
> >> +
> >> +    acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src -
> IRQ_TYPE_VBLANK);
> >> +
> >> +    if (!acrtc)
> >> +            return;
> >> +
> >> +    acrtc_state = to_dm_crtc_state(acrtc->base.state);
> >> +
> >> +    DRM_DEBUG_DRIVER("crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
> >> +                            amdgpu_dm_vrr_active(acrtc_state));
> >> +
> >> +    amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
> >> +    drm_crtc_handle_vblank(&acrtc->base);
> >
> > Shouldn't this be the other way around? Don't we want the CRC sent back
> > to userspace to have the updated vblank counter?
> >
> > This is how it worked before at least.
> >
> > Other than that, this patch looks fine to me.
> >
> > Nicholas Kazlauskas
>
>
> Looks like we're doing a crtc_accurate_vblank_count() inside the crc
> handler,
> so I don't think order matters here.
>
> Leo
>
> >
> >> +
> >> +    spin_lock_irqsave(&adev->ddev->event_lock, flags)
> >> +
> >> +    if (acrtc_state->vrr_params.supported &&
> >> +        acrtc_state->freesync_config.state ==
> VRR_STATE_ACTIVE_VARIABLE) {
> >> +            mod_freesync_handle_v_update(
> >> +            adev->dm.freesync_module,
> >> +            acrtc_state->stream,
> >> +            &acrtc_state->vrr_params);
> >> +
> >> +            dc_stream_adjust_vmin_vmax(
> >> +                    adev->dm.dc,
> >> +                    acrtc_state->stream,
> >> +                    &acrtc_state->vrr_params.adjust);
> >> +    }
> >> +
> >> +    if (acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED) {
> >> +            if (acrtc->event) {
> >> +                    drm_crtc_send_vblank_event(&acrtc->base,
> acrtc->event);
> >> +                    acrtc->event = NULL;
> >> +                    drm_crtc_vblank_put(&acrtc->base);
> >> +            }
> >> +            acrtc->pflip_status = AMDGPU_FLIP_NONE;
> >> +    }
> >> +
> >> +    spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> >> +}
> >> +
> >>   static int dm_set_clockgating_state(void *handle,
> >>                enum amd_clockgating_state state)
> >>   {
> >> @@ -2175,7 +2238,7 @@ static int dcn10_register_irq_handlers(struct
> amdgpu_device *adev)
> >>              c_irq_params->irq_src = int_params.irq_source;
> >>
> >>              amdgpu_dm_irq_register_interrupt(adev, &int_params,
> >> -                            dm_crtc_high_irq, c_irq_params);
> >> +                            dm_dcn_crtc_high_irq, c_irq_params);
> >>      }
> >>
> >>      /* Use VUPDATE_NO_LOCK interrupt on DCN, which seems to correspond
> to
> >> --
> >> 2.23.0
> >>
> >
>

--0000000000007c088d0598811f86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Leo and others,<br></div><div><br></div><div>sorry=
 for the late reply. I just spent some time looking at your patches and tes=
ting them on a Raven DCN-1.</div><div><br></div><div>I looked at how the vs=
tartup line is computed in the dc_bandwidth_calcs etc., and added some DRM_=
DEBUG statements to the dm_dcn_crtc_high_irq and dm_pflip_high_irq handlers=
 to print the scanline at which the handlers get invoked.</div><div><br></d=
iv><div>From my reading and the results my understanding is that VSTARTUP a=
lways fires after end of front-porch in VRR mode, so the dm_dcn_crtc_high_i=
rq handler will only get invoked in the vsync/back-porch area? This is good=
 and very important, as otherwise all the vblank and timestamp calculations=
 would often be wrong (if it ever happened inside front-porch).</div><div><=
br></div><div>Could you give me some overview of which interrupts / hw even=
ts happens when on DCN vs DCE? I intend to spend quite a bit of quality tim=
e in December playing with the freesync code in DC and see if i can hack up=
 some proof-of-concept for precisely timed pageflips - the approach Harry s=
uggested in his XDC2019 talk which i finally found time to watch. I think w=
ith the highly precise vblank and pageflip timestamps we should be able to =
implement this precisely without the need for (jittery) software timers, ju=
st some extensions to DRR hw programming and some trickery similar to what =
below-the-range BTR support does. That would be so cool, especially for neu=
ro-science/vision-science/medical research applications.<br></div><div><br>=
</div><div>My rough undestanding so far for DCN seems to be:</div><div><br>=
</div><div>1. Pageflips can execute in front-porch, ie. the register double=
-buffering can switch there. Can they also still execute after front-porch?=
 How far into vsync/back-porch? I assume at some point close to the end of =
back-porch they can&#39;t anymore, because after a flip the line buffer nee=
ds time to prefetch the new pixeldata from the new scanout buffer [a]?</div=
><div><br></div><div>2. The VSTARTUP interrupt/event in VRR mode happens so=
mewhere programmable after end of front-porch (suggested by the bandwidth c=
alc code), but before VUPDATE? Is VSTARTUP the last point at which double-b=
uffering for a pageflip can happen, ie. after that the line-buffer refill f=
or the next frame starts, ie. [a]?</div><div><br></div><div>3. The VUPDATE =
interrupt/event marks the end of vblank? And that&#39;s where double-buffer=
ing / switch of new values for the DRR registers happens? So DRR values pro=
grammed before VUPDATE will take effect after VUPDATE and thereby affect th=
e vblank after the current one ie. after the following video frame?<br></di=
v><div><br></div><div>Is this correct? And how does it differ from Vega/DCE=
-12 and older &lt;=3D Polaris / &lt;=3D DCE-11 ? I remember from earlier th=
is year that BTR works much better on DCN (tested) and DCE-12 (presumably, =
don&#39;t have hw to test) than it does on DCE-11 and earlier. This was due=
 to different behaviour of when the DRR programing takes effect, allowing f=
or much quicker switching on DCN. I&#39;d like to understand in detail how =
the DRR switching/latching/double-buffering differs, if one of you can enli=
ghten me.</div><div><br></div><div>There&#39;s one thing about this patch t=
hough that i think is not right. The sending of pageflip completion events =
from within dm_dcn_crtc_high_irq() seems to be both not needed and possibly=
 causing potentially wrong results in pageflip events/timestamps / visual g=
litches due to races?<br></div><div><br></div><div>Two cases:</div><div><br=
></div><div>a) If a pageflip completes in front porch and the pageflip hand=
ler dm_pflip_high_irq() executes while in front-porch, it will queue the pr=
oper pageflip event for later delivery to user space by drm_crtc_handle_vbl=
ank() which is called by dm_dcn_crtc_high_irq() already.</div><div><br></di=
v><div>b) If dm_pflip_high_irq() executes after front-porch (pageflip compl=
etes in back-porch if this is possible), it will deliver the pageflip event=
 itself after updating the vblank count and timestamps correctly via drm_cr=
tc_accurate_vblank_count().</div><div><br></div><div>There isn&#39;t a need=
 for the extra code in your patch (if (acrtc-&gt;pflip_status =3D=3D AMDGPU=
_FLIP_SUBMITTED) {...}) and indeed i can just comment it out and everything=
 works fine.</div><div><br></div><div>I think the code could be even harmfu=
l if a pageflip gets queued into the hardware before invocation of dm_dcn_c=
rtc_high_irq() (ie. a bit before VSTARTUP + irq handling delay), but after =
missing the deadline for double-buffering of the hardwares primary surface =
base address registers. You could end up with setting acrtc-&gt;pflip_statu=
s =3D AMDGPU_FLIP_SUBMITTED, missing the hw double-buffering deadline, and =
then dm_dcn_crtc_high_irq() would decide to send out a pageflip completion =
event to userspace for a flip that hasn&#39;t actually taken place in the h=
w in this vblank. Userspace would then misschedule its presentation due to =
the wrong pageflip event / timestamp and you&#39;d end up with the previous=
 rendered image presented one scanout cycle too long, and the current image=
 silently dropped and never displayed!</div><div><br></div><div>Indeed debu=
g output i added shows that the dm_pflip_high_irq() handler essentially tur=
ns into doing nothing with your patch applied, so pageflip completion event=
s sent to user space no longer correspond to true hw flips.</div><div><br><=
/div><div>I have some hw measuring equipment to verify flip timing independ=
ent of the driver and during a few short test runs i think i observed this =
glitch at least once, suggesting the problem is real.<br></div><div><br></d=
iv><div>thanks,<br></div><div>-mario</div><div><br></div><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 5, 2019 at 7:32 =
PM Li, Sun peng (Leo) &lt;<a href=3D"mailto:Sunpeng.Li@amd.com" target=3D"_=
blank">Sunpeng.Li@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><br>
<br>
On 2019-11-05 11:15 a.m., Kazlauskas, Nicholas wrote:<br>
&gt; On 2019-11-05 10:34 a.m., <a href=3D"mailto:sunpeng.li@amd.com" target=
=3D"_blank">sunpeng.li@amd.com</a> wrote:<br>
&gt;&gt; From: Leo Li &lt;<a href=3D"mailto:sunpeng.li@amd.com" target=3D"_=
blank">sunpeng.li@amd.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; [Why]<br>
&gt;&gt;<br>
&gt;&gt; For DCN hardware, the crtc_high_irq handler is assigned to the vst=
artup<br>
&gt;&gt; interrupt. This is different from DCE, which has it assigned to vb=
lank<br>
&gt;&gt; start.<br>
&gt;&gt;<br>
&gt;&gt; We&#39;d like to send vblank and user events at vstartup because:<=
br>
&gt;&gt;<br>
&gt;&gt; * It happens close enough to vupdate - the point of no return for =
HW.<br>
&gt;&gt;<br>
&gt;&gt; * It is programmed as lines relative to vblank end - i.e. it is no=
t in<br>
&gt;&gt;=C2=A0 =C2=A0 the variable portion when VRR is enabled. We should s=
ignal user<br>
&gt;&gt;=C2=A0 =C2=A0 events here.<br>
&gt;&gt;<br>
&gt;&gt; * The pflip interrupt responsible for sending user events today on=
ly<br>
&gt;&gt;=C2=A0 =C2=A0 fires if the DCH HUBP component is not clock gated. I=
n situations<br>
&gt;&gt;=C2=A0 =C2=A0 where planes are disabled - but the CRTC is enabled -=
 user events won&#39;t<br>
&gt;&gt;=C2=A0 =C2=A0 be sent out, leading to flip done timeouts.<br>
&gt;&gt;<br>
&gt;&gt; Consequently, this makes vupdate on DCN hardware redundant. It wil=
l be<br>
&gt;&gt; removed in the next change.<br>
&gt;&gt;<br>
&gt;&gt; [How]<br>
&gt;&gt;<br>
&gt;&gt; Add a DCN-specific crtc_high_irq handler, and hook it to the VStar=
tup<br>
&gt;&gt; signal. Inside the DCN handler, we send off user events if the pfl=
ip<br>
&gt;&gt; handler hasn&#39;t already done so.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Leo Li &lt;<a href=3D"mailto:sunpeng.li@amd.com" ta=
rget=3D"_blank">sunpeng.li@amd.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 65 +++=
+++++++++++++++-<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 64 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; index 00017b91c91a..256a23a0ec28 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; @@ -485,6 +485,69 @@ static void dm_crtc_high_irq(void *interrupt_=
params)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * dm_dcn_crtc_high_irq() - Handles VStartup interrupt for DCN ge=
neration ASICs<br>
&gt;&gt; + * @interrupt params - interrupt parameters<br>
&gt;&gt; + *<br>
&gt;&gt; + * Notify DRM&#39;s vblank event handler at VSTARTUP<br>
&gt;&gt; + *<br>
&gt;&gt; + * Unlike DCE hardware, we trigger the handler at VSTARTUP. at wh=
ich:<br>
&gt;&gt; + * * We are close enough to VUPDATE - the point of no return for =
hw<br>
&gt;&gt; + * * We are in the fixed portion of variable front porch when vrr=
 is enabled<br>
&gt;&gt; + * * We are before VUPDATE, where double-buffered vrr registers a=
re swapped<br>
&gt;&gt; + *<br>
&gt;&gt; + * It is therefore the correct place to signal vblank, send user =
flip events,<br>
&gt;&gt; + * and update VRR.<br>
&gt;&gt; + */<br>
&gt;&gt; +static void dm_dcn_crtc_high_irq(void *interrupt_params)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 struct common_irq_params *irq_params =3D interrupt_=
params;<br>
&gt;&gt; +=C2=A0 =C2=A0 struct amdgpu_device *adev =3D irq_params-&gt;adev;=
<br>
&gt;&gt; +=C2=A0 =C2=A0 struct amdgpu_crtc *acrtc;<br>
&gt;&gt; +=C2=A0 =C2=A0 struct dm_crtc_state *acrtc_state;<br>
&gt;&gt; +=C2=A0 =C2=A0 unsigned long flags;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 acrtc =3D get_crtc_by_otg_inst(adev, irq_params-&gt=
;irq_src - IRQ_TYPE_VBLANK);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!acrtc)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 acrtc_state =3D to_dm_crtc_state(acrtc-&gt;base.sta=
te);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 DRM_DEBUG_DRIVER(&quot;crtc:%d, vupdate-vrr:%d\n&qu=
ot;, acrtc-&gt;crtc_id,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_dm_vrr_active(acrtc_state));<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 amdgpu_dm_crtc_handle_crc_irq(&amp;acrtc-&gt;base);=
<br>
&gt;&gt; +=C2=A0 =C2=A0 drm_crtc_handle_vblank(&amp;acrtc-&gt;base);<br>
&gt; <br>
&gt; Shouldn&#39;t this be the other way around? Don&#39;t we want the CRC =
sent back <br>
&gt; to userspace to have the updated vblank counter?<br>
&gt; <br>
&gt; This is how it worked before at least.<br>
&gt; <br>
&gt; Other than that, this patch looks fine to me.<br>
&gt; <br>
&gt; Nicholas Kazlauskas<br>
<br>
<br>
Looks like we&#39;re doing a crtc_accurate_vblank_count() inside the crc ha=
ndler,<br>
so I don&#39;t think order matters here.<br>
<br>
Leo<br>
<br>
&gt; <br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 spin_lock_irqsave(&amp;adev-&gt;ddev-&gt;event_lock=
, flags)<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (acrtc_state-&gt;vrr_params.supported &amp;&amp;=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 acrtc_state-&gt;freesync_config.state=
 =3D=3D VRR_STATE_ACTIVE_VARIABLE) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod_freesync_handle_v_u=
pdate(<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;dm.freesync_mo=
dule,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acrtc_state-&gt;stream,=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;acrtc_state-&gt;vr=
r_params);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc_stream_adjust_vmin_v=
max(<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 adev-&gt;dm.dc,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 acrtc_state-&gt;stream,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &amp;acrtc_state-&gt;vrr_params.adjust);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (acrtc-&gt;pflip_status =3D=3D AMDGPU_FLIP_SUBMI=
TTED) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (acrtc-&gt;event) {<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 drm_crtc_send_vblank_event(&amp;acrtc-&gt;base, acrtc-&gt;event);<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 acrtc-&gt;event =3D NULL;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 drm_crtc_vblank_put(&amp;acrtc-&gt;base);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acrtc-&gt;pflip_status =
=3D AMDGPU_FLIP_NONE;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 spin_unlock_irqrestore(&amp;adev-&gt;ddev-&gt;event=
_lock, flags);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0static int dm_set_clockgating_state(void *handle,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum amd_cl=
ockgating_state state)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt; @@ -2175,7 +2238,7 @@ static int dcn10_register_irq_handlers(struc=
t amdgpu_device *adev)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c_irq_params-&gt;i=
rq_src =3D int_params.irq_source;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_dm_irq_regi=
ster_interrupt(adev, &amp;int_params,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dm_crtc_high_irq, c_irq_params);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dm_dcn_crtc_high_irq, c_irq_params);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 /* Use VUPDATE_NO_LOCK interrupt on DCN, which=
 seems to correspond to<br>
&gt;&gt; --<br>
&gt;&gt; 2.23.0<br>
&gt;&gt;<br>
&gt; <br>
</blockquote></div></div>

--0000000000007c088d0598811f86--

--===============0671872427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0671872427==--

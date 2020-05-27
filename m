Return-Path: <SRS0=WaPU=7J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7D4C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 20:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044332088E
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 20:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/vrh+Sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044332088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A8D6E101;
	Wed, 27 May 2020 20:51:21 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553CA6E0FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 20:51:20 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f5so953600wmh.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VE/Alzl9LCW9bpH6O4H5gaMfxKbz1e6CA43xGRSHgb0=;
 b=I/vrh+SxuCyyj3aRyS26TjwPvgOKglIh3LxRQB2b3F0bltTWwv7A1ThtqmnpotysWM
 jwAaz8E1rj3d90W+bozEQoTtobzokxfjf/Vkiiq+wQ6kYpK3hJRbt8HAjL7AmJ6Yxgay
 q/rGP+qDOUlochQFPUdQNVOkLblDkvgmfZH627YmE7GI8RxfcAqLFVEGfzDEQIKoQ0Fp
 1V8AOCbiheCOgwLobQFN1O6EwKg5AkE8kkbvuogGopd1+X3lJRjQH8WacbPxCeJroIUk
 vUXODe8KKq3vEwl+xEnNNloQzYyZ7dcH7SKf3twuZLNBQYhWwlMIR30yhPJ4iqJ2pjCU
 qxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VE/Alzl9LCW9bpH6O4H5gaMfxKbz1e6CA43xGRSHgb0=;
 b=GNbijEJmkt0rM6JmthH0xa79Fxwy08cZRE3lunwxTNVYkX3nLLS2lZkBmAFDuSiwK+
 VLQ/dCNHy84OkRSzLXyeUI27xOalkHivtjo7wUJXd7srKJq+ak+E7MhoUXyc4vCXWJmN
 8dp72I5fdLWA/ffviSa0+n4V36YWhyvhbxPcpaxqTh5srXmzyRj87DOfnWdlZVylinZX
 2LBAbLDjrJoNir2dsK3qovCm4qOy4oWCvFlhEvD0unD24tK2pQ61uF9XSniQRf4+1o3d
 gxe9z9f2sFsuCNLoTtTeMsRjCk4XACiC6+s73fP5N9uwt7wCy90lBC79dDKhf5seaGTJ
 T4zQ==
X-Gm-Message-State: AOAM5312upsdOqgBd2nVyOWszA/cxrW0xzIsflh7Gv6lRBgACD3BuhTB
 VISymednhMnuxgGoMDfydYnFoMgZ7nAphLVdemw=
X-Google-Smtp-Source: ABdhPJxMuyXwAEbY2wtaL4ei97a103A/06jHN/yKr7SCEXM6DoD5KByPhzCWFmRhp/BPU6VS3utFfTMceBJSmSaa8A0=
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr8797wml.70.1590612678897; 
 Wed, 27 May 2020 13:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200110201110.117166-1-alexander.deucher@amd.com>
 <CADnq5_PqWGUjn06jvxXfr=qQa45WJCK1aKgJ-b+VJRkVj9z4Yg@mail.gmail.com>
 <07041392-d18f-821e-4271-c94008818399@amd.com>
 <CADnq5_PZTSqWfctAjXwveMwj+5zGwvsPptx+oWUvtjJ3aWRe=Q@mail.gmail.com>
 <CADnq5_NZ0e28xzyEGFVbUZo4g46TQ8FVK1U5LHT8XybWmSMWag@mail.gmail.com>
In-Reply-To: <CADnq5_NZ0e28xzyEGFVbUZo4g46TQ8FVK1U5LHT8XybWmSMWag@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 May 2020 16:51:07 -0400
Message-ID: <CADnq5_Oe=YGjaGuHKPcB6m2i_D3wVWjrgyGaMfX0QnsCyDA-MA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: fix logic inversion in
 program_timing_sync()
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Laktyushkin,
 Dmytro" <Dmytro.Laktyushkin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Can we apply this for now until we can get further analysis on the
actual root cause?

Alex

On Mon, Apr 6, 2020 at 10:44 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Ping again?
>
> Alex
>
> On Thu, Feb 20, 2020 at 8:27 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, Feb 4, 2020 at 9:06 AM Kazlauskas, Nicholas
> > <nicholas.kazlauskas@amd.com> wrote:
> > >
> > > Comments inline.
> > >
> > > On 2020-02-03 4:07 p.m., Alex Deucher wrote:
> > > > Ping?
> > > >
> > > > On Fri, Jan 10, 2020 at 3:11 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > > >>
> > > >> It looks like we should be reducing the group size when we don't
> > > >> have a plane rather than when we do.
> > > >>
> > > >> Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
> > > >> Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
> > > >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > >> ---
> > > >>   drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
> > > >>   1 file changed, 2 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > > >> index 3d89904003f0..01b27726d9c5 100644
> > > >> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > > >> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > > >> @@ -1003,9 +1003,9 @@ static void program_timing_sync(
> > > >>                                  status->timing_sync_info.master = false;
> > > >>
> > > >>                  }
> > > >> -               /* remove any other pipes with plane as they have already been synced */
> > > >> +               /* remove any other pipes without plane as they have already been synced */
> > >
> > > This took a while to wrap my head around but I think I understand what
> > > this was originally trying to do.
> > >
> > > The original logic seems to have been checking for blanked streams and
> > > trying to remove anything that was blanked from the group to try and
> > > avoid having to enable timing synchronization.
> > >
> > > However, the logic for blanked is *not* the same as having a
> > > plane_state. Technically you can drive an OTG without anything connected
> > > in the front end and it'll just draw out the back color - which is
> > > distinct from having the OTG be blanked.
> > >
> > > The problem is really this iteration below:
> > >
> > > >>                  for (j = j + 1; j < group_size; j++) {
> > >
> > > There could still be pipes in here (depending on the ordering) that have
> > > planes and could be synchronized with the master OTG. I think starting
> > > at j + 1 is a mistake for this logic as well.
> > >
> > > I wonder if we can just drop this loop altogether. If we add planes or
> > > unblank the OTG later then we'll still want the synchronization.
> > >
> > > Dymtro, Wenjing - feel free to correct my understanding if I'm mistaken
> > > about this.
> >
> > Ping?  Any thoughts on this?  It would be nice to get this fixed.
> >
> > Alex
> >
> >
> > >
> > > Regards,
> > > Nicholas Kazlauskas
> > >
> > > >> -                       if (pipe_set[j]->plane_state) {
> > > >> +                       if (!pipe_set[j]->plane_state) {
> > > >>                                  group_size--;
> > > >>                                  pipe_set[j] = pipe_set[group_size];
> > > >>                                  j--;
> > > >> --
> > > >> 2.24.1
> > > >>
> > > > _______________________________________________
> > > > amd-gfx mailing list
> > > > amd-gfx@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > > >
> > >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

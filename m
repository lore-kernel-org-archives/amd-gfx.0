Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1FBC3DA7A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 14:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE10A10E744;
	Thu,  5 Jan 2023 14:45:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F216A10E744
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 14:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672929927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IygfhRQXV+vMkAtrcWNsDzrc29ZOAS6VlK+vnheQF7Q=;
 b=D5wbEYkB+eHK6JgC2ARejsNQ+osQSdffhCsBPiaJWiBO81MVZDU4iZ+zWJyQAfRFTmiQmY
 S2Cwg0m6cVdlehu3ytQfnVPKmxhnE25vdloW7jY/kP7ffdGcOxZi1VFsybwKKkNtALzQDv
 G+cSG0Jn1CCDJ7EaTCMBr/lyQIVBOxY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-454-OtXjfo1NNzSEO7FWdp3M3A-1; Thu, 05 Jan 2023 09:45:25 -0500
X-MC-Unique: OtXjfo1NNzSEO7FWdp3M3A-1
Received: by mail-lj1-f200.google.com with SMTP id
 by6-20020a05651c1a0600b0027fc191dd12so6830888ljb.20
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jan 2023 06:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IygfhRQXV+vMkAtrcWNsDzrc29ZOAS6VlK+vnheQF7Q=;
 b=m87bLJR3FGc5XmFjiSmq8X2jWk1g+Y2uRthkfHHR5NqlbDm0M8J0SdTq1qrtJqdp6i
 6AX1qOgK+TjkTWn4meYUMCjVoMZhMxGtuZdpAm1TO7zaQMZ57Dc54QEjUivH2Oomam3d
 OsTfCDlj38OwU33JLy8Rin4UN+JP6QRJP4yZVQlqofkLRNFlfvW/iZc5uyXEmEInUOzl
 AxsUeM1CyKu0uFViJ83t7NKzXwRsiJ39VFhzrtj2FFdxkjVda1n6ZCD3l0jK9eihlVOf
 HjifujaxRsy+atdWDhMcSTAMn9o82vy7332byZN+X7corwIzYP02HyN8nU4aTs6/UJBw
 PRcw==
X-Gm-Message-State: AFqh2kpqZDkFQwB9ePuhc80k4+2wXZJ3mkYcyE3mejKkPKmXaL28APwk
 fpQDIkaSPeXOK/3egPZ8haSwxHDincG9uku1vxXZSMXLmXxd8CdTQh7bRnQt7CXE8He23kqsX6s
 DWmEG5cVuc76akb+OXBk00IC49R/JO1K+sIVaZjbJiw==
X-Received: by 2002:a05:651c:22b:b0:27f:b397:db7d with SMTP id
 z11-20020a05651c022b00b0027fb397db7dmr2709089ljn.323.1672929924365; 
 Thu, 05 Jan 2023 06:45:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvLSm4cJ8Vb8dZ62NZRvXIQvGMXHBJiY0DZG4MVqkypnRpkR5DAKnuwfANsnYjxYNwT9y49VCJ+oi2KP5B6xGg=
X-Received: by 2002:a05:651c:22b:b0:27f:b397:db7d with SMTP id
 z11-20020a05651c022b00b0027fb397db7dmr2709080ljn.323.1672929924066; Thu, 05
 Jan 2023 06:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20221212182137.374625-1-harry.wentland@amd.com>
 <20221212182137.374625-17-harry.wentland@amd.com>
 <114c2e02-41c8-8576-f88d-1c50f41deb9e@mailbox.org>
 <20221214110128.1cd58dea@eldfell>
 <b53b1d6e-e81c-98d0-7a7f-a6d5fede90fc@amd.com>
In-Reply-To: <b53b1d6e-e81c-98d0-7a7f-a6d5fede90fc@amd.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Thu, 5 Jan 2023 15:45:12 +0100
Message-ID: <CA+hFU4z=-RRmeh6-D9Ydk1_aPq8jjQq34gYbdd+oLVkiS6HmZQ@mail.gmail.com>
Subject: Re: [PATCH 16/16] drm/amd/display: Don't restrict bpc to 8 bpc
To: Harry Wentland <harry.wentland@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, Uma Shankar <uma.shankar@intel.com>,
 Vitaly.Prosyak@amd.com, Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 23, 2022 at 8:10 PM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
>
>
> On 12/14/22 04:01, Pekka Paalanen wrote:
> > On Tue, 13 Dec 2022 18:20:59 +0100
> > Michel D=C3=A4nzer <michel.daenzer@mailbox.org> wrote:
> >
> >> On 12/12/22 19:21, Harry Wentland wrote:
> >>> This will let us pass kms_hdr.bpc_switch.
> >>>
> >>> I don't see any good reasons why we still need to
> >>> limit bpc to 8 bpc and doing so is problematic when
> >>> we enable HDR.
> >>>
> >>> If I remember correctly there might have been some
> >>> displays out there where the advertised link bandwidth
> >>> was not large enough to drive the default timing at
> >>> max bpc. This would leave to an atomic commit/check
> >>> failure which should really be handled in compositors
> >>> with some sort of fallback mechanism.
> >>>
> >>> If this somehow turns out to still be an issue I
> >>> suggest we add a module parameter to allow users to
> >>> limit the max_bpc to a desired value.
> >>
> >> While leaving the fallback for user space to handle makes some sense
> >> in theory, in practice most KMS display servers likely won't handle
> >> it.
> >>
> >> Another issue is that if mode validation is based on the maximum bpc
> >> value, it may reject modes which would work with lower bpc.
> >>
> >>
> >> What Ville (CC'd) suggested before instead (and what i915 seems to be
> >> doing already) is that the driver should do mode validation based on
> >> the *minimum* bpc, and automatically make the effective bpc lower
> >> than the maximum as needed to make the rest of the atomic state work.
> >
> > A driver is always allowed to choose a bpc lower than max_bpc, so it
> > very well should do so when necessary due to *known* hardware etc.
> > limitations.
> >
>
> I spent a bunch of time to figure out how this actually pans out in
> amdgpu and it looks like we're doing the right thing, i.e. if bandwidth
> limitations require it we'll downgrade bpc appropriately. These changes
> happened over the last couple years or so. So while raising the default
> max_bpc wasn't safe in amdgpu years ago it is completely fine now.
>
> As for the relevant code it's mostly handled in create_validate_stream_fo=
r_sink
> in amdgpu_dm.c where we iterate over a stream's mode validation with
> decreasing bpc if it fails (down to a bpc of 6).
>
> For HDMI we also have a separate adjust_colour_depth_from_display_info
> function that downgrades bpc in order to fit within the max_tmds_clock.
>
> So, in short, this change should not lead to displays not lighting up
> because we no longer force a given bpc.

Very good!

>
> > So things like mode validation cannot just look at a single max or min
> > bpc, but it needs to figure out if there is any usable bpc value that
> > makes the mode work.
> >
> > The max_bpc knob exists only for the cases where the sink undetectably
> > malfunctions unless the bpc is artificially limited more than seems
> > necessary. That malfunction requires a human to detect, and reconfigure
> > their system as we don't have a quirk database for this I think.
> >
> > The question of userspace wanting a specific bpc is a different matter
> > and an unsolved one. It also ties to userspace wanting to use the
> > current mode to avoid a mode switch between e.g. hand-off from firmware
> > boot splash to proper userspace. That's also unsolved AFAIK.
> >
>
> Agreed, the current "max bpc" just sets a max. We'd probably want a
> "min bpc" if userspace needs a minimum (e.g., for HDR).

To be clear: we need this. I've argued before that we need a min bpc
setting because we'd rather not enable HDR if we can't get the bit
depth required for it and there is no other mechanism to control this.
The other remaining kernel problem for HDR is that we still have no
control over YCC/RGB selection on the cable and thus can't choose the
correct color space infoframe.

>
> Harry
>
> > OTOH, we have the discussion that concluded as
> > https://gitlab.freedesktop.org/wayland/weston/-/issues/612#note_1359898
> > which really puts userspace in charge of max_bpc, so the driver-chosen
> > default value does not have much impact as long as it makes the
> > firmware-chosen video mode to continue, as requested in
> > https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/995
> > given that userspace cannot know what the actual bpc currently is nor
> > set the exact bpc to keep it the same.
> >
> >
> > Thanks,
> > pq
>


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC4ACAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 20:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1E510E7CB;
	Wed, 24 Sep 2025 20:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I3+0iGy6";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8CE10E7CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 20:07:26 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-24498e93b8fso349275ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758744446; x=1759349246; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKnflPuEez+KMavmEvDVz0cbFU6KCU4us8y073u8XcU=;
 b=I3+0iGy6JFzLuFWfMRBvE2g9xo697jhdpht/vwxutaufAc+Ai7MHN4ZgSSg0N4253W
 96y11zpk7mO3YrNQXIUipsQiWHRpIQFGKZ9E+fV35Whn83ZQjck3U1qr4qDfLO+WH4yK
 nwzLTnwpxCQXqEMYF6RdkTuFu7E+W+RbhwdX6pG5kLZH+vzsg4yhPlPIdnPOZstPDDv3
 ekF4t8opHNhhEpv1DvK/UB+TGN1+y2qP6dmethcdI3TD/0yug5xLQWKDNwv8xkrfCtZ6
 xcBIc7UU50N3m8spWhU7bJSHQTJXsMWl1Men/UjX9kOwmOumsyhNkrSmx7GdvCgAIBoA
 8JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758744446; x=1759349246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKnflPuEez+KMavmEvDVz0cbFU6KCU4us8y073u8XcU=;
 b=N940telSvhqNpSS295t1kaBbu0E6kmgACJkg3wS8tjnyooLUVWk36LT5ZpdjIm0FVX
 qrDREQRZ4eLWg/qb9jLsoaFHXwqze+PEe6VlVFeN1m41yB6fmbuzaQ0499O70xUfQF5I
 KbKCACHWuceeCkk/eCfy4nCK1ouh3uIkXESUCBFJy4ZonquY1RPcyowo8kyJFEgEl85w
 vgyTPOrlb17RAYAmkvnneBnUmypVgJXezkRSVQj1Be5RdZ5alswP+FxjQQzOsCJvhUvx
 GR8OVFiov9+kG5J/pydd1bTAWzzaRCINY1c1tTDoLu4CUFcHW4w/u1U3wApSnRdDpz44
 rimA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIxKdXLjHKwHJVKaXSXknX4TTNaJrC1Wtchb78G/aRZFcDEHLC5J8OQr70Kgkb/oryCVspIDEF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDRBpRr8rwM3o5BSJu7/rmKaAtGXiBBjv33gc3n85FS3HNg6Ic
 w4ICABLtCAuZnB9Stj7JhuR3DOMIMhipWJ1nP9sjuMHejKyWhC0LKU1Mmn+cNPFH2CPgOoiv5FD
 1F0ucJPMrJl7cgY4EVyPL7CtcDT81uq0=
X-Gm-Gg: ASbGncsJzkRv8+M/IWnGlDpU+f8iUci2NKvs3ZNCLcOeNZr9tGhIL1L6mi6BWD+Bx8c
 jgPmcqwiHicS3wQ1zUNhpdd1FsKGmEm+Dg4O5/LDMRwgN4yv0EENvJ+2vc+rbRX/balcvVS7eZ4
 pIawjJnVzJx0llwZX3wGzGKmraZIn/6tspsLEjOOSCu+EA2JDCs8M+fsNWEki6dTYlrLCQhgfRf
 veDOSY=
X-Google-Smtp-Source: AGHT+IF4XiybegPLTIs9qUadwYipQjFOe1bg+SxXgHLnmeip/H7U9DYgeH3CGDTBytjJQSPLudJl/tI8RqB2are0Qe8=
X-Received: by 2002:a17:902:e886:b0:274:944f:9d84 with SMTP id
 d9443c01a7336-27ed4a66e4bmr5621505ad.11.1758744446082; Wed, 24 Sep 2025
 13:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <29cbab3f-083a-41a8-81a1-b0234f36152f@gmail.com>
 <cc2094c5-3cc2-476e-8d6f-72fc61ebab90@amd.com>
 <bebbe919-0c5d-4399-a211-c7cf744febdc@gmail.com>
 <68bff33a-46ef-4518-8b1e-d9d1b3087f2a@amd.com>
 <ff564617-e261-466f-a686-81e96725b4d7@amd.com>
 <CADnq5_P6UUKSSO64r0zfyj+TsG+vzzP=Cci=EMhAru0GHNLgvw@mail.gmail.com>
 <c46d08ae-1cb6-412a-a135-c4974974eb12@amd.com>
In-Reply-To: <c46d08ae-1cb6-412a-a135-c4974974eb12@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Sep 2025 16:07:14 -0400
X-Gm-Features: AS18NWDwm-xRqbuivFS5tB_K_sdS0nsHsL9jO4BHO7KEWpxMS4pD-StI8on4kjA
Message-ID: <CADnq5_OOoAdeD5b6Q2FbbJwERq9_vkCADBcfudjBk1oU=LfRtw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Adjustments to common mode behavior
To: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>
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

On Wed, Sep 24, 2025 at 4:00=E2=80=AFPM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
>
>
> On 2025-09-24 15:11, Alex Deucher wrote:
> > On Wed, Sep 24, 2025 at 2:44=E2=80=AFPM Harry Wentland <harry.wentland@=
amd.com> wrote:
> >>
> >>
> >>
> >> On 2025-09-24 13:48, Mario Limonciello wrote:
> >>> On 9/24/25 12:33 PM, Timur Krist=C3=B3f wrote:
> >>>>
> >>>>
> >>>> On 9/24/25 19:21, Mario Limonciello wrote:
> >>>>>
> >>>>> On 9/24/25 12:13 PM, Timur Krist=C3=B3f wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 9/24/25 18:16, Mario Limonciello wrote:
> >>>>>>> As part of enablement for SI and CIK in DC Timur pointed out some
> >>>>>>> differences in behavior for common mode handling for DC vs non DC
> >>>>>>> code paths. This series lines up the behavior between the two
> >>>>>>> implementations.
> >>>>>>>
> >>>>>> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>>>>>
> >>>>>> Thank you Mario, this series makes good sense to me.
> >>>>>> My only worry is this: is it possible that removing the common mod=
es from connectors like DP, HDMI, etc. will regress somebody's setup?
> >>>>>
> >>>>> Possibly.  We're not going to know until we try.  I generally prefe=
r not to add common modes (hence why I tried to drop them before until we h=
it the Xorg bug report).
> >>>>>
> >>>>> If someone complains about this then I see two other directions we =
can go.
> >>>>
> >>>> Sounds good.
> >>>>
> >>>> Considering the non-DC code already didn't add those common modes, I=
 think it's reasonable to assume that we would have already heard about it =
if somebody had issues with it.
> >>>>
> >>>>>
> >>>>> 1) to make both DC and non-DC paths apply common modes to eDP,LVDS,=
 DP, HDMI.  Make them not apply common modes to VGA and DVI
> >>>>>
> >>>>> 2) Enabling common modes /across the board/ but anything not in the=
 EDID gets the GPU scalar turned on.
> >>
> >> I was surprised the previous approach failed, which seems
> >> to indicate GPU scaling isn't already happening. I wonder
> >> why. I think this would make a better default behavior
> >> instead of relying on monitor scalers to deal with
> >> non-advertised modes.
> >
> > My thinking with the original logic in radeon and the amdgpu non-DC
> > code was to only add the common modes to eDP/LVDS because the EDIDs
> > for those panels usually only had one mode in them and users almost
> > always wanted to do clone mode with an external monitor.  For external
> > monitors they often supported multiple modes already so there was less
> > incentive to add additional modes.  The default setting of the scaler
> > property was also different on eDP/LVDS (on) and external displays
> > (off).  If a user wanted to use the GPU scaler on an external display,
> > they could enable the scaler property and then manually add whatever
> > mode they wanted.  If they wanted to use the modes from the EDID, they
> > would just disable the scaler property and pick the mode from the
> > EDID.
> >
>
> Makes sense. I forgot usermode controls scaling via the "scaling mode"
> property.

Now that compositors generally control all of this, unless you are
running X, there's probably not a good way to mess with this.

Alex

>
> Harry
>
> > Alex
> >
> >>
> >> Harry
> >>
> >>>>
> >>>> I guess we'll see if any of those are necessary. For now, I'd propos=
e to just consider adding the common modes if there are 0 modes probed. But=
 I'm also OK with leaving that for later if you feel it isn't necessary.
> >>>>
> >>>
> >>> Yeah if something comes up and we need to weight it out we have this =
thread to refer back to for our ideas on what to do.
> >>>
> >>>> A slightly related question, would you be OK with changing the link =
detection code to return dc_connection_none when DDC cannot read an EDID he=
ader on digital signals, similar to how the non-DC code does it?
> >>>>
> >>>
> >>> I personally think lining up all these nuances that are different bet=
ween the two is a good idea.e e
> >>>
> >>> But for that specific question that's probably more of a Harry/Alex H=
ung question.
> >>>
> >>>>>>
> >>>>>> Two possible cases come to mind:
> >>>>>> 1. When we are unable to read the EDID for some reason
> >>>>>> 2. When the EDID is buggy and/or doesn't contain any modes
> >>>>>> Are these issues real or am I overthinking it?
> >>>>>>
> >>>>>> Thanks & best regards,
> >>>>>> Timur
> >>>>>
> >>>>> Failing to read EDID has happened in the past, but I think with the=
 deferred aux message handling that should be cleared up now.
> >>>>
> >>>> I was actually curious about that. I saw that issue while I was work=
ing on something else. How is it deferred now? Can you point me to the seri=
es that fixed it?
> >>>>
> >>>
> >>> There's more patches than this one, but I believe this was the =F0=9F=
=92=B0 patch.
> >>>
> >>> https://lore.kernel.org/amd-gfx/20250428135514.20775-27-ray.wu@amd.co=
m/
> >>>
> >>>
> >>
>

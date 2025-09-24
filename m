Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CFBCAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 19:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA53C10E255;
	Wed, 24 Sep 2025 19:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C2Aj6luj";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E304A10E255
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 19:11:30 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-26e81c17d60so280135ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758741090; x=1759345890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scm2p9UMxSBqe9gHWhoSE3Wt31d09DVGe1ix/U9MnkU=;
 b=C2Aj6luj+djn50pJveXefDGSf4qH6spBQrwmrE7gajnx2Msevs2TawyDPpMpCVw7EB
 9EGif+Rd/IacEfgmlVPsBgAWaQkhZPJcJBwq14ezciFsNXWdtbEUPqdTV7sRKLEQ794C
 ZAvz5X2YyX+eDcZbDRAwsAZ1APc1W+GpQ8MhYPh8wmDt93vS5y8SY4lR7wLawWfF5vUE
 JNVCfrIf3GSiNjrZPKrB6GlK0KkNBudWs46b1MjjyDIMmEZtVnhM7d58bb3qhjXBzShE
 +h3Ld+JaK3W/ml1jZtktv9XSEWjlGt2YFklrPMtqf8Kyf/xMrJFLYYDN+vlsAztarQAx
 fATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758741090; x=1759345890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scm2p9UMxSBqe9gHWhoSE3Wt31d09DVGe1ix/U9MnkU=;
 b=oY3r3uA8TX9VTx1zlBJYa7R2cL6J6rKziJrN3IWXAohBgDYFJz9WzG0ZUux1xOBEZg
 BoVDDKmAY12SuP5wzPHu4eaOtJJfgXJbTacMab6twTRxV0THUA0KnRImMi2IKW/ByC4S
 CvaQE+DAYiE9d9jFEgx6lww/YClEzRyAIQXvphOk2MtwfnClSlz7ulO+MAXmuJxcZq8Q
 kxGRujs3U7hjZv6kJ61t3UFp848FzYtiGgz0bVaBZndJ+arI8a6tC7nXbRbRQJ4eLd1v
 wqMnfhYZQdVs56rhTBoF//aOq2UGhCCeXmc7xpr5P2rAF3SNTa7C/sW6o70m5Y8Q7pgM
 0AVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc3RPLT8uSUu322qs5ke/Zh+OiTCglKZLoox4b+kOJSooyoMAM/rs9MRM6rhZ9exJbHzksqBc9@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+rMsIyK6uMyfcZaA7EZ5byokpiRWlrlvI6TTmO19RvQadw1YM
 Vwm6InT4B9Fzapym9Qk/O2iQ8RNJC/GucUfkmVFQW/iYcrX7CwQaqPNdoQJ43+pgOI/JQgBoCDs
 rze0qUeLPZVUmabIusb6fqtJhiF0T9fg=
X-Gm-Gg: ASbGncs7d99xvmpYeQ5BVMDzJXwNFGubgdM2g6CpnZV10F8Sh6yOoJvgLtBxhiEQMDO
 gumFfTgYPA+y/aDlo/yHmeKBN6tfaZo5DDRakSlR+4SDlGlwM/Bo7gSBRJX0LYhDn5GyyHreErb
 Z6xGQ8/rB80DrTvGFOMqJaSS/k8Q5LqX5MhEsDgNnr+NnVyQ4WMq4E2zEp/0d6/wgvzrmth8ezV
 ujSEEE=
X-Google-Smtp-Source: AGHT+IFkd5x3fsIiCcJ7btWJ6BbgZa6vmJAL7uwnbNUHvxP6JESqop9JVp2nnHFszu4xSNt2RnuNBbzAftXy3q1xjiU=
X-Received: by 2002:a17:903:2306:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-27ed4a7edc4mr5337685ad.6.1758741090291; Wed, 24 Sep 2025
 12:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <29cbab3f-083a-41a8-81a1-b0234f36152f@gmail.com>
 <cc2094c5-3cc2-476e-8d6f-72fc61ebab90@amd.com>
 <bebbe919-0c5d-4399-a211-c7cf744febdc@gmail.com>
 <68bff33a-46ef-4518-8b1e-d9d1b3087f2a@amd.com>
 <ff564617-e261-466f-a686-81e96725b4d7@amd.com>
In-Reply-To: <ff564617-e261-466f-a686-81e96725b4d7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Sep 2025 15:11:18 -0400
X-Gm-Features: AS18NWAOg3x1HvXm5jvp0Lb3BSQYWdOmuoU-iPGAzOX3SZEZgarSTRiNTLsKwQ8
Message-ID: <CADnq5_P6UUKSSO64r0zfyj+TsG+vzzP=Cci=EMhAru0GHNLgvw@mail.gmail.com>
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

On Wed, Sep 24, 2025 at 2:44=E2=80=AFPM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
>
>
> On 2025-09-24 13:48, Mario Limonciello wrote:
> > On 9/24/25 12:33 PM, Timur Krist=C3=B3f wrote:
> >>
> >>
> >> On 9/24/25 19:21, Mario Limonciello wrote:
> >>>
> >>> On 9/24/25 12:13 PM, Timur Krist=C3=B3f wrote:
> >>>>
> >>>>
> >>>> On 9/24/25 18:16, Mario Limonciello wrote:
> >>>>> As part of enablement for SI and CIK in DC Timur pointed out some
> >>>>> differences in behavior for common mode handling for DC vs non DC
> >>>>> code paths. This series lines up the behavior between the two
> >>>>> implementations.
> >>>>>
> >>>> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>>>
> >>>> Thank you Mario, this series makes good sense to me.
> >>>> My only worry is this: is it possible that removing the common modes=
 from connectors like DP, HDMI, etc. will regress somebody's setup?
> >>>
> >>> Possibly.  We're not going to know until we try.  I generally prefer =
not to add common modes (hence why I tried to drop them before until we hit=
 the Xorg bug report).
> >>>
> >>> If someone complains about this then I see two other directions we ca=
n go.
> >>
> >> Sounds good.
> >>
> >> Considering the non-DC code already didn't add those common modes, I t=
hink it's reasonable to assume that we would have already heard about it if=
 somebody had issues with it.
> >>
> >>>
> >>> 1) to make both DC and non-DC paths apply common modes to eDP,LVDS, D=
P, HDMI.  Make them not apply common modes to VGA and DVI
> >>>
> >>> 2) Enabling common modes /across the board/ but anything not in the E=
DID gets the GPU scalar turned on.
>
> I was surprised the previous approach failed, which seems
> to indicate GPU scaling isn't already happening. I wonder
> why. I think this would make a better default behavior
> instead of relying on monitor scalers to deal with
> non-advertised modes.

My thinking with the original logic in radeon and the amdgpu non-DC
code was to only add the common modes to eDP/LVDS because the EDIDs
for those panels usually only had one mode in them and users almost
always wanted to do clone mode with an external monitor.  For external
monitors they often supported multiple modes already so there was less
incentive to add additional modes.  The default setting of the scaler
property was also different on eDP/LVDS (on) and external displays
(off).  If a user wanted to use the GPU scaler on an external display,
they could enable the scaler property and then manually add whatever
mode they wanted.  If they wanted to use the modes from the EDID, they
would just disable the scaler property and pick the mode from the
EDID.

Alex

>
> Harry
>
> >>
> >> I guess we'll see if any of those are necessary. For now, I'd propose =
to just consider adding the common modes if there are 0 modes probed. But I=
'm also OK with leaving that for later if you feel it isn't necessary.
> >>
> >
> > Yeah if something comes up and we need to weight it out we have this th=
read to refer back to for our ideas on what to do.
> >
> >> A slightly related question, would you be OK with changing the link de=
tection code to return dc_connection_none when DDC cannot read an EDID head=
er on digital signals, similar to how the non-DC code does it?
> >>
> >
> > I personally think lining up all these nuances that are different betwe=
en the two is a good idea.e e
> >
> > But for that specific question that's probably more of a Harry/Alex Hun=
g question.
> >
> >>>>
> >>>> Two possible cases come to mind:
> >>>> 1. When we are unable to read the EDID for some reason
> >>>> 2. When the EDID is buggy and/or doesn't contain any modes
> >>>> Are these issues real or am I overthinking it?
> >>>>
> >>>> Thanks & best regards,
> >>>> Timur
> >>>
> >>> Failing to read EDID has happened in the past, but I think with the d=
eferred aux message handling that should be cleared up now.
> >>
> >> I was actually curious about that. I saw that issue while I was workin=
g on something else. How is it deferred now? Can you point me to the series=
 that fixed it?
> >>
> >
> > There's more patches than this one, but I believe this was the =F0=9F=
=92=B0 patch.
> >
> > https://lore.kernel.org/amd-gfx/20250428135514.20775-27-ray.wu@amd.com/
> >
> >
>

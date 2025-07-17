Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFABC83F3B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 07:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE1F10E919;
	Fri, 18 Jul 2025 07:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="A8L8YtcS";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185B510E0F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 19:28:43 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-606a269d440so240843a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gwmail.gwu.edu; s=google; t=1752780521; x=1753385321;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkA5fbn5ScNc0+GMAv2mNg170kF8j9I9SLy+PWD9/jk=;
 b=A8L8YtcSNnyjecFzvL9ah6nm7+7xROC8dJfZk1IWwSQvWtt0xvIiNaPpsDWq5FIT9p
 dfj2xnzu4fjDNVaHTzt2S5nDSChrZCWDvoXeuUZwO6KwHCAWJ01PpIRfHw6LdlXzrV0N
 C479W82LF918yohzIKX52u9h/pCH8VYgw9eaQ2LS68yjhStTkjyjpYOvuA/Wymw3C+Fe
 zQdL1cDXwEdFGIUVp8ExPMSW7KdOERa7RoxA3X/lH4e0xkFPpc2c8W2r1u8x8RrNLY0Z
 Vubbo5N9M26F21q7hDs/OpFhXBd4i4V0y+o0XwKkcQTw4C5IlocxZJc6UOC5tJ+a1Diq
 JWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752780521; x=1753385321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkA5fbn5ScNc0+GMAv2mNg170kF8j9I9SLy+PWD9/jk=;
 b=eEHlQ5dFDUKUQujUMrYNbT5JrgxOH4GTAQFIDaC5BFfMkXvzB/xSmPD6MU2By1X31U
 tdkQYRrvULm9XQ5cxK6yOs2kwVoDmKyaVV0rZXy+hGI47JCtjmfQjrBNN83SMcA/aVAT
 CPisGdVLHQEC4zVqUg6YAsHATAdPema1oKLSek0yIWSuOJSeKwLoaOOkxiOHv/1tJIl+
 GlBvpezv0bpeU5n+QKd52L+AIdQ3z1BgFkEHexNILWhtcWNzDt25SH27pMAQeeKXC6Xd
 jMu2ac8gz59RPzS9LbE/N3IYgjinJLhTz5Uhi4k4RXygFAPBpfYLDVVMenIBJt3BfaIA
 B+GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlwCxf/P4qBp2QkON4DGTdY9AbVpwKa597yVSJmVZPdJDd/+dK9bXi2Kw6Aj/4KWhVW+znzZpx@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+LEpRnIxUQDp4ilNzv9KtZb5H8Vd6RsNXPdWGLXa25F3Wb4ah
 eWZg+xLjH6ylMEt298MVBj+XxaoJBYn5gtjzneON3BkfiVUoOZN4KVtBm5V7LOYgGZ6b+69KjIM
 YulYVc2BPYcY2r8Mu9gFa/WCQYiOuqVCNwoHD+00g
X-Gm-Gg: ASbGncveYQ5iMwz/OoTYBDZrBjgLC6iLuyz16Jr4nQQAgwo9Dm6M3q6FM+1p80S+oYm
 iIFvsx2J/nRkE6pZ84h11d3vSngy1vor1ZWqkqb0NUzgBSutsePYI1DTn4+fn8X5ND2wSQ5IsJl
 WVEAYaWZDxtYRlg/AkibUSRSEvM9EbbFHUFCSdF6PVDbLwUWMqyLRStfgC4Azy0EIf5EajZ/jRe
 6L/qGg7
X-Google-Smtp-Source: AGHT+IGB2hyabWda1sIRfvafSlbP+cnzeZFzKRebvLkkRuhbvbMwHHgbGDNdOVOfqpwyhDbqe1w5G02AL5zkN7/b0bI=
X-Received: by 2002:a17:907:72c6:b0:ae0:caeb:276d with SMTP id
 a640c23a62f3a-ae9c99973c2mr300883566b.4.1752780521224; Thu, 17 Jul 2025
 12:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250717143738.84722-1-mwen@igalia.com>
 <70ac7b1e-9a28-45ff-b7b2-ab0f4fe9030a@amd.com>
 <bb4099a70c2a8c78ef07d5fb6a8f0d3b@igalia.com>
 <55467ebe-42c8-4387-9a61-aa60b3a84053@amd.com>
 <BA28247C-9779-4C4C-A8E3-ACF57BEF1521@gwmail.gwu.edu>
 <67169725b87e02cc8fdc19be5fc7df59@igalia.com>
In-Reply-To: <67169725b87e02cc8fdc19be5fc7df59@igalia.com>
From: Matthew Schwartz <mattschwartz@gwmail.gwu.edu>
Date: Thu, 17 Jul 2025 12:28:29 -0700
X-Gm-Features: Ac12FXwjl-IkbBGjSmuNCGG3zxuuVT2QJzFLYy3iy0VDyjsBLK-cykvVUSEu9jw
Message-ID: <CAD9O9Dq=dAsMs5a3VzgSvLwfuYYhkARDFBXyWUy+yktEZv5WbQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: limit clear_update_flags to
 dcn32 and above"
To: Melissa Wen <mwen@igalia.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, airlied@gmail.com,
 simona@ffwll.ch, 
 "Hung, Alex" <Alex.Hung@amd.com>, "Liu, Charlene" <Charlene.Liu@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 18 Jul 2025 07:37:06 +0000
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

On Thu, Jul 17, 2025 at 12:18=E2=80=AFPM Melissa Wen <mwen@igalia.com> wrot=
e:
>
> On 17-07-2025 17:57, Matthew Schwartz wrote:
> >> On Jul 17, 2025, at 9:58=E2=80=AFAM, Limonciello, Mario <Mario.Limonci=
ello@amd.com> wrote:
> >>
> >> On 7/17/25 11:55 AM, Melissa Wen wrote:
> >>> On 17-07-2025 13:39, Limonciello, Mario wrote:
> >>>> On 7/17/25 9:36 AM, Melissa Wen wrote:
> >>>>> This reverts commit e1bd5e0bb4ca0d633ad698abd3658f8265009b81.
> >>>>>
> >>>>> The commit causes a regression in Steam Deck (DCN 3.01), reintroduc=
ing a
> >>>>> functional issue reported in [1] that was fixed by calling the
> >>>>> clear_update_flags() from commit 7671f62c10f2a.
> >>>>>
> >>>>> On Steam Deck, we use multiple hw plane color caps and up to two ov=
erlay
> >>>>> planes with dynamic pipe split policy. I.e. with 1 primary + 1 over=
lay,
> >>>>> the driver split planes into two (with 4 pipes), but with 1 primary=
 + 2
> >>>>> overlays, we don't have enough pipe for splitting. Glitches appear =
in
> >>>>> this pipe-split transition of 1-2 overlay planes, if the driver doe=
sn't
> >>>>> clear update flags.
> >>>>>
> >>>>> Besides that, the issue the commit e1bd5e0bb4ca tries to address [2=
]
> >>>>> isn't functional.
> >>>>>
> >>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3441 [1]
> >>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4129 [2]
> >>>>> Signed-off-by: Melissa Wen <mwen@igalia.com>
> >>>>
> >>>> Can you please double check the use case that prompted
> >>>> e1bd5e0bb4ca0d633ad698abd3658f8265009b81 in the first place?  IE Wit=
h
> >>>> this revert you proposed do you see a traceback on unplug of externa=
l
> >>>> display?
> >>>
> >>> Hi Mario,
> >>>
> >>> I don't see either traceback or REG_WAIT timeout when unplugging an
> >>> external HDMI-connected display.
> >>> I tried with the Deck Dock and USB-C to HDMI adapter. Not sure if the=
re
> >>> is a very specific scenario that triggers this that I didn't cover.
> >>
> >> No; it's quite a general problem and easy to reproduce.  This makes me
> >> wonder if there should be an exception carved out for Steam Deck inste=
ad.
> >
> > I just tested DCN 3.1.2 (Z2 Go) and DCN 3.1.4 (Legion Go/ROG Ally) and
> > I was not able to reproduce the issue so a Steam Deck carveout might ma=
ke
> > sense here.
>
> What issue are you trying to reproduce?
> Glitches on Hades II + MangoHud, or traceback/REG_WAIT timeout?

Sorry, should've specified! I was testing for glitches with Hades II + Mang=
oHud.

>
> And with what kernel version?

amd-staging-drm-next built from b78bd800, tested on top of SteamOS Main

>
> Melissa
>
> >
> > Matt
> >
> >>
> >>>
> >>> The only message on dmesg from this action is:
> >>> amdgpu 0000:04:00.0: amdgpu: pp_od_clk_voltage is not accessible if
> >>> power_dpm_force_performance_level is not in manual mode!
> >>>
> >>> Moreover, if I move to the Desktop mode (KDE), there is no message.
> >>>
> >>> Melissa
> >>>
> >>>>
> >>>>> ---
> >>>>>   drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++--
> >>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu=
/drm/amd/display/dc/core/dc.c
> >>>>> index c31f7f8e409f..7c48f72e5917 100644
> >>>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> >>>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> >>>>> @@ -5443,7 +5443,8 @@ bool dc_update_planes_and_stream(struct dc *d=
c,
> >>>>>    else
> >>>>>    ret =3D update_planes_and_stream_v2(dc, srf_updates,
> >>>>>    surface_count, stream, stream_update);
> >>>>> - if (ret && dc->ctx->dce_version >=3D DCN_VERSION_3_2)
> >>>>> +
> >>>>> + if (ret)
> >>>>>    clear_update_flags(srf_updates, surface_count, stream);
> >>>>>
> >>>>>    return ret;
> >>>>> @@ -5474,7 +5475,7 @@ void dc_commit_updates_for_stream(struct dc *=
dc,
> >>>>>    ret =3D update_planes_and_stream_v1(dc, srf_updates, surface_cou=
nt, stream,
> >>>>>    stream_update, state);
> >>>>>
> >>>>> - if (ret && dc->ctx->dce_version >=3D DCN_VERSION_3_2)
> >>>>> + if (ret)
> >>>>>    clear_update_flags(srf_updates, surface_count, stream);
> >>>>>   }

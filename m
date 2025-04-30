Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFB0C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 13:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE7510E74F;
	Wed, 30 Apr 2025 13:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nd1skZC8";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A96A10E74F
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 13:44:03 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3032a9c7cfeso769045a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746020643; x=1746625443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJrK5GaCA2K3JkgDrjjpa+C8s1NdgpaVm27Gd4PuryQ=;
 b=nd1skZC8ZgsRsrBUGwkagrz21hrOLVroZo5KGQUxj+jXn+9PUP9pULYCuAq3BMgb1E
 XThKGo1BFNV6XpDwTBpWFthsnMDNxpFHHoyscVEsjSLRnLSLkUM1LEj8UsCSmYSOlvm/
 sNT2GLXA4VLWUIYvFC1JBd+wELYJl1wPRGxuccv/fwgfdz4Im2mzBJi/B4z9e4KxKWI3
 8kNI4fyqN4bk8avA1RFcEvaj8x7CV4KbzhB1X+kCs7DPtNMdtQy4IxxXciF8mCC2ixNJ
 ZrLEnwVsnDsFEDrae6n2KakpjMa0W0BqtLBSycYj2qbGekRrJmast778ZTpMrTB4YY55
 +04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746020643; x=1746625443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJrK5GaCA2K3JkgDrjjpa+C8s1NdgpaVm27Gd4PuryQ=;
 b=KaFiLunyGy7X+6Cre56h+tZ7s/FmT7/wZ11pxPDY1jym1Ai4niAbDNAWsab3SA3Y/D
 b8kfFt17Al3bFVcwu0vGwrwBwAsNMJ1CoVmpYZMUpRRZ400hMYHMJor9yrSU4MOb5BDM
 fj8rjNTztGWXiMajnnRnTZ/6m9oo+3rG3zu2kEz0f4GN/N63DBXyrJdu4LIFNgf6KTVH
 gJfhr3NXJF1I9P4gl653CIs1vILpp7KvU+wlsIvWEhiPVRRDbeN5Yrmr39UYtSlHOq2h
 X387WlAZVfLpbk9Wj3hZjs9q5iJDKAXwacVVhTHJdmo8lO7fkKHPf+ed/ZPxTt8G7WIQ
 KXaw==
X-Gm-Message-State: AOJu0YyWHep13L/Lyl15VbsWkuUUkUYu/gHxvsBh2tz966WCgaXqEH4Z
 8kGAGpBN8lUA/XRxQlYNmo1B2od7Tipigo39mETO7ObtuvdC2flZbN1o6lAlRIXqZ2ZQVohSKFu
 u8szDL0FTYle4nEeSwEQKyVbg1wM=
X-Gm-Gg: ASbGncuwYC1nM5W26x8/KLmzWo1SvS7rARohfj5SBH4EB0G4EXW/Ri2tRyo/VgYxHQF
 Npkw9xprKt2oPjPoUHmEgDE0z+JaDKMkft67vD3oEtCdjY2NfA7D2dAoq2gIcJ1oAFnkdD5y6mf
 I+d5cCZjKmZSX5a3pDDOr6IA==
X-Google-Smtp-Source: AGHT+IGTXhxB1LVkIEClpUyW6qbP9jSSStggCuAbuL7em4+ZAbVlMlCsQw4cLOEkEkVj9yjgKNWYTpMW8FLQRuK5DUs=
X-Received: by 2002:a17:90b:1642:b0:306:e6ec:dc82 with SMTP id
 98e67ed59e1d1-30a3bb7ebf2mr373149a91.6.1746020642932; Wed, 30 Apr 2025
 06:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <15eca28818c4fad674bb2f33df7b3277563ba56d.camel@nordisch.org>
 <20250429130749.GBaBDPJSol4WXi-G-r@fat_crate.local>
In-Reply-To: <20250429130749.GBaBDPJSol4WXi-G-r@fat_crate.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 09:43:51 -0400
X-Gm-Features: ATxdqUH-rfzBKjyZRD5BxydCiwKhwXuhWa9H-nLUhAWkudgAICqexUysxVcigcU
Message-ID: <CADnq5_NN9YF6FaXV1SMhow8=jgXcoto=uTJ2zNPbOAjJvi0uyQ@mail.gmail.com>
Subject: Re: Display Port handling errors out when monitor is slow to wake up
To: Borislav Petkov <bp@alien8.de>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Marcus_R=C3=BCckert?= <amd@nordisch.org>
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

On Wed, Apr 30, 2025 at 3:55=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> + amdgpu folks.
>
> On Tue, Apr 29, 2025 at 02:51:21PM +0200, Marcus R=C3=BCckert wrote:
> > Hardware:
> > - ASUS ROG Swift OLED PG27AQDP
> > - XFX Mercury Radeon RX 9070 XT OC Gaming Edition with RGB, 16GB GDDR6,=
 HDMI, 3x DP RX-97TRGBBB9
> >
> > Kernel:
> > - kernel-default-6.15~rc4-1.1.g62ec7c7.x86_64 from https://build.opensu=
se.org/project/show/Kernel:HEAD
> >
> > The monitor is really slow on waking up - or even switching mode e.g. w=
hen going from console to wayland with 480Hz.
> > When I turn on the monitor before I wake up wayland via keyboard/mouse,=
 no error comes. If I wake up wayland first and then start the monitor:

Ideally you would physically turn the monitor on before you wake the
desktop.  Even better, just let the compositor manage the monitor.  It
will turn the monitor off automatically after an idle period.  If you
try to use the desktop before the monitor is powered up, the driver is
not able to train the link with the monitor because the monitor is
powered off, hence the errors below.  That can also lead to delays as
the driver attempts to train the link, but since the monitor is off,
it leads to lots of timeouts and failures until the monitor is
actually powered on.  Is those suggestions don't help, please file a
report here:
https://gitlab.freedesktop.org/drm/amd/-/issues/

Thanks,

Alex

> >
> > ```
> > [Tue Apr 29 13:49:54 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1118: core_link_write_dpcd (DP_DOWNSPREAD_CTRL) fa=
iled
> > [Tue Apr 29 13:49:54 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1123: core_link_write_dpcd (DP_LANE_COUNT_SET) fai=
led
> > [Tue Apr 29 13:49:54 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1151: core_link_write_dpcd (DP_LINK_BW_SET) failed
> > [Tue Apr 29 13:49:55 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1118: core_link_write_dpcd (DP_DOWNSPREAD_CTRL) fa=
iled
> > [Tue Apr 29 13:49:55 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1123: core_link_write_dpcd (DP_LANE_COUNT_SET) fai=
led
> > [Tue Apr 29 13:49:55 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1151: core_link_write_dpcd (DP_LINK_BW_SET) failed
> > [Tue Apr 29 13:49:56 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1118: core_link_write_dpcd (DP_DOWNSPREAD_CTRL) fa=
iled
> > [Tue Apr 29 13:49:56 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1123: core_link_write_dpcd (DP_LANE_COUNT_SET) fai=
led
> > [Tue Apr 29 13:49:56 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1151: core_link_write_dpcd (DP_LINK_BW_SET) failed
> > [Tue Apr 29 13:49:57 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1118: core_link_write_dpcd (DP_DOWNSPREAD_CTRL) fa=
iled
> > [Tue Apr 29 13:49:57 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1123: core_link_write_dpcd (DP_LANE_COUNT_SET) fai=
led
> > [Tue Apr 29 13:49:57 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1151: core_link_write_dpcd (DP_LINK_BW_SET) failed
> > [Tue Apr 29 13:49:58 2025] [  T70365] amdgpu 0000:03:00.0: [drm] enabli=
ng link 1 failed: 15
> > ```
> >
> > Feel free to ping me if you need more information.
> >
> >    darix
> >
> > ```
> > --
> > Always remember:
> >   Never accept the world as it appears to be.
> >     Dare to see it for what it could be.
> >       The world can always use more heroes.
> >
> >
> >
> >
> > ```
> >
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

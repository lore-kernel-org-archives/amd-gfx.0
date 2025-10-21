Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C38CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 16:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E45B710E621;
	Tue, 21 Oct 2025 16:44:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmOTk3kX";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747D010E621
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 16:44:46 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-292dc9158e5so2570095ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761065086; x=1761669886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBh47DaxdjilUnEsDZdXiU4U+0GHT4G9Ubc91C6Qtaw=;
 b=HmOTk3kXJjI4JHRkGGtp8jR7kIJT97e6Gel+Iv2+dZBXHH1z+RFR49nXgOe5V4cBKx
 KnRZMpUwJ9EMpEwtOHVWxnzEU2mLukXb+pH6/8+vE8TTjsVZpOC0YMpout13AQfsG1Vi
 M9aho+MOc7QXMRaMsug501kECThiMkt5/fCey+2A6V//Zt1AlVjhAuzMVKmyH5OYhxeo
 MKL3+ntJMYdmwZteQE7UJNbOmKeBIp1poHYWTP0SgZVXx+6WESf/LxmevM2YQHiAyGke
 cs+JIbeG6SRXAu6WXv2Yag7P2mhkS7Ye8wmCUkqwjXV+QjIB830xOWXjWSyaBuJq2Wjb
 pLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761065086; x=1761669886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBh47DaxdjilUnEsDZdXiU4U+0GHT4G9Ubc91C6Qtaw=;
 b=t8cyYpwZp3pg06S7LGjzq3+ahROB4bI/ZJ7kzwhhy8yCqGP8+gO2a0t/jOvGprKp/a
 eIUzfL3mo8JPSKONA8aTofuuAbLypkqNA3YLieiIXU+cg47oAKmE2+wxnrUUz3dtpTVu
 8MD8caeVhKn30dKuwfYk1aMHwJjQlr18bMLkfOS8rhDUfKquhO3BOnsRF49iy8cGnYPI
 0yM7TZuuX8u66NO2SGFN+nu/lDjhgkydvL/Jwc7Ok4/6SsRYIWd6D6J50WfRRttDDtRr
 /mPNJSv0ZXUcybhXPJUH2X6zXIihd96U9y5xrzp6XyOCDiTJ50IwzGdsZf5kUGY2h/bi
 oBZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFaJ3ojyDkrvN3kohwYjkp7bFdOWUOlKtF+altm17hrZKmMli7+mACe53o9m2Z+bRlTcdQ341z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsBzGwV90TSzPIx3OxAS25xyyFnibLckiqMXijQce4Q6P5uqW6
 NV4/tpfvak1QgVKIvg6Lfl1BDTZlTQprNi6zwNJ0hhj3175wuaMCXTRiesRyXsrALyL3JS2cVrv
 GR4zGoqCFCji3UGop5r6GZ3pi1mwpDvk=
X-Gm-Gg: ASbGncsOgcaZelIkCN0bPZddxgF1m6IGBzlKT6jrFB+lpVqTqJcTsilvvmC7uONop2l
 80zAV0zB8kVRln44v+9Kvmj4pSJA5QQOxLOhzQKkLEBOY6jUSvDMZKQYwe2kuskYCA3hmkPoHxR
 jvhIAd2OGLSoTNM3SJAUqtvXjRUMVuBCBkwHosNk2Mtt5Fa23CrbY/meO033Cj/rcJjLWAmutut
 HUSAR0/ZIOHscFE20+gM6zigyLwtS6/HVEAzgQpiQxlIvVKiUO93GNMWLHmMyRXn5RoY24=
X-Google-Smtp-Source: AGHT+IFvnDVlxBdFsf79t22xl536og+wMXk2NPEc4fJy7301xguBleLqdrBCII/Vn3pqW4M2huT2vLSG6FmKmNObmeI=
X-Received: by 2002:a17:902:cecb:b0:258:a3a1:9aa5 with SMTP id
 d9443c01a7336-290c9ae1a2emr129460085ad.0.1761065085772; Tue, 21 Oct 2025
 09:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250926180203.16690-1-timur.kristof@gmail.com>
 <0fb9b183-ba74-4837-86a1-499b3acf04d5@amd.com>
 <f7bb25e7-0a64-4057-b068-5fb63d5d287e@amd.com>
 <DS0PR12MB6534854A0932A7E3E0D05D939CEEA@DS0PR12MB6534.namprd12.prod.outlook.com>
 <f2672baf-1f02-480d-a8c3-54f7f7863695@amd.com>
 <1835c00c-780a-4530-9652-5ee4a3bb8622@gmail.com>
In-Reply-To: <1835c00c-780a-4530-9652-5ee4a3bb8622@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Oct 2025 12:44:33 -0400
X-Gm-Features: AS18NWDSEMbGMDfQ0xbwBA7eEDUymY83ksIp4l0--1piPi1yTX7IrTuSqxZ8Ro8
Message-ID: <CADnq5_M2vx+tzHFk2Jyq7-yoV5kHFFFVdCE2O2KP7UmT4zwR3g@mail.gmail.com>
Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Hung, Alex" <Alex.Hung@amd.com>, "siqueira@igalia.com" <siqueira@igalia.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
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

On Tue, Oct 21, 2025 at 12:26=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> Hi,
>
> Did you guys manage to include the series in last week's promotion?
> Are there any issues?
>
> I'd really like it to be included in Linux 6.18, are we still on time
> for that?

The deadline for new features for 6.18 was over a month ago
unfortunately,  We are already at 6.18-rc2.

Alex

>
> Thanks & best regards,
> Timur
>
> On 10/9/25 20:27, Harry Wentland wrote:
> >
> >
> > On 2025-10-09 13:49, Wheeler, Daniel wrote:
> >> [Public]
> >>
> >> Sure, we can add it to next week's promotion, I'm almost through this =
week's candidate. Tom is scheduled to prepare next week's candidate, so I'l=
l tag him in.
> >>
> >
> > Great. Thanks.
> >
> > Harry
> >
> >> Thank you,
> >>
> >> Dan Wheeler
> >> Sr. Technologist | AMD
> >> SW Display
> >> ----------------------------------------------------------------------=
--------------------------------------------
> >> 1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
> >> amd.com
> >>
> >>
> >> -----Original Message-----
> >> From: Wentland, Harry <Harry.Wentland@amd.com>
> >> Sent: Thursday, October 9, 2025 1:27 PM
> >> To: Timur Krist=C3=B3f <timur.kristof@gmail.com>; amd-gfx@lists.freede=
sktop.org; Wheeler, Daniel <Daniel.Wheeler@amd.com>
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hung, Alex <Alex.H=
ung@amd.com>; siqueira@igalia.com; Koenig, Christian <Christian.Koenig@amd.=
com>
> >> Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
> >>
> >>
> >>
> >> On 2025-10-08 17:11, Harry Wentland wrote:
> >>> On 2025-09-26 14:01, Timur Krist=C3=B3f wrote:
> >>>> This series adds support for analog connectors to DC for DCE6-10.
> >>>> There are two reasons to add this support:
> >>>>
> >>>> 1. GPUs that already use DC by default and have analog connectors.
> >>>> Some Tonga and Hawaii graphics cards in fact have DVI-I connectors,
> >>>> and their analog part doesn't work with DC. This functionality
> >>>> regressed when switching from the amdgpu legacy display code to DC.
> >>>>
> >>>> 2. GPUs that don't use amdgpu by default yet.
> >>>> Currently, SI (GFX6) and CIK (GFX7) don't use amdgpu by default yet,
> >>>> and missing analog connector support in DC is cited as one of the
> >>>> main reasons why not.
> >>>>
> >>>> Before starting this work, I asked Harry and Alex about how best to
> >>>> do it and we agreed that we'd like to use the VBIOS to set up the
> >>>> DAC. So I used the amdgpu legacy display code as a reference.
> >>>> The first few commits add some minor changes to DC to prepare for
> >>>> supporting analog stream and link encoders, then analog link
> >>>> detection is added along with polling, and finally DAC load detectio=
n
> >>>> support, which is useful for old displays and adapters.
> >>>>
> >>>> With this analog support added to DC, we could already fully switch
> >>>> CIK discrete GPUs to use DC and switch them to the amdgpu driver by
> >>>> default. This series switches Bonaire to DC by default, we can do th=
e
> >>>> switch to amdgpu in a later series.
> >>>>
> >>>> For SI dGPUs, there are other pending patches to make DC work well,
> >>>> afterwards we could switch to DC by default, but missing
> >>>> VCE1 support is the blocker from using amdgpu by default.
> >>>>
> >>>> For GFX7 APUs, further work is needed before enabling DC by default,
> >>>> specifically with regards to the TRAVIS and NUTMEG external encoders
> >>>> which are not supported by DC at all.
> >>>>
> >>>> Changes in v2 of the series:
> >>>> Fixed regression on RDNA2 and newer APUs.
> >>>> Fixed flickering caused by polling analog connectors.
> >>>> Fixed crash on Kaveri.
> >>>> Fixed bug when HPD was high without a connected display.
> >>>> Reduced code churn by reusing same link encoder.
> >>>> Addressed other feedback from the review of v1.
> >>>
> >>> Thanks for the series.
> >>>
> >>> Patches 1-13 are
> >>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >>>
> >>> I'll hope to find time for the rest tomorrow or Friday.
> >>>
> >>
> >> The rest looks good to me as well.
> >>
> >> The whole series is
> >> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >>
> >> Dan, can we give this a spin in our weekly promotion tests before I me=
rge it?
> >>
> >> Harry
> >>
> >>> Harry
> >>>
> >>>>
> >>>> Timur Krist=C3=B3f (23):
> >>>>    drm/amd/display: Determine DVI-I connector type (v2)
> >>>>    drm/amd/display: Add analog bit to edid_caps (v2)
> >>>>    drm/amd/display: Introduce MAX_LINK_ENCODERS (v2)
> >>>>    drm/amd/display: Hook up DAC to bios_parser_encoder_control
> >>>>    drm/amd/display: Add SelectCRTC_Source to BIOS parser
> >>>>    drm/amd/display: Get maximum pixel clock from VBIOS
> >>>>    drm/amd/display: Don't use stereo sync and audio on RGB signals (=
v2)
> >>>>    drm/amd/display: Don't try to enable/disable HPD when unavailable
> >>>>    drm/amd/display: Determine early if a link has supported encoders=
 (v2)
> >>>>    drm/amd/display: Add concept of analog encoders (v2)
> >>>>    drm/amd/display: Implement DCE analog stream encoders
> >>>>    drm/amd/display: Implement DCE analog link encoders (v2)
> >>>>    drm/amd/display: Support DAC in dce110_hwseq
> >>>>    drm/amd/display: Add analog link detection (v2)
> >>>>    drm/amd/display: Refactor amdgpu_dm_connector_detect (v2)
> >>>>    drm/amd/display: Poll analog connectors (v2)
> >>>>    drm/amd/display: Add DCE BIOS_SCRATCH_0 register
> >>>>    drm/amd/display: Make get_support_mask_for_device_id reusable
> >>>>    drm/amd/display: Add DAC_LoadDetection to BIOS parser (v2)
> >>>>    drm/amd/display: Use DAC load detection on analog connectors (v2)
> >>>>    drm/amd/display: Add common modes to analog displays without EDID
> >>>>    drm/amd/display: Don't add freesync modes to analog displays (v2)
> >>>>    drm/amdgpu: Use DC by default for Bonaire
> >>>>
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 -
> >>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 173 ++++++++---
> >>>>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
> >>>>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
> >>>>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  20 ++
> >>>> .../gpu/drm/amd/display/dc/bios/bios_parser.c |  95 +++++-
> >>>>   .../drm/amd/display/dc/bios/command_table.c   | 286 ++++++++++++++=
++++
> >>>>   .../drm/amd/display/dc/bios/command_table.h   |   6 +
> >>>>   .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   4 +-
> >>>>   .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +
> >>>>   .../gpu/drm/amd/display/dc/dc_bios_types.h    |   9 +
> >>>>   drivers/gpu/drm/amd/display/dc/dc_types.h     |   8 +-
> >>>>   .../drm/amd/display/dc/dce/dce_link_encoder.c |  85 ++++++
> >>>> .../drm/amd/display/dc/dce/dce_link_encoder.h |  16 +-
> >>>>   .../amd/display/dc/dce/dce_stream_encoder.c   |  14 +
> >>>>   .../amd/display/dc/dce/dce_stream_encoder.h   |   5 +
> >>>>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  75 ++++-
> >>>>   .../gpu/drm/amd/display/dc/inc/core_types.h   |   8 +-
> >>>>   .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  24 ++
> >>>>   .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 +
> >>>>   drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
> >>>>   .../amd/display/dc/link/hwss/link_hwss_dio.c  |  19 +-
> >>>> .../drm/amd/display/dc/link/link_detection.c  | 147 ++++++++-
> >>>>   .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
> >>>>   .../drm/amd/display/dc/link/link_factory.c    |  60 +++-
> >>>>   .../dc/resource/dce100/dce100_resource.c      |  31 +-
> >>>>   .../dc/resource/dce110/dce110_resource.c      |   2 +
> >>>>   .../dc/resource/dce112/dce112_resource.c      |   2 +
> >>>>   .../dc/resource/dce120/dce120_resource.c      |   1 +
> >>>>   .../dc/resource/dce60/dce60_resource.c        |  29 +-
> >>>>   .../dc/resource/dce80/dce80_resource.c        |  26 +-
> >>>>   .../amd/display/include/bios_parser_types.h   |  11 +-
> >>>>   .../display/include/grph_object_ctrl_defs.h   |   1 +
> >>>>   .../drm/amd/display/include/grph_object_id.h  |   7 +
> >>>>   .../drm/amd/display/include/signal_types.h    |  12 +
> >>>>   35 files changed, 1117 insertions(+), 86 deletions(-)
> >>>>
> >>>
> >>
> >
>

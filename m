Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE62ECCFA00
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 08:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6510C10E132;
	Fri, 31 Oct 2025 08:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IV8PFNAc";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A229110E132
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 08:19:03 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b626a4cd9d6so222121466b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 01:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761898742; x=1762503542; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=r/WLQON4bfON5LGIqyJfLHE6K6Ijv5XGg1ISUZD092Q=;
 b=IV8PFNAcB7GaeSVymD82JYZoBL21/SfhKArhE9p3Bm1Vyu531I11ZhLLe14VRSsj2+
 PCaal8HfKwMSlnGQHLGc+I4+fPZgTfA7RJ9jDLaVar9tdV4w+4OyMhTyQKgTxKWjxzQ/
 AS1aWy+rs2DUmAFWtBKmqEGW5hm5mtES3PgmgPyOgWXeyvJo5YVAC4xOxBmhpM6NZDEq
 Hb76lt+DqWkakDOiytRHpRZ6HAzDa+V8QfyQr0HflhTvPwiJsoGwaMGcm1IV3G/e+Q7l
 arwyi2G7fzXRHoUcFuFBLXd4yMo/Kxx6yeJakZusZXwJdmcJ/sZwVaX6lQdMJaXxBoQW
 dZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761898742; x=1762503542;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r/WLQON4bfON5LGIqyJfLHE6K6Ijv5XGg1ISUZD092Q=;
 b=s2slD0K7HJScgjvzFymuZsge3018EkNOOuX0dEx9db7/tr60qEu73AMDIia0Xc4fXI
 +PtSRnMuBfMLRUCS/0jJRE3HxRB+vUsGc672MkNuZY8BMrXKXJv3S0tlae4ayWHbkYCF
 G9S3kXsfzUewjWLjIIKEYh1GScOmfmYXL1S42KCmqFKywXxEZvehkZNoSryECLPhnoCi
 /9r3TopxmTHMlyPWDeiQLvrfNxENG9TbxBr++SlDiDhvJ9EgHu5w1YYPiE1OAG/zAjrq
 fG7JWeqF2RCgJGquy2w4X11eMQuyc83Qku5sh6A4+EuI386xHkpcqXf42fcehDdUnq+s
 kT1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT6uTHAP4+VNDEvatFkTOXWTPdActQTFzw1ynH/io7xcVVK1TYFKRBbURZP1SS+FYwFnwhjUDY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzz4DB/mVkx46z8oDaVcjYO8MOnoryKNE2McfEvz1t/q0H+jP3O
 dTh/TOwypudP5Et0UFRinxpZ9MmEwzxd16c8N4NP89qMDfiyLXnIHuXH
X-Gm-Gg: ASbGncvOmycGT0KN/juJZUWnV7oCiE30zNvdNYYlBgvW5G/BncZqwKoOSszDdWraOVn
 Chuw8EDTjD/HKWEPpSc3MsP0tKUZTy2N9LdQjM5RL/vqPlLp9gRt8BdqNF8oYpdVjfRNPiiJatE
 XAo+VTfnwvTDfGVUPg+qKWtmJxp2Z4MYeoKuhGHFeoubxC8Mx7tqpwMtwKnV9XaXmHlJTHmnX59
 6C42qXX4/bV9avl7eRo1fNKFSuPdbggE5JrwmXf5BFAEjBPfdVnn/pySqTPpzutS6QreHz/f9qF
 RHCsa6n+lIWRNwmfQmGmebTfr9Avjsuim+VS09YFKyfAokPQCLynQXgeRJRzqsQjZBFxvw20avn
 JjFDjpax2x2eMmF3rVGKtBGVWJfQEbuXntCwslHlasANvPEfcAmma2niQKCerGocYVaAez0RuG5
 2aP/skY8PCUQZXHpLNKJHkuybBMur6lpCjZ4PAVl6Ts67+y/fO13p71FPhkE91VGvP9Z0F1FItr
 TTtQd98eHnj7mdlRz4cKIbUdwO0ffKBFBHEjYRom+5dA8l6rnGM7rc=
X-Google-Smtp-Source: AGHT+IH+WM2R82LJSoVF61wktTWZIyriVeWkBL/Q7uAlWBULwZ10LNm6jbuG6cgO46ane4lLu34qEw==
X-Received: by 2002:a17:907:9702:b0:b0a:f3f3:a28 with SMTP id
 a640c23a62f3a-b70701335ccmr239005666b.14.1761898741748; 
 Fri, 31 Oct 2025 01:19:01 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 (20014C4E24CBF70023E83719BDA98268.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077c3b1a4sm111015066b.46.2025.10.31.01.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 01:19:01 -0700 (PDT)
Message-ID: <11fd98bdd0b3abcd6e47ebd188b82eb67b63a25f.camel@gmail.com>
Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "siqueira@igalia.com" <siqueira@igalia.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Date: Fri, 31 Oct 2025 09:19:00 +0100
In-Reply-To: <DS0PR12MB65348B9EAE8322D587F19F8B9CF1A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
 <0fb9b183-ba74-4837-86a1-499b3acf04d5@amd.com>
 <f7bb25e7-0a64-4057-b068-5fb63d5d287e@amd.com>
 <DS0PR12MB6534854A0932A7E3E0D05D939CEEA@DS0PR12MB6534.namprd12.prod.outlook.com>
 <f2672baf-1f02-480d-a8c3-54f7f7863695@amd.com>
 <1835c00c-780a-4530-9652-5ee4a3bb8622@gmail.com>
 <DS0PR12MB6534C9AB60795127DEB8BAC69CF2A@DS0PR12MB6534.namprd12.prod.outlook.com>
 <6feb7b2587b972154f5235ff1c7168e1124329a3.camel@gmail.com>
 <DS0PR12MB65348B9EAE8322D587F19F8B9CF1A@DS0PR12MB6534.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

Hi Daniel,

Thank you, I really appreciate your work!

Out of curiosity, can you share what your testing methodology is?
What kind of functionality do you test in general, and how much of it
can you automate? Do you test on Linux or Windows? Or both?

(If you are not comfortable answering that in public, we can also
continue this off the mailing list.)

Best regards,
Timur

On Fri, 2025-10-24 at 21:28 +0000, Wheeler, Daniel wrote:
> [Public]
>=20
> Hi Timur,
>=20
> I tested the series on top of the promotion for this week, and it
> tested fine. So it should be merged alongside, and I can validate
> that next week. With that, I don't see why it wouldn't make it into
> 6.19. If there's anyone who's more knowledgeable on the release
> timelines who can confirm, that would be helpful.
>=20
> Thank you,
>=20
> Dan Wheeler
> Sr. Technologist | AMD
> SW Display
> ---------------------------------------------------------------------
> ---------------------------------------------
> 1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
> amd.com
>=20
>=20
> -----Original Message-----
> From: timur.kristof@gmail.com=C2=A0<timur.kristof@gmail.com>
> Sent: Friday, October 24, 2025 3:07 PM
> To: Wheeler, Daniel <Daniel.Wheeler@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; amd-gfx@lists.freedesktop.org; Chung,
> ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>; siqueira@igalia.com; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
>=20
> Hi Dan,
>=20
> Thanks, I'm looking forward to it. Please let me know how it goes.
>=20
> Is there any way I can help?
>=20
> I respect that testing and validating a huge series is non-trivial.
> However, considering that we have already missed the deadline for
> 6.18, I'd like to make sure, can this feature make it into 6.19?
>=20
> Thanks & best regards,
> Timur
>=20
> On Tue, 2025-10-21 at 17:32 +0000, Wheeler, Daniel wrote:
> > [Public]
> >=20
> > Hi Timur,
> >=20
> > Sorry, the patches weren't added to either last week's or this
> > week's
> > candidate. I'm going to add the patches on top of this week's
> > promotion and run the testing with them. I'll see about getting
> > them
> > merged alongside the promotion this week.
> >=20
> > Thank you,
> >=20
> > Dan Wheeler
> > Sr. Technologist | AMD
> > SW Display
> > -------------------------------------------------------------------
> > --
> > ---------------------------------------------
> > 1 Commerce Valley Dr E, Thornhill, ON L3T 7X6 amd.com
> >=20
> >=20
> > -----Original Message-----
> > From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Sent: Tuesday, October 21, 2025 12:15 PM
> > To: Wentland, Harry <Harry.Wentland@amd.com>; Wheeler, Daniel
> > <Daniel.Wheeler@amd.com>; amd-gfx@lists.freedesktop.org; Chung,
> > ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hung, Alex
> > <Alex.Hung@amd.com>; siqueira@igalia.com; Koenig, Christian
> > <Christian.Koenig@amd.com>
> > Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
> >=20
> > Hi,
> >=20
> > Did you guys manage to include the series in last week's promotion?
> > Are there any issues?
> >=20
> > I'd really like it to be included in Linux 6.18, are we still on
> > time
> > for that?
> >=20
> > Thanks & best regards,
> > Timur
> >=20
> > On 10/9/25 20:27, Harry Wentland wrote:
> > >=20
> > >=20
> > > On 2025-10-09 13:49, Wheeler, Daniel wrote:
> > > > [Public]
> > > >=20
> > > > Sure, we can add it to next week's promotion, I'm almost
> > > > through
> > > > this week's candidate. Tom is scheduled to prepare next week's
> > > > candidate, so I'll tag him in.
> > > >=20
> > >=20
> > > Great. Thanks.
> > >=20
> > > Harry
> > >=20
> > > > Thank you,
> > > >=20
> > > > Dan Wheeler
> > > > Sr. Technologist | AMD
> > > > SW Display
> > > > ---------------------------------------------------------------
> > > > --
> > > > ----
> > > > ---------------------------------------------
> > > > 1 Commerce Valley Dr E, Thornhill, ON L3T 7X6 amd.com
> > > >=20
> > > >=20
> > > > -----Original Message-----
> > > > From: Wentland, Harry <Harry.Wentland@amd.com>
> > > > Sent: Thursday, October 9, 2025 1:27 PM
> > > > To: Timur Krist=C3=B3f <timur.kristof@gmail.com>;
> > > > amd-gfx@lists.freedesktop.org; Wheeler, Daniel
> > > > <Daniel.Wheeler@amd.com>
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hung, Alex
> > > > <Alex.Hung@amd.com>; siqueira@igalia.com; Koenig, Christian
> > > > <Christian.Koenig@amd.com>
> > > > Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
> > > >=20
> > > >=20
> > > >=20
> > > > On 2025-10-08 17:11, Harry Wentland wrote:
> > > > > On 2025-09-26 14:01, Timur Krist=C3=B3f wrote:
> > > > > > This series adds support for analog connectors to DC for
> > > > > > DCE6-10.
> > > > > > There are two reasons to add this support:
> > > > > >=20
> > > > > > 1. GPUs that already use DC by default and have analog
> > > > > > connectors.
> > > > > > Some Tonga and Hawaii graphics cards in fact have DVI-I
> > > > > > connectors, and their analog part doesn't work with DC.
> > > > > > This
> > > > > > functionality regressed when switching from the amdgpu
> > > > > > legacy
> > > > > > display code to DC.
> > > > > >=20
> > > > > > 2. GPUs that don't use amdgpu by default yet.
> > > > > > Currently, SI (GFX6) and CIK (GFX7) don't use amdgpu by
> > > > > > default yet, and missing analog connector support in DC is
> > > > > > cited as one of the main reasons why not.
> > > > > >=20
> > > > > > Before starting this work, I asked Harry and Alex about how
> > > > > > best to do it and we agreed that we'd like to use the VBIOS
> > > > > > to
> > > > > > set up the DAC. So I used the amdgpu legacy display code as
> > > > > > a
> > > > > > reference.
> > > > > > The first few commits add some minor changes to DC to
> > > > > > prepare
> > > > > > for supporting analog stream and link encoders, then analog
> > > > > > link detection is added along with polling, and finally DAC
> > > > > > load detection support, which is useful for old displays
> > > > > > and
> > > > > > adapters.
> > > > > >=20
> > > > > > With this analog support added to DC, we could already
> > > > > > fully
> > > > > > switch CIK discrete GPUs to use DC and switch them to the
> > > > > > amdgpu driver by default. This series switches Bonaire to
> > > > > > DC
> > > > > > by default, we can do the switch to amdgpu in a later
> > > > > > series.
> > > > > >=20
> > > > > > For SI dGPUs, there are other pending patches to make DC
> > > > > > work
> > > > > > well, afterwards we could switch to DC by default, but
> > > > > > missing
> > > > > > VCE1 support is the blocker from using amdgpu by default.
> > > > > >=20
> > > > > > For GFX7 APUs, further work is needed before enabling DC by
> > > > > > default, specifically with regards to the TRAVIS and NUTMEG
> > > > > > external encoders which are not supported by DC at all.
> > > > > >=20
> > > > > > Changes in v2 of the series:
> > > > > > Fixed regression on RDNA2 and newer APUs.
> > > > > > Fixed flickering caused by polling analog connectors.
> > > > > > Fixed crash on Kaveri.
> > > > > > Fixed bug when HPD was high without a connected display.
> > > > > > Reduced code churn by reusing same link encoder.
> > > > > > Addressed other feedback from the review of v1.
> > > > >=20
> > > > > Thanks for the series.
> > > > >=20
> > > > > Patches 1-13 are
> > > > > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> > > > >=20
> > > > > I'll hope to find time for the rest tomorrow or Friday.
> > > > >=20
> > > >=20
> > > > The rest looks good to me as well.
> > > >=20
> > > > The whole series is
> > > > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> > > >=20
> > > > Dan, can we give this a spin in our weekly promotion tests
> > > > before
> > > > I merge it?
> > > >=20
> > > > Harry
> > > >=20
> > > > > Harry
> > > > >=20
> > > > > >=20
> > > > > > Timur Krist=C3=B3f (23):
> > > > > > =C2=A0=C2=A0 drm/amd/display: Determine DVI-I connector type (v=
2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Add analog bit to edid_caps (v2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Introduce MAX_LINK_ENCODERS (v2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Hook up DAC to
> > > > > > bios_parser_encoder_control
> > > > > > =C2=A0=C2=A0 drm/amd/display: Add SelectCRTC_Source to BIOS par=
ser
> > > > > > =C2=A0=C2=A0 drm/amd/display: Get maximum pixel clock from VBIO=
S
> > > > > > =C2=A0=C2=A0 drm/amd/display: Don't use stereo sync and audio o=
n RGB
> > > > > > signals (v2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Don't try to enable/disable HPD w=
hen
> > > > > > unavailable
> > > > > > =C2=A0=C2=A0 drm/amd/display: Determine early if a link has sup=
ported
> > > > > > encoders (v2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Add concept of analog encoders (v=
2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Implement DCE analog stream encod=
ers
> > > > > > =C2=A0=C2=A0 drm/amd/display: Implement DCE analog link encoder=
s (v2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Support DAC in dce110_hwseq
> > > > > > =C2=A0=C2=A0 drm/amd/display: Add analog link detection (v2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Refactor amdgpu_dm_connector_dete=
ct
> > > > > > (v2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Poll analog connectors (v2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Add DCE BIOS_SCRATCH_0 register
> > > > > > =C2=A0=C2=A0 drm/amd/display: Make get_support_mask_for_device_=
id
> > > > > > reusable
> > > > > > =C2=A0=C2=A0 drm/amd/display: Add DAC_LoadDetection to BIOS par=
ser
> > > > > > (v2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Use DAC load detection on analog
> > > > > > connectors (v2)
> > > > > > =C2=A0=C2=A0 drm/amd/display: Add common modes to analog displa=
ys
> > > > > > without EDID
> > > > > > =C2=A0=C2=A0 drm/amd/display: Don't add freesync modes to analo=
g
> > > > > > displays (v2)
> > > > > > =C2=A0=C2=A0 drm/amdgpu: Use DC by default for Bonaire
> > > > > >=20
> > > > > > =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 -
> > > > > > =C2=A0 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 173
> > > > > > ++++++++---
> > > > > > =C2=A0 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |=C2=A0=C2=
=A0 5 +-
> > > > > > =C2=A0 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |=C2=A0=C2=
=A0 1 +
> > > > > > =C2=A0 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |=C2=A0 20=
 ++
> > > > > > .../gpu/drm/amd/display/dc/bios/bios_parser.c |=C2=A0 95 +++++-
> > > > > > =C2=A0 .../drm/amd/display/dc/bios/command_table.c=C2=A0=C2=A0 =
| 286
> > > > > > ++++++++++++++++++
> > > > > > =C2=A0 .../drm/amd/display/dc/bios/command_table.h=C2=A0=C2=A0 =
|=C2=A0=C2=A0 6 +
> > > > > > =C2=A0 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |=C2=A0=C2=
=A0 4 +-
> > > > > > =C2=A0 .../gpu/drm/amd/display/dc/core/dc_resource.c |=C2=A0=C2=
=A0 8 +
> > > > > > =C2=A0 .../gpu/drm/amd/display/dc/dc_bios_types.h=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 9 +
> > > > > > =C2=A0 drivers/gpu/drm/amd/display/dc/dc_types.h=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> > > > > > =C2=A0 .../drm/amd/display/dc/dce/dce_link_encoder.c |=C2=A0 85
> > > > > > ++++++
> > > > > > .../drm/amd/display/dc/dce/dce_link_encoder.h |=C2=A0 16 +-
> > > > > > =C2=A0 .../amd/display/dc/dce/dce_stream_encoder.c=C2=A0=C2=A0 =
|=C2=A0 14 +
> > > > > > =C2=A0 .../amd/display/dc/dce/dce_stream_encoder.h=C2=A0=C2=A0 =
|=C2=A0=C2=A0 5 +
> > > > > > =C2=A0 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |=C2=A0 75=
 ++++-
> > > > > > =C2=A0 .../gpu/drm/amd/display/dc/inc/core_types.h=C2=A0=C2=A0 =
|=C2=A0=C2=A0 8 +-
> > > > > > =C2=A0 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |=C2=A0 24=
 ++
> > > > > > =C2=A0 .../drm/amd/display/dc/inc/hw/link_encoder.h=C2=A0 |=C2=
=A0=C2=A0 2 +
> > > > > > =C2=A0 drivers/gpu/drm/amd/display/dc/inc/resource.h |=C2=A0=C2=
=A0 1 +
> > > > > > =C2=A0 .../amd/display/dc/link/hwss/link_hwss_dio.c=C2=A0 |=C2=
=A0 19 +-
> > > > > > .../drm/amd/display/dc/link/link_detection.c=C2=A0 | 147
> > > > > > ++++++++-
> > > > > > =C2=A0 .../gpu/drm/amd/display/dc/link/link_dpms.c=C2=A0=C2=A0 =
|=C2=A0=C2=A0 9 +-
> > > > > > =C2=A0 .../drm/amd/display/dc/link/link_factory.c=C2=A0=C2=A0=
=C2=A0 |=C2=A0 60 +++-
> > > > > > =C2=A0 .../dc/resource/dce100/dce100_resource.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 31 +-
> > > > > > =C2=A0 .../dc/resource/dce110/dce110_resource.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > > > > =C2=A0 .../dc/resource/dce112/dce112_resource.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > > > > =C2=A0 .../dc/resource/dce120/dce120_resource.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > > > =C2=A0 .../dc/resource/dce60/dce60_resource.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 29 +-
> > > > > > =C2=A0 .../dc/resource/dce80/dce80_resource.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 26 +-
> > > > > > =C2=A0 .../amd/display/include/bios_parser_types.h=C2=A0=C2=A0 =
|=C2=A0 11 +-
> > > > > > =C2=A0 .../display/include/grph_object_ctrl_defs.h=C2=A0=C2=A0 =
|=C2=A0=C2=A0 1 +
> > > > > > =C2=A0 .../drm/amd/display/include/grph_object_id.h=C2=A0 |=C2=
=A0=C2=A0 7 +
> > > > > > =C2=A0 .../drm/amd/display/include/signal_types.h=C2=A0=C2=A0=
=C2=A0 |=C2=A0 12 +
> > > > > > =C2=A0 35 files changed, 1117 insertions(+), 86 deletions(-)
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20

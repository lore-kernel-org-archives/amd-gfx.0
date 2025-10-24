Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61563CCF9E0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 19:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D776410E1FA;
	Fri, 24 Oct 2025 19:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PjkiOYqv";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768CB10E1FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 19:07:08 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso3948504a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761332827; x=1761937627; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VVBgaXuUCcqZUksTw8KSTo2g9fH1GP9T8gCUm/Gs8/4=;
 b=PjkiOYqvvQAELrsXFiYKUQB6pizlHncDCPJQ1SjtaKKOWersasHqqowVlDRdgWdApw
 S57nGTGyPo8I6ZkUpnAKjfUwt9DRInD2F8xxCWBMOUR49fnlmtIlPh/cikCP5Zp7GVn8
 qlrDG7GJtItQCLBgthcw29Xk6ePaPJwvu5lwqwKaViFNO+KmXADP9SAwTpXHmLG2V45L
 Z8J2E5MeUc/h/Qd0+/ArZCeplxb2SevFlCyvrAYQurjwXfrTA3I1Auz2ZV29ScRyz0Dn
 Fuyf2CabI7PJQx2jKvzs5UwsErQpPUfuCoTKbnNaagAHH3olufCCgPNVmDkn7KXNCe5u
 LlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761332827; x=1761937627;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VVBgaXuUCcqZUksTw8KSTo2g9fH1GP9T8gCUm/Gs8/4=;
 b=D6s/Bwr6MYy1/WSU6581QT2D+yj2dUHi9vss2KiqwUR3vKxr6tarj3cPYaCOJ9GSuE
 66BeQvVIdJ68XzHT4qfArtMv0SUHa9aBa5giqQe6mZd0Y0hjUd3i6vjZ0WuFpmfAqquU
 M+8/wegrrgWXvSKYB8OtR9glrtiedoxzFqL92Iie6v0Qys0DC6KEiAom/sVlgxwlMPZy
 6qwzW9TQpVUsZBQTcnvdZizc5l8l+LFyN2ESrcaeSBdYXVDQ38jIlIBpI9rXAgxnh5uV
 BsdLGQr57/lJbnMm/WDob+jyhsGedJvQSyf0ah14LO6ZsRgAA6c3aHZbxJQN2d+b8Mql
 7uSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlAxtcfjkEdhPY4EzRq2uQ9bBlwahwPbuOp9+3+3Sc7rmilAkuvVNrh+xwWdFZssee9C018a3L@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/IHP6e8+vx/Dy1VnIeJjLDSAh2nnZBYAH3Y17UwnJNU7zP1bd
 s2hu9gzR0ny8IT/nm8rv2MasnrH0zyKoEclfoq0kCWn1COc2YqQCLH0k
X-Gm-Gg: ASbGncu7yqUZrFXan6GlD1y/i8pIa0lNYTfBINA33OLStAEF9dRkUSU7Ykl/dJFPw0K
 zffj/9wMzZHXEREhrWESJcQD9ckgYUSRr6gs+r/LrxqgKQ8r44fVg7CMPLkl+fJ0b1zRv+tBvtJ
 LpbEepPax10wcIRJzkO+0ddIFAra0KtCZMI6ZzotkwbcxeXwWNhSBAJq6UnX8Kyif9fx1efahA0
 eK07Mzn9qgboyspHdcWhNj3hWhzsQhZZiVc9qgVz37lvM1qr7wivIfcQVn/rnclr75GkeQZIBOC
 g9+ziuQwk+eBZIqWMK73F5kY5vc2ptrQ9kQEp2hpoLuSxUPD8EogC2sr3FOvmuMPvGfKaFyJaVU
 p5bitAo0c4Ya88iSMq8xMhjLWpHdSp1NT8ntxH19hNPBgUSQ2zFb/ePxy+1NNm5Ptvs+h1pXWs4
 t5IcWq7jRn86ZdaX128qxaGzCWdi2HhVCzJwy631Ep5HfqAKxanfxW+3T+KIE0Vv/Ecg7C3pm7H
 1hEwiQZKgS7KhZu3PgujxC5jCyB0UY997UTLt3cga1R9gazKifBcDFSxlWdXLj28w==
X-Google-Smtp-Source: AGHT+IGFr38YIfHjpdxnjrK7t9h/Lf6p3aZHrUATeHNNnvGP3IlOkWv3dU2teH5CmdGf83OISF2FQw==
X-Received: by 2002:a05:6402:42c5:b0:634:c377:e1ae with SMTP id
 4fb4d7f45d1cf-63e5eb29557mr3425014a12.14.1761332826724; 
 Fri, 24 Oct 2025 12:07:06 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24da:6700:e4da:bdc8:a726:ec86?
 (20014C4E24DA6700E4DABDC8A726EC86.dsl.pool.telekom.hu.
 [2001:4c4e:24da:6700:e4da:bdc8:a726:ec86])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3ebcd476sm5035733a12.13.2025.10.24.12.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 12:07:06 -0700 (PDT)
Message-ID: <6feb7b2587b972154f5235ff1c7168e1124329a3.camel@gmail.com>
Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
From: timur.kristof@gmail.com
To: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "siqueira@igalia.com" <siqueira@igalia.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Date: Fri, 24 Oct 2025 21:07:02 +0200
In-Reply-To: <DS0PR12MB6534C9AB60795127DEB8BAC69CF2A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
 <0fb9b183-ba74-4837-86a1-499b3acf04d5@amd.com>
 <f7bb25e7-0a64-4057-b068-5fb63d5d287e@amd.com>
 <DS0PR12MB6534854A0932A7E3E0D05D939CEEA@DS0PR12MB6534.namprd12.prod.outlook.com>
 <f2672baf-1f02-480d-a8c3-54f7f7863695@amd.com>
 <1835c00c-780a-4530-9652-5ee4a3bb8622@gmail.com>
 <DS0PR12MB6534C9AB60795127DEB8BAC69CF2A@DS0PR12MB6534.namprd12.prod.outlook.com>
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

Hi Dan,

Thanks, I'm looking forward to it. Please let me know how it goes.

Is there any way I can help?

I respect that testing and validating a huge series is non-trivial.
However, considering that we have already missed the deadline for 6.18,
I'd like to make sure, can this feature make it into 6.19?

Thanks & best regards,
Timur

On Tue, 2025-10-21 at 17:32 +0000, Wheeler, Daniel wrote:
> [Public]
>=20
> Hi Timur,
>=20
> Sorry, the patches weren't added to either last week's or this week's
> candidate. I'm going to add the patches on top of this week's
> promotion and run the testing with them. I'll see about getting them
> merged alongside the promotion this week.
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
> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Sent: Tuesday, October 21, 2025 12:15 PM
> To: Wentland, Harry <Harry.Wentland@amd.com>; Wheeler, Daniel
> <Daniel.Wheeler@amd.com>; amd-gfx@lists.freedesktop.org; Chung,
> ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>; siqueira@igalia.com; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
>=20
> Hi,
>=20
> Did you guys manage to include the series in last week's promotion?
> Are there any issues?
>=20
> I'd really like it to be included in Linux 6.18, are we still on time
> for that?
>=20
> Thanks & best regards,
> Timur
>=20
> On 10/9/25 20:27, Harry Wentland wrote:
> >=20
> >=20
> > On 2025-10-09 13:49, Wheeler, Daniel wrote:
> > > [Public]
> > >=20
> > > Sure, we can add it to next week's promotion, I'm almost through
> > > this week's candidate. Tom is scheduled to prepare next week's
> > > candidate, so I'll tag him in.
> > >=20
> >=20
> > Great. Thanks.
> >=20
> > Harry
> >=20
> > > Thank you,
> > >=20
> > > Dan Wheeler
> > > Sr. Technologist | AMD
> > > SW Display
> > > -----------------------------------------------------------------
> > > ----
> > > ---------------------------------------------
> > > 1 Commerce Valley Dr E, Thornhill, ON L3T 7X6 amd.com
> > >=20
> > >=20
> > > -----Original Message-----
> > > From: Wentland, Harry <Harry.Wentland@amd.com>
> > > Sent: Thursday, October 9, 2025 1:27 PM
> > > To: Timur Krist=C3=B3f <timur.kristof@gmail.com>;
> > > amd-gfx@lists.freedesktop.org; Wheeler, Daniel
> > > <Daniel.Wheeler@amd.com>
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hung, Alex
> > > <Alex.Hung@amd.com>; siqueira@igalia.com; Koenig, Christian
> > > <Christian.Koenig@amd.com>
> > > Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
> > >=20
> > >=20
> > >=20
> > > On 2025-10-08 17:11, Harry Wentland wrote:
> > > > On 2025-09-26 14:01, Timur Krist=C3=B3f wrote:
> > > > > This series adds support for analog connectors to DC for
> > > > > DCE6-10.
> > > > > There are two reasons to add this support:
> > > > >=20
> > > > > 1. GPUs that already use DC by default and have analog
> > > > > connectors.
> > > > > Some Tonga and Hawaii graphics cards in fact have DVI-I
> > > > > connectors,
> > > > > and their analog part doesn't work with DC. This
> > > > > functionality
> > > > > regressed when switching from the amdgpu legacy display code
> > > > > to DC.
> > > > >=20
> > > > > 2. GPUs that don't use amdgpu by default yet.
> > > > > Currently, SI (GFX6) and CIK (GFX7) don't use amdgpu by
> > > > > default
> > > > > yet, and missing analog connector support in DC is cited as
> > > > > one of
> > > > > the main reasons why not.
> > > > >=20
> > > > > Before starting this work, I asked Harry and Alex about how
> > > > > best to
> > > > > do it and we agreed that we'd like to use the VBIOS to set up
> > > > > the
> > > > > DAC. So I used the amdgpu legacy display code as a reference.
> > > > > The first few commits add some minor changes to DC to prepare
> > > > > for
> > > > > supporting analog stream and link encoders, then analog link
> > > > > detection is added along with polling, and finally DAC load
> > > > > detection support, which is useful for old displays and
> > > > > adapters.
> > > > >=20
> > > > > With this analog support added to DC, we could already fully
> > > > > switch
> > > > > CIK discrete GPUs to use DC and switch them to the amdgpu
> > > > > driver by
> > > > > default. This series switches Bonaire to DC by default, we
> > > > > can do
> > > > > the switch to amdgpu in a later series.
> > > > >=20
> > > > > For SI dGPUs, there are other pending patches to make DC work
> > > > > well,
> > > > > afterwards we could switch to DC by default, but missing
> > > > > VCE1 support is the blocker from using amdgpu by default.
> > > > >=20
> > > > > For GFX7 APUs, further work is needed before enabling DC by
> > > > > default, specifically with regards to the TRAVIS and NUTMEG
> > > > > external encoders which are not supported by DC at all.
> > > > >=20
> > > > > Changes in v2 of the series:
> > > > > Fixed regression on RDNA2 and newer APUs.
> > > > > Fixed flickering caused by polling analog connectors.
> > > > > Fixed crash on Kaveri.
> > > > > Fixed bug when HPD was high without a connected display.
> > > > > Reduced code churn by reusing same link encoder.
> > > > > Addressed other feedback from the review of v1.
> > > >=20
> > > > Thanks for the series.
> > > >=20
> > > > Patches 1-13 are
> > > > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> > > >=20
> > > > I'll hope to find time for the rest tomorrow or Friday.
> > > >=20
> > >=20
> > > The rest looks good to me as well.
> > >=20
> > > The whole series is
> > > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> > >=20
> > > Dan, can we give this a spin in our weekly promotion tests before
> > > I merge it?
> > >=20
> > > Harry
> > >=20
> > > > Harry
> > > >=20
> > > > >=20
> > > > > Timur Krist=C3=B3f (23):
> > > > > =C2=A0=C2=A0 drm/amd/display: Determine DVI-I connector type (v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Add analog bit to edid_caps (v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Introduce MAX_LINK_ENCODERS (v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Hook up DAC to
> > > > > bios_parser_encoder_control
> > > > > =C2=A0=C2=A0 drm/amd/display: Add SelectCRTC_Source to BIOS parse=
r
> > > > > =C2=A0=C2=A0 drm/amd/display: Get maximum pixel clock from VBIOS
> > > > > =C2=A0=C2=A0 drm/amd/display: Don't use stereo sync and audio on =
RGB
> > > > > signals (v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Don't try to enable/disable HPD whe=
n
> > > > > unavailable
> > > > > =C2=A0=C2=A0 drm/amd/display: Determine early if a link has suppo=
rted
> > > > > encoders (v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Add concept of analog encoders (v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Implement DCE analog stream encoder=
s
> > > > > =C2=A0=C2=A0 drm/amd/display: Implement DCE analog link encoders =
(v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Support DAC in dce110_hwseq
> > > > > =C2=A0=C2=A0 drm/amd/display: Add analog link detection (v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Refactor amdgpu_dm_connector_detect=
 (v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Poll analog connectors (v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Add DCE BIOS_SCRATCH_0 register
> > > > > =C2=A0=C2=A0 drm/amd/display: Make get_support_mask_for_device_id
> > > > > reusable
> > > > > =C2=A0=C2=A0 drm/amd/display: Add DAC_LoadDetection to BIOS parse=
r (v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Use DAC load detection on analog
> > > > > connectors (v2)
> > > > > =C2=A0=C2=A0 drm/amd/display: Add common modes to analog displays
> > > > > without EDID
> > > > > =C2=A0=C2=A0 drm/amd/display: Don't add freesync modes to analog
> > > > > displays (v2)
> > > > > =C2=A0=C2=A0 drm/amdgpu: Use DC by default for Bonaire
> > > > >=20
> > > > > =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 -
> > > > > =C2=A0 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 173
> > > > > ++++++++---
> > > > > =C2=A0 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |=C2=A0=C2=
=A0 5 +-
> > > > > =C2=A0 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |=C2=A0=C2=
=A0 1 +
> > > > > =C2=A0 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |=C2=A0 20 +=
+
> > > > > .../gpu/drm/amd/display/dc/bios/bios_parser.c |=C2=A0 95 +++++-
> > > > > =C2=A0 .../drm/amd/display/dc/bios/command_table.c=C2=A0=C2=A0 | =
286
> > > > > ++++++++++++++++++
> > > > > =C2=A0 .../drm/amd/display/dc/bios/command_table.h=C2=A0=C2=A0 |=
=C2=A0=C2=A0 6 +
> > > > > =C2=A0 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |=C2=A0=C2=
=A0 4 +-
> > > > > =C2=A0 .../gpu/drm/amd/display/dc/core/dc_resource.c |=C2=A0=C2=
=A0 8 +
> > > > > =C2=A0 .../gpu/drm/amd/display/dc/dc_bios_types.h=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 9 +
> > > > > =C2=A0 drivers/gpu/drm/amd/display/dc/dc_types.h=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> > > > > =C2=A0 .../drm/amd/display/dc/dce/dce_link_encoder.c |=C2=A0 85 +=
+++++
> > > > > .../drm/amd/display/dc/dce/dce_link_encoder.h |=C2=A0 16 +-
> > > > > =C2=A0 .../amd/display/dc/dce/dce_stream_encoder.c=C2=A0=C2=A0 |=
=C2=A0 14 +
> > > > > =C2=A0 .../amd/display/dc/dce/dce_stream_encoder.h=C2=A0=C2=A0 |=
=C2=A0=C2=A0 5 +
> > > > > =C2=A0 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |=C2=A0 75 +=
+++-
> > > > > =C2=A0 .../gpu/drm/amd/display/dc/inc/core_types.h=C2=A0=C2=A0 |=
=C2=A0=C2=A0 8 +-
> > > > > =C2=A0 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |=C2=A0 24 +=
+
> > > > > =C2=A0 .../drm/amd/display/dc/inc/hw/link_encoder.h=C2=A0 |=C2=A0=
=C2=A0 2 +
> > > > > =C2=A0 drivers/gpu/drm/amd/display/dc/inc/resource.h |=C2=A0=C2=
=A0 1 +
> > > > > =C2=A0 .../amd/display/dc/link/hwss/link_hwss_dio.c=C2=A0 |=C2=A0=
 19 +-
> > > > > .../drm/amd/display/dc/link/link_detection.c=C2=A0 | 147 ++++++++=
-
> > > > > =C2=A0 .../gpu/drm/amd/display/dc/link/link_dpms.c=C2=A0=C2=A0 |=
=C2=A0=C2=A0 9 +-
> > > > > =C2=A0 .../drm/amd/display/dc/link/link_factory.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0 60 +++-
> > > > > =C2=A0 .../dc/resource/dce100/dce100_resource.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 31 +-
> > > > > =C2=A0 .../dc/resource/dce110/dce110_resource.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > > > =C2=A0 .../dc/resource/dce112/dce112_resource.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > > > =C2=A0 .../dc/resource/dce120/dce120_resource.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > > =C2=A0 .../dc/resource/dce60/dce60_resource.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 29 +-
> > > > > =C2=A0 .../dc/resource/dce80/dce80_resource.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 26 +-
> > > > > =C2=A0 .../amd/display/include/bios_parser_types.h=C2=A0=C2=A0 |=
=C2=A0 11 +-
> > > > > =C2=A0 .../display/include/grph_object_ctrl_defs.h=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> > > > > =C2=A0 .../drm/amd/display/include/grph_object_id.h=C2=A0 |=C2=A0=
=C2=A0 7 +
> > > > > =C2=A0 .../drm/amd/display/include/signal_types.h=C2=A0=C2=A0=C2=
=A0 |=C2=A0 12 +
> > > > > =C2=A0 35 files changed, 1117 insertions(+), 86 deletions(-)
> > > > >=20
> > > >=20
> > >=20
> >=20

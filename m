Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE4DD609D9
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 18:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9AB10E2BB;
	Tue, 16 Dec 2025 18:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZgleTyAc";
	dkim-atps=neutral
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6630C10E2BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 18:22:20 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id
 46e09a7af769-7c76d855ddbso1738282a34.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 10:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765909339; x=1766514139; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WvBoQcL6sTFfbbK9wNRlgx6KUGi+hdnw9AFMhbGloo0=;
 b=ZgleTyAc/4/6IdhW9RFKzHJm7OhkI2OcTuPiB2yVVNqnc0+zc6sJYTv4OhZUDW6rSU
 Kl6+/nrJLHET/+hPY+IR3W0/KpE8K/kH186rKX5yIHDeE5qumyYzXySg32zdfi1gNS5v
 rl0AbtK/jy933bsvwxRn/gqO8S/iQM+VcB+G3oAn1iHGx0iAYi0oNkXHvjkn0+yOUz2G
 Fz5eR8Umkp3XrAq2bQUS8PJu0uVhGSgOT79hIKncw67nRUGucv9xYzBD46YGa7Skka4G
 b08zbblTZ9Bw1WExFWq7W9/LLiibnFr60xKnFrcIjw89/I/Z824umjtZ5y0hvE5Q8xH4
 dSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765909339; x=1766514139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WvBoQcL6sTFfbbK9wNRlgx6KUGi+hdnw9AFMhbGloo0=;
 b=bhRcWix6dRRO8PC8RU9NX4qO+7DetHkzp4bq7btyNLSQrxQzKh9zo5NZVjp4GxYxyc
 Yi1Naq1MLsihztbkvjlAYo5dfVB5HIhu1DZ1Qs58tqbagU+MYpsbPzdJV6+BJe0a1L7+
 agkclg0vy2K8H0EUFvQ5yxsMWwMe31XM0gB+l8ki+dV3y0Cw88pxdZL9fPc/2KET8CSf
 xBI4A9sDlZIDcpQcTLiY7M7+z6e14WnCMtS6A4OkD3CFEewutBC+EgSKkg8vTxz5Oaug
 +tZ4c1VxPWfYiOmtJZ3YcEkDQjObhOw6aT7wvh4Wy+zWEf8PEDVm0K1bHyj6U/TMUgV7
 Dl1g==
X-Gm-Message-State: AOJu0YwQugR270cSn20FaZfnWTlKuWCa1VZvjvTxO0wLNnxu5SWQXcdm
 aTyZrqXzyXAWrnDEJHMveJzN7Nfi9feo9NCuW8f/U3IC1Qjgyakq+nHE
X-Gm-Gg: AY/fxX68pZrqgifEkoQeoY83fbbngxuO5MqrudT9ZUnVlvRb6CpTJb2udr7jarUFp09
 LjGjIZyteMNyF3LMuuzyftHnfoXrkbUCY88kXfGL7QYiOap3mf4ic2xSb5FXn/Zan0jpwsDc2wo
 ICdeb/wDotu4VJVK1aLjRPFJ4iOGxLBUCJXx5KnzmR3QlAw8PJCetn64zZsn7Zx69bYz1GXV1Cm
 OIZeiwnlkrp69av457j5sDs0T5biHu8bfRQzVyqpurgpRJJkvKjkjkLwBgCL8RUBveLrddK+mEA
 mL2YLRyw5brptXWpu9G4RlyipNbPwLRzjCLwEPqlhkU2oipquKANf2p/27mt23uZr1RM2yk/rrJ
 YU5pmfoqmJ07XrKkBpyz4azTplSDzDIzVlYV5if5DgwbwiiAhJxDVjTP6fcbzsBcOGTbausIreR
 AtjdVPvR+MLeD4NB5o2Dmyu+80bJilRdw+0Ac=
X-Google-Smtp-Source: AGHT+IGZLPTK7ciD1XodCruWtwDT/pztgb+m86iIQS8kYvs+u9ovTBC69GwqD55zoOOBI5AQxgHlQw==
X-Received: by 2002:a05:6830:43a5:b0:7c9:5a1d:333a with SMTP id
 46e09a7af769-7cae81e3c52mr7332950a34.0.1765909339344; 
 Tue, 16 Dec 2025 10:22:19 -0800 (PST)
Received: from timur-max.localnet ([2806:105e:c:2784:c142:4173:ff05:1321])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb345977sm11798787a34.29.2025.12.16.10.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 10:22:18 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 alexander.deucher@amd.com, siqueira@igalia.com
Subject: Re: [PATCH 0/5] drm/amd/display: DC analog connector fixes
Date: Tue, 16 Dec 2025 12:21:35 -0600
Message-ID: <2595415.XAFRqVoOGU@timur-max>
In-Reply-To: <CADnq5_PhBodb6o9LHi6e5Y8yQUaJyTa_EvMyWFpmmfrpZrUkuA@mail.gmail.com>
References: <20251206023106.8875-1-timur.kristof@gmail.com>
 <CADnq5_PhBodb6o9LHi6e5Y8yQUaJyTa_EvMyWFpmmfrpZrUkuA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2025. december 16., kedd 9:27:34 k=C3=B6z=C3=A9ps=C5=91 =C3=A1llamokbeli=
 z=C3=B3naid=C5=91 Alex Deucher=20
wrote:
> On Fri, Dec 5, 2025 at 9:49=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@=
gmail.com>=20
wrote:
> > Fix a few issues with the initial DC analog connector
> > implementation that I've noticed since. I highly recommend
> > to backport this series to kernel versions that include
> > the DC analog series.
>=20
> Did you have an update for this series, or are they ready to be applied?
>=20
> Alex

Hi,

I re-reviewed my patches in this series again and I realized that my commen=
t=20
was mistaken (I confused link encoder with stream encoder). So the patches=
=20
should be good as-is.

However, in the meantime Mauro got back to me this weekend, and told me tha=
t=20
he determined that the patch "Setup DAC encoder before using it" not only=20
doesn't fix it, but regresses the analog connector on his HD 7790 further.=
=20
Before this patch, he got a black screen on boot, but the DAC started worki=
ng=20
after suspend/resume. After this patch, it no longer works for him even aft=
er=20
suspend/resume.

What do you think is the way to proceed?

A) Merge all patches but that one. I'll submit a corrected patch once we fi=
gure=20
out the HD 7790.
B) Merge the whole series as-is and I can submit a fix once we figured out =
what=20
is going on with the HD 7790.

Thanks & best regards,
Timur

>=20
> > Timur Krist=C3=B3f (5):
> >   drm/amd/display: Pass proper DAC encoder ID to VBIOS
> >   drm/amd/display: Correct color depth for SelectCRTC_Source
> >   drm/amd/display: Add missing encoder setup to DACnEncoderControl
> >   drm/amd/display: Setup DAC encoder before using it
> >   drm/amd/display: Don't repeat DAC load detection
> > =20
> >  .../gpu/drm/amd/display/dc/bios/bios_parser.c |  4 +-
> >  .../drm/amd/display/dc/bios/command_table.c   | 44 +++++++++++++++----
> >  .../drm/amd/display/dc/bios/command_table.h   |  4 +-
> >  .../drm/amd/display/dc/dce/dce_link_encoder.c |  2 +
> >  .../amd/display/dc/dce/dce_stream_encoder.c   | 25 ++++++++++-
> >  .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 28 +-----------
> >  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 +
> >  .../amd/display/dc/inc/hw/stream_encoder.h    |  4 ++
> >  .../amd/display/dc/link/hwss/link_hwss_dio.c  |  4 ++
> >  .../drm/amd/display/dc/link/link_detection.c  |  7 ++-
> >  .../drm/amd/display/dc/link/link_factory.c    | 10 ++---
> >  .../dc/resource/dce110/dce110_resource.c      |  2 +
> >  .../amd/display/include/bios_parser_types.h   |  2 +-
> >  13 files changed, 87 insertions(+), 51 deletions(-)
> >=20
> > --
> > 2.52.0





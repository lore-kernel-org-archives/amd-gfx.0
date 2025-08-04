Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90500C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 18:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D840710E22C;
	Mon,  4 Aug 2025 18:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iPzCniPX";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E1010E22C
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 18:51:51 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3b8de193b60so1107052f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754333510; x=1754938310; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1k1QeT0J8MKA8lXpIip4t+PaXDBHU/fNWdAUjH5UMvQ=;
 b=iPzCniPXRovFZFKJxZH7kt7pEZHefjrfwNQYbpU+gS1m5kjEYxOJMgPitD7Q35A6w6
 0fFbgAdmZ+TJokxEqD0KDBP0kRuKTCUe5NKTwdpRbNBUBhysWYJt8afPrOcdyIt0+feu
 OBFwqcydg9U48qf8aioDGKrkXRJySTutxn1332P3zTf3KkUHIb0PlCnSkAbO4LsrdnWA
 yMAHSKOBW3IU5CYq4Dq4PV1L6FzfY93dhWmIsdKBzmiNedpl46vXEF6FcS94AWQ3deyu
 4y/FhpaijRv+0K92szDmrEAoeAowyioK/VRTYgx9q4Q9EdO1T4yw37IjnWx4HflyMRGZ
 MzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754333510; x=1754938310;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1k1QeT0J8MKA8lXpIip4t+PaXDBHU/fNWdAUjH5UMvQ=;
 b=UA04XKfr/6eS+H+Gh6g3P2f/5XbmDkekSDagVYJIzqy0MfaWS+6A6KJir4O5Vv14c4
 wvSSiEcOFO/Iw9GKclhfA9/8o1C1nk43QcBkS2jb5PNXAdUiGccwkMpGLKLn+qnSfHxL
 quKGGDNCOhRu0iWXKIbg2TS7otKlqUpEUfT7r7Wd9DAiKo/m4zDvEJ8t5AIkgPJs7Zkm
 LvpGKVV0cyOz8uew8xz/ViQejbfSZbl0EK1THIq2+8VyijPXApc5mkhHjPBFakLE5b2H
 RIDP0DkaekOEMUNVSwHnU8/fm0GCKGDWbXVDIB1Sn6oMrZJkXnwHgQMwSqSkCQp4PLwN
 bI5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK2u78ROMjbsWaF7fEy72udJCbgMOBTFDiubdT5A72SJuaeWL4bAUjl/AyEVCCU6A4GCsXwwrv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUU+ZlgteZv2Bqf4dWM/+Knf9hI2fMcGQ0AEm147lCydBk2fM2
 HBrXU3S45W6iTj1syj3A/0Xgi8sAWI4Dk16ulGzU3n80aYuH1KQPe6Yq
X-Gm-Gg: ASbGncvOyr5qSWZAO4lQplOsgXueZ09NO612KO23OEfWdu5W/AY322nG7Xl4SI6r0RG
 kqbZ2AQek8kvR1L+RkUFGqDFqHDFOO3hhI5zd6PYWku5uQ0UnsfpZ+zxVKAOgV5mL3f8mjL8Yjk
 6v2eaeHXUux0V/wzV9viQ9x+3iLOrasBHEpGytSGPsJJFHqMiWgh19ipCOQUlotQSYe77kmnh8/
 qhFZgqJYwn7cksh+43+vXjG9NWYqU/0HQjxGxBAB/+wuDHtOtEUIeRAAUnC94Q86+cLVpN3VCoi
 DMC2kyhhEmgr4CPuosYIZ4MwWDVXOnQzyGPLiwSXqokmHwDlHFze16WRCNPy06WBdrfShgtCJN4
 6CJNewOYeE7KmOhDkQXcwgFu3jaoaPGQfulA5GL5zKZg2ox2+iCzglF0L0PziR4GnQIraQRqiyM
 +4bdX/RglOQdqR7KcCdM0g3ZI0YbYNEu0Aef4ZBNs6MiTy0Od33n+yY9yF+mSoyQ==
X-Google-Smtp-Source: AGHT+IHHkPokjSk5s0Jr+lZPvjjxd324kJVglrPByGZOSexmRFh7DXvQQaUlLutd1rdootayUfaN5A==
X-Received: by 2002:a05:6000:4203:b0:3b5:dafc:1525 with SMTP id
 ffacd0b85a97d-3b8d94b5c13mr7341997f8f.33.1754333509600; 
 Mon, 04 Aug 2025 11:51:49 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24da:bd00:a473:4c1d:2078:832b?
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47c516sm16484768f8f.62.2025.08.04.11.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 11:51:48 -0700 (PDT)
Message-ID: <e8f2d8f383178fd728e708b9f2c120749691a846.camel@gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: Power up UVD 3 for FW validation
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Christian Koenig <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>, 
 amd-gfx@lists.freedesktop.org
Date: Mon, 04 Aug 2025 20:51:46 +0200
In-Reply-To: <CADnq5_MGRH2D1YnhxGLLLJft5FvLaNKzhDgwWu_LPb0NvCK6Tg@mail.gmail.com>
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-2-timur.kristof@gmail.com>
 <CADnq5_O5F5UAC17CE4mwOx_5pbTKzv73Yuj=-_cA06G3hQeQJQ@mail.gmail.com>
 <aec0376f34db68c9e62d8ef5b8b5c51fe2eac5e2.camel@gmail.com>
 <CADnq5_MGRH2D1YnhxGLLLJft5FvLaNKzhDgwWu_LPb0NvCK6Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
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

On Mon, 2025-08-04 at 13:45 -0400, Alex Deucher wrote:
> On Mon, Aug 4, 2025 at 12:00=E2=80=AFPM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > On Mon, 2025-08-04 at 11:20 -0400, Alex Deucher wrote:
> > > On Mon, Aug 4, 2025 at 9:58=E2=80=AFAM Timur Krist=C3=B3f
> > > <timur.kristof@gmail.com> wrote:
> > > >=20
> > > > Unlike later versions, UVD 3 has firmware validation.
> > > > For this to work, the UVD should be powered up correctly.
> > > >=20
> > > > When DPM is enabled and the display clock is off,
> > > > the SMU may choose a power state which doesn't power
> > > > the UVD, which can result in failure to initialize UVD.
> > >=20
> > > + Christian, Leo
> > >=20
> > > That doesn't seem right to me.=C2=A0 IIRC, the driver always set the
> > > UVD
> > > PLL directly on SI and I don't think SI supported any kind of UVD
> > > power gating. I guess it's probably some sort of subtle
> > > sequencing
> > > difference between radeon and amdgpu.=C2=A0 Unless Christian or Leo
> > > have
> > > any ideas, I think the patch is probably fine.
> > >=20
> > > Alex
> >=20
> > Hi,
> >=20
> > These are my observations about how the UVD clock works on SI:
> >=20
> > 1. It seems that the SMC needs to know whether UVD is enabled or
> > not,
> > and the UVD clocks are included as part of the power states. See:
> > si_convert_power_state_to_smc
> > si_convert_power_level_to_smc
> >=20
> > On SI the default power state doesn't set the UVD clocks,
> > and SI has a specific power state to be used with UVD. Actually
> > amdgpu_dpm_enable_uvd has a special case code path for SI, where it
> > sets this power state. If I print the power states from
> > si_parse_power_table, it indeed confirms that there is only one
> > power
> > state that has non-zero UVD clocks, and the rest of them just have
> > the
> > UVD clocks at zero.
> >=20
> > It's unclear to me what happens if we try to enable UVD clocks when
> > we
> > selected a power state that doesn't include them (ie. when we don't
> > tell the SMC that UVD is active).
> >=20
> > 2. When setting a power state that enables UVD, the UVD clock is
> > enabled either before or after the engine clock by si_dpm. This is
> > done
> > so in both radeon and amdgpu, see:
> > si_dpm_set_power_state
> > ni_set_uvd_clock_before_set_eng_clock
> > ni_set_uvd_clock_after_set_eng_clock
> >=20
> > The specific sequence in which the UVD clock is enabled by
> > si_dpm_set_power_state leads me to the conclusion that
> > amdgpu_asic_set_uvd_clocks should not be directly called on SI
> > outside
> > of the DPM code.
> >=20
> > Please correct me if I misunderstood the code.
>=20
> Yeah, I don't remember the clock dependencies.=C2=A0 I thought that you
> should be able to program the UVD PLLs any time you wanted and the
> ordering only mattered when you were also changing the sclk.

In that case, wouldn't it cause issues that the SMC is not aware that
the UVD is running?

As far as I see from si_convert_power_*_to_smc there are some flags in
the power states which are set differently depending on whether UVD is
active or not.

A secondary issue is that the VBIOS seems to have different clock
values for the UVD compared to what is hardcoded in the driver. This
doesn't mean the driver is incorrect, but si_dpm does use the values
from the VBIOS.

> Programming the PLLs directly works as is in radeon, but I guess
> maybe
> we init DPM in a different order in radeon vs amdgpu.

The order is the same.

Looking at radeon's si.c, in si_init:
It calls radeon_pm_init (which eventually calls si_dpm_init) before
calling si_uvd_init.

Looking at amdgpu's si.c, in si_set_ip_blocks:
The si_smu_ip_block is added before uvd_v3_1_ip_block.

I think the main difference between radeon and amdgpu as far as I see:
- radeon doesn't do the FW validation
- radeon doesn't do a ring test

Hence, radeon doesn't actually need to enable the UVD clocks at
initialization.

>=20
> It would also probably be a good idea to disable the UVD clocks again
> after IP init to save power. E.g., something like:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->pm.dpm_enabled)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 amdgpu_dpm_enable_uvd(adev, false);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>=20
> Alex

Note that the UVD clocks were already enabled by uvd_v3_1_hw_init, when
it creates the ring test, that calls amdgpu_uvd_ring_begin_use which
enables the clock by calling amdgpu_dpm_enable_uvd. The only difference
that my patch makes is that it now enables the UVD clock just a little
bit earlier.

I think we can't disable the UVD clocks directly in uvd_v3_1_hw_init,
because the ring test would fail. However, as far as I understand, the
UVD clocks are already disabled automatically anyway after the ring
test is done: amdgpu_ring_commit calls amdgpu_uvd_ring_end_use. This
launches the UVD idle work handler, which automatically disables the UV
clock when all pending fences are signalled.

Please correct me if I misunderstood this.

Thanks,
Timur


>=20
>=20
> >=20
> > Thanks,
> > Timur
> >=20
> >=20
> > >=20
> > > >=20
> > > > Fixes: b38f3e80ecec ("drm amdgpu: SI UVD v3_1 (v2)")
> > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > ---
> > > > =C2=A0drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 9 ++++++---
> > > > =C2=A01 file changed, 6 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > > b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > > index 5dbaebb592b3..9ad06c1e150d 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > > @@ -633,6 +633,12 @@ static int uvd_v3_1_hw_init(struct
> > > > amdgpu_ip_block *ip_block)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int r;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_mc_resume(adev)=
;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_enable_mgcg(adev, tr=
ue);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->pm.dpm_enabled)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 amdgpu_dpm_enable_uvd(adev, true);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D uvd_v3_1_fw_valida=
te(adev);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r) {
> > > > @@ -640,9 +646,6 @@ static int uvd_v3_1_hw_init(struct
> > > > amdgpu_ip_block *ip_block)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return r;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_enable_mgcg(adev, tr=
ue);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_asic_set_uvd_clocks(ad=
ev, 53300, 40000);
> > > > -
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_start(adev);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D amdgpu_ring_test_h=
elper(ring);
> > > > --
> > > > 2.50.1
> > > >=20

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6FEC87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 00:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F7B10E107;
	Wed,  6 Aug 2025 00:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D66XSKFp";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4262610E107
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 00:35:11 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-45994a72356so3222935e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Aug 2025 17:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754440510; x=1755045310; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/BIrAoibcrvI570WVyqnuR09ebV0XLfzki+UZ4cO0fw=;
 b=D66XSKFpEgKsv/VWeXs9v11whUtCYYuVclb46jcWxobDPiapXgoYEj7Kr+A6sxv31v
 mXm1lnNBIVrRlH0hb7u5uzHcHNB2N/K/vRXBuGMcKtP1x/KMYOYEWgn4Sa7OqI+Wf8+w
 OftKVy5a/ZGTRDT7Rs/4f3+piRy5c8TuWq/JqrPx46pV7tRLZqbyMhFp6Hbj4qOUDUlp
 F8+uRHIHWmSBo4cnG6w0Lfq8+fOl1v7+K7+aQ6vg5QmdNxMTNa06Fgj1JuOTKNrTS/sy
 INmy8Bp5Vj9aoXJIdzNyPgl0om08YfS3tzZBNZ1Xm8fMQ94rAMNlxQgE+CXxL4ngpEuq
 sSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754440510; x=1755045310;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/BIrAoibcrvI570WVyqnuR09ebV0XLfzki+UZ4cO0fw=;
 b=F9eZeHb+5JvwlTa8B+DEjfbz32Yxwapf2oItsSS/Ez7xwoCBLy8pigBEDK9OS6Pz/4
 Vi5b2+POX5ijLVyCmZl3I7FaXlPdYylqn7TdcKPtDanOd1ppwZqUBLBqPf9vXw402AEj
 xD3bf8X/wREU3fMFdWneU5Jr3DYFDFBl6PRc684/3No16bbDXXlGXrZc3H7jgLrVb41W
 /BmnyKQwgTy/9QdLRMLkCxfHXD1pDQJrEzduRqux4xuKsDpB/DDPGHMj1mHm/vC0jZNW
 JD6Io60vTKLpGP523TbVKAFa5i3cmgO/Y1NevAvL83d4MNykRs0Vjlq7O0/V+p/TN5NY
 1udQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3PvjFuWjUCw8jbakwd0GIirXqVEBG2+Jhf9/L0cIYiZN9KP1q3RHO3K/9z7xVs3wqxJu6qvg2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnEgOVIofm/OmPHel25WdpaKBFnNmFJ43dv4eYpv8eYF7ZRmbt
 r6KD5xXCLCwCPhgS5C0fRpnKnhnFhmMcNJw1KoJCeNZHzw992wJwOaGc
X-Gm-Gg: ASbGncuRqpsDCb2GlXDWPbjEV7Inf3cyhr+o2brZj8OaqX4WLPH3Hiwp0VSRPI4Iydf
 Iz9t10dS2UBRYLBWbTFmStXtgcS6TtNHAoLwar1tW7oEGE0QHjUj0alYJ0X3lEyvjzcck4JOcLV
 HHnCSFb3/kEyZ/kvR2MzIwbvd3sqwypGfS9o0wxpLy1dQ36Z3Oy06ltyd1smHM0y5mr2BdeGuI7
 gRxST0QNuN+N4Yw9JyHqy5TEgWIUL9ZZpzIjRbRV7wWBvHGUCBUOPNMZCqh9q1/L8YyE/kDxGiO
 K27rxDny1GUZhpnbOqv3IL86NaRa3BBPfKjiiuLHM/tUBa6vw4ziXEX4oQGGL7IH3QQCi7sSrB1
 2B1RZXuuUuyVIXr78Rxoin91G9zt4GKuZWoNShDz4nszOsIWU2XbvnE0wxSC5DLfJ4CDRue4qqN
 3bIpaGrftnRycJ+qDEt2xoJy3UpjGzM97LZ+fOe3a9RRAmliO0wot06AAzyKhQXfKK8tylgNZa
X-Google-Smtp-Source: AGHT+IH4zboNm+wbWphdpaxi6np/KeXtM8/jahfna2egUi5JhPZLJlrlQJUVVIq0cpfWQfD9mCwNWw==
X-Received: by 2002:a05:600c:6211:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-459e70f04bfmr6492565e9.10.1754440509487; 
 Tue, 05 Aug 2025 17:35:09 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24da:bd00:bf67:748c:caa0:fc72?
 (20014C4E24DABD00BF67748CCAA0FC72.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:bf67:748c:caa0:fc72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e075805csm65732205e9.4.2025.08.05.17.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 17:35:08 -0700 (PDT)
Message-ID: <8baae4b5b5af6078a27c8a20202fa1b660fc8aef.camel@gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: Power up UVD 3 for FW validation
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex
 Deucher <alexdeucher@gmail.com>
Cc: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org
Date: Wed, 06 Aug 2025 02:35:07 +0200
In-Reply-To: <99761dc3-7814-42be-8d08-c8ff7b2a76cf@amd.com>
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-2-timur.kristof@gmail.com>
 <CADnq5_O5F5UAC17CE4mwOx_5pbTKzv73Yuj=-_cA06G3hQeQJQ@mail.gmail.com>
 <aec0376f34db68c9e62d8ef5b8b5c51fe2eac5e2.camel@gmail.com>
 <CADnq5_MGRH2D1YnhxGLLLJft5FvLaNKzhDgwWu_LPb0NvCK6Tg@mail.gmail.com>
 <99761dc3-7814-42be-8d08-c8ff7b2a76cf@amd.com>
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

On Mon, 2025-08-04 at 20:59 +0200, Christian K=C3=B6nig wrote:
> On 04.08.25 19:45, Alex Deucher wrote:
> > On Mon, Aug 4, 2025 at 12:00=E2=80=AFPM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >=20
> > > On Mon, 2025-08-04 at 11:20 -0400, Alex Deucher wrote:
> > > > On Mon, Aug 4, 2025 at 9:58=E2=80=AFAM Timur Krist=C3=B3f
> > > > <timur.kristof@gmail.com> wrote:
> > > > >=20
> > > > > Unlike later versions, UVD 3 has firmware validation.
> > > > > For this to work, the UVD should be powered up correctly.
> > > > >=20
> > > > > When DPM is enabled and the display clock is off,
> > > > > the SMU may choose a power state which doesn't power
> > > > > the UVD, which can result in failure to initialize UVD.
> > > >=20
> > > > + Christian, Leo
> > > >=20
> > > > That doesn't seem right to me.=C2=A0 IIRC, the driver always set th=
e
> > > > UVD
> > > > PLL directly on SI and I don't think SI supported any kind of
> > > > UVD
> > > > power gating. I guess it's probably some sort of subtle
> > > > sequencing
> > > > difference between radeon and amdgpu.=C2=A0 Unless Christian or Leo
> > > > have
> > > > any ideas, I think the patch is probably fine.
>=20
> Oh my, that stuff was last at the front of my head a long long time
> ago.

Thanks for taking the time to reply anyway!

>=20
> > > >=20
> > > > Alex
> > >=20
> > > Hi,
> > >=20
> > > These are my observations about how the UVD clock works on SI:
> > >=20
> > > 1. It seems that the SMC needs to know whether UVD is enabled or
> > > not,
> > > and the UVD clocks are included as part of the power states. See:
> > > si_convert_power_state_to_smc
> > > si_convert_power_level_to_smc
>=20
> Correct, yes. The design was that either the KMD or the SMC could
> program the PLLs.
>=20
> > >=20
> > > On SI the default power state doesn't set the UVD clocks,
> > > and SI has a specific power state to be used with UVD. Actually
> > > amdgpu_dpm_enable_uvd has a special case code path for SI, where
> > > it
> > > sets this power state. If I print the power states from
> > > si_parse_power_table, it indeed confirms that there is only one
> > > power
> > > state that has non-zero UVD clocks, and the rest of them just
> > > have the
> > > UVD clocks at zero.
> > >=20
> > > It's unclear to me what happens if we try to enable UVD clocks
> > > when we
> > > selected a power state that doesn't include them (ie. when we
> > > don't
> > > tell the SMC that UVD is active).
>=20
> IIRC there were two possibilities.
>=20
> Either you let the SMC handle the clocks in which case it would lower
> the GFX clock in favor of stable UVD clocks.
>=20
> Or the KMD would lock the SMC to the highest level and then program
> the UVD clocks manually.

As far as I see the si_dpm code does a mixture of the above two.
When UVD is enabled, it selects the VBIOS-provided UVD power state and
then it manually enables the UVD clocks to the value provided by the
VBIOS.

When the UVD ring is not used anymore, it then shuts the UVD clock down
manually.

(I assume then it goes back to a normal power state but I haven't
actually verified that.)

>=20
> The later was not really validated but requested by a lot of people
> because otherwise you got a GFX performance reduction whenever you
> used UVD.

Yes, the UVD power state from the VBIOS indeed has lower shader clocks
compared to the normal power state.

>=20
> > >=20
> > > 2. When setting a power state that enables UVD, the UVD clock is
> > > enabled either before or after the engine clock by si_dpm. This
> > > is done
> > > so in both radeon and amdgpu, see:
> > > si_dpm_set_power_state
> > > ni_set_uvd_clock_before_set_eng_clock
> > > ni_set_uvd_clock_after_set_eng_clock
> > >=20
> > > The specific sequence in which the UVD clock is enabled by
> > > si_dpm_set_power_state leads me to the conclusion that
> > > amdgpu_asic_set_uvd_clocks should not be directly called on SI
> > > outside
> > > of the DPM code.
> > >=20
> > > Please correct me if I misunderstood the code.
>=20
> That sounds correct to me.

Thanks!

Sounds like the patch is correct, then.

>=20
> >=20
> > Yeah, I don't remember the clock dependencies.=C2=A0 I thought that you
> > should be able to program the UVD PLLs any time you wanted and the
> > ordering only mattered when you were also changing the sclk.
> > Programming the PLLs directly works as is in radeon, but I guess
> > maybe
> > we init DPM in a different order in radeon vs amdgpu.
> >=20
> > It would also probably be a good idea to disable the UVD clocks
> > again
> > after IP init to save power. E.g., something like:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->pm.dpm_enabled)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 amdgpu_dpm_enable_uvd(adev, false);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>=20
> IIRC we always disabled the PLL manually when UVD was unused because
> the SMC sometimes failed to do this.


Yes, as I mentioned in my previous mail the PM code does that already
when the UVD ring is not in use anymore. So it's not necessary to add
any code to shut it down.

Maybe I should edit the commit to explain that in a comment?

Thanks,
Timur

>=20
> Regards,
> Christian.
>=20
> >=20
> > Alex
> >=20
> >=20
> > >=20
> > > Thanks,
> > > Timur
> > >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > Fixes: b38f3e80ecec ("drm amdgpu: SI UVD v3_1 (v2)")
> > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > ---
> > > > > =C2=A0drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 9 ++++++---
> > > > > =C2=A01 file changed, 6 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > > > index 5dbaebb592b3..9ad06c1e150d 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > > > > @@ -633,6 +633,12 @@ static int uvd_v3_1_hw_init(struct
> > > > > amdgpu_ip_block *ip_block)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int r;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_mc_resume(ade=
v);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_enable_mgcg(adev, =
true);
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->pm.dpm_enabled)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 amdgpu_dpm_enable_uvd(adev, true);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 amdgpu_asic_set_uvd_clocks(adev, 53300,
> > > > > 40000);
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D uvd_v3_1_fw_vali=
date(adev);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r) {
> > > > > @@ -640,9 +646,6 @@ static int uvd_v3_1_hw_init(struct
> > > > > amdgpu_ip_block *ip_block)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return r;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_enable_mgcg(adev, =
true);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_asic_set_uvd_clocks(=
adev, 53300, 40000);
> > > > > -
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_start(adev);
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D amdgpu_ring_test=
_helper(ring);
> > > > > --
> > > > > 2.50.1
> > > > >=20

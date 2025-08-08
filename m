Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4624C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 08:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4C510E507;
	Fri,  8 Aug 2025 08:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T1RFmgkR";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9FA10E507
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 08:23:53 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3b78d337dd9so1098152f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Aug 2025 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754641432; x=1755246232; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nDfrCytAull36hchS6EOh4B1N5kAN5M1R7b6hj+Lce8=;
 b=T1RFmgkRzPNXPT0adQ9bHawTKckXCsTLvqhzkhE01jaP1ovKgp1CAZ8+60E/VOhuky
 cSSUKa4QynPh6AJX/jPHWDAhOT5M83HeePXBgGdJ2nMBnVengmu1Mx+wBuv0P6l3qqHJ
 crCsWiSLqNvK6irlYuVQ/wZCzJqnstEBoL5Q2U7Frlnwwv2NT51ykh0KI4N6J74KbnPS
 r3VyuTrgkaGjmRM4dOjy3PPZOYZLtOGv8iIGhnjNfA+VJF13MZOGp0TTBfZxmPZdqkTL
 kiNhma4qpQ2U1OeUp93gsmb9P9JJgOXshlONsmYmoUp5flxPH3THRqBz1aQj+4FL+HZG
 JhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754641432; x=1755246232;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nDfrCytAull36hchS6EOh4B1N5kAN5M1R7b6hj+Lce8=;
 b=aEreQZefzWDcNnqYfTluTYmGWVEkYgrSvBAzKsMnVRtq0X4xpjM7ZxHJn99AbrCdEH
 9CmCp7Jd/RQ5y04659IUjfMY+BdONQEYfgwup/fivJ8lWXOf3Dd8QXB8C6iMYP+bD7z6
 K8DvqwPOItQokLTZnw8uGuGQzlteL9DHc6TIVO5talDYGzoYMlRTYl0nxijeWikVSmfV
 pQDJXRpMrCmiEBrdzj6woUVlNrBZueBPVKWJ20uH+TC7KqfbdPj6GEs5l4xzeBCDC0If
 lC6dKAcOg2ucj4WVFZeGCAteRpGY8JFnIAXRxTfWdvUCZYkKcOPSw1+b0edEKMDNJpPA
 IOtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv2l/YD32HF9QQOmUxdHO3IJqv9MKT+EklDaxNbMaHDkOmoBaoFPHSf8ngimPJg7Yy1mh4tCf2@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywi7t2z47sPVPFNNcXG8gd988TXOxUNm0Pk70RWhFetcwYz7FYW
 yIz49At/A2L3CCOQfR7obcNo8j1TPs7pKonmGo4uG/sho/CJRc4TjEAD
X-Gm-Gg: ASbGncs0O8JWGDTiujjF4TRbxAqV0VVV5lQx4o9Lfy53PxkoaeoZpoK5oKHopltXdpH
 pN6gMa7mQC0MUZ71SWug5ysK1NMyVfy0QknDXfCDUrWkoSmZVLGDSEStKpGinVh8O7+EiG7LKH6
 Q7pz19w611DOGmtqzq/KXrD98GKMo+tEGrgdKtjDMh848stmGiQoEjVGtkEfGtaKe3FO/52e2v6
 vaU1rhp1+OHIqiLFLnRRlQn4Rw9RWghVkGuxOZ4CiWIjRtx6sK8LhoWUS6RGASRdypi/rkw/aOe
 BK42x8QkaiMHDI8xRg9m9bs0FNm8NIMOPHT9fnjYSETOG8RCA7O1JpLqGzg18FofKRJNZZu7aOK
 pIGN+kXjza8GSzm5WUFOxnqh5e0h0hg7EYZkz9ptigQ3RWpgHXtbYzwBUy1x1RV4q6CAXTvnS2N
 X0uwpfwISbnCmajuEAFJrMk0aL9iTDwKXKPVVQ/w2pDJ3WYoerz152+UZzNLxCOw==
X-Google-Smtp-Source: AGHT+IG8Ge54/4Ev+cXovbaa5bQWnRn45lM6jbReXGmCHCXujoMxzKHg1hFkfP9xCLCah61DXxnTFA==
X-Received: by 2002:a05:6000:4305:b0:3b8:d893:524c with SMTP id
 ffacd0b85a97d-3b900b6a1e7mr1785599f8f.53.1754641431944; 
 Fri, 08 Aug 2025 01:23:51 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d0:2800:6d31:8bf4:e59f:ec20?
 (20014C4E24D028006D318BF4E59FEC20.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:2800:6d31:8bf4:e59f:ec20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac093sm31013357f8f.9.2025.08.08.01.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 01:23:51 -0700 (PDT)
Message-ID: <8a1b61f47ef4632826118b3f2e19eee01fa5793b.camel@gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: Power up UVD 3 for FW validation
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex
 Deucher <alexdeucher@gmail.com>
Cc: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org
Date: Fri, 08 Aug 2025 10:23:50 +0200
In-Reply-To: <79bb0b1f-687c-4f6f-8a3e-728e8d0c8800@amd.com>
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-2-timur.kristof@gmail.com>
 <CADnq5_O5F5UAC17CE4mwOx_5pbTKzv73Yuj=-_cA06G3hQeQJQ@mail.gmail.com>
 <aec0376f34db68c9e62d8ef5b8b5c51fe2eac5e2.camel@gmail.com>
 <CADnq5_MGRH2D1YnhxGLLLJft5FvLaNKzhDgwWu_LPb0NvCK6Tg@mail.gmail.com>
 <99761dc3-7814-42be-8d08-c8ff7b2a76cf@amd.com>
 <8baae4b5b5af6078a27c8a20202fa1b660fc8aef.camel@gmail.com>
 <79bb0b1f-687c-4f6f-8a3e-728e8d0c8800@amd.com>
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

On Wed, 2025-08-06 at 14:27 +0200, Christian K=C3=B6nig wrote:
> On 06.08.25 02:35, Timur Krist=C3=B3f wrote:
> > >=20
> > > > > >=20
> > > > > > Alex
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > These are my observations about how the UVD clock works on
> > > > > SI:
> > > > >=20
> > > > > 1. It seems that the SMC needs to know whether UVD is enabled
> > > > > or
> > > > > not,
> > > > > and the UVD clocks are included as part of the power states.
> > > > > See:
> > > > > si_convert_power_state_to_smc
> > > > > si_convert_power_level_to_smc
> > >=20
> > > Correct, yes. The design was that either the KMD or the SMC could
> > > program the PLLs.
> > >=20
> > > > >=20
> > > > > On SI the default power state doesn't set the UVD clocks,
> > > > > and SI has a specific power state to be used with UVD.
> > > > > Actually
> > > > > amdgpu_dpm_enable_uvd has a special case code path for SI,
> > > > > where
> > > > > it
> > > > > sets this power state. If I print the power states from
> > > > > si_parse_power_table, it indeed confirms that there is only
> > > > > one
> > > > > power
> > > > > state that has non-zero UVD clocks, and the rest of them just
> > > > > have the
> > > > > UVD clocks at zero.
> > > > >=20
> > > > > It's unclear to me what happens if we try to enable UVD
> > > > > clocks
> > > > > when we
> > > > > selected a power state that doesn't include them (ie. when we
> > > > > don't
> > > > > tell the SMC that UVD is active).
> > >=20
> > > IIRC there were two possibilities.
> > >=20
> > > Either you let the SMC handle the clocks in which case it would
> > > lower
> > > the GFX clock in favor of stable UVD clocks.
> > >=20
> > > Or the KMD would lock the SMC to the highest level and then
> > > program
> > > the UVD clocks manually.
> >=20
> > As far as I see the si_dpm code does a mixture of the above two.
> > When UVD is enabled, it selects the VBIOS-provided UVD power state
> > and
> > then it manually enables the UVD clocks to the value provided by
> > the
> > VBIOS.
> >=20
> > When the UVD ring is not used anymore, it then shuts the UVD clock
> > down
> > manually.
> >=20
> > (I assume then it goes back to a normal power state but I haven't
> > actually verified that.)
> >=20
> > >=20
> > > The later was not really validated but requested by a lot of
> > > people
> > > because otherwise you got a GFX performance reduction whenever
> > > you
> > > used UVD.
> >=20
> > Yes, the UVD power state from the VBIOS indeed has lower shader
> > clocks
> > compared to the normal power state.
> >=20
> > >=20
> > > > >=20
> > > > > 2. When setting a power state that enables UVD, the UVD clock
> > > > > is
> > > > > enabled either before or after the engine clock by si_dpm.
> > > > > This
> > > > > is done
> > > > > so in both radeon and amdgpu, see:
> > > > > si_dpm_set_power_state
> > > > > ni_set_uvd_clock_before_set_eng_clock
> > > > > ni_set_uvd_clock_after_set_eng_clock
> > > > >=20
> > > > > The specific sequence in which the UVD clock is enabled by
> > > > > si_dpm_set_power_state leads me to the conclusion that
> > > > > amdgpu_asic_set_uvd_clocks should not be directly called on
> > > > > SI
> > > > > outside
> > > > > of the DPM code.
> > > > >=20
> > > > > Please correct me if I misunderstood the code.
> > >=20
> > > That sounds correct to me.
> >=20
> > Thanks!
> >=20
> > Sounds like the patch is correct, then.
>=20
> Most likely yes.
>=20
> >=20
> > >=20
> > > >=20
> > > > Yeah, I don't remember the clock dependencies.=C2=A0 I thought that
> > > > you
> > > > should be able to program the UVD PLLs any time you wanted and
> > > > the
> > > > ordering only mattered when you were also changing the sclk.
> > > > Programming the PLLs directly works as is in radeon, but I
> > > > guess
> > > > maybe
> > > > we init DPM in a different order in radeon vs amdgpu.
> > > >=20
> > > > It would also probably be a good idea to disable the UVD clocks
> > > > again
> > > > after IP init to save power. E.g., something like:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->pm.dpm_enabled)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 amdgpu_dpm_enable_uvd(adev, false);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> > >=20
> > > IIRC we always disabled the PLL manually when UVD was unused
> > > because
> > > the SMC sometimes failed to do this.
> >=20
> >=20
> > Yes, as I mentioned in my previous mail the PM code does that
> > already
> > when the UVD ring is not in use anymore. So it's not necessary to
> > add
> > any code to shut it down.
> >=20
> > Maybe I should edit the commit to explain that in a comment?
>=20
> Code comment please!
>=20
> That's basically the only chance we have to keep the knowledge why we
> did something the way we do it for the old HW generations around.
>=20
> Regards,
> Christian.

Hi Christian,

Sounds good. I will add a comment when I submit a next version of this
series.

>=20
> >=20
> > Thanks,
> > Timur

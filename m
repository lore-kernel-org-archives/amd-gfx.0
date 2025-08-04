Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DC4C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 16:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344E310E5AE;
	Mon,  4 Aug 2025 16:00:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XAEgUdad";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D35BF10E5AE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 16:00:44 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-459d44d286eso5895895e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754323243; x=1754928043; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W8yzmmKzpiubwpS9Fkb+g3BjPWivLvkuy50JRZSCY7I=;
 b=XAEgUdad/KFcTLwY34d1x1TPDFt74qnq5D9GjlZCIyGbU3qreiqmoQ7PkaE+ITJLO/
 +XKOSLB4K8tFU7rW/VdnnAs15e/8nUqe1oUClC/0q5MX4YZBozz2uPmhvZr3CxAV74de
 fF66Lfq5kEpu1bHs6aQjI0Eh26f4WvavLO38Ne6txnNnVX7mWZ/00NG3OiNR2+ckC/VE
 SPGLTRvHI4I8NVFbzUUy3i+6HV9p8SF5PQcqVO3ffZxIY0KUABWC3MAWiV+ywSaEfpwj
 o7JRtnyAHg3U77Qj65o9FG5Y9LCKyozHxK2gQosHImoLBtuR94/fNbVLLTlWVdXf7lVZ
 S72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323243; x=1754928043;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W8yzmmKzpiubwpS9Fkb+g3BjPWivLvkuy50JRZSCY7I=;
 b=rr4BX6czcyqdcZr5Vnp8QJUkFK9urrmGTsXags/H0PICIC6H9N3mM1PpCuDSJAZ1tT
 RMEvmJnBL4mQtVWziLQs1YifI68lxY+y2xMkGfwsvTY8yw86Jm/2Q5JicBR34tzsiBLh
 /mRBbJoPSkY2QaR/rNpkAutP/odltYgRs8G6HXyEv5HOpOWm9cwhANNGLxG5sZISa6fD
 pZXrb72gVPQtduYL2Rnah5SOuc7xWebKm2jpIprlvGzKUa6sEcWrOT3NPVB02LkQgbTD
 WUd5NH+HzNYaSd7r4VUqOXCyzCUE1xyoqlFc/2vDB+SpXYIl7BGWGBlvFi6W6zi17zwm
 p2XA==
X-Gm-Message-State: AOJu0YzW/vdDmGaP3Kvsk2LOSMnGWqioHPqoq0uWdSY02tI83jFvlUYh
 8ZeQdYhaDJDJXBdemX8Rsw/hgpHvcwakUkDRhGoEc14u7B+4N0UhDHz3
X-Gm-Gg: ASbGncvtMgFs9/98K+B6neMyLiCHIg9lYfy5chiQ5Nb8mF9jBBO4fN5LVS5AI5ZZcJl
 QDovprKK/LvZeo9n+V3XDjT/bQNttxui/jsv5+JsdP9FwddXLalg7XjARPSTJmPF8faIJht7Pcl
 +ZA/tci/y165fjjYEzn1d8lHmVkgpCLSQuk22bpYxZqz9auVTiCYezh9yO5u1mPnCh1nJMQOGzx
 d7UUZffZfsEspaPRRUaOUu6nYp02OAi86m+ln7acXdV89P/4qYC4wamW4JtuMd/pH2XlS34kpAG
 7nLzYWwbsom2aZB9fWs1DAOAHfEyn2mEEr3GwyNjHawFje+MRFujQUXTum2VeEMyIXKCdOwcyt2
 KWJREowrN6PEaHpNyzqoltAlr7QZMDCn6n8suhBdSTjHUmF/nsvfq8qgVj1C2HeSEdiJSMwvdcR
 hsV/vGWib2JK10MyB25Vs3PelPcfM+ltXMbyrsbfpYR/hetEKoDCFa0OL9k5DCqw==
X-Google-Smtp-Source: AGHT+IG78HWhnamFdzrH4ImCCAMPBjzojKGND1dcpcd1X8QGV0h7tDpvGvXMkFOQUokiLraU6AmHyQ==
X-Received: by 2002:a05:6000:2506:b0:3b6:5d0d:9826 with SMTP id
 ffacd0b85a97d-3b8ebed5295mr66882f8f.21.1754323242928; 
 Mon, 04 Aug 2025 09:00:42 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24da:bd00:a473:4c1d:2078:832b?
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45923c34af8sm70976645e9.24.2025.08.04.09.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:00:42 -0700 (PDT)
Message-ID: <aec0376f34db68c9e62d8ef5b8b5c51fe2eac5e2.camel@gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: Power up UVD 3 for FW validation
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>, Christian Koenig
 <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Date: Mon, 04 Aug 2025 18:00:41 +0200
In-Reply-To: <CADnq5_O5F5UAC17CE4mwOx_5pbTKzv73Yuj=-_cA06G3hQeQJQ@mail.gmail.com>
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-2-timur.kristof@gmail.com>
 <CADnq5_O5F5UAC17CE4mwOx_5pbTKzv73Yuj=-_cA06G3hQeQJQ@mail.gmail.com>
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

On Mon, 2025-08-04 at 11:20 -0400, Alex Deucher wrote:
> On Mon, Aug 4, 2025 at 9:58=E2=80=AFAM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > Unlike later versions, UVD 3 has firmware validation.
> > For this to work, the UVD should be powered up correctly.
> >=20
> > When DPM is enabled and the display clock is off,
> > the SMU may choose a power state which doesn't power
> > the UVD, which can result in failure to initialize UVD.
>=20
> + Christian, Leo
>=20
> That doesn't seem right to me.=C2=A0 IIRC, the driver always set the UVD
> PLL directly on SI and I don't think SI supported any kind of UVD
> power gating. I guess it's probably some sort of subtle sequencing
> difference between radeon and amdgpu.=C2=A0 Unless Christian or Leo have
> any ideas, I think the patch is probably fine.
>=20
> Alex

Hi,

These are my observations about how the UVD clock works on SI:

1. It seems that the SMC needs to know whether UVD is enabled or not,
and the UVD clocks are included as part of the power states. See:
si_convert_power_state_to_smc
si_convert_power_level_to_smc

On SI the default power state doesn't set the UVD clocks,
and SI has a specific power state to be used with UVD. Actually
amdgpu_dpm_enable_uvd has a special case code path for SI, where it
sets this power state. If I print the power states from
si_parse_power_table, it indeed confirms that there is only one power
state that has non-zero UVD clocks, and the rest of them just have the
UVD clocks at zero.

It's unclear to me what happens if we try to enable UVD clocks when we
selected a power state that doesn't include them (ie. when we don't
tell the SMC that UVD is active).

2. When setting a power state that enables UVD, the UVD clock is
enabled either before or after the engine clock by si_dpm. This is done
so in both radeon and amdgpu, see:
si_dpm_set_power_state
ni_set_uvd_clock_before_set_eng_clock
ni_set_uvd_clock_after_set_eng_clock

The specific sequence in which the UVD clock is enabled by
si_dpm_set_power_state leads me to the conclusion that
amdgpu_asic_set_uvd_clocks should not be directly called on SI outside
of the DPM code.

Please correct me if I misunderstood the code.

Thanks,
Timur


>=20
> >=20
> > Fixes: b38f3e80ecec ("drm amdgpu: SI UVD v3_1 (v2)")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 9 ++++++---
> > =C2=A01 file changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > index 5dbaebb592b3..9ad06c1e150d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> > @@ -633,6 +633,12 @@ static int uvd_v3_1_hw_init(struct
> > amdgpu_ip_block *ip_block)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int r;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_mc_resume(adev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_enable_mgcg(adev, true);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->pm.dpm_enabled)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 amdgpu_dpm_enable_uvd(adev, true);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D uvd_v3_1_fw_validate(a=
dev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r) {
> > @@ -640,9 +646,6 @@ static int uvd_v3_1_hw_init(struct
> > amdgpu_ip_block *ip_block)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return r;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_enable_mgcg(adev, true);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_asic_set_uvd_clocks(adev, =
53300, 40000);
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvd_v3_1_start(adev);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D amdgpu_ring_test_helpe=
r(ring);
> > --
> > 2.50.1
> >=20

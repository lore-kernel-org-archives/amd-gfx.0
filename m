Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C42CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A729410E1A7;
	Tue, 16 Jun 2026 12:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cW2Omw3Z";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F57F10E1A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 12:36:44 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso29425605e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781613403; x=1782218203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7coB9SVCzlKfWuUiPm3B/YiPKFZVYDid1aZwPdjE2oU=;
 b=cW2Omw3Z11K+Gjh5OFq4BubYG+oCxzD4l0wAN4dCz3wAlQqEX3rIDWqpS9Xq6mbIXB
 mxV8Db/1QuLOQmteHUYAk47ufjYRiITCrlB7wdoytaogVb2dtDX520if+n/u3chID0bD
 WKeeh1IPK3jFUROC+ySEpPnSjWJ6I+1eDwph/n/yL4iiKOtf6fIaLGgiD42iWv0baLuP
 PMZCyaStR8dhu2GLaq4lKykBdfxhaCSdN+bP2+9BuA7/HqEus9UQ6jcaYI1cUhcASFLx
 LQw62FE4nvPL9gj0rUUKVSlVxnYWMdDc95US7sGzcqfTsJTn7J8C4u+N0Gs2cSYYVRNQ
 VbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781613403; x=1782218203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7coB9SVCzlKfWuUiPm3B/YiPKFZVYDid1aZwPdjE2oU=;
 b=MiGs61WjLsWdzm0zyA2DQZ/YFyLxkwyMAtkS+WnM9DPtVuqS2vJqb8tWxRbTjXd7eO
 N7i2SsBEyt73mURtupdOJd/NQ4RhyGO0/WPE9yFmhbMISnpic8wAc0mwPdEy8ATNJ7ew
 RphPO0nP7+cQhkcY0g7qwhYHePDuooIWcNOcSBjFXDKUtUlH0Gn8d9mzw8r5LbEC2GQg
 IFCsK0TIj2t9OIZUuWPp1T3myGCm3w/Pyv6kewEEU5cziYxyhYan0R0axbWWN7s64eL7
 Ww4JZcSYEweQg7ER/XjSjuYwDxAPYRyvgDF10HrrXCuRmlYRJ7ASZB1YgrNOuRBTX1tz
 2jpg==
X-Gm-Message-State: AOJu0Ywlc0Lnrq3Yd7vgq72VuNLNQgX2JUCCQ9T6IiQeD1F/MGEzKfFV
 eedF8WFDd2k4X2ak2Gmlnhj9sSP3bbx6aVhyJMzAwa8Zgxbl8fHUGr7eJXklEQ==
X-Gm-Gg: Acq92OFXnPCu2/D4UWbuLMsGwZewdJlQ3VugA5deVd8fv5Tc1IenJq79xakqfBVBYLo
 fpx925q+Gt3yLTAn7SV2EIscPRAjwuNOdFhZF5vFECe01n1GRbU/arq82RIVH2VfsOEIF55Y9hs
 tNEoYuMbXkLwJSxtZhRZutXpTGxlExpbzNcd5CC6iRTBMYjudhILFNrt5OCYAEAQJ7JIeEwYaOV
 LFWt3p1uRnrB8Umg4BXphJ9Er9vGoLhTzIx+oSHXtI9osplSZDPNs9+VNajJgsgap5Jm1vwXD0C
 ULkzmw/iNVUuMRL9E0vEfVzjMD7aKPe6/2A6GJASqPmtI/anS3JIAjplG/3lkTHQrkGGfgQYC+F
 pv4ELqpxoY6s95TAXfGf+0xtv13fgf1O9pB5Ml1asT/4NFWGnLslKVMU6YGGM4Jze2l/HEa6Uxh
 UGR6Sgt3LP7TYzA36iZNvbkaPZ0vnJcJEc8dh/Y5c2D32Na884sscjXWIUIGb2c0VQGcFOtA==
X-Received: by 2002:a05:600c:83c3:b0:492:2f5b:7ed4 with SMTP id
 5b1f17b1804b1-4922ffc97f5mr49021125e9.36.1781613402957; 
 Tue, 16 Jun 2026 05:36:42 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a45b30sm55382835e9.2.2026.06.16.05.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 05:36:42 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 6/7] drm/amdgpu/gfxhub: Respect noretry flag for retry
 faults on GFX12.1
Date: Tue, 16 Jun 2026 14:36:41 +0200
Message-ID: <3036224.DJkKcVGEfx@timur-hyperion>
In-Reply-To: <4296af8f-8001-4a98-b942-3a2840296b7e@ursulin.net>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <4660473.UPlyArG6xL@timur-hyperion>
 <4296af8f-8001-4a98-b942-3a2840296b7e@ursulin.net>
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

On Tuesday, June 16, 2026 2:16:35=E2=80=AFPM Central European Summer Time T=
vrtko=20
Ursulin wrote:
> On 16/06/2026 12:57, Timur Krist=C3=B3f wrote:
> > On Tuesday, June 16, 2026 10:09:53=E2=80=AFAM Central European Summer T=
ime Tvrtko
> >=20
> > Ursulin wrote:
> >> On 25/05/2026 12:45, Timur Krist=C3=B3f wrote:
> >>> When retry faults are disabled (amdgpu.noretry=3D1),
> >>> the ENABLE_RETRY_FAULT_INTERRUPT bit should be programmed to 0.
> >>>=20
> >>> Note that retry faults are enabled by default on GFX12.1
> >>> so this just fixes the case when they are explicitly disabled.
> >>>=20
> >>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>> ---
> >>>=20
> >>>    drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> >>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c index
> >>> 4c2fd1e6616e..d2edfe037da8 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> >>> @@ -243,7 +243,7 @@ static void
> >>> gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *ade>
> >>>=20
> >>>    		tmp =3D REG_SET_FIELD(tmp,
> >=20
> > GCVM_L2_PROTECTION_FAULT_CNTL2,
> >=20
> >=20
> > ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> >=20
> >>>    		tmp =3D REG_SET_FIELD(tmp,
> >=20
> > GCVM_L2_PROTECTION_FAULT_CNTL2,
> >=20
> >>> -				    ENABLE_RETRY_FAULT_INTERRUPT,
> >=20
> > 0x1);
> >=20
> >>> +				    ENABLE_RETRY_FAULT_INTERRUPT,
> >=20
> > !adev->gmc.noretry);
> >=20
> >>>    		WREG32_SOC15(GC, GET_INST(GC, i),
> >>>    	=09
> >>>    			     regGCVM_L2_PROTECTION_FAULT_CNTL2,
> >=20
> > tmp);
> >=20
> >>>    	}
> >>=20
> >> If I look at 6f894c92490b ("drm/amdgpu: Enable retry faults for GFX
> >> 12.1") which added this code, it also touched
> >>=20
> >> gfxhub_v12_1_xcc_setup_vmid_config():
> >>       tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
> >>      =20
> >>                           RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> >>=20
> >> -                       !amdgpu_noretry);
> >> +                       1);
> >>=20
> >> Should that be changed as well?
> >=20
> > I personally don't have a GFX12.1 GPU so I have no way to verify how th=
at
> > works, which is why I try to avoid changing it unless it's pretty obvio=
us
> > that the upstream code is wrong.
> >=20
> > Can you elaborate on what you are suggesting exactly?
>=20
> I'm asking. :)
>=20
> commit 6f894c92490be1bb27492a82544b4b1e4ad20915
> Author: Mukul Joshi <mukul.joshi@amd.com>
> Date:   Wed Mar 26 22:06:39 2025 -0400
>=20
>      drm/amdgpu: Enable retry faults for GFX 12.1
>=20
> Made these three changes:
>=20
> gfxhub_v12_1_xcc_init_system_aperture_regs:
> +                       tmp =3D REG_SET_FIELD(tmp,
> GCVM_L2_PROTECTION_FAULT_CNTL2,
> +
> ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
>=20
>=20
> gfxhub_v12_1_xcc_setup_vmid_config:
> -                                           !amdgpu_noretry);
> +                                           1);
>=20
>=20
> mmhub_v4_2_0_mid_init_system_aperture_regs:
> +               tmp =3D REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
> +                                   ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
>=20
>=20
> The claim from that one was that it is enabling retry faults on gfx
> 12.1. If that is correct, and we look at your patch which wants respect
> the noretry modparam, but only changes one of those three.
>=20
> So question is are you confident it is only that one you need to change
> to make it respect the modparam? I don't know to be clear, those are
> just things I spot while reading you patch and the relevant history
> trying to familiarise myself with this area.

I think I see what you mean.
Indeed it would make sense to change the patch to use the gmc->noretry flag=
=20
there as well. Will add that to the next version.

Thanks,
Timur






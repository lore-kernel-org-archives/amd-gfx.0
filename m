Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B25CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 11:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 897E410EA8B;
	Tue, 16 Jun 2026 11:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RmgbmKGK";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF94010EA8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:57:36 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490b9318997so32213835e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 04:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781611055; x=1782215855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hG25+YkVhmGIa5zKTu9sjz+XLZJi78ZJD1a88jKsFSo=;
 b=RmgbmKGKihIux2zgGAfgIgNpmo9I2TaASxhj/QcpWY4Ejt6UEzCoODdey1e28/eayW
 q66qsuHUP3BKEM3kqtqnUXf3HCDgkPPdJka2FQ1efDv6QOV78Lh+e7jTys8YU3IvtKOV
 KgWTvNHVFeX8VV8Hvod8ObkTWPLjRySfi+Xsensskfcj/8vcXtU/g8ju6Rr1EHZu6xJW
 QPqb+mGCFautOSMuc6VjGYM7bEZpBhaY47xBgtkn0uha2exnR5SUxSVgxynqC6py0QR1
 hW4V2a5bOZyk/bWv6Cmjos4RJlnWNoAZlmGKZttnbpizeBP6ciiB/lPPXSrXk2ROvrYW
 vt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781611055; x=1782215855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hG25+YkVhmGIa5zKTu9sjz+XLZJi78ZJD1a88jKsFSo=;
 b=Sk64QpCRCLrz0+tbqbbqMgURjoO7o9H+5T6dmm3VtiOVFAzwNkx49gadQH57D2iMWO
 YF/uAYdZ7SBGSgy22moRb0D3AxGQPwsE3k2nhRcdb9RcGJEpwEEK/TutqXghwFH1AS/X
 NPRCEAAKLpbdjP3sQopdiIhJ+guS0roAp+JqEbzoi74wvN7PqqlI2EX/fm5BWqevv9Ho
 yEISJ1/K517EH0XwATXNQE/tCvHP7NFkvsTbcLwW97DHyzWzvcIfJsjfllh8Z0WIsR7J
 E6W7zjOK3F49//seuwPEyMVEg6VQcAm7+Wk68FLROH+8z0dhzXNq398lFzs0nSLodCRE
 elKg==
X-Gm-Message-State: AOJu0Yy72T+rit4LhXdYYZSfoKHvcoKJuNcwKXZkL3s/CgJSXp0ePW7t
 E6ZTI1TPqx8QqSrRaaSVoYePfci/sLDpYAD6Oav+iCEdmq/4qmSx8juCIBC7lw==
X-Gm-Gg: Acq92OFSXYqB0rPfKDup6MSISqztXlT62+Uabq8G1sBBnJQHjgLqWcJILJm7OK2/bQW
 N9sIzB3gLyMApAGLLpH2mSQmYqsqdroqQoq4pmPyRG73BGpADrKh+2KIAwtV9kSGmW4fm9LaT5n
 Pi1dRKnKCLgvrQVOIK3glQMkVv5XorJRsyNlfxIzsGjiHai7CI3aajzDjyr07syusvgSc60qSGO
 FfedIts2iqVTtVYuDC50HFGzn2IFVEodVHZLc2XN0QsLwdmSaq+RySVtV6tocce7Qt5qnC1Lb3n
 4I8F36X5Q2ocFIJawYz53H8rs/Lw8Ws+EeWO3FMOSJ9d81qHhsCzPk/gnGD+vZpxoraITVbdkJ4
 rmjZhyvseznh7RnfHkdCYDazZQEEP2+0LJRSlteGh/1rNO8FO/lX9RFCliLiwC7nn1HHlelrSZg
 pwk9oOUh6wehZVivXwuLTlmU0+521koWC27BI3kDB7L3L5hdbZrsvEdZbBZaWtIoKKIEEqAg==
X-Received: by 2002:a05:600c:1d04:b0:490:b58a:e6ff with SMTP id
 5b1f17b1804b1-4922011dfe2mr170172135e9.22.1781611055174; 
 Tue, 16 Jun 2026 04:57:35 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa890d8sm82651265e9.10.2026.06.16.04.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 04:57:34 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 6/7] drm/amdgpu/gfxhub: Respect noretry flag for retry
 faults on GFX12.1
Date: Tue, 16 Jun 2026 13:57:33 +0200
Message-ID: <4660473.UPlyArG6xL@timur-hyperion>
In-Reply-To: <25f69c76-8140-4573-8d3e-9aa8071ee715@ursulin.net>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <20260525114507.24566-7-timur.kristof@gmail.com>
 <25f69c76-8140-4573-8d3e-9aa8071ee715@ursulin.net>
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

On Tuesday, June 16, 2026 10:09:53=E2=80=AFAM Central European Summer Time =
Tvrtko=20
Ursulin wrote:
> On 25/05/2026 12:45, Timur Krist=C3=B3f wrote:
> > When retry faults are disabled (amdgpu.noretry=3D1),
> > the ENABLE_RETRY_FAULT_INTERRUPT bit should be programmed to 0.
> >=20
> > Note that retry faults are enabled by default on GFX12.1
> > so this just fixes the case when they are explicitly disabled.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c index
> > 4c2fd1e6616e..d2edfe037da8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> > @@ -243,7 +243,7 @@ static void
> > gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *ade>=20
> >   		tmp =3D REG_SET_FIELD(tmp,=20
GCVM_L2_PROTECTION_FAULT_CNTL2,
> >   	=09
> >   				   =20
ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> >   	=09
> >   		tmp =3D REG_SET_FIELD(tmp,=20
GCVM_L2_PROTECTION_FAULT_CNTL2,
> >=20
> > -				    ENABLE_RETRY_FAULT_INTERRUPT,=20
0x1);
> > +				    ENABLE_RETRY_FAULT_INTERRUPT,=20
!adev->gmc.noretry);
> >=20
> >   		WREG32_SOC15(GC, GET_INST(GC, i),
> >   	=09
> >   			     regGCVM_L2_PROTECTION_FAULT_CNTL2,=20
tmp);
> >   =09
> >   	}
>=20
> If I look at 6f894c92490b ("drm/amdgpu: Enable retry faults for GFX
> 12.1") which added this code, it also touched
> gfxhub_v12_1_xcc_setup_vmid_config():
>=20
>      tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
>                          RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -                       !amdgpu_noretry);
> +                       1);
>=20
> Should that be changed as well?
>=20

I personally don't have a GFX12.1 GPU so I have no way to verify how that=20
works, which is why I try to avoid changing it unless it's pretty obvious t=
hat=20
the upstream code is wrong.

Can you elaborate on what you are suggesting exactly?

Thanks,
Timur



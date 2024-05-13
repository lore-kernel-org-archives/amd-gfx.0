Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAAAC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 14:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E33B710E278;
	Mon, 13 May 2024 14:33:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N6qcuSvZ";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F1310E6C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 14:33:00 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-61bbb208ea5so3151198a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715610779; x=1716215579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POLZI6E+O8+MOBAalFE2DyvFkWgkDXHmq+6WiPwPmow=;
 b=N6qcuSvZP35M8YnVFgnlWQ22OoVokSRWCaBL4g3c2qRX+WDosH17A6jwOfHDc5yGZU
 CU2lp6gnaFlFXQPW7SfWvDykfL0fQpjAMHApem+7GnV+8uSnuZbMGoR4F3VqKEtpQ2CU
 TjPpPDF5iQr6mHmFYhezQZYrwoWH3lb7prImbn+nT3rCSTYACzwwmwg+aKajRmfRJQxD
 5riQjeP3TUghFKH/T3wekBcyBFDdqcLOOS7iBSwkfsae52quQbsb29ysq/S4CNzP+XZP
 0OjmAA7BTWrqhAUPNL/yJIDHk2Z/0Ptf8Ju08Kl5b7M+1anlSTE4gPP8EFbCiv5lQSra
 VaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715610779; x=1716215579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=POLZI6E+O8+MOBAalFE2DyvFkWgkDXHmq+6WiPwPmow=;
 b=cKZeGrGAN5oo3+mSpO7Ml6heWpYuMlGkJg6HADvrqa3RftVvl0UW5CQKpd4QCqSNqi
 1JPS3qOTn02uSGIHXX+FhINX+Ed8AsqdcdC98Yhi1uuf1vWKztvrzL9pREqb3s56Xvdy
 eUcI2n5VMNzjzZ1geSwSyJnFWbWOYehHHlUqtnkgl5dtG6a5/IPckPNUy8x9gtHITCmB
 1IaBtNoM6GHUJMlw9bjH3+S1VToMXaycvIDYbJeKW0KO+PoGzsfcWGe+poGCojqyQu0w
 kc6pZFIBgmAeFodwCg4+0bv/Hb8jEvx0pai1Br3BeuFq74/tWLDqQ4TaQo9TCWOCUcDi
 +b6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM6qK07bjVuXcsKoMlTtgE2X27xSwX4r7cr+SxRiEavdDjdu/K/V2cBhsPChBXJiV6qR0cyQAXKkSWvDqVZ715pCmMgUWc42syulehCw==
X-Gm-Message-State: AOJu0Yxrgg7XsRH05yUsbNvphhVqfQ8Je+hCL86Bohb/+NY8ywckZ9WO
 e7dez9IdjsHqexbdmEXEezv2XRcBVH2YtkeWmS0zs8shj0Hxu/ycpSl0R5Zgp1Gd+zmCCOxpJ+X
 gj0hq7JFxqDGIM3nuRG99K0f37nN7rg==
X-Google-Smtp-Source: AGHT+IE7aDy4zJdHcUmWHemU44VPH1ca1xxNBRTSWX/wvlV+0HG4K0HF2vFdc7r+h/pxDwXUQf9EWaBghCJ9Rk3nJYY=
X-Received: by 2002:a17:90a:ea86:b0:2b2:9b67:198a with SMTP id
 98e67ed59e1d1-2b6ccd6ccebmr8429259a91.34.1715610779513; Mon, 13 May 2024
 07:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240513083929.91933-1-Frank.Min@amd.com>
 <SA1PR12MB56592211FB21D663BFE2F7C5E9E22@SA1PR12MB5659.namprd12.prod.outlook.com>
 <DM4PR12MB5181AAF5D6B02927220B7679EFE22@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5181AAF5D6B02927220B7679EFE22@DM4PR12MB5181.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 May 2024 10:32:48 -0400
Message-ID: <CADnq5_NqSfg0FTLBzAuqdfiOD90YE=ei7WDGY0AGesf1zpL7fA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add initial value for gfx12 AGP aperture
To: "Gao, Likun" <Likun.Gao@amd.com>
Cc: "Min, Frank" <Frank.Min@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, May 13, 2024 at 5:37=E2=80=AFAM Gao, Likun <Likun.Gao@amd.com> wrot=
e:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> This patch was
> Reviewed-by: Likun Gao <Likun.Gao@amd.com>.
>
> Regards,
> Likun
>
> -----Original Message-----
> From: Min, Frank <Frank.Min@amd.com>
> Sent: Monday, May 13, 2024 4:56 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun=
 <Likun.Gao@amd.com>
> Subject: [PATCH] drm/amdgpu: add initial value for gfx12 AGP aperture
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> From: Frank Min <Frank.Min@amd.com>
>
> add initial value for gfx12 AGP aperture
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index 34264a33dcdf..b876300bb9f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -622,6 +622,7 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu=
_device *adev,
>
>         base =3D adev->mmhub.funcs->get_fb_location(adev);
>
> +       amdgpu_gmc_set_agp_default(adev, mc);
>         amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>         amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
>         if (!amdgpu_sriov_vf(adev) && (amdgpu_agp =3D=3D 1))
> --
> 2.34.1
>
>

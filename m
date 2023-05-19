Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78333C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 19:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1973B10E00E;
	Fri, 19 May 2023 19:00:31 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EF710E00E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 19:00:28 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-199bcf78252so2702983fac.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684522828; x=1687114828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqZ0hjhr9qk4gz1MOJ0QT4/j1DJUwc7Hkz00nNcTvr4=;
 b=LkXC/dGus1Yhit5wCwM44qMcvf+kD6iRFF9IX3SiJO4uhLoyTChApdA8Bo2NVITpYI
 by6H1YfTwyjAA5Yn4cxqpZSuYSCUDLd45NgbR84XK8NLKy78qdn7KAg7lvqukKytYMj9
 0Exbzm0iAXjyjj6lB38mNN3tskXu60erHwYl7pvodFDem6550ubDU9JvFsXMZVOgLG62
 /a948NsOhv1UGgPnJHZ9DaYk5mY5/2Vi9ikABA/RERsSsjR98Vbk7mbe8NuyZ4R7Y0VF
 2SXoml7FXMLU47f+xmpNJiP+UuZRahpa+5HC8TdhbaFzWy+jeBVplktr94FbFMulWZMW
 OMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684522828; x=1687114828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqZ0hjhr9qk4gz1MOJ0QT4/j1DJUwc7Hkz00nNcTvr4=;
 b=FLRQRaj2Ss4Ehs5M3/Nh6qJiXYi8Rj3HzskkSIkBOkrbXM4Q28H03GWJ0quoAL7+mx
 dKI6i+mxAAbkbbYnfetNeKewEuoixzzaq+uK2/03A8mDRP3EBiqF6VDSU4aM8QcP8F1W
 /xW+wL7wo4VYwSyU3rGkiAr58cusIPqF0hx1yUNCKs7sK24gLkyPaKQqxAcQpOoSUED3
 3BOvn9T32JqPOqqoYJyukdfnOig0sjcgZGcMAsaDExydcq9tmh0PLUw9oUnx00LqKTe1
 Bv9YId+HKidXYxj4cpgwEzP2FQI4wPEfLCbmhSDlwGEtza4X2rtN3yD1dFRv/J0o0VBT
 479g==
X-Gm-Message-State: AC+VfDxZz0xBwPYlvleAR6QLB7g+kVqm3mlyNadxqvd9SQ6+cSvT9Jbj
 0cfdFsiKo53vHlqjINsHOJfpPcLtGFe3KbPg2nEUTRVe
X-Google-Smtp-Source: ACHHUZ4Qk/vszSNqmVluobanJB+7G2hpomcELNoFHpmN3IFrBf0eNbzrxqW+RP09HiSNXy8qF7RYb8tYKd/mz7nZlzk=
X-Received: by 2002:a05:6870:32c7:b0:199:c7a2:bdea with SMTP id
 r7-20020a05687032c700b00199c7a2bdeamr1823616oac.14.1684522827845; Fri, 19 May
 2023 12:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221114231325.18698-1-jntesteves@gmail.com>
In-Reply-To: <20221114231325.18698-1-jntesteves@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 May 2023 15:00:16 -0400
Message-ID: <CADnq5_PT09_d+_awYFPV-ZwGDaOb0KETYq3J+UJjvRq5jtsa7g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix output of pp_od_clk_voltage
To: Jonatas Esteves <jntesteves@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 14, 2022 at 8:57=E2=80=AFPM Jonatas Esteves <jntesteves@gmail.c=
om> wrote:
>
> Printing the other clock types should not be conditioned on being able
> to print OD_SCLK. Some GPUs currently have limited capability of only
> printing a subset of these.
>
> Since this condition was introduced in v5.18-rc1, reading from
> `pp_od_clk_voltage` has been returning empty on the Asus ROG Strix G15
> (2021).
>
> Fixes: 79c65f3fcbb1 ("drm/amd/pm: do not expose power implementation deta=
ils to amdgpu_pm.c")

Can you provide your signed-off-by?  Once I get that I can apply the
patch.  Thanks.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 236657eece47..9d364bbc78e1 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -869,13 +869,11 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct =
device *dev,
>         }
>         if (ret =3D=3D -ENOENT) {
>                 size =3D amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf=
);
> -               if (size > 0) {
> -                       size +=3D amdgpu_dpm_print_clock_levels(adev, OD_=
MCLK, buf + size);
> -                       size +=3D amdgpu_dpm_print_clock_levels(adev, OD_=
VDDC_CURVE, buf + size);
> -                       size +=3D amdgpu_dpm_print_clock_levels(adev, OD_=
VDDGFX_OFFSET, buf + size);
> -                       size +=3D amdgpu_dpm_print_clock_levels(adev, OD_=
RANGE, buf + size);
> -                       size +=3D amdgpu_dpm_print_clock_levels(adev, OD_=
CCLK, buf + size);
> -               }
> +               size +=3D amdgpu_dpm_print_clock_levels(adev, OD_MCLK, bu=
f + size);
> +               size +=3D amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CUR=
VE, buf + size);
> +               size +=3D amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_O=
FFSET, buf + size);
> +               size +=3D amdgpu_dpm_print_clock_levels(adev, OD_RANGE, b=
uf + size);
> +               size +=3D amdgpu_dpm_print_clock_levels(adev, OD_CCLK, bu=
f + size);
>         }
>
>         if (size =3D=3D 0)
> --
> 2.30.2
>

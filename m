Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455F9C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 14:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54FD10E036;
	Mon, 22 May 2023 14:57:04 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA2610E036
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 14:57:02 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6af873d1d8bso183090a34.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684767421; x=1687359421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0PCjGWVeQYtK4cFjUGUH6AhhnD0uh+f8Aq4aegfQxE=;
 b=GgLSH+2jGJ3mxnH2pZ+5k64jvXIB7NjfIbT1PO3AhAolLyT+/9IsoVxSU3Oc2uNYJc
 KEw20q3YD1s/Yv6gD6ufadiXieqTVTaIcCGdruMP1iI908n1oumnq4gex1hYNvY4jKgU
 lDFyu9q161VyHEe12o1F8WHKOgEqHw+Ip5FfB0hyXhhMWGoCTCzbAOk19jtdgSR/TH4m
 cWd52AsNGMdFaY4O5P80yBThTYPo/cWVEY1YRqFwqZKZ7ZUBiB9yF6AIsIQoGf3hxO83
 mXZ/qq9UsMCuGFHgunZo+mGxxQNW8LAJ3oX8f5nRmuIgAfO+74pHpwLmEq0YJCdEMUta
 EABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684767421; x=1687359421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0PCjGWVeQYtK4cFjUGUH6AhhnD0uh+f8Aq4aegfQxE=;
 b=JluQ2Mz2aR5OOMwBAC83d14/sYD7VI01FYzE8SiQbEGbsOsxoqD8vu9DhodJmWdq9K
 tjmvCIbPndYV3VPsUEZbq1FdoNS97zGAbt6GauiwcgFyJV1gTIhlkCv+D45YIyDZGc74
 GSctzEbI/vhyzVPjFXGh2kXIdQSXDSqM3CQtseNWGstah3XYlHmBc+Y/zn8KTDJZRylN
 TIQ6o9mbBsO3Iv6IVmqGYdBlmpg/WWFWcvaZOLCLlpO2oO4YI7MbUU2+WN6jHvn39fLh
 ihvl+o9OO7wCozCS+ZFa3+2iXKZze2EQHXSUuo2vMsHzDRItSGwq980m8rfR/luxUG2P
 /RkQ==
X-Gm-Message-State: AC+VfDwBVT+ZeoGTxHbGl8GkcjhqouvzCiCDbtveOYiCPtwpfpDv/jJc
 Uyqk2+fkJd6I8Zxe8Jon4lgRVlwdBBB1Lc8DU97a32KX
X-Google-Smtp-Source: ACHHUZ7+5pKMkgYGPD2lh58NIKg4KwFiTzPGqit+RuQgZC0bAyBYEj18rhJMqWZBZZvCm5+JOchkVa/gYg4PQmInqQE=
X-Received: by 2002:aca:1207:0:b0:394:3d96:8cf3 with SMTP id
 7-20020aca1207000000b003943d968cf3mr5529193ois.25.1684767421119; Mon, 22 May
 2023 07:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230520133951.172823-1-jntesteves@gmail.com>
In-Reply-To: <20230520133951.172823-1-jntesteves@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 May 2023 10:56:50 -0400
Message-ID: <CADnq5_PkHnWbEzmELGvO5zgzf_-2auFMx-+D3VFnc1QrrKB=QA@mail.gmail.com>
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

Applied.  Thanks!

On Mon, May 22, 2023 at 3:20=E2=80=AFAM Jonatas Esteves <jntesteves@gmail.c=
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
> Signed-off-by: Jonatas Esteves <jntesteves@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 58c2246918fd..f4f40459f22b 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -871,13 +871,11 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct =
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
> 2.40.1
>

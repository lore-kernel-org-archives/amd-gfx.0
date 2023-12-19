Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEF2C41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 17:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A2610E4F6;
	Tue, 19 Dec 2023 17:04:32 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86AF110E4F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 17:04:30 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1fb33059466so3199524fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 09:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703005469; x=1703610269; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3spGZBDe0Pi/VYD6DNIE9qFDQo4F4dfi8lDByABGa2o=;
 b=Vqbly8mRe/Ej7UIYWNVAAUQgAe93phHQu4vryc7PA9fk4RSTVfXRxSLdHYNm1yzjLJ
 xceZH7xiL144tu67GAqZpq8pqL4BAi5dqjrTI58PEByzCr85srbBQEBqYCIAaIH5vOxB
 i1ibbkVnOgK+3iSgFxd4ADbR8rBNClL1WTidRXxAg1L/bRi2ZPHONk0SG1zmSA0laBKH
 skT4ZbAyFZidLOu/Vy1GKpeIvdT4tWEWi3a/WslTmXmHwQNunSwMYpUCms2vSWAFcT+g
 YDBKEVKgesfjJMgTzHtFNhmmn4NZSOqwKZi2DpcB7rsTCf/c1VqZCyN4Tpv6wU2mMsdu
 yaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703005469; x=1703610269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3spGZBDe0Pi/VYD6DNIE9qFDQo4F4dfi8lDByABGa2o=;
 b=PlrEjpjs0f110gbg+FHqfAP6WQOd/+YNN8xXnRa14pXH5DhQJLxE0o5iqdk+/0gxs+
 j0+ogCCpVgGhlWQlgKXpI/NVdWNGDA2zszXfPj+gf4gzAwC6kDcZPlrc8eSmg4v/2itL
 2kKjTauTxW0KUtIeX1gukfIB2LvcJe3CF74O0K+oicNYQgfmHFg79YadWoaDTaG726Cu
 B23tV/RoZmU8PHubLFYRhKjYPZC1FczX1mlyVguboOD6x+HBFkK6wC8+/6RaDF6PAXoh
 aaBm4hK6VenshCOYQ6y0eCkz+OEnr+9DhL2wEGLr9PK9JRB9hP3sCb5oMeqeiifbwUkW
 EA6w==
X-Gm-Message-State: AOJu0YwCkD/8hZwL45X5yXQfMA+9Fxn8x2fSxHB2OqL8b2CC1KHXnZeW
 BnOYn36iKBguxWUleKUxFhpnNOA4mxJZ6laLgfJLnmvH
X-Google-Smtp-Source: AGHT+IEu4TGtErG3iW9wLsuxcz0Rf6tgZbPRb27H6CblwshegXbW4WK6xq/EJT1UxLdgW7M10OTHY1fI1M3dBMWaSO4=
X-Received: by 2002:a05:6870:b48d:b0:203:f9c5:7dda with SMTP id
 y13-20020a056870b48d00b00203f9c57ddamr612796oap.75.1703005469697; Tue, 19 Dec
 2023 09:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20231219092340.1601929-1-Jack.Xiao@amd.com>
In-Reply-To: <20231219092340.1601929-1-Jack.Xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Dec 2023 12:04:18 -0500
Message-ID: <CADnq5_NAzBZj+SXc7iY5ZWUgxGCmt3A+PsVRRx59YWx4=toXYg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET
To: Jack Xiao <Jack.Xiao@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 19, 2023 at 4:30=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wrote=
:
>
> It's required to take the gfx mutex before access to CP_VMID_RESET,
> for there is a race condition with CP firmware to write the register.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index bdcf96df69e6..ae3370d34d11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4518,6 +4518,22 @@ static int gfx_v11_0_soft_reset(void *handle)
>                 }
>         }
>

We probably want a CPU mutex or spinlock to protect this as well
unless this is already protected by the reset lock.

Alex

> +       /* Try to require the gfx mutex before access to CP_VMID_RESET */
> +       for (i =3D 0; i < adev->usec_timeout; i++) {
> +               /* Request with MeId=3D2, PipeId=3D0 */
> +               tmp =3D REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, 1);
> +               tmp =3D REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, CLIENTID, =
4);
> +               WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
> +               if (RREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX) =3D=3D tmp=
)
> +                       break;
> +               udelay(1);
> +       }
> +
> +       if (i >=3D adev->usec_timeout) {
> +               printk("Failed to require the gfx mutex during soft reset=
\n");
> +               return -EINVAL;
> +       }
> +
>         WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0xfffffffe);
>
>         // Read CP_VMID_RESET register three times.
> @@ -4526,6 +4542,10 @@ static int gfx_v11_0_soft_reset(void *handle)
>         RREG32_SOC15(GC, 0, regCP_VMID_RESET);
>         RREG32_SOC15(GC, 0, regCP_VMID_RESET);
>
> +       /* release the gfx mutex */
> +       tmp =3D REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, REQUEST, 0);
> +       WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
> +
>         for (i =3D 0; i < adev->usec_timeout; i++) {
>                 if (!RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) &&
>                     !RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE))
> --
> 2.41.0
>

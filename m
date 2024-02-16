Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8036BC48260
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 15:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA4710EB79;
	Fri, 16 Feb 2024 15:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nzyef3lh";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBCF10EB79
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 15:29:20 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-6e1126f57f1so1268172b3a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 07:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708097359; x=1708702159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/GEgZ29d7oBrcavN6liecbGV0+c7MuCE/7u7hwgjAw=;
 b=Nzyef3lhczKYWyJWX8cDPqHNqgXsEvgsZPJjL6zdnj8ym15OvACjDIF7Au9uSVgvwv
 mRkmBQLhHR6LluEEIWXBvJt4hqbTd9Wx/9M/rpv3U3MOhM+ZtaiHF9WjlnFEP2pKADIr
 XKJ97L6dpXoDgFX3awAMUn2CWOeTeamXtY+ml5O57MOOocnNfvUl1A/IYMoVBVXWgth0
 nF8t4cUJF8ic28bZQ42VFeob4R77sNYUYRxYyOU3hO0tFr/+MzRlBGyvvMEyApgFJUBZ
 i4R2Sx5TFP6q+P8Gd/3NOctgJACC8RTOb8KWLUbNMJDrvMVF+5Q9ns/ngsLQC7XW78sr
 dVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708097359; x=1708702159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/GEgZ29d7oBrcavN6liecbGV0+c7MuCE/7u7hwgjAw=;
 b=bZbVCcNZHPnnHOLLGlsjVUZkT3W9NU4dBHqj51uGGN1EUwxO3JrEmDDyyVFK1u0JTS
 v5BqkVBk2K7onbLFIG8HYEA6/NpE0j+Ui6vv4j1ZDvwIyhF+b5Cr7izLHvuf9IPB3L+v
 4S3lor3U2AbRUTgIqg1RvCa1kImoWOPvCXuQFw7K/Q8DhluXaVid9+tbJDZzP11bbh+E
 e/nlsht5W9fTDhq6as23Z/E2T/9rrMkKhKcmZ333Od9NulK21NVqWahBTqrH7AHJXAKu
 GZ+Rx54sbLv+rG07xdtUzzkJhXzoo8v+PE1uf3aiRP3pJhPqLd2O1ufG4DHaxg1sOr/B
 Hihg==
X-Gm-Message-State: AOJu0YzsgyXSPi6DMHm8mFMrOilO51S2n6sNAu6qBPWWeXhmA3fSVqRx
 Fwe1IlGKEWJc6myV/5LjOjuOZb3lINT1PCwZC1Ul05asBoga7jy28CcylPNZ7j0/qgE/KWcGioe
 ivHxhMT5FT4WiBRGAWoQG7oOklTI=
X-Google-Smtp-Source: AGHT+IH+4Xj+3QtFUd7Wyv/956DX0B9gwNGC99rskBOzHcUQaGUBP7KCtbWOlWnO2J64vd4yVrzYW0+HKFp0XN6B6cY=
X-Received: by 2002:a17:90a:a090:b0:299:275d:c346 with SMTP id
 r16-20020a17090aa09000b00299275dc346mr4174606pjp.5.1708097359424; Fri, 16 Feb
 2024 07:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20240213223418.11733-1-victorchengchi.lu@amd.com>
In-Reply-To: <20240213223418.11733-1-victorchengchi.lu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Feb 2024 10:29:07 -0500
Message-ID: <CADnq5_PRCtJcFsuOG+ttEsQ3VVZ6UPcfsDbfkyCDe=4nOYqMZg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Do not program IH_CHICKEN in vega20_ih.c
 under SRIOV
To: Victor Lu <victorchengchi.lu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, samir.dhume@amd.com
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

On Tue, Feb 13, 2024 at 5:43=E2=80=AFPM Victor Lu <victorchengchi.lu@amd.co=
m> wrote:
>
> IH_CHICKEN is blocked for VF writes; this access should be skipped.
>
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 38 ++++++++++++++------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd=
/amdgpu/vega20_ih.c
> index db66e6cccaf2..b9e785846637 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -291,27 +291,29 @@ static int vega20_ih_irq_init(struct amdgpu_device =
*adev)
>
>         adev->nbio.funcs->ih_control(adev);
>
> -       if ((amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4,=
 2, 1)) &&
> -           adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
> -               ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
> -               if (adev->irq.ih.use_bus_addr) {
> -                       ih_chicken =3D REG_SET_FIELD(ih_chicken, IH_CHICK=
EN,
> -                                                  MC_SPACE_GPA_ENABLE, 1=
);
> +       if (!amdgpu_sriov_vf(adev)) {
> +               if ((amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VE=
RSION(4, 2, 1)) &&
> +                   adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT=
) {
> +                       ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICK=
EN);
> +                       if (adev->irq.ih.use_bus_addr) {
> +                               ih_chicken =3D REG_SET_FIELD(ih_chicken, =
IH_CHICKEN,
> +                                                          MC_SPACE_GPA_E=
NABLE, 1);
> +                       }
> +                       WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken)=
;
>                 }
> -               WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
> -       }
>
> -       /* psp firmware won't program IH_CHICKEN for aldebaran
> -        * driver needs to program it properly according to
> -        * MC_SPACE type in IH_RB_CNTL */
> -       if ((amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4,=
 4, 0)) ||
> -           (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4,=
 4, 2))) {
> -               ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEB=
ARAN);
> -               if (adev->irq.ih.use_bus_addr) {
> -                       ih_chicken =3D REG_SET_FIELD(ih_chicken, IH_CHICK=
EN,
> -                                                  MC_SPACE_GPA_ENABLE, 1=
);
> +               /* psp firmware won't program IH_CHICKEN for aldebaran
> +                * driver needs to program it properly according to
> +                * MC_SPACE type in IH_RB_CNTL */
> +               if ((amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VE=
RSION(4, 4, 0)) ||
> +                   (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VE=
RSION(4, 4, 2))) {
> +                       ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICK=
EN_ALDEBARAN);
> +                       if (adev->irq.ih.use_bus_addr) {
> +                               ih_chicken =3D REG_SET_FIELD(ih_chicken, =
IH_CHICKEN,
> +                                                          MC_SPACE_GPA_E=
NABLE, 1);
> +                       }
> +                       WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEBARAN, i=
h_chicken);
>                 }
> -               WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEBARAN, ih_chicke=
n);
>         }
>
>         for (i =3D 0; i < ARRAY_SIZE(ih); i++) {
> --
> 2.34.1
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28580C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC48D89361;
	Thu, 25 Jul 2024 18:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mw9bvwNy";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E852589361
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:22:26 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-7a130ae7126so136258a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721931746; x=1722536546; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgQY9Vh9MRSgjI4kL7/a3FJNoKSfw9GI/hEj7/knbXo=;
 b=Mw9bvwNyuW1iQ8IRLOUYKXWU6c43raKqq5fMzZuWKZazCdJMT0HT4V+Of8iDTYjk3P
 Uz+qpCzR5wcYy93/jrL7EHPxwg5+iuR02tZp/5L8p4gbStrY3nOeZagMz0XqAkbecpYW
 Al7CO+NyHwckuxF+/cpCxM8952nQWOF3cN4UI0PwBGNicWZTiKhSEj1oARUO45dbygVU
 BhgwZglHPPWjtKMSznv6uUjTyA3ab15FDyQRpwpMJ9iUHjH+VF6fDmQuRnzi1BPSadKb
 uvs5FuJxHrQlbIqDiB9EPBqRuBRXQWKCJkBpxmonoaDSbumseThh5S+Rlx7RtA7Z9LZH
 YwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721931746; x=1722536546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgQY9Vh9MRSgjI4kL7/a3FJNoKSfw9GI/hEj7/knbXo=;
 b=jo0Nl3nylmvVVCrEcMRihaYRa60HeQKQW2YmzGP/VWfOHcYdC118ItiFobOjB3eHCb
 E6nbL1A96/19VgMBIGjFUilfofc8Gt838LaMD+gLE35lbm6plZtzhtOUV7s68CuLnZ+c
 xtPe+bcN7qBtVMLOuexBYNKmp1FzQeOP2SADN8om/LQlushDIAsVRbTdslM7zHc+aYqu
 Ct1HbZ9E0dy1uiBDh+e06fWogZ37ATGtWadvNBXKm3XuHRsJA9By1UDckprCq5kDmdVo
 75mDFRxGIla6EiVjRWcvGleadHefDJKoahlLdluTgSfhoQxzamasdb7NApN9IVs9Exn3
 QtOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0fECSDENi3zscXMfcY57kJII4ishMJKf4kPdspUAI/uHAi+xlOwf3yxEtSnD+01o386H34Qngs812bDpHN2+VQWbO0pm1A81ffDeRqg==
X-Gm-Message-State: AOJu0YxoaSg401cx9ZAzOBFo1eXmMbCQ41+FgiGxyIJWpX/UuOeiseez
 dzo3Qg41G8RRNvKc/d2NiM4SGCKuFbziQIrxfJ3hz+RlSrhU/GNo/zH+G2MH/r6rvyHp7hC3y2Q
 0UFkc7mCvuENaMvt+T6aZhiHgiGakkA==
X-Google-Smtp-Source: AGHT+IGjD/7XgH0JTKcO91I0B5RZKwmjoixxS6MkRfHm+Q/CjJBNnWNPQmxw06Voks9X3YCtQp30D9ea2zXKfRKBfe8=
X-Received: by 2002:a17:90b:38cc:b0:2c9:93a3:1db6 with SMTP id
 98e67ed59e1d1-2cf2e9f7b36mr2833873a91.11.1721931746246; Thu, 25 Jul 2024
 11:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240725064107.2921431-1-sunil.khatri@amd.com>
 <20240725064107.2921431-4-sunil.khatri@amd.com>
In-Reply-To: <20240725064107.2921431-4-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jul 2024 14:22:14 -0400
Message-ID: <CADnq5_Mkwb-KsXsGR11YVa2Wsr=H5a9paAcwnCxoKWwG6ypp6g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amdgpu: add print support for vcn_v3_0 ip dump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jul 25, 2024 at 2:41=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add support for logging the registers in devcoredump
> buffer for vcn_v3_0.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 28 ++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index d0bca93f8226..9e1cbeee10db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -2324,6 +2324,32 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_d=
evice *adev)
>         }
>  }
>
> +static void vcn_v3_0_print_ip_state(void *handle, struct drm_printer *p)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       int i, j;
> +       uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_3_0);
> +       uint32_t inst_off;
> +
> +       if (!adev->vcn.ip_dump)
> +               return;
> +
> +       drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (adev->vcn.harvest_config & (1 << i)) {
> +                       drm_printf(p, "\nHarvested Instance:VCN%d Skippin=
g dump\n", i);
> +                       continue;
> +               }
> +
> +               inst_off =3D i * reg_count;
> +               drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +
> +               for (j =3D 0; j < reg_count; j++)
> +                       drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_3=
_0[j].reg_name,
> +                                  adev->vcn.ip_dump[inst_off + j]);
> +       }
> +}
> +
>  static void vcn_v3_0_dump_ip_state(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -2369,7 +2395,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs =
=3D {
>         .set_clockgating_state =3D vcn_v3_0_set_clockgating_state,
>         .set_powergating_state =3D vcn_v3_0_set_powergating_state,
>         .dump_ip_state =3D vcn_v3_0_dump_ip_state,
> -       .print_ip_state =3D NULL,
> +       .print_ip_state =3D vcn_v3_0_print_ip_state,
>  };
>
>  const struct amdgpu_ip_block_version vcn_v3_0_ip_block =3D {
> --
> 2.34.1
>

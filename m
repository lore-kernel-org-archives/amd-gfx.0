Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2E5C3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 13:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE3210E976;
	Fri, 26 Jul 2024 13:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dgs9+6tD";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5618410E322
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 13:12:41 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-70ea93aa9bdso791512b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721999561; x=1722604361; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWdhHrjfEXt0UgAC92lgDSrRu872moy1LyoywJm1bac=;
 b=dgs9+6tDJbA9/AZS4Lads63Nh6+R85x9MaXSCcClW4A42es3LYqYuaWy2mzwgGEQDv
 TrK6DK2T8XHsa/n7mscxI7jwNUMk/b52B1RkczC2SOVOUXrtFu58KRtXUet1Xt498yEj
 OCpqWb6XO4GV4Hu8jCGfaHpTc7ogzc5VnLNpu53h+2JupCBIaj7oS4sjg85IVxbIVdTX
 054ZwSJ8pND+QNOE6RJKVkz1bA8FPHGjXduBOaHhCEgrDOs/csksAsvH3oMwtQfd4kM5
 dOqIL0SXDWxbPUTTLo08yddLkb1hK+2a8nSTBCm6phTzNkECocv5RYa9hpVevRnbLqN7
 MBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721999561; x=1722604361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWdhHrjfEXt0UgAC92lgDSrRu872moy1LyoywJm1bac=;
 b=fe9tKcLTIZY897M2uN1VFnU+oSadFyjUY7ddxe0sQ20lp/wdEiOr59bOm113Y2hn13
 OZS7qlRvHqv5hBZjQgvz66J+Do7ELWvxBBzYN0Xc0dtSEkPN2dCRbRzjXx6SOQvXxWt6
 dk9xk6SQa6IXrxzH3CnNVTE9yzBz0TORK1f2171fksbVmjeGmrpnGA8pYfz4kz/IH30c
 8lbo5cickQaX0NuLPWUllXpB15xNFZ3p+OC6Vry+z3DXC7JOCI/AIQBod89h2u9UI2JA
 0VGDO+x/tdkcHHe2YSpoCDE2Io9bi01mw/a0qHvDt7RPU2bMtoZ05Iae96ocEfZRAVUI
 iTjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURiHsJMyO5uNaU3SUdB781RhD0KR3cBLE+/C2L5b6NuhhrRo0BF5MaJHaUjJRQzAKPHx4oi94qvzRdoLYGoFSeTdCa/pG21HN4jsUr4A==
X-Gm-Message-State: AOJu0Yx3Ev3WOPo91XIYArZIYmFvIvetHPJfGhRQ6zCBHBKumvLsBHad
 Sxy3ENjy79sAQGxgliamQGHU6v2t1Y7XCnFngocB/b4m/ffuZf/ENeRWKMy8IiDA3mLOORL4NLk
 W3UpDDZFxmWUfy0sJC+PktDxN9iE=
X-Google-Smtp-Source: AGHT+IHYIlBsuaPOubjOlgmKXka3rk9qcOoNtyRB4F+i+yYmOe2Mvm3DQ5ewZXmGd2X9t4gXuxKM9zO/+R2UyR+m6uU=
X-Received: by 2002:a05:6a20:914b:b0:1c0:f2a5:c8dc with SMTP id
 adf61e73a8af0-1c472c5b4a5mr7623089637.50.1721999560793; Fri, 26 Jul 2024
 06:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
In-Reply-To: <20240726124751.3121312-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jul 2024 09:12:29 -0400
Message-ID: <CADnq5_O1N3rNqewdUkwf+7qGoGP3qECNgZ7cGNhgeddmEsqZ9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: print VCN instance dump for valid instance
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

On Fri, Jul 26, 2024 at 8:48=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> VCN dump is dependent on power state of the ip. Dump is
> valid if VCN was powered up at the time of ip dump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 28 +++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 9e1cbeee10db..c2278cc49dd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -2329,7 +2329,7 @@ static void vcn_v3_0_print_ip_state(void *handle, s=
truct drm_printer *p)
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         int i, j;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_3_0);
> -       uint32_t inst_off;
> +       uint32_t inst_off, is_powered;
>
>         if (!adev->vcn.ip_dump)
>                 return;
> @@ -2342,11 +2342,17 @@ static void vcn_v3_0_print_ip_state(void *handle,=
 struct drm_printer *p)
>                 }
>
>                 inst_off =3D i * reg_count;
> -               drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +               is_powered =3D (adev->vcn.ip_dump[inst_off] &
> +                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) =
!=3D 1;
>
> -               for (j =3D 0; j < reg_count; j++)
> -                       drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_3=
_0[j].reg_name,
> -                                  adev->vcn.ip_dump[inst_off + j]);
> +               if (is_powered) {
> +                       drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +                       for (j =3D 0; j < reg_count; j++)
> +                               drm_printf(p, "%-50s \t 0x%08x\n", vcn_re=
g_list_3_0[j].reg_name,
> +                                          adev->vcn.ip_dump[inst_off + j=
]);
> +               } else {
> +                       drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> +               }
>         }
>  }
>
> @@ -2354,7 +2360,7 @@ static void vcn_v3_0_dump_ip_state(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         int i, j;
> -       bool reg_safe;
> +       bool is_powered;
>         uint32_t inst_off;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_3_0);
>
> @@ -2366,11 +2372,13 @@ static void vcn_v3_0_dump_ip_state(void *handle)
>                         continue;
>
>                 inst_off =3D i * reg_count;
> -               reg_safe =3D (RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS) &
> -                           UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) !=3D=
 1;
> +               /* mmUVD_POWER_STATUS is always readable and is first ele=
ment of the array */
> +               adev->vcn.ip_dump[inst_off] =3D RREG32_SOC15(VCN, i, mmUV=
D_POWER_STATUS);
> +               is_powered =3D (adev->vcn.ip_dump[inst_off] &
> +                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) =
!=3D 1;
>
> -               if (reg_safe)
> -                       for (j =3D 0; j < reg_count; j++)
> +               if (is_powered)
> +                       for (j =3D 1; j < reg_count; j++)
>                                 adev->vcn.ip_dump[inst_off + j] =3D
>                                         RREG32(SOC15_REG_ENTRY_OFFSET_INS=
T(vcn_reg_list_3_0[j], i));
>         }
> --
> 2.34.1
>

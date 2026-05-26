Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B9DCD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 15:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3F510E500;
	Tue, 26 May 2026 15:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EdTsNip1";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7079110E4C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 15:00:50 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f6e6a0a215so912784eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 08:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807649; cv=none;
 d=google.com; s=arc-20240605;
 b=NnvYt8NERBasCnge1049MHmhcoQNb7wOqS/0E5LV70VZbqbnLG4AVvFyq3jRd/sPpA
 /PgpHubffSLim2FlQE9CndBV9e7mLzYDA2i6EPmKi8HSFFqnXkHfWp471XhpshcUSgL8
 C0blr7L+EcchraREzjU1GNDkjD5P2DxNFa3U7Mu5ZdRSHodDQc+HuNo8zrMUlYL4e7AS
 1KIp8KYesB8u1kPB0RhdocNI9HzkPLT2HMVcFNHP8UtwIqWSLEdOmC4lLgk9HXjj4qSJ
 FXh9JhsMdbKJGt2vZ8fHKHcu3sLKsK5SJoyqFE2r0Iw9riHNh27QZiXOdAgTOEOmphOp
 QEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M8BbtBh6h4IHFGJllYcSg9753hpPnuHPx+gjzgBQ574=;
 fh=6Tba4fIK037g9vkqh80dQgnOfOxlO//gA31YD0wQbk4=;
 b=AeqKjpoMvPMmklf4FLgALCyOW2fs5vuh+1rdiSSjfXrsWVHm8YoOrNm3eeGquMRbyh
 OFfzDxKUG1rKb6CBccehy7FQrAYMEiPnXHNQCjJpjc9FbSzX/rER8h7zPhqhSyJxiDi/
 bM504Rbi0nuIWH3gpmqBHwlrPRy0+gvNugXNVJQY7KiV0QiUSGdGpf0FdsQfOUkYQytN
 jm5fPWKGLRcEnO7px1QjIsujzyZVtNkMMrDlK9AuGnJ6udKWeGO3FFXXiIWVQJ3Ankw6
 /3wpwpN9ujRMtvpB+SJFMEN18YrFMEEB8lqYJJC9XLE0vLzq6MJYCZ9eNrmO8SAUN09k
 7xWA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779807649; x=1780412449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8BbtBh6h4IHFGJllYcSg9753hpPnuHPx+gjzgBQ574=;
 b=EdTsNip1ZSgmF0Ab+9tlg1G26CJzUHnjVkxdLAhofqdJQjhrZiWTaCt27HymH/W7LA
 NRFyeiaF4jxxONw9/8wLrgvz3ZMxtm2vsFrpPHWfACVNGENC5UbXryxN5J9LiRkUM/kR
 4qD1N2GFyklMHb7T3FaJKgT+t/GR5r3GO9L8cGgls7tzKTs3y6E5fc/8j8SGhlsp/GBJ
 0/b3FYHQs6DSdP6K8ut2R/eBmK8K08Xi3Tlw7v6nWQ6JL8I8tntJiECREXLNhAyMUhW/
 8KGNKdueItyNgOxNzlubT3EGpeSRCmk82f+hFxvrVHDIOTbtafbXKQxiqrPW3R3IJpfK
 QLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807649; x=1780412449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M8BbtBh6h4IHFGJllYcSg9753hpPnuHPx+gjzgBQ574=;
 b=aFOjQxni3GmhIa9nlyXaXeVdtLah58B8CdaSouBYeHufRh3JJg7hZVNr70IJmG/UEJ
 tgc4HnuVb17vYAyDBLEn2lUqlXimxWtiNdgTBelby+CFhDIqkdvFtW9G0yhjl8esjEim
 rpkxmtRjD274n8TjKM9wkJJAXWlRJX387ucwAhTwwlSPFE1fhq8MHDrNrJuGcUMgvAPS
 tGNKZlxDn/iO8/lWmH9PrIn4VzTDE0nlYakHbLvC0FgEsb+PuMcvQETYde65alFlxewE
 taTjhR4S24Tr5k85VdS73pU41IXTmXYLxS/ronk6AniOC/AHcaYa+ZC2DNAyzaidHASt
 8AXw==
X-Gm-Message-State: AOJu0YwqvNcEMh1MYgdlJ0ANof3f+S5xYBzXJBwzc+uNBdw4OBhA/vdg
 4F2fw5Li0QSJCwc7hmRE6fRORbDB1cwNwxxX0v4qYwHfFmSqCBbq0g3Y1vj21t00qGOsUdPB5Yb
 FlUDQJxx+8ur0akEb0Rsxp6a7U6XJbVg=
X-Gm-Gg: Acq92OEzvL9/FewJHgnVIobTenwjjkbJsvfTkGkd/pW0CkRo0AVlhto1iMEDH0I//Mw
 eIcjXAYhRjqCVn5VwN45+HSybPook4bmlhOXalVCC6BL1IX5WogN4RQpZEXi/ylipTeV1bBXKzu
 JCTxJiDXpJRvlUpFRFxhnJyf5D2pJWpn4WsLBjrJMXt5WdXymy9Or6pTNloVkQXi5gmIcPYQCrR
 /MeGtkefym/owQ7LBOp1y9COouC5QtNd/Fu5zYrCaaBH2bmH5DKEkPXct3awvRTMqdk/waIqhCs
 mpFsLlADLBKUdCWkLbWEPOWCbPRlNNkAxqkgUWr+GBIIzgAvkF3kmg4jnLR4H2X5LogaeXz+RvA
 tCnSf
X-Received: by 2002:a05:7300:8c05:b0:2d1:9b35:4f03 with SMTP id
 5a478bee46e88-304491af095mr4320694eec.5.1779807649007; Tue, 26 May 2026
 08:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <20260525114507.24566-3-timur.kristof@gmail.com>
In-Reply-To: <20260525114507.24566-3-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 11:00:37 -0400
X-Gm-Features: AVHnY4JUpedUTBfv8aGHoJWhbBjATVhMAu2aCas4mNIAPT3sS2-D9mhfvStBnTc
Message-ID: <CADnq5_NzaHitLofeB7=K1wdAUspgVx=UdU8Ce7W3_44bN5GNVA@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0
 as needed
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
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

Applied patches 1 and 2.

Alex

On Mon, May 25, 2026 at 8:04=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> When the fault stop mode isn't AMDGPU_VM_FAULT_STOP_ALWAYS,
> these bits should be programmed to 0.
>
> Program CRASH_ON_NO_RETRY_FAULT and CRASH_ON_RETRY_FAULT
> always, to make sure to clear the bits when we don't want
> to crash.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 14 ++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 10 ++++------
>  9 files changed, 38 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/dr=
m/amd/amdgpu/gfxhub_v11_5_0.c
> index f845ba698b40..652eea6eae4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -449,12 +449,10 @@ static void gfxhub_v11_5_0_set_fault_enable_default=
(struct amdgpu_device *adev,
>                             WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value)=
;
>         tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>                             EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, valu=
e);
> -       if (!value) {
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_NO_RETRY_FAULT, 1);
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_RETRY_FAULT, 1);
> -       }
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_NO_RETRY_FAULT, !value);
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_RETRY_FAULT, !value);
>         WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfxhub_v12_0.c
> index ba78b5a1a7cd..6cbf837d50dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> @@ -454,12 +454,10 @@ static void gfxhub_v12_0_set_fault_enable_default(s=
truct amdgpu_device *adev,
>                             WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value)=
;
>         tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>                             EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, valu=
e);
> -       if (!value) {
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_NO_RETRY_FAULT, 1);
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_RETRY_FAULT, 1);
> -       }
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_NO_RETRY_FAULT, !value);
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_RETRY_FAULT, !value);
>         WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/=
amd/amdgpu/gfxhub_v12_1.c
> index 3544eb42dca6..4c2fd1e6616e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -633,19 +633,17 @@ static void gfxhub_v12_1_xcc_set_fault_enable_defau=
lt(struct amdgpu_device *adev
>                 tmp =3D REG_SET_FIELD(tmp,
>                                     GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
>                                     OTHER_CLIENT_ID_NO_RETRY_FAULT_INTERR=
UPT, value);
> -               if (!value)
> -                       tmp =3D REG_SET_FIELD(tmp,
> -                                           GCVM_L2_PROTECTION_FAULT_CNTL=
_LO32,
> -                                           CRASH_ON_NO_RETRY_FAULT, 1);
> +               tmp =3D REG_SET_FIELD(tmp,
> +                                   GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
> +                                   CRASH_ON_NO_RETRY_FAULT, !value);
>                 WREG32_SOC15(GC, GET_INST(GC, i),
>                              regGCVM_L2_PROTECTION_FAULT_CNTL_LO32, tmp);
>
>                 tmp =3D RREG32_SOC15(GC, GET_INST(GC, i),
>                                    regGCVM_L2_PROTECTION_FAULT_CNTL_HI32)=
;
> -               if (!value)
> -                       tmp =3D REG_SET_FIELD(tmp,
> -                                           GCVM_L2_PROTECTION_FAULT_CNTL=
_HI32,
> -                                           CRASH_ON_RETRY_FAULT, 1);
> +               tmp =3D REG_SET_FIELD(tmp,
> +                                   GCVM_L2_PROTECTION_FAULT_CNTL_HI32,
> +                                   CRASH_ON_RETRY_FAULT, !value);
>                 WREG32_SOC15(GC, GET_INST(GC, i),
>                              regGCVM_L2_PROTECTION_FAULT_CNTL_HI32, tmp);
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v1_0.c
> index a7bfc9f41d0e..bfe247b1a333 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -403,12 +403,10 @@ static void gfxhub_v1_0_set_fault_enable_default(st=
ruct amdgpu_device *adev,
>                         WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
>         tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
>                         EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> -       if (!value) {
> -               tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_NO_RETRY_FAULT, 1);
> -               tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_RETRY_FAULT, 1);
> -       }
> +       tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> +                       CRASH_ON_NO_RETRY_FAULT, !value);
> +       tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> +                       CRASH_ON_RETRY_FAULT, !value);
>         WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v1_2.c
> index 6c03bf9f1ae8..fbdf46070b38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -516,12 +516,10 @@ static void gfxhub_v1_2_xcc_set_fault_enable_defaul=
t(struct amdgpu_device *adev,
>                                 WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, va=
lue);
>                 tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
>                                 EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, =
value);
> -               if (!value) {
> -                       tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT=
_CNTL,
> -                                       CRASH_ON_NO_RETRY_FAULT, 1);
> -                       tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT=
_CNTL,
> -                                       CRASH_ON_RETRY_FAULT, 1);
> -               }
> +               tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> +                               CRASH_ON_NO_RETRY_FAULT, !value);
> +               tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> +                               CRASH_ON_RETRY_FAULT, !value);
>                 WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAU=
LT_CNTL, tmp);
>         }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v2_0.c
> index 793faf62cb07..9ea593e2c719 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -418,12 +418,10 @@ static void gfxhub_v2_0_set_fault_enable_default(st=
ruct amdgpu_device *adev,
>                             WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value)=
;
>         tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>                             EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, valu=
e);
> -       if (!value) {
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_NO_RETRY_FAULT, 1);
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_RETRY_FAULT, 1);
> -       }
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_NO_RETRY_FAULT, !value);
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_RETRY_FAULT, !value);
>         WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v2_1.c
> index aceb8447feac..30b90d35abd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -449,12 +449,10 @@ static void gfxhub_v2_1_set_fault_enable_default(st=
ruct amdgpu_device *adev,
>                             WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value)=
;
>         tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>                             EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, valu=
e);
> -       if (!value) {
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_NO_RETRY_FAULT, 1);
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_RETRY_FAULT, 1);
> -       }
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_NO_RETRY_FAULT, !value);
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_RETRY_FAULT, !value);
>         WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v3_0.c
> index 631f99e3741a..9e6a6e13dec0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -446,12 +446,10 @@ static void gfxhub_v3_0_set_fault_enable_default(st=
ruct amdgpu_device *adev,
>                             WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value)=
;
>         tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>                             EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, valu=
e);
> -       if (!value) {
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_NO_RETRY_FAULT, 1);
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_RETRY_FAULT, 1);
> -       }
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_NO_RETRY_FAULT, !value);
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_RETRY_FAULT, !value);
>         WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm=
/amd/amdgpu/gfxhub_v3_0_3.c
> index 8a87410ce016..b3b1085c7cd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -434,12 +434,10 @@ static void gfxhub_v3_0_3_set_fault_enable_default(=
struct amdgpu_device *adev,
>                             WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value)=
;
>         tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>                             EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, valu=
e);
> -       if (!value) {
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_NO_RETRY_FAULT, 1);
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -                               CRASH_ON_RETRY_FAULT, 1);
> -       }
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_NO_RETRY_FAULT, !value);
> +       tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +                           CRASH_ON_RETRY_FAULT, !value);
>         WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  }
>
> --
> 2.54.0
>

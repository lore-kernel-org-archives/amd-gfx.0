Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A7BC001DE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 13:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB3E10E141;
	Tue, 25 Jul 2023 13:18:11 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA22E10E141
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 13:18:09 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a44fae863fso3726236b6e.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690291089; x=1690895889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1uOlcNRKdzqiQ0LWl5KhTDJe25j9vBO9jHRbjxtiYw=;
 b=dGKJGuDJ7p5c0UmVTAXcN2XEEYeRF1jOsBaM4QuNP0Ra2smWVzmhf2TvuaXhd3hC93
 NInCosHIFsBDzFcc0WyAReuaEIeCUUFAUzPEwxR4lClL2F6aKU5miG4lbDFOifdMejcr
 GpzycLNvzSgZQxRu09+OvKzlAJOertnT0Ns4CLDXRSQpV0N+iAgQpa7wrSMiNB+1gjJd
 GNWWWbU+CK9npmo9P9mnGpDXpA2Ih6IYlhxqjjknrPJakTzmDB7ycJVSJ21CEsJUZOT2
 VfEHiusz80tvvW9Z2uOfh5CuKQOCZ7FBngULrekKo5s4+rwN9va2Ndh/no1R3lOK7kSi
 YfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690291089; x=1690895889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1uOlcNRKdzqiQ0LWl5KhTDJe25j9vBO9jHRbjxtiYw=;
 b=IPLy/u/3eaVs5a6BPr7IZhR1dupVJUP0FEJepr8NOALqdbsSZ8/BvmhET0LDLAVIT9
 Ej8wP42bDHGcarVaS8L6yzariX7TrujJvzdSvFmuo0FCcw0kDsDVxY7yd+3hWUTP5q/a
 qhMDM4psEQplEi8hS7nkBYoUyHv6t2UQ2TxKm2A5alnpXQipzaYR/8PQF4CivuT0yEs9
 55P18Sr0t8NEZXk5DQi7EBhvzdI78cgH02qQlTRJyuPTPq/xgW98HY1b/CLahBXfmXQz
 mv2gmcSyLXaiSHmwAoEqDJqLwZqiZQxg1XdvhYiYof8ufpXHf/KPxFQgYO7mt4El+x35
 0g2A==
X-Gm-Message-State: ABy/qLZYrfgEMWNQww1l9qLKevbVvYAH38bHmYZEASB4VtF7TsFvFe6/
 JGE2p35kpQDA4F1oapXucFmysOB3swEoXCsJQ1qTg6wDk+M=
X-Google-Smtp-Source: APBJJlE/eM0DXsrC2PljTNHTnFDj+jTcNCcd6JFeypIjYVtgSELLjCkxvs1DK7zcarYd8DI3M26hCr0gNIoYsGaUiIk=
X-Received: by 2002:a05:6808:3029:b0:3a3:64a3:b5a1 with SMTP id
 ay41-20020a056808302900b003a364a3b5a1mr13025004oib.7.1690291089020; Tue, 25
 Jul 2023 06:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230725120413.2285840-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230725120413.2285840-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jul 2023 09:17:58 -0400
Message-ID: <CADnq5_MJ00PWdH+eXkuwh+TdtQ6=OKW=+r_Xanb4mxCT3ibuBA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix no new typedefs for enum
 _AMDGPU_DOORBELL_*
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jul 25, 2023 at 8:04=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following:
>
> WARNING: do not add new typedefs
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 27 ++++++++++----------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_doorbell.h
> index 5ce29426ef11..0e593cfeb570 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -90,8 +90,7 @@ struct amdgpu_doorbell_index {
>         uint32_t xcc_doorbell_range;
>  };
>
> -typedef enum _AMDGPU_DOORBELL_ASSIGNMENT
> -{
> +enum AMDGPU_DOORBELL_ASSIGNMENT {
>         AMDGPU_DOORBELL_KIQ                     =3D 0x000,
>         AMDGPU_DOORBELL_HIQ                     =3D 0x001,
>         AMDGPU_DOORBELL_DIQ                     =3D 0x002,
> @@ -109,10 +108,10 @@ typedef enum _AMDGPU_DOORBELL_ASSIGNMENT
>         AMDGPU_DOORBELL_IH                      =3D 0x1E8,
>         AMDGPU_DOORBELL_MAX_ASSIGNMENT          =3D 0x3FF,
>         AMDGPU_DOORBELL_INVALID                 =3D 0xFFFF
> -} AMDGPU_DOORBELL_ASSIGNMENT;
> +};
> +
> +enum AMDGPU_VEGA20_DOORBELL_ASSIGNMENT {
>
> -typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT
> -{
>         /* Compute + GFX: 0~255 */
>         AMDGPU_VEGA20_DOORBELL_KIQ                     =3D 0x000,
>         AMDGPU_VEGA20_DOORBELL_HIQ                     =3D 0x001,
> @@ -176,10 +175,10 @@ typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT
>
>         AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT            =3D 0x1F7,
>         AMDGPU_VEGA20_DOORBELL_INVALID                   =3D 0xFFFF
> -} AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;
> +};
> +
> +enum AMDGPU_NAVI10_DOORBELL_ASSIGNMENT {
>
> -typedef enum _AMDGPU_NAVI10_DOORBELL_ASSIGNMENT
> -{
>         /* Compute + GFX: 0~255 */
>         AMDGPU_NAVI10_DOORBELL_KIQ                      =3D 0x000,
>         AMDGPU_NAVI10_DOORBELL_HIQ                      =3D 0x001,
> @@ -227,13 +226,12 @@ typedef enum _AMDGPU_NAVI10_DOORBELL_ASSIGNMENT
>
>         AMDGPU_NAVI10_DOORBELL_MAX_ASSIGNMENT           =3D 0x18F,
>         AMDGPU_NAVI10_DOORBELL_INVALID                  =3D 0xFFFF
> -} AMDGPU_NAVI10_DOORBELL_ASSIGNMENT;
> +};
>
>  /*
>   * 64bit doorbell, offset are in QWORD, occupy 2KB doorbell space
>   */
> -typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT
> -{
> +enum AMDGPU_DOORBELL64_ASSIGNMENT {
>         /*
>          * All compute related doorbells: kiq, hiq, diq, traditional comp=
ute queue, user queue, should locate in
>          * a continues range so that programming CP_MEC_DOORBELL_RANGE_LO=
WER/UPPER can cover this range.
> @@ -309,9 +307,10 @@ typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT
>
>         AMDGPU_DOORBELL64_MAX_ASSIGNMENT          =3D 0xFF,
>         AMDGPU_DOORBELL64_INVALID                 =3D 0xFFFF
> -} AMDGPU_DOORBELL64_ASSIGNMENT;
> +};
> +
> +enum AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1 {
>
> -typedef enum _AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1 {
>         /* XCC0: 0x00 ~20, XCC1: 20 ~ 2F ... */
>
>         /* KIQ/HIQ/DIQ */
> @@ -339,7 +338,7 @@ typedef enum _AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1 {
>
>         AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          =3D 0x1D4,
>         AMDGPU_DOORBELL_LAYOUT1_INVALID                 =3D 0xFFFF
> -} AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1;
> +};
>
>  u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index);
>  void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
> --
> 2.25.1
>

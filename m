Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3423DC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1BDE10E2CD;
	Wed,  3 Jan 2024 14:42:35 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AC510E2CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:42:33 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-20451ecbb80so5293559fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 06:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704292953; x=1704897753; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZ0XLcc5XnGXqdz5F686TqzQkpvw6okEgJ8b9ecMux4=;
 b=TeM5r5JU+S9824hTY/RbSBYO+lnuBKk4txZVmRqJsc4TaAOIUHHHmsEW+mRdr9K/by
 exJU+YzKlw5VrhJg7mKlYUFnZhbEHgXyeF9ib0QLJSIklERfP/IkWp+W9X4x0otXKWd5
 sRjyxCJZtQL8qOWtbKbCqk2X/v+w4FG37lmweyESiUuwXmJZvNOuFfPII1Z/QS0gCj5Q
 PKF6tCqi3jYcmuYeq1R/oZjaLaBLr3B+vjcBwu82ySJ2Xzge/ivJHDP8WPuF3UM1cl35
 h1F6apAT1eCtpuqPsvZmr75AcWqXPrZBGdeMFNrUXdGjQ+6x+4LMy2dj6kuzWbC02AYf
 KukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292953; x=1704897753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZ0XLcc5XnGXqdz5F686TqzQkpvw6okEgJ8b9ecMux4=;
 b=Winwud6A81uMb4HcySwImUqJJ+XB4CbU4hWxqOeKO8u/YqhlN7VirfmYSAAdG050wK
 jNBlnqVA+D7U4BtlCjIxg+DaHk1KFG2ZZ6OGQoOQNgNpREX3WpnkbipppAFolIOWDTco
 YTiRoYB4JQa/j8d931CjmLHwjEq4JjCafo6rgawtOKKj6YHkrZYCmlkt6QuNnLMRi+o+
 F8ehZggxbytub0R6xDSsTtlV0umwjM0NtwrRSGDH9CULF0kfrkyqVk7B9Q+fJqYi+H/e
 afGjScPLLgZiEFJ0P/1/6myb1J4Qkc499K33lpmL/wXueSn6wXKNVIEnphoKqUjUYtfT
 fYOA==
X-Gm-Message-State: AOJu0YwsoWFlpsmCf8VlnkjTHjXkMVJFn1jDEAl8oCPl5OUeR1MxWoBl
 EfbWUoNAT4vXgvaDtGv9hwuCmFXrXabFYN/Dl+U=
X-Google-Smtp-Source: AGHT+IGOzMVbbxzoV97x30p/NivsuwMn4UnyejNMcdA3iZyE+cYEwvP/4W6HC+01U6hn8aBdmyQTngpg1ifzzU26OE8=
X-Received: by 2002:a05:6870:7010:b0:1fa:f81d:2402 with SMTP id
 u16-20020a056870701000b001faf81d2402mr18418427oae.12.1704292953240; Wed, 03
 Jan 2024 06:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20231221204151.98967-1-harry.wentland@amd.com>
 <20231221204151.98967-2-harry.wentland@amd.com>
In-Reply-To: <20231221204151.98967-2-harry.wentland@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:42:22 -0500
Message-ID: <CADnq5_NjmpHNj60rbmWKBdadAaWz-iqVoQPSr8B_OAuxdROEHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Move fixpt_from_s3132 to amdgpu_dm
To: Harry Wentland <harry.wentland@amd.com>
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

On Thu, Dec 21, 2023 at 3:50=E2=80=AFPM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
> Other environments don't like the unary minus operator on
> an unsigned value.
>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_color.c    | 18 +++++++++++++++---
>  .../gpu/drm/amd/display/include/fixed31_32.h   | 12 ------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 36bf65a8cd6e..9b527bffe11a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -85,6 +85,18 @@ void amdgpu_dm_init_color_mod(void)
>         setup_x_points_distribution();
>  }
>
> +static inline struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
> +{
> +       struct fixed31_32 val;
> +
> +       /* If negative, convert to 2's complement. */
> +       if (x & (1ULL << 63))
> +               x =3D -(x & ~(1ULL << 63));
> +
> +       val.value =3D x;
> +       return val;
> +}
> +
>  #ifdef AMD_PRIVATE_COLOR
>  /* Pre-defined Transfer Functions (TF)
>   *
> @@ -430,7 +442,7 @@ static void __drm_ctm_to_dc_matrix(const struct drm_c=
olor_ctm *ctm,
>                 }
>
>                 /* gamut_remap_matrix[i] =3D ctm[i - floor(i/4)] */
> -               matrix[i] =3D dc_fixpt_from_s3132(ctm->matrix[i - (i / 4)=
]);
> +               matrix[i] =3D amdgpu_dm_fixpt_from_s3132(ctm->matrix[i - =
(i / 4)]);
>         }
>  }
>
> @@ -452,7 +464,7 @@ static void __drm_ctm_3x4_to_dc_matrix(const struct d=
rm_color_ctm_3x4 *ctm,
>          */
>         for (i =3D 0; i < 12; i++) {
>                 /* gamut_remap_matrix[i] =3D ctm[i - floor(i/4)] */
> -               matrix[i] =3D dc_fixpt_from_s3132(ctm->matrix[i]);
> +               matrix[i] =3D amdgpu_dm_fixpt_from_s3132(ctm->matrix[i]);
>         }
>  }
>
> @@ -1136,7 +1148,7 @@ amdgpu_dm_plane_set_color_properties(struct drm_pla=
ne_state *plane_state,
>         uint32_t shaper_size, lut3d_size, blend_size;
>         int ret;
>
> -       dc_plane_state->hdr_mult =3D dc_fixpt_from_s3132(dm_plane_state->=
hdr_mult);
> +       dc_plane_state->hdr_mult =3D amdgpu_dm_fixpt_from_s3132(dm_plane_=
state->hdr_mult);
>
>         shaper_lut =3D __extract_blob_lut(dm_plane_state->shaper_lut, &sh=
aper_size);
>         shaper_size =3D shaper_lut !=3D NULL ? shaper_size : 0;
> diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/g=
pu/drm/amd/display/include/fixed31_32.h
> index 84da1dd34efd..d4cf7ead1d87 100644
> --- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
> +++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
> @@ -69,18 +69,6 @@ static const struct fixed31_32 dc_fixpt_epsilon =3D { =
1LL };
>  static const struct fixed31_32 dc_fixpt_half =3D { 0x80000000LL };
>  static const struct fixed31_32 dc_fixpt_one =3D { 0x100000000LL };
>
> -static inline struct fixed31_32 dc_fixpt_from_s3132(__u64 x)
> -{
> -       struct fixed31_32 val;
> -
> -       /* If negative, convert to 2's complement. */
> -       if (x & (1ULL << 63))
> -               x =3D -(x & ~(1ULL << 63));
> -
> -       val.value =3D x;
> -       return val;
> -}
> -
>  /*
>   * @brief
>   * Initialization routines
> --
> 2.43.0
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0635C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 14:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A1910E330;
	Wed, 30 Apr 2025 14:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nIQMEgIP";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B30FD10E330
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 14:29:46 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff62f9b6e4so891174a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746023386; x=1746628186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ut+6UCHt+MA+z+KIGehMgcSk+Kt1wIvxxrRvYc8zTKQ=;
 b=nIQMEgIP2GREQZe59Zt8ru8JjG6UDYp2ucFWbvs4TuQ/f+SBPGJVMZR2ZrJYFeTiB7
 wj/cgH/oAagfB3xF4eCrbmeE1/GCs5u7j6HDImMdOkDuFtx1CM5n1ncs/j38DYzgJb9w
 K1YmT0sLpdq2QOA2UO1LvpU34QxsxvNgieFzAKPKnmF5v9FcDl6N+sOZxTG8LLdEkWjJ
 d1rRmY707xvQB33tNUa2QDtTYyc/uroMt8arE1cKVTtnRuaioMvKL6YpelvSezeqXGMv
 Q3CwpP9wvAdZBxlHpioHeadxc1gVo4//yhWpBjjhtYTrpCA4M4yrAswqT/SvlV6+9A0Z
 a0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023386; x=1746628186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ut+6UCHt+MA+z+KIGehMgcSk+Kt1wIvxxrRvYc8zTKQ=;
 b=AsWcYjTpEy3271PX/P3IKY4KbpCL0f55uUR8Dj1tSe3ArnGbfEyPMswMIxSTwe0WKl
 ilwhRVxRhMFskloHpTNWnrVdrtRPfHOBQo4/xEhV08pNKsWMKQfLH1zCLm48avI4XLIV
 2eIWO7gfo4xz4kx8VCKAceSO7kLXIAUfOk/w4znOvrzbnGAnLR5U2HwqIPeXbt+kpedG
 XjTIAEIJyTmdtWe7s3exom8Lcio2S633Q4uZnFiWHNNDwGsmUUgQUqFIqj6qT8L5y3WM
 gNdNtaPISIt/lir+Wu8JsH9eSCmLjMuqkQbq3mYbEO0oFmwTjHvNz5Jtiu92od+0LnQr
 1j4Q==
X-Gm-Message-State: AOJu0Yyzcr0dUv60sHOmM9Ks5XTsDLe2gTdm+9IZImuUPIvdAA5UdAkV
 9ImIb86I6UcAqulMsLBKa3O5X9uMGevEB1NM9dCIfOUAYYWRog+dksFok685OAaa9NZaixf2N0R
 W8vBvMBszUMFPcPsSa2Wbx6zRtfM=
X-Gm-Gg: ASbGncsemYrRDC9rIWctaafffD4OKyG1O+dBoMEn6H8+sOKSFDVvpYQ2E18lWTFEH0y
 KoFAo27OIAtvYJbucaKaMBprtCgD31Co1HIVXFmrt5dRpcJwKuHCj+j4Kv8q01dodosOu5eS2QJ
 P6VgGuuxfnxb/4P+YyQGNiMIf95Tc3Sw/F
X-Google-Smtp-Source: AGHT+IHzXaGkwLqvJJ4ye6p2IunqpDnUDWx7oh2DkljW3Kbmlg/IkzQL/klAfPyNTGe6+hOXQPS36KfspZU+E+v/o70=
X-Received: by 2002:a17:90b:1648:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-30a349d354amr1554700a91.1.1746023386159; Wed, 30 Apr 2025
 07:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250430040512.307765-1-ganglxie@amd.com>
In-Reply-To: <20250430040512.307765-1-ganglxie@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 10:29:33 -0400
X-Gm-Features: ATxdqUG6xe7JlNV4SalqF4m5awDX2am7J6leh0jHojx7CxTJcUerWF-IHHBzflM
Message-ID: <CADnq5_OOoTsgbTLeeQKucpneBttS9bvmBZHC0JNdmgWnne4Lgw@mail.gmail.com>
Subject: Re: [PATCH] Refine RAS bad page records counting and parsing in
 eeprom V3
To: ganglxie <ganglxie@amd.com>
Cc: amd-gfx@lists.freedesktop.org, tao.zhou1@amd.com
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

On Wed, Apr 30, 2025 at 12:13=E2=80=AFAM ganglxie <ganglxie@amd.com> wrote:

Please fix the patch title.  Please add a drm/amdgpu prefix.  E.g.,

drm/amdgpu: Refine RAS bad page records counting and parsing in eeprom V3


>
> there is only MCA records in V3, no need to care about PA records.
> recalculate the value of ras_num_bad_pages when parsing failed and
> go on with the left records instead of quit.
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 61 +++++++++++++++----------
>  1 file changed, 36 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index e85143acf3a2..32f41f151c82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2889,6 +2889,7 @@ static int __amdgpu_ras_convert_rec_from_rom(struct=
 amdgpu_device *adev,
>                 if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
>                         return -EINVAL;
>         }
> +
>         return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
>                                                                         a=
dev->umc.retire_unit);
>  }
> @@ -2903,7 +2904,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *=
adev,
>                         &adev->psp.ras_context.ras->eeprom_control;
>         enum amdgpu_memory_partition nps =3D AMDGPU_NPS1_PARTITION_MODE;
>         int ret =3D 0;
> -       uint32_t i;
> +       uint32_t i =3D 0;
>
>         if (!con || !con->eh_data || !bps || pages <=3D 0)
>                 return 0;
> @@ -2924,28 +2925,31 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device=
 *adev,
>         mutex_lock(&con->recovery_lock);
>
>         if (from_rom) {
> -               for (i =3D 0; i < pages; i++) {
> -                       if (control->ras_num_recs - i >=3D adev->umc.reti=
re_unit) {
> -                               if ((bps[i].address =3D=3D bps[i + 1].add=
ress) &&
> -                                   (bps[i].mem_channel =3D=3D bps[i + 1]=
.mem_channel)) {
> -                                       //deal with retire_unit records a=
 time
> -                                       ret =3D __amdgpu_ras_convert_rec_=
array_from_rom(adev,
> -                                                                       &=
bps[i], &err_data, nps);
> -                                       if (ret)
> -                                               goto free;
> -                                       i +=3D (adev->umc.retire_unit - 1=
);
> +               /* there is no pa recs in V3, so skip pa recs processing =
*/
> +               if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> +                       for (i =3D 0; i < pages; i++) {
> +                               if (control->ras_num_recs - i >=3D adev->=
umc.retire_unit) {
> +                                       if ((bps[i].address =3D=3D bps[i =
+ 1].address) &&
> +                                               (bps[i].mem_channel =3D=
=3D bps[i + 1].mem_channel)) {
> +                                               /* deal with retire_unit =
records a time */
> +                                               ret =3D __amdgpu_ras_conv=
ert_rec_array_from_rom(adev,
> +                                                                        =
       &bps[i], &err_data, nps);
> +                                               if (ret)
> +                                                       control->ras_num_=
bad_pages -=3D adev->umc.retire_unit;
> +                                               i +=3D (adev->umc.retire_=
unit - 1);
> +                                       } else {
> +                                               break;
> +                                       }
>                                 } else {
>                                         break;
>                                 }
> -                       } else {
> -                               break;
>                         }
>                 }
>                 for (; i < pages; i++) {
>                         ret =3D __amdgpu_ras_convert_rec_from_rom(adev,
>                                 &bps[i], &err_data, nps);
>                         if (ret)
> -                               goto free;
> +                               control->ras_num_bad_pages -=3D adev->umc=
.retire_unit;
>                 }
>         } else {
>                 ret =3D __amdgpu_ras_restore_bad_pages(adev, bps, pages);
> @@ -3040,21 +3044,28 @@ static int amdgpu_ras_load_bad_pages(struct amdgp=
u_device *adev)
>                 dev_err(adev->dev, "Failed to load EEPROM table records!"=
);
>         } else {
>                 if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)=
 {
> -                       for (i =3D 0; i < control->ras_num_recs; i++) {
> -                               if ((control->ras_num_recs - i) >=3D adev=
->umc.retire_unit) {
> -                                       if ((bps[i].address =3D=3D bps[i =
+ 1].address) &&
> -                                               (bps[i].mem_channel =3D=
=3D bps[i + 1].mem_channel)) {
> -                                               control->ras_num_pa_recs =
+=3D adev->umc.retire_unit;
> -                                               i +=3D (adev->umc.retire_=
unit - 1);
> +                       /*In V3, there is no pa recs, and some cases(when=
 address=3D=3D0) may be parsed
> +                       as pa recs, so add verion check to avoid it.
> +                       */
> +                       if (control->tbl_hdr.version < RAS_TABLE_VER_V3) =
{
> +                               for (i =3D 0; i < control->ras_num_recs; =
i++) {
> +                                       if ((control->ras_num_recs - i) >=
=3D adev->umc.retire_unit) {
> +                                               if ((bps[i].address =3D=
=3D bps[i + 1].address) &&
> +                                                       (bps[i].mem_chann=
el =3D=3D bps[i + 1].mem_channel)) {
> +                                                       control->ras_num_=
pa_recs +=3D adev->umc.retire_unit;
> +                                                       i +=3D (adev->umc=
.retire_unit - 1);
> +                                               } else {
> +                                                       control->ras_num_=
mca_recs +=3D
> +                                                                        =
       (control->ras_num_recs - i);
> +                                                       break;
> +                                               }
>                                         } else {
> -                                               control->ras_num_mca_recs=
 +=3D
> -                                                                       (=
control->ras_num_recs - i);
> +                                               control->ras_num_mca_recs=
 +=3D (control->ras_num_recs - i);
>                                                 break;
>                                         }
> -                               } else {
> -                                       control->ras_num_mca_recs +=3D (c=
ontrol->ras_num_recs - i);
> -                                       break;
>                                 }
> +                       } else {
> +                               control->ras_num_mca_recs =3D control->ra=
s_num_recs;
>                         }
>                 }
>
> --
> 2.34.1
>

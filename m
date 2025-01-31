Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B200EC02192
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 13:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B7F410E0AC;
	Fri, 31 Jan 2025 13:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WfPdMUUv";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1581810E0AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 13:53:16 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2f7d35de32dso410925a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 05:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738331595; x=1738936395; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNMBkOpmP6vvdTRVVBF/6yEZJShOGeWKrlGiQrsMP4E=;
 b=WfPdMUUveieaCL/QVV7jEi6ukYluSskwn1NUnR6TYbgJuu5q+BhLDtkquQWpPxGRzh
 +sR0ZLh/s1zPbc465UocSqdxrio7sIw2FQia4NAQOg94nKSXITmnvKQGUMXQg8u/eTAH
 T6W+PBUG5Viyn+FowknoddYOKYX4Y78P2nIB/fcq703NJGUykwo8cStmby3e0yqYl/a0
 u0swg8o7NQa7tJg3O0WTLucSylzBYfOMombZeDw77HIBA+0r3TamHMqUmvOQYmUl+l6Q
 /3gZNiwirq5raxgMpaN5daz20MD3mKlgBIO/7tu+MCfFeZYETfvqGFssD5j8GUIHA43+
 dlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738331595; x=1738936395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNMBkOpmP6vvdTRVVBF/6yEZJShOGeWKrlGiQrsMP4E=;
 b=t6fXu6UZ1LEPN5XtimQVzKZjPG1HqA41rEF7x4jo0bnMpShYY5t4hudOdOoXTue3qH
 w7nHUFLgg3NOEGcD/femdLYDy/cl74yC3OI15oTbsqN17PtknJY24MT250juP9zzylcH
 YpTnMX22a9eI51vJch/8mAdRUjozRl5BEce6+JPenb2BnUqlyZzdNYMbc8QLF6mCnvGG
 5X2e85BjhJ0U1u4/USbJgc+F/kQkwIqcrtRElcQXZNvOJQGCHi2oo45ucVoaoAE1GObU
 j2OMSQWrAa570n6WpKFMM+nD6HjHV0sYzI3GN4c6L1C8dTdqU8YvKY2wTmL6iEQVdVEc
 mcew==
X-Gm-Message-State: AOJu0YxSkUuZsdGtrvZUQNu42TRfPmOAcVOyUMOzuUjkbrmSe7IFyQfU
 d34O37Jk0C7FscvxD2gxWdloknb41XdRQDVpjlglmQ2Ab5Nh+fHI/0nASr27AfJyV+7H5FPjQo7
 4Xwb3f6Ntmvohd2OZY7a0ajQ61xM=
X-Gm-Gg: ASbGncstFbjudoVjOQ8Bx30vzCRqp/xphHFQLJOBYszx36D4apU5UVD0pIPKSDeCbU4
 PkUL+4tDop8a0jO9yyR242RIqUwwom0IjHvrnshBxANA0fMU40FxvLSHZ7z+mQM1Ih/nYWDYZ
X-Google-Smtp-Source: AGHT+IHE7f9QSagHHdqt0DLY47EHPHY1WZoQrmKI8BJw6VNt+AqevfLhGpoOsD2Ew0VKRWbQud85Qyr6tsxO+VJFEWg=
X-Received: by 2002:a17:90a:c2c7:b0:2ee:d4ed:13a7 with SMTP id
 98e67ed59e1d1-2f83acaaa06mr6057487a91.7.1738331595381; Fri, 31 Jan 2025
 05:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20250131125518.1792987-1-lijo.lazar@amd.com>
In-Reply-To: <20250131125518.1792987-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 Jan 2025 08:53:03 -0500
X-Gm-Features: AWEUYZlDdGBhQbqVafEhU8LAutcHavxQLzsfoa-8pi_-nmMTY116UPO1hBvK_bY
Message-ID: <CADnq5_N72Ha=V5D1XfJj5htTYysx+kXTQr8WJSFwfKuacXjUHA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Limit to 8 jpeg rings per instance
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com
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

On Fri, Jan 31, 2025 at 8:02=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> JPEG 5.0.1 supports upto 10 rings, however PMFW support for SMU v13.0.6
> variants is now limited to 8 per instance. Limit to 8 temporarily to
> avoid out of bounds access.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 7f0b4cc1141b..11591c01be0e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2513,6 +2513,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>         MetricsTableV2_t *metrics_v2;
>         struct amdgpu_xcp *xcp;
>         u16 link_width_level;
> +       u8 num_jpeg_rings;
>         u32 inst_mask;
>         bool per_inst;
>
> @@ -2649,6 +2650,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>
>         per_inst =3D smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METR=
ICS));
>
> +       num_jpeg_rings =3D max_t(u8, adev->jpeg.num_jpeg_rings, 8);
>         for_each_xcp(adev->xcp_mgr, xcp, i) {
>                 amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_ma=
sk);
>                 idx =3D 0;
> @@ -2656,11 +2658,11 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct=
 smu_context *smu, void **table
>                         /* Both JPEG and VCN has same instances */
>                         inst =3D GET_INST(VCN, k);
>
> -                       for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j)=
 {
> +                       for (j =3D 0; j < num_jpeg_rings; ++j) {
>                                 gpu_metrics->xcp_stats[i].jpeg_busy
> -                                       [(idx * adev->jpeg.num_jpeg_rings=
) + j] =3D
> +                                       [(idx * num_jpeg_rings) + j] =3D
>                                         SMUQ10_ROUND(GET_METRIC_FIELD(Jpe=
gBusy, version)
> -                                                       [(inst * adev->jp=
eg.num_jpeg_rings) + j]);
> +                                                       [(inst * num_jpeg=
_rings) + j]);
>                         }
>                         gpu_metrics->xcp_stats[i].vcn_busy[idx] =3D
>                                SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, ver=
sion)[inst]);
> --
> 2.25.1
>

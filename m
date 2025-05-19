Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9B9C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 13:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC5610E40E;
	Mon, 19 May 2025 13:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VrSFm2t1";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C9210E232
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 13:45:05 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b26e6c551f8so306082a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747662305; x=1748267105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVCp6+crwWYXNbXVOO1dEkJjKk8p18F1cJge7wBy18s=;
 b=VrSFm2t1iBfeKMvEiYQ1NkIx7uMKslDQuAVc9rJfSnCuly0rbXpPCgs/6r5S+wTmT5
 4hwJLNxspI7FK4f55yi+4R2V/Q59nnhMWLU1iPe9ZQtDSHosaEoJMwi+qXlIU5MDYBHj
 s8DY8jUS4/XaXQRk73RVUJTgBumgxw9A9pYSnfn/15FOMaAYQ49aRWXoIfFI0CV8/hti
 BexczOFsOyXLwfC8RVjz5VQb5L2WpJB30e8Oiy2uekgOTzY/3W0BgNLWBbY27bUDCLWl
 P1dq2qLwiadUC695XedgNRNWzhEUvJOlcdEFM2LsVnMg2M/CEE6IM5O1AXOjH0YtgzCI
 L/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747662305; x=1748267105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVCp6+crwWYXNbXVOO1dEkJjKk8p18F1cJge7wBy18s=;
 b=CA5ynIEaVpzUWuR8uyzIqvojDs6F/v67RdONyi/x9XzPNMdsl7BIIg54jxuATCAH1I
 /1jl3xSKx1fd2fKmPW2JELJYtKfiQ/9VmjJM3k8WWaqVR8OmA0qI3a2wPlJ6wC5lZ5TC
 f1bNEzo3ppo8OIDigzEAkk5jVBo04BYm3se11ZbxF7M6z96BvnCKgBdIRriDac2U4fEN
 DENqDp/PM5t6NrhY8LxJ8kXgt5ooAXzT4CShirOGbntCqLYallerwoPldLfist3aBOYR
 O0sfd3Cz25yuVZ+dCBrLweVyNeZOtMD2U03E3amcje6wmZvN0pe4F2Gkk81NaDGpLQVi
 B2/Q==
X-Gm-Message-State: AOJu0YwIYw4lPQLe34tu9uHcXzVQarDnmwSW+LJtjd/1S+BC80Rbu065
 nGwIPH8JUJiFUxOCnjL23E6mk93ITigRwCW73AZAch/FjIn9n0200aMGGd02oW1M0m6N5NqOgkK
 hNoRJeDUxZOnBENHCcWYHRKdzPQ92h5A=
X-Gm-Gg: ASbGnctvx2L+vuXqn0lnPVvdCZRP0/UvIFHCognJZ0LGkKV2PBMfgg9fFe0kqSd4Ycx
 6eoqImRGbV0sc3IK5dnJ0QZjTeoXjf318K84NGVIp+hIxRMRZm2lbLxwbspNLQ6U4o9ojByzK/8
 OkegO6iwvWg8VHswg5FglWcyCBtZ48zB3+mQ==
X-Google-Smtp-Source: AGHT+IFQ7EtoPu8xEYVL37XA2rZMq2Mp3Lvj25p04CjRNG1EQiNTgvA9AOZQd5Iji8lpZeb1AXWoJuSmQNJtDBl2ghQ=
X-Received: by 2002:a17:903:41d0:b0:22f:d4e7:e7ca with SMTP id
 d9443c01a7336-231d43b2377mr70134935ad.6.1747662304535; Mon, 19 May 2025
 06:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250519132027.513023-1-lijo.lazar@amd.com>
In-Reply-To: <20250519132027.513023-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 May 2025 09:44:52 -0400
X-Gm-Features: AX0GCFumWCW0n-eTONJLBMPODrfbbxTm9lV8NX7-8BxOkwVwqXOpBaMemYPsZ9Y
Message-ID: <CADnq5_Ox1=pDcAOwA=sanGssrSZwEdLCpqMHHD7EzqJzCfm+sw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: Use external link order for xgmi data
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, 
 Yang Wang <kevinyang.wang@amd.com>
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

On Mon, May 19, 2025 at 9:20=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> xgmi_port_num interface reports external link number for port number. To
> be consistent, use the external link number for reporting other XGMI
> link data also.
>
> v2: For invalid link number return -EINVAL (Kevin)
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Acked-by: Yang Wang <kevinyang.wang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c        | 17 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h        |  1 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c   |  9 ++++++---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 ++++++++-----
>  4 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index f51ef4cf16e0..d9ad37711c3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -294,6 +294,23 @@ static const struct amdgpu_pcs_ras_field xgmi3x16_pc=
s_ras_fields[] =3D {
>          SOC15_REG_FIELD(PCS_XGMI3X16_PCS_ERROR_STATUS, RxCMDPktErr)},
>  };
>
> +int amdgpu_xgmi_get_ext_link(struct amdgpu_device *adev, int link_num)
> +{
> +       int link_map_6_4_x[8] =3D { 0, 3, 1, 2, 7, 6, 4, 5 };
> +
> +       switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
> +       case IP_VERSION(6, 4, 0):
> +       case IP_VERSION(6, 4, 1):
> +               if (link_num < ARRAY_SIZE(link_map_6_4_x))
> +                       return link_map_6_4_x[link_num];
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  static u32 xgmi_v6_4_get_link_status(struct amdgpu_device *adev, int glo=
bal_link_num)
>  {
>         const u32 smn_xgmi_6_4_pcs_state_hist1[2] =3D { 0x11a00070, 0x11b=
00070 };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.h
> index 32dabba4062f..f994be985f42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -125,6 +125,7 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_devi=
ce *adev,
>                                    int req_nps_mode);
>  int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev,
>                                 int global_link_num);
> +int amdgpu_xgmi_get_ext_link(struct amdgpu_device *adev, int link_num);
>
>  void amdgpu_xgmi_early_init(struct amdgpu_device *adev);
>  uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index ac172b21f803..69f92bd35bf2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -472,13 +472,16 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_con=
text *smu, void **table)
>         gpu_metrics->mem_activity_acc =3D SMUQ10_ROUND(metrics->DramBandw=
idthUtilizationAcc);
>
>         for (i =3D 0; i < NUM_XGMI_LINKS; i++) {
> -               gpu_metrics->xgmi_read_data_acc[i] =3D
> +               j =3D amdgpu_xgmi_get_ext_link(adev, i);
> +               if (j < 0 || j >=3D NUM_XGMI_LINKS)
> +                       continue;
> +               gpu_metrics->xgmi_read_data_acc[j] =3D
>                         SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
> -               gpu_metrics->xgmi_write_data_acc[i] =3D
> +               gpu_metrics->xgmi_write_data_acc[j] =3D
>                         SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
>                 ret =3D amdgpu_get_xgmi_link_status(adev, i);
>                 if (ret >=3D 0)
> -                       gpu_metrics->xgmi_link_status[i] =3D ret;
> +                       gpu_metrics->xgmi_link_status[j] =3D ret;
>         }
>
>         gpu_metrics->num_partition =3D adev->xcp_mgr->num_xcps;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 645c2bff3e5f..179b1b16edd1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2819,13 +2819,16 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct=
 smu_context *smu, void **table
>                 SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc=
, version));
>
>         for (i =3D 0; i < NUM_XGMI_LINKS; i++) {
> -               gpu_metrics->xgmi_read_data_acc[i] =3D
> -                       SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc=
, version)[i]);
> -               gpu_metrics->xgmi_write_data_acc[i] =3D
> -                       SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAc=
c, version)[i]);
> +               j =3D amdgpu_xgmi_get_ext_link(adev, i);
> +               if (j < 0 || j >=3D NUM_XGMI_LINKS)
> +                       continue;
> +               gpu_metrics->xgmi_read_data_acc[j] =3D SMUQ10_ROUND(
> +                       GET_METRIC_FIELD(XgmiReadDataSizeAcc, version)[i]=
);
> +               gpu_metrics->xgmi_write_data_acc[j] =3D SMUQ10_ROUND(
> +                       GET_METRIC_FIELD(XgmiWriteDataSizeAcc, version)[i=
]);
>                 ret =3D amdgpu_get_xgmi_link_status(adev, i);
>                 if (ret >=3D 0)
> -                       gpu_metrics->xgmi_link_status[i] =3D ret;
> +                       gpu_metrics->xgmi_link_status[j] =3D ret;
>         }
>
>         gpu_metrics->num_partition =3D adev->xcp_mgr->num_xcps;
> --
> 2.25.1
>

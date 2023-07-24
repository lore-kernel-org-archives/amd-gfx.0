Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E847C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 13:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C508D10E313;
	Mon, 24 Jul 2023 13:22:19 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69AAA10E313
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 13:22:17 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1b449890ef5so3429877fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690204936; x=1690809736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lReCM1Ng5R5l5rw6SUsay1V2ASZdcgW+9GTWja1MJxE=;
 b=Z7JHLiLZVrF/1EVqqWwgouLTDAOyvOaO3uM8ldKg9Cl1d3lnGaDSsoz3eBxwhHz3bw
 Cvf5y1FefUBQ+g85aalPr0iQrF2dc6lN3ThD4ZfDO2OmmsrPPCeu/5z0/1O74iqDV7Ml
 4DexjZ1Kv8II1IPOEtybkkrXlB/W9bZhi3oZZ0xbGdBf44m7eETAYBijOcZLcmXFOvbT
 u2GS6HxIBSZft3zHWlxNjbUHAbMquBw+yIqIXHZgklp0C5MOK7HiBpQguvyenyA2xZ0o
 1AGjlNyKT8wjWJTt2yEDZinKaAwWwibH/108pqVOfWd1LaWaE0HxAYVqq43wkzk4DZLP
 2Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690204936; x=1690809736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lReCM1Ng5R5l5rw6SUsay1V2ASZdcgW+9GTWja1MJxE=;
 b=TdRPPvt0vkiyJ7bla+0LK/Uj/KdKqYZ0sY+Rb2WFNqskvTUuVcEj1FVMUm7nHId5Kq
 2E5TozlwdfiZKbkczFMweKvBPlknsfXDP1BTPSc1jnbwjcyG45XMMXY7inO171ZqS2HL
 63YIAlmjzVaJsfof5ZhhyjutT5WDm7jys8agv9b56m67aMx/ui65idHKJjPnKO7WasGk
 aLaJqpvOQsQ/g7P1PaWrEmJEHrLKKUlpVG4wHhWo/a8p4U+7np7Go7OM08AkKkDB89Fr
 X7JR0z+3EdtayPSE79DZBl6OpWIGsEi37bV9MY2FhWT1bT0bqy0+KaVj4xU36aexYG//
 DpiQ==
X-Gm-Message-State: ABy/qLZWivGEBo6wVeeBmGPJG2cNJAalZMDgG/yUqYEfeBIEaXLaB8fQ
 sN44DlcWRgjGUpW7cBRGSdbqyQ+MC2V8ba7mlMc=
X-Google-Smtp-Source: APBJJlHVn5K/kUXVQKZPtpJXJvKOZEKXZMuT5vxWSVVRIvfMsdPhUqvch/ezdcdNsuNcPVLZsgBIckb7y1ekeZCQL1U=
X-Received: by 2002:a05:6870:428e:b0:1b3:d39a:968f with SMTP id
 y14-20020a056870428e00b001b3d39a968fmr11339232oah.58.1690204936402; Mon, 24
 Jul 2023 06:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230723094921.2054552-1-srinivasan.shanmugam@amd.com>
 <20230723125320.2059977-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230723125320.2059977-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jul 2023 09:22:05 -0400
Message-ID: <CADnq5_OVK18pqJhQ6FYyBi21pt3NqQ4GzQ5gq+qoyjL0FLtS8A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Add -ENOMEM error handling when there is
 no memory
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

On Sun, Jul 23, 2023 at 8:53=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Return -ENOMEM, when there is no sufficient dynamically allocated memory
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>
> v2:
>  - Added -ENOMEM - when it failed to create MQD backup,
>    while creating MQD for each KCQ
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 17 ++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c   |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  4 +++-
>  4 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 6639fde5dd5c..c76b6bfc4dab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -110,9 +110,9 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_dev=
ice *adev,
>   * The bitmask of CUs to be disabled in the shader array determined by s=
e and
>   * sh is stored in mask[se * max_sh + sh].
>   */
> -void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se, unsign=
ed max_sh)
> +void amdgpu_gfx_parse_disable_cu(unsigned int *mask, unsigned int max_se=
, unsigned int max_sh)
>  {
> -       unsigned se, sh, cu;
> +       unsigned int se, sh, cu;
>         const char *p;
>
>         memset(mask, 0, sizeof(*mask) * max_se * max_sh);
> @@ -124,6 +124,7 @@ void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsi=
gned max_se, unsigned max_s
>         for (;;) {
>                 char *next;
>                 int ret =3D sscanf(p, "%u.%u.%u", &se, &sh, &cu);
> +
>                 if (ret < 3) {
>                         DRM_ERROR("amdgpu: could not parse disable_cu\n")=
;
>                         return;
> @@ -349,7 +350,7 @@ void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev, =
int xcc_id)
>  }
>
>  int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
> -                       unsigned hpd_size, int xcc_id)
> +                       unsigned int hpd_size, int xcc_id)
>  {
>         int r;
>         u32 *hpd;
> @@ -376,7 +377,7 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
>
>  /* create MQD for each compute/gfx queue */
>  int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
> -                          unsigned mqd_size, int xcc_id)
> +                          unsigned int mqd_size, int xcc_id)
>  {
>         int r, i, j;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
> @@ -454,8 +455,10 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ade=
v,
>                         ring->mqd_size =3D mqd_size;
>                         /* prepare MQD backup */
>                         adev->gfx.mec.mqd_backup[j] =3D kmalloc(mqd_size,=
 GFP_KERNEL);
> -                       if (!adev->gfx.mec.mqd_backup[j])
> +                       if (!adev->gfx.mec.mqd_backup[j]) {
>                                 dev_warn(adev->dev, "no memory to create =
MQD backup for ring %s\n", ring->name);
> +                               return -ENOMEM;
> +                       }
>                 }
>         }
>
> @@ -1286,11 +1289,11 @@ static ssize_t amdgpu_gfx_get_available_compute_p=
artition(struct device *dev,
>         return sysfs_emit(buf, "%s\n", supported_partition);
>  }
>
> -static DEVICE_ATTR(current_compute_partition, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(current_compute_partition, 0644,
>                    amdgpu_gfx_get_current_compute_partition,
>                    amdgpu_gfx_set_compute_partition);
>
> -static DEVICE_ATTR(available_compute_partition, S_IRUGO,
> +static DEVICE_ATTR(available_compute_partition, 0444,
>                    amdgpu_gfx_get_available_compute_partition, NULL);
>
>  int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index 03dc59cbe8aa..7e91b24784e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -500,6 +500,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct =
amdgpu_device *adev)
>         hive =3D kzalloc(sizeof(*hive), GFP_KERNEL);
>         if (!hive) {
>                 dev_err(adev->dev, "XGMI: allocation failed\n");
> +               ret =3D -ENOMEM;
>                 hive =3D NULL;
>                 goto pro_end;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v10_1.c
> index 36a123e6c8ee..eb06d749876f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -909,10 +909,12 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_devi=
ce *adev,
>
>         /* prepare MQD backup */
>         adev->mes.mqd_backup[pipe] =3D kmalloc(mqd_size, GFP_KERNEL);
> -       if (!adev->mes.mqd_backup[pipe])
> +       if (!adev->mes.mqd_backup[pipe]) {
>                 dev_warn(adev->dev,
>                          "no memory to create MQD backup for ring %s\n",
>                          ring->name);
> +               return -ENOMEM;
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 8e67e965f7ea..c8be534cc60d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1021,10 +1021,12 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_de=
vice *adev,
>
>         /* prepare MQD backup */
>         adev->mes.mqd_backup[pipe] =3D kmalloc(mqd_size, GFP_KERNEL);
> -       if (!adev->mes.mqd_backup[pipe])
> +       if (!adev->mes.mqd_backup[pipe]) {
>                 dev_warn(adev->dev,
>                          "no memory to create MQD backup for ring %s\n",
>                          ring->name);
> +               return -ENOMEM;
> +       }
>
>         return 0;
>  }
> --
> 2.25.1
>

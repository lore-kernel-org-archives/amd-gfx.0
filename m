Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FF8C3DA78
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 14:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA45110E546;
	Tue, 17 Jan 2023 14:13:19 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CABF10E546
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 14:13:18 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-15b9c93848dso23789144fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 06:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09uObknMqzP1TxSF5N7o6B2YYXa5LgL7geMM1HNGUrw=;
 b=FYzwFZzIN2gauxmzH4n2Ct3yLcggFqFmv71qZMKtvKf9DhLxc95+e0c9g9aVVg1SAr
 UZkX7wRXvpraOHptJdO32g/BTmDLXmNarBbo6abMem25cUjZgilGuNI6FuTp0x1kitSZ
 78lc94OI6GYTi/OTqp4aN5wVCxFWRN1+kKGF9efgx8vRqMpeSIdQ7Y+ANW5d+EQSWHrZ
 qcooep1kri+L5nG1Q3m5vYsuz/hxGV6K0F1Cayf4QUocNwLVME1e/P6egXIP6Jt9RKvR
 2XojSNj8DtAoRZrhW4/iSIiIoj+gA3vdMDvB8VuetHzXlSFzk8msFSKqT9Tc7VvCxxdP
 YcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09uObknMqzP1TxSF5N7o6B2YYXa5LgL7geMM1HNGUrw=;
 b=jxp/LA4ihWKJuPoEN66/NXX4d15kVxyLdqTvhKOncpwTH5IQtf35+K/SLO+SXrIkdU
 rIOGijVw3ZeysCWJB4EU7QDz2X6RG9tRBBf9Z+AQITUEO3lDzYfM4C4OHra5IJV/9UUj
 qLi10WzoAbowv3zT5dAJeqziQW0KmL5wdBwiOtmnsIe8vZQyhta/wYfO+Uv1ARHn5CR+
 +DU6ZTDN+EyBWcgAzTklESlzMSN486G6cLKFJGhpBACz4szv6I2qopZ4MqSHmsgc6KPL
 XYrUiqvLUx8ky9MeZLx5eq5FvZnr+qRStrIx7yu35NaOPEzHW17ES5CJYSeIBxeO+Msd
 dUMQ==
X-Gm-Message-State: AFqh2krdmJxXJ3iCRqDvOD/UK2rzPzYoCADi6XRQlEyaQk1ZDPVIaSfx
 deRJxSevnJFCzIBwYJuRJprEfw14NJ/LiQDRaCM=
X-Google-Smtp-Source: AMrXdXu2YJva9FcqZY7tP4IsE2oKh3/vHMPKBpiXoz+xvl7ywyAKrLx4zOPEtg/1oqJ+Yj7eZTn5zTVsDRnWG/rl8Os=
X-Received: by 2002:a05:6871:4593:b0:150:d9aa:4011 with SMTP id
 nl19-20020a056871459300b00150d9aa4011mr279411oab.96.1673964797761; Tue, 17
 Jan 2023 06:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20230117081240.13669-1-christian.koenig@amd.com>
 <20230117081240.13669-2-christian.koenig@amd.com>
In-Reply-To: <20230117081240.13669-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jan 2023 09:13:06 -0500
Message-ID: <CADnq5_NQwe1kvK98Oqsrvs-LnuBr=w173bAQb+dxo5k5rr8qOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: simplify amdgpu_uvd_send_msg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jan 17, 2023 at 3:12 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> We only need one offset and not an array of it.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index dd0894c9740d..229419c0c031 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1118,29 +1118,26 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring=
 *ring, struct amdgpu_bo *bo,
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         struct dma_fence *f =3D NULL;
> +       uint32_t offset, data[4];
>         struct amdgpu_job *job;
>         struct amdgpu_ib *ib;
> -       uint32_t data[4];
>         uint64_t addr;
>         int i, r;
> -       unsigned offset_idx =3D 0;
> -       unsigned offset[3] =3D { UVD_BASE_SI, 0, 0 };
>
>         r =3D amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_=
DIRECT :
>                                      AMDGPU_IB_POOL_DELAYED, &job);
>         if (r)
>                 return r;
>
> -       if (adev->asic_type >=3D CHIP_VEGA10) {
> -               offset_idx =3D 1 + ring->me;
> -               offset[1] =3D adev->reg_offset[UVD_HWIP][0][1];
> -               offset[2] =3D adev->reg_offset[UVD_HWIP][1][1];
> -       }
> +       if (adev->asic_type >=3D CHIP_VEGA10)
> +               offset =3D adev->reg_offset[UVD_HWIP][ring->me][1];
> +       else
> +               offset =3D UVD_BASE_SI;
>
> -       data[0] =3D PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_DATA0, 0)=
;
> -       data[1] =3D PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_DATA1, 0)=
;
> -       data[2] =3D PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_CMD, 0);
> -       data[3] =3D PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
> +       data[0] =3D PACKET0(offset + UVD_GPCOM_VCPU_DATA0, 0);
> +       data[1] =3D PACKET0(offset + UVD_GPCOM_VCPU_DATA1, 0);
> +       data[2] =3D PACKET0(offset + UVD_GPCOM_VCPU_CMD, 0);
> +       data[3] =3D PACKET0(offset + UVD_NO_OP, 0);
>
>         ib =3D &job->ibs[0];
>         addr =3D amdgpu_bo_gpu_offset(bo);
> --
> 2.34.1
>

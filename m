Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D564AC54EBE
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 20:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75ED810E4B0;
	Mon, 16 Jan 2023 20:17:47 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2DE10E4B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 20:17:46 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 r2-20020a9d7cc2000000b006718a7f7fbaso16710904otn.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHKAMGJPo0uR0JzN9L0DUby7vlU9cN2VkV3BlcQ73rg=;
 b=GvmkANswbObfIhvD3l3UEFmvRKz4K2azinyZ6KpCuu8HgXQEVZ4Rttm9BQ+ffQdMoi
 1Ffk8fSlqjxaKqMbGCgp2MqeSHT3V2uiM7bd/eXjmlCuDMkrMseZI5RKqWkD5oXnZlpQ
 hVeUiMBkkcFRhqxsLNrvUYp5WQMjz42NQG/cr1O+nued1Yu/Up+xg9QYTuOWi3fyrpqB
 GuFwqJ2Z120Ji+7rm8eYwKouS1eo1lC2htct1yIoN+8moZ3YIJ80S+zBNa6k1XJ1yDbN
 3xqxw2TkdzWbZ2BETPIqLZycugRw75laYgk5qcRuoB26EdB3WFhlOuPqpLy73uXIhVPy
 dYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHKAMGJPo0uR0JzN9L0DUby7vlU9cN2VkV3BlcQ73rg=;
 b=Vld/XHZTBnPAN35uq1lyaR3lP6JKVY1WFOzjfHvDsM7+Mr18ghI3fKcQiXLAwB+YSB
 HvPzyrd2DELyIlED1IrqZntyE5NOjh0jg30+5Fd8yQlnxDBmsNBr42S1/FP1HLEfDwQT
 8uL35k8sPT6tYWPn8pS2SnAJwS9SXuYx4/Ym9+bVp4E2Nry5L9Dqay1FoavhmUSb6AEr
 gfDkSwasxSOBKpp9tDtPTxyA3o7dW7irgVGNrA/xSW0/WIh4vGmMZ8KVMkXq0j9N9ZwW
 6wGU34BKN+3Xl/yjv5hP+jR39uANTrSaZpIs1ehSuErUYcxolefWDm56hYFQS6fTglEr
 eYrQ==
X-Gm-Message-State: AFqh2kr3APf8fWImzQeEpu+/wId0stg54uj9cd0HYBk30upvkOq5GuaK
 WHsySB3KQAMOvPA5oHEeZ4c2tohj/lkJk2NytxY=
X-Google-Smtp-Source: AMrXdXvPUkhZK/fbliOvYxAh3aJ+WWTFEiRDIJDfdygZyk848DRVLAng2mHywpTIVkI4qdpZlxrlwJFAZ4r1xDAUMD4=
X-Received: by 2002:a05:6830:449:b0:684:bedc:4f54 with SMTP id
 d9-20020a056830044900b00684bedc4f54mr18886otc.233.1673900265602; Mon, 16 Jan
 2023 12:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20230116201218.5113-1-christian.koenig@amd.com>
 <20230116201218.5113-2-christian.koenig@amd.com>
In-Reply-To: <20230116201218.5113-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jan 2023 15:17:34 -0500
Message-ID: <CADnq5_PaheFHQzg5_iRBn-e83E7ofjHMxfmO7tqqTsJMGQ1hLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: simplify and cleanup amdgpu_uvd_send_msg
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
Cc: amd-gfx@lists.freedesktop.org, thong.thai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 16, 2023 at 3:12 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> We only need one offset and not an array of it.
>
> We have a wait in the amdgpu_bo_kmap() code for quite a while now, so
> waiting here isn't needed any more.

This should probably be two patches, one to clean up the offsets and
one to remove the syncs.

Alex

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 38 +++++++------------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index b67a5fb2ff3e..229419c0c031 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1118,30 +1118,26 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring=
 *ring, struct amdgpu_bo *bo,
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         struct dma_fence *f =3D NULL;
> +       uint32_t offset, data[4];
>         struct amdgpu_job *job;
>         struct amdgpu_ib *ib;
> -       uint32_t data[4];
>         uint64_t addr;
> -       long r;
> -       int i;
> -       unsigned offset_idx =3D 0;
> -       unsigned offset[3] =3D { UVD_BASE_SI, 0, 0 };
> +       int i, r;
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
> @@ -1158,24 +1154,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring=
 *ring, struct amdgpu_bo *bo,
>         ib->length_dw =3D 16;
>
>         if (direct) {
> -               r =3D dma_resv_wait_timeout(bo->tbo.base.resv,
> -                                         DMA_RESV_USAGE_KERNEL, false,
> -                                         msecs_to_jiffies(10));
> -               if (r =3D=3D 0)
> -                       r =3D -ETIMEDOUT;
> -               if (r < 0)
> -                       goto err_free;
> -
>                 r =3D amdgpu_job_submit_direct(job, ring, &f);
>                 if (r)
>                         goto err_free;
>         } else {
> -               r =3D amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.res=
v,
> -                                    AMDGPU_SYNC_ALWAYS,
> -                                    AMDGPU_FENCE_OWNER_UNDEFINED);
> -               if (r)
> -                       goto err_free;
> -
>                 r =3D amdgpu_job_submit(job, &adev->uvd.entity,
>                                       AMDGPU_FENCE_OWNER_UNDEFINED, &f);
>                 if (r)
> --
> 2.34.1
>

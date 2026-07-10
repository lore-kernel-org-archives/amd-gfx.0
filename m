Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D065DC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 13:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3741E10E1B5;
	Fri, 10 Jul 2026 13:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E0cth/tS";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF3010E1B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 13:17:36 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-380a02c71e2so417600a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783689455; cv=none;
 d=google.com; s=arc-20260327;
 b=eQs2MDYO/tRkcFmcvaMEzN+a+/jpbRrhK74ry3VF3POH9OSaaMGJyfrL23uBIDnFCf
 ej4SmWBeOqNerQPPhEu+YFCikbhyr+rWdOjzT9mPyziTMoM/tLttBzYFyV2XB7U2T7ip
 6yil0HgYcGx0sUPr0aBTJKAuPS7OtP9TNVznDRSUWhyudHYiD4BOwTpYcBdEy4iN6hXP
 fyD7DFo3n2lwVTNjVZhqktAQaBNSyKLMc/cs1bDqenipR25lFqheEuPCpPpGldYAkpSI
 3rKQs9PDVO6Vq6GusCN4DJayd8HbV5C74yEM+KO0RhDLuV9hg4TzU2coE33utZtjEVYH
 ODGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lfEDLX5g+oPVDfMe7ZvqOKzl3SYDhrt0YnV2+d5jAmU=;
 fh=NTFLzSWid31u10IJwXC2si4MWTC0fDs+RxoZ7zZTVas=;
 b=SZ0BL2NKGyrGAr2bX0O7VWK9DJRy2GzOMDvx+QZLHZQ0O1Xm9IqOhjcDOrWcM8N0N5
 SfGholy9zpDK7hiUx86D+Ry5mHvpwRn20WZb0WKB2s+jVZ4h8gpUiFlpq5UUNaDS2qyv
 2y49tkxEH73bRWVmlpRSqfpcjLuzSJxv5dtMN1EKrRbepBz7vowutrYGt3p3mzV+vmV0
 xYBUGqhcXD1RL3ZgrXpk3xv91p5r71MuYB1wQJ33CwfKoxTvEFD6ZwXs9tLJjyGrLFe2
 mUWq1yhxDDjgaHhIJ2JAP39Bept3yyHEQnz7sd9jQBYzfT1KDlJLTEM9TzM58rmI2Cyv
 TFvA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783689455; x=1784294255; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lfEDLX5g+oPVDfMe7ZvqOKzl3SYDhrt0YnV2+d5jAmU=;
 b=E0cth/tS6Nuie+IVzNGxPFS64BNIJeHpm5aSdJ9c40gMCvDFdDe6w4Q3DkwK6WQHNi
 RG8faoohqh/Kz9cbAQetgLs3E7J4eUg84GJyFhOb6cstbg36Rwc/fsWW8YtggEHqEH31
 fmjlD69wNFHnnsReHByiSEv1ewEuCaHAkPFmGziiJ+K/j6KmzVUH12fkyX6fGYSRvfLZ
 YSxQE3BVIVZgHEM8t3iaHl0GlfgMe/inrDIddTsePGD6OkEhLXhapKqf/2Mu/YsypdSe
 A/q7J60EeRs+l6raqMKvsD+jK+CrdQOuaQzcouENRYtGeSsDwHBJPCiIoUlQklCa35Ch
 GiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783689455; x=1784294255;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lfEDLX5g+oPVDfMe7ZvqOKzl3SYDhrt0YnV2+d5jAmU=;
 b=osJ2SmfXTQ7a7SzkrCnO1IZnMCmx9bvhi/4oWSdyLTuF2ymtXgQxWr++nEBdoprWY1
 WLINDEaqOe2seTxAzNFBLFksFdfTAFSKOKjDxcA2swjhelH6a3TRqd4CthFPlP+uzsor
 8gTFjVdv2TLmEWbOBi7QlCBGazVivXgUC9eZBkNz0PHqwEiRZFoR4XWQ2G80mu9/QIzX
 j+AGjAkL9TwK80/OOAVoA91C6BrFk9TjzO1f0RHoIhc6rHIGvF1bLjnvvA059CihymZz
 fFaDUKYi5kWcGPNI04xpSlz3XECvuOkoN90G6VCFS7+70HVpjvMyROS+YofcA9MEKYYL
 JvNQ==
X-Gm-Message-State: AOJu0YzAb2LAMzum8zJtwcpOa8wKY/SXu9DHsv0jqnQWPbZ36nZL8roc
 6yA7AmIGfhAGERA9kdDRUnE6zO/oofoOVf4VQ2tKUts9568+GnV+MxR45L+vVkZB/NX9wBmC+Ur
 19cRpaWe+K12ySyxGVvEseltpdAYiLCZt/g==
X-Gm-Gg: AfdE7cmGFDOnIraxbJyt0sUW7apv4H5d/6aiP82mDI9AqE/NrFuUIC5h2SkCAVZTZZU
 k2S03iuj95G+ShRmU5m0lW3fmaJqBfC/4sgRxA5zF2M5C+tlbIk8ty1YSn31xDcrnmFl9AfxeeY
 fnzoHWeMoOH45XM4z+79UumYakGtVblwLv5gdbDg2YFiwFa4wyBGE0MyZ1AygUBFTEQSSQX2Nhb
 pGFiPK4uqAHitsjqofs+jvTsx4ZrA+yCIfJaHp0xKzp5VpCGNQe/5kkMB4+fErJQcOdvY7TmsUe
 9cO1oo+faGkdbCmE11tgr5JCkI8uXpusVXZUL7aVjIPkNWBwzpj+gRO7J6o=
X-Received: by 2002:a17:90a:ad89:b0:38d:90c1:2400 with SMTP id
 98e67ed59e1d1-38d90c135cdmr1289227a91.2.1783689455394; Fri, 10 Jul 2026
 06:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260709065856.472296-1-Prike.Liang@amd.com>
 <20260709065856.472296-3-Prike.Liang@amd.com>
In-Reply-To: <20260709065856.472296-3-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2026 09:17:23 -0400
X-Gm-Features: AVVi8CdOVxIV1oeELcfr-OaqPZToK5WOmGNxG2EqnAdJhDLIIIu3adsip-iFgW4
Message-ID: <CADnq5_PhWi1AUjhscrbB4pbUd9sOUv44U41kkyzsL2LZyrO=wg@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/amdgpu/mes11: get MES process/gang contex size
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com, Michael.Chen@amd.com
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

On Thu, Jul 9, 2026 at 3:09=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> wr=
ote:
>
> Setup the MES_API_QUERY_MES__GET_CTX_ARRAY_SIZE MES firmware
> command request, and get the MES11 process/gang contex size.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 79 +++++++++++++++++++
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 61 ++++++++++++--
>  2 files changed, 132 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index c721a90051e9..195dc3b4058d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -832,6 +832,58 @@ static int mes_v11_0_query_sched_status(struct amdgp=
u_mes *mes)
>                         offsetof(union MESAPI__QUERY_MES_STATUS, api_stat=
us));
>  }
>
> +/**
> + * QUERY_SCHEDULER_STATUS: get proc/gang context array sizes
> + */
> +static int mes_v11_0_query_ctx_array_sizes(struct amdgpu_mes *mes)
> +{
> +       struct amdgpu_device *adev =3D mes->adev;;
> +       union MESAPI__QUERY_MES_STATUS mes_query_pkt;
> +       int r;
> +
> +       if (!mes->ctx_array_size_cpu_ptr)
> +               return -EINVAL;
> +
> +       /* Clear the output buffer */
> +       mes->ctx_array_size_cpu_ptr[0] =3D 0;  /* proc_ctx_array_size */
> +       mes->ctx_array_size_cpu_ptr[1] =3D 0;  /* gang_ctx_array_size */
> +
> +       memset(&mes_query_pkt, 0, sizeof(mes_query_pkt));
> +
> +       mes_query_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_query_pkt.header.opcode =3D MES_SCH_API_QUERY_SCHEDULER_STATU=
S;
> +       mes_query_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_query_pkt.subopcode =3D MES_API_QUERY_MES__GET_CTX_ARRAY_SIZE=
;
> +
> +       /*
> +        * MES FW will write the array sizes to these GPU addresses:
> +        *   proc_ctx_array_size_addr -> uint32_t N (e.g., 50)
> +        *   gang_ctx_array_size_addr -> uint32_t M (e.g., 300)
> +        */
> +       mes_query_pkt.ctx_array_size.proc_ctx_array_size_addr =3D
> +               mes->ctx_array_size_gpu_addr;
> +       mes_query_pkt.ctx_array_size.gang_ctx_array_size_addr =3D
> +               mes->ctx_array_size_gpu_addr + sizeof(uint32_t);
> +
> +       mes_query_pkt.api_status.api_completion_fence_addr =3D
> +               mes->ring[0].fence_drv.gpu_addr;
> +       mes_query_pkt.api_status.api_completion_fence_value =3D
> +               ++mes->ring[0].fence_drv.sync_seq;
> +
> +       r =3D mes_v11_0_submit_pkt_and_poll_completion(mes,
> +                       &mes_query_pkt, sizeof(mes_query_pkt),
> +                       offsetof(union MESAPI__QUERY_MES_STATUS, api_stat=
us));
> +       if (r) {
> +               dev_err(adev->dev,
> +                       "MES QUERY_SCHEDULER_STATUS (GET_CTX_ARRAY_SIZE) =
failed, r=3D%d\n", r);
> +               return r;
> +       }
> +
> +       /* MES has written the sizes - now set up bitmaps */
> +       return amdgpu_mes_rs64mem_setup_bitmaps(mes);
> +}
> +
>  static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>                              struct mes_misc_op_input *input)
>  {
> @@ -1907,10 +1959,33 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         if (r)
>                 goto failure;
>
> +       /* Allocate GPU buffer for array size query results */
> +       r =3D amdgpu_mes_rs64mem_init(&adev->mes);
> +       if (r)
> +               dev_warn(adev->dev,
> +                        "RS64 local memory init failed (%d), "
> +                        "falling back to system memory path\n", r);
> +
>         r =3D mes_v11_0_set_hw_resources(&adev->mes);
> +
>         if (r)
>                 goto failure;
>
> +       /*
> +        * QUERY_SCHEDULER_STATUS to get array sizes (N, M).
> +        * MES writes the sizes to the GPU buffer, then we allocate bitma=
ps.
> +        */
> +       if (adev->mes.use_rs64mem) {
> +               r =3D mes_v11_0_query_ctx_array_sizes(&adev->mes);
> +               if (r) {
> +                       dev_warn(adev->dev,
> +                                "Failed to query ctx array sizes (%d), "
> +                                "disabling RS64 local memory\n", r);
> +                       /* Continue without optimization - not fatal */
> +               }
> +       }
> +
> +
>         if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x52=
) {
>                 r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
>                 if (r) {
> @@ -1948,6 +2023,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>  static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (adev->mes.use_rs64mem)
> +               amdgpu_mes_rs64mem_fini(&adev->mes);
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v11_api_def.h
> index b06412ac8583..dfc27be4454d 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -329,6 +329,7 @@ union MESAPI__ADD_QUEUE {
>                 uint32_t                    pipe_id;
>                 uint32_t                    queue_id;
>                 uint32_t                    alignment_mode_setting;
> +               uint32_t                    full_sh_mem_config_data;
>                 uint64_t                    unmap_flag_addr;
>         };
>
> @@ -358,6 +359,7 @@ union MESAPI__REMOVE_QUEUE {
>                 uint32_t                    tf_data;
>
>                 enum MES_QUEUE_TYPE         queue_type;
> +               uint64_t                    timestamp;
>         };
>
>         uint32_t        max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> @@ -516,14 +518,57 @@ union MESAPI__SET_LOGGING_BUFFER {
>         uint32_t        max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
>  };
>
> -union MESAPI__QUERY_MES_STATUS {
> -       struct {
> -               union MES_API_HEADER    header;
> -               bool                    mes_healthy; /* 0 - not healthy, =
1 - healthy */
> -               struct MES_API_STATUS   api_status;
> -       };
> -
> -       uint32_t        max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> +enum MES_API_QUERY_MES_OPCODE
> +{
> +    MES_API_QUERY_MES__GET_CTX_ARRAY_SIZE,
> +    MES_API_QUERY_MES__GET_CAPS =3D MES_API_QUERY_MES__GET_CTX_ARRAY_SIZ=
E,
> +    MES_API_QUERY_MES__CHECK_HEALTHY,
> +    MES_API_QUERY_MES__MAX,
> +};
> +
> +enum { QUERY_MES_MAX_SIZE_IN_DWORDS =3D 20 };
> +
> +/**
> + * Obsolete
> + * to be removed once KMD stopped refering to it.
> + * use MES_API_QUERY_MES__CAPS instead
> +*/
> +struct MES_API_QUERY_MES__CTX_ARRAY_SIZE
> +{
> +    uint64_t    proc_ctx_array_size_addr;
> +    uint64_t    gang_ctx_array_size_addr;
> +};
> +
> +struct MES_API_QUERY_MES__HEALTHY_CHECK
> +{
> +    uint64_t    healthy_addr;
> +};
> +
> +struct MES_API_QUERY_MES__CAPS
> +{
> +    uint64_t    proc_ctx_array_size_addr;
> +    uint64_t    gang_ctx_array_size_addr;
> +    uint64_t    features_enablement_addr;
> +};
> +
> +union MESAPI__QUERY_MES_STATUS
> +{
> +    struct
> +    {
> +        union MES_API_HEADER            header;
> +        enum MES_API_QUERY_MES_OPCODE   subopcode;
> +        struct MES_API_STATUS           api_status;
> +        uint64_t                        timestamp;
> +        union
> +        {
> +            struct MES_API_QUERY_MES__CTX_ARRAY_SIZE    ctx_array_size;
> +            struct MES_API_QUERY_MES__CAPS              caps;
> +            struct MES_API_QUERY_MES__HEALTHY_CHECK     healthy_check;
> +            uint32_t data[QUERY_MES_MAX_SIZE_IN_DWORDS];
> +        };
> +    };
> +
> +    uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
>  };
>

Presumably we need a firmware version check to determine when this is
available?  What about mes 12?

Alex

>  union MESAPI__PROGRAM_GDS {
> --
> 2.34.1
>

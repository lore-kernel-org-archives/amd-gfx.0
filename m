Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0C1C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 14:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA1410E046;
	Fri,  7 Feb 2025 14:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P5BnC5Yd";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E768810E046
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 14:23:49 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2fa0f70bfecso380910a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Feb 2025 06:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738938229; x=1739543029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1nq4zRZ7Ms82xQc1su7yxQQ6RSPlgt66iuft1SZsOo=;
 b=P5BnC5Yd4FYo3YlgwEL53HejZb2lprfrPmgpVMcHtqBt9gEoYNJ2HbVdwL3Z7hXvYm
 sjZmA0utNwfpzhwiUNVXGTIxvyji2DhHaK9xrhP/1hKKFAK/AnOvHSF7AYdIL4DlpBz7
 ucnZOVhMFcxKpWW/s7Ae5oi7ZLrJBO5e4b6URfunuNKlEKDWYqnpMAeue83qpFmXKieI
 a3XI/P1ALgdrNDG1p++CgZ8dgEeKnFyCgdCx+PFSqSVz6o2xc38g0uMH6NJ73kLec0VP
 jExXRlJCtiQKFFqV96i85jUmdLCRlN8YW/zfTxsV86QKu584Auaa2qrdB81Wov4y3l0X
 9MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738938229; x=1739543029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1nq4zRZ7Ms82xQc1su7yxQQ6RSPlgt66iuft1SZsOo=;
 b=EiAIHl5uNF7ShTSK37dtdlDX41JL+NM0hpJqrSTWONQZLTOrOjHuvL2jiMfZP+7hNF
 790az65EVfzeY9HE6m5/V8TJ232FU4+cQFdF0E1NbaMvDTvRlMbPvbzpqEzexolDnhJ3
 Q81F0y28I455M6jiM/4uEMSE2/5+HVtHjbLyHQfbOUCdUljCfSveUimKU3IP+pVgFSkv
 i/wWmkfcevHXZ0OrgNQmjuszB4UVgW11lf3oAn197+UOrQ0y/iQUvZThwVdcFEUc1Y2D
 1jdGhyVVo2OZfzKVHc9xNMZjink5I4zCrwaLM2m/heuydkcEd5nhfP2IIvB/iNVbePVB
 xtOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn+6BBC5zqYU9kkkPaGduQJ0Z+pz/xGE/apH9rgZSG7/7Ca86yza/19wVzx405Q4V2S32tnO0F@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJBi4jkgTjbsLlt5waEpWo1kM2nqdkr7Mem8zYGjiHb9xCHLwk
 Wgj25hXlvNlbkC1KQcq5mcS0KyGuD7odyvsB4en0SyC1yN3FRZMZzP5bKZExXmrzWENaFQd6V8Q
 Vip+O85FWVjdzNHvyhHqW0Yd7eYE=
X-Gm-Gg: ASbGncvt9RERM13obsV5iGHBlGs0OA7S/48wgpJVyilf0u63dpB4Sco/2pg8SAXVuqq
 m58ASwWuidTLZP3fV1vASiwpGi8r3nTAu5Pr3g5IfoLT5xwKFYRpmZuoqL1OVOZvxL7mySQqa
X-Google-Smtp-Source: AGHT+IETLFTYKuyeL6Ten6D+tAJuUUztjNwU6na3okAj2j16ZTK3UoOaFR8ptL3aI0FV1UClfCT+pWNA9dp32Z44yMI=
X-Received: by 2002:a17:90b:3e8a:b0:2ee:e518:c1d4 with SMTP id
 98e67ed59e1d1-2fa23f5df75mr2137297a91.1.1738938229355; Fri, 07 Feb 2025
 06:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20250207093003.1098454-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250207093003.1098454-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Feb 2025 09:23:37 -0500
X-Gm-Features: AWEUYZkbVX8YxaFMS9u2cfgZoohDa_htzs9ua7Z768QXzcrhwsryemsSGGXGwpc
Message-ID: <CADnq5_Nx3sJ8jRuXq0mFYukWoOny1JNHnLScFQb73CbDcr_C=g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 lin cao <lin.cao@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>
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

On Fri, Feb 7, 2025 at 5:02=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit introduces enhancements to the handling of the cleaner
> shader fence in the AMDGPU MES driver:
>
> - The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
>   KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
>   that requests are handled in a controlled manner and avoiding the
>   race conditions.
> - The CP (Compute Processor) firmware has been updated to use a private
>   bus for accessing specific registers, avoiding unnecessary operations
>   that could lead to issues in VF (Virtual Function) mode.
> - The cleaner shader fence memory address is now set correctly in the
>   `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
>   the cleaner shader execution. This is done by calculating the address
>   using the write-back memory base address and the cleaner fence offset.
>
> - **Memory Offset Retrieval**: The line `ret =3D
>   amdgpu_device_wb_get(adev, &cleaner_fence_offset);` retrieves the
>   offset for the cleaner shader fence from the write-back (WB) memory.
>   This is important for ensuring that the cleaner shader can synchronize
>   its execution properly, as the offset is necessary to calculate the
>   exact memory address where the fence will be located.
>
> - **Setting Cleaner Shader Fence Address**: The line
>   `mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =3D adev->wb.gpu_addr =
+
>   (cleaner_fence_offset * 4);` sets the memory address for the cleaner
>   shader fence in the `mes_set_hw_res_pkt` structure. This address is
>   calculated by adding the base GPU address of the write-back memory to
>   the calculated offset. By setting this address, the MES (Microcode
>   Execution Scheduler) knows where to check for synchronization related
>   to the cleaner shader, ensuring that it operates correctly and that
>   the GPU is in a stable state before executing new tasks.
>
> Cc: lin cao <lin.cao@amd.com>
> Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2: The checks for amdgpu_sriov_is_mes_info_enable were removed to
>     simplify the resource management logic in the MES initialization and
>     finalization functions, ensuring that the necessary resources are alw=
ays
>     set up and cleaned up regardless of the SRIOV mode, thereby enhancing
>     consistency in cleaner shader operations.
>
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index bf51f3dcc130..2462c9cd5f6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -745,14 +745,20 @@ static int mes_v11_0_set_hw_resources_1(struct amdg=
pu_mes *mes)
>  {
>         int size =3D 128 * PAGE_SIZE;
>         int ret =3D 0;
> +       u32 cleaner_fence_offset;
>         struct amdgpu_device *adev =3D mes->adev;
>         union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
>         memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
>
> +       ret =3D amdgpu_device_wb_get(adev, &cleaner_fence_offset);
> +       if (ret)
> +               return ret;

You need to save this and free it when you free the resource_1 bo.
Better yet, make the resource_1 bo bigger and put the fence in that
buffer.

Alex

>         mes_set_hw_res_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
>         mes_set_hw_res_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
>         mes_set_hw_res_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>         mes_set_hw_res_pkt.enable_mes_info_ctx =3D 1;
> +       mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =3D adev->wb.gpu_=
addr +
> +                                                         (cleaner_fence_=
offset * 4);
>
>         ret =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>                                 AMDGPU_GEM_DOMAIN_VRAM,
> @@ -1632,12 +1638,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         if (r)
>                 goto failure;
>
> -       if (amdgpu_sriov_is_mes_info_enable(adev)) {
> -               r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
> -               if (r) {
> -                       DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=
=3D%d\n", r);
> -                       goto failure;
> -               }
> +       r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
> +       if (r) {
> +               DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=3D%d\n"=
, r);
> +               goto failure;
>         }
>
>         r =3D mes_v11_0_query_sched_status(&adev->mes);
> @@ -1665,10 +1669,9 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       if (amdgpu_sriov_is_mes_info_enable(adev)) {
> -               amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.r=
esource_1_gpu_addr,
> -                                       &adev->mes.resource_1_addr);
> -       }
> +
> +       amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_=
1_gpu_addr,
> +                             &adev->mes.resource_1_addr);
>         return 0;
>  }
>
> --
> 2.34.1
>

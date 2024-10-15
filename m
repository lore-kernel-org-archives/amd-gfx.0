Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3319D216BF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 14:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E1010E597;
	Tue, 15 Oct 2024 14:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MMCKBmqP";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BCFB10E597
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 14:58:19 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2e2af4dca5cso1083766a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729004298; x=1729609098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1r2/hK6rar7EKBtprtvJm1CQFlqcywd68tVaULXWKfI=;
 b=MMCKBmqPxyQ+pcGF0Y8AnFejtvHBlb9Iwu93j6EsKef64L1Sla1jLcCBKGt9EKSsU2
 QnZFWS7vGsaGIlD4Ad8lxjWBPrTMfYocUQahawlG/HEVt3BBr1vNtlNmJV2TKeibX827
 IMdsKs0OCLN51y2HDrGYAQzsGa6jDUrVKgbIQz6m24PqBLRE7cLCFvXxKA90tVrVFu4z
 9WXucWmuSqgJqjsqfLrTNWoUy/9G9Z4byPBOiva/4U2nTI8qq3YXi8f5AcniaYnacydM
 VKimhnYbwlUvYCUiGtviuOst78xfMp7Rrwm0rTfTg4ElN54vFvECqOPrQgrJyZVBGL2f
 5PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729004298; x=1729609098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1r2/hK6rar7EKBtprtvJm1CQFlqcywd68tVaULXWKfI=;
 b=LhlB8p6cxRPAFvQHp2Jff+gAn4SNOSnkKh1qVdqTiW4hGDsGJJ2h9iF+CqKf5kbwfG
 BoDCGJ2R+ZUhFctNpl/tFoiuExO/vGzZMXt51pQuLXJZSjz/StjKXfO4MrMUWvB/7/1l
 p5E/SjiBiEQFGrGwTvrAnGlVf7TkJsa6HD2No5C9q4hhkY2QwLbt4b9scu/clGFf3smP
 EH6+ozUKWeqQJR73kdHILq5b3++Ab+KOUiyJB3XUTVfBnndldZdTWqQ6ndm8cQU9aQj3
 Cpz6+jbnNpx1pgZkxF06n1VzDC+1NPExWKCD3jrVHIJT/LaCrRpERgfjbX80LpU15XDB
 IaDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOxmRlvB27r/RbnnJ9+/gYC3CTkMdLIjVze7AbNpTPI6eKe8/5UjzupLYEY/ylKS82NSt98cmL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkINIrhTeeLRHLPdxRENFpA6yzsXDm3bURNH4YMgxvaENezy3J
 Vsm0Cxf6lhe84tjWfQiK1iATDh/4QHJQdu59KRrBIg/xzCdRo4Kgt7k9ZvVFQwgwjYWv+e2SgsH
 9WJIRHbc2ZtUJbuRGs85qEJGgtfM=
X-Google-Smtp-Source: AGHT+IEqbaU+Ye40oNMZy63Jg3TQGp1W0S7i/L034JcgJTTzRTFAfK1nsXoPfhkLuvbO6iaWbNTI2knlxUuGuh8ijvc=
X-Received: by 2002:a17:90a:fe8a:b0:2e2:ebce:c412 with SMTP id
 98e67ed59e1d1-2e2f0a2fb4dmr7653283a91.2.1729004298388; Tue, 15 Oct 2024
 07:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241010180806.834-1-shashank.sharma@amd.com>
 <BL1PR12MB5144EC6671DD09A36B0BFD0CF7442@BL1PR12MB5144.namprd12.prod.outlook.com>
 <0a06cc8c-b496-45ae-856f-67cd538a2153@amd.com>
In-Reply-To: <0a06cc8c-b496-45ae-856f-67cd538a2153@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Oct 2024 10:58:06 -0400
Message-ID: <CADnq5_P-DgRJg-ainqgWAyDR_1P1DF+RirpkzsDJ-Kc4aHfCTA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable userqueue support for GFX12
To: "Sharma, Shashank" <shashank.sharma@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Yadav,
 Arvind" <Arvind.Yadav@amd.com>
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

On Tue, Oct 15, 2024 at 6:13=E2=80=AFAM Sharma, Shashank
<shashank.sharma@amd.com> wrote:
>
> Hello Alex,
>
> On 14/10/2024 22:29, Deucher, Alexander wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Sharma, Shashank <Shashank.Sharma@amd.com>
> Sent: Thursday, October 10, 2024 2:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>; Sharma,
> Shashank <Shashank.Sharma@amd.com>
> Subject: [PATCH] drm/amdgpu: enable userqueue support for GFX12
>
> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>
> This patch enables Usermode queue support across GFX, Compute and SDMA IP=
s
> on GFX12/SDMA7. It typically reuses Navi3X userqueue IP functions to crea=
te and
> destroy MQDs.
>
> I would like to make this more explicit.  In mes_v11_0_userqueue.c, I wou=
ld suggest splitting out any non-gfx11 specific code into some new helpers =
in mes_userqueue.c.  E.g.,
>
> mes_v11_0_map_gtt_bo_to_gart() -> mes_userq_map_gtt_bo_to_gart()
> mes_v11_0_create_wptr_mapping() -> mes_userq_create_wptr_mapping()
> mes_v11_0_userq_map() -> mes_userq_map()
> mes_v11_0_userq_unmap() -> mes_userq_unmap()
> mes_v11_0_userq_mqd_destroy() -> mes_userq_mqd_destroy()
>
> Initial patch sets had all these functions named similar to 'mes_userq_* =
' only, but later you recommended that we should have mention of _v11_0 to =
indicate the IP specific stuff, as there might be IP specific way of mappin=
g/unmapping/creating and destroying the queues. So with this comment we mig=
ht be going back to the same version.

Well that was before gfx12 support was on our radar.  Generally, you
develop for the first generation and if there are things that you can
pull out into common code and share across generations, then you
should do that when you add support for the next generation.

>
> As of now, v12 UQ was tested using the the same methods as V11 UQs, and f=
ound it functional. We might need more information before taking this step.

You would need to verify that the V11 and V12 MQDs are the same.
EIther way, I would recommend making v11 and v12 variants the the
functions which populate the MQDs that the firmware uses.  There is
alays a chance that the firmware may repurpose some of the fields for
different things that can lead to subtle bugs.  At the end of the day,
I think we'll end up with a bunch of helpers in mes_userqueue.c and
then a function or two in mes_v11_0_userqueue.c and
mes_v12_0_userqueue.c.  Alternatively, you could just put the helpers
in amdgpu_mes.c and the gfx11 and gfx12 specific functions in
mes_v11_0.c and mes_v12_0.c since it will probably only be a function
or two.  You could even add a callback for the MQD specific changes
and add a wrapper like the other functions in amdgpu_mes.c and the
generic functions in mes_v11_0_userqueue.c.  That would make
everything symmetric for mes managed queues.

Alex

>
> - Shashank
>
> However, mes_v11_userq_create_ctx_space() uses the v11 mqd structures whi=
ch may not match the v12 structures.  We should add a v12 implementation fo=
r any functions that use the v12 structures.
>
> Alex
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Arvind Yadav <arvind.yadav@amd.com>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
> drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 6 ++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 9fec28d8a5fc..d511996c374d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -46,6 +46,7 @@
>  #include "gfx_v12_0.h"
>  #include "nbif_v6_3_1.h"
>  #include "mes_v12_0.h"
> +#include "mes_v11_0_userqueue.h"
>
>  #define GFX12_NUM_GFX_RINGS  1
>  #define GFX12_MEC_HPD_SIZE   2048
> @@ -1335,6 +1336,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_bloc=
k
> *ip_block)
>               adev->gfx.mec.num_mec =3D 2;
>               adev->gfx.mec.num_pipe_per_mec =3D 2;
>               adev->gfx.mec.num_queue_per_pipe =3D 4;
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +             adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D
> &userq_mes_v11_0_funcs;
> +             adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D
> &userq_mes_v11_0_funcs;
> +#endif
>               break;
>       default:
>               adev->gfx.me.num_me =3D 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 24f24974ac1d..badcf38bb8b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -42,6 +42,7 @@
>  #include "sdma_common.h"
>  #include "sdma_v7_0.h"
>  #include "v12_structs.h"
> +#include "mes_v11_0_userqueue.h"
>
>  MODULE_FIRMWARE("amdgpu/sdma_7_0_0.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_7_0_1.bin");
> @@ -1317,6 +1318,11 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_bloc=
k
> *ip_block)
>       else
>               DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +     adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_v11_0_funcs;
> #endif
> +
> +
>       return r;
>  }
>
> --
> 2.46.2

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9CACCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 19:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AB510EB00;
	Thu,  9 Oct 2025 19:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JzrXPahV";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D5F10EB00
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 19:16:48 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-269640c2d4bso1902015ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760037408; x=1760642208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zp18NPkpB9kn9tLMCyIgCrNIFh39wvywObQCkrp+KdI=;
 b=JzrXPahVnVOEvt497lKW7E+TWsGG7Z8rL1q+fUVG597ebgiXmFYPmZT4t5kYYqdJ+T
 zVS0xJ1tK+oZ+ZVgBXNO/yf3xEvZueFmcbPJ4dk2XdL/nmhhv1hN+mLBlcgiqiAo4I9n
 Nm4WWp287/SMxwaNuO8WDW3R4+Iu9D1v3rl74TJzPDdOak1dPyCNhXpoTR/p13Q87J2N
 iccE4+CsRMFC5kVz05GFi4u8sKJp3sRRfQlZJcFkVDvaXym5fvtvj/zoblWhFG+HbAYa
 VHW/h4CQNSywE7rPq2GdLVKCX9DttJT4f0/JE8YiD4vPMPLtCXbh1it51bVSnzAiP8wo
 pdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760037408; x=1760642208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zp18NPkpB9kn9tLMCyIgCrNIFh39wvywObQCkrp+KdI=;
 b=lgEfSrbqxXySoLyLcLgykrg9yMw99Vg/X8BxsW+FUjsDTAWwpj3JIBOfJGM1gC5Tpj
 F0M60cYO77DClMf7ZirXMOn+h4cRWkfylSc+brnIhNvP2CZrNEd9FHa65CEFp3VCy6hx
 ERtB7IOYyTKVZqSon1x2ivLKr4/yZCautrGSTo2WYCwYv/e4mlayubhGq91Wd6O7g5wL
 latgoqRntcBjv6uu16b2OL9abChkGIP/gMlBGGSZXWLx9CrIUr6VnYuoGQIQXgb3SFI8
 /DmTpNHhXf9sJHnJqb86gMAhboiAjeLVHVudO7Vlo0Zf0fF8U7tzS+la/MronpN9E9kc
 i50w==
X-Gm-Message-State: AOJu0YwcEYrWzZK1G1SAqmjLq50h3mYkCd4EUWWR70h0gc+sc8FyeLjm
 Q21FQYndGqDwd9tXgtH2L5xqY3XnRnBgcrHAoLFfQfeqSt5si5WSKcKx36djEXzPEJl/Xv87UnI
 m50tt6/ggIovAdX+eMgWdridwSCP6N6I=
X-Gm-Gg: ASbGncvAFvFnj83IwXMuXKe4zt5iMcOLZ+NdHcEUjnnETgiE9umLtzr0CdqnDpUADSu
 8h6y1RAFLYBpkArkDLUiK0YsYrgShYpx0YhOC6I6sVida+2ntfkALqr3EEohgL/buHRjPooGPYP
 yCn426rYEyUr6qHtCJyqBTH23/aE9wCubpoA96zjVrt4IAWD/GCeSir0fy/PutJ5zRpAd3/1D4r
 46nBJNJar6ttF+/xOz57WpBgGogZoU=
X-Google-Smtp-Source: AGHT+IGwKyVQGaoMOWryAbCxTueaDs9TJfgkPotmBH5vdxxBApb8XraZYbIXRYdcakln15jKnd7AbS2QFpqBPCmuhUQ=
X-Received: by 2002:a17:902:f541:b0:276:76e1:2e78 with SMTP id
 d9443c01a7336-29027336d54mr68035385ad.10.1760037407510; Thu, 09 Oct 2025
 12:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
 <20251009184929.1038298-4-jonathan.kim@amd.com>
In-Reply-To: <20251009184929.1038298-4-jonathan.kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 15:16:36 -0400
X-Gm-Features: AS18NWCx2D5y4MgBrm0sbK97E7aR-ymej9qdkHYujXN-ErgEhtzbD537hocbXEY
Message-ID: <CADnq5_Moqk8zHiXyvj7_BfHwH4W3dQqNfvhRQcyj4mw-9tM19Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/amdgpu: fix hung reset queue array return for hws
 user compute
To: Jonathan Kim <jonathan.kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Shaoyun.Liu@amd.com, Harish.Kasiviswanathan@amd.com, Amber.Lin@amd.com
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

On Thu, Oct 9, 2025 at 2:50=E2=80=AFPM Jonathan Kim <jonathan.kim@amd.com> =
wrote:
>
> By design the MES will return an array result that is twice the number
> of hung doorbells it can report.
>
> i.e. if up k reported doorbells are supported, then the
> second half of the array, also of length k, holds the HQD information
> (type/queue/pipe) where queue 1 corresponds to index 0 and k,
> queue 2 corresponds to index 1 and k + 1 etc ...

Has this always been the case?  If not, what mes version changed this?

>
> The driver will use the HDQ info to target queue/pipe reset for
> hardware scheduled user compute queues.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 20 ++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     |  8 +++++---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  8 +++++---
>  5 files changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index c698e183beda..1af3ddb6f65c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -419,12 +419,24 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct =
amdgpu_device *adev,
>         if (r) {
>                 dev_err(adev->dev, "failed to detect and reset\n");
>         } else {
> +               int array_hqd_info_offset =3D adev->mes.hung_queue_hqd_in=
fo_offset;
> +               int array_size =3D adev->mes.hung_queue_db_array_size;
>                 *hung_db_num =3D 0;
> -               for (i =3D 0; i < adev->mes.hung_queue_db_array_size; i++=
) {
> -                       if (db_array[i] !=3D AMDGPU_MES_INVALID_DB_OFFSET=
) {
> +
> +               for (i =3D 0; i < array_hqd_info_offset; i++) {
> +                       if (db_array[i] =3D=3D AMDGPU_MES_INVALID_DB_OFFS=
ET)
> +                               continue;
> +
> +                       hung_db_array[i] =3D db_array[i];
> +                       *hung_db_num +=3D 1;
> +               }
> +
> +               for (i =3D array_hqd_info_offset; i < array_size; i++) {
> +                       if (!hung_db_num || queue_type !=3D AMDGPU_RING_T=
YPE_COMPUTE)

Might be better to move the queue_type check before the loop.

> +                               break;
> +
> +                       if (db_array[i] !=3D AMDGPU_MES_INVALID_DB_OFFSET=
)
>                                 hung_db_array[i] =3D db_array[i];

What is the point of this?  If this is hqd info, then it's not a
doorbell, so why add it to the list?  Maybe drop the hqd array
handling until we actually use it.

Alex

> -                               *hung_db_num +=3D 1;
> -                       }
>                 }
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 6b506fc72f58..97c137c90f97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -149,6 +149,7 @@ struct amdgpu_mes {
>         void                *resource_1_addr[AMDGPU_MAX_MES_PIPES];
>
>         int                             hung_queue_db_array_size;
> +       int                             hung_queue_hqd_info_offset;
>         struct amdgpu_bo                *hung_queue_db_array_gpu_obj;
>         uint64_t                        hung_queue_db_array_gpu_addr;
>         void                            *hung_queue_db_array_cpu_addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 829129ad7bd1..5c63480dda9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -208,10 +208,10 @@ static int mes_userq_detect_and_reset(struct amdgpu=
_device *adev,
>         struct amdgpu_userq_mgr *uqm, *tmp;
>         unsigned int hung_db_num =3D 0;
>         int queue_id, r, i;
> -       u32 db_array[4];
> +       u32 db_array[8];
>
> -       if (db_array_size > 4) {
> -               dev_err(adev->dev, "DB array size (%d vs 4) too small\n",
> +       if (db_array_size > 8) {
> +               dev_err(adev->dev, "DB array size (%d vs 8) too small\n",
>                         db_array_size);
>                 return -EINVAL;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index e82188431f79..da575bb1377f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -66,7 +66,8 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *=
adev);
>  #define GFX_MES_DRAM_SIZE      0x80000
>  #define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)
>
> -#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 4
> +#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] =3D db offset, [4:7] =
=3D hqd info */
> +#define MES11_HUNG_HQD_INFO_OFFSET     4
>
>  static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
>  {
> @@ -1720,8 +1721,9 @@ static int mes_v11_0_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int pipe, r;
>
> -       adev->mes.hung_queue_db_array_size =3D
> -               MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
> +       adev->mes.hung_queue_db_array_size =3D MES11_HUNG_DB_OFFSET_ARRAY=
_SIZE;
> +       adev->mes.hung_queue_hqd_info_offset =3D MES11_HUNG_HQD_INFO_OFFS=
ET;
> +
>         for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
>                 if (!adev->enable_mes_kiq && pipe =3D=3D AMDGPU_MES_KIQ_P=
IPE)
>                         continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index be8a352f9771..79dd2261ad04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -47,7 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *=
adev);
>
>  #define MES_EOP_SIZE   2048
>
> -#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
> +#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] =3D db offset [4:7] h=
qd info */
> +#define MES12_HUNG_HQD_INFO_OFFSET     4
>
>  static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
>  {
> @@ -1899,8 +1900,9 @@ static int mes_v12_0_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int pipe, r;
>
> -       adev->mes.hung_queue_db_array_size =3D
> -               MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
> +       adev->mes.hung_queue_db_array_size =3D MES12_HUNG_DB_OFFSET_ARRAY=
_SIZE;
> +       adev->mes.hung_queue_hqd_info_offset =3D MES12_HUNG_HQD_INFO_OFFS=
ET;
> +
>         for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
>                 r =3D amdgpu_mes_init_microcode(adev, pipe);
>                 if (r)
> --
> 2.34.1
>

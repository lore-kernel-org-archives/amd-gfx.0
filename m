Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C28DD1A631
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 14:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D2510E8D7;
	Fri,  9 Jan 2026 14:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nDCdc0ai";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CB110E8D7
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 14:01:33 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-11f0d900dc4so172730c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Jan 2026 06:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767967292; x=1768572092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYmoAWdHv0KxdJIgtpcGZ9+WdJbDkvUL6WkY8YEOFz8=;
 b=nDCdc0aittu+Z2u6XqSBRIU+rwa4ChH5u3wJzFdNfFBKpQBgtXnQH5gVLzXvpbA19T
 qA0M4tPh87kUkwapQ7PIn6ht0aiKANreMPl5bio2NuZQkAmTxp+z7/XNSv/36DDOEHEN
 pes68Y+8evvqwdLbK4BW7Mxps66XvonNr1CJuIIVrG9+Nl53d4+1W8wOhqBDYr6wt7Wu
 9fzl5MvjAd8SPdN2l53pURqbUKmOqcVc3l8FMMfTSF2paeG2zTUtbtE8XQuD/CETHJKh
 ioea9iA0svq1VxgUwM4b39nk+IQJWlWi+xRXF95vcWBLkSFBy7yoZ+jTMoPjeQ+MqTNv
 X2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767967292; x=1768572092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EYmoAWdHv0KxdJIgtpcGZ9+WdJbDkvUL6WkY8YEOFz8=;
 b=qZwinxzCPbg4h8o1t23N5+XH5z4Jxs6E1XoCJxNSUhkVsWXWWhiee3xBAv/yUiojQF
 PYwlcNzU7H7V9XWytkd/IDciWL0yyY6t5poSD5geCrFol8CVWsskxKTHqBeFu5U47TFV
 vVjp3M6CK8ZpfkhWs+O53NwjdnoU0iZNDSU/gY9hSDlZVtELF/u81CigI73OxByZeDoj
 toY/s+gQs/tXmezhhlXILpKkglvKo438n/WngGkQF9KCOykJnGcp3uNARVIgyEyKAa/y
 9RMef92ELbb5UwkafP1geEyKvvhhtcvmnB/9ceuV2OtUu+DSno92PoAY934ClJXPap4e
 nxpw==
X-Gm-Message-State: AOJu0YwMTuQGzzDUQ74KN3xqdKikFWTytsj/lZsF9oumchWIkdO84iHZ
 x7i3SOH8OGa6Xpea66+y4E9u5Xmqv6XudWIA/3ZX2OAthiqOQNNii5BIVcXryjzdFipGNcxIql4
 APD7A6hhEseRnE++sZtQl8kvMOrTco8o=
X-Gm-Gg: AY/fxX5APuSe8GBP5N7f5AnwquXdGnzCwy8OSKaZNLULXDpulCLVz1JEMBa7jG3KpNv
 qqOS/JEexJnheFdS5ht+km0wCYOzsxZ/GxAdspNtek1k3+qLyYoKfOOPTZ3hAGsG1B93B7cFKPL
 aVnIauxiaSP2skMEk612XqG+g9IHogPCMHrBEPJ1WO8cq4/zuHG11nKIjuZJyc4Gtoumttn8hVb
 QXYOc4wG66NCJG95s8QGwLNkJ4hgb/qsQtQcLE7C1HUtdwozj3CheN1bYtc1Y4lHuq+3hHI
X-Google-Smtp-Source: AGHT+IH4LIL57ZOtwtBYmwzgq9w+hCDu8umpdge51fb4Fl5kvbCUYUQgr8kTCT5FuwvLIuWPeeKwxQzIKJJ0FN1AAKI=
X-Received: by 2002:a05:7022:2211:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-121f8ba1e7fmr5007289c88.7.1767967292211; Fri, 09 Jan 2026
 06:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20260109100936.1163980-1-lang.yu@amd.com>
In-Reply-To: <20260109100936.1163980-1-lang.yu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Jan 2026 09:01:20 -0500
X-Gm-Features: AQt7F2of3MytX5HIUPzJ9DI2Tk5yQD3eL8Iv_J3xsvON9Ukamh5n-HyIeYRjSvM
Message-ID: <CADnq5_Pif1hLBspVqg87ozW-5rV9fkWC16bGJvmT7S9k9AGORQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/mes: Simplify hqd mask initialization
To: Lang Yu <lang.yu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>
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

On Fri, Jan 9, 2026 at 5:09=E2=80=AFAM Lang Yu <lang.yu@amd.com> wrote:
>
> "adev->mes.compute_hqd_mask[i] =3D adev->gfx.disable_kq ? 0xF" is
> incorrect for MEC with 8 queues per pipe. Let's calculate hqd
> mask with number of queues per pipe and number of gfx/compute
> queues kernel used, and get rid of version check and hardcode.
>
> Currently, only MEC1 is used for both kernel/user compute queue.
> To enable more MECs, we need to redistribute queue per pipe and
> adjust queue resource shared with kfd that needs a separate patch.
> Skip other MECs for now.
>
> v2: Force reserved queues to 0 if kernel queue is explicitly disabled.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 59 +++++++++++++++----------
>  1 file changed, 35 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index dffa0f7276b7..bed37e50d45b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -31,7 +31,6 @@
>
>  #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
>  #define AMDGPU_ONE_DOORBELL_SIZE 8
> -#define AMDGPU_MES_RESERVED_QUEUES     2
>
>  int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
>  {
> @@ -89,12 +88,25 @@ static void amdgpu_mes_doorbell_free(struct amdgpu_de=
vice *adev)
>         bitmap_free(adev->mes.doorbell_bitmap);
>  }
>
> +static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe, u32 num_hqd_per_=
pipe, u32 num_reserved_hqd)
> +{
> +       u32 total_hqd_mask =3D (u32)((1ULL << num_hqd_per_pipe) - 1);
> +       u32 reserved_hqd_mask =3D (u32)((1ULL << DIV_ROUND_UP(num_reserve=
d_hqd, num_pipe)) - 1);
> +
> +       return (total_hqd_mask & ~reserved_hqd_mask);
> +}
> +
>  int amdgpu_mes_init(struct amdgpu_device *adev)
>  {
>         int i, r, num_pipes;
>         u32 total_vmid_mask, reserved_vmid_mask;
> -       u32 queue_mask, reserved_queue_mask;
>         int num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) =
: 1;
> +       u32 gfx_hqd_mask =3D amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pip=
e_per_me,
> +                               adev->gfx.me.num_queue_per_pipe,
> +                               adev->gfx.disable_kq ? 0 : adev->gfx.num_=
gfx_rings);
> +       u32 compute_hqd_mask =3D amdgpu_mes_get_hqd_mask(adev->gfx.mec.nu=
m_pipe_per_mec,
> +                               adev->gfx.mec.num_queue_per_pipe,
> +                               adev->gfx.disable_kq ? 0 : adev->gfx.num_=
compute_rings);
>
>         adev->mes.adev =3D adev;
>
> @@ -115,9 +127,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>         adev->mes.vmid_mask_mmhub =3D 0xFF00;
>         adev->mes.vmid_mask_gfxhub =3D total_vmid_mask & ~reserved_vmid_m=
ask;
>
> -       queue_mask =3D (u32)(1UL << adev->gfx.mec.num_queue_per_pipe) - 1=
;
> -       reserved_queue_mask =3D (u32)(1UL << AMDGPU_MES_RESERVED_QUEUES) =
- 1;
> -
>         num_pipes =3D adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>         if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
>                 dev_warn(adev->dev, "more gfx pipes than supported by MES=
! (%d vs %d)\n",
> @@ -126,22 +135,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>         for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
>                 if (i >=3D num_pipes)
>                         break;
> -               if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D
> -                   IP_VERSION(12, 0, 0))
> -                       /*
> -                        * GFX V12 has only one GFX pipe, but 8 queues in=
 it.
> -                        * GFX pipe 0 queue 0 is being used by Kernel que=
ue.
> -                        * Set GFX pipe 0 queue 1-7 for MES scheduling
> -                        * mask =3D 1111 1110b
> -                        */
> -                       adev->mes.gfx_hqd_mask[i] =3D adev->gfx.disable_k=
q ? 0xFF : 0xFE;
> -               else
> -                       /*
> -                        * GFX pipe 0 queue 0 is being used by Kernel que=
ue.
> -                        * Set GFX pipe 0 queue 1 for MES scheduling
> -                        * mask =3D 10b
> -                        */
> -                       adev->mes.gfx_hqd_mask[i] =3D adev->gfx.disable_k=
q ? 0x3 : 0x2;
> +
> +               adev->mes.gfx_hqd_mask[i] =3D gfx_hqd_mask;
>         }
>
>         num_pipes =3D adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_=
mec;
> @@ -150,10 +145,15 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                          num_pipes, AMDGPU_MES_MAX_COMPUTE_PIPES);
>
>         for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
> -               if (i >=3D num_pipes)
> +               /*
> +                * Currently, only MEC1 is used for both kernel and user =
compute queue.
> +                * To enable more MECs, we need to redistribute queue per=
 pipe and
> +                * adjust queue resource shared with kfd. Skip other MECs=
 for now.
> +                */
> +               if (i >=3D adev->gfx.mec.num_pipe_per_mec)
>                         break;
> -               adev->mes.compute_hqd_mask[i] =3D
> -                       adev->gfx.disable_kq ? 0xF : (queue_mask & ~reser=
ved_queue_mask);
> +
> +               adev->mes.compute_hqd_mask[i] =3D compute_hqd_mask;
>         }
>
>         num_pipes =3D adev->sdma.num_instances;
> @@ -167,6 +167,17 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                 adev->mes.sdma_hqd_mask[i] =3D 0xfc;
>         }
>
> +       dev_info(adev->dev,
> +                        "MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub 0=
x%08x\n",
> +                        adev->mes.vmid_mask_mmhub,
> +                        adev->mes.vmid_mask_gfxhub);
> +
> +       dev_info(adev->dev,
> +                        "MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%0=
8x, sdma_hqd_mask 0x%08x\n",
> +                        adev->mes.gfx_hqd_mask[0],
> +                        adev->mes.compute_hqd_mask[0],
> +                        adev->mes.sdma_hqd_mask[0]);
> +
>         for (i =3D 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
>                 r =3D amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs[=
i]);
>                 if (r) {
> --
> 2.34.1
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CA4C0219B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 15:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CDC210E228;
	Tue, 11 Feb 2025 15:23:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nCCX1Mkx";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F110B10E228
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 15:23:46 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2f9b8ef4261so1375743a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 07:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739287426; x=1739892226; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/r1G3WCk/x5cUFcaqEA4CREnsWnh8UnrnMBrpy8FbE=;
 b=nCCX1Mkxsq2m1vx3IT3Jhow2Btw2XMuCJfgBcqzWjgacEASJV2Ufn0D8uVUyonAKqc
 +4d48zczWcVPfTn/kVyOFx1o8CQJ1kRQ7mfC0BrF/Rvdl5ri1CxYCZ9zL73LSv7t8gC/
 Q6Dfh1yuj25I0l5NMA1q2ezuEXAmvy2jX3japQnZnuAO4olXferoVx638OlZ++oARaAG
 nSsGpSkYR5KRx4kTddzL4shxngeZErrCSPwxqUJuZuvndO9sWtt03W/7GfmWPJz5x55y
 ahOIK+Q69MtFIjdvyHoIx7Wo/mIvn5Yx7e82BnrhjvlVZY0mnT2puQjt5pu/Wjaa0Zjt
 AKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739287426; x=1739892226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g/r1G3WCk/x5cUFcaqEA4CREnsWnh8UnrnMBrpy8FbE=;
 b=iBRvCzvv12/izMgp2tc5likGYKCxhudM4Xopk5KReKvjMAII0qDtrv5uedRFCYE4aU
 4dhgoUZx4ZGtcNwvft1lF14pdAH/nuhwauiLFru884w6CIRcJkc8y6cqy7juY9V1VN+O
 aWJubkFxs5HAo3ZlUn+yLNNlHZlcq6CT6IwybIUrTwNDY4f0u0/Bdt6IjUC0kzwFOl+p
 PIC3GwXkLb98R4igTisDfBqANS4wP33BmXqOobRiifgml4Cv+8NZZImjo3m0H2YZMEzW
 8DAmXkrZQ7ak0Wz/L+l46RqNCv5dc9P/r+5Jm+AipE83l66OSZOnaU69Kye4OL9kRJgB
 MfEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG2C/HBtHQeNxVZfzex8C5BnMQlusjKtIm3wZHndg6kZiE2Hxa7VemPP3UHnnlP2/Ub48U0VQp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvJcE6lP/zLUn379Fyi2qLL40oIx2oeFQGU3DIK2f+GwGKyf4o
 cxA8Z8656J73hzprthKcQNxjmZUioBzPCmm1qa+Cyh7Q6rtwmhze3i6Yv07z5rLOuE4dS7AYSU/
 nWzp/OajsjBXhsXy6qA5DrCC8xJJn7h4k
X-Gm-Gg: ASbGncvAnferfYnjV1Vuumf66KRpjCysuWWqNfjEZZNpYrcPpQsHyOKTpII0D5kE5iO
 hsL+t+OmBGcF9lz0YXb/bLszg4pkYX22I0nWwWnhJhFFmN7tyn5OaLu62z0cZeLoiATmE5DPE
X-Google-Smtp-Source: AGHT+IGP7gsnIKcE5h+RuWQFl2IWIK2y9SZMudy8npJC8sZKRAUMM/pIv4Ikm7qJEhSKjJ0z9U+pKNTnmbnsVG29sPE=
X-Received: by 2002:a17:90b:4c0c:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2fa22b99a16mr11348164a91.0.1739287426266; Tue, 11 Feb 2025
 07:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20250210211904.281317-1-alexander.deucher@amd.com>
 <20250210211904.281317-2-alexander.deucher@amd.com>
 <CH0PR12MB53726043385289BEA92AFA2FF4FD2@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53726043385289BEA92AFA2FF4FD2@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Feb 2025 10:23:33 -0500
X-Gm-Features: AWEUYZkgAb8lJPmlbJr96lV7zrbUD-jZsuPA6fPOgpMuEoUjGKiG0TeHq2wNM7g
Message-ID: <CADnq5_MUCe80BCtLmiVoNW+hK55HTr1uzRnWx+XUzgY=gkjaNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX12
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
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

On Mon, Feb 10, 2025 at 8:48=E2=80=AFPM Liu, Shaoyun <Shaoyun.Liu@amd.com> =
wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Why only free the mem when  unified mes is enabled , I remembered that se=
t_hw_resource_1 will also be called in none-unified mes mode .

mes_v12_0_set_hw_resources_1() is currently only called when unified
mes mode is enabled so it makes sense to align the free side as well.

>
> Another thing is eventually we probably should allocate total 129 pages t=
he same as GFX11  (128  for hw_resource_1 and  one  extra page for MES inte=
rnal usage) .  But seems SRIOV still not use that 128 pages, It can  be  up=
dated later when  I update the API for gfx12 to enable that .
>

yeah, we can add that later if we need it.  The current mes 12 packet
doesn't seem to support that feature yet.

Alex

> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Monday, February 10, 2025 4:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.co=
m>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/mes: Add cleaner shader fence address han=
dling in MES for GFX12
>
> This commit introduces enhancements to the handling of the cleaner shader=
 fence in the AMDGPU MES driver:
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
>   the cleaner shader execution.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index dcbc31279f29b..8dbab3834d82d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -678,6 +678,9 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
>
>  static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe=
)  {
> +       unsigned int alloc_size =3D AMDGPU_GPU_PAGE_SIZE;
> +       int ret =3D 0;
> +       struct amdgpu_device *adev =3D mes->adev;
>         union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;
>
>         memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt)); @=
@ -687,6 +690,19 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_m=
es *mes, int pipe)
>         mes_set_hw_res_1_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>         mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout =3D 0xa;
>
> +       ret =3D amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
> +                               AMDGPU_GEM_DOMAIN_VRAM,
> +                               &mes->resource_1,
> +                               &mes->resource_1_gpu_addr,
> +                               &mes->resource_1_addr);
> +       if (ret) {
> +               dev_err(adev->dev, "(%d) failed to create mes resource_1 =
bo\n", ret);
> +               return ret;
> +       }
> +
> +       mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =3D
> +               mes->resource_1_gpu_addr;
> +
>         return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
>                         &mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pk=
t),
>                         offsetof(union MESAPI_SET_HW_RESOURCES_1, api_sta=
tus)); @@ -1770,6 +1786,12 @@ static int mes_v12_0_hw_init(struct amdgpu_ip=
_block *ip_block)
>
>  static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (adev->enable_uni_mes)
> +               amdgpu_bo_free_kernel(&adev->mes.resource_1,
> +                                     &adev->mes.resource_1_gpu_addr,
> +                                     &adev->mes.resource_1_addr);
>         return 0;
>  }
>
> --
> 2.48.1
>

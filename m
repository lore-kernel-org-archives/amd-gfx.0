Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4585EC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 17:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DF010E5B1;
	Mon,  4 Aug 2025 17:01:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M2k2M4s4";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A2410E21B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 17:01:07 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-31f5ed172daso708919a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754326867; x=1754931667; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfNSaJxalEKMOHcxqrcxdFvNTm2gCaP3c9bJOB1TlhA=;
 b=M2k2M4s4xuBsscOeEGDlmEtFHD3uS9aKgrNnTAk9QGaq4jHDc9P8c5CdCd0LVJ/gcH
 FPViYTHAHJfSJ1jIppjRtAVU9XGazdM5B+NMyQGvW8ihtoxeiKWIJVSO1OyPoRdXHS0m
 dsB+XPe52fkSrRVlKhHk8bKcOzbICs2I9MDv1MQRWTbI2f0R+ZPrvvOXrIGXI/eYTQDo
 TycGx/HrDuwWH+2+0sweeQjdzjoPaJKSvGgawRQml/hs+7nSkn1tsQPpD9SEbcVSXDps
 9GkYLl4+Rkd4HbSHGFWqC7XINRoNTCLY6okQ5HNFCIZJ63vwusnJ75vT8T9ASWh42q6H
 dj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754326867; x=1754931667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfNSaJxalEKMOHcxqrcxdFvNTm2gCaP3c9bJOB1TlhA=;
 b=jyjimBhPufBvWUG1SUfvEnyLi2JUJLBXbUlF3Z3CRqtI5t24znRi6rIPL5cas0DP/G
 74NG73cSYfqhjO9oRG3WCQ5mNDEqfuyyL929PofEGAf0Nca3ALw2ZhdW3QpApUvevasy
 Aaut/WznOJQ4xdXL/jH4uBp0Efk1vrfukCidZ/jPZmFJQIf7AT8hQSaXN42O3OQuuhhj
 qBM3b6mCBL8nf0vpVSuU+9P9nliPdKiGfzQDV6Yzhq3RnX1mwQzMzwLbdLaJG0HZojI8
 w+m9fHuJgXixnIgSRz5JyiuRlHreO/aZ2NtVLzycPng90Fk08WxJO+Lc5IZvKVSmo+93
 PZUQ==
X-Gm-Message-State: AOJu0Yz9DpF7m8R3aXAmnHH0Ei7AjdOevz2MPuL9+yQWexm6+l5t+t1U
 zVwl4+GfZgNeh811B5mIHzAHaiUweHIeB2KYngiIBWWEEQuVDDl2oeimwI3AusD+q2JI2fhvbEI
 cisqO3p8tfhiITfHd8sxfg8VwcFMmqfgJaRyF
X-Gm-Gg: ASbGncujTmh4pSGQLElLOmnU6dEIDHdVe+09wu2VcxSwvqMX7myYOv4S3Z9nHa8JWr4
 qUBeQZlak/YYLtZsriUHm8qt8jTc2Hex9ktPSgXWevUKLp/mrZ54lxHxezJ/LUvYulmSh47bH+X
 e9xmt5kJowbaukDx8Y7n9qkv2v3wP1bQW303XSJvSl+1VvkRByJCmjTxeQ/MveTM4SKcyepi3iv
 0NRWYqF
X-Google-Smtp-Source: AGHT+IGtkxjShNABHv9Dy6J5LBr3z61xki5oFnDhzNnKmRZb2Mtz7mPtM+LsSWuSs+nN4++CMxWOnZ5cvFDD7h5SyK8=
X-Received: by 2002:a17:90b:3887:b0:31e:ff94:3fae with SMTP id
 98e67ed59e1d1-321162a2892mr5830398a91.4.1754326866383; Mon, 04 Aug 2025
 10:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
 <20250804084029.863138-3-Jesse.Zhang@amd.com>
In-Reply-To: <20250804084029.863138-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:00:53 -0400
X-Gm-Features: Ac12FXwz0oaBj0HJMnmUq0C_Dja2ipkQdqDHlVRHV8fqz5XwCPU4nw0R71iZi1w
Message-ID: <CADnq5_NypwK4k34mRtoc4AkmTvrfEspGDdqBxsLrL1Z6fvkRUw@mail.gmail.com>
Subject: Re: [v6 03/13] drm/amdgpu/mes12: implement detect and reset callback
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Mon, Aug 4, 2025 at 4:53=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Implement support for the hung queue detect and reset
> functionality.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 37 ++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 6b222630f3fa..29d38aa1897e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -47,6 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *=
adev);
>
>  #define MES_EOP_SIZE   2048
>
> +#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
> +
>  static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -879,6 +881,38 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_me=
s *mes,
>                         offsetof(union MESAPI__RESET, api_status));
>  }
>
> +static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes=
,
> +                                                 struct mes_detect_and_r=
eset_queue_input *input)
> +{
> +       union MESAPI__RESET mes_reset_queue_pkt;
> +       int pipe;
> +
> +       memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
> +
> +       mes_reset_queue_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_reset_queue_pkt.header.opcode =3D MES_SCH_API_RESET;
> +       mes_reset_queue_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_reset_queue_pkt.queue_type =3D
> +               convert_to_mes_queue_type(input->queue_type);
> +       mes_reset_queue_pkt.doorbell_offset_addr =3D
> +               mes->hung_queue_db_array_gpu_addr;
> +
> +       if (input->detect_only)
> +               mes_reset_queue_pkt.hang_detect_only =3D 1;
> +       else
> +               mes_reset_queue_pkt.hang_detect_then_reset =3D 1;
> +
> +       if (mes->adev->enable_uni_mes)
> +               pipe =3D AMDGPU_MES_KIQ_PIPE;
> +       else
> +               pipe =3D AMDGPU_MES_SCHED_PIPE;

I think this should probably always be AMDGPU_MES_SCHED_PIPE.  Setting
this may fix the issues you were seeing on gfx12.

Alex

> +
> +       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> +                       &mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt)=
,
> +                       offsetof(union MESAPI__RESET, api_status));
> +}
> +
>  static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
>         .add_hw_queue =3D mes_v12_0_add_hw_queue,
>         .remove_hw_queue =3D mes_v12_0_remove_hw_queue,
> @@ -888,6 +922,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =
=3D {
>         .resume_gang =3D mes_v12_0_resume_gang,
>         .misc_op =3D mes_v12_0_misc_op,
>         .reset_hw_queue =3D mes_v12_0_reset_hw_queue,
> +       .detect_and_reset_hung_queues =3D mes_v12_0_detect_and_reset_hung=
_queues,
>  };
>
>  static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
> @@ -1793,6 +1828,8 @@ static int mes_v12_0_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int pipe, r;
>
> +       adev->mes.hung_queue_db_array_size =3D
> +               MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
>         for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
>                 r =3D amdgpu_mes_init_microcode(adev, pipe);
>                 if (r)
> --
> 2.49.0
>

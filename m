Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58FDEE49A5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 13:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4073610EA1F;
	Wed, 11 Sep 2024 13:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i/NZZQVJ";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A0510EA1F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 13:46:38 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-20530659f78so3162185ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726062398; x=1726667198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FDoK4Za/mpszlmEA4QGE1kawVBDZbRGhae2hu1DUnc=;
 b=i/NZZQVJVNGuTipotbq6aMO6p1FToqBPwXXCIGFFHu1N5D4ztyueB8MwXFeZB1O6Fa
 wwITwOHhpn6Zl6dVLCT8RiIIFx/1BJKKseeynPoNV0AZm1HeiDw6vz7tH/7GUENPyAWk
 Igzu5zut5xDLooHYWPGA++mcrFv2Apzhn1+Q2xeoKUwcSoCCSa+ZtesZuw+BuUJiD32D
 ScaPwHKHujnzHRqgfA3WbVRm97nYnQ89AeOhoj9k9oW5OyeVveS1wJlk1b7iRzUplGPa
 r8SiZk+wbXX0EHrY1NtjniJmnwIA1cMJE1QwAZrUgX5UGnEt3WeEPNYvj9mUD5ZNkR0Y
 ZR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062398; x=1726667198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FDoK4Za/mpszlmEA4QGE1kawVBDZbRGhae2hu1DUnc=;
 b=AqrOIH3x3fCrUDI3Wpc/JKGQz+Wq2+Gp504yPrIWJUrYj2+9/recoFSaAtyV0jkxCL
 PupYyCGsOcCZ6EQadSX7ChficbVMhMFsG+nmKNrkqOJxd3AaIJz1PePx8l2K1Bi+V4+I
 wCnOdLLBpEGtXd/yTgY81IPxL/StMswyHp5MsxbZUOwQrKnd+gTq1NypWjjDM5IR/wsh
 YSRLzChA34glreseRpLUHh7Dv/I0iW515Z4cz/p01RUhWjhdCsWBfEKtTj16WdN1SU+1
 A6r9Pux1Ua/Ix7lCBfA10YcagfrQ4aXTDbIJVzcTO5cLbJkOwc2HDzsN3SCLkjAYoYb8
 VXyg==
X-Gm-Message-State: AOJu0Yw/t71+gPBqckUea4VT3BSZMFd3uYuRqlonzTNdwbQVILrNWChk
 RmwUTkjTfPBYKaN2cNcGbwmDl2I9+qkaDmX3NmrT/6iwb7RQuQCwnwAMldgk1CbcJtCCd5GMMhO
 cPLRE1xV1aWm0ufCR9pZ5SDaueazlgw==
X-Google-Smtp-Source: AGHT+IG0z4cRtwCTL1qxXdglHh4RxQpFBhfhqClBgOlJbFTJZII5Zx6Yfr60ZpmN2RBcEmTqeLismklT7tvftLmwmHo=
X-Received: by 2002:a17:902:da82:b0:205:60f5:4c0 with SMTP id
 d9443c01a7336-2074c5f8481mr25968515ad.9.1726062397533; Wed, 11 Sep 2024
 06:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240911083458.4109430-1-Jack.Xiao@amd.com>
In-Reply-To: <20240911083458.4109430-1-Jack.Xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Sep 2024 09:46:26 -0400
Message-ID: <CADnq5_MX9sGCYQGCzL8RLFN8dUgzaFDF7OLfxGGvNAHnDiup3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes12: switch SET_SHADER_DEBUGGER pkt to mes
 schq pipe
To: Jack Xiao <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Hawking.Zhang@amd.com
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

On Wed, Sep 11, 2024 at 4:48=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wrote=
:
>
> The SET_SHADER_DEBUGGER packet must work with the added
> hardware queue, switch the packet submitting to mes schq pipe.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index e499b2857a01..ef05a4116230 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -479,6 +479,11 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
>         union MESAPI__MISC misc_pkt;
>         int pipe;
>
> +       if (mes->adev->enable_uni_mes)
> +               pipe =3D AMDGPU_MES_KIQ_PIPE;
> +       else
> +               pipe =3D AMDGPU_MES_SCHED_PIPE;
> +
>         memset(&misc_pkt, 0, sizeof(misc_pkt));
>
>         misc_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> @@ -513,6 +518,7 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
>                 misc_pkt.wait_reg_mem.reg_offset2 =3D input->wrm_reg.reg1=
;
>                 break;
>         case MES_MISC_OP_SET_SHADER_DEBUGGER:
> +               pipe =3D AMDGPU_MES_SCHED_PIPE;
>                 misc_pkt.opcode =3D MESAPI_MISC__SET_SHADER_DEBUGGER;
>                 misc_pkt.set_shader_debugger.process_context_addr =3D
>                                 input->set_shader_debugger.process_contex=
t_addr;
> @@ -530,11 +536,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
>                 return -EINVAL;
>         }
>
> -       if (mes->adev->enable_uni_mes)
> -               pipe =3D AMDGPU_MES_KIQ_PIPE;
> -       else
> -               pipe =3D AMDGPU_MES_SCHED_PIPE;
> -
>         return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
>                         &misc_pkt, sizeof(misc_pkt),
>                         offsetof(union MESAPI__MISC, api_status));
> --
> 2.41.0
>

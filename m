Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC11AC83F37
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 21:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC9810E070;
	Thu, 31 Aug 2023 21:25:25 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC2710E070
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 21:25:23 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a9b41ffe11so766729b6e.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693517123; x=1694121923; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6UhV5WIu/1pZ3N0t2CiL5ZMRroglltONsQCnHvd9ac=;
 b=J5frm9Fw1T/ksWRSkCeNqYZRWaIY+EkVS8Eg3B4JivKFYYRYqvCEkGCZ7k8d9dv8uX
 y2eJfHRqhzVEEsICsQ6luCvKeGnnXXWqzFAZwLJaye+oovATi8T4bh0hANPaYU6MuwXz
 ecmdPCZ1uXhF24cbJzeiTJZdxgDK2SzOhPd/ajdI7qs8L1nTYW8gH8uKHo/TptukZX1O
 1ogariTj51VNOwg3hzVbnOp9DpY1NrWMl3mhWe4uIiaM0QqTjJxfzndCjA6csuqmqRTK
 DRXlWMO+f88cckVJwcBEkFmANjbQRNBvH+y4u8uOKqsa9F8DMQ8K2gO3qw1U0GJ+kOto
 b8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693517123; x=1694121923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6UhV5WIu/1pZ3N0t2CiL5ZMRroglltONsQCnHvd9ac=;
 b=NdXapBVnQcJXKD3c8QpUpU7sALR4HPGE21xCaYOSWM1kvbbtda6bw0bgf/U40rky+L
 618a2kIhajL2geGuPgtyV/H+/wxeVExc13WcxDLcOAH9j6V1CJzsZVUYh0lMwhNawNI6
 eUcdJKV8SwgICTFz0t0t2YYcbANxXHyu7x7FfQa5og6cX+Z2iG6tlmVli89Ol4/7D1yr
 6d1zsBoXPowd6AmikSeV5GIiMQxcofjXrTUqC+bApnDuyIHC0tEnuQrpzbjw9r47i0+o
 ZQJD7gcf59C8AiNzF4ANneTO2RrJvPjaz0Rnl4vqIM9KazvrnmPgUHWw1pOdEymEA2CB
 XVwQ==
X-Gm-Message-State: AOJu0YwvHSSJ5raTovnmnGKujfNu8wwcJPTE14MawEgElH+TNxW2NlVj
 Br9r5ySrNUZJI+XWjKIl35LKa5r9sfpWwwbqasA=
X-Google-Smtp-Source: AGHT+IH7CZlrfaqVxsRnhZqGdAObdoAl0sXrAivoTKprdvCj9xJkOr2ovmxE19S1zIarMHotb7UmZdUcol4cfjpvzg8=
X-Received: by 2002:a05:6808:f91:b0:3a6:febf:e1 with SMTP id
 o17-20020a0568080f9100b003a6febf00e1mr889388oiw.55.1693517122697; Thu, 31 Aug
 2023 14:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230831210419.104784-1-timmtsai@amd.com>
In-Reply-To: <20230831210419.104784-1-timmtsai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 31 Aug 2023 17:25:11 -0400
Message-ID: <CADnq5_NK4Jz64jbSR+p2Ugph1J5MABN10TgGWcQvQ_gvU9UeDg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd : Add HDP flush during jpeg init
To: Timmy Tsai <timmtsai@amd.com>
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

On Thu, Aug 31, 2023 at 5:20=E2=80=AFPM Timmy Tsai <timmtsai@amd.com> wrote=
:
>
> During jpeg init, CPU writes to frame buffer which can be cached by HDP,
> occasionally causing invalid header to be sent to MMSCH.  Perform HDP flu=
sh
> after writing to frame buffer before continuing with jpeg init sequence.
>
> Signed-off-by: Timmy Tsai <timmtsai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0.c
> index 3eb3dcd56..27efba2da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -33,6 +33,7 @@
>  #include "vcn/vcn_4_0_0_offset.h"
>  #include "vcn/vcn_4_0_0_sh_mask.h"
>  #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
> +#include "nbio/nbio_4_3_0_offset.h"
>
>  #define regUVD_JPEG_PITCH_INTERNAL_OFFSET                  0x401f
>
> @@ -468,6 +469,15 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_devic=
e *adev)
>         table_loc =3D (uint32_t *)table->cpu_addr;
>         memcpy((void *)table_loc, &header, size);
>
> +       /* Perform HDP flush before writing to MMSCH registers */
> +       WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE, 0x0);
> +       WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ, 0xFFF);
> +       if (SOC15_WAIT_ON_RREG(NBIO, 0,
> +                       regBIF_BX_PF0_GPU_HDP_FLUSH_DONE, 0xFFF,
> +                       0xFFF)) {
> +               DRM_ERROR("Failed to flush HDP during jpeg init\n");
> +       }
> +

You can just call amdgpu_device_flush_hdp() here.

Alex


>         /* message MMSCH (in VCN[0]) to initialize this client
>          * 1, write to mmsch_vf_ctx_addr_lo/hi register with GPU mc addr
>          * of memory descriptor location
> --
> 2.34.1
>

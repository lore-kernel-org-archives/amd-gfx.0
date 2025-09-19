Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87D3CAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 20:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EDD210EA90;
	Fri, 19 Sep 2025 20:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="feiSOcoA";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809CB10EA90
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 20:26:06 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-32b96f83238so219064a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758313566; x=1758918366; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2edYhbkWGqwE5JWh+sQ/IR569CXWjL8McOb76y7BJk0=;
 b=feiSOcoAXvdlAzdF1124oDCEzdD4wSGCB4NI9g6O3dqefQaAaU5CF4zOKgUORulkuI
 ldpeczkkG0peQUiFYlKOO7GOqBY0dPSBpm9ymNjtllk/kNzNLqRkIutOwPfEMYBYId9Q
 y4TqJRcOrOzF3pi0anivPXuONYddKTSgCsQHoy9c2EoRq5VADDCrQYzmBbOcYcd5JqLr
 9Ac/9ogxPafTAN29diojCXzy6byXem6Lq3nd43uFCCG1C5iyo7AHuY3GnS3Jg8y3DGfQ
 9Bgu/0C0PRaXDNQaorOPmfZV30/f6+qoGXVkRAfeAZ1M8tEQSlL29PzUhSgBeEpPVec7
 xjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758313566; x=1758918366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2edYhbkWGqwE5JWh+sQ/IR569CXWjL8McOb76y7BJk0=;
 b=FuOhqB8u3Fty6ytIZEl1XIlYypm5Gx13nk3I2iguARA0SM2NjnDVjYAGjHkvhYjBWS
 mceIghEgq/LCeOOneP/Z/Zww1UquL5PLL+vwSczGbvCdqQoGdOMQ7j8i0d/RoPsCGvdO
 azA8wMTNVKeprkVnQb5+i/UFibB5AnKQCRiKUYdtdXLtUnJuyjhZSNPrVJNA3oK5riIx
 KmoFWKPEiY/E7VGzoRJC64boUzNNqXCrd1G6ggUZaBtTy1aqb+2FGrkMleoSBVXOeAxP
 bZrqpp9vG1w/wD32NCKe54vu+0Nc8sYqha9bwmG34VA7rDR6eNy6L5npVigQiKrUryEA
 Jz4Q==
X-Gm-Message-State: AOJu0YzM4IfThNvhv3zlIYaiIJl9y8Uqy3m3eaZGAEVdxsWtNDgL4Wi/
 g9X/cMdFRY4MR5sxKLxrVtow1srN6X2+jjIfxLDeNGyh4m2beFrlsJbyLI14WeXYbDtaDuIpVJT
 1pa0k8vp2nWMNYw6joKriQr19QvM27dtWFA==
X-Gm-Gg: ASbGncsDf5siWHAPbqlsPWgIsY0jWZ/TCV5mkpa3xRCeOj/g/eB6VJxOSTe24UTyNhA
 4sS+A/Uvg4hqr1LnnSWcMEIjGjqiEvllhUMKSCfNS+oTcSZq/9nK/eEZp4EUpn+CsK4+abXUQXI
 AUQ2NykfiNww0Vb05oc6XJn6mekySdCLpe/bMlvT0U4xDgDHR84pJpFDJWeRJXAn9K7KG/NViNg
 QONKOY=
X-Google-Smtp-Source: AGHT+IFPTauJLfwbMYRp5G0+GiqbI/JkG3LPvX1ieLglMQd3ladjzSwkQdEJbWbPTd2ZNdAek1DaIrlLY3fKcvR+rAg=
X-Received: by 2002:a17:90b:4c88:b0:32e:4924:68f8 with SMTP id
 98e67ed59e1d1-33097ff4c7bmr3025423a91.2.1758313565923; Fri, 19 Sep 2025
 13:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250919064613.2786008-1-Prike.Liang@amd.com>
In-Reply-To: <20250919064613.2786008-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Sep 2025 16:25:53 -0400
X-Gm-Features: AS18NWC9V83BsJrVcppHLGppdZixIUGILWUed2JSH-CMOiPQC9vV9hCReaKhcfA
Message-ID: <CADnq5_PD2SJQRNsKoFHuKXkpHMbYfuC5Z4Rczp=e4EH8v=8rMw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: assign an error code for invalid userq
 va
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Fri, Sep 19, 2025 at 2:54=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> It should return an error code if userq VA validation fails.
>
> Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual
> address and size")
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 5ab4ee26b825..3bbe1001fda1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -71,6 +71,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm=
, u64 addr,
>                 return 0;
>         }
>
> +       r =3D -EINVAL;
>  out_err:
>         amdgpu_bo_unreserve(vm->root.bo);
>         return r;
> @@ -508,6 +509,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>         if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va,=
 args->in.queue_size) ||
>             amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, =
AMDGPU_GPU_PAGE_SIZE) ||
>             amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, =
AMDGPU_GPU_PAGE_SIZE)) {
> +               r =3D -EINVAL;
>                 kfree(queue);
>                 goto unlock;
>         }
> --
> 2.34.1
>

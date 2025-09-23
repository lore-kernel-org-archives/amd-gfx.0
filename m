Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4B6CAC5AC
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 13:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A991410E608;
	Tue, 23 Sep 2025 13:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B5dXeJ6a";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFDF10E608
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 13:36:43 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-269640c2d4bso8527255ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758634603; x=1759239403; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otEaU7DbSu5fwFG5V/7FjxemXZE8s6t2JHSkmpcGOYg=;
 b=B5dXeJ6af0EZI9UnnpDChTK0htlnNMr0Peh3XoD1duVU2M9N9kwbj2JgrzCdxSbGws
 dp5CPqIuz+Tuw1HB+4qK9ADUfKJ2LrIqKe91oqxGlONa0kcM8ZgzdrAI/CqF7uwdEuac
 VrNUDa/riyUAbqTFsTKr3/fdYqzEXqQxRbAZuaDzhxsradidYdqWPqn8UrobSuTfmgID
 DK/+hxEFKu0DdLZqKAAYGi8SJstAXZcRKhQXrcyQeEGw1yDTPRIpNU71qjiyRXKRBDM2
 7mpqhmGtd22ZMS8e6lZJRLsuKw1ykFA7Wz93slDhXw19UJXoSPUznKuAqOLhMobYlqh6
 JTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758634603; x=1759239403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otEaU7DbSu5fwFG5V/7FjxemXZE8s6t2JHSkmpcGOYg=;
 b=UpMiP8e3dPnPPvi2DS/VBIUGnGdURjVbq4cGiU+6XKO+96rgykvPam5yi5+bIs47pK
 wzDtwKDTNZVos587y5PiVGTy9lIuFShZGti+uBc/g1mYsC5dvRff/gY068m04zNnhVVH
 jDf/4CgMZoY5m5bHH3bD8X0ghxJrht7EH14kZDwcSACzgb4qfIF2JXQ8rZgl9O1HSqYB
 LRMCrkhFe6cCRChSWgtVJauyJBYGU0VUCd3V0ItpTcrbLIuFaGMCBl6HmKG2PUyeZHaG
 i0hXoCeAez0TX9Vt4sR16akQ74nXRGNBVbNvQxFXQXFcrzM5+HCLb3AL4MfYxv+md8yb
 zX4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwt2ovH72zcBtGQCAm+BjS30ZiU6+Y+nmzbxhmBKK72HEmmykN7GBClSicZyOhCJ8uQZuIEf9a@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcjdPod72EGpsmRNfn8/vrBX2FEyYf4+j2glCYEUINznvMjYdD
 ZCugMVBywToQhUhzkAPOk2nqtYKHK9Rcszs4/Trb5XNaX4emQHICAl99CWyIOOGhOYZ32/fARFT
 lPLAAwRkBb2r207mdtvWXnbJ8Ys+COCA=
X-Gm-Gg: ASbGncsmh7NzWh/u7XG2DFa7py73Yz+9gKjYPnxrZJ1wrBHkSwwvf2lxVepwpw4f096
 2nzhqdszt761CN5N361MiU2NgWFOVApIDpUPKfJVd+y0CoNUw2BPiP8GG3oX8NikKxv/9EzWGaH
 uYwtAWYDZchhXLRK0dChU2zKRCmVj/3Q1/oMVyVEe/EJx1eqI4pdoFbTEVIG54kpXTiU3UThyEK
 5wpWKQ=
X-Google-Smtp-Source: AGHT+IEpMUnFXWyxsGB8ZxBMeAgGcPFPwTVhymkxn7e8U0JVLQYauOQtEeX79IdV3W2++0+E8uyLhuiu+eoxowxoku4=
X-Received: by 2002:a17:903:110e:b0:269:80e2:c5a8 with SMTP id
 d9443c01a7336-27cc94ca027mr20584185ad.7.1758634603040; Tue, 23 Sep 2025
 06:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250923131025.3268-1-christian.koenig@amd.com>
 <20250923131025.3268-2-christian.koenig@amd.com>
In-Reply-To: <20250923131025.3268-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Sep 2025 09:36:29 -0400
X-Gm-Features: AS18NWBvgRQTQzsYGMXmbi7gKTRZi1u_ALTmOBbcxYIcnYkniUf460M3nrHAjG0
Message-ID: <CADnq5_O009VC72EmULoc=EbRN==8YTRpSgKfGWq8UpXsgSGm=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: block CE CS if not explicitely allowed by
 module option
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: alexander.deucher@amd.com, Marek.Olsak@amd.com, timur.kristof@gmail.com, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Sep 23, 2025 at 9:19=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The Constant Engine found on gfx6-gfx10 HW has been a notorious source of
> problems.
>
> RADV never used it in the first place, radeonsi only used it for a few
> releases around 2017 for gfx6-gfx9 before dropping support for it as
> well.
>
> While investigating another problem I just recently found that submitting
> to the CE seems to be completely broken on gfx9 for quite a while.
>
> Since nobody complained about that problem it most likely means that
> nobody is using any of the affected radeonsi versions on current Linux
> kernels any more.
>
> So to potentially phase out the support for the CE and eliminate another
> source of problems block submitting CE IBs unless it is enabled again
> using a debug flag.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 +++++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 2a0df4cabb99..6f5b4a0e0a34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1290,6 +1290,7 @@ struct amdgpu_device {
>         bool                            debug_disable_gpu_ring_reset;
>         bool                            debug_vm_userptr;
>         bool                            debug_disable_ce_logs;
> +       bool                            debug_enable_ce_cs;
>
>         /* Protection for the following isolation structure */
>         struct mutex                    enforce_isolation_mutex;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 744e6ff69814..322890e2c899 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -364,6 +364,12 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *=
p,
>         if (p->uf_bo && ring->funcs->no_user_fence)
>                 return -EINVAL;
>
> +       if (!p->adev->debug_enable_ce_cs &&
> +           chunk_ib->flags & AMDGPU_IB_FLAG_CE) {
> +               dev_err_ratelimited(p->adev->dev, "CE CS is blocked, use =
debug=3D0x400 to override\n");
> +               return -EINVAL;
> +       }
> +
>         if (chunk_ib->ip_type =3D=3D AMDGPU_HW_IP_GFX &&
>             chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
>                 if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index ece251cbe8c3..3b3fc734c0f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -144,7 +144,8 @@ enum AMDGPU_DEBUG_MASK {
>         AMDGPU_DEBUG_DISABLE_GPU_RING_RESET =3D BIT(6),
>         AMDGPU_DEBUG_SMU_POOL =3D BIT(7),
>         AMDGPU_DEBUG_VM_USERPTR =3D BIT(8),
> -       AMDGPU_DEBUG_DISABLE_RAS_CE_LOG =3D BIT(9)
> +       AMDGPU_DEBUG_DISABLE_RAS_CE_LOG =3D BIT(9),
> +       AMDGPU_DEBUG_ENABLE_CE_CS =3D BIT(10)
>  };
>
>  unsigned int amdgpu_vram_limit =3D UINT_MAX;
> @@ -2289,6 +2290,11 @@ static void amdgpu_init_debug_options(struct amdgp=
u_device *adev)
>                 pr_info("debug: disable kernel logs of correctable errors=
\n");
>                 adev->debug_disable_ce_logs =3D true;
>         }
> +
> +       if (amdgpu_debug_mask & AMDGPU_DEBUG_ENABLE_CE_CS) {
> +               pr_info("debug: allowing command submission to CE engine\=
n");
> +               adev->debug_enable_ce_cs =3D true;
> +       }
>  }
>
>  static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned=
 long flags)
> --
> 2.43.0
>

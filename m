Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF0DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 21:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D518C10FAC5;
	Wed, 15 Dec 2021 21:38:14 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477D710FAC5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 21:38:14 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 u18-20020a9d7212000000b00560cb1dc10bso26520108otj.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 13:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+wGfUrNbEDt3XV8f+PFGjh1XT7laacFOrlHGKe5bZBs=;
 b=q6I79TbSMC6dYTkveim70ikUo2CyhRdPOhltscajC54CM+v93JT+NMOdKj74K+VRQ1
 ZdaIBDcBfVeQL2VOe9Pal7e80SwA8wyE2jt7qRXGy4Ng+HSHIZocuWOcDdcv2M2JM21b
 mdMf2Uofblr4l5vdZFbbVcuaYTqgLK836GM8UjVb8RuKjImNbUHxFYxMeleMa4qfZVHY
 wrHpcdLbAQM+6iQZ9lzRrfXdTFKgt7K4rP+Qg54NrIJKA/Fi+uUrdpS20yB6FI/2vI09
 hv65nys2YQ9gB3lSEMZ4I//IH3Sr3EAiiDxhjVuGGqYPvnmO0PRNpi6Vnrk/EHsiGehh
 A9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+wGfUrNbEDt3XV8f+PFGjh1XT7laacFOrlHGKe5bZBs=;
 b=Ppr9cZch2xrXzIxDkI3bOZOFfOUtT9IIYbDlVSYkUIqq8cMxQaWHVfwfKi1t3rFl9t
 uqBbo6Gs6SLUdIR0kDXOCx4xMZyi7LB6xoy/PeEkNtWBCXiCCO0x3ADXuk4L1GHniaQE
 xZz0U1ccFpUGdnUG+sJSW/Y4r1agBO1l2CCL+qOjKnofgoU3S5TyGYrti08Rq9m1R0Wh
 SaOLgvA3Ms3LlbbuqlLjPiXv4uTMxxf2dYEVhSei0JYrC5b0v7bIjnbcsP6hwEZ32koN
 F8SUT37iOvs8yEqUUmBtYu/Mm4pX2uDyE+L1PvRsaCVyIzK/C/9zAGkqtWVGdc4imr8X
 Q7ow==
X-Gm-Message-State: AOAM533zuNrgAsG9KfjaM9yEL/VjYxVg1pspc4Uf7cmlR1ZyisNLBvsW
 mp84XYlVv/utbsd2OyV9vU7B2eYmA/5WJFrV06ydpdGevE0=
X-Google-Smtp-Source: ABdhPJy4xWQDuwTbFjr1KgFye6k7lSsZT9v5QnPsEDEp/tNwrhYY2j4LTsOji58ssEcqHR6844w+QXE2gqzSvkkn5Y0=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr10574300oto.357.1639604293568; 
 Wed, 15 Dec 2021 13:38:13 -0800 (PST)
MIME-Version: 1.0
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
 <20211215185510.15134-5-victor.skvortsov@amd.com>
In-Reply-To: <20211215185510.15134-5-victor.skvortsov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Dec 2021 16:38:02 -0500
Message-ID: <CADnq5_OP0=TCPcMprrqFo4HxkXWsZamXkLHa25ZWPEMezM1c_Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function pointers
To: Victor Skvortsov <victor.skvortsov@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Davis Ming <Davis.Ming@amd.com>, Jingwen Chen <JingWen.Chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Emily Deng <Emily.Deng@amd.com>,
 "Nieto, David M" <David.Nieto@amd.com>, Horace Chen <Horace.Chen@amd.com>,
 "monk.liu" <Monk.Liu@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 15, 2021 at 1:56 PM Victor Skvortsov
<victor.skvortsov@amd.com> wrote:
>
> In SRIOV, RLC function pointers must be initialized early as
> we rely on the RLCG interface for all GC register access.
>
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 3 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h         | 2 ++
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 65e1f6cc59dd..1bc92a38d124 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -844,6 +844,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
>         case IP_VERSION(9, 4, 1):
>         case IP_VERSION(9, 4, 2):
>                 amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
> +               if (amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
> +                       gfx_v9_0_set_rlc_funcs(adev);

amdgpu_discovery.c is IP independent.  I'd rather not add random IP
specific function calls.  gfx_v9_0_set_rlc_funcs() already gets called
in gfx_v9_0_early_init().  Is that not early enough?  In general we
shouldn't be touching the hardware much if at all in early_init.

Alex

>                 break;
>         case IP_VERSION(10, 1, 10):
>         case IP_VERSION(10, 1, 2):
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index edb3e3b08eed..d252b06efa43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -816,7 +816,6 @@ static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offset,
>  static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);
>  static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);
>  static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);
> -static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
>  static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>                                 struct amdgpu_cu_info *cu_info);
>  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> @@ -7066,7 +7065,7 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)
>         adev->gfx.cp_ecc_error_irq.funcs = &gfx_v9_0_cp_ecc_error_irq_funcs;
>  }
>
> -static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
> +void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
>  {
>         switch (adev->ip_versions[GC_HWIP][0]) {
>         case IP_VERSION(9, 0, 1):
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> index dfe8d4841f58..1817e252354f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> @@ -29,4 +29,6 @@ extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
>  void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
>                            u32 instance);
>
> +void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
> +
>  #endif
> --
> 2.25.1
>

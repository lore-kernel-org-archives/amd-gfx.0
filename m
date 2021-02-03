Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF718C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 16:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D1064F84
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 16:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D1064F84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D666D6EB3F;
	Wed,  3 Feb 2021 16:57:08 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD016EB3F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 16:57:07 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id w124so556734oia.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Feb 2021 08:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L1jzdLQDSS5XSA3l1fJXdp9sZHIabBfG6o2SjhCA2SQ=;
 b=RlYRLrChR0nNfJicF/vtARFfKpe9xwug5By88Ac2tXgXsOflOMZtp4MzbEAeKUqneJ
 x8lQUn894FMEylgCCP675f2Up1s9x+9dSsi7efEAxGQTLZ/Xeb0v3BEcye981Pa9U9bC
 4Afn28arVz+kNQJCK0bYOAVPgFfHdRVUW57COuYywBnqRh/lLl0aowsAs9tuHP7L8Kk7
 qd04RmEw6jWE1vWntqzhkWIF/fGew90pHtWJEgR/DILVUve3b66t2cVysrPrUYl+mgQs
 +FeNXLA8rkiLpGEvxc9R8ygxPCZBCnKumrmc0PaFhWH4DXQOuywHPzNOt7aHS3MU2FM2
 b23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L1jzdLQDSS5XSA3l1fJXdp9sZHIabBfG6o2SjhCA2SQ=;
 b=GiS9ht4+TCxHNGAbB9giqRg/juohMz+/8ygZwwx8c5W8PTOdPOPa8C22xucUzAlF6/
 +SBTwPOQ5w0umC6EmMVY7a1yWqvIP3usN9HewtKEUawikeAfyq9KNbwvdgfWIha5o7Ug
 TQghAqiFigvMa8b8l6fvts1qWsZ/4FHILLWk3h7p5XdoreCI88ocpCFqhI8YaUQZ+ohk
 Ba+DgicOjbUrmnTYuqQ6v2pDYhiK9xyt8gSXdeSHkeOO8j7867eaAZgxfEcRVd4mSbpO
 hA2DvwfJLVzm+24DKQzpDxQiqM/TfJ4COirnGyheuNcpeIZ12EZb6U4TtH7/edq7tvLg
 CMSA==
X-Gm-Message-State: AOAM530DOkFApPGpEyv7mtWLKwKLLGoK45/SC/IefkKsKiZjlMXL9FVO
 Je+H/7lUfvWNV2EQhptclC/q+vc343E6dp2qKsw=
X-Google-Smtp-Source: ABdhPJxVjZQ2+TM+Ozez8NIuPXRhC1TilorIgHUOhbnNwckT8dnYE/9O/npqmWNOabDfoS/tap+n/oCROtrt70VtHTI=
X-Received: by 2002:aca:1a17:: with SMTP id a23mr2575575oia.120.1612371426935; 
 Wed, 03 Feb 2021 08:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20210203160723.98588-1-nirmoy.das@amd.com>
In-Reply-To: <20210203160723.98588-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Feb 2021 11:56:55 -0500
Message-ID: <CADnq5_Oxd=oBkh7AMEQgVQxhJpuxCRugb8OfZC_w_OmkMTgUbw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: enable wave limit on non high prio cs
 pipes
To: Nirmoy Das <nirmoy.das@amd.com>
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
Cc: Alan Harrison <Alan.Harrison@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Huang Rui <ray.huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 3, 2021 at 11:07 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>
> To achieve the best QoS for high priority compute jobs it is
> required to limit waves on other compute pipes as well.
> This patch will set min value in non high priority
> mmSPI_WCL_PIPE_PERCENT_CS[0-3] registers to minimize the
> impact of normal/low priority compute jobs over high priority
> compute jobs.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 49 ++++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 46 ++++++++++++++++++++++++-
>  2 files changed, 93 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index bdfd29a22b3d..28dbce1083ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6846,10 +6846,44 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
>         amdgpu_ring_write(ring, 0x0000000A);    /* poll interval */
>  }
>
> +
> +/* mmSPI_WCL_PIPE_PERCENT_CS[0-7]_DEFAULT values are same */
> +#define mmSPI_WCL_PIPE_PERCENT_CS_DEFAULT      0x0000007f
> +static void gfx_v8_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
> +                                       uint32_t pipe, bool enable)
> +{
> +       uint32_t val;
> +       uint32_t wcl_cs_reg;
> +
> +       val = enable ? 0x1 : mmSPI_WCL_PIPE_PERCENT_CS_DEFAULT;
> +
> +       switch (pipe) {
> +       case 0:
> +               wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS0;
> +               break;
> +       case 1:
> +               wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS1;
> +               break;
> +       case 2:
> +               wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS2;
> +               break;
> +       case 3:
> +               wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS3;
> +               break;
> +       default:
> +               DRM_DEBUG("invalid pipe %d\n", pipe);
> +               return;
> +       }
> +
> +       amdgpu_ring_emit_wreg(ring, wcl_cs_reg, val);
> +
> +}
> +
>  #define mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT     0x07ffffff
>  static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>  {
>         uint32_t val;
> +       int i;
>
>         /* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
>          * number of gfx waves. Setting 5 bit will make sure gfx only gets
> @@ -6857,6 +6891,18 @@ static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>          */
>         val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
>         amdgpu_ring_emit_wreg(ring, mmSPI_WCL_PIPE_PERCENT_GFX, val);
> +
> +       /* Restrict waves for normal/low priority compute queues as well
> +        * to get best QoS for high priority compute jobs.
> +        *
> +        * amdgpu controls only 1st ME(0-3 CS pipes).
> +        */
> +       for (i = 0; i < 4; i++) {

How about using adev->gfx.mec.num_pipe_per_mec instead of hardcoding 4 here?

> +               if (i != ring->pipe)
> +                       gfx_v8_0_emit_wave_limit_cs(ring, i, enable);
> +
> +       }
> +
>  }
>
>  static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
> @@ -6943,7 +6989,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
>                 VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v8_0_ring_emit_vm_flush */
>                 7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence */
>                 7 + /* gfx_v8_0_emit_mem_sync_compute */
> -               5, /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> +               5 + /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> +               15, /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
>         .emit_ib_size = 7, /* gfx_v8_0_ring_emit_ib_compute */
>         .emit_ib = gfx_v8_0_ring_emit_ib_compute,
>         .emit_fence = gfx_v8_0_ring_emit_fence_compute,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 027997e95e46..e44487ae15dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -6668,10 +6668,42 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
>         amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
>  }
>
> +static void gfx_v9_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
> +                                       uint32_t pipe, bool enable)
> +{
> +       struct amdgpu_device *adev = ring->adev;
> +       uint32_t val;
> +       uint32_t wcl_cs_reg;
> +
> +       /* mmSPI_WCL_PIPE_PERCENT_CS[0-7]_DEFAULT values are same */
> +       val = enable ? 0x1 : mmSPI_WCL_PIPE_PERCENT_CS0_DEFAULT;
> +
> +       switch (pipe) {
> +       case 0:
> +               wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS0);
> +               break;
> +       case 1:
> +               wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS1);
> +               break;
> +       case 2:
> +               wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS2);
> +               break;
> +       case 3:
> +               wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS3);
> +               break;
> +       default:
> +               DRM_DEBUG("invalid pipe %d\n", pipe);
> +               return;
> +       }
> +
> +       amdgpu_ring_emit_wreg(ring, wcl_cs_reg, val);
> +
> +}
>  static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>  {
>         struct amdgpu_device *adev = ring->adev;
>         uint32_t val;
> +       int i;
>
>
>         /* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
> @@ -6682,6 +6714,17 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>         amdgpu_ring_emit_wreg(ring,
>                               SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_GFX),
>                               val);
> +
> +       /* Restrict waves for normal/low priority compute queues as well
> +        * to get best QoS for high priority compute jobs.
> +        *
> +        * amdgpu controls only 1st ME(0-3 CS pipes).
> +        */
> +       for (i = 0; i < 4; i++) {

Same comment here.

> +               if (i != ring->pipe)
> +                       gfx_v9_0_emit_wave_limit_cs(ring, i, enable);
> +
> +       }
>  }
>
>  static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
> @@ -6774,7 +6817,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>                 2 + /* gfx_v9_0_ring_emit_vm_flush */
>                 8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
>                 7 + /* gfx_v9_0_emit_mem_sync */
> -               5, /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> +               5 + /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> +               15, /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
>         .emit_ib_size = 7, /* gfx_v9_0_ring_emit_ib_compute */
>         .emit_ib = gfx_v9_0_ring_emit_ib_compute,
>         .emit_fence = gfx_v9_0_ring_emit_fence,
> --
> 2.30.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

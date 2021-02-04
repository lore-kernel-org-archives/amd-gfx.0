Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0473C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 16:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6CF64F42
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 16:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6CF64F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66D26E0F8;
	Thu,  4 Feb 2021 16:32:29 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FA76E0F8
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 16:32:28 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id d20so4273788oiw.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 08:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=15/SV159iQ+fN9PvGrugloW+ny8dcDzgYnmx2NQAGvY=;
 b=PiuMf7x4phwFsYbSRm16h1xiLFHalaMpEs9Kmbdx3PwaWMkmL+QUo+vMpdqWqpgWMi
 myquPu0zlJQIK/dx/NEzYumu4ticRJFrB/ci/4e6+KTe/OJq57jUVcGt71yRkiCv2OPb
 6XPDh8YXHhAVKnqWozHXOANxvEeErDxltWyROg1MiCLRhdUyObKlucE303QxqXmJ4tDS
 C41h1kLlywfKDCiSY/DA+3TBhulH2DNY3lyvcXT6J+EQ1Q40o2YWSochp8Z3bzMPUK/v
 Yf7vT8IyMvzh6s+6BJMhJuxP3W1zxslTw9NTbjl1AotKz9xOvD77k3VdA1i/3UVfJFTe
 Ng4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=15/SV159iQ+fN9PvGrugloW+ny8dcDzgYnmx2NQAGvY=;
 b=t/TReQsO0SNHsWzQSKtCmjR6G3ktD9wUhj0eq/S8ZYFwHow6j2dES98DtrneqAlE7q
 orQ896f4mIpF7W9meZRL+8xBkEr3KOXIJ6B1hSJXgfJwpX87Ud5ZIhJ7yaSy5qVIoAZC
 eBymk7zKlHr/DgPMxRgEBOmqZ7CQhjFwbw0sfCJZE1oQTRp4CAXnJXdKQcRCTeQsrzJ7
 rsn9FGrfTmRabUoD0zWgfPnxcLfu8Z3cmfasBNr49LUfcUfwx99VHrCUb3wJcIkMX6AY
 wMI3ruV0bgopivIwzdQ+7mpaMa7VeDSxObFI2UoLZUKIFewQfTXX7o25/9hMbwrHWu/3
 w0Nw==
X-Gm-Message-State: AOAM532wt4rpCtFk6vs9vq5Q03QLpq8DJTkFbKLbO1sPoZSc4qGkYL3A
 Aa0h5X9TSeH77EOcFm6j8g0FH5lRKBf8LWFPTOFRHpzG
X-Google-Smtp-Source: ABdhPJx21clYaq8iWXNHioSfthwqIANrfdgQ+AcjG+hi9KK1ABk2FXoVOx/yDyKfHVc9GGqvPHAQnrej3yTsXRohtkg=
X-Received: by 2002:aca:1a17:: with SMTP id a23mr177351oia.120.1612456347463; 
 Thu, 04 Feb 2021 08:32:27 -0800 (PST)
MIME-Version: 1.0
References: <20210203171132.121236-1-nirmoy.das@amd.com>
 <61775992-be78-b799-4bac-293f8a33308d@amd.com>
In-Reply-To: <61775992-be78-b799-4bac-293f8a33308d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Feb 2021 11:32:15 -0500
Message-ID: <CADnq5_OXV0pAAmE-pD5vve8G-j1LKZUkPqxAgdQZwtvSpp+a4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/amdgpu: enable wave limit on non high prio cs
 pipes
To: Nirmoy <nirmodas@amd.com>
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
 Felix" <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Feb 4, 2021 at 11:17 AM Nirmoy <nirmodas@amd.com> wrote:
>
> ping.
>
> On 2/3/21 6:11 PM, Nirmoy Das wrote:
> > To achieve the best QoS for high priority compute jobs it is
> > required to limit waves on other compute pipes as well.
> > This patch will set min value in non high priority
> > mmSPI_WCL_PIPE_PERCENT_CS[0-3] registers to minimize the
> > impact of normal/low priority compute jobs over high priority
> > compute jobs.
> >
> > v2: use adev->gfx.mec.num_pipe_per_mec instead of hardcoding 4.
> >
> > Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 50 ++++++++++++++++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 46 +++++++++++++++++++++++-
> >   2 files changed, 94 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > index bdfd29a22b3d..84d2eaa38101 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -6846,10 +6846,45 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
> >       amdgpu_ring_write(ring, 0x0000000A);    /* poll interval */
> >   }
> >
> > +
> > +/* mmSPI_WCL_PIPE_PERCENT_CS[0-7]_DEFAULT values are same */
> > +#define mmSPI_WCL_PIPE_PERCENT_CS_DEFAULT    0x0000007f
> > +static void gfx_v8_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
> > +                                     uint32_t pipe, bool enable)
> > +{
> > +     uint32_t val;
> > +     uint32_t wcl_cs_reg;
> > +
> > +     val = enable ? 0x1 : mmSPI_WCL_PIPE_PERCENT_CS_DEFAULT;
> > +
> > +     switch (pipe) {
> > +     case 0:
> > +             wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS0;
> > +             break;
> > +     case 1:
> > +             wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS1;
> > +             break;
> > +     case 2:
> > +             wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS2;
> > +             break;
> > +     case 3:
> > +             wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS3;
> > +             break;
> > +     default:
> > +             DRM_DEBUG("invalid pipe %d\n", pipe);
> > +             return;
> > +     }
> > +
> > +     amdgpu_ring_emit_wreg(ring, wcl_cs_reg, val);
> > +
> > +}
> > +
> >   #define mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT  0x07ffffff
> >   static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
> >   {
> > +     struct amdgpu_device *adev = ring->adev;
> >       uint32_t val;
> > +     int i;
> >
> >       /* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
> >        * number of gfx waves. Setting 5 bit will make sure gfx only gets
> > @@ -6857,6 +6892,18 @@ static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
> >        */
> >       val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
> >       amdgpu_ring_emit_wreg(ring, mmSPI_WCL_PIPE_PERCENT_GFX, val);
> > +
> > +     /* Restrict waves for normal/low priority compute queues as well
> > +      * to get best QoS for high priority compute jobs.
> > +      *
> > +      * amdgpu controls only 1st ME(0-3 CS pipes).
> > +      */
> > +     for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
> > +             if (i != ring->pipe)
> > +                     gfx_v8_0_emit_wave_limit_cs(ring, i, enable);
> > +
> > +     }
> > +
> >   }
> >
> >   static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
> > @@ -6943,7 +6990,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
> >               VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v8_0_ring_emit_vm_flush */
> >               7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence */
> >               7 + /* gfx_v8_0_emit_mem_sync_compute */
> > -             5, /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> > +             5 + /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> > +             15, /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
> >       .emit_ib_size = 7, /* gfx_v8_0_ring_emit_ib_compute */
> >       .emit_ib = gfx_v8_0_ring_emit_ib_compute,
> >       .emit_fence = gfx_v8_0_ring_emit_fence_compute,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 027997e95e46..65db88bb6cbc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -6668,10 +6668,42 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
> >       amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
> >   }
> >
> > +static void gfx_v9_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
> > +                                     uint32_t pipe, bool enable)
> > +{
> > +     struct amdgpu_device *adev = ring->adev;
> > +     uint32_t val;
> > +     uint32_t wcl_cs_reg;
> > +
> > +     /* mmSPI_WCL_PIPE_PERCENT_CS[0-7]_DEFAULT values are same */
> > +     val = enable ? 0x1 : mmSPI_WCL_PIPE_PERCENT_CS0_DEFAULT;
> > +
> > +     switch (pipe) {
> > +     case 0:
> > +             wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS0);
> > +             break;
> > +     case 1:
> > +             wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS1);
> > +             break;
> > +     case 2:
> > +             wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS2);
> > +             break;
> > +     case 3:
> > +             wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS3);
> > +             break;
> > +     default:
> > +             DRM_DEBUG("invalid pipe %d\n", pipe);
> > +             return;
> > +     }
> > +
> > +     amdgpu_ring_emit_wreg(ring, wcl_cs_reg, val);
> > +
> > +}
> >   static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
> >   {
> >       struct amdgpu_device *adev = ring->adev;
> >       uint32_t val;
> > +     int i;
> >
> >
> >       /* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
> > @@ -6682,6 +6714,17 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
> >       amdgpu_ring_emit_wreg(ring,
> >                             SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_GFX),
> >                             val);
> > +
> > +     /* Restrict waves for normal/low priority compute queues as well
> > +      * to get best QoS for high priority compute jobs.
> > +      *
> > +      * amdgpu controls only 1st ME(0-3 CS pipes).
> > +      */
> > +     for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
> > +             if (i != ring->pipe)
> > +                     gfx_v9_0_emit_wave_limit_cs(ring, i, enable);
> > +
> > +     }
> >   }
> >
> >   static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
> > @@ -6774,7 +6817,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
> >               2 + /* gfx_v9_0_ring_emit_vm_flush */
> >               8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
> >               7 + /* gfx_v9_0_emit_mem_sync */
> > -             5, /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> > +             5 + /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> > +             15, /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
> >       .emit_ib_size = 7, /* gfx_v9_0_ring_emit_ib_compute */
> >       .emit_ib = gfx_v9_0_ring_emit_ib_compute,
> >       .emit_fence = gfx_v9_0_ring_emit_fence,
> > --
> > 2.30.0
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

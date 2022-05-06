Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DD7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A674810E1B2;
	Fri,  6 May 2022 15:26:43 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056DA10E1B2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:26:42 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id y63so7821549oia.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 May 2022 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ch1LAHJSbD2MfSmmb8n4ot5EpqEwM/lFNxVjYGI7cK0=;
 b=RvEcDxdRsblqUwiwzGjL7xuLiHtFklOHxmd/sLNaWXh8i+M5povoqL5lSfRlwZeBGj
 PITaleqEn+BbQ8MOzWqph3cmT2EV83r94Ts/XOrU7i8S88NuN9KozS+nXBAK3e5Pn9Ba
 /r51cS5zWT25z2lC2TESta5ePsijj3IUwjvg+oUz3HqEbXdo7zeMUIpzf64GKe61eOwi
 aqRr6klYn5P+tJyHn2jASeJ8eW+bItJpYsmcFwM3aUl84I79ULcX4aFZlEWJjAsOZri8
 w1IlXd3MGwfnfBK6otRNEn55Ona8Nz7dPyV7E25A7FTlN764ZMD9TAQ5O2QlrT+j7gGu
 Mryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ch1LAHJSbD2MfSmmb8n4ot5EpqEwM/lFNxVjYGI7cK0=;
 b=iBIesP0UJBzJ10TZdpACjez6fifWFOqEMG7V2Fs1DFsWI7qbY4nQQf4HxRXMa1FKqs
 o6k/pGU6bhaavvH/+/IN5fmKlu7Y/Ph/5qUKDGrZBFioLgFtc0c70IScLXlzcqz7GYuU
 OL2PWqruX1ZkmP08iUTaaFUJ4UcGDsXMVEEbYwTBgrsGvPHZLB5Qbb5Nk1oSzaYSkddN
 xygPwa/AkJlzyVRB+pgD1scoSYWRyYjC6zQEnu2kmvSiSKkMocMYZrl+1jv04MMNYG/J
 3XN61qWY5BCP4WKNyx2Qv6Fq6pIJq7qdK7RUbGBhZyWPoZndYt4WhcGA7TgyPiaLbF4k
 kzpg==
X-Gm-Message-State: AOAM530cuzcX1VdTcCorcoCLohJG75HuO/8Su7hLSAc3A01dBl20DXk/
 t4f6PfURRLcnlgkNzgcPcnWNuz2wnPL3aAF09UmaNBgX
X-Google-Smtp-Source: ABdhPJwkmYdv2IvxAazII29ZUOvs5pe59JjKM2YFFfT1G9GtkwLZkMwvN3jDFR4QqvViAh7ldNYrPMQD7X7PMfhpBEA=
X-Received: by 2002:a05:6808:f8d:b0:325:1e81:ffe5 with SMTP id
 o13-20020a0568080f8d00b003251e81ffe5mr1715585oiw.253.1651850801709; Fri, 06
 May 2022 08:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
 <20220505200406.1293467-7-alexander.deucher@amd.com>
 <df37562a-86d0-16e6-96f0-b9b43ba08ca2@amd.com>
In-Reply-To: <df37562a-86d0-16e6-96f0-b9b43ba08ca2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 May 2022 11:26:30 -0400
Message-ID: <CADnq5_PHzyNy-yNTKhfi6H1Xu60FXfH+XHC5GVhpHj1pfNj27Q@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/amdgpu: support memory power gating for lsdma
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 6, 2022 at 1:10 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
>
>
> On 2022-05-05 16:04, Alex Deucher wrote:
> > From: Likun Gao <Likun.Gao@amd.com>
> >
> > Support memory power gating control for LSDMA.
> >
> > Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> > Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h |  1 +
> >  drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c   | 16 +++++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/soc21.c        | 12 +++++++++++-
> >  3 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> > index 9a29f18407b8..7ec7598e7dec 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> > @@ -34,6 +34,7 @@ struct amdgpu_lsdma_funcs
> >                      uint64_t dst_addr, uint64_t size);
> >       int (*fill_mem)(struct amdgpu_device *adev, uint64_t dst_addr,
> >                      uint32_t data, uint64_t size);
> > +     void (*update_memory_power_gating)(struct amdgpu_device *adev, bool enable);
> >  };
> >
> >  int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev, uint64_t src_addr,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> > index b4adb94a080b..1a285b531881 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> > @@ -101,7 +101,21 @@ static int lsdma_v6_0_fill_mem(struct amdgpu_device *adev,
> >       return ret;
> >  }
> >
> > +static void lsdma_v6_0_update_memory_power_gating(struct amdgpu_device *adev,
> > +                                              bool enable)
> > +{
> > +     uint32_t tmp;
> > +
> > +     tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL);
> > +     tmp = REG_SET_FIELD(tmp, LSDMA_MEM_POWER_CTRL, MEM_POWER_CTRL_EN, 0);
> > +     WREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL, tmp);
> > +
> > +     tmp = REG_SET_FIELD(tmp, LSDMA_MEM_POWER_CTRL, MEM_POWER_CTRL_EN, enable);
> > +     WREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL, tmp);
> > +}
> > +
>
> Do we need to disable it first before updating?
>
> What if we're updating it to the same value it currently is (on the first read)?
> Shouldn't we just skip the subsequent writes?

I'll let Likun comment, but I suspect this sequence came from the hardware team.

Alex

>
> >  const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
> >       .copy_mem = lsdma_v6_0_copy_mem,
> > -     .fill_mem = lsdma_v6_0_fill_mem
> > +     .fill_mem = lsdma_v6_0_fill_mem,
> > +     .update_memory_power_gating = lsdma_v6_0_update_memory_power_gating
> >  };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > index 741ed3ba84d6..3303e02f85d1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > @@ -676,7 +676,17 @@ static int soc21_common_set_clockgating_state(void *handle,
> >  static int soc21_common_set_powergating_state(void *handle,
> >                                          enum amd_powergating_state state)
> >  {
> > -     /* TODO */
> > +     struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +
> > +     switch (adev->ip_versions[LSDMA_HWIP][0]) {
> > +     case IP_VERSION(6, 0, 0):
> > +             adev->lsdma.funcs->update_memory_power_gating(adev,
> > +                             state == AMD_PG_STATE_GATE);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> >       return 0;
> >  }
> >
>
> Regards,
> --
> Luben

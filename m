Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD967EE4993
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 15:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A0710E227;
	Tue, 22 Aug 2023 15:49:02 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D30D910E227
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 15:49:00 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3a8036d805eso3441185b6e.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 08:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692719340; x=1693324140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRmnqaquB+hzJgcInMcanxv+jJ8vjS5WNwrY4djpvPM=;
 b=GjsOC/e6RiT5wmYZ57V4DhuLEgw9PCA+lQrKHy6Lk5lUW5eUUJJH83LwQNGQzc4U3N
 FpzXJBXAHz4csIuT/4O/rfJz/X7RGYNdATJkv+kFnLg7/hTnapaXcSl/ZmzWKnCzTv8h
 zAcAnoyVbQlN+I1PMisieJW3ZTtFOCP8OnO9cNXVzQoanlfT4DtoBOSQ1WtufH0Lnc32
 y6MVdsRRPt+8GnHmdATt7E7PE+KR/z4lTFeo82sRiNeVOdS6IscPFnnB0VCXt/iWJh2f
 ppFthEdCW6BmqZETXu3W5xqC+pBEd+Yvm72tfTxYN/w9rsrmDE3thM9vV6u5PulofT9j
 edrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692719340; x=1693324140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRmnqaquB+hzJgcInMcanxv+jJ8vjS5WNwrY4djpvPM=;
 b=kB5ISiaAhy50IUnBVce8hgCDjFE7cn2A9nRPbRPo4HsVwrelPQIQrhbBqkqpCQdi7W
 hXEXvnXiKzHe7yJOwflvHRlhY9IAUf48r1X4hvverBzfvBWFPIGk89oR5PAhps4WLgvQ
 xt6krvhVfSfm7CcHHMo79eAEw/XN02FT+TdZ5ksZd3JrKuL95HQ5Un39ALGVAXn2fV97
 javCrupcJI8NzZHF/36axCgeVCMxS/9n/wY4RQ9awrNwvWCaPB+nS5J69vDYeVYsCd7S
 TkzEL2Cr5XUp5XCI4eJSR6SzDMebr2k3QzdijHtXvmiaQ2Zj+0SjPPwtvO0bIIoy713A
 /hPg==
X-Gm-Message-State: AOJu0YwaOQAKPTIleEcApXenw4hIiTbWJUZLvGrFALe9MHi7tCEWP2cz
 WqwcPqqXiutuT2M0ndwckronqKjjB2IbJLpVfq0=
X-Google-Smtp-Source: AGHT+IG/Ya6cQY01E/dO8DbbIv1VJUfT72tCeFEGgMJLvIJYzPscub9002UaTR7ZC0AX1VR++CHlPQUfCJ7yxemwPUQ=
X-Received: by 2002:aca:1b16:0:b0:3a7:330d:93da with SMTP id
 b22-20020aca1b16000000b003a7330d93damr11060827oib.19.1692719339985; Tue, 22
 Aug 2023 08:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230822061724.3917603-1-yifan1.zhang@amd.com>
 <20230822061724.3917603-2-yifan1.zhang@amd.com>
 <2f0ac951-0825-6298-604d-90a5454b6e6e@amd.com>
In-Reply-To: <2f0ac951-0825-6298-604d-90a5454b6e6e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Aug 2023 11:48:48 -0400
Message-ID: <CADnq5_P2YzF-30OgnxnXVEtqjXr-oxCbMHMbqmYhRScEakLN8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Put page tables to GTT memory for APUs.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 22, 2023 at 8:00=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 22.08.23 um 08:17 schrieb Yifan Zhang:
> > To decrease VRAM pressure for APUs, put page tables to
> > GTT domain.
> >
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_pt.c
> > index 96d601e209b8..26063e611c49 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > @@ -515,7 +515,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm,
> >       bp.size =3D amdgpu_vm_pt_size(adev, level);
> >       bp.byte_align =3D AMDGPU_GPU_PAGE_SIZE;
> >
> > -     if (!adev->gmc.is_app_apu)
> > +     if (!(adev->gmc.is_app_apu || (adev->flags & AMD_IS_APU)))
>
> I've tried this before and it doesn't work in quite a bunch of
> configurations. Especially IOMMU has big problems with that.
>
> Alex do you know which hw generation finally supported that without
> problems?

We ran into issues on raven boards IIRC.  It's probably safe to enable
on Renoir and newer APUs since those should have all been validated
with windows + IOMMU.

Alex

>
> Regards,
> Christian.
>
> >               bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> >       else
> >               bp.domain =3D AMDGPU_GEM_DOMAIN_GTT;
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D69FC7EE21
	for <amd-gfx@archiver.kernel.org>; Thu,  4 May 2023 19:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462D410E071;
	Thu,  4 May 2023 19:16:04 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6D810E071
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 May 2023 19:16:00 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-38e5eeba43cso321065b6e.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 May 2023 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683227759; x=1685819759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45pDfT6Yr/sMIpbbOVZhrRD64WSJlqTXfUaJ2/0pjy0=;
 b=W8F9jRg17/RFqIPz80gFKJmbF6pWMZihPFcUzMr3R2vNU8VLWXX4qQWD39vi65mPmT
 bvmZ9adxVvDS4ITp6nFGWXIoP6Amb4m+hibHxTb2OQ9l/BD0LGVQdVKCWKtPgeSkJDLT
 kxn0RCa8SEx+sTv+m8JCcSdpKM753gkoFHd+5vjSnTwIFsbKLeAtvteUoYj/W3ksMpNU
 fmgMCTy2jYUY0zDqb4Gmia+7lUykWhod8ur6liTVUZz57yKoGmmCsHt/5EF/uhWCVB26
 efl2pjlf9jKpI6UMNg/8wHUim1j+XdtUiDokOegHtd3VJf/y8Bt1XVtrcyNO8IwKvHyv
 XNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683227759; x=1685819759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=45pDfT6Yr/sMIpbbOVZhrRD64WSJlqTXfUaJ2/0pjy0=;
 b=ADZdRx39lH/TrfM098ckLeMVzylpJj4QnTDHc88Mgod1k3KCbDwoyHoGUOCbJ3GGCL
 NxBrTdZtEHAfilmTZnam0/ykaQJeTB6egFf6Ou66D62ilTAad/UC4ROfyUQ2gwSU6XMy
 NsFiD8mwyxHcTMtpqzwjQXY22xd5bIEDqFDtQiTQF3dpzTumurTrGkIpKboD5kS5QLMq
 j7wgMXjoFGuDVVB6BpsCofN6uMhM7iH/+xguvsFbQkVN/0fTjY0bZba10OAjnqlnEH7J
 DzXmP4UTKTOCfmcyvHaVOOjhlpavGcGpuz8fz/19HkLojnTOP8E4y6E+ZHXupXJ8oI8L
 FVKA==
X-Gm-Message-State: AC+VfDz3ViX8pVS46cITaQPN91C1M4F2M//E5DioAZ9Y3dvmvGS6znod
 TEow3/0knhnnBt2XKq60+Z79FXhLwWpPUTgX9JQReR6UCCA=
X-Google-Smtp-Source: ACHHUZ6JK9v19r6fuq6jwOSjdQAgM+TD3VmudDTd4SkSdu20XBanD8xSGbNGbmalU1Nu5KePg0E7eZb3h0xxJnh0OiU=
X-Received: by 2002:a05:6808:1155:b0:387:2833:619f with SMTP id
 u21-20020a056808115500b003872833619fmr2847579oiu.15.1683227759309; Thu, 04
 May 2023 12:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230504155023.1415369-1-yifan1.zhang@amd.com>
 <20230504155023.1415369-2-yifan1.zhang@amd.com>
In-Reply-To: <20230504155023.1415369-2-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 May 2023 15:15:47 -0400
Message-ID: <CADnq5_MiO+ZY0A1ckzRTOK=CQS8hahoycP1XffgFmPTXdsfbXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: adjust vmhub flush tlb iteration to fit
 the new GFXHUB/MMHUB layout
To: Yifan Zhang <yifan1.zhang@amd.com>
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
Cc: Alexander.Deucher@amd.com, le.ma@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Maybe add:
Fixes: dc267018dac1 ("drm/amdgpu: introduce vmhub definition for
multi-partition cases (v3)")
to the series.  With that, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

On Thu, May 4, 2023 at 11:51=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> tlb flush has to be changed for the new mmhub layout
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 16 ++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 10 +++++++---
>  2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gart.c
> index 01cb89ffbd56..2383db399c95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -160,6 +160,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, u=
int64_t offset,
>         /* Starting from VEGA10, system bit must be 0 to mean invalid. */
>         uint64_t flags =3D 0;
>         int idx;
> +       struct amdgpu_vmhub *hub;
>
>         if (!adev->gart.ptr)
>                 return;
> @@ -182,8 +183,11 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, =
uint64_t offset,
>         }
>         mb();
>         amdgpu_device_flush_hdp(adev, NULL);
> -       for (i =3D 0; i < adev->num_vmhubs; i++)
> -               amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +       for (i =3D 0; i < AMDGPU_MAX_VMHUBS; i++) {
> +               hub =3D &adev->vmhub[i];
> +               if (hub->vmhub_funcs)
> +                       amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +       }
>
>         drm_dev_exit(idx);
>  }
> @@ -258,14 +262,18 @@ void amdgpu_gart_bind(struct amdgpu_device *adev, u=
int64_t offset,
>  void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
>  {
>         int i;
> +       struct amdgpu_vmhub *hub;
>
>         if (!adev->gart.ptr)
>                 return;
>
>         mb();
>         amdgpu_device_flush_hdp(adev, NULL);
> -       for (i =3D 0; i < adev->num_vmhubs; i++)
> -               amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +       for (i =3D 0; i < AMDGPU_MAX_VMHUBS; i++) {
> +               hub =3D &adev->vmhub[i];
> +               if (hub->vmhub_funcs)
> +                       amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +       }
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 90cf79f8ddde..3ee7f5e067fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -331,6 +331,7 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>         bool ret;
>         struct amdgpu_ring *ring =3D &adev->gfx.kiq[0].ring;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> +       struct amdgpu_vmhub *hub;
>
>         if (amdgpu_emu_mode =3D=3D 0 && ring->sched.ready) {
>                 spin_lock(&adev->gfx.kiq[0].ring_lock);
> @@ -362,9 +363,12 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdg=
pu_device *adev,
>                                 &queried_pasid);
>                 if (ret && queried_pasid =3D=3D pasid) {
>                         if (all_hub) {
> -                               for (i =3D 0; i < adev->num_vmhubs; i++)
> -                                       gmc_v11_0_flush_gpu_tlb(adev, vmi=
d,
> -                                                       i, flush_type);
> +                               for (i =3D 0; i < AMDGPU_MAX_VMHUBS; i++)=
 {
> +                                       hub =3D &adev->vmhub[i];
> +                                       if (hub->vmhub_funcs)
> +                                               gmc_v11_0_flush_gpu_tlb(a=
dev, vmid,
> +                                                               i, flush_=
type);
> +                               }
>                         } else {
>                                 gmc_v11_0_flush_gpu_tlb(adev, vmid,
>                                                 AMDGPU_GFXHUB(0), flush_t=
ype);
> --
> 2.37.3
>

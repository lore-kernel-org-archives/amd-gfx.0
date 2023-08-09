Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CCDC0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 13:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E62210E443;
	Wed,  9 Aug 2023 13:55:35 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1733710E443
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 13:55:33 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5633b7e5f90so4919553eaf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Aug 2023 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691589332; x=1692194132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOCB79KjMhqBfgq1ZV5SurafAjJMRV6Gq6YnbdsoZeA=;
 b=jHIfj+RjH0dTcdN3BWd2/ZNbXi3qLW5r7WQO2s4TSX4Nr46+Wuw68o+BiVyISmtKS4
 c/tnn0inw4X0SxKxBujfLzAxEn+obZzXfKC17yMhe18ypDVNmss6C1Rr7ZTZ6f/tqx4o
 pFrPOXwhBEhFUVW8oVW+5tGD980drS3w6xJBG5oXdZxzJ0qDt/dgD8Cq4VmZInW9FvLN
 YTgNlQeWeKk1pq3dCb/8v0w5hd/hhbejeysnYawl0z2SQjkeKzida35DsVaHJBmgO+dQ
 wehtABE/htcqHU+MtR0GXyY51vUgjd9Y2nos4E+4/YZII6lFZ36Oiml3Ndoyl3Sj66Yi
 AaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691589332; x=1692194132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOCB79KjMhqBfgq1ZV5SurafAjJMRV6Gq6YnbdsoZeA=;
 b=W33sG/hJxqlcf7lmnwDHB2lZHvjWFsVC96nDfooQlnNpDLPS6+YRWWXwCpEMAy0Vyf
 7rsETpVLIXRc8yA7q0e/X/SOh7oa5sE2Y6IJRIgOkDBdQSF3U8rgPXCUyEOxtuWvQCO3
 BeEER4ZjOHPPzkqSIBANg8hg/gGswwGBhuOy/R7+2dTUf0ZxOOHP/vsrzOBfOuyGSC27
 ubpe3NOeBAZNX9Tl/pnJl0Atd7rSLHvTg8jvL4qN7qWsALmwONUbUa7M3nNmFGeDjK0G
 Vb7AlU8de4S+Q2uX0a+u7LaWb/LuDVCWGGfBguCvFRWpxfNJWzKibeWeQtKBOi2+rMkr
 YVuQ==
X-Gm-Message-State: AOJu0YyCnYPoV0DA801CurZz/HaDdaLksDkhlJ8FFau3WYP3n1QKUsY+
 n0McKhoqe69ktiwDJwoGIR3ixO0Rq+FaqgNXvbg=
X-Google-Smtp-Source: AGHT+IHVPIwKfYTAFAqk6JTp27JHz0I1NTTLN8yiaA8oZwZ0Ohxa2j+ha+GvImyceg+Ikp+usNEHnbHrb8Nf+X86dxM=
X-Received: by 2002:a05:6808:1313:b0:3a7:57a6:e077 with SMTP id
 y19-20020a056808131300b003a757a6e077mr3210124oiv.37.1691589332173; Wed, 09
 Aug 2023 06:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230809032036.533108-1-jiadong.zhu@amd.com>
In-Reply-To: <20230809032036.533108-1-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Aug 2023 09:55:21 -0400
Message-ID: <CADnq5_O=1PG7e9ObJNh+UoaXNC74M6hiMmA8Ayk=Z2e1+rqfkw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable mcbp if parameter zero is set
To: jiadong.zhu@amd.com
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

On Tue, Aug 8, 2023 at 11:21=E2=80=AFPM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> The parameter amdgpu_mcbp shall have priority against the default value
> calculated from the chip version.
> User could disable mcbp by setting the parameter mcbp as zero.
>
> v2: do not trigger preemption in sw ring muxer when mcbp is disabled.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 9 +++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7314529553f6..615669dcabc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3699,10 +3699,11 @@ static void amdgpu_device_set_mcbp(struct amdgpu_=
device *adev)
>  {
>         if (amdgpu_mcbp =3D=3D 1)
>                 adev->gfx.mcbp =3D true;
> -
> -       if ((adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 0, 0)) &&
> -           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
> -           adev->gfx.num_gfx_rings)
> +       else if (amdgpu_mcbp =3D=3D 0)
> +               adev->gfx.mcbp =3D false;
> +       else if ((adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 0, 0))=
 &&
> +                (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &=
&
> +                adev->gfx.num_gfx_rings)
>                 adev->gfx.mcbp =3D true;
>
>         if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring_mux.c
> index b779ee4bbaa7..e1ee1c7117fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -397,7 +397,7 @@ void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring=
)
>         struct amdgpu_ring_mux *mux =3D &adev->gfx.muxer;
>
>         WARN_ON(!ring->is_sw_ring);
> -       if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
> +       if (adev->gfx.mcbp && ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
>                 if (amdgpu_mcbp_scan(mux) > 0)
>                         amdgpu_mcbp_trigger_preempt(mux);
>                 return;
> --
> 2.25.1
>

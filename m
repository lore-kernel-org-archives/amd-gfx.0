Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5637D3E2BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511E310E541;
	Mon, 28 Oct 2024 19:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TV/PzHUW";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE53D10E541
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:43:42 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-7ea535890e0so527991a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730144622; x=1730749422; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWNvsJ+p26yHOxZZ8pyxpSePq39gJkGD7XFa6quwGTQ=;
 b=TV/PzHUW6T9uDsKdDcPPOLuspbV06VS/fvx4WVzd7lWRBR60qqZjllPUVLekonvCjJ
 CtPtCLYsXxrzjDWmdDXC6Ib3cOBybKGTVMZfo2QAOPaF61ZJiYDU14hjb7wqhRTNYnuQ
 sazWydCkIdu7ngZFFLe5feCNSfzRBS+r/i1u3+Ri1lc7rEo9RpMOSli/Nhfl9Bjk7GAF
 m1RBDSrL+90VXBMB5QIBcjmJD+pOQ1odsp3cbcGUpdi1N98q8GPO2fsgJCndwt3tctzQ
 PhLJU+6LiPFv0vur/7WPhxFll2tGuuSUT3FZe7s34j7+uPUS47KSvcqbynHeCP2MdiAV
 ZULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730144622; x=1730749422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWNvsJ+p26yHOxZZ8pyxpSePq39gJkGD7XFa6quwGTQ=;
 b=CwwHprUz3L1EjjstN4jcBG7D9ZW7F9Mw3D2X5q012tSE3CuAt5qp0eYYPKzn6c17k7
 IkeuwFP3iyZeThZx8q+L2ic60bC4z1dQuKqpkTkd8CUh6p6DLXHJXrKT2Nu2W7ZsTVJf
 hnps4TfQ24O02NL8VEBmXoLjWy9rtadHoG1vuXn544vT+P2x6aZxOnInQuVPhJl4SNFK
 PteeRelVfVX1g3Le7NNawLR36SKBDxGisOJnBxMjSV9EAeqVLfALpP+AqHf5AYf7p5qi
 DdtMHGCdXfyEaO6mzF+pFSeUTcdX7N2lwilGPs2mVnU/mTI/eAUFRHbudNDUpW7FNs/q
 gk7w==
X-Gm-Message-State: AOJu0Yx6qAEI09qiy2nl3OvsrXu6Omgu5oRSkWxZIo21l/M4HkGrgX5p
 qMHLq3D5k73+dX++WqXHLM3Ld8VYin3nnC70UeFvV3Q/MGOyptWejujXp/VCJG7rYxI+clN5iBZ
 D/2J8fNOY64Fdm0D2y2fjWcFmZIE=
X-Google-Smtp-Source: AGHT+IEH6dW24Ye5/FJd4kkG4JGaZgkR4WrqCBvK22a6avqoKqHqtZY/mQU82Dg31fH3p/FfwcVR6QoaEg1mogJ2uQs=
X-Received: by 2002:a05:6a20:a10f:b0:1cf:4bd8:3a09 with SMTP id
 adf61e73a8af0-1d9a83da97bmr6860481637.6.1730144622297; Mon, 28 Oct 2024
 12:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-27-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-27-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:43:30 -0400
Message-ID: <CADnq5_OhJzPbG9UD__KbdR6FdaSP5sMSGZ-7XJCiSiif8juuMA@mail.gmail.com>
Subject: Re: [PATCH 26/29] drm/amdgpu: setup_ucode for each vcn instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Thu, Oct 24, 2024 at 10:36=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to amdgpu_vcn_setup_ucode(), and perform
> setup ucode ONLY for the given vcn instance, instead of for all
> vcn instances. Modify each vcn generation accordingly.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  2 +-
>  10 files changed, 26 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index c4e1283aa9a4..29f6a2b76919 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1049,34 +1049,31 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_en=
c_ring_prio(int ring)
>         }
>  }
>
> -void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
> +void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst)
>  {
> -       int i;
>         unsigned int idx;
>
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
>                 const struct common_firmware_header *hdr;
>
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       if (adev->vcn.harvest_config & (1 << i))
> -                               continue;
> +               if (adev->vcn.harvest_config & (1 << inst))
> +                       return;
>
> -                       hdr =3D (const struct common_firmware_header *)ad=
ev->vcn.inst[i].fw->data;
> -                       /* currently only support 2 FW instances */
> -                       if (i >=3D 2) {
> -                               dev_info(adev->dev, "More then 2 VCN FW i=
nstances!\n");
> -                               break;
> -                       }
> -                       idx =3D AMDGPU_UCODE_ID_VCN + i;
> -                       adev->firmware.ucode[idx].ucode_id =3D idx;
> -                       adev->firmware.ucode[idx].fw =3D adev->vcn.inst[i=
].fw;
> -                       adev->firmware.fw_size +=3D
> -                               ALIGN(le32_to_cpu(hdr->ucode_size_bytes),=
 PAGE_SIZE);
> -
> -                       if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
> -                           IP_VERSION(4, 0, 3))
> -                               break;
> +               hdr =3D (const struct common_firmware_header *)adev->vcn.=
inst[inst].fw->data;
> +               /* currently only support 2 FW instances */
> +               if (inst >=3D 2) {
> +                       dev_info(adev->dev, "More then 2 VCN FW instances=
!\n");
> +                       return;
>                 }
> +               idx =3D AMDGPU_UCODE_ID_VCN + inst;
> +               adev->firmware.ucode[idx].ucode_id =3D idx;
> +               adev->firmware.ucode[idx].fw =3D adev->vcn.inst[inst].fw;
> +               adev->firmware.fw_size +=3D
> +                       ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SI=
ZE);
> +
> +               if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
> +                       IP_VERSION(4, 0, 3))
> +                       return;
>         }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 75cfdb770672..6cd094ee8218 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -505,7 +505,7 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *r=
ing, long timeout);
>
>  enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
>
> -void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
> +void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst);
>
>  void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
>  void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 77f9f34eaca8..7638ddeccec7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -154,7 +154,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>         /* Override the work func */
>         adev->vcn.inst[0].idle_work.work.func =3D vcn_v1_0_idle_work_hand=
ler;
>
> -       amdgpu_vcn_setup_ucode(adev);
> +       amdgpu_vcn_setup_ucode(adev, inst);
>
>         r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index 87293bb777d4..a327c3bf84f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -159,7 +159,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_setup_ucode(adev);
> +       amdgpu_vcn_setup_ucode(adev, inst);
>
>         r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 62266db72531..0d84cb4279e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -189,7 +189,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_setup_ucode(adev);
> +       amdgpu_vcn_setup_ucode(adev, inst);
>
>         r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index d29c49d061d7..03fc50b3aa05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -172,7 +172,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_setup_ucode(adev);
> +       amdgpu_vcn_setup_ucode(adev, inst);
>
>         r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 509dc6b5f43b..c52ed8166d9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -180,7 +180,7 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_setup_ucode(adev);
> +       amdgpu_vcn_setup_ucode(adev, inst);
>
>         r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 070cf516f365..2468a5e409c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -137,7 +137,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_setup_ucode(adev);
> +       amdgpu_vcn_setup_ucode(adev, inst);
>
>         r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index ad9e67d9134d..f43604d7fb1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -142,7 +142,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_setup_ucode(adev);
> +       amdgpu_vcn_setup_ucode(adev, inst);
>
>         r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 9999c8094920..d61428c75c88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -126,7 +126,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_setup_ucode(adev);
> +       amdgpu_vcn_setup_ucode(adev, inst);
>
>         r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
> --
> 2.34.1
>

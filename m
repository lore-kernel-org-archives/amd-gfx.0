Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1435C54E41
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 14:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8358710EEBF;
	Wed,  6 Mar 2024 14:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UJZ/gQ1y";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108BD10EEBF
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 14:13:45 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-29aa91e173dso1386021a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Mar 2024 06:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709734425; x=1710339225; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8lowcs9QjSM8EgLYFn0DKqMV3AZNXD1WsUPGpBTZ1A=;
 b=UJZ/gQ1yp4SXd0WCT439xsrfK8Qkh3SGl8BBqpdxRy6SiIGBywjrYa3ES7ME8Pl4x0
 co0bmL5FFfpWoYLRCh3p09GTWs8DjXqhErytKVSzRMkb/kNiPuxi6odp/yojvK0GfAjj
 KVhUXy7dOmxOE1Q3P7ok7Mz97L21bJ4/c22OCzgAyNkmvzRQmSv6iuC5FpZJSzVeeyKY
 /bJNjwCzTp+QmUUhh22rOrgCbkZXXgoyKtRDwxQk5NFjGbXN6q1T5DDRWJuewf7eMGAY
 pSGw3FblEskv+dyae+gPpsOreDn86KtPzsGLz4TRxmAL4PU1LGiOU5D9u4KmXFU0ypzT
 Wq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709734425; x=1710339225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8lowcs9QjSM8EgLYFn0DKqMV3AZNXD1WsUPGpBTZ1A=;
 b=h0hXTw9RuwlTT2luQTugkujtpyUOIo1Fc3jJ2qIcuh/+STFtKuRlV/SQNgVP/XN/mA
 vL2Ln3z4mwQ58XjlBiewl/+u5y0lA/5Wh5bnEMic0EaQ1vP9yvyQeD+XJBSSfkpWFS1L
 cCVHpnpgooQOIqXJY2uJMJvhfNHlfhaYuH9O9mWuzjoyvb/ZmLjoDQSslbb+z3qFZNFV
 IDC9t1iFqilX9yJD1unew3hw6FMB4oFMRJLcE3XoWZ30JQ3RgV9S5JWwLLgWIztz1ggH
 46TfOcbSykdOpDRlgDP9UBVReSZZTTxeJSum66OrDA35ATI/BobNcWdMi1Yj8z38SXNZ
 3WHA==
X-Gm-Message-State: AOJu0Yz5sGmmvJoY1aCSyqo6FrG3Ie325znHvcovLeEZLJwlMR8XQE/O
 GGY/cw4D64Pwcey+OmkZZ0VqBkW83ooZ1oXK1BKlzAAlyY56NNIT+aoeanS361RVrZZTNh/1eh5
 9xpSbTsVyN37sExksgPck0XgFNso=
X-Google-Smtp-Source: AGHT+IH/TuW83V/93WeFIOd7AqUrW+2W2quAB5CbIkhOMNhtOIoHVZr/jjGtzxK0wmHYzKLrK2Xa3BP0PhdSCNk1lTI=
X-Received: by 2002:a17:90a:4813:b0:29b:2f01:6f53 with SMTP id
 a19-20020a17090a481300b0029b2f016f53mr9814619pjh.46.1709734425282; Wed, 06
 Mar 2024 06:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20240306100732.1126961-1-zhenguo.yin@amd.com>
In-Reply-To: <20240306100732.1126961-1-zhenguo.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Mar 2024 09:13:32 -0500
Message-ID: <CADnq5_NFwH0XRRq+S_KvEucYfcGaEjaohbGNRHvAGMp0+xtDrQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Skip access PF-only registers on
 gfx10/gfxhub2_1 under SRIOV
To: ZhenGuo Yin <zhenguo.yin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, jingwen.chen@amd.com, horace.chen@amd.com
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Mar 6, 2024 at 5:33=E2=80=AFAM ZhenGuo Yin <zhenguo.yin@amd.com> wr=
ote:
>
> [Why]
> RLCG interface returns "out-of-range" error under SRIOV VF when accessing
> PF-only registers.
>
> [How]
> Skip access PF-only registers on gfx10/gfxhub2_1 under SRIOV.
>
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 904b9ff5ead2..f90905ef32c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3657,6 +3657,9 @@ static void gfx_v10_0_init_spm_golden_registers(str=
uct amdgpu_device *adev)
>
>  static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
>  {
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(10, 1, 10):
>                 soc15_program_register_sequence(adev,
> @@ -4982,7 +4985,8 @@ static void gfx_v10_0_constants_init(struct amdgpu_=
device *adev)
>         u32 tmp;
>         int i;
>
> -       WREG32_FIELD15(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
> +       if (!amdgpu_sriov_vf(adev))
> +               WREG32_FIELD15(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
>
>         gfx_v10_0_setup_rb(adev);
>         gfx_v10_0_get_cu_info(adev, &adev->gfx.cu_info);
> @@ -7163,7 +7167,7 @@ static int gfx_v10_0_hw_init(void *handle)
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3, =
0))
>                 gfx_v10_3_program_pbb_mode(adev);
>
> -       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(10, 3, 0)=
)
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(10, 3, 0)=
 && !amdgpu_sriov_vf(adev))
>                 gfx_v10_3_set_power_brake_sequence(adev);
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v2_1.c
> index cd0e8a321e46..17509f32f61a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -155,6 +155,9 @@ static void gfxhub_v2_1_init_system_aperture_regs(str=
uct amdgpu_device *adev)
>  {
>         uint64_t value;
>
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +
>         /* Program the AGP BAR */
>         WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
>         WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24)=
;
> --
> 2.35.1
>

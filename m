Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83594D0BB62
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 20:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3194310E3AA;
	Thu, 24 Oct 2024 20:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="emFMUfje";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED5C10E3AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 20:19:24 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-7ea6f99e6eeso49976a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729801164; x=1730405964; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNSAhqT3SQQ6HzAAu9O/WZUXT3zIdS0OVD849dN+RRI=;
 b=emFMUfjeSXn7gCY3FsS9hycCZJfqrjAAaCd1G1jp86Udj5F1gHMx6FT8I107l0TTYy
 YrP0Pp+lntJW+hndIpefayzwDfsBdZM/RAKLNlPl00goBCBaRDU4UWlj1wFELQV4Lk7r
 2HSEk09avFTkYYXvd0wwq2r11MM8OfBEiZVkES5xOJS8roL0iV6MBCWl2w3wvoiX7tsg
 l1di1jKt/apygsFjeemyapEOHo8iNvuOYUHvKVtAQDH1V9SvFmC3S+CWTt58ozWGvuli
 cTYgSeEIdcBLKtd36JXcarUX586w9sbPpHvb/SFR/5gPt2gckjcaymGj7M2r5F9ordSu
 s7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729801164; x=1730405964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNSAhqT3SQQ6HzAAu9O/WZUXT3zIdS0OVD849dN+RRI=;
 b=kN5KpZzKGuP3GjmqnCaCt61/mf/I4rL/rszTy1/E382+9zUnEiDQBfpjzkFayTfRle
 3goeYtZ0zReqHn/VfAHM+hLc/LqIZjCn8CiQcymOUtAc5wkhF8+Mgh9a6QLKojW4jCtt
 3ra010ddsLkaVgxFShy5ag/AZq4AgKUbMZvaMCy37fDODmPUd31A8Z9KZHHrjuxL5EeE
 1prjKepymsUtQ2vxla89bEXpGwMnDINis4e6d8N/x6KTM795WJxYXcand7pDf40qx2p6
 G13y3pV1mJvZr13ZbHjaUGhihSrHtGevTr7eIQUCbUM5RmARwYTpGL9stfuZMfz1V7nP
 fj9w==
X-Gm-Message-State: AOJu0YxzhDRGxWDsYJD94lI3nBQT25fDHOH7Y76eujObgZXs5wxVEdMl
 u9gxweUFzXeD+Fw/bk+GdKckj7lnVdp2VLJ3agIhD8vGxAL3OqIOkuBtlmlBo4v3q6J2zR6Mc/Y
 jZfgy3Ffj5ipJ77cKBy9SL85v84eLbg==
X-Google-Smtp-Source: AGHT+IE1DSZOwE3PeC9Yp+Ctuy4k1nSLlktaEVeCyBz5qxt8ih58l0mbLcadO4WDpojeLxm+9oPn41v6oJ14iKX8aY4=
X-Received: by 2002:a05:6a00:2daa:b0:71e:66bb:d33b with SMTP id
 d2e1a72fcca58-72030a087a3mr4611256b3a.1.1729801164185; Thu, 24 Oct 2024
 13:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241024165916.439-1-shashank.sharma@amd.com>
In-Reply-To: <20241024165916.439-1-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Oct 2024 16:19:12 -0400
Message-ID: <CADnq5_Ow836fYOmLboctc6NCyXFgHfjF8zZE9GxUtW3i=hF_mA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add get_gfx_shadow_info callback for gfx12
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Christian Koenig <christian.koenig@amd.com>
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

On Thu, Oct 24, 2024 at 12:59=E2=80=AFPM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> This callback gets the size and alignment requirements
> for the gfx shadow buffer for preemption.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 29 ++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 02244bd2c418..0ac0222b178c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -860,6 +860,34 @@ static void gfx_v12_0_select_me_pipe_q(struct amdgpu=
_device *adev,
>         soc24_grbm_select(adev, me, pipe, q, vm);
>  }
>
> +/* all sizes are in bytes */
> +#define MQD_SHADOW_BASE_SIZE      73728
> +#define MQD_SHADOW_BASE_ALIGNMENT 256
> +#define MQD_FWWORKAREA_SIZE       484
> +#define MQD_FWWORKAREA_ALIGNMENT  256
> +
> +static void gfx_v12_0_get_gfx_shadow_info_nocheck(struct amdgpu_device *=
adev,
> +                                                 struct amdgpu_gfx_shado=
w_info *shadow_info)
> +{
> +       shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
> +       shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNMENT;
> +       shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
> +       shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> +}
> +
> +static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
> +                                        struct amdgpu_gfx_shadow_info *s=
hadow_info,
> +                                        bool skip_check)
> +{
> +       if (adev->gfx.cp_gfx_shadow || skip_check) {
> +               gfx_v12_0_get_gfx_shadow_info_nocheck(adev, shadow_info);
> +               return 0;
> +       }
> +
> +       memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
> +       return -EINVAL;
> +}
> +
>  static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs =3D {
>         .get_gpu_clock_counter =3D &gfx_v12_0_get_gpu_clock_counter,
>         .select_se_sh =3D &gfx_v12_0_select_se_sh,
> @@ -868,6 +896,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_fu=
ncs =3D {
>         .read_wave_vgprs =3D &gfx_v12_0_read_wave_vgprs,
>         .select_me_pipe_q =3D &gfx_v12_0_select_me_pipe_q,
>         .update_perfmon_mgcg =3D &gfx_v12_0_update_perf_clk,
> +       .get_gfx_shadow_info =3D &gfx_v12_0_get_gfx_shadow_info,
>  };
>
>  static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
> --
> 2.46.2
>

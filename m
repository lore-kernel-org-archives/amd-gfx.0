Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275E2EE14D6
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 04:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3E810E418;
	Thu,  7 Sep 2023 04:47:35 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C3F10E418
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 04:47:32 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57656330b80so267035eaf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Sep 2023 21:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694062052; x=1694666852; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hbhg2YPqihYvaiV0kEd0e4rvU+Qplz/EUCzXbA19quE=;
 b=hQCWG6jL4HxM6v36S+Wt49pbshwydQ2dmsePhlLZ18vNi9h88MkQZSjEZ5hXO15nEp
 eG2w3mpEVtQywVZm9GM6iVZH1SBsw7MqgY9dF8EijV+fQVVYj60LayNK80ayZc4avaE+
 F/HseCbFGeMe/oEggQ1aktOgmWtJ7F4gDiLzJ/nzuROPme/5uFS65RMWl/+oCKg7z+ix
 naFnHl6sPzVrLW3LVNoedung2USv7wTflnAMglLD32vDMbnDpFFVID1eBN252a9XZ7R4
 H0TjUJect7R7aZlmLRhBzH3K0y1ZqnLdp26N1K26ZEk+qlHjzT1zXF3pxJqOhDWP1p5Y
 YjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694062052; x=1694666852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hbhg2YPqihYvaiV0kEd0e4rvU+Qplz/EUCzXbA19quE=;
 b=VUTLum/pwmEv4iDzFA9D0Xq7YYk+Q8HV6zojX9WfwXVkQaC8Jr9nxAqA8N//ax56vM
 idiZHFEdPKnHkkZ+wCAqq9TxHRrhGewQ0AxjGdUEiGfDjX+nq6BGNPMBgw5sjTNHmk16
 l8gWQXTShJ0BmTa5LP7J1HSX1JmJXoQ7iMhokT2mpVOcnrPGLT3FplnW9ATfgrE/MCDI
 1k43JgUGDfpIh7IT4H1V41+8P5rB829qC68HDGfmh26jkXeCTevymuxcPcd5JRCsR/fE
 KpRhfPGdTLEx/IzMjGzjAxIqExZOYAX+6N/42q0w96Ebe62CQfdIljTwm5EYq+1aeLgD
 PqbA==
X-Gm-Message-State: AOJu0YzOqxtPvBz6N4Uua2KnFbgdYAZuJR9J6uFcr9ANA/9upzQXDAKy
 9M87E8DyoP3qs6djO4BP3nGQB4a4e/kXrObzqroEl0GQ
X-Google-Smtp-Source: AGHT+IEyLAwcLg9/28dKNvWTH24NSF/HXVez/jqgZq4Cdar2ea095epIa6BZGjgPRYqObZ+zdggYXgAFEyqlxqJm6nI=
X-Received: by 2002:a05:6820:284:b0:571:aceb:26ce with SMTP id
 q4-20020a056820028400b00571aceb26cemr17111286ood.1.1694062051620; Wed, 06 Sep
 2023 21:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230907032500.99796-1-yifan1.zhang@amd.com>
In-Reply-To: <20230907032500.99796-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Sep 2023 00:47:20 -0400
Message-ID: <CADnq5_Pv6+5jwKuL54ghLqQYid66FCQxcUzT5mWihbSehiT+=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add type conversion for gc info
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
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Sep 7, 2023 at 12:20=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> gc info usage misses type conversion.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 5d179edcc8a8..9ab33b0bbbad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1439,12 +1439,12 @@ static int amdgpu_discovery_get_gfx_info(struct a=
mdgpu_device *adev)
>                 adev->gfx.config.num_sc_per_sh =3D le32_to_cpu(gc_info->v=
1.gc_num_sc_per_se) /
>                         le32_to_cpu(gc_info->v1.gc_num_sa_per_se);
>                 adev->gfx.config.num_packer_per_sc =3D le32_to_cpu(gc_inf=
o->v1.gc_num_packer_per_sc);
> -               if (gc_info->v1.header.version_minor >=3D 1) {
> +               if (le16_to_cpu(gc_info->v1.header.version_minor) >=3D 1)=
 {
>                         adev->gfx.config.gc_num_tcp_per_sa =3D le32_to_cp=
u(gc_info->v1_1.gc_num_tcp_per_sa);
>                         adev->gfx.config.gc_num_sdp_interface =3D le32_to=
_cpu(gc_info->v1_1.gc_num_sdp_interface);
>                         adev->gfx.config.gc_num_tcps =3D le32_to_cpu(gc_i=
nfo->v1_1.gc_num_tcps);
>                 }
> -               if (gc_info->v1.header.version_minor >=3D 2) {
> +               if (le16_to_cpu(gc_info->v1.header.version_minor) >=3D 2)=
 {
>                         adev->gfx.config.gc_num_tcp_per_wpg =3D le32_to_c=
pu(gc_info->v1_2.gc_num_tcp_per_wpg);
>                         adev->gfx.config.gc_tcp_l1_size =3D le32_to_cpu(g=
c_info->v1_2.gc_tcp_l1_size);
>                         adev->gfx.config.gc_num_sqc_per_wgp =3D le32_to_c=
pu(gc_info->v1_2.gc_num_sqc_per_wgp);
> @@ -1473,7 +1473,7 @@ static int amdgpu_discovery_get_gfx_info(struct amd=
gpu_device *adev)
>                 adev->gfx.config.num_sc_per_sh =3D le32_to_cpu(gc_info->v=
2.gc_num_sc_per_se) /
>                         le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
>                 adev->gfx.config.num_packer_per_sc =3D le32_to_cpu(gc_inf=
o->v2.gc_num_packer_per_sc);
> -               if (gc_info->v2.header.version_minor =3D=3D 1) {
> +               if (le16_to_cpu(gc_info->v2.header.version_minor =3D=3D 1=
)) {
>                         adev->gfx.config.gc_num_tcp_per_sa =3D le32_to_cp=
u(gc_info->v2_1.gc_num_tcp_per_sh);
>                         adev->gfx.config.gc_tcp_size_per_cu =3D le32_to_c=
pu(gc_info->v2_1.gc_tcp_size_per_cu);
>                         adev->gfx.config.gc_num_sdp_interface =3D le32_to=
_cpu(gc_info->v2_1.gc_num_sdp_interface); /* per XCD */
> --
> 2.37.3
>

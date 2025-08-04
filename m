Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540C3C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 14:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAED510E09A;
	Mon,  4 Aug 2025 14:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O23p0X7n";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FE010E09A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:16:23 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b3510c22173so499113a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754316983; x=1754921783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmvTMUm/ICs/ahFcRTrwKfKZlA+J5p75DnclZMp8JVE=;
 b=O23p0X7n6UPwXDz/INsqhYyf8h0TepAWHOrvx1xG/bGjnEBMNiObSlfZcNIi2VjB/9
 LYqF5juLldZ+n4GiJAoMI8SZYSHWcA8BDomr6EPo2V8fOMMlLGn2OgkkZMKweuAcFiX5
 N7iNWGx9/3Uqtfsbl/11cJp/79G87rz2nlRrUBr2V8vqdZ59thqTeScJty0j2s5S+mf1
 RQXu9BsPuV6MEb+tUfUgpBRr25wngv/zk9oSOpo+W2/6so7m2gv98Cz4wjE03L0+y4FK
 BX8btNZuClsaDJNqIGAKhPBGgWG9Ll9uvUMKw1ZwCGLtuajBzMQTap2tHaDPrWwh/b54
 EgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754316983; x=1754921783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TmvTMUm/ICs/ahFcRTrwKfKZlA+J5p75DnclZMp8JVE=;
 b=jqVoFnkFzxGxHC785QqmnB49qFoW4IkDBhUhrpY/yaffTZ8j8/MuZi0zg6r/5yp/BZ
 9xU06bDHpwSV06S9r8P5/drF4H7hkuiUUbf42zRXp4tzZ/KtrcsV0v0RAQqq13aXceml
 IWCehMHTP3ekTbH6gfZxG718ab4dslKV3zKoRRK6622obxO/M/usryAYZeYu5JhYUm8Z
 iMp59NkVYfx1hXwyBBy1+vO8ZieiubGB5uQfPT5s6e0Th4YrfPLrx5SlcUTcfqFhahHj
 q+4Jgz5ROgwhvjL5yXeRAkWbWkodC30YirfdfD6W7Z3iJYn9asVZx6KwRKge/j53etRQ
 3TSA==
X-Gm-Message-State: AOJu0YyNtQLoH6oe7MfExYJeYrtc4gHBdVHpn7Nc3BtNk1GxlLhSM9t7
 eaTfXeBBpzjeArdm0ccDHq+OvQaqQ90lx5MzXv7x87t3R35WJa6mzIWpBIBgUAi1DmFl+ZZO3Ba
 AQ7h//mhyvqXWZt8GDOzyA7dFYIJsnJs=
X-Gm-Gg: ASbGncsIxSvTZPigEGGdJU3hNBkkl/yEZSp+KrFsUrCpmgjo2LqTRPCZMrDkksTGVo4
 NetR6d3NhInI67EUJchEnubAcqYcS9CT2MeMr+PQxQO0wpFF1ANiWnP8SqSdFMDS+2Bmn69phSW
 6Oc5731afBMWZ5QFEX4bL3h2tl9aQ4W+sz2Nn2rC7jmtPtF0UrDPwR7ot+jAyACZjYKDlO0MIoZ
 s1x4yVn
X-Google-Smtp-Source: AGHT+IEq9ico+45e/lWfZTSuRxPqOjzXQJMO2yAHWmdAa65USJLAotkgDCF+yqF+5AE4SZTACL6/e7N5WK72/jKfKNA=
X-Received: by 2002:a17:902:ef4e:b0:240:729c:a022 with SMTP id
 d9443c01a7336-24246fef45bmr57133095ad.11.1754316983052; Mon, 04 Aug 2025
 07:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250730155900.22657-1-alexander.deucher@amd.com>
In-Reply-To: <20250730155900.22657-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 10:16:11 -0400
X-Gm-Features: Ac12FXwJy7sUb93YuMFGFJPMXM7DzaATuAsXfBApHodn4ZPc1FpuDIyjdvdjb4g
Message-ID: <CADnq5_NtBWyQozzv2wih6cp7Ado+nBf7hd_N+oGXsd0H_JadKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/discovery: fix fw based ip discovery
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
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

Ping?

Alex

On Wed, Jul 30, 2025 at 12:18=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> We only need the fw based discovery table for sysfs.  No
> need to parse it.  Additionally parsing some of the board
> specific tables may result in incorrect data on some boards.
> just load the binary and don't parse it on those boards.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4441
> Fixes: 80a0e8282933 ("drm/amdgpu/discovery: optionally use fw based ip di=
scovery")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 72 ++++++++++---------
>  2 files changed, 41 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index efe98ffb679a4..b2538cff222ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2570,9 +2570,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct a=
mdgpu_device *adev)
>
>         adev->firmware.gpu_info_fw =3D NULL;
>
> -       if (adev->mman.discovery_bin)
> -               return 0;
> -
>         switch (adev->asic_type) {
>         default:
>                 return 0;
> @@ -2594,6 +2591,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct a=
mdgpu_device *adev)
>                 chip_name =3D "arcturus";
>                 break;
>         case CHIP_NAVI12:
> +               if (adev->mman.discovery_bin)
> +                       return 0;
>                 chip_name =3D "navi12";
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 81b3443c8d7f4..27bd7659961e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2555,40 +2555,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_=
device *adev)
>
>         switch (adev->asic_type) {
>         case CHIP_VEGA10:
> -       case CHIP_VEGA12:
> -       case CHIP_RAVEN:
> -       case CHIP_VEGA20:
> -       case CHIP_ARCTURUS:
> -       case CHIP_ALDEBARAN:
> -               /* this is not fatal.  We have a fallback below
> -                * if the new firmwares are not present. some of
> -                * this will be overridden below to keep things
> -                * consistent with the current behavior.
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
>                  */
> -               r =3D amdgpu_discovery_reg_base_init(adev);
> -               if (!r) {
> -                       amdgpu_discovery_harvest_ip(adev);
> -                       amdgpu_discovery_get_gfx_info(adev);
> -                       amdgpu_discovery_get_mall_info(adev);
> -                       amdgpu_discovery_get_vcn_info(adev);
> -               }
> -               break;
> -       default:
> -               r =3D amdgpu_discovery_reg_base_init(adev);
> -               if (r) {
> -                       drm_err(&adev->ddev, "discovery failed: %d\n", r)=
;
> -                       return r;
> -               }
> -
> -               amdgpu_discovery_harvest_ip(adev);
> -               amdgpu_discovery_get_gfx_info(adev);
> -               amdgpu_discovery_get_mall_info(adev);
> -               amdgpu_discovery_get_vcn_info(adev);
> -               break;
> -       }
> -
> -       switch (adev->asic_type) {
> -       case CHIP_VEGA10:
> +               amdgpu_discovery_init(adev);
>                 vega10_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 2;
>                 adev->gmc.num_umc =3D 4;
> @@ -2611,6 +2582,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 0, 0);
>                 break;
>         case CHIP_VEGA12:
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
> +                */
> +               amdgpu_discovery_init(adev);
>                 vega10_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 2;
>                 adev->gmc.num_umc =3D 4;
> @@ -2633,6 +2609,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 0, 1);
>                 break;
>         case CHIP_RAVEN:
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
> +                */
> +               amdgpu_discovery_init(adev);
>                 vega10_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 1;
>                 adev->vcn.num_vcn_inst =3D 1;
> @@ -2674,6 +2655,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 }
>                 break;
>         case CHIP_VEGA20:
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
> +                */
> +               amdgpu_discovery_init(adev);
>                 vega20_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 2;
>                 adev->gmc.num_umc =3D 8;
> @@ -2697,6 +2683,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 1, 0);
>                 break;
>         case CHIP_ARCTURUS:
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
> +                */
> +               amdgpu_discovery_init(adev);
>                 arct_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 8;
>                 adev->vcn.num_vcn_inst =3D 2;
> @@ -2725,6 +2716,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 adev->ip_versions[UVD_HWIP][1] =3D IP_VERSION(2, 5, 0);
>                 break;
>         case CHIP_ALDEBARAN:
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
> +                */
> +               amdgpu_discovery_init(adev);
>                 aldebaran_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 5;
>                 adev->vcn.num_vcn_inst =3D 2;
> @@ -2751,6 +2747,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 1, 0);
>                 break;
>         default:
> +               r =3D amdgpu_discovery_reg_base_init(adev);
> +               if (r) {
> +                       drm_err(&adev->ddev, "discovery failed: %d\n", r)=
;
> +                       return r;
> +               }
> +
> +               amdgpu_discovery_harvest_ip(adev);
> +               amdgpu_discovery_get_gfx_info(adev);
> +               amdgpu_discovery_get_mall_info(adev);
> +               amdgpu_discovery_get_vcn_info(adev);
>                 break;
>         }
>
> --
> 2.50.1
>

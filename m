Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C244C5478C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 13:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B1E10EEBF;
	Fri,  1 Mar 2024 13:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XSOFJ8r5";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBB610EEC0
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 13:55:22 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-6da4a923b1bso1851814b3a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Mar 2024 05:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709301322; x=1709906122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xbc3RQ8SHn0YDrMV/nPosP6LPzEbfc+pumvUAR5tZQQ=;
 b=XSOFJ8r5T5YBR8dZljQtJYsSK5wl4DObP/yxLFSWVoXaO8KIajZjNud+sGgW7xCPh1
 WbKUdVkyiZNqzN2CcJrKYUaQbjxe+D2hAPdoiAZglAc52Pav2KVBGBdjXa8bo0EMPQ4I
 9Nq9MLb/dFS4df98ffgRIR/woJsfcWaInoz3mNL7ylDIXLF2vDVNPsKZ5OXeGfCkkRBE
 I4+j3SsUXKobzAh5Ou2BDac78lizQKQxDPJwGPOU5ca6En6AgyJTgqr77RnxDPBGF2dd
 ndBVOmAKxWQ3nXC2Y+1d0Da9Si59I8q2sFm7F061HjN+zjoaHRTUl1DGp+dWMQYFISqf
 5JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709301322; x=1709906122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xbc3RQ8SHn0YDrMV/nPosP6LPzEbfc+pumvUAR5tZQQ=;
 b=LUXiWePBfD6lPQiU2c7TiciO+y+uA9fD8xATsB9I7fyCxSU60u/Y7ZzxzdJSeBhkuw
 kARC68X0XlC/7iEx9XFl+Hfh5ljZh999VA+Ya1Ip94bZpo/SjfPcnQHFZEmccK1ysq8H
 +v6+4Axn4waq87FwyXFQlhlVCnPS4N7YhJpBnmwehRdMzzerXvuA2yQT6KbNQOy0fg/F
 2/kk3RFVuyKYIqwfJe11L3w0j/2/S2EWDeR8gxrGcBNCba/3E2NyGJwxxtqQZLSMUXca
 n5T5sfQhkKybFCpaAZ4ijUVJ6cl3ok8jTheXNksNDKmVZGS4yrsnRM0uXC+8eBKEAxsh
 LUNA==
X-Gm-Message-State: AOJu0Yy0nSZ1fWjHeHiiVp+V3XC5MF+1iecVY64LZTR3GC7C3SY44uqx
 KDEmVIOVwS/by36He4gJ2tsDQX9DxheTy0ZPQAZlaf8O3qE/vV/B6Tajwa2jyPqL/3Qd3Zy7tpr
 BdnFFdMQa9aGyShI1BqAXx/lwUned3ICl
X-Google-Smtp-Source: AGHT+IHoUcPOTVzO7p+OpT6RGiWYfrhkpEh7BeMoN2fEV61vtQRice1JwkeG7Q4yq8aBxg7hP82pLg8Mvcob3tqlTAI=
X-Received: by 2002:a05:6a20:3d81:b0:1a0:f6ea:f41c with SMTP id
 s1-20020a056a203d8100b001a0f6eaf41cmr2103545pzi.13.1709301322146; Fri, 01 Mar
 2024 05:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20240228211154.3498505-1-alexander.deucher@amd.com>
In-Reply-To: <20240228211154.3498505-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 Mar 2024 08:55:09 -0500
Message-ID: <CADnq5_N5P35-s3Gy3ziNCQ1P4a1AhYReDe-J432w8ZtUkDcPrg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: handle range offsets in VRR ranges
To: Alex Deucher <alexander.deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Wed, Feb 28, 2024 at 4:12=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Need to check the offset bits for values greater than 255.
>
> v2: also update amdgpu_dm_connector values.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3203
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 32efce81a5a74..4e4cbf2e33dd2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -11292,14 +11292,23 @@ void amdgpu_dm_update_freesync_caps(struct drm_=
connector *connector,
>                                 if (range->flags !=3D 1)
>                                         continue;
>
> -                               amdgpu_dm_connector->min_vfreq =3D range-=
>min_vfreq;
> -                               amdgpu_dm_connector->max_vfreq =3D range-=
>max_vfreq;
> -                               amdgpu_dm_connector->pixel_clock_mhz =3D
> -                                       range->pixel_clock_mhz * 10;
> -
>                                 connector->display_info.monitor_range.min=
_vfreq =3D range->min_vfreq;
>                                 connector->display_info.monitor_range.max=
_vfreq =3D range->max_vfreq;
>
> +                               if (edid->revision >=3D 4) {
> +                                       if (data->pad2 & DRM_EDID_RANGE_O=
FFSET_MIN_VFREQ)
> +                                               connector->display_info.m=
onitor_range.min_vfreq +=3D 255;
> +                                       if (data->pad2 & DRM_EDID_RANGE_O=
FFSET_MAX_VFREQ)
> +                                               connector->display_info.m=
onitor_range.max_vfreq +=3D 255;
> +                               }
> +
> +                               amdgpu_dm_connector->min_vfreq =3D
> +                                       connector->display_info.monitor_r=
ange.min_vfreq;
> +                               amdgpu_dm_connector->max_vfreq =3D
> +                                       connector->display_info.monitor_r=
ange.max_vfreq;
> +                               amdgpu_dm_connector->pixel_clock_mhz =3D
> +                                       range->pixel_clock_mhz * 10;
> +
>                                 break;
>                         }
>
> --
> 2.44.0
>

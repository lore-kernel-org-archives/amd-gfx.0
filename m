Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D466C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 14:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2401110E047;
	Fri,  5 Jan 2024 14:02:48 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F15AF10E047
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 14:02:46 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-204ec50010eso678594fac.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jan 2024 06:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704463366; x=1705068166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXJd6bIfgI4JVHpvXvSqGZc1mxLUUdw43IM9bFZL2Ek=;
 b=D2eKWkTd7ugqIPsDEmL0Er+NfDMeDE1m4YciuJFre8bt3Yznaz2rMCfkHR0nxXkzCy
 FM060NTPHq3PScKAzeDBrvOR5F0HT9WuvZGVpy+q6EFbmNJOaM0IH6E/P8XjkwAB0BuD
 r3h0XuQNTbHB2saXUa9GnjGS37Ptv8+EYfLGPrycO+syLfqujjaO+cWfyWzBaAm/50FF
 7kckFbfzD4WKmNLrtU4PBmmiuny4RUiWpqtYpaLZoBmzRSt5rudm/TYSlGUQYot2WVdr
 j65ZYHQ6yNHvEFLq5RlCf8mzeB1W7GnTyWHhNn4O2WmoNGARYQ7z3jI9Yd1qYLb0XFCt
 L7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704463366; x=1705068166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXJd6bIfgI4JVHpvXvSqGZc1mxLUUdw43IM9bFZL2Ek=;
 b=cAOYVBap0PTZw3z1SrfSMtqh2KOMV/XFg4iCj3Kyp4iarZbQJzHuDSJW2LeSJT1hO6
 zxIWZHzMwiguGnLMyz3Xjc7SyujUNvPRX9wl+PajVSjb+Zh/+o5EMsZZ8pF229ZN68Uz
 HuAKESlAPp25HRI+gZyZqMG3e6L0PawqoadJdbIThwjvu22QBsywVTjiUApiRPgPX5t1
 VjOpEZqDl9QpAQbgPAiW2bN/MAHXjpBNny/BKEW6I5XzsXGlW+vywDZRRD/vd8pdFUa4
 JzQ6b4AQS2gV7Ji+VpITUfjitPdbi+s8KmkcL6jZ9Oe0K1qt0Wxuj5KVKNKUonrH+T4E
 TLcA==
X-Gm-Message-State: AOJu0Yz00dhXdqAdROHV+s5Kj8VJBIawrFJ40byOSCLaFrkPpX6MH2Sf
 OPmYcnbm4ZMdu+hLwogFLL+Yb0696s9LIqvVQfU=
X-Google-Smtp-Source: AGHT+IHjWbruYP6fVQynzYaFrhhseKBInqMrnlu2kT+9A1lkN5JZe4nVUqp5wDykEKRFp+W/UG7q0ke7NdshpGmo1Nc=
X-Received: by 2002:a05:6871:a68f:b0:204:24c4:3330 with SMTP id
 wh15-20020a056871a68f00b0020424c43330mr1902409oab.44.1704463365986; Fri, 05
 Jan 2024 06:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20231213212729.1965153-1-alexander.deucher@amd.com>
In-Reply-To: <20231213212729.1965153-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jan 2024 09:02:34 -0500
Message-ID: <CADnq5_MkzcTThbTdGqeOw6ffCSRDhk=LMENkriF_iavGO3fZiQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: fix avg vs input power reporting on smu7
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping on this series?

Alex

On Wed, Dec 13, 2023 at 4:55=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Hawaii, Bonaire, Fiji, and Tonga support average power, the others
> support current power.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 11372fcc59c8..a2c7b2e111fa 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -3995,6 +3995,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr,=
 int idx,
>         uint32_t sclk, mclk, activity_percent;
>         uint32_t offset, val_vid;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> +       struct amdgpu_device *adev =3D hwmgr->adev;
>
>         /* size must be at least 4 bytes for all sensors */
>         if (*size < 4)
> @@ -4038,7 +4039,21 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr=
, int idx,
>                 *size =3D 4;
>                 return 0;
>         case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
> -               return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
> +               if ((adev->asic_type !=3D CHIP_HAWAII) &&
> +                   (adev->asic_type !=3D CHIP_BONAIRE) &&
> +                   (adev->asic_type !=3D CHIP_FIJI) &&
> +                   (adev->asic_type !=3D CHIP_TONGA))
> +                       return smu7_get_gpu_power(hwmgr, (uint32_t *)valu=
e);
> +               else
> +                       return -EOPNOTSUPP;
> +       case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
> +               if ((adev->asic_type !=3D CHIP_HAWAII) &&
> +                   (adev->asic_type !=3D CHIP_BONAIRE) &&
> +                   (adev->asic_type !=3D CHIP_FIJI) &&
> +                   (adev->asic_type !=3D CHIP_TONGA))
> +                       return -EOPNOTSUPP;
> +               else
> +                       return smu7_get_gpu_power(hwmgr, (uint32_t *)valu=
e);
>         case AMDGPU_PP_SENSOR_VDDGFX:
>                 if ((data->vr_config & VRCONF_VDDGFX_MASK) =3D=3D
>                     (VR_SVI2_PLANE_2 << VRCONF_VDDGFX_SHIFT))
> --
> 2.42.0
>

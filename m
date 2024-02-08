Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CF0C48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 16:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84DF10E99F;
	Thu,  8 Feb 2024 16:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L+s9Y37g";
	dkim-atps=neutral
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C18BF10E99F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 16:55:35 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-2143a96d185so885149fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Feb 2024 08:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707411335; x=1708016135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JLY9ZumtHCANbV8MI2shzZgt4g2uU23bbF1//hYQhM=;
 b=L+s9Y37gpK683afsxYFqz2aMllw2WruVcQw9HT+L+W4T0+2HIplYwZBIQcrj81fbc1
 MHcB/OjEydedZDQ4hkWbtoSPkyzuSimsCQsu4XDjX21DsU2HS2FOPFxWmwTILqZgr7oc
 weD6k83FaLsKO5ILBdINAFRKHG7IXSYTD4iqE6p4hm3RDO/zUzO3XgA4HGToV3IlaKCw
 ftVmElIjDf8/7LiXLvxh2J+tzMIAN5dDg/VytL/4N5bsc1tC881vmVovlfebSUF4zX9U
 MrCf3TbuZ+gxHBy+IY0ySRUJvDoqLZt8MOHynQDJy1cCSewXihAYuydRZ+4J5Oe3T9dR
 g3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707411335; x=1708016135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JLY9ZumtHCANbV8MI2shzZgt4g2uU23bbF1//hYQhM=;
 b=jxcEt77YXkTVKRlexvvCdSKbz/ICAXfNoVniSqN4g0NYseX7hU9o9ihwJrQfr8xdUe
 wOTPbHDigVTwie7KNvNVDeBtXbMDa6VAJv6lEZEXIABdBp9RbIW602IVORg7wcea5Je/
 Q1+xy4L8HmtwObfx7w3o6n3Wldr3+od8s7BFH3NzZOeEURfg4gnZfsb+0zmvyW2XGsvY
 OpWeQ2i3dLc7xavx6SpSRalsTOrb4Og6QBcLz4lTzP5T02v008zWdMCRBcHuS1A3yieI
 tJGjTujgnj4dgJbJfPXvY9iI33AKoIrp3BoQe455pyMNlGauvikmrmcc5MlwObaj+rXT
 yIlg==
X-Gm-Message-State: AOJu0YzH/oitGiIqnN58U1fdvOQrh7Q9KNsdOwa3l5YLd9e/0vEDt2yS
 E99OA1WxZof5RoQU6W9e03Ca8jkZBxx5wuiVzk3vPSTIun4XjKuuZAYE1Q0QwEXeCj1Yjp2RVXh
 0u8Y4bq3FqoAzvM7+WM0qIdPdn7GEqZCo
X-Google-Smtp-Source: AGHT+IHK+fqn6BVLOuqtbnYxy+FrzWFJDciLYoqFJVYYpY6DmOSS2HAXojSHKRfoteVMftC8ToSKwmMImT+xVj+nLfY=
X-Received: by 2002:a05:6870:a710:b0:219:cea4:6bd4 with SMTP id
 g16-20020a056870a71000b00219cea46bd4mr5486675oam.38.1707411334736; Thu, 08
 Feb 2024 08:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20240208055256.130917-1-mario.limonciello@amd.com>
 <20240208055256.130917-2-mario.limonciello@amd.com>
In-Reply-To: <20240208055256.130917-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Feb 2024 11:55:22 -0500
Message-ID: <CADnq5_MZRuCsAza+2x5cfFjFoJdfe92SaNvPV5QDMTbEAR1QKQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drm/amd: Stop evicting resources on APUs in suspend
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
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

On Thu, Feb 8, 2024 at 1:48=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 5095d5418193 ("drm/amd: Evict resources during PM ops prepare()
> callback") intentionally moved the eviction of resources to earlier in
> the suspend process, but this introduced a subtle change that it occurs
> before adev->in_s0ix or adev->in_s3 are set. This meant that APUs
> actually started to evict resources at suspend time as well.
>
> Explicitly set s0ix or s3 in the prepare() stage, and unset them if the
> prepare() stage failed.
>
> Reported-by: J=C3=BCrg Billeter <j@bitron.ch>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3132#note_2271038
> Fixes: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() ca=
llback")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v3->v4:
>     * New function to set s0ix/s3 and explicitly unset in cleanup
> v2->v3:
>     * Whitespace
> v1->v2:
>     * Add and use new in_prepare member
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   | 15 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++--
>  3 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 3d8a48f46b01..f6c38a974bae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1547,9 +1547,11 @@ static inline int amdgpu_acpi_smart_shift_update(s=
truct drm_device *dev,
>  #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
>  bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
> +void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
>  #else
>  static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev=
) { return false; }
>  static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) =
{ return false; }
> +static void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { =
}
>  #endif
>
>  #if defined(CONFIG_DRM_AMD_DC)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 2deebece810e..cc21ed67a330 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1519,4 +1519,19 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_devi=
ce *adev)
>  #endif /* CONFIG_AMD_PMC */
>  }
>
> +/**
> + * amdgpu_choose_low_power_state
> + *
> + * @adev: amdgpu_device_pointer
> + *
> + * Choose the target low power state for the GPU
> + */
> +void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
> +{
> +       if (amdgpu_acpi_is_s0ix_active(adev))
> +               adev->in_s0ix =3D true;
> +       else if (amdgpu_acpi_is_s3_active(adev))
> +               adev->in_s3 =3D true;
> +}
> +
>  #endif /* CONFIG_SUSPEND */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 2bc460cb993d..dab03865c827 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4518,13 +4518,15 @@ int amdgpu_device_prepare(struct drm_device *dev)
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
>         int i, r;
>
> +       amdgpu_choose_low_power_state(adev);
> +
>         if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>                 return 0;
>
>         /* Evict the majority of BOs before starting suspend sequence */
>         r =3D amdgpu_device_evict_resources(adev);
>         if (r)
> -               return r;
> +               goto unprepare;
>
>         for (i =3D 0; i < adev->num_ip_blocks; i++) {
>                 if (!adev->ip_blocks[i].status.valid)
> @@ -4533,10 +4535,15 @@ int amdgpu_device_prepare(struct drm_device *dev)
>                         continue;
>                 r =3D adev->ip_blocks[i].version->funcs->prepare_suspend(=
(void *)adev);
>                 if (r)
> -                       return r;
> +                       goto unprepare;
>         }
>
>         return 0;
> +
> +unprepare:
> +       adev->in_s0ix =3D adev->in_s3 =3D false;
> +
> +       return r;
>  }
>
>  /**
> --
> 2.34.1
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F148CC001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 13:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CED610E0E7;
	Fri, 11 Aug 2023 13:44:35 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA56310E0E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 13:44:33 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a7d4030621so1131834b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691761473; x=1692366273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DQ3CKMvp5kJtA+6HaNhPbNicxpIFbMz32rBcSSatu8=;
 b=hIpvo4lCwxwLOuzNPLG8rt5EmOSgRiupr8WIc0n3FGdj4DbKBticMFmBrJMeu7UOmq
 e9iyNd0vplkg5uTlf0IKZcdKglO6FnqZU8NokVKmNgu9um3mi8rNIMTEGh/geGU1BXEW
 LWjNftBB46RAmojWfVkvTFKPrEYQrc7cNl46SBrJO2DvJywQi3tTliyMuJRxuUk3+HFI
 Aq8hYDJaHuKQlbbm/g4OuiGNSVcEukQcZYmfpaaFqKtdkNPz+U7s81E58Fu2HOAEOIX2
 rVFy4t9AnsPQOGCP6kWPQdii+BIUiu5O41hExfasrn6/xRAtrU4SANkGPsTtJcgOlkwD
 amNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691761473; x=1692366273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DQ3CKMvp5kJtA+6HaNhPbNicxpIFbMz32rBcSSatu8=;
 b=arm/T0kKgiB+NW9XkNMpR6JzGal5ZfikWPzXKNqtCGVh5r9vhq0VtXPMIsemkpfNVq
 tmafZv/YpGrqAqVKJYCsQStwcib6qHDm9UvLI2dD0zqY8DxVDcTSW0T8gFvnSL0TDP7X
 IMbd8Avh/NoZ7J5sXUH1vzHDDpE2tG3LkjZ+S7vKdI4bGqPACqB88C1JhVCwT1/gqOF/
 UWFrgumWda0cVDUdAyzzgHPPf/w314Ns6EbgmWHi/W4xPgco3HdZHnXVvqAAv3QU9H/x
 NwSeUh5RzjWzL5MX11WUeAJ8QXuIy3lnx8r9XRCwTsQNpaJow1G3iyS53OQxc61FQZYi
 xKfw==
X-Gm-Message-State: AOJu0YwtC6r7H5Fqi7OYeGntTAPzwIenFWTmGDqz0mMrU+yZbQonJJ2P
 GsQfM0FFhh38+weR7REpdCKNBbcsJkN1M8+OWFTmFW3z
X-Google-Smtp-Source: AGHT+IFXQld4mq5YTmYHJZDDbjexzltFvmtFtjKXGEKuLz93Eox39HR1uTBeWq+E0kbhMJ514PSILuicHlsFu4eexNk=
X-Received: by 2002:a05:6808:6d4:b0:3a3:fa64:bb8d with SMTP id
 m20-20020a05680806d400b003a3fa64bb8dmr1801961oih.10.1691761472675; Fri, 11
 Aug 2023 06:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230810103202.141225-1-mario.limonciello@amd.com>
 <20230810103202.141225-9-mario.limonciello@amd.com>
In-Reply-To: <20230810103202.141225-9-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Aug 2023 09:44:21 -0400
Message-ID: <CADnq5_PeZtgBCTwEXv3OMxGD9Sz7j5cM_VDhev+=nzgO9nUdHA@mail.gmail.com>
Subject: Re: [PATCH 9/9] drm/amd: Hide unsupported power attributes
To: Mario Limonciello <mario.limonciello@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Aug 10, 2023 at 11:40=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Some ASICS only offer one type of power attribute, so in the visible
> callback check whether the attributes are supported and hide if not
> supported.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 8133d968f75b9..5b1d73b00ef73 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3179,6 +3179,7 @@ static umode_t hwmon_attributes_visible(struct kobj=
ect *kobj,
>         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
>         umode_t effective_mode =3D attr->mode;
>         uint32_t gc_ver =3D adev->ip_versions[GC_HWIP][0];
> +       uint32_t tmp;
>
>         /* under multi-vf mode, the hwmon attributes are all not supporte=
d */
>         if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> @@ -3264,6 +3265,14 @@ static umode_t hwmon_attributes_visible(struct kob=
ject *kobj,
>             (attr =3D=3D &sensor_dev_attr_power1_average.dev_attr.attr))
>                 return 0;
>
> +       /* not all products support both average and instantaneous */
> +       if (attr =3D=3D &sensor_dev_attr_power1_average.dev_attr.attr &&
> +           amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_AV=
G_POWER, (void *)&tmp) =3D=3D -EOPNOTSUPP)
> +               return 0;
> +       if (attr =3D=3D &sensor_dev_attr_power1_input.dev_attr.attr &&
> +           amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_IN=
PUT_POWER, (void *)&tmp) =3D=3D -EOPNOTSUPP)
> +               return 0;
> +
>         /* hide max/min values if we can't both query and manage the fan =
*/
>         if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) =3D=3D -EOPNOTS=
UPP) &&
>               (amdgpu_dpm_get_fan_speed_pwm(adev, NULL) =3D=3D -EOPNOTSUP=
P) &&
> --
> 2.34.1
>

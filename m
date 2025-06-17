Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BF2C71155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 02:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D8610E0DA;
	Tue, 17 Jun 2025 02:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZV3R2n4c";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CED310E0DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 02:53:38 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-312efc384fcso950343a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 19:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750128818; x=1750733618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arE+5sm22uMkUg3lJy1VDfIJkkn83pCsohYueeKOKmM=;
 b=ZV3R2n4cDSSm19hgqCCCoKTt6/7YolYke0EtPzumo30Le7oI0RyZyoZ1qjUTZ0X51U
 gNdJIymbiVQbZevCfJ5M9NF4kxHpp33RslJXsuhPvX1IhEFd62QoPyvxlYe/1+aepf3b
 ZPK172gYQF8SAnCE5zfjDf+2uSI1qF1Q8JpfZOSApz1CPV/x9UntM1W8wC8W/pCeNoLA
 cPPBv51hAHo07+9FpIW0fSPzUiuGLdzqxA5azNLdDaZ4bFxR42m1fIzWQXfGtUAJFtgB
 DjwQzMqebdWUYuuTjMTTSmi9IEbSxKXZV4qvSid3rPc1lTbgU9bDJFS5xkicmn/7OMLn
 uqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750128818; x=1750733618;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arE+5sm22uMkUg3lJy1VDfIJkkn83pCsohYueeKOKmM=;
 b=J6oboNRBglsImHWyGICjH9roltPhPyZQK53SvSuR6qHH3V5RVTRC8N3Hqym9MG14P4
 Qv3igPC90xdxnXOeh38mDD5vkNdBr+06F422zmRIhY8gbzRtMCheA+QK6ASnQNgM2vpk
 jCDNzW2+z5P3sgKMscD2T4Zm8w3Y9XPzfH89znZVJwiS9zjDqpcKi1qlPc+zvczHutWx
 BlaZJe3TTRkbtk5E+XdUXC52da72zypXdTXs3/lC1xqVdp708BBb14Mm9KohYWOn71n5
 T3ifIc5QU9GVf6j2stfzq5AOLENS04OBPWqr5aN/hlDEkDt1jnAtbp/FAdvAQ/5Kq0MN
 3s1w==
X-Gm-Message-State: AOJu0Yz0llHuethREK3gGPR13Pvnls1OHN285xRuZ/0wwcYYMr5GTs8e
 POZUtvIyYUCXLzMpCzlvMzr9UOgaTUd6FnJSAWnM/HhWlL6MGgp6hMZByfireEUfNcz8ui5T5WW
 yH2Oz8VPxLIm2HgmPweKive6UfCjH2PYI5A==
X-Gm-Gg: ASbGncs/vbs4d73jT5i2v/v7wg+EbKYrg5sLlFJk88Lekga0LoQ9Lbz3k8asUWlF4Js
 oj4LoFahNpkaevMkCfILsUr1NhJl4R9p2gcXJf8TsJZBZi/KJuyeJWQ4A31zjLMa7o5vP+Ka30v
 8mhm3HHEfmLsU6CWJZE32nGBOBLG40b8zN3q4elsaN1yiR
X-Google-Smtp-Source: AGHT+IFC95IfwuoeUsG1XdYwK7zN8w76qHw80jNWC+tboYYqUmZimhqcvQNm2d1OI38ufhGcjomRCa1cs4zUtsO7RLI=
X-Received: by 2002:a17:90b:2787:b0:311:488:f506 with SMTP id
 98e67ed59e1d1-31425b0421amr915359a91.6.1750128818227; Mon, 16 Jun 2025
 19:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250616201552.4022366-1-superm1@kernel.org>
In-Reply-To: <20250616201552.4022366-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jun 2025 22:53:26 -0400
X-Gm-Features: AX0GCFuwQ11IjTK-Lhg6yWX5kLeFBRvH1ELl_yLdduiokwAbtqcXmN-MtiYyXq0
Message-ID: <CADnq5_PAR3sW9bFPwCfzJYGKqBygNDk=rrifBkb3q_E58396UQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add a sysfs file to detect whether a GPU is an
 APU
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Mon, Jun 16, 2025 at 4:21=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> In order to discover whether a GPU is part of a dGPU or APU userspace has
> to do some mental gymnastics or heuristics.  Add a sysfs file that clearl=
y
> indicates to userspace.

You can already query this via the INFO IOCTL.  What use case did you
have in mind for this interface?

Alex

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c     | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h |  1 +
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index edd9895b46c02..4e4c77488e334 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -945,6 +945,21 @@ static ssize_t amdgpu_get_pp_features(struct device =
*dev,
>         return size;
>  }
>
> +/**
> + * DOC: apu
> + *
> + * Represents whether GPU is on a dGPU (0) or APU (1)
> + */
> +static ssize_t amdgpu_get_apu(struct device *dev,
> +                             struct device_attribute *attr,
> +                             char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +       return sysfs_emit(buf, "%d\n", adev->flags & AMD_IS_APU ? 1 : 0);
> +}
> +
>  /**
>   * DOC: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk=
 pp_dpm_pcie
>   *
> @@ -2287,6 +2302,7 @@ static struct amdgpu_device_attr amdgpu_device_attr=
s[] =3D {
>                               .attr_update =3D ss_bias_attr_update),
>         AMDGPU_DEVICE_ATTR_RO(pm_metrics,                               A=
TTR_FLAG_BASIC,
>                               .attr_update =3D amdgpu_pm_metrics_attr_upd=
ate),
> +       AMDGPU_DEVICE_ATTR_RO(apu,                                      A=
TTR_FLAG_BASIC),
>  };
>
>  static int default_attr_update(struct amdgpu_device *adev, struct amdgpu=
_device_attr *attr,
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd=
/pm/inc/amdgpu_pm.h
> index c12ced32f7808..ffd008c1e6ec2 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> @@ -78,6 +78,7 @@ enum amdgpu_device_attr_id {
>         device_attr_id__smartshift_dgpu_power,
>         device_attr_id__smartshift_bias,
>         device_attr_id__pm_metrics,
> +       device_attr_id__apu,
>         device_attr_id__count,
>  };
>
> --
> 2.43.0
>

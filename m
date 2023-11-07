Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A479FC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 15:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C3F10E14B;
	Tue,  7 Nov 2023 15:40:22 +0000 (UTC)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2DC10E073
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 15:35:59 +0000 (UTC)
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-45dad6ece90so1392323137.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Nov 2023 07:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699371358; x=1699976158; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BZqwEk90H97hbODv9brPBFZE2JhJMU7rcldMtR9zCqM=;
 b=o+EqWpLJXasRZJSCHQlvxSN0AyAu5WL4er+qyH0zmoK3XzFL15KZqExXbIq16d4doU
 6MiqK11vTpB+0YJ7YFIq/aB/hpqtb34NgEnXirbqJuiZuk2OYt9GPAdBxoApkA3hbT02
 UVAg/bzqJ2g9aS1F4GdjeGIm+oaTzAU7fZHnyV0GSuNPVHObAeMtWogvbllrk71Xow5S
 BC6KCTYjbahaxWOU22NltH1XGPyFUtMywWHgrrP07QEHb+rWKlUgSzBU1D6e2Ov7FRO3
 zgh0yA/sAYx8RiLZkzfimvhyG7ma03VdO5jI8hmwt00JHiAmqQ6FHB/hM9u5VPjQXpFW
 9zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699371358; x=1699976158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BZqwEk90H97hbODv9brPBFZE2JhJMU7rcldMtR9zCqM=;
 b=HZBkskH0oxJSIQ3BcwqnBT8k0v8qE7W9VVrr2ugCysWcEWplQ3m+v3zLusrwFT4zye
 +SrGk1Reqas+d7F+FSs7BhXVAT4KfwxFKwK6fJdAZS3vU2BTFOo+x3QQIUxURdSEcwGq
 mrSCT3/MJSUKRRU6hQAcj9WemoC1U506b5Lr/8GjQjJdfpUpbRLNsfCgFGrOP2KUbVQf
 xzn0FM2EG7XGDg9rY32eHXMIXUYjtz4Fj8OFpSQFIV41M1a8qRIZkeHgjQYOqjLWefVE
 iUUxd8X+yYAzg4enugJ6HfwgOgGwuKY7AWI0UwbqlYHUv3hSUasar4aR+MIFU52TATgJ
 8Btw==
X-Gm-Message-State: AOJu0YylgS51zuT9WnLr4RsiDL2v7s93PJ2xPOdqtfUeCDCDmj1RcsmB
 oINuLLnkd7gA+vYd7BIT97R9duQuxOhisvG3yclQyQ==
X-Google-Smtp-Source: AGHT+IG5CuPEbzlo2z0WKHJQCgqgKd0wyQ+rtlhDVzsghymOYbe8ervp6lWqf1FTSQbV4tPEGP0CprIm0yVbUDYzT7I=
X-Received: by 2002:a05:6102:5493:b0:45f:3b30:9c93 with SMTP id
 bk19-20020a056102549300b0045f3b309c93mr5361920vsb.22.1699371358609; Tue, 07
 Nov 2023 07:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20231031175453.1383422-1-alexander.deucher@amd.com>
In-Reply-To: <20231031175453.1383422-1-alexander.deucher@amd.com>
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Tue, 7 Nov 2023 15:35:47 +0000
Message-ID: <CANgGJDrGb3_jnRySPMqkjyRWC3PmWTM=ucAD6-EDpWQew1ZYzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't put MQDs in VRAM on ARM | ARM64
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 07 Nov 2023 15:40:20 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 31 Oct 2023 at 17:55, Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Issues were reported with commit 1cfb4d612127
> ("drm/amdgpu: put MQDs in VRAM") on an ADLINK Ampere
> Altra Developer Platform (AVA developer platform).
>
> Various ARM systems seem to have problems related
> to PCIe and MMIO access.  In this case, I'm not sure
> if this is specific to the ADLINK platform or ARM
> in general.  Seems to be some coherency issue with
> VRAM.  For now, just don't put MQDs in VRAM on ARM.
>
> Link: https://lists.freedesktop.org/archives/amd-gfx/2023-October/100453.html
> Fixes: 1cfb4d612127 ("drm/amdgpu: put MQDs in VRAM")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: alexey.klimov@linaro.org

Thanks for the patch! Can you please give me day or two to test it a
little bit more? I am still trying ti figure out if page faults in GPU
depend on this patch or not. I can provide Tested-by tag then.

Also, FWIW maybe you can add Reported-by tag.

Thanks,
Alexey


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c92e0aba69e1..a2a29dcb2422 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -385,9 +385,11 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>         struct amdgpu_ring *ring = &kiq->ring;
>         u32 domain = AMDGPU_GEM_DOMAIN_GTT;
>
> +#if !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
>         /* Only enable on gfx10 and 11 for now to avoid changing behavior on older chips */
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 0, 0))
>                 domain |= AMDGPU_GEM_DOMAIN_VRAM;
> +#endif
>
>         /* create MQD for KIQ */
>         if (!adev->enable_mes_kiq && !ring->mqd_obj) {
> --
> 2.41.0
>

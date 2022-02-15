Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EB8C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 22:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65BC710E5B5;
	Tue, 15 Feb 2022 22:34:48 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF1310E5B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 22:34:47 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id q8so581868oiw.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 14:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PM01xRfPlPQhvuKoxVaDqHcXW28N5TE/rK/+piVBWeI=;
 b=D6pN7ynxS3IEP6C1alemfY0Qg+cbEb1eB624WTa650XMYDSHUAqj6iSsnZbhuI9pSZ
 aDrSLPpLwXQdu1s72Buiyja351+8ALyzxw9S91vrRFQb5Dp/c8Z9m7ZIhCQVNoiC+0YZ
 6lbeIksn+gRwKHkd92bfe0D0GiVsySdwgOheLoEhpKTlmkoj4U67ASeEpL0SvrQCidYh
 vQgpuDmbOxG+QSwxTt70eUuesLwD+LqLaNdqePWyV2sJ50E8IlVpEsZ7BnEXlHBIzAYv
 uRznZKksu39NnJ6ZwTZA84K27Fjegn+h+6iB1+vdAoEeYnqLZeCziLthRCth2M9BGMT8
 CFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PM01xRfPlPQhvuKoxVaDqHcXW28N5TE/rK/+piVBWeI=;
 b=qXWEj1Zqea0qD1Ym5uw7xpQySlsUr/wDavTfCjh8ZX1XXJ7CP1TU/WQ4NFaUh/zgHe
 kmIwDWSgqF201eSgQSktn8T97xEoDG8/sUsB8KaP3rRrnNH+kMvB18UJ0lon5723zke2
 u4ABfMTS7If9HkbvtenGSZDUbo/FiaOj1UWQAsIXHhfh8yWaiDq1gci+s1Ag/R17VsHe
 BraSyExePm4cwf375NlBw9WVDTO38NKdoi5F2MdDNwhqpYXPaqk/09iPR/FHLJD1avmm
 Of9DqKVPvzuS8kjcZm4/2F7bdvo7Xw0sW80F7TsWjm7eT2IZChO2KTdL/bc4ZwIEYKKf
 jvyA==
X-Gm-Message-State: AOAM532PGC5+bhWuB5vvk9+CPaD6rWHgccvUg3aGYNkNfPc6waejTojw
 5E7XOOQZzziPAqkgNzHdGaklu5WWRnjXmjImYOEd+0Mz
X-Google-Smtp-Source: ABdhPJxqei952ZEUSxu9GZ0TaAVTpBwQU660LEbLxrXAw3ah/Hry3UVZQRxozsuQf4i/dSxARMoe6zZ6EjWBcYCixQM=
X-Received: by 2002:a05:6808:f8b:b0:2ce:6ee7:2c99 with SMTP id
 o11-20020a0568080f8b00b002ce6ee72c99mr2768375oiw.199.1644964487117; Tue, 15
 Feb 2022 14:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20220215152859.1519226-1-tom.stdenis@amd.com>
In-Reply-To: <20220215152859.1519226-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Feb 2022 17:34:36 -0500
Message-ID: <CADnq5_NxSpbt7+2Tc7QJruuSe4iDX8v6wz-GykddCFRqiJpJTg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add APU flag and asic_type to gca_config
 debugfs data
To: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 15, 2022 at 10:29 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Needed by umr to detect if ip discovered ASIC is an APU or not.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

I'm not sure we want to expose the asic_type outside of the driver as
we may theoretically change the ordering in the kernel and then
userspace would need to be aware of this.  We already expose the
asic_family and external revision id which encodes basically the same
information.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 4b950de9bf66..3b2341610c16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -728,7 +728,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
>                 return -ENOMEM;
>
>         /* version, increment each time something is added */
> -       config[no_regs++] = 3;
> +       config[no_regs++] = 4;
>         config[no_regs++] = adev->gfx.config.max_shader_engines;
>         config[no_regs++] = adev->gfx.config.max_tile_pipes;
>         config[no_regs++] = adev->gfx.config.max_cu_per_sh;
> @@ -768,6 +768,11 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
>         config[no_regs++] = adev->pdev->subsystem_device;
>         config[no_regs++] = adev->pdev->subsystem_vendor;
>
> +       /* rev==4 asic_type and APU flag */
> +       config[no_regs++] = adev->flags & 0xFF;
> +       config[no_regs++] = (adev->flags >> 8) & 0xFF;
> +       config[no_regs++] = adev->flags & AMD_IS_APU ? 1 : 0;
> +
>         while (size && (*pos < no_regs * 4)) {
>                 uint32_t value;
>
> --
> 2.32.0
>

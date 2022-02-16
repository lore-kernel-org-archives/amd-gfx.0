Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C697DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 14:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A92410E420;
	Wed, 16 Feb 2022 14:37:06 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8897B10E420
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 14:37:04 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id 13so2570900oiz.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TXamBlEstaB1RoQOlaYp10+ZVOywQd1EMWp68+pRvtg=;
 b=FP6nJ0HGQhR1r5/PRgdTD6XMvZh8J8ojV0WCL8NtpSjA9yVRm+Boy5inROd+tuINM6
 uFXF6RBmo2oNtg/17lqSj5+YF+az+0xxkFxAvgJZ8GTN7YtlrbemnM9YK6GaLzKut+wA
 9yzuj02qgzOkBKmkbC7W4fptdVaM5Brw3vOih97BUa6DVUQdsDe/2GPZ4tcxnqwcr9Zb
 DzvAApRJH080eYjq3PAH5SEy+bBOj+rDot1MmIseb56/JKJD05qKPozM1MkvfGZ74tQi
 7RcslWaskKUfE9QZB+S44CL1IXoAkArZ+ibmsh3pWOIYdx7bp8s0XwuWIHkk0NKbpghB
 ybGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TXamBlEstaB1RoQOlaYp10+ZVOywQd1EMWp68+pRvtg=;
 b=P86cHBEmt6fafABtibIY2WaptF3M3GyMz+xPpgK1p7hSJyCZahltNrTS85eP6jb0r4
 W4mRTtx7VB3A+jWENXc5An4/1vJwXn8KmfyIkBRJAkkILfQJU527aQm+bgC0EEUlW7T3
 19OcYlgzQj6MY2bLZUqTpQHB3WkgfhtdKIyp4aF53w0j++ZwUJ5tm2CaKRw5mdro+HpP
 ta1ZnRVvlmiKbSf9ZIyliseZtg4v4aVSjCp5lBmR1gU+RVRInGXZrDdu95wLzvrJGxvC
 p8XT9ms6wz6uzvpKB6rIldKPrQRVoC7EGI3eOEZNSh19L8mGb4e1R6yq8eZN4j9MaPh1
 /7AA==
X-Gm-Message-State: AOAM532XpB7cbZFlJqpq8qPGn3FEPmKMwlNX8Ce8b57JLhAWXUWaEvOj
 p8yzwgdmIAkNC/pLuBZ1pMzxkM0GIJXTyN70ef0=
X-Google-Smtp-Source: ABdhPJwW/KCzvvc5GqjrIKQzLSuV0ybh8H/5HEX9+mJNIEIzeEFcp5h0+pMRHcsj+jrKhHvI/Vg1M3fBuxEZZIdWGkc=
X-Received: by 2002:a54:4416:0:b0:2d0:d4d1:8363 with SMTP id
 k22-20020a544416000000b002d0d4d18363mr788629oiw.132.1645022223857; Wed, 16
 Feb 2022 06:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20220215234701.1560356-1-tom.stdenis@amd.com>
In-Reply-To: <20220215234701.1560356-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Feb 2022 09:36:52 -0500
Message-ID: <CADnq5_ND4xDQR_ut59rQoMfJhKvniVF9vGyjpqr1QroacR5YJg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add APU flag to gca_config debugfs data
 (v2)
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

On Tue, Feb 15, 2022 at 6:47 PM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Needed by umr to detect if ip discovered ASIC is an APU or not.
>
> (v2): Remove asic type from packet it's not strictly needed
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 4b950de9bf66..8f0ca71862b1 100644
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
> @@ -768,6 +768,9 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
>         config[no_regs++] = adev->pdev->subsystem_device;
>         config[no_regs++] = adev->pdev->subsystem_vendor;
>
> +       /* rev==4 asic_type and APU flag */

Fix the comment here. Also, we already expose the APU flag as
AMDGPU_IDS_FLAGS_FUSION via the AMDGPU_INFO_DEV_INFO query to the INFO
ioctl.  If you already use that, you should already have this.  If
not, with the comment fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +       config[no_regs++] = adev->flags & AMD_IS_APU ? 1 : 0;
> +
>         while (size && (*pos < no_regs * 4)) {
>                 uint32_t value;
>
> --
> 2.32.0
>

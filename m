Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E811C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 14:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D407610E4DC;
	Fri,  8 Apr 2022 14:56:01 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869EA10E4DC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 14:56:01 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 n19-20020a9d7113000000b005cd9cff76c3so6280143otj.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Apr 2022 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E9vmlpCKSTPYVqRG9fG7+hWPiZNJJoRyvqxufniycB0=;
 b=EA3UV0gL6BJbTy0RNoil3wg1nceCSVqqOTD+X4bfJCrkOynozHSzJlVxcwWe8gyn8P
 uAqnZ/JRjjHotRG+1Xl0KoUjiqCa+azyqraAVY+aY3Q48k6XYAfvsW22kKML977UIiNr
 uF1SlLHGtYNXUC2zn6XySDI6O3gcF12FCYKpxPARNGUfay4O2ZyoexGXEN+gaqcQP8yk
 RzEYCtgBjLjBHiT9goNhHfWd7FSb4sIaRuhnCMuNIZcNykd6WKQKfIbGjx0YZIXTBdmQ
 PkagiqpPJYvHOOM+txvYfBnM7eu5RnSaQCd0U6vVfJBE65t/bmUYLE0/K1BpEe3OFt4C
 /0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E9vmlpCKSTPYVqRG9fG7+hWPiZNJJoRyvqxufniycB0=;
 b=6vxZM7jjOod5xu2NfZ2jy4r8Kwk6W8ePehD7q3zpohKPvDLxPq0gRH+bZwCke6Av81
 aRqRxZsEKowCgjMsW9w8/7QOkb8zpZDHo8pN3O2jQ6+uP+4k7mmrZFqS2I2TPvHdLH8z
 DmDib8j3et2N4Al01Ejn7Pak6oaTinIUQzCbv3qL0xKPPMLZ/MPWqx+pIDGaLNFh2kZI
 Bd+281Y5QapWskeEhWcBu8AOEk7ScU5mSqXQzg9foqBMRJ2M93A61KEf0t3nvppDmJ04
 EL9vNY3o4l2/576XhN8ufbr9hKIy+iR4nvw31lMiT2HSFf3ULxFHLuBqtqn2hzqVXCcz
 NEww==
X-Gm-Message-State: AOAM533XyfPMz1XTjwck2kew388ypg8opUJakvz4SU20CbzTZYqkhKJE
 DULQjdCa8jNqvlIzYI2A/jQ3atZ1veKxUvXL+WadjgtC
X-Google-Smtp-Source: ABdhPJy7v4yYY4jTf1fBL75lZAI9FBJm1KRCtxBR/t7qGZ3tctUT4FAScOnEbS+KNvbTUFOIz2v4dqEi+mECYaG8cwQ=
X-Received: by 2002:a05:6830:1552:b0:5cd:bc6e:62b1 with SMTP id
 l18-20020a056830155200b005cdbc6e62b1mr6918978otp.357.1649429760790; Fri, 08
 Apr 2022 07:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220408132133.511808-1-tom.stdenis@amd.com>
In-Reply-To: <20220408132133.511808-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Apr 2022 10:55:49 -0400
Message-ID: <CADnq5_NdAPjH4kkntehb2MnqxO8TJP6Waex=p6KLSs2ZxpJc_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Update debugfs GCA data
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

On Fri, Apr 8, 2022 at 9:21 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> The revision was not changed to 5 from 4.  Also since
> this was missed I took the opportunity to add future
> upper 64-bits of PG flags as well so we don't need to
> bump it again when that comes.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Maybe add a comment explaining why we jumped to 5.  Either way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 1db48dc58ae9..13e4d8f9b874 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -730,7 +730,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
>                 return -ENOMEM;
>
>         /* version, increment each time something is added */
> -       config[no_regs++] = 4;
> +       config[no_regs++] = 5;
>         config[no_regs++] = adev->gfx.config.max_shader_engines;
>         config[no_regs++] = adev->gfx.config.max_tile_pipes;
>         config[no_regs++] = adev->gfx.config.max_cu_per_sh;
> @@ -757,7 +757,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
>
>         /* rev==1 */
>         config[no_regs++] = adev->rev_id;
> -       config[no_regs++] = adev->pg_flags;
> +       config[no_regs++] = lower_32_bits(adev->pg_flags);
>         config[no_regs++] = lower_32_bits(adev->cg_flags);
>
>         /* rev==2 */
> @@ -773,7 +773,8 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
>         /* rev==4 APU flag */
>         config[no_regs++] = adev->flags & AMD_IS_APU ? 1 : 0;
>
> -       /* rev==5 CG flag upper 32bit */
> +       /* rev==5 PG/CG flag upper 32bit */
> +       config[no_regs++] = upper_32_bits(adev->pg_flags);
>         config[no_regs++] = upper_32_bits(adev->cg_flags);
>
>         while (size && (*pos < no_regs * 4)) {
> --
> 2.32.0
>

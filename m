Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6CAC35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 18:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895DB2071E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 18:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIFet7FQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895DB2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDD36E46E;
	Fri, 21 Feb 2020 18:59:34 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C6D6E46E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 18:59:33 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a5so2855559wmb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 10:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gzZQMzbIVXGFvjaX6e6trWUhSJI0u59h2QsoXfUMV4M=;
 b=TIFet7FQl1cI4TjEli1ZMBFKXbwYKiFN4Q+B6yqBa3a0tB5xNJlIE+1yLw6KfzksHa
 aHMLCJWsKdZiom3fAv5mltEGRoTLEMx12vP6XIxGp8Psq7mNptzNbeb29MErai6oNl+l
 pd+bZ9gZUOSOGrAssprcPFg5f7leTCzx/O5Uf9jQUbzP9L6hZRAFYumW0whyUbXdzT0B
 UFy21Zw6xGC4X8k0mD6Nmr4yIGoljw2zorXutyCur1/iPrBHcXGTwW3v+UsidWkDqVX9
 Gdlp2HYKUokX2AJxuhcySbJ+R9YJC48QTEbgLqzf5+XUnlnzCJD9SpYYulVBI8JsZHhE
 KthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gzZQMzbIVXGFvjaX6e6trWUhSJI0u59h2QsoXfUMV4M=;
 b=kscvuR28kp2jk+8BIXNBtiNAPm0uE61TnEIKHLkRVZL2fBtnhkMVfH8B5dE+SCdbMA
 C//3yyB9VuaAC92b7C+Vfqlzcqy7LZbZx3sscSzyQXcScE3s4JzZIS2jmveE/pJYj1Wp
 7G7uL1BZ3BMjg34txYkluuXR1XqTfG3cKEL0+xl2acQbBw57p0Lbm4Ba4pjTYB3omq2u
 Up/xkQTI100JBYQ6i9Of3rukJ2hJTFJk3nqenXU5FuYyZkjyvuQrtmRJq8EzSB5iwTq0
 +kn1L6V9mcLXTEl+tf/BQCpHfV6vch3b/CTSZ+oLywJFcgwhBcxpnqRmacz6cD4QAxF2
 4CXg==
X-Gm-Message-State: APjAAAVdMnvGE3WXSe2cnFbj6RUHaV4AJdNPxf5EC/fyEDVieQW3q/LK
 AMKk4Eps/N2V/hBNH2w3i8/vQzYUI/HvPZz9CnvVoHUE
X-Google-Smtp-Source: APXvYqzYOaSOW0qwu0gTlVM6Rre7UG6k1hXrcVnE/IEASajn5GT7XWS0/opYgdjQdXG5ypg8Y+Mo/QJ6mcy77t8YbaY=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr5205674wmb.73.1582311571595;
 Fri, 21 Feb 2020 10:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20200221184510.636829-1-tom.stdenis@amd.com>
In-Reply-To: <20200221184510.636829-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2020 13:59:20 -0500
Message-ID: <CADnq5_Oi2w=Wy3m7e9v1wXd003Rbe2RYmwWSD3DOHz8Okbeyew@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add gfxoff debugfs entry
To: Tom St Denis <tom.stdenis@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 21, 2020 at 1:45 PM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Write a 32-bit value of zero to disable GFXOFF and write a 32-bit
> value of non-zero to enable GFXOFF.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 56 +++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 7379910790c9..3bb74056b9d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -842,6 +842,55 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>         return result;
>  }
>
> +/**
> + * amdgpu_debugfs_regs_gfxoff_write - Enable/disable GFXOFF
> + *
> + * @f: open file handle
> + * @buf: User buffer to write data from
> + * @size: Number of bytes to write
> + * @pos:  Offset to seek to
> + *
> + * Write a 32-bit zero to disable or a 32-bit non-zero to enable
> + */
> +static ssize_t amdgpu_debugfs_gfxoff_write(struct file *f, const char __user *buf,
> +                                        size_t size, loff_t *pos)
> +{
> +       struct amdgpu_device *adev = file_inode(f)->i_private;
> +       ssize_t result = 0;
> +       int r;
> +
> +       if (size & 0x3 || *pos & 0x3)
> +               return -EINVAL;
> +
> +       r = pm_runtime_get_sync(adev->ddev->dev);

Not really directly related to this patch, but If you are using umr
for debugging, we should probably disable runtime pm, otherwise the
entire GPU may be powered down between accesses.  There is already an
interface to do that via the core kernel power subsystem in sysfs.
E.g.,
/sys/class/drm/card0/device/power/control
/sys/class/drm/card0/device/power/runtime_status
Something else to look at for umr.

We don't store the state for when we dynamically turn it off like this
so if we get a GPU reset or a power management event (runtime pm or
S3), GFXOFF will be re-enabled at that point.  This is just for
debugging though so:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex


> +       if (r < 0)
> +               return r;
> +
> +       while (size) {
> +               uint32_t value;
> +
> +               r = get_user(value, (uint32_t *)buf);
> +               if (r) {
> +                       pm_runtime_mark_last_busy(adev->ddev->dev);
> +                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       return r;
> +               }
> +
> +               amdgpu_gfx_off_ctrl(adev, value ? true : false);
> +
> +               result += 4;
> +               buf += 4;
> +               *pos += 4;
> +               size -= 4;
> +       }
> +
> +       pm_runtime_mark_last_busy(adev->ddev->dev);
> +       pm_runtime_put_autosuspend(adev->ddev->dev);
> +
> +       return result;
> +}
> +
> +
>  static const struct file_operations amdgpu_debugfs_regs_fops = {
>         .owner = THIS_MODULE,
>         .read = amdgpu_debugfs_regs_read,
> @@ -890,6 +939,11 @@ static const struct file_operations amdgpu_debugfs_gpr_fops = {
>         .llseek = default_llseek
>  };
>
> +static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
> +       .owner = THIS_MODULE,
> +       .write = amdgpu_debugfs_gfxoff_write,
> +};
> +
>  static const struct file_operations *debugfs_regs[] = {
>         &amdgpu_debugfs_regs_fops,
>         &amdgpu_debugfs_regs_didt_fops,
> @@ -899,6 +953,7 @@ static const struct file_operations *debugfs_regs[] = {
>         &amdgpu_debugfs_sensors_fops,
>         &amdgpu_debugfs_wave_fops,
>         &amdgpu_debugfs_gpr_fops,
> +       &amdgpu_debugfs_gfxoff_fops,
>  };
>
>  static const char *debugfs_regs_names[] = {
> @@ -910,6 +965,7 @@ static const char *debugfs_regs_names[] = {
>         "amdgpu_sensors",
>         "amdgpu_wave",
>         "amdgpu_gpr",
> +       "amdgpu_gfxoff",
>  };
>
>  /**
> --
> 2.24.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

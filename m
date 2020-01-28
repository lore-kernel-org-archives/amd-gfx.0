Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B492BC33CB3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A718206A2
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSN/nC/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A718206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 431836F3F0;
	Tue, 28 Jan 2020 20:23:08 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0488E6F3F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 20:23:07 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c9so17607574wrw.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 12:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uX7vKSNNo5Eaq9xL7Tq2ySVrFfQcClvTNne2pu/tz2g=;
 b=pSN/nC/QbLzP4T5fOmhLuEPlFbfAG7bM3cEjQmzq2La0ifw78P7J08JuPYWDgGHIkA
 xB+DcpSk41tHd8wc01CkQ3rO7Y7cCurODS31J+8LsAgoqj/5m0y6lsZ6wVqKi3rY3ijA
 xg0RmgUQhjlxcFu/dDE8hREvvHEKZ245iZNBfrUW1HaUTqR1jBzuumYXq/arMdgibrS+
 nl0E5V0gfhB8qUFXNO6nMkRKPADyThbDLuZG5ZdsXfKxKmO5QMo6QzvQblHLlPb8xjFo
 zNH9/OWqhc/0x95Ld2igtp3eoOpS0jjETmipccTvnhyjXMlpK5SNnxmHMxoCCgMMU9oK
 wgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uX7vKSNNo5Eaq9xL7Tq2ySVrFfQcClvTNne2pu/tz2g=;
 b=Tf/+q1gU5V1mx2+sUr4+BPI7lUvDoEker4HCFn7/zIuM7ni7q3bkmNWATf1RE50RtK
 U2m/IDnTukaqABk18q8L+nMthv3bz+6OeA+E0o/DCQ5AuxPhGfTiA3S0JcRdW1fsLUwH
 hcyPvGHoVz5Jy4sURjky0zwhTcUksYsJWSvp9yFnd+WwqvP1u76McmWgY28Eqqc8ibr6
 FmEnexUIuMN+xePV7LfchcnWvK5qqPZfAscg6lrHjXqPQBvXuq7F6KUkYBhWZUvEPprs
 fjVve3ozRxNkGnHuQRyWfd2xtBRogq2PRWsbap/zEpYIyU8+k3QrRrxBtJ4GuRebHm1g
 18mw==
X-Gm-Message-State: APjAAAU++snHwEXbqeZpGMxSPNBLHJnLMbar6JLBUFdNM1CcANA4bKVd
 w7P/Idiw0yCvfe9HZfDhbQtyzyxaFH0b2lR/uBgQ2lng
X-Google-Smtp-Source: APXvYqzT+CCRCPN/gZ4+Fjq+pajIIk+ZZVJxVRNhPuzBjozaVF7fq4LeZxKKYG1KwCKePG2HZJoh8qG3otbKRxs8eyA=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr32015697wrn.124.1580242985633; 
 Tue, 28 Jan 2020 12:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
 <20200128012923.25536-4-rajneesh.bhardwaj@amd.com>
In-Reply-To: <20200128012923.25536-4-rajneesh.bhardwaj@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jan 2020 15:22:54 -0500
Message-ID: <CADnq5_N+cMAWFyi0GdUer0AkU2LNSjrnb7i9Z4O07CR5V04FaQ@mail.gmail.com>
Subject: Re: [Patch v1 3/5] drm/amdkfd: Introduce debugfs option to disable
 baco
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 27, 2020 at 8:30 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@amd.com> wrote:
>
> When BACO is enabled by default, sometimes it can cause additional
> trouble to debug KFD issues. This debugfs override allows to temporarily
> disable BACO for debug purpose without having to reboot the machine.
>
> However, in some cases one suspend-resume cycle might be needed if
> the device is already runtime suspended.
>
> e.g
>
> sudo rtcwake -m < mem or freeze > -s 15
>
> or
>
> by triggering autosuspend event from user space, by doing something
> like:
>
> echo 6000 > /sys/bus/pci/devices/0000\:03\:00.0/power/autosuspend_delay_ms
>
>     Usage:
>
> echo 0 > /sys/kernel/debug/kfd/enable_baco and run
> cat /sys/kernel/debug/kfd/baco_status to verify whether BACO is
> enabled or disabled by kfd driver.
>
> It should be noted that while enabling baco again via kfd override, we
> must do the following steps:
>
> 1. echo 0 > /sys/kernel/debug/kfd/enable_baco
> 2. sudo rtcwake -m < mem > -s 15
>
> In this case, we need GPU to be fully reset which is done by BIOS. This
> is not possible in case of S2idle i.e. freeze so we must use mem for
> sleep.
>

I think we can drop this patch in favor of just using the standard
runtime pm control.  E.g.,
/sys/class/drm/card0/device/power/control

Also, the underlying mechanism may not always be BACO.  E.g., hybrid
laptops use BOCO (d3cold).  So it would be better to make the naming
more generic (e.g., runpm_enable, runpm_status).  This is also kfd
specific.  If we actually do want something like this, I think it
should be at the device level in amdgpu.

Alex

> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c   | 27 ++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 47b0f2957d1f..0fa898d30207 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -34,6 +34,7 @@
>  #include "amdgpu_vm.h"
>
>  extern uint64_t amdgpu_amdkfd_total_mem_size;
> +extern bool kfd_enable_baco;
>
>  struct amdgpu_device;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2c64d2a83d61..d9e5eac182d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3259,6 +3259,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>                 return -ENODEV;
>         }
>
> +       if (!kfd_enable_baco)
> +               return -EBUSY;
> +
>         adev = dev->dev_private;
>
>         if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> index 511712c2e382..c6f6ff2ff603 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> @@ -26,6 +26,7 @@
>  #include "kfd_priv.h"
>
>  static struct dentry *debugfs_root;
> +bool kfd_enable_baco = true;
>
>  static int kfd_debugfs_open(struct inode *inode, struct file *file)
>  {
> @@ -83,6 +84,28 @@ static const struct file_operations kfd_debugfs_hang_hws_fops = {
>         .release = single_release,
>  };
>
> +static int baco_sts_set(void *data, u64 val)
> +{
> +       if (!val)
> +               kfd_enable_baco = false;
> +       else
> +               kfd_enable_baco = true;
> +
> +       return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(fops_baco_enable, NULL, baco_sts_set, "%lld\n");
> +
> +static int baco_sts_show(struct seq_file *s, void *unused)
> +{
> +       if (kfd_enable_baco)
> +               seq_puts(s, "Baco is Enabled\n");
> +       else
> +               seq_puts(s, "Baco is Disabled\n");
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(baco_sts);
> +
>  void kfd_debugfs_init(void)
>  {
>         debugfs_root = debugfs_create_dir("kfd", NULL);
> @@ -95,6 +118,10 @@ void kfd_debugfs_init(void)
>                             kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
>         debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
>                             NULL, &kfd_debugfs_hang_hws_fops);
> +       debugfs_create_file("enable_baco", 0644, debugfs_root, NULL,
> +                           &fops_baco_enable);
> +       debugfs_create_file("baco_status", 0444, debugfs_root, NULL,
> +                           &baco_sts_fops);
>  }
>
>  void kfd_debugfs_fini(void)
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

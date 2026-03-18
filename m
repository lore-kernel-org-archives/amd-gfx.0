Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1C8FCD0C4
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 13:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0CFF10E0CA;
	Wed, 18 Mar 2026 13:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U5cGnC3d";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A6210E0CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 13:12:28 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12734af2cdcso317115c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 06:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773839547; cv=none;
 d=google.com; s=arc-20240605;
 b=XxotqDlCMxhLJcVDPVihDDGl/iMM66CB3iGeamzTM5sfhSLRFOzFV9topd18rfW9M5
 sJhhtb6PkvssvkzLgs/TmniNbzEJwcyGVkLkI2ZkotIwC4xp9XWdsiYNL5jUO50vsNEn
 eLZymwOXom3+LxZvyQsV2qFezmn0SouWwVlscOZx7cGi9QdtaU7j2yzAbs6qyQR9wU3e
 Z+G6fLMstNsGdzQfzoVI+OMSg/sxkFhUF2oIz/g7LW2T7RXD5/KhmHYr5g02dzS7HHis
 VZFp0Dt9fzASBuCvWA8/I2PMilmYD7XH8xY2OU6MoGGYP/qBCBRa6SiFPa8n5EP2zryT
 88UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fCZVVUxNMAnAlrRNwKH1qIToPVFuh8cbnjHj2aVzUvg=;
 fh=eClSOvX3Ufrk3xmew2bENE0C3juJ/fkpDTmR/fycvps=;
 b=WNv0s8PUCZPxlMvZILnUx9puo5Cdq8FNJTVtPhiYinrVL6snS4bAILEWTPjfg3KrSA
 lpFImmQ2NgchwSzZcibXPWWToDpOqaOUic6cRNnslIA4Gb0PzzWJa4eWt0ujCiVA3WvM
 6KKVmDvQFMn7J+VJOZe+XbJ9pql4DfDdRgJxQ8jH+09cOLj5x33rsPxJe2VU4qx+QQ+o
 zcNUs9akxeCODXWiYJQ1s11F+sXcHa2T5Mnb4XkKoXY5TmfT/NcVwtCwiYWvX7LzGuYA
 AqNXyzchg9XGPXPiohHtCJLBPeQ9d4bIKL5Z30hq7rQ7JeDAbMV9M6AmqludIU8S48UV
 umJQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773839547; x=1774444347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCZVVUxNMAnAlrRNwKH1qIToPVFuh8cbnjHj2aVzUvg=;
 b=U5cGnC3deGUj1E3jAwtE8cUuwzF8adlqfTTD/6MYf9+GahzXGcLiWTgW52wpBGn52a
 IipaCyJwpNBcpk6n6M7uBKBlbTEJxI4u1JCo02LbFimH3ABRSjT91p7yMFy05oLaeuQb
 N/GTLFvDxz1IScoZpW5gXFSEsQmT8KjH3++dbTXYApnKZN7km+A/2AVkyjQvWO7qWot8
 IYTPF7Oiujj5YuDkftetmhvGU8+Vl3g2RKiUA9WxPqqmFKowyCGPEyvueHBOMt7J7qsU
 UEQTFYCQHLLxBrmMfUCHe8I3wYSHtbeE0VEgHSeSojE8Srzt7hjXPvGiXm1chX7h0vYs
 ZmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773839547; x=1774444347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fCZVVUxNMAnAlrRNwKH1qIToPVFuh8cbnjHj2aVzUvg=;
 b=j6jTBtTB++dqoMzdk0hnyWWHYSRB+x0xft312zfmDZKxkWGswitzPBhzNxgyvKVK0l
 OgM4pouTqBnYs5Cx7c7G6x1TtEk6X0bCGSQyX/JT7L8omgreaf9URUC0qFev8asdZUFK
 J4nARwQ3A9KfC6nrsfIzEUYBHMbA8Y4uxn63D8nHlm5EfDKsAvlJx07Q3hsye/j4zJhU
 cbnzHLiA3Gf7ovSL7D6AI1J6GpIrcHUraue/CEV3DlKNxjW20HLGIEBltMK3hmNUS/9J
 IT6DRkc9ivqMI1i+hykWPj7gPirpoNdNklbAgOEkWl5TjSFndk2XljzA40IiXdq3C5B+
 nsUw==
X-Gm-Message-State: AOJu0YyjQrxCBxnofsCGRT8fyGTVZYGX7iTjqJpgQIDKyiaTlSl5FWz+
 mgZbUuwJxwN+PFpgYkV45iNZIM3Vh0VlIfWr0fKV/xeGHRSymJAHVeqFIIVvWAWxqUmLpFEkagI
 DFO467KVWvNJ1YTPQxLhgTL29V9e3scE=
X-Gm-Gg: ATEYQzzevx7VaNlkPAxyS57QeI70q05i2kL4OolUjSdlZtkAQOllFw/hBvURw7byVEF
 tCofyMHlgmtmHPYF6CiXhc9RByAcKdtdoVoVPaa/XpLwyj4tPl56ub3JG09KsvSUE27Zf/Y+X4N
 uLoqx6hIv+is2CvzlrXLc/nY0YVT7yR5w3rFCc3xLzcct3He0oUgAf4u5hgbZGay4zMXXqXzOhA
 ApLNLR5wV0qBmwXIR5G1h1vqjmTbzxJrzwV8UYyWsOK09rjABD1k5edav6THiHn7FCT6Z+FqE7S
 jCF8rBl044Zy6eAlKK/P+Bn61ACcBP13YLHaeZpBaOw+7gYj/LIISBOSkXpFx0x/vuLxHg==
X-Received: by 2002:a05:7022:1503:b0:128:d4d5:93b9 with SMTP id
 a92af1059eb24-129a710b536mr760994c88.7.1773839547393; Wed, 18 Mar 2026
 06:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260318112201.3779461-1-Stanley.Yang@amd.com>
In-Reply-To: <20260318112201.3779461-1-Stanley.Yang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Mar 2026 09:12:15 -0400
X-Gm-Features: AaiRm52OsVEbnfK4aGDe282mXkPx08REzb1FT_OQ_ckvKdZX3uXiSI-C8pw9g8E
Message-ID: <CADnq5_OgqwDNZHQm=JJvwHZeUjifxyJ4kgm8=nyURDOLoeAobw@mail.gmail.com>
Subject: Re: [PATCH Review 1/1] drm/amdgpu: Add amdgpu_regs_pcie64 debugfs node
To: "Stanley.Yang" <Stanley.Yang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Wed, Mar 18, 2026 at 7:22=E2=80=AFAM Stanley.Yang <Stanley.Yang@amd.com>=
 wrote:
>
> Add amdgpu_regs_pcie64 debugfs node to
> read/write 64bit PCIE registers.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 113 ++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 6fdcd9c78324..e15b3aa02919 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -622,6 +622,111 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struc=
t file *f, const char __user
>         amdgpu_virt_disable_access_debugfs(adev);
>         return r;
>  }
> +/**
> + * amdgpu_debugfs_regs_pcie64_read - Read from a 64-bit PCIE register
> + *
> + * @f: open file handle
> + * @buf: User buffer to store read data in
> + * @size: Number of bytes to read
> + * @pos:  Offset to seek to
> + */
> +static ssize_t amdgpu_debugfs_regs_pcie64_read(struct file *f, char __us=
er *buf,
> +                    size_t size, loff_t *pos)
> +{
> +       struct amdgpu_device *adev =3D file_inode(f)->i_private;
> +       ssize_t result =3D 0;
> +       int r;
> +
> +       if (size & 0x7 || *pos & 0x7)
> +               return -EINVAL;
> +
> +       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +       if (r < 0) {
> +               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +               return r;
> +       }
> +
> +       r =3D amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0) {
> +               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +               return r;
> +       }
> +
> +       while (size) {
> +               uint64_t value;
> +
> +               value =3D RREG64_PCIE_EXT(*pos);
> +
> +               r =3D put_user(value, (uint64_t *)buf);
> +               if (r)
> +                       goto out;
> +
> +               result +=3D 8;
> +               buf +=3D 8;
> +               *pos +=3D 8;
> +               size -=3D 8;
> +       }
> +
> +       r =3D result;
> +out:
> +       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +       amdgpu_virt_disable_access_debugfs(adev);
> +       return r;
> +}
> +
> +/**
> + * amdgpu_debugfs_regs_pcie64_write - Write to a 64-bit PCIE register
> + *
> + * @f: open file handle
> + * @buf: User buffer to write data from
> + * @size: Number of bytes to write
> + * @pos:  Offset to seek to
> + */
> +static ssize_t amdgpu_debugfs_regs_pcie64_write(struct file *f, const ch=
ar __user *buf,
> +                     size_t size, loff_t *pos)
> +{
> +       struct amdgpu_device *adev =3D file_inode(f)->i_private;
> +       ssize_t result =3D 0;
> +       int r;
> +
> +       if (size & 0x7 || *pos & 0x7)
> +               return -EINVAL;
> +
> +       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +       if (r < 0) {
> +               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +               return r;
> +       }
> +
> +       r =3D amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0) {
> +               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +               return r;
> +       }
> +
> +       while (size) {
> +               uint64_t value;
> +
> +               r =3D get_user(value, (uint64_t *)buf);
> +               if (r)
> +                       goto out;
> +
> +               WREG64_PCIE_EXT(*pos, value);
> +
> +               result +=3D 8;
> +               buf +=3D 8;
> +               *pos +=3D 8;
> +               size -=3D 8;
> +       }
> +
> +       r =3D result;
> +out:
> +       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +       amdgpu_virt_disable_access_debugfs(adev);
> +       return r;
> +}
>
>  /**
>   * amdgpu_debugfs_regs_didt_read - Read from a DIDT register
> @@ -1544,6 +1649,12 @@ static const struct file_operations amdgpu_debugfs=
_regs_pcie_fops =3D {
>         .write =3D amdgpu_debugfs_regs_pcie_write,
>         .llseek =3D default_llseek
>  };
> +static const struct file_operations amdgpu_debugfs_regs_pcie64_fops =3D =
{
> +       .owner =3D THIS_MODULE,
> +       .read =3D amdgpu_debugfs_regs_pcie64_read,
> +       .write =3D amdgpu_debugfs_regs_pcie64_write,
> +       .llseek =3D default_llseek
> +};
>  static const struct file_operations amdgpu_debugfs_regs_smc_fops =3D {
>         .owner =3D THIS_MODULE,
>         .read =3D amdgpu_debugfs_regs_smc_read,
> @@ -1606,6 +1717,7 @@ static const struct file_operations *debugfs_regs[]=
 =3D {
>         &amdgpu_debugfs_gprwave_fops,
>         &amdgpu_debugfs_regs_didt_fops,
>         &amdgpu_debugfs_regs_pcie_fops,
> +       &amdgpu_debugfs_regs_pcie64_fops,
>         &amdgpu_debugfs_regs_smc_fops,
>         &amdgpu_debugfs_gca_config_fops,
>         &amdgpu_debugfs_sensors_fops,
> @@ -1623,6 +1735,7 @@ static const char * const debugfs_regs_names[] =3D =
{
>         "amdgpu_gprwave",
>         "amdgpu_regs_didt",
>         "amdgpu_regs_pcie",
> +       "amdgpu_regs_pcie64",
>         "amdgpu_regs_smc",
>         "amdgpu_gca_config",
>         "amdgpu_sensors",
> --
> 2.25.1
>

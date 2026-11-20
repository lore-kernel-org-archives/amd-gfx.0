Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7036606A690
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+dBa2hz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA4D10E295;
	Fri, 20 Nov 2026 22:21:56 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0266810E295
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 22:21:49 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-8437d47592bso144539a34.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 14:21:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795213309; cv=none;
 d=google.com; s=arc-20260327;
 b=CGkwe3IDQmlE2HEshITqvUQJueG/cSUvKdh0rVT5iA7LYexgL0lJcfPhaIFrzsUOL3
 Xq6APppiAfW1V7tc0+O8KJYvXpSAxHhBxYObnZZBebIldWQd77/6Z3wuP6zcps/C4rIl
 7WVEH+dUAeRQTmKafj6w9p7ctf5IMUrb29FZHjELKd9P0U8B5Vd6BoLsEKtE4EZaX0tL
 fO5EqVs0smhI+9hQgCdoO06poAf37wZJ8L/wFsca/UNvLnxe0xrxaFUPLAi4juRaWe4K
 InDJcd5QvL0VM5TqIZyJFvnet6A+MAO8eR24RfHHFgZeMXFgZJaK8nrF7k17bED7i6Ov
 eNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lZbAFJ5hZp+KhJPRKyRM2sFS1JXKoukA9wnVojH7jR4=;
 fh=UL6y2wPUyLQAM1rrUScIR7ov5kMb+DJ/dH8vmi3esx4=;
 b=CKkYkzan6hAlPlugcFuBjr5T6kK1zlURoEsJmCp7eZ5D1MGseA+JIAQhbjuCv4rFTZ
 XE02mLSOwF/LyW01+1jiI9EPBkuGu3eLLeiSCGDnikhxtRX1wXiZcYWPdHd3Kx1WK5RV
 HIaLrRS8BLPI2pJJFhzwJqcvpvAFpR9yJLsjXY3a5WyGXyNMqV/e9VgQBCHCjWCCJBzT
 PoBWPd6bGLmCCwifZsxZpHxbFVDxO8uv19CnvKRVOT/By+EHq2JsERn5um7n3F4vv9K+
 KQsP1vjOt0eOQ2yCb6temuLXBxR2OllI61L3w4sxcOz7We6CcCJhZ1uGP1lqLNQLUlr0
 MTgg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795213309; x=1795818109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lZbAFJ5hZp+KhJPRKyRM2sFS1JXKoukA9wnVojH7jR4=;
 b=D+dBa2hzVAEQZGvakZgeWykuwrAY1lREniT/YFSAOm17GFtLX7NurmH0/1ZJpFo9l1
 fozFl/iQU4+H8DUH2VkWTc2wNSEtGq1BbAfuXiU9lOEcs4q2MZN45/85rZmedAz6JHfA
 k4bnUTysGb9uBUACjXOyA33o3tI1gp8MSTxMXxIWdNBfFU40A3fbCWItnXOWt3WXgAw/
 OR46AG4rNP/ltpsD0zDS82kk0AUooqkYJbY27t0pqZz/GejD/mxDp4uZHnWCLJ9Sx3p0
 HODbl3BIrHX5GWF/GYl1eeLt4PjZZRmd5YDRT0LkFfaiJlOnOT3YoIjjXqdRFBEF99n/
 tLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795213309; x=1795818109;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lZbAFJ5hZp+KhJPRKyRM2sFS1JXKoukA9wnVojH7jR4=;
 b=AB2hivAeEMTR5cVe6z6LI/vvoVXXHxXhXsUtknODak7NOXeFE3FVYJmq77uu7NLWC9
 w8NIOe1SXwWb+gWpMBI2EqC+RYySVek4ThgOyBk24R23vgd/V30buaTgNWzQJo/jnHQJ
 qAKORyUL8CdYIpas4e0TmOnCP0wrbpVGjQYb3qAL1te2F9kNNItwEJzfpVTuqIGASjJr
 2+oHd9b/PtINQOO0J5EJO4XTyuJIC4dKy0iJFZUYAj6qEcxucEwPn35p+2RVMHH6iNoE
 MfQkFLgxbW9kfS96eUdEdnw6ZPAsMBBR20ql9ZBgNmaPA8KhLT82PrHJRLJqsQjlbXQ/
 LLuA==
X-Gm-Message-State: APuU4Z+nmpGIKYMoQ6eRyqX5v1FEGwwGQtdM6ZCOKOo5+vtWjS9I0Ydu
 CmbeYeQ2jacxWqbscS+uM+hrZCon2Zvz+7qTEfsoZXKPXDR+wZl+n/7xjT42VJ/W7vkmbB3PRv4
 oHMJZy7qUGnT6S/nv2mzRL64cF+vcHdk=
X-Gm-Gg: AYBFou2HjMXSd0Y78cPE+74hHd7VB2UJWea/KhmjWeiCIugwTrbJndzsbNnqH2NZwdW
 /pUeJa+Itra1HuAZvnWGFiGYf2wDOiLnc4B9LfIV/BcZ0D4MSiLZmi2iL1qs4kmk3G/SHPWNYZ/
 N3O9t1XgG5ZrSJCpN3ot3IVfgoB7Z/+fpvMpUV+Zh1c2gpJeoHAz5Spc6f/XtUItOOtkTiHkGMP
 XAurdIAtnKegqtowpmLqydvtXoG/VH+UnEPeIYBMrILGzb7BRoG8EqHNaoBHD/uxUKJuMu7+/Vo
 LKMwJztkrYGFdx7HnjJhh98kwucKfwX/cUQxllQ4wiODlKppr/XWQPYbFMJ97IbIVvFaQSKkz+d
 7ReMsaC+v1g3tUCEX7fkBBOvjVSm63WrW4PlfVRpPI8qktyQjsIwZP7QaamtipVRht6XBB0Gb2P
 A1PoiGNMEPCjwVpLvGVd2awCq4buab5zTsnTsGKRODrtha8v2HQr6LDOSzJag=
X-Received: by 2002:a05:6808:f0d:b0:572:221b:221b with SMTP id
 5614622812f47-57a0ac2f919mr7261820b6e.5.1795213308855; Fri, 20 Nov 2026
 14:21:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
 <20260911154212.591213-8-shahyan.soltani@amd.com>
In-Reply-To: <20260911154212.591213-8-shahyan.soltani@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Nov 2026 17:21:37 -0500
X-Gm-Features: Aa3M54qxUpADMekiyGUeJhHfBG7yj8e0Eu3hiy6gnyrZtaeotve4ynJQIW6Lmyg
Message-ID: <CADnq5_MwSF626Ji96+3Gkerr8A_OsXAW1BmFh5tciEmo7xLGdg@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/amdgpu: get rid of amdgpu_drm_ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Sep 11, 2026 at 12:01=E2=80=AFPM Shahyan Soltani
<shahyan.soltani@amd.com> wrote:
>
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>
> Remove the entire amdgpu_drm_ioctl handler system in favor of drm_ioctl.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> [shahyan.soltani@amd.com: Added commit description]
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile       |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 23 +-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h   |  6 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c | 45 -----------------------
>  4 files changed, 2 insertions(+), 73 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 7b08814a24da..d5ddf236a6f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -321,7 +321,6 @@ include $(FULL_AMD_PATH)/acp/Makefile
>  amdgpu-y +=3D $(AMD_ACP_FILES)
>  endif
>
> -amdgpu-$(CONFIG_COMPAT) +=3D amdgpu_ioc32.o
>  amdgpu-$(CONFIG_VGA_SWITCHEROO) +=3D amdgpu_atpx_handler.o
>  amdgpu-$(CONFIG_ACPI) +=3D amdgpu_acpi.o
>  amdgpu-$(CONFIG_HMM_MIRROR) +=3D amdgpu_hmm.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 9c5e93cd3ee6..f51f03ae5241 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3019,25 +3019,6 @@ static int amdgpu_drm_release(struct inode *inode,=
 struct file *filp)
>         return drm_release(inode, filp);
>  }
>
> -long amdgpu_drm_ioctl(struct file *filp,
> -                     unsigned int cmd, unsigned long arg)
> -{
> -       struct drm_file *file_priv =3D filp->private_data;
> -       struct drm_device *dev;
> -       long ret;
> -
> -       dev =3D file_priv->minor->dev;
> -       ret =3D pm_runtime_get_sync(dev->dev);
> -       if (ret < 0)
> -               goto out;
> -
> -       ret =3D drm_ioctl(filp, cmd, arg);
> -
> -out:
> -       pm_runtime_put_autosuspend(dev->dev);
> -       return ret;
> -}

Thinking about this a bit more, what happens when KMS IOCTLs get
called (e.g., modeset, display detect, etc.)?  Will they properly
power up the GPU?  I suspect you will either need to properly add ref
counting to the KMS entry points in the display code, or you need to
resurrect this specifically for the KMS IOCTLs.

Alex

> -
>  static const struct dev_pm_ops amdgpu_pm_ops =3D {
>         .prepare =3D pm_sleep_ptr(amdgpu_pmops_prepare),
>         .complete =3D pm_sleep_ptr(amdgpu_pmops_complete),
> @@ -3070,12 +3051,12 @@ static const struct file_operations amdgpu_driver=
_kms_fops =3D {
>         .open =3D drm_open,
>         .flush =3D amdgpu_flush,
>         .release =3D amdgpu_drm_release,
> -       .unlocked_ioctl =3D amdgpu_drm_ioctl,
> +       .unlocked_ioctl =3D drm_ioctl,
>         .mmap =3D drm_gem_mmap,
>         .poll =3D drm_poll,
>         .read =3D drm_read,
>  #ifdef CONFIG_COMPAT
> -       .compat_ioctl =3D amdgpu_kms_compat_ioctl,
> +       .compat_ioctl =3D drm_compat_ioctl,
>  #endif
>  #ifdef CONFIG_PROC_FS
>         .show_fdinfo =3D drm_show_fdinfo,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.h
> index 2d86cc6f7f4d..6b06c0956e48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
> @@ -43,10 +43,4 @@
>
>  extern const struct drm_driver amdgpu_partition_driver;
>
> -long amdgpu_drm_ioctl(struct file *filp,
> -                     unsigned int cmd, unsigned long arg);
> -
> -long amdgpu_kms_compat_ioctl(struct file *filp,
> -                            unsigned int cmd, unsigned long arg);
> -
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ioc32.c
> deleted file mode 100644
> index a1cbd7c3deb2..000000000000
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -/*
> - * \file amdgpu_ioc32.c
> - *
> - * 32-bit ioctl compatibility routines for the AMDGPU DRM.
> - *
> - * \author Paul Mackerras <paulus@samba.org>
> - *
> - * Copyright (C) Paul Mackerras 2005
> - * All Rights Reserved.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a
> - * copy of this software and associated documentation files (the "Softwa=
re"),
> - * to deal in the Software without restriction, including without limita=
tion
> - * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice (including the =
next
> - * paragraph) shall be included in all copies or substantial portions of=
 the
> - * Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> - * THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S
> - * IN THE SOFTWARE.
> - */
> -#include <linux/compat.h>
> -
> -#include <drm/amdgpu_drm.h>
> -#include <drm/drm_ioctl.h>
> -
> -#include "amdgpu_drv.h"
> -
> -long amdgpu_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsign=
ed long arg)
> -{
> -       unsigned int nr =3D DRM_IOCTL_NR(cmd);
> -
> -       if (nr < DRM_COMMAND_BASE)
> -               return drm_compat_ioctl(filp, cmd, arg);
> -
> -       return amdgpu_drm_ioctl(filp, cmd, arg);
> -}
> --
> 2.55.0
>

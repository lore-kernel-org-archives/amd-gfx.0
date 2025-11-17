Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AB0CEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 19:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973F510E1C7;
	Mon, 17 Nov 2025 19:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fVLLfVwj";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DB310E1C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 19:49:05 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7ba92341f07so155111b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 11:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763408945; x=1764013745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwN9xd/+ICCzUFjJbywSX4hJRNbIwbnqiOuOojfw4bA=;
 b=fVLLfVwjFMl516VbEQBcrftJljChIwAl6bPweiKM0n+uh8DvCODISzvtkGBpoLj4Yk
 1P7NoRl35c0nMwXA1YyDlhk8tkUGUTQ6rQCozW0BYmrx0FHdqiIl+nnEG+vw1GdVOu4D
 jclskGvMvv0HwCCMUXKkBdiB3j2UYGqqJ1Vz6UfxWu4PWbNzzaVfHqV/VqvHyeeKXn75
 LGAZWjKwrX8R8ZTOY1lT4mUrONVMULkVSVxJUZW6Z80pkumq25M7dQEnoUZ2fzexL1E2
 CDftCvYtipD2WNyyiSedyCyvNjx9I+5L+GUUtxnHKgCC8dxE0i+GRo5fDd8cJHczqQxY
 a7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763408945; x=1764013745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uwN9xd/+ICCzUFjJbywSX4hJRNbIwbnqiOuOojfw4bA=;
 b=nPue7vdDWCHgCqGUOpfLmz8Yxi5EBJsYBDKwnYaTgDe6jruCJXSGt0Wh2KW2vUIOSN
 WtulkxuN0ljdUyyGbJjDskaCnFNl4Mzn124wUPCgegjmh6BEmm0Mjv202iq5ZpanzetU
 t7eVjchRv68k20YDVbd2G5V4qJEI10nRt2wOpIUjGrnRGTIyFOX4GBRi3lVA17kZHr5y
 n3RGFrF5Y4GUjrLzXDJc9gYerc74RZTv0cq/MuKcxwC6gkBKWqQ5N9OLwrebaGz40piO
 bMIllLiura7Vox3uAhFDzBUAvsDLDjdHG407qhQLE5jCZ94ZpzodW6WUozuzlFiLFfem
 gltg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvTX5Dg2RgX+IyPNlt6vCqArUnrFsO9q6/cxYa0j21TtjEKfwYpEg71mTuW4fknh9iUp4bf7m8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKXydJnUp1jOwi4ufVxPoxvZWuTtgtr/PKdb+Tf3J6AUECMlLe
 YH+dxCKsRZFqELCl5EfSuNUq429Xp1gR8cJLTdYl1frlpHC2Q4iyUHTR8S19Yc8bzYbULx9u6UX
 qCtLK3OY9iPEUDdW4F9QygkYVxEMZEMg=
X-Gm-Gg: ASbGncuZ63JWGInzLLAuW31rxE2IgSS2mfrkvjq9LIZyqOmnclgU6jVXwgBFCc6s9Cf
 +l+TQEp/8659cHv2wIiWg8uqcn/He12W3PG/aY6XaF4sxU36sINlXmzT51vIIBGtJvLNJ+6qtTH
 34w5VUPS0yOlo8R8QFWkPEVcrSFzoRebvlg9hl4QkP45aOJxf38HZ/0v0u33ThE3Qr/fTuOoQfg
 I8/hBHwXIQver5KxQbQzy5hYhATOnOYc3t+MVQpJHCDsxMj0HXI3BKfik0IMgWONEf6npP5b/0w
 plqlEg==
X-Google-Smtp-Source: AGHT+IE/8ggS6LUeyVsp5eEk+e9DOPtpK5cG7eKvt4t1ew0SgFR+tKonGHD5OH0s8yx7jrceY7HF7o2yVSkpv+xcRzs=
X-Received: by 2002:a05:7022:6297:b0:11a:c044:ec44 with SMTP id
 a92af1059eb24-11c78562aa4mr21812c88.0.1763408944651; Mon, 17 Nov 2025
 11:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20251114-vram-carveout-tuning-for-upstream-v2-0-4f6bdd48030d@amd.com>
 <20251114-vram-carveout-tuning-for-upstream-v2-4-4f6bdd48030d@amd.com>
In-Reply-To: <20251114-vram-carveout-tuning-for-upstream-v2-4-4f6bdd48030d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Nov 2025 14:48:52 -0500
X-Gm-Features: AWmQ_blyq-3bafSyeznjWZ3ESVeo9aWvK16_VaoKKclzjAv-7Z2Oe4CELV6neqw
Message-ID: <CADnq5_Mjo7M-ndi0mOUZzrvCnz2gUY0wm0a7uGtdLp=_kWLW0Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] drm/amdgpu: add UMA allocation interfaces to sysfs
To: "Yo-Jung Leo Lin (AMD)" <Leo.Lin@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, "Tsao, Anson" <anson.tsao@amd.com>, 
 "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
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

On Fri, Nov 14, 2025 at 3:52=E2=80=AFAM Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.=
com> wrote:
>
> Add two sysfs files as interfaces to inspect or change UMA carveout
> size. These files are:
>
> - uma_carveout_options: a read-only file listing all the available
>   UMA allocation options and their index.
>
> - uma_carveout: a file that is both readable and writable. On read,
>   it shows the index of the current setting. Writing a valid index
>   into this file allows users to change the UMA carveout size to that
>   option on the next boot.

Would it be cleaner to combine these?  Reading the file would show the
indexed list of options with a * next to the currently selected one
and then writing the index to the file would cause the change to take
effect on the next reboot.

Alex

>
> Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 127 +++++++++++++++++++++++++=
++++++
>  1 file changed, 127 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 444ab4102168..b9378f34eb79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -30,6 +30,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/suspend.h>
> +#include <linux/device.h>
>  #include <acpi/video.h>
>  #include <acpi/actbl.h>
>
> @@ -1247,6 +1248,125 @@ int amdgpu_acpi_get_mem_info(struct amdgpu_device=
 *adev, int xcc_id,
>         return -ENOENT;
>  }
>
> +static ssize_t uma_carveout_options_show(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf)
> +{
> +       struct amdgpu_uma_carveout_info *uma_info =3D &amdgpu_acpi_priv.a=
tcs.uma_info;
> +       ssize_t size =3D 0;
> +
> +       if (!uma_info || !uma_info->num_entries)
> +               return -ENODEV;
> +
> +       for (int i =3D 0; i < uma_info->num_entries; i++) {
> +               size +=3D sysfs_emit_at(buf, size, "%d: %s (%u GB)\n",
> +                                     i,
> +                                     uma_info->entries[i].name,
> +                                     uma_info->entries[i].memory_carved)=
;
> +       }
> +
> +       return size;
> +}
> +static DEVICE_ATTR_RO(uma_carveout_options);
> +
> +static ssize_t uma_carveout_show(struct device *dev,
> +                                struct device_attribute *attr,
> +                                char *buf)
> +{
> +       return sysfs_emit(buf, "%u\n", amdgpu_acpi_priv.atcs.uma_info.uma=
_option_index);
> +}
> +
> +static ssize_t uma_carveout_store(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 const char *buf, size_t count)
> +{
> +       struct amdgpu_uma_carveout_info *uma_info =3D &amdgpu_acpi_priv.a=
tcs.uma_info;
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       struct amdgpu_uma_carveout_option *opt;
> +       unsigned long val;
> +       uint8_t flags;
> +       int r;
> +
> +       r =3D kstrtoul(buf, 10, &val);
> +       if (r)
> +               return r;
> +
> +       if (val >=3D uma_info->num_entries)
> +               return -EINVAL;
> +
> +       opt =3D &uma_info->entries[val];
> +
> +       if (!(opt->flags & AMDGPU_UMA_FLAG_AUTO) &&
> +           !(opt->flags & AMDGPU_UMA_FLAG_CUSTOM)) {
> +               drm_err_once(ddev, "Option %ul not supported due to lack =
of Custom/Auto flag", r);
> +               return -EINVAL;
> +       }
> +
> +       flags =3D opt->flags;
> +       flags &=3D ~((flags & AMDGPU_UMA_FLAG_AUTO) >> 1);
> +
> +       guard(mutex)(&uma_info->update_lock);
> +
> +       r =3D amdgpu_acpi_set_uma_allocation_size(adev, val, flags);
> +       if (r)
> +               return r;
> +
> +       uma_info->uma_option_index =3D val;
> +
> +       return count;
> +}
> +static DEVICE_ATTR_RW(uma_carveout);
> +
> +static struct attribute *amdgpu_uma_attrs[] =3D {
> +       &dev_attr_uma_carveout.attr,
> +       &dev_attr_uma_carveout_options.attr,
> +       NULL
> +};
> +
> +const struct attribute_group amdgpu_uma_attr_group =3D {
> +       .attrs =3D amdgpu_uma_attrs
> +};
> +
> +static int amdgpu_acpi_uma_option_init(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_atcs *atcs =3D &amdgpu_acpi_priv.atcs;
> +       int rc;
> +
> +       if (!atcs->functions.set_uma_allocation_size)
> +               return -ENODEV;
> +
> +       rc =3D amdgpu_atomfirmware_get_uma_carveout_info(adev, &atcs->uma=
_info);
> +       if (rc) {
> +               drm_dbg(adev_to_drm(adev),
> +                       "Failed to parse UMA carveout info from VBIOS: %d=
\n", rc);
> +               goto out_info;
> +       }
> +
> +       mutex_init(&atcs->uma_info.update_lock);
> +
> +       rc =3D devm_device_add_group(adev->dev, &amdgpu_uma_attr_group);
> +       if (rc) {
> +               drm_dbg(adev_to_drm(adev), "Failed to add UMA carveout sy=
sfs interfaces %d\n", rc);
> +               goto out_attr;
> +       }
> +
> +       return 0;
> +
> +out_attr:
> +       mutex_destroy(&atcs->uma_info.update_lock);
> +out_info:
> +       return rc;
> +}
> +
> +static void amdgpu_acpi_uma_option_fini(void)
> +{
> +       struct amdgpu_uma_carveout_info *uma_info =3D &amdgpu_acpi_priv.a=
tcs.uma_info;
> +
> +       mutex_destroy(&uma_info->update_lock);
> +       uma_info->num_entries =3D 0;
> +}
> +
>  /**
>   * amdgpu_acpi_event - handle notify events
>   *
> @@ -1291,6 +1411,12 @@ static int amdgpu_acpi_event(struct notifier_block=
 *nb,
>  int amdgpu_acpi_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_atif *atif =3D &amdgpu_acpi_priv.atif;
> +       int rc;
> +
> +       rc =3D amdgpu_acpi_uma_option_init(adev);
> +
> +       if (rc)
> +               drm_dbg(adev_to_drm(adev), "Not creating uma carveout int=
erfaces: %d", rc);
>
>         if (atif->notifications.brightness_change) {
>                 if (adev->dc_enabled) {
> @@ -1343,6 +1469,7 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_d=
m_backlight_caps *caps)
>  void amdgpu_acpi_fini(struct amdgpu_device *adev)
>  {
>         unregister_acpi_notifier(&adev->acpi_nb);
> +       amdgpu_acpi_uma_option_fini();
>  }
>
>  /**
>
> --
> 2.43.0
>

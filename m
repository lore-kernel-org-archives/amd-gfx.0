Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8FED116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 20:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313AB10E47A;
	Mon,  1 Dec 2025 20:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LHltBVfd";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A055810E47A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 20:05:55 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7bb2fa942daso549012b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764619555; x=1765224355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFrWgmkG7JMlma11RCf17aNl2kDEHMj0EdooeYV2b8A=;
 b=LHltBVfdnaTxvmn8+R0dgPvsiWMXaxVfSJw85rOWD+ibmMYat7GEW9BCzLJgq002Yr
 y+SPsmIE8IGQY9uJQofhAh0iTsmvwncmSjXEKVrjLvcdeKnjJj0MP7Hsh26IvS7bW8J8
 KBrBkWgQqQ9flqy+v0pKZXMuWFHC4xcu8Wiwprmkrm7xgUbCiyrPP4cSS+HyePt58gUA
 ieamZDe7PiQBUW9SS/oxu42J8CPquEitJhqKzgC65l6pR/hQvsyK60MqhDwitEkWbPj0
 tPAM6I6QRdddNuFd6NBgJJ5jKixRCnNMnySmMQoeVDuojRd9aWnCU5lIpSDGc0eLmw4e
 yQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764619555; x=1765224355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFrWgmkG7JMlma11RCf17aNl2kDEHMj0EdooeYV2b8A=;
 b=oHIkqLFUFMp0sLdzhQfcHNcP+pStbYT0pyVuQO3neNN6Sz8srLFdWPx/VTxMHPbyfL
 +FTTIFHUL+xpJSrAcc814uXixH6GSiihWY5OPe6D68m34bebWbN+bKE89kVTA38ZpTHg
 F462UV1at9sjFM8WufiCDVUwPZvuXGVAwD6VOIEhkj3sEAEtwQZH90ahN0yKMRLvlAM4
 mFgFMA4xnhZrWmQB6WUIYztiesonevVIcpDbnuzOZk1g5VsUTjb0CQHocgB8UnlsQ9pz
 w017RgFmjRm/6JTqjv6taH49TDNhlQ/3k2gYTPlH7/I3pcIAxvWH917uJShRPjuqY9XI
 6QVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5/xIsRy9j2wqWBMWrCraaoWvKgRCnJ0qvcPuo4V8RpN45SOeOQHFq5Ns+dcG1hzLeEtu3m5KG@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2PX5J9ShVjntKVJaOZILPJNAmOVe2DBEqqspi3tqXibT2gzS4
 I78+Q1vp8MnuP90W/ZYO4jdJ+W1f0Wpsg9KLhyRHUm1zzINd7NCUiqL0CsnqvyVPSmR86DEKBDo
 Tq8j2D7ZS14gXARgLupzQOcSjNgQ1am4=
X-Gm-Gg: ASbGncvlsST5dS0EQrhFsIZv9cqAl/K4aXkmBnUrbIp8JFgcqy1nNnc5Njbt4Xr51r6
 7Xg46Q541EQLpmq/XooXUZASE8YfBSrA3efgcEWp/sFl/FhC/mz39kcNLjCxnCC+fzbBdo/iixM
 xOzOk7ANqnSDkz4mJk4NwNINUu7Y25Pa5gugSgurqoAW30BBbo5SngBLPeCgUN24IGNbkJKblaH
 JFytd8eBXJkZwSBAbFhUjnCKbbQt5gAStFCr8aleWBPdp4L106WzxgPiH3xlnGfYFDN9n4=
X-Google-Smtp-Source: AGHT+IEVGxZvEymQ5Z+ZhxpVm8zthm+G7kUrixr4nf8AMH7ygnh0W1c1kRagjmD0HRQTA1/QkwPyNPX9JIfAfaaRiAY=
X-Received: by 2002:a05:7022:6299:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-11c9f31a210mr23772934c88.2.1764619554839; Mon, 01 Dec 2025
 12:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20251201-vram-carveout-tuning-for-upstream-v4-0-9e151363b5ab@amd.com>
 <20251201-vram-carveout-tuning-for-upstream-v4-4-9e151363b5ab@amd.com>
In-Reply-To: <20251201-vram-carveout-tuning-for-upstream-v4-4-9e151363b5ab@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Dec 2025 15:05:42 -0500
X-Gm-Features: AWmQ_blfEQxmQc_uSIvHcJCYBb5U06PuZh5Q_2wd4BtKvvM2GdlVIsLAcf5gU0o
Message-ID: <CADnq5_MWujeT-t36TfzuqUvc_O+J15s_iYzx=WpPMzV9tcUDEg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] drm/amdgpu: add UMA allocation interfaces to sysfs
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

On Mon, Dec 1, 2025 at 6:09=E2=80=AFAM Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.c=
om> wrote:
>
> Add a uma/ directory containing two sysfs files as interfaces to
> inspect or change UMA carveout size. These files are:
>
> - uma/carveout_options: a read-only file listing all the available
>   UMA allocation options and their index.
>
> - uma/carveout: a file that is both readable and writable. On read,
>   it shows the index of the current setting. Writing a valid index
>   into this file allows users to change the UMA carveout size to that
>   option on the next boot.
>
> Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 139 +++++++++++++++++++++++++=
++++++
>  1 file changed, 139 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index bce9027fa241..2c0405cdc436 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -30,6 +30,8 @@
>  #include <linux/power_supply.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/suspend.h>
> +#include <linux/device.h>
> +#include <linux/nospec.h>
>  #include <acpi/video.h>
>  #include <acpi/actbl.h>
>
> @@ -1246,6 +1248,136 @@ int amdgpu_acpi_get_mem_info(struct amdgpu_device=
 *adev, int xcc_id,
>         return -ENOENT;
>  }
>
> +static ssize_t carveout_options_show(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    char *buf)
> +{
> +       struct amdgpu_uma_carveout_info *uma_info =3D &amdgpu_acpi_priv.a=
tcs.uma_info;
> +       uint32_t memory_carved;
> +       ssize_t size =3D 0;
> +
> +       if (!uma_info || !uma_info->num_entries)
> +               return -ENODEV;
> +
> +       for (int i =3D 0; i < uma_info->num_entries; i++) {
> +               memory_carved =3D uma_info->entries[i].memory_carved_mb;
> +               if (memory_carved >=3D SZ_1G/SZ_1M) {
> +                       size +=3D sysfs_emit_at(buf, size, "%d: %s (%u GB=
)\n",
> +                                             i,
> +                                             uma_info->entries[i].name,
> +                                             memory_carved >> 10);
> +               } else {
> +                       size +=3D sysfs_emit_at(buf, size, "%d: %s (%u MB=
)\n",
> +                                             i,
> +                                             uma_info->entries[i].name,
> +                                             memory_carved);
> +               }
> +       }
> +
> +       return size;
> +}
> +static DEVICE_ATTR_RO(carveout_options);
> +
> +static ssize_t carveout_show(struct device *dev,
> +                            struct device_attribute *attr,
> +                            char *buf)
> +{
> +       return sysfs_emit(buf, "%u\n", amdgpu_acpi_priv.atcs.uma_info.uma=
_option_index);
> +}
> +
> +static ssize_t carveout_store(struct device *dev,
> +                             struct device_attribute *attr,
> +                             const char *buf, size_t count)
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
> +       val =3D array_index_nospec(val, uma_info->num_entries);
> +       opt =3D &uma_info->entries[val];
> +
> +       if (!(opt->flags & AMDGPU_UMA_FLAG_AUTO) &&
> +           !(opt->flags & AMDGPU_UMA_FLAG_CUSTOM)) {
> +               drm_err_once(ddev, "Option %lu not supported due to lack =
of Custom/Auto flag", val);
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
> +static DEVICE_ATTR_RW(carveout);
> +
> +static struct attribute *amdgpu_uma_attrs[] =3D {
> +       &dev_attr_carveout.attr,
> +       &dev_attr_carveout_options.attr,
> +       NULL
> +};
> +
> +const struct attribute_group amdgpu_uma_attr_group =3D {
> +       .name =3D "uma",
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
> @@ -1290,6 +1422,12 @@ static int amdgpu_acpi_event(struct notifier_block=
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
> @@ -1342,6 +1480,7 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_d=
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

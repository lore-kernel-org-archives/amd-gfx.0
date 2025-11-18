Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D532CEDD97
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 14:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AEC910E4CB;
	Tue, 18 Nov 2025 14:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VhvCt8t+";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D5810E4CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 14:30:24 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-34384760ce1so1033435a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 06:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763476224; x=1764081024; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pLRjjJhoTglZ7jWNZgoDl/9rlpfI3e4+ly647tQW+Y=;
 b=VhvCt8t+7CXUFy59IFeDQvCkRYHHlYbrktnQfBuPNhf4q6xLAVjcYTgREngEPMAqFn
 jiTDIekQf7ei8XXtojpLScRqvtboI8Dgr4Ap2pa3UzHgvXHJXmhYeRzawqZ7Bh/LhPdu
 6FeG7woSX+pVDs5EV5t409bc8BQ5IaiUH4XdTppHFMloC6Xc98yjac3o8oO2vaMkSqmO
 02OhMhKLV8wyig3TdcNLNdgjg/QOpnMd4hKWMdXgM6HSR+HjLD8/4qPwIofCuuuUuRXT
 /9vcbbNr00/JPAq5YSdp96KpQybWlCJx2r8f4QpmCqKSxeR+kb51YgUrqkFxltiEyJRb
 kWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763476224; x=1764081024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4pLRjjJhoTglZ7jWNZgoDl/9rlpfI3e4+ly647tQW+Y=;
 b=l6eis2rQE/zVkjNZk1IijUXTbQWrgmHplAdQImGk68JlgWJLVBw90/MI8La0MR4ICM
 agnFYetPelKYOUOnbF+1+hr3Z/wVcieTAO4z/7rmqZ27ukHjfo3FJwM9ZJK52KbkhIIr
 lfU1gvIWdttrya45+vwqQJcLTmtAz6Hkzon/u60SHhC/mSBg6FrDJ6nwq1NQ565NmPfG
 f75m2pmMay2kAqwmLkPeBrXLhOSrGXh/WXCGx0aTb4y89QzfedR6w1qAsRkYJJEEud6R
 eKNuZVf7HfZ49rjh07KjWW4cheKMBlzx3dIZRPYemguWrHMDq+ibqrN0a170FswJ84Wj
 I35w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs8kQifCZLWyLCG1NB/DSD3Gly72al2ZlaVr1tCkzeipyUcBEopdO+Qk50jzX0uocZuff9maxA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvunGrOvXq0A9KoIlgegeiOeagQrbRqZrVufUBDf3KTzAuL81j
 gyFVjOpN2mq1986zAoqM6wSFzCSTMMBdb12NJ+3ZSvA4gVaXks/Wr7hRI2Ef8PfJy7zVr37bcM0
 S79smjSD4UB7ofLa4hbvrAYz7paiiPms=
X-Gm-Gg: ASbGnct3VYGNI+9HU7Jgbrh2hhcr/Rz9TvEIESzGAptrDeiBEudHqdqDZjZFKRrBNG4
 QwmfD/HEtpWghGbQvi/4vKCGMHjovB+btxXpY6qtKIblAokVthhLxuPeg8Qjhd+KhyNXX46zfdo
 I0DS/fS46qEjRsQ8PAVHwqpi8Wpl6xCB7MidEgSpB0m8QlnE8IvtaGlPdms4c9t6tsUgg5qX5Tt
 5XAudEDfg4ms6fV+SRGNNmxX5xIMRn8LJgoNYKto7HKadl+mgFsGY5R7PcK
X-Google-Smtp-Source: AGHT+IE6uGTqmvLMIY/BkY6TlrUxtJXmh1E20OtRrddBLXAbgsNYa3QmPGXBgWhB6L6vhMWtQABqyVNIlhDGCWF0t+I=
X-Received: by 2002:a05:7022:a9d:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-11c7859cb60mr1060537c88.0.1763476223152; Tue, 18 Nov 2025
 06:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20251114-vram-carveout-tuning-for-upstream-v2-0-4f6bdd48030d@amd.com>
 <20251114-vram-carveout-tuning-for-upstream-v2-4-4f6bdd48030d@amd.com>
 <CADnq5_Mjo7M-ndi0mOUZzrvCnz2gUY0wm0a7uGtdLp=_kWLW0Q@mail.gmail.com>
 <DS0PR12MB8479B79EE3D12DDCB27463D6FED6A@DS0PR12MB8479.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB8479B79EE3D12DDCB27463D6FED6A@DS0PR12MB8479.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Nov 2025 09:30:11 -0500
X-Gm-Features: AWmQ_bnL1HUUszUeY5LN2QTF2g6sDGRCkasOJUpuKaiRdAAPcoGDNGpLkdiZRuc
Message-ID: <CADnq5_NOCjk2jFzABpiPeazAgd0Ke-ZQKpkm60fxgTRWES8naw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] drm/amdgpu: add UMA allocation interfaces to sysfs
To: "Lin, Leo" <Leo.Lin@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Tsao,
 Anson" <anson.tsao@amd.com>, 
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

On Tue, Nov 18, 2025 at 9:22=E2=80=AFAM Lin, Leo <Leo.Lin@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, November 18, 2025 3:49 AM
> > To: Lin, Leo <Leo.Lin@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona
> > Vetter <simona@ffwll.ch>; Maarten Lankhorst
> > <maarten.lankhorst@linux.intel.com>; Maxime Ripard
> > <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>;
> > Jonathan Corbet <corbet@lwn.net>; amd-gfx@lists.freedesktop.org; dri-
> > devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; linux-
> > doc@vger.kernel.org; Tsao, Anson <anson.tsao@amd.com>; Mario
> > Limonciello (AMD) (kernel.org) <superm1@kernel.org>
> > Subject: Re: [PATCH v2 4/5] drm/amdgpu: add UMA allocation interfaces t=
o
> > sysfs
> >
> > On Fri, Nov 14, 2025 at 3:52=E2=80=AFAM Yo-Jung Leo Lin (AMD) <Leo.Lin@=
amd.com>
> > wrote:
> > >
> > > Add two sysfs files as interfaces to inspect or change UMA carveout
> > > size. These files are:
> > >
> > > - uma_carveout_options: a read-only file listing all the available
> > >   UMA allocation options and their index.
> > >
> > > - uma_carveout: a file that is both readable and writable. On read,
> > >   it shows the index of the current setting. Writing a valid index
> > >   into this file allows users to change the UMA carveout size to that
> > >   option on the next boot.
> >
> > Would it be cleaner to combine these?  Reading the file would show the
> > indexed list of options with a * next to the currently selected one and=
 then
> > writing the index to the file would cause the change to take effect on =
the next
> > reboot.
> >
> > Alex
>
> My thought is that it'll make it less friendly for processing output with=
 awk/cut/other text processing tools. Also, I feel that the format will be =
trickier to maintain in the future, considering that it has to stay consist=
ent for potentially new carveout option naming scheme.
>
> (Plus, the general guideline of making a sysfs file content array-ish in =
the kernel doc.[1])
>
> That being said, it's my personal thought. If you feel cleaner to merge t=
hose two interfaces into one, it's definitely possible to do this in the ne=
xt version and see what people's feedback would be. Let me know if that's w=
hat you'd like to see.
>
> [1]  https://docs.kernel.org/filesystems/sysfs.html#attributes

Most of the other sysfs files work more like what I suggested.  That
said, if you'd prefer the other method, can you group then in a
directory?  E.g.,
uma/carveout_options
uma/carveout

Thanks,

Alex

>
> BR,
> Leo
>
> >
> > >
> > > Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > Signed-off-by: Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 127
> > > +++++++++++++++++++++++++++++++
> > >  1 file changed, 127 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > index 444ab4102168..b9378f34eb79 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > @@ -30,6 +30,7 @@
> > >  #include <linux/power_supply.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/suspend.h>
> > > +#include <linux/device.h>
> > >  #include <acpi/video.h>
> > >  #include <acpi/actbl.h>
> > >
> > > @@ -1247,6 +1248,125 @@ int amdgpu_acpi_get_mem_info(struct
> > amdgpu_device *adev, int xcc_id,
> > >         return -ENOENT;
> > >  }
> > >
> > > +static ssize_t uma_carveout_options_show(struct device *dev,
> > > +                                        struct device_attribute *att=
r,
> > > +                                        char *buf) {
> > > +       struct amdgpu_uma_carveout_info *uma_info =3D
> > &amdgpu_acpi_priv.atcs.uma_info;
> > > +       ssize_t size =3D 0;
> > > +
> > > +       if (!uma_info || !uma_info->num_entries)
> > > +               return -ENODEV;
> > > +
> > > +       for (int i =3D 0; i < uma_info->num_entries; i++) {
> > > +               size +=3D sysfs_emit_at(buf, size, "%d: %s (%u GB)\n"=
,
> > > +                                     i,
> > > +                                     uma_info->entries[i].name,
> > > +                                     uma_info->entries[i].memory_car=
ved);
> > > +       }
> > > +
> > > +       return size;
> > > +}
> > > +static DEVICE_ATTR_RO(uma_carveout_options);
> > > +
> > > +static ssize_t uma_carveout_show(struct device *dev,
> > > +                                struct device_attribute *attr,
> > > +                                char *buf) {
> > > +       return sysfs_emit(buf, "%u\n",
> > > +amdgpu_acpi_priv.atcs.uma_info.uma_option_index);
> > > +}
> > > +
> > > +static ssize_t uma_carveout_store(struct device *dev,
> > > +                                 struct device_attribute *attr,
> > > +                                 const char *buf, size_t count) {
> > > +       struct amdgpu_uma_carveout_info *uma_info =3D
> > &amdgpu_acpi_priv.atcs.uma_info;
> > > +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > > +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> > > +       struct amdgpu_uma_carveout_option *opt;
> > > +       unsigned long val;
> > > +       uint8_t flags;
> > > +       int r;
> > > +
> > > +       r =3D kstrtoul(buf, 10, &val);
> > > +       if (r)
> > > +               return r;
> > > +
> > > +       if (val >=3D uma_info->num_entries)
> > > +               return -EINVAL;
> > > +
> > > +       opt =3D &uma_info->entries[val];
> > > +
> > > +       if (!(opt->flags & AMDGPU_UMA_FLAG_AUTO) &&
> > > +           !(opt->flags & AMDGPU_UMA_FLAG_CUSTOM)) {
> > > +               drm_err_once(ddev, "Option %ul not supported due to l=
ack of
> > Custom/Auto flag", r);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       flags =3D opt->flags;
> > > +       flags &=3D ~((flags & AMDGPU_UMA_FLAG_AUTO) >> 1);
> > > +
> > > +       guard(mutex)(&uma_info->update_lock);
> > > +
> > > +       r =3D amdgpu_acpi_set_uma_allocation_size(adev, val, flags);
> > > +       if (r)
> > > +               return r;
> > > +
> > > +       uma_info->uma_option_index =3D val;
> > > +
> > > +       return count;
> > > +}
> > > +static DEVICE_ATTR_RW(uma_carveout);
> > > +
> > > +static struct attribute *amdgpu_uma_attrs[] =3D {
> > > +       &dev_attr_uma_carveout.attr,
> > > +       &dev_attr_uma_carveout_options.attr,
> > > +       NULL
> > > +};
> > > +
> > > +const struct attribute_group amdgpu_uma_attr_group =3D {
> > > +       .attrs =3D amdgpu_uma_attrs
> > > +};
> > > +
> > > +static int amdgpu_acpi_uma_option_init(struct amdgpu_device *adev) {
> > > +       struct amdgpu_atcs *atcs =3D &amdgpu_acpi_priv.atcs;
> > > +       int rc;
> > > +
> > > +       if (!atcs->functions.set_uma_allocation_size)
> > > +               return -ENODEV;
> > > +
> > > +       rc =3D amdgpu_atomfirmware_get_uma_carveout_info(adev, &atcs-
> > >uma_info);
> > > +       if (rc) {
> > > +               drm_dbg(adev_to_drm(adev),
> > > +                       "Failed to parse UMA carveout info from VBIOS=
: %d\n", rc);
> > > +               goto out_info;
> > > +       }
> > > +
> > > +       mutex_init(&atcs->uma_info.update_lock);
> > > +
> > > +       rc =3D devm_device_add_group(adev->dev, &amdgpu_uma_attr_grou=
p);
> > > +       if (rc) {
> > > +               drm_dbg(adev_to_drm(adev), "Failed to add UMA carveou=
t sysfs
> > interfaces %d\n", rc);
> > > +               goto out_attr;
> > > +       }
> > > +
> > > +       return 0;
> > > +
> > > +out_attr:
> > > +       mutex_destroy(&atcs->uma_info.update_lock);
> > > +out_info:
> > > +       return rc;
> > > +}
> > > +
> > > +static void amdgpu_acpi_uma_option_fini(void) {
> > > +       struct amdgpu_uma_carveout_info *uma_info =3D
> > > +&amdgpu_acpi_priv.atcs.uma_info;
> > > +
> > > +       mutex_destroy(&uma_info->update_lock);
> > > +       uma_info->num_entries =3D 0;
> > > +}
> > > +
> > >  /**
> > >   * amdgpu_acpi_event - handle notify events
> > >   *
> > > @@ -1291,6 +1411,12 @@ static int amdgpu_acpi_event(struct
> > > notifier_block *nb,  int amdgpu_acpi_init(struct amdgpu_device *adev)
> > > {
> > >         struct amdgpu_atif *atif =3D &amdgpu_acpi_priv.atif;
> > > +       int rc;
> > > +
> > > +       rc =3D amdgpu_acpi_uma_option_init(adev);
> > > +
> > > +       if (rc)
> > > +               drm_dbg(adev_to_drm(adev), "Not creating uma carveout
> > > + interfaces: %d", rc);
> > >
> > >         if (atif->notifications.brightness_change) {
> > >                 if (adev->dc_enabled) { @@ -1343,6 +1469,7 @@ void
> > > amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
> > > void amdgpu_acpi_fini(struct amdgpu_device *adev)  {
> > >         unregister_acpi_notifier(&adev->acpi_nb);
> > > +       amdgpu_acpi_uma_option_fini();
> > >  }
> > >
> > >  /**
> > >
> > > --
> > > 2.43.0
> > >

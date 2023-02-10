Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CC5C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 16:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 604AF10E12E;
	Fri, 10 Feb 2023 16:37:22 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F8E10E12E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 16:37:20 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id cz14so4860619oib.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 08:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lZGbGz1NhrfpSRG2z7TL3PYxSXZAjKUnuSOuFnqQH1M=;
 b=J/9YT4DMQEDgj8/252EPESJY9MGTEXGRBHKNumqXE2p3HtcnXwLmcYFgJjNhgnarlY
 QinCKWkt5IZgSgKNAB4OoYPrldjLis0yV5D8RdMQILUCxqTwRpQmlKbAZhGn6655G1ot
 WAj0XVX1imiwW52nLWksZqsPtxknYYR7u7OtmCEJYNlXodegV2IrMIv1Hen546qavFQr
 iwkpkQFB4BsPsFNv+dgS46s7i/QOA2way5cMVVdmyhOYtKxOTQ9gxACHd0rdJOmRL009
 sau7+jnv5FcP0odLXOjyxJjzqoMsZ7UZdeNufPhhFsA4EX4d8A98u/CItxxxvoWyFhbd
 QQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lZGbGz1NhrfpSRG2z7TL3PYxSXZAjKUnuSOuFnqQH1M=;
 b=Atu7NH9hm/lPfp/kFu86hxqDXQeuNplpGxklCWn+vKOI2l+hoWU7dUJR079XNkq9+Z
 U8zbMkmHu+v445Ko2XBcvT0OqKCgnU6CYCi5fWztA+gVe1nGbnLgZXJZlpnS4E0tsW4D
 mosv1Lz5mqcl2WTdKiJQEF/l/bMpeJyRQ9Eu+WEHz3RSaghfI12wQZol8MsRqYYHaHpa
 OFTgHc+9XSthrym/+4CCiqlWV1XlPgKX7vlT1QLI5Fs5WQ5s/TRAFiq9SM6xT6OpWBIr
 I9/XPU16y9Ao2tvNP1Q+9r9m3O2kX9FPuzqjG18mA/vIeEI/i9ZY6dET5bPm6Mk8NBj0
 96/Q==
X-Gm-Message-State: AO0yUKViNtYWF34IjjF5ghZumXflIgmzms4lY7d1Bfx+JjDJODeilK8c
 yukK323MXyPladFR8Yw/IXoLfSZE/g92wKiJAvo=
X-Google-Smtp-Source: AK7set+2eWH+CMgS4hAF2ka24mHW+jrtFcHDoTu3x6gdp5f/5ym8/9ji5ZX8mgiO3zxiEOUWAIeoJiwqo9LUlsTOKwE=
X-Received: by 2002:aca:3dd4:0:b0:378:4edd:a89c with SMTP id
 k203-20020aca3dd4000000b003784edda89cmr1122180oia.46.1676047039514; Fri, 10
 Feb 2023 08:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-10-orlandoch.dev@gmail.com>
 <CADnq5_PVsrk4+K45kVgU=r98B9GgC2CxbC8AvGUXRtv2sZAHPg@mail.gmail.com>
 <b3a2d525-b30c-164c-705c-97fcb0016540@redhat.com>
In-Reply-To: <b3a2d525-b30c-164c-705c-97fcb0016540@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Feb 2023 11:37:08 -0500
Message-ID: <CADnq5_PXa=d8ie8jj7sGxvxfn+ZNwed-eSyNg89PfWCvpo8LCw@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] drm/amdgpu: register a vga_switcheroo client for
 all GPUs that are not thunderbolt attached
To: Hans de Goede <hdegoede@redhat.com>
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
Cc: alsa-devel@alsa-project.org,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Rander Wang <rander.wang@intel.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>, Kerem Karabay <kekrby@gmail.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 amd-gfx@lists.freedesktop.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>,
 Mark Gross <markgross@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Evan Quan <evan.quan@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 Aditya Garg <gargaditya08@live.com>, platform-driver-x86@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 10, 2023 at 11:07 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/10/23 16:53, Alex Deucher wrote:
> > On Fri, Feb 10, 2023 at 3:04 AM Orlando Chamberlain
> > <orlandoch.dev@gmail.com> wrote:
> >>
> >> From: Kerem Karabay <kekrby@gmail.com>
> >>
> >> Commit 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
> >> vga_switcheroo") made amdgpu only register a vga_switcheroo client for
> >> GPU's with PX, however AMD GPUs in dual gpu Apple Macbooks do need to
> >> register, but don't have PX. Instead of AMD's PX, they use apple-gmux.
> >
> > Is there a way to detect apple-gmux instead?  Otherwise, we register
> > vga_switcheroo on any system with multiple GPUs which is not what we
> > want.
>
> Yes since 6.1.y (either stable series or just take 6.2.0) the apple-gmux
> detect code has been factored out into a stand-alone
> apple_gmux_detect() helper inside:
>
> include/linux/apple-gmux.h
>
> For usage outside of the actual apple-gmux driver you can simply
> pass NULL for both arguments.
>
> This was necessary to reliably check if the apple-gmux should be
> used for backlight control.
>
> Note there also is the older apple_gmux_present() helper, which is
> already used in some drm code. That function is not reliable though
> it detects if the ACPI tables contain an ACPI device describing
> the presence of a gmux, but it turns out even Apple has buggy ACPI
> tables and the mere presence of that ACPI device is not a reliable
> indicator the gmux is actually there.
>
> I have not changed over any of the existing apple_gmux_present()
> users for fear of unwanted side effects...

Looks like we could maybe use the PWRD ACPI check like patch 8 does as well.

Alex

>
> Regards,
>
> Hans
>
>
>
>
> >> Revert to the old logic of registering for all non-thunderbolt gpus,
> >> like radeon and nouveau.
> >>
> >> Fixes: 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and vga_switcheroo")
> >> Signed-off-by: Kerem Karabay <kekrby@gmail.com>
> >> [Orlando Chamberlain <orlandoch.dev@gmail.com>: add commit description]
> >> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++++++++-------
> >>  1 file changed, 11 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> index 2f28a8c02f64..0bb553a61552 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -3919,12 +3919,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> >>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
> >>                 vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
> >>
> >> -       if (amdgpu_device_supports_px(ddev)) {
> >> -               px = true;
> >> -               vga_switcheroo_register_client(adev->pdev,
> >> -                                              &amdgpu_switcheroo_ops, px);
> >> +       px = amdgpu_device_supports_px(ddev);
> >> +
> >> +       if (!pci_is_thunderbolt_attached(adev->pdev))
> >> +               vga_switcheroo_register_client(adev->pdev, &amdgpu_switcheroo_ops, px);
> >> +
> >> +       if (px)
> >>                 vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
> >> -       }
> >>
> >>         if (adev->gmc.xgmi.pending_reset)
> >>                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
> >> @@ -4048,10 +4049,13 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> >>
> >>         kfree(adev->bios);
> >>         adev->bios = NULL;
> >> -       if (amdgpu_device_supports_px(adev_to_drm(adev))) {
> >> +
> >> +       if (!pci_is_thunderbolt_attached(adev->pdev))
> >>                 vga_switcheroo_unregister_client(adev->pdev);
> >> +
> >> +       if (amdgpu_device_supports_px(adev_to_drm(adev)))
> >>                 vga_switcheroo_fini_domain_pm_ops(adev->dev);
> >> -       }
> >> +
> >>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
> >>                 vga_client_unregister(adev->pdev);
> >>
> >> --
> >> 2.39.1
> >>
> >
>

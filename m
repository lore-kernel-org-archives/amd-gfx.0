Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F5FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 17:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684A110E260;
	Mon, 24 Jan 2022 17:04:31 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C3310E260
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 17:04:29 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id x193so26558295oix.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 09:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E7Oz+OAUDPzcoErJ5LrjgeRbjicJzQkLP3fhGNuFgqc=;
 b=dVPPVZHdsFuLVnFkMrORa4gA/eaYJ6iPt8ceenfYEwI73FAVpW9YkJ8/5Wm3Au7hEr
 fvWyQr/6BB9z9H9YDWR46LqrLyNdUQ+6kiNEhwyezWSfPcx1uIn3XInrOWi2QOOOiH0I
 HqksV1VnqQ/wkyDIyEp78mHK8dFixfTzUsQx4l53L830PISZPGMgR7zR/KvXy+CrRixL
 OXgIKDEpfzp7G0THjPRlMHFE5PBYOHQSbscDm5YkcWSzkXtmesmlMjXqrqxbv1CFUnPZ
 DmY3fF4PvuXJ1GQNtt1mPKVNyzLxTwPuzzeE08g6r4JPvhD0JiGpIoHe936jhq62JoiF
 xpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E7Oz+OAUDPzcoErJ5LrjgeRbjicJzQkLP3fhGNuFgqc=;
 b=UsSoAsXYqzShHvU6X6oGaOBalRMLPIol5mUQNpbZtWHa/nZXt5JoRd+0lY87ePIHri
 t36xVcksflSiVJ7QBiDKt5w/OGMorGRospehFyuIuK4ORpyWJ9wujZUAVIPX+pXkW79R
 nM9EXXsAB9+5glWnYjjsMc0HGG/aAj8IsuMLa3ZEJemQ7DcwejA3VcBWvzHCkTscGi6d
 TJomBWdNgL/Yf19+Kgpvyto8EPnIFUUUKzwKRTB/OA4sNqKgJl4UipoMhchuR5jD8/9f
 BFBQRnRYfYkOszfJT2e2oV/RXssy/k2KyyJFI27x8Hys094tAxaCp2hZD4nD/H1JpxG+
 ewHA==
X-Gm-Message-State: AOAM532YzpNwjFJjlQN3PPackvhH8e+y6EQnN275URPO3pwY5hS6c7uc
 nDdZp4IgrdVm9AyW7TJFcEFil0t3KhuJURihNB189Z6Z1AA=
X-Google-Smtp-Source: ABdhPJxCdwUU5AEjhEjKyYvW5Z3dZLxPGusPHNjSVUIUFWKpDwmjEoZshPQW3yrLe6MYUOFnPsbgwsI/ccSmRwbaZOw=
X-Received: by 2002:a05:6808:68f:: with SMTP id
 k15mr2142619oig.5.1643043869133; 
 Mon, 24 Jan 2022 09:04:29 -0800 (PST)
MIME-Version: 1.0
References: <87ee57c8fu.fsf@turner.link>
 <acd2fd5e-d622-948c-82ef-629a8030c9d8@leemhuis.info>
 <87a6ftk9qy.fsf@dmarc-none.turner.link> <87zgnp96a4.fsf@turner.link>
 <fc2b7593-db8f-091c-67a0-ae5ffce71700@leemhuis.info>
 <CADnq5_Nr5-FR2zP1ViVsD_ZMiW=UHC1wO8_HEGm26K_EG2KDoA@mail.gmail.com>
 <87czkk1pmt.fsf@dmarc-none.turner.link>
 <BYAPR12MB46140BE09E37244AE129C01A975C9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <87sftfqwlx.fsf@dmarc-none.turner.link>
In-Reply-To: <87sftfqwlx.fsf@dmarc-none.turner.link>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jan 2022 12:04:18 -0500
Message-ID: <CADnq5_P5RAJxKWCQBmJae8eWjJ5_wPG01uJYOpXMGsieWqUDvw@mail.gmail.com>
Subject: Re: [REGRESSION] Too-low frequency limit for AMD GPU
 PCI-passed-through to Windows VM
To: James Turner <linuxkernel.foss@dmarc-none.turner.link>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jan 22, 2022 at 4:38 PM James Turner
<linuxkernel.foss@dmarc-none.turner.link> wrote:
>
> Hi Lijo,
>
> > Could you provide the pp_dpm_* values in sysfs with and without the
> > patch? Also, could you try forcing PCIE to gen3 (through pp_dpm_pcie)
> > if it's not in gen3 when the issue happens?
>
> AFAICT, I can't access those values while the AMD GPU PCI devices are
> bound to `vfio-pci`. However, I can at least access the link speed and
> width elsewhere in sysfs. So, I gathered what information I could for
> two different cases:
>
> - With the PCI devices bound to `vfio-pci`. With this configuration, I
>   can start the VM, but the `pp_dpm_*` values are not available since
>   the devices are bound to `vfio-pci` instead of `amdgpu`.
>
> - Without the PCI devices bound to `vfio-pci` (i.e. after removing the
>   `vfio-pci.ids=...` kernel command line argument). With this
>   configuration, I can access the `pp_dpm_*` values, since the PCI
>   devices are bound to `amdgpu`. However, I cannot use the VM. If I try
>   to start the VM, the display (both the external monitors attached to
>   the AMD GPU and the built-in laptop display attached to the Intel
>   iGPU) completely freezes.
>
> The output shown below was identical for both the good commit:
> f1688bd69ec4 ("drm/amd/amdgpu:save psp ring wptr to avoid attack")
> and the commit which introduced the issue:
> f9b7f3703ff9 ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)")
>
> Note that the PCI link speed increased to 8.0 GT/s when the GPU was
> under heavy load for both versions, but the clock speeds of the GPU were
> different under load. (For the good commit, it was 1295 MHz; for the bad
> commit, it was 501 MHz.)
>

Are the ATIF and ATCS ACPI methods available in the guest VM?  They
are required for this platform to work correctly from a power
standpoint.  One thing that f9b7f3703ff9 did was to get those ACPI
methods executed on certain platforms where they had not been
previously due to a bug in the original implementation.  If the
windows driver doesn't interact with them, it could cause performance
issues.  It may have worked by accident before because the ACPI
interfaces may not have been called, leading the windows driver to
believe this was a standalone dGPU rather than one integrated into a
power/thermal limited platform.

Alex


>
> # With the PCI devices bound to `vfio-pci`
>
> ## Before starting the VM
>
> % ls /sys/module/amdgpu/drivers/pci:amdgpu
> module  bind  new_id  remove_id  uevent  unbind
>
> % find /sys/bus/pci/devices/0000:01:00.0/ -type f -name 'current_link*' -print -exec cat {} \;
> /sys/bus/pci/devices/0000:01:00.0/current_link_width
> 8
> /sys/bus/pci/devices/0000:01:00.0/current_link_speed
> 8.0 GT/s PCIe
>
> ## While running the VM, before placing the AMD GPU under heavy load
>
> % find /sys/bus/pci/devices/0000:01:00.0/ -type f -name 'current_link*' -print -exec cat {} \;
> /sys/bus/pci/devices/0000:01:00.0/current_link_width
> 8
> /sys/bus/pci/devices/0000:01:00.0/current_link_speed
> 2.5 GT/s PCIe
>
> ## While running the VM, with the AMD GPU under heavy load
>
> % find /sys/bus/pci/devices/0000:01:00.0/ -type f -name 'current_link*' -print -exec cat {} \;
> /sys/bus/pci/devices/0000:01:00.0/current_link_width
> 8
> /sys/bus/pci/devices/0000:01:00.0/current_link_speed
> 8.0 GT/s PCIe
>
> ## While running the VM, after stopping the heavy load on the AMD GPU
>
> % find /sys/bus/pci/devices/0000:01:00.0/ -type f -name 'current_link*' -print -exec cat {} \;
> /sys/bus/pci/devices/0000:01:00.0/current_link_width
> 8
> /sys/bus/pci/devices/0000:01:00.0/current_link_speed
> 2.5 GT/s PCIe
>
> ## After stopping the VM
>
> % find /sys/bus/pci/devices/0000:01:00.0/ -type f -name 'current_link*' -print -exec cat {} \;
> /sys/bus/pci/devices/0000:01:00.0/current_link_width
> 8
> /sys/bus/pci/devices/0000:01:00.0/current_link_speed
> 2.5 GT/s PCIe
>
>
> # Without the PCI devices bound to `vfio-pci`
>
> % ls /sys/module/amdgpu/drivers/pci:amdgpu
> 0000:01:00.0  module  bind  new_id  remove_id  uevent  unbind
>
> % for f in /sys/module/amdgpu/drivers/pci:amdgpu/*/pp_dpm_*; do echo "$f"; cat "$f"; echo; done
> /sys/module/amdgpu/drivers/pci:amdgpu/0000:01:00.0/pp_dpm_mclk
> 0: 300Mhz
> 1: 625Mhz
> 2: 1500Mhz *
>
> /sys/module/amdgpu/drivers/pci:amdgpu/0000:01:00.0/pp_dpm_pcie
> 0: 2.5GT/s, x8
> 1: 8.0GT/s, x16 *
>
> /sys/module/amdgpu/drivers/pci:amdgpu/0000:01:00.0/pp_dpm_sclk
> 0: 214Mhz
> 1: 501Mhz
> 2: 850Mhz
> 3: 1034Mhz
> 4: 1144Mhz
> 5: 1228Mhz
> 6: 1275Mhz
> 7: 1295Mhz *
>
> % find /sys/bus/pci/devices/0000:01:00.0/ -type f -name 'current_link*' -print -exec cat {} \;
> /sys/bus/pci/devices/0000:01:00.0/current_link_width
> 8
> /sys/bus/pci/devices/0000:01:00.0/current_link_speed
> 8.0 GT/s PCIe
>
>
> James

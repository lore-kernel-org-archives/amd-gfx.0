Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FD0E784A4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 07:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D9DF10E216;
	Mon,  2 Oct 2023 07:39:54 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE3E10E057
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 00:12:22 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6c644a1845cso1735240a34.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Oct 2023 17:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lucidpixels.com; s=google; t=1696205541; x=1696810341;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GFCHGpbpyraI/3FGZPNhIjojebHHdCoO8NPiTDHixqM=;
 b=ppClx5yMwaO9lYS0PJCfOSveJ6Dek718GErqYvq1k1cm5iEk+L7eAmFNs3RAXHZbil
 i1th/1W4MBfIBrvmM5JP+hh/16qvl4Ri/Sq+IaywD53rxNhGlhmkIIqHcVONj4+5+B08
 hx4XbehQjE5IYY0RpZ2u0N/UKpSTtA7cPJbC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696205541; x=1696810341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFCHGpbpyraI/3FGZPNhIjojebHHdCoO8NPiTDHixqM=;
 b=FYrZuYNvYUwck5jRvD3DAMGI12triQItX8Ur0VkDfevF3d2LZfx+qaINHkOmuLDdj5
 XCM4wDUULf9TTxsjXFJ+1m9fPpirwUUfwvk4VG/W6mWXIMGlTtUTDvWR//MrXtOZHSkG
 HudFsHiuvvKGcW0hfw+xpdBm38Xd0byHE4R5bBjuG1xaweZpqxvO8AkdmQ/KGmc/TKmm
 KoMjiEwPB6XqJzj0/zJ2q1sVuHw5T0QF8POh5WiCx8jfmsMeuSsFT1YOeyQ/KtBFuW0I
 lbkzuJ6q4P3Z0zYDKdaQ9kZajNlnWameVk3zdsaRFEy83ck/cpkxaSYs+95SozH2JD5C
 cLqw==
X-Gm-Message-State: AOJu0YydM9nHX/VwfI1WTyR3xzsV81A/S6x23Ra/Ftg6ELkimElPjwVp
 qsZIZUNgeAAiScgD2Fqw56XinWLyMxFuJZeofZ5D0Q==
X-Google-Smtp-Source: AGHT+IHGsZm62WWO4Snv2PQvtIfISUWnk/mWHvXfJC7YDU3eKhOk+Wj3mHp6dQoESefI2pcpUzsTPaPQQhevaW02ogM=
X-Received: by 2002:a05:6808:1495:b0:3ab:7f46:ecc5 with SMTP id
 e21-20020a056808149500b003ab7f46ecc5mr13517982oiw.35.1696205541085; Sun, 01
 Oct 2023 17:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com>
 <ZRoIGhMesKtmNkAM@debian.me>
In-Reply-To: <ZRoIGhMesKtmNkAM@debian.me>
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Sun, 1 Oct 2023 20:12:08 -0400
Message-ID: <CAO9zADyfaLRWB-0rdojnbFD6SUsqX+zb9JZSZUkgTC7VJN=c1A@mail.gmail.com>
Subject: Re: 6.5.5: UBSAN: radeon_atombios.c: index 1 is out of range for type
 'UCHAR [1]'
To: Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 02 Oct 2023 07:39:51 +0000
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> > ================================================================================
> > [Sun Oct  1 15:59:04 2023] UBSAN: array-index-out-of-bounds in
> > drivers/gpu/drm/radeon/radeon_atombios.c:2620:43
> > [Sun Oct  1 15:59:04 2023] index 1 is out of range for type 'UCHAR [1]'
> > [Sun Oct  1 15:59:04 2023] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G
> >             T  6.5.5 #13 55df8de52754ef95effc50a55e9206abdea304ac
> > [Sun Oct  1 15:59:04 2023] Hardware name: Supermicro X9SRL-F/X9SRL-F,
> > BIOS 3.3 11/13/2018
> > [Sun Oct  1 15:59:04 2023] Call Trace:
> > [Sun Oct  1 15:59:04 2023]  <TASK>
> > [Sun Oct  1 15:59:04 2023]  dump_stack_lvl+0x36/0x50
> > [Sun Oct  1 15:59:04 2023]  __ubsan_handle_out_of_bounds+0xc7/0x110
> > [Sun Oct  1 15:59:04 2023]  radeon_atombios_get_power_modes+0x87a/0x8f0
> > [Sun Oct  1 15:59:04 2023]  radeon_pm_init+0x13a/0x7e0
> > [Sun Oct  1 15:59:04 2023]  evergreen_init+0x13d/0x3d0
> > [Sun Oct  1 15:59:04 2023]  radeon_device_init+0x60a/0xbf0
> > [Sun Oct  1 15:59:04 2023]  radeon_driver_load_kms+0xb1/0x250
> > [Sun Oct  1 15:59:04 2023]  drm_dev_register+0xfc/0x250
> > [Sun Oct  1 15:59:04 2023]  radeon_pci_probe+0xd0/0x150
> > [Sun Oct  1 15:59:04 2023]  pci_device_probe+0x97/0x130
> > [Sun Oct  1 15:59:04 2023]  really_probe+0xbe/0x2f0
> > [Sun Oct  1 15:59:04 2023]  ? __pfx___driver_attach+0x10/0x10
> > [Sun Oct  1 15:59:04 2023]  __driver_probe_device+0x6e/0x120
> > [Sun Oct  1 15:59:04 2023]  driver_probe_device+0x1a/0x90
> > [Sun Oct  1 15:59:04 2023]  __driver_attach+0xd4/0x170
> > [Sun Oct  1 15:59:04 2023]  bus_for_each_dev+0x87/0xe0
> > [Sun Oct  1 15:59:04 2023]  bus_add_driver+0xf3/0x1f0
> > [Sun Oct  1 15:59:04 2023]  driver_register+0x58/0x120
> > [Sun Oct  1 15:59:04 2023]  ? __pfx_radeon_module_init+0x10/0x10
> > [Sun Oct  1 15:59:04 2023]  do_one_initcall+0x93/0x4a0
> > [Sun Oct  1 15:59:04 2023]  kernel_init_freeable+0x301/0x580
> > [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
> > [Sun Oct  1 15:59:04 2023]  kernel_init+0x15/0x1b0
> > [Sun Oct  1 15:59:04 2023]  ret_from_fork+0x2f/0x50
> > [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
> > [Sun Oct  1 15:59:04 2023]  ret_from_fork_asm+0x1b/0x30
> > [Sun Oct  1 15:59:04 2023]  </TASK>
> > [Sun Oct  1 15:59:04 2023]
> > ================================================================================
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: dpm initialized
> > [Sun Oct  1 15:59:04 2023] [drm] GART: num cpu pages 262144, num gpu
> > pages 262144
> > [Sun Oct  1 15:59:04 2023] [drm] enabling PCIE gen 2 link speeds,
> > disable with radeon.pcie_gen2=0
> > [Sun Oct  1 15:59:04 2023] [drm] PCIE GART of 1024M enabled (table at
> > 0x000000000014C000).
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: WB enabled
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 0
> > use gpu addr 0x0000000040000c00
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 3
> > use gpu addr 0x0000000040000c0c
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 5
> > use gpu addr 0x000000000005c418
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: MSI limited to 32-bit
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: using MSI.
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: irq initialized.
> >
>
> Please also open an issue on freedesktop tracker [1].
>
> Thanks.
>
> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues

Issue opened: https://gitlab.freedesktop.org/drm/amd/-/issues/2894

Regards,
Justin

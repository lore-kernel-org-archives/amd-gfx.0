Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CB0C67861
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Apr 2024 04:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491F010E20C;
	Tue,  9 Apr 2024 04:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TQCF36QT";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260CE10E20C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Apr 2024 04:23:18 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so4812591b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Apr 2024 21:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712636597; x=1713241397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmMw7a5O50tj9x9X/rTKi3+asqjaHKmEWJL4jpB0MIM=;
 b=TQCF36QT0fhHSUjmZz9aYOVpeThOmQXgg5aML7XBAWuQo9JKpHsS/LYjPzBU+HzPdY
 3T+pBXPQrbxDwwqqm3qNfv4Dkgyhx1rSdRSJ51OvpBgrBVuQfY/YxScrjbF4pWtQO/UI
 fH+PRR2m697Jdx3kcR46ibuWP1cFsputnkPfdxZ5ELznMsxFRkrHsaXVL1ppuoKknWyj
 /G3JCXSdURm+mzlnpXrjDPjehJ3yBSWxASwiDRYhKGZYDXHGw6MTosFaRk9wR8yGslbE
 spocrKVmcdWzCGwBlSO21/P/M0vFIF287uRpJ/pFolM2/FeDqY9qwXL/Dcy8mm4A4qUh
 4BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712636597; x=1713241397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmMw7a5O50tj9x9X/rTKi3+asqjaHKmEWJL4jpB0MIM=;
 b=Beve+7ApDsbGcH+bfXjKy1361KRtjBjzN/BE3ZwfthdllKbrbwhfNbVkXSi340apxe
 EcIzG9uPKbzoHtPkueiYEe0iDkdUFfnrgiq5FA6Hu6UqUnaIxMXRgPypkWr4UV78GBab
 WUO92Fd5HAoSSWNCmkRoiEnuywzprx/BA+RTAlKoyjx75c9GXd9tVwyWmvfuL5aUt394
 n203vz2AEnWeM2P9I3NDJVoaf5bgZRMpwfZ2lOF1BzlpMxDw9u66G4AxHRKZqBLe7huv
 6PzTT6NLAk54EeTQbyqE2Q4nIBO584UDPLWn2kw3J9V2DdN+914eBp2LDbR8CNPmNNIN
 vnPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Ube+prCaVAEKmJ3uh+0thhZGlC5Z+S4W6mmJfMZzAVh36yzf+otkSx31ObPKUDp3TjeisP7oX1sRW1dwhcerqod5gZvDpa8XXix/Hg==
X-Gm-Message-State: AOJu0YxQcemd4XeNjxlAcIBN5zz5iuVJTzkXPF+BdnQrtymjajQpfyl/
 rHFrtMUV7kc8isnbduioghRRD91cN/uHFVwzqRG5Tiltv6BgIHoc2PF+8xZs9hyZg46xd/XewHU
 NxGO9AH9gkHY/VwSfQ3O6pJxLUVk=
X-Google-Smtp-Source: AGHT+IErkFwGKO2kTAdhos7XepQZsquGNVc0/92UHzaKSlD+q8rpc3ijcmyr5W4VXK5Zf6zz4zb7gE9OjGY/Z/6i8K0=
X-Received: by 2002:a05:6a20:5603:b0:1a7:9ce4:bd1d with SMTP id
 ir3-20020a056a20560300b001a79ce4bd1dmr1604314pzc.34.1712636597462; Mon, 08
 Apr 2024 21:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com>
 <ZRoIGhMesKtmNkAM@debian.me>
 <CAO9zADyfaLRWB-0rdojnbFD6SUsqX+zb9JZSZUkgTC7VJN=c1A@mail.gmail.com>
 <a619df03-e0cb-48f7-840a-970b7a6f6037@quicinc.com>
 <CA212FEF-E0BB-483C-86CC-6986D4FBE168@kernel.org>
In-Reply-To: <CA212FEF-E0BB-483C-86CC-6986D4FBE168@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Apr 2024 00:23:05 -0400
Message-ID: <CADnq5_PKoX9G8jD=m1WnX3nxd_+GL_xi03_Dgq8HK6Diw3=JsQ@mail.gmail.com>
Subject: Re: 6.5.5: UBSAN: radeon_atombios.c: index 1 is out of range for type
 'UCHAR [1]'
To: Kees Cook <kees@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Justin Piszcz <jpiszcz@lucidpixels.com>, 
 Bagas Sanjaya <bagasdotme@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>, 
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Kees Cook <keescook@chromium.org>
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

On Mon, Apr 8, 2024 at 9:45=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On April 8, 2024 5:45:29 PM PDT, Jeff Johnson <quic_jjohnson@quicinc.com>=
 wrote:
> >On 10/1/23 17:12, Justin Piszcz wrote:
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> [Sun Oct  1 15:59:04 2023] UBSAN: array-index-out-of-bounds in
> >>>> drivers/gpu/drm/radeon/radeon_atombios.c:2620:43
> >>>> [Sun Oct  1 15:59:04 2023] index 1 is out of range for type 'UCHAR [=
1]'
> >>>> [Sun Oct  1 15:59:04 2023] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G
> >>>>              T  6.5.5 #13 55df8de52754ef95effc50a55e9206abdea304ac
> >>>> [Sun Oct  1 15:59:04 2023] Hardware name: Supermicro X9SRL-F/X9SRL-F=
,
> >>>> BIOS 3.3 11/13/2018
> >>>> [Sun Oct  1 15:59:04 2023] Call Trace:
> >>>> [Sun Oct  1 15:59:04 2023]  <TASK>
> >>>> [Sun Oct  1 15:59:04 2023]  dump_stack_lvl+0x36/0x50
> >>>> [Sun Oct  1 15:59:04 2023]  __ubsan_handle_out_of_bounds+0xc7/0x110
> >>>> [Sun Oct  1 15:59:04 2023]  radeon_atombios_get_power_modes+0x87a/0x=
8f0
> >>>> [Sun Oct  1 15:59:04 2023]  radeon_pm_init+0x13a/0x7e0
> >>>> [Sun Oct  1 15:59:04 2023]  evergreen_init+0x13d/0x3d0
> >>>> [Sun Oct  1 15:59:04 2023]  radeon_device_init+0x60a/0xbf0
> >>>> [Sun Oct  1 15:59:04 2023]  radeon_driver_load_kms+0xb1/0x250
> >>>> [Sun Oct  1 15:59:04 2023]  drm_dev_register+0xfc/0x250
> >>>> [Sun Oct  1 15:59:04 2023]  radeon_pci_probe+0xd0/0x150
> >>>> [Sun Oct  1 15:59:04 2023]  pci_device_probe+0x97/0x130
> >>>> [Sun Oct  1 15:59:04 2023]  really_probe+0xbe/0x2f0
> >>>> [Sun Oct  1 15:59:04 2023]  ? __pfx___driver_attach+0x10/0x10
> >>>> [Sun Oct  1 15:59:04 2023]  __driver_probe_device+0x6e/0x120
> >>>> [Sun Oct  1 15:59:04 2023]  driver_probe_device+0x1a/0x90
> >>>> [Sun Oct  1 15:59:04 2023]  __driver_attach+0xd4/0x170
> >>>> [Sun Oct  1 15:59:04 2023]  bus_for_each_dev+0x87/0xe0
> >>>> [Sun Oct  1 15:59:04 2023]  bus_add_driver+0xf3/0x1f0
> >>>> [Sun Oct  1 15:59:04 2023]  driver_register+0x58/0x120
> >>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_radeon_module_init+0x10/0x10
> >>>> [Sun Oct  1 15:59:04 2023]  do_one_initcall+0x93/0x4a0
> >>>> [Sun Oct  1 15:59:04 2023]  kernel_init_freeable+0x301/0x580
> >>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
> >>>> [Sun Oct  1 15:59:04 2023]  kernel_init+0x15/0x1b0
> >>>> [Sun Oct  1 15:59:04 2023]  ret_from_fork+0x2f/0x50
> >>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
> >>>> [Sun Oct  1 15:59:04 2023]  ret_from_fork_asm+0x1b/0x30
> >>>> [Sun Oct  1 15:59:04 2023]  </TASK>
> >>>> [Sun Oct  1 15:59:04 2023]
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> [Sun Oct  1 15:59:04 2023] [drm] radeon: dpm initialized
> >>>> [Sun Oct  1 15:59:04 2023] [drm] GART: num cpu pages 262144, num gpu
> >>>> pages 262144
> >>>> [Sun Oct  1 15:59:04 2023] [drm] enabling PCIE gen 2 link speeds,
> >>>> disable with radeon.pcie_gen2=3D0
> >>>> [Sun Oct  1 15:59:04 2023] [drm] PCIE GART of 1024M enabled (table a=
t
> >>>> 0x000000000014C000).
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: WB enabled
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring=
 0
> >>>> use gpu addr 0x0000000040000c00
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring=
 3
> >>>> use gpu addr 0x0000000040000c0c
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring=
 5
> >>>> use gpu addr 0x000000000005c418
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: MSI limited =
to 32-bit
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: using MSI.
> >>>> [Sun Oct  1 15:59:04 2023] [drm] radeon: irq initialized.
> >>>>
> >>>
> >>> Please also open an issue on freedesktop tracker [1].
> >>>
> >>> Thanks.
> >>>
> >>> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues
> >>
> >> Issue opened: https://gitlab.freedesktop.org/drm/amd/-/issues/2894
> >>
> >> Regards,
> >> Justin
> >
> >+Kees since I've worked with him on several of these flexible array issu=
es.
> >
> >I just happened to look at kernel logs today for my ath1*k driver mainte=
nance and see the subject issue is present on my device, running 6.9.0-rc1.=
 The freedesktop issue tracker says the issue is closed, but any fix has no=
t landed in the upstream kernel. Is there a -next patch somewhere?
> >
> >[   12.105270] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/radeo=
n/radeon_atombios.c:2718:34
> >[   12.105272] index 48 is out of range for type 'UCHAR [1]'
> >[
> >
> >If there isn't really an upstream fix, I can probably supply one.
>
> I would expect this to have fixed it:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/gpu/drm/radeon/pptable.h?id=3Dc63079c61177ba1b17fa05c6875699a36924=
fe39
>
> If not, there must be something else happening?

This patch should silence it I think:
https://patchwork.freedesktop.org/patch/588305/

Alex

>
> -Kees
>
> --
> Kees Cook

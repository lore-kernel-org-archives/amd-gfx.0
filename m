Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F6DE784B5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 14:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC1010E2C3;
	Mon,  2 Oct 2023 14:21:02 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B87910E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 14:20:54 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1dc6195bf93so9196593fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Oct 2023 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696256453; x=1696861253; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUOlzv+UFv92EjRw2MpN+xguuKwzgQuyeoPrL+fOaqA=;
 b=QHcDxCy2e3v+9hVy63S7ZdfTD7fKfRXx344Tvl7CSRr+OjCmZKqqck4oJn9xpHxLJ6
 ZdwAqlaAi0ZHZ7UsXifMuXGDTEZZeEddhxB35PFnZtGCixcQEiQoGF/cmeLl+ZtSVDDA
 5UNl8ArOtkqhM7JaGBeK2F2H+RApS5Qhpcli6faBDH4pCiDG+nGFe9DuqmfCfW0HKEhL
 Iy3SjcXdSyGVhm195aZvDgzwye/HnN8+5Qn4+lrP7JXdOp9dPVj2gkNmWCRCIFdjPTzj
 u2vHrR7OVsKqq85EweGwfGPoqOkR06dVbE2GPPAvpdhpqMlTBFzj4RJyAMKKEP8B7EGD
 m9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696256453; x=1696861253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUOlzv+UFv92EjRw2MpN+xguuKwzgQuyeoPrL+fOaqA=;
 b=T/oMRwcajsUEJmIk8Vx4XQBWZKqIlxENFidXoiwP8geGvpzjjyK6gCOaX8fAm14V1T
 PkvesFd+sQHLKoiW0I2fVPdEbfY38MwZlAdURCGvvg3tTyXExzs0ow6S4A/8rSqSjtfd
 Wm+WswMh0tPP7P3y5+vkiTlznLtALpc8cdNMBH9ompcH7eMTUQRunrw8AmEC66kNZM0P
 CIYMJ5pKzgpHmSwMYgqMTLo1Sjo9DKridAxspR4SHYPyK1Ux5ubGqmicAcp70PgDi8cK
 lz57mxHO+qkCBWwGOpEs4GyTgBnrDmbZZgoyV3nLR5Yj9HEhPSkZ5XDWFFDHs4Z3xL2y
 /OdA==
X-Gm-Message-State: AOJu0Yxy9oP8UYb+FWd/ygZpWUP/Tph0UhxIrFaA6KYKvGLXCgmDw3sR
 KI9hIvocNGJx8tBf6apDJ03LFTM1CMKGrtIPCTk=
X-Google-Smtp-Source: AGHT+IH/31AOMMoNa1PznWx4AqPqP41PY3lJbTGBZgZhfJX8r58BHRpOT8Xbm/9DYz6e040gDuQnL+2xiLkGQkes3SI=
X-Received: by 2002:a05:6870:a454:b0:1dc:8191:8aa with SMTP id
 n20-20020a056870a45400b001dc819108aamr13317859oal.44.1696256453364; Mon, 02
 Oct 2023 07:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com>
 <ZRoIGhMesKtmNkAM@debian.me>
In-Reply-To: <ZRoIGhMesKtmNkAM@debian.me>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Oct 2023 10:20:42 -0400
Message-ID: <CADnq5_Nxtuu-cO+5DNaF+anD9_7J9Ahpr3+4JGfYEmzdM1Kw_w@mail.gmail.com>
Subject: Re: 6.5.5: UBSAN: radeon_atombios.c: index 1 is out of range for type
 'UCHAR [1]'
To: Bagas Sanjaya <bagasdotme@gmail.com>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
 Justin Piszcz <jpiszcz@lucidpixels.com>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 2, 2023 at 3:40=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> On Sun, Oct 01, 2023 at 07:05:11PM -0400, Justin Piszcz wrote:
> > Hello,
> >
> > Kernel: 6.5.5
> > Arch: x86_64
> > Distribution: Debian testing
> >
> > Recently, I enabled UBSAN and noticed the following at boot time with
> > an older AMD graphics card, is this considered normal when using the
> > AMD firmware-linux-nonfree package?

This is actually a variable sized array we are indexing:

typedef struct _ATOM_PPLIB_STATE
{
    UCHAR ucNonClockStateIndex;
    UCHAR ucClockStateIndices[1]; // variable-sized
} ATOM_PPLIB_STATE;

So it's a false positive.  I guess it should be converted to variable
sized array changes others have been working on.

Alex

> >
> > [ .. ]
> > [Sun Oct  1 15:59:04 2023] ACPI: bus type drm_connector registered
> > [Sun Oct  1 15:59:04 2023] [drm] radeon kernel modesetting enabled.
> > [Sun Oct  1 15:59:04 2023] [drm] initializing kernel modesetting
> > (CEDAR 0x1002:0x68E1 0x1787:0x3000 0x00).
> > [Sun Oct  1 15:59:04 2023] ATOM BIOS: PARK
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: VRAM: 1024M
> > 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: GTT: 1024M
> > 0x0000000040000000 - 0x000000007FFFFFFF
> > [Sun Oct  1 15:59:04 2023] [drm] Detected VRAM RAM=3D1024M, BAR=3D256M
> > [Sun Oct  1 15:59:04 2023] [drm] RAM width 64bits DDR
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: 1024M of VRAM memory ready
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: 1024M of GTT memory ready.
> > [Sun Oct  1 15:59:04 2023] [drm] Loading CEDAR Microcode
> > [Sun Oct  1 15:59:04 2023] [drm] Internal thermal controller with fan c=
ontrol
> > [Sun Oct  1 15:59:04 2023]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
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
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: dpm initialized
> > [Sun Oct  1 15:59:04 2023] [drm] GART: num cpu pages 262144, num gpu
> > pages 262144
> > [Sun Oct  1 15:59:04 2023] [drm] enabling PCIE gen 2 link speeds,
> > disable with radeon.pcie_gen2=3D0
> > [Sun Oct  1 15:59:04 2023] [drm] PCIE GART of 1024M enabled (table at
> > 0x000000000014C000).
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: WB enabled
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 0
> > use gpu addr 0x0000000040000c00
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 3
> > use gpu addr 0x0000000040000c0c
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 5
> > use gpu addr 0x000000000005c418
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: MSI limited to =
32-bit
> > [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: using MSI.
> > [Sun Oct  1 15:59:04 2023] [drm] radeon: irq initialized.
> >
>
> Please also open an issue on freedesktop tracker [1].
>
> Thanks.
>
> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues
>
> --
> An old man doll... just what I always wanted! - Clara

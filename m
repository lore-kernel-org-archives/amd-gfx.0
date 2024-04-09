Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBD5C67861
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Apr 2024 01:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E82A112A09;
	Tue,  9 Apr 2024 01:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BYq0BEu5";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BBD6112A09
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Apr 2024 01:45:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B085DCE1B9C;
 Tue,  9 Apr 2024 01:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5305C433C7;
 Tue,  9 Apr 2024 01:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712627124;
 bh=z2eCoScpgsl7Ir10XM1QcJSlIyoPYZVQM9kO+cbyA4c=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=BYq0BEu52Xr7p+duyjGWBqOJ8lQxU+kvhZP8g8BBzCi1/cdfwn/DUHnGAL4n7FM7r
 MXD8jY2HLdZ2SiA2XuFQEhKTXp4Cuwq3DTrqoAopfzwn1RS4vMRp9hXwKgvhFKlvl6
 /OMOodkL377GbnigzmGjgDOT1ByAPWU6oMeEaqnHKEJuI7O1fwaNmw+Rpn6ovdjgmh
 XFzatHYbuzIavNJWEJIq7Wo95UcR7KeIC94m6zRA6bs/ebslJ/oX0nNvjTqUkWEhXO
 3GODVwmUFrtZ4O3nqPdBoC51rwfzCufRzKeUzdN9BZ0Y0j7/chak6onuw18zf6eWap
 1Safc6T57lgRA==
Date: Mon, 08 Apr 2024 18:45:19 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Justin Piszcz <jpiszcz@lucidpixels.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>
CC: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 =?ISO-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 Kees Cook <keescook@chromium.org>
Subject: =?US-ASCII?Q?Re=3A_6=2E5=2E5=3A_UBSAN=3A_radeon=5Fatombios=2Ec=3A_ind?=
 =?US-ASCII?Q?ex_1_is_out_of_range_for_type_=27UCHAR_=5B1=5D=27?=
User-Agent: K-9 Mail for Android
In-Reply-To: <a619df03-e0cb-48f7-840a-970b7a6f6037@quicinc.com>
References: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com>
 <ZRoIGhMesKtmNkAM@debian.me>
 <CAO9zADyfaLRWB-0rdojnbFD6SUsqX+zb9JZSZUkgTC7VJN=c1A@mail.gmail.com>
 <a619df03-e0cb-48f7-840a-970b7a6f6037@quicinc.com>
Message-ID: <CA212FEF-E0BB-483C-86CC-6986D4FBE168@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



On April 8, 2024 5:45:29 PM PDT, Jeff Johnson <quic_jjohnson@quicinc=2Ecom=
> wrote:
>On 10/1/23 17:12, Justin Piszcz wrote:
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>> [Sun Oct  1 15:59:04 2023] UBSAN: array-index-out-of-bounds in
>>>> drivers/gpu/drm/radeon/radeon_atombios=2Ec:2620:43
>>>> [Sun Oct  1 15:59:04 2023] index 1 is out of range for type 'UCHAR [1=
]'
>>>> [Sun Oct  1 15:59:04 2023] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G
>>>>              T  6=2E5=2E5 #13 55df8de52754ef95effc50a55e9206abdea304a=
c
>>>> [Sun Oct  1 15:59:04 2023] Hardware name: Supermicro X9SRL-F/X9SRL-F,
>>>> BIOS 3=2E3 11/13/2018
>>>> [Sun Oct  1 15:59:04 2023] Call Trace:
>>>> [Sun Oct  1 15:59:04 2023]  <TASK>
>>>> [Sun Oct  1 15:59:04 2023]  dump_stack_lvl+0x36/0x50
>>>> [Sun Oct  1 15:59:04 2023]  __ubsan_handle_out_of_bounds+0xc7/0x110
>>>> [Sun Oct  1 15:59:04 2023]  radeon_atombios_get_power_modes+0x87a/0x8=
f0
>>>> [Sun Oct  1 15:59:04 2023]  radeon_pm_init+0x13a/0x7e0
>>>> [Sun Oct  1 15:59:04 2023]  evergreen_init+0x13d/0x3d0
>>>> [Sun Oct  1 15:59:04 2023]  radeon_device_init+0x60a/0xbf0
>>>> [Sun Oct  1 15:59:04 2023]  radeon_driver_load_kms+0xb1/0x250
>>>> [Sun Oct  1 15:59:04 2023]  drm_dev_register+0xfc/0x250
>>>> [Sun Oct  1 15:59:04 2023]  radeon_pci_probe+0xd0/0x150
>>>> [Sun Oct  1 15:59:04 2023]  pci_device_probe+0x97/0x130
>>>> [Sun Oct  1 15:59:04 2023]  really_probe+0xbe/0x2f0
>>>> [Sun Oct  1 15:59:04 2023]  ? __pfx___driver_attach+0x10/0x10
>>>> [Sun Oct  1 15:59:04 2023]  __driver_probe_device+0x6e/0x120
>>>> [Sun Oct  1 15:59:04 2023]  driver_probe_device+0x1a/0x90
>>>> [Sun Oct  1 15:59:04 2023]  __driver_attach+0xd4/0x170
>>>> [Sun Oct  1 15:59:04 2023]  bus_for_each_dev+0x87/0xe0
>>>> [Sun Oct  1 15:59:04 2023]  bus_add_driver+0xf3/0x1f0
>>>> [Sun Oct  1 15:59:04 2023]  driver_register+0x58/0x120
>>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_radeon_module_init+0x10/0x10
>>>> [Sun Oct  1 15:59:04 2023]  do_one_initcall+0x93/0x4a0
>>>> [Sun Oct  1 15:59:04 2023]  kernel_init_freeable+0x301/0x580
>>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
>>>> [Sun Oct  1 15:59:04 2023]  kernel_init+0x15/0x1b0
>>>> [Sun Oct  1 15:59:04 2023]  ret_from_fork+0x2f/0x50
>>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
>>>> [Sun Oct  1 15:59:04 2023]  ret_from_fork_asm+0x1b/0x30
>>>> [Sun Oct  1 15:59:04 2023]  </TASK>
>>>> [Sun Oct  1 15:59:04 2023]
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>> [Sun Oct  1 15:59:04 2023] [drm] radeon: dpm initialized
>>>> [Sun Oct  1 15:59:04 2023] [drm] GART: num cpu pages 262144, num gpu
>>>> pages 262144
>>>> [Sun Oct  1 15:59:04 2023] [drm] enabling PCIE gen 2 link speeds,
>>>> disable with radeon=2Epcie_gen2=3D0
>>>> [Sun Oct  1 15:59:04 2023] [drm] PCIE GART of 1024M enabled (table at
>>>> 0x000000000014C000)=2E
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: WB enabled
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: fence driver on rin=
g 0
>>>> use gpu addr 0x0000000040000c00
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: fence driver on rin=
g 3
>>>> use gpu addr 0x0000000040000c0c
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: fence driver on rin=
g 5
>>>> use gpu addr 0x000000000005c418
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: radeon: MSI limited=
 to 32-bit
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: radeon: using MSI=
=2E
>>>> [Sun Oct  1 15:59:04 2023] [drm] radeon: irq initialized=2E
>>>>=20
>>>=20
>>> Please also open an issue on freedesktop tracker [1]=2E
>>>=20
>>> Thanks=2E
>>>=20
>>> [1]: https://gitlab=2Efreedesktop=2Eorg/drm/amd/-/issues
>>=20
>> Issue opened: https://gitlab=2Efreedesktop=2Eorg/drm/amd/-/issues/2894
>>=20
>> Regards,
>> Justin
>
>+Kees since I've worked with him on several of these flexible array issue=
s=2E
>
>I just happened to look at kernel logs today for my ath1*k driver mainten=
ance and see the subject issue is present on my device, running 6=2E9=2E0-r=
c1=2E The freedesktop issue tracker says the issue is closed, but any fix h=
as not landed in the upstream kernel=2E Is there a -next patch somewhere?
>
>[   12=2E105270] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/rade=
on/radeon_atombios=2Ec:2718:34
>[   12=2E105272] index 48 is out of range for type 'UCHAR [1]'
>[
>
>If there isn't really an upstream fix, I can probably supply one=2E

I would expect this to have fixed it:
https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/c=
ommit/drivers/gpu/drm/radeon/pptable=2Eh?id=3Dc63079c61177ba1b17fa05c687569=
9a36924fe39

If not, there must be something else happening?

-Kees

--=20
Kees Cook

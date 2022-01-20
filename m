Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190BCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 19:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB4510E89D;
	Thu, 20 Jan 2022 19:09:47 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA8910E4D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 11:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1642677348;
 bh=BalRvSiyJ3LpQ3wNOTb6rjMlvQUdefxQuTJXZmIZZ78=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=g3wMzDIs4V+ngXA/wajRcMEPKYS1B/I59xyGnbq0s1WQ/MmbGACwlZoLCBgvEOKDI
 6XRiESA1dTaGTxxCBOTG/dumr7cYB75zj2H/JBAZQ/7Je6Wc7guqzmPiihmH9Dh3mN
 dMUElcWppAD9MgK7Trjffnz3mooPSTbhif8yMXZ0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.122] ([88.152.98.65]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCE0-1mZFrH3lrE-00bsrv; Thu, 20
 Jan 2022 12:15:48 +0100
Message-ID: <30442368f3e0031dab58d77c57e4daf917b0b436.camel@web.de>
Subject: Re: amd-staging-drm-next breaks suspend
From: Bert Karwatzki <spasswolf@web.de>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Date: Thu, 20 Jan 2022 12:15:46 +0100
In-Reply-To: <DM6PR12MB31637A906C7E520B358C8242855A9@DM6PR12MB3163.namprd12.prod.outlook.com>
References: <2d7fe1c0ddde50a1836b49dff8a02decdfcbe00d.camel@web.de>
 <BL1PR12MB515792BB2C4609F91269E3AFE2599@BL1PR12MB5157.namprd12.prod.outlook.com>
 <904d0552-20b0-2e11-c061-4d9d20bca374@amd.com>
 <75d1eefa7cf24d1751532b19841625be010cc015.camel@web.de>
 <314494939bcf185110d6a468637b08891138fba5.camel@web.de>
 <CADnq5_Nv9aChRhSBk3snMZ2ueU0fAAfYa_a_tc5gAy49dRRR_w@mail.gmail.com>
 <9da08e91cf313da76d4c4d8e9221b929e9e5247d.camel@web.de>
 <DM6PR12MB31637A906C7E520B358C8242855A9@DM6PR12MB3163.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OKB/AMj4tdUl2oiIJLm1IbiaHV0gENKTPuGntPXuFW6g0ObnmSJ
 rTDQ88qjo+5BG1Ji9UWHZLKpcAqsUnBMjE9z0Xep+iRgRRXyKKVrpHpsKGi6FsMNA03ixM4
 VhS3u05KFNu0v1wx5iL+cLAyTBxY6kngCaoLZ0kBKh5dx12yna9Ecw+EAbFPPzyUDqCS0Bk
 xV239McpjURlyx9iaRlVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eN6saPK49Q0=:aUsVZdvLDSeBNWIe57dlOS
 vA9g30FOdGtUy/triwSNtWl7WpmGM7tiyFGkjSm1wZjxrYGVXtzOtAMJwRF4+rtcQX1VrICzS
 QDmBI/shZhrRGlaqJk4kGQN8M7/bymH83vL3vKiJg2UZWzNgCckbfw60E5vhKw+yqdF2SfhJy
 fKHgaFTm2UyFwrMntTJVlM0Zr5+mlm4we1fSl3mjh2awEThQtD+cgoLa3Y3UWYZE7qPE0oPje
 Z7bmAJfGXmHVPbcBo7TLBl27rJqTIw/DObnup9hKBUBYi7TgG0KmD1ePcgCQhVbmm6RcMHuac
 NB51Bb9pzd5hqKCqfKIqDQuGEaTBZvIirJWKZ//80mdlR/YAPrfPGvcEjyJ5cNeHoUCNQAlAa
 alBr9T9uTrNcQkLWzIfr912wbpU+y0a8PFsrgCoLgxqfAktqSP/vrRxTGF5921MQWVp/T4/Qx
 1KnXKpGXoR9E1gQOPIPpRNwKV9ezTF3ot+ZIwXWdDXGZ8stBSGFmjOjQ2NGHX5u8ryr02ityt
 eLuv7KVtGKiQOfpn4v2NRQag3J5sr+Jus1xSERwHdZDEu9pvia1sgNMkLgl5nT8WmivZqgkgl
 d3lUJK4QdholZx6hkNXek07R1fex/vRMaFc1YsC61+IQqNSPyAlSPjlDh7duNVUbzIxByVKQj
 rFNWlVlCjPhn+jA46kRv/+L0Qrso1lySzdlYQngaHSg3QcnELJT5cXTS38AwWPUlB25G5wp2l
 zN4ttgLD5veefiBIiTAnShwdwqvQ5Q5CAXHo1zR84CGxi/cR1xvoLqJ8VFsN4/nE3SmZnSt6f
 ydYMGr/CEv8fcvWgzZpsGtwqUXiW5RPba2Zc2Pj1FXxZ2v81N93Dp+Zqev0v9o+noWyZKQ7zY
 6M/jtoystyR9oEAJ3rZ/j51Pp5IE3rn3xnKV7g3N6Te+fY0IkKgKRT+KgzZNg6KqVrYrtbLpS
 kAE+FgJmox2VE2P/fWy0Kcu9xrtYG404nz4gwAy26IKgh1Ac7qUGvYKLlD66gExup3bvK9E+q
 vR9QCk9QDq5ob8RD8cStBZorjdnmQoXKMMXxl2hLiGpb2+8ANSt+EAqqu+oCquGbQWw6LpbwQ
 QJ0KxJBVKBeFNs=
X-Mailman-Approved-At: Thu, 20 Jan 2022 19:09:46 +0000
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
Cc: Chris Hixon <linux-kernel-bugs@hixontech.com>, "Zhuo, Qingqing
 \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Scott Bruce <smbruce@gmail.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tested amd-staging-drm-next (HEAD
e5c18a35031963eb22bfabf84cce3545da56a8ee) and suspend/resume works
despite the warnings. So the amdgpu_gart_bind warning did not cause
problems.

Am Donnerstag, dem 20.01.2022 um 01:52 +0000 schrieb Kim, Jonathan:
> [Public]
>
> This should fix the issue by getting rid of the unneeded flag check
> during gart bind:
> https://patchwork.freedesktop.org/patch/469907/
>
> Thanks,
>
> Jon
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Bert
> > Karwatzki
> > Sent: January 19, 2022 8:12 PM
> > To: Alex Deucher <alexdeucher@gmail.com>
> > Cc: Chris Hixon <linux-kernel-bugs@hixontech.com>; Zhuo, Qingqing
> > (Lillian) <Qingqing.Zhuo@amd.com>; Das, Nirmoy
> > <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org; Scott Bruce
> > <smbruce@gmail.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Kazlauskas, Nicholas
> > <Nicholas.Kazlauskas@amd.com>
> > Subject: Re: amd-staging-drm-next breaks suspend
> >
> > [CAUTION: External Email]
> >
> > Unfortunately this does not work either:
> >
> > [=C2=A0=C2=A0=C2=A0 0.859998] ------------[ cut here ]------------
> > [=C2=A0=C2=A0=C2=A0 0.859998] trying to bind memory to uninitialized G=
ART !
> > [=C2=A0=C2=A0=C2=A0 0.860003] WARNING: CPU: 13 PID: 235 at
> > drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:254
> > amdgpu_gart_bind+0x29/0x40 [amdgpu]
> > [=C2=A0=C2=A0=C2=A0 0.860099] Modules linked in: amdgpu(+) drm_ttm_hel=
per ttm
> > gpu_sched i2c_algo_bit drm_kms_helper syscopyarea hid_sensor_hub
> > sysfillrect mfd_core sysimgblt hid_generic fb_sys_fops cec xhci_pci
> > xhci_hcd nvme drm r8169 nvme_core psmouse crc32c_intel realtek
> > amd_sfh usbcore i2c_hid_acpi mdio_devres t10_pi crc_t10dif i2c_hid
> > i2c_piix4 crct10dif_generic libphy crct10dif_common hid backlight
> > i2c_designware_platform i2c_designware_core
> > [=C2=A0=C2=A0=C2=A0 0.860113] CPU: 13 PID: 235 Comm: systemd-udevd Not=
 tainted
> > 5.13.0+
> > #15
> > [=C2=A0=C2=A0=C2=A0 0.860115] Hardware name: Micro-Star International =
Co., Ltd.
> > Alpha
> > 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
> > [=C2=A0=C2=A0=C2=A0 0.860116] RIP: 0010:amdgpu_gart_bind+0x29/0x40 [am=
dgpu]
> > [=C2=A0=C2=A0=C2=A0 0.860210] Code: 00 80 bf 34 25 00 00 00 74 14 4c 8=
b 8f 20 25
> > 00 00
> > 4d 85 c9 74 05 e9 16 ff ff ff 31 c0 c3 48 c7 c7 08 06 7d c0 e8 8e
> > cc 31
> > e2 <0f> 0b b8 ea ff ff ff c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> > 40
> > [=C2=A0=C2=A0=C2=A0 0.860212] RSP: 0018:ffffbb9e80b6f968 EFLAGS: 00010=
286
> > [=C2=A0=C2=A0=C2=A0 0.860213] RAX: 0000000000000000 RBX: 0000000000000=
067 RCX:
> > ffffffffa3080968
> > [=C2=A0=C2=A0=C2=A0 0.860214] RDX: 0000000000000000 RSI: 00000000ffffe=
fff RDI:
> > ffffffffa3028960
> > [=C2=A0=C2=A0=C2=A0 0.860215] RBP: ffff947c91e49a80 R08: 0000000000000=
000 R09:
> > ffffbb9e80b6f798
> > [=C2=A0=C2=A0=C2=A0 0.860215] R10: ffffbb9e80b6f790 R11: ffffffffa3098=
9a8 R12:
> > 0000000000000000
> > [=C2=A0=C2=A0=C2=A0 0.860216] R13: ffff947c8a740000 R14: ffff947c8a740=
000 R15:
> > 0000000000000000
> > [=C2=A0=C2=A0=C2=A0 0.860216] FS:=C2=A0 00007f60a3c918c0(0000)
> > GS:ffff947f5e940000(0000)
> > knlGS:0000000000000000
> > [=C2=A0=C2=A0=C2=A0 0.860217] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
> > [=C2=A0=C2=A0=C2=A0 0.860218] CR2: 00007f60a4213480 CR3: 0000000135ee2=
000 CR4:
> > 0000000000550ee0
> > [=C2=A0=C2=A0=C2=A0 0.860218] PKRU: 55555554
> > [=C2=A0=C2=A0=C2=A0 0.860219] Call Trace:
> > [=C2=A0=C2=A0=C2=A0 0.860221]=C2=A0 amdgpu_ttm_gart_bind+0x74/0xc0 [am=
dgpu]
> > [=C2=A0=C2=A0=C2=A0 0.860305]=C2=A0 amdgpu_ttm_alloc_gart+0x13e/0x190 =
[amdgpu]
> > [=C2=A0=C2=A0=C2=A0 0.860385]=C2=A0 amdgpu_bo_create_reserved.part.0+0=
xf3/0x1b0
> > [amdgpu]
> > [=C2=A0=C2=A0=C2=A0 0.860465]=C2=A0 ? amdgpu_ttm_debugfs_init+0x110/0x=
110 [amdgpu]
> > [=C2=A0=C2=A0=C2=A0 0.860554]=C2=A0 amdgpu_bo_create_kernel+0x36/0xa0 =
[amdgpu]
> > [=C2=A0=C2=A0=C2=A0 0.860641]=C2=A0 amdgpu_ttm_init.cold+0x167/0x181 [=
amdgpu]
> > [=C2=A0=C2=A0=C2=A0 0.860784]=C2=A0 gmc_v10_0_sw_init+0x2d7/0x430 [amd=
gpu]
> > [=C2=A0=C2=A0=C2=A0 0.860889]=C2=A0 amdgpu_device_init.cold+0x147f/0x1=
ad7 [amdgpu]
> > [=C2=A0=C2=A0=C2=A0 0.861007]=C2=A0 ? acpi_ns_get_node+0x4a/0x55
> > [=C2=A0=C2=A0=C2=A0 0.861011]=C2=A0 ? acpi_get_handle+0x89/0xb2
> > [=C2=A0=C2=A0=C2=A0 0.861012]=C2=A0 amdgpu_driver_load_kms+0x55/0x290 =
[amdgpu]
> > [=C2=A0=C2=A0=C2=A0 0.861098]=C2=A0 amdgpu_pci_probe+0x181/0x250 [amdg=
pu]
> > [=C2=A0=C2=A0=C2=A0 0.861188]=C2=A0 pci_device_probe+0xcd/0x140
> > [=C2=A0=C2=A0=C2=A0 0.861191]=C2=A0 really_probe+0xed/0x460
> > [=C2=A0=C2=A0=C2=A0 0.861193]=C2=A0 driver_probe_device+0xe3/0x150
> > [=C2=A0=C2=A0=C2=A0 0.861195]=C2=A0 device_driver_attach+0x9c/0xb0
> > [=C2=A0=C2=A0=C2=A0 0.861196]=C2=A0 __driver_attach+0x8a/0x150
> > [=C2=A0=C2=A0=C2=A0 0.861197]=C2=A0 ? device_driver_attach+0xb0/0xb0
> > [=C2=A0=C2=A0=C2=A0 0.861198]=C2=A0 ? device_driver_attach+0xb0/0xb0
> > [=C2=A0=C2=A0=C2=A0 0.861198]=C2=A0 bus_for_each_dev+0x73/0xb0
> > [=C2=A0=C2=A0=C2=A0 0.861200]=C2=A0 bus_add_driver+0x121/0x1e0
> > [=C2=A0=C2=A0=C2=A0 0.861201]=C2=A0 driver_register+0x8a/0xe0
> > [=C2=A0=C2=A0=C2=A0 0.861202]=C2=A0 ? 0xffffffffc1117000
> > [=C2=A0=C2=A0=C2=A0 0.861203]=C2=A0 do_one_initcall+0x47/0x180
> > [=C2=A0=C2=A0=C2=A0 0.861205]=C2=A0 ? do_init_module+0x19/0x230
> > [=C2=A0=C2=A0=C2=A0 0.861208]=C2=A0 ? kmem_cache_alloc+0x182/0x260
> > [=C2=A0=C2=A0=C2=A0 0.861210]=C2=A0 do_init_module+0x51/0x230
> > [=C2=A0=C2=A0=C2=A0 0.861211]=C2=A0 __do_sys_finit_module+0xb1/0x110
> > [=C2=A0=C2=A0=C2=A0 0.861213]=C2=A0 do_syscall_64+0x40/0xb0
> > [=C2=A0=C2=A0=C2=A0 0.861216]=C2=A0 entry_SYSCALL_64_after_hwframe+0x4=
4/0xae
> > [=C2=A0=C2=A0=C2=A0 0.861218] RIP: 0033:0x7f60a4149679
> > [=C2=A0=C2=A0=C2=A0 0.861220] Code: 48 8d 3d 9a a1 0c 00 0f 05 eb a5 6=
6 0f 1f 44
> > 00 00
> > 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> > 08 0f
> > 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64 89 01
> > 48
> > [=C2=A0=C2=A0=C2=A0 0.861221] RSP: 002b:00007ffe25f17ea8 EFLAGS: 00000=
246
> > ORIG_RAX:
> > 0000000000000139
> > [=C2=A0=C2=A0=C2=A0 0.861223] RAX: ffffffffffffffda RBX: 000056004a10a=
660 RCX:
> > 00007f60a4149679
> > [=C2=A0=C2=A0=C2=A0 0.861224] RDX: 0000000000000000 RSI: 00007f60a42e9=
eed RDI:
> > 0000000000000016
> > [=C2=A0=C2=A0=C2=A0 0.861224] RBP: 0000000000020000 R08: 0000000000000=
000 R09:
> > 000056004a105980
> > [=C2=A0=C2=A0=C2=A0 0.861225] R10: 0000000000000016 R11: 0000000000000=
246 R12:
> > 00007f60a42e9eed
> > [=C2=A0=C2=A0=C2=A0 0.861225] R13: 0000000000000000 R14: 000056004a0ef=
dd0 R15:
> > 000056004a10a660
> > [=C2=A0=C2=A0=C2=A0 0.861226] ---[ end trace 0319f26df48f8ef0 ]---
> > [=C2=A0=C2=A0=C2=A0 0.861228] [drm:amdgpu_ttm_gart_bind [amdgpu]] *ERR=
OR* failed
> > to
> > bind 1 pages at 0x00400000
> > [=C2=A0=C2=A0=C2=A0 0.861540] amdgpu 0000:03:00.0: amdgpu: 00000000a9d=
fe17c bind
> > failed
> >
> >
> > Am Mittwoch, dem 19.01.2022 um 19:54 -0500 schrieb Alex Deucher:
> > > On Wed, Jan 19, 2022 at 7:48 PM Bert Karwatzki <spasswolf@web.de>
> > > wrote:
> > > >
> > > > Bisected the error and found the first bad commit to be
> > > > d015e9861e55928a78137a2c95897bc50637fc47 is the first bad
> > commit
> > > > commit d015e9861e55928a78137a2c95897bc50637fc47
> > > > Author: Jonathan Kim <jonathan.kim@amd.com>
> > > > Date:=C2=A0=C2=A0 Thu Dec 9 16:48:56 2021 -0500
> > > >
> > > > =C2=A0=C2=A0=C2=A0 drm/amdgpu: improve debug VRAM access performan=
ce using
> > > > sdma
> > > >
> > > > =C2=A0=C2=A0=C2=A0 For better performance during VRAM access for d=
ebugged
> > > > processes, do
> > > > =C2=A0=C2=A0=C2=A0 read/write copies over SDMA.
> > > >
> > > > =C2=A0=C2=A0=C2=A0 In order to fulfill post mortem debugging on a =
broken
> > > > device,
> > > > fallback to
> > > > =C2=A0=C2=A0=C2=A0 stable MMIO access when gpu recovery is disable=
d or when
> > > > job
> > > > submission
> > > > =C2=A0=C2=A0=C2=A0 time outs are set to max.=C2=A0 Failed SDMA acc=
ess should
> > > > automatically fall
> > > > =C2=A0=C2=A0=C2=A0 back to MMIO access.
> > > >
> > > > =C2=A0=C2=A0=C2=A0 Use a pre-allocated GTT bounce buffer pre-mappe=
d into GART
> > > > to
> > > > avoid
> > > > =C2=A0=C2=A0=C2=A0 page-table updates and TLB flushes on access.
> > > >
> > > > =C2=A0=C2=A0=C2=A0 Signed-off-by: Jonathan Kim <jonathan.kim@amd.c=
om>
> > > > =C2=A0=C2=A0=C2=A0 Reviewed-by: Felix Kuehling <felix.kuehling@amd=
.com>
> > > >
> > > > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 78
> > > > +++++++++++++++++++++++++++++++++
> > > > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |=C2=A0 4 ++
> > > > =C2=A02 files changed, 82 insertions(+)
> > >
> > > Should be fixed with:
> > >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > tc
> > >
> > hwork.freedesktop.org%2Fpatch%2F470069%2F&amp;data=3D04%7C01%7Cj
> > onathan.
> > >
> > kim%40amd.com%7C666cc32439ea492a788f08d9dbb25da2%7C3dd8961f
> > e4884e608e1
> > >
> > 1a82d994e183d%7C0%7C0%7C637782381705599409%7CUnknown%7CT
> > WFpbGZsb3d8eyJ
> > >
> > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> > %7C2000
> > >
> > &amp;sdata=3Dun0a2cd1Nxcd2IIPw%2B35k01JGoLxxGsAaDteKTeQElo%3D&a
> > mp;reserv
> > > ed=3D0
> > >
> > > Alex
> > >
> > > >
> > > >
> > > > Am Donnerstag, dem 20.01.2022 um 00:22 +0100 schrieb Bert
> > > > Karwatzki:
> > > > > Reverting commit 72f686438de13f121c52f58d7445570a33dfdc61
> > does not
> > > > > change the errors:
> > > > > [=C2=A0=C2=A0=C2=A0 1.310550] ------------[ cut here ]----------=
-- [=C2=A0=C2=A0=C2=A0
> > > > > 1.310551]
> > > > > trying to bind memory to uninitialized GART !
> > > > > [=C2=A0=C2=A0=C2=A0 1.310556] WARNING: CPU: 9 PID: 252 at
> > > > > drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:254
> > > > > amdgpu_gart_bind+0x2e/0x40
> > > > > [amdgpu]
> > > > > [=C2=A0=C2=A0=C2=A0 1.310659] Modules linked in: amdgpu(+) gpu_s=
ched
> > > > > i2c_algo_bit
> > > > > drm_ttm_helper hid_sensor_hub ttm hid_generic nvme
> > drm_kms_helper
> > > > > nvme_core cec xhci_pci t10_pi r8169 rc_core crc32_pclmul
> > > > > crc_t10dif i2c_hid_acpi realtek xhci_hcd psmouse crc32c_intel
> > > > > crct10dif_generic i2c_hid amd_sfh mdio_devres
> > > > > crct10dif_pclmul
> > drm
> > > > > i2c_piix4 usbcore libphy crct10dif_common wmi button battery
> > > > > video
> > > > > fjes(-) hid [=C2=A0=C2=A0=C2=A0 1.310672] CPU: 9 PID: 252 Comm: =
systemd-
> > > > > udevd Not
> > > > > tainted 5.13.0+
> > > > > #4
> > > > > [=C2=A0=C2=A0=C2=A0 1.310673] Hardware name: Micro-Star Internat=
ional Co.,
> > > > > Ltd.
> > > > > Alpha
> > > > > 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021 [=C2=A0=C2=A0=C2=
=A0 1.310674]
> > RIP:
> > > > > 0010:amdgpu_gart_bind+0x2e/0x40 [amdgpu] [=C2=A0=C2=A0=C2=A0 1.3=
10762] Code:
> > 00
> > > > > 80 bf 34 25 00 00 00 74 14 4c 8b 8f 20 25
> > > > > 00
> > > > > 00
> > > > > 4d 85 c9 74 05 e9 01 ff ff ff 31 c0 c3 48 c7 c7 68 36 dd c0
> > > > > e8 86
> > > > > db
> > > > > 19
> > > > > e8 <0f> 0b b8 ea ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f
> > > > > 1f
> > > > > 44
> > > > > 00
> > > > > [=C2=A0=C2=A0=C2=A0 1.310763] RSP: 0018:ffffb19d00c33920 EFLAGS:=
 00010282 [
> > > > > 1.310764] RAX: 0000000000000000 RBX: 0000000000000067 RCX:
> > > > > ffffffffa9abb208
> > > > > [=C2=A0=C2=A0=C2=A0 1.310765] RDX: 0000000000000000 RSI: 0000000=
0ffffefff
> > > > > RDI:
> > > > > ffffffffa9a63200
> > > > > [=C2=A0=C2=A0=C2=A0 1.310766] RBP: ffff985ce2a796c0 R08: 0000000=
000000000
> > > > > R09:
> > > > > ffffb19d00c33748
> > > > > [=C2=A0=C2=A0=C2=A0 1.310766] R10: ffffb19d00c33740 R11: fffffff=
fa9ad3248
> > > > > R12:
> > > > > 0000000000000000
> > > > > [=C2=A0=C2=A0=C2=A0 1.310766] R13: ffff985cd45a0000 R14: ffff985=
cd45a0000
> > > > > R15:
> > > > > 0000000000000000
> > > > > [=C2=A0=C2=A0=C2=A0 1.310767] FS:=C2=A0 00007f69fabdc8c0(0000)
> > > > > GS:ffff985f9e640000(0000)
> > > > > knlGS:0000000000000000
> > > > > [=C2=A0=C2=A0=C2=A0 1.310768] CS:=C2=A0 0010 DS: 0000 ES: 0000 C=
R0:
> > > > > 0000000080050033
> > [
> > > > > 1.310768] CR2: 00007f69fabc5dca CR3: 00000001139ec000 CR4:
> > > > > 0000000000750ee0
> > > > > [=C2=A0=C2=A0=C2=A0 1.310769] PKRU: 55555554
> > > > > [=C2=A0=C2=A0=C2=A0 1.310770] Call Trace:
> > > > > [=C2=A0=C2=A0=C2=A0 1.310772]=C2=A0 amdgpu_ttm_gart_bind+0x79/0x=
c0 [amdgpu] [
> > > > > 1.310858]=C2=A0 amdgpu_ttm_alloc_gart+0x146/0x1a0 [amdgpu] [
> > > > > 1.310942]=C2=A0 amdgpu_bo_create_reserved.part.0+0xf8/0x1b0
> > > > > [amdgpu]
> > > > > [=C2=A0=C2=A0=C2=A0 1.311025]=C2=A0 ? amdgpu_ttm_debugfs_init+0x=
110/0x110
> > > > > [amdgpu]
> > [
> > > > > 1.311145]=C2=A0 amdgpu_bo_create_kernel+0x3b/0xa0 [amdgpu] [
> > > > > 1.311229]=C2=A0 amdgpu_ttm_init.cold+0x165/0x17f [amdgpu] [
> > > > > 1.311349]=C2=A0 gmc_v10_0_sw_init+0x2dc/0x430 [amdgpu]
> > [=C2=A0=C2=A0=C2=A0 1.311455]
> > > > > amdgpu_device_init.cold+0x1544/0x1b54 [amdgpu] [=C2=A0=C2=A0=C2=
=A0
> > > > > 1.311570]=C2=A0 ?
> > > > > acpi_ns_get_node+0x4f/0x5a [=C2=A0=C2=A0=C2=A0 1.311574]=C2=A0 ?
> > > > > acpi_get_handle+0x8e/0xb7 [=C2=A0=C2=A0=C2=A0 1.311576]
> > > > > amdgpu_driver_load_kms+0x67/0x320 [amdgpu] [=C2=A0=C2=A0=C2=A0 1=
.311664]
> > > > > amdgpu_pci_probe+0x1bc/0x290 [amdgpu] [=C2=A0=C2=A0=C2=A0 1.3117=
50]
> > > > > local_pci_probe+0x42/0x80 [=C2=A0=C2=A0=C2=A0 1.311753]=C2=A0 ?
> > > > > __cond_resched+0x16/0x40 [=C2=A0=C2=A0=C2=A0 1.311755]
> > > > > pci_device_probe+0xfd/0x1b0 [=C2=A0=C2=A0=C2=A0 1.311756]
> > > > > really_probe+0xf2/0x460 [=C2=A0=C2=A0=C2=A0 1.311759]
> > > > > driver_probe_device+0xe8/0x160 [=C2=A0=C2=A0=C2=A0 1.311760]
> > > > > device_driver_attach+0xa1/0xb0 [=C2=A0=C2=A0=C2=A0 1.311761]
> > > > > __driver_attach+0x8f/0x150 [=C2=A0=C2=A0=C2=A0 1.311763]=C2=A0 ?
> > > > > device_driver_attach+0xb0/0xb0 [=C2=A0=C2=A0=C2=A0 1.311764]=C2=
=A0 ?
> > > > > device_driver_attach+0xb0/0xb0 [=C2=A0=C2=A0=C2=A0 1.311765]
> > > > > bus_for_each_dev+0x78/0xc0 [=C2=A0=C2=A0=C2=A0 1.311766]
> > > > > bus_add_driver+0x12b/0x1e0 [=C2=A0=C2=A0=C2=A0 1.311768]
> > > > > driver_register+0x8f/0xe0 [=C2=A0=C2=A0=C2=A0 1.311769]=C2=A0 ?
> > > > > 0xffffffffc1828000 [
> > > > > 1.311770]=C2=A0 do_one_initcall+0x44/0x1d0 [=C2=A0=C2=A0=C2=A0 1=
.311772]=C2=A0 ?
> > > > > kmem_cache_alloc_trace+0x103/0x240
> > > > > [=C2=A0=C2=A0=C2=A0 1.311775]=C2=A0 do_init_module+0x5c/0x270 [=
=C2=A0=C2=A0=C2=A0 1.311777]
> > > > > __do_sys_finit_module+0xb1/0x110 [=C2=A0=C2=A0=C2=A0 1.311779]
> > > > > do_syscall_64+0x40/0xb0 [=C2=A0=C2=A0=C2=A0 1.311781]
> > > > > entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > [=C2=A0=C2=A0=C2=A0 1.311783] RIP: 0033:0x7f69fb094679 [=C2=A0=
=C2=A0=C2=A0 1.311785] Code:
> > > > > 48 8d
> > > > > 3d 9a a1 0c 00 0f 05 eb a5 66 0f 1f 44
> > > > > 00
> > > > > 00
> > > > > 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> > > > > 4c 24
> > > > > 08
> > > > > 0f
> > > > > 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64
> > > > > 89
> > > > > 01
> > > > > 48
> > > > > [=C2=A0=C2=A0=C2=A0 1.311786] RSP: 002b:00007ffce4131708 EFLAGS:=
 00000246
> > > > > ORIG_RAX:
> > > > > 0000000000000139
> > > > > [=C2=A0=C2=A0=C2=A0 1.311788] RAX: ffffffffffffffda RBX: 000055d=
71350a3a0
> > > > > RCX:
> > > > > 00007f69fb094679
> > > > > [=C2=A0=C2=A0=C2=A0 1.311788] RDX: 0000000000000000 RSI: 00007f6=
9fb234eed
> > > > > RDI:
> > > > > 0000000000000013
> > > > > [=C2=A0=C2=A0=C2=A0 1.311789] RBP: 0000000000020000 R08: 0000000=
000000000
> > R09:
> > > > > 000055d7134f3930
> > > > > [=C2=A0=C2=A0=C2=A0 1.311789] R10: 0000000000000013 R11: 0000000=
000000246
> > R12:
> > > > > 00007f69fb234eed
> > > > > [=C2=A0=C2=A0=C2=A0 1.311790] R13: 0000000000000000 R14: 000055d=
7134da0f0
> > R15:
> > > > > 000055d71350a3a0
> > > > > [=C2=A0=C2=A0=C2=A0 1.311791] ---[ end trace ff47998e3140e95d ]-=
-- [=C2=A0=C2=A0=C2=A0
> > > > > 1.311793]
> > > > > [drm:amdgpu_ttm_gart_bind [amdgpu]] *ERROR* failed to bind 1
> > pages
> > > > > at 0x00400000 [=C2=A0=C2=A0=C2=A0 1.312100] amdgpu 0000:03:00.0:=
 amdgpu:
> > > > > 00000000989bdfac bind failed
> > > > >
> > > > > and using
> > > > >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > > >
> > patchwork.freedesktop.org%2Fpatch%2F469907%2F&amp;data=3D04%7C01
> > %7Cj
> > > > >
> > onathan.kim%40amd.com%7C666cc32439ea492a788f08d9dbb25da2%7C3
> > dd8961
> > > > >
> > fe4884e608e11a82d994e183d%7C0%7C0%7C637782381705599409%7CU
> > nknown%7
> > > > >
> > CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
> > iL
> > > > >
> > CJXVCI6Mn0%3D%7C2000&amp;sdata=3DCA5Vz90Asz5lJsionuxAZ8iDlUIJrdW
> > FqiB
> > > > > UuJYbfNE%3D&amp;reserved=3D0
> > > > > gives a this message:
> > > > >
> > > > > [=C2=A0=C2=A0=C2=A0 1.311502] ------------[ cut here ]----------=
-- [=C2=A0=C2=A0=C2=A0
> > > > > 1.311502]
> > > > > WARNING: CPU: 9 PID: 221 at
> > > > > drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:244
> > > > > amdgpu_gart_bind+0x16/0x20
> > > > > [amdgpu]
> > > > > [=C2=A0=C2=A0=C2=A0 1.311602] Modules linked in: amdgpu(+) gpu_s=
ched
> > > > > i2c_algo_bit
> > > > > drm_ttm_helper hid_sensor_hub ttm hid_generic nvme xhci_pci
> > > > > drm_kms_helper nvme_core t10_pi xhci_hcd crc_t10dif r8169 cec
> > > > > crct10dif_generic i2c_hid_acpi amd_sfh rc_core
> > > > > crct10dif_pclmul
> > > > > realtek i2c_hid crc32_pclmul mdio_devres psmouse usbcore
> > > > > crc32c_intel drm libphy i2c_piix4 crct10dif_common button wmi
> > > > > battery video fjes(-
> > > > > )
> > > > > hid
> > > > > [=C2=A0=C2=A0=C2=A0 1.311614] CPU: 9 PID: 221 Comm: systemd-udev=
d Not
> > > > > tainted
> > > > > 5.13.0+
> > > > > #6
> > > > > [=C2=A0=C2=A0=C2=A0 1.311616] Hardware name: Micro-Star Internat=
ional Co.,
> > > > > Ltd.
> > > > > Alpha
> > > > > 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021 [=C2=A0=C2=A0=C2=
=A0 1.311617]
> > RIP:
> > > > > 0010:amdgpu_gart_bind+0x16/0x20 [amdgpu] [=C2=A0=C2=A0=C2=A0 1.3=
11701] Code:
> > 39
> > > > > df 74 aa eb dc e8 19 a2 f6 f0 66 0f 1f 84
> > > > > 00
> > > > > 00
> > > > > 00 00 00 0f 1f 44 00 00 4c 8b 8f 20 25 00 00 4d 85 c9 74 05
> > > > > e9 3a
> > > > > ff ff ff <0f> 0b c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48
> > > > > 89
> > > > > fd 53 0f ae [=C2=A0=C2=A0=C2=A0 1.311702] RSP: 0018:ffffb5be80b1=
7948 EFLAGS:
> > > > > 00010246 [=C2=A0=C2=A0=C2=A0 1.311703] RAX: 0000000000000022 RBX=
:
> > > > > ffff98670583e858 RCX:
> > > > > ffff98677c8a8738
> > > > > [=C2=A0=C2=A0=C2=A0 1.311704] RDX: 0000000000000001 RSI: 0000000=
000400000
> > > > > RDI:
> > > > > ffff986720ce0000
> > > > > [=C2=A0=C2=A0=C2=A0 1.311704] RBP: ffff986705841a08 R08: 0000000=
000000067
> > > > > R09:
> > > > > 0000000000000000
> > > > > [=C2=A0=C2=A0=C2=A0 1.311705] R10: ffff986705841a08 R11: 0000000=
000000400
> > > > > R12:
> > > > > 0000000000000000
> > > > > [=C2=A0=C2=A0=C2=A0 1.311705] R13: ffff98670dc50e40 R14: ffff986=
720ce0000
> > > > > R15:
> > > > > 0000000000000000
> > > > > [=C2=A0=C2=A0=C2=A0 1.311706] FS:=C2=A0 00007ff4ee0968c0(0000)
> > > > > GS:ffff9869de840000(0000)
> > > > > knlGS:0000000000000000
> > > > > [=C2=A0=C2=A0=C2=A0 1.311707] CS:=C2=A0 0010 DS: 0000 ES: 0000 C=
R0:
> > > > > 0000000080050033
> > [
> > > > > 1.311707] CR2: 00007ff4ee07fdca CR3: 000000017b436000 CR4:
> > > > > 0000000000750ee0
> > > > > [=C2=A0=C2=A0=C2=A0 1.311708] PKRU: 55555554
> > > > > [=C2=A0=C2=A0=C2=A0 1.311708] Call Trace:
> > > > > [=C2=A0=C2=A0=C2=A0 1.311710]=C2=A0 amdgpu_ttm_alloc_gart+0x147/=
0x190 [amdgpu] [
> > > > > 1.311793]=C2=A0 amdgpu_bo_create_reserved.part.0+0xf8/0x1b0
> > > > > [amdgpu]
> > > > > [=C2=A0=C2=A0=C2=A0 1.311873]=C2=A0 ? amdgpu_ttm_debugfs_init+0x=
110/0x110
> > > > > [amdgpu]
> > [
> > > > > 1.311952]=C2=A0 amdgpu_bo_create_kernel+0x3b/0xa0 [amdgpu] [
> > > > > 1.312031]=C2=A0 amdgpu_ttm_init.cold+0x165/0x17f [amdgpu] [
> > > > > 1.312181]=C2=A0 gmc_v10_0_sw_init+0x2dc/0x430 [amdgpu]
> > [=C2=A0=C2=A0=C2=A0 1.312275]
> > > > > amdgpu_device_init.cold+0x1544/0x1b54 [amdgpu] [=C2=A0=C2=A0=C2=
=A0
> > > > > 1.312385]=C2=A0 ?
> > > > > acpi_ns_get_node+0x4f/0x5a [=C2=A0=C2=A0=C2=A0 1.312388]=C2=A0 ?
> > > > > acpi_get_handle+0x8e/0xb7 [=C2=A0=C2=A0=C2=A0 1.312390]
> > > > > amdgpu_driver_load_kms+0x67/0x320 [amdgpu] [=C2=A0=C2=A0=C2=A0 1=
.312479]
> > > > > amdgpu_pci_probe+0x1bc/0x290 [amdgpu] [=C2=A0=C2=A0=C2=A0 1.3125=
73]
> > > > > local_pci_probe+0x42/0x80 [=C2=A0=C2=A0=C2=A0 1.312578]=C2=A0 ?
> > > > > __cond_resched+0x16/0x40 [=C2=A0=C2=A0=C2=A0 1.312581]
> > > > > pci_device_probe+0xfd/0x1b0 [=C2=A0=C2=A0=C2=A0 1.312583]
> > > > > really_probe+0xf2/0x460 [=C2=A0=C2=A0=C2=A0 1.312587]
> > > > > driver_probe_device+0xe8/0x160 [=C2=A0=C2=A0=C2=A0 1.312589]
> > > > > device_driver_attach+0xa1/0xb0 [=C2=A0=C2=A0=C2=A0 1.312591]
> > > > > __driver_attach+0x8f/0x150 [=C2=A0=C2=A0=C2=A0 1.312592]=C2=A0 ?
> > > > > device_driver_attach+0xb0/0xb0 [=C2=A0=C2=A0=C2=A0 1.312593]=C2=
=A0 ?
> > > > > device_driver_attach+0xb0/0xb0 [=C2=A0=C2=A0=C2=A0 1.312594]
> > > > > bus_for_each_dev+0x78/0xc0 [=C2=A0=C2=A0=C2=A0 1.312595]
> > > > > bus_add_driver+0x12b/0x1e0 [=C2=A0=C2=A0=C2=A0 1.312597]
> > > > > driver_register+0x8f/0xe0 [=C2=A0=C2=A0=C2=A0 1.312598]=C2=A0 ?
> > > > > 0xffffffffc1696000 [
> > > > > 1.312599]=C2=A0 do_one_initcall+0x44/0x1d0 [=C2=A0=C2=A0=C2=A0 1=
.312602]=C2=A0 ?
> > > > > kmem_cache_alloc_trace+0x103/0x240
> > > > > [=C2=A0=C2=A0=C2=A0 1.312604]=C2=A0 do_init_module+0x5c/0x270 [=
=C2=A0=C2=A0=C2=A0 1.312606]
> > > > > __do_sys_finit_module+0xb1/0x110 [=C2=A0=C2=A0=C2=A0 1.312608]
> > > > > do_syscall_64+0x40/0xb0 [=C2=A0=C2=A0=C2=A0 1.312610]
> > > > > entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > [=C2=A0=C2=A0=C2=A0 1.312614] RIP: 0033:0x7ff4ee54e679 [=C2=A0=
=C2=A0=C2=A0 1.312616] Code:
> > > > > 48 8d
> > > > > 3d 9a a1 0c 00 0f 05 eb a5 66 0f 1f 44
> > > > > 00
> > > > > 00
> > > > > 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> > > > > 4c 24
> > > > > 08
> > > > > 0f
> > > > > 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64
> > > > > 89
> > > > > 01
> > > > > 48
> > > > > [=C2=A0=C2=A0=C2=A0 1.312617] RSP: 002b:00007fff9c9d5bc8 EFLAGS:=
 00000246
> > > > > ORIG_RAX:
> > > > > 0000000000000139
> > > > > [=C2=A0=C2=A0=C2=A0 1.312618] RAX: ffffffffffffffda RBX: 000055a=
ca9cf9230
> > > > > RCX:
> > > > > 00007ff4ee54e679
> > > > > [=C2=A0=C2=A0=C2=A0 1.312619] RDX: 0000000000000000 RSI: 00007ff=
4ee6eeeed
> > > > > RDI:
> > > > > 0000000000000013
> > > > > [=C2=A0=C2=A0=C2=A0 1.312619] RBP: 0000000000020000 R08: 0000000=
000000000
> > R09:
> > > > > 000055aca9cdf480
> > > > > [=C2=A0=C2=A0=C2=A0 1.312620] R10: 0000000000000013 R11: 0000000=
000000246
> > R12:
> > > > > 00007ff4ee6eeeed
> > > > > [=C2=A0=C2=A0=C2=A0 1.312620] R13: 0000000000000000 R14: 000055a=
ca9cf9ab0
> > > > > R15:
> > > > > 000055aca9cf9230
> > > > > [=C2=A0=C2=A0=C2=A0 1.312622] ---[ end trace c4fc99f16e2a1eb7 ]-=
--
> > > > >
> > > > > In both cases there's a similar error message for the oth GPU
> > > > > in
> > > > > the system (the integrated one at 08:00.0)
> > > > >
> > > > > Am Mittwoch, dem 19.01.2022 um 23:40 +0100 schrieb Das,
> > > > > Nirmoy:
> > > > > >
> > > > > > On 1/19/2022 10:59 PM, Limonciello, Mario wrote:
> > > > > > > [Public]
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Bert Karwatzki <spasswolf@web.de>
> > > > > > > > Sent: Wednesday, January 19, 2022 15:52
> > > > > > > > To: amd-gfx@lists.freedesktop.org
> > > > > > > > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>;
> > > > > > > > Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>;
> > > > > > > > Zhuo,
> > > > > > > > Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Scott Bruce
> > > > > > > > <smbruce@gmail.com>; Alex Deucher
> > <alexdeucher@gmail.com>;
> > > > > > > > Chris Hixon <linux-kernel-bugs@hixontech.com>
> > > > > > > > Subject: amd-staging-drm-next breaks suspend
> > > > > > > >
> > > > > > > > I just tested drm-staging-drm-next with HEAD
> > > > > > > > f1b2924ee6929cb431440e6f961f06eb65d52beb:
> > > > > > > > Going into suspend leads to a hang again:
> > > > > > > > This is probably caused by
> > > > > > > > [ 1.310551] trying to bind memory to uninitialized GART
> > > > > > > > !
> > > > > > > > and/or
> > > > > > > > [ 3.976438] trying to bind memory to uninitialized GART
> > > > > > > > !
> > > > > >
> > > > > >
> > > > > > Could you please also try
> > > > > >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > tchwork.freedesktop.org%2Fpatch%2F469907%2F&amp;data=3D04%7C01%7
> > Cjonathan.kim%40amd.com%7C666cc32439ea492a788f08d9dbb25da2%7
> > C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63778238170559
> > 9409%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> > uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3DCA5Vz90A
> > sz5lJsionuxAZ8iDlUIJrdWFqiBUuJYbfNE%3D&amp;reserved=3D0 ?
> > > > > >
> > > > > >
> > > > > > Regards,
> > > > > >
> > > > > > Nirmoy
> > > > > >
> > > > > > > >
> > > >
>


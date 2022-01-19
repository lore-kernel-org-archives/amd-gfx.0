Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5645C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 00:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45FB310E37C;
	Thu, 20 Jan 2022 00:36:38 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A0810E294
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1642634528;
 bh=uMJYe/mJ+1R3894rBbKhH04I7CRvA5egcQ+kgxt9Wlc=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=o8KSe33YVUbd3UDs0Jm7f9oPkDJbuFj9FLVvYTmJIBIhQKB3UzEAz9nqB0P9GxdpA
 uQIEuWT4avxg5F7IgI8nzPp4lFEFAE9XOovPAnWWBLUCUftDoCdNM3Ya/orLnbZKkQ
 +wNgN2mZJUtogwqs8SVQrvh5vNqock3vPB51lVJg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.101] ([88.152.98.65]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mdf89-1mbGVd0ruT-00ZJKP; Thu, 20
 Jan 2022 00:22:08 +0100
Message-ID: <75d1eefa7cf24d1751532b19841625be010cc015.camel@web.de>
Subject: Re: amd-staging-drm-next breaks suspend
From: Bert Karwatzki <spasswolf@web.de>
To: "Das, Nirmoy" <nirmoy.das@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Thu, 20 Jan 2022 00:22:06 +0100
In-Reply-To: <904d0552-20b0-2e11-c061-4d9d20bca374@amd.com>
References: <2d7fe1c0ddde50a1836b49dff8a02decdfcbe00d.camel@web.de>
 <BL1PR12MB515792BB2C4609F91269E3AFE2599@BL1PR12MB5157.namprd12.prod.outlook.com>
 <904d0552-20b0-2e11-c061-4d9d20bca374@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xz48JS73//ddpNqDd2siNix7gBlL8Wm5PKXceZBkv1MM5yL3ZrI
 RfNoZJMl7y+FJXpjX0Bgac8j1Tzj21/l9XIKShCHO7oV/YXoFdI9JiMA7ztdglBDCJUL7tr
 5bWDxD+wFSNhRhcY9cpSHjvqZzsjG52P1sDNjnaHMdK64StSvFzmGW6mcGIwubKQTPmvgdH
 aXtYFsiYwCHwlOpZ+JPWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LvezOGtKWUQ=:Js1+EP2wpuQwJX6oNidzOI
 AsI3G7sJGlEMh2knjOOVb6nTU0NRp8qkvGFlv4H49R+I1QM3KVtNdGqZGwuK97HIm2pgazfv9
 zYvqDL9q8kzKHAjyZ3DpMBcEYlVAkkqzWOz4HrMwkbDpn3ZSfWDweOc3+vewZm9yTmSw71uLB
 HhW8aFKk8+GuSIPTvz1ZAyT7ZpfRS9qC7wFTNVG3Vj+vuJqOFvbr3yiYF/sHtOGyeTkvJxxgp
 EimrExpRjIuTQFrlHO0ov+IGKv8Ume1qiXQ2jzh1pU6UrX0pZ4efFMGH+uHdrkQXgwulSvJjI
 fD7t+cEOm/jRYB9YWxUZWp4rC+Zjdj0AnCA2ZagrOkhM9FWHiwE55O9E8+awBqHAV5IDxvpd1
 aPnmx82hgr0SbQ8XzzVG/LzDMpKVCio9zMj4hNfrhoH5qSMbSqYj9DbU859eO4x5Q7H2SYeDd
 3HnT5fss4xUA8RdjP98LEqjb9WKNP/V5JHav9HcwooiTO2pAZ4nIBJ0E24pLPbgtbLNUl3m9X
 0QmLYZkEiKBA3Y/DTD1Vf3Qinboc14fTWiJ3OXmMDckhQ35tBJhuaOtUVGzJcCZ4la2a41K5O
 aaa8m92nk+Q3vbl3jHyViwN78aeoUk4gg1vt5UZZ34IDDJSuHUqCq2NBGE4PEXr+lG1DqFo1d
 d4Dxuif0y+D6VbZd0NkwKcRD/Rp3/JbN9uSU/Wf59qyMyWCjBpgVnv+AcfBBhEicQDJN2AVT4
 DfoFkgoEEFGZZqsl9JGHheGQxBwT/Ox4UV+Y892EwZ+yB95d+1imwGJYWCd62TgQfQdAesZx3
 d6UWIDlqhBtIi+2PjfgzNIvHDUQhTqHIhzHw870fFL/dG8u7KMlx/28OZz2QOVkvEwFpLhwfo
 FUwZFsQJYOJ+7B30KxWF07ZhlPg8ujP5S3t9JTa1+Enk/OQ/2dxxvG4CGfjcwsoW/miwm/i8Y
 Rv3PO/gUep9uMFhLWNAptfIyp9zhP1eYEbfM5HkY5M/bu+bVe4kNx7TmgQlhvS/irDoRAfmBl
 P/Vy0/0Ej7/+/hWlKK1LHnCBtHGOqYWf5Sozpm4VpmEjKDhOuvgEPLxZicYVjDDNRhI8gDHG2
 DyGGO/BBPRPYWc=
X-Mailman-Approved-At: Thu, 20 Jan 2022 00:36:37 +0000
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Zhuo, Qingqing
 \(Lillian\)" <Qingqing.Zhuo@amd.com>, Scott Bruce <smbruce@gmail.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reverting commit 72f686438de13f121c52f58d7445570a33dfdc61 does not
change the errors:
[    1.310550] ------------[ cut here ]------------
[    1.310551] trying to bind memory to uninitialized GART !
[    1.310556] WARNING: CPU: 9 PID: 252 at
drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:254 amdgpu_gart_bind+0x2e/0x40
[amdgpu]
[    1.310659] Modules linked in: amdgpu(+) gpu_sched i2c_algo_bit
drm_ttm_helper hid_sensor_hub ttm hid_generic nvme drm_kms_helper
nvme_core cec xhci_pci t10_pi r8169 rc_core crc32_pclmul crc_t10dif
i2c_hid_acpi realtek xhci_hcd psmouse crc32c_intel crct10dif_generic
i2c_hid amd_sfh mdio_devres crct10dif_pclmul drm i2c_piix4 usbcore
libphy crct10dif_common wmi button battery video fjes(-) hid
[    1.310672] CPU: 9 PID: 252 Comm: systemd-udevd Not tainted 5.13.0+
#4
[    1.310673] Hardware name: Micro-Star International Co., Ltd. Alpha
15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[    1.310674] RIP: 0010:amdgpu_gart_bind+0x2e/0x40 [amdgpu]
[    1.310762] Code: 00 80 bf 34 25 00 00 00 74 14 4c 8b 8f 20 25 00 00
4d 85 c9 74 05 e9 01 ff ff ff 31 c0 c3 48 c7 c7 68 36 dd c0 e8 86 db 19
e8 <0f> 0b b8 ea ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
[    1.310763] RSP: 0018:ffffb19d00c33920 EFLAGS: 00010282
[    1.310764] RAX: 0000000000000000 RBX: 0000000000000067 RCX:
ffffffffa9abb208
[    1.310765] RDX: 0000000000000000 RSI: 00000000ffffefff RDI:
ffffffffa9a63200
[    1.310766] RBP: ffff985ce2a796c0 R08: 0000000000000000 R09:
ffffb19d00c33748
[    1.310766] R10: ffffb19d00c33740 R11: ffffffffa9ad3248 R12:
0000000000000000
[    1.310766] R13: ffff985cd45a0000 R14: ffff985cd45a0000 R15:
0000000000000000
[    1.310767] FS:  00007f69fabdc8c0(0000) GS:ffff985f9e640000(0000)
knlGS:0000000000000000
[    1.310768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.310768] CR2: 00007f69fabc5dca CR3: 00000001139ec000 CR4:
0000000000750ee0
[    1.310769] PKRU: 55555554
[    1.310770] Call Trace:
[    1.310772]  amdgpu_ttm_gart_bind+0x79/0xc0 [amdgpu]
[    1.310858]  amdgpu_ttm_alloc_gart+0x146/0x1a0 [amdgpu]
[    1.310942]  amdgpu_bo_create_reserved.part.0+0xf8/0x1b0 [amdgpu]
[    1.311025]  ? amdgpu_ttm_debugfs_init+0x110/0x110 [amdgpu]
[    1.311145]  amdgpu_bo_create_kernel+0x3b/0xa0 [amdgpu]
[    1.311229]  amdgpu_ttm_init.cold+0x165/0x17f [amdgpu]
[    1.311349]  gmc_v10_0_sw_init+0x2dc/0x430 [amdgpu]
[    1.311455]  amdgpu_device_init.cold+0x1544/0x1b54 [amdgpu]
[    1.311570]  ? acpi_ns_get_node+0x4f/0x5a
[    1.311574]  ? acpi_get_handle+0x8e/0xb7
[    1.311576]  amdgpu_driver_load_kms+0x67/0x320 [amdgpu]
[    1.311664]  amdgpu_pci_probe+0x1bc/0x290 [amdgpu]
[    1.311750]  local_pci_probe+0x42/0x80
[    1.311753]  ? __cond_resched+0x16/0x40
[    1.311755]  pci_device_probe+0xfd/0x1b0
[    1.311756]  really_probe+0xf2/0x460
[    1.311759]  driver_probe_device+0xe8/0x160
[    1.311760]  device_driver_attach+0xa1/0xb0
[    1.311761]  __driver_attach+0x8f/0x150
[    1.311763]  ? device_driver_attach+0xb0/0xb0
[    1.311764]  ? device_driver_attach+0xb0/0xb0
[    1.311765]  bus_for_each_dev+0x78/0xc0
[    1.311766]  bus_add_driver+0x12b/0x1e0
[    1.311768]  driver_register+0x8f/0xe0
[    1.311769]  ? 0xffffffffc1828000
[    1.311770]  do_one_initcall+0x44/0x1d0
[    1.311772]  ? kmem_cache_alloc_trace+0x103/0x240
[    1.311775]  do_init_module+0x5c/0x270
[    1.311777]  __do_sys_finit_module+0xb1/0x110
[    1.311779]  do_syscall_64+0x40/0xb0
[    1.311781]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    1.311783] RIP: 0033:0x7f69fb094679
[    1.311785] Code: 48 8d 3d 9a a1 0c 00 0f 05 eb a5 66 0f 1f 44 00 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64 89 01 48
[    1.311786] RSP: 002b:00007ffce4131708 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    1.311788] RAX: ffffffffffffffda RBX: 000055d71350a3a0 RCX:
00007f69fb094679
[    1.311788] RDX: 0000000000000000 RSI: 00007f69fb234eed RDI:
0000000000000013
[    1.311789] RBP: 0000000000020000 R08: 0000000000000000 R09:
000055d7134f3930
[    1.311789] R10: 0000000000000013 R11: 0000000000000246 R12:
00007f69fb234eed
[    1.311790] R13: 0000000000000000 R14: 000055d7134da0f0 R15:
000055d71350a3a0
[    1.311791] ---[ end trace ff47998e3140e95d ]---
[    1.311793] [drm:amdgpu_ttm_gart_bind [amdgpu]] *ERROR* failed to
bind 1 pages at 0x00400000
[    1.312100] amdgpu 0000:03:00.0: amdgpu: 00000000989bdfac bind
failed

and using https://patchwork.freedesktop.org/patch/469907/
gives a this message:

[    1.311502] ------------[ cut here ]------------
[    1.311502] WARNING: CPU: 9 PID: 221 at
drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:244 amdgpu_gart_bind+0x16/0x20
[amdgpu]
[    1.311602] Modules linked in: amdgpu(+) gpu_sched i2c_algo_bit
drm_ttm_helper hid_sensor_hub ttm hid_generic nvme xhci_pci
drm_kms_helper nvme_core t10_pi xhci_hcd crc_t10dif r8169 cec
crct10dif_generic i2c_hid_acpi amd_sfh rc_core crct10dif_pclmul realtek
i2c_hid crc32_pclmul mdio_devres psmouse usbcore crc32c_intel drm
libphy i2c_piix4 crct10dif_common button wmi battery video fjes(-) hid
[    1.311614] CPU: 9 PID: 221 Comm: systemd-udevd Not tainted 5.13.0+
#6
[    1.311616] Hardware name: Micro-Star International Co., Ltd. Alpha
15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[    1.311617] RIP: 0010:amdgpu_gart_bind+0x16/0x20 [amdgpu]
[    1.311701] Code: 39 df 74 aa eb dc e8 19 a2 f6 f0 66 0f 1f 84 00 00
00 00 00 0f 1f 44 00 00 4c 8b 8f 20 25 00 00 4d 85 c9 74 05 e9 3a ff ff
ff <0f> 0b c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 fd 53 0f ae
[    1.311702] RSP: 0018:ffffb5be80b17948 EFLAGS: 00010246
[    1.311703] RAX: 0000000000000022 RBX: ffff98670583e858 RCX:
ffff98677c8a8738
[    1.311704] RDX: 0000000000000001 RSI: 0000000000400000 RDI:
ffff986720ce0000
[    1.311704] RBP: ffff986705841a08 R08: 0000000000000067 R09:
0000000000000000
[    1.311705] R10: ffff986705841a08 R11: 0000000000000400 R12:
0000000000000000
[    1.311705] R13: ffff98670dc50e40 R14: ffff986720ce0000 R15:
0000000000000000
[    1.311706] FS:  00007ff4ee0968c0(0000) GS:ffff9869de840000(0000)
knlGS:0000000000000000
[    1.311707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.311707] CR2: 00007ff4ee07fdca CR3: 000000017b436000 CR4:
0000000000750ee0
[    1.311708] PKRU: 55555554
[    1.311708] Call Trace:
[    1.311710]  amdgpu_ttm_alloc_gart+0x147/0x190 [amdgpu]
[    1.311793]  amdgpu_bo_create_reserved.part.0+0xf8/0x1b0 [amdgpu]
[    1.311873]  ? amdgpu_ttm_debugfs_init+0x110/0x110 [amdgpu]
[    1.311952]  amdgpu_bo_create_kernel+0x3b/0xa0 [amdgpu]
[    1.312031]  amdgpu_ttm_init.cold+0x165/0x17f [amdgpu]
[    1.312181]  gmc_v10_0_sw_init+0x2dc/0x430 [amdgpu]
[    1.312275]  amdgpu_device_init.cold+0x1544/0x1b54 [amdgpu]
[    1.312385]  ? acpi_ns_get_node+0x4f/0x5a
[    1.312388]  ? acpi_get_handle+0x8e/0xb7
[    1.312390]  amdgpu_driver_load_kms+0x67/0x320 [amdgpu]
[    1.312479]  amdgpu_pci_probe+0x1bc/0x290 [amdgpu]
[    1.312573]  local_pci_probe+0x42/0x80
[    1.312578]  ? __cond_resched+0x16/0x40
[    1.312581]  pci_device_probe+0xfd/0x1b0
[    1.312583]  really_probe+0xf2/0x460
[    1.312587]  driver_probe_device+0xe8/0x160
[    1.312589]  device_driver_attach+0xa1/0xb0
[    1.312591]  __driver_attach+0x8f/0x150
[    1.312592]  ? device_driver_attach+0xb0/0xb0
[    1.312593]  ? device_driver_attach+0xb0/0xb0
[    1.312594]  bus_for_each_dev+0x78/0xc0
[    1.312595]  bus_add_driver+0x12b/0x1e0
[    1.312597]  driver_register+0x8f/0xe0
[    1.312598]  ? 0xffffffffc1696000
[    1.312599]  do_one_initcall+0x44/0x1d0
[    1.312602]  ? kmem_cache_alloc_trace+0x103/0x240
[    1.312604]  do_init_module+0x5c/0x270
[    1.312606]  __do_sys_finit_module+0xb1/0x110
[    1.312608]  do_syscall_64+0x40/0xb0
[    1.312610]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    1.312614] RIP: 0033:0x7ff4ee54e679
[    1.312616] Code: 48 8d 3d 9a a1 0c 00 0f 05 eb a5 66 0f 1f 44 00 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64 89 01 48
[    1.312617] RSP: 002b:00007fff9c9d5bc8 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    1.312618] RAX: ffffffffffffffda RBX: 000055aca9cf9230 RCX:
00007ff4ee54e679
[    1.312619] RDX: 0000000000000000 RSI: 00007ff4ee6eeeed RDI:
0000000000000013
[    1.312619] RBP: 0000000000020000 R08: 0000000000000000 R09:
000055aca9cdf480
[    1.312620] R10: 0000000000000013 R11: 0000000000000246 R12:
00007ff4ee6eeeed
[    1.312620] R13: 0000000000000000 R14: 000055aca9cf9ab0 R15:
000055aca9cf9230
[    1.312622] ---[ end trace c4fc99f16e2a1eb7 ]---

In both cases there's a similar error message for the oth GPU in the
system (the integrated one at 08:00.0)

Am Mittwoch, dem 19.01.2022 um 23:40 +0100 schrieb Das, Nirmoy:
>
> On 1/19/2022 10:59 PM, Limonciello, Mario wrote:
> > [Public]
> >
> > > -----Original Message-----
> > > From: Bert Karwatzki <spasswolf@web.de>
> > > Sent: Wednesday, January 19, 2022 15:52
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Kazlauskas,
> > > Nicholas
> > > <Nicholas.Kazlauskas@amd.com>; Zhuo, Qingqing (Lillian)
> > > <Qingqing.Zhuo@amd.com>; Scott Bruce <smbruce@gmail.com>; Alex
> > > Deucher
> > > <alexdeucher@gmail.com>; Chris Hixon
> > > <linux-kernel-bugs@hixontech.com>
> > > Subject: amd-staging-drm-next breaks suspend
> > >
> > > I just tested drm-staging-drm-next with HEAD
> > > f1b2924ee6929cb431440e6f961f06eb65d52beb:
> > > Going into suspend leads to a hang again:
> > > This is probably caused by
> > > [ 1.310551] trying to bind memory to uninitialized GART !
> > > and/or
> > > [ 3.976438] trying to bind memory to uninitialized GART !
>
>
> Could you please also try
> https://patchwork.freedesktop.org/patch/469907/=C2=A0?
>
>
> Regards,
>
> Nirmoy
>
> > >

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67EFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 00:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B05610F317;
	Thu, 20 Jan 2022 00:53:18 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E2110F314
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 00:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1642639694;
 bh=ZDS0fIgqXL2Nb5uwnMj1g9Oau5kveLP8cJzakQfnZLA=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=gOUGbaPgfRJLWlJErQhE1ANK/cxBNLR9045dNVH4mkQz4beposBq95AcHPeF5LfOo
 uYHRipbfL/HclVtaikhHpbvA5SnhA1qMJHOx/6KH6G9KOksN+DXTNAe4nzoGmibFzl
 LLJ+eJpnGohw/HfsrXtqVd4la4Adka5uq3brATU4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.101] ([88.152.98.65]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPrY-1mIwoi0gsI-00v9kq; Thu, 20
 Jan 2022 01:48:14 +0100
Message-ID: <314494939bcf185110d6a468637b08891138fba5.camel@web.de>
Subject: Re: amd-staging-drm-next breaks suspend
From: Bert Karwatzki <spasswolf@web.de>
To: "Das, Nirmoy" <nirmoy.das@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Thu, 20 Jan 2022 01:48:12 +0100
In-Reply-To: <75d1eefa7cf24d1751532b19841625be010cc015.camel@web.de>
References: <2d7fe1c0ddde50a1836b49dff8a02decdfcbe00d.camel@web.de>
 <BL1PR12MB515792BB2C4609F91269E3AFE2599@BL1PR12MB5157.namprd12.prod.outlook.com>
 <904d0552-20b0-2e11-c061-4d9d20bca374@amd.com>
 <75d1eefa7cf24d1751532b19841625be010cc015.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DBUDciFR9W2+7C5fkK27F7XZHYY+yiJ/+fgaPoZnO2S3QU+3xgC
 DHOZ8unIgPo7ZaHXNoAagpf7XYRH5a+fS2peZiaaaqB6i9AQClyMnjQHI5OlMNwnMtwTo3K
 b/ASDH+qI7udBbfS5MOUPw2k+oEJkHOhtBiGXSlyGM6QL6VysryX6x2tjeC3GBsgtJQeqG8
 iDvYg+cGtxjhLFJbc1moA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PrCoOF5YyXg=:b6epm7X+y153eZilGQkPRs
 ZMostlgFnkMtpyesbEr3lz4SS6dmS2mOO1Cw9BZFfVFbHD8TmF33XgzInw6EWsuJQGP3cx5A8
 wbpV5u6ZYTUORGVtRl5/dqScV2eBTaMRb3kxrqChmlxXNodswPUUqCnrcmPCTT442YmiumTSk
 fbIe6OjaETaR1SCjl5906xkOqFZMdMmqARZfW+BA0FQD/uOammi1v8/X3LJmh9BVnJ6wqLLGO
 iNJyTSSMDOVBGf9ZzQr/TBNFzb3uNED0U7G7YXdlM4rEi3SfrHnt3kW2sQogj75vXPqeSnpsa
 FGh6XHDx6CEBeAQU6fPJqZEH2MB9IxliFUTSyeebwHVmhkpvQmCOBbeAiprguIIt65qpttcDd
 BKoXoLV8zck2CYuibk0avSzRS+X80G21k5t3OhLP+fB5vOCqo8kBUlKK/VYzwpZkWDNNii3gY
 riicsA4jRltKklDJk5wcfmSLa40IhTSaH3kmEee0s7qh9WbDwVYd42Pc/CD1+3OUZuokZzCtc
 Ut2RD+wDEDhK9Pi1JV2WAlustbEiSRFZZGgjCXIzoyfHNKavLqawBFQB7sAaNi7gs49QXyDQ4
 7Vx+dPTITOmtB6tvG8GaE16aTsiuKDYaOEsiXkfefyZQ9Nv3hDMqByMr1VidqW2wV8w1mD2s3
 qAYiGCrnVJSxd2pAZjFiLo+MFdqYA2BvRdZQI/sEirgGmKoMLVgN1FRFONijP5pqxuM8PbOPO
 WH3AvHd4V4hwg9siUAs9GfPo3GeAqPFy4eZgavZRhlt3WiXSlb4Vb5TJZlEpJbC9n+tVl/K11
 M5cdtxBJkr3WceaX4o8ZZ8STEZ6SXpKv7GQ8eGhhdlgb9bVSV4ZQ/63zTAoOiODnMJogUTBSF
 on+gQa7LqBzFpGjmi0mOecB1sUQ7gAkKrOT88eVaapme3xAle7iO8D8e0iytkGgk2GQIwu5hA
 SYKp+n1NbFLGlHD5VDrSZwDwTyJ48DREKg0X3ddk2yIktxz8EyB+frkXXNO16EmpHBU4E4rGZ
 arkkuv9iClXgdgOMMX4WgAKV3hNUfEuuGMomXAaxF8d6MH2ejIBZtB9C/sIK2M2WZBKoUHzNR
 c3kzLNXDrrueOI=
X-Mailman-Approved-At: Thu, 20 Jan 2022 00:53:16 +0000
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

Bisected the error and found the first bad commit to be
d015e9861e55928a78137a2c95897bc50637fc47 is the first bad commit
commit d015e9861e55928a78137a2c95897bc50637fc47
Author: Jonathan Kim <jonathan.kim@amd.com>
Date:   Thu Dec 9 16:48:56 2021 -0500

    drm/amdgpu: improve debug VRAM access performance using sdma

    For better performance during VRAM access for debugged processes,
do
    read/write copies over SDMA.

    In order to fulfill post mortem debugging on a broken device,
fallback to
    stable MMIO access when gpu recovery is disabled or when job
submission
    time outs are set to max.  Failed SDMA access should automatically
fall
    back to MMIO access.

    Use a pre-allocated GTT bounce buffer pre-mapped into GART to avoid
    page-table updates and TLB flushes on access.

    Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
    Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 78
+++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  4 ++
 2 files changed, 82 insertions(+)


Am Donnerstag, dem 20.01.2022 um 00:22 +0100 schrieb Bert Karwatzki:
> Reverting commit 72f686438de13f121c52f58d7445570a33dfdc61 does not
> change the errors:
> [=C2=A0=C2=A0=C2=A0 1.310550] ------------[ cut here ]------------
> [=C2=A0=C2=A0=C2=A0 1.310551] trying to bind memory to uninitialized GAR=
T !
> [=C2=A0=C2=A0=C2=A0 1.310556] WARNING: CPU: 9 PID: 252 at
> drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:254
> amdgpu_gart_bind+0x2e/0x40
> [amdgpu]
> [=C2=A0=C2=A0=C2=A0 1.310659] Modules linked in: amdgpu(+) gpu_sched i2c=
_algo_bit
> drm_ttm_helper hid_sensor_hub ttm hid_generic nvme drm_kms_helper
> nvme_core cec xhci_pci t10_pi r8169 rc_core crc32_pclmul crc_t10dif
> i2c_hid_acpi realtek xhci_hcd psmouse crc32c_intel crct10dif_generic
> i2c_hid amd_sfh mdio_devres crct10dif_pclmul drm i2c_piix4 usbcore
> libphy crct10dif_common wmi button battery video fjes(-) hid
> [=C2=A0=C2=A0=C2=A0 1.310672] CPU: 9 PID: 252 Comm: systemd-udevd Not ta=
inted
> 5.13.0+
> #4
> [=C2=A0=C2=A0=C2=A0 1.310673] Hardware name: Micro-Star International Co=
., Ltd.
> Alpha
> 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
> [=C2=A0=C2=A0=C2=A0 1.310674] RIP: 0010:amdgpu_gart_bind+0x2e/0x40 [amdg=
pu]
> [=C2=A0=C2=A0=C2=A0 1.310762] Code: 00 80 bf 34 25 00 00 00 74 14 4c 8b =
8f 20 25 00
> 00
> 4d 85 c9 74 05 e9 01 ff ff ff 31 c0 c3 48 c7 c7 68 36 dd c0 e8 86 db
> 19
> e8 <0f> 0b b8 ea ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
> 00
> [=C2=A0=C2=A0=C2=A0 1.310763] RSP: 0018:ffffb19d00c33920 EFLAGS: 0001028=
2
> [=C2=A0=C2=A0=C2=A0 1.310764] RAX: 0000000000000000 RBX: 000000000000006=
7 RCX:
> ffffffffa9abb208
> [=C2=A0=C2=A0=C2=A0 1.310765] RDX: 0000000000000000 RSI: 00000000ffffeff=
f RDI:
> ffffffffa9a63200
> [=C2=A0=C2=A0=C2=A0 1.310766] RBP: ffff985ce2a796c0 R08: 000000000000000=
0 R09:
> ffffb19d00c33748
> [=C2=A0=C2=A0=C2=A0 1.310766] R10: ffffb19d00c33740 R11: ffffffffa9ad324=
8 R12:
> 0000000000000000
> [=C2=A0=C2=A0=C2=A0 1.310766] R13: ffff985cd45a0000 R14: ffff985cd45a000=
0 R15:
> 0000000000000000
> [=C2=A0=C2=A0=C2=A0 1.310767] FS:=C2=A0 00007f69fabdc8c0(0000) GS:ffff98=
5f9e640000(0000)
> knlGS:0000000000000000
> [=C2=A0=C2=A0=C2=A0 1.310768] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033
> [=C2=A0=C2=A0=C2=A0 1.310768] CR2: 00007f69fabc5dca CR3: 00000001139ec00=
0 CR4:
> 0000000000750ee0
> [=C2=A0=C2=A0=C2=A0 1.310769] PKRU: 55555554
> [=C2=A0=C2=A0=C2=A0 1.310770] Call Trace:
> [=C2=A0=C2=A0=C2=A0 1.310772]=C2=A0 amdgpu_ttm_gart_bind+0x79/0xc0 [amdg=
pu]
> [=C2=A0=C2=A0=C2=A0 1.310858]=C2=A0 amdgpu_ttm_alloc_gart+0x146/0x1a0 [a=
mdgpu]
> [=C2=A0=C2=A0=C2=A0 1.310942]=C2=A0 amdgpu_bo_create_reserved.part.0+0xf=
8/0x1b0 [amdgpu]
> [=C2=A0=C2=A0=C2=A0 1.311025]=C2=A0 ? amdgpu_ttm_debugfs_init+0x110/0x11=
0 [amdgpu]
> [=C2=A0=C2=A0=C2=A0 1.311145]=C2=A0 amdgpu_bo_create_kernel+0x3b/0xa0 [a=
mdgpu]
> [=C2=A0=C2=A0=C2=A0 1.311229]=C2=A0 amdgpu_ttm_init.cold+0x165/0x17f [am=
dgpu]
> [=C2=A0=C2=A0=C2=A0 1.311349]=C2=A0 gmc_v10_0_sw_init+0x2dc/0x430 [amdgp=
u]
> [=C2=A0=C2=A0=C2=A0 1.311455]=C2=A0 amdgpu_device_init.cold+0x1544/0x1b5=
4 [amdgpu]
> [=C2=A0=C2=A0=C2=A0 1.311570]=C2=A0 ? acpi_ns_get_node+0x4f/0x5a
> [=C2=A0=C2=A0=C2=A0 1.311574]=C2=A0 ? acpi_get_handle+0x8e/0xb7
> [=C2=A0=C2=A0=C2=A0 1.311576]=C2=A0 amdgpu_driver_load_kms+0x67/0x320 [a=
mdgpu]
> [=C2=A0=C2=A0=C2=A0 1.311664]=C2=A0 amdgpu_pci_probe+0x1bc/0x290 [amdgpu=
]
> [=C2=A0=C2=A0=C2=A0 1.311750]=C2=A0 local_pci_probe+0x42/0x80
> [=C2=A0=C2=A0=C2=A0 1.311753]=C2=A0 ? __cond_resched+0x16/0x40
> [=C2=A0=C2=A0=C2=A0 1.311755]=C2=A0 pci_device_probe+0xfd/0x1b0
> [=C2=A0=C2=A0=C2=A0 1.311756]=C2=A0 really_probe+0xf2/0x460
> [=C2=A0=C2=A0=C2=A0 1.311759]=C2=A0 driver_probe_device+0xe8/0x160
> [=C2=A0=C2=A0=C2=A0 1.311760]=C2=A0 device_driver_attach+0xa1/0xb0
> [=C2=A0=C2=A0=C2=A0 1.311761]=C2=A0 __driver_attach+0x8f/0x150
> [=C2=A0=C2=A0=C2=A0 1.311763]=C2=A0 ? device_driver_attach+0xb0/0xb0
> [=C2=A0=C2=A0=C2=A0 1.311764]=C2=A0 ? device_driver_attach+0xb0/0xb0
> [=C2=A0=C2=A0=C2=A0 1.311765]=C2=A0 bus_for_each_dev+0x78/0xc0
> [=C2=A0=C2=A0=C2=A0 1.311766]=C2=A0 bus_add_driver+0x12b/0x1e0
> [=C2=A0=C2=A0=C2=A0 1.311768]=C2=A0 driver_register+0x8f/0xe0
> [=C2=A0=C2=A0=C2=A0 1.311769]=C2=A0 ? 0xffffffffc1828000
> [=C2=A0=C2=A0=C2=A0 1.311770]=C2=A0 do_one_initcall+0x44/0x1d0
> [=C2=A0=C2=A0=C2=A0 1.311772]=C2=A0 ? kmem_cache_alloc_trace+0x103/0x240
> [=C2=A0=C2=A0=C2=A0 1.311775]=C2=A0 do_init_module+0x5c/0x270
> [=C2=A0=C2=A0=C2=A0 1.311777]=C2=A0 __do_sys_finit_module+0xb1/0x110
> [=C2=A0=C2=A0=C2=A0 1.311779]=C2=A0 do_syscall_64+0x40/0xb0
> [=C2=A0=C2=A0=C2=A0 1.311781]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/=
0xae
> [=C2=A0=C2=A0=C2=A0 1.311783] RIP: 0033:0x7f69fb094679
> [=C2=A0=C2=A0=C2=A0 1.311785] Code: 48 8d 3d 9a a1 0c 00 0f 05 eb a5 66 =
0f 1f 44 00
> 00
> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08
> 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64 89 01
> 48
> [=C2=A0=C2=A0=C2=A0 1.311786] RSP: 002b:00007ffce4131708 EFLAGS: 0000024=
6 ORIG_RAX:
> 0000000000000139
> [=C2=A0=C2=A0=C2=A0 1.311788] RAX: ffffffffffffffda RBX: 000055d71350a3a=
0 RCX:
> 00007f69fb094679
> [=C2=A0=C2=A0=C2=A0 1.311788] RDX: 0000000000000000 RSI: 00007f69fb234ee=
d RDI:
> 0000000000000013
> [=C2=A0=C2=A0=C2=A0 1.311789] RBP: 0000000000020000 R08: 000000000000000=
0 R09:
> 000055d7134f3930
> [=C2=A0=C2=A0=C2=A0 1.311789] R10: 0000000000000013 R11: 000000000000024=
6 R12:
> 00007f69fb234eed
> [=C2=A0=C2=A0=C2=A0 1.311790] R13: 0000000000000000 R14: 000055d7134da0f=
0 R15:
> 000055d71350a3a0
> [=C2=A0=C2=A0=C2=A0 1.311791] ---[ end trace ff47998e3140e95d ]---
> [=C2=A0=C2=A0=C2=A0 1.311793] [drm:amdgpu_ttm_gart_bind [amdgpu]] *ERROR=
* failed to
> bind 1 pages at 0x00400000
> [=C2=A0=C2=A0=C2=A0 1.312100] amdgpu 0000:03:00.0: amdgpu: 00000000989bd=
fac bind
> failed
>
> and using https://patchwork.freedesktop.org/patch/469907/
> gives a this message:
>
> [=C2=A0=C2=A0=C2=A0 1.311502] ------------[ cut here ]------------
> [=C2=A0=C2=A0=C2=A0 1.311502] WARNING: CPU: 9 PID: 221 at
> drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:244
> amdgpu_gart_bind+0x16/0x20
> [amdgpu]
> [=C2=A0=C2=A0=C2=A0 1.311602] Modules linked in: amdgpu(+) gpu_sched i2c=
_algo_bit
> drm_ttm_helper hid_sensor_hub ttm hid_generic nvme xhci_pci
> drm_kms_helper nvme_core t10_pi xhci_hcd crc_t10dif r8169 cec
> crct10dif_generic i2c_hid_acpi amd_sfh rc_core crct10dif_pclmul
> realtek
> i2c_hid crc32_pclmul mdio_devres psmouse usbcore crc32c_intel drm
> libphy i2c_piix4 crct10dif_common button wmi battery video fjes(-)
> hid
> [=C2=A0=C2=A0=C2=A0 1.311614] CPU: 9 PID: 221 Comm: systemd-udevd Not ta=
inted
> 5.13.0+
> #6
> [=C2=A0=C2=A0=C2=A0 1.311616] Hardware name: Micro-Star International Co=
., Ltd.
> Alpha
> 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
> [=C2=A0=C2=A0=C2=A0 1.311617] RIP: 0010:amdgpu_gart_bind+0x16/0x20 [amdg=
pu]
> [=C2=A0=C2=A0=C2=A0 1.311701] Code: 39 df 74 aa eb dc e8 19 a2 f6 f0 66 =
0f 1f 84 00
> 00
> 00 00 00 0f 1f 44 00 00 4c 8b 8f 20 25 00 00 4d 85 c9 74 05 e9 3a ff
> ff
> ff <0f> 0b c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 fd 53 0f
> ae
> [=C2=A0=C2=A0=C2=A0 1.311702] RSP: 0018:ffffb5be80b17948 EFLAGS: 0001024=
6
> [=C2=A0=C2=A0=C2=A0 1.311703] RAX: 0000000000000022 RBX: ffff98670583e85=
8 RCX:
> ffff98677c8a8738
> [=C2=A0=C2=A0=C2=A0 1.311704] RDX: 0000000000000001 RSI: 000000000040000=
0 RDI:
> ffff986720ce0000
> [=C2=A0=C2=A0=C2=A0 1.311704] RBP: ffff986705841a08 R08: 000000000000006=
7 R09:
> 0000000000000000
> [=C2=A0=C2=A0=C2=A0 1.311705] R10: ffff986705841a08 R11: 000000000000040=
0 R12:
> 0000000000000000
> [=C2=A0=C2=A0=C2=A0 1.311705] R13: ffff98670dc50e40 R14: ffff986720ce000=
0 R15:
> 0000000000000000
> [=C2=A0=C2=A0=C2=A0 1.311706] FS:=C2=A0 00007ff4ee0968c0(0000) GS:ffff98=
69de840000(0000)
> knlGS:0000000000000000
> [=C2=A0=C2=A0=C2=A0 1.311707] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033
> [=C2=A0=C2=A0=C2=A0 1.311707] CR2: 00007ff4ee07fdca CR3: 000000017b43600=
0 CR4:
> 0000000000750ee0
> [=C2=A0=C2=A0=C2=A0 1.311708] PKRU: 55555554
> [=C2=A0=C2=A0=C2=A0 1.311708] Call Trace:
> [=C2=A0=C2=A0=C2=A0 1.311710]=C2=A0 amdgpu_ttm_alloc_gart+0x147/0x190 [a=
mdgpu]
> [=C2=A0=C2=A0=C2=A0 1.311793]=C2=A0 amdgpu_bo_create_reserved.part.0+0xf=
8/0x1b0 [amdgpu]
> [=C2=A0=C2=A0=C2=A0 1.311873]=C2=A0 ? amdgpu_ttm_debugfs_init+0x110/0x11=
0 [amdgpu]
> [=C2=A0=C2=A0=C2=A0 1.311952]=C2=A0 amdgpu_bo_create_kernel+0x3b/0xa0 [a=
mdgpu]
> [=C2=A0=C2=A0=C2=A0 1.312031]=C2=A0 amdgpu_ttm_init.cold+0x165/0x17f [am=
dgpu]
> [=C2=A0=C2=A0=C2=A0 1.312181]=C2=A0 gmc_v10_0_sw_init+0x2dc/0x430 [amdgp=
u]
> [=C2=A0=C2=A0=C2=A0 1.312275]=C2=A0 amdgpu_device_init.cold+0x1544/0x1b5=
4 [amdgpu]
> [=C2=A0=C2=A0=C2=A0 1.312385]=C2=A0 ? acpi_ns_get_node+0x4f/0x5a
> [=C2=A0=C2=A0=C2=A0 1.312388]=C2=A0 ? acpi_get_handle+0x8e/0xb7
> [=C2=A0=C2=A0=C2=A0 1.312390]=C2=A0 amdgpu_driver_load_kms+0x67/0x320 [a=
mdgpu]
> [=C2=A0=C2=A0=C2=A0 1.312479]=C2=A0 amdgpu_pci_probe+0x1bc/0x290 [amdgpu=
]
> [=C2=A0=C2=A0=C2=A0 1.312573]=C2=A0 local_pci_probe+0x42/0x80
> [=C2=A0=C2=A0=C2=A0 1.312578]=C2=A0 ? __cond_resched+0x16/0x40
> [=C2=A0=C2=A0=C2=A0 1.312581]=C2=A0 pci_device_probe+0xfd/0x1b0
> [=C2=A0=C2=A0=C2=A0 1.312583]=C2=A0 really_probe+0xf2/0x460
> [=C2=A0=C2=A0=C2=A0 1.312587]=C2=A0 driver_probe_device+0xe8/0x160
> [=C2=A0=C2=A0=C2=A0 1.312589]=C2=A0 device_driver_attach+0xa1/0xb0
> [=C2=A0=C2=A0=C2=A0 1.312591]=C2=A0 __driver_attach+0x8f/0x150
> [=C2=A0=C2=A0=C2=A0 1.312592]=C2=A0 ? device_driver_attach+0xb0/0xb0
> [=C2=A0=C2=A0=C2=A0 1.312593]=C2=A0 ? device_driver_attach+0xb0/0xb0
> [=C2=A0=C2=A0=C2=A0 1.312594]=C2=A0 bus_for_each_dev+0x78/0xc0
> [=C2=A0=C2=A0=C2=A0 1.312595]=C2=A0 bus_add_driver+0x12b/0x1e0
> [=C2=A0=C2=A0=C2=A0 1.312597]=C2=A0 driver_register+0x8f/0xe0
> [=C2=A0=C2=A0=C2=A0 1.312598]=C2=A0 ? 0xffffffffc1696000
> [=C2=A0=C2=A0=C2=A0 1.312599]=C2=A0 do_one_initcall+0x44/0x1d0
> [=C2=A0=C2=A0=C2=A0 1.312602]=C2=A0 ? kmem_cache_alloc_trace+0x103/0x240
> [=C2=A0=C2=A0=C2=A0 1.312604]=C2=A0 do_init_module+0x5c/0x270
> [=C2=A0=C2=A0=C2=A0 1.312606]=C2=A0 __do_sys_finit_module+0xb1/0x110
> [=C2=A0=C2=A0=C2=A0 1.312608]=C2=A0 do_syscall_64+0x40/0xb0
> [=C2=A0=C2=A0=C2=A0 1.312610]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/=
0xae
> [=C2=A0=C2=A0=C2=A0 1.312614] RIP: 0033:0x7ff4ee54e679
> [=C2=A0=C2=A0=C2=A0 1.312616] Code: 48 8d 3d 9a a1 0c 00 0f 05 eb a5 66 =
0f 1f 44 00
> 00
> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08
> 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64 89 01
> 48
> [=C2=A0=C2=A0=C2=A0 1.312617] RSP: 002b:00007fff9c9d5bc8 EFLAGS: 0000024=
6 ORIG_RAX:
> 0000000000000139
> [=C2=A0=C2=A0=C2=A0 1.312618] RAX: ffffffffffffffda RBX: 000055aca9cf923=
0 RCX:
> 00007ff4ee54e679
> [=C2=A0=C2=A0=C2=A0 1.312619] RDX: 0000000000000000 RSI: 00007ff4ee6eeee=
d RDI:
> 0000000000000013
> [=C2=A0=C2=A0=C2=A0 1.312619] RBP: 0000000000020000 R08: 000000000000000=
0 R09:
> 000055aca9cdf480
> [=C2=A0=C2=A0=C2=A0 1.312620] R10: 0000000000000013 R11: 000000000000024=
6 R12:
> 00007ff4ee6eeeed
> [=C2=A0=C2=A0=C2=A0 1.312620] R13: 0000000000000000 R14: 000055aca9cf9ab=
0 R15:
> 000055aca9cf9230
> [=C2=A0=C2=A0=C2=A0 1.312622] ---[ end trace c4fc99f16e2a1eb7 ]---
>
> In both cases there's a similar error message for the oth GPU in the
> system (the integrated one at 08:00.0)
>
> Am Mittwoch, dem 19.01.2022 um 23:40 +0100 schrieb Das, Nirmoy:
> >
> > On 1/19/2022 10:59 PM, Limonciello, Mario wrote:
> > > [Public]
> > >
> > > > -----Original Message-----
> > > > From: Bert Karwatzki <spasswolf@web.de>
> > > > Sent: Wednesday, January 19, 2022 15:52
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Kazlauskas,
> > > > Nicholas
> > > > <Nicholas.Kazlauskas@amd.com>; Zhuo, Qingqing (Lillian)
> > > > <Qingqing.Zhuo@amd.com>; Scott Bruce <smbruce@gmail.com>; Alex
> > > > Deucher
> > > > <alexdeucher@gmail.com>; Chris Hixon
> > > > <linux-kernel-bugs@hixontech.com>
> > > > Subject: amd-staging-drm-next breaks suspend
> > > >
> > > > I just tested drm-staging-drm-next with HEAD
> > > > f1b2924ee6929cb431440e6f961f06eb65d52beb:
> > > > Going into suspend leads to a hang again:
> > > > This is probably caused by
> > > > [ 1.310551] trying to bind memory to uninitialized GART !
> > > > and/or
> > > > [ 3.976438] trying to bind memory to uninitialized GART !
> >
> >
> > Could you please also try
> > https://patchwork.freedesktop.org/patch/469907/=C2=A0?
> >
> >
> > Regards,
> >
> > Nirmoy
> >
> > > >


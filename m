Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACDFF99359
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 08:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0DC10EFF1;
	Thu, 23 Apr 2026 08:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="bqQYdI7d";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DC310E16A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1776893264; x=1777152464;
 bh=hNuKgalmnoGfnIXopd2mRVdLZ+BpFCeJ4dh9y0wW2pE=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=bqQYdI7d8dFMSQQIInef6ujtBuqj1acLRbAVNyHfCINRlxAX1ulJpJZh7eNzwbbG+
 LWjn0SkXQw5eW/g/aBBjsgA4xSnNsrXAM8fLxRnzuU9iV75oE2vbN5foTjAw1YzHa5
 KDXhEld6xaejNKqJ+L8LtrtJxsomz5k5kOr7UC2RoUeKXCKULRklvGpI5MDVJJIjWQ
 kvhzvVGP7Uct9uAiNghKW6ZJFUzwXP/tMuFtDeMd/NXf+SgT+aOAvaNGIOf63E2N8G
 91KUtkRadZAub3O1+cIztqHcxuqP7+RtB7ltbL+dUgBWl7hQebA9Sa19Vqwwx37jH7
 CYKBZmCVMzFpg==
Date: Wed, 22 Apr 2026 21:27:38 +0000
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Kostadin Shishmanov <kostadinshishmanov@protonmail.com>
Subject: BUG: sleeping function called from invalid context at
 ./include/linux/sched/mm.h:323 during DC initialization
Message-ID: <7t2m9N9vWRP5ulx1qQDLmZlw1qIep3cLDd54ZVPDBxsEeUtWX1r4VTsKCbz1QbZEjw0jbsT3cmgfwv1D1XtZtyikC9qlvLmj6KBkjuFsy3s=@protonmail.com>
Feedback-ID: 25269289:user:proton
X-Pm-Message-ID: d1d42383f0a200c0ecbd58778ed5d76cb5dbc169
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 23 Apr 2026 08:52:16 +0000
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

It only seems to show up if CONFIG_DEBUG_ATOMIC_SLEEP is enabled, but thoug=
ht I should report it anyway. The kernel is built from drm-next today.

The trace disappears if I boot with nomodeset or amdgpu.dc=3D0

[    7.167550] amdgpu 0000:03:00.0: STB initialized to 2048 entries
[    7.167693] amdgpu 0000:03:00.0: [drm] Loading DMUB firmware via PSP: ve=
rsion=3D0x02020021
[    7.167987] amdgpu 0000:03:00.0: [drm] use_doorbell being set to: [true]
[    7.168002] amdgpu 0000:03:00.0: [drm] use_doorbell being set to: [true]
[    7.168015] amdgpu 0000:03:00.0: [drm] use_doorbell being set to: [true]
[    7.168027] amdgpu 0000:03:00.0: [drm] use_doorbell being set to: [true]
[    7.168045] amdgpu 0000:03:00.0: [VCN instance 0] Found VCN firmware Ver=
sion ENC: 1.33 DEC: 4 VEP: 0 Revision: 14
[    7.168142] amdgpu 0000:03:00.0: [VCN instance 1] Found VCN firmware Ver=
sion ENC: 1.33 DEC: 4 VEP: 0 Revision: 14
[    7.233699] amdgpu 0000:03:00.0: reserve 0xa00000 from 0x83fd000000 for =
PSP TMR
[    7.376763] amdgpu 0000:03:00.0: SECUREDISPLAY: optional securedisplay t=
a ucode is not available
[    7.376807] amdgpu 0000:03:00.0: smu driver if version =3D 0x00000040, s=
mu fw if version =3D 0x00000041, smu fw program =3D 0, smu fw version =3D 0=
x003a5b00 (58.91.0)
[    7.376837] amdgpu 0000:03:00.0: use vbios provided pptable
[    7.451657] amdgpu 0000:03:00.0: SMU is initialized successfully!
[    7.451766] BUG: sleeping function called from invalid context at ./incl=
ude/linux/sched/mm.h:323
[    7.451776] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 327, =
name: (udev-worker)
[    7.451783] preempt_count: 201, expected: 0
[    7.451786] RCU nest depth: 0, expected: 0
[    7.451789] 1 lock held by (udev-worker)/327:
[    7.451790]  #0: ffff8c7bc1eb4200 (&dev->mutex){....}-{4:4}, at: __drive=
r_attach+0xb5/0x200
[    7.451797] CPU: 8 UID: 0 PID: 327 Comm: (udev-worker) Not tainted 7.0.0=
-rc7 #1 PREEMPT(full)  3ea630ac936a7123d6bffb42972bc5d75ccd9b07
[    7.451799] Hardware name: ASRock B650M-HDV/M.2/B650M-HDV/M.2, BIOS 4.10=
 02/09/2026
[    7.451799] Call Trace:
[    7.451800]  <TASK>
[    7.451801]  dump_stack_lvl+0x59/0x80
[    7.451803]  ? dcn30_clock_source_create+0x34/0xb0 [amdgpu 2841543364449=
4137702b25fd9f49d37d365a3cc]
[    7.452023]  __might_resched.cold+0xec/0xfe
[    7.452025]  __kmalloc_cache_noprof+0x3a9/0x6e0
[    7.452029]  dcn30_clock_source_create+0x34/0xb0 [amdgpu 284154336444941=
37702b25fd9f49d37d365a3cc]
[    7.452193]  dcn30_create_resource_pool+0x2ea/0x17f0 [amdgpu 28415433644=
494137702b25fd9f49d37d365a3cc]
[    7.452317]  ? amdgpu_dm_init+0x510/0x510 [amdgpu 28415433644494137702b2=
5fd9f49d37d365a3cc]
[    7.452492]  dc_create_resource_pool+0x166/0x210 [amdgpu 284154336444941=
37702b25fd9f49d37d365a3cc]
[    7.452683]  dc_create+0x1e1/0x670 [amdgpu 28415433644494137702b25fd9f49=
d37d365a3cc]
[    7.452846]  amdgpu_dm_init+0x305/0x510 [amdgpu 28415433644494137702b25f=
d9f49d37d365a3cc]
[    7.453008]  ? __irq_work_queue_local+0x4e/0x150
[    7.453010]  ? console_unlock+0x94/0x120
[    7.453012]  ? irq_work_queue+0x29/0x50
[    7.453013]  ? __wake_up_klogd+0x4e/0x70
[    7.453014]  ? vprintk_emit+0x260/0x340
[    7.453019]  ? amdgpu_dm_init+0x510/0x510 [amdgpu 28415433644494137702b2=
5fd9f49d37d365a3cc]
[    7.453145]  dm_hw_init+0x17/0x80 [amdgpu 28415433644494137702b25fd9f49d=
37d365a3cc]
[    7.453258]  amdgpu_device_init.cold+0x13dc/0x2072 [amdgpu 2841543364449=
4137702b25fd9f49d37d365a3cc]
[    7.453445]  ? pci_bus_read_config_word+0x42/0x70
[    7.453448]  amdgpu_driver_load_kms+0x15/0x80 [amdgpu 284154336444941377=
02b25fd9f49d37d365a3cc]
[    7.453577]  amdgpu_pci_probe+0x231/0x540 [amdgpu 28415433644494137702b2=
5fd9f49d37d365a3cc]
[    7.453688]  ? _raw_spin_unlock_irqrestore+0x3c/0x50
[    7.453691]  local_pci_probe+0x39/0x80
[    7.453694]  pci_call_probe+0x56/0x300
[    7.453696]  ? _raw_spin_unlock+0x1f/0x40
[    7.453697]  ? pci_match_device+0xf9/0x120
[    7.453699]  pci_device_probe+0x91/0x130
[    7.453701]  really_probe+0xd5/0x370
[    7.453702]  __driver_probe_device+0x78/0x140
[    7.453703]  driver_probe_device+0x1f/0xa0
[    7.453704]  ? __device_attach_driver+0x110/0x110
[    7.453705]  __driver_attach+0xc0/0x200
[    7.453706]  bus_for_each_dev+0x81/0xd0
[    7.453708]  bus_add_driver+0x113/0x200
[    7.453709]  ? crc16+0x1000/0x1000 [crc16 23fab5f78db1f9f2d12b1a145d6cfe=
f916d4b62e]
[    7.453710]  driver_register+0x71/0xd0
[    7.453711]  ? __pci_register_driver+0x58/0x80
[    7.453712]  do_one_initcall+0x68/0x3d0
[    7.453715]  do_init_module+0x62/0x230
[    7.453717]  __do_sys_init_module+0x192/0x1c0
[    7.453719]  do_syscall_64+0xe2/0x950
[    7.453721]  ? trace_hardirqs_off+0x46/0xf0
[    7.453722]  ? trace_hardirqs_on_prepare+0xd0/0xf0
[    7.453723]  ? lockdep_hardirqs_on_prepare+0xcf/0x160
[    7.453725]  ? irqentry_exit+0xf2/0x780
[    7.453727]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[    7.453727] RIP: 0033:0x7f0f3c94afba
[    7.453729] Code: 48 8b 0d 41 9e 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 af 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0e 9e 0d 00 f7 d8 64 89 01 48
[    7.453729] RSP: 002b:00007fffaca4d538 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000af
[    7.453730] RAX: ffffffffffffffda RBX: 000055a774508700 RCX: 00007f0f3c9=
4afba
[    7.453731] RDX: 00007f0f3d1344ce RSI: 000000001a2330d0 RDI: 00007f0f171=
cc010
[    7.453731] RBP: 00007fffaca4d5d0 R08: 00007f0f171cc010 R09: 000055a7745=
70530
[    7.453732] R10: 00007f0f3c946087 R11: 0000000000000246 R12: 00007f0f3d1=
344ce
[    7.453732] R13: 000055a77440a4d0 R14: 0000000000000000 R15: 00000000000=
00000
[    7.453734]  </TASK>
[    7.453893] amdgpu 0000:03:00.0: [drm] Display Core v3.2.378 initialized=
 on DCN 3.0

Regards,
Kostadin

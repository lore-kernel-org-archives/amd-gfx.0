Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46832C7115A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 02:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D70E010E3D3;
	Thu, 19 Jun 2025 02:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FbgV/Wml";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A05A10E3D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 02:26:47 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-312a806f002so37653a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 19:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750300007; x=1750904807; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7TCWM7xpT6Ugz+mcI7j3wjQNyxlnBvy5MP/no8q7XU=;
 b=FbgV/WmlzB7WOgls0XRYU4+w+TxzIh6UguZUnM8xkTAH8wt1BTxPRO02zadkb7/Tea
 etj8ifjH7F1PkU1HxPsc2j56bx5FDT0cez4Z43VxiDt/1UkMZI2DGI8gNZUpOA9L18s7
 3pHMxhhz5tECOf+Y+kgI3SfyacXMkzxge1khZvEJG6b5xMNAdSOEsdN1LE5VK3SPNeRb
 tSqrQUEjs0o5TstandkCNF5aMQPnZ/xzGUr+vZMo+TDkLkaEhgYU46LszhyW2hkPCj+3
 yEXNvz5Qp0A+gIKvzfO9necxec5tmww5A9zccJ/gYn5hfnbXpVErJLLUdteyy1JZTdGh
 6ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750300007; x=1750904807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7TCWM7xpT6Ugz+mcI7j3wjQNyxlnBvy5MP/no8q7XU=;
 b=OUmuI3se8ZmgBU1A3rzyZckgWrM+wr+8n1UtT02cYU3XXZ9y313M+1zW8YlsccQ9K4
 EE/XpSo/rvHGdIw/Do6uXbDfRT8HA7LgyVm9rG5b7hBbuVLpqykS91k3oVrSOWrBnj/K
 NuHksT1lQz4J3yzMdIqEB+fHiWWh3FJzk7PVwbLkJmbMlngASOFxRWbLpKSm89nG/6h9
 8lPVjedNp7/34cEzm7KXDM1hV4li2X49ix1Izfs6+6DER3Udx+7sprEC6P7o5AMSj+S0
 /EwBBJzsqbXwlhrb4xMTueibaSA4Xup26BE3kaJ8BcavxA3XHAhYwJPulI4kr4HRM+/f
 fmSg==
X-Gm-Message-State: AOJu0Yy/i+InRrKSYxtsswC7JPwXF+XsOsSLhy8x3YPGtKiIbSd2ndDB
 EhZLV+gomYx2TkY2GqV7YYUwu5XlIoWLSGUsS/8Djt6AXKrkiJz6ihhLDxohB1jS10OLXIDiPDF
 QJp8XCvUDqpEBWfjEUNRakNXvdJKgvfk=
X-Gm-Gg: ASbGnct+ll47Z2fRG1gHSo4ACizIVVZLAswYEOZJ4Z575QM6/TGiECYKDMFiLtobHR2
 pAY6gjphfGj49SdSlR17SBS9tPbzMFVzNtTl5/Bfss2G9tP6FoCvWZxT/k+2UyjC6BH9PX6E19R
 QH3A+asqWXZUO1JLfhmuFe/mEBh/gIsfrXjtdCYCqrwx0p
X-Google-Smtp-Source: AGHT+IGh7KBubVHSB4EkN5Bq5MCqSD/jNQ5QF6NzW8ERrcfHjHOxa42J289hHp1EOPXv9OB2vKjR2HtSxOCEYy+Cch8=
X-Received: by 2002:a17:90b:5251:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-3158c10362dmr784638a91.8.1750300006560; Wed, 18 Jun 2025
 19:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250619013206.123183-1-vitaly.prosyak@amd.com>
In-Reply-To: <20250619013206.123183-1-vitaly.prosyak@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Jun 2025 22:26:34 -0400
X-Gm-Features: AX0GCFuwqFSAO1otcYWEBHFpbAGOx1tXWgey_NnHtu8095eyU8yHKJqDThQhAXY
Message-ID: <CADnq5_NKTTXcEuZANmsS=E6gcLeX11P5CMT5bQnF0p-5XaLqYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix slab-use-after-free in
 amdgpu_userq_mgr_fini+0x70c
To: vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, 
 Arvind Yadav <arvind.yadav@amd.com>
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

On Wed, Jun 18, 2025 at 9:32=E2=80=AFPM <vitaly.prosyak@amd.com> wrote:
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> The issue was reproduced on NV10 using IGT pci_unplug test.
> It is expected that `amdgpu_driver_postclose_kms()` is called prior to `a=
mdgpu_drm_release()`.
> However, the bug is that `amdgpu_fpriv` was freed in `amdgpu_driver_postc=
lose_kms()`, and then
> later accessed in `amdgpu_drm_release()` via a call to `amdgpu_userq_mgr_=
fini()`.
> As a result, KASAN detected a use-after-free condition, as shown in the l=
og below.
> The proposed fix is to move the calls to `amdgpu_eviction_fence_destroy()=
` and
> `amdgpu_userq_mgr_fini()` into `amdgpu_driver_postclose_kms()`, so they a=
re invoked before
> `amdgpu_fpriv` is freed.
>
> This also ensures symmetry with the initialization path in `amdgpu_driver=
_open_kms()`,
> where the following components are initialized:
> - `amdgpu_userq_mgr_init()`
> - `amdgpu_eviction_fence_init()`
> - `amdgpu_ctx_mgr_init()`
>
> Correspondingly, in `amdgpu_driver_postclose_kms()` we should clean up us=
ing:
> - `amdgpu_userq_mgr_fini()`
> - `amdgpu_eviction_fence_destroy()`
> - `amdgpu_ctx_mgr_fini()`
>
> This change eliminates the use-after-free and improves consistency in res=
ource management between open and close paths.
>
> [  +0.094367] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  +0.000026] BUG: KASAN: slab-use-after-free in amdgpu_userq_mgr_fini+0x=
70c/0x730 [amdgpu]
> [  +0.000866] Write of size 8 at addr ffff88811c068c60 by task amd_pci_un=
plug/1737
> [  +0.000026] CPU: 3 UID: 0 PID: 1737 Comm: amd_pci_unplug Not tainted 6.=
14.0+ #2
> [  +0.000008] Hardware name: ASUS System Product Name/ROG STRIX B550-F GA=
MING (WI-FI), BIOS 1401 12/03/2020
> [  +0.000004] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000003]  dump_stack_lvl+0x76/0xa0
> [  +0.000010]  print_report+0xce/0x600
> [  +0.000009]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
> [  +0.000790]  ? srso_return_thunk+0x5/0x5f
> [  +0.000007]  ? kasan_complete_mode_report_info+0x76/0x200
> [  +0.000008]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
> [  +0.000684]  kasan_report+0xbe/0x110
> [  +0.000007]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
> [  +0.000601]  __asan_report_store8_noabort+0x17/0x30
> [  +0.000007]  amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
> [  +0.000801]  ? __pfx_amdgpu_userq_mgr_fini+0x10/0x10 [amdgpu]
> [  +0.000819]  ? srso_return_thunk+0x5/0x5f
> [  +0.000008]  amdgpu_drm_release+0xa3/0xe0 [amdgpu]
> [  +0.000604]  __fput+0x354/0xa90
> [  +0.000010]  __fput_sync+0x59/0x80
> [  +0.000005]  __x64_sys_close+0x7d/0xe0
> [  +0.000006]  x64_sys_call+0x2505/0x26f0
> [  +0.000006]  do_syscall_64+0x7c/0x170
> [  +0.000004]  ? kasan_record_aux_stack+0xae/0xd0
> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? kmem_cache_free+0x398/0x580
> [  +0.000006]  ? __fput+0x543/0xa90
> [  +0.000006]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? __fput+0x543/0xa90
> [  +0.000004]  ? __kasan_check_read+0x11/0x20
> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? __kasan_check_read+0x11/0x20
> [  +0.000003]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? fpregs_assert_state_consistent+0x21/0xb0
> [  +0.000006]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? syscall_exit_to_user_mode+0x4e/0x240
> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? do_syscall_64+0x88/0x170
> [  +0.000003]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? do_syscall_64+0x88/0x170
> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? irqentry_exit+0x43/0x50
> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? exc_page_fault+0x7c/0x110
> [  +0.000006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000005] RIP: 0033:0x7ffff7b14f67
> [  +0.000005] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f=
 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <4=
8> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 ba f7 ff
> [  +0.000004] RSP: 002b:00007fffffffe358 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000003
> [  +0.000006] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffff7=
b14f67
> [  +0.000003] RDX: 0000000000000000 RSI: 00007ffff7f5755a RDI: 0000000000=
000003
> [  +0.000003] RBP: 00007fffffffe380 R08: 0000555555568170 R09: 0000000000=
000000
> [  +0.000003] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffff=
ffe5c8
> [  +0.000003] R13: 00005555555552a9 R14: 0000555555557d48 R15: 00007ffff7=
ffd040
> [  +0.000007]  </TASK>
>
> [  +0.000286] Allocated by task 425 on cpu 11 at 29.751192s:
> [  +0.000013]  kasan_save_stack+0x28/0x60
> [  +0.000008]  kasan_save_track+0x18/0x70
> [  +0.000006]  kasan_save_alloc_info+0x38/0x60
> [  +0.000006]  __kasan_kmalloc+0xc1/0xd0
> [  +0.000005]  __kmalloc_cache_noprof+0x1bd/0x430
> [  +0.000006]  amdgpu_driver_open_kms+0x172/0x760 [amdgpu]
> [  +0.000521]  drm_file_alloc+0x569/0x9a0
> [  +0.000008]  drm_client_init+0x1b7/0x410
> [  +0.000007]  drm_fbdev_client_setup+0x174/0x470
> [  +0.000007]  drm_client_setup+0x8a/0xf0
> [  +0.000006]  amdgpu_pci_probe+0x50b/0x10d0 [amdgpu]
> [  +0.000482]  local_pci_probe+0xe7/0x1b0
> [  +0.000008]  pci_device_probe+0x5bf/0x890
> [  +0.000005]  really_probe+0x1fd/0x950
> [  +0.000007]  __driver_probe_device+0x307/0x410
> [  +0.000005]  driver_probe_device+0x4e/0x150
> [  +0.000006]  __driver_attach+0x223/0x510
> [  +0.000005]  bus_for_each_dev+0x102/0x1a0
> [  +0.000006]  driver_attach+0x3d/0x60
> [  +0.000005]  bus_add_driver+0x309/0x650
> [  +0.000005]  driver_register+0x13d/0x490
> [  +0.000006]  __pci_register_driver+0x1ee/0x2b0
> [  +0.000006]  xfrm_ealg_get_byidx+0x43/0x50 [xfrm_algo]
> [  +0.000008]  do_one_initcall+0x9c/0x3e0
> [  +0.000007]  do_init_module+0x29e/0x7f0
> [  +0.000006]  load_module+0x5c75/0x7c80
> [  +0.000006]  init_module_from_file+0x106/0x180
> [  +0.000007]  idempotent_init_module+0x377/0x740
> [  +0.000006]  __x64_sys_finit_module+0xd7/0x180
> [  +0.000006]  x64_sys_call+0x1f0b/0x26f0
> [  +0.000006]  do_syscall_64+0x7c/0x170
> [  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> [  +0.000013] Freed by task 1737 on cpu 9 at 76.455063s:
> [  +0.000010]  kasan_save_stack+0x28/0x60
> [  +0.000006]  kasan_save_track+0x18/0x70
> [  +0.000005]  kasan_save_free_info+0x3b/0x60
> [  +0.000006]  __kasan_slab_free+0x54/0x80
> [  +0.000005]  kfree+0x127/0x470
> [  +0.000006]  amdgpu_driver_postclose_kms+0x455/0x760 [amdgpu]
> [  +0.000485]  drm_file_free.part.0+0x5b1/0xba0
> [  +0.000007]  drm_file_free+0x13/0x30
> [  +0.000006]  drm_client_release+0x1c4/0x2b0
> [  +0.000006]  drm_fbdev_ttm_fb_destroy+0xd2/0x120 [drm_ttm_helper]
> [  +0.000007]  put_fb_info+0x97/0xe0
> [  +0.000006]  unregister_framebuffer+0x197/0x380
> [  +0.000005]  drm_fb_helper_unregister_info+0x94/0x100
> [  +0.000005]  drm_fbdev_client_unregister+0x3c/0x80
> [  +0.000007]  drm_client_dev_unregister+0x144/0x330
> [  +0.000006]  drm_dev_unregister+0x49/0x1b0
> [  +0.000006]  drm_dev_unplug+0x4c/0xd0
> [  +0.000006]  amdgpu_pci_remove+0x58/0x130 [amdgpu]
> [  +0.000482]  pci_device_remove+0xae/0x1e0
> [  +0.000006]  device_remove+0xc7/0x180
> [  +0.000006]  device_release_driver_internal+0x3d4/0x5a0
> [  +0.000007]  device_release_driver+0x12/0x20
> [  +0.000006]  pci_stop_bus_device+0x104/0x150
> [  +0.000006]  pci_stop_and_remove_bus_device_locked+0x1b/0x40
> [  +0.000005]  remove_store+0xd7/0xf0
> [  +0.000007]  dev_attr_store+0x3f/0x80
> [  +0.000006]  sysfs_kf_write+0x125/0x1d0
> [  +0.000005]  kernfs_fop_write_iter+0x2ea/0x490
> [  +0.000007]  vfs_write+0x90d/0xe70
> [  +0.000006]  ksys_write+0x119/0x220
> [  +0.000006]  __x64_sys_write+0x72/0xc0
> [  +0.000006]  x64_sys_call+0x18ab/0x26f0
> [  +0.000005]  do_syscall_64+0x7c/0x170
> [  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> [  +0.000013] The buggy address belongs to the object at ffff88811c068000
>                which belongs to the cache kmalloc-rnd-01-4k of size 4096
> [  +0.000016] The buggy address is located 3168 bytes inside of
>                freed 4096-byte region [ffff88811c068000, ffff88811c069000=
)
>
> [  +0.000022] The buggy address belongs to the physical page:
> [  +0.000010] page: refcount:0 mapcount:0 mapping:0000000000000000 index:=
0xffff88811c06e000 pfn:0x11c068
> [  +0.000006] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:=
0 pincount:0
> [  +0.000006] flags: 0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=
=3D0x1fffff)
> [  +0.000007] page_type: f5(slab)
> [  +0.000007] raw: 0017ffffc0000040 ffff88810004c140 dead000000000122 000=
0000000000000
> [  +0.000005] raw: ffff88811c06e000 0000000080040002 00000000f5000000 000=
0000000000000
> [  +0.000006] head: 0017ffffc0000040 ffff88810004c140 dead000000000122 00=
00000000000000
> [  +0.000005] head: ffff88811c06e000 0000000080040002 00000000f5000000 00=
00000000000000
> [  +0.000006] head: 0017ffffc0000003 ffffea0004701a01 ffffffffffffffff 00=
00000000000000
> [  +0.000005] head: 0000000000000008 0000000000000000 00000000ffffffff 00=
00000000000000
> [  +0.000004] page dumped because: kasan: bad access detected
>
> [  +0.000011] Memory state around the buggy address:
> [  +0.000009]  ffff88811c068b00: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000012]  ffff88811c068b80: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000011] >ffff88811c068c00: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000011]                                                        ^
> [  +0.000010]  ffff88811c068c80: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000011]  ffff88811c068d00: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000011] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Jesse Zhang <Jesse.Zhang@amd.com>
> Cc: Arvind Yadav <arvind.yadav@amd.com>
>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 +++
>  2 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 7fd233f160bf..204178d949e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2914,16 +2914,10 @@ static int amdgpu_pmops_runtime_idle(struct devic=
e *dev)
>
>  static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>  {
> -       struct drm_file *file_priv =3D filp->private_data;
> -       struct amdgpu_fpriv *fpriv =3D file_priv->driver_priv;
> -
> -       if (fpriv) {
> -               fpriv->evf_mgr.fd_closing =3D true;
> -               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> -               amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> -       }
> +       int r;
>
> -       return drm_release(inode, filp);
> +       r =3D drm_release(inode, filp);
> +       return r;
>  }

You can just drop amdgpu_drm_release() altogether and just assign
drm_release() as the callback directly.

Alex

>
>  long amdgpu_drm_ioctl(struct file *filp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index d2ce7d86dbc8..195ed81d39ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1501,6 +1501,9 @@ void amdgpu_driver_postclose_kms(struct drm_device =
*dev,
>                 amdgpu_vm_bo_del(adev, fpriv->prt_va);
>                 amdgpu_bo_unreserve(pd);
>         }
> +       fpriv->evf_mgr.fd_closing =3D true;
> +       amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>
>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>         amdgpu_vm_fini(adev, &fpriv->vm);
> --
> 2.34.1
>

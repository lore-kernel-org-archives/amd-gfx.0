Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714D9C83038
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 17:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC03F10E09C;
	Wed,  2 Jul 2025 17:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XKDwd0j6";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D4B10E09C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 17:54:08 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-31384c8ba66so1272308a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jul 2025 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751478848; x=1752083648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMDaylWR1s3noDM5x5gqhX6AIcXqkuD2e22B+kXXfIw=;
 b=XKDwd0j6SeUcD0N2gsnisGXrNmbGJzR3Jhzyg5u2W3um327uZTm0ORk5wVzJoMkMyf
 s3fA+z8tEA9YCIqFWG7gGWMtSbtLuz8rQpo77b6NCyYj19zcjiSOfi2wAXnTm8ZXnotQ
 d5Ht9rBMyFmcOuJ25hIshKrn9ZVReFP7ugF3LmAY7Tjmpn+6F9ImmPJeWva0nKplfPt5
 mtGRZf3sKoCF2M8zkdVHxCBNpGftLQzNIcFNeKzeCPWlH4yZdEyhV72ZOzQNLS4yOBPd
 7SCzVfPIET6Q03AptuQLNCcEYpuKGoyZo6tb7UN0QFsqvVCCwGWhsFMBnMqHWhAH/Cg5
 VnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751478848; x=1752083648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMDaylWR1s3noDM5x5gqhX6AIcXqkuD2e22B+kXXfIw=;
 b=bb4jjWvCOu8+450ge36hCwVUqPTAIYP/uk9QflWQesZI3ZGTD5tkXJ58M7R+B6gAqY
 cuqLV9BLErnLrw4Kb9o2GestWMKPgA6C4VLmoDUNX18ZBZwSl0h7rhNVTf1USu08Hwek
 bEMwYHOKBSlg+GEVf3BHXmAN3FGhTm6bTsSDqHVAMYOhdLITa/9nydhqSOo7CPs905B9
 KJN+72Uqi47Akg8M5pMzEUCIEtU3A7vcctrG8WRCI/GFSYwj9RG/Y5Ly9Ifafs5O0l1/
 mRuFLaduktvJkWdhBcmyArplLpBzS8LxySu5dgyXe805GKah6O5L4+O8Ecevnx9zVeMN
 sdaA==
X-Gm-Message-State: AOJu0Yyyf8NdtWwzPKOft4hvkm5dJd8KieMDm58bKC4bNQZD7KHaJE8e
 Vlb92wzSMpbltzgGGEuI9E0NQjpr4kaJEQGKhz9H3SvwkVglecnlg00DF63cDzul5gT45dm2E1Y
 SM9PLvNSptBDl9XRVu1URMdwcDU5PR5ub9A==
X-Gm-Gg: ASbGncvYs6By7NoJ/+gXDOi0vrcpp55NsEKeqqR4aC0h3BqNUcxQIQnxTZTnhQq8/rf
 Ay4es48D/m6VGGiHrxpSnDnOVnyZgW3TL6Xg3kEgPc0soeKSb/zHsjtNgJ+cffgJQxh8QGDuT0Z
 g5zxu3o1PQXcAGBCh0qdr70BZmFPYHPvjkaC/oYLvqTfRE
X-Google-Smtp-Source: AGHT+IFC/ZyRYfChARQtYd/jnQGj3FEOfxUsClNO8wCtFFY42pFP2dlRRMB0++TRs4979+vmYdzSuGvX8jrII7VvDxI=
X-Received: by 2002:a17:90b:56cf:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-31a909d3b90mr2149312a91.0.1751478847523; Wed, 02 Jul 2025
 10:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250702171020.69028-1-vitaly.prosyak@amd.com>
 <20250702171020.69028-2-vitaly.prosyak@amd.com>
In-Reply-To: <20250702171020.69028-2-vitaly.prosyak@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Jul 2025 13:53:55 -0400
X-Gm-Features: Ac12FXxnFYRjkkS2YuqgOHSB6RJlDQ8rURfq6h9pjd1A37xtXL6parm1AmgrZso
Message-ID: <CADnq5_PwgfzhsNHsJrptmrW7QeQi4_oJTkT7cVD9KsRL42pd-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix use-after-free in
 amdgpu_userq_suspend+0x51a/0x5a0
To: vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Christian Koenig <christian.koenig@amd.com>
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

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jul 2, 2025 at 1:10=E2=80=AFPM <vitaly.prosyak@amd.com> wrote:
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> [  +0.000020] BUG: KASAN: slab-use-after-free in amdgpu_userq_suspend+0x5=
1a/0x5a0 [amdgpu]
> [  +0.000817] Read of size 8 at addr ffff88812eec8c58 by task amd_pci_unp=
lug/1733
>
> [  +0.000027] CPU: 10 UID: 0 PID: 1733 Comm: amd_pci_unplug Tainted: G   =
     W          6.14.0+ #2
> [  +0.000009] Tainted: [W]=3DWARN
> [  +0.000003] Hardware name: ASUS System Product Name/ROG STRIX B550-F GA=
MING (WI-FI), BIOS 1401 12/03/2020
> [  +0.000004] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000003]  dump_stack_lvl+0x76/0xa0
> [  +0.000011]  print_report+0xce/0x600
> [  +0.000009]  ? srso_return_thunk+0x5/0x5f
> [  +0.000006]  ? kasan_complete_mode_report_info+0x76/0x200
> [  +0.000007]  ? kasan_addr_to_slab+0xd/0xb0
> [  +0.000006]  ? amdgpu_userq_suspend+0x51a/0x5a0 [amdgpu]
> [  +0.000707]  kasan_report+0xbe/0x110
> [  +0.000006]  ? amdgpu_userq_suspend+0x51a/0x5a0 [amdgpu]
> [  +0.000541]  __asan_report_load8_noabort+0x14/0x30
> [  +0.000005]  amdgpu_userq_suspend+0x51a/0x5a0 [amdgpu]
> [  +0.000535]  ? stop_cpsch+0x396/0x600 [amdgpu]
> [  +0.000556]  ? stop_cpsch+0x429/0x600 [amdgpu]
> [  +0.000536]  ? __pfx_amdgpu_userq_suspend+0x10/0x10 [amdgpu]
> [  +0.000536]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? kgd2kfd_suspend+0x132/0x1d0 [amdgpu]
> [  +0.000542]  amdgpu_device_fini_hw+0x581/0xe90 [amdgpu]
> [  +0.000485]  ? down_write+0xbb/0x140
> [  +0.000007]  ? __mutex_unlock_slowpath.constprop.0+0x317/0x360
> [  +0.000005]  ? __pfx_amdgpu_device_fini_hw+0x10/0x10 [amdgpu]
> [  +0.000482]  ? __kasan_check_write+0x14/0x30
> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? up_write+0x55/0xb0
> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
> [  +0.000005]  ? blocking_notifier_chain_unregister+0x6c/0xc0
> [  +0.000008]  amdgpu_driver_unload_kms+0x69/0x90 [amdgpu]
> [  +0.000484]  amdgpu_pci_remove+0x93/0x130 [amdgpu]
> [  +0.000482]  pci_device_remove+0xae/0x1e0
> [  +0.000008]  device_remove+0xc7/0x180
> [  +0.000008]  device_release_driver_internal+0x3d4/0x5a0
> [  +0.000007]  device_release_driver+0x12/0x20
> [  +0.000004]  pci_stop_bus_device+0x104/0x150
> [  +0.000006]  pci_stop_and_remove_bus_device_locked+0x1b/0x40
> [  +0.000005]  remove_store+0xd7/0xf0
> [  +0.000005]  ? __pfx_remove_store+0x10/0x10
> [  +0.000006]  ? __pfx__copy_from_iter+0x10/0x10
> [  +0.000006]  ? __pfx_dev_attr_store+0x10/0x10
> [  +0.000006]  dev_attr_store+0x3f/0x80
> [  +0.000006]  sysfs_kf_write+0x125/0x1d0
> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
> [  +0.000005]  ? __kasan_check_write+0x14/0x30
> [  +0.000005]  kernfs_fop_write_iter+0x2ea/0x490
> [  +0.000005]  ? rw_verify_area+0x70/0x420
> [  +0.000005]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
> [  +0.000006]  vfs_write+0x90d/0xe70
> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
> [  +0.000005]  ? __pfx_vfs_write+0x10/0x10
> [  +0.000004]  ? local_clock+0x15/0x30
> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? __kasan_slab_free+0x5f/0x80
> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? __kasan_check_read+0x11/0x20
> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? fdget_pos+0x1d3/0x500
> [  +0.000007]  ksys_write+0x119/0x220
> [  +0.000005]  ? putname+0x1c/0x30
> [  +0.000006]  ? __pfx_ksys_write+0x10/0x10
> [  +0.000007]  __x64_sys_write+0x72/0xc0
> [  +0.000006]  x64_sys_call+0x18ab/0x26f0
> [  +0.000006]  do_syscall_64+0x7c/0x170
> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? __pfx___x64_sys_openat+0x10/0x10
> [  +0.000006]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? __kasan_check_read+0x11/0x20
> [  +0.000003]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? fpregs_assert_state_consistent+0x21/0xb0
> [  +0.000006]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? syscall_exit_to_user_mode+0x4e/0x240
> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? do_syscall_64+0x88/0x170
> [  +0.000003]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? irqentry_exit+0x43/0x50
> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? exc_page_fault+0x7c/0x110
> [  +0.000006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000006] RIP: 0033:0x7480c0b14887
> [  +0.000005] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f=
 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <4=
8> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [  +0.000005] RSP: 002b:00007fff142b0058 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000001
> [  +0.000006] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007480c0=
b14887
> [  +0.000003] RDX: 0000000000000001 RSI: 00007480c0e7365a RDI: 0000000000=
000004
> [  +0.000003] RBP: 00007fff142b0080 R08: 0000563b2e73c170 R09: 0000000000=
000000
> [  +0.000003] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff14=
2b02f8
> [  +0.000003] R13: 0000563b159a72a9 R14: 0000563b159a9d48 R15: 00007480c0=
f19040
> [  +0.000008]  </TASK>
>
> [  +0.000445] Allocated by task 427 on cpu 5 at 29.342331s:
> [  +0.000011]  kasan_save_stack+0x28/0x60
> [  +0.000006]  kasan_save_track+0x18/0x70
> [  +0.000006]  kasan_save_alloc_info+0x38/0x60
> [  +0.000005]  __kasan_kmalloc+0xc1/0xd0
> [  +0.000006]  __kmalloc_cache_noprof+0x1bd/0x430
> [  +0.000007]  amdgpu_driver_open_kms+0x172/0x760 [amdgpu]
> [  +0.000493]  drm_file_alloc+0x569/0x9a0
> [  +0.000007]  drm_client_init+0x1b7/0x410
> [  +0.000007]  drm_fbdev_client_setup+0x174/0x470
> [  +0.000006]  drm_client_setup+0x8a/0xf0
> [  +0.000006]  amdgpu_pci_probe+0x510/0x10c0 [amdgpu]
> [  +0.000483]  local_pci_probe+0xe7/0x1b0
> [  +0.000006]  pci_device_probe+0x5bf/0x890
> [  +0.000006]  really_probe+0x1fd/0x950
> [  +0.000005]  __driver_probe_device+0x307/0x410
> [  +0.000006]  driver_probe_device+0x4e/0x150
> [  +0.000005]  __driver_attach+0x223/0x510
> [  +0.000006]  bus_for_each_dev+0x102/0x1a0
> [  +0.000005]  driver_attach+0x3d/0x60
> [  +0.000006]  bus_add_driver+0x309/0x650
> [  +0.000005]  driver_register+0x13d/0x490
> [  +0.000006]  __pci_register_driver+0x1ee/0x2b0
> [  +0.000006]  rfcomm_dlc_clear_state+0x69/0x220 [rfcomm]
> [  +0.000011]  do_one_initcall+0x9c/0x3e0
> [  +0.000007]  do_init_module+0x29e/0x7f0
> [  +0.000006]  load_module+0x5c75/0x7c80
> [  +0.000006]  init_module_from_file+0x106/0x180
> [  +0.000006]  idempotent_init_module+0x377/0x740
> [  +0.000006]  __x64_sys_finit_module+0xd7/0x180
> [  +0.000006]  x64_sys_call+0x1f0b/0x26f0
> [  +0.000006]  do_syscall_64+0x7c/0x170
> [  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> [  +0.000013] Freed by task 1733 on cpu 5 at 59.907086s:
> [  +0.000011]  kasan_save_stack+0x28/0x60
> [  +0.000006]  kasan_save_track+0x18/0x70
> [  +0.000005]  kasan_save_free_info+0x3b/0x60
> [  +0.000005]  __kasan_slab_free+0x54/0x80
> [  +0.000006]  kfree+0x127/0x470
> [  +0.000006]  amdgpu_driver_postclose_kms+0x455/0x760 [amdgpu]
> [  +0.000493]  drm_file_free.part.0+0x5b1/0xba0
> [  +0.000006]  drm_file_free+0x13/0x30
> [  +0.000006]  drm_client_release+0x1c4/0x2b0
> [  +0.000006]  drm_fbdev_ttm_fb_destroy+0xd2/0x120 [drm_ttm_helper]
> [  +0.000007]  put_fb_info+0x97/0xe0
> [  +0.000007]  unregister_framebuffer+0x197/0x380
> [  +0.000005]  drm_fb_helper_unregister_info+0x94/0x100
> [  +0.000005]  drm_fbdev_client_unregister+0x3c/0x80
> [  +0.000007]  drm_client_dev_unregister+0x144/0x330
> [  +0.000006]  drm_dev_unregister+0x49/0x1b0
> [  +0.000006]  drm_dev_unplug+0x4c/0xd0
> [  +0.000006]  amdgpu_pci_remove+0x58/0x130 [amdgpu]
> [  +0.000484]  pci_device_remove+0xae/0x1e0
> [  +0.000008]  device_remove+0xc7/0x180
> [  +0.000007]  device_release_driver_internal+0x3d4/0x5a0
> [  +0.000006]  device_release_driver+0x12/0x20
> [  +0.000007]  pci_stop_bus_device+0x104/0x150
> [  +0.000006]  pci_stop_and_remove_bus_device_locked+0x1b/0x40
> [  +0.000006]  remove_store+0xd7/0xf0
> [  +0.000006]  dev_attr_store+0x3f/0x80
> [  +0.000005]  sysfs_kf_write+0x125/0x1d0
> [  +0.000006]  kernfs_fop_write_iter+0x2ea/0x490
> [  +0.000006]  vfs_write+0x90d/0xe70
> [  +0.000006]  ksys_write+0x119/0x220
> [  +0.000006]  __x64_sys_write+0x72/0xc0
> [  +0.000006]  x64_sys_call+0x18ab/0x26f0
> [  +0.000005]  do_syscall_64+0x7c/0x170
> [  +0.000006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> [  +0.000012] The buggy address belongs to the object at ffff88812eec8000
>                which belongs to the cache kmalloc-rnd-07-4k of size 4096
> [  +0.000016] The buggy address is located 3160 bytes inside of
>                freed 4096-byte region [ffff88812eec8000, ffff88812eec9000=
)
>
> [  +0.000023] The buggy address belongs to the physical page:
> [  +0.000009] page: refcount:0 mapcount:0 mapping:0000000000000000 index:=
0x0 pfn:0x12eec8
> [  +0.000007] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:=
0 pincount:0
> [  +0.000005] flags: 0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=
=3D0x1fffff)
> [  +0.000007] page_type: f5(slab)
> [  +0.000008] raw: 0017ffffc0000040 ffff888100054500 dead000000000122 000=
0000000000000
> [  +0.000005] raw: 0000000000000000 0000000080040004 00000000f5000000 000=
0000000000000
> [  +0.000006] head: 0017ffffc0000040 ffff888100054500 dead000000000122 00=
00000000000000
> [  +0.000005] head: 0000000000000000 0000000080040004 00000000f5000000 00=
00000000000000
> [  +0.000006] head: 0017ffffc0000003 ffffea0004bbb201 ffffffffffffffff 00=
00000000000000
> [  +0.000005] head: 0000000000000008 0000000000000000 00000000ffffffff 00=
00000000000000
> [  +0.000005] page dumped because: kasan: bad access detected
>
> [  +0.000010] Memory state around the buggy address:
> [  +0.000009]  ffff88812eec8b00: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000012]  ffff88812eec8b80: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000011] >ffff88812eec8c00: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000011]                                                     ^
> [  +0.000010]  ffff88812eec8c80: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000011]  ffff88812eec8d00: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000011] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The use-after-free occurs because a delayed work item (`suspend_work`) ma=
y still
> be pending or running when resources it accesses are freed during device =
removal
> or file close. The previous code used `flush_work(&fpriv->evf_mgr.suspend=
_work.work)`,
> which does not wait for delayed work that has not yet started. As a resul=
t, the
> delayed work could run after its memory was freed, causing a use-after-fr=
ee.
> By switching to `flush_delayed_work(&fpriv->evf_mgr.suspend_work)`, we en=
sure that
> the kernel waits for both queued and delayed work to finish before
> freeing memory, closing this race.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 295e7186e156..aac0de86f3e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -664,7 +664,7 @@ static void amdgpu_userq_restore_worker(struct work_s=
truct *work)
>         struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
>         int ret;
>
> -       flush_work(&fpriv->evf_mgr.suspend_work.work);
> +       flush_delayed_work(&fpriv->evf_mgr.suspend_work);
>
>         mutex_lock(&uq_mgr->userq_mutex);
>
> --
> 2.34.1
>

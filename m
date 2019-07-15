From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: HMM related use-after-free with amdgpu
Date: Mon, 15 Jul 2019 18:51:06 +0200
Message-ID: <9a38f48b-3974-a238-5987-5251c1343f6b@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------D00F9BFE900E91BE33215F33"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-CA
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>

This is a multi-part message in MIME format.
--------------D00F9BFE900E91BE33215F33
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


With a KASAN enabled kernel built from amd-staging-drm-next, the
attached use-after-free is pretty reliably detected during a piglit gpu run.

Any ideas?


P.S. With my standard kernels without KASAN (currently 5.2.y + drm-next
changes for 5.3), I'm having trouble lately completing a piglit run,
running into various issues which look like memory corruption, so might
be related.

-- 
Earthling Michel Dänzer               |              https://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------D00F9BFE900E91BE33215F33
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kern.log"

Jul 15 18:09:29 kaveri kernel: [  560.388751][T12568] ==================================================================
Jul 15 18:09:29 kaveri kernel: [  560.389063][T12568] BUG: KASAN: use-after-free in __mmu_notifier_release+0x286/0x3e0
Jul 15 18:09:29 kaveri kernel: [  560.389068][T12568] Read of size 8 at addr ffff88835e1c7cb0 by task amd_pinned_memo/12568
Jul 15 18:09:29 kaveri kernel: [  560.389071][T12568] 
Jul 15 18:09:29 kaveri kernel: [  560.389077][T12568] CPU: 9 PID: 12568 Comm: amd_pinned_memo Tainted: G           OE     5.2.0-rc1-00811-g2ad5a7d31bdf #125
Jul 15 18:09:29 kaveri kernel: [  560.389080][T12568] Hardware name: Micro-Star International Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2017
Jul 15 18:09:29 kaveri kernel: [  560.389084][T12568] Call Trace:
Jul 15 18:09:29 kaveri kernel: [  560.389091][T12568]  dump_stack+0x7c/0xc0
Jul 15 18:09:29 kaveri kernel: [  560.389097][T12568]  ? __mmu_notifier_release+0x286/0x3e0
Jul 15 18:09:29 kaveri kernel: [  560.389101][T12568]  print_address_description+0x65/0x22e
Jul 15 18:09:29 kaveri kernel: [  560.389106][T12568]  ? __mmu_notifier_release+0x286/0x3e0
Jul 15 18:09:29 kaveri kernel: [  560.389110][T12568]  ? __mmu_notifier_release+0x286/0x3e0
Jul 15 18:09:29 kaveri kernel: [  560.389115][T12568]  __kasan_report.cold.3+0x1a/0x3d
Jul 15 18:09:29 kaveri kernel: [  560.389122][T12568]  ? __mmu_notifier_release+0x286/0x3e0
Jul 15 18:09:29 kaveri kernel: [  560.389128][T12568]  kasan_report+0xe/0x20
Jul 15 18:09:29 kaveri kernel: [  560.389132][T12568]  __mmu_notifier_release+0x286/0x3e0
Jul 15 18:09:29 kaveri kernel: [  560.389142][T12568]  exit_mmap+0x93/0x400
Jul 15 18:09:29 kaveri kernel: [  560.389146][T12568]  ? quarantine_put+0xb7/0x150
Jul 15 18:09:29 kaveri kernel: [  560.389151][T12568]  ? do_munmap+0x10/0x10
Jul 15 18:09:29 kaveri kernel: [  560.389156][T12568]  ? lockdep_hardirqs_on+0x37f/0x560
Jul 15 18:09:29 kaveri kernel: [  560.389165][T12568]  ? __khugepaged_exit+0x2af/0x3e0
Jul 15 18:09:29 kaveri kernel: [  560.389169][T12568]  ? __khugepaged_exit+0x2af/0x3e0
Jul 15 18:09:29 kaveri kernel: [  560.389174][T12568]  ? rcu_read_lock_sched_held+0xd8/0x110
Jul 15 18:09:29 kaveri kernel: [  560.389179][T12568]  ? kmem_cache_free+0x279/0x2c0
Jul 15 18:09:29 kaveri kernel: [  560.389185][T12568]  ? __khugepaged_exit+0x2be/0x3e0
Jul 15 18:09:29 kaveri kernel: [  560.389192][T12568]  mmput+0xb2/0x390
Jul 15 18:09:29 kaveri kernel: [  560.389199][T12568]  do_exit+0x880/0x2a70
Jul 15 18:09:29 kaveri kernel: [  560.389207][T12568]  ? find_held_lock+0x33/0x1c0
Jul 15 18:09:29 kaveri kernel: [  560.389213][T12568]  ? mm_update_next_owner+0x5d0/0x5d0
Jul 15 18:09:29 kaveri kernel: [  560.389218][T12568]  ? __do_page_fault+0x41d/0xa20
Jul 15 18:09:29 kaveri kernel: [  560.389226][T12568]  ? lock_downgrade+0x620/0x620
Jul 15 18:09:29 kaveri kernel: [  560.389232][T12568]  ? handle_mm_fault+0x4ab/0x6a0
Jul 15 18:09:29 kaveri kernel: [  560.389242][T12568]  do_group_exit+0xf0/0x2e0
Jul 15 18:09:29 kaveri kernel: [  560.389249][T12568]  __x64_sys_exit_group+0x3a/0x50
Jul 15 18:09:29 kaveri kernel: [  560.389255][T12568]  do_syscall_64+0x9c/0x430
Jul 15 18:09:29 kaveri kernel: [  560.389261][T12568]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
Jul 15 18:09:29 kaveri kernel: [  560.389266][T12568] RIP: 0033:0x7fc23d8ed9d6
Jul 15 18:09:29 kaveri kernel: [  560.389271][T12568] Code: 00 4c 8b 0d bc 44 0f 00 eb 19 66 2e 0f 1f 84 00 00 00 00 00 89 d7 89 f0 0f 05 48 3d 00 f0 ff ff 77 22 f4 89 d7 44 89 c0 0f 05 <48> 3d 00 f0 ff ff 76 e2 f7 d8 64 41 89 01 eb da 66 2e 0f 1f 84 00
Jul 15 18:09:29 kaveri kernel: [  560.389275][T12568] RSP: 002b:00007fff8c3bcfa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Jul 15 18:09:29 kaveri kernel: [  560.389280][T12568] RAX: ffffffffffffffda RBX: 00007fc23d9de760 RCX: 00007fc23d8ed9d6
Jul 15 18:09:29 kaveri kernel: [  560.389283][T12568] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
Jul 15 18:09:29 kaveri kernel: [  560.389287][T12568] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff48
Jul 15 18:09:29 kaveri kernel: [  560.389290][T12568] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc23d9de760
Jul 15 18:09:29 kaveri kernel: [  560.389293][T12568] R13: 00000000000004f0 R14: 00007fc23d9e7428 R15: 0000000000000000
Jul 15 18:09:29 kaveri kernel: [  560.389306][T12568] 
Jul 15 18:09:29 kaveri kernel: [  560.389309][T12568] Allocated by task 12568:
Jul 15 18:09:29 kaveri kernel: [  560.389314][T12568]  save_stack+0x19/0x80
Jul 15 18:09:29 kaveri kernel: [  560.389318][T12568]  __kasan_kmalloc.constprop.8+0xc1/0xd0
Jul 15 18:09:29 kaveri kernel: [  560.389323][T12568]  hmm_get_or_create+0x8f/0x3f0
Jul 15 18:09:29 kaveri kernel: [  560.389327][T12568]  hmm_mirror_register+0x58/0x240
Jul 15 18:09:29 kaveri kernel: [  560.389425][T12568]  amdgpu_mn_get+0x37b/0x6c0 [amdgpu]
Jul 15 18:09:29 kaveri kernel: [  560.389554][T12568]  amdgpu_mn_register+0xf6/0x710 [amdgpu]
Jul 15 18:09:29 kaveri kernel: [  560.389656][T12568]  amdgpu_gem_userptr_ioctl+0x6a3/0x8b0 [amdgpu]
Jul 15 18:09:29 kaveri kernel: [  560.389678][T12568]  drm_ioctl_kernel+0x1c9/0x260 [drm]
Jul 15 18:09:29 kaveri kernel: [  560.389701][T12568]  drm_ioctl+0x436/0x930 [drm]
Jul 15 18:09:29 kaveri kernel: [  560.389830][T12568]  amdgpu_drm_ioctl+0xd0/0x1b0 [amdgpu]
Jul 15 18:09:29 kaveri kernel: [  560.389836][T12568]  do_vfs_ioctl+0x193/0xfd0
Jul 15 18:09:29 kaveri kernel: [  560.389839][T12568]  ksys_ioctl+0x60/0x90
Jul 15 18:09:29 kaveri kernel: [  560.389843][T12568]  __x64_sys_ioctl+0x6f/0xb0
Jul 15 18:09:29 kaveri kernel: [  560.389847][T12568]  do_syscall_64+0x9c/0x430
Jul 15 18:09:29 kaveri kernel: [  560.389851][T12568]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
Jul 15 18:09:29 kaveri kernel: [  560.389853][T12568] 
Jul 15 18:09:29 kaveri kernel: [  560.389857][T12568] Freed by task 12568:
Jul 15 18:09:29 kaveri kernel: [  560.389860][T12568]  save_stack+0x19/0x80
Jul 15 18:09:29 kaveri kernel: [  560.389864][T12568]  __kasan_slab_free+0x125/0x170
Jul 15 18:09:29 kaveri kernel: [  560.389867][T12568]  kfree+0xe2/0x290
Jul 15 18:09:29 kaveri kernel: [  560.389871][T12568]  __mmu_notifier_release+0xef/0x3e0
Jul 15 18:09:29 kaveri kernel: [  560.389875][T12568]  exit_mmap+0x93/0x400
Jul 15 18:09:29 kaveri kernel: [  560.389879][T12568]  mmput+0xb2/0x390
Jul 15 18:09:29 kaveri kernel: [  560.389883][T12568]  do_exit+0x880/0x2a70
Jul 15 18:09:29 kaveri kernel: [  560.389886][T12568]  do_group_exit+0xf0/0x2e0
Jul 15 18:09:29 kaveri kernel: [  560.389890][T12568]  __x64_sys_exit_group+0x3a/0x50
Jul 15 18:09:29 kaveri kernel: [  560.389893][T12568]  do_syscall_64+0x9c/0x430
Jul 15 18:09:29 kaveri kernel: [  560.389897][T12568]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
Jul 15 18:09:29 kaveri kernel: [  560.389900][T12568] 
Jul 15 18:09:29 kaveri kernel: [  560.389903][T12568] The buggy address belongs to the object at ffff88835e1c7c00
Jul 15 18:09:29 kaveri kernel: [  560.389903][T12568]  which belongs to the cache kmalloc-512 of size 512
Jul 15 18:09:29 kaveri kernel: [  560.389908][T12568] The buggy address is located 176 bytes inside of
Jul 15 18:09:29 kaveri kernel: [  560.389908][T12568]  512-byte region [ffff88835e1c7c00, ffff88835e1c7e00)
Jul 15 18:09:29 kaveri kernel: [  560.389911][T12568] The buggy address belongs to the page:
Jul 15 18:09:29 kaveri kernel: [  560.389915][T12568] page:ffffea000d787100 refcount:1 mapcount:0 mapping:ffff88837d80ec00 index:0x0 compound_mapcount: 0
Jul 15 18:09:29 kaveri kernel: [  560.389921][T12568] flags: 0x17fffc000010200(slab|head)
Jul 15 18:09:29 kaveri kernel: [  560.389929][T12568] raw: 017fffc000010200 0000000000000000 0000000100000001 ffff88837d80ec00
Jul 15 18:09:29 kaveri kernel: [  560.389933][T12568] raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
Jul 15 18:09:29 kaveri kernel: [  560.389936][T12568] page dumped because: kasan: bad access detected
Jul 15 18:09:29 kaveri kernel: [  560.389939][T12568] 
Jul 15 18:09:29 kaveri kernel: [  560.389942][T12568] Memory state around the buggy address:
Jul 15 18:09:29 kaveri kernel: [  560.389946][T12568]  ffff88835e1c7b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Jul 15 18:09:29 kaveri kernel: [  560.389949][T12568]  ffff88835e1c7c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Jul 15 18:09:29 kaveri kernel: [  560.389953][T12568] >ffff88835e1c7c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Jul 15 18:09:29 kaveri kernel: [  560.389956][T12568]                                      ^
Jul 15 18:09:29 kaveri kernel: [  560.389960][T12568]  ffff88835e1c7d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Jul 15 18:09:29 kaveri kernel: [  560.389963][T12568]  ffff88835e1c7d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Jul 15 18:09:29 kaveri kernel: [  560.389966][T12568] ==================================================================

--------------D00F9BFE900E91BE33215F33
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--------------D00F9BFE900E91BE33215F33--

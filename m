From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: KASAN caught amdgpu / HMM use-after-free
Date: Wed, 27 Feb 2019 18:02:49 +0100
Message-ID: <e8466985-a66b-468b-5fff-6e743180da67@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F44DAA55B53BA30728B159A3"
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
To: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------F44DAA55B53BA30728B159A3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


See the attached dmesg excerpt. I've hit this a few times running piglit
with amd-staging-drm-next, first on February 22nd.

The memory was freed after calling hmm_mirror_unregister in
amdgpu_mn_destroy.


-- 
Earthling Michel Dänzer               |              https://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------F44DAA55B53BA30728B159A3
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kern.log"

Feb 27 16:58:54 kaveri kernel: [ 2184.979558] ==================================================================
Feb 27 16:58:54 kaveri kernel: [ 2184.979574] BUG: KASAN: use-after-free in __lock_acquire+0x3291/0x4650
Feb 27 16:58:54 kaveri kernel: [ 2184.979579] Read of size 8 at addr ffff8881c7179ed8 by task amd_pinned_memo/21960
Feb 27 16:58:54 kaveri kernel: [ 2184.979581] 
Feb 27 16:58:54 kaveri kernel: [ 2184.979587] CPU: 13 PID: 21960 Comm: amd_pinned_memo Tainted: G        W  OE     5.0.0-rc1-00409-gdbb4a1266c83-dirty #120
Feb 27 16:58:54 kaveri kernel: [ 2184.979591] Hardware name: Micro-Star International Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2017
Feb 27 16:58:54 kaveri kernel: [ 2184.979594] Call Trace:
Feb 27 16:58:54 kaveri kernel: [ 2184.979602]  dump_stack+0x7c/0xc0
Feb 27 16:58:54 kaveri kernel: [ 2184.979606]  ? __lock_acquire+0x3291/0x4650
Feb 27 16:58:54 kaveri kernel: [ 2184.979612]  print_address_description+0x65/0x22e
Feb 27 16:58:54 kaveri kernel: [ 2184.979616]  ? __lock_acquire+0x3291/0x4650
Feb 27 16:58:54 kaveri kernel: [ 2184.979619]  ? __lock_acquire+0x3291/0x4650
Feb 27 16:58:54 kaveri kernel: [ 2184.979623]  kasan_report.cold.3+0x1a/0x40
Feb 27 16:58:54 kaveri kernel: [ 2184.979628]  ? __lock_acquire+0x3291/0x4650
Feb 27 16:58:54 kaveri kernel: [ 2184.979632]  __lock_acquire+0x3291/0x4650
Feb 27 16:58:54 kaveri kernel: [ 2184.979636]  ? find_held_lock+0x33/0x1c0
Feb 27 16:58:54 kaveri kernel: [ 2184.979642]  ? finish_task_switch+0x12b/0x630
Feb 27 16:58:54 kaveri kernel: [ 2184.979647]  ? mark_held_locks+0x140/0x140
Feb 27 16:58:54 kaveri kernel: [ 2184.979651]  ? finish_task_switch+0xf4/0x630
Feb 27 16:58:54 kaveri kernel: [ 2184.979656]  ? _raw_spin_unlock_irq+0x29/0x30
Feb 27 16:58:54 kaveri kernel: [ 2184.979660]  ? lockdep_hardirqs_on+0x37c/0x560
Feb 27 16:58:54 kaveri kernel: [ 2184.979664]  ? finish_task_switch+0x191/0x630
Feb 27 16:58:54 kaveri kernel: [ 2184.979668]  ? __switch_to_asm+0x34/0x70
Feb 27 16:58:54 kaveri kernel: [ 2184.979671]  ? __switch_to_asm+0x40/0x70
Feb 27 16:58:54 kaveri kernel: [ 2184.979676]  ? __schedule+0x800/0x1cb0
Feb 27 16:58:54 kaveri kernel: [ 2184.979681]  lock_acquire+0x103/0x2c0
Feb 27 16:58:54 kaveri kernel: [ 2184.979687]  ? hmm_release+0x1c3/0x2d0
Feb 27 16:58:54 kaveri kernel: [ 2184.979692]  down_write+0x2b/0x80
Feb 27 16:58:54 kaveri kernel: [ 2184.979696]  ? hmm_release+0x1c3/0x2d0
Feb 27 16:58:54 kaveri kernel: [ 2184.979700]  hmm_release+0x1c3/0x2d0
Feb 27 16:58:54 kaveri kernel: [ 2184.979706]  ? uprobe_clear_state+0x5e/0x200
Feb 27 16:58:54 kaveri kernel: [ 2184.979711]  __mmu_notifier_release+0xef/0x3d0
Feb 27 16:58:54 kaveri kernel: [ 2184.979717]  exit_mmap+0x93/0x400
Feb 27 16:58:54 kaveri kernel: [ 2184.979720]  ? quarantine_put+0xb7/0x150
Feb 27 16:58:54 kaveri kernel: [ 2184.979724]  ? do_munmap+0x10/0x10
Feb 27 16:58:54 kaveri kernel: [ 2184.979727]  ? lockdep_hardirqs_on+0x37c/0x560
Feb 27 16:58:54 kaveri kernel: [ 2184.979732]  ? __khugepaged_exit+0x2af/0x3e0
Feb 27 16:58:54 kaveri kernel: [ 2184.979735]  ? __khugepaged_exit+0x2af/0x3e0
Feb 27 16:58:54 kaveri kernel: [ 2184.979738]  ? __khugepaged_exit+0x2af/0x3e0
Feb 27 16:58:54 kaveri kernel: [ 2184.979744]  ? rcu_read_lock_sched_held+0xd8/0x110
Feb 27 16:58:54 kaveri kernel: [ 2184.979748]  ? kmem_cache_free+0x27c/0x2c0
Feb 27 16:58:54 kaveri kernel: [ 2184.979751]  ? __khugepaged_exit+0x2be/0x3e0
Feb 27 16:58:54 kaveri kernel: [ 2184.979756]  mmput+0xb2/0x390
Feb 27 16:58:54 kaveri kernel: [ 2184.979760]  do_exit+0x899/0x2840
Feb 27 16:58:54 kaveri kernel: [ 2184.979765]  ? mm_update_next_owner+0x600/0x600
Feb 27 16:58:54 kaveri kernel: [ 2184.979770]  ? __do_page_fault+0x424/0x9e0
Feb 27 16:58:54 kaveri kernel: [ 2184.979774]  ? lock_downgrade+0x5d0/0x5d0
Feb 27 16:58:54 kaveri kernel: [ 2184.979778]  ? handle_mm_fault+0x4e7/0x750
Feb 27 16:58:54 kaveri kernel: [ 2184.979784]  do_group_exit+0xf0/0x2e0
Feb 27 16:58:54 kaveri kernel: [ 2184.979788]  __x64_sys_exit_group+0x3a/0x50
Feb 27 16:58:54 kaveri kernel: [ 2184.979793]  do_syscall_64+0x9c/0x3d0
Feb 27 16:58:54 kaveri kernel: [ 2184.979797]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
Feb 27 16:58:54 kaveri kernel: [ 2184.979802] RIP: 0033:0x7fcfc943bcf6
Feb 27 16:58:54 kaveri kernel: [ 2184.979806] Code: 00 4c 8b 0d 9c 41 0f 00 eb 19 66 2e 0f 1f 84 00 00 00 00 00 89 d7 89 f0 0f 05 48 3d 00 f0 ff ff 77 22 f4 89 d7 44 89 c0 0f 05 <48> 3d 00 f0 ff ff 76 e2 f7 d8 64 41 89 01 eb da 66 2e 0f 1f 84 00
Feb 27 16:58:54 kaveri kernel: [ 2184.979810] RSP: 002b:00007ffdb68de6e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Feb 27 16:58:54 kaveri kernel: [ 2184.979815] RAX: ffffffffffffffda RBX: 00007fcfc952c760 RCX: 00007fcfc943bcf6
Feb 27 16:58:54 kaveri kernel: [ 2184.979818] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
Feb 27 16:58:54 kaveri kernel: [ 2184.979821] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff48
Feb 27 16:58:54 kaveri kernel: [ 2184.979824] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcfc952c760
Feb 27 16:58:54 kaveri kernel: [ 2184.979827] R13: 00000000000004c5 R14: 00007fcfc9535428 R15: 0000000000000000
Feb 27 16:58:54 kaveri kernel: [ 2184.979832] 
Feb 27 16:58:54 kaveri kernel: [ 2184.979835] Allocated by task 21960:
Feb 27 16:58:54 kaveri kernel: [ 2184.979839]  kasan_kmalloc+0xc6/0xd0
Feb 27 16:58:54 kaveri kernel: [ 2184.979843]  hmm_register.part.12+0x48/0x2e0
Feb 27 16:58:54 kaveri kernel: [ 2184.979846]  hmm_mirror_register+0xf5/0x320
Feb 27 16:58:54 kaveri kernel: [ 2184.979948]  amdgpu_mn_get+0x37b/0x6c0 [amdgpu]
Feb 27 16:58:54 kaveri kernel: [ 2184.980040]  amdgpu_mn_register+0xf6/0x710 [amdgpu]
Feb 27 16:58:54 kaveri kernel: [ 2184.980126]  amdgpu_gem_userptr_ioctl+0x656/0x960 [amdgpu]
Feb 27 16:58:54 kaveri kernel: [ 2184.980146]  drm_ioctl_kernel+0x1c6/0x260 [drm]
Feb 27 16:58:54 kaveri kernel: [ 2184.980165]  drm_ioctl+0x42d/0x920 [drm]
Feb 27 16:58:54 kaveri kernel: [ 2184.980242]  amdgpu_drm_ioctl+0xd0/0x1b0 [amdgpu]
Feb 27 16:58:54 kaveri kernel: [ 2184.980246]  do_vfs_ioctl+0x193/0xfd0
Feb 27 16:58:54 kaveri kernel: [ 2184.980249]  ksys_ioctl+0x60/0x90
Feb 27 16:58:54 kaveri kernel: [ 2184.980252]  __x64_sys_ioctl+0x6f/0xb0
Feb 27 16:58:54 kaveri kernel: [ 2184.980255]  do_syscall_64+0x9c/0x3d0
Feb 27 16:58:54 kaveri kernel: [ 2184.980258]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
Feb 27 16:58:54 kaveri kernel: [ 2184.980260] 
Feb 27 16:58:54 kaveri kernel: [ 2184.980263] Freed by task 14381:
Feb 27 16:58:54 kaveri kernel: [ 2184.980266]  __kasan_slab_free+0x12a/0x170
Feb 27 16:58:54 kaveri kernel: [ 2184.980269]  kfree+0xe2/0x290
Feb 27 16:58:54 kaveri kernel: [ 2184.980368]  amdgpu_mn_destroy+0x2f0/0x440 [amdgpu]
Feb 27 16:58:54 kaveri kernel: [ 2184.980372]  process_one_work+0x815/0x1490
Feb 27 16:58:54 kaveri kernel: [ 2184.980375]  worker_thread+0x87/0xb10
Feb 27 16:58:54 kaveri kernel: [ 2184.980379]  kthread+0x2e2/0x3a0
Feb 27 16:58:54 kaveri kernel: [ 2184.980382]  ret_from_fork+0x27/0x50
Feb 27 16:58:54 kaveri kernel: [ 2184.980384] 
Feb 27 16:58:54 kaveri kernel: [ 2184.980387] The buggy address belongs to the object at ffff8881c7179e00
Feb 27 16:58:54 kaveri kernel: [ 2184.980387]  which belongs to the cache kmalloc-256 of size 256
Feb 27 16:58:54 kaveri kernel: [ 2184.980391] The buggy address is located 216 bytes inside of
Feb 27 16:58:54 kaveri kernel: [ 2184.980391]  256-byte region [ffff8881c7179e00, ffff8881c7179f00)
Feb 27 16:58:54 kaveri kernel: [ 2184.980394] The buggy address belongs to the page:
Feb 27 16:58:54 kaveri kernel: [ 2184.980397] page:ffffea00071c5e00 count:1 mapcount:0 mapping:ffff8883bd80ee00 index:0x0 compound_mapcount: 0
Feb 27 16:58:54 kaveri kernel: [ 2184.980403] flags: 0x17fffc000010200(slab|head)
Feb 27 16:58:54 kaveri kernel: [ 2184.980409] raw: 017fffc000010200 ffffea000a4f7900 0000000300000003 ffff8883bd80ee00
Feb 27 16:58:54 kaveri kernel: [ 2184.980413] raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
Feb 27 16:58:54 kaveri kernel: [ 2184.980416] page dumped because: kasan: bad access detected
Feb 27 16:58:54 kaveri kernel: [ 2184.980418] 
Feb 27 16:58:54 kaveri kernel: [ 2184.980420] Memory state around the buggy address:
Feb 27 16:58:54 kaveri kernel: [ 2184.980423]  ffff8881c7179d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
Feb 27 16:58:54 kaveri kernel: [ 2184.980426]  ffff8881c7179e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Feb 27 16:58:54 kaveri kernel: [ 2184.980429] >ffff8881c7179e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Feb 27 16:58:54 kaveri kernel: [ 2184.980432]                                                     ^
Feb 27 16:58:54 kaveri kernel: [ 2184.980435]  ffff8881c7179f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Feb 27 16:58:54 kaveri kernel: [ 2184.980438]  ffff8881c7179f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Feb 27 16:58:54 kaveri kernel: [ 2184.980440] ==================================================================

--------------F44DAA55B53BA30728B159A3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--------------F44DAA55B53BA30728B159A3--

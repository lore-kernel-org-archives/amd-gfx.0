From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: BUG: KASAN: use-after-free in amdgpu_job_free_cb
Date: Fri, 12 Jan 2018 10:20:49 -0500
Message-ID: <77f6ae06-988a-54c8-fa57-556df22cc202@amd.com>
References: <CAEzXK1p9b8vOPZ_ed-E6S+CDcpUStwPopHGzny7tN6pnzZdGEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------3B7F56A2A3B59FE683DAAE9E"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1p9b8vOPZ_ed-E6S+CDcpUStwPopHGzny7tN6pnzZdGEQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
To: =?UTF-8?Q?Lu=c3=ads_Mendes?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johannes Hirte <johannes.hirte-rSzmJuYucINa7YElYzY8/Q@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, sunpeng.li-5C7GfCeVMHo@public.gmane.org, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------3B7F56A2A3B59FE683DAAE9E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, looks to me  like a different issue (not related) then the one  
Johannes, reports, your issue was already reported by some one (can't 
remember the thread of hand) and looks like in shader hang or GPU 
scheduler synchronization issue while  Johannes's use after free is pure 
software logic issue in either KMS atomic framework or more probably in 
AMDGPU/DC (DAL).


Johanes, I attached a debug patch which forces the cursor update to wait 
for any  page flip in progress, can you give it a try and see if the 
issue is gone ? This is not an actual fix but just to evaluate the reason.


Thanks,

Andrey


On 01/12/2018 06:43 AM, Luís Mendes wrote:
> Hi Andrey, Johannes,
>
> Sorry for getting into this conversation, but I think I might have
> something related to this.
> I am getting GPU hangs playing some videos, both on ARMv7 and on x86,
> although with slightly different blocking paths. On ARMv7 it always
> blocks with amdgpu_dm_do_flip. I suspect the GPU hang, fence timeout,
> might also be caused by a kernel synchronization issue. I am using a
> single HDMI display and testing with VP9 videos on Kodi, but can also
> be triggered with youtube videos on firefox.
> Could this not exactly be a GPU hang, but rather a software lockup,
> that impedes the dma fence to be properly completed on the host side
> (due to a synchronization issue on the host side)?
> It is always related to the page flip and sometimes I get kernel
> messages after a while after the hang stating drm_flip_done timeout or
> similar.
>
> Kernel stack trace is always like:
> [   73.432967] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
> timeout, last signaled seq=4183, last emitted seq=4185
> [   73.443847] [drm] IP block:gmc_v8_0 is hung!
> [   73.443854] [drm] IP block:gfx_v8_0 is hung!
> [   73.444019] [drm] GPU recovery disabled.
> [  243.672640] INFO: task kworker/u4:3:89 blocked for more than 120
> seconds.
> [  243.679466]       Not tainted 4.15.0-rc4-drmnext2g #1
> [  243.685337] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  243.693200] kworker/u4:3    D    0    89      2 0x00000000
> [  243.693232] Workqueue: events_unbound commit_work [drm_kms_helper]
> [  243.693251] [<80b8c6d4>] (__schedule) from [<80b8cdd0>]
> (schedule+0x4c/0xac)
> [  243.693259] [<80b8cdd0>] (schedule) from [<80b91024>]
> (schedule_timeout+0x228/0x444)
> [  243.693270] [<80b91024>] (schedule_timeout) from [<80886738>]
> (dma_fence_default_wait+0x2b4/0x2d8)
> [  243.693276] [<80886738>] (dma_fence_default_wait) from [<80885d60>]
> (dma_fence_wait_timeout+0x40/0x150)
> [  243.693284] [<80885d60>] (dma_fence_wait_timeout) from [<80887b1c>]
> (reservation_object_wait_timeout_rcu+0xfc/0x34c)
> [  243.693509] [<80887b1c>] (reservation_object_wait_timeout_rcu) from
> [<7f331988>] (amdgpu_dm_do_flip+0xec/0x36c [amdgpu])
> [  243.693789] [<7f331988>] (amdgpu_dm_do_flip [amdgpu]) from
> [<7f33309c>] (amdgpu_dm_atomic_commit_tail+0xbfc/0xe58 [amdgpu])
> [  243.693941] [<7f33309c>] (amdgpu_dm_atomic_commit_tail [amdgpu])
> from [<7f15758c>] (commit_tail+0x50/0x94 [drm_kms_helper])
> [  243.693964] [<7f15758c>] (commit_tail [drm_kms_helper]) from
> [<7f1575ec>] (commit_work+0x1c/0x20 [drm_kms_helper])
> [  243.693981] [<7f1575ec>] (commit_work [drm_kms_helper]) from
> [<8016f4c8>] (process_one_work+0x1a8/0x4ac)
> [  243.693987] [<8016f4c8>] (process_one_work) from [<8017050c>]
> (worker_thread+0x68/0x598)
> [  243.693994] [<8017050c>] (worker_thread) from [<80175e50>]
> (kthread+0x16c/0x174)
> [  243.694003] [<80175e50>] (kthread) from [<80109de8>]
> (ret_from_fork+0x14/0x2c)
>
> Regards,
> Luís
>
>
>> Thanks for the dmesg, unfortunately nothing suspicious from there.
>>
>> Looking again at KASAN it hints at a race between cursor update and non
>> blocking part of flip with regard to accessing CRTC states, maybe cursor
>> update is not properly synchronized against a flip in flight on same CRTC...
>>
>> P.S What is your setup ? How many displays ?
>>
>>
>> Thanks,
>>
>> Andrey
>>
>>
>> Thanks,
>>
>> Andrey
>>
>> On 01/11/2018 05:55 PM, Johannes Hirte wrote:
>>> On 2018 Jan 10, Andrey Grodzovsky wrote:
>>>> Hi, is there a particular scenario when this happens ,
>>> Unfortunately no, I still search for a reproducer. Sometimes it takes
>>> several days until the next use-after-free.
>>>
>>>> can you add dmesg with echo 0x10 > /sys/module/drm/parameters/debug?
>>> I assume you want the debug output when a use-after-free happened. Here
>>> it is:
>>>
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_init] Allocated atomic state 00000000a67d7f62
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_plane_state] Added [PLANE:40:plane-4] 000000009b693a40 state to 00000000a67d7f62
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_crtc_state] Added [CRTC:41:crtc-0] 00000000fd68d0e6 state to 00000000a67d7f62
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_crtc_for_plane] Link plane state 000000009b693a40 to [CRTC:41:crtc-0]
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_fb_for_plane] Set [FB:48] for plane state 000000009b693a40
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_check_only] checking 00000000a67d7f62
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_commit] committing 00000000a67d7f62
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_default_clear] Clearing atomic state 00000000a67d7f62
>>> Jan 11 23:21:33 probook kernel: [drm:__drm_atomic_state_free] Freeing atomic state 00000000a67d7f62
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_init] Allocated atomic state 00000000aff36e64
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_plane_state] Added [PLANE:40:plane-4] 00000000bef4ac0a state to 00000000aff36e64
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_crtc_state] Added [CRTC:41:crtc-0] 00000000487e5e13 state to 00000000aff36e64
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_crtc_for_plane] Link plane state 00000000bef4ac0a to [CRTC:41:crtc-0]
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_fb_for_plane] Set [FB:48] for plane state 00000000bef4ac0a
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_check_only] checking 00000000aff36e64
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_commit] committing 00000000aff36e64
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_default_clear] Clearing atomic state 00000000aff36e64
>>> Jan 11 23:21:33 probook kernel: [drm:__drm_atomic_state_free] Freeing atomic state 00000000aff36e64
>>> Jan 11 23:21:33 probook kernel: ==================================================================
>>> Jan 11 23:21:33 probook kernel: BUG: KASAN: use-after-free in drm_atomic_helper_wait_for_flip_done+0x24f/0x270
>>> Jan 11 23:21:33 probook kernel: Read of size 8 at addr ffff8801e020d788 by task kworker/u8:6/18738
>>> Jan 11 23:21:33 probook kernel:
>>> Jan 11 23:21:33 probook kernel: CPU: 2 PID: 18738 Comm: kworker/u8:6 Not tainted 4.15.0-rc7-00001-gd24b113b5c00 #444
>>> Jan 11 23:21:33 probook kernel: Hardware name: HP HP ProBook 645 G2/80FE, BIOS N77 Ver. 01.10 10/12/2017
>>> Jan 11 23:21:33 probook kernel: Workqueue: events_unbound commit_work
>>> Jan 11 23:21:33 probook kernel: Call Trace:
>>> Jan 11 23:21:33 probook kernel:  dump_stack+0x99/0x11e
>>> Jan 11 23:21:33 probook kernel:  ? _atomic_dec_and_lock+0x152/0x152
>>> Jan 11 23:21:33 probook kernel:  print_address_description+0x65/0x270
>>> Jan 11 23:21:33 probook kernel:  kasan_report+0x272/0x360
>>> Jan 11 23:21:33 probook kernel:  ? drm_atomic_helper_wait_for_flip_done+0x24f/0x270
>>> Jan 11 23:21:33 probook kernel:  drm_atomic_helper_wait_for_flip_done+0x24f/0x270
>>> Jan 11 23:21:33 probook kernel:  amdgpu_dm_atomic_commit_tail+0x185e/0x2b90
>>> Jan 11 23:21:33 probook kernel:  ? dm_crtc_duplicate_state+0x130/0x130
>>> Jan 11 23:21:33 probook kernel:  ? drm_atomic_helper_wait_for_dependencies+0x3f2/0x800
>>> Jan 11 23:21:33 probook kernel:  commit_tail+0x92/0xe0
>>> Jan 11 23:21:33 probook kernel:  process_one_work+0x84b/0x1600
>>> Jan 11 23:21:33 probook kernel:  ? tick_nohz_dep_clear_signal+0x20/0x20
>>> Jan 11 23:21:33 probook kernel:  ? _raw_spin_unlock_irq+0xbe/0x120
>>> Jan 11 23:21:33 probook kernel:  ? _raw_spin_unlock+0x120/0x120
>>> Jan 11 23:21:33 probook kernel:  ? pwq_dec_nr_in_flight+0x3c0/0x3c0
>>> Jan 11 23:21:33 probook kernel:  ? arch_vtime_task_switch+0xee/0x190
>>> Jan 11 23:21:33 probook kernel:  ? finish_task_switch+0x27d/0x7f0
>>> Jan 11 23:21:33 probook kernel:  ? wq_worker_waking_up+0xc0/0xc0
>>> Jan 11 23:21:33 probook kernel:  ? copy_overflow+0x20/0x20
>>> Jan 11 23:21:33 probook kernel:  ? sched_clock_cpu+0x18/0x1e0
>>> Jan 11 23:21:33 probook kernel:  ? pci_mmcfg_check_reserved+0x100/0x100
>>> Jan 11 23:21:33 probook kernel:  ? preempt_schedule_irq+0x4e/0xb0
>>> Jan 11 23:21:33 probook kernel:  ? schedule+0xfb/0x3b0
>>> Jan 11 23:21:33 probook kernel:  ? __schedule+0x19b0/0x19b0
>>> Jan 11 23:21:33 probook kernel:  ? _raw_spin_unlock_irq+0xb9/0x120
>>> Jan 11 23:21:33 probook kernel:  ? _raw_spin_unlock_irq+0xbe/0x120
>>> Jan 11 23:21:33 probook kernel:  ? _raw_spin_unlock+0x120/0x120
>>> Jan 11 23:21:33 probook kernel:  worker_thread+0x211/0x1790
>>> Jan 11 23:21:33 probook kernel:  ? trace_event_raw_event_workqueue_work+0x170/0x170
>>> Jan 11 23:21:33 probook kernel:  ? vtime_guest_exit+0xe0/0xe0
>>> Jan 11 23:21:33 probook kernel:  ? tick_nohz_dep_clear_signal+0x20/0x20
>>> Jan 11 23:21:33 probook kernel:  ? _raw_spin_unlock_irq+0xbe/0x120
>>> Jan 11 23:21:33 probook kernel:  ? _raw_spin_unlock+0x120/0x120
>>> Jan 11 23:21:33 probook kernel:  ? finish_task_switch+0x27d/0x7f0
>>> Jan 11 23:21:33 probook kernel:  ? sched_clock_cpu+0x18/0x1e0
>>> Jan 11 23:21:33 probook kernel:  ? pci_mmcfg_check_reserved+0x100/0x100
>>> Jan 11 23:21:33 probook kernel:  ? pci_mmcfg_check_reserved+0x100/0x100
>>> Jan 11 23:21:33 probook kernel:  ? cyc2ns_read_end+0x20/0x20
>>> Jan 11 23:21:33 probook kernel:  ? schedule+0xfb/0x3b0
>>> Jan 11 23:21:33 probook kernel:  ? trace_event_raw_event_workqueue_work+0x170/0x170
>>> Jan 11 23:21:33 probook kernel:  ? __schedule+0x19b0/0x19b0
>>> Jan 11 23:21:33 probook kernel:  ? ___preempt_schedule+0x16/0x18
>>> Jan 11 23:21:33 probook kernel:  ? _raw_spin_unlock_irqrestore+0xfe/0x130
>>> Jan 11 23:21:33 probook kernel:  ? _raw_spin_unlock_irq+0x120/0x120
>>> Jan 11 23:21:33 probook kernel:  ? trace_event_raw_event_workqueue_work+0x170/0x170
>>> Jan 11 23:21:33 probook kernel:  kthread+0x2d4/0x390
>>> Jan 11 23:21:33 probook kernel:  ? kthread_create_worker+0xd0/0xd0
>>> Jan 11 23:21:33 probook kernel:  ret_from_fork+0x1f/0x30
>>> Jan 11 23:21:33 probook kernel:
>>> Jan 11 23:21:33 probook kernel: Allocated by task 2408:
>>> Jan 11 23:21:33 probook kernel:  kasan_kmalloc+0xa0/0xd0
>>> Jan 11 23:21:33 probook kernel:  kmem_cache_alloc_trace+0xd1/0x1e0
>>> Jan 11 23:21:33 probook kernel:  dm_crtc_duplicate_state+0x73/0x130
>>> Jan 11 23:21:33 probook kernel:  drm_atomic_get_crtc_state+0x13c/0x400
>>> Jan 11 23:21:33 probook kernel:  page_flip_common+0x52/0x230
>>> Jan 11 23:21:33 probook kernel:  drm_atomic_helper_page_flip+0xa1/0x100
>>> Jan 11 23:21:33 probook kernel:  drm_mode_page_flip_ioctl+0xc10/0x1030
>>> Jan 11 23:21:33 probook kernel:  drm_ioctl_kernel+0x1b5/0x2c0
>>> Jan 11 23:21:33 probook kernel:  drm_ioctl+0x709/0xa00
>>> Jan 11 23:21:33 probook kernel:  amdgpu_drm_ioctl+0x118/0x280
>>> Jan 11 23:21:33 probook kernel:  do_vfs_ioctl+0x18a/0x1260
>>> Jan 11 23:21:33 probook kernel:  SyS_ioctl+0x6f/0x80
>>> Jan 11 23:21:33 probook kernel:  do_syscall_64+0x220/0x670
>>> Jan 11 23:21:33 probook kernel:  return_from_SYSCALL_64+0x0/0x65
>>> Jan 11 23:21:33 probook kernel:
>>> Jan 11 23:21:33 probook kernel: Freed by task 2531:
>>> Jan 11 23:21:33 probook kernel:  kasan_slab_free+0x71/0xc0
>>> Jan 11 23:21:33 probook kernel:  kfree+0x88/0x1b0
>>> Jan 11 23:21:33 probook kernel:  drm_atomic_state_default_clear+0x2c8/0xa00
>>> Jan 11 23:21:33 probook kernel:  __drm_atomic_state_free+0x30/0xd0
>>> Jan 11 23:21:33 probook kernel:  drm_atomic_helper_update_plane+0xb6/0x350
>>> Jan 11 23:21:33 probook kernel:  __setplane_internal+0x5b4/0x9d0
>>> Jan 11 23:21:33 probook kernel:  drm_mode_cursor_universal+0x412/0xc60
>>> Jan 11 23:21:33 probook kernel:  drm_mode_cursor_common+0x4b6/0x890
>>> Jan 11 23:21:33 probook kernel:  drm_mode_cursor_ioctl+0xd3/0x120
>>> Jan 11 23:21:33 probook kernel:  drm_ioctl_kernel+0x1b5/0x2c0
>>> Jan 11 23:21:33 probook kernel:  drm_ioctl+0x709/0xa00
>>> Jan 11 23:21:33 probook kernel:  amdgpu_drm_ioctl+0x118/0x280
>>> Jan 11 23:21:33 probook kernel:  do_vfs_ioctl+0x18a/0x1260
>>> Jan 11 23:21:33 probook kernel:  SyS_ioctl+0x6f/0x80
>>> Jan 11 23:21:33 probook kernel:  do_syscall_64+0x220/0x670
>>> Jan 11 23:21:33 probook kernel:  return_from_SYSCALL_64+0x0/0x65
>>> Jan 11 23:21:33 probook kernel:
>>> Jan 11 23:21:33 probook kernel: The buggy address belongs to the object at ffff8801e020d580
>>> Jan 11 23:21:33 probook kernel: The buggy address is located 520 bytes inside of
>>> Jan 11 23:21:33 probook kernel: The buggy address belongs to the page:
>>> Jan 11 23:21:33 probook kernel: page:ffffea0007808200 count:1 mapcount:0 mapping:          >(null) index:0x0 compound_mapcount: 0
>>> Jan 11 23:21:33 probook kernel: flags: 0x2000000000008100(slab|head)
>>> Jan 11 23:21:33 probook kernel: raw: 2000000000008100 0000000000000000 0000000000000000 00000001001c001c
>>> Jan 11 23:21:33 probook kernel: raw: dead000000000100 dead000000000200 ffff8803f3002c40 0000000000000000
>>> Jan 11 23:21:33 probook kernel: page dumped because: kasan: bad access detected
>>> Jan 11 23:21:33 probook kernel:
>>> Jan 11 23:21:33 probook kernel: Memory state around the buggy address:
>>> Jan 11 23:21:33 probook kernel:  ffff8801e020d680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> Jan 11 23:21:33 probook kernel:  ffff8801e020d700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> Jan 11 23:21:33 probook kernel: >ffff8801e020d780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> Jan 11 23:21:33 probook kernel:                       ^
>>> Jan 11 23:21:33 probook kernel:  ffff8801e020d800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> Jan 11 23:21:33 probook kernel:  ffff8801e020d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> Jan 11 23:21:33 probook kernel: >==================================================================
>>> Jan 11 23:21:33 probook kernel: Disabling lock debugging due to kernel taint
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_init] Allocated atomic state 00000000c428f190
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_plane_state] Added [PLANE:40:plane-4] 00000000c33882cc state to 00000000c428f190
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_crtc_state] Added [CRTC:41:crtc-0] 0000000001d7e9fe state to 00000000c428f190
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_crtc_for_plane] Link plane state 00000000c33882cc to [CRTC:41:crtc-0]
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_fb_for_plane] Set [FB:48] for plane state 00000000c33882cc
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_check_only] checking 00000000c428f190
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_commit] committing 00000000c428f190
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_default_clear] Clearing atomic state 00000000c428f190
>>> Jan 11 23:21:33 probook kernel: [drm:__drm_atomic_state_free] Freeing atomic state 00000000c428f190
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_init] Allocated atomic state 000000008beb2208
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_plane_state] Added [PLANE:40:plane-4] 0000000021b4ca12 state to 000000008beb2208
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_crtc_state] Added [CRTC:41:crtc-0] 0000000005eaf319 state to 000000008beb2208
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_crtc_for_plane] Link plane state 0000000021b4ca12 to [CRTC:41:crtc-0]
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_fb_for_plane] Set [FB:48] for plane state 0000000021b4ca12
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_check_only] checking 000000008beb2208
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_commit] committing 000000008beb2208
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_default_clear] Clearing atomic state 000000008beb2208
>>> Jan 11 23:21:33 probook kernel: [drm:__drm_atomic_state_free] Freeing atomic state 000000008beb2208
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_default_clear] Clearing atomic state 000000005030c62c
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_init] Allocated atomic state 0000000004ea9707
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_plane_state] Added [PLANE:40:plane-4] 000000005e0d9d34 state to 0000000004ea9707
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_crtc_state] Added [CRTC:41:crtc-0] 00000000ca793baf state to 0000000004ea9707
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_crtc_for_plane] Link plane state 000000005e0d9d34 to [CRTC:41:crtc-0]
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_fb_for_plane] Set [FB:48] for plane state 000000005e0d9d34
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_check_only] checking 0000000004ea9707
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_commit] committing 0000000004ea9707
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_default_clear] Clearing atomic state 0000000004ea9707
>>> Jan 11 23:21:33 probook kernel: [drm:__drm_atomic_state_free] Freeing atomic state 0000000004ea9707
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_init] Allocated atomic state 00000000978683e0
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_plane_state] Added [PLANE:40:plane-4] 000000002a6fa7ba state to 00000000978683e0
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_crtc_state] Added [CRTC:41:crtc-0] 000000008cb98e24 state to 00000000978683e0
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_crtc_for_plane] Link plane state 000000002a6fa7ba to [CRTC:41:crtc-0]
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_fb_for_plane] Set [FB:48] for plane state 000000002a6fa7ba
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_check_only] checking 00000000978683e0
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_commit] committing 00000000978683e0
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_default_clear] Clearing atomic state 00000000978683e0
>>> Jan 11 23:21:33 probook kernel: [drm:__drm_atomic_state_free] Freeing atomic state 00000000978683e0
>>> Jan 11 23:21:33 probook kernel: [drm:__drm_atomic_state_free] Freeing atomic state 000000005030c62c
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_init] Allocated atomic state 00000000b8b1a194
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_plane_state] Added [PLANE:40:plane-4] 0000000062e99415 state to 00000000b8b1a194
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_get_crtc_state] Added [CRTC:41:crtc-0] 00000000460cd934 state to 00000000b8b1a194
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_crtc_for_plane] Link plane state 0000000062e99415 to [CRTC:41:crtc-0]
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_set_fb_for_plane] Set [FB:48] for plane state 0000000062e99415
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_check_only] checking 00000000b8b1a194
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_commit] committing 00000000b8b1a194
>>> Jan 11 23:21:33 probook kernel: [drm:drm_atomic_state_default_clear] Clearing atomic state 00000000b8b1a194
>>> Jan 11 23:21:33 probook kernel: [drm:__drm_atomic_state_free] Freeing atomic state 00000000b8b1a194
>>>


--------------3B7F56A2A3B59FE683DAAE9E
Content-Type: text/x-patch;
 name="force_cursor_update_wait_for_flip.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="force_cursor_update_wait_for_flip.patch"

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5a70682..323d020 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4908,7 +4908,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
         * synchronization events.
         */
 
-       if (lock_and_validation_needed) {
+       if (lock_and_validation_needed || state->legacy_cursor_update == true) {
 
                ret = do_aquire_global_lock(dev, state);
                if (ret)
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
index a1a751b..6d6ffdf 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c


--------------3B7F56A2A3B59FE683DAAE9E
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------3B7F56A2A3B59FE683DAAE9E--

From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: new KASAN running piglit
Date: Wed, 18 Jul 2018 18:44:05 +0200
Message-ID: <d14118e8-7f7c-147b-0727-a10c87b81e02@daenzer.net>
References: <2600416c-1f85-0d9d-06ad-a3d12e1fde70@amd.com>
 <1d0fd4a1-30c4-16cb-fe4f-10a20a8bfa6b@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------25B41F2DB08FB9DCBA8BC984"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1d0fd4a1-30c4-16cb-fe4f-10a20a8bfa6b-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------25B41F2DB08FB9DCBA8BC984
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2018-07-18 06:17 PM, Michel Dänzer wrote:
> On 2018-07-18 06:05 PM, Tom St Denis wrote:
>> Hi Christian,
>>
>> This patch:
>>
>> [root@raven linux]# git bisect bad
>> 90f362bdf0d0d06a126a5fd35b084436dd8250ad is the first bad commit
>> commit 90f362bdf0d0d06a126a5fd35b084436dd8250ad
>> Author: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>> Date:   Mon Jul 16 14:58:48 2018 +0200
>>
>>     drm/amdgpu: change ring priority after pushing the job
>>
>>     Pushing a job can change the ring assignment of an entity.
>>
>>     Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>     Reviewed-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
>>
>> :040000 040000 9a09d3e9d055e4f5024019861c334ee9cc0bd11b
>> 522540c31c3d1a4f4a6fbac75e985e9a7f7e93c9 M      drivers
>>
>> causes a KASAN while running piglit.  It's reproduceable 100% of the
>> time.  The commit before this doesn't not cause a KASAN.
> 
> I got the attached KASAN use-after-free report while running piglit
> today, could be the same?

Sorry, that was for a different issue. Here's the KASAN report.


Tom, what does the file command say about the amdgpu.ko file loaded on
your system?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------25B41F2DB08FB9DCBA8BC984
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Jul 18 18:02:46 kaveri kernel: [18273.337881] BUG: KASAN: use-after-free =
in amdgpu_cs_ioctl+0x48b2/0x4eb0 [amdgpu]
Jul 18 18:02:46 kaveri kernel: [18273.337889] Read of size 4 at addr ffff=
8801004b7aa4 by task shader_run:cs0/19401
Jul 18 18:02:46 kaveri kernel: [18273.337892]=20
Jul 18 18:02:46 kaveri kernel: [18273.337900] CPU: 9 PID: 19401 Comm: sha=
der_run:cs0 Tainted: G        W  OE     4.18.0-rc1+ #110
Jul 18 18:02:46 kaveri kernel: [18273.337905] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Jul 18 18:02:46 kaveri kernel: [18273.337909] Call Trace:
Jul 18 18:02:46 kaveri kernel: [18273.337920]  dump_stack+0x9a/0xeb
Jul 18 18:02:46 kaveri kernel: [18273.337928]  print_address_description+=
0x6a/0x270
Jul 18 18:02:46 kaveri kernel: [18273.337935]  kasan_report+0x258/0x380
Jul 18 18:02:46 kaveri kernel: [18273.338018]  ? amdgpu_cs_ioctl+0x48b2/0=
x4eb0 [amdgpu]
Jul 18 18:02:46 kaveri kernel: [18273.338098]  amdgpu_cs_ioctl+0x48b2/0x4=
eb0 [amdgpu]
Jul 18 18:02:46 kaveri kernel: [18273.338187]  ? amdgpu_bo_list_ioctl+0x2=
d1/0x3e0 [amdgpu]
Jul 18 18:02:46 kaveri kernel: [18273.338257]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Jul 18 18:02:46 kaveri kernel: [18273.338263]  ? do_vfs_ioctl+0x192/0xf30=

Jul 18 18:02:46 kaveri kernel: [18273.338267]  ? ksys_ioctl+0x70/0x80
Jul 18 18:02:46 kaveri kernel: [18273.338272]  ? __x64_sys_ioctl+0x6f/0xb=
0
Jul 18 18:02:46 kaveri kernel: [18273.338278]  ? do_syscall_64+0xa5/0x3f0=

Jul 18 18:02:46 kaveri kernel: [18273.338283]  ? entry_SYSCALL_64_after_h=
wframe+0x49/0xbe
Jul 18 18:02:46 kaveri kernel: [18273.338290]  ? idr_get_free+0x4bc/0x980=

Jul 18 18:02:46 kaveri kernel: [18273.338297]  ? __radix_tree_replace+0xa=
7/0x160
Jul 18 18:02:46 kaveri kernel: [18273.338325]  ? drm_dev_enter+0x5/0xe0 [=
drm]
Jul 18 18:02:46 kaveri kernel: [18273.338332]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jul 18 18:02:46 kaveri kernel: [18273.338337]  ? __fprop_inc_percpu_max+0=
x1d0/0x1d0
Jul 18 18:02:46 kaveri kernel: [18273.338438]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Jul 18 18:02:46 kaveri kernel: [18273.338463]  drm_ioctl_kernel+0x197/0x2=
20 [drm]
Jul 18 18:02:46 kaveri kernel: [18273.338484]  ? drm_setversion+0x7d0/0x7=
d0 [drm]
Jul 18 18:02:46 kaveri kernel: [18273.338493]  ? __check_object_size+0x14=
9/0x360
Jul 18 18:02:46 kaveri kernel: [18273.338515]  drm_ioctl+0x60a/0x970 [drm=
]
Jul 18 18:02:46 kaveri kernel: [18273.338597]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Jul 18 18:02:46 kaveri kernel: [18273.338623]  ? drm_ioctl_kernel+0x220/0=
x220 [drm]
Jul 18 18:02:46 kaveri kernel: [18273.338633]  ? lock_downgrade+0x5e0/0x5=
e0
Jul 18 18:02:46 kaveri kernel: [18273.338638]  ? __pm_runtime_resume+0x79=
/0x100
Jul 18 18:02:46 kaveri kernel: [18273.338644]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jul 18 18:02:46 kaveri kernel: [18273.338650]  ? do_raw_spin_unlock+0x54/=
0x220
Jul 18 18:02:46 kaveri kernel: [18273.338731]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Jul 18 18:02:46 kaveri kernel: [18273.338739]  do_vfs_ioctl+0x192/0xf30
Jul 18 18:02:46 kaveri kernel: [18273.338744]  ? lock_acquire+0x10b/0x330=

Jul 18 18:02:46 kaveri kernel: [18273.338749]  ? finish_task_switch+0xf1/=
0x670
Jul 18 18:02:46 kaveri kernel: [18273.338756]  ? ioctl_preallocate+0x1b0/=
0x1b0
Jul 18 18:02:46 kaveri kernel: [18273.338762]  ? __fget+0x1c8/0x300
Jul 18 18:02:46 kaveri kernel: [18273.338768]  ? lock_downgrade+0x5e0/0x5=
e0
Jul 18 18:02:46 kaveri kernel: [18273.338771]  ? __fget+0x49/0x300
Jul 18 18:02:46 kaveri kernel: [18273.338780]  ? __fget+0x1e0/0x300
Jul 18 18:02:46 kaveri kernel: [18273.338790]  ksys_ioctl+0x70/0x80
Jul 18 18:02:46 kaveri kernel: [18273.338797]  __x64_sys_ioctl+0x6f/0xb0
Jul 18 18:02:46 kaveri kernel: [18273.338802]  do_syscall_64+0xa5/0x3f0
Jul 18 18:02:46 kaveri kernel: [18273.338808]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Jul 18 18:02:46 kaveri kernel: [18273.338813] RIP: 0033:0x7f40e528e097
Jul 18 18:02:46 kaveri kernel: [18273.338816] Code: b3 66 90 48 8b 05 f1 =
7d 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 =
7d 0c 00 f7 d8 64 89 01 48=20
Jul 18 18:02:46 kaveri kernel: [18273.338899] RSP: 002b:00007f40dd4c8bb8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Jul 18 18:02:46 kaveri kernel: [18273.338906] RAX: ffffffffffffffda RBX: =
00007f40dd4c8d58 RCX: 00007f40e528e097
Jul 18 18:02:46 kaveri kernel: [18273.338910] RDX: 00007f40dd4c8c20 RSI: =
00000000c0186444 RDI: 0000000000000006
Jul 18 18:02:46 kaveri kernel: [18273.338914] RBP: 00007f40dd4c8be0 R08: =
00007f40dd4c8d80 R09: 00007f40dd4c8d58
Jul 18 18:02:46 kaveri kernel: [18273.338918] R10: 00007f40dd4c8d80 R11: =
0000000000000246 R12: 00007f40dd4c8c20
Jul 18 18:02:46 kaveri kernel: [18273.338921] R13: 00000000c0186444 R14: =
0000000000000006 R15: 0000562701f667d8
Jul 18 18:02:46 kaveri kernel: [18273.338931]=20
Jul 18 18:02:46 kaveri kernel: [18273.338935] Allocated by task 19401:
Jul 18 18:02:46 kaveri kernel: [18273.338941]  kasan_kmalloc+0xa0/0xd0
Jul 18 18:02:46 kaveri kernel: [18273.338945]  __kmalloc+0x136/0x2d0
Jul 18 18:02:46 kaveri kernel: [18273.339035]  amdgpu_job_alloc+0x3d/0x2c=
0 [amdgpu]
Jul 18 18:02:46 kaveri kernel: [18273.339114]  amdgpu_cs_ioctl+0x229a/0x4=
eb0 [amdgpu]
Jul 18 18:02:46 kaveri kernel: [18273.339137]  drm_ioctl_kernel+0x197/0x2=
20 [drm]
Jul 18 18:02:46 kaveri kernel: [18273.339158]  drm_ioctl+0x60a/0x970 [drm=
]
Jul 18 18:02:46 kaveri kernel: [18273.339236]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Jul 18 18:02:46 kaveri kernel: [18273.339241]  do_vfs_ioctl+0x192/0xf30
Jul 18 18:02:46 kaveri kernel: [18273.339246]  ksys_ioctl+0x70/0x80
Jul 18 18:02:46 kaveri kernel: [18273.339250]  __x64_sys_ioctl+0x6f/0xb0
Jul 18 18:02:46 kaveri kernel: [18273.339254]  do_syscall_64+0xa5/0x3f0
Jul 18 18:02:46 kaveri kernel: [18273.339259]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Jul 18 18:02:46 kaveri kernel: [18273.339262]=20
Jul 18 18:02:46 kaveri kernel: [18273.339265] Freed by task 8646:
Jul 18 18:02:46 kaveri kernel: [18273.339270]  __kasan_slab_free+0x130/0x=
180
Jul 18 18:02:46 kaveri kernel: [18273.339274]  kfree+0xf9/0x2f0
Jul 18 18:02:46 kaveri kernel: [18273.339278]  process_one_work+0x7fd/0x1=
6c0
Jul 18 18:02:46 kaveri kernel: [18273.339283]  worker_thread+0x87/0xb50
Jul 18 18:02:46 kaveri kernel: [18273.339287]  kthread+0x2db/0x390
Jul 18 18:02:46 kaveri kernel: [18273.339291]  ret_from_fork+0x27/0x50
Jul 18 18:02:46 kaveri kernel: [18273.339294]=20
Jul 18 18:02:46 kaveri kernel: [18273.339298] The buggy address belongs t=
o the object at ffff8801004b7980
Jul 18 18:02:46 kaveri kernel: [18273.339298]  which belongs to the cache=
 kmalloc-1024 of size 1024
Jul 18 18:02:46 kaveri kernel: [18273.339304] The buggy address is locate=
d 292 bytes inside of
Jul 18 18:02:46 kaveri kernel: [18273.339304]  1024-byte region [ffff8801=
004b7980, ffff8801004b7d80)
Jul 18 18:02:46 kaveri kernel: [18273.339308] The buggy address belongs t=
o the page:
Jul 18 18:02:46 kaveri kernel: [18273.339313] page:ffffea0004012c00 count=
:1 mapcount:0 mapping:ffff8803ed80ea00 index:0x0 compound_mapcount: 0
Jul 18 18:02:46 kaveri kernel: [18273.339320] flags: 0x17fffc000008100(sl=
ab|head)
Jul 18 18:02:46 kaveri kernel: [18273.339327] raw: 017fffc000008100 dead0=
00000000100 dead000000000200 ffff8803ed80ea00
Jul 18 18:02:46 kaveri kernel: [18273.339332] raw: 0000000000000000 00000=
000801c001c 00000001ffffffff 0000000000000000
Jul 18 18:02:46 kaveri kernel: [18273.339335] page dumped because: kasan:=
 bad access detected
Jul 18 18:02:46 kaveri kernel: [18273.339338]=20
Jul 18 18:02:46 kaveri kernel: [18273.339341] Memory state around the bug=
gy address:
Jul 18 18:02:46 kaveri kernel: [18273.339345]  ffff8801004b7980: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Jul 18 18:02:46 kaveri kernel: [18273.339349]  ffff8801004b7a00: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Jul 18 18:02:46 kaveri kernel: [18273.339353] >ffff8801004b7a80: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Jul 18 18:02:46 kaveri kernel: [18273.339356]                            =
    ^
Jul 18 18:02:46 kaveri kernel: [18273.339360]  ffff8801004b7b00: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Jul 18 18:02:46 kaveri kernel: [18273.339365]  ffff8801004b7b80: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb

--------------25B41F2DB08FB9DCBA8BC984
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------25B41F2DB08FB9DCBA8BC984--

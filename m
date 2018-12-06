From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: KASAN: use-after-free in drm_sched_entity_pop_job with amdgpu
Date: Thu, 6 Dec 2018 16:35:51 +0100
Message-ID: <bb36ccaa-3e8e-4cda-4c77-3238a6e425c6@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------E0CD17B9282CD5FF1DAC1F1E"
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------E0CD17B9282CD5FF1DAC1F1E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


KASAN caught something during today's piglit run, see the attached dmesg
excerpt.

Looks like amdgpu destroys the VM while the scheduler still has a
reference to its entity?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------E0CD17B9282CD5FF1DAC1F1E
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Dec  6 15:21:35 kaveri kernel: [ 8318.734239] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Dec  6 15:21:35 kaveri kernel: [ 8318.736505] BUG: KASAN: use-after-free =
in drm_sched_entity_pop_job+0x50f/0x910 [gpu_sched]
Dec  6 15:21:35 kaveri kernel: [ 8318.736661] Write of size 4 at addr fff=
f888261b9b460 by task sdma0/827
Dec  6 15:21:35 kaveri kernel: [ 8318.736769]=20
Dec  6 15:21:35 kaveri kernel: [ 8318.736941] CPU: 7 PID: 827 Comm: sdma0=
 Tainted: G           OE     4.20.0-rc3+ #118
Dec  6 15:21:35 kaveri kernel: [ 8318.737091] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Dec  6 15:21:35 kaveri kernel: [ 8318.737220] Call Trace:
Dec  6 15:21:35 kaveri kernel: [ 8318.737416]  dump_stack+0x7c/0xc0
Dec  6 15:21:35 kaveri kernel: [ 8318.737639]  print_address_description+=
0x65/0x22e
Dec  6 15:21:35 kaveri kernel: [ 8318.737919]  ? drm_sched_entity_pop_job=
+0x50f/0x910 [gpu_sched]
Dec  6 15:21:35 kaveri kernel: [ 8318.738089]  kasan_report.cold.5+0x241/=
0x306
Dec  6 15:21:35 kaveri kernel: [ 8318.738446]  drm_sched_entity_pop_job+0=
x50f/0x910 [gpu_sched]
Dec  6 15:21:35 kaveri kernel: [ 8318.738882]  drm_sched_main+0xe4/0x5a0 =
[gpu_sched]
Dec  6 15:21:35 kaveri kernel: [ 8318.739340]  ? drm_sched_job_recovery+0=
x470/0x470 [gpu_sched]
Dec  6 15:21:35 kaveri kernel: [ 8318.739750]  ? lock_acquire+0x103/0x2c0=

Dec  6 15:21:35 kaveri kernel: [ 8318.739967]  ? __kthread_parkme+0x50/0x=
f0
Dec  6 15:21:35 kaveri kernel: [ 8318.740275]  ? finish_wait+0x230/0x230
Dec  6 15:21:35 kaveri kernel: [ 8318.740517]  ? lockdep_hardirqs_on+0x37=
c/0x560
Dec  6 15:21:35 kaveri kernel: [ 8318.740924]  ? drm_sched_job_recovery+0=
x470/0x470 [gpu_sched]
Dec  6 15:21:35 kaveri kernel: [ 8318.741111]  kthread+0x2e2/0x3a0
Dec  6 15:21:35 kaveri kernel: [ 8318.741279]  ? kthread_park+0x120/0x120=

Dec  6 15:21:35 kaveri kernel: [ 8318.741536]  ret_from_fork+0x27/0x50
Dec  6 15:21:35 kaveri kernel: [ 8318.742118]=20
Dec  6 15:21:35 kaveri kernel: [ 8318.742264] Allocated by task 8273:
Dec  6 15:21:35 kaveri kernel: [ 8318.742480]  kasan_kmalloc+0xbf/0xe0
Dec  6 15:21:35 kaveri kernel: [ 8318.742652]  kmem_cache_alloc_trace+0x1=
2d/0x290
Dec  6 15:21:35 kaveri kernel: [ 8318.743245]  amdgpu_driver_open_kms+0xe=
6/0x4c0 [amdgpu]
Dec  6 15:21:35 kaveri kernel: [ 8318.743275]  drm_file_alloc+0x43a/0x980=
 [drm]
Dec  6 15:21:35 kaveri kernel: [ 8318.743303]  drm_open+0x21c/0x730 [drm]=

Dec  6 15:21:35 kaveri kernel: [ 8318.743332]  drm_stub_open+0x25e/0x410 =
[drm]
Dec  6 15:21:35 kaveri kernel: [ 8318.743339]  chrdev_open+0x1e0/0x4e0
Dec  6 15:21:35 kaveri kernel: [ 8318.743346]  do_dentry_open+0x3c4/0xda0=

Dec  6 15:21:35 kaveri kernel: [ 8318.743353]  path_openat+0xa1e/0x3650
Dec  6 15:21:35 kaveri kernel: [ 8318.743359]  do_filp_open+0x17c/0x250
Dec  6 15:21:35 kaveri kernel: [ 8318.743365]  do_sys_open+0x1db/0x310
Dec  6 15:21:35 kaveri kernel: [ 8318.743373]  do_syscall_64+0x9c/0x3d0
Dec  6 15:21:35 kaveri kernel: [ 8318.743380]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Dec  6 15:21:35 kaveri kernel: [ 8318.743385]=20
Dec  6 15:21:35 kaveri kernel: [ 8318.743391] Freed by task 6916:
Dec  6 15:21:35 kaveri kernel: [ 8318.743398]  __kasan_slab_free+0x125/0x=
170
Dec  6 15:21:35 kaveri kernel: [ 8318.743404]  kfree+0xe2/0x290
Dec  6 15:21:35 kaveri kernel: [ 8318.743520]  amdgpu_driver_postclose_km=
s+0x4e7/0x8e0 [amdgpu]
Dec  6 15:21:35 kaveri kernel: [ 8318.743548]  drm_file_free.part.3+0x7d6=
/0xe30 [drm]
Dec  6 15:21:35 kaveri kernel: [ 8318.743576]  drm_release+0x231/0x3f0 [d=
rm]
Dec  6 15:21:35 kaveri kernel: [ 8318.743582]  __fput+0x235/0x710
Dec  6 15:21:35 kaveri kernel: [ 8318.743590]  task_work_run+0x10e/0x180
Dec  6 15:21:35 kaveri kernel: [ 8318.743596]  exit_to_usermode_loop+0x13=
6/0x160
Dec  6 15:21:35 kaveri kernel: [ 8318.743602]  do_syscall_64+0x32e/0x3d0
Dec  6 15:21:35 kaveri kernel: [ 8318.743609]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Dec  6 15:21:35 kaveri kernel: [ 8318.743613]=20
Dec  6 15:21:35 kaveri kernel: [ 8318.743619] The buggy address belongs t=
o the object at ffff888261b9b300
Dec  6 15:21:35 kaveri kernel: [ 8318.743619]  which belongs to the cache=
 kmalloc-4k of size 4096
Dec  6 15:21:35 kaveri kernel: [ 8318.743627] The buggy address is locate=
d 352 bytes inside of
Dec  6 15:21:35 kaveri kernel: [ 8318.743627]  4096-byte region [ffff8882=
61b9b300, ffff888261b9c300)
Dec  6 15:21:35 kaveri kernel: [ 8318.743633] The buggy address belongs t=
o the page:
Dec  6 15:21:35 kaveri kernel: [ 8318.743639] page:ffffea000986e600 count=
:1 mapcount:0 mapping:ffff8883ed80e600 index:0x0 compound_mapcount: 0
Dec  6 15:21:35 kaveri kernel: [ 8318.743649] flags: 0x17fffc000010200(sl=
ab|head)
Dec  6 15:21:35 kaveri kernel: [ 8318.743657] raw: 017fffc000010200 ffffe=
a00074fca00 0000000300000003 ffff8883ed80e600
Dec  6 15:21:35 kaveri kernel: [ 8318.743664] raw: 0000000000000000 00000=
00000070007 00000001ffffffff 0000000000000000
Dec  6 15:21:35 kaveri kernel: [ 8318.743669] page dumped because: kasan:=
 bad access detected
Dec  6 15:21:35 kaveri kernel: [ 8318.743672]=20
Dec  6 15:21:35 kaveri kernel: [ 8318.743677] Memory state around the bug=
gy address:
Dec  6 15:21:35 kaveri kernel: [ 8318.743683]  ffff888261b9b300: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec  6 15:21:35 kaveri kernel: [ 8318.743689]  ffff888261b9b380: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec  6 15:21:35 kaveri kernel: [ 8318.743695] >ffff888261b9b400: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec  6 15:21:35 kaveri kernel: [ 8318.743700]                            =
                            ^
Dec  6 15:21:35 kaveri kernel: [ 8318.743706]  ffff888261b9b480: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec  6 15:21:35 kaveri kernel: [ 8318.743712]  ffff888261b9b500: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec  6 15:21:35 kaveri kernel: [ 8318.743717] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

--------------E0CD17B9282CD5FF1DAC1F1E
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------E0CD17B9282CD5FF1DAC1F1E--

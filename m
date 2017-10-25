From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: KASAN use-after-free report during piglit run
Date: Wed, 25 Oct 2017 17:43:29 +0200
Message-ID: <e9df6a9b-19bc-4b2f-eeb2-a06ebb2f22c2@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------44C07256B5455136B9575B03"
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

This is a multi-part message in MIME format.
--------------44C07256B5455136B9575B03
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


KASAN caught another use-after-free on my development machine today, see
the attached dmesg excerpt. There haven't been any related changes in
amd-staging-drm-next since yesterday, so maybe userspace is just
tickling the kernel differently (e.g. piglit runs some more tests in
parallel now). It's not reproducible every time, but it just happened a
second time (with an amd-staging-drm-next commit from about a week ago).


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------44C07256B5455136B9575B03
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Oct 25 13:27:17 kaveri kernel: [ 1926.898181] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Oct 25 13:27:17 kaveri kernel: [ 1926.898198] BUG: KASAN: use-after-free =
in reservation_object_wait_timeout_rcu+0xe02/0xe90
Oct 25 13:27:17 kaveri kernel: [ 1926.898204] Read of size 4 at addr ffff=
88000e02ca90 by task max-texture-siz/1607
Oct 25 13:27:17 kaveri kernel: [ 1926.898207]=20
Oct 25 13:27:17 kaveri kernel: [ 1926.898213] CPU: 11 PID: 1607 Comm: max=
-texture-siz Tainted: G        W  O    4.13.0-rc5+ #29
Oct 25 13:27:17 kaveri kernel: [ 1926.898215] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Oct 25 13:27:17 kaveri kernel: [ 1926.898217] Call Trace:
Oct 25 13:27:17 kaveri kernel: [ 1926.898223]  dump_stack+0xb8/0x152
Oct 25 13:27:17 kaveri kernel: [ 1926.898226]  ? dma_virt_map_sg+0x1fe/0x=
1fe
Oct 25 13:27:17 kaveri kernel: [ 1926.898231]  ? show_regs_print_info+0x6=
2/0x62
Oct 25 13:27:17 kaveri kernel: [ 1926.898236]  print_address_description+=
0x6f/0x280
Oct 25 13:27:17 kaveri kernel: [ 1926.898238]  kasan_report+0x27a/0x370
Oct 25 13:27:17 kaveri kernel: [ 1926.898241]  ? reservation_object_wait_=
timeout_rcu+0xe02/0xe90
Oct 25 13:27:17 kaveri kernel: [ 1926.898243]  __asan_report_load4_noabor=
t+0x19/0x20
Oct 25 13:27:17 kaveri kernel: [ 1926.898246]  reservation_object_wait_ti=
meout_rcu+0xe02/0xe90
Oct 25 13:27:17 kaveri kernel: [ 1926.898249]  ? reservation_object_copy_=
fences+0x1060/0x1060
Oct 25 13:27:17 kaveri kernel: [ 1926.898253]  ? __pv_queued_spin_lock_sl=
owpath+0x1360/0x1360
Oct 25 13:27:17 kaveri kernel: [ 1926.898265]  ? drm_mm_scan_remove_block=
+0x804/0xcf0 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898274]  ? drm_mm_scan_color_evict+=
0x827/0x9a0 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898283]  ? drm_mm_insert_node_in_ra=
nge+0xb06/0x1190 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898289]  ttm_bo_unref+0x1021/0x1c00=
 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898293]  ? ttm_bo_unref+0xdb0/0x1c0=
0 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898297]  ? ttm_bo_add_to_lru+0x46c/=
0x12e0 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898300]  ? kasan_kmalloc_large+0x9c=
/0xd0
Oct 25 13:27:17 kaveri kernel: [ 1926.898324]  ? amdgpu_fence_driver_init=
+0x1d49/0x2d80 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898349]  ? amdgpu_gtt_mgr_usage+0xf=
84/0x1220 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898353]  ttm_bo_unmap_virtual_locke=
d+0x3603/0x3840 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898377]  ? amdgpu_gtt_mgr_usage+0xf=
84/0x1220 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898381]  ? ttm_bo_unmap_virtual_loc=
ked+0x33a0/0x3840 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898386]  ttm_bo_mem_space+0x84e/0x1=
110 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898389]  ? __shmem_file_setup+0x250=
/0x520
Oct 25 13:27:17 kaveri kernel: [ 1926.898394]  ttm_bo_validate+0x322/0x58=
0 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898397]  ? unwind_dump+0x4e0/0x4e0
Oct 25 13:27:17 kaveri kernel: [ 1926.898401]  ? ttm_bo_evict_mm+0xa0/0xa=
0 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898403]  ? cpufreq_default_governor=
+0x20/0x20
Oct 25 13:27:17 kaveri kernel: [ 1926.898413]  ? drm_gem_prime_import+0x7=
00/0x9e0 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898417]  ttm_bo_init_reserved+0x9b6=
/0x1300 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898422]  ? ttm_bo_validate+0x580/0x=
580 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898424]  ? dentry_path_raw+0x10/0x1=
0
Oct 25 13:27:17 kaveri kernel: [ 1926.898427]  ? proc_nr_files+0x30/0x30
Oct 25 13:27:17 kaveri kernel: [ 1926.898429]  ? shmem_get_inode+0x668/0x=
8f0
Oct 25 13:27:17 kaveri kernel: [ 1926.898432]  ? shmem_fh_to_dentry+0x160=
/0x160
Oct 25 13:27:17 kaveri kernel: [ 1926.898435]  ? entry_SYSCALL_64_fastpat=
h+0x1e/0xa9
Oct 25 13:27:17 kaveri kernel: [ 1926.898439]  ? _copy_to_user+0x90/0x90
Oct 25 13:27:17 kaveri kernel: [ 1926.898443]  ? alloc_file+0x16d/0x440
Oct 25 13:27:17 kaveri kernel: [ 1926.898445]  ? __shmem_file_setup+0x2e0=
/0x520
Oct 25 13:27:17 kaveri kernel: [ 1926.898448]  ? mark_free_pages+0x3f0/0x=
3f0
Oct 25 13:27:17 kaveri kernel: [ 1926.898450]  ? shmem_fill_super+0xa10/0=
xa10
Oct 25 13:27:17 kaveri kernel: [ 1926.898459]  ? drm_gem_private_object_i=
nit+0x189/0x300 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898462]  ? kasan_kmalloc+0xad/0xe0
Oct 25 13:27:17 kaveri kernel: [ 1926.898486]  amdgpu_ttm_placement_from_=
domain+0xe64/0x1cf0 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898509]  ? amdgpu_fill_buffer+0xb80=
/0x1150 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898511]  ? update_stack_state+0x402=
/0x780
Oct 25 13:27:17 kaveri kernel: [ 1926.898535]  ? amdgpu_ttm_placement_fro=
m_domain+0x8d0/0x1cf0 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898538]  ? show_initstate+0xb0/0xb0=

Oct 25 13:27:17 kaveri kernel: [ 1926.898541]  ? bpf_prog_alloc+0x320/0x3=
20
Oct 25 13:27:17 kaveri kernel: [ 1926.898544]  ? unwind_next_frame.part.5=
+0x1bb/0xc90
Oct 25 13:27:17 kaveri kernel: [ 1926.898547]  ? __free_insn_slot+0x6a0/0=
x6a0
Oct 25 13:27:17 kaveri kernel: [ 1926.898549]  ? unwind_dump+0x4e0/0x4e0
Oct 25 13:27:17 kaveri kernel: [ 1926.898552]  ? rb_erase+0x3540/0x3540
Oct 25 13:27:17 kaveri kernel: [ 1926.898556]  ? __mem_cgroup_threshold+0=
x7b0/0x7b0
Oct 25 13:27:17 kaveri kernel: [ 1926.898558]  ? memory_max_write+0x420/0=
x420
Oct 25 13:27:17 kaveri kernel: [ 1926.898561]  ? __kernel_text_address+0x=
bf/0xf0
Oct 25 13:27:17 kaveri kernel: [ 1926.898563]  ? unwind_get_return_addres=
s+0x66/0xb0
Oct 25 13:27:17 kaveri kernel: [ 1926.898566]  ? __save_stack_trace+0x92/=
0x100
Oct 25 13:27:17 kaveri kernel: [ 1926.898589]  amdgpu_bo_create+0xba/0xa0=
0 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898612]  ? amdgpu_ttm_placement_fro=
m_domain+0x1cf0/0x1cf0 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898615]  ? mem_cgroup_uncharge_swap=
+0xc0/0xc0
Oct 25 13:27:17 kaveri kernel: [ 1926.898617]  ? kmem_cache_alloc+0xb7/0x=
1c0
Oct 25 13:27:17 kaveri kernel: [ 1926.898620]  ? __anon_vma_prepare+0x37a=
/0x650
Oct 25 13:27:17 kaveri kernel: [ 1926.898622]  ? __handle_mm_fault+0x31ac=
/0x5070
Oct 25 13:27:17 kaveri kernel: [ 1926.898625]  ? handle_mm_fault+0x292/0x=
800
Oct 25 13:27:17 kaveri kernel: [ 1926.898627]  ? __do_page_fault+0x412/0x=
a00
Oct 25 13:27:17 kaveri kernel: [ 1926.898629]  ? do_page_fault+0x22/0x30
Oct 25 13:27:17 kaveri kernel: [ 1926.898631]  ? page_fault+0x28/0x30
Oct 25 13:27:17 kaveri kernel: [ 1926.898633]  ? memcg_oom_wake_function+=
0x6a0/0x6a0
Oct 25 13:27:17 kaveri kernel: [ 1926.898657]  amdgpu_gem_object_create+0=
x11f/0x240 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898682]  ? amdgpu_gem_object_free+0=
x1d0/0x1d0 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898706]  amdgpu_gem_create_ioctl+0x=
3bb/0xc10 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898731]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898734]  ? page_add_new_anon_rmap+0=
x203/0x3d0
Oct 25 13:27:17 kaveri kernel: [ 1926.898737]  ? __check_object_size+0x22=
e/0x560
Oct 25 13:27:17 kaveri kernel: [ 1926.898760]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898768]  drm_ioctl_kernel+0x1ce/0x3=
50 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898777]  ? drm_ioctl_permit+0x2c0/0=
x2c0 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898779]  ? kasan_check_write+0x14/0=
x20
Oct 25 13:27:17 kaveri kernel: [ 1926.898788]  drm_ioctl+0x79a/0x17e0 [dr=
m]
Oct 25 13:27:17 kaveri kernel: [ 1926.898812]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898821]  ? drm_ioctl_kernel+0x350/0=
x350 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898825]  ? do_mmap+0x641/0x10f0
Oct 25 13:27:17 kaveri kernel: [ 1926.898848]  amdgpu_drm_ioctl+0xd8/0x61=
d0 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898850]  do_vfs_ioctl+0x197/0x1490
Oct 25 13:27:17 kaveri kernel: [ 1926.898853]  ? vm_mmap_pgoff+0x1fe/0x2c=
0
Oct 25 13:27:17 kaveri kernel: [ 1926.898855]  ? ioctl_preallocate+0x2c0/=
0x2c0
Oct 25 13:27:17 kaveri kernel: [ 1926.898858]  ? __fget_light+0x2be/0x410=

Oct 25 13:27:17 kaveri kernel: [ 1926.898860]  ? iterate_fd+0x2e0/0x2e0
Oct 25 13:27:17 kaveri kernel: [ 1926.898862]  ? handle_mm_fault+0x292/0x=
800
Oct 25 13:27:17 kaveri kernel: [ 1926.898865]  ? __handle_mm_fault+0x5070=
/0x5070
Oct 25 13:27:17 kaveri kernel: [ 1926.898868]  ? __do_page_fault+0x43a/0x=
a00
Oct 25 13:27:17 kaveri kernel: [ 1926.898871]  SyS_ioctl+0x79/0x90
Oct 25 13:27:17 kaveri kernel: [ 1926.898874]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Oct 25 13:27:17 kaveri kernel: [ 1926.898876] RIP: 0033:0x7f56527b0dc7
Oct 25 13:27:17 kaveri kernel: [ 1926.898878] RSP: 002b:00007ffc20e89988 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Oct 25 13:27:17 kaveri kernel: [ 1926.898881] RAX: ffffffffffffffda RBX: =
00007f5652a67b00 RCX: 00007f56527b0dc7
Oct 25 13:27:17 kaveri kernel: [ 1926.898883] RDX: 00007ffc20e899d0 RSI: =
00000000c0206440 RDI: 0000000000000006
Oct 25 13:27:17 kaveri kernel: [ 1926.898884] RBP: 0000000040000010 R08: =
00007f5652a67ca8 R09: 0000000000000060
Oct 25 13:27:17 kaveri kernel: [ 1926.898885] R10: 0000000000000004 R11: =
0000000000000246 R12: 0000000040001000
Oct 25 13:27:17 kaveri kernel: [ 1926.898887] R13: 00007f5652a67b58 R14: =
0000000000001000 R15: 00007f5652a67b00
Oct 25 13:27:17 kaveri kernel: [ 1926.898889]=20
Oct 25 13:27:17 kaveri kernel: [ 1926.898893] Allocated by task 24908:
Oct 25 13:27:17 kaveri kernel: [ 1926.898897]  save_stack_trace+0x1b/0x20=

Oct 25 13:27:17 kaveri kernel: [ 1926.898899]  save_stack+0x43/0xd0
Oct 25 13:27:17 kaveri kernel: [ 1926.898900]  kasan_kmalloc+0xad/0xe0
Oct 25 13:27:17 kaveri kernel: [ 1926.898902]  __kmalloc+0x105/0x230
Oct 25 13:27:17 kaveri kernel: [ 1926.898905]  reservation_object_copy_fe=
nces+0x1b9/0x1060
Oct 25 13:27:17 kaveri kernel: [ 1926.898908]  ttm_bo_unref+0x3dd/0x1c00 =
[ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898931]  amdgpu_bo_unref+0xae/0x160=
 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898953]  amdgpu_gem_object_free+0x1=
33/0x1d0 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.898961]  drm_gem_object_free+0xdd/0=
x2b0 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898968]  drm_gem_object_put_unlocke=
d+0x9c/0x4f0 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898976]  drm_gem_object_put_unlocke=
d+0x23f/0x4f0 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898983]  drm_gem_object_put_unlocke=
d+0x44e/0x4f0 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898991]  drm_gem_handle_delete+0x5e=
/0x90 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.898999]  drm_gem_close_ioctl+0x91/0=
xf0 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.899007]  drm_ioctl_kernel+0x1ce/0x3=
50 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.899014]  drm_ioctl+0x79a/0x17e0 [dr=
m]
Oct 25 13:27:17 kaveri kernel: [ 1926.899034]  amdgpu_drm_ioctl+0xd8/0x61=
d0 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.899036]  do_vfs_ioctl+0x197/0x1490
Oct 25 13:27:17 kaveri kernel: [ 1926.899037]  SyS_ioctl+0x79/0x90
Oct 25 13:27:17 kaveri kernel: [ 1926.899040]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Oct 25 13:27:17 kaveri kernel: [ 1926.899040]=20
Oct 25 13:27:17 kaveri kernel: [ 1926.899042] Freed by task 24152:
Oct 25 13:27:17 kaveri kernel: [ 1926.899045]  save_stack_trace+0x1b/0x20=

Oct 25 13:27:17 kaveri kernel: [ 1926.899047]  save_stack+0x43/0xd0
Oct 25 13:27:17 kaveri kernel: [ 1926.899049]  kasan_slab_free+0x72/0xc0
Oct 25 13:27:17 kaveri kernel: [ 1926.899051]  kfree+0x94/0x1a0
Oct 25 13:27:17 kaveri kernel: [ 1926.899054]  ttm_bo_unref+0x12c7/0x1c00=
 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.899057]  ttm_bo_unmap_virtual_locke=
d+0x3603/0x3840 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.899060]  ttm_bo_mem_space+0x84e/0x1=
110 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.899064]  ttm_bo_validate+0x322/0x58=
0 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.899067]  ttm_bo_init_reserved+0x9b6=
/0x1300 [ttm]
Oct 25 13:27:17 kaveri kernel: [ 1926.899089]  amdgpu_ttm_placement_from_=
domain+0xe64/0x1cf0 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.899110]  amdgpu_bo_create+0xba/0xa0=
0 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.899133]  amdgpu_gem_object_create+0=
x11f/0x240 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.899156]  amdgpu_gem_create_ioctl+0x=
3bb/0xc10 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.899164]  drm_ioctl_kernel+0x1ce/0x3=
50 [drm]
Oct 25 13:27:17 kaveri kernel: [ 1926.899172]  drm_ioctl+0x79a/0x17e0 [dr=
m]
Oct 25 13:27:17 kaveri kernel: [ 1926.899191]  amdgpu_drm_ioctl+0xd8/0x61=
d0 [amdgpu]
Oct 25 13:27:17 kaveri kernel: [ 1926.899193]  do_vfs_ioctl+0x197/0x1490
Oct 25 13:27:17 kaveri kernel: [ 1926.899195]  SyS_ioctl+0x79/0x90
Oct 25 13:27:17 kaveri kernel: [ 1926.899197]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Oct 25 13:27:17 kaveri kernel: [ 1926.899197]=20
Oct 25 13:27:17 kaveri kernel: [ 1926.899201] The buggy address belongs t=
o the object at ffff88000e02ca80
Oct 25 13:27:17 kaveri kernel: [ 1926.899201]  which belongs to the cache=
 kmalloc-64 of size 64
Oct 25 13:27:17 kaveri kernel: [ 1926.899206] The buggy address is locate=
d 16 bytes inside of
Oct 25 13:27:17 kaveri kernel: [ 1926.899206]  64-byte region [ffff88000e=
02ca80, ffff88000e02cac0)
Oct 25 13:27:17 kaveri kernel: [ 1926.899209] The buggy address belongs t=
o the page:
Oct 25 13:27:17 kaveri kernel: [ 1926.899212] page:ffffea0000380b00 count=
:1 mapcount:0 mapping:          (null) index:0x0
Oct 25 13:27:17 kaveri kernel: [ 1926.899216] flags: 0xffffc000000100(sla=
b)
Oct 25 13:27:17 kaveri kernel: [ 1926.899221] raw: 00ffffc000000100 00000=
00000000000 0000000000000000 00000001002a002a
Oct 25 13:27:17 kaveri kernel: [ 1926.899225] raw: ffffea00042e1700 00000=
01300000013 ffff8803ae00f640 0000000000000000
Oct 25 13:27:17 kaveri kernel: [ 1926.899228] page dumped because: kasan:=
 bad access detected
Oct 25 13:27:17 kaveri kernel: [ 1926.899229]=20
Oct 25 13:27:17 kaveri kernel: [ 1926.899231] Memory state around the bug=
gy address:
Oct 25 13:27:17 kaveri kernel: [ 1926.899234]  ffff88000e02c980: 00 00 00=
 fc fc fc fc fc 00 00 00 00 00 00 00 fc
Oct 25 13:27:17 kaveri kernel: [ 1926.899237]  ffff88000e02ca00: fc fc fc=
 fc 00 00 00 00 00 00 00 fc fc fc fc fc
Oct 25 13:27:17 kaveri kernel: [ 1926.899240] >ffff88000e02ca80: fb fb fb=
 fb fb fb fb fb fc fc fc fc 00 00 00 00
Oct 25 13:27:17 kaveri kernel: [ 1926.899242]                          ^
Oct 25 13:27:17 kaveri kernel: [ 1926.899244]  ffff88000e02cb00: 00 00 00=
 fc fc fc fc fc 00 00 00 00 00 00 00 fc
Oct 25 13:27:17 kaveri kernel: [ 1926.899247]  ffff88000e02cb80: fc fc fc=
 fc 00 00 00 00 00 00 00 fc fc fc fc fc
Oct 25 13:27:17 kaveri kernel: [ 1926.899249] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

--------------44C07256B5455136B9575B03
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------44C07256B5455136B9575B03--

From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: set bo->resv point to tbo->ttm_resv after
 individualize_resv
Date: Tue, 7 Nov 2017 17:16:00 +0100
Message-ID: <6f5e59de-c689-d8da-dcf5-350f87db3d54@daenzer.net>
References: <20171107134431.11209-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------D961C7D70F401DB49874AFA8"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171107134431.11209-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------D961C7D70F401DB49874AFA8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 07/11/17 02:44 PM, Christian König wrote:
> Set bo->resv to ttm_resv during BO cleanup. This way freed BOs can be
> better reaped during eviction.
> 
> Signed-off-by: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

KASAN caught some badness while running piglit with this applied, see
the attached dmesg excerpts.


At least some of this might be pre-existing bugs being exposed by this
change. E.g. I've been chasing another use-after-free, with
ttm_bo_delayed_delete trying to reserve a BO which has already been
destroyed. Looks like maybe the ddestroy list handling isn't quite
watertight yet.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------D961C7D70F401DB49874AFA8
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Nov  7 16:36:02 kaveri kernel: [  164.320428] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Nov  7 16:36:02 kaveri kernel: [  164.320482] BUG: KASAN: use-after-free =
in amdgpu_ttm_copy_mem_to_mem+0x1171/0x15f0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.320485] Read of size 8 at addr ffff=
880398d9f010 by task max-texture-siz/7130
Nov  7 16:36:02 kaveri kernel: [  164.320486]=20
Nov  7 16:36:02 kaveri kernel: [  164.320490] CPU: 1 PID: 7130 Comm: max-=
texture-siz Tainted: G           O    4.14.0-rc3+ #32
Nov  7 16:36:02 kaveri kernel: [  164.320492] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Nov  7 16:36:02 kaveri kernel: [  164.320492] Call Trace:
Nov  7 16:36:02 kaveri kernel: [  164.320498]  dump_stack+0xad/0x139
Nov  7 16:36:02 kaveri kernel: [  164.320501]  ? dma_virt_map_sg+0x1f7/0x=
1f7
Nov  7 16:36:02 kaveri kernel: [  164.320505]  print_address_description+=
0x6a/0x270
Nov  7 16:36:02 kaveri kernel: [  164.320507]  kasan_report+0x277/0x360
Nov  7 16:36:02 kaveri kernel: [  164.320547]  ? amdgpu_ttm_copy_mem_to_m=
em+0x1171/0x15f0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.320587]  amdgpu_ttm_copy_mem_to_mem=
+0x1171/0x15f0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.320590]  ? security_capable+0x6d/0x=
a0
Nov  7 16:36:02 kaveri kernel: [  164.320595]  ? ttm_check_swapping+0x26/=
0x240 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.320599]  ? ttm_mem_global_alloc_zon=
e.constprop.4+0x1bc/0x290 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.320657]  ? amdgpu_copy_buffer+0x7c0=
/0x7c0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.320666]  ? ttm_pool_populate+0x618/=
0xb40 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.320674]  ? ttm_pool_unpopulate+0x29=
0/0x290 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.320677]  ? kasan_unpoison_shadow+0x=
30/0x40
Nov  7 16:36:02 kaveri kernel: [  164.320732]  amdgpu_move_blit.constprop=
=2E17+0x227/0x4a0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.320735]  ? __kmalloc_node+0x170/0x2=
80
Nov  7 16:36:02 kaveri kernel: [  164.320739]  ? ttm_dma_tt_init+0x27a/0x=
520 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.320781]  ? amdgpu_ttm_copy_mem_to_m=
em+0x15f0/0x15f0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.320788]  ? ttm_dma_tt_init+0x27a/0x=
520 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.320833]  ? amdgpu_bo_move_notify+0x=
f9/0x310 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.320873]  amdgpu_bo_move+0x227/0x700=
 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.320879]  ttm_bo_handle_move_mem+0x8=
6a/0x2300 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.320883]  ? ttm_bo_mem_space+0x54e/0=
xe90 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.320936]  ? amdgpu_evict_flags+0x285=
/0x620 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.320944]  ttm_bo_evict+0x3ee/0xc70 [=
ttm]
Nov  7 16:36:02 kaveri kernel: [  164.320968]  ? drm_mm_init+0x4d0/0x4d0 =
[drm]
Nov  7 16:36:02 kaveri kernel: [  164.320975]  ? ttm_bo_handle_move_mem+0=
x2300/0x2300 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.320983]  ? ttm_bo_add_to_lru+0x42f/=
0x640 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.320987]  ? bpf_prog_alloc+0x2d0/0x2=
d0
Nov  7 16:36:02 kaveri kernel: [  164.320990]  ? deref_stack_reg+0x1f0/0x=
1f0
Nov  7 16:36:02 kaveri kernel: [  164.320994]  ? kmalloc_order+0x4b/0x60
Nov  7 16:36:02 kaveri kernel: [  164.321002]  ttm_mem_evict_first+0x2e0/=
0x460 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.321010]  ? ttm_bo_evict+0xc70/0xc70=
 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.321018]  ttm_bo_mem_space+0x894/0xe=
90 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.321026]  ? ttm_bo_mem_compat+0x6b/0=
x130 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.321032]  ttm_bo_validate+0x301/0x53=
0 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.321037]  ? ttm_bo_evict_mm+0xa0/0xa=
0 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.321039]  ? SyS_membarrier+0x2b0/0x2=
b0
Nov  7 16:36:02 kaveri kernel: [  164.321057]  ? drm_vma_offset_add+0xb4/=
0x180 [drm]
Nov  7 16:36:02 kaveri kernel: [  164.321065]  ttm_bo_init_reserved+0xaf3=
/0x1200 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.321071]  ? ttm_bo_validate+0x530/0x=
530 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.321075]  ? get_empty_filp+0x27b/0x5=
30
Nov  7 16:36:02 kaveri kernel: [  164.321076]  ? proc_nr_files+0x30/0x30
Nov  7 16:36:02 kaveri kernel: [  164.321079]  ? _copy_to_user+0x90/0x90
Nov  7 16:36:02 kaveri kernel: [  164.321081]  ? alloc_file+0x16d/0x440
Nov  7 16:36:02 kaveri kernel: [  164.321083]  ? __shmem_file_setup+0x2af=
/0x480
Nov  7 16:36:02 kaveri kernel: [  164.321095]  ? drm_gem_private_object_i=
nit+0x18a/0x2e0 [drm]
Nov  7 16:36:02 kaveri kernel: [  164.321097]  ? kasan_kmalloc+0xa0/0xd0
Nov  7 16:36:02 kaveri kernel: [  164.321137]  amdgpu_bo_do_create+0x549/=
0x1260 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321186]  ? amdgpu_fill_buffer+0x9f0=
/0x9f0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321190]  ? refill_stock+0xf0/0xf0
Nov  7 16:36:02 kaveri kernel: [  164.321263]  ? amdgpu_ttm_placement_fro=
m_domain+0x8a0/0x8a0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321267]  ? is_bpf_text_address+0xa/=
0x20
Nov  7 16:36:02 kaveri kernel: [  164.321271]  ? kernel_text_address+0x11=
1/0x120
Nov  7 16:36:02 kaveri kernel: [  164.321273]  ? __kernel_text_address+0x=
e/0x30
Nov  7 16:36:02 kaveri kernel: [  164.321275]  ? unwind_get_return_addres=
s+0x5f/0xa0
Nov  7 16:36:02 kaveri kernel: [  164.321279]  ? mem_cgroup_uncharge_swap=
+0xc0/0xc0
Nov  7 16:36:02 kaveri kernel: [  164.321281]  ? save_stack+0x32/0xb0
Nov  7 16:36:02 kaveri kernel: [  164.321282]  ? kasan_kmalloc+0xa0/0xd0
Nov  7 16:36:02 kaveri kernel: [  164.321284]  ? kmem_cache_alloc+0xb6/0x=
1c0
Nov  7 16:36:02 kaveri kernel: [  164.321285]  ? __anon_vma_prepare+0x357=
/0x5e0
Nov  7 16:36:02 kaveri kernel: [  164.321287]  ? memcg_oom_wake_function+=
0x6e0/0x6e0
Nov  7 16:36:02 kaveri kernel: [  164.321289]  ? do_page_fault+0x93/0x320=

Nov  7 16:36:02 kaveri kernel: [  164.321291]  ? rb_insert_color_cached+0=
x1070/0x1070
Nov  7 16:36:02 kaveri kernel: [  164.321331]  amdgpu_bo_create+0xba/0x88=
0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321336]  ? ttm_bo_release_list+0x7d=
0/0x7d0 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.321338]  ? unwind_get_return_addres=
s+0x5f/0xa0
Nov  7 16:36:02 kaveri kernel: [  164.321377]  ? amdgpu_bo_do_create+0x12=
60/0x1260 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321379]  ? mem_cgroup_try_charge+0x=
23b/0x920
Nov  7 16:36:02 kaveri kernel: [  164.321381]  ? __alloc_pages_nodemask+0=
x3c3/0xb70
Nov  7 16:36:02 kaveri kernel: [  164.321382]  ? mem_cgroup_low+0x1e0/0x1=
e0
Nov  7 16:36:02 kaveri kernel: [  164.321384]  ? page_mkclean.part.34+0x1=
0/0x10
Nov  7 16:36:02 kaveri kernel: [  164.321425]  amdgpu_gem_object_create+0=
x10d/0x210 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321497]  ? amdgpu_gem_object_free+0=
x180/0x180 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321501]  ? __ww_mutex_lock_interrup=
tible_slowpath+0x20/0x20
Nov  7 16:36:02 kaveri kernel: [  164.321504]  ? lru_cache_add_active_or_=
unevictable+0x112/0x2b0
Nov  7 16:36:02 kaveri kernel: [  164.321555]  amdgpu_gem_create_ioctl+0x=
37d/0xa10 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321596]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321598]  ? __handle_mm_fault+0x1d3b=
/0x4950
Nov  7 16:36:02 kaveri kernel: [  164.321600]  ? __pmd_alloc+0x300/0x300
Nov  7 16:36:02 kaveri kernel: [  164.321602]  ? vma_set_page_prot+0x10b/=
0x220
Nov  7 16:36:02 kaveri kernel: [  164.321604]  ? vma_wants_writenotify+0x=
370/0x370
Nov  7 16:36:02 kaveri kernel: [  164.321605]  ? __check_object_size+0x21=
7/0x4a0
Nov  7 16:36:02 kaveri kernel: [  164.321645]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321656]  drm_ioctl_kernel+0x1ba/0x2=
c0 [drm]
Nov  7 16:36:02 kaveri kernel: [  164.321668]  ? drm_ioctl_permit+0x2b0/0=
x2b0 [drm]
Nov  7 16:36:02 kaveri kernel: [  164.321679]  drm_ioctl+0x720/0xa30 [drm=
]
Nov  7 16:36:02 kaveri kernel: [  164.321733]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321753]  ? drm_getstats+0x20/0x20 [=
drm]
Nov  7 16:36:02 kaveri kernel: [  164.321757]  ? mem_cgroup_reset+0x290/0=
x290
Nov  7 16:36:02 kaveri kernel: [  164.321760]  ? do_mmap+0x608/0xee0
Nov  7 16:36:02 kaveri kernel: [  164.321819]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321822]  do_vfs_ioctl+0x18f/0x1270
Nov  7 16:36:02 kaveri kernel: [  164.321824]  ? __do_page_fault+0x4ee/0x=
b10
Nov  7 16:36:02 kaveri kernel: [  164.321825]  ? ioctl_preallocate+0x2a0/=
0x2a0
Nov  7 16:36:02 kaveri kernel: [  164.321827]  ? __fget_light+0x2b0/0x3b0=

Nov  7 16:36:02 kaveri kernel: [  164.321829]  ? iterate_fd+0x2a0/0x2a0
Nov  7 16:36:02 kaveri kernel: [  164.321831]  ? do_page_fault+0x93/0x320=

Nov  7 16:36:02 kaveri kernel: [  164.321832]  ? __do_page_fault+0xb10/0x=
b10
Nov  7 16:36:02 kaveri kernel: [  164.321833]  ? SyS_mmap_pgoff+0x1e8/0x5=
e0
Nov  7 16:36:02 kaveri kernel: [  164.321835]  ? SyS_write+0x128/0x1e0
Nov  7 16:36:02 kaveri kernel: [  164.321836]  ? do_munmap+0xcf0/0xcf0
Nov  7 16:36:02 kaveri kernel: [  164.321838]  SyS_ioctl+0x74/0x80
Nov  7 16:36:02 kaveri kernel: [  164.321840]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Nov  7 16:36:02 kaveri kernel: [  164.321842] RIP: 0033:0x7f2f51319dc7
Nov  7 16:36:02 kaveri kernel: [  164.321843] RSP: 002b:00007fffc2df9e48 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Nov  7 16:36:02 kaveri kernel: [  164.321846] RAX: ffffffffffffffda RBX: =
00007f2f515d0b00 RCX: 00007f2f51319dc7
Nov  7 16:36:02 kaveri kernel: [  164.321847] RDX: 00007fffc2df9e90 RSI: =
00000000c0206440 RDI: 0000000000000006
Nov  7 16:36:02 kaveri kernel: [  164.321848] RBP: 0000000040000010 R08: =
00007f2f515d0c48 R09: 0000000000000060
Nov  7 16:36:02 kaveri kernel: [  164.321849] R10: 0000000000000004 R11: =
0000000000000246 R12: 0000000040001000
Nov  7 16:36:02 kaveri kernel: [  164.321850] R13: 00007f2f515d0b58 R14: =
0000000000001000 R15: 00007f2f515d0b00
Nov  7 16:36:02 kaveri kernel: [  164.321852]=20
Nov  7 16:36:02 kaveri kernel: [  164.321854] Allocated by task 22536:
Nov  7 16:36:02 kaveri kernel: [  164.321857]  save_stack+0x32/0xb0
Nov  7 16:36:02 kaveri kernel: [  164.321858]  kasan_kmalloc+0xa0/0xd0
Nov  7 16:36:02 kaveri kernel: [  164.321859]  __kmalloc+0x104/0x210
Nov  7 16:36:02 kaveri kernel: [  164.321902]  amdgpu_vram_mgr_new+0x1e9/=
0x710 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321906]  ttm_bo_mem_space+0x2a2/0xe=
90 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.321910]  ttm_bo_validate+0x301/0x53=
0 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.321950]  amdgpu_cs_bo_validate+0x32=
a/0x670 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.321990]  amdgpu_cs_validate+0xba/0x=
9f0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.322037]  amdgpu_vm_validate_pt_bos+=
0x1cf/0x7d0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.322110]  amdgpu_cs_ioctl+0x4524/0x7=
490 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.322124]  drm_ioctl_kernel+0x1ba/0x2=
c0 [drm]
Nov  7 16:36:02 kaveri kernel: [  164.322135]  drm_ioctl+0x720/0xa30 [drm=
]
Nov  7 16:36:02 kaveri kernel: [  164.322172]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.322173]  do_vfs_ioctl+0x18f/0x1270
Nov  7 16:36:02 kaveri kernel: [  164.322175]  SyS_ioctl+0x74/0x80
Nov  7 16:36:02 kaveri kernel: [  164.322176]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Nov  7 16:36:02 kaveri kernel: [  164.322176]=20
Nov  7 16:36:02 kaveri kernel: [  164.322178] Freed by task 22507:
Nov  7 16:36:02 kaveri kernel: [  164.322181]  save_stack+0x32/0xb0
Nov  7 16:36:02 kaveri kernel: [  164.322182]  kasan_slab_free+0x72/0xc0
Nov  7 16:36:02 kaveri kernel: [  164.322183]  kfree+0x8d/0x190
Nov  7 16:36:02 kaveri kernel: [  164.322225]  amdgpu_vram_mgr_del+0x1e8/=
0x2c0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.322229]  ttm_bo_cleanup_memtype_use=
+0x1bb/0x2a0 [ttm]
Nov  7 16:36:02 kaveri kernel: [  164.322232]  ttm_bo_unref+0x623/0x9a0 [=
ttm]
Nov  7 16:36:02 kaveri kernel: [  164.322271]  amdgpu_bo_unref+0xaa/0x150=
 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.322311]  amdgpu_gem_object_free+0x1=
1b/0x180 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.322321]  drm_gem_object_free+0xd3/0=
x240 [drm]
Nov  7 16:36:02 kaveri kernel: [  164.322332]  drm_gem_object_release_han=
dle+0xf2/0x190 [drm]
Nov  7 16:36:02 kaveri kernel: [  164.322342]  drm_gem_handle_delete+0x57=
/0x80 [drm]
Nov  7 16:36:02 kaveri kernel: [  164.322352]  drm_ioctl_kernel+0x1ba/0x2=
c0 [drm]
Nov  7 16:36:02 kaveri kernel: [  164.322362]  drm_ioctl+0x720/0xa30 [drm=
]
Nov  7 16:36:02 kaveri kernel: [  164.322422]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Nov  7 16:36:02 kaveri kernel: [  164.322425]  do_vfs_ioctl+0x18f/0x1270
Nov  7 16:36:02 kaveri kernel: [  164.322426]  SyS_ioctl+0x74/0x80
Nov  7 16:36:02 kaveri kernel: [  164.322428]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Nov  7 16:36:02 kaveri kernel: [  164.322429]=20
Nov  7 16:36:02 kaveri kernel: [  164.322432] The buggy address belongs t=
o the object at ffff880398d9f000
Nov  7 16:36:02 kaveri kernel: [  164.322432]  which belongs to the cache=
 kmalloc-192 of size 192
Nov  7 16:36:02 kaveri kernel: [  164.322436] The buggy address is locate=
d 16 bytes inside of
Nov  7 16:36:02 kaveri kernel: [  164.322436]  192-byte region [ffff88039=
8d9f000, ffff880398d9f0c0)
Nov  7 16:36:02 kaveri kernel: [  164.322439] The buggy address belongs t=
o the page:
Nov  7 16:36:02 kaveri kernel: [  164.322443] page:ffffea000e636780 count=
:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
Nov  7 16:36:02 kaveri kernel: [  164.322447] flags: 0x17fffc000008100(sl=
ab|head)
Nov  7 16:36:02 kaveri kernel: [  164.322452] raw: 017fffc000008100 00000=
00000000000 0000000000000000 0000000100200020
Nov  7 16:36:02 kaveri kernel: [  164.322456] raw: dead000000000100 dead0=
00000000200 ffff8803ae00f100 0000000000000000
Nov  7 16:36:02 kaveri kernel: [  164.322458] page dumped because: kasan:=
 bad access detected
Nov  7 16:36:02 kaveri kernel: [  164.322459]=20
Nov  7 16:36:02 kaveri kernel: [  164.322461] Memory state around the bug=
gy address:
Nov  7 16:36:02 kaveri kernel: [  164.322463]  ffff880398d9ef00: 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00
Nov  7 16:36:02 kaveri kernel: [  164.322466]  ffff880398d9ef80: 00 00 00=
 00 00 fc fc fc fc fc fc fc fc fc fc fc
Nov  7 16:36:02 kaveri kernel: [  164.322468] >ffff880398d9f000: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Nov  7 16:36:02 kaveri kernel: [  164.322469]                          ^
Nov  7 16:36:02 kaveri kernel: [  164.322471]  ffff880398d9f080: fb fb fb=
 fb fb fb fb fb fc fc fc fc fc fc fc fc
Nov  7 16:36:02 kaveri kernel: [  164.322472]  ffff880398d9f100: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Nov  7 16:36:02 kaveri kernel: [  164.322473] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Nov  7 16:36:02 kaveri kernel: [  164.322475] Disabling lock debugging du=
e to kernel taint
[...]
Nov  7 16:52:43 kaveri kernel: [  386.871098] kasan: CONFIG_KASAN_INLINE =
enabled
Nov  7 16:52:43 kaveri kernel: [  386.871109] kasan: GPF could be caused =
by NULL-ptr deref or user memory access
Nov  7 16:52:43 kaveri kernel: [  386.871116] general protection fault: 0=
000 [#1] SMP KASAN
Nov  7 16:52:43 kaveri kernel: [  386.871119] Modules linked in: lz4 lz4_=
compress cpufreq_powersave cpufreq_userspace cpufreq_conservative binfmt_=
misc nls_ascii nls_cp437 vfat fat amdgpu(O) edac_mce_amd amdkfd(O) radeon=
(O) kvm irqbypass crct10dif_pclmul crc32_pclmul chash snd_hda_codec_realt=
ek ghash_clmulni_intel pcbc snd_hda_codec_generic ttm(O) snd_hda_codec_hd=
mi efi_pstore drm_kms_helper(O) snd_hda_intel snd_hda_codec drm(O) snd_hd=
a_core snd_hwdep aesni_intel snd_pcm i2c_algo_bit ccp aes_x86_64 fb_sys_f=
ops crypto_simd r8169 syscopyarea glue_helper wmi_bmof ppdev sysfillrect =
snd_timer cryptd sysimgblt mii sg pcspkr mfd_core efivars rng_core snd sp=
5100_tco soundcore i2c_piix4 wmi parport_pc parport i2c_designware_platfo=
rm i2c_designware_core button acpi_cpufreq tcp_bbr sch_fq nct6775 hwmon_v=
id sunrpc efivarfs ip_tables x_tables
Nov  7 16:52:43 kaveri kernel: [  386.871173]  autofs4 ext4 crc16 mbcache=
 jbd2 fscrypto dm_mod raid10 raid1 raid0 multipath linear md_mod sd_mod e=
vdev hid_generic usbhid hid ahci libahci libata xhci_pci xhci_hcd crc32c_=
intel usbcore scsi_mod shpchp gpio_amdpt gpio_generic
Nov  7 16:52:43 kaveri kernel: [  386.871191] CPU: 1 PID: 13908 Comm: max=
-texture-siz Tainted: G           O    4.14.0-rc3+ #32
Nov  7 16:52:43 kaveri kernel: [  386.871193] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Nov  7 16:52:43 kaveri kernel: [  386.871196] task: ffff8801e7fd5d00 task=
=2Estack: ffff8803968b8000
Nov  7 16:52:43 kaveri kernel: [  386.871244] RIP: 0010:amdgpu_ttm_copy_m=
em_to_mem+0x1af/0x15f0 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.871246] RSP: 0018:ffff8803968be8b8 =
EFLAGS: 00010212
Nov  7 16:52:43 kaveri kernel: [  386.871249] RAX: dffffc0000000000 RBX: =
ffff88038dc10000 RCX: 0000000000022000
Nov  7 16:52:43 kaveri kernel: [  386.871250] RDX: 0000000000000002 RSI: =
ffff8803968beb08 RDI: ffff88038dc167bc
Nov  7 16:52:43 kaveri kernel: [  386.871252] RBP: 0000000000000010 R08: =
ffff880379224628 R09: ffff8803968beac8
Nov  7 16:52:43 kaveri kernel: [  386.871253] R10: ffff8801e7632198 R11: =
0000000000000000 R12: 0000000000000000
Nov  7 16:52:43 kaveri kernel: [  386.871255] R13: ffff8803968beac8 R14: =
ffff880379224490 R15: ffff8803968beb18
Nov  7 16:52:43 kaveri kernel: [  386.871257] FS:  00007f40a6f2f300(0000)=
 GS:ffff8803ae440000(0000) knlGS:0000000000000000
Nov  7 16:52:43 kaveri kernel: [  386.871259] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Nov  7 16:52:43 kaveri kernel: [  386.871260] CR2: 00007f1acabfe000 CR3: =
000000037d946000 CR4: 00000000003406e0
Nov  7 16:52:43 kaveri kernel: [  386.871261] Call Trace:
Nov  7 16:52:43 kaveri kernel: [  386.871320]  ? amdgpu_bo_create+0xba/0x=
880 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.871328]  ? security_capable+0x6d/0x=
a0
Nov  7 16:52:43 kaveri kernel: [  386.871337]  ? ttm_check_swapping+0x26/=
0x240 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871347]  ? ttm_mem_global_alloc_zon=
e.constprop.4+0x1bc/0x290 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871421]  ? amdgpu_copy_buffer+0x7c0=
/0x7c0 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.871431]  ? ttm_pool_populate+0x618/=
0xb40 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871442]  ? ttm_pool_unpopulate+0x29=
0/0x290 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871446]  ? kasan_unpoison_shadow+0x=
30/0x40
Nov  7 16:52:43 kaveri kernel: [  386.871505]  amdgpu_move_blit.constprop=
=2E17+0x227/0x4a0 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.871509]  ? __kmalloc_node+0x170/0x2=
80
Nov  7 16:52:43 kaveri kernel: [  386.871516]  ? ttm_dma_tt_init+0x27a/0x=
520 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871581]  ? amdgpu_ttm_copy_mem_to_m=
em+0x15f0/0x15f0 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.871589]  ? ttm_dma_tt_init+0x27a/0x=
520 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871664]  ? amdgpu_bo_move_notify+0x=
f9/0x310 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.871729]  amdgpu_bo_move+0x227/0x700=
 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.871738]  ttm_bo_handle_move_mem+0x8=
6a/0x2300 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871745]  ? ttm_bo_mem_space+0x54e/0=
xe90 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871812]  ? amdgpu_evict_flags+0x285=
/0x620 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.871821]  ttm_bo_evict+0x3ee/0xc70 [=
ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871845]  ? drm_mm_init+0x4d0/0x4d0 =
[drm]
Nov  7 16:52:43 kaveri kernel: [  386.871853]  ? ttm_bo_handle_move_mem+0=
x2300/0x2300 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871861]  ? ttm_bo_add_to_lru+0x42f/=
0x640 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871869]  ? kmalloc_order+0x4b/0x60
Nov  7 16:52:43 kaveri kernel: [  386.871876]  ttm_mem_evict_first+0x2e0/=
0x460 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871884]  ? ttm_bo_evict+0xc70/0xc70=
 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871892]  ttm_bo_mem_space+0x894/0xe=
90 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871900]  ? ttm_bo_mem_compat+0x6b/0=
x130 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871908]  ttm_bo_validate+0x301/0x53=
0 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871915]  ? ttm_bo_evict_mm+0xa0/0xa=
0 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871919]  ? SyS_membarrier+0x2b0/0x2=
b0
Nov  7 16:52:43 kaveri kernel: [  386.871940]  ? drm_vma_offset_add+0xb4/=
0x180 [drm]
Nov  7 16:52:43 kaveri kernel: [  386.871947]  ttm_bo_init_reserved+0xaf3=
/0x1200 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871955]  ? ttm_bo_validate+0x530/0x=
530 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.871959]  ? get_empty_filp+0x27b/0x5=
30
Nov  7 16:52:43 kaveri kernel: [  386.871962]  ? proc_nr_files+0x30/0x30
Nov  7 16:52:43 kaveri kernel: [  386.871967]  ? _copy_to_user+0x90/0x90
Nov  7 16:52:43 kaveri kernel: [  386.871970]  ? alloc_file+0x16d/0x440
Nov  7 16:52:43 kaveri kernel: [  386.871974]  ? __shmem_file_setup+0x2af=
/0x480
Nov  7 16:52:43 kaveri kernel: [  386.871992]  ? drm_gem_private_object_i=
nit+0x18a/0x2e0 [drm]
Nov  7 16:52:43 kaveri kernel: [  386.871996]  ? kasan_kmalloc+0xa0/0xd0
Nov  7 16:52:43 kaveri kernel: [  386.872068]  amdgpu_bo_do_create+0x549/=
0x1260 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.872133]  ? amdgpu_fill_buffer+0x9f0=
/0x9f0 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.872137]  ? refill_stock+0xf0/0xf0
Nov  7 16:52:43 kaveri kernel: [  386.872207]  ? amdgpu_ttm_placement_fro=
m_domain+0x8a0/0x8a0 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.872212]  ? is_bpf_text_address+0xa/=
0x20
Nov  7 16:52:43 kaveri kernel: [  386.872216]  ? kernel_text_address+0x11=
1/0x120
Nov  7 16:52:43 kaveri kernel: [  386.872220]  ? __kernel_text_address+0x=
e/0x30
Nov  7 16:52:43 kaveri kernel: [  386.872224]  ? unwind_get_return_addres=
s+0x5f/0xa0
Nov  7 16:52:43 kaveri kernel: [  386.872228]  ? __pv_queued_spin_lock_sl=
owpath+0x1100/0x1100
Nov  7 16:52:43 kaveri kernel: [  386.872232]  ? mem_cgroup_uncharge_swap=
+0xc0/0xc0
Nov  7 16:52:43 kaveri kernel: [  386.872236]  ? save_stack+0x32/0xb0
Nov  7 16:52:43 kaveri kernel: [  386.872238]  ? kasan_kmalloc+0xa0/0xd0
Nov  7 16:52:43 kaveri kernel: [  386.872241]  ? kmem_cache_alloc+0xb6/0x=
1c0
Nov  7 16:52:43 kaveri kernel: [  386.872245]  ? __anon_vma_prepare+0x357=
/0x5e0
Nov  7 16:52:43 kaveri kernel: [  386.872248]  ? memcg_oom_wake_function+=
0x6e0/0x6e0
Nov  7 16:52:43 kaveri kernel: [  386.872251]  ? do_page_fault+0x93/0x320=

Nov  7 16:52:43 kaveri kernel: [  386.872257]  ? rb_insert_color_cached+0=
x1070/0x1070
Nov  7 16:52:43 kaveri kernel: [  386.872326]  amdgpu_bo_create+0xba/0x88=
0 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.872335]  ? ttm_bo_release_list+0x7d=
0/0x7d0 [ttm]
Nov  7 16:52:43 kaveri kernel: [  386.872338]  ? unwind_get_return_addres=
s+0x5f/0xa0
Nov  7 16:52:43 kaveri kernel: [  386.872408]  ? amdgpu_bo_do_create+0x12=
60/0x1260 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.872412]  ? mem_cgroup_try_charge+0x=
23b/0x920
Nov  7 16:52:43 kaveri kernel: [  386.872416]  ? __alloc_pages_nodemask+0=
x3c3/0xb70
Nov  7 16:52:43 kaveri kernel: [  386.872420]  ? mem_cgroup_low+0x1e0/0x1=
e0
Nov  7 16:52:43 kaveri kernel: [  386.872423]  ? page_mkclean.part.34+0x1=
0/0x10
Nov  7 16:52:43 kaveri kernel: [  386.872497]  amdgpu_gem_object_create+0=
x10d/0x210 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.872569]  ? amdgpu_gem_object_free+0=
x180/0x180 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.872574]  ? __ww_mutex_lock_interrup=
tible_slowpath+0x20/0x20
Nov  7 16:52:43 kaveri kernel: [  386.872579]  ? lru_cache_add_active_or_=
unevictable+0x112/0x2b0
Nov  7 16:52:43 kaveri kernel: [  386.872651]  amdgpu_gem_create_ioctl+0x=
37d/0xa10 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.872727]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.872731]  ? __handle_mm_fault+0x1d3b=
/0x4950
Nov  7 16:52:43 kaveri kernel: [  386.872735]  ? __pmd_alloc+0x300/0x300
Nov  7 16:52:43 kaveri kernel: [  386.872738]  ? vma_set_page_prot+0x10b/=
0x220
Nov  7 16:52:43 kaveri kernel: [  386.872741]  ? vma_wants_writenotify+0x=
370/0x370
Nov  7 16:52:43 kaveri kernel: [  386.872745]  ? __check_object_size+0x21=
7/0x4a0
Nov  7 16:52:43 kaveri kernel: [  386.872820]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.872840]  drm_ioctl_kernel+0x1ba/0x2=
c0 [drm]
Nov  7 16:52:43 kaveri kernel: [  386.872861]  ? drm_ioctl_permit+0x2b0/0=
x2b0 [drm]
Nov  7 16:52:43 kaveri kernel: [  386.872883]  drm_ioctl+0x720/0xa30 [drm=
]
Nov  7 16:52:43 kaveri kernel: [  386.872958]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.872979]  ? drm_getstats+0x20/0x20 [=
drm]
Nov  7 16:52:43 kaveri kernel: [  386.872984]  ? mem_cgroup_reset+0x290/0=
x290
Nov  7 16:52:43 kaveri kernel: [  386.872987]  ? do_mmap+0x608/0xee0
Nov  7 16:52:43 kaveri kernel: [  386.873060]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Nov  7 16:52:43 kaveri kernel: [  386.873065]  do_vfs_ioctl+0x18f/0x1270
Nov  7 16:52:43 kaveri kernel: [  386.873069]  ? __do_page_fault+0x4ee/0x=
b10
Nov  7 16:52:43 kaveri kernel: [  386.873072]  ? ioctl_preallocate+0x2a0/=
0x2a0
Nov  7 16:52:43 kaveri kernel: [  386.873076]  ? __fget_light+0x2b0/0x3b0=

Nov  7 16:52:43 kaveri kernel: [  386.873079]  ? iterate_fd+0x2a0/0x2a0
Nov  7 16:52:43 kaveri kernel: [  386.873083]  ? do_page_fault+0x93/0x320=

Nov  7 16:52:43 kaveri kernel: [  386.873087]  ? __do_page_fault+0xb10/0x=
b10
Nov  7 16:52:43 kaveri kernel: [  386.873090]  ? SyS_mmap_pgoff+0x1e8/0x5=
e0
Nov  7 16:52:43 kaveri kernel: [  386.873093]  ? SyS_write+0x128/0x1e0
Nov  7 16:52:43 kaveri kernel: [  386.873096]  ? do_munmap+0xcf0/0xcf0
Nov  7 16:52:43 kaveri kernel: [  386.873100]  SyS_ioctl+0x74/0x80
Nov  7 16:52:43 kaveri kernel: [  386.873104]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Nov  7 16:52:43 kaveri kernel: [  386.873109] RIP: 0033:0x7f40a3bd3dc7
Nov  7 16:52:43 kaveri kernel: [  386.873111] RSP: 002b:00007ffc11109a58 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Nov  7 16:52:43 kaveri kernel: [  386.873115] RAX: ffffffffffffffda RBX: =
00007f40a3e8ab00 RCX: 00007f40a3bd3dc7
Nov  7 16:52:43 kaveri kernel: [  386.873117] RDX: 00007ffc11109aa0 RSI: =
00000000c0206440 RDI: 0000000000000006
Nov  7 16:52:43 kaveri kernel: [  386.873120] RBP: 0000000040000010 R08: =
00007f40a3e8b008 R09: 0000000000000060
Nov  7 16:52:43 kaveri kernel: [  386.873123] R10: 0000000000000004 R11: =
0000000000000246 R12: 0000000040001000
Nov  7 16:52:43 kaveri kernel: [  386.873125] R13: 00007f40a3e8ab58 R14: =
0000000000001000 R15: 00007f40a3e8ab00
Nov  7 16:52:43 kaveri kernel: [  386.873129] Code: c1 ea 03 80 3c 02 00 =
0f 85 e9 0f 00 00 48 8b 44 24 20 49 8d 6b 10 48 89 ea 4c 8b 60 10 48 c1 e=
a 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 0f 85 ac 0f 00 00 49 8b =
43 10 48 c1 e0 0c 4c 39 e0=20
Nov  7 16:52:43 kaveri kernel: [  386.873242] RIP: amdgpu_ttm_copy_mem_to=
_mem+0x1af/0x15f0 [amdgpu] RSP: ffff8803968be8b8
Nov  7 16:52:43 kaveri kernel: [  386.873247] ---[ end trace 23c44df0d7d0=
392a ]---
Nov  7 16:54:45 kaveri kernel: [  508.486354] kasan: CONFIG_KASAN_INLINE =
enabled
Nov  7 16:54:45 kaveri kernel: [  508.486359] kasan: GPF could be caused =
by NULL-ptr deref or user memory access
Nov  7 16:54:45 kaveri kernel: [  508.486363] general protection fault: 0=
000 [#2] SMP KASAN
Nov  7 16:54:45 kaveri kernel: [  508.486365] Modules linked in: lz4 lz4_=
compress cpufreq_powersave cpufreq_userspace cpufreq_conservative binfmt_=
misc nls_ascii nls_cp437 vfat fat amdgpu(O) edac_mce_amd amdkfd(O) radeon=
(O) kvm irqbypass crct10dif_pclmul crc32_pclmul chash snd_hda_codec_realt=
ek ghash_clmulni_intel pcbc snd_hda_codec_generic ttm(O) snd_hda_codec_hd=
mi efi_pstore drm_kms_helper(O) snd_hda_intel snd_hda_codec drm(O) snd_hd=
a_core snd_hwdep aesni_intel snd_pcm i2c_algo_bit ccp aes_x86_64 fb_sys_f=
ops crypto_simd r8169 syscopyarea glue_helper wmi_bmof ppdev sysfillrect =
snd_timer cryptd sysimgblt mii sg pcspkr mfd_core efivars rng_core snd sp=
5100_tco soundcore i2c_piix4 wmi parport_pc parport i2c_designware_platfo=
rm i2c_designware_core button acpi_cpufreq tcp_bbr sch_fq nct6775 hwmon_v=
id sunrpc efivarfs ip_tables x_tables
Nov  7 16:54:45 kaveri kernel: [  508.486402]  autofs4 ext4 crc16 mbcache=
 jbd2 fscrypto dm_mod raid10 raid1 raid0 multipath linear md_mod sd_mod e=
vdev hid_generic usbhid hid ahci libahci libata xhci_pci xhci_hcd crc32c_=
intel usbcore scsi_mod shpchp gpio_amdpt gpio_generic
Nov  7 16:54:45 kaveri kernel: [  508.486419] CPU: 4 PID: 4444 Comm: tex3=
d-maxsize Tainted: G      D    O    4.14.0-rc3+ #32
Nov  7 16:54:45 kaveri kernel: [  508.486421] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Nov  7 16:54:45 kaveri kernel: [  508.486423] task: ffff880397454d80 task=
=2Estack: ffff88037daf8000
Nov  7 16:54:45 kaveri kernel: [  508.486469] RIP: 0010:amdgpu_ttm_copy_m=
em_to_mem+0x1af/0x15f0 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.486470] RSP: 0018:ffff88037dafe8b8 =
EFLAGS: 00010212
Nov  7 16:54:45 kaveri kernel: [  508.486473] RAX: dffffc0000000000 RBX: =
ffff88038dc10000 RCX: 0000000000020000
Nov  7 16:54:45 kaveri kernel: [  508.486474] RDX: 0000000000000002 RSI: =
ffff88037dafeb08 RDI: ffff88038dc167bc
Nov  7 16:54:45 kaveri kernel: [  508.486476] RBP: 0000000000000010 R08: =
ffff88018ac99328 R09: ffff88037dafeac8
Nov  7 16:54:45 kaveri kernel: [  508.486478] R10: ffff880380eb8978 R11: =
0000000000000000 R12: 0000000000000000
Nov  7 16:54:45 kaveri kernel: [  508.486479] R13: ffff88037dafeac8 R14: =
ffff88018ac99190 R15: ffff88037dafeb18
Nov  7 16:54:45 kaveri kernel: [  508.486481] FS:  00007fc2f98e8300(0000)=
 GS:ffff8803ae500000(0000) knlGS:0000000000000000
Nov  7 16:54:45 kaveri kernel: [  508.486483] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Nov  7 16:54:45 kaveri kernel: [  508.486484] CR2: 0000000000768573 CR3: =
000000017cee9000 CR4: 00000000003406e0
Nov  7 16:54:45 kaveri kernel: [  508.486486] Call Trace:
Nov  7 16:54:45 kaveri kernel: [  508.486528]  ? amdgpu_bo_create+0xba/0x=
880 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.486533]  ? security_capable+0x6d/0x=
a0
Nov  7 16:54:45 kaveri kernel: [  508.486538]  ? ttm_check_swapping+0x26/=
0x240 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486543]  ? ttm_mem_global_alloc_zon=
e.constprop.4+0x1bc/0x290 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486584]  ? amdgpu_copy_buffer+0x7c0=
/0x7c0 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.486590]  ? ttm_pool_populate+0x618/=
0xb40 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486596]  ? ttm_pool_unpopulate+0x29=
0/0x290 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486599]  ? kasan_unpoison_shadow+0x=
30/0x40
Nov  7 16:54:45 kaveri kernel: [  508.486640]  amdgpu_move_blit.constprop=
=2E17+0x227/0x4a0 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.486643]  ? __kmalloc_node+0x170/0x2=
80
Nov  7 16:54:45 kaveri kernel: [  508.486647]  ? ttm_dma_tt_init+0x27a/0x=
520 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486687]  ? amdgpu_ttm_copy_mem_to_m=
em+0x15f0/0x15f0 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.486692]  ? ttm_dma_tt_init+0x27a/0x=
520 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486733]  ? amdgpu_bo_move_notify+0x=
f9/0x310 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.486774]  amdgpu_bo_move+0x227/0x700=
 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.486780]  ttm_bo_handle_move_mem+0x8=
6a/0x2300 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486785]  ? ttm_bo_mem_space+0x54e/0=
xe90 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486826]  ? amdgpu_evict_flags+0x285=
/0x620 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.486831]  ttm_bo_evict+0x3ee/0xc70 [=
ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486845]  ? drm_mm_init+0x4d0/0x4d0 =
[drm]
Nov  7 16:54:45 kaveri kernel: [  508.486850]  ? ttm_bo_handle_move_mem+0=
x2300/0x2300 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486855]  ? ttm_bo_add_to_lru+0x42f/=
0x640 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486858]  ? bpf_prog_alloc+0x2d0/0x2=
d0
Nov  7 16:54:45 kaveri kernel: [  508.486861]  ? deref_stack_reg+0x1f0/0x=
1f0
Nov  7 16:54:45 kaveri kernel: [  508.486864]  ? kmalloc_order+0x4b/0x60
Nov  7 16:54:45 kaveri kernel: [  508.486869]  ttm_mem_evict_first+0x2e0/=
0x460 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486875]  ? ttm_bo_evict+0xc70/0xc70=
 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486880]  ttm_bo_mem_space+0x894/0xe=
90 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486886]  ? ttm_bo_mem_compat+0x6b/0=
x130 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486891]  ttm_bo_validate+0x301/0x53=
0 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486896]  ? ttm_bo_evict_mm+0xa0/0xa=
0 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486900]  ? SyS_membarrier+0x2b0/0x2=
b0
Nov  7 16:54:45 kaveri kernel: [  508.486914]  ? drm_vma_offset_add+0xb4/=
0x180 [drm]
Nov  7 16:54:45 kaveri kernel: [  508.486920]  ttm_bo_init_reserved+0xaf3=
/0x1200 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486926]  ? ttm_bo_validate+0x530/0x=
530 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.486929]  ? get_empty_filp+0x27b/0x5=
30
Nov  7 16:54:45 kaveri kernel: [  508.486930]  ? proc_nr_files+0x30/0x30
Nov  7 16:54:45 kaveri kernel: [  508.486935]  ? _copy_to_user+0x90/0x90
Nov  7 16:54:45 kaveri kernel: [  508.486937]  ? __read_once_size_nocheck=
=2Econstprop.6+0x10/0x10
Nov  7 16:54:45 kaveri kernel: [  508.486940]  ? entry_SYSCALL_64_fastpat=
h+0x1e/0xa9
Nov  7 16:54:45 kaveri kernel: [  508.486942]  ? alloc_file+0x16d/0x440
Nov  7 16:54:45 kaveri kernel: [  508.486945]  ? __shmem_file_setup+0x2af=
/0x480
Nov  7 16:54:45 kaveri kernel: [  508.486957]  ? drm_gem_private_object_i=
nit+0x18a/0x2e0 [drm]
Nov  7 16:54:45 kaveri kernel: [  508.486959]  ? kasan_kmalloc+0xa0/0xd0
Nov  7 16:54:45 kaveri kernel: [  508.487000]  amdgpu_bo_do_create+0x549/=
0x1260 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487040]  ? amdgpu_fill_buffer+0x9f0=
/0x9f0 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487044]  ? refill_stock+0xf0/0xf0
Nov  7 16:54:45 kaveri kernel: [  508.487084]  ? amdgpu_ttm_placement_fro=
m_domain+0x8a0/0x8a0 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487086]  ? deref_stack_reg+0x1f0/0x=
1f0
Nov  7 16:54:45 kaveri kernel: [  508.487089]  ? __kernel_text_address+0x=
e/0x30
Nov  7 16:54:45 kaveri kernel: [  508.487091]  ? unwind_get_return_addres=
s+0x5f/0xa0
Nov  7 16:54:45 kaveri kernel: [  508.487093]  ? wake_up_page_bit+0x4d0/0=
x4d0
Nov  7 16:54:45 kaveri kernel: [  508.487096]  ? __free_insn_slot+0x4c0/0=
x4c0
Nov  7 16:54:45 kaveri kernel: [  508.487099]  ? __pv_queued_spin_lock_sl=
owpath+0x1100/0x1100
Nov  7 16:54:45 kaveri kernel: [  508.487102]  ? mem_cgroup_uncharge_swap=
+0xc0/0xc0
Nov  7 16:54:45 kaveri kernel: [  508.487104]  ? kernel_text_address+0x11=
1/0x120
Nov  7 16:54:45 kaveri kernel: [  508.487106]  ? find_get_entries_tag+0xd=
a0/0xda0
Nov  7 16:54:45 kaveri kernel: [  508.487108]  ? __kernel_text_address+0x=
e/0x30
Nov  7 16:54:45 kaveri kernel: [  508.487110]  ? memcg_oom_wake_function+=
0x6e0/0x6e0
Nov  7 16:54:45 kaveri kernel: [  508.487114]  ? depot_save_stack+0x12d/0=
x470
Nov  7 16:54:45 kaveri kernel: [  508.487155]  amdgpu_bo_create+0xba/0x88=
0 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487160]  ? ttm_bo_release_list+0x7d=
0/0x7d0 [ttm]
Nov  7 16:54:45 kaveri kernel: [  508.487200]  ? amdgpu_bo_do_create+0x12=
60/0x1260 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487202]  ? mem_cgroup_try_charge+0x=
23b/0x920
Nov  7 16:54:45 kaveri kernel: [  508.487205]  ? __alloc_pages_nodemask+0=
x3c3/0xb70
Nov  7 16:54:45 kaveri kernel: [  508.487207]  ? mem_cgroup_low+0x1e0/0x1=
e0
Nov  7 16:54:45 kaveri kernel: [  508.487210]  ? page_mkclean.part.34+0x1=
0/0x10
Nov  7 16:54:45 kaveri kernel: [  508.487251]  amdgpu_gem_object_create+0=
x10d/0x210 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487293]  ? amdgpu_gem_object_free+0=
x180/0x180 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487296]  ? __ww_mutex_lock_interrup=
tible_slowpath+0x20/0x20
Nov  7 16:54:45 kaveri kernel: [  508.487299]  ? lru_cache_add_active_or_=
unevictable+0x112/0x2b0
Nov  7 16:54:45 kaveri kernel: [  508.487340]  amdgpu_gem_create_ioctl+0x=
37d/0xa10 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487383]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487385]  ? __handle_mm_fault+0x1d3b=
/0x4950
Nov  7 16:54:45 kaveri kernel: [  508.487387]  ? __pmd_alloc+0x300/0x300
Nov  7 16:54:45 kaveri kernel: [  508.487390]  ? do_futex+0xa60/0x1c50
Nov  7 16:54:45 kaveri kernel: [  508.487393]  ? __check_object_size+0x21=
7/0x4a0
Nov  7 16:54:45 kaveri kernel: [  508.487433]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487445]  drm_ioctl_kernel+0x1ba/0x2=
c0 [drm]
Nov  7 16:54:45 kaveri kernel: [  508.487457]  ? drm_ioctl_permit+0x2b0/0=
x2b0 [drm]
Nov  7 16:54:45 kaveri kernel: [  508.487469]  drm_ioctl+0x720/0xa30 [drm=
]
Nov  7 16:54:45 kaveri kernel: [  508.487510]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487521]  ? drm_getstats+0x20/0x20 [=
drm]
Nov  7 16:54:45 kaveri kernel: [  508.487524]  ? set_fd_set.part.1+0x50/0=
x50
Nov  7 16:54:45 kaveri kernel: [  508.487527]  ? mem_cgroup_reset+0x290/0=
x290
Nov  7 16:54:45 kaveri kernel: [  508.487529]  ? iterate_fd+0x2a0/0x2a0
Nov  7 16:54:45 kaveri kernel: [  508.487569]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Nov  7 16:54:45 kaveri kernel: [  508.487571]  do_vfs_ioctl+0x18f/0x1270
Nov  7 16:54:45 kaveri kernel: [  508.487574]  ? __do_page_fault+0x4ee/0x=
b10
Nov  7 16:54:45 kaveri kernel: [  508.487576]  ? ioctl_preallocate+0x2a0/=
0x2a0
Nov  7 16:54:45 kaveri kernel: [  508.487578]  ? __fget_light+0x2b0/0x3b0=

Nov  7 16:54:45 kaveri kernel: [  508.487580]  ? iterate_fd+0x2a0/0x2a0
Nov  7 16:54:45 kaveri kernel: [  508.487583]  ? do_page_fault+0x93/0x320=

Nov  7 16:54:45 kaveri kernel: [  508.487585]  ? __do_page_fault+0xb10/0x=
b10
Nov  7 16:54:45 kaveri kernel: [  508.487587]  SyS_ioctl+0x74/0x80
Nov  7 16:54:45 kaveri kernel: [  508.487590]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Nov  7 16:54:45 kaveri kernel: [  508.487592] RIP: 0033:0x7fc2f658cdc7
Nov  7 16:54:45 kaveri kernel: [  508.487593] RSP: 002b:00007ffd7d2bd8a8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Nov  7 16:54:45 kaveri kernel: [  508.487595] RAX: ffffffffffffffda RBX: =
000000000000a840 RCX: 00007fc2f658cdc7
Nov  7 16:54:45 kaveri kernel: [  508.487597] RDX: 00007ffd7d2bd8f0 RSI: =
00000000c0206440 RDI: 0000000000000006
Nov  7 16:54:45 kaveri kernel: [  508.487598] RBP: 000056400a2e7820 R08: =
00007fc2f68442c8 R09: 0000000000000060
Nov  7 16:54:45 kaveri kernel: [  508.487599] R10: 0000000000000004 R11: =
0000000000000246 R12: 0000000000000080
Nov  7 16:54:45 kaveri kernel: [  508.487601] R13: 00007fc2f6843b58 R14: =
000056400a2dcf60 R15: 00007fc2f6843b00
Nov  7 16:54:45 kaveri kernel: [  508.487603] Code: c1 ea 03 80 3c 02 00 =
0f 85 e9 0f 00 00 48 8b 44 24 20 49 8d 6b 10 48 89 ea 4c 8b 60 10 48 c1 e=
a 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 0f 85 ac 0f 00 00 49 8b =
43 10 48 c1 e0 0c 4c 39 e0=20
Nov  7 16:54:45 kaveri kernel: [  508.487667] RIP: amdgpu_ttm_copy_mem_to=
_mem+0x1af/0x15f0 [amdgpu] RSP: ffff88037dafe8b8
Nov  7 16:54:45 kaveri kernel: [  508.487669] ---[ end trace 23c44df0d7d0=
392b ]---
[...]
Nov  7 16:56:35 kaveri kernel: [  622.586891] kasan: CONFIG_KASAN_INLINE =
enabled
Nov  7 16:56:35 kaveri kernel: [  622.586900] kasan: GPF could be caused =
by NULL-ptr deref or user memory access
Nov  7 16:56:35 kaveri kernel: [  622.586905] general protection fault: 0=
000 [#3] SMP KASAN
Nov  7 16:56:35 kaveri kernel: [  622.586908] Modules linked in: lz4 lz4_=
compress cpufreq_powersave cpufreq_userspace cpufreq_conservative binfmt_=
misc nls_ascii nls_cp437 vfat fat amdgpu(O) edac_mce_amd amdkfd(O) radeon=
(O) kvm irqbypass crct10dif_pclmul crc32_pclmul chash snd_hda_codec_realt=
ek ghash_clmulni_intel pcbc snd_hda_codec_generic ttm(O) snd_hda_codec_hd=
mi efi_pstore drm_kms_helper(O) snd_hda_intel snd_hda_codec drm(O) snd_hd=
a_core snd_hwdep aesni_intel snd_pcm i2c_algo_bit ccp aes_x86_64 fb_sys_f=
ops crypto_simd r8169 syscopyarea glue_helper wmi_bmof ppdev sysfillrect =
snd_timer cryptd sysimgblt mii sg pcspkr mfd_core efivars rng_core snd sp=
5100_tco soundcore i2c_piix4 wmi parport_pc parport i2c_designware_platfo=
rm i2c_designware_core button acpi_cpufreq tcp_bbr sch_fq nct6775 hwmon_v=
id sunrpc efivarfs ip_tables x_tables
Nov  7 16:56:35 kaveri kernel: [  622.586959]  autofs4 ext4 crc16 mbcache=
 jbd2 fscrypto dm_mod raid10 raid1 raid0 multipath linear md_mod sd_mod e=
vdev hid_generic usbhid hid ahci libahci libata xhci_pci xhci_hcd crc32c_=
intel usbcore scsi_mod shpchp gpio_amdpt gpio_generic
Nov  7 16:56:35 kaveri kernel: [  622.586983] CPU: 13 PID: 29609 Comm: fb=
o-maxsize Tainted: G      D    O    4.14.0-rc3+ #32
Nov  7 16:56:35 kaveri kernel: [  622.586986] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Nov  7 16:56:35 kaveri kernel: [  622.586990] task: ffff880382475d00 task=
=2Estack: ffff8803a5388000
Nov  7 16:56:35 kaveri kernel: [  622.587063] RIP: 0010:amdgpu_ttm_copy_m=
em_to_mem+0x1af/0x15f0 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.587066] RSP: 0018:ffff8803a538e8b8 =
EFLAGS: 00010212
Nov  7 16:56:35 kaveri kernel: [  622.587070] RAX: dffffc0000000000 RBX: =
ffff88038dc10000 RCX: 0000000000020000
Nov  7 16:56:35 kaveri kernel: [  622.587072] RDX: 0000000000000002 RSI: =
ffff8803a538eb08 RDI: ffff88038dc167bc
Nov  7 16:56:35 kaveri kernel: [  622.587075] RBP: 0000000000000010 R08: =
ffff88037877c628 R09: ffff8803a538eac8
Nov  7 16:56:35 kaveri kernel: [  622.587077] R10: ffff880391e10e78 R11: =
0000000000000000 R12: 0000000000000000
Nov  7 16:56:35 kaveri kernel: [  622.587079] R13: ffff8803a538eac8 R14: =
ffff88037877c490 R15: ffff8803a538eb18
Nov  7 16:56:35 kaveri kernel: [  622.587083] FS:  00007f2c9a97b300(0000)=
 GS:ffff8803ae740000(0000) knlGS:0000000000000000
Nov  7 16:56:35 kaveri kernel: [  622.587085] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Nov  7 16:56:35 kaveri kernel: [  622.587088] CR2: 000055a76d8e70f8 CR3: =
00000003a7f7f000 CR4: 00000000003406e0
Nov  7 16:56:35 kaveri kernel: [  622.587090] Call Trace:
Nov  7 16:56:35 kaveri kernel: [  622.587164]  ? amdgpu_bo_create+0xba/0x=
880 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.587170]  ? security_capable+0x6d/0x=
a0
Nov  7 16:56:35 kaveri kernel: [  622.587178]  ? ttm_check_swapping+0x26/=
0x240 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587186]  ? ttm_mem_global_alloc_zon=
e.constprop.4+0x1bc/0x290 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587248]  ? amdgpu_copy_buffer+0x7c0=
/0x7c0 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.587257]  ? ttm_pool_populate+0x618/=
0xb40 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587266]  ? ttm_pool_unpopulate+0x29=
0/0x290 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587270]  ? kasan_unpoison_shadow+0x=
30/0x40
Nov  7 16:56:35 kaveri kernel: [  622.587331]  amdgpu_move_blit.constprop=
=2E17+0x227/0x4a0 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.587336]  ? __kmalloc_node+0x170/0x2=
80
Nov  7 16:56:35 kaveri kernel: [  622.587344]  ? ttm_dma_tt_init+0x27a/0x=
520 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587417]  ? amdgpu_ttm_copy_mem_to_m=
em+0x15f0/0x15f0 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.587424]  ? ttm_dma_tt_init+0x27a/0x=
520 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587486]  ? amdgpu_bo_move_notify+0x=
f9/0x310 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.587549]  amdgpu_bo_move+0x227/0x700=
 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.587558]  ttm_bo_handle_move_mem+0x8=
6a/0x2300 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587566]  ? ttm_bo_mem_space+0x54e/0=
xe90 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587638]  ? amdgpu_evict_flags+0x285=
/0x620 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.587647]  ttm_bo_evict+0x3ee/0xc70 [=
ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587669]  ? drm_mm_init+0x4d0/0x4d0 =
[drm]
Nov  7 16:56:35 kaveri kernel: [  622.587677]  ? ttm_bo_handle_move_mem+0=
x2300/0x2300 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587684]  ? ttm_bo_add_to_lru+0x42f/=
0x640 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587691]  ? kmalloc_order+0x4b/0x60
Nov  7 16:56:35 kaveri kernel: [  622.587698]  ttm_mem_evict_first+0x2e0/=
0x460 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587706]  ? ttm_bo_evict+0xc70/0xc70=
 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587714]  ttm_bo_mem_space+0x894/0xe=
90 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587722]  ? ttm_bo_mem_compat+0x6b/0=
x130 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587730]  ttm_bo_validate+0x301/0x53=
0 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587738]  ? ttm_bo_evict_mm+0xa0/0xa=
0 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587742]  ? SyS_membarrier+0x2b0/0x2=
b0
Nov  7 16:56:35 kaveri kernel: [  622.587763]  ? drm_vma_offset_add+0xb4/=
0x180 [drm]
Nov  7 16:56:35 kaveri kernel: [  622.587772]  ttm_bo_init_reserved+0xaf3=
/0x1200 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587780]  ? ttm_bo_validate+0x530/0x=
530 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.587784]  ? get_empty_filp+0x27b/0x5=
30
Nov  7 16:56:35 kaveri kernel: [  622.587787]  ? proc_nr_files+0x30/0x30
Nov  7 16:56:35 kaveri kernel: [  622.587792]  ? _copy_to_user+0x90/0x90
Nov  7 16:56:35 kaveri kernel: [  622.587796]  ? update_blocked_averages+=
0x1b00/0x1b00
Nov  7 16:56:35 kaveri kernel: [  622.587799]  ? alloc_file+0x16d/0x440
Nov  7 16:56:35 kaveri kernel: [  622.587803]  ? __shmem_file_setup+0x2af=
/0x480
Nov  7 16:56:35 kaveri kernel: [  622.587820]  ? drm_gem_private_object_i=
nit+0x18a/0x2e0 [drm]
Nov  7 16:56:35 kaveri kernel: [  622.587824]  ? kasan_kmalloc+0xa0/0xd0
Nov  7 16:56:35 kaveri kernel: [  622.587895]  amdgpu_bo_do_create+0x549/=
0x1260 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.587961]  ? amdgpu_fill_buffer+0x9f0=
/0x9f0 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.588010]  ? amdgpu_ttm_placement_fro=
m_domain+0x8a0/0x8a0 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.588014]  ? schedule+0xec/0x3a0
Nov  7 16:56:35 kaveri kernel: [  622.588016]  ? __schedule+0x1c50/0x1c50=

Nov  7 16:56:35 kaveri kernel: [  622.588019]  ? plist_add+0x7d0/0x7d0
Nov  7 16:56:35 kaveri kernel: [  622.588022]  ? check_preempt_curr+0x1d9=
/0x2b0
Nov  7 16:56:35 kaveri kernel: [  622.588026]  ? futex_wait_queue_me+0x3c=
b/0x670
Nov  7 16:56:35 kaveri kernel: [  622.588028]  ? sched_clock_cpu+0x18/0x1=
60
Nov  7 16:56:35 kaveri kernel: [  622.588030]  ? refill_pi_state_cache.pa=
rt.7+0x300/0x300
Nov  7 16:56:35 kaveri kernel: [  622.588033]  ? futex_wait_setup+0x138/0=
x320
Nov  7 16:56:35 kaveri kernel: [  622.588073]  amdgpu_bo_create+0xba/0x88=
0 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.588081]  ? ttm_bo_release_list+0x7d=
0/0x7d0 [ttm]
Nov  7 16:56:35 kaveri kernel: [  622.588084]  ? fault_in_user_writeable+=
0x90/0x90
Nov  7 16:56:35 kaveri kernel: [  622.588158]  ? amdgpu_bo_do_create+0x12=
60/0x1260 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.588162]  ? futex_wait+0x6e3/0x8c0
Nov  7 16:56:35 kaveri kernel: [  622.588210]  amdgpu_gem_object_create+0=
x10d/0x210 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.588259]  ? amdgpu_gem_object_free+0=
x180/0x180 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.588263]  ? __ww_mutex_lock_interrup=
tible_slowpath+0x20/0x20
Nov  7 16:56:35 kaveri kernel: [  622.588320]  amdgpu_gem_create_ioctl+0x=
37d/0xa10 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.588383]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.588388]  ? __switch_to+0x521/0xc30
Nov  7 16:56:35 kaveri kernel: [  622.588392]  ? do_futex+0xa60/0x1c50
Nov  7 16:56:35 kaveri kernel: [  622.588396]  ? __check_object_size+0x21=
7/0x4a0
Nov  7 16:56:35 kaveri kernel: [  622.588468]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.588489]  drm_ioctl_kernel+0x1ba/0x2=
c0 [drm]
Nov  7 16:56:35 kaveri kernel: [  622.588507]  ? drm_ioctl_permit+0x2b0/0=
x2b0 [drm]
Nov  7 16:56:35 kaveri kernel: [  622.588524]  drm_ioctl+0x720/0xa30 [drm=
]
Nov  7 16:56:35 kaveri kernel: [  622.588588]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.588605]  ? drm_getstats+0x20/0x20 [=
drm]
Nov  7 16:56:35 kaveri kernel: [  622.588668]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Nov  7 16:56:35 kaveri kernel: [  622.588674]  do_vfs_ioctl+0x18f/0x1270
Nov  7 16:56:35 kaveri kernel: [  622.588678]  ? ioctl_preallocate+0x2a0/=
0x2a0
Nov  7 16:56:35 kaveri kernel: [  622.588682]  ? __fget_light+0x2b0/0x3b0=

Nov  7 16:56:35 kaveri kernel: [  622.588685]  ? iterate_fd+0x2a0/0x2a0
Nov  7 16:56:35 kaveri kernel: [  622.588689]  ? SYSC_newfstat+0x7c/0xd0
Nov  7 16:56:35 kaveri kernel: [  622.588692]  ? SYSC_newfstatat+0xd0/0xd=
0
Nov  7 16:56:35 kaveri kernel: [  622.588697]  SyS_ioctl+0x74/0x80
Nov  7 16:56:35 kaveri kernel: [  622.588701]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Nov  7 16:56:35 kaveri kernel: [  622.588704] RIP: 0033:0x7f2c9761fdc7
Nov  7 16:56:35 kaveri kernel: [  622.588706] RSP: 002b:00007ffd24df2e28 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Nov  7 16:56:35 kaveri kernel: [  622.588710] RAX: ffffffffffffffda RBX: =
000055d5ee7f7bc0 RCX: 00007f2c9761fdc7
Nov  7 16:56:35 kaveri kernel: [  622.588712] RDX: 00007ffd24df2e70 RSI: =
00000000c0206440 RDI: 0000000000000006
Nov  7 16:56:35 kaveri kernel: [  622.588714] RBP: 00007ffd24df2e70 R08: =
00007f2c978d6ca8 R09: 0000000000000060
Nov  7 16:56:35 kaveri kernel: [  622.588717] R10: 0000000000000004 R11: =
0000000000000246 R12: 000055d5ee825e18
Nov  7 16:56:35 kaveri kernel: [  622.588719] R13: 00007f2c934093a0 R14: =
000055d5ee81dc40 R15: 000055d5ee7f7bb8
Nov  7 16:56:35 kaveri kernel: [  622.588723] Code: c1 ea 03 80 3c 02 00 =
0f 85 e9 0f 00 00 48 8b 44 24 20 49 8d 6b 10 48 89 ea 4c 8b 60 10 48 c1 e=
a 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 0f 85 ac 0f 00 00 49 8b =
43 10 48 c1 e0 0c 4c 39 e0=20
Nov  7 16:56:35 kaveri kernel: [  622.588820] RIP: amdgpu_ttm_copy_mem_to=
_mem+0x1af/0x15f0 [amdgpu] RSP: ffff8803a538e8b8
Nov  7 16:56:35 kaveri kernel: [  622.588843] ---[ end trace 23c44df0d7d0=
392c ]---

--------------D961C7D70F401DB49874AFA8
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------D961C7D70F401DB49874AFA8--

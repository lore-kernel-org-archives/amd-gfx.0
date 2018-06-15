From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Use kvmalloc_array for allocating VRAM
 manager nodes array
Date: Fri, 15 Jun 2018 17:12:16 +0200
Message-ID: <317a26cc-93f7-0a7b-1004-a74f60d7ae57@daenzer.net>
References: <20180615142717.14475-1-michel@daenzer.net>
 <8be0b1bc-09aa-8ed1-7e2c-67a9f9802bdf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------E68C0E9ABABF64A0359D23A0"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8be0b1bc-09aa-8ed1-7e2c-67a9f9802bdf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------E68C0E9ABABF64A0359D23A0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2018-06-15 05:05 PM, Christian König wrote:
> Am 15.06.2018 um 16:27 schrieb Michel Dänzer:
>> From: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>>
>> It can be quite big, and there's no need for it to be physically
>> contiguous. This is less likely to fail under memory pressure (has
>> actually happened while running piglit).
> 
> Mhm, the last time I looked a drm_mm node had around 160 bytes, which
> means that you need to allocate more than 50MB of VRAM to fill up a 4K
> page.

I'm attaching the failure that prompted me to write this patch. It was
trying to allocate order 5, i.e. more than 16 pages / 64 KB.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------E68C0E9ABABF64A0359D23A0
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Jun  7 14:45:58 kaveri kernel: [ 6797.305204] amdgpu_cs:0: page allocatio=
n failure: order:5, mode:0x140c0c0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nod=
emask=3D(null)
Jun  7 14:45:58 kaveri kernel: [ 6797.305216] amdgpu_cs:0 cpuset=3D/ mems=
_allowed=3D0
Jun  7 14:45:58 kaveri kernel: [ 6797.305227] CPU: 10 PID: 30296 Comm: am=
dgpu_cs:0 Tainted: G    B D W  OE    4.16.0-rc7+ #104
Jun  7 14:45:58 kaveri kernel: [ 6797.305230] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Jun  7 14:45:58 kaveri kernel: [ 6797.305233] Call Trace:
Jun  7 14:45:58 kaveri kernel: [ 6797.305246]  dump_stack+0x85/0xc1
Jun  7 14:45:58 kaveri kernel: [ 6797.305255]  warn_alloc+0x18e/0x290
Jun  7 14:45:58 kaveri kernel: [ 6797.305260]  ? zone_watermark_ok_safe+0=
x270/0x270
Jun  7 14:45:58 kaveri kernel: [ 6797.305264]  ? __isolate_free_page+0x53=
0/0x530
Jun  7 14:45:58 kaveri kernel: [ 6797.305269]  ? try_to_compact_pages+0x1=
d5/0x850
Jun  7 14:45:58 kaveri kernel: [ 6797.305276]  __alloc_pages_slowpath+0x1=
bc4/0x22b0
Jun  7 14:45:58 kaveri kernel: [ 6797.305283]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jun  7 14:45:58 kaveri kernel: [ 6797.305290]  ? warn_alloc+0x290/0x290
Jun  7 14:45:58 kaveri kernel: [ 6797.305294]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jun  7 14:45:58 kaveri kernel: [ 6797.305299]  ? __isolate_free_page+0x53=
0/0x530
Jun  7 14:45:58 kaveri kernel: [ 6797.305304]  __alloc_pages_nodemask+0x4=
c5/0x5c0
Jun  7 14:45:58 kaveri kernel: [ 6797.305308]  ? __alloc_pages_slowpath+0=
x22b0/0x22b0
Jun  7 14:45:58 kaveri kernel: [ 6797.305316]  kmalloc_order+0x1d/0x70
Jun  7 14:45:58 kaveri kernel: [ 6797.305321]  kmalloc_order_trace+0x1d/0=
x160
Jun  7 14:45:58 kaveri kernel: [ 6797.305409]  amdgpu_vram_mgr_new+0x1e9/=
0x700 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.305423]  ttm_bo_mem_space+0x755/0xe=
10 [ttm]
Jun  7 14:45:58 kaveri kernel: [ 6797.305433]  ? ttm_bo_mem_compat+0x6b/0=
x130 [ttm]
Jun  7 14:45:58 kaveri kernel: [ 6797.305440]  ttm_bo_validate+0x293/0x4a=
0 [ttm]
Jun  7 14:45:58 kaveri kernel: [ 6797.305447]  ? ttm_bo_evict_mm+0xa0/0xa=
0 [ttm]
Jun  7 14:45:58 kaveri kernel: [ 6797.305450]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jun  7 14:45:58 kaveri kernel: [ 6797.305454]  ? kernel_text_address+0x11=
1/0x120
Jun  7 14:45:58 kaveri kernel: [ 6797.305457]  ? __kernel_text_address+0x=
e/0x30
Jun  7 14:45:58 kaveri kernel: [ 6797.305461]  ? unwind_get_return_addres=
s+0x5f/0xa0
Jun  7 14:45:58 kaveri kernel: [ 6797.305513]  amdgpu_cs_bo_validate+0x34=
c/0x860 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.305519]  ? lock_acquire+0x10b/0x350=

Jun  7 14:45:58 kaveri kernel: [ 6797.305525]  ? ttm_eu_reserve_buffers+0=
x8ff/0x12b0 [ttm]
Jun  7 14:45:58 kaveri kernel: [ 6797.305580]  ? copy_overflow+0x20/0x20 =
[amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.305585]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jun  7 14:45:58 kaveri kernel: [ 6797.305589]  ? __ww_mutex_lock.constpro=
p.11+0x131/0x2ee0
Jun  7 14:45:58 kaveri kernel: [ 6797.305595]  ? ttm_eu_reserve_buffers+0=
x8ff/0x12b0 [ttm]
Jun  7 14:45:58 kaveri kernel: [ 6797.305647]  amdgpu_cs_validate+0x94/0x=
b40 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.305652]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jun  7 14:45:58 kaveri kernel: [ 6797.305708]  ? amdgpu_cs_get_fence.isra=
=2E6+0x210/0x210 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.305762]  ? amdgpu_vm_validate_pt_bo=
s+0x4ed/0x6c0 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.305814]  amdgpu_cs_list_validate+0x=
197/0x3e0 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.305864]  ? amdgpu_cs_validate+0xb40=
/0xb40 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.305867]  ? _raw_spin_unlock+0x24/0x=
30
Jun  7 14:45:58 kaveri kernel: [ 6797.305919]  ? amdgpu_cs_get_fence.isra=
=2E6+0x210/0x210 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.305979]  amdgpu_cs_ioctl+0x3310/0x4=
d80 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.306055]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.306119]  ? amdgpu_bo_list_ioctl+0x2=
aa/0x650 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.306125]  ? save_stack+0x89/0xb0
Jun  7 14:45:58 kaveri kernel: [ 6797.306129]  ? __kasan_slab_free+0x136/=
0x180
Jun  7 14:45:58 kaveri kernel: [ 6797.306132]  ? kfree+0xf9/0x2f0
Jun  7 14:45:58 kaveri kernel: [ 6797.306181]  ? amdgpu_bo_list_ioctl+0x2=
aa/0x650 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.306198]  ? drm_ioctl_kernel+0x135/0=
x1c0 [drm]
Jun  7 14:45:58 kaveri kernel: [ 6797.306211]  ? drm_ioctl+0x67a/0x980 [d=
rm]
Jun  7 14:45:58 kaveri kernel: [ 6797.306255]  ? amdgpu_drm_ioctl+0xcc/0x=
1a0 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.306259]  ? do_vfs_ioctl+0x192/0xee0=

Jun  7 14:45:58 kaveri kernel: [ 6797.306261]  ? SyS_ioctl+0x74/0x80
Jun  7 14:45:58 kaveri kernel: [ 6797.306265]  ? do_syscall_64+0x198/0x5c=
0
Jun  7 14:45:58 kaveri kernel: [ 6797.306269]  ? entry_SYSCALL_64_after_h=
wframe+0x42/0xb7
Jun  7 14:45:58 kaveri kernel: [ 6797.306275]  ? idr_get_free+0x4b3/0x980=

Jun  7 14:45:58 kaveri kernel: [ 6797.306280]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jun  7 14:45:58 kaveri kernel: [ 6797.306293]  ? get_futex_key+0xc20/0xc2=
0
Jun  7 14:45:58 kaveri kernel: [ 6797.306341]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.306355]  drm_ioctl_kernel+0x135/0x1=
c0 [drm]
Jun  7 14:45:58 kaveri kernel: [ 6797.306370]  drm_ioctl+0x67a/0x980 [drm=
]
Jun  7 14:45:58 kaveri kernel: [ 6797.306419]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.306432]  ? drm_getstats+0x20/0x20 [=
drm]
Jun  7 14:45:58 kaveri kernel: [ 6797.306437]  ? lock_downgrade+0x5e0/0x5=
e0
Jun  7 14:45:58 kaveri kernel: [ 6797.306441]  ? __pm_runtime_resume+0x68=
/0xf0
Jun  7 14:45:58 kaveri kernel: [ 6797.306445]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jun  7 14:45:58 kaveri kernel: [ 6797.306491]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Jun  7 14:45:58 kaveri kernel: [ 6797.306496]  do_vfs_ioctl+0x192/0xee0
Jun  7 14:45:58 kaveri kernel: [ 6797.306500]  ? ioctl_preallocate+0x1b0/=
0x1b0
Jun  7 14:45:58 kaveri kernel: [ 6797.306505]  ? __fget+0x1bc/0x300
Jun  7 14:45:58 kaveri kernel: [ 6797.306508]  ? lock_downgrade+0x5e0/0x5=
e0
Jun  7 14:45:58 kaveri kernel: [ 6797.306511]  ? __fget+0x49/0x300
Jun  7 14:45:58 kaveri kernel: [ 6797.306515]  ? SyS_futex+0x197/0x200
Jun  7 14:45:58 kaveri kernel: [ 6797.306519]  ? __fget+0x1db/0x300
Jun  7 14:45:58 kaveri kernel: [ 6797.306524]  SyS_ioctl+0x74/0x80
Jun  7 14:45:58 kaveri kernel: [ 6797.306527]  ? do_vfs_ioctl+0xee0/0xee0=

Jun  7 14:45:58 kaveri kernel: [ 6797.306530]  do_syscall_64+0x198/0x5c0
Jun  7 14:45:58 kaveri kernel: [ 6797.306537]  entry_SYSCALL_64_after_hwf=
rame+0x42/0xb7
Jun  7 14:45:58 kaveri kernel: [ 6797.306542] RIP: 0033:0x7fee04e31f07
Jun  7 14:45:58 kaveri kernel: [ 6797.306545] RSP: 002b:00007fedfc20dc68 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Jun  7 14:45:58 kaveri kernel: [ 6797.306551] RAX: ffffffffffffffda RBX: =
00007fedfc20dd58 RCX: 00007fee04e31f07
Jun  7 14:45:58 kaveri kernel: [ 6797.306554] RDX: 00007fedfc20dcd0 RSI: =
00000000c0186444 RDI: 0000000000000006
Jun  7 14:45:58 kaveri kernel: [ 6797.306558] RBP: 00007fedfc20dc90 R08: =
00007fedfc20dd80 R09: 00007fedfc20dd58
Jun  7 14:45:58 kaveri kernel: [ 6797.306562] R10: 00007fedfc20dd80 R11: =
0000000000000246 R12: 00007fedfc20dcd0
Jun  7 14:45:58 kaveri kernel: [ 6797.306565] R13: 00000000c0186444 R14: =
0000000000000006 R15: 0000000000000000
Jun  7 14:45:58 kaveri kernel: [ 6797.306573] Mem-Info:
Jun  7 14:45:58 kaveri kernel: [ 6797.306582] active_anon:118926 inactive=
_anon:64892 isolated_anon:0
Jun  7 14:45:58 kaveri kernel: [ 6797.306582]  active_file:1375959 inacti=
ve_file:509602 isolated_file:0
Jun  7 14:45:58 kaveri kernel: [ 6797.306582]  unevictable:0 dirty:9227 w=
riteback:9 unstable:0
Jun  7 14:45:58 kaveri kernel: [ 6797.306582]  slab_reclaimable:331000 sl=
ab_unreclaimable:173987
Jun  7 14:45:58 kaveri kernel: [ 6797.306582]  mapped:30563 shmem:3000 pa=
getables:6564 bounce:0
Jun  7 14:45:58 kaveri kernel: [ 6797.306582]  free:47135 free_pcp:537 fr=
ee_cma:0
Jun  7 14:45:58 kaveri kernel: [ 6797.306595] Node 0 active_anon:475704kB=
 inactive_anon:259568kB active_file:5503836kB inactive_file:2038408kB une=
victable:0kB isolated(anon):0kB isolated(file):0kB mapped:122252kB dirty:=
36908kB writeback:36kB shmem:12000kB shmem_thp: 0kB shmem_pmdmapped: 0kB =
anon_thp: 55296kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
Jun  7 14:45:58 kaveri kernel: [ 6797.306599] Node 0 DMA free:15892kB min=
:72kB low:88kB high:104kB active_anon:0kB inactive_anon:0kB active_file:0=
kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB man=
aged:15892kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_=
pcp:0kB local_pcp:0kB free_cma:0kB
Jun  7 14:45:58 kaveri kernel: [ 6797.306606] lowmem_reserve[]: 0 2943 13=
850 13850 13850
Jun  7 14:45:58 kaveri kernel: [ 6797.306613] Node 0 DMA32 free:58416kB m=
in:14344kB low:17928kB high:21512kB active_anon:19640kB inactive_anon:325=
76kB active_file:1818172kB inactive_file:777900kB unevictable:0kB writepe=
nding:120kB present:3093540kB managed:3091224kB mlocked:0kB kernel_stack:=
1568kB pagetables:940kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0k=
B
Jun  7 14:45:58 kaveri kernel: [ 6797.306621] lowmem_reserve[]: 0 0 10906=
 10906 10906
Jun  7 14:45:58 kaveri kernel: [ 6797.306630] Node 0 Normal free:114232kB=
 min:53160kB low:66448kB high:79736kB active_anon:456660kB inactive_anon:=
226344kB active_file:3686376kB inactive_file:1260752kB unevictable:0kB wr=
itepending:36824kB present:13618688kB managed:11179732kB mlocked:0kB kern=
el_stack:29280kB pagetables:25316kB bounce:0kB free_pcp:2132kB local_pcp:=
0kB free_cma:0kB
Jun  7 14:45:58 kaveri kernel: [ 6797.306638] lowmem_reserve[]: 0 0 0 0 0=

Jun  7 14:45:58 kaveri kernel: [ 6797.306645] Node 0 DMA: 1*4kB (U) 2*8kB=
 (U) 2*16kB (U) 1*32kB (U) 3*64kB (U) 0*128kB 1*256kB (U) 0*512kB 1*1024k=
B (U) 1*2048kB (M) 3*4096kB (M) =3D 15892kB
Jun  7 14:45:58 kaveri kernel: [ 6797.306676] Node 0 DMA32: 4484*4kB (UME=
H) 289*8kB (UMEH) 119*16kB (UMEH) 117*32kB (UMEH) 72*64kB (UMEH) 42*128kB=
 (UMEH) 26*256kB (MEH) 16*512kB (UMH) 8*1024kB (M) 0*2048kB 0*4096kB =3D =
58920kB
Jun  7 14:45:58 kaveri kernel: [ 6797.306706] Node 0 Normal: 10925*4kB (U=
ME) 2599*8kB (UME) 1228*16kB (UMEH) 466*32kB (UMEH) 232*64kB (UMH) 3*128k=
B (H) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 114284kB
Jun  7 14:45:58 kaveri kernel: [ 6797.306734] Node 0 hugepages_total=3D0 =
hugepages_free=3D0 hugepages_surp=3D0 hugepages_size=3D1048576kB
Jun  7 14:45:58 kaveri kernel: [ 6797.306738] Node 0 hugepages_total=3D0 =
hugepages_free=3D0 hugepages_surp=3D0 hugepages_size=3D2048kB
Jun  7 14:45:58 kaveri kernel: [ 6797.306741] 1890820 total pagecache pag=
es
Jun  7 14:45:58 kaveri kernel: [ 6797.306745] 2563 pages in swap cache
Jun  7 14:45:58 kaveri kernel: [ 6797.306749] Swap cache stats: add 12752=
8, delete 124978, find 31032/54223
Jun  7 14:45:58 kaveri kernel: [ 6797.306751] Free swap  =3D 7921404kB
Jun  7 14:45:58 kaveri kernel: [ 6797.306754] Total swap =3D 7999484kB
Jun  7 14:45:58 kaveri kernel: [ 6797.306757] 4182056 pages RAM
Jun  7 14:45:58 kaveri kernel: [ 6797.306760] 0 pages HighMem/MovableOnly=

Jun  7 14:45:58 kaveri kernel: [ 6797.306762] 610344 pages reserved
Jun  7 14:45:58 kaveri kernel: [ 6797.306765] 0 pages hwpoisoned

--------------E68C0E9ABABF64A0359D23A0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------E68C0E9ABABF64A0359D23A0--

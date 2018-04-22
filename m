From: Chris Rankin <rankincj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [OOPS] [AMDGPU] Problem with R7 360 card and 4.16.x kernel.
Date: Sun, 22 Apr 2018 13:03:10 +0100
Message-ID: <CAK2bqVJZBzgGbnKgNRrDLpQy+nso_fkwqgFtN33XdM9JbjpJiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0463940537=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

--===============0463940537==
Content-Type: multipart/alternative; boundary="000000000000853684056a6eb412"

--000000000000853684056a6eb412
Content-Type: text/plain; charset="UTF-8"

Hi,

I have recently upgraded to the 4.16 kernel, and have now noticed the
following appearing in my dmesg log. This didn't happen with the 4.15
kernel. I am also noticing that my graphics card runs ~10C hotter with 4.16.

The PCI numbers for this card are: 1002:665f (rev 81)

More information available on request,
Cheers,
Chris

[ 9229.654917] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[ 9229.660763] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[ 9229.667131] CPU: 4 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[ 9229.673514] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[ 9229.681212] Call Trace:
[ 9229.682393]  dump_stack+0x46/0x59
[ 9229.684462]  swiotlb_alloc_coherent+0x162/0x173
[ 9229.687758]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[ 9229.691604]  ttm_dma_populate+0xfb/0x29c [ttm]
[ 9229.694784]  ttm_tt_bind+0x2d/0x52 [ttm]
[ 9229.697427]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[ 9229.701276]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[ 9229.704732]  ttm_bo_validate+0x76/0xd4 [ttm]
[ 9229.707792]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[ 9229.711268]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[ 9229.714945]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[ 9229.718753]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[ 9229.722325]  ? amdgpu_vm_bo_update+0x3e1/0x426 [amdgpu]
[ 9229.726275]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[ 9229.729788]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[ 9229.733834]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[ 9229.737952]  ? resched_curr+0x38/0x4f
[ 9229.740351]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[ 9229.744639]  drm_ioctl_kernel+0x5f/0x9b [drm]
[ 9229.747699]  drm_ioctl+0x1ef/0x2d5 [drm]
[ 9229.750371]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[ 9229.754662]  ? rpm_resume+0x89/0x3cb
[ 9229.757059]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[ 9229.760399]  vfs_ioctl+0x19/0x26
[ 9229.762353]  do_vfs_ioctl+0x506/0x519
[ 9229.764725]  ? __audit_syscall_entry+0xba/0xde
[ 9229.767895]  SyS_ioctl+0x4d/0x6f
[ 9229.769854]  do_syscall_64+0x5c/0xe7
[ 9229.772188]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 9229.776023] RIP: 0033:0x7f3af27290f7
[ 9229.778494] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[ 9229.778496] RAX: ffffffffffffffda RBX: 00007f3a9aa8bbc0 RCX:
00007f3af27290f7
[ 9229.778497] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[ 9229.778498] RBP: 000000000326d910 R08: 00007f3a9aa8bbc0 R09:
0000000000000004
[ 9229.778499] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[ 9229.778500] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39d9e3e560
[ 9397.135877] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[ 9397.141657] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[ 9397.147968] CPU: 6 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[ 9397.154352] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[ 9397.161996] Call Trace:
[ 9397.163182]  dump_stack+0x46/0x59
[ 9397.165214]  swiotlb_alloc_coherent+0x162/0x173
[ 9397.168526]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[ 9397.172279]  ttm_dma_populate+0xfb/0x29c [ttm]
[ 9397.175432]  ttm_tt_bind+0x2d/0x52 [ttm]
[ 9397.178180]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[ 9397.181943]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[ 9397.185381]  ? __slab_alloc.isra.20.constprop.25+0x3d/0x46
[ 9397.189714]  ttm_bo_validate+0x76/0xd4 [ttm]
[ 9397.192713]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[ 9397.196127]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[ 9397.199767]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[ 9397.203536]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[ 9397.206993]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[ 9397.210443]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[ 9397.214533]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[ 9397.218637]  ? preempt_count_add+0x75/0x87
[ 9397.221534]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[ 9397.225880]  drm_ioctl_kernel+0x5f/0x9b [drm]
[ 9397.225887]  drm_ioctl+0x1ef/0x2d5 [drm]
[ 9397.231658]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[ 9397.235979]  ? rpm_resume+0x89/0x3cb
[ 9397.238266]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[ 9397.241673]  vfs_ioctl+0x19/0x26
[ 9397.243619]  do_vfs_ioctl+0x506/0x519
[ 9397.245997]  ? __audit_syscall_entry+0xba/0xde
[ 9397.249175]  SyS_ioctl+0x4d/0x6f
[ 9397.251127]  do_syscall_64+0x5c/0xe7
[ 9397.253434]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 9397.257208] RIP: 0033:0x7f3af27290f7
[ 9397.259522] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[ 9397.265814] RAX: ffffffffffffffda RBX: 00007f39da2eaa90 RCX:
00007f3af27290f7
[ 9397.271691] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[ 9397.277600] RBP: 000000000326d910 R08: 00007f39da2eaa90 R09:
0000000000000004
[ 9397.283566] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[ 9397.283567] R13: 000000000000008a R14: 000000000326d988 R15:
00007f3a9a5d5ee0
[ 9405.461010] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[ 9405.466786] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[ 9405.473097] CPU: 3 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[ 9405.479509] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[ 9405.487130] Call Trace:
[ 9405.488311]  dump_stack+0x46/0x59
[ 9405.490337]  swiotlb_alloc_coherent+0x162/0x173
[ 9405.493598]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[ 9405.497383]  ttm_dma_populate+0xfb/0x29c [ttm]
[ 9405.500600]  ttm_tt_bind+0x2d/0x52 [ttm]
[ 9405.503242]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[ 9405.507029]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[ 9405.510470]  ttm_bo_validate+0x76/0xd4 [ttm]
[ 9405.513493]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[ 9405.516968]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[ 9405.520623]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[ 9405.524436]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[ 9405.527912]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[ 9405.531351]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[ 9405.535435]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[ 9405.539565]  ? hrtimer_cancel+0xc/0x16
[ 9405.542044]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[ 9405.546335]  drm_ioctl_kernel+0x5f/0x9b [drm]
[ 9405.549459]  drm_ioctl+0x1ef/0x2d5 [drm]
[ 9405.552135]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[ 9405.556419]  ? rpm_resume+0x89/0x3cb
[ 9405.558753]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[ 9405.562081]  vfs_ioctl+0x19/0x26
[ 9405.564020]  do_vfs_ioctl+0x506/0x519
[ 9405.566419]  ? __audit_syscall_entry+0xba/0xde
[ 9405.569634]  SyS_ioctl+0x4d/0x6f
[ 9405.571594]  do_syscall_64+0x5c/0xe7
[ 9405.573911]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 9405.577711] RIP: 0033:0x7f3af27290f7
[ 9405.580020] RSP: 002b:000000000326e088 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[ 9405.586377] RAX: ffffffffffffffda RBX: 00007f39d9f9d3d0 RCX:
00007f3af27290f7
[ 9405.592332] RDX: 000000000326e0d0 RSI: 00000000c0206440 RDI:
000000000000008a
[ 9405.598287] RBP: 000000000326e0d0 R08: 00007f39d9f9d3d0 R09:
0000000000000004
[ 9405.604248] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[ 9405.610202] R13: 000000000000008a R14: 000000000326e148 R15:
00007f39da2ab860
[ 9407.963742] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[ 9407.969516] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[ 9407.975852] CPU: 1 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[ 9407.982301] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[ 9407.989920] Call Trace:
[ 9407.991104]  dump_stack+0x46/0x59
[ 9407.993131]  swiotlb_alloc_coherent+0x162/0x173
[ 9407.996371]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[ 9408.000149]  ttm_dma_populate+0xfb/0x29c [ttm]
[ 9408.003336]  ttm_tt_bind+0x2d/0x52 [ttm]
[ 9408.006008]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[ 9408.009796]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[ 9408.013280]  ? enqueue_entity+0x504/0x653
[ 9408.016008]  ttm_bo_validate+0x76/0xd4 [ttm]
[ 9408.019067]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[ 9408.022475]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[ 9408.026137]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[ 9408.029966]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[ 9408.033415]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[ 9408.036876]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[ 9408.041029]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[ 9408.045200]  ? resched_curr+0x38/0x4f
[ 9408.047592]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[ 9408.051899]  drm_ioctl_kernel+0x5f/0x9b [drm]
[ 9408.055064]  drm_ioctl+0x1ef/0x2d5 [drm]
[ 9408.057743]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[ 9408.062021]  ? rpm_resume+0x89/0x3cb
[ 9408.064336]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[ 9408.067670]  vfs_ioctl+0x19/0x26
[ 9408.069626]  do_vfs_ioctl+0x506/0x519
[ 9408.072074]  ? __audit_syscall_entry+0xba/0xde
[ 9408.075271]  SyS_ioctl+0x4d/0x6f
[ 9408.077229]  do_syscall_64+0x5c/0xe7
[ 9408.079509]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 9408.083286] RIP: 0033:0x7f3af27290f7
[ 9408.085617] RSP: 002b:000000000326e088 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[ 9408.092002] RAX: ffffffffffffffda RBX: 00007f3a9a59c270 RCX:
00007f3af27290f7
[ 9408.098005] RDX: 000000000326e0d0 RSI: 00000000c0206440 RDI:
000000000000008a
[ 9408.103885] RBP: 000000000326e0d0 R08: 00007f3a9a59c270 R09:
0000000000000004
[ 9408.109884] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[ 9408.109885] R13: 000000000000008a R14: 000000000326e148 R15:
00007f39da117b20
[ 9421.696643] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[ 9421.702356] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[ 9421.702360] CPU: 0 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[ 9421.702361] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[ 9421.702362] Call Trace:
[ 9421.702371]  dump_stack+0x46/0x59
[ 9421.702375]  swiotlb_alloc_coherent+0x162/0x173
[ 9421.728920]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[ 9421.732669]  ttm_dma_populate+0xfb/0x29c [ttm]
[ 9421.735813]  ttm_tt_bind+0x2d/0x52 [ttm]
[ 9421.738441]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[ 9421.742192]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[ 9421.745600]  ? enqueue_entity+0x504/0x653
[ 9421.745605]  ttm_bo_validate+0x76/0xd4 [ttm]
[ 9421.751286]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[ 9421.754689]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[ 9421.758307]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[ 9421.762075]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[ 9421.765496]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[ 9421.768923]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[ 9421.772950]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[ 9421.777052]  ? resched_curr+0x38/0x4f
[ 9421.779431]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[ 9421.783701]  drm_ioctl_kernel+0x5f/0x9b [drm]
[ 9421.786763]  drm_ioctl+0x1ef/0x2d5 [drm]
[ 9421.789408]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[ 9421.793680]  ? rpm_resume+0x89/0x3cb
[ 9421.795972]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[ 9421.799288]  vfs_ioctl+0x19/0x26
[ 9421.801219]  do_vfs_ioctl+0x506/0x519
[ 9421.801223]  ? __audit_syscall_entry+0xba/0xde
[ 9421.806723]  SyS_ioctl+0x4d/0x6f
[ 9421.808656]  do_syscall_64+0x5c/0xe7
[ 9421.810937]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 9421.810939] RIP: 0033:0x7f3af27290f7
[ 9421.816957] RSP: 002b:000000000326e088 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[ 9421.823223] RAX: ffffffffffffffda RBX: 00007f39d92845c0 RCX:
00007f3af27290f7
[ 9421.829046] RDX: 000000000326e0d0 RSI: 00000000c0206440 RDI:
000000000000008a
[ 9421.829048] RBP: 000000000326e0d0 R08: 00007f39d92845c0 R09:
0000000000000004
[ 9421.840694] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[ 9421.846519] R13: 000000000000008a R14: 000000000326e148 R15:
00007f39d9807160
[10943.377740] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[10943.383524] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[10943.389971] CPU: 6 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[10943.389972] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[10943.389973] Call Trace:
[10943.405174]  dump_stack+0x46/0x59
[10943.407197]  swiotlb_alloc_coherent+0x162/0x173
[10943.410502]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[10943.410506]  ttm_dma_populate+0xfb/0x29c [ttm]
[10943.417571]  ttm_tt_bind+0x2d/0x52 [ttm]
[10943.420284]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[10943.424035]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[10943.427471]  ? enqueue_entity+0x504/0x653
[10943.427474]  ttm_bo_validate+0x76/0xd4 [ttm]
[10943.433204]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[10943.436614]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[10943.436665]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[10943.443990]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[10943.444008]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[10943.450853]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[10943.450873]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[10943.459154]  ? resched_curr+0x38/0x4f
[10943.461581]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[10943.465969]  drm_ioctl_kernel+0x5f/0x9b [drm]
[10943.469056]  drm_ioctl+0x1ef/0x2d5 [drm]
[10943.469077]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[10943.475993]  ? rpm_resume+0x89/0x3cb
[10943.476012]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[10943.481651]  vfs_ioctl+0x19/0x26
[10943.483611]  do_vfs_ioctl+0x506/0x519
[10943.483616]  ? __audit_syscall_entry+0xba/0xde
[10943.489198]  SyS_ioctl+0x4d/0x6f
[10943.491151]  do_syscall_64+0x5c/0xe7
[10943.491155]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[10943.497188] RIP: 0033:0x7f3af27290f7
[10943.499492] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[10943.505844] RAX: ffffffffffffffda RBX: 00007f39db4e9580 RCX:
00007f3af27290f7
[10943.511706] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[10943.511708] RBP: 000000000326d910 R08: 00007f39db4e9580 R09:
0000000000000004
[10943.511709] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[10943.511710] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39db4e2be0
[11005.809894] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11005.815666] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11005.815668] CPU: 3 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11005.815669] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11005.815670] Call Trace:
[11005.815677]  dump_stack+0x46/0x59
[11005.815680]  swiotlb_alloc_coherent+0x162/0x173
[11005.815688]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11005.815692]  ttm_dma_populate+0xfb/0x29c [ttm]
[11005.815695]  ttm_tt_bind+0x2d/0x52 [ttm]
[11005.852103]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11005.852108]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11005.852111]  ? __slab_alloc.isra.20.constprop.25+0x3d/0x46
[11005.852115]  ttm_bo_validate+0x76/0xd4 [ttm]
[11005.852129]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11005.852133]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11005.852175]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11005.852200]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11005.880866]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11005.880882]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11005.880897]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11005.880901]  ? resched_curr+0x38/0x4f
[11005.894879]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11005.894885]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11005.894891]  drm_ioctl+0x1ef/0x2d5 [drm]
[11005.894906]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11005.894909]  ? rpm_resume+0x89/0x3cb
[11005.911752]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11005.911755]  vfs_ioctl+0x19/0x26
[11005.911756]  do_vfs_ioctl+0x506/0x519
[11005.911760]  ? __audit_syscall_entry+0xba/0xde
[11005.911761]  SyS_ioctl+0x4d/0x6f
[11005.911763]  do_syscall_64+0x5c/0xe7
[11005.911767]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11005.911768] RIP: 0033:0x7f3af27290f7
[11005.911769] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11005.911771] RAX: ffffffffffffffda RBX: 00007f39db4ef4a0 RCX:
00007f3af27290f7
[11005.911772] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11005.911772] RBP: 000000000326d910 R08: 00007f39db4ef4a0 R09:
000000000000000b
[11005.911773] R10: 0000000000000000 R11: 0000000000000246 R12:
00000000c0206440
[11005.911774] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39da324080
[11017.845296] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11017.851038] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11017.857396] CPU: 3 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11017.863762] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11017.871372] Call Trace:
[11017.872524]  dump_stack+0x46/0x59
[11017.874540]  swiotlb_alloc_coherent+0x162/0x173
[11017.877826]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11017.881603]  ttm_dma_populate+0xfb/0x29c [ttm]
[11017.884800]  ttm_tt_bind+0x2d/0x52 [ttm]
[11017.887451]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11017.891224]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11017.894706]  ? get_nohz_timer_target+0x16/0xe5
[11017.897852]  ttm_bo_validate+0x76/0xd4 [ttm]
[11017.900863]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11017.904301]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11017.908018]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11017.911837]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11017.915349]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11017.918801]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11017.922920]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11017.927025]  ? resched_curr+0x38/0x4f
[11017.929405]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11017.933683]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11017.936751]  drm_ioctl+0x1ef/0x2d5 [drm]
[11017.939442]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11017.943777]  ? rpm_resume+0x89/0x3cb
[11017.946120]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11017.949472]  vfs_ioctl+0x19/0x26
[11017.951427]  do_vfs_ioctl+0x506/0x519
[11017.953814]  ? __audit_syscall_entry+0xba/0xde
[11017.956991]  SyS_ioctl+0x4d/0x6f
[11017.958943]  do_syscall_64+0x5c/0xe7
[11017.961239]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11017.965024] RIP: 0033:0x7f3af27290f7
[11017.967381] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11017.973718] RAX: ffffffffffffffda RBX: 00007f39db2ea130 RCX:
00007f3af27290f7
[11017.979627] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11017.985624] RBP: 000000000326d910 R08: 00007f39db2ea130 R09:
0000000000000004
[11017.991493] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[11017.997376] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39db1dee30
[11069.149823] audit: type=1130 audit(1523832495.084:243): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=dnfdaemon comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[11073.124430] audit: type=1131 audit(1523832499.058:244): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=dnfdaemon comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[11106.125114] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11106.130857] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11106.137325] CPU: 5 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11106.143712] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11106.151365] Call Trace:
[11106.151372]  dump_stack+0x46/0x59
[11106.154572]  swiotlb_alloc_coherent+0x162/0x173
[11106.154578]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11106.161587]  ttm_dma_populate+0xfb/0x29c [ttm]
[11106.164783]  ttm_tt_bind+0x2d/0x52 [ttm]
[11106.167411]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11106.171186]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11106.171190]  ? enqueue_entity+0x504/0x653
[11106.177368]  ttm_bo_validate+0x76/0xd4 [ttm]
[11106.180453]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11106.180456]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11106.187614]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11106.187629]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11106.194898]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11106.194914]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11106.202419]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11106.206608]  ? resched_curr+0x38/0x4f
[11106.209006]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11106.213400]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11106.213406]  drm_ioctl+0x1ef/0x2d5 [drm]
[11106.219305]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11106.219309]  ? rpm_resume+0x89/0x3cb
[11106.225982]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11106.225986]  vfs_ioctl+0x19/0x26
[11106.231298]  do_vfs_ioctl+0x506/0x519
[11106.233731]  ? __audit_syscall_entry+0xba/0xde
[11106.233733]  SyS_ioctl+0x4d/0x6f
[11106.238848]  do_syscall_64+0x5c/0xe7
[11106.241207]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11106.245059] RIP: 0033:0x7f3af27290f7
[11106.247365] RSP: 002b:000000000326e088 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11106.253762] RAX: ffffffffffffffda RBX: 00007f39db703ca0 RCX:
00007f3af27290f7
[11106.253763] RDX: 000000000326e0d0 RSI: 00000000c0206440 RDI:
000000000000008a
[11106.253764] RBP: 000000000326e0d0 R08: 00007f39db703ca0 R09:
00007f3a98000180
[11106.253764] R10: 0000000000000000 R11: 0000000000000246 R12:
00000000c0206440
[11106.253766] R13: 000000000000008a R14: 000000000326e148 R15:
00007f39db61d750
[11137.559983] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11137.565715] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11137.572062] CPU: 4 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11137.572063] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11137.572065] Call Trace:
[11137.572072]  dump_stack+0x46/0x59
[11137.572075]  swiotlb_alloc_coherent+0x162/0x173
[11137.572080]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11137.572084]  ttm_dma_populate+0xfb/0x29c [ttm]
[11137.572086]  ttm_tt_bind+0x2d/0x52 [ttm]
[11137.572089]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11137.572092]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11137.572095]  ? __slab_alloc.isra.20.constprop.25+0x3d/0x46
[11137.572098]  ttm_bo_validate+0x76/0xd4 [ttm]
[11137.572109]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11137.572111]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11137.572148]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11137.627953]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11137.627988]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11137.628003]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11137.638939]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11137.638942]  ? resched_curr+0x38/0x4f
[11137.638957]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11137.638963]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11137.638969]  drm_ioctl+0x1ef/0x2d5 [drm]
[11137.655542]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11137.659871]  ? rpm_resume+0x89/0x3cb
[11137.662194]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11137.665574]  vfs_ioctl+0x19/0x26
[11137.667522]  do_vfs_ioctl+0x506/0x519
[11137.669915]  ? __audit_syscall_entry+0xba/0xde
[11137.673114]  SyS_ioctl+0x4d/0x6f
[11137.673116]  do_syscall_64+0x5c/0xe7
[11137.673119]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11137.673121] RIP: 0033:0x7f3af27290f7
[11137.673122] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11137.673123] RAX: ffffffffffffffda RBX: 00007f39dafced10 RCX:
00007f3af27290f7
[11137.673124] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11137.673125] RBP: 000000000326d910 R08: 00007f39dafced10 R09:
0000000000000004
[11137.673126] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[11137.673127] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39da014550
[11192.494759] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11192.500420] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11192.506805] CPU: 4 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11192.513173] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11192.520919] Call Trace:
[11192.522097]  dump_stack+0x46/0x59
[11192.524145]  swiotlb_alloc_coherent+0x162/0x173
[11192.527449]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11192.531228]  ttm_dma_populate+0xfb/0x29c [ttm]
[11192.534451]  ttm_tt_bind+0x2d/0x52 [ttm]
[11192.537102]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11192.540924]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11192.544398]  ? enqueue_entity+0x504/0x653
[11192.547103]  ttm_bo_validate+0x76/0xd4 [ttm]
[11192.550103]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11192.553544]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11192.557251]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11192.561030]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11192.564545]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11192.568013]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11192.572261]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11192.576433]  ? resched_curr+0x38/0x4f
[11192.578837]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11192.583162]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11192.586325]  drm_ioctl+0x1ef/0x2d5 [drm]
[11192.589040]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11192.593312]  ? rpm_resume+0x89/0x3cb
[11192.595709]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11192.599121]  vfs_ioctl+0x19/0x26
[11192.601068]  do_vfs_ioctl+0x506/0x519
[11192.603437]  ? __audit_syscall_entry+0xba/0xde
[11192.606660]  SyS_ioctl+0x4d/0x6f
[11192.608635]  do_syscall_64+0x5c/0xe7
[11192.610915]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11192.614710] RIP: 0033:0x7f3af27290f7
[11192.617094] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11192.623551] RAX: ffffffffffffffda RBX: 00007f39db63e090 RCX:
00007f3af27290f7
[11192.629574] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11192.635430] RBP: 000000000326d910 R08: 00007f39db63e090 R09:
0000000000000004
[11192.641360] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[11192.647277] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39db83f490
[11232.821909] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11232.827574] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11232.833873] CPU: 3 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11232.833874] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11232.833875] Call Trace:
[11232.833882]  dump_stack+0x46/0x59
[11232.833886]  swiotlb_alloc_coherent+0x162/0x173
[11232.833891]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11232.833894]  ttm_dma_populate+0xfb/0x29c [ttm]
[11232.833897]  ttm_tt_bind+0x2d/0x52 [ttm]
[11232.833900]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11232.833903]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11232.833906]  ttm_bo_validate+0x76/0xd4 [ttm]
[11232.833916]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11232.833921]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11232.833956]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11232.833971]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11232.887966]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11232.891381]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11232.895401]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11232.899498]  ? resched_curr+0x38/0x4f
[11232.901876]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11232.906147]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11232.909207]  drm_ioctl+0x1ef/0x2d5 [drm]
[11232.911842]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11232.916109]  ? rpm_resume+0x89/0x3cb
[11232.918399]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11232.921718]  vfs_ioctl+0x19/0x26
[11232.923649]  do_vfs_ioctl+0x506/0x519
[11232.926018]  ? __audit_syscall_entry+0xba/0xde
[11232.929162]  SyS_ioctl+0x4d/0x6f
[11232.931095]  do_syscall_64+0x5c/0xe7
[11232.933374]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11232.937124] RIP: 0033:0x7f3af27290f7
[11232.939395] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11232.945660] RAX: ffffffffffffffda RBX: 00007f39da05c8c0 RCX:
00007f3af27290f7
[11232.951484] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11232.957310] RBP: 000000000326d910 R08: 00007f39da05c8c0 R09:
0000000000000004
[11232.963133] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[11232.968957] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39db729280
[11248.940341] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11248.946035] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11248.952305] CPU: 5 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11248.958663] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11248.966222] Call Trace:
[11248.966229]  dump_stack+0x46/0x59
[11248.966233]  swiotlb_alloc_coherent+0x162/0x173
[11248.966239]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11248.966243]  ttm_dma_populate+0xfb/0x29c [ttm]
[11248.966247]  ttm_tt_bind+0x2d/0x52 [ttm]
[11248.966250]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11248.966254]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11248.966265]  ? add_hole+0x3b/0xe6 [drm]
[11248.966269]  ttm_bo_validate+0x76/0xd4 [ttm]
[11248.966278]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11248.966281]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11248.966317]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11248.966335]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11249.009235]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11249.009254]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11249.016664]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11249.016667]  ? resched_curr+0x38/0x4f
[11249.016685]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11249.016692]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11249.030509]  drm_ioctl+0x1ef/0x2d5 [drm]
[11249.030529]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11249.030531]  ? rpm_resume+0x89/0x3cb
[11249.030546]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11249.030549]  vfs_ioctl+0x19/0x26
[11249.044992]  do_vfs_ioctl+0x506/0x519
[11249.047412]  ? __audit_syscall_entry+0xba/0xde
[11249.050556]  SyS_ioctl+0x4d/0x6f
[11249.052499]  do_syscall_64+0x5c/0xe7
[11249.054791]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11249.058573] RIP: 0033:0x7f3af27290f7
[11249.060843] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11249.067160] RAX: ffffffffffffffda RBX: 00007f39db49e780 RCX:
00007f3af27290f7
[11249.073011] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11249.078836] RBP: 000000000326d910 R08: 00007f39db49e780 R09:
0000000000000004
[11249.084702] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[11249.090560] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39dafe1590
[11263.728451] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11263.734145] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11263.740427] CPU: 1 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11263.746776] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11263.754335] Call Trace:
[11263.755483]  dump_stack+0x46/0x59
[11263.757500]  swiotlb_alloc_coherent+0x162/0x173
[11263.760734]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11263.764485]  ttm_dma_populate+0xfb/0x29c [ttm]
[11263.767632]  ttm_tt_bind+0x2d/0x52 [ttm]
[11263.770260]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11263.770264]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11263.770266]  ttm_bo_validate+0x76/0xd4 [ttm]
[11263.770277]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11263.770280]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11263.770309]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11263.770324]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11263.794545]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11263.797961]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11263.801982]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11263.806076]  ? resched_curr+0x38/0x4f
[11263.808455]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11263.812727]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11263.815787]  drm_ioctl+0x1ef/0x2d5 [drm]
[11263.818427]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11263.822699]  ? rpm_resume+0x89/0x3cb
[11263.824994]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11263.824997]  vfs_ioctl+0x19/0x26
[11263.830230]  do_vfs_ioctl+0x506/0x519
[11263.832598]  ? __audit_syscall_entry+0xba/0xde
[11263.835741]  SyS_ioctl+0x4d/0x6f
[11263.837665]  do_syscall_64+0x5c/0xe7
[11263.839937]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11263.843688] RIP: 0033:0x7f3af27290f7
[11263.845957] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11263.852215] RAX: ffffffffffffffda RBX: 00007f39db7e9920 RCX:
00007f3af27290f7
[11263.858040] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11263.863863] RBP: 000000000326d910 R08: 00007f39db7e9920 R09:
0000000000000004
[11263.869689] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[11263.875563] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39db8064c0
[11308.013166] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11308.018904] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11308.025240] CPU: 2 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11308.031653] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11308.039467] Call Trace:
[11308.040619]  dump_stack+0x46/0x59
[11308.042669]  swiotlb_alloc_coherent+0x162/0x173
[11308.045922]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11308.049770]  ttm_dma_populate+0xfb/0x29c [ttm]
[11308.052983]  ttm_tt_bind+0x2d/0x52 [ttm]
[11308.055619]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11308.059396]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11308.062829]  ? get_nohz_timer_target+0x16/0xe5
[11308.066001]  ttm_bo_validate+0x76/0xd4 [ttm]
[11308.069059]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11308.072582]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11308.072615]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11308.079951]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11308.083363]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11308.086779]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11308.090802]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11308.094894]  ? resched_curr+0x38/0x4f
[11308.097263]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11308.101539]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11308.104607]  drm_ioctl+0x1ef/0x2d5 [drm]
[11308.107251]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11308.111518]  ? rpm_resume+0x89/0x3cb
[11308.113807]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11308.117124]  vfs_ioctl+0x19/0x26
[11308.119048]  do_vfs_ioctl+0x506/0x519
[11308.121408]  ? __audit_syscall_entry+0xba/0xde
[11308.124551]  SyS_ioctl+0x4d/0x6f
[11308.126474]  do_syscall_64+0x5c/0xe7
[11308.128748]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11308.132570] RIP: 0033:0x7f3af27290f7
[11308.134847] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11308.141103] RAX: ffffffffffffffda RBX: 00007f39db2a2480 RCX:
00007f3af27290f7
[11308.146926] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11308.152787] RBP: 000000000326d910 R08: 00007f39db2a2480 R09:
0000000000000004
[11308.158698] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[11308.164564] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39db7abc30
[11338.907546] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11338.913752] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11338.920445] CPU: 7 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11338.926907] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11338.926908] Call Trace:
[11338.926915]  dump_stack+0x46/0x59
[11338.926919]  swiotlb_alloc_coherent+0x162/0x173
[11338.926923]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11338.926927]  ttm_dma_populate+0xfb/0x29c [ttm]
[11338.926930]  ttm_tt_bind+0x2d/0x52 [ttm]
[11338.926932]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11338.926936]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11338.926938]  ? enqueue_entity+0x504/0x653
[11338.926941]  ttm_bo_validate+0x76/0xd4 [ttm]
[11338.926952]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11338.926955]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11338.970788]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11338.970803]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11338.970817]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11338.981567]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11338.981583]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11338.981586]  ? resched_curr+0x38/0x4f
[11338.981601]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11338.981606]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11338.999670]  drm_ioctl+0x1ef/0x2d5 [drm]
[11338.999686]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11338.999688]  ? rpm_resume+0x89/0x3cb
[11338.999700]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11338.999703]  vfs_ioctl+0x19/0x26
[11338.999704]  do_vfs_ioctl+0x506/0x519
[11338.999707]  ? __audit_syscall_entry+0xba/0xde
[11338.999709]  SyS_ioctl+0x4d/0x6f
[11338.999711]  do_syscall_64+0x5c/0xe7
[11338.999714]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11338.999716] RIP: 0033:0x7f3af27290f7
[11338.999716] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11338.999718] RAX: ffffffffffffffda RBX: 00007f39db84e9b0 RCX:
00007f3af27290f7
[11338.999719] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11338.999720] RBP: 000000000326d910 R08: 00007f39db84e9b0 R09:
0000000000000004
[11338.999721] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[11338.999722] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39db726860
[11426.178446] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11426.184371] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11426.190645] CPU: 5 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11426.196994] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11426.196995] Call Trace:
[11426.197002]  dump_stack+0x46/0x59
[11426.197006]  swiotlb_alloc_coherent+0x162/0x173
[11426.197011]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11426.197014]  ttm_dma_populate+0xfb/0x29c [ttm]
[11426.197017]  ttm_tt_bind+0x2d/0x52 [ttm]
[11426.197020]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11426.197023]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11426.227598]  ? enqueue_entity+0x504/0x653
[11426.230310]  ttm_bo_validate+0x76/0xd4 [ttm]
[11426.233326]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11426.233329]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11426.233360]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11426.233375]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11426.233389]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11426.233405]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11426.254924]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11426.254928]  ? resched_curr+0x38/0x4f
[11426.254942]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11426.254948]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11426.254954]  drm_ioctl+0x1ef/0x2d5 [drm]
[11426.271354]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11426.271356]  ? rpm_resume+0x89/0x3cb
[11426.271369]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11426.271372]  vfs_ioctl+0x19/0x26
[11426.271373]  do_vfs_ioctl+0x506/0x519
[11426.271376]  ? __audit_syscall_entry+0xba/0xde
[11426.271378]  SyS_ioctl+0x4d/0x6f
[11426.290597]  do_syscall_64+0x5c/0xe7
[11426.290601]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11426.290603] RIP: 0033:0x7f3af27290f7
[11426.298896] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11426.298898] RAX: ffffffffffffffda RBX: 00007f39db847830 RCX:
00007f3af27290f7
[11426.298899] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11426.298900] RBP: 000000000326d910 R08: 00007f39db847830 R09:
0000000000000004
[11426.298900] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[11426.298901] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39d9a586f0

[11541.794623] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11541.800674] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11541.806960] CPU: 7 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11541.813304] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11541.813306] Call Trace:
[11541.813313]  dump_stack+0x46/0x59
[11541.824047]  swiotlb_alloc_coherent+0x162/0x173
[11541.827278]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11541.831028]  ttm_dma_populate+0xfb/0x29c [ttm]
[11541.834166]  ttm_tt_bind+0x2d/0x52 [ttm]
[11541.836784]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11541.840537]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11541.843943]  ttm_bo_validate+0x76/0xd4 [ttm]
[11541.846967]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11541.850363]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11541.853968]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11541.857726]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11541.861140]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11541.864554]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11541.868576]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11541.872672]  ? preempt_count_add+0x75/0x87
[11541.875474]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11541.879750]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11541.882811]  drm_ioctl+0x1ef/0x2d5 [drm]
[11541.882831]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11541.889696]  ? rpm_resume+0x89/0x3cb
[11541.889715]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11541.895284]  vfs_ioctl+0x19/0x26
[11541.897217]  do_vfs_ioctl+0x506/0x519
[11541.899582]  ? __audit_syscall_entry+0xba/0xde
[11541.902726]  SyS_ioctl+0x4d/0x6f
[11541.904654]  do_syscall_64+0x5c/0xe7
[11541.904658]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11541.910674] RIP: 0033:0x7f3af27290f7
[11541.912946] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11541.912949] RAX: ffffffffffffffda RBX: 00007f39db63a6e0 RCX:
00007f3af27290f7
[11541.925037] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11541.925039] RBP: 000000000326d910 R08: 00007f39db63a6e0 R09:
0000000000000004
[11541.925040] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[11541.942517] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39db5bb1a0
[11557.395216] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152
bytes)
[11557.400974] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,
size=2097152
[11557.407488] CPU: 4 PID: 18225 Comm: Wow-64.exe Tainted: G
I      4.16.2 #1
[11557.413873] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[11557.413875] Call Trace:
[11557.422614]  dump_stack+0x46/0x59
[11557.424698]  swiotlb_alloc_coherent+0x162/0x173
[11557.427960]  ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]
[11557.431738]  ttm_dma_populate+0xfb/0x29c [ttm]
[11557.434917]  ttm_tt_bind+0x2d/0x52 [ttm]
[11557.434920]  ttm_bo_handle_move_mem+0x11a/0x323 [ttm]
[11557.434923]  ? ttm_bo_mem_space+0x14c/0x370 [ttm]
[11557.434927]  ? get_nohz_timer_target+0x16/0xe5
[11557.434929]  ttm_bo_validate+0x76/0xd4 [ttm]
[11557.434939]  ? drm_vma_offset_add+0x3b/0x4f [drm]
[11557.434941]  ttm_bo_init_reserved+0x30b/0x3a3 [ttm]
[11557.434972]  amdgpu_bo_do_create+0x224/0x3be [amdgpu]
[11557.434987]  ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]
[11557.465325]  amdgpu_bo_create+0x3e/0x181 [amdgpu]
[11557.465340]  amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]
[11557.465356]  amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]
[11557.465359]  ? resched_curr+0x38/0x4f
[11557.465373]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11557.465378]  drm_ioctl_kernel+0x5f/0x9b [drm]
[11557.465385]  drm_ioctl+0x1ef/0x2d5 [drm]
[11557.489498]  ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]
[11557.489501]  ? rpm_resume+0x89/0x3cb
[11557.489513]  amdgpu_drm_ioctl+0x45/0x73 [amdgpu]
[11557.489516]  vfs_ioctl+0x19/0x26
[11557.489518]  do_vfs_ioctl+0x506/0x519
[11557.489521]  ? __audit_syscall_entry+0xba/0xde
[11557.489522]  SyS_ioctl+0x4d/0x6f
[11557.489524]  do_syscall_64+0x5c/0xe7
[11557.489527]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[11557.489529] RIP: 0033:0x7f3af27290f7
[11557.489530] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[11557.489531] RAX: ffffffffffffffda RBX: 00007f39db8efae0 RCX:
00007f3af27290f7
[11557.489532] RDX: 000000000326d910 RSI: 00000000c0206440 RDI:
000000000000008a
[11557.489533] RBP: 000000000326d910 R08: 00007f39db8efae0 R09:
0000000000000004
[11557.489534] R10: 00007f3a980008d0 R11: 0000000000000246 R12:
00000000c0206440
[11557.489534] R13: 000000000000008a R14: 000000000326d988 R15:
00007f39db55a6a0

--000000000000853684056a6eb412
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail-msg-body gmail-P_wpofO gmail-iy_A"><di=
v class=3D"gmail-jb_0 gmail-X_6MGW gmail-N_6Fd5"><div><div dir=3D"ltr">Hi,<=
br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">I
 have recently upgraded to the 4.16 kernel, and have now noticed the=20
following appearing in my dmesg log. This didn&#39;t happen with the 4.15=
=20
kernel. I am also noticing that my graphics card runs ~10C hotter with=20
4.16.<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">The PCI numbers =
for this card are: 1002:665f (rev 81)<br><br></div><div>More information av=
ailable on request,<br></div><div>Cheers,<br></div><div>Chris<br></div><div=
 dir=3D"ltr"><br></div><div dir=3D"ltr">[ 9229.654917] amdgpu 0000:02:00.0:=
 swiotlb buffer is full (sz: 2097152 bytes)<br></div><div dir=3D"ltr">[ 922=
9.660763] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed, size=3D=
2097152<br></div><div dir=3D"ltr">[ 9229.667131] CPU: 4 PID: 18225 Comm: Wo=
w-64.exe Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1<br></div><div dir=3D"ltr">[ 9229.6=
73514] Hardware name: Gigabyte Technology Co., Ltd. EX58-UD3R/EX58-UD3R, BI=
OS FB=C2=A0 05/04/2009<br></div><div dir=3D"ltr">[ 9229.681212] Call Trace:=
<br></div><div dir=3D"ltr">[ 9229.682393]=C2=A0 dump_stack+0x46/0x59<br></d=
iv><div dir=3D"ltr">[ 9229.684462]=C2=A0 swiotlb_alloc_coherent+0x162/0x173=
<br></div><div dir=3D"ltr">[ 9229.687758]=C2=A0 ttm_dma_pool_get_pages+0x17=
0/0x3f7 [ttm]<br></div><div dir=3D"ltr">[ 9229.691604]=C2=A0 ttm_dma_popula=
te+0xfb/0x29c [ttm]<br></div><div dir=3D"ltr">[ 9229.694784]=C2=A0 ttm_tt_b=
ind+0x2d/0x52 [ttm]<br></div><div dir=3D"ltr">[ 9229.697427]=C2=A0 ttm_bo_h=
andle_move_mem+0x11a/0x323 [ttm]<br></div><div dir=3D"ltr">[ 9229.701276]=
=C2=A0 ? ttm_bo_mem_space+0x14c/0x370 [ttm]<br></div><div dir=3D"ltr">[ 922=
9.704732]=C2=A0 ttm_bo_validate+0x76/0xd4 [ttm]<br></div><div dir=3D"ltr">[=
 9229.707792]=C2=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<br></div><div dir=
=3D"ltr">[ 9229.711268]=C2=A0 ttm_bo_init_reserved+0x30b/0x3a3 [ttm]<br></d=
iv><div dir=3D"ltr">[ 9229.714945]=C2=A0 amdgpu_bo_do_create+0x224/0x3be [a=
mdgpu]<br></div><div dir=3D"ltr">[ 9229.718753]=C2=A0 ? amdgpu_bo_unref+0x2=
f/0x2f [amdgpu]<br></div><div dir=3D"ltr">[ 9229.722325]=C2=A0 ? amdgpu_vm_=
bo_update+0x3e1/0x426 [amdgpu]<br></div><div dir=3D"ltr">[ 9229.726275]=C2=
=A0 amdgpu_bo_create+0x3e/0x181 [amdgpu]<br></div><div dir=3D"ltr">[ 9229.7=
29788]=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]<br></div><div dir=
=3D"ltr">[ 9229.733834]=C2=A0 amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<=
br></div><div dir=3D"ltr">[ 9229.737952]=C2=A0 ? resched_curr+0x38/0x4f<br>=
</div><div dir=3D"ltr">[ 9229.740351]=C2=A0 ? amdgpu_gem_object_close+0x19f=
/0x19f [amdgpu]<br></div><div dir=3D"ltr">[ 9229.744639]=C2=A0 drm_ioctl_ke=
rnel+0x5f/0x9b [drm]<br></div><div dir=3D"ltr">[ 9229.747699]=C2=A0 drm_ioc=
tl+0x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr">[ 9229.750371]=C2=A0 ? amdgp=
u_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[ 9229.75=
4662]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div dir=3D"ltr">[ 9229.757059=
]=C2=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></div><div dir=3D"ltr">[ 922=
9.760399]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div dir=3D"ltr">[ 9229.762353=
]=C2=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=3D"ltr">[ 9229.764725]=
=C2=A0 ? __audit_syscall_entry+0xba/0xde<br></div><div dir=3D"ltr">[ 9229.7=
67895]=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=3D"ltr">[ 9229.769854]=
=C2=A0 do_syscall_64+0x5c/0xe7<br></div><div dir=3D"ltr">[ 9229.772188]=C2=
=A0 entry_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div><div dir=3D"ltr">[ 92=
29.776023] RIP: 0033:0x7f3af27290f7<br></div><div dir=3D"ltr">[ 9229.778494=
] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br=
></div><div dir=3D"ltr">[ 9229.778496] RAX: ffffffffffffffda RBX: 00007f3a9=
aa8bbc0 RCX: 00007f3af27290f7<br></div><div dir=3D"ltr">[ 9229.778497] RDX:=
 000000000326d910 RSI: 00000000c0206440 RDI: 000000000000008a<br></div><div=
 dir=3D"ltr">[ 9229.778498] RBP: 000000000326d910 R08: 00007f3a9aa8bbc0 R09=
: 0000000000000004<br></div><div dir=3D"ltr">[ 9229.778499] R10: 00007f3a98=
0008d0 R11: 0000000000000246 R12: 00000000c0206440<br></div><div dir=3D"ltr=
">[ 9229.778500] R13: 000000000000008a R14: 000000000326d988 R15: 00007f39d=
9e3e560<br></div><div dir=3D"ltr">[ 9397.135877] amdgpu 0000:02:00.0: swiot=
lb buffer is full (sz: 2097152 bytes)<br></div><div dir=3D"ltr">[ 9397.1416=
57] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed, size=3D209715=
2<br></div><div dir=3D"ltr">[ 9397.147968] CPU: 6 PID: 18225 Comm: Wow-64.e=
xe Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1<br></div><div dir=3D"ltr">[ 9397.154352]=
 Hardware name: Gigabyte Technology Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=
=C2=A0 05/04/2009<br></div><div dir=3D"ltr">[ 9397.161996] Call Trace:<br><=
/div><div dir=3D"ltr">[ 9397.163182]=C2=A0 dump_stack+0x46/0x59<br></div><d=
iv dir=3D"ltr">[ 9397.165214]=C2=A0 swiotlb_alloc_coherent+0x162/0x173<br><=
/div><div dir=3D"ltr">[ 9397.168526]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3=
f7 [ttm]<br></div><div dir=3D"ltr">[ 9397.172279]=C2=A0 ttm_dma_populate+0x=
fb/0x29c [ttm]<br></div><div dir=3D"ltr">[ 9397.175432]=C2=A0 ttm_tt_bind+0=
x2d/0x52 [ttm]<br></div><div dir=3D"ltr">[ 9397.178180]=C2=A0 ttm_bo_handle=
_move_mem+0x11a/0x323 [ttm]<br></div><div dir=3D"ltr">[ 9397.181943]=C2=A0 =
? ttm_bo_mem_space+0x14c/0x370 [ttm]<br></div><div dir=3D"ltr">[ 9397.18538=
1]=C2=A0 ? __slab_alloc.isra.20.constprop.25+0x3d/0x46<br></div><div dir=3D=
"ltr">[ 9397.189714]=C2=A0 ttm_bo_validate+0x76/0xd4 [ttm]<br></div><div di=
r=3D"ltr">[ 9397.192713]=C2=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<br></di=
v><div dir=3D"ltr">[ 9397.196127]=C2=A0 ttm_bo_init_reserved+0x30b/0x3a3 [t=
tm]<br></div><div dir=3D"ltr">[ 9397.199767]=C2=A0 amdgpu_bo_do_create+0x22=
4/0x3be [amdgpu]<br></div><div dir=3D"ltr">[ 9397.203536]=C2=A0 ? amdgpu_bo=
_unref+0x2f/0x2f [amdgpu]<br></div><div dir=3D"ltr">[ 9397.206993]=C2=A0 am=
dgpu_bo_create+0x3e/0x181 [amdgpu]<br></div><div dir=3D"ltr">[ 9397.210443]=
=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]<br></div><div dir=3D"ltr=
">[ 9397.214533]=C2=A0 amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<br></di=
v><div dir=3D"ltr">[ 9397.218637]=C2=A0 ? preempt_count_add+0x75/0x87<br></=
div><div dir=3D"ltr">[ 9397.221534]=C2=A0 ? amdgpu_gem_object_close+0x19f/0=
x19f [amdgpu]<br></div><div dir=3D"ltr">[ 9397.225880]=C2=A0 drm_ioctl_kern=
el+0x5f/0x9b [drm]<br></div><div dir=3D"ltr">[ 9397.225887]=C2=A0 drm_ioctl=
+0x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr">[ 9397.231658]=C2=A0 ? amdgpu_=
gem_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[ 9397.2359=
79]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div dir=3D"ltr">[ 9397.238266]=
=C2=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></div><div dir=3D"ltr">[ 9397=
.241673]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div dir=3D"ltr">[ 9397.243619]=
=C2=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=3D"ltr">[ 9397.245997]=C2=
=A0 ? __audit_syscall_entry+0xba/0xde<br></div><div dir=3D"ltr">[ 9397.2491=
75]=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=3D"ltr">[ 9397.251127]=C2=
=A0 do_syscall_64+0x5c/0xe7<br></div><div dir=3D"ltr">[ 9397.253434]=C2=A0 =
entry_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div><div dir=3D"ltr">[ 9397.2=
57208] RIP: 0033:0x7f3af27290f7<br></div><div dir=3D"ltr">[ 9397.259522] RS=
P: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br></d=
iv><div dir=3D"ltr">[ 9397.265814] RAX: ffffffffffffffda RBX: 00007f39da2ea=
a90 RCX: 00007f3af27290f7<br></div><div dir=3D"ltr">[ 9397.271691] RDX: 000=
000000326d910 RSI: 00000000c0206440 RDI: 000000000000008a<br></div><div dir=
=3D"ltr">[ 9397.277600] RBP: 000000000326d910 R08: 00007f39da2eaa90 R09: 00=
00000000000004<br></div><div dir=3D"ltr">[ 9397.283566] R10: 00007f3a980008=
d0 R11: 0000000000000246 R12: 00000000c0206440<br></div><div dir=3D"ltr">[ =
9397.283567] R13: 000000000000008a R14: 000000000326d988 R15: 00007f3a9a5d5=
ee0<br></div><div dir=3D"ltr">[ 9405.461010] amdgpu 0000:02:00.0: swiotlb b=
uffer is full (sz: 2097152 bytes)<br></div><div dir=3D"ltr">[ 9405.466786] =
amdgpu 0000:02:00.0: swiotlb: coherent allocation failed, size=3D2097152<br=
></div><div dir=3D"ltr">[ 9405.473097] CPU: 3 PID: 18225 Comm: Wow-64.exe T=
ainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1<br></div><div dir=3D"ltr">[ 9405.479509] Ha=
rdware name: Gigabyte Technology Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=C2=
=A0 05/04/2009<br></div><div dir=3D"ltr">[ 9405.487130] Call Trace:<br></di=
v><div dir=3D"ltr">[ 9405.488311]=C2=A0 dump_stack+0x46/0x59<br></div><div =
dir=3D"ltr">[ 9405.490337]=C2=A0 swiotlb_alloc_coherent+0x162/0x173<br></di=
v><div dir=3D"ltr">[ 9405.493598]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3f7 =
[ttm]<br></div><div dir=3D"ltr">[ 9405.497383]=C2=A0 ttm_dma_populate+0xfb/=
0x29c [ttm]<br></div><div dir=3D"ltr">[ 9405.500600]=C2=A0 ttm_tt_bind+0x2d=
/0x52 [ttm]<br></div><div dir=3D"ltr">[ 9405.503242]=C2=A0 ttm_bo_handle_mo=
ve_mem+0x11a/0x323 [ttm]<br></div><div dir=3D"ltr">[ 9405.507029]=C2=A0 ? t=
tm_bo_mem_space+0x14c/0x370 [ttm]<br></div><div dir=3D"ltr">[ 9405.510470]=
=C2=A0 ttm_bo_validate+0x76/0xd4 [ttm]<br></div><div dir=3D"ltr">[ 9405.513=
493]=C2=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<br></div><div dir=3D"ltr">[=
 9405.516968]=C2=A0 ttm_bo_init_reserved+0x30b/0x3a3 [ttm]<br></div><div di=
r=3D"ltr">[ 9405.520623]=C2=A0 amdgpu_bo_do_create+0x224/0x3be [amdgpu]<br>=
</div><div dir=3D"ltr">[ 9405.524436]=C2=A0 ? amdgpu_bo_unref+0x2f/0x2f [am=
dgpu]<br></div><div dir=3D"ltr">[ 9405.527912]=C2=A0 amdgpu_bo_create+0x3e/=
0x181 [amdgpu]<br></div><div dir=3D"ltr">[ 9405.531351]=C2=A0 amdgpu_gem_ob=
ject_create+0x5c/0xd3 [amdgpu]<br></div><div dir=3D"ltr">[ 9405.535435]=C2=
=A0 amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<br></div><div dir=3D"ltr">=
[ 9405.539565]=C2=A0 ? hrtimer_cancel+0xc/0x16<br></div><div dir=3D"ltr">[ =
9405.542044]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></div>=
<div dir=3D"ltr">[ 9405.546335]=C2=A0 drm_ioctl_kernel+0x5f/0x9b [drm]<br><=
/div><div dir=3D"ltr">[ 9405.549459]=C2=A0 drm_ioctl+0x1ef/0x2d5 [drm]<br><=
/div><div dir=3D"ltr">[ 9405.552135]=C2=A0 ? amdgpu_gem_object_close+0x19f/=
0x19f [amdgpu]<br></div><div dir=3D"ltr">[ 9405.556419]=C2=A0 ? rpm_resume+=
0x89/0x3cb<br></div><div dir=3D"ltr">[ 9405.558753]=C2=A0 amdgpu_drm_ioctl+=
0x45/0x73 [amdgpu]<br></div><div dir=3D"ltr">[ 9405.562081]=C2=A0 vfs_ioctl=
+0x19/0x26<br></div><div dir=3D"ltr">[ 9405.564020]=C2=A0 do_vfs_ioctl+0x50=
6/0x519<br></div><div dir=3D"ltr">[ 9405.566419]=C2=A0 ? __audit_syscall_en=
try+0xba/0xde<br></div><div dir=3D"ltr">[ 9405.569634]=C2=A0 SyS_ioctl+0x4d=
/0x6f<br></div><div dir=3D"ltr">[ 9405.571594]=C2=A0 do_syscall_64+0x5c/0xe=
7<br></div><div dir=3D"ltr">[ 9405.573911]=C2=A0 entry_SYSCALL_64_after_hwf=
rame+0x3d/0xa2<br></div><div dir=3D"ltr">[ 9405.577711] RIP: 0033:0x7f3af27=
290f7<br></div><div dir=3D"ltr">[ 9405.580020] RSP: 002b:000000000326e088 E=
FLAGS: 00000246 ORIG_RAX: 0000000000000010<br></div><div dir=3D"ltr">[ 9405=
.586377] RAX: ffffffffffffffda RBX: 00007f39d9f9d3d0 RCX: 00007f3af27290f7<=
br></div><div dir=3D"ltr">[ 9405.592332] RDX: 000000000326e0d0 RSI: 0000000=
0c0206440 RDI: 000000000000008a<br></div><div dir=3D"ltr">[ 9405.598287] RB=
P: 000000000326e0d0 R08: 00007f39d9f9d3d0 R09: 0000000000000004<br></div><d=
iv dir=3D"ltr">[ 9405.604248] R10: 00007f3a980008d0 R11: 0000000000000246 R=
12: 00000000c0206440<br></div><div dir=3D"ltr">[ 9405.610202] R13: 00000000=
0000008a R14: 000000000326e148 R15: 00007f39da2ab860<br></div><div dir=3D"l=
tr">[ 9407.963742] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152=
 bytes)<br></div><div dir=3D"ltr">[ 9407.969516] amdgpu 0000:02:00.0: swiot=
lb: coherent allocation failed, size=3D2097152<br></div><div dir=3D"ltr">[ =
9407.975852] CPU: 1 PID: 18225 Comm: Wow-64.exe Tainted: G=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.1=
6.2 #1<br></div><div dir=3D"ltr">[ 9407.982301] Hardware name: Gigabyte Tec=
hnology Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=C2=A0 05/04/2009<br></div><d=
iv dir=3D"ltr">[ 9407.989920] Call Trace:<br></div><div dir=3D"ltr">[ 9407.=
991104]=C2=A0 dump_stack+0x46/0x59<br></div><div dir=3D"ltr">[ 9407.993131]=
=C2=A0 swiotlb_alloc_coherent+0x162/0x173<br></div><div dir=3D"ltr">[ 9407.=
996371]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]<br></div><div dir=3D=
"ltr">[ 9408.000149]=C2=A0 ttm_dma_populate+0xfb/0x29c [ttm]<br></div><div =
dir=3D"ltr">[ 9408.003336]=C2=A0 ttm_tt_bind+0x2d/0x52 [ttm]<br></div><div =
dir=3D"ltr">[ 9408.006008]=C2=A0 ttm_bo_handle_move_mem+0x11a/0x323 [ttm]<b=
r></div><div dir=3D"ltr">[ 9408.009796]=C2=A0 ? ttm_bo_mem_space+0x14c/0x37=
0 [ttm]<br></div><div dir=3D"ltr">[ 9408.013280]=C2=A0 ? enqueue_entity+0x5=
04/0x653<br></div><div dir=3D"ltr">[ 9408.016008]=C2=A0 ttm_bo_validate+0x7=
6/0xd4 [ttm]<br></div><div dir=3D"ltr">[ 9408.019067]=C2=A0 ? drm_vma_offse=
t_add+0x3b/0x4f [drm]<br></div><div dir=3D"ltr">[ 9408.022475]=C2=A0 ttm_bo=
_init_reserved+0x30b/0x3a3 [ttm]<br></div><div dir=3D"ltr">[ 9408.026137]=
=C2=A0 amdgpu_bo_do_create+0x224/0x3be [amdgpu]<br></div><div dir=3D"ltr">[=
 9408.029966]=C2=A0 ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]<br></div><div dir=
=3D"ltr">[ 9408.033415]=C2=A0 amdgpu_bo_create+0x3e/0x181 [amdgpu]<br></div=
><div dir=3D"ltr">[ 9408.036876]=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [=
amdgpu]<br></div><div dir=3D"ltr">[ 9408.041029]=C2=A0 amdgpu_gem_create_io=
ctl+0x138/0x1f6 [amdgpu]<br></div><div dir=3D"ltr">[ 9408.045200]=C2=A0 ? r=
esched_curr+0x38/0x4f<br></div><div dir=3D"ltr">[ 9408.047592]=C2=A0 ? amdg=
pu_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[ 9408.0=
51899]=C2=A0 drm_ioctl_kernel+0x5f/0x9b [drm]<br></div><div dir=3D"ltr">[ 9=
408.055064]=C2=A0 drm_ioctl+0x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr">[ 9=
408.057743]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></div><=
div dir=3D"ltr">[ 9408.062021]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div =
dir=3D"ltr">[ 9408.064336]=C2=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></d=
iv><div dir=3D"ltr">[ 9408.067670]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div =
dir=3D"ltr">[ 9408.069626]=C2=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=
=3D"ltr">[ 9408.072074]=C2=A0 ? __audit_syscall_entry+0xba/0xde<br></div><d=
iv dir=3D"ltr">[ 9408.075271]=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=
=3D"ltr">[ 9408.077229]=C2=A0 do_syscall_64+0x5c/0xe7<br></div><div dir=3D"=
ltr">[ 9408.079509]=C2=A0 entry_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div=
><div dir=3D"ltr">[ 9408.083286] RIP: 0033:0x7f3af27290f7<br></div><div dir=
=3D"ltr">[ 9408.085617] RSP: 002b:000000000326e088 EFLAGS: 00000246 ORIG_RA=
X: 0000000000000010<br></div><div dir=3D"ltr">[ 9408.092002] RAX: fffffffff=
fffffda RBX: 00007f3a9a59c270 RCX: 00007f3af27290f7<br></div><div dir=3D"lt=
r">[ 9408.098005] RDX: 000000000326e0d0 RSI: 00000000c0206440 RDI: 00000000=
0000008a<br></div><div dir=3D"ltr">[ 9408.103885] RBP: 000000000326e0d0 R08=
: 00007f3a9a59c270 R09: 0000000000000004<br></div><div dir=3D"ltr">[ 9408.1=
09884] R10: 00007f3a980008d0 R11: 0000000000000246 R12: 00000000c0206440<br=
></div><div dir=3D"ltr">[ 9408.109885] R13: 000000000000008a R14: 000000000=
326e148 R15: 00007f39da117b20<br></div><div dir=3D"ltr">[ 9421.696643] amdg=
pu 0000:02:00.0: swiotlb buffer is full (sz: 2097152 bytes)<br></div><div d=
ir=3D"ltr">[ 9421.702356] amdgpu 0000:02:00.0: swiotlb: coherent allocation=
 failed, size=3D2097152<br></div><div dir=3D"ltr">[ 9421.702360] CPU: 0 PID=
: 18225 Comm: Wow-64.exe Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1<br></div><div dir=
=3D"ltr">[ 9421.702361] Hardware name: Gigabyte Technology Co., Ltd. EX58-U=
D3R/EX58-UD3R, BIOS FB=C2=A0 05/04/2009<br></div><div dir=3D"ltr">[ 9421.70=
2362] Call Trace:<br></div><div dir=3D"ltr">[ 9421.702371]=C2=A0 dump_stack=
+0x46/0x59<br></div><div dir=3D"ltr">[ 9421.702375]=C2=A0 swiotlb_alloc_coh=
erent+0x162/0x173<br></div><div dir=3D"ltr">[ 9421.728920]=C2=A0 ttm_dma_po=
ol_get_pages+0x170/0x3f7 [ttm]<br></div><div dir=3D"ltr">[ 9421.732669]=C2=
=A0 ttm_dma_populate+0xfb/0x29c [ttm]<br></div><div dir=3D"ltr">[ 9421.7358=
13]=C2=A0 ttm_tt_bind+0x2d/0x52 [ttm]<br></div><div dir=3D"ltr">[ 9421.7384=
41]=C2=A0 ttm_bo_handle_move_mem+0x11a/0x323 [ttm]<br></div><div dir=3D"ltr=
">[ 9421.742192]=C2=A0 ? ttm_bo_mem_space+0x14c/0x370 [ttm]<br></div><div d=
ir=3D"ltr">[ 9421.745600]=C2=A0 ? enqueue_entity+0x504/0x653<br></div><div =
dir=3D"ltr">[ 9421.745605]=C2=A0 ttm_bo_validate+0x76/0xd4 [ttm]<br></div><=
div dir=3D"ltr">[ 9421.751286]=C2=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<b=
r></div><div dir=3D"ltr">[ 9421.754689]=C2=A0 ttm_bo_init_reserved+0x30b/0x=
3a3 [ttm]<br></div><div dir=3D"ltr">[ 9421.758307]=C2=A0 amdgpu_bo_do_creat=
e+0x224/0x3be [amdgpu]<br></div><div dir=3D"ltr">[ 9421.762075]=C2=A0 ? amd=
gpu_bo_unref+0x2f/0x2f [amdgpu]<br></div><div dir=3D"ltr">[ 9421.765496]=C2=
=A0 amdgpu_bo_create+0x3e/0x181 [amdgpu]<br></div><div dir=3D"ltr">[ 9421.7=
68923]=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]<br></div><div dir=
=3D"ltr">[ 9421.772950]=C2=A0 amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<=
br></div><div dir=3D"ltr">[ 9421.777052]=C2=A0 ? resched_curr+0x38/0x4f<br>=
</div><div dir=3D"ltr">[ 9421.779431]=C2=A0 ? amdgpu_gem_object_close+0x19f=
/0x19f [amdgpu]<br></div><div dir=3D"ltr">[ 9421.783701]=C2=A0 drm_ioctl_ke=
rnel+0x5f/0x9b [drm]<br></div><div dir=3D"ltr">[ 9421.786763]=C2=A0 drm_ioc=
tl+0x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr">[ 9421.789408]=C2=A0 ? amdgp=
u_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[ 9421.79=
3680]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div dir=3D"ltr">[ 9421.795972=
]=C2=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></div><div dir=3D"ltr">[ 942=
1.799288]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div dir=3D"ltr">[ 9421.801219=
]=C2=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=3D"ltr">[ 9421.801223]=
=C2=A0 ? __audit_syscall_entry+0xba/0xde<br></div><div dir=3D"ltr">[ 9421.8=
06723]=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=3D"ltr">[ 9421.808656]=
=C2=A0 do_syscall_64+0x5c/0xe7<br></div><div dir=3D"ltr">[ 9421.810937]=C2=
=A0 entry_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div><div dir=3D"ltr">[ 94=
21.810939] RIP: 0033:0x7f3af27290f7<br></div><div dir=3D"ltr">[ 9421.816957=
] RSP: 002b:000000000326e088 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br=
></div><div dir=3D"ltr">[ 9421.823223] RAX: ffffffffffffffda RBX: 00007f39d=
92845c0 RCX: 00007f3af27290f7<br></div><div dir=3D"ltr">[ 9421.829046] RDX:=
 000000000326e0d0 RSI: 00000000c0206440 RDI: 000000000000008a<br></div><div=
 dir=3D"ltr">[ 9421.829048] RBP: 000000000326e0d0 R08: 00007f39d92845c0 R09=
: 0000000000000004<br></div><div dir=3D"ltr">[ 9421.840694] R10: 00007f3a98=
0008d0 R11: 0000000000000246 R12: 00000000c0206440<br></div><div dir=3D"ltr=
">[ 9421.846519] R13: 000000000000008a R14: 000000000326e148 R15: 00007f39d=
9807160<br></div><div dir=3D"ltr">[10943.377740] amdgpu 0000:02:00.0: swiot=
lb buffer is full (sz: 2097152 bytes)<br></div><div dir=3D"ltr">[10943.3835=
24] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed, size=3D209715=
2<br></div><div dir=3D"ltr">[10943.389971] CPU: 6 PID: 18225 Comm: Wow-64.e=
xe Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1<br></div><div dir=3D"ltr">[10943.389972]=
 Hardware name: Gigabyte Technology Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=
=C2=A0 05/04/2009<br></div><div dir=3D"ltr">[10943.389973] Call Trace:<br><=
/div><div dir=3D"ltr">[10943.405174]=C2=A0 dump_stack+0x46/0x59<br></div><d=
iv dir=3D"ltr">[10943.407197]=C2=A0 swiotlb_alloc_coherent+0x162/0x173<br><=
/div><div dir=3D"ltr">[10943.410502]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3=
f7 [ttm]<br></div><div dir=3D"ltr">[10943.410506]=C2=A0 ttm_dma_populate+0x=
fb/0x29c [ttm]<br></div><div dir=3D"ltr">[10943.417571]=C2=A0 ttm_tt_bind+0=
x2d/0x52 [ttm]<br></div><div dir=3D"ltr">[10943.420284]=C2=A0 ttm_bo_handle=
_move_mem+0x11a/0x323 [ttm]<br></div><div dir=3D"ltr">[10943.424035]=C2=A0 =
? ttm_bo_mem_space+0x14c/0x370 [ttm]<br></div><div dir=3D"ltr">[10943.42747=
1]=C2=A0 ? enqueue_entity+0x504/0x653<br></div><div dir=3D"ltr">[10943.4274=
74]=C2=A0 ttm_bo_validate+0x76/0xd4 [ttm]<br></div><div dir=3D"ltr">[10943.=
433204]=C2=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<br></div><div dir=3D"ltr=
">[10943.436614]=C2=A0 ttm_bo_init_reserved+0x30b/0x3a3 [ttm]<br></div><div=
 dir=3D"ltr">[10943.436665]=C2=A0 amdgpu_bo_do_create+0x224/0x3be [amdgpu]<=
br></div><div dir=3D"ltr">[10943.443990]=C2=A0 ? amdgpu_bo_unref+0x2f/0x2f =
[amdgpu]<br></div><div dir=3D"ltr">[10943.444008]=C2=A0 amdgpu_bo_create+0x=
3e/0x181 [amdgpu]<br></div><div dir=3D"ltr">[10943.450853]=C2=A0 amdgpu_gem=
_object_create+0x5c/0xd3 [amdgpu]<br></div><div dir=3D"ltr">[10943.450873]=
=C2=A0 amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<br></div><div dir=3D"lt=
r">[10943.459154]=C2=A0 ? resched_curr+0x38/0x4f<br></div><div dir=3D"ltr">=
[10943.461581]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></di=
v><div dir=3D"ltr">[10943.465969]=C2=A0 drm_ioctl_kernel+0x5f/0x9b [drm]<br=
></div><div dir=3D"ltr">[10943.469056]=C2=A0 drm_ioctl+0x1ef/0x2d5 [drm]<br=
></div><div dir=3D"ltr">[10943.469077]=C2=A0 ? amdgpu_gem_object_close+0x19=
f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[10943.475993]=C2=A0 ? rpm_resum=
e+0x89/0x3cb<br></div><div dir=3D"ltr">[10943.476012]=C2=A0 amdgpu_drm_ioct=
l+0x45/0x73 [amdgpu]<br></div><div dir=3D"ltr">[10943.481651]=C2=A0 vfs_ioc=
tl+0x19/0x26<br></div><div dir=3D"ltr">[10943.483611]=C2=A0 do_vfs_ioctl+0x=
506/0x519<br></div><div dir=3D"ltr">[10943.483616]=C2=A0 ? __audit_syscall_=
entry+0xba/0xde<br></div><div dir=3D"ltr">[10943.489198]=C2=A0 SyS_ioctl+0x=
4d/0x6f<br></div><div dir=3D"ltr">[10943.491151]=C2=A0 do_syscall_64+0x5c/0=
xe7<br></div><div dir=3D"ltr">[10943.491155]=C2=A0 entry_SYSCALL_64_after_h=
wframe+0x3d/0xa2<br></div><div dir=3D"ltr">[10943.497188] RIP: 0033:0x7f3af=
27290f7<br></div><div dir=3D"ltr">[10943.499492] RSP: 002b:000000000326d8c8=
 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br></div><div dir=3D"ltr">[109=
43.505844] RAX: ffffffffffffffda RBX: 00007f39db4e9580 RCX: 00007f3af27290f=
7<br></div><div dir=3D"ltr">[10943.511706] RDX: 000000000326d910 RSI: 00000=
000c0206440 RDI: 000000000000008a<br></div><div dir=3D"ltr">[10943.511708] =
RBP: 000000000326d910 R08: 00007f39db4e9580 R09: 0000000000000004<br></div>=
<div dir=3D"ltr">[10943.511709] R10: 00007f3a980008d0 R11: 0000000000000246=
 R12: 00000000c0206440<br></div><div dir=3D"ltr">[10943.511710] R13: 000000=
000000008a R14: 000000000326d988 R15: 00007f39db4e2be0<br></div><div dir=3D=
"ltr">[11005.809894] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 20971=
52 bytes)<br></div><div dir=3D"ltr">[11005.815666] amdgpu 0000:02:00.0: swi=
otlb: coherent allocation failed, size=3D2097152<br></div><div dir=3D"ltr">=
[11005.815668] CPU: 3 PID: 18225 Comm: Wow-64.exe Tainted: G=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.1=
6.2 #1<br></div><div dir=3D"ltr">[11005.815669] Hardware name: Gigabyte Tec=
hnology Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=C2=A0 05/04/2009<br></div><d=
iv dir=3D"ltr">[11005.815670] Call Trace:<br></div><div dir=3D"ltr">[11005.=
815677]=C2=A0 dump_stack+0x46/0x59<br></div><div dir=3D"ltr">[11005.815680]=
=C2=A0 swiotlb_alloc_coherent+0x162/0x173<br></div><div dir=3D"ltr">[11005.=
815688]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]<br></div><div dir=3D=
"ltr">[11005.815692]=C2=A0 ttm_dma_populate+0xfb/0x29c [ttm]<br></div><div =
dir=3D"ltr">[11005.815695]=C2=A0 ttm_tt_bind+0x2d/0x52 [ttm]<br></div><div =
dir=3D"ltr">[11005.852103]=C2=A0 ttm_bo_handle_move_mem+0x11a/0x323 [ttm]<b=
r></div><div dir=3D"ltr">[11005.852108]=C2=A0 ? ttm_bo_mem_space+0x14c/0x37=
0 [ttm]<br></div><div dir=3D"ltr">[11005.852111]=C2=A0 ? __slab_alloc.isra.=
20.constprop.25+0x3d/0x46<br></div><div dir=3D"ltr">[11005.852115]=C2=A0 tt=
m_bo_validate+0x76/0xd4 [ttm]<br></div><div dir=3D"ltr">[11005.852129]=C2=
=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<br></div><div dir=3D"ltr">[11005.8=
52133]=C2=A0 ttm_bo_init_reserved+0x30b/0x3a3 [ttm]<br></div><div dir=3D"lt=
r">[11005.852175]=C2=A0 amdgpu_bo_do_create+0x224/0x3be [amdgpu]<br></div><=
div dir=3D"ltr">[11005.852200]=C2=A0 ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]<b=
r></div><div dir=3D"ltr">[11005.880866]=C2=A0 amdgpu_bo_create+0x3e/0x181 [=
amdgpu]<br></div><div dir=3D"ltr">[11005.880882]=C2=A0 amdgpu_gem_object_cr=
eate+0x5c/0xd3 [amdgpu]<br></div><div dir=3D"ltr">[11005.880897]=C2=A0 amdg=
pu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<br></div><div dir=3D"ltr">[11005.8=
80901]=C2=A0 ? resched_curr+0x38/0x4f<br></div><div dir=3D"ltr">[11005.8948=
79]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=
=3D"ltr">[11005.894885]=C2=A0 drm_ioctl_kernel+0x5f/0x9b [drm]<br></div><di=
v dir=3D"ltr">[11005.894891]=C2=A0 drm_ioctl+0x1ef/0x2d5 [drm]<br></div><di=
v dir=3D"ltr">[11005.894906]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [a=
mdgpu]<br></div><div dir=3D"ltr">[11005.894909]=C2=A0 ? rpm_resume+0x89/0x3=
cb<br></div><div dir=3D"ltr">[11005.911752]=C2=A0 amdgpu_drm_ioctl+0x45/0x7=
3 [amdgpu]<br></div><div dir=3D"ltr">[11005.911755]=C2=A0 vfs_ioctl+0x19/0x=
26<br></div><div dir=3D"ltr">[11005.911756]=C2=A0 do_vfs_ioctl+0x506/0x519<=
br></div><div dir=3D"ltr">[11005.911760]=C2=A0 ? __audit_syscall_entry+0xba=
/0xde<br></div><div dir=3D"ltr">[11005.911761]=C2=A0 SyS_ioctl+0x4d/0x6f<br=
></div><div dir=3D"ltr">[11005.911763]=C2=A0 do_syscall_64+0x5c/0xe7<br></d=
iv><div dir=3D"ltr">[11005.911767]=C2=A0 entry_SYSCALL_64_after_hwframe+0x3=
d/0xa2<br></div><div dir=3D"ltr">[11005.911768] RIP: 0033:0x7f3af27290f7<br=
></div><div dir=3D"ltr">[11005.911769] RSP: 002b:000000000326d8c8 EFLAGS: 0=
0000246 ORIG_RAX: 0000000000000010<br></div><div dir=3D"ltr">[11005.911771]=
 RAX: ffffffffffffffda RBX: 00007f39db4ef4a0 RCX: 00007f3af27290f7<br></div=
><div dir=3D"ltr">[11005.911772] RDX: 000000000326d910 RSI: 00000000c020644=
0 RDI: 000000000000008a<br></div><div dir=3D"ltr">[11005.911772] RBP: 00000=
0000326d910 R08: 00007f39db4ef4a0 R09: 000000000000000b<br></div><div dir=
=3D"ltr">[11005.911773] R10: 0000000000000000 R11: 0000000000000246 R12: 00=
000000c0206440<br></div><div dir=3D"ltr">[11005.911774] R13: 00000000000000=
8a R14: 000000000326d988 R15: 00007f39da324080<br></div><div dir=3D"ltr">[1=
1017.845296] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152 bytes=
)<br></div><div dir=3D"ltr">[11017.851038] amdgpu 0000:02:00.0: swiotlb: co=
herent allocation failed, size=3D2097152<br></div><div dir=3D"ltr">[11017.8=
57396] CPU: 3 PID: 18225 Comm: Wow-64.exe Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1=
<br></div><div dir=3D"ltr">[11017.863762] Hardware name: Gigabyte Technolog=
y Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=C2=A0 05/04/2009<br></div><div dir=
=3D"ltr">[11017.871372] Call Trace:<br></div><div dir=3D"ltr">[11017.872524=
]=C2=A0 dump_stack+0x46/0x59<br></div><div dir=3D"ltr">[11017.874540]=C2=A0=
 swiotlb_alloc_coherent+0x162/0x173<br></div><div dir=3D"ltr">[11017.877826=
]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]<br></div><div dir=3D"ltr">=
[11017.881603]=C2=A0 ttm_dma_populate+0xfb/0x29c [ttm]<br></div><div dir=3D=
"ltr">[11017.884800]=C2=A0 ttm_tt_bind+0x2d/0x52 [ttm]<br></div><div dir=3D=
"ltr">[11017.887451]=C2=A0 ttm_bo_handle_move_mem+0x11a/0x323 [ttm]<br></di=
v><div dir=3D"ltr">[11017.891224]=C2=A0 ? ttm_bo_mem_space+0x14c/0x370 [ttm=
]<br></div><div dir=3D"ltr">[11017.894706]=C2=A0 ? get_nohz_timer_target+0x=
16/0xe5<br></div><div dir=3D"ltr">[11017.897852]=C2=A0 ttm_bo_validate+0x76=
/0xd4 [ttm]<br></div><div dir=3D"ltr">[11017.900863]=C2=A0 ? drm_vma_offset=
_add+0x3b/0x4f [drm]<br></div><div dir=3D"ltr">[11017.904301]=C2=A0 ttm_bo_=
init_reserved+0x30b/0x3a3 [ttm]<br></div><div dir=3D"ltr">[11017.908018]=C2=
=A0 amdgpu_bo_do_create+0x224/0x3be [amdgpu]<br></div><div dir=3D"ltr">[110=
17.911837]=C2=A0 ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]<br></div><div dir=3D"=
ltr">[11017.915349]=C2=A0 amdgpu_bo_create+0x3e/0x181 [amdgpu]<br></div><di=
v dir=3D"ltr">[11017.918801]=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [amdg=
pu]<br></div><div dir=3D"ltr">[11017.922920]=C2=A0 amdgpu_gem_create_ioctl+=
0x138/0x1f6 [amdgpu]<br></div><div dir=3D"ltr">[11017.927025]=C2=A0 ? resch=
ed_curr+0x38/0x4f<br></div><div dir=3D"ltr">[11017.929405]=C2=A0 ? amdgpu_g=
em_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[11017.93368=
3]=C2=A0 drm_ioctl_kernel+0x5f/0x9b [drm]<br></div><div dir=3D"ltr">[11017.=
936751]=C2=A0 drm_ioctl+0x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr">[11017.=
939442]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div =
dir=3D"ltr">[11017.943777]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div dir=
=3D"ltr">[11017.946120]=C2=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></div>=
<div dir=3D"ltr">[11017.949472]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div dir=
=3D"ltr">[11017.951427]=C2=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=3D=
"ltr">[11017.953814]=C2=A0 ? __audit_syscall_entry+0xba/0xde<br></div><div =
dir=3D"ltr">[11017.956991]=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=3D"l=
tr">[11017.958943]=C2=A0 do_syscall_64+0x5c/0xe7<br></div><div dir=3D"ltr">=
[11017.961239]=C2=A0 entry_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div><div=
 dir=3D"ltr">[11017.965024] RIP: 0033:0x7f3af27290f7<br></div><div dir=3D"l=
tr">[11017.967381] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010<br></div><div dir=3D"ltr">[11017.973718] RAX: ffffffffffffff=
da RBX: 00007f39db2ea130 RCX: 00007f3af27290f7<br></div><div dir=3D"ltr">[1=
1017.979627] RDX: 000000000326d910 RSI: 00000000c0206440 RDI: 0000000000000=
08a<br></div><div dir=3D"ltr">[11017.985624] RBP: 000000000326d910 R08: 000=
07f39db2ea130 R09: 0000000000000004<br></div><div dir=3D"ltr">[11017.991493=
] R10: 00007f3a980008d0 R11: 0000000000000246 R12: 00000000c0206440<br></di=
v><div dir=3D"ltr">[11017.997376] R13: 000000000000008a R14: 000000000326d9=
88 R15: 00007f39db1dee30<br></div><div dir=3D"ltr">[11069.149823]
 audit: type=3D1130 audit(1523832495.084:243): pid=3D1 uid=3D0 auid=3D42949=
67295
 ses=3D4294967295 msg=3D&#39;unit=3Ddnfdaemon comm=3D&quot;systemd&quot;=20
exe=3D&quot;/usr/lib/systemd/systemd&quot; hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess&#39;<br></div><div dir=3D"ltr">[11073.124430]
 audit: type=3D1131 audit(1523832499.058:244): pid=3D1 uid=3D0 auid=3D42949=
67295
 ses=3D4294967295 msg=3D&#39;unit=3Ddnfdaemon comm=3D&quot;systemd&quot;=20
exe=3D&quot;/usr/lib/systemd/systemd&quot; hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess&#39;<br></div><div dir=3D"ltr">[11106.125114] amdgpu 000=
0:02:00.0: swiotlb buffer is full (sz: 2097152 bytes)<br></div><div dir=3D"=
ltr">[11106.130857] amdgpu 0000:02:00.0: swiotlb: coherent allocation faile=
d, size=3D2097152<br></div><div dir=3D"ltr">[11106.137325] CPU: 5 PID: 1822=
5 Comm: Wow-64.exe Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1<br></div><div dir=3D"lt=
r">[11106.143712] Hardware name: Gigabyte Technology Co., Ltd. EX58-UD3R/EX=
58-UD3R, BIOS FB=C2=A0 05/04/2009<br></div><div dir=3D"ltr">[11106.151365] =
Call Trace:<br></div><div dir=3D"ltr">[11106.151372]=C2=A0 dump_stack+0x46/=
0x59<br></div><div dir=3D"ltr">[11106.154572]=C2=A0 swiotlb_alloc_coherent+=
0x162/0x173<br></div><div dir=3D"ltr">[11106.154578]=C2=A0 ttm_dma_pool_get=
_pages+0x170/0x3f7 [ttm]<br></div><div dir=3D"ltr">[11106.161587]=C2=A0 ttm=
_dma_populate+0xfb/0x29c [ttm]<br></div><div dir=3D"ltr">[11106.164783]=C2=
=A0 ttm_tt_bind+0x2d/0x52 [ttm]<br></div><div dir=3D"ltr">[11106.167411]=C2=
=A0 ttm_bo_handle_move_mem+0x11a/0x323 [ttm]<br></div><div dir=3D"ltr">[111=
06.171186]=C2=A0 ? ttm_bo_mem_space+0x14c/0x370 [ttm]<br></div><div dir=3D"=
ltr">[11106.171190]=C2=A0 ? enqueue_entity+0x504/0x653<br></div><div dir=3D=
"ltr">[11106.177368]=C2=A0 ttm_bo_validate+0x76/0xd4 [ttm]<br></div><div di=
r=3D"ltr">[11106.180453]=C2=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<br></di=
v><div dir=3D"ltr">[11106.180456]=C2=A0 ttm_bo_init_reserved+0x30b/0x3a3 [t=
tm]<br></div><div dir=3D"ltr">[11106.187614]=C2=A0 amdgpu_bo_do_create+0x22=
4/0x3be [amdgpu]<br></div><div dir=3D"ltr">[11106.187629]=C2=A0 ? amdgpu_bo=
_unref+0x2f/0x2f [amdgpu]<br></div><div dir=3D"ltr">[11106.194898]=C2=A0 am=
dgpu_bo_create+0x3e/0x181 [amdgpu]<br></div><div dir=3D"ltr">[11106.194914]=
=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]<br></div><div dir=3D"ltr=
">[11106.202419]=C2=A0 amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<br></di=
v><div dir=3D"ltr">[11106.206608]=C2=A0 ? resched_curr+0x38/0x4f<br></div><=
div dir=3D"ltr">[11106.209006]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f =
[amdgpu]<br></div><div dir=3D"ltr">[11106.213400]=C2=A0 drm_ioctl_kernel+0x=
5f/0x9b [drm]<br></div><div dir=3D"ltr">[11106.213406]=C2=A0 drm_ioctl+0x1e=
f/0x2d5 [drm]<br></div><div dir=3D"ltr">[11106.219305]=C2=A0 ? amdgpu_gem_o=
bject_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[11106.219309]=
=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div dir=3D"ltr">[11106.225982]=C2=
=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></div><div dir=3D"ltr">[11106.22=
5986]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div dir=3D"ltr">[11106.231298]=C2=
=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=3D"ltr">[11106.233731]=C2=A0=
 ? __audit_syscall_entry+0xba/0xde<br></div><div dir=3D"ltr">[11106.233733]=
=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=3D"ltr">[11106.238848]=C2=A0 d=
o_syscall_64+0x5c/0xe7<br></div><div dir=3D"ltr">[11106.241207]=C2=A0 entry=
_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div><div dir=3D"ltr">[11106.245059=
] RIP: 0033:0x7f3af27290f7<br></div><div dir=3D"ltr">[11106.247365] RSP: 00=
2b:000000000326e088 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br></div><d=
iv dir=3D"ltr">[11106.253762] RAX: ffffffffffffffda RBX: 00007f39db703ca0 R=
CX: 00007f3af27290f7<br></div><div dir=3D"ltr">[11106.253763] RDX: 00000000=
0326e0d0 RSI: 00000000c0206440 RDI: 000000000000008a<br></div><div dir=3D"l=
tr">[11106.253764] RBP: 000000000326e0d0 R08: 00007f39db703ca0 R09: 00007f3=
a98000180<br></div><div dir=3D"ltr">[11106.253764] R10: 0000000000000000 R1=
1: 0000000000000246 R12: 00000000c0206440<br></div><div dir=3D"ltr">[11106.=
253766] R13: 000000000000008a R14: 000000000326e148 R15: 00007f39db61d750<b=
r></div><div dir=3D"ltr">[11137.559983] amdgpu 0000:02:00.0: swiotlb buffer=
 is full (sz: 2097152 bytes)<br></div><div dir=3D"ltr">[11137.565715] amdgp=
u 0000:02:00.0: swiotlb: coherent allocation failed, size=3D2097152<br></di=
v><div dir=3D"ltr">[11137.572062] CPU: 4 PID: 18225 Comm: Wow-64.exe Tainte=
d: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 4.16.2 #1<br></div><div dir=3D"ltr">[11137.572063] Hardware=
 name: Gigabyte Technology Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=C2=A0 05/=
04/2009<br></div><div dir=3D"ltr">[11137.572065] Call Trace:<br></div><div =
dir=3D"ltr">[11137.572072]=C2=A0 dump_stack+0x46/0x59<br></div><div dir=3D"=
ltr">[11137.572075]=C2=A0 swiotlb_alloc_coherent+0x162/0x173<br></div><div =
dir=3D"ltr">[11137.572080]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]<b=
r></div><div dir=3D"ltr">[11137.572084]=C2=A0 ttm_dma_populate+0xfb/0x29c [=
ttm]<br></div><div dir=3D"ltr">[11137.572086]=C2=A0 ttm_tt_bind+0x2d/0x52 [=
ttm]<br></div><div dir=3D"ltr">[11137.572089]=C2=A0 ttm_bo_handle_move_mem+=
0x11a/0x323 [ttm]<br></div><div dir=3D"ltr">[11137.572092]=C2=A0 ? ttm_bo_m=
em_space+0x14c/0x370 [ttm]<br></div><div dir=3D"ltr">[11137.572095]=C2=A0 ?=
 __slab_alloc.isra.20.constprop.25+0x3d/0x46<br></div><div dir=3D"ltr">[111=
37.572098]=C2=A0 ttm_bo_validate+0x76/0xd4 [ttm]<br></div><div dir=3D"ltr">=
[11137.572109]=C2=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<br></div><div dir=
=3D"ltr">[11137.572111]=C2=A0 ttm_bo_init_reserved+0x30b/0x3a3 [ttm]<br></d=
iv><div dir=3D"ltr">[11137.572148]=C2=A0 amdgpu_bo_do_create+0x224/0x3be [a=
mdgpu]<br></div><div dir=3D"ltr">[11137.627953]=C2=A0 ? amdgpu_bo_unref+0x2=
f/0x2f [amdgpu]<br></div><div dir=3D"ltr">[11137.627988]=C2=A0 amdgpu_bo_cr=
eate+0x3e/0x181 [amdgpu]<br></div><div dir=3D"ltr">[11137.628003]=C2=A0 amd=
gpu_gem_object_create+0x5c/0xd3 [amdgpu]<br></div><div dir=3D"ltr">[11137.6=
38939]=C2=A0 amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<br></div><div dir=
=3D"ltr">[11137.638942]=C2=A0 ? resched_curr+0x38/0x4f<br></div><div dir=3D=
"ltr">[11137.638957]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<b=
r></div><div dir=3D"ltr">[11137.638963]=C2=A0 drm_ioctl_kernel+0x5f/0x9b [d=
rm]<br></div><div dir=3D"ltr">[11137.638969]=C2=A0 drm_ioctl+0x1ef/0x2d5 [d=
rm]<br></div><div dir=3D"ltr">[11137.655542]=C2=A0 ? amdgpu_gem_object_clos=
e+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[11137.659871]=C2=A0 ? rpm=
_resume+0x89/0x3cb<br></div><div dir=3D"ltr">[11137.662194]=C2=A0 amdgpu_dr=
m_ioctl+0x45/0x73 [amdgpu]<br></div><div dir=3D"ltr">[11137.665574]=C2=A0 v=
fs_ioctl+0x19/0x26<br></div><div dir=3D"ltr">[11137.667522]=C2=A0 do_vfs_io=
ctl+0x506/0x519<br></div><div dir=3D"ltr">[11137.669915]=C2=A0 ? __audit_sy=
scall_entry+0xba/0xde<br></div><div dir=3D"ltr">[11137.673114]=C2=A0 SyS_io=
ctl+0x4d/0x6f<br></div><div dir=3D"ltr">[11137.673116]=C2=A0 do_syscall_64+=
0x5c/0xe7<br></div><div dir=3D"ltr">[11137.673119]=C2=A0 entry_SYSCALL_64_a=
fter_hwframe+0x3d/0xa2<br></div><div dir=3D"ltr">[11137.673121] RIP: 0033:0=
x7f3af27290f7<br></div><div dir=3D"ltr">[11137.673122] RSP: 002b:0000000003=
26d8c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br></div><div dir=3D"ltr=
">[11137.673123] RAX: ffffffffffffffda RBX: 00007f39dafced10 RCX: 00007f3af=
27290f7<br></div><div dir=3D"ltr">[11137.673124] RDX: 000000000326d910 RSI:=
 00000000c0206440 RDI: 000000000000008a<br></div><div dir=3D"ltr">[11137.67=
3125] RBP: 000000000326d910 R08: 00007f39dafced10 R09: 0000000000000004<br>=
</div><div dir=3D"ltr">[11137.673126] R10: 00007f3a980008d0 R11: 0000000000=
000246 R12: 00000000c0206440<br></div><div dir=3D"ltr">[11137.673127] R13: =
000000000000008a R14: 000000000326d988 R15: 00007f39da014550<br></div><div =
dir=3D"ltr">[11192.494759] amdgpu 0000:02:00.0: swiotlb buffer is full (sz:=
 2097152 bytes)<br></div><div dir=3D"ltr">[11192.500420] amdgpu 0000:02:00.=
0: swiotlb: coherent allocation failed, size=3D2097152<br></div><div dir=3D=
"ltr">[11192.506805] CPU: 4 PID: 18225 Comm: Wow-64.exe Tainted: G=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 4.16.2 #1<br></div><div dir=3D"ltr">[11192.513173] Hardware name: Gigab=
yte Technology Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=C2=A0 05/04/2009<br><=
/div><div dir=3D"ltr">[11192.520919] Call Trace:<br></div><div dir=3D"ltr">=
[11192.522097]=C2=A0 dump_stack+0x46/0x59<br></div><div dir=3D"ltr">[11192.=
524145]=C2=A0 swiotlb_alloc_coherent+0x162/0x173<br></div><div dir=3D"ltr">=
[11192.527449]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]<br></div><div=
 dir=3D"ltr">[11192.531228]=C2=A0 ttm_dma_populate+0xfb/0x29c [ttm]<br></di=
v><div dir=3D"ltr">[11192.534451]=C2=A0 ttm_tt_bind+0x2d/0x52 [ttm]<br></di=
v><div dir=3D"ltr">[11192.537102]=C2=A0 ttm_bo_handle_move_mem+0x11a/0x323 =
[ttm]<br></div><div dir=3D"ltr">[11192.540924]=C2=A0 ? ttm_bo_mem_space+0x1=
4c/0x370 [ttm]<br></div><div dir=3D"ltr">[11192.544398]=C2=A0 ? enqueue_ent=
ity+0x504/0x653<br></div><div dir=3D"ltr">[11192.547103]=C2=A0 ttm_bo_valid=
ate+0x76/0xd4 [ttm]<br></div><div dir=3D"ltr">[11192.550103]=C2=A0 ? drm_vm=
a_offset_add+0x3b/0x4f [drm]<br></div><div dir=3D"ltr">[11192.553544]=C2=A0=
 ttm_bo_init_reserved+0x30b/0x3a3 [ttm]<br></div><div dir=3D"ltr">[11192.55=
7251]=C2=A0 amdgpu_bo_do_create+0x224/0x3be [amdgpu]<br></div><div dir=3D"l=
tr">[11192.561030]=C2=A0 ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]<br></div><div=
 dir=3D"ltr">[11192.564545]=C2=A0 amdgpu_bo_create+0x3e/0x181 [amdgpu]<br><=
/div><div dir=3D"ltr">[11192.568013]=C2=A0 amdgpu_gem_object_create+0x5c/0x=
d3 [amdgpu]<br></div><div dir=3D"ltr">[11192.572261]=C2=A0 amdgpu_gem_creat=
e_ioctl+0x138/0x1f6 [amdgpu]<br></div><div dir=3D"ltr">[11192.576433]=C2=A0=
 ? resched_curr+0x38/0x4f<br></div><div dir=3D"ltr">[11192.578837]=C2=A0 ? =
amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[111=
92.583162]=C2=A0 drm_ioctl_kernel+0x5f/0x9b [drm]<br></div><div dir=3D"ltr"=
>[11192.586325]=C2=A0 drm_ioctl+0x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr"=
>[11192.589040]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></d=
iv><div dir=3D"ltr">[11192.593312]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><=
div dir=3D"ltr">[11192.595709]=C2=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br=
></div><div dir=3D"ltr">[11192.599121]=C2=A0 vfs_ioctl+0x19/0x26<br></div><=
div dir=3D"ltr">[11192.601068]=C2=A0 do_vfs_ioctl+0x506/0x519<br></div><div=
 dir=3D"ltr">[11192.603437]=C2=A0 ? __audit_syscall_entry+0xba/0xde<br></di=
v><div dir=3D"ltr">[11192.606660]=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div d=
ir=3D"ltr">[11192.608635]=C2=A0 do_syscall_64+0x5c/0xe7<br></div><div dir=
=3D"ltr">[11192.610915]=C2=A0 entry_SYSCALL_64_after_hwframe+0x3d/0xa2<br><=
/div><div dir=3D"ltr">[11192.614710] RIP: 0033:0x7f3af27290f7<br></div><div=
 dir=3D"ltr">[11192.617094] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORI=
G_RAX: 0000000000000010<br></div><div dir=3D"ltr">[11192.623551] RAX: fffff=
fffffffffda RBX: 00007f39db63e090 RCX: 00007f3af27290f7<br></div><div dir=
=3D"ltr">[11192.629574] RDX: 000000000326d910 RSI: 00000000c0206440 RDI: 00=
0000000000008a<br></div><div dir=3D"ltr">[11192.635430] RBP: 000000000326d9=
10 R08: 00007f39db63e090 R09: 0000000000000004<br></div><div dir=3D"ltr">[1=
1192.641360] R10: 00007f3a980008d0 R11: 0000000000000246 R12: 00000000c0206=
440<br></div><div dir=3D"ltr">[11192.647277] R13: 000000000000008a R14: 000=
000000326d988 R15: 00007f39db83f490<br></div><div dir=3D"ltr">[11232.821909=
] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152 bytes)<br></div>=
<div dir=3D"ltr">[11232.827574] amdgpu 0000:02:00.0: swiotlb: coherent allo=
cation failed, size=3D2097152<br></div><div dir=3D"ltr">[11232.833873] CPU:=
 3 PID: 18225 Comm: Wow-64.exe Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1<br></div><d=
iv dir=3D"ltr">[11232.833874] Hardware name: Gigabyte Technology Co., Ltd. =
EX58-UD3R/EX58-UD3R, BIOS FB=C2=A0 05/04/2009<br></div><div dir=3D"ltr">[11=
232.833875] Call Trace:<br></div><div dir=3D"ltr">[11232.833882]=C2=A0 dump=
_stack+0x46/0x59<br></div><div dir=3D"ltr">[11232.833886]=C2=A0 swiotlb_all=
oc_coherent+0x162/0x173<br></div><div dir=3D"ltr">[11232.833891]=C2=A0 ttm_=
dma_pool_get_pages+0x170/0x3f7 [ttm]<br></div><div dir=3D"ltr">[11232.83389=
4]=C2=A0 ttm_dma_populate+0xfb/0x29c [ttm]<br></div><div dir=3D"ltr">[11232=
.833897]=C2=A0 ttm_tt_bind+0x2d/0x52 [ttm]<br></div><div dir=3D"ltr">[11232=
.833900]=C2=A0 ttm_bo_handle_move_mem+0x11a/0x323 [ttm]<br></div><div dir=
=3D"ltr">[11232.833903]=C2=A0 ? ttm_bo_mem_space+0x14c/0x370 [ttm]<br></div=
><div dir=3D"ltr">[11232.833906]=C2=A0 ttm_bo_validate+0x76/0xd4 [ttm]<br><=
/div><div dir=3D"ltr">[11232.833916]=C2=A0 ? drm_vma_offset_add+0x3b/0x4f [=
drm]<br></div><div dir=3D"ltr">[11232.833921]=C2=A0 ttm_bo_init_reserved+0x=
30b/0x3a3 [ttm]<br></div><div dir=3D"ltr">[11232.833956]=C2=A0 amdgpu_bo_do=
_create+0x224/0x3be [amdgpu]<br></div><div dir=3D"ltr">[11232.833971]=C2=A0=
 ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]<br></div><div dir=3D"ltr">[11232.8879=
66]=C2=A0 amdgpu_bo_create+0x3e/0x181 [amdgpu]<br></div><div dir=3D"ltr">[1=
1232.891381]=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]<br></div><di=
v dir=3D"ltr">[11232.895401]=C2=A0 amdgpu_gem_create_ioctl+0x138/0x1f6 [amd=
gpu]<br></div><div dir=3D"ltr">[11232.899498]=C2=A0 ? resched_curr+0x38/0x4=
f<br></div><div dir=3D"ltr">[11232.901876]=C2=A0 ? amdgpu_gem_object_close+=
0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[11232.906147]=C2=A0 drm_ioc=
tl_kernel+0x5f/0x9b [drm]<br></div><div dir=3D"ltr">[11232.909207]=C2=A0 dr=
m_ioctl+0x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr">[11232.911842]=C2=A0 ? =
amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[112=
32.916109]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div dir=3D"ltr">[11232.9=
18399]=C2=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></div><div dir=3D"ltr">=
[11232.921718]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div dir=3D"ltr">[11232.9=
23649]=C2=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=3D"ltr">[11232.9260=
18]=C2=A0 ? __audit_syscall_entry+0xba/0xde<br></div><div dir=3D"ltr">[1123=
2.929162]=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=3D"ltr">[11232.931095=
]=C2=A0 do_syscall_64+0x5c/0xe7<br></div><div dir=3D"ltr">[11232.933374]=C2=
=A0 entry_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div><div dir=3D"ltr">[112=
32.937124] RIP: 0033:0x7f3af27290f7<br></div><div dir=3D"ltr">[11232.939395=
] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br=
></div><div dir=3D"ltr">[11232.945660] RAX: ffffffffffffffda RBX: 00007f39d=
a05c8c0 RCX: 00007f3af27290f7<br></div><div dir=3D"ltr">[11232.951484] RDX:=
 000000000326d910 RSI: 00000000c0206440 RDI: 000000000000008a<br></div><div=
 dir=3D"ltr">[11232.957310] RBP: 000000000326d910 R08: 00007f39da05c8c0 R09=
: 0000000000000004<br></div><div dir=3D"ltr">[11232.963133] R10: 00007f3a98=
0008d0 R11: 0000000000000246 R12: 00000000c0206440<br></div><div dir=3D"ltr=
">[11232.968957] R13: 000000000000008a R14: 000000000326d988 R15: 00007f39d=
b729280<br></div><div dir=3D"ltr">[11248.940341] amdgpu 0000:02:00.0: swiot=
lb buffer is full (sz: 2097152 bytes)<br></div><div dir=3D"ltr">[11248.9460=
35] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed, size=3D209715=
2<br></div><div dir=3D"ltr">[11248.952305] CPU: 5 PID: 18225 Comm: Wow-64.e=
xe Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1<br></div><div dir=3D"ltr">[11248.958663]=
 Hardware name: Gigabyte Technology Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=
=C2=A0 05/04/2009<br></div><div dir=3D"ltr">[11248.966222] Call Trace:<br><=
/div><div dir=3D"ltr">[11248.966229]=C2=A0 dump_stack+0x46/0x59<br></div><d=
iv dir=3D"ltr">[11248.966233]=C2=A0 swiotlb_alloc_coherent+0x162/0x173<br><=
/div><div dir=3D"ltr">[11248.966239]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3=
f7 [ttm]<br></div><div dir=3D"ltr">[11248.966243]=C2=A0 ttm_dma_populate+0x=
fb/0x29c [ttm]<br></div><div dir=3D"ltr">[11248.966247]=C2=A0 ttm_tt_bind+0=
x2d/0x52 [ttm]<br></div><div dir=3D"ltr">[11248.966250]=C2=A0 ttm_bo_handle=
_move_mem+0x11a/0x323 [ttm]<br></div><div dir=3D"ltr">[11248.966254]=C2=A0 =
? ttm_bo_mem_space+0x14c/0x370 [ttm]<br></div><div dir=3D"ltr">[11248.96626=
5]=C2=A0 ? add_hole+0x3b/0xe6 [drm]<br></div><div dir=3D"ltr">[11248.966269=
]=C2=A0 ttm_bo_validate+0x76/0xd4 [ttm]<br></div><div dir=3D"ltr">[11248.96=
6278]=C2=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<br></div><div dir=3D"ltr">=
[11248.966281]=C2=A0 ttm_bo_init_reserved+0x30b/0x3a3 [ttm]<br></div><div d=
ir=3D"ltr">[11248.966317]=C2=A0 amdgpu_bo_do_create+0x224/0x3be [amdgpu]<br=
></div><div dir=3D"ltr">[11248.966335]=C2=A0 ? amdgpu_bo_unref+0x2f/0x2f [a=
mdgpu]<br></div><div dir=3D"ltr">[11249.009235]=C2=A0 amdgpu_bo_create+0x3e=
/0x181 [amdgpu]<br></div><div dir=3D"ltr">[11249.009254]=C2=A0 amdgpu_gem_o=
bject_create+0x5c/0xd3 [amdgpu]<br></div><div dir=3D"ltr">[11249.016664]=C2=
=A0 amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<br></div><div dir=3D"ltr">=
[11249.016667]=C2=A0 ? resched_curr+0x38/0x4f<br></div><div dir=3D"ltr">[11=
249.016685]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></div><=
div dir=3D"ltr">[11249.016692]=C2=A0 drm_ioctl_kernel+0x5f/0x9b [drm]<br></=
div><div dir=3D"ltr">[11249.030509]=C2=A0 drm_ioctl+0x1ef/0x2d5 [drm]<br></=
div><div dir=3D"ltr">[11249.030529]=C2=A0 ? amdgpu_gem_object_close+0x19f/0=
x19f [amdgpu]<br></div><div dir=3D"ltr">[11249.030531]=C2=A0 ? rpm_resume+0=
x89/0x3cb<br></div><div dir=3D"ltr">[11249.030546]=C2=A0 amdgpu_drm_ioctl+0=
x45/0x73 [amdgpu]<br></div><div dir=3D"ltr">[11249.030549]=C2=A0 vfs_ioctl+=
0x19/0x26<br></div><div dir=3D"ltr">[11249.044992]=C2=A0 do_vfs_ioctl+0x506=
/0x519<br></div><div dir=3D"ltr">[11249.047412]=C2=A0 ? __audit_syscall_ent=
ry+0xba/0xde<br></div><div dir=3D"ltr">[11249.050556]=C2=A0 SyS_ioctl+0x4d/=
0x6f<br></div><div dir=3D"ltr">[11249.052499]=C2=A0 do_syscall_64+0x5c/0xe7=
<br></div><div dir=3D"ltr">[11249.054791]=C2=A0 entry_SYSCALL_64_after_hwfr=
ame+0x3d/0xa2<br></div><div dir=3D"ltr">[11249.058573] RIP: 0033:0x7f3af272=
90f7<br></div><div dir=3D"ltr">[11249.060843] RSP: 002b:000000000326d8c8 EF=
LAGS: 00000246 ORIG_RAX: 0000000000000010<br></div><div dir=3D"ltr">[11249.=
067160] RAX: ffffffffffffffda RBX: 00007f39db49e780 RCX: 00007f3af27290f7<b=
r></div><div dir=3D"ltr">[11249.073011] RDX: 000000000326d910 RSI: 00000000=
c0206440 RDI: 000000000000008a<br></div><div dir=3D"ltr">[11249.078836] RBP=
: 000000000326d910 R08: 00007f39db49e780 R09: 0000000000000004<br></div><di=
v dir=3D"ltr">[11249.084702] R10: 00007f3a980008d0 R11: 0000000000000246 R1=
2: 00000000c0206440<br></div><div dir=3D"ltr">[11249.090560] R13: 000000000=
000008a R14: 000000000326d988 R15: 00007f39dafe1590<br></div><div dir=3D"lt=
r">[11263.728451] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152 =
bytes)<br></div><div dir=3D"ltr">[11263.734145] amdgpu 0000:02:00.0: swiotl=
b: coherent allocation failed, size=3D2097152<br></div><div dir=3D"ltr">[11=
263.740427] CPU: 1 PID: 18225 Comm: Wow-64.exe Tainted: G=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2=
 #1<br></div><div dir=3D"ltr">[11263.746776] Hardware name: Gigabyte Techno=
logy Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=C2=A0 05/04/2009<br></div><div =
dir=3D"ltr">[11263.754335] Call Trace:<br></div><div dir=3D"ltr">[11263.755=
483]=C2=A0 dump_stack+0x46/0x59<br></div><div dir=3D"ltr">[11263.757500]=C2=
=A0 swiotlb_alloc_coherent+0x162/0x173<br></div><div dir=3D"ltr">[11263.760=
734]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]<br></div><div dir=3D"lt=
r">[11263.764485]=C2=A0 ttm_dma_populate+0xfb/0x29c [ttm]<br></div><div dir=
=3D"ltr">[11263.767632]=C2=A0 ttm_tt_bind+0x2d/0x52 [ttm]<br></div><div dir=
=3D"ltr">[11263.770260]=C2=A0 ttm_bo_handle_move_mem+0x11a/0x323 [ttm]<br><=
/div><div dir=3D"ltr">[11263.770264]=C2=A0 ? ttm_bo_mem_space+0x14c/0x370 [=
ttm]<br></div><div dir=3D"ltr">[11263.770266]=C2=A0 ttm_bo_validate+0x76/0x=
d4 [ttm]<br></div><div dir=3D"ltr">[11263.770277]=C2=A0 ? drm_vma_offset_ad=
d+0x3b/0x4f [drm]<br></div><div dir=3D"ltr">[11263.770280]=C2=A0 ttm_bo_ini=
t_reserved+0x30b/0x3a3 [ttm]<br></div><div dir=3D"ltr">[11263.770309]=C2=A0=
 amdgpu_bo_do_create+0x224/0x3be [amdgpu]<br></div><div dir=3D"ltr">[11263.=
770324]=C2=A0 ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]<br></div><div dir=3D"ltr=
">[11263.794545]=C2=A0 amdgpu_bo_create+0x3e/0x181 [amdgpu]<br></div><div d=
ir=3D"ltr">[11263.797961]=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]=
<br></div><div dir=3D"ltr">[11263.801982]=C2=A0 amdgpu_gem_create_ioctl+0x1=
38/0x1f6 [amdgpu]<br></div><div dir=3D"ltr">[11263.806076]=C2=A0 ? resched_=
curr+0x38/0x4f<br></div><div dir=3D"ltr">[11263.808455]=C2=A0 ? amdgpu_gem_=
object_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[11263.812727]=
=C2=A0 drm_ioctl_kernel+0x5f/0x9b [drm]<br></div><div dir=3D"ltr">[11263.81=
5787]=C2=A0 drm_ioctl+0x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr">[11263.81=
8427]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div di=
r=3D"ltr">[11263.822699]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div dir=3D=
"ltr">[11263.824994]=C2=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></div><di=
v dir=3D"ltr">[11263.824997]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div dir=3D=
"ltr">[11263.830230]=C2=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=3D"lt=
r">[11263.832598]=C2=A0 ? __audit_syscall_entry+0xba/0xde<br></div><div dir=
=3D"ltr">[11263.835741]=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=3D"ltr"=
>[11263.837665]=C2=A0 do_syscall_64+0x5c/0xe7<br></div><div dir=3D"ltr">[11=
263.839937]=C2=A0 entry_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div><div di=
r=3D"ltr">[11263.843688] RIP: 0033:0x7f3af27290f7<br></div><div dir=3D"ltr"=
>[11263.845957] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010<br></div><div dir=3D"ltr">[11263.852215] RAX: ffffffffffffffda =
RBX: 00007f39db7e9920 RCX: 00007f3af27290f7<br></div><div dir=3D"ltr">[1126=
3.858040] RDX: 000000000326d910 RSI: 00000000c0206440 RDI: 000000000000008a=
<br></div><div dir=3D"ltr">[11263.863863] RBP: 000000000326d910 R08: 00007f=
39db7e9920 R09: 0000000000000004<br></div><div dir=3D"ltr">[11263.869689] R=
10: 00007f3a980008d0 R11: 0000000000000246 R12: 00000000c0206440<br></div><=
div dir=3D"ltr">[11263.875563] R13: 000000000000008a R14: 000000000326d988 =
R15: 00007f39db8064c0<br></div><div dir=3D"ltr">[11308.013166] amdgpu 0000:=
02:00.0: swiotlb buffer is full (sz: 2097152 bytes)<br></div><div dir=3D"lt=
r">[11308.018904] amdgpu 0000:02:00.0: swiotlb: coherent allocation failed,=
 size=3D2097152<br></div><div dir=3D"ltr">[11308.025240] CPU: 2 PID: 18225 =
Comm: Wow-64.exe Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1<br></div><div dir=3D"ltr">=
[11308.031653] Hardware name: Gigabyte Technology Co., Ltd. EX58-UD3R/EX58-=
UD3R, BIOS FB=C2=A0 05/04/2009<br></div><div dir=3D"ltr">[11308.039467] Cal=
l Trace:<br></div><div dir=3D"ltr">[11308.040619]=C2=A0 dump_stack+0x46/0x5=
9<br></div><div dir=3D"ltr">[11308.042669]=C2=A0 swiotlb_alloc_coherent+0x1=
62/0x173<br></div><div dir=3D"ltr">[11308.045922]=C2=A0 ttm_dma_pool_get_pa=
ges+0x170/0x3f7 [ttm]<br></div><div dir=3D"ltr">[11308.049770]=C2=A0 ttm_dm=
a_populate+0xfb/0x29c [ttm]<br></div><div dir=3D"ltr">[11308.052983]=C2=A0 =
ttm_tt_bind+0x2d/0x52 [ttm]<br></div><div dir=3D"ltr">[11308.055619]=C2=A0 =
ttm_bo_handle_move_mem+0x11a/0x323 [ttm]<br></div><div dir=3D"ltr">[11308.0=
59396]=C2=A0 ? ttm_bo_mem_space+0x14c/0x370 [ttm]<br></div><div dir=3D"ltr"=
>[11308.062829]=C2=A0 ? get_nohz_timer_target+0x16/0xe5<br></div><div dir=
=3D"ltr">[11308.066001]=C2=A0 ttm_bo_validate+0x76/0xd4 [ttm]<br></div><div=
 dir=3D"ltr">[11308.069059]=C2=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<br><=
/div><div dir=3D"ltr">[11308.072582]=C2=A0 ttm_bo_init_reserved+0x30b/0x3a3=
 [ttm]<br></div><div dir=3D"ltr">[11308.072615]=C2=A0 amdgpu_bo_do_create+0=
x224/0x3be [amdgpu]<br></div><div dir=3D"ltr">[11308.079951]=C2=A0 ? amdgpu=
_bo_unref+0x2f/0x2f [amdgpu]<br></div><div dir=3D"ltr">[11308.083363]=C2=A0=
 amdgpu_bo_create+0x3e/0x181 [amdgpu]<br></div><div dir=3D"ltr">[11308.0867=
79]=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]<br></div><div dir=3D"=
ltr">[11308.090802]=C2=A0 amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<br><=
/div><div dir=3D"ltr">[11308.094894]=C2=A0 ? resched_curr+0x38/0x4f<br></di=
v><div dir=3D"ltr">[11308.097263]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x1=
9f [amdgpu]<br></div><div dir=3D"ltr">[11308.101539]=C2=A0 drm_ioctl_kernel=
+0x5f/0x9b [drm]<br></div><div dir=3D"ltr">[11308.104607]=C2=A0 drm_ioctl+0=
x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr">[11308.107251]=C2=A0 ? amdgpu_ge=
m_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[11308.111518=
]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div dir=3D"ltr">[11308.113807]=C2=
=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></div><div dir=3D"ltr">[11308.11=
7124]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div dir=3D"ltr">[11308.119048]=C2=
=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=3D"ltr">[11308.121408]=C2=A0=
 ? __audit_syscall_entry+0xba/0xde<br></div><div dir=3D"ltr">[11308.124551]=
=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=3D"ltr">[11308.126474]=C2=A0 d=
o_syscall_64+0x5c/0xe7<br></div><div dir=3D"ltr">[11308.128748]=C2=A0 entry=
_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div><div dir=3D"ltr">[11308.132570=
] RIP: 0033:0x7f3af27290f7<br></div><div dir=3D"ltr">[11308.134847] RSP: 00=
2b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br></div><d=
iv dir=3D"ltr">[11308.141103] RAX: ffffffffffffffda RBX: 00007f39db2a2480 R=
CX: 00007f3af27290f7<br></div><div dir=3D"ltr">[11308.146926] RDX: 00000000=
0326d910 RSI: 00000000c0206440 RDI: 000000000000008a<br></div><div dir=3D"l=
tr">[11308.152787] RBP: 000000000326d910 R08: 00007f39db2a2480 R09: 0000000=
000000004<br></div><div dir=3D"ltr">[11308.158698] R10: 00007f3a980008d0 R1=
1: 0000000000000246 R12: 00000000c0206440<br></div><div dir=3D"ltr">[11308.=
164564] R13: 000000000000008a R14: 000000000326d988 R15: 00007f39db7abc30<b=
r></div><div dir=3D"ltr">[11338.907546] amdgpu 0000:02:00.0: swiotlb buffer=
 is full (sz: 2097152 bytes)<br></div><div dir=3D"ltr">[11338.913752] amdgp=
u 0000:02:00.0: swiotlb: coherent allocation failed, size=3D2097152<br></di=
v><div dir=3D"ltr">[11338.920445] CPU: 7 PID: 18225 Comm: Wow-64.exe Tainte=
d: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 4.16.2 #1<br></div><div dir=3D"ltr">[11338.926907] Hardware=
 name: Gigabyte Technology Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=C2=A0 05/=
04/2009<br></div><div dir=3D"ltr">[11338.926908] Call Trace:<br></div><div =
dir=3D"ltr">[11338.926915]=C2=A0 dump_stack+0x46/0x59<br></div><div dir=3D"=
ltr">[11338.926919]=C2=A0 swiotlb_alloc_coherent+0x162/0x173<br></div><div =
dir=3D"ltr">[11338.926923]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]<b=
r></div><div dir=3D"ltr">[11338.926927]=C2=A0 ttm_dma_populate+0xfb/0x29c [=
ttm]<br></div><div dir=3D"ltr">[11338.926930]=C2=A0 ttm_tt_bind+0x2d/0x52 [=
ttm]<br></div><div dir=3D"ltr">[11338.926932]=C2=A0 ttm_bo_handle_move_mem+=
0x11a/0x323 [ttm]<br></div><div dir=3D"ltr">[11338.926936]=C2=A0 ? ttm_bo_m=
em_space+0x14c/0x370 [ttm]<br></div><div dir=3D"ltr">[11338.926938]=C2=A0 ?=
 enqueue_entity+0x504/0x653<br></div><div dir=3D"ltr">[11338.926941]=C2=A0 =
ttm_bo_validate+0x76/0xd4 [ttm]<br></div><div dir=3D"ltr">[11338.926952]=C2=
=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<br></div><div dir=3D"ltr">[11338.9=
26955]=C2=A0 ttm_bo_init_reserved+0x30b/0x3a3 [ttm]<br></div><div dir=3D"lt=
r">[11338.970788]=C2=A0 amdgpu_bo_do_create+0x224/0x3be [amdgpu]<br></div><=
div dir=3D"ltr">[11338.970803]=C2=A0 ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]<b=
r></div><div dir=3D"ltr">[11338.970817]=C2=A0 amdgpu_bo_create+0x3e/0x181 [=
amdgpu]<br></div><div dir=3D"ltr">[11338.981567]=C2=A0 amdgpu_gem_object_cr=
eate+0x5c/0xd3 [amdgpu]<br></div><div dir=3D"ltr">[11338.981583]=C2=A0 amdg=
pu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<br></div><div dir=3D"ltr">[11338.9=
81586]=C2=A0 ? resched_curr+0x38/0x4f<br></div><div dir=3D"ltr">[11338.9816=
01]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=
=3D"ltr">[11338.981606]=C2=A0 drm_ioctl_kernel+0x5f/0x9b [drm]<br></div><di=
v dir=3D"ltr">[11338.999670]=C2=A0 drm_ioctl+0x1ef/0x2d5 [drm]<br></div><di=
v dir=3D"ltr">[11338.999686]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [a=
mdgpu]<br></div><div dir=3D"ltr">[11338.999688]=C2=A0 ? rpm_resume+0x89/0x3=
cb<br></div><div dir=3D"ltr">[11338.999700]=C2=A0 amdgpu_drm_ioctl+0x45/0x7=
3 [amdgpu]<br></div><div dir=3D"ltr">[11338.999703]=C2=A0 vfs_ioctl+0x19/0x=
26<br></div><div dir=3D"ltr">[11338.999704]=C2=A0 do_vfs_ioctl+0x506/0x519<=
br></div><div dir=3D"ltr">[11338.999707]=C2=A0 ? __audit_syscall_entry+0xba=
/0xde<br></div><div dir=3D"ltr">[11338.999709]=C2=A0 SyS_ioctl+0x4d/0x6f<br=
></div><div dir=3D"ltr">[11338.999711]=C2=A0 do_syscall_64+0x5c/0xe7<br></d=
iv><div dir=3D"ltr">[11338.999714]=C2=A0 entry_SYSCALL_64_after_hwframe+0x3=
d/0xa2<br></div><div dir=3D"ltr">[11338.999716] RIP: 0033:0x7f3af27290f7<br=
></div><div dir=3D"ltr">[11338.999716] RSP: 002b:000000000326d8c8 EFLAGS: 0=
0000246 ORIG_RAX: 0000000000000010<br></div><div dir=3D"ltr">[11338.999718]=
 RAX: ffffffffffffffda RBX: 00007f39db84e9b0 RCX: 00007f3af27290f7<br></div=
><div dir=3D"ltr">[11338.999719] RDX: 000000000326d910 RSI: 00000000c020644=
0 RDI: 000000000000008a<br></div><div dir=3D"ltr">[11338.999720] RBP: 00000=
0000326d910 R08: 00007f39db84e9b0 R09: 0000000000000004<br></div><div dir=
=3D"ltr">[11338.999721] R10: 00007f3a980008d0 R11: 0000000000000246 R12: 00=
000000c0206440<br></div><div dir=3D"ltr">[11338.999722] R13: 00000000000000=
8a R14: 000000000326d988 R15: 00007f39db726860<br></div><div dir=3D"ltr">[1=
1426.178446] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152 bytes=
)<br></div><div dir=3D"ltr">[11426.184371] amdgpu 0000:02:00.0: swiotlb: co=
herent allocation failed, size=3D2097152<br></div><div dir=3D"ltr">[11426.1=
90645] CPU: 5 PID: 18225 Comm: Wow-64.exe Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1=
<br></div><div dir=3D"ltr">[11426.196994] Hardware name: Gigabyte Technolog=
y Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=C2=A0 05/04/2009<br></div><div dir=
=3D"ltr">[11426.196995] Call Trace:<br></div><div dir=3D"ltr">[11426.197002=
]=C2=A0 dump_stack+0x46/0x59<br></div><div dir=3D"ltr">[11426.197006]=C2=A0=
 swiotlb_alloc_coherent+0x162/0x173<br></div><div dir=3D"ltr">[11426.197011=
]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]<br></div><div dir=3D"ltr">=
[11426.197014]=C2=A0 ttm_dma_populate+0xfb/0x29c [ttm]<br></div><div dir=3D=
"ltr">[11426.197017]=C2=A0 ttm_tt_bind+0x2d/0x52 [ttm]<br></div><div dir=3D=
"ltr">[11426.197020]=C2=A0 ttm_bo_handle_move_mem+0x11a/0x323 [ttm]<br></di=
v><div dir=3D"ltr">[11426.197023]=C2=A0 ? ttm_bo_mem_space+0x14c/0x370 [ttm=
]<br></div><div dir=3D"ltr">[11426.227598]=C2=A0 ? enqueue_entity+0x504/0x6=
53<br></div><div dir=3D"ltr">[11426.230310]=C2=A0 ttm_bo_validate+0x76/0xd4=
 [ttm]<br></div><div dir=3D"ltr">[11426.233326]=C2=A0 ? drm_vma_offset_add+=
0x3b/0x4f [drm]<br></div><div dir=3D"ltr">[11426.233329]=C2=A0 ttm_bo_init_=
reserved+0x30b/0x3a3 [ttm]<br></div><div dir=3D"ltr">[11426.233360]=C2=A0 a=
mdgpu_bo_do_create+0x224/0x3be [amdgpu]<br></div><div dir=3D"ltr">[11426.23=
3375]=C2=A0 ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]<br></div><div dir=3D"ltr">=
[11426.233389]=C2=A0 amdgpu_bo_create+0x3e/0x181 [amdgpu]<br></div><div dir=
=3D"ltr">[11426.233405]=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]<b=
r></div><div dir=3D"ltr">[11426.254924]=C2=A0 amdgpu_gem_create_ioctl+0x138=
/0x1f6 [amdgpu]<br></div><div dir=3D"ltr">[11426.254928]=C2=A0 ? resched_cu=
rr+0x38/0x4f<br></div><div dir=3D"ltr">[11426.254942]=C2=A0 ? amdgpu_gem_ob=
ject_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[11426.254948]=C2=
=A0 drm_ioctl_kernel+0x5f/0x9b [drm]<br></div><div dir=3D"ltr">[11426.25495=
4]=C2=A0 drm_ioctl+0x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr">[11426.27135=
4]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=
=3D"ltr">[11426.271356]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div dir=3D"=
ltr">[11426.271369]=C2=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></div><div=
 dir=3D"ltr">[11426.271372]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div dir=3D"=
ltr">[11426.271373]=C2=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=3D"ltr=
">[11426.271376]=C2=A0 ? __audit_syscall_entry+0xba/0xde<br></div><div dir=
=3D"ltr">[11426.271378]=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=3D"ltr"=
>[11426.290597]=C2=A0 do_syscall_64+0x5c/0xe7<br></div><div dir=3D"ltr">[11=
426.290601]=C2=A0 entry_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div><div di=
r=3D"ltr">[11426.290603] RIP: 0033:0x7f3af27290f7<br></div><div dir=3D"ltr"=
>[11426.298896] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010<br></div><div dir=3D"ltr">[11426.298898] RAX: ffffffffffffffda =
RBX: 00007f39db847830 RCX: 00007f3af27290f7<br></div><div dir=3D"ltr">[1142=
6.298899] RDX: 000000000326d910 RSI: 00000000c0206440 RDI: 000000000000008a=
<br></div><div dir=3D"ltr">[11426.298900] RBP: 000000000326d910 R08: 00007f=
39db847830 R09: 0000000000000004<br></div><div dir=3D"ltr">[11426.298900] R=
10: 00007f3a980008d0 R11: 0000000000000246 R12: 00000000c0206440<br></div><=
div dir=3D"ltr">[11426.298901] R13: 000000000000008a R14: 000000000326d988 =
R15: 00007f39d9a586f0<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">=
[11541.794623] amdgpu 0000:02:00.0: swiotlb buffer is full (sz: 2097152 byt=
es)<br></div><div dir=3D"ltr">[11541.800674] amdgpu 0000:02:00.0: swiotlb: =
coherent allocation failed, size=3D2097152<br></div><div dir=3D"ltr">[11541=
.806960] CPU: 7 PID: 18225 Comm: Wow-64.exe Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1=
<br></div><div dir=3D"ltr">[11541.813304] Hardware name: Gigabyte Technolog=
y Co., Ltd. EX58-UD3R/EX58-UD3R, BIOS FB=C2=A0 05/04/2009<br></div><div dir=
=3D"ltr">[11541.813306] Call Trace:<br></div><div dir=3D"ltr">[11541.813313=
]=C2=A0 dump_stack+0x46/0x59<br></div><div dir=3D"ltr">[11541.824047]=C2=A0=
 swiotlb_alloc_coherent+0x162/0x173<br></div><div dir=3D"ltr">[11541.827278=
]=C2=A0 ttm_dma_pool_get_pages+0x170/0x3f7 [ttm]<br></div><div dir=3D"ltr">=
[11541.831028]=C2=A0 ttm_dma_populate+0xfb/0x29c [ttm]<br></div><div dir=3D=
"ltr">[11541.834166]=C2=A0 ttm_tt_bind+0x2d/0x52 [ttm]<br></div><div dir=3D=
"ltr">[11541.836784]=C2=A0 ttm_bo_handle_move_mem+0x11a/0x323 [ttm]<br></di=
v><div dir=3D"ltr">[11541.840537]=C2=A0 ? ttm_bo_mem_space+0x14c/0x370 [ttm=
]<br></div><div dir=3D"ltr">[11541.843943]=C2=A0 ttm_bo_validate+0x76/0xd4 =
[ttm]<br></div><div dir=3D"ltr">[11541.846967]=C2=A0 ? drm_vma_offset_add+0=
x3b/0x4f [drm]<br></div><div dir=3D"ltr">[11541.850363]=C2=A0 ttm_bo_init_r=
eserved+0x30b/0x3a3 [ttm]<br></div><div dir=3D"ltr">[11541.853968]=C2=A0 am=
dgpu_bo_do_create+0x224/0x3be [amdgpu]<br></div><div dir=3D"ltr">[11541.857=
726]=C2=A0 ? amdgpu_bo_unref+0x2f/0x2f [amdgpu]<br></div><div dir=3D"ltr">[=
11541.861140]=C2=A0 amdgpu_bo_create+0x3e/0x181 [amdgpu]<br></div><div dir=
=3D"ltr">[11541.864554]=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]<b=
r></div><div dir=3D"ltr">[11541.868576]=C2=A0 amdgpu_gem_create_ioctl+0x138=
/0x1f6 [amdgpu]<br></div><div dir=3D"ltr">[11541.872672]=C2=A0 ? preempt_co=
unt_add+0x75/0x87<br></div><div dir=3D"ltr">[11541.875474]=C2=A0 ? amdgpu_g=
em_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[11541.87975=
0]=C2=A0 drm_ioctl_kernel+0x5f/0x9b [drm]<br></div><div dir=3D"ltr">[11541.=
882811]=C2=A0 drm_ioctl+0x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr">[11541.=
882831]=C2=A0 ? amdgpu_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div =
dir=3D"ltr">[11541.889696]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div dir=
=3D"ltr">[11541.889715]=C2=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></div>=
<div dir=3D"ltr">[11541.895284]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div dir=
=3D"ltr">[11541.897217]=C2=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=3D=
"ltr">[11541.899582]=C2=A0 ? __audit_syscall_entry+0xba/0xde<br></div><div =
dir=3D"ltr">[11541.902726]=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=3D"l=
tr">[11541.904654]=C2=A0 do_syscall_64+0x5c/0xe7<br></div><div dir=3D"ltr">=
[11541.904658]=C2=A0 entry_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div><div=
 dir=3D"ltr">[11541.910674] RIP: 0033:0x7f3af27290f7<br></div><div dir=3D"l=
tr">[11541.912946] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010<br></div><div dir=3D"ltr">[11541.912949] RAX: ffffffffffffff=
da RBX: 00007f39db63a6e0 RCX: 00007f3af27290f7<br></div><div dir=3D"ltr">[1=
1541.925037] RDX: 000000000326d910 RSI: 00000000c0206440 RDI: 0000000000000=
08a<br></div><div dir=3D"ltr">[11541.925039] RBP: 000000000326d910 R08: 000=
07f39db63a6e0 R09: 0000000000000004<br></div><div dir=3D"ltr">[11541.925040=
] R10: 00007f3a980008d0 R11: 0000000000000246 R12: 00000000c0206440<br></di=
v><div dir=3D"ltr">[11541.942517] R13: 000000000000008a R14: 000000000326d9=
88 R15: 00007f39db5bb1a0<br></div><div dir=3D"ltr">[11557.395216] amdgpu 00=
00:02:00.0: swiotlb buffer is full (sz: 2097152 bytes)<br></div><div dir=3D=
"ltr">[11557.400974] amdgpu 0000:02:00.0: swiotlb: coherent allocation fail=
ed, size=3D2097152<br></div><div dir=3D"ltr">[11557.407488] CPU: 4 PID: 182=
25 Comm: Wow-64.exe Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.16.2 #1<br></div><div dir=3D"lt=
r">[11557.413873] Hardware name: Gigabyte Technology Co., Ltd. EX58-UD3R/EX=
58-UD3R, BIOS FB=C2=A0 05/04/2009<br></div><div dir=3D"ltr">[11557.413875] =
Call Trace:<br></div><div dir=3D"ltr">[11557.422614]=C2=A0 dump_stack+0x46/=
0x59<br></div><div dir=3D"ltr">[11557.424698]=C2=A0 swiotlb_alloc_coherent+=
0x162/0x173<br></div><div dir=3D"ltr">[11557.427960]=C2=A0 ttm_dma_pool_get=
_pages+0x170/0x3f7 [ttm]<br></div><div dir=3D"ltr">[11557.431738]=C2=A0 ttm=
_dma_populate+0xfb/0x29c [ttm]<br></div><div dir=3D"ltr">[11557.434917]=C2=
=A0 ttm_tt_bind+0x2d/0x52 [ttm]<br></div><div dir=3D"ltr">[11557.434920]=C2=
=A0 ttm_bo_handle_move_mem+0x11a/0x323 [ttm]<br></div><div dir=3D"ltr">[115=
57.434923]=C2=A0 ? ttm_bo_mem_space+0x14c/0x370 [ttm]<br></div><div dir=3D"=
ltr">[11557.434927]=C2=A0 ? get_nohz_timer_target+0x16/0xe5<br></div><div d=
ir=3D"ltr">[11557.434929]=C2=A0 ttm_bo_validate+0x76/0xd4 [ttm]<br></div><d=
iv dir=3D"ltr">[11557.434939]=C2=A0 ? drm_vma_offset_add+0x3b/0x4f [drm]<br=
></div><div dir=3D"ltr">[11557.434941]=C2=A0 ttm_bo_init_reserved+0x30b/0x3=
a3 [ttm]<br></div><div dir=3D"ltr">[11557.434972]=C2=A0 amdgpu_bo_do_create=
+0x224/0x3be [amdgpu]<br></div><div dir=3D"ltr">[11557.434987]=C2=A0 ? amdg=
pu_bo_unref+0x2f/0x2f [amdgpu]<br></div><div dir=3D"ltr">[11557.465325]=C2=
=A0 amdgpu_bo_create+0x3e/0x181 [amdgpu]<br></div><div dir=3D"ltr">[11557.4=
65340]=C2=A0 amdgpu_gem_object_create+0x5c/0xd3 [amdgpu]<br></div><div dir=
=3D"ltr">[11557.465356]=C2=A0 amdgpu_gem_create_ioctl+0x138/0x1f6 [amdgpu]<=
br></div><div dir=3D"ltr">[11557.465359]=C2=A0 ? resched_curr+0x38/0x4f<br>=
</div><div dir=3D"ltr">[11557.465373]=C2=A0 ? amdgpu_gem_object_close+0x19f=
/0x19f [amdgpu]<br></div><div dir=3D"ltr">[11557.465378]=C2=A0 drm_ioctl_ke=
rnel+0x5f/0x9b [drm]<br></div><div dir=3D"ltr">[11557.465385]=C2=A0 drm_ioc=
tl+0x1ef/0x2d5 [drm]<br></div><div dir=3D"ltr">[11557.489498]=C2=A0 ? amdgp=
u_gem_object_close+0x19f/0x19f [amdgpu]<br></div><div dir=3D"ltr">[11557.48=
9501]=C2=A0 ? rpm_resume+0x89/0x3cb<br></div><div dir=3D"ltr">[11557.489513=
]=C2=A0 amdgpu_drm_ioctl+0x45/0x73 [amdgpu]<br></div><div dir=3D"ltr">[1155=
7.489516]=C2=A0 vfs_ioctl+0x19/0x26<br></div><div dir=3D"ltr">[11557.489518=
]=C2=A0 do_vfs_ioctl+0x506/0x519<br></div><div dir=3D"ltr">[11557.489521]=
=C2=A0 ? __audit_syscall_entry+0xba/0xde<br></div><div dir=3D"ltr">[11557.4=
89522]=C2=A0 SyS_ioctl+0x4d/0x6f<br></div><div dir=3D"ltr">[11557.489524]=
=C2=A0 do_syscall_64+0x5c/0xe7<br></div><div dir=3D"ltr">[11557.489527]=C2=
=A0 entry_SYSCALL_64_after_hwframe+0x3d/0xa2<br></div><div dir=3D"ltr">[115=
57.489529] RIP: 0033:0x7f3af27290f7<br></div><div dir=3D"ltr">[11557.489530=
] RSP: 002b:000000000326d8c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br=
></div><div dir=3D"ltr">[11557.489531] RAX: ffffffffffffffda RBX: 00007f39d=
b8efae0 RCX: 00007f3af27290f7<br></div><div dir=3D"ltr">[11557.489532] RDX:=
 000000000326d910 RSI: 00000000c0206440 RDI: 000000000000008a<br></div><div=
 dir=3D"ltr">[11557.489533] RBP: 000000000326d910 R08: 00007f39db8efae0 R09=
: 0000000000000004<br></div><div dir=3D"ltr">[11557.489534] R10: 00007f3a98=
0008d0 R11: 0000000000000246 R12: 00000000c0206440<br></div><div dir=3D"ltr=
">[11557.489534] R13: 000000000000008a R14: 000000000326d988 R15: 00007f39d=
b55a6a0</div></div></div></div><br></div>

--000000000000853684056a6eb412--

--===============0463940537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0463940537==--

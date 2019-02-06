From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: BUG - unable to handle null pointer,
 bisected - drm/amd/display: add gpio lock/unlock
Date: Wed, 06 Feb 2019 10:48:05 +0100
Message-ID: <10341067.RRd0raRtKH@eclipse>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1156354077=="
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Chiawen Huang <chiawen.huang-5C7GfCeVMHo@public.gmane.org>
Cc: Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>

--===============1156354077==
Content-Type: multipart/signed; boundary="nextPart3073571.X7BTedMSLo"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3073571.X7BTedMSLo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Good morning,

on my Lenovo G50-45 a6310 APU with R4 Mullins commit 
e261568f94d6c37ebb94d3c4b3f8a3085375dd9d is causing kernel Oops (unable to 
handle NULL pointer).
Cross-checked by reverting troublesome commit and machine without it is 
working fine.

Here is a part of the Oops message from pstore:


<1>[   13.200310] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000008
<1>[   13.200323] #PF error: [normal kernel read fault]
<6>[   13.200328] PGD 0 P4D 0 
<4>[   13.200335] Oops: 0000 [#1] PREEMPT SMP
<4>[   13.200342] CPU: 2 PID: 2961 Comm: udevd Not tainted 5.0.0-rc1+ #47
<4>[   13.200347] Hardware name: LENOVO 80E3/Lancer 5B2, BIOS A2CN45WW(V2.13) 
08/04/2016
<4>[   13.200450] RIP: 0010:dal_gpio_open_ex+0x0/0x30 [amdgpu]
<4>[   13.200456] Code: d6 48 89 de 48 89 ef e8 6e f8 ff ff 84 c0 74 c7 48 89 e8 
5b 5d c3 0f 0b 31 ed 5b 48 89 e8 5d c3 66 2e 0f 1f 84 00 00 00 00 00 <48> 83 
7f 08 00 74 08 0f 0b b8 05 00 00 00 c3 89 77 18 8b 57 14 4c
<4>[   13.200466] RSP: 0018:ffffb78e82bb7650 EFLAGS: 00010282
<4>[   13.200471] RAX: 0000000000000000 RBX: ffffb78e82bb76a4 RCX: 
0000000000000000
<4>[   13.200476] RDX: 0000000000000006 RSI: 0000000000000004 RDI: 
0000000000000000
<4>[   13.200480] RBP: ffffa1d695e93300 R08: 0000000000000003 R09: 
ffffa1d692456600
<4>[   13.200485] R10: fffff7dc88574dc0 R11: ffffb78e82bb75b8 R12: ffffa1d695c68700
<4>[   13.200490] R13: ffffffffc07ef5a0 R14: ffffb78e82bb79b8 R15: ffffa1d692456600
<4>[   13.200495] FS:  00007f9c3fcac300(0000) GS:ffffa1d697b00000(0000) knlGS:
0000000000000000
<4>[   13.200501] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   13.200506] CR2: 0000000000000008 CR3: 00000002124a0000 CR4: 
00000000000406e0
<4>[   13.200510] Call Trace:
<4>[   13.200605]  construct+0x15f/0x710 [amdgpu]
<4>[   13.200710]  link_create+0x2e/0x48 [amdgpu]
<4>[   13.200803]  dc_create+0x2c0/0x5f0 [amdgpu]
<4>[   13.200899]  dm_hw_init+0xe0/0x150 [amdgpu]
<4>[   13.200990]  amdgpu_device_init.cold.38+0xe06/0xf67 [amdgpu]
<4>[   13.201002]  ? kmalloc_order+0x13/0x38
<4>[   13.201102]  amdgpu_driver_load_kms+0x60/0x210 [amdgpu]
<4>[   13.201112]  drm_dev_register+0x10e/0x150
<4>[   13.201207]  amdgpu_pci_probe+0xb8/0x118 [amdgpu]
<4>[   13.201217]  ? _raw_spin_unlock_irqrestore+0xf/0x28
<4>[   13.201226]  pci_device_probe+0xd1/0x158
<4>[   13.201234]  really_probe+0xee/0x2a0
<4>[   13.201241]  driver_probe_device+0x4a/0xb0
<4>[   13.201247]  __driver_attach+0xaf/0xc8
<4>[   13.201253]  ? driver_probe_device+0xb0/0xb0
<4>[   13.201258]  bus_for_each_dev+0x6f/0xb8
<4>[   13.201265]  bus_add_driver+0x197/0x1d8
<4>[   13.201271]  ? 0xffffffffc0933000
<4>[   13.201276]  driver_register+0x66/0xa8
<4>[   13.201281]  ? 0xffffffffc0933000
<4>[   13.201287]  do_one_initcall+0x41/0x1e2
<4>[   13.201294]  ? wake_up_page_bit+0x21/0x100
<4>[   13.201301]  ? kmem_cache_alloc_trace+0x2e/0x1a0
<4>[   13.201308]  ? do_init_module+0x1d/0x1e0
<4>[   13.201315]  do_init_module+0x55/0x1e0
<4>[   13.201321]  load_module+0x205c/0x2488
<4>[   13.201329]  ? vfs_read+0x10e/0x138
<4>[   13.201337]  ? __do_sys_finit_module+0xba/0xd8
<4>[   13.201342]  __do_sys_finit_module+0xba/0xd8
<4>[   13.201350]  do_syscall_64+0x50/0x168
<4>[   13.201357]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4>[   13.201364] RIP: 0033:0x7f9c3fdcf409
<4>[   13.201371] Code: 18 c3 e8 3a 98 01 00 66 2e 0f 1f 84 00 00 00 00 00 48 
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 
3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 6a 0c 00 f7 d8 64 89 01 48
<4>[   13.201381] RSP: 002b:00007fff9b4824f8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
<4>[   13.201389] RAX: ffffffffffffffda RBX: 0000559d56fe1780 RCX: 00007f9c3fdcf409
<4>[   13.201394] RDX: 0000000000000000 RSI: 0000559d570385c0 RDI: 
000000000000000e
<4>[   13.201399] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007fff9b482610
<4>[   13.201404] R10: 000000000000000e R11: 0000000000000246 R12: 
0000559d56ff2120
<4>[   13.201409] R13: 0000000000020000 R14: 0000559d570385c0 R15: 
0000559d56fe1780
<4>[   13.201416] Modules linked in: kvm_amd kvm ath9k irqbypass crc32_pclmul 
ghash_clmulni_intel serio_raw ath9k_common ath9k_hw sdhci_pci cqhci sdhci 
amdgpu(+) mmc_core mac80211 ath mfd_core chash cfg80211 gpu_sched ttm xhci_pci 
ehci_pci xhci_hcd ehci_hcd sp5100_tco
<4>[   13.201448] CR2: 0000000000000008
<4>[   13.206222] ---[ end trace 2244da3024c5ad93 ]---


Here is a full git bisect log on amd-staging-drm-next branch synced today:

git bisect start
# good: [e1be4cb583800db36ed7f6303f7a8c205be24ceb] drm/amd/display: Use memset 
to initialize variables in fill_plane_dcc_attributes
git bisect good e1be4cb583800db36ed7f6303f7a8c205be24ceb
# bad: [25fa5507b06b8cfbec6db7933615ae603516bb7b] drm/amd/display: Disconnect 
mpcc when changing tg
git bisect bad 25fa5507b06b8cfbec6db7933615ae603516bb7b
# good: [e7b4cc9edcbe9c07e5bae2dbdebb04b054e3ff5b] drm/amd/display: Remove 
FreeSync timing changed debug output
git bisect good e7b4cc9edcbe9c07e5bae2dbdebb04b054e3ff5b
# good: [e92d0609eaba2d0a717864854eae3447a4273a29] drm/amd/display: 3.2.16
git bisect good e92d0609eaba2d0a717864854eae3447a4273a29
# bad: [7be6d18fce69c547ba2e0be72b67ac5bedc83dce] drm/amd/display: Modify ABM 
2.2 Max Reduction
git bisect bad 7be6d18fce69c547ba2e0be72b67ac5bedc83dce
# bad: [b18bdff1019443bec3a220857ee6f5350fc4af36] drm/amd/display: pass 
vline_config parameter by reference.
git bisect bad b18bdff1019443bec3a220857ee6f5350fc4af36
# bad: [e261568f94d6c37ebb94d3c4b3f8a3085375dd9d] drm/amd/display: add gpio 
lock/unlock
git bisect bad e261568f94d6c37ebb94d3c4b3f8a3085375dd9d
# first bad commit: [e261568f94d6c37ebb94d3c4b3f8a3085375dd9d] drm/amd/display: 
add gpio lock/unlock

commit e261568f94d6c37ebb94d3c4b3f8a3085375dd9d
Author: Chiawen Huang <chiawen.huang-5C7GfCeVMHo@public.gmane.org>
Date:   Fri Jan 18 14:07:54 2019 +0800

    drm/amd/display: add gpio lock/unlock
    
    [Why]
    When querying HPD via GPIO flow,
    it will create a new gpio object then free in the end of query.
    There is a irql issue for HPD querying at ISR level.
    
    [How]
    Therefore, creating the HPD gpio object in dc_link and set it as unlcok in 
default.
    1. reducing unnecessary malloc/free when HPD querying.
    2. reducing init GPIO flow.
    3. add lock/unlock to prevent multi gpio service running.
    
    Change-Id: Ibcf95d4d50c37b6831d40530194a7d6f08777c5c
    Signed-off-by: Chiawen Huang <chiawen.huang-5C7GfCeVMHo@public.gmane.org>
    Reviewed-by: Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>
    Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
    

Any help is appreciated.

Thanks,
Przemek.

--nextPart3073571.X7BTedMSLo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAlxarVYACgkQPMstj1ls
VJMG7xAAp+eczjyNJbqi9Cfb6ojVNOEOqu+2CJg1+iNL88u5Ug5mRD145Og49hsC
I2ai9erljQ3Xa3N3rkcOJ8WtDOlhu/4JCxn/P30pR08LpgrhZGkkB7B0atiLyEJi
KH+zNZ8yqrjFi3EQlUPXj2qFmUI5+sR43AXRNTJ+CplFiZc8asuROzbAsffVFOc9
NuI3jg+iUiXF1DIxgsy/bCNCQ+QeruiSYktGzaH9gtcEK4hKU1VfLWpbpcA2ATer
6k7G0AeykKAxR2Fau5FgD3PS2ksnnI9drRkgHmzf/M51YrbUweGZ6vwV9qUjTF0d
bjj3AW46tfHFnNCcjR32S+HBozAMYlSl7Bb9at7CC6JwdDn4sSPxRIWWp6+Aj4xe
ZCVA76Li+222PvwF6ZUyMIBQqFFd/lnCClNcA5xiQUtI5l/t0M0iWcDxR7jvynE1
FIFA0l1OKpYGy+RpwH/e1qwGEjEGXoorQc/Pt+Q06T/WaN1pj3Y2yKbR5WCGiKz+
oOuRl02Lfl6crFWyoxu4LYqRTTgFckvMRvkkw4DsXDUlmv0DgnFPRdPNy95AOFTL
/F4bZrwA7+RB4FTTBosiYGhw56AkzgJCGyxYyAuXedeG1Cf0oHCs8uSKHsqB+wfe
UdLtosUYDwoOyfY+kvwmtWEbL+wwhbsLOcsW4sP9f0+0F9Zjq3Y=
=3PPi
-----END PGP SIGNATURE-----

--nextPart3073571.X7BTedMSLo--




--===============1156354077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1156354077==--

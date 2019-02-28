From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: amd-staging-drm-next - [drm] REG_WAIT timeout 1us * 80000 tries -
 dce_abm_set_pipe line:62
Date: Thu, 28 Feb 2019 17:10:51 +0100
Message-ID: <20424141.aeKYZLujXd@eclipse>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1840789601=="
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1840789601==
Content-Type: multipart/signed; boundary="nextPart2816746.VLVOLJpBL0"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2816746.VLVOLJpBL0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi all,

today I've spotted a warning during hibernation (S4) process while the machine 
was attempting to disable all HW and write hibernation image to disk just 
before "amdgpu 0000:00:01.0: GPU pci config reset" and disabling EC interrupt.

Besides that everything works just fine. System hibernates and resumes 
correctly, so I have no idea if I should worry or not.

System is Lenovo G50-45 with a6-6310 APU and r4 Mullins.

>[14469.490249] [drm] REG_WAIT timeout 1us * 80000 tries - dce_abm_set_pipe 
line:62
>[14469.490427] WARNING: CPU: 3 PID: 32028 at drivers/gpu/drm/amd/amdgpu/../
display/dc/dc_helper.c:277 generic_reg_wait.cold.3+0x2a/0x31 [amdgpu]
>[14469.490429] Modules linked in: rfcomm nf_tables ebtable_nat ip_set 
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables overlay squashfs 
loop bnep ipv6 ath3k >btusb btintel bluetooth ecdh_generic rtsx_usb_ms 
memstick rtsx_usb_sdmmc uvcvideo videobuf2_vmalloc videobuf2_memops 
videobuf2_v4l2 rtsx_usb videobuf2_common videodev media >ath9k kvm_amd 
ath9k_common ath9k_hw kvm irqbypass sdhci_pci cqhci sdhci crc32_pclmul 
ghash_clmulni_intel serio_raw mmc_core mac80211 amdgpu ath xhci_pci xhci_hcd 
cfg80211 >mfd_core chash gpu_sched ehci_pci ttm ehci_hcd sp5100_tco
>[14469.490488] CPU: 3 PID: 32028 Comm: kworker/u8:13 Not tainted 5.0.0-rc1+ 
#71
>[14469.490490] Hardware name: LENOVO 80E3/Lancer 5B2, BIOS A2CN45WW(V2.13) 
08/04/2016
>[14469.490499] Workqueue: events_unbound async_run_entry_fn
>[14469.490590] RIP: 0010:generic_reg_wait.cold.3+0x2a/0x31 [amdgpu]
>[14469.490595] Code: 44 8b 44 24 68 48 c7 c7 30 2f 43 c0 48 8b 4c 24 60 8b 54 
24 58 8b 74 24 04 e8 16 ed 37 ef 41 83 7c 24 20 01 0f 84 d6 a3 fe ff <0f> 0b e9 
cf a3 fe ff e8 4d c1 eb ff 48 c7 c7 00 a0 4b c0 e8 a1 77
>[14469.490598] RSP: 0018:ffff9759425ff6e0 EFLAGS: 00010297
>[14469.490602] RAX: 0000000000000043 RBX: 0000000000013881 RCX: 
0000000000000000
>[14469.490605] RDX: 0000000000000000 RSI: 0000000000000096 RDI: 00000000ffffffff
>[14469.490608] RBP: 0000000000001620 R08: 0000000000000004 R09: 
000000000001bb40
>[14469.490611] R10: 000002e453506252 R11: 0000000000000043 R12: 
ffff8d2552416100
>[14469.490613] R13: 0000000000000000 R14: 0000000000000001 R15: 
0000000000000001
>[14469.490617] FS:  0000000000000000(0000) GS:ffff8d2557b80000(0000) knlGS:
0000000000000000
>[14469.490620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[14469.490623] CR2: 00007efbb0564038 CR3: 0000000212b5e000 CR4: 
00000000000406e0
>[14469.490625] Call Trace:
>[14469.490743]  dce_abm_set_pipe+0x47/0x2a8 [amdgpu]
>[14469.490855]  dce_abm_immediate_disable+0x15/0x208 [amdgpu]
>[14469.490949]  dc_link_set_abm_disable+0x31/0x40 [amdgpu]
>[14469.491045]  dce110_blank_stream+0x69/0x70 [amdgpu]
>[14469.491139]  core_link_disable_stream+0x3e/0x238 [amdgpu]
>[14469.491236]  dce110_reset_hw_ctx_wrap+0xbe/0x1e0 [amdgpu]
>[14469.491333]  dce110_apply_ctx_to_hw+0x46/0x768 [amdgpu]
>[14469.491428]  ? amdgpu_pm_compute_clocks.part.11+0x265/0x4d8 [amdgpu]
>[14469.491539]  ? dm_pp_apply_display_requirements+0x1dd/0x1f8 [amdgpu]
>[14469.491633]  dc_commit_state+0x35e/0x9f0 [amdgpu]
>[14469.491731]  ? dce110_timing_generator_get_position+0x71/0x160 [amdgpu]
>[14469.491842]  amdgpu_dm_atomic_commit_tail+0x4b4/0x1cf0 [amdgpu]
>[14469.491941]  ? dce110_timing_generator_get_crtc_scanoutpos+0x75/0x130 
[amdgpu]
>[14469.492031]  ? dc_stream_get_scanoutpos+0x70/0x90 [amdgpu]
>[14469.492140]  ? dm_crtc_get_scanoutpos+0x61/0xb0 [amdgpu]
>[14469.492234]  ? amdgpu_display_get_crtc_scanoutpos+0x80/0x168 [amdgpu]
>[14469.492330]  ? dce110_timing_generator_get_vblank_counter+0x26/0xa0 
[amdgpu]
>[14469.492340]  ? _raw_spin_unlock_irqrestore+0xf/0x28
>[14469.492346]  ? __wake_up_common_lock+0x84/0xb8
>[14469.492456]  ? amdgpu_dm_atomic_commit_tail+0x1cf0/0x1cf0 [amdgpu]
>[14469.492462]  ? preempt_count_add+0x74/0xa0
>[14469.492467]  ? _raw_spin_lock_irq+0xf/0x30
>[14469.492471]  ? _raw_spin_unlock_irq+0xe/0x20
>[14469.492478]  ? wait_for_completion_timeout+0x101/0x128
>[14469.492486]  ? drm_atomic_helper_setup_commit+0x4a7/0x660
>[14469.492493]  ? drm_atomic_helper_commit+0x107/0x418
>[14469.492499]  drm_atomic_helper_commit+0x107/0x418
>[14469.492507]  __drm_atomic_helper_disable_all.constprop.30+0x141/0x150
>[14469.492514]  drm_atomic_helper_suspend+0xe5/0x118
>[14469.492625]  dm_suspend+0x20/0xb8 [amdgpu]
>[14469.492716]  amdgpu_device_ip_suspend_phase1+0x94/0xc0 [amdgpu]
>[14469.492808]  amdgpu_device_suspend+0x2e8/0x490 [amdgpu]
>[14469.492817]  pci_pm_freeze+0x4c/0xc8
>[14469.492823]  ? pci_pm_poweroff+0xd0/0xd0
>[14469.492829]  dpm_run_callback+0x2a/0x120
>[14469.492837]  __device_suspend+0x200/0x7e8
>[14469.492844]  async_suspend+0x15/0x88
>[14469.492849]  async_run_entry_fn+0x32/0xd8
>[14469.492856]  process_one_work+0x1f4/0x428
>[14469.492863]  worker_thread+0x43/0x490
>[14469.492869]  ? process_one_work+0x428/0x428
>[14469.492873]  kthread+0x15d/0x180
>[14469.492878]  ? kthread_create_on_node+0x60/0x60
>[14469.492884]  ret_from_fork+0x22/0x40
>[14469.492891] ---[ end trace c082c85b81f107b8 ]---


IMHO this warning is similar to later one, as mentioned in a bug report : 
https://bugs.freedesktop.org/show_bug.cgi?id=106544 ( I know that this one is 
resolved/fixed due to the system can suspend/hibernate and resume correctly.) 

>[10999.597203] [drm:generic_reg_wait [amdgpu]] *ERROR* REG_WAIT timeout 1us * 
80000 tries - dce_abm_immediate_disable line:318
>[10999.597307] WARNING: CPU: 3 PID: 14336 at drivers/gpu/drm/amd/amdgpu/../
display/dc/dc_helper.c:249 generic_reg_wait+0xd5/0x140 [amdgpu]
>[10999.597309] Modules linked in: rfcomm ebtable_nat ip_set nfnetlink 
ebtable_filter ebtables ip6table_filter ip6_tables overlay squashfs loop bnep 
ipv6 ath3k btusb btintel >bluetooth ecdh_generic rtsx_usb_ms memstick 
rtsx_usb_sdmmc uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 
videobuf2_common videodev media rtsx_usb kvm_amd ath9k >kvm ath9k_common 
irqbypass ath9k_hw crc32_pclmul amdgpu ghash_clmulni_intel serio_raw mac80211 
ath sdhci_pci cqhci sdhci mfd_core chash gpu_sched mmc_core ttm cfg80211 
>xhci_pci ehci_pci xhci_hcd ehci_hcd sp5100_tco
>[10999.597371] CPU: 3 PID: 14336 Comm: kworker/u8:7 Tainted: G        W         
4.19.0-rc1+ #4
>[10999.597373] Hardware name: LENOVO 80E3/Lancer 5B2, BIOS A2CN45WW(V2.13) 
08/04/2016
>[10999.597381] Workqueue: events_unbound async_run_entry_fn
>[10999.597441] RIP: 0010:generic_reg_wait+0xd5/0x140 [amdgpu]
>[10999.597445] Code: 58 89 de 48 8b 4c 24 50 48 c7 c7 e0 b1 5b c0 8b 54 24 48 
44 89 4c 24 08 e8 c8 3c 9e c6 41 83 7c 24 18 01 44 8b 4c 24 08 74 02 <0f> 0b 
48 83 c4 10 44 89 >c8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 41 0f
>[10999.597447] RSP: 0018:ffff9f86c24eb8e8 EFLAGS: 00010297
>[10999.597450] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 
0000000000000001
>[10999.597452] RDX: 0000000000000000 RSI: 0000000000000086 RDI: 00000000ffffffff
>[10999.597454] RBP: 0000000000000000 R08: 000011fa4e0922d1 R09: 
0000000000000001
>[10999.597456] R10: 0000000000000000 R11: 0000000000025e1c R12: 
ffff9976d0a9ae80
>[10999.597458] R13: 0000000000013881 R14: 0000000000000001 R15: 
0000000000000000
>[10999.597461] FS:  0000000000000000(0000) GS:ffff9976d7b80000(0000) knlGS:
0000000000000000
>[10999.597463] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[10999.597465] CR2: 00007f7bcc7c5018 CR3: 000000020eb25000 CR4: 
00000000000406e0
>[10999.597467] Call Trace:
>[10999.597549]  dce_abm_immediate_disable+0x41/0x170 [amdgpu]
>[10999.597615]  dc_link_set_abm_disable+0x31/0x40 [amdgpu]
>[10999.597679]  dce110_blank_stream+0x6f/0x78 [amdgpu]
>[10999.597742]  core_link_disable_stream+0x4f/0x218 [amdgpu]
>[10999.597749]  ? preempt_count_add+0x44/0x98
>[10999.597754]  ? wake_up_klogd+0x4a/0x68
>[10999.597757]  ? vprintk_emit+0x8c/0x1a0
>[10999.597822]  dce110_reset_hw_ctx_wrap+0xbb/0x1e8 [amdgpu]
>[10999.597889]  dce110_apply_ctx_to_hw+0x3f/0x480 [amdgpu]
>[10999.597955]  ? amdgpu_pm_compute_clocks+0x31c/0x530 [amdgpu]
>[10999.598035]  ? dm_pp_apply_display_requirements+0x192/0x1a0 [amdgpu]
>[10999.598099]  dc_commit_state+0x2d7/0x560 [amdgpu]
>[10999.598182]  amdgpu_dm_atomic_commit_tail+0x29f/0xd20 [amdgpu]
>[10999.598190]  ? preempt_count_add+0x63/0x98
>[10999.598196]  ? _raw_spin_lock_irq+0xf/0x30
>[10999.598199]  ? _raw_spin_unlock_irq+0xe/0x20
>[10999.598203]  ? wait_for_completion_timeout+0x101/0x128
>[10999.598206]  ? _raw_spin_lock_irq+0xf/0x30
>[10999.598209]  ? _raw_spin_unlock_irq+0xe/0x20
>[10999.598213]  ? wait_for_completion_interruptible+0xde/0x168
>[10999.598291]  ? dm_plane_helper_prepare_fb+0x1e2/0x2f8 [amdgpu]
>[10999.598299]  commit_tail+0x38/0x60
>[10999.598304]  drm_atomic_helper_commit+0x102/0x110
>[10999.598309]  __drm_atomic_helper_disable_all.constprop.30+0x13d/0x150
>[10999.598314]  drm_atomic_helper_suspend+0x4c/0xd0
>[10999.598396]  dm_suspend+0x2d/0x50 [amdgpu]
>[10999.598458]  amdgpu_device_ip_suspend_phase1+0x8e/0xc0 [amdgpu]
>[10999.598522]  amdgpu_device_suspend+0x234/0x3c8 [amdgpu]
>[10999.598531]  pci_pm_suspend+0x76/0x128
>[10999.598535]  ? pci_pm_freeze+0xc8/0xc8
>[10999.598541]  dpm_run_callback+0x2a/0x110
>[10999.598546]  __device_suspend+0xe5/0x3d0
>[10999.598552]  async_suspend+0x15/0x88
>[10999.598556]  async_run_entry_fn+0x32/0xd8
>[10999.598562]  process_one_work+0x1f4/0x3e0
>[10999.598567]  worker_thread+0x28/0x3c0
>[10999.598571]  ? rescuer_thread+0x330/0x330
>[10999.598575]  kthread+0x118/0x130
>[10999.598580]  ? kthread_create_worker_on_cpu+0x60/0x60
>[10999.598585]  ret_from_fork+0x22/0x40
>[10999.598593] ---[ end trace c54e6357600c238a ]---


Maybe this could be helpful and will put some light what is going on. 

Thanks,
Przemek.
--nextPart2816746.VLVOLJpBL0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAlx4CAsACgkQPMstj1ls
VJNT4Q/+OoA4xIvpu2+BGFOcF6X7BWWgMjxxPMKnDNOVtJdLXFH4iMF2KPfpy+KU
fuWAgfXUvL5pc/QzLvF56sQ9cNSYAoUqGQQjz7PLdAqvOIAnBWWVuWjkLFEfx2k4
27uNA1Ijvq4OX6MrT4NEuNM3I6r+IKC8W2ZJGqUDdpEKzOgNidyWIRuGu1lfVWbg
p/95gNXCoPFg0MZOxdOjyFqbyT7KtkaGXrHBuBOSagw3tfoqfZHzz8D7LofcNDbK
M5WFHPJeaiBYE3T/Cyzb28YPcD8mIAxX8oPFcCBzEomQ3RE+UdLihuj9HgNuvwGd
6MlHyR3JxE692He/vNJAzgW2eTjHMLOpLLTVgmrWLhoGW2zVjcQlXGtR65NYMVYr
oF6Rf7MUilSwpvyLIB0PEO0CR8IbvF5mcKaLn5QC7z0YE0NoMoXksp2wDttpDZVc
vyLNBQaXwClJJrtruoo2YQzzNiAG6QWd3ciDIJbRMicXvPfegytQ0rVJ3AGOK3CN
plKEd1RhGwOUMbBjDkyOUcIqDIA8GvBTW6oiukqXT/URDnMwSh3WK66uNk6ksb4n
plIZWFCHCf45uQw2A07UEj3LVrjuMGm52KegT2Q3w31luM7idJJk545wxfq3oavB
OhusJDbIm9sJhZTGYcmu32h+Eh7W1DT4Z047i0UUtV/jNqssM7I=
=7RMH
-----END PGP SIGNATURE-----

--nextPart2816746.VLVOLJpBL0--




--===============1840789601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1840789601==--

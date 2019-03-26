From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: WARNING at amdgpu_vm_sdma.c:85
Date: Tue, 26 Mar 2019 16:21:23 +0100
Message-ID: <ad5fa654-8093-9d0d-df29-2aa702365e76@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------EBCB1E26CBB2763AD1CA931A"
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
--------------EBCB1E26CBB2763AD1CA931A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


I'm hitting some badness with piglit today, see the attached dmesg
excerpt. I was away for a couple of days, but looks like it might be
related to the VM changes? I'll try bisecting.


-- 
Earthling Michel Dänzer               |              https://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------EBCB1E26CBB2763AD1CA931A
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Mar 26 13:39:22 kaveri kernel: [ 2583.307294] WARNING: CPU: 8 PID: 6574 a=
t drivers/gpu/drm//amd/amdgpu/amdgpu_vm_sdma.c:85 amdgpu_vm_sdma_commit+0=
x358/0x480 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.307670] Modules linked in: fuse(E) =
ipt_MASQUERADE(E) nf_conntrack_netlink(E) nfnetlink(E) xfrm_user(E) xfrm_=
algo(E) iptable_nat(E) nf_nat_ipv4(E) xt_addrtype(E) iptable_filter(E) bp=
filter(E) xt_conntrack(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_=
defrag_ipv4(E) libcrc32c(E) br_netfilter(E) bridge(E) stp(E) llc(E) overl=
ay(E) lz4(E) lz4_compress(E) cpufreq_powersave(E) cpufreq_userspace(E) cp=
ufreq_conservative(E) amdgpu(OE) gpu_sched(OE) binfmt_misc(E) nls_ascii(E=
) nls_cp437(E) vfat(E) fat(E) edac_mce_amd(E) kvm(E) irqbypass(E) radeon(=
OE) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) ledtrig_audio(E) sn=
d_hda_codec_hdmi(E) crct10dif_pclmul(E) crc32_pclmul(E) ttm(OE) snd_hda_i=
ntel(E) snd_hda_codec(E) drm_kms_helper(OE) ghash_clmulni_intel(E) snd_hd=
a_core(E) efi_pstore(E) wmi_bmof(E) snd_hwdep(E) drm(OE) realtek(E) aesni=
_intel(E) snd_pcm(E) i2c_algo_bit(E) aes_x86_64(E) snd_timer(E) crypto_si=
md(E) r8169(E) fb_sys_fops(E) sg(E) cryptd(E) syscopyarea(E) sp5100_tco(E=
) glue_helper(E)
Mar 26 13:39:22 kaveri kernel: [ 2583.307738]  ccp(E) sysfillrect(E) snd(=
E) pcspkr(E) efivars(E) rng_core(E) sysimgblt(E) libphy(E) i2c_piix4(E) s=
oundcore(E) k10temp(E) wmi(E) pcc_cpufreq(E) button(E) acpi_cpufreq(E) tc=
p_bbr(E) sch_fq(E) sunrpc(E) nct6775(E) hwmon_vid(E) efivarfs(E) ip_table=
s(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E)=
 jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) multipath(E) l=
inear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) hid(E) ahc=
i(E) libahci(E) xhci_pci(E) libata(E) xhci_hcd(E) crc32c_intel(E) scsi_mo=
d(E) usbcore(E) gpio_amdpt(E) gpio_generic(E)
Mar 26 13:39:22 kaveri kernel: [ 2583.307804] CPU: 8 PID: 6574 Comm: shad=
er_run:cs0 Tainted: G           OE     5.0.0-rc1-00651-g4a93cf78b903 #121=

Mar 26 13:39:22 kaveri kernel: [ 2583.307811] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Mar 26 13:39:22 kaveri kernel: [ 2583.307935] RIP: 0010:amdgpu_vm_sdma_co=
mmit+0x358/0x480 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.307943] Code: 48 c1 ea 03 80 3c 02 =
00 0f 85 34 01 00 00 48 8b 7b 18 e8 8b 5b 28 00 eb a1 48 89 df e8 a1 47 c=
5 cf eb 97 0f 0b e9 d3 fe ff ff <0f> 0b e9 fa fd ff ff e8 fc 8b 23 cf e9 =
8e fe ff ff 48 89 44 24 10
Mar 26 13:39:22 kaveri kernel: [ 2583.307949] RSP: 0018:ffff88835a2ef4e8 =
EFLAGS: 00010246
Mar 26 13:39:22 kaveri kernel: [ 2583.307956] RAX: ffff888341c8af18 RBX: =
ffff88835a2ef6c0 RCX: 0000000000000000
Mar 26 13:39:22 kaveri kernel: [ 2583.307962] RDX: ffff888341c8afe8 RSI: =
ffff88814063fbb0 RDI: ffff88814063fbb8
Mar 26 13:39:22 kaveri kernel: [ 2583.307967] RBP: 1ffff1106b45dea0 R08: =
1ffff110280c7f77 R09: ffffed1068390aee
Mar 26 13:39:22 kaveri kernel: [ 2583.307973] R10: ffffed1068390aee R11: =
ffff888341c85773 R12: ffff88835a2ef6e0
Mar 26 13:39:22 kaveri kernel: [ 2583.307979] R13: ffff888367d2c4e0 R14: =
ffff888360bfa200 R15: ffff88835a2ef6c8
Mar 26 13:39:22 kaveri kernel: [ 2583.307985] FS:  00007fc032275700(0000)=
 GS:ffff88837e000000(0000) knlGS:0000000000000000
Mar 26 13:39:22 kaveri kernel: [ 2583.307990] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Mar 26 13:39:22 kaveri kernel: [ 2583.307995] CR2: 00007f80c450d000 CR3: =
000000015d8e6000 CR4: 00000000003406e0
Mar 26 13:39:22 kaveri kernel: [ 2583.308000] Call Trace:
Mar 26 13:39:22 kaveri kernel: [ 2583.308128]  ? amdgpu_vm_cpu_prepare+0x=
c0/0xc0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.308255]  ? amdgpu_vm_sdma_prepare+0=
x170/0x2e0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.308382]  amdgpu_vm_update_directori=
es+0x664/0xa60 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.308511]  ? amdgpu_vm_map_gart+0x40/=
0x40 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.308633]  ? amdgpu_vm_handle_moved+0=
x28c/0x360 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.308649]  ? lock_downgrade+0x5d0/0x5=
d0
Mar 26 13:39:22 kaveri kernel: [ 2583.308657]  ? rwlock_bug.part.2+0x90/0=
x90
Mar 26 13:39:22 kaveri kernel: [ 2583.308788]  ? amdgpu_vm_handle_moved+0=
x28c/0x360 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.308917]  amdgpu_cs_ioctl+0x2f57/0x4=
850 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.309047]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.309055]  ? __switch_to_asm+0x40/0x7=
0
Mar 26 13:39:22 kaveri kernel: [ 2583.309067]  ? __lock_acquire+0x5d6/0x4=
650
Mar 26 13:39:22 kaveri kernel: [ 2583.309076]  ? futex_wait_queue_me+0x1c=
3/0x510
Mar 26 13:39:22 kaveri kernel: [ 2583.309089]  ? firmware_map_remove+0x16=
b/0x16b
Mar 26 13:39:22 kaveri kernel: [ 2583.309103]  ? mark_held_locks+0x140/0x=
140
Mar 26 13:39:22 kaveri kernel: [ 2583.309264]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.309294]  drm_ioctl_kernel+0x1c6/0x2=
60 [drm]
Mar 26 13:39:22 kaveri kernel: [ 2583.309325]  ? drm_setversion+0x800/0x8=
00 [drm]
Mar 26 13:39:22 kaveri kernel: [ 2583.309365]  drm_ioctl+0x42d/0x920 [drm=
]
Mar 26 13:39:22 kaveri kernel: [ 2583.309487]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.309518]  ? drm_version+0x390/0x390 =
[drm]
Mar 26 13:39:22 kaveri kernel: [ 2583.309525]  ? find_held_lock+0x33/0x1c=
0
Mar 26 13:39:22 kaveri kernel: [ 2583.309536]  ? __pm_runtime_resume+0xb2=
/0xf0
Mar 26 13:39:22 kaveri kernel: [ 2583.309549]  ? lock_downgrade+0x5d0/0x5=
d0
Mar 26 13:39:22 kaveri kernel: [ 2583.309555]  ? lock_acquire+0x103/0x2c0=

Mar 26 13:39:22 kaveri kernel: [ 2583.309562]  ? __pm_runtime_resume+0x98=
/0xf0
Mar 26 13:39:22 kaveri kernel: [ 2583.309571]  ? _raw_spin_unlock_irqrest=
ore+0x3c/0x50
Mar 26 13:39:22 kaveri kernel: [ 2583.309580]  ? lockdep_hardirqs_on+0x37=
c/0x560
Mar 26 13:39:22 kaveri kernel: [ 2583.309702]  amdgpu_drm_ioctl+0xd0/0x1b=
0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.309716]  do_vfs_ioctl+0x193/0xfd0
Mar 26 13:39:22 kaveri kernel: [ 2583.309725]  ? lock_downgrade+0x5d0/0x5=
d0
Mar 26 13:39:22 kaveri kernel: [ 2583.309733]  ? ioctl_preallocate+0x1b0/=
0x1b0
Mar 26 13:39:22 kaveri kernel: [ 2583.309749]  ? __fget+0x287/0x3e0
Mar 26 13:39:22 kaveri kernel: [ 2583.309763]  ? expand_files.part.9+0x5e=
0/0x5e0
Mar 26 13:39:22 kaveri kernel: [ 2583.309769]  ? __x64_sys_futex+0x261/0x=
370
Mar 26 13:39:22 kaveri kernel: [ 2583.309791]  ksys_ioctl+0x60/0x90
Mar 26 13:39:22 kaveri kernel: [ 2583.309802]  __x64_sys_ioctl+0x6f/0xb0
Mar 26 13:39:22 kaveri kernel: [ 2583.309808]  ? lockdep_hardirqs_on+0x37=
c/0x560
Mar 26 13:39:22 kaveri kernel: [ 2583.309816]  do_syscall_64+0x9c/0x3d0
Mar 26 13:39:22 kaveri kernel: [ 2583.309826]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Mar 26 13:39:22 kaveri kernel: [ 2583.309833] RIP: 0033:0x7fc037a78777
Mar 26 13:39:22 kaveri kernel: [ 2583.309839] Code: 00 00 90 48 8b 05 19 =
a7 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 =
a6 0c 00 f7 d8 64 89 01 48
Mar 26 13:39:22 kaveri kernel: [ 2583.309845] RSP: 002b:00007fc032274bc8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Mar 26 13:39:22 kaveri kernel: [ 2583.309852] RAX: ffffffffffffffda RBX: =
00007fc032274cf8 RCX: 00007fc037a78777
Mar 26 13:39:22 kaveri kernel: [ 2583.309857] RDX: 00007fc032274c40 RSI: =
00000000c0186444 RDI: 0000000000000006
Mar 26 13:39:22 kaveri kernel: [ 2583.309863] RBP: 00007fc032274bf0 R08: =
00007fc032274d50 R09: 0000000000000020
Mar 26 13:39:22 kaveri kernel: [ 2583.309868] R10: 00007fc032274d50 R11: =
0000000000000246 R12: 00007fc032274c40
Mar 26 13:39:22 kaveri kernel: [ 2583.309873] R13: 00000000c0186444 R14: =
0000000000000006 R15: 000055c7c4c1fc80
Mar 26 13:39:22 kaveri kernel: [ 2583.309895] irq event stamp: 16107698
Mar 26 13:39:22 kaveri kernel: [ 2583.309902] hardirqs last  enabled at (=
16107697): [<ffffffff925ab02c>] _raw_spin_unlock_irqrestore+0x3c/0x50
Mar 26 13:39:22 kaveri kernel: [ 2583.309910] hardirqs last disabled at (=
16107698): [<ffffffff90e03542>] trace_hardirqs_off_thunk+0x1a/0x1c
Mar 26 13:39:22 kaveri kernel: [ 2583.309917] softirqs last  enabled at (=
16107366): [<ffffffff928005d4>] __do_softirq+0x5d4/0x86e
Mar 26 13:39:22 kaveri kernel: [ 2583.309924] softirqs last disabled at (=
16107361): [<ffffffff90f3c022>] irq_exit+0x1a2/0x1d0
Mar 26 13:39:22 kaveri kernel: [ 2583.309929] ---[ end trace f92a944f39a3=
7d17 ]---
Mar 26 13:39:22 kaveri kernel: [ 2583.338908] WARNING: CPU: 15 PID: 32703=
 at drivers/gpu/drm//amd/amdgpu/amdgpu_vm_sdma.c:85 amdgpu_vm_sdma_commit=
+0x358/0x480 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.338921] Modules linked in: fuse(E) =
ipt_MASQUERADE(E) nf_conntrack_netlink(E) nfnetlink(E) xfrm_user(E) xfrm_=
algo(E) iptable_nat(E) nf_nat_ipv4(E) xt_addrtype(E) iptable_filter(E) bp=
filter(E) xt_conntrack(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_=
defrag_ipv4(E) libcrc32c(E) br_netfilter(E) bridge(E) stp(E) llc(E) overl=
ay(E) lz4(E) lz4_compress(E) cpufreq_powersave(E) cpufreq_userspace(E) cp=
ufreq_conservative(E) amdgpu(OE) gpu_sched(OE) binfmt_misc(E) nls_ascii(E=
) nls_cp437(E) vfat(E) fat(E) edac_mce_amd(E) kvm(E) irqbypass(E) radeon(=
OE) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) ledtrig_audio(E) sn=
d_hda_codec_hdmi(E) crct10dif_pclmul(E) crc32_pclmul(E) ttm(OE) snd_hda_i=
ntel(E) snd_hda_codec(E) drm_kms_helper(OE) ghash_clmulni_intel(E) snd_hd=
a_core(E) efi_pstore(E) wmi_bmof(E) snd_hwdep(E) drm(OE) realtek(E) aesni=
_intel(E) snd_pcm(E) i2c_algo_bit(E) aes_x86_64(E) snd_timer(E) crypto_si=
md(E) r8169(E) fb_sys_fops(E) sg(E) cryptd(E) syscopyarea(E) sp5100_tco(E=
) glue_helper(E)
Mar 26 13:39:22 kaveri kernel: [ 2583.338995]  ccp(E) sysfillrect(E) snd(=
E) pcspkr(E) efivars(E) rng_core(E) sysimgblt(E) libphy(E) i2c_piix4(E) s=
oundcore(E) k10temp(E) wmi(E) pcc_cpufreq(E) button(E) acpi_cpufreq(E) tc=
p_bbr(E) sch_fq(E) sunrpc(E) nct6775(E) hwmon_vid(E) efivarfs(E) ip_table=
s(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E)=
 jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) multipath(E) l=
inear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) hid(E) ahc=
i(E) libahci(E) xhci_pci(E) libata(E) xhci_hcd(E) crc32c_intel(E) scsi_mo=
d(E) usbcore(E) gpio_amdpt(E) gpio_generic(E)
Mar 26 13:39:22 kaveri kernel: [ 2583.339065] CPU: 15 PID: 32703 Comm: Xe=
phyr:cs0 Tainted: G        W  OE     5.0.0-rc1-00651-g4a93cf78b903 #121
Mar 26 13:39:22 kaveri kernel: [ 2583.339071] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Mar 26 13:39:22 kaveri kernel: [ 2583.339196] RIP: 0010:amdgpu_vm_sdma_co=
mmit+0x358/0x480 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.339204] Code: 48 c1 ea 03 80 3c 02 =
00 0f 85 34 01 00 00 48 8b 7b 18 e8 8b 5b 28 00 eb a1 48 89 df e8 a1 47 c=
5 cf eb 97 0f 0b e9 d3 fe ff ff <0f> 0b e9 fa fd ff ff e8 fc 8b 23 cf e9 =
8e fe ff ff 48 89 44 24 10
Mar 26 13:39:22 kaveri kernel: [ 2583.339210] RSP: 0018:ffff8882cb0a74e8 =
EFLAGS: 00010246
Mar 26 13:39:22 kaveri kernel: [ 2583.339217] RAX: ffff888341c8baa0 RBX: =
ffff8882cb0a76c0 RCX: 0000000000000000
Mar 26 13:39:22 kaveri kernel: [ 2583.339223] RDX: ffff888341c8bb70 RSI: =
ffff88836de6ca30 RDI: ffff88836de6ca38
Mar 26 13:39:22 kaveri kernel: [ 2583.339228] RBP: 1ffff11059614ea0 R08: =
1ffff1106dbcd947 R09: ffffed1068390aee
Mar 26 13:39:22 kaveri kernel: [ 2583.339234] R10: ffffed1068390aee R11: =
ffff888341c85773 R12: ffff8882cb0a76e0
Mar 26 13:39:22 kaveri kernel: [ 2583.339240] R13: ffff888112ad33e0 R14: =
ffff888378dde600 R15: ffff8882cb0a76c8
Mar 26 13:39:22 kaveri kernel: [ 2583.339246] FS:  00007f49dde76700(0000)=
 GS:ffff88837e1c0000(0000) knlGS:0000000000000000
Mar 26 13:39:22 kaveri kernel: [ 2583.339252] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Mar 26 13:39:22 kaveri kernel: [ 2583.339257] CR2: 00007fe47ce62380 CR3: =
00000003710b8000 CR4: 00000000003406e0
Mar 26 13:39:22 kaveri kernel: [ 2583.339262] Call Trace:
Mar 26 13:39:22 kaveri kernel: [ 2583.339391]  ? amdgpu_vm_cpu_prepare+0x=
c0/0xc0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.339521]  ? amdgpu_vm_sdma_prepare+0=
x170/0x2e0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.339647]  amdgpu_vm_update_directori=
es+0x664/0xa60 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.339775]  ? amdgpu_vm_map_gart+0x40/=
0x40 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.339897]  ? amdgpu_vm_handle_moved+0=
x28c/0x360 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.339913]  ? lock_downgrade+0x5d0/0x5=
d0
Mar 26 13:39:22 kaveri kernel: [ 2583.339921]  ? rwlock_bug.part.2+0x90/0=
x90
Mar 26 13:39:22 kaveri kernel: [ 2583.340051]  ? amdgpu_vm_handle_moved+0=
x28c/0x360 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.340181]  amdgpu_cs_ioctl+0x2f57/0x4=
850 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.340198]  ? put_task_stack+0x101/0x2=
90
Mar 26 13:39:22 kaveri kernel: [ 2583.340321]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.340330]  ? __switch_to_asm+0x40/0x7=
0
Mar 26 13:39:22 kaveri kernel: [ 2583.340342]  ? __lock_acquire+0x5d6/0x4=
650
Mar 26 13:39:22 kaveri kernel: [ 2583.340351]  ? futex_wait_queue_me+0x1c=
3/0x510
Mar 26 13:39:22 kaveri kernel: [ 2583.340364]  ? firmware_map_remove+0x16=
b/0x16b
Mar 26 13:39:22 kaveri kernel: [ 2583.340377]  ? mark_held_locks+0x140/0x=
140
Mar 26 13:39:22 kaveri kernel: [ 2583.340542]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.340575]  drm_ioctl_kernel+0x1c6/0x2=
60 [drm]
Mar 26 13:39:22 kaveri kernel: [ 2583.340606]  ? drm_setversion+0x800/0x8=
00 [drm]
Mar 26 13:39:22 kaveri kernel: [ 2583.340647]  drm_ioctl+0x42d/0x920 [drm=
]
Mar 26 13:39:22 kaveri kernel: [ 2583.340772]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.340804]  ? drm_version+0x390/0x390 =
[drm]
Mar 26 13:39:22 kaveri kernel: [ 2583.340811]  ? find_held_lock+0x33/0x1c=
0
Mar 26 13:39:22 kaveri kernel: [ 2583.340823]  ? __pm_runtime_resume+0xb2=
/0xf0
Mar 26 13:39:22 kaveri kernel: [ 2583.340836]  ? lock_downgrade+0x5d0/0x5=
d0
Mar 26 13:39:22 kaveri kernel: [ 2583.340842]  ? lock_acquire+0x103/0x2c0=

Mar 26 13:39:22 kaveri kernel: [ 2583.340849]  ? __pm_runtime_resume+0x98=
/0xf0
Mar 26 13:39:22 kaveri kernel: [ 2583.340859]  ? _raw_spin_unlock_irqrest=
ore+0x3c/0x50
Mar 26 13:39:22 kaveri kernel: [ 2583.340868]  ? lockdep_hardirqs_on+0x37=
c/0x560
Mar 26 13:39:22 kaveri kernel: [ 2583.340994]  amdgpu_drm_ioctl+0xd0/0x1b=
0 [amdgpu]
Mar 26 13:39:22 kaveri kernel: [ 2583.341009]  do_vfs_ioctl+0x193/0xfd0
Mar 26 13:39:22 kaveri kernel: [ 2583.341018]  ? lock_downgrade+0x5d0/0x5=
d0
Mar 26 13:39:22 kaveri kernel: [ 2583.341027]  ? ioctl_preallocate+0x1b0/=
0x1b0
Mar 26 13:39:22 kaveri kernel: [ 2583.341042]  ? __fget+0x287/0x3e0
Mar 26 13:39:22 kaveri kernel: [ 2583.341056]  ? expand_files.part.9+0x5e=
0/0x5e0
Mar 26 13:39:22 kaveri kernel: [ 2583.341062]  ? __x64_sys_futex+0x261/0x=
370
Mar 26 13:39:22 kaveri kernel: [ 2583.341072]  ? __fget_light+0x55/0x1f0
Mar 26 13:39:22 kaveri kernel: [ 2583.341090]  ksys_ioctl+0x60/0x90
Mar 26 13:39:22 kaveri kernel: [ 2583.341101]  __x64_sys_ioctl+0x6f/0xb0
Mar 26 13:39:22 kaveri kernel: [ 2583.341107]  ? lockdep_hardirqs_on+0x37=
c/0x560
Mar 26 13:39:22 kaveri kernel: [ 2583.341115]  do_syscall_64+0x9c/0x3d0
Mar 26 13:39:22 kaveri kernel: [ 2583.341125]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Mar 26 13:39:22 kaveri kernel: [ 2583.341132] RIP: 0033:0x7f49e3145777
Mar 26 13:39:22 kaveri kernel: [ 2583.341138] Code: 00 00 90 48 8b 05 19 =
a7 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 =
a6 0c 00 f7 d8 64 89 01 48
Mar 26 13:39:22 kaveri kernel: [ 2583.341144] RSP: 002b:00007f49dde759d8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Mar 26 13:39:22 kaveri kernel: [ 2583.341151] RAX: ffffffffffffffda RBX: =
00007f49dde75af8 RCX: 00007f49e3145777
Mar 26 13:39:22 kaveri kernel: [ 2583.341156] RDX: 00007f49dde75a50 RSI: =
00000000c0186444 RDI: 0000000000000007
Mar 26 13:39:22 kaveri kernel: [ 2583.341162] RBP: 00007f49dde75a00 R08: =
00007f49dde75b50 R09: 0000000000000020
Mar 26 13:39:22 kaveri kernel: [ 2583.341167] R10: 00007f49dde75b50 R11: =
0000000000000246 R12: 00007f49dde75a50
Mar 26 13:39:22 kaveri kernel: [ 2583.341172] R13: 00000000c0186444 R14: =
0000000000000007 R15: 0000556595e9ae18
Mar 26 13:39:22 kaveri kernel: [ 2583.341194] irq event stamp: 35442202
Mar 26 13:39:22 kaveri kernel: [ 2583.341204] hardirqs last  enabled at (=
35442201): [<ffffffff910add8b>] __call_rcu.constprop.62+0x19b/0x530
Mar 26 13:39:22 kaveri kernel: [ 2583.341211] hardirqs last disabled at (=
35442202): [<ffffffff90e03542>] trace_hardirqs_off_thunk+0x1a/0x1c
Mar 26 13:39:22 kaveri kernel: [ 2583.341218] softirqs last  enabled at (=
35441988): [<ffffffff928005d4>] __do_softirq+0x5d4/0x86e
Mar 26 13:39:22 kaveri kernel: [ 2583.341225] softirqs last disabled at (=
35441979): [<ffffffff90f3c022>] irq_exit+0x1a2/0x1d0
Mar 26 13:39:22 kaveri kernel: [ 2583.341231] ---[ end trace f92a944f39a3=
7d18 ]---
Mar 26 13:39:32 kaveri kernel: [ 2593.568043] [drm:amdgpu_job_timedout [a=
mdgpu]] *ERROR* ring sdma0 timeout, signaled seq=3D2383280, emitted seq=3D=
2383282
Mar 26 13:39:32 kaveri kernel: [ 2593.568258] [drm:amdgpu_job_timedout [a=
mdgpu]] *ERROR* Process information: process  pid 0 thread  pid 0
Mar 26 13:39:32 kaveri kernel: [ 2593.568301] amdgpu 0000:23:00.0: GPU re=
set begin!
Mar 26 13:39:32 kaveri kernel: [ 2593.569331]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.569335] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Mar 26 13:39:32 kaveri kernel: [ 2593.569338] WARNING: possible circular =
locking dependency detected
Mar 26 13:39:32 kaveri kernel: [ 2593.569341] 5.0.0-rc1-00651-g4a93cf78b9=
03 #121 Tainted: G        W  OE   =20
Mar 26 13:39:32 kaveri kernel: [ 2593.569343] ---------------------------=
---------------------------
Mar 26 13:39:32 kaveri kernel: [ 2593.569346] kworker/7:4/29967 is trying=
 to acquire lock:
Mar 26 13:39:32 kaveri kernel: [ 2593.569348] 00000000f7919cea (&(&ring->=
fence_drv.lock)->rlock){-.-.}, at: dma_fence_remove_callback+0x41/0x210
Mar 26 13:39:32 kaveri kernel: [ 2593.569358]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.569358] but task is already holding=
 lock:
Mar 26 13:39:32 kaveri kernel: [ 2593.569360] 00000000d185855f (&(&sched-=
>job_list_lock)->rlock){-.-.}, at: drm_sched_stop+0x57/0x390 [gpu_sched]
Mar 26 13:39:32 kaveri kernel: [ 2593.569367]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.569367] which lock already depends =
on the new lock.
Mar 26 13:39:32 kaveri kernel: [ 2593.569367]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.569369]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.569369] the existing dependency cha=
in (in reverse order) is:
Mar 26 13:39:32 kaveri kernel: [ 2593.569371]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.569371] -> #1 (&(&sched->job_list_l=
ock)->rlock){-.-.}:
Mar 26 13:39:32 kaveri kernel: [ 2593.569378]        drm_sched_process_jo=
b+0xbb/0x410 [gpu_sched]
Mar 26 13:39:32 kaveri kernel: [ 2593.569382]        dma_fence_signal+0x2=
88/0x480
Mar 26 13:39:32 kaveri kernel: [ 2593.569455]        amdgpu_fence_process=
+0x211/0x320 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.569536]        cik_sdma_process_tra=
p_irq+0x7d/0xb0 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.569619]        amdgpu_irq_dispatch+=
0x256/0x590 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.569701]        amdgpu_ih_process+0x=
1c6/0x3e0 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.569784]        amdgpu_irq_handler+0=
x39/0xc0 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.569789]        __handle_irq_event_p=
ercpu+0xf5/0x580
Mar 26 13:39:32 kaveri kernel: [ 2593.569792]        handle_irq_event_per=
cpu+0x73/0x140
Mar 26 13:39:32 kaveri kernel: [ 2593.569794]        handle_irq_event+0xa=
d/0x13c
Mar 26 13:39:32 kaveri kernel: [ 2593.569797]        handle_edge_irq+0x1e=
3/0x790
Mar 26 13:39:32 kaveri kernel: [ 2593.569801]        handle_irq+0x18e/0x2=
fe
Mar 26 13:39:32 kaveri kernel: [ 2593.569805]        do_IRQ+0x7e/0x1a0
Mar 26 13:39:32 kaveri kernel: [ 2593.569808]        ret_from_intr+0x0/0x=
1d
Mar 26 13:39:32 kaveri kernel: [ 2593.569811]        lock_acquire+0x145/0=
x2c0
Mar 26 13:39:32 kaveri kernel: [ 2593.569815]        is_bpf_text_address+=
0x2d/0xe0
Mar 26 13:39:32 kaveri kernel: [ 2593.569819]        kernel_text_address+=
0x125/0x140
Mar 26 13:39:32 kaveri kernel: [ 2593.569822]        __kernel_text_addres=
s+0xe/0x30
Mar 26 13:39:32 kaveri kernel: [ 2593.569825]        unwind_get_return_ad=
dress+0x5f/0xa0
Mar 26 13:39:32 kaveri kernel: [ 2593.569828]        __save_stack_trace+0=
x92/0x100
Mar 26 13:39:32 kaveri kernel: [ 2593.569832]        save_stack+0x32/0xb0=

Mar 26 13:39:32 kaveri kernel: [ 2593.569834]        kasan_kmalloc+0xc6/0=
xd0
Mar 26 13:39:32 kaveri kernel: [ 2593.569838]        cgroup_show_path+0xc=
4/0x570
Mar 26 13:39:32 kaveri kernel: [ 2593.569841]        show_mountinfo+0x22e=
/0x7f0
Mar 26 13:39:32 kaveri kernel: [ 2593.569845]        seq_read+0x3fb/0x101=
0
Mar 26 13:39:32 kaveri kernel: [ 2593.569848]        __vfs_read+0xe1/0x73=
0
Mar 26 13:39:32 kaveri kernel: [ 2593.569851]        vfs_read+0xe9/0x2e0
Mar 26 13:39:32 kaveri kernel: [ 2593.569853]        ksys_read+0xb8/0x170=

Mar 26 13:39:32 kaveri kernel: [ 2593.569856]        do_syscall_64+0x9c/0=
x3d0
Mar 26 13:39:32 kaveri kernel: [ 2593.569859]        entry_SYSCALL_64_aft=
er_hwframe+0x49/0xbe
Mar 26 13:39:32 kaveri kernel: [ 2593.569862]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.569862] -> #0 (&(&ring->fence_drv.l=
ock)->rlock){-.-.}:
Mar 26 13:39:32 kaveri kernel: [ 2593.569867]        _raw_spin_lock_irqsa=
ve+0x2e/0x40
Mar 26 13:39:32 kaveri kernel: [ 2593.569870]        dma_fence_remove_cal=
lback+0x41/0x210
Mar 26 13:39:32 kaveri kernel: [ 2593.569875]        drm_sched_stop+0x1c5=
/0x390 [gpu_sched]
Mar 26 13:39:32 kaveri kernel: [ 2593.569946]        amdgpu_device_pre_as=
ic_reset+0xab/0x8d0 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.570017]        amdgpu_device_gpu_re=
cover+0x12f/0x15c0 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.570110]        amdgpu_job_timedout+=
0x31d/0x460 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.570115]        drm_sched_job_timedo=
ut+0xae/0x110 [gpu_sched]
Mar 26 13:39:32 kaveri kernel: [ 2593.570118]        process_one_work+0x8=
15/0x1490
Mar 26 13:39:32 kaveri kernel: [ 2593.570121]        worker_thread+0x87/0=
xb10
Mar 26 13:39:32 kaveri kernel: [ 2593.570124]        kthread+0x2e2/0x3a0
Mar 26 13:39:32 kaveri kernel: [ 2593.570127]        ret_from_fork+0x27/0=
x50
Mar 26 13:39:32 kaveri kernel: [ 2593.570128]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.570128] other info that might help =
us debug this:
Mar 26 13:39:32 kaveri kernel: [ 2593.570128]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.570130]  Possible unsafe locking sc=
enario:
Mar 26 13:39:32 kaveri kernel: [ 2593.570130]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.570132]        CPU0                =
    CPU1
Mar 26 13:39:32 kaveri kernel: [ 2593.570134]        ----                =
    ----
Mar 26 13:39:32 kaveri kernel: [ 2593.570135]   lock(&(&sched->job_list_l=
ock)->rlock);
Mar 26 13:39:32 kaveri kernel: [ 2593.570138]                            =
    lock(&(&ring->fence_drv.lock)->rlock);
Mar 26 13:39:32 kaveri kernel: [ 2593.570140]                            =
    lock(&(&sched->job_list_lock)->rlock);
Mar 26 13:39:32 kaveri kernel: [ 2593.570143]   lock(&(&ring->fence_drv.l=
ock)->rlock);
Mar 26 13:39:32 kaveri kernel: [ 2593.570145]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.570145]  *** DEADLOCK ***
Mar 26 13:39:32 kaveri kernel: [ 2593.570145]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.570148] 4 locks held by kworker/7:4=
/29967:
Mar 26 13:39:32 kaveri kernel: [ 2593.570149]  #0: 0000000077862d44 ((wq_=
completion)"events"){+.+.}, at: process_one_work+0x747/0x1490
Mar 26 13:39:32 kaveri kernel: [ 2593.570155]  #1: 00000000db90eddb ((wor=
k_completion)(&(&sched->work_tdr)->work)){+.+.}, at: process_one_work+0x7=
7b/0x1490
Mar 26 13:39:32 kaveri kernel: [ 2593.570160]  #2: 00000000baea80e0 (&ade=
v->lock_reset){+.+.}, at: amdgpu_device_lock_adev+0x17/0xa0 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.570233]  #3: 00000000d185855f (&(&s=
ched->job_list_lock)->rlock){-.-.}, at: drm_sched_stop+0x57/0x390 [gpu_sc=
hed]
Mar 26 13:39:32 kaveri kernel: [ 2593.570240]=20
Mar 26 13:39:32 kaveri kernel: [ 2593.570240] stack backtrace:
Mar 26 13:39:32 kaveri kernel: [ 2593.570245] CPU: 7 PID: 29967 Comm: kwo=
rker/7:4 Tainted: G        W  OE     5.0.0-rc1-00651-g4a93cf78b903 #121
Mar 26 13:39:32 kaveri kernel: [ 2593.570249] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Mar 26 13:39:32 kaveri kernel: [ 2593.570254] Workqueue: events drm_sched=
_job_timedout [gpu_sched]
Mar 26 13:39:32 kaveri kernel: [ 2593.570257] Call Trace:
Mar 26 13:39:32 kaveri kernel: [ 2593.570263]  dump_stack+0x7c/0xc0
Mar 26 13:39:32 kaveri kernel: [ 2593.570268]  print_circular_bug.isra.33=
=2Ecold.50+0x1bc/0x279
Mar 26 13:39:32 kaveri kernel: [ 2593.570271]  ? save_trace+0xd6/0x250
Mar 26 13:39:32 kaveri kernel: [ 2593.570275]  __lock_acquire+0x2f8e/0x46=
50
Mar 26 13:39:32 kaveri kernel: [ 2593.570280]  ? mark_held_locks+0x140/0x=
140
Mar 26 13:39:32 kaveri kernel: [ 2593.570284]  ? mark_held_locks+0x140/0x=
140
Mar 26 13:39:32 kaveri kernel: [ 2593.570287]  ? lockdep_hardirqs_on+0x37=
c/0x560
Mar 26 13:39:32 kaveri kernel: [ 2593.570292]  ? _raw_spin_unlock_irq+0x2=
9/0x30
Mar 26 13:39:32 kaveri kernel: [ 2593.570295]  ? migrate_swap+0x270/0x270=

Mar 26 13:39:32 kaveri kernel: [ 2593.570299]  lock_acquire+0x103/0x2c0
Mar 26 13:39:32 kaveri kernel: [ 2593.570302]  ? dma_fence_remove_callbac=
k+0x41/0x210
Mar 26 13:39:32 kaveri kernel: [ 2593.570306]  _raw_spin_lock_irqsave+0x2=
e/0x40
Mar 26 13:39:32 kaveri kernel: [ 2593.570309]  ? dma_fence_remove_callbac=
k+0x41/0x210
Mar 26 13:39:32 kaveri kernel: [ 2593.570312]  dma_fence_remove_callback+=
0x41/0x210
Mar 26 13:39:32 kaveri kernel: [ 2593.570318]  drm_sched_stop+0x1c5/0x390=
 [gpu_sched]
Mar 26 13:39:32 kaveri kernel: [ 2593.570390]  amdgpu_device_pre_asic_res=
et+0xab/0x8d0 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.570463]  amdgpu_device_gpu_recover+=
0x12f/0x15c0 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.570538]  ? amdgpu_device_should_rec=
over_gpu+0x100/0x100 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.570610]  ? amdgpu_device_ip_check_s=
oft_reset+0x99/0x330 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.570614]  ? _raw_spin_unlock_irqrest=
ore+0x3c/0x50
Mar 26 13:39:32 kaveri kernel: [ 2593.570707]  amdgpu_job_timedout+0x31d/=
0x460 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.570801]  ? amdgpu_cgs_destroy_devic=
e+0x10/0x10 [amdgpu]
Mar 26 13:39:32 kaveri kernel: [ 2593.570805]  ? __lock_is_held+0xad/0x14=
0
Mar 26 13:39:32 kaveri kernel: [ 2593.570811]  drm_sched_job_timedout+0xa=
e/0x110 [gpu_sched]
Mar 26 13:39:32 kaveri kernel: [ 2593.570815]  process_one_work+0x815/0x1=
490
Mar 26 13:39:32 kaveri kernel: [ 2593.570819]  ? apply_wqattrs_commit+0x3=
80/0x380
Mar 26 13:39:32 kaveri kernel: [ 2593.570822]  ? do_raw_spin_lock+0x120/0=
x290
Mar 26 13:39:32 kaveri kernel: [ 2593.570827]  worker_thread+0x87/0xb10
Mar 26 13:39:32 kaveri kernel: [ 2593.570832]  ? __kthread_parkme+0x82/0x=
f0
Mar 26 13:39:32 kaveri kernel: [ 2593.570835]  ? process_one_work+0x1490/=
0x1490
Mar 26 13:39:32 kaveri kernel: [ 2593.570838]  kthread+0x2e2/0x3a0
Mar 26 13:39:32 kaveri kernel: [ 2593.570841]  ? kthread_create_on_node+0=
xc0/0xc0
Mar 26 13:39:32 kaveri kernel: [ 2593.570845]  ret_from_fork+0x27/0x50

--------------EBCB1E26CBB2763AD1CA931A
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--------------EBCB1E26CBB2763AD1CA931A--

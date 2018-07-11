From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: DEBUG_LOCKS_WARN_ON(sem->owner != ((struct task_struct *)(1UL << 0)))
Date: Wed, 11 Jul 2018 18:11:46 +0200
Message-ID: <cacdbfb1-1760-518c-6a52-94fbd11748c5@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------5E797B75683861BBE415B8EF"
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
--------------5E797B75683861BBE415B8EF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


I've been occasionally getting the debugging warnings seen in the
attached kernel log excerpt. Only for piglit amd_pinned_memory and for
libdrm amdgpu_test, so I suspect it's pointing at a userptr related
issue. Christian, any ideas?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------5E797B75683861BBE415B8EF
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Jul  9 16:33:10 kaveri kernel: [ 1048.706008] DEBUG_LOCKS_WARN_ON(sem->ow=
ner !=3D ((struct task_struct *)(1UL << 0)))
Jul  9 16:33:10 kaveri kernel: [ 1048.706023] WARNING: CPU: 13 PID: 19903=
 at kernel/locking/rwsem.c:217 up_read_non_owner+0xd5/0x100
Jul  9 16:33:10 kaveri kernel: [ 1048.706029] Modules linked in: lz4(E) l=
z4_compress(E) cpufreq_powersave(E) cpufreq_userspace(E) cpufreq_conserva=
tive(E) binfmt_misc(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) edac_mce_=
amd(E) amdkfd(OE) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E)=
 snd_hda_codec_realtek(E) ghash_clmulni_intel(E) amdgpu(OE) wmi_bmof(E) r=
adeon(OE) snd_hda_codec_generic(E) pcbc(E) snd_hda_codec_hdmi(E) snd_hda_=
intel(E) chash(OE) snd_hda_codec(E) gpu_sched(OE) ttm(OE) snd_hda_core(E)=
 snd_hwdep(E) drm_kms_helper(OE) efi_pstore(E) aesni_intel(E) aes_x86_64(=
E) drm(OE) crypto_simd(E) snd_pcm(E) cryptd(E) r8169(E) i2c_algo_bit(E) g=
lue_helper(E) pcspkr(E) efivars(E) k10temp(E) snd_timer(E) fb_sys_fops(E)=
 mii(E) sg(E) ccp(E) syscopyarea(E) sp5100_tco(E) snd(E) sysfillrect(E) s=
ysimgblt(E) soundcore(E) rng_core(E) i2c_piix4(E)
Jul  9 16:33:10 kaveri kernel: [ 1048.706126]  wmi(E) button(E) acpi_cpuf=
req(E) tcp_bbr(E) sch_fq(E) nct6775(E) hwmon_vid(E) sunrpc(E) efivarfs(E)=
 ip_tables(E) x_tables(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) j=
bd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) multipath(E) lin=
ear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) hid(E) ahci(=
E) libahci(E) xhci_pci(E) libata(E) xhci_hcd(E) crc32c_intel(E) scsi_mod(=
E) usbcore(E) gpio_amdpt(E) gpio_generic(E)
Jul  9 16:33:10 kaveri kernel: [ 1048.706191] CPU: 13 PID: 19903 Comm: am=
d_pinned_memo Tainted: G        W  OE     4.18.0-rc1+ #110
Jul  9 16:33:10 kaveri kernel: [ 1048.706195] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Jul  9 16:33:10 kaveri kernel: [ 1048.706202] RIP: 0010:up_read_non_owner=
+0xd5/0x100
Jul  9 16:33:10 kaveri kernel: [ 1048.706205] Code: e0 07 83 c0 03 38 d0 =
7c 04 84 d2 75 2b 8b 05 32 e5 d8 03 85 c0 75 a8 48 c7 c6 e0 43 47 a2 48 c=
7 c7 40 44 47 a2 e8 3b 99 ee ff <0f> 0b eb 91 e8 52 49 43 00 e9 57 ff ff =
ff e8 48 49 43 00 eb ce e8=20
Jul  9 16:33:10 kaveri kernel: [ 1048.706289] RSP: 0000:ffff8803ddc37ab8 =
EFLAGS: 00010286
Jul  9 16:33:10 kaveri kernel: [ 1048.706295] RAX: 0000000000000000 RBX: =
ffff8803ce344580 RCX: ffffffffa0c4d5e0
Jul  9 16:33:10 kaveri kernel: [ 1048.706299] RDX: 0000000000000000 RSI: =
0000000000000008 RDI: ffff8803ee35ea90
Jul  9 16:33:10 kaveri kernel: [ 1048.706303] RBP: ffff8803ddc37b10 R08: =
ffffed007dc6bd53 R09: ffffed007dc6bd53
Jul  9 16:33:10 kaveri kernel: [ 1048.706308] R10: 0000000000000001 R11: =
ffffed007dc6bd52 R12: 0000559fbdfcb000
Jul  9 16:33:10 kaveri kernel: [ 1048.706311] R13: 0000559fbdfcc000 R14: =
0000000000000001 R15: dffffc0000000000
Jul  9 16:33:10 kaveri kernel: [ 1048.706316] FS:  00007fc20c5207c0(0000)=
 GS:ffff8803ee340000(0000) knlGS:0000000000000000
Jul  9 16:33:10 kaveri kernel: [ 1048.706320] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Jul  9 16:33:10 kaveri kernel: [ 1048.706324] CR2: 0000559fbdfcb000 CR3: =
00000003e8fae000 CR4: 00000000003406e0
Jul  9 16:33:10 kaveri kernel: [ 1048.706327] Call Trace:
Jul  9 16:33:10 kaveri kernel: [ 1048.706337]  __mmu_notifier_invalidate_=
range_end+0x14f/0x210
Jul  9 16:33:10 kaveri kernel: [ 1048.706346]  wp_page_copy+0xc1d/0x1790
Jul  9 16:33:10 kaveri kernel: [ 1048.706355]  ? __do_fault+0x310/0x310
Jul  9 16:33:10 kaveri kernel: [ 1048.706361]  ? __lock_acquire+0x605/0x3=
670
Jul  9 16:33:10 kaveri kernel: [ 1048.706370]  do_wp_page+0x422/0x1b10
Jul  9 16:33:10 kaveri kernel: [ 1048.706376]  ? lock_acquire+0x10b/0x330=

Jul  9 16:33:10 kaveri kernel: [ 1048.706381]  ? finish_mkwrite_fault+0x5=
60/0x560
Jul  9 16:33:10 kaveri kernel: [ 1048.706391]  __handle_mm_fault+0x1b22/0=
x3130
Jul  9 16:33:10 kaveri kernel: [ 1048.706398]  ? finish_task_switch+0x11f=
/0x670
Jul  9 16:33:10 kaveri kernel: [ 1048.706403]  ? __pmd_alloc+0x430/0x430
Jul  9 16:33:10 kaveri kernel: [ 1048.706409]  ? find_held_lock+0x32/0x1c=
0
Jul  9 16:33:10 kaveri kernel: [ 1048.706421]  ? mark_held_locks+0xa8/0xf=
0
Jul  9 16:33:10 kaveri kernel: [ 1048.706426]  ? handle_mm_fault+0x17e/0x=
7a0
Jul  9 16:33:10 kaveri kernel: [ 1048.706433]  handle_mm_fault+0x257/0x7a=
0
Jul  9 16:33:10 kaveri kernel: [ 1048.706442]  __do_page_fault+0x47f/0xa8=
0
Jul  9 16:33:10 kaveri kernel: [ 1048.706450]  ? retint_user+0x18/0x18
Jul  9 16:33:10 kaveri kernel: [ 1048.706455]  ? mm_fault_error+0x2d0/0x2=
d0
Jul  9 16:33:10 kaveri kernel: [ 1048.706461]  ? page_fault+0x8/0x30
Jul  9 16:33:10 kaveri kernel: [ 1048.706466]  ? trace_hardirqs_off_thunk=
+0x1a/0x1c
Jul  9 16:33:10 kaveri kernel: [ 1048.706473]  ? page_fault+0x8/0x30
Jul  9 16:33:10 kaveri kernel: [ 1048.706479]  page_fault+0x1e/0x30
Jul  9 16:33:10 kaveri kernel: [ 1048.706484] RIP: 0033:0x7fc20fae3357
Jul  9 16:33:10 kaveri kernel: [ 1048.706487] Code: 47 20 c5 fe 7f 44 17 =
c0 c5 fe 7f 47 40 c5 fe 7f 44 17 a0 c5 fe 7f 47 60 c5 fe 7f 44 17 80 48 0=
1 fa 48 83 e2 80 48 39 d1 74 ba <c5> fd 7f 01 c5 fd 7f 41 20 c5 fd 7f 41 =
40 c5 fd 7f 41 60 48 81 c1=20
Jul  9 16:33:10 kaveri kernel: [ 1048.706570] RSP: 002b:00007ffe17619218 =
EFLAGS: 00010206
Jul  9 16:33:10 kaveri kernel: [ 1048.706575] RAX: 0000559fbdfc8010 RBX: =
0000000000029000 RCX: 0000559fbdfcb000
Jul  9 16:33:10 kaveri kernel: [ 1048.706579] RDX: 0000559fbdfeb800 RSI: =
0000000000000000 RDI: 0000559fbdfc8010
Jul  9 16:33:10 kaveri kernel: [ 1048.706583] RBP: 00000000000237f8 R08: =
0000559fbdfc8010 R09: 0000559fbdfc0870
Jul  9 16:33:10 kaveri kernel: [ 1048.706586] R10: 0000000000000000 R11: =
0000000000000004 R12: 00007fc20fb449d8
Jul  9 16:33:10 kaveri kernel: [ 1048.706590] R13: 0000559fbdfc8000 R14: =
00007fc20fb3fc40 R15: 00007ffe176192c0
Jul  9 16:33:10 kaveri kernel: [ 1048.706601] irq event stamp: 109699
Jul  9 16:33:10 kaveri kernel: [ 1048.706608] hardirqs last  enabled at (=
109699): [<ffffffffa0eab8ed>] mem_cgroup_commit_charge+0xbd/0xed0
Jul  9 16:33:10 kaveri kernel: [ 1048.706613] hardirqs last disabled at (=
109698): [<ffffffffa0eab8cc>] mem_cgroup_commit_charge+0x9c/0xed0
Jul  9 16:33:10 kaveri kernel: [ 1048.706619] softirqs last  enabled at (=
107488): [<ffffffffa2200620>] __do_softirq+0x620/0x919
Jul  9 16:33:10 kaveri kernel: [ 1048.706625] softirqs last disabled at (=
107471): [<ffffffffa093443e>] irq_exit+0x19e/0x1d0

--------------5E797B75683861BBE415B8EF
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------5E797B75683861BBE415B8EF--

From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: kernel BUG at drivers/gpu/drm//ttm/ttm_bo.c:196!
Date: Tue, 5 Feb 2019 16:02:55 +0100
Message-ID: <b1448d56-5dc4-d3f4-db04-e7993533240b@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------EEFFEF4FAA9B8CB77B531368"
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
--------------EEFFEF4FAA9B8CB77B531368
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Hit this with an amdgpu piglit run today, see the attached dmesg
excerpt. It's ttm_bo_ref_bug() being called from ttm_bo_del_from_lru().
Maybe this is still fallout from the "cleanup setting bulk_movable" change?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------EEFFEF4FAA9B8CB77B531368
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Feb  5 15:20:59 kaveri kernel: [ 2006.806877] kernel BUG at drivers/gpu/d=
rm//ttm/ttm_bo.c:196!
Feb  5 15:20:59 kaveri kernel: [ 2006.806909] invalid opcode: 0000 [#1] S=
MP KASAN NOPTI
Feb  5 15:20:59 kaveri kernel: [ 2006.806922] CPU: 14 PID: 4058 Comm: sha=
der_runner Tainted: G           OE     5.0.0-rc1-00261-gbbf48cae572b #119=

Feb  5 15:20:59 kaveri kernel: [ 2006.806929] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Feb  5 15:20:59 kaveri kernel: [ 2006.806941] RIP: 0010:ttm_bo_ref_bug.co=
nstprop.20+0x5/0x10 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.806945] Code: d3 8b 54 24 04 8b 34 =
24 e9 74 ff ff ff 48 89 ef e8 60 37 cf d3 eb bd 66 66 2e 0f 1f 84 00 00 0=
0 00 00 0f 1f 00 0f 1f 44 00 00 <0f> 0b 66 0f 1f 84 00 00 00 00 00 0f 1f =
44 00 00 41 55 49 89 fd 41
Feb  5 15:20:59 kaveri kernel: [ 2006.806948] RSP: 0000:ffff88819449f670 =
EFLAGS: 00010202
Feb  5 15:20:59 kaveri kernel: [ 2006.806952] RAX: 0000000000000001 RBX: =
ffff88810d4e5dd0 RCX: 0000000000000000
Feb  5 15:20:59 kaveri kernel: [ 2006.806954] RDX: dffffc0000000000 RSI: =
0000000000000004 RDI: ffff88819449f608
Feb  5 15:20:59 kaveri kernel: [ 2006.806957] RBP: ffff88810d4e5e78 R08: =
ffffed1032893ec2 R09: ffffed1032893ec1
Feb  5 15:20:59 kaveri kernel: [ 2006.806959] R10: ffffed1032893ec1 R11: =
0000000000000003 R12: ffff888328562bf0
Feb  5 15:20:59 kaveri kernel: [ 2006.806967] R13: ffff88810d4e5dfc R14: =
ffff88810d4e5e80 R15: ffff8881427eef78
Feb  5 15:20:59 kaveri kernel: [ 2006.806976] FS:  00007f8d74113000(0000)=
 GS:ffff88837e180000(0000) knlGS:0000000000000000
Feb  5 15:20:59 kaveri kernel: [ 2006.806987] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Feb  5 15:20:59 kaveri kernel: [ 2006.806995] CR2: 00007f8d6c160210 CR3: =
000000019f0f4000 CR4: 00000000003406e0
Feb  5 15:20:59 kaveri kernel: [ 2006.806998] Call Trace:
Feb  5 15:20:59 kaveri kernel: [ 2006.807009]  ttm_bo_del_from_lru+0x2f9/=
0x430 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807022]  ttm_bo_swapout+0x1fc/0x680=
 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807035]  ? ttm_bo_unmap_virtual+0x9=
0/0x90 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807046]  ? .slowpath+0xe/0xe
Feb  5 15:20:59 kaveri kernel: [ 2006.807051]  ? native_queued_spin_lock_=
slowpath+0x5b1/0x8b0
Feb  5 15:20:59 kaveri kernel: [ 2006.807062]  ? find_held_lock+0x33/0x1c=
0
Feb  5 15:20:59 kaveri kernel: [ 2006.807070]  ? ttm_shrink+0x16c/0x210 [=
ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807078]  ? lock_downgrade+0x5d0/0x5=
d0
Feb  5 15:20:59 kaveri kernel: [ 2006.807088]  ? security_capable+0x54/0x=
90
Feb  5 15:20:59 kaveri kernel: [ 2006.807100]  ttm_shrink+0x18a/0x210 [tt=
m]
Feb  5 15:20:59 kaveri kernel: [ 2006.807116]  ttm_mem_global_alloc_zone+=
0x1b7/0x2f0 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807130]  ttm_pool_populate+0x52c/0x=
ae0 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807144]  ? ttm_pool_unpopulate+0x40=
/0x40 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807147]  ? lock_downgrade+0x5d0/0x5=
d0
Feb  5 15:20:59 kaveri kernel: [ 2006.807153]  ? mutex_lock_interruptible=
_nested+0x20/0x20
Feb  5 15:20:59 kaveri kernel: [ 2006.807165]  ttm_populate_and_map_pages=
+0x2a/0x7d0 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807251]  ? amdgpu_bo_move_notify+0x=
310/0x310 [amdgpu]
Feb  5 15:20:59 kaveri kernel: [ 2006.807261]  ttm_tt_populate.part.8+0x8=
b/0x2c0 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807270]  ? ttm_mem_io_reserve_vm+0x=
be/0x2f0 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807276]  ? mutex_trylock+0x167/0x1a=
0
Feb  5 15:20:59 kaveri kernel: [ 2006.807286]  ttm_bo_vm_fault+0x777/0x12=
90 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807300]  ? ttm_bo_vm_access+0x680/0=
x680 [ttm]
Feb  5 15:20:59 kaveri kernel: [ 2006.807372]  ? amdgpu_drm_ioctl+0xf7/0x=
1b0 [amdgpu]
Feb  5 15:20:59 kaveri kernel: [ 2006.807384]  ? mark_held_locks+0x140/0x=
140
Feb  5 15:20:59 kaveri kernel: [ 2006.807394]  __do_fault+0x80/0x320
Feb  5 15:20:59 kaveri kernel: [ 2006.807402]  __handle_mm_fault+0x2011/0=
x39f0
Feb  5 15:20:59 kaveri kernel: [ 2006.807409]  ? trace_hardirqs_on_thunk+=
0x1a/0x1c
Feb  5 15:20:59 kaveri kernel: [ 2006.807415]  ? vmf_insert_mixed_mkwrite=
+0x10/0x10
Feb  5 15:20:59 kaveri kernel: [ 2006.807422]  ? find_held_lock+0x33/0x1c=
0
Feb  5 15:20:59 kaveri kernel: [ 2006.807432]  ? mark_held_locks+0xc1/0x1=
40
Feb  5 15:20:59 kaveri kernel: [ 2006.807438]  ? handle_mm_fault+0x4e7/0x=
750
Feb  5 15:20:59 kaveri kernel: [ 2006.807446]  handle_mm_fault+0x23f/0x75=
0
Feb  5 15:20:59 kaveri kernel: [ 2006.807455]  __do_page_fault+0x402/0x9e=
0
Feb  5 15:20:59 kaveri kernel: [ 2006.807463]  ? page_fault+0x8/0x30
Feb  5 15:20:59 kaveri kernel: [ 2006.807470]  page_fault+0x1e/0x30
Feb  5 15:20:59 kaveri kernel: [ 2006.807474] RIP: 0033:0x7f8d7366bf8d
Feb  5 15:20:59 kaveri kernel: [ 2006.807480] Code: e3 d7 ff 66 2e 0f 1f =
84 00 00 00 00 00 48 8b 87 c8 03 00 00 8b 10 8d 4a 04 3b 48 04 77 6d 48 8=
b 48 08 8d 72 01 45 31 c0 89 30 <c7> 04 91 00 69 02 c0 8b 10 8d 72 01 89 =
30 c7 04 91 e5 02 00 00 66
Feb  5 15:20:59 kaveri kernel: [ 2006.807483] RSP: 002b:00007ffdd55743a8 =
EFLAGS: 00010246
Feb  5 15:20:59 kaveri kernel: [ 2006.807488] RAX: 0000560fa3c62740 RBX: =
0000560fa3c51f90 RCX: 00007f8d6c160200
Feb  5 15:20:59 kaveri kernel: [ 2006.807493] RDX: 0000000000000004 RSI: =
0000000000000005 RDI: 0000560fa3c51f90
Feb  5 15:20:59 kaveri kernel: [ 2006.807496] RBP: 00007ffdd5574430 R08: =
0000000000000000 R09: 0000560fa3c52d18
Feb  5 15:20:59 kaveri kernel: [ 2006.807498] R10: 0000000000000002 R11: =
0000000000000000 R12: 00000000000feab8
Feb  5 15:20:59 kaveri kernel: [ 2006.807503] R13: 0000000000000004 R14: =
00000000ffffffff R15: 00000000000feabc
Feb  5 15:20:59 kaveri kernel: [ 2006.807514] Modules linked in: fuse(E) =
ipt_MASQUERADE(E) nf_conntrack_netlink(E) nfnetlink(E) xfrm_user(E) xfrm_=
algo(E) iptable_nat(E) nf_nat_ipv4(E) xt_addrtype(E) iptable_filter(E) bp=
filter(E) xt_conntrack(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_=
defrag_ipv4(E) libcrc32c(E) br_netfilter(E) bridge(E) stp(E) llc(E) overl=
ay(E) lz4(E) lz4_compress(E) cpufreq_powersave(E) cpufreq_userspace(E) cp=
ufreq_conservative(E) binfmt_misc(E) sunrpc(E) amdgpu(OE) nls_ascii(E) nl=
s_cp437(E) vfat(E) fat(E) chash(OE) gpu_sched(OE) edac_mce_amd(E) kvm(E) =
irqbypass(E) radeon(OE) crct10dif_pclmul(E) crc32_pclmul(E) snd_hda_codec=
_realtek(E) snd_hda_codec_generic(E) ttm(OE) ghash_clmulni_intel(E) ledtr=
ig_audio(E) snd_hda_codec_hdmi(E) wmi_bmof(E) aesni_intel(E) drm_kms_help=
er(OE) snd_hda_intel(E) aes_x86_64(E) crypto_simd(E) efi_pstore(E) snd_hd=
a_codec(E) sg(E) realtek(E) cryptd(E) drm(OE) glue_helper(E) snd_hda_core=
(E) snd_hwdep(E) snd_pcm(E) pcspkr(E) r8169(E) sp5100_tco(E) efivars(E) i=
2c_algo_bit(E)
Feb  5 15:20:59 kaveri kernel: [ 2006.807577]  snd_timer(E) libphy(E) fb_=
sys_fops(E) k10temp(E) syscopyarea(E) i2c_piix4(E) sysfillrect(E) ccp(E) =
sysimgblt(E) snd(E) soundcore(E) rng_core(E) wmi(E) pcc_cpufreq(E) acpi_c=
pufreq(E) button(E) tcp_bbr(E) sch_fq(E) nct6775(E) hwmon_vid(E) efivarfs=
(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E=
) mbcache(E) jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) mu=
ltipath(E) linear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E=
) hid(E) ahci(E) xhci_pci(E) libahci(E) xhci_hcd(E) libata(E) crc32c_inte=
l(E) usbcore(E) scsi_mod(E) gpio_amdpt(E) gpio_generic(E)

--------------EEFFEF4FAA9B8CB77B531368
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------EEFFEF4FAA9B8CB77B531368--

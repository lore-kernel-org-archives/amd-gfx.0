From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: Fix vce initialize failed on
 Kaveri/Mullins
Date: Thu, 23 Aug 2018 12:58:39 +0200
Message-ID: <db4ce08a-3f23-410d-9738-ff1d800bae31@daenzer.net>
References: <1535016296-16215-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------77383B6C5726F969E92D7A21"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1535016296-16215-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------77383B6C5726F969E92D7A21
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2018-08-23 11:24 a.m., Rex Zhu wrote:
> Forgot to add vce pg support via smu for Kaveri/Mullins.
> 
> Regresstion issue caused by
> 'commit 561a5c83eadd ("drm/amd/pp: Unify powergate_uvd/vce/mmhub
> to set_powergating_by_smu")'

You can replace this paragraph with

Fixes: 561a5c83eadd ("drm/amd/pp: Unify powergate_uvd/vce/mmhub
                      to set_powergating_by_smu")


This patch fixes the VCE ring (and also IB) test on this laptop, thanks!

Unfortunately though, there's still an oops if I let the amdkfd driver
load together with amdgpu (no issue when loading amdkfd manually later),
see the attached kernel.log excerpt. This is also a regression in the
4.19 drm tree changes. It might be a separate issue, but TBH I don't
feel like another day or two bisecting right now. :)


Anyway, this series is

Tested-by: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------77383B6C5726F969E92D7A21
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Aug 23 12:25:30 thor kernel: [  200.456163] [drm] amdgpu kernel modesetti=
ng enabled.
Aug 23 12:25:30 thor kernel: [  200.465731] Parsing CRAT table with 1 nod=
es
Aug 23 12:25:30 thor kernel: [  200.465741] Creating topology SYSFS entri=
es
Aug 23 12:25:30 thor kernel: [  200.465786] Topology: Add APU node [0x0:0=
x0]
Aug 23 12:25:30 thor kernel: [  200.465789] Finished initializing topolog=
y
Aug 23 12:25:30 thor kernel: [  200.465853] kfd kfd: Initialized module
Aug 23 12:25:30 thor kernel: [  200.466288] checking generic (c0000000 30=
0000) vs hw (c0000000 10000000)
Aug 23 12:25:30 thor kernel: [  200.466296] fb: switching to amdgpudrmfb =
from EFI VGA
Aug 23 12:25:30 thor kernel: [  200.466418] Console: switching to colour =
dummy device 80x25
Aug 23 12:25:30 thor kernel: [  200.467646] [drm] initializing kernel mod=
esetting (KAVERI 0x1002:0x130A 0x103C:0x2234 0x00).
Aug 23 12:25:30 thor kernel: [  200.468031] [drm] register mmio base: 0xD=
6800000
Aug 23 12:25:30 thor kernel: [  200.468035] [drm] register mmio size: 262=
144
Aug 23 12:25:30 thor kernel: [  200.468058] [drm] add ip block number 0 <=
cik_common>
Aug 23 12:25:30 thor kernel: [  200.468062] [drm] add ip block number 1 <=
gmc_v7_0>
Aug 23 12:25:30 thor kernel: [  200.468064] [drm] add ip block number 2 <=
cik_ih>
Aug 23 12:25:30 thor kernel: [  200.468067] [drm] add ip block number 3 <=
kv_dpm>
Aug 23 12:25:30 thor kernel: [  200.468071] [drm] add ip block number 4 <=
dce_v8_0>
Aug 23 12:25:30 thor kernel: [  200.468074] [drm] add ip block number 5 <=
gfx_v7_0>
Aug 23 12:25:30 thor kernel: [  200.468077] [drm] add ip block number 6 <=
cik_sdma>
Aug 23 12:25:30 thor kernel: [  200.468080] [drm] add ip block number 7 <=
uvd_v4_2>
Aug 23 12:25:30 thor kernel: [  200.468082] [drm] add ip block number 8 <=
vce_v2_0>
Aug 23 12:25:30 thor kernel: [  200.501755] [drm] BIOS signature incorrec=
t 0 0
Aug 23 12:25:30 thor kernel: [  200.501804] resource sanity check: reques=
ting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [=
mem 0x000c0000-0x000c3fff window]
Aug 23 12:25:30 thor kernel: [  200.501812] caller pci_map_rom+0x58/0xe0 =
mapping multiple BARs
Aug 23 12:25:30 thor kernel: [  200.503187] ATOM BIOS: BR45464.001
Aug 23 12:25:30 thor kernel: [  200.503219] [drm] GPU posting now...
Aug 23 12:25:31 thor kernel: [  200.966309] [drm] vm size is 64 GB, 2 lev=
els, block size is 10-bit, fragment size is 9-bit
Aug 23 12:25:31 thor kernel: [  200.966329] amdgpu 0000:00:01.0: VRAM: 10=
24M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
Aug 23 12:25:31 thor kernel: [  200.966333] amdgpu 0000:00:01.0: GART: 10=
24M 0x0000000000000000 - 0x000000003FFFFFFF
Aug 23 12:25:31 thor kernel: [  200.966352] [drm] Detected VRAM RAM=3D102=
4M, BAR=3D1024M
Aug 23 12:25:31 thor kernel: [  200.966354] [drm] RAM width 128bits UNKNO=
WN
Aug 23 12:25:31 thor kernel: [  200.966695] [TTM] Zone  kernel: Available=
 graphics memory: 3568742 kiB
Aug 23 12:25:31 thor kernel: [  200.966702] [TTM] Zone   dma32: Available=
 graphics memory: 2097152 kiB
Aug 23 12:25:31 thor kernel: [  200.966705] [TTM] Initializing pool alloc=
ator
Aug 23 12:25:31 thor kernel: [  200.966714] [TTM] Initializing DMA pool a=
llocator
Aug 23 12:25:31 thor kernel: [  200.966799] [drm] amdgpu: 1024M of VRAM m=
emory ready
Aug 23 12:25:31 thor kernel: [  200.966803] [drm] amdgpu: 3072M of GTT me=
mory ready.
Aug 23 12:25:31 thor kernel: [  200.966842] [drm] GART: num cpu pages 262=
144, num gpu pages 262144
Aug 23 12:25:31 thor kernel: [  200.967622] [drm] PCIE GART of 1024M enab=
led (table at 0x000000F400000000).
Aug 23 12:25:31 thor kernel: [  200.967771] [drm] Supports vblank timesta=
mp caching Rev 2 (21.10.2013).
Aug 23 12:25:31 thor kernel: [  200.967774] [drm] Driver supports precise=
 vblank timestamp query.
Aug 23 12:25:31 thor kernel: [  200.967803] [drm] Internal thermal contro=
ller without fan control
Aug 23 12:25:31 thor kernel: [  200.967806] [drm] amdgpu: dpm initialized=

Aug 23 12:25:31 thor kernel: [  200.969641] [drm] amdgpu atom DIG backlig=
ht initialized
Aug 23 12:25:31 thor kernel: [  200.969644] [drm] AMDGPU Display Connecto=
rs
Aug 23 12:25:31 thor kernel: [  200.969647] [drm] Connector 0:
Aug 23 12:25:31 thor kernel: [  200.969649] [drm]   VGA-1
Aug 23 12:25:31 thor kernel: [  200.969651] [drm]   HPD2
Aug 23 12:25:31 thor kernel: [  200.969654] [drm]   DDC: 0x1950 0x1950 0x=
1951 0x1951 0x1952 0x1952 0x1953 0x1953
Aug 23 12:25:31 thor kernel: [  200.969656] [drm]   Encoders:
Aug 23 12:25:31 thor kernel: [  200.969658] [drm]     CRT1: INTERNAL_UNIP=
HY2
Aug 23 12:25:31 thor kernel: [  200.969660] [drm]     CRT1: NUTMEG
Aug 23 12:25:31 thor kernel: [  200.969662] [drm] Connector 1:
Aug 23 12:25:31 thor kernel: [  200.969664] [drm]   HDMI-A-1
Aug 23 12:25:31 thor kernel: [  200.969665] [drm]   HPD3
Aug 23 12:25:31 thor kernel: [  200.969668] [drm]   DDC: 0x1954 0x1954 0x=
1955 0x1955 0x1956 0x1956 0x1957 0x1957
Aug 23 12:25:31 thor kernel: [  200.969670] [drm]   Encoders:
Aug 23 12:25:31 thor kernel: [  200.969672] [drm]     DFP1: INTERNAL_UNIP=
HY2
Aug 23 12:25:31 thor kernel: [  200.969674] [drm] Connector 2:
Aug 23 12:25:31 thor kernel: [  200.969675] [drm]   eDP-1
Aug 23 12:25:31 thor kernel: [  200.969677] [drm]   HPD1
Aug 23 12:25:31 thor kernel: [  200.969680] [drm]   DDC: 0x194c 0x194c 0x=
194d 0x194d 0x194e 0x194e 0x194f 0x194f
Aug 23 12:25:31 thor kernel: [  200.969681] [drm]   Encoders:
Aug 23 12:25:31 thor kernel: [  200.969683] [drm]     LCD1: INTERNAL_UNIP=
HY
Aug 23 12:25:31 thor kernel: [  200.985682] [drm] Found UVD firmware Vers=
ion: 1.64 Family ID: 9
Aug 23 12:25:31 thor kernel: [  200.987446] [drm] Found VCE firmware Vers=
ion: 50.10 Binary ID: 2
Aug 23 12:25:31 thor kernel: [  201.078820] [drm] UVD initialized success=
fully.
Aug 23 12:25:31 thor kernel: [  201.189125] [drm] VCE initialized success=
fully.
Aug 23 12:25:31 thor kernel: [  201.195461] kfd kfd: Allocated 3969056 by=
tes on gart
Aug 23 12:25:31 thor kernel: [  201.195533] BUG: unable to handle kernel =
NULL pointer dereference at 000000000000003c
Aug 23 12:25:31 thor kernel: [  201.195539] PGD 0 P4D 0=20
Aug 23 12:25:31 thor kernel: [  201.195549] Oops: 0000 [#1] SMP NOPTI
Aug 23 12:25:31 thor kernel: [  201.195557] CPU: 3 PID: 4342 Comm: modpro=
be Tainted: G        W  OE     4.18.3+ #326
Aug 23 12:25:31 thor kernel: [  201.195562] Hardware name: Hewlett-Packar=
d HP ProBook 455 G2/2235, BIOS M75 Ver. 01.42 09/26/2016
Aug 23 12:25:31 thor kernel: [  201.195625] RIP: 0010:amdgpu_kv_copy_byte=
s_to_smc+0x8cb/0x44d0 [amdgpu]
Aug 23 12:25:31 thor kernel: [  201.195629] Code: 1f 44 00 00 c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 70 48 00 00 48 8b 80 28 04 =
00 00 40 84 f6 74 03 8b 00 c3 <8b> 50 3c 83 ea 01 48 8d 14 52 8b 04 90 c3=
 0f 1f 80 00 00 00 00 0f=20
Aug 23 12:25:31 thor kernel: [  201.195724] RSP: 0018:ffffa0abc21e78b8 EF=
LAGS: 00010246
Aug 23 12:25:31 thor kernel: [  201.195730] RAX: 0000000000000000 RBX: ff=
ff89acb6e69000 RCX: 0000000000000000
Aug 23 12:25:31 thor kernel: [  201.195734] RDX: ffffffffc13c78d0 RSI: 00=
00000000000000 RDI: ffff89aced080000
Aug 23 12:25:31 thor kernel: [  201.195739] RBP: ffffa0abc21e78e0 R08: ff=
ff89aced080000 R09: 0000000000000000
Aug 23 12:25:31 thor kernel: [  201.195743] R10: 0000000000000000 R11: 00=
00000000000000 R12: ffff89acb7e75800
Aug 23 12:25:31 thor kernel: [  201.195747] R13: 000000000000707b R14: 00=
00000000000000 R15: 0000000000000000
Aug 23 12:25:31 thor kernel: [  201.195753] FS:  00007ff57d1b4b80(0000) G=
S:ffff89acfed80000(0000) knlGS:0000000000000000
Aug 23 12:25:31 thor kernel: [  201.195757] CS:  0010 DS: 0000 ES: 0000 C=
R0: 0000000080050033
Aug 23 12:25:31 thor kernel: [  201.195761] CR2: 000000000000003c CR3: 00=
000001d436e000 CR4: 00000000000406e0
Aug 23 12:25:31 thor kernel: [  201.195766] Call Trace:
Aug 23 12:25:31 thor kernel: [  201.195825]  get_max_engine_clock_in_mhz+=
0x2f/0x60 [amdgpu]
Aug 23 12:25:31 thor kernel: [  201.195848]  kfd_topology_add_device+0x18=
4/0x440 [amdkfd]
Aug 23 12:25:31 thor kernel: [  201.195877]  kgd2kfd_device_init+0x1a9/0x=
400 [amdkfd]
Aug 23 12:25:31 thor kernel: [  201.195931]  amdgpu_amdkfd_device_init+0x=
189/0x1c0 [amdgpu]
Aug 23 12:25:31 thor kernel: [  201.195980]  mod_color_calculate_degamma_=
curve+0x1782/0x1b7c [amdgpu]
Aug 23 12:25:31 thor kernel: [  201.195994]  ? kmalloc_order+0x14/0x40
Aug 23 12:25:31 thor kernel: [  201.196040]  amdgpu_driver_load_kms+0x86/=
0x2c0 [amdgpu]
Aug 23 12:25:31 thor kernel: [  201.196080]  drm_dev_register+0x10b/0x140=
 [drm]
Aug 23 12:25:31 thor kernel: [  201.196128]  amdgpu_drm_ioctl+0x53c/0xe40=
 [amdgpu]
Aug 23 12:25:31 thor kernel: [  201.196139]  local_pci_probe+0x41/0x90
Aug 23 12:25:31 thor kernel: [  201.196148]  pci_device_probe+0x115/0x1a0=

Aug 23 12:25:31 thor kernel: [  201.196160]  driver_probe_device+0x2da/0x=
450
Aug 23 12:25:31 thor kernel: [  201.196168]  __driver_attach+0xe1/0x110
Aug 23 12:25:31 thor kernel: [  201.196175]  ? driver_probe_device+0x450/=
0x450
Aug 23 12:25:31 thor kernel: [  201.196181]  ? driver_probe_device+0x450/=
0x450
Aug 23 12:25:31 thor kernel: [  201.196188]  bus_for_each_dev+0x79/0xc0
Aug 23 12:25:31 thor kernel: [  201.196197]  bus_add_driver+0x155/0x230
Aug 23 12:25:31 thor kernel: [  201.196203]  ? 0xffffffffc15ff000
Aug 23 12:25:31 thor kernel: [  201.196210]  driver_register+0x6b/0xb0
Aug 23 12:25:31 thor kernel: [  201.196216]  ? 0xffffffffc15ff000
Aug 23 12:25:31 thor kernel: [  201.196223]  do_one_initcall+0x5d/0x32a
Aug 23 12:25:31 thor kernel: [  201.196233]  ? kmem_cache_alloc_trace+0x2=
20/0x290
Aug 23 12:25:31 thor kernel: [  201.196239]  ? do_init_module+0x22/0x210
Aug 23 12:25:31 thor kernel: [  201.196247]  do_init_module+0x5a/0x210
Aug 23 12:25:31 thor kernel: [  201.196254]  load_module+0x19da/0x1f90
Aug 23 12:25:31 thor kernel: [  201.196268]  ? vfs_read+0x110/0x140
Aug 23 12:25:31 thor kernel: [  201.196282]  ? __do_sys_finit_module+0xa8=
/0x110
Aug 23 12:25:31 thor kernel: [  201.196287]  __do_sys_finit_module+0xa8/0=
x110
Aug 23 12:25:31 thor kernel: [  201.196302]  do_syscall_64+0x60/0x180
Aug 23 12:25:31 thor kernel: [  201.196311]  entry_SYSCALL_64_after_hwfra=
me+0x49/0xbe
Aug 23 12:25:31 thor kernel: [  201.196317] RIP: 0033:0x7ff57ce82a79
Aug 23 12:25:31 thor kernel: [  201.196320] Code: 00 f3 c3 66 2e 0f 1f 84=
 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 =
4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d df 43=
 0c 00 f7 d8 64 89 01 48=20
Aug 23 12:25:31 thor kernel: [  201.196415] RSP: 002b:00007ffcee9a9be8 EF=
LAGS: 00000246 ORIG_RAX: 0000000000000139
Aug 23 12:25:31 thor kernel: [  201.196421] RAX: ffffffffffffffda RBX: 00=
00563242004140 RCX: 00007ff57ce82a79
Aug 23 12:25:31 thor kernel: [  201.196425] RDX: 0000000000000000 RSI: 00=
005632420079f0 RDI: 000000000000000d
Aug 23 12:25:31 thor kernel: [  201.196429] RBP: 00005632420079f0 R08: 00=
00000000000000 R09: 0000000000000000
Aug 23 12:25:31 thor kernel: [  201.196433] R10: 000000000000000d R11: 00=
00000000000246 R12: 0000000000000000
Aug 23 12:25:31 thor kernel: [  201.196437] R13: 0000563242004270 R14: 00=
00000000040000 R15: 0000000000000000
Aug 23 12:25:31 thor kernel: [  201.196449] Modules linked in: amdkfd(E) =
amdgpu(OE+) chash(E) gpu_sched(E) ttm(E) drm_kms_helper(E) drm(E) i2c_alg=
o_bit(E) fb_sys_fops(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) nf_con=
ntrack_netbios_ns(E) nf_conntrack_broadcast(E) xt_CT(E) xt_tcpudp(E) ip6t=
_rpfilter(E) ip6t_REJECT(E) nf_reject_ipv6(E) ipt_REJECT(E) nf_reject_ipv=
4(E) xt_conntrack(E) pci_stub(E) vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE=
) vboxdrv(OE) ip_set(E) nfnetlink(E) ebtable_nat(E) ebtable_broute(E) bri=
dge(E) stp(E) llc(E) ip6table_nat(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(=
E) nf_nat_ipv6(E) ip6table_mangle(E) ip6table_raw(E) ip6table_security(E)=
 iptable_nat(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) nf_nat_ipv4(E) nf_=
nat(E) nf_conntrack(E) iptable_mangle(E) iptable_raw(E) iptable_security(=
E) ebtable_filter(E) ebtables(E) ip6table_filter(E)
Aug 23 12:25:31 thor kernel: [  201.196548]  ip6_tables(E) iptable_filter=
(E) bpfilter(E) lz4(E) lz4_compress(E) cpufreq_conservative(E) cpufreq_po=
wersave(E) cpufreq_userspace(E) binfmt_misc(E) cmac(E) bnep(E) nls_ascii(=
E) arc4(E) nls_cp437(E) vfat(E) fat(E) b43(E) pktcdvd(E) mac80211(E) cfg8=
0211(E) ssb(E) rtsx_pci_sdmmc(E) pcmcia(E) mmc_core(E) pcmcia_core(E) rts=
x_pci_ms(E) memstick(E) btusb(E) btrtl(E) btbcm(E) btintel(E) uvcvideo(E)=
 videobuf2_vmalloc(E) videobuf2_memops(E) bluetooth(E) videobuf2_v4l2(E) =
videobuf2_common(E) drbg(E) videodev(E) efi_pstore(E) ansi_cprng(E) media=
(E) edac_mce_amd(E) ecdh_generic(E) kvm_amd(E) ccp(E) kvm(E) irqbypass(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) hp_wmi(E) pcs=
pkr(E) sparse_keymap(E) rfkill(E) wmi_bmof(E) joydev(E) snd_hda_codec_rea=
ltek(E) snd_hda_codec_generic(E) efivars(E)
Aug 23 12:25:31 thor kernel: [  201.196658]  snd_hda_codec_hdmi(E) fam15h=
_power(E) k10temp(E) snd_hda_intel(E) snd_hda_codec(E) snd_hda_core(E) sn=
d_hwdep(E) sr_mod(E) cdrom(E) sp5100_tco(E) snd_pcm(E) i2c_piix4(E) snd_t=
imer(E) sg(E) snd(E) bcma(E) rtsx_pci(E) r8169(E) soundcore(E) mii(E) tpm=
_infineon(E) battery(E) hp_accel(E) lis3lv02d(E) input_polldev(E) tpm_tis=
(E) tpm_tis_core(E) pcc_cpufreq(E) tpm(E) rng_core(E) hp_wireless(E) acpi=
_cpufreq(E) ac(E) sch_fq_codel(E) cuse(E) fuse(E) ddcci_backlight(OE) ddc=
ci(OE) parport_pc(E) ppdev(E) lp(E) parport(E) efivarfs(E) ip_tables(E) x=
_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) fscrypto(E) dm_=
crypt(E) dm_mod(E) raid10(E) raid456(E) libcrc32c(E) crc32c_generic(E) as=
ync_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) xor(E) async_=
tx(E) raid6_pq(E) raid1(E) raid0(E)
Aug 23 12:25:31 thor kernel: [  201.196780]  multipath(E) linear(E) md_mo=
d(E) usbhid(E) hid_generic(E) hid_apple(E) hid(E) sd_mod(E) ohci_pci(E) c=
rc32c_intel(E) aesni_intel(E) aes_x86_64(E) crypto_simd(E) cryptd(E) ehci=
_pci(E) glue_helper(E) ohci_hcd(E) ehci_hcd(E) ahci(E) xhci_pci(E) psmous=
e(E) libahci(E) xhci_hcd(E) serio_raw(E) evdev(E) libata(E) usbcore(E) sc=
si_mod(E) thermal(E) wmi(E) video(E) button(E)
Aug 23 12:25:31 thor kernel: [  201.196844] CR2: 000000000000003c
Aug 23 12:25:31 thor kernel: [  201.196851] ---[ end trace 8f90de1e7cb0f4=
48 ]---
Aug 23 12:25:31 thor kernel: [  201.196902] RIP: 0010:amdgpu_kv_copy_byte=
s_to_smc+0x8cb/0x44d0 [amdgpu]
Aug 23 12:25:31 thor kernel: [  201.196906] Code: 1f 44 00 00 c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 70 48 00 00 48 8b 80 28 04 =
00 00 40 84 f6 74 03 8b 00 c3 <8b> 50 3c 83 ea 01 48 8d 14 52 8b 04 90 c3=
 0f 1f 80 00 00 00 00 0f=20
Aug 23 12:25:31 thor kernel: [  201.197001] RSP: 0018:ffffa0abc21e78b8 EF=
LAGS: 00010246
Aug 23 12:25:31 thor kernel: [  201.197006] RAX: 0000000000000000 RBX: ff=
ff89acb6e69000 RCX: 0000000000000000
Aug 23 12:25:31 thor kernel: [  201.197011] RDX: ffffffffc13c78d0 RSI: 00=
00000000000000 RDI: ffff89aced080000
Aug 23 12:25:31 thor kernel: [  201.197015] RBP: ffffa0abc21e78e0 R08: ff=
ff89aced080000 R09: 0000000000000000
Aug 23 12:25:31 thor kernel: [  201.197019] R10: 0000000000000000 R11: 00=
00000000000000 R12: ffff89acb7e75800
Aug 23 12:25:31 thor kernel: [  201.197023] R13: 000000000000707b R14: 00=
00000000000000 R15: 0000000000000000
Aug 23 12:25:31 thor kernel: [  201.197028] FS:  00007ff57d1b4b80(0000) G=
S:ffff89acfed80000(0000) knlGS:0000000000000000
Aug 23 12:25:31 thor kernel: [  201.197032] CS:  0010 DS: 0000 ES: 0000 C=
R0: 0000000080050033
Aug 23 12:25:31 thor kernel: [  201.197037] CR2: 000000000000003c CR3: 00=
000001d436e000 CR4: 00000000000406e0

--------------77383B6C5726F969E92D7A21
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------77383B6C5726F969E92D7A21--

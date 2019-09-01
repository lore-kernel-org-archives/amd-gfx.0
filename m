From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Kenel Ooops with: "drm/amdgpu: poll ras_controller_irq and
 err_event_athub_irq status" [bisected].
Date: Sun, 01 Sep 2019 20:43:35 +0200
Message-ID: <1980315.NaUcZm7eqv@eclipse>
References: <2628603.F1qxjxke30@eclipse>
 <CADnq5_OMdehS65YE3R5HcVstS20z1brnB37JidJQYM4Ck5isCA@mail.gmail.com>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1856309288=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OMdehS65YE3R5HcVstS20z1brnB37JidJQYM4Ck5isCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1856309288==
Content-Type: multipart/signed; boundary="nextPart2903080.GGqqDFrkqj"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2903080.GGqqDFrkqj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dnia niedziela, 1 wrze=C5=9Bnia 2019 19:40:25 CEST piszesz:
> On Sun, Sep 1, 2019 at 1:09 PM Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hello everyone,
> >=20
> > after today sync with amd-staging-drm-next repo my machine was hit by
> > Ooops
> > bug.
> > Maybe my google-foo is weak, but I could not find any fix on patchwork =
for
> > this that will/was implemented or planned.
> >=20
> > Machine is a Lenovo netbook with a6-6310 APU, R4 (CIK).
> >=20
> > I have done bisection and here are the results:
> >=20
> >=20
> > 1.  dmesg output from pstore after kernel panic:
> >=20
> > <6>[   13.133880] [drm] amdgpu kernel modesetting enabled.
> > <6>[   13.133923] amdgpu 0000:00:01.0:
> > remove_conflicting_pci_framebuffers: bar 0: 0xe0000000 -> 0xefffffff
> > <6>[   13.133927] amdgpu 0000:00:01.0:
> > remove_conflicting_pci_framebuffers: bar 2: 0xf0000000 -> 0xf07fffff
> > <6>[   13.133930] amdgpu 0000:00:01.0:
> > remove_conflicting_pci_framebuffers: bar 5: 0xf0c00000 -> 0xf0c3ffff
> > <7>[   13.133933] checking generic (e0000000 420000) vs hw (e0000000
> > 10000000) <6>[   13.133935] fb0: switching to amdgpudrmfb from EFI VGA
> > <6>[   13.133999] Console: switching to colour dummy device 80x25
> > <6>[   13.136463] [drm] initializing kernel modesetting (MULLINS
> > 0x1002:0x9851 0x17AA:0x3801 0x00).
> > <6>[   13.136826] [drm] register mmio base: 0xF0C00000
> > <6>[   13.136827] [drm] register mmio size: 262144
> > <6>[   13.136837] [drm] add ip block number 0 <cik_common>
> > <6>[   13.136839] [drm] add ip block number 1 <gmc_v7_0>
> > <6>[   13.136840] [drm] add ip block number 2 <cik_ih>
> > <6>[   13.136842] [drm] add ip block number 3 <gfx_v7_0>
> > <6>[   13.136844] [drm] add ip block number 4 <cik_sdma>
> > <6>[   13.136845] [drm] add ip block number 5 <kv_dpm>
> > <6>[   13.136847] [drm] add ip block number 6 <dm>
> > <6>[   13.136849] [drm] add ip block number 7 <uvd_v4_2>
> > <6>[   13.136850] [drm] add ip block number 8 <vce_v2_0>
> > <6>[   13.136857] amdgpu 0000:00:01.0: kfd not supported on this ASIC
> > <6>[   13.136916] ATOM BIOS: BR45787.ts5
> > <6>[   13.137031] [drm] vm size is 64 GB, 2 levels, block size is 10-bi=
t,
> > fragment size is 9-bit
> > <6>[   13.137042] amdgpu 0000:00:01.0: VRAM: 1024M 0x000000F400000000 -
> > 0x000000F43FFFFFFF (1024M used)
> > <6>[   13.137046] amdgpu 0000:00:01.0: GART: 1024M 0x000000FF00000000 -
> > 0x000000FF3FFFFFFF
> > <6>[   13.137056] [drm] Detected VRAM RAM=3D1024M, BAR=3D1024M
> > <6>[   13.137057] [drm] RAM width 64bits UNKNOWN
> > <6>[   13.138102] sdhci: Secure Digital Host Controller Interface driver
> > <6>[   13.138105] sdhci: Copyright(c) Pierre Ossman
> > <6>[   13.138741] [TTM] Zone  kernel: Available graphics memory: 3541568
> > KiB <6>[   13.138744] [TTM] Zone   dma32: Available graphics memory:
> > 2097152 KiB <6>[   13.138745] [TTM] Initializing pool allocator
> > <6>[   13.138754] [TTM] Initializing DMA pool allocator
> > <6>[   13.138882] [drm] amdgpu: 1024M of VRAM memory ready
> > <6>[   13.138891] [drm] amdgpu: 3072M of GTT memory ready.
> > <6>[   13.138932] [drm] GART: num cpu pages 262144, num gpu pages 262144
> > <6>[   13.138970] [drm] PCIE GART of 1024M enabled (table at
> > 0x000000F400401000).
> > <6>[   13.176861] [drm] Internal thermal controller without fan control
> > <6>[   13.176865] [drm] amdgpu: dpm initialized
> > <6>[   13.176872] [drm] Found UVD firmware Version: 1.64 Family ID: 9
> > <6>[   13.178133] sdhci-pci 0000:00:14.7: SDHCI controller found
> > [1022:7813] (rev 1)
> > <6>[   13.180552] [drm] Found VCE firmware Version: 50.10 Binary ID: 2
> > <6>[   13.186202] kvm: Nested Virtualization enabled
> > <6>[   13.186205] kvm: Nested Paging enabled
> > <6>[   13.191378] mmc0: SDHCI controller on PCI [0000:00:14.7] using AD=
MA
> > <3>[   13.196258] [drm:dm_pp_get_static_clocks [amdgpu]] *ERROR* DM_PPL=
IB:
> > invalid powerlevel state: 0!
> > <4>[   13.196308] [drm] Unsupported Connector type:5!
> > <6>[   13.213496] [drm] Display Core initialized with v3.2.48!
> > <6>[   13.221850] [drm] SADs count is: -2, don't need to read it
> > <6>[   13.230392] ath: phy0: WB335 2-ANT card detected
> > <6>[   13.230395] ath: phy0: Set BT/WLAN RX diversity capability
> > <6>[   13.247472] ath: phy0: Enable LNA combining
> > <6>[   13.248570] ath: phy0: ASPM enabled: 0x43
> > <7>[   13.248574] ath: EEPROM regdomain: 0x6a
> > <7>[   13.248575] ath: EEPROM indicates we should expect a direct regpa=
ir
> > map <7>[   13.248579] ath: Country alpha2 being used: 00
> > <7>[   13.248580] ath: Regpair used: 0x6a
> > <7>[   13.261552] ieee80211 phy0: Selected rate control algorithm
> > 'minstrel_ht'
> > <6>[   13.261857] ieee80211 phy0: Atheros AR9565 Rev:1
> > mem=3D0xffffa9f1c0400000, irq=3D43
> > <6>[   13.296215] ath9k 0000:01:00.0 wlp1s0: renamed from wlan0
> > <6>[   13.304323] [drm] Supports vblank timestamp caching Rev 2
> > (21.10.2013). <6>[   13.304325] [drm] Driver supports precise vblank
> > timestamp query. <6>[   13.321092] [drm] UVD initialized successfully.
> > <6>[   13.373473] usb 1-1: new high-speed USB device number 2 using
> > ehci-pci <6>[   13.386794] usb 4-1: new high-speed USB device number 2
> > using ehci-pci <6>[   13.442287] [drm] VCE initialized successfully.
> > <1>[   13.444174] BUG: kernel NULL pointer dereference, address:
> > 00000000000000a8
> > <1>[   13.444191] #PF: supervisor read access in kernel mode
> > <1>[   13.444197] #PF: error_code(0x0000) - not-present page
> > <6>[   13.444202] PGD 0 P4D 0
> > <4>[   13.444210] Oops: 0000 [#1] PREEMPT SMP
> > <4>[   13.444218] CPU: 1 PID: 3311 Comm: laptop_mode Not tainted
> > 5.2.0-rc1+
> > #94
> > <4>[   13.444224] Hardware name: LENOVO 80E3/Lancer 5B2, BIOS
> > A2CN45WW(V2.13) 08/04/2016
> > <4>[   13.444392] RIP: 0010:amdgpu_irq_handler+0x28/0x78 [amdgpu]
> > <4>[   13.444401] Code: 00 00 41 54 55 53 48 8b 6e 28 48 89 f3 48 89 ef=
 48
> > 8d b5 88 5f 00 00 e8 0e 0a 00 00 41 89 c4 ff c8 74 3e 48 8b 85 d0 70 00
> > 00 <48> 8b 90 a8 00 00 00 48 85 d2 74 0f 48 89 ef e8 1c 75 f7 cb 48 8b
> > <4>[   13.444414] RSP: 0000:ffffa9f1c00ecf00 EFLAGS: 00010012
> > <4>[   13.444420] RAX: 0000000000000000 RBX: ffff947b96a700b0 RCX:
> > 0000000000000018
> > <4>[   13.444427] RDX: 00000000008e7d30 RSI: 001a351391f4b553 RDI:
> > ffffffff8ca17720
> > <4>[   13.444433] RBP: ffff947b8fb80000 R08: ffffffff8c6077e0 R09:
> > ffff947b97ba4af8 <4>[   13.444440] R10: ffff947b969cd2b8 R11:
> > ffff947b969cd2a8 R12: 0000000000000001
> > <4>[   13.444446] R13: 0000000000000000 R14: ffffa9f1c00ecf64 R15:
> > 0000000000000000
> > <4>[   13.444453] FS:  00007f40b84aa740(0000) GS:ffff947b97a80000(0000)
> > knlGS: 0000000000000000
> > <4>[   13.444461] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[   13.444466] CR2: 00000000000000a8 CR3: 000000020e627000 CR4:
> > 00000000000406e0
> > <4>[   13.444472] Call Trace:
> > <4>[   13.444481]  <IRQ>
> > <4>[   13.444492]  __handle_irq_event_percpu+0x3d/0x1a0
> > <4>[   13.444501]  handle_irq_event_percpu+0x2c/0x78
> > <4>[   13.444508]  handle_irq_event+0x2f/0x4c
> > <4>[   13.444515]  handle_edge_irq+0x95/0x1c0
> > <4>[   13.444523]  handle_irq+0x17/0x20
> > <4>[   13.444531]  do_IRQ+0x4a/0xe0
> > <4>[   13.444539]  common_interrupt+0xf/0xf
> > <4>[   13.444545]  </IRQ>
> > <4>[   13.444550] RIP: 0033:0x56277e2c6830
> > <4>[   13.444556] Code: 68 7d 00 00 00 e9 10 f8 ff ff ff 25 22 52 0d 00=
 68
> > 7e 00 00 00 e9 00 f8 ff ff ff 25 1a 52 0d 00 68 7f 00 00 00 e9 f0 f7 ff
> > ff <ff> 25 12 52 0d 00 68 80 00 00 00 e9 e0 f7 ff ff ff 25 0a 52 0d 00
> > <4>[   13.444568] RSP: 002b:00007ffddc457328 EFLAGS: 00000246 ORIG_RAX:
> > ffffffffffffffda
> > <4>[   13.444576] RAX: 0000562780370044 RBX: 0000000000000056 RCX:
> > 0000000000000045
> > <4>[   13.444582] RDX: 0000000000000001 RSI: 000056278037f670 RDI:
> > 00005627804390c0
> > <4>[   13.444588] RBP: 0000562780443150 R08: 0000000000000000 R09:
> > 0000000000003cff
> > <4>[   13.444595] R10: 0000000000100000 R11: 0000000000000098 R12:
> > 00005627804390c0
> > <4>[   13.444601] R13: 0000562780440044 R14: 0000562780457a00 R15:
> > 00000000000000bc
> > <4>[   13.444609] Modules linked in: ath9k ath9k_common ath9k_hw kvm_amd
> > sdhci_pci iosf_mbi mac80211 cqhci kvm sdhci irqbypass crc32_pclmul
> > ghash_clmulni_intel serio_raw mmc_core ath amdgpu(+) cfg80211 gpu_sched
> > mfd_core ttm xhci_pci ehci_pci xhci_hcd sp5100_tco ehci_hcd
> > <4>[   13.444645] CR2: 00000000000000a8
> > <4>[   13.444654] ---[ end trace cd97c823583992aa ]---
> > <6>[   13.446294] [drm] fb mappable at 0xA07ED000
> > <6>[   13.446305] [drm] vram apper at 0xA0000000
> > <6>[   13.446310] [drm] size 5767168
> > <6>[   13.446315] [drm] fb depth is 24
> > <6>[   13.446319] [drm]    pitch is 5632
> > <6>[   13.446480] fbcon: amdgpudrmfb (fb0) is primary device
> > <4>[   13.486378] hpet1: lost 1 rtc interrupts
> > <4>[   13.531123] hpet1: lost 1 rtc interrupts
> > <4>[   13.572920] hpet1: lost 1 rtc interrupts
> > <6>[   13.573579] usb 1-1: New USB device found, idVendor=3D0438,
> > idProduct=3D7900, bcdDevice=3D 0.18
> > <6>[   13.573583] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0,
> > SerialNumber=3D0
> > <6>[   13.573689] usb 4-1: New USB device found, idVendor=3D0438,
> > idProduct=3D7900, bcdDevice=3D 0.18
> > <6>[   13.573692] usb 4-1: New USB device strings: Mfr=3D0, Product=3D0,
> > SerialNumber=3D0
> > <6>[   13.573994] hub 4-1:1.0: USB hub found
> > <6>[   13.574107] hub 1-1:1.0: USB hub found
> > <6>[   13.574120] hub 4-1:1.0: 4 ports detected
> > <6>[   13.574182] hub 1-1:1.0: 4 ports detected
> > <4>[   13.612313] hpet1: lost 1 rtc interrupts
> > <4>[   13.651976] hpet1: lost 1 rtc interrupts
> > <4>[   13.690645] hpet1: lost 1 rtc interrupts
> > <4>[   13.732985] hpet1: lost 1 rtc interrupts
> > <4>[   13.773804] hpet1: lost 1 rtc interrupts
> > <4>[   13.815399] hpet1: lost 1 rtc interrupts
> > <4>[   13.857053] hpet1: lost 1 rtc interrupts
> > <6>[   13.943198] usb 4-1.2: new high-speed USB device number 3 using
> > ehci-pci <6>[   13.943227] usb 1-1.3: new high-speed USB device number 3
> > using ehci-pci <4>[   14.017533] RIP: 0010:amdgpu_irq_handler+0x28/0x78
> > [amdgpu]
> > <4>[   14.017538] Code: 00 00 41 54 55 53 48 8b 6e 28 48 89 f3 48 89 ef=
 48
> > 8d b5 88 5f 00 00 e8 0e 0a 00 00 41 89 c4 ff c8 74 3e 48 8b 85 d0 70 00
> > 00 <48> 8b 90 a8 00 00 00 48 85 d2 74 0f 48 89 ef e8 1c 75 f7 cb 48 8b
> > <4>[   14.017540] RSP: 0000:ffffa9f1c00ecf00 EFLAGS: 00010012
> > <4>[   14.017544] RAX: 0000000000000000 RBX: ffff947b96a700b0 RCX:
> > 0000000000000018
> > <4>[   14.017546] RDX: 00000000008e7d30 RSI: 001a351391f4b553 RDI:
> > ffffffff8ca17720
> > <4>[   14.017547] RBP: ffff947b8fb80000 R08: ffffffff8c6077e0 R09:
> > ffff947b97ba4af8 <4>[   14.017549] R10: ffff947b969cd2b8 R11:
> > ffff947b969cd2a8 R12: 0000000000000001
> > <4>[   14.017551] R13: 0000000000000000 R14: ffffa9f1c00ecf64 R15:
> > 0000000000000000
> > <4>[   14.017553] FS:  00007f40b84aa740(0000) GS:ffff947b97a80000(0000)
> > knlGS: 0000000000000000
> > <4>[   14.017555] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[   14.017557] CR2: 00000000000000a8 CR3: 000000020e627000 CR4:
> > 00000000000406e0
> > <0>[   14.017559] Kernel panic - not syncing: Fatal exception in interr=
upt
> > <0>[   14.017575] Kernel Offset: 0xa800000 from 0xffffffff81000000
> > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> >=20
> >=20
> > 2. full git bisect log:
> >=20
> >=20
> > git bisect start
> > # good: [f1f7ad1b3b98a22229e71d51a1b983049e8bae6b] drm/amd/display: fix
> > calc_pll_max_vco_construct
> > git bisect good f1f7ad1b3b98a22229e71d51a1b983049e8bae6b
> > # bad: [3913cc8cdcf3e27d5ffd31b70779f189e61e6c71] drm/amdgpu: Move null
> > pointer dereference check
> > git bisect bad 3913cc8cdcf3e27d5ffd31b70779f189e61e6c71
> > # good: [f7ffd234bc4acc41612fd6aac83408a1aceffceb] drm/amd/display: Add
> > hubp block for Renoir (v2)
> > git bisect good f7ffd234bc4acc41612fd6aac83408a1aceffceb
> > # good: [0460fba0adac1c0e6211ec5308cfb58941cf26b8] drm/amdgpu: Handle j=
ob
> > is NULL use case in amdgpu_device_gpu_recover
> > git bisect good 0460fba0adac1c0e6211ec5308cfb58941cf26b8
> > # bad: [62c64055ab6d618b1afb28dd4b119cfc1e5d59cb] drm/amdgpu: switch to
> > amdgpu_ras_late_init for gfx v9 block (v2)
> > git bisect bad 62c64055ab6d618b1afb28dd4b119cfc1e5d59cb
> > # good: [1b64dd1871d952c3f999aac8176ba2afbd5ff661] drm/amdgpu: add nbif
> > v7_4 irq source header for vega20
> > git bisect good 1b64dd1871d952c3f999aac8176ba2afbd5ff661
> > # good: [82e6cc2843fc844e5164c0618e6ec133f405a25f] drm/amdgpu: add
> > ras_controller and err_event_athub interrupt support
> > git bisect good 82e6cc2843fc844e5164c0618e6ec133f405a25f
> > # bad: [598de6e65a1c1cbd36decb09d190071c99f100f8] drm/amdgpu: add helper
> > function to do common ras_late_init/fini (v3)
> > git bisect bad 598de6e65a1c1cbd36decb09d190071c99f100f8
> > # bad: [ab2d6f7463d1f6eaf0529c163754feadc353469b] drm/amdgpu: poll
> > ras_controller_irq and err_event_athub_irq status
> > git bisect bad ab2d6f7463d1f6eaf0529c163754feadc353469b
> > # first bad commit: [ab2d6f7463d1f6eaf0529c163754feadc353469b] drm/amdg=
pu:
> > poll ras_controller_irq and err_event_athub_irq status
> >=20
> >=20
> >=20
> > commit ab2d6f7463d1f6eaf0529c163754feadc353469b
> > Author: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
> > Date:   Wed Jun 5 14:40:57 2019 +0800
> >=20
> >     drm/amdgpu: poll ras_controller_irq and err_event_athub_irq status
> >    =20
> >     For the hardware that can not enable BIF ring for IH cookies for bo=
th
> >     ras_controller_irq and err_event_athub_irq, the driver has to poll =
the
> >     status register in irq handling and ack the hardware properly when
> >     there
> >     is interrupt triggered
> >    =20
> >     Signed-off-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
> >     Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> >=20
> > Any help is appreciated.
>=20
> This patch should fix it:
> https://patchwork.freedesktop.org/patch/328558/
>=20
> Alex
Thanks.
Works like a charm.
Przemek.

--nextPart2903080.GGqqDFrkqj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAl1sEVcACgkQPMstj1ls
VJPD/hAAs0Es9NedAo+MSFQvtaUbKM1btoBNVrunFnpuW1gYnKt7gNrEb14zaoVa
EqnkhNaXQiV4DFubWa1MokQo7x5I9fBE55P150mU/wBYjlxJ+TMFDCxDBj21SApJ
woL2AJTkp2k8bdAOEggrTJVoqg0ZbefmGshdcGpaOyn5ttcZS6f3Gz6gQy/j4iJv
ijlcWTjWhn9FX7eaFw3pM46rBPAilw/9q8xjg5x9J/rUUWZdVGyQ6KZgcWThtJLz
UegsNjqiXWkxhBVbKngQe81o0AWaWGk+pFqM6v+vFSnwr5v2+pBra/pGGFO61RKU
xA8oXRMSeQ6DAGdImSNA1qpOeHaLQRfHreeS6Qpvg70SkvTL3ck2Bcg3GEwfyAx2
u1dmvwMxFCk7d26kg7TsuxtQ+jNjKUoie/UKm3+DCal+j3ib6kie6vuPnzc38vkJ
OkaApEDlXgTAXCWmPWStIoP30S8ZomJ7mMOMjeYAjvNnwa7kzYBHfZ0OYsgGRuma
vRTUlaneencLVQu26GE6qTHj3KuENsjWYar4trmU0Sv/Yy0BId2XkBMUXcsKS6I0
QOtz9PTUyGyV2V7FNTgaUnI6DLRrkdjh4bqVYr5OgXiZBljHEYl5kFH26hrJ1u8F
T3taAmfaigi9I7AbhfNY+KQrHBFEFQxS2jPI3RRXtKQ7dn/4qU4=
=RMwO
-----END PGP SIGNATURE-----

--nextPart2903080.GGqqDFrkqj--




--===============1856309288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1856309288==--

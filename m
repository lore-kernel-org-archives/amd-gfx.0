From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Regression: Kaveri VCE ring test fails
Date: Wed, 22 Aug 2018 18:31:23 +0200
Message-ID: <8b612048-12fc-ff45-8ad4-675ea0319c34@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------5536448325CF61FA0C1687CF"
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------5536448325CF61FA0C1687CF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Hi Rex,


I bisected a regression to your "drm/amd/pp: Unify
powergate_uvd/vce/mmhub to set_powergating_by_smu" change. Since this
change, the VCE ring test fails on this Kaveri laptop, which prevents
the amdgpu driver from initializing at all, see the the attached kern.log.

If I disable VCE via the ip_block_mask module parameter, I get an oops
in kv_dpm_get_sclk called from amdkfd, see the attached no-vce.log.


Since the change above landed for 4.19-rc1, the regression should be
fixed before the final 4.19 release if at all possible.


Note that before this change, the VCE IB test has always (as far as I
remember) failed on this machine, see the attached vce-ib-fail.log. But
I don't care about that too much, as I don't need VCE, and I haven't
noticed any other issues related to that.


P.S. Somebody else bisected a Mullins issue to the same commit:
https://bugs.freedesktop.org/show_bug.cgi?id=107595

-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------5536448325CF61FA0C1687CF
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Aug 21 10:20:37 thor kernel: [    4.429726] [drm] amdgpu kernel modesetti=
ng enabled.
Aug 21 10:20:37 thor kernel: [    4.434379] thermal LNXTHERM:04: register=
ed as thermal_zone4
Aug 21 10:20:37 thor kernel: [    4.435586] ACPI: Thermal Zone [BATZ] (27=
 C)
Aug 21 10:20:37 thor kernel: [    4.438045] ohci-pci: OHCI PCI platform d=
river
Aug 21 10:20:37 thor kernel: [    4.438785] Parsing CRAT table with 1 nod=
es
Aug 21 10:20:37 thor kernel: [    4.440120] ohci-pci 0000:00:12.0: OHCI P=
CI host controller
Aug 21 10:20:37 thor kernel: [    4.440522] Creating topology SYSFS entri=
es
Aug 21 10:20:37 thor kernel: [    4.441676] ohci-pci 0000:00:12.0: new US=
B bus registered, assigned bus number 5
Aug 21 10:20:37 thor kernel: [    4.442936] Topology: Add APU node [0x0:0=
x0]
Aug 21 10:20:37 thor kernel: [    4.444233] ohci-pci 0000:00:12.0: irq 18=
, io mem 0xd684e000
Aug 21 10:20:37 thor kernel: [    4.445142] Finished initializing topolog=
y
Aug 21 10:20:37 thor kernel: [    4.445268] kfd kfd: Initialized module
Aug 21 10:20:37 thor kernel: [    4.449415] checking generic (c0000000 30=
0000) vs hw (c0000000 10000000)
Aug 21 10:20:37 thor kernel: [    4.449420] fb: switching to amdgpudrmfb =
from EFI VGA
Aug 21 10:20:37 thor kernel: [    4.450767] Console: switching to colour =
dummy device 80x25
Aug 21 10:20:37 thor kernel: [    4.455227] [drm] initializing kernel mod=
esetting (KAVERI 0x1002:0x130A 0x103C:0x2234 0x00).
Aug 21 10:20:37 thor kernel: [    4.455359] [drm] register mmio base: 0xD=
6800000
Aug 21 10:20:37 thor kernel: [    4.455380] [drm] register mmio size: 262=
144
Aug 21 10:20:37 thor kernel: [    4.455415] [drm] add ip block number 0 <=
cik_common>
Aug 21 10:20:37 thor kernel: [    4.455437] [drm] add ip block number 1 <=
gmc_v7_0>
Aug 21 10:20:37 thor kernel: [    4.455458] [drm] add ip block number 2 <=
cik_ih>
Aug 21 10:20:37 thor kernel: [    4.455479] [drm] add ip block number 3 <=
kv_dpm>
Aug 21 10:20:37 thor kernel: [    4.455499] [drm] add ip block number 4 <=
dce_v8_0>
Aug 21 10:20:37 thor kernel: [    4.455521] [drm] add ip block number 5 <=
gfx_v7_0>
Aug 21 10:20:37 thor kernel: [    4.455542] [drm] add ip block number 6 <=
cik_sdma>
Aug 21 10:20:37 thor kernel: [    4.455562] [drm] add ip block number 7 <=
uvd_v4_2>
Aug 21 10:20:37 thor kernel: [    4.455582] [drm] add ip block number 8 <=
vce_v2_0>
Aug 21 10:20:37 thor kernel: [    4.480652] [drm] BIOS signature incorrec=
t 0 0
Aug 21 10:20:37 thor kernel: [    4.480716] resource sanity check: reques=
ting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [=
mem 0x000c0000-0x000c3fff window]
Aug 21 10:20:37 thor kernel: [    4.480825] caller pci_map_rom+0x58/0xe0 =
mapping multiple BARs
Aug 21 10:20:37 thor kernel: [    4.482188] ATOM BIOS: BR45464.001
Aug 21 10:20:37 thor kernel: [    4.483717] [drm] vm size is 64 GB, 2 lev=
els, block size is 10-bit, fragment size is 9-bit
Aug 21 10:20:37 thor kernel: [    4.483764] amdgpu 0000:00:01.0: VRAM: 10=
24M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
Aug 21 10:20:37 thor kernel: [    4.483804] amdgpu 0000:00:01.0: GART: 10=
24M 0x0000000000000000 - 0x000000003FFFFFFF
Aug 21 10:20:37 thor kernel: [    4.483850] [drm] Detected VRAM RAM=3D102=
4M, BAR=3D1024M
Aug 21 10:20:37 thor kernel: [    4.483875] [drm] RAM width 128bits UNKNO=
WN
Aug 21 10:20:37 thor kernel: [    4.484472] [TTM] Zone  kernel: Available=
 graphics memory: 3568746 kiB
Aug 21 10:20:37 thor kernel: [    4.484537] [TTM] Zone   dma32: Available=
 graphics memory: 2097152 kiB
Aug 21 10:20:37 thor kernel: [    4.484563] [TTM] Initializing pool alloc=
ator
Aug 21 10:20:37 thor kernel: [    4.484620] [TTM] Initializing DMA pool a=
llocator
Aug 21 10:20:37 thor kernel: [    4.485188] [drm] amdgpu: 1024M of VRAM m=
emory ready
Aug 21 10:20:37 thor kernel: [    4.485217] [drm] amdgpu: 3072M of GTT me=
mory ready.
Aug 21 10:20:37 thor kernel: [    4.485316] [drm] GART: num cpu pages 262=
144, num gpu pages 262144
Aug 21 10:20:37 thor kernel: [    4.486477] [drm] PCIE GART of 1024M enab=
led (table at 0x000000F400300000).
Aug 21 10:20:37 thor kernel: [    4.486977] [drm] Supports vblank timesta=
mp caching Rev 2 (21.10.2013).
Aug 21 10:20:37 thor kernel: [    4.487007] [drm] Driver supports precise=
 vblank timestamp query.
Aug 21 10:20:37 thor kernel: [    4.487196] [drm] Internal thermal contro=
ller without fan control
Aug 21 10:20:37 thor kernel: [    4.487266] [drm] amdgpu: dpm initialized=

Aug 21 10:20:37 thor kernel: [    4.493590] [drm] amdgpu atom DIG backlig=
ht initialized
Aug 21 10:20:37 thor kernel: [    4.493619] [drm] AMDGPU Display Connecto=
rs
Aug 21 10:20:37 thor kernel: [    4.493643] [drm] Connector 0:
Aug 21 10:20:37 thor kernel: [    4.493662] [drm]   VGA-1
Aug 21 10:20:37 thor kernel: [    4.493679] [drm]   HPD2
Aug 21 10:20:37 thor kernel: [    4.493698] [drm]   DDC: 0x1950 0x1950 0x=
1951 0x1951 0x1952 0x1952 0x1953 0x1953
Aug 21 10:20:37 thor kernel: [    4.493734] [drm]   Encoders:
Aug 21 10:20:37 thor kernel: [    4.493752] [drm]     CRT1: INTERNAL_UNIP=
HY2
Aug 21 10:20:37 thor kernel: [    4.493774] [drm]     CRT1: NUTMEG
Aug 21 10:20:37 thor kernel: [    4.493791] [drm] Connector 1:
Aug 21 10:20:37 thor kernel: [    4.493808] [drm]   HDMI-A-1
Aug 21 10:20:37 thor kernel: [    4.493825] [drm]   HPD3
Aug 21 10:20:37 thor kernel: [    4.493842] [drm]   DDC: 0x1954 0x1954 0x=
1955 0x1955 0x1956 0x1956 0x1957 0x1957
Aug 21 10:20:37 thor kernel: [    4.493875] [drm]   Encoders:
Aug 21 10:20:37 thor kernel: [    4.493891] [drm]     DFP1: INTERNAL_UNIP=
HY2
Aug 21 10:20:37 thor kernel: [    4.493914] [drm] Connector 2:
Aug 21 10:20:37 thor kernel: [    4.493931] [drm]   eDP-1
Aug 21 10:20:37 thor kernel: [    4.493949] [drm]   HPD1
Aug 21 10:20:37 thor kernel: [    4.493965] [drm]   DDC: 0x194c 0x194c 0x=
194d 0x194d 0x194e 0x194e 0x194f 0x194f
Aug 21 10:20:37 thor kernel: [    4.493997] [drm]   Encoders:
Aug 21 10:20:37 thor kernel: [    4.494014] [drm]     LCD1: INTERNAL_UNIP=
HY
Aug 21 10:20:37 thor kernel: [    4.498450] [drm] Found UVD firmware Vers=
ion: 1.64 Family ID: 9
Aug 21 10:20:37 thor kernel: [    4.499115] [drm] Found VCE firmware Vers=
ion: 50.10 Binary ID: 2
Aug 21 10:20:37 thor kernel: [    4.508643] usb usb5: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0001, bcdDevice=3D 4.18
Aug 21 10:20:37 thor kernel: [    4.508690] usb usb5: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Aug 21 10:20:37 thor kernel: [    4.508722] usb usb5: Product: OHCI PCI h=
ost controller
Aug 21 10:20:37 thor kernel: [    4.508746] usb usb5: Manufacturer: Linux=
 4.18.3+ ohci_hcd
Aug 21 10:20:37 thor kernel: [    4.508771] usb usb5: SerialNumber: 0000:=
00:12.0
Aug 21 10:20:37 thor kernel: [    4.509733] hub 5-0:1.0: USB hub found
Aug 21 10:20:37 thor kernel: [    4.509866] hub 5-0:1.0: 5 ports detected=

Aug 21 10:20:37 thor kernel: [    4.512474] ohci-pci 0000:00:13.0: OHCI P=
CI host controller
Aug 21 10:20:37 thor kernel: [    4.512526] ohci-pci 0000:00:13.0: new US=
B bus registered, assigned bus number 6
Aug 21 10:20:37 thor kernel: [    4.512710] ohci-pci 0000:00:13.0: irq 18=
, io mem 0xd684c000
Aug 21 10:20:37 thor kernel: [    4.576573] usb usb6: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0001, bcdDevice=3D 4.18
Aug 21 10:20:37 thor kernel: [    4.576619] usb usb6: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Aug 21 10:20:37 thor kernel: [    4.576652] usb usb6: Product: OHCI PCI h=
ost controller
Aug 21 10:20:37 thor kernel: [    4.576676] usb usb6: Manufacturer: Linux=
 4.18.3+ ohci_hcd
Aug 21 10:20:37 thor kernel: [    4.576700] usb usb6: SerialNumber: 0000:=
00:13.0
Aug 21 10:20:37 thor kernel: [    4.577512] hub 6-0:1.0: USB hub found
Aug 21 10:20:37 thor kernel: [    4.577641] hub 6-0:1.0: 5 ports detected=

Aug 21 10:20:37 thor kernel: [    4.579585] ohci-pci 0000:00:14.5: OHCI P=
CI host controller
Aug 21 10:20:37 thor kernel: [    4.579633] ohci-pci 0000:00:14.5: new US=
B bus registered, assigned bus number 7
Aug 21 10:20:37 thor kernel: [    4.579806] ohci-pci 0000:00:14.5: irq 18=
, io mem 0xd684a000
Aug 21 10:20:37 thor kernel: [    4.597742] [drm] UVD initialized success=
fully.
Aug 21 10:20:37 thor kernel: [    4.640534] usb usb7: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0001, bcdDevice=3D 4.18
Aug 21 10:20:37 thor kernel: [    4.640576] usb usb7: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Aug 21 10:20:37 thor kernel: [    4.640608] usb usb7: Product: OHCI PCI h=
ost controller
Aug 21 10:20:37 thor kernel: [    4.640633] usb usb7: Manufacturer: Linux=
 4.18.3+ ohci_hcd
Aug 21 10:20:37 thor kernel: [    4.640658] usb usb7: SerialNumber: 0000:=
00:14.5
Aug 21 10:20:37 thor kernel: [    4.641572] hub 7-0:1.0: USB hub found
Aug 21 10:20:37 thor kernel: [    4.641661] hub 7-0:1.0: 2 ports detected=

Aug 21 10:20:37 thor kernel: [    4.656213] usb 1-2: new high-speed USB d=
evice number 2 using xhci_hcd
Aug 21 10:20:37 thor kernel: [    4.784144] ata2: SATA link up 1.5 Gbps (=
SStatus 113 SControl 300)
Aug 21 10:20:37 thor kernel: [    4.784381] ata1: SATA link up 6.0 Gbps (=
SStatus 133 SControl 300)
Aug 21 10:20:37 thor kernel: [    4.785204] ata1.00: ATA-9: TOSHIBA THNSN=
J256GCSU, JURA0101, max UDMA/100
Aug 21 10:20:37 thor kernel: [    4.785245] ata1.00: 500118192 sectors, m=
ulti 16: LBA48 NCQ (depth 32), AA
Aug 21 10:20:37 thor kernel: [    4.786168] ata1.00: configured for UDMA/=
100
Aug 21 10:20:37 thor kernel: [    4.787759] scsi 0:0:0:0: Direct-Access  =
   ATA      TOSHIBA THNSNJ25 0101 PQ: 0 ANSI: 5
Aug 21 10:20:37 thor kernel: [    4.789422] ata2.00: ATAPI: hp       DVDR=
W  SU208GB, HH00, max UDMA/100
Aug 21 10:20:37 thor kernel: [    4.798403] ata2.00: configured for UDMA/=
100
Aug 21 10:20:37 thor kernel: [    4.806116] scsi 1:0:0:0: CD-ROM         =
   hp       DVDRW  SU208GB   HH00 PQ: 0 ANSI: 5
Aug 21 10:20:37 thor kernel: [    4.815325] usb 1-2: New USB device found=
, idVendor=3D05ac, idProduct=3D1006, bcdDevice=3D94.15
Aug 21 10:20:37 thor kernel: [    4.815443] usb 1-2: New USB device strin=
gs: Mfr=3D1, Product=3D2, SerialNumber=3D3
Aug 21 10:20:37 thor kernel: [    4.815475] usb 1-2: Product: Keyboard Hu=
b
Aug 21 10:20:37 thor kernel: [    4.815496] usb 1-2: Manufacturer: Apple,=
 Inc.
Aug 21 10:20:37 thor kernel: [    4.815517] usb 1-2: SerialNumber: 000000=
000000
Aug 21 10:20:37 thor kernel: [    4.819068] hub 1-2:1.0: USB hub found
Aug 21 10:20:37 thor kernel: [    4.819576] hub 1-2:1.0: 3 ports detected=

Aug 21 10:20:37 thor kernel: [    4.826494] [drm:amdgpu_vce_ring_test_rin=
g [amdgpu]] *ERROR* amdgpu: ring 12 test failed
Aug 21 10:20:37 thor kernel: [    4.826675] [drm:amdgpu_device_init.cold.=
27 [amdgpu]] *ERROR* hw_init of IP block <vce_v2_0> failed -110
Aug 21 10:20:37 thor kernel: [    4.826725] amdgpu 0000:00:01.0: amdgpu_d=
evice_ip_init failed
Aug 21 10:20:37 thor kernel: [    4.826759] amdgpu 0000:00:01.0: Fatal er=
ror during GPU init
Aug 21 10:20:37 thor kernel: [    4.826959] [drm] amdgpu: finishing devic=
e.
Aug 21 10:20:37 thor kernel: [    4.850222] [drm] amdgpu atom LVDS backli=
ght unloaded
Aug 21 10:20:37 thor kernel: [    4.854959] ------------[ cut here ]-----=
-------
Aug 21 10:20:37 thor kernel: [    4.855067] Memory manager not clean duri=
ng takedown.
Aug 21 10:20:37 thor kernel: [    4.855203] WARNING: CPU: 0 PID: 122 at d=
rivers/gpu/drm/drm_mm.c:950 drm_mm_takedown+0x1f/0x30 [drm]
Aug 21 10:20:37 thor kernel: [    4.855245] Modules linked in: ohci_pci(E=
) amdkfd(E) crc32c_intel(E) aesni_intel(E) aes_x86_64(E) crypto_simd(E) a=
mdgpu(E+) cryptd(E) glue_helper(E) chash(E) gpu_sched(E) ehci_pci(E) ohci=
_hcd(E) i2c_algo_bit(E) ehci_hcd(E) psmouse(E) ttm(E) xhci_pci(E) ahci(E)=
 serio_raw(E) drm_kms_helper(E) libahci(E) xhci_hcd(E) syscopyarea(E) sys=
fillrect(E) libata(E) sysimgblt(E) fb_sys_fops(E) usbcore(E) scsi_mod(E) =
thermal(E) evdev(E) drm(E) wmi(E) video(E) button(E)
Aug 21 10:20:37 thor kernel: [    4.855499] CPU: 0 PID: 122 Comm: systemd=
-udevd Tainted: G        W   E     4.18.3+ #326
Aug 21 10:20:37 thor kernel: [    4.855538] Hardware name: Hewlett-Packar=
d HP ProBook 455 G2/2235, BIOS M75 Ver. 01.42 09/26/2016
Aug 21 10:20:37 thor kernel: [    4.855601] RIP: 0010:drm_mm_takedown+0x1=
f/0x30 [drm]
Aug 21 10:20:37 thor kernel: [    4.855625] Code: f6 c3 48 8d 41 c0 eb bb=
 0f 1f 00 0f 1f 44 00 00 48 8b 47 38 48 83 c7 38 48 39 c7 75 01 c3 48 c7 =
c7 f8 ca 29 c0 e8 75 ee 60 f9 <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00=
 0f 1f 00 0f 1f 44 00 00=20
Aug 21 10:20:37 thor kernel: [    4.855860] RSP: 0018:ffffb052015cf9f0 EF=
LAGS: 00010286
Aug 21 10:20:37 thor kernel: [    4.855887] RAX: 0000000000000000 RBX: ff=
ff8aa86f788400 RCX: 0000000000000006
Aug 21 10:20:37 thor kernel: [    4.855919] RDX: 0000000000000faa RSI: ff=
ff8aa86f4c5000 RDI: 0000000000000246
Aug 21 10:20:37 thor kernel: [    4.855950] RBP: ffff8aa86eba2ed8 R08: 00=
00000000000000 R09: 0000000000000000
Aug 21 10:20:37 thor kernel: [    4.855981] R10: 0000000000000000 R11: 00=
00000000000000 R12: ffff8aa86f7884e8
Aug 21 10:20:37 thor kernel: [    4.856021] R13: ffff8aa86eba2eb8 R14: 00=
00000000000000 R15: ffff8aa86e457190
Aug 21 10:20:37 thor kernel: [    4.856055] FS:  00007f72e00f58c0(0000) G=
S:ffff8aa87ec00000(0000) knlGS:0000000000000000
Aug 21 10:20:37 thor kernel: [    4.856093] CS:  0010 DS: 0000 ES: 0000 C=
R0: 0000000080050033
Aug 21 10:20:37 thor kernel: [    4.856120] CR2: 000055aae814d538 CR3: 00=
0000022f4f0000 CR4: 00000000000406f0
Aug 21 10:20:37 thor kernel: [    4.856152] Call Trace:
Aug 21 10:20:37 thor kernel: [    4.856344]  amdgpu_vram_mgr_fini+0x27/0x=
50 [amdgpu]
Aug 21 10:20:37 thor kernel: [    4.856385]  ttm_bo_clean_mm+0xaf/0xc0 [t=
tm]
Aug 21 10:20:37 thor kernel: [    4.856519]  amdgpu_ttm_fini+0x7d/0x120 [=
amdgpu]
Aug 21 10:20:37 thor kernel: [    4.856653]  amdgpu_bo_fini+0xe/0x30 [amd=
gpu]
Aug 21 10:20:37 thor kernel: [    4.856795]  gmc_v7_0_sw_fini+0x3a/0x60 [=
amdgpu]
Aug 21 10:20:37 thor kernel: [    4.856947]  amdgpu_device_fini+0x2cc/0x4=
87 [amdgpu]
Aug 21 10:20:37 thor kernel: [    4.857084]  amdgpu_driver_unload_kms+0x4=
2/0x90 [amdgpu]
Aug 21 10:20:37 thor kernel: [    4.857217]  amdgpu_driver_load_kms+0x146=
/0x2c0 [amdgpu]
Aug 21 10:20:37 thor kernel: [    4.857269]  drm_dev_register+0x10b/0x140=
 [drm]
Aug 21 10:20:37 thor kernel: [    4.857403]  amdgpu_pci_probe+0x13c/0x1c0=
 [amdgpu]
Aug 21 10:20:37 thor kernel: [    4.857438]  local_pci_probe+0x41/0x90
Aug 21 10:20:37 thor kernel: [    4.857464]  pci_device_probe+0x115/0x1a0=

Aug 21 10:20:37 thor kernel: [    4.857497]  driver_probe_device+0x2da/0x=
450
Aug 21 10:20:37 thor kernel: [    4.857527]  __driver_attach+0xe1/0x110
Aug 21 10:20:37 thor kernel: [    4.857550]  ? driver_probe_device+0x450/=
0x450
Aug 21 10:20:37 thor kernel: [    4.857575]  ? driver_probe_device+0x450/=
0x450
Aug 21 10:20:37 thor kernel: [    4.857603]  bus_for_each_dev+0x79/0xc0
Aug 21 10:20:37 thor kernel: [    4.857632]  bus_add_driver+0x155/0x230
Aug 21 10:20:37 thor kernel: [    4.857657]  ? 0xffffffffc0445000
Aug 21 10:20:37 thor kernel: [    4.857681]  driver_register+0x6b/0xb0
Aug 21 10:20:37 thor kernel: [    4.857703]  ? 0xffffffffc0445000
Aug 21 10:20:37 thor kernel: [    4.857725]  do_one_initcall+0x5d/0x32a
Aug 21 10:20:37 thor kernel: [    4.857753]  ? rcu_read_lock_sched_held+0=
x55/0x60
Aug 21 10:20:37 thor kernel: [    4.857780]  ? kmem_cache_alloc_trace+0x2=
37/0x290
Aug 21 10:20:37 thor kernel: [    4.857806]  ? do_init_module+0x22/0x210
Aug 21 10:20:37 thor kernel: [    4.857834]  do_init_module+0x5a/0x210
Aug 21 10:20:37 thor kernel: [    4.857858]  load_module+0x19da/0x1f90
Aug 21 10:20:37 thor kernel: [    4.857898]  ? vfs_read+0x110/0x140
Aug 21 10:20:37 thor kernel: [    4.857941]  ? __do_sys_finit_module+0xa8=
/0x110
Aug 21 10:20:37 thor kernel: [    4.857965]  __do_sys_finit_module+0xa8/0=
x110
Aug 21 10:20:37 thor kernel: [    4.858009]  do_syscall_64+0x60/0x180
Aug 21 10:20:37 thor kernel: [    4.858035]  entry_SYSCALL_64_after_hwfra=
me+0x49/0xbe
Aug 21 10:20:37 thor kernel: [    4.858061] RIP: 0033:0x7f72e002aa79
Aug 21 10:20:37 thor kernel: [    4.858079] Code: 00 f3 c3 66 2e 0f 1f 84=
 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 =
4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d df 43=
 0c 00 f7 d8 64 89 01 48=20
Aug 21 10:20:37 thor kernel: [    4.858323] RSP: 002b:00007ffc73ef00c8 EF=
LAGS: 00000246 ORIG_RAX: 0000000000000139
Aug 21 10:20:37 thor kernel: [    4.858360] RAX: ffffffffffffffda RBX: 00=
0055aae813bf90 RCX: 00007f72e002aa79
Aug 21 10:20:37 thor kernel: [    4.858392] RDX: 0000000000000000 RSI: 00=
0055aae8131190 RDI: 0000000000000015
Aug 21 10:20:37 thor kernel: [    4.858423] RBP: 000055aae8131190 R08: 00=
00000000000000 R09: 0000000000000000
Aug 21 10:20:37 thor kernel: [    4.858455] R10: 0000000000000015 R11: 00=
00000000000246 R12: 0000000000000000
Aug 21 10:20:37 thor kernel: [    4.858486] R13: 000055aae8145e60 R14: 00=
00000000020000 R15: 0000000000000000
Aug 21 10:20:37 thor kernel: [    4.858536] irq event stamp: 34328
Aug 21 10:20:37 thor kernel: [    4.858560] hardirqs last  enabled at (34=
327): [<ffffffffb98e7bb0>] console_unlock+0x450/0x5f0
Aug 21 10:20:37 thor kernel: [    4.858600] hardirqs last disabled at (34=
328): [<ffffffffba0011ef>] error_entry+0x7f/0x100
Aug 21 10:20:37 thor kernel: [    4.858641] softirqs last  enabled at (32=
640): [<ffffffffb9e42401>] peernet2id+0x51/0x80
Aug 21 10:20:37 thor kernel: [    4.858678] softirqs last disabled at (32=
638): [<ffffffffb9e423e2>] peernet2id+0x32/0x80
Aug 21 10:20:37 thor kernel: [    4.858714] ---[ end trace e7618c1cf728da=
bb ]---
Aug 21 10:20:37 thor kernel: [    4.859198] [TTM] Finalizing pool allocat=
or
Aug 21 10:20:37 thor kernel: [    4.859499] [TTM] Finalizing DMA pool all=
ocator
Aug 21 10:20:37 thor kernel: [    4.860563] [TTM] Zone  kernel: Used memo=
ry at exit: 22 kiB
Aug 21 10:20:37 thor kernel: [    4.860612] [TTM] Zone   dma32: Used memo=
ry at exit: 22 kiB
Aug 21 10:20:37 thor kernel: [    4.860708] [drm] amdgpu: ttm finalized
Aug 21 10:20:37 thor kernel: [    4.863746] amdgpu: probe of 0000:00:01.0=
 failed with error -110

--------------5536448325CF61FA0C1687CF
Content-Type: text/x-log;
 name="no-vce.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="no-vce.log"

Aug 21 11:28:50 thor kernel: [   73.229567] [drm] amdgpu kernel modesetti=
ng enabled.
Aug 21 11:28:50 thor kernel: [   73.250985] Parsing CRAT table with 1 nod=
es
Aug 21 11:28:50 thor kernel: [   73.250997] Creating topology SYSFS entri=
es
Aug 21 11:28:50 thor kernel: [   73.251040] Topology: Add APU node [0x0:0=
x0]
Aug 21 11:28:50 thor kernel: [   73.251042] Finished initializing topolog=
y
Aug 21 11:28:50 thor kernel: [   73.251104] kfd kfd: Initialized module
Aug 21 11:28:50 thor kernel: [   73.251492] checking generic (c0000000 30=
0000) vs hw (c0000000 10000000)
Aug 21 11:28:50 thor kernel: [   73.251495] fb: switching to amdgpudrmfb =
from EFI VGA
Aug 21 11:28:50 thor kernel: [   73.251589] Console: switching to colour =
dummy device 80x25
Aug 21 11:28:50 thor kernel: [   73.252390] [drm] initializing kernel mod=
esetting (KAVERI 0x1002:0x130A 0x103C:0x2234 0x00).
Aug 21 11:28:50 thor kernel: [   73.252468] [drm] register mmio base: 0xD=
6800000
Aug 21 11:28:50 thor kernel: [   73.252471] [drm] register mmio size: 262=
144
Aug 21 11:28:50 thor kernel: [   73.252485] [drm] add ip block number 0 <=
cik_common>
Aug 21 11:28:50 thor kernel: [   73.252488] [drm] add ip block number 1 <=
gmc_v7_0>
Aug 21 11:28:50 thor kernel: [   73.252492] [drm] add ip block number 2 <=
cik_ih>
Aug 21 11:28:50 thor kernel: [   73.252495] [drm] add ip block number 3 <=
kv_dpm>
Aug 21 11:28:50 thor kernel: [   73.252499] [drm] add ip block number 4 <=
dce_v8_0>
Aug 21 11:28:50 thor kernel: [   73.252502] [drm] add ip block number 5 <=
gfx_v7_0>
Aug 21 11:28:50 thor kernel: [   73.252505] [drm] add ip block number 6 <=
cik_sdma>
Aug 21 11:28:50 thor kernel: [   73.252508] [drm] add ip block number 7 <=
uvd_v4_2>
Aug 21 11:28:50 thor kernel: [   73.252511] [drm] add ip block number 8 <=
vce_v2_0>
Aug 21 11:28:50 thor kernel: [   73.252693] [drm:amdgpu_device_init.cold.=
28 [amdgpu]] *ERROR* disabled ip block: 8 <vce_v2_0>
Aug 21 11:28:50 thor kernel: [   73.286381] [drm] BIOS signature incorrec=
t 0 0
Aug 21 11:28:50 thor kernel: [   73.286429] resource sanity check: reques=
ting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [=
mem 0x000c0000-0x000c3fff window]
Aug 21 11:28:50 thor kernel: [   73.286442] caller pci_map_rom+0x58/0xe0 =
mapping multiple BARs
Aug 21 11:28:50 thor kernel: [   73.287797] ATOM BIOS: BR45464.001
Aug 21 11:28:50 thor kernel: [   73.287822] [drm] GPU posting now...
Aug 21 11:28:51 thor kernel: [   73.754393] [drm] vm size is 64 GB, 2 lev=
els, block size is 10-bit, fragment size is 9-bit
Aug 21 11:28:51 thor kernel: [   73.754413] amdgpu 0000:00:01.0: VRAM: 10=
24M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
Aug 21 11:28:51 thor kernel: [   73.754417] amdgpu 0000:00:01.0: GTT: 102=
4M 0x0000000000000000 - 0x000000003FFFFFFF
Aug 21 11:28:51 thor kernel: [   73.754434] [drm] Detected VRAM RAM=3D102=
4M, BAR=3D1024M
Aug 21 11:28:51 thor kernel: [   73.754437] [drm] RAM width 128bits UNKNO=
WN
Aug 21 11:28:51 thor kernel: [   73.754852] [TTM] Zone  kernel: Available=
 graphics memory: 3568746 kiB
Aug 21 11:28:51 thor kernel: [   73.754858] [TTM] Zone   dma32: Available=
 graphics memory: 2097152 kiB
Aug 21 11:28:51 thor kernel: [   73.754861] [TTM] Initializing pool alloc=
ator
Aug 21 11:28:51 thor kernel: [   73.754871] [TTM] Initializing DMA pool a=
llocator
Aug 21 11:28:51 thor kernel: [   73.754963] [drm] amdgpu: 1024M of VRAM m=
emory ready
Aug 21 11:28:51 thor kernel: [   73.754968] [drm] amdgpu: 3072M of GTT me=
mory ready.
Aug 21 11:28:51 thor kernel: [   73.755028] [drm] GART: num cpu pages 262=
144, num gpu pages 262144
Aug 21 11:28:51 thor kernel: [   73.755804] [drm] PCIE GART of 1024M enab=
led (table at 0x000000F400000000).
Aug 21 11:28:51 thor kernel: [   73.755968] [drm] Supports vblank timesta=
mp caching Rev 2 (21.10.2013).
Aug 21 11:28:51 thor kernel: [   73.755972] [drm] Driver supports precise=
 vblank timestamp query.
Aug 21 11:28:51 thor kernel: [   73.756004] [drm] Internal thermal contro=
ller without fan control
Aug 21 11:28:51 thor kernel: [   73.756007] [drm] amdgpu: dpm initialized=

Aug 21 11:28:51 thor kernel: [   73.757823] [drm] amdgpu atom DIG backlig=
ht initialized
Aug 21 11:28:51 thor kernel: [   73.757826] [drm] AMDGPU Display Connecto=
rs
Aug 21 11:28:51 thor kernel: [   73.757829] [drm] Connector 0:
Aug 21 11:28:51 thor kernel: [   73.757831] [drm]   VGA-1
Aug 21 11:28:51 thor kernel: [   73.757833] [drm]   HPD2
Aug 21 11:28:51 thor kernel: [   73.757836] [drm]   DDC: 0x1950 0x1950 0x=
1951 0x1951 0x1952 0x1952 0x1953 0x1953
Aug 21 11:28:51 thor kernel: [   73.757838] [drm]   Encoders:
Aug 21 11:28:51 thor kernel: [   73.757840] [drm]     CRT1: INTERNAL_UNIP=
HY2
Aug 21 11:28:51 thor kernel: [   73.757842] [drm]     CRT1: NUTMEG
Aug 21 11:28:51 thor kernel: [   73.757844] [drm] Connector 1:
Aug 21 11:28:51 thor kernel: [   73.757846] [drm]   HDMI-A-1
Aug 21 11:28:51 thor kernel: [   73.757847] [drm]   HPD3
Aug 21 11:28:51 thor kernel: [   73.757850] [drm]   DDC: 0x1954 0x1954 0x=
1955 0x1955 0x1956 0x1956 0x1957 0x1957
Aug 21 11:28:51 thor kernel: [   73.757852] [drm]   Encoders:
Aug 21 11:28:51 thor kernel: [   73.757854] [drm]     DFP1: INTERNAL_UNIP=
HY2
Aug 21 11:28:51 thor kernel: [   73.757856] [drm] Connector 2:
Aug 21 11:28:51 thor kernel: [   73.757857] [drm]   eDP-1
Aug 21 11:28:51 thor kernel: [   73.757859] [drm]   HPD1
Aug 21 11:28:51 thor kernel: [   73.757862] [drm]   DDC: 0x194c 0x194c 0x=
194d 0x194d 0x194e 0x194e 0x194f 0x194f
Aug 21 11:28:51 thor kernel: [   73.757864] [drm]   Encoders:
Aug 21 11:28:51 thor kernel: [   73.757866] [drm]     LCD1: INTERNAL_UNIP=
HY
Aug 21 11:28:51 thor kernel: [   73.772752] [drm] Found UVD firmware Vers=
ion: 1.64 Family ID: 9
Aug 21 11:28:51 thor kernel: [   73.870851] [drm] UVD initialized success=
fully.
Aug 21 11:28:51 thor kernel: [   73.879258] kfd kfd: Allocated 3969056 by=
tes on gart
Aug 21 11:28:51 thor kernel: [   73.879318] BUG: unable to handle kernel =
NULL pointer dereference at 000000000000003c
Aug 21 11:28:51 thor kernel: [   73.879325] PGD 0 P4D 0=20
Aug 21 11:28:51 thor kernel: [   73.879338] Oops: 0000 [#1] SMP NOPTI
Aug 21 11:28:51 thor kernel: [   73.879349] CPU: 1 PID: 3609 Comm: modpro=
be Tainted: G        W  OE     4.18.3+ #326
Aug 21 11:28:51 thor kernel: [   73.879355] Hardware name: Hewlett-Packar=
d HP ProBook 455 G2/2235, BIOS M75 Ver. 01.42 09/26/2016
Aug 21 11:28:51 thor kernel: [   73.879563] RIP: 0010:kv_dpm_get_sclk+0x1=
b/0x30 [amdgpu]
Aug 21 11:28:51 thor kernel: [   73.879568] Code: 1f 44 00 00 c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 60 48 00 00 48 8b 80 28 04 =
00 00 40 84 f6 74 03 8b 00 c3 <8b> 50 3c 83 ea 01 48 8d 14 52 8b 04 90 c3=
 0f 1f 80 00 00 00 00 0f=20
Aug 21 11:28:51 thor kernel: [   73.879699] RSP: 0018:ffffba09821038b8 EF=
LAGS: 00010246
Aug 21 11:28:51 thor kernel: [   73.879707] RAX: 0000000000000000 RBX: ff=
ff95726de47800 RCX: 0000000000000000
Aug 21 11:28:51 thor kernel: [   73.879713] RDX: ffffffffc11a3b10 RSI: 00=
00000000000000 RDI: ffff95726eb00000
Aug 21 11:28:51 thor kernel: [   73.879719] RBP: ffffba09821038e0 R08: ff=
ff95726eb00000 R09: 0000000000000000
Aug 21 11:28:51 thor kernel: [   73.879724] R10: 0000000000000000 R11: 00=
00000000000000 R12: ffff95726de47000
Aug 21 11:28:51 thor kernel: [   73.879730] R13: 000000000000707b R14: 00=
00000000000000 R15: 0000000000000000
Aug 21 11:28:51 thor kernel: [   73.879737] FS:  00007fe7f2c63b80(0000) G=
S:ffff95727ec80000(0000) knlGS:0000000000000000
Aug 21 11:28:51 thor kernel: [   73.879743] CS:  0010 DS: 0000 ES: 0000 C=
R0: 0000000080050033
Aug 21 11:28:51 thor kernel: [   73.879749] CR2: 000000000000003c CR3: 00=
0000022dddc000 CR4: 00000000000406e0
Aug 21 11:28:51 thor kernel: [   73.879754] Call Trace:
Aug 21 11:28:51 thor kernel: [   73.879927]  get_max_engine_clock_in_mhz+=
0x2f/0x60 [amdgpu]
Aug 21 11:28:51 thor kernel: [   73.879956]  kfd_topology_add_device+0x18=
4/0x440 [amdkfd]
Aug 21 11:28:51 thor kernel: [   73.879994]  kgd2kfd_device_init+0x1a9/0x=
400 [amdkfd]
Aug 21 11:28:51 thor kernel: [   73.880161]  amdgpu_amdkfd_device_init+0x=
189/0x1c0 [amdgpu]
Aug 21 11:28:51 thor kernel: [   73.880339]  amdgpu_device_init.cold.28+0=
xf26/0x12bc [amdgpu]
Aug 21 11:28:51 thor kernel: [   73.880358]  ? kmalloc_order+0x14/0x40
Aug 21 11:28:51 thor kernel: [   73.880505]  amdgpu_driver_load_kms+0x86/=
0x2c0 [amdgpu]
Aug 21 11:28:51 thor kernel: [   73.880554]  drm_dev_register+0x10b/0x140=
 [drm]
Aug 21 11:28:51 thor kernel: [   73.880704]  amdgpu_pci_probe+0x13c/0x1c0=
 [amdgpu]
Aug 21 11:28:51 thor kernel: [   73.880719]  local_pci_probe+0x41/0x90
Aug 21 11:28:51 thor kernel: [   73.880729]  pci_device_probe+0x115/0x1a0=

Aug 21 11:28:51 thor kernel: [   73.880745]  driver_probe_device+0x2da/0x=
450
Aug 21 11:28:51 thor kernel: [   73.880757]  __driver_attach+0xe1/0x110
Aug 21 11:28:51 thor kernel: [   73.880765]  ? driver_probe_device+0x450/=
0x450
Aug 21 11:28:51 thor kernel: [   73.880774]  ? driver_probe_device+0x450/=
0x450
Aug 21 11:28:51 thor kernel: [   73.880782]  bus_for_each_dev+0x79/0xc0
Aug 21 11:28:51 thor kernel: [   73.880794]  bus_add_driver+0x155/0x230
Aug 21 11:28:51 thor kernel: [   73.880802]  ? 0xffffffffc13c1000
Aug 21 11:28:51 thor kernel: [   73.880812]  driver_register+0x6b/0xb0
Aug 21 11:28:51 thor kernel: [   73.880819]  ? 0xffffffffc13c1000
Aug 21 11:28:51 thor kernel: [   73.880829]  do_one_initcall+0x5d/0x32a
Aug 21 11:28:51 thor kernel: [   73.880841]  ? _cond_resched+0x15/0x30
Aug 21 11:28:51 thor kernel: [   73.880849]  ? kmem_cache_alloc_trace+0x2=
20/0x290
Aug 21 11:28:51 thor kernel: [   73.880858]  ? do_init_module+0x22/0x210
Aug 21 11:28:51 thor kernel: [   73.880868]  do_init_module+0x5a/0x210
Aug 21 11:28:51 thor kernel: [   73.880877]  load_module+0x19da/0x1f90
Aug 21 11:28:51 thor kernel: [   73.880896]  ? vfs_read+0x110/0x140
Aug 21 11:28:51 thor kernel: [   73.880916]  ? __do_sys_finit_module+0xa8=
/0x110
Aug 21 11:28:51 thor kernel: [   73.880923]  __do_sys_finit_module+0xa8/0=
x110
Aug 21 11:28:51 thor kernel: [   73.880942]  do_syscall_64+0x60/0x180
Aug 21 11:28:51 thor kernel: [   73.880953]  entry_SYSCALL_64_after_hwfra=
me+0x49/0xbe
Aug 21 11:28:51 thor kernel: [   73.880961] RIP: 0033:0x7fe7f2902a79
Aug 21 11:28:51 thor kernel: [   73.880965] Code: 00 f3 c3 66 2e 0f 1f 84=
 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 =
4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d df 43=
 0c 00 f7 d8 64 89 01 48=20
Aug 21 11:28:51 thor kernel: [   73.881094] RSP: 002b:00007ffcf2722578 EF=
LAGS: 00000246 ORIG_RAX: 0000000000000139
Aug 21 11:28:51 thor kernel: [   73.881103] RAX: ffffffffffffffda RBX: 00=
0056050ae79160 RCX: 00007fe7f2902a79
Aug 21 11:28:51 thor kernel: [   73.881108] RDX: 0000000000000000 RSI: 00=
0056050ae7c820 RDI: 000000000000000d
Aug 21 11:28:51 thor kernel: [   73.881114] RBP: 000056050ae7c820 R08: 00=
00000000000000 R09: 0000000000000000
Aug 21 11:28:51 thor kernel: [   73.881119] R10: 000000000000000d R11: 00=
00000000000246 R12: 0000000000000000
Aug 21 11:28:51 thor kernel: [   73.881125] R13: 000056050ae79290 R14: 00=
00000000040000 R15: 0000000000000011
Aug 21 11:28:51 thor kernel: [   73.881141] Modules linked in: amdkfd(OE)=
 amdgpu(OE+) chash(OE) gpu_sched(OE) ttm(OE) drm_kms_helper(OE) drm(OE) i=
2c_algo_bit(E) fb_sys_fops(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) =
pci_stub(E) vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE) vboxdrv(OE) nf_conn=
track_netbios_ns(E) nf_conntrack_broadcast(E) xt_CT(E) xt_tcpudp(E) ip6t_=
rpfilter(E) ip6t_REJECT(E) nf_reject_ipv6(E) ipt_REJECT(E) nf_reject_ipv4=
(E) xt_conntrack(E) ip_set(E) nfnetlink(E) ebtable_nat(E) ebtable_broute(=
E) bridge(E) stp(E) llc(E) ip6table_nat(E) nf_conntrack_ipv6(E) nf_defrag=
_ipv6(E) nf_nat_ipv6(E) ip6table_mangle(E) ip6table_raw(E) ip6table_secur=
ity(E) iptable_nat(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) nf_nat_ipv4(=
E) nf_nat(E) nf_conntrack(E) iptable_mangle(E) iptable_raw(E) iptable_sec=
urity(E) ebtable_filter(E) ebtables(E)
Aug 21 11:28:51 thor kernel: [   73.881276]  ip6table_filter(E) ip6_table=
s(E) iptable_filter(E) bpfilter(E) lz4(E) lz4_compress(E) cmac(E) cpufreq=
_conservative(E) cpufreq_powersave(E) cpufreq_userspace(E) bnep(E) binfmt=
_misc(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) pktcdvd(E) arc4(E) b43(=
E) mac80211(E) cfg80211(E) ssb(E) pcmcia(E) rtsx_pci_sdmmc(E) pcmcia_core=
(E) rtsx_pci_ms(E) mmc_core(E) memstick(E) edac_mce_amd(E) kvm_amd(E) ccp=
(E) btusb(E) btrtl(E) btbcm(E) btintel(E) kvm(E) irqbypass(E) crct10dif_p=
clmul(E) bluetooth(E) crc32_pclmul(E) drbg(E) ghash_clmulni_intel(E) ansi=
_cprng(E) efi_pstore(E) ecdh_generic(E) uvcvideo(E) videobuf2_vmalloc(E) =
videobuf2_memops(E) videobuf2_v4l2(E) videobuf2_common(E) videodev(E) med=
ia(E) joydev(E) pcspkr(E) hp_wmi(E) sparse_keymap(E) rfkill(E) wmi_bmof(E=
) snd_hda_codec_realtek(E) efivars(E)
Aug 21 11:28:51 thor kernel: [   73.881430]  snd_hda_codec_generic(E) snd=
_hda_codec_hdmi(E) snd_hda_intel(E) k10temp(E) fam15h_power(E) snd_hda_co=
dec(E) snd_hda_core(E) snd_hwdep(E) sp5100_tco(E) sr_mod(E) snd_pcm(E) cd=
rom(E) i2c_piix4(E) snd_timer(E) r8169(E) sg(E) mii(E) snd(E) rtsx_pci(E)=
 bcma(E) soundcore(E) tpm_infineon(E) battery(E) hp_accel(E) pcc_cpufreq(=
E) lis3lv02d(E) input_polldev(E) tpm_tis(E) tpm_tis_core(E) tpm(E) rng_co=
re(E) ac(E) acpi_cpufreq(E) hp_wireless(E) sch_fq_codel(E) cuse(E) fuse(E=
) tun(E) ddcci_backlight(OE) ddcci(OE) parport_pc(E) ppdev(E) lp(E) parpo=
rt(E) efivarfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mb=
cache(E) jbd2(E) fscrypto(E) dm_crypt(E) dm_mod(E) raid10(E) raid456(E) l=
ibcrc32c(E) crc32c_generic(E) async_raid6_recov(E) async_memcpy(E) async_=
pq(E) async_xor(E) xor(E) async_tx(E)
Aug 21 11:28:51 thor kernel: [   73.881596]  raid6_pq(E) raid1(E) raid0(E=
) multipath(E) linear(E) md_mod(E) hid_generic(E) hid_apple(E) usbhid(E) =
hid(E) sd_mod(E) ohci_pci(E) crc32c_intel(E) ehci_pci(E) aesni_intel(E) a=
es_x86_64(E) ohci_hcd(E) crypto_simd(E) ehci_hcd(E) cryptd(E) glue_helper=
(E) ahci(E) xhci_pci(E) psmouse(E) libahci(E) serio_raw(E) evdev(E) xhci_=
hcd(E) libata(E) scsi_mod(E) usbcore(E) wmi(E) thermal(E) video(E) button=
(E)
Aug 21 11:28:51 thor kernel: [   73.881691] CR2: 000000000000003c
Aug 21 11:28:51 thor kernel: [   73.881700] ---[ end trace b21c252497292e=
f0 ]---
Aug 21 11:28:51 thor kernel: [   73.881857] RIP: 0010:kv_dpm_get_sclk+0x1=
b/0x30 [amdgpu]
Aug 21 11:28:51 thor kernel: [   73.881861] Code: 1f 44 00 00 c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 60 48 00 00 48 8b 80 28 04 =
00 00 40 84 f6 74 03 8b 00 c3 <8b> 50 3c 83 ea 01 48 8d 14 52 8b 04 90 c3=
 0f 1f 80 00 00 00 00 0f=20
Aug 21 11:28:51 thor kernel: [   73.881992] RSP: 0018:ffffba09821038b8 EF=
LAGS: 00010246
Aug 21 11:28:51 thor kernel: [   73.881999] RAX: 0000000000000000 RBX: ff=
ff95726de47800 RCX: 0000000000000000
Aug 21 11:28:51 thor kernel: [   73.882005] RDX: ffffffffc11a3b10 RSI: 00=
00000000000000 RDI: ffff95726eb00000
Aug 21 11:28:51 thor kernel: [   73.882011] RBP: ffffba09821038e0 R08: ff=
ff95726eb00000 R09: 0000000000000000
Aug 21 11:28:51 thor kernel: [   73.882016] R10: 0000000000000000 R11: 00=
00000000000000 R12: ffff95726de47000
Aug 21 11:28:51 thor kernel: [   73.882021] R13: 000000000000707b R14: 00=
00000000000000 R15: 0000000000000000
Aug 21 11:28:51 thor kernel: [   73.882028] FS:  00007fe7f2c63b80(0000) G=
S:ffff95727ec80000(0000) knlGS:0000000000000000
Aug 21 11:28:51 thor kernel: [   73.882034] CS:  0010 DS: 0000 ES: 0000 C=
R0: 0000000080050033
Aug 21 11:28:51 thor kernel: [   73.882040] CR2: 000000000000003c CR3: 00=
0000022dddc000 CR4: 00000000000406e0

--------------5536448325CF61FA0C1687CF
Content-Type: text/x-log;
 name="vce-ib-fail.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="vce-ib-fail.log"

Aug 21 10:00:39 thor kernel: [   12.083947] [drm:vce_v2_0_start [amdgpu]]=
 *ERROR* VCE not responding, trying to reset the ECPU!!!
Aug 21 10:00:39 thor kernel: [   13.097295] [drm:vce_v2_0_start [amdgpu]]=
 *ERROR* VCE not responding, trying to reset the ECPU!!!
Aug 21 10:00:39 thor kernel: [   14.110558] [drm:vce_v2_0_start [amdgpu]]=
 *ERROR* VCE not responding, trying to reset the ECPU!!!
Aug 21 10:00:39 thor kernel: [   15.123804] [drm:vce_v2_0_start [amdgpu]]=
 *ERROR* VCE not responding, trying to reset the ECPU!!!
Aug 21 10:00:39 thor kernel: [   16.138056] [drm:vce_v2_0_start [amdgpu]]=
 *ERROR* VCE not responding, trying to reset the ECPU!!!
Aug 21 10:00:39 thor kernel: [   17.151455] [drm:vce_v2_0_start [amdgpu]]=
 *ERROR* VCE not responding, trying to reset the ECPU!!!
Aug 21 10:00:39 thor kernel: [   18.165417] [drm:vce_v2_0_start [amdgpu]]=
 *ERROR* VCE not responding, trying to reset the ECPU!!!
Aug 21 10:00:39 thor kernel: [   19.179664] [drm:vce_v2_0_start [amdgpu]]=
 *ERROR* VCE not responding, trying to reset the ECPU!!!
Aug 21 10:00:39 thor kernel: [   20.194125] [drm:vce_v2_0_start [amdgpu]]=
 *ERROR* VCE not responding, trying to reset the ECPU!!!
Aug 21 10:00:39 thor kernel: [   21.208779] [drm:vce_v2_0_start [amdgpu]]=
 *ERROR* VCE not responding, trying to reset the ECPU!!!
Aug 21 10:00:39 thor kernel: [   21.229692] [drm:vce_v2_0_start [amdgpu]]=
 *ERROR* VCE not responding, giving up!!!
Aug 21 10:00:39 thor kernel: [   21.230734] [drm:amdgpu_device_ip_set_pow=
ergating_state [amdgpu]] *ERROR* set_powergating_state of IP block <vce_v=
2_0> failed -110
Aug 21 10:00:39 thor kernel: [   22.268160] [drm:amdgpu_vce_ring_test_ib =
[amdgpu]] *ERROR* amdgpu: IB test timed out.
Aug 21 10:00:39 thor kernel: [   22.269751] [drm:amdgpu_ib_ring_tests [am=
dgpu]] *ERROR* amdgpu: failed testing IB on ring 12 (-110).
Aug 21 10:00:39 thor kernel: [   22.271415] [drm:amdgpu_device_ip_late_in=
it_func_handler [amdgpu]] *ERROR* ib ring test failed (-110).

--------------5536448325CF61FA0C1687CF
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------5536448325CF61FA0C1687CF--

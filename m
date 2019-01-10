From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Re: Trying to run AMD E9260 (Polaris 11) on NXP LS1012A-RDB
Date: Thu, 10 Jan 2019 11:55:16 +0100
Message-ID: <CAGtoiRiPHW8a3afkO3ui5FtLP-OztBjVz6CgMgLifgLvnk4QOg@mail.gmail.com>
References: <CAGtoiRiubNF5fCwGvYbC_sxzFk10Ceg79ZsK2fPLXUzFvm_QZw@mail.gmail.com>
 <CADnq5_MC9PLzvouWT=4J_RXkmsAy7NF1bpB-geEgxa-XV1dgQQ@mail.gmail.com>
 <CAGtoiRjahq_zC=QbS3gNCQB-nA++=gs=kKVJhWKNXEY0QQ8y=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2020701308=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAGtoiRjahq_zC=QbS3gNCQB-nA++=gs=kKVJhWKNXEY0QQ8y=g@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2020701308==
Content-Type: multipart/alternative; boundary="000000000000952639057f186ab7"

--000000000000952639057f186ab7
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

I've managed to get a little further. I am currently running mainline
(5.0.0-rc1) and am getting the errors below.
Looking at the datasheet for the LS1012A, it mentions in the PCI Express
section that:

The PCI Express controller as instantiated on this chip does not support
hardware coherency. All incoming PCI Express transactions are made non
IO-coherent.

Would AMDGPU still work with that PCI Express controller, or is this a
show-stopper?

[    5.727691] [drm] initializing kernel modesetting (POLARIS11
0x1002:0x67E8 0x1DA2:0xE362 0x80).
[    5.761767] [drm] register mmio base: 0x58000000
[    5.777272] [drm] register mmio size: 262144
[    5.825973] [drm] add ip block number 0 <vi_common>
[    5.832242] [drm] add ip block number 1 <gmc_v8_0>
[    5.837767] [drm] add ip block number 2 <tonga_ih>
[    5.843121] [drm] add ip block number 3 <gfx_v8_0>
[    5.848480] [drm] add ip block number 4 <sdma_v3_0>
[    5.853969] [drm] add ip block number 5 <powerplay>
[    5.859413] [drm] add ip block number 6 <dm>
[    5.864238] [drm] add ip block number 7 <uvd_v6_0>
[    5.869690] [drm] add ip block number 8 <vce_v3_0>
[    5.875067] [drm] UVD is enabled in VM mode
[    5.879858] [drm] UVD ENC is enabled in VM mode
[    5.884985] [drm] VCE enabled in VM mode
[    6.114020] ATOM BIOS: 113-C98511-U01
[    6.117757] [drm] GPU posting now...
[    6.238112] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
fragment size is 9-bit
[    6.247290] amdgpu 0000:01:00.0: BAR 2: releasing [mem
0x4050000000-0x40501fffff 64bit pref]
[    6.257354] amdgpu 0000:01:00.0: BAR 0: releasing [mem
0x4040000000-0x404fffffff 64bit pref]
[    6.267261] pcieport 0000:00:00.0: BAR 15: releasing [mem
0x4040000000-0x4057ffffff 64bit pref]
[    6.277288] pcieport 0000:00:00.0: BAR 15: no space for [mem size
0x300000000 64bit pref]
[    6.286843] pcieport 0000:00:00.0: BAR 15: failed to assign [mem size
0x300000000 64bit pref]
[    6.296708] amdgpu 0000:01:00.0: BAR 0: no space for [mem size
0x200000000 64bit pref]
[    6.306009] amdgpu 0000:01:00.0: BAR 0: failed to assign [mem size
0x200000000 64bit pref]
[    6.315635] amdgpu 0000:01:00.0: BAR 2: no space for [mem size
0x00200000 64bit pref]
[    6.324804] amdgpu 0000:01:00.0: BAR 2: failed to assign [mem size
0x00200000 64bit pref]
[    6.334366] pcieport 0000:00:00.0: PCI bridge to [bus 01-ff]
[    6.341323] pcieport 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    6.349158] pcieport 0000:00:00.0:   bridge window [mem
0x4058000000-0x40580fffff]
[    6.358095] pcieport 0000:00:00.0: PCI bridge to [bus 01-ff]
[    6.365054] pcieport 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    6.372981] pcieport 0000:00:00.0:   bridge window [mem
0x4058000000-0x40580fffff]
[    6.381917] pcieport 0000:00:00.0:   bridge window [mem
0x4040000000-0x4057ffffff 64bit pref]
[    6.391789] [drm] Not enough PCI address space for a large BAR.
[    6.391820] amdgpu 0000:01:00.0: BAR 0: assigned [mem
0x4040000000-0x404fffffff 64bit pref]
[    6.407776] amdgpu 0000:01:00.0: BAR 2: assigned [mem
0x4050000000-0x40501fffff 64bit pref]
[    6.417672] amdgpu 0000:01:00.0: VRAM: 8192M 0x000000F400000000 -
0x000000F5FFFFFFFF (8192M used)
[    6.426586] amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 -
0x000000FF0FFFFFFF
[    6.436171] [drm] Detected VRAM RAM=8192M, BAR=256M
[    6.478952] [drm] GART: num cpu pages 65536, num gpu pages 65536
[    6.487871] [drm] PCIE GART of 256M enabled (table at
0x000000F400000000).
[    6.496316] amdgpu 0000:01:00.0: Direct firmware load for
amdgpu/polaris11_pfp_2.bin failed with error -2
[    6.508078] amdgpu 0000:01:00.0: Direct firmware load for
amdgpu/polaris11_me_2.bin failed with error -2
[    6.519538] amdgpu 0000:01:00.0: Direct firmware load for
amdgpu/polaris11_ce_2.bin failed with error -2
[    6.531496] amdgpu 0000:01:00.0: Direct firmware load for
amdgpu/polaris11_mec_2.bin failed with error -2
[    6.544214] amdgpu 0000:01:00.0: Direct firmware load for
amdgpu/polaris11_mec2_2.bin failed with error -2
[    6.565121] [drm] Found UVD firmware Version: 1.79 Family ID: 16
[    6.571241] [drm] UVD ENC is disabled
[    6.580927] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[    6.656854] amdgpu 0000:01:00.0: GPU fault detected: 147 0x00004802 for
process  pid 0 thread  pid 0
[    6.666013] amdgpu 0000:01:00.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR
 0x0017F000
[    6.673508] amdgpu 0000:01:00.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS
0x02048002
[    6.681006] amdgpu 0000:01:00.0: VM fault (0x02, vmid 1, pasid 0) at
page 1568768, read from 'TC0' (0x54433000) (72)
[    6.691557] amdgpu 0000:01:00.0: GPU fault detected: 147 0x00004402 for
process  pid 0 thread  pid 0
[    6.700706] amdgpu 0000:01:00.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR
 0x0017F000
[    6.708200] amdgpu 0000:01:00.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS
0x02048002
[    6.715697] amdgpu 0000:01:00.0: VM fault (0x02, vmid 1, pasid 0) at
page 1568768, read from 'TC0' (0x54433000) (72)
[    6.726246] amdgpu 0000:01:00.0: GPU fault detected: 147 0x00000402 for
process  pid 0 thread  pid 0
[    6.735395] amdgpu 0000:01:00.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR
 0x0017F000
[    6.742889] amdgpu 0000:01:00.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS
0x02048002
[    6.750386] amdgpu 0000:01:00.0: VM fault (0x02, vmid 1, pasid 0) at
page 1568768, read from 'TC0' (0x54433000) (72)
[    6.984485] amdgpu 0000:01:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring gfx test failed (-110)
[    6.994562] [drm:amdgpu_device_init [amdgpu]] *ERROR* hw_init of IP
block <gfx_v8_0> failed -110
[    7.004942] amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
[    7.011963] amdgpu 0000:01:00.0: Fatal error during GPU init
[    7.018890] [drm] amdgpu: finishing device.
[    7.308898] WARNING: CPU: 0 PID: 2084 at
/home/bas/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:915
amdgpu_bo_unpin+0xe4/0x110 [amdgpu]
[    7.321451] Modules linked in: amdgpu(+) realtek chash gpu_sched ttm
drm_kms_helper drm crct10dif_ce drm_panel_orientation_quirks pfe(C)
ip_tables x_tables ipv6
[    7.335850] CPU: 0 PID: 2084 Comm: systemd-udevd Tainted: G         C
    5.0.0-rc1-00001-g3bd6e94bec12-dirty #1
[    7.346303] Hardware name: LS1012A RDB Board (DT)
[    7.351014] pstate: 40000005 (nZcv daif -PAN -UAO)
[    7.356090] pc : amdgpu_bo_unpin+0xe4/0x110 [amdgpu]
[    7.361307] lr : amdgpu_bo_free_kernel+0x7c/0x148 [amdgpu]
[    7.366799] sp : ffff0000118c3730
[    7.370114] x29: ffff0000118c3730 x28: ffff000008e63710
[    7.375434] x27: ffff0000118c3df0 x26: 0000000000000100
[    7.380754] x25: ffff80003599cb60 x24: ffff8000359927d0
[    7.386073] x23: ffff800035994750 x22: ffff8000359927d0
[    7.391393] x21: ffff8000358cb800 x20: ffff0000111fd000
[    7.396713] x19: ffff8000358cb800 x18: 000000000000001e
[    7.402033] x17: 0000000000000000 x16: 0000000000000002
[    7.407351] x15: 0000000000000400 x14: 0000000000000400
[    7.412670] x13: 000000000000cb72 x12: 000000000000b308
[    7.417989] x11: ffff7e0000d02488 x10: ffff800037798030
[    7.423308] x9 : ffff0000118c36e4 x8 : 0000000000000000
[    7.428627] x7 : 0000000000210d00 x6 : 0000000000000000
[    7.433946] x5 : 0000000000000001 x4 : 0000000000000001
[    7.439265] x3 : ffff8000358cb87c x2 : 0000000000000000
[    7.444583] x1 : 0000000000000000 x0 : ffff8000358cb800
[    7.449903] Call trace:
[    7.452583]  amdgpu_bo_unpin+0xe4/0x110 [amdgpu]
[    7.457437]  amdgpu_bo_free_kernel+0x7c/0x148 [amdgpu]
[    7.462812]  amdgpu_gfx_rlc_fini+0x50/0x78 [amdgpu]
[    7.467926]  gfx_v8_0_sw_fini+0xfc/0x1c0 [amdgpu]
[    7.472864]  amdgpu_device_fini+0x1e0/0x480 [amdgpu]
[    7.478058]  amdgpu_driver_unload_kms+0xa0/0x150 [amdgpu]
[    7.483686]  amdgpu_driver_load_kms+0x144/0x1f8 [amdgpu]
[    7.489110]  drm_dev_register+0x14c/0x1e0 [drm]
[    7.493906]  amdgpu_pci_probe+0xcc/0x188 [amdgpu]
[    7.498622]  local_pci_probe+0x3c/0xb0
[    7.502375]  pci_device_probe+0x150/0x1b8
[    7.506390]  really_probe+0x1f0/0x298
[    7.510055]  driver_probe_device+0x58/0x100
[    7.514242]  __driver_attach+0xd4/0xd8
[    7.517993]  bus_for_each_dev+0x74/0xc8
[    7.521832]  driver_attach+0x20/0x28
[    7.525410]  bus_add_driver+0x1ac/0x218
[    7.529250]  driver_register+0x60/0x110
[    7.533089]  __pci_register_driver+0x40/0x48
[    7.537599]  amdgpu_init+0x58/0x1000 [amdgpu]
[    7.541964]  do_one_initcall+0x5c/0x178
[    7.545804]  do_init_module+0x58/0x1b0
[    7.549556]  load_module+0x1dc8/0x2178
[    7.553308]  __se_sys_finit_module+0xbc/0xd0
[    7.557582]  __arm64_sys_finit_module+0x18/0x20
[    7.562119]  el0_svc_common+0x60/0x100
[    7.565872]  el0_svc_handler+0x2c/0x80
[    7.581715] amdgpu 0000:01:00.0: (____ptrval____) unpin not necessary
[    7.594743] [TTM] Finalizing pool allocator
[    7.599867] [TTM] Finalizing DMA pool allocator
[    7.605265] [TTM] Zone  kernel: Used memory at exit: 0 kiB
[    7.611482] [drm] amdgpu: ttm finalized
[    7.618028] amdgpu: probe of 0000:01:00.0 failed with error -110

Bas Vermeulen


On Thu, Dec 20, 2018 at 5:11 PM Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org> wrote:

> Hi Alex,
>
> I already have a similar patch in, that doesn't fix it just yet. I'll
> investigate some more.
>
> Bas Vermeulen
>
> On Thu, Dec 20, 2018 at 4:27 PM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
>
>> On Thu, Dec 20, 2018 at 9:06 AM Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org> wrote:
>> >
>> > Hi all,
>> >
>> > I have connected an E9260 (Polaris 11 based) to a mini-PCIe slot on my
>> NXP LS1012ARDB.
>> > The GPU is seen, all the BARs are correctly assigned (but there's not
>> enough PCIe memory space for the big BARs).
>> >
>> > When I try to load the amdgpu module, I can't get the driver to enable
>> the acceleration (the scratch register check fails).
>> >
>> > The E9260 is connected to a PCIe x1 (Gen2) slot.
>> >
>> > Anyone have an idea on where to look or how to fix this? This is a
>> test-bed before we get an LS1046ARDB with quad core A72's.
>> >
>> > Any help would be appreciated,
>>
>> Something like this patch should fix it assuming this is an ARM based
>> platform:
>> https://patchwork.freedesktop.org/patch/269367/
>>
>> Alex
>>
>> >
>> > Bas Vermeulen
>> > _______________________________________________
>> > amd-gfx mailing list
>> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>

--000000000000952639057f186ab7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr">Hi Alex,<div><br></div><div>I&#39;ve managed to get a little furt=
her. I am currently running mainline (5.0.0-rc1) and am getting the errors =
below.</div><div>Looking at the datasheet for the LS1012A, it mentions in t=
he PCI Express section that:<br><br>The PCI Express controller as instantia=
ted on this chip does not
support hardware coherency. All incoming PCI Express
transactions are made non IO-coherent.</div><div><br></div><div>Would AMDGP=
U still work with that PCI Express controller, or is this a show-stopper?</=
div><div><br><div>[=C2=A0 =C2=A0 5.727691] [drm] initializing kernel modese=
tting (POLARIS11 0x1002:0x67E8 0x1DA2:0xE362 0x80).</div><div>[=C2=A0 =C2=
=A0 5.761767] [drm] register mmio base: 0x58000000</div><div>[=C2=A0 =C2=A0=
 5.777272] [drm] register mmio size: 262144</div><div>[=C2=A0 =C2=A0 5.8259=
73] [drm] add ip block number 0 &lt;vi_common&gt;</div><div>[=C2=A0 =C2=A0 =
5.832242] [drm] add ip block number 1 &lt;gmc_v8_0&gt;</div><div>[=C2=A0 =
=C2=A0 5.837767] [drm] add ip block number 2 &lt;tonga_ih&gt;</div><div>[=
=C2=A0 =C2=A0 5.843121] [drm] add ip block number 3 &lt;gfx_v8_0&gt;</div><=
div>[=C2=A0 =C2=A0 5.848480] [drm] add ip block number 4 &lt;sdma_v3_0&gt;<=
/div><div>[=C2=A0 =C2=A0 5.853969] [drm] add ip block number 5 &lt;powerpla=
y&gt;</div><div>[=C2=A0 =C2=A0 5.859413] [drm] add ip block number 6 &lt;dm=
&gt;</div><div>[=C2=A0 =C2=A0 5.864238] [drm] add ip block number 7 &lt;uvd=
_v6_0&gt;</div><div>[=C2=A0 =C2=A0 5.869690] [drm] add ip block number 8 &l=
t;vce_v3_0&gt;</div><div>[=C2=A0 =C2=A0 5.875067] [drm] UVD is enabled in V=
M mode</div><div>[=C2=A0 =C2=A0 5.879858] [drm] UVD ENC is enabled in VM mo=
de</div><div>[=C2=A0 =C2=A0 5.884985] [drm] VCE enabled in VM mode</div><di=
v>[=C2=A0 =C2=A0 6.114020] ATOM BIOS: 113-C98511-U01</div><div>[=C2=A0 =C2=
=A0 6.117757] [drm] GPU posting now...</div><div>[=C2=A0 =C2=A0 6.238112] [=
drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-b=
it</div><div>[=C2=A0 =C2=A0 6.247290] amdgpu 0000:01:00.0: BAR 2: releasing=
 [mem 0x4050000000-0x40501fffff 64bit pref]</div><div>[=C2=A0 =C2=A0 6.2573=
54] amdgpu 0000:01:00.0: BAR 0: releasing [mem 0x4040000000-0x404fffffff 64=
bit pref]</div><div>[=C2=A0 =C2=A0 6.267261] pcieport 0000:00:00.0: BAR 15:=
 releasing [mem 0x4040000000-0x4057ffffff 64bit pref]</div><div>[=C2=A0 =C2=
=A0 6.277288] pcieport 0000:00:00.0: BAR 15: no space for [mem size 0x30000=
0000 64bit pref]</div><div>[=C2=A0 =C2=A0 6.286843] pcieport 0000:00:00.0: =
BAR 15: failed to assign [mem size 0x300000000 64bit pref]</div><div>[=C2=
=A0 =C2=A0 6.296708] amdgpu 0000:01:00.0: BAR 0: no space for [mem size 0x2=
00000000 64bit pref]</div><div>[=C2=A0 =C2=A0 6.306009] amdgpu 0000:01:00.0=
: BAR 0: failed to assign [mem size 0x200000000 64bit pref]</div><div>[=C2=
=A0 =C2=A0 6.315635] amdgpu 0000:01:00.0: BAR 2: no space for [mem size 0x0=
0200000 64bit pref]</div><div>[=C2=A0 =C2=A0 6.324804] amdgpu 0000:01:00.0:=
 BAR 2: failed to assign [mem size 0x00200000 64bit pref]</div><div>[=C2=A0=
 =C2=A0 6.334366] pcieport 0000:00:00.0: PCI bridge to [bus 01-ff]</div><di=
v>[=C2=A0 =C2=A0 6.341323] pcieport 0000:00:00.0:=C2=A0 =C2=A0bridge window=
 [io=C2=A0 0x1000-0x1fff]</div><div>[=C2=A0 =C2=A0 6.349158] pcieport 0000:=
00:00.0:=C2=A0 =C2=A0bridge window [mem 0x4058000000-0x40580fffff]</div><di=
v>[=C2=A0 =C2=A0 6.358095] pcieport 0000:00:00.0: PCI bridge to [bus 01-ff]=
</div><div>[=C2=A0 =C2=A0 6.365054] pcieport 0000:00:00.0:=C2=A0 =C2=A0brid=
ge window [io=C2=A0 0x1000-0x1fff]</div><div>[=C2=A0 =C2=A0 6.372981] pciep=
ort 0000:00:00.0:=C2=A0 =C2=A0bridge window [mem 0x4058000000-0x40580fffff]=
</div><div>[=C2=A0 =C2=A0 6.381917] pcieport 0000:00:00.0:=C2=A0 =C2=A0brid=
ge window [mem 0x4040000000-0x4057ffffff 64bit pref]</div><div>[=C2=A0 =C2=
=A0 6.391789] [drm] Not enough PCI address space for a large BAR.</div><div=
>[=C2=A0 =C2=A0 6.391820] amdgpu 0000:01:00.0: BAR 0: assigned [mem 0x40400=
00000-0x404fffffff 64bit pref]</div><div>[=C2=A0 =C2=A0 6.407776] amdgpu 00=
00:01:00.0: BAR 2: assigned [mem 0x4050000000-0x40501fffff 64bit pref]</div=
><div>[=C2=A0 =C2=A0 6.417672] amdgpu 0000:01:00.0: VRAM: 8192M 0x000000F40=
0000000 - 0x000000F5FFFFFFFF (8192M used)</div><div>[=C2=A0 =C2=A0 6.426586=
] amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF</=
div><div>[=C2=A0 =C2=A0 6.436171] [drm] Detected VRAM RAM=3D8192M, BAR=3D25=
6M</div><div>[=C2=A0 =C2=A0 6.478952] [drm] GART: num cpu pages 65536, num =
gpu pages 65536</div><div><div>[=C2=A0 =C2=A0 6.487871] [drm] PCIE GART of =
256M enabled (table at 0x000000F400000000).</div><div>[=C2=A0 =C2=A0 6.4963=
16] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris11_pfp_2.bi=
n failed with error -2</div><div>[=C2=A0 =C2=A0 6.508078] amdgpu 0000:01:00=
.0: Direct firmware load for amdgpu/polaris11_me_2.bin failed with error -2=
</div><div>[=C2=A0 =C2=A0 6.519538] amdgpu 0000:01:00.0: Direct firmware lo=
ad for amdgpu/polaris11_ce_2.bin failed with error -2</div><div>[=C2=A0 =C2=
=A0 6.531496] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris1=
1_mec_2.bin failed with error -2</div><div>[=C2=A0 =C2=A0 6.544214] amdgpu =
0000:01:00.0: Direct firmware load for amdgpu/polaris11_mec2_2.bin failed w=
ith error -2</div><div>[=C2=A0 =C2=A0 6.565121] [drm] Found UVD firmware Ve=
rsion: 1.79 Family ID: 16</div><div>[=C2=A0 =C2=A0 6.571241] [drm] UVD ENC =
is disabled</div><div>[=C2=A0 =C2=A0 6.580927] [drm] Found VCE firmware Ver=
sion: 52.4 Binary ID: 3</div><div>[=C2=A0 =C2=A0 6.656854] amdgpu 0000:01:0=
0.0: GPU fault detected: 147 0x00004802 for process=C2=A0 pid 0 thread=C2=
=A0 pid 0</div><div>[=C2=A0 =C2=A0 6.666013] amdgpu 0000:01:00.0:=C2=A0 =C2=
=A0VM_CONTEXT1_PROTECTION_FAULT_ADDR=C2=A0 =C2=A00x0017F000</div><div>[=C2=
=A0 =C2=A0 6.673508] amdgpu 0000:01:00.0:=C2=A0 =C2=A0VM_CONTEXT1_PROTECTIO=
N_FAULT_STATUS 0x02048002</div><div>[=C2=A0 =C2=A0 6.681006] amdgpu 0000:01=
:00.0: VM fault (0x02, vmid 1, pasid 0) at page 1568768, read from &#39;TC0=
&#39; (0x54433000) (72)</div><div>[=C2=A0 =C2=A0 6.691557] amdgpu 0000:01:0=
0.0: GPU fault detected: 147 0x00004402 for process=C2=A0 pid 0 thread=C2=
=A0 pid 0</div><div>[=C2=A0 =C2=A0 6.700706] amdgpu 0000:01:00.0:=C2=A0 =C2=
=A0VM_CONTEXT1_PROTECTION_FAULT_ADDR=C2=A0 =C2=A00x0017F000</div><div>[=C2=
=A0 =C2=A0 6.708200] amdgpu 0000:01:00.0:=C2=A0 =C2=A0VM_CONTEXT1_PROTECTIO=
N_FAULT_STATUS 0x02048002</div><div>[=C2=A0 =C2=A0 6.715697] amdgpu 0000:01=
:00.0: VM fault (0x02, vmid 1, pasid 0) at page 1568768, read from &#39;TC0=
&#39; (0x54433000) (72)</div><div>[=C2=A0 =C2=A0 6.726246] amdgpu 0000:01:0=
0.0: GPU fault detected: 147 0x00000402 for process=C2=A0 pid 0 thread=C2=
=A0 pid 0</div><div>[=C2=A0 =C2=A0 6.735395] amdgpu 0000:01:00.0:=C2=A0 =C2=
=A0VM_CONTEXT1_PROTECTION_FAULT_ADDR=C2=A0 =C2=A00x0017F000</div><div>[=C2=
=A0 =C2=A0 6.742889] amdgpu 0000:01:00.0:=C2=A0 =C2=A0VM_CONTEXT1_PROTECTIO=
N_FAULT_STATUS 0x02048002</div><div>[=C2=A0 =C2=A0 6.750386] amdgpu 0000:01=
:00.0: VM fault (0x02, vmid 1, pasid 0) at page 1568768, read from &#39;TC0=
&#39; (0x54433000) (72)</div><div>[=C2=A0 =C2=A0 6.984485] amdgpu 0000:01:0=
0.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring gfx test failed (-=
110)</div><div>[=C2=A0 =C2=A0 6.994562] [drm:amdgpu_device_init [amdgpu]] *=
ERROR* hw_init of IP block &lt;gfx_v8_0&gt; failed -110</div><div>[=C2=A0 =
=C2=A0 7.004942] amdgpu 0000:01:00.0: amdgpu_device_ip_init failed</div><di=
v>[=C2=A0 =C2=A0 7.011963] amdgpu 0000:01:00.0: Fatal error during GPU init=
</div><div>[=C2=A0 =C2=A0 7.018890] [drm] amdgpu: finishing device.</div></=
div></div><div><div>[=C2=A0 =C2=A0 7.308898] WARNING: CPU: 0 PID: 2084 at /=
home/bas/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:915 amdgpu_bo_unp=
in+0xe4/0x110 [amdgpu]</div><div>[=C2=A0 =C2=A0 7.321451] Modules linked in=
: amdgpu(+) realtek chash gpu_sched ttm drm_kms_helper drm crct10dif_ce drm=
_panel_orientation_quirks pfe(C) ip_tables x_tables ipv6</div><div>[=C2=A0 =
=C2=A0 7.335850] CPU: 0 PID: 2084 Comm: systemd-udevd Tainted: G=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0C=C2=A0 =C2=A0 =C2=A0 =C2=A0 5.0.0-rc1-00001-g3bd6e=
94bec12-dirty #1</div><div>[=C2=A0 =C2=A0 7.346303] Hardware name: LS1012A =
RDB Board (DT)</div><div>[=C2=A0 =C2=A0 7.351014] pstate: 40000005 (nZcv da=
if -PAN -UAO)</div><div>[=C2=A0 =C2=A0 7.356090] pc : amdgpu_bo_unpin+0xe4/=
0x110 [amdgpu]</div><div>[=C2=A0 =C2=A0 7.361307] lr : amdgpu_bo_free_kerne=
l+0x7c/0x148 [amdgpu]</div><div>[=C2=A0 =C2=A0 7.366799] sp : ffff0000118c3=
730</div><div>[=C2=A0 =C2=A0 7.370114] x29: ffff0000118c3730 x28: ffff00000=
8e63710=C2=A0</div><div>[=C2=A0 =C2=A0 7.375434] x27: ffff0000118c3df0 x26:=
 0000000000000100=C2=A0</div><div>[=C2=A0 =C2=A0 7.380754] x25: ffff8000359=
9cb60 x24: ffff8000359927d0=C2=A0</div><div>[=C2=A0 =C2=A0 7.386073] x23: f=
fff800035994750 x22: ffff8000359927d0=C2=A0</div><div>[=C2=A0 =C2=A0 7.3913=
93] x21: ffff8000358cb800 x20: ffff0000111fd000=C2=A0</div><div>[=C2=A0 =C2=
=A0 7.396713] x19: ffff8000358cb800 x18: 000000000000001e=C2=A0</div><div>[=
=C2=A0 =C2=A0 7.402033] x17: 0000000000000000 x16: 0000000000000002=C2=A0</=
div><div>[=C2=A0 =C2=A0 7.407351] x15: 0000000000000400 x14: 00000000000004=
00=C2=A0</div><div>[=C2=A0 =C2=A0 7.412670] x13: 000000000000cb72 x12: 0000=
00000000b308=C2=A0</div><div>[=C2=A0 =C2=A0 7.417989] x11: ffff7e0000d02488=
 x10: ffff800037798030=C2=A0</div><div>[=C2=A0 =C2=A0 7.423308] x9 : ffff00=
00118c36e4 x8 : 0000000000000000=C2=A0</div><div>[=C2=A0 =C2=A0 7.428627] x=
7 : 0000000000210d00 x6 : 0000000000000000=C2=A0</div><div>[=C2=A0 =C2=A0 7=
.433946] x5 : 0000000000000001 x4 : 0000000000000001=C2=A0</div><div>[=C2=
=A0 =C2=A0 7.439265] x3 : ffff8000358cb87c x2 : 0000000000000000=C2=A0</div=
><div>[=C2=A0 =C2=A0 7.444583] x1 : 0000000000000000 x0 : ffff8000358cb800=
=C2=A0</div><div>[=C2=A0 =C2=A0 7.449903] Call trace:</div><div>[=C2=A0 =C2=
=A0 7.452583]=C2=A0 amdgpu_bo_unpin+0xe4/0x110 [amdgpu]</div><div>[=C2=A0 =
=C2=A0 7.457437]=C2=A0 amdgpu_bo_free_kernel+0x7c/0x148 [amdgpu]</div><div>=
[=C2=A0 =C2=A0 7.462812]=C2=A0 amdgpu_gfx_rlc_fini+0x50/0x78 [amdgpu]</div>=
<div>[=C2=A0 =C2=A0 7.467926]=C2=A0 gfx_v8_0_sw_fini+0xfc/0x1c0 [amdgpu]</d=
iv><div>[=C2=A0 =C2=A0 7.472864]=C2=A0 amdgpu_device_fini+0x1e0/0x480 [amdg=
pu]</div><div>[=C2=A0 =C2=A0 7.478058]=C2=A0 amdgpu_driver_unload_kms+0xa0/=
0x150 [amdgpu]</div><div>[=C2=A0 =C2=A0 7.483686]=C2=A0 amdgpu_driver_load_=
kms+0x144/0x1f8 [amdgpu]</div><div>[=C2=A0 =C2=A0 7.489110]=C2=A0 drm_dev_r=
egister+0x14c/0x1e0 [drm]</div><div>[=C2=A0 =C2=A0 7.493906]=C2=A0 amdgpu_p=
ci_probe+0xcc/0x188 [amdgpu]</div><div>[=C2=A0 =C2=A0 7.498622]=C2=A0 local=
_pci_probe+0x3c/0xb0</div><div>[=C2=A0 =C2=A0 7.502375]=C2=A0 pci_device_pr=
obe+0x150/0x1b8</div><div>[=C2=A0 =C2=A0 7.506390]=C2=A0 really_probe+0x1f0=
/0x298</div><div>[=C2=A0 =C2=A0 7.510055]=C2=A0 driver_probe_device+0x58/0x=
100</div><div>[=C2=A0 =C2=A0 7.514242]=C2=A0 __driver_attach+0xd4/0xd8</div=
><div>[=C2=A0 =C2=A0 7.517993]=C2=A0 bus_for_each_dev+0x74/0xc8</div><div>[=
=C2=A0 =C2=A0 7.521832]=C2=A0 driver_attach+0x20/0x28</div><div>[=C2=A0 =C2=
=A0 7.525410]=C2=A0 bus_add_driver+0x1ac/0x218</div><div>[=C2=A0 =C2=A0 7.5=
29250]=C2=A0 driver_register+0x60/0x110</div><div>[=C2=A0 =C2=A0 7.533089]=
=C2=A0 __pci_register_driver+0x40/0x48</div><div>[=C2=A0 =C2=A0 7.537599]=
=C2=A0 amdgpu_init+0x58/0x1000 [amdgpu]</div><div>[=C2=A0 =C2=A0 7.541964]=
=C2=A0 do_one_initcall+0x5c/0x178</div><div>[=C2=A0 =C2=A0 7.545804]=C2=A0 =
do_init_module+0x58/0x1b0</div><div>[=C2=A0 =C2=A0 7.549556]=C2=A0 load_mod=
ule+0x1dc8/0x2178</div><div>[=C2=A0 =C2=A0 7.553308]=C2=A0 __se_sys_finit_m=
odule+0xbc/0xd0</div><div>[=C2=A0 =C2=A0 7.557582]=C2=A0 __arm64_sys_finit_=
module+0x18/0x20</div><div>[=C2=A0 =C2=A0 7.562119]=C2=A0 el0_svc_common+0x=
60/0x100</div><div>[=C2=A0 =C2=A0 7.565872]=C2=A0 el0_svc_handler+0x2c/0x80=
</div></div><div><div>[=C2=A0 =C2=A0 7.581715] amdgpu 0000:01:00.0: (____pt=
rval____) unpin not necessary</div><div>[=C2=A0 =C2=A0 7.594743] [TTM] Fina=
lizing pool allocator</div><div>[=C2=A0 =C2=A0 7.599867] [TTM] Finalizing D=
MA pool allocator</div><div>[=C2=A0 =C2=A0 7.605265] [TTM] Zone=C2=A0 kerne=
l: Used memory at exit: 0 kiB</div><div>[=C2=A0 =C2=A0 7.611482] [drm] amdg=
pu: ttm finalized</div><div>[=C2=A0 =C2=A0 7.618028] amdgpu: probe of 0000:=
01:00.0 failed with error -110</div></div><div><br></div><div>Bas Vermeulen=
</div><div><br></div></div></div></div></div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr">On Thu, Dec 20, 2018 at 5:11 PM Bas Vermeulen &lt;<=
a href=3D"mailto:bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org">bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi Alex=
,<div><br></div><div>I already have a similar patch in, that doesn&#39;t fi=
x it just yet. I&#39;ll investigate some more.</div><div><br></div><div>Bas=
 Vermeulen</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Th=
u, Dec 20, 2018 at 4:27 PM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@g=
mail.com" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Dec 20, 2018 at 9:=
06 AM Bas Vermeulen &lt;<a href=3D"mailto:bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org" target=3D"_blan=
k">bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I have connected an E9260 (Polaris 11 based) to a mini-PCIe slot on my=
 NXP LS1012ARDB.<br>
&gt; The GPU is seen, all the BARs are correctly assigned (but there&#39;s =
not enough PCIe memory space for the big BARs).<br>
&gt;<br>
&gt; When I try to load the amdgpu module, I can&#39;t get the driver to en=
able the acceleration (the scratch register check fails).<br>
&gt;<br>
&gt; The E9260 is connected to a PCIe x1 (Gen2) slot.<br>
&gt;<br>
&gt; Anyone have an idea on where to look or how to fix this? This is a tes=
t-bed before we get an LS1046ARDB with quad core A72&#39;s.<br>
&gt;<br>
&gt; Any help would be appreciated,<br>
<br>
Something like this patch should fix it assuming this is an ARM based platf=
orm:<br>
<a href=3D"https://patchwork.freedesktop.org/patch/269367/" rel=3D"noreferr=
er" target=3D"_blank">https://patchwork.freedesktop.org/patch/269367/</a><b=
r>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Bas Vermeulen<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>
</blockquote></div>

--000000000000952639057f186ab7--

--===============2020701308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2020701308==--

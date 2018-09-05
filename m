From: Acewind <acewind-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: gim error:(set_new_adapter:791) fail to enable MSI
Date: Wed, 5 Sep 2018 10:35:04 +0800
Message-ID: <CA+B2R55ZE0VmmzYsrH70Q-JtAq-opdH0Ry0_GY9TNhFEjanEnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1765066179=="
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

--===============1765066179==
Content-Type: multipart/alternative; boundary="000000000000eab9990575169fb5"

--000000000000eab9990575169fb5
Content-Type: text/plain; charset="UTF-8"

I'm working on AMD FirePro S7150 GPU passthrough by SRIOV on CentOS 7.3
(kernel = 3.10.0-514).
According to the two patches from
https://github.com/GPUOpen-LibrariesAndSDKs/MxGPU-Virtualization, I have
patched the kernel and rebooted.
Iommu and sriov are both enabled, 8 VFs can be found.
But there's error from dmesg:  gim error:(set_new_adapter:791) fail to
enable MSI
And in win7 guests os, the AMD driver always show error code 43.
Are the two errors related? Or MSI error can be ignored?

[   10.859725] gim: loading out-of-tree module taints kernel.
[   10.860008] gim: module verification failed: signature and/or required
key missing - tainting kernel
[   10.861041] gim info:(gim_init:144) Start AMD open source GIM
initialization
[   10.861045] gim info:(gim_init:147) GPU IOV MODULE - version 1.0.0-k
[   10.861047] gim info:(gim_init:149) Copyright (c) 2014-2017 AMD
Corporation.
[   10.861069] gim info:(init_config:305) INIT CONFIG
[   10.861091] gim info:(set_new_adapter:614) curr allocated at
ffffffffa0326a40
[   10.861092] gim info:(set_new_adapter:621) SRIOV is supported
[   10.861098] gim info:(set_new_adapter:629) found PCI bridge device
[   10.861100] gim info:(set_new_adapter:633) found: 00:2.0
[   10.861122] gim info:(set_new_adapter:650) mmio_base = ffffc90007180000
[   10.861130] gim info:(set_new_adapter:652) doorbell = ffffc90007c00000
[   10.861147] gim info:(set_new_adapter:654) pf.fb_va = ffffc90040000000
[   10.861159] gim info:(sriov_is_ari_enabled:164) PCI_SRIOV_CAP =
0x00000002
[   10.861162] gim info:(sriov_is_ari_enabled:173) PCI_SRIOV_CTRL =
0x00000010
[   10.861163] gim info:(sriov_is_ari_enabled:176) PCI_SRIOV_CTRL_ARI is
set --> ARI is supported
[   10.861167] gim info:(program_ari_mode:483) Read bif_strap8 = 0x00200004
[   10.861169] gim info:(program_ari_mode:488) program_ari_mode - Set
ARI_Mode = PF_BUS
[   10.861171] gim info:(program_ari_mode:498) Write bif_strap8 = 0x00000004
[   10.861173] gim info:(gim_read_rom_from_reg:222) Reading VBios from ROM
[   10.861290] gim info:(gim_read_vbios:284) VBIOS starts:  0x55, 0xaa
[   10.861292] gim info:(gim_read_vbios:287) VBios size is 0x10000
[   10.861299] gim info:(gim_read_vbios:290) vbios allocated at
ffffc90006d7d000
[   10.861301] gim info:(gim_read_rom_from_reg:222) Reading VBios from ROM
[   10.994958] gim info:(gim_read_vbios:298) BIOS Version Major 0xF Minor
0x31
[   10.994999] gim info:(gim_read_vbios:311) Valid video BIOS image,
[   10.995000] gim info:(gim_read_vbios:313) size = 0x10000, check sum is
0x53b100
[   10.995011] gim info:(gim_post_vbios:344) Init Parser passed!, continue
[   10.995015] gim info:(atom_chk_asic_status:335) ATOM_CheckAsicStatus -
BIOS_SCRATCH_7 = 0x00000000
[   10.995016] gim info:(atom_chk_asic_status:338) Isolate
ATOM_S7_ASIC_INIT_COMPLETE_MASK bit(s) = 0x00000000
[   10.995018] gim info:(atom_chk_asic_status:341) RLC_CNTL = 0x00000000
[   10.995019] gim info:(atom_chk_asic_status:343) Isolate
RLC_CNTL__RLC_ENABLE_F32_MASK = 0x00000000
[   10.995020] gim info:(atom_chk_asic_status:350) ATOM_ASIC_NEED_POST
[   10.995021] gim info:(gim_post_vbios:347) Asic needs a VBios post
[   10.995022] gim info:(atom_post_vbios:200) ATOM_PostVBIOS: firmware_info
passed
[   10.995023] gim info:(atom_post_vbios:253) asic_init before, engine
clock = 7530; memory clock =1e848
[   11.320309] gim info:(atom_post_vbios:256) asic_init after
[   11.320312] gim info:(atom_post_vbios:263) atom_init_fan_cntl before
[   11.320313] gim info:(atom_post_vbios:265) atom_init_fan_cntl after
[   11.320314] gim info:(gim_post_vbios:353) Post INIT_ASIC successfully!
[   11.320327] gim info:(firmware_requires_update:512) SMU option ROM
version 0x111700
[   11.320328] gim info:(firmware_requires_update:513) versus patch version
0x111a00
[   11.320339] gim info:(firmware_requires_update:523) RLCV option ROM
version 113 versus patch version 113
[   11.320340] gim info:(firmware_requires_update:528) TOC found, update it
[   11.320341] gim info:(patch_firmware:579) Update smc_init table
[   11.882360] gim info:(patch_firmware:612) Update smu firmware
[   11.892326] gim info:(patch_firmware:630) Update TOC
[   11.896239] gim info:(gim_post_vbios:359) Asic needs firmware loaded
[   11.896241] gim info:(atom_post_vbios:200) ATOM_PostVBIOS: firmware_info
passed
[   11.896242] gim info:(atom_post_vbios:239) just load uCode
[   11.896243] gim info:(atom_post_vbios:253) asic_init before, engine
clock = 7530; memory clock =1e848
[   13.172548] gim info:(atom_post_vbios:256) asic_init after
[   13.172551] gim info:(atom_post_vbios:263) atom_init_fan_cntl before
[   13.172552] gim info:(atom_post_vbios:265) atom_init_fan_cntl after
[   13.172553] gim info:(gim_post_vbios:365) Post LOAD_FW successfully!
[   13.172554] gim info:(gim_post_vbios:366) Post VBIOS successfully!
[   13.172555] gim info:(set_new_adapter:701) gim_post_vbios done
[   13.172557] gim info:(set_new_adapter:739) Scheduler Time interval is
per-vf from XL
[   13.172557] gim info:(set_new_adapter:740) config file
[   13.172559] gim info:(enable_sriov:295) Enable SRIOV
[   13.172560] gim info:(enable_sriov:296) Enable SRIOV vfs count = 16
[   13.277685] gim info:(enumerate_vfs:123) vf found: 04:2.0
[   13.277702] gim info:(enumerate_vfs:123) vf found: 04:2.1
[   13.277727] gim info:(enumerate_vfs:123) vf found: 04:2.2
[   13.277740] gim info:(enumerate_vfs:123) vf found: 04:2.3
[   13.277753] gim info:(enumerate_vfs:123) vf found: 04:2.4
[   13.277766] gim info:(enumerate_vfs:123) vf found: 04:2.5
[   13.277779] gim info:(enumerate_vfs:123) vf found: 04:2.6
[   13.277792] gim info:(enumerate_vfs:123) vf found: 04:2.7
[   13.277805] gim info:(enumerate_vfs:123) vf found: 04:3.0
[   13.277817] gim info:(enumerate_vfs:123) vf found: 04:3.1
[   13.277830] gim info:(enumerate_vfs:123) vf found: 04:3.2
[   13.277843] gim info:(enumerate_vfs:123) vf found: 04:3.3
[   13.277856] gim info:(enumerate_vfs:123) vf found: 04:3.4
[   13.277869] gim info:(enumerate_vfs:123) vf found: 04:3.5
[   13.277882] gim info:(enumerate_vfs:123) vf found: 04:3.6
[   13.277895] gim info:(enumerate_vfs:123) vf found: 04:3.7
[   13.277928] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:2.0
[   13.277930] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.277934] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.277953] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:2.1
[   13.277955] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.277958] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.277979] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:2.2
[   13.277980] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.277984] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278004] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:2.3
[   13.278005] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278008] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278028] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:2.4
[   13.278030] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278033] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278053] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:2.5
[   13.278055] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278058] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278078] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:2.6
[   13.278079] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278083] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278102] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:2.7
[   13.278104] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278107] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278127] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:3.0
[   13.278128] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278131] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278151] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:3.1
[   13.278153] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278156] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278176] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:3.2
[   13.278178] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278181] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278206] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:3.3
[   13.278208] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278211] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278231] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:3.4
[   13.278233] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278236] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278256] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:3.5
[   13.278257] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278261] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278280] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:3.6
[   13.278282] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278285] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278305] gim info:(pci_disable_error_reporting:764) Disable error
reporting for device: 04:3.7
[   13.278307] gim info:(pci_disable_error_reporting:769) Mask before ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278311] gim info:(pci_disable_error_reporting:780) Mask after ->
corr = 0x00000000, uncorr = 0x00000000
[   13.278320] gim info:(pci_gpu_iov_init:87) total_fb_available = 8190
[   13.278321] gim info:(pci_gpu_iov_init:88) AMD GIM pci_gpu_iov_init pos
= 400
[   13.278322] gim info:(pci_gpu_iov_init:90) AMD GIM pci_gpu_iov_init
total_fb_available = 1ffe
[   13.278323] gim info:(init_frame_buffer_partition:190) PCI defined PF FB
size = 256 MB
[   13.278324] gim info:(init_frame_buffer_partition:194) PCI defined VF FB
size = 256 MB
[   13.278325] gim info:(init_frame_buffer_partition:200) Total FB
Available = 8190 MB, CSA = 8 MB, Max remaining FBsize =8160 MB
[   13.278327] gim info:(init_frame_buffer_partition:201) max_fb_size = 8160
[   13.278328] gim info:(init_frame_buffer_partition:214) PF FB size after
checking limits from config file = 256MB
[   13.278329] gim info:(init_frame_buffer_partition:217) PF rounded down
to nearest 16MB boundary = 256
[   13.278330] gim info:(init_pf_fb:60) total framebuffer available = 1ffe
[   13.278331] gim info:(init_pf_fb:61) pf framebuffer = 100
[   13.278332] gim info:(init_pf_fb:63) total framebuffer consumed = 1efe
[   13.278333] gim info:(init_frame_buffer_partition:224) CSA starts at
offset 256MB
[   13.278334] gim info:(init_context_save_area:42) AMD GIM
init_context_save_area: base =100 size=1.
[   13.278336] gim info:(init_frame_buffer_partition:231) VF FB base =
272MB (256 + 16)
[   13.278337] gim info:(init_frame_buffer_partition:235) VF FB Size =
7904MB (8160 - 256)
[   13.278339] gim info:(init_fb_static:118) AMD GIM init_fb_static: num_vf
= 16, base= 272, total_size=7904, mini_size=256
[   13.278340] gim info:(init_fb_static:139) AMD GIM init_fb_static:
vf_fb_size = 480, base= 272
[   13.278341] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 0 base =272,size= 480
[   13.278343] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 1 base =752,size= 480
[   13.278344] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 2 base =1232,size= 480
[   13.278345] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 3 base =1712,size= 480
[   13.278347] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 4 base =2192,size= 480
[   13.278348] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 5 base =2672,size= 480
[   13.278349] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 6 base =3152,size= 480
[   13.278350] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 7 base =3632,size= 480
[   13.278352] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 8 base =4112,size= 480
[   13.278353] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 9 base =4592,size= 480
[   13.278354] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 10 base =5072,size= 480
[   13.278356] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 11 base =5552,size= 480
[   13.278357] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 12 base =6032,size= 480
[   13.278358] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 13 base =6512,size= 480
[   13.278360] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 14 base =6992,size= 480
[   13.278361] gim info:(init_fb_static:150) AMD GIM init_fb_static:
partition 15 base =7472,size= 480
[   13.278365] gim info:(set_new_adapter:789) enable MSI
[   13.278367] gim error:(set_new_adapter:791) fail to enable MSI
[   13.278368] gim info:(gim_probe:86) AMD GIM probe: pf_count = 1

--000000000000eab9990575169fb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I&#39;m working on AMD=C2=A0FirePro S7150=
 GPU passthrough by SRIOV on CentOS 7.3 (kernel =3D 3.10.0-514).</div><div>=
According to the two patches from=C2=A0<a href=3D"https://github.com/GPUOpe=
n-LibrariesAndSDKs/MxGPU-Virtualization" target=3D"_blank">https://github.c=
om/GPUOpen-LibrariesAndSDKs/MxGPU-Virtualization</a>, I have patched the ke=
rnel and rebooted.</div><div>Iommu and sriov are both enabled, 8 VFs can be=
 found.</div><div>But there&#39;s error from dmesg:=C2=A0=C2=A0<font color=
=3D"#0000ff">gim error:(set_new_adapter:791) fail to enable MSI</font></div=
><div dir=3D"ltr"><div>And in win7 guests os, the AMD driver always show er=
ror code 43.</div><div>Are the two errors related? Or MSI error can be igno=
red?</div><div><br></div><div><div>[=C2=A0 =C2=A010.859725] gim: loading ou=
t-of-tree module taints kernel.</div><div>[=C2=A0 =C2=A010.860008] gim: mod=
ule verification failed: signature and/or required key missing - tainting k=
ernel</div><div>[=C2=A0 =C2=A010.861041] gim info:(gim_init:144) Start AMD =
open source GIM initialization</div><div>[=C2=A0 =C2=A010.861045] gim info:=
(gim_init:147) GPU IOV MODULE - version 1.0.0-k</div><div>[=C2=A0 =C2=A010.=
861047] gim info:(gim_init:149) Copyright (c) 2014-2017 AMD Corporation.</d=
iv><div>[=C2=A0 =C2=A010.861069] gim info:(init_config:305) INIT CONFIG</di=
v><div>[=C2=A0 =C2=A010.861091] gim info:(set_new_adapter:614) curr allocat=
ed at ffffffffa0326a40</div><div>[=C2=A0 =C2=A010.861092] gim info:(set_new=
_adapter:621) SRIOV is supported</div><div>[=C2=A0 =C2=A010.861098] gim inf=
o:(set_new_adapter:629) found PCI bridge device</div><div>[=C2=A0 =C2=A010.=
861100] gim info:(set_new_adapter:633) found: 00:2.0</div><div>[=C2=A0 =C2=
=A010.861122] gim info:(set_new_adapter:650) mmio_base =3D ffffc90007180000=
</div><div>[=C2=A0 =C2=A010.861130] gim info:(set_new_adapter:652) doorbell=
 =3D ffffc90007c00000</div><div>[=C2=A0 =C2=A010.861147] gim info:(set_new_=
adapter:654) pf.fb_va =3D ffffc90040000000</div><div>[=C2=A0 =C2=A010.86115=
9] gim info:(sriov_is_ari_enabled:164) PCI_SRIOV_CAP =3D 0x00000002</div><d=
iv>[=C2=A0 =C2=A010.861162] gim info:(sriov_is_ari_enabled:173) PCI_SRIOV_C=
TRL =3D 0x00000010</div><div>[=C2=A0 =C2=A010.861163] gim info:(sriov_is_ar=
i_enabled:176) PCI_SRIOV_CTRL_ARI is set --&gt; ARI is supported</div><div>=
[=C2=A0 =C2=A010.861167] gim info:(program_ari_mode:483) Read bif_strap8 =
=3D 0x00200004</div><div>[=C2=A0 =C2=A010.861169] gim info:(program_ari_mod=
e:488) program_ari_mode - Set ARI_Mode =3D PF_BUS</div><div>[=C2=A0 =C2=A01=
0.861171] gim info:(program_ari_mode:498) Write bif_strap8 =3D 0x00000004</=
div><div>[=C2=A0 =C2=A010.861173] gim info:(gim_read_rom_from_reg:222) Read=
ing VBios from ROM</div><div>[=C2=A0 =C2=A010.861290] gim info:(gim_read_vb=
ios:284) VBIOS starts:=C2=A0 0x55, 0xaa</div><div>[=C2=A0 =C2=A010.861292] =
gim info:(gim_read_vbios:287) VBios size is 0x10000</div><div>[=C2=A0 =C2=
=A010.861299] gim info:(gim_read_vbios:290) vbios allocated at ffffc90006d7=
d000</div><div>[=C2=A0 =C2=A010.861301] gim info:(gim_read_rom_from_reg:222=
) Reading VBios from ROM</div><div>[=C2=A0 =C2=A010.994958] gim info:(gim_r=
ead_vbios:298) BIOS Version Major 0xF Minor 0x31</div><div>[=C2=A0 =C2=A010=
.994999] gim info:(gim_read_vbios:311) Valid video BIOS image,</div><div>[=
=C2=A0 =C2=A010.995000] gim info:(gim_read_vbios:313) size =3D 0x10000, che=
ck sum is 0x53b100</div><div>[=C2=A0 =C2=A010.995011] gim info:(gim_post_vb=
ios:344) Init Parser passed!, continue</div><div>[=C2=A0 =C2=A010.995015] g=
im info:(atom_chk_asic_status:335) ATOM_CheckAsicStatus - BIOS_SCRATCH_7 =
=3D 0x00000000</div><div>[=C2=A0 =C2=A010.995016] gim info:(atom_chk_asic_s=
tatus:338) Isolate ATOM_S7_ASIC_INIT_COMPLETE_MASK bit(s) =3D 0x00000000</d=
iv><div>[=C2=A0 =C2=A010.995018] gim info:(atom_chk_asic_status:341) RLC_CN=
TL =3D 0x00000000</div><div>[=C2=A0 =C2=A010.995019] gim info:(atom_chk_asi=
c_status:343) Isolate RLC_CNTL__RLC_ENABLE_F32_MASK =3D 0x00000000</div><di=
v>[=C2=A0 =C2=A010.995020] gim info:(atom_chk_asic_status:350) ATOM_ASIC_NE=
ED_POST</div><div>[=C2=A0 =C2=A010.995021] gim info:(gim_post_vbios:347) As=
ic needs a VBios post</div><div>[=C2=A0 =C2=A010.995022] gim info:(atom_pos=
t_vbios:200) ATOM_PostVBIOS: firmware_info passed</div><div>[=C2=A0 =C2=A01=
0.995023] gim info:(atom_post_vbios:253) asic_init before, engine clock =3D=
 7530; memory clock =3D1e848</div><div>[=C2=A0 =C2=A011.320309] gim info:(a=
tom_post_vbios:256) asic_init after</div><div>[=C2=A0 =C2=A011.320312] gim =
info:(atom_post_vbios:263) atom_init_fan_cntl before</div><div>[=C2=A0 =C2=
=A011.320313] gim info:(atom_post_vbios:265) atom_init_fan_cntl after</div>=
<div>[=C2=A0 =C2=A011.320314] gim info:(gim_post_vbios:353) Post INIT_ASIC =
successfully!</div><div>[=C2=A0 =C2=A011.320327] gim info:(firmware_require=
s_update:512) SMU option ROM version 0x111700</div><div>[=C2=A0 =C2=A011.32=
0328] gim info:(firmware_requires_update:513) versus patch version 0x111a00=
</div><div>[=C2=A0 =C2=A011.320339] gim info:(firmware_requires_update:523)=
 RLCV option ROM version 113 versus patch version 113</div><div>[=C2=A0 =C2=
=A011.320340] gim info:(firmware_requires_update:528) TOC found, update it<=
/div><div>[=C2=A0 =C2=A011.320341] gim info:(patch_firmware:579) Update smc=
_init table</div><div>[=C2=A0 =C2=A011.882360] gim info:(patch_firmware:612=
) Update smu firmware</div><div>[=C2=A0 =C2=A011.892326] gim info:(patch_fi=
rmware:630) Update TOC</div><div>[=C2=A0 =C2=A011.896239] gim info:(gim_pos=
t_vbios:359) Asic needs firmware loaded</div><div>[=C2=A0 =C2=A011.896241] =
gim info:(atom_post_vbios:200) ATOM_PostVBIOS: firmware_info passed</div><d=
iv>[=C2=A0 =C2=A011.896242] gim info:(atom_post_vbios:239) just load uCode<=
/div><div>[=C2=A0 =C2=A011.896243] gim info:(atom_post_vbios:253) asic_init=
 before, engine clock =3D 7530; memory clock =3D1e848</div><div>[=C2=A0 =C2=
=A013.172548] gim info:(atom_post_vbios:256) asic_init after</div><div>[=C2=
=A0 =C2=A013.172551] gim info:(atom_post_vbios:263) atom_init_fan_cntl befo=
re</div><div>[=C2=A0 =C2=A013.172552] gim info:(atom_post_vbios:265) atom_i=
nit_fan_cntl after</div><div>[=C2=A0 =C2=A013.172553] gim info:(gim_post_vb=
ios:365) Post LOAD_FW successfully!</div><div>[=C2=A0 =C2=A013.172554] gim =
info:(gim_post_vbios:366) Post VBIOS successfully!</div><div>[=C2=A0 =C2=A0=
13.172555] gim info:(set_new_adapter:701) gim_post_vbios done</div><div>[=
=C2=A0 =C2=A013.172557] gim info:(set_new_adapter:739) Scheduler Time inter=
val is per-vf from XL</div><div>[=C2=A0 =C2=A013.172557] gim info:(set_new_=
adapter:740) config file</div><div>[=C2=A0 =C2=A013.172559] gim info:(enabl=
e_sriov:295) Enable SRIOV</div><div>[=C2=A0 =C2=A013.172560] gim info:(enab=
le_sriov:296) Enable SRIOV vfs count =3D 16</div><div>[=C2=A0 =C2=A013.2776=
85] gim info:(enumerate_vfs:123) vf found: 04:2.0</div><div>[=C2=A0 =C2=A01=
3.277702] gim info:(enumerate_vfs:123) vf found: 04:2.1</div><div>[=C2=A0 =
=C2=A013.277727] gim info:(enumerate_vfs:123) vf found: 04:2.2</div><div>[=
=C2=A0 =C2=A013.277740] gim info:(enumerate_vfs:123) vf found: 04:2.3</div>=
<div>[=C2=A0 =C2=A013.277753] gim info:(enumerate_vfs:123) vf found: 04:2.4=
</div><div>[=C2=A0 =C2=A013.277766] gim info:(enumerate_vfs:123) vf found: =
04:2.5</div><div>[=C2=A0 =C2=A013.277779] gim info:(enumerate_vfs:123) vf f=
ound: 04:2.6</div><div>[=C2=A0 =C2=A013.277792] gim info:(enumerate_vfs:123=
) vf found: 04:2.7</div><div>[=C2=A0 =C2=A013.277805] gim info:(enumerate_v=
fs:123) vf found: 04:3.0</div><div>[=C2=A0 =C2=A013.277817] gim info:(enume=
rate_vfs:123) vf found: 04:3.1</div><div>[=C2=A0 =C2=A013.277830] gim info:=
(enumerate_vfs:123) vf found: 04:3.2</div><div>[=C2=A0 =C2=A013.277843] gim=
 info:(enumerate_vfs:123) vf found: 04:3.3</div><div>[=C2=A0 =C2=A013.27785=
6] gim info:(enumerate_vfs:123) vf found: 04:3.4</div><div>[=C2=A0 =C2=A013=
.277869] gim info:(enumerate_vfs:123) vf found: 04:3.5</div><div>[=C2=A0 =
=C2=A013.277882] gim info:(enumerate_vfs:123) vf found: 04:3.6</div><div>[=
=C2=A0 =C2=A013.277895] gim info:(enumerate_vfs:123) vf found: 04:3.7</div>=
<div>[=C2=A0 =C2=A013.277928] gim info:(pci_disable_error_reporting:764) Di=
sable error reporting for device: 04:2.0</div><div>[=C2=A0 =C2=A013.277930]=
 gim info:(pci_disable_error_reporting:769) Mask before -&gt; corr =3D 0x00=
000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.277934] gim info:(=
pci_disable_error_reporting:780) Mask after -&gt; corr =3D 0x00000000, unco=
rr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.277953] gim info:(pci_disable_=
error_reporting:764) Disable error reporting for device: 04:2.1</div><div>[=
=C2=A0 =C2=A013.277955] gim info:(pci_disable_error_reporting:769) Mask bef=
ore -&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=
=A013.277958] gim info:(pci_disable_error_reporting:780) Mask after -&gt; c=
orr =3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.277979=
] gim info:(pci_disable_error_reporting:764) Disable error reporting for de=
vice: 04:2.2</div><div>[=C2=A0 =C2=A013.277980] gim info:(pci_disable_error=
_reporting:769) Mask before -&gt; corr =3D 0x00000000, uncorr =3D 0x0000000=
0</div><div>[=C2=A0 =C2=A013.277984] gim info:(pci_disable_error_reporting:=
780) Mask after -&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</div><div>=
[=C2=A0 =C2=A013.278004] gim info:(pci_disable_error_reporting:764) Disable=
 error reporting for device: 04:2.3</div><div>[=C2=A0 =C2=A013.278005] gim =
info:(pci_disable_error_reporting:769) Mask before -&gt; corr =3D 0x0000000=
0, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.278008] gim info:(pci_d=
isable_error_reporting:780) Mask after -&gt; corr =3D 0x00000000, uncorr =
=3D 0x00000000</div><div>[=C2=A0 =C2=A013.278028] gim info:(pci_disable_err=
or_reporting:764) Disable error reporting for device: 04:2.4</div><div>[=C2=
=A0 =C2=A013.278030] gim info:(pci_disable_error_reporting:769) Mask before=
 -&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A01=
3.278033] gim info:(pci_disable_error_reporting:780) Mask after -&gt; corr =
=3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.278053] gi=
m info:(pci_disable_error_reporting:764) Disable error reporting for device=
: 04:2.5</div><div>[=C2=A0 =C2=A013.278055] gim info:(pci_disable_error_rep=
orting:769) Mask before -&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</d=
iv><div>[=C2=A0 =C2=A013.278058] gim info:(pci_disable_error_reporting:780)=
 Mask after -&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=
=A0 =C2=A013.278078] gim info:(pci_disable_error_reporting:764) Disable err=
or reporting for device: 04:2.6</div><div>[=C2=A0 =C2=A013.278079] gim info=
:(pci_disable_error_reporting:769) Mask before -&gt; corr =3D 0x00000000, u=
ncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.278083] gim info:(pci_disab=
le_error_reporting:780) Mask after -&gt; corr =3D 0x00000000, uncorr =3D 0x=
00000000</div><div>[=C2=A0 =C2=A013.278102] gim info:(pci_disable_error_rep=
orting:764) Disable error reporting for device: 04:2.7</div><div>[=C2=A0 =
=C2=A013.278104] gim info:(pci_disable_error_reporting:769) Mask before -&g=
t; corr =3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.27=
8107] gim info:(pci_disable_error_reporting:780) Mask after -&gt; corr =3D =
0x00000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.278127] gim in=
fo:(pci_disable_error_reporting:764) Disable error reporting for device: 04=
:3.0</div><div>[=C2=A0 =C2=A013.278128] gim info:(pci_disable_error_reporti=
ng:769) Mask before -&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</div><=
div>[=C2=A0 =C2=A013.278131] gim info:(pci_disable_error_reporting:780) Mas=
k after -&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =
=C2=A013.278151] gim info:(pci_disable_error_reporting:764) Disable error r=
eporting for device: 04:3.1</div><div>[=C2=A0 =C2=A013.278153] gim info:(pc=
i_disable_error_reporting:769) Mask before -&gt; corr =3D 0x00000000, uncor=
r =3D 0x00000000</div><div>[=C2=A0 =C2=A013.278156] gim info:(pci_disable_e=
rror_reporting:780) Mask after -&gt; corr =3D 0x00000000, uncorr =3D 0x0000=
0000</div><div>[=C2=A0 =C2=A013.278176] gim info:(pci_disable_error_reporti=
ng:764) Disable error reporting for device: 04:3.2</div><div>[=C2=A0 =C2=A0=
13.278178] gim info:(pci_disable_error_reporting:769) Mask before -&gt; cor=
r =3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.278181] =
gim info:(pci_disable_error_reporting:780) Mask after -&gt; corr =3D 0x0000=
0000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.278206] gim info:(pc=
i_disable_error_reporting:764) Disable error reporting for device: 04:3.3</=
div><div>[=C2=A0 =C2=A013.278208] gim info:(pci_disable_error_reporting:769=
) Mask before -&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</div><div>[=
=C2=A0 =C2=A013.278211] gim info:(pci_disable_error_reporting:780) Mask aft=
er -&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=
=A013.278231] gim info:(pci_disable_error_reporting:764) Disable error repo=
rting for device: 04:3.4</div><div>[=C2=A0 =C2=A013.278233] gim info:(pci_d=
isable_error_reporting:769) Mask before -&gt; corr =3D 0x00000000, uncorr =
=3D 0x00000000</div><div>[=C2=A0 =C2=A013.278236] gim info:(pci_disable_err=
or_reporting:780) Mask after -&gt; corr =3D 0x00000000, uncorr =3D 0x000000=
00</div><div>[=C2=A0 =C2=A013.278256] gim info:(pci_disable_error_reporting=
:764) Disable error reporting for device: 04:3.5</div><div>[=C2=A0 =C2=A013=
.278257] gim info:(pci_disable_error_reporting:769) Mask before -&gt; corr =
=3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.278261] gi=
m info:(pci_disable_error_reporting:780) Mask after -&gt; corr =3D 0x000000=
00, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013.278280] gim info:(pci_=
disable_error_reporting:764) Disable error reporting for device: 04:3.6</di=
v><div>[=C2=A0 =C2=A013.278282] gim info:(pci_disable_error_reporting:769) =
Mask before -&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=
=A0 =C2=A013.278285] gim info:(pci_disable_error_reporting:780) Mask after =
-&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</div><div>[=C2=A0 =C2=A013=
.278305] gim info:(pci_disable_error_reporting:764) Disable error reporting=
 for device: 04:3.7</div><div>[=C2=A0 =C2=A013.278307] gim info:(pci_disabl=
e_error_reporting:769) Mask before -&gt; corr =3D 0x00000000, uncorr =3D 0x=
00000000</div><div>[=C2=A0 =C2=A013.278311] gim info:(pci_disable_error_rep=
orting:780) Mask after -&gt; corr =3D 0x00000000, uncorr =3D 0x00000000</di=
v><div>[=C2=A0 =C2=A013.278320] gim info:(pci_gpu_iov_init:87) total_fb_ava=
ilable =3D 8190</div><div>[=C2=A0 =C2=A013.278321] gim info:(pci_gpu_iov_in=
it:88) AMD GIM pci_gpu_iov_init pos =3D 400</div><div>[=C2=A0 =C2=A013.2783=
22] gim info:(pci_gpu_iov_init:90) AMD GIM pci_gpu_iov_init total_fb_availa=
ble =3D 1ffe</div><div>[=C2=A0 =C2=A013.278323] gim info:(init_frame_buffer=
_partition:190) PCI defined PF FB size =3D 256 MB</div><div>[=C2=A0 =C2=A01=
3.278324] gim info:(init_frame_buffer_partition:194) PCI defined VF FB size=
 =3D 256 MB</div><div>[=C2=A0 =C2=A013.278325] gim info:(init_frame_buffer_=
partition:200) Total FB Available =3D 8190 MB, CSA =3D 8 MB, Max remaining =
FBsize =3D8160 MB</div><div>[=C2=A0 =C2=A013.278327] gim info:(init_frame_b=
uffer_partition:201) max_fb_size =3D 8160</div><div>[=C2=A0 =C2=A013.278328=
] gim info:(init_frame_buffer_partition:214) PF FB size after checking limi=
ts from config file =3D 256MB</div><div>[=C2=A0 =C2=A013.278329] gim info:(=
init_frame_buffer_partition:217) PF rounded down to nearest 16MB boundary =
=3D 256</div><div>[=C2=A0 =C2=A013.278330] gim info:(init_pf_fb:60) total f=
ramebuffer available =3D 1ffe</div><div>[=C2=A0 =C2=A013.278331] gim info:(=
init_pf_fb:61) pf framebuffer =3D 100</div><div>[=C2=A0 =C2=A013.278332] gi=
m info:(init_pf_fb:63) total framebuffer consumed =3D 1efe</div><div>[=C2=
=A0 =C2=A013.278333] gim info:(init_frame_buffer_partition:224) CSA starts =
at offset 256MB</div><div>[=C2=A0 =C2=A013.278334] gim info:(init_context_s=
ave_area:42) AMD GIM init_context_save_area: base =3D100 size=3D1.</div><di=
v>[=C2=A0 =C2=A013.278336] gim info:(init_frame_buffer_partition:231) VF FB=
 base =3D 272MB (256 + 16)</div><div>[=C2=A0 =C2=A013.278337] gim info:(ini=
t_frame_buffer_partition:235) VF FB Size =3D 7904MB (8160 - 256)</div><div>=
[=C2=A0 =C2=A013.278339] gim info:(init_fb_static:118) AMD GIM init_fb_stat=
ic: num_vf =3D 16, base=3D 272, total_size=3D7904, mini_size=3D256</div><di=
v>[=C2=A0 =C2=A013.278340] gim info:(init_fb_static:139) AMD GIM init_fb_st=
atic: vf_fb_size =3D 480, base=3D 272</div><div>[=C2=A0 =C2=A013.278341] gi=
m info:(init_fb_static:150) AMD GIM init_fb_static: partition 0 base =3D272=
,size=3D 480</div><div>[=C2=A0 =C2=A013.278343] gim info:(init_fb_static:15=
0) AMD GIM init_fb_static: partition 1 base =3D752,size=3D 480</div><div>[=
=C2=A0 =C2=A013.278344] gim info:(init_fb_static:150) AMD GIM init_fb_stati=
c: partition 2 base =3D1232,size=3D 480</div><div>[=C2=A0 =C2=A013.278345] =
gim info:(init_fb_static:150) AMD GIM init_fb_static: partition 3 base =3D1=
712,size=3D 480</div><div>[=C2=A0 =C2=A013.278347] gim info:(init_fb_static=
:150) AMD GIM init_fb_static: partition 4 base =3D2192,size=3D 480</div><di=
v>[=C2=A0 =C2=A013.278348] gim info:(init_fb_static:150) AMD GIM init_fb_st=
atic: partition 5 base =3D2672,size=3D 480</div><div>[=C2=A0 =C2=A013.27834=
9] gim info:(init_fb_static:150) AMD GIM init_fb_static: partition 6 base =
=3D3152,size=3D 480</div><div>[=C2=A0 =C2=A013.278350] gim info:(init_fb_st=
atic:150) AMD GIM init_fb_static: partition 7 base =3D3632,size=3D 480</div=
><div>[=C2=A0 =C2=A013.278352] gim info:(init_fb_static:150) AMD GIM init_f=
b_static: partition 8 base =3D4112,size=3D 480</div><div>[=C2=A0 =C2=A013.2=
78353] gim info:(init_fb_static:150) AMD GIM init_fb_static: partition 9 ba=
se =3D4592,size=3D 480</div><div>[=C2=A0 =C2=A013.278354] gim info:(init_fb=
_static:150) AMD GIM init_fb_static: partition 10 base =3D5072,size=3D 480<=
/div><div>[=C2=A0 =C2=A013.278356] gim info:(init_fb_static:150) AMD GIM in=
it_fb_static: partition 11 base =3D5552,size=3D 480</div><div>[=C2=A0 =C2=
=A013.278357] gim info:(init_fb_static:150) AMD GIM init_fb_static: partiti=
on 12 base =3D6032,size=3D 480</div><div>[=C2=A0 =C2=A013.278358] gim info:=
(init_fb_static:150) AMD GIM init_fb_static: partition 13 base =3D6512,size=
=3D 480</div><div>[=C2=A0 =C2=A013.278360] gim info:(init_fb_static:150) AM=
D GIM init_fb_static: partition 14 base =3D6992,size=3D 480</div><div>[=C2=
=A0 =C2=A013.278361] gim info:(init_fb_static:150) AMD GIM init_fb_static: =
partition 15 base =3D7472,size=3D 480</div><div>[=C2=A0 =C2=A013.278365] gi=
m info:(set_new_adapter:789) enable MSI</div><div>[=C2=A0 =C2=A013.278367] =
gim error:(set_new_adapter:791) fail to enable MSI</div><div>[=C2=A0 =C2=A0=
13.278368] gim info:(gim_probe:86) AMD GIM probe: pf_count =3D 1</div></div=
></div></div>

--000000000000eab9990575169fb5--

--===============1765066179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1765066179==--

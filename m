From: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Kernel panic on Xorg init with new HP F.19 BIOS and kernel 4.19
Date: Sun, 9 Dec 2018 16:43:02 -0300
Message-ID: <CAJri6_sqo0+SN60C=_WH1nn=twuuey9iGE=FGBz1WoOr7wHr0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0635288500=="
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

--===============0635288500==
Content-Type: multipart/alternative; boundary="000000000000174eaf057c9c0fe2"

--000000000000174eaf057c9c0fe2
Content-Type: text/plain; charset="UTF-8"

Hi all,

After using windows to update my HP Envy x360 from BIOS to F.17 to F.19 I
can't boot using kernel 4.19 anymore. FYI that update increased shared
memory from 256mb to 1gb.
BIOS downloaded from
https://support.hp.com/us-en/drivers/selfservice/hp-envy-15-bq000-x360-convertible-pc/15551149


Caps lock starts blinking on lightdm init and get a black screen, looks
like a kernel panic.

Kernel 4.18.20 boots normally.

Call trace from journalctl -xe -b -1:
dez 09 16:25:01 braulio-laptop kernel: mousedev: PS/2 mouse device common
for all mice
dez 09 16:25:01 braulio-laptop kernel: amdgpu: [powerplay] dpm has been
enabled
dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: values for Invalid
clock
dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB:         0 in kHz
dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB:         400000 in
kHz
dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB:         933000 in
kHz
dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB:         1067000 in
kHz
dez 09 16:25:01 braulio-laptop kernel: WARNING: CPU: 6 PID: 377 at
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1372
dcn_bw_update_from_pplib+0x16b/0x280 [amdgpu]
dez 09 16:25:01 braulio-laptop kernel: Modules linked in: joydev mousedev
amdkfd amd_iommu_v2 amdgpu(+) btusb arc4 ext4 btrtl btbcm uvcvideo btintel
r8822be(C) videobuf2_vmalloc hp_wmi vid>
dez 09 16:25:01 braulio-laptop kernel:  sysimgblt k10temp soundcore rfkill
fb_sys_fops memstick i2c_piix4 battery ac hp_accel wmi lis3lv02d i2c_scmi
i2c_hid input_polldev pinctrl_amd hp_wi>
dez 09 16:25:01 braulio-laptop kernel: CPU: 6 PID: 377 Comm: systemd-udevd
Tainted: G         C OE     4.19.4-arch1-1-ARCH #1
dez 09 16:25:01 braulio-laptop kernel: Hardware name: HP HP ENVY x360
Convertible 15m-bq1xx/83C6, BIOS F.19 11/05/2018
dez 09 16:25:01 braulio-laptop kernel: RIP:
0010:dcn_bw_update_from_pplib+0x16b/0x280 [amdgpu]
dez 09 16:25:01 braulio-laptop kernel: Code: d8 ca d8 f1 d9 5a 50 8b 44 fc
14 49 8b 94 24 78 01 00 00 48 89 04 24 df 2c 24 d8 f1 db 42 78 de c9 de ca
de f9 d9 5a 4c eb 02 <0f> 0b 48 89 da >
dez 09 16:25:01 braulio-laptop kernel: RSP: 0018:ffffbb5e83c6f7d8 EFLAGS:
00010246
dez 09 16:25:01 braulio-laptop kernel: RAX: 0000000000000001 RBX:
ffffbb5e83c6f838 RCX: 0000000000000000
dez 09 16:25:01 braulio-laptop kernel: RDX: 0000000000000000 RSI:
0000000000000004 RDI: 00000000ffffffff
dez 09 16:25:01 braulio-laptop kernel: RBP: ffffa121c508dd80 R08:
0000000000000001 R09: 00000000000003d7
dez 09 16:25:01 braulio-laptop kernel: R10: 0000000000000004 R11:
0000000000000000 R12: ffffa121bbb31000
dez 09 16:25:01 braulio-laptop kernel: R13: ffffa121bbb80f60 R14:
ffffa121bbb31000 R15: 0000000000000000
dez 09 16:25:01 braulio-laptop kernel: FS:  00007ffff6033cc0(0000)
GS:ffffa121cbb80000(0000) knlGS:0000000000000000
dez 09 16:25:01 braulio-laptop kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
dez 09 16:25:01 braulio-laptop kernel: CR2: 00007fffffffa9e0 CR3:
0000000504058000 CR4: 00000000003406e0
dez 09 16:25:01 braulio-laptop kernel: Call Trace:
dez 09 16:25:01 braulio-laptop kernel:  dcn10_create_resource_pool+0x781/0x9d0
[amdgpu]
dez 09 16:25:01 braulio-laptop kernel:  ?
dal_aux_engine_dce110_create+0x39/0x70 [amdgpu]
dez 09 16:25:01 braulio-laptop kernel:  dc_create_resource_pool+0x42/0x180
[amdgpu]
dez 09 16:25:01 braulio-laptop kernel:  ? __kmalloc+0x18f/0x220
dez 09 16:25:01 braulio-laptop kernel:  dc_create+0x20f/0x620 [amdgpu]
dez 09 16:25:01 braulio-laptop kernel:  ?
amdgpu_cgs_create_device+0x23/0x50 [amdgpu]
dez 09 16:25:01 braulio-laptop kernel:  dm_hw_init+0xc8/0x130 [amdgpu]
dez 09 16:25:01 braulio-laptop kernel:
amdgpu_device_init.cold.14+0x1041/0x1253
[amdgpu]
dez 09 16:25:01 braulio-laptop kernel:  amdgpu_driver_load_kms+0x86/0x2c0
[amdgpu]
dez 09 16:25:01 braulio-laptop kernel:  drm_dev_register+0x109/0x140 [drm]
dez 09 16:25:01 braulio-laptop kernel:  amdgpu_pci_probe+0x13c/0x1c0
[amdgpu]
dez 09 16:25:01 braulio-laptop kernel:  ?
_raw_spin_unlock_irqrestore+0x20/0x40
dez 09 16:25:01 braulio-laptop kernel:  local_pci_probe+0x41/0x90
dez 09 16:25:01 braulio-laptop kernel:  pci_device_probe+0x189/0x1a0
dez 09 16:25:01 braulio-laptop kernel:  really_probe+0x235/0x3a0
dez 09 16:25:01 braulio-laptop kernel:  driver_probe_device+0xb3/0xf0
dez 09 16:25:01 braulio-laptop kernel:  __driver_attach+0xdd/0x110
dez 09 16:25:01 braulio-laptop kernel:  ? driver_probe_device+0xf0/0xf0
dez 09 16:25:01 braulio-laptop kernel:  ? driver_probe_device+0xf0/0xf0
dez 09 16:25:01 braulio-laptop kernel:  bus_for_each_dev+0x76/0xc0
dez 09 16:25:01 braulio-laptop kernel:  bus_add_driver+0x152/0x230
dez 09 16:25:01 braulio-laptop kernel:  ? 0xffffffffc1475000
dez 09 16:25:01 braulio-laptop kernel:  driver_register+0x6b/0xb0
dez 09 16:25:01 braulio-laptop kernel:  ? 0xffffffffc1475000
dez 09 16:25:01 braulio-laptop kernel:  do_one_initcall+0x46/0x1f5
dez 09 16:25:01 braulio-laptop kernel:  ? kmem_cache_alloc_trace+0x176/0x1d0
dez 09 16:25:01 braulio-laptop kernel:  ? do_init_module+0x22/0x210
dez 09 16:25:01 braulio-laptop kernel:  do_init_module+0x5a/0x210
dez 09 16:25:01 braulio-laptop kernel:  load_module+0x1fac/0x20e0
dez 09 16:25:01 braulio-laptop kernel:  ? __se_sys_init_module+0x10a/0x170
dez 09 16:25:01 braulio-laptop kernel:  __se_sys_init_module+0x10a/0x170
dez 09 16:25:01 braulio-laptop kernel:  do_syscall_64+0x5b/0x170
dez 09 16:25:01 braulio-laptop kernel:
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
dez 09 16:25:01 braulio-laptop kernel: RIP: 0033:0x7ffff7e8b56e
dez 09 16:25:01 braulio-laptop kernel: Code: 48 8b 0d f5 18 0c 00 f7 d8 64
89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca
b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff >
dez 09 16:25:01 braulio-laptop kernel: RSP: 002b:00007fffffffd618 EFLAGS:
00000246 ORIG_RAX: 00000000000000af
dez 09 16:25:01 braulio-laptop kernel: RAX: ffffffffffffffda RBX:
00005555555da970 RCX: 00007ffff7e8b56e
dez 09 16:25:01 braulio-laptop kernel: RDX: 00007ffff791fecd RSI:
00000000006115a9 RDI: 0000555555fcf770
dez 09 16:25:01 braulio-laptop kernel: RBP: 00007ffff791fecd R08:
0000000000000006 R09: 0000000000000005
dez 09 16:25:01 braulio-laptop kernel: R10: 00005555555b5010 R11:
0000000000000246 R12: 0000555555fcf770
dez 09 16:25:01 braulio-laptop kernel: R13: 00005555555c6ff0 R14:
0000000000020000 R15: 00005555555da970
dez 09 16:25:01 braulio-laptop kernel: ---[ end trace f644f1cfd9421895 ]---
dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: values for Invalid
clock
dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB:         300000 in
kHz
dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB:         600000 in
kHz
dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB:         626000 in
kHz
dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB:         654000 in
kHz
dez 09 16:25:01 braulio-laptop kernel: [drm:construct [amdgpu]] *ERROR*
construct: Invalid Connector ObjectID from Adapter Service for connector
index:2! type 0 expected 3
dez 09 16:25:01 braulio-laptop kernel: [drm] Display Core initialized with
v3.1.59!
dez 09 16:25:01 braulio-laptop kernel: [drm] SADs count is: -2, don't need
to read it
dez 09 16:25:01 braulio-laptop kernel: [drm] Supports vblank timestamp
caching Rev 2 (21.10.2013).
dez 09 16:25:01 braulio-laptop kernel: [drm] Driver supports precise vblank
timestamp query.

--000000000000174eaf057c9c0fe2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>After using windows to update m=
y HP Envy x360 from BIOS to F.17 to F.19 I can&#39;t boot using kernel 4.19=
 anymore. FYI that update increased shared memory from 256mb to 1gb.</div><=
div>BIOS downloaded from=C2=A0<a href=3D"https://support.hp.com/us-en/drive=
rs/selfservice/hp-envy-15-bq000-x360-convertible-pc/15551149">https://suppo=
rt.hp.com/us-en/drivers/selfservice/hp-envy-15-bq000-x360-convertible-pc/15=
551149</a>=C2=A0</div><div><br></div><div>Caps lock starts blinking on ligh=
tdm init and get a black screen, looks like a kernel panic.</div><div><br><=
/div><div>Kernel 4.18.20 boots normally.</div><div><br></div><div>Call trac=
e from journalctl -xe -b -1:</div><div><span style=3D"font-family:monospace=
">dez 09 16:25:01 braulio-laptop kernel: mousedev: PS/2 mouse device common=
 for all mice
<br>dez 09 16:25:01 braulio-laptop kernel: amdgpu: [powerplay] dpm has been=
 enabled
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: values for Inval=
id clock
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 in kHz
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0400000 in kHz
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0933000 in kHz
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01067000 in kHz
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>WARNING: CPU: 6 PID: 377 at drivers/gpu/drm/amd/amdgpu/../display/dc/calcs=
/dcn_calcs.c:1372 dcn_bw_update_from_pplib+0x16b/0x280 [amdgpu]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>Modules linked in: joydev mousedev amdkfd amd_iommu_v2 amdgpu(+) btusb arc=
4 ext4 btrtl btbcm uvcvideo btintel r8822be(C) videobuf2_vmalloc hp_wmi vid=
</span><span style=3D"color:rgb(255,255,255);background-color:rgb(0,0,0)">&=
gt;</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0sysimgblt k10temp soundcore rfkill fb_sys_fops memstick i2c_piix4 ba=
ttery ac hp_accel wmi lis3lv02d i2c_scmi i2c_hid input_polldev pinctrl_amd =
hp_wi</span><span style=3D"color:rgb(255,255,255);background-color:rgb(0,0,=
0)">&gt;</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>CPU: 6 PID: 377 Comm: systemd-udevd Tainted: G =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0C OE =C2=A0=C2=A0=C2=A0=C2=A04.19.4-arch1-1-ARCH #1</s=
pan>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>Hardware name: HP HP ENVY x360 Convertible 15m-bq1xx/83C6, BIOS F.19 11/05=
/2018</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>RIP: 0010:dcn_bw_update_from_pplib+0x16b/0x280 [amdgpu]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>Code: d8 ca d8 f1 d9 5a 50 8b 44 fc 14 49 8b 94 24 78 01 00 00 48 89 04 24=
 df 2c 24 d8 f1 db 42 78 de c9 de ca de f9 d9 5a 4c eb 02 &lt;0f&gt; 0b 48 =
89 da </span><span style=3D"color:rgb(255,255,255);background-color:rgb(0,0=
,0)">&gt;</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>RSP: 0018:ffffbb5e83c6f7d8 EFLAGS: 00010246</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>RAX: 0000000000000001 RBX: ffffbb5e83c6f838 RCX: 0000000000000000</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00000000ffffffff</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>RBP: ffffa121c508dd80 R08: 0000000000000001 R09: 00000000000003d7</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>R10: 0000000000000004 R11: 0000000000000000 R12: ffffa121bbb31000</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>R13: ffffa121bbb80f60 R14: ffffa121bbb31000 R15: 0000000000000000</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>FS: =C2=A000007ffff6033cc0(0000) GS:ffffa121cbb80000(0000) knlGS:000000000=
0000000</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>CR2: 00007fffffffa9e0 CR3: 0000000504058000 CR4: 00000000003406e0</span><b=
r></span></div><span style=3D"font-family:monospace">dez 09 16:25:01 brauli=
o-laptop kernel: <span style=3D"font-weight:bold">Call Trace:</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0dcn10_create_resource_pool+0x781/0x9d0 [amdgpu]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0? dal_aux_engine_dce110_create+0x39/0x70 [amdgpu]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0dc_create_resource_pool+0x42/0x180 [amdgpu]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0? __kmalloc+0x18f/0x220</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0dc_create+0x20f/0x620 [amdgpu]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0? amdgpu_cgs_create_device+0x23/0x50 [amdgpu]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0dm_hw_init+0xc8/0x130 [amdgpu]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0amdgpu_device_init.cold.14+0x1041/0x1253 [amdgpu]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0amdgpu_driver_load_kms+0x86/0x2c0 [amdgpu]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0drm_dev_register+0x109/0x140 [drm]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0amdgpu_pci_probe+0x13c/0x1c0 [amdgpu]</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0? _raw_spin_unlock_irqrestore+0x20/0x40</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0local_pci_probe+0x41/0x90</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0pci_device_probe+0x189/0x1a0</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0really_probe+0x235/0x3a0</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0driver_probe_device+0xb3/0xf0</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0__driver_attach+0xdd/0x110</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0? driver_probe_device+0xf0/0xf0</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0? driver_probe_device+0xf0/0xf0</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0bus_for_each_dev+0x76/0xc0</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0bus_add_driver+0x152/0x230</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0? 0xffffffffc1475000</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0driver_register+0x6b/0xb0</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0? 0xffffffffc1475000</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0do_one_initcall+0x46/0x1f5</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0? kmem_cache_alloc_trace+0x176/0x1d0</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0? do_init_module+0x22/0x210</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0do_init_module+0x5a/0x210</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0load_module+0x1fac/0x20e0</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0? __se_sys_init_module+0x10a/0x170</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0__se_sys_init_module+0x10a/0x170</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0do_syscall_64+0x5b/0x170</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>=C2=A0entry_SYSCALL_64_after_hwframe+0x44/0xa9</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>RIP: 0033:0x7ffff7e8b56e</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>Code: 48 8b 0d f5 18 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00=
 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 &lt;48&gt; 3d 01 =
f0 ff </span><span style=3D"color:rgb(255,255,255);background-color:rgb(0,0=
,0)">&gt;</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>RSP: 002b:00007fffffffd618 EFLAGS: 00000246 ORIG_RAX: 00000000000000af</sp=
an>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>RAX: ffffffffffffffda RBX: 00005555555da970 RCX: 00007ffff7e8b56e</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>RDX: 00007ffff791fecd RSI: 00000000006115a9 RDI: 0000555555fcf770</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>RBP: 00007ffff791fecd R08: 0000000000000006 R09: 0000000000000005</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>R10: 00005555555b5010 R11: 0000000000000246 R12: 0000555555fcf770</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>R13: 00005555555c6ff0 R14: 0000000000020000 R15: 00005555555da970</span>
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold"=
>---[ end trace f644f1cfd9421895 ]---</span>
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: values for Inval=
id clock
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0300000 in kHz
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0600000 in kHz
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0626000 in kHz
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] DM_PPLIB: =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0654000 in kHz
<br>dez 09 16:25:01 braulio-laptop kernel: <span style=3D"font-weight:bold;=
color:rgb(255,84,84)">[drm:construct [amdgpu]] *ERROR* construct: Invalid C=
onnector ObjectID from Adapter Service for connector index:2! type 0 expect=
ed 3</span>
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] Display Core initialized w=
ith v3.1.59!
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] SADs count is: -2, don&#39=
;t need to read it
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] Supports vblank timestamp =
caching Rev 2 (21.10.2013).
<br>dez 09 16:25:01 braulio-laptop kernel: [drm] Driver supports precise vb=
lank timestamp query.
<br></span><div>=C2=A0=C2=A0</div></div>

--000000000000174eaf057c9c0fe2--

--===============0635288500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0635288500==--

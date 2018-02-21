From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Re: AMD E8860 on PowerPC with u-boot (T2080)
Date: Wed, 21 Feb 2018 13:13:55 +0100
Message-ID: <CAGtoiRhjUShyxeHRuhx_g4zoTYLig=5R_9f-bHAUOcfVO7C0FQ@mail.gmail.com>
References: <CAGtoiRjxS7mgQKG_yib9-5tVkD9_yAkp3P8PxYvipy3bFnV9Rg@mail.gmail.com>
 <62565c2f-a57f-9a2b-8277-ca94937bbe0f@daenzer.net>
 <CAGtoiRjqaseQSw7utV5Ncru1ggrq+p2OAg7weULzzSt0DWNoaA@mail.gmail.com>
 <9b9704ee-05ae-8586-bdf8-0e37171d8829@daenzer.net>
 <CAGtoiRgJsoETCpE7R+LwQ-941vgifCWQ+9GdDe_-NiNaJK-78A@mail.gmail.com>
 <8950aedc-29db-ae1b-96c9-20be3c8177eb@gmail.com>
 <CAGtoiRhivO8WtafLy-LC=h9VOsOUrwR7=_Uze9pTBAk=FfiVsA@mail.gmail.com>
 <4b7d2add-456f-5e0e-5aea-15439d2b76e3@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2077117230=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4b7d2add-456f-5e0e-5aea-15439d2b76e3-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============2077117230==
Content-Type: multipart/alternative; boundary="001a114cde247111480565b7dc97"

--001a114cde247111480565b7dc97
Content-Type: text/plain; charset="UTF-8"

I got a 4.15.0 up and running on the board; it needs pci=noaer, but boots
up and sees the E8860 apart from that.

The relevant dmesg output:

[   10.888426] [drm] radeon kernel modesetting enabled.
[   10.892170] radeon 0001:01:00.0: runtime IRQ mapping not provided by arch
[   10.892407] [drm] initializing kernel modesetting (VERDE 0x1002:0x6822
0x1002:0x031E 0x00).
[   11.138410] ATOM BIOS: E268
[   11.139916] [drm] GPU not posted. posting now...
[   11.168970] radeon 0001:01:00.0: VRAM: 2048M 0x0000000000000000 -
0x000000007FFFFFFF (2048M used)
[   11.176546] radeon 0001:01:00.0: GTT: 2048M 0x0000000080000000 -
0x00000000FFFFFFFF
[   11.182909] [drm] Detected VRAM RAM=2048M, BAR=256M
[   11.186488] [drm] RAM width 128bits DDR
[   11.189121] [TTM] Zone  kernel: Available graphics memory: 1978102 kiB
[   11.194350] [TTM] Initializing pool allocator
[   11.197407] [TTM] Initializing DMA pool allocator
[   11.200858] [drm] radeon: 2048M of VRAM memory ready
[   11.204527] [drm] radeon: 2048M of GTT memory ready.
[   11.208211] [drm] Loading verde Microcode
[   11.225907] [drm] Internal thermal controller with fan control
[   11.230575] [drm] probing gen 2 caps for device 1957:830 = 73f443/e
[   11.247750] [drm] radeon: dpm initialized
[   11.268255] [drm] Found VCE firmware/feedback version 50.0.1 / 17!
[   11.273152] [drm] GART: num cpu pages 524288, num gpu pages 524288
[   11.281061] [drm] probing gen 2 caps for device 1957:830 = 73f443/e
[   11.286060] [drm] PCIE gen 3 link speeds already enabled
[   11.342009] [drm] PCIE GART of 2048M enabled (table at
0x00000000001D6000).
[   11.347883] radeon 0001:01:00.0: WB enabled
[   11.350779] radeon 0001:01:00.0: fence driver on ring 0 use gpu addr
0x0000000080000c00 and cpu addr 0x000000007408d6c9
[   11.360274] radeon 0001:01:00.0: fence driver on ring 1 use gpu addr
0x0000000080000c04 and cpu addr 0x0000000013c11aeb
[   11.369770] radeon 0001:01:00.0: fence driver on ring 2 use gpu addr
0x0000000080000c08 and cpu addr 0x00000000d4ddd131
[   11.379267] radeon 0001:01:00.0: fence driver on ring 3 use gpu addr
0x0000000080000c0c and cpu addr 0x00000000263a4d29
[   11.388763] radeon 0001:01:00.0: fence driver on ring 4 use gpu addr
0x0000000080000c10 and cpu addr 0x000000006ceb1503
[   11.399277] radeon 0001:01:00.0: fence driver on ring 5 use gpu addr
0x0000000000075a18 and cpu addr 0x000000008935a463
[   11.419084] radeon 0001:01:00.0: failed VCE resume (-22).
[   11.423181] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.428502] [drm] Driver supports precise vblank timestamp query.
[   11.433301] radeon 0001:01:00.0: radeon: MSI limited to 32-bit
[   11.437896] radeon 0001:01:00.0: radeon: using MSI.
[   11.441499] [drm] radeon: irq initialized.
[   12.127423] [drm:.r600_ring_test [radeon]] *ERROR* radeon: ring 0 test
failed (scratch(0x850C)=0xCAFEDEAD)
[   12.135788] radeon 0001:01:00.0: disabling GPU acceleration
[   12.320848] [drm] Radeon Display Connectors
[   12.323733] [drm] Connector 0:
[   12.325476] [drm]   DP-1
[   12.326711] [drm]   HPD1
[   12.327935] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538
0x653c 0x653c
[   12.334035] [drm]   Encoders:
[   12.335691] [drm]     DFP1: INTERNAL_UNIPHY1
[   12.338662] [drm] Connector 1:
[   12.340405] [drm]   DP-2
[   12.341625] [drm]   HPD4
[   12.342857] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568
0x656c 0x656c
[   12.348957] [drm]   Encoders:
[   12.350622] [drm]     DFP2: INTERNAL_UNIPHY1
[   12.353583] [drm] Connector 2:
[   12.355335] [drm]   DP-3
[   12.356557] [drm]   HPD5
[   12.357788] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548
0x654c 0x654c
[   12.363888] [drm]   Encoders:
[   12.365543] [drm]     DFP3: INTERNAL_UNIPHY2
[   12.368514] [drm] Connector 3:
[   12.370267] [drm]   DP-4
[   12.371487] [drm]   HPD6
[   12.372709] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578
0x657c 0x657c
[   12.378808] [drm]   Encoders:
[   12.380464] [drm]     DFP4: INTERNAL_UNIPHY2
[   12.508848] [drm] Cannot find any crtc or sizes
[   12.512716] [drm] Initialized radeon 2.50.0 20080528 for 0001:01:00.0 on
minor 0
[   13.636810] [drm] Cannot find any crtc or sizes

The failed VCE resume (-22) seems to be caused by

        if (rdev->vce.vcpu_bo == NULL)
                return -EINVAL;

in radeon_vce.c line 226. Any idea where to look from there?

Bas Vermeulen

--001a114cde247111480565b7dc97
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I got a 4.15.0 up and running on the board; it needs pci=
=3Dnoaer, but boots up and sees the E8860 apart from that.<div><br></div><d=
iv>The relevant dmesg output:</div><div><br></div><div><div>[=C2=A0 =C2=A01=
0.888426] [drm] radeon kernel modesetting enabled.</div><div>[=C2=A0 =C2=A0=
10.892170] radeon 0001:01:00.0: runtime IRQ mapping not provided by arch</d=
iv><div>[=C2=A0 =C2=A010.892407] [drm] initializing kernel modesetting (VER=
DE 0x1002:0x6822 0x1002:0x031E 0x00).</div><div>[=C2=A0 =C2=A011.138410] AT=
OM BIOS: E268</div><div>[=C2=A0 =C2=A011.139916] [drm] GPU not posted. post=
ing now...</div><div>[=C2=A0 =C2=A011.168970] radeon 0001:01:00.0: VRAM: 20=
48M 0x0000000000000000 - 0x000000007FFFFFFF (2048M used)</div><div>[=C2=A0 =
=C2=A011.176546] radeon 0001:01:00.0: GTT: 2048M 0x0000000080000000 - 0x000=
00000FFFFFFFF</div><div>[=C2=A0 =C2=A011.182909] [drm] Detected VRAM RAM=3D=
2048M, BAR=3D256M</div><div>[=C2=A0 =C2=A011.186488] [drm] RAM width 128bit=
s DDR</div><div>[=C2=A0 =C2=A011.189121] [TTM] Zone=C2=A0 kernel: Available=
 graphics memory: 1978102 kiB</div><div>[=C2=A0 =C2=A011.194350] [TTM] Init=
ializing pool allocator</div><div>[=C2=A0 =C2=A011.197407] [TTM] Initializi=
ng DMA pool allocator</div><div>[=C2=A0 =C2=A011.200858] [drm] radeon: 2048=
M of VRAM memory ready</div><div>[=C2=A0 =C2=A011.204527] [drm] radeon: 204=
8M of GTT memory ready.</div><div>[=C2=A0 =C2=A011.208211] [drm] Loading ve=
rde Microcode</div><div>[=C2=A0 =C2=A011.225907] [drm] Internal thermal con=
troller with fan control</div><div>[=C2=A0 =C2=A011.230575] [drm] probing g=
en 2 caps for device 1957:830 =3D 73f443/e</div><div>[=C2=A0 =C2=A011.24775=
0] [drm] radeon: dpm initialized</div><div>[=C2=A0 =C2=A011.268255] [drm] F=
ound VCE firmware/feedback version 50.0.1 / 17!</div><div>[=C2=A0 =C2=A011.=
273152] [drm] GART: num cpu pages 524288, num gpu pages 524288</div><div>[=
=C2=A0 =C2=A011.281061] [drm] probing gen 2 caps for device 1957:830 =3D 73=
f443/e</div><div>[=C2=A0 =C2=A011.286060] [drm] PCIE gen 3 link speeds alre=
ady enabled</div><div>[=C2=A0 =C2=A011.342009] [drm] PCIE GART of 2048M ena=
bled (table at 0x00000000001D6000).</div><div>[=C2=A0 =C2=A011.347883] rade=
on 0001:01:00.0: WB enabled</div><div>[=C2=A0 =C2=A011.350779] radeon 0001:=
01:00.0: fence driver on ring 0 use gpu addr 0x0000000080000c00 and cpu add=
r 0x000000007408d6c9</div><div>[=C2=A0 =C2=A011.360274] radeon 0001:01:00.0=
: fence driver on ring 1 use gpu addr 0x0000000080000c04 and cpu addr 0x000=
0000013c11aeb</div><div>[=C2=A0 =C2=A011.369770] radeon 0001:01:00.0: fence=
 driver on ring 2 use gpu addr 0x0000000080000c08 and cpu addr 0x00000000d4=
ddd131</div><div>[=C2=A0 =C2=A011.379267] radeon 0001:01:00.0: fence driver=
 on ring 3 use gpu addr 0x0000000080000c0c and cpu addr 0x00000000263a4d29<=
/div><div>[=C2=A0 =C2=A011.388763] radeon 0001:01:00.0: fence driver on rin=
g 4 use gpu addr 0x0000000080000c10 and cpu addr 0x000000006ceb1503</div><d=
iv>[=C2=A0 =C2=A011.399277] radeon 0001:01:00.0: fence driver on ring 5 use=
 gpu addr 0x0000000000075a18 and cpu addr 0x000000008935a463</div><div>[=C2=
=A0 =C2=A011.419084] radeon 0001:01:00.0: failed VCE resume (-22).</div><di=
v>[=C2=A0 =C2=A011.423181] [drm] Supports vblank timestamp caching Rev 2 (2=
1.10.2013).</div><div>[=C2=A0 =C2=A011.428502] [drm] Driver supports precis=
e vblank timestamp query.</div><div>[=C2=A0 =C2=A011.433301] radeon 0001:01=
:00.0: radeon: MSI limited to 32-bit</div><div>[=C2=A0 =C2=A011.437896] rad=
eon 0001:01:00.0: radeon: using MSI.</div><div>[=C2=A0 =C2=A011.441499] [dr=
m] radeon: irq initialized.</div><div>[=C2=A0 =C2=A012.127423] [drm:.r600_r=
ing_test [radeon]] *ERROR* radeon: ring 0 test failed (scratch(0x850C)=3D0x=
CAFEDEAD)</div><div>[=C2=A0 =C2=A012.135788] radeon 0001:01:00.0: disabling=
 GPU acceleration</div><div>[=C2=A0 =C2=A012.320848] [drm] Radeon Display C=
onnectors</div><div>[=C2=A0 =C2=A012.323733] [drm] Connector 0:</div><div>[=
=C2=A0 =C2=A012.325476] [drm]=C2=A0 =C2=A0DP-1</div><div>[=C2=A0 =C2=A012.3=
26711] [drm]=C2=A0 =C2=A0HPD1</div><div>[=C2=A0 =C2=A012.327935] [drm]=C2=
=A0 =C2=A0DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c</div=
><div>[=C2=A0 =C2=A012.334035] [drm]=C2=A0 =C2=A0Encoders:</div><div>[=C2=
=A0 =C2=A012.335691] [drm]=C2=A0 =C2=A0 =C2=A0DFP1: INTERNAL_UNIPHY1</div><=
div>[=C2=A0 =C2=A012.338662] [drm] Connector 1:</div><div>[=C2=A0 =C2=A012.=
340405] [drm]=C2=A0 =C2=A0DP-2</div><div>[=C2=A0 =C2=A012.341625] [drm]=C2=
=A0 =C2=A0HPD4</div><div>[=C2=A0 =C2=A012.342857] [drm]=C2=A0 =C2=A0DDC: 0x=
6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c 0x656c</div><div>[=C2=A0 =C2=
=A012.348957] [drm]=C2=A0 =C2=A0Encoders:</div><div>[=C2=A0 =C2=A012.350622=
] [drm]=C2=A0 =C2=A0 =C2=A0DFP2: INTERNAL_UNIPHY1</div><div>[=C2=A0 =C2=A01=
2.353583] [drm] Connector 2:</div><div>[=C2=A0 =C2=A012.355335] [drm]=C2=A0=
 =C2=A0DP-3</div><div>[=C2=A0 =C2=A012.356557] [drm]=C2=A0 =C2=A0HPD5</div>=
<div>[=C2=A0 =C2=A012.357788] [drm]=C2=A0 =C2=A0DDC: 0x6540 0x6540 0x6544 0=
x6544 0x6548 0x6548 0x654c 0x654c</div><div>[=C2=A0 =C2=A012.363888] [drm]=
=C2=A0 =C2=A0Encoders:</div><div>[=C2=A0 =C2=A012.365543] [drm]=C2=A0 =C2=
=A0 =C2=A0DFP3: INTERNAL_UNIPHY2</div><div>[=C2=A0 =C2=A012.368514] [drm] C=
onnector 3:</div><div>[=C2=A0 =C2=A012.370267] [drm]=C2=A0 =C2=A0DP-4</div>=
<div>[=C2=A0 =C2=A012.371487] [drm]=C2=A0 =C2=A0HPD6</div><div>[=C2=A0 =C2=
=A012.372709] [drm]=C2=A0 =C2=A0DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6=
578 0x657c 0x657c</div><div>[=C2=A0 =C2=A012.378808] [drm]=C2=A0 =C2=A0Enco=
ders:</div><div>[=C2=A0 =C2=A012.380464] [drm]=C2=A0 =C2=A0 =C2=A0DFP4: INT=
ERNAL_UNIPHY2</div><div>[=C2=A0 =C2=A012.508848] [drm] Cannot find any crtc=
 or sizes</div><div>[=C2=A0 =C2=A012.512716] [drm] Initialized radeon 2.50.=
0 20080528 for 0001:01:00.0 on minor 0</div><div>[=C2=A0 =C2=A013.636810] [=
drm] Cannot find any crtc or sizes</div></div><div><br></div><div>The faile=
d VCE resume (-22) seems to be caused by</div><div><br></div><div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (rdev-&gt;vce.vcpu_bo =3D=3D NULL)</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;</di=
v></div><div><br></div><div>in radeon_vce.c line 226. Any idea where to loo=
k from there?</div><div><br></div><div>Bas Vermeulen</div></div>

--001a114cde247111480565b7dc97--

--===============2077117230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2077117230==--

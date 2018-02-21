From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Re: AMD E8860 on PowerPC with u-boot (T2080)
Date: Wed, 21 Feb 2018 11:38:58 +0100
Message-ID: <CAGtoiRgJsoETCpE7R+LwQ-941vgifCWQ+9GdDe_-NiNaJK-78A@mail.gmail.com>
References: <CAGtoiRjxS7mgQKG_yib9-5tVkD9_yAkp3P8PxYvipy3bFnV9Rg@mail.gmail.com>
 <62565c2f-a57f-9a2b-8277-ca94937bbe0f@daenzer.net>
 <CAGtoiRjqaseQSw7utV5Ncru1ggrq+p2OAg7weULzzSt0DWNoaA@mail.gmail.com>
 <9b9704ee-05ae-8586-bdf8-0e37171d8829@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1395453865=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9b9704ee-05ae-8586-bdf8-0e37171d8829-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1395453865==
Content-Type: multipart/alternative; boundary="089e0827e9fce8066b0565b688e0"

--089e0827e9fce8066b0565b688e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 10:31 AM, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> w=
rote:

> On 2018-02-21 10:18 AM, Bas Vermeulen wrote:
> > On Wed, Feb 21, 2018 at 10:06 AM, Michel D=C3=A4nzer <michel-otUistvHUpNNg+MwTxZMZA@public.gmane.org=
t
> > <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>> wrote:
> >
> >     > My question is, what do I need to do to correctly initialize the
> E8860
> >     > board on my powerpc machine?
> >
> >     Start by sharing the dmesg output, and maybe also the kernel build
> >     configuration file.
> >
> >
> > Both are attached (gzipped because of size).
>
> It might be related to this:
>
> [   10.482772] radeon: No coherent DMA available.
>
>
I updated my device-tree to add incoming pcie ranges, and that removes this
error:

[   10.161044] [drm] radeon kernel modesetting enabled.
[   10.165168] [drm] initializing kernel modesetting (VERDE 0x1002:0x6822
0x1002:0x031E).
[   10.171799] radeon: No coherent DMA available.
[   10.171831] [drm] register mmio base: 0x41000000
[   10.171832] [drm] register mmio size: 262144
[   10.411061] ATOM BIOS: E268
[   10.412569] [drm] GPU not posted. posting now...
[   10.441831] radeon 0002:01:00.0: VRAM: 2048M 0x0000000000000000 -
0x000000007FFFFFFF (2048M used)
[   10.449408] radeon 0002:01:00.0: GTT: 1024M 0x0000000080000000 -
0x00000000BFFFFFFF
[   10.455771] [drm] Detected VRAM RAM=3D2048M, BAR=3D256M
[   10.459349] [drm] RAM width 128bits DDR
[   10.462455] [TTM] Zone  kernel: Available graphics memory: 1978634 kiB
[   10.467688] [TTM] Initializing pool allocator
[   10.470755] [TTM] Initializing DMA pool allocator
[   10.474194] [drm] radeon: 2048M of VRAM memory ready
[   10.477859] [drm] radeon: 1024M of GTT memory ready.
[   10.481549] [drm] Loading verde Microcode
[   10.500383] [drm] Internal thermal controller with fan control
[   10.505048] [drm] probing gen 2 caps for device 1957:830 =3D 73f443/e
[   10.522317] [drm] radeon: dpm initialized
[   10.539675] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   10.546129] [drm] probing gen 2 caps for device 1957:830 =3D 73f443/e
[   10.551121] [drm] PCIE gen 3 link speeds already enabled
[   10.581276] [drm] PCIE GART of 1024M enabled (table at
0x0000000000277000).
[   10.587142] radeon 0002:01:00.0: WB enabled
[   10.590019] radeon 0002:01:00.0: fence driver on ring 0 use gpu addr
0x0000000080000c00 and cpu addr 0xc0000000ed15bc00
[   10.599515] radeon 0002:01:00.0: fence driver on ring 1 use gpu addr
0x0000000080000c04 and cpu addr 0xc0000000ed15bc04
[   10.609008] radeon 0002:01:00.0: fence driver on ring 2 use gpu addr
0x0000000080000c08 and cpu addr 0xc0000000ed15bc08
[   10.618499] radeon 0002:01:00.0: fence driver on ring 3 use gpu addr
0x0000000080000c0c and cpu addr 0xc0000000ed15bc0c
[   10.627992] radeon 0002:01:00.0: fence driver on ring 4 use gpu addr
0x0000000080000c10 and cpu addr 0xc0000000ed15bc10
[   10.639273] radeon 0002:01:00.0: fence driver on ring 5 use gpu addr
0x0000000000075a18 and cpu addr 0x8000080088db5a18
[   10.648762] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.654078] [drm] Driver supports precise vblank timestamp query.
[   10.658873] radeon 0002:01:00.0: radeon: MSI limited to 32-bit
[   10.663455] radeon 0002:01:00.0: radeon: using MSI.
[   10.667069] [drm] radeon: irq initialized.
[   11.353989] [drm:.r600_ring_test [radeon]] *ERROR* radeon: ring 0 test
failed (scratch(0x850C)=3D0xCAFEDEAD)
[   11.362354] radeon 0002:01:00.0: disabling GPU acceleration
[   11.543395] [drm] Radeon Display Connectors
[   11.546272] [drm] Connector 0:
[   11.548027] [drm]   DP-1
[   11.549248] [drm]   HPD1
[   11.550471] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538
0x653c 0x653c
[   11.556569] [drm]   Encoders:
[   11.558224] [drm]     DFP1: INTERNAL_UNIPHY1
[   11.561192] [drm] Connector 1:
[   11.562941] [drm]   DP-2
[   11.564162] [drm]   HPD4
[   11.565384] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568
0x656c 0x656c
[   11.571480] [drm]   Encoders:
[   11.573136] [drm]     DFP2: INTERNAL_UNIPHY1
[   11.576103] [drm] Connector 2:
[   11.577846] [drm]   DP-3
[   11.579074] [drm]   HPD5
[   11.580297] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548
0x654c 0x654c
[   11.586393] [drm]   Encoders:
[   11.588057] [drm]     DFP3: INTERNAL_UNIPHY2
[   11.591023] [drm] Connector 3:
[   11.592767] [drm]   DP-4
[   11.593987] [drm]   HPD6
[   11.595216] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578
0x657c 0x657c
[   11.601313] [drm]   Encoders:
[   11.602978] [drm]     DFP4: INTERNAL_UNIPHY2
[   11.692728] radeon 0002:01:00.0: No connectors reported connected with
modes
[   11.698480] [drm] Cannot find any crtc or sizes - going 1024x768
[   11.708402] [drm] fb mappable at 0xC60478000
[   11.711369] [drm] vram apper at 0xC60000000
[   11.714242] [drm] size 3145728
[   11.715993] [drm] fb depth is 24
[   11.717910] [drm]    pitch is 4096
[   11.720091] radeon 0002:01:00.0: fb0: radeondrmfb frame buffer device
[   11.725236] radeon 0002:01:00.0: registered panic notifier
[   11.742619] [drm] Initialized radeon 2.42.0 20080528 for 0002:01:00.0 on
minor 0
[   40.806632] random: nonblocking pool is initialized

Bas Vermeulen

--089e0827e9fce8066b0565b688e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Feb 21, 2018 at 10:31 AM, Michel D=C3=A4nzer <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><spa=
n class=3D"gmail-">On 2018-02-21 10:18 AM, Bas Vermeulen wrote:<br>
&gt; On Wed, Feb 21, 2018 at 10:06 AM, Michel D=C3=A4nzer &lt;<a href=3D"ma=
ilto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a><br>
</span><span class=3D"gmail-">&gt; &lt;mailto:<a href=3D"mailto:michel@daen=
zer.net">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; My question is, what do I need to do to correc=
tly initialize the E8860<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; board on my powerpc machine?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Start by sharing the dmesg output, and maybe also t=
he kernel build<br>
&gt;=C2=A0 =C2=A0 =C2=A0configuration file.<br>
&gt;<br>
&gt; =C2=A0<br>
&gt; Both are attached (gzipped because of size).<br>
<br>
</span>It might be related to this:<br>
<br>
[=C2=A0 =C2=A010.482772] radeon: No coherent DMA available.<br>
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br></div></div></block=
quote><div><br></div><div>I updated my device-tree to add incoming pcie ran=
ges, and that removes this error:</div><div><br></div><div>[=C2=A0 =C2=A010=
.161044] [drm] radeon kernel modesetting enabled.</div><div>[=C2=A0 =C2=A01=
0.165168] [drm] initializing kernel modesetting (VERDE 0x1002:0x6822 0x1002=
:0x031E).</div><div>[=C2=A0 =C2=A010.171799] radeon: No coherent DMA availa=
ble.</div><div>[=C2=A0 =C2=A010.171831] [drm] register mmio base: 0x4100000=
0</div><div>[=C2=A0 =C2=A010.171832] [drm] register mmio size: 262144</div>=
<div>[=C2=A0 =C2=A010.411061] ATOM BIOS: E268</div><div>[=C2=A0 =C2=A010.41=
2569] [drm] GPU not posted. posting now...</div><div>[=C2=A0 =C2=A010.44183=
1] radeon 0002:01:00.0: VRAM: 2048M 0x0000000000000000 - 0x000000007FFFFFFF=
 (2048M used)</div><div>[=C2=A0 =C2=A010.449408] radeon 0002:01:00.0: GTT: =
1024M 0x0000000080000000 - 0x00000000BFFFFFFF</div><div>[=C2=A0 =C2=A010.45=
5771] [drm] Detected VRAM RAM=3D2048M, BAR=3D256M</div><div>[=C2=A0 =C2=A01=
0.459349] [drm] RAM width 128bits DDR</div><div>[=C2=A0 =C2=A010.462455] [T=
TM] Zone=C2=A0 kernel: Available graphics memory: 1978634 kiB</div><div>[=
=C2=A0 =C2=A010.467688] [TTM] Initializing pool allocator</div><div>[=C2=A0=
 =C2=A010.470755] [TTM] Initializing DMA pool allocator</div><div>[=C2=A0 =
=C2=A010.474194] [drm] radeon: 2048M of VRAM memory ready</div><div>[=C2=A0=
 =C2=A010.477859] [drm] radeon: 1024M of GTT memory ready.</div><div>[=C2=
=A0 =C2=A010.481549] [drm] Loading verde Microcode</div><div>[=C2=A0 =C2=A0=
10.500383] [drm] Internal thermal controller with fan control</div><div>[=
=C2=A0 =C2=A010.505048] [drm] probing gen 2 caps for device 1957:830 =3D 73=
f443/e</div><div>[=C2=A0 =C2=A010.522317] [drm] radeon: dpm initialized</di=
v><div>[=C2=A0 =C2=A010.539675] [drm] GART: num cpu pages 262144, num gpu p=
ages 262144</div><div>[=C2=A0 =C2=A010.546129] [drm] probing gen 2 caps for=
 device 1957:830 =3D 73f443/e</div><div>[=C2=A0 =C2=A010.551121] [drm] PCIE=
 gen 3 link speeds already enabled</div><div>[=C2=A0 =C2=A010.581276] [drm]=
 PCIE GART of 1024M enabled (table at 0x0000000000277000).</div><div>[=C2=
=A0 =C2=A010.587142] radeon 0002:01:00.0: WB enabled</div><div>[=C2=A0 =C2=
=A010.590019] radeon 0002:01:00.0: fence driver on ring 0 use gpu addr 0x00=
00000080000c00 and cpu addr 0xc0000000ed15bc00</div><div>[=C2=A0 =C2=A010.5=
99515] radeon 0002:01:00.0: fence driver on ring 1 use gpu addr 0x000000008=
0000c04 and cpu addr 0xc0000000ed15bc04</div><div>[=C2=A0 =C2=A010.609008] =
radeon 0002:01:00.0: fence driver on ring 2 use gpu addr 0x0000000080000c08=
 and cpu addr 0xc0000000ed15bc08</div><div>[=C2=A0 =C2=A010.618499] radeon =
0002:01:00.0: fence driver on ring 3 use gpu addr 0x0000000080000c0c and cp=
u addr 0xc0000000ed15bc0c</div><div>[=C2=A0 =C2=A010.627992] radeon 0002:01=
:00.0: fence driver on ring 4 use gpu addr 0x0000000080000c10 and cpu addr =
0xc0000000ed15bc10</div><div>[=C2=A0 =C2=A010.639273] radeon 0002:01:00.0: =
fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0x80000=
80088db5a18</div><div>[=C2=A0 =C2=A010.648762] [drm] Supports vblank timest=
amp caching Rev 2 (21.10.2013).</div><div>[=C2=A0 =C2=A010.654078] [drm] Dr=
iver supports precise vblank timestamp query.</div><div>[=C2=A0 =C2=A010.65=
8873] radeon 0002:01:00.0: radeon: MSI limited to 32-bit</div><div>[=C2=A0 =
=C2=A010.663455] radeon 0002:01:00.0: radeon: using MSI.</div><div>[=C2=A0 =
=C2=A010.667069] [drm] radeon: irq initialized.</div><div>[=C2=A0 =C2=A011.=
353989] [drm:.r600_ring_test [radeon]] *ERROR* radeon: ring 0 test failed (=
scratch(0x850C)=3D0xCAFEDEAD)</div><div>[=C2=A0 =C2=A011.362354] radeon 000=
2:01:00.0: disabling GPU acceleration</div><div>[=C2=A0 =C2=A011.543395] [d=
rm] Radeon Display Connectors</div><div>[=C2=A0 =C2=A011.546272] [drm] Conn=
ector 0:</div><div>[=C2=A0 =C2=A011.548027] [drm]=C2=A0 =C2=A0DP-1</div><di=
v>[=C2=A0 =C2=A011.549248] [drm]=C2=A0 =C2=A0HPD1</div><div>[=C2=A0 =C2=A01=
1.550471] [drm]=C2=A0 =C2=A0DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 =
0x653c 0x653c</div><div>[=C2=A0 =C2=A011.556569] [drm]=C2=A0 =C2=A0Encoders=
:</div><div>[=C2=A0 =C2=A011.558224] [drm]=C2=A0 =C2=A0 =C2=A0DFP1: INTERNA=
L_UNIPHY1</div><div>[=C2=A0 =C2=A011.561192] [drm] Connector 1:</div><div>[=
=C2=A0 =C2=A011.562941] [drm]=C2=A0 =C2=A0DP-2</div><div>[=C2=A0 =C2=A011.5=
64162] [drm]=C2=A0 =C2=A0HPD4</div><div>[=C2=A0 =C2=A011.565384] [drm]=C2=
=A0 =C2=A0DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c 0x656c</div=
><div>[=C2=A0 =C2=A011.571480] [drm]=C2=A0 =C2=A0Encoders:</div><div>[=C2=
=A0 =C2=A011.573136] [drm]=C2=A0 =C2=A0 =C2=A0DFP2: INTERNAL_UNIPHY1</div><=
div>[=C2=A0 =C2=A011.576103] [drm] Connector 2:</div><div>[=C2=A0 =C2=A011.=
577846] [drm]=C2=A0 =C2=A0DP-3</div><div>[=C2=A0 =C2=A011.579074] [drm]=C2=
=A0 =C2=A0HPD5</div><div>[=C2=A0 =C2=A011.580297] [drm]=C2=A0 =C2=A0DDC: 0x=
6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c</div><div>[=C2=A0 =C2=
=A011.586393] [drm]=C2=A0 =C2=A0Encoders:</div><div>[=C2=A0 =C2=A011.588057=
] [drm]=C2=A0 =C2=A0 =C2=A0DFP3: INTERNAL_UNIPHY2</div><div>[=C2=A0 =C2=A01=
1.591023] [drm] Connector 3:</div><div>[=C2=A0 =C2=A011.592767] [drm]=C2=A0=
 =C2=A0DP-4</div><div>[=C2=A0 =C2=A011.593987] [drm]=C2=A0 =C2=A0HPD6</div>=
<div>[=C2=A0 =C2=A011.595216] [drm]=C2=A0 =C2=A0DDC: 0x6570 0x6570 0x6574 0=
x6574 0x6578 0x6578 0x657c 0x657c</div><div>[=C2=A0 =C2=A011.601313] [drm]=
=C2=A0 =C2=A0Encoders:</div><div>[=C2=A0 =C2=A011.602978] [drm]=C2=A0 =C2=
=A0 =C2=A0DFP4: INTERNAL_UNIPHY2</div><div>[=C2=A0 =C2=A011.692728] radeon =
0002:01:00.0: No connectors reported connected with modes</div><div>[=C2=A0=
 =C2=A011.698480] [drm] Cannot find any crtc or sizes - going 1024x768</div=
><div>[=C2=A0 =C2=A011.708402] [drm] fb mappable at 0xC60478000</div><div>[=
=C2=A0 =C2=A011.711369] [drm] vram apper at 0xC60000000</div><div>[=C2=A0 =
=C2=A011.714242] [drm] size 3145728</div><div>[=C2=A0 =C2=A011.715993] [drm=
] fb depth is 24</div><div>[=C2=A0 =C2=A011.717910] [drm]=C2=A0 =C2=A0 pitc=
h is 4096</div><div>[=C2=A0 =C2=A011.720091] radeon 0002:01:00.0: fb0: rade=
ondrmfb frame buffer device</div><div>[=C2=A0 =C2=A011.725236] radeon 0002:=
01:00.0: registered panic notifier</div><div>[=C2=A0 =C2=A011.742619] [drm]=
 Initialized radeon 2.42.0 20080528 for 0002:01:00.0 on minor 0</div><div>[=
=C2=A0 =C2=A040.806632] random: nonblocking pool is initialized</div><div><=
br></div><div>Bas Vermeulen</div></div></div></div>

--089e0827e9fce8066b0565b688e0--

--===============1395453865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1395453865==--

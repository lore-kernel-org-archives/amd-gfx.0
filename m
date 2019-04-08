From: Daryl Kuchay <daryl.kuchay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: vega20_ta.bin
Date: Mon, 8 Apr 2019 11:57:33 -0400
Message-ID: <CAE5gGPCWYZ9NT9fN6kM=Ysf55Fd+ZowSEepJv5nD9nTKpFOFGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0977707928=="
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

--===============0977707928==
Content-Type: multipart/alternative; boundary="000000000000dc9b15058606e5be"

--000000000000dc9b15058606e5be
Content-Type: text/plain; charset="UTF-8"

Trying to build linux-5.07 on gentoo. Installed linux-firmware and it looks
to be from 3/13:

https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-kernel/linux-firmware/linux-firmware-20190313.ebuild


At cpio stage of genkernel I see the following:

cp: cannot stat '/lib/firmware/amdgpu/vega20_ta.bin': No such file or
directory


Have not been able to get a working kernel. Simply taking gentoo wiki
config adds from a zcat on current config from gentoo 4/03 install media
running on kernel 4.19.

Looking in lib/firmware/amdgpu after installation of linux-firmware I see
no file for:

vega20_ta.bin

Just grabbed a fresh linux-firmware from git and looking inside reveals
that:

vega20_ta.bin

is not within current either. I see mentions of it in psp patch files
visible from git but I dont see the firmware file itself anywhere.

Would this be keeping me from booting?

Thank you

Daryl

--000000000000dc9b15058606e5be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Trying to build linux-5.07 on gentoo. Ins=
talled linux-firmware and it looks to be from 3/13:<div><br></div><div><a h=
ref=3D"https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-kernel/linux-firm=
ware/linux-firmware-20190313.ebuild">https://gitweb.gentoo.org/repo/gentoo.=
git/tree/sys-kernel/linux-firmware/linux-firmware-20190313.ebuild</a>=C2=A0=
</div><div><br></div><div>At cpio stage of genkernel I see the following:</=
div><div><br></div><div>cp: cannot stat &#39;/lib/firmware/amdgpu/vega20_ta=
.bin&#39;: No such file or directory<br></div><div><br></div><div><br></div=
><div>Have not been able to get a working kernel. Simply taking gentoo wiki=
 config adds from a zcat on current config from gentoo 4/03 install media r=
unning on kernel 4.19.=C2=A0</div><div><br></div><div>Looking in lib/firmwa=
re/amdgpu after installation of linux-firmware I see no file for:</div><div=
><br></div><div>vega20_ta.bin=C2=A0</div><div><br></div><div>Just grabbed a=
 fresh linux-firmware from git and looking inside reveals that:</div><div><=
br></div><div>vega20_ta.bin</div><div><br></div><div>is not within current =
either. I see mentions of it in psp patch files visible from git but I dont=
 see the firmware file itself anywhere.=C2=A0</div><div><br></div><div>Woul=
d this be keeping me from booting?</div><div><br></div><div>Thank you</div>=
<div><br></div><div>Daryl=C2=A0=C2=A0<br></div><div>=C2=A0<br></div></div><=
/div>

--000000000000dc9b15058606e5be--

--===============0977707928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0977707928==--

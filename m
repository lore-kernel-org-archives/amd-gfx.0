From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: AMD E8860 on PowerPC with u-boot (T2080)
Date: Wed, 21 Feb 2018 09:49:54 +0100
Message-ID: <CAGtoiRjxS7mgQKG_yib9-5tVkD9_yAkp3P8PxYvipy3bFnV9Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1692047797=="
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

--===============1692047797==
Content-Type: multipart/alternative; boundary="001a1147c9e6d719c50565b502f7"

--001a1147c9e6d719c50565b502f7
Content-Type: text/plain; charset="UTF-8"

Hi,

I am unsure if this is the right place to ask, but it seems relevant.

I am trying to use an AMD E8860 (SI) board connected to an E6500 PowerPC
board (T2080RDB from NXP).
The T2080RDB does not use a BIOS, and uses u-boot to bootstrap Linux.

I have the E8860 connected to a PCIe x4 slot with an adapter. The kernel is
a 4.1, with DRM included in the kernel and the radeon as a module. The
radeon driver detects the card, notices the BIOS hasn't posted and starts
things up.
After that, the ring tests get run, and fails on the ring 0 test, disabling
acceleration. The graphics card is (or seems to be) working apart from
that, the driver starts up and sees the connectors on the board.

When I compare dmesg on an x86 machine and the PPC machine, I see that the
x86 machine loads a lot more firmware from the kernel (probably the
acceleration parts?).

My question is, what do I need to do to correctly initialize the E8860
board on my powerpc machine?
Is there some documentation you can point me to, or someone to ask?

Bas Vermeulen

--001a1147c9e6d719c50565b502f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am unsure if this is the right pl=
ace to ask, but it seems relevant.</div><div><br></div><div>I am trying to =
use an AMD E8860 (SI) board connected to an E6500 PowerPC board (T2080RDB f=
rom NXP).</div><div>The T2080RDB does not use a BIOS, and uses u-boot to bo=
otstrap Linux.</div><div><br></div><div>I have the E8860 connected to a PCI=
e x4 slot with an adapter. The kernel is a 4.1, with DRM included in the ke=
rnel and the radeon as a module. The radeon driver detects the card, notice=
s the BIOS hasn&#39;t posted and starts things up.</div><div>After that, th=
e ring tests get run, and fails on the ring 0 test, disabling acceleration.=
 The graphics card is (or seems to be) working apart from that, the driver =
starts up and sees the connectors on the board.</div><div><br></div><div>Wh=
en I compare dmesg on an x86 machine and the PPC machine, I see that the x8=
6 machine loads a lot more firmware from the kernel (probably the accelerat=
ion parts?).</div><div><br></div><div>My question is, what do I need to do =
to correctly initialize the E8860 board on my powerpc machine?</div><div>Is=
 there some documentation you can point me to, or someone to ask?</div><div=
><br></div><div>Bas Vermeulen</div></div>

--001a1147c9e6d719c50565b502f7--

--===============1692047797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1692047797==--

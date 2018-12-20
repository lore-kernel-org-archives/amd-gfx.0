From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Trying to run AMD E9260 (Polaris 11) on NXP LS1012A-RDB
Date: Thu, 20 Dec 2018 15:06:28 +0100
Message-ID: <CAGtoiRiubNF5fCwGvYbC_sxzFk10Ceg79ZsK2fPLXUzFvm_QZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2110870071=="
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

--===============2110870071==
Content-Type: multipart/alternative; boundary="000000000000a7fe8e057d74a305"

--000000000000a7fe8e057d74a305
Content-Type: text/plain; charset="UTF-8"

Hi all,

I have connected an E9260 (Polaris 11 based) to a mini-PCIe slot on my NXP
LS1012ARDB.
The GPU is seen, all the BARs are correctly assigned (but there's not
enough PCIe memory space for the big BARs).

When I try to load the amdgpu module, I can't get the driver to enable the
acceleration (the scratch register check fails).

The E9260 is connected to a PCIe x1 (Gen2) slot.

Anyone have an idea on where to look or how to fix this? This is a test-bed
before we get an LS1046ARDB with quad core A72's.

Any help would be appreciated,

Bas Vermeulen

--000000000000a7fe8e057d74a305
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I have connected an E9260 (Pola=
ris 11 based) to a mini-PCIe slot on my NXP LS1012ARDB.</div><div>The GPU i=
s seen, all the BARs are correctly assigned (but there&#39;s not enough PCI=
e memory space for the big BARs).</div><div><br></div><div>When I try to lo=
ad the amdgpu module, I can&#39;t get the driver to enable the acceleration=
 (the scratch register check fails).</div><div><br></div><div>The E9260 is =
connected to a PCIe x1 (Gen2) slot.</div><div><br></div><div>Anyone have an=
 idea on where to look or how to fix this? This is a test-bed before we get=
 an LS1046ARDB with quad core A72&#39;s.</div><div><br></div><div>Any help =
would be appreciated,</div><div><br></div><div>Bas Vermeulen</div></div>

--000000000000a7fe8e057d74a305--

--===============2110870071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2110870071==--

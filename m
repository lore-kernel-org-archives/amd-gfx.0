From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: OpenCL with Mesa on E8860 on big endian system (PowerPC)
Date: Wed, 28 Mar 2018 14:27:31 +0200
Message-ID: <CAGtoiRhzmO7Dus8CR0WUk_3gz4H3FF9O+Q2d6f84=L2br6QMCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1424362494=="
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

--===============1424362494==
Content-Type: multipart/alternative; boundary="f403045f16948bfa600568782144"

--f403045f16948bfa600568782144
Content-Type: text/plain; charset="UTF-8"

Hi,

I've managed to configure my device-tree correctly, and am now able to
correctly start
the radeon driver with acceleration on my T2080 (an e6500 PowerPC chip)
with an AMD E8860 GPU (radeon/radeonsi). Thanks for the help with that.

I am able to run a small OpenCL program that fills a float buffer with
values (1024 float array, filled with values from 0.0 - 1023.0), and am
even able to read expected data (part of it anyways).
When reading my array, I see that the first 257 values are correct after
byteswapping (as expected, since the GPU is little endian), but all data
above that is random junk.

In order to debug this, I would like to check the values put into
ring0-ring5. Is the format for these documented somewhere, and can anyone
point me to this?

I've already sent a small patch to mesa-dev to fix an endianness issue I
had to fix to get mesa/clover/gallium to work at all. I'd like to get this
working correctly completely.

Bas Vermeulen

--f403045f16948bfa600568782144
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;ve managed to configure my de=
vice-tree correctly, and am now able to correctly start</div><div>the radeo=
n driver with acceleration on my T2080 (an e6500 PowerPC chip) with an AMD =
E8860 GPU (radeon/radeonsi). Thanks for the help with that.</div><div><br><=
/div><div>I am able to run a small OpenCL program that fills a float buffer=
 with values (1024 float array, filled with values from 0.0 - 1023.0), and =
am even able to read expected data (part of it anyways).</div><div>When rea=
ding my array, I see that the first 257 values are correct after byteswappi=
ng (as expected, since the GPU is little endian), but all data above that i=
s random junk.</div><div><br></div><div>In order to debug this, I would lik=
e to check the values put into ring0-ring5. Is the format for these documen=
ted somewhere, and can anyone point me to this?</div><div><br></div><div>I&=
#39;ve already sent a small patch to mesa-dev to fix an endianness issue I =
had to fix to get mesa/clover/gallium to work at all. I&#39;d like to get t=
his working correctly completely.</div><div><br></div><div>Bas Vermeulen</d=
iv></div>

--f403045f16948bfa600568782144--

--===============1424362494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1424362494==--

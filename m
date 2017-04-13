From: Dennis Schridde <dennis.schridde-axtXthT+lymYbFdUjOg7S7NAH6kLmebB@public.gmane.org>
Subject: AMDGPU without display output
Date: Thu, 13 Apr 2017 16:31:42 +0200
Message-ID: <2259850.ejp6DaCL9T@c07060>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0478962630=="
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

--===============0478962630==
Content-Type: multipart/signed; boundary="nextPart11244928.oNnvTFJaHV"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart11244928.oNnvTFJaHV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello again!

I am trying to use a AMD FirePro S7150X2 with the AMDGPU driver of a Linux 
4.10.9 kernel (CoreOS Container Linux) and linux-firmware 
e39f0e3e6897ad865b3704f61218ae83f98a85da.

Since the card has no display output and I want to run remote applications 
only, I would like to prevent any interference with mode setting and the 
kernel console. Thus I set "nomodeset" on the kernel command line to prevent 
the kernel from trying to initialise anything but the rendering functions of 
the card. However, this leads to following error message:

[drm:init_module [amdgpu]] *ERROR* VGACON disables amdgpu kernel modesetting.

The result is that the AMDGPU module can not be loaded.

Is this generally the right approach to use this driver for rendering without 
display output, or can I safely leave KMS enabled and it will not interfere 
with my application's X servers and the OpenGL applications running on them?

Assuming I have to disable KMS, how would I get past this error, i.e. to 
initialise the card's rendering functions, but skipping initialisation of the 
output part of the driver?

Generally asking: How do people use this card for GPGPU compute (i.e. 
headless) tasks? Is there some documentation what I need to pay attention to?

Thanks,
Dennis
--nextPart11244928.oNnvTFJaHV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQG0BAABCAAGBQJY74vOAAoJENS5dBsVnRQdcSkMvjiKblwDJZgPH8ESBLd1Decr
y0qnPRF+PwOSWj4D8v/LBx9qSosEjwcx8xGKqbXWSt4DQG/QlyvmKyGoDLkvkdLt
E6ZhacBsKS/ULd6++MBsffyJxk5Ss0nwhVfBJPIrzPkLoXs/IofcpEGyqQUdyBH9
RaZy102FKXMeDWIWk0B0eGkSSbwlSZuvyq/ArUkrVPKrLn7Wx27PmGcDHsnGgwT4
phsI01ib4tsgBU0BhoGmWI60akFdPgPIg9Bmagn5ir3MmAnXc6VhfjmqWxOOvAqz
3BqR1LlfHI2KpUeAeYTctHcxR177kmE/FoRXUJU4n/AferhxNvLVxTnGkJSmuPsv
04zchzkfoG+RoEmR0ru6AG4fBewG3wJzzv0eaIRxzNKZgdhcJv9FF1J5EY++4qrr
LQ5y9fTpVgMmd429CGI+zfdQG6HLjuip2Z7NzPUgktjH3X90mg7/fDdJcKi1HWW9
Jw/QBbSuY83bvtNhjjsJM24RyvJGhDh+e+lq2IhnAlJwyqpDKI1prL7E+TKJtazk
rRvGUq/3HQ==
=9bBx
-----END PGP SIGNATURE-----

--nextPart11244928.oNnvTFJaHV--


--===============0478962630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0478962630==--

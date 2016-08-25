From: Dennis Schridde <dennis.schridde-axtXthT+lymYbFdUjOg7S7NAH6kLmebB@public.gmane.org>
Subject: Bind amdgpu to SR-IOV virtual function
Date: Thu, 25 Aug 2016 17:00:41 +0200
Message-ID: <2568946.uSqerHif76@c07060>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1564394169=="
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

--===============1564394169==
Content-Type: multipart/signed; boundary="nextPart4646944.67BIpW57PF"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4646944.67BIpW57PF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hello!

I investigating the virtualisation abilities of current AMD FirePro hardwar=
e;=20
specifically how to securely pass a share of a GPU to one application (a Rk=
t/
Docker container). I already read vfio.txt and pci-iov-howto.txt, but they =
do=20
not answer my questions. I was unable to find documentation on the process=
=20
online, either.

1. How do I create VFs from a AMD FirePro PF? I saw an example using VMWare=
=20
ESXi tools, where it is possible to specify RAM size and time-share, but I=
=20
have not seen how that translates to modifying /sys/bus/pci/..., which is t=
he=20
method recommended for SR-IOV devices in pci-iov-howto.txt.

2. After having created VFs, is it possible to bind these to the host's amd=
gpu=20
driver, so that I get multiple /dev/dri/card* device nodes?

3. Will passing these /dev/dri/card* device nodes into a Rkt/Docker contain=
er=20
be enough for the AMD Radeon Pro OpenGL runtime to be able to use that card?

Best regards,
Dennis Schridde
=2D-=20
Heidelberg University Computing Centre
Service division: Future IT - Research & Education

Tel. +49 6221 54-4519, Fax +49 6221 54-5581
dennis.schridde-axtXthT+lymYbFdUjOg7S7NAH6kLmebB@public.gmane.org

http://www.urz.uni-heidelberg.de/

Ruprecht-Karls-Universit=E4t Heidelberg
Universit=E4tsrechenzentrum
Im Neuenheimer Feld 293, 69120 Heidelberg, Germany
--nextPart4646944.67BIpW57PF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQG0BAABCAAGBQJXvwgZAAoJENS5dBsVnRQdNLgMvih+Y+t3Z7ilAvDF6y7bJkIR
tMRWmsDgVh/T+nnSy+YMlqVBnaWAxMiYcniP/uOkHOX7RzYfI0MkC/bZAFH4rxZJ
WmOVig8nGiNhvZs2ntzFrLffHJKHRcLzDfLMjlA4B7+Z9xK03VeCs1aJjVUclvMo
pknyRpVndl/THtWFx7ntfAr1s7UWn0RPImSjsbJgjvdTU3Z/WTRyZF5iYtBaT7yc
X2PwJSy8QevXROipPGbOVzWOXhQsNPRKb12mCRj9q0Ltp5HoEDG6gd67esVMaJqW
mYlmvOb5dw5rMDTi3iEHkykc9Kk8SSIhSvu6cC5bKvn2DtpY4pjC8zTLPEKljrLn
OMHVAh5mkrLl0J4XZ6L6ltGlF364JAIks7vNMaN0aT041ShmRZi7rBwSxcbUUmA1
PXIKUvGmPes6yON83xsPeh4QPbCDol1da/WAWhj05C0RslN5rv3sRCnNmKF0cCVu
k3StSkX8dsAUKdtqYhjbOVxJfzZPVOGVzSw98kQ4aUBTA8D0Ev8+YxtF4zayoP86
WvP1Gn7CNw==
=hIPl
-----END PGP SIGNATURE-----

--nextPart4646944.67BIpW57PF--


--===============1564394169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1564394169==--

From: Luya Tshimbalanga <luya-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Subject: GPU lockup with amdgpu driver
Date: Wed, 31 Aug 2016 10:51:18 -0700
Message-ID: <654eebe2-fa52-ee1e-8144-1b3664c96f40@fedoraproject.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0818750841=="
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0818750841==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IDqf5EULmqI2FH4IxKeol2AimEaFJLBi8"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IDqf5EULmqI2FH4IxKeol2AimEaFJLBi8
Content-Type: multipart/mixed; boundary="vQ2XaevGc1t0Pb77ChCwkKQSBotb4r8UO";
 protected-headers="v1"
From: Luya Tshimbalanga <luya-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <654eebe2-fa52-ee1e-8144-1b3664c96f40-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Subject: GPU lockup with amdgpu driver

--vQ2XaevGc1t0Pb77ChCwkKQSBotb4r8UO
Content-Type: multipart/alternative;
 boundary="------------EB947BC3BAA6D31907C8CDA6"

This is a multi-part message in MIME format.
--------------EB947BC3BAA6D31907C8CDA6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Upon recommendation from Phoronix comment, here is the bug report.[1]

Updating linux-firmware snapshot from 20160609 (gita4bbc811) to 20160816
(git7c3dfc0b) caused a GPU lockup on enabled amdgpu driver  for CIK (Sea
Island) card  affecting kernel 4.8+ and the staging kernel branches. An
example below during the boot process:

radeon 0000:00:01.0: GPU lockup (current fence id 0x0000000000000003 last=
 fence id 0x0000000000000004 on ring 0)
Aug 29 16:51:37 kernel: radeon 0000:00:01.0: ring 0 stalled for more than=
 10581msec

Reverting the linux-firmware snapshot to 20160609 fixed the issue. Will
it possible to fix? What will be the step to provide the traceback ?

Test is done with ASUS X550ZE powered by AMD A10 7400P featuring Radeon
R7 M265DX

Ref:
----
[1]
https://www.phoronix.com/forums/forum/linux-graphics-x-org-drivers/open-s=
ource-amd-linux/889794-amd-staging-4-6-for-fedora-24-amdgpu/page6?_=3D147=
2604363785


--=20
Luya Tshimbalanga
Graphic & Web Designer
E: luya-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org
W: http://www.coolest-storm.net


--------------EB947BC3BAA6D31907C8CDA6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Upon recommendation from Phoronix comment, here is the bug
    report.[1]<br>
    <br>
    Updating linux-firmware snapshot from 20160609 (gita4bbc811) to
    20160816 (git7c3dfc0b) caused a GPU lockup on enabled amdgpu driver=C2=
=A0
    for CIK (Sea Island) card=C2=A0 affecting kernel 4.8+ and the staging=

    kernel branches. An example below during the boot process:<br>
    <br>
    <pre class=3D"bbcode_code" style=3D"height:60px;">radeon 0000:00:01.0=
: GPU lockup (current fence id 0x0000000000000003 last fence id 0x0000000=
000000004 on ring 0)
Aug 29 16:51:37 kernel: radeon 0000:00:01.0: ring 0 stalled for more than=
 10581msec</pre>
    Reverting the linux-firmware snapshot to 20160609 fixed the issue.
    Will it possible to fix? What will be the step to provide the
    traceback ?<br>
    <br>
    Test is done with ASUS X550ZE powered by AMD A10 7400P featuring
    Radeon R7 M265DX<br>
    <br>
    Ref:<br>
    ----<br>
    [1]
<a class=3D"moz-txt-link-freetext" href=3D"https://www.phoronix.com/forum=
s/forum/linux-graphics-x-org-drivers/open-source-amd-linux/889794-amd-sta=
ging-4-6-for-fedora-24-amdgpu/page6?_=3D1472604363785">https://www.phoron=
ix.com/forums/forum/linux-graphics-x-org-drivers/open-source-amd-linux/88=
9794-amd-staging-4-6-for-fedora-24-amdgpu/page6?_=3D1472604363785</a><br>=

    <pre class=3D"moz-signature" cols=3D"72">

--=20
Luya Tshimbalanga
Graphic &amp; Web Designer
E: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:luya@fedoraprojec=
t.org">luya-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org</a>
W: <a class=3D"moz-txt-link-freetext" href=3D"http://www.coolest-storm.ne=
t">http://www.coolest-storm.net</a>
</pre>
  </body>
</html>

--------------EB947BC3BAA6D31907C8CDA6--

--vQ2XaevGc1t0Pb77ChCwkKQSBotb4r8UO--

--IDqf5EULmqI2FH4IxKeol2AimEaFJLBi8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXxxkXAAoJEF5SgXTYomCaQdoH/1IcOvNqzPy2ZSzri6LTiwWk
R8F8iovIJrgjq0KGg0gVRW8QRLwMdQfGzcrhIfjtQrNK1CTZVNXhH8DA7PJQapNp
6UzeG5FvtbNaondm9nYaLzX8Dea9sbu6/uj/SF7NES2z81lwde2eb3mWP+MnWShr
0SoS47HVAfgD1PXCGJ0LTqVNyrXUK2eictCpttt89nexb0lG6IjHXobdwZYG++JW
BwTOHenhSRWda+N1I6FLlP7gp/Cdw32+8+qOBtwx6m4jbVqxeAPJoWcz7gKHtWXT
uWsCtws2IwLvsY2MQwlMV5FDKKJVk//+7B0kQaqL9dAQethpLnGzXRj5MavWmi8=
=oHkf
-----END PGP SIGNATURE-----

--IDqf5EULmqI2FH4IxKeol2AimEaFJLBi8--

--===============0818750841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0818750841==--

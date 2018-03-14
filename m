From: Jona Stubbe <gpg2025-ilhm+zE510QR3TpqV4T2kg@public.gmane.org>
Subject: Debugging modesetting problem
Date: Thu, 15 Mar 2018 00:52:55 +0100
Message-ID: <3135989.9rTpBQRE1N@jona-m500>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1574543915=="
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

--===============1574543915==
Content-Type: multipart/signed; boundary="nextPart6103326.OHJuSJLdTY"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart6103326.OHJuSJLdTY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi AMD graphics developers,

I've recently hit a modesetting problem: when I used the DisplayPort KVM 
switch that I got yesterday to connect my PC (running Arch Linux) to my 4K 
monitor, it only worked in 3 out of about 60 times of switching/replugging the 
cable (the BIOS always manages to put something onscreen, though).
I've tried both graphics cards available to me right now: a Polaris (RX 480) 
and a Cayman (HD 6950/6970) and neither of them modesets properly and 
reliably.
I wouldn't be opposed to doing some work to fix this myself, as this is a good 
opportunity for me to get into system development, however I don't know where 
to start.
I have full (root if required) access to the system, so building/running 
custom kernels or whatever is necessary is not a big problem. However, logic 
analysers (or whatever you may need to find out what actually goes over the 
wire) are out of my reach. Is this something I can tackle?

Yours faithfully
Jona Stubbe

PS: if there is a shorter-latency way of asking this kind of question (like an 
IRC channel), I'd be interested too :)
--nextPart6103326.OHJuSJLdTY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE/5FapFcPE+aNCRTJE83Pxj8bWXAFAlqptdcACgkQE83Pxj8b
WXAvyxAAzdGzTEBh8v3T8j4wmgEeVI8TdFwiIl0AvE/T4dpITJ5ZdUZI0jEO0Fq7
Oxb9YgG6l1bJjkq+DZUKQueg/q5hK6wwpO+yW9Eaa6S70rbiWgQMjZuejvxR3Poh
7+OjUM47TgiP/VP+b9ccMGoT838I0XddgAuyj2p6AXVDyGykk+MA9NJZKy2nuttT
kFaDhGEu7D2f899EvyVyCr9pvE19xAnZkzGBj8UdaOWl6Lp7Ips/qn8bufTJFjVR
iOntHRAdCSal/6mLL+2MKwgTH4z2l059kJXp7B7kaX1yn9cK4mmnX9vTMihj/d0a
jQbF1psTSj1tm7GXN0tDKTRlRgcl5QVp4ioD/UCRRJ1r+3Bm1h7VNj1TuUbImVxH
KQHBnD0SX4ew3j0xzqkV90R3g7lQgZ6YuMiMDs6ZkCBU3o/blgEKNvdNz0uxMtRJ
H+wtfsinNKfSuVzeXtxTA933ji0NCMuM7lsmLPQycB79igEcVxkK2irPslUHbKnW
gSR2Y0Vpu1zr6NDNNU7GDFKUiKjcEW0LDqnqF7kfBHj6d6DAeomAWUf6EkxQhDnX
+ZHbbRjiu0hdTWlLftv6pTEcJWqEZeDgJ4IS30k48HoTQv4lxb6yfjgkB8dSoDRK
2eHVi+7mCeGDPcXKnLT1rWrCDczETIwVarHtKlFdGTGU+LtMA4U=
=pzlX
-----END PGP SIGNATURE-----

--nextPart6103326.OHJuSJLdTY--




--===============1574543915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1574543915==--

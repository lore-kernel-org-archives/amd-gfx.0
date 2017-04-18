From: Dennis Schridde <dennis.schridde-axtXthT+lymYbFdUjOg7S7NAH6kLmebB@public.gmane.org>
Subject: Re: AMDGPU without display output
Date: Tue, 18 Apr 2017 14:25:18 +0200
Message-ID: <2000813.UM9hCpDLC0@c07060>
References: <2259850.ejp6DaCL9T@c07060> <6870657.eATv821s2Z@c07060>
 <DM5PR12MB1739D59ACC914AE04D4A35E38F050@DM5PR12MB1739.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0687123204=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1739D59ACC914AE04D4A35E38F050-2J9CzHegvk/RSyQDjr89dQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Yu,
 Qiang" <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>

--===============0687123204==
Content-Type: multipart/signed; boundary="nextPart2052818.CD4Fa64u2R"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2052818.CD4Fa64u2R
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 14. April 2017 03:50:30 CEST Yu, Qiang wrote:
> PS. If you want to use X11/OGL on this no display output card, just add an
> option to the amdgpu kernel module "virtual_display=all" which will fake a
> display output so that the xserver can start with amdgpu DDX successfully.
> You can use remote desktop apps like VNC to view the X screen.

Thanks a lot for that information! This will likely simplify several things, 
once we solve the "Fatal error during GPU init" (see my other email).

--Dennis
--nextPart2052818.CD4Fa64u2R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQG0BAABCAAGBQJY9gWuAAoJENS5dBsVnRQdLNsMv2CKpkQEKxYjcRe+ZqbX4iFR
2mebmb/mAQb4kR/j/rUrPlCSc8TyUcYRgZ0e06QLQ6wMHKoqvtWPZmMQNIn9W1fg
nXgKEi7YwYrzeSdnvkMl4lR7hLZeM5cTE6CN3uSr9UFORB/z3/qKNyrdLRnXwO/Q
m3Zx/80yNZ6BCurGETVk0vol6uUVMh47olwrtw+IntebtFFmlp8meAg+xQ8jZ/3R
sBiZaXrqb1QMWfpH3f5skUu+OOw5IgsQzszy2qxfzgowt6ObFOLjhvmbWDHBljAt
yIv223R0+MTdU4Ampy75hTSaUemwpxplhZKGdynQ7WHw30GYXMxmuIYoUKSSDJRI
qqcWcJgAItdFiYdt00CgoKuAQHk4gn4qFxpNFvBKh+b7pRBp5HrBArf5g1boWEA8
hP0Hou2Tl/7om3g58FV+zC6yXy8ie796vfvLfgmbWADFVL5C0oYMpqDU/6poMo63
qOFOHpcngFhE7JRh00eWNeJ8F4FoO5/63FkELIGCTYnZtgeOJ4tnkNFTXoJEWxQC
hanlrwqGxQ==
=yXIp
-----END PGP SIGNATURE-----

--nextPart2052818.CD4Fa64u2R--


--===============0687123204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0687123204==--

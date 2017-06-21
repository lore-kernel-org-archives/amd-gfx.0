From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/vc4: Allow vblank_disable_immediate
	on non-fw-kms.
Date: Wed, 21 Jun 2017 09:19:04 -0700
Message-ID: <87r2ydco07.fsf@eliezer.anholt.net>
References: <20170621014457.26587-1-mario.kleiner.de@gmail.com>
 <20170621014457.26587-2-mario.kleiner.de@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1195808773=="
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170621014457.26587-2-mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: amd-gfx.lists.freedesktop.org

--===============1195808773==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> With instantaneous high precision vblank timestamping
> that updates at leading edge of vblank, the emulated
> "hw vblank counter" from vblank timestamping which
> increments at leading edge of vblank, and reliable
> page flip execution and completion at leading edge
> of vblank, we should meet the requirements for fast
> vblank irq disable/enable.
>
> Testing against rpi-4.12-rc5 Linux kernel with timing
> measurement equipment indicates this works fine,
> so allow immediate vblank disable for power saving.
>
> For debugging in case of unexpected trouble, booting
> with kernel cmdline option drm.vblankoffdelay=0
> would keep vblank irqs on to approximate old behavior.
>
> Signed-off-by: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

If you can spin this against drm-misc-next instead of the downstream
tree, I can get it applied.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAllKnHgACgkQtdYpNtH8
nuhMkw/+J6kE21IU+tjMIQkk/peyLBURp7HPLq1Jqt9h0nE+pie1YwsXvxfQK9rk
vuztOasS72//X2/IaFHg6tpk3O0sTOkloE7nlWuw53/bCWByiXBJyV1AHTxR7ANl
ji3usjwe+VrnBxzqv/xVqaHRXzRyiByH1cpVi96IYOge2YTr7dAxPDOucMl7DoPm
ZFaq6OuV7EChfdxjczCqh3qG1CxkXzzQq210E3nsdMatXmUR575WCqjDwqsZydGi
fjM3ch27mNeV0+ODSccPZndY8A90xvFzZzNodU/QFaYuCm0n18oYq6SkNRmrmJb5
wWegddPqag1JHV8Q5kD4Mknb6IwSL01BLKrmIc88fy+XnIz+QM2sLDOEtrV9lWy0
u8lxxLW+R4dkyafBo+4HgIM4vqhKU1XI3o34pvAnFgn9YRzuSzXuE4rYdhTsORKK
q7t7XHNilRVnAW9psAn0QgqX9u17tyV7fnPDFdkCSkihUz2nZwvlTPnrCdraP1Hw
5JDyR03+nimw3OEqwFD0suM14CFP1witE3nreAc9II9IILS7xuTLnK/5+eZJZ9D8
UWflqloL1L9Ku6PoZY63e0yUiABnCgnkXX6r+nfDWZWFKd5E+lg5PzIM97iTj3IN
lYMKc/rRsbV7uF7RrPfeVmYS8+GekPmOlQVu/CIR3A9gHIaPitM=
=xhYL
-----END PGP SIGNATURE-----
--=-=-=--

--===============1195808773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVhdSBt
YWlsaW5nIGxpc3QKTm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9ub3V2ZWF1Cg==

--===============1195808773==--

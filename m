From: "Keith Packard" <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RFC for a render API to support adaptive sync and VRR
Date: Tue, 17 Apr 2018 20:58:50 -0700
Message-ID: <87o9ihyxl1.fsf@keithp.com>
References: <c79421ce-9408-5cd6-5de3-0fa521146e4b@amd.com>
 <435ebd04-0435-5a6a-9f1e-e4c4fc629aa9@amd.com>
 <20180409214554.GB13967@intel.com>
 <1e8d1857-faba-85da-0136-ea7c29ec1b84@amd.com>
 <b75e31f7-ce59-de97-5445-cb4c03ff7336@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0257759809=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b75e31f7-ce59-de97-5445-cb4c03ff7336-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Nicolai =?utf-8?Q?H=C3=A4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0257759809==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> writes:

> Time-based presentation seems to be the right approach for preventing
> micro-stutter in games as well, Croteam developers have been researching
> this.

Both the Vulkan GOOGLE_display_timing extension and X11 Present
extension offer the ability to specify the desired display time in
seconds.

Similarly, I'd suggest that the min/max display refresh rate values be
advertised as time between frames rather than frames per second.

I'd also encourage using a single unit for all of these values,
preferably nanoseconds. Absolute times should all be referenced to
CLOCK_MONOTONIC.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAlrWwnoACgkQ2yIaaQAA
ABGdzw//T8vtFgbiaJIx8UEflACQPTpNoUXaWKVM9+dLRToIwIKoc1VaM857EqTr
dn8pI/DzeYSAC4H2GS7eIFcW5wZT9gNvobV9gHscpJN/M1sxiXhvWxf9x5EfYNSn
cNoa4p7EgyflH+Rh9GgWfOa9TgaNyb3W5dzI0CBHMvJvhJCnqlpMNXhvlRMhccpt
jQnIk+ZSFN+GQpsa7Cjm3wlkKrmNF1WxbEqM8L4rZBo9+8s6l41hfYgBzHUtu/aE
RG5rq8l/jLMYtW0yYHr88y1pL60aOOfNWRHxCKac0SZYo2SWS6BJsjzx8a4lB9ov
Ztu9wDppag8yLFKEmt8esYgmU7NMCW5meg93jckFcHHjWRyFfwatK9v9XcPGxW0u
NA2H1fBUf7esxfiwLVNQ2RbUlAl9/qHFdplr9L5MvXTu8YKxPMezLdjX435m48og
Lnqx3tlJ8M993McWSPQF6lBHwnS98Aozyzdsuz8B8rFG5r4MWmJlKcSFJH25toog
ITUE1mlGO2MdA+4uYkrM0EVvr0PqzIsY73hgz1tzlAPL5I870wNVFNB0ld2G7B/E
xJtVyt+yBJe+UeNRwz9HpBDy+tp9DHwUUkQjN7tXnjHj21kVeLIXudokG5BCS2M7
oAxUP1GtKB725xtPyXejvrZB5gpVm5H/0MdTyJmHpDAcBf3d3jg=
=Io+A
-----END PGP SIGNATURE-----
--=-=-=--

--===============0257759809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0257759809==--

From: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH xserver 0/6] modesetting: add DRI2 page flip support
Date: Thu, 18 Aug 2016 22:11:07 -0700
Message-ID: <86h9ahmjh0.fsf@hiro.keithp.com>
References: <1471429751-17269-1-git-send-email-Qiang.Yu@amd.com>
 <CACvgo52vhzcyAS384uQdYy_XrA0LmKRdsRnLF0UB0OhV49A7uw@mail.gmail.com>
 <MWHPR12MB121593BB7CA6C60D65B21E6B8F160@MWHPR12MB1215.namprd12.prod.outlook.com>
 <09c2176a-6a7e-b28d-d7e1-6a4bb76dab58@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1626253241=="
Return-path: <xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
In-Reply-To: <09c2176a-6a7e-b28d-d7e1-6a4bb76dab58-otUistvHUpPR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.x.org/mailman/options/xorg-devel>,
 <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.x.org/archives/xorg-devel>
List-Post: <mailto:xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.x.org/mailman/listinfo/xorg-devel>,
 <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org
Sender: "xorg-devel" <xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Yu, Qiang" <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>, Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ML xorg-devel <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1626253241==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> writes:

> This does mean though that if one has only up to patch 3 applied (e.g.
> during a bisection), one is exposed to the issues fixed by patch 4. So
> maybe patch 4 should be squashed into patch 3.

That's a very important point -- developing code in small logical steps
is a most excellent plan, but the resulting set of commits in git need
to satisfy different requirements:

 1) Make forward progress; no commit should regress any functionality,
    no commit should introduce compiler warnings (or, even worse,
    compiler errors). Adam Jackson has reminded me several times to use
    'git rebase -x make' to check a long sequence of patches with the
    compiler. Sometimes I remember on my own.

 2) Each patch should be a single change, self contained and easy to
    understand. If you can't summarize the patch in one line, it's
    probably too complicated for anyone to review effectively. If you
    ever use the word 'and' in the summary line, that's a good sign that
    the patch does more than one thing and should be split apart.

 3) The series should tell a good story. Just like writing a book, the
    final product (sequence of patches or storyline) almost certainly
    will not be presented in the original development
    order. Splitting/merging patch chunks and reordering commits is
    almost always necessary in a long patch series.

I think review takes time related to some high order polynomial function
of the patch length; maybe just quadratic, but possibly more. Long
patches that are purely mechanical changes (replacing function names,
cleaning up whitespace) might be an exception to this rule. Remember
that development is a shared activity, and that spending time making the
patches easy to review moves work from reviewer to committer, and that
is almost always a net win in total development time.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV7aU7NsiGmkAAAARAQgPJBAAiBXyGSD48cXyXMCv1aZ/YIvYOG0wuTvC
Ovn0cLPjWr2E1drNHNUlnxR0TggGQk+VDPQbCLLaT2nU1DioJSmjvfNBwyrXmEEK
usiEtwFzVNYHFG3Aqpd4dqnjj0cx4lpLhV6Y6NKIirVGDtro4GQvOKX+5guuhCH+
zpmqhA4O27JcGETyJAfEBjQpA2TRg8up9eF93e/jWCZbauv/sJfrs6mz+gDwFSVM
ZJsOsSclLWnnb3CG7cfXIEOi24Au3FG5SidtFdAx6IuqrjiHaxRRyzdMxqLfrzJv
QwzheytFmcB/Y3I/SQvrjaTT3oeZ+TMtB2CzncMkl/JQp0G+Htm7WwywiCPGDI3V
uvF2kcNY2g2v1n0Ud5jUvlj/7BB7r556eTyEeokuK2sw9z1B4qaUXmlM+2UxvRqM
SdLDfIwfdrjfsF4Jozt9uLXz+XYVQHwLiBYPa2dUt+BJdbJAqabIWiBVybcHFZqg
RL97hKmeAAE4DLDpdzOrM5EMTE6OZX8nQYo4WGewkCWbuGLO7bIlv/a/fr4ubtyM
zmSmCiDL8QMXKIyceOqiOv9Imsrv28Oy5hZckdU2xwNYdp/3yr9hgy6x++sjpn9R
kttt9UwsiVRgrC7ADSwrI2ls/VRuK4YZXYk1oyuDRPrD9HV6SjY7hc/0/q8lyElM
QFMhL/1mWmU=
=b2AQ
-----END PGP SIGNATURE-----
--=-=-=--

--===============1626253241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KeG9yZy1kZXZl
bEBsaXN0cy54Lm9yZzogWC5PcmcgZGV2ZWxvcG1lbnQKQXJjaGl2ZXM6IGh0dHA6Ly9saXN0cy54
Lm9yZy9hcmNoaXZlcy94b3JnLWRldmVsCkluZm86IGh0dHBzOi8vbGlzdHMueC5vcmcvbWFpbG1h
bi9saXN0aW5mby94b3JnLWRldmVs

--===============1626253241==--

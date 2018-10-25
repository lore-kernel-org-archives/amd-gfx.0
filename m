From: Eric Anholt <eric@anholt.net>
Subject: Re: [igt-dev] [PATCH] RFC: Make igts for cross-driver
 stuff mandatory?
Date: Thu, 25 Oct 2018 09:35:50 -0700
Message-ID: <87efcernkp.fsf@anholt.net>
References: <20181019085049.25482-1-daniel.vetter@ffwll.ch>
 <20181025125149.GG154160@art_vandelay>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0920542304=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20181025125149.GG154160@art_vandelay>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Sean Paul <sean@poorly.run>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: IGT development <igt-dev@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

--===============0920542304==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Sean Paul <sean@poorly.run> writes:

> On Fri, Oct 19, 2018 at 10:50:49AM +0200, Daniel Vetter wrote:
>> Hi all,
>>=20
>> This is just to collect feedback on this idea, and see whether the
>> overall dri-devel community stands on all this. I think the past few
>> cross-vendor uapi extensions all came with igts attached, and
>> personally I think there's lots of value in having them: A
>> cross-vendor interface isn't useful if every driver implements it
>> slightly differently.
>>=20
>> I think there's 2 questions here:
>>=20
>> - Do we want to make such testcases mandatory?
>>=20
>
> Yes, more testing =3D=3D better code.
>
>
>> - If yes, are we there yet, or is there something crucially missing
>>   still?
>
> In my experience, no. Last week while trying to replicate an intel-gfx CI
> failure, I tried compiling igt for one of my (intel) chromebooks. It seem=
s like
> cross-compilation (or, in my case, just specifying
> prefix/ld_library_path/sbin_path) is broken on igt. If we want to impose
> restrictions across the entire subsystem, we need to make sure that every=
one can
> build and deploy igt easily.
>
> I managed to hack around everything and get it working, but I still haven=
't
> tried switching out the toolchain. Once we have some GitLab CI to validate
> cross-compilation, then we can consider making IGT mandatory.
>
> It's possible that I'm just a meson n00b and didn't use the right incanta=
tion,
> so maybe it already works, but then we need better documentation.
>
> I've pasted my horrible hacks below, I also didn't have libunwind, so rem=
oved
> its usage.

I've also had to cut out libunwind for cross-compiling on many
occasions.  Worst library.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvR8OYACgkQtdYpNtH8
nugbnA//d38dKOKXQoc2QULqasRpO63vPklcmNSBj3ZcMjy67Vf24cL0XdeOePPT
oiisV3PSMODrVmxLYPes1AifauI1CO9yu0hhOdXr7NOfHj4LG+YdORkWoRK3xXdR
pThzY0J4zXTKzXUyemL7X1vFYhehUHdL1UVArS6/ZgLOjj0kLqbsMCB/mDQY1vrE
huaTZt4xGtOzPNpxXqzaps1p9Z+XGZG/l1c7tlZtnIIdJCfKQHWnchTmtv9nf2cR
SEmTMJRCXHstqq5kK7LfUEWRqnOM/iKAUd0L/+TMvtXSarXdGKbaXjaDP41AlzoI
lwmCXCsqlVpBf1JFH48a9RIiEgJylMrxQAYAk8yRtjbzbVKLzBdZY64hgyWwJ4ed
7nqfp36b5pD6acZyibPskvwGnPzrCqjOsFqkjEiRT+3g5X7PG4ya+Q34F/LVE9yi
NmgeCmF/x+LAHFEEXh+0hLK7iFsSQPrqAE6K1K57W2syB2GwW4Mrp/clMDgRf4YL
s3iONXtgl2RxGRAF7m8G5cWOgKDCOjWSmfRFXv3sJLuPNszYGQKo+RPaOpuVbFx9
f1t+ClQ5/+qE4JohJ/QvmLt5gtKzg9ysTclyOs9ySd07Uyd93rZQgZkG1gQQy/pm
ImwvBgooN2yB6+brtzpWONCVKSKzPZ4fxQEQhZ4iU9+aF+dGKdo=
=kPxM
-----END PGP SIGNATURE-----
--=-=-=--

--===============0920542304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0920542304==--

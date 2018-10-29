From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 3/4] drm: Document variable refresh properties
Date: Mon, 29 Oct 2018 10:36:36 +0200
Message-ID: <20181029103636.5cc2798b@eldfell>
References: <20181011163942.28267-1-nicholas.kazlauskas@amd.com>
 <20181011163942.28267-4-nicholas.kazlauskas@amd.com>
 <20181026143719.01381cdd@eldfell>
 <bdda3a3b-c912-98bf-8dbd-29a5b58086df@amd.com>
 <20181026145321.GV9144@intel.com>
 <f21251f7-10e2-e0f7-702d-bd3868ac8edc@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1876256759=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f21251f7-10e2-e0f7-702d-bd3868ac8edc-5C7GfCeVMHo@public.gmane.org>
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
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: "daniel.vetter-/w4YWyX8dFk@public.gmane.org" <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--===============1876256759==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/02GLZp3RKsp=iUHInp20u77"; protocol="application/pgp-signature"

--Sig_/02GLZp3RKsp=iUHInp20u77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Oct 2018 17:34:15 +0000
"Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:

> On 10/26/18 10:53 AM, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Fri, Oct 26, 2018 at 02:49:31PM +0000, Kazlauskas, Nicholas wrote: =
=20
> >> On 10/26/18 7:37 AM, Pekka Paalanen wrote: =20

> >>> Hi,
> >>>
> >>> where is the documentation that explains how drivers must implement
> >>> "variable refresh rate adjustment"?
> >>>
> >>> What should and could userspace expect to get if it flicks this switc=
h?
> >>>
> >>> I also think the kernel documentation should include a description of
> >>> what VRR actually is and how it conceptually works as far as userspace
> >>> is concerned.
> >>>
> >>> That is, the kernel documentation should describe what this thing doe=
s,
> >>> so that we avoid every driver implementing a different thing. For
> >>> example, one driver could prevent the luminance flickering itself by
> >>> tuning the timings while another driver might not do that, which means
> >>> that an application tested on the former driver will look just fine
> >>> while it is unbearable to watch on the latter.
> >>>
> >>>
> >>> Thanks,
> >>> pq =20
> >>
> >> I felt it was best to leave this more on the vague side to not impose
> >> restrictions yet on what a driver must do.
> >>
> >> If you think it's worth defining what the "baseline" expectation is for
> >> userspace, I would probably describe it as "utilizing the monitor's
> >> variable refresh rate to reduce stuttering or tearing that can occur
> >> during flipping". This is currently what the amdgpu driver has enabled
> >> for support. The implementation also isn't much more complex than just
> >> passing the variable refresh range to the hardware.

Hi,

sorry, but that says nothing.

Also, tearing has nothing to do here. VRR reduces stuttering if
userspace is already tear-free. If userspace was driving the display in
a tearing fashion, VRR will not reduce or remove tearing, it just makes
it happen at different points and times. Tearing happens because
framebuffer flips are executed regardless of the refresh cycle, so
adjusting the refresh timings won't help.

However...

> >>
> >> I wouldn't want every driver to be forced to implement some sort of
> >> luminance flickering by default. It's not noticeable on many panels and
> >> any tuning would inherently add latency to the output. It would probab=
ly
> >> be better left as a new property or a driver specific feature.

The point is to give userspace guaranteed expectations. If the
expectation is that some displays might actually emit bad luminance
flickering, then userspace must always assume the worst and implement
the needed slewing algorithms to avoid it, even if it would be
unnecessary.

Userspace is farther away from the hardware than the drivers are, and
if userspace is required to implement luminance flickering avoidance,
that implementation must be done in all display servers and KMS apps
that might enable VRR. That would also call for a userspace hardware
database, so that people can set up quirks to enable/disable/adjust the
algorithms for specific hardware with the hopes that other users could
then have a good out-of-the-box experience. Instead, if possible, I
would like to see some guarantees from the kernel drivers that
userspace does not need to worry about luminance flickering.

Unless you would deem all hardware that can exhibit luminance
flickering as faulty and unsupported?

We need a baseline default expectation. You can modify that expectation
later with new properties, but I believe something needs to be defined
as the default. Even if the definition is really just "hardware takes
care of not flickering".

> >>
> >> In general I would imagine that most future VRR features would end up =
as
> >> new properties. Anything that's purely software could be implemented as
> >> a drm helper that every driver can use. I think the target presentation
> >> timestamp feature is a good example for that. =20
> >=20
> > Speaking of timestamps. What is the expected behaviour of vblank
> > timestamps when vrr is enabled?
> > =20
>=20
> When vrr is enabled the duration of the vertical front porch will be
> extended until flip or timeout occurs. The vblank timestamp will vary
> based on duration of the vertical front porch. The min/max duration for
> the front porch can be specified by the driver via the min/max range.

...This is actually useful information, it explains things. Do all VRR
hardware implementations fundamentally work like this?

With that definition, there is only more parameter to be exposed to
userspace in the future: what is the length of the timeout? No need to
expose maximum-refresh-freq because that information is already present
in the programmed video mode.

Btw. even this definition does not give any hint about problems like
the luminance flickering. If possible flickering is an issue that
cannot be simply ignored, then something should be documented about it.

Do you know of any other "hidden" issues that could require userspace
or drivers to be careful in how it will drive VRR?


Thanks,
pq

> No changes to vblank timestamping handling should be necessary to
> accommodate variable refresh rate.
>=20
> I think it's probably best to update the documentation for vrr_enable=20
> with some of the specifics I described above. That should help clarify=20
> userspace expectations as well.
>=20
> Nicholas Kazlauskas


--Sig_/02GLZp3RKsp=iUHInp20u77
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlvWxpQACgkQI1/ltBGq
qqdHwA//d+ExqSnjyij0XJ5LRp4fpAEq991MR6RxQCByzMACiXIGwfWWvbfkLFRi
cWrt3JbMeXD/ShXJRj2MqZHE+hmZ1+mgok2YMv+reRKNjEr9Q6JsUugLgraOuwKf
90RfAp5+hjehfHB2FwEcs/bjpDIevKdkQcFlu1K7ABeL+++PMXglxEBpoA6xmXRv
Cmp52aYOwkZng/FwoYOq3AHiGHsF4vjRamuhTQiXa6eKmKhcWqBn0AidGz3StTdE
n434OjQp60kmNE2ZoZM1ws4am21Awn1Ow+ALqqCzw6L9VrR7L60irH5+xg6Cvowd
7SD25X64qx5SPfDA+/LKAhjvXDbPA2z3EWouvzx82JCnQqJyhQBYMPSq3vTlwy9X
5+toebJrBmWkQLVMUSJZ3CTEIRi4KLT/Cc5Wb4V1O/8K8pK/jXQyVmYn7A2EXFPR
1Z+30OkLgqLWTrdKQLSN8VK+8NM13t92BnVlKP+grqXzOOyMm7200aEgZy4QFYSM
OSdXB1YJKxyJMR6XgcODg8X4/t5++TLm6Wf5cDiHORTmasvMNG+8b5j8DOwSEEAn
zJU/b9sulq90OiApALh1TqMMcUj8tzZ8AbtYMlBzPbOl+8Ok4uoobiCgOUnByxGP
dZ2p3E6chTmKYJn6nsnpWQ5i0R7nFt+UFwbs/c3Ois1ct6heoi4=
=1Oj+
-----END PGP SIGNATURE-----

--Sig_/02GLZp3RKsp=iUHInp20u77--

--===============1876256759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1876256759==--

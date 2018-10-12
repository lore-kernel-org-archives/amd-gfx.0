From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] drm: Add variable refresh property to DRM CRTC
Date: Fri, 12 Oct 2018 12:21:44 +0300
Message-ID: <20181012122144.595de059@eldfell>
References: <20180924181537.12092-1-nicholas.kazlauskas@amd.com>
 <20180924181537.12092-3-nicholas.kazlauskas@amd.com>
 <20180924183826.GX5565@intel.com>
 <4aa1583c-2be0-8cec-2857-6c3e489965b4@amd.com>
 <20180924202655.GA9144@intel.com>
 <bb8b3e03-94ce-3f0e-0947-ac0aaa4ff8a9@amd.com>
 <20181005111059.1cd71f95@eldfell>
 <fdc195dd-9650-8194-3a16-393f61bb2eee@amd.com>
 <20181010101448.400f4010@eldfell>
 <3bb5e05d-f7e6-8e44-cfae-202191d64245@amd.com>
 <20181012102310.32e0bac0@eldfell>
 <894d12d3-aa0b-c0f6-6347-7d13e58e651a@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0239018913=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <894d12d3-aa0b-c0f6-6347-7d13e58e651a-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Haehnle,
 Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--===============0239018913==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iRgxug/9f8beKWTeTtM29cr"; protocol="application/pgp-signature"

--Sig_/iRgxug/9f8beKWTeTtM29cr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Oct 2018 07:35:57 +0000
"Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org> wrote:

> Am 12.10.2018 um 09:23 schrieb Pekka Paalanen:
> > On Wed, 10 Oct 2018 09:35:50 -0400
> > "Kazlauskas, Nicholas" <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:
> > =20
> >> The patches I've put out target this use case mostly because of the
> >> benefit for a relatively simple interface. VRR can and has been used in
> >> more ways that this, however.
> >>
> >> An example usecase that differs from this would actually be video
> >> playback. The monitor's refresh rate likely doesn't align with the vid=
eo
> >> content rate. An API that exposes direct control over VRR (like the
> >> range, refresh duration, presentation timestamp) could allow the
> >> application to specify the content rate directly to deliver a smoother
> >> playback experience. For example, if you had a 24fps video and the VRR
> >> range was 40-60Hz you could target 48Hz via some API here. =20
> > The way that has been discussed to be implemented is that DRM page flips
> > would carry a target timestamp, which the driver will then meet as good
> > as it can. It is better to define an absolute target timestamp than a
> > frequency, because a timestamp can be used to synchronize with audio
> > and more. Mario Kleiner can tell you all about scientific use cases
> > that require accurate display timing, not just frequency. =20
>=20
> To summarize what information should be provided by the driver stack to=20
> make applications happy:
>=20
> 1. The minimum time a frame can be displayed, in other words the maximum=
=20
> frame rate.
> 2. The maximum time a frame can be displayed, in other words the minimum=
=20
> frame rate.
> 3. How much change of frame timing is allowed between frames to avoid=20
> luminescence flickering.
>=20
> Number 1 and 2 can also be used to signal the availability of VRR to=20
> applications, e.g. if they are identical we don't support VRR at all.

Hi Christian,

"the maximum time a frame can be displayed" is perhaps not an
unambiguous definition. A frame can be shown indefinitely in any case.
The CRTC will simply start scanning out the same frame again if there
is no new one. I understand what you want to say, but perhaps some
different words will be in order.

I do wonder if applications really want to know the maximum acceptable
slew rate in timings... maybe that should be left for the drivers to
apply. What I'm thinking is that we have the page flip timestamp with
the page flip events to tell when the new FB became active. That
information could be extended with a time range on when the very next
flip could take place. Applications are already computing that
prediction from the flip timestamp and fixed refresh rate, but it might
be nice to give them the driver's opinion explicitly. Maybe the
tolerable slew rate is not a constant.

Other than that, yes, it sounds fine to me.


Thanks,
pq

--Sig_/iRgxug/9f8beKWTeTtM29cr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlvAZ6gACgkQI1/ltBGq
qqdO3g//QG1J5biHeTgvl0PptpJ0MDXIUF+/YrNlgKtiT5V6rHZ/TRS3rXpnR3yU
BHuQE5grU5b5nsI+Y4kxEMsAOquSbdtACsMCdK+RvYeYh+7HKJ3Vd6WxZZeCmZQr
23kGlXf+EYoR6OlZDyOCcf0LoRCxwuEK6rj6Hrj99IQobUK0oI9E42jRSzYhSSc5
NmXNWbr6CSZ89L9dkswgZehaK0tSC4hNjYzyupU8CynYE5Ct0ImwEaJEQZpQgUc/
iTHgZYjzfzDb9e5QcSQuZ6wbW43cQ+Cuu6iIDP+U0pN70CDjkQtfofmkX53Z5HRL
Im7z6Vru/MSXKatmjv2zWsTxDtLUjveLMmgeOmpRI/TjamI4v/EmV+N0z3I/Mf6Y
2hlfWCaJlp5wnu6psPzuk1umQ86ZA3s3+J/NtqcSGrsbP6hVTSBf14GR+ADnikc9
Tpw7MlTNUHe8hU2uKh8I4m+FrShANsVuJ1elD65bVYpc+lJrNWfQyGmFpPIm49gn
Yf0zg3KeYtKehe1NPNBMi8NHksgtElvsyOFEljFnj++F5JUWVlzBeUblcw6AK0pN
MLA8pXQOKujcH6mp+QDQQv4SpOUV9ZBmiM1V9CKv5EsCBINGikRMvwFdURKll1NH
IfigMrE3UMuv8slG3PPaGC/gSugg1WsA7Zxjak2d6+2prxzz2Ug=
=gQug
-----END PGP SIGNATURE-----

--Sig_/iRgxug/9f8beKWTeTtM29cr--

--===============0239018913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0239018913==--

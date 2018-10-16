From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] drm: Add variable refresh property to DRM CRTC
Date: Tue, 16 Oct 2018 10:36:24 +0300
Message-ID: <20181016103624.7f68fd5f@eldfell>
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
 <20181012122144.595de059@eldfell>
 <00b8b89f-2675-dda5-7307-8a75b20390d7@amd.com>
 <c73340aa-a437-dc44-92b6-b3f104d0556e@amd.com>
 <20181015165733.66c668ba@eldfell>
 <52103366-510d-15a6-61d2-26196a4f0e57@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1863804374=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <52103366-510d-15a6-61d2-26196a4f0e57-5C7GfCeVMHo@public.gmane.org>
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
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Olsak,
 Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Ville =?UTF-8?B?U3ly?= =?UTF-8?B?asOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--===============1863804374==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hRk9JQzYW9Tq4Uy_6Zvugr5"; protocol="application/pgp-signature"

--Sig_/hRk9JQzYW9Tq4Uy_6Zvugr5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Oct 2018 12:02:14 -0400
"Kazlauskas, Nicholas" <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:

> On 10/15/2018 09:57 AM, Pekka Paalanen wrote:
> > On Fri, 12 Oct 2018 08:58:23 -0400
> > "Kazlauskas, Nicholas" <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:
> >  =20
> >> On 10/12/2018 07:20 AM, Koenig, Christian wrote: =20
> >>> Am 12.10.2018 um 11:21 schrieb Pekka Paalanen: =20
> >>>> On Fri, 12 Oct 2018 07:35:57 +0000
> >>>> "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org> wrote:
> >>>>    =20
> >>>>> Am 12.10.2018 um 09:23 schrieb Pekka Paalanen: =20
> >>>>>> On Wed, 10 Oct 2018 09:35:50 -0400
> >>>>>> "Kazlauskas, Nicholas" <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:
> >>>>>>        =20

> >> Flickering will really depend on the panel itself. A wider ranger is
> >> more likely to exhibit the issue, but factors like topology, pixel
> >> density and other display technology can affect this.
> >>
> >> It can be hard for a driver to guess at all of this. For many panels
> >> it'd be difficult to notice unless it's consistently jumping between t=
he
> >> min and max range. =20
> >=20
> > Do you mean that there is no way to know and get that information from
> > the monitor itself? Nothing in EDID that could even be used as a
> > default and quirk the monitors that got it wrong? =20
>=20
> The variable refresh range is exposed, but that's about it. There's=20
> certainly no simple algorithm you can feed monitor information into to=20
> determine how bad the luminance flickering is going to look to the user.
>=20
> >  =20
> >> Opening up an API that restricts how much the driver can change the
> >> refresh rate in a VRR scenario seems a bit extreme, but there's probab=
ly
> >> some applications that could benefit from this. I'd certainly want to
> >> see the actual use case first, though. This still feels more like a
> >> driver policy to me. =20
> >=20
> > I don't think anyone suggested that, certainly I did not. The driver
> > should get that information from the monitor hardware so that it can
> > drive it correctly. If the hardware driver doesn't know, then how could
> > the DRM core or userspace know any better? My whole premise was that the
> > driver knows. =20
>=20
> This was referring to the "How much change of frame timing is allowed=20
> between frames to avoid luminescence flickering" comment. I assumed that=
=20
> this implied restriction of the min/max VRR ranges from the driver.

Yes, exactly. The limits on the change of frame timings should be
enforced by the driver if the hardware does not do it already, so that
regardless of when userspace is scheduling flips, the monitor will
never flicker. IOW, even with on-demand rendering apps with totally
random frame timings, the kernel driver or the monitor hardware must
ensure the monitor will never luminance-flicker visibly.

Making good image quality (in this case not flickering) depend on
userspace doing something specific correctly without even a possibility
to know what "correct" is, is just silly in my opinion.

Too bad that ship sailed years ago, so we will need to have very
pessimistic kernel driver expectations on what slew rates are
acceptable. I do believe the kernel driver must enforce limits on slew
rate to prevent screen flickering if the hardware does not prevent it
already.

Besides, the kernel driver needs to know when to re-scan out the current
framebuffer in case userspace decides to take a pause, e.g. a temporary
stall in a game - compiling shaders or whatever. That should not result
in any flickering either, right? How will that be handled?

So, maybe it's not a bad idea to think of an UABI for changing the slew
rate limits. It is similar to color calibration: the defaults should be
ok to watch, but if one wants more correct color reproduction, one
needs to calibrate the monitor and load up color correction factors
through the driver. The luminance flickering should never be disturbing
by default, but maybe some people want to optimize further.

> >=20
> > Sounds like VRR hardware was designed not only for a consistent refresh
> > rate but also temporary glitches being ok.
> >=20
> > I suppose this will result in choosing a very pessimistic allowed slew
> > rate in the driver that covers 95% of VRR monitors and handle the rest
> > with quirks. That could still work.
> >  =20
> >> I agree with the nanosecond based timestamp API making the most logical
> >> sense here from an API perspective. This does overlap a little bit with
> >> the target vblank property that's already on the CRTC, perhaps. =20
> >=20
> > KMS UABI already has a target vblank property defined, or are you
> > talking about your CRTC hardware?
> >=20
> > Target vblank counter value makes even less sense with VRR than it ever
> > did with a fixed refresh rate. :-) > =20
> >> The target vblank could be determined based on the timestamp. The driv=
er
> >> is likely to exceed the target presentation timestamp by a fair bit if
> >> it was to just do this, however. VRR could be used in this case to get
> >> closer to the timestamp. A naive implementation could iterate over eve=
ry
> >> rate in the range and take the one with the minimum difference, for
> >> example. =20
> >=20
> > Could you elaborate on that, who could be doing what exactly to achieve
> > what?
>=20
> These comments were mostly discussing about how a kernel driver might=20
> approach a target presentation timestamp.
>=20
> A target presentation timestamp isn't related to VRR directly. Without=20
> VRR this could still be implemented by a kernel driver, but it would=20
> effectively be the client asking the driver to pick the right target=20
> vblank. There's already some support for this in DRM with the=20
> target_vblank CRTC property, but it isn't the easiest thing to use.
>=20
> The driver can do much better at getting closer to the client's target=20
> presentation timestamp by adjusting the refresh rate accordingly on a=20
> VRR capable monitor.

Right. An absolute timestamp should be easier to use than a target
vblank for userspace. On the kernel side it would avoid depending on
estimating vblank counts from a clock when vblank interrupts have been
opportunistically turned off, put to lower rate, or across modesets
that might mess up vblank counters. Also good for self-refreshing
panels, virtual outputs that get forwarded as video streams, etc.

We digress, though. Target timestamps or vblanks are not necessary for
the VRR feature, flip ASAP is what we have right now. The kernel driver
should adjust when ASAP is to avoid too high slew rate and luminance
flickering.


Thanks,
pq

--Sig_/hRk9JQzYW9Tq4Uy_6Zvugr5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlvFlPgACgkQI1/ltBGq
qqf3FQ//X3bMj92pvXVEYyTa++QHf7vciXK3I9gHROP/ph339n41Gfsg+IsAUuXs
YCSzUv4fpHUE0SbGs3mVPUAC9Qy9NFDKrtmvjRnmkMzLs2u0X2wVa8cBCF8T6Y5w
wCYE1c+LsUH5bt7kLLTtLrjuV9x/ao7lHnRjLNxfM5V86Zk4q4EHbuYNGe/F+Huq
XwHxPi5eymzjCx1qbHg8cJe6eVf8T8ghqzYqzLCyzFu3z0WgLTWglGWJNiayxWpm
6uYd0wm6TZdaWBMmhiWACF0Vy+hg/kW5w/ZzczMsMlVWrH8d83ml+bHvhViKz+u5
MolCGbw1EwUZKgXzy2tUrt6tNLDw/KbGNa8/bo3W5awb/3iQOyxjFM7HLWlBAQZb
hXqyZiPxMvJ2VFLtSBCultjfffXgpelUrd2bKMIiFi09YtMRdt1sgi9HAv7cFnb4
POeYx5gsMOxu5Rzkg1omG1i4FGIDig3CcsOt5EU1OCC+3PkFoiECkPXqfIK3wqNm
T6jHJBqAraUfwdvBRqmENsmh+2r7EmSS01uHreGV245HCuzLwpbMZPlEd3+jicq/
76by0gArQ97uCivurrjsGRk4c3CV7WBBGktlmm3SQA2qzWFdcoq17w6M71A6zlrt
5pcOGWXCapGz9AKJpQR3egp+aQqw3n/PNFM/pAzqXzFOW9IFxhY=
=vbDl
-----END PGP SIGNATURE-----

--Sig_/hRk9JQzYW9Tq4Uy_6Zvugr5--

--===============1863804374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1863804374==--

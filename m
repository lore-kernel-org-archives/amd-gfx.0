From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] drm: Add variable refresh property to DRM CRTC
Date: Wed, 10 Oct 2018 10:14:48 +0300
Message-ID: <20181010101448.400f4010@eldfell>
References: <20180924181537.12092-1-nicholas.kazlauskas@amd.com>
 <20180924181537.12092-3-nicholas.kazlauskas@amd.com>
 <20180924183826.GX5565@intel.com>
 <4aa1583c-2be0-8cec-2857-6c3e489965b4@amd.com>
 <20180924202655.GA9144@intel.com>
 <bb8b3e03-94ce-3f0e-0947-ac0aaa4ff8a9@amd.com>
 <20181005111059.1cd71f95@eldfell>
 <fdc195dd-9650-8194-3a16-393f61bb2eee@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0012851814=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fdc195dd-9650-8194-3a16-393f61bb2eee-5C7GfCeVMHo@public.gmane.org>
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
Cc: nicolai.haehnle-5C7GfCeVMHo@public.gmane.org, michel-otUistvHUpPR7s880joybQ@public.gmane.org, Marek.Olsak-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--===============0012851814==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7.zMeK05DyFEC0wS06k6a5m"; protocol="application/pgp-signature"

--Sig_/7.zMeK05DyFEC0wS06k6a5m
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Oct 2018 12:21:20 -0400
"Kazlauskas, Nicholas" <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:

> On 10/05/2018 04:10 AM, Pekka Paalanen wrote:
> > Hi,
> >=20
> > I have a somewhat of my own view on what would be involved with VRR,
> > and I'd like to hear what you think of it. Comments inline.
> >=20
> >=20
> > On Tue, 25 Sep 2018 09:51:37 -0400
> > "Kazlauskas, Nicholas" <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:
> >  =20
> >> On 09/24/2018 04:26 PM, Ville Syrj=C3=A4l=C3=A4 wrote: =20
> >>> On Mon, Sep 24, 2018 at 03:06:02PM -0400, Kazlauskas, Nicholas wrote:=
 =20
> >>>> On 09/24/2018 02:38 PM, Ville Syrj=C3=A4l=C3=A4 wrote: =20
> >>>>> On Mon, Sep 24, 2018 at 02:15:36PM -0400, Nicholas Kazlauskas wrote=
: =20
> >>>>>> Variable refresh rate algorithms have typically been enabled only
> >>>>>> when the display is covered by a single source of content.
> >>>>>>
> >>>>>> This patch introduces a new default CRTC property that helps
> >>>>>> hint to the driver when the CRTC composition is suitable for varia=
ble
> >>>>>> refresh rate algorithms. Userspace can set this property dynamical=
ly
> >>>>>> as the composition changes.
> >>>>>>
> >>>>>> Whether the variable refresh rate algorithms are active will still
> >>>>>> depend on the CRTC being suitable and the connector being capable
> >>>>>> and enabled by the user for variable refresh rate support.
> >>>>>>
> >>>>>> It is worth noting that while the property is atomic it isn't filt=
ered
> >>>>>> from legacy userspace queries. This allows for Xorg userspace driv=
ers
> >>>>>> to implement support in non-atomic setups.
> >>>>>>
> >>>>>> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> =
=20

...

> >> Whenever I mentioned variable refresh "features", what I really meant
> >> was operating in one of two modes:
> >>
> >> (1) Letting the driver and hardware adjust refresh automatically based
> >> on the flip rate on a CRTC from a single application
> >>
> >> (2) Setting a fixed frame duration based on the flip rate on a CRTC fr=
om
> >> a single application =20
> >=20
> > I wonder if that's too much magic in the kernel... what would be wrong
> > with simply flipping ASAP when VRR is active?
> >=20
> > How will userspace be able to predict coming flip opportunities if the
> > kernel does so much magic? =20
>=20
> The kernel driver doesn't need to do much more than let the hardware=20
> know the variable refresh range. The "magic" is performed by hardware.
>=20
> Most games would like to render as fast as possible to deliver a more=20
> responsive and smoother image to the user. Many of these are also=20
> resource intensive and won't always be able to render at the fixed=20
> refresh rate of the panel (especially for higher refresh rates like=20
> 144Hz). The user will experience stuttering if the game takes too long=20
> to render and misses the vblank window for the flip.
>=20
> Dynamic VRR adjustment can resolve this problem. The hardware can lower=20
> the refresh rate and increase the vblank window in response to this so=20
> the user doesn't experience stuttering (or latency).
>=20
> Userspace shouldn't predict anything.

...

> >>>> The reasoning for the split is because not all content is suitable f=
or
> >>>> variable refresh. Desktop environments, web browsers, etc only typic=
ally
> >>>> flip when needed - which will result in display flickering. =20
> >=20
> > Flickering? What do you mean? =20
>=20
> This is a property of how panels work.
>=20
> The luminance for a panel will vary based on how long the vrefresh is.=20
> Since the vrefresh length is changing as part of VRR you're more likely=20
> to notice the difference in luminance the bigger the difference is.
>=20
> The difference will be largest when switching from the min vrefresh to=20
> the max vrefresh duration.
>=20
> Large differences can occur for applications that render on demand like=20
> a web browser (and why you wouldn't want VRR enabled for those). The=20
> hardware would continuously wait for a flip that isn't coming. Then if=20
> the user moves their cursor or the page updates it's going to happen=20
> "randomly" in that window and the hardware will adjust to that.

Hi Nicholas,

it seems I have very much mis-guessed what VRR aims to achieve, and the
effect on luminance sounds horrible.

People have worked for years to make display timings more explicit,
giving better control and predictability over them. It sounds like VRR
is not an improvement that allows new smarter software to take control
of timings even better. Instead, VRR seems to be a step backwards,
introducing more uncertainty into the timings. The expectation of a
fixed unknown refresh rate must be built into software for the software
to work reasonably while VRR is active.

=46rom your comments I understood that the VRR hardware still very much
depends on a consistent refresh rate, except the hardware (not the
software!) can additionally slew the refresh rate over time. Abrupt
changes in frame timings must still be prevented, but I wasn't quite
sure if you meant the hardware will do that or if the software must do
that, since you are worried about on-demand updating applications
causing flickering.

Hence, VRR looks like a band-aid for old and simple applications that
use brute force (more fps, maximize the work load) in an attempt to
make things smoother and to reduce latency. There are lots of such
applications, so VRR has its place. It is my mistake of assuming it
could do more. Yes, I am disappointed to realize this.

I believe that future display servers and applications that actually
care about display timings will just opt out from VRR to gain better
predictability.

I also believe that you will need to blacklist applications like video
players whose developers have spent a great deal of effort in making a
smart scheduling algorithm for fixed rate display. I assume that a
smart sheduling algorithm that is based on prediciting the next display
time instant will interact poorly with VRR. A video player will need to
know if it is getting fixed rate or VRR to choose the appropriate
timing algorithm - wherther it needs to adapt to the display rate or
will the display rate adapt to it.

In summary, VRR is only good for exactly the use cases you listed, and
for other uses it can be harmful, just like you said.

Given the above, I think we are now very much on the same page about
what the KMS UABI should look like.


> Most compositors function well under this stack. It will vary
> depending on compositor support for window unredirection to let the
> window flip via the Present extension. Mutter handles this without
> any configuration and kwin can be configured to work with these
> patches. Compton can be configured to support unredirection as well.

You are thinking about the applications. What about the compositor
itself? Is the COW not hitting the Present direct scanout path,
triggering VRR, when what is actually showing is the desktop with
on-demand randomly updating windows?

> These (among others) are covered as part of the blacklist for the
> mesa patches. They do need to be explicitly excluded.

Right, you blacklist all compositing managers to prevent them from
regressing. That feels a bit ugly to me, needing exceptions to not
regress things, but maybe that's business as usual in Mesa?

Fortunately that problem with compositing managers won't exist with
Wayland.

In any case, there must also be a way for an application to explicitly
say if it supports VRR or not and to know if it gets VRR or not. Are
there no EGL or Vulkan extensions for that?


Thanks,
pq

--Sig_/7.zMeK05DyFEC0wS06k6a5m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlu9pugACgkQI1/ltBGq
qqcn5Q//TJfp11W+iwxjPJnn+Zftm+5sl0JqcOmJ6uN3EtHYjlHAVbuRXRwV2iky
R+mVbjXtuXHgWAJJWUG09uz/0XciyeNjOiGz6KM73ux0aEnsgkVIz+Vxt6Bjv6R1
iwmkoTN1gKmT2oafeMqYJ4+FxuhS5uRKgrsrQyhyQbJkhKTMQvi9q1u/gMwYqZnd
HHXbgmgRv8KhTjgMoa28JM2fsiBGTr8BsFGuBn6watG2TybcLMAgcmeqfPbPsGTu
bbV9BIJPqdR3anLVLtxJwwvROmZ6tYPOs4zA32109IoiGIwd3pUAG42wC0N3TApy
eLjZvfuggnoYXXvv5rNGlk+W3xKlHnp/VLNAZ3OeFhqy+73abycd4GtAvaZmUHvK
TRZdVXYFUjCT07puFJsSG4XnfEdGgUjLPO0CxRsIoyYxW7CiNLRKIoY/9E0jP7T5
thyUTKte0DHW/A4xj5frTemIqud5/p1i7bZn/gdDvNWmTFjmQsL4YXjQ5S6xHySk
yEsHjb+OXaVr6FFJW6D3LogG2/q+5J0cF0F/MYNNyh9FNhTDFoMW4meNtde5Ql2+
DDug/lA6ZcX+T3+zsbv/lJzq1SzGnGlUtX/oWlU1RiE2JhSBQ/HfaXigIRUf4NP3
dzgq8G42L1RGvo7UuE+549tL8oywZm3251qX2eqkhWP0XhSqY70=
=8M2P
-----END PGP SIGNATURE-----

--Sig_/7.zMeK05DyFEC0wS06k6a5m--

--===============0012851814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0012851814==--

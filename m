From: Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH v2 2/3] drm: Add variable refresh property to DRM CRTC
Date: Mon, 15 Oct 2018 16:57:33 +0300
Message-ID: <20181015165733.66c668ba@eldfell>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1168432051=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <c73340aa-a437-dc44-92b6-b3f104d0556e@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Cc: "Haehnle, Nicolai" <Nicolai.Haehnle@amd.com>, "michel@daenzer.net" <michel@daenzer.net>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "manasi.d.navare@intel.com" <manasi.d.navare@intel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============1168432051==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kihenBEltgluD.haH131/fL"; protocol="application/pgp-signature"

--Sig_/kihenBEltgluD.haH131/fL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Oct 2018 08:58:23 -0400
"Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com> wrote:

> On 10/12/2018 07:20 AM, Koenig, Christian wrote:
> > Am 12.10.2018 um 11:21 schrieb Pekka Paalanen: =20
> >> On Fri, 12 Oct 2018 07:35:57 +0000
> >> "Koenig, Christian" <Christian.Koenig@amd.com> wrote:
> >> =20
> >>> Am 12.10.2018 um 09:23 schrieb Pekka Paalanen: =20
> >>>> On Wed, 10 Oct 2018 09:35:50 -0400
> >>>> "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com> wrote:
> >>>>     =20
> >>>>> The patches I've put out target this use case mostly because of the
> >>>>> benefit for a relatively simple interface. VRR can and has been use=
d in
> >>>>> more ways that this, however.
> >>>>>
> >>>>> An example usecase that differs from this would actually be video
> >>>>> playback. The monitor's refresh rate likely doesn't align with the =
video
> >>>>> content rate. An API that exposes direct control over VRR (like the
> >>>>> range, refresh duration, presentation timestamp) could allow the
> >>>>> application to specify the content rate directly to deliver a smoot=
her
> >>>>> playback experience. For example, if you had a 24fps video and the =
VRR
> >>>>> range was 40-60Hz you could target 48Hz via some API here. =20
> >>>> The way that has been discussed to be implemented is that DRM page f=
lips
> >>>> would carry a target timestamp, which the driver will then meet as g=
ood
> >>>> as it can. It is better to define an absolute target timestamp than a
> >>>> frequency, because a timestamp can be used to synchronize with audio
> >>>> and more. Mario Kleiner can tell you all about scientific use cases
> >>>> that require accurate display timing, not just frequency. =20
> >>> To summarize what information should be provided by the driver stack =
to
> >>> make applications happy:
> >>>
> >>> 1. The minimum time a frame can be displayed, in other words the maxi=
mum
> >>> frame rate.
> >>> 2. The maximum time a frame can be displayed, in other words the mini=
mum
> >>> frame rate.
> >>> 3. How much change of frame timing is allowed between frames to avoid
> >>> luminescence flickering.
> >>>
> >>> Number 1 and 2 can also be used to signal the availability of VRR to
> >>> applications, e.g. if they are identical we don't support VRR at all.=
 =20
> >> Hi Christian,
> >>
> >> "the maximum time a frame can be displayed" is perhaps not an
> >> unambiguous definition. A frame can be shown indefinitely in any case.=
 =20
> >=20
> > Good point. Please also note that I'm not an expert on the display stuff
> > in general.
> >=20
> > My background comes more from implementing the VDPAU mediaplayer
> > interface in mesa.
> >=20
> > So just throwing some ideas in here from the point of view of an
> > userspace developer which wants to write a media player :)

Excellent!

> >> The CRTC will simply start scanning out the same frame again if there
> >> is no new one. I understand what you want to say, but perhaps some
> >> different words will be in order.
> >>
> >> I do wonder if applications really want to know the maximum acceptable
> >> slew rate in timings... maybe that should be left for the drivers to
> >> apply. What I'm thinking is that we have the page flip timestamp with
> >> the page flip events to tell when the new FB became active. That
> >> information could be extended with a time range on when the very next
> >> flip could take place. Applications are already computing that
> >> prediction from the flip timestamp and fixed refresh rate, but it might
> >> be nice to give them the driver's opinion explicitly. Maybe the
> >> tolerable slew rate is not a constant. =20
> >=20
> > Well it depends. I agree that the kernel should probably enforce the
> > slew rate to avoid flickering for the user.

That's what I was hoping if the monitor hardware does not do that
already, but now it sounds like it's not possible. Another failed
assumption from my side.

> > But it might be beneficial for the application to know things like this.

Applications should know when they could likely flip, my question is
how to tell them. Is the acceptable slew rate a constant for a video
mode, or does it depend on the previous refresh interval.

> >=20
> > What the application definitely needs to know is when a frame was
> > actually displayed. E.g. application says I want to display this at
> > point X and at some point later the kernel returns saying the frame was
> > displayed at point N where in the ideal case N=3DX.

You already get this timestamp with the DRM page flip events. We also
have Wayland and X11 extensions to get it to apps.

> >=20
> > Additional to that let's please use 64bit values and nanoseconds for
> > every value we use here, and NOT fps, line numbers or similar :)

Seconded!

I'd really favour absolute timestamps even.

> >=20
> > Regards,
> > Christian. =20
>=20
> Flickering will really depend on the panel itself. A wider ranger is
> more likely to exhibit the issue, but factors like topology, pixel
> density and other display technology can affect this.
>=20
> It can be hard for a driver to guess at all of this. For many panels
> it'd be difficult to notice unless it's consistently jumping between the
> min and max range.

Do you mean that there is no way to know and get that information from
the monitor itself? Nothing in EDID that could even be used as a
default and quirk the monitors that got it wrong?

> Opening up an API that restricts how much the driver can change the
> refresh rate in a VRR scenario seems a bit extreme, but there's probably
> some applications that could benefit from this. I'd certainly want to
> see the actual use case first, though. This still feels more like a
> driver policy to me.

I don't think anyone suggested that, certainly I did not. The driver
should get that information from the monitor hardware so that it can
drive it correctly. If the hardware driver doesn't know, then how could
the DRM core or userspace know any better? My whole premise was that the
driver knows.

Sounds like VRR hardware was designed not only for a consistent refresh
rate but also temporary glitches being ok.

I suppose this will result in choosing a very pessimistic allowed slew
rate in the driver that covers 95% of VRR monitors and handle the rest
with quirks. That could still work.

> I agree with the nanosecond based timestamp API making the most logical
> sense here from an API perspective. This does overlap a little bit with
> the target vblank property that's already on the CRTC, perhaps.

KMS UABI already has a target vblank property defined, or are you
talking about your CRTC hardware?

Target vblank counter value makes even less sense with VRR than it ever
did with a fixed refresh rate. :-)

> The target vblank could be determined based on the timestamp. The driver
> is likely to exceed the target presentation timestamp by a fair bit if
> it was to just do this, however. VRR could be used in this case to get
> closer to the timestamp. A naive implementation could iterate over every
> rate in the range and take the one with the minimum difference, for
> example.

Could you elaborate on that, who could be doing what exactly to achieve
what?


Thanks,
pq

--Sig_/kihenBEltgluD.haH131/fL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlvEnM0ACgkQI1/ltBGq
qqclzw//RoIaSAkyNBylzqUZ29ecQ1Kmz78jtIHC+R/v4SCzSm8oeQQiF9oYkb9P
4mBVddsctVYTn3KR3FpYfvcpz4BPcpNAxCgMzDrWCWhAvcmlCeUVApKVXNGxeTsI
Qry0xeu7POA7nOXy+9dOZKglTOToXPC7bDxg0K7VEGdjpj8jKaTO8BT20NKJNOOh
ZWrlM2KDs7e5a5ngJ6QPv+6ATB4d2OvufK2AB7Uzeh3hTtSIfrntij0IWSmpOGUM
IGGp1lUWRTQTPX+8Wjr7CLr+qeStDiuPNsA+8Wly4MGzE2rQtA1jtHUaQQypyesg
X2PaV3hGUh+Wo758XGNH20NlPjT0ZWvVABeb7NWltBVnSfdNDDxU+hrzeYCns1rq
dXivDqf9U5lUFoRF/+Y5WSUZC7NBt2Z+Jd4CkwDIvy76+R5gg6lO9UUgMWGPjAni
0xDTThm1TzeZvSU8ZJKbt9eHPpGJ+xEcFi6uF5ggr1bWALA8AU743PXKvKoZeEQj
CBhgkiu70E+RHA7NWR1TODO9bdcEbWT53G+Fjj0rfwrR8K1Qun1qdrq757vFC11L
TK78pw33/9eEFfqidWqsFyawrY1QxYnm+QWVKBJLnvPcN64cgvO3cg2W6L09yHv9
1X/OtDPkzT8OG8wcRZmU6O1zsVqqUsP80h/H8m8eC6c0t3CpNi4=
=0ZxA
-----END PGP SIGNATURE-----

--Sig_/kihenBEltgluD.haH131/fL--

--===============1168432051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1168432051==--

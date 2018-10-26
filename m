From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 2/4] drm: Add vrr_enabled property to drm CRTC
Date: Fri, 26 Oct 2018 17:27:31 +0300
Message-ID: <20181026172731.5776c301@eldfell>
References: <20181012164458.12864-1-nicholas.kazlauskas@amd.com>
 <20181012164458.12864-3-nicholas.kazlauskas@amd.com>
 <e1feafbe-2c37-d1ff-8a45-4672b4da1264@gmail.com>
 <9811fdab-3efe-4701-92e1-0f53b323959d@daenzer.net>
 <c9afd2f9-c80c-3147-6458-14e386196fb7@gmail.com>
 <ec5d531d-e91a-ba2f-7e8e-4a875b183e97@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0927057375=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ec5d531d-e91a-ba2f-7e8e-4a875b183e97-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?UTF-8?B?RMOkbnplcg==?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: daniel.vetter-/w4YWyX8dFk@public.gmane.org, Marek.Olsak-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>, manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

--===============0927057375==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZqBwT3c7kljA=+BM+LeTxWl"; protocol="application/pgp-signature"

--Sig_/ZqBwT3c7kljA=+BM+LeTxWl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Oct 2018 12:06:52 +0200
Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

> On 2018-10-15 11:47 a.m., Christian K=C3=B6nig wrote:
> > Am 15.10.2018 um 11:40 schrieb Michel D=C3=A4nzer: =20
> >> On 2018-10-13 7:38 p.m., Christian K=C3=B6nig wrote: =20
> >>> Am 12.10.2018 um 18:44 schrieb Nicholas Kazlauskas: =20
> >>>> This patch introduces the 'vrr_enabled' CRTC property to allow
> >>>> dynamic control over variable refresh rate support for a CRTC.
> >>>>
> >>>> This property should be treated like a content hint to the driver -
> >>>> if the hardware or driver is not capable of driving variable refresh
> >>>> timings then this is not considered an error.
> >>>>
> >>>> Capability for variable refresh rate support should be determined
> >>>> by querying the vrr_capable drm connector property.
> >>>>
> >>>> It is worth noting that while the property is intended for atomic use
> >>>> it isn't filtered from legacy userspace queries. This allows for Xorg
> >>>> userspace drivers to implement support. =20
> >>> I'm honestly still not convinced that a per CRTC property is actually
> >>> the right approach.
> >>>
> >>> What we should rather do instead is to implement a target timestamp f=
or
> >>> the page flip. =20
> >> You'd have to be more specific about how the latter could completely
> >> replace the former. I don't see how it could. =20
> >=20
> > Each flip request send by an application gets a timestamp when the flip
> > should be displayed.
> >=20
> > If I'm not completely mistaken we already have something like that in
> > both DRI2 as well as DRI3. =20
>=20
> Certainly not DRI2, but for now we're not enabling VRR with that anyway.
>=20
> While the X11 Present extension specifies PresentOptionUST for this,
> support for it isn't implemented yet in xserver (as in setting the
> option has no effect, the X server interprets the target value as an MSC
> anyway).
>=20
> So this couldn't work before the next major release of xserver, which
> based on recent history could be at least about one year away.

Hi

> In contrast, the CRTC property based solution for the gaming use-case
> can work even with older xserver versions.

This is probably the heaviest reason.

Coming up with a KMS UABI for target timestamps could get complicated.
Do you need a flip queue deeper than one? Do you need to be able to
cancel flips?

> > So as far as I can see we only need to add an extra flag that those
> > information are trust worth in the context of VRR as well.
> >=20
> > If we don't set this flag we always get the always working fallback
> > behavior, e.g. VRR is disabled and we have a fixed refresh rate.
> >=20
> > If we set this flag and the timestamp is in the past we get the VRR
> > behavior to display the next frame as soon as possible.
> >=20
> > If we set this flag and specific a specific timestamp then we get the
> > VRR behavior to display the frame as close as possible to the specified
> > timestamp. =20
>=20
> Apart from the above, another issue is that this would give direct
> control to the client on whether or not VRR should be used. But we want
> to allow the user to disable VRR even if a client wants to use it, via
> an RandR output property. This requires that the Xorg driver can control
> whether or not VRR can actually be used, via the CRTC property added by
> this patch.

It would not imply direct control to clients. The target timestamps go
through the X server, the X server can mangle them or remove them
before calling KMS any way it wants. The X server can invent a RandR
property to disable/enable VRR.

One would need a video-DDX update the very minimum to start passing the
timestamps to the kernel, so there is no way VRR would be enabled
unwanted.


Thanks,
pq

--Sig_/ZqBwT3c7kljA=+BM+LeTxWl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlvTJFMACgkQI1/ltBGq
qqdlgA/+N+ocxSbl1wfpQMpU6Z5XTYljzTCdc32tRDKdx7nnZxxYmTxoMpLXTK0r
T7F/7dTZqMzpPGQqztzrvfeU9kMKWYz3zKqM2Io4kQ2PvUPxd/4PKjR6CgBpG37e
n5Muys/9uauv5Ut8RB/b2aGHlwJYa1XBHLE8R+KXX+LmtVXZYpbmGndBkAF11Tep
Z+BHeoWVojyv3vzYj63xHTAZ+u5fEd/82Qxwqnz3MiD6Zbs9laAmN3fP00QL4I2f
pMom4C0Y34UbcxSA19i36rboASOV62NceZ9erJL0SOnhL1kv3Al2MeP7Xuua5R6M
MfbpbDdrkwu9/6T2fU833jTKd0uKEPzaPkaFFZE/c6rv8zedHUfEGXwJqdW3HBA2
lRXKvyD0EvO7eXkAjxlEluQo1dDAEtT7D60Go4Oad5JPeeESEO1elVwTAUekOFh7
Q8VOo4AvnXxiJfuQSe2KhpM22QNbuYocvSOTEN7H3YQ73A7b0eiJTWIsZ3UhgWBG
qj+ljhRBgL4VWUBe0QpqxZumnSzyp3wL5nnWf+AlhlWL071HGtIxlvWmeOsjiYOH
b+cM0+6GFN6LpXU7BYUkFsp9kRlhG2ks1T4ng/eFaPLgk0fhz5k/B15Es5XM9X34
ZdJuG2PJAMOpWs3sPopklyXvrrWCLAGoPbKpXUA04wADpjSNAOQ=
=pfjD
-----END PGP SIGNATURE-----

--Sig_/ZqBwT3c7kljA=+BM+LeTxWl--

--===============0927057375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0927057375==--

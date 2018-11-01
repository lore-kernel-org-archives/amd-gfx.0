From: Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH v4 3/4] drm: Document variable refresh properties
Date: Thu, 1 Nov 2018 10:37:23 +0200
Message-ID: <20181101103723.166ef50f@eldfell>
References: <20181011163942.28267-1-nicholas.kazlauskas@amd.com>
 <20181011163942.28267-4-nicholas.kazlauskas@amd.com>
 <20181026143719.01381cdd@eldfell>
 <bdda3a3b-c912-98bf-8dbd-29a5b58086df@amd.com>
 <20181026145321.GV9144@intel.com>
 <f21251f7-10e2-e0f7-702d-bd3868ac8edc@amd.com>
 <20181026175924.GH9144@intel.com>
 <481ae686-adda-5857-5538-2b0af2e25427@daenzer.net>
 <20181029180341.GN9144@intel.com>
 <13a934a2-5cea-3d1b-ec57-bf5488698129@daenzer.net>
 <1c1c0f6f-ccbd-bfc2-f249-a01f6fc997ec@amd.com>
 <311638a8-eb8a-cb8d-3f7a-109aaa4b046b@amd.com>
 <ff46c350-5729-d7e3-704d-9b7e52f61f28@daenzer.net>
 <31902d88-aa0c-a7de-a17b-6e5e6ec23f56@amd.com>
 <689846fa-7315-1fe4-77e5-4651bf6a21b5@daenzer.net>
 <87bcab42-e377-259c-13ea-0cfe9c675cf9@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1261145839=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <87bcab42-e377-259c-13ea-0cfe9c675cf9@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Cc: "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "manasi.d.navare@intel.com" <manasi.d.navare@intel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============1261145839==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TMgsYCcPI4oDIJOv0cqQaWI"; protocol="application/pgp-signature"

--Sig_/TMgsYCcPI4oDIJOv0cqQaWI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Oct 2018 17:54:34 +0000
"Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com> wrote:

> On 10/31/18 12:20 PM, Michel D=C3=A4nzer wrote:
> > On 2018-10-31 3:41 p.m., Kazlauskas, Nicholas wrote: =20
> >> On 10/31/18 10:12 AM, Michel D=C3=A4nzer wrote: =20
> >>> On 2018-10-31 2:38 p.m., Kazlauskas, Nicholas wrote: =20
> >>>> On 10/30/18 11:34 AM, Kazlauskas, Nicholas wrote: =20
> >>>>>
> >>>>> I understand the issue you're describing now. The timestamp is supp=
osed
> >>>>> to signify the end of the current vblank. The call to get scanout
> >>>>> position is supposed to return the number of lines until scanout (a
> >>>>> negative value) or the number of lines since the next scanout began=
 (a
> >>>>> positive value).
> >>>>>
> >>>>> The amdgpu driver calculates the number of lines based on a hardware
> >>>>> register status position which returns an increasing value from 0 t=
hat
> >>>>> indicates the current vpos/hpos for the display.
> >>>>>
> >>>>> For any vpos below vbl_start we know the value is correct since the=
 next
> >>>>> vblank hasn't begun yet. But for anythign about vbl_start it's prob=
ably
> >>>>> wrong since it applies a corrective offset based on the fixed value=
 of
> >>>>> crtc_vtotal. It's even worse when the value is above crtc_vtotal si=
nce
> >>>>> it'll be calculating the number of lines since the last scanout sin=
ce
> >>>>> it'll be a positive value.
> >>>>>
> >>>>> So the issue becomes determining when the vfront porch will end.
> >>>>>
> >>>>> When the flip address gets written the vfront porch will end at the
> >>>>> start of the next line leaving only the back porch plus part of the
> >>>>> line. But we don't know when the flip will occur, if at all. It has=
n't
> >>>>> occurred yet in this case.
> >>>>>
> >>>>> Waiting for the wrap around to 0 might be the best choice here since
> >>>>> there's no guarantee the flip will occur. =20
> >>>>
> >>>> I put some more thought into this and I don't think this is as bad a=
s I
> >>>> had originally thought.
> >>>>
> >>>> I think the vblank timestamp is supposed to be for the first active
> >>>> pixel of the next scanout. The usage of which is for clients to time
> >>>> their content/animation/etc.
> >>>>
> >>>> The client likely doesn't care when they issue their flip, just that
> >>>> their content is matched for that vblank timestamp. The fixed refresh
> >>>> model works really well for that kind of application.
> >>>>
> >>>> Utilizing variable refresh rate would be a mistake in that case since
> >>>> the client would then have to time based on when they flip which is a
> >>>> lot harder to "predict" precisely. =20
> >>>
> >>> It's only a "mistake" as long as the timestamps are misleading. :) As
> >>> discussed before, accurate presentation timestamps are one requirement
> >>> for achieving perfectly smooth animation. =20
> >>
> >> For most 3D games the game world/rendering can advance by an arbitrary
> >> timestep - and faster will be smoother, which is what the native mode
> >> would give you.
> >>
> >> For fixed interval content/animation where you can't do that variable
> >> refresh rate could vastly improve the output. But like discussed before
> >> that would need a way to specify the interval/presentation timestamp to
> >> control that front porch duration. The timestamp will be misleading in
> >> any other case. =20
> >=20
> > I don't agree that an accurate timestamp can ever be more "misleading"
> > than an inaccurate one. But yeah, accurate timestamps and time-based
> > presentation are two sides of the same coin which can buy the holy grail
> > of perfectly smooth animation. :)
> >=20
> >  =20
> >>>> I did some more investigation into when amdgpu gets the scanout posi=
tion
> >>>> and what values we get back out of it. The timestamp is updated shor=
tly
> >>>> after the crtc irq vblank which is typically within a few lines of
> >>>> vbl_start. This makes sense, since we can provide the prediction
> >>>> timestamp early. Waiting for the vblank to wrap around to 0 doesn't
> >>>> really make sense here since that would mean we already hit timeout =
or
> >>>> the flip occurred =20
> >>>
> >>> Sounds like you're mixing up the two cases of "actual" vblank events
> >>> (triggered by the "vblank" interrupt =3D> drm_(crtc_)handle_vblank) a=
nd
> >>> flip completion events (triggered by the PFLIP interrupt with our
> >>> hardware =3D> drm_crtc_send_vblank_event).
> >>>
> >>> Actual vblank events need to be delivered to userspace at the start of
> >>> vblank, so we indeed can't wait until the timestamp is accurate for
> >>> them. We just need to document the exact semantics of their timestamp
> >>> with VRR.
> >>>
> >>> For page flip completion events though, the timestamp needs to be
> >>> accurate and correspond to when the flipped frame starts being scanned
> >>> out, otherwise we'll surely break at least some userspace relying on
> >>> this information.
> >>> =20
> >> Yeah, I was. I guess what's sent is the estimated vblank timestamp
> >> calculated at the start of the interrupt. =20
> >=20
> > s/interrupt/vblank/, yeah.
> >=20
> >  =20
> >> And since that's just a guess rather than what's actually going to
> >> happen it's going to be wrong in a lot of cases.
> >>
> >> I could see the wrap-around method working if the vblank timestamp was
> >> somehow updated in amdgpu or in drm_crtc_send_vblank_event. =20
> >=20
> > DC already calls drm_crtc_accurate_vblank_count before
> > drm_crtc_send_vblank_event, we "just" need to make sure that results in
> > an accurate timestamp.
> >=20
> >  =20
> >> This would be a relatively simple fix but would break anything in
> >> userspace that relied on the timestamp for vblank interrupt and the
> >> flip completion being the same value. =20
> >=20
> > Hmm, that's a good point. So while VRR is enabled, maybe it is safer to
> > defer delivery of vblank events until the accurate timestamp is known as
> > well, at least by default. If there is userspace which needs the events
> > earlier even with VRR but can live with the guessed timestamp, a flag or
> > something could be added for that.
> >=20
> >  =20
>=20
> I was under the impression that the vblank timestamp was reused but it's=
=20
> already going to differ since we call drm_crtc_accurate_vblank_count=20
> before drm_crtc_send_vblank_event. Thanks for pointing that out.
>=20
> Since that works for updating timestamp what's left is making sure that=20
> it waits for the wrap around if it's above crtc_vtotal. It might make=20
> sense to add a new flag for this that's only used within=20
> amdgpu_get_crtc_scanout_position so the other call sites aren't affected.
>=20
> There isn't a way to get an accurate timestamp with VRR enabled until=20
> after the flip happens. So deferring it kind of defeats the purpose of a=
=20
> client using it to make predictions before the flip for displaying their=
=20
> content.

Hi,

I don't think I understood half of the discussion above, but I'd like
to offer how Weston uses vblank timestamps and pageflip timestamps
today.

When Weston starts rendering "from idle", which means it has lost track
of the past flip timestamps since it has not been flipping, it uses
drmWaitVBlank() to query the latest flip time non-blocking:

	drmVBlank vbl =3D {
		.request.type =3D DRM_VBLANK_RELATIVE,
		.request.sequence =3D 0,
		.request.signal =3D 0,
	};

If that returns a valid answer, it is taken as the base timestamp. (If
it doesn't result in a valid timestamp, Weston makes a flip to the
current FB and uses the realized pageflip timestamp of that as the base
timestamp.)  The base timestamp is used to predict the next possible
flip time by adding one refresh period to it.

This obviously depends heavily on fixed refresh rate. However, if
userspace can know the VRR flip timeout length, I think it should be
possible to compute the next possible flip window being between:
base timestamp + minimum refresh period + { 0, timeout }.

Of course, the prediction of the next possible flip window is only an
estimate, so some inaccuracy is allowed. We still rely on the
after-the-fact feedback in the form of pageflip timestamps to be
accurate, so that we can potentially adjust the userspace timings to
eventually hit what we predict.

Implementing support for flip target timestamps would be merely an
addition to all the above, that should improve the sub-refresh-period
timing accuracy even further. But, to compute target timestamps,
userspace would still need to predict the flip window to avoid being
half a refresh period or more off on average.

Therefore, if at all possible, I would like you to set the vblank and
pageflip timestamp semantics such that this prediction is not
fundamentally broken.


Thanks,
pq

--Sig_/TMgsYCcPI4oDIJOv0cqQaWI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlvau0MACgkQI1/ltBGq
qqfhXQ//UfAfpxxFlHjVh97RSWlRYM8naI29mwyiAOLojVJraf1rhJXCHrDmyU6P
wqu6zMsnLbCibb3/iK5V1G+DgVS72uDLlict1Cw2hPSvmXTDAPt/XXMtfgub4MVX
9lVKbV5/Zd5aCPFrWZ8P+xf4e7hGAlFUMCy1xW980KEgKeTLCWC4GTMtKGi/iKC8
jRK35UQceU5JsUpLx9wfJYZNIpox2+sGpQg8v5LvQ9Je8WKLb8tOg/oRKZ6VbiB+
nmojg1ggm1HS++2FIQRRnPcIzcCeKvNagUkLVcfH9NoWiZcz2SGDefKcAYAMwV8h
Y+gk1nLXOi2j7fSdiODzN1sQ3RdDzcHTHMpZT7zMCsnFKa73EDDpY565KoKdpsls
To5vZ5SgOwY7Ha3u+QQyN9TPUarSZSJDjbY1jrLkFXB0u8VH9ljQo5gLzVQTTp1P
oc8CVxgjKUWvPmoGS5pfD/rUpXnqKaBH2P2k8PAyi0X9rFmGHDalk51RrTkY9Lo3
G/6tgHOY4VycGt2nBau5ZKPVSRHtTuKboUqaKD92dE4Rg6ZUJ87N6Z/cNHhrK9rO
EbHNF6b/6c/XZO+dOMNG4R13zPwqOJiqz6iNBRKGNmZHQmGZ1SdXQ6yilH2O+I0S
+0Bgbrt7BZZsHF5qSHT9V7qdYbYPK8VT7YEqa0RyXXjBYofcVPk=
=3PQ9
-----END PGP SIGNATURE-----

--Sig_/TMgsYCcPI4oDIJOv0cqQaWI--

--===============1261145839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1261145839==--

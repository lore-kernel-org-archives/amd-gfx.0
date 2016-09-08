From: Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH 6/6] drm: Add
 DRM_MODE_PAGE_FLIP_TARGET_ABSOLUTE/RELATIVE flags v2
Date: Thu, 8 Sep 2016 12:36:31 +0300
Message-ID: <20160908123631.721dcab0@eldfell>
References: <1470281981-18172-7-git-send-email-michel@daenzer.net>
 <1470641019-3067-1-git-send-email-michel@daenzer.net>
 <8974b919-6f9c-5912-0d26-f1a526829f83@gmail.com>
 <8e3f5a2b-0de8-7b0a-b64b-ec298955fe75@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1474525916=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <8e3f5a2b-0de8-7b0a-b64b-ec298955fe75@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>
Cc: daniel.stone@collabora.com, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, "wayland-devel@lists.freedesktop.org" <wayland-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

--===============1474525916==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/g401TpbhX2Cvp2.lMOcPjyG"; protocol="application/pgp-signature"

--Sig_/g401TpbhX2Cvp2.lMOcPjyG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Aug 2016 10:46:13 +0900
Michel D=C3=A4nzer <michel@daenzer.net> wrote:

> On 16/08/16 10:32 AM, Mario Kleiner wrote:
> > Cc'ing Daniel Stone and Pekka Paalanen, because this relates to wayland.
> >=20
> > Wrt. having a new pageflip parameter struct, i wonder if it wouldn't
> > make sense to then already prepare some space in it for specifying an
> > absolute target time, e.g., in u64 microseconds? Or make this part of
> > the atomic pageflip framework? =20
>=20
> I feel like this is too much hassle for the DRM_IOCTL_MODE_PAGE_FLIP
> ioctl, probably makes sense to only deal with this in the atomic API.
>=20
>=20
> > In Wayland we now have the presentation_feedback extension (maybe it got
> > a new name?), which is great to get feedback when and how presentation
> > was completed, essentially the equivalent of X11's GLX_INTEL_swap_events
> > + some useful extra info / the feedback half of OML_sync_control.
> >=20
> > That was supposed to be complemented by a presentation_queue extension
> > which would provide the other half of OML_sync_control, the part where
> > an app can tell the compositor when and how to present surface updates.
> > I remember that a year ago inclusion of that extension was blocked on
> > some other more urgent important blocker bugs? Did this make progress?

Hi,

sorry, I'm pretty poor at following dri-devel@.

Yeah, the Wayland extension for queueing frames to be presented at
specific times has not been going anywhere for a long time. IIRC the
blockers have since been resolved, now it would need dusting off and
seeing how it interacts with those protocol additions. I wasn't too
happy with the design at the time, either, because of the question of
which state to queue and which not.

Nowadays presentation_feedback lives in
https://cgit.freedesktop.org/wayland/wayland-protocols/tree/stable/presenta=
tion-time
and has been declared stable.

> > For timing sensitive applications such an extension is even more
> > important in a wayland world than under X11. On X11 most desktops allow
> > unredirecting fullscreen windows, so an app can drive the flip timing
> > rather direct. At least on Weston as i remember it from my last tests a
> > year ago, that wasn't possible, and an app that doesn't want to present
> > at each video refresh, but at specific target times had to guess what
> > the specific compositors scheduling strategy might be and then "play
> > games" wrt. to timing surface commit's to trick the compositor into sort
> > of doing the right thing - very fragile.
> >=20
> > Anyway, the idea of presentation_queue was to specify the requested time
> > of presentation as actual time, not as a target vblank count. This
> > because applications that care about precise presentation timing, like
> > my kind of neuroscience/medical visual stimulation software, or also
> > video players, or e.g., at least the VDPAU video presentation api
> > "think" in absolute time, not in refresh cycles. Also a target vblank
> > count for presentation is less meaningful than a target time for things
> > like variable framerate displays/adaptive sync, or displays which don't
> > have a classic refresh cycle at all. It might also be useful if one
> > thinks about something like VR compositors, where precise timing control
> > could help for some of the tricks ("time warping" iirc?) they use to
> > hide/cope with latency from head tracking -> display.
> >=20
> > It would be nice if the kernel could help compositors which would
> > implement presentation_queue or similar to be robust/precise in face of
> > future stuff like Freesync, or of added delays due to Optimus/Prime
> > hybrid-graphics setups. If we wanted to synchronize presentation of
> > multiple displays in a Freesync type display setup, absolute target
> > times could also be helpful. =20
>=20
> I agree with all of this though.

I'm very happy to hear the idea has support!


Thanks,
pq


> I'd like to add that the X11 Present extension specification already
> includes support for specifying a target time instead of a target
> refresh cycle. This isn't implemented yet though, but it should be
> relatively straightforward to implement using the kind of kernel API you
> describe.

--Sig_/g401TpbhX2Cvp2.lMOcPjyG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBV9ExJiNf5bQRqqqnAQhvtA/+KXdqQoQs9l2CjL4gbfmoCkw0T5t9jJ2k
mDar9ysnVseLUHimOb6/R4wtO9bSesnSTWlNWOjSNUz0bA9En3aCRvfztr+eQLPS
XSumyQqwPThg9XQlDLSJlvLqz3od9yFpMUd8uHDBOKBAKpja/Ue2F8t6g7lDtBD9
Vh2yY1/9WkdMfwzLvyLbQ9ndYpAvoR3UTMV2dmPa9v+d8zO9X6Zt0C0JcYF7cnaI
JHvCPG0Xjs7CO+RIz0HUKzAEWnSa8AXKWNxqUqC5bcPZAqPCbFLyXMb/rqyPmZ5U
kDwi867Siqxk+ConGOruuO6XukR42mPqo9LAA7i0XUpPLC9GiJLX90vE2/dWwWOg
AWZQbV/tIlENBX9As6l3kTRUGIw0h1pFvoQMap9sKSZV77K8T5uzWeeAG9/xJ26r
9Ajts+bb7g11d0hiHsC+FYUhnwYJpK3U9twSGWPlkrOXTkbgwmhuyhW+UzakRFKx
r9Z81/NtvuQX5eXx7zc1TLg23+KJbiyBsCbTE1A8M4ECglpNa//FOgTjX1erhvru
XzmcBFTWewbwYAT0sgItbtfWRGliYzp9hhZYiqVwgP7DmgBG8jhDMthZlnP6tER0
hLfUNLR0y7DygQJ1VM9RfHs/yVp4HBeWSDdqU8wSM2rGGJZqazZ5PIyPQduPTlxn
kTZkzGPoP4o=
=W97q
-----END PGP SIGNATURE-----

--Sig_/g401TpbhX2Cvp2.lMOcPjyG--

--===============1474525916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1474525916==--

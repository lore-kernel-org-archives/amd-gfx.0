From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] drm: Add variable refresh property to DRM CRTC
Date: Fri, 12 Oct 2018 10:23:10 +0300
Message-ID: <20181012102310.32e0bac0@eldfell>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0785377081=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3bb5e05d-f7e6-8e44-cfae-202191d64245-5C7GfCeVMHo@public.gmane.org>
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

--===============0785377081==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+SXQ3lk5ppfFZ9ovvQOCNBZ"; protocol="application/pgp-signature"

--Sig_/+SXQ3lk5ppfFZ9ovvQOCNBZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Oct 2018 09:35:50 -0400
"Kazlauskas, Nicholas" <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:

> The patches I've put out target this use case mostly because of the=20
> benefit for a relatively simple interface. VRR can and has been used in=20
> more ways that this, however.
>=20
> An example usecase that differs from this would actually be video=20
> playback. The monitor's refresh rate likely doesn't align with the video=
=20
> content rate. An API that exposes direct control over VRR (like the=20
> range, refresh duration, presentation timestamp) could allow the=20
> application to specify the content rate directly to deliver a smoother=20
> playback experience. For example, if you had a 24fps video and the VRR=20
> range was 40-60Hz you could target 48Hz via some API here.

The way that has been discussed to be implemented is that DRM page flips
would carry a target timestamp, which the driver will then meet as good
as it can. It is better to define an absolute target timestamp than a
frequency, because a timestamp can be used to synchronize with audio
and more. Mario Kleiner can tell you all about scientific use cases
that require accurate display timing, not just frequency.

A timestamp will naturally lend itself to arbitrary on-demand screen
updates as well.

However, userspace still needs to know if the target timestamp it is
contemplating on could realistically be met, so that e.g. a video
player can choose between showing video frames as is vs. needing to
interpolate for the presentation times it actually can achieve.

I suppose we agree on the above.

Btw. would a video player even need explicit controls if it knows the
display will adapt to the player's refresh rate? It could just use the
original video rate and from what I understood, the display will soon
end up refreshing at exactly that rate. The player can still use the
realized page flip timestamps to synchronize with audio, since it can
assume the refresh rate is stable and can predict the next few flips.
But, this would only work if the video player knows that VRR will adapt
to its rate.

While we are talking about predictability of page flips, Weston is
already relying on a prediction to reduce the desktop latency to
screen. However, it should be possible to modify Weston to implement
the kind of VRR support for fullscreen exclusive windows like you are
proposing just fine.

Just like the X11 window property you mentioned for marking windows as
eligible for VRR in Xorg, Wayland will need a similar protocol
extension.

I'm happy to see work being done for VRR.


Thanks,
pq

--Sig_/+SXQ3lk5ppfFZ9ovvQOCNBZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlvAS94ACgkQI1/ltBGq
qqeHfxAAoi6gdoPpklsbZfpsiSJfQoEA8M4YegA4Vp1XqmuGPM6KRh6aThxxrave
dEGpocGlQ5GCs8yZWvC66x/Vs5DBStk5t9BrtafevsdUPq8ql+fvL6DcJW3IdcSW
CC3GrVijtBE4IXojlx8UpYVDsde6o770yZC8iJA/IY0yrpMM7xqObcC4Q98g7tyo
bmhpuyk1mrbJiARFDY+s9T92nUtLIXWML7X/Z/V6r3kHO6ibpvG8d3v6ZzjOSHBG
T9Wg91Nj45oubv/CgIbJuLjP5hSUceejm531sDK9cyMX6O9lEwu1L1fOV+TeCvck
OKRAsnwJSflEFFAgLczDtH1rgrLVz17B0rrybg9dLSuSmU3jraF+9fn0C6qHsNfD
Dxb1OuxvitUSu0BHbSZ9dz3lPsvKvawn1VGprUmhRsQMwTqXFt50iIrWk+plOgo6
g9D2Tiw1ARVr76+Fdmad233R0BIJC3LN7fsdFTa4+t+c+vwZDOG/ITER9iP7vI8T
nxaMNmh/SuJpn2c6i6iG7ibhMe5UiBpnjOku//XAJd1Q9Mw9PZ+h5KrkoHjiR3xE
kiYcrjmWJA21qbyy5Hmq8WCAsEkm+tlW+ZLez2LSBT3ct7Wk3x+oEKaAuOr97GpE
hLFp19DU4ocCZXhO0nOytmLzC5nfMn6Oc9MF/Lmyztpz4nPly6o=
=voC5
-----END PGP SIGNATURE-----

--Sig_/+SXQ3lk5ppfFZ9ovvQOCNBZ--

--===============0785377081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0785377081==--

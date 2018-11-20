From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 3/5] drm: Document variable refresh properties
Date: Tue, 20 Nov 2018 17:05:41 +0200
Message-ID: <20181120170541.74de7b8b@eldfell>
References: <20181106202435.23556-1-nicholas.kazlauskas@amd.com>
 <20181106202435.23556-4-nicholas.kazlauskas@amd.com>
 <0cb3b0c9-b3a6-1c79-341a-6b7ebc9da29a@amd.com>
 <a48c02c9-0e35-a9ca-08ea-99df83014d3f@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0959979787=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a48c02c9-0e35-a9ca-08ea-99df83014d3f-5C7GfCeVMHo@public.gmane.org>
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
Cc: "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--===============0959979787==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/b5Ne54uAURg_3F7f2YUjh7U"; protocol="application/pgp-signature"

--Sig_/b5Ne54uAURg_3F7f2YUjh7U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Nov 2018 15:10:31 +0000
"Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:

> On 11/7/18 9:57 AM, Wentland, Harry wrote:
> >=20
> >=20
> > On 2018-11-06 3:24 p.m., Nicholas Kazlauskas wrote: =20
> >> These include the drm_connector 'vrr_capable' and the drm_crtc
> >> 'vrr_enabled' properties.
> >>
> >> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
> >> Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> >> Cc: Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >> Cc: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >> Cc: Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
> >> ---
> >>   Documentation/gpu/drm-kms.rst   |  7 ++++
> >>   drivers/gpu/drm/drm_connector.c | 61 +++++++++++++++++++++++++++++++=
++
> >>   2 files changed, 68 insertions(+)
> >>
> >> diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms=
.rst
> >> index 4b1501b4835b..8da2a178cf85 100644
> >> --- a/Documentation/gpu/drm-kms.rst
> >> +++ b/Documentation/gpu/drm-kms.rst
> >> @@ -575,6 +575,13 @@ Explicit Fencing Properties
> >>   .. kernel-doc:: drivers/gpu/drm/drm_atomic_uapi.c
> >>      :doc: explicit fencing properties
> >>  =20
> >> +
> >> +Variable Refresh Properties
> >> +---------------------------
> >> +
> >> +.. kernel-doc:: drivers/gpu/drm/drm_connector.c
> >> +   :doc: Variable refresh properties
> >> +
> >>   Existing KMS Properties
> >>   -----------------------
> >>  =20
> >> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_con=
nector.c
> >> index 49290060ab7b..a6adf5450db3 100644
> >> --- a/drivers/gpu/drm/drm_connector.c
> >> +++ b/drivers/gpu/drm/drm_connector.c
> >> @@ -1255,6 +1255,67 @@ int drm_mode_create_scaling_mode_property(struc=
t drm_device *dev)
> >>   }
> >>   EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
> >>  =20
> >> +/**
> >> + * DOC: Variable refresh properties
> >> + *
> >> + * Variable refresh rate capable displays can dynamically adjust their
> >> + * refresh rate by extending the duration of their vertical porch unt=
il =20
> >=20
> > vertical porch -> vertical front porch
> >  =20
> >> + * page flip or timeout occurs. This can reduce or remove stuttering
> >> + * and latency in scenarios where the page flip does not align with t=
he
> >> + * vblank interval.
> >> + *
> >> + * An example scenario would be an application flipping at a constant=
 rate
> >> + * of 48Hz on a 60Hz display. The page flip will frequently miss the =
vblank
> >> + * interval and the same contents will be displayed twice. This can be
> >> + * observed as stuttering for content with motion.
> >> + *
> >> + * If variable refresh rate was active on a display that supported a
> >> + * variable refresh range from 35Hz to 60Hz no stuttering would be ob=
servable
> >> + * for the example scenario. The minimum supported variable refresh r=
ate of
> >> + * 35Hz is below the page flip frequency and the vertical front porch=
 can
> >> + * be extended until the page flip occurs. The vblank interval will be
> >> + * directly aligned to the page flip rate.
> >> + *
> >> + * Userspace control for variable refresh rate is supported via prope=
rties
> >> + * on the &drm_connector and &drm_crtc objects.
> >> + *
> >> + * "vrr_capable":
> >> + *	Optional &drm_connector boolean property that drivers should attach
> >> + *	with drm_connector_attach_vrr_capable_property() on connectors that
> >> + *	could support variable refresh rates. Drivers should update the
> >> + *	property value by calling drm_connector_set_vrr_capable_property().
> >> + *
> >> + *	Absence of the property should indicate absence of support.
> >> + *
> >> + * "vrr_enabled":
> >> + *	Default &drm_crtc boolean property that notifies the driver that t=
he
> >> + *	content on the CRTC is suitable for variable refresh rate presenta=
tion.
> >> + *	The driver will take this property as a hint to enable variable
> >> + *	refresh rate support if the receiver supports it, ie. if the
> >> + *	"vrr_capable" property is true on the &drm_connector object. The
> >> + *	veritcal front porch duration will be extended until page-flip or =
=20
> >=20
> > veritcal -> vertical
> >  =20
> >> + *	timeout when enabled.
> >> + *
> >> + *	The minimum vertical front porch duration is defined as the vertic=
al
> >> + *	front porch duration for the current mode.
> >> + *
> >> + *	The maximum vertical front porch duration is greater than or equal=
 to
> >> + *	the minimum vertical front porch duration. The duration is derived
> >> + *	from the minimum supported variable refresh rate for the connector.
> >> + *
> >> + *	The driver may place further restrictions within these minimum
> >> + *	and maximum bounds.
> >> + *
> >> + *	Some displays may exhibit noticeable differences in brightness when
> >> + *	varying vertical front porch duration.
> >> + * =20
> >=20
> > Maybe something like this makes sense here:
> >=20
> >   *	Some displays may exhibit noticeable differences in brightness when
> >   *	varying vertical front porch duration drastically. It is therefore
> >   *	advised userspace only provide the "vrr_enabled" hint for content
> >   *	with a render rate that is expected to change gradually frame to fr=
ame,
> >   *	such as games. =20
>=20
> Good point about mentioning that userspace shouldn't expect this to work=
=20
> well with frequent (and large) changes in vertical front porch duration.
>=20
> I should probably more clearly word that the panel brightness may differ=
=20
> based on the vertical front porch duration. So large changes will be=20
> more noticeable.
>=20
> >  =20
> >> + *	The semantics for the vertical blank timestamp differ when
> >> + *	variable refresh rate is active. The vertical blank timestamp
> >> + *	is defined to be an estimate using the current mode's fixed
> >> + *	refresh rate timings. The semantics for the page-flip event
> >> + *	timestamp remain the same.
> >> + */
> >> +
> >>   /**
> >>    * drm_connector_attach_vrr_capable_property - creates the
> >>    * vrr_capable property
> >> =20
>=20
> Thanks for the review, I'll fix up these for the next revision.

Hi Nicholas,

I am happy with this documentation.

- It explains exactly what VRR does: VRR allows extending the front
  porch from the video mode defined length to some maximum length.

- It guarantees that a flip is performed ASAP: when the buffer becomes
  ready (fences) and when the driver agrees on the first possible time
  to flip.

- The point about drivers also allows for drivers to prevent the
  luminance flickering by enforcing a maximum slew rate on the timings,
  should anyone want to implement that.

- The timestamps for vblank and pageflip events.

Acked-by: Pekka Paalanen <pekka.paalanen-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>

Btw. I don't think I yet understood the underlying mechanism on how a
monitor could exhibit luminance changes due to VRR. Do you know, can
you point me to some analysis on what happens? Are the liquid crystals
slowly turning on their own without a refresh cycle, or?


Thanks,
pq

--Sig_/b5Ne54uAURg_3F7f2YUjh7U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlv0IsUACgkQI1/ltBGq
qqfrQA/+MvPCMr8HTYmpOUG55mBNiYutWbBHEcINTtK7e0w8T/7TRR34UQCh4XiX
dh/MMGlC4QnPZ+WCy65NIpINHSv+Tb/cFuOvLjeQADlaf/WUqjs+sshh59BL3bUN
pzdCEf0urP8NwJeM3mJalzwqzrXTflcULIQAH4oNdPQp+n/6IGgDCOkKLy6jSxYn
d9cMvPutlcJEeQiWG62JpspjBgZ6dOIVwanSMf+VTYyGEMoz9YBv6EroC+vqNP4H
/l7TrO4HeQDc1+2anYB0xDzRaDAuur2FGh5B+dzqBGKoJLx2brnoLs+SN/y1BMxH
oUgojCWAfCO3bV55qj9YW/9w/vHdpkSh2yRWs69ffsnZ5E7MJZ1ws0W085JmvIC/
XjlzWaMORcvGdnePCEx8dj/cXge1DdDoqozF+ICBskIje7UweL7Pt0E+n/KGwos7
eTQFmHGXJyIissrhSmnzfAz0turiNOy+KmPqTGpsOCwY10+nQaELmSsAI2btF9kd
ZbIUn0w14jaL1UKEvyg6ZwD5Gi0czYf4UoKy+W+5Oz3tLGdUrwjI22cVVOSjFJP5
bRWZvLzGB0AjT7LXiaXGJrufdQOjlsEYHBgV+ewVFUOOE7eLAMriyyENbp0VbsPG
3OXSqLdd9WxKifMCmru5L1dl6V7EymufgeKBUKbPH2DeuEIFmvI=
=cYpK
-----END PGP SIGNATURE-----

--Sig_/b5Ne54uAURg_3F7f2YUjh7U--

--===============0959979787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0959979787==--

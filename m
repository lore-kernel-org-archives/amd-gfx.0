From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v2 2/4] drm/vc4: Take underscan setup into account when
 updating planes
Date: Fri, 11 May 2018 13:11:24 -0700
Message-ID: <87mux6q7f7.fsf@anholt.net>
References: <20180511145919.22447-1-boris.brezillon@bootlin.com>
 <20180511145919.22447-3-boris.brezillon@bootlin.com>
 <20180511153450.GS23723@intel.com> <20180511175256.53a3966a@bbrezillon>
 <20180511165402.GU23723@intel.com> <20180511191221.185f9e94@bbrezillon>
 <20180511172948.GV23723@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1213300805=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180511172948.GV23723-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

--===============1213300805==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:

> On Fri, May 11, 2018 at 07:12:21PM +0200, Boris Brezillon wrote:
>> On Fri, 11 May 2018 19:54:02 +0300
>> Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>=20
>> > On Fri, May 11, 2018 at 05:52:56PM +0200, Boris Brezillon wrote:
>> > > On Fri, 11 May 2018 18:34:50 +0300
>> > > Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>> > >=20=20=20
>> > > > On Fri, May 11, 2018 at 04:59:17PM +0200, Boris Brezillon wrote:=
=20=20
>> > > > > Applying an underscan setup is just a matter of scaling all plan=
es
>> > > > > appropriately and adjusting the CRTC X/Y offset to account for t=
he
>> > > > > horizontal and vertical border.
>> > > > >=20
>> > > > > Create an vc4_plane_underscan_adj() function doing that and call=
 it from
>> > > > > vc4_plane_setup_clipping_and_scaling() so that we are ready to a=
ttach
>> > > > > underscan properties to the HDMI connector.
>> > > > >=20
>> > > > > Signed-off-by: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
>> > > > > ---
>> > > > > Changes in v2:
>> > > > > - Take changes on hborder/vborder meaning into account
>> > > > > ---
>> > > > >  drivers/gpu/drm/vc4/vc4_plane.c | 49 ++++++++++++++++++++++++++=
++++++++++++++-
>> > > > >  1 file changed, 48 insertions(+), 1 deletion(-)
>> > > > >=20
>> > > > > diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/v=
c4/vc4_plane.c
>> > > > > index 71d44c357d35..61ed60841cd6 100644
>> > > > > --- a/drivers/gpu/drm/vc4/vc4_plane.c
>> > > > > +++ b/drivers/gpu/drm/vc4/vc4_plane.c
>> > > > > @@ -258,6 +258,49 @@ static u32 vc4_get_scl_field(struct drm_pla=
ne_state *state, int plane)
>> > > > >  	}
>> > > > >  }
>> > > > >=20=20
>> > > > > +static int vc4_plane_underscan_adj(struct drm_plane_state *psta=
te)
>> > > > > +{
>> > > > > +	struct vc4_plane_state *vc4_pstate =3D to_vc4_plane_state(psta=
te);
>> > > > > +	struct drm_connector_state *conn_state =3D NULL;
>> > > > > +	struct drm_connector *conn;
>> > > > > +	struct drm_crtc_state *crtc_state;
>> > > > > +	int i;
>> > > > > +
>> > > > > +	for_each_new_connector_in_state(pstate->state, conn, conn_stat=
e, i) {
>> > > > > +		if (conn_state->crtc =3D=3D pstate->crtc)
>> > > > > +			break;
>> > > > > +	}
>> > > > > +
>> > > > > +	if (i =3D=3D pstate->state->num_connector)
>> > > > > +		return 0;
>> > > > > +
>> > > > > +	if (conn_state->underscan.mode !=3D DRM_UNDERSCAN_ON)
>> > > > > +		return 0;
>> > > > > +
>> > > > > +	crtc_state =3D drm_atomic_get_new_crtc_state(pstate->state,
>> > > > > +						   pstate->crtc);
>> > > > > +
>> > > > > +	if (conn_state->underscan.hborder >=3D crtc_state->mode.hdispl=
ay ||
>> > > > > +	    conn_state->underscan.vborder >=3D crtc_state->mode.vdispl=
ay)
>> > > > > +		return -EINVAL;=20=20=20=20
>> > > >=20
>> > > > border * 2 ?=20=20
>> > >=20
>> > > Oops, indeed. I'll fix that.
>> > >=20=20=20
>> > > >=20=20=20
>> > > > > +
>> > > > > +	vc4_pstate->crtc_x +=3D conn_state->underscan.hborder;
>> > > > > +	vc4_pstate->crtc_y +=3D conn_state->underscan.vborder;
>> > > > > +	vc4_pstate->crtc_w =3D (vc4_pstate->crtc_w *
>> > > > > +			      (crtc_state->mode.hdisplay -
>> > > > > +			       (conn_state->underscan.hborder * 2))) /
>> > > > > +			     crtc_state->mode.hdisplay;
>> > > > > +	vc4_pstate->crtc_h =3D (vc4_pstate->crtc_h *
>> > > > > +			      (crtc_state->mode.vdisplay -
>> > > > > +			       (conn_state->underscan.vborder * 2))) /
>> > > > > +			     crtc_state->mode.vdisplay;=20=20=20=20
>> > > >=20
>> > > > So you're now scaling all planes? The code seems to reject scaling=
 for
>> > > > the cursor plane, how are you dealing with that? Or just no cursor
>> > > > allowed when underscanning?=20=20
>> > >=20
>> > > No, I just didn't test with a cursor plane. We should probably avoid
>> > > scaling the cursor plane and just adjust its position. Eric any opin=
ion
>> > > on that?=20=20
>> >=20
>> > I don't think you can just not scale it. The user asked for the cursor
>> > to be at a specific place with a specific size. Can't just ignore
>> > that and do something else. Also eg. i915 would definitely scale the
>> > cursor since we'd just scale the entire crtc instead of scaling
>> > individual planes. Different drivers doing different things wouldn't
>> > be good.
>>=20
>> Except in our case the scaling takes place before the composition, so
>> we don't have a choice.
>
> The choice is to either do what userspace asked, or return an error.
>
>>=20
>> >=20
>> > >=20=20=20
>> > > >=20
>> > > > I'm also wondering if there's any way we can reconcile these border
>> > > > props with the scaling mode prop, should we ever wish to expose
>> > > > these props on connectors that already have the scaling mode prop.=
=20=20
>> > >=20
>> > > Nouveau seems to expose both, and I don't see why we couldn't.=20=20
>> >=20
>> > First of all the interaction of these borders with panels that have
>> > a fixed mode would need to be properly specified. Do we apply the
>> > borders against the user mode or the panel's native mode?
>>=20
>> Hm, I'm a bit lost. Isn't crtc_state->mode supposed to contain the mode
>> that is about to be applied, no matter if it's a usermode or one of the
>> mode returned by the display?=20
>
> No. With fixed mode panels the user mode is a lie. Only
> hdisplay/vdisplay mean anything. The actual timings are known only to
> the kernel. Well, userspace can perhaps make an educated guess based on
> the connector's mode list and the presence of the scaling mode property.

Let's just not expose the property on devices with fixed mode panels.
Problem solved because all this property is is a way to work around HDMI
monitors doing something awful, and trying to build something more
general isn't serving anyone.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlr1+OwACgkQtdYpNtH8
nujSpRAAhQY2vNMYcYLAk/0eanMKRx+Lx3nAoU+79JVaqQpuCTJhnVcMF3XrYt6Z
ZMuzf5uBB5ky4+og8VLuj2XAjBU4jKSA63+RDpwMxX6ek5DTHUgc0ghtTg9MXlVH
YFN3bv163644HusUuE0wSIPhN2GSo/0r8siJjVsBfiur3sqZhxq/4iC5ZqgvgX9x
iJQzawHzpVfodyxGg6irl7f0XVtvL5qa0zTd4tzur1o3GX3doJ66bLbfuShBgtWO
6gYg14Id4RdqsPMD7zp68iXZV04YJnUv/HTFXVVIBh40TGZLbPzpip0y1WWl5mLT
0KwusRkcOO23UehpURPZTBOskr0lK3YTNx0XICkTeiZ2v/Dh03ozVer/Ed4VeFTg
lQbovF5EKX5UEt9SYlW+5us62dt3rlDgRrVY8dBrXsTMtAYz8TeI4oZKudhJUXxu
eDM3AR0SY6/WI/rYjA6fr2zGuSJhV++BYiV+H7/x6k1lBjdQepOnbNrW2vDiaauZ
fAw5IyNNgGtYLoR50ArUcRSgxdF+ConDbPOrcSP4xvYXRzSzd12AvaLylgMrcTy7
ZtMYGAA1UmrfBmPLa7c1o3S468Nlwt9t5dTo0ri5rndMUqo7zVJ71qE4iQwMQgTU
deEfvlQcT/Yi9vMDF4yB7cl8wKUdxVUCn/6K/TomHEh/aLKfvQI=
=X171
-----END PGP SIGNATURE-----
--=-=-=--

--===============1213300805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1213300805==--

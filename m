From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v2 2/4] drm/vc4: Take underscan setup into
 account when updating planes
Date: Mon, 14 May 2018 08:05:37 +0100
Message-ID: <87lgcmn2da.fsf@anholt.net>
References: <20180511145919.22447-1-boris.brezillon@bootlin.com>
 <20180511145919.22447-3-boris.brezillon@bootlin.com>
 <20180511153450.GS23723@intel.com> <20180511175256.53a3966a@bbrezillon>
 <20180511165402.GU23723@intel.com> <20180511191221.185f9e94@bbrezillon>
 <20180511172948.GV23723@intel.com> <20180511214749.47f6682e@bbrezillon>
 <20180511204643.GW23723@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1340915223=="
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180511204643.GW23723-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1340915223==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:

> On Fri, May 11, 2018 at 09:47:49PM +0200, Boris Brezillon wrote:
>> On Fri, 11 May 2018 20:29:48 +0300
>> Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>=20
>> > On Fri, May 11, 2018 at 07:12:21PM +0200, Boris Brezillon wrote:
>> > > On Fri, 11 May 2018 19:54:02 +0300
>> > > Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>> > >=20=20=20
>> > > > On Fri, May 11, 2018 at 05:52:56PM +0200, Boris Brezillon wrote:=
=20=20
>> > > > > On Fri, 11 May 2018 18:34:50 +0300
>> > > > > Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>> > > > >=20=20=20=20=20
>> > > > > > On Fri, May 11, 2018 at 04:59:17PM +0200, Boris Brezillon wrot=
e:=20=20=20=20
>> > > > > > > Applying an underscan setup is just a matter of scaling all =
planes
>> > > > > > > appropriately and adjusting the CRTC X/Y offset to account f=
or the
>> > > > > > > horizontal and vertical border.
>> > > > > > >=20
>> > > > > > > Create an vc4_plane_underscan_adj() function doing that and =
call it from
>> > > > > > > vc4_plane_setup_clipping_and_scaling() so that we are ready =
to attach
>> > > > > > > underscan properties to the HDMI connector.
>> > > > > > >=20
>> > > > > > > Signed-off-by: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
>> > > > > > > ---
>> > > > > > > Changes in v2:
>> > > > > > > - Take changes on hborder/vborder meaning into account
>> > > > > > > ---
>> > > > > > >  drivers/gpu/drm/vc4/vc4_plane.c | 49 ++++++++++++++++++++++=
++++++++++++++++++-
>> > > > > > >  1 file changed, 48 insertions(+), 1 deletion(-)
>> > > > > > >=20
>> > > > > > > diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/d=
rm/vc4/vc4_plane.c
>> > > > > > > index 71d44c357d35..61ed60841cd6 100644
>> > > > > > > --- a/drivers/gpu/drm/vc4/vc4_plane.c
>> > > > > > > +++ b/drivers/gpu/drm/vc4/vc4_plane.c
>> > > > > > > @@ -258,6 +258,49 @@ static u32 vc4_get_scl_field(struct drm=
_plane_state *state, int plane)
>> > > > > > >  	}
>> > > > > > >  }
>> > > > > > >=20=20
>> > > > > > > +static int vc4_plane_underscan_adj(struct drm_plane_state *=
pstate)
>> > > > > > > +{
>> > > > > > > +	struct vc4_plane_state *vc4_pstate =3D to_vc4_plane_state(=
pstate);
>> > > > > > > +	struct drm_connector_state *conn_state =3D NULL;
>> > > > > > > +	struct drm_connector *conn;
>> > > > > > > +	struct drm_crtc_state *crtc_state;
>> > > > > > > +	int i;
>> > > > > > > +
>> > > > > > > +	for_each_new_connector_in_state(pstate->state, conn, conn_=
state, i) {
>> > > > > > > +		if (conn_state->crtc =3D=3D pstate->crtc)
>> > > > > > > +			break;
>> > > > > > > +	}
>> > > > > > > +
>> > > > > > > +	if (i =3D=3D pstate->state->num_connector)
>> > > > > > > +		return 0;
>> > > > > > > +
>> > > > > > > +	if (conn_state->underscan.mode !=3D DRM_UNDERSCAN_ON)
>> > > > > > > +		return 0;
>> > > > > > > +
>> > > > > > > +	crtc_state =3D drm_atomic_get_new_crtc_state(pstate->state,
>> > > > > > > +						   pstate->crtc);
>> > > > > > > +
>> > > > > > > +	if (conn_state->underscan.hborder >=3D crtc_state->mode.hd=
isplay ||
>> > > > > > > +	    conn_state->underscan.vborder >=3D crtc_state->mode.vd=
isplay)
>> > > > > > > +		return -EINVAL;=20=20=20=20=20=20
>> > > > > >=20
>> > > > > > border * 2 ?=20=20=20=20
>> > > > >=20
>> > > > > Oops, indeed. I'll fix that.
>> > > > >=20=20=20=20=20
>> > > > > >=20=20=20=20=20
>> > > > > > > +
>> > > > > > > +	vc4_pstate->crtc_x +=3D conn_state->underscan.hborder;
>> > > > > > > +	vc4_pstate->crtc_y +=3D conn_state->underscan.vborder;
>> > > > > > > +	vc4_pstate->crtc_w =3D (vc4_pstate->crtc_w *
>> > > > > > > +			      (crtc_state->mode.hdisplay -
>> > > > > > > +			       (conn_state->underscan.hborder * 2))) /
>> > > > > > > +			     crtc_state->mode.hdisplay;
>> > > > > > > +	vc4_pstate->crtc_h =3D (vc4_pstate->crtc_h *
>> > > > > > > +			      (crtc_state->mode.vdisplay -
>> > > > > > > +			       (conn_state->underscan.vborder * 2))) /
>> > > > > > > +			     crtc_state->mode.vdisplay;=20=20=20=20=20=20
>> > > > > >=20
>> > > > > > So you're now scaling all planes? The code seems to reject sca=
ling for
>> > > > > > the cursor plane, how are you dealing with that? Or just no cu=
rsor
>> > > > > > allowed when underscanning?=20=20=20=20
>> > > > >=20
>> > > > > No, I just didn't test with a cursor plane. We should probably a=
void
>> > > > > scaling the cursor plane and just adjust its position. Eric any =
opinion
>> > > > > on that?=20=20=20=20
>> > > >=20
>> > > > I don't think you can just not scale it. The user asked for the cu=
rsor
>> > > > to be at a specific place with a specific size. Can't just ignore
>> > > > that and do something else. Also eg. i915 would definitely scale t=
he
>> > > > cursor since we'd just scale the entire crtc instead of scaling
>> > > > individual planes. Different drivers doing different things wouldn=
't
>> > > > be good.=20=20
>> > >=20
>> > > Except in our case the scaling takes place before the composition, so
>> > > we don't have a choice.=20=20
>> >=20
>> > The choice is to either do what userspace asked, or return an error.
>>=20
>> Come on! If we can't use underscan when there's a cursor plane enabled
>> this feature is pretty much useless. But let's take a real use case to
>> show you how negligible the lack of scaling on the cursor plane will
>> be. Say you have borders taking 10% of you screen (which is already a
>> lot), and your cursor is a plane of 64x64 pixels, you'll end up with a
>> 64x64 cursor instead of 58x58. Quite frankly, I doubt you'll notice
>> the difference.
>
> Now you're assuming the cursor is only ever used as a cursor. It can
> be used for other things and those may need to be positioned pixel
> perfect in relation to other planes/fb contents.
>
> We used to play is fast and loose in i915 when it came to the sprite
> plane coordinates. People generally hated that, at least when it came
> to the atomic ioctl. Basically we just adjusted the src/dst
> coordinates until the hw was happy with them, partially ignoring
> what the user had asked. Maarten recently nuked that code, and so
> now we either respect the user's choice or we return an error.
>
> I guess one way out of this conundrum would be to allow the cursor
> to violate the user's requested parameters when controlled via the
> legacy cursor ioctls. There are no atomicity guarantees there, so
> I guess we could also say there are no other correctness guarantees
> either. Not sure if the accuracy of the hotspot might become an issue
> though.
>
> Another option might be to just scale the cursor as well. If I
> understand correctly the "cursor can't be scaled" limitation just
> comes from the fact that some vblank synced resource needs to be
> reconfigured whenever the scaling changes. So doing that for
> unthrottled cursor updates is not easy. But in this case the
> underscan properties are what determines the scaling so maybe that
> resource could be reconfigured whenever the those props change
> to make sure the cursor can always be scaled appropriately?

Yeah, we had no application for it, so it wasn't supported.  I don't
think it would be hard to have a previously-scaled cursor move, it's
just that we need to fall back to a synchronous plane update if the
scaling parameters change.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlr5NUEACgkQtdYpNtH8
nuj/Lg//Ylgxlt8PlndH+WKwmd30LDG3/7Vibx3of8VHCe8IajJGHJLPvOXVm1vi
DunHIs/dEI9hVwHPuYmDQro+VkXjqaDn/pwVI6LCeOpjpui6pAq40RQicg2l7VUO
/y1Y24EA7oPncomETHPAMC6q7WVIzjKUJTNrJZJDxTYmUFVC5NqqA40ullsoQLQR
Y9LADM9cA5Htj9v9l3dP8Bc5Nn3yy5tPyW5tCemrCtAklvvtk/OND9ZedxosDWFX
/dD9VcMPDQQHpPnJWffZNkPcAw3P/oPyQmATmvPjR+yc1H3s/OJkdYVlVUDN22DC
R9tFz0BOAGs5M6JfuzYNzHXtKnU97XfMaNqzGlfHmHXQqAtwwzw1tePSij7pB/pB
eFisnKMIqA9RxC1fqWIGjjvrExZMafuYqyNRqDLNJHvLbgOh3j+ru2a/jT1ftXD3
KXPCo4rVItpQeyWsFx2DcHQmBHxN6Kf3EiGkrCb2fizF8/kF7Ppw3S0w74CXTJES
mjv2xWbevLgpEHEOAgOv4TqXvW/EC6Dqbnka9jjomGCASKNQHDSIpWGPQkH+x2it
Ap8YHVe+UxK2I9I+ojVAO0jPENdDPsypIEtczSWFI1QZWXnH9MxanigCin2EVxgO
zaMaypTJcTVKS0quECGrISuLSwQy1ElJ6bYHuOd4RtQ6x4vF+9U=
=DBiB
-----END PGP SIGNATURE-----
--=-=-=--

--===============1340915223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVhdSBt
YWlsaW5nIGxpc3QKTm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9ub3V2ZWF1Cg==

--===============1340915223==--

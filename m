From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 04/19] drm/amd/display: Fix handling of scaling and
 underscan.
Date: Wed, 31 May 2017 18:39:14 +0200
Message-ID: <9f00c668-0cfd-ff16-f97b-c9ee7ed0c5c4@dev.carbon-project.org>
References: <20170531155218.29934-1-harry.wentland@amd.com>
 <20170531155218.29934-5-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1500896865=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170531155218.29934-5-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1500896865==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CX4bu0cRTAorgUU9VVbpJQQKNpEdFX2KE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CX4bu0cRTAorgUU9VVbpJQQKNpEdFX2KE
Content-Type: multipart/mixed; boundary="wFtW4xsjKmqAPOxH011ehxU3AaPRLCaXR";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>,
 amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Message-ID: <9f00c668-0cfd-ff16-f97b-c9ee7ed0c5c4-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 04/19] drm/amd/display: Fix handling of scaling and
 underscan.
References: <20170531155218.29934-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
 <20170531155218.29934-5-harry.wentland-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170531155218.29934-5-harry.wentland-5C7GfCeVMHo@public.gmane.org>

--wFtW4xsjKmqAPOxH011ehxU3AaPRLCaXR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Harry, hey Andrey,
Harry Wentland wrote on 31.05.2017 17:52:
> From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
>=20
> Summury of changes:

s/Summury/Summary/

> 1: Both in check and commit Connector properties were handled as

s/in// ?

>    part of for_each(crtc) loop while they shoud have been handled

s/part of/part of a/
s/shoud/should/

>    in a dedicated for_each(connector)
>    loop since they are connector properties. Moved.
>=20
> 2: Removed hacky plane add in amdgpu_dm_connector_atomic_set_property
>    to force iteration on plane forconnector property. This was
>    causing double call to commit_surface_for_stream both in crtc loop
>    and plane loop.
> 3: Remove middleman DC interface and  call dc_commit_surfaces_to_stream=

>    directly to increase code clarity.

This description makes it sound like three independent issues, that shoul=
d be
split into their own patches. But I'm probably missing an interdependency=
 here?
If so, it'd be awesome if this could be mentioned here.

Cheers&Thanks,
Kai


> Remove it from atomic_commit.
>=20
> Change-Id: I1337b7abe4a2c6812c7500a5bf22f6c6f01890ca
> Signed-off-by: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_types.c    | 207 ++++++++++---=
--------
>  1 file changed, 99 insertions(+), 108 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_types.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_types.c
> index a929df2e690d..15204bf7d9a8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_types.c
> @@ -683,9 +683,8 @@ struct amdgpu_connector *aconnector_from_drm_crtc_i=
d(
>  static void update_stream_scaling_settings(
>  		const struct drm_display_mode *mode,
>  		const struct dm_connector_state *dm_state,
> -		const struct dc_stream *stream)
> +		struct dc_stream *stream)
>  {
> -	struct amdgpu_device *adev =3D dm_state->base.crtc->dev->dev_private;=

>  	enum amdgpu_rmx_type rmx_type;
> =20
>  	struct rect src =3D { 0 }; /* viewport in composition space*/
> @@ -727,7 +726,8 @@ static void update_stream_scaling_settings(
>  		dst.height -=3D dm_state->underscan_vborder;
>  	}
> =20
> -	adev->dm.dc->stream_funcs.stream_update_scaling(adev->dm.dc, stream, =
&src, &dst);
> +	stream->src =3D src;
> +	stream->dst =3D dst;
> =20
>  	DRM_DEBUG_KMS("Destination Rectangle x:%d  y:%d  width:%d  height:%d\=
n",
>  			dst.x, dst.y, dst.width, dst.height);
> @@ -1287,9 +1287,6 @@ int amdgpu_dm_connector_atomic_set_property(
>  	struct dm_connector_state *dm_new_state =3D
>  		to_dm_connector_state(connector_state);
> =20
> -	struct drm_crtc_state *new_crtc_state;
> -	struct drm_crtc *crtc;
> -	int i;
>  	int ret =3D -EINVAL;
> =20
>  	if (property =3D=3D dev->mode_config.scaling_mode_property) {
> @@ -1335,34 +1332,6 @@ int amdgpu_dm_connector_atomic_set_property(
>  		return ret;
>  	}
> =20
> -
> -
> -	for_each_crtc_in_state(
> -		connector_state->state,
> -		crtc,
> -		new_crtc_state,
> -		i) {
> -
> -		if (crtc =3D=3D connector_state->crtc) {
> -			struct drm_plane_state *plane_state;
> -
> -			/*
> -			 * Bit of magic done here. We need to ensure
> -			 * that planes get update after mode is set.
> -			 * So, we need to add primary plane to state,
> -			 * and this way atomic_update would be called
> -			 * for it
> -			 */
> -			plane_state =3D
> -				drm_atomic_get_plane_state(
> -					connector_state->state,
> -					crtc->primary);
> -
> -			if (!plane_state)
> -				return -EINVAL;
> -		}
> -	}
> -
>  	return ret;
>  }
> =20
> @@ -2582,28 +2551,19 @@ static void amdgpu_dm_commit_surfaces(struct dr=
m_atomic_state *state,
>  		struct amdgpu_crtc *acrtc_attach =3D to_amdgpu_crtc(crtc);
>  		struct drm_framebuffer *fb =3D plane_state->fb;
>  		struct drm_connector *connector;
> -		struct dm_connector_state *dm_state =3D NULL;
> -
> -		enum dm_commit_action action;
> +		struct dm_connector_state *con_state =3D NULL;
>  		bool pflip_needed;
> =20
>  		if (!fb || !crtc || !crtc->state->active)
>  			continue;
> =20
> -		action =3D get_dm_commit_action(crtc->state);
> -
> -		/*
> -		 * TODO - TO decide if it's a flip or surface update
> -		 * stop relying on allow_modeset flag and query DC
> -		 * using dc_check_update_surfaces_for_stream.
> -		 */
>  		pflip_needed =3D !state->allow_modeset;
>  		if (!pflip_needed) {
>  			list_for_each_entry(connector,
>  					    &dev->mode_config.connector_list,
>  					    head) {
>  				if (connector->state->crtc =3D=3D crtc) {
> -					dm_state =3D to_dm_connector_state(
> +					con_state =3D to_dm_connector_state(
>  							connector->state);
>  					break;
>  				}
> @@ -2623,8 +2583,10 @@ static void amdgpu_dm_commit_surfaces(struct drm=
_atomic_state *state,
>  			 * Also it should be needed when used with actual
>  			 * drm_atomic_commit ioctl in future
>  			 */
> -			if (!dm_state)
> +			if (!con_state)
>  				continue;
> +
> +
>  			if (crtc =3D=3D pcrtc) {
>  				add_surface(dm->dc, crtc, plane,
>  					    &dc_surfaces_constructed[planes_count]);
> @@ -2676,7 +2638,8 @@ void amdgpu_dm_atomic_commit_tail(
>  	const struct dc_stream *new_stream;
>  	unsigned long flags;
>  	bool wait_for_vblank =3D true;
> -
> +	struct drm_connector *connector;
> +	struct drm_connector_state *old_conn_state;
> =20
>  	drm_atomic_helper_update_legacy_modeset_state(dev, state);
> =20
> @@ -2756,21 +2719,6 @@ void amdgpu_dm_atomic_commit_tail(
> =20
>  			break;
>  		}
> -
> -		case DM_COMMIT_ACTION_NOTHING: {
> -			struct dm_connector_state *dm_state =3D NULL;
> -
> -			if (!aconnector)
> -				break;
> -
> -			dm_state =3D to_dm_connector_state(aconnector->base.state);
> -
> -			/* Scaling update */
> -			update_stream_scaling_settings(&crtc->state->mode,
> -					dm_state, acrtc->stream);
> -
> -			break;
> -		}
>  		case DM_COMMIT_ACTION_DPMS_OFF:
>  		case DM_COMMIT_ACTION_RESET:
>  			DRM_INFO("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id,=
 acrtc);
> @@ -2778,9 +2726,48 @@ void amdgpu_dm_atomic_commit_tail(
>  			if (acrtc->stream)
>  				remove_stream(adev, acrtc);
>  			break;
> +
> +		/*TODO retire */
> +		case DM_COMMIT_ACTION_NOTHING:
> +			continue;
>  		} /* switch() */
>  	} /* for_each_crtc_in_state() */
> =20
> +	/* Handle scaling and undersacn changes*/
> +	for_each_connector_in_state(state, connector, old_conn_state, i) {
> +		struct amdgpu_connector *aconnector =3D to_amdgpu_connector(connecto=
r);
> +		struct dm_connector_state *con_new_state =3D
> +				to_dm_connector_state(aconnector->base.state);
> +		struct dm_connector_state *con_old_state =3D
> +				to_dm_connector_state(old_conn_state);
> +		struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(con_new_state->base.crt=
c);
> +		const struct dc_stream_status *status =3D NULL;
> +
> +		/* Skip any modesets/resets */
> +		if (!acrtc ||
> +			get_dm_commit_action(acrtc->base.state) !=3D DM_COMMIT_ACTION_NOTHI=
NG)
> +			continue;
> +
> +		/* Skip any thing not scale or underscan chnages */
> +		if (!is_scaling_state_different(con_new_state, con_old_state))
> +			continue;
> +
> +		update_stream_scaling_settings(&con_new_state->base.crtc->mode,
> +				con_new_state, (struct dc_stream *)acrtc->stream);
> +
> +		status =3D dc_stream_get_status(acrtc->stream);
> +		WARN_ON(!status);
> +		WARN_ON(!status->surface_count);
> +
> +		/*TODO How it works with MPO ?*/
> +		if (!dc_commit_surfaces_to_stream(
> +				dm->dc,
> +				(const struct dc_surface **)status->surfaces,
> +				status->surface_count,
> +				acrtc->stream))
> +			dm_error("%s: Failed to update stream scaling!\n", __func__);
> +	}
> +
>  	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> =20
>  		struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);
> @@ -3118,6 +3105,8 @@ int amdgpu_dm_atomic_check(struct drm_device *dev=
,
>  	struct dc *dc =3D adev->dm.dc;
>  	bool need_to_validate =3D false;
>  	struct validate_context *context;
> +	struct drm_connector *connector;
> +	struct drm_connector_state *conn_state;
>  	/*
>  	 * This bool will be set for true for any modeset/reset
>  	 * or surface update which implies non fast surfae update.
> @@ -3203,52 +3192,6 @@ int amdgpu_dm_atomic_check(struct drm_device *de=
v,
>  			break;
>  		}
> =20
> -		case DM_COMMIT_ACTION_NOTHING: {
> -			const struct drm_connector *drm_connector =3D NULL;
> -			struct drm_connector_state *conn_state =3D NULL;
> -			struct dm_connector_state *dm_state =3D NULL;
> -			struct dm_connector_state *old_dm_state =3D NULL;
> -			struct dc_stream *new_stream;
> -
> -			if (!aconnector)
> -				break;
> -
> -			for_each_connector_in_state(
> -				state, drm_connector, conn_state, j) {
> -				if (&aconnector->base =3D=3D drm_connector)
> -					break;
> -			}
> -
> -			old_dm_state =3D to_dm_connector_state(drm_connector->state);
> -			dm_state =3D to_dm_connector_state(conn_state);
> -
> -			/* Support underscan adjustment*/
> -			if (!is_scaling_state_different(dm_state, old_dm_state))
> -				break;
> -
> -			new_stream =3D create_stream_for_sink(aconnector, &crtc_state->mode=
, dm_state);
> -
> -			if (!new_stream) {
> -				DRM_ERROR("%s: Failed to create new stream for crtc %d\n",
> -						__func__, acrtc->base.base.id);
> -				break;
> -			}
> -
> -			new_streams[new_stream_count] =3D new_stream;
> -			set_count =3D update_in_val_sets_stream(
> -					set,
> -					crtc_set,
> -					set_count,
> -					acrtc->stream,
> -					new_stream,
> -					crtc);
> -
> -			new_stream_count++;
> -			need_to_validate =3D true;
> -			wait_for_prev_commits =3D true;
> -
> -			break;
> -		}
>  		case DM_COMMIT_ACTION_DPMS_OFF:
>  		case DM_COMMIT_ACTION_RESET:
>  			/* i.e. reset mode */
> @@ -3260,6 +3203,10 @@ int amdgpu_dm_atomic_check(struct drm_device *de=
v,
>  				wait_for_prev_commits =3D true;
>  			}
>  			break;
> +
> +		/*TODO retire */
> +		case DM_COMMIT_ACTION_NOTHING:
> +			continue;
>  		}
> =20
>  		/*
> @@ -3276,6 +3223,50 @@ int amdgpu_dm_atomic_check(struct drm_device *de=
v,
>  		ret =3D -EINVAL;
>  	}
> =20
> +	/* Check scaling and undersacn changes*/
> +	for_each_connector_in_state(state, connector, conn_state, i) {
> +		struct amdgpu_connector *aconnector =3D to_amdgpu_connector(connecto=
r);
> +		struct dm_connector_state *con_old_state =3D
> +				to_dm_connector_state(aconnector->base.state);
> +		struct dm_connector_state *con_new_state =3D
> +						to_dm_connector_state(conn_state);
> +		struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(con_new_state->base.crt=
c);
> +		struct dc_stream *new_stream;
> +
> +		/* Skip any modesets/resets */
> +		if (!acrtc ||
> +			get_dm_commit_action(acrtc->base.state) !=3D DM_COMMIT_ACTION_NOTHI=
NG)
> +			continue;
> +
> +		/* Skip any thing not scale or underscan chnages */
> +		if (!is_scaling_state_different(con_new_state, con_old_state))
> +			continue;
> +
> +		new_stream =3D create_stream_for_sink(
> +				aconnector,
> +				&acrtc->base.state->mode,
> +				con_new_state);
> +
> +		if (!new_stream) {
> +			DRM_ERROR("%s: Failed to create new stream for crtc %d\n",
> +					__func__, acrtc->base.base.id);
> +			continue;
> +		}
> +
> +		new_streams[new_stream_count] =3D new_stream;
> +		set_count =3D update_in_val_sets_stream(
> +				set,
> +				crtc_set,
> +				set_count,
> +				acrtc->stream,
> +				new_stream,
> +				&acrtc->base);
> +
> +		new_stream_count++;
> +		need_to_validate =3D true;
> +		wait_for_prev_commits =3D true;
> +	}
> +
>  	for (i =3D 0; i < set_count; i++) {
>  		for_each_plane_in_state(state, plane, plane_state, j) {
>  			struct drm_crtc *crtc =3D plane_state->crtc;
>=20

--=20

Kai Wasserb=C3=A4ch (Kai Wasserbaech)

E-Mail: kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org


--wFtW4xsjKmqAPOxH011ehxU3AaPRLCaXR--

--CX4bu0cRTAorgUU9VVbpJQQKNpEdFX2KE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlku8bIACgkQownXbOHe
WdK2uAwAnhreGmjw89LwJyFwxI2SpVAizmcMpzGvUToBJ37ATmBnjFNU2ShnV+IG
XKIA+9X+nwLFPxiS2Nj/BGSxUpyQt7zkt1h2BBaSoGeUglmbxuk8ibYljnJn2Ok0
r0244o3QNBWBgMsuend1mLsBmKWDGIP2nKysto+LaGPHwdq4cvTxqjokHF7Yuq95
TtKDZmf9i5ltHADrvq9KNihhAhrw3lhf9xmY4ijxGAyJ+/iubMMfCfpjKqCfw8sn
l2IApTVCkiM/N0pm2BzDFoGHdzrExylNW21NiXFWRgjcudFPT5zukHfu+57h98Iz
QUqf79ajJwF7hro1EzYZAZpvNgMkl32zCzANxrPnj86kT53lrsifWthFmQupBm7+
SrwPO/KzYeXIRAcDurHQHQuauw1lNMvYIYphfUZQfQEhbjJH0tn7r2csVr/29y5w
3FieNuUB6dFlfOcuASibiEuVwAH4asKziCeM3+HGG8T6Gx7+mS7ApyPV+MD3NckD
8XTEckck
=ZeC2
-----END PGP SIGNATURE-----

--CX4bu0cRTAorgUU9VVbpJQQKNpEdFX2KE--

--===============1500896865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1500896865==--

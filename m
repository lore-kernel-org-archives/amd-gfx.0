From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v3 1/3] drm/connector: Add generic underscan properties
Date: Mon, 03 Dec 2018 07:50:53 -0800
Message-ID: <87k1kqfw2q.fsf@anholt.net>
References: <20181122112331.17735-1-boris.brezillon@bootlin.com>
 <20181122112331.17735-2-boris.brezillon@bootlin.com>
 <20181203144011.GH9144@intel.com> <20181203163636.7053cffd@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0329242848=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181203163636.7053cffd@bbrezillon>
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
To: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Ville =?utf-8?B?U3ly?= =?utf-8?B?asOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

--===============0329242848==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> writes:

> On Mon, 3 Dec 2018 16:40:11 +0200
> Ville Syrj=C3=A4l=C3=A4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>
>> On Thu, Nov 22, 2018 at 12:23:29PM +0100, Boris Brezillon wrote:
>> > @@ -924,6 +978,29 @@ struct drm_connector {
>> >  	 */
>> >  	struct drm_property_blob *path_blob_ptr;
>> >=20=20
>> > +	/**
>> > +	 * @underscan_mode_property: Optional connector underscan mode. Used=
 by
>> > +	 * the driver to scale the output image and compensate an overscan d=
one
>> > +	 * on the display side.
>> > +	 */
>> > +	struct drm_property *underscan_mode_property;
>> > +
>> > +	/**
>> > +	 * @underscan_hborder_property: Optional connector underscan horizon=
tal
>> > +	 * border (expressed in pixels). Used by the driver to adjust the
>> > +	 * output image position and compensate an overscan done on the disp=
lay
>> > +	 * side.
>> > +	 */
>> > +	struct drm_property *underscan_hborder_property;
>> > +
>> > +	/**
>> > +	 * @underscan_hborder_property: Optional connector underscan vertical
>> > +	 * border (expressed in pixels). Used by the driver to adjust the
>> > +	 * output image position and compensate an overscan done on the disp=
lay
>> > +	 * side.
>> > +	 */
>> > +	struct drm_property *underscan_vborder_property;=20=20
>>=20
>> I'm wondering why we're adding these new props when we already have the
>> (slightly more flexible) margin properties for TV out. We could just
>> reuse those AFAICS.
>
> I'm not against the idea, but I can't use
> drm_mode_create_tv_properties() directly, as most props created by this
> function are not applicable to an HDMI displays. Should I move the
> margins props out of the tv_connector_state and provide new helpers to
> create those props?

TV margin props look good to me, FWIW.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwFUN0ACgkQtdYpNtH8
nuj4/A//YBSOhcSonFIhzzu5jiBw0HfyUaumOpFaZ7U0BbcABXqFftpB3ddNIMnf
NMte0ByJScUvTzEYkYqEE9d1bByvWNhkAsqqhEDvP/dWOVnTJhekZQb5Cm//xtG9
HY6J5mvtNCIrRhTrFTX74tzEYEiojO25XZEM/qf0+fpmicyKigwmX4dhATnUGzeO
1IlYGT2o9ZUlsR8FEqiph2gDnv2UfXwQVouYneSMeG/0TwWxTLC0a3Tq+DV220Fe
kvDOIiR8PRgwR8B80zPT6b2MG3SJhep2ogXrMweln5XBKFYcaL85TOy0/MMNVQYo
8jgO5ajBKOfcM/UFwUEC9HdlE3K73L/H4ClnyyfUvXdKYXzpnxn8B6ETF9YsW8kT
fTPys0NOn6km+/NiULXDPknSot6rPo8s80ePp8yp3xVsxGy045tSKpjrVKGZM5Ym
ENJHp4NA0obnRLRdbSriuu/9DRnh5IEOxLCwYE5t6NQMcKJ26t5xAm+ToKZRRhEc
7qtN1WdmP4vhjJiDz9buHdiDc7y4u45UWksqbfO6kSnyQHq02KT8xPk1QqVAulBn
H7naSUS8yAFqD25W2UaKyGVMYqmqJyXlGPpDcekQ8zc9w25f/24RKdTVmp2h4XHY
rysVSr4xF0+1TA9fMe5GXI55N4eKZivlHvIk+gxyZF8g882Vq/8=
=DAG6
-----END PGP SIGNATURE-----
--=-=-=--

--===============0329242848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0329242848==--

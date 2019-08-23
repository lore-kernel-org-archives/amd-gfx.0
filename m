From: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm: Add LTTPR defines for DP 1.4
Date: Fri, 23 Aug 2019 19:37:59 +0000
Message-ID: <20190823193755.yiwxlvdgbsexlihd@outlook.office365.com>
References: <20190822224607.m73g3a2a23zww644@outlook.office365.com>
 <8105f436-91af-3c63-7ada-a5800df43a52@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1206232293=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8105f436-91af-3c63-7ada-a5800df43a52-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Berthe,
 Abdoulaye" <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1206232293==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sja2kg3yq4wg4ipx"

--sja2kg3yq4wg4ipx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Harry,

Thanks for your feedback, I'll prepare a V2.

On 08/23, Wentland, Harry wrote:
> On 2019-08-22 6:46 p.m., Siqueira, Rodrigo wrote:
> > DP 1.4 specification defines Link Training Tunable PHY Repeater (LTTPR)
> > which is required to add support for systems with Thunderbolt or other
> > repeater devices.
> >=20
> > Cc: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
> > Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> > Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
> > Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
> > Signed-off-by: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  include/drm/drm_dp_helper.h | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
> > diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> > index 8364502f92cf..8336d960da7f 100644
> > --- a/include/drm/drm_dp_helper.h
> > +++ b/include/drm/drm_dp_helper.h
> > @@ -134,6 +134,32 @@
> >  #define DP_SUPPORTED_LINK_RATES		    0x010 /* eDP 1.4 */
> >  # define DP_MAX_SUPPORTED_RATES		     8	    /* 16-bit little-endian */
> > =20
> > +/** Link Training (LT)-tunable Physical Repeaters - DP 1.4 **/
> > +#define DP_LTTPR_REV                                  0xf0000
> > +#define DP_LTTPR_MAX_LINK_RATE                        0xf0001
> > +#define DP_LTTPR_REPEATER_CNT                         0xf0002
> > +#define DP_LTTPR_REPEATER_MODE                        0xf0003
> > +#define DP_LTTPR_MAX_LANE_CNT                         0xf0004
> > +#define DP_LTTPR_EXTENDED_WAIT_TIMEOUT                0xf0005
> > +#define DP_LTTPR_TRAINING_PATTERN_SET_REPEATER1       0xf0010
> > +#define DP_LTTPR_TRAINING_LANE0_SET_REPEATER1         0xf0011
> > +#define DP_LTTPR_TRAINING_LANE1_SET_REPEATER1         0xf0012
> > +#define DP_LTTPR_TRAINING_LANE2_SET_REPEATER1         0xf0013
> > +#define DP_LTTPR_TRAINING_LANE3_SET_REPEATER1         0xf0014
>=20
> Can we align the register naming with the spec and to align with the
> rest of this file?
>=20
> The seem to take the form of DP_<name-from-spec>
>=20
> E.g. call this one DP_TRAINING_LANE3_SET_PHY_REPEATER1
>=20
> Same for all other registers.
>=20
> Keeping the naming consistent makes it easier to search.
>=20
> > +#define DP_LTTPR_TRAINING_AUX_RD_INTERVAL_REPEATER1   0xf0020
> > +#define DP_LTTPR_TRANSMITTER_CAPABILITY_REPEATER1     0xf0021
> > +#define DP_LTTPR_LANE0_1_STATUS_REPEATER1             0xf0030
> > +#define DP_LTTPR_LANE2_3_STATUS_REPEATER1             0xf0031
> > +#define DP_LTTPR_LANE_ALIGN_STATUS_UPDATED_REPEATER1  0xf0032
> > +#define DP_LTTPR_ADJUST_REQUEST_LANE0_1_REPEATER1     0xf0033
> > +#define DP_LTTPR_ADJUST_REQUEST_LANE2_3_REPEATER1     0xf0034
> > +#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE0_REPEATER1   0xf0035
> > +#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE1_REPEATER1   0xf0037
> > +#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE2_REPEATER1   0xf0039
> > +#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE3_REPEATER1   0xf003b
> > +#define DP_REPEATER_CONFIGURATION_AND_STATUS_OFFSET   0x50
>=20
> With a cursory search I can't seem to find this in the spec. Where is
> this coming from?
>=20
> Harry
>=20
> > +#define DP_LTTPR_FEC_STATUS_REPEATER1                 0xf0290> +
> >  /* Multiple stream transport */
> >  #define DP_FAUX_CAP			    0x020   /* 1.2 */
> >  # define DP_FAUX_CAP_1			    (1 << 0)
> >=20
>=20




--=20
Rodrigo Siqueira
https://siqueira.tech

--sja2kg3yq4wg4ipx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl1gQJMACgkQWJzP/com
vP+lrQ//fyXX66ak9HWFSGEuD6SNP4isgeQj0smEZVdzYAiDKYIVTAdOUVdRySbY
Mx0sNqft6DT7mF1CKnExA+WCCLpQNnCFjs8Vtva8d/3izjVtRX5Au+pztx6v1IGL
p8Of5fNKfCdPqIT15qsVxMrFNKSzUOMo3d7L4Lh0iTJqSIlF9t6Fpr96JWLzJDEh
sgrvNaISJzzlpIMOOwNjhuKCdXXAla+4UJitB0UsrwYlZhe0VXpdn7DMqWoy7Dgt
nAumMIJBK+aV0XFjr/dp4BHNzMc7q3muwS5nT41Pw8qdxWap1MFf2LQ/jtzgE0y7
yTwjjCX54olRFnY/EuzOd8kl7MNIzzIBF3nkc932Uvx1OLzz0+uloU44rrNMANGb
LUefgwLska4xBwZPak2Sl5K8EQLEcHBfsMGqizBhCDwUQ/yxFu7PCKhTmqdh9G6Y
9h5pF9wfLRnsKvHriWO23Cr4jBetxL+BN2Ymu89P3NLux1KBxiMOCd41WNH5Vg1V
wFZtkXIjzhUu36el2pJub+Dp6UTcXR8jsxAIKQKhreuy3LRBov3RKmAmb2xtH55r
IWI7nal0pItXCjX2QFJAESrIUugi2cBMgFMm1heDzmTHpbtZzopLnqeHhkNgSqtR
L7P6d1HlhiaL7igTSTEBrEUL6No7SOZqgqE12S1ZPX1xm/JCHgY=
=/cFN
-----END PGP SIGNATURE-----

--sja2kg3yq4wg4ipx--

--===============1206232293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1206232293==--

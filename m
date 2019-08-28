From: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH V2] drm: Add LTTPR defines for DP 1.4a
Date: Wed, 28 Aug 2019 19:58:57 +0000
Message-ID: <20190828195904.u4lqjwi4naclkh4r@outlook.office365.com>
References: <20190826152925.4x7mwhzxit353yww@outlook.office365.com>
 <87zhjv81lx.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2067205127=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <87zhjv81lx.fsf@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Berthe,
 Abdoulaye" <Abdoulaye.Berthe@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============2067205127==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g77yriyayozscbdx"

--g77yriyayozscbdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08/27, Jani Nikula wrote:
> On Mon, 26 Aug 2019, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com> wrote:
> > DP 1.4a specification defines Link Training Tunable PHY Repeater (LTTPR)
> > which is required to add support for systems with Thunderbolt or other
> > repeater devices.
> >
> > Changes since V1:
> > - Adjusts registers names to be aligned with spec and the rest of the
> >   file
> > - Update spec comment from 1.4 to 1.4a
> >
> > Cc: Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Signed-off-by: Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
> > ---
> >  include/drm/drm_dp_helper.h | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> > index 8364502f92cf..e8beb4e7e5da 100644
> > --- a/include/drm/drm_dp_helper.h
> > +++ b/include/drm/drm_dp_helper.h
> > @@ -134,6 +134,31 @@
> >  #define DP_SUPPORTED_LINK_RATES		    0x010 /* eDP 1.4 */
> >  # define DP_MAX_SUPPORTED_RATES		     8	    /* 16-bit little-endian */
> > =20
> > +/** Link Training (LT)-tunable Physical Repeaters - DP 1.4a **/
>=20
> This is not a kernel-doc comment, so please drop the double ** and use
> regular comments.
>=20
> All the DPCD register definitions are ordered according to register
> offset. Why add 0xf0000 and friends between 0x10 and 0x20...?

Hi Jani,

Thank you for the feedback. I already sent a V3 patch based on your
comments; please let me know if you have any other suggestion.

Best Regards

> BR,
> Jani.
>=20
> > +#define DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV 0xf0000
> > +#define DP_MAX_LINK_RATE_PHY_REPEATER                       0xf0001
> > +#define DP_PHY_REPEATER_CNT                                 0xf0002
> > +#define DP_PHY_REPEATER_MODE                                0xf0003
> > +#define DP_MAX_LANE_COUNT_PHY_REPEATER                      0xf0004
> > +#define DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT               0xf0005
> > +#define DP_TRAINING_PATTERN_SET_PHY_REPEATER1               0xf0010
> > +#define DP_TRAINING_LANE0_SET_PHY_REPEATER1                 0xf0011
> > +#define DP_TRAINING_LANE1_SET_PHY_REPEATER1                 0xf0012
> > +#define DP_TRAINING_LANE2_SET_PHY_REPEATER1                 0xf0013
> > +#define DP_TRAINING_LANE3_SET_PHY_REPEATER1                 0xf0014
> > +#define DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1           0xf0020
> > +#define DP_TRANSMITTER_CAPABILITY_PHY_REPEATER1             0xf0021
> > +#define DP_LANE0_1_STATUS_PHY_REPEATER1                     0xf0030
> > +#define DP_LANE2_3_STATUS_PHY_REPEATER1                     0xf0031
> > +#define DP_LANE_ALIGN_STATUS_UPDATED_PHY_REPEATER1          0xf0032
> > +#define DP_ADJUST_REQUEST_LANE0_1_PHY_REPEATER1             0xf0033
> > +#define DP_ADJUST_REQUEST_LANE2_3_PHY_REPEATER1             0xf0034
> > +#define DP_SYMBOL_ERROR_COUNT_LANE0_PHY_REPEATER1           0xf0035
> > +#define DP_SYMBOL_ERROR_COUNT_LANE1_PHY_REPEATER1           0xf0037
> > +#define DP_SYMBOL_ERROR_COUNT_LANE2_PHY_REPEATER1           0xf0039
> > +#define DP_SYMBOL_ERROR_COUNT_LANE3_PHY_REPEATER1           0xf003b
> > +#define DP_FEC_STATUS_PHY_REPEATER1                         0xf0290
> > +
> >  /* Multiple stream transport */
> >  #define DP_FAUX_CAP			    0x020   /* 1.2 */
> >  # define DP_FAUX_CAP_1			    (1 << 0)
>=20
> --=20
> Jani Nikula, Intel Open Source Graphics Center

--=20
Rodrigo Siqueira
Software Engineer, Advanced Micro Devices (AMD)
https://siqueira.tech

--g77yriyayozscbdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl1m3QgACgkQWJzP/com
vP+NMw/+MsgYUVfI4L4iH6c7sGo0x8hLxxRGAZ25MaIMtCfa+oaguXI3nx0cWddU
I5zvcGVU5X+s2dFOXyG4qOlmUV6x+uJMnqTB7RcRybjpjzv8OamB6hhSV7Gt/cRb
dEYX8ugtDhSQWHoZT4LzARuFUIOnIJO9N12oLe8B98QXmZpsAQl+X6ZyWAHzEVzo
FA9iyuCRKGPO/+Y1xn7NkD36WcZDNwRRC/ivE4AOh2yu2EFOdnMyykuDRTQvXyXr
2cPOjayOafmyPw6CNscHkmcWNYSkrKnbH3I2RfT867CNpXdLW5ed/XAio2s213H6
j2H/f4NboQ7kFi/SoHtqKvubMBTPb82zLUnoMyL21hof8XkuN2ZMFO8MnAMRBPgi
uCaJKHGZrq7QeXu6ClD50gRZ5Grv7gM9ZyQ8GotAcu/T534YsRYPmiajhmvsoxI6
//BC/Mu37IfrXA2y3jwbgPRMX1PGccEGdLzV9fY8gysiKCULzMfYMyQTBtE3Tw0L
FeJZcJiULr4jLZQCtG+Ia/KLZXFaRRnav4721Ai9HTfpOf8ZDDvpAnkCABgfhlTk
v9nSyVJcn++IUjV2pe4tmcemb36RY4WXQPQNWSqP8Yd+B6Ci5+2w3pxnecabiH/Z
qJ7yTVHAriLg8FoardjzGnjYL5PX4q3EZqwgfBwjYZDp52ySJXY=
=vZf3
-----END PGP SIGNATURE-----

--g77yriyayozscbdx--

--===============2067205127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============2067205127==--

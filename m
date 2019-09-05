From: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V4] drm: Add LTTPR defines for DP 1.4a
Date: Thu, 5 Sep 2019 19:51:59 +0000
Message-ID: <20190905195156.3jay646drmdrw7bi@outlook.office365.com>
References: <20190904190116.klyt2rjg3svswmot@outlook.office365.com>
 <20190905172914.GN7482@intel.com>
 <bc61a7de-2183-cb28-65e0-3b7545fb556b@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0792320683=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bc61a7de-2183-cb28-65e0-3b7545fb556b-5C7GfCeVMHo@public.gmane.org>
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
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Berthe,
 Abdoulaye" <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============0792320683==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="niwzws3k25bof2su"

--niwzws3k25bof2su
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ville,

First of all, thank you very much for the review.

I added some comments below.

On 09/05, Wentland, Harry wrote:
> On 2019-09-05 1:29 p.m., Ville Syrj=E4l=E4 wrote:
> > On Wed, Sep 04, 2019 at 07:02:18PM +0000, Siqueira, Rodrigo wrote:
> >> DP 1.4a specification defines Link Training Tunable PHY Repeater (LTTP=
R)
> >=20
> > A bunch of this stuff was already in DP 1.3 so the statement here
> > (and in the comment) is a bit misleading.
> >=20
> > "LTTPR" is not a name that appears anywhere in the spec AFAICS, so
> > calling it that is a bit confusing.
> >=20

We are using "VESA DisplayPort (DP) Standard 1.4a" as a reference. We
double-checked the specification, and we found many occurrences of
LTTPR.

> >> which is required to add support for systems with Thunderbolt or other
> >> repeater devices.
> >=20
> > "required" seems a bit strong. IIRC by default these things should be in
> > transparent mode so the DPTX can remain blissfully unaware of their
> > presence.
> >=20

Just for adding some extra information:

LTTPR can work in two modes: non-transparent and transparent. In the
non-transparent mode we need to train each repeater in the link which
brings the benefit of better signal quality in contrast to the
transparent mode.
=20
> That's the idea but in reality things usually don't work out like this.
> I remember a couple years back debugging Thunderbolt and having it
> modify DPCD register reads on me and messing up link training with
> certain receivers.
>=20
> Either way, we've found that in order to receive a reliable
> implementation we need to make use of the LTTPR functionality.
>=20
> >>
> >> Changes since V3:
> >> - Replace spaces by tabs
> >> Changes since V2:
> >> - Drop the kernel-doc comment
> >> - Reorder LTTPR according to register offset
> >> Changes since V1:
> >> - Adjusts registers names to be aligned with spec and the rest of the
> >>   file
> >> - Update spec comment from 1.4 to 1.4a
> >>
> >> Cc: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
> >> Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> >> Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
> >> Cc: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >> Cc: Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >> Cc: Ville Syrj=E4l=E4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
> >> Signed-off-by: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
> >> Reviewed-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
> >> ---
> >>  include/drm/drm_dp_helper.h | 25 +++++++++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >>
> >> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> >> index 8364502f92cf..5abed96a1cb1 100644
> >> --- a/include/drm/drm_dp_helper.h
> >> +++ b/include/drm/drm_dp_helper.h
> >> @@ -966,6 +966,31 @@
> >>  #define DP_HDCP_2_2_REG_STREAM_TYPE_OFFSET	0x69494
> >>  #define DP_HDCP_2_2_REG_DBG_OFFSET		0x69518
> >> =20
> >> +/* Link Training (LT)-tunable Physical Repeaters - DP 1.4a */
> >=20
> > s/Physical/PHY/ to match the spec.
> >=20
> >> +#define DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV	0xf0000
> >> +#define DP_MAX_LINK_RATE_PHY_REPEATER				0xf0001
> >> +#define DP_PHY_REPEATER_CNT					0xf0002
> >> +#define DP_PHY_REPEATER_MODE					0xf0003
> >> +#define DP_MAX_LANE_COUNT_PHY_REPEATER				0xf0004
> >> +#define DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT			0xf0005
> >=20
> > The last two are DP 1.4a it seems.
> >=20
> > 0xf0004 was called Repeater_FEC_CAPABILITY in 1.4. But the spec doesn't
> > say anything about the DPCD revision so I have no idea how you're
> > supposed to decide which definition to use.
> >=20
> > DP 1.4a seems to have added FEC_CAPABILITY_PHY_REPEATER1 at 0xf0294.
> > To replace the 1.4 Repeater_FEC_CAPABILITY I suppose.
> >=20

Touch=E9! :)
Really good point, we have to check it.

For the next version, I'll add comments for showing if an address came
=66rom 1.4 or 1.4a. I'll also apply the other suggestions.

Thank you again!
=20
> This part confused me when I saw it in 1.4 and 1.4a. It's probably
> safest to go with the 1.4a definition.
>=20
> >> +#define DP_TRAINING_PATTERN_SET_PHY_REPEATER1			0xf0010
> >> +#define DP_TRAINING_LANE0_SET_PHY_REPEATER1			0xf0011
> >> +#define DP_TRAINING_LANE1_SET_PHY_REPEATER1			0xf0012
> >> +#define DP_TRAINING_LANE2_SET_PHY_REPEATER1			0xf0013
> >> +#define DP_TRAINING_LANE3_SET_PHY_REPEATER1			0xf0014
> >> +#define DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1		0xf0020
> >> +#define DP_TRANSMITTER_CAPABILITY_PHY_REPEATER1			0xf0021
> >=20
> > Above two are DP 1.4a.
> >=20
> >> +#define DP_LANE0_1_STATUS_PHY_REPEATER1				0xf0030
> >> +#define DP_LANE2_3_STATUS_PHY_REPEATER1				0xf0031
> >> +#define DP_LANE_ALIGN_STATUS_UPDATED_PHY_REPEATER1		0xf0032
> >> +#define DP_ADJUST_REQUEST_LANE0_1_PHY_REPEATER1			0xf0033
> >> +#define DP_ADJUST_REQUEST_LANE2_3_PHY_REPEATER1			0xf0034
> >> +#define DP_SYMBOL_ERROR_COUNT_LANE0_PHY_REPEATER1		0xf0035
> >> +#define DP_SYMBOL_ERROR_COUNT_LANE1_PHY_REPEATER1		0xf0037
> >> +#define DP_SYMBOL_ERROR_COUNT_LANE2_PHY_REPEATER1		0xf0039
> >> +#define DP_SYMBOL_ERROR_COUNT_LANE3_PHY_REPEATER1		0xf003b
> >> +#define DP_FEC_STATUS_PHY_REPEATER1				0xf0290
> >=20
> > This seems to have appared in DP 1.4.
> >=20
> > You skipped quite a few registers here. I guess those were deemed not
> > important?
> >=20
>=20
> They won't be used by us at the moment.
>=20
> Harry
>=20
> >> +
> >>  /* DP HDCP message start offsets in DPCD address space */
> >>  #define DP_HDCP_2_2_AKE_INIT_OFFSET		DP_HDCP_2_2_REG_RTX_OFFSET
> >>  #define DP_HDCP_2_2_AKE_SEND_CERT_OFFSET	DP_HDCP_2_2_REG_CERT_RX_OFFS=
ET
> >> --=20
> >> 2.23.0
> >=20
> >=20
> >=20

--=20
Rodrigo Siqueira
Software Engineer, Advanced Micro Devices (AMD)
https://siqueira.tech

--niwzws3k25bof2su
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl1xZ1sACgkQWJzP/com
vP9tEBAAtYwf4CW6nME6v76pVrJawoFVPMzJ+J+yM8BTmQ6BWPRcTXJdY/+KXoc6
5OLaCdKLkqdu0DIypKmzwGks2+l1QAeAj48EKGtr6Uxr0iz45QShX/lJN4YYt+FR
+cN5XnrMlPygn7rORRfx8PD7R1x2jFui87tT4Oh0J60E9OCeYDamcmfAj0el9tLW
dkoByR4FL6DDnCXzDbXoCknjmspxE449PsiykpntK3EVNgdJZIQv/SvW3ymRlY+F
wyrxccJ7nGldgKyOpXDKuGdJNFTFqwfZBQli5gDKzzciLcJqhsBOUkMdzHwJ/gKw
ypz+kNyGUJ67Kr0aPub0NxkBjWkQuSjs0tJMLcVabQA0TS5Q2f9G9ugb/Yto46mN
hQXDc1O7kE6lCjk8Jaz56DP1CngvfDZDxZEsKmkV1fhE+Wwwa/WlrMaqNSRUN1hn
28Yd/enL/zyqu23X99ewI5vXK+zOyQnGNHD5rgKneFpzPAXNRaRAq/gwu91zflfh
CSizMpcIBgLSWk0cQqIx9MVFqi+ojxfTpCuYR8hOJbVSW9ttNRWO+jqgwTa5jry+
VbxN8Gm8DkTJJy/mzaUOAwVLjnZ1V2PhXpjbVS37wbefEfu1TS8aG4PH4Y8NEzhN
JVAqRWqmOc/mTRA+1IMILA9E7GsLaLzqTed9lnj0FEHGujUr0HY=
=iTBu
-----END PGP SIGNATURE-----

--niwzws3k25bof2su--

--===============0792320683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0792320683==--

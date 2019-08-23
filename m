From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm: Add LTTPR defines for DP 1.4
Date: Fri, 23 Aug 2019 15:57:59 +0000
Message-ID: <8105f436-91af-3c63-7ada-a5800df43a52@amd.com>
References: <20190822224607.m73g3a2a23zww644@outlook.office365.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0184477755=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190822224607.m73g3a2a23zww644-1ViLX0X+lBJGNQ1M2rI3KwRV3xvJKrda@public.gmane.org>
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
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Berthe,
 Abdoulaye" <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============0184477755==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yhEycHOY5GvvroNbpg8nf0NFlrv4yNEqK"

--yhEycHOY5GvvroNbpg8nf0NFlrv4yNEqK
Content-Type: multipart/mixed; boundary="X0vQyaYXkRLW2m8P3gBnXegyFSiafsUNP";
 protected-headers="v1"
From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Berthe, Abdoulaye" <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>,
 "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>,
 "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>
Message-ID: <8105f436-91af-3c63-7ada-a5800df43a52-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm: Add LTTPR defines for DP 1.4
References: <20190822224607.m73g3a2a23zww644-1ViLX0X+lBJGNQ1M2rI3KwRV3xvJKrda@public.gmane.org>
In-Reply-To: <20190822224607.m73g3a2a23zww644-1ViLX0X+lBJGNQ1M2rI3KwRV3xvJKrda@public.gmane.org>

--X0vQyaYXkRLW2m8P3gBnXegyFSiafsUNP
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-08-22 6:46 p.m., Siqueira, Rodrigo wrote:
> DP 1.4 specification defines Link Training Tunable PHY Repeater (LTTPR)=

> which is required to add support for systems with Thunderbolt or other
> repeater devices.
>=20
> Cc: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
> Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
> ---
>  include/drm/drm_dp_helper.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 8364502f92cf..8336d960da7f 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -134,6 +134,32 @@
>  #define DP_SUPPORTED_LINK_RATES		    0x010 /* eDP 1.4 */
>  # define DP_MAX_SUPPORTED_RATES		     8	    /* 16-bit little-endian */=

> =20
> +/** Link Training (LT)-tunable Physical Repeaters - DP 1.4 **/
> +#define DP_LTTPR_REV                                  0xf0000
> +#define DP_LTTPR_MAX_LINK_RATE                        0xf0001
> +#define DP_LTTPR_REPEATER_CNT                         0xf0002
> +#define DP_LTTPR_REPEATER_MODE                        0xf0003
> +#define DP_LTTPR_MAX_LANE_CNT                         0xf0004
> +#define DP_LTTPR_EXTENDED_WAIT_TIMEOUT                0xf0005
> +#define DP_LTTPR_TRAINING_PATTERN_SET_REPEATER1       0xf0010
> +#define DP_LTTPR_TRAINING_LANE0_SET_REPEATER1         0xf0011
> +#define DP_LTTPR_TRAINING_LANE1_SET_REPEATER1         0xf0012
> +#define DP_LTTPR_TRAINING_LANE2_SET_REPEATER1         0xf0013
> +#define DP_LTTPR_TRAINING_LANE3_SET_REPEATER1         0xf0014

Can we align the register naming with the spec and to align with the
rest of this file?

The seem to take the form of DP_<name-from-spec>

E.g. call this one DP_TRAINING_LANE3_SET_PHY_REPEATER1

Same for all other registers.

Keeping the naming consistent makes it easier to search.

> +#define DP_LTTPR_TRAINING_AUX_RD_INTERVAL_REPEATER1   0xf0020
> +#define DP_LTTPR_TRANSMITTER_CAPABILITY_REPEATER1     0xf0021
> +#define DP_LTTPR_LANE0_1_STATUS_REPEATER1             0xf0030
> +#define DP_LTTPR_LANE2_3_STATUS_REPEATER1             0xf0031
> +#define DP_LTTPR_LANE_ALIGN_STATUS_UPDATED_REPEATER1  0xf0032
> +#define DP_LTTPR_ADJUST_REQUEST_LANE0_1_REPEATER1     0xf0033
> +#define DP_LTTPR_ADJUST_REQUEST_LANE2_3_REPEATER1     0xf0034
> +#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE0_REPEATER1   0xf0035
> +#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE1_REPEATER1   0xf0037
> +#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE2_REPEATER1   0xf0039
> +#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE3_REPEATER1   0xf003b
> +#define DP_REPEATER_CONFIGURATION_AND_STATUS_OFFSET   0x50

With a cursory search I can't seem to find this in the spec. Where is
this coming from?

Harry

> +#define DP_LTTPR_FEC_STATUS_REPEATER1                 0xf0290> +
>  /* Multiple stream transport */
>  #define DP_FAUX_CAP			    0x020   /* 1.2 */
>  # define DP_FAUX_CAP_1			    (1 << 0)
>=20


--X0vQyaYXkRLW2m8P3gBnXegyFSiafsUNP--

--yhEycHOY5GvvroNbpg8nf0NFlrv4yNEqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkiEcMSFhcOGNLtE6LVgVyYwUtuMFAl1gDQUACgkQLVgVyYwU
tuOqCQgAxuWo0QQCxMTKj0TSQagvX9ulxdI4GmKWgTGntzj0Ng1NvYlxzudOWrZH
Am47T4DTDLc7Miv5ZmMNUglzrwSfSm+8Hbx6koqlSnpqwgNiikLE7pexl7XwPQvx
tlc+3K2ftK789eSoBdfOBaTAgdQ3i4ZVCn9bRauxoY9fhFPvdApFYsvDo5Y6hXGC
HQXxgRg/Qcs4dwh+PO1sWqXiVuZEF5xHdLOFK+2Es/adMz/sM/SL4B+34BVPipuk
N48TheM7dPLiy/YxrU1WRt3PXnNYbx032bPL6wmflTlhhRLSvpdRZAGxr9pwGOFY
2vNQDt0ldC9fuksLCCJ4Li95w5RYWA==
=PVXp
-----END PGP SIGNATURE-----

--yhEycHOY5GvvroNbpg8nf0NFlrv4yNEqK--

--===============0184477755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0184477755==--

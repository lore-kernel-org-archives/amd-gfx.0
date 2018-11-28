From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 1/3] drm/connector: Add generic underscan properties
Date: Wed, 28 Nov 2018 09:17:07 -0800
Message-ID: <875zwh6s18.fsf@anholt.net>
References: <20181122112331.17735-1-boris.brezillon@bootlin.com>
 <20181122112331.17735-2-boris.brezillon@bootlin.com>
 <20181122173658.7gvnl3trkdhsqn3p@DESKTOP-E1NTVVP.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0290045825=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181122173658.7gvnl3trkdhsqn3p@DESKTOP-E1NTVVP.localdomain>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Brian Starkey <Brian.Starkey@arm.com>, Boris Brezillon <boris.brezillon@bootlin.com>
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, nd <nd@arm.com>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0290045825==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Brian Starkey <Brian.Starkey@arm.com> writes:

> Hi Boris,
>
> Just because I happened to read the docs in here, one typo below:
>
> On Thu, Nov 22, 2018 at 12:23:29PM +0100, Boris Brezillon wrote:
>>diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>>index c555e17ab8d7..170317248da6 100644
>>--- a/drivers/gpu/drm/drm_connector.c
>>+++ b/drivers/gpu/drm/drm_connector.c
>>@@ -971,6 +971,38 @@ DRM_ENUM_NAME_FN(drm_get_content_protection_name, drm_cp_enum_list)
>>  *	can also expose this property to external outputs, in which case they
>>  *	must support "None", which should be the default (since external screens
>>  *	have a built-in scaler).
>>+ *
>>+ * Connectors for non-analog outputs may also have standardized underscan
>>+ * properties (drivers can set this up by calling
>>+ * drm_connector_attach_content_protection_property() on initialization):
>
> Should be drm_connector_attach_underscan_properties()

Other than this typo, this series is:

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlv+zZMACgkQtdYpNtH8
nugbfQ//Uqeeq2iFesEUAtE76R436NzQuAZ220SpW+NuV7OzfZPU0HX9wwWygneS
uUkXlAlDuUatzFgLzoFtLczU2hLyz3czePW5foGzr6roDneZElT/HvANK/xfymO5
Gim+w1RocqAg3DEZb+pH2LLaqtJnu53DIVk0yQpMGCnL5it3n/lGmzxbA48ozETn
BOycujwUHvHfpSdmNlxQ0+GwBPaa2dEbxhwhApqdxIGk5JZECgndWZd7CYwxnY0x
uFr2y1AKfBf/7TJzTTcyQOBTC9+5M2iPTR8yJ6B3YOoP7VlTuGtF9is7ykW8UUi0
w+XgfSpN2Dti8eL0W65kNcHX/oVOzMkLIdAgfRlq7jC3F0OmlEy5tajPSRoYond4
xsBKsuhCDOpGOOhucRIn2ktHnL5AWMDc8hwU886eaaWSYJm83I6WTcWuG8YzDY3D
noxJsqnmJ2uVX5SgxSDon8Sv2mhcuGlqkr9O9+xuY0inV8sBPK2ccDmrBhYB/IId
54g3zsKIWwWY49MCwAzQ5rjyjixc5WKqCMJpwhKbw4By6vO8KMAO69JHG2ZPOPOQ
eiD31VlxqVD+DEsy/i8ALmyX6WdZRsnundHuKV4TVglKulPzclt47ATxXKZvuSKP
ohyF81zTofYM/wF6Tk4y9sh4VbAkhZoYt94HDQ1lUVEZ7qPIZjM=
=0Pgr
-----END PGP SIGNATURE-----
--=-=-=--

--===============0290045825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0290045825==--

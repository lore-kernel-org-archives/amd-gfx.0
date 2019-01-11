From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: BISECTED- amd-staging-drm-next, xorg-server segfault A6-6310 APU
 - R4 Mullins.
Date: Fri, 11 Jan 2019 16:27:44 +0100
Message-ID: <8033aaf7-2e86-9414-c68a-7b17e331f212@daenzer.net>
References: <3677766.FRf3LM2rx8@eclipse> <91019770.5DcfmtkFX1@eclipse>
 <641eb681-2952-19d9-5c74-01616a51c6ec@daenzer.net>
 <5741871.Z2MBXCYFqd@eclipse>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1489843483=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5741871.Z2MBXCYFqd@eclipse>
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
To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1489843483==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UWGDLaEvVUvSO7SAtZ2EJz9mpitfIBOYr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UWGDLaEvVUvSO7SAtZ2EJz9mpitfIBOYr
Content-Type: multipart/mixed; boundary="wC3BulcPkep0Yv6dkxSG85KVBeOJwsG3V";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <8033aaf7-2e86-9414-c68a-7b17e331f212-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: BISECTED- amd-staging-drm-next, xorg-server segfault A6-6310 APU
 - R4 Mullins.
References: <3677766.FRf3LM2rx8@eclipse> <91019770.5DcfmtkFX1@eclipse>
 <641eb681-2952-19d9-5c74-01616a51c6ec-otUistvHUpPR7s880joybQ@public.gmane.org>
 <5741871.Z2MBXCYFqd@eclipse>
In-Reply-To: <5741871.Z2MBXCYFqd@eclipse>

--wC3BulcPkep0Yv6dkxSG85KVBeOJwsG3V
Content-Type: multipart/mixed;
 boundary="------------A050D14EF95BD5C05EF426AC"
Content-Language: en-CA

This is a multi-part message in MIME format.
--------------A050D14EF95BD5C05EF426AC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2019-01-10 6:56 p.m., Przemek Socha wrote:
>
> [  147.846148] [drm:amdgpu_display_user_framebuffer_create [amdgpu]] In=
valid=20
> pitch: expecting 10752 but got 10624
> [  147.846155] [drm:drm_internal_framebuffer_create] could not create=20
> framebuffer"

Thanks, this confirms that the check is too strict. I've sent a patch
reverting this as well.


Yu, I like the idea behind your changes, but unfortunately it's more
complicated than that. If you want to work on similar checks which
accurately reflect the hardware constraints, people on the amd-gfx list
should be able to help with that.


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer

--------------A050D14EF95BD5C05EF426AC
Content-Type: text/x-patch;
 name="amdgpu_display_user_framebuffer_create-debug.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="amdgpu_display_user_framebuffer_create-debug.diff"

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
index 70a816dd8b4d..99b646c16311 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -537,8 +537,11 @@ amdgpu_display_user_framebuffer_create(struct drm_de=
vice *dev,
=20
 	pitch =3D amdgpu_align_pitch(adev, pitch, cpp, false);
 	if (mode_cmd->pitches[0] !=3D pitch) {
-		DRM_DEBUG_KMS("Invalid pitch: expecting %d but got %d\n",
-			      pitch, mode_cmd->pitches[0]);
+		struct drm_format_name_buf format_name;
+
+		DRM_ERROR("Invalid pitch: expecting %d but got %d, format %s =3D> cpp=3D=
%d\n",
+			  pitch, mode_cmd->pitches[0],
+			  drm_get_format_name(mode_cmd->pixel_format, &format_name), cpp);
 		return ERR_PTR(-EINVAL);
 	}
=20

--------------A050D14EF95BD5C05EF426AC--

--wC3BulcPkep0Yv6dkxSG85KVBeOJwsG3V--

--UWGDLaEvVUvSO7SAtZ2EJz9mpitfIBOYr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCXDi18AAKCRBaga+Oatuy
AAOxAKCrkfgKPbxO9ULg298S3wnQJEU1OQCfaSD4zWte25hqQf2+01h9+rNbQZw=
=ap/2
-----END PGP SIGNATURE-----

--UWGDLaEvVUvSO7SAtZ2EJz9mpitfIBOYr--

--===============1489843483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1489843483==--

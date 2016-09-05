From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/radeon: handle runtime pm in fbcon (v2)
Date: Mon, 5 Sep 2016 16:48:22 +0900
Message-ID: <8c679d0c-f33b-47c9-3c21-56103793aaa9@daenzer.net>
References: <1472829513-4539-1-git-send-email-alexander.deucher@amd.com>
 <1472829513-4539-2-git-send-email-alexander.deucher@amd.com>
 <19ade2e9-3fd5-a614-6ec8-a07147444ab1@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1128471676=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <19ade2e9-3fd5-a614-6ec8-a07147444ab1-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1128471676==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vFlJceCwu5CaSA7Ixl2lfe6CU9SW7QoDh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vFlJceCwu5CaSA7Ixl2lfe6CU9SW7QoDh
Content-Type: multipart/mixed; boundary="VaLkEFOSHJxt9olFS70KAaNF5GQetxwmf"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>,
 Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <8c679d0c-f33b-47c9-3c21-56103793aaa9-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/radeon: handle runtime pm in fbcon (v2)
References: <1472829513-4539-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
 <1472829513-4539-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
 <19ade2e9-3fd5-a614-6ec8-a07147444ab1-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
In-Reply-To: <19ade2e9-3fd5-a614-6ec8-a07147444ab1-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

--VaLkEFOSHJxt9olFS70KAaNF5GQetxwmf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/09/16 02:07 PM, Edward O'Callaghan wrote:
> On 09/03/2016 01:18 AM, Alex Deucher wrote:
>> Ported from nouveau.
>>
>> v2: re-enable runtime autosuspend in the error case
>>
>> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

[...]

>> @@ -47,8 +48,35 @@ struct radeon_fbdev {
>>  	struct radeon_device *rdev;
>>  };
>> =20
>> +static int
>> +radeonfb_open(struct fb_info *info, int user)
>> +{
>> +	struct radeon_fbdev *rfbdev =3D info->par;
>> +	struct radeon_device *rdev =3D rfbdev->rdev;
>> +	int ret =3D pm_runtime_get_sync(rdev->ddev->dev);
>> +	if (ret < 0 && ret !=3D -EACCES) {
>> +		pm_runtime_mark_last_busy(rdev->ddev->dev);
>> +		pm_runtime_put_autosuspend(rdev->ddev->dev);
>> +		return ret;
>> +	}
>> +	return 0;
>=20
> Hi Alex,
>=20
> Minor question - in the case of (ret =3D=3D -EACCES) is that still rega=
rded
> as successful in the context of radeonfb_open()'s call?

Yes, it is. Both patches are

Reviewed-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--VaLkEFOSHJxt9olFS70KAaNF5GQetxwmf--

--vFlJceCwu5CaSA7Ixl2lfe6CU9SW7QoDh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAlfNI0oACgkQWoGvjmrbsgCd2gCgmY6hFzrJWXYgkOXT26qlxXD/
zIEAn1SAAAWX4K8MWraNnd2UpdSYgTjO
=QbLK
-----END PGP SIGNATURE-----

--vFlJceCwu5CaSA7Ixl2lfe6CU9SW7QoDh--

--===============1128471676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1128471676==--

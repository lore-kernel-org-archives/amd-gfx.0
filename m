From: Edward O'Callaghan <funfunctor@folklore1984.net>
Subject: Re: [PATCH] drm/amd/amdgpu: fix spelling mistake: "comleted" ->
 "completed"
Date: Fri, 30 Dec 2016 14:52:51 +1100
Message-ID: <3c0d4123-8859-8b10-3219-8f0e8b1c6f12@folklore1984.net>
References: <20161229154709.21700-1-colin.king@canonical.com>
 <SN1PR12MB0637F50C4488915FC3FFBA36B46A0@SN1PR12MB0637.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="haq1g2v2kgatfVkgXt4OnjLgEAMGWQwHa"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SN1PR12MB0637F50C4488915FC3FFBA36B46A0@SN1PR12MB0637.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, Colin King <colin.king@canonical.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, David Airlie <airlied@linux.ie>, "StDenis, Tom" <Tom.StDenis@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--haq1g2v2kgatfVkgXt4OnjLgEAMGWQwHa
Content-Type: multipart/mixed; boundary="NCTLxshoV1DB2on53k7GhRdcItPHDCJRG";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor@folklore1984.net>
To: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
 Colin King <colin.king@canonical.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@linux.ie>, "StDenis, Tom" <Tom.StDenis@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Message-ID: <3c0d4123-8859-8b10-3219-8f0e8b1c6f12@folklore1984.net>
Subject: Re: [PATCH] drm/amd/amdgpu: fix spelling mistake: "comleted" ->
 "completed"
References: <20161229154709.21700-1-colin.king@canonical.com>
 <SN1PR12MB0637F50C4488915FC3FFBA36B46A0@SN1PR12MB0637.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB0637F50C4488915FC3FFBA36B46A0@SN1PR12MB0637.namprd12.prod.outlook.com>

--NCTLxshoV1DB2on53k7GhRdcItPHDCJRG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor@folklore1984.net>

On 12/30/2016 12:39 PM, Zhou, David(ChunMing) wrote:
> +amd-gfx, patch is Reviewed-by: Chunming Zhou <david1.zhou@amd.com>
>=20
> -----Original Message-----
> From: Colin King [mailto:colin.king@canonical.com]=20
> Sent: Thursday, December 29, 2016 11:47 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <=
Christian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Zhou, David(C=
hunMing) <David1.Zhou@amd.com>; StDenis, Tom <Tom.StDenis@amd.com>; Liu, =
Monk <Monk.Liu@amd.com>; dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] drm/amd/amdgpu: fix spelling mistake: "comleted" -> "c=
ompleted"
>=20
> From: Colin Ian King <colin.king@canonical.com>
>=20
> trivial fix to spelling mistake in WARN message
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index 60bd4af..9ca3167 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2335,7 +2335,7 @@ int amdgpu_gpu_reset(struct amdgpu_device *adev)
>  				if (fence) {
>  					r =3D dma_fence_wait(fence, false);
>  					if (r) {
> -						WARN(r, "recovery from shadow isn't comleted\n");
> +						WARN(r, "recovery from shadow isn't completed\n");
>  						break;
>  					}
>  				}
> @@ -2347,7 +2347,7 @@ int amdgpu_gpu_reset(struct amdgpu_device *adev)
>  			if (fence) {
>  				r =3D dma_fence_wait(fence, false);
>  				if (r)
> -					WARN(r, "recovery from shadow isn't comleted\n");
> +					WARN(r, "recovery from shadow isn't completed\n");
>  			}
>  			dma_fence_put(fence);
>  		}
>=20


--NCTLxshoV1DB2on53k7GhRdcItPHDCJRG--

--haq1g2v2kgatfVkgXt4OnjLgEAMGWQwHa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYZdoWAAoJEP4bvbfZuWjb0MwP/1sjt++I2TipXirziaXb5euY
kuqVbFx7YbA7BEtIGP6o2zaI7IgQtr1YZMshOjrOJu/aS+STUW/YPFtF3NN02TC4
ZlG4/p1xu5IZ1z++QG/P6QVL4yxuZOUDCgEosajS1zjvVMuiBGa4j6ZIiJuOvZLe
dqiU7LMWD+vZgXowG+kNVX53RBYK4W5ZihqtX6jE8XDcuhvZEP9o3ljrxuntBSas
1sW4vb4+Ki4z/JOjPySSBaT8Ni/WyvNapRBnBW8jxN/3Ti273xkJEB1uDFfI3YIA
ltnsPZWUwp6JB/v8JvW1FluSCOC7+wEPZDfCbPjGGDqXPRldiOYgIdQs4b9KitUH
MpxoXJLDBQhfzKzevA8WH6mxRzKNFOQ24Fli6KWVVCJLV3Xq1FILCa/uV8afF/Sf
KCQ1jjELGOv7ODYBYCKHBZvdpG424BCQhRR0OqGDc/QJB9l6KHem6hK4Iqbn+MSQ
1/tLpOBJg4dw4YupALDKZOjx0qBgr3Oi4RffxLDhK9nk3L9FUH0Ab36oGGGGDzjv
IKplNeADziE14CfcpdpOxjRAUMcGJIssPTLOOEPOzCmb2d1ISk0inGRoJfjcBNhT
mjiB2kYKnWM2MX2gWHjmz2b2aqSynWGENCgHmkvVV80I4HdsBICcRbzc2K0Ljg84
E8wnuL+kjvlGelXhH1kp
=lwIG
-----END PGP SIGNATURE-----

--haq1g2v2kgatfVkgXt4OnjLgEAMGWQwHa--

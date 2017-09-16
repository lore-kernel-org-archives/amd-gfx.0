From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH 03/11] drm/amdkfd: Rectify the jiffies calculation error
 with milliseconds
Date: Fri, 15 Sep 2017 20:09:04 -0400
Message-ID: <1505520544.24699.47.camel@rutgers.edu>
References: <1505518982-29631-1-git-send-email-Felix.Kuehling@amd.com>
 <1505518982-29631-4-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1088701293=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505518982-29631-4-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>


--===============1088701293==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-XfmM2DXm3U9S4JSI6/KO"


--=-XfmM2DXm3U9S4JSI6/KO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2017-09-15 at 19:42 -0400, Felix Kuehling wrote:
> From: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>
>=20
> The timeout in milliseconds should not be regarded as jiffies. This
> commit fixed that.
>=20
> Signed-off-by: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 5db82b8..3db6a31 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -835,12 +835,14 @@ static int create_queue_cpsch(struct device_queue_m=
anager *dqm, struct queue *q,
> =20
>  int amdkfd_fence_wait_timeout(unsigned int *fence_addr,
>  				unsigned int fence_value,
> -				unsigned long timeout)
> +				unsigned long timeout_ms)
>  {
> -	timeout +=3D jiffies;
> +	unsigned long end_jiffies;
> +
> +	end_jiffies =3D (timeout_ms * HZ / 1000) + jiffies;

msecs_to_jiffies? (jiffies.h)

Jan

> =20
>  	while (*fence_addr !=3D fence_value) {
> -		if (time_after(jiffies, timeout)) {
> +		if (time_after(jiffies, end_jiffies)) {
>  			pr_err("qcm fence wait loop timeout expired\n");
>  			return -ETIME;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index ef582cc..f8d6a8e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -669,7 +669,7 @@ struct kernel_queue *pqm_get_kernel_queue(struct proc=
ess_queue_manager *pqm,
> =20
>  int amdkfd_fence_wait_timeout(unsigned int *fence_addr,
>  				unsigned int fence_value,
> -				unsigned long timeout);
> +				unsigned long timeout_ms);
> =20
>  /* Packet Manager */
> =20

--=-XfmM2DXm3U9S4JSI6/KO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjGgSoFJq63cCYGKvY+M/tz9IsiAFAlm8a6EACgkQY+M/tz9I
siC5uw/+M9C27M8XKo5saooUAnixgtSGmmf0/LhPckwhbwmoJ2URqPK9QqaN5v5t
I+JxrkBXmsFh84+sXY3ugXoXdXhiN6L/nD5xHFRwo1/HpBTNHGNu7Rr+7emo2vtH
8d/3bV4JCbjYKmrU1qXNobwnfAUYYhcn7JMBqE7IABmQjxVXXo8VIDAAk83v/kV/
GFWCTT07T7fKp95JZnynSIvT2IyB517/D/9JDsfo1KiKkxumCQ3Vu/M8Jo76FUlP
cCu1WbgijJNvGr1ZqEbiqWX6+oT5RBK7AjozaZJXJ2eE+aWTdnPYD8bQ2rb7AhD/
uatydYPbplbSgiGu5NPwMV7ivbJDVJEfs5ysJf6o0Xj1rH9uLM0AkCoxEkLNw1qF
YO+jTmFkyvBDxqeMX0rIApJnAkLXk2EQqxRYEhT51bEHf1JVeLQYMdIKwmUJVDq3
rSvXTXwe2KkSur0dMzFnGKyUmMQO9uva9eJsWGEkcLK9Eu2hKhSnMky3oTmJsslf
7VwRbj6SeyCMTX3nouZTOlJfzIwr2xAN2SrS2oJ+9MItBJqBT+TrVtH1398SaKoM
GR+sTfernD5v9ANgpaWXdC0dKEuAfN98Gn7tBgkMgb2NKtG7v23Z+vFPFVRAP8In
SYuF/k79YO6E+Pj4P6RWu/U3qTyH027t5peIgwcA98/hWyuPtyM=
=v75Z
-----END PGP SIGNATURE-----

--=-XfmM2DXm3U9S4JSI6/KO--


--===============1088701293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1088701293==--

From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH libdrm 1/1] amdgpu: Take lock before removing devices
 from fd_tab hash table.
Date: Thu, 17 May 2018 20:47:41 -0400
Message-ID: <6c678d3b067b7469fc4eb760bce8fb29f8456f77.camel@rutgers.edu>
References: <20180510233316.21437-1-jan.vesely@rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1755668675=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180510233316.21437-1-jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org


--===============1755668675==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-1nuYnL3S/RTIGzA9D4Ky"


--=-1nuYnL3S/RTIGzA9D4Ky
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-05-10 at 19:33 -0400, Jan Vesely wrote:
> Close the file descriptors under lock as well.
>=20
> Signed-off-by: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
> ---
>  amdgpu/amdgpu_device.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/amdgpu/amdgpu_device.c b/amdgpu/amdgpu_device.c
> index 983b19ab..f71fc050 100644
> --- a/amdgpu/amdgpu_device.c
> +++ b/amdgpu/amdgpu_device.c
> @@ -126,6 +126,13 @@ static int amdgpu_get_auth(int fd, int *auth)
> =20
>  static void amdgpu_device_free_internal(amdgpu_device_handle dev)
>  {
> +	pthread_mutex_lock(&fd_mutex);
> +	close(dev->fd);
> +	if ((dev->flink_fd >=3D 0) && (dev->fd !=3D dev->flink_fd))
> +		close(dev->flink_fd);
> +	util_hash_table_remove(fd_tab, UINT_TO_PTR(dev->fd));
> +	pthread_mutex_unlock(&fd_mutex);
> +
>  	amdgpu_vamgr_deinit(&dev->vamgr_32);
>  	amdgpu_vamgr_deinit(&dev->vamgr);
>  	amdgpu_vamgr_deinit(&dev->vamgr_high_32);
> @@ -133,10 +140,6 @@ static void amdgpu_device_free_internal(amdgpu_devic=
e_handle dev)
>  	util_hash_table_destroy(dev->bo_flink_names);
>  	util_hash_table_destroy(dev->bo_handles);
>  	pthread_mutex_destroy(&dev->bo_table_mutex);
> -	util_hash_table_remove(fd_tab, UINT_TO_PTR(dev->fd));
> -	close(dev->fd);
> -	if ((dev->flink_fd >=3D 0) && (dev->fd !=3D dev->flink_fd))
> -		close(dev->flink_fd);
>  	free(dev->marketing_name);
>  	free(dev);
>  }
ping.

Jan
--=-1nuYnL3S/RTIGzA9D4Ky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE24EFFD7zPJCEhhd3ruXbdUjrWUwFAlr+Iq0ACgkQruXbdUjr
WUxycAf8CU7/2O7KyYmRLU5C2F1NTaWLipZ446nigGS9XA3La7P40kLlbzUtmcT7
qqXHV8QbBSOGd8a9nNCOfzWVyZfmXqhGzApZ/1oVWcMB01xPCgmIwS1yMMt2CajQ
8eAwX5PyqjdeJ+NG6lj1fMVU2u+cbdxqKgv+1nz6gn20jUxBjlac9+yf60ixuQVY
yxyiSwelD0O/AXpUXsE018GZGQs7Pd2ExXUc7W69Yy2eL9BQ4vZ6eaFXBr0WsugO
Z7wtsETAL67avx/2PKQQGqwHKNs9Yw7yR82D8dB0g+xIBfMEvixTEopgyrzhynhm
MH5ign5xLJ5V78TpkIFo4QwmM805XA==
=MHfs
-----END PGP SIGNATURE-----

--=-1nuYnL3S/RTIGzA9D4Ky--


--===============1755668675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1755668675==--

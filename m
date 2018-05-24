From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH libdrm 3/3] amdgpu: Destroy fd_hash table when the last
 device is removed.
Date: Thu, 24 May 2018 13:04:43 -0400
Message-ID: <76e9b86b42d5965765d5a5b94b5b0412df0e096a.camel@rutgers.edu>
References: <20180518170007.2847-1-jan.vesely@rutgers.edu>
 <20180518170007.2847-3-jan.vesely@rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1799974861=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180518170007.2847-3-jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org


--===============1799974861==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-M3vXOmzUtT8ZZ+5eLb4J"


--=-M3vXOmzUtT8ZZ+5eLb4J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-05-18 at 13:00 -0400, Jan Vesely wrote:
> Fixes memory leak on module unload.
> Analogous to mesa commit of the same name.
> Signed-off-by: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
> ---
>  amdgpu/amdgpu_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/amdgpu/amdgpu_device.c b/amdgpu/amdgpu_device.c
> index e23dd3b3..34ac95b8 100644
> --- a/amdgpu/amdgpu_device.c
> +++ b/amdgpu/amdgpu_device.c
> @@ -128,6 +128,10 @@ static void amdgpu_device_free_internal(amdgpu_devic=
e_handle dev)
>  {
>  	pthread_mutex_lock(&fd_mutex);
>  	util_hash_table_remove(fd_tab, UINT_TO_PTR(dev->fd));
> +	if (util_hash_table_count(fd_tab) =3D=3D 0) {
> +		util_hash_table_destroy(fd_tab);
> +		fd_tab =3D NULL;
> +	}
>  	close(dev->fd);
>  	if ((dev->flink_fd >=3D 0) && (dev->fd !=3D dev->flink_fd))
>  		close(dev->flink_fd);

gentle ping.

Jan
--=-M3vXOmzUtT8ZZ+5eLb4J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE24EFFD7zPJCEhhd3ruXbdUjrWUwFAlsG8KsACgkQruXbdUjr
WUy/hQf/bivNVl3dYLN97Mv7b0c2nqYga49r+2X9auz+muREmPPTjQfkbUJvYEkf
kRQFw4UI1u6CZf1A09qBbR2iBWJP4kPrzO1zCyF4nCCf2hXrsgqjynYKlvo176f1
5vyUTxdCte1URxe8cCX0EI52fZHCsGK0sXnkkHK19OxBjiWxWr5SkGLbcPGMfUix
+mnkKZqAGd/FC+m1pwnWCI1q5UuIW1D0UBUxIcn9klpcHm3Z394/kaDP4xqseWID
AJstJgYiNfXZsUNrAOYQOTb9591Ctd8VAeZNGeGpmuLV7NhvgolwpGy8WuzJQd5F
K84kPnUkVjFv7yypXynfmk6xzw/Cbg==
=nwdx
-----END PGP SIGNATURE-----

--=-M3vXOmzUtT8ZZ+5eLb4J--


--===============1799974861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1799974861==--

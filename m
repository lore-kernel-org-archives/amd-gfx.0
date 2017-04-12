From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Prevent reading sensors far too quickly.
Date: Thu, 13 Apr 2017 00:13:41 +1000
Message-ID: <74c4dff8-cdc1-a3a8-0f29-6e0537dfd0a8@folklore1984.net>
References: <20170412131044.8556-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1753472995=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170412131044.8556-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1753472995==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pUKb1lQoeWGWFiWHgNxWtLr0nrG9sqe3D"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pUKb1lQoeWGWFiWHgNxWtLr0nrG9sqe3D
Content-Type: multipart/mixed; boundary="BheDqhnMpm9dPwVoPE5sfe62uKMor75Xh";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <74c4dff8-cdc1-a3a8-0f29-6e0537dfd0a8-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Prevent reading sensors far too quickly.
References: <20170412131044.8556-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170412131044.8556-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--BheDqhnMpm9dPwVoPE5sfe62uKMor75Xh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 04/12/2017 11:10 PM, Tom St Denis wrote:
> On platforms without GPU_POWER sensors the thread reading sensors would=
 proceed
> far too quickly.  So it is now rate limited to 50Hz to be consistent.
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  src/app/top.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/app/top.c b/src/app/top.c
> index 96e33ff2e1da..364180eb70f6 100644
> --- a/src/app/top.c
> +++ b/src/app/top.c
> @@ -293,18 +293,24 @@ static volatile struct umr_bitfield *sensor_bits =
=3D NULL;
>  static void *gpu_sensor_thread(void *data)
>  {
>  	struct umr_asic asic =3D *((struct umr_asic*)data);
> -	int size, rem, off, x;
> +	int size, rem, off, x, power;
>  	char fname[128];
> +	struct timespec ts;
> +
> +	ts.tv_sec =3D 0;
> +	ts.tv_nsec =3D 1000000000UL / 50; // limit to 50Hz
> =20
>  	snprintf(fname, sizeof(fname)-1, "/sys/kernel/debug/dri/%d/amdgpu_sen=
sors", asic.instance);
>  	asic.fd.sensors =3D open(fname, O_RDWR);
>  	while (!sensor_thread_quit) {
>  		rem =3D sizeof gpu_power_data;
>  		off =3D 0;
> +		power =3D 0;
>  		for (x =3D 0; sensor_bits[x].regname; ) {
>  			switch (sensor_bits[x].start) {
>  				case AMDGPU_PP_SENSOR_GPU_POWER:
>  					size =3D 16;
> +					power =3D 1;
>  					break;
>  				default:
>  					size =3D 4;
> @@ -316,6 +322,10 @@ static void *gpu_sensor_thread(void *data)
>  			rem -=3D size;
>  			x   +=3D size / 4;
>  		}
> +
> +		// sleep for 20ms if no GPU power sensor to rate limit things a bit
> +		if (!power)
> +			nanosleep(&ts, NULL);
>  	}
>  	close(asic.fd.sensors);
>  	return NULL;
>=20


--BheDqhnMpm9dPwVoPE5sfe62uKMor75Xh--

--pUKb1lQoeWGWFiWHgNxWtLr0nrG9sqe3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7jYaAAoJEP4bvbfZuWjb2aMP/2XDJ9DA9CCm34yZMXHsq+Ob
EPPv/IUjWc+CcCsOLEs47TtwIL3N+dWTwaaj4sxksXfm2ya6GM9w7x0fs+JJPfGb
TG5X0+4bvWuiNh58T7EYfD+gJaNYlm3mrhgbfN7pWuI3diELdlgYtWyZZHaMN+kU
nDLdMncbBsZyImTNDjjvh9o1FPrzFuSWM7aXjGjRCMJXVfnZMxSLKUUGHXGFq3V/
4qk9HpAF5M4Z49uNaBo0CA/wlju3/JLDOgYOb12EDGy9WWzQTkj+Vj1Dn06Fdh6M
sVIHP6wCntahNPBP7sOGeyCS3kxROcRT5TYuYg+C9zNtwnQMsfD3mK5cpkkVqm5F
RtNlkkVU0wthZ9FODwxwLVH8iHnnmdH6+xiyF027J83gvHZnUHbpiTmv2iWzPi0F
etVwVMrz3RqtD+kMXX0Yqy22wxeR9hEDdjiVXTf8q4LquRi64eVArHpIA1Lgxfy0
LJGoGr0qAiAbUT3jQuYdvqlTpVIU4qLoIMXoJ7/pfZq80e9dwKgJvPAvBEoBEOAo
tQtJ/R28ExXyZCN1IW3mzU3z/8j4QFq6ve74NrCr5UD40CEtTWgFLglDJCvi90h/
wgmFcVs28IgRTf9cSK07ogZIPJStHpuUYXj+NQiLA7V33zcGlkNkQTNshIMtfo3j
gt/eiLRM975pYWN7Iz5O
=E9nJ
-----END PGP SIGNATURE-----

--pUKb1lQoeWGWFiWHgNxWtLr0nrG9sqe3D--

--===============1753472995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1753472995==--

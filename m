From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/3] dma-buf: add dma_fence_get_stub
Date: Mon, 03 Dec 2018 08:08:40 -0800
Message-ID: <878t16fv93.fsf@anholt.net>
References: <20181203130759.10226-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1693703308=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181203130759.10226-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: Christian =?utf-8?Q?K=C3=B6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1693703308==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian K=C3=B6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> Extract of useful code from the timeline work. This provides a function
> to return a stub or dummy fence which is always signaled.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/dma-buf/dma-fence.c | 36 +++++++++++++++++++++++++++++++++++-
>  include/linux/dma-fence.h   |  1 +
>  2 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 1551ca7df394..136ec04d683f 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c

>  /*
>   * fence context counter: each execution context should have its own
>   * fence context, this allows checking if fences belong to the same
>   * context or not. One device can have multiple separate contexts,
>   * and they're used if some engine can run independently of another.
>   */
> -static atomic64_t dma_fence_context_counter =3D ATOMIC64_INIT(0);
> +static atomic64_t dma_fence_context_counter =3D ATOMIC64_INIT(1);

What's this change for?  I don't see a context allocation in patch #2
where the stub fence is being moved from, so this seems out of place.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwFVQgACgkQtdYpNtH8
nuhnQA//Svq3nDanzVIalLgcfnvg5tboWMKxEuGNT2rOZ8QJ8HzzIyRdNKoyizvN
1eKrdr8SiVPJmMKiG5TI7TU7nFzPEETWnfp+RM4uzzFEc5JPgGo3o2ow4EYraR8e
aIwhZmHoS5RKpTEpUtWJlaEb3uCKuM/p+nEEd7ZbMeFvU1QwxGI0fXr9Vw1h3nla
X37co+2Kl0uNIlxAC+Uv7WTWQYuIXCWftN6f6j4T60EZhXYjmJSj6a/m3VDQrAq8
8jom4iRMy5E5MvA7Y5vOaMe+9Z6XzcWQ3ygQuaBAq+RcPstJLEelFYRtRQN8xgs5
ktSw8cbb2Aw++mgY0TG0+IGxDGm+al+Cwaj6aZrrzG+vxD66Jiya0+2LAdaeM69g
0OIYDbV6bPV60LkSiXWr5iZQBYbgpX1bw2C/xUoW7ROgSbNbV/zdsBlv/FORFL8s
zYvxYD1PRdWCD6psRk5lNscBPDgSjiALRKq6xL64Inw3V3zDJ+GmwlTCcLfJeLpL
LRvrotCkT5xM1xRIVGFZ077JpQQMPQr1foXYUTVfYLh4kRSyIWJvCYyHDbUUbVL3
qG9clPS17JTzjtt4c7MWPdO9QAuPuged6KxbbRG+VCVN1QEqBVRM4Cw9Pa3sBrAt
lwGcN6rLVZTSYU8HwKhafVpD55fWiUDNX+J/T0IyWf44rPV8TIE=
=LsyZ
-----END PGP SIGNATURE-----
--=-=-=--

--===============1693703308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1693703308==--

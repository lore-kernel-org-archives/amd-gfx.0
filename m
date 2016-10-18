From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/3] x86/pat: export io memory reserve/free api.
Date: Tue, 18 Oct 2016 18:22:51 +1100
Message-ID: <d5dcf484-d760-8fe6-bc00-4d6db3ef9d05@folklore1984.net>
References: <1476771193-2759-1-git-send-email-airlied@gmail.com>
 <1476771193-2759-2-git-send-email-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0808570027=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1476771193-2759-2-git-send-email-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0808570027==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oKxsOSMI1KPTRESeGDh71Ss7r5MmPsjf7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oKxsOSMI1KPTRESeGDh71Ss7r5MmPsjf7
Content-Type: multipart/mixed; boundary="jX1Am56n4JjVns7ovojd2MneFkHIFhw4B";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org
Message-ID: <d5dcf484-d760-8fe6-bc00-4d6db3ef9d05-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/3] x86/pat: export io memory reserve/free api.
References: <1476771193-2759-1-git-send-email-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <1476771193-2759-2-git-send-email-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <1476771193-2759-2-git-send-email-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--jX1Am56n4JjVns7ovojd2MneFkHIFhw4B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

NACK,

I think you want to use 'iomap_create_wc()' instead to avoid aliasing.

Kind Regards,
Edward.

On 10/18/2016 05:13 PM, Dave Airlie wrote:
> From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>=20
> These functions are needed for gpu/ttm drivers to reserve the
> VRAM area as write combined. In a lot of places we don't ioremap
> but still need to insert pfn from it into a VMA using vm_insert_mixed,
> but a recent change in mixed insertion means we need to reserve
> VRAM as WC upfront, so we need these APIs exported.
>=20
> Signed-off-by: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/x86/mm/pat.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
> index 170cc4f..5ce2fbb 100644
> --- a/arch/x86/mm/pat.c
> +++ b/arch/x86/mm/pat.c
> @@ -719,6 +719,7 @@ out_free:
>  out_err:
>  	return ret;
>  }
> +EXPORT_SYMBOL(io_reserve_memtype);
> =20
>  /**
>   * io_free_memtype - Release a memory type mapping for a region of mem=
ory
> @@ -729,6 +730,7 @@ void io_free_memtype(resource_size_t start, resourc=
e_size_t end)
>  {
>  	free_memtype(start, end);
>  }
> +EXPORT_SYMBOL(io_free_memtype);
> =20
>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				unsigned long size, pgprot_t vma_prot)
>=20


--jX1Am56n4JjVns7ovojd2MneFkHIFhw4B--

--oKxsOSMI1KPTRESeGDh71Ss7r5MmPsjf7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYBc3LAAoJEP4bvbfZuWjbWCwP/2n3KC0fvXhB03MG6krTn/ui
oaOyN3K3oTTzzPwfqpTge0JNpSJbHlTRhtbtCG8dqz0EICefd9n5g3xv/HOhvrPq
l2saHtXSXH+0uHquh/VMKTDgxQ96wy2rnPQGgBl4hBVy9Kk2zJSRldYzo2IgdBff
rUPbVeRusY0XCrzndY5GMnSrexURP9I/cwGkq0qIpm1mq0tj/MygkY9hgqTWidUj
XLYa5M1GTfVNVuDB/iBvLRDH3P0NOorL0uFAFBRELyrZ7mi1rdU+2sC3INq1Hfmg
Q6/ep70kZKPHPk2aWn2r6ke7gf6qt4777AhDE2MxvH7k/2MzNnlLZCOTXuGBgcJ4
xLZXJ5hd/EHHO7as8zhwZLq9GpaDxkF8Qar42NA/axjqzLIgapgbSyIZDwMo71KE
zfKK4r2e7mU9Yx7Y8Z2F2Sp3+nnXM91AIDnKn5vJl0KKQIVrm1uYW5aHcq1ThlWf
HH8ri55lAR7ihyIz6ocjM3lFyM4GFyAh/bG+9wFs5N5CAf31xwvfHkOdyditoP1O
n++hO38E0IP/uiHZBPvQKOYSjHSzPdSAydim+AxIjmqWKr6oAstdX5igjDvz4VPo
jY8wpVDlq4UzrGSnFOnrgYOV6Db11ui0TocJcf+ftJHOstF5Brc9X8NqsiOZLQFM
VfrTNhLZPNidTKu/9wmD
=gCby
-----END PGP SIGNATURE-----

--oKxsOSMI1KPTRESeGDh71Ss7r5MmPsjf7--

--===============0808570027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0808570027==--

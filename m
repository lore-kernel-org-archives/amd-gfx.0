From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/3] x86/pat: export io memory reserve/free api.
Date: Tue, 18 Oct 2016 23:31:23 +1100
Message-ID: <5af7094b-3b04-b8af-b267-5cdd160a3991@folklore1984.net>
References: <1476771193-2759-1-git-send-email-airlied@gmail.com>
 <1476771193-2759-2-git-send-email-airlied@gmail.com>
 <d5dcf484-d760-8fe6-bc00-4d6db3ef9d05@folklore1984.net>
 <CAPM=9tx2iBaHt-bg_WjUHE3wPprs2GvNt1LZNLngF-GLH2U_Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0847614388=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9tx2iBaHt-bg_WjUHE3wPprs2GvNt1LZNLngF-GLH2U_Zw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0847614388==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Hl8R22i0DFfRPoGqeQ1rAnabTS4pmclEV"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hl8R22i0DFfRPoGqeQ1rAnabTS4pmclEV
Content-Type: multipart/mixed; boundary="sbiXXIkhUMbsC50QnHjM8iEbEcIcswU3A";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
 dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <5af7094b-3b04-b8af-b267-5cdd160a3991-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/3] x86/pat: export io memory reserve/free api.
References: <1476771193-2759-1-git-send-email-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <1476771193-2759-2-git-send-email-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <d5dcf484-d760-8fe6-bc00-4d6db3ef9d05-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <CAPM=9tx2iBaHt-bg_WjUHE3wPprs2GvNt1LZNLngF-GLH2U_Zw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CAPM=9tx2iBaHt-bg_WjUHE3wPprs2GvNt1LZNLngF-GLH2U_Zw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--sbiXXIkhUMbsC50QnHjM8iEbEcIcswU3A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/18/2016 07:29 PM, Dave Airlie wrote:
> On 18 Oct. 2016 17:23, "Edward O'Callaghan" <funfunctor-dczkZgxz+BNOTv0TxJ7zrQ@public.gmane.org=
t
> <mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>> wrote:
>>
>> NACK,
>>
>> I think you want to use 'iomap_create_wc()' instead to avoid aliasing.=

>=20
> Please explain what can alias here?

Ah disregard the alias comment, I was remembering how it was introduced
and that referred to 'io_mapping_create_wc()' not hard coding WC.

Any way, I think 'iomap_create_wc()' is what your looking for so no need
to expose those symbols and hook them though.

Cheers,
Edward.

>=20
> Dave.
>=20
>>
>> Kind Regards,
>> Edward.
>>
>> On 10/18/2016 05:13 PM, Dave Airlie wrote:
>> > From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org <mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>
>> >
>> > These functions are needed for gpu/ttm drivers to reserve the
>> > VRAM area as write combined. In a lot of places we don't ioremap
>> > but still need to insert pfn from it into a VMA using vm_insert_mixe=
d,
>> > but a recent change in mixed insertion means we need to reserve
>> > VRAM as WC upfront, so we need these APIs exported.
>> >
>> > Signed-off-by: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> <mailto:airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>
>> > ---
>> >  arch/x86/mm/pat.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
>> > index 170cc4f..5ce2fbb 100644
>> > --- a/arch/x86/mm/pat.c
>> > +++ b/arch/x86/mm/pat.c
>> > @@ -719,6 +719,7 @@ out_free:
>> >  out_err:
>> >       return ret;
>> >  }
>> > +EXPORT_SYMBOL(io_reserve_memtype);
>> >
>> >  /**
>> >   * io_free_memtype - Release a memory type mapping for a region of
> memory
>> > @@ -729,6 +730,7 @@ void io_free_memtype(resource_size_t start,
> resource_size_t end)
>> >  {
>> >       free_memtype(start, end);
>> >  }
>> > +EXPORT_SYMBOL(io_free_memtype);
>> >
>> >  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,=

>> >                               unsigned long size, pgprot_t vma_prot)=

>> >
>>
>=20


--sbiXXIkhUMbsC50QnHjM8iEbEcIcswU3A--

--Hl8R22i0DFfRPoGqeQ1rAnabTS4pmclEV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYBhYbAAoJEP4bvbfZuWjbyzEQALwqERVz9vX0EhCNWuwDgk13
BwSWi4eM/VLh+6p4UsRRXAKmQDnh7H5BcGx4nQktxHeKrLsWtU3XMmF5XpCQp7F+
m39XErvuhc43gDVl2Kxqx9urdBrLPiNZpoFVg1U4cUmmYS76pcCO8CKZijMXoRf9
ZPmKwOTWU+N/G+w91eV0KF7HEIllxIeIBjzH6DwWB2XuCXgi4mKmSoPX4MtHjjTH
JIU+WkP7XUoi75WQs3KxocI6F2yjdAsZjIUGdoc8Pv6lJW+ULDcHOav+6yJCcsVE
YLDTVcc8Feb69z4s4M4GrFxpHMQai8XkKe8gCV5kcP/R1hfPQfP7KCqE6oLpX3wd
TXXXmj7N11AZS1jdIrWX/sPDPFhM95GGSotjClVELoTkq+7cqLLI4csAoOfVWfqf
sDHIbdIrBEvhQUTLXggxlEhBexvtTnOActFpcUECrPLsudrlVJynNiH8o+JZi2J/
kH7k28ef5mQtEc/rXDlShIJget3AoLhb39tbaBSwr6Gsr8GunEq/klsszjmcH+BR
DyCB1Uhc6fO3N+zpAEp5HO9k/CW3aFutCpjWZBxdD3pIkA/oH2JuB5M2fYmwROjn
7Cjcd6jIyF/8518+/TEAR2VpbWjixy2UXCKmwDb5GXyOlR0puLKEZCuyEjYM4ZG1
ZkVzjUweCRPtH42mCNEc
=Y+vC
-----END PGP SIGNATURE-----

--Hl8R22i0DFfRPoGqeQ1rAnabTS4pmclEV--

--===============0847614388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0847614388==--

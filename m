From: Jan Vesely <jan.vesely@rutgers.edu>
Subject: Re: [PATCH 1/1] drm/amdkfd: Do not ignore requested queue size
 during allocation
Date: Wed, 29 Nov 2017 16:43:23 -0500
Message-ID: <1511991803.2978.67.camel@rutgers.edu>
References: <20171116213631.3987-1-jan.vesely@rutgers.edu>
 <CAFCwf10MTrBcGn1kejNvn9AcHDsCiW85HkC6bSmYfY=1shGJxQ@mail.gmail.com>
 <21e77adc-4fbe-a3e9-0a02-5d84eb201561@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1897960067=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <21e77adc-4fbe-a3e9-0a02-5d84eb201561@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Felix Kuehling <felix.kuehling@amd.com>, Oded Gabbay <oded.gabbay@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org


--===============1897960067==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Mh63DbUGSoAh5zA2idKx"


--=-Mh63DbUGSoAh5zA2idKx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-11-20 at 14:22 -0500, Felix Kuehling wrote:
> I think this patch is not correct. The EOP-mem is not associated with
> the queue size. The EOP buffer is a separate buffer used by the firmware
> to handle command completion. As I understand it, this allows more
> concurrency, while still making it look like all commands in the queue
> are completing in order.

thanks for the explanation. I was looking for a source of a CP hang
(rptr stops advancing), but bumping the eop size actually mode things
worse. Is there a way to find out if a queue got disabled and for what
reason? (I'm running ROCK-1.6.x based kernel)

thanks,
Jan

>=20
> Regards,
>   Felix
>=20
>=20
> On 2017-11-19 03:19 AM, Oded Gabbay wrote:
> > On Thu, Nov 16, 2017 at 11:36 PM, Jan Vesely <jan.vesely@rutgers.edu> w=
rote:
> > > Signed-off-by: Jan Vesely <jan.vesely@rutgers.edu>
> > > ---
> > >  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
> > > index f1d48281e322..b3bee39661ab 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
> > > @@ -37,15 +37,16 @@ static bool initialize_vi(struct kernel_queue *kq=
, struct kfd_dev *dev,
> > >                         enum kfd_queue_type type, unsigned int queue_=
size)
> > >  {
> > >         int retval;
> > > +       unsigned int size =3D ALIGN(queue_size, PAGE_SIZE);
> > >=20
> > > -       retval =3D kfd_gtt_sa_allocate(dev, PAGE_SIZE, &kq->eop_mem);
> > > +       retval =3D kfd_gtt_sa_allocate(dev, size, &kq->eop_mem);
> > >         if (retval !=3D 0)
> > >                 return false;
> > >=20
> > >         kq->eop_gpu_addr =3D kq->eop_mem->gpu_addr;
> > >         kq->eop_kernel_addr =3D kq->eop_mem->cpu_ptr;
> > >=20
> > > -       memset(kq->eop_kernel_addr, 0, PAGE_SIZE);
> > > +       memset(kq->eop_kernel_addr, 0, size);
> > >=20
> > >         return true;
> > >  }
> > > --
> > > 2.13.6
> > >=20
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >=20
> > Thanks!
> > Applied to -next tree
> > Oded
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20
>=20

--=-Mh63DbUGSoAh5zA2idKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjGgSoFJq63cCYGKvY+M/tz9IsiAFAlofKf0ACgkQY+M/tz9I
siC8nRAAwIPkvLmPF/U8ez3Ba5fbot6htWgIrzG+dXODnAWWlcw3BnDdF1XCNzQ1
+WRGXVL08dfi/zCk9xgA6Lwob00sHYTuntejKomiuLjQD91xXWs6AxTFEfw12dTl
IGZLWvoWTEKimaafEjqC4As7zZq7LW+AMESmmzSgC7vZDa6LDjal4kogu2wQnzlS
RvsU9AXpCaYhTl/k1T9m5Ebz0Fw1ce7MTEyIY9Ye90T3Y0aHgs8PoxayvISJEhqH
gtqILIOPc3r+Bx1DSjUY44+XwWeBmuUWccJcCqy0S+moUr0xOCdKQa/7UvAtqEt/
gOxasR9TpfWSvNmwPDnr27OghE4cPW0WOBIg7ZJu1bVypSnGMRXH/EsTm+z8/wYq
791PQ5nPcao5RC4q7Fc6g/iygel9q8SFyKH/nGA0968SfMfh75TpFvw8LWMU3PDB
s4Ln0CXk6C8+/7+q6H2yLIjIU2nomhOU2JdEX/sZ2tebeMKQz/hWEoLkxQmNoSlp
Y/9HT13NFH/0VQqCjpIC7/Ac1y4D4+qZoqAUPZpI0c8i7txYl+o2opwSdiw2ulsu
a0mC3Uyc6CaOCWeJhiN+IgVDAz0Pp5bTntYxvUhdXOzVYCqaC/+QXI4/B6sEFCsl
aPQZ4Qv3B+wxkar3Xzp3ukWu9rHi3ANBMy9Z+zgwrEPA2EwQ3TI=
=Fjch
-----END PGP SIGNATURE-----

--=-Mh63DbUGSoAh5zA2idKx--


--===============1897960067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1897960067==--

From: Jan Vesely <jan.vesely@rutgers.edu>
Subject: Re: [PATCH 1/1] drm/amdkfd: Do not ignore requested queue size
 during allocation
Date: Thu, 30 Nov 2017 18:51:29 -0500
Message-ID: <1512085889.3631.50.camel@rutgers.edu>
References: <20171116213631.3987-1-jan.vesely@rutgers.edu>
 <CAFCwf10MTrBcGn1kejNvn9AcHDsCiW85HkC6bSmYfY=1shGJxQ@mail.gmail.com>
 <21e77adc-4fbe-a3e9-0a02-5d84eb201561@amd.com>
 <1511991803.2978.67.camel@rutgers.edu>
 <772df39e-167a-6404-4330-913718560b2f@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1710299943=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <772df39e-167a-6404-4330-913718560b2f@amd.com>
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


--===============1710299943==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-tLs82fIaNO88GD6BzuHd"


--=-tLs82fIaNO88GD6BzuHd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-11-29 at 16:58 -0500, Felix Kuehling wrote:
> You can see the state of the queues in debugfs:
> /sys/kernel/debug/kfd/... You can look at MQDs and HQDs.

thanks. how do I decode the information?
The rptr always stops at pos 60 which looks like this in mqds:

 DIQ on device 45a2
    00000000: c0310800 00004000 00000000 00000000 00000000 00000000 0000000=
0 00000000
    00000020: 00000000 00000000 00000000 00000001 00000000 00000000 0000000=
0 00000000
    00000040: 00000000 00000000 00000000 00000000 00000000 00000000 0000000=
0 ffffffff
    00000060: ffffffff 00000000 ffffffff ffffffff 00000000 00000000 0000000=
0 00000000

If I understood correctly that's the queue dump, so those fffffs look
wrong

>=20
> If your application isn't stopping queues deliberately, queues get
> disabled by evictions, usually temporarily. You'll see kernel messages
> when that happens.
>=20
> A VM fault will result in queues of the offending process getting
> disabled permanently. Again, you'll see messages about that in the
> kernel log.
>=20
> The RPTR can also stop advancing if you have an infinite loop in a
> shader program, or just a shader that takes a very long time to execute.
> Or maybe if you have some dependencies (barriers) in your AQL packets
> that never get satisfied.
>=20
> The function you changed only affects the HIQ, the queue that KFD uses
> to control the HWS. It does not affect user mode queues. If your problem
> is with a user mode queue, your change should have no effect at all.

It's not a userspace queue that stops. I'm using kernel dbgdev to issue
wave_resume commands. (waves are halted after executing
s_sendmsg_halt).
I bumped KFD_KERNEL_QUEUE_SIZE to 16KB to make sure all 320 resume
commads fit (otherwise I get spurious ENOMEM when the queue is full but
still advancing).

thanks,
Jan

>=20
> Regards,
>   Felix
>=20
>=20
> On 2017-11-29 04:43 PM, Jan Vesely wrote:
> > On Mon, 2017-11-20 at 14:22 -0500, Felix Kuehling wrote:
> > > I think this patch is not correct. The EOP-mem is not associated with
> > > the queue size. The EOP buffer is a separate buffer used by the firmw=
are
> > > to handle command completion. As I understand it, this allows more
> > > concurrency, while still making it look like all commands in the queu=
e
> > > are completing in order.
> >=20
> > thanks for the explanation. I was looking for a source of a CP hang
> > (rptr stops advancing), but bumping the eop size actually mode things
> > worse. Is there a way to find out if a queue got disabled and for what
> > reason? (I'm running ROCK-1.6.x based kernel)
> >=20
> > thanks,
> > Jan
> >=20
> > > Regards,
> > >   Felix
> > >=20
> > >=20
> > > On 2017-11-19 03:19 AM, Oded Gabbay wrote:
> > > > On Thu, Nov 16, 2017 at 11:36 PM, Jan Vesely <jan.vesely@rutgers.ed=
u> wrote:
> > > > > Signed-off-by: Jan Vesely <jan.vesely@rutgers.edu>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c | 5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
> > > > > index f1d48281e322..b3bee39661ab 100644
> > > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
> > > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
> > > > > @@ -37,15 +37,16 @@ static bool initialize_vi(struct kernel_queue=
 *kq, struct kfd_dev *dev,
> > > > >                         enum kfd_queue_type type, unsigned int qu=
eue_size)
> > > > >  {
> > > > >         int retval;
> > > > > +       unsigned int size =3D ALIGN(queue_size, PAGE_SIZE);
> > > > >=20
> > > > > -       retval =3D kfd_gtt_sa_allocate(dev, PAGE_SIZE, &kq->eop_m=
em);
> > > > > +       retval =3D kfd_gtt_sa_allocate(dev, size, &kq->eop_mem);
> > > > >         if (retval !=3D 0)
> > > > >                 return false;
> > > > >=20
> > > > >         kq->eop_gpu_addr =3D kq->eop_mem->gpu_addr;
> > > > >         kq->eop_kernel_addr =3D kq->eop_mem->cpu_ptr;
> > > > >=20
> > > > > -       memset(kq->eop_kernel_addr, 0, PAGE_SIZE);
> > > > > +       memset(kq->eop_kernel_addr, 0, size);
> > > > >=20
> > > > >         return true;
> > > > >  }
> > > > > --
> > > > > 2.13.6
> > > > >=20
> > > > > _______________________________________________
> > > > > amd-gfx mailing list
> > > > > amd-gfx@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > > >=20
> > > > Thanks!
> > > > Applied to -next tree
> > > > Oded
> > > > _______________________________________________
> > > > amd-gfx mailing list
> > > > amd-gfx@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20
>=20

--=-tLs82fIaNO88GD6BzuHd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjGgSoFJq63cCYGKvY+M/tz9IsiAFAlogmYIACgkQY+M/tz9I
siAyHw/9FjBKF2riBtQsPWGBcz+6icpkQjkRMBgAxUIQuXvpcf3pr+yXVRg/jFND
/mj76tv+UXFaas8zMPVVjbB91n0kZXj7vIMc0jP+ReP0GoHpx7Qy9XbVcYPeKtsz
9xQ6Q6ZQSVnDgP9cdS48xCIStCyEc80yV3WyUWXwufuIANYU6Qn5TGmejHjA+p99
ngOe8wTd1i4ssBT6PLSJZ3bVak3nClEX0ZRF8bX499mVStzv673RCl6iRvlZTmlJ
D4pUzfXI2ig2MuhpcvwO7kz/pEqE5ipiEQ0q/bQth1+Yznuzu1OjsGC82dL4r+cP
FAv0qYDqNzJXb4wTTixrX7JyjPJuOpyP0d6hJlPg8Q889zjcbfmCvudxTqLTJ4LA
UA1jDXHjN1FmaAFketo6e/d+8ozqERyxsWKV9/0k6LOFpmLZk29A4NNdCDJtvmeY
UMyz9MLWHJXnuTS5QiQQ5qEyrmrL7E48oR7pfhunlBDu+G0unFywO0S/3o9kMGEG
RHFzvDlsJifnNnxbhyEz5O0braXZl36UGCmBScqos+T3gLrvyTy4dRCR1vU0HjsS
/81ehqiXec+CO3qWIrW53ajA22R/VdcMl1YExv08LqUjPYMIRYyvh7bLhUujSfwj
Pe/Fa1TTPc+gNgTGL2WUFf9MmYRQ1n117MaGCBh7FGR3OlNoySI=
=UlpA
-----END PGP SIGNATURE-----

--=-tLs82fIaNO88GD6BzuHd--


--===============1710299943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1710299943==--

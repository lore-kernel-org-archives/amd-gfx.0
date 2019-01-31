From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: amd-staging-drm-next: Oops - BUG: unable to handle kernel NULL
 pointer dereference, bisected.
Date: Thu, 31 Jan 2019 18:31:22 +0100
Message-ID: <4141754.D6MJ5NIKBA@eclipse>
References: <1631249.cbNX0rPzdC@eclipse> <3492051.hfQoeLTAnN@eclipse>
 <676b4805-fc73-245f-abd2-38e014248b61@amd.com>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0946188631=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <676b4805-fc73-245f-abd2-38e014248b61-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0946188631==
Content-Type: multipart/signed; boundary="nextPart8664589.v1meLIQR80"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart8664589.v1meLIQR80
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Dnia czwartek, 31 stycznia 2019 17:56:32 CET piszesz:

> In my experience only the last chunk of the patch is necessary.  Can you 
> try this without:
> 
> 
>  >> +	vm->bulk_moveable = false;
> 
> 
> Too?
> 
> Thanks,
> Tom

Sure.

I have applied only the last chunk of the patch on top of today's amd-staging-
drm-next pull:

> >> @@ -2772,6 +2773,9 @@  void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
> >> 
> >> 	struct amdgpu_vm_bo_base **base;
> >>
> >>
> >>
> >> 	if (bo) {
> >> 
> >> +		if (bo->tbo.resv == vm->root.base.bo->tbo.resv)
> >> +			vm->bulk_moveable = false;
> >> +
> >> 
> >> 		for (base = &bo_va->base.bo->vm_bo; *base;
> >> 		
> >> 		     base = &(*base)->next) {
> >> 			
> >> 			if (*base != &bo_va->base)

and it seems to be working as expected also. 

Thanks,
Przemek.
--nextPart8664589.v1meLIQR80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAlxTMOoACgkQPMstj1ls
VJN+2w/+IV0A1A5oNKuTiPwvdzEcjejUFXcz0Cm7AhwiUFjGCTfUi0lh4kXbhxIl
YQYCqyPgaT8l62e+zADcMPq945dqC5HRe8fKfCbaqtt8u1GN7O9BQnETq99a4rC9
trNr4S3HoGsO4rnRPgGfmPxOn+3RI9UmMlNhOnJYs8AZmsy1K6O00fTgwnUFBrkd
Lj892IO8+UXC5A40eqVVgm+jwEmVws/nqo+Eue/zZquiNsh1JrH46ccglvSGp1Fj
is+jfTw5OU7x3mTM9e1w/YUBBWJm3OGfFEQfK2X/v5vLWAGfiFznQs2Nv0cYLIQh
oaje4gPZBfb76+ZbVM/DrV73iV/RdTFWu6OS9ToxtaOwm4Z9X+mkSHXV0v4AqVhj
37219cAtrrg4ar3Hc26y/TQtb/1+2dcUgIuiPozTsePCazTMQMjKWF+mMhsAVrQt
Fdl6y+jNr3YH375K2ubAzC9aV4f/5Bfin1kzW0BiWz5ZfbDMp93iQeO02td28HTv
9uONPj+cX9sA5OSzvgXf4LueUTSAzcDvNQi3IrRioWx67/8DkZ82jYXvF17wGSEa
P9VPsz3v3BOUkZyFbyxvk4pJVYky/gmlY+L5h4qAFoQAhl50GPi86FgTMqo4WBKn
95uTNNiLgJmSzsxpe+uxzztqIlTLPmQQBsuLTAw7zHtxuqqDeIo=
=dBwr
-----END PGP SIGNATURE-----

--nextPart8664589.v1meLIQR80--




--===============0946188631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0946188631==--

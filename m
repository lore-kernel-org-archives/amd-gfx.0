From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 04/11] drm/amdgpu: fix vm init error path
Date: Sat, 30 Jul 2016 13:44:04 +1000
Message-ID: <bd568ed0-23cb-5a2e-e556-96360e613868@folklore1984.net>
References: <1469700828-25650-1-git-send-email-David1.Zhou@amd.com>
 <1469700828-25650-5-git-send-email-David1.Zhou@amd.com>
 <7115f9e7-3afd-a693-3e23-1ad4acb3c700@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0155403657=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7115f9e7-3afd-a693-3e23-1ad4acb3c700-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0155403657==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bWdF7UvQi7AnfRMwWOpCS8SIEfFR5pKov"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bWdF7UvQi7AnfRMwWOpCS8SIEfFR5pKov
Content-Type: multipart/mixed; boundary="mujJ940jT5mRmkGKODVtblB9SJhomRavu"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <bd568ed0-23cb-5a2e-e556-96360e613868-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 04/11] drm/amdgpu: fix vm init error path
References: <1469700828-25650-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <1469700828-25650-5-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <7115f9e7-3afd-a693-3e23-1ad4acb3c700-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
In-Reply-To: <7115f9e7-3afd-a693-3e23-1ad4acb3c700-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

--mujJ940jT5mRmkGKODVtblB9SJhomRavu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/30/2016 01:41 PM, Edward O'Callaghan wrote:
> Hi,
>=20
> On 07/28/2016 08:13 PM, Chunming Zhou wrote:
>> Change-Id: Ie3d5440dc0d2d3a61d8e785ab08b8b91eda223db
>> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c
>> index 11c1263..1d58577 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1682,7 +1682,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm)
>>  	r =3D amd_sched_entity_init(&ring->sched, &vm->entity,
>>  				  rq, amdgpu_sched_jobs);
>>  	if (r)
>=20
> Hmm while we are here I think we should be explicit that non-zero,
> negative return values indicate an error path, so:
>=20
> -  	if (r)
> +  	if (r < 0)
>=20
> This then follows precisely the semantics documented for
> 'amdgpu_vm_init()' invocations.
wops! 'amd_sched_entity_init()' I mean to say!

>=20
> Kind Regards,
> Edward.
>=20
>> -		return r;
>> +		goto err;
>> =20
>>  	vm->page_directory_fence =3D NULL;
>> =20
>> @@ -1725,6 +1725,9 @@ error_free_page_directory:
>>  error_free_sched_entity:
>>  	amd_sched_entity_fini(&ring->sched, &vm->entity);
>> =20
>> +err:
>> +	drm_free_large(vm->page_tables);
>> +
>>  	return r;
>>  }
>> =20
>>
>=20
>=20
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--mujJ940jT5mRmkGKODVtblB9SJhomRavu--

--bWdF7UvQi7AnfRMwWOpCS8SIEfFR5pKov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXnCKFAAoJEP4bvbfZuWjb44oP/RWj/Zw5/YRJwcS9mSZd5Jb1
Zp8HACVAn4ZgOZAKUbkAgY0W/Sqk14biHbnDdiZ+zQMGhFlbyPKjfSinNojvVTLm
ccj605tEC1SYWkdtBsgTLOhveckmmZ25GqiTAa6k5gpvTjxo4H+gZbA39tXXs4e9
33IfzmTqEnTAtJap7bv1UfuDNrKrcodiOvWszARBtdoFDWph6EFOT7IV5n39ElN2
3egtR29h7QCSkH4gCRHEjsNN+yq3gCoyBg7qlPJbOXIuG5TJn4usu/4Jbfo+t2Ja
yyNq1bRIFAarZS8hvhXV6EW0P4vsGb2VCT5pcOKITpeaDF7OYTKXbI38HxHkoMkL
GAPYgmbyMNQR/h8acroxTUWXrTMApOcCS9WVOZNMxzWrhV5aPy4o3GMwuYws3Em6
hHF9bX8zlwsZPrwMdm5aa4CPyPqm+osjVTtv+Ef0P4LPMgy+usX5R5ok+dDt+CK8
wpF8jvkN/mZmbebFmhCh2ZMMDeaxgZhnekLhCOwgrueo08T5UWo9SgaevpbFONhR
d8VtYKbVCeYyO9DSgJX6F889Ck2RdlYmNib25iYsWNtGS1Ob7A0++YhmKU/TNW5O
maOiaQBxo2OTZSW3aprAhS0JNoyx/WEKqiDbfFFnkHspW+ihgzcwUaIAcg/xOmyr
zBDdwEeVranE7plsz71v
=+UGA
-----END PGP SIGNATURE-----

--bWdF7UvQi7AnfRMwWOpCS8SIEfFR5pKov--

--===============0155403657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0155403657==--

From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use error label to handle exceptional case
Date: Fri, 9 Sep 2016 20:30:42 +1000
Message-ID: <737d5f41-2a32-29e2-daa0-c71819428a8e@folklore1984.net>
References: <1473414607-19904-1-git-send-email-ray.huang@amd.com>
 <c125876f-8a96-bb6f-21ed-0f2a98876054@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1110047035=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c125876f-8a96-bb6f-21ed-0f2a98876054-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1110047035==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LAScqQisBgRRhr8f713lJ1BtDC1wf7lVK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LAScqQisBgRRhr8f713lJ1BtDC1wf7lVK
Content-Type: multipart/mixed; boundary="abOPWQnXTmotgaMSRXPEJ38uT7RqsAwKw";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>,
 Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <737d5f41-2a32-29e2-daa0-c71819428a8e-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use error label to handle exceptional case
References: <1473414607-19904-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
 <c125876f-8a96-bb6f-21ed-0f2a98876054-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <c125876f-8a96-bb6f-21ed-0f2a98876054-5C7GfCeVMHo@public.gmane.org>

--abOPWQnXTmotgaMSRXPEJ38uT7RqsAwKw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/09/2016 07:58 PM, Christian K=C3=B6nig wrote:
> Am 09.09.2016 um 11:50 schrieb Huang Rui:
>> Use error label to decrease global item unref and make codes more
>> readable.
>>
>> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
>=20
> Nice cleanup, please keep going with that. Probably more than once case=

> where we have things like this.

Definitely !

>=20
> Patch is Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

>=20
> Regards,
> Christian.
>=20
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 819c62d..2872afc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -89,10 +89,10 @@ int amdgpu_ttm_global_init(struct amdgpu_device
>> *adev)
>>       global_ref->init =3D &amdgpu_ttm_mem_global_init;
>>       global_ref->release =3D &amdgpu_ttm_mem_global_release;
>>       r =3D drm_global_item_ref(global_ref);
>> -    if (r !=3D 0) {
>> +    if (r) {
>>           DRM_ERROR("Failed setting up TTM memory accounting "
>>                 "subsystem.\n");
>> -        return r;
>> +        goto error_mem;
>>       }
>>         adev->mman.bo_global_ref.mem_glob =3D
>> @@ -103,26 +103,30 @@ int amdgpu_ttm_global_init(struct amdgpu_device
>> *adev)
>>       global_ref->init =3D &ttm_bo_global_init;
>>       global_ref->release =3D &ttm_bo_global_release;
>>       r =3D drm_global_item_ref(global_ref);
>> -    if (r !=3D 0) {
>> +    if (r) {
>>           DRM_ERROR("Failed setting up TTM BO subsystem.\n");
>> -        drm_global_item_unref(&adev->mman.mem_global_ref);
>> -        return r;
>> +        goto error_bo;
>>       }
>>         ring =3D adev->mman.buffer_funcs_ring;
>>       rq =3D &ring->sched.sched_rq[AMD_SCHED_PRIORITY_KERNEL];
>>       r =3D amd_sched_entity_init(&ring->sched, &adev->mman.entity,
>>                     rq, amdgpu_sched_jobs);
>> -    if (r !=3D 0) {
>> +    if (r) {
>>           DRM_ERROR("Failed setting up TTM BO move run queue.\n");
>> -        drm_global_item_unref(&adev->mman.mem_global_ref);
>> -        drm_global_item_unref(&adev->mman.bo_global_ref.ref);
>> -        return r;
>> +        goto error_entity;
>>       }
>>         adev->mman.mem_global_referenced =3D true;
>>         return 0;
>> +
>> +error_entity:
>> +    drm_global_item_unref(&adev->mman.bo_global_ref.ref);
>> +error_bo:
>> +    drm_global_item_unref(&adev->mman.mem_global_ref);
>> +error_mem:
>> +    return r;
>>   }
>>     static void amdgpu_ttm_global_fini(struct amdgpu_device *adev)
>=20
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--abOPWQnXTmotgaMSRXPEJ38uT7RqsAwKw--

--LAScqQisBgRRhr8f713lJ1BtDC1wf7lVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX0o9SAAoJEP4bvbfZuWjbeI0QAJv1RoOiyE0/oaT2iZ4cYMC4
4B746dsqIa9NjIl2jsND6syI7Vsx0tpjoQv9xB8x9+s3aUcHBH5u3RISHgMeyDdK
fScM1M2+MGwp6BARa2ir8QvbD2nEdRioO/7BJibSlWirw1z3iGXBL0ZJe+qaZh5i
vL5k/y1Z6ELwM+z0VqBPA5XBUvc8L6KpFrlS5/MWBoILNjNBwf5G9+aQCIYRJrFr
RJz1X/epm4+WnzVcgU7UhVEK9B6DhsfkufjdOURakgqm7BfvSGXtut90eD5Icg/G
t3dyYwhaj0NlZBWB9HKrouBF8M3v6ufuGw3611sMIMQgLKKVvk2C279FDdbuutPh
sFpGrlTPMyLKw2VWDwZswv1gPdUPtp25T3zxacnw8TCmzoEKWm6kAv6MdZNmBY1P
qsjNfuEYVRcnmpFi2Jsej420DykjTaUIA9xVY91ms1CBK2IT/b8EcK4EWC2Mfja+
lzfIvbz/6eq7VkqHfleH0O7ZVH60f1zTxHZt24n0UVxxh8BvB27kLpUL9WBSHwu+
nnJgPmLbgv2QLBAf+NXsNL4QLSSY9aIkSZwlGhsEpHw1SCJzE2UAFscqvZIDh/V2
AgiHcHurEXO9k/jVB8Mshl5uelfJUbob3bX5XorksNv0zkE+b5ESyXDyLjFCaY/g
oBS/48d3e7N7Ul6Y4nk1
=59RV
-----END PGP SIGNATURE-----

--LAScqQisBgRRhr8f713lJ1BtDC1wf7lVK--

--===============1110047035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1110047035==--

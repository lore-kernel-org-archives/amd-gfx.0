From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/4] amdgpu: add export/import semaphore apis
Date: Mon, 22 Aug 2016 22:41:29 +1000
Message-ID: <414bf811-0e72-6f79-350f-8995a2b5167c@folklore1984.net>
References: <1471506959-905-1-git-send-email-David1.Zhou@amd.com>
 <1471506959-905-3-git-send-email-David1.Zhou@amd.com>
 <cf458d97-d40a-d363-b5c4-2ae45dde9179@folklore1984.net>
 <57BA6689.2010700@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0289193484=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57BA6689.2010700-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David.Mao-5C7GfCeVMHo@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0289193484==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DCkXxCAsLRHtv7gNXDGO4sapKk68jEFnK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DCkXxCAsLRHtv7gNXDGO4sapKk68jEFnK
Content-Type: multipart/mixed; boundary="vKQe4m1R7hOsLjBER8qK5VPeAJsQFG3mo"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David.Mao-5C7GfCeVMHo@public.gmane.org
Message-ID: <414bf811-0e72-6f79-350f-8995a2b5167c-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/4] amdgpu: add export/import semaphore apis
References: <1471506959-905-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <1471506959-905-3-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <cf458d97-d40a-d363-b5c4-2ae45dde9179-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <57BA6689.2010700-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <57BA6689.2010700-5C7GfCeVMHo@public.gmane.org>

--vKQe4m1R7hOsLjBER8qK5VPeAJsQFG3mo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/22/2016 12:42 PM, zhoucm1 wrote:
>=20
>=20
> On 2016=E5=B9=B408=E6=9C=8821=E6=97=A5 14:23, Edward O'Callaghan wrote:=

>>
>> On 08/18/2016 05:55 PM, Chunming Zhou wrote:
>>> They are used for sharing semaphore across process.
>>>
>>> Change-Id: I262adf10913d365bb93368b492e69140af522c64
>>> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>  amdgpu/amdgpu.h          | 40 ++++++++++++++++++++++++++++++
>>>  amdgpu/amdgpu_cs.c       | 63 ++++++++++++++++++++++++++++++++++++++=
++++++++--
>>>  amdgpu/amdgpu_internal.h |  2 ++
>>>  3 files changed, 103 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
>>> index 693d841..e716855 100644
>>> --- a/amdgpu/amdgpu.h
>>> +++ b/amdgpu/amdgpu.h
>>> @@ -1379,6 +1379,19 @@ int amdgpu_svm_commit(amdgpu_va_handle va_rang=
e_handle,
>>>  int amdgpu_svm_uncommit(amdgpu_va_handle va_range_handle);
>>> =20
>>>  /**
>>> + *  create shared semaphore
>>> + *
>>> + * \param amdgpu_device_handle
>>> + * \param   sem	   - \c [out] semaphore handle
>>> + *
>>> + * \return   0 on success\n
>>> + *          <0 - Negative POSIX Error code
>>> + *
>>> +*/
>>> +int amdgpu_cs_create_semaphore_object(amdgpu_device_handle device_ha=
ndle,
>>> +				      amdgpu_semaphore_handle *sem);
>>> +
>>> +/**
>>>   *  create semaphore
>>>   *
>>>   * \param   sem	   - \c [out] semaphore handle
>>> @@ -1439,6 +1452,33 @@ int amdgpu_cs_wait_semaphore(amdgpu_context_ha=
ndle ctx,
>>>  int amdgpu_cs_destroy_semaphore(amdgpu_semaphore_handle sem);
>>> =20
>>>  /**
>>> + *  export semaphore
>>> + *
>>> + * \param   sem	    - \c [in] semaphore handle
>>> + * \param   shared_handle    - \c [out] handle across process
>>> + *
>>> + * \return   0 on success\n
>>> + *          <0 - Negative POSIX Error code
>>> + *
>>> +*/
>>> +int amdgpu_cs_export_semaphore(amdgpu_semaphore_handle sem,
>>> +			       uint32_t *shared_handle);
>>> +/**
>>> + *  import semaphore
>>> + *
>>> + * \param   sem	    - \c [out] semaphore handle
>>> + * \param   dev	    - \c [in] device handle
>>> + * \param   shared_handle    - \c [in] handle across process
>>> + *
>>> + * \return   0 on success\n
>>> + *          <0 - Negative POSIX Error code
>>> + *
>>> +*/
>>> +int amdgpu_cs_import_semaphore(amdgpu_semaphore_handle *sem,
>>> +			       amdgpu_device_handle dev,
>>> +			       uint32_t shared_handle);
>>> +
>>> +/**
>>>   *  Get the ASIC marketing name
>>>   *
>>>   * \param   dev         - \c [in] Device handle. See #amdgpu_device_=
initialize()
>>> diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
>>> index c76a675..a3ff34e 100644
>>> --- a/amdgpu/amdgpu_cs.c
>>> +++ b/amdgpu/amdgpu_cs.c
>>> @@ -518,6 +518,34 @@ int amdgpu_cs_wait_fences(struct amdgpu_cs_fence=
 *fences,
>>>  	return r;
>>>  }
>>> =20
>>> +int amdgpu_cs_create_semaphore_object(amdgpu_device_handle device_ha=
ndle,
>>> +				      amdgpu_semaphore_handle *sem)
>>> +{
>>> +	struct amdgpu_bo_alloc_request req =3D {0};
>>> +	amdgpu_bo_handle buf_handle;
>>> +	int r;
>>> +
>>> +	if (NULL =3D=3D sem)
>> Since sem is ** then should we not check that *both* sem && *sem are
>> non-NULL too? Further you can use the canonical form of (!sem)
>>
>>> +		return -EINVAL;
>>> +
>>> +	req.alloc_size =3D sizeof(struct amdgpu_semaphore);
>>> +	req.preferred_heap =3D AMDGPU_GEM_DOMAIN_GTT;
>>> +
>>> +	r =3D amdgpu_bo_alloc(device_handle, &req, &buf_handle);
>>> +	if (r)
>>> +		return r;
>>> +	r =3D amdgpu_bo_cpu_map(buf_handle, sem);
>>> +	if (r) {
>>> +		amdgpu_bo_free(buf_handle);
>>> +		return r;
>>> +	}
>>> +	(*sem)->buf_handle =3D buf_handle;
>>> +	atomic_set(&(*sem)->refcount, 1);
>> Hi Chunming,
>>
>> When/where was 'amdgpu_semaphore_handle' introduced? I am not sure I
>> like pointers being hidden behind typedef's as opaque types this can
>> lead to really really bad things.. I only noticed sem was a ** because=

>> of the weird looking deference then address operator application, then=

>> deference again here, &(*sem)->..
> Hi Edward,
> semaphore was introduced last year, which is the wrapper of existing
> dependency.

Well no, I mean 'amdgpu_semaphore_handle' in particular as I didn't see
that in mainline. Where was it introduced?

> Yeah, this whole sharing semaphore approach has been NAKed by Christian=
=2E
> So we can skip this series now, we are going to use sync_file instead.

No worries.

Kind Regards,
Edward.

>=20
> Thanks,
> David Zhou
>=20
>>
>> Cheers,
>> Edward.
>>
>>> +	(*sem)->version =3D 2;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  int amdgpu_cs_create_semaphore(amdgpu_semaphore_handle *sem)
>>>  {
>>>  	struct amdgpu_semaphore *gpu_semaphore;
>>> @@ -529,6 +557,7 @@ int amdgpu_cs_create_semaphore(amdgpu_semaphore_h=
andle *sem)
>>>  	if (NULL =3D=3D gpu_semaphore)
>>>  		return -ENOMEM;
>>> =20
>>> +	gpu_semaphore->version =3D 1;
>>>  	atomic_set(&gpu_semaphore->refcount, 1);
>>>  	*sem =3D gpu_semaphore;
>>> =20
>>> @@ -608,8 +637,15 @@ static int amdgpu_cs_unreference_sem(amdgpu_sema=
phore_handle sem)
>>>  	if (NULL =3D=3D sem)
>>>  		return -EINVAL;
>>> =20
>>> -	if (update_references(&sem->refcount, NULL))
>>> -		free(sem);
>>> +	if (update_references(&sem->refcount, NULL)) {
>>> +		if (sem->version =3D=3D 1)
>>> +			free(sem);
>>> +		else if (sem->version =3D=3D 2) {
>>> +			amdgpu_bo_handle buf_handle =3D sem->buf_handle;
>>> +			amdgpu_bo_cpu_unmap(buf_handle);
>>> +			amdgpu_bo_free(buf_handle);
>>> +		}
>>> +	}
>>>  	return 0;
>>>  }
>>> =20
>>> @@ -618,4 +654,27 @@ int amdgpu_cs_destroy_semaphore(amdgpu_semaphore=
_handle sem)
>>>  	return amdgpu_cs_unreference_sem(sem);
>>>  }
>>> =20
>>> +int amdgpu_cs_export_semaphore(amdgpu_semaphore_handle sem,
>>> +			       uint32_t *shared_handle)
>>> +{
>>> +	return amdgpu_bo_export(sem->buf_handle,
>>> +				amdgpu_bo_handle_type_dma_buf_fd,
>>> +				shared_handle);
>>> +
>>> +}
>>> +
>>> +int amdgpu_cs_import_semaphore(amdgpu_semaphore_handle *sem,
>>> +			       amdgpu_device_handle dev, uint32_t shared_handle)
>>> +{
>>> +	struct amdgpu_bo_import_result output;
>>> +	int r;
>>> +
>>> +	r =3D amdgpu_bo_import(dev,
>>> +			     amdgpu_bo_handle_type_dma_buf_fd,
>>> +			     shared_handle,
>>> +			     &output);
>>> +	if (r)
>>> +		return r;
>>> =20
>>> +	return amdgpu_bo_cpu_map(output.buf_handle, sem);
>>> +}
>>> diff --git a/amdgpu/amdgpu_internal.h b/amdgpu/amdgpu_internal.h
>>> index ccc85d7..7c422da 100644
>>> --- a/amdgpu/amdgpu_internal.h
>>> +++ b/amdgpu/amdgpu_internal.h
>>> @@ -134,6 +134,8 @@ struct amdgpu_semaphore {
>>>  	atomic_t refcount;
>>>  	struct list_head list;
>>>  	struct drm_amdgpu_fence signal_fence;
>>> +	amdgpu_bo_handle buf_handle;
>>> +	uint32_t version;
>>>  };
>>> =20
>>>  /**
>>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20
>=20
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--vKQe4m1R7hOsLjBER8qK5VPeAJsQFG3mo--

--DCkXxCAsLRHtv7gNXDGO4sapKk68jEFnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXuvL5AAoJEP4bvbfZuWjbFdIQANUnsh0dIJ6xtmnXpd0Qrp7P
ZB6/OHa755wTGAoFk3gcnccacIJZxuZueWTYqjQur3SRkyyEfLDO6NNCFQLXOFW6
8n+HgK9bWCHmVXp5DjxZ0dUtGM5tjWuZPo5o+qSi6pQncPNTZon96oBtfL0dxdG0
l7DOaP4yKzkKyApgAYUzsxuUEOrXMf+WVll18aUEtsunfhKQJLIELMZIZQZZ7u9r
Ir/qXG3leVltSp5TkfmRrbF7DQwMNYYt1YGET+WVft9BlS9uoylVGhT43Xn7CL+H
1clP6yC6dIDwh6OXTvIqGE6IxSVf+58ZdZxEWTsg5higFzEpvGaXRUI8BS1I7Kou
YsNnR3iCCq7hCRoeFfzB+7GBOuiDw5RV7A6/uGf9cFPIVsPX73O1QuP1FZey754w
CJMDMxtjHb7X3rMr9NCqauigII8NDKdCRYqv9EJoeiuyD9KnRZ+POGCQxMFMRYcb
kVuzR2+u1RMKw22Ft62SrNa+lj8trOyl8WEsnFeapm+A+z8gcUGqut3PB94xMO1+
ZkT100oG/w9swiXyofIXOO+x6I8dLHlxZGIYsqcoBBwKgJgkFboXabfVWn4prrYP
3IP+/ddBOFmOP1/4Qs5hCDkUiEhbE9xiuJGruHuBYk81pnvmm+sFg/feRIcP7FfE
agmy4/ikWSHLm0jrzL3F
=V0sT
-----END PGP SIGNATURE-----

--DCkXxCAsLRHtv7gNXDGO4sapKk68jEFnK--

--===============0289193484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0289193484==--

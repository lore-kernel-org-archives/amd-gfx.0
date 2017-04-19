From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: add the interface of waiting multiple
 fences
Date: Wed, 19 Apr 2017 13:17:05 +1000
Message-ID: <cb5f475f-37ae-46ec-a5fe-9a0af205723c@folklore1984.net>
References: <20170413144756.30734-1-nhaehnle@gmail.com>
 <20170413144756.30734-2-nhaehnle@gmail.com>
 <025d8078-e9e7-a958-02f9-d221e26960b8@folklore1984.net>
 <519b14a3-a81f-e86e-2174-48ccdd029846@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0484537962=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <519b14a3-a81f-e86e-2174-48ccdd029846-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>, "monk . liu" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0484537962==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IhMA3gfhS2whlhHWqPL72gebEQ7gOKwpv"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IhMA3gfhS2whlhHWqPL72gebEQ7gOKwpv
Content-Type: multipart/mixed; boundary="GbtPwTjOLK3mDL8J8QHhUMjqrewvPc1Ri";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "monk . liu" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>,
 =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
Message-ID: <cb5f475f-37ae-46ec-a5fe-9a0af205723c-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: add the interface of waiting multiple
 fences
References: <20170413144756.30734-1-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <20170413144756.30734-2-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <025d8078-e9e7-a958-02f9-d221e26960b8-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <519b14a3-a81f-e86e-2174-48ccdd029846-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <519b14a3-a81f-e86e-2174-48ccdd029846-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--GbtPwTjOLK3mDL8J8QHhUMjqrewvPc1Ri
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 04/19/2017 04:28 AM, Nicolai H=C3=A4hnle wrote:
> On 18.04.2017 17:47, Edward O'Callaghan wrote:
>> On 04/14/2017 12:47 AM, Nicolai H=C3=A4hnle wrote:
>>> From: Nicolai H=C3=A4hnle <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
>>>
>>> Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
>>> [v2: allow returning the first signaled fence index]
>>> Signed-off-by: monk.liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>>> [v3:
>>>  - cleanup *status setting
>>>  - fix amdgpu symbols check]
>>> Signed-off-by: Nicolai H=C3=A4hnle <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org> (v1)
>>> Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org> (v1)
>>> ---
>>>  amdgpu/amdgpu-symbol-check |  1 +
>>>  amdgpu/amdgpu.h            | 23 ++++++++++++++
>>>  amdgpu/amdgpu_cs.c         | 74
>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 98 insertions(+)
>>>
> [snip]
>>> +static int amdgpu_ioctl_wait_fences(struct amdgpu_cs_fence *fences,
>>> +                    uint32_t fence_count,
>>> +                    bool wait_all,
>>> +                    uint64_t timeout_ns,
>>> +                    uint32_t *status,
>>> +                    uint32_t *first)
>>> +{
>>> +    struct drm_amdgpu_fence *drm_fences;
>>> +    amdgpu_device_handle dev =3D fences[0].context->dev;
>>> +    union drm_amdgpu_wait_fences args;
>>> +    int r;
>>> +    uint32_t i;
>>> +
>>> +    drm_fences =3D alloca(sizeof(struct drm_amdgpu_fence) * fence_co=
unt);
>>> +    for (i =3D 0; i < fence_count; i++) {
>>> +        drm_fences[i].ctx_id =3D fences[i].context->id;
>>> +        drm_fences[i].ip_type =3D fences[i].ip_type;
>>> +        drm_fences[i].ip_instance =3D fences[i].ip_instance;
>>> +        drm_fences[i].ring =3D fences[i].ring;
>>> +        drm_fences[i].seq_no =3D fences[i].fence;
>>> +    }
>>> +
>>> +    memset(&args, 0, sizeof(args));
>>> +    args.in.fences =3D (uint64_t)(uintptr_t)drm_fences;
>>> +    args.in.fence_count =3D fence_count;
>>> +    args.in.wait_all =3D wait_all;
>>> +    args.in.timeout_ns =3D amdgpu_cs_calculate_timeout(timeout_ns);
>>> +
>>> +    r =3D drmIoctl(dev->fd, DRM_IOCTL_AMDGPU_WAIT_FENCES, &args);
>>> +    if (r)
>>> +        return -errno;
>>
>> Hi Nicolai,
>>
>> you will leak drm_fences here on the error branch.
>=20
> It's an alloca, so it's automatically freed when the function returns.
>=20
>=20
>>> +
>>> +    *status =3D args.out.status;
>>> +
>>> +    if (first)
>>> +        *first =3D args.out.first_signaled;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int amdgpu_cs_wait_fences(struct amdgpu_cs_fence *fences,
>>> +              uint32_t fence_count,
>>> +              bool wait_all,
>>> +              uint64_t timeout_ns,
>>> +              uint32_t *status,
>>> +              uint32_t *first)
>>> +{
>>> +    uint32_t i;
>>> +    int r;
>>
>> no need for a intermediate ret, just return amdgpu_ioctl_wait_fences()=

>> directly?
>=20
> Good point, I'll change that before I push.
>=20
>=20
>>> +
>>> +    /* Sanity check */
>>> +    if (NULL =3D=3D fences)
>>> +        return -EINVAL;
>>> +    if (NULL =3D=3D status)
>>> +        return -EINVAL;
>>> +    if (fence_count <=3D 0)
>>> +        return -EINVAL;
>>
>> may as well combine these branches?
>>
>> if (!fences || !status || !fence_count)
>>     return -EINVAL;
>>
>> as fence_count is unsigned.
>=20
> Yeah, that makes some sense, but I decided to keep the separate
> if-statements because other functions are written like this as well.

Its not completely consistent actually, I sent in a patch last night to
fix the rest.

Cheers,
Edward.

>=20
> Thanks,
> Nicolai
>=20
>=20
>=20
>>
>> Kind Regards,
>> Edward.
>>
>>> +    for (i =3D 0; i < fence_count; i++) {
>>> +        if (NULL =3D=3D fences[i].context)
>>> +            return -EINVAL;
>>> +        if (fences[i].ip_type >=3D AMDGPU_HW_IP_NUM)
>>> +            return -EINVAL;
>>> +        if (fences[i].ring >=3D AMDGPU_CS_MAX_RINGS)
>>> +            return -EINVAL;
>>> +    }
>>> +
>>> +    *status =3D 0;
>>> +
>>> +    r =3D amdgpu_ioctl_wait_fences(fences, fence_count, wait_all,
>>> timeout_ns,
>>> +                     status, first);
>>> +
>>> +    return r;
>>> +}
>>> +
>>>  int amdgpu_cs_create_semaphore(amdgpu_semaphore_handle *sem)
>>>  {
>>>      struct amdgpu_semaphore *gpu_semaphore;
>>>
>>>      if (NULL =3D=3D sem)
>>>          return -EINVAL;
>>>
>>>      gpu_semaphore =3D calloc(1, sizeof(struct amdgpu_semaphore));
>>>      if (NULL =3D=3D gpu_semaphore)
>>>          return -ENOMEM;
>>>
>>
>=20
>=20


--GbtPwTjOLK3mDL8J8QHhUMjqrewvPc1Ri--

--IhMA3gfhS2whlhHWqPL72gebEQ7gOKwpv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9taxAAoJEP4bvbfZuWjbIzIP/1p0oNr+7Vme+qsnsRtUq6/E
zwW4a223yROTc2k+e+JI51cJ/UjVcIjSENi0/IUfPhKFvCuf8vmzx5gu97ROIUtQ
jbjwp0HL8+4e26/38WpV+54KB10pqC5cJzZ50ANfwSB8bYXVjBI4lsIbqxbcSbIV
QbReHEjS+P67KpRSxVNQWaQVDAj+hLtslZ03jmBsau+hEqcNe9iEl+YY9Iix8IS6
OFgNdsKVlwArX004dQSEUH7fWFRO4WUgOaeXEhXk4ePC3oLwcZEXOQRcG80pcKMq
63JodDX3vLEwJKueNKgWmHpvgvXneO/kcNF0/40tIxnvEVANDlzz5w6FBRAP5TV5
RdI8tcyeEevL35Ej6XevS44WXtyghXlfv3grXF3Bth8njDv42nWgZiOKY3rhmvyC
/u4EIT8DaSvGuufY8GMTPkzFH/biRay0sVokA42R45bQpOZldQ7NFh3AUBdaWo5o
lEP//UmWgHEUTzRlIXtapTbZk2Qgk5ZDMpcchz9cxvO6ilVx74i3gqOn7mbE9nSj
TUVu2SkQvFLbLQ6KO9oKJSERd4mzpbZ8fQoFmy+5tEVKlx0Oh8W9+kOr4RIerd7F
EpIBvmqOesSOSw/B62YYB4kwXLUFWfgGxcjgWnD9VDJRps8kvbhbJDY9M09HVjHd
2kQRFpDDOzKgEFO9dpWj
=2CCG
-----END PGP SIGNATURE-----

--IhMA3gfhS2whlhHWqPL72gebEQ7gOKwpv--

--===============0484537962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0484537962==--

From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 00/11] add recovery entity and run queue
Date: Fri, 5 Aug 2016 20:16:05 +1000
Message-ID: <69d5e2e2-4a16-2f52-1512-e3d72b5d5fe0@folklore1984.net>
References: <1470124302-23615-1-git-send-email-David1.Zhou@amd.com>
 <88bda920-4da2-7115-a82c-c0b1f581603e@folklore1984.net>
 <57A2AC23.7090709@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0198215326=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57A2AC23.7090709-5C7GfCeVMHo@public.gmane.org>
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0198215326==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DnCmh5IwjCMtTjtX7nic9811crTfdxgka"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DnCmh5IwjCMtTjtX7nic9811crTfdxgka
Content-Type: multipart/mixed; boundary="0nCpMn0p6LGuRPaP0t8rHFFsvC6BtNOVP"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <69d5e2e2-4a16-2f52-1512-e3d72b5d5fe0-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 00/11] add recovery entity and run queue
References: <1470124302-23615-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <88bda920-4da2-7115-a82c-c0b1f581603e-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <57A2AC23.7090709-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <57A2AC23.7090709-5C7GfCeVMHo@public.gmane.org>

--0nCpMn0p6LGuRPaP0t8rHFFsvC6BtNOVP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/04/2016 12:44 PM, zhoucm1 wrote:
>=20
> On 2016=E5=B9=B408=E6=9C=8803=E6=97=A5 20:16, Edward O'Callaghan wrote:=

>> Hi,
>>
>> I didn't see any of my previous review remarks on your previous
>> submission addresses in this submission of this series?
> Hi Edward,
>=20
> Sorry for that. Since these patch sets are big feature change and we
> need to pin down the approach of the solution first. As you see,
> Christian has argued this solution and suggested another direction.
> When we change the direction, the patches could be different totally. S=
o
> I didn't address patch itself flaw. But indeed many thanks for your rev=
iew.
No problem, welcome to the community and thanks for your hard work! :)

>=20
> Thanks,
> David Zhou
>=20
>>
>> Kind Regards,
>> Edward.
>>
>> On 08/02/2016 05:51 PM, Chunming Zhou wrote:
>>> every vm has itself recovery entity, which is used to reovery page ta=
ble from their shadow.
>>> They don't need to wait front vm completed.
>>> And also using all pte rings can speed reovery.
>>>
>>> every scheduler has its own recovery entity, which is used to save hw=
 jobs, and resubmit from it, which solves the conflicts between reset thr=
ead and scheduler thread when run job.
>>>
>>> And some fixes when doing this improment.=20
>>>
>>> Chunming Zhou (11):
>>>   drm/amdgpu: hw ring should be empty when gpu reset
>>>   drm/amdgpu: specify entity to amdgpu_copy_buffer
>>>   drm/amd: add recover run queue for scheduler
>>>   drm/amdgpu: fix vm init error path
>>>   drm/amdgpu: add vm recover entity
>>>   drm/amdgpu: use all pte rings to recover page table
>>>   drm/amd: add recover entity for every scheduler
>>>   drm/amd: use scheduler to recover hw jobs
>>>   drm/amd: hw job list should be exact
>>>   drm/amd: reset jobs to recover entity
>>>   drm/amdgpu: no need fence wait every time
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  35 +++++--
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  11 +++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_test.c      |   8 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   5 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  27 ++++--
>>>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 129 +++++++++++++---=
----------
>>>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |   4 +-
>>>  9 files changed, 135 insertions(+), 92 deletions(-)
>>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--0nCpMn0p6LGuRPaP0t8rHFFsvC6BtNOVP--

--DnCmh5IwjCMtTjtX7nic9811crTfdxgka
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXpGdlAAoJEP4bvbfZuWjbjtgP/jeHWwsk5eaJaWAGtPG+7VxD
FR7aHrcE1XGuRPEYwplyhGuXcwPezP0xFlYeBRTenGULVyVENbqYjwHw3jOi0Sls
ZLZ9YnUtrt7MTdkb1K3hEUlH6vgB7Mci0wkFU4I3ctOtvNlHn9pfqis9LdK24iN3
/rgOqTjsI4YIN/IbRRq9wZ6TrAqOBRH4bBPwkvXscF60FvItihwwzExACzibXDGk
i4CGgvv5yW2rnXzzKzs33bIxyjrEp7ayYLvrENotQtzq3gwklvW/BQfG7hqnzQ1m
s5Vn7xVCb+T/IVxhUqx+/2Fi6HfF6i9cGqHcUMJALaXOOoQAjSjSSa0LSwnLnvoq
koMFd7klDYViE05O7CjsjvELQaaL+qzC6hIIeD+sM4zTqwzu3IAraKtvzm1J24dQ
ovX3RwqelMB6TvDquozQOMy3/0ulZttK683R1hx15QZPkCGceyauiodIUk1mwRn+
kY856YtPAFqEEQGYUmJqAVMwC8wJ/gafzoT5grBJcwbOV8wlPetqQFaftrNlN0hW
FUSYIAWzsw11ShmaVN6y1ljuvkZOsNTWJ/7I6oUhXRqJAOedWxkNc5F05jFEv8YG
p/n0JIYnkFl5zRl/OZXuWFx2UA5V2EPei4wydjZ8ZaQrw6JK36n7ft7DdBZoemGn
onA4cTDTdV+AW0xnB26G
=VW8j
-----END PGP SIGNATURE-----

--DnCmh5IwjCMtTjtX7nic9811crTfdxgka--

--===============0198215326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0198215326==--

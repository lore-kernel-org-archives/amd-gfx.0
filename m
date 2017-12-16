From: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 28/37] drm/amdkfd: Add support for displaying VRAM usage
Date: Sat, 16 Dec 2017 21:36:48 +0100
Message-ID: <f64e2633-9424-26d4-0a35-166a2b8a62c8@gmail.com>
References: <1512792555-26042-1-git-send-email-Felix.Kuehling@amd.com>
 <1512792555-26042-29-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf12qZXOyS3iwHd5WnBLKce9Kf+7gMu720uiN_TJSzuFngA@mail.gmail.com>
 <CAFCwf129dU00ocL=btDWh0bjHVaX-JsqWcwAr1uLpJmvj1gkKA@mail.gmail.com>
 <64ce9318-7aa1-d654-7d41-e24cb7ad056a@gmail.com>
 <71874366-c697-8e90-de59-4e5f1d4f797b@amd.com>
 <BN6PR1201MB01800128BE70E4BF0E4DEE4085340@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <CAFCwf12RbD-AaecdAjurqyAYXU6UqvpdLM+mpc7VdvXuYtp=TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2067663846=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf12RbD-AaecdAjurqyAYXU6UqvpdLM+mpc7VdvXuYtp=TA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2067663846==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pUx9K6uf64RgsM4tn4oBw6oci6F4DPDMP"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pUx9K6uf64RgsM4tn4oBw6oci6F4DPDMP
Content-Type: multipart/mixed; boundary="CPHM3QwITPEB2osVlEg7jdxaRTcaL8TIN";
 protected-headers="v1"
From: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Russell, Kent"
 <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>,
 "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>,
 amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <f64e2633-9424-26d4-0a35-166a2b8a62c8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 28/37] drm/amdkfd: Add support for displaying VRAM usage
References: <1512792555-26042-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
 <1512792555-26042-29-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
 <CAFCwf12qZXOyS3iwHd5WnBLKce9Kf+7gMu720uiN_TJSzuFngA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
 <CAFCwf129dU00ocL=btDWh0bjHVaX-JsqWcwAr1uLpJmvj1gkKA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
 <64ce9318-7aa1-d654-7d41-e24cb7ad056a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <71874366-c697-8e90-de59-4e5f1d4f797b-5C7GfCeVMHo@public.gmane.org>
 <BN6PR1201MB01800128BE70E4BF0E4DEE4085340-6iU6OBHu2P/H0AMcJMwsYmrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
 <CAFCwf12RbD-AaecdAjurqyAYXU6UqvpdLM+mpc7VdvXuYtp=TA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CAFCwf12RbD-AaecdAjurqyAYXU6UqvpdLM+mpc7VdvXuYtp=TA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--CPHM3QwITPEB2osVlEg7jdxaRTcaL8TIN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB

Am 13.12.2017 um 08:23 schrieb Oded Gabbay:
> On Tue, Dec 12, 2017 at 1:11 PM, Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org> w=
rote:
>> That's alright. I admit that it was a bit self-serving in that I was a=
sked to get something somewhere to get the information out, and it was th=
e simplest solution. I can see if I can come up with a more acceptable op=
tion in a future patch set, but for now I think Felix is right in that we=
 can just drop this one for now, it's definitely not worth holding up the=
 rest of the patches over.
>>
>>  Kent
> Sure, np. I'll drop this for now.

FWIW, there is precedent for this type of information in sysfs. See
/sys/devices/virtual/drm/ttm/memory_accounting/kernel/used_memory.

Regards,
=C2=A0 Felix

>
> Oded
>
>> -----Original Message-----
>> From: Kuehling, Felix
>> Sent: Monday, December 11, 2017 2:52 PM
>> To: Koenig, Christian; Oded Gabbay
>> Cc: Russell, Kent; amd-gfx list
>> Subject: Re: [PATCH 28/37] drm/amdkfd: Add support for displaying VRAM=
 usage
>>
>> On 2017-12-11 12:28 PM, Christian K=C3=B6nig wrote:
>>> Am 11.12.2017 um 17:40 schrieb Oded Gabbay:
>>>> On Mon, Dec 11, 2017 at 5:32 PM, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=

>>>> wrote:
>>>>> On Sat, Dec 9, 2017 at 6:09 AM, Felix Kuehling
>>>>> <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> wrote:
>>>>>> From: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
>>>>>>
>>>>>> Add a sysfs file in topology (node/x/memory_banks/X/used_memory)
>>>>>> that reports the current VRAM usage for that node. Only works for
>>>>>> GPU nodes at this time.
>>>>>>
>>>>> As with patch 22 (perf counters), I would not expect this
>>>>> information to be included in the topology. It doesn't describe the=

>>>>> properties of the device, but a current state.
>>>>> Oded
>>>> For example, in amdgpu, the VRAM usage is reported in the INFO IOCTL=

>>>> (AMDGPU_INFO_VRAM_USAGE). See function  amdgpu_info_ioctl()
>>> Yep, completely agree.
>>>
>>> That stuff is runtime properties and not static attribute nor
>>> configuration or setup.
>>>
>>> So either debugfs or IOCTL are the two best options as far as I can s=
ee.
>> Right. I admit, this feature was a bit of a hack to quickly enable the=
 HIP team without having to change a bunch of interfaces (ioctls, Thunk, =
and Runtime).
>>
>> This patch isn't critical for enabling dGPU support. I'll drop it for =
now and we can reimplement it properly later.
>>
>> Regards,
>>   Felix
>>
>>> Christian.
>>>
>>>> Thanks,
>>>>
>>>> Oded
>>>>
>>>>
>>>>>> Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
>>>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 49
>>>>>> +++++++++++++++++++++++++++----
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  4 ++-
>>>>>>   2 files changed, 46 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>>>> index 7f0d41e..7f04038 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>>>> @@ -186,6 +186,8 @@ struct kfd_topology_device
>>>>>> *kfd_create_topology_device(
>>>>>>                  sysfs_show_gen_prop(buffer, "%s %llu\n", name,
>>>>>> value)
>>>>>>   #define sysfs_show_32bit_val(buffer, value) \
>>>>>>                  sysfs_show_gen_prop(buffer, "%u\n", value)
>>>>>> +#define sysfs_show_64bit_val(buffer, value) \
>>>>>> +               sysfs_show_gen_prop(buffer, "%llu\n", value)
>>>>>>   #define sysfs_show_str_val(buffer, value) \
>>>>>>                  sysfs_show_gen_prop(buffer, "%s\n", value)
>>>>>>
>>>>>> @@ -268,11 +270,23 @@ static ssize_t mem_show(struct kobject *kobj=
,
>>>>>> struct attribute *attr,
>>>>>>   {
>>>>>>          ssize_t ret;
>>>>>>          struct kfd_mem_properties *mem;
>>>>>> +       uint64_t used_mem;
>>>>>>
>>>>>>          /* Making sure that the buffer is an empty string */
>>>>>>          buffer[0] =3D 0;
>>>>>>
>>>>>> -       mem =3D container_of(attr, struct kfd_mem_properties, attr=
);
>>>>>> +       if (strcmp(attr->name, "used_memory") =3D=3D 0) {
>>>>>> +               mem =3D container_of(attr, struct kfd_mem_properti=
es,
>>>>>> attr_used);
>>>>>> +               if (mem->gpu) {
>>>>>> +                       used_mem =3D
>>>>>> +mem->gpu->kfd2kgd->get_vram_usage(
>>>>>> +
>>>>>> mem->gpu->kgd);
>>>>>> +                       return sysfs_show_64bit_val(buffer,
>>>>>> +used_mem);
>>>>>> +               }
>>>>>> +               /* TODO: Report APU/CPU-allocated memory; For now
>>>>>> return 0 */
>>>>>> +               return 0;
>>>>>> +       }
>>>>>> +
>>>>>> +       mem =3D container_of(attr, struct kfd_mem_properties,
>>>>>> attr_props);
>>>>>>          sysfs_show_32bit_prop(buffer, "heap_type",
>>>>>> mem->heap_type);
>>>>>>          sysfs_show_64bit_prop(buffer, "size_in_bytes",
>>>>>> mem->size_in_bytes);
>>>>>>          sysfs_show_32bit_prop(buffer, "flags", mem->flags); @@
>>>>>> -527,7 +541,12 @@ static void kfd_remove_sysfs_node_entry(struct
>>>>>> kfd_topology_device *dev)
>>>>>>          if (dev->kobj_mem) {
>>>>>>                  list_for_each_entry(mem, &dev->mem_props, list)
>>>>>>                          if (mem->kobj) {
>>>>>> -                               kfd_remove_sysfs_file(mem->kobj,
>>>>>> &mem->attr);
>>>>>> +                               /* TODO: Remove when CPU/APU
>>>>>> supported */
>>>>>> +                               if (dev->node_props.cpu_cores_coun=
t
>>>>>> =3D=3D 0)
>>>>>> +
>>>>>> +sysfs_remove_file(mem->kobj,
>>>>>> +
>>>>>> &mem->attr_used);
>>>>>> +                               kfd_remove_sysfs_file(mem->kobj,
>>>>>> +                                               &mem->attr_props);=

>>>>>>                                  mem->kobj =3D NULL;
>>>>>>                          }
>>>>>>                  kobject_del(dev->kobj_mem); @@ -629,12 +648,23 @@=

>>>>>> static int kfd_build_sysfs_node_entry(struct kfd_topology_device
>>>>>> *dev,
>>>>>>                  if (ret < 0)
>>>>>>                          return ret;
>>>>>>
>>>>>> -               mem->attr.name =3D "properties";
>>>>>> -               mem->attr.mode =3D KFD_SYSFS_FILE_MODE;
>>>>>> -               sysfs_attr_init(&mem->attr);
>>>>>> -               ret =3D sysfs_create_file(mem->kobj, &mem->attr);
>>>>>> +               mem->attr_props.name =3D "properties";
>>>>>> +               mem->attr_props.mode =3D KFD_SYSFS_FILE_MODE;
>>>>>> +               sysfs_attr_init(&mem->attr_props);
>>>>>> +               ret =3D sysfs_create_file(mem->kobj,
>>>>>> +&mem->attr_props);
>>>>>>                  if (ret < 0)
>>>>>>                          return ret;
>>>>>> +
>>>>>> +               /* TODO: Support APU/CPU memory usage */
>>>>>> +               if (dev->node_props.cpu_cores_count =3D=3D 0) {
>>>>>> +                       mem->attr_used.name =3D "used_memory";
>>>>>> +                       mem->attr_used.mode =3D KFD_SYSFS_FILE_MOD=
E;
>>>>>> +                       sysfs_attr_init(&mem->attr_used);
>>>>>> +                       ret =3D sysfs_create_file(mem->kobj,
>>>>>> &mem->attr_used);
>>>>>> +                       if (ret < 0)
>>>>>> +                               return ret;
>>>>>> +               }
>>>>>> +
>>>>>>                  i++;
>>>>>>          }
>>>>>>
>>>>>> @@ -1075,15 +1105,22 @@ static struct kfd_topology_device
>>>>>> *kfd_assign_gpu(struct kfd_dev *gpu)
>>>>>>   {
>>>>>>          struct kfd_topology_device *dev;
>>>>>>          struct kfd_topology_device *out_dev =3D NULL;
>>>>>> +       struct kfd_mem_properties *mem;
>>>>>>
>>>>>>          down_write(&topology_lock);
>>>>>>          list_for_each_entry(dev, &topology_device_list, list)
>>>>>>                  if (!dev->gpu && (dev->node_props.simd_count > 0)=
)
>>>>>> {
>>>>>>                          dev->gpu =3D gpu;
>>>>>>                          out_dev =3D dev;
>>>>>> +
>>>>>> +                       /* Assign mem->gpu */
>>>>>> +                       list_for_each_entry(mem, &dev->mem_props,
>>>>>> list)
>>>>>> +                               mem->gpu =3D dev->gpu;
>>>>>> +
>>>>>>                          break;
>>>>>>                  }
>>>>>>          up_write(&topology_lock);
>>>>>> +
>>>>>>          return out_dev;
>>>>>>   }
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>>>>>> index 53fca1f..0f698d8 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>>>>>> @@ -93,7 +93,9 @@ struct kfd_mem_properties {
>>>>>>          uint32_t                width;
>>>>>>          uint32_t                mem_clk_max;
>>>>>>          struct kobject          *kobj;
>>>>>> -       struct attribute        attr;
>>>>>> +       struct kfd_dev          *gpu;
>>>>>> +       struct attribute        attr_props;
>>>>>> +       struct attribute        attr_used;
>>>>>>   };
>>>>>>
>>>>>>   #define HSA_CACHE_TYPE_DATA            0x00000001
>>>>>> --
>>>>>> 2.7.4
>>>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--CPHM3QwITPEB2osVlEg7jdxaRTcaL8TIN--

--pUx9K6uf64RgsM4tn4oBw6oci6F4DPDMP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlo1g/0ACgkQ1hkrDAUMk3YdhAD/RB/h6tCM7M/hRWZx8hDg9fV9
xVM0ewUxWuoaK+av4m8A/3Y5LKgZkAedFBSbn2aWVi82bp8q88dgbFgIhhLBb/SV
=5yLI
-----END PGP SIGNATURE-----

--pUx9K6uf64RgsM4tn4oBw6oci6F4DPDMP--

--===============2067663846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2067663846==--

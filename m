From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: potential uninitialized variable in amdgpu_vce_ring_parse_cs()
Date: Wed, 8 Nov 2017 15:37:48 -0500
Message-ID: <CADnq5_NUoGKfhTrQ41_G+_JBk6rOumTR=PN83b9D3m5PnrXQ4Q@mail.gmail.com>
References: <20170930081328.kher7yumqzi2vsrg@mwanda> <0b5a4cef-085d-bbeb-e673-79f8163a2e34@amd.com>
 <CAD=4a=XLYh2Er1sKvt7MBrNCsqC_F037Ttrfyxv4aW58JW+pKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <CAD=4a=XLYh2Er1sKvt7MBrNCsqC_F037Ttrfyxv4aW58JW+pKg@mail.gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Leo Liu <leo.liu@amd.com>, kernel-janitors@vger.kernel.org, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Chris Wilson <chris@chris-wilson.co.uk>, Junwei Zhang <Jerry.Zhang@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Nov 8, 2017 at 2:53 PM, Ernst Sj=C3=B6strand <ernstp@gmail.com> wro=
te:
> Can't find these anywhere yet, errors still there.
>
> https://patchwork.freedesktop.org/series/31220/

Applied.  thanks for the reminder.

Alex

>
> Regards
> //Ernst
>
> 2017-09-30 10:25 GMT+02:00 Christian K=C3=B6nig <christian.koenig@amd.com=
>:
>> Am 30.09.2017 um 10:13 schrieb Dan Carpenter:
>>>
>>> We shifted some code around in commit 9cca0b8e5df0 ("drm/amdgpu: move
>>> amdgpu_cs_sysvm_access_required into find_mapping") and now my static
>>> checker complains that "r" might not be initialized at the end of the
>>> function.  I've reviewed the code, and that seems possible, but it's
>>> also possible I may have missed something.
>>>
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>>
>> Good catches, Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.co=
m> for
>> both patches.
>>
>>
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> index b46280c1279f..2918de2f39ec 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> @@ -648,7 +648,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parse=
r
>>> *p, uint32_t ib_idx)
>>>         uint32_t allocated =3D 0;
>>>         uint32_t tmp, handle =3D 0;
>>>         uint32_t *size =3D &tmp;
>>> -       int i, r, idx =3D 0;
>>> +       int i, r =3D 0, idx =3D 0;
>>>         p->job->vm =3D NULL;
>>>         ib->gpu_addr =3D amdgpu_sa_bo_gpu_addr(ib->sa_bo);
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

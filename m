From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Fix missing break in
 switch statement
Date: Mon, 22 Jul 2019 17:43:56 +0000
Message-ID: <fd20d447-dde0-a24d-8d63-d846accb5cc9@amd.com>
References: <20190721225920.GA18099@embeddedor>
 <c735a1cc-a545-50fb-44e7-c0ad93ee8ee7@amd.com>
 <BN6PR12MB18098741A081711936563597F7C40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <b1feb7e5-bd52-ef1b-b72e-b98b2c954b89@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b1feb7e5-bd52-ef1b-b72e-b98b2c954b89@embeddedor.com>
Content-Language: en-US
Content-ID: <988882E2B639C74B889D4B8FD45F7B31@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Cox, Philip" <Philip.Cox@amd.com>, Oded Gabbay <oded.gabbay@gmail.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

That sounds good to me .

Regards

shaoyun.liu

On 2019-07-22 12:13 p.m., Gustavo A. R. Silva wrote:
>
> On 7/22/19 10:58 AM, Deucher, Alexander wrote:
>> We need to add a /*fall through */ comment then.
>>
> It might be better to remove the call to pr_debug() in KFD_MQD_TYPE_CP:
>
> 	case KFD_MQD_TYPE_CP:
>         	case KFD_MQD_TYPE_COMPUTE:
> 		pr_debug("%s@%i\n", __func__, __LINE__);
> 		mqd->allocate_mqd =3D allocate_mqd;
>
> Thanks
> --
> Gustavo
>
>
>> Alex
>> ________________________________
>> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
>> Sent: Monday, July 22, 2019 11:14 AM
>> To: Gustavo A. R. Silva <gustavo@embeddedor.com>; Cox, Philip <Philip.Co=
x@amd.com>; Oded Gabbay <oded.gabbay@gmail.com>; Deucher, Alexander <Alexan=
der.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, D=
avid(ChunMing) <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Dani=
el Vetter <daniel@ffwll.ch>
>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; dri-d=
evel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; linux-kernel@=
vger.kernel.org <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Fix missing break i=
n switch statement
>>
>> This one properly in purpose , The mqd init for CP and  COMPUTE will
>> have the same  routine .
>>
>> Regard
>>
>> sshaoyun.liu
>>
>> On 2019-07-21 6:59 p.m., Gustavo A. R. Silva wrote:
>>> Add missing break statement in order to prevent the code from falling
>>> through to case KFD_MQD_TYPE_COMPUTE.
>>>
>>> This bug was found thanks to the ongoing efforts to enable
>>> -Wimplicit-fallthrough.
>>>
>>> Fixes: 14328aa58ce5 ("drm/amdkfd: Add navi10 support to amdkfd. (v3)")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>>> index 4f8a6ffc5775..1d8b13ad46f9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>>> @@ -430,6 +430,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_M=
QD_TYPE type,
>>>         switch (type) {
>>>         case KFD_MQD_TYPE_CP:
>>>                 pr_debug("%s@%i\n", __func__, __LINE__);
>>> +             break;
>>>         case KFD_MQD_TYPE_COMPUTE:
>>>                 pr_debug("%s@%i\n", __func__, __LINE__);
>>>                 mqd->allocate_mqd =3D allocate_mqd;

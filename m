From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
Date: Fri, 5 Oct 2018 01:38:02 -0700
Message-ID: <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Peng Hao <peng.hao2@zte.com.cn>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On 10/05/2018 01:14 AM, Koenig, Christian wrote:
> Am 04.10.2018 um 20:52 schrieb Guenter Roeck:
>> Hi,
>>
>> On Fri, Sep 14, 2018 at 06:05:52PM +0800, Peng Hao wrote:
>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:
>>>       In function ‘gmc_v8_0_process_interrupt’:
>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:10:
>>>       warning: missing braces around initializer [-Wmissing-braces]
>>>
>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>> Was there any feedback on this patch ? The problem does affect us,
>> and we'll need a fix.
> 
> Well as discussed using "{ { 0 } }" is as wrong as using "{ 0 }".
> 

Ah, sorry, I must have missed the discussion.

It is for sure not the best solution, but at least it compiles, and it seems
to be proliferating.

$ git grep "{ *{ *0 *} *}" | wc
     144    1180   11802
$ git grep "{ *{ *0 *} *}" drivers/gpu/drm/amd/ | wc
      50     459    5239

> We should either use only "{ }" or even better make nails with heads and
> use memset().

I'd rather leave it up to the compiler to decide what is most efficient.

Guenter

> 
> Christian.
> 
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index 9333109..55f4755 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>>>    		gmc_v8_0_set_fault_enable_default(adev, false);
>>>    
>>>    	if (printk_ratelimit()) {
>>> -		struct amdgpu_task_info task_info = { 0 };
>>> +		struct amdgpu_task_info task_info = { {0} };
>>>    
>> I wondered if
>> 		struct amdgpu_task_info task_info = { };
>> would be better.
>>
>> Thanks,
>> Guenter
>>
>>>    		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>    
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 72f8018..e8b78c5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>>>    	}
>>>    
>>>    	if (printk_ratelimit()) {
>>> -		struct amdgpu_task_info task_info = { 0 };
>>> +		struct amdgpu_task_info task_info = { {0} };
>>>    
>>>    		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>    
> 

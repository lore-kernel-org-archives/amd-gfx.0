From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] Fix IB va_start+ib_bytes range check on 32Bit systems
Date: Thu, 30 Mar 2017 10:41:51 +0900
Message-ID: <07c31b2e-5dfa-0e6b-2961-44c1bdf47fe1@daenzer.net>
References: <20170329091839.5246-1-jan.burgmeier@unicon-software.com>
 <20170329091839.5246-2-jan.burgmeier@unicon-software.com>
 <6dc2814c-c32b-220a-daa7-da530d13f20d@vodafone.de>
 <26c98d79-025c-bdf6-4bbe-bfd083cb6720@daenzer.net>
 <af21de45-36ce-2351-7704-7e26d8212e3f@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <af21de45-36ce-2351-7704-7e26d8212e3f@vodafone.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>, Jan Burgmeier <jan.burgmeier@unicon-software.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On 30/03/17 12:18 AM, Christian König wrote:
> Am 29.03.2017 um 16:54 schrieb Michel Dänzer:
>> On 29/03/17 10:22 PM, Christian König wrote:
>>> Am 29.03.2017 um 11:18 schrieb Jan Burgmeier:
>>>> Signed-off-by: Jan Burgmeier <jan.burgmeier@unicon-software.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> index 99424cb8020b..583d22974e14 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -908,6 +908,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device
>>>> *adev,
>>>>                struct amdgpu_bo *aobj = NULL;
>>>>                uint64_t offset;
>>>>                uint8_t *kptr;
>>>> +            uint64_t it_last;
>>>>                  m = amdgpu_cs_find_mapping(parser, chunk_ib->va_start,
>>>>                               &aobj);
>>>> @@ -916,8 +917,9 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device
>>>> *adev,
>>>>                    return -EINVAL;
>>>>                }
>>>>    +            it_last = m->it.last;
>>>>                if ((chunk_ib->va_start + chunk_ib->ib_bytes) >
>>>> -                (m->it.last + 1) * AMDGPU_GPU_PAGE_SIZE) {
>>>> +                (it_last + 1) * AMDGPU_GPU_PAGE_SIZE) {
>>> Nice catch, but just adding a u64 case should do here as well. E.g:
>>>
>>> if ((chunk_ib->va_start + chunk_ib->ib_bytes) >
>>>      (u64)(m->it.last + 1) * AMDGPU_GPU_PAGE_SIZE) {
>> That won't work correctly if m->it.last == 0xffffffff ? Or is that not
>> possible?
> Hui, why? is it.last signed?

No. If m->it.last == 0xffffffff, (m->it.last + 1) == 0, the u64 cast
won't change that. I thought that would be bad, but maybe not?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

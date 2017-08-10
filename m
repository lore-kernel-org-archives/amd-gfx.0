From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: potential shift wrapping bug
Date: Thu, 10 Aug 2017 15:02:53 +0200
Message-ID: <b13fa138-4a14-50bc-953d-0f6ce11d8744@amd.com>
References: <20170810121659.7k2pqemqnd3px2qi@mwanda>
 <1c9843bd-8c8f-b6f7-d413-ebb508c97930@vodafone.de>
 <20170810125344.6g2tbgdr5xyhudly@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170810125344.6g2tbgdr5xyhudly@mwanda>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, "Zhang, Jerry" <Jerry.Zhang@amd.com>, Alex Xie <AlexBin.Xie@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Am 10.08.2017 um 14:53 schrieb Dan Carpenter:
> On Thu, Aug 10, 2017 at 02:30:15PM +0200, Christian König wrote:
>> Am 10.08.2017 um 14:16 schrieb Dan Carpenter:
>>> "frag_align" is a u64, so presumably we want to use the high bits as
>>> well instead of shift wrapping.
>>>
>>> Fixes: 6be7adb37d9b ("drm/amdgpu: increase fragmentation size for Vega10 v2")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> The fragment field has only 5bits in hardware and can never be more than 31,
>> so the correct fix would actually be using uint32_t here instead.
>>
> Changing it to uint32_t introduces a new static checker warning:
>
>      drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1465 amdgpu_vm_frag_ptes()
>      warn: was expecting a 64 bit value instead of '~(frag_align - 1)'
>
> Unfortunately, I get so many thousands of those I can't normally even
> review that sort of bug...
>
> Let me resend the original patch but with a modified changelog to say
> that the bug is a false positive.

Ah, yes of course that's why I made it a 64bit value in the first place.

Mhm, could we use something like (u32)(1 << pages_per_frag) instead to 
silence the static checker warning?

It doesn't make much sense to use a 64bit shift here.

Christian.

>
> regards,
> dan carpenter
>


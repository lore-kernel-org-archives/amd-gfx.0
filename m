From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] drm/amdgpu: potential shift wrapping bug
Date: Thu, 10 Aug 2017 15:17:43 +0200
Message-ID: <598C5CF7.8080702@bfs.de>
References: <20170810121659.7k2pqemqnd3px2qi@mwanda> <1c9843bd-8c8f-b6f7-d413-ebb508c97930@vodafone.de> <20170810125344.6g2tbgdr5xyhudly@mwanda> <b13fa138-4a14-50bc-953d-0f6ce11d8744@amd.com>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <b13fa138-4a14-50bc-953d-0f6ce11d8744@amd.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, =?UTF-8?B?Q2hyaXN0aWFuIEvDtg==?= =?UTF-8?B?bmln?= <deathsimple@vodafone.de>, Alex Deucher <alexander.deucher@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, "Zhang, Jerry" <Jerry.Zhang@amd.com>, Alex Xie <AlexBin.Xie@amd.com>
List-Id: amd-gfx.lists.freedesktop.org



Am 10.08.2017 15:02, schrieb Christian König:
> Am 10.08.2017 um 14:53 schrieb Dan Carpenter:
>> On Thu, Aug 10, 2017 at 02:30:15PM +0200, Christian König wrote:
>>> Am 10.08.2017 um 14:16 schrieb Dan Carpenter:
>>>> "frag_align" is a u64, so presumably we want to use the high bits as
>>>> well instead of shift wrapping.
>>>>
>>>> Fixes: 6be7adb37d9b ("drm/amdgpu: increase fragmentation size for
>>>> Vega10 v2")
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> The fragment field has only 5bits in hardware and can never be more
>>> than 31,
>>> so the correct fix would actually be using uint32_t here instead.
>>>
>> Changing it to uint32_t introduces a new static checker warning:
>>
>>      drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1465 amdgpu_vm_frag_ptes()
>>      warn: was expecting a 64 bit value instead of '~(frag_align - 1)'
>>
>> Unfortunately, I get so many thousands of those I can't normally even
>> review that sort of bug...
>>
>> Let me resend the original patch but with a modified changelog to say
>> that the bug is a false positive.
> 
> Ah, yes of course that's why I made it a 64bit value in the first place.
> 
> Mhm, could we use something like (u32)(1 << pages_per_frag) instead to
> silence the static checker warning?
> 
> It doesn't make much sense to use a 64bit shift here.
> 
> Christian.
> 



Why not keeping Dan 1. patch and add a comment that pages_per_frag is always >31 ?

Using 32bit in a 64bit is not forbidden, and changing it causes more problems than
it solves. But doing so should be done in a clean way.

just my 2 cents,
re,
 wh


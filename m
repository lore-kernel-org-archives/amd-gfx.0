From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] drm/amdkfd: add missing void argument to function
 kgd2kfd_init
Date: Sat, 5 Oct 2019 11:30:00 -0700
Message-ID: <43fae0fa-aa26-c713-ca64-627b58c6519b@infradead.org>
References: <20191005175808.32018-1-colin.king@canonical.com>
 <7677a8bc-cc5a-eb03-c7d4-b1a27330126f@infradead.org>
 <d9ae3586-f484-9734-1cc7-5e960fde76a3@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d9ae3586-f484-9734-1cc7-5e960fde76a3@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On 10/5/19 11:23 AM, Colin Ian King wrote:
> On 05/10/2019 19:10, Randy Dunlap wrote:
>> On 10/5/19 10:58 AM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Function kgd2kfd_init is missing a void argument, add it
>>> to clean up the non-ANSI function declaration.
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> sparse reports 2 such warnings in amdgpu:
>>
>> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_module.c:85:18: warning: non-ANSI function declaration of function 'kgd2kfd_init'
>> ../drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c:168:60: warning: non-ANSI function declaration of function 'amdgpu_amdkfd_gfx_10_0_get_functions'
> 
> Looking at linux-next, the amdgpu_amdkfd_gfx_10_0_get_functions() was
> removed in commit:
> 
> commit e392c887df979112af94cfec08dd87f4dd55d085
> Author: Yong Zhao <Yong.Zhao@amd.com>
> Date:   Fri Sep 27 22:03:42 2019 -0400
> 
>     drm/amdkfd: Use array to probe kfd2kgd_calls
> 
> ..so I didn't fix that one up

ah. Thanks.

-- 
~Randy

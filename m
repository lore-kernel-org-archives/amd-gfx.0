From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 01/14] amdgpu: powerplay: Remove unused function
Date: Wed, 26 Jul 2017 10:44:16 -0400
Message-ID: <34bf4656-4a87-bedc-7e8f-74a688c78cd6@amd.com>
References: <20170724133540.32200-1-ricardo.ribalda@gmail.com>
 <20170724133540.32200-2-ricardo.ribalda@gmail.com>
 <40ac5a58-9e02-0240-ae87-0b1c9375873b@amd.com>
 <CAPybu_2eqTsFzrP=o8u-m-sCi-VDx6Bep2AqT7KGH4p6LstHcA@mail.gmail.com>
 <a059f078-b364-e0b7-6532-99fa4d36514e@amd.com>
 <CAPybu_3EBnHk3x1nRXTvZT1tuk5CmJidiA9BupaTbgjP6pADOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_3EBnHk3x1nRXTvZT1tuk5CmJidiA9BupaTbgjP6pADOg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Tom St Denis <tom.stdenis@amd.com>, Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, David Airlie <airlied@linux.ie>, Edward O'Callaghan <funfunctor@folklore1984.net>, LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, "Andrew F. Davis" <afd@ti.com>, Eric Huang <JinHuiEric.Huang@amd.com>, Huang Rui <ray.huang@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Nils_Wallm=c3=a9nius?= <nils.wallmenius@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Colin Ian King <colin.king@canonical.com>, Baoyou Xie <baoyou.xie@linaro.org>, Rex Zhu <Rex.Zhu@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Dan Carpenter <dan.carpenter@ora>
List-Id: amd-gfx.lists.freedesktop.org

On 2017-07-26 09:47 AM, Ricardo Ribalda Delgado wrote:
> Hi Harry
> 
> On Mon, Jul 24, 2017 at 5:45 PM, Harry Wentland <harry.wentland@amd.com> wrote:
>> On 2017-07-24 10:06 AM, Ricardo Ribalda Delgado wrote:
>>> Hi Harry
>>> On Mon, Jul 24, 2017 at 4:01 PM, Harry Wentland <harry.wentland@amd.com> wrote:
>>>
>>>>
>>>> This is used and needed by the DC display driver. See
>>>> display/amdgpu_dm/amdgpu_dm_services.c:193 in Alex's amd-staging-4.11 tree:
>>>>
>>>> https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c?h=amd-staging-4.11
>>>>
>>>
>>> I could not find any reference to the function in linux-next (>4.12)
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/amd
>>>
>>> Is there any plan to merge Alex's amd-stagin tree?
>>
>> The plan is to merge/upstream the amd/display portion of Alex's
>> amd-staging tree. We're currently working on the community feedback we
>> received to get it into shape.
> 
> Is there any timeframe for this?
> 

We're actively working on this. It depends on cleaning up our codebase a
fair bit.

Harry

>  At least we should remove the   pr_info("min_core_set_clock not
> set\n"); message.>
> it is (very) misleading right now.
> 
> Regards!
> 
>>
>> Harry
>>
>>>
>>> Sorry, I am not very familiar with this subsystem.
>>>
>>> Regards!
>>>
> 
> 
> 

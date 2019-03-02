From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: Fix missing break in switch
 statement
Date: Fri, 1 Mar 2019 18:00:32 -0600
Message-ID: <37efca9b-c949-efb9-c336-f1fb910d81f3@embeddedor.com>
References: <20190301212943.GA21585@embeddedor>
 <CADnq5_NdT3R141uSGxYd7yZ0nimo2uW_WgfWF8jGxYr68F4Kqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_NdT3R141uSGxYd7yZ0nimo2uW_WgfWF8jGxYr68F4Kqg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@chromium.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org



On 3/1/19 5:54 PM, Alex Deucher wrote:
> On Fri, Mar 1, 2019 at 4:51 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> Add missing break statement in order to prevent the code from falling
>> through to case SMU_Discrete_DpmTable.
>>
>> This bug was found thanks to the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Fixes: 34a564eaf528 ("drm/amd/powerplay: implement fw image related smum interface for Polaris.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Already fixed:
> https://cgit.freedesktop.org/~agd5f/linux/commit/?h=drm-next-5.2-wip&id=6feaa4194c18578623565017f95d1b2f6b243567
> 

Awesome. :)

I was looking for that link, but I didn't find it.  That's why
I sent this patch.

Happy to see it is fixed now.

Thanks, Alex.

--
Gustavo

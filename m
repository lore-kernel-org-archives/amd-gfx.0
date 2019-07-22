From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Fix missing break in switch statement
Date: Mon, 22 Jul 2019 14:14:37 -0500
Message-ID: <8a539933-bb59-0204-58a9-ab54fa6b1c94@embeddedor.com>
References: <20190721223949.GA13591@embeddedor>
 <CADnq5_NZNA3wCq4U4jbOU7BHfYgan5m=R6MbWmJ3Xp1oYMAUog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_NZNA3wCq4U4jbOU7BHfYgan5m=R6MbWmJ3Xp1oYMAUog@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@chromium.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org



On 7/22/19 2:12 PM, Alex Deucher wrote:
> On Sun, Jul 21, 2019 at 6:39 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> Add missing break statement in order to prevent the code from falling
>> through to case AMDGPU_IRQ_STATE_ENABLE.
>>
>> This bug was found thanks to the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Fixes: a644d85a5cd4 ("drm/amdgpu: add gfx v10 implementation (v10)")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied.  Thanks!
> 

Awesome! Glad to help. :)

Thanks
--
Gustavo

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amd/powerplay: Fix missing break in switch
Date: Mon, 28 Jan 2019 12:23:16 -0600
Message-ID: <10cbe6a3-f06f-7443-4f99-cdc389100462@embeddedor.com>
References: <20190125215533.GA4878@embeddedor>
 <CADnq5_Nx1yHoANDaGs50AF5VQXWCUD8PU1YoyHAmGetHxoqiPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_Nx1yHoANDaGs50AF5VQXWCUD8PU1YoyHAmGetHxoqiPA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@chromium.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org



On 1/28/19 10:19 AM, Alex Deucher wrote:
> On Fri, Jan 25, 2019 at 5:31 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> Add missing break statement in order to prevent the code from falling
>> through to the default case.
>>
>> The resoning for this is that pclk_vol_table is an automatic variable.
>> So, it makes no sense to update it just before falling through to the
>> default case and return -EINVAL.
>>
>> This bug was found thanks to the ongoing efforts to enabling
>> -Wimplicit-fallthrough.
>>
>> Fixes: cd70f3d6e3fa ("drm/amd/powerplay: PP/DAL interface changes for dynamic clock switch")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied.  Thanks!
> 

Great. :)

Thanks, Alex.
--
Gustavo

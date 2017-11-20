From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] drm/amd/display/dc/dce110/dce110_mem_input_v: use swap
 macro in program_size_and_rotation
Date: Sun, 19 Nov 2017 23:25:02 -0600
Message-ID: <20171119232502.Horde.q2PQYS7eChaoQL8h2Iegu1z@gator4166.hostgator.com>
References: <20171110223109.GA31549@embeddedor.com>
 <fc996517-7d2b-a35a-1a2d-930037668dac@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fc996517-7d2b-a35a-1a2d-930037668dac@amd.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?b?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org


Quoting Harry Wentland <harry.wentland@amd.com>:

> On 2017-11-10 05:31 PM, Gustavo A. R. Silva wrote:
>> Make use of the swap macro instead of _manually_ swapping values
>> and remove unnecessary variable swap.
>>
>> This makes the code easier to read and maintain.
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Thank you, Harry.

--
Gustavo A. R. Silva

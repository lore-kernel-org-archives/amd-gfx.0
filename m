From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amd/display/dc/dce: Fix multiple potential integer
 overflows
Date: Wed, 4 Jul 2018 12:54:22 -0500
Message-ID: <ab3d5e10-e25b-46a1-d3ab-da3619d8c5b4@embeddedor.com>
References: <20180704011305.GA15742@embeddedor.com>
 <c663121e-1db8-9d7f-6b66-2c41e6a8bb70@daenzer.net>
 <421747e5-e6e0-6680-e3b7-a3a2a5b7b307@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <421747e5-e6e0-6680-e3b7-a3a2a5b7b307@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org



On 07/04/2018 12:51 PM, Harry Wentland wrote:
[..]
>>>  
>>> @@ -145,8 +145,8 @@ static bool calculate_fb_and_fractional_fb_divider(
>>>   * of fractional feedback decimal point and the fractional FB Divider precision
>>>   * is 2 then the equation becomes (ullfeedbackDivider + 5*100) / (10*100))*/
>>>  
>>> -	feedback_divider += (uint64_t)
>>> -			(5 * calc_pll_cs->fract_fb_divider_precision_factor);
>>> +	feedback_divider += 5UL *
>>> +			    calc_pll_cs->fract_fb_divider_precision_factor;
>>
>> This should be 5ULL, as the commit log says, otherwise it's still only
>> 32 bits on 32-bit platforms.
>>
> 
> Agreed.
> 
> Otherwise this looks good.
> 
> With that fixed this patch is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 

Hi Harry,

I already sent v2: https://patchwork.kernel.org/patch/10506897/

Thanks
--
Gustavo

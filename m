From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amd/display/dc/dce: Fix multiple potential integer
 overflows
Date: Wed, 4 Jul 2018 07:51:06 -0500
Message-ID: <d16f0990-a06e-de77-fe3c-130d7620d8bd@embeddedor.com>
References: <20180704011305.GA15742@embeddedor.com>
 <c663121e-1db8-9d7f-6b66-2c41e6a8bb70@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c663121e-1db8-9d7f-6b66-2c41e6a8bb70@daenzer.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hi Michel,

On 07/04/2018 02:38 AM, Michel Dänzer wrote:
> On 2018-07-04 03:13 AM, Gustavo A. R. Silva wrote:
>> Add suffix ULL to constant 5 and cast variables target_pix_clk_khz and
>> feedback_divider to uint64_t in order to avoid multiple potential integer
>> overflows and give the compiler complete information about the proper
>> arithmetic to use.
>>
>> Notice that such constant and variables are used in contexts that
>> expect expressions of type uint64_t (64 bits, unsigned). The current
>> casts to uint64_t effectively apply to each expression as a whole,
>> but they do not prevent them from being evaluated using 32-bit
>> arithmetic instead of 64-bit arithmetic.
>>
>> Also, once the expressions are properly evaluated using 64-bit
>> arithmentic, there is no need for the parentheses that enclose
>> them.
>>
>> Addresses-Coverity-ID: 1460245 ("Unintentional integer overflow")
>> Addresses-Coverity-ID: 1460286 ("Unintentional integer overflow")
>> Addresses-Coverity-ID: 1460401 ("Unintentional integer overflow")
>> Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>
>> [...]
>>  
>> @@ -145,8 +145,8 @@ static bool calculate_fb_and_fractional_fb_divider(
>>   * of fractional feedback decimal point and the fractional FB Divider precision
>>   * is 2 then the equation becomes (ullfeedbackDivider + 5*100) / (10*100))*/
>>  
>> -	feedback_divider += (uint64_t)
>> -			(5 * calc_pll_cs->fract_fb_divider_precision_factor);
>> +	feedback_divider += 5UL *
>> +			    calc_pll_cs->fract_fb_divider_precision_factor;
> 
> This should be 5ULL, as the commit log says, otherwise it's still only
> 32 bits on 32-bit platforms.
> 

That's correct. Thanks for the report.

I'll send v2 shortly.

Thanks
--
Gustavo

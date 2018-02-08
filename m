From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH v3 4/4] amdgpu/dc/calcs: Support clang option for stack
 alignment
Date: Thu, 8 Feb 2018 16:44:21 -0500
Message-ID: <dc344f23-663e-0e61-0b89-c4e358811e23@amd.com>
References: <20180208205316.93330-1-mka@chromium.org>
 <20180208205316.93330-4-mka@chromium.org>
 <953daf8c-b195-e983-ecc4-4b369515e9ac@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <953daf8c-b195-e983-ecc4-4b369515e9ac@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: Craig Bergstrom <craigb@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Justin TerAvest <teravest@chromium.org>, amd-gfx@lists.freedesktop.org, Guenter Roeck <groeck@chromium.org>
List-Id: amd-gfx.lists.freedesktop.org

On 2018-02-08 04:03 PM, Harry Wentland wrote:
> On 2018-02-08 03:53 PM, Matthias Kaehlcke wrote:
>> calcs uses the compiler option -mpreferred-stack-boundary=4 to configure
>> a stack alignment of 16 bytes. Clang uses the option -mstack-alignment
>> instead, which expects as parameter the alignment in bytes, and not a
>> power of two like -mpreferred-stack-boundary.
>>
>> Probe for both compiler options and use the correct one, similar to
>> what is done in arch/x86/Makefile.
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Series is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

... and merged to amd-staging-drm-next.

I had to resolve a small conflict with patches 1 & 2. Not a big deal but curious what development branch you use. We normally use this for amd-gfx development: https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-drm-next (although it might be a bit behind our internal dev tree).

Harry

> 
> Harry
> 
>> ---
>> Changes in v3:
>> - patch added
>>
>> Note to self: if this patterns proliferates further we probably want to
>> put the evaluation of the correct compiler flag in some common place.
>>
>>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> index af0f452f3c9f..95f332ee3e7e 100644
>> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> @@ -24,7 +24,13 @@
>>  # It calculates Bandwidth and Watermarks values for HW programming
>>  #
>>  
>> -calcs_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
>> +ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
>> +	cc_stack_align := -mpreferred-stack-boundary=4
>> +else ifneq ($(call cc-option, -mstack-alignment=16),)
>> +	cc_stack_align := -mstack-alignment=16
>> +endif
>> +
>> +calcs_ccflags := -mhard-float -msse $(cc_stack_align)
>>  
>>  CFLAGS_dcn_calcs.o := $(calcs_ccflags)
>>  CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

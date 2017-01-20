From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: amdgpu: Corrupted video on 32 bit systems (possible fix)
Date: Fri, 20 Jan 2017 10:11:41 +0100
Message-ID: <d45d5242-5c42-1ac7-d850-dae49804ec09@vodafone.de>
References: <20170119193537.GA3296@teela.fritz.box>
 <40da3f7e-6634-7588-36b5-f03378faee26@daenzer.net>
 <20170120074427.GA2793@boerne.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120074427.GA2793@boerne.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
To: Nils Holland <nholland@tisys.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Am 20.01.2017 um 08:44 schrieb Nils Holland:
> On Fri, Jan 20, 2017 at 11:47:53AM +0900, Michel Dänzer wrote:
>> On 20/01/17 04:35 AM, Nils Holland wrote:
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c	2016-12-11 20:17:54.000000000 +0100
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c	2017-01-19 15:38:56.972034489 +0100
>>> @@ -372,6 +372,10 @@
>>>   	if (!drm_arch_can_wc_memory())
>>>   		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>>   
>>> +	#ifdef CONFIG_X86_32
>>> +		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>> +	#endif
>>> +
>>>   	amdgpu_fill_placement_to_bo(bo, placement);
>>>   	/* Kernel allocation are uninterruptible */
>>>   	r = ttm_bo_init(&adev->mman.bdev, &bo->tbo, size, type,
>> The corresponding code in the radeon driver has changed quite a bit
>> since this original fix. It would be better to bring the amdgpu code in
>> line with the current radeon code.
>>
>>
>>> With this patch, the amdgpu driver works fine for me on my 32 bit
>>> kernel: All graphics output looks the way it's supposed to, even with
>>> full acceleration enabled - great!
>>>
>>> I'd suggest that it might be a good idea to put to apply the above
>>> patch or something similar to the official sources.
>> Indeed. Do you want to create a proper patch and submit it to the
>> amd-gfx mailing list for review? See Documentation/SubmittingPatches for
>> more information.
> Sounds like a good idea! I was a bit heasitant because, to be honest,
> I'm not at all an expert about the code in question and basically only
> saw how you fixed the issue in radeon and thought: "Well, let's see if
> I can do the same thing in amdgpu and if so, if it helps there, too".
> ;-)

Well first of all thanks for testing this and pointing into the correct 
direction how to fix the issue.

>
> However, since you've said that a 32 bit fix in amdgpu generally seems
> like a good idea, I would indeed use a little time on the weekend to
> get a proper patch ready and submit it for review. Even if the "no wc
> for x86_32" part is probably the only thing it'll contain - more of
> "bringing the amdgpu code in line with the current radeon code" might,
> for the time being, be beyond my capabilities, at least if we assume
> that the code should stay in a sane and working condition. ;-)

The amdgpu code is a successor of the radeon code, we just forked it of 
to avoid regressing radeon while working on new stuff (and radeon just 
became way to big to handle).

Unfortunately that fork happened before the final fix in radeon for 
32bit systems landed. I think it's just the #if condition which changed 
on radeon, e.g. instead of always disabling it on 32bit X86 we do so 
when the feature needed for USWC isn't enabled on the architecture in 
general IIRC.

Shouldn't be to much of an issue to port the current status over to amdgpu.

Regards,
Christian.

>
> Thanks and greetings
> Nils
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

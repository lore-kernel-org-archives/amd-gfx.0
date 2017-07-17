From: "Zhang, Jerry (Junwei)" <Jerry.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: read reg in each iterate of psp_wait_for
 loop
Date: Mon, 17 Jul 2017 16:56:26 +0800
Message-ID: <596C7BBA.2010300@amd.com>
References: <1500027617-18557-1-git-send-email-Jerry.Zhang@amd.com> <20170717075209.GA16630@hr-amur2> <20170717075755.GB16630@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170717075755.GB16630@hr-amur2>
Sender: stable-owner@vger.kernel.org
To: Huang Rui <ray.huang@amd.com>, Ken Wang <Qingqing.Wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

+ stable@vger.kernel.org

On 07/17/2017 03:57 PM, Huang Rui wrote:
> On Mon, Jul 17, 2017 at 03:52:10PM +0800, Huang Rui wrote:
>> On Fri, Jul 14, 2017 at 06:20:17PM +0800, Junwei Zhang wrote:
>>> Signed-off-by: Junwei Zhang <Jerry.Zhang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> index ba743d4..71ce3ee 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> @@ -95,9 +95,8 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
>>>   	int i;
>>>   	struct amdgpu_device *adev = psp->adev;
>>>
>>> -	val = RREG32(reg_index);
>>> -
>>>   	for (i = 0; i < adev->usec_timeout; i++) {
>>> +		val = RREG32(reg_index);
>>>   		if (check_changed) {
>>>   			if (val != reg_val)
>>>   				return 0;
>>
>> Nice catch. I remembered Ken also mentioned it before. This should fix the
>> issue I encountered before during bring-up. Can you open this handshake in
>> psp_v3_1_bootloader_load_sos and double check if this handshake is workable
>> with this fix. If yes, please add it back.

Yes, it could fix this.
Later I will enable it.

Jerry

>>
>> #if 0
>>          ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_81),
>>                             RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
>>                             0, true);
>> #endif
>>
>> Acked-by: Huang Rui <ray.huang@amd.com>
>
> BTW: please add Cc: <stable@vger.kernel.org> in your patch, it need be
> backported to stable tree.
>
> Thanks,
> Rui
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C7AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 08:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7DC10E84D;
	Mon, 28 Mar 2022 08:08:48 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5461210E84D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 08:08:47 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aef5a.dynamic.kabel-deutschland.de
 [95.90.239.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id B2CA561EA1927;
 Mon, 28 Mar 2022 10:08:45 +0200 (CEST)
Message-ID: <92b220d2-1d1b-c673-f9f9-3636dc1ba804@molgen.mpg.de>
Date: Mon, 28 Mar 2022 10:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
Content-Language: en-US
To: Mohammad Zafar Ziya <Mohammadzafar.Ziya@amd.com>,
 Tao Zhou <Tao.Zhou1@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
 <20220328062453.4156191-6-Mohammadzafar.ziya@amd.com>
 <DM5PR12MB17706851354758760795883DB01D9@DM5PR12MB1770.namprd12.prod.outlook.com>
 <3c80e4e5-97fc-9222-d9a3-f676125b0f5c@molgen.mpg.de>
 <PH0PR12MB545100117A4F02A2C98BCE0E981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <PH0PR12MB545100117A4F02A2C98BCE0E981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Mohammad,


Am 28.03.22 um 10:00 schrieb Ziya, Mohammad zafar:

[…]

>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Monday, March 28, 2022 1:22 PM

[…]

>> Tao, it’s hard to find your reply in the quote, as the message is not quoted
>> correctly (> prepended). Is it possible to use a different email client?
>>
>>
>> Am 28.03.22 um 09:43 schrieb Zhou1, Tao:
>>> -----Original Message-----
>>> From: Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>
>>> Sent: Monday, March 28, 2022 2:25 PM

[…]

>>> +static uint32_t vcn_v2_6_query_poison_by_instance(struct amdgpu_device *adev,
>>> +			uint32_t instance, uint32_t sub_block) {
>>> +	uint32_t poison_stat = 0, reg_value = 0;
>>> +
>>> +	switch (sub_block) {
>>> +	case AMDGPU_VCN_V2_6_VCPU_VCODEC:
>>> +		reg_value = RREG32_SOC15(VCN, instance, mmUVD_RAS_VCPU_VCODEC_STATUS);
>>> +		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_VCPU_VCODEC_STATUS, POISONED_PF);
>>> +		break;
>>> +	default:
>>> +		break;
>>> +	};
>>> +
>>> +	if (poison_stat)
>>> +		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
>>> +			instance, sub_block);
>>
>> What should a user do with that information? Faulty hardware, …?
> 
> [Mohammad]: This message will help to identify the faulty hardware,
> the hardware ID will also log along with poison, help to identify
> among multiple hardware installed on the system.

Thank you for clarifying. If it’s indeed faulty hardware, should the log 
level be increased to be an error? Keep in mind, that normal ignorant 
users (like me) are reading the message, and it’d be great to guide them 
a little. They do not know what “Poison“ means I guess. Maybe:

A hardware corruption was found indicating the device might be faulty. 
(Poison detected in VCN%d, sub_block%d)\n

(Keep in mind, I do not know anything about RAS.)

>>> +
>>> +	return poison_stat;
>>> +}
>>> +
>>> +static bool vcn_v2_6_query_poison_status(struct amdgpu_device *adev) {
>>> +	uint32_t inst, sub;
>>> +	uint32_t poison_stat = 0;
>>> +
>>> +	for (inst = 0; inst < adev->vcn.num_vcn_inst; inst++)
>>> +		for (sub = 0; sub < AMDGPU_VCN_V2_6_MAX_SUB_BLOCK; sub++)
>>> +			poison_stat +=
>>> +			vcn_v2_6_query_poison_by_instance(adev, inst, sub);
>>> +
>>> +	return poison_stat ? true : false;
>>>
>>> [Tao] just want to confirm the logic, if the POISONED_PF of one instance is 1
>> and another is 0, the poison_stat is true, correct?
>>> Can we add a print message for this case? Same question to JPEG.
> 
> [Mohammad]: Message will be printed on function block ahead of the function.
> 
>> Is the `dev_info` message in `vcn_v2_6_query_poison_by_instance()` doing
>> what you want?
>>
>> Also, instead of `poison_stat ? true : false;` a common pattern is
>> `!!poison_stat` I believe.

[…]

> [Mohammad]: Noted the change. Will make to return !!poison_stat ? true : false;

No, just

     return !!poison_stat;

[…]


Kind regards,

Paul

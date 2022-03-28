Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B07C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 09:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 072DD10E61A;
	Mon, 28 Mar 2022 09:55:54 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490B610E61A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 09:55:53 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9C63361EA1927;
 Mon, 28 Mar 2022 11:55:50 +0200 (CEST)
Message-ID: <096971c4-6d7f-57bc-0dcc-9fd5f815d89f@molgen.mpg.de>
Date: Mon, 28 Mar 2022 11:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
Content-Language: en-US
To: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>,
 Tao Zhou <Tao.Zhou1@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
 <20220328062453.4156191-6-Mohammadzafar.ziya@amd.com>
 <DM5PR12MB17706851354758760795883DB01D9@DM5PR12MB1770.namprd12.prod.outlook.com>
 <3c80e4e5-97fc-9222-d9a3-f676125b0f5c@molgen.mpg.de>
 <PH0PR12MB545100117A4F02A2C98BCE0E981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
 <92b220d2-1d1b-c673-f9f9-3636dc1ba804@molgen.mpg.de>
 <PH0PR12MB54519484FA4DFFBF63B0AE3C981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
 <0fe2edfd-b9ba-fa08-17fb-ebbf678b1b51@molgen.mpg.de>
 <PH0PR12MB54514F94A327C6A5E12BEE67981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <PH0PR12MB54514F94A327C6A5E12BEE67981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Mohammad,


Am 28.03.22 um 11:49 schrieb Ziya, Mohammad zafar:

>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Monday, March 28, 2022 3:08 PM

>> Am 28.03.22 um 10:47 schrieb Ziya, Mohammad zafar:
>>
>> […]
>>
>>>> -----Original Message-----
>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>> Sent: Monday, March 28, 2022 1:39 PM
>>
>>>> Am 28.03.22 um 10:00 schrieb Ziya, Mohammad zafar:
>>>>
>>>> […]
>>>>
>>>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>>>> Sent: Monday, March 28, 2022 1:22 PM
>>
>>>>>> Am 28.03.22 um 09:43 schrieb Zhou1, Tao:
>>>>>>> -----Original Message-----
>>>>>>> From: Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>
>>>>>>> Sent: Monday, March 28, 2022 2:25 PM
>>>>
>>>> […]
>>>>
>>>>>>> +static uint32_t vcn_v2_6_query_poison_by_instance(struct amdgpu_device *adev,
>>>>>>> +			uint32_t instance, uint32_t sub_block) {
>>>>>>> +	uint32_t poison_stat = 0, reg_value = 0;
>>>>>>> +
>>>>>>> +	switch (sub_block) {
>>>>>>> +	case AMDGPU_VCN_V2_6_VCPU_VCODEC:
>>>>>>> +		reg_value = RREG32_SOC15(VCN, instance, mmUVD_RAS_VCPU_VCODEC_STATUS);
>>>>>>> +		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_VCPU_VCODEC_STATUS, POISONED_PF);
>>>>>>> +		break;
>>>>>>> +	default:
>>>>>>> +		break;
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	if (poison_stat)
>>>>>>> +		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
>>>>>>> +			instance, sub_block);
>>>>>>
>>>>>> What should a user do with that information? Faulty hardware, …?
>>>>>
>>>>> [Mohammad]: This message will help to identify the faulty hardware,
>>>>> the hardware ID will also log along with poison, help to identify
>>>>> among multiple hardware installed on the system.
>>>>
>>>> Thank you for clarifying. If it’s indeed faulty hardware, should the
>>>> log level be increased to be an error? Keep in mind, that normal
>>>> ignorant users (like me) are reading the message, and it’d be great
>>>> to guide them a little. They do not know what “Poison“ means I guess. Maybe:
>>>>
>>>> A hardware corruption was found indicating the device might be faulty.
>>>> (Poison detected in VCN%d, sub_block%d)\n
>>>>
>>>> (Keep in mind, I do not know anything about RAS.)
>>>
>>> [Mohammad]: It is an error condition, but this is just an information
>>> message which could have been ignored as well because VCN just
>>> consumed the poison, not created.
>>
>> Sorry, I have never seen these message in `dmesg`, so could you give an
>> example log please, what the user would see?
>>
> 
> [Mohammad]: [  231.181316] amdgpu 0000:8a:00.0: amdgpu: Poison detected in VCN0, sub_block0
> 
> Sample message from amdgpu " [  237.013029] amdgpu 0000:8a:00.0: amdgpu: HDCP: optional hdcp ta ucode is not available "

Hmm, that is six seconds later, so, if Linux logs other stuff in 
between, no idea if the connection will be made.

Both messages read like debug message, with normal users not having a 
clue what to do. Can that be improved by rewording them?


Kind regards,

Paul

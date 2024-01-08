Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6C1C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 08:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C505410E14C;
	Mon,  8 Jan 2024 08:33:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D376610E18D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 08:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdnAQqu8g514QkZOsx1GqIbheEjW0qYU7QlWqZMQa4W1SY59CDcR9eyFFBYVEFRZ1HmxuGp4LaPwVz5m0trLyRhdp0e0pkDmYkQxsZEosK7YmTHKYnwARKqfQaePr3Q5YwkPN45yAjSagmW6GPZ0MY9DR1GUtmKSuuomo4wYtYTzVvS1qffjQUfE0LHOBkjnCxTFhZxDmNrqYYC/rEKMTKjiunpY7iRfC5XCJ2WDrC1dMs4r2evcungp3muxIb53WyUcUTYEnxK89F6F/ud6babvQk1gEsmsNPqaHd9cia9SFUQU0i/VP95BR08EjijRDoFyQdcVVm3fLpw6K8c4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb6flv9cPNYbtDlLYA5y1mWY1vMG/EIcuhF2oPjKlg0=;
 b=dymjsaldoi3yJWg5P7VxvWgZaiF8/3tu6nH26ENhkq3yPP//z2VayPf8GbtlTSzb1F54oL1QmgI7tHo1kqqNanTKecu27/WeaxWWWg0RluBZ8gJwlf8ffCn7lh/PCjolbc+08whVn4Hp3LYzkF9JIU7KFJsa/O7Jw4tAxni56nHuAWZDtAEtu5apVJFjRQRWL9PETXUH+Vw6QTf/webHzgQrIDanyvMzzMJkR9QQVVZMLVw58fO8rQeEt2KYC7vUSEx24LuKUZU3/dnUbeFyn/zoPxLI0qFwqezFhYLydJMVaI5PbOrmETke/9xcNzytKotSllKgwH3P1VFTCwyPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb6flv9cPNYbtDlLYA5y1mWY1vMG/EIcuhF2oPjKlg0=;
 b=a2jzx058+cBNKm5Cba85sCMXsWb2+z2Z+qikZQHe5fpV7mfNitE8fNqrKt7olxqfFjCV36EC0ZNKq2J0MNrI8d0gvJzP3rYWqoFU/vkulNARVPqrJn2ATyF4xcRUsDeL68qKrHOi5dYyJuOIuFkG3khxGGs3/ILuNvoGyB90m8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 08:33:06 +0000
Received: from SA3PR12MB7808.namprd12.prod.outlook.com
 ([fe80::9ca0:c2c:c5b3:5635]) by SA3PR12MB7808.namprd12.prod.outlook.com
 ([fe80::9ca0:c2c:c5b3:5635%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 08:33:06 +0000
Message-ID: <d83c82ef-f9f3-46f0-99ed-8d115dbdd465@amd.com>
Date: Mon, 8 Jan 2024 14:02:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Update irq disable flow during unload
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
References: <20240105152100.471494-1-asad.kamal@amd.com>
 <5c1863cb-a528-4c12-9ad7-3c9589088863@amd.com>
 <DS7PR12MB60714005DFBD7DFF9754A23B8E6B2@DS7PR12MB6071.namprd12.prod.outlook.com>
 <1309eac6-7b01-4566-a83f-541dbc0a3132@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1309eac6-7b01-4566-a83f-541dbc0a3132@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::21) To SA3PR12MB7808.namprd12.prod.outlook.com
 (2603:10b6:806:31b::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7808:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a42836-f20b-4636-5729-08dc1024700c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bqycic8YXPjpgrBuebQi8hGfSbLOQTkVpbL9IiNkJ/KpAjsCUgOKkjuaR9iss3apw9eElW+LgZEkgv19osnmmTZpzSKSzcQLuxecclJFv4GobHsFU7YKiOQ8ivTYP5BjNuPYdAzMfEgM9SogW6pMN0Z8SqrLqbJO+R3rxsk3PhIkhpZEc/XibU/dzZhsiC1kAn2tjbVHleQrpPQmE1btE5LNzEoXfKlwytC/pbMUg9AJpCctzs8olMkAzUDbIy3Dy2rRZS7/2qJ4mluIH0VRBjvZbY1nmrhkkjkmbeBaxVHcOUxMD/85kX0OJzNL3lEhwpr487i6Q/Ne8mqtoH6WJRPcB5rKzRJGTzMCzBSUDztfTitAtLlDVWVa96hbsuUy53m3fo9oopXkfPacQ8J8PuE39GnTeSGk8WI0cQNzcfxUIOqWUr/b6TWda2hDTurgdQdU+H+CDhL48f2SAsKkLw8YdPZowZFHsTSi89e9kw/uamTCVmJKfVaBSiVoV4YbGadwDUHA+QLPlqbG9yD90JNjgZsKYS/NAFFkr6X8oAaiEEgg07qM8v+z+KILihe6MuDSK7uKm3o4SNgP1XB4kOg9pQeUgRS1G/SZfvX9rFlSB5v6OlzO8ajKGjrWAIrUFq529q26y7wqLAh/tcLA5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7808.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(8936002)(2616005)(26005)(8676002)(110136005)(6506007)(316002)(54906003)(6512007)(53546011)(66574015)(83380400001)(6486002)(31696002)(66556008)(66476007)(66946007)(41300700001)(86362001)(6666004)(6636002)(478600001)(36756003)(5660300002)(15650500001)(38100700002)(31686004)(2906002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFdWNkFUc2JSaUhZbVpwSU5mVVE2SGZ2QjdhUUhSZHVNTStiQ09jZDNUL3FN?=
 =?utf-8?B?eHpRYUl1ME9adTV5UUhuVTYyVFZVdlA4NVlHQ2xmdm1CaSsvOTBiRGdBZGph?=
 =?utf-8?B?U3lKZDVMUHQyaDh1ZmFwVnN2cExya0hqa1FFUXBKUFkrSFVRRTh1L3lMeW1h?=
 =?utf-8?B?bktzWUJQMmJ1RkJLR2tIMEJNTTdIOTVsOXlEUzRhZjFtdWl6emZaL3RvcXVn?=
 =?utf-8?B?SHJpZ1l2RTZrK1VQdHQ0R0s3RmlpM0F1QnFhdEdTK1BOYzJUbXozRmN0UnFK?=
 =?utf-8?B?RDJXZzYxSjR3U0tkUTJvajc2MUFvQ1ZSM2NiY3cwUHNFdFFlVVhQSEllZUY3?=
 =?utf-8?B?V0RvdHYwb3J1MnBIb01iU0dJSkU3bDA5cmpySytnZnNXQlcxVmFFRXV3Um12?=
 =?utf-8?B?SGpyODhvY0RJai9GK2NWN1k1MklicW9rbStYZXUrbmdoWFVIZ0NyMURTOTRi?=
 =?utf-8?B?eUpISG05SzZlSlp3VExGd1N4ckJMZjZCUGtnZFl2RC9QTFRraTZCVkpMdG5q?=
 =?utf-8?B?bi9PcE9GdXNjYWsxamVvN0s4TzFvMkF2QXZiUnNHT2hsazZjd2dYZTJvZEVj?=
 =?utf-8?B?SFJiQWE0cng4b0h2cjg4QVlFSW5TcW1BYU81QVhCenlrZTVLc3d0WnNKdE91?=
 =?utf-8?B?a0Z6VkpkdVZKSUhVN09YOGUvall3cE5ta28xWURxODNGcXc1b3VwZ3M3OHlZ?=
 =?utf-8?B?eUdoaGhLMmNCekE2dGVkQXpZL0w2VXppMWpDOUJOV2I4c0VFNzBHbm9Ta0Zt?=
 =?utf-8?B?YzVaTTZvdmxHeFVXZjNEYWhhbk9LNXZHd0RrYWtBeGJlSXZETjB6U1BnY1cr?=
 =?utf-8?B?aEFDZUI0QXJHRDhSeUVjM3QwbTl4VUp4RmJSdDBpS0o1eUdSb0dVRHc2Znly?=
 =?utf-8?B?cEhZRHJteUthYzBUUGJpSUxCNWh4S0dZTlFJS295YWNiYjhGeVd3NkFFc1o0?=
 =?utf-8?B?S1BmZUNrNS9RSFdicGdhVmFlL05TQURvQTRWOW1wTG1YTnlQQm80MnZ0cFBZ?=
 =?utf-8?B?N2pvTkRFc0RzQkhHQnNnRFUyWHZEWXJ1YzdrNWtwR28vVUp2SjFIc1RHby9C?=
 =?utf-8?B?UHNrajYxRVBKSXF5eHZFQW5hS2pDVzgvOWVtcVdqUTRhUkVuM0NueTM2V0x2?=
 =?utf-8?B?R012Q1NrTzIrZUhzS0tyYXh4WjZuc0xpMmtMN3dNTWdQQ2tsRXg0dVd1Ykc0?=
 =?utf-8?B?SHZCR0V1SXk5R1Fnc09ZWXRPWGY2VzVjNW5qKzlNUnVoRFZUcjJlY1R1TVd1?=
 =?utf-8?B?cmJkSHE3OTZENERGL0dxd2JDZWEwNERweWlCdVE4YjR5TGhlTVl3NzVDM3hC?=
 =?utf-8?B?akNsMHhCSnFHZEg3cEp5VzlsdStQUnJBdVFxZXZ5WDB2SHJRZDdsbkdYUkFr?=
 =?utf-8?B?eDRvUzlsV1h2V2hZVG1qR2NBVTJINm1HNHZyVWhpaHhUSXVWanZMV1ZDSU8y?=
 =?utf-8?B?Zkg4UWFvOUdyWFlwSktjSWVLbE1VQVdFc1lPOC9teXNHUnZPNzI2RGNNTmxF?=
 =?utf-8?B?dlIwYnBMVVByQWNwN3RhMWY0aDdZM0RydVYvUEFUcXliNk5tMjl5RzZ6SEds?=
 =?utf-8?B?TW1sREhFODhYSU92VHIreFd2REoyaW5KY3llRlR3NDFlaUxpYTErcTgrZml2?=
 =?utf-8?B?d28wR1BPNUxaQjBIN0ovZWMwY3VDSkVMYW5mYXJHQkFwbzdVWmFoSkdybGx6?=
 =?utf-8?B?Y1FhSDJjQ2hjREU2dDNKMSt5YVFGSHptS2htYWZLend1WFNBdmY1Z21sZnE0?=
 =?utf-8?B?Q2NsRExHcUVncFNGL201L3dJQnBpSmpLak5pMXBUOSsycjc1ckozUGJuVVAw?=
 =?utf-8?B?UWQxS2tXWGdWYXhsUWxJVDArb3ZSVHVHT2lIa1NNQWxPdWxmNmtsejBNYXUv?=
 =?utf-8?B?WnZmRENiRGR3L1RJQ1o2L1ZvYkUzMVgvaXdDVnAxM0pFclNaSGZFZTlSNmhY?=
 =?utf-8?B?aCtDR2dnMjJzSDlWb1VjMVU2a0NNS2Vrc3RUT0h5WEg2TWV5djF4cnFTV3Yy?=
 =?utf-8?B?dWJLWFlzd20vQVlHOVdyNzVGeFFhcWJYN01kY3Q0VTNPWWhNaUhmc3NNRk9i?=
 =?utf-8?B?YmY2QTRNUlRPT0pyZzcyRUdQcFg1UE5DTjhkOG05ZDlOODZYYjloWDVFT0h1?=
 =?utf-8?Q?2qIxA188x/ihX1/+Cc0YD1o0W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a42836-f20b-4636-5729-08dc1024700c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7808.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 08:33:06.8197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrMsk0pQSi/XxjhzdFfxmbpWyBIZ0jGDZs3qqfHioTmuzEpP1GVH9aEpJRTZOiac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/8/2024 1:51 PM, Christian König wrote:
> Am 08.01.24 um 09:13 schrieb Kamal, Asad:
>> [AMD Official Use Only - General]
>>
>> Hi Christian,
>>
>> Thank you for the comment.
>>
>> This is not normal reset, it is reset done during unload for smu 
>> v_13_0_2.
> 
> Yeah, but this doesn't explain the rational for this.
> 
> IRQ enable/disable should be balanced in hw_init()/hw_fini(), 
> independent of what else you do.
> 
> I'm not sure what you are trying to solve but this here is a complete 
> no-go.
> 

This is a special reset done during module unload by this commit - 
f5c7e7797060 ("drm/amdgpu: Adjust removal control flow for smu
v13_0_2"). Without this commit, it seems driver reload doesnt' work.

In this particular case, a the reset is done during unload and only 
resume sequence of only select IPs are done (part of the workaround in 
the patch). For those IPs, irqs are enabled during 
late_init/ras_late_init, and not during hw_init(), that part gets skipped.

The module unload sequence causes a WARN trace during irq_put of those 
IPs during hw_fini(). Those are mix of generic irqs and ras irqs, so 
there is no clean way to untangle it.

One thing that could be done is to add an extra check for 13.0.2 version 
to make it clear that this workaround is done for only for those ASICs.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks & Regards
>> Asad
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, January 8, 2024 1:33 PM
>> To: Kamal, Asad <Asad.Kamal@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Update irq disable flow during unload
>>
>> Am 05.01.24 um 16:21 schrieb Asad Kamal:
>>> In certain special cases, e.g device reset before module unload, irq
>>> gets disabled as part of reset sequence and won't get enabled back.
>>> Add special check to cover such scenarios
>> Well complete NAK to that. Resets shouldn't affect the IRQ state at all!
>>
>> If this is an issue then something else is broken.
>>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
>>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 ++++++++++--
>>>    drivers/gpu/drm/amd/amdgpu/soc15.c    | 13 +++++++++++--
>>>    2 files changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 372de9f1ce59..a4e1b9a58679 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -2361,6 +2361,7 @@ static void gmc_v9_0_gart_disable(struct 
>>> amdgpu_device *adev)
>>>    static int gmc_v9_0_hw_fini(void *handle)
>>>    {
>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +     bool irq_release = true;
>>>
>>>        gmc_v9_0_gart_disable(adev);
>>>
>>> @@ -2378,9 +2379,16 @@ static int gmc_v9_0_hw_fini(void *handle)
>>>        if (adev->mmhub.funcs->update_power_gating)
>>>                adev->mmhub.funcs->update_power_gating(adev, false);
>>>
>>> -     amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>>> +     if (adev->shutdown)
>>> +             irq_release = amdgpu_irq_enabled(adev, 
>>> &adev->gmc.vm_fault, 0);
>>>
>>> -     if (adev->gmc.ecc_irq.funcs &&
>>> +     if (irq_release)
>>> +             amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>>> +
>>> +     if (adev->shutdown)
>>> +             irq_release = amdgpu_irq_enabled(adev, 
>>> &adev->gmc.ecc_irq, 0);
>>> +
>>> +     if (adev->gmc.ecc_irq.funcs && irq_release &&
>>>                amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
>>>                amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> index 15033efec2ba..7ee835049d57 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> @@ -1266,6 +1266,7 @@ static int soc15_common_hw_init(void *handle)
>>>    static int soc15_common_hw_fini(void *handle)
>>>    {
>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +     bool irq_release = true;
>>>
>>>        /* Disable the doorbell aperture and selfring doorbell aperture
>>>         * separately in hw_fini because 
>>> soc15_enable_doorbell_aperture @@
>>> -1280,10 +1281,18 @@ static int soc15_common_hw_fini(void *handle)
>>>
>>>        if (adev->nbio.ras_if &&
>>>            amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
>>> -             if (adev->nbio.ras &&
>>> +             if (adev->shutdown)
>>> +                     irq_release = amdgpu_irq_enabled(adev,
>>> +&adev->nbio.ras_controller_irq, 0);
>>> +
>>> +             if (adev->nbio.ras && irq_release &&
>>>                    adev->nbio.ras->init_ras_controller_interrupt)
>>>                        amdgpu_irq_put(adev, 
>>> &adev->nbio.ras_controller_irq, 0);
>>> -             if (adev->nbio.ras &&
>>> +
>>> +             if (adev->shutdown)
>>> +                     irq_release = amdgpu_irq_enabled(adev,
>>> +                                     
>>> &adev->nbio.ras_err_event_athub_irq, 0);
>>> +
>>> +             if (adev->nbio.ras && irq_release &&
>>>                    adev->nbio.ras->init_ras_err_event_athub_interrupt)
>>>                        amdgpu_irq_put(adev, 
>>> &adev->nbio.ras_err_event_athub_irq, 0);
>>>        }
> 


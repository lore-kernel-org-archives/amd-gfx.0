Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6E9C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 08:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548A510F2F0;
	Wed,  3 Apr 2024 08:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FdlOBKyZ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2114.outbound.protection.outlook.com [40.107.101.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 953DE10EC1C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 08:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEPvxHbmJsv+FEeefKMs0XTZjIaltouaVI6f3Gp/mWem9RN9G/lO/Bt6IhABzZK9wJkJLFpE6jXU5XUlwC1UH4x0r11cxReRZzbGGjzH88w20uwMHoxgj3CPupPfsKKtb58icURttYS/ftYuyrw8HSaoCH9bSnoj8F223YhMsL3owoII0ZUEGFEDpfb5sxF0yXlFWZumsld3h1ALfXIzVgFV995fwhffhb8jU3TW+Hwo0F8KxUeF7WM2+gb6wAiGjXdX8+OseY8LnZIHD4ILr36QFIeAt29ndTI1HjmHRhFoBUjaRpkx3tespw8kMSTcgtUBagTBQ7dwTXErusQBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAFhqw7vdPpHU4Sm/IBWsD8CgNnDElWDEor+QsddBVE=;
 b=odNvV9dPct1Qf7c/H//Bf/RnCphk4PqP7EEjW8qj27dkEZgw9PleUsCqjvjVkFl1ZIHaujdLh7mrLo73NZi8Ei4AKVaIm+OvzVga7rYPAnDh9acnKca7JK3fKTQphdXypF6T2YYLqBgCq2AEFsRZqVslBul2cAN0S5nV9GnRQJL45FTgunt/azW5NqTXwkP9N4ExXLZjvNJ+/J3mGAt/upnAhcrtCcCas44Y1L8ZC7kGcQlUF1Wc3IJVJhqp6um1tnMDKFwAHUlzGiWSRaO2YlVud5gbfQpmNbbIAqufCU4uwOks7f3A0ijNq/lEuKChMZo8y8ENzfTn4IZjFi/j9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAFhqw7vdPpHU4Sm/IBWsD8CgNnDElWDEor+QsddBVE=;
 b=FdlOBKyZQfpPp8XCIutHd105nH1xPitiOrh3IKab6Bryq1V12yyDBBFuLQsKYDTFHroHhqpPizb4zis+0kELsMrMxWqcGXRAVCrsdOdwM2qsETzkrl+Lw3tX+sOpSIj1ByavvUTMfPcgV0B+rFct4/+vP0U3Nco1yI0oO+PIhT8=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 08:44:04 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 08:44:04 +0000
Message-ID: <8e93ebb9-7d4f-16cf-96f2-554c40f28c96@amd.com>
Date: Wed, 3 Apr 2024 10:44:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amdgpu: add post reset IP callback
Content-Language: en-US
To: "Yu, Lang" <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20240328044014.3278891-1-Lang.Yu@amd.com>
 <d3581afc-4bc4-4e42-a4f5-5b4be5f10ed3@gmail.com>
 <MW6PR12MB88988E7D5DB5D5E9C4ED1A45FB3D2@MW6PR12MB8898.namprd12.prod.outlook.com>
 <c037df2f-bca9-ffb6-a569-603f4d8edb29@amd.com>
 <MW6PR12MB8898C23F7466A6B0F12BFD18FB3D2@MW6PR12MB8898.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <MW6PR12MB8898C23F7466A6B0F12BFD18FB3D2@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0375.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::9) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH0PR12MB8150:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gjf/VKP2BXk9SsCrYQh8m3iQrFXaE2oYyXPUTHERR9dKqT2j06YZ1icUCdAJ4oQuXpxJuUp4JK99Y0ox7CcDNpqlRJ6u5GRxWzWyC8c0mIzpcxAMwSOndI/b3UwfxR8lhi7yXJ5Pwdlezq6SDbFAIRQhnXg+4cdBSn74aEU5e94G84K4qHHaJV7WeBvW2eqN7bFcsY5L6+9iruMyynrIEqoRAQVHgErpdyw0h0oQM1VqFbR1pKjnx7B3vRbRJxn+Hx8vt8xIfpEFwSP058fCk7U02T6WleRZ/DftpXSMH98+JC2oW7Cb8AkAxCIH2qAT0T4RqGpUD4ZnrkR6v0Sp82uOOYku2fXD6LQtMXwEP9P+DnlW2/m20Ys/O3kZUtNV2K0X/FE/qPx9sCge9VVYAl823bks5Vbp8r/JL11dHFo3nDdDT2z3yiVaKfJtNQd4Ph1gDnG8jkvs+PVrvuN5M3YfJXf1ShuVpQGP+WdBUDP+b8JtUqv+iUQw7iRU9nbdh7qMHp8IrxQThRD2lKv6HQVxMFnwrPot/PgDFh4u7vDw1YfKvhXYmlLXzQJUx1BFsCz2JqcwiGlI1rOi85crvSONQrteiQjZpcBhhQaO9Yh1nx+AGXaU9CYZfqzUu57PZkQjwFtLJ7l0S4hZT0OyB1Ep1j2hlfRfrXyCX9c57YU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZZb28yZDFnb3JNR1BuUGhiWEVWYUppM0hSendlblNIWVFOMVB4YUQ3VWt4?=
 =?utf-8?B?UGdtRjl0bkQrQkpQS3RwVGNaZWpIZVo3cXgzSnpVT3BXa0QxR1g0ZE5DZ1I3?=
 =?utf-8?B?Y1JDOTgzb2NGMnVNNDdNSlBaZlFaZlZVd2JxNlNvMGFkQm44Y0ErMjVCWTVn?=
 =?utf-8?B?Y09vcWh2aGc0RWhVaDd6TUcvdUZ5YWxLaExoc0RGejJwK01WbWpNVTQ1U1pU?=
 =?utf-8?B?d0VjNFAxeFdBQlNIdW04REo4V1FTWThzSFpXWmYzRWd1dGY0RnVjaElYSFdx?=
 =?utf-8?B?bzlNVDlqYThQb1lvVlQzai82ZFM0U1M1b2V2UGNjbURLM3MrR0NBZUZZRWlN?=
 =?utf-8?B?QXpqWVgxWFhVbjBldTh2dk93RDUyV0ZzdkFiZkc2VUlWdEZmYm9hM2pHbVV5?=
 =?utf-8?B?TkVRTkV4Mng1d2loUk0vTkJqajRlNHBEY1Q3elZGZ252RjJBZXp1TjM0VkMr?=
 =?utf-8?B?RnRyRGlFeHRkREhaZGYyZlUwb2VNV0dFYWI2RVIxbXJ4b09kZEVvbDNMZTQ1?=
 =?utf-8?B?ZE11YlB3R1h5SWI2WXBHcnpEU0Fra3lNMFlyYU9qN2FhSlBnb1JiQTFHdURP?=
 =?utf-8?B?RzVCTVI2TndzZGJ1dTVjWXNuVlhTdUpvZ2NNL0FMUGdxVGNrR2tVMUhQQ3pr?=
 =?utf-8?B?M3crT0pZeGV0c3lacjlsdENmcEJ6cU9aMVVEVlBFWWU2MHppZURwNFJidGsx?=
 =?utf-8?B?YW1Tc1BvTWxsdytITVRvcWxwb01qZDdFaXRmcHRpbjJWZEQwZFAzN2EvSy9S?=
 =?utf-8?B?dXpOWTdWRXduOU0rcEJSK2pUTnBqT0ZtUWRnV1JKUzFPTldBRElZUUZINFEz?=
 =?utf-8?B?RHlTczJZNmNSeXg3cGRmZExYbDR0bVUyUExNc0FVNGE4TkN5RXBDS2xBSks5?=
 =?utf-8?B?WERCTERYVTA0bjU1WHhlWXc0bE0xWFlHZGEwbnlZcXBYZU5PQmtkM2hIK3Br?=
 =?utf-8?B?eUVLRVZVOEpoc3hlOEJLVXBxL3hnekNnUCtFeUJXamVrNmpxZW4vN2luWlJa?=
 =?utf-8?B?MCtaUmRpeTVjTjllM3BsSkVhd011aTY2Q0dLZGF2dzZ3eUpMYTJxRE5rdVVw?=
 =?utf-8?B?WXZWbm1xUjc5UnlJTWFBM202MEg1K3I2dkxIYUJIeWxXK2xjOGI2WTl4ZWNP?=
 =?utf-8?B?TnpVd1RBSFlReGRJSVBTWmdnUlBZY2dZUVBlb0JrK0ptZ056TVNkcGcxb2tp?=
 =?utf-8?B?eW5qdHRXd3cvUXphb2tseE0vRzl0aWtvMlJISW91V3RnVFdjcUExVmdDbGdD?=
 =?utf-8?B?ZWd4VE9CT2RMOWNPQzdhSTBQeUpMbnEvTnhyMDNYTlgyRVBnWU92cmRadzlS?=
 =?utf-8?B?TzRBYlFlamhzUHVjd3l5cmZkVTg3a3U4YTd5K1NGNXQrVFoybjI5NFNzRmYy?=
 =?utf-8?B?aXI0azE4enYxSURHZFNHMGJ2M29QdWlOUzlpNkJmbHljMnpvZTVNZ1E3em8r?=
 =?utf-8?B?QkE4NEhvTkQxRU15K0plc3gwaXRzci9STkdnb2lSaGpFZ0hHMlZoTTJhMTNi?=
 =?utf-8?B?WE9LdmY5U1dKVSs0MGpyL0F2Vk91cDBsODdDaUx3d0FMdldKemZZMUtmU3pD?=
 =?utf-8?B?ejlWdkhIVTRJa2Z4WUI2UjEwbjdpUlZhSERUU2ROWTlxQWhxVm5XbzYvY0Nq?=
 =?utf-8?B?dm1TajYzbmdZdUk4NnVIMEhybFhxRmlvcGw1eFJZUTlJbk5ZTlVzc1doWUor?=
 =?utf-8?B?NXZMWW12OVBRU0hUaUxVY0QvdWVmR0syaGVobGk0UVhvTExnT2kzN056WldC?=
 =?utf-8?B?YzNYYUJXU2gyMEEwaWhOd1dnN0hvcExFZkh2OEtGYlJhZHFid3RPNHlaZlB1?=
 =?utf-8?B?VXNxM1BEdUdYdjJxemI5ZW5lbWxlQVJNOUFZMG9NRU5SdUdKVTFZVWZ0eDNW?=
 =?utf-8?B?ZXBSTVNoRXJsQndpWE5FUlNWQnc2UG1pYnM5a1JQVzBrRVhUbGMrUW9hR3k5?=
 =?utf-8?B?dE56VmlKVjVVRzFhTmlZRWdyLzFtd0pXTlA1NUJaVTBMMlAwa2RSaWJoU2tt?=
 =?utf-8?B?bFpBay9zK0tKd3VSdHU1M3NoOTE3TXBUaHp2MEFzblBCTWc1NkUxZUFiOTRo?=
 =?utf-8?B?VGZoQktQeTJLYzNqams0UjE1VG5iODBQb1FaSC9NTnV2cGVJUEdKdTZaaFlJ?=
 =?utf-8?Q?8zFJr5T8m0ZBievtPyOm7j15E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5113fc55-d9e4-48bd-50c2-08dc53ba3787
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 08:44:04.2840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JcxdOwrTEyDLo7F7o1rqqjGQuPifOJoig21XBMniXT2kI5mO7fmQrHwVr+8CjxZD/0y8BgZkgSBZ654SkfXFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 03/04/2024 09:31, Yu, Lang wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Sharma, Shashank <Shashank.Sharma@amd.com>
>> Sent: Wednesday, April 3, 2024 3:19 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; Christian König
>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add post reset IP callback
>>
>> Hey Lang,
>>
>> On 03/04/2024 08:51, Yu, Lang wrote:
>>> [AMD Official Use Only - General]
>>>
>>>> -----Original Message-----
>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>> Sent: Tuesday, April 2, 2024 9:38 PM
>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>; Sharma, Shashank
>>>> <Shashank.Sharma@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: add post reset IP callback
>>>>
>>>> Am 28.03.24 um 05:40 schrieb Lang Yu:
>>>>> There are use cases which need full GPU functionality (e.g., VM
>>>>> update, TLB inavildate) when doing a GPU reset.
>>>>>
>>>>> Especially, the mes/umsch self tests which help validate the hw
>>>>> state after hw init like ring/ib tests.
>>>> I noted that before but just to repeat it once more: We can't do any
>>>> MES or UMSCH validation while doing a GPU reset!
>>> Yes, we can just easily disable it if it doesn't work well.
>>> But it doesn't take too much effort to make it work.
>>> It can expose issues as soon as possible and is useful for debugging
>> purpose.
>> IMO, its not that useful for debugging as well. In case of a problem, It will just
>> timeout waiting for MES packet write and we will still have to find out the
>> actual problem which caused MES to go into bad state in the last GPU reset.
>>>> The ring and IB tests use some pre-allocated memory we put aside for
>>>> the task during driver load and so can execute during GPU reset as well.
>>> If user space can create a VM and allocate memory during GPU reset, it
>>> makes no sense to prevent kernel space from doing that.
>> I think the objection here is mostly about why to do it at all, when it is not
>> helpful. It would be just a maintenance overhead.
> If you think it is not helpful,  why doing ring/ib tests?
That's because they add value during the bootup, when we know that the 
HW is being initialized in a controlled/systematic way. But in case of a 
GPU reset, it could go anyway and could be neither of those.
> I don't think such sanity test is not helpful.
>
> I only talk UMSCH test(different with MES test) here,

Your comment above about ring tests talks about both MES/UMSCH self 
tests, so it attracts attention on both.

If its only about UMSCH tests, I will let someone else to comment on that.

- Shashank

> I don't think it has a maintenance overhead.
>
> Regards,
> Lang
>
>> - Shashank
>>
>>>> But for the MES/UMSCH we need a full blown environment with VM and
>>>> submission infrastructure and setting that up isn't possible here.
>>> At least for UMSCH test, it only uses VM mapping functionality (if we
>>> can create a VM with cpu update mode, that's enough), it doesn't use
>>> other submission functionality.
>>> It is actually a compute context.
>>>
>>>
>>> Regards,
>>> Lang
>>>
>>>> Adding Shashank as well, but I think we should probably just
>>>> completely remove those from the kernel.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Add a post reset IP callback to handle such use cases which will be
>>>>> executed after GPU reset succeeds.
>>>>>
>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24
>>>> ++++++++++++++++++++++
>>>>>     drivers/gpu/drm/amd/include/amd_shared.h   |  3 +++
>>>>>     2 files changed, 27 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 12dc71a6b5db..feeab9397aab 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -5556,6 +5556,27 @@ static int
>> amdgpu_device_health_check(struct
>>>> list_head *device_list_handle)
>>>>>        return ret;
>>>>>     }
>>>>>
>>>>> +static int amdgpu_device_ip_post_reset(struct amdgpu_device *adev) {
>>>>> +    uint32_t i;
>>>>> +    int r;
>>>>> +
>>>>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>>>>> +            if (!adev->ip_blocks[i].status.valid ||
>>>>> +                !adev->ip_blocks[i].version->funcs->post_reset)
>>>>> +                    continue;
>>>>> +
>>>>> +            r = adev->ip_blocks[i].version->funcs->post_reset(adev);
>>>>> +            if (r) {
>>>>> +                    DRM_ERROR("post reset of IP block <%s>
>>>> failed %d\n",
>>>>> +                              adev->ip_blocks[i].version->funcs->name, r);
>>>>> +                    return r;
>>>>> +            }
>>>>> +    }
>>>>> +
>>>>> +    return r;
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>>>>>      *
>>>>> @@ -5805,6 +5826,9 @@ int amdgpu_device_gpu_recover(struct
>>>> amdgpu_device *adev,
>>>>>                amdgpu_put_xgmi_hive(hive);
>>>>>        }
>>>>>
>>>>> +    if (!r && !job_signaled)
>>>>> +            r = amdgpu_device_ip_post_reset(adev);
>>>>> +
>>>>>        if (r)
>>>>>                dev_info(adev->dev, "GPU reset end with ret = %d\n",
>>>>> r);
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>>>>> b/drivers/gpu/drm/amd/include/amd_shared.h
>>>>> index b0a6256e89f4..33ce30a8e3ab 100644
>>>>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>>>>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>>>>> @@ -287,6 +287,7 @@ enum amd_dpm_forced_level;
>>>>>      * @pre_soft_reset: pre soft reset the IP block
>>>>>      * @soft_reset: soft reset the IP block
>>>>>      * @post_soft_reset: post soft reset the IP block
>>>>> + * @post_reset: handles IP specific post reset stuff(e.g., self
>>>>> + test)
>>>>>      * @set_clockgating_state: enable/disable cg for the IP block
>>>>>      * @set_powergating_state: enable/disable pg for the IP block
>>>>>      * @get_clockgating_state: get current clockgating status @@
>>>>> -316,11
>>>>> +317,13 @@ struct amd_ip_funcs {
>>>>>        int (*pre_soft_reset)(void *handle);
>>>>>        int (*soft_reset)(void *handle);
>>>>>        int (*post_soft_reset)(void *handle);
>>>>> +    int (*post_reset)(void *handle);
>>>>>        int (*set_clockgating_state)(void *handle,
>>>>>                                     enum amd_clockgating_state state);
>>>>>        int (*set_powergating_state)(void *handle,
>>>>>                                     enum amd_powergating_state state);
>>>>>        void (*get_clockgating_state)(void *handle, u64 *flags);
>>>>> +
>>>>>     };
>>>>>
>>>>>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C8CC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 08:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A584F113638;
	Thu,  6 Jan 2022 08:29:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F5F113637
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 08:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhRYBfrwSYUX6Z7ukjMh2hzlzGHYjRKSELHIXGbAm8w0esHbfmj4UY0F80BXfnBTjxj77ZLrGdCGulSs9oFlNzNtWqqxviGsUoiEVTPsA/3NHLCoB5g0hJ5UBqdM2HqrzXqqVFsITiFCLX9x6ns5AaZWYbBs1mTINJEC1MRDkezeRYyb+qbY+7898dfFqvhK+BIDBPyvhSCNxaNyKX7kS0hpq5aDL31Dfa7w9cYniX8ibfXGjDPGyS2aWDx+OUAqnM4Vw5PMvYGrqfisgPQlE/cub1JXq7WmEhuRVsYy/oRbwluJWs23IP7WgOphi7rDe7ZhurKzCld534YoKu6MNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRIzA+JWRpZ2zasNXnf9BZlkGVHA61L7zo6FRI+V8L0=;
 b=BT/K5cRFIxgHlgjOMY2M8ixDdO1jN17FS7hN4f5JkRwifHToHBRe1ScrmrDVIZKsfMvKfKigq0YzpqRlH66vjHR8O4qjkBNpJIcOpZhUDI7eFgB8qSIzfjx/D5+uC+xKF6YFl2/8pBwyyd4DoWeD2PKVHGSsvAY9e/cOxRhKtdOg/dkqihomB2iajEkD56byahWbYpkiqjnxcDD7Ttx/+kyi/b4dNogQpJxVu7p4XpVdG7QaMvJaWo61xJFYf2AIuvWK4GY50Gw7VxLpRqWlOyAdZC1oZnoHHC3xgBXymu8WjHHXFzqI/tmsZ1X9DuYlCNuAGtQgmr+RC/s9CtbBlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRIzA+JWRpZ2zasNXnf9BZlkGVHA61L7zo6FRI+V8L0=;
 b=k/aEHgjndT5cl7rNfbb0gYkay1gfeXHqGSmPncmQeIEHi9xyfmyWgRdwVko/q5Q10P+Ur4bdWaJC7GAldoBc5IVuq98veE55/ptwv2rV6Dl+npvygbS4qb+XqyaVr7QC5WVruWgd9ofHyVMEAKvqEfdt+NTuyggSeDgMhu92t8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by SN6PR12MB2798.namprd12.prod.outlook.com (2603:10b6:805:69::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 08:29:06 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::183:1343:d261:7870]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::183:1343:d261:7870%4]) with mapi id 15.20.4844.017; Thu, 6 Jan 2022
 08:29:06 +0000
Message-ID: <7dbaa69b-2465-c1ab-9676-4dec289d6356@amd.com>
Date: Thu, 6 Jan 2022 13:58:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/7] drm/amd/pm: drop unneeded smu->metrics_lock
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220106055732.3073780-1-evan.quan@amd.com>
 <20220106055732.3073780-4-evan.quan@amd.com>
 <4c820046-fc95-e7ef-c857-eebea6542990@amd.com>
 <DM6PR12MB2619F53DE7747026D05E3A49E44C9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619F53DE7747026D05E3A49E44C9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::36) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a74c504-97f2-4166-d1fd-08d9d0ee9a5e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2798:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2798413B332B68977370347D974C9@SN6PR12MB2798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOO5v0QVit3UuMMBKl9BSmDDFSCWkbaXOjVAsjdvskEexq2G3RR1uE3UjdZWmGRomAEkeba4NgnwOGuQotZ5li/Mxr5wSGIeapor/AxSsdzW/Us9qU3fEI/+A6UQkwGIGdcUfWJNSCdN/IGsYsHVUnfYFdElbwNUWJCzZRKV1nNYlnfg3ittpj58ybkHzcQDuLdVOgYKvXaGVl1/32BtJn9rb1yaUJLzXLoWDNpqwlGw8s1rAbIoaseWGdM8pDiUgaFElI5BweOMixGWyQr8BIJO0GA8K/9KwztowNFCr2VMfpYP8NexuANZqJxto8ojD3+kdtj+zQrhV2wkmRoCh4WVDeP8zRZbRQMcT5xnjHlUmqWIz6qR9LkMBTaC1D0/eVi37EkXQ66eRmwHVsup6a02fvgIhJ6eqb9zH3THAMOuqSehN9U0m2GCRQIwahZgZzUfb2qbgbJmNYT4RP6n9nCNfWGWVTauMA9kRTFigK+3LSXqysxKXzEsphfsiNIremLIhzZkMfOu58+9ceVsZQ6JEoLBA664wULLmiwFHOLZpYqPF5LG5IMswRsRCowQw2Egt/jD9MPAwnzpbC3iChKheHmK5jEQgp8kKMmOrp6YI1POlqJ0T0F60iImBNgXXB720ekRJwSqHqr6sTW+lI2xWciUZ+N7welwt3o6ucri9IWBS7jzgoCtRA1LdaeVLKU2ymmLobVnhmxctjIfUU8IDTZBHOC+nhupMlcIKkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(6506007)(508600001)(4326008)(86362001)(26005)(53546011)(19627235002)(186003)(66946007)(36756003)(66556008)(31696002)(8936002)(30864003)(66476007)(83380400001)(110136005)(5660300002)(316002)(8676002)(6486002)(2906002)(38100700002)(6512007)(31686004)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0wwQXZ1bzUva3dkWDMwNno2WGVqNVFGNVlIQU40VnVEaGpNVFNGUHdpcUZa?=
 =?utf-8?B?M0FjKzZEN1FZMjBEUy9zbDNoT3hHRHdlMTNROWJhTHRlZVl6RTVCOTN1aFhz?=
 =?utf-8?B?R295NkRUbFNBL2ZmUStEcWVVbTNIcjBxR29SaExBa0lMME50cHJBZ3h3cjlu?=
 =?utf-8?B?c3RzdmZtN3h3NVhrSXA2R3dlSW1meXNDNW5nOUVIRWIyT3VML0p1NTRoN0J5?=
 =?utf-8?B?K3ZQNm54QTYxWDZUT2J0RGJEOEU5MytQTURBRFVYOW1NYU9WcjhGTDNsd0hI?=
 =?utf-8?B?NGlBbHQyME9uSEpTM0V4MnA1NFkwUWZPa0xqTDZ2UFBGclFIUDJwS1RGREFX?=
 =?utf-8?B?Yk8rOTV3ZmpkRE5vRGthVFdEY1BZb3ZqWmozNnJXTHo2cDBlZmRYQ3NsVXVL?=
 =?utf-8?B?YnEzdXc5Q2tVQXdreTdHY0NhbG9USVVwTkorMmttMnczOTFpdHdQSHp4Y1RU?=
 =?utf-8?B?LzZTNWxtVnRQbWhRY0JrTk9hem1DNzEyaXc0Zy9hTjNaM2VGYXE1K2s3bk83?=
 =?utf-8?B?UzdzMUdYTjg1R1JhcW01d2hiWVRtRk1ab0IyYUgvb3JnZSs4VmdvZW9vaVll?=
 =?utf-8?B?czhWSURQbVZlcFRmK0tBUzlMM1ZsZ1ZCdmdTU0QyVEZabmRaWHRzbDJBYkFD?=
 =?utf-8?B?NjMzRThJd2cweVcxVjdKTkh3cmtnajM0Rjh2bVU4L043QWZ2dDZrZ3ZPTzNi?=
 =?utf-8?B?N1E2RTl4Q2U4emNFaEtCdTVDSFZIRzc3bHlHQVhsNzJJNDdPM1RZdTcwcklK?=
 =?utf-8?B?eC9OM0gwMzNRdSs1dmZ4UGNPMTRrYW1VKzUxU2owR0pIdHAxWFVLN0E5c1Nv?=
 =?utf-8?B?SU9DWjBRMFo0WXRRZVU4Vng5ZGNwYk9SN1RBNC9IQUE4OWh2VEUyTTUyNEk1?=
 =?utf-8?B?RDhUODdVUU5ONTBKWkY5RG9FSzZsaVNKTU9Vd0tGc2JyZ2VMTHF4L0JhWnJU?=
 =?utf-8?B?OHc5ZWE4ZUw1TUcxTkZXVW1KR1VYSDQ2a2luaWZFRFF5WHlLRmxaZUdhRUND?=
 =?utf-8?B?TW9xdGQvcmVKb0ZhVm5ZVTZ3SFh1ZVpaMTArMVlXeVBtQWxTNnlPbzdybkNV?=
 =?utf-8?B?TjYxVWhEQ3FrNnVwYjF4dm5RYjRUVjJLWGk2Tno5WW8wd1I1T0hWcTg1ckFa?=
 =?utf-8?B?NDF0UXQ0WXZwdm9KQzNuMlZLL0VJaXFNR3hPVGFwejBwZ0NXbHc4Qi9RNDJP?=
 =?utf-8?B?dFo4WHZ0S3RYek9pUVcvUXd0UTNwR3c0YWVkLy8yWlZ6alFSc1haemVvTk1B?=
 =?utf-8?B?ZStFRG1hNDlmWXBnSTdVUy8vS3laVnZNWmVPN2lxNWpEZXB6VlE2YlJ0bmcw?=
 =?utf-8?B?S0grS3NIWmZTVlJkaWdnV1B4REpiVnd3d3Jxc2szQzhxSTMxNFZiTkNOaWRl?=
 =?utf-8?B?VWNybHMySGVOZ29kczlOcE5lbnV3Q3B6bXdEUnlnQ0FxMTVETERTVTZBbThv?=
 =?utf-8?B?bTFBS09nWFBCTDRKRHhNTkdVbkc2YmtMaDlkMm5PK2wrUWExQmVKNG5GVTYr?=
 =?utf-8?B?YmJiS0tZcWYvOHd5cnJ3OTB3eUdBR1AzNUwxQU1BRWdUMmQzVE5NS0dncUc2?=
 =?utf-8?B?TG1BRzh3NklROU5hZDRUc1VOZVRudzlnMEx4R1V1VlNpc1ZVcUNUU2I4cWJK?=
 =?utf-8?B?aE1wVkJOalRyZnM4MjZpS2hxOElHZGtNSmRORHVhTVdNanJRUWVCMENISTNW?=
 =?utf-8?B?Uld2dDNhMlNjZVNYd25Sc052Rkp3T0V3a093N24zVWhtUEg4UVVXMC9HR2Fv?=
 =?utf-8?B?eUltU2RsUGExVmJwV2FQZmhOSTNBVWJlTDhLVEVuT0FKdkY5T0wyNFdmQ0x6?=
 =?utf-8?B?S3NxVER0UWtqTnY2TTV6YUI3ZmtnSTNzdjVkWjlGYjBKYm1WSVMvbE1oNEw2?=
 =?utf-8?B?dWozWENIMmJBQzdXYWltMitZeWNxTUZKaDd1Qld0Y3NMeEFDWVdHdUJuMEFC?=
 =?utf-8?B?RXQ2V3h4SlJuczFaOG5uQ1F4M1BGQ2pmU21leDNteG9rT1V4MEJvRzJsNWJY?=
 =?utf-8?B?YmNYMk1kNVZpMGFpMEdPWUY0aTB6S2dxdUFlNHYvYVV3Z2VQUS8vek5KV1Ir?=
 =?utf-8?B?SjM4ZVpzcFJrR1ViZ0Uxbi9JS1pqZXNvMDNrb0dqRHNHY0FibjJ2Q1hMTEs0?=
 =?utf-8?Q?7jj8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a74c504-97f2-4166-d1fd-08d9d0ee9a5e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 08:29:06.5647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rmn7zeO56n1C0hnU+axMtBSIs6VRemMxWQ/Ca2PfaDSQF/tMBDJF4g83TrpFS5LI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2798
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/6/2022 12:32 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, January 6, 2022 2:17 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 3/7] drm/amd/pm: drop unneeded smu->metrics_lock
>>
>>
>>
>> On 1/6/2022 11:27 AM, Evan Quan wrote:
>>> As all those related APIs are already well protected by
>>> adev->pm.mutex and smu->message_lock.
>>>
>>
>> This one may be widely used. Instead of relying on pm.mutex it's better to
>> keep metrics lock so that multiple clients can read data without waiting on
>> other APIs that use pm.mutex.
> [Quan, Evan] If I understand it correctly, what you wanted to express is to use fine-grained lock instead of cross-grained one to avoid chasing for the same lock.
> Yes, that was what we did before and that's why we have so many types of locks. Below are my considerations for this:
> 1. We actually do not have such issue that many APIs/clients chasing for the same lock. Thus fine-grained locks cannot bring much benefits.
> Take the metrics_lock here for example.  The data protected by metrics_lock are for those pm sysfs interfaces. Those sysfs interface are not so frequently called. And almost all the time, they are called one after one. So, it's rarely they will chase for the same lock.
> 

It's not just sysfs, there are other interfaces like sensors, hwmons 
etc. Basically, metrics table provides data like GFX activity or 
throttler status that may be continuously monitored by app layer. So 
other APIs could suffer. My thought is to just keep metrics under a 
separate lock and not tie with pm.mutex.

Thanks,
Lijo

> 2. Cross-grained lock can simplify our implementations. It's hard to believe, there is 10+(actually 13 as I counted) different types of locks used in our existing power code.
> By the cross-grained lock, we can simplify the code and protect us from some unintentional dead-locks(I actually run into that several times and it's really tricky).
> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: Ic75326ba7b4b67be8762d5407d02f6c514e1ad35
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 -
>>>    drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 -
>>>    .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  14 +--
>>>    .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  10 +-
>>>    .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 112 +++++------------
>> -
>>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 ++---
>>>    .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  28 ++---
>>>    .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  14 +--
>>>    .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  23 ++--
>>>    .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  10 +-
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  21 +---
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 -
>>>    12 files changed, 70 insertions(+), 195 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index ecbc768dfe2f..f0136bf36533 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -956,7 +956,6 @@ static int smu_sw_init(void *handle)
>>>    	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
>>>
>>>    	mutex_init(&smu->sensor_lock);
>>> -	mutex_init(&smu->metrics_lock);
>>>    	mutex_init(&smu->message_lock);
>>>
>>>    	INIT_WORK(&smu->throttling_logging_work,
>>> smu_throttling_logging_work_fn); diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> index c3efe4fea5e0..63ed807c96f5 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> @@ -487,7 +487,6 @@ struct smu_context
>>>    	const struct cmn2asic_mapping	*pwr_src_map;
>>>    	const struct cmn2asic_mapping	*workload_map;
>>>    	struct mutex			sensor_lock;
>>> -	struct mutex			metrics_lock;
>>>    	struct mutex			message_lock;
>>>    	uint64_t pool_size;
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> index addb0472d040..3f7c1f23475b 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> @@ -602,15 +602,11 @@ static int arcturus_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>> metrics_table;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_CURR_GFXCLK:
>>> @@ -693,8 +689,6 @@ static int arcturus_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>> index 2238ee19c222..7ae6b1bd648a 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>> @@ -150,13 +150,9 @@ cyan_skillfish_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>> metrics_table;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_CURR_GFXCLK:
>>> @@ -200,8 +196,6 @@ cyan_skillfish_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> index fe17b3c1ece7..fdb059e7c6ba 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> @@ -546,15 +546,11 @@ static int
>> navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>    		(SmuMetrics_legacy_t *)smu_table->metrics_table;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_CURR_GFXCLK:
>>> @@ -624,8 +620,6 @@ static int
>> navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>    }
>>>
>>> @@ -638,15 +632,11 @@ static int navi10_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    		(SmuMetrics_t *)smu_table->metrics_table;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_CURR_GFXCLK:
>>> @@ -719,8 +709,6 @@ static int navi10_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>    }
>>>
>>> @@ -733,15 +721,11 @@ static int
>> navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>    		(SmuMetrics_NV12_legacy_t *)smu_table->metrics_table;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_CURR_GFXCLK:
>>> @@ -811,8 +795,6 @@ static int
>> navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>    }
>>>
>>> @@ -825,15 +807,11 @@ static int navi12_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    		(SmuMetrics_NV12_t *)smu_table->metrics_table;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_CURR_GFXCLK:
>>> @@ -906,8 +884,6 @@ static int navi12_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>    }
>>>
>>> @@ -2708,20 +2684,14 @@ static ssize_t
>> navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>>>    	SmuMetrics_legacy_t metrics;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       true);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					true);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	memcpy(&metrics, smu_table->metrics_table,
>>> sizeof(SmuMetrics_legacy_t));
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>
>>>    	gpu_metrics->temperature_edge = metrics.TemperatureEdge; @@
>>> -2899,20 +2869,14 @@ static ssize_t navi10_get_gpu_metrics(struct
>> smu_context *smu,
>>>    	SmuMetrics_t metrics;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       true);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					true);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	memcpy(&metrics, smu_table->metrics_table,
>> sizeof(SmuMetrics_t));
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>
>>>    	gpu_metrics->temperature_edge = metrics.TemperatureEdge; @@
>>> -2977,20 +2941,14 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct
>> smu_context *smu,
>>>    	SmuMetrics_NV12_legacy_t metrics;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       true);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					true);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	memcpy(&metrics, smu_table->metrics_table,
>>> sizeof(SmuMetrics_NV12_legacy_t));
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>
>>>    	gpu_metrics->temperature_edge = metrics.TemperatureEdge; @@
>>> -3058,20 +3016,14 @@ static ssize_t navi12_get_gpu_metrics(struct
>> smu_context *smu,
>>>    	SmuMetrics_NV12_t metrics;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       true);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					true);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	memcpy(&metrics, smu_table->metrics_table,
>>> sizeof(SmuMetrics_NV12_t));
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>
>>>    	gpu_metrics->temperature_edge = metrics.TemperatureEdge; diff --
>> git
>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> index 93caaf45a2db..2241250c2d2a 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> @@ -525,15 +525,11 @@ static int
>> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>>>    	uint16_t average_gfx_activity;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_CURR_GFXCLK:
>>> @@ -633,8 +629,6 @@ static int
>> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>
>>>    }
>>> @@ -3564,14 +3558,11 @@ static ssize_t
>> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>>>    	uint16_t average_gfx_activity;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       &metrics_external,
>>> -					       true);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					&metrics_external,
>>> +					true);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>
>>> @@ -3661,8 +3652,6 @@ static ssize_t
>> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>>>
>> 	smu_v11_0_get_current_pcie_link_speed(smu);
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>>>
>>>    	*table = (void *)gpu_metrics;
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> index 5cb07ed227fb..c736adca6fbb 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> @@ -273,15 +273,11 @@ static int
>> vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>    	SmuMetrics_legacy_t *metrics = (SmuMetrics_legacy_t
>> *)smu_table->metrics_table;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_CURR_GFXCLK:
>>> @@ -335,8 +331,6 @@ static int
>> vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>    }
>>>
>>> @@ -348,15 +342,11 @@ static int vangogh_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>> metrics_table;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_CURR_GFXCLK:
>>> @@ -410,8 +400,6 @@ static int vangogh_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> index 25c4b135f830..d75508085578 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> @@ -1128,15 +1128,11 @@ static int renoir_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>> metrics_table;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_AVERAGE_GFXCLK:
>>> @@ -1201,8 +1197,6 @@ static int renoir_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> index f065d95b117a..014fb88daa04 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> @@ -571,15 +571,11 @@ static int
>> aldebaran_get_smu_metrics_data(struct smu_context *smu,
>>>    	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>> metrics_table;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       NULL,
>>> -					       false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu,
>>> +					NULL,
>>> +					false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_CURR_GFXCLK:
>>> @@ -653,8 +649,6 @@ static int aldebaran_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>    }
>>>
>>> @@ -1592,17 +1586,14 @@ static void aldebaran_get_unique_id(struct
>> smu_context *smu)
>>>    	uint32_t upper32 = 0, lower32 = 0;
>>>    	int ret;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
>>> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>>>    	if (ret)
>>> -		goto out_unlock;
>>> +		goto out;
>>>
>>>    	upper32 = metrics->PublicSerialNumUpper32;
>>>    	lower32 = metrics->PublicSerialNumLower32;
>>>
>>> -out_unlock:
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>> +out:
>>>    	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
>>>    	if (adev->serial[0] == '\0')
>>>    		sprintf(adev->serial, "%016llx", adev->unique_id); diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>> index caf1775d48ef..451d30dcc639 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>> @@ -310,13 +310,9 @@ static int
>> yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>>>    	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>> metrics_table;
>>>    	int ret = 0;
>>>
>>> -	mutex_lock(&smu->metrics_lock);
>>> -
>>> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
>>> -	if (ret) {
>>> -		mutex_unlock(&smu->metrics_lock);
>>> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>>
>>>    	switch (member) {
>>>    	case METRICS_AVERAGE_GFXCLK:
>>> @@ -387,8 +383,6 @@ static int yellow_carp_get_smu_metrics_data(struct
>> smu_context *smu,
>>>    		break;
>>>    	}
>>>
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>>    	return ret;
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index 735e1a1e365d..d78e4f689a2a 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -964,9 +964,9 @@ int smu_cmn_write_pptable(struct smu_context
>> *smu)
>>>    				    true);
>>>    }
>>>
>>> -int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
>>> -				     void *metrics_table,
>>> -				     bool bypass_cache)
>>> +int smu_cmn_get_metrics_table(struct smu_context *smu,
>>> +			      void *metrics_table,
>>> +			      bool bypass_cache)
>>>    {
>>>    	struct smu_table_context *smu_table= &smu->smu_table;
>>>    	uint32_t table_size =
>>> @@ -994,21 +994,6 @@ int smu_cmn_get_metrics_table_locked(struct
>> smu_context *smu,
>>>    	return 0;
>>>    }
>>>
>>> -int smu_cmn_get_metrics_table(struct smu_context *smu,
>>> -			      void *metrics_table,
>>> -			      bool bypass_cache)
>>> -{
>>> -	int ret = 0;
>>> -
>>> -	mutex_lock(&smu->metrics_lock);
>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>> -					       metrics_table,
>>> -					       bypass_cache);
>>> -	mutex_unlock(&smu->metrics_lock);
>>> -
>>> -	return ret;
>>> -}
>>> -
>>>    void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t
>> crev)
>>>    {
>>>    	struct metrics_table_header *header = (struct metrics_table_header
>>> *)table; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> index 67a25da79256..f0b4fb2a0960 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> @@ -101,10 +101,6 @@ int smu_cmn_write_watermarks_table(struct
>>> smu_context *smu);
>>>
>>>    int smu_cmn_write_pptable(struct smu_context *smu);
>>>
>>> -int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
>>> -				     void *metrics_table,
>>> -				     bool bypass_cache);
>>> -
>>>    int smu_cmn_get_metrics_table(struct smu_context *smu,
>>>    			      void *metrics_table,
>>>    			      bool bypass_cache);
>>>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2A4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 11:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9100D6F5A6;
	Mon,  6 Dec 2021 11:37:10 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232E673D4B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 11:37:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OauTXjj6VY8ogTLanDKsS874JK9qT2zOndRvY295APM2HhYGAj4o+t5ixaLAYS0vLQERqC6gSZdyLY3BdUC2gxOUpMRGTnASqGncrujNbGLCgIpnYdUQHml1XLEgS1MSvt+T77b+L6WXoSuyeAqcEbvLJolMNx6Ny8J7Iw9pPgAuwfWph9lPrFDhRAUQ0jgXUuTzaEqroIhT7q7Z7ywmzwV7TxgjtYDqaNIXzEvBYfOy2g6zMNUzKJOnaxRcaVYD9gLBg1DOjuq5vzN4oFKrLeV7vMMXjgf9a4inQ57cHFexNczDMxjIK6U6f4QPjVuqaopU53RlBXCDbTU0HZA5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt2ChafQkTZKnB9fMPuDdudH3Q5gDrfqr2rzm5vsfe4=;
 b=Xvg2IdB3fZ7txco9h71iuCao/IlORS+sm2zzuynJ9z/626VbsnzUUmqA6+NJAvFNAPaKMbkthYrpz1bK0/gbA5yheZDNFx7B463qd+JEhhXEQ9fxTWK4ztuKdW2LJuPgoyXdwrwxazzSGiP7c34xEgnTMrGclrJ7TlTP0vqLtE/hZ/Y0aJ1FFYp78C1NqiZU5i8ng+uVhje2K3l2pp3gIqm+ym80UW9QJiI/Qf1SF7X/TFyYex3TPigzIHw0My5rF9EkEocBXeql30q+OVoFeCmvJH9VwksmV7wynpY6A9TEjh2zNnZae/9CpUcG4a5xWPjZZy9XalvB9iVITuRGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt2ChafQkTZKnB9fMPuDdudH3Q5gDrfqr2rzm5vsfe4=;
 b=MWwtpc4+a54lBRPHp5konE44VeSJiawAMONv1ixInNIlWKJ5pci/Zram6aqt06jDJsUvIQId2c+ET3T3Jp77ZN0ni1YJGmI0V79QsKZTEsuYmVixZaeOMFPL+ttWDFegQEDVm9yGZeaFra6TLapRCWozyjv1it9dtNxGcnQ6rj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 11:37:01 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.030; Mon, 6 Dec 2021
 11:37:01 +0000
Message-ID: <7be3f643-040e-e9ff-46b2-3739112c07e0@amd.com>
Date: Mon, 6 Dec 2021 17:06:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20211202191912.6148-1-alexander.deucher@amd.com>
 <b05f1327-b26d-ac47-4bac-f94979bd3741@gmail.com>
 <CADnq5_OgW3vfG5kjV-67KYc4RxavJeZOWvNEo5vm9siHj2B0HA@mail.gmail.com>
 <79ab8197-890a-494d-6687-de0f3d467360@gmail.com>
 <8e0b8d8f-b64f-8d17-a877-9a3171b60b2e@amd.com>
 <9d584c64-9351-5b84-6721-887aaeb0bc36@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <9d584c64-9351-5b84-6721-887aaeb0bc36@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::12) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:18::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Mon, 6 Dec 2021 11:36:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7359d4c5-b104-449a-4101-08d9b8acb7e9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB133738BCBEA32FC315289BBB976D9@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55bOyLQXl5fBdZUbNGbCyVv6zM4TzwkrMzCaP3j9OSOzbtGH2kr29l4sQMdLOTipweqmQ5HM8Zmbij6FMZey1u1LnHngdhf8JUzd2EwGGdYqLDBVvq+0Fb8BEmR+c2vSYdGo8+ZcE+o9JDXeth7I6TpPhzE/cpKnmZIFt358fWj7vXkmunoaMsM/yE7xb3hZyTs3bh6AEC0DP3ZWCoV7/ThQ8UDyQmAgNkqtLHG0VimpHfNKxraVhXHcxiVIbsLj19MhkQ9P9d6PZqr+50z7zMw567HnwkSuN022oGj016/yqd0uZVD36S9tVqPuMb18bnu8PYD+C7EiYBssKp74pt6WtW5+zkNS2r/aD5oAHnc3FnqWGb5HDBhG/lPyl31Aue2KtwcMKIN+8ghur3TDFz5PTTpaLuJQbInGgd1jActVzRcf9SKQYslhtI/fmYoTijM3bArGXn0A1Qw4vDif7T3KRGPAdFT/4RZlUWW3yD9H8a8RL5Px5+E8IVvMnT2NQp+/ILgF/r6F/mZ2vNLUuyTEZ4tQ8hEltvQeFq4H7ATCHudR7RzbNbBvLlp7qH945NFvRcTR9tCqNV6CSfdDZCiDR/dENTMhdhZb7tqdBvl59KfYmMMUTvukiftASjd6Uc7hzOrRHHaTwFJ9GsqemH1+C/FivAdUltsjPm5AZ42/7y8jQ3IziMWTF51kH5XAwe3evUfl/6KIWodcAH+FYWsygazd6QDkUO3TPdZwjH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(30864003)(316002)(508600001)(83380400001)(66574015)(8676002)(110136005)(2616005)(53546011)(31686004)(31696002)(38100700002)(66946007)(5660300002)(186003)(66556008)(8936002)(66476007)(2906002)(54906003)(4326008)(956004)(26005)(6486002)(6666004)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBYY3R5dVc2RzBnam1mRUJmK2dveWIvaWEvTUExNzY3Z3BPdlI3Y0UwNzlM?=
 =?utf-8?B?ODArbzBNWTZ1UVBrbkdLays0Y3BQK0F3aWVIb0p4OVFXek8xMUJzcjBTVVJK?=
 =?utf-8?B?dW9Za0JoaVhsR2ZwTDRHZmN4VDVKdkJXa3IrTFAwajJNOGl4czhPcWJrNEJu?=
 =?utf-8?B?bnV6eTg4eTBqRVFYb3g1SVM3MWpFWlhzLzA0eFlPcXNFYWFWWHdENWlldy9Y?=
 =?utf-8?B?UjlYMkh3cERqMWdYM3BPMXorSmhNZHlNdFlhNVdwUmFLRXlCbzFmVkwxQ1ly?=
 =?utf-8?B?SkJQbEVDZHdBayt1dGJXZ2NJRUUrdHgxRGl5SW9qRG5ORndvSWtTK2xBaDdE?=
 =?utf-8?B?RmZySE82WTdtS3FDam1qSzJzR095em51Ky96bHNTZVdWZFJ6SU9VV1V5R0Nn?=
 =?utf-8?B?UkhFTCt6b3g3NWFScjRtS1pHOUMrRFlQYlFINzFyalltVDBBY0hkMm9yeGt6?=
 =?utf-8?B?UTNYaWdDMFhPQ1JYcDFHSGU4UzFnc3E2angyeEtybHpsbzBuTmVxVU1lcWRM?=
 =?utf-8?B?SzB1U0g2bmprUnBEVVhaSjRDbmlFQ0lmZE9scUJpdm9CdkRQdmdPQmtYUXhF?=
 =?utf-8?B?Wmx0OTVBUGcyUE01Zm9CVG1GTTMvUzVTZ1dNWEtFTDFZSUpaTVRMNGJHNndE?=
 =?utf-8?B?bmZlN3kyY1FhQURvQm1DYStBeWI0Vk5CaEdMenhRcm4xRnFHVXdhZjBZc3Yz?=
 =?utf-8?B?N0hhODNuQ20zZVNiN1pabWRLVmpWN01iZlV1SmtiSHY0SmRhSGUyNVFPcWVT?=
 =?utf-8?B?dU9aempwZW5DVzA1b3k2UnkyUnFXTEZFZitYSmRVL3l0cTlEMmRjRnJNYkRQ?=
 =?utf-8?B?TjM5dmN0cmEyMEZOdDlZb1lDSGlndytrdXNjaUV4NG5KV0EyaWlzSS9teFR4?=
 =?utf-8?B?ZkFPN08xS2tBSWNoWDRTOGN3VGJEcHg2TXJjRFBjc1BMTXJweFpucVdIYVlZ?=
 =?utf-8?B?VWV4Y0dMRUJiRGdlUHV1QjhNRDdNdDRHL0VobGdQRTRnbDY4SGVTYXFYSTlO?=
 =?utf-8?B?MVB3ODJqcWpHaHZKN3VBZkJWeC9lZU5Ma2JDbXY1Smt2QkwreUlIWkEzdjFE?=
 =?utf-8?B?ekY1YlpmNldpYkp0ZE1xalNiVEo0dUFaWXhmOHhaVm9saTNJNUpoRTRKekp3?=
 =?utf-8?B?MHRMeE45RXRoUFF1MDBoc0N4WEpZYmdCK1BEZzltUWVwUlJXL3NaMzVucGF1?=
 =?utf-8?B?NHFqV3Vva0hSOTlENXp4WGZQODZFMVVETTlKNjNZVlBua0czbElnK0lMYVBD?=
 =?utf-8?B?aGxRTlh5Vk5qYXRabGNhTXljNmZVeW9kcjB5UmJ4K1Q0UDlJT3dhOUVoYWM4?=
 =?utf-8?B?b0gveDZ5ZStJUXJFRmNHU3V2VWcydllURmZsWEh5OHk4eXdZL0FpM1VRTE1k?=
 =?utf-8?B?Y2NyY1BvME92VEE3SlNFa2UzTzQxcXIvdzVDYi9iSm5uQStJQjlRd3ZORThK?=
 =?utf-8?B?VzZzSWN3cnNnN0F4UnArdk1TclNLRThST0daeEpGR05xODJCTVNzNk05ak9V?=
 =?utf-8?B?Rk00alJ0UFZRZ01wQkFZWnlkeEJrMkVpZjJmRGYvVmNGKzVhWEJCSGQxVUgv?=
 =?utf-8?B?QWlsV25mWnpjQnI0b0VrbVB2dklNREVzcEtYN21xRDNtdG9mbFBvZ0NYalZB?=
 =?utf-8?B?RFdCMk1ZU1NPaXZwcTFHUUMvYk9LWHY0MldXNThHLzFKUFNiSGVhZlh2b0lo?=
 =?utf-8?B?NldPMUkxeGxLamVON0E3ajBFTGc5Z0czalg2TUhmRG5RZkRKZFdvSlc1VTQ5?=
 =?utf-8?B?ejV3UWpMM2k1dVUrR01xajNCWUNVM3ZkM0RpU2w5anVkejlNTUltVk9pazB3?=
 =?utf-8?B?Z0dpYzZ3NjN5MGdnNTQyZzVnek5ud2R6azlNV0x0bEFQbVdBUno1cG9vREg4?=
 =?utf-8?B?Nll4d2JjUFJ4U1JCeTZVM2QySzlRbFJQMDJodys3N052MFMvaERqUGRwVEla?=
 =?utf-8?B?WTh1TkpFcGxlSWViVkIyNXhJd2tOVEFsSHIrOTNaMy9CMEo2N1RKYXJQaGFn?=
 =?utf-8?B?NDdXQ3RJK1p6S0xxTVQvVlduRVhQV2xxZndBVWNCb0NlajBMQy93djVRUGlM?=
 =?utf-8?B?Z2tZT0NEU2c0dW1pVnZDemJwaDlxT2dVWjk4Y3dDRXdobFdpdGNsVkFIaUd5?=
 =?utf-8?Q?psWU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7359d4c5-b104-449a-4101-08d9b8acb7e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 11:37:01.2546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9T0+pkprTI0/5X8L7XhxbZDM5XPttubvCUG2jvPdNzsAo43CheFM+ryv9tPr/m88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/6/2021 4:52 PM, Christian König wrote:
> Am 06.12.21 um 11:56 schrieb Lazar, Lijo:
>> On 12/5/2021 2:53 PM, Christian König wrote:
>>> Am 03.12.21 um 17:13 schrieb Alex Deucher:
>>>> On Fri, Dec 3, 2021 at 7:15 AM Christian König
>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>> Am 02.12.21 um 20:19 schrieb Alex Deucher:
>>>>>> This adds a new IOCTL currently used to implement querying
>>>>>> and setting the stable power state for GPU profiling.  The
>>>>>> stable pstates use fixed clocks and disable certain power
>>>>>> features in order to get accurate pipeline profiling.
>>>>>>
>>>>>> Currently this is handled via sysfs, and that is still
>>>>>> available, but this makes it easier for applications
>>>>>> to utilize.  Note that the power state is global so
>>>>>> setting it will affect all applications.  There are currently
>>>>>> no checks in place to prevent multiple applications from
>>>>>> using this interface, but it doesn't make sense to do
>>>>>> profiling while you have multiple applications running in the
>>>>>> first place, so it's up to the user to ensure this in order
>>>>>> to get good results.
>>>>>>
>>>>>> This patch add an interface to query what profiling mode is
>>>>>> currently active and to set enable a profiling mode.
>>>>> First of all I wouldn't call this profiling mode. Profiling is the use
>>>>> case, but performance and power management are what is controlled 
>>>>> here.
>>>>>
>>>> Ok.
>>>>
>>>>> Then we already have functionality for process and context priority
>>>>> override for the SW scheduler in amdgpu_sched.c. I think we should add
>>>>> this functionality there.
>>>> I'm not sure I follow.  Do you mean to integrate this with the
>>>> rendering context?  That was what my original patch did (attached).
>>>> Or were you thinking it would be better to make this part of the sched
>>>> ioctl?
>>>
>>> The later,
>>>
>>> The scheduler IOCTLs are all about adjusting the default priority of 
>>> a process (and optionally a context as well).
>>>
>>> Putting the hardware power management control alongside that kind of 
>>> makes sense I think.
>>>
>>> Something like AMDGPU_SCHED_OP_POWER.
>>
>> That doesn't make sense to me. This is not optimizing scheduling for 
>> power. These settings are applied to the whole hardware. Even if we 
>> assume a hypothetical case of 'no-scheduler' (only one app running), 
>> the settings can be used to figure out whether an app is sensitive to 
>> GFXCLK vs MCLK or which phases of the app are sensitive.
> 
> What clocks are eventually in use is pretty much irrelevant. The 
> functionality is that the application is defining a power level to use 
> when it is active.
> 

Exactly and it's irrelevant how it is made active. It just wants to run 
something under certain conditions for specific cases.

For ex: it could just collect some data for a time period less than 
scheduled quantum and it could make use of in the next phase of its 
logic. It is very much internal to the app and I don't see any scheduler 
related logic inside that (just because an app is made active by a 
scheduler).

Thanks,
Lijo

> That we currently do that globally and only allow the first application 
> to modify this is an implementation detail.
> 
> Regards,
> Christian.
> 
>>
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Christian.
>>>
>>>>
>>>> Alex
>>>>
>>>>
>>>>> Christian.
>>>>>
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c | 112 
>>>>>> ++++++++++++++++++++
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h |  30 ++++++
>>>>>>    include/uapi/drm/amdgpu_drm.h               |  28 +++++
>>>>>>    5 files changed, 173 insertions(+), 1 deletion(-)
>>>>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> index 7fedbb725e17..4cf5bf637a9e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> @@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>>        amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o 
>>>>>> amdgpu_nbio.o \
>>>>>>        amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o 
>>>>>> amdgpu_rap.o \
>>>>>>        amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
>>>>>> -     amdgpu_eeprom.o amdgpu_mca.o
>>>>>> +     amdgpu_eeprom.o amdgpu_mca.o amdgpu_profile.o
>>>>>>
>>>>>>    amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> index bc1355c6248d..0e27f9673f8f 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> @@ -46,6 +46,7 @@
>>>>>>    #include "amdgpu_sched.h"
>>>>>>    #include "amdgpu_fdinfo.h"
>>>>>>    #include "amdgpu_amdkfd.h"
>>>>>> +#include "amdgpu_profile.h"
>>>>>>
>>>>>>    #include "amdgpu_ras.h"
>>>>>>    #include "amdgpu_xgmi.h"
>>>>>> @@ -2467,6 +2468,7 @@ const struct drm_ioctl_desc 
>>>>>> amdgpu_ioctls_kms[] = {
>>>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, 
>>>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, 
>>>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, 
>>>>>> amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>> +     DRM_IOCTL_DEF_DRV(AMDGPU_PROFILE, amdgpu_profile_ioctl, 
>>>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>>    };
>>>>>>
>>>>>>    static const struct drm_driver amdgpu_kms_driver = {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..94fe408e810f
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>>>> @@ -0,0 +1,112 @@
>>>>>> +/*
>>>>>> + * Copyright 2021 Advanced Micro Devices, Inc.
>>>>>> + *
>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>> obtaining a
>>>>>> + * copy of this software and associated documentation files (the 
>>>>>> "Software"),
>>>>>> + * to deal in the Software without restriction, including without 
>>>>>> limitation
>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>> sublicense,
>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>> whom the
>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>> conditions:
>>>>>> + *
>>>>>> + * The above copyright notice and this permission notice shall be 
>>>>>> included in
>>>>>> + * all copies or substantial portions of the Software.
>>>>>> + *
>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>> KIND, EXPRESS OR
>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>> MERCHANTABILITY,
>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>>>> EVENT SHALL
>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>>> DAMAGES OR
>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>> OTHERWISE,
>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>>>> USE OR
>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>> + *
>>>>>> + */
>>>>>> +
>>>>>> +#include <drm/amdgpu_drm.h>
>>>>>> +#include "amdgpu.h"
>>>>>> +
>>>>>> +/**
>>>>>> + * amdgpu_profile_ioctl - Manages settings for profiling.
>>>>>> + *
>>>>>> + * @dev: drm device pointer
>>>>>> + * @data: drm_amdgpu_vm
>>>>>> + * @filp: drm file pointer
>>>>>> + *
>>>>>> + * Returns:
>>>>>> + * 0 for success, -errno for errors.
>>>>>> + */
>>>>>> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
>>>>>> +                      struct drm_file *filp)
>>>>>> +{
>>>>>> +     union drm_amdgpu_profile *args = data;
>>>>>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>>>>>> +     const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>>>> +     enum amd_dpm_forced_level current_level, requested_level;
>>>>>> +     int r;
>>>>>> +
>>>>>> +     if (pp_funcs->get_performance_level)
>>>>>> +             current_level = amdgpu_dpm_get_performance_level(adev);
>>>>>> +     else
>>>>>> +             current_level = adev->pm.dpm.forced_level;
>>>>>> +
>>>>>> +     switch (args->in.op) {
>>>>>> +     case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
>>>>>> +             if (args->in.flags)
>>>>>> +                     return -EINVAL;
>>>>>> +             switch (current_level) {
>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
>>>>>> +                     args->out.flags = 
>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD;
>>>>>> +                     break;
>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
>>>>>> +                     args->out.flags = 
>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK;
>>>>>> +                     break;
>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
>>>>>> +                     args->out.flags = 
>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK;
>>>>>> +                     break;
>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
>>>>>> +                     args->out.flags = 
>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK;
>>>>>> +                     break;
>>>>>> +             default:
>>>>>> +                     args->out.flags = 
>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE;
>>>>>> +                     break;
>>>>>> +             }
>>>>>> +             break;
>>>>>> +     case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
>>>>>> +             if (args->in.flags & 
>>>>>> ~AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK)
>>>>>> +                     return -EINVAL;
>>>>>> +             switch (args->in.flags & 
>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK) {
>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
>>>>>> +                     requested_level = 
>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
>>>>>> +                     break;
>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
>>>>>> +                     requested_level = 
>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
>>>>>> +                     break;
>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
>>>>>> +                     requested_level = 
>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
>>>>>> +                     break;
>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
>>>>>> +                     requested_level = 
>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
>>>>>> +                     break;
>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
>>>>>> +                     requested_level = AMD_DPM_FORCED_LEVEL_AUTO;
>>>>>> +                     break;
>>>>>> +             default:
>>>>>> +                     return -EINVAL;
>>>>>> +             }
>>>>>> +
>>>>>> +             if ((current_level != requested_level) && 
>>>>>> pp_funcs->force_performance_level) {
>>>>>> +                     mutex_lock(&adev->pm.mutex);
>>>>>> +                     r = amdgpu_dpm_force_performance_level(adev, 
>>>>>> requested_level);
>>>>>> +                     if (!r)
>>>>>> +                             adev->pm.dpm.forced_level = 
>>>>>> requested_level;
>>>>>> + mutex_unlock(&adev->pm.mutex);
>>>>>> +                     if (r)
>>>>>> +                             return r;
>>>>>> +             }
>>>>>> +             break;
>>>>>> +     default:
>>>>>> +             return -EINVAL;
>>>>>> +     }
>>>>>> +
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..cd1c597bae11
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>>>> @@ -0,0 +1,30 @@
>>>>>> +/*
>>>>>> + * Copyright 2021 Advanced Micro Devices, Inc.
>>>>>> + *
>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>> obtaining a
>>>>>> + * copy of this software and associated documentation files (the 
>>>>>> "Software"),
>>>>>> + * to deal in the Software without restriction, including without 
>>>>>> limitation
>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>> sublicense,
>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>> whom the
>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>> conditions:
>>>>>> + *
>>>>>> + * The above copyright notice and this permission notice shall be 
>>>>>> included in
>>>>>> + * all copies or substantial portions of the Software.
>>>>>> + *
>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>> KIND, EXPRESS OR
>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>> MERCHANTABILITY,
>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>>>> EVENT SHALL
>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>>> DAMAGES OR
>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>> OTHERWISE,
>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>>>> USE OR
>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>> + *
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef __AMDGPU_PROFILE_H__
>>>>>> +#define __AMDGPU_PROFILE_H__
>>>>>> +
>>>>>> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
>>>>>> +                      struct drm_file *filp);
>>>>>> +
>>>>>> +#endif
>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>>>>> b/include/uapi/drm/amdgpu_drm.h
>>>>>> index 26e45fc5eb1a..b6edf4a826f9 100644
>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>> @@ -54,6 +54,7 @@ extern "C" {
>>>>>>    #define DRM_AMDGPU_VM                       0x13
>>>>>>    #define DRM_AMDGPU_FENCE_TO_HANDLE  0x14
>>>>>>    #define DRM_AMDGPU_SCHED            0x15
>>>>>> +#define DRM_AMDGPU_PROFILE           0x16
>>>>>>
>>>>>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + 
>>>>>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE + 
>>>>>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>> @@ -71,6 +72,7 @@ extern "C" {
>>>>>>    #define DRM_IOCTL_AMDGPU_VM DRM_IOWR(DRM_COMMAND_BASE + 
>>>>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>>>    #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE 
>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union 
>>>>>> drm_amdgpu_fence_to_handle)
>>>>>>    #define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE + 
>>>>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>>>> +#define DRM_IOCTL_AMDGPU_PROFILE DRM_IOW(DRM_COMMAND_BASE + 
>>>>>> DRM_AMDGPU_PROFILE, union drm_amdgpu_profile)
>>>>>>
>>>>>>    /**
>>>>>>     * DOC: memory domains
>>>>>> @@ -1120,6 +1122,32 @@ struct drm_amdgpu_info_video_caps {
>>>>>>        struct drm_amdgpu_info_video_codec_info 
>>>>>> codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
>>>>>>    };
>>>>>>
>>>>>> +/* profile ioctl */
>>>>>> +#define AMDGPU_PROFILE_OP_GET_STABLE_PSTATE  1
>>>>>> +#define AMDGPU_PROFILE_OP_SET_STABLE_PSTATE  2
>>>>>> +
>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK      0xf
>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE      0
>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD  1
>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK  2
>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK  3
>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK      4
>>>>>> +
>>>>>> +struct drm_amdgpu_profile_in {
>>>>>> +     /** AMDGPU_PROFILE_OP_* */
>>>>>> +     __u32   op;
>>>>>> +     __u32   flags;
>>>>>> +};
>>>>>> +
>>>>>> +struct drm_amdgpu_profile_out {
>>>>>> +     __u64   flags;
>>>>>> +};
>>>>>> +
>>>>>> +union drm_amdgpu_profile {
>>>>>> +     struct drm_amdgpu_profile_in in;
>>>>>> +     struct drm_amdgpu_profile_out out;
>>>>>> +};
>>>>>> +
>>>>>>    /*
>>>>>>     * Supported GPU families
>>>>>>     */
>>>
> 

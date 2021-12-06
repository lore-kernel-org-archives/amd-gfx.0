Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B548C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 13:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C90B46FB1D;
	Mon,  6 Dec 2021 13:24:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DF06E5CF
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 13:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iibRN/9xkb3up01KNlrpVPeRE6E9pki6VUCJDJxZpEsavb9gSpEZOcmDo6EvJ9ylz8HtviYk3JfAwl2O42RGAdBpPMoJoOgkvA5XqwFHvNt4VEcYNeYQu0YGIz9ZhcBAvqnEh42VeN+qq42JoKqh333K/L9a03RHcXrj8AuNfDJQURHBfIOvYCAO/jOWqtJm1Yo5AkmnkJY1m32cWEg9aklQT9iAXrXe7KSj7YQmg2QYVR+NtELiZNHbHgS7Rwu7SrW9jD7GV5FbgWz4ZIkOj6k3R7vvvadaTqTrdii/+RV5ARnjSZGL3v4GkQBkpPrK/xIdw5t8wqcnQCZErD+5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFv88nmJoY5iouVgzcOxa1ShECGUzVQ3XDqbdS/bXIE=;
 b=ASS58vULJn6XhSFxP4KLiaqDGGqHdp/YsiydpOul1wd6dfARUBjk+bNFKngQXYZMOUzeW5yntP2j2FWN4kpWUn79oncYGVXh6OvhL6SunI+nFHQ8F5tc8OwxCATA2uMmWwaochxFxpDREyxj4q+Mh8lnlIWuuG+D9w/qEx0KrmJ338SdBiVDURgHWDqyHPu6EqxVq0hyUIHBwO0IQljOy/rhKh8jBUb1yUdeANtIp1WOYarF3jRj4pp8jZY23yq0PbQKS5dxS6LzJWrQ4MmOmFtsy9UInVBNl6v22oHLkVFBFRtmKVJ6g2VHDHlgSQBIqc0izs4AubkQxBrdElq++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFv88nmJoY5iouVgzcOxa1ShECGUzVQ3XDqbdS/bXIE=;
 b=FQv266DPAagGcMoADr2mCzsZlLz0T7mFZ2x7uTgQyyV2ZiFulpnQLTaR/jUORR/g+b/jzGIWenUCgUnt/+0ULOwWxllgyu9iLySrh+LS3TpFB83l+OgBRtzKlRrl7mW33O9o1vLwdqLEjtoStF7f+q1M2ihfn9POdN/nFeEbvTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 13:24:08 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.030; Mon, 6 Dec 2021
 13:24:07 +0000
Message-ID: <636019a6-e08e-7aa9-d62d-52ce802e3a44@amd.com>
Date: Mon, 6 Dec 2021 18:53:54 +0530
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
 <7be3f643-040e-e9ff-46b2-3739112c07e0@amd.com>
 <a381e89e-84c2-92ed-2a06-cb6818d6aba7@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <a381e89e-84c2-92ed-2a06-cb6818d6aba7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::12) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0007.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:25::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 13:24:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd3d138-0a51-481a-d85f-08d9b8bbae5c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3115B6925BE48449CD0E7BEC976D9@DM6PR12MB3115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e36wfbWqzyFS6rADP7vjAX14yM2IqCJcPNDAgdUMSKQgU3y8HwLuppFGXQ9GxyYef+LNaS1Hy5Q1F28NqSJ5u9GGCLVLgcTpwIhAQ7pLQGnkgDiCY0SqGZlRsjYfVMQDaj6y5SFexip81RamXz2D+ws42SRPE+rjKPuoSerT4xLQdeITSIjw8Epx3xHSrqhzUM9/55AYrPXHfZVV9guGL/FSVRsltDzMWoZspgkyuRcyk+7zIphKSsSsSwos/IDolWXl+jP1uODfiFsQy3z8l6MwXYY9xP+1hBHbpIUwTFYZbesMUAeBKamkLBMv3Ylv26kpZgpi0GzGFcbtcJaXH/rh5uDgyLhntwGj0ZVcXTbuLp1xoDC46Ic56dqnRtWoQFZPoYYOqcxMWf2/ETXzKG7bJXcrp/qSy4hhX4HvyO+tmVESJBfGV3w8Lh3Vy717fpZ/bbrvAK+O+sMkmDh90En5N/z44WtNwnElBCUYHT5viQnvBCV5rxsCoBmuawHGV70zfd5go3iIjGR/jJVvqeU6M/tjRnoe8k97qvEL+Odmw71W8X9MwvgQbtgCriJaXKyg3jHJtK62Ywg3c3NRWxkdotfkHC9V5Rx7VZv6pLgPAUx5j0UVtmo09+3MMAwM2pb51eF5qYCquAKjyUiW2Unmsgcelvj3uyqArbjrziiIkVluJuZTlBd7V5hN6w50SDjkO86W405MXY4wTd3p/ciiU/5QrXjFVDF316NzPT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(30864003)(36756003)(5660300002)(53546011)(6486002)(316002)(956004)(8676002)(26005)(2616005)(83380400001)(66946007)(508600001)(66556008)(66476007)(31686004)(6666004)(31696002)(110136005)(186003)(2906002)(16576012)(8936002)(4326008)(86362001)(54906003)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzYybS92enVkNDFCN3I0VUpmTWFoTVJmWCtMVVVGQVRYUVhVdXN6NkkyaGo1?=
 =?utf-8?B?UE5mVTBsNDhGeE5uZzQwSkczNEVCYyt0R3JEOEJPNlV3aGlBWm9oSVpUdXV6?=
 =?utf-8?B?d2c2cXJuVDlGTTArc0s4VDQ1L2ZUbno5NVJrNmVZa3JFYzRHZmlOUkliQ2pt?=
 =?utf-8?B?S3R2eXF4Qm5ZeWUybTJMMHdaMWkxTnprdmlmd2piMTNPWGdUcVZvSW1rNnVn?=
 =?utf-8?B?Y3FYekwzcW91N1NTSlMrbFk0dEpGR0Z4SEczUUJ6QkZnRTVUSWwxN1ZvWnJ1?=
 =?utf-8?B?Q05JZFlSMGUwUGJnQUFLcXQxMzFwKzBMVGdtWFovZUpxaGViTlNGMXphTllu?=
 =?utf-8?B?Rml1czNZempjQUJ6STYrVnRRVTdPa3FuZzBCeEM3RExheXhhQ0Z4ZUxkL1ht?=
 =?utf-8?B?aloyNjhzWnlrZG1aYkIwaVNEU0gwSC9MeHZ2cHdZSnUxa0JHMWp6UVBrNElJ?=
 =?utf-8?B?ME9vUklvVXhYYXVFeWt6WlRSbXZjMm1HaDZxUWJaQnozTllFYTk0Z0M5UEty?=
 =?utf-8?B?ZDREaEtNRnRiWkYxRFZOSHk4SmtrZmdNc2Rsb20zam1GR09mMzdYMUpZalNY?=
 =?utf-8?B?dU1rSER6d2VvNTU0OVIzNmpYdlB5cDEraFM1cndaUzVYR0hobG1MRGhnTGVy?=
 =?utf-8?B?di8vSDJiS3JyMDFJb3RDVnlGSHJhWFJCU2Rnanl6NmZrdDBtbGhKVmJUUEZC?=
 =?utf-8?B?c2VCK0JtbDZuRlJBcFNCR3RUNEVoTkJlKzFXME9KNEpENUUreEo1NENMN21y?=
 =?utf-8?B?NE5qZzc3VXNhVm5CZmFnWXlzbDJIU1VsOWVnR1Y3SzU3TjdudU0zbGdkTnN4?=
 =?utf-8?B?NC9VSFpoQkV3QldxN1ZVUW1sVXJVdzRYbHYvL0NhRzJMdnMwT2l4aVkzQ1ZM?=
 =?utf-8?B?bDROUllHYzlSYWpkTmJWc2lEQmRrMkNPOTBCYUQyTkNYNDhBa0d5NXMweUYw?=
 =?utf-8?B?NmVUQ1NHdXU4V3dqSi81TEsrOXJpVitSOEY0QlMrdTJvMjU1SDIxR1lidW92?=
 =?utf-8?B?dWdzbHoyZWg4WVc0enpTUGZxTWdYdTJIUWdDdTFVeXpyVjJHbW5SNlNicjR3?=
 =?utf-8?B?Wk5za0V5R1NNcEI2MkJ0YUVnQTV5L083VWw2U1huSHRIME1CR29pdEs0c3p4?=
 =?utf-8?B?VzdJVkdPdFR1dENjeGRWVWorSFpBaVhJZVR1SHZqNllOcVlrcGo2cUwwUzJN?=
 =?utf-8?B?REY3UzhuV0d1Wmo0SzlhT29MS21HUDJTbUF0cFF0b1JGdUNNVHRNOExsNC9O?=
 =?utf-8?B?bFliVXRnSUhqWUEzalp1ODVkTGNuYmZNaGxlZzYwZmNGQzBGcTVUL2RKZjFL?=
 =?utf-8?B?bm84elVQRFpKbEw5aVV1MTZhNVErY0xTOGp1UEZJQXpRdXVUU2UyQXE2VUcz?=
 =?utf-8?B?ZmRIdWJDSDdpRHBweE9Pc0dkb2k0WHNKWHUxbEs5WisyYkNlODlBdm8xUGhz?=
 =?utf-8?B?dm1yWjhwbm5kakcyK2gweFlUbkN6VGVVTnRtV2wxYnRBaVJ6QjVOTDFvaVda?=
 =?utf-8?B?UFdVMlltTDFrZXBsUGQyczh2VjQvb3lOYWFKQlNCZEpMMFY0SEJ3c3p6Rmxp?=
 =?utf-8?B?NHRZUjFxZm10anlRbmR0ZllzcVVqYjkyVVNhNVVzWlNlSjNCSE00ZHJNSFZ5?=
 =?utf-8?B?VlFqRFBSQ1JaTFAzT1pzdXQ0MnZ2Ty9zZ3dLSHk1bjhOZ1dUUHcya1lMck90?=
 =?utf-8?B?dmh0MnB1a3RlTXkxWU5hOU81VTRLdHhmWVo5WU9DM2o2SjBoQWpzZDA2SlAy?=
 =?utf-8?B?RC9mNXFSbzk0L3ZxbXpPWmdUd2d4SVlCTG5XTVFpb0xPdFpFeGNUTkx5bW04?=
 =?utf-8?B?NU9oWlJ0Ymk5MlVneG9hTEhTeG5OakNqUVNhSHpyVkpDenYwWm9wcGtJZnJi?=
 =?utf-8?B?Vmh6cHZEN1RmalRWQ1VkMmordXRURGwvZVRMTkVLMlA3a3VaRjRwMWJDZ0JS?=
 =?utf-8?B?Z2hWTG1CNEkvT25JZ3lOYUNUOUo2c2NxNDFVOGpyenB6NkU1YVlzYTRFVGdn?=
 =?utf-8?B?aWdIWkJrMHM1THVnaUJtek1ldUhOdjRDZ25GRDRLOTIrT0ZqSllrODYwc1ZK?=
 =?utf-8?B?dzF3L3Q4SW5wZGxRRTNTdWxOTDNtUGJwWEp3MWt0SnRPeXR2QzE3WWl4OHNY?=
 =?utf-8?Q?7BlE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd3d138-0a51-481a-d85f-08d9b8bbae5c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 13:24:07.7069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OogVB0hpUu9mVNxWyDSzeeTEnZ+d2cIns9E5D3pLvvAysZUK0x3RWPpjn+UADMsB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
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



On 12/6/2021 5:42 PM, Christian König wrote:
> Am 06.12.21 um 12:36 schrieb Lazar, Lijo:
>> On 12/6/2021 4:52 PM, Christian König wrote:
>>> Am 06.12.21 um 11:56 schrieb Lazar, Lijo:
>>>> On 12/5/2021 2:53 PM, Christian König wrote:
>>>>> Am 03.12.21 um 17:13 schrieb Alex Deucher:
>>>>>> On Fri, Dec 3, 2021 at 7:15 AM Christian König
>>>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>>>> Am 02.12.21 um 20:19 schrieb Alex Deucher:
>>>>>>>> This adds a new IOCTL currently used to implement querying
>>>>>>>> and setting the stable power state for GPU profiling. The
>>>>>>>> stable pstates use fixed clocks and disable certain power
>>>>>>>> features in order to get accurate pipeline profiling.
>>>>>>>>
>>>>>>>> Currently this is handled via sysfs, and that is still
>>>>>>>> available, but this makes it easier for applications
>>>>>>>> to utilize.  Note that the power state is global so
>>>>>>>> setting it will affect all applications.  There are currently
>>>>>>>> no checks in place to prevent multiple applications from
>>>>>>>> using this interface, but it doesn't make sense to do
>>>>>>>> profiling while you have multiple applications running in the
>>>>>>>> first place, so it's up to the user to ensure this in order
>>>>>>>> to get good results.
>>>>>>>>
>>>>>>>> This patch add an interface to query what profiling mode is
>>>>>>>> currently active and to set enable a profiling mode.
>>>>>>> First of all I wouldn't call this profiling mode. Profiling is 
>>>>>>> the use
>>>>>>> case, but performance and power management are what is controlled 
>>>>>>> here.
>>>>>>>
>>>>>> Ok.
>>>>>>
>>>>>>> Then we already have functionality for process and context priority
>>>>>>> override for the SW scheduler in amdgpu_sched.c. I think we 
>>>>>>> should add
>>>>>>> this functionality there.
>>>>>> I'm not sure I follow.  Do you mean to integrate this with the
>>>>>> rendering context?  That was what my original patch did (attached).
>>>>>> Or were you thinking it would be better to make this part of the 
>>>>>> sched
>>>>>> ioctl?
>>>>>
>>>>> The later,
>>>>>
>>>>> The scheduler IOCTLs are all about adjusting the default priority 
>>>>> of a process (and optionally a context as well).
>>>>>
>>>>> Putting the hardware power management control alongside that kind 
>>>>> of makes sense I think.
>>>>>
>>>>> Something like AMDGPU_SCHED_OP_POWER.
>>>>
>>>> That doesn't make sense to me. This is not optimizing scheduling for 
>>>> power. These settings are applied to the whole hardware. Even if we 
>>>> assume a hypothetical case of 'no-scheduler' (only one app running), 
>>>> the settings can be used to figure out whether an app is sensitive 
>>>> to GFXCLK vs MCLK or which phases of the app are sensitive.
>>>
>>> What clocks are eventually in use is pretty much irrelevant. The 
>>> functionality is that the application is defining a power level to 
>>> use when it is active.
>>>
>>
>> Exactly and it's irrelevant how it is made active. It just wants to 
>> run something under certain conditions for specific cases.
>>
>> For ex: it could just collect some data for a time period less than 
>> scheduled quantum and it could make use of in the next phase of its 
>> logic. It is very much internal to the app and I don't see any 
>> scheduler related logic inside that (just because an app is made 
>> active by a scheduler).
> 
> This is about the GPU scheduler who decides which application runs on 
> the GPU and not related to the CPU scheduler in any way.
> 
> Our current plan is to expose the performance level globally, because it 
> is to much overhead to change the performance level on each application 
> switch.
> 
> But ideally you won't do that. Instead each application should note the 
> performance level it wants to the kernel and the kernel then makes an 
> adequate decision based on that.
> 

If I understand correctly, in the ideal case, the current implementation 
of immediately switching to requested perf level shouldn't be done. It 
should only be associated with that context and then used later. The 
current one is way too far from ideal.

Thanks for explaining.

Thanks,
Lijo

> Since this is related to how jobs are scheduled and switching between 
> applications I suggested to put it into amdgpu_scheduler.c.
> 
> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> That we currently do that globally and only allow the first 
>>> application to modify this is an implementation detail.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>
>>>>>>> Christian.
>>>>>>>
>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c | 112 
>>>>>>>> ++++++++++++++++++++
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h |  30 ++++++
>>>>>>>>    include/uapi/drm/amdgpu_drm.h               |  28 +++++
>>>>>>>>    5 files changed, 173 insertions(+), 1 deletion(-)
>>>>>>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>>>>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> index 7fedbb725e17..4cf5bf637a9e 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> @@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>>>>        amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o 
>>>>>>>> amdgpu_nbio.o \
>>>>>>>>        amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o 
>>>>>>>> amdgpu_rap.o \
>>>>>>>>        amdgpu_fw_attestation.o amdgpu_securedisplay.o 
>>>>>>>> amdgpu_hdp.o \
>>>>>>>> -     amdgpu_eeprom.o amdgpu_mca.o
>>>>>>>> +     amdgpu_eeprom.o amdgpu_mca.o amdgpu_profile.o
>>>>>>>>
>>>>>>>>    amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>>> index bc1355c6248d..0e27f9673f8f 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>>> @@ -46,6 +46,7 @@
>>>>>>>>    #include "amdgpu_sched.h"
>>>>>>>>    #include "amdgpu_fdinfo.h"
>>>>>>>>    #include "amdgpu_amdkfd.h"
>>>>>>>> +#include "amdgpu_profile.h"
>>>>>>>>
>>>>>>>>    #include "amdgpu_ras.h"
>>>>>>>>    #include "amdgpu_xgmi.h"
>>>>>>>> @@ -2467,6 +2468,7 @@ const struct drm_ioctl_desc 
>>>>>>>> amdgpu_ioctls_kms[] = {
>>>>>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, 
>>>>>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, 
>>>>>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, 
>>>>>>>> amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>>>> +     DRM_IOCTL_DEF_DRV(AMDGPU_PROFILE, amdgpu_profile_ioctl, 
>>>>>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>>>>>    };
>>>>>>>>
>>>>>>>>    static const struct drm_driver amdgpu_kms_driver = {
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..94fe408e810f
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>>>>>> @@ -0,0 +1,112 @@
>>>>>>>> +/*
>>>>>>>> + * Copyright 2021 Advanced Micro Devices, Inc.
>>>>>>>> + *
>>>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>>>> obtaining a
>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>> (the "Software"),
>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>> without limitation
>>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>>>> sublicense,
>>>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>>>> whom the
>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>> conditions:
>>>>>>>> + *
>>>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>>>> be included in
>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>> + *
>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>>> KIND, EXPRESS OR
>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>> MERCHANTABILITY,
>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>>>>>> EVENT SHALL
>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>>> OTHERWISE,
>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>>> THE USE OR
>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#include <drm/amdgpu_drm.h>
>>>>>>>> +#include "amdgpu.h"
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * amdgpu_profile_ioctl - Manages settings for profiling.
>>>>>>>> + *
>>>>>>>> + * @dev: drm device pointer
>>>>>>>> + * @data: drm_amdgpu_vm
>>>>>>>> + * @filp: drm file pointer
>>>>>>>> + *
>>>>>>>> + * Returns:
>>>>>>>> + * 0 for success, -errno for errors.
>>>>>>>> + */
>>>>>>>> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
>>>>>>>> +                      struct drm_file *filp)
>>>>>>>> +{
>>>>>>>> +     union drm_amdgpu_profile *args = data;
>>>>>>>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>>>>>>>> +     const struct amd_pm_funcs *pp_funcs = 
>>>>>>>> adev->powerplay.pp_funcs;
>>>>>>>> +     enum amd_dpm_forced_level current_level, requested_level;
>>>>>>>> +     int r;
>>>>>>>> +
>>>>>>>> +     if (pp_funcs->get_performance_level)
>>>>>>>> +             current_level = 
>>>>>>>> amdgpu_dpm_get_performance_level(adev);
>>>>>>>> +     else
>>>>>>>> +             current_level = adev->pm.dpm.forced_level;
>>>>>>>> +
>>>>>>>> +     switch (args->in.op) {
>>>>>>>> +     case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
>>>>>>>> +             if (args->in.flags)
>>>>>>>> +                     return -EINVAL;
>>>>>>>> +             switch (current_level) {
>>>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
>>>>>>>> +                     args->out.flags = 
>>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD;
>>>>>>>> +                     break;
>>>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
>>>>>>>> +                     args->out.flags = 
>>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK;
>>>>>>>> +                     break;
>>>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
>>>>>>>> +                     args->out.flags = 
>>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK;
>>>>>>>> +                     break;
>>>>>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
>>>>>>>> +                     args->out.flags = 
>>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK;
>>>>>>>> +                     break;
>>>>>>>> +             default:
>>>>>>>> +                     args->out.flags = 
>>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE;
>>>>>>>> +                     break;
>>>>>>>> +             }
>>>>>>>> +             break;
>>>>>>>> +     case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
>>>>>>>> +             if (args->in.flags & 
>>>>>>>> ~AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK)
>>>>>>>> +                     return -EINVAL;
>>>>>>>> +             switch (args->in.flags & 
>>>>>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK) {
>>>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
>>>>>>>> +                     requested_level = 
>>>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
>>>>>>>> +                     break;
>>>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
>>>>>>>> +                     requested_level = 
>>>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
>>>>>>>> +                     break;
>>>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
>>>>>>>> +                     requested_level = 
>>>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
>>>>>>>> +                     break;
>>>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
>>>>>>>> +                     requested_level = 
>>>>>>>> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
>>>>>>>> +                     break;
>>>>>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
>>>>>>>> +                     requested_level = AMD_DPM_FORCED_LEVEL_AUTO;
>>>>>>>> +                     break;
>>>>>>>> +             default:
>>>>>>>> +                     return -EINVAL;
>>>>>>>> +             }
>>>>>>>> +
>>>>>>>> +             if ((current_level != requested_level) && 
>>>>>>>> pp_funcs->force_performance_level) {
>>>>>>>> + mutex_lock(&adev->pm.mutex);
>>>>>>>> +                     r = 
>>>>>>>> amdgpu_dpm_force_performance_level(adev, requested_level);
>>>>>>>> +                     if (!r)
>>>>>>>> + adev->pm.dpm.forced_level = requested_level;
>>>>>>>> + mutex_unlock(&adev->pm.mutex);
>>>>>>>> +                     if (r)
>>>>>>>> +                             return r;
>>>>>>>> +             }
>>>>>>>> +             break;
>>>>>>>> +     default:
>>>>>>>> +             return -EINVAL;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..cd1c597bae11
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>>>>>> @@ -0,0 +1,30 @@
>>>>>>>> +/*
>>>>>>>> + * Copyright 2021 Advanced Micro Devices, Inc.
>>>>>>>> + *
>>>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>>>> obtaining a
>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>> (the "Software"),
>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>> without limitation
>>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>>>> sublicense,
>>>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>>>> whom the
>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>> conditions:
>>>>>>>> + *
>>>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>>>> be included in
>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>> + *
>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>>> KIND, EXPRESS OR
>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>> MERCHANTABILITY,
>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>>>>>> EVENT SHALL
>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>>> OTHERWISE,
>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>>> THE USE OR
>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#ifndef __AMDGPU_PROFILE_H__
>>>>>>>> +#define __AMDGPU_PROFILE_H__
>>>>>>>> +
>>>>>>>> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
>>>>>>>> +                      struct drm_file *filp);
>>>>>>>> +
>>>>>>>> +#endif
>>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>>>>>>> b/include/uapi/drm/amdgpu_drm.h
>>>>>>>> index 26e45fc5eb1a..b6edf4a826f9 100644
>>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>>> @@ -54,6 +54,7 @@ extern "C" {
>>>>>>>>    #define DRM_AMDGPU_VM                       0x13
>>>>>>>>    #define DRM_AMDGPU_FENCE_TO_HANDLE  0x14
>>>>>>>>    #define DRM_AMDGPU_SCHED            0x15
>>>>>>>> +#define DRM_AMDGPU_PROFILE           0x16
>>>>>>>>
>>>>>>>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE 
>>>>>>>> + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE + 
>>>>>>>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>>>> @@ -71,6 +72,7 @@ extern "C" {
>>>>>>>>    #define DRM_IOCTL_AMDGPU_VM DRM_IOWR(DRM_COMMAND_BASE + 
>>>>>>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>>>>>    #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE 
>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union 
>>>>>>>> drm_amdgpu_fence_to_handle)
>>>>>>>>    #define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE + 
>>>>>>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>>>>>> +#define DRM_IOCTL_AMDGPU_PROFILE DRM_IOW(DRM_COMMAND_BASE + 
>>>>>>>> DRM_AMDGPU_PROFILE, union drm_amdgpu_profile)
>>>>>>>>
>>>>>>>>    /**
>>>>>>>>     * DOC: memory domains
>>>>>>>> @@ -1120,6 +1122,32 @@ struct drm_amdgpu_info_video_caps {
>>>>>>>>        struct drm_amdgpu_info_video_codec_info 
>>>>>>>> codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
>>>>>>>>    };
>>>>>>>>
>>>>>>>> +/* profile ioctl */
>>>>>>>> +#define AMDGPU_PROFILE_OP_GET_STABLE_PSTATE  1
>>>>>>>> +#define AMDGPU_PROFILE_OP_SET_STABLE_PSTATE  2
>>>>>>>> +
>>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK 0xf
>>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE 0
>>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD 1
>>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK 2
>>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK 3
>>>>>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK 4
>>>>>>>> +
>>>>>>>> +struct drm_amdgpu_profile_in {
>>>>>>>> +     /** AMDGPU_PROFILE_OP_* */
>>>>>>>> +     __u32   op;
>>>>>>>> +     __u32   flags;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +struct drm_amdgpu_profile_out {
>>>>>>>> +     __u64   flags;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +union drm_amdgpu_profile {
>>>>>>>> +     struct drm_amdgpu_profile_in in;
>>>>>>>> +     struct drm_amdgpu_profile_out out;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>    /*
>>>>>>>>     * Supported GPU families
>>>>>>>>     */
>>>>>
>>>
> 

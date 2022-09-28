Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0DDC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 08:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB35C10E37C;
	Wed, 28 Sep 2022 08:57:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED7D10E366
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 08:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/KSiogz7YiPOLML8he2zSEEWa/zhWchgFUQUCFkew5/1yjQIaV/vZowFJjBIE9Nr8uFywx4ETpNfvZa08/HAX3Ag1LlCOXsUqPBeSTV3m9TI9A0wmBSxuVFFGZxzoi1x77XAmVrgsrWb4uwAXx387UyvWjPNuMCY5xjHgDCGJSuLc1zHASAz32dXICQ+CPbA3p+4WGUTzmZtv74bPOau3drk5hSnHURvhcFTtPOWjQLPCbAahogqsJWH3rhYcuiJkam6pwa85dOSejp4ZeVF1ORPmKEnbfsea5I2mnagaRJUkmN6e8IObtn8Dht8MYhGkyBdq+IyKTPvQ7eKTgkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJvWIIBWcmsZmL5MyO2PZEROLTqbZy5UOszI3q5hf9g=;
 b=YiLSClumrB9rXrKxxlCVUepPUgRIpEvoiZO/tG2svTxPXtpwntCUSma/BAMIPvCxnoifd5LgUj+LL3TJpcXWG5iCEbqguSYMw5f04AsE1umUrvcOCsYtcxUXhnqWbpqQhKGjRFSWst7j7zBaxLm95fu3AR8Q0yxAMP5zqunh/UREVg6MetFTYr/H1LeTs0F5j/4chEkorYWjEiwFZx1eKc1CwH6ItSjWVyFenrSyJZ6/CwXGZLJofjm4szynnGV6kalCekNSqJitb1ND5IGTMMcLQest4Az10m/3UnD1LRzTDGhDdPLm9YcR4Iq932De2tDqVy0bIjQsoeuAoKrhBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJvWIIBWcmsZmL5MyO2PZEROLTqbZy5UOszI3q5hf9g=;
 b=jzI7YTJSw4w4Q5GX82naOpoWSgJPuf3/+QlkvbJp7C8RwkZKOyZrfOx/mLxGwMOrBuhuyXd6uh6H5SueKhqxGSsOV5Oi1rNZ2NcnKRnkRSNO97RnVn120sKJZXgra/YBD0S4Q17B5bYZan4S+ZYl2y4wIGgLYhj288j5OQdqbvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 08:56:59 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 08:56:58 +0000
Message-ID: <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
Date: Wed, 28 Sep 2022 10:56:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
 <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0061.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::38) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 9662df65-b984-4314-cf1f-08daa12f66a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8AN3so0KjlyO01qm4egVmU9jgTp96U2A1cORjNVZkpR1++rQpy2DHnEvOut63euCQMqs+Szkpd+gagHOhYURxVv7K3/lGcI0ylv5d7jhObkJzf8ckKqZrZ6xHYYU5zo1+FDkulUF6SxtbWK25hnxC2nCVt8efpDAgUuZCdhTnWfU66rAp5yIlbwY6eWU2devHjAJ2LGJdhcichrAHhAGGiQX9/rZ4pDQf+W/RvozOx5eaw70b0U/DbA66dGJOkZAkE2fHzJcP2A6LwPriWtyslFfvVR76RTg2aP922xNg/nYsDKAOICSpq1qswIdWVlaxR6BzGI5AFiqIQOkATOrykxyZOR6odqrUYMKofrPcSrsC9JXoe7LUOutshVUoFWjgG6YKBAjhx2Fqw7cZCvn0hVnBXxoNQqC5PpdKgFbMM/Z1FfiQErARqTw4C8dl46JVXQP08iF8DfaMLuCcG+Wx6KNapOn9legbTGNmubzH9g0eAtvwhB51JK9zxxRP+7b2dLkzpwDL7ZSpAvJQZ6+VzhhJJBf8WkT1sKak3nyGRLAxUgoi9ELxTS/lpbETMFrqdKugs4Uv55awyTgpKKC+NHtNG1bxpJJC+UCn0/a+Pu3OpHl84u7o1enI5m5T/biXQXPTmWZLoSIBxmJsmNryOJyLci1q7Ij0v12cN+Gqi2sjpIFHKytyTEbKDCtG4rQoOlePOHg7/SdRFklwIj6sNnvTH9kFXQ6AWwzc4L/Tk3g89W3NfMN1mYI0V2xEXU6aaCM64c9kLR47a+JuDE7yuJrP2KwnMm1vq3DnPNb80=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199015)(38100700002)(6506007)(53546011)(6666004)(31696002)(6512007)(41300700001)(36756003)(66574015)(2906002)(8936002)(5660300002)(6486002)(478600001)(86362001)(54906003)(6916009)(26005)(31686004)(4326008)(83380400001)(186003)(8676002)(66476007)(66946007)(66556008)(2616005)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUlFbTZ2UVQ0alZKalBBY2ZMUUxURkdrdWtjNk0xNGdyWGx5SU5ZMDN0Tkxp?=
 =?utf-8?B?UnJRMVMzU21jMUFFWHZod21oR2wwcDVGUFV6WXRaOG9pWFRXbDExZ3FxeEE0?=
 =?utf-8?B?VlZiaWQ0Uk5mcGZFS2kwcHZROGVzcDVJOThYQkkwR20yaUlpZVRKeEJObnBj?=
 =?utf-8?B?dHlCT2J4Yi9GVjQ5K1lLVXhJOTFZaWZGTHlBVlJtdGVCTFA1UThwaWJ4cjd3?=
 =?utf-8?B?OGdaenlVSittZWtlaWJoWTl3akd2TW5wS0gxRXNCbVJyUjVLL3I2SHdvZW5h?=
 =?utf-8?B?dVcraHUzamIyckQ2ODFnMERvbFRUcmxaalRZeEttMnVyU0liL2NXcEd1WUxO?=
 =?utf-8?B?b3JiVzBVOFplVWx0SE1Gazc0eGNIeXM0SGlaMlNWOUYxN3czeTNDRFg1SEd4?=
 =?utf-8?B?SGhpZklSTFVUeWhWODBsdDlNZTc2TWh3NzZHZGREdzUrL0VKTnNOclJ6Y1lZ?=
 =?utf-8?B?bkNRTVZnUEpjUnpwUHE1YnhnL2FqRVRvdXFkL0pXRnVSc3RYcDBHZ3A3SHlx?=
 =?utf-8?B?dGNvQm1DLzcyVlloZ0ZCclp0VTNWRWRSYlpraXNNUzVWTGZWUlhFZWpyMCs2?=
 =?utf-8?B?Y3F1RjFXQi90SDVwdFdQaXpiaExUdmVxLzhQcE1BTWpFakttdFNBcS93TmJD?=
 =?utf-8?B?UU9vN21aVVloL0c3N3dMWW02ZWNxYVd6NzU5emdyRVkrWmlkZ3FmVHorWkhZ?=
 =?utf-8?B?YjNYWjlZL0ZlSllnSk1CU1VXNjdmTkVJSEdSMlgzZHgvamxQWEp6NGRKSVIy?=
 =?utf-8?B?czRDcndhendjZlBHTGxXMXhrNUZNWXZkUzgzMml6WFkyWlZVQVZuZUNNQjZU?=
 =?utf-8?B?YmtWZXJWcXJtWlUxWSs2SFdpNzVZb3U3K0ZYLzVEU3FIdmdJS2czQWtQUy9t?=
 =?utf-8?B?bC9VZVNIQUlRcldWSTc3eStIaWZPejkyNE1xL0dhL3FQV2lyK01QeDE5aHhn?=
 =?utf-8?B?WDc4VXlXNXkrQzVkS1JjZjh5SkJibVpNTW50cVFNY0gwZHRDRjlYYktuWXJh?=
 =?utf-8?B?amhISjI1ZGpGdHdwWDhuTXFQTm4zWURqeHkvNFhOaWxNbFE4M2JXNXZ6SG9y?=
 =?utf-8?B?bXltRzhpTjJvTGhGSEFvY3o5N2d0ekU0OFlISUVqVHlVVHBhMUY4K1l5am00?=
 =?utf-8?B?NmpacWJqZzBBR2JNRVh5cGZCaGRlcWFtSEhvWURaQ0lEeC9URGRMU3ZCclpX?=
 =?utf-8?B?QkJ3RVlzTjZFVnFBRFl0VUMzRFRrK1phZGxjR3F1cHhFcGF6NkJHVWlOWGJ1?=
 =?utf-8?B?SXFQVVNvbkgwR1RaY0xVaklQQWp4SUd4YmR3SXBTTHBEaFU5VUl5Q1dEd2cr?=
 =?utf-8?B?REMvS3pzcUhmVUkxKzR5NURjMDQ4UmZwdGVhSFVWZDNMNEh4SEFvS211Wnk3?=
 =?utf-8?B?SlBEa0dhajdnZFJ1MmZLa1NwUVJRZ3I0Tjkzb3hQQ0hPLzFrcmV1d0h2QUds?=
 =?utf-8?B?Sk92WDhGUW92YUhvaVBTWFFJNmh5dFliYVBaTjBRaTFUL2lHUXkrTGoyemxK?=
 =?utf-8?B?eUMxdUNXSjlMNjJ5SVVxU0hJVy9CZkxxR2tVaGw2enl1UjNTNWllVXE2d3I0?=
 =?utf-8?B?a092TXJLWStVRXlQWWRCWmhYZUV6NGZPeXRObXBQVy80VmhUaUZId2RSYlVU?=
 =?utf-8?B?ZC9adndMdEJhY3MxdENVVko0b0ZlTWhNMW9xRkhlcjlzUU9xRXdKVUJpMEVu?=
 =?utf-8?B?RElUVGhlM1B0VGFTeDU1WDRoYTVTVk1lekNHYTlxY1A2QXd2SEQzNW1JU1BJ?=
 =?utf-8?B?cVZDaFpodmJoQVZXKzRNdUxGRlNrVHBHV0ROKytTcXhZaHRQMzZVT1lJb0t2?=
 =?utf-8?B?TTZUcytBNFU5ejMzVEhxaVdwcWZySjYzdEJmQ3daQ0xRZTE5bGV1Mlg5elBo?=
 =?utf-8?B?dDVUVnRtVDkyZXlGQ0M0RzFVTHVJVitDaHZyRllXRTJxZ2Y2SUNVZGVkZEta?=
 =?utf-8?B?c3dWNjVSdnBUTlNnZDBhb2tla21ReFM5NWtIb1dFZWlDQ3VNV0JVTm8rYkFY?=
 =?utf-8?B?VU1hanhXTG5MT2RBTWExR0ZyTmV3cDEwS0NiOVdJU2NZbnBlYlJ4NU41Q213?=
 =?utf-8?B?bTdzVU9xOXZ4LzJtcENpMW54Mkt3Z2NPRTBlZkRVLzIrYjBtSzRCNUVRd0ti?=
 =?utf-8?Q?EXGoQzUgU4ntvjhWVxdPAj6Be?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9662df65-b984-4314-cf1f-08daa12f66a4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 08:56:58.6614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il1WLiO9GfN81o1zSibnGgbOH8ZhQ5oW3momOZiYC9ynVuwmbHjVen9xVK+zPZXWGUMDdKDxyGTeUEvd4DQJGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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
Cc: alexander.deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 amaranath.somalapuram@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 10:40 PM, Alex Deucher wrote:
> On Tue, Sep 27, 2022 at 11:38 AM Sharma, Shashank
> <shashank.sharma@amd.com> wrote:
>>
>>
>>
>> On 9/27/2022 5:23 PM, Felix Kuehling wrote:
>>> Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
>>>> Hello Felix,
>>>>
>>>> Thank for the review comments.
>>>>
>>>> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
>>>>> Am 2022-09-27 um 02:12 schrieb Christian König:
>>>>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>>>>>> This patch switches the GPU workload mode to/from
>>>>>>> compute mode, while submitting compute workload.
>>>>>>>
>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>
>>>>>> Feel free to add my acked-by, but Felix should probably take a look
>>>>>> as well.
>>>>>
>>>>> This look OK purely from a compute perspective. But I'm concerned
>>>>> about the interaction of compute with graphics or multiple graphics
>>>>> contexts submitting work concurrently. They would constantly override
>>>>> or disable each other's workload hints.
>>>>>
>>>>> For example, you have an amdgpu_ctx with
>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD
>>>>> process that also wants the compute profile. Those could be different
>>>>> processes belonging to different users. Say, KFD enables the compute
>>>>> profile first. Then the graphics context submits a job. At the start
>>>>> of the job, the compute profile is enabled. That's a no-op because
>>>>> KFD already enabled the compute profile. When the job finishes, it
>>>>> disables the compute profile for everyone, including KFD. That's
>>>>> unexpected.
>>>>>
>>>>
>>>> In this case, it will not disable the compute profile, as the
>>>> reference counter will not be zero. The reset_profile() will only act
>>>> if the reference counter is 0.
>>>
>>> OK, I missed the reference counter.
>>>
>>>
>>>>
>>>> But I would be happy to get any inputs about a policy which can be
>>>> more sustainable and gets better outputs, for example:
>>>> - should we not allow a profile change, if a PP mode is already
>>>> applied and keep it Early bird basis ?
>>>>
>>>> For example: Policy A
>>>> - Job A sets the profile to compute
>>>> - Job B tries to set profile to 3D, but we do not allow it as job A is
>>>> not finished it yet.
>>>>
>>>> Or Policy B: Current one
>>>> - Job A sets the profile to compute
>>>> - Job B tries to set profile to 3D, and we allow it. Job A also runs
>>>> in PP 3D
>>>> - Job B finishes, but does not reset PP as reference count is not zero
>>>> due to compute
>>>> - Job  A finishes, profile reset to NONE
>>>
>>> I think this won't work. As I understand it, the
>>> amdgpu_dpm_switch_power_profile enables and disables individual
>>> profiles. Disabling the 3D profile doesn't disable the compute profile
>>> at the same time. I think you'll need one refcount per profile.
>>>
>>> Regards,
>>>     Felix
>>
>> Thanks, This is exactly what I was looking for, I think Alex's initial
>> idea was around it, but I was under the assumption that there is only
>> one HW profile in SMU which keeps on getting overwritten. This can solve
>> our problems, as I can create an array of reference counters, and will
>> disable only the profile whose reference counter goes 0.
> 
> It's been a while since I paged any of this code into my head, but I
> believe the actual workload message in the SMU is a mask where you can
> specify multiple workload types at the same time and the SMU will
> arbitrate between them internally.  E.g., the most aggressive one will
> be selected out of the ones specified.  I think in the driver we just
> set one bit at a time using the current interface.  It might be better
> to change the interface and just ref count the hint types and then
> when we call the set function look at the ref counts for each hint
> type and set the mask as appropriate.
> 
> Alex
> 

Hey Alex,
Thanks for your comment, if that is the case, this current patch series 
works straight forward, and no changes would be required. Please let me 
know if my understanding is correct:

Assumption: Order of aggression: 3D > Media > Compute

- Job 1: Requests mode compute: PP changed to compute, ref count 1
- Job 2: Requests mode media: PP changed to media, ref count 2
- Job 3: requests mode 3D: PP changed to 3D, ref count 3
- Job 1 finishes, downs ref count to 2, doesn't reset the PP as ref > 0, 
PP still 3D
- Job 3 finishes, downs ref count to 1, doesn't reset the PP as ref > 0,
PP still 3D
- Job 2 finishes, downs ref count to 0, PP changed to NONE,

In this way, every job will be operating in the Power profile of desired 
aggression or higher, and this API guarantees the execution at-least in 
the desired power profile.

- Shashank

> 
>>
>> - Shashank
>>
>>>
>>>
>>>>
>>>>
>>>> Or anything else ?
>>>>
>>>> REgards
>>>> Shashank
>>>>
>>>>
>>>>> Or you have multiple VCN contexts. When context1 finishes a job, it
>>>>> disables the VIDEO profile. But context2 still has a job on the other
>>>>> VCN engine and wants the VIDEO profile to still be enabled.
>>>>>
>>>>> Regards,
>>>>>     Felix
>>>>>
>>>>>
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
>>>>>>>    1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> index 5e53a5293935..1caed319a448 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> @@ -34,6 +34,7 @@
>>>>>>>    #include "amdgpu_ras.h"
>>>>>>>    #include "amdgpu_umc.h"
>>>>>>>    #include "amdgpu_reset.h"
>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>      /* Total memory size in system memory and all GPU VRAM. Used to
>>>>>>>     * estimate worst case amount of memory to reserve for page tables
>>>>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>      void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev,
>>>>>>> bool idle)
>>>>>>>    {
>>>>>>> -    amdgpu_dpm_switch_power_profile(adev,
>>>>>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
>>>>>>> -                    !idle);
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    if (idle)
>>>>>>> +        ret = amdgpu_clear_workload_profile(adev,
>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>> +    else
>>>>>>> +        ret = amdgpu_set_workload_profile(adev,
>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>> +
>>>>>>> +    if (ret)
>>>>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to
>>>>>>> compute mode\n",
>>>>>>> +             idle ? "reset" : "set");
>>>>>>>    }
>>>>>>>      bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32
>>>>>>> vmid)
>>>>>>

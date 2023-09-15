Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFECAEED601
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 14:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1E810E644;
	Fri, 15 Sep 2023 14:53:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2C410E640
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 14:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/nvY6Da4R9UngP5ZIhtqtE1C6oc1DYdydsk4XVJspCbVjpWbVKuRR+tOMGch806GDTh49O758WK0/j0EJ0FVbtEhgnaRo/smJdDKBUWhsRg6T1BB4egFpTZ2YCq90onW2lotAluQ+SBR56Y5jlDpDUQvUkcZ7HAiMu2z3UKVIenw+54wo/lndN/od1Mkdm2cV5RMn/EC1omSY+ntVi49BkJfiRwNMw+AUHWTuDRFHQZfNgXhvtdtJy9gW8OcWrvWb5yGYCoYDUbI7UkF4TuV65c+CbbwLR1HpKccDXNzzsWvdpwzD2778G9e5fLFk3MmzxlsOKNOpuJ1wuEQc1DQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqtH9rDI9ZFW5QxJ4TjuPeVaE3Ou+BykEyxf02o8JeI=;
 b=QSJTNf7M402rKDCQ0XLqxjfCetLbWnX14J0z2DTypyQaAPsQIsZA1DduFD4FnbXNZA0d1QwhxkoYO2MPzFNExMoYIS2g9VKe7ZSdokn180VaCwZvVAGedu1Uhb82/RVxH4LvSgl1JuKsckyQziDJj/tDxIrj3pxIIwZ03uXOEJQIn1zdEjyAbBBnbSa3Ke4fNTZNIjMw79azStftnYUBhpttKGjHhcR/GSNPpC4SM8JgaJMKa7vJ1oxG9K/CCD9uvI2S9icgK8t8BMIzEZ4jm+TylufxYY3Q1xJhzzR3shRjBvqPxS+2OwQQiOdTxqzOeF7Qvs6GuOm/fOTao+4vGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqtH9rDI9ZFW5QxJ4TjuPeVaE3Ou+BykEyxf02o8JeI=;
 b=L09LES8PsyLInDMeDjm3qL0hxn2BZj8RGnxbSk0k5jORYA3hXbGVdCf/UN6Kql22uCavVxgdHajrDVqsXKD7hgCj1WEi1yzhw/kkV5vLuSZi1InnzOktxpCnDnILpK1ZnK+Bamp0Fp5XpfT09d0/AMo4Q/9es4MkRuB7OneqUiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 14:53:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 14:53:44 +0000
Message-ID: <f82d33ef-3ace-0b74-04ab-9ce646dfb0bb@amd.com>
Date: Fri, 15 Sep 2023 10:53:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Use gpu_offset for user queue's wptr
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
References: <20230915025213.2463291-1-YuBiao.Wang@amd.com>
 <81a73442-2d27-eab8-4dec-cb1a6d179ab3@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <81a73442-2d27-eab8-4dec-cb1a6d179ab3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0216.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: c30f6d0a-914d-4aee-d630-08dbb5fb8f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tuXntKnQTrzw4e/EddbWKzu1RbmKAMULDUPtkRhZZD0OVEjY2Mrj1ACCgG4FEFKo7On+q3vb4CmfNjPNtFAC7KYoa1a+UesANqnkMuf0N0z9E3c/6924hOLsG1JauOZrl2P/iE+ezclUWdjTOLGM46d5ljVjrhGCGEHN5eq1d2GsXHnLriSlcB5oP6eIeKMKNXDlLlm4y966OHqwclGB9jnJcA0oIDKxmTVOLPAX0dcfRoSxJA4XgXVZlPibMGdLZhhFpIE66sstLGVhoAzH2sQqJDAtHeLQFzBzE8DBOHu0E/XOdF4EGF6MJ2v06SyMlfw9h9FRQbSI3W2Z8tEIb0eustoohTT6LI8FN3w+dot8WICrE0cdllzI9DknLtp28g91WFl7iRTNN0K79SeI5Bf0ZT94s7X4aWdpAWWoGHFPHkpg8jbi1eTPheX9fMtD0AXHOtUkw25A02jgYN8JyQmUu2FFvfCDM4h9khaRbbPyAFucQC4pNNpot4Vh0TSzCuyxKd8WQM03uB76OGcuaZDsDU91t9YFjymm+1dUuvqpMOHpzfc4Zj0jFJC7ERA2URQrUX9YmTcdyo1mis1uOqODNLTBwEvydN727aE6iqIybg7XzYp0rZpw2RacvQkaq/jzEYBBQo+jGld2eH/8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(1800799009)(451199024)(186009)(31686004)(38100700002)(6636002)(2906002)(54906003)(41300700001)(4326008)(316002)(66476007)(36756003)(8676002)(5660300002)(6506007)(44832011)(8936002)(6512007)(66556008)(6666004)(53546011)(6486002)(66946007)(110136005)(2616005)(86362001)(31696002)(26005)(478600001)(83380400001)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Lzl4cmQrYUUxckVBODdmemhMZ2JRMTB3dkNlWjR6ZnZOMlZCMlM0ZG1MbGF0?=
 =?utf-8?B?SHNMNC8xWW1ldjVJbzJRN2cwQ0dOQzVWdE5pTTRFdDdYYUJ6MDJtTW9NNkZh?=
 =?utf-8?B?dlNzU0RDZVJJN09rRmlTdHFEY0tMK05yWk5vN2ZjeVVIRHkrSmdoR2x4Y1FE?=
 =?utf-8?B?b2hkZWZZdGJ3eXFUVnFvVVVGTGJUeGhYYzl3dThJenhIZE5vbTRVVHJ2M3pF?=
 =?utf-8?B?NTdRTkpRL1FDd0hsN2hiV3ExeHFQQTE4MjFleEJoeEhIdjd3RDZsQTdMYkZE?=
 =?utf-8?B?T1FqaHBQSHc3M05OTk1YUzZUYVhDQUloWnkveDArUUpxdWVRUkl4NVRia3BJ?=
 =?utf-8?B?YldGTlBDSVNXN3dTZ3UwdGQyUjNTMkk3d3NTT3hOamcxVVlEdC81bkFWcmpp?=
 =?utf-8?B?ZGRxUWZYOFp1dDIzR2Q1OWkrWmxST1A5QjZzcFJlL2NkL1luTUxHbTY3ME9P?=
 =?utf-8?B?S3NFdSt4cTVSVzZmZlZscHpvVjB3RzFmbncxSmM5WXNlMTcvVlhvN1A3UFhi?=
 =?utf-8?B?M3NHekNwU2dqTkQrUThnOVB4WEhVV2VHdURCaGR3VFBSd1JIQmZMT2pUaE96?=
 =?utf-8?B?QW9YZEZwUko5WG9rN0h4MlFTb1lLS2x6ZDNYU1ZsS3pQTDNjbWJsOFZkMXhh?=
 =?utf-8?B?ekdsRWR5S2hjN2lnTitFenlrVDJodThwbUxleFRMY2JESzFNVUpJQlVwRVZ6?=
 =?utf-8?B?MG9FS1hCNW9nL1ZjYW9ZK09rYzFOSi9oZDF3WkwveWdBTzVyS3BENU9BZkI5?=
 =?utf-8?B?Nnl0QmVUODBlVEVkWDgxT3U1SGpXV3R1YkQrSk0vL3NVZ3Z5MFlKRGhvZGkv?=
 =?utf-8?B?U1lpdC9nMWx6NzlyVmgyMitkTlJFTVVVY3ppWGFhcTY1WVFXa0dDNUZlamFW?=
 =?utf-8?B?QVRWQXg2Nm9qdm8zWWR5UDVIL2VWS0VBd0tMamxRSWFISHROUGNidzlSYzJH?=
 =?utf-8?B?RitCenptbzlPNEE4ckhsNFdTVzVBVHppZ2dzUnA5YmV3ZUNxckhyamxNRitr?=
 =?utf-8?B?eld6dmQ5bGR2OXBPdkcwa3hPLy9OczNVT2ZJbHQ0ZHZxeERMdDBmd1NFN21X?=
 =?utf-8?B?UGcvR0Z2WUtKWDY3ZnkrdzNidUE3Wm5YL3ZpU05BQ1Ric3lJbVpYME1FVk1a?=
 =?utf-8?B?Mk93bTEwcjltNERwSHdHRDJhSzVHSmJkTnd1SHgxdVh3SEZKODQ5R0lpSkJ0?=
 =?utf-8?B?YjNMWHE0YkdqR1FLYXd1Mm9CeFlYazJrcUJJUk1aNmhPaXBSSTJkbWlBY3Uz?=
 =?utf-8?B?Y0dwdG1HTjRmbnZEOXVBanlRSEhZUDc3cHFodFJ0N2w1OG94d0xNN2ZqOE1v?=
 =?utf-8?B?WE1XbjFwcmxCKzhjYSt3R2VrRGQ3TzUrOFBMQlVIZmV0cUhUWEtMejJMWWxu?=
 =?utf-8?B?Wll5ODMzbnYyYjFqRkMzMlhvam11SE5ZcFZSSUZWczFOODdtcW95NFl4bnBz?=
 =?utf-8?B?NVhaSmNsWjRzQnZ1aWQ0MVJBTlBWNXpKK055cnVuY3JOOER4aThnMmFxRHor?=
 =?utf-8?B?S1V1R0ExUkdnd2UyOXZsUTdaK2xJZnJqTEdOTW41NitVN091bGFtYTBxZUJP?=
 =?utf-8?B?SUVwblJiOFhGdTI4S04rYlFwRFVuTU5SR1JTNVhVY2lVRVluWk9tUG5mZSth?=
 =?utf-8?B?WWszQVlmKytpWE5EMHk0aG5vZ3AzbXJMU3N0K1VHRW5XdzFHam1XeWNDbko1?=
 =?utf-8?B?QUFTc2xualVJMjc4a2pKeWFZc2lha1N3MWpTQWUxVFVnTzV5cXFFL1hGQ3k0?=
 =?utf-8?B?SVdKSjc1SmozbWY3QVV5bTd5dnAySjQ4dGtKajVUSyt0bjJIY1lWOU1KdW1D?=
 =?utf-8?B?VDR1aWNzeHhDRWtWcmlpN24wcHV1QWRtdDIxNlJVVW5BVHNVVHVOS1FXY0sr?=
 =?utf-8?B?MTlEWm1hTUlDdWpraGd1aUJqYjBybVFaNlhvM2YxRktBMmtjNXVtay9EbTBO?=
 =?utf-8?B?aitrdDdNVWR1YnZpZExEcGRDMG94akJ5QjJGdGMvMDZ5dWk0TEhpOTd4dU82?=
 =?utf-8?B?UzN5WmZOZGJLQjl2andPNGhpb09JbnhvWVNDNGkrZENSVk5FMkRwS1l1aWpJ?=
 =?utf-8?B?UW9ZNUgrcS94WmIxUVhqTldHQnFxUEg0cnVzVEZDUHNYcDdIRFB0ZXp6NVQ5?=
 =?utf-8?Q?YTM3JUqLxb1fo8I80BPmHHwQA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30f6d0a-914d-4aee-d630-08dbb5fb8f38
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 14:53:44.8812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Of3K3aSmuFTh2fEClI8JR6B/ipxoT4ubT8fm67rSSCA8NAh7iQsuG8ChaubmmBU7/AHmkjbQs4/WBBT1uIzqRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-15 2:50, Christian König wrote:
> Am 15.09.23 um 04:52 schrieb YuBiao Wang:
>> Directly use tbo's start address will miss the domain start offset. Need
>> to use gpu_offset instead.
>>
>> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
>
> Felix and/or Shashank should probably take a look as well, but of hand 
> that looks like the correct fix.

Looks reasonable to me. Why did this not cause problems before? Are we 
just lucky that the domain start offset is 0 on the GPUs we've tested so 
far?

Regards,
   Felix


>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 77159b03a422..36e7171ad9a7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -216,7 +216,7 @@ static int add_queue_mes(struct 
>> device_queue_manager *dqm, struct queue *q,
>>         if (q->wptr_bo) {
>>           wptr_addr_off = (uint64_t)q->properties.write_ptr & 
>> (PAGE_SIZE - 1);
>> -        queue_input.wptr_mc_addr = 
>> ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + 
>> wptr_addr_off;
>> +        queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->wptr_bo) 
>> + wptr_addr_off;
>>       }
>>         queue_input.is_kfd_process = 1;
>

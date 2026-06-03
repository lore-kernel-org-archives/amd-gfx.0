Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8F8CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 19:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A197A1122D5;
	Wed,  3 Jun 2026 19:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ly9wuuGL";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D301122D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 19:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ykm/M8463FQ2OUrEbstKt5sI4VApPeuP6n+WyjY278g+X02KebR6v3rNHTONPLcnQigTb4Ja/iBG9o0QOcO8/KP43znTPGNR8Ii1HX7cnox9x+wHaka5bTWNxJBFh6GzsEyALSiUDPfspXwoNPVqJ4ojG6XQcexHLsmaFV4+UV8YnkMWdWI9GfEO/JnerM0ru9CsI2ApqgfkQqZ65BBqHsuDAB6R8+8Wj9IxuNemySqLuqsFGzGlqNRH3thu3JnKdKbP+pRezGAgFjDSbMcJRc/AHKNKIW4rfDzK7F144zOTzCj6N8sy0Q1Hb/G9KJJRTNiJ10PqtD6+genn5t9mog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyhFguK9ptD1G9OCi28BDnD58hcZOG9sdDt4wg4VgMo=;
 b=gcP7hNIW5IwEG0ekUb8ulRvoQ7igSx6Hfji1EVqNQ67M5Ls9viYnlOyeI4NXgosyIZb04gq7wQCcRV+tHEX5WoL2dUOuLdZsRV3uPe+mC+xuwSXy1shvG8ma+nJW+z1IzpI/Q1VAzA4hrbf/ObyQfJHowsxIDTeoziFo8KjxdRwODZgPOgkTaLZ7Z9zLPtV7s08FfKWByrw8p3vPeWFB05oXbv/Q5dmsZv0uStAr5SfMsMfEqox22ucpv7i49307XsooV1+wyP/RG+w6TtMdH+bkamX7y6dwtEQc8kC/5WmwRoPoK0DXcv6TqM09sUrCcd0qJjSei59dVzU9Xb3OgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyhFguK9ptD1G9OCi28BDnD58hcZOG9sdDt4wg4VgMo=;
 b=ly9wuuGLSii+U+GsQG7Q4YGaPjyUemMmUOiV3xDVJ4wS7xzpxQUu3TpVXfW/mTg8IHxkuEjmGh0fJxt+LScgFO5kh8rGlqlFj2apt/reZrlmh5z9zV6Xxc7M/gs9saO+AVdQlRZBWablAci1i/mqm4mv+wvNsUaD5cxD4guDjUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 19:26:11 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 19:26:11 +0000
Message-ID: <7efb228e-5c0d-42ad-a0e0-cc7d55e1db12@amd.com>
Date: Wed, 3 Jun 2026 15:26:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add sdma queue counter for gfxv9
To: Eric Huang <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260527175921.192734-1-jinhuieric.huang@amd.com>
 <94fcce68-98bc-49c9-ac44-1235644aa309@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <94fcce68-98bc-49c9-ac44-1235644aa309@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::15) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: da05e402-0d86-46f9-dad3-08dec1a5f83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: wKFwrRsD2JZCoOuMAeDOSxz4OXJ5ddpyZUQnP8KQrdI67V1wWaOxUMaPlOmuxPrhgpHhJnmn/KCjbCB3Iy612dVyTL9gLqlM2F3gC9sKnk/+zjIVn9MT6FKpYgyhkg5g9CtQqgwfp8EKUt8+KwABjL3026wY879vz0dwjegh0an636mrdcR6RMMGdT1RmwFUFpr/q/rHUYR2kdqMpB8UA7jZgkwXiE0xaFn7HI7KibcudwGLZRGteqHW6753pXgJY0BALlBnJsIj83Z14JWEgdOLT36pHoRzLw0DNNrPL2XKZjDA1EK8lZf7GF7KXGJVV7FIWUYyOd+H0zSTO4oxM6f3FC8+nAo1dUfFHXRgaW5Z1VKMoF5bW3eCDXHOxj2FJsfh3/og11HmUGSX8ch+gBHfZewp7cDguMVpBjY8829jHCwd+VZs/jsupHmxO4lTilqd9TV6I9523EUdE8T0DUEjnaIz8Ha9M75wlRKWHucQubYIdpWQ8AiPAgT49prxMg3TQFfKJHQEuxg0Z3by5spGos3uvdxdIi74o1vW+3TNHdveXx/iIa1N9CWu1DfcsHMazdtw1cwz8IvMrcDsqQVAe0C+lq5oWhmOkmBnfCWQ2ZmITwkgQOWfS4sF8pr3tgd4vc8wV0IEqTIjLSm2kHyhGY2kWhYfQWxNK4isNHaJkMoZJPHx7VtPM4GtZBiU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2tqWXdCOFhNTGdOaFFoN0F5VzR4ZkhMZWdLZHZjbVl3ZFptMU1IR1Q3R3JV?=
 =?utf-8?B?SThFaHh1TklPQ0J4NWRLbXFCOUdjVGRRQjkra2NyT214T2krZXZmdnRRbjc3?=
 =?utf-8?B?dE5XYzVaOUEzblp2N3VLak9ZZTA4YUhGYzdtNFJiaGxtRXVEK2drM01JKzJ3?=
 =?utf-8?B?czNHR0FuekY2K0RFZkJOSFRYT1BxNXo1RHRVN3E3a0prSHBlZ1NIalhjeWtq?=
 =?utf-8?B?YmYyUXE3d2NDQmx4YkRIc0xDVXFTZGV6NDJmVnN3L1hDd04yb1NIYzNyOURx?=
 =?utf-8?B?M2RtUmR0NnFLTisyc01JckpoVnZYaXg5aEVhdkxsSnhScGwreEJPcS8xNnNo?=
 =?utf-8?B?SThLQTQ3Y3h4TVE0ZjJVKysvQkw0aVRnNEhCQ2JkR2duYndCeDd2QlkyOHdJ?=
 =?utf-8?B?TmZvZncyN2NZTC8vYWhza2lHdHlQa3ZuRDJVS1kwNHFaS0RiYzNaZHpyUENV?=
 =?utf-8?B?TFg0Ny9TS3VNWVVlVjJ2Yi9HUUdqM0tQbUhjOXJRZVpJVko3dkRnSjNzclRM?=
 =?utf-8?B?ZWFoaTBIU0ZWNWhoTSsxNGxGWUx4bWd4RFVEUTNKb2RCclVRRXRGVXJnb2Ex?=
 =?utf-8?B?aHNVWFZ0UVpydU5RN1NETDBHcUtjUWdzMC9tVTVrcXRPa2tocXQwVmQ2c0pK?=
 =?utf-8?B?TXpqRHY5SzQ4Y1Y5cVZTQlVMMTFSb3dmU2s3RWFjaExsM214MGZoQkJRYjhi?=
 =?utf-8?B?UHhDU1RGdWRZZSs0Smx1UzVMMXUyUFo1d1dvRFZNMWxmUG9FLzU2L0gyRHFG?=
 =?utf-8?B?U0Z0S2dCSGEwRUVlc2JYNE5IeGlnZ3R2SFMrZGtDTXRxWWZQeDdiZElhR0VJ?=
 =?utf-8?B?NFE3YjRXUS9JbmhCTFVDSEx6Yy9Ldk1uOVl2Uk1hbUZ3OW9sL3NQNHpmR1ZF?=
 =?utf-8?B?ZVBLaEVwZklNREk0bkEydmJ2cU1YUFA4QUhqUWNldSswSE9ZY29XWFlpUDNW?=
 =?utf-8?B?UTdsWjBaczZWdzZ5NjI2aHZlRHRVdHh3d0w3N2ZnMThPZVRyRjlLRVFMZG5I?=
 =?utf-8?B?aGNTc2R6OUw0WVo2VUVmRDRiRUpUeVNNWGZmakw3WmMrdkNyaUlKK1hQMlRw?=
 =?utf-8?B?NzJFSHJ4cC9WcU51QkliNG1ERW5JTjJmQ01iWFQxK0pia1VQaENmTjJ6SVg1?=
 =?utf-8?B?ZlJCWU9IWEJxbkZnZnFCWEt4T0NnRG1PQWN3MG1kL2g2am9ZZlpWRlpLN3VX?=
 =?utf-8?B?QjlKdFJjMUFwVkV3eTgxQjE3OThHak1xYjRIb1pvRlJNeUFMYnh2bWxwWTJ5?=
 =?utf-8?B?amtpYzMzN1psQVMzUjFHSVRQOVB5Y1FSU29HMEd6ejVMTXNDbmM3NXdhVlh6?=
 =?utf-8?B?TVhlWHdQc2NwNkUwOFpmUU5la2FPcmxkbm5lTWpXck1iTVJiWjlnOTRaRkVP?=
 =?utf-8?B?V2t6NlFURGIvYUp0WWtVd0Ywc3hYU25PSUE5Vzk1NVozZ2VraDJLcFVsV1hz?=
 =?utf-8?B?bTVZOHFVa1hrY3lzYVB6SjgzcjNoSWlydzNvcGZuMUhUb0xlVUhsT3NkYURn?=
 =?utf-8?B?QWViVHFnNURsNzJpemx4cVZuYm1uN2xZeDNITTQ3T2Ivb3YzMzdWVzYwaG8z?=
 =?utf-8?B?bjRnckdCY2I2Q2FuM3RKZWYrRUR1azNmK09PVm9NSzNHT1R1VU9rWFdHRncz?=
 =?utf-8?B?Z2lLU2lBVWwvS3lyOW53bmtsOVBFYXJHTGVHdGppeFIwNm51MzFsbUl4a1VK?=
 =?utf-8?B?b2d1clVFTUIvZVBMVlNYV0ZBMkF4aVdHZGpDMUxIZWVEZStsakxzb2Q3YUxF?=
 =?utf-8?B?U2V6RVkvQ0pKeW9wYVhBNUQ1ODlTMGgzbktYMW5nc3hjT3FoaFRUS1FvZDF0?=
 =?utf-8?B?cC9EdVVxTFNTTzFkYjhkbmhWb1B4VXZpK21ScEg3YXMrVnk0VGhqbHYxRWYv?=
 =?utf-8?B?STI1LzRpQVZ4M3hyMFJBUzlDbmRDOTkrTGF4V1pZQkFNdkx2Mnd1dVIxWHdl?=
 =?utf-8?B?YUJEb2RzbUswUWFVaXU4WEE0MDZPZ1NaZldvYlgxRmliKzU4bUp4ZTFkM3Fm?=
 =?utf-8?B?Wis5d0pWZ2JlK2RMQzFLYi82S1RIaEhZdDBtR3lkd2NmSWlNNlJRNVV6L1FY?=
 =?utf-8?B?VkhHQXYvRjNLV2xndEV5bXE2NFlPdHRlanhicmkrb3JTZllsaU9XRDNvM3A3?=
 =?utf-8?B?aHhwYW9PVXJWU2tLRnVYaVBQNVZvclJlaXhERGxhT0tsY0FKbG95NkZVUzNY?=
 =?utf-8?B?emVhbGhEeGJRUG1JM0JnYndoK1dlb0dzZHBINTR6VGxLSFZHZjdPeERQNmVD?=
 =?utf-8?B?MmtVSzRja1g3c01OZmovc1k2SThhK3d0VlNYK0p1WnVvcTBBc29RS0ZDRUpO?=
 =?utf-8?B?ZWg4QXU4VTFZcllwNmVSZ2tGQWhaSHY3VU15c1QvalVOY1ZQajBmZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da05e402-0d86-46f9-dad3-08dec1a5f83a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:26:11.3365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoDuSebsY7uLfO4oGFt0Nnfu6lch/SvzMfxD3MAlLhHSGtAcLZOS1qeTpjbCYOsabGlAwFhQOn2uSPtoo4k5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
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

Please ignore it, I will send out new version of it.

Eric

On 2026-06-03 09:41, Eric Huang wrote:
> Ping ...
>
> On 2026-05-27 13:59, Eric Huang wrote:
>> since gfx 9.4.3 HW is calculating accumulated activity counter
>> per-queue in register sdmax_rlcx_utilization_hi/lo, CPFW adds it in
>> sdma MQD for save/restore, KFD will read it from there. gfx 9.4.2
>> will still keep the way to read from memory at rptr+8.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 26 +++++++++++++------
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  1 +
>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 18 +++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 15 ++++++++++-
>>   drivers/gpu/drm/amd/include/v9_structs.h      |  4 +--
>>   5 files changed, 53 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 4c2378bbdc95..1a69091aa695 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -1064,8 +1064,14 @@ static int destroy_queue_nocpsch(struct 
>> device_queue_manager *dqm,
>>       /* Get the SDMA queue stats */
>>       if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>>           (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>> -        retval = read_sdma_queue_counter((uint64_t __user 
>> *)q->properties.read_ptr,
>> -                            &sdma_val);
>> +        if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
>> +            retval = read_sdma_queue_counter((uint64_t __user 
>> *)q->properties.read_ptr,
>> +                             &sdma_val);
>> +        else
>> +            retval = mqd_mgr->read_sdma_counter ?
>> +                 mqd_mgr->read_sdma_counter(q->mqd, &sdma_val) :
>> +                 0;
>> +
>>           if (retval)
>>               dev_err(dev, "Failed to read SDMA queue counter for 
>> queue: %d\n",
>>                   q->properties.queue_id);
>> @@ -2689,7 +2695,8 @@ static int destroy_queue_cpsch(struct 
>> device_queue_manager *dqm,
>>                   struct queue *q)
>>   {
>>       int retval;
>> -    struct mqd_manager *mqd_mgr;
>> +    struct mqd_manager *mqd_mgr =
>> + dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
>>       uint64_t sdma_val = 0;
>>       struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>>       struct device *dev = dqm->dev->adev->dev;
>> @@ -2697,8 +2704,14 @@ static int destroy_queue_cpsch(struct 
>> device_queue_manager *dqm,
>>       /* Get the SDMA queue stats */
>>       if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>>           (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>> -        retval = read_sdma_queue_counter((uint64_t __user 
>> *)q->properties.read_ptr,
>> -                            &sdma_val);
>> +        if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
>> +            retval = read_sdma_queue_counter((uint64_t __user 
>> *)q->properties.read_ptr,
>> +                                     &sdma_val);
>> +        else
>> +            retval = mqd_mgr->read_sdma_counter ?
>> +                 mqd_mgr->read_sdma_counter(q->mqd, &sdma_val) :
>> +                 0;
>> +
>>           if (retval)
>>               dev_err(dev, "Failed to read SDMA queue counter for 
>> queue: %d\n",
>>                   q->properties.queue_id);
>> @@ -2724,9 +2737,6 @@ static int destroy_queue_cpsch(struct 
>> device_queue_manager *dqm,
>>         }
>>   -    mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>> -            q->properties.type)];
>> -
>>       deallocate_doorbell(qpd, q);
>>         if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
>> index 06ca6235ff1b..7d3b801ea6e3 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
>> @@ -123,6 +123,7 @@ struct mqd_manager {
>>       bool (*check_preemption_failed)(struct mqd_manager *mm, void 
>> *mqd);
>>       uint64_t (*mqd_stride)(struct mqd_manager *mm,
>>                   struct queue_properties *p);
>> +    int (*read_sdma_counter)(void *mqd, uint64_t *val);
>>         struct mutex    mqd_mutex;
>>       struct kfd_node    *dev;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index a04102fd2fb7..fe3a676d734f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -959,6 +959,23 @@ static int get_wave_state_v9_4_3(struct 
>> mqd_manager *mm, void *mqd,
>>       return err;
>>   }
>>   +static int read_sdma_counter(void *mqd, uint64_t *val)
>> +{
>> +    struct v9_sdma_mqd *m = get_sdma_mqd(mqd);
>> +
>> +    if (!m)
>> +        return -EINVAL;
>> +
>> +    /* Since GC 9.4.3 sdma queue activity accumulated
>> +     * counter is saved/restored in MQD by CPFW when
>> +     * queue is unmapped/mapped.
>> +     */
>> +    *val = ((uint64_t)m->sdmax_rlcx_utilization_hi << 32) |
>> +        m->sdmax_rlcx_utilization_lo;
>> +
>> +    return 0;
>> +}
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>>     static int debugfs_show_mqd(struct seq_file *m, void *data)
>> @@ -1072,6 +1089,7 @@ struct mqd_manager *mqd_manager_init_v9(enum 
>> KFD_MQD_TYPE type,
>>           mqd->restore_mqd = restore_mqd_sdma;
>>           mqd->mqd_size = sizeof(struct v9_sdma_mqd);
>>           mqd->mqd_stride = kfd_mqd_stride;
>> +        mqd->read_sdma_counter = read_sdma_counter;
>>   #if defined(CONFIG_DEBUG_FS)
>>           mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 419bb8086ccd..270f253213e4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -91,6 +91,7 @@ struct kfd_sdma_activity_handler_workarea {
>>     struct temp_sdma_queue_list {
>>       uint64_t __user *rptr;
>> +    void *mqd;
>>       uint64_t sdma_val;
>>       unsigned int queue_id;
>>       struct list_head list;
>> @@ -108,6 +109,7 @@ static void kfd_sdma_activity_worker(struct 
>> work_struct *work)
>>       int ret = 0;
>>       struct temp_sdma_queue_list sdma_q_list;
>>       struct temp_sdma_queue_list *sdma_q, *next;
>> +    struct mqd_manager *mqd_mgr;
>>         workarea = container_of(work, struct 
>> kfd_sdma_activity_handler_workarea,
>>                   sdma_activity_work);
>> @@ -119,6 +121,9 @@ static void kfd_sdma_activity_worker(struct 
>> work_struct *work)
>>       qpd = &pdd->qpd;
>>       if (!dqm || !qpd)
>>           return;
>> +
>> +    mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA];
>> +
>>       /*
>>        * Total SDMA activity is current SDMA activity + past SDMA 
>> activity
>>        * Past SDMA count is stored in pdd.
>> @@ -161,6 +166,7 @@ static void kfd_sdma_activity_worker(struct 
>> work_struct *work)
>>             INIT_LIST_HEAD(&sdma_q->list);
>>           sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
>> +        sdma_q->mqd = q->mqd;
>>           sdma_q->queue_id = q->properties.queue_id;
>>           list_add_tail(&sdma_q->list, &sdma_q_list.list);
>>       }
>> @@ -189,7 +195,14 @@ static void kfd_sdma_activity_worker(struct 
>> work_struct *work)
>>         list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
>>           val = 0;
>> -        ret = read_sdma_queue_counter(sdma_q->rptr, &val);
>> +
>> +        if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
>> +            ret = read_sdma_queue_counter(sdma_q->rptr, &val);
>> +        else
>> +            ret = mqd_mgr->read_sdma_counter ?
>> +                  mqd_mgr->read_sdma_counter(sdma_q->mqd, &val) :
>> +                  0;
>> +
>>           if (ret) {
>>               pr_debug("Failed to read SDMA queue active counter for 
>> queue id: %d",
>>                    sdma_q->queue_id);
>> diff --git a/drivers/gpu/drm/amd/include/v9_structs.h 
>> b/drivers/gpu/drm/amd/include/v9_structs.h
>> index a2f81b9c38af..e0d387f08576 100644
>> --- a/drivers/gpu/drm/amd/include/v9_structs.h
>> +++ b/drivers/gpu/drm/amd/include/v9_structs.h
>> @@ -69,8 +69,8 @@ struct v9_sdma_mqd {
>>       uint32_t sdmax_rlcx_midcmd_cntl;
>>       uint32_t reserved_42;
>>       uint32_t reserved_43;
>> -    uint32_t reserved_44;
>> -    uint32_t reserved_45;
>> +    uint32_t sdmax_rlcx_utilization_lo;
>> +    uint32_t sdmax_rlcx_utilization_hi;
>>       uint32_t reserved_46;
>>       uint32_t reserved_47;
>>       uint32_t reserved_48;
>


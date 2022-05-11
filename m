Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC13BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 09:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402CD10E2FB;
	Wed, 11 May 2022 09:04:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320A510E2FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 09:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io1y+43JEd4NvUjpqfY2mlCrhc8/r/nNCKW3SsRKV3T3Pq4GadQ+ZPzdGt0H69geplwF0Dm2U4AOYRFySfJdVWxGZJGDIfPSFDVk/7bAojYVaAAHaYYQpOshGeJtpl/sF3uIFCDbPqH507XjVcLHvVdccRtq/EkuaKp1HBJdKOd0XvDhm3Q9S3esfM3+Lcj/eXXcTn5xiLSw9sPbtvhmkJyjTyLOo1YkMf0IyE+UrvtU+6P3CisEl42t8pqg4MskAtIlAbm7YFucfVGiIuhNl+2u3YXIKgicklsLxX4OItt1OqUxVIgs4jT1STqJNZTbcYD6VMYPfzK2J5xIHhXn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Qs2xT2266J1fVTHA2sOJ28STT83EFOQhta3TmjTJSI=;
 b=VJaYbN5sWZGW5amc1l9zKzt5ZvAf7nTEn404B8+jw1hm/ltGIsdaCO6EqJyvItnn1vHMPx5I0ehpVdmQRmS8pLZGQH+KnFpWUQLfzCmKON9MKP5EnIuarord8fDJu/OYHl3nnGCzt1zx3tIETCcpGjOq5l5udJhqnqzhUGfP9VCR58/YbA0X7k7f8cmXSVa3HDT3B7LjLpFV3Z2koDb5acLdJhULQaXqxPN6V+OUgpN2hMSHe2CyG2tSsYMRP+q+A8Z3b2Dyck40hznOmPAy3+p/4MPZDAZMl2z/YgqQ/lyULQnttOpAaH3ozdaNL/an328jnmriEChvl0EqD4lJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Qs2xT2266J1fVTHA2sOJ28STT83EFOQhta3TmjTJSI=;
 b=Il0BK+OU5rn2klKzLuroJddqNTMnmWLFrLU5+L9mLUcnwHE+SNa11Hh8BzFoAlpm4kJBZZp0uovoZYSmqKAe0PLero2hEZedruBnijehtI5Y2znZm8sgVCJdxmEfqX4v9KxeOgr0NSCZO6bkiry3BueYcfXF+FbBwg5q0zUrtSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Wed, 11 May 2022 09:04:33 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 09:04:32 +0000
Message-ID: <8bea832d-f624-4870-9770-19d5c20b675f@amd.com>
Date: Wed, 11 May 2022 11:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Convert to common fdinfo format v2
Content-Language: en-US
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20220510165550.2048-1-christian.koenig@amd.com>
 <87ad9b96-ba07-1489-87dc-980d6576d1e7@linux.intel.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <87ad9b96-ba07-1489-87dc-980d6576d1e7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::45) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bed4a5e8-5edf-4ad4-0df8-08da332d4381
X-MS-TrafficTypeDiagnostic: DS7PR12MB6023:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB60231765DB1E03D0F340FD9D83C89@DS7PR12MB6023.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n41CvhiHxcuqsn+kn7s9qLFbOZH4ZPjIVfkZFo8YeREr9gVo7IWGWZSk8DdlYbaY/nFSzWdusEmxEEvFWx/SsNTGH+aBf2vU9onCjZA2izUAHi5wcK8VxhxYOZiFKfKLBYPgHo734YUSuUFs7bS4ft58WZYHT652o3Xf+15Xhvo8Aa9UKdsqQgnt83Jkn3NHsdcHzZam+pYyGap04yyQ/RlTawglMW9mEV0ALndD2P3nHulxONq86zX6ssI8YCUOHbNjFnBgOH3ZVtAPPB/zkzf8CXjLmTAttYd2bHee29rCKEX0Ux5M5C/L2jYzQc6YkILM9vh76kw1TQasB/89bnrZe+t9N4G8RWR9jo2NqgEeJfnzX30vocdg+DnT3nK4cI+HhwUXOSd3qnLUccYMB5yW4s6XmXOam/uN8QUUg7LEaX06NTBP0kidEJFcp/ePlNtSlA0kVl3XcIPlbjHv0ZfLdZ03oFze2H0KQBLgd4wl03xW3RXKUWgkIGQr9kdYl7HmcI8fc4h5Q6KU0k1nkeQJCQlRt7Bva7IKmHzKts2I62m/bOhysKfqYPB1bLuPTJQqNDFpTtVS4wtKdp4IXQ11JHq7Gmwvz6T0bvmKXBdhppok0b27ijs7KLh4Iv96KBM0k04Irsz6Jo2IZ7edEDTruvFUg0dEbERvK93p/my21vyKY78z0Y6os+QeZ9OIQwDBRu573m5Dd86XduRnwvhl86Cxjzlup4CZZaRW4B+7shtI68e/6U9D0FRsogzo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(30864003)(110136005)(54906003)(4326008)(66556008)(6666004)(8676002)(83380400001)(66946007)(66476007)(6512007)(6486002)(38100700002)(508600001)(36756003)(31696002)(8936002)(2616005)(6506007)(53546011)(2906002)(86362001)(186003)(5660300002)(66574015)(31686004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVdjNjNONUx1WUV1Y3lGUklXblhOQkpFS0U5NGk2UVFacVlUdFdGM3drNTA5?=
 =?utf-8?B?clk2UUhETjVYUkpwTUZJbEZVRkJPMFV4dk16VlRKR0dRcGxRQjBwN25QeWpE?=
 =?utf-8?B?OVhnUndqV2NTQ0ZxSG1NaGE5aDN3US9MSllGYWdtVG5ic2Uza2FnU2JrZW94?=
 =?utf-8?B?TXArcmltK01UZVYvY1JMaXlPL3VrQ1JxeE03a2V0dDNHK1pzdHpNenJDKzI4?=
 =?utf-8?B?QThUSWFKeXBob0lraUptWmd0K1JLdFdHOVIwZnY1QUI1d2R2cTNLWmtjcFoy?=
 =?utf-8?B?OFJYaVdJUUx5bFVqT1A2aXRLayt5NkxvcXZoenhHWnY2Vks4RXhvY0FHQU9z?=
 =?utf-8?B?OVRXTHNSckJzZVJqbmJjSmFmay9hN256UGYveWFUVkdqTUs2bU9QdzhsUjVF?=
 =?utf-8?B?RnowM2FUSnJBeXFHRTJ6SkxnMWM5OHVSS1VOWCsvblVzTjBqV0xVV2NHd253?=
 =?utf-8?B?UGYrZVREamV5TlVYa2pDMlJLTDdlK01UN3RleUZ6ZGpHMUtCYTgrQnlRM0Jx?=
 =?utf-8?B?VGFVVzFVZnA4YjZ6Rm5kaUxBK1JBMEJ0OUFYdmkyWTlsdXUwZmJDZzRsSi9D?=
 =?utf-8?B?TG1GNXM0cGx6ZnFVNkdsdFNqQjYzcFlXSnpJQ1QwWHpSOFA5YndvanJON1RZ?=
 =?utf-8?B?VUlwSGIyM3U2YSs1VFpscGl3SUFheTY2NGZzbUN0RFFjUTNuazF4TE5QTzZ4?=
 =?utf-8?B?dlc5ZHNNbzMrRGcrQnVQK20zL1lMOStYRTZMUEI1TG9haDlvQlhEbUU2YkxS?=
 =?utf-8?B?amdBbWtUem0rMzc2dkNMaEx5MjVnTDVSWllXYkhUSXdvR0lrdnJUYWpXZzNs?=
 =?utf-8?B?b2xOVlNiREVyek5uNHN1ZSs2bzFYc1p3ZnFLaC8yM2pUdlU1ajMvamhNcVRx?=
 =?utf-8?B?STl6RnZyT2ZSMzhvZXNST3VRWUkwb1JrWEk2NFFoV25udWNnMEV5SURLWVlo?=
 =?utf-8?B?dUxQK0luVjVHQ2ZpVWpXV0RUa0sxVWRrV2tVQnZ5Y1FnWG0rbU5CR2p3aHBp?=
 =?utf-8?B?aHZJU3UvWjlFR2FtQ21rd3pud1FIRjErVHlTbkozbUc4eDNnWksvVmU4Ym5k?=
 =?utf-8?B?VGUzMjJJbzNkK2phYXdvS0pRbHZlK1FIV09WU1Qrd3N2RGdEdmtWanN6OTZr?=
 =?utf-8?B?WXZvSUhrZGxkQ3YxMU5UNnI2RVRXVU9mckNibmwvQTlqLytyN0dzMFU3SnpQ?=
 =?utf-8?B?ZS9qaE9LL0hKQncwOGc1NHRQUWZxeVVwMFJpWGpTb21EdkZabnREcjRlRkZV?=
 =?utf-8?B?UjdPSUZoa3FRZjZTYWh3Qmt3bzRjUWpFa015RGd1ZHR1NXBzTFEzZzhtekto?=
 =?utf-8?B?cmRjTW1ONFVnb05WRHk5RnpKR1VDclE0S1ZIT1B5YzEvTHJxY2U2UDhjUkg4?=
 =?utf-8?B?R1lOMnEvV1FVa2VCMDJQaDVFWmpwRmFidGZxaTFKT3h3MXF3Y0RZTG5pU0pI?=
 =?utf-8?B?TzRJL3dNMWp5dytOWFdSdzIwRDRQN1FzcFhvaWgrdStSRjhVQzRWTVV4VTUy?=
 =?utf-8?B?Z1ZvWDlFSW5ieWNFWjRiYjBVelV2cU5hUkZkMUZ1VFRwQWxndFM4dUlzWVlM?=
 =?utf-8?B?dkdST3dvbHQ2aXQzdDArMnBmOUV6NERSaHEvNEZmZE51NGhRczcvWldVUWxP?=
 =?utf-8?B?cVJybUdHV2l1Q01ycnNjTEhJamFPRmFzTitzRGpDVkFyOEFFTisxa3l6bFMw?=
 =?utf-8?B?VENHSEh5RnZvQ2psbFZjcDJ6M2VEL0ZDZy9zakZxRFJKV0JnUE5wa09QYWJL?=
 =?utf-8?B?azVpa0h4ZkdHYUVwTjhSTFN2ZVcrQ2l4VHJ3OTZQeUFVNmdrMXNUN3dtYVkw?=
 =?utf-8?B?bHArQVVJMURwMzdiU01ud3lRWUdVc0NTRWd5UUR1bHJqRGg3TTVGdW9KRWw3?=
 =?utf-8?B?WFJuY1RSZ2E0aHd0QUVsM0dWeWFzQ0V1OGhrWjd4QnBacnpjZWxPbWVjTVhZ?=
 =?utf-8?B?YTlrTit4YWlxVzRxbkpiNGhVRVRaRTdzdnlhMXFwZVlXRFEvTWVZNjNkcndo?=
 =?utf-8?B?NHdYL1c4SE1GRGg4dXNCa201TnJjMlFWaWNBRHpqY2ZGTk1XWDEyMDNBS0Ns?=
 =?utf-8?B?Q0dYU0k0NGFLb0ExY0RpTExSVkZ6UjZpOTNpRC9xUGRHeUdhV0ZYUllhK1cx?=
 =?utf-8?B?Tmw2OFMzdi81WjdRQ1ZFeUNnRHJ0cFAyWUFlZ2pqbW5xSWtUR0xFcmFXcVpu?=
 =?utf-8?B?WnRYWm9qZncyTy8xdGE2cS93V1gwMzN0UXVCajl4VC9qYi9aYkJOaEdabWxL?=
 =?utf-8?B?VHNtSFpKclhXQUM4dk9JaXZiTkJYeTEwVG16S2gwU3I2TGk3SUU1aTIvR1Zx?=
 =?utf-8?B?ZFBlQVp5bUhhckQwQmJnYnhqd2hsTHFGOWYyVUV0b2Ixc2JoaWdXQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed4a5e8-5edf-4ad4-0df8-08da332d4381
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:04:32.7141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42LTWQHicfxyJkyilC3JmW5k1jLiPRGBTG3jUeqmC1WTLVYO1UUTHKoyicgtYWPL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
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
Cc: David M Nieto <David.Nieto@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.05.22 um 10:04 schrieb Tvrtko Ursulin:
>
> On 10/05/2022 17:55, Christian König wrote:
>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>
> Feels like you should take over owenrship since you wrote a lot of 
> new, amdgpu specific code here.

Yeah, probably.

>
>> Convert fdinfo format to one documented in drm-usage-stats.rst.
>>
>> It turned out that the existing implementation was actually completely
>> nonsense. The calculated percentages indeed represented the usage of the
>> engine, but with varying time slices.
>>
>> So 10% usage for application A could mean something completely different
>> than 10% usage for application B.
>>
>> Completely nuke that and just use the now standardized nanosecond
>> interface.
>>
>> v2: drop the documentation change for now, nuke percentage calculation
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Cc: David M Nieto <David.Nieto@amd.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 136 +++++++++------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  45 ++++---
>>   3 files changed, 88 insertions(+), 101 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index 8f0e6d93bb9c..988c5a76cad2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -183,6 +183,7 @@ static int amdgpu_ctx_init_entity(struct 
>> amdgpu_ctx *ctx, u32 hw_ip,
>>       ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
>>               ctx->init_priority : ctx->override_priority;
>>       entity->sequence = 1;
>> +    entity->time_spend = 0;
>>       hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>>       drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
>>   @@ -666,6 +667,26 @@ int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
>>       return 0;
>>   }
>>   +/* Calculate the time spend on the hw */
>> +static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
>> +{
>> +    struct drm_sched_fence *s_fence;
>> +
>> +    if (!fence)
>> +        return ns_to_ktime(0);
>> +
>> +    /* When the fence is not even scheduled it can't have spend time */
>> +    s_fence = to_drm_sched_fence(fence);
>> +    if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, 
>> &s_fence->scheduled.flags))
>> +        return ns_to_ktime(0);
>> +
>> +    if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, 
>> &s_fence->finished.flags))
>> +        return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
>> +
>> +    return ktime_sub(s_fence->finished.timestamp,
>> +             s_fence->scheduled.timestamp);
>> +}
>> +
>>   void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>>                 struct drm_sched_entity *entity,
>>                 struct dma_fence *fence, uint64_t *handle)
>> @@ -685,6 +706,7 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>>       spin_lock(&ctx->ring_lock);
>>       centity->fences[idx] = fence;
>>       centity->sequence++;
>> +    centity->time_spend += amdgpu_ctx_fence_time(other);
>>       spin_unlock(&ctx->ring_lock);
>>         dma_fence_put(other);
>> @@ -692,6 +714,42 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>>           *handle = seq;
>>   }
>>   +static ktime_t amdgpu_ctx_entity_time(struct amdgpu_ctx *ctx,
>> +                      struct amdgpu_ctx_entity *centity)
>> +{
>> +    ktime_t res;
>> +    uint32_t i;
>> +
>> +    spin_lock(&ctx->ring_lock);
>> +    res = centity->time_spend;
>> +    for (i = 0; i < amdgpu_sched_jobs; i++) {
>> +        res = ktime_add(res, 
>> amdgpu_ctx_fence_time(centity->fences[i]));
>> +    }
>> +    spin_unlock(&ctx->ring_lock);
>> +    return res;
>> +}
>> +
>> +ktime_t amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
>> +                 uint32_t idx)
>> +{
>> +    struct amdgpu_ctx_entity *centity;
>> +    ktime_t res = ns_to_ktime(0);
>> +    struct amdgpu_ctx *ctx;
>> +    uint32_t id;
>> +
>> +    mutex_lock(&mgr->lock);
>> +    idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
>> +
>> +        centity = ctx->entities[hwip][idx];
>> +        if (!centity)
>> +            continue;
>> +
>> +        res = ktime_add(res, amdgpu_ctx_entity_time(ctx, centity));
>> +    }
>> +    mutex_unlock(&mgr->lock);
>> +    return res;
>> +}
>
> The amdgpu specific code I cannot really review - but I can ask a 
> question - do you have a concept of contexts which were used with a 
> client and then closed/abandoned, in which case would the time they 
> spent on the GPU be forgotten or preserved in this accounting flow?

Oh, good point. So I should probably accumulate the time spend by 
garbage collected fences on the context manager instead of the context 
entity.

Additional to that I think separating the output by scheduler instance 
doesn't make any sense at all because those are not related to the 
hardware engines. In other word the SDMA0 queue of process A can go to a 
different hardware engine than the SDMA0 queue of process B and that 
makes the values not comparable.

Thanks,
Christian.

>
> In i915 we have this so I am accumulating the times spent by contexts 
> as they are closed into a data structure associated with the owning 
> drm_file.
>
>> +
>>   struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>>                          struct drm_sched_entity *entity,
>>                          uint64_t seq)
>> @@ -869,81 +927,3 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr 
>> *mgr)
>>       idr_destroy(&mgr->ctx_handles);
>>       mutex_destroy(&mgr->lock);
>>   }
>> -
>> -static void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx,
>> -        struct amdgpu_ctx_entity *centity, ktime_t *total, ktime_t 
>> *max)
>> -{
>> -    ktime_t now, t1;
>> -    uint32_t i;
>> -
>> -    *total = *max = 0;
>> -
>> -    now = ktime_get();
>> -    for (i = 0; i < amdgpu_sched_jobs; i++) {
>> -        struct dma_fence *fence;
>> -        struct drm_sched_fence *s_fence;
>> -
>> -        spin_lock(&ctx->ring_lock);
>> -        fence = dma_fence_get(centity->fences[i]);
>> -        spin_unlock(&ctx->ring_lock);
>> -        if (!fence)
>> -            continue;
>> -        s_fence = to_drm_sched_fence(fence);
>> -        if (!dma_fence_is_signaled(&s_fence->scheduled)) {
>> -            dma_fence_put(fence);
>> -            continue;
>> -        }
>> -        t1 = s_fence->scheduled.timestamp;
>> -        if (!ktime_before(t1, now)) {
>> -            dma_fence_put(fence);
>> -            continue;
>> -        }
>> -        if (dma_fence_is_signaled(&s_fence->finished) &&
>> -            s_fence->finished.timestamp < now)
>> -            *total += ktime_sub(s_fence->finished.timestamp, t1);
>> -        else
>> -            *total += ktime_sub(now, t1);
>> -        t1 = ktime_sub(now, t1);
>> -        dma_fence_put(fence);
>> -        *max = max(t1, *max);
>> -    }
>> -}
>> -
>> -ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, 
>> uint32_t hwip,
>> -        uint32_t idx, uint64_t *elapsed)
>> -{
>> -    struct idr *idp;
>> -    struct amdgpu_ctx *ctx;
>> -    uint32_t id;
>> -    struct amdgpu_ctx_entity *centity;
>> -    ktime_t total = 0, max = 0;
>> -
>> -    if (idx >= AMDGPU_MAX_ENTITY_NUM)
>> -        return 0;
>> -    idp = &mgr->ctx_handles;
>> -    mutex_lock(&mgr->lock);
>> -    idr_for_each_entry(idp, ctx, id) {
>> -        ktime_t ttotal, tmax;
>> -
>> -        if (!ctx->entities[hwip][idx])
>> -            continue;
>> -
>> -        centity = ctx->entities[hwip][idx];
>> -        amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
>> -
>> -        /* Harmonic mean approximation diverges for very small
>> -         * values. If ratio < 0.01% ignore
>> -         */
>> -        if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
>> -            continue;
>> -
>> -        total = ktime_add(total, ttotal);
>> -        max = ktime_after(tmax, max) ? tmax : max;
>> -    }
>> -
>> -    mutex_unlock(&mgr->lock);
>> -    if (elapsed)
>> -        *elapsed = max;
>> -
>> -    return total;
>> -}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> index 142f2f87d44c..b5bb4425b0ac 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> @@ -23,6 +23,8 @@
>>   #ifndef __AMDGPU_CTX_H__
>>   #define __AMDGPU_CTX_H__
>>   +#include <linux/ktime.h>
>> +
>>   #include "amdgpu_ring.h"
>>     struct drm_device;
>> @@ -30,10 +32,10 @@ struct drm_file;
>>   struct amdgpu_fpriv;
>>     #define AMDGPU_MAX_ENTITY_NUM 4
>> -#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) ((max) > 
>> 16384ULL*(total))
>>     struct amdgpu_ctx_entity {
>>       uint64_t        sequence;
>> +    ktime_t            time_spend;
>>       struct drm_sched_entity    entity;
>>       struct dma_fence    *fences[];
>>   };
>> @@ -89,6 +91,6 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);
>>   void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
>>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long 
>> timeout);
>>   void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
>> -ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, 
>> uint32_t hwip,
>> -        uint32_t idx, uint64_t *elapsed);
>> +ktime_t amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
>> +                 uint32_t idx);
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> index 5a6857c44bb6..38cb5eb105ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> @@ -32,6 +32,7 @@
>>     #include <drm/amdgpu_drm.h>
>>   #include <drm/drm_debugfs.h>
>> +#include <drm/drm_drv.h>
>>     #include "amdgpu.h"
>>   #include "amdgpu_vm.h"
>> @@ -55,10 +56,10 @@ static const char 
>> *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
>>   void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>>   {
>>       struct amdgpu_fpriv *fpriv;
>> -    uint32_t bus, dev, fn, i, domain;
>>       uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
>>       struct drm_file *file = f->private_data;
>>       struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
>> +    uint32_t bus, dev, fn, domain, hw_ip;
>>       struct amdgpu_bo *root;
>>       int ret;
>>   @@ -83,29 +84,33 @@ void amdgpu_show_fdinfo(struct seq_file *m, 
>> struct file *f)
>>       amdgpu_bo_unreserve(root);
>>       amdgpu_bo_unref(&root);
>>   -    seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", 
>> domain, bus,
>> +    /*
>> +     * 
>> ******************************************************************
>> +     * For text output format description please see 
>> drm-usage-stats.rst!
>> +     * 
>> ******************************************************************
>> +     */
>> +
>> +    seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
>> +    seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", 
>> domain, bus,
>>               dev, fn, fpriv->vm.pasid);
>> -    seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
>> -    seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
>> -    seq_printf(m, "cpu mem:\t%llu kB\n", cpu_mem/1024UL);
>> -    for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
>> -        uint32_t count = amdgpu_ctx_num_entities[i];
>> -        int idx = 0;
>> -        uint64_t total = 0, min = 0;
>> -        uint32_t perc, frac;
>> +    seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
>> +    seq_printf(m, "drm-memory-gtt:\t%llu KiB\n", gtt_mem/1024UL);
>> +    seq_printf(m, "drm-memory-cpu:\t%llu KiB\n", cpu_mem/1024UL);
>> +    for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>> +        uint32_t count = amdgpu_ctx_num_entities[hw_ip];
>> +        int idx;
>>   -        for (idx = 0; idx < count; idx++) {
>> -            total = amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mgr,
>> -                i, idx, &min);
>> -            if ((total == 0) || (min == 0))
>> -                continue;
>> +        for (idx = 0; idx < count; ++idx) {
>> +            ktime_t usage;
>>   -            perc = div64_u64(10000 * total, min);
>> -            frac = perc % 100;
>> +            usage = amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, hw_ip,
>> +                             idx);
>> +            if (!usage)
>> +                continue;
>
> Hmm I did not envisage fields dynamically appearing but it looks my 
> userspace happens to cope. Worst that would happen is order of engines 
> are displayed on screen could change between runs. And as my spec does 
> not define whether all possible engines should be always present or 
> not I guess it is fine like this.
>
>>   -            seq_printf(m, "%s%d:\t%d.%d%%\n",
>> -                    amdgpu_ip_name[i],
>> -                    idx, perc/100, frac);
>> +            seq_printf(m, "drm-engine-%s%d:\t%Ld ns\n",
>> +                   amdgpu_ip_name[hw_ip], idx,
>> +                   ktime_to_ns(usage));
>>           }
>>       }
>>   }
>
> Regards,
>
> Tvrtko


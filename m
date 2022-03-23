Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B75C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 03:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97F410E12C;
	Wed, 23 Mar 2022 03:02:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E587310E12C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 03:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8+NOr24s+tgvTj7GxFAszbZSpC06zllNgcXcI8pfwLzL9XQ8ENF6SwPLw2Bse6qia1m9npUz2K13E0AQ3zbu/xBVv4WunXby1hbo8TeF9l6yUrI1YR1d+5UKNQshLuedZI3Td8NVBdAEwv8zzZcpXyCqJK0B6uLc6RIqDOpfQ0QI6LuOoAPaZqMMM5S2e10S7yozEpJgzubYgcSyiZsP8Y/PKjMAeUkxVIx2ZpIgp8SIAe7jGcfU4mehAZTphgPjj/wnWmenT8JnFWQMiNQvxEYmjnoy46Fem0cjVG+NuN1fN92l1Ko0qdFbaLv4OkMhGXtqS8cTaYcIXYA2vqo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiW9u5V8Uy2zIZP7lvCORdQNX4qa2uTrswTbNgKfUDk=;
 b=fYIwUkMgPydMeX8QAwSTzJU3klm7CspAwWT8RWSaZljd3dbHCzV46AavVl2sQRbXKd6/cCdveLo+vXoEItVqYfWH8W0/nCULGwZRSwrjdC2p7ffK+LoZAlUHWHRI2NqoEktSfPMvk/pZOpKjlqyJrV7ZwyMZuSoaO2fIVLbW9DTLvrKC289FSnoA6X89/6LC1GhUq0XWsXOOck6fToP+Iq2E2RgjSyEOZIiMJP4ixD2j1/CyXmCCtNv7nAUljMlAAHv/CwVMJ/izTTGr8Xs76ukOhGuGXqGWxqWOGuWSvsPmWMtiiPIdNNnhy03uAcapzkHk+mhhVL4i8Sm9KZbsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiW9u5V8Uy2zIZP7lvCORdQNX4qa2uTrswTbNgKfUDk=;
 b=hoCy5qpxVnskIEUPtqZ5PmanxgT4oc6dEJVR4UbdIUicCwTkREZsVS/zgPEx9Mj4n8gkVW2MdVG1JiIrxj6o+rHo8OroKQPCn53KyJ+jQ05HALIrE4dWkl2OJVvb5C0yz3vxNHKT6J7ygXZx54vJxRk2BNZE31Kxeu+dR3mm/Z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1621.namprd12.prod.outlook.com (2603:10b6:910:10::18)
 by MWHPR1201MB2511.namprd12.prod.outlook.com (2603:10b6:300:e0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 23 Mar
 2022 03:02:41 +0000
Received: from CY4PR12MB1621.namprd12.prod.outlook.com
 ([fe80::f0cb:7010:df22:2416]) by CY4PR12MB1621.namprd12.prod.outlook.com
 ([fe80::f0cb:7010:df22:2416%2]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 03:02:38 +0000
Message-ID: <e424caae-277d-4aec-7057-8b38c27cd9ad@amd.com>
Date: Wed, 23 Mar 2022 11:02:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Correct the parameter name of amdgpu_ring_init
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220322125308.3771732-1-Jun.Ma2@amd.com>
 <bcf4bb86-4b76-0b02-d0f6-2af822e5276f@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <bcf4bb86-4b76-0b02-d0f6-2af822e5276f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To CY4PR12MB1621.namprd12.prod.outlook.com
 (2603:10b6:910:10::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 071ad53f-2683-4bed-4ae9-08da0c799673
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2511:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB251164CF2DD14865FDE07A80BC189@MWHPR1201MB2511.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zsWkuFvFWVs2kM7iZS6oJgmVjVWG2mb6FEnNjCN66/Cuq4qs3oz2+6gceXCOfRNXWhsGrPZ0Hs46hZiThaSKsxHYonMLacQjdig3ZS3FgfA7CYiTLZgLbmzZiCyG+9vRlqP6zETiAD4zOi2V2rB0m7gJQ7vFokpe7dKOlLmIJqtfFc+8Y9WTIz6iH9ScFPQ8/iowwDcHrfeOJ1edPgnI90x27UL0jjZOYjZa7uTFpCfo0BHBzH86lxWBpfevkbzbZZOso6DZd4ztCFk0qcfmhxYjz3FxE8oUGBqYC9lOw2HE32EgZ2GnL8hVZHqWcbuiWg4u06dIcihib4rwqmC+XzGoUChpqf/yztJLDObUHz+lUp7iUyqTNcBwDgzmjJWtyXR/ltkfq4qyl0oUg5pdOGZK6QjopASG6p3s9W4qL/T2c9u+u7QCXqBv6hPRLi19CQ+Jlfe67P/jhSlGnh/G9l0qSwKF6B729RCji6wG4MLLr3NoUW9hLCc7lRFIoP1ep5lUnhxvHofb9HVc1WsclXlObs3esFJqZnbOJryGAvBzQNUtBIVn43bscg8ONNwrND5WJIrq947hxNKccmwnrxJFpXutp7YUk8b/kSFQ/gEevDqOUtQhwirCjnW4NfTryd7bA16et8Wl2ZRdGPGG3mnZqtmDhl6T0gYw6OQwU485/CHx2w4lEjq21Fk/Rl2S7tlylOjvSuhfhaopZpaDbeQ1E7Q2282m1GlHU+TNVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(110136005)(6486002)(31696002)(316002)(8676002)(66556008)(2906002)(66476007)(66946007)(4326008)(38100700002)(6512007)(26005)(53546011)(83380400001)(31686004)(66574015)(2616005)(186003)(36756003)(6666004)(6506007)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1I3dEMyOERRY2JkVTVNSDFFTWdDcEhBWlVBWUgwYVZ1UzNkRXdNdXZBTDNL?=
 =?utf-8?B?YmVDWDFWZURlYUpmWGFuZU1takQvRU5uR0lyVkpxS1lHdEJzRVR6QXQ2VFZa?=
 =?utf-8?B?ZC9XV0JjMlRyUTNzNERmVEtwNmVybWNGQmhqWWdqcklaYjhVWkZoV28rM2Vo?=
 =?utf-8?B?cVRLdmFYRFg0UFZpSmc0MHFqSkY4UzBFakxvZUFkcDNMNzhNZ0o5VndPUnlt?=
 =?utf-8?B?V1BKRm5LRlkyMmc3ZDRVQzAvdVpJZmhqUnN5bll0TnhXRUxXaXNXVFROVGxV?=
 =?utf-8?B?Tml1YXlZWFpuU0pMTFRBdzd4dHFVU29MbVlQZjZvbFVYbjhIcDBzWjlpQ0Fx?=
 =?utf-8?B?c043RC93QzdGTDBpOU8zS3NxWElxVmoyR1dBK0VMNk9yN3E3WHVFTlZLNmRa?=
 =?utf-8?B?UEZ1Z2JWSVBuTHRaVE93SDN0ei93M21jRTIrek1ybjdGeWloUWRmSEZWY1ZD?=
 =?utf-8?B?NnRxc2ppWjNWYlJ5SGJ2aWRONDBVR0VnVUMxTFlucnFOSnM4U1phQ0x5R1F1?=
 =?utf-8?B?QWptemRreW5WcmZ6cUE4MEV2UUMrODNRSGNuSFI2Z3NMNHd1NitYRVd2QXBJ?=
 =?utf-8?B?ZWFDbVR5Rk1mdnRMdGpRWlBtQU9yMTR4WStuK25HeXBsazBKMUhGSkdpbEdK?=
 =?utf-8?B?UHdGbGlZWjE3ZmlYbnJuNmlWcTZsU3JNM2hIcGtxRGR0dmc1blBuOGVQMVhG?=
 =?utf-8?B?VDc5NGVnOStGTUV3MktRbEVJV3BBbUVzOHd6SnVKNVdnbXBzUTM5Z0JGTWww?=
 =?utf-8?B?VWxSQkZBM0VPZXZyenE5UStabUtTalFsSlFNd3k4YjE0L3BPZzZ3dmFtb3pI?=
 =?utf-8?B?VS8rQmtBVlZScDZkUndaUy9qcjYzaWkxR2hTMkFGNzhNQjQ1VnJ2MkdlU21l?=
 =?utf-8?B?Sks2RTZyeEhBK04wTG05c0xmcFJ2aWE0V25pT1RPQ0Z0YTAwdVo4MTl2TU0v?=
 =?utf-8?B?WHRxYXRXUjl5WG8zLzQxT052SnUveVF4Y01RM2JGTElZOGlxejJ0aDJuN09J?=
 =?utf-8?B?c3dMaDJsWnJUYVgrTWloV0g3eHZWd25JbkFERlphRG9iTnFRaGxjU0ZRd1lp?=
 =?utf-8?B?a3NDcnpiaXdOSmxONXFDVVBKM1JKL21WZ3R5L3lHWGdpbVVqeXFoUEhmWE9v?=
 =?utf-8?B?dDJDTCt2TG9YTG5KS2grcUZpbmh5aEtXbGtacU1DaTY3b3llRTRnUXFRNUFk?=
 =?utf-8?B?ZEVtQmI0TEtpTkNpaHdiVERaL1B5TTFkZDBkQU92MWtOM3dXVG9RRisrb1k0?=
 =?utf-8?B?L3hkZHdLNkt6WENKdTBSNkNYNnI5aXJvaFJxSEJvcnFGeHZBUTVFN3FsdFd4?=
 =?utf-8?B?c3VqNzVNVmtNZXo3OFlnQ1RrejJJN1RDT0VPS1QrYUo5aDdkOTZVZExVc2hI?=
 =?utf-8?B?Y04vZTN4UkhpRW5PYm9tWmpLYjJLeG80ZGNtdzJ4ZHFBaXF1SG83djZya0pj?=
 =?utf-8?B?UHkvbml1YkwrNEVVSGFOLzgzQ1FlR3ZRanZMRGxHS1Rudm5kMG01OU9wWUVO?=
 =?utf-8?B?Vy80RmxKVXEvWG5HeGFDSGRsVkZvRWtBVTdQOG9aMDdUS2U5emxXNW1wTGNX?=
 =?utf-8?B?OXdpcUVwRkVCSjZ2ZjZGN01KZ1RTOVpuOVhGaWdOZmI5NmI0QnRUdGlpbTc4?=
 =?utf-8?B?aThRV1h0RC9rTkJCcVFsdnM4dmpWQyt0S0ptb2hqY3hWQ3prMzhkUnZWMlo4?=
 =?utf-8?B?ei9yMHBWdDlaOFNCVXQ2YVA4RSs0YVRXTEpHRytwZVJoeERndFkwOEp3aFlH?=
 =?utf-8?B?L1ZOWmxXT2pzZmVKeUF4NTBqWnowbE9xL3lsc1pmQXZodDI1NXdJOHNua0tC?=
 =?utf-8?B?QWFvaGNGYkZHVEhOb203SnF6b0tLYldjRzU2KzJZV0FBMThWN2V3RkdpNmE4?=
 =?utf-8?B?R3pOM05IUDhadXlFaUdEd3h1dzJiS1dSbHpJbzZiQ3ViOG5VVXVzM0FTZkk1?=
 =?utf-8?Q?aGuDhlDjV2G4yWOcwQsFvKZ/8dfTni1K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071ad53f-2683-4bed-4ae9-08da0c799673
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 03:02:38.4498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/VmeFhCrPPHKMJLj1s3F3ICC/sNtob9qoZb0Imi+jDNmydZV8Ip08XjBskel1Zj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2511
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
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/22/2022 9:33 PM, Christian König wrote:
> Am 22.03.22 um 13:53 schrieb Ma Jun:
>> Correct the parameter name of amdgpu_ring_init() in header file.
> 
> Maybe write "Sync up header and implementation to use the same parameter 
> names", otherwise somebody could think that this is a real functional 
> bug fix and backport it.
> ok, will fix this in v2

Regards,
Ma Jun
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> 
> With the commit message and subject adjusted the patch is Reviewed-by: 
> Christian König <christian.koenig@amd.com>
> 
>> Change-Id: I202d76ba04b137926b456b1c8a4c05a5b1a01bff
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 5320bb0883d8..317d80209e95 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -300,8 +300,8 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>>   void amdgpu_ring_commit(struct amdgpu_ring *ring);
>>   void amdgpu_ring_undo(struct amdgpu_ring *ring);
>>   int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>> -		     unsigned int ring_size, struct amdgpu_irq_src *irq_src,
>> -		     unsigned int irq_type, unsigned int prio,
>> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
>> +		     unsigned int irq_type, unsigned int hw_prio,
>>   		     atomic_t *sched_score);
>>   void amdgpu_ring_fini(struct amdgpu_ring *ring);
>>   void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
> 

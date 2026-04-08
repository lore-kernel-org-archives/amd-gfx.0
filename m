Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480011073CA8
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 12:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD05110E631;
	Wed,  8 Apr 2026 12:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AyWtk86U";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E54B10E631
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 12:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v56ICkTkNtzONF88rupNHhMqwbynTK4uPPbM1uS6bdoZuTh2S3ep+dD0Z7B8ule/qyKSx6TUpZ2wqkmy9kxz+q8MQzgf1UgGWhAF6u20W9rIEemcH9Iteraxi4WhAnF2m63LGFrHKdGKq+GG7JkZ0RaP+t2V4JKX5SKEjSwcUREtsPLZj5bXuWD6Nn2AppRrfql2iXHVBVQBTUDd34sQVM3hbwNvWnvcn5lAKhYhBr0BNf+aPijYknU2PFMdtcntHTODCuZnKv09+eD9qUFYuxtXxzrgZuggru2Mr+9razMUpHnR/YtPrKsBQUpx0rsNd/JkajPDoUDqLWjuV7BkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnEDewpD47zXBmKh1Ymht3cNTQImFqSYL8WXVIO2CVM=;
 b=vlWybrry85zDxdHwjMtJBP0h7CsF/bO12NJyJfd5ZRrRu0efUmn/PHmKJxSPtHH0Tlx+JAjY8boYAa+A8RkDuFcjxlgPRGo1Y/hGzCduBiA73QhFjJzT3o7bywIv1ozutTrxtIq4f4GPeWNqDvKT17Q99rskSNBM/MDUEw6ypNcRbzj/7QGUjQIPG8eGlbjdVD2SBmJrJrDGuYlRuh34LzL7ctIcMXUCbhyUamIj878qN77l6cthK9SzXhhtTv0Zrhvqx6lw4rmVX7YV0hrrHgp8Jf9n780I9jgNhOHkIaVJSUcgPKA/3Dor9Pz3yJDgafv31vXHhqYWpdBHQEqqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnEDewpD47zXBmKh1Ymht3cNTQImFqSYL8WXVIO2CVM=;
 b=AyWtk86UrjUBcnW3acC14IaY9vkNIgJlCTHS+AyQjOf9QJ+QHFrBruFP5G2RWtYbfSw/lJzhOPOHJFQXGOuPuyiQH+Ca8cycTQDzCFvcFCBwQaqGVvvQ5xoqD+U+QtUvWO+kjwrmlDlfHpFOnEtt0DJ646hYY8m4cUrNNLRdJ18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bda) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:38:33 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.015; Wed, 8 Apr 2026
 12:38:33 +0000
Message-ID: <64e17b2a-e2d2-4d9a-8179-827886ac918f@amd.com>
Date: Wed, 8 Apr 2026 18:08:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu/userq: move comment to definition for
 amdgpu_userq_ensure_ev_fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260408094254.3535048-1-sunil.khatri@amd.com>
 <7bddfdd2-8a7d-4f56-99b7-a491113e3836@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <7bddfdd2-8a7d-4f56-99b7-a491113e3836@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0181.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1be158-f8b9-472a-2a5f-08de956bbf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: XxKeZY2AIamzSclvtfxkg2ODBpFSpi+XkZjMm3qL3oo+NuS6upEhVWlq13My9PfVxTcuWyQeyx5/7tiSRdmiNpNtRMeUMxga2X45MC8IWgldW4SJ9UpBvEJ8L1VQtGwLlpFULNi97tw91acXnBNqcNE2lRM7/nu44rEpIgW0Qhsc693sXCfLTF+sWyEFzwN+qWIrKsvw1rM4J+0yQ0X34D0Wif271ruxQC/ECHM0U64B8WlvUTs1YVC9hp7HgcFIUx8MDbfyi7Ubfr9kZSseQk38bim1gha591ZeIZU1IeH5mnfN758vmS+xR/HJUUil3fsqwReX9dXNAAMYBT4p+PoJnZzkP9SyAAagFj6jlO470aBd+ler9XbNECOGyXfex8B8n/zI2LYlPmj09rsbDOyEhT/ZBPwbqzJnHjrZT1dTtNsie4aacnD7fcabmkZwV1Va5evNtGPxJ15cH+saZwMjh7CH2U4VNsSveNgqRy5X9TWkzU37PAQl2kmtCW9csM7ke+18EFu1nrGJJQEdVk8VT6uZptl3z1lss/9MYYT7kWrEODOvCYVJUrvP6en5AJRLvcVBu1D2syRnVANUuYiqQwbf7jhp8lm60+Et3f0fjrTOh92wgFHLHCM/NL0GLZjjBfNFG5uYd/JKbzY2JNEMT3QPqcexTjKfr4Z/9SAgebQp7IUt2CJNIGHuMdhiRfahvjbKlhdlq+NV7lfbm1i/jGUM8iTktkKThOxClo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGQyN2MzR2g5QVBwdDNxK2RiTm5KNjJWWkFoRmZyb2xHWkMxeFZtMGUwSzls?=
 =?utf-8?B?MnhtdjQ5d0hLQURPTTYxWnRkM1BlbHdIOEM1ZUhtaVhDbURubjB5bDRSeGd1?=
 =?utf-8?B?VEh6bVdHR2EweVlqMmROdXJiVE4yanF5TElaTTBEWHErYkxYTU1vbWl6SVhP?=
 =?utf-8?B?QlBmaWRLRUFFeXgrNDN4cTljZ0RZS29iOFVnSTFzYnBOb0l6d01KMXg0VUVC?=
 =?utf-8?B?S1lVQ1p3c1ZFdXFOTEQwaW5ENVZaTjZMckRUcEMySTlQZ253aVV6bXdkcGs2?=
 =?utf-8?B?QzN0TVdUSkl3NDR4cGwxSG1NNkZmQkhCY1VMK3hUTkdqaHowazdLeE8xMEhv?=
 =?utf-8?B?TGJXenIxcVBwMXVZd0lxK3l1MHlJRVoyRmluK1dINHpnTVZLZFZDVHc4cmhN?=
 =?utf-8?B?UzRlTnBwUzNhbWxVVlJoYVpHVjZnOUk0V2x0UUt0UG1FRm5DSGZFUmk1WjhJ?=
 =?utf-8?B?VTJzdGhvdHk1b0JObkxidUNMRFk0RWs3QnE3Y3d0OTFhM2dwWURyRzJwRjkx?=
 =?utf-8?B?L0YwcWVXTTc4KzNjYmdXU2orQXplcTZUY3QrZWdpVVUvVXZSQzFLeGxIRlZh?=
 =?utf-8?B?RjhDbTNTWThSaUVnNGdvbjUzMlEwK0RPUURZUkg2TmJ3MzVFMU5kNUgvR0Yv?=
 =?utf-8?B?SitFcVhKaGhuRHhRbzhOYXpaUVM2K0JpME90S3ozaEs1R2wydnprbUc1OXJV?=
 =?utf-8?B?WHZpU3BCTTJBQTZxcjZ5bWNaUVFXZERXR253TDJPN01aSngxcmx1RktJV3ds?=
 =?utf-8?B?MEdBcHVMSGU5OXJxbStGQm04a1pOeE5BOWNGd09ua0J5Wi9CQm5YaGhkQnNL?=
 =?utf-8?B?KzVYLzZqSXp3VEpnQUdTcTJCdFNxV3QyVysvZGhoYU5WV1IzelJQcjhGMWZC?=
 =?utf-8?B?bGJTcHNYZ0JsUHpDWnJpZ2k3bUYwemw0NmUrc016Mzc1RFMxVTEzOElINi9n?=
 =?utf-8?B?SVZPblBvcEhlL2ZjTCszbmxmWDY3NHp5aDNLRWRxaFFJY3hSelJDUVY0OEVv?=
 =?utf-8?B?OTFCVEovUnVWdmVBQjJ2VFZJL3k0VmQvSjExOC8xZkRoelRKR3U2RkpPYnJZ?=
 =?utf-8?B?UHRGUzMydGlrakM3aUc2UGN0aTBUSkcwYjFYSThBcjhXZE1IZWRqZkVNb3Zo?=
 =?utf-8?B?MEJCcHNLMk9KSkZWMjc2dHBJbVFCZVU0QkVJZnNTbzN3dm5heHpaN2lpTEVM?=
 =?utf-8?B?Rm13a0l6eGdSek1KNHRUdzFLWWF5bndhNE0yYmV2RktycjVxVW5jSCtXVndS?=
 =?utf-8?B?TU5ZSEY3RlZ3S2JvTS83RC81c0NzcElhemVxcjNRL0pidGZUVkZwVHFQc3Iz?=
 =?utf-8?B?UzJaSWJTUmVsTTRlTWoxZjh5L3hGaVl0dFRQd1R1RlhjTm5RNkk0REFpT0Nq?=
 =?utf-8?B?Zlo4TnZPT012NFFFRXdMY3FFUUI1VWxZQXh5cEVzVzdoMnMvYnBtVktxWE1R?=
 =?utf-8?B?cFJEQzgxM3VFUWZMSjBWWjRSUU0wVncvdmxWZzBtYVdiNzBGN3dRZ1pGYkhj?=
 =?utf-8?B?Uy9HNTB0cFhBOVJmK0dOY09JMVNzbXlZeVFRSnpQVkU3SXNzU2xFVlp1Snpj?=
 =?utf-8?B?Mktqc0dUd2hqZmZwU1JkRFBzWitlMTJRTnVmWjU5b2tibnVWRDJ3Mzg3OTQ3?=
 =?utf-8?B?a3I2bnlwT0tKL2VhSzFaallJM2NhR1RiUXZTVXJuTEdzalRpckROZnJBMWcy?=
 =?utf-8?B?UTNSeGpxYno5QWJjczR4WHkyNGN1emUwanF0Z2dtWVl6QUhmSCs2Z2IyNEo4?=
 =?utf-8?B?SjRqbW9TSTh6Skg2QitCYktoSStFc1BTSi8wNHkzYVhNbU84Nkx5TloyNUE0?=
 =?utf-8?B?a0Vxa082NCsvbUhTcEROK3p4QTBhanRPWTQ0d1U4NUNTV1o4R3RGZ0lqV09G?=
 =?utf-8?B?SlRSVGROQ08zRk1LVVdGOHplS0ZnNzZHV1c0L1ZFQkF3dy9pUVF6VDdKZ2JT?=
 =?utf-8?B?V3M3SGZlTyt1bjZYSnJuTkcvQmQ3ckIxVzY1T1MwYzVPUElFSTlyNjM2TjRh?=
 =?utf-8?B?MVlSdnhyY3Z4VjRXRmZNU3A0VFlzV1BSV3JESzlzUkd4WHk4dVFGN0F3Y2hW?=
 =?utf-8?B?T1drczIyWXJYa3ZnQzNTZkxWMFV3anhaa3p5aUdMZnJGZ0NONmR5YjllWU9m?=
 =?utf-8?B?bXpWcXNRK2d4S2FYYXFndlExWGdLdXZjZWptZTVTQ0ZQckIwcFd3RHNsbE9H?=
 =?utf-8?B?aUN4bHl0WlhVVzZxV0dNYWVscW45ZHJIclYwc0ttV0RvVGhKT3Y1bkhFZm9s?=
 =?utf-8?B?aEROQ285N051K3JFdUVvd3pNU3FKaExxL3J2Vm1GV0RFR2RzeEdldU02Sks3?=
 =?utf-8?B?d214bTNvZ2RoYnJ0NlErNzBDWVczRVBwQXdpWGkyWG8vM1MyamVKUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1be158-f8b9-472a-2a5f-08de956bbf24
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:38:33.5728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lkdpoe/jOdtJrZa0lJGahmXdxfByYyh4yD70C5s0Ec4l8+Th/ACYcaSNHoW8eAm+z0Whwsmx0vG8+wRt2jNJRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236
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


On 08-04-2026 05:43 pm, Christian König wrote:
>
> On 4/8/26 11:42, Sunil Khatri wrote:
>> Move the comment for the caller to the definition for
>> amdgpu_userq_ensure_ev_fence.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index ae973c611972..b921346faa99 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -460,6 +460,13 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>>   	up_read(&adev->reset_domain->sem);
>>   }
>>   
>> +/*
>> + * There could be a situation that we are creating a new queue while
>> + * the other queues under this UQ_mgr are suspended. So if there is any
>> + * resume work pending, wait for it to get done.
> This is actually not necessary here.
>
>> + *
>> + * This will also make sure we have a valid eviction fence ready to be used.
>> + */
> That's the important part, maybe even extend that a bit:
>
> /* This will make sure that we have a valid and not signaled eviction fence and user queues are ready to be used. */
>
> Then using kerneldoc format would be even better then just a comment.
Sure, will do that way.

Regards
Sunil khatri
>
> Thanks,
> Christian.
>
>>   void
>>   amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>>   			     struct amdgpu_eviction_fence_mgr *evf_mgr)
>> @@ -786,13 +793,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		goto clean_mapping;
>>   	}
>>   
>> -	/*
>> -	 * There could be a situation that we are creating a new queue while
>> -	 * the other queues under this UQ_mgr are suspended. So if there is any
>> -	 * resume work pending, wait for it to get done.
>> -	 *
>> -	 * This will also make sure we have a valid eviction fence ready to be used.
>> -	 */
>>   	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>   
>>   	r = uq_funcs->mqd_create(queue, &args->in);

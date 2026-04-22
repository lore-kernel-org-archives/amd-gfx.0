Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C905AF94CDB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 07:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EB011201B;
	Wed, 22 Apr 2026 07:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YbJUZD2p";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D81A112017
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 07:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIHSx5tiDIL94F3yYBr8HFfQ7OHf7ovYUczvRgjNo4IdXrxDYmWfeouz9lqLLdgmZ8pyDb8ExE+ie1DtYU7hFtB72CyboYxOw8jtDmg2ygfy5Ie++mcyMU6Jk5YXBNfCO0mxqHG4l5TmK/6WRCtGwGbeM6PFCMcUezcBJ+DC/+UZnBbexaMtLO6r0pPJjHBN2pWl7Z9GQ6Bce4lSaps4MhVelZuW2F/FV8wYWSofuWhm8l4l5rKJ7y/2b6WqSsrKaNEKSIi3uobuNNZrbSwNLj/hxtM4u4uDTciAd03XXJBSgGa8SRrVNOlqaM0hqjv9ZOZqvE3kzx/vzb2rpMFa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+tBTCh+U9f0scG3Me2ORPEObDDaKKE95dD4eKfy6pU=;
 b=vsMceOn3/bawVH1asKur+tb3TC3iD9Y/pxYKwKMtu/byQ1Fr68vYgHsc4qm4xRP+JuEKGqZSABSwLRgcUwUr0H6ZjT/uvdgOsjNpfstRvrdtgr5dX/h2cbclRyfzS0r27HwfLKTXuhxnqcjq2U3Wjpnazlu5YniqbOAZp2hfdQ8REF6MgiLNBJUY6cHKLccfR9BGRZkFe/qMBxQyL5oMcKsbtnA1WAci3HWllqeSl6XeDjko+7MrsQAPLps/hsPV/zkQ9VseiO9IczNB2Sb7bao8GvAgLpsTpz5aTHBcgoH6MIr/egmvy4dtGuUn5CytJByQDxYOTVJrf08LnsVBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+tBTCh+U9f0scG3Me2ORPEObDDaKKE95dD4eKfy6pU=;
 b=YbJUZD2p++6NDTuhkrojJwhwnWfcf2i099SITgCjWMmmQ2ia0xKMorlq536RdhsZG2wN6BA+llaBVnaGFYNnLwiGfNMqXhH8FWFod5SIePdsHpO1ouPSPk99IFZLLZgpn6zSznRHh+eOV+A2vAbw9s/z7wpp4BkQBIuBMaeHL9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 07:14:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 07:13:59 +0000
Message-ID: <e70355c6-778b-46d9-bf29-cbbb4adc9d0f@amd.com>
Date: Wed, 22 Apr 2026 09:13:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/amdgpu: remove deadlocks from
 amdgpu_userq_pre_reset
To: "Khatri, Sunil" <sukhatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-2-christian.koenig@amd.com>
 <e0761bb4-6cb5-40ec-b5f4-f57c6ef636e2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e0761bb4-6cb5-40ec-b5f4-f57c6ef636e2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f188d86-5802-4480-8608-08dea03eb973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|11006099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qklvn17yB5Wu67bXdZEKx4cQqqeKbuNGjDeDyPxAEt7zIGs/WyeOvr97NPf3rdy5utcAeKDNmTDOftNFiXHcHzCv9oQsMl0MzkUujq2+CYXBA2xzmrPvb4gEuzWZFOHzokBprYtItxJUiGfm8WkDqf05sT2IR8+ndsMTXJOk3XburzXvNBcaVOspxFM5rd9hizB2bg6xOmhGMeeUt2VKe0wnOypdeiVoW3ul/BeSK+2ez5txuqkO9QwUVp5Ot1dYCyHeVjqvkNAkafxCXLLl92SEszvNksSPf+csZyhYj+OdbDqzP93vL41OESoo43VDZ4+YY9taFlv478YzzfuIP6WTstFrNF6lL4/o0viEMxQgFewzC3ftYRE06DuFqk/2JFpQu2chqHzAE91Thp6wLKP+4/Hvr8Bm/5Y5uPJiRh5xh8vp9F+s7pVhMiwJZXqrnQHL3CINGghJajzFM3nU2mV7Kc8vuN1tlF3EbZ92UnugXsD1GRnbrWRye5TvZ+e4yA5ZA6SmQ7CiwaVjcZbmoGGCSVzfvm+Wmc6NOL/rqmalbshcxuvKgI4fxvPFoEwIesLBaqiWJG6aoalygp7jM8U598cdVklWpAWAiYKkllHjqihGqI6FMULCdMzhCtEaciMDH1OFq54hZSA/onthu2k/8Er9xD9TNN0EEBzcGUU1m03MIFgU+XdQu/ecmT3yUDe2jeHBToPgOgdtZQNqiN+mYUJmm6hS4N/mUq28yH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(11006099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0wyUndLc2c3STl4TFRXaTdGQXdQakR0TEVlNjFQUGhTTWxadCttSjFvN2VC?=
 =?utf-8?B?M0hSbHhOck9OV1Q0d0NTVVNnb01QUDhBa1g2VG82amZ5UDIyVTZ3eDU1d0JH?=
 =?utf-8?B?Vk83emlScTlkYkkwL3poRm0rbUFmenZwL091QTRCS0Q2bHB4M2Jmb0ZrT0Zx?=
 =?utf-8?B?c0NUK2hqdy81dXIrdDM1WDI0ZVA2WEk3RWNOWHBSZ2RhUEZLM3doZ2ZEUHV2?=
 =?utf-8?B?WE5JT2o2UzZlMWFwWm5keWF2eGZjQXdaU1ludUdSY0p6RHJadml2QmZEdWNE?=
 =?utf-8?B?ZDZpSUdaVURPeFlrU2hrQVIwNXJOZGNmNmdoWlhPM0NWOG1RNTRBTndOZ252?=
 =?utf-8?B?K25EWDB4bUNWQVlBa0tpb0ZkYWd0NmFwNWVIenpzQ0xEVXVPbThReDhETVJJ?=
 =?utf-8?B?ZWdGcTlEcjBlbnFZNVQ3c3Nwc2NXei9abHJwbG9acnV6emk1QUlKYnZ1cXow?=
 =?utf-8?B?UXJieUpLT3ZaZVdjTksvZE9wVllZSEhQS2c1MUp5bldzNFVDdWs0Tmlabm1r?=
 =?utf-8?B?dlhGcVdhelhUaSs3THVqcHdBSGF3N1h6Yyt6RW1yYXZ6MktNSWIyN3hMaGNT?=
 =?utf-8?B?Mk9hMWt0SWlyWGd0ZzhOdkN2L1hqaFFrcEMzZmsxZlFIZHZMaEJ5VDlqeUhl?=
 =?utf-8?B?Q0J4MVZQQzVLR0FScUJXa3B0ZEVFMUJYQWJsTUJXbWdyZzVTVE1pVDVxZHQr?=
 =?utf-8?B?VWlzdjBNZ0QwQ3dDZWo3TzNaZVVjOWNyRVRlSjdJK1k5VUJYQ2lCamRhUlo0?=
 =?utf-8?B?MDBtNmhiYmExTnZ1dUcvQis3OVpaTDNaY2w1UU9LNTUwN1FBQUZUOU1ZNk5O?=
 =?utf-8?B?R1N0bnZSekNzRVZMdkZPTnA3THpkdFFUTzlaNkRTbmR3V3hTbzF3ZkNmWEwr?=
 =?utf-8?B?RWdkYTdGSFNGQ3QzNmorNHNENTlKWTI5MG1oTkpxMzE0bTZLR1FuSVVjekU0?=
 =?utf-8?B?bi9JNU4vMFVFN3Z6OFJXQ1luT2xhMkdQVEdyOFBtRVlKa21UZzMrVkJORXhm?=
 =?utf-8?B?cGRwMldGOU1oYU5ia0xKK1NLekhKUGQzMGJ4RnRTQmRLVnhDRnc0T2NQVzQz?=
 =?utf-8?B?MkNSODhwYkdnWjZkYlBpT0l2S3c5VWtTQVdPNWNTSnJqdFNCRkZQOWZ0Q0w1?=
 =?utf-8?B?aHRSdENiOXVkeUY3WkNGaHRodytWYVR0TTNoeWZJY1Jwd0Q4UXBUdEQraC91?=
 =?utf-8?B?cUk1YzdhakRkZ1UzWGpBYzlOU0tSUnZrTnNqQ2FvUnd4ajVlWHk0TCtlVHAv?=
 =?utf-8?B?bXMwaERnZ1g1UDRkbGlVa3RMSWt2NnRhaC9FQ3dKbXRMKzRnbzVqU1N0SnlH?=
 =?utf-8?B?UWZNNXVtN2Z6U0VPU2tUODlrMlR6RDlpRW43TkhIQy95dDFmZkEyZ2xDVUov?=
 =?utf-8?B?cVZGRFlkN0N6dFNQWkkvZFkySEoyM2hML3V3bm5IcnJYV2ozajViTTljTUR6?=
 =?utf-8?B?d00rM2cxRU4wdlY5RHlEYlhHbTVUZS9acGZXZThYZHNCbnhSVXkwN1RHZVlC?=
 =?utf-8?B?ZFE4MThnaXVpdzRTb1V3K01taEtvRHdMTEsxU01IMDUvMjlxVllkTnpSOERx?=
 =?utf-8?B?RTkzVUh6VDVsdGNRZGRpZjhZMk11S0duQTNjaGp0SUNmcENkbk5ZTGJtZTFI?=
 =?utf-8?B?TGFVRVB2eURGM3VlNkhhS3JFb25Zb2hPdjVWUFFmalJCb0dENFhaN3E5RGlz?=
 =?utf-8?B?UzFNVExZZEZIUFp0c2RYZ1BEZTJacW8zU2V6Q1JzenliczNlZks3MUFKNnB4?=
 =?utf-8?B?aXp3VUFZSHZsOVd5UUZIVmw1dVJLeHZIL1QwcDJmMFB3Qk9jbEFkTkpFVHAz?=
 =?utf-8?B?TGtsdjNjTDkwbzkzTjNRUG83aFN5UWNmdnV6VERybS9URDlkSWlVc2d6Y3Br?=
 =?utf-8?B?UTg1TGJINWt1NkJkVmZieWpnN21TVk9DRzRjYU9FZlVhSThIdFNMZmV2SFRr?=
 =?utf-8?B?by9yRDdlN09ZeWVFM0JsbFkzS05ra0IwbTlKMUJNVnUvUjh0Y2dNVytld0tS?=
 =?utf-8?B?Zi95bUJZQW1FbzJCZjJVUjhmTlZQbGpKekQvRmROT3VydllPVGtIWVUzNWZn?=
 =?utf-8?B?SEFCUG1tRUV3V2cyVkJ1bkIxallmUlByK0FMaC9qV3FhcUpMZEtYcjVPNmc2?=
 =?utf-8?B?L1ozUytmeGVsQ2FQdmlUU0NxNGZjR2JpdUZHZUpVK1VuME5DYkVNamRIdXhW?=
 =?utf-8?B?K3psSmpqTmlaWFMvelVZUjdrT1ZrMWtIOHdwQkJreXE5QkdlVHlXQStzbXkr?=
 =?utf-8?B?bG1JaEVsMnhpNVEzem84ZUJzRG5LRDJacFBZaytzcE5ndmt5Q2NWZ0srNUZX?=
 =?utf-8?Q?N8nnJss+U2fxQ7Lb1H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f188d86-5802-4480-8608-08dea03eb973
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 07:13:59.6082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg+yfY9PmsBvfftiQoZoo0t9jpGz7qyp5u64RJzPrB7RpCmSkpyX8P+JfrcY+orn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
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

On 4/22/26 06:53, Khatri, Sunil wrote:
> On 21-04-2026 06:25 pm, Christian König wrote:
>> The purpose of a GPU reset is to make sure that fence can be signaled
>> again and the signal and resume workers can make progress again.
>>
>> So waiting for the resume worker or any fence in the GPU reset path is
>> just utterly nonsense.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++++------------
>>  1 file changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 8f48520cb822..b632bc3c952b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1496,23 +1496,21 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
>>  {
>>  	const struct amdgpu_userq_funcs *userq_funcs;
>>  	struct amdgpu_usermode_queue *queue;
>> -	struct amdgpu_userq_mgr *uqm;
>>  	unsigned long queue_id;
>>  
>> +	/* TODO: We probably need a new lock for the queue state */
>>  	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>> -		uqm = queue->userq_mgr;
>> -		cancel_delayed_work_sync(&uqm->resume_work);
>> -		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>> -			amdgpu_userq_wait_for_last_fence(queue);
>> -			userq_funcs = adev->userq_funcs[queue->queue_type];
>> -			userq_funcs->unmap(queue);
>> -			/* just mark all queues as hung at this point.
>> -			 * if unmap succeeds, we could map again
>> -			 * in amdgpu_userq_post_reset() if vram is not lost
>> -			 */
>> -			queue->state = AMDGPU_USERQ_STATE_HUNG;
>> -			amdgpu_userq_fence_driver_force_completion(queue);
>> -		}
>> +		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
>> +			continue;
> 
> If the queue is in prempt state and if at that time we are in this function we should still be doing force completion for work in those queue else the waiters will keep waiting.
> 
>> +
>> +		userq_funcs = adev->userq_funcs[queue->queue_type];
>> +		userq_funcs->unmap(queue);
> GPU is already hung if we are here and observation is we are unable to unmap as we have tried to reset via the fw and that failed to atleast thats what i have seen. Could we skip unmap ???
>> +		/* just mark all queues as hung at this point.
>> +		 * if unmap succeeds, we could map again
>> +		 * in amdgpu_userq_post_reset() if vram is not lost
>> +		 */
>> +		queue->state = AMDGPU_USERQ_STATE_HUNG;
>> +		amdgpu_userq_fence_driver_force_completion(queue);
> 
> we should be calling completion irrespective of queue state here. The GPU atleast the queue is hung and fw has failed to reset. We have to release the fences by foce completion.

Yeah, I agree completely with those require comments I has similar thoughts while going over this.

I'm only driven by bugs here and my goal with the patch was to remove the obvious deadlock in the function.

Somebody needs to sit down and go over the whole handling for GPU resets and make sure it plays nicely with user queues.

Regards,
Christian.

> 
> Regards
> Sunil Khatri
> 
>>  	}
>>  }
>>  


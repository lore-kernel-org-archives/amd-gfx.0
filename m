Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BEDF01827
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 11:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E88410ED0A;
	Fri,  6 Mar 2026 11:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BtdWud84";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C66A010ECF8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 11:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xo4T+4TAxmkAJiAkUQFtrSpOYf3B7jrPsRYmnEDhivVBNsK/n8kgmX5zuwKNTwvUc9NGV7YzFZ4H5hH4taTqy331SbuEtfF1Dk0dD72YdBLP5A2PpHsDmzziAqsM+bJgfDkpQvgh3JIzrOHKbxUGIborbQsBznv/7u3Vn6G0sqXlUmVjPeGCChsd9XUk+tcCNNh/U9Feu5OKdPryjCWUbXpJPWYBH7TzO8IVemFBoB/6LxppIwaAJyZUNVUwFyBqNWf2h9F1+HeEFi/PHp/BUCJkh+mMBcXuTZLhHywD3am5mqIdwsu0+6fGfpILho6iQzFCgG1ljkvKWIR3t84+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An42rLHZgd6kLPYztPppHh4aGTLEodlgvq8zp11C/pU=;
 b=NVijuwk/EPgk96zKnSV+0zE/HkyHqJMXWJktmG/OPgT/u6LgArYv9Uq3t+VZmfrcf106yT0+KClUvT+eLJTdID2gDBeqXPGL2xbpCUMxRoDXplS5eeG91UgCgRU8qHtBhII5oRbu/3a7QMbtj1bzjhCg+FaWKTMpxZa3VsavYQVS9dxcCJgWvqe4PLro9eC0yFE9wKYWxk9YSPU6lNBW5HgnoVvqkENnP46RHb7OXn6XyLMoVWvF4eLN/rXWhuFk4/lRlQ4FZXV80l778z1cMxxCLbqWTPeG6e7LCiUtC+xMFG9XVRyXpwnEpXiuIr7C18325A7aWphoHnmIFB3Pkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An42rLHZgd6kLPYztPppHh4aGTLEodlgvq8zp11C/pU=;
 b=BtdWud84Qmle1OxhdkLpK27u9wICdijj1Gw/UeDgrMdYEx5b/K7ePJxAYAecj8HAwqoT5SKuvXu6e5vvo0cMl2i1oMsp6QCbwSzHtng0FDeo8RVzwUa55FXmFE4z0HpuqFKEkJF2HQp/EGY03Z4fDrejlM3CE2EJ3DARYOfEjyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 11:14:16 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 11:14:16 +0000
Content-Type: multipart/alternative;
 boundary="------------ame121xe1K0wzCCk23aDGd36"
Message-ID: <4e9f1760-01b9-4378-8004-a16d9e933b0e@amd.com>
Date: Fri, 6 Mar 2026 16:44:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu/userq: declutter the code with goto
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260306101453.1940129-1-sunil.khatri@amd.com>
 <20260306101453.1940129-2-sunil.khatri@amd.com>
 <dcd6c950-3d04-42c3-a6f1-8d10a66dc635@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <dcd6c950-3d04-42c3-a6f1-8d10a66dc635@amd.com>
X-ClientProxiedBy: PN2PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::34) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: c47facee-9a08-4e2c-7dd2-08de7b7180d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: Okj6s8Q8LRDDhPAFfJqfmVlrMlcNQfEWQTwsBQKq+4dxOchkqTXPNtvR9zCuzJn/A3KZimuBVzhD2KNMfymj7KXYE44/ayykXNxfQH0U/BJyKXfyeGg/CDDEDaIntnWG1mbyCWLs2eTlF27S5tHK34kNQGOfX07Ww8Dr6iuN1vkDy0pkmjrIOuFxgmgHWwGsNJuW7OWiwR1C/TuQeSWQex47B5GZo6zee8dScgP8ybblSU6Rvz21P7PCrMQyTHlmN80Slgy/yikhf2+wsyGJ2FBG/T3IvTUF7y3+tBlT2j66t7WnLFow+nkTTKXdAFgkeidHm6ibkEqA4d5AcD91wh/dQDwbgn5oehFXChPftx3ixj+Kbdp7+Mc4hlbK+nQo+pEDQ/QdM6h1t7ojuwt+WsCXl2iEADVWeX7UT0wwgbIYd2821iZgftW1mJoffbvm8EkFID1H2C6+Yb/O1hcMRR8MfrSOq3hodHAkOveIyeks1HqxrGYxLpDi0aVVh5veZvzRUcbprquWcqld0ztucVeuhD5PqGd6agZkNMKEaytkAZTdu+bcwbeBH5lg/TvdRPKr7Eyy+gYF3v7vcKw0koy9pUjHC5g9+Z0gHyAL+F/iK82nXM4ivA9dZrgPpjVZ7gKCRGDDGNdrtMKjzURUkZTMA+0AYvznrb2tZ6hKX0ZWaI/MXg8nkzhWbBwnVzv752E450Yb/j0IvAv8FaGFmh63dfWgsqhcNTAYHN5RnEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmw4UXpLWjhuV3YyL2xJZC81VWtGb2FBRHc0L0paNmJqQzhJSGZkaVF2VlJZ?=
 =?utf-8?B?ak0xSDZKR3p5ejVIeWw1S1FGN1Z0VDhBRXdNcWxLWG9ZMEZlQ1RQWkdKUHFq?=
 =?utf-8?B?eDNyc2R1QklBTXgvcFZLS29ZZmJCUVRyVHBpSWdvTmQvNW5VMVdFQ1dack1i?=
 =?utf-8?B?M2JnZ1hoWUNKemRwVWdmQVp0R2VURkkrTnNjQVZjaWxyOUQxRklCK2V4QUJo?=
 =?utf-8?B?cDRSdU9vUXVFQlNCTWo2bkY1QXd6VDh0bFgremhOc0lPc29LZ1JxY252QSs1?=
 =?utf-8?B?U1E5eDNmYUdTSkpZWVNOWS8wZzJ6aEhmYVhGSkl3TTlMaXhObEpneEZiaTdT?=
 =?utf-8?B?MmNvUkhUazZSRzJpSVZCRmNRTGNHM2JyVFZQUE9BMHZCaXlUa2FxWWhwekFo?=
 =?utf-8?B?b29Ia2JXajI5SG1RVkg1amJ4RGJIcFFLSURTbkU2VU1hUHBER2lFSWhDbmlQ?=
 =?utf-8?B?Uk96NHFOdTNUNjI2WFJZMzJDMzV2Yzd6dXZLbEVQSkh0KzNwN1huaUUzSFpT?=
 =?utf-8?B?STBMd21HU3o3SEkxZUx0Sk04cEkyUlZpTUplRDZySUFjNmNtM1JUa3Bpd3RD?=
 =?utf-8?B?Q2x6dkxPeUJ3eEVTTGEyeGdvZzJzeUFkVkVGbjJ3Y1A3Y2hQU1NRakNNdHoy?=
 =?utf-8?B?NWtQeGlJRk1NY1lRNFhVWHFSaTRPNjFUT20xTVQ5T2Ixa1B5RzYxL2NqelRI?=
 =?utf-8?B?Q1MxVm5FbGdJUXVXdDNEc29URStqL2hCNHR3UFRYL3I2ZXNqMnNmQUYzRDJn?=
 =?utf-8?B?VWJ5bEordHBUK2dqQzhSdC8yR2F4cUVCTzNYdnBESTkvc3VkOGpzNm04SGN0?=
 =?utf-8?B?SVVQQkVEQUg3THJuOTAwQkQ1NW9sN3N5am5qQkFjd2NGSks3M1BKN3ZxaHdV?=
 =?utf-8?B?SEtxcEZYaE5UcTRKL0s4clRwTVVnRG9EUnlMTVVGSmhQMEdvRTdTSEV4YjZP?=
 =?utf-8?B?WHpuVGc4c2lLRWR4cHAzNDg4UEVEREx1ZmowSDZOZjlsT0I2bFFidWNXeklN?=
 =?utf-8?B?a0Z3dXNiOCtCZmpmTG1pOWN3NkV3TjNQbHZCU0o4VUZ6T1J6aUVZQ2R4YnBm?=
 =?utf-8?B?ZGU5aHl4emNQVVY1ZmJJZFNzTDZoSjZNNklOY3JHdFBVQ0lkeGNxVTRVTUE0?=
 =?utf-8?B?elU4YVI3c1MvdWkycUJWcWpNQ3lLVlZyUHpSUjdTbTdhR05RalFlSFMveFpo?=
 =?utf-8?B?SjFpVGQ4UUNnV1A0akpWMXFWOUhMQXBLaGxoajZQV1FlTDYrL0NZZ3NYSnQw?=
 =?utf-8?B?WVp5M1ZtcDgzcEFjVkdQb2VGTkZWallLRjVjOVZUZmgxVGxwa1hoTU1TV0R1?=
 =?utf-8?B?dGVjZVhYU1JnS1Z6RFlDaTk3a0p4UjJMWTQxK0lvNFZlV1pYOGl5T1JEYnJt?=
 =?utf-8?B?YzlkaWROTVprMjViWWU5dENUdUV4YjhkZ0dVeCt2UjdkMHllNzl6T3VxSHY1?=
 =?utf-8?B?ZXcvZ1MyQytLK0NQbEJSQjRqeWV4N2dqd28zS1gvY0MyZXNVckRjb1Y4UkVn?=
 =?utf-8?B?dnVUandHR2JOL2JVek93MUxOTVRlZTltcGo2SXdQYzdTRjdVdDR1clR4VlJk?=
 =?utf-8?B?OUFESm1ic3JPU0QxckpCUXpRbXZUd280WUo3ZjRNek1TalVGa1hCTzhHMHY0?=
 =?utf-8?B?VzlpNUdvWEVZRXlkYzJiWnVJRlZtVHZHSUN0bFNraDdjYVY5ZGhUaFJiOE55?=
 =?utf-8?B?UXBMaFpMdmxWZUJBUXdIQVJmZTFJN1c5ZUJZRzBvUyszR2J4bXJLZkViOUpP?=
 =?utf-8?B?ME4yUjBITnRNTFpocEFrMGdSby9PTmtWSW9GdjNWTk5oQWtkNDdDSkJNcnFW?=
 =?utf-8?B?SjZmYk9UYjluYWp5RE5sQUpaZFhZOUhDbjM4V1dZY1lxOGxDTjFYVnc5Z1Ro?=
 =?utf-8?B?dkVJNE1STEhUVXpRN3ZiTDNhWWtpbmVPR3hNVTZPV1VySlpVZmZ5N2UrOHhF?=
 =?utf-8?B?QVpiNm1XVzY0aDBkUU9qajI1V2Zxc2I5bzRDdzgrQkNYRnVjTmJNVW0vWEYy?=
 =?utf-8?B?QVdKdlVyU2lmRmx5M3I3Y3djR1pIZ0pIU1hjL2FrWGVFTHB4UllFZHJSK0Fl?=
 =?utf-8?B?NlpkYWxQS3J2SHJrczNva2NrSktlbThTUVFOR21peEtqanZHMTg3YmtZejRB?=
 =?utf-8?B?SWZJVzl5QWd2WGQ5RitHNjFqTmYwU3FmUkp4MWRhZUIzS1ZZRlNRYUZDL25i?=
 =?utf-8?B?VDV3OC9nc0RGRjAxc2tqQUhXVVYvOW80STlQdWYzZllkaW5VKzFQeHc2RTZ2?=
 =?utf-8?B?VG1wakY4d01ZdnprWUhMQjRTcGxwVGphU0lzMGg2dVJzYXdmelhwYVZ6RDlk?=
 =?utf-8?B?WU5YTkVsNnpZTGRUaHUwOXQ4V0RtRjEwVUlGMkFSZCszbUVuWklEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47facee-9a08-4e2c-7dd2-08de7b7180d8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 11:14:15.9932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdexsL8e7bAF4d1lGolRIZL1K1tfHQ7u3yVvUwMo93adtgEDyjLkfVLwDjI+taCiba3BW4i1Fw8Xq3JnCAKHeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218
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

--------------ame121xe1K0wzCCk23aDGd36
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 06-03-2026 04:37 pm, Christian König wrote:
> On 3/6/26 11:14, Sunil Khatri wrote:
>> Clean up the amdgpu_userq_create function clean up in
>> failure condition using goto method. This avoid replication
>> of cleanup for every failure conditon.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 45 ++++++++++-------------
>>   1 file changed, 20 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index a614b01b7eab..aef9b5855812 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -758,7 +758,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	const struct amdgpu_userq_funcs *uq_funcs;
>>   	struct amdgpu_usermode_queue *queue;
>>   	struct amdgpu_db_info db_info;
>> -	bool skip_map_queue;
>> +	bool skip_map_queue = false, sem_held = false;
> Please don't put lock status into a local variable, that is usually a really bad idea.
Noted, that i was made to call due to mqd_destroy not being calling with 
sem.
>
>>   	u32 qid;
>>   	uint64_t index;
>>   	int r = 0;
>> @@ -818,17 +818,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
>>   	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
>>   		r = -EINVAL;
>> -		kfree(queue);
>> -		goto unlock;
>> +		goto free_queue;
>>   	}
>>   
>>   	/* Convert relative doorbell offset into absolute doorbell index */
>>   	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
>>   	if (index == (uint64_t)-EINVAL) {
>>   		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
>> -		kfree(queue);
>>   		r = -EINVAL;
>> -		goto unlock;
>> +		goto free_queue;
>>   	}
>>   
>>   	queue->doorbell_index = index;
>> @@ -836,15 +834,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	r = amdgpu_userq_fence_driver_alloc(adev, queue);
>>   	if (r) {
>>   		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
>> -		goto unlock;
>> +		goto free_queue;
>>   	}
>>   
>>   	r = uq_funcs->mqd_create(queue, &args->in);
>>   	if (r) {
>>   		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
>> -		amdgpu_userq_fence_driver_free(queue);
>> -		kfree(queue);
>> -		goto unlock;
>> +		goto clean_fence_driver;
>>   	}
>>   
>>   	/* don't map the queue if scheduling is halted */
>> @@ -852,16 +848,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>>   	     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)))
>>   		skip_map_queue = true;
>> -	else
>> -		skip_map_queue = false;
>> +
>>   	if (!skip_map_queue) {
>>   		r = amdgpu_userq_map_helper(queue);
>>   		if (r) {
>>   			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>> -			uq_funcs->mqd_destroy(queue);
>> -			amdgpu_userq_fence_driver_free(queue);
>> -			kfree(queue);
>> -			goto unlock;
>> +			goto clean_mqd;
>>   		}
>>   	}
>>   
>> @@ -870,18 +862,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   
>>   	/* Wait for mode-1 reset to complete */
>>   	down_read(&adev->reset_domain->sem);
>> +	sem_held = true;
>>   	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
>>   		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
>>   	if (r) {
>>   		if (!skip_map_queue)
>>   			amdgpu_userq_unmap_helper(queue);
>>   
>> -		uq_funcs->mqd_destroy(queue);
>> -		amdgpu_userq_fence_driver_free(queue);
>> -		kfree(queue);
>>   		r = -ENOMEM;
>> -		up_read(&adev->reset_domain->sem);
>> -		goto unlock;
>> +		goto clean_mqd;
>>   	}
>>   
>>   	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
>> @@ -890,11 +879,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		if (!skip_map_queue)
>>   			amdgpu_userq_unmap_helper(queue);
>>   
>> -		uq_funcs->mqd_destroy(queue);
>> -		amdgpu_userq_fence_driver_free(queue);
>> -		kfree(queue);
>> -		up_read(&adev->reset_domain->sem);
>> -		goto unlock;
>> +		goto clean_mqd;
>>   	}
>>   	up_read(&adev->reset_domain->sem);
>>   
>> @@ -910,7 +895,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   
>>   	args->out.queue_id = qid;
>>   	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
>> +	mutex_unlock(&uq_mgr->userq_mutex);
>> +	return 0;
>>   
>> +clean_mqd:
>> +	uq_funcs->mqd_destroy(queue);
>> +	if (sem_held)
>> +		up_read(&adev->reset_domain->sem);
> To be able to savely call uq_funcs->mqd_destroy() we must hold adev->reset_domain->sem.

I see, but is it only for the mqd_destroy the reset_domain->sem needs to 
be held or for other mqd functions like create too ?

Regards
Sunil khatri

>
> So when that is somehow called without holding that then we have a bug here.
>
> Regards,
> Christian.
>
>> +clean_fence_driver:
>> +	amdgpu_userq_fence_driver_free(queue);
>> +free_queue:
>> +	kfree(queue);
>>   unlock:
>>   	mutex_unlock(&uq_mgr->userq_mutex);
>>   
--------------ame121xe1K0wzCCk23aDGd36
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 06-03-2026 04:37 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:dcd6c950-3d04-42c3-a6f1-8d10a66dc635@amd.com">
      <pre wrap="" class="moz-quote-pre">On 3/6/26 11:14, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Clean up the amdgpu_userq_create function clean up in
failure condition using goto method. This avoid replication
of cleanup for every failure conditon.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 45 ++++++++++-------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a614b01b7eab..aef9b5855812 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -758,7 +758,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_db_info db_info;
-	bool skip_map_queue;
+	bool skip_map_queue = false, sem_held = false;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please don't put lock status into a local variable, that is usually a really bad idea.</pre>
    </blockquote>
    Noted, that i was made to call due to mqd_destroy not being calling
    with sem.
    <blockquote type="cite" cite="mid:dcd6c950-3d04-42c3-a6f1-8d10a66dc635@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	u32 qid;
 	uint64_t index;
 	int r = 0;
@@ -818,17 +818,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	    amdgpu_userq_input_va_validate(adev, queue, args-&gt;in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
 	    amdgpu_userq_input_va_validate(adev, queue, args-&gt;in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
 		r = -EINVAL;
-		kfree(queue);
-		goto unlock;
+		goto free_queue;
 	}
 
 	/* Convert relative doorbell offset into absolute doorbell index */
 	index = amdgpu_userq_get_doorbell_index(uq_mgr, &amp;db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
 		drm_file_err(uq_mgr-&gt;file, &quot;Failed to get doorbell for queue\n&quot;);
-		kfree(queue);
 		r = -EINVAL;
-		goto unlock;
+		goto free_queue;
 	}
 
 	queue-&gt;doorbell_index = index;
@@ -836,15 +834,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		drm_file_err(uq_mgr-&gt;file, &quot;Failed to alloc fence driver\n&quot;);
-		goto unlock;
+		goto free_queue;
 	}
 
 	r = uq_funcs-&gt;mqd_create(queue, &amp;args-&gt;in);
 	if (r) {
 		drm_file_err(uq_mgr-&gt;file, &quot;Failed to create Queue\n&quot;);
-		amdgpu_userq_fence_driver_free(queue);
-		kfree(queue);
-		goto unlock;
+		goto clean_fence_driver;
 	}
 
 	/* don't map the queue if scheduling is halted */
@@ -852,16 +848,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	    ((queue-&gt;queue_type == AMDGPU_HW_IP_GFX) ||
 	     (queue-&gt;queue_type == AMDGPU_HW_IP_COMPUTE)))
 		skip_map_queue = true;
-	else
-		skip_map_queue = false;
+
 	if (!skip_map_queue) {
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr-&gt;file, &quot;Failed to map Queue\n&quot;);
-			uq_funcs-&gt;mqd_destroy(queue);
-			amdgpu_userq_fence_driver_free(queue);
-			kfree(queue);
-			goto unlock;
+			goto clean_mqd;
 		}
 	}
 
@@ -870,18 +862,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	/* Wait for mode-1 reset to complete */
 	down_read(&amp;adev-&gt;reset_domain-&gt;sem);
+	sem_held = true;
 	r = xa_alloc(&amp;uq_mgr-&gt;userq_xa, &amp;qid, queue,
 		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
 	if (r) {
 		if (!skip_map_queue)
 			amdgpu_userq_unmap_helper(queue);
 
-		uq_funcs-&gt;mqd_destroy(queue);
-		amdgpu_userq_fence_driver_free(queue);
-		kfree(queue);
 		r = -ENOMEM;
-		up_read(&amp;adev-&gt;reset_domain-&gt;sem);
-		goto unlock;
+		goto clean_mqd;
 	}
 
 	r = xa_err(xa_store_irq(&amp;adev-&gt;userq_doorbell_xa, index, queue, GFP_KERNEL));
@@ -890,11 +879,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		if (!skip_map_queue)
 			amdgpu_userq_unmap_helper(queue);
 
-		uq_funcs-&gt;mqd_destroy(queue);
-		amdgpu_userq_fence_driver_free(queue);
-		kfree(queue);
-		up_read(&amp;adev-&gt;reset_domain-&gt;sem);
-		goto unlock;
+		goto clean_mqd;
 	}
 	up_read(&amp;adev-&gt;reset_domain-&gt;sem);
 
@@ -910,7 +895,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	args-&gt;out.queue_id = qid;
 	atomic_inc(&amp;uq_mgr-&gt;userq_count[queue-&gt;queue_type]);
+	mutex_unlock(&amp;uq_mgr-&gt;userq_mutex);
+	return 0;
 
+clean_mqd:
+	uq_funcs-&gt;mqd_destroy(queue);
+	if (sem_held)
+		up_read(&amp;adev-&gt;reset_domain-&gt;sem);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
To be able to savely call uq_funcs-&gt;mqd_destroy() we must hold adev-&gt;reset_domain-&gt;sem.</pre>
    </blockquote>
    <p>I see, but is it only for the&nbsp;<span style="white-space: pre-wrap">mqd_destroy</span>
      the reset_domain-&gt;sem needs to be held or for other mqd
      functions like create too ?</p>
    <p>Regards<br>
      Sunil khatri</p>
    <blockquote type="cite" cite="mid:dcd6c950-3d04-42c3-a6f1-8d10a66dc635@amd.com">
      <pre wrap="" class="moz-quote-pre">

So when that is somehow called without holding that then we have a bug here.

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+clean_fence_driver:
+	amdgpu_userq_fence_driver_free(queue);
+free_queue:
+	kfree(queue);
 unlock:
 	mutex_unlock(&amp;uq_mgr-&gt;userq_mutex);
 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------ame121xe1K0wzCCk23aDGd36--

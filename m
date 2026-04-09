Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1510DEA3C4E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 12:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E3D310E7EA;
	Thu,  9 Apr 2026 12:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DodI77tS";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFCE110E7EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 12:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rExnR2Z2rKqJShM4KTqU1OO0zyOiLubvI7iBvDQFedmJR0N6EjC2IofiAZ0Q7cOCC9jsIQFrkV110iKtnlhqKAHfJlgAiUNbTrxpTiKE4E+TSuCJOJsUnvW80qMarUpfYzUK/WdZwDLiIL7gWUlkozytFANza47Xh8tOVuNqHRTpQTT0Upl83QI9doTXpl4X7Jn4H6ADXul769yuwAdeFKIOEMxqn7CAyC9Z8aWNUuo7jGGqlS7N/XnVBkXJ1EDKZ6VYXjV5/Mz9Jfu87XWLVqjvTU9b+Z0jiO0SI2SV/C4iQhMiLuXKEHBfwu6tz6QCsj/eurkWumS7Okch5QEP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIsBAOmZ88CYSluNfuB6v5yebdk2dIxfHZrpUMbmEzs=;
 b=kbVRhqVGXLEhY6oE8yP+60h3YrJD+ske4txU3pJAcsOOtS4e53QQHzjHFJpsi0rkE+Qeb04iUQR/dL8hAgdvLNpW6Q46wsyFyAI33M3plEJ8DX3qfA5XhgSjAxZNRa9AcET0xx11FQgdpX1I15g6+cDJ/v+ucmLsm/+TD08PB1FH+edCLoaLkdSGrzGKJxyp4EuPPIsU6i4nf7KRA3w2W/ddW4Zz+ZzHJRZDDeuA6GrLVUDM+tz/7upDBkCV2hUjoQlcdnOVSAF3Rvx4q9oaOAjIz6keB/iDHtuKGZK4KXt9MTFNktxklbZ11gUSe3Dau+YrKKGM7ugJ/FKghQpHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIsBAOmZ88CYSluNfuB6v5yebdk2dIxfHZrpUMbmEzs=;
 b=DodI77tSBEMuf/ONH+2a/yAsyPpWkZXhixcsY7o0+w1W7eNdVGxrbl4a/8e7jFVOnkU7sKESsr+VXxtMFs2n+KiHH/oIe9jk/IxPqSAEK+X08GzecL+gqD6jX8uzuMU8sWUiI8pQOYC0mUEg9rK2M3G6FSOLuDtPlztdqrPsB1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 12:46:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 12:46:06 +0000
Message-ID: <d0807359-52db-49f1-9ef9-86cd8d38b20f@amd.com>
Date: Thu, 9 Apr 2026 14:46:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] drm/amdgpu/userq: create_mqd does not need
 userq_mutex
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260409083355.1326089-1-sunil.khatri@amd.com>
 <20260409083355.1326089-3-sunil.khatri@amd.com>
 <016e66c4-0268-4b22-b285-b54f0c2f88ad@amd.com>
 <d64995bd-1cec-406b-975f-e14c633ce606@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d64995bd-1cec-406b-975f-e14c633ce606@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3e2386-4e70-4f2b-05bf-08de9635f7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: G5d5FpkfWWEOMKfQq9Fg5WByFgYsM85pLv9kPiVZW8mbVO2i/NdB7+Dr0P8GT9ZwO+Pl0uxRPDSHe9xE4ziVeijbky9z9eREqasiGRuiZtl7K9LOj0L0VBfK04nW3M76EOabOy97ilbygdIAQMLbAftia/vRl7sycvGhvFiG54i4ZRJ2mf8mk59s0NOdplR/bU8A9NNOjHuRdZclyzep/4u66EhI/uyd0MEZ2LzRYKvv3YJ9s83Mv9Z0O7hKctgXXi7Thul7SVEKotCz5UOxeRZJAbis6VLWuD16mQrpqxZwl1Y6OGwTGmpyQ0eJ8qykSyg+FUa3jkPR5OZCm1pEuwk6NnCAI3CxrSYKWO4Q4N8Vxjz6AsJlpSSbEExBU1XVrAjE5zh1QYQL+cHaTwDW5iGvniWYhLL+DJ7jVYYcM1ziLX7Z0c4xSSh5vDPPAc0vsEg3ETjJClzkjvzDhe6Ys1ajjsd6i2dx4A5/1afITy+bn5Xc3q7ZDE7ARKB/p/h9aLhq7EuRWNxe0FZvEZVAYO9LqypEVu5b7k+16H/zyAqneuAxfg7R6lAZb/xTFdFmlqMFHpdoFrmHxjpMpEqs0S/Z7U/easip5vuZkDGr73lnDHjOxINCEThS4cTwKyicczjWfzTsp7uzyfofEPA8O+TPKZGf6iT5lC+kwiikFldf74PRjbtHfYMkSI6nLc75X2kVTpUUfT4izcXcO0UqQRoQDn12JctBhdwC/i+JRcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3ByejNDR1FHRFdJbnZIMGMzeFFnOWwrSWtXa2xoRzJQWHZFYVZZdmtoMEpj?=
 =?utf-8?B?Sk8xcXl0ZDBJRXI5TE5zY2grN1VDcHJTTXd3M09rQ3l5ZC93VlM4RzBBYTZa?=
 =?utf-8?B?S2U5MlRmYkhJdXRpd2ZrcktzaFNMZU05TDFkMng0bjdwUkgvNkpIS3BMMVFQ?=
 =?utf-8?B?NUw5Y2IvYU0reUx1djd5RERuMnBZbGRTRjZSRy9HWTJUTWNCeHZyQm1BU3I0?=
 =?utf-8?B?a3J0M2Nja0lNZVBJdEhzZXRNU2FoTkRhWDJLbFRlUkx6eHZWMGpuVjJCNFFQ?=
 =?utf-8?B?UitBVDlUMFJCMFd5cUc5QnJlYU9NZnVvMFczOWcyWSsrbXhFVjBZM2F2bml3?=
 =?utf-8?B?bU9TR0kzYUNkRU9YZmEzcTNEa2ZuOHVTZm9xb2hHTjY5aVVKTTY0SnYwRGl4?=
 =?utf-8?B?NFNEbmRqZlh4OHpaSTlVdkgxTlFaNlFqUkdBL0JKWitHeWg2V0ZuTW9naGVY?=
 =?utf-8?B?ditPbzZHbWY0VzdPd0ZuelNYQXp4NEZxSmNyOGZxdjViZ1VoTTI0NHlud2Vv?=
 =?utf-8?B?cFhkbDdBNE5GUlNGNWJyeDJSYnAxeis1YTNwaC83T3p5clpoZlh1cktqMTVV?=
 =?utf-8?B?N2dyWmdhRXlsL1l3R2Vqd2Rsd010UWJEc2hxelZsTFZwd0RROTdjemNaYTRU?=
 =?utf-8?B?Qnhrdms0V2lFQkJLbUxRUjhNV1RwWGNtK2hpTFByRFR2WnZuQlNHZC9yWERv?=
 =?utf-8?B?ZDBjQUhSRnMvNE5CUjluL0JFUzJ5RjY4R0dRVEFXU0phS0xQalREYmZtTGUr?=
 =?utf-8?B?SFYxR2Nza2VPYWxTRmJ1Vk41a09vbzdTK2pXMHp6WWV0ZGhsUU90c0J6NlZX?=
 =?utf-8?B?VW5sTy9VdGlkbHJMR0NWU0NnSzhsbDI5L1ZybUNvbFc0WlJFam00R3FJTEFk?=
 =?utf-8?B?YXBjZUc2MVFNd3pTQUlZYmhva3NDWjBBdStzVVJGcndNNWJ5MWc3cjdpUnNj?=
 =?utf-8?B?RUdBMlo1ME1qRUx3RitmUlVlSjc3azBjYytoVDVxU3VuVHd4OUVtamhSWG5w?=
 =?utf-8?B?TEFJMWtPNk1VSVpkVmIyVlU4L2YvVU4zK3E2T0U5SVkrNCt6V21rekVpdW04?=
 =?utf-8?B?S1hnaHM2Mk8zaFNPVHl1MitWVG1hT2JoVEptVlM1RTBUR0hCL1d2TEx2eExl?=
 =?utf-8?B?MDhVMzBkVDh0dVN1NlkrZU5kbnFVbHN2azd2VVhjWllvNHpuNWg5MExXZHh0?=
 =?utf-8?B?eXlYVlBLUlk5RmlBaHRNMnptNjFJNDJueENrREkxbXJ1T04rczJhekhtaitR?=
 =?utf-8?B?eVVHT09UdTA5RDczYklPUkx4Nzc0ZkNJZ3pqUGVLQnA1U2hENGs1R2VkWGg2?=
 =?utf-8?B?ZDBKMXZzNWpDOTI1MlQvRG9ySGtHU1E3aURFWFFSamVaSGxacmxqSmg3S0VJ?=
 =?utf-8?B?TEJCb2tuZnk1QXdXR3FINGdyUHZQSk9vRWZiUmh2Uy9IR0lCZjcwRms2OTN6?=
 =?utf-8?B?UXNjZEFYS3UxbjJnSzJDVnBXUGdoTDdyT0ZsRUFnR0pkU0ZNanpFelRvUis4?=
 =?utf-8?B?eHhKdmxwdW5LVXBKQ2RmUmVXNHJpYm9KVUt5bTJWeTU4TmdkQ2FYWnZzbTJs?=
 =?utf-8?B?cnZPT0FKNlM3Yjh2N2YzSGltOUlHdW80dlF5SmhZVVZ5bGQ5UTVOeUZCNlpo?=
 =?utf-8?B?MHAyQmJJdlZyQWRHRTJKTGhaVkEyeUVaVzNkNjZMUVpiMkNUcmdOZmZQUXVv?=
 =?utf-8?B?bnFtNnhZZVdWSFlob28yQ0lrYytwMzJHVUoyMTRQMG5TSWI2OVZYOHQzYzI4?=
 =?utf-8?B?Z21QSnVEclRmcWRFT2s0TzM4M21SakRGaTBGdkljTXEvYTUreHBzQVpXZWUv?=
 =?utf-8?B?ZDJ1Z05icHA5UWZwb3IvcDAxU1dobnVTR1hXSENUYUQ1K2dORWc4dE9nSXRz?=
 =?utf-8?B?d1FmeWZuMS9FUFNGUmtTcElIZ3JxWUovL0lTd2JVazRNTXJ0S2docmp5Y3M2?=
 =?utf-8?B?SmZkRjN0a2VDc3ZmckdBOTd3NEFybldnOE4yQ3VMOVg5cEVMU2VuTmRNL1Fo?=
 =?utf-8?B?NkJ6TVlUaG80ZmlBY2psMk9WMjNlVlFUNnBMWExDVXZLQW02U01JOVdtc1pU?=
 =?utf-8?B?WWs4bVpjUEc0aDRHc3RGSFVVRys4ODZ5MWp0Qng2bnZKbmk2L2xJWGhvRGF0?=
 =?utf-8?B?VmxtMDUyTzU0blRQRXRRZ0p1dzZOOHVRQUlBc1NmZ3o5M2pLREpITkxxb0Ir?=
 =?utf-8?B?bWlqQjJud1EvOXF3bUE5dHBJdUhqaHNuck1odm5aQnR4UGs3UVZBcE1GVVY2?=
 =?utf-8?B?TEdFS2l1dndtblRKTk5nbkxqM21JVENEWXNuMndTeHYvdW1nYU5Pd2JOQlJJ?=
 =?utf-8?Q?vAOgmzDqMIRGMxlmte?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3e2386-4e70-4f2b-05bf-08de9635f7b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:46:06.7690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tI0eQqOV9tgfQvtNTYt2r/OMHlmGyecsbJ7cEq7iGJBTH09WlF13uhJnV5weqSIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
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



On 4/9/26 14:39, Khatri, Sunil wrote:
> 
> On 09-04-2026 05:25 pm, Christian König wrote:
>> On 4/9/26 10:33, Sunil Khatri wrote:
>>> Reshuffle the code to run create_mqd outside the mutex.
>>> code here is mostly setting up software structure init
>>> before actually registering the userqueue in the xa and
>>> to the driver.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++---------
>>>   1 file changed, 7 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index cf8c8dfde721..2408f888c4d9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -793,14 +793,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>           goto clean_mapping;
>>>       }
>>>   -    amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>> -
>>>       r = uq_funcs->mqd_create(queue, &args->in);
>>>       if (r) {
>>>           drm_file_err(uq_mgr->file, "Failed to create Queue\n");
>>>           goto clean_fence_driver;
>>>       }
>>>   +    amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>> +
>> Mhm while this might work it looks a bit questionable.
>>
>> What exactly is uq_funcs->mqd_create() doing? I though it would only be initializing fields.
> Things done here
> a. Allocate objects needed for creating queue, validated the mappings of various parameters of the queue.
> b. Call mqd_init for various IPs: like below, which set various parameters for mqd and but still not call any fw functions.
>    1. gfx_v12_0_gfx_mqd_init
>    2. gfx_v12_0_compute_mqd_init
> 
> Irrespective of that, we could make this mqd_init function with userq_mutex. I think it is safe.

When it allocates memory it is not safe to call this function while holding the userq_mutex lock. All memory allocations must be done outside of that lock, with the only exception being the resume path for the eviction fence.

So as long as the function doesn't talk to the FW the patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> 
> Regards
> Sunil Khatri
>>
>> Regards,
>> Christian.
>>
>>>       /* don't map the queue if scheduling is halted */
>>>       if (adev->userq_halt_for_enforce_isolation &&
>>>           ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>>> @@ -812,7 +812,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>           r = amdgpu_userq_map_helper(queue);
>>>           if (r) {
>>>               drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>>> -            down_read(&adev->reset_domain->sem);
>>>               goto clean_mqd;
>>>           }
>>>       }
>>> @@ -828,9 +827,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>       if (r) {
>>>           if (!skip_map_queue)
>>>               amdgpu_userq_unmap_helper(queue);
>>> -
>>>           r = -ENOMEM;
>>> -        goto clean_mqd;
>>> +        goto clean_reset_domain;
>>>       }
>>>         r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
>>> @@ -838,8 +836,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>           xa_erase(&uq_mgr->userq_xa, qid);
>>>           if (!skip_map_queue)
>>>               amdgpu_userq_unmap_helper(queue);
>>> -
>>> -        goto clean_mqd;
>>> +        goto clean_reset_domain;
>>>       }
>>>       up_read(&adev->reset_domain->sem);
>>>   @@ -851,12 +848,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>       mutex_unlock(&uq_mgr->userq_mutex);
>>>       return 0;
>>>   +clean_reset_domain:
>>> +    up_read(&adev->reset_domain->sem);
>>>   clean_mqd:
>>> +    mutex_unlock(&uq_mgr->userq_mutex);
>>>       uq_funcs->mqd_destroy(queue);
>>> -    up_read(&adev->reset_domain->sem);
>>>   clean_fence_driver:
>>>       amdgpu_userq_fence_driver_free(queue);
>>> -    mutex_unlock(&uq_mgr->userq_mutex);
>>>   clean_mapping:
>>>       amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>>>       kfree(queue);


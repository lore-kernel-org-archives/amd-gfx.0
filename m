Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C170C79F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 06:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3BE10F309;
	Thu, 10 Sep 2026 06:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yiBXKqqN";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013007.outbound.protection.outlook.com
 [40.93.196.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5457710F309
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 06:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2Nbz26m+UCCtek8lp+w5hOhznmrsyYGJ4oW7Y24dVKvIYfqjMP7aUjOajesasWC+H3SH9/cE65Oo1OaRsDftnfwWNouRyQyZm8OWR/q3Jp2B8Kp7y4eb9MkmjeyHDWtjcMKcx5GtG7ozZmOjocJbv0RG2qA6hRWjvHbVKhaNRU3ERhErxbP2s/QMmGp38bOQlbXQunuVE+8wzc06Xe9vOFfDliWgtj3knDGoyfFsOMrCxEjJ6lVpjFQ7+7ygvr4SNHDfgLRPAnikveKJ+dBXoWGdG47c/wNfJ5Fz5hW1KS7swgA5qrRXCVkctsY7TFc5FrFnzKWTXEuXbaA76LqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpPIfOEAv6irnEV1UUucWEydBGBpmeWiXUiR4EIVFMk=;
 b=E2OMLVZpl7ZkbjfK/8zfmxAZBoE59onUiBnAubeFwGX/MzqvhfscqCjAdGBCWn0kIW1jJKYxNg0ZXJl8MjHFGNLr9XB5ZpgAjazj9xK1PCZESw17yXTzZuPUyHee0a9M8233iv5PFTGqzDtZM/ObLWoebgZiXa0ANmMcx4es4Kn+Q4Z4oC9krnqlb1mBe8WD/QTHAWSgjQKPK0nQxyzMsXAWi21H57PjiQq/X6UDYO3NOoqLoJqI9l3y3L/gcCosHq0hlRg6eyn0SvTGCKzMsqVg3y4ZX0QPt+gSXXM7SHJ+YV9/NDKYdb6dcl1mVnEkcocP/43ltmemxb3wuSfPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpPIfOEAv6irnEV1UUucWEydBGBpmeWiXUiR4EIVFMk=;
 b=yiBXKqqNYJ4o5bojYRz1oExd6b3slhQPcnMEonJwk0dXGgnZoRqPUPVhLms+Wz3AGIgupcjvow5Vs4PuBQexLTaeJN0zlDqbp7eNjnzK+RsPUqPSiZD4PvG3ws2bLYdLGZ1X8eyqXk2cP/2JLm8TZ8czQzGi9aqDxrGymhPvc0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 06:58:04 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 06:58:04 +0000
Message-ID: <61caf661-a844-47b6-87b5-e7b71c3cd6b3@amd.com>
Date: Thu, 10 Sep 2026 12:27:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <CADnq5_PHEQzUVTqJYzO3mALs9LfK9cAUMQtgi0JEzGvFSZk7Eg@mail.gmail.com>
 <CADnq5_M+tLHSrfXQCxX2+LFq-x8OO1=BG+ou=qq2_Y0VS+b8AA@mail.gmail.com>
 <8573edf1-9af4-423d-8af8-08ac38f33ab2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <8573edf1-9af4-423d-8af8-08ac38f33ab2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 677ae90e-b792-4d38-0670-08df0f08dc18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|4143699003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: REvRUVg7TUxm1PsH97pPO4zNRgu3PPV4eo1esObXhikzfoDx1r4paOeD66TCIkhxalA5JU7CJc/4yM94rRtolD2mOe8uQKHvFcUHBMIZsZ7386nM9M83Pdq5rThh9ya/n5CvpFMw0AQn752zdvPwYNQ0SBcmLfdUpEMkO3UCVnCSs9ke4O/xz/17rmZf4okQN5fX24yDO56OwheoJ9V+cfKFTzw4rOb+yW6B07vJYPSERnXWiYZZcVXLY9HxVHO5p9wDnLFyxpbzyRlmqeUeR3pBeTLSD0zwdP/G4iEKhoBmXOODuuDyxs2gCEwt0GrRjrs+gkJj7Kv/hNJ3/bvHcQaSlRjZl0NhKsxr8FkQ2j+9xpniq8L9yF3ZdFjixg9hZ7TsO4AewYauCPFrAN4G9m7d/M1YQQSqXQMvGtZ6yqNHO6lE/JiJiVxTLFbLl01iJHctjn9wM5SbmbslZHFKS8m0vjQX/XAfaZa82yThYYz+Y9MYL80epc761nTOo+XmIijrs3GFgy6r1DesDRqBI/CteC6ivCVgvIR8soFoRQ9O54+encmKNNM96AzyHF7e9397JGW7J2dHKpL/07xURypdluzA/JyXYm6LPEOHFkQWjBSE/+wLG6NnwEDa8zvW5X8vWbjBhBKTMdunmQSEzHx8WwHDGJlPD3f+zRx6TMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXdkajFvZ001SC9EOXVKa2pKZVgxK05GSjV1bjVYTE95QjM4d0pLa3JDWnBa?=
 =?utf-8?B?N3ZqaXNZUTVIUXlHdUQ3ODYwTktNdzhUTjNEN1BpbENEelBDSUhnTmVHakd5?=
 =?utf-8?B?S2xVdW5abzBZTWt2MEx3RHc4dGtVUXNIT2I2SC9wekE5WnNPRmJDV3o1cUdZ?=
 =?utf-8?B?V0hwNVFneXpPU20zWWUwZzhGbWV1eUFnaXVNQjhiQm1EaW9aa08vMkdOdnY4?=
 =?utf-8?B?QVQxL3N1ZzRlTThJRi9qZkJoZUpuL1BCcjBvTEFGTEdGamFkWFNpT3VSdDZY?=
 =?utf-8?B?RjVtbzVmV0MwU05VL3IvTWNPM09PcWNIQzEvekwxelRsTlFrSkZBVFVUMisy?=
 =?utf-8?B?UFF2SU9RcWNQWnJvbHIyemxDUFV5MkRlZXZUeHVoTWZ3TW9kekxEY3BkQ2ZT?=
 =?utf-8?B?cE0wbkZZMWl0TlpQQzl5VVZUOS96NjlnWlI5c2htNzF5aHJhZW9IVE40blFF?=
 =?utf-8?B?YXNxck5tNWliVldQcnBTVUlHY2h3Q2JRSXorcnZWZjVZQ1EyaTFyT2FqcThX?=
 =?utf-8?B?RUV5cmVub2Z3M2Jpb2g1Z2hmbEpTYTZmYVZuVjdkYjZiem1rVmtaTTdJOUsv?=
 =?utf-8?B?K3FUbHhlenc4UEpkZVhrZGUwWFdsY0hqZlFlb1FMQ3AvUWxCdkZaVEtQci9s?=
 =?utf-8?B?ZUE1MFM2VHVzVUUrMnhTQ204eDZ4N3RuWTNZM2RkTC9VbWVvRzg0dW9laHkz?=
 =?utf-8?B?aythWHpwSHB6T0t1blV2aFlIdjV2ODRpdkJpM2VPSlJoMDBOME5renRvelhL?=
 =?utf-8?B?ZGFYbWZnNERydndWekxiMXNsSS9FUlpvQ2xDY3IrbHQ2RTRzRHhSZDkxZnRp?=
 =?utf-8?B?bkROL05FR2J1eWdJQWxFM0Y4cnZxQnRJcVpHTHBXWWtQSDV3bUdaU2pMemp6?=
 =?utf-8?B?aE5GWDJnUFcybTg4VTFiblgzUjBZTXM3NkpNTFcyYkgvbjRiZzM0ZjQwU3Rx?=
 =?utf-8?B?Tm5IQmNUbVNXU0NRRDYzbGpWdlY1ZkIvSmhtUFJEYjBvRjRZMDVBOGtvcDNW?=
 =?utf-8?B?WWdLQ2k3SnlEL3lqMDNMWmN1WldpTHhndW9YVmRDMHBTTHJaUzJFUHA1SjNI?=
 =?utf-8?B?Z0dMTUwvUFhCQkF4UHJQMFRJeHVlb3BkU0tEUzhhQWYwQ0tkb2hNWmxWZmZ5?=
 =?utf-8?B?OVIwUlgybFYxUy9VSjN4NUdHcFR0OXI1bldhWUJ5YVpzZnhRWWkzODBaVlNK?=
 =?utf-8?B?L3l3dDZzODg3WE9aZUo1aTdOMUFvMXEwbnBZZnV6ZHBSbGFrNE9qRjFjSEd1?=
 =?utf-8?B?TWt3YVFoRVhjdFUrOElNaVJ4dUxVMnR0MDUrd3VoUlJTVklRbFdVeGp0cGFB?=
 =?utf-8?B?VkhhRS9zZVJDZmpTL0M4bHVRQmlRcWMrVkdiVjVDTHlnMkdQdjE0SDBQTnVQ?=
 =?utf-8?B?MHVqQm5Pc0VHZ05FV1pVZGE4M3FrVEVxR1hNNldka2dXM013bHNSUjBvR1h2?=
 =?utf-8?B?NFh2MGovTDlUcFZGTGg4cDZueEpXckFuanFpU3lBck9zRE1LR0FvM3k0QXJi?=
 =?utf-8?B?dzJOVjBLSENzdkNzZlBpUlExN25FbXA1UEU4aHdSUjI1VlE5N0o5Mzdkdk8x?=
 =?utf-8?B?VXdTaEF4S0dFelpMQUxKR3VNckZCVnh0SUhQclFNZjJ3QXltZm1kcjQ5YjlP?=
 =?utf-8?B?MjcwRS93MHpDa01kWTVpYnRQdkJ5M0I5azRZdm9yamxhb1lDcFlFZUFKQ0hh?=
 =?utf-8?B?RmZYMjMxSnZpWEVpNFVkbzREVzJ3Vi8xWXdaaHVQTHNhWWJXZlA2UEV5NTgx?=
 =?utf-8?B?dURuWE4rN2ZVVjdmcnVUeWhTamVSU0ttcVdNL2pPMHJZdExtUnNaUlU5RzFs?=
 =?utf-8?B?ZHBHQWh5THFLY05BWW9Gb2F5TC9xcy9mSTFWZm1yY29ZUjM3a21xRjNzbkQw?=
 =?utf-8?B?K2FNU1BKSnRnU3NNSmM0aUpPN0pKV21oWFVjaW9LRDd4NE5FOVlRV2lsT1Fj?=
 =?utf-8?B?bHVmZ0xxTGxneElSOGtXajZVaDV3YzV4WlZPSjZ2M09UMWZNR1NPZTNvYWFa?=
 =?utf-8?B?eWpTSnZqZnlIdmo5S0NwaGJNNEtnc014U2J3dkFOd2drSnVnMEZDdllhKzA1?=
 =?utf-8?B?ZFh6UU5CUitKdmJMTEJmNXIxNXQ5SXpHK01DdG9lbjNQUUZheFhXS0lvcUtu?=
 =?utf-8?B?UkNJTWZyZXo2a0t2bm9ncFdIZ1JLK2RhdnZ3M2cxY1VHS2FMdEwwM0lRWWEx?=
 =?utf-8?B?T1FxVDhncFJCbjRXcTA3ajcwTHQxb3dRbFU0a3p3RkxZNkp2MWJXNnQ4UENm?=
 =?utf-8?B?NVhUTVZuV0dpSDc1SVM3cEFkVDlZL3FDZE05NGZINlhLUWp4eTRXS3ZwS3c0?=
 =?utf-8?B?MG5VSU4zcEVMWm9mUm1BZ2NOaTVwaEpJOSsvZVlvTzdocEVjR25MUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677ae90e-b792-4d38-0670-08df0f08dc18
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 06:58:04.0375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fs1+u1sGTKD9dl4JuIgFwZkfY/BLTSRy1bGLK1HSoDM4hMDqFXEID+pQq20tf5yT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224
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



On 10-Sep-26 11:43 AM, SRINIVASAN SHANMUGAM wrote:
> 
> On 9/10/2026 2:20 AM, Alex Deucher wrote:
>> On Wed, Sep 9, 2026 at 4:42 PM Alex Deucher<alexdeucher@gmail.com> wrote:
>>> On Sat, Sep 5, 2026 at 4:55 AM Srinivasan Shanmugam
>>> <srinivasan.shanmugam@amd.com> wrote:
>>>> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
>>>> SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
>>>> via ADD_QUEUE with map_legacy_kq=1 but does not set trap handler state.
>>>> On GFX10 and earlier HWS-based hardware, the driver programs trap
>>>> registers via SRBM select for KFD queues but no equivalent exists for
>>>> driver-managed kernel queue VMIDs.
>>>>
>>>> Add a vmhub callback program_kernel_trap_vmids() so each gfxhub version
>>>> can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
>>>> device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
>>>> address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its own kq_tma_bo
>>>> there, so per-VM isolation is handled entirely by page tables without
>>>> needing to reprogram the register per job or per submission.
>>>>
>>>> The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
>>>> (parallel to page table allocation) and mapped read-only into the GPU VM
>>>> at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-level
>>>> handler address into it via kq_tma_map when userspace calls SET_L2_TRAP.
>>>> The first-level CWSR handler reads this address to chain to the
>>>> second-level handler when a shader exception fires.
>>>>
>>>> This design is:
>>>>    - Per-VM BO (not device-level) — same model as page tables
>>>>    - Fixed VA in each VM's address space — same VA, different physical BO
>>>>    - Read-only from GPU — kernel CPU updates it via CPU mapping
>>>>    - Treat allocation/free lifecycle identical to page tables
>>>>
>>>> Suggested-by: Christian König<christian.koenig@amd.com>
>>>> Suggested-by: Alexander Deucher<alexander.deucher@amd.com>
>>>> Cc: Lijo Lazar<lijo.lazar@amd.com>
>>>> Cc: Timur Kristóf<timur.kristof@gmail.com>
>>>> Cc: Samuel Pitoiset<hakzsam@gmail.com>
>>>> Cc: Natalie Vock<natalie.vock@gmx.de>
>>>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>>>> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
>>>>   5 files changed, 110 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> index 3ca187f5ade8..5624a5ab5c62 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>>>>          void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
>>>>                                                   uint32_t status);
>>>>          uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_type);
>>>> +       void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>>>>   };
>>>>
>>>>   struct amdgpu_vmhub {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>> index 623cac6781be..e913488ca3fa 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>>>>
>>>>          amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>>>>          adev->trap_info = no_free_ptr(trap_info);
>>>> +       amdgpu_trap_program_kernel_vmids(adev);
>>>>
>>>>          return 0;
>>>>   }
>>>> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
>>>>          adev->trap_info = NULL;
>>>>   }
>>>>
>>>> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
>>>> +{
>>>> +       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>>>> +
>>>> +       if (!amdgpu_trap_is_enabled(adev))
>>>> +               return;
>>>> +       if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap_vmids)
>>>> +               return;
>>>> +
>>>> +       hub->vmhub_funcs->program_kernel_trap_vmids(adev);
>>>> +}
>>>> +
>>>> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
>>>> +                               struct amdgpu_vm *vm)
>>>> +{
>>>> +       void *cpu_addr;
>>>> +       uint64_t va;
>>>> +       int r;
>>>> +
>>>> +       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>> +
>>>> +       r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
>>>> +                                   AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_bo,
>>>> +                                   NULL, &cpu_addr);
>>>> +       if (r)
>>>> +               return r;
>>>> +
>>>> +       if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>>>> +               iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
>>>> +                                         (void __iomem *)cpu_addr);
>>>> +       else
>>>> +               iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
>>>> +
>>>> +       vm->kq_tma_va = amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
>>>> +       if (!vm->kq_tma_va) {
>>>> +               r = -ENOMEM;
>>>> +               goto err_free_bo;
>>>> +       }
>>>> +
>>>> +       va = AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;
>>>> +       r = amdgpu_vm_bo_map(adev, vm->kq_tma_va, va, 0,
>>>> +                            AMDGPU_GPU_PAGE_SIZE,
>>>> +                            AMDGPU_VM_PAGE_READABLE);
>>>> +       if (r)
>>>> +               goto err_del_va;
>>>> +
>>>> +       r = amdgpu_vm_bo_update(adev, vm->kq_tma_va, false);
>>>> +       if (r)
>>>> +               goto err_del_va;
>>>> +
>>>> +       return 0;
>>>> +
>>>> +err_del_va:
>>>> +       amdgpu_vm_bo_del(adev, vm->kq_tma_va);
>>>> +       vm->kq_tma_va = NULL;
>>>> +err_free_bo:
>>>> +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
>>>> +       return r;
>>>> +}
>>>> +
>>>> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
>>>> +                               struct amdgpu_vm *vm)
>>>> +{
>>>> +       uint64_t va;
>>>> +
>>>> +       if (!vm->kq_tma_bo)
>>>> +               return;
>>>> +
>>>> +       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>> +
>>>> +       if (vm->kq_tma_va) {
>>>> +               va = AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;
>>>> +               amdgpu_vm_bo_unmap(adev, vm->kq_tma_va, va);
>>>> +               amdgpu_vm_bo_del(adev, vm->kq_tma_va);
>>>> +               vm->kq_tma_va = NULL;
>>>> +       }
>>>> +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
>>>> +}
>>>> +
>>>>   static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>>>>                                    struct amdgpu_vm *vm,
>>>>                                    struct amdgpu_trap_obj *cwsr,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>>> index 7f83174a4742..9be5035abd1c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>>> @@ -155,4 +155,11 @@ int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
>>>>                                      struct amdgpu_trap_obj *cwsr_obj,
>>>>                                      bool enabled);
>>>>
>>>> +/* Kernel queue trap handler — per-VM TMA and register programming */
>>>> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
>>>> +int  amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
>>>> +                                struct amdgpu_vm *vm);
>>>> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
>>>> +                               struct amdgpu_vm *vm);
>>>> +
>>>>   #endif
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index de3ef9ce2234..f5e228d4bfb5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -2640,6 +2640,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>          if (r)
>>>>                  goto error_free_root;
>>>>
>>>> +       if (amdgpu_trap_is_enabled(adev)) {
>>>> +               r = amdgpu_trap_vm_kq_tma_alloc(adev, vm);
>>>> +               if (r)
>>>> +                       goto error_free_root;
>>>> +       }
>>>> +
>>>>          r = amdgpu_vm_create_task_info(vm);
>>>>          if (r)
>>>>                  dev_dbg(adev->dev, "Failed to create task info for VM\n");
>>>> @@ -2774,6 +2780,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>>                  amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>>>>          }
>>>>
>>>> +       if (vm->kq_tma_bo)
>>>> +               amdgpu_trap_vm_kq_tma_free(adev, vm);
>>>> +
>>>>          amdgpu_vm_pt_free_root(adev, vm);
>>>>          amdgpu_bo_unreserve(root);
>>>>          amdgpu_bo_unref(&root);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index dd825e179979..064f95a83790 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -25,6 +25,7 @@
>>>>   #define __AMDGPU_VM_H__
>>>>
>>>>   #include <linux/idr.h>
>>>> +#include <linux/iosys-map.h>
>>>>   #include <linux/kfifo.h>
>>>>   #include <linux/rbtree.h>
>>>>   #include <drm/gpu_scheduler.h>
>>>> @@ -488,6 +489,18 @@ struct amdgpu_vm {
>>>>
>>>>          /* cached fault info */
>>>>          struct amdgpu_vm_fault_info fault_info;
>>>> +
>>>> +       /*
>>>> +        * Per-VM kernel queue first-level TMA BO.
>>>> +        * Allocated at VM init, freed at VM fini — same lifecycle as page tables.
>>>> +        * Mapped read-only at AMDGPU_VA_RESERVED_TRAP_START in the GPU VM.
>>>> +        * SQ_SHADER_TMA for all kernel VMIDs points to this fixed VA; per-VM
>>>> +        * isolation is via page tables mapping different physical BOs there.
>>>> +        * CPU kernel writes second-level handler address via kq_tma_map.
>>>> +        */
>>>> +       struct amdgpu_bo        *kq_tma_bo;
>>>> +       struct amdgpu_bo_va     *kq_tma_va;
>>>> +       struct iosys_map         kq_tma_map;
>>> These should be the same for both user and kernel queues.  The only
>>> difference is who manages the vmids (driver vs MES).  They are per
>>> vmid so it doesn't matter whether it's a kernel queue or user queue.
>>>
>> I would merge these patch sets.  The trap handling is the same for
>> both kernel queues and user queues.  The only difference for kernel
>> queues is that the driver has to set the TBA/TMA registers while
>> MES/KIQ handles it for user queues.  At vm_init time, allocate the
>> memory for the trap handler, copy the trap handler to the memory and
>> add the mapping to the GPUVM address space.  Then in gfxhub init,
>> program the TBA/TMA registers for the kernel managed vmids.  Finally,
>> add the IOCTL to set/clear the second level trap handler and validate
>> the user supplied GPU VA.
> 
> Hi Alex,
> 
> Thank you for the review. I have few questions before proceeding with 
> the implementation.
> 
> I looked at how KFD handles this today in |kfd_process.c|:
> 
> /* KFD writes second-level TBA/TMA into first-level TMA */
> iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
>               uint64_t, tba_addr);
> iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
>               uint64_t, tma_addr);
> 
> Where |KFD_CWSR_TMA_OFFSET = AMDGPU_GPU_PAGE_SIZE + 2048 = 0x1800|. KFD 
> uses physical GPU addresses for TBA/TMA registers, not VM virtual addresses.
> 

KFD doesn't use physical adddress, it uses the below fixed virtual address.

pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(pdd->dev->adev)

KFD mechanism is to allocate one BO which is mapped to the above virtual 
address. That BO accounts for both TMA and TBA size. TMA is located at 
KFD_CWSR_TMA_OFFSET within that BO.

TBA region carries the first level handler code. It's not allowed to be 
overridden by user. Hence when we moved to new design, TBA is kept 
common for all user VMs.

TMA BO is the place through where user's second level TMA/TBA addresses 
are passed and also the place where stack is saved.

                 iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
                              uint64_t, tba_addr);
                 iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + 
sizeof(uint64_t),
                              uint64_t, tma_addr);

What this code does is to write the second level handler tba/tma 
addresses in the TMA, which is located at KFD_CWSR_TMA_OFFSET within the BO.


TMA region is the only variable thing per VM. First level handler code 
executed is the same for all VMs. So in the new design, we have a first 
level TBA BO that is shared by all VMs, and that carries first level 
trap handler code. The second level TBA is allocated per VM.

I see Alex is saying the same thing which I asked through a different 
thread. There is no need to allocate separate BOs for kernel queues. All 
you need to do is program the fixed TBA/TMA first level virtual 
addresses for non-KFD VMs during init.

Regarding kernel queue draining - my understanding is that the condition 
is no work having that VMID is in progress during the change. So, it may 
not be required to entirely drain kernel queue.

Thanks,
Lijo

> Question 1 — Which fixed GPU virtual address for the merged buffer?
> 
> KFD uses physical addresses for the TBA/TMA registers. Our design maps 
> the buffer into each VM at a fixed virtual address for page table 
> isolation. Should the merged per-VM buffer use | 
> AMDGPU_VA_RESERVED_TRAP_UQ_START| as the fixed VA? Or a different address?
> 
> Question 2 — TMA offset inside the merged buffer — 0x1800 or 0x2000?
> 
> KFD places the TMA section at offset |0x1800| from the TBA start (| 
> KFD_CWSR_TMA_OFFSET|). The current UQ design uses offset |0x2000| (| 
> AMDGPU_TRAP_TBA_MAX_SIZE|). After merging into one per-VM buffer, should 
> TMA start at |0x1800| to match KFD's layout?
> 
> Question 3 — When should TRAP_EN be set?
> 
> When programming |SQ_SHADER_TBA_HI| for kernel VMIDs, should |TRAP_EN| 
> be set only after the per-VM buffer is fully mapped? Or is it safe to 
> set it at boot time since TMA slots start zeroed (meaning no second- 
> level handler installed yet)?
> 
> Question 4 — Drain kernel queues before writing second-level handler?
> 
> When |SET_L2_TRAP| is called, user queues are evicted and TLB is flushed 
> before writing. After the merge, kernel queue VMIDs also read from the 
> same TMA. Should kernel queue work be drained as well before writing the 
> second-level handler addresses?
> 
> Thanks,
> Srini
> 


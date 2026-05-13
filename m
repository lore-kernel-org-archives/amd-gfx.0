Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93128CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2340110E0E8;
	Wed, 13 May 2026 14:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V832SRHl";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15BC10E0E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SINAuI3vC9HAZW2cr0RKKTbjP0o2w2MB2saGD9DLBmpVJ7+Yt4ZTi/gs4ImYAK+UGz6p4Tt9IU8GxNj/zJ+TUu5Yu6Erc9IHBBSLt2JwvGNRKwQC4lTQdX/4kc8dZNtsJ+Vi8bBqFK9etGa/ob6ncpI4itIX22qRlmCsS9hILZTv3j4z9FLJMd2OHyhKbWq3On2mjxIOFZWIS/VvIWpWRxFjiTJpzjf1BRNisgv/EfsmHHfvKsNXyaSzmRcmCuqGh0iHpHbuV/3zqNDtoxkEKuqIDtq23+jF5WKodBCSsqWxalv9/xef7KTiTHhYcZLipAcsUbmtA5xMtpkF4S/QTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GSQwWfKCljFTTllmTg3x/Csjk27BhMiu92QjEn1Y2s=;
 b=IUCCrcAMnpZHxlW4D3z40ZhAnuFVb9+/yzP1eQ1L5lCCov07TFGEGIO1lF0WrwiZrjSRxJlSBB4Vr/0PA3VnvOblSVIzO2XT+pPx9igV5zPJjAW6CR9v8EAbK3ibWT2R5+Dg0aNP1PQMvmYsoZ1QBqFEmXufDgDafzaWG8/gBthI/QkhK81aHub/wJ+RxnaeXuWc4F1GnZMmfl46GDf1ge0lV/9y2zaMMbHMv8HvHgAw33uKmd+9oziMlIrKuC8YNgnlcr/j/E7KSNxSSSpeqUVzXT2dIfcJYqpdSqWtw6/lrZLzerOa9MyWNErVG+ZsvZ3mlnUptPoK3B2j83lrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GSQwWfKCljFTTllmTg3x/Csjk27BhMiu92QjEn1Y2s=;
 b=V832SRHlTWDjno7xhCwRkMoX8ppkjWPdwiDcpEX/o8XUF6XljlrISB2yqJNxD1u/7MbhCTSzip/EYaQW82VvdlbTWHVMtiVmgy4KOQ+JLAFQ13vnMliIKsYonZjiRljNWbliG3CYiPE9Cvu+UaLzaPV2WTyeF9HBZ/uPwTjjdKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Wed, 13 May
 2026 14:21:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:21:29 +0000
Message-ID: <b97010c2-75e5-43cc-b844-ce61906eafaa@amd.com>
Date: Wed, 13 May 2026 09:21:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Perry.Yuan@amd.com
References: <20260511142259.1424915-1-yifan1.zhang@amd.com>
 <f40f3088-073f-40cb-9e3c-38da7b101f27@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <f40f3088-073f-40cb-9e3c-38da7b101f27@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0187.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: e93bbe75-64f1-4292-edb4-08deb0faecf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TbtIIzGdvNVxWHdBEx/xs4fKRqm99pIFiR3IRB73I1qjBIQlJqcYrdYSuyqQCcdUjAoAbIEddOqvBAy+UyZQBNhGucliLL4esI0RDwf9XUSTdQkcj14TJE4Fx4622o76ddpTCBCoANQI4lIwoDAfmdyQO8gcRAPKO8KEV6bRmtxwjlmlQVnh7MFFA44aVmAGUrEmHYEGt9JgOXNe4g3bWtt1qqEGqwjUhDvPcV511XoXXnwhTGGO0AS22yF4RpLJhSxxBUGMIIdut9rlBsQGdRkcTCNH1cPqgg8tHhtv49cqnvEth3XeRpE7areufb64PNzjNFLnzYnEHhj+Z0hL2Uvruyz2BkLYls8u2jrQELQoomcc2h+ErYUMpo1Gx9Cwc9qnSZct1x6Hak4FeW/ZKLp9A5F/reSJVJH6PvLZ/FBZfk7+nsrsQ0qdhwGDSO+Z3MnTDqRYJ2mTve8xC6LNX3M7xpYEe+AGZl2O9maqKR67AWoIbCNAb4/f/y3ADjRfsUz6vtPMsSyTxivTccrheMA/zkjozMycaoJgwMqLVVIgxMIiweGDIDXuGGGwM3RbdY/8CPO8V42oNjLp8btD51ANXqd3YqlXy0HmkAP9HCAimUSIpgy6HYxLdTCQXsFSHGFbRcWs1wzlqf79RVO7LK5CSFmdt0ES63Ph5MvPgj9OULr2RssInZ6oFJqquDLC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3p0enNSVUo5bjBaWkpkVVk5Z0xVU1RGRjZZRjVTRW9sajQ5MWhkcnRjbDk1?=
 =?utf-8?B?WDRyakhQMnlQY1lqOFhOcjcydFY1S0RlRFJyaDhNNTlVZ2pSK21pNFI5SStj?=
 =?utf-8?B?cXhZV0E1WjZiQzE5clhtNTJwcWsrY2NJNXM3cE0rQ1J6NkZLdTJuVEUyeTVX?=
 =?utf-8?B?czhlQjFqQ0hGK3Nac2JCWnFoSnQ1ZWF1YzJPVWlXcWE4SG9mQTk5TTduWm5R?=
 =?utf-8?B?UW5zdmdINlNBQ2oyKzZqZlZ1RTZPVmhOa0RHQURRSFFUQ0JHT0JReUJIMEpZ?=
 =?utf-8?B?SDBlT1E4N1E5NHY0WDQ5SkpBb0JScDhoRjVnMHpjRlJ3R2VPT0tuZ0VtZFBv?=
 =?utf-8?B?WUxMUlhSSlNJRU43MTNEd2JmRmpobWx6eG9oZjZ3d3RkZmFzT0ppYlVORGM2?=
 =?utf-8?B?bUpmT2UrZUw3SFEwT0FRRW9FVGVyNVZ3NmlvRThzRlZQd0RlclJrbGZndE8x?=
 =?utf-8?B?YmI5aXJBYTRselFSYUpyZFhwb0NKRFo2bENMY3p5ekxwZTllVlMwWXNQWnk1?=
 =?utf-8?B?WG9ickpkbWhrYUFBV0gxc0tBdlc1ZkhISnJDSVpzelJ0WWpBYnRlQ0hYMUxS?=
 =?utf-8?B?M0Rvam0zL2ZCeFJmZ1VVdzl2SGdwQWU3UnhuOXRZWXRPTGhieUFKcUFPN0JU?=
 =?utf-8?B?dHR4TmxmbEVBbk9la2wyTzFhc3lLMnFnNHYvaGtZcU14d25FY0cxYjR5RTZv?=
 =?utf-8?B?U3gvQjIzbkhocWJrbDl3emFsSk9seC9HZzcxNGVIK3FnSDhDMS8xaUJnVFRI?=
 =?utf-8?B?a0h2SEN3amdaOVhtZTU4UU11WFpPVVhzRTBnU0FjUk8rMGtXdWEyN0l3SEQ3?=
 =?utf-8?B?TVdXcDVHeWtrZlE0Z0lIekhHSmhHa2llR09PSlpVYzEyb0RIUWgwaGd6MnZY?=
 =?utf-8?B?UmhXaFhndGhVeFdmOTh2cngyQ1VVblRNODhuLzBtek5uc01RMVA1d2RwM3I1?=
 =?utf-8?B?d0pHNGgyVnRFRXVHeUlNVmVpRkN3QzJVUGNjdTRsQml6VDZobVlpNTZHbXdK?=
 =?utf-8?B?eXNQdW5ZZlRxdGprVXl2ckJ5OG1VVTZ3RjdZOHM3MDQ0a1htT08rRFdmWWZ6?=
 =?utf-8?B?TU1uN1B0WDdVTzUvM2t6d0FHbERCbi90dW9pSm1NS3VINCt6TFdVS2pCMVFz?=
 =?utf-8?B?S1ZpbUVVZ2lmUzFrRTdZVHFld0xqWTVvcHhST1hlRW1jUmx6cUtWUWF6ZTJw?=
 =?utf-8?B?R3ZLUzBZa3grd3ZGQ1FqSExYU3Y1Z1FFQWM5bnBUMzFvYkNYOVVnbXlmS0JN?=
 =?utf-8?B?VytINWlILzBuaE5WK1Z3S2JSb0pKbDZCS2E0UE9JeEtFekFNMU1VRm9mTmlJ?=
 =?utf-8?B?cEM5aVBFOVRINlhia3BUQ3VsMUZNSVNOUVhnVFBBVlpGZ3Y3SlIzSElTR0xS?=
 =?utf-8?B?c3BubE4yNU1wWUFac2MvaTVHVW1mZ251dzlOQWVDbVVlSzFzdkdCbDY4TFRi?=
 =?utf-8?B?b1lJTUVnSHBuWTZabXhPdU4raWFFdjJOQ0pZM3B0V0tyNjB4V25idTFJV0Ri?=
 =?utf-8?B?dW5SQ0xRNXNpTUliRnhxdm1RZW5RYzdCc1JHZzQxZ1pQQTNwTUdrd2p3STB2?=
 =?utf-8?B?RlNJOGVNbEdVN2lPV3laNmw2QTJlQzR1REptaEMzL2RHeU03cVFCRHpjZGpB?=
 =?utf-8?B?Wmx2NG1XK3NQMzhKZWhtTUNKTkZ0cVUvNGtrcG9vbFVIUkU4bTBJZTZEUVVX?=
 =?utf-8?B?WjRXdWFiRll3Ym41akxiUHB4WXFwYUxXQTZwVThxTkRJMVpmNXVpWmZXMnQz?=
 =?utf-8?B?em4vK2cxWlpNRUdXMnJ1VGRIamt4enNRdUNYREFlK2hOSzZtdjVYVm5yZXRq?=
 =?utf-8?B?OGhqOUFOUlFKWUg3K3k4dkNTdzlJTGFyTStSY04wTUVlMTJka2NpTWFWOTZp?=
 =?utf-8?B?OWhZQzQ0cTBhRDJRMTBMa2c3elI4QkVQT0NlZDZFNEJiazMzT0J4RWlBWDB0?=
 =?utf-8?B?UGxZSXdBK3VZVG9oU2ZBb1F2NzkxdmcxRXROZFJtaW9NOVZheTJhMEJEM2ZB?=
 =?utf-8?B?YTFWUDRFdVpJaFFONm94R3ZlU3B3KzF0N0ZtTTlYeGcwbUlCQVI1NEVqK0pt?=
 =?utf-8?B?V0lHcHVTMlpWRDg3UHNOZ1QrREhxdThYbWgzcHowSHN5S0NGcWhlRkJoYnBw?=
 =?utf-8?B?TVNLQnJDcm54Vm9vZCsxSEtVc0VVU3VaVjJzR2MxWU9Jb2FNRllBZWUweHg4?=
 =?utf-8?B?L1QzRmU2M2RHTzFDYWFkOEgyNjNXQU1NNjlibUhYN0NVb01lSyt0Tnd4eUFH?=
 =?utf-8?B?Zk1IaXI1cVBpcHNZeXZheHJqOUE1SjAvdnh4RTJlbldvclNFMXovM2dZNDkw?=
 =?utf-8?B?VlBYRFBMSEhvTnEwRENMUkdRMWIyR29seXp1SzUyUDNGVnM4NENadz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93bbe75-64f1-4292-edb4-08deb0faecf6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:21:29.8500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOKxJ1ROzd7cCeaij2CWGM1jaKh3GcyeQFPSauP1zCo5s5JRMiOLY1RVbMZjwI6IjUmBlUZhDtxpXIKWaSfjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
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


On 2026-05-13 01:58, Christian König wrote:
>
> On 5/11/26 16:22, Yifan Zhang wrote:
>> During Mode 1 reset, the ASIC undergoes a reset cycle and becomes temporarily
>> inaccessible via PCIe. Any attempt to access framebuffer or MMIO registers during
>> this window can result in uncompleted PCIe transactions, leading to NMI panics or
>> system hangs.
>>
>> To prevent this, Unmap all of the applications mappings of the framebuffer
>> and doorbell BARs before mode1 reset. Also prevent new mappings from coming in
>> during the reset process.
>>
>> v2: remove inode in kfd_dev (Christian)
>> v3: correct unmap offset (Felix), remove prevent new mappings part to avoid deadlock (Christian)
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 22 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 22 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
>>   5 files changed, 52 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 7b10bbe28caf..d1dac3412a66 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -36,6 +36,7 @@
>>   #include "amdgpu_ras.h"
>>   #include "amdgpu_umc.h"
>>   #include "amdgpu_reset.h"
>> +#include "kfd_priv.h"
>>   
>>   /* Total memory size in system memory and all GPU VRAM. Used to
>>    * estimate worst case amount of memory to reserve for page tables
>> @@ -320,6 +321,27 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>>   		(void)amdgpu_reset_domain_schedule(adev->reset_domain, &adev->kfd.reset_work);
>>   }
>>   
>> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
>> +{
>> +	struct kfd_dev *kfd = adev->kfd.dev;
>> +	unsigned int i;
>> +
>> +	if (!kfd)
>> +		return;
>> +
>> +	for (i = 0; i < kfd->num_nodes; i++) {
>> +		struct kfd_node *node = kfd->nodes[i];
>> +
>> +		kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_DOORBELL |
>> +					    KFD_MMAP_GPU_ID(node->id),
>> +					    kfd_doorbell_process_slice(kfd));
>> +		kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_MMIO |
>> +					    KFD_MMAP_GPU_ID(node->id),
>> +					    PAGE_SIZE);
>> +	}
>> +}
>> +
>> +
>>   int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
>>   				u32 domain, void **mem_obj, uint64_t *gpu_addr,
>>   				void **cpu_ptr, bool cp_mqd_gfx9)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 2bf6a31c194d..5333e052d56d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>   		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>   void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>   		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
>>   
>>   u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1202a72ff063..6760c9331f46 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5844,6 +5844,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>   	/* We need to lock reset domain only once both for XGMI and single device */
>>   	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>>   
>> +	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
>> +	 * accessing them
>> +	 */
>> +	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
>> +	amdgpu_amdkfd_clear_kfd_mapping(adev);
>> +
>>   	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
>>   				      hive, need_emergency_restart);
>>   	if (need_emergency_restart)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 84b9bde7f371..1be1b1dd2341 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -69,6 +69,21 @@ static const struct class kfd_class = {
>>   	.name = kfd_dev_name,
>>   };
>>   
>> +/*
>> + * Cache the address space of the chardev on first open so that the reset
>> + * path can drop all userspace mappings of doorbell and MMIO ranges via
>> + * unmap_mapping_range().
>> + */
>> +static struct address_space *kfd_dev_mapping;
>> +
>> +void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen)
>> +{
>> +	struct address_space *mapping = READ_ONCE(kfd_dev_mapping);
>> +
>> +	if (mapping)
>> +		unmap_mapping_range(mapping, holebegin, holelen, 1);
>> +}
>> +
>>   static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
>>   {
>>   	struct kfd_process_device *pdd;
>> @@ -135,6 +150,13 @@ static int kfd_open(struct inode *inode, struct file *filep)
>>   	if (iminor(inode) != 0)
>>   		return -ENODEV;
>>   
>> +	/*
>> +	 * /dev/kfd is a single chardev so all opens share one inode. Cache
>> +	 * its address_space on the first open for use by the reset path.
>> +	 */
>> +	if (!READ_ONCE(kfd_dev_mapping))
>> +		cmpxchg(&kfd_dev_mapping, NULL, inode->i_mapping);
> That stuff looks really odd. Mostly @Felix why is that necessary?
>
> Apart from that the patch looks good to me.

My understanding is, that kfd_dev_mapping caches the mapping in a global 
variable, which is OK because there is only one KFD device node. Using 
cmpxchg is a reliable way to update it without holding a lock the first 
time kfd_open is called.

It's not pretty, but I can't think of a better way of doing this.

Regards,
   Felix


>
> Regards,
> Christian.
>
>
>> +
>>   	is_32bit_user_mode = in_compat_syscall();
>>   
>>   	if (is_32bit_user_mode) {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index a6ff1db477f9..f037062c33ea 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -399,6 +399,7 @@ enum kfd_mempool {
>>   /* Character device interface */
>>   int kfd_chardev_init(void);
>>   void kfd_chardev_exit(void);
>> +void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen);
>>   
>>   /**
>>    * enum kfd_unmap_queues_filter - Enum for queue filters.

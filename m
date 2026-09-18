Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98EBC982DA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 12:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5902810E0C3;
	Fri, 18 Sep 2026 12:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ofanm1jm";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D293710E0C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 12:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M94sb8YxUSslJ1xWcqR1kaKhGjEy03jF75kj+4RBhM4ngLutZkRMTGUJgapLk0gaqzLjfT4YU2UlzW5/NQRHrcSsnmKPXYUNkDfaeOXFXeaSnTZgvxkEq97BINY263x/K/jKSBXTLVVK0sqR9CpQx5dMkbugAXSYP/nmRcannNP21BRCKnwANrL3P4OrJktalMHV5UagKSG5frk6bcHMSKxu+RoH90O0dxWcWNvKtLtW625yWgg5Anms9UBG6lDmOIib+CGzqilEKYV+jQau29sNLNW6QVYUXqVwlp+5bCpjvHTg3HSFXdlx88F3WtL6xaWVOZNbIY1L7rGf/R4haw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oI/moC4x5A2jKZvmbpYmIZ919N2Md/l00xaDDVk1Bdw=;
 b=tuLz5iALioBmdo+VLjgNVQGkfzvGvVLd5Aqr+IdAI+rYaEDXpn5n9Y0rh7v7JRKvKf8anEN21ismqriFD+H52hcaDipKsQ77i4nm9e8dAZsSZUE4yO8G9PcPpQQZ7T7siwuKsVIwuznfELdlN/oVOI+ogh+PTkLXrpIjMQ6FD4SxzsurCgc9dz1J9lReEAGopYqdmUXO/lu1QeRcnudYOfYWH48lG2l/6KL2MqeH3NSG8eS9LNBhe31EhC2/S6UNmZRPJe+MxoLFCScL53WG6GCIv7MoyCPoWfZwPDENibdtkG6YCYMzE/uF24gofYwGdvxPWsHb+JN+dBMI2dH4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI/moC4x5A2jKZvmbpYmIZ919N2Md/l00xaDDVk1Bdw=;
 b=Ofanm1jmq7uNaKmJejx9PtJSSpb9WVF5aP0f1I3/dnnA0xtVF5MtzmL/4w6wlhR6gzVQgWnCjxlyInHQNbeq4XjK5pWIiCalGi4DgyWPOKCN0NAm8W+IYcxbwICSznlC+1WagmvBlkQI6xfTliETV/RMrxML6PEzHUa20AXUU8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 12:25:14 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 12:25:14 +0000
Message-ID: <4f2852de-7669-4e23-b75a-5d814309cd90@amd.com>
Date: Fri, 18 Sep 2026 17:55:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Program trap TBA/TMA for kernel-managed
 VMIDs
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
 <20260916053722.601067-4-srinivasan.shanmugam@amd.com>
 <04f954fd-bf4a-4677-ab0f-69b7a3edafc4@amd.com>
 <5de4d9dc-5324-4fbb-8215-d4aac230f929@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <5de4d9dc-5324-4fbb-8215-d4aac230f929@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8b56dc-622c-450b-4551-08df157fe451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|10067099003|6133799003|4143699003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 7/z8JkC5iHS07lr/Xb+zQMN2yi21XVULkOuKhPEKW2CIY5MIkVrMeIaOdVApUSIPS36hgCv+ScK0RZ78ETu8HX4vpLz9d7xkaCCNXpzq7V+h54XYWzTnYhj6LitBbcLuENyhzgq8ieQBdh9HR2VUMZDuB1ord7Rf0xBvmwiMxBpD1QDpTKyTTLcv4EdeUhuAmNbqvZzYKPsQ89gg39kBcidCZ2sYP4bQa+Etw09JZtZvwD0FVeNhFzoMKy1XCRo5Wa+RlqhUIYi6jIJjzWmsv7oGy7LnEBCJBarq1iYENJug1gIwiXeXjeA0aVwOmLdfLUigcQ1ygFeRe6RO1bsjGqG19L9LkpiRbvtY9ND/B7pmk8Uf4sKKU919sZcSfEMAxSTxZCaAvhd7cTeg5WG9uiB98CVh3cITTQ2Op/7A/INAkKbWy/REtyiRwULqJsF+h+2dirgYECOQNQC/VUUhZdx+kQAXQpHdhcRJ3faeGWjNHl5zC9Ue7f0pRzwQnAO6aHkc9hVquLQN1/7j2VziCyLzSJS0pYoPJQYxIM4kFlGwaKxfvdLFFEqUo14TK9t7zvi9anJ3KjUGkUKed275Iu+BLPa5oLVTYlMF/pPR6nG56mJztk7jGtFL91vi9GvQylURgqEsfRi0LG36H8jtDt+tuv4c4bvCz2abNHrzjL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(10067099003)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3Z3cnNIZjNLdlJkWlpwdm5kN3hFQ1BUZisyMXdGc3FLK0VnSE41Q1ZZQkky?=
 =?utf-8?B?amdBcFFCdWFpRjVxenJ1cVNsOTU5bVNkYndPVjd2TCt5VG5MNVFqL0pXdWhM?=
 =?utf-8?B?N3p0YXZMRzBFWXBoVXdjclpjQXhHbiswYTFpNXMvZ01hTDlzemdydXE4L3Ri?=
 =?utf-8?B?SCtWb3YwNW9wSjRhZnRKWWw2am12ZkdmallyNUs0K3ZxTEREQXhEOXpPMXVw?=
 =?utf-8?B?Y1hSV09YZzh0U3dpT2phTVg3Ri9IODNiUCtlZDRVdk1tZ0lCeVRNR0NsMDJV?=
 =?utf-8?B?NUVrTzYzYkRSUlV1RXBGekd4azRQY3hMejFwNkViRDlLRjNLd1ZMN0VqRnhl?=
 =?utf-8?B?MHpQLy8vSUtJWVowMmhINkVJNWZKRHNjNkdRMml0bVQwQmk1STFhbDl4RVps?=
 =?utf-8?B?d0FzZEJ6bmNmNXZ5d09jR2J3WmRmRHpyTHB3bEJUOTFkOWZOZDdTWWdoa0t0?=
 =?utf-8?B?QUZwcDh3M2c5SVBpZXpJNUt0bUk2SDhYQlZQZHVVV2oyeHE0YWh0TVBhenVo?=
 =?utf-8?B?VklHY1krUGVKSlM4Q3JFZG9VMS9xaEgvS1VJODN1aW85Ui9COEdJV2oxYTlO?=
 =?utf-8?B?Y3dWK004dnlPOE9vdWlPaXYwbWVZcG9iRmlvZXJ5RHdNK2w2ZlpCUnFuWlRj?=
 =?utf-8?B?WnpTZUFGaFhnd0drU0REc3VmcVV0R2ZKL2hDcXk5Rm9KVEhWelo3WkhQSm9K?=
 =?utf-8?B?a2ZrNGwrdFpURGVoZysrc1pvUjI2eU5uUzNyblcwZ3FzT0pYWTZ1VkFLUnJ3?=
 =?utf-8?B?NThPTFdDM2x1bkNRZm9kTVJ3Nml0ZFhESEQwNUtrMXBOZzl1MGhZMElUMVpq?=
 =?utf-8?B?Ry9lbFpFbmVYWjcyR1dzamRvUUpjRGNUTFFndysySGJmK2RBbDVFUDRlOWVa?=
 =?utf-8?B?QVUvOWRqdFRsZGcwZFRXT0llcEx2QkVTZ3RaNFhQTGZ0VDVVbkFGVTNKWjFV?=
 =?utf-8?B?dmFoTXFwRUJCRzZlSjYyZE8zNDNpa3hQYTBpbTZPdWp5SkpMeStlRmFzRkta?=
 =?utf-8?B?a1NMMldNQjJmaTE2a3hsb3MxQTFQN1FVMEJ0WjBGRnJrZ0J4M0Y1b0hvU3Vu?=
 =?utf-8?B?dklBclVBcXNjWDQ5cWlJQWN4ZlBERXF3em5xWTc3ZHl4c3IvV0dkSzZrZEVF?=
 =?utf-8?B?czZBVnh5OCtLWWxJdTBFN1haS3ZYRktjRXRnQlZtZmFQWjdlT1c5bUpsa3Az?=
 =?utf-8?B?RmVqN0g2Q1FFU2EzakZMTjQwZE9jTFhSejh4MFRLSDJtL3UvdW96ODVSQzRo?=
 =?utf-8?B?cDQ1MHU3aXhwNS81V3VKemNYRytOc2g5SHFTR3ZTR3podEgranRxVjB3c3k2?=
 =?utf-8?B?UEJJejU0Y2FMaWlReEpidE80S2pGeDBqZC9oNVczdldYNng5OWllUzh6TnlH?=
 =?utf-8?B?ZVYzcE9HU01nYkdhWi9zQVBGYzlvUHRqTG9JYXhEVGdWZ3o3SEsyazhOVkdq?=
 =?utf-8?B?VUJOR01wZ3A0aGRxNjBLR0FKS1BrUXF1bkFvSmR0dzR0ekVsRk9SUVBudmh1?=
 =?utf-8?B?UVpCN1JaMDY0TThuTmlVbHRjb0VMUU5PaTRNNDVVcWc3bmxBZ1hnZHJxY083?=
 =?utf-8?B?LzdBSzZXUGVCUDZaZ2hIN3ZUVHlITXErNXJDa2Z4dDFXcUpLWnE1V3o1cnQ0?=
 =?utf-8?B?Z1VJaHlFUFExM1M0R2RsR3RMZ1dxNGo2a0k0cWYzclJKcS9sZ1Q2eWhKRFlQ?=
 =?utf-8?B?eERoMU1nOGVkZDUrYXJDVnlXZm1OWFlNaW9JeTRZR1NVckpEZkJmd3pmekJk?=
 =?utf-8?B?MFVmblRXRFlBV3RRdnJlVDVvQWM2Q29oY05hakYyNFZtY2pnM1hOa2hSK2xH?=
 =?utf-8?B?bjljK1BqYnBlcVdyN1UwZGFQSXV3ZURTYS9ISkdFMS9KQlFBeEFvZnNSMFdO?=
 =?utf-8?B?cGp5c1lCMVQ3WTRYOUYzMjc0SkhodXE5bXB5YXBIZEl1WXlabGs2WnU3bUk0?=
 =?utf-8?B?bzgvajUxVjF3WER3ZTRWeFVZYlI4dklGZC9naVhJelVvWmNSSFpld2xVUG9C?=
 =?utf-8?B?L2JwWmVrUmJ1anpBZW9uM2dhMmJ4SEJKUjZHQW5MYWdXRnVhblU0VEczQlBB?=
 =?utf-8?B?b0RhNlRSR2VJK0Y1aXZwT1FobjhHOFV0L3NNL3Z4alM0VnpSUm5XOWQ1QUdM?=
 =?utf-8?B?TTcyRXdGNXlvREliSVFjU2kvNDA2cEd2dnNnQmtZMXBwSjFHSGlHRDNqSm5C?=
 =?utf-8?B?TWxPTHRaYnlXWTJ1L212TFQwQm80Mkx3a2pBajEyQ1lyNVpRbStNK1hhMFpz?=
 =?utf-8?B?alJMWDdQTE9WNFVkUzhWNlRHcFhsZTRvUUhRZThZcjRZdVhXbTR0UEtkQS9P?=
 =?utf-8?Q?S/ncxpT92+MBtz7c3c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8b56dc-622c-450b-4551-08df157fe451
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 12:25:14.6717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8FdB8BFPDlooDWRa6gMp5VIoKAsSV1ciTTnctIw/LdhFtWEvu+p7mrR7UohO+zm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
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



On 18-Sep-26 5:47 PM, SRINIVASAN SHANMUGAM wrote:
> 
> On 9/18/2026 10:30 AM, Lazar, Lijo wrote:
>>
>>
>> On 16-Sep-26 11:07 AM, Srinivasan Shanmugam wrote:
>>> User-queue VMIDs receive their trap register state from MES/KIQ at queue
>>> creation. Kernel-managed VMIDs do not; program them here.
>>>
>>> Add program_kernel_trap_tba_tma() to each gfxhub generation and call it
>>> from setup_vmid_config(). No vmhub callback is introduced: the operation
>>> is generation-specific and belongs in each gfxhub's own setup path.
>>>
>>> Both TBA and TMA addresses are GPU virtual addresses taken from the
>>> common trap mapping established at vm_init. TRAP_EN is safe to set at
>>> this point: any GPUVM assigned to a kernel-managed VMID already has a
>>> valid trap mapping before it can execute work.
>>>
>>> TBA is the shared device-level ISA BO mapped into each VM at
>>> AMDGPU_VA_RESERVED_TRAP_START. TMA starts at offset 0x1800 from the same
>>> base, matching KFD_CWSR_TMA_OFFSET so both KFD and render-node VMs use
>>> the same per-VM buffer layout.
>>>
>>> The helper is named program_kernel_trap_tba_tma() because it selects
>>> each kernel-managed VMID and writes its TBA/TMA registers; it does not
>>> configure the VMIDs themselves.
>>>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    |  4 ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  9 +++++
>>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 35 ++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 35 ++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 39 +++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 35 ++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 35 ++++++++++++++++++
>>>   7 files changed, 188 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_trap.c
>>> index 3313bc099cf4..d17f54ccadb0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> @@ -38,10 +38,6 @@
>>>     extern int cwsr_enable;
>>>   -#define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
>>> -#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
>>> -#define AMDGPU_TRAP_TMA_OFFSET (AMDGPU_TRAP_TBA_MAX_SIZE)
>>> -
>>>   #define SGPR_SIZE_PER_CU 0x4000
>>>   #define LDS_SIZE_PER_CU 0x10000
>>>   #define HWREG_SIZE_PER_CU 0x1000
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_trap.h
>>> index 2d855433308a..5769c5acb5c0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>> @@ -26,6 +26,15 @@
>>>   #include <linux/types.h>
>>>   #include <linux/iosys-map.h>
>>>   +/*
>>> + * TBA occupies one page plus 2 KiB (0x1800). TMA starts at that 
>>> offset.
>>> + * Matches KFD_CWSR_TMA_OFFSET so both KFD and render-node paths share
>>> + * the same per-VM buffer layout.
>>> + */
>>> +#define AMDGPU_TRAP_TBA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE + 2048) /* 
>>> 0x1800 */
>>> +#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
>>> +#define AMDGPU_TRAP_TMA_OFFSET   (AMDGPU_TRAP_TBA_MAX_SIZE) /* 
>>> 0x1800 */
>>> +
>>
>> This doesn't work after the split to a separate tma bo. A new bo 
>> mapping has to be at AMDGPU_PAGE_SIZE aligned offset. There is some 
>> check like that in the mapping API is what I recall.
> 
> I checked the VM mapping validation and confirmed that the separate TMA 
> BO needs GPU page alignment.
> 
> Since the UQ trap region reserves three pages, I'm planning to keep the 
> TBA at AMDGPU_VA_RESERVED_TRAP_UQ_START and place the TMA after the two- 
> page TBA, at TBA + 2 * AMDGPU_GPU_PAGE_SIZE.
> 
> I'll keep this layout inside amdgpu_trap and return both addresses 
> through the helper you suggested.
> 
> Just to confirm, is this the layout you had in mind?

Yes. If trap handler grows in size or layout changes etc., we  don't 
need to take care in below functions. These functions only care about 
absolute VA values for TBA/TMA.

BTW, from what I understand there will only be 
AMDGPU_VA_RESERVED_TRAP_START which will be programmed for all types of 
queues; no separate macro required like AMDGPU_VA_RESERVED_TRAP_UQ_START.

Thanks,
Lijo

> 
> Thanks, Srini
> 
>>
>>>   struct amdgpu_bo;
>>>   struct amdgpu_bo_va;
>>>   struct amdgpu_device;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/ 
>>> gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
>>> index 652eea6eae4a..687268e23344 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
>>> @@ -22,6 +22,7 @@
>>>    */
>>>     #include "amdgpu.h"
>>> +#include "amdgpu_trap.h"
>>>   #include "gfxhub_v11_5_0.h"
>>>     #include "gc/gc_11_5_0_offset.h"
>>> @@ -290,6 +291,37 @@ static void 
>>> gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
>>>     }
>>>   +static void
>>> +gfxhub_v11_5_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
>>> +{
>>> +    u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
>>> +    u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 
>>> 0x1800 */
>>
>> Better to get it through a helper like amdgpu_trap_get_l1_addr(tba, 
>> tma). The layout needs to stay within amdgpu_trap.
>>
>> Thanks,
>> Lijo
>>
>>> +    int vmid;
>>> +
>>> +    if (!amdgpu_trap_is_enabled(adev) ||
>>> +        !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
>>> +        return;
>>> +
>>> +    WARN_ON(!IS_ALIGNED(tba_addr, 256));
>>> +    WARN_ON(!IS_ALIGNED(tma_addr, 256));
>>> +
>>> +    mutex_lock(&adev->srbm_mutex);
>>> +    for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
>>> +        amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
>>> +                 lower_32_bits(tba_addr >> 8));
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
>>> +                 upper_32_bits(tba_addr >> 8) |
>>> +                 (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
>>> +                 lower_32_bits(tma_addr >> 8));
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
>>> +                 upper_32_bits(tma_addr >> 8));
>>> +    }
>>> +    amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
>>> +    mutex_unlock(&adev->srbm_mutex);
>>> +}
>>> +
>>>   static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device 
>>> *adev)
>>>   {
>>>       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>>> @@ -337,6 +369,9 @@ static void 
>>> gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>>>       }
>>>         hub->vm_cntx_cntl = tmp;
>>> +
>>> +    if (amdgpu_trap_is_enabled(adev))
>>> +        gfxhub_v11_5_0_program_kernel_trap_tba_tma(adev);
>>>   }
>>>     static void gfxhub_v11_5_0_program_invalidation(struct 
>>> amdgpu_device *adev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/gfxhub_v12_0.c
>>> index 6cbf837d50dd..b521a6c6eaf6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
>>> @@ -22,6 +22,7 @@
>>>    */
>>>     #include "amdgpu.h"
>>> +#include "amdgpu_trap.h"
>>>   #include "gfxhub_v12_0.h"
>>>     #include "gc/gc_12_0_0_offset.h"
>>> @@ -295,6 +296,37 @@ static void 
>>> gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
>>>     }
>>>   +static void
>>> +gfxhub_v12_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
>>> +{
>>> +    u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
>>> +    u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 
>>> 0x1800 */
>>> +    int vmid;
>>> +
>>> +    if (!amdgpu_trap_is_enabled(adev) ||
>>> +        !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
>>> +        return;
>>> +
>>> +    WARN_ON(!IS_ALIGNED(tba_addr, 256));
>>> +    WARN_ON(!IS_ALIGNED(tma_addr, 256));
>>> +
>>> +    mutex_lock(&adev->srbm_mutex);
>>> +    for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
>>> +        amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
>>> +                 lower_32_bits(tba_addr >> 8));
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
>>> +                 upper_32_bits(tba_addr >> 8) |
>>> +                 (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
>>> +                 lower_32_bits(tma_addr >> 8));
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
>>> +                 upper_32_bits(tma_addr >> 8));
>>> +    }
>>> +    amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
>>> +    mutex_unlock(&adev->srbm_mutex);
>>> +}
>>> +
>>>   static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
>>>   {
>>>       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>>> @@ -342,6 +374,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct 
>>> amdgpu_device *adev)
>>>       }
>>>         hub->vm_cntx_cntl = tmp;
>>> +
>>> +    if (amdgpu_trap_is_enabled(adev))
>>> +        gfxhub_v12_0_program_kernel_trap_tba_tma(adev);
>>>   }
>>>     static void gfxhub_v12_0_program_invalidation(struct 
>>> amdgpu_device *adev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/gfxhub_v12_1.c
>>> index 4c2fd1e6616e..ac52ccda713d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
>>> @@ -21,6 +21,7 @@
>>>    *
>>>    */
>>>   #include "amdgpu.h"
>>> +#include "amdgpu_trap.h"
>>>   #include "amdgpu_xcp.h"
>>>   #include "gfxhub_v12_1.h"
>>>   @@ -406,6 +407,41 @@ static void 
>>> gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
>>>       }
>>>   }
>>>   +static void
>>> +gfxhub_v12_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
>>> +{
>>> +    u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
>>> +    u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 
>>> 0x1800 */
>>> +    int xcc, vmid;
>>> +
>>> +    if (!amdgpu_trap_is_enabled(adev) ||
>>> +        !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
>>> +        return;
>>> +
>>> +    WARN_ON(!IS_ALIGNED(tba_addr, 256));
>>> +    WARN_ON(!IS_ALIGNED(tma_addr, 256));
>>> +
>>> +    mutex_lock(&adev->srbm_mutex);
>>> +    for_each_inst(xcc, adev->gfx.xcc_mask) {
>>> +        for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid+ 
>>> +) {
>>> +            amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, xcc);
>>> +            WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TBA_LO,
>>> +                     lower_32_bits(tba_addr >> 8));
>>> +            WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TBA_HI,
>>> +                     upper_32_bits(tba_addr >> 8) |
>>> +                     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
>>> +            WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TMA_LO,
>>> +                     lower_32_bits(tma_addr >> 8));
>>> +            WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TMA_HI,
>>> +                     upper_32_bits(tma_addr >> 8));
>>> +        }
>>> +    }
>>> +    /* Reset the VMID selector on every XCC instance. */
>>> +    for_each_inst(xcc, adev->gfx.xcc_mask)
>>> +        amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
>>> +    mutex_unlock(&adev->srbm_mutex);
>>> +}
>>> +
>>>   static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device 
>>> *adev,
>>>                              uint32_t xcc_mask)
>>>   {
>>> @@ -468,6 +504,9 @@ static void 
>>> gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
>>>             hub->vm_cntx_cntl = tmp;
>>>       }
>>> +
>>> +    if (amdgpu_trap_is_enabled(adev))
>>> +        gfxhub_v12_1_program_kernel_trap_tba_tma(adev);
>>>   }
>>>     static void gfxhub_v12_1_xcc_program_invalidation(struct 
>>> amdgpu_device *adev,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/gfxhub_v2_0.c
>>> index 9ea593e2c719..ba2d5d719474 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>>> @@ -22,6 +22,7 @@
>>>    */
>>>     #include "amdgpu.h"
>>> +#include "amdgpu_trap.h"
>>>   #include "gfxhub_v2_0.h"
>>>     #include "gc/gc_10_1_0_offset.h"
>>> @@ -280,6 +281,37 @@ static void 
>>> gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
>>>     }
>>>   +static void
>>> +gfxhub_v2_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
>>> +{
>>> +    u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
>>> +    u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 
>>> 0x1800 */
>>> +    int vmid;
>>> +
>>> +    if (!amdgpu_trap_is_enabled(adev) ||
>>> +        !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
>>> +        return;
>>> +
>>> +    WARN_ON(!IS_ALIGNED(tba_addr, 256));
>>> +    WARN_ON(!IS_ALIGNED(tma_addr, 256));
>>> +
>>> +    mutex_lock(&adev->srbm_mutex);
>>> +    for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
>>> +        amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
>>> +        WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
>>> +                 lower_32_bits(tba_addr >> 8));
>>> +        WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
>>> +                 upper_32_bits(tba_addr >> 8) |
>>> +                 (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
>>> +        WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
>>> +                 lower_32_bits(tma_addr >> 8));
>>> +        WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
>>> +                 upper_32_bits(tma_addr >> 8));
>>> +    }
>>> +    amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
>>> +    mutex_unlock(&adev->srbm_mutex);
>>> +}
>>> +
>>>   static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>>>   {
>>>       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>>> @@ -327,6 +359,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct 
>>> amdgpu_device *adev)
>>>       }
>>>         hub->vm_cntx_cntl = tmp;
>>> +
>>> +    if (amdgpu_trap_is_enabled(adev))
>>> +        gfxhub_v2_0_program_kernel_trap_tba_tma(adev);
>>>   }
>>>     static void gfxhub_v2_0_program_invalidation(struct amdgpu_device 
>>> *adev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/gfxhub_v3_0.c
>>> index 9e6a6e13dec0..204a8817df30 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
>>> @@ -22,6 +22,7 @@
>>>    */
>>>     #include "amdgpu.h"
>>> +#include "amdgpu_trap.h"
>>>   #include "gfxhub_v3_0.h"
>>>     #include "gc/gc_11_0_0_offset.h"
>>> @@ -287,6 +288,37 @@ static void 
>>> gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
>>>     }
>>>   +static void
>>> +gfxhub_v3_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
>>> +{
>>> +    u64 tba_addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
>>> +    u64 tma_addr = tba_addr + AMDGPU_TRAP_TMA_OFFSET;  /* tba_addr + 
>>> 0x1800 */
>>> +    int vmid;
>>> +
>>> +    if (!amdgpu_trap_is_enabled(adev) ||
>>> +        !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
>>> +        return;
>>> +
>>> +    WARN_ON(!IS_ALIGNED(tba_addr, 256));
>>> +    WARN_ON(!IS_ALIGNED(tma_addr, 256));
>>> +
>>> +    mutex_lock(&adev->srbm_mutex);
>>> +    for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
>>> +        amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
>>> +                 lower_32_bits(tba_addr >> 8));
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
>>> +                 upper_32_bits(tba_addr >> 8) |
>>> +                 (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
>>> +                 lower_32_bits(tma_addr >> 8));
>>> +        WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
>>> +                 upper_32_bits(tma_addr >> 8));
>>> +    }
>>> +    amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
>>> +    mutex_unlock(&adev->srbm_mutex);
>>> +}
>>> +
>>>   static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>>>   {
>>>       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>>> @@ -334,6 +366,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct 
>>> amdgpu_device *adev)
>>>       }
>>>         hub->vm_cntx_cntl = tmp;
>>> +
>>> +    if (amdgpu_trap_is_enabled(adev))
>>> +        gfxhub_v3_0_program_kernel_trap_tba_tma(adev);
>>>   }
>>>     static void gfxhub_v3_0_program_invalidation(struct amdgpu_device 
>>> *adev)
>>


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A939C79FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 13:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E921610E18F;
	Wed,  9 Sep 2026 13:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U8zGxGTb";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E77F10E1AB
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 13:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJuQXdULXpvmKfHl9x1cKrM2+LQJfEWJb2HGbb/9iciWk7UAdjtKJG65fINhcMUHIhWe4Lwh+Z6fHX/5N0BiI9cwd3CGlYaDJZd4XHPXARk2XX6B6L4cXMBtYBNl2PgGJ4IpjAvKliCcLm/hpJ5NjX/rlz958lrSsFzbMcRUzXrcO15I32zfpzCLKhRi23Rb9eNzM/w6q8wGqqxFUUvZY2ifmZPDDnkMP84b0JgBR67lGOL3jIk6hDaBDP3oabVetmzorl7mf7tBO48RKWbiGhECSNoPxAXLCZww0poZSwP3j+7ar/HRvgsmdj1OYNapzgUgLsdnPXX6an+449BRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNTx77+yUzUPRnqP/xUzIKewYDYCfIlp/2xwpweiUaM=;
 b=X2t8aLxPsfEYDDjGrFButqYehinZqS3xt8r70z7w5JVMGVi9yQreHD3nyKj4qKbS6mfYp637z06F+0kiHOxVqwq54VkGs1B1NnchguHePZvZbsKM6ZX657XSLTdKyrsZBB1icANv0teAUpNVvciAX1UsdD+NON6nVNmQZSeBeWiKH4UlW6vnNFizZfl9jTSp7mqcV0ZO39YS/dPjZm2O18mG6maYWP8SF9Xaa760wj5NGja9oaXMEl2vznJpK5AHsEmXL+rr63RHNn2raD8wcNgSI2qR2nFA/UYG1uoebODdCnywOdz1/FxkUZz99YRGJ1EpjPYwne1OfXSCE/HN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNTx77+yUzUPRnqP/xUzIKewYDYCfIlp/2xwpweiUaM=;
 b=U8zGxGTbmfBvqu4rzvmRUUomfgC2EdTSL36b9qKTvvjV0kZDx1l/VynGkhP9hI0v3Sau0QAvVJRBDo+cajSWBXpjSUZ0kXGMsSjjtKmlX1cMkmrs+EsN/HiEo6iqoNVk4j8eHba8UDT8K2ugQLIYlVKK7Tv+5OGhdg604ykQkIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH1PR12MB9597.namprd12.prod.outlook.com (2603:10b6:610:2ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Wed, 9 Sep
 2026 13:02:10 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 13:02:09 +0000
Content-Type: multipart/alternative;
 boundary="------------u0WLdkhUR45PjDKDCKu0MrG0"
Message-ID: <b652b617-de17-4e11-9492-ffb003a9e51e@amd.com>
Date: Wed, 9 Sep 2026 18:32:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <hakzsam@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <4f97a5e8-8bef-4353-9998-9e6daee499d2@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <4f97a5e8-8bef-4353-9998-9e6daee499d2@amd.com>
X-ClientProxiedBy: MA5P287CA0352.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::16) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CH1PR12MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdce36c-bcc1-4528-28ad-08df0e728eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|10067099003|18002099003|22082099003|8096899003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: LRVWUUCaP6bgtP6aeAeHAtaQThoMP6Pmbxk1Tfig4C5PKGqELHfssuiHJU8crQgs1/8iQGRsoomLrtBuhiNtyOvvngiWabtQM1pPtygeE4X5RnQ4J0nfnr0/gCbgaeAFWJ+ZLMrXyE+k7p94hmzK27G2TG9niq8oMc0pA4tqKrpkp3SkP/tFBLdBLsksWujSFOfEQGH/y9ChlaDPFDyLMzI/e1zN2TLJUdfqxLPDaHbVnkKGQE7YM4nBCRF9wSzJpkw+g79yikF4LlV6BWSkuhO0rJnMEkZFRBFadhP9GHwWrbgVOMYvPfOge/UEy3WLQgCUqnQykHdbs32BWt0EY/5FKg8akxRn6bFzcZBe8eupU8Q4T6hrpQe6yoOHhIGKG7sr4AZ6gmTN/2rBHtJeqXB05mXSbc6j7XJMxXZfv86LcsybFbokbz7N9OENxxclMUexbUOdxyw9biT6YiFuR6hNIhbyKQozV03ikKjBkQ62cQwI1KlJqduzYkgwAUtTVCRGvgZmzUFNhnNTG37Q+04QVATJN/by4Vrfx8WTKTHstLGKKRhQsOm/z7e1d4pHkmwB045YMmuqNGeynqr3kuUEU2coySitLxHFzQB1P9mnkPKGm0aOf+QhHLc+Wvvq8obdO5N2VzhgxFWJMuZ8y+h/44m60HNrtyzuf8Xoe3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(10067099003)(18002099003)(22082099003)(8096899003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEFGcXc2MFR5cWdjeTlNTXZJd1dMcDQ5Vm1DRGRoclcwOUJ6TlEvMFg2OXhZ?=
 =?utf-8?B?UkNYS000UUhScVpaR2ZrN2gvTWpDTWtwOExZZ2xKVm42T2JPZUFtbmdZRUxs?=
 =?utf-8?B?dStoL3NJZGlrdUN1UElIcndKb1VseUxNaEJCWmc2T0pOZi9sdzI0Zjg2VFJ0?=
 =?utf-8?B?Q0VVUG16WE1jZ094dVlKWGcyTVE3VVY3c1QyOXF4bktNWmJCTjNlR1BqTjBh?=
 =?utf-8?B?aTlUQzN6SmpkNmh0RlQxaUZUVlYxa3ppdzFzUThJTUFLSWhIMnl3V3dQVXRo?=
 =?utf-8?B?V3VZcGdyU2RQNW94dE0yUkJsYlBOS2Y2VGlocmc0ejlZOGtreW5hUVBBNDUx?=
 =?utf-8?B?TmZmM2ROVmRMV1VtcGZCdHlib1RzbGQyWHRhQmR2TzVZMEx0dDdoSEhsTExO?=
 =?utf-8?B?V2h0QlkvSXVrYWJ1b21Jajh6dUtzMHFDRUxSSHRXanhNSUUwR3Q1d25iRzBm?=
 =?utf-8?B?Rnc4L2ZueE1ZYlNDRXA4UTN2cFFQYytlZHFFbWtkWDdmZlZKbEE4a3BIUmhs?=
 =?utf-8?B?a0ZvazZRU2VXNDluWTZPOHM3R09WSmtpWnY0KzJJdjVObmRleUVvaVZTMUF3?=
 =?utf-8?B?SnMvcEJzZnRFMi9wRXRJWWU0YzdESlh5MHRaNVUybTNYN0htbU5DSVZBazN6?=
 =?utf-8?B?eVJXcW5UM3REUXNMVkhaTXArSThPTjcrRjBteVVML1dvRFhzYW5tdEFDR0VX?=
 =?utf-8?B?MktzSURlVWlWRysvWXlEenE4T1dCL1NNTGJkMmoxZ0JVcCtCOGQ4ZWNDTG1z?=
 =?utf-8?B?bmdwZnByV3JiSkUvZ0dqMmlqK2xqbncyVGFiZ1dUSjJpTEdORi9jeUFBQkQ3?=
 =?utf-8?B?WTBpM0FORE90YTlPMENkYVU5SUxUM0JhNmpYZktWQ2VjN0t1WEpZK0JhZEFX?=
 =?utf-8?B?WCtyNjYvWFJ4aUp3dE1lUE5LVnI4dUh0YStGejEycHZxQmpHdURFNldIMVRz?=
 =?utf-8?B?dVBybjNxNWpMV3pobWN4M1Q5TmtsT3F4L2o4YWhXQ2RWNEwwZlpQL2FydHM3?=
 =?utf-8?B?Z1gyVGR6SXo0ZVJ1ajZZby9WVWxYaERPNjBjb3JRRjg1Tll2cDM2aVFsUnEv?=
 =?utf-8?B?K1ZybnVtSGN2cmNPdVNCaEl5UWliaVFEVFBScGJHUDdybUlwTE0rTmp4YVpC?=
 =?utf-8?B?RTdvYUd6dXBJOEQ0TUc4RHNCN3JRQi96Z2JPOUJRUUFYdkhNT2Y5Qk9Nbm5Q?=
 =?utf-8?B?UFg1azVvNkxPS1A4S1dtZkk2cVY5YXF3citmb2kwdUxjall3SzJ1VHZBTGx6?=
 =?utf-8?B?OE9PUGk0OGJGSDcxNTZVNkhqZEVpOGI4SUFvc0xUMUp0MWh3TklCK3pSSlIv?=
 =?utf-8?B?cWI5WUYxQ3prZ1BIWWZhUEkrdW5aL0tnaHA0TU5EZmhybkx0SThVZ2RzbFBy?=
 =?utf-8?B?T3pqY0ptcDgzQzNaenhkbUJuSnl5dTVRSjlmR0RNTUJjMGgxUmY4elJrLzZj?=
 =?utf-8?B?N05wemhlRXR4eTh2d0VqNEtxKzd3bWtOS3p5NXlqZklmajU1anVDN2R5VGgz?=
 =?utf-8?B?Z29rZDQzOTEwOXhodkxnd0hwd1BVMDJkN0RxUVo1ODNkaVlQV3pSWnFMcGRY?=
 =?utf-8?B?SEV4WkRMcXE2czhabWhobXFwb2FCNGgwSmszS2F3bnF4K1RubnZpWGYyakxs?=
 =?utf-8?B?ZFd1SjlWUkhFdkhCMjVwbnM0dVJNd3grY2ZBYVBHNzRKOVlBWFBFT0ZkRUdB?=
 =?utf-8?B?b0xKMlpjVWFlT2JsdThzUHQ3ZERIVCtMYXJLakc5cHIxWWFXSVZQVHBueVZk?=
 =?utf-8?B?Y0VqRVF2dlo5RTMwTHdjaHBlZFkxaTVZVUlzNDYwR2ZxcFhUMFp1Qkp1aFBG?=
 =?utf-8?B?aUp1REtDMnF1RmM1WjgwNmVUSVNyV24yOTFLcTY4NzRaSmExU21nemhhbzdj?=
 =?utf-8?B?MUhpMWJuWWhjU2lRVEFDR3o3Y0tQWlRGUVBRQXcreGVsckI0TUJQRHdVVFZ2?=
 =?utf-8?B?UGVGREQrNnN4RnUvRkQ5Umd3ak8yTTRvZ1lnRzV6aVJwcWE2M1d0bVZtM1Bw?=
 =?utf-8?B?YTlab2YxV3RIYmw4em94cElZRElLL0RmSjRBVVk1OExrdVhPWFJKblliQzdI?=
 =?utf-8?B?bVpmWW9MZnlzVjRLbTZnckg5dzc5akRGTzk3YTI4MVkyL1lnd0lyUTNmaDJu?=
 =?utf-8?B?UUd1aWJoQlltd3ZrYWY4OVJWemh0elFFc3pSMzFjUDMycXJKTUdRWXpyOHhp?=
 =?utf-8?B?bWI0bDZTNXV3QzB1OXpnNGxtcE94dklVTFovM3FwUEJFUERRU3pXVUJjZHhl?=
 =?utf-8?B?QzlHRXRwQStIVVJtQm9EZ1MxOStHcUVJa0crL1paZHJDaHUwRFZlU1FHNEYv?=
 =?utf-8?Q?ks+53xs6PPuQiQQ8xp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdce36c-bcc1-4528-28ad-08df0e728eae
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 13:02:09.7534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEvY1HRl3L/JpVxNloaIS0kMLoh87izeLgA9vVi85H62S37oNy5xImY+WWoSplMlRevcS9H/lQLqYENQPl0Tpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9597
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

--------------u0WLdkhUR45PjDKDCKu0MrG0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/9/2026 1:15 PM, Lazar, Lijo wrote:
>
>
> On 05-Sep-26 1:49 PM, Srinivasan Shanmugam wrote:
>> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
>> SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
>> via ADD_QUEUE with map_legacy_kq=1 but does not set trap handler state.
>> On GFX10 and earlier HWS-based hardware, the driver programs trap
>> registers via SRBM select for KFD queues but no equivalent exists for
>> driver-managed kernel queue VMIDs.
>>
>> Add a vmhub callback program_kernel_trap_vmids() so each gfxhub version
>> can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
>> device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
>> address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its own kq_tma_bo
>> there, so per-VM isolation is handled entirely by page tables without
>> needing to reprogram the register per job or per submission.
>>
>> The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
>> (parallel to page table allocation) and mapped read-only into the GPU VM
>> at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-level
>> handler address into it via kq_tma_map when userspace calls SET_L2_TRAP.
>> The first-level CWSR handler reads this address to chain to the
>> second-level handler when a shader exception fires.
>>
>> This design is:
>>    - Per-VM BO (not device-level) — same model as page tables
>>    - Fixed VA in each VM's address space — same VA, different 
>> physical BO
>>    - Read-only from GPU — kernel CPU updates it via CPU mapping
>>    - Treat allocation/free lifecycle identical to page tables
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>> Cc: Samuel Pitoiset <hakzsam@gmail.com>
>> Cc: Natalie Vock <natalie.vock@gmx.de>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
>>   5 files changed, 110 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index 3ca187f5ade8..5624a5ab5c62 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>>       void (*print_l2_protection_fault_status)(struct amdgpu_device 
>> *adev,
>>                            uint32_t status);
>>       uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t 
>> flush_type);
>> +    void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>>   };
>>     struct amdgpu_vmhub {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> index 623cac6781be..e913488ca3fa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>>         amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>>       adev->trap_info = no_free_ptr(trap_info);
>> +    amdgpu_trap_program_kernel_vmids(adev);
>>         return 0;
>>   }
>> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
>>       adev->trap_info = NULL;
>>   }
>>   +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
>> +{
>> +    struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>> +
>> +    if (!amdgpu_trap_is_enabled(adev))
>> +        return;
>> +    if (!hub->vmhub_funcs || 
>> !hub->vmhub_funcs->program_kernel_trap_vmids)
>> +        return;
>> +
>> +    hub->vmhub_funcs->program_kernel_trap_vmids(adev);
>> +}
>> +
>> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
>> +                struct amdgpu_vm *vm)
>> +{
>> +    void *cpu_addr;
>> +    uint64_t va;
>> +    int r;
>> +
>> +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>> +
>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_bo,
>> +                    NULL, &cpu_addr);
>> +    if (r)
>> +        return r;
>> +
>> +    if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>> +        iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
>> +                      (void __iomem *)cpu_addr);
>> +    else
>> +        iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
>> +
>> +    vm->kq_tma_va = amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
>> +    if (!vm->kq_tma_va) {
>> +        r = -ENOMEM;
>> +        goto err_free_bo;
>> +    }
>> +
>> +    va = AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;
>
> Is this the same address used for mapping of TMA for user queues?

No — these are *different, non-overlapping addresses* in the reserved VA 
region:

  * |AMDGPU_VA_RESERVED_TRAP_UQ_START| = TRAP_START − 12 KiB
    → used for UQ first-level TBA (8 KiB) + TMA (4 KiB)
  * |AMDGPU_VA_RESERVED_TRAP_START| = SEQ64_START − 64 KiB
    → used for KQ per-VM TMA (this patch)

The UQ region sits immediately below the KQ region in the reserved VA
space. No collision between the two mappings in the same VM.

Regards, Srini

--------------u0WLdkhUR45PjDKDCKu0MrG0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/9/2026 1:15 PM, Lazar, Lijo wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4f97a5e8-8bef-4353-9998-9e6daee499d2@amd.com">
      <br>
      <br>
      On 05-Sep-26 1:49 PM, Srinivasan Shanmugam wrote:
      <br>
      <blockquote type="cite">MES owns kernel queue VMIDs
        (1..first_kfd_vmid-1) but does not program
        <br>
        SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel
        queues
        <br>
        via ADD_QUEUE with map_legacy_kq=1 but does not set trap handler
        state.
        <br>
        On GFX10 and earlier HWS-based hardware, the driver programs
        trap
        <br>
        registers via SRBM select for KFD queues but no equivalent
        exists for
        <br>
        driver-managed kernel queue VMIDs.
        <br>
        <br>
        Add a vmhub callback program_kernel_trap_vmids() so each gfxhub
        version
        <br>
        can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to
        the
        <br>
        device-level CWSR ISA BO. The TMA is set to the fixed per-VM
        virtual
        <br>
        address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its own
        kq_tma_bo
        <br>
        there, so per-VM isolation is handled entirely by page tables
        without
        <br>
        needing to reprogram the register per job or per submission.
        <br>
        <br>
        The per-VM kq_tma_bo is a small GTT BO allocated at VM creation
        time
        <br>
        (parallel to page table allocation) and mapped read-only into
        the GPU VM
        <br>
        at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the
        second-level
        <br>
        handler address into it via kq_tma_map when userspace calls
        SET_L2_TRAP.
        <br>
        The first-level CWSR handler reads this address to chain to the
        <br>
        second-level handler when a shader exception fires.
        <br>
        <br>
        This design is:
        <br>
        &nbsp;&nbsp; - Per-VM BO (not device-level) — same model as page tables
        <br>
        &nbsp;&nbsp; - Fixed VA in each VM's address space — same VA, different
        physical BO
        <br>
        &nbsp;&nbsp; - Read-only from GPU — kernel CPU updates it via CPU mapping
        <br>
        &nbsp;&nbsp; - Treat allocation/free lifecycle identical to page tables
        <br>
        <br>
        Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
        <br>
        Suggested-by: Alexander Deucher
        <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
        <br>
        Cc: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>
        <br>
        Cc: Timur Kristóf <a class="moz-txt-link-rfc2396E" href="mailto:timur.kristof@gmail.com">&lt;timur.kristof@gmail.com&gt;</a>
        <br>
        Cc: Samuel Pitoiset <a class="moz-txt-link-rfc2396E" href="mailto:hakzsam@gmail.com">&lt;hakzsam@gmail.com&gt;</a>
        <br>
        Cc: Natalie Vock <a class="moz-txt-link-rfc2396E" href="mailto:natalie.vock@gmx.de">&lt;natalie.vock@gmx.de&gt;</a>
        <br>
        Signed-off-by: Srinivasan Shanmugam
        <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
        <br>
        Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp; |&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80
        ++++++++++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |&nbsp; 7 +++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp; |&nbsp; 9 +++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp; | 13 ++++
        <br>
        &nbsp; 5 files changed, 110 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
        <br>
        index 3ca187f5ade8..5624a5ab5c62 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
        <br>
        @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*print_l2_protection_fault_status)(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t status);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t
        flush_type);
        <br>
        +&nbsp;&nbsp;&nbsp; void (*program_kernel_trap_vmids)(struct amdgpu_device
        *adev);
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; struct amdgpu_vmhub {
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
        <br>
        index 623cac6781be..e913488ca3fa 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
        <br>
        @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device
        *adev)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;trap_info = no_free_ptr(trap_info);
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_trap_program_kernel_vmids(adev);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device
        *adev)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;trap_info = NULL;
        <br>
        &nbsp; }
        <br>
        &nbsp; +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device
        *adev)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_vmhub *hub =
        &amp;adev-&gt;vmhub[AMDGPU_GFXHUB(0)];
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!amdgpu_trap_is_enabled(adev))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +&nbsp;&nbsp;&nbsp; if (!hub-&gt;vmhub_funcs ||
        !hub-&gt;vmhub_funcs-&gt;program_kernel_trap_vmids)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; hub-&gt;vmhub_funcs-&gt;program_kernel_trap_vmids(adev);
        <br>
        +}
        <br>
        +
        <br>
        +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; void *cpu_addr;
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t va;
        <br>
        +&nbsp;&nbsp;&nbsp; int r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; dma_resv_assert_held(vm-&gt;root.bo-&gt;tbo.base.resv);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE,
        PAGE_SIZE,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT,
        &amp;vm-&gt;kq_tma_bo,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, &amp;cpu_addr);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (vm-&gt;kq_tma_bo-&gt;kmap.bo_kmap_type &amp;
        TTM_BO_MAP_IOMEM_MASK)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iosys_map_set_vaddr_iomem(&amp;vm-&gt;kq_tma_map,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void __iomem *)cpu_addr);
        <br>
        +&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iosys_map_set_vaddr(&amp;vm-&gt;kq_tma_map, cpu_addr);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; vm-&gt;kq_tma_va = amdgpu_vm_bo_add(adev, vm,
        vm-&gt;kq_tma_bo);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!vm-&gt;kq_tma_va) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ENOMEM;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_free_bo;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; va = AMDGPU_VA_RESERVED_TRAP_START(adev) &amp;
        AMDGPU_GMC_HOLE_MASK;
        <br>
      </blockquote>
      <br>
      Is this the same address used for mapping of TMA for user queues?
      <br>
    </blockquote>
    <p dir="ltr">No — these are <strong>different, non-overlapping
        addresses</strong> in the reserved VA region:</p>
    <ul dir="ltr">
      <li><code>AMDGPU_VA_RESERVED_TRAP_UQ_START</code> = TRAP_START −
        12 KiB<br>
        → used for UQ first-level TBA (8 KiB) + TMA (4 KiB)</li>
      <li><code>AMDGPU_VA_RESERVED_TRAP_START</code> = SEQ64_START − 64
        KiB<br>
        → used for KQ per-VM TMA (this patch)</li>
    </ul>
    <p dir="ltr">The UQ region sits immediately below the KQ region in
      the reserved VA<br>
      space. No collision between the two mappings in the same VM.</p>
    <p>Regards,&nbsp;Srini</p>
  </body>
</html>

--------------u0WLdkhUR45PjDKDCKu0MrG0--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49862C79FAA
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 07:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFBAA10EF8C;
	Wed,  9 Sep 2026 07:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ltzPBMBC";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C53710EF84
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 07:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3eLqRJeFKdSvSzeAgkxMmjgYtskIYqb7Nf9esrT0/o9evL3F2aIrSoH/GoRqvm1J9Y+6BvEeKJhU2PBYmGiYw+r9qb26AeywVZUOCHfFKS6F5/iVj561A1va7CCriWwbgwGl/E9GTNcf8tlRbqx/iias/V6s6JDKm5lT7zHfOODYQbYw2sIB4PbFkyaOLHQ9Ulonb9oVmiuZF064VGF1q9BKvR1FxdloFtKwIWMWAzJQcAsVSDFj4k0FejSgRDsGjE8lZP9epAovuHZ1vwZ9/52LrB1wz7t9isPshnWd+hb6zPq8dHg5cyj0UdijtGgQ21dKFDpllosjB8bhY9TVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYmhw+FOpGkCOq1UhrNhB0EvNzubpT11BykCFoulMMc=;
 b=cvLlhrnBEuSObuHsdofv9nNgNrejV32HSq8DzpWwLoX/vMlQ555Vu5eQWvh+senQllZTjmK1Q+tmXLBUQeLskQ7zSp7NnhMvajaPrY+HluWBxdGPjEdDb02ZZEWjk8Eo1k9TTptx40NXv0U1CJrnCJxZtM0IXd8/TB0t93ZNmqqAra1DYj0iQhfwDxDlnETVZ5psU0BGlnodL2JwC+jalXV8dBiSNU8psIr8rFNO4KnGLQFVTBdIoxAcPUi6gtJpGKT/b4HE253xYMKZDuNyduyI6TO9Tcumwc3ECdUB/hqb9TzhU4abZm+hjIaJXPL3S/c1R5E7akArO0ffdMU28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYmhw+FOpGkCOq1UhrNhB0EvNzubpT11BykCFoulMMc=;
 b=ltzPBMBCD7EofnnLIrV96GXiwuICCdzyeznHbzyvgFn7mUGxuSzn4b7SGDYZBFKLq4dlsFYPbSzj5zEIj0//vrI7jIc5FMRpOeG0QWWOrJ/0wWwRbOgXq4lTT+9RDZSqBAd6uJcsFO67YjrZw9VsXjmDQVDVaxtRtqdsqYZHMk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 07:45:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 07:45:36 +0000
Message-ID: <4f97a5e8-8bef-4353-9998-9e6daee499d2@amd.com>
Date: Wed, 9 Sep 2026 13:15:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <hakzsam@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bc2329-9610-4d92-fd63-08df0e4655ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2pPlRqsjXJmwRCdXP+2FU8j9RFQatuqwH5Vl2nHi/ekNZjK1CoAxmzmoV9XMqeu9At2ShziP+y4d3xzhuDr8YONuOV9zlBqlAel/jWZ5vsh9F6LV4ZkSxanBRxVSBkgQD50K6GhI6u2mX0K2Ko+Yl/K+Gtw89FktRwsj2+eNQsfcgVDZjvn67jwRjRBDmZ6jDPYeJJXtmUbLFsJNWVAzgU5OL53vX5+65az4k6eaPp2LpRtHQ5jCUfeQVtFFl5RVxZzLFW+gDZR7lojpe7IV1RMTta7TjDACcuUyEjPkNXSoLnsOzdhH7ubIu+Co2lG0Rhw8llAvZR85nkgo4yRAKEabUqby4qQusFQ1C7wRwSxmzC3zLjKkg+FgqAtS3pqpUJfxfzrDrpXw2u6hiC3h3kRJRBd5aYV3J7fksUcG1JjlO/jJtCjlNUQXtyfr/JmBGVoCpEJxkN4NjrfMSe2UBMkA2b5idvQSHK7ZfAf4P0ty2jl15X4lhjHwV88OEp+7PR1G10JwINRiyYMUUIN6oOHQ1LMo6l9mDDlYx8a6PN/qRI1bMu7jIfB5sfcT4VSNQ2nwFkFa6iIOu18rmPLvO8AOZqCmYipeqEI+2BQzNAby4Y6cYWLp+f57/hUWjUMe5+zMfo2gOAQnt4VLFF0PtxbK6m/prqGFE/qIb/lS+xc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3dWYTR6eXdqdEIyMmtKK2tUK2FKWkZWZlRSUU9VUzk5ditDTXM2WXp3a2JP?=
 =?utf-8?B?NFRieFRDQUt6QXBIT2xWblgzbFRMZ25BeHVXdnc0UkRLaW50c041Zkg0UFdW?=
 =?utf-8?B?SGw1ckVyeHZwWGNEeDdyZ1Z5RVFPUGVjT2dtd3AwenBHUlJiUi9lMjQ3Tll0?=
 =?utf-8?B?NUIwMmtXM3NGUDVreDluTnZhaWNDUllIb1FNdWlqa1p5ZGZmOTkwNFpwejZK?=
 =?utf-8?B?bjNvaUlVWTVpZ3JmSVYzODg1RkVzaGhVWElZVlV1UW0rek43a2VuOWYrQzlE?=
 =?utf-8?B?RDdqbHBrUkNUc0hmZFdORE94S25MQVZXb1VXaU1Cb2Q1WXd2Z2E2RDVrZ2VM?=
 =?utf-8?B?aEZ4VEMxNm1abkNRTzFBcVVEd2kzWlNqcUd5Y1FvWjh5ejYxbU9uYWNCSXZn?=
 =?utf-8?B?dTRlb2F2WFJsSXB3SVdpeFdKc2RWUFN0UFJxR3NFWitZUkpRS1c1ZnRtL0lT?=
 =?utf-8?B?VlhYUGVlMDBhQ2F4YzMyblZkamczRUF0czVMa09HN21ZVDdXMFJaSTBPMHB5?=
 =?utf-8?B?MFRXQ0MxbEZVbUUxSStqb3JQWnZOOTE5UkRHUU9DUWloZEdEMkE5RTBCQWVR?=
 =?utf-8?B?UW5mK0REb0JWOWU5OW14VU5TL2ZlanZhNUd6SU1HR0xab3F5WnVVRGdnWXJk?=
 =?utf-8?B?VzdGZjhsOFhocFVNTDdCakYzOE1WeFd0alZPOWpacFlPMmxFRERkZWZueXUy?=
 =?utf-8?B?MktSVVFRQUY5UUtVT0dqUld5V2xDZkxrYkF0aEcyM05IbTNXdC9Pc3RYUGtq?=
 =?utf-8?B?R1F0RUZDTVhDQjFtZHVBUzZic1JGZTE0M0liUlpTSjVmVmNMTUxtY2JnOXh3?=
 =?utf-8?B?aHpwb016eXFDWmZiNU1HbFlFWEtjOFVuOWJlQWtVQ3Q0VWRVekZYcXhnK0Z5?=
 =?utf-8?B?U0wvN01iKzVvY3VRU3htN0Y1cnF4OVpyWnBxTVVvWWNSMG4weUpMbjhsQzJY?=
 =?utf-8?B?MzVhdHVUMTJRVkNLY1ZhTlV5WEYxazVhMGl2VzJEZjJYY3VvU0dxODhqOXhi?=
 =?utf-8?B?S3BsNUJpRFVnUk1mU2xPVnFTVnp1alNQOWJ6N3VyeGYyRHZFSjJsNXJuS0Rj?=
 =?utf-8?B?cEppMi9LNTFOTWUxZEJlc25FTHFEUlZxTlJUazFpSis2Zm1KNVZ5UTlVK0RZ?=
 =?utf-8?B?THZtRDNBRVo2RytNMGE5SHUzdUdTUWsxNXZHMHZHT2IyczdRS09BSHJERzIz?=
 =?utf-8?B?YkZXZkNoUjBpdDNRUzV2ZnRCcjVGdFk3cjlkeVVDM0s0b2ROVzJ2STZPeWhx?=
 =?utf-8?B?MGJFV2xaRkhIMGp1V1RwRkNqYi9INXhtdjludVNKM0tPV1psanBzRU1NdFY2?=
 =?utf-8?B?bGppU1VBVHh2RjAxeElCSTltZzBYb1hZQ3lNc0UxM2ptbW9hSkdpMVJiR2to?=
 =?utf-8?B?dFZaUkorckpQa0UxSFBDcndaejVmdW9uV0NMTlhzOGpRcU5NamdobVQ5U3Zq?=
 =?utf-8?B?Q1h0RTRLcWxOZU9DZ2Q4cERVR0pCZnI4ZFNqVjNaRFl0cHJLTXlGNDA4Ly8v?=
 =?utf-8?B?eGkxNk9scWcyRm00bk9VOHZaeWN1VC9iUFNraG9hcC80RHFYU1RoYXFIN0JG?=
 =?utf-8?B?RzhRWVZ1by9DTk9RQVpSMVArS09BWmR0NTJtM05VYWZHMVBWWWRIQm5ZVjNU?=
 =?utf-8?B?NGhzZXk4T0dMOTJ6YmJnZzhPZ0RhbDVzd0F1UjdZVjRFc2VGQ1UvYTlGQU9l?=
 =?utf-8?B?ZHlmMjFhVjRYSUtDU2FaMUZGaURFYzBRZzlRY1F0bEVTL0tieG10UXdZV3cv?=
 =?utf-8?B?a3k1SkdiK2VXVXdlYWRKZFEvQlRxeTgraVIzcDRjeUFoWlJyMDYycmxLLy9R?=
 =?utf-8?B?NGtpQStUVEFiRThLdGZVRkxDMTJaMFI3eitYMFBzMWRadi91ekVBcS94b3E1?=
 =?utf-8?B?RWdqYXNveGJCeVgyVU9XcmJJQlRwVkJMWEwxYllBNEFheit6OXl3UW43K0lG?=
 =?utf-8?B?ZElqQ3NKWXdPZXByU04zQkp2RVdCWVgrbGRONTNjR3VmT1E4LzhGV1dydjVJ?=
 =?utf-8?B?VjFsYWxwSWMyRDYyanp3VXU1eFJVc05UVUk4TWluRHN1TFRMSnJTS3p4cmY1?=
 =?utf-8?B?eWlENUhwd0tQY2ZtVmRVWXkwVjZHaGt6WGhLMElTTmF1TXF0eGpnOWZ5YUxr?=
 =?utf-8?B?RUZUamxEVUtEZkxnaXA1WGtIcEtMRzBXSTFiditDblNJWUNLV0V2aGFaUlNB?=
 =?utf-8?B?U0k5T1puSjhZaE9PWjJrK3VKcVhRbUdsbFQxZUNzcWdnVHZtM1RlNHkySkdi?=
 =?utf-8?B?Y3g1UkdqTFl0aERXNmE2WFlQODlqY0VDQWh1QVZKUUpqMTMyd2t3MDBRNTNE?=
 =?utf-8?Q?PQb2ZW7jK7hgdSxJ/1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bc2329-9610-4d92-fd63-08df0e4655ac
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 07:45:36.1652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXe2nQtSMT4+lp+ssdumeil4FZeAUve4iuNqjbDalPJ1Dqz/Xx8VCEEJAJLfDkmW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746
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



On 05-Sep-26 1:49 PM, Srinivasan Shanmugam wrote:
> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
> SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
> via ADD_QUEUE with map_legacy_kq=1 but does not set trap handler state.
> On GFX10 and earlier HWS-based hardware, the driver programs trap
> registers via SRBM select for KFD queues but no equivalent exists for
> driver-managed kernel queue VMIDs.
> 
> Add a vmhub callback program_kernel_trap_vmids() so each gfxhub version
> can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
> device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
> address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its own kq_tma_bo
> there, so per-VM isolation is handled entirely by page tables without
> needing to reprogram the register per job or per submission.
> 
> The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
> (parallel to page table allocation) and mapped read-only into the GPU VM
> at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-level
> handler address into it via kq_tma_map when userspace calls SET_L2_TRAP.
> The first-level CWSR handler reads this address to chain to the
> second-level handler when a shader exception fires.
> 
> This design is:
>    - Per-VM BO (not device-level) — same model as page tables
>    - Fixed VA in each VM's address space — same VA, different physical BO
>    - Read-only from GPU — kernel CPU updates it via CPU mapping
>    - Treat allocation/free lifecycle identical to page tables
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
>   5 files changed, 110 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 3ca187f5ade8..5624a5ab5c62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>   	void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
>   						 uint32_t status);
>   	uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_type);
> +	void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>   };
>   
>   struct amdgpu_vmhub {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 623cac6781be..e913488ca3fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>   
>   	amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>   	adev->trap_info = no_free_ptr(trap_info);
> +	amdgpu_trap_program_kernel_vmids(adev);
>   
>   	return 0;
>   }
> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
>   	adev->trap_info = NULL;
>   }
>   
> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> +
> +	if (!amdgpu_trap_is_enabled(adev))
> +		return;
> +	if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap_vmids)
> +		return;
> +
> +	hub->vmhub_funcs->program_kernel_trap_vmids(adev);
> +}
> +
> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
> +				struct amdgpu_vm *vm)
> +{
> +	void *cpu_addr;
> +	uint64_t va;
> +	int r;
> +
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +
> +	r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_bo,
> +				    NULL, &cpu_addr);
> +	if (r)
> +		return r;
> +
> +	if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> +		iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
> +					  (void __iomem *)cpu_addr);
> +	else
> +		iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
> +
> +	vm->kq_tma_va = amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
> +	if (!vm->kq_tma_va) {
> +		r = -ENOMEM;
> +		goto err_free_bo;
> +	}
> +
> +	va = AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;

Is this the same address used for mapping of TMA for user queues?

Thanks,
Lijo

> +	r = amdgpu_vm_bo_map(adev, vm->kq_tma_va, va, 0,
> +			     AMDGPU_GPU_PAGE_SIZE,
> +			     AMDGPU_VM_PAGE_READABLE);
> +	if (r)
> +		goto err_del_va;
> +
> +	r = amdgpu_vm_bo_update(adev, vm->kq_tma_va, false);
> +	if (r)
> +		goto err_del_va;
> +
> +	return 0;
> +
> +err_del_va:
> +	amdgpu_vm_bo_del(adev, vm->kq_tma_va);
> +	vm->kq_tma_va = NULL;
> +err_free_bo:
> +	amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
> +	return r;
> +}
> +
> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
> +				struct amdgpu_vm *vm)
> +{
> +	uint64_t va;
> +
> +	if (!vm->kq_tma_bo)
> +		return;
> +
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +
> +	if (vm->kq_tma_va) {
> +		va = AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;
> +		amdgpu_vm_bo_unmap(adev, vm->kq_tma_va, va);
> +		amdgpu_vm_bo_del(adev, vm->kq_tma_va);
> +		vm->kq_tma_va = NULL;
> +	}
> +	amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
> +}
> +
>   static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>   				  struct amdgpu_vm *vm,
>   				  struct amdgpu_trap_obj *cwsr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> index 7f83174a4742..9be5035abd1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -155,4 +155,11 @@ int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
>   				    struct amdgpu_trap_obj *cwsr_obj,
>   				    bool enabled);
>   
> +/* Kernel queue trap handler — per-VM TMA and register programming */
> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
> +int  amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
> +				 struct amdgpu_vm *vm);
> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
> +				struct amdgpu_vm *vm);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index de3ef9ce2234..f5e228d4bfb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2640,6 +2640,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto error_free_root;
>   
> +	if (amdgpu_trap_is_enabled(adev)) {
> +		r = amdgpu_trap_vm_kq_tma_alloc(adev, vm);
> +		if (r)
> +			goto error_free_root;
> +	}
> +
>   	r = amdgpu_vm_create_task_info(vm);
>   	if (r)
>   		dev_dbg(adev->dev, "Failed to create task info for VM\n");
> @@ -2774,6 +2780,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>   	}
>   
> +	if (vm->kq_tma_bo)
> +		amdgpu_trap_vm_kq_tma_free(adev, vm);
> +
>   	amdgpu_vm_pt_free_root(adev, vm);
>   	amdgpu_bo_unreserve(root);
>   	amdgpu_bo_unref(&root);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index dd825e179979..064f95a83790 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -25,6 +25,7 @@
>   #define __AMDGPU_VM_H__
>   
>   #include <linux/idr.h>
> +#include <linux/iosys-map.h>
>   #include <linux/kfifo.h>
>   #include <linux/rbtree.h>
>   #include <drm/gpu_scheduler.h>
> @@ -488,6 +489,18 @@ struct amdgpu_vm {
>   
>   	/* cached fault info */
>   	struct amdgpu_vm_fault_info fault_info;
> +
> +	/*
> +	 * Per-VM kernel queue first-level TMA BO.
> +	 * Allocated at VM init, freed at VM fini — same lifecycle as page tables.
> +	 * Mapped read-only at AMDGPU_VA_RESERVED_TRAP_START in the GPU VM.
> +	 * SQ_SHADER_TMA for all kernel VMIDs points to this fixed VA; per-VM
> +	 * isolation is via page tables mapping different physical BOs there.
> +	 * CPU kernel writes second-level handler address via kq_tma_map.
> +	 */
> +	struct amdgpu_bo	*kq_tma_bo;
> +	struct amdgpu_bo_va	*kq_tma_va;
> +	struct iosys_map	 kq_tma_map;
>   };
>   
>   struct amdgpu_vm_manager {


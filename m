Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86241C624D4
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 15:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF3510F276;
	Wed,  2 Sep 2026 15:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yeXiwRmP";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBEF10F276
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 15:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3jgyhYXMdHeLG8eCs8XVQ6ObdenO0OHiQe510eVzzaaMgc5KjUkjgSeiMTCMjIu5r94il+UcdBNVhNpKoE02+gwVV1dVadixrz7G3ZTN9SCQqsaqd/ZpguUBEFePiycfjU75pM85sYtVoVGxlyULsUAaOH7yFpwJGu5V61Eg9+FpPwyBcsIMr4FaiYM50YLrqLu7EkxmU9hZQGOZDPL7nIi7U1HeGy7gTJNIEWjghZ9utXlcy67aNS/uK1OkWAJN0YPllPBcqBnCIaR/anUT3zO8DWJ5xRsE6TdExWJCTbnBHFW+81UgeTMOjUmxhKqRi3IEYooSL0HMYERDJHWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/9/gnQ7MuFqCcJf9b3XCLH2Pd5jn0UOf0xHQIWTV5g=;
 b=CQ3rh6UvIUAAnIEf+SlBXHPpW0vjvyPIl7zp+6V+QaU2b3a1Hu16JAW1yX+NPnjBVUSYSY3dKBoSG8GEFxQxNxCpUqlu6LiuD2IbxNY+A+ER678NsZnCSMK4UeZ6CPueFV0pXiJZd8GoYt3ReQ3vhj4HOLvP32Wr7ywO6pz0YJNKW/YwXfYmHY0DqTVUlL4P2WbFoHNcUs+l+DNTaTJV3Nz/dge4ZR+ard6wpqi7GEKrhuHz5gpURxAhfOl0jFq8ElY1KKyGZu41f0apdWDOhqFlh3IARa8CR+HPQVQYCuGz7C0Q3xI+9I3ssLC/r2DlRuDZlLM8HSa/96mmJ1Laxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/9/gnQ7MuFqCcJf9b3XCLH2Pd5jn0UOf0xHQIWTV5g=;
 b=yeXiwRmPaXs223Hq3YRjuU2D+jdAMOYedutho+bCxfTtRuzykqDpIqSfTgYCTF7WzMiNjzh/cQwdo7OXdWQMdnCVIgk2OzpfigZAdk3Effdb7mz2jSbUsjBsoT4Z1NtvM6RCur689VI/LACfMcfNGVSSCcRvUaiahDWd2EUyaRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 15:29:04 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 15:29:04 +0000
Message-ID: <ae477cda-c0be-4a26-8aa4-95a836500e7c@amd.com>
Date: Wed, 2 Sep 2026 20:58:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
 infrastructure
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260902150656.183333-1-srinivasan.shanmugam@amd.com>
 <20260902150656.183333-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260902150656.183333-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0191.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db18850-96db-49e4-9830-08df0906ec15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9ecpjcwvGlTx3xBbw8iWa/IuFZ9bPLnMVVOeLz82622BJvQLIbr0oaw1nrxMiHUgpfGaAcHUplKTtiRL5mro02SntouLNbTUogJJ5s1UzP4lFd4a/AqTJwh2xlYuw7Lzrv6IXoDWj815CZ2HdAKTUaADPVbodYiCYwN+CBvQR9Yygvb74la1nzdluzkq8zmuAlnNjWAgYMOqc+w4BTEhS1iiRmcKg0/xBzklhzqH5x0rz6OXbxy5mfGuzjqtTYu8tRyb35Q6eOUcThde477Pl9TBUhV27oKWo/wBlnIszOIIdi8K/F3dOAwhc6awd/N7DxXQAGDAUFI8fHLXunZDCv/6Y3mxBtTBHEyI3ZqJhWE0gdZ7VyYzJyx7jl8zfcctXa0kp3OCUW+G7967BsroqTwBAWb98sYNHOZCoErtAE63BAXKBIrF16E8gTbg0kNdv8RVbL/5ps5eufj4JHMD7Uf/TPbBR7c/pBbPrit6RtfZATrtt2b+s+OkbXpuUQeuaBz+fFixqSQwTJGR35SqSott55Owe7clmYiVQFDSkqKwaz6O5K0+9p5dugB39dZKJYCkPgug4HmzVxHXL0gyzIF9/XvCtlDs24m+LI2pea2djK71LeBXVDM+VLBABl0m+Djs/89pJm6pSACZ7xqUEyoaBDqkES404ShDmfRlQtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVIyQlYwSFdXS05wWVdxdHcwVGlMSjRhMzVBN21uRlNHekxqUERTRnVBQUV4?=
 =?utf-8?B?SEVsaDhxZVdJT1M0cExUWitVL3Nvb3hnMjZuSmhGMkR0aGdNM1BBdFZjNkZK?=
 =?utf-8?B?RSsxVGxlYmdRRTI5SzIwekJsMjJXa2xzdkFVRitrSGprcTh2U2E5RTBiRDFi?=
 =?utf-8?B?cDRtUUQvWmgyQ0dvYTJEVm9GbDJIejNIVmRKV29JWWxkaEk3dWxrQnRwU2R3?=
 =?utf-8?B?VVJyVjAzZzRYZ0kwWGN3K1pYekl1MEhxaElYWXdEUjQ1dlJWSEdKRS8wOW5o?=
 =?utf-8?B?ZDZqVHQ5V0NxcEpLeUVIT3hhME5vM28xVGtQZHZ0UGNUb296SXpBQTlHQ0Yy?=
 =?utf-8?B?RFM2dHZBb1ZTV0FyTjcrdnVqUS9ZZldYS2VjaFR1RHRiclFlSkpOb042bWJF?=
 =?utf-8?B?eWUwTU1TN3pRdU0vYXk5RUg0R0dPa2N3cm1GWEJJUjJnYW5vR1BSbVhXVGNu?=
 =?utf-8?B?dmJkZi9pNWtiRFZHbFZQZ2Eyci9nT213YjY3bW12QmE5MWJKS2gyejFHT01n?=
 =?utf-8?B?aVloZVo2ZDQraHI2amhMeEF0OXBEc0tNcFVSVDRSajZVUGdhR3RSTUlRbXZL?=
 =?utf-8?B?Rkh0NDVNWFR4eXg3MXFlcHpYMGZNTXRTdUxCQmhvaklJWEdpRmJKcjg4b0Ri?=
 =?utf-8?B?c3J1Qm1QbHBiZnFJMTh5TUJ4NisyUTk3WXVIYXFjRVM2Ung2UFQ4V0UzOEdo?=
 =?utf-8?B?ZTBHeURzTVpjUEFwQVdFaWl2VWhoajcyQVM1K2pjdFBZUDhiMEhybVRFcHNn?=
 =?utf-8?B?TXVpdDFJbStmaUNTVTI4d0NIWVlCQnlTcFhVVGgxS3luVjB6TXJmSlJHMnRI?=
 =?utf-8?B?VkZvMGtXNjQxR2oxamxrME0vRk92Vit6NXdFNTB4UWdlZE9qQ2l6bExoOERp?=
 =?utf-8?B?Z29zZ1JMT3BXNkdNM3BtUFU2SnVmcVBlWTJRYnJRWmtwSnF2SkhVeUwxR3c4?=
 =?utf-8?B?cm5VWUdLSThVNnBkWE1LT2ptLzgwSmV2SkZYZGt0WnY2ckNFR1NOUnpCSVp2?=
 =?utf-8?B?M1RmSzR0NFE2VmJkTWo5V2xrUWw0dFdUSmtiNVpOSTE4ZW9kRUZXMzhkTWhp?=
 =?utf-8?B?OGJVSXBtU3A5SmR2amhQMHh6d1Y4MUF2Yit5SUJFazlObExlMUwrWllIZzBq?=
 =?utf-8?B?WnkvdEVBOGhUMHNuWHhZSkRaa1hsY2FSdVphVmVtSmNDN05Na29oN1BSMGFj?=
 =?utf-8?B?Qk1lRkhnOTBoaEN3QnNGQU5uTC8ybnJLZWdkUE1RVXVSZEFUdTRRU3Q1K1pv?=
 =?utf-8?B?UXl4L3RvcDZTaU01ZGdFZ2FyY3Z0b3A3ZWZLZmJKVFBDREFBdWkxNXpsTHZw?=
 =?utf-8?B?bkRZazFHOStaYVlPeGlaY1ZISS9xYUxHcSsyeVZRV3g2ZW1lYmxUQjVlUmtt?=
 =?utf-8?B?NEhGVkdTekJWRXVVVUZWanhDWXJtem16OS9qZW45bHVIVGV3Vy8rRkVNVUYx?=
 =?utf-8?B?VDg4aXJBZlpyZ1JCSGtPdVN1ekRHSy9zeUtwMENQRGR3K1VBczQ3aE0xaVFu?=
 =?utf-8?B?ajliVnlOeHNhTlUwMjBIN1ZvdHBlVitlUlAvaTV6a3hCQkhaOG1jTVFUMFNj?=
 =?utf-8?B?SXh0U0RxK0drajZSVWZUN1lVS0dyUm1JV01kTTdBRU5Sa2FNc1lKcGVEUUNr?=
 =?utf-8?B?RG5ObGVxUDdLWXF1VU5pYkhSdXozVTNaQVFyNExxajR6NkZJQWU2a3Y5VHBK?=
 =?utf-8?B?aEtFTTdIa21uUEZUalZmNFJUeE9ESEFoajdqdE1yak5XblpwQWMydTBXcnVK?=
 =?utf-8?B?clVUNEtLM25uUjZCa2NuTDJvLzZBS0lWeUtCSlNDTEMxU1RYOW9IaDRyM0x0?=
 =?utf-8?B?TFcxWjlmYUlGM3lmSTFPYmRHYjVUMDVhRS80cGRkcWVDOEZwMkRwa3NaWGpJ?=
 =?utf-8?B?cGU1K1dWZnR2Sm9vSjFkQ0gzL0lGemR6SlpmMG9ERm1Rb1JualdKaWIrNnZT?=
 =?utf-8?B?cG1PTm9oa09oaUNjZGRXMWZqRThjVWdTTXZCK0MxS2ZiY0xHQTV0dnQ2Q1Fl?=
 =?utf-8?B?d1RKNWJwWFVBNmhTSnkvRG9rQmdlRThybUorNFY5c1ZJWkpvSFlFdGNCbld4?=
 =?utf-8?B?NUtjYTdkVTh4aWMrUjJxYWIvTXIzUUkyRVNTSEt1SFNVSnhnRVZTejFRZHpQ?=
 =?utf-8?B?RUVhT2h5dGl2a2wwc1JMSmRVQkJJWkJwREFlakRwbWx3WlRNTEd4WUd5bnRT?=
 =?utf-8?B?Z0I3ZzVYKzJIOEZLaUdVb2VucyszeTc0NzJGdWo3MUZuK0pwbXRLaWNKSkFY?=
 =?utf-8?B?MFBtOTFSNjFOVXZ1TmQxSHNHbEZTdEVZb3plcmhPd2dhVGpGV3ArQjhubUJr?=
 =?utf-8?B?bk9qYlFpdFRNeXUyZEZRdG1IbDRVNDFtRTRXZ2FJTDRidzR1cGN6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db18850-96db-49e4-9830-08df0906ec15
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:29:04.6430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lOAfvotybPv5araeHrJpIpRfF/MDjD/GVsch6nilzl5tijeZBeaAWFF+df/95PU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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



On 02-Sep-26 8:36 PM, Srinivasan Shanmugam wrote:
> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
> SQ_SHADER_TBA/TMA registers for them. Add infrastructure to let the
> driver program the first-level CWSR trap handler for these VMIDs directly
> via SRBM select.
> 
> Add kq_tma_bo — a pinned GTT BO used as device-level TMA scratch for
> kernel queue VMIDs. Unlike per-process TMA (created in amdgpu_trap_alloc),
> this is device-level and lives for the lifetime of the device. It is
> zero-initialized by the OS: the second-level handler address is 0 until
> userspace calls SET_L2_TRAP.
> 
> Add amdgpu_trap_program_kernel_vmids() which dispatches to a per-HW
> vmhub callback, and a new program_kernel_trap_vmids hook in
> amdgpu_vmhub_funcs for per-GFX-generation register writes.
> 
> Required for:
>    - RADV graphics debugging on Vega/Navi/Steam Deck (Valve request)
>    - Consistent trap handler behavior when switching between kernel
>      queues and user queues
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: Alexander Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I0709e788835b69d3d492864de8d5c2d36d0f08c8
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 37 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  2 ++
>   3 files changed, 40 insertions(+)
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
> index 31f653ec3fb1..0e0aeea0aa2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -256,8 +256,23 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>   
>   	memcpy(ptr, trap_info->isa_buf, trap_info->isa_sz);
>   
> +	/*
> +	 * Device-level TMA for kernel queue VMIDs. Pinned GTT — not subject
> +	 * to eviction. Zero-initialized by OS: second-level handler address
> +	 * is 0 until userspace calls SET_L2_TRAP.

How is the exclusivity maintained as a user app doesn't 'own' kernel 
queue? How is the conflict of different user apps trying to install 
their own second level handler on a kernel queue handled?

Thanks,
Lijo

> +	 */
> +	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT,
> +				    &trap_info->kq_tma_bo, NULL, NULL);
> +	if (r) {
> +		/* isa_bo freed explicitly; trap_info struct freed by __free */
> +		amdgpu_bo_free_kernel(&trap_info->isa_bo, NULL, NULL);
> +		return r;
> +	}
> +
>   	amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>   	adev->trap_info = no_free_ptr(trap_info);
> +	amdgpu_trap_program_kernel_vmids(adev);
>   
>   	return 0;
>   }
> @@ -267,11 +282,33 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
>   	if (!amdgpu_trap_is_enabled(adev))
>   		return;
>   
> +	amdgpu_bo_free_kernel(&adev->trap_info->kq_tma_bo, NULL, NULL);
>   	amdgpu_bo_free_kernel(&adev->trap_info->isa_bo, NULL, NULL);
>   	kfree(adev->trap_info);
>   	adev->trap_info = NULL;
>   }
>   
> +/**
> + * amdgpu_trap_program_kernel_vmids - program first-level trap handler for
> + *                                    kernel queue VMIDs
> + * @adev: amdgpu device pointer
> + *
> + * Programs SQ_SHADER_TBA/TMA for kernel queue VMIDs (1..first_kfd_vmid-1)
> + * via SRBM select. MES owns these VMIDs but does not program trap handler
> + * state. Called after trap init and on GPU resume via setup_vmid_config.
> + */
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
>   /*
>    * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
>    * it maps virtual address amdgpu_trap_tba_vaddr() to this VM, and each
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> index 6d4664469bad..326910f1d94d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -48,6 +48,7 @@ struct amdgpu_trap_obj {
>   struct amdgpu_trap_info {
>   	/* cwsr isa */
>   	struct amdgpu_bo *isa_bo;
> +	struct amdgpu_bo *kq_tma_bo;	/* pinned GTT, device-level TMA for kernel queue VMIDs */
>   	const void *isa_buf;
>   	uint32_t isa_sz;
>   	/* cwsr size info per XCC*/
> @@ -70,6 +71,7 @@ struct amdgpu_trap_usr_addr {
>   };
>   
>   int amdgpu_trap_init(struct amdgpu_device *adev);
> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
>   void amdgpu_trap_fini(struct amdgpu_device *adev);
>   
>   int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA53CD8CA8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 11:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549CB10E096;
	Tue,  9 Jun 2026 11:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w4D5/pLD";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D784110E096
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 11:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiIdWVvrghpFpgWmkUPaoIBEjYXjwwvQ1ql8v+kjvvobqrdeXW7R4kHF3RjqNPPEuPI32blGaVmzKQ6ey0VdpelV9sTKcS/AjYOkkFBsIQ5UmfDFU2XOjo/eyZANuSBOfglcl66xZR9ULMX9fGzhXfYw+08Lyyel3d+PLyg1KDxvGH0RpVJi56fGP6WhmY84Nj5T7WZUW8NLSBgY5gGgcOJ7h0NE2t6nEys6c44jyWIoR+JGRxiSYSZcHmlWOQkiuZ3EASR6yyfO0wF26qZovveejCTZFD1y/mErQ83xt+wG7Zxf6FbW9Ztpu+DJDZV1eMCuOzw9Jc9gHNSYRN+UVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riE0IZtzsXwoVXRZARqV8E5s5PRGtjo6GwS7lgGm+JU=;
 b=AQ6iLiWdtiwJeGfCifZ2QqCGMKyNZzKv+edCYh/rioWtIeG0lMSyMLs5TU8stPL2IOnHulgE059P4sfJLLzUw5RGRyHyt183+T+skye/sBwrye39IOG2pI7ASm5w/zPF9j0QCOCT+dA8Hy6BTZ1TqKGWGZOUHV+AXW5WdGEKhOCYzpBuOONCKr03Bv28WE5eWHfqODfejNAdVyB/Wjs4ZQ8OcyHBeFd+uRaJqiUf+pvi/Ns596t8cGD1H1amW4B3V8ttweaQoWH5Wx2S/VgcoQoWn4t27l16CX5vuEG5Whs6gK5Rg49V/H/R/8xI0XB9YY7rxQz0KI+7v/j1kiFXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riE0IZtzsXwoVXRZARqV8E5s5PRGtjo6GwS7lgGm+JU=;
 b=w4D5/pLDiIONFyAhHtkaikf64xDGg2hnpZIn4Z2mTZZPQF/yWVIJIyGyKuPONJPNAQTgIpqsEgkMYIlM6rkgObRGcjSq2vWZek0TCHWYCir9+NLns6BFkzOjtBVyh1BqR3QmjPn3ZSLRHHF21nPJMgPRRNTh4FbgGS3zKmBwBF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA6PR12MB999202.namprd12.prod.outlook.com (2603:10b6:806:450::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 9 Jun 2026
 11:00:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 11:00:11 +0000
Message-ID: <23c97289-7744-45e1-b885-adc9135aca44@amd.com>
Date: Tue, 9 Jun 2026 13:00:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] drm/amdgpu: move amdgpu_acpi helpers into new
 header
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
 <20260608194741.1590055-8-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608194741.1590055-8-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0454.namprd03.prod.outlook.com
 (2603:10b6:408:139::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA6PR12MB999202:EE_
X-MS-Office365-Filtering-Correlation-Id: f2896670-2618-42e9-6e9e-08dec6164686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|22082099003|18002099003|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 4u+genmn77KiOxGLp4i+YZNPL7MaEuWXkBukp/Cf9gzCbSjC6HN7X3ZqYR1b6vRNz+M8fS9qvGxh3ackacH5wkfsVFRUz1tdU7JCYg1a09fm6505RrwVq0jdpFExB7JOue3ErWis07nLVMfeyAHt6Sg/LkrQocUfvu4PyJtDOZtvwo0d8/GZU82bpZAcZm4MOS0YfG3RhqT6Z6xtzkSW5dlNoHisW2oqPa7IHcZp+qTNGN8MP3OwG66WCcohGrkF13qPwYkiWOWohmtt91UcXRhob3iTc3rQf0OmfXJlg+rT/tAMYOPIIHS6xnydzUIRppVCqSE28huUFVcIB518jCGGA3UaNjVeyZcjZ6eu9ixGrPpYTnJaEDIKX7brjk4yeMOYwHoAQwS+dxtJH/ceUXMlL6Vb8mowujRuUGIUUksWz/p1CaOPsRxjsYMb5wbE3sC5NS8KEzqPCcJAYCRia7xoiGsG9gbcQB43KBnuFnSTa++eI8Aw5KVLHc82vBSGFeBI58dxN8vJozTOPgOhZLzEu3GoN4WRKAWrKi53FeULpIBhAfchCE3hAppjuOcrr+aGOX2BoOfoBlkXGPIFiYcTY60FEdF4sMiiEb+nic0IgkAtKandZqgsRjy3jh7v6t5jnAWmzfsh6dPtZCnSzzctH46qX//TDnm6BajcLysf8NVxdz5zSAx5EizWGt0Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZQMWNDR0treUxYT3RDVGNmUElSVExVOEtsc010N2llNUxkRmVuMzUwZkd6?=
 =?utf-8?B?Mk5pcitHcU4zaG5STFNEM205RnozYUJpZjEvd2t4L2ZCVmRQbVZwNHZnN0VM?=
 =?utf-8?B?dmtMbGNIandUTDQwT1dlRjh0cWJzWHZRYUZGMlVPQldGK2RGKy80WEw5b0Vo?=
 =?utf-8?B?WWt2UVh6RHNLZy9jUTNQQzF4d3NXZlZuOGlGTVBsZ0NhdCs1VVJjRXk5U2hP?=
 =?utf-8?B?YWd3WUx5L09uYWo0Y3FackZEMlFnUlRtTnFPVUNvK3FLeUI1UWVCWGg3d0d5?=
 =?utf-8?B?WGdlNGhraHBNTVd5MkhoZ1plRGZ2OVBFd1ptUkVHMk1aUGk2RUVXZG0xeTNv?=
 =?utf-8?B?ZkFtWmVYdytGYWpNUWxEakRnNlFYaCtRcURXSCtzUW1SYllMaXlYMWFrNEV2?=
 =?utf-8?B?VVgxQ2JucCtYWDFzUHVSWlMwMThVTEJwSmRaRWdUdVRFMmxxVXV2bXdDSVlH?=
 =?utf-8?B?K2QzWEV0SmZkNVRUazhvWVNpNUpMbVcrekVKajhoUzJzYUxTWkRpdXpjZDhP?=
 =?utf-8?B?M1ZucTVWcHp1YVhpakRCZFZoc0lFSjZJd3JFSGVrd3pRMU9SRFdyMmlSOVRK?=
 =?utf-8?B?cWxHRnBmVlFYL25yVzRQVkl2RVVsUEZOWWRoM1B4TTJqc1RjV1FyTmxXM2xt?=
 =?utf-8?B?SnRUdHFmeGdvQlU5cC92SjkrbG91UnlIazdEYlNpWUxvdFB6VDg4WWdCRjBw?=
 =?utf-8?B?M1hQeUU2SmxWMW9Cc1VNMFhDWG1McWM4bEo1djA5M3VCaDU4SjRkb1drUDV0?=
 =?utf-8?B?L2VNUTFnZG5CMS9Nb0hCNUJ2TzZsZ0pLVHVjVGZXeU82dTZSR210bGV5SEYr?=
 =?utf-8?B?d25aQUhESmR1VkF6OEorWExCdmlpMUxTUXZXWUlFbWNJU3Riclg4VjBRdmZB?=
 =?utf-8?B?dUNaMDdJT3FkL0hXRHZRbDJib0xma3ZxUlJiWFRDc2JOZXR3cTRlaEtEeWtk?=
 =?utf-8?B?U3loMWt2SVhDNUdCajRiQ0dzUnZ2VUljalZEU3Q1SUV0TG1vTUZPa0VWbkZk?=
 =?utf-8?B?Y01IZk5SeHd1S1dWUVh3WnRRRHBTL2p3dU4ybTlyV0tNR0RjNzd0TDVtYngz?=
 =?utf-8?B?eUpycWtKVko0L2c2aGUzTUxweTJwVHkrV0swYVlYTEI2NExPY3ZtZlloTlZO?=
 =?utf-8?B?SlhwTm9mcHdMUGpKbjRqSkprWC9lMUJwSEFmcWN5aUdqNkExb1oxTkVOMW9P?=
 =?utf-8?B?R3Qvb3BFWlVNQzdZYkNleWVUNXFBRGIzVmtnQXp6N2ZVRXFPNHdmU2x1bGdP?=
 =?utf-8?B?MGhUbFJUS1Q5ZkVhWVp3WG1ndkNpL21hVjdTcFZuTDE2REZpL05Ca2g3eWlK?=
 =?utf-8?B?OG5MSzk2RlNTUGxEQ0lGdGsxZFdGMlB1cEl5NjA4TUpQVG1OY1FaaXFMbWJ5?=
 =?utf-8?B?OUphUFNmRXpGTi9zelNSMUx0am91aGcwZlVvVG45RTZnRVMrR2thb3VhMk1S?=
 =?utf-8?B?a1dWVmtZTEpWcVhqdkhKWXN0TTN0UGJjcmpuZ3loVm43WGpNTzBDMGs1TW9r?=
 =?utf-8?B?ZWcyS3lMNTVSZkNYcG1zTEtKM2hlODRueEU4K2dXMGczVi9Oc3NEZzFtL0gr?=
 =?utf-8?B?S3JoOFdoblBqVkd6SW1UeGZYTmhoRlFtZ1dMdEdCVi9hQUM3ajhybzFWWFI3?=
 =?utf-8?B?Z0FHR09kQjBxRG5TaHorUVBuWjJZVytZWWsvSFdDN0luZ3JBY3loenlaY2po?=
 =?utf-8?B?UDhqbmtsd25jTUlCVWtkOVlmSS9ydmpxNHpSamc4aFZpL1Uzc2Uyd3haNTBl?=
 =?utf-8?B?Q25CVUVDL01iSFMxMDVRVEh4QzBaYmhtQ0dtc3p5aHVPc2lSYnJBcXgyUTF3?=
 =?utf-8?B?YzhJODBabkYreWxsUGVIU3pwQjlDVWJWSWE5dXFaMFB4ODBqbzRjbjRkblpj?=
 =?utf-8?B?LzRURmNuVi9nODZSRStLM0E4d0hobWpXZnpsOHluVHZhNXJaMVZQRWFadnl1?=
 =?utf-8?B?RHJGSE45a2NoeVFudjhvQndoa3VselJsdUMwV09qNTFUdkxCNXlPYmxIZnUx?=
 =?utf-8?B?SVQ2TklZQ3VvS3VHcytMTExqbnZzdlZpSlVueW5nMlRoMDRrQ0hTQzN0ZkJ5?=
 =?utf-8?B?T2NMTVZQRUk3YVE0c3VscG1mSjhaYVBHU29oRUNCcmw2SE15QmxWQ2lXMjZN?=
 =?utf-8?B?TnkyankyemcwN3hnam9TOWorWUFsWDQ3b3RSUDJYUWZQYWtGMWtFK2FDZXJh?=
 =?utf-8?B?REp3TW1SOVBjaTVqVjRraHBWVWpwMUxMamlScXVoRS9hK1Y2QVFrNGtkcGpG?=
 =?utf-8?B?VWs3ZUEweHFKMHl0NUh1czJIa3dnU01hV1ZlaEdBRlNuaEVobTI2RFM0Vk1r?=
 =?utf-8?Q?1DwoJq68YXJ0b58ilT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2896670-2618-42e9-6e9e-08dec6164686
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:00:10.9606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+TqdXDZ4VrHVpn3XJYgY7hIrNmkWBGaTi22nCwmLRRRQFnxkyL6aORAtykdtbIn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999202
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

On 6/8/26 21:47, Shahyan Soltani wrote:
> Move struct amdgpu_uma_carveout_option, struct amdgpu_uma_carveout_info,
> struct amdgpu_numa_info, and relevant acpi helpers from the monolithic
> amdgpu.h header file into a new amdgpu_acpi.h file.
> 
> This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
> separate headers.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 122 +-----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h | 151 +++++++++++++++++++++++
>  2 files changed, 152 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 07962b06168d..85d040184d13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -114,6 +114,7 @@
>  #include "amdgpu_sa.h"
>  #include "amdgpu_wb.h"
>  #include "amdgpu_ip.h"
> +#include "amdgpu_acpi.h"
>  #include "amdgpu_mqd.h"
>  #include "amdgpu_init_level.h"
>  #include "amdgpu_uid.h"
> @@ -139,13 +140,6 @@ struct amdgpu_mgpu_info {
>  	uint32_t			num_apu;
>  };
>  
> -enum amdgpu_ss {
> -	AMDGPU_SS_DRV_LOAD,
> -	AMDGPU_SS_DEV_D0,
> -	AMDGPU_SS_DEV_D3,
> -	AMDGPU_SS_DRV_UNLOAD
> -};
> -
>  struct amdgpu_hwip_reg_entry {
>  	u32		hwip;
>  	u32		inst;
> @@ -537,38 +531,6 @@ struct amdgpu_mmio_remap {
>  	struct amdgpu_bo *bo;
>  };
>  
> -#define MAX_UMA_OPTION_NAME	28
> -#define MAX_UMA_OPTION_ENTRIES	19
> -
> -#define AMDGPU_UMA_FLAG_AUTO	BIT(1)
> -#define AMDGPU_UMA_FLAG_CUSTOM	BIT(0)
> -
> -/**
> - * struct amdgpu_uma_carveout_option - single UMA carveout option
> - * @name: Name of the carveout option
> - * @memory_carved_mb: Amount of memory carved in MB
> - * @flags: ATCS flags supported by this option
> - */
> -struct amdgpu_uma_carveout_option {
> -	char name[MAX_UMA_OPTION_NAME];
> -	uint32_t memory_carved_mb;
> -	uint8_t flags;
> -};
> -
> -/**
> - * struct amdgpu_uma_carveout_info - table of available UMA carveout options
> - * @num_entries: Number of available options
> - * @uma_option_index: The index of the option currently applied
> - * @update_lock: Lock to serialize changes to the option
> - * @entries: The array of carveout options
> - */
> -struct amdgpu_uma_carveout_info {
> -	uint8_t num_entries;
> -	uint8_t uma_option_index;
> -	struct mutex update_lock;
> -	struct amdgpu_uma_carveout_option entries[MAX_UMA_OPTION_ENTRIES];
> -};
> -
>  struct amd_powerplay {
>  	void *pp_handle;
>  	const struct amd_pm_funcs *pp_funcs;
> @@ -1295,88 +1257,6 @@ struct amdgpu_afmt_acr {
>  
>  struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock);
>  
> -/* amdgpu_acpi.c */
> -
> -struct amdgpu_numa_info {
> -	uint64_t size;
> -	int pxm;
> -	int nid;
> -};
> -
> -/* ATCS Device/Driver State */
> -#define AMDGPU_ATCS_PSC_DEV_STATE_D0		0
> -#define AMDGPU_ATCS_PSC_DEV_STATE_D3_HOT	3
> -#define AMDGPU_ATCS_PSC_DRV_STATE_OPR		0
> -#define AMDGPU_ATCS_PSC_DRV_STATE_NOT_OPR	1
> -
> -#if defined(CONFIG_ACPI)
> -int amdgpu_acpi_init(struct amdgpu_device *adev);
> -void amdgpu_acpi_fini(struct amdgpu_device *adev);
> -bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev);
> -bool amdgpu_acpi_is_power_shift_control_supported(void);
> -bool amdgpu_acpi_is_set_uma_allocation_size_supported(void);
> -int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
> -						u8 perf_req, bool advertise);
> -int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
> -				    u8 dev_state, bool drv_state);
> -int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
> -				   enum amdgpu_ss ss_state);
> -int amdgpu_acpi_set_uma_allocation_size(struct amdgpu_device *adev, u8 index, u8 type);
> -int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
> -int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset,
> -			     u64 *tmr_size);
> -int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev, int xcc_id,
> -			     struct amdgpu_numa_info *numa_info);
> -
> -void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
> -bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
> -void amdgpu_acpi_detect(void);
> -void amdgpu_acpi_release(void);
> -#else
> -static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
> -static inline int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev,
> -					   u64 *tmr_offset, u64 *tmr_size)
> -{
> -	return -EINVAL;
> -}
> -static inline int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev,
> -					   int xcc_id,
> -					   struct amdgpu_numa_info *numa_info)
> -{
> -	return -EINVAL;
> -}
> -static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
> -static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
> -static inline void amdgpu_acpi_detect(void) { }
> -static inline void amdgpu_acpi_release(void) { }
> -static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { return false; }
> -static inline bool amdgpu_acpi_is_set_uma_allocation_size_supported(void) { return false; }
> -static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
> -						  u8 dev_state, bool drv_state) { return 0; }
> -static inline int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
> -						 enum amdgpu_ss ss_state)
> -{
> -	return 0;
> -}
> -static inline int amdgpu_acpi_set_uma_allocation_size(struct amdgpu_device *adev, u8 index, u8 type)
> -{
> -	return -EINVAL;
> -}
> -static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps) { }
> -#endif
> -
> -#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
> -bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
> -bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
> -#else
> -static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
> -static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
> -#endif
> -
> -#if defined(CONFIG_DRM_AMD_ISP)
> -int amdgpu_acpi_get_isp4_dev(struct acpi_device **dev);
> -#endif
> -
>  void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
> new file mode 100644
> index 000000000000..6569a4db5dae
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
> @@ -0,0 +1,151 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT
> + *
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +#ifndef __AMDGPU_ACPI_H__
> +#define __AMDGPU_ACPI_H__
> +
> +#include <linux/types.h>
> +#include <linux/mutex_types.h>
> +
> +struct amdgpu_device;
> +struct acpi_device;
> +struct amdgpu_dm_backlight_caps;
> +
> +#define MAX_UMA_OPTION_NAME	28
> +#define MAX_UMA_OPTION_ENTRIES	19
> +
> +#define AMDGPU_UMA_FLAG_AUTO	BIT(1)
> +#define AMDGPU_UMA_FLAG_CUSTOM	BIT(0)
> +
> +/* ATCS Device/Driver State */
> +#define AMDGPU_ATCS_PSC_DEV_STATE_D0		0
> +#define AMDGPU_ATCS_PSC_DEV_STATE_D3_HOT	3
> +#define AMDGPU_ATCS_PSC_DRV_STATE_OPR		0
> +#define AMDGPU_ATCS_PSC_DRV_STATE_NOT_OPR	1
> +
> +enum amdgpu_ss {
> +	AMDGPU_SS_DRV_LOAD,
> +	AMDGPU_SS_DEV_D0,
> +	AMDGPU_SS_DEV_D3,
> +	AMDGPU_SS_DRV_UNLOAD
> +};
> +
> +/**
> + * struct amdgpu_uma_carveout_option - single UMA carveout option
> + * @name: Name of the carveout option
> + * @memory_carved_mb: Amount of memory carved in MB
> + * @flags: ATCS flags supported by this option
> + */
> +struct amdgpu_uma_carveout_option {
> +	char name[MAX_UMA_OPTION_NAME];
> +	uint32_t memory_carved_mb;
> +	uint8_t flags;
> +};
> +
> +/**
> + * struct amdgpu_uma_carveout_info - table of available UMA carveout options
> + * @num_entries: Number of available options
> + * @uma_option_index: The index of the option currently applied
> + * @update_lock: Lock to serialize changes to the option
> + * @entries: The array of carveout options
> + */
> +struct amdgpu_uma_carveout_info {
> +	uint8_t num_entries;
> +	uint8_t uma_option_index;
> +	struct mutex update_lock;
> +	struct amdgpu_uma_carveout_option entries[MAX_UMA_OPTION_ENTRIES];
> +};
> +
> +struct amdgpu_numa_info {
> +	uint64_t size;
> +	int pxm;
> +	int nid;
> +};
> +
> +#if defined(CONFIG_ACPI)
> +int amdgpu_acpi_init(struct amdgpu_device *adev);
> +void amdgpu_acpi_fini(struct amdgpu_device *adev);
> +bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev);
> +bool amdgpu_acpi_is_power_shift_control_supported(void);
> +bool amdgpu_acpi_is_set_uma_allocation_size_supported(void);
> +int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
> +						u8 perf_req, bool advertise);
> +int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
> +				    u8 dev_state, bool drv_state);
> +int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
> +				   enum amdgpu_ss ss_state);
> +int amdgpu_acpi_set_uma_allocation_size(struct amdgpu_device *adev, u8 index, u8 type);
> +int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
> +int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset,
> +			     u64 *tmr_size);
> +int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev, int xcc_id,
> +			     struct amdgpu_numa_info *numa_info);
> +
> +void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
> +bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
> +void amdgpu_acpi_detect(void);
> +void amdgpu_acpi_release(void);
> +#else
> +static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
> +static inline int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev,
> +					   u64 *tmr_offset, u64 *tmr_size)
> +{
> +	return -EINVAL;
> +}
> +static inline int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev,
> +					   int xcc_id,
> +					   struct amdgpu_numa_info *numa_info)
> +{
> +	return -EINVAL;
> +}
> +static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
> +static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
> +static inline void amdgpu_acpi_detect(void) { }
> +static inline void amdgpu_acpi_release(void) { }
> +static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { return false; }
> +static inline bool amdgpu_acpi_is_set_uma_allocation_size_supported(void) { return false; }
> +static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
> +						  u8 dev_state, bool drv_state) { return 0; }
> +static inline int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
> +						 enum amdgpu_ss ss_state)
> +{
> +	return 0;
> +}
> +static inline int amdgpu_acpi_set_uma_allocation_size(struct amdgpu_device *adev, u8 index, u8 type)
> +{
> +	return -EINVAL;
> +}
> +static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps) { }
> +#endif
> +
> +#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
> +bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
> +bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
> +#else
> +static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
> +static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
> +#endif
> +
> +#if defined(CONFIG_DRM_AMD_ISP)
> +int amdgpu_acpi_get_isp4_dev(struct acpi_device **dev);
> +#endif
> +#endif /* __AMDGPU_ACPI_H__ */


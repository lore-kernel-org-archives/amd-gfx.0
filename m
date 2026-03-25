Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DB8FEA83B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 09:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F4FA10E6C6;
	Wed, 25 Mar 2026 09:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ti4r6yB1";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC68C10E6C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 09:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beFpikA0L/yZfa/848vfSWkm69RZVwH8F48SfhjJFKVXIYwrVAjyMrM9pd6VGKvs7qHS527qYumP4E8ZIVa2gCggiRS2j3YuztQ/2mOnv20KrHv5EEEREEBsP3jLcaoQ4pSBECuxmXwkTvQVn2cHKBkR4hbo4T6xQOanMjFLZpd5CjIa/jR1BHIryhiaSCz+kcXdiXCDI/Nll4nn07w+seeN+EfRdpoAyPkhiNKWnnWjXTal8hy3oThTTh+hPKo4MNtvERi+y29ZjtU61VKdS1mLHZP2X8BxHWsg5cujuQHTM/U8/0tXjyStV+J36LktJ4u5IMquoIX6/4L1xdNFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K82qUkLj3LmkihYINSEsmcVDtPUlyC+ep0BeIxF9BV4=;
 b=uoVogtpqLOzwiG331YT3Epat9+8igg71AJk1QB7QEuFKRBsbsSdEQO6AhoSi+Ym2WW+yRlNitfY2aycgOrnY3BRSYt6mIX2VMYI9QvVLUynVAi4Lj9CBvgee6PMVbB5c0MX7OKQOQhGreQMmtB87X2OlQRl6YDMzRYvqeAn6HlEDrOWlFdioTb9PchI4Knr4h/tVkQfg1HkEqn0F48sfRyS8Ai9G8FnbASTJGNVB/TYtlRMhj0DMZ4JqMdqo3ovx4CVDYuk6KmWPCbdCt2oaYKSUcFaquKiqQBP9wLomqZE5GiLlf5DgA2cZC8G//BZ38h7n3jrUNrCz4ykgb05yLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K82qUkLj3LmkihYINSEsmcVDtPUlyC+ep0BeIxF9BV4=;
 b=ti4r6yB1MCaIRwGJNDZPNdMVmRCF4pPBrkMNZZBAatHv9RBpF2Y2ZPt8rbC6u4gZp6c6Oo8Ffc32NYCxR/DKR9Sn3o45aQzXS/0iglXlkAPFHZqb4+w3Flq9OoZShayjRzuFdc1uuDK3WnBpsf4aOpXN3vfoqYcs+8X5eZnUqrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 09:44:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 09:44:24 +0000
Message-ID: <c7eef696-7114-4b8c-8b87-7d232bcff570@amd.com>
Date: Wed, 25 Mar 2026 10:44:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix PTs flush race with pending TLB fence in
 vm_fini
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260325084413.3359504-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260325084413.3359504-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: eb22c01e-9368-47fe-c5da-08de8a531921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: OVxYysV9wSm/wecyOwKmUZSA73fixfQA1wTzwImJUDZovopqCxAtNEfgpUBzfGvFcCygC3VhO71+BiLHcjYfZE/lDlUrUw7ArtGPc2eT6285HGNEaD7A0LIP2pQ1i0koT4qI3CqWOep0KOh2vD/Ixsfy4hpEkm61V8x9BeKcnmZlC5BaybIzvpxRew3NzUJ6aAhjkGuFvL5bV9WTvs+S1vHCkGGIc9NkclsZOmm+ejegKXeJ8o+sd7um8MRjk6OZI3P1afZp6HIALo1++9Mhs5gcer9g1IpZS5YQhsOAuXef8MDOBgOAeoU9davZVpHu2AX1HBtjJy9I4wQVVir2pB0cP9D+Gfn2ntqAr+DcBdUHTM7pvekJXqpNa1RkQIltvwO0X3PLuWsmbbtG3XdUW38ebqID8IjCsOpojJAqo20wyiPTaWfVUDTDauI9tugujX8YkLX1gNeRKwLYhVmXOsLShM/cNJ2gme1jQwryE4A5Vj2aky3YgIDBgY10+rUM7bDXEBRGfLxB+X62GPMx2/VhjnhTf3RyqnXy+FLCfwOre1jA2PluC037eVnpOSEF/jzUKFiRP0bQcP8uUO2ch01dwyPclZmYMHuoahS2kjzNPjhcYGhjJzMcza6ME6TN6+KXsfvP+DYm0DKtRq9D6ng7aDrMS/LZYRgsaRr8ddZmIHtj7lDI8ODiIWifHoTB7/uflV6Uu/wDjUNtQkh1MVdOEnzQpXjTrFDvbyc3NkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUVseGFLaXhnZkxHWlVXVzh4SXU2eXF0YnhsdGdKbDcvTTVpT0t4cnY1dW5I?=
 =?utf-8?B?b1FENHR4L09hcUJ0M2VBTzdkUnBqbTZFMXo5WkttMXlSWFdYUWMwTWpreTBE?=
 =?utf-8?B?OUxwM2JHdWwySFZhcUhhVjBUV1dwdTNteVhVRUZVQ244YlEwRTNUTXd3Y1Jz?=
 =?utf-8?B?OVYzVGxibmx6SEdVaWJOUzRML3U1T29oUUZvdzZEZTl0T0ZtdDNlVU40ZnNa?=
 =?utf-8?B?Q1ZCV29uWmo4Y083bFFaMnVvNXhEYlgzSEtjcXZ0QTBtdEdlRjNaM1VVbEJT?=
 =?utf-8?B?SzU0anIxUUoxYndSUEZ5bTZmQU9ha2xLTnRyUS8zWGZwbmtMZjNyRXUzVmVk?=
 =?utf-8?B?NE9iejRkQkxoYVcyN3B3cG9zTFJpVDN4RENqNG1DNkNMcWE4UUNtN0ZpL2Jy?=
 =?utf-8?B?QkVrQmdXNStyd05vd3QvSUsycEhMUTFCOE9LaEJEbzFRQW5tT3lucDkrWVhX?=
 =?utf-8?B?YjdWY0Q2WW8rUVJMSnhXMG80SVNtcFdEMHh1SnJLakc4VmprYStFSEErT0I2?=
 =?utf-8?B?TjZhd1UydkJsbys5WDgvNm90YXVyaVpDV0FmN0M5MXdsZG53Vml6UjhPNThF?=
 =?utf-8?B?MzBQVlNLQjhjS1NzeHk0S2ZybXZuZ3cxOFNwM01RQ1ZGTjhDZUpycEwxM2Q1?=
 =?utf-8?B?TzdaSTdqZTN3a2xkdnNnamdQb1dMTnNEOTBRcmVsdzhteDJIZGViSjFtS0Zx?=
 =?utf-8?B?VmhXUys2NGNVd0JmN0UwVW1NNjVoRlowcy9IOHpNaUxURE1EMVBKaENYME1P?=
 =?utf-8?B?WHpIdTFUby9jTUZDMGlKSDZHa2VnSWg1MDFXUWVWc3RWWVlVckV6Um5IRXN4?=
 =?utf-8?B?OEpJWjh2K1FNdXlaR25CSTNZdGdYK2NadEcyUUVJTElFN3N4R0JBU2NOTU5V?=
 =?utf-8?B?MUZvTDNUS3BLMk9DVm9lNHZPS3pia2FwdjNaWGlJZFYwa1JlWXhqMStDRWNJ?=
 =?utf-8?B?RU1wOW51NHlnemxyeWlwMjBNUFNkblE5elg4STVjREZ6OE91RGtxZitDSExJ?=
 =?utf-8?B?VjdsaFhBd0ZRYzFyaEZkb0pieGdrOEhNbXRTR2tzdTZtU3VpNjlKWFEySHdB?=
 =?utf-8?B?QlZUUjhxOHN0L1kzM0tqWG5Bekx1d2ZlMWZJUEh6MWNQdHFLNzkzWUExMDBm?=
 =?utf-8?B?emRUNHg5RUhGOE1kRXE5RmN5V2c5M29OSGdXTElHWFNxcy9WdlZOeURTeU9z?=
 =?utf-8?B?RjRpNklQbGhIbXZ5Y3JCcFUzL1RMaFp3NmNveWxJS0UzRDZPK3c4S3Awa2ly?=
 =?utf-8?B?QWFvb1pSQnJabVRGMW9iMTNWK2RmazlRVzd5V2J5WUZ0ekltVE5BWjg2L200?=
 =?utf-8?B?VFMzZURoQ3RlL0VXcERtbHh1cC9XZXR0VlErSUxBcGFwWWo1T2hRbzNZVWNz?=
 =?utf-8?B?VkwwMXJkenZSeWVPUFdGSS83ZTdLU2lURWdENEhCQlZRT1hRbldqUkRkYzFO?=
 =?utf-8?B?T1V2dGNHVE1EeVZLN29VYitPSVRPUXNwdEpkN3NtVFFEM3R2dm9Nb1J5Q2xk?=
 =?utf-8?B?YktnWjRzNWlyUXhRNUsxSkptaFRNTG50WHlyMEJZT2w2ZFB4bzlHTjM2cHZD?=
 =?utf-8?B?OVpmMTc2RXI3RkFBK084aC9QS0lnN29VTTIzbkh6d0xZN0tZdkw0Y2gzL1FH?=
 =?utf-8?B?RU1zTDNPRFZJa0MzMlpHcktLUmhERW1hVnF0SWNXUXUzUEYvcW5rMlc0TzQw?=
 =?utf-8?B?TU9HTVMxalAxc0dOTGpINHZPOE1CNjdFWWN0ZjJXbDB1ckh0endIT0RmVWRK?=
 =?utf-8?B?bFJMR3g3dExIZmRFYUZzQkkvMFV1bnFFdnk3cjVXaGUxTjdwYmcwT0tOWkNO?=
 =?utf-8?B?UzREZlRyQXpoZWt3UVByTDhFNU50d1JHT3ZQendYRGRVY2VPR0pJMGpsaklL?=
 =?utf-8?B?S2hVaHhDRm5SQUxFd09MU2lqeS8zZEZCWGpWbEdjZTNlSS9jeHBhVU1STmVa?=
 =?utf-8?B?MG9pMkRRL3MwOWVjeEVwa3FaM2dDcnZkWVNSaUZndTNOT3pVQXRtOGFsN01D?=
 =?utf-8?B?anNkNXdCN0JXUkRhaGNVUVNkTFBSZ2dOL0tuKzRhSDFnVDZBMm1iZEg4bGR5?=
 =?utf-8?B?cHlCZWl3OHI5Ky9wdW5uSGVXbzZZaVlRdTlVOG4vckRXUUZqMS9zb1JZeUtn?=
 =?utf-8?B?dmwrdUpOQ1BidG5nUnJLS2dBYTNpU2tBMi9yVGNyaHZ1SGwrZGRDeXJFUm5U?=
 =?utf-8?B?dUZCbzUwQ0EyaFlpRE9iUXEyZndXNnBDSnZNSHd0c0ZMK0kzYkI2S2pSVzVv?=
 =?utf-8?B?ZGZJVTYwRWVFcHN6cHhGSXdHRDAvaWQyelliM1g3d3ZqaGRicXRWZ3dUcVNx?=
 =?utf-8?Q?kyJYitOVUKyqapcqhy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb22c01e-9368-47fe-c5da-08de8a531921
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:44:24.3421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCCbQI94yo/v6P4vSJXwiKAqTMDO8Cnd3wxcbxpC3ynP+AQYS/vqKnRrL7jV0hBD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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

On 3/25/26 09:44, Prike Liang wrote:
> amdgpu_vm_fini() relies on vm->last_tlb_flush to wait for TLB activity
> to complete before calling amdgpu_vm_pt_free_root(). Because
> vm->last_tlb_flush tracks only the vm commit fence and never the TLB
> fence itself, so fini() may proceed to free page tables while the TLB fence
> work item is still running amdgpu_gmc_flush_gpu_tlb_pasid().

That is not correct.

The PDs/PTs can be freed without waiting for the TLB flush to complete because dma_resv_add_fence() adds the fence to the PDs/PTs and make sure that their backing store stays around until that is finished.

The reason why we have vm->last_tlb_flush is to track the SDMA job which will trigger the TLB flush callback for kernel queues.

And your patch here breaks exactly that, so absolutely clear NAK from my side for this.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 937a6dd3a4b5..53d0ac8bf98f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1093,6 +1093,13 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>  	if (!params->unlocked && vm->need_tlb_fence) {
>  		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>  
> +		/*
> +		 * Update last_tlb_flush to the TLB fence so that
> +		 * amdgpu_vm_fini() waits for the actual TLB flush to
> +		 * complete, not just its commit fence.
> +		 */
> +		dma_fence_put(vm->last_tlb_flush);
> +		vm->last_tlb_flush = dma_fence_get(*fence);
>  		/* Makes sure no PD/PT is freed before the flush */
>  		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>  				   DMA_RESV_USAGE_BOOKKEEP);


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04391606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bv71ubZJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7225610E95E;
	Thu, 26 Nov 2026 10:35:21 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012049.outbound.protection.outlook.com
 [40.93.195.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEB31122CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 10:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rex/23wlwJ/u+n9j997iJQfMct+fSZANs4m6iLP09T0t35j2KkmHj4Qm0OFRCcJMQdA5U2VVfXEPyr4Fcq4iuxgCG4Ovs89Yq88ybnVKxh6UG44PQKjM+hnitM6hUaFk57c9jyCyj0LRM49Q49Ndo63afeFpukw214yrJNb3AXrN851Nz/AO/CJw2JaJ0HGPSPz3PWwQpFNv+IVfkyFLfjp68SQ+ST3614eOQ9AAZi3y2ur6ulosj+ysv+vZqPlEe2B9Q4Ni4hVNVZa3tbfw4QGgLmpjkMa+ci+2w1qIjukEkyRdcnkUDWDhd3i4K28gVTvc5R72j35XEqItsNgMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJQkqA2l13vHAIx/MQ39CFi7dvtd1xG7dzNokbo8Iz0=;
 b=DTaOh+asIBTL0pE+ppAfJLsCakZDVTfAfOVIXiV4rLbWXad4s8xUSZPQwjNWBIAPMuK81VH70kJBWIB0nozOxgezzb6mNuO67bBPhF6Hg2w0jkLzYPW4F4yiloihn4tJN+xyduemOD81EURdZzoaCgIQDb2wqBR2o9S2EoGnN+z36UBqt6jwuAGUN2to1RY2aMAMs+UE9NCOYSqglqhCePRMOswwEbx5GIiPBU4GI8xZ4fyQfGyh9G69WR7aFbS6N89lFQNydUvv9xiN/b/dWbnTrLzZIAPlj6weJVbKOltArbbK/UwOTt2W4nuusGiBHii7LGbK5IgID4bPj3Esyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJQkqA2l13vHAIx/MQ39CFi7dvtd1xG7dzNokbo8Iz0=;
 b=bv71ubZJmMEv1d/qtPug5JKqKjtbqyaZQyJDHKx8zjnbyAOEIvgTovuKKvb9JhMBVWkIVzbzxFaAbWVmMtDEwGDoJjx4fYiTwPX7n/9mN6ejDH8wbjCRqIYsQU/NpaP+w3lrAzGEEKTXvZT5ymDHEg7f6AL/yZUxjSokSKsYN3k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 10:35:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 10:35:08 +0000
Message-ID: <44e5f985-0125-4aea-8b3d-71efa13fa375@amd.com>
Date: Thu, 26 Nov 2026 11:35:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep the address of cleared PDEs with
 translate further
To: Bob Zhou <bobzhou2@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Mukul.Joshi@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com
References: <20261126101946.2651048-1-bobzhou2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261126101946.2651048-1-bobzhou2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN3PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:408:2af::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: a478fde5-aeb0-4375-ff58-08df4ba8f14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|22082099003|18002099003|10067099003|11063799006|261028144727099003|261102123227099003|261026140227099003|261022105027099003|56012099006|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 1csj9uAD1r97RO8HK5bvYtgR8ZFcWNFZX82VeL9pIZPrjU3p7I5JLORirc04iFYNXol2jQ3rMdJ1XPCyhtrBmrPp/tec2NPx/hTDf2oetJK7/olgahvuM9dmSRGRFeIt89f69HM3x7iK1lu1NIxg73RhIupFXR7IfMAiggwbX5LueTcPqReKkIB5Sz50wAjjNTnXTUp3EZwU+F+AWnULvcKiAd8I7jeDCQlZh1q63omEz83KfWxtnJxvV/b35FZ0+lAC7EAja1joRdx13bSO4qgIsPiB/1aklwUn/VXDW0oR0jhLqATkaCscendxxJiMgpyV5nPilT59pKRdFZi0M2KZGqU2ccxjlyLrYTqpJ2SW4MPyJ6s5FpFsXTHPKdx/BWpf1kLwV9KZkOgLeBcF/oAonBCyd4YGqqrkGZwGJVr67g6NIyOPjCCGffK9YBDH/AZYXUwVS/aD6sNybIAlFyX9jn89iYOzs9dmDpgeMENJklVIBtykkDXWF3ng/+y5iRSoAhUYTLArwgU48zEr7mkN4d8L37s/VouSOUegEXifNOGWtef1wsCn0P2LUTQxCg/1ZRt0DAshe8ThhFa6GaXLJmLYuENv2TLtvRbMNNVsKk/x7Y+xah8/D1fmgXRqPHb14Cw47r41u5a/4ypM7657rNpuXerEqwV2YsDqdGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(22082099003)(18002099003)(10067099003)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDhVNFZwNnhZTWw4bDB3aUFjWU9LbmR3WVkxZGhVRk5xeEVCdFJTTEw1Qy8y?=
 =?utf-8?B?SVl3bkVqeFNmZExPeG5Bc05XNkFqZjR0aCszTFZMYWllVkNtTHRva2xtMHd5?=
 =?utf-8?B?TUIxSVZuVENQOTRiN2lvcHZVaEl6MENRRjl5aElHdTlSdHNJeGdtcGJLZGxV?=
 =?utf-8?B?c1RMVTh5RGNpYkNqNmlNVUdlcUlrUE93NFBFNlZYK3hHZnRwdnZKVzAvMi9C?=
 =?utf-8?B?MjJhd0tJZmN5eCtUY1padzBEbDdQM0JMeWMyTjRjSGFXYURYR0QwWVlNWDR6?=
 =?utf-8?B?dDB2RU9MNVhHb0xGTGZpN0dXUlZCYmpHRnRMcGZ2YThuQzJ2LzlXWFZ3d3VQ?=
 =?utf-8?B?SVJMZHlqdlhPV2pIUGNwOXZlOVlTY3B3U1Q4ZUVIa1lNSjArTmtlbTArVzdD?=
 =?utf-8?B?ejlwem84VnhQTDlWakJLVnF2c2pDeXhXUHJZTDhmMzBqRmJqcjNHVDFyNnJZ?=
 =?utf-8?B?dm1nWVdIQ09ldVFFODd2ZFQ4OFo3TzQ2OW9GY3o2WnBiVGpHbm1ORTZSWVFT?=
 =?utf-8?B?WDV4bE03Wkl0WURkZE5DZSsramJNbHBkbWE3Z25rQWtFRTdNSkIxT3F4TXlq?=
 =?utf-8?B?LzgxYjQ2U1NXL1JXeGtIOUZIOVpzYXBsVlI0TVBKaXhoOGswVXFLbDVvbzR3?=
 =?utf-8?B?dmJDSGptNXFsQVQrSEE4c012cjM1Ulp6QjNnRC9MME53L091THhOSWozU3V2?=
 =?utf-8?B?bG8zZUxYWjF4SVh1dmFsMnozanhMYUd1R2RFN1NjTkR2U2loT3BrOWRHNEhW?=
 =?utf-8?B?eFlDOUpkNktMR1FxZ01RMHlheDNNLzZkbkttZjlaYmU0enVWZGx2NlFBbzhN?=
 =?utf-8?B?SVBoSVByLzJraFV6Z1pDU0xzZHhSb2Z6QkV3REtzOVJqKzRhQzFLU0hrK2dS?=
 =?utf-8?B?V2FUNDU0V01JV3IwbmJ3OEtrU1ZlUTNlT3hLV3laRW1JLzVKRm1nNUlSRVc2?=
 =?utf-8?B?a3gzREh5cGpPdFpQRDBMMVE1amhtR3ZjSzZOZHRJOEpLaEpvQzdSemdxeGJw?=
 =?utf-8?B?WTg0TThhaUtqYVl4YkFWWjBzNXp6aVFMR041QlBROHdlRlpwQVdVV2JuNG9U?=
 =?utf-8?B?N2pIMzd2eFNZTkNSWXpRUHFRamtrYUtXbzBmb1EwRlJGOTFSN3h4aENvOWh2?=
 =?utf-8?B?cTh3TzRTVzdIbndpVWRuek1FYkRhay9CZ0UzMitSWEtsQXZBNWl3SFppZWE3?=
 =?utf-8?B?ZUw5RjBXeGV1VVQ2dTJ5d3Z4bWJROTFPVWtuWDRaNUMrbDVEYzJOMWltdGFC?=
 =?utf-8?B?ZEY0RXRqcTRpZkJvVWFqR1ZGYzY1Yk4rWWFBNk5RSmdkdVNreFFjdVZFNGVq?=
 =?utf-8?B?MTFXMkVqWVJBOFBHUXJVcjNBdGlDQkJRVWZsVmJoWDNSczZ6L2d3ekEzbFhH?=
 =?utf-8?B?MXZISWg5eCt1bjlMV0Fvd3VXb21MNTN4NHg0TUUvbHZtdksrd1ZQUDlQdmY3?=
 =?utf-8?B?NGt6a29zSldxV3Vabms0VklUTGlzSmE2ekVBbXBIa3lvWmJIVzVuenltcHI4?=
 =?utf-8?B?MzJhUU9PMVFpNHI4Tjk4R3VPMWQvZFZEUnl0WEx3UVF5ZDlnUmU0bkZRVGhV?=
 =?utf-8?B?UjJxRWEwU3hndzNZSnhISjY0ZU5HZC8vSUJycVEweGZlRGk1L0ZGRnhHYzIz?=
 =?utf-8?B?WFRjazMxdmNMd1lLNW9OYVRSUkVJYXhMVjJOLzFtaTVHL1RueG4rMmoram1X?=
 =?utf-8?B?a0ZaaERWMFpRNkZUQUwyMWg3dHpTNEZJYWk1V0hRaHR5ZW9Ib0xxWGFndzlp?=
 =?utf-8?B?OEtod2ZJMXNGeUJ2Vmc3djJpN2lERnQzUkpCNW8rS2xhS05WUS9vR1RUSkV0?=
 =?utf-8?B?OVlzN1czcWtQenNnZVc2RUp1V3dWVi9uclVpZjZ2ZENuTldSVVhLOEg2eUpw?=
 =?utf-8?B?ZmVLd3VrWmxyV2JpZFlIVllMUnA1K2M2dVRzYllQRFh3MVllMVlNZ2NCNVBu?=
 =?utf-8?B?MnJCSmNSQ0JXVFRHOXo1SlNkNFhwZ2VFa2NkL04ycndkUk5Hd1hydVRnZi9p?=
 =?utf-8?B?NXdPeDhvMFpNQ1RHQkhIT3h5MldRcWs0c2J5OTgzMEsyME1ZRWZIcEFtNXlu?=
 =?utf-8?B?QkZiQmJwOThPOWM3M00wOFJGNFM5VnVrV1FldmRRSDRwdnBGK2dDajNraVBN?=
 =?utf-8?B?MTNFYUpjL2ZJUENxM2hBdDJHSDZEUnBuek52c21oWGhQVVdwS01nbkhFZTNG?=
 =?utf-8?B?OXZJYVl1Nm1LRDhJVUpSYklvRFNEZHNUYnBpZlF2SjlReDB2V3lEUmd2SEpM?=
 =?utf-8?B?THhKYjA4T0c1SENDWk95WTg3aUlkOWh4dENpWkZ6UHloQ2Yzc0dCMjZKZHpC?=
 =?utf-8?Q?ODbLPSMtdqC+g8FOGq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a478fde5-aeb0-4375-ff58-08df4ba8f14d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:35:08.7567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzFwPW3vDQRk7U91KLUaCTmcrAWStmdQATw3DjunDHaz9u6oevJ+SzKVCmhlAip6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 11:19, Bob Zhou wrote:
> Commit 37a0bad677a7 ("drm/amdgpu: Update PTE flags with TF enabled")
> made gmc_v9_0_get_vm_pde() set bit 12 in the address of an invalid PDB0
> entry, because with translate further consecutive invalid entries which
> read as 0 are considered a fault.
> 
> amdgpu_vm_pt_clear_flags() drops that address and amdgpu_vm_pt_clear()
> writes 0 instead. Return both the address and the flags to the caller
> and write the address again.
> 
> Fixes: 6250a8342784 ("drm/amdgpu: fix cleared PDE/PTE flag generation")
> Signed-off-by: Bob Zhou <bobzhou2@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 36 ++++++++++-------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a6d389c08524f..8f1e0bc7d65ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -346,31 +346,26 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
>  	     amdgpu_vm_pt_continue_dfs((start), (entry));			\
>  	     (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev), &(cursor)))
>  
> -/* Return the flags used for cleared PDEs/PTES */
> -static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
> -					struct amdgpu_vm *vm,
> -					unsigned int level)
> +/* Set @addr and @flags for cleared PDEs/PTEs */
> +static void amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
> +				     struct amdgpu_vm *vm,
> +				     unsigned int level, uint64_t *addr,
> +				     uint64_t *flags)
>  {
> -	uint64_t flags;
> -
>  	if (adev->asic_type < CHIP_VEGA10)
> -		return 0;
> +		return;
>  
>  	if (level != AMDGPU_VM_PTB) {
> -		uint64_t value = 0;
> -
> -		flags = AMDGPU_PDE_PTE_FLAG(adev);
> +		*flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  		if (vm->is_npa)
> -			flags |= adev->gmc.noretry_flags;
> -		amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
> +			*flags |= adev->gmc.noretry_flags;
> +		amdgpu_gmc_get_vm_pde(adev, level, addr, flags);
>  	} else if (vm->is_npa) {
> -		flags = adev->gmc.noretry_flags;
> +		*flags |= adev->gmc.noretry_flags;
>  	} else {
>  		/* Workaround for fault priority problem on GMC9 */
> -		flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
> +		*flags |= AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
>  	}
> -
> -	return flags;
>  }
>  
>  /**
> @@ -395,7 +390,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	struct amdgpu_bo *ancestor = &vmbo->bo;
>  	struct amdgpu_bo *bo = &vmbo->bo;
>  	unsigned int entries;
> -	uint64_t flags;
> +	uint64_t value = 0, flags = 0;
>  	int r, idx;
>  
>  	/* Figure out our place in the hierarchy */
> @@ -430,8 +425,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		goto exit;
>  
> -	flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
> -	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0, flags);
> +	amdgpu_vm_pt_clear_flags(adev, vm, level, &value, &flags);
> +	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, value,
> +				     flags);
>  	if (r)
>  		goto exit;
>  
> @@ -724,7 +720,7 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>  
>  	} else if (!(flags & AMDGPU_PTE_VALID) &&
>  		   !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
> -		flags |= amdgpu_vm_pt_clear_flags(adev, params->vm, level);
> +		amdgpu_vm_pt_clear_flags(adev, params->vm, level, &addr, &flags);
>  	}
>  
>  	/*


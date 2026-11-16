Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8515606A894
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bcnMWDTY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D30F10EE25;
	Mon, 16 Nov 2026 09:45:28 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D62F10EE20
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 09:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHTv52WACGuEXkyab8Phk2PeeuvRoQ+dvFLjo5XoDXBcdLl9qApbGN4yi6ZcAFfe97IBhSxIaKKDJbkescNH3h48wNP/Dy5TX2mELgWw97uaeOXr+6HzjkrRfQpgwpa5M28r5tGUun9k8NP2umBQSFGE3QrWOOXHeUrsRefQbpmaS8o9NRMj7OK0mJvV2H6IB6lSvKcJOYkQNtpaNE60A4vlz6bInV1PLF5vEvh6DFBRYf8Zvz0xIlZbznjfXHdH/fTmZo58+PEnfZrBdJVPyPneu+c+Aud6MSmboW90yBBsZ8N75emWvtcKFHrpbScMEEmvllKzBio++OIMBOz+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh5wYvHOltKUwoowfgmRZkfKWSqHBFotDxXEcYFn4WY=;
 b=d6e3LUG6NGDuZjctvxiwJNYKwXilJaut2CQzzud6Ys2ct1eRHwHp8jWqQ4Hlr6cTPH1ubd1tD3GThz7tPj/m9+NLJku0wadrqTnIDu2xs4tkNLY6tqNM8aJ7+nyoIHkDYc8xIScynHhtE0fbgJX+m+xIzWu8fs8+veUVQ9JcSphIBsMAxmTdBGRp8SzmeMtJqo8qnJ7TI7+NpKt3v75GjERR/oxLLmBc10UgWdlsjuKJCVRahxk0pTNOGJ/u3wuXwTDsUWqG5V7Yo22uN7UukfOTxRiXO0GSwhByS8x2+E3mkHjZOtnGnrGyv9r89qJCKllu/1Us+38xBus1OBX8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh5wYvHOltKUwoowfgmRZkfKWSqHBFotDxXEcYFn4WY=;
 b=bcnMWDTYp+nSpg9ml1LeU/komhC39hPld0Y8Sh4VJ9bMoznXcJBAwqtNM/YTBDI6PS7OcJNcLRnoPNyh411OOPdcZGfmgDB6Eba1OjZU+S5OMb/GH+qbXbT5Go+B0PD90/AZk5GO+IL1Tgybsk45d3mMZ5fDwEonYnUHl415eXI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by DS0PR12MB677406.namprd12.prod.outlook.com (2603:10b6:8:4ed::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:44:18 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:44:18 +0000
Message-ID: <acb0010c-0b63-4709-aeb7-9d15859f11dc@amd.com>
Date: Mon, 16 Nov 2026 10:44:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/amdgpu: fill the A+A VF PDB0 through get_vm_pde
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com, Lijo.Lazar@amd.com
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
 <20261113145702.323968-5-Zhigang.Luo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261113145702.323968-5-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::11) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR12MB5684:EE_|DS0PR12MB677406:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d2096d-ad5e-40b7-0d0c-08df43c62e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|261026121527099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: tsIDMbherS0BlP1gYzJ110Gqt43QrqPIHhQ7uOjeMQ8dnAdWz5y4gLTt/M7NWPKsphJNCRTAEotkniWA6Zq5q/4Q6JuGlLnAB7Vt3yA6TnMAw4FgIAgk8zpMAa5GaeMxgG+TZeYNI0Yfd5WX0jgsVWzMhljVGVkexNRP6e5OPP2A1kTsfb3kYteBOO/MbD4Q3LqS7mIhd+UY74F19SwMgNJ/B8CJcpOsiqZg7N7WHZYfD8c8lX+FNzvKvu4NiAUxWqPIyN7SRyKQlylz1z0Q3aJvB35c9AoX6REiFggAqSpkQEXXtq+Oho7JCJLY4qKAaMP2NF+ipHIowaTalCw3Lc2y24rwPT8T5bDD/0lHbXV4HLNergDPaTHzni4MQEzY7BTBXE8LbZNEU9GZcD2kAukJHokgqqG1gD577bQZTmi+H1/IZBb+U0Isfy8k2tHCBC7fvGh6jRNdkK0sKrMWp6NKY/TGI4eIDWv2N8+78phF1qnr/sMXc9NCxzVhmpSKTyWQuRNTScTt0oHOWcKAPI/5CHBJNDnaBY19xxUCRCewD3YSRaoNkWoWZewXnFv/ltAVjqZYQv6y3KegUj3krh6/xCkus0y072IrpbMlB0Z3LV4muMovh/MmNhUJmvjuZOE5HtWdGuha+6QJhMy5WA8D3Z4/cv4fgDHq2JtyZRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmtCcGNCRW8wYWVLY2QwVjhkc1c1cUwwWS91ak96aTFTL1VtM3JWNXEvTzlW?=
 =?utf-8?B?aFVOVkFQZzhlL3J4VEdIeW5uaE1NbVJSRzdRRUJFbGprQ09OYnNRZWdwV2x2?=
 =?utf-8?B?a2VzanhmZHBTcXdsR01kR3RKQ3pPK3k1NkVmNlBXY1RaY0ZaNTNLWmhHR3hI?=
 =?utf-8?B?U1plc1FycnBiYUswQy9ocXZzK0ZJUHdTUEdTQ2JWeFUvZXFLY25DUnRoN2NS?=
 =?utf-8?B?TWpCbE5tUVROU1RhZTRCZGFFMytBR1BFeFZsSlBvU3B5U05QSS9zd21DWmpR?=
 =?utf-8?B?QSs0UEtoQjhFUURkWTA3L3FXUVhDelBNNEMwUWUxQ2lZOVk5UGdxbTFEemxC?=
 =?utf-8?B?OXlBM1BmSHdNL01PdUpYbGNMSFJyZzY1OVl6SWFhcEs5S0tSbkV4OEc4clVj?=
 =?utf-8?B?WmVKbzJBdDc1NFU3UTBCdWt5dFJnNmRPU1JRS3p5emJvRHZEWFU1YThuQ0Nl?=
 =?utf-8?B?Rm9GWDc5dFQ4bWxDWEVEZXJVeHBBcDRLUDhoWWRtZFNkblEwZ0NrK0ZvYkNw?=
 =?utf-8?B?T2xyUkMzR0xsK21oK29NVVZOaE1kbEFWU3J6ZCs2aUNEQ0VvY2JzaTdyWHJE?=
 =?utf-8?B?LzMySHhtNnM0aWRlQ1pLTE83REpXRDZSWkxrMXdBbWxzbzh3QTFaa3hXWGZD?=
 =?utf-8?B?Nm05QXcwSElNaDA5Tk02aGZYQnFMSVVHb0lETVBNOUNmUnhreTFyZW9rU3dF?=
 =?utf-8?B?S2grTWVGV0txd1VHT2lvUVRpNE9Qb0ZmM1BCdndScG9Vb0JnQWh5ZkVibk52?=
 =?utf-8?B?WE4wZkNwdFBNVEE4eHVzZVBwUXFNS0cwWnhYY3pkMXFsV1RCdlRuL2pzT3BU?=
 =?utf-8?B?U20yTjYzd0FJajh3NTNOVFNISmxnMVpaS2VUOHlKbHUvU0liM2lPVld2MUJk?=
 =?utf-8?B?THVhU1ViL3FWNFJqMFJURzZwc2hjRC9EWHdCampxUEZWUEtqaDJ2dURTNndE?=
 =?utf-8?B?ZlpoczVGREU1Q2g5TS9SYmdzc0RIa081andBNlNadW5qZXIrelJjUjNQRzNM?=
 =?utf-8?B?TDd0ajcwK25RZ3psWW1CdVNFWjNDZGlrWEdVeHVSdUJKUHRSZmhIUjVLYU9h?=
 =?utf-8?B?bjJyRjFnTGZRUkxxODRPRHFZVE5Ralp1aCtaTitVZTNxV09lY3JUNjR6V3Jx?=
 =?utf-8?B?cmtzcnU1MGt1czdlQ0xmRXJDdzR6VWwraDBkRWlpdlZzdm1KK2I4MmF6OTlJ?=
 =?utf-8?B?QjVlUHFGaFZzUFRnVkwveDQ4QVVCbitheVJxV3YrYmk0SEFoTTdNUlBiemlC?=
 =?utf-8?B?cWU2SVBoem00Um91TUs1aEYvSkk3dVkwbk5kdjAyazZTM2I5Tk14QWV2OUx0?=
 =?utf-8?B?RE5CYnV5Z2lybHh3THpFd2wwdSs3RStIN0xPelp5T0FuWFQ4eDJNQUp2R2VF?=
 =?utf-8?B?eDJsdEZLWUhId1oyZDF2Q3BIMVhVcFczMnR0SktReTRhVjQ3V2t2N2ZuaTBs?=
 =?utf-8?B?UEhPQTJqWkljV25FUTAvVXl5M3VCcUw4aUVqZVY4NG5BOTdDdjZPT21QK3pN?=
 =?utf-8?B?ZUFCZzBsSENHU3ZMZ3diYjhSMC9wWXdTSGVpMm5oQmh3UEJBS1dYM2dldjJL?=
 =?utf-8?B?RVBTNFdGallMVDU0WUVZS3VzRGFGeWhSNHlHcGU3ajduTTJtRmc0TkJXU1Iv?=
 =?utf-8?B?SzFtNDhaMkhOMzNmMzl6a0M2d3MvbUxVVTJidjJTRlZFL3M4ZHdnOVpkSjN3?=
 =?utf-8?B?WEg2Wi9ZTHY1UDE4UFJxL3R5anRpNXoyK3dYM2w0Rkx3bTV3NjZtN2lITW1n?=
 =?utf-8?B?T1dqY1Jva28yMEdLMzYxNEdRTXdxYTVzcEwrZGFpTXhsTWtQUDN1blBPeWhF?=
 =?utf-8?B?cVZNKzN5d3VGaDhOZFUyQm55SUlINVRpc0tneEdkbEpLcXNaa25naUhhazV2?=
 =?utf-8?B?QjRJY2svd0xvZWczWUNtdklLWis5Z01PcjFJTTFXSjZpWk42YlYvWUxtM3N1?=
 =?utf-8?B?NlQ3MGFha2pWeEt4NUs0bzAvaERHaEhNTHF0R1VpejU3ZSttZ1NEOExTUUR1?=
 =?utf-8?B?Zm14aUdHaWIyY2ZwUTFGamJOSFFDRjBiSzE4alRDcWJYQnBpVllJMzAzZ3J5?=
 =?utf-8?B?LzZxWGVQNHRya3VYSnNqSjBVR0hOY2J2SVRLZ2gwRmtaQTRTeWFhLzlBTXlo?=
 =?utf-8?B?RzdMTmd4N3RpTkVKcDJMOTVnVGVsdU12TEpQMHVSaVVvN243RWZVUWdOOTh4?=
 =?utf-8?B?QVV4RHZHQmFSZG1yK2dpbzRjeVRwdjlRbHlLSEdVRkdZZVl0RU9BYmtTekF2?=
 =?utf-8?B?R1dkVU5CSnJ2OUI2emZaRmRBWFlyNU9LTWVmdVZoWGpyK3VuWGxBaE5QOTdt?=
 =?utf-8?Q?JIOLTXr8pnzONCyWOm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d2096d-ad5e-40b7-0d0c-08df43c62e97
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:44:17.9157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRTUpBqW06qIHbQRo/S3mwT0xV+wglODybKwqcRbPSYrn2raGW28kV26KU0EgQKx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB677406
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

On 11/13/26 15:57, Zhigang Luo wrote:
> PDB0 is written directly and does not go through get_vm_pte(). Route
> both entries through amdgpu_gmc_get_vm_pde() so they take the same
> SYSTEM-bit path as every other GFX 12.1 mapping.
> 
> The VRAM entries are PDE_PTEs and already hold a physical address, so
> the translation is skipped and S is set for SPM. The GART PDE is given
> the GART BO's MC address and translated once.
> 
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 659e89e5e78f..04cf02dd22ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1272,7 +1272,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
>  	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
>  	u64 vram_addr, vram_end;
> -	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
> +	u64 pde_addr, pde_flags;
>  	int idx;
>  
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -1290,10 +1290,16 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	vram_end = vram_addr + vram_size;
>  
>  	/* The first n PDE0 entries are used as PTE,
> -	 * pointing to vram
> +	 * pointing to vram. PDE_PTE already holds a physical address, so
> +	 * get_vm_pde() skips translation and sets S for SPM.
>  	 */
> -	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size)
> -		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_addr, flags);
> +	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size) {
> +		pde_addr = vram_addr;
> +		pde_flags = flags;
> +		amdgpu_gmc_get_vm_pde(adev, AMDGPU_VM_PDB0, &pde_addr, &pde_flags);
> +		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, pde_addr,
> +				       pde_flags);
> +	}
>  
>  	/* The n+1'th PDE0 entry points to a huge
>  	 * PTB who has more than 512 entries each
> @@ -1301,8 +1307,12 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	 */
>  	flags = AMDGPU_PTE_VALID;
>  	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PDE_BFS_FLAG(adev, 0);
> -	/* Requires gart_ptb_gpu_pa to be 4K aligned */
> -	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
> +	/* MC address. get_vm_pde() translates it once and sets S for SPM.
> +	 * Requires the GART PT to be 4K aligned.
> +	 */
> +	pde_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
> +	amdgpu_gmc_get_vm_pde(adev, AMDGPU_VM_PDB0, &pde_addr, &flags);
> +	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, pde_addr, flags);
>  	drm_dev_exit(idx);
>  }
>  


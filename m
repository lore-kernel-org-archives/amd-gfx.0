Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4065606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TaiUxaIt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741CD10E5A3;
	Thu, 12 Nov 2026 12:33:09 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013016.outbound.protection.outlook.com
 [40.93.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52AC810E5A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 12:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh0owfxG9HNtX6XRTcjybbbws4Zgwh1aRDJERLN3sN4nQsWiBFvMv2ajQTkP/1678+xY1ggGR6JzAhRy2UD+f4qfGegvAGadCFVBXTmgzqUDa1aW0lVadkdDVFHHhaM2f02b7+CEYLNnQ8qhFtim+js5h5lCr9Cwr8K27cAVtD/fllrsOjVzxi7tIcqhcpU3aKS3qX0u6eTHWP342lSqCGB46GDa9fn+hu7BkRHT7z94MRZXDf92I3FGHo9Q3uEgwJ+gVddMBy+vx+2QKcrabmDE7g8V9RAj8cGZ2q0BmMJ7rRdGgECCXMke7Pw7PyMM1S4OnXT8efC9r0pORx53yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRbdKzTNeBIM/UQcBG680/0vD5psQpzCB5iIFjQgziI=;
 b=r7IJIDWUZ3kXCdNJMFrFWu3SMPx0HZ/52Y0QImgxk9mJ/iUnaA5kG+579M1oz4vOUZAuGO1UKBJZUjEYUO1AAknUC93AGRpDH5Xi5lod5i2A33kYzysip4CjJGbbF8ZeIhGdWpDOJrAigjgbNQJ5689cOih9nbqp+VvuHE+jgnc1snLdBYUOuP3wbQfSkRjyhE1aClIP0whhF+7zC4YrjrPOQeKJFFHca7a9RgsEUiQVSS59lYPoDNB7h6WTi/vQ6nI2cWUbKS7WYc4LwZzM4PstgewL3SIxaLXfq+aeCOt/dLhCWJkxTq7S/lKGmBxVFNNqHHTIo4OadpNMlTyrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRbdKzTNeBIM/UQcBG680/0vD5psQpzCB5iIFjQgziI=;
 b=TaiUxaItepfAShtOSwNjoe7CnPzk208dgYQijRMOjCQLH7IG7ZFYfFIOMBLjG467pYqVqU0X63IHhN9rgt/3lYKuCp40dbi2YkGgX9OQVHBeTt+d3LEvzy5WdNKFWy69a87EJiaDtJEazcxQspVvs6tHzXgZ+Ci17l+rOeBlPAY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 12:33:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 12:32:59 +0000
Message-ID: <38fff3db-25ad-4c7f-a422-5976a63714ff@amd.com>
Date: Thu, 12 Nov 2026 13:32:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: set the A+A VF SYSTEM bit in the GFX 12.1
 helpers
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com, Lijo.Lazar@amd.com
References: <20261111192319.297456-1-Zhigang.Luo@amd.com>
 <20261111192319.297456-3-Zhigang.Luo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261111192319.297456-3-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0346.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e097742-1edf-4579-1dcf-08df40b91622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|261009223027099003|18002099003|261022105027099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: XpX5gja+NNFK/jhCgyShnZi0M3CdaD216GbJCWdFLX8NCT+9XDon4BzvTt/PMgMG2N7ZOnYsWwZyUzeRUrUuGXxH/Bm5yHKdO8t5cDOIPJLHLaTrIj05rEqDLLYQMhIBJmDhBt0C0qKn4cfBaUNMD4N1iCdBXDSgOcGOqNRSAOYow5j5I6s5Ojmxr5bwIYcAmEOaW4yUq9nTjOkNPcohnhQiDMTxXnmgiHRa6HEFXjGEDPUtwbKsNGyccU3ji+AlgoLBWOPmSD9A4eJcXsr7WJEvagDAZIny5VkFEczj91VarSv2Ks5lDEU/lP1FUuO1Algjewr6WW2yOd2bjeAGaqfY1RhPWHCfXLfzXwWBO5AzHtWAoQsLFJr1KirdFOBtdc2PCHIZlC/40sH7RsFRSNypiLXNx7BvApOJtRwanZ/+ylONPGH2hn1bDjDCanMNHsWmFtw+O+Q4dCY/cC8p18Le2QF+p2QaPcqeaku7hl1Ihc+Plc9GkLtDSo2B4kgBf6qsI7XJc5u6yesk5JXwgn6oCehpqod8OuBTDMbO5t6FrbOwjA5FKiFa9AFRY1a4HIwwPXKb3/NNh/WWEMpHcT0k1d4QHc/7t9eR3j/3WT8hFJ6oruZi8x898aEPa5xPq4mKNExLcAPLABvCv5IEngsTNiCu+7nLG4NpIyWI5C4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(261009223027099003)(18002099003)(261022105027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGU4d2JWQVBFTHNWTUdsYlpNcXdSMGJmTWpMUm1BYlNxaUdmd1h2SjEzUUxC?=
 =?utf-8?B?LzlBTjA4N29DV1NzYnNMZHMvRTZFNjRoNzByR0tTOGZzK2dqVXkwL2wvZkRD?=
 =?utf-8?B?dWx1eGQ5R1hoNUhwbmlsakRNZlNicm8vcllCQXRsaFRqdC90RmdFeS9ZNHlV?=
 =?utf-8?B?eitZN3pRMitmOERESnorOU54eXBVUU14RCs3alIxQnNNQlpGSGNhTEk3OFp3?=
 =?utf-8?B?TXRRb0hxT0ppSW00WkJZblBPSlNCUlBQNERaQWxuZDVmTitXdkNKZlpBM2l6?=
 =?utf-8?B?dWtsU1dHd3RYR3d2YXBpem9aWWp2ckYwRU9ET3loUFErNDRuUkJKckxsZmpw?=
 =?utf-8?B?d0JqZE56OXBUN2x4NmZCbzd5L3FoQ0hsajhPaHIrbVA5cEhwYXYvV1dyOHJk?=
 =?utf-8?B?a2tXSHpoMHVReFJSRm5vOEowT1NPbG9oTUYwcXg0RU5Tb2htWC9lZHlzMlZ0?=
 =?utf-8?B?TjJXR2lycXk3NXc0MVBPelkxNmdmV2RPUnBRUFZKbE5ZUjhrcnJRZVJ6bVdi?=
 =?utf-8?B?NEhvVzFhbDE3TkhjdGdDeWVVYXhzWGtLRk51dm5OUTYzNWNyNVhGMHg2bGlx?=
 =?utf-8?B?QXZNeDhrSndMRHliMzBPZXc4ay9nejZTQVBJaGRKa2kzTUlzWTYzN3lWTUF0?=
 =?utf-8?B?SWQxUFFETVd3R1VvWmM1NUVmcXdGaWpCaEJtNHVLbjVsVkQ0MG5WYk5GcFVS?=
 =?utf-8?B?S09kLzRIZlo5S3BoK2JGUzg0RFZZVjJJQnp3YTloZ21HYTFJUmhPVlkwYnZQ?=
 =?utf-8?B?T3kyc25iSS9pQS9Hdk5kREo0MGR0aHliOUo0Y0JPRTBFcXpESlpOaFNodUgx?=
 =?utf-8?B?ZHB1VnBkMFZTSmIvU0twcS85NnJOYm1HeVJNdWRrWGtBMXVaUWY4dkZTSFds?=
 =?utf-8?B?dmNMUHB6enZnWXhJaW5FNmNPT0UxM0trbGdCeGVMZkR1bkZmRk5oa3h2WE4r?=
 =?utf-8?B?UUhDMTExN3VMUHl2UWo0SjFTSERXQmtBYWZZb3ByajhRdzhueUtZSXhoUDU0?=
 =?utf-8?B?bVRpK3lNT0NGdy83T0R6M2w2MW15aHhPMUpvZWNjRUhIYVU3TC9temc3Qzlj?=
 =?utf-8?B?VTZCVytWazArS3AxZWE5am5JTUpXbXUwdUpQWkJnVWNPbVhyQ2h2TDd5VGp0?=
 =?utf-8?B?MTNuTSsxcnY4YzB6OVNUdWNsdE9VUFVvbVc1WFdkODcwUHdEOEVjWUFDVVpF?=
 =?utf-8?B?aVFKSGZCN0U0cmpISjRLdk8zRmVFVGlkeS9zb25pZ2lxVVd3ZEIxK3N1NE5E?=
 =?utf-8?B?WTRlNGQrODhkelJyUWI2akltTHVXQ0syNGVJcm1CVFFVM2xubjNTZVVhL1FY?=
 =?utf-8?B?K1grWTNQWmxmUk9QYkVIOGxnR2VmQUFSUnAvdGMwNURoT05wcC9DWmVDZmhG?=
 =?utf-8?B?YnBGV3dLTVNqaUUvQzE5SmhsaFFZWFBrQTdpZUNhbnorVXQyTVppUENUS3FK?=
 =?utf-8?B?OG5nMUUzUWxUNVpOb1dVWnFPWjZzS0pNWkFjN0l2bjgvWFNIOEFVYmJkemZC?=
 =?utf-8?B?a3N5MzdGNzVDMHpyUjRsb0VjMFZ3NDQ0OUtFeVpweHo1ak9LYWlKV0s5TFI5?=
 =?utf-8?B?SHA3NHVOU0tPQ2dyUXU1czViYzJIU0RRbzVzVVhLVmQ4YkNLRDlYb2VWVERn?=
 =?utf-8?B?bU1wZXZDZnUwRGlVd2puNGZQWEtXVkh3MzVybFhiM2lVaXJnT0RTTnArQktF?=
 =?utf-8?B?RlFIcEl6NUlkM3k2UlNoTnhodVJ1U01UaVNJS2NkQldvSjR4TUJYNTN3SDN0?=
 =?utf-8?B?enhQNWtsMDlZUTdTZjFoankwZ3J0TFNzSlcwNkt0Z0p2MnFiMjJoMm44a3Jl?=
 =?utf-8?B?TUtFd29zeThmZnlCRDhEbUZybkR4bFZBV3IzODJBaXgzTlJlditMWDFhclhC?=
 =?utf-8?B?aW9IdDJ3WEMyTnRNanc3U3R3QS8xNEhtdS8zZ1JYQjEwU3pWTndYNHgyQnZP?=
 =?utf-8?B?OVc4NDc1SUJDUFVFNkJlTWhwSGxlZHMyZ09hbkVTWHRQcVNjMGdUSVdYUnR2?=
 =?utf-8?B?aVkvSTVtWnJEWkxBQkF4K0Z3VU52WTlKODdTTjc0SkZ6dFBXR0Y5djlvYXhu?=
 =?utf-8?B?Q0REb1lFMFBMNTZobHYxYzZJZTZMVVFUWUdRSVRWL2RuOGFERExteGFHa2lQ?=
 =?utf-8?B?ZUxhYUtRSUFkV0NKbHNvdXFLdzFVd2hhZUdvaEVna2d4bm9yYURaNG1zdnlR?=
 =?utf-8?B?YTdmOWp4cFVYTmVxNDlRK1JFZFVlVDZJRFNmYi8zcUd0TExJdHlmckV6Vm1I?=
 =?utf-8?B?UGlrNXlFMExKWlVvdjN3T2NMQmdMVG95MmIvN0xiU3F5QjNSeCtKS2ZUZHJn?=
 =?utf-8?Q?anXbYQLUFWqACiMMBp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e097742-1edf-4579-1dcf-08df40b91622
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:32:59.5767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoOoAWpYOzaxzq4cSSpl4sLTWU0EkEbeJNbxSb2vkELasb5ygYnuZYRdy7NMXbPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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

On 11/11/26 20:23, Zhigang Luo wrote:
> gmc_v12_1_get_vm_pde() converts a VRAM MC address to a physical
> address and skips that conversion when AMDGPU_PTE_SYSTEM is already
> set. Set the bit after the translation so the address stays physical.
> 
> PDB0 is filled through amdgpu_gmc_get_vm_pde() so those entries take
> the same path. The VRAM entries are PDE_PTEs and already hold a
> physical address, so the translation is skipped. The GART PDE is
> given the GART BO's MC address and translated once.
> 
> gmc_v12_1_get_vm_pte() sets the bit only for VRAM. SVM VRAM ranges
> call it with a NULL buffer object and leave the bit clear. NPA
> mappings are left unchanged.
> 
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 22 ++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 12 +++++++++++-
>  2 files changed, 27 insertions(+), 7 deletions(-)
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

That is still a little bit hacky but certainly better than before.

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

Please move those two changes into a separate patch.

>  	drm_dev_exit(idx);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> index 76391fca6c62..0fbf4525947a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -586,6 +586,12 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
>  		*addr = adev->vm_manager.vram_base_offset + *addr -
>  			adev->gmc.vram_start;
>  
> +	/* SPM VRAM is reached at a system physical address. Set S after the
> +	 * translation above so that translation is not skipped.
> +	 */
> +	if (amdgpu_virt_vram_is_spm(adev))
> +		*flags |= AMDGPU_PTE_SYSTEM;
> +
>  	if (*addr & ~adev->gmc.pte_addr_mask) {
>  		dev_err(adev->dev, "Invalid PDE address: %llx\n", *addr);
>  		*addr = 0;
> @@ -756,8 +762,12 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
>  		break;
>  	}
>  
> +	mem = bo ? bo->tbo.resource : NULL;
> +	if (amdgpu_virt_vram_is_spm(adev) &&
> +	    (!mem || mem->mem_type == TTM_PL_VRAM))
> +		*flags |= AMDGPU_PTE_SYSTEM;
> +
>  	if (bo) {
> -		mem = bo->tbo.resource;

Move the check here, this way you don't need to check if there is a BO any more and already have mem.

Apart from those minor comments that looks good to me now.

Regards,
Christian.

>  		if (mem && mem->mem_type == AMDGPU_PL_NPA) {
>  			dev_dbg(adev->dev,
>  				"Setting PTE for NPA BO, mem->type: %d, mem->start: %lx, mem->size: %u, cur_flags: %llx\n",


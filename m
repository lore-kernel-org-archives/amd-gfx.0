Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F0606A33B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ifdUZXYu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D0910E55F;
	Tue, 24 Nov 2026 08:36:51 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0799E10F304
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 08:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOXm3ujrsvrHO1zvV2vazMKPyFDniOKDZD5c6kWzARW2ILJnMTI4d4B+ZrYCDp4EJ7w0rwReg8JXg7hWDaX4ryExfrPSOML2JS7T9ichd14WfafIVdHEJipV3Mx5XiujfjzTfnPqixnD38RGBCe8IOVLn2Qw7NRskSdgoTsQzzD3OUGqzgsS6AWrqn6fp3nB2UX/hLfmLjxOpYFmqq5V5PECgxhPiZNHBiZ9QzpU7Eg4N3RVzH+ngCjEEBv8J4BC1fOQvkPt31nRXKx2RSL7CD4qPFOnO6ZJCy2xf/reZLitTl4s7lkU4S0+UueWKqpqqx2eP2zvmAq3v66MX0+etw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pauIw5f2VWEiZYJTcA3Z7J4eL+PI5wTp97Cpv7lf3Lk=;
 b=od2E1xdp/2T5wu16Fa7dTxAfdmJ3VEsn+7KgA4nOgzqAY1DUoxAlAzaNBGw7e8GYIBjC4v7E/MdAgK7fUMI1dHvvi/7anA41IMWidC8o+HL6H4NquShR5bkjJep51OPqR/hFJ21hwBb/sdmu96pqOxTdjdGfQi7i1URKwLcBAFMFiIFkZNeFB7HK3Ummuv2GQQnzw3yV3nG4EIn3rSmuS6gMGF/Izi4RtfJholAUcXttV10ZQ3kDZsspS0L2/nu1JqX1tQLLTrPMi7ytSC53C77S9/p2VkB2PtECnVKSWsAYmxsPNn9XKGT55FpMwpVk1qZRExXCrmzCLxbVwlkzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pauIw5f2VWEiZYJTcA3Z7J4eL+PI5wTp97Cpv7lf3Lk=;
 b=ifdUZXYuwdN+BPfxtX9PBFhqNGutmeRM0c9+GeDDE9mGg4lNKuGdSTjngCmLYR720h5hQJEE7RMv8J7kZxpFqelHBTicZtsGiqsIqi/r+kgNvIH4wqfUBg4mU+JDje1ra2p1yC7UoBDcztwJfZeH9T9Vs52nzivdwyU0n+cqN60=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by FT1PR12MB035643.namprd12.prod.outlook.com (2603:10b6:170:3c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 08:36:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:36:42 +0000
Message-ID: <1dc5f4d2-e59e-447c-890b-3c39421dd2b7@amd.com>
Date: Tue, 24 Nov 2026 09:36:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/amdgpu: set the A+A VF SYSTEM bit in the GFX 12.1
 helpers
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com, Lijo.Lazar@amd.com
References: <20261116194727.397571-1-Zhigang.Luo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261116194727.397571-1-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|FT1PR12MB035643:EE_
X-MS-Office365-Filtering-Correlation-Id: 38033970-a445-4ef8-42f8-08df4a0610be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|261009223027099003|261021121427099003|261102123227099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: HfiVb/H4mhuoQb9vXYuog6vo3Zux61/3KXHdrquY6egiHp2L+8NfPdG6MmJGBMJcfgKYKsIidcpxdXVonvfnya/9gojxS1dH2l7X66RzRabd4YRE/1h+W8zq227fvNGUx/PRrniolzjQkUoz1OyJnWbgx3J1Ducz+w7z2cEVuSGvYNTipLglb6LiOuJACVp4K3id9gn2TRO+XbcXjw4WfU/FQ1dPzsP+pNxHMhgJQBW1SsKPZza6ElhhEckhpiy9jmpvvvyy4AumGbZza6RMcgabdvEW/1r6b0X/dq+g8uNm92RrXJZ5vBmoH7RxEgki08I7FABZRY8gHLkbQOt5TBYLwGb+unf2iWulyFyikMc9U2Rei+ks7w+xR9uDL9zCIiZYw08oiiIXVOdq28flEARufzNT5/m7Ahz606t/V3ADPO5KdH0AoxT/cnP6Vn8l4xA5eH5pTmKHjyZ3h4EZDGHuZ0sj8nF5B96kc0IAnWuC/DcFbtuyCVy4UEfDvm6edszxCoi2khQDCvvl++AvY/OYxP6bUDspUykhVzcfQ1WcQe0S4oP+HCJ2+02VaPWfnbLLnzXhmnnfAQ139pHrfbQCSEE0EKUu6UF5XFPyy5urd5cON9ENaP2sc9yqbsqyOdXKdy22897pHkOpgJh7I+NzP5NRi1CX6/B9oTiekSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(261009223027099003)(261021121427099003)(261102123227099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFJaalBqdXZaNk1FbjR0RUpvclAvQnllRXBBaVh2a0NydXpOcXEwcU55bG5a?=
 =?utf-8?B?bmRoUmpocUFEM3VYVkIvNFJ5blQwNFJrbEo0Rmh5aVgzUGdsSUR0TWhNNzh4?=
 =?utf-8?B?M0NDb1VSWWZDMVpibW93d0k1Z2FZVUhKTzlDM1ZnckZYL1RKUUhvdWtCOGJw?=
 =?utf-8?B?d2RqT2JDNWdrZFJDT0w3dlJ2Q2ZDUGtqOE5rS1Y0dHFpWnVsQ1lGc1dCWkE3?=
 =?utf-8?B?YlpSY3FaYWNHeHc3dnhOUjkvQUNlR0N5WmYwRTl0WGFyWWN0TkhaZjIwbzFr?=
 =?utf-8?B?YjE3VWhCUmNvUjNGMlh3ZHRBVUhuR2pRVlgrdENGU0hhbUNGVkx6Qno3c0c3?=
 =?utf-8?B?MXhQbTBaV2pBWUtKSlFKZTV1bHQ5NU8wVnFSY1hvTjdhai81SHZKaktPLzNi?=
 =?utf-8?B?cVc0Tk04NUZ4aDFGbGczbDVaVFlSZUUzVk0rMTBOcWhyNDR3aU15emh2dFhv?=
 =?utf-8?B?bzRFV2NEdFM2MHNrR2QreE5XVUNGMTIyV21DVm1GSDFaSmNmL2w1a0craDdz?=
 =?utf-8?B?Q05rcTRPaHpZeTR5eDF6WGpGaTMzNTZBV0ZTaDJycUQxNWtRY3J4NmpNOThs?=
 =?utf-8?B?YXVCQ0lYeGwrM2hRQ255TGV3bys5MzUyaEVMLzh4VTVqQ1d4bVFucE9VaFBN?=
 =?utf-8?B?LzJ1L2tyeHl1QmJVa0tPdUpMWGk3NVc3TG9aZmR5Q2VzaWxYa0l6UzBxbUpJ?=
 =?utf-8?B?U2gxVXpLRVZobXQ2UnU3REN4Ti9VdHU0bGNGTExFQVBRRHlyTEtDNjhaWU42?=
 =?utf-8?B?NkJydi8vYXRWWDFEa0ZzVnFtQmcrYjVvT3JBaHFFT1hORWdTemxjUnRWM3Q0?=
 =?utf-8?B?NWtVamRFUUl1Z1ppa1hqK2gyN20wcWc4K0lxUnBYQW56RjJYVnc2YThsYnY4?=
 =?utf-8?B?RnZJLzZVeUkxK05zM2s3VGNkczNtU2pMVGhUTitJQ2ZXVmxBSkJLRHlINGdr?=
 =?utf-8?B?SjR6TWlGLzFVdUJYMVF6ejk3bWg4eFF0SWEyd1I5UkhvU3FIc1h0OGVqaHFT?=
 =?utf-8?B?Y29ieFBPcURQTFhmcXBmOEtHSnhpckpVcnYyR1VLajZucDNSenZZWWNWc3l1?=
 =?utf-8?B?VDYzNllsMjlBS1Z1dUQwK1lsN1U2WCtmQ2Y2a21BS05XTlVBUkp4NVYxbk5S?=
 =?utf-8?B?RlNxZHc5ZjhzU3FtbzFpTHJGTmMyU2gwL0UrcU0raDhxTUpZVEUyeFlOanZY?=
 =?utf-8?B?WW1qcTBNajhOZy9rZ2pYQ29hWDhnUGFCVlpTS3A5RmV1YTFzbmc4YW9JVGZY?=
 =?utf-8?B?aC9mZjBEcXJMbkVEckloOTlWdy9KdlJkZURCOEdVSnFlUUlVSFlWQkF2eE1E?=
 =?utf-8?B?cW1KR09FZ1BGc2R4UExpNVQwZzdEM3hHYk5mdGR6WnRYcTUxWjJEUkZuTTN2?=
 =?utf-8?B?RmtveHQ1YUsrOUhIMzE1MXFyQW9XZTlhRzNzNzdpeXRWVFhKTDVORXZCMTlY?=
 =?utf-8?B?eDNoMkdZVDQzc2diSnd2SVh3NzN1UUtrd0FkQk5GSXVoR0U4NUNCSXhtaG1C?=
 =?utf-8?B?UkNEeUVNWW1jaXh1Vm5NUUJua0tRcEx3WVlwa1J4OHlqbnVCRUszV0RaL3ZY?=
 =?utf-8?B?SG1HdlhSazV4N0pDNHBpazVVSSs4OE14Mm5oOGN0WDhudWNSdXBWcG1vL2Nx?=
 =?utf-8?B?S3FOemtJbENqUzZSWndYWThpdGlLOGtod1c0OTBWZDVDZmZkdkZndjFsMGlM?=
 =?utf-8?B?NTluMW11dlF0bEUwN2FmaWROK2ZFZHBKV2t2UmU2KzQvVC94T212b2pEQ2cw?=
 =?utf-8?B?UVB0QjBkTDRGZ1o0UGZwQ2tEV1E1WTRXbnJKek1oNGVnelhGcldXbzFqdjZl?=
 =?utf-8?B?OWVoVnIrN2oxM3ZjeURTOUcvaHljbUY1bW5KOWx2R0FDSmVlS0dkQVo3QzhG?=
 =?utf-8?B?NHFickNBSHNNVU9BTHRsOUlxNkNZUS91THRMbUFwVkdmdmRzN01VWDJLRko5?=
 =?utf-8?B?UEpJYXdSa3BpdHp4Q0puY3UvSnhEQ1pJdFdqYlhXckdodTN6eDMvWnhOeThp?=
 =?utf-8?B?NTc2Ty9hU0o3cUpaUTJpRmZXTm5CQXc0Z3l2RXVqa0pHb2lYRmRmd29qcHVI?=
 =?utf-8?B?QUUrNGYxZmdRM3Zrcm9MYUI4bUxTR2Yrc0lHOHB0dFV1NzhlRWFBOEV1Z2dF?=
 =?utf-8?B?dmdrTWJ4cktMWkQxWmVvMncydFF2M2FiWWdkaUNQM3lKQW8rWXhGcmNUcTd2?=
 =?utf-8?B?cWY1Nys4azMzcFplRlN1S0NHdnY2SWhtMEFiWGVBNTAxcnRZT1RkQVBkaEUy?=
 =?utf-8?B?OC9ReDJSUW1qYjJhTXRhbFJWZFVFV3JDTEtBOGdOT3k4eWJtM3R6Z3pYVU9v?=
 =?utf-8?Q?fbPPUYWS/1eAkDy1ti?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38033970-a445-4ef8-42f8-08df4a0610be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:36:42.4743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPub/3vNPEQSt8trX2MZDDUgDYteYhyNpFKoQSjl0N1wrCM7PkFS0xcCRwWP6iHn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB035643
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

On 11/16/26 20:47, Zhigang Luo wrote:
> gmc_v12_1_get_vm_pde() converts a VRAM MC address to a physical
> address and skips that conversion when AMDGPU_PTE_SYSTEM is already
> set. Set the bit after the translation so the address stays physical.
> 
> gmc_v12_1_get_vm_pte() sets the bit for a VRAM buffer object. SVM
> calls it with a NULL buffer object, and svm_range_get_pte_flags()
> sets the bit only for system memory, so the NULL case sets it for
> SPM VRAM. NPA mappings are left unchanged.
> 
> v2:
> - Set the bit for a VRAM BO inside if (bo), and for the SVM NULL BO
>   in the else.
> 
> v3:
> - Set S only when AMDGPU_PTE_VALID is already set, so PRT, clears,
>   and NPA stay unchanged.
> 
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> index 76391fca6c62..507a9c52ccd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -586,6 +586,13 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
>  		*addr = adev->vm_manager.vram_base_offset + *addr -
>  			adev->gmc.vram_start;
>  
> +	/* SPM VRAM is reached at a system physical address. Set S after the
> +	 * translation above so that translation is not skipped. A cleared
> +	 * PDE or an NPA leaf has VALID clear and keeps S clear.
> +	 */
> +	if (amdgpu_virt_vram_is_spm(adev) && (*flags & AMDGPU_PTE_VALID))
> +		*flags |= AMDGPU_PTE_SYSTEM;
> +
>  	if (*addr & ~adev->gmc.pte_addr_mask) {
>  		dev_err(adev->dev, "Invalid PDE address: %llx\n", *addr);
>  		*addr = 0;
> @@ -758,6 +765,11 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
>  
>  	if (bo) {
>  		mem = bo->tbo.resource;
> +		if (amdgpu_virt_vram_is_spm(adev) &&
> +		    (*flags & AMDGPU_PTE_VALID) &&
> +		    mem && mem->mem_type == TTM_PL_VRAM)
> +			*flags |= AMDGPU_PTE_SYSTEM;
> +
>  		if (mem && mem->mem_type == AMDGPU_PL_NPA) {
>  			dev_dbg(adev->dev,
>  				"Setting PTE for NPA BO, mem->type: %d, mem->start: %lx, mem->size: %u, cur_flags: %llx\n",
> @@ -766,6 +778,12 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
>  		} else if (*flags & AMDGPU_PTE_VALID) {
>  			gmc_v12_1_get_coherence_flags(adev, bo, flags);
>  		}
> +	} else if (amdgpu_virt_vram_is_spm(adev) &&
> +		   (*flags & AMDGPU_PTE_VALID)) {
> +		/* SVM has no BO and sets VALID first. System memory already
> +		 * has S. PRT and a clear have VALID clear and stay unchanged.
> +		 */
> +		*flags |= AMDGPU_PTE_SYSTEM;
>  	}
>  }
>  


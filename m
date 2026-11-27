Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AFC606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rCEWDDfg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A70112906;
	Fri, 27 Nov 2026 21:35:01 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516D5112906
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 21:34:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKDN4wiQeIxJbrILDHT9FlMXijjECIOiuBnHGxQjtWzp+aWUB+DwMHgg9BDm7ufV7xfConjPJkAS9n93FjwrytuxEEpfXgrHfwCffZ2N9wQhBdeoGsk0WzO7WT1cX2bwfek6Vos5dCO3cj6/6YAq+LV1pknTFmG1RsM+ELZ/vV/zaIHPFQN2AXV+Iyr5JneDFTJsyrIl7bZ60OCTHY6eNd8o0/CbD49lVTwA21KB9cIRNVakeYaPgVjQweg9INX35l5aB6ALmGK1dV8D8iRA9nMepIfACpnB8OqiWMOWlGgghmFpVYh4NsmiK9FvTj6cO4wefAZnv/i8MTqHTqeR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV3N40/AHuSmaXCRcUxddbDqiGiujB63ONGLNPO+MEc=;
 b=twkKp/Vr+76wGIml5mX9jTdkB/TnKSzLQFpzrmBFj3qsgYx041D5urmyG/i2doU1P+V8SiYF7sR4w7Y0hH4NM/GcoQMmu7jHAymO8D1JH+cKfLxoGLigqzxAQIrMVa+C50MmEet/Uv5s+YUJnKGx0erqIrlXKEz4RtqzmFnjLlrW0OvLB/6IeNLIjytfcrbLFGgt01/HvRaFB01JuJdPXLrmkbN7IvACExqtb11obKMygdSSrqnkiQXqvR6COd9z3gCiREXYP/vm4cbymzDFyOLMVRe2KL61HzMvX15rK2JdL7ywVn70RDXm4YJPCScGwtjxNwD0t88gAt3VbFjPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV3N40/AHuSmaXCRcUxddbDqiGiujB63ONGLNPO+MEc=;
 b=rCEWDDfghRAfz2SXZDDQd3IUqWKlOoyLITa4FySckoMmNpgmktFj+45RiqPq8Uusdw7Qrk4zy3O0r9zrXxGhqqPSCykIlNxERH/jXObSG+ez9uhQBLZx9ZjkW1xDmbAu3i50LPilRkXdVUlEx/Xh7bubAhJC+7AV/znUAgy5TbM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 21:34:52 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 21:34:52 +0000
Content-Type: multipart/alternative;
 boundary="------------Ukp0Ol4XufQAGEbpGB5MAR0w"
Message-ID: <7affc853-ec24-4620-a883-b344f4ded38e@amd.com>
Date: Fri, 27 Nov 2026 16:34:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drm/amdkfd: Add awareness of THP of device and
 system RAM in kfd svm driver
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261122202653.274580-1-xiaogang.chen@amd.com>
 <20261122202653.274580-2-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261122202653.274580-2-xiaogang.chen@amd.com>
X-ClientProxiedBy: YT4PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::20) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 055376c7-145f-4c13-b1d2-08df4cce453a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261022113327099003|261022105027099003|261028144727099003|261102123227099003|261102130727099003|4143699003|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003|6133799003|8096899003;
X-Microsoft-Antispam-Message-Info: eQoYvPz3HlCv7y3QNsaaOnDo/zREsVrYZJZlUZW3CjEMuEcJ4UNdPyLZ02b7PRUIXZhV+wnQ8UmGzEZLknP0efJAk+9aWQcKriBfcUOFeUlI4/s51dpWyqnNHxw74ogwDlzNcBlQwHfFuyHhYvB80qLJbIcIPOQj1ZrJDwMn0AEUEuWJlGA0WSntJMJieNJfpRbiCInKmYVpoim8UOYHruJY+aj06XJH8WdVNwCCPDxFwSK+lT60Pjtr8HmRAvwd0eobJs/iVMSj6pEDOGxZVy9QrjNVcX5hkPzjmm4OZL8KyIu+3Vr4SmIrEyrgF8N6q02C+FZjsnQRq5RDkN2KkGc+Vo3+A2MX1LL6plOQTy2/Bb0/4mKb/R+wPQBtbcDu4FG32Lma9HeVtqIB4xDtMKfVD8eSA/gP3LvwGgC8w2+foX5ePVPZeNTPdxyxJVK3A6xyGP00ja2Xz25D9V24FmlFg/Wc6Jk30XHSB+32qlTEXF1TSRDsyw5Ix+iELObwsFPvIYT8JaTSmq1D8twj73CNhD18AZR3mvQDg7bjeKA9VBKvGD2egsQUy6ajZdmOs8p0ss8ABfHmGL8zv+B533aGAG5o3eRVO2rxmGle40dFEoAbj202OAuYCVOAFTwQMephvt2LJ4gmV/wK5L8x6sSw+foQ+b24KpiuIggHB5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022113327099003)(261022105027099003)(261028144727099003)(261102123227099003)(261102130727099003)(4143699003)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlN6dUNaRk5pTXFwRTRzdTB2ak5nQmdLaGlHSXVCeU02aXJvM3EwNTlVOXVn?=
 =?utf-8?B?S3gzYlAxN1cvUkt2cnkrNEFSVzZkR2RPTVgrWFp6dTIzZ0cvcUFkZnhZeHlU?=
 =?utf-8?B?OWMzbVNuUW9yT2pqZGhGK0d3U25PR1RjMzhvYWNYdHBGMXlSUVFYelVIZHZo?=
 =?utf-8?B?UzgrRU9NVncyOEpJdlZSMGZJdjNvS05EOFRXbUR0bUxLTmZzeEJOa29KYjJv?=
 =?utf-8?B?dHZhRTNWV1hBMEtielYvbnh1dzZJS2dSMmVtNER6SHlYTjd6WStVcVR4WkFP?=
 =?utf-8?B?aGVWMVNLQ3Q1R05jNDY3dEtRcTNkY2xMWjAycGlBUnpEaEFLUUE4dWNCck85?=
 =?utf-8?B?bC9ha1NSamI4NzNBUXc0eGhEQzM3VGs0ckNobm80YlNhYkZFY2J5Vng0R0VO?=
 =?utf-8?B?UkxtcUxsQkhxVWFjOHJkRW1UY3psdXhoMjVIWmxwQ2lWNWU1STFjWUorbHRS?=
 =?utf-8?B?NEh2SUpKSzZMMXNSWGRFTFh6S205bzA3TTE0Ty9Sd3JqdGltc21LQk1pSnRk?=
 =?utf-8?B?QTRJdkE2c0hYeVR0SU5VQUNBVmVqVDJoYkJCaHZhd0pnRnI3b0ZrMXF5ZDR0?=
 =?utf-8?B?NHI5WUdEK2U4dVFFTEJkSkxBTTlEUVhnektyb2ZpdElGcVlrSlFoejJSUWFG?=
 =?utf-8?B?SkR6a2x0dlhMdDRKSDlXY2Y4MEIydUk0WmgrMmpRT09kc21wSk9oQndWdjMw?=
 =?utf-8?B?WkZwQStVc2d3NTlXcjVmUDVoKzR0Tk9VUjEzeVdleTRialhJcHZpS2VqTHkx?=
 =?utf-8?B?UjUrb2ZxWWNVQ3FRL015N00vT2dqNkRKVFZEeklMZ2E1OUtONFJuODd5dllF?=
 =?utf-8?B?R2VWbTB0cHNDekhONlVza0Mya2lzWWlDaW5zbDQyT3dhbS9FMEFSNlhYL25X?=
 =?utf-8?B?NTY3OUVzU3hkS05yYXhPdjZIM1hCUk9vMDBWY01IWUhNSktWNkNmL2lBYy84?=
 =?utf-8?B?a1J2YW1XUXlRVWlINHhPbnF5eC9VYm5qSEZtSElFenFQRDNxcnBPcEEyQW1M?=
 =?utf-8?B?SFBvQmFZbnFYR2ZpdnBadThGV1Q3MFJFNHRBWndNc0IxWldxQllYeDVnMytB?=
 =?utf-8?B?TTVNVVR2RUVRc1pKQkVtL0VJSEtoYmtyK2htNnRNb0xtbDdmV2p1VDJKOW5Y?=
 =?utf-8?B?Z21JQWFCTUdYREo3Y1Q1WCtJcXA4RWJWaFhJZWlZSW9QTWQ3eHNOSUkyS2Jy?=
 =?utf-8?B?QVJwWUxJVEJEMzZRQjdCcEtIdUhYOFRjN2lZUDAxMHlTc0NzMDRkNnlidVUr?=
 =?utf-8?B?NkpteExzTld5ZXV3ckkvNUtQS29nNDNJS1U4UlVhM3NBeXhTL3M4VThpQmRS?=
 =?utf-8?B?YkdOc3JQTWVvNzAyL0NsOVh5bGI1N3k0a3I4M3FUY3ZNVStJTVFJV3NXTndC?=
 =?utf-8?B?WTlzUDNKSHZDUERISU0vODFYM3QxOVVuTThBTHEwamNLcE5ndkNFeTNsMk8z?=
 =?utf-8?B?cEx6L25kMVB1Sjl6ZThFbDhKaURWMU5TMHlFQ01zaHd3dXM0bnlPV05SVS92?=
 =?utf-8?B?YlJZTDM4TkdjWGM5TzJYYUJVWERIcG1PY281WmQ5V3AzZUZQVUZXbVE3Vmo5?=
 =?utf-8?B?d3MzWWFsWnZmT2NPZWV4aDg4UnF6Z1NYRlpqOWF3N0FDTDBuMHR1K1lCUnNB?=
 =?utf-8?B?WE5UMXhBWDExOGhwSWhyVld6dEE0WWJNbE1sTXZaaUU3SEc5RFZTc1VLb2lG?=
 =?utf-8?B?YkVUcDlvc3lMZ1dRd2xOWkpIRW9YNllwSS94Y0VmUFF0Ymx2MWVVR2c2YitT?=
 =?utf-8?B?ZXg5Z1c2MnN5R3ZYMEFVdUpUQXdSUXdiSU1nUXMxdGJMVk5tdE96b1FRNUZn?=
 =?utf-8?B?eEE0SUNPc0hpbkFEcXp2Y0gzQ29id1ZGSHdEc2xxVjBxbTRYeVVienlUcUc0?=
 =?utf-8?B?dms1QXk0VHp4KzhIWUltaytmYmUxQkpka0VOQXhIeWIyREh0UlFpK1FoTHlZ?=
 =?utf-8?B?OEtQYnRpY1d3MmNXdlNMSVh3QmZFdGJ2WHFlZHFEb0VueFZScVd2V3VRc29X?=
 =?utf-8?B?UERRdlBYcmNTTUd4ZDcrWm8rSExha2NrY3BFTXMyQ1A0ZGhjRE50S0dieXdJ?=
 =?utf-8?B?d3NQamxoY2ZwUWc2dzlwN1lzbWgrc2NuaS9oc2R5UStCWWpMS0p0UGY0dTNE?=
 =?utf-8?B?aVVjaXJFN1VlRytpM0xHa2ZxV20zQXNkSWhiQU5wYjl4SjU2UVhFbEFBN0w5?=
 =?utf-8?B?a1dJTkVKM2FRbVR5MnRHSlk0bWZXa1hyZ1E2N2w5NUVTM3pzY0VoTlY2VFov?=
 =?utf-8?B?YUNCQ1ZhNXlobkxNYTljZjc1cFFob3FsKzN5aEtieFNTVmxlOC8xS2drYXpP?=
 =?utf-8?Q?0oh6nXrS/WeHNE5i/m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055376c7-145f-4c13-b1d2-08df4cce453a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 21:34:52.0621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1LC3YrAHOzEeBBFf0LeUbV3VwHBKnxSCrMxALx8UCs5kXhDG/arwTbxQXlIzRhC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------Ukp0Ol4XufQAGEbpGB5MAR0w
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-22 15:26, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> Extend kfd/svm functions to allocate HPAGE_PMD_SIZE based device memory by
> buddy allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned; and to
> allocate THP system ram by vma_alloc_folio.
>
> Introduce SVM_RANGE_DMA_THP flag that indicates dma map of THP. THP dma
> addresss will use this flag.
>
> Add dev_pagemap_ops->folio_split callback that is called by folio_split when
> core MM splits device memory folio.
>
> Reset compound folio of device memory after it got released from core HMM.
> So, TTM can reuse this VRAM as 4K pages on next range.
>
> These are preparations for following support for (THP) migration of zone
> device-private memory, no function change.
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 112 ++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  39 ++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  18 ++++
>   3 files changed, 152 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 1eb92ac6eb05..5ead98a604b1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -218,17 +218,45 @@ svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
>   	return (addr + adev->kfd.pgmap.range.start) >> PAGE_SHIFT;
>   }
>   
> +/*
> + * TTM can reuse a 2MB VRAM block that was previously a device THP.
> + * Reset unused pages so the next 4K init does not see leftover head/tail.
> + */
> +static void svm_migrate_clear_compound_pages(struct page *page, unsigned int nr,
> +					      struct dev_pagemap *pgmap)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nr; i++, page++) {
> +		struct folio *new_folio = (struct folio *)page;
> +
> +		if (page_count(page))
> +			continue;
> +
> +		page->flags.f &= ~0xffUL;
> +#ifdef NR_PAGES_IN_LARGE_FOLIO
> +		((struct folio *)(page - 1))->_nr_pages = 0;
> +#endif
> +		new_folio->mapping = NULL;
> +		new_folio->pgmap = pgmap;
> +		new_folio->share = 0;
> +		page->zone_device_data = NULL;
> +	}
> +}
> +
This is not needed. Commit 12b2285bf3d1 ("mm/zone_device: reinitialize
large zone device private folios") already makes zone_device_page_init()
clear any leftover head/tail state when a page is handed out again.
svm_migrate_get_vram_page() calls zone_device_folio_init() for every VRAM
page it hands out, so the page is reinitialized when it is reused, as a 4K
page or as part of a new THP. There is no need to clear the compound pages
when the folio is freed.
>   static void
> -svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
> +svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
> +			   int order)
>   {
> -	struct page *page;
> +	struct page *page = pfn_to_page(pfn);
>   
> -	page = pfn_to_page(pfn);
> -	svm_range_bo_ref(prange->svm_bo);
> +	/* Init this pfn, not page_folio() — that follows a leftover tail to the old head. */
> +	zone_device_folio_init((struct folio *)page, page_pgmap(page), order);
>   	page->zone_device_data = prange->svm_bo;
Please use folio_set_zone_device_data(page_folio(page), prange->svm_bo).
The result is the same, since page is always the head page here, but it
adds a sanity check and matches how other drivers do it.
> -	zone_device_page_init(page, page_pgmap(page), 0);
> +	svm_range_bo_ref(prange->svm_bo);
>   }
>   
> +
>   static void
>   svm_migrate_put_vram_page(struct amdgpu_device *adev, unsigned long addr)
>   {
> @@ -249,11 +277,45 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
>   }
>   
>   static struct page *
> -svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
> +svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr,
> +			  unsigned long order)
>   {
>   	struct page *page;
>   
> -	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
> +	if (order) {
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
The caller only passes order > 0 on the THP compound page path, so this
#ifdef is not needed.
> +		struct folio *folio;
> +		gfp_t gfp;
> +
> +		/*
> +		 * Honour MADV_NOHUGEPAGE and prctl(PR_SET_THP_DISABLE). The
> +		 * sysfs THP policy (thp_vma_allowable_orders()) and
> +		 * vma_thp_gfp_mask() are not exported to modules.
> +		 */
> +		if (vma_thp_disabled(vma, vma->vm_flags, false))
> +			return NULL;
> +
> +		/*
> +		 * Used by every VRAM to RAM migration (CPU/GPU fault,
> +		 * prefetch, TTM eviction), and the caller falls back to 4K
> +		 * pages on failure. Fail fast like the default "madvise"
> +		 * defrag policy: no direct reclaim or compaction unless the
> +		 * VMA asked for huge pages. Eviction in particular runs under
> +		 * memory pressure, where compaction stalls are most costly.
> +		 */
> +		gfp = GFP_TRANSHUGE_LIGHT;
> +		if (vma->vm_flags & VM_HUGEPAGE)
> +			gfp |= __GFP_DIRECT_RECLAIM;
> +
I think this mixes up the madvise THP policy with THP page migration.
They are separate settings. GFP_TRANSHUGE_LIGHT/GFP_TRANSHUGE are used
internally by core mm (THP fault, khugepaged, NUMA migration), not by
drivers. For the migration destination, please use GFP_HIGHUSER, the same
flag other drivers use in their migrate-to-RAM paths.

> +		folio = vma_alloc_folio(gfp, order, vma, addr);
> +		page = folio ? folio_page(folio, 0) : NULL;
> +#else
> +		return NULL;
> +#endif
> +	} else {
> +		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
> +	}
> +
>   	if (page)
>   		lock_page(page);
>   
> @@ -267,8 +329,13 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
>   
>   	for (i = 0; i < migrate->npages; i++) {
>   		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
> -		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
> -			mpages++;
> +			migrate->src[i] & MIGRATE_PFN_MIGRATE) {
Wrong indentation change.
> +
> +			if (migrate->dst[i] & MIGRATE_PFN_COMPOUND)
> +				mpages += SVM_HPAGE_PMD_NR;
For a compound page, the remaining dst entries are zero, so skip them:

                 i += HPAGE_PMD_NR - 1;

> +			else
> +				mpages++;
> +		}
>   	}
>   	return mpages;
>   }
> @@ -312,7 +379,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   				migrate->dst[i] = 0;
>   				spage = NULL;
>   			} else {
> -				svm_migrate_get_vram_page(prange, migrate->dst[i]);
> +				svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
>   				migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>   				mpages++;
>   			}
> @@ -626,10 +693,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	return r < 0 ? r : 0;
>   }
>   
> +/* folio can be compound folio or single page */
>   static void svm_migrate_folio_free(struct folio *folio)
>   {
>   	struct page *page = &folio->page;
>   	struct svm_range_bo *svm_bo = page->zone_device_data;
> +	struct dev_pagemap *pgmap = folio->pgmap;
> +	unsigned int order = folio_order(folio);
> +
> +	/* So TTM can reuse this VRAM as 4K pages on the next range. */
> +	if (order)
> +		svm_migrate_clear_compound_pages(page, 1U << order, pgmap);
>   
As above, please remove this.

>   	if (svm_bo) {
>   		pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
> @@ -688,7 +762,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			j = 0;
>   		}
>   
> -		dpage = svm_migrate_get_sys_page(migrate->vma, addr);
> +		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
>   		if (!dpage) {
>   			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>   				 prange->svms, prange->start, prange->last);
> @@ -1091,9 +1165,25 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   	return r ? VM_FAULT_SIGBUS : 0;
>   }
>   
> +static void svm_migrate_folio_split(struct folio *head, struct folio *tail)
> +{
> +	struct svm_range_bo *svm_bo;
> +
> +	if (tail == NULL)
> +		return;
> +
> +	tail->pgmap = head->pgmap;
> +	tail->mapping = head->mapping;
> +
> +	svm_bo = folio_zone_device_data(head);
> +	folio_set_zone_device_data(tail, svm_bo);
> +	svm_range_bo_ref(svm_bo);
> +}
> +
>   static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
>   	.folio_free		= svm_migrate_folio_free,
>   	.migrate_to_ram		= svm_migrate_to_ram,
> +	.folio_split		= svm_migrate_folio_split,
>   };
>   
>   /* Each VRAM page uses sizeof(struct page) on system memory */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 421d3f65fcf1..35cebdad5651 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -246,7 +246,16 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>   			continue;
>   		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
> -		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
> +
> +		/* dma unmap of THP */
> +		if (dma_addr[i] & SVM_RANGE_DMA_THP) {
> +			dma_addr[i] &= ~SVM_RANGE_DMA_THP;
> +			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*SVM_HPAGE_PMD_NR,
> +				       DMA_BIDIRECTIONAL);
Clear the entry and skip the rest of the THP here:

             dma_addr[i] = 0;
             i += HPAGE_PMD_NR - 1;


> +		} else {
> +			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
                                    dma_addr[i] = 0;
> +		}
> +
>   		dma_addr[i] = 0;
Then this line can be removed.

Regards,
Philip
>   	}
>   }
> @@ -579,10 +588,20 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   	}
>   
>   	memset(&bp, 0, sizeof(bp));
> +	/*
> +	 * Keep bp.size equal to the prange size so it matches the
> +	 * amdgpu_amdkfd_reserve_mem_limit() reservation made by the caller.
> +	 * A 2MB byte_align makes the VRAM manager allocate 2MB-aligned 2MB
> +	 * buddy blocks and trim only the last one to the requested size, so
> +	 * every full 2MB chunk can still back a device THP.
> +	 */
>   	bp.size = prange->npages * PAGE_SIZE;
> +	if (SVM_THP_ENABLED && prange->npages >= SVM_HPAGE_PMD_NR)
> +		bp.byte_align = SVM_HPAGE_PMD_SIZE;
> +	else
> +		bp.byte_align = PAGE_SIZE;
>   	bp.bo_ptr_size = sizeof(struct svm_range_bo);
>   	bp.destroy = svm_range_bo_destroy;
> -	bp.byte_align = PAGE_SIZE;
>   	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>   	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>   	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
> @@ -594,9 +613,16 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   
>   	r = amdgpu_bo_create(node->adev, &bp, &bo);
>   	if (r) {
> -		pr_debug("failed %d to create bo\n", r);
> -		mmput(mm);
> -		goto create_bo_failed;
> +		if (bp.byte_align == SVM_HPAGE_PMD_SIZE) {
> +			/* fall back PAGE_SIZE granularity */
> +			bp.byte_align = PAGE_SIZE;
> +			r = amdgpu_bo_create(node->adev, &bp, &bo);
> +		}
> +		if (r) {
> +			pr_debug("failed %d to create bo\n", r);
> +			mmput(mm);
> +			goto create_bo_failed;
> +		}
>   	}
>   
>   	svm_bo = to_svm_range_bo(bo);
> @@ -957,6 +983,7 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
>   	*vram_pages = 0;
>   	for (i = 0; i < num_elements; i++) {
>   		dma_addr_t *temp;
> +
>   		temp = (dma_addr_t *)dst + i;
>   		*temp = *((dma_addr_t *)src + i);
>   		if (*temp&SVM_RANGE_VRAM_DOMAIN)
> @@ -1675,7 +1702,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
>   	uint32_t gpuidx;
>   	int r;
>   
> -	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
> +	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
>   	drm_exec_until_all_locked(&ctx->exec) {
>   		for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
>   			pdd = kfd_process_device_from_gpuidx(ctx->process, gpuidx);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 38744e716f74..8767a784e679 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -35,6 +35,24 @@
>   #include "kfd_priv.h"
>   
>   #define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
> +#define SVM_RANGE_DMA_THP (1UL << 1)
> +
> +/*
> + * Size of a PMD-mapped device or system THP. HPAGE_PMD_* expand to
> + * BUILD_BUG() without CONFIG_TRANSPARENT_HUGEPAGE, so the SVM code uses
> + * these instead. Without THP, SVM_THP_ENABLED is false, no compound
> + * migration is requested, and HMM never reports MIGRATE_PFN_COMPOUND, so
> + * the THP paths still compile but are never taken.
> + */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define SVM_HPAGE_PMD_ORDER	HPAGE_PMD_ORDER
> +#else
> +#define SVM_HPAGE_PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> +#endif
> +#define SVM_HPAGE_PMD_NR	(1UL << SVM_HPAGE_PMD_ORDER)
> +#define SVM_HPAGE_PMD_SIZE	(PAGE_SIZE << SVM_HPAGE_PMD_ORDER)
> +#define SVM_THP_ENABLED		IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> +
>   #define SVM_ADEV_PGMAP_OWNER(adev)\
>   			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
>   

--------------Ukp0Ol4XufQAGEbpGB5MAR0w
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-22 15:26, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

Extend kfd/svm functions to allocate HPAGE_PMD_SIZE based device memory by
buddy allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned; and to
allocate THP system ram by vma_alloc_folio.

Introduce SVM_RANGE_DMA_THP flag that indicates dma map of THP. THP dma
addresss will use this flag.

Add dev_pagemap_ops-&gt;folio_split callback that is called by folio_split when
core MM splits device memory folio.

Reset compound folio of device memory after it got released from core HMM.
So, TTM can reuse this VRAM as 4K pages on next range.

These are preparations for following support for (THP) migration of zone
device-private memory, no function change.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 112 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  39 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  18 ++++
 3 files changed, 152 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 1eb92ac6eb05..5ead98a604b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -218,17 +218,45 @@ svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
 	return (addr + adev-&gt;kfd.pgmap.range.start) &gt;&gt; PAGE_SHIFT;
 }
 
+/*
+ * TTM can reuse a 2MB VRAM block that was previously a device THP.
+ * Reset unused pages so the next 4K init does not see leftover head/tail.
+ */
+static void svm_migrate_clear_compound_pages(struct page *page, unsigned int nr,
+					      struct dev_pagemap *pgmap)
+{
+	unsigned int i;
+
+	for (i = 0; i &lt; nr; i++, page++) {
+		struct folio *new_folio = (struct folio *)page;
+
+		if (page_count(page))
+			continue;
+
+		page-&gt;flags.f &amp;= ~0xffUL;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+		((struct folio *)(page - 1))-&gt;_nr_pages = 0;
+#endif
+		new_folio-&gt;mapping = NULL;
+		new_folio-&gt;pgmap = pgmap;
+		new_folio-&gt;share = 0;
+		page-&gt;zone_device_data = NULL;
+	}
+}
+</pre>
    </blockquote>
    This is not needed. Commit 12b2285bf3d1 (&quot;mm/zone_device:
    reinitialize<br>
    large zone device private folios&quot;) already makes
    zone_device_page_init()<br>
    clear any leftover head/tail state when a page is handed out again.<br>
    svm_migrate_get_vram_page() calls zone_device_folio_init() for every
    VRAM<br>
    page it hands out, so the page is reinitialized when it is reused,
    as a 4K<br>
    page or as part of a new THP. There is no need to clear the compound
    pages<br>
    when the folio is freed.
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 static void
-svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
+svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
+			   int order)
 {
-	struct page *page;
+	struct page *page = pfn_to_page(pfn);
 
-	page = pfn_to_page(pfn);
-	svm_range_bo_ref(prange-&gt;svm_bo);
+	/* Init this pfn, not page_folio() — that follows a leftover tail to the old head. */
+	zone_device_folio_init((struct folio *)page, page_pgmap(page), order);
 	page-&gt;zone_device_data = prange-&gt;svm_bo;</pre>
    </blockquote>
    Please use folio_set_zone_device_data(page_folio(page),
    prange-&gt;svm_bo).<br>
    The result is the same, since page is always the head page here, but
    it<br>
    adds a sanity check and matches how other drivers do it.
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
-	zone_device_page_init(page, page_pgmap(page), 0);
+	svm_range_bo_ref(prange-&gt;svm_bo);
 }
 
+
 static void
 svm_migrate_put_vram_page(struct amdgpu_device *adev, unsigned long addr)
 {
@@ -249,11 +277,45 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
 }
 
 static struct page *
-svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
+svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr,
+			  unsigned long order)
 {
 	struct page *page;
 
-	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+	if (order) {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE</pre>
    </blockquote>
    The caller only passes order &gt; 0 on the THP compound page path,
    so this<br>
    #ifdef is not needed.
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		struct folio *folio;
+		gfp_t gfp;
+
+		/*
+		 * Honour MADV_NOHUGEPAGE and prctl(PR_SET_THP_DISABLE). The
+		 * sysfs THP policy (thp_vma_allowable_orders()) and
+		 * vma_thp_gfp_mask() are not exported to modules.
+		 */
+		if (vma_thp_disabled(vma, vma-&gt;vm_flags, false))
+			return NULL;
+</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		/*
+		 * Used by every VRAM to RAM migration (CPU/GPU fault,
+		 * prefetch, TTM eviction), and the caller falls back to 4K
+		 * pages on failure. Fail fast like the default &quot;madvise&quot;
+		 * defrag policy: no direct reclaim or compaction unless the
+		 * VMA asked for huge pages. Eviction in particular runs under
+		 * memory pressure, where compaction stalls are most costly.
+		 */
+		gfp = GFP_TRANSHUGE_LIGHT;
+		if (vma-&gt;vm_flags &amp; VM_HUGEPAGE)
+			gfp |= __GFP_DIRECT_RECLAIM;
+</pre>
    </blockquote>
    I think this mixes up the madvise THP policy with THP page
    migration.<br>
    They are separate settings. GFP_TRANSHUGE_LIGHT/GFP_TRANSHUGE are
    used<br>
    internally by core mm (THP fault, khugepaged, NUMA migration), not
    by<br>
    drivers. For the migration destination, please use GFP_HIGHUSER, the
    same<br>
    flag other drivers use in their migrate-to-RAM paths.<br>
    <br>
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		folio = vma_alloc_folio(gfp, order, vma, addr);
+		page = folio ? folio_page(folio, 0) : NULL;
+#else
+		return NULL;
+#endif
+	} else {
+		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+	}
+
 	if (page)
 		lock_page(page);
 
@@ -267,8 +329,13 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 
 	for (i = 0; i &lt; migrate-&gt;npages; i++) {
 		if (migrate-&gt;dst[i] &amp; MIGRATE_PFN_VALID &amp;&amp;
-		    migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE)
-			mpages++;
+			migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {</pre>
    </blockquote>
    Wrong indentation change.
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+			if (migrate-&gt;dst[i] &amp; MIGRATE_PFN_COMPOUND)
+				mpages += SVM_HPAGE_PMD_NR;</pre>
    </blockquote>
    For a compound page, the remaining dst entries are zero, so skip
    them:<br>
    <br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i += HPAGE_PMD_NR - 1;<br>
    <br>
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+			else
+				mpages++;
+		}
 	}
 	return mpages;
 }
@@ -312,7 +379,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 				migrate-&gt;dst[i] = 0;
 				spage = NULL;
 			} else {
-				svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
+				svm_migrate_get_vram_page(prange, migrate-&gt;dst[i], 0);
 				migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
 				mpages++;
 			}
@@ -626,10 +693,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	return r &lt; 0 ? r : 0;
 }
 
+/* folio can be compound folio or single page */
 static void svm_migrate_folio_free(struct folio *folio)
 {
 	struct page *page = &amp;folio-&gt;page;
 	struct svm_range_bo *svm_bo = page-&gt;zone_device_data;
+	struct dev_pagemap *pgmap = folio-&gt;pgmap;
+	unsigned int order = folio_order(folio);
+
+	/* So TTM can reuse this VRAM as 4K pages on the next range. */
+	if (order)
+		svm_migrate_clear_compound_pages(page, 1U &lt;&lt; order, pgmap);
 </pre>
    </blockquote>
    As above, please remove this.<br>
    <br>
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	if (svm_bo) {
 		pr_debug_ratelimited(&quot;ref: %d\n&quot;, kref_read(&amp;svm_bo-&gt;kref));
@@ -688,7 +762,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr);
+		dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr, 0);
 		if (!dpage) {
 			pr_debug(&quot;failed get page svms 0x%p [0x%lx 0x%lx]\n&quot;,
 				 prange-&gt;svms, prange-&gt;start, prange-&gt;last);
@@ -1091,9 +1165,25 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	return r ? VM_FAULT_SIGBUS : 0;
 }
 
+static void svm_migrate_folio_split(struct folio *head, struct folio *tail)
+{
+	struct svm_range_bo *svm_bo;
+
+	if (tail == NULL)
+		return;
+
+	tail-&gt;pgmap = head-&gt;pgmap;
+	tail-&gt;mapping = head-&gt;mapping;
+
+	svm_bo = folio_zone_device_data(head);
+	folio_set_zone_device_data(tail, svm_bo);
+	svm_range_bo_ref(svm_bo);
+}
+
 static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
 	.folio_free		= svm_migrate_folio_free,
 	.migrate_to_ram		= svm_migrate_to_ram,
+	.folio_split		= svm_migrate_folio_split,
 };
 
 /* Each VRAM page uses sizeof(struct page) on system memory */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 421d3f65fcf1..35cebdad5651 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -246,7 +246,16 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
 		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
 			continue;
 		pr_debug_ratelimited(&quot;unmap 0x%llx\n&quot;, dma_addr[i] &gt;&gt; PAGE_SHIFT);
-		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
+
+		/* dma unmap of THP */
+		if (dma_addr[i] &amp; SVM_RANGE_DMA_THP) {
+			dma_addr[i] &amp;= ~SVM_RANGE_DMA_THP;
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*SVM_HPAGE_PMD_NR,
+				       DMA_BIDIRECTIONAL);</pre>
    </blockquote>
    Clear the entry and skip the rest of the THP here:<br>
    <br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dma_addr[i] = 0;<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i += HPAGE_PMD_NR - 1;<br>
    <br>
    <br>
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		} else {
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);</pre>
    </blockquote>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dma_addr[i] = 0;
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		}
+
 		dma_addr[i] = 0;</pre>
    </blockquote>
    Then this line can be removed.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	}
 }
@@ -579,10 +588,20 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	}
 
 	memset(&amp;bp, 0, sizeof(bp));
+	/*
+	 * Keep bp.size equal to the prange size so it matches the
+	 * amdgpu_amdkfd_reserve_mem_limit() reservation made by the caller.
+	 * A 2MB byte_align makes the VRAM manager allocate 2MB-aligned 2MB
+	 * buddy blocks and trim only the last one to the requested size, so
+	 * every full 2MB chunk can still back a device THP.
+	 */
 	bp.size = prange-&gt;npages * PAGE_SIZE;
+	if (SVM_THP_ENABLED &amp;&amp; prange-&gt;npages &gt;= SVM_HPAGE_PMD_NR)
+		bp.byte_align = SVM_HPAGE_PMD_SIZE;
+	else
+		bp.byte_align = PAGE_SIZE;
 	bp.bo_ptr_size = sizeof(struct svm_range_bo);
 	bp.destroy = svm_range_bo_destroy;
-	bp.byte_align = PAGE_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
@@ -594,9 +613,16 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 
 	r = amdgpu_bo_create(node-&gt;adev, &amp;bp, &amp;bo);
 	if (r) {
-		pr_debug(&quot;failed %d to create bo\n&quot;, r);
-		mmput(mm);
-		goto create_bo_failed;
+		if (bp.byte_align == SVM_HPAGE_PMD_SIZE) {
+			/* fall back PAGE_SIZE granularity */
+			bp.byte_align = PAGE_SIZE;
+			r = amdgpu_bo_create(node-&gt;adev, &amp;bp, &amp;bo);
+		}
+		if (r) {
+			pr_debug(&quot;failed %d to create bo\n&quot;, r);
+			mmput(mm);
+			goto create_bo_failed;
+		}
 	}
 
 	svm_bo = to_svm_range_bo(bo);
@@ -957,6 +983,7 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
 	*vram_pages = 0;
 	for (i = 0; i &lt; num_elements; i++) {
 		dma_addr_t *temp;
+
 		temp = (dma_addr_t *)dst + i;
 		*temp = *((dma_addr_t *)src + i);
 		if (*temp&amp;SVM_RANGE_VRAM_DOMAIN)
@@ -1675,7 +1702,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
 	uint32_t gpuidx;
 	int r;
 
-	drm_exec_init(&amp;ctx-&gt;exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
+	drm_exec_init(&amp;ctx-&gt;exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
 	drm_exec_until_all_locked(&amp;ctx-&gt;exec) {
 		for_each_set_bit(gpuidx, ctx-&gt;bitmap, MAX_GPU_INSTANCE) {
 			pdd = kfd_process_device_from_gpuidx(ctx-&gt;process, gpuidx);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 38744e716f74..8767a784e679 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -35,6 +35,24 @@
 #include &quot;kfd_priv.h&quot;
 
 #define SVM_RANGE_VRAM_DOMAIN (1UL &lt;&lt; 0)
+#define SVM_RANGE_DMA_THP (1UL &lt;&lt; 1)
+
+/*
+ * Size of a PMD-mapped device or system THP. HPAGE_PMD_* expand to
+ * BUILD_BUG() without CONFIG_TRANSPARENT_HUGEPAGE, so the SVM code uses
+ * these instead. Without THP, SVM_THP_ENABLED is false, no compound
+ * migration is requested, and HMM never reports MIGRATE_PFN_COMPOUND, so
+ * the THP paths still compile but are never taken.
+ */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define SVM_HPAGE_PMD_ORDER	HPAGE_PMD_ORDER
+#else
+#define SVM_HPAGE_PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
+#endif
+#define SVM_HPAGE_PMD_NR	(1UL &lt;&lt; SVM_HPAGE_PMD_ORDER)
+#define SVM_HPAGE_PMD_SIZE	(PAGE_SIZE &lt;&lt; SVM_HPAGE_PMD_ORDER)
+#define SVM_THP_ENABLED		IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
+
 #define SVM_ADEV_PGMAP_OWNER(adev)\
 			((adev)-&gt;hive ? (void *)(adev)-&gt;hive : (void *)(adev))
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------Ukp0Ol4XufQAGEbpGB5MAR0w--

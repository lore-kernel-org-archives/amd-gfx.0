Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C566EE0211
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 22:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0593D10E0FB;
	Wed, 13 Sep 2023 22:03:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CB910E0FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 22:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0vtMBAI91DZolkHsNbrbzUbSBy/zSzUWdH83Pr5iyyOsJE4A3QK0I01so3ix/KZiCvvTHTqUO8PvJbfAMz1mhDScktz3ZJCIH9qmox95PRPR7Zt3SyOgRJ3kDO0q9UY6FZVDxcawfg8/cn7d+YmSkFsbul+IrWVEwK7dBodgnIh0l3KW8EUbMMBwBYzOr/smfHTx7n65WLmdBBegFePCf7yNDgOtKOVGXk9BlF2sFxeUURR/qko4C2ADNlxhWDLzd8eXKXzEdA4F+6QF7EG7wa299NibyP/gDcgGtd8OavT/01TjLuBCLhOJ2/lwcrgCXPrpckMhmtBcIv/I3nwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBHqTyhGaCwxlvfkXFWWzpmd2bJ6OXUpq7iEujg2oa0=;
 b=AmPCdAuW0PRAkHj7SrNhGeQV5pvOjoy1nDVT8f7OIka1pt2TwrOmrEGxPV7gSl1WjZUJavcSZXHiOBQV95RcXAy1D6Gz2EReLVpCz2DdgTGMbxvoj6w5NNwuPFHcGeOuwCwQapU9ZKrh36+7HbbFMVasfsYX1JAu51xSAFq3JA009ODPI5aEM/PBdG5sBSIzW65Q3EWFFy6OpYp3hRqek0al/Wg+kirYneFxY22aylTJ5fcuJPHEC7rPn57zBC1k+g2fwD5OC1eq4INNu7bBLoUsWC0SMnmdHiIT25ZhCw2+IFseDQUUp+M9hlE42bGJaesW77MaFhgDE9YRagONbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBHqTyhGaCwxlvfkXFWWzpmd2bJ6OXUpq7iEujg2oa0=;
 b=f/xafVlzMzlZrdJLkjSPC+mK+RdfnEFTnHxbyr5VDMdf2YbKnhDxt5PIphivWuhlpHe5FR6U1UewwPlzvsoK4m7Pd47ra9ARtB+pa6/Vm84Emlb1c6CpSzgfTSSL01TLciMssSIF5e382OIeuwJXWnX41nwZIFsd4Z3Ub1TNZbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 22:03:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 22:03:09 +0000
Message-ID: <725b7649-5d55-9d3e-cb66-43c8fe2a3e87@amd.com>
Date: Wed, 13 Sep 2023 18:03:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: Use partial migrations in GPU page faults
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230911140430.106717-1-xiaogang.chen@amd.com>
Content-Language: en-US
Organization: AMD Inc.
In-Reply-To: <20230911140430.106717-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0292.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcb25d2-8e32-4490-9e75-08dbb4a5375d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knMDzLFa5zMgHpNQil2NRbvXYUemZlLOwoox7E66/j083oKj+//dlljC+oJhmRxgRlbTdI8dtRzEK+Stz0/HyoWtYWQq8HXw2Zm9njjNJ32XUGR69dKZ0mehu0SznwMSYYNLz+zmgzUTWNOZ+V6ARzUHsWzK0KL/0MxEh+WLRzsQvLTPbwwNE89NUUHkSAe+MYDi3rit1kIEDVJAdw2iD4JJdPuHnQO/rMs2kS5cqBGxLoZjPP1JkgqxFNAOM7wVfDaPw2dADE4Ki+rUsovPydpHNpYQF4gTesisGQGNCTqtHnAMuGOcRIgkR21heFu5yEMLTq36h4LbVR5oc4Duc3k4duIqaUgSNYwtj8XwLijHaguNjZqhLx7WVaUABCqj64Ls8VfucPDzNOcH0vR9AuHmGpIdYusoZEl8jiQUkgvU7zjLXRUkEp8m1Sdw6H0COQq+/1Fu7YpHlIGELgJdzwOM9CKNtpN50qzGYvB3mfwqayBzjjWD+fEV9IX3K/RzoiWhgJRHvBms4MdNSqmlMWq9jIKkNB62AUKOF38gyQMJmJBDa1B4H3iWbzwKIUpcHcj1ihvWCPSXNso3NTxnSrIfMNAktpi1q1PqDjDyKaQ0htIi5sRxSsFzKibsIKfmDaEChh69RLxjwmwCn0A8FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(1800799009)(186009)(451199024)(31686004)(6666004)(6486002)(53546011)(36916002)(6506007)(86362001)(31696002)(38100700002)(36756003)(26005)(2616005)(30864003)(2906002)(6512007)(478600001)(83380400001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(44832011)(66476007)(316002)(66946007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2ViQVNJR3J6S3B0bXQzd0x6L1FRb2RLV2p1ZSsvWEVVZG9ldUdqclZjUXRF?=
 =?utf-8?B?b2dUcis1eUVJSGRXR2FmQ0svUHBRdUJUK2lPMVZNbERJaWhwTXEyRElJbkFI?=
 =?utf-8?B?VEJZYlFVRE1WL3FadVlKbXJqaGp6eW1EYTZwcWhKQXdjMG5RZytSODM1RExB?=
 =?utf-8?B?K1hqQnJ2Umdld043MTJXbU5Bb09GSU9XVDF5VkxnSmhjcnN3MEZla1p6ZU5P?=
 =?utf-8?B?Y2hWc1Z5S01UUzhNYkR0akhRTVIreDlpeGNRdnNMaUxRSW4zV3dqM0RnRjNh?=
 =?utf-8?B?UEp1TVQrekpKdXhadm1UV3Z5WnpaaWgxUnhEeTYrNUxha25Mc0gxR2cwdW9W?=
 =?utf-8?B?WnZVclpqMXhZcDRrNFRVUEplazdTMzVNcGhkTGNlNW10Ykl1RW9HSFUralI3?=
 =?utf-8?B?ZlRXaG0rRnNqSytyMW5tZFJDbnlwTDREYmY2eGVld2FidCtnWEtYUVdoOXdy?=
 =?utf-8?B?NEtieUNMUnJheVhEYTZKL3lCT3Y5WndlSld4RGdzVUVGd1ZJcWdaVmFGMVJo?=
 =?utf-8?B?WVo1YzFLdnFRK0ZzOFlHVDVrK245azNrRk1oeno0SXI3VnNRbFA4aE5hQ0xU?=
 =?utf-8?B?QkZrTVJVSU1EQXNORWoyV2JldGVjOVd6NytYM3BQNjBEV2wzdUdOWlBFZFBj?=
 =?utf-8?B?Qm5JS0E5a0pIRjRkWHVOTTU0RFllelNKRXZodW5GMU9TMTFDZWdtbjhtcENH?=
 =?utf-8?B?MHY1TTVNK295NFNpbDA5Vk5YRXNGMVcrMU9QSkdvQmZDTkpmWlN2YW85YlU0?=
 =?utf-8?B?bUtMbE1UZ25RUVlpZ0o5TDVxenVlUVA3eVIreDVoR2dMcDZjdWhDRkhudXFm?=
 =?utf-8?B?am15Q3JEelN1dHlJeHdsUGo4eG9XNEdJYnVJWnZVRXR1NDZka014ZTR6NnQ2?=
 =?utf-8?B?RDAram9MZHhWSUNEaG90SGpieFc2cExBL3pka3lDZldmejFnRUVZMU0raVA4?=
 =?utf-8?B?dmRvYUdTMUIrOXFrbGdMM2daTkpWeS85NFBGVU0ycm1vMVRQYmpBRlNHMHdO?=
 =?utf-8?B?VWFlVHNFK0xKNFMwbmQxYlNTdE1UdnRKOUFqY0NRQmkvb1JxeVJOblN3YXJ6?=
 =?utf-8?B?WDFldDVaM1YxWU9yRUE3Y0VIVVpORUlFeVVncko0c0ZVaSs1YXcyRlhMOGVX?=
 =?utf-8?B?aEwrcVZyUW1mOFY5QXZzcmNLMWlvdk5CTDArVmpGbDZBZEhxcTVrdHhSd2FI?=
 =?utf-8?B?WG1pNzNyTmZSOXNTR3VvS25DQnFJMGVIcStuUzZCdGZhdkJJZXRrQ2dxc1Zk?=
 =?utf-8?B?NzNzaHVOandCeVUyZ3RRTEc5VUJaUHRZNGdlNzBGWGV1WEQzMkxMNmdQeVJj?=
 =?utf-8?B?RXR6K0t3TDk2bUNlMURjcWZ3c3h6a2lBdWRSNGdzQitHOHFVM1VSdldhaVZu?=
 =?utf-8?B?M0JWUlBYdEJKT1V0c3UwcDVYSFA5ZUczOVNpVDFIVjE5MEVlMUFzaHpHb2FO?=
 =?utf-8?B?RWFNd3F6WHRuUmsyWjQ4cnZVRm9OYUdtSXBUSUJzUXExV2p2T2VFeExlYSsz?=
 =?utf-8?B?cGxEanhpRTdsM3V6alRaa0QzNHRLaUdKalNLYlIwWlNOeXFlM3pGSFQzcitS?=
 =?utf-8?B?TjRHUit3RVJzV25FMjhlcE43QnFaWVVGODk4YUF5ZmdQaldmc3hORGFzU2pD?=
 =?utf-8?B?aGF2QlYrd2dsTFNPL1ZacU43U3hmaDBxbFlSTjk4ZDJhY3Z6eVZRU0hIWDBo?=
 =?utf-8?B?bnF0dDUxVUlxYnRzdzAxQ3ArdzM5dE9nbmZodlBoZUU1cTJLL3FJaHNFU2lo?=
 =?utf-8?B?elUwTjRMamRCcmFXWm5xR2k3eXoxME1jb1puS2pGQWZWRmdFYk10V1kvZTRl?=
 =?utf-8?B?L1ovdlYweW5hY09jS3hhc3l0YmU4eHAzZmk2TDVFSSt3UW00cnQzNjVOVE92?=
 =?utf-8?B?OExCK2F2RTU2bWx2MC9PZWd0SG41Yk9KMlBySmtHSkxBSFNYOXRRNEw3MjVT?=
 =?utf-8?B?eXA4TGE0bFB0bVkySXMrZWxtRlh3dlNVOXFkV1crYndrODRFYm5jNEV6MkJG?=
 =?utf-8?B?WldNMHVMUTdzK1pnTDJJZ0MzdEZ6MHR2WHRpeVFRM1RXcGZleTd4VXpRVFhE?=
 =?utf-8?B?eXd4emtaWC8zY0h1VXN4dTJXeXl1NkJ1eWFUVWZ6VnIvaWpyOHVHZTRZZWI4?=
 =?utf-8?Q?YyuPTWovYSMTewibo3Vse9Hdv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcb25d2-8e32-4490-9e75-08dbb4a5375d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 22:03:09.6085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvmOpbPjgvOXo26Z9RfTgMqU3AruJpuhOwQh3SPfs+b6lCjMxbkF7NWs0ekSslIe9ukRUVaQgu7Iuvad4PE1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-11 10:04, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> This patch implements partial migration in gpu page fault according to migration
> granularity(default 2MB) and not split svm range in cpu page fault handling.
> A svm range may include pages from both system ram and vram of one gpu now.
> These chagnes are expected to improve migration performance and reduce
> mmu callback and TLB flush workloads.
>
> Signed-off-by: xiaogang chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 151 ++++++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  88 ++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   7 +-
>   4 files changed, 171 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 7d82c7da223a..653a2edbaba4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -445,7 +445,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",

Should this message also be updated: migrated -> collected?


>   			 cpages, npages);
>   	else
> -		pr_debug("0x%lx pages migrated\n", cpages);
> +		pr_debug("0x%lx pages collected\n", cpages);
>   
>   	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
>   	migrate_vma_pages(&migrate);
> @@ -479,6 +479,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>    * svm_migrate_ram_to_vram - migrate svm range from system to device
>    * @prange: range structure
>    * @best_loc: the device to migrate to
> + * @start_mgr: start page to migrate
> + * @last_mgr: last page to migrate
>    * @mm: the process mm structure
>    * @trigger: reason of migration
>    *
> @@ -489,6 +491,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>    */
>   static int
>   svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
> +			unsigned long start_mgr, unsigned long last_mgr,
>   			struct mm_struct *mm, uint32_t trigger)
>   {
>   	unsigned long addr, start, end;
> @@ -498,23 +501,30 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	unsigned long cpages = 0;
>   	long r = 0;
>   
> -	if (prange->actual_loc == best_loc) {
> -		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
> -			 prange->svms, prange->start, prange->last, best_loc);
> +	if (!best_loc) {
> +		pr_debug("request svms 0x%p [0x%lx 0x%lx] migrate to sys ram\n",

This message seems incorrect. This function migrates to VRAM.


> +			 prange->svms, start_mgr, last_mgr);
>   		return 0;
>   	}
>   
> +	if (start_mgr < prange->start || last_mgr > prange->last) {
> +		pr_debug("migration range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
> +				 start_mgr, last_mgr, prange->start, prange->last);
> +		return -EFAULT;
> +	}
> +
>   	node = svm_range_get_node_by_id(prange, best_loc);
>   	if (!node) {
>   		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
>   		return -ENODEV;
>   	}
>   
> -	pr_debug("svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n", prange->svms,
> -		 prange->start, prange->last, best_loc);
> +	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
> +			 prange->svms, start_mgr, last_mgr, prange->start, prange->last,
> +			 best_loc);
>   
> -	start = prange->start << PAGE_SHIFT;
> -	end = (prange->last + 1) << PAGE_SHIFT;
> +	start = start_mgr << PAGE_SHIFT;
> +	end = (last_mgr + 1) << PAGE_SHIFT;
>   
>   	r = svm_range_vram_node_new(node, prange, true);
>   	if (r) {
> @@ -544,8 +554,11 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   
>   	if (cpages) {
>   		prange->actual_loc = best_loc;
> -		svm_range_free_dma_mappings(prange, true);
> -	} else {
> +		prange->vram_pages = prange->vram_pages + cpages;
> +	} else if (!prange->actual_loc) {
> +		/* if no page migrated and all pages from prange are at
> +		 * sys ram drop svm_bo got from svm_range_vram_node_new
> +		 */
>   		svm_range_vram_node_free(prange);
>   	}
>   
> @@ -670,7 +683,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   static long
>   svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
> -		       uint32_t trigger, struct page *fault_page)
> +		       uint32_t trigger, struct page *fault_page, unsigned long *mpages)
>   {
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> @@ -684,6 +697,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	void *buf;
>   	int r = -ENOMEM;
>   
> +	*mpages = 0;
>   	memset(&migrate, 0, sizeof(migrate));
>   	migrate.vma = vma;
>   	migrate.start = start;
> @@ -728,7 +742,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
>   			 cpages, npages);
>   	else
> -		pr_debug("0x%lx pages migrated\n", cpages);
> +		pr_debug("0x%lx pages collected\n", cpages);
>   
>   	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
>   				    scratch, npages);
> @@ -751,10 +765,12 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	kvfree(buf);
>   out:
>   	if (!r && cpages) {
> +		*mpages = cpages - upages;
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
> -			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
> +			WRITE_ONCE(pdd->page_out, pdd->page_out + *mpages);
>   	}
> +
>   	return r ? r : upages;
>   }
>   
> @@ -762,6 +778,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>    * svm_migrate_vram_to_ram - migrate svm range from device to system
>    * @prange: range structure
>    * @mm: process mm, use current->mm if NULL
> + * @start_mgr: start page need be migrated to sys ram
> + * @last_mgr: last page need be migrated to sys ram
>    * @trigger: reason of migration
>    * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
>    *
> @@ -771,7 +789,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>    * 0 - OK, otherwise error code
>    */
>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
> -			    uint32_t trigger, struct page *fault_page)
> +					unsigned long start_mgr, unsigned long last_mgr,
> +					uint32_t trigger, struct page *fault_page)
>   {
>   	struct kfd_node *node;
>   	struct vm_area_struct *vma;
> @@ -779,28 +798,37 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   	unsigned long start;
>   	unsigned long end;
>   	unsigned long upages = 0;
> +	unsigned long mpages = 0;
>   	long r = 0;
>   
> +	/* this pragne has no any vram page to migrate to sys ram */
>   	if (!prange->actual_loc) {
>   		pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
>   			 prange->start, prange->last);
>   		return 0;
>   	}
>   
> +	if (start_mgr < prange->start || last_mgr > prange->last) {
> +		pr_debug("migration range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
> +			 start_mgr, last_mgr, prange->start, prange->last);
> +		return -EFAULT;
> +	}
> +
>   	node = svm_range_get_node_by_id(prange, prange->actual_loc);
>   	if (!node) {
>   		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
>   		return -ENODEV;
>   	}
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
> -		 prange->svms, prange, prange->start, prange->last,
> +		 prange->svms, prange, start_mgr, last_mgr,
>   		 prange->actual_loc);
>   
> -	start = prange->start << PAGE_SHIFT;
> -	end = (prange->last + 1) << PAGE_SHIFT;
> +	start = start_mgr << PAGE_SHIFT;
> +	end = (last_mgr + 1) << PAGE_SHIFT;
>   
>   	for (addr = start; addr < end;) {
>   		unsigned long next;
> +		unsigned long mpages_vma;
>   
>   		vma = vma_lookup(mm, addr);
>   		if (!vma) {
> @@ -811,19 +839,29 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   
>   		next = min(vma->vm_end, end);
>   		r = svm_migrate_vma_to_ram(node, prange, vma, addr, next, trigger,
> -			fault_page);
> +			fault_page, &mpages_vma);
>   		if (r < 0) {
>   			pr_debug("failed %ld to migrate prange %p\n", r, prange);
>   			break;
>   		} else {
>   			upages += r;
> +			mpages = mpages + mpages_vma;

     mpages += mpages_vma;


>   		}
>   		addr = next;
>   	}
>   
> -	if (r >= 0 && !upages) {
> -		svm_range_vram_node_free(prange);
> -		prange->actual_loc = 0;

Looks like we no longer need upages. Maybe instead of adding an mpages 
output parameter to svm_migrate_vma_to_ram, we could let the function 
return mpages instead of upages.


> +	if (r >= 0) {
> +		prange->vram_pages = prange->vram_pages - mpages;
> +
> +		/* prange dos not have vram page drop its svm_bo ref */
> +		if (prange->vram_pages == 0 && prange->ttm_res) {
> +
> +			svm_range_vram_node_free(prange);
> +			mutex_lock(&prange->lock);
> +			prange->svm_bo = NULL;

This looks suspicious. Normally this is only done when the original BO 
is freed, so that we can reuse existing BOs shared by multiple ranges as 
long as they continue to exist.


> +			prange->actual_loc = 0;
> +			mutex_unlock(&prange->lock);
> +		}
>   	}
>   
>   	return r < 0 ? r : 0;
> @@ -833,17 +871,23 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>    * svm_migrate_vram_to_vram - migrate svm range from device to device
>    * @prange: range structure
>    * @best_loc: the device to migrate to
> + * @start: start page need be migrated to sys ram
> + * @last: last page need be migrated to sys ram
>    * @mm: process mm, use current->mm if NULL
>    * @trigger: reason of migration
>    *
>    * Context: Process context, caller hold mmap read lock, svms lock, prange lock
>    *
> + * migrate all vram pages in prange to sys ram, then migrate [start, last] pages
> + * from sys ram to gpu node best_loc.
> + *
>    * Return:
>    * 0 - OK, otherwise error code
>    */
>   static int
>   svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
> -			 struct mm_struct *mm, uint32_t trigger)
> +			unsigned long start, unsigned long last,
> +			struct mm_struct *mm, uint32_t trigger)
>   {
>   	int r, retries = 3;
>   
> @@ -855,7 +899,8 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
>   
>   	do {
> -		r = svm_migrate_vram_to_ram(prange, mm, trigger, NULL);
> +		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
> +					trigger, NULL);
>   		if (r)
>   			return r;
>   	} while (prange->actual_loc && --retries);
> @@ -863,18 +908,20 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	if (prange->actual_loc)
>   		return -EDEADLK;
>   
> -	return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
> +	return svm_migrate_ram_to_vram(prange, best_loc, start, last, mm, trigger);
>   }
>   
>   int
>   svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
> -		    struct mm_struct *mm, uint32_t trigger)
> +		unsigned long start, unsigned long last,
> +		struct mm_struct *mm, uint32_t trigger)
>   {
> -	if  (!prange->actual_loc)
> -		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
> +	if  (!prange->actual_loc || prange->actual_loc == best_loc)
> +		return svm_migrate_ram_to_vram(prange, best_loc, start, last,
> +					mm, trigger);
>   	else
> -		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
> -
> +		return svm_migrate_vram_to_vram(prange, best_loc, start, last,
> +					mm, trigger);
>   }
>   
>   /**
> @@ -889,10 +936,9 @@ svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
>    */
>   static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   {
> +	unsigned long start, last, size;
>   	unsigned long addr = vmf->address;
>   	struct svm_range_bo *svm_bo;
> -	enum svm_work_list_ops op;
> -	struct svm_range *parent;
>   	struct svm_range *prange;
>   	struct kfd_process *p;
>   	struct mm_struct *mm;
> @@ -929,51 +975,34 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   
>   	mutex_lock(&p->svms.lock);
>   
> -	prange = svm_range_from_addr(&p->svms, addr, &parent);
> +	prange = svm_range_from_addr(&p->svms, addr, NULL);
>   	if (!prange) {
>   		pr_debug("failed get range svms 0x%p addr 0x%lx\n", &p->svms, addr);
>   		r = -EFAULT;
>   		goto out_unlock_svms;
>   	}
>   
> -	mutex_lock(&parent->migrate_mutex);
> -	if (prange != parent)
> -		mutex_lock_nested(&prange->migrate_mutex, 1);
> +	mutex_lock(&prange->migrate_mutex);
>   
>   	if (!prange->actual_loc)
>   		goto out_unlock_prange;
>   
> -	svm_range_lock(parent);
> -	if (prange != parent)
> -		mutex_lock_nested(&prange->lock, 1);
> -	r = svm_range_split_by_granularity(p, mm, addr, parent, prange);
> -	if (prange != parent)
> -		mutex_unlock(&prange->lock);
> -	svm_range_unlock(parent);
> -	if (r) {
> -		pr_debug("failed %d to split range by granularity\n", r);
> -		goto out_unlock_prange;
> -	}
> +	/* Align migration range start and size to granularity size */
> +	size = 1UL << prange->granularity;

I think this was broken before, but you probably need to change this to

	size = 1UL << (prange->granularity + PAGE_SHIFT);

because prange->granularity 0 corresponds to PAGE_SIZE, and I'm pretty 
sure prange->start/last are byte-addresses.


> +	start = ALIGN_DOWN(addr, size);
> +	last = ALIGN(addr + 1, size) - 1;
> +
> +	start = (start >= prange->start) ? start : prange->start;
> +	last = (last <= prange->last) ? last : prange->last;

You can simplify this to

	start = max(ALIGN_DOWN(addr, size), prange->start);
	last = min(ALIGN(addr + 1, size) - 1, prange->last);


>   
> -	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
> -				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
> -				    vmf->page);
> +	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, last,
> +				KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
>   	if (r)
>   		pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 0x%lx]\n",
> -			 r, prange->svms, prange, prange->start, prange->last);
> -
> -	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
> -	if (p->xnack_enabled && parent == prange)
> -		op = SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP;
> -	else
> -		op = SVM_OP_UPDATE_RANGE_NOTIFIER;
> -	svm_range_add_list_work(&p->svms, parent, mm, op);
> -	schedule_deferred_list_work(&p->svms);
> +			 r, prange->svms, prange, start, last);
>   
>   out_unlock_prange:
> -	if (prange != parent)
> -		mutex_unlock(&prange->migrate_mutex);
> -	mutex_unlock(&parent->migrate_mutex);
> +	mutex_unlock(&prange->migrate_mutex);
>   out_unlock_svms:
>   	mutex_unlock(&p->svms.lock);
>   out_unref_process:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> index 487f26368164..9e48d10e848e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> @@ -41,9 +41,13 @@ enum MIGRATION_COPY_DIR {
>   };
>   
>   int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
> +			unsigned long start, unsigned long last,
>   			struct mm_struct *mm, uint32_t trigger);
> +
>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
> -			    uint32_t trigger, struct page *fault_page);
> +			unsigned long start, unsigned long last,
> +			uint32_t trigger, struct page *fault_page);
> +
>   unsigned long
>   svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 841ba6102bbb..8243fbccdf2d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -270,8 +270,6 @@ void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma)
>   		dev = &pdd->dev->adev->pdev->dev;
>   		if (unmap_dma)
>   			svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
> -		kvfree(dma_addr);
> -		prange->dma_addr[gpuidx] = NULL;

I'd recommend renaming this function to make its new purpose clearer: 
svm_range_dma_unmap. Then you can also remove the unmap_dma parameter. 
In cases where it was false, you won't need to call the function at all, 
now that it no longer frees the DMA address arrays.

It would make sense to split that into a separate patch.


>   	}
>   }
>   
> @@ -279,6 +277,7 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   {
>   	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +	uint32_t gpuidx;
>   
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
>   		 prange->start, prange->last);
> @@ -286,6 +285,14 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   	svm_range_vram_node_free(prange);
>   	svm_range_free_dma_mappings(prange, do_unmap);

For example, this would become

	if (do_unmap)
		svm_range_dma_unmap(prange);


>   
> +	/* free dma_addr array for each gpu */
> +	for (gpuidx = 0; gpuidx < MAX_GPU_INSTANCE; gpuidx++) {
> +		if (prange->dma_addr[gpuidx]) {
> +			kvfree(prange->dma_addr[gpuidx]);
> +			prange->dma_addr[gpuidx] = NULL;
> +		}
> +	}
> +
>   	if (do_unmap && !p->xnack_enabled) {
>   		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
>   		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
> @@ -338,6 +345,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	INIT_LIST_HEAD(&prange->child_list);
>   	atomic_set(&prange->invalid, 0);
>   	prange->validate_timestamp = 0;
> +	prange->vram_pages = 0;
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> @@ -384,6 +392,8 @@ static void svm_range_bo_release(struct kref *kref)
>   			 prange->start, prange->last);
>   		mutex_lock(&prange->lock);
>   		prange->svm_bo = NULL;
> +		/* prange dose not hold vram page now */

Typo: dose -> does


> +		prange->actual_loc = 0;
>   		mutex_unlock(&prange->lock);
>   
>   		spin_lock(&svm_bo->list_lock);
> @@ -439,7 +449,8 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
>   		mutex_unlock(&prange->lock);
>   		return false;
>   	}
> -	if (prange->ttm_res) {
> +	/* requeset from same kfd_node and we still have reference to it */
> +	if (prange->ttm_res && prange->svm_bo->node == node) {

I think previously, the assumption was, that we migrate to system memory 
before we migrate to a different GPU. So we should have called 
svm_range_vram_node_free before trying to get a new VRAM BO.

If this is no longer true, we need to fix that. Otherwise you leak a BO 
reference here.


>   		/* We still have a reference, all is well */
>   		mutex_unlock(&prange->lock);
>   		return true;
> @@ -458,6 +469,8 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
>   			spin_unlock(&prange->svm_bo->list_lock);
>   
>   			svm_range_bo_unref(prange->svm_bo);
> +			prange->ttm_res = NULL;
> +			prange->svm_bo = NULL;

The only function that should update prange->svm_bo to NULL is 
svm_range_bo_release. And ttm_res is set to NULL in 
svm_range_vram_node_free. If you fix the above assumptions about calling 
svm_range_vram_node_free before allocating a BO on a different GPU, this 
hack will also not be needed.


>   			return false;
>   		}
>   		if (READ_ONCE(prange->svm_bo->evicting)) {
> @@ -956,6 +969,10 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
>   
>   	new->svm_bo = svm_range_bo_ref(old->svm_bo);
>   	new->ttm_res = old->ttm_res;
> +	/* set new's vram_pages as old range's now, the acurate vram_pages
> +	 * will be updated during mapping
> +	 */
> +	new->vram_pages = old->vram_pages;

This should be min(old->vram_pages, new->npages).


>   
>   	spin_lock(&new->svm_bo->list_lock);
>   	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
> @@ -1593,6 +1610,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	struct svm_validate_context *ctx;
>   	unsigned long start, end, addr;
>   	struct kfd_process *p;
> +	uint32_t vram_pages;

Should this be uint64_t? And why not 0-initialize this here?


>   	void *owner;
>   	int32_t idx;
>   	int r = 0;
> @@ -1661,6 +1679,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   	}
>   
> +	vram_pages = 0;
>   	start = prange->start << PAGE_SHIFT;
>   	end = (prange->last + 1) << PAGE_SHIFT;
>   	for (addr = start; addr < end && !r; ) {
> @@ -1692,6 +1711,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			goto unreserve_out;
>   		}
>   
> +		for (int i = 0; i < npages; i++) {
> +			if (is_zone_device_page(hmm_pfn_to_page(hmm_range->hmm_pfns[i])))
> +				vram_pages++;
> +		}

Is there a way to do this only if it's needed (i.e. after a range was 
split). I suspect this could add unnecessary overhead if we do it all 
the time.


> +
>   		offset = (addr - start) >> PAGE_SHIFT;
>   		r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>   				      hmm_range->hmm_pfns);

Or you could make it 0-additional-overhead by counting vram_pages it 
svm_range_dma_map_dev, which needs to iterate the pfn-array and 
determine the page type anyway.


> @@ -1724,6 +1748,15 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	if (addr == end) {
>   		prange->validated_once = true;
>   		prange->mapped_to_gpu = true;
> +		prange->vram_pages = vram_pages;
> +
> +		/* if pragne does not include any vram page and it
> +		 * has not released svm_bo drop its svm_bo reference
> +		 */
> +		if (!vram_pages && prange->ttm_res) {
> +			svm_range_vram_node_free(prange);
> +			prange->actual_loc = 0;
> +		}
>   	}
>   
>   unreserve_out:
> @@ -1981,6 +2014,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
>   	new->mapped_to_gpu = old->mapped_to_gpu;
> +	new->vram_pages = old->vram_pages;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>   
> @@ -2888,6 +2922,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			uint32_t vmid, uint32_t node_id,
>   			uint64_t addr, bool write_fault)
>   {
> +	unsigned long start, last, size;
>   	struct mm_struct *mm = NULL;
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
> @@ -3023,11 +3058,21 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>   				       write_fault, timestamp);
>   
> -	if (prange->actual_loc != best_loc) {
> +
> +	if (prange->actual_loc != 0 || best_loc != 0) {

I think this misses cases where we need to migrate to system memory 
(i.e. prange->actual_loc != 0 and best_loc == 0). I think this condition 
should just be

	if (prange->actual_loc != 0)

You could optimize this further to avoid unnecessary migrations when all 
pages are already in the correct VRAM location:

	if (prange->actual_loc != 0 && (best_loc == 0 ||
		(best_loc != 0 && prange->vram_pages < prange->npages)))


> +
>   		migration = true;
> +		/* Align migration range start and size to granularity size */
> +		size = 1UL << prange->granularity;
> +		start = ALIGN_DOWN(addr, size);
> +		last = ALIGN(addr + 1, size) - 1;
> +
> +		start = (start >= prange->start) ? start : prange->start;
> +		last = (last <= prange->last) ? last : prange->last;
> +
>   		if (best_loc) {
> -			r = svm_migrate_to_vram(prange, best_loc, mm,
> -					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
> +			r = svm_migrate_to_vram(prange, best_loc, start, last,
> +							mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>   			if (r) {
>   				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
>   					 r, addr);
> @@ -3035,20 +3080,18 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   				 * VRAM failed
>   				 */
>   				if (prange->actual_loc)

This condition needs to change now. If we're migrating to the same GPU, 
then a failed migration is no problem. We only need to migrate to system 
memory if the memory is in the wrong GPU and migration failed:

  				if (prange->actual_loc && prange->actual_loc != best_loc)


> -					r = svm_migrate_vram_to_ram(prange, mm,
> -					   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
> -					   NULL);
> +					r = svm_migrate_vram_to_ram(prange, mm, start, last,
> +								KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>   				else
>   					r = 0;
>   			}
>   		} else {

See my comment above. You'll never get to this else branch unless you 
fix the condition above.


> -			r = svm_migrate_vram_to_ram(prange, mm,
> -					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
> -					NULL);
> +			r = svm_migrate_vram_to_ram(prange, mm, start, last,
> +						KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>   		}
>   		if (r) {
>   			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
> -				 r, svms, prange->start, prange->last);
> +				 r, svms, start, last);
>   			goto out_unlock_range;
>   		}
>   	}
> @@ -3402,18 +3445,24 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
>   	*migrated = false;
>   	best_loc = svm_range_best_prefetch_location(prange);
>   
> -	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
> -	    best_loc == prange->actual_loc)
> +	/* when best_loc is a gpu node and same as prange->actual_loc
> +	 * we still need do migration as prange->actual_loc !=0 does
> +	 * not mean all pages in prange are vram. hmm migrate will pick
> +	 * up right pages during migration.
> +	 */
> +	if ((best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED) ||
> +		(best_loc == 0 && prange->actual_loc == 0))

You could refine this to avoid unnecessary migrations if all pages are 
in VRAM already:

		|| (prange->actual_loc == best_loc && prange->vram_pages == prange->npages)


>   		return 0;
>   
>   	if (!best_loc) {
> -		r = svm_migrate_vram_to_ram(prange, mm,
> +		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
>   					KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>   		*migrated = !r;
>   		return r;
>   	}
>   
> -	r = svm_migrate_to_vram(prange, best_loc, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
> +	r = svm_migrate_to_vram(prange, best_loc, prange->start, prange->last,
> +					mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>   	*migrated = !r;
>   
>   	return r;
> @@ -3468,7 +3517,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   
>   		mutex_lock(&prange->migrate_mutex);
>   		do {
> +			/* migrate all vram pages in this prange to sys ram
> +			 * after that prange->actual_loc should be zero
> +			 */
>   			r = svm_migrate_vram_to_ram(prange, mm,
> +					prange->start, prange->last,
>   					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>   		} while (!r && prange->actual_loc && --retries);
>   
> @@ -3571,7 +3624,6 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		bool migrated;
>   
>   		mutex_lock(&prange->migrate_mutex);
> -
>   		r = svm_range_trigger_migration(mm, prange, &migrated);
>   		if (r)
>   			goto out_unlock_range;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 9e668eeefb32..83acd4e8c4a1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -88,7 +88,9 @@ struct svm_work_list_item {
>    * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
>    * @perferred_loc: perferred location, 0 for CPU, or GPU id
>    * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
> - * @actual_loc: the actual location, 0 for CPU, or GPU id
> + * @actual_loc: this svm_range location. 0: all pages are from sys ram;
> + *              GPU id: this svm_range may include vram pages from GPU with
> + *              id actual_loc.
>    * @granularity:migration granularity, log2 num pages
>    * @invalid:    not 0 means cpu page table is invalidated
>    * @validate_timestamp: system timestamp when range is validated
> @@ -98,6 +100,7 @@ struct svm_work_list_item {
>    * @child_list: list header for split ranges which are not added to svms yet
>    * @bitmap_access: index bitmap of GPUs which can access the range
>    * @bitmap_aip: index bitmap of GPUs which can access the range in place
> + * @vram_pages: vram pages number in this svm_range
>    *
>    * Data structure for virtual memory range shared by CPU and GPUs, it can be
>    * allocated from system memory ram or device vram, and migrate from ram to vram
> @@ -135,6 +138,7 @@ struct svm_range {
>   	bool				validated_once;
>   	bool				mapped_to_gpu;
>   	bool				is_error_flag;
> +	uint32_t			vram_pages;

This should probably be uint64_t to be future proof. npages is also 
64-bit. Maybe add this next to npages.

Regards,
   Felix


>   };
>   
>   static inline void svm_range_lock(struct svm_range *prange)
> @@ -184,6 +188,7 @@ void schedule_deferred_list_work(struct svm_range_list *svms);
>   void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>   			 unsigned long offset, unsigned long npages);
>   void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma);
> +
>   int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
>   		       uint64_t *svm_priv_data_size);
>   int kfd_criu_checkpoint_svm(struct kfd_process *p,

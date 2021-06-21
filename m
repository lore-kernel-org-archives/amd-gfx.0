Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE65C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 20:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A388460FE6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 20:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A388460FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B8BC6E419;
	Mon, 21 Jun 2021 20:26:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7117C6E419
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 20:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLdAEtM/CjsyRlD8CZW7izGGvufb6QTzU/oMzHIx+R1w31/VHtSD4Nuj28HtaEoy7tsvAPs1dykwE+jIR1806xYeZsdAPJEUYx2UJhZEjRrViu6VRNOAxyUXob3xOAetPmepEydz/l1GRijyBp/MmV9Z9GSXCiNxnGGHIoXPkg8rYnZGONY3pCySqenkpc9IyuB9pami4gpne/C8SPjionEflOBQxOkiua1r5RjoFO/AHmn6jxICKcdKqJhq/kDkrLjXqdbfPWxNlYiUMrtTiN81hWRZq7inDOfrWfM3b25EnTskRAMRU321F0vYTZZrEjSeeyMi/qJOeBkGijwIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmGG+wm1Vid/k1V2dNbENgDuTWb9DPgeMOhvdboHbHo=;
 b=BW7DUXEAqYWnLu+AE6TF8tIqqjQkCuj2LiCrCKxpN9lRl2jA8CLzMtGSX0kGj0a70BZjc7nk0VLJwS5Zw/lzBLXwUkYITVSqZ8JvkiZJk6+1t+tU/nj5G12ER5C1IiegInTh7IkjRoVHLy1njxNfMALlvSVb5terojMNVQbHeECN8yzFemubhTneEsxcPpg7YEQ+9xu2jSxs55EUw8blz/4cV0LNC2N9jXyocz+oGhVc7IGD0gdTBAi86kRSYWA3FtiqtVdfdolcuiJOCZJ2kla+kdo+D6IbFxr0K/kaZKPN+0wnydWoj8pH0pW8fZ8xMmCBaUcJKOdidJmCBOvP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmGG+wm1Vid/k1V2dNbENgDuTWb9DPgeMOhvdboHbHo=;
 b=A7hOlJu/moGOn3m2b6oJc2XXfiTrAU/2bdOukiA+SNGdOIthUMJxggvg2tk6b/G3qVy2jFLubDw+lAWO2sJ38Zwspw2jfGFhafuVY+oWQG6v3NjbqjntOyTHAu6B0x9Pbz8lKIgeY8rv41HqG3AsZxx/ztsGwcgFBPqrsLrgxhk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 20:26:09 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 20:26:09 +0000
Subject: Re: [PATCH 05/10] drm/amdkfd: classify and map mixed svm range pages
 in GPU
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210621160423.3517-1-alex.sierra@amd.com>
 <20210621160423.3517-5-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <c106012a-fea6-aebd-e4ae-be0d3d41972e@amd.com>
Date: Mon, 21 Jun 2021 16:26:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210621160423.3517-5-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::38) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Mon, 21 Jun 2021 20:26:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faa871b1-0ef7-43ef-7d7c-08d934f2cdb1
X-MS-TrafficTypeDiagnostic: BN9PR12MB5081:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5081330C6E10A43DE341A27C920A9@BN9PR12MB5081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVEqcliTXbSWFD/PW8v2nDwJn0UDYoFDPsn6+jjdqRAleEk7nktf9N1vpLzu+kn458Cxf0dD6zA5MyCscBpPWTv8FwCP2v/RXuOMYSsOrt57YFU2cOl1Tjgq1ebVbaIQNHxOzYiju2Or2CLgxEYN3Vs4SbLmUkf3PHRzsXkQLH/yrNk4UoDHwytWJyFruEb1q1qmCPzqIAdcO82rxlRaAy0FvEradA3nLRMymikcnW3sWQX/R5ytffgCBUmwRX4ROl1UTrX3P1i1fSdhVdvczbrNuvJC9I8mbH0nicSuCNTYEqOeyYaHHR4nI/cOY7DXC6J+1l9PQ/Rw5OYcNj6C98XfBxIRdJ8Cwayf5uEXM4CovhnepgMKhS7AV4rLTMpO35Iqyv58zAXA4ZXZuJWgkVqlLgU8XPmLXcCTOsN0+ydNUic+t59BGG0aPE2RL8fQWgYjgwMR9uYBSIHmr1CIFgR6L0gX//jVRKJ0p35TPSg3kI3u7/28If2glhT/Y03TdxF/1CzQ9IPIilU0EopnpUmtCpeuhE/FEFAjIXaSpFo2XYKODIIaXyMUb+jat7TX5a2QEsRIxelwm+BpjPx8BHpHmzHdquyz2pU2bGUrwjZI+xFxvunKCDTHYMikyDnRdhnBGMkpHYjGlOMROaMUjCWDoOjwjR3bjXg0415Do6z6FA8undhorhQdSR4nSIRd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(44832011)(53546011)(86362001)(66946007)(186003)(26005)(16526019)(36756003)(66556008)(478600001)(31686004)(83380400001)(2616005)(38100700002)(66476007)(8676002)(36916002)(31696002)(5660300002)(316002)(956004)(2906002)(6486002)(16576012)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTR2cjZpNVVXd0RxOUhEdW9VSDR6WVBOc3lNVENxV1VPdGM1YVNna3RBVWNq?=
 =?utf-8?B?d3JIdnhEenVORURtUFl0b1hwdmY5VDlGVjJuc09MaHl3bGxpblM2MEMyS0l0?=
 =?utf-8?B?K3BZd0lVMkhoZVNIWjE1OXQ4Q1Y5cjZKM1RGMlRWY0dOeXdic2hnQi9weXlu?=
 =?utf-8?B?SllYZmx2eFExSSs1Y2RNcDRWMlFydUVjczh3Z0tGSWo4Sk9tTGZBSC81b213?=
 =?utf-8?B?YWRIUFRFVjNXdWF2OWplMS93bWRJMlB1anJ0Z2xnMFpocmYzTTJEbDZlemls?=
 =?utf-8?B?Q0FQMXI5OVIyWXNNQ1ErOFVFcEZNYVBDbjR4eFhLdmJkMDd2dU5JNCtONWRj?=
 =?utf-8?B?QytpOGRlQzNyS3JJSkdqV05tU1RjWlZzOHV1RXV0TEFTaDJlTE04Vlhoanhl?=
 =?utf-8?B?V2s0TEtPQjg0aTAyTGhKYkI2WnRrSGJJb2ZOSTBPbjBaMS8xNnhlbjhqV3Vj?=
 =?utf-8?B?bkxHVXRUZTBjQ2poWmFQRkF4cEtpSlBBdWpYYTBlbFVHWkU4Z2g5M25UanFG?=
 =?utf-8?B?ZngzQXpYT2F6NFd0Q1U5Zkt1U05tK21mdnFxMlVrcFA1N2IrVWV1REJaRGZS?=
 =?utf-8?B?ZVJLQ1l5NzNxcVlBWG5DNjFpcnBqU1hCTE8yazhTRnV6QjR0dStLM2toelRi?=
 =?utf-8?B?aEcxRnVuUFVSUmVxSnZFTkN0UENNanh4ZEd5aTU5VU9NTzZ5QnB5RURkWjN5?=
 =?utf-8?B?eFUyV3AvVWFIZlRNSnlpN1g5dGVQSlkrdmhtZEwzV05Hak1MY0JTYkdrNG5J?=
 =?utf-8?B?V1E3RHkzZjFTY0RoR2NYMWczZk1NT3p0STFxRG54blVxV21mMVc2OW1lMUJC?=
 =?utf-8?B?VUFlWVNhQklIaFFNZ3hBMHhhMmU0R096T0JhUkYwNEN3VnN2OHc0Sjh3WGU4?=
 =?utf-8?B?dlE5RWUxMW9RQWtMVDhCZGFhNHZDVWdSQ3liN05QcEtHb0xmR3l3RU1ZOEg0?=
 =?utf-8?B?aElYTmprTFFHbWMrVkJkbUhxdzFPb1VzWTNTZjlBZ3FacGo0V2JYOGlKbXRu?=
 =?utf-8?B?anhyZVhieHE0bHk0NDNGdEN6SlUzWFQxOFFKa2xXZVVUTGhiRU9hbExaWEtC?=
 =?utf-8?B?R3IzdHIvdU1nYldJS1JMZzBZeWw1MU1Tck9uSVZEcml1aEVqQ2xFb3d4Mnhw?=
 =?utf-8?B?LzhYQXJoaFJhaE4zajRrYkw1NzMzMS9jOFZ5Z0NmaUc2SVNqQjRySmgxSkVk?=
 =?utf-8?B?dE93bjNPS0V6WVdXTWRPMFlCaTZJRTlzYlpVamtxdjRoOHB2VEc0bU1pLzZp?=
 =?utf-8?B?WmtCTi81MUIyaWZqa2dDRkFjS3lzcmVHN29tbmM4MTJ0Nnp2Nk9oNVNOQTA4?=
 =?utf-8?B?bjJPZlZpK1dRVWFVMDdQN1Q0NFdMc1BXTlVyZWZSU2FXcGNJckRnRVArUUtK?=
 =?utf-8?B?L3ExUXllSGszN1BNOGxjQWJXdW5MZVpybnFPcUttZFJ2c0VJQTRIZUNFVUZz?=
 =?utf-8?B?N1haYlBFODNRQktHT1RPQXliVDVkYksvNGtab1lyWk5Ud0pzQklhVlplSXF4?=
 =?utf-8?B?YktqeFZSRkN5eVRpSXRsNHpRNmVlMzBhNFBkWlp5STQ0WUg3bHVmQmtoZ3By?=
 =?utf-8?B?aEczQzhqbHhmdlFtYktxeG9WTHhkRVBwRlF0MjZhSVNiV0RoTjN2eTEzNHEr?=
 =?utf-8?B?cEdxSWVVTmRMUkJJUDYvM0FnbCtJeGR1MWZxT2d0d1doQ3l0blFsRVZvdW5h?=
 =?utf-8?B?bTdrbzZMenZMemxNQVNkYkZQTmxObjhGTjdSZTRETFNVRHNDSjB3bzNhWUdL?=
 =?utf-8?Q?OLfgE2Bm2qfrSTHgcP1p6yTXQkOhvbwuL88+2Bq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa871b1-0ef7-43ef-7d7c-08d934f2cdb1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 20:26:08.9995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEHq5hxc88YH3BgE5pLf7NtrMIfaS8qo/1IGOR5He9Ttx+pGxJmwoi5NgoElafjmpBu+1YXSRCk3nrXXSiOBfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-21 12:04 p.m., Alex Sierra wrote:
> [Why]
> svm ranges can have mixed pages from device or system memory.
> A good example is, after a prange has been allocated in VRAM and a
> copy-on-write is triggered by a fork. This invalidates some pages
> inside the prange. Endding up in mixed pages.
>
> [How]
> By classifying each page inside a prange, based on its type. Device or
> system memory, during dma mapping call. If page corresponds
> to VRAM domain, a flag is set to its dma_addr entry for each GPU.
> Then, at the GPU page table mapping. All group of contiguous pages within
> the same type are mapped with their proper pte flags.
>
> v2:
> Instead of using ttm_res to calculate vram pfns in the svm_range. It is now
> done by setting the vram real physical address into drm_addr array.
> This makes more flexible VRAM management, plus removes the need to have
> a BO reference in the svm_range.
>
> v3:
> Remove mapping member from svm_range
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 73 ++++++++++++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  2 +-
>   2 files changed, 47 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2b4318646a75..3b05bc270732 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -119,11 +119,12 @@ static void svm_range_remove_notifier(struct svm_range *prange)
>   }
>   
>   static int
> -svm_range_dma_map_dev(struct device *dev, dma_addr_t **dma_addr,
> +svm_range_dma_map_dev(struct amdgpu_device *adev, dma_addr_t **dma_addr,
>   		      unsigned long *hmm_pfns, uint64_t npages)
>   {
>   	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
>   	dma_addr_t *addr = *dma_addr;
> +	struct device *dev = adev->dev;
>   	struct page *page;
>   	int i, r;
>   
> @@ -141,6 +142,14 @@ svm_range_dma_map_dev(struct device *dev, dma_addr_t **dma_addr,
>   			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
>   
>   		page = hmm_pfn_to_page(hmm_pfns[i]);
> +		if (is_zone_device_page(page)) {
> +			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
> +				   adev->vm_manager.vram_base_offset -
> +				   adev->kfd.dev->pgmap.range.start;
> +			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
> +			pr_debug("vram address detected: 0x%llx\n", addr[i]);
> +			continue;
> +		}
>   		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
>   		r = dma_mapping_error(dev, addr[i]);
>   		if (r) {
> @@ -175,7 +184,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>   		}
>   		adev = (struct amdgpu_device *)pdd->dev->kgd;
>   
> -		r = svm_range_dma_map_dev(adev->dev, &prange->dma_addr[gpuidx],
> +		r = svm_range_dma_map_dev(adev, &prange->dma_addr[gpuidx],
>   					  hmm_pfns, prange->npages);
>   		if (r)
>   			break;
> @@ -1003,21 +1012,22 @@ svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
>   }
>   
>   static uint64_t
> -svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange)
> +svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
> +			int domain)
>   {
>   	struct amdgpu_device *bo_adev;
>   	uint32_t flags = prange->flags;
>   	uint32_t mapping_flags = 0;
>   	uint64_t pte_flags;
> -	bool snoop = !prange->ttm_res;
> +	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
>   	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
>   
> -	if (prange->svm_bo && prange->ttm_res)
> +	if (domain == SVM_RANGE_VRAM_DOMAIN)
>   		bo_adev = amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
>   
>   	switch (adev->asic_type) {
>   	case CHIP_ARCTURUS:
> -		if (prange->svm_bo && prange->ttm_res) {
> +		if (domain == SVM_RANGE_VRAM_DOMAIN) {
>   			if (bo_adev == adev) {
>   				mapping_flags |= coherent ?
>   					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
> @@ -1032,7 +1042,7 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange)
>   		}
>   		break;
>   	case CHIP_ALDEBARAN:
> -		if (prange->svm_bo && prange->ttm_res) {
> +		if (domain == SVM_RANGE_VRAM_DOMAIN) {
>   			if (bo_adev == adev) {
>   				mapping_flags |= coherent ?
>   					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
> @@ -1061,14 +1071,14 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange)
>   		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>   
>   	pte_flags = AMDGPU_PTE_VALID;
> -	pte_flags |= prange->ttm_res ? 0 : AMDGPU_PTE_SYSTEM;
> +	pte_flags |= (domain == SVM_RANGE_VRAM_DOMAIN) ? 0 : AMDGPU_PTE_SYSTEM;
>   	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>   
>   	pte_flags |= amdgpu_gem_va_map_flags(adev, mapping_flags);
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx] vram %d PTE 0x%llx mapping 0x%x\n",
>   		 prange->svms, prange->start, prange->last,
> -		 prange->ttm_res ? 1:0, pte_flags, mapping_flags);
> +		 (domain == SVM_RANGE_VRAM_DOMAIN) ? 1:0, pte_flags, mapping_flags);
>   
>   	return pte_flags;
>   }
> @@ -1138,31 +1148,41 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   {
>   	struct amdgpu_bo_va bo_va;
>   	uint64_t pte_flags;
> +	unsigned long last_start;
> +	int last_domain;
>   	int r = 0;
> +	int64_t i;
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
>   		 prange->last);
>   
> -	if (prange->svm_bo && prange->ttm_res) {
> +	if (prange->svm_bo && prange->ttm_res)
>   		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
> -		prange->mapping.bo_va = &bo_va;
> -	}
>   
> -	prange->mapping.start = prange->start;
> -	prange->mapping.last = prange->last;
> -	prange->mapping.offset = prange->offset;
> -	pte_flags = svm_range_get_pte_flags(adev, prange);
> +	last_start = prange->start;
> +	for (i = 0; i < prange->npages; i++) {
> +		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
> +		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
> +		if ((prange->start + i) < prange->last &&
> +		    last_domain == (dma_addr[i + 1] & SVM_RANGE_VRAM_DOMAIN))
> +			continue;
>   
> -	r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
> -					prange->mapping.start,
> -					prange->mapping.last, pte_flags,
> -					prange->mapping.offset,
> -					prange->ttm_res ?
> -						prange->ttm_res->mm_node : NULL,
> -					dma_addr, &vm->last_update);
> -	if (r) {
> -		pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
> -		goto out;
> +		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
> +			 last_start, prange->start + i, last_domain ? "GPU" : "CPU");
> +		pte_flags = svm_range_get_pte_flags(adev, prange, last_domain);
> +		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
> +						last_start,
> +						prange->start + i, pte_flags,
> +						prange->offset +
> +						((last_start - prange->start) << PAGE_SHIFT),
> +						NULL,
> +						dma_addr,
> +						&vm->last_update);
> +		if (r) {
> +			pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
> +			goto out;
> +		}
> +		last_start = prange->start + i + 1;
>   	}
>   
>   	r = amdgpu_vm_update_pdes(adev, vm, false);
> @@ -1176,7 +1196,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		*fence = dma_fence_get(vm->last_update);
>   
>   out:
> -	prange->mapping.bo_va = NULL;
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 08542fe39303..27fbe1936493 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -35,6 +35,7 @@
>   #include "amdgpu.h"
>   #include "kfd_priv.h"
>   
> +#define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
>   #define SVM_ADEV_PGMAP_OWNER(adev)\
>   			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
>   
> @@ -113,7 +114,6 @@ struct svm_range {
>   	struct list_head		update_list;
>   	struct list_head		remove_list;
>   	struct list_head		insert_list;
> -	struct amdgpu_bo_va_mapping	mapping;
>   	uint64_t			npages;
>   	dma_addr_t			*dma_addr[MAX_GPU_INSTANCE];
>   	struct ttm_resource		*ttm_res;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

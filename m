Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161D0C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82FD10E4FC;
	Tue, 18 Aug 2026 20:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OfKk6Mok";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012048.outbound.protection.outlook.com
 [40.107.200.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BDE810E4FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHEhCK8bbPnyutakrpQWY57r6tcZWh2UcyhFStSTBS85rSNi5KU2ROsVq7qbstXTqjAllLRehw3h6sV4C+ppW4wVqiBoPhyHG3Hr9E0aGG309GYgt6D3b/sh2HnqUFIrpSN5P690tdrsdqUGX0ZngcTXVNvdj/yIZvkp176+LYpgjrdVHmTLSa6qsMH30sujY8vzo5v2CqTLBgg/P1hqPI1VU2Mb3nWRv/WxiUHjoy1pa5m3LUZHa0hvXn3htGCMSROcFl7l35sab/fG0QmhI/9hsDenbx5/inFqXs1OaVWd3XoApg+YLl3PMr/AJGmwcsj9HXSxSKj62476GeSd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q2g9IKvIZ1CX4STjj/HEQBsM+uSirN7k8AT0R7UNl0=;
 b=pL1FLVKSUwOGaRFCPXNrW74qOUcWPG7GGD3dz2s4FXAsdhwCewf3WVYvN5W8WtsSWbAZa4+dddNHRR1VRaqFVLUGHDr3kpOTmuISN4y5A2pbarZYCl1RhBEGfApWXI+P+wVVWYzJOI9twIUn+Hbok7GN3tbxf65ynmM7WeacXs+mYdepwjzKr1NYlsXgI05q03tm4zEJ6pvgp+c7dAxuf1gChf0k3YBqMxZPeEUIAH7Ii23WMHAJy96plgWIqwo3xxjoDRRkRSPgYqzDyEcheDY7TAHHcvStb4hK75amUefccCFEjluabTC6LsS73N1Odq/7lmuOS8uXO5YT7ckM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q2g9IKvIZ1CX4STjj/HEQBsM+uSirN7k8AT0R7UNl0=;
 b=OfKk6MokX1JcNw1TVK58n4fCaIa37YUOd7nrxpWvPzdqcaSfP2ClovqiRojyAf5vmQdCpG19c1UM0qKVNINOiQurHqkRIOL+NKWIeGQemIAGfGTICiTOFV/C75trdIkZAZhY2RcLDX+hkr3vVM9Ypz1y9Wuhfq9JGk6XUoP5oEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by DM4PR12MB7672.namprd12.prod.outlook.com
 (2603:10b6:8:103::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:41:04 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 20:41:04 +0000
Message-ID: <ec90b230-f265-48ed-8a61-665313eac2ed@amd.com>
Date: Tue, 18 Aug 2026 16:41:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdkfd: Fix error path at svm_migrate_copy_to_ram
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260817135918.228397-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260817135918.228397-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::20) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e82ecf-0445-4883-484b-08defd69057a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: wY1/AFcKylwYFeT1MF8oFY9EDmxmrugzyjWl3Crkx/OQoSbew3JbTnDOji/o5X9lWHDBZf2ZL0wEYqNCI6lSwCG4CGnZwvfb5y45+wYuNXxItnHILW3cNXhqRE6hgZl7mANT8s6N2SmkvBJEljXHzemOgKnLoXUtapuUk0q7ZYU2I58OE70dGFOXUH5w1fXmpnSf94pa7K6qDuTph/3qI3KiC16ukO0qP554cpRC3IjADXxy7BAJqXDy4QVQhBciwdvK2AlVhKE8veRpLc9Ei6toWOr1F7FargQbXi1uOovMnpsMmwTqqg2UN94K1hwnkqjku4k3OLv8LmLCviJOOevXuPyO6TyQRxck0Gfh9dFhNRgeKnrtNke9LycVx8FmuquSgLTNn41QKz6D+dD0YdQYi9hfr090cUwwL3OohuQZK8MHQMgtZ0S5uVCyXJCnuUK5F0jEz08GgXnuTr4he1u3LjCc/TRjMViliHihXH7MUQbNhKYah9bbT+xflkt9XqdzCyScFPigcaqDLBztkToxOtWDbSUFxucq8azkT6aEH0FMTGyeD0kBhhwuFgMpgd/UX4+Mwyencdi0jj6i+faT/EM3Oglo23uVQJ0D4UEfSC8aa8dlhn3ppj5MXuyO3BXqSokx0YUyfHV6osIFSNGNArOF07hszMgz0diCjWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUxvREt4UkRaTkNPRGtHL1kyZHRRejR1NmZvemt2SXA5OXRaK1NSMTA0MGI1?=
 =?utf-8?B?UXFZbGtXZnZ4OGV6b1Y3Q01obmdoa2hDUExSODI1ODBsKzZ4U0gxY0hIL1lS?=
 =?utf-8?B?VGFzc09zRnpZN3V2NzVEeFdGNyt6cTVTckxnN2lzUEs0dndMaVVrYUIybUxR?=
 =?utf-8?B?MjIxcFVQZDFYOHl3QkNVYWw3ZTdBL3BDM2RENzFsckR0VE9EM3AvZzNoRE1v?=
 =?utf-8?B?ZjJVWFhNSjJHT0Zka3pZS2N4aFVScUxMRHo3SUdqSUZYc01HM3hoQUdaZ3hB?=
 =?utf-8?B?cWZ4c0pmUkhTc3d2ek1RZXFhYmpFY2JITE5Ha0ExdENGRjR1L2xHQklrTDE1?=
 =?utf-8?B?Q08zbVBwaUpLNHk2dGpkdllRSXQ4NzBqN1pHNTFhbUpGRDZ2SHljTmlPUkdx?=
 =?utf-8?B?aHcxV25vQmp2ejNudHFiTFZ3R2l5ZnpLMHFSa2FPMWk2eDU4N1JQRWlhVVpW?=
 =?utf-8?B?MEVZTG9vY25FaGJrUnVHbkpOWHZueEE0a0VxNzZkekg4TlZRSW9BKzRqUG52?=
 =?utf-8?B?c1hGMmw4L05EcXF1RStISXU2Y0tvK1RRNnNRY2NzOWVTbUlqaWdSYXc1MTlm?=
 =?utf-8?B?ZkNLallxbG5tUGYrOThZL3dKR2Y4WGZud3o0OEZPZUdkbHBEMTdGM0NRbUtx?=
 =?utf-8?B?dnBwcGtiZkl1MFRsNW1wNXBRR3pVRFlvZDFZTXozZDRlc0M0ZUxnaTdqeTJp?=
 =?utf-8?B?cnoxWGxxNkx5SnlteGpJWkQ3VnJid0JTdGRKSDZsckFNRE1nSGxSR2hwakVk?=
 =?utf-8?B?NGFSZ2dVNXhUdUtWcG1OMzFBemlYdjU0S1RGNEFaeXBINHM1SmtpUnpFMVl3?=
 =?utf-8?B?NEZwSERBSWNoTVJJWGtQUjNXTVBTRTVSU3VJNXhialVqT3hiY1R5V3ZPVmc1?=
 =?utf-8?B?ZjFRZnRsc0NSRWVrOUFGSDM4VWhLS3RqYkhSTlhVbDFLNkZ2N3VSZzhKcHRi?=
 =?utf-8?B?cmI2RkNRRWc1ZHR4YzJCdVdIL0N0OTFaWHVVRHUzMzMwMHFxUWFNWTMrNDVP?=
 =?utf-8?B?UDMyUkpPZ3RaVy84M1FkUXRIb0hRcWJoRzdlTm5wc2NrcDRORXM5bSt1c3ZK?=
 =?utf-8?B?d04xdWpVak9qWTEwL2RxeDJjYWZ1aFlrMk5pZnNuTGhScm1CcU03TGlNSUtT?=
 =?utf-8?B?SW5HRTBQeHd4eU9YdlUzb0hYWnZJRHl6YVV5dUUwSWJPSE5ZNG5XYVNjTnVY?=
 =?utf-8?B?N3lhZnpzUENDT2hMSS9YS1hUSXo0OEhpY1hqNExPMEJUZWNTdEhETnRGK003?=
 =?utf-8?B?M2d0QjkvRmdSSXdiOUhJSmw2dUdOUW1JZER5UTl2bXkybzJNcm1sVStRMk56?=
 =?utf-8?B?YnlMMzZ2UEpPTzNCUlVtb3JZRGJmUG50OG9hOUVjUlJkSXN5ZEFTWElOTVhs?=
 =?utf-8?B?Qk4zOTgvL2YzT1dETEQwdVhBYzViMkZ1WnJUZUxSdno1QzlVcDdodEI3OWtj?=
 =?utf-8?B?ZmhueGkrVm5DdGdsQmtPYnQ4OFFPQ0RBajVZU1JncHlEUkkzdWFWZStHcWdY?=
 =?utf-8?B?Z1NaYWdQQ29pdS9YWE1GQjZBbkpzM2I1NmwyRmpWUWxrVGViLzVlTzhraHFD?=
 =?utf-8?B?Nkl4U095MmxIc3IxL0h3UUtkaVNGY0VBS2QwK3JpK2ZWOUtJb2tRMGNneGpa?=
 =?utf-8?B?N1JNVmZoN0tnV09hN0dSZklPUndFRlk1bEUvQjgyN29TQW9NM0NmOEROWjh6?=
 =?utf-8?B?WVZOKzgyYkVrb2h5OHBPR1QrQnF0eFdPbisyaVBZcU1JeGkweXVQcVpNYkdL?=
 =?utf-8?B?c2pIRUxueVhESVJEUjFhY2YxZkk2ZGRGQTNxT2lvME9uMnMzMUdwbERPTC81?=
 =?utf-8?B?aHRjWGtjWHBpenNWTlVVMzNwYWlhY2FIcTdKYkFtTFFiak81YnRlNm1vVDl3?=
 =?utf-8?B?T0cxUWpZK0hvN1cyNkZrcW0zdG9COUN4ZHdwSnRHQ2RDYzd6VGdWaEhyaWZ6?=
 =?utf-8?B?dkR4bUl1NTl3QTY5SWVCeGZIdm1lWlorQ3JWOGRiSEFHcnpRRnl1ajBxYkRa?=
 =?utf-8?B?NVMyZEhpR3pqS0NaYUJUV212Zmc3SnIwZU9zTlQ1NXV0eGVZNG1vcUdsNlpR?=
 =?utf-8?B?Q0JPL0k3cy9NV3ZKaXpyN0lVbWN5ajhjM3ZlaEwycnhsNDJadm9LSzgvL0tP?=
 =?utf-8?B?cytJUWt4K1RZRnpuTGR1aldTcnUxeEUrSis3clpHTEo1Y3FwdVZ1T0w2MGJT?=
 =?utf-8?B?U1YyRkZEWVAwbS8xRHNoOUlXUWRVMnFXY1JrMm5UaFZMLzFmbTZGRkVKbWJx?=
 =?utf-8?B?VEtoQlNLd2VGbHViK0FvYURJYjlSYUFBdFc5V3B0MnJMeGhJeTVYMDdvc1Ry?=
 =?utf-8?B?U0hvRlJYeUpqbWxoclZVMEIwVHR1NDFwRURvamVBU2RwVDJqakc0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e82ecf-0445-4883-484b-08defd69057a
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:41:04.0310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWrGDRu4aeIUuW9TJHoy+05MZDdAO7Ny0EHZl26Xh55NC6SzltIy1ptNknQi+d06XpZBproFWXuYF5OrZYSHeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
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


On 2026-08-17 09:59, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> If page migration from device to sys ram fails for some reasons driver needs
> release and unlock allocated system pages. To do that driver should use page
> physical address, or pfn, then get struct page*. Current driver uses dma
> address(for adev) that is not correct with IOMMU enabled, or even in general.
>
> The patch releases and unlocks allocated system pages based on where migration
> failed by struct page* of sys ram pages. Also dma_unmap correspodent system
> ram pages at error path.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 46 ++++++++++++++++--------
>   1 file changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 226e76ae0be7..aea82da5f575 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -258,15 +258,6 @@ svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
>   	return page;
>   }
>   
> -static void svm_migrate_put_sys_page(unsigned long addr)
> -{
> -	struct page *page;
> -
> -	page = pfn_to_page(addr >> PAGE_SHIFT);
> -	unlock_page(page);
> -	put_page(page);
> -}
> -
>   static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
>   {
>   	unsigned long mpages = 0;
> @@ -591,9 +582,10 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			dma_addr_t *scratch, u64 npages)
>   {
>   	struct device *dev = adev->dev;
> -	u64 *src;
> +	struct page *dpage = NULL;
>   	dma_addr_t *dst;
> -	struct page *dpage;
> +	u64 *src;
> +
>   	u64 i = 0, j;
>   	u64 addr;
>   	int r = 0;
> @@ -647,6 +639,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   		r = dma_mapping_error(dev, dst[i]);
>   		if (r) {
>   			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
> +			dst[i] = 0;
>   			goto out_oom;
>   		}
>   
> @@ -654,17 +647,40 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>   
>   		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
> +
> +		dpage = NULL;
>   		j++;
>   	}
>   
> -	r = svm_migrate_copy_memory_gart(adev, dst + i - j, src + i - j, j,
> -					 FROM_VRAM_TO_RAM, mfence);
> -
> +	if (j > 0)
> +		r = svm_migrate_copy_memory_gart(adev, dst + i - j, src + i - j, j,
> +						 FROM_VRAM_TO_RAM, mfence);
>   out_oom:
>   	if (r) {
>   		pr_debug("failed %d copy to ram\n", r);
> +
> +		/* first release current dpage when dma_map_page fail */
> +		if (dpage) {
> +			unlock_page(dpage);
> +			put_page(dpage);
> +			dpage = NULL;

Minor nit-pick: You don't really need to set dpage to NULL here. The 
loop below doesn't either.


> +		}
> +
> +		/* release previous allocated sys pages and unmap dma address */
>   		while (i--) {
> -			svm_migrate_put_sys_page(dst[i]);
> +
> +			if (dst[i] && !dma_mapping_error(dev, dst[i])) {

Why do you need to check dma_mapping_error here again? If there was an 
error above, you already set dst[i] = 0.

With those two issues fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +				dma_unmap_page(dev, dst[i], PAGE_SIZE,
> +					       DMA_BIDIRECTIONAL);
> +				dst[i] = 0;
> +			}
> +
> +			dpage = migrate_pfn_to_page(migrate->dst[i]);
> +			if (!dpage)
> +				continue;
> +
> +			unlock_page(dpage);
> +			put_page(dpage);
>   			migrate->dst[i] = 0;
>   		}
>   	}

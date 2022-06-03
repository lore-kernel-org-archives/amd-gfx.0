Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ECAC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 14:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E175D10EC21;
	Fri,  3 Jun 2022 14:37:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1376310EAE3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 14:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2Xe5sHn2XoPMcZU5ez8Mw/u4mQ/kko497kB+Im1jcXnoO0HHIhWt1DJIJ8hiU6kInqE+B1doAs55pan45cLzNgTorYgR+kaKCQznI1bgp8G2yTz7oK4w2NmkRgX2SIhjvWWLR2Y+tDGTiJgcNuDxFr4cR4BcRV/cd2zRR7ZkdX+V2CMOMRwAoFLdjOa/ocnvGOZxx8gCHEo1EzFhQSIuTow1T6tziHancN+nuqc2IskiLBvqGpV/URj115XPTgW4CSpXMY5xFDMsXsiF8bxd8n3i/zCSJuLTIXbjvWM+p90TnFL/20Zd290WZziGdu5eiwci/MBE7LOhYeKrsBQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWuVHgWtYOYJdp+HUzFMGFOXHtGTBowIgKuK5AZ8Zgk=;
 b=ec40Tt9ixBq0FDpdi45cftJJYK4VoHq7hz73xvHeCM91ZV40+4vRvpdbtdZp5uLCg/NcAiEoiaTQ32A1Py+NrLvIzeMlQW1Qyg2ptfRcT0via53yirQL0CsGomp2814Dm9mgDmBHqYWQJINknO7XpLefr0HExbK9lipC+YKq12y7CJcrZhni/gGthyHBCYmVSD4QpPBIjFszWGQrFc9dwoxjbSYJSFuQWAPfKRU4nh6h2sHXpp1SB/WmpuPrrmsIy3TIBBiijaEz0Jd7Fs3ofhmnplko544Sjt1JAtfHD+TN8fy+h6mary/J+MBc8wsVVHvDC7I+MzEXYHnGJjnKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWuVHgWtYOYJdp+HUzFMGFOXHtGTBowIgKuK5AZ8Zgk=;
 b=meoSK1moKoc7LZ375O9q2uDVFjN+uF2wJAdkkmoOhXhbIeVnuC/8uOdTXY/3pqjrq1115JvvFfztDOQIUQ8kIjJkPe/NB2por9Meuhh4Is3Ig0wWuwf1p5DF3VbH2Gf7vZDv1nfXdMEaQRgKU8ad4pFAV4JsGk3pAINGEsLdcwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR1201MB2522.namprd12.prod.outlook.com (2603:10b6:3:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 14:37:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.016; Fri, 3 Jun 2022
 14:37:33 +0000
Message-ID: <24835561-5344-f18d-ba6c-6bd4bfb8023c@amd.com>
Date: Fri, 3 Jun 2022 10:37:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdkfd: Fix partial migration bugs
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
References: <20220603135906.20912-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220603135906.20912-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b39a61e-b198-4af4-0221-08da456e987f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2522:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25224BB25DEA285584C446B192A19@DM5PR1201MB2522.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45EcABf8y6iGLuFy5z0mreITik3r/I0QZOuk0F7uLV3Ke51gKisU0AJSs8lZQlbjAG2yDdyK4IYwNvpwfJ1DbQqY7iSPGMgZn7fN1QQZ6P1phWqPksFlp7YJ/5MY2bKuLHzv7/YkGcdXb1JquR0SyDsqJzyHjhKdvDfi69HxblH9s60T0qwnHK7tqTAS/FtRHyTreDVtcdNeQiPG4jQt/b5GLdAAl7yaxxfI6Pc5idjG3o+bUcCifLirk6U2S5OiuTynp3cB1wtw6FocbZvfmHeMcuSFmFUQTpKdaA50f0utXy19zIU4/kuQPEKAgXozW1bRP14Z+CUJVy+LzA0XnirIdx7JAI9d0iCEKvCgxfBBSxX+FxVZqamD65Hgsp9ki3jeg1UUsH/c+JeQN2djAYYLSMExJZ9v71RvP+65lTB1Sb8hvbBK4jSf/tuMorlmiMvnQRag24gY05S3Q91rq9F2beLtA+Twi82xU9DQPO3rPG+DhFAsxN5bnIHWJir6ZomP849rNu2DBtMAo8rDGQhyCMX0mnKfZmFSk9JCpyhV9ZfBMuu1U9hUY0B833m7YH8y3whxi4bzbKrNYJUDeNgC8tik7uruBw/G4FFthIfRfKL15WLzuCTyTYhNbMZqaqKREv0dPRmoel2KQAVxk9n4oDvYqyQOMA8Brf/FDybTSqJVdd7PUQFNcwpIBLkt+5lzvvUs/5jzDhOcSweDcIoxcT05iwRf8Amp+wsVysfO+6WM04EBN/P1gWt8cfff
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(66476007)(186003)(36756003)(110136005)(8676002)(86362001)(31696002)(6636002)(8936002)(2616005)(6506007)(26005)(6512007)(6486002)(38100700002)(44832011)(508600001)(66556008)(31686004)(66946007)(83380400001)(5660300002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3lOVit4TFZxNENCdkI3UkhTMW05bjkxYTc4MTBlZk01OGVyTzZBNmpYbkFH?=
 =?utf-8?B?djNkV3pTbE50YUhYdUcweDE1aDhIR2tRSzhJLy9uSGJHNGxoNnFYSnVLZTNo?=
 =?utf-8?B?WDRLVGR0Ri9NbUZFYTV2RFEvblNNdzBsQjRQcXBMYTZjcU9RejJvL0V0eU5r?=
 =?utf-8?B?azNqNnNvQzV3bHhjamhqZ1FzaUt0MTBsWE1ZdmVJZjRZRTN6NU9oS2pRMzVV?=
 =?utf-8?B?ZlhabWREaHM0ckl6SWp5aW1JV1U1Tis4WjhaWTRpVU9sejQxS2pUOXBtUkho?=
 =?utf-8?B?VTJnYmZnTE54WTAvaVRqVFQ0S2U2S1BFanVZZTJ0NllCSzZkVkNidXdTZldL?=
 =?utf-8?B?V0ZBYUx1VGwyV1Q0UU44Z2RYUXJyT0RUN1NZVTNoclFOa0dGN1pzRjRiN2RT?=
 =?utf-8?B?aGcxdXFwT1lISUhlZUVYOVRQb0JYalQ3RytiSnRKVEZlN2J2WUxobHlTSXZI?=
 =?utf-8?B?Z2swUThsYTVWaG1DOFVvZHRnMStkaUdIMnU0TTRtQ2Y4M3NkTyszcHFhTkE1?=
 =?utf-8?B?RlFCZWV4MkdlTDJnWnJ0anhRaGZsaDB6cW9VUGx0OWlXQXRLenJ1K2VNSUts?=
 =?utf-8?B?L2xhVEt3WkVuaG5ybVFhWmFVRGxOc2c3WjNGYzJTRzBPcGdvVG8vejZNOVBQ?=
 =?utf-8?B?SWVTSFNiSU1IQlJvR2QrZ01FVXlneW16Z0RkZnJEYkxmL0JJU3RKb3JWeG5q?=
 =?utf-8?B?OUFNc0JFTTJwRnpYbi95RXpBa3hoM0hOUWhQQWgyOUc5N1dHMzFZbUxWRzJs?=
 =?utf-8?B?SDdjNjErZS95MTR5d1BUU3ZRcVNHWGQySVd6M1lVaVpMTnNvZXBnMjVnc0VR?=
 =?utf-8?B?QUlNbjZMcXVTb242UTI1Q1JmOWFrSC9PZFZyRlNrOVRraUlWN2JjRXcvTDYx?=
 =?utf-8?B?TCttUVN2UGJ5YVBNV3dFOTRqb2taQUpKd2ZxV092dElpaWE3SWt1R2tTUTUv?=
 =?utf-8?B?WnRpZ2NLYmdRSlljVndFMjJRQmlJN3V6K1VaR2MvZEVER2ZLRDRDbFJTcndZ?=
 =?utf-8?B?Y2YwcWIyWXdPaGMxTjEvekpSRkZzKzFXd3Y0U1dlQy9BY3M2Vkt1dDVKQ3dK?=
 =?utf-8?B?bUMzOGJvWFZkeXJ3S0JvUGozTWtlYXpZSHhEU2haQlNRZ21FUlFBNmtETTFK?=
 =?utf-8?B?MFlBVElNeWo1aDZ4SFB2VXUza3hieE9nQVN3Ui9aemZ2TFBOb0hhbUxIUGV3?=
 =?utf-8?B?c0pEVFBOaFlGU0ZrbEhlSGt0NjczQ3plMVRxSkMydGdlOEw0QTh1WHhLUlhk?=
 =?utf-8?B?dlVXUlpKVGJkcGhiUlNHVTN6ZUpOOHY1MG5aTzFqM2thMnpkbFdGd09KN2hJ?=
 =?utf-8?B?VlhlMEpBblJ3SGVRNndycnJqYUFFa3VBTTFQWHNSZHYyWFNLYitvY0c2QnB5?=
 =?utf-8?B?UWxiVWtVMm93STA5U2xhQUlGaVNSbm9qMVFyZENvMk53ajN4MFFGWHZ6a1o3?=
 =?utf-8?B?WE4yYmd6c3cyZ09aQzJ2aGlTdllJNnIrQ25yNWQrTmxaWTV6bngrTG4vQkZ1?=
 =?utf-8?B?VlVybFVYVWJaeTQwYS91WWNkQ0hiV1FMMEVMV3RCaWZYdytmRzlZOWg4Ty9G?=
 =?utf-8?B?NkFUaWM1akFXRVp6MTVyV2JpVzI4aEVpUXc2eXNxNE1ZU1g4TGZHM25iT3hS?=
 =?utf-8?B?UGppTEhiekcyZmFIQ2pteGNWdytVTnZNRnZ6Mmxzd0ZoNWFMRksvTmNyTk4w?=
 =?utf-8?B?TTdIODlEODlLVEtnclhPTWphcTBjWUw2Y3VaQURxaFhCdWJtTk9pSnFWTFNu?=
 =?utf-8?B?NWRJV2ZFMW5IUjdKUktSQ2pPMHlpSWNUckNIUUNHUS9YVTBWcDlNaXU3ei9m?=
 =?utf-8?B?eUJ6cStLOVpUazUrYzRGQ3ZYSmd1TXBJNE5nOVpudlJQOXRPa0R0YlZ2SytV?=
 =?utf-8?B?c2dkTkxWb0RubjNZVmcwYXFVS3pzellJV2ZYaUJDdUNRSTJyQWw1ZmhlZko0?=
 =?utf-8?B?eVdUbFdZeFlvL25ITCtHakw1QnlmY2tkR0g3VzAwNkhkREhGbVdXOVl5YzBN?=
 =?utf-8?B?MG95R0EzVmdWK3FXVnZVRzRDa2s3bk5rekRGazlTbGViQmQ5K2FQbXRmRDM5?=
 =?utf-8?B?V2h3OU5yY0NKZEZwQUo4UkhrL0t3ZlZwOVRSVVI5VUljekpET3NoRlJrRGxa?=
 =?utf-8?B?Uk00RTZKbkhIOUFQa0lleHI2d1JoV3RrKzlzL21Zb2ZMemtxbkQzVkVnazYw?=
 =?utf-8?B?d0hSdlNIUVQ0VFBYRGpZT2dsQUIxZU5BamZDWUlYWExNb2VydHIxTUd6OGRr?=
 =?utf-8?B?aUJjalIrYzZFcEhTNDBmbW5DSlExMXZvTytUaUIyQm1yNmhNdlpaT1o3ZFB1?=
 =?utf-8?B?ak9OakxUb0luTGlrTzROaU1aRkJhaWlGT21WUzBObnc3dGRTV01wQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b39a61e-b198-4af4-0221-08da456e987f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 14:37:33.5400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sKyVUYcWv9sdSC3c5xmeUFSukj/KstLgxveJdvzedrryLlQBnL6lHNmhQpSH7FNcr5tRpDPgJcwJNPtdjN9eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2522
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

Am 2022-06-03 um 09:59 schrieb Philip Yang:
> Migration range from system memory to VRAM, if system page can not be
> locked or unmapped, we do partial migration and leave some pages in
> system memory. Several bugs found to copy pages and update GPU mapping
> for this situation:
>
> 1. copy to vram should use migrate->npage which is total pages of range
> as npages, not migrate->cpages which is number of pages can be migrated.
>
> 2. After partial copy, set VRAM res cursor as j + 1, j is number of
> system pages copied plus 1 page to skip copy.
>
> 3. copy to ram, should collect all continuous VRAM pages and copy
> together.
>
> 4. Call amdgpu_vm_update_range, should pass in offset as bytes, not
> as number of pages.

Thanks for catching all these. It's unfortunate that partial migrations 
are currently so hard to trigger deliberately, which makes this code 
path hard to test. Basically currently it is only used when page locking 
fails due to race conditions.

Xiaogang is working on a change to use partial migration when migrating 
large ranges in GPU page faults. Heads up, Xiaogang, you need this 
patch. And once your changes are ready it should become possible to 
write a KFDTest that checks data integrity with partial migrations.

One comment inline.


>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 +++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 43cd47723946..d03135a1f7e6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -296,7 +296,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
>   			 dma_addr_t *scratch)
>   {
> -	uint64_t npages = migrate->cpages;
> +	uint64_t npages = migrate->npages;
>   	struct device *dev = adev->dev;
>   	struct amdgpu_res_cursor cursor;
>   	dma_addr_t *src;
> @@ -344,7 +344,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   						mfence);
>   				if (r)
>   					goto out_free_vram_pages;
> -				amdgpu_res_next(&cursor, j << PAGE_SHIFT);
> +				amdgpu_res_next(&cursor, (j + 1) << PAGE_SHIFT);
>   				j = 0;
>   			} else {
>   				amdgpu_res_next(&cursor, PAGE_SIZE);
> @@ -590,7 +590,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			continue;
>   		}
>   		src[i] = svm_migrate_addr(adev, spage);
> -		if (i > 0 && src[i] != src[i - 1] + PAGE_SIZE) {
> +		if (i > 0 && src[i] != src[i - 1] + PAGE_SIZE && j) {

I think the i > 0 condition is redundant now. You could just replace i > 
0 with j > 0.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   			r = svm_migrate_copy_memory_gart(adev, dst + i - j,
>   							 src + i - j, j,
>   							 FROM_VRAM_TO_RAM,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2ba3de0fb8aa..d6fc00d51c8c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1295,7 +1295,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
>   					   last_start, prange->start + i,
>   					   pte_flags,
> -					   last_start - prange->start,
> +					   (last_start - prange->start) << PAGE_SHIFT,
>   					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
>   					   NULL, dma_addr, &vm->last_update);
>   

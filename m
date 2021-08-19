Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B18C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 21:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09106109E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 21:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E09106109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BAD86E9E0;
	Thu, 19 Aug 2021 21:32:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35CC36E9E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 21:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPvgI7zne2VThHvCZqG42u2JzLlpAkwXJNfkoCYbvZga0XPHRFokE6NZ4YfKDtHVITOlB4sMviqh0QozjF9lLLnJImPhSWFftMt5oEhDBxc3INiQLNeAFwk9QAExgNy5oYfkLpP/zqG7FEefJoF61mEOQw3pDoCy+DY/yjl5nBhZVSatpABOuphg5YEH/gtQMdJv+dTUBmermXTSEhjYL4+JGjdkmRlfIqTAA9p4ZB5MWCOFxh+IJMYWJ0wJ+Bi5bbZKLgWg08k8G8Xb4ZNXsksTqthtzFXrvXKb0+LHDvNFklSINvgNDrW6lMnok8TGNladPMe+/bMbn/j9tDaeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrDsNwwR5h92Ykm7xuhp1BvCyIh3aACd25cgS72A8ao=;
 b=iNEgoCAR/CpqAdaypJsFiIYKImWbrns/hgvH/tDAQsTbPoChnmN6B/7vuSUQ87eS2SuoMuAFEoGsALPUAv3BsN81NEjhvH6FJ1KI95bR+l7Wl0Al7FuE4ys4UPiyEiYrfkzaY9v0wYEvDAmJbPuSNHBkRUmBiNMZ2QTLM0AszeUQFuSisyzHalekg5g22pyjQgrjnhQdKthk6EP83asf+58a9GEYYY73HmuESdgi6sC590rcQQsVR5DrfodFWydjglm7vV2CO10uVTqqUX2jUYOBnN/mPzBZ3ijFgGdxlKOCij4Yu+YlFxiTiNxeoH28h/Fz7jF57LlHUY/Dx3VO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrDsNwwR5h92Ykm7xuhp1BvCyIh3aACd25cgS72A8ao=;
 b=Caebu+/GnbKezYcD36/pmv9gu/rTk6utHhDvFLUHqt8qYhWynY7f56pZxVlpIiAsQKD/ty78QL89lQlpusX5r5akXCLilUP7D2dU1MAX7ML+RYQH1ocFp4x8ElnWbSebusW5e6zV9C1/zdhjrfYoDGopcPFGNcrIxtXSwnAlDms=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 21:32:40 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%4]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 21:32:40 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: map SVM range with correct access
 permission
To: amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210819145658.2254-1-Philip.Yang@amd.com>
 <20210819145658.2254-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <3fa1a300-8ea8-3b7d-9ca8-82c70ec8fac4@amd.com>
Date: Thu, 19 Aug 2021 17:32:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210819145658.2254-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::7) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT3PR01CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 21:32:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 873a4eef-c6e6-4914-ad61-08d96358df0e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5052486CC16CFE79A6513B2992C09@BN9PR12MB5052.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: go3+b0dz8LMRW7C3grPXvQ+noun/P2HdcW2hzgYo9XzlFOdLI4O5K3SDjR64E5eb77jVxahNxGTvlMBSSMdvI0BDHY9D3Z1I2oRt16QXWcDZhQyPc7keq0BSRa3tHhKNtlfMvp57p2gDVHOMzIcrOFhJnBKbKSUn1i0+TZ9DjC/eACRKcaHTcqj+N04QMHQq7muLtmnnX4jRCU6xUadsV7qxDeFoeoVysKAejOHfEXYJyZJ7c08JNfSLet8HzHikpHcZ3Hd7fITxLvM0Z5ue9RLn8UZ43816/+4UfrCtFrLX01kkExsnJrw7HBzlDCLNYiA/8lrrc5jpk7vxYGSJLshM6scztuUp8XfvDEa4fO6vdUVUXB3VMIoG4zandjMuQQqGeCIXVl9dvBCwYx20M02yW6PLnCo9yUPJ0mKnvKpHV/f5aCCQw0XmN4iGgWFKaIIvqPZCl5so5L1CwwgjHrnC+KjdEhImIGSF3GVmF7E4qUgMi1Py0wndPhsN6S9kj+5vR1Zvjnzalor0Z5z8VeV2lIcLklAZ1eFWCjBNycLUtG3rkBRtb/L8nBOhpf1taaqZO9n/ftZ28QRRa6oqmnnwrr11d0icjH2FQmnWV1x5MYvEEO2Z9B2Ft6snZsjC7utGnnZouNAsT8IoHYoISKP7tfNOX+C50Xgag/7QMnkmMIX75OaaJVa0vapQ/8Y7khaEzDtkx8cY/Yv7o89hl2v159e9jZRqF46Ab1gqEy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(956004)(38100700002)(8676002)(2616005)(478600001)(37006003)(66476007)(66556008)(66946007)(44832011)(31686004)(2906002)(36756003)(186003)(86362001)(31696002)(16576012)(83380400001)(26005)(6486002)(6862004)(8936002)(316002)(6636002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emhCcGwrNzU3UWZNM2RhTHpWOWhlOHlYMU5wSU92S1k4UVFHZVZzWXpyNDk4?=
 =?utf-8?B?Z1JLb1JzdGxMK2tlSUlvUW5lU0NWeGZXWUorTWlka0ZITCtNSXozRTNFU1d1?=
 =?utf-8?B?ZXlWbVRDU0VaZmQ3NS9HeWVnZG9lWkhwT0RPdVVlWXdVWUwwZmZ2MjVFbys3?=
 =?utf-8?B?Y1BLajlxOEZpNThLMXdLWWRRT0VBTjYrWWF5VnRveFd2RzlqS1JUUVdNYjgw?=
 =?utf-8?B?dkJOODA1ZCtmRThxQWpOdmNPWUpPWUFnOC81QVhjNHRFZTlENk1tVENwVzRz?=
 =?utf-8?B?eXdQcTJNNDJIZjZRbG9LUWhScUl0cko5NG84RnJJNDdpOFFKL0tGRWhTdm96?=
 =?utf-8?B?MkVmOUF2Y0ZmS2wvQjFsNGZhbmszUjY5SU5OOFFaNVA5TDNJNmR2YWs2dGFS?=
 =?utf-8?B?dlBMYnpvdU8wNDRnL2tyOFpyN2xyQnN2ckY3YU10QnFFYUtEVktQQ0FSWStm?=
 =?utf-8?B?ZEJPbC9VZVJxQ0o5Z3lzc1hlTjhXcEVDanhyOGhsQWtFS3VKTkw2bFNUQlZz?=
 =?utf-8?B?SW5FVWVDNGt3TlpDM3ZlK0RjVk5FK0x6NHNITzJVY2U2ZWgwaGMrUUlkazNt?=
 =?utf-8?B?ck4zQmNnRUZVNmZaOWNYakdQZGg5cTVJSzFxQWl4ckpyRit0MDh0VTJPYTNy?=
 =?utf-8?B?bG45WDJJY1pMNkZwUDZFSFZGM2ZxOEpoUS9RS3V5VGdHekpac01wMGcwMDUv?=
 =?utf-8?B?UG9kU3YzRGR3QmJvUStyLy9peVVKK0diTHFaL2phRGthWFR5eDA1R2RkZ3F6?=
 =?utf-8?B?aTVTdkdzeHNPTTB3QkM4VW84VzN5Z3FsY0hHQjZ6QTdrNWNIUWdEZy9XckdI?=
 =?utf-8?B?MXZNKytWMWZNUFp2bHhwYWtFbWhpaVdYangwcktFSUpYRm5GaUQ5V09na3cv?=
 =?utf-8?B?cVZWcXg1dWtXSjY5QVlyc2ppdk85bkM0LzhpcG1XaFNON0J4M1oyTHpyR0Jr?=
 =?utf-8?B?UWxPT295cWpiQVRvZEZQWWJjYzBlbXpqb3k0TW9IVWNMR3J4R0VnNGk5WUpM?=
 =?utf-8?B?a2Roa1E3TGZPZldSWUd5TGkzT1NGOGFVN2JIdVQzYTFXVVdsNEZGTUVMWjBm?=
 =?utf-8?B?SHhqV05pZVUxamhFdHRadlpZRHNZU29sbFBRS2pmRERaSXZZOFR6MEh0bHdG?=
 =?utf-8?B?N1IxeGNOYW9hckdUWDF6MXMwcHF4c3JldnM3bjFlSG9zUUFSS1kvdjIrVFE4?=
 =?utf-8?B?LzRvTkxPTTdTYUlGM3ZwSHRwZ1hMSGFBZmN2SjRCanMvY3pheWZvVWd5Y0E4?=
 =?utf-8?B?QnV0MzgvRzRjU3dQWXMyZW9lWFVxVnp2djBEcjJNZWJjZlhIcjZnRTA0SUlo?=
 =?utf-8?B?cnRnSWNUUlBhRFFYaEZoOFJhV1hTb1dieWVIa2h6YzExV0pBUkVyZUJNcFFX?=
 =?utf-8?B?YUtZQnErcm9Rc01OdG9ZMVU3cDcveWwvRHVUMWpsYTdpN3BqRW9UdG8zUjNK?=
 =?utf-8?B?ZlR1MWhTc2YwOGQ5akZxbXhZNlFsVkhCbk1JczVzK3FKcFJOQTlESzFvTDF4?=
 =?utf-8?B?bFlDakNid1JwRFhCTFpXZGIvYjF6bTJEU25vNHlZMWpIVncxWjNqVmlYODBp?=
 =?utf-8?B?T2JKZTZKbitaSTljMnNaSDJ4ZXlVUlpQVFBPYVZ0WFd2dG1mVmVvdlo2eHpa?=
 =?utf-8?B?V2laNkxTTXlnay8xS09xK1NZb1pQZFZ6cE84RncyNUVrWi9lUzZSMG4rdGJS?=
 =?utf-8?B?NCtMRFJUVCtHdHhwcENrVDNJVmRMWU1iMVcvL2pCKzhNUFp3NlRYaVdnUmhO?=
 =?utf-8?Q?EC5QveaCV8HGhpRTRcOuo7eOOXLhP8AuN3CVrcp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873a4eef-c6e6-4914-ad61-08d96358df0e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 21:32:40.1373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Oeo6XzgJbrjQrari2UDs/Ds75qx5XwjZJNk9XXznhTT8m/pmVH2B8aQF4pkDz6wFDHsB5VDMnA2H1llzQFycA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
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

Am 2021-08-19 um 10:56 a.m. schrieb Philip Yang:
> Restore retry fault or prefetch range, or restore svm range after
> eviction to map range to GPU with correct read or write access
> permission.
>
> Range may includes multiple VMAs, update GPU page table with offset of
> prange, number of pages for each VMA according VMA access permission.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Minor nitpicks, and one question. See inline. It looks good otherwise.


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 131 +++++++++++++++++----------
>  1 file changed, 84 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cf1009bb532a..94612581963f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -120,6 +120,7 @@ static void svm_range_remove_notifier(struct svm_range *prange)
>  
>  static int
>  svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
> +		      unsigned long offset, unsigned long npages,
>  		      unsigned long *hmm_pfns, uint32_t gpuidx)
>  {
>  	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
> @@ -136,7 +137,8 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>  		prange->dma_addr[gpuidx] = addr;
>  	}
>  
> -	for (i = 0; i < prange->npages; i++) {
> +	addr += offset;
> +	for (i = 0; i < npages; i++) {
>  		if (WARN_ONCE(addr[i] && !dma_mapping_error(dev, addr[i]),
>  			      "leaking dma mapping\n"))
>  			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
> @@ -167,6 +169,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  static int
>  svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
> +		  unsigned long offset, unsigned long npages,
>  		  unsigned long *hmm_pfns)
>  {
>  	struct kfd_process *p;
> @@ -187,7 +190,8 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>  		}
>  		adev = (struct amdgpu_device *)pdd->dev->kgd;
>  
> -		r = svm_range_dma_map_dev(adev, prange, hmm_pfns, gpuidx);
> +		r = svm_range_dma_map_dev(adev, prange, offset, npages,
> +					  hmm_pfns, gpuidx);
>  		if (r)
>  			break;
>  	}
> @@ -1088,11 +1092,6 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
>  	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>  
>  	pte_flags |= amdgpu_gem_va_map_flags(adev, mapping_flags);
> -
> -	pr_debug("svms 0x%p [0x%lx 0x%lx] vram %d PTE 0x%llx mapping 0x%x\n",
> -		 prange->svms, prange->start, prange->last,
> -		 (domain == SVM_RANGE_VRAM_DOMAIN) ? 1:0, pte_flags, mapping_flags);
> -
>  	return pte_flags;
>  }
>  
> @@ -1156,7 +1155,8 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>  
>  static int
>  svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		     struct svm_range *prange, dma_addr_t *dma_addr,
> +		     struct svm_range *prange, unsigned long offset,
> +		     unsigned long npages, bool readonly, dma_addr_t *dma_addr,
>  		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
>  {
>  	struct amdgpu_bo_va bo_va;
> @@ -1167,14 +1167,15 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	int r = 0;
>  	int64_t i;
>  
> -	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
> -		 prange->last);
> +	last_start = prange->start + offset;
> +
> +	pr_debug("svms 0x%p [0x%lx 0x%lx] readonly %d\n", prange->svms,
> +		 last_start, last_start + npages - 1, readonly);
>  
>  	if (prange->svm_bo && prange->ttm_res)
>  		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
>  
> -	last_start = prange->start;
> -	for (i = 0; i < prange->npages; i++) {
> +	for (i = offset; i < offset + npages; i++) {
>  		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
>  		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
>  		if ((prange->start + i) < prange->last &&
> @@ -1183,13 +1184,21 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
>  			 last_start, prange->start + i, last_domain ? "GPU" : "CPU");
> +
>  		pte_flags = svm_range_get_pte_flags(adev, prange, last_domain);
> -		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
> -						last_start,
> +		if (readonly)
> +			pte_flags &= ~AMDGPU_PTE_WRITEABLE;
> +
> +		pr_debug("svms 0x%p map [0x%lx 0x%llx] vram %d PTE 0x%llx\n",
> +			 prange->svms, last_start, prange->start + i,
> +			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
> +			 pte_flags);
> +
> +		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false,
> +						NULL, last_start,
>  						prange->start + i, pte_flags,
>  						last_start - prange->start,
> -						NULL,
> -						dma_addr,
> +						NULL, dma_addr,
>  						&vm->last_update,
>  						&table_freed);
>  		if (r) {
> @@ -1220,8 +1229,10 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	return r;
>  }
>  
> -static int svm_range_map_to_gpus(struct svm_range *prange,
> -				 unsigned long *bitmap, bool wait)
> +static int
> +svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
> +		      unsigned long npages, bool readonly,
> +		      unsigned long *bitmap, bool wait)
>  {
>  	struct kfd_process_device *pdd;
>  	struct amdgpu_device *bo_adev;
> @@ -1257,7 +1268,8 @@ static int svm_range_map_to_gpus(struct svm_range *prange,
>  		}
>  
>  		r = svm_range_map_to_gpu(adev, drm_priv_to_vm(pdd->drm_priv),
> -					 prange, prange->dma_addr[gpuidx],
> +					 prange, offset, npages, readonly,
> +					 prange->dma_addr[gpuidx],
>  					 bo_adev, wait ? &fence : NULL);
>  		if (r)
>  			break;
> @@ -1390,6 +1402,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  				      int32_t gpuidx, bool intr, bool wait)
>  {
>  	struct svm_validate_context ctx;
> +	unsigned long start, end, addr;
>  	struct hmm_range *hmm_range;
>  	struct kfd_process *p;
>  	void *owner;
> @@ -1448,40 +1461,64 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  			break;
>  		}
>  	}
> -	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
> -				       prange->start << PAGE_SHIFT,
> -				       prange->npages, &hmm_range,
> -				       false, true, owner);
> -	if (r) {
> -		pr_debug("failed %d to get svm range pages\n", r);
> -		goto unreserve_out;
> -	}
>  
> -	r = svm_range_dma_map(prange, ctx.bitmap,
> -			      hmm_range->hmm_pfns);
> -	if (r) {
> -		pr_debug("failed %d to dma map range\n", r);
> -		goto unreserve_out;
> -	}
> +	start = prange->start << PAGE_SHIFT;
> +	end = (prange->last + 1) << PAGE_SHIFT;
> +	for (addr = start; addr < end && !r; ) {
> +		struct vm_area_struct *vma;
> +		unsigned long next;
> +		unsigned long offset;
> +		unsigned long npages;
> +		bool readonly;
>  
> -	prange->validated_once = true;
> +		vma = find_vma(mm, addr);
> +		if (!vma || addr < vma->vm_start) {
> +			r = -EINVAL;

I think -EFAULT would be the appropriate error code here.


> +			goto unreserve_out;
> +		}
> +		readonly = !(vma->vm_flags & VM_WRITE);
>  
> -	svm_range_lock(prange);
> -	if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
> -		pr_debug("hmm update the range, need validate again\n");
> -		r = -EAGAIN;
> -		goto unlock_out;
> -	}
> -	if (!list_empty(&prange->child_list)) {
> -		pr_debug("range split by unmap in parallel, validate again\n");
> -		r = -EAGAIN;
> -		goto unlock_out;
> -	}
> +		next = min(vma->vm_end, end);
> +		npages = (next - addr) / PAGE_SIZE;

Use >> PAGE_SHIFT for consistency.


> +		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
> +					       addr, npages, &hmm_range,
> +					       readonly, true, owner);
> +		if (r) {
> +			pr_debug("failed %d to get svm range pages\n", r);
> +			goto unreserve_out;
> +		}
>  
> -	r = svm_range_map_to_gpus(prange, ctx.bitmap, wait);
> +		offset = (addr - start) / PAGE_SIZE;

>> PAGE_SHIFT


> +		r = svm_range_dma_map(prange, ctx.bitmap, offset, npages,
> +				      hmm_range->hmm_pfns);
> +		if (r) {
> +			pr_debug("failed %d to dma map range\n", r);
> +			goto unreserve_out;
> +		}
> +
> +		svm_range_lock(prange);
> +		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
> +			pr_debug("hmm update the range, need validate again\n");
> +			r = -EAGAIN;
> +			goto unlock_out;
> +		}
> +		if (!list_empty(&prange->child_list)) {
> +			pr_debug("range split by unmap in parallel, validate again\n");
> +			r = -EAGAIN;
> +			goto unlock_out;
> +		}
> +
> +		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> +					  ctx.bitmap, wait);
>  
>  unlock_out:
> -	svm_range_unlock(prange);
> +		svm_range_unlock(prange);
> +
> +		addr = next;
> +	}
> +
> +	prange->validated_once = true;

Should this be conditional on "!r"?

Regards,
  Felix


> +
>  unreserve_out:
>  	svm_range_unreserve_bos(&ctx);
>  

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92126C4706C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 22:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A8F10E517;
	Tue,  9 Jan 2024 22:29:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF0110E517
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 22:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROARHbV7092od1UwgnSYWy9j9Tt19G+DnWcFcZjV2dQ3SUp67dIqd4BAezU5HNPtRpibLJYsZCZUMAk0lIOt5lw8dU4g7urTsiNFpuJm4+a0M+au2PB1CcBUXt7QLvggx5YD2zM437e4LganbLyQtnb+vv687OPlPy9p6GNDkWWyPR2QWok51qImT+0fmmtYswBUOjtUx1SXWQdv6skx24DSlsQUWybpxcCIWIzHm1XLssVWj/VXOcvYMA5bGH9ZwL9lf4m/HH1rj1gc6YYNMcbbHB8FPsFDSLu7UydKVxOxb5Q1M2v6NLPtwGUSip9F0MWBUtGd1FLkGcHovHW7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRz4lQI52t3QUtwdt869MFxv9C7esbzuV/uZ0h0/vGE=;
 b=oQ1wtIad0zlizltSPIITlAUpuobw/pbE3i8tuOGtOhCRll9IDzubvDrb7h3/i4fCumFRjR3aFuuhPIRVE8OOWLGn7AE0+CTvJtY5wAtn7CC6ZA2MyvsDvQZxbGsb90a5PpbqBnBXhWDyWArmRcUiqhjzpnydNVGk1gi5C2NtsRIgIu533joGOh/VyAM+YZxn5cVrJXBlKiWYYJ9v9K1ur7ZUJ88MM/j2RNDsWzGXtTwJjzGiqf9U19hyLWxQJ4MBeXUnHxzF0BOJhgfrpq32wn6wWV2ljK64gVofWcIExoMs9Jqqau7H7/dDtvi1DkYPmd7Z7GGZZuxsCG+atqBzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRz4lQI52t3QUtwdt869MFxv9C7esbzuV/uZ0h0/vGE=;
 b=S4uULQ5WbZgtd+yHcmJ0/7P+kU9k1RlZOTR+hDpiY1zt9Ik8py2aeB95Ni8F0a8saBlnqVQjPaJtuAOzeErnqPeKK0oyT5cudjwMflNqKrRa7lQzv7Oi6f4yvfmZZPYRsbhTCgFN1Dg2aErIgF8qMvnGmMU5p1FY5dkRONf7wzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Tue, 9 Jan 2024 22:29:04 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8cf7:bb84:b64e:331]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8cf7:bb84:b64e:331%6]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 22:29:03 +0000
Message-ID: <ecc1ec75-749c-a3fd-568e-94ddbf90ba87@amd.com>
Date: Tue, 9 Jan 2024 16:29:01 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] amd/amdkfd: Set correct svm range actual loc after
 spliting
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240109200527.24039-1-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240109200527.24039-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:806:21::32) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a6a9c0-0fa4-4424-cede-08dc11626286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6B1hAtfaWenata+5hWL8MOGYXvCLAIFyGfBLxqnR2FUKPkYDGX5DSEqioBIF9Ga2bDcQXYr4dfVObilA8BPtK8mrmA7JPd/s6p4ffb/J2on5VOCkV3MAURJxkEy9Y+McrFhQVEvla27gnrrWhNS5uS3LmUTm6+R7iHUV2sUO0jwe/oH6yqwUF0386PunLOMxmWTYwVlm4NbIe8LDXD4vwSkSZTZnUaqKJN4R+EGwV3cxoqrIvCFmDLFqmJt3Snzofh8Vc6U0lX6XamLM3TGzG2SL+sXqd5d2npOw/LKqS3QEkfIYzXsBMv4GDyQu671VAp+Se4LxmHg2HoaaTL38HOQfRfrm5EpKQlEm8CCfVl3PBTnfg+2PBSwbfrRkmCOEP4yhEZ5JOLuW/QUYnkMbw6f2a4roRNZp3AwhI9CNyV/badjZtwI7AzxDFYs+X/HRuOiVTAwLOlhpJHOIu/Y7mdVLDfPdiw/gT/KXh/ZA7xXTEoU9CrsjKHB23uWpIeYkCfZOBMYTK/4pyuWBMFDSDkw8L4HUScDXONWX/opY9Je+hDlOVS0Nsth+akzypdzTuehkfPMLuJvpi7E5D6OMPZroFV8t3gPeUHCpN0d3kYHhXumO4TNwJOidHIYojSarXQ3BVwQCDRnZ9JvyN1gxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(478600001)(5660300002)(8676002)(31696002)(6512007)(53546011)(6486002)(2616005)(86362001)(6506007)(8936002)(66946007)(41300700001)(66476007)(66556008)(316002)(38100700002)(83380400001)(26005)(36756003)(4326008)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzZqZVE3clFvdUZuS1RFMFNVSi9EVDRMbDJXSXlKYUxReGVoOGc0d3Z0bWRn?=
 =?utf-8?B?M0FsazFwemJ4NzJyeWdqblRkMngzQzd6SU5FZnJNN0I0dGpkVi9qNG1PWUVE?=
 =?utf-8?B?VzViU0VoNEc1UEdGVEtYaVlCbVJyYkxiektGZjEyR3V1aUEzYi9oZ0FxelNi?=
 =?utf-8?B?MWIyWks2OFQwV3ZacUdGbjFtNXJjeUE3WjRTMFRFMXV1bkk3QlBicWtBbklY?=
 =?utf-8?B?QndSYlkzckpLN2tkRjA2QmhvTTEzd1dFNjJBNkNOT1pKdmRYdnJIYXdscmxN?=
 =?utf-8?B?VCtvcWtQVGpYaWJncXFKWVpXeWYyUmJFWkVMbXBtU2lwTjdzYk5mTDV6ajJw?=
 =?utf-8?B?SmIvVzllRFZmZzZ3V1lneWJLL3NwWlZTcFdYcnhhcEJYV2lDUmdrYUNVSFhz?=
 =?utf-8?B?bkpBc1RUYjJFOVV0ZTNndFJpUVNzOE13RERnRmVYd0wxd05CYXkyYkNlN2hS?=
 =?utf-8?B?RkhVNk03a3ZNeFo0RDJobWZJa0hEUWdKTVEwVGFERUppTWRXT3lIOW1IU2dw?=
 =?utf-8?B?ZlVDVlJKNGY2T0VHOGNiVjNJeHVKblI3OUt1WDU2dmhqbE1QMEVmR28wVmt6?=
 =?utf-8?B?alhtZzg1S0dWK0FvNlh4WE9YRnp4N2ZmbDZSMXVQTDVlclFrT3p6QW40bG85?=
 =?utf-8?B?WlI0SFdaeW5tN09nTm4rZjZmMHdyWERwUXpnNk8xUnZOOHJpRWV0emErSm5C?=
 =?utf-8?B?bjduQmU1VzEwS1pWRXdpVk9VUHJ2VVJnUWxzZ1FNSEUreTJJRjNqNkdMdFBW?=
 =?utf-8?B?cE1iN1prdUVIRVd6dEdyaFlpc3FBNHNvcEExb2VVVFExS1FrbkJRem9RS1I5?=
 =?utf-8?B?TmVDeDI3YktTd0wwd0NhSXRWbXQ4U0VnbG45dDVvM0JKNUVJWVR0VUxZbTJ1?=
 =?utf-8?B?VFNxSDM5UURBdjkrU0paVVNqWDdLUnRaK1lxUkI4WEFqL1Z0aHAxMG1xWVN0?=
 =?utf-8?B?bmVXNzJ5V2ZNOHRKQ3JUNjZnSXc2aVgvNzdiQ1NmUjRrL2s0MkMrOFJHenVq?=
 =?utf-8?B?ME90TzhnNGdrU0M2R2N4K01xZmJHdG1zd3dUdFpXcXpvV0dCK3dmbWVMTm0x?=
 =?utf-8?B?MHlwWGpGUzY0Mnhray9zR2FZYnkvQTNVdkhBOTRSRWw4ZDBrY3ZXTEd2UURh?=
 =?utf-8?B?ZVRpOVRVN2JrT29jNzBkNVZ1ZUI2RjZWU0kydmZpUXJWL2xPQVdSMWhzOS96?=
 =?utf-8?B?OVR5MTZVeldWTHZYVnZHSXk5c0pTZGtOUHFmYWRjSmthM1hPQWRXTnlkdFJi?=
 =?utf-8?B?RlVFY2JNUGVqK3BoNUc4UXZ3NnMyVVZFeHhiSzBORVEyZGNvK3ZwRkJlTENO?=
 =?utf-8?B?azdSbXpoS1Y2c2ZIbWhYQ3BYSW5GZm9tRkNyeFVDc2lqbnNOQ2VxUVFQem04?=
 =?utf-8?B?Qy9tWGxCQlFYb2wvV210cEgzVmw4WDh2NEM5TnBoOUE4b1ZoNmptdXFoSWp4?=
 =?utf-8?B?TXpNN011T2l3VmpuRG5Ia0dTZGh5UDQyOFU5VTIvWnhOY1JZVnBxaU4vQVVP?=
 =?utf-8?B?T3c2ZTEyNVBTcFova1dRSmw5Wk00Z25GVUx6dm9KZ1F1Nnk3aEhrQlUvRmRu?=
 =?utf-8?B?OHNha1B3SXc1R0VhamxPRjVrUUxhVGFYQnRmUjcvU1hzWVp4bUlYb255UER1?=
 =?utf-8?B?TUNGZmZVNXVTRm1ZMEN3RHUweWw3Nmx3QlVZZGQweFFRRldEcFh0alRXelV6?=
 =?utf-8?B?bklqRG1TZ3NoNmdQKzBYVkVsT2U3KzJKZ21OTHQra29XVFBuYkZ5VWxOSDNH?=
 =?utf-8?B?R2o0ZFM5THJhdDlRWGFLUi8wQjdqVVI4MFhuT1RVRi92K1ROU0tLa3dCT1pD?=
 =?utf-8?B?OFR0K3FVenpwMjQyeVFhUDdPNzV3a0Vwclk2UEJSeDlWbkFHVXR6VmlwKzJL?=
 =?utf-8?B?QkFwSTluYUxEWUVYT3VzUmpsSlR3VmM1S3V1ajFHbUdyY01uak1oZE9HbUhj?=
 =?utf-8?B?djRGK2VzazNadWRoMlo4Mm5TVnRqUzRidXBKSDBIMDRuUUtZOUIrN0Y1NmNw?=
 =?utf-8?B?UG9FVmdHUWEwUlduVllsRmF5RTV1VU8zSHZmMElSY3ZGUktRZmU1cjJPMFlP?=
 =?utf-8?B?WkZXa0p1M1F1V1loL0lNd2NzYzJEN09hMXlXaGs4UWNiMDVaaXFpKzdOdStm?=
 =?utf-8?Q?z5yU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a6a9c0-0fa4-4424-cede-08dc11626286
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 22:29:03.8665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwlS72iGjud2DsOrmDJUdC+2Qg/kjBWjLaBuIdOS3fl/uzCnnysnQ0CtBnXlbUxa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/9/2024 2:05 PM, Philip Yang wrote:
> After svm range partial migrating to system memory, unmap to cleanup the
> corresponding dma_addr vram domain flag, otherwise the future split will
> get incorrect vram_pages and actual loc.
>
> After range spliting, set new range and old range actual_loc:
> new range actual_loc is 0 if new->vram_pages is 0.
> old range actual_loc is 0 if old->vram_pages - new->vram_pages == 0.
>
> new range takes svm_bo ref only if vram_pages not equal to 0.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  3 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 35 +++++++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +-
>   3 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f856901055d3..e85bcda29db6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -839,6 +839,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   			prange->actual_loc = 0;
>   			svm_range_vram_node_free(prange);
>   		}
> +
> +		svm_range_dma_unmap(prange, start_mgr - prange->start,
> +				    last_mgr - start_mgr + 1);

when come here we know some pages got migrated to sys ram, in theory we 
do not know if all pages got migrated. svm_range_dma_unmap does 
dma_unmap for all pages from  start_mgr - prange->start to  last_mgr - 
start_mgr + 1.

If there are pages not migrated due to some reason(though it is rare) we 
still need keep its dma_addr, I think only hmm can tell that.

>   	}
>   
>   	return r < 0 ? r : 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cc24f30f88fb..2202bdcde057 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -254,6 +254,10 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   		return;
>   
>   	for (i = offset; i < offset + npages; i++) {
> +		if (dma_addr[i] & SVM_RANGE_VRAM_DOMAIN) {
> +			dma_addr[i] = 0;
> +			continue;
> +		}
same as above here set dma_addr[i]=0 unconditionally without knowing if 
the page is indeed in sys ram.
>   		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>   			continue;
>   		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
> @@ -262,7 +266,8 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   	}
>   }
>   
> -void svm_range_dma_unmap(struct svm_range *prange)
> +void svm_range_dma_unmap(struct svm_range *prange, unsigned long offset,
> +			 unsigned long npages)
>   {
>   	struct kfd_process_device *pdd;
>   	dma_addr_t *dma_addr;
> @@ -284,7 +289,7 @@ void svm_range_dma_unmap(struct svm_range *prange)
>   		}
>   		dev = &pdd->dev->adev->pdev->dev;
>   
> -		svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages);
> +		svm_range_dma_unmap_dev(dev, dma_addr, offset, npages);
>   	}
>   }
>   
> @@ -299,7 +304,7 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   
>   	svm_range_vram_node_free(prange);
>   	if (do_unmap)
> -		svm_range_dma_unmap(prange);
> +		svm_range_dma_unmap(prange, 0, prange->npages);
>   
>   	if (do_unmap && !p->xnack_enabled) {
>   		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
> @@ -362,7 +367,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	INIT_LIST_HEAD(&prange->child_list);
>   	atomic_set(&prange->invalid, 0);
>   	
> -	prange->vram_pages = 0;

still want it as the last patch? I thought you want also remove

prange->validate_timestamp = 0;

and

atomic_set(&prange->invalid, 0);

that are not necessary to set afterkzalloc.

Regards

Xiaogang

>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> @@ -980,9 +984,14 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
>   		if (r)
>   			return r;
>   	}
> -	if (old->actual_loc)
> +	if (old->actual_loc && new->vram_pages) {
>   		old->vram_pages -= new->vram_pages;
> -
> +		new->actual_loc = old->actual_loc;
> +		if (!old->vram_pages)
> +			old->actual_loc = 0;
> +	}
> +	pr_debug("new->vram_pages 0x%llx loc 0x%x old->vram_pages 0x%llx loc 0x%x\n",
> +		 new->vram_pages, new->actual_loc, old->vram_pages, old->actual_loc);
>   	return 0;
>   }
>   
> @@ -1002,13 +1011,14 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
>   		new->offset = old->offset + npages;
>   	}
>   
> -	new->svm_bo = svm_range_bo_ref(old->svm_bo);
> -	new->ttm_res = old->ttm_res;
> -
> -	spin_lock(&new->svm_bo->list_lock);
> -	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
> -	spin_unlock(&new->svm_bo->list_lock);
> +	if (new->vram_pages) {
> +		new->svm_bo = svm_range_bo_ref(old->svm_bo);
> +		new->ttm_res = old->ttm_res;
>   
> +		spin_lock(&new->svm_bo->list_lock);
> +		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
> +		spin_unlock(&new->svm_bo->list_lock);
> +	}
>   	return 0;
>   }
>   
> @@ -1058,7 +1068,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   	new->flags = old->flags;
>   	new->preferred_loc = old->preferred_loc;
>   	new->prefetch_loc = old->prefetch_loc;
> -	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
>   	new->mapped_to_gpu = old->mapped_to_gpu;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 026863a0abcd..778f108911cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -182,7 +182,8 @@ void svm_range_add_list_work(struct svm_range_list *svms,
>   void schedule_deferred_list_work(struct svm_range_list *svms);
>   void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   			 unsigned long offset, unsigned long npages);
> -void svm_range_dma_unmap(struct svm_range *prange);
> +void svm_range_dma_unmap(struct svm_range *prange, unsigned long offset,
> +			 unsigned long npages);
>   int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
>   		       uint64_t *svm_priv_data_size);
>   int kfd_criu_checkpoint_svm(struct kfd_process *p,

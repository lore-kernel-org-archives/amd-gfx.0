Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23FCCDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 20:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2E610E1E1;
	Wed, 11 Oct 2023 20:15:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D16810E1D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 20:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dD09eT78/dvB87f6j6eD0FM+P0ANryxONE0mMV7VmUxYQ9gRpMN3qNuvX84QCQp/P8bWKD6hhkzmxXkXcpc2hq9zEirqmgg0JnPZsrd6YG1zkBsgDpFMew745Ai+T5UrG02n2He1ZuNoDd/EUXH3h2TCTTElXbgJz8mwY9ECPmsmEcSU6++3aWxHRJGOsMG1dsRZ08w6a2VcPIT+mXZO/GHFxVjgmmIGDb5yu1LfaSA454TAQtvH2Gx8HIlkIPm4XdnvDjwRjwPDTY2FEbGwQ+MAHAwXsEuK0urnV7v71SyulrcJ/i6i5Pg3K37tOF04Hxh5Bh2UaOaS9E3RxNLOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMZnLarzrDiNv8lLcHNwZq/1aHUU4+Yxmoj/IMZPPm0=;
 b=f2kkqed3TXzbu9652CIcZTqdPGzpgRjn9J2OJ3qs1FBi4NnApVpfF6EFRneQD3VSnCvzUDkOeNoa4utjpzhP1OKBdWa0hmeJ1RxqM6P3e62VovHq8p6FeLB4SGRLZl1/iHt/dMhRMF6PiTnKQcUbys/lLLPwTKlGoMyRg+Q7RCrfEZYe1J1czHTmbjfLrEzjuXRy6LXow+HyUIgTiK8fAa5BUs5GQPtPYfXSIxWyLjo3J/XyvJpWag4FRNkLlYwQHsKFFo+9/BTczkm6DRX2+ZwNjKoxk4ss0N6mckBbLSN4Yai7OfhQ8AMTRxAvhqhE9Q/9y+x5rlPoXqxvKFwjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMZnLarzrDiNv8lLcHNwZq/1aHUU4+Yxmoj/IMZPPm0=;
 b=RqpFQMCi6HyKXnFW/6oA7QDcrprL7dmlupA05OFKUK76zJYoSarCqcwlh8aupDPY3SlYytXoQrkR5zuFH4STzxBJpZksBsJsgG8qAMPgpVMUzsELRUUOuB4HDwS7kWYHD9reJbrwA44qSKpi3NTQtSgeIOxDpaLzURO1hCxBMQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 20:15:42 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48%3]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 20:15:42 +0000
Message-ID: <db659f45-b78c-c42c-9db9-be03fa4e1038@amd.com>
Date: Wed, 11 Oct 2023 15:15:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/7] amd/amdkfd: Add granularity bitmap mapped to gpu
 flag
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231010144024.3016-1-Philip.Yang@amd.com>
 <20231010144024.3016-3-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20231010144024.3016-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0056.namprd05.prod.outlook.com
 (2603:10b6:803:41::33) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|SA0PR12MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8a7abb-ff89-45d3-a9a4-08dbca96d7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGWofvnyL/mgbIad7pVNSH7julTvDphG867o3l+AIyvgfNkmN90Lkp66P8avUjouKJveRe8RTkhXk4ln2X9HxPRGQpJOnBUmV0Sls+foVsFwUsy5wdbs7Od1Wzr9C3bXqPomvOTrGNI4LOTMISHHkvqVu3TFVN8+TH7zB1tRE0QUiRZk9k1u9CLK1zBY7vKooJnvBxuYVGwwrGKQjFsjsX1KzL0ArD47b+6HMnzNh8R04H75iw8+8Sb3UYn4cprT4t8irUzaY7nzEhohFZjwBeg2Ks+fZpcqHtpCZBNBz+I72i6a+HSIyXf4+kqnR858laz0YK2kPkvw1gKla3IksYJoLGMQdnY6Pj8VNYHO8+WtXMA+vJ8/+zpFJP7sfgMN+CvmBRjQGpvbdA4SFP6YeQfwpax+2a7YDs+SXi+Aa2T4TutBTwy+fhLjx2bnfky4UrfV6lN5BVMpBs8/vwAr/z8iP01brIHy8iwNd7TWuLWQIaYVaAyDRpsE4csaaeGIhd8n5uALyDcec3Pm2eG+l4wk6pM+nzcqbk++WBbJRf1MjNZBXMm6E269W3a/CJrNyEOAbyWDTBm39Y+UWPARAsJ61nqmRLTsYzXmEbJRm/gQYbWA69xUGGAkdaQxhPHb86QZRTTLd4YT+Z8O2pMtdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2616005)(31686004)(6512007)(53546011)(31696002)(38100700002)(36756003)(86362001)(30864003)(26005)(8936002)(2906002)(83380400001)(6666004)(66556008)(966005)(6486002)(6506007)(478600001)(41300700001)(4326008)(8676002)(316002)(66476007)(66946007)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjArTWpMTFpsYk1keG10bXJadnlZTUFobVhHT0ovbDRPVUVBSTd4TTNIYm1v?=
 =?utf-8?B?aGY4b1pJLzJzUkdGV1NpbXdwMmV4VzZJSTdSYUx4NG9Qb25oNmg2b1gvM3lt?=
 =?utf-8?B?RDBFQjRQK0VWNzhJRFMwRHA1MGhMNFRRNThuaEt6OFFpNDJZa1JPUUJFL0xE?=
 =?utf-8?B?SWlDRmZyV3pJWjZIMytVRlprcEdmYlNHeTBPZDYrcDhoZUFUMGhrR0dnd2h1?=
 =?utf-8?B?SWEzT2hLMUlJUnNid014WkpTRWhFcWEvQjNwSUNIQkdDTm5INE94TkthclBl?=
 =?utf-8?B?dEFWc2hqd1phdGg3REp0eHp1a25SemtTcU5GbmV2RkdBWnNEbDQ3Y0p0dlBU?=
 =?utf-8?B?R1VkdFU5SENWZU1qRmVsdG1BYkRrVzA5b2hjTmlGdUFSUWxvV0syNGsva2wy?=
 =?utf-8?B?QkVPd2FGR1o3SmU0cU40UmxIekllSGkwWTdueHpzdk5BdTgzOVVadXc1cDJz?=
 =?utf-8?B?V1BMSHdHVG5ObERldCs0ZENRQ1RrNjVkTXl0V2dXWXhmcDFGQjNRV0l4NXFH?=
 =?utf-8?B?bWNXWktwNUV4amN2bnp6ZGxvd2kwNXV4Z2RoOHVWbzFXOU5HYWRmN0FCeW9j?=
 =?utf-8?B?MWZudUN1Q1hjeWtEc1VqY0lNUTNsNXU4eDJ2ZCtrUGZrdksrdEVLWE9yMzUy?=
 =?utf-8?B?THZqZkFPMWhXWTRpQmgrUzkyY3p0c3BxZDlpL0xocU1jdWxWbzdQc3dpMmJR?=
 =?utf-8?B?YlZlWXNOMVhUSEFSUUFNT0hRcGFhVDJ5Z3MwNTVjcWZvQU1Qa3hyRTYrT2NL?=
 =?utf-8?B?NWdNUmNrck5BcW1mL2hGY0JBNTY0NEZVcjFZaU55UEd3cjJlUkx2WXM3UHN5?=
 =?utf-8?B?RDRVS0ZWRXpQNW1qL2lCdWFzQVJiQWxKV21KZFVoVzRpQ3I0dTZvL3lMd3g1?=
 =?utf-8?B?blBQbFFVTlZQckhXTEVlTW5OSXBOMjZkdVkwbWwwY21vWDJzTzM4ckU1MDlU?=
 =?utf-8?B?SHBkZ1F2eVFMbmZyTlZTZi93UVNQS05CdWlyeUhKQU1QN0ptckZpZnRoREd0?=
 =?utf-8?B?QStPNXZOYUIrY0htdGMwSWFOcG1WMnIvcDFDS3VsZEt0cVF4bVdSMUYwTXZ3?=
 =?utf-8?B?WGY1RndFeTBqTWtTZ01XUWF4d0VnTnk4amZlUEUyajRTdXdNb3pTSUdaTjU3?=
 =?utf-8?B?R2hzbWxyWmlDb2lZeVVpMnhnWXV5czB3KzNPZjFWMEw5SFZDczZjT2NCaW4r?=
 =?utf-8?B?Q1ZoeHhDUHdGaFJtTkl0cXBuejk1Wm5ZWHRiMXJ3cWdKWUFSRmRtVUpUdENh?=
 =?utf-8?B?Vld1RVFSZis4Y1NSOVRSQ0JLc3VsVng1MmI1N1VyOGJXaUQ1bUVkbzZTSUEr?=
 =?utf-8?B?MTNCMC9xVHpFczI1dEl1Um51clhYRDV0NjdTYm8zMkJITUFZbFRRTUN6ZktZ?=
 =?utf-8?B?bzFwQ3NKaXpxbHhSVFJ0ZkRMcEg1V0JxaEEzUWsxYndNWGZudmt5U2ZLYWhE?=
 =?utf-8?B?Y1YvQWRNY1pmdlF3cmc3S3liSWhBMkJuSlpvaytQNng4bWFheDM3RnFuZFJn?=
 =?utf-8?B?cW1JKzFkV0x0MHhydEUxQzdvRHlMa2Fkekc2VjZyRnlkdDNmSzlhcDhjTjBh?=
 =?utf-8?B?MmZoc3dsamZnWkNJK2NEcDI3bHNuZkFJaXdwcDNkc0FIMGYyQVlVNDNaOXlS?=
 =?utf-8?B?Z2p6aElpTmtPVmNRQy9qTVlxVUZUdUt2QS9EcVlCcVNNVm1ZYXRtY0k0VzJT?=
 =?utf-8?B?cTlaNWxQV0lWRXBYaERreWF0NHFLdGcwMUp0T0k3Y3h6ekF0Y2FBVTMwWE1t?=
 =?utf-8?B?WTdvR01FNFRlMDZvcEZ6K1lKSXVYaDM1VWdyckVURkdmc2RIVWdmN1R4NCs0?=
 =?utf-8?B?OERiRkdwYjVEN0JFd2xJSWVkWUhnWUIzY3VaRFkwMFNtU2RYYWRxSmNUWmRx?=
 =?utf-8?B?VGQ1K2R3dDVYZjEwV2JwUE16aUJDclhpelRQNXlOU2svN3d0Qzg0UTFYdklN?=
 =?utf-8?B?bG9yR1d3VDJqUUx6WUt4RVAweTlGQXVraUZGOWl4dlNjbVlqcjBxdmZYMGs1?=
 =?utf-8?B?UjAwQ2x3REdEOVh2VDllR29vUkU2Nm9vWGkyWWNQMUdhbm5UWmV2c05oeWFQ?=
 =?utf-8?B?SDBUcHVVN2JQU0E2ZjJuN1BxY0VEamVVdlpwQUphVXRCMjNMTERjRWZZVlk2?=
 =?utf-8?Q?m958=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8a7abb-ff89-45d3-a9a4-08dbca96d7e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 20:15:42.0982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BoulBg1kZOjT9FnQptfrL0NG+ue6q2OzCIc+ihJ5tkbmyL7liMsaOGMnvHBCdx0F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526
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


On 10/10/2023 9:40 AM, Philip Yang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Replace prange->mapped_to_gpu with prange->bitmap_mapped[], which is per
> GPU flag and based on prange granularity, updated when map to GPUS or
> unmap from GPUs, to optimize multiple GPU map, unmap and retry fault
> recover.
>
> svm_range_partial_mapped is false only if no part of the range mapping
> on any GPUs.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 256 +++++++++++++++++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |   8 +-
>   2 files changed, 213 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fb22b857adbc..4e1af4b181ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -296,12 +296,12 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>                                          KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
>          }
>
> -       /* free dma_addr array for each gpu */
> +       /* free dma_addr array, bitmap_mapped for each gpu */
>          for (gpuidx = 0; gpuidx < MAX_GPU_INSTANCE; gpuidx++) {
> -               if (prange->dma_addr[gpuidx]) {
> +               if (prange->dma_addr[gpuidx])
>                          kvfree(prange->dma_addr[gpuidx]);
> -                               prange->dma_addr[gpuidx] = NULL;
I do not know why remove this line.
> -               }
> +               if (prange->bitmap_mapped[gpuidx])
> +                       bitmap_free(prange->bitmap_mapped[gpuidx]);
>          }
>
>          mutex_destroy(&prange->lock);
> @@ -327,19 +327,38 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>          uint64_t size = last - start + 1;
>          struct svm_range *prange;
>          struct kfd_process *p;
> -
> -       prange = kzalloc(sizeof(*prange), GFP_KERNEL);
> -       if (!prange)
> -               return NULL;
> +       unsigned int nbits;
> +       uint32_t gpuidx;
>
>          p = container_of(svms, struct kfd_process, svms);
>          if (!p->xnack_enabled && update_mem_usage &&
>              amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
>                                      KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0)) {
>                  pr_info("SVM mapping failed, exceeds resident system memory limit\n");
> -               kfree(prange);
>                  return NULL;
>          }
> +
> +       prange = kzalloc(sizeof(*prange), GFP_KERNEL);
> +       if (!prange)
> +               return NULL;
> +
> +       svm_range_set_default_attributes(&prange->preferred_loc,
> +                                        &prange->prefetch_loc,
> +                                        &prange->granularity, &prange->flags);
> +
> +       nbits = svm_range_mapped_nbits(start, last, prange->granularity);
> +       pr_debug("prange 0x%p [0x%llx 0x%llx] bitmap_mapped nbits %d\n", prange,
> +                start, last, nbits);
> +       for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +               prange->bitmap_mapped[gpuidx] = bitmap_zalloc(nbits, GFP_KERNEL);
> +               if (!prange->bitmap_mapped[gpuidx]) {
> +                       while (gpuidx--)
> +                               bitmap_free(prange->bitmap_mapped[gpuidx]);
> +                       kfree(prange);
> +                       return NULL;
> +               }
> +       }
> +
>          prange->npages = size;
>          prange->svms = svms;
>          prange->start = start;
> @@ -359,10 +378,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>                  bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>                              MAX_GPU_INSTANCE);
>
> -       svm_range_set_default_attributes(&prange->preferred_loc,
> -                                        &prange->prefetch_loc,
> -                                        &prange->granularity, &prange->flags);
> -
>          pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
>
>          return prange;
> @@ -984,6 +999,47 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
>          return 0;
>   }
>
> +static int
> +svm_range_split_bitmap_mapped(struct svm_range *new, struct svm_range *old,
> +                             uint64_t start, uint64_t last)
> +{
> +       struct kfd_process *p = container_of(new->svms, struct kfd_process, svms);
> +       unsigned int nbits, old_nbits, old_nbits2;
> +       unsigned long *bits;
> +       uint32_t gpuidx;
> +
> +       nbits = svm_range_mapped_nbits(new->start, new->last, new->granularity);
> +       old_nbits = svm_range_mapped_nbits(old->start, old->last, old->granularity);
> +       old_nbits2 = svm_range_mapped_nbits(start, last, old->granularity);
> +
> +       pr_debug("old 0x%p [0x%lx 0x%lx] => [0x%llx 0x%llx] nbits %d => %d\n",
> +                old, old->start, old->last, start, last, old_nbits, old_nbits2);
> +       pr_debug("new 0x%p [0x%lx 0x%lx] nbits %d\n", new, new->start, new->last,
> +                nbits);
> +
> +       for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +               bits = bitmap_alloc(old_nbits2, GFP_KERNEL);
> +               if (!bits)
> +                       return -ENOMEM;
> +
> +               if (start == old->start) {
> +                       bitmap_shift_right(new->bitmap_mapped[gpuidx],
> +                                          old->bitmap_mapped[gpuidx],
> +                                          old_nbits2 - 1, old_nbits);
> +                       bitmap_copy(bits, old->bitmap_mapped[gpuidx], old_nbits2);
> +               } else {
> +                       bitmap_copy(new->bitmap_mapped[gpuidx],
> +                                   old->bitmap_mapped[gpuidx], nbits);
> +                       bitmap_shift_right(bits, old->bitmap_mapped[gpuidx],
> +                                          nbits - 1, old_nbits);
> +               }
> +               bitmap_free(old->bitmap_mapped[gpuidx]);
> +               old->bitmap_mapped[gpuidx] = bits;
> +       }
> +
> +       return 0;
> +}
> +
>   /**
>    * svm_range_split_adjust - split range and adjust
>    *
> @@ -1024,6 +1080,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>                          return r;
>          }
>
> +       r = svm_range_split_bitmap_mapped(new, old, start, last);
> +       if (r)
> +               return r;
> +
>          old->npages = last - start + 1;
>          old->start = start;
>          old->last = last;
> @@ -1032,7 +1092,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>          new->prefetch_loc = old->prefetch_loc;
>          new->actual_loc = old->actual_loc;
>          new->granularity = old->granularity;
> -       new->mapped_to_gpu = old->mapped_to_gpu;
>          bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>          bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>
> @@ -1346,6 +1405,108 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                                        fence);
>   }
>
> +/**
> + * svm_range_partial_mapped_dev - check if prange mapped on the specific GPU
> + *
> + * @gpuidx: the GPU index to check
> + * @prange: prange to check
> + * @start: the start address in pages
> + * @last: the last address in pages
> + *
> + * Return:
> + * true: if any part of the range within [start, last] mapped on the GPU
> + * false: if the entire range [start, last] not mapped on the GPU
> + */
> +static bool
> +svm_range_partial_mapped_dev(uint32_t gpuidx, struct svm_range *prange,
> +                            unsigned long start, unsigned long last)
> +{
> +       unsigned long start_index, last_index;
> +
> +       start = max(start, prange->start);
> +       last = min(last, prange->last);
> +       if (last < start)
> +               return false;
> +
> +       start_index = (start - prange->start) >> prange->granularity;
> +       last_index = (last - prange->start) >> prange->granularity;
> +       return find_next_bit(prange->bitmap_mapped[gpuidx], last_index + 1,
> +                            start_index) <= last_index;
The second parameter of find_next_bit is size that find_next_bit will 
look from bitmap offset, not end of bit. Look at: 
https://elixir.bootlin.com/linux/latest/source/include/linux/find.h#L54
> +}
> +
> +/**
> + * svm_range_partial_mapped - check if prange mapped on any GPU
> + *
> + * @prange: prange to check
> + * @start: the start address in pages
> + * @last: the last address in pages
> + *
> + * Return:
> + * true: if any part of prange mapped on any GPU currently
> + * false: if the entire range is not mapped on any GPU
> + */
> +static bool
> +svm_range_partial_mapped(struct svm_range *prange, unsigned long start,
> +                        unsigned long last)
> +{
> +       struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +       struct svm_range *pchild;
> +       uint32_t gpuidx;
> +
> +       for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +               list_for_each_entry(pchild, &prange->child_list, child_list) {
> +                       if (svm_range_partial_mapped_dev(gpuidx, pchild, start, last))
> +                               return true;
> +               }
> +
> +               if (svm_range_partial_mapped_dev(gpuidx, prange, start, last))
> +                       return true;
> +       }
> +       return false;
> +}
> +
> +/**
> + * svm_range_complete_mapped - check if prange mapped on all GPUs completely
> + *
> + * @prange: prange to check
> + *
> + * Return:
> + * true: if the entire prange mapped completely on all GPUs that need access
> + * otherwise return false
> + */
> +static bool svm_range_complete_mapped(struct svm_range *prange)
> +{
> +       int nbits = svm_range_mapped_nbits(prange->start, prange->last, prange->granularity);
> +       DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
> +       uint32_t gpuidx;
> +       int r;
> +
> +       r = svm_range_need_access_gpus(bitmap, prange);
> +       if (r)
> +               return false;
> +
> +       for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE)
> +               if (!bitmap_full(prange->bitmap_mapped[gpuidx], nbits))
> +                       return false;
> +       return true;
> +}
> +
> +static void
> +svm_range_update_mapped(uint32_t gpuidx, struct svm_range *prange,
> +                       unsigned long start, unsigned long last, bool mapped)
> +{
> +       unsigned long index, nbits;
> +
> +       index = (start - prange->start) >> prange->granularity;
> +       nbits = svm_range_mapped_nbits(start, last, prange->granularity);
> +       if (mapped)
> +               bitmap_set(prange->bitmap_mapped[gpuidx], index, nbits);
> +       else
> +               bitmap_clear(prange->bitmap_mapped[gpuidx], index, nbits);
> +       pr_debug("prange 0x%p [0x%lx 0x%lx] update mapped %d nbits %ld gpu %d\n",
> +                prange, start, last, mapped, nbits, gpuidx);
> +}
> +
prange->bitmap_mapped is based on prange->granularity, not same as 
[start, last]. The result is bitmap_mapped may cover bigger range than 
[start, last]. Is it ok?
>   static int
>   svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>                            unsigned long last, uint32_t trigger)
> @@ -1357,29 +1518,28 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>          uint32_t gpuidx;
>          int r = 0;
>
> -       if (!prange->mapped_to_gpu) {
> -               pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
> -                        prange, prange->start, prange->last);
> -               return 0;
> -       }
> -
> -       if (prange->start == start && prange->last == last) {
> -               pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, prange);
> -               prange->mapped_to_gpu = false;
> -       }
> -
>          bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
>                    MAX_GPU_INSTANCE);
>          p = container_of(prange->svms, struct kfd_process, svms);
>
>          for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
> -               pr_debug("unmap from gpu idx 0x%x\n", gpuidx);
>                  pdd = kfd_process_device_from_gpuidx(p, gpuidx);
>                  if (!pdd) {
>                          pr_debug("failed to find device idx %d\n", gpuidx);
> -                       return -EINVAL;
> +                       continue;
>                  }
>
> +               if (!svm_range_partial_mapped_dev(gpuidx, prange, start, last)) {
> +                       pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] not mapped on gpu %d\n",
> +                                prange->svms, prange, start, last, gpuidx);
> +                       continue;
> +               }
> +
> +               svm_range_update_mapped(gpuidx, prange, start, last, false);
svm_range_update_mapped should happen after svm_range_unmap_from_gpu, 
not before.
> +
> +               pr_debug("unmap svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu %d\n",
> +                        prange->svms, prange, start, last, gpuidx);
> +
>                  kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
>                                               start, last, trigger);
>
> @@ -1519,6 +1679,10 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>                  if (r)
>                          break;
>
> +               if (!r)
> +                       svm_range_update_mapped(gpuidx, prange, prange->start + offset,
> +                                               prange->start + offset + npages - 1, true);
> +

Same as above that the mapping range is not same as the range that 
svm_range_update_mapped covers. This leds to that some pages are not 
mapped, but the bitmap marks they are mapped.

Regards

Xiaogang

>                  if (fence) {
>                          r = dma_fence_wait(fence, false);
>                          dma_fence_put(fence);
> @@ -1670,7 +1834,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>
>          if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>                  bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> -               if (!prange->mapped_to_gpu ||
> +               if (!svm_range_partial_mapped(prange, prange->start, prange->last) ||
>                      bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>                          r = 0;
>                          goto free_ctx;
> @@ -1755,9 +1919,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>                          r = svm_range_map_to_gpus(prange, offset, npages, readonly,
>                                                    ctx->bitmap, flush_tlb);
>
> -               if (!r && next == end)
> -                       prange->mapped_to_gpu = true;
> -
>                  svm_range_unlock(prange);
>
>                  addr = next;
> @@ -1939,22 +2100,8 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>          if (!p->xnack_enabled ||
>              (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>                  int evicted_ranges;
> -               bool mapped = prange->mapped_to_gpu;
> -
> -               list_for_each_entry(pchild, &prange->child_list, child_list) {
> -                       if (!pchild->mapped_to_gpu)
> -                               continue;
> -                       mapped = true;
> -                       mutex_lock_nested(&pchild->lock, 1);
> -                       if (pchild->start <= last && pchild->last >= start) {
> -                               pr_debug("increment pchild invalid [0x%lx 0x%lx]\n",
> -                                        pchild->start, pchild->last);
> -                               atomic_inc(&pchild->invalid);
> -                       }
> -                       mutex_unlock(&pchild->lock);
> -               }
>
> -               if (!mapped)
> +               if (!svm_range_partial_mapped(prange, start, last))
>                          return r;
>
>                  if (prange->start <= last && prange->last >= start)
> @@ -2005,7 +2152,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>
>   static struct svm_range *svm_range_clone(struct svm_range *old)
>   {
> +       struct kfd_process *p = container_of(old->svms, struct kfd_process, svms);
>          struct svm_range *new;
> +       uint32_t gpuidx;
> +       int nbits;
>
>          new = svm_range_new(old->svms, old->start, old->last, false);
>          if (!new)
> @@ -2027,8 +2177,13 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>          new->prefetch_loc = old->prefetch_loc;
>          new->actual_loc = old->actual_loc;
>          new->granularity = old->granularity;
> -       new->mapped_to_gpu = old->mapped_to_gpu;
>          new->vram_pages = old->vram_pages;
> +       nbits = svm_range_mapped_nbits(new->start, new->last, new->granularity);
> +       for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +               bitmap_copy(new->bitmap_mapped[gpuidx],
> +                           old->bitmap_mapped[gpuidx],
> +                           nbits);
> +       };
>          bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>          bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>
> @@ -2147,7 +2302,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>                  next_start = min(node->last, last) + 1;
>
>                  if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
> -                   prange->mapped_to_gpu) {
> +                   svm_range_complete_mapped(prange)) {
>                          /* nothing to do */
>                  } else if (node->start < start || node->last > last) {
>                          /* node intersects the update range and its attributes
> @@ -3641,7 +3796,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>
>                  if (migrated && (!p->xnack_enabled ||
>                      (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
> -                   prange->mapped_to_gpu) {
> +                   svm_range_partial_mapped(prange, prange->start, prange->last)) {
>                          pr_debug("restore_work will update mappings of GPUs\n");
>                          mutex_unlock(&prange->migrate_mutex);
>                          continue;
> @@ -3652,7 +3807,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>                          continue;
>                  }
>
> -               flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
> +               flush_tlb = !migrated && update_mapping &&
> +                           svm_range_partial_mapped(prange, prange->start, prange->last);
>
>                  r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
>                                                 true, flush_tlb);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index bf2fde008115..7e165854bc0e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -136,7 +136,7 @@ struct svm_range {
>          struct list_head                child_list;
>          DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>          DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
> -       bool                            mapped_to_gpu;
> +       unsigned long                   *bitmap_mapped[MAX_GPU_INSTANCE];
>   };
>
>   static inline void svm_range_lock(struct svm_range *prange)
> @@ -167,6 +167,12 @@ static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
>                  return NULL;
>   }
>
> +static inline int svm_range_mapped_nbits(uint64_t start, uint64_t last,
> +                                        uint8_t granularity)
> +{
> +       return (last >> granularity) - (start >> granularity) + 1;
> +}
> +
>   int svm_range_list_init(struct kfd_process *p);
>   void svm_range_list_fini(struct kfd_process *p);
>   int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
> --
> 2.35.1
>

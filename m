Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029EDE784AB
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 17:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC8410E230;
	Mon,  2 Oct 2023 17:02:42 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98AF10E0BC
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 17:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5nYZgxxccg6MzDeMmB3zBvAidcost7S1+1XI4AcJqLMXwo0Rb4Au3VmGHTIWFAXWyzNM0ZLH0Ng5BiYUFTdYf/1EAiOa/v4WYP2zjSU/C32/cuQNp8wV4uxkwBEXxUTI93ij+iHE3V6s65OnKNCamUGngtE3QH9CVnuEwYM2abWgKy6uGm8QaVl3YgW9QfJqCeMZm3lbtQYvOyBE8nyyq01lq0tBnQs4GLpuXxWlsTcpb9TkRA+2iUeWLAzm49QViHhm8bZA+w1yMEqhpLX/g7A1QbW1wQa/r5M2nRhQefpGvUKBc4xsMMj9fFutP2KaCHqnN2k47+5L5niONqhLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aW8mOGuFi26TRfghJRz8CgXV/hneeQjCNQ8Lmufu2o=;
 b=cf6JoSQlNeuybAnlieKH7JOxw65sjk0iriIje8U2yZdzRJYnfLJHVQoUb5usD8QxvcjHh5ikqS2Us3mnEPXoACGcZL61umbtr3aC+X1c5B8W93w2QeX57pjijjvQvxfPNhNkIt/jkLau2ihb2BqxO7Fm7Nw2Szu3icMCpuitRUtNkbOXA/OXtKvc2NRP6ssaco6Jkf86OebLuJHyQqhbRfVswwNK7s/1jarVfTG7FciVuQYCEmxGoadx9Yev6TTc5c5y/ohikLs9XylCI92mSaPpDE0W+RdsslKdEiWpwr6TIiWi32wB6+AIh2ytOLdvpT95jYaOnr1InS5rPs+QtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aW8mOGuFi26TRfghJRz8CgXV/hneeQjCNQ8Lmufu2o=;
 b=xjz7BDHZd1fdKoOWWiHGnUlliMXM2SthvFRd5baPb2veAiA8D68bKfcfpaWWba7AfoJuVlTqht8pg9axUVS2lcYD4tGZOYT08NIU8TThoYqsdN6jNmpPtRal7wngG6wfNZEZexclRnHkIYO1NTsIh3+WDdddrZaX1R7LRcosNpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 BY5PR12MB4935.namprd12.prod.outlook.com (2603:10b6:a03:1d9::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.30; Mon, 2 Oct 2023 17:02:37 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f%7]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 17:02:37 +0000
Message-ID: <a223b7a5-53f2-efaf-c754-5263cb799b3f@amd.com>
Date: Mon, 2 Oct 2023 12:02:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] amd/amdkfd: Add granularity bitmap mapped to gpu flag
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929141115.10016-1-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20230929141115.10016-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0229.namprd04.prod.outlook.com
 (2603:10b6:806:127::24) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|BY5PR12MB4935:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6b2cc0-6e4c-4c5a-3a68-08dbc3696116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ta8GM6amRMj4sHVr/6Z00pgpLZubt2BYn35VB+oa/YiX9PH3SnzwaSIajSCEYD2g6YFWFQHYrbtdrk+uau4ERg/mxzEgWsYkgDSiqov4NrSF8t7VUPBoCyhGMwzptTujaVULS+xtNslrJcG4xx9SK5QzwJhZBEUCQnwejyGivLMF1tnhL7ag++9oaOmi8pSuEw5LNILzkgMBB0CvTtev192XDwTb98a8qrUC82xEjPVxkI+4tse+OvTxkrovDNf4KscyLL3s5rjFhRpiiy3d7h/EaSQifce2YPYO8vcDhv+/C5Qhg1RjZYAjDoVXTmEvHupjRRwO4EmMo1ewq/x/2U8NqVEYgw7aWepBMs3pFecrwiZaZxM3ocQp85qTyQRatzmmJhvMZCTF+xZnrzS8JGUU5pSCNiT3H/LtirkxoyZ8VKUt60LnGJ/OiXS51LlVPgRKeKUoit6bVTClUkC4CnocaAn6AFfyIwgM716ulnD59U0n36FNmYLWPOACmQhW/Wq64hLXL+chZh6fxC2WKFar3LIhwL+pZ0TsPbzaQZ54R7TsvC53AUwnP1GjPdOWsWba/vhoGBOzu/U9DNV5dX7s1YkJJRa7KUaRZP7I/MEb/im0nstjJm8M98JGe/m7iRLnAVdGGasvta3QDHIvrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6506007)(6666004)(53546011)(478600001)(6486002)(38100700002)(86362001)(31696002)(2906002)(30864003)(41300700001)(83380400001)(6512007)(26005)(2616005)(36756003)(316002)(66556008)(8676002)(66946007)(66476007)(8936002)(5660300002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SldRSUp0d3ZMcHN1VG42MWxwVXJQVStza1N2N2U1Ky85bWtIODZaUXNTbzZW?=
 =?utf-8?B?TDlxWGtCdU9JbFRVa2JlNnFFMUFkOFJTNU1YQkNtTUNPdjFVSStkanI2VXZ6?=
 =?utf-8?B?bEVmaXJZSjJSYUZ5MGw1VWY3VzU5bkRhNitGT1hoRE53YksvTFFBQVVSZEor?=
 =?utf-8?B?ZGhrK2FtNjZXRUJaa1FiT2hWTUFYV0Q2UFNhangxRmkrTjVtY0QxcXVoNjcy?=
 =?utf-8?B?RHFOdWRWNGh2bE9TZHZBZ1dQcEwrN1hTMi9vNzAyeEg5L2RlL1hNVkQ5VnJG?=
 =?utf-8?B?UnhxYklnelpTaDc0MmVmeXlOVlQ2Z29nUU1mcENieHR3eW04TWlTcE9CODFr?=
 =?utf-8?B?eU9tMzJaZm5VcHo5TmVMUVhHc05KeVZoTS9DaDBrQlVybWtEOGthNEVTbGNP?=
 =?utf-8?B?MXRScE9OOUtLcnhVWElxanV3UmxiMDVNa3VRa3M4Rm92NUpIaXFjcUc2TXBi?=
 =?utf-8?B?aDVtM3hObXh5VnhsUlhaNm5LT3FIMlhEeXFrT1l5YkE1WmZqSS9TalhhVEZm?=
 =?utf-8?B?eGNOSDRHTnZVS2VOTE9yQlpLaHQ2QkZ1SzZUd2JWanlEQUJkNlhjZmUyY3F4?=
 =?utf-8?B?QjBzVWFLZEhEejdGbzRxWU5pWWE4SERMWWxVdXQzS0ZNRVo3YkF4dGlCWjJ5?=
 =?utf-8?B?K2xMWSsyc3JPSkFscFRIMEZVdWlsZlI2MU5pSlJKK2hqaHJxa3ZZb2lnNUZJ?=
 =?utf-8?B?aFovZS9hcFlsODVlOXNKQ0g2ZDFEOGJZTXlqR0EzSDJjQ3JNOXNKQmcvVUNn?=
 =?utf-8?B?S3dueDR4UGMrK1BLeXZtTGlQWWNZTUs1ZlBKUmRBcTB5RXQ5a0IxbWhLTnRK?=
 =?utf-8?B?ZFpOdkQrS3JPbms3T2pZa0hKWVhXak0yZWdFcHllek80NUowUGt0aWJjRHJQ?=
 =?utf-8?B?QjNUMWRHR1pRM2hBZFFhSTk5TjlCZ2RLNFBFMGtwVE5SaDk1ZENpc2pBMHdC?=
 =?utf-8?B?OVY1UStaUHU3NSs1SmNVR2taRStRZmNFRzRGRS83RkR2QmJ3OGx2UXlkZVdM?=
 =?utf-8?B?SUdzSER6V3I4MEtBd0lkSXBBbHgyeUVRYS8rNEt5NU5NcGlWYVVTTW1mSWN3?=
 =?utf-8?B?NG9WZHlmUGlNNFV1RXhkSm5JZlRXYmFubGtxZ3A5amRwNmVaZ1cxVVY1bWsy?=
 =?utf-8?B?d1FuL0ZsMG9HamZsSDg2RmhxNEFKTHc1Njl0VHk5NzFyVGtFL1ZibW5PdFdG?=
 =?utf-8?B?K2s5V045QjU1ZnpvUWYxczIxWnlkemFlZkM1Wm9sZmF4UWdYbEpkVUc2bXRh?=
 =?utf-8?B?MHZ0UTNKVUNnMTRGd0lJTUtGclZtR0U2dEIrUmtMNk90UkNzcTh4RjZuM3Js?=
 =?utf-8?B?S2h2YWpVVHNDSlc2REJPTU16cy9icnU0SURzSlRDQVphUjlHUnRJN3I1Qi9s?=
 =?utf-8?B?S01aL2NydUw3Myt4UzMzWXVBTkMxaDY3OWtScUk1ei9CVFc5NFhhcUhPVTlG?=
 =?utf-8?B?VzNZT2pNdUFPL3lKY3IvN0JqdloxaitGcC9RQ2pzK0Q1SXVkbGFsZUFMak5P?=
 =?utf-8?B?RW1WQnNodWpOYlJ4OHhpNk8yQWN1MEMvQXNxckRDRld0Y3ZwVitlcjRaUGl3?=
 =?utf-8?B?aHA1Tk1hTDBXNEJqQ0xsT2RLWVFUd2ZaOEFpdUJFTWVMN1hyeENxS1hpeHdC?=
 =?utf-8?B?ODBwS0I0c2dkTUh1Z3BpQ2hXWEpiZlM1cEtwdVAvV3pCYWhtMXVVMFB6MDdh?=
 =?utf-8?B?bEJVTFN0cVB4eDF2ZWhzRjViQW1sTzJlaXZsOWllaTUwWXBXR0NiYXJlZHJW?=
 =?utf-8?B?SHFtZ2ZxU3Q0VWNVQnMzNW90T3pCaENlVGI1T2JBbjFuaDN0aU0zTkJaS2FI?=
 =?utf-8?B?RnozYWVrSHhFZUd6aXNZd3hjMmFyZGlUNzU3ZWZlU29HRUU1RmI1bUVhT3ov?=
 =?utf-8?B?OUlzL3B6T2JVYTNtSlJCVGVwSVdWUTV1azE1cUFVUTNqWVhxR1lEelJVS2Nz?=
 =?utf-8?B?UzBIRUFUakdoSURvdTVWZG1sT0pyeFJmdk1iTzNNVEJ4eUNaVUh6TEtubHQv?=
 =?utf-8?B?N2R1TUVWSllsRFc5OUpMdUF0TjFtaktzQ2FkVUVuVWx6VnF0UjlnZXRZY1dK?=
 =?utf-8?B?R1B3TG1vR1ZrUGVFZncwYjAySW9QT3Y1aG5XZVRLazBwTmZnZVBtQVRHNWZh?=
 =?utf-8?Q?J9ds=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6b2cc0-6e4c-4c5a-3a68-08dbc3696116
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:02:37.2649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7nn80WdcWb8KMS5hk76MYWy3SykMGMlsZ5bqImX3l743VC8ChHC+XRxdin/0xg9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4935
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


On 9/29/2023 9:11 AM, Philip Yang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Replace prange->mapped_to_gpu with prange->bitmap_mapped[], which is
> based on prange granularity, updated when map to GPUS or unmap from
> GPUs, to optimize multiple GPU map, unmap and retry fault recover.
>
> svm_range_is_mapped is false only if no parital range mapping on any
> GPUs.
>
> Split the bitmap_mapped when unmap from cpu to split the prange.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 218 ++++++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |   4 +-
>   2 files changed, 184 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 040dc32ad475..626e0dd4ec79 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -292,12 +292,12 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
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
> -               }
> +               if (prange->bitmap_mapped[gpuidx])
> +                       bitmap_free(prange->bitmap_mapped[gpuidx]);
>          }
>
>          mutex_destroy(&prange->lock);
> @@ -323,19 +323,38 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
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
> +       nbits = svm_range_mapped_nbits(size, prange->granularity);
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
> @@ -354,10 +373,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
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
> @@ -972,6 +987,48 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
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
> +       nbits = svm_range_mapped_nbits(new->npages, new->granularity);
> +       old_nbits = svm_range_mapped_nbits(old->npages, old->granularity);
> +       old_nbits2 = svm_range_mapped_nbits(last - start + 1, old->granularity);
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
> +                                          old_nbits2, old_nbits);
> +                       bitmap_shift_right(bits, old->bitmap_mapped[gpuidx], 0,
> +                                          old_nbits2);
> +               } else {
> +                       bitmap_copy(new->bitmap_mapped[gpuidx],
> +                                   old->bitmap_mapped[gpuidx], nbits);
> +                       bitmap_shift_right(bits, old->bitmap_mapped[gpuidx],
> +                                          nbits, old_nbits);
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
> @@ -1012,6 +1069,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
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
> @@ -1020,7 +1081,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>          new->prefetch_loc = old->prefetch_loc;
>          new->actual_loc = old->actual_loc;
>          new->granularity = old->granularity;
> -       new->mapped_to_gpu = old->mapped_to_gpu;
>          bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>          bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>
> @@ -1310,6 +1370,84 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                                        fence);
>   }
>
> +/**
> + * svm_range_partial_mapped_dev - check if prange mapped on the specific gpu
> + *
> + * @gpuidx: the gpu to check
> + * @prange: prange to check
> + * @start: the start address in pages
> + * @last: the last address in pages
> + *
> + * Return:
> + * true: if any partial range mapped on gpu based on granularity boundary
> + * false: if the entire range not mapped
> + */
> +static bool
> +svm_range_partial_mapped_dev(uint32_t gpuidx, struct svm_range *prange,
> +                            unsigned long start, unsigned long last)
> +{
> +       unsigned long index, off;
> +       bool mapped = false;
> +
> +       start = max(start, prange->start);
> +       last = min(last, prange->last);
> +       if (last < start)
> +               goto out;
> +
> +       for (off = start; off <= last; off += (1UL << prange->granularity)) {
> +               index = (off - prange->start) >> prange->granularity;
> +               if (test_bit(index, prange->bitmap_mapped[gpuidx])) {
> +                       mapped = true;
> +                       break;
> +               }
> +       }
> +out:
> +       pr_debug("prange 0x%p [0x%lx 0x%lx] mapped %d on gpu %d\n", prange,
> +                start, last, mapped, gpuidx);
> +       return mapped;
> +}
> +
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
> +static bool svm_range_is_mapped(struct svm_range *prange)
> +{
> +       return svm_range_partial_mapped(prange, prange->start, prange->last);
> +}
> +
I think svm_range_is_mapped actually means if there is any 
prange->granularity range inside prange is mapped to any gpu, not prange 
got mapped. The name is confusion.
> +static void
> +svm_range_update_mapped(uint32_t gpuidx, struct svm_range *prange,
> +                       unsigned long start, unsigned long last, bool mapped)
> +{
> +       unsigned long index, nbits;
> +
> +       index = (start - prange->start) >> prange->granularity;
> +       nbits = svm_range_mapped_nbits(last - start + 1, prange->granularity);
> +       if (mapped)
> +               bitmap_set(prange->bitmap_mapped[gpuidx], index, nbits);
> +       else
> +               bitmap_clear(prange->bitmap_mapped[gpuidx], index, nbits);
> +       pr_debug("prange 0x%p [0x%lx 0x%lx] update mapped %d nbits %ld gpu %d\n",
> +                prange, start, last, mapped, nbits, gpuidx);
> +}
> +
>   static int
>   svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>                            unsigned long last, uint32_t trigger)
> @@ -1321,29 +1459,28 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
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
> +               }
> +
> +               if (!svm_range_partial_mapped_dev(gpuidx, prange, start, last)) {
> +                       pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] not mapped on gpu %d\n",
> +                                prange->svms, prange, start, last, gpuidx);
> +                       continue;
>                  }
>
> +               svm_range_update_mapped(gpuidx, prange, start, last, false);
> +
> +               pr_debug("unmap svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu %d\n",
> +                        prange->svms, prange, start, last, gpuidx);
> +
>                  kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
>                                               start, last, trigger);
>
> @@ -1483,6 +1620,10 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>                  if (r)
>                          break;
>
> +               if (!r)
> +                       svm_range_update_mapped(gpuidx, prange, prange->start + offset,
> +                                               prange->start + offset + npages - 1, true);

svm_range_update_mapped set the mapping bitmap with prange->granularity, 
but the gpu mapping is for [prange->start + offset,  prange->start + 
offset + npages - 1]. The mapping bitmap covered range maybe bigger then 
the range that got mapped.

In following gpu page fault handler you use 
svm_range_partial_mapped_dev(gpuidx, prange, addr, addr) to check if 
addr is mapped. Is there a room left that addr is not mapped, but the 
mapping bitmap covers it? That would cause the page fault at addr never 
got handled.

Regard

Xiaogang

> +
>                  if (fence) {
>                          r = dma_fence_wait(fence, false);
>                          dma_fence_put(fence);
> @@ -1648,7 +1789,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>
>          if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>                  bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> -               if (!prange->mapped_to_gpu ||
> +               if (!svm_range_is_mapped(prange) ||
>                      bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>                          r = 0;
>                          goto free_ctx;
> @@ -1729,9 +1870,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>                          r = svm_range_map_to_gpus(prange, offset, npages, readonly,
>                                                    ctx->bitmap, flush_tlb);
>
> -               if (!r && next == end)
> -                       prange->mapped_to_gpu = true;
> -
>                  svm_range_unlock(prange);
>
>                  addr = next;
> @@ -1900,10 +2038,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>          if (!p->xnack_enabled ||
>              (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>                  int evicted_ranges;
> -               bool mapped = prange->mapped_to_gpu;
> +               bool mapped = svm_range_is_mapped(prange);
>
>                  list_for_each_entry(pchild, &prange->child_list, child_list) {
> -                       if (!pchild->mapped_to_gpu)
> +                       if (!svm_range_is_mapped(pchild))
>                                  continue;
>                          mapped = true;
>                          mutex_lock_nested(&pchild->lock, 1);
> @@ -1966,7 +2104,9 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>
>   static struct svm_range *svm_range_clone(struct svm_range *old)
>   {
> +       struct kfd_process *p = container_of(old->svms, struct kfd_process, svms);
>          struct svm_range *new;
> +       uint32_t gpuidx;
>
>          new = svm_range_new(old->svms, old->start, old->last, false);
>          if (!new)
> @@ -1988,7 +2128,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>          new->prefetch_loc = old->prefetch_loc;
>          new->actual_loc = old->actual_loc;
>          new->granularity = old->granularity;
> -       new->mapped_to_gpu = old->mapped_to_gpu;
> +       for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +               bitmap_copy(new->bitmap_mapped[gpuidx], old->bitmap_mapped[gpuidx],
> +                           svm_range_mapped_nbits(new->last - new->start + 1,
> +                                                  new->granularity));
> +       };
>          bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>          bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>
> @@ -2107,7 +2251,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>                  next_start = min(node->last, last) + 1;
>
>                  if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
> -                   prange->mapped_to_gpu) {
> +                   svm_range_is_mapped(prange)) {
>                          /* nothing to do */
>                  } else if (node->start < start || node->last > last) {
>                          /* node intersects the update range and its attributes
> @@ -3587,7 +3731,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>
>                  if (migrated && (!p->xnack_enabled ||
>                      (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
> -                   prange->mapped_to_gpu) {
> +                   svm_range_is_mapped(prange)) {
>                          pr_debug("restore_work will update mappings of GPUs\n");
>                          mutex_unlock(&prange->migrate_mutex);
>                          continue;
> @@ -3598,7 +3742,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>                          continue;
>                  }
>
> -               flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
> +               flush_tlb = !migrated && update_mapping && svm_range_is_mapped(prange);
>
>                  r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
>                                                 true, flush_tlb);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index d2e94d8fb4be..10c92c5e23a7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -132,7 +132,7 @@ struct svm_range {
>          struct list_head                child_list;
>          DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>          DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
> -       bool                            mapped_to_gpu;
> +       unsigned long                   *bitmap_mapped[MAX_GPU_INSTANCE];
>   };
>
>   static inline void svm_range_lock(struct svm_range *prange)
> @@ -163,6 +163,8 @@ static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
>                  return NULL;
>   }
>
> +#define svm_range_mapped_nbits(size, granularity) DIV_ROUND_UP((size), 1UL << (granularity))
> +
>   int svm_range_list_init(struct kfd_process *p);
>   void svm_range_list_fini(struct kfd_process *p);
>   int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
> --
> 2.35.1
>

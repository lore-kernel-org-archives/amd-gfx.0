Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16457CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 20:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7902A10E0D6;
	Wed, 11 Oct 2023 20:13:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A88C110E0D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 20:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnJEMJ/BFTby5qHaD+C7beGDTVZ2U01JKvJypj/NRA1t7TEtPSfXFYL0KWVaYUiCDM5lTl0syhBerwvntcZC1rkTJSsA8DG0PYwL7EcDE/3PZDdSEUSlF0WOhqHzzGGyWCe1s02akRq55TthrRRyPJLC1xFMdBKRVNBkJhJSsmbn/IXhuUJqu5nhZpDs+LGptcNEJ58zqOkrI4XFBWytKEx4Vd9koKsDMaZRwFR375LvBP+UeSuvAvbVVvhiC1hvIkxCbu7JV+Haz5wRR3FUD82g9gLQV/a67qLnifKPuqa+PZYnxyG/9rPK4SaFQWElSHSM5QOz8aY1HGTlPimrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qSb6ta7DAklp1zcMnbv4kDnpD0XsEyB5qZfqY7YheE=;
 b=LmCjvrRZwM4xmaXcQmHLT2/WC+Fm27nnDZ3XKA6iFaOuhEEHXYzCVmIScPR9xC25TmVOVznV5cvsYDIarRofgYUNbK4pHVhq76n/NHAnCy9a+JJeewEpdj2KBOf731AhPdJjC0S2h/yypHXdqq989n4R6Qf5bAvL1Oh9a28k1/xYVz4GJ+4JERe6h9Sp92EbEuoSnt+QS/wZxHiuAhFkhlyyZ/M6w7U07JEwzBpniKiRiCaNKSjt5eawyBQUAJGYAAvSj76aRRDc0TEq7Ex/OZhjP08HUVwdxx4XvSipKaV5LfSjpkOBopfaNy5HYRkg1QM5PYDHVuehXI0ZpnOCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qSb6ta7DAklp1zcMnbv4kDnpD0XsEyB5qZfqY7YheE=;
 b=kCGjDZ+f8qRdGQzhu2pPjPG9d141Xd1BieDMQ96qfBIadcv468BoplgrxHsuuEV5tFSGb7wYFbmIVMkqf3/sSniLv7YvMIyXHj8bCXBfyVJaCGDpoq1CZBt9zpmcSp+ByRTJTYz+gNtXX7Pn9PmnL5KlzMd7S5KJG1WzprTTf4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 20:13:30 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48%3]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 20:13:30 +0000
Message-ID: <6933556b-d911-df84-76f5-ec3f8f79b61b@amd.com>
Date: Wed, 11 Oct 2023 15:13:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/7] drm/amdkfd: Wait vm update fence after retry fault
 recovered
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231010144024.3016-1-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20231010144024.3016-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::29) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ee5420-7bda-4af3-9f99-08dbca96894b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dtJN64abC/kcOBChIqaax1S/6S9ZS5U3Ams/8VJv1wMl29iSlBafDpOk8Qs826TCiK9rkU/vaA5iOVyV8p8Va4Rx4nms2LlC3PNBD8nX5X9n8066YvAQecX4PiqNjJ+3pFVqmomsZcHi8PN0JZk8S/ZQvF4s+pWp+uk6kpzblf6+xitUniwxyc9PNSveZbWpBcuYUz0hWvIfuFvIfJj52DLhpy3fVWMj3RUBUbwPmOR+4FQGqrdqjj+nTCiZsAInT4E243vK/uVJOzATt9I5rVkr9JbkVrBAYZfP1DkBoOjudIBF4NJtSUWR5b2rztLUn6vF8yVDDKWI6WUUMX52J155uoBe1+uPlI+Mg6E1vypqsxZioK0YK+cnpFIm3IYPOcc0ii7fjkw5861aMvJexzxm/0kW1qjUeTVvSXY2l4jSC4IlLxkDnTeDzpvKWo17uaxNKM8dDtUTPP13OtQxGvTHn4mVVKnMPZsizEMsaEzL16urAVCLNbNie48QO0VSF26629qkNOhXlmrQJEgXPQbIp9ASJfTB2U/t3EkII4AEV1bXi4DcSS0ROuiY4828m2xAyU//uwKtPZtEuQqknRzfYaC/fcznDiIhvbj3CVA/oue1o54kTg6HBZ8+GE3G04F0yf8bv0BLqyE4r3jGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(53546011)(6506007)(2616005)(316002)(6512007)(36756003)(31696002)(86362001)(478600001)(38100700002)(41300700001)(8936002)(6666004)(2906002)(15650500001)(66946007)(26005)(83380400001)(4326008)(5660300002)(8676002)(66556008)(6486002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0R3aEh4VFM3SjVjR1lnaFVKTUtmTDBPaWpNdit1RVpaMW9rcTNMWlFzR1lK?=
 =?utf-8?B?NVBZVHdzWDhEM0RDTll5WFBLbUgzZ0JoRHc3ZWxTTjV0Q1czMGxDZm1XMnFK?=
 =?utf-8?B?K1htUXN5SlVpV3YwdGNtRzY2bFlMb0JNK1hYZUZHbkRraHNITGJYais2cnpW?=
 =?utf-8?B?NGNCM2tqMW5aeG5aZ1dyTkFOM2QzY1ZEdGNFYmFJZnAzNmxyU1R1VXNlczI2?=
 =?utf-8?B?TThTaDNDVjN0aVR5a0w1STdKc2pMWHFFcjlYQ3JIeFZJSHJZamU4YklkcE96?=
 =?utf-8?B?Z0xoSHNQWEtkRFNwUjJONjM4b2JrTS9WcDVlc1hqUFNySWJWR1psT1VuRHh0?=
 =?utf-8?B?ak0weTFzVU5NS2pqV0REYjRFVzdmcDMxQi9sb25OTG5qT1pGWnIyM0tweDJ5?=
 =?utf-8?B?MTdmV1B4NE9LQ3hhejhmMWUydUVLaVQ1ZktLUExTM0ZCVHZDMldNMnJNZ2Rs?=
 =?utf-8?B?Y29uanJUVzJyWENDRVNIZ0MzQWppMkJCWkR6N01nVk1ycjJRS1U3M1JYaGpo?=
 =?utf-8?B?VlNEUktGcUNrcUhKaWlkbTNaNHo0V3B4am5YU3Z1MkZuMXJ1QjJXazMwTVVU?=
 =?utf-8?B?OHdwRUhnQmE1bUJTUXB2S2ZDRllENHdPY1dIM1dnMW0vQVBUM2pCb0VmZ3Z1?=
 =?utf-8?B?L1pJQjRIVFpvZTg4RXBNVTZFTldQZHZFUXFHdlk2N0xmSXA3QUNTV0JVT3ZZ?=
 =?utf-8?B?NE9jSm56bkQyMXZpTm9ZSkkrNy9XaTNERlJacEZNVENJbHBnYndEejRhbnV5?=
 =?utf-8?B?Z0lqbjhlOHkzaHRIckJEOEdRc1dWekNnTFdhamltT0wrSDlCWXYxbHg5VGhH?=
 =?utf-8?B?NHZtMEtDY2VMNUVZcEM4blMzaGlmUWRaYkl3OVN1d3N1d3JZM09oRXpYMUVu?=
 =?utf-8?B?aTBBWE9wU3RFeHNhc0JiN3Rud1FSM1lRSnZhMGZQQWQ3cVgrejdZWk1aRG9H?=
 =?utf-8?B?dWs5VURobVBWWXJGL3NrYlc2cHlCbTFHNzBIT0RueXcwYTllaVFPOFZkWlhZ?=
 =?utf-8?B?UVA4aVNsdmtEUmVRMFVtSTljU3lMVHhiZEZsWGNlVk1yMlo1ZkcyZmhkVDJC?=
 =?utf-8?B?UTFOVS91bENCOVBiZVBqbFY0WGRWWTE5WHZTT0NIa2tNajdaUU9GdXdKRFJZ?=
 =?utf-8?B?M0NLK2FIc09DdEVkUFYrZkNWKzFjNUhubTJKQVJIY0w4MEluY3hBZTBPSlpS?=
 =?utf-8?B?OHRYUnRiTEk0S3A4NzhROTBxazBOcjVNcGdBUkk2YkRsN1B6am82YThzaXdF?=
 =?utf-8?B?ZWpjb0FudEJaMzF6T2pEcUJDdWV5dWNIQ1NFWmUybzBzTmJrU1BnNlAyME90?=
 =?utf-8?B?NWlkRjQwNk1YVm5na0w5V1k4WWFmazN3b2JHL3ZyaDU2bFBKeFMvcnlLTnZv?=
 =?utf-8?B?bEMrSDFWbE11QmpWeUcyaEtYS0duNExzcktMelJLN0tFZlQxdVJzekV4Vjha?=
 =?utf-8?B?RitranphRUZXV2ZnQVZJTWxjMitOWHc4TzhvWFhlWWpRYUF6VnR4bnBMbVc1?=
 =?utf-8?B?VHVlYjlKazgwbkxDWWU1dS9tOUVzVnZWMnp0dHV4U2ZrYWNPTHBnSTBSNEZG?=
 =?utf-8?B?RHd2VEgxaGVudjM2aXlVTGV2dEhiaDl4d2MremRtRVhMUU43N2gwNU1kaU13?=
 =?utf-8?B?U1FzNGlrRm0yazhOdGhjUmp4bFI0VVZOSEVlMTVEcDZOVllZNU9EYkcvWk5Q?=
 =?utf-8?B?UHBkSmd3NG5rM1AvWmRVR0tIbG1qV2JEanErMldiUUkyRWpTT1VFeUZtUjhn?=
 =?utf-8?B?Zk9SWHhkS1NSd0c0eHNycXJXQ1Y1MDFTVFQyZEpLOUZEQURYWWFUUFQzWENx?=
 =?utf-8?B?SVFOSE5mcjlnS0tzelBUU2EwVXRNaDRxVndYNEFJNHNyTDV5MFR6dndhWEVP?=
 =?utf-8?B?YTgwejZ4NGlOYWl3aWJHSC83UzV4Z3lJQW9NakpoUzAybjgyMzFWOHVPR21I?=
 =?utf-8?B?WHJiaVlMWlZBeG96U3dTQXRxa1A3UGovK2o1TG9sVnZDaXFuYmoweEhiNUJS?=
 =?utf-8?B?Z0kwUTZPbGYwL1NiL1V2R1BMd2FhaDdsSEJqYklwcDV3WW41Snh5WTlGVFpx?=
 =?utf-8?B?ajdxYlpHUm9Qa0w1RmlEUkVoUHVqVWVUZFRILzVJV0xRamg5TGRYcXY1ZjVo?=
 =?utf-8?Q?S9jc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ee5420-7bda-4af3-9f99-08dbca96894b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 20:13:30.2424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEipg8UKwcsLQP/eLqXlf4tatTRbVwkJ/oB/5Kh/Y9TAf8dU4R1cVsaB2xbMVKKr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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
> If using sdma update GPU page table, kfd flush tlb does nothing if vm
> update fence callback doesn't update vm->tlb_seq. This works now because
> retry fault keep coming and will be handled to update page table again
> after AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING timeout and flush tlb.
>
> With the following patch to add bitmap_mapped flag, the retry fault
> recover will only update GPU page table once, need wait vm udate fence
> and then flush tlb.
>
> No change if using CPU update GPU page table because no vm update fence.
>
> Remove wait parameter in svm_range_validate_and_map because it is
> always called with true now.

I think it is better to add sdma at this patch title, like " Wait sdma 
vm update fence after retry fault recovered" as this patch only applies 
to using sdma to update page table in page fault recovery. It can 
improve performance in this case.

Waiting fence would delay page fault recovery process, we may need to 
look how it affects IH sw ring overflow in future.

Regards

Xiaogang

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2b4ccc0531e8..e195106a77cb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1454,7 +1454,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   static int
>   svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>                        unsigned long npages, bool readonly,
> -                     unsigned long *bitmap, bool wait, bool flush_tlb)
> +                     unsigned long *bitmap, bool flush_tlb)
>   {
>          struct kfd_process_device *pdd;
>          struct amdgpu_device *bo_adev = NULL;
> @@ -1487,8 +1487,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>
>                  r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
>                                           prange->dma_addr[gpuidx],
> -                                        bo_adev, wait ? &fence : NULL,
> -                                        flush_tlb);
> +                                        bo_adev, &fence, flush_tlb);
>                  if (r)
>                          break;
>
> @@ -1612,7 +1611,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
>    */
>   static int svm_range_validate_and_map(struct mm_struct *mm,
>                                        struct svm_range *prange, int32_t gpuidx,
> -                                     bool intr, bool wait, bool flush_tlb)
> +                                     bool intr, bool flush_tlb)
>   {
>          struct svm_validate_context *ctx;
>          unsigned long start, end, addr;
> @@ -1741,7 +1740,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>
>                  if (!r)
>                          r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -                                                 ctx->bitmap, wait, flush_tlb);
> +                                                 ctx->bitmap, flush_tlb);
>
>                  if (!r && next == end)
>                          prange->mapped_to_gpu = true;
> @@ -1848,7 +1847,7 @@ static void svm_range_restore_work(struct work_struct *work)
>                  mutex_lock(&prange->migrate_mutex);
>
>                  r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -                                              false, true, false);
> +                                              false, false);
>                  if (r)
>                          pr_debug("failed %d to map 0x%lx to gpus\n", r,
>                                   prange->start);
> @@ -3094,7 +3093,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>                  }
>          }
>
> -       r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
> +       r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
>          if (r)
>                  pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>                           r, svms, prange->start, prange->last);
> @@ -3643,7 +3642,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>                  flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
>
>                  r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -                                              true, true, flush_tlb);
> +                                              true, flush_tlb);
>                  if (r)
>                          pr_debug("failed %d to map svm range\n", r);
>
> --
> 2.35.1
>

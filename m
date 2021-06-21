Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C863C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 20:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517FF6115B
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 20:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517FF6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25086E413;
	Mon, 21 Jun 2021 20:02:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD716E413
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 20:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4afn0uJZZ6fRAwls9T/Npd6owL6U1wYqtBtjrfJvomC74j7IULcIOPF30fiR5mzmHeX64jORbfRu4aPPhy+jHW4xnZLbrNeH16VV7SfLxJcXPGyHisvEyssDAR5iBm3FO0L4LoZ8SUqhQ+MPK1d2HWXKf59p/u6ZIFzFH+nd6PH29DNwriO/iVL0CgQ0+HdM76jeVPJ541gqB3S7xpDjJIyMfU6q/Fqngnsd3sm19odm7qL8QUWTHcsU8klFZxCaosZwqViYy64fqnq6DiU8nHyKEbtMi1hwZrRh+UWpoxdKGAos0DessNnTzbcWjvyAoXNrQyOkvnmRbOr755lOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYoTkUbJPNLr9cS27o8hAt5dgcR0a8TkNiwCF13vWuA=;
 b=Diaibil3qUE3aqoGrLBLXU9CwHkahe5u9/WuSa1RjsLkitp1ZfEslQuCczwpahP+CbVMNQpywDn84BW4zvyycxS3A5+LsSMfSg98ylL3inLNx+KAaVc7WzRxgATMucy8eiIdiv6MZMWhV8pWRi0hX/gpuDzQMreSQYHOstQ0kk1LY1uwmgRvYfwpxoECiS0yW+nYJb80K30pixlSr8TQbtcvAy3wRumyVJJ8OnoGjKyxZ8DrRdkCejo2coNWpOBZT8jd5pxsfG26whwJQ3V99Ywp7zw1ZBu7xgbuWaUWzzl7TcK0bMT6ABx1uJzNfGb0f5fBXJin4+EOh9nI4hCACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYoTkUbJPNLr9cS27o8hAt5dgcR0a8TkNiwCF13vWuA=;
 b=DPcQ8bYGvTGNZQ9o+mWepV2KMXY6waxZMZk+XNoEPL8sNFMYRSIEsb6MgMhT0ZFIbNpMMAuCxtNjB8Z+c1vohzKnck/6EB4fRc4v1lZoj/1TmYplzql0paskPChdbOcaXYtO+iVO0MVANyhqLQK2oPFahbixvuR/80JWalMSC4g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 20:02:53 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 20:02:53 +0000
Subject: Re: [PATCH 03/10] drm/amdkfd: set owner ref to svm range prefault
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210621160423.3517-1-alex.sierra@amd.com>
 <20210621160423.3517-3-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <c3dee4fb-af0a-110e-81a7-d3ee9d2f5c79@amd.com>
Date: Mon, 21 Jun 2021 16:02:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210621160423.3517-3-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::22) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Mon, 21 Jun 2021 20:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1cfe283-520f-44d5-e877-08d934ef8e1f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5033:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5033A3C9B9761557B20F94A1920A9@BN9PR12MB5033.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buxdX7p/xx4pKHhwhBF4BP1l0faqj2Mt8veYvLZvJLa6JtQozvgTJFi1y8PU8V7m5V19wHMKSsq/MMJU3PNOr7nRtSglGDqsyD6mCP6KFW1Sp+Tv44PBWujPRfZay58yihl/2gTV1bK1ITFrelkxEmViDpxBVA2Fd0YWVm/5pcLW0Ij8lGlAezb9ondMzevtMYq0tsTSwsOgpdyWH6TrDqiATsyIDkyFcYz9swVQTaYEpSlqTEAhEBSrSrKD2SmZqIBAjNqAF+PfzMF3izb4EXdRMc3ZewW3hpplp58lelIX+r2u+trc7nnAIKYXMt7cufOMCwvTSFVxYBL9O4q67QcOvtQvJFSFIVXWSpJ/mhpRw3LJrbkPulyW/XelXc75bZO5m94ffHwajsUnuEt9TpL+nnZHYZ5l/b4pWDYj8wNczuEdM3xs3RDCBrKcpzRKdY4190Htsir4xXZR3O5kyXgShfPpynmJIPkO4KU28IZOw6zQRzWtiutWxIGa7WPYARjoLnC1pM5ednsNLLQ3ktTgiK5r/Jg1K1srlTmefphIrfZozVhPA/vZ6+oNgnW/yr8EPv4OQ7LzfHDAl7t+0Gze/lkQViEtsGXxhH5izNV0KT014B8SFkFTrBscWyJsFumN9c3eXPMQFM1h404mEmIw68j/XAlHlvavPOao8u1f4C82IZyqXq+mYzphoZl5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(53546011)(36916002)(36756003)(186003)(5660300002)(83380400001)(31686004)(6486002)(66946007)(38100700002)(8676002)(26005)(16526019)(16576012)(66476007)(316002)(8936002)(956004)(44832011)(31696002)(2906002)(86362001)(66556008)(478600001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjhyNjJLUExOMlNXNGFyWURsdzJVQm1KL2o2ZkJuakkrb1RZM0NZL0paQUV3?=
 =?utf-8?B?M2djdXVQZmZubW4zK3NCdkdNNk15MkZtRVFxMmFKZnBVblE1d2NtU29mSEZF?=
 =?utf-8?B?eUczRjRwM2NBTFlkRTRBSnV4T3J5U0NwclJZdkhqNW8yL28vNy8rejQzMVZj?=
 =?utf-8?B?bmVnMTlTWjFyc1ErRzZNaER3Z2pkdXAwOHZJaU9aTzJTKytUM3BQRk5HV0hX?=
 =?utf-8?B?TExsQ2RLeFpZWVhHK2diN3BVVkwxU2hSYnZxSHhvbHBtQkNOaG1oVVVnRElC?=
 =?utf-8?B?bW51WTNXc3ZrS0lVZksxMURubk9SWmcyTWxlcEpRQnZUN1NzMk80T2h5Skxq?=
 =?utf-8?B?MkNyQkNzMXBLamoyWmpDM2ZueGFPTnFZNkdMOFNxcTFMMHdOaVl4UXFPTzdn?=
 =?utf-8?B?ZEdnYjRZUWtnSWVyZmhkMDMxVFgrU2FiTjRmKzdyNVhrdTRsTkxYK1hiajVS?=
 =?utf-8?B?dlRSMVRpN29mdmp6RW51YmZtOXVvc3d5NlAyeG90TWF3dHVlb0Q5OEUrVklL?=
 =?utf-8?B?eEp5WTU2QXM1eFFQTGFpOEdPMjZHQXQxWGF1R0JyVWNwMDhRYWlPd2lNa3VQ?=
 =?utf-8?B?YmVtZ3hlWFczbXFsWVVtbGRwSWRWS2J4NlQzZjZmSW16SDQycjcvQmkyc092?=
 =?utf-8?B?NURFWGJKVmtpTEhDWU9KOUdGNDdScHlNaGdtazFNWGlRUmtwVUdFWUJNSlFH?=
 =?utf-8?B?N0N2b1lKeHVIRDZUVWw4VTh6YktIWkJpakZCTXF2dmp6NXdodXNRQmg2MWlK?=
 =?utf-8?B?KzJCeEkzckhRbTFSbS9oSytIdkE2V1UxUGNzZ3lFMFdTQS9zdm5SYjdLbmMv?=
 =?utf-8?B?NjZZZ2V2UXZxYmx4bW9vaDdyaU02VWhudUlUMmM0ZTVXMnZwbUFoWlZza0pH?=
 =?utf-8?B?OWI0dkE5ZjNEMFgvWWpmcC9OLy9oRG14dWdjSHVqK01vR0FLay9ielJpSHpD?=
 =?utf-8?B?c2NTVWJQbTBHckhLK0FtQURUYUpzNGw5b3ZuRDB3eHhoV2pyMDdWVHpzdVdV?=
 =?utf-8?B?QjlxT0Vyai9IWEJyb0h6ZmxYL0NkMzV6aVRvWkgyMysrY2tySU5sZzlQS1h0?=
 =?utf-8?B?TFN2Sk4xa1gwZ1pkQUhFQ3pzQmozbjNiMGFYdG5ibjQwZ0JjWHF5cHVWSkxJ?=
 =?utf-8?B?NTZGWGRXTW1FV3RDS2E3VmE3ck5ERjc4eHJPVjhoVjJrbmRsSVErSGhjN0hD?=
 =?utf-8?B?N0lXMXlPWjlIdEtLTWIxL2c3UldMQnIrSjFRd1FzSWdoeVVCV1daaGtYZ1NB?=
 =?utf-8?B?OU13ZjNYYjZlQzRxazIyZTBHRDhwcGo4aUlIN1N3aTVWcDUrY0JjTVpONmhU?=
 =?utf-8?B?dzNOWG9pZWdsamdDNDI0VjN3L3UrNlZGdUU1TE51UGNlNWZBcldNdERlSnRX?=
 =?utf-8?B?VSt2SXZ3dWZ2NzliY1RndTU3ZG9aVFRTSEZqMHV4Z0F1VEVEZUZSQnlCVnM5?=
 =?utf-8?B?Sk9iZUtldUtCc3cxak9VWi8vS3g1di9GYkh1c2ZMUHl3VjJPelBkS2NGZGpJ?=
 =?utf-8?B?U3NIaW45cCsvejlZUW8vRDdQVlJXMGJFWDFxYUpLRTR3M3JNeVlhTGJzeTg2?=
 =?utf-8?B?UW0xQUlZTm9JUjFoSTdwKzl2ZUN5di9rRURHTmJlZkZsOWlCekZYcUdQSkpR?=
 =?utf-8?B?dmNsQVVuRkFld3RJK2hMOXdUTGhBVWQ4VDNQT3RjNHVlSnNPcEEzQkdvU1VN?=
 =?utf-8?B?OFJ1eVJweXhKVkk1S2IwRDMyTXlrTTQ4enFsa1F4RFF3RkR5RlNpVDcrVWY2?=
 =?utf-8?Q?JOFUoGNZh6Z1xEtEGItWBs2OC4CaMzaks3ythK5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cfe283-520f-44d5-e877-08d934ef8e1f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 20:02:53.7363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AotLYhAppszo1zbCan5i2wYGoyDtV1nw2Z/JiymKE9BM83bWWUE61NHyxKupsHD758GOzbljwbXzkpfzc5Qkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5033
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
> svm_range_prefault is called right before migrations to VRAM,
> to make sure pages are resident in system memory before the migration.
> With partial migrations, this reference is used by hmm range get pages
> to avoid migrating pages that are already in the same VRAM domain.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 5 +++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 ++-
>   3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 11f7f590c6ec..b298aa8dea4d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -512,7 +512,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   		 prange->start, prange->last, best_loc);
>   
>   	/* FIXME: workaround for page locking bug with invalid pages */
> -	svm_range_prefault(prange, mm);
> +	svm_range_prefault(prange, mm, SVM_ADEV_PGMAP_OWNER(adev));
>   
>   	start = prange->start << PAGE_SHIFT;
>   	end = (prange->last + 1) << PAGE_SHIFT;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b939f353ac8c..54f47b09b14a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2646,7 +2646,8 @@ svm_range_best_prefetch_location(struct svm_range *prange)
>   /* FIXME: This is a workaround for page locking bug when some pages are
>    * invalid during migration to VRAM
>    */
> -void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
> +void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
> +			void *owner)
>   {
>   	struct hmm_range *hmm_range;
>   	int r;
> @@ -2657,7 +2658,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
>   	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
>   				       prange->start << PAGE_SHIFT,
>   				       prange->npages, &hmm_range,
> -				       false, true, NULL);
> +				       false, true, owner);
>   	if (!r) {
>   		amdgpu_hmm_range_get_pages_done(hmm_range);
>   		prange->validated_once = true;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 4297250f259d..08542fe39303 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -176,7 +176,8 @@ void schedule_deferred_list_work(struct svm_range_list *svms);
>   void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>   			 unsigned long offset, unsigned long npages);
>   void svm_range_free_dma_mappings(struct svm_range *prange);
> -void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm);
> +void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
> +			void *owner);
>   
>   #else
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

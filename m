Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51DCC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 20:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF4A61153
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 20:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF4A61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F596E40D;
	Mon, 21 Jun 2021 20:00:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD256E40D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 20:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBlljvBS6jxVVmzsZYT/RWGVz0RWs3jhnAStF3b7xdZw0JqzynSq7WNHloKbeRn9RGNHAgrRmJcpsqYWuYONeL0dP83Mw5ywJCfN5yChxBUTe56uNVtbXL+sm+NZELfQlY6yGfBkOohRBSDRcmt8t1gn4CvTRHjT+oF0Kj7IEL589NYzmGgxlxeBBfGlXD0eHALAgB+PEhSXZ1U2l3jW3afJk9+jRU7kAj70d7oyBuo40bEh7cikqUSwZzCvZifz5ZVManArV9Kz7BGjclIDknM+ax7Pd/9D5vYZ72jgAhB2dvvSLMZ0m3cegouxCF9J1fE6NlRRDoAhfzQU13b63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCzr19DgOJ3WDMCSP0psWPoUjC7HJ5aLWbvSNhtnQpw=;
 b=CyVXKr15Mj6JBGUPLToG/G9erWm9wGJWIsYyQR6HKqD7X0/IFccvnoO0RNosOmEzPfRXcJs+4sfMJJIEe9dB4M5ss49HrFSM+NFUM+aPcap6zTwhHEjnYAOu6E/MW893voEm+MsCvhp7gzsCLdTp2d26K/WGKabZEzUu+MMjnf6KzN+TF9Ou5hcu9kwhcOldnEr9BN2Dv4nu4OY7cPtvxicCs4S1d2B72psluz2VlaS3q0w1CVbWLo7QuB7OFpX13sVQ4IdWBWDz/GJLuSTLFqFMAviFikTOQVuw9w4w2pCBvRLjToRD22fKOoJt48MrIQJXWLL5JiRaKmlyP/1C4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCzr19DgOJ3WDMCSP0psWPoUjC7HJ5aLWbvSNhtnQpw=;
 b=GuwOK9fPOR0ZR71NYNnce44Mr9VhIxcyLiZ0Dfmyd7q5dp/mdWHy3jmZUEmFO0MBuu4etwvHQhIugJ9CY37kfi90Upp04lO22zMNOYO2bqhEYcEdMHuvEUP8L4b5qgaXmUy0kRQxxx/MigC7Ksq2Br+XkH+nT44wjoUAPrVMUvg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 20:00:52 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 20:00:52 +0000
Subject: Re: [PATCH 02/10] drm/amdkfd: add owner ref param to get hmm pages
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210621160423.3517-1-alex.sierra@amd.com>
 <20210621160423.3517-2-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <7a772e19-abf2-d7b2-d15c-1959d90baddb@amd.com>
Date: Mon, 21 Jun 2021 16:00:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210621160423.3517-2-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::6) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0127.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 20:00:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 140a9d26-6035-4b2d-7384-08d934ef4605
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5368949E369153453B76631C920A9@BN9PR12MB5368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pU92jMxKQkHQhyJuApNF+h/81AzUSnurO0WslnnmGYuM91InTo8uovQEw/n3Azt3N9drMJPaFRZcf73aLCPL+NG69EIQ7sGXgIY7PocFpF+dMY2mlcIJE9hetlyoKVeEtTvjiFWCo7GJ0mKl8oWDBqy/Z2ZpdPKen5H4XXN8GpyLwflOUoTRCDfLaXlnWZqwKKedAgKqpbdAjJ7YiEh9xOepgvwSIdYscOnOmp4hhMr7iZSg2zkQpZ51SJH4K+PaZoMuyarX8wlwWNzATdCbAcrSGwmuN2mCB8fxHiAfZpy37W3hfzvIOfajgJiNNj0tbvUxE0HnwGlsz4HGIN3trpsR7aSvC0lUWvtGcRxYRGGmupa0MNfZzjo1q6Rqzxl673GyoTB4FNImxbgPlDknUl25W4G4pEcGz3shi+OAy3bGKGMNku1BqaQaXojvYYk3gy/wThnvZqAR/3a0cwoB3jLCQgnk3ApxnACMxSVgYIN9MPtsFAth6A92weToVX50AONGLcrxGrqPlwBQrVfBH/YmYawb81hWSpvcZi3Q1g7/MzNF77bla1ss7k8v3kYbL0IndfoqX/DjbvY9JCzfwGwklL1LhbX9KgZjYa4UeWVsGNPpVC86zqFksJkK6z2xdIWfcsq29ZtLs5FCcTmkwGLW46NFOJhcJEMOb3/xp33DAcTh/s/gtmFEfNByvdMR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(31696002)(36756003)(44832011)(316002)(86362001)(8676002)(5660300002)(956004)(2616005)(83380400001)(66476007)(186003)(31686004)(478600001)(6486002)(16526019)(8936002)(53546011)(38100700002)(36916002)(66556008)(2906002)(66946007)(16576012)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFraEpiNGY4QmdEY1RhT1JaNUxBaTk3OHlwR2VqdDZLb0dBYy9DNXRGeTRs?=
 =?utf-8?B?b2wwRkNoWDBXRXJob293SjdqeG1CQnBNVkxxdXgyTXQvUTRIVFc0ZTJibE1E?=
 =?utf-8?B?WDF1QnVmbVFrcVN5T2Qra1paeDdGcjdFb2lnTjBkaWdoZVdKV29NM0I3dWU5?=
 =?utf-8?B?WTFpTnNQVlRmdU1QRnZGNWs2ay9ROUdJSUIyRkIvVlMybXZsenFkZ1E5L2NO?=
 =?utf-8?B?WGU5d2pXTUhYRkhUL2ZKRGhPWEI1MGQzTHRYWUpuMTZWZVFUV3pnRTNyNTMy?=
 =?utf-8?B?UUNoaCtWdWdGL0lWbUhveVNIUm5aODg3czRDalhqMFpDdGhUSGZnZXJrOUQr?=
 =?utf-8?B?NHZiekRPQXhpL1IxNmhOWHdna0VsVEVDcWxWZWdvTHdvYXRUNHgwN3VGTWcr?=
 =?utf-8?B?UFlPQXgwbVh6RDZRODlXOTJ4L1ZwMkN3ZXZ2Q3JPTHg0dk1hN3VacDU5aHYx?=
 =?utf-8?B?ajg1Y2FRSDUyMXpoam4wZWhNSWVFSmZ2MUVWTlNOM0V4OTdaT1FKdHJrL0pa?=
 =?utf-8?B?T3hYb0tIRWV1YUkzdlRMK1lPVGprR2g5ZmxFVjlHWk9vdmNmRmowanNMTEF3?=
 =?utf-8?B?Qy9xYm5VR3NhQ2VvWFQwcDF2ZVNlbzg5TXc3cjVtNlpERXlnd3hveUFwVFdx?=
 =?utf-8?B?ejdMeDM2T0lDaFpsRHVmS1oxOTlCVFQwa1NidHZPNDZHcWVOaXlNOG5tMHpm?=
 =?utf-8?B?dFJkV3Z0Y1JDZmJiSGYvbTkyYnRzcVpKU0FFaGFwYU9QVVdvdlZoMWpvM2di?=
 =?utf-8?B?UHRPUDc0endsbWI0MlBUZ2JyckxRK0YrMWQ3N1BXY01pQ3o1WFZYT1krbC9P?=
 =?utf-8?B?NU5QcGxENjV4NGdCWmd2Zy9VekVGbThRT0hVdkVpMnNUQjVYNnFLWVp2ZW9Z?=
 =?utf-8?B?K20rc3haV0Q1VUY4blQ1VWhyQkpEelNzRVVMTFFtUDFDY1Rna3ExMWpETHlp?=
 =?utf-8?B?VUFJRlpUV2d2RFREUEgxMUkyREJNcHpHVXZjUlBzb2Z2dmFYcWd6SDFLdTRp?=
 =?utf-8?B?bTVsZC9zbXpkQm54VkQwRyt3QXU1ZjZyYWVPaWpmMytiaHI1OUVUbG42elpD?=
 =?utf-8?B?eVU1YzRkQlViVlFuaUhOUTArbzdlbzRKZjg2WDRPenMyamVVYkpmQlpLSVNJ?=
 =?utf-8?B?cnBpZDBMMFRNQVpmUnFucXRkQUVLTmZvNzlxT3NrRGROanM4NCtoRHliT1NB?=
 =?utf-8?B?SWxNcERIVlJ6T2FQeVc2MU5oU1VtM1g3SWdTRjBHTHIxMTZrU2hod1BmWEtY?=
 =?utf-8?B?Ykc2c2Jtb2QzUXFDY3BBVU02VFhTbkZoMWg0ajQ2YTF4cG9BRnFGa1NTVndo?=
 =?utf-8?B?SEtmNGRzTjFEdUtnb1dLbHdqaUhMZWFEaWFSU0pVMEJISmZkOUJ4WnBUUmhV?=
 =?utf-8?B?ZUtnOWJTZEJoVFFXY1RMd2tOa0F3WjV4UUhJNmQ3OERmanVkdVorSWxadGkw?=
 =?utf-8?B?ZmtRUHB4dk94YTN4d0lDNmdDdGtmMUhRRlcyMFN0SXlJa1ZGSFZpVG9QdHpG?=
 =?utf-8?B?MDRhVDN6eExyWUVTUVFLL2hlSmJ4SzV1aWFLcEpjOVgyY1dOUys2RHVvcDVa?=
 =?utf-8?B?NFpKWmljampHWkFHVEFYOVAwZnRwSWg0YWNXL2x4TVJyeVhSK3Nlb2JPcHJJ?=
 =?utf-8?B?RWtPU2RPeGhGanNUcFpnVkh3aitHVUc5RVl6UkhyeVZoYVc2cURCL0NTeE5z?=
 =?utf-8?B?b09nTXJRM3BoYUJZZ05tK1JyWSs2L0VmYzdiRmtXRFpNZHlENVpKeitqSkpM?=
 =?utf-8?Q?K41OyQBRxmq2TJxnzidDB6oWW3rAI8Kiygkrmtc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140a9d26-6035-4b2d-7384-08d934ef4605
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 20:00:52.8207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i11IVzsppyHOAjUvDeRKePiLPxd42burrSfCR/hL3mKG1hu7pu4X6l4IfM1qcYyWwbIUXf9dhUMnMP361YZzNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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
> The parameter is used in the dev_private_owner to decide if device
> pages in the range require to be migrated back to system memory, based
> if they are or not in the same memory domain.
> In this case, this reference could come from the same memory domain
> with devices connected to the same hive.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 4 ++--
>   4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index 2741c28ff1b5..378c238c2099 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -160,7 +160,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			       struct mm_struct *mm, struct page **pages,
>   			       uint64_t start, uint64_t npages,
>   			       struct hmm_range **phmm_range, bool readonly,
> -			       bool mmap_locked)
> +			       bool mmap_locked, void *owner)
>   {
>   	struct hmm_range *hmm_range;
>   	unsigned long timeout;
> @@ -185,6 +185,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   	hmm_range->hmm_pfns = pfns;
>   	hmm_range->start = start;
>   	hmm_range->end = start + npages * PAGE_SIZE;
> +	hmm_range->dev_private_owner = owner;
>   
>   	/* Assuming 512MB takes maxmium 1 second to fault page address */
>   	timeout = max(npages >> 17, 1ULL) * HMM_RANGE_DEFAULT_TIMEOUT;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> index 7f7d37a457c3..14a3c1864085 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> @@ -34,7 +34,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			       struct mm_struct *mm, struct page **pages,
>   			       uint64_t start, uint64_t npages,
>   			       struct hmm_range **phmm_range, bool readonly,
> -			       bool mmap_locked);
> +			       bool mmap_locked, void *owner);
>   int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>   
>   #if defined(CONFIG_HMM_MIRROR)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 7e7d8330d64b..c13f7fbfc070 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -709,7 +709,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   	readonly = amdgpu_ttm_tt_is_readonly(ttm);
>   	r = amdgpu_hmm_range_get_pages(&bo->notifier, mm, pages, start,
>   				       ttm->num_pages, &gtt->range, readonly,
> -				       false);
> +				       false, NULL);
>   out_putmm:
>   	mmput(mm);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b665e9ff77e3..b939f353ac8c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1392,7 +1392,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
>   					       prange->start << PAGE_SHIFT,
>   					       prange->npages, &hmm_range,
> -					       false, true);
> +					       false, true, NULL);
>   		if (r) {
>   			pr_debug("failed %d to get svm range pages\n", r);
>   			goto unreserve_out;
> @@ -2657,7 +2657,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
>   	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
>   				       prange->start << PAGE_SHIFT,
>   				       prange->npages, &hmm_range,
> -				       false, true);
> +				       false, true, NULL);
>   	if (!r) {
>   		amdgpu_hmm_range_get_pages_done(hmm_range);
>   		prange->validated_once = true;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

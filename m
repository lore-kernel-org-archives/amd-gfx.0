Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021A7ECAAD3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 20:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4228010EE1B;
	Fri,  9 Sep 2022 20:01:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0583E10EE1B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 20:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mECDF9AEakISXaBfYNKv6fxyy0+i1Rf1pTnCeUcNhX6chCUeMuar+eJw96aO33lnUN4QyvpSL8Gw4K2AkGNtiHNdvXyX9sA+JhiRX/hzJKZu8Dbphvztc29F2LOwCFItIsD6rDgIh9SK+qXwkMP9uVWzBX227i00FBuZNv0+aw5jhc62KzZxsRpY84hQMLQkVDC/xIwvMRvLhtDIDl+smfjaado/bP9d+9padKE2XqZMybRjZGc5/prW4K48lDzGnUoQ/1NpNGhEgXy+KjjnasFNdB2/uBtmz3SSc1IdJaaAWVBikjMQ6VbwcpUJ6NuNP0sKju9aRRXKKTixWBwmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsapISaQeDWeqhz/zdFZFoMd9rUQqqd+nrWM7Mrm3hE=;
 b=HatUZh7+AkW08PZx3JubIyNau0ExZwWk3N7uvkyarHDP70cT1n2GOi5I3PQqcrExOx+ZKc4X/2nrKOsz4WpIyWIz1d1nkcLQf7nVMOAcYV4PAXbyFN2+Psw4DUKpAUhc70HGpgfmxAVr5lJIOfYHx2hqHDte2a9Z1oHTADBrAcQ7o7J8l8as5SijjxFXI4OdW0o0f/HCBgZzcSo07kB96rp3bk6YPSYgN37Cpcahb529qgj0NGycD/vWG/vvK82JcYZTm4SQCoPiKStJOnS1kMl8os6LXHRTRnbwJRIaFIUGK+5yDzSJTnoW3awpIR/GmwofScUqmn6fnFlkQaU8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsapISaQeDWeqhz/zdFZFoMd9rUQqqd+nrWM7Mrm3hE=;
 b=U2i230NalMiU09B9pCvTMRPEIC/x2EyDDukDGRBOV0cps/JPt97YwiUkSgkWv05ntb871HgqnrRstA2P19cudX33fVhxdXJnJhPW1Ych6dA2HG5nbv5bMzY5EucFrsBVue8vsPYu0YVkpBIfKTRZ/RZwi07ysityFAOM0RG0V1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.20; Fri, 9 Sep 2022 20:01:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5612.021; Fri, 9 Sep 2022
 20:01:09 +0000
Message-ID: <45eb080f-eb84-7b54-73ad-dce8de0727d0@amd.com>
Date: Fri, 9 Sep 2022 16:01:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220909182502.13995-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220909182502.13995-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: bc106191-0def-4303-904f-08da929e09f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLnDybLyjzN1tlc86JhhH5i8aq7MU6KMa6bVEeuwkOwPt0osyvQ8EqsnqXCKwT1fEaq/3LSGp4znaf2GnxTDcLHi07/vuH6xpITSqU8yMVgA5zs5nmbwRxjlju9TUAOV5dKHYWOG5MHvdtINEifNLTlU2k5rfF84pA0ACNATxVZyKA5w4Vb/zZ0xgyTExSecsRplZj02l/nxcok1C9AKtOLGSjftYttPAxIxa8BnzJcWL7dmrKU2R6RV4Xav3wIji7rY4Xo6ZcW1NUGsFxzpjbgaYQtZ0yiblpzfBeCIN/hipVeQiLNUG1C/tz3mKAImHuI6RVyRAscdJWT2slzjKBAJRlKlXrT7juospiNxrFJzcc5qLmGZ3eQmIBpSGucf9gUAD78r3jjIVA0qurOoixVndE4288Kej5CAFsADMRLFCWzr9e061E1IcVrF9fOAReyB31lSdhDVhOC92HvVDcHViUUiJ6n2E7MCqxlmKig+GBmqGjm1dRy6N0IWG1mrm9YHp/XbvEvYfjg/xdNt7D5qvF08tgXGHM7/Q5SW+T9mcc72+CKigcgJ2vfsrZzg55xHaupwx3SOvWmS0ipPv8HHqqXGlaQEZEwUqSF3Z+PBiPVo/n2NL4AB7nvCuayO9zjzD+kMajC6ZMamHMLQ9/7SILtx27IVxmVQpHnspDfMLoyjHaeEq2CtonDxVULrHQfLjgQ4eD/+e3rn0NPlSbrySJQquSRj4HMW5wLi8xwWxRunX21mNetn423bSzPXSNeQg10lFQejlx23KmeqC1CXZN6ZvqlQDwY1fDs8arQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(31696002)(5660300002)(66556008)(66476007)(38100700002)(31686004)(86362001)(83380400001)(2616005)(26005)(6506007)(186003)(6486002)(6512007)(41300700001)(478600001)(8936002)(4326008)(36756003)(66946007)(316002)(44832011)(8676002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUN1d3FTaXhlQ0xPeFVONGZSU0h1RkdmcXlwZzNzVXNFY3JNd2p4U1loS1FX?=
 =?utf-8?B?UWxsNjNkNEJodzJYY1JFdGZrZ045TGNCWHpkcXBSd0F0d3B0QnBudjhGdUNw?=
 =?utf-8?B?a3ZoVk4yYUR4NDhKejdjVTVVT2k2SWpTOFBmeG1SS1hCcGE0QmJZQnU0VWJV?=
 =?utf-8?B?MVdOOTl6WmVrVS9iRnhFcEY0VHI1YnhvcnlJV25Yb3BJUGVwTnVra25lN2o5?=
 =?utf-8?B?aWpHMGt6MkQyVUcxZ2FGaU9TcHRseUE5Q2RQRExYTFMzS2xScmJYQTk3UkdQ?=
 =?utf-8?B?U3p3c0FGdDlwVHZZaDBpRnJnLytSczRLZjZkKzY2c2RHK3F0K3JBVEVIVjNC?=
 =?utf-8?B?NG9HeWZuSk5yRWJHLzl4U3RmTEV0S0pMaFk1QUpFY3lBVnZWZXRiMDhnQXFW?=
 =?utf-8?B?dHY1VEYzT0xKUVp6MDhreDhCOTU5YWo5VkZjS0xkZXpaN05IK0llTkNRU0F3?=
 =?utf-8?B?dUo2UXFLVTQ1bkZDS1FFRGE4NkZhbFJvRUlrWnpBSVhYYzVGMlJqZitUek9L?=
 =?utf-8?B?QXZtcG1CVElJV3dDOGtvMDJRbC9WR2VIRzhnRDlUdW4rN1NMMEk0ZGZSaVZG?=
 =?utf-8?B?S0NXNFZCMThKSHhqOVZvMEdXdzllZldtQldZelAvU2hWQXNCZDlVa3o3UFNm?=
 =?utf-8?B?aVA4dDhmbXRRdTFuOUl3cldxRThDTldjWGJFTThwR1RxZ3FZbkdWcUp3QkI1?=
 =?utf-8?B?aENOYnVIdm8xeHo3NktMaTB4TWs5eDFNeENTYjYwS3pkaGxmbjVvaTN0cStr?=
 =?utf-8?B?VWYvTHlnQ2t3RmxMaFFmblhjWHY2bWFCOGEva29sV0VYMWpyRHpMSENVTnNG?=
 =?utf-8?B?Ym5sakJmZzV6ZjhuTXF0OVluWFIzRUJyWWtXL082NlEwN3VYbTB2a2ZLTHVn?=
 =?utf-8?B?T1czc2orSVh0Y0svSkZoUWNuNThNdU8rWFZEWU1DQnlMcHkwSUdQQnVydFBi?=
 =?utf-8?B?bHkrMzFuRXNEOFpadkticER1eU1rUm5sVVJKeGxqakhCQnlBbnZGZE1ST1Vu?=
 =?utf-8?B?NFVXZFBVR3ZIcjVKRndVSVF0YzdhSXpYT1VtMmV6WDRCMjAzRXVEZ1ZhS0tZ?=
 =?utf-8?B?M2MvKzhHSHJVNHJoZmlIVklJbUZ6UXFxbWJrSEJjQ3B4bWxIZFRUOUw2VCt2?=
 =?utf-8?B?QzRVZTljRStYaHIrRU13bmhnNUlrY3JFbitNc0dBN0pkUklpK1B2bjRrQ3li?=
 =?utf-8?B?bXlGRjZIYS9Gck9vZDZnYXp3YXdQbTgzdUFRN2d2WGcrUkRxWDVUeU1MaUVx?=
 =?utf-8?B?LzdTNUxpU2FPMGU0cFBaa04yY0JsWjlDbDR0djNCR09hakRDMUh6SGk1ZDJ1?=
 =?utf-8?B?OHdIYzNDeWhsUTRVYUZieU1FVGlvdlpIQmI2QzJha3ZXbnViaWtlMVV1QUNm?=
 =?utf-8?B?VEFiSDhrRVByOFRLWTZMM0ZQbTJtV1VJeHdnV0lzM2RIMHVldmZvaTFmVGdS?=
 =?utf-8?B?MnBVbmk3MVh1Qnp2ZUFNNWxHc2FQZ1pRU2RDV2FYZitnU3NadGhPTnhsclA2?=
 =?utf-8?B?ZWE1SENsM25nVmUxOVNicFdKZysrU3pQK2VXalkxU3FEOEtzZ2k1cm8rK3V3?=
 =?utf-8?B?cERablZUbDFOeXU2OVNFc0IyRmJvKzFMc3RNVWF2ZVZ0MExnVmxiNC9mRXcx?=
 =?utf-8?B?Uy9KSnNxcG1oc3N5UnFEa3pPTkMrZnMvd2hJT1EwZE9sWlp2S21XQXRKUEtz?=
 =?utf-8?B?eDFxWEg1OTkxZkcranZVdjJpMDB4NlArbFFQUmc2eVR6dGdXVWQvTjN4MHJZ?=
 =?utf-8?B?WFdkblh6QmgvM0V3ZEVjZFFxSWdtaXcvNUlSMWhvc2U3elZlTHh4SGQ5dkhX?=
 =?utf-8?B?ZDB3L1BpcmRsdDVDZXZZYTRTcHlBcHR3NnlQcVlVaTFIWFdrc1F4aHBVelE5?=
 =?utf-8?B?M1lwVGRwQTRKK3FVc09uUnR1VG85eThiZ3BlQVN4bnhhWTN0ZzdqdXFlRm9O?=
 =?utf-8?B?Z1dDd29rOFBEUlZuSzIyY3NzQmREajFGVThkdDVNdkxCajF5WWp2S0MxTjFa?=
 =?utf-8?B?emZ5d1NQSmNaVnhtdXNKV3RvcFFDMW5zb2dPWTh3Q0piSXRrVEFsR1d3Sks1?=
 =?utf-8?B?S3RhTEFEd0dKQjVjV3pTQ2d5UnQ2OVZLWkhZRzNQWkkySzNjcXdMaXptN1F3?=
 =?utf-8?Q?53InC6GLCwkSd7HtT/CaS0Spr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc106191-0def-4303-904f-08da929e09f3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 20:01:09.7678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYibt0RG4o7EWPAyaZYJVMeC7VvHDov21AWPsOS3JM3fU3b+8H3h4rUktWsaGDEJdzFbHhLMgHbzugt0Fz7C1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-09 um 14:25 schrieb Philip Yang:
> Free page table BO from vm resv unlocked context generate below
> warnings.
>
> Add a free_work in vm_bo base of each page table BO, pass vm resv
> unlock status from page table update caller, and schedule the
> work if calling with vm resv unlocked.
>
>   WARNING: CPU: 12 PID: 3238 at
>   drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
>   Call Trace:
>    amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>    amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>    amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>    amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>    svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>    svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>    unmap_vmas+0x9d/0x140
>    unmap_region+0xa8/0x110
>
>   WARNING: CPU: 0 PID: 1475 at
>   drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
>   Call Trace:
>    dma_resv_iter_first+0x43/0xa0
>    amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
>    amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
>    amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
>    svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
>    svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
>    __mmu_notifier_invalidate_range_start+0x1d3/0x230
>    unmap_vmas+0x140/0x150
>    unmap_region+0xa8/0x110
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 40 +++++++++++++++++++----
>   2 files changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9ecb7f663e19..ac7cd2c738e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -150,6 +150,9 @@ struct amdgpu_vm_bo_base {
>   
>   	/* protected by the BO being reserved */
>   	bool				moved;
> +
> +	/* work to free pt bo if vm resv is not hold */
> +	struct work_struct              free_work;
>   };
>   
>   /* provided by hw blocks that can write ptes, e.g., sdma */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 88de9f0d4728..e6f6d7e6368f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -37,6 +37,8 @@ struct amdgpu_vm_pt_cursor {
>   	unsigned int level;
>   };
>   
> +static void amdgpu_vm_pt_free_work(struct work_struct *work);
> +
>   /**
>    * amdgpu_vm_pt_level_shift - return the addr shift for each level
>    *
> @@ -607,6 +609,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>   	pt_bo = &pt->bo;
>   	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
>   	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
> +	INIT_WORK(&entry->free_work, amdgpu_vm_pt_free_work);
>   	r = amdgpu_vm_pt_clear(adev, vm, pt, immediate);
>   	if (r)
>   		goto error_free_pt;
> @@ -624,23 +627,46 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>    *
>    * @entry: PDE to free
>    */
> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
> +static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry, bool unlocked)
>   {
>   	struct amdgpu_bo *shadow;
>   
>   	if (!entry->bo)
>   		return;
> +
> +	if (unlocked) {
> +		schedule_work(&entry->free_work);
> +		return;
> +	}
> +
>   	shadow = amdgpu_bo_shadowed(entry->bo);
>   	if (shadow) {
>   		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>   		amdgpu_bo_unref(&shadow);
>   	}
>   	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
> +
>   	entry->bo->vm_bo = NULL;
>   	list_del(&entry->vm_status);
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> +static void amdgpu_vm_pt_free_work(struct work_struct *work)
> +{
> +	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_bo *root;
> +
> +	entry = container_of(work, struct amdgpu_vm_bo_base, delayed_work);
> +
> +	root = amdgpu_bo_ref(entry->vm->root.bo);
> +	amdgpu_bo_reserve(root, true);
> +
> +	amdgpu_vm_pt_free(entry, true);

Doesn't this just cause the work to be scheduled again, rather than 
actually freeing the BO?

Regards,
   Felix


> +
> +	amdgpu_bo_unreserve(root);
> +	amdgpu_bo_unref(&root);
> +}
> +
>   /**
>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>    *
> @@ -652,16 +678,17 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>    */
>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>   				  struct amdgpu_vm *vm,
> -				  struct amdgpu_vm_pt_cursor *start)
> +				  struct amdgpu_vm_pt_cursor *start,
> +				  bool unlocked)
>   {
>   	struct amdgpu_vm_pt_cursor cursor;
>   	struct amdgpu_vm_bo_base *entry;
>   
>   	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> -		amdgpu_vm_pt_free(entry);
> +		amdgpu_vm_pt_free(entry, unlocked);
>   
>   	if (start)
> -		amdgpu_vm_pt_free(start->entry);
> +		amdgpu_vm_pt_free(start->entry, unlocked);
>   }
>   
>   /**
> @@ -673,7 +700,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>    */
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	amdgpu_vm_pt_free_dfs(adev, vm, NULL);
> +	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>   }
>   
>   /**
> @@ -966,7 +993,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   				if (cursor.entry->bo) {
>   					params->table_freed = true;
>   					amdgpu_vm_pt_free_dfs(adev, params->vm,
> -							      &cursor);
> +							      &cursor,
> +							      params->unlocked);
>   				}
>   				amdgpu_vm_pt_next(adev, &cursor);
>   			}

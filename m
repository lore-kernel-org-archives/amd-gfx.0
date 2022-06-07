Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B826C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 16:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FB1610E1F3;
	Tue,  7 Jun 2022 16:10:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A47410E1F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 16:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOS1/RVxQgU2smPaUMQEyQdiwrlaoPxsRhb1QcK+PcAkZ22NSXNiNKy5nLZySv3ZkuaOmW0bUAdT4oY87iVCM4Z94vEL37C2D2yDMQqFjxRUHyKW3385ev4ydZuqXhqOqXP6A9NtJVlVJzxp8g6kxM+33p1Spw4XXYTLphR+tTIeRXmxTKJ+K+rgMMINdv12sXNkeA5of8qmbHLcdYB0vgoQPkfxAZ9bWnl+3v2fconUu0N7/TDCnTK+oaAt0FEcICAxGCpotA/BBA8iJYLplcoHXtnrG45i7Vj5OhFtqpssl1+UimdUEgFpwSKcIpSRnmiumt3P4aHXbUj8cL9O2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lul+ep3LhBtSb7lfMENHtpHNKyYZP4AI3MGIZJZnz7c=;
 b=YpgTd0MnB/ApCvLsMrtOs0bDpG6eh73nfUx90bDDAbsohco0Y714j/ioG4EcXBt/6xJx1Ctaigqm8iKYTeL6vYyyctBpUgsHvF8y8HZu/SgTp96D62PclNKX/BjEkHy0yvTLluigj6K7Hi4up098LXw70FYHWxLGn4hQQkduSTRVyNeJDW4Chi4GVjqmUCwnBDfoy7LY5WFBg3shKqSVC8G1CSdC3oVKa4zEEJ2rRg8Iv+3r32I6p6Km11PLnjXvhRJWyoZXxhvBlbdedZ3NuUg/fEOdorqMRYWTT1bt79Bc/TUQgYY6JOST/gDYbeOCLuApZHuMYMVdXpjR1d792w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lul+ep3LhBtSb7lfMENHtpHNKyYZP4AI3MGIZJZnz7c=;
 b=JALs3vypEOrvRrg9y5B4y71SbcMueslC1Z2aPeI+9bUHjIBuYB9MwLCRMHZ8cILNqB6WOmyVCmvcsAp9WhAyIZeQYHRzlCAQpq0YFbgG063TMxLG/rozim33R9TyT6g0kGacxmFdX/9huUNrQNv30q0NplwzR9tvDLtjbzaFhxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN8PR12MB3027.namprd12.prod.outlook.com (2603:10b6:408:64::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 16:10:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 16:10:17 +0000
Message-ID: <286b82e4-9d0c-3454-0e53-afc023f3c87d@amd.com>
Date: Tue, 7 Jun 2022 12:10:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] drm/amdgpu: Add peer-to-peer support among PCIe
 connected AMD GPUs
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220607082307.1982598-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220607082307.1982598-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14039137-74b5-46e7-0030-08da48a03678
X-MS-TrafficTypeDiagnostic: BN8PR12MB3027:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB30274E4C5289C3F31A1B767192A59@BN8PR12MB3027.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TiRY7A6qYlPSxvu3fy3dPcq/cK+oWj7/Olocjxo/k+YAYZkoUSx9KNO1+/mX87MX+AxovPKSHjdq1cE2yYrKMbC3RNSCh/ksZFC0HaD25GfOqPk2m5/5vunAfGkRbr2iSFE/waD1BxNk/X3M0kUioOiVS4IfYaKMwqNy9Q8cFeof6EVTQ8eIcEeSl2gc20Ju4OIcGVU8k7AFI8PIbLHmwCwGyxULSnF7tTxHaEQwxKu3WoMqeUCq0peDq43kh2QqYpmWS+cggn4YlRFjoB8epXoFqCUhjxE3rqWeWZhyl1wTXxLGDXsVGucbR8S+0waQlsaHVH4RA0RaT854BJpJSEmAp4kr9NtFxpV2PdXxz/Rzs9RvyhR8WLOJaXVScg2WgSo7xpCCcXwLqLwZ/nlMCUj0TO+0pyDjM52stUIGeGkBN2ybeq+3hZRqnymDe9mFKnfyNylENwAZfOjrbrxbLizD/DAxSSDEqR8AhofrGD+wK7nO6YBIf/VEMXTx81ZXP5oEWVYFt5jyZvCKtkRjhn3m3hy7+3QyiJIrOM9YnZLQqbQA3lgXea4jjFiEf1vuAj0s06uThWEeIHTTykqTY64/OH28KJxh7ZERgsLlcIQwtHCQx4q7s68eaLZov1/gYnIR/eJGyqMpSOAribC+GvwN82OeMqGqvUqvVOB2stUc46Tpt+g8uUaR/JrRRFwlYseduvPo2hyWUkD32L73QCubXxbO+0Knn5cbmg7JcJNIgQe6cnYMEonSwvmHgkzB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(30864003)(186003)(44832011)(5660300002)(6486002)(8676002)(2906002)(66946007)(66476007)(66556008)(316002)(2616005)(508600001)(26005)(38100700002)(31686004)(31696002)(6512007)(86362001)(36756003)(83380400001)(6506007)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndUZzdUczBKUm1kakM3bHNucGhjYmNxR3J5cmFXT2UvVjk2bmJsT0xINmVM?=
 =?utf-8?B?WjdmenBTTzlCd2VaTGFZd1k4TnYyT2JlQ3pLMEZLd1Zsa1pjSk4xV2ZqSG54?=
 =?utf-8?B?WjFrSytYR1NFR2FSRDltbWsxakVIczVsblpkV2lTTDVhVTd3bE5qeXVZWFdD?=
 =?utf-8?B?SzdUR1lHK2ViVjdmdVFtd2ZDb012QjZGQjhpTlE3cVF6MXV4ZjlBMUlUMDkv?=
 =?utf-8?B?elozbFcrTkhEVWtZcW5qZ3BDaXRwa2tMb2ZiZmU0TWtpcldCTkMrWnNEaXpp?=
 =?utf-8?B?cXpKeVIrL1J2ZHkvZmYrYTIwVjczZkpMRDdtUHE4YVBJY0RDeE5KMjRmK3Rp?=
 =?utf-8?B?WHJjSXpFeUtvMkJidDFZcEp5Mkh5SUhjdXZrVGlVRHl1N3FWL0hJdk5DSXZ0?=
 =?utf-8?B?aGNQMSt5djdLamR1bzZ4dUtEY1U3VzJBWm8wanM3Nk9NTDBKTVp1bTVKTHc0?=
 =?utf-8?B?M09oTHAveSs0WlFMbUlsR3FpQW4xUWd3RGRKdFVta1RTMWI0Nk1CbzRGNFBt?=
 =?utf-8?B?YUdXbmVuSGxmMU9qV3d0Wm80MWNYaEZBcmRFeVRKdTlGN1hHUEowYk8xaE11?=
 =?utf-8?B?SElRSzZ0b3dpMTVFOEtsZVI4MjJONHZVc2ZhUTZiNVAycjRwTkNYZkFXTHU0?=
 =?utf-8?B?LzZlVnhEc2NFcUIyWmxVS2pqWFNPaG43VnBJbEhXVHZyQWVlYkhPUncvS0JS?=
 =?utf-8?B?S2RyUVZqU0oyVFFxZ1hIZVVuVnpSc2p1K000Q3E1bUEyQ1JuYzdwaHFtRllj?=
 =?utf-8?B?aXZPV0EvemZIK21mNVVKdGhTL1NvN0hURFJtZ1RHT1dCVFpOVXN1YWlzTmVo?=
 =?utf-8?B?VFFRb3U0Q2l6LzJUN0U1bzhLSHh2bURBamVObm9WRGozMVpjM21zN241YnlW?=
 =?utf-8?B?R3Y3WktDOXdPUEhIcThWbVlNa2x4ZXNabFBwbi9xYmczd0ZpZlJrT0NBZU52?=
 =?utf-8?B?OEU3ek5QeGtMNmoxRjRzUGk1cXZwN3lRakt6NkJVcHVab3FOWm1SKy9qaVFC?=
 =?utf-8?B?RWZ4bzNkV2orZXJsdmlaSk5USEVoY3c5alY2NDloUnV3TGhLS2U2MWFyY0JE?=
 =?utf-8?B?c2prL05IVU9zeWZQaGcrOGxhcUFRVU00bnNERzN1c1gvRThUMXdSM1Q5VW5r?=
 =?utf-8?B?WVdaOE5PZ2krTkd6ZEN0b2FEdmVVYThQMGljb0FQQjFNVTQzcUUxQU1ESHdB?=
 =?utf-8?B?UFBvWGFuSG5nWnU5UHBMNUMvdjc3Ri9zUXFiS2FJMXBQTkgxMXhuNnQ0RTgz?=
 =?utf-8?B?VExrUVNEVkxvYzBybWE2RjdiMzJLU2xvRzdLcHNEZ0F1QWNwUEdKZURBOTZo?=
 =?utf-8?B?dWVLSlViVXlySlExSThkNUpEMFNYZGFsTk9QV1lQaFQyWEtUc0FtazJUdWRF?=
 =?utf-8?B?cVloMzNSSitkSjZ0b1I4MWlkbVEyanZvRHN6NnBKOG1rZW5Uem5jbFZneHZm?=
 =?utf-8?B?TzlZc2t0SHlLcDQ1L2lPdzZreVBFMEZmS3FvQWFiVTBoOEk2am1LU0hEdml0?=
 =?utf-8?B?WjVsZ3RVWHhxUFdUN2xJY1ZTc09jd1hkQzMzMStGelB6VzJGZERJenlreFI3?=
 =?utf-8?B?TDFiaytQREFsUzFRUDlJTzFEc1lwMVR3MTFERGRaZlo5a3BEYWxzaXFidjls?=
 =?utf-8?B?RDFJQVZmWjVmNEcxWXFDTjFFQlNNc3U5Mnk5T05mWFBhcjJDa2tISTJ0d096?=
 =?utf-8?B?bzBqSUNEOEc4eTdWVThmQWl4SlF1aXJ0eWxQMHpUWXBNZEppRFhncVZHdzly?=
 =?utf-8?B?Uk1VNDJDdDZ0RW4waDJpM3ZVTjlHOHlPMFZkTTVxS3VjT1VvQXJSL3g1TGMr?=
 =?utf-8?B?OUxUVEtlMnF1VEJGU1QxNDA0dTJEMEluQ240OXF1Zkk4SGVJZjZsMTNId2ZJ?=
 =?utf-8?B?eXBVajNsRDFpcTMyQ1AxUjltVmNidUtyTzZ5RzdCNnBjS0ZIMlJCT3VOTGhJ?=
 =?utf-8?B?Y1N5MUxldlUwL2lYd0swWEJha045Z2RyakdNeDJ2QkEyeVlwYU5qbjVRM3hU?=
 =?utf-8?B?TEVzTDNKWGFCblpoRzNWa29oWHV0NTVTVXl5Vnd0b1hBYlM1N21EdnJsNmVx?=
 =?utf-8?B?dE05TjMxVnBJSU4xTTFFcnFWaTNoc08vdnpKU2hUenhwSUpHbVpiYnFqM0pj?=
 =?utf-8?B?cnU0ZU5xL3NuUXE5OEdPQzdsTmtidjdHcWlTRWtSSzFGeHU0cFdRcVQrTktF?=
 =?utf-8?B?L2ZsUm5SMXc5OC9hK1U1U2YxaXpXM0xtWGd6YUZKODZOQWIvRDNSTndERUZF?=
 =?utf-8?B?UDVYejFSK2tTaXdYSmlpYmFUeFZ4dW5yMDR5U05kRFZHL0lwRTBKeFB6M1or?=
 =?utf-8?B?UVVUV0lXNmlDdktYOXBnR3ZOR1h5V244akEyWjNVMlloK3BJKytyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14039137-74b5-46e7-0030-08da48a03678
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 16:10:17.3397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9PnMBzBwQPzVnPOq6MHseR6txwe1U4ayYXL+1Zn6iisOvlVNNTqdEeuD0n0Wa6niaccQg7o8rTu5b2XkU/YCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3027
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


Am 2022-06-07 um 04:23 schrieb Ramesh Errabolu:
> Add support for peer-to-peer communication among AMD GPUs over PCIe
> bus. Support REQUIRES enablement of config HSA_AMD_P2P.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 300 ++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  31 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 +
>   5 files changed, 283 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 70a2a0ffc007..d3b2245972b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -223,6 +223,9 @@ static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
>   static const bool __maybe_unused debug_evictions; /* = false */
>   static const bool __maybe_unused no_system_mem_limit;
>   #endif
> +#ifdef CONFIG_HSA_AMD_P2P
> +extern bool pcie_p2p;
> +#endif
>   
>   extern int amdgpu_tmz;
>   extern int amdgpu_reset_method;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f8b9f27adcf5..5c00ea1df21c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -48,6 +48,7 @@ enum kfd_mem_attachment_type {
>   	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
>   	KFD_MEM_ATT_USERPTR,	/* SG bo to DMA map pages from a userptr bo */
>   	KFD_MEM_ATT_DMABUF,	/* DMAbuf to DMA map TTM BOs */
> +	KFD_MEM_ATT_SG		/* Tag to DMA map SG BOs */
>   };
>   
>   struct kfd_mem_attachment {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 054e4a76ae2e..ce012a148ed7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -241,6 +241,42 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   	kfree(bo->kfd_bo);
>   }
>   
> +/**
> + * @create_dmamap_sg_bo: Creates a amdgpu_bo object to reflect information
> + * about USERPTR or DOOREBELL or MMIO BO.
> + * @adev: Device for which dmamap BO is being created
> + * @mem: BO of peer device that is being DMA mapped. Provides parameters
> + *	 in building the dmamap BO
> + * @bo_out: Output parameter updated with handle of dmamap BO
> + */
> +static int
> +create_dmamap_sg_bo(struct amdgpu_device *adev,
> +		 struct kgd_mem *mem, struct amdgpu_bo **bo_out)
> +{
> +	struct drm_gem_object *gem_obj;
> +	int ret, align;
> +
> +	ret = amdgpu_bo_reserve(mem->bo, false);
> +	if (ret)
> +		return ret;
> +
> +	align = 1;
> +	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, align,
> +			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE,
> +			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj);
> +
> +	amdgpu_bo_unreserve(mem->bo);
> +
> +	if (ret) {
> +		pr_err("Error in creating DMA mappable SG BO on domain: %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	*bo_out = gem_to_amdgpu_bo(gem_obj);
> +	(*bo_out)->parent = amdgpu_bo_ref(mem->bo);
> +	return ret;
> +}
> +
>   /* amdgpu_amdkfd_remove_eviction_fence - Removes eviction fence from BO's
>    *  reservation object.
>    *
> @@ -481,6 +517,38 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
>   	return pte_flags;
>   }
>   
> +/**
> + * create_sg_table() - Create an sg_table for a contiguous DMA addr range
> + * @addr: The starting address to point to
> + * @size: Size of memory area in bytes being pointed to
> + *
> + * Allocates an instance of sg_table and initializes it to point to memory
> + * area specified by input parameters. The address used to build is assumed
> + * to be DMA mapped, if needed.
> + *
> + * DOORBELL or MMIO BOs use only one scatterlist node in their sg_table
> + * because they are physically contiguous.
> + *
> + * Return: Initialized instance of SG Table or NULL
> + */
> +static struct sg_table *create_sg_table(uint64_t addr, uint32_t size)
> +{
> +	struct sg_table *sg = kmalloc(sizeof(*sg), GFP_KERNEL);
> +
> +	if (!sg)
> +		return NULL;
> +	if (sg_alloc_table(sg, 1, GFP_KERNEL)) {
> +		kfree(sg);
> +		return NULL;
> +	}
> +	sg_dma_address(sg->sgl) = addr;
> +	sg->sgl->length = size;
> +#ifdef CONFIG_NEED_SG_DMA_LENGTH
> +	sg->sgl->dma_length = size;
> +#endif
> +	return sg;
> +}
> +
>   static int
>   kfd_mem_dmamap_userptr(struct kgd_mem *mem,
>   		       struct kfd_mem_attachment *attachment)
> @@ -545,6 +613,87 @@ kfd_mem_dmamap_dmabuf(struct kfd_mem_attachment *attachment)
>   	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   }
>   
> +/**
> + * kfd_mem_dmamap_sg_bo() - Create DMA mapped sg_table to access DOORBELL or MMIO BO
> + * @mem: SG BO of the DOORBELL or MMIO resource on the owning device
> + * @attachment: Virtual address attachment of the BO on accessing device
> + *
> + * An access request from the device that owns DOORBELL does not require DMA mapping.
> + * This is because the request doesn't go through PCIe root complex i.e. it instead
> + * loops back. The need to DMA map arises only when accessing peer device's DOORBELL
> + *
> + * In contrast, all access requests for MMIO need to be DMA mapped without regard to
> + * device ownership. This is because access requests for MMIO go through PCIe root
> + * complex.
> + *
> + * This is accomplished in two steps:
> + *   - Obtain DMA mapped address of DOORBELL or MMIO memory that could be used
> + *         in updating requesting device's page table
> + *   - Signal TTM to mark memory pointed to by requesting device's BO as GPU
> + *         accessible. This allows an update of requesting device's page table
> + *         with entries associated with DOOREBELL or MMIO memory
> + *
> + * This method is invoked in the following contexts:
> + *   - Mapping of DOORBELL or MMIO BO of same or peer device
> + *   - Validating an evicted DOOREBELL or MMIO BO on device seeking access
> + *
> + * Return: ZERO if successful, NON-ZERO otherwise
> + */
> +static int
> +kfd_mem_dmamap_sg_bo(struct kgd_mem *mem,
> +		     struct kfd_mem_attachment *attachment)
> +{
> +	struct ttm_operation_ctx ctx = {.interruptible = true};
> +	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
> +	struct amdgpu_device *adev = attachment->adev;
> +	struct ttm_tt *ttm = bo->tbo.ttm;
> +	enum dma_data_direction dir;
> +	dma_addr_t dma_addr;
> +	bool mmio;
> +	int ret;
> +
> +	/* Expect SG Table of dmapmap BO to be NULL */
> +	mmio = (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP);
> +	if (unlikely(ttm->sg)) {
> +		pr_err("SG Table of %d BO for peer device is UNEXPECTEDLY NON-NULL", mmio);
> +		return -EINVAL;
> +	}
> +
> +	dir = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
> +			DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
> +	dma_addr = mem->bo->tbo.sg->sgl->dma_address;
> +	pr_debug("%d BO size: %d\n", mmio, mem->bo->tbo.sg->sgl->length);
> +	pr_debug("%d BO address before DMA mapping: %llx\n", mmio, dma_addr);
> +	dma_addr = dma_map_resource(adev->dev, dma_addr,
> +			mem->bo->tbo.sg->sgl->length, dir, DMA_ATTR_SKIP_CPU_SYNC);
> +	ret = dma_mapping_error(adev->dev, dma_addr);
> +	if (unlikely(ret))
> +		return ret;
> +	pr_debug("%d BO address after DMA mapping: %llx\n", mmio, dma_addr);
> +
> +	ttm->sg = create_sg_table(dma_addr, mem->bo->tbo.sg->sgl->length);
> +	if (unlikely(!ttm->sg)) {
> +		ret = -ENOMEM;
> +		goto unmap_sg;
> +	}
> +
> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +	if (unlikely(ret))
> +		goto free_sg;
> +
> +	return ret;
> +
> +free_sg:
> +	sg_free_table(ttm->sg);
> +	kfree(ttm->sg);
> +	ttm->sg = NULL;
> +unmap_sg:
> +	dma_unmap_resource(adev->dev, dma_addr, mem->bo->tbo.sg->sgl->length,
> +			   dir, DMA_ATTR_SKIP_CPU_SYNC);
> +	return ret;
> +}
> +
>   static int
>   kfd_mem_dmamap_attachment(struct kgd_mem *mem,
>   			  struct kfd_mem_attachment *attachment)
> @@ -556,6 +705,8 @@ kfd_mem_dmamap_attachment(struct kgd_mem *mem,
>   		return kfd_mem_dmamap_userptr(mem, attachment);
>   	case KFD_MEM_ATT_DMABUF:
>   		return kfd_mem_dmamap_dmabuf(attachment);
> +	case KFD_MEM_ATT_SG:
> +		return kfd_mem_dmamap_sg_bo(mem, attachment);
>   	default:
>   		WARN_ON_ONCE(1);
>   	}
> @@ -596,6 +747,50 @@ kfd_mem_dmaunmap_dmabuf(struct kfd_mem_attachment *attachment)
>   	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   }
>   
> +/**
> + * kfd_mem_dmaunmap_sg_bo() - Free DMA mapped sg_table of DOORBELL or MMIO BO
> + * @mem: SG BO of the DOORBELL or MMIO resource on the owning device
> + * @attachment: Virtual address attachment of the BO on accessing device
> + *
> + * The method performs following steps:
> + *   - Signal TTM to mark memory pointed to by BO as GPU inaccessible
> + *   - Free SG Table that is used to encapsulate DMA mapped memory of
> + *          peer device's DOORBELL or MMIO memory
> + *
> + * This method is invoked in the following contexts:
> + *     UNMapping of DOORBELL or MMIO BO on a device having access to its memory
> + *     Eviction of DOOREBELL or MMIO BO on device having access to its memory
> + *
> + * Return: void
> + */
> +static void
> +kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
> +		       struct kfd_mem_attachment *attachment)
> +{
> +	struct ttm_operation_ctx ctx = {.interruptible = true};
> +	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
> +	struct amdgpu_device *adev = attachment->adev;
> +	struct ttm_tt *ttm = bo->tbo.ttm;
> +	enum dma_data_direction dir;
> +
> +	if (unlikely(!ttm->sg)) {
> +		pr_err("SG Table of BO is UNEXPECTEDLY NULL");
> +		return;
> +	}
> +
> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> +	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +
> +	dir = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
> +				DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
> +	dma_unmap_resource(adev->dev, ttm->sg->sgl->dma_address,
> +			ttm->sg->sgl->length, dir, DMA_ATTR_SKIP_CPU_SYNC);
> +	sg_free_table(ttm->sg);
> +	kfree(ttm->sg);
> +	ttm->sg = NULL;
> +	bo->tbo.sg = NULL;
> +}
> +
>   static void
>   kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
>   			    struct kfd_mem_attachment *attachment)
> @@ -609,38 +804,14 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
>   	case KFD_MEM_ATT_DMABUF:
>   		kfd_mem_dmaunmap_dmabuf(attachment);
>   		break;
> +	case KFD_MEM_ATT_SG:
> +		kfd_mem_dmaunmap_sg_bo(mem, attachment);
> +		break;
>   	default:
>   		WARN_ON_ONCE(1);
>   	}
>   }
>   
> -static int
> -kfd_mem_attach_userptr(struct amdgpu_device *adev, struct kgd_mem *mem,
> -		       struct amdgpu_bo **bo)
> -{
> -	unsigned long bo_size = mem->bo->tbo.base.size;
> -	struct drm_gem_object *gobj;
> -	int ret;
> -
> -	ret = amdgpu_bo_reserve(mem->bo, false);
> -	if (ret)
> -		return ret;
> -
> -	ret = amdgpu_gem_object_create(adev, bo_size, 1,
> -				       AMDGPU_GEM_DOMAIN_CPU,
> -				       AMDGPU_GEM_CREATE_PREEMPTIBLE,
> -				       ttm_bo_type_sg, mem->bo->tbo.base.resv,
> -				       &gobj);
> -	amdgpu_bo_unreserve(mem->bo);
> -	if (ret)
> -		return ret;
> -
> -	*bo = gem_to_amdgpu_bo(gobj);
> -	(*bo)->parent = amdgpu_bo_ref(mem->bo);
> -
> -	return 0;
> -}
> -
>   static int
>   kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		      struct amdgpu_bo **bo)
> @@ -691,6 +862,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	uint64_t va = mem->va;
>   	struct kfd_mem_attachment *attachment[2] = {NULL, NULL};
>   	struct amdgpu_bo *bo[2] = {NULL, NULL};
> +	bool same_hive = false;
>   	int i, ret;
>   
>   	if (!va) {
> @@ -698,6 +870,24 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		return -EINVAL;
>   	}
>   
> +	/* Determine access to VRAM, MMIO and DOORBELL BOs of peer devices
> +	 *
> +	 * The access path of MMIO and DOORBELL BOs of is always over PCIe.
> +	 * In contrast the access path of VRAM BOs depens upon the type of
> +	 * link that connects the peer device. Access over PCIe is allowed
> +	 * if peer device has large BAR. In contrast, access over xGMI is
> +	 * allowed for both small and large BAR configurations of peer device
> +	 */
> +	if ((adev != bo_adev) &&
> +	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
> +	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
> +	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
> +		if (mem->domain == AMDGPU_GEM_DOMAIN_VRAM)
> +			same_hive = amdgpu_xgmi_same_hive(adev, bo_adev);
> +		if (!same_hive && !amdgpu_device_is_peer_accessible(bo_adev, adev))
> +			return -EINVAL;
> +	}
> +
>   	for (i = 0; i <= is_aql; i++) {
>   		attachment[i] = kzalloc(sizeof(*attachment[i]), GFP_KERNEL);
>   		if (unlikely(!attachment[i])) {
> @@ -708,9 +898,9 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
>   			 va + bo_size, vm);
>   
> -		if (adev == bo_adev ||
> -		   (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
> -		   (mem->domain == AMDGPU_GEM_DOMAIN_VRAM && amdgpu_xgmi_same_hive(adev, bo_adev))) {
> +		if ((adev == bo_adev && !(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
> +		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
> +		    same_hive) {
>   			/* Mappings on the local GPU, or VRAM mappings in the
>   			 * local hive, or userptr mapping IOMMU direct map mode
>   			 * share the original BO
> @@ -726,26 +916,30 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		} else if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
>   			/* Create an SG BO to DMA-map userptrs on other GPUs */
>   			attachment[i]->type = KFD_MEM_ATT_USERPTR;
> -			ret = kfd_mem_attach_userptr(adev, mem, &bo[i]);
> +			ret = create_dmamap_sg_bo(adev, mem, &bo[i]);
>   			if (ret)
>   				goto unwind;
> -		} else if (mem->domain == AMDGPU_GEM_DOMAIN_GTT &&
> -			   mem->bo->tbo.type != ttm_bo_type_sg) {
> -			/* GTT BOs use DMA-mapping ability of dynamic-attach
> -			 * DMA bufs. TODO: The same should work for VRAM on
> -			 * large-BAR GPUs.
> -			 */
> +		/* Handle DOORBELL BOs of peer devices and MMIO BOs of local and peer devices */
> +		} else if (mem->bo->tbo.type == ttm_bo_type_sg) {
> +			WARN_ONCE(!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL ||
> +				    mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP),
> +				  "Handing invalid SG BO in ATTACH request");
> +			attachment[i]->type = KFD_MEM_ATT_SG;
> +			ret = create_dmamap_sg_bo(adev, mem, &bo[i]);
> +			if (ret)
> +				goto unwind;
> +		/* Enable acces to GTT and VRAM BOs of peer devices */
> +		} else if (mem->domain == AMDGPU_GEM_DOMAIN_GTT ||
> +			   mem->domain == AMDGPU_GEM_DOMAIN_VRAM) {
>   			attachment[i]->type = KFD_MEM_ATT_DMABUF;
>   			ret = kfd_mem_attach_dmabuf(adev, mem, &bo[i]);
>   			if (ret)
>   				goto unwind;
> +			pr_debug("Employ DMABUF mechanim to enable peer GPU access\n");
>   		} else {
> -			/* FIXME: Need to DMA-map other BO types:
> -			 * large-BAR VRAM, doorbells, MMIO remap
> -			 */
> -			attachment[i]->type = KFD_MEM_ATT_SHARED;
> -			bo[i] = mem->bo;
> -			drm_gem_object_get(&bo[i]->tbo.base);
> +			WARN_ONCE(true, "Handling invalid ATTACH request");
> +			ret = -EINVAL;
> +			goto unwind;
>   		}
>   
>   		/* Add BO to VM internal data structures */
> @@ -1146,24 +1340,6 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
>   	return ret;
>   }
>   
> -static struct sg_table *create_doorbell_sg(uint64_t addr, uint32_t size)
> -{
> -	struct sg_table *sg = kmalloc(sizeof(*sg), GFP_KERNEL);
> -
> -	if (!sg)
> -		return NULL;
> -	if (sg_alloc_table(sg, 1, GFP_KERNEL)) {
> -		kfree(sg);
> -		return NULL;
> -	}
> -	sg->sgl->dma_address = addr;
> -	sg->sgl->length = size;
> -#ifdef CONFIG_NEED_SG_DMA_LENGTH
> -	sg->sgl->dma_length = size;
> -#endif
> -	return sg;
> -}
> -
>   static int process_validate_vms(struct amdkfd_process_info *process_info)
>   {
>   	struct amdgpu_vm *peer_vm;
> @@ -1532,7 +1708,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   			bo_type = ttm_bo_type_sg;
>   			if (size > UINT_MAX)
>   				return -EINVAL;
> -			sg = create_doorbell_sg(*offset, size);
> +			sg = create_sg_table(*offset, size);
>   			if (!sg)
>   				return -ENOMEM;
>   		} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index be0baacc5942..803c7a8345da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -34,6 +34,7 @@
>   #include <linux/pci.h>
>   #include <linux/devcoredump.h>
>   #include <generated/utsrelease.h>
> +#include <linux/pci-p2pdma.h>
>   
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_probe_helper.h>
> @@ -5498,6 +5499,36 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
>   	}
>   }
>   
> +/**
> + * amdgpu_device_is_peer_accessible - Check peer access through PCIe BAR
> + *
> + * @adev: amdgpu_device pointer
> + * @peer_adev: amdgpu_device pointer for peer device trying to access @adev
> + *
> + * Return true if @peer_adev can access (DMA) @adev through the PCIe
> + * BAR, i.e. @adev is "large BAR" and the BAR matches the DMA mask of
> + * @peer_adev.
> + */
> +bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
> +				      struct amdgpu_device *peer_adev)
> +{
> +#ifdef CONFIG_HSA_AMD_P2P
> +	uint64_t address_mask = peer_adev->dev->dma_mask ?
> +		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
> +	resource_size_t aper_limit =
> +		adev->gmc.aper_base + adev->gmc.aper_size - 1;
> +	bool p2p_access = !(pci_p2pdma_distance_many(adev->pdev,
> +					&peer_adev->dev, 1, true) < 0);
> +
> +	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
> +		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
> +		!(adev->gmc.aper_base & address_mask ||
> +		  aper_limit & address_mask));
> +#else
> +	return false;
> +#endif
> +}
> +
>   int amdgpu_device_baco_enter(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index bed4ed88951f..1cc9260e75de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -802,6 +802,16 @@ MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM fault (
>   module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
>   #endif
>   
> +/**
> + * DOC: pcie_p2p (bool)
> + * Enable PCIe P2P (requires large-BAR). Default value: true (on)
> + */
> +#ifdef CONFIG_HSA_AMD_P2P
> +bool pcie_p2p = true;
> +module_param(pcie_p2p, bool, 0444);
> +MODULE_PARM_DESC(pcie_p2p, "Enable PCIe P2P (requires large-BAR). (N = off, Y = on(default))");
> +#endif
> +
>   /**
>    * DOC: dcfeaturemask (uint)
>    * Override display features enabled. See enum DC_FEATURE_MASK in drivers/gpu/drm/amd/include/amd_shared.h.

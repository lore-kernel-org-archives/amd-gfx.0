Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74BEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Feb 2022 00:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E9110E284;
	Tue,  1 Feb 2022 00:56:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C1710E284
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Feb 2022 00:56:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6dSS3dusPl6uP5ANbtpsNDNEfd2xgnfCbqpeonFnUg9jp1cldArFcNbxiuj8Pg6BetOPDpyNlhq0eEWiUcqz29Kegm/dpFVM0Fso4zIXDRUoPNwqnyJotQXSiq/cBpmC0KmcUyKpRgsGLNMHyhfeTNDpBOpO2VK0KBKoMCNDAEYpJffZTOeHAReaiBHdH1K7+V0YpU2gtUrdhvCKJ+sNY5PmoYOdhbGibhFzi33YWH25MFhkFcXJDqIYd1G9zfRqoyK5k7jnOZDe6VGlVDENr5ie16N5IkNUPh0i4hmJlyDiHlGQfv2Gb4zAe42AZxqeiS6Z5BZptTHt8fJQll4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1Dv5WHWEzkfqNwYA0BABVajGRZBHQ7m3b7qnJW9UKs=;
 b=SeNe1x9ffhiJKXX63FNVaQqA/leIjlNwAZlQNWkhXb3Ibg/mBxhBpBmnFMZX4/pC2N8inHHmaKbSk7yHgZ/Odcm/Ko3sApn9GhHIQU2w/jBsOAzJTcV9dkmDdgamAgj3+IxxCCZj04H9mq3RX7QPeyVhSu8+SK7m76xtUKPi2Zw1KGXkq8hevYP2O9+0org24KdrWhmNXyAogUwlw9bGkRCm7EHySpssqN7s/vXs0UBab2198b/1bRcbKPfJ3Ke95sVVdIif2qQFt+miIbY/JCesxnAvZkUGVwOnEV0xlqzLmgM5uPNWYwkarIIgabic3H+48pVhuVUXyTk+hULztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1Dv5WHWEzkfqNwYA0BABVajGRZBHQ7m3b7qnJW9UKs=;
 b=kVHPpHL/51l34UuJorRpL2vjLwiHzq4REIkqHghBIp0VburL1dZq81Vr1DYu+bm6ZKuoWBNkMhVYqy8BhY7cO16tATRy2pYcjN33z5iJ+L2poAuT1aGGZ1o8yqnHU5hcGcfTa9ogCtjGouK6bKVKv+oYLe1YRdZPK+HiDbogmTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB4694.namprd12.prod.outlook.com (2603:10b6:a03:a5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 00:56:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 00:56:34 +0000
Message-ID: <f073f994-321e-f61e-571c-e1a2e5b68077@amd.com>
Date: Mon, 31 Jan 2022 19:56:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] drm/amdgpu: restructure amdgpu_fill_buffer v2
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 harish.kasiviswanathan@amd.com, benjaminadam.price@amd.com
References: <20220131135246.1521-1-christian.koenig@amd.com>
 <20220131135246.1521-4-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220131135246.1521-4-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ac99032-5324-4754-1884-08d9e51db1b0
X-MS-TrafficTypeDiagnostic: BYAPR12MB4694:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB469406B5368C2043228A6DED92269@BYAPR12MB4694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLb3wSENfJRev2YxXf/sHw8JTUR0n/1R9sr/EWW8zC+8j9hQgNFKXdRFSvLHQExcfBLPgpr/zvTRTBBtLFC1Q0iW7913AGemAOqfezZY2FRjgCPXl+81sVtLAMnQc+jxEfebyNjU+yEdpiphUfl2AIe3fNKp9g7Fp6kSnURWaT4pnx2HaI71rmExaHL98ZgVSSoXGa8RvPBnd3GelQjDO7eN9wekur09+24kXBN/WJvmfZboVu0s+TfLIljW7mSf0Vcp2NUZCaIAkJxZGyAAQjUirqDNCbz5VdRhNaTOYlzya+548SECa5aEIV6BzGK7PInhMWPHKzL7F/43Eerv8+6DacrCrz+v6AeXUny5PhfGbRZAAqmZGkO+ZfOFnFJaQEBaqzHPPLYKrv5XeWtVXQ0lX4uTYgw0tj/j+A+Cer27Qa9iCpfSfr6itw760kIQaYYFeeRh/tNJ3zBTc5hn0Z4P8b9Fiw3nDtvn73/dTEA/y0wNGfX7YHwsJravMA/b+MneXjhFp8XdVHWNUoh13h+kBycnCnjY80RTkVRkULfIJEBMsvStzK9B0BIHK32H5PWBMut1fNQk86j0fuxI3Me9NRP7CGE7ffZFh8gJe7F6A1a84T9USkR75yI3jpkUQKiHIken3V6DeEotx0YEKJkIqr3IyP9hl3/INyas7/R7Bm7FN061oxNcHqNZLJ2671btJYbDvR4JoBD/TzBqbx6i2UMSG61PuTCoWGvZvOvQQUIbNa8E56YRIn8wLCNH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66556008)(508600001)(6636002)(66574015)(6506007)(4326008)(66476007)(44832011)(86362001)(6512007)(36756003)(8676002)(31696002)(31686004)(8936002)(6486002)(5660300002)(316002)(83380400001)(2906002)(186003)(26005)(2616005)(38100700002)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzVkVWhrU29ZODVwcW9NdDFUbHphMFNvSUwwSWVnUm5tYnR4N2dvNVNTQWtp?=
 =?utf-8?B?ZXRqQnFQemo3M1Yrd3pmZGc3RXpKMzFYNnRoSEhFRGU2VWhBMTBha3BXSHNp?=
 =?utf-8?B?c3NLR1NVWk14MHpGRWE0Snc5K0xzUERNbnpvaVRzaUlzWDljRWptT1JQTmZB?=
 =?utf-8?B?dWswaXNrM0EwZlJHVG9rVHhCalJpSERLeEE0MitJdGxDdDE1S0ZDTUw4TTdx?=
 =?utf-8?B?bmxSNGhTQ2xVeFAvQXdmOWpPVm9VMmlDVlFZS0hnTUJpQTUxTmVnSE5Oak9q?=
 =?utf-8?B?ZXliSUQvTkw2MXBEMnoxbkZIaWdVYTNoVnZTSGR0RkQ5ZXJXK3lGMDI0am1V?=
 =?utf-8?B?NldMRFFSY2NQeDE5TlgrUXFDVkMvL2hRWVNyeDhFRnNCTHhDNjBDS1Q5QUQz?=
 =?utf-8?B?SkZIL1N2cFNSbFQ1T3Z3TklCMVF6YjNhbWlDUytuZ05uNUdRMG51MDJWU0Zw?=
 =?utf-8?B?eXBLaW12Zk1DN3BMMTgrS3pjVjVyejNWL2U3V2wwNHhMWWFxallBT0JQRlVp?=
 =?utf-8?B?WWdHM2g0TFNwVjJXcWN0MUNpR2swTWwrM0oyR3c5ZWRpVGMxeVpOdlJaOVht?=
 =?utf-8?B?ZVhGN1JDcmk2TSswMEJOSGRVemZDZDVXTG9sSURoSWVNcytPVExvRE1rb2cy?=
 =?utf-8?B?Z1kraWU0QU14RmR0SXpmaWk2YlVhamk2THgwN1BjaFBqbGQ1NGNBSXZBanZh?=
 =?utf-8?B?Z1IxVVNVSU1oSzNEdlZ3NFlSMlhwaWpUSnBhQlM5a0ZXMHZVREM1UlhwZzZZ?=
 =?utf-8?B?Zm83amZQQnYyRlpNTi9Wc3k5Mi9qend5SUtyM2FHeEJSK00xNloxRGxCZHJX?=
 =?utf-8?B?Mk92ZHJVU3BGNW9pdWdRZ2d4OG5pd2RNcFVzYnRtM2xuc0xqa2kxRk9GbCsw?=
 =?utf-8?B?a2ZVa21hN0hYbU42OWZZbUh4am0vMFNvR0ZSMHNEWGJLcG1scXE4dC9KS3dC?=
 =?utf-8?B?U0xiaXJ1djUwSXRhNURrYkpNQi9lV21Kb2VNWHIxa2drdXZjUnpOengrU0lv?=
 =?utf-8?B?enFNTjV0WjIya1NDR3hxZzNXSGw3enNUdHQyUnUrSWdack91VkJaQ1Q5MlRR?=
 =?utf-8?B?MEltcjJnUmNqbE0xUCs4R0txTXhGZUFuUkRWZTdOaHMzaG84a1pOMm9XTEhj?=
 =?utf-8?B?LzRsVy94Um1UZWF6b1JhUWN2eTRnS2dOVlByODN3M1pIYUN4bFFvYm1zV3lO?=
 =?utf-8?B?SXM3eHVvbStROVRXTzhvT2lneDU5QkQveWVkQXVVaXFqWFBrZmQrbkEzbDFm?=
 =?utf-8?B?MVRPZUViN2hNWWU2Qy81VGlaQ3JjQmFkZEwrdnE1Z2hxckFtalZjV0ZHVTFr?=
 =?utf-8?B?dTNoaG8yUVNaeEYwYlU3VEpvVURoU2Q5ZUJ4VW9JUmt6akFXWmcxbVMxbkRp?=
 =?utf-8?B?WHY3ZXVFc0ZyTHMwREhCZkU2NEdMdjdyZmh6cTBpOWFpME9BK2o1RDJrTStm?=
 =?utf-8?B?cUFicHkyREViSm9EWUZ4RnhqSm5PMDgyZDliWTQ3VHpUd3VtMEF1OGtjbWZ3?=
 =?utf-8?B?ZEJ5WWY4dlJPeEQ2MEpvczJrMlNsRzYyNUVpeWxCZnpsVU1WdEVkaGdQVXFq?=
 =?utf-8?B?aHJBMDA3ckVrem43YldxeGlBNFZMWlNzaWJhZ2xLd05weTkyRUl5TGwwTEh3?=
 =?utf-8?B?V1ZQcE1XVExHekN4c0t5S3FFaFFOak5jWWd0R0hhRjIwMFhJZFdUZ0RZaS9Q?=
 =?utf-8?B?WldHNWljOVYwekpyMllYdWI4OUVYcldNNW9BRlF1TlI4TUIyc3lGNnJSWEpU?=
 =?utf-8?B?ZDJWL0Y5aFVmdjhXTEx6YnhZZ3JRSGtMbERtN2tGbStMSlNTc1ZUUENhVWli?=
 =?utf-8?B?QjRYcnlYS1FTeGdZcXJkWnQ0dEFaQThHem9uKytYaGhOWjI3RmR5a0ZuSmtw?=
 =?utf-8?B?STI3WmNWUElhVDVESG1VQTBrT1N5QnRtUGZLaTNaaVdOWlFiN2RrMHFONXFs?=
 =?utf-8?B?WCthYzFMMUVTaVNxUGtoZEQ3NFNrd1RhaWNxTGtFdDlnUXNSMXJCejRzQjg3?=
 =?utf-8?B?anVzbzVSc3ZjdGZzTXp4SXBWUG5oS2VUQTJSZFhPSlQyOGphcGVOTEV3Y0xo?=
 =?utf-8?B?T1d0N21NMllJN09uM0l6QkdiQzRlUm5Zai9TSHBaZmcxRjdQUWtKUWxLNmhz?=
 =?utf-8?B?NVFsaHpjQ3NUdlVocS9LZks1cUk2RjNXZ3A4QlArbzRLRW15cndqRXFMcTZ2?=
 =?utf-8?Q?UkdvKjIJ3/261GmS5rzI8yQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac99032-5324-4754-1884-08d9e51db1b0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 00:56:34.8805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3lHdGXK95/WpLZbq9tEXcjIiRKXHqHO1oBGf5mAES2sAIljDGejxDHM4kKGumn8kR7QC2ckq9f0t9+4E9ZAqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4694
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-01-31 um 08:52 schrieb Christian König:
> We ran into the problem that clearing really larger buffer (60GiB) caused an
> SDMA timeout.
>
> Restructure the function to use the dst window instead of mapping the whole
> buffer into the GART and then fill only 2MiB/256MiB chunks at a time.
>
> v2: rebase on restructured window map.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 187 +++++++++++++-----------
>   1 file changed, 105 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 26c521cd1092..b9637d1cf147 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -396,8 +396,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>   	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
>   		struct dma_fence *wipe_fence = NULL;
>   
> -		r = amdgpu_fill_buffer(ttm_to_amdgpu_bo(bo), AMDGPU_POISON,
> -				       NULL, &wipe_fence);
> +		r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, &wipe_fence);
>   		if (r) {
>   			goto error;
>   		} else if (wipe_fence) {
> @@ -1923,19 +1922,51 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>   	adev->mman.buffer_funcs_enabled = enable;
>   }
>   
> +static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
> +				  bool direct_submit,
> +				  unsigned int num_dw,
> +				  struct dma_resv *resv,
> +				  bool vm_needs_flush,
> +				  struct amdgpu_job **job)
> +{
> +	enum amdgpu_ib_pool_type pool = direct_submit ?
> +		AMDGPU_IB_POOL_DIRECT :
> +		AMDGPU_IB_POOL_DELAYED;
> +	int r;
> +
> +	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, pool, job);
> +	if (r)
> +		return r;
> +
> +	if (vm_needs_flush) {
> +		(*job)->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
> +							adev->gmc.pdb0_bo :
> +							adev->gart.bo);
> +		(*job)->vm_needs_flush = true;
> +	}
> +	if (resv) {
> +		r = amdgpu_sync_resv(adev, &(*job)->sync, resv,
> +				     AMDGPU_SYNC_ALWAYS,
> +				     AMDGPU_FENCE_OWNER_UNDEFINED);
> +		if (r) {
> +			DRM_ERROR("sync failed (%d).\n", r);
> +			amdgpu_job_free(*job);
> +			return r;
> +		}
> +	}
> +	return 0;
> +}
> +
>   int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>   		       uint64_t dst_offset, uint32_t byte_count,
>   		       struct dma_resv *resv,
>   		       struct dma_fence **fence, bool direct_submit,
>   		       bool vm_needs_flush, bool tmz)
>   {
> -	enum amdgpu_ib_pool_type pool = direct_submit ? AMDGPU_IB_POOL_DIRECT :
> -		AMDGPU_IB_POOL_DELAYED;
>   	struct amdgpu_device *adev = ring->adev;
> +	unsigned num_loops, num_dw;
>   	struct amdgpu_job *job;
> -
>   	uint32_t max_bytes;
> -	unsigned num_loops, num_dw;
>   	unsigned i;
>   	int r;
>   
> @@ -1947,26 +1978,11 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>   	max_bytes = adev->mman.buffer_funcs->copy_max_bytes;
>   	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
>   	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
> -
> -	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, pool, &job);
> +	r = amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
> +				   resv, vm_needs_flush, &job);
>   	if (r)
>   		return r;
>   
> -	if (vm_needs_flush) {
> -		job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
> -					adev->gmc.pdb0_bo : adev->gart.bo);
> -		job->vm_needs_flush = true;
> -	}
> -	if (resv) {
> -		r = amdgpu_sync_resv(adev, &job->sync, resv,
> -				     AMDGPU_SYNC_ALWAYS,
> -				     AMDGPU_FENCE_OWNER_UNDEFINED);
> -		if (r) {
> -			DRM_ERROR("sync failed (%d).\n", r);
> -			goto error_free;
> -		}
> -	}
> -
>   	for (i = 0; i < num_loops; i++) {
>   		uint32_t cur_size_in_bytes = min(byte_count, max_bytes);
>   
> @@ -1996,77 +2012,35 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>   	return r;
>   }
>   
> -int amdgpu_fill_buffer(struct amdgpu_bo *bo,
> -		       uint32_t src_data,
> -		       struct dma_resv *resv,
> -		       struct dma_fence **fence)
> +static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
> +			       uint64_t dst_addr, uint32_t byte_count,
> +			       struct dma_resv *resv,
> +			       struct dma_fence **fence,
> +			       bool vm_needs_flush)
>   {
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> -	uint32_t max_bytes = adev->mman.buffer_funcs->fill_max_bytes;
> -	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> -
> -	struct amdgpu_res_cursor cursor;
> +	struct amdgpu_device *adev = ring->adev;
>   	unsigned int num_loops, num_dw;
> -	uint64_t num_bytes;
> -
>   	struct amdgpu_job *job;
> +	uint32_t max_bytes;
> +	unsigned int i;
>   	int r;
>   
> -	if (!adev->mman.buffer_funcs_enabled) {
> -		DRM_ERROR("Trying to clear memory with ring turned off.\n");
> -		return -EINVAL;
> -	}
> -
> -	if (bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
> -		DRM_ERROR("Trying to clear preemptible memory.\n");
> -		return -EINVAL;
> -	}
> -
> -	if (bo->tbo.resource->mem_type == TTM_PL_TT) {
> -		r = amdgpu_ttm_alloc_gart(&bo->tbo);
> -		if (r)
> -			return r;
> -	}
> -
> -	num_bytes = bo->tbo.resource->num_pages << PAGE_SHIFT;
> -	num_loops = 0;
> -
> -	amdgpu_res_first(bo->tbo.resource, 0, num_bytes, &cursor);
> -	while (cursor.remaining) {
> -		num_loops += DIV_ROUND_UP_ULL(cursor.size, max_bytes);
> -		amdgpu_res_next(&cursor, cursor.size);
> -	}
> -	num_dw = num_loops * adev->mman.buffer_funcs->fill_num_dw;
> -
> -	/* for IB padding */
> -	num_dw += 64;
> -
> -	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, AMDGPU_IB_POOL_DELAYED,
> -				     &job);
> +	max_bytes = adev->mman.buffer_funcs->fill_max_bytes;
> +	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
> +	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
> +	r = amdgpu_ttm_prepare_job(adev, false, num_dw, resv, vm_needs_flush,
> +				   &job);
>   	if (r)
>   		return r;
>   
> -	if (resv) {
> -		r = amdgpu_sync_resv(adev, &job->sync, resv,
> -				     AMDGPU_SYNC_ALWAYS,
> -				     AMDGPU_FENCE_OWNER_UNDEFINED);
> -		if (r) {
> -			DRM_ERROR("sync failed (%d).\n", r);
> -			goto error_free;
> -		}
> -	}
> -
> -	amdgpu_res_first(bo->tbo.resource, 0, num_bytes, &cursor);
> -	while (cursor.remaining) {
> -		uint32_t cur_size = min_t(uint64_t, cursor.size, max_bytes);
> -		uint64_t dst_addr = cursor.start;
> +	for (i = 0; i < num_loops; i++) {
> +		uint32_t cur_size = min(byte_count, max_bytes);
>   
> -		dst_addr += amdgpu_ttm_domain_start(adev,
> -						    bo->tbo.resource->mem_type);
>   		amdgpu_emit_fill_buffer(adev, &job->ibs[0], src_data, dst_addr,
>   					cur_size);
>   
> -		amdgpu_res_next(&cursor, cur_size);
> +		dst_addr += cur_size;
> +		byte_count -= cur_size;
>   	}
>   
>   	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> @@ -2083,6 +2057,55 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>   	return r;
>   }
>   
> +int amdgpu_fill_buffer(struct amdgpu_bo *bo,
> +			uint32_t src_data,
> +			struct dma_resv *resv,
> +			struct dma_fence **f)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> +	struct dma_fence *fence = NULL;
> +	struct amdgpu_res_cursor dst;
> +	int r;
> +
> +	if (!adev->mman.buffer_funcs_enabled) {
> +		DRM_ERROR("Trying to clear memory with ring turned off.\n");
> +		return -EINVAL;
> +	}
> +
> +	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &dst);
> +
> +	mutex_lock(&adev->mman.gtt_window_lock);
> +	while (dst.remaining) {
> +		struct dma_fence *next;
> +		uint64_t cur_size, to;
> +
> +		/* Never fill more than 256MiB at once to avoid timeouts */
> +		cur_size = min(dst.size, 256ULL << 20);
> +
> +		r = amdgpu_ttm_map_buffer(&bo->tbo, bo->tbo.resource, &dst,
> +					  1, ring, false, &cur_size, &to);
> +		if (r)
> +			goto error;
> +
> +		r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
> +					&next, true);

I really think we should set vm_needs_flush conditionally here. We try 
hard to avoid VM flushs when they are not needed because they affect the 
performance of all running applications. Anyway, this can be another patch.

This series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

It was also tested by Harish and Benjamin. There was no noticeable 
slowdown for large fills. And the timeouts are no longer observed (the 
test is still running, but fingers crossed).

Thanks,
   Felix


> +		if (r)
> +			goto error;
> +
> +		dma_fence_put(fence);
> +		fence = next;
> +
> +		amdgpu_res_next(&dst, cur_size);
> +	}
> +error:
> +	mutex_unlock(&adev->mman.gtt_window_lock);
> +	if (f)
> +		*f = dma_fence_get(fence);
> +	dma_fence_put(fence);
> +	return r;
> +}
> +
>   /**
>    * amdgpu_ttm_evict_resources - evict memory buffers
>    * @adev: amdgpu device object

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79E3C7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 22:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE4010E2C4;
	Wed, 17 May 2023 22:10:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F7A10E082
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 22:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdrbFziH51cLvsmCfp8mGsD/ksD9jrPuxc6HQ9XvRu3riFCMOO7/+JOjs/mk1oEo4OOcg8KMpVl+9c9jjhADcJAyd+JSe4Hgmrnf5O6GpmX9qQA2IPZFc0qqjlPh1X+qfUEhjwvUrKP8EL+QPCxQwQJ7DezJR+jGxbIdBsAON+na51kI3C+MRuqn1j6xPKXY/wAGiodRSkNaLvNU/zvGanMbEjFp6OC3WcwloK4l6ZWXnbyTeYjhofEEAlTOZE1QSyAv5qdp7ylZLY2E5RZ6WDKzdUc0Pmn8Gh6QqC6UBFMBQn5XHo4AC3KiKRxDSiTfHO1SMrKOVq5Eh22g5ed5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4gxHuDOjgw8C8FWvfmV9I5H/n/xier4Dj0cmdGR5C4=;
 b=M5O/xd6F5qhIj1kVqkVEfAhIatjpuz265CsEXQyi0+F1STryqxnHMT6KWMvoMVW/1SGbIDbXjniX4WyreKUr6o+NDUGXlfK5s2/qSO1I8A6kzKUe8UAKmwA7liWgqJBoonFja4wWpKjfyl/GXKuawnkoheWDAUp/z8w6FiyjcA2SDmO0PJYc8cnrsak4bn0qJHSTOM5bLnEpQ30Zp1iupl8e4vXHwfSdBmE7e2m7iTRtad47JrzHiT9vGBAzrWy9v0TTx9Z9zfJWvHgGH6VokbZvYfOb5/ttNHXFMCTFLKXE+CAdhG2EwiQYC/w2TH6nkboHhwPFQ9hWWm3gfqSXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4gxHuDOjgw8C8FWvfmV9I5H/n/xier4Dj0cmdGR5C4=;
 b=fbaAG+f503OKDfnfKSsYviKaFZ/4uvK9/BgLhjazUaiaxcCFZxX/2cjxmOBjrQeYI4sLGarf3RHhyUKFK/oVOo287/DNe913XZa6MVrOcWIo9AaOajv6lv48lLZM4JvF/ua0SKi6+mt25OEyi7Plej3kc32E7k+YsiPiD7vWfVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 22:10:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 22:10:22 +0000
Message-ID: <41e91d4b-7504-a431-d891-ac5e79c5b80e@amd.com>
Date: Wed, 17 May 2023 18:10:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Add a low priority scheduler for VRAM clearing
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230517214040.539342-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230517214040.539342-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ce0547-10d9-4aab-b332-08db5723821f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJbD3I/C4n1gltbqQsaPpwQIlYoiURIUUzsjhtyoPSDAW6vgZy/XZn3ZdaHsCwRTeTnRyfbjbxPo896XfUNM15fAwuFO+1NNXz0yZxnryc8Xs5rX8ZXDlZM6AmJBgt2Oy0RIbd+Yl9J7iujJdXHRMMYd8EesDTyMU4GOgQeOZGrknk6XYVQuURcmNSj3J3x5qw0pnyN5/8pFH2oOFWhDr++mQQ/TbklqM1uB37gIbXd2K1d+OrW83NOgW33Zmq9D6gsMBNbiJEEglt9g8gloyygexs1q+LOMWGgF9FN78YYXQr5salWxEDSUs/SqJ7GYcC+OQOGfsKzzfBd4V3T6ojBaMPaC8b5WNPm5OI9Qhest322RoIFr4n5mSiCuw/lKibg9eSJg+SuSaPXb9oB5LFRll0ZcINU/4PDeQhLYj93mUzS/QAm8W8CBAb6cayCFpvbs602qS9UGXh5G7y9Vp1YiRefQUHT1njqNrK9T9u1upwrYMEe8Wi3iMceZa6aSOaq0VQMx2ygwjm1KQ/LvSi7HE5ROefYApzu+Mvj2j1ANQLWJMwGzDxo54Hhz4kVEa1rijypFbHFHu9w3fiBNjZhfd3unt6eI0uFBVCokKC+xEa4JaG4hEt54srOZPHNgBzgWuf5CEg5Q2FZJVgLPtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(86362001)(36756003)(31696002)(6486002)(66556008)(4326008)(66476007)(316002)(36916002)(478600001)(6666004)(2906002)(8936002)(5660300002)(41300700001)(8676002)(44832011)(38100700002)(6506007)(6512007)(26005)(186003)(2616005)(53546011)(66946007)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckRTNlBHdWxwV3g3QU9QVFNqMk10QWZqaUtWMU8xem0wTzhQbTdPQjl0cHFL?=
 =?utf-8?B?UEczYm1LWXVsQU5RZ2JUZzZ6TWVqcTNFc2YrZS90U1Z4WmlaM1RMdXVDZXFz?=
 =?utf-8?B?enlvbElvcUpVNWVoZllsM2I2ZDMrb3kvK042YjUxOVpYa2ptWHlWNExsVlBV?=
 =?utf-8?B?c2JMR2grNE5ncUhYYk9GcGRDcWJjK3ppS2JsT0RlZmdSTEtMUFNEd3ZHVDZE?=
 =?utf-8?B?SXluNWk5ZlFNR0JRL2ZQSlNiM1h2elkwWkk3OUIvcXU2cGJaUG1RQStYQUNy?=
 =?utf-8?B?WUZWelA2Uks2cTd1Qlp3MXR6cFRPRjFqQjE1b0lzb3RTS1lobGxTUzZ6QlBF?=
 =?utf-8?B?dG1PbnlQUm9RS3ZqOUcrS3FZNDQ3eVN2a0JhdTk4aVgxT1FiRitBcTk1RUNP?=
 =?utf-8?B?bUttelk5MjFJeG0xUlY1bFZUOUM1ZDEzQ0U0MXlvTXdhYjlhS3RTdXZQa3JX?=
 =?utf-8?B?M0RSaExwYjdyejdaK3cyMmxNMlpKYlN2cExIRDcvTDVYTndJRjIxQjBZVi92?=
 =?utf-8?B?ZjVuNlQveFhUK0Q4TkJxUU1JdTNWb04xZTEya2FkSU1td01kUDlmekM4MHB2?=
 =?utf-8?B?UU1HOTUrNlordmJFcFZCT0pYZkFSWlVDWkZLU015REpoWlgxYnZRNzJqbFF4?=
 =?utf-8?B?VTVFeEFXeitZRDVveGxOSStaMXVNRjI3WTVZZllUVkM5UDQyeFNkekU0Y3Bp?=
 =?utf-8?B?TE9FSU1HM2JWQmg4VktpS0ptMWhBeFBGNWdOcDZWWXlNZ2kwems4ZmlPNmRF?=
 =?utf-8?B?eHJINjNROTdqaGNXem0yaG5UMVFFNkxiNEx4aDNVZy9aWjcvOGt4aFd0VWZG?=
 =?utf-8?B?T01mZGpWSGN3a2FMVnZGbUd6MmpXMEZnTmpnWUZiMlI5Qmw3a05yeU1oUGJZ?=
 =?utf-8?B?N0hnb2lDQVIzb05CQTNVd3ZXbWZyMHlZYU9NRUlPcEhsbDdBWG9DSEM1cVZh?=
 =?utf-8?B?S3lMK0QwZzB1RlpFNUpBdHFJOHBubzlHWkFBUUZGTHVBNmdBakJRcTNIOFBk?=
 =?utf-8?B?YitCazdQRSt2K2JHQVlYekpqczFtMFZHUHI4bUhrNTJvWVpyTGZkSmpPMzEy?=
 =?utf-8?B?MGhIUzdKTkN5TEo3VG1WbThJWTlwdVpMc1lVTWU2NnRVTGxWd01IZXZ5UjJt?=
 =?utf-8?B?a1hLNmFhSW93ZlJ2L1NWTWVjNWZFa2NhYjJjOW50UXpRTnFYNlBNMGJrcG9Q?=
 =?utf-8?B?blhCVVFSY2ZHd2lEa2FsY2NUM0RaQ0ZPLzBoVWt4R1J4VCtUbkpWTzJNaUJU?=
 =?utf-8?B?OGF5eG9UQk1NZi82eDhKd0FLdzJ6K3V6Y1Bpdm5jcGpGOGhpcU9ZSFJGN3cv?=
 =?utf-8?B?RDhvZ1VKaVMzeVQxZ2tzUEFJMGJJR01PMDRrQWUvQlhOMlRUR2FrVG1Ka01q?=
 =?utf-8?B?Z2pWYmtxbERpci80V3k2NVh0SUdnSHNvOStCTXV2Nzg4d1dvNnNHYlBsaTJH?=
 =?utf-8?B?RzFDdFRHamRkR2xlSTdJVi9zL3ZINjZUN1B3NWtRNTYyUW5KSkNFR1FwVlRw?=
 =?utf-8?B?eHFGdmZlNG5oaTZTZldlUFlJUUMxY1JySnArWmJQN1lYTlg4VE1ZajN5UFY3?=
 =?utf-8?B?RnVDRWc4Zyt4UjlUSDB0VzRGVzNMOXU0cmhDek5QUEdRZ2pQVWRteS82bkF2?=
 =?utf-8?B?NTRMampQd0cxMFhZZm8zRjcyMi9BOVNmeDZlSXpSWWRjUXZkV1JPS0MvZDVG?=
 =?utf-8?B?V2VpSzBRVlBURmRSSk5XSE5rVnQ4K3Evd2NQZmtuQ1g3NXFNOWpYRGwyM05j?=
 =?utf-8?B?Q2ptbHo1Ni9iUjFUREVFaUNKQUJVVVpNNFlvRGVFVGJ2dm5LcllYV3g0SHJT?=
 =?utf-8?B?RVdQcHgxU3FxZXoxYXE0S3QvM2VNY3VLNExkbVJ3TGNhTXVHWnd4bmJUdlBN?=
 =?utf-8?B?YzlpcGxJck5NZmlsVmFoc2FrQUpGMFlPQTU5MkdpRytsaUEycVB1cVQ5bzBF?=
 =?utf-8?B?akdTcXlwVEF4aDl0dHdtL0VzbXdJUTVEck05bTI0OE5rZFhyNUZQR0Rzc3ZI?=
 =?utf-8?B?RWJuWWJ3bGx6aVQ0Q0pxeXFRTmRxRFpZOVFWRkFlUEptbHZFc1dDQk82elM5?=
 =?utf-8?B?aVl1eVFjcG5NTm0wUjZyZHZaUXFXSFdsYVA4UW13N0hoeXIzaENDSmpCb3BZ?=
 =?utf-8?Q?IAwMtPnChKzXRXM82G4skP6Lk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ce0547-10d9-4aab-b332-08db5723821f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:10:22.2995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTThiP1flv0ePtAA6f5b1S75UOSFFEhUL69ATZ6RR7ArHqi5RDnhqq//dQYqXqZPQBkwyHbuiQ2BZaHCOpE86w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
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

On 2023-05-17 17:40, Mukul Joshi wrote:
> Add a low priority DRM scheduler for VRAM clearing instead of using
> the exisiting high priority scheduler. Use the high priority scheduler
> for migrations and evictions.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 37 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  5 ++-
>   3 files changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 9924c8de57ab..46f249912b67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -627,7 +627,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>   		struct dma_fence *fence;
>   
> -		r = amdgpu_fill_buffer(bo, 0, bo->tbo.base.resv, &fence);
> +		r = amdgpu_fill_buffer(bo, 0, bo->tbo.base.resv, &fence, true);
>   		if (unlikely(r))
>   			goto fail_unreserve;
>   
> @@ -1354,7 +1354,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
>   		return;
>   
> -	r = amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, &fence);
> +	r = amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, &fence, true);
>   	if (!WARN_ON(r)) {
>   		amdgpu_bo_fence(abo, fence, false);
>   		dma_fence_put(fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 34724b771ace..bbdad0dc1b07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -384,7 +384,8 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>   	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
>   		struct dma_fence *wipe_fence = NULL;
>   
> -		r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, &wipe_fence);
> +		r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, &wipe_fence,
> +					false);
>   		if (r) {
>   			goto error;
>   		} else if (wipe_fence) {
> @@ -2040,8 +2041,18 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>   				  r);
>   			return;
>   		}
> +
> +		r = drm_sched_entity_init(&adev->mman.delayed,

I'm not a big fan of the "delayed" name. But I see the parallel with 
"immediate" and "delayed" entities in amdgpu_vm. We may want to rename 
adev->mman.entity to "immediate" as well to make the distinction clearer.


> +					  DRM_SCHED_PRIORITY_NORMAL, &sched,

I wonder if this could even be DRM_SCHED_PRIORITY_MIN to minimize its 
performance impact on page table updates and graphics user mode 
submissions. Either way, the patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

Thanks,
   Felix


> +					  1, NULL);
> +		if (r) {
> +			DRM_ERROR("Failed setting up TTM BO move entity (%d)\n",
> +				  r);
> +			goto error_free_entity;
> +		}
>   	} else {
>   		drm_sched_entity_destroy(&adev->mman.entity);
> +		drm_sched_entity_destroy(&adev->mman.delayed);
>   		dma_fence_put(man->move);
>   		man->move = NULL;
>   	}
> @@ -2053,6 +2064,11 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>   		size = adev->gmc.visible_vram_size;
>   	man->size = size;
>   	adev->mman.buffer_funcs_enabled = enable;
> +
> +	return;
> +
> +error_free_entity:
> +	drm_sched_entity_destroy(&adev->mman.entity);
>   }
>   
>   static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
> @@ -2060,14 +2076,16 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>   				  unsigned int num_dw,
>   				  struct dma_resv *resv,
>   				  bool vm_needs_flush,
> -				  struct amdgpu_job **job)
> +				  struct amdgpu_job **job,
> +				  bool delayed)
>   {
>   	enum amdgpu_ib_pool_type pool = direct_submit ?
>   		AMDGPU_IB_POOL_DIRECT :
>   		AMDGPU_IB_POOL_DELAYED;
>   	int r;
> -
> -	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
> +	struct drm_sched_entity *entity = delayed ? &adev->mman.delayed :
> +						    &adev->mman.entity;
> +	r = amdgpu_job_alloc_with_ib(adev, entity,
>   				     AMDGPU_FENCE_OWNER_UNDEFINED,
>   				     num_dw * 4, pool, job);
>   	if (r)
> @@ -2108,7 +2126,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>   	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
>   	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
>   	r = amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
> -				   resv, vm_needs_flush, &job);
> +				   resv, vm_needs_flush, &job, false);
>   	if (r)
>   		return r;
>   
> @@ -2144,7 +2162,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
>   			       uint64_t dst_addr, uint32_t byte_count,
>   			       struct dma_resv *resv,
>   			       struct dma_fence **fence,
> -			       bool vm_needs_flush)
> +			       bool vm_needs_flush, bool delayed)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	unsigned int num_loops, num_dw;
> @@ -2157,7 +2175,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
>   	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
>   	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
>   	r = amdgpu_ttm_prepare_job(adev, false, num_dw, resv, vm_needs_flush,
> -				   &job);
> +				   &job, delayed);
>   	if (r)
>   		return r;
>   
> @@ -2180,7 +2198,8 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
>   int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>   			uint32_t src_data,
>   			struct dma_resv *resv,
> -			struct dma_fence **f)
> +			struct dma_fence **f,
> +			bool delayed)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> @@ -2209,7 +2228,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>   			goto error;
>   
>   		r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
> -					&next, true);
> +					&next, true, delayed);
>   		if (r)
>   			goto error;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 8ef048a0a33e..e82b1edee7a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -61,6 +61,8 @@ struct amdgpu_mman {
>   	struct mutex				gtt_window_lock;
>   	/* Scheduler entity for buffer moves */
>   	struct drm_sched_entity			entity;
> +	/* Scheduler entity for VRAM clearing */
> +	struct drm_sched_entity			delayed;
>   
>   	struct amdgpu_vram_mgr vram_mgr;
>   	struct amdgpu_gtt_mgr gtt_mgr;
> @@ -152,7 +154,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>   int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>   			uint32_t src_data,
>   			struct dma_resv *resv,
> -			struct dma_fence **fence);
> +			struct dma_fence **fence,
> +			bool delayed);
>   
>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);

Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F0BC352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BC520675
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AIxPYEaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BC520675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640A66EE5B;
	Tue, 11 Feb 2020 14:09:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17116EE56
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 14:09:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An6Dl5AgOyNLps8zbo886i6cYFEOf9lLRFyhEfFvgFm0J82RmjMBCfsUCMoVWoTz3aBHXAG6ncK3992ovuRtMn9Xout6Y0pMwA6I4d7lq2lAbrqLt4UD8qUjscBXcmFwKUaSjrQIH5YFl6U47ZtN5gs1O+E/H9M05KVCkVibNoKQ2dhbsIi0hq/QphktVPuR3w3j0YoTFxRJCq/QyMwmUaBCXTbaQOA+mw9cSrvPlzAnHo2IfAZoWvhI1Up8oCULgXY23o0Qf9jetsSOGGTY0YrmKQHAvNORXGmLUrCLYlRXqy+dVSrf4hQUJUNTpEC3eDhw74tlsSitGtNFw/2Sog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh0nzZSKmDOC+6u9L5UP36FhdXgmyPXu4oVyvWkIX+4=;
 b=ZYGynJ+BkmK/GHvsn90v3sGB3VxR2xlHfzuAONzoIhVxoyuhyX1bD0pLs8pRE3KOkJOfpD6QMrm4CCcanepyYe+EAlSPhOYCpOipXJmDslojB6USxx+Do9w+nl98SJ66Lb/FYgnWszH3E/ewF8OwejiRaNgcRFKv35cRndju30pgiulJJZng5nkVKc+o8iEY1vC70820BPDUFcHuQdw4sT0uA1E6KQTPNyNBiryK+ik1muJuIZYDuMYuaut5CJS4z4+yFJvoDg5XS++D1hRmO3Okk/zZnaJ/7RyVZ+4onoFuKr8Yg8molzD5aXp8wDHq+nWESk8eIuJvftRX5lUVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh0nzZSKmDOC+6u9L5UP36FhdXgmyPXu4oVyvWkIX+4=;
 b=AIxPYEaKb+W4Kxx5QW94agwA31XrXRWFa66QlHvX8GIV7JLX0YotLH/S9Gri2Ou8pgQk5yTLnuhuBNJmujKpjh8rvSns5e77ycm8tzX7WPT4RYoLDPIiNbT2g7XxwmXcHC34HNWhM/lvIAkRUD233061G2D95p7iPWpk3xUNFS8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1274.namprd12.prod.outlook.com (10.168.239.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 14:09:26 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2707.030; Tue, 11 Feb
 2020 14:09:26 +0000
Subject: Re: [RFC PATCH v2] drm/amdgpu: move ttm bo->offset to amdgpu_bo
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200211140656.3574-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3bf68f81-2825-6b00-af9a-e073c3872384@amd.com>
Date: Tue, 11 Feb 2020 15:09:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200211140656.3574-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0087.eurprd07.prod.outlook.com
 (2603:10a6:207:6::21) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0087.eurprd07.prod.outlook.com (2603:10a6:207:6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.14 via Frontend Transport; Tue, 11 Feb 2020 14:09:25 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ef83b34-e04b-4c59-f6cb-08d7aefc00cb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1274:|DM5PR12MB1274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB12740745130FECBC7AB538E283180@DM5PR12MB1274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(199004)(189003)(316002)(66556008)(66476007)(66946007)(6486002)(5660300002)(478600001)(31686004)(4326008)(16526019)(36756003)(8936002)(52116002)(186003)(81166006)(81156014)(8676002)(2906002)(86362001)(31696002)(2616005)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1274;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3KZrbcD1ddAk2vyd+D6QFj/rwaDz+JYM4hTw3Uv+M4ngAayocsSe+EG3/BIWwPdvNFRF7WRHUj0zFxv6D+YdDqf9s87o3Fgbh1QJ0laNYqQp43F203Z1vWZSN/ONWUP1usezamwe1Ex/wrYGEvtkxfk0VMOg5hKA/D+cR6xGaWGBGuNlSu21xxqzg1BWgj/J7R5+L13hyiP/N/xsNg0fb3K7stoFXTtkTvMMRCM07xUi+H7AJ8FIjNRt3sQDOSFG/tEWPr7y+zBKyo87Y8MdkdYLTdosIdmHovv3RTUzW+OQDtFYNGRmQ5049LJMkRc4M5wQVJwYYdIqVaqe/MG2WTkvlFi6m0tSajd9cVrC0tj72tUscrpqKT5Qc2MV7fDkgQkIrhiFXWbgfH+gPA1e2XEACpuwTPSuoFL/TRfFppaVSEP0b7gCt237yc5C7Uv
X-MS-Exchange-AntiSpam-MessageData: z/daILyu8EU6rU7CiWPQKWGe3KU8cwYiJKQq2KRqpU3NgnyiSzyP4IHCyDAa6KvX1tmMBh40HYGA8n1H6jTYBAdn1YgcJNJ0t7glvh8Wc4XXIw+LVv/PoMH6hkEdO2/7T4m+YtOEFc05gdtm+WrZ4r/puSyaA2jx3oyq/jB/2Wdv6z4sCJ9lct6IriW1RP6UusRSRPsZoRTmMO47vNb31g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef83b34-e04b-4c59-f6cb-08d7aefc00cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 14:09:26.6332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqXUk7ul3k4mx7Y2OUgySVi7VnvTwPXxLSR7jY/bCjQTmcXVWIMLE4xlbt7jZnA8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1274
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.02.20 um 15:06 schrieb Nirmoy Das:
> GPU address should belong to driver not in memory management.
> This patch moves ttm bo.offset and gpu_offset calculation to amdgpu driver.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 22 +++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  8 +-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  4 ++--
>   4 files changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6f60a581e3ba..e25924be33ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -917,7 +917,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   		bo->pin_count++;
>   
>   		if (max_offset != 0) {
> -			u64 domain_start = bo->tbo.bdev->man[mem_type].gpu_offset;
> +			u64 domain_start = amdgpu_bo_gpu_start(adev, mem_type);
>   			WARN_ON_ONCE(max_offset <
>   				     (amdgpu_bo_gpu_offset(bo) - domain_start));
>   		}
> @@ -1248,6 +1248,18 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>   	return 0;
>   }
>   
> +uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev, uint32_t type)

Probably better to put that into amdgpu_ttm.[ch] or amdgpu_gmc.[ch] and 
name it an amdgpu_ttm_domain_start.

> +{
> +	switch(type) {
> +		case TTM_PL_TT:

Coding style here is of, what editor and setting do you use?

> +			return adev->gmc.gart_start;
> +		case TTM_PL_VRAM:
> +			return adev->gmc.vram_start;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_bo_move_notify - notification about a memory move
>    * @bo: pointer to a buffer object
> @@ -1460,6 +1472,9 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr)
>    */
>   u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>   {
> +	uint64_t offset;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);

Better put adev first.

> +
>   	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_SYSTEM);
>   	WARN_ON_ONCE(!dma_resv_is_locked(bo->tbo.base.resv) &&
>   		     !bo->pin_count && bo->tbo.type != ttm_bo_type_kernel);
> @@ -1467,7 +1482,10 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>   	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_VRAM &&
>   		     !(bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS));
>   
> -	return amdgpu_gmc_sign_extend(bo->tbo.offset);
> +        offset = (bo->tbo.mem.start << PAGE_SHIFT) +
> +		 amdgpu_bo_gpu_start(adev, bo->tbo.mem.mem_type);
> +
> +	return amdgpu_gmc_sign_extend(offset);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 96d805889e8d..dfa4e75b95e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -294,6 +294,7 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
>   uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
>   					    uint32_t domain);
>   
> +uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev, uint32_t type);
>   /*
>    * sub allocation
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2c1d1eb1a7e1..3e65bdfca94f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -103,7 +103,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>   	case TTM_PL_TT:
>   		/* GTT memory  */
>   		man->func = &amdgpu_gtt_mgr_func;
> -		man->gpu_offset = adev->gmc.gart_start;
>   		man->available_caching = TTM_PL_MASK_CACHING;
>   		man->default_caching = TTM_PL_FLAG_CACHED;
>   		man->flags = TTM_MEMTYPE_FLAG_MAPPABLE | TTM_MEMTYPE_FLAG_CMA;
> @@ -111,7 +110,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>   	case TTM_PL_VRAM:
>   		/* "On-card" video ram */
>   		man->func = &amdgpu_vram_mgr_func;
> -		man->gpu_offset = adev->gmc.vram_start;
>   		man->flags = TTM_MEMTYPE_FLAG_FIXED |
>   			     TTM_MEMTYPE_FLAG_MAPPABLE;
>   		man->available_caching = TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_WC;
> @@ -122,7 +120,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>   	case AMDGPU_PL_OA:
>   		/* On-chip GDS memory*/
>   		man->func = &ttm_bo_manager_func;
> -		man->gpu_offset = 0;
>   		man->flags = TTM_MEMTYPE_FLAG_FIXED | TTM_MEMTYPE_FLAG_CMA;
>   		man->available_caching = TTM_PL_FLAG_UNCACHED;
>   		man->default_caching = TTM_PL_FLAG_UNCACHED;
> @@ -270,7 +267,7 @@ static uint64_t amdgpu_mm_node_addr(struct ttm_buffer_object *bo,
>   
>   	if (mm_node->start != AMDGPU_BO_INVALID_OFFSET) {
>   		addr = mm_node->start << PAGE_SHIFT;
> -		addr += bo->bdev->man[mem->mem_type].gpu_offset;
> +		addr += amdgpu_bo_gpu_start(amdgpu_ttm_adev(bo->bdev), mem->mem_type);
>   	}
>   	return addr;
>   }
> @@ -1136,9 +1133,6 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>   		bo->mem = tmp;
>   	}
>   
> -	bo->offset = (bo->mem.start << PAGE_SHIFT) +
> -		bo->bdev->man[bo->mem.mem_type].gpu_offset;
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 4cc7881f438c..e7a383134521 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -140,7 +140,7 @@ static void amdgpu_vm_sdma_copy_ptes(struct amdgpu_vm_update_params *p,
>   
>   	src += p->num_dw_left * 4;
>   
> -	pe += amdgpu_gmc_sign_extend(bo->tbo.offset);
> +	pe += amdgpu_bo_gpu_offset(bo);

That won't work. We need to add something like 
amdgpu_bo_gpu_offset_no_check() or adjust the WARN_ONs in 
amdgpu_bo_gpu_offset() a bit.

>   	trace_amdgpu_vm_copy_ptes(pe, src, count, p->direct);
>   
>   	amdgpu_vm_copy_pte(p->adev, ib, pe, src, count);
> @@ -167,7 +167,7 @@ static void amdgpu_vm_sdma_set_ptes(struct amdgpu_vm_update_params *p,
>   {
>   	struct amdgpu_ib *ib = p->job->ibs;
>   
> -	pe += amdgpu_gmc_sign_extend(bo->tbo.offset);
> +	pe += amdgpu_bo_gpu_offset(bo);

Same here.

Apart from those minor issue looks good to me.

Christian.

>   	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->direct);
>   	if (count < 3) {
>   		amdgpu_vm_write_pte(p->adev, ib, pe, addr | flags,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

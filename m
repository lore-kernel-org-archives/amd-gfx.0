Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1313FC352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13CD20714
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z30xo0Mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13CD20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D226EE39;
	Tue, 11 Feb 2020 11:58:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA706EE39
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 11:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9GZyZWTbL4rrlijgm3N7lPI43i4r7Sqbk0c0/LeVdOIebjsqCzhY3P2UfzEzCBf5lvg9NyYP88ENXSf9Q52JDsAN1Qruk6ZsGR46ZW2U9XTnxj+JIYJBKe0xQUs4x2s4G8s5Cb9W4/9g0M4o+oeV8+0Of31ihAiVEbwfoWv4P258JrU+iYKB3oAZAhZObokDqDtIm3ktzuXNDDBjM9ZOJiAmJY4YerlhpTcdTMTMv/CXnsXzvp8E9i6HxsHbXTJ7CItaOIAIS2MbhmChhKsQA4jPT1C/ihTrBcukHhZ1kn7Mx38rho7e5H4K8U+zMgancwkm4zNMyzSiq5p9zug3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHli+uh11OFeSUSu2LnaWCGHuZVF+jxIviiVaIS4ckI=;
 b=hVqo5O5ZH/VOVqt6V7AzN3uw3UF4ANubs0UPTHuar1zSWl33UDg7eG2xdqJr901UntxyzhuK7DAaDAXsTCMt3bzjmliM6DJvDl+EZrwkEFAKuYZGQM2xixwDLGDqevuQzh1F+CBWQCSsh5Y0v43xRkeBRug+rDBZu2Lqd+f4YH+8/QdevyCZm92LozDrxU0vGU5bBCLPnEi6xurdqsIAH6L+OPWzKsVdt4wJEXUWVjQDQK0G3EbkgWp5qCzuHMxYdjSS8uoeU6jK/tiqiG+nxXRFefxj2tvT9bY0qA8f7THpJGUsjFyUUvoI0QmEhXvl43E1zAvZBDk/u8h9iYifGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHli+uh11OFeSUSu2LnaWCGHuZVF+jxIviiVaIS4ckI=;
 b=Z30xo0MjPl/kE+AIPZztD9e973s/3Cr/i1cRaZKrqWtVvd6OeRbpAez49XAdMnX7PFv7xj2AA0e1ko1xY2gzgzSRSFwUI1RFvk8DpERWkkuqRhQLvlQ5KMHdPB/2zhlKMoX/nIFWrEqW8UaEaus+rOAEs78bVMz4/FfMSe9o+bo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB2976.namprd12.prod.outlook.com (20.178.240.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Tue, 11 Feb 2020 11:57:56 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 11:57:56 +0000
Date: Tue, 11 Feb 2020 19:57:47 +0800
From: Huang Rui <ray.huang@amd.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
Subject: Re: [RFC PATCH] drm/amdgpu: move ttm bo->offset to amdgpu_bo
Message-ID: <20200211115413.GA18019@jenkins-Celadon-RN>
References: <20200211111722.6372-1-nirmoy.das@amd.com>
Content-Disposition: inline
In-Reply-To: <20200211111722.6372-1-nirmoy.das@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR02CA0149.apcprd02.prod.outlook.com
 (2603:1096:202:16::33) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR02CA0149.apcprd02.prod.outlook.com (2603:1096:202:16::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 11:57:54 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2a5c282-7161-43a8-a5ad-08d7aee9a1be
X-MS-TrafficTypeDiagnostic: MN2PR12MB2976:|MN2PR12MB2976:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2976C463DB28E34C0647699BEC180@MN2PR12MB2976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(5660300002)(66946007)(86362001)(6666004)(4326008)(30864003)(66556008)(9686003)(55016002)(186003)(66476007)(8676002)(16526019)(81166006)(81156014)(2906002)(6916009)(966005)(33656002)(8936002)(33716001)(956004)(45080400002)(26005)(316002)(478600001)(52116002)(1076003)(6496006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2976;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbE32PJv+seFJDQZGUUcXS+Hoo9fR8beHy/yoUfJf2fB1BsM6/noU3oc3gIHkQMZ3krPMcJ0XUKeIZ7ExOYfqlBN38gEIUJ9WLEABd3yN6prVZmon7syYCc6DZ+5O5XGIbJuHYFDVVXT5e23TQ69zUeUknG3dAa9E6yV/krwFfMWh3tZGOrYY8eqsNlTT+OHOxMsip2PX3W3Gw4h4EnP4AZB6+wa6KDBqK6adqgwWB3q3PKBdGtyG64UrlBwePwqf7H0/TI3YSKz8zWxH0Qf2TAmh09OCpBsUnpqKc/tuYAAq0w7v1O/ZQonJ9SvyfZKaJNIvMUSwXmT5Yp/UADCkPIBVs6BzlSpw1f+55b1bO0ZcR6wpGeJmDTWJQKPzxw0uvsVjlN+DRzMgdaKWvUj0Ec7OyszyATDNQKbwzklKZyx9rjHG267f2y1UiNyMH8uYtz+SyBTSPeWp6ZEZOPWeqcnvOLIVby9XdgLnmX7ZmYUky+U52VS2t0eO712MAW/iLgw84oMIuGW8VZyaJrwVQ==
X-MS-Exchange-AntiSpam-MessageData: LdBLE5fHhXTg5Z6Pa/exh072UUpPPcpwc+GOzsqCxt/3XpfICMvR9wYtGKnszCrgwTnksA85xbI9Wwneftllepx3oncEiwLBKWoENQAQX6XN+67khExCgZ6pHZbCxx6IppElvcUjUkqW0ypyoRB93g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a5c282-7161-43a8-a5ad-08d7aee9a1be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 11:57:56.5350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spSE//N+Gepw3wdzBU3fR73UM2gyXgN08Csag1J8ba764ckKvh1Z9PScv7ERcalANsyGg8wvO8StwHXp4SCCtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2976
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 11, 2020 at 12:17:22PM +0100, Nirmoy Das wrote:
> GPU address should belong to driver not in memory management.
> This patch moves ttm bo.offset and gpu_offset calculation to amdgpu driver.
> 

Looks good for me. Yes, agree, the mc address should be got from amdgpu_bo.

Acked-by: Huang Rui <ray.huang@amd.com>

How about other hardware drivers which also use ttm?

Thanks,
Ray

> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 22 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_test.c      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 40 +++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |  8 ++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
>  12 files changed, 55 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 8609287620ea..613047ea9065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -263,7 +263,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
>  		goto allocate_mem_pin_bo_failed;
>  	}
>  
> -	r = amdgpu_ttm_alloc_gart(&bo->tbo);
> +	r = amdgpu_ttm_alloc_gart(bo);
>  	if (r) {
>  		dev_err(adev->dev, "%p bind failed\n", bo);
>  		goto allocate_mem_kmap_bo_failed;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> index d9b35df33806..f29986231b27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> @@ -98,7 +98,7 @@ static void amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>  		amdgpu_bo_unreserve(sobj);
>  		goto out_cleanup;
>  	}
> -	r = amdgpu_ttm_alloc_gart(&sobj->tbo);
> +	r = amdgpu_ttm_alloc_gart(sobj);
>  	amdgpu_bo_unreserve(sobj);
>  	if (r) {
>  		goto out_cleanup;
> @@ -117,7 +117,7 @@ static void amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>  		amdgpu_bo_unreserve(sobj);
>  		goto out_cleanup;
>  	}
> -	r = amdgpu_ttm_alloc_gart(&dobj->tbo);
> +	r = amdgpu_ttm_alloc_gart(dobj);
>  	amdgpu_bo_unreserve(dobj);
>  	if (r) {
>  		goto out_cleanup;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 80ba6dfc54e2..921719d92ab1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -642,7 +642,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  	if (!r && p->uf_entry.tv.bo) {
>  		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(p->uf_entry.tv.bo);
>  
> -		r = amdgpu_ttm_alloc_gart(&uf->tbo);
> +		r = amdgpu_ttm_alloc_gart(uf);
>  		p->job->uf_addr += amdgpu_bo_gpu_offset(uf);
>  	}
>  
> @@ -1676,5 +1676,5 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
>  			return r;
>  	}
>  
> -	return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
> +	return amdgpu_ttm_alloc_gart(*bo);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index ca9056b0472a..3d0aa2b2926f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -199,7 +199,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
>  		}
>  	}
>  
> -	r = amdgpu_ttm_alloc_gart(&new_abo->tbo);
> +	r = amdgpu_ttm_alloc_gart(new_abo);
>  	if (unlikely(r != 0)) {
>  		DRM_ERROR("%p bind failed\n", new_abo);
>  		goto unpin;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> index 143753d237e7..a02b1cbd006d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -174,7 +174,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
>  		goto out_unref;
>  	}
>  
> -	ret = amdgpu_ttm_alloc_gart(&abo->tbo);
> +	ret = amdgpu_ttm_alloc_gart(abo);
>  	if (ret) {
>  		amdgpu_bo_unreserve(abo);
>  		dev_err(adev->dev, "%p bind failed\n", abo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6f60a581e3ba..650758a5b3aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -274,7 +274,7 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>  		goto error_unreserve;
>  	}
>  
> -	r = amdgpu_ttm_alloc_gart(&(*bo_ptr)->tbo);
> +	r = amdgpu_ttm_alloc_gart(*bo_ptr);
>  	if (r) {
>  		dev_err(adev->dev, "%p bind failed\n", *bo_ptr);
>  		goto error_unpin;
> @@ -917,7 +917,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>  		bo->pin_count++;
>  
>  		if (max_offset != 0) {
> -			u64 domain_start = bo->tbo.bdev->man[mem_type].gpu_offset;
> +			u64 domain_start = amdgpu_bo_gpu_start(adev, mem_type);
>  			WARN_ON_ONCE(max_offset <
>  				     (amdgpu_bo_gpu_offset(bo) - domain_start));
>  		}
> @@ -1248,6 +1248,18 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>  	return 0;
>  }
>  
> +uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev, uint32_t type)
> +{
> +	switch(type) {
> +		case TTM_PL_TT:
> +			return adev->gmc.gart_start;
> +		case TTM_PL_VRAM:
> +			return adev->gmc.vram_start;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_bo_move_notify - notification about a memory move
>   * @bo: pointer to a buffer object
> @@ -1278,6 +1290,10 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>  	if (evict)
>  		atomic64_inc(&adev->num_evictions);
>  
> +	if (new_mem)
> +		abo->offset = (new_mem->start << PAGE_SHIFT) +
> +			 amdgpu_bo_gpu_start(amdgpu_ttm_adev(bo->bdev), new_mem->mem_type);
> +
>  	/* update statistics */
>  	if (!new_mem)
>  		return;
> @@ -1467,7 +1483,7 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>  	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_VRAM &&
>  		     !(bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS));
>  
> -	return amdgpu_gmc_sign_extend(bo->tbo.offset);
> +	return amdgpu_gmc_sign_extend(bo->offset);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 96d805889e8d..c7e1028fd31f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -94,6 +94,8 @@ struct amdgpu_bo {
>  	unsigned			prime_shared_count;
>  	/* per VM structure for page tables and with virtual addresses */
>  	struct amdgpu_vm_bo_base	*vm_bo;
> +	 /* GPU address space is independent of CPU word size */
> +	uint64_t			offset;
>  	/* Constant after initialization */
>  	struct amdgpu_bo		*parent;
>  	struct amdgpu_bo		*shadow;
> @@ -294,6 +296,7 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
>  uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
>  					    uint32_t domain);
>  
> +uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev, uint32_t type);
>  /*
>   * sub allocation
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> index 476f1f89aaad..dfab64bbb5fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> @@ -103,7 +103,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>  			DRM_ERROR("Failed to pin GTT object %d\n", i);
>  			goto out_lclean_unres;
>  		}
> -		r = amdgpu_ttm_alloc_gart(&gtt_obj[i]->tbo);
> +		r = amdgpu_ttm_alloc_gart(gtt_obj[i]);
>  		if (r) {
>  			DRM_ERROR("%p bind failed\n", gtt_obj[i]);
>  			goto out_lclean_unpin;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2c1d1eb1a7e1..15d9e8f807b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -103,7 +103,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>  	case TTM_PL_TT:
>  		/* GTT memory  */
>  		man->func = &amdgpu_gtt_mgr_func;
> -		man->gpu_offset = adev->gmc.gart_start;
>  		man->available_caching = TTM_PL_MASK_CACHING;
>  		man->default_caching = TTM_PL_FLAG_CACHED;
>  		man->flags = TTM_MEMTYPE_FLAG_MAPPABLE | TTM_MEMTYPE_FLAG_CMA;
> @@ -111,7 +110,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>  	case TTM_PL_VRAM:
>  		/* "On-card" video ram */
>  		man->func = &amdgpu_vram_mgr_func;
> -		man->gpu_offset = adev->gmc.vram_start;
>  		man->flags = TTM_MEMTYPE_FLAG_FIXED |
>  			     TTM_MEMTYPE_FLAG_MAPPABLE;
>  		man->available_caching = TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_WC;
> @@ -122,7 +120,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>  	case AMDGPU_PL_OA:
>  		/* On-chip GDS memory*/
>  		man->func = &ttm_bo_manager_func;
> -		man->gpu_offset = 0;
>  		man->flags = TTM_MEMTYPE_FLAG_FIXED | TTM_MEMTYPE_FLAG_CMA;
>  		man->available_caching = TTM_PL_FLAG_UNCACHED;
>  		man->default_caching = TTM_PL_FLAG_UNCACHED;
> @@ -270,7 +267,7 @@ static uint64_t amdgpu_mm_node_addr(struct ttm_buffer_object *bo,
>  
>  	if (mm_node->start != AMDGPU_BO_INVALID_OFFSET) {
>  		addr = mm_node->start << PAGE_SHIFT;
> -		addr += bo->bdev->man[mem->mem_type].gpu_offset;
> +		addr += amdgpu_bo_gpu_start(amdgpu_ttm_adev(bo->bdev), mem->mem_type);
>  	}
>  	return addr;
>  }
> @@ -1086,27 +1083,28 @@ static int amdgpu_ttm_backend_bind(struct ttm_tt *ttm,
>  /**
>   * amdgpu_ttm_alloc_gart - Allocate GART memory for buffer object
>   */
> -int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
> +int amdgpu_ttm_alloc_gart(struct amdgpu_bo *bo)
>  {
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
> +	struct ttm_buffer_object *tbo = &bo->tbo;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>  	struct ttm_operation_ctx ctx = { false, false };
> -	struct amdgpu_ttm_tt *gtt = (void*)bo->ttm;
> +	struct amdgpu_ttm_tt *gtt = (void*)tbo->ttm;
>  	struct ttm_mem_reg tmp;
>  	struct ttm_placement placement;
>  	struct ttm_place placements;
>  	uint64_t addr, flags;
>  	int r;
>  
> -	if (bo->mem.start != AMDGPU_BO_INVALID_OFFSET)
> +	if (tbo->mem.start != AMDGPU_BO_INVALID_OFFSET)
>  		return 0;
>  
> -	addr = amdgpu_gmc_agp_addr(bo);
> +	addr = amdgpu_gmc_agp_addr(tbo);
>  	if (addr != AMDGPU_BO_INVALID_OFFSET) {
> -		bo->mem.start = addr >> PAGE_SHIFT;
> +		tbo->mem.start = addr >> PAGE_SHIFT;
>  	} else {
>  
>  		/* allocate GART space */
> -		tmp = bo->mem;
> +		tmp = tbo->mem;
>  		tmp.mm_node = NULL;
>  		placement.num_placement = 1;
>  		placement.placement = &placements;
> @@ -1114,30 +1112,30 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>  		placement.busy_placement = &placements;
>  		placements.fpfn = 0;
>  		placements.lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
> -		placements.flags = (bo->mem.placement & ~TTM_PL_MASK_MEM) |
> +		placements.flags = (tbo->mem.placement & ~TTM_PL_MASK_MEM) |
>  			TTM_PL_FLAG_TT;
>  
> -		r = ttm_bo_mem_space(bo, &placement, &tmp, &ctx);
> +		r = ttm_bo_mem_space(tbo, &placement, &tmp, &ctx);
>  		if (unlikely(r))
>  			return r;
>  
>  		/* compute PTE flags for this buffer object */
> -		flags = amdgpu_ttm_tt_pte_flags(adev, bo->ttm, &tmp);
> +		flags = amdgpu_ttm_tt_pte_flags(adev, tbo->ttm, &tmp);
>  
>  		/* Bind pages */
>  		gtt->offset = (u64)tmp.start << PAGE_SHIFT;
> -		r = amdgpu_ttm_gart_bind(adev, bo, flags);
> +		r = amdgpu_ttm_gart_bind(adev, tbo, flags);
>  		if (unlikely(r)) {
> -			ttm_bo_mem_put(bo, &tmp);
> +			ttm_bo_mem_put(tbo, &tmp);
>  			return r;
>  		}
>  
> -		ttm_bo_mem_put(bo, &bo->mem);
> -		bo->mem = tmp;
> +		ttm_bo_mem_put(tbo, &tbo->mem);
> +		tbo->mem = tmp;
>  	}
>  
> -	bo->offset = (bo->mem.start << PAGE_SHIFT) +
> -		bo->bdev->man[bo->mem.mem_type].gpu_offset;
> +	bo->offset = (tbo->mem.start << PAGE_SHIFT) +
> +		amdgpu_bo_gpu_start(adev, tbo->mem.mem_type);
>  
>  	return 0;
>  }
> @@ -2149,7 +2147,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>  	}
>  
>  	if (bo->tbo.mem.mem_type == TTM_PL_TT) {
> -		r = amdgpu_ttm_alloc_gart(&bo->tbo);
> +		r = amdgpu_ttm_alloc_gart(bo);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index f1ebd424510c..4f6e7ef2b004 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -100,7 +100,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>  			struct dma_fence **fence);
>  
>  int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma);
> -int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> +int amdgpu_ttm_alloc_gart(struct amdgpu_bo *bo);
>  int amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>  
>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 4cc7881f438c..c810cda7a06e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -37,12 +37,12 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo *table)
>  {
>  	int r;
>  
> -	r = amdgpu_ttm_alloc_gart(&table->tbo);
> +	r = amdgpu_ttm_alloc_gart(table);
>  	if (r)
>  		return r;
>  
>  	if (table->shadow)
> -		r = amdgpu_ttm_alloc_gart(&table->shadow->tbo);
> +		r = amdgpu_ttm_alloc_gart(table->shadow);
>  
>  	return r;
>  }
> @@ -140,7 +140,7 @@ static void amdgpu_vm_sdma_copy_ptes(struct amdgpu_vm_update_params *p,
>  
>  	src += p->num_dw_left * 4;
>  
> -	pe += amdgpu_gmc_sign_extend(bo->tbo.offset);
> +	pe += amdgpu_gmc_sign_extend(bo->offset);
>  	trace_amdgpu_vm_copy_ptes(pe, src, count, p->direct);
>  
>  	amdgpu_vm_copy_pte(p->adev, ib, pe, src, count);
> @@ -167,7 +167,7 @@ static void amdgpu_vm_sdma_set_ptes(struct amdgpu_vm_update_params *p,
>  {
>  	struct amdgpu_ib *ib = p->job->ibs;
>  
> -	pe += amdgpu_gmc_sign_extend(bo->tbo.offset);
> +	pe += amdgpu_gmc_sign_extend(bo->offset);
>  	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->direct);
>  	if (count < 3) {
>  		amdgpu_vm_write_pte(p->adev, ib, pe, addr | flags,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6786d34f7d04..277dbc6ba8ec 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5212,7 +5212,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>  		return r;
>  	}
>  
> -	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
> +	r = amdgpu_ttm_alloc_gart(rbo);
>  	if (unlikely(r != 0)) {
>  		amdgpu_bo_unpin(rbo);
>  		ttm_eu_backoff_reservation(&ticket, &list);
> -- 
> 2.25.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C2d55974df6a543431af708d7aee3a25a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637170165033072494&amp;sdata=MXLAHsn8x4NFx8QUYQB6Vb%2B3lh%2ByW0oNs2TAnF5v1GI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

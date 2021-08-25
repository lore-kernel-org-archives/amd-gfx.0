Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5841C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 09:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E30C6113C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 09:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E30C6113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85B16E165;
	Wed, 25 Aug 2021 09:27:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7530C6E165
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 09:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPP9Dt9I041Bv7NFqqWNiTCh/P3gqca+P6FnKUf8fHMNV4SUeLZiVdMT5hVBw2+7cxDOGkjToySkptF+oeprMHirP1qX+qRmZc/5FROr3ROBSLZRV+hfJPyVdGvfy/9b65ucJeDqaixiRYB/gvwR0vH7F+a+QoJGRGBbigItXNebYP0rvJdrcsWH7RUn6iy6UCBhFnrUpoPNPC3sRsNxowt5yuJOOxm2/IbzaYIDhMCentfuLEZEq6f+d+3Ra8tMVVNaQ15E1oKv0lerQ8lC8OJFSAyKrtXame7U3Do9sMGJDQkOz5coRdPQGfFhkjPkDyi5skKvbkaKinSfZrJKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjtnnAQiBe/X2V58/biOxfbL7BaNUXYbjWTC2X1M5h4=;
 b=Q9oXUO+qbPuU6Iy/67uku4/LFRe3r4eG8S5mf241gsEyaHPf2XeHU/2Nphq3gqUOBgOjtwqCJol11ZMDQS+wU88bb7zeyvIzKWfu8webPs9HpwhM82ugCBDPsA3lmV9VjNOo4tEVwJXS/9TmW6ZkzjREIfg0bcVEo8sIvIxsTi/1in33YhKVAhTRT2riyqxclYKs/jTM9t3I+rwmFXye/OTQ4VgIYrKQXcvSmzzUmpF8JlE1RUlqxlVj7zpsOboe5Uq8VkqR8/vEzy+p/2a4H9fBJ3hsm4DOfiio4KYNryittGuqjZMH7nBesMPV8U7UTKdXJqYEfUb10pici8cqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjtnnAQiBe/X2V58/biOxfbL7BaNUXYbjWTC2X1M5h4=;
 b=LDUHQl+sMfXlVkHTKgi4//jc3Q/TCEzU3st+2efpxd6p9Lfj0/LFBOGXW+uMh3dv9KK4Wzqhu/qs+snz7z7JYNWIgNpIUUzAALECuq7X3fALVEVO7y0IvwNG9aebN0AsChJhvzggJXdKJvyD/jr639w2iWvgsMO8Cql9/aiY1Eo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Wed, 25 Aug
 2021 09:27:05 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 09:27:05 +0000
Subject: Re: [PATCH] drm/amdgpu: rename amdgpu_bo_get_preferred_pin_domain.
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210825091434.693149-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6ac81b1e-5d5a-2789-f123-73c7631bee96@amd.com>
Date: Wed, 25 Aug 2021 11:26:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210825091434.693149-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR2P264CA0020.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::32)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 PR2P264CA0020.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 09:27:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7c4c83f-53af-4af4-69d0-08d967aa80c0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42554718B8AD4011255ED2B283C69@MN2PR12MB4255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTLzR7qifkJgrtRS4PWs37DmrQAGoPFndZza5bz2eblEbJYjxfdV5vMJ2Sa+8cma7F8Hrv5/q6IoDn0RVhBB3YIYvWh3KNNWQMX5MOop3a1VuRet8SGTn0q1ElDTS+TL/W7A5PUQ+mHjYliWVQ0a82QItkyJXhiCKgLuntqy4of7sXraq1lWkhIpMu+omM7L0BzMVZqTkTOX1oJ8CruJOjwmwfHFhy99BUtuIFBaK4HOoV+TXC7MfO+3jxpWMHpiqimXOmN4lYsimoJmmGugB1md5Ua3YE/mZgA0ubTHtOoYpjhjhzj1HlDu9Lc0zf3CTXJGGzabfFjwY4/IZsEUvFr8lf3kUfStQsLVegNMwgBlJyYS6fP2QPHU+NVFPSUgaAImMONlvZgpRUePCBz4pch+A7Z7ERUWf/Zh1vI3/rxioVX9kP4ydHJI3If5B9qIjLpNQpiRYC/3bPt4flzuVSymtQDC9EXDiNBVAKas5WQ4l2+SRG+c3Q0fmvNvp9VBofu6nCPGwCx30IeIiTsFYX4iQoaJ3dBhUsADk0A6ULj+uiIxse2QVWJg7SoXEuBCkW5VsntOr5YwqTkNwN4pxGElXB8wihRO+sRxC9750UoXpqlOH3CfccegcUyXSGJBYQIt+4ihHsIiAWaTdqh6kxyiKtfL+qUDbo/jvyMXq/ll0HGwgqpHM46QJ4zU2yn/tM/Q+Og8cbftmZkCLursc9yz0dO1DGjSjL70CtksXYTfB+AOSkZD7aETzu+XpaYG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(5660300002)(83380400001)(38100700002)(26005)(66946007)(66476007)(66556008)(6486002)(36756003)(508600001)(6666004)(66574015)(31696002)(186003)(86362001)(2616005)(31686004)(956004)(2906002)(316002)(16576012)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdrbVNialJFa3F5bkg1dnk0OUYvUHdPSUNzRDUxRUs1S1JYZnpsdnpvUVg3?=
 =?utf-8?B?YTZaVjU2MS90VFpEaE1JVEZRVHJSa21PMFc0QklwRllkbThCSHpRd1NmOHNt?=
 =?utf-8?B?VmlqU2pXc3Z1dUdkVk02MzNCV25sODRJL3AzbTBEWS9ONXA2SXArc3lQbUxv?=
 =?utf-8?B?bVR2S3lIWE1YYnlXT0pVNjNkdDVGaGtMVlZVMWJOVGg2TDQ2dTFqZ0pKRis2?=
 =?utf-8?B?WTVtc0JCMDJWRFBTWk1Qdll2b0VlSS90TEl3NVlZbm1SQ2FoeVB0Y3kzeURi?=
 =?utf-8?B?TGhNNEFqVlhHMG0wOHppZzJ0MWFXZkdGRStTNFVpcWVSeXA1dmxMOHpwaHpP?=
 =?utf-8?B?bkdwN3cvdStEQURGS3dCdThlVE9qeG1SQjVLNkhKT0dPTmhmVCtnbjVUVzlz?=
 =?utf-8?B?MVpHdDZjcnRKR0VDSWZoYk5CWGR4T1MwOGRRU1lHeGh6SlJzY1AvVVd1TmFt?=
 =?utf-8?B?UktET1BOUlFUWFpxSGV2d2U1QmNkYTJLekxWNEJCZnIwaTFhTjRUQXo4cXA3?=
 =?utf-8?B?Z1N4bmZoSEY1WGhvY2p1UU1vSE4xaUVPdEhicjl0UDBuZWtwUlkxbVNncnkx?=
 =?utf-8?B?ZWRZbkQ0ZTkwMU5VUE9xSmRmQ0xqZUIxSzVuTGVmSGxZdjkrR0JVdGZQY1hy?=
 =?utf-8?B?bGJmcWpISkplVExLaTlzUyt5NFlqMC9od1NXUWVLbkVVeTk3Q2hRYmthZHdq?=
 =?utf-8?B?QXF1Y2RWenF2L09OcktLd1JXQmRURjAyMDV6VzgxbEpTMG9CZ1V2U3plNkcw?=
 =?utf-8?B?ZmJsRUN4dkNMMi91ajk2bW5kV2xzTnQ1M2xWTGtTMDBRNmJMWDJ3VVF1Qklm?=
 =?utf-8?B?eFBRTzUrWVJWU0pkQ2MwaHY4dWZ6alRCZXQ4WVc2MVdTUHpxejMvN042bWJj?=
 =?utf-8?B?QnF3WjV1MmppRDdpOHlnZXVwU1dScWdzUFNSTCtCeEM1NzlsTTZjQVJqQk5U?=
 =?utf-8?B?S0JHd3hDNnNhaFFUZE9nYlFYbG0zb25lc21QeC8wTGo2eXVVOHBhVkR4M3lG?=
 =?utf-8?B?cHBJSllSQUNYOGQ3eGtGTVdjR2pNMWwwQlhTeEZxN3dpb0hqNjNERG1LU3J1?=
 =?utf-8?B?ZU5sbHBWdWlIRHpCVzYrYi9OT2ZJakpuVytoV2Y0akxBV0lNK2RaM3UrTmVN?=
 =?utf-8?B?L09iQWlodi9YU0xWM3JCQVdpU0Q3d1VmRmx1UnpYTW95b1c5VTBQQzR6WDVU?=
 =?utf-8?B?Y1hQNGpYdmduZzNSN1F6REhvN1YzR1JzUVpOYjdabXdudGdTZHFvY3QvTzQx?=
 =?utf-8?B?M280VFF0TXkvVXAxc0lldHJ2azVRNzFmdzZTSWthaVFjeGJER1k1SXZLQzJJ?=
 =?utf-8?B?TWZaR3RtUnZ5ZFVjUXVkcjlNQTFMWmNRVUgzNVg4SXRaMjR2L0s3Ujg3b2d3?=
 =?utf-8?B?cDlYQ0YzbGtOV1ZEMDJoZjJpclU4d1ZpSXN6OXorT094VXRhdi9adGViR1Zy?=
 =?utf-8?B?OUxsblUzOWlCbmNGVXBlMVd6TWg4WHJOeDN2cXArV2IybDlVNUU3UUpCQ3k4?=
 =?utf-8?B?dDQzaUluWkJJejZPaDZvbkk0WFRHaHBxK2hEZERWS1JScGhPcHFuTTZOZzlL?=
 =?utf-8?B?a0QrcUNtdHZVa04wQ1UyOUdRZExyOWs4ODFTTU1QRFRBS3h4YW5mVzl5TVNi?=
 =?utf-8?B?aWFqQTRlZWNhRWFydHVaemxJaGxEaERzT0c1NE00NGFQNUJ5bmxFRVdpWVRr?=
 =?utf-8?B?STFFYk40bTRoTWZsb1IzUWI1WE10NVNPKzNzb3lNSVUxVVkwVVVQdkk1NXlT?=
 =?utf-8?Q?yU5vrvtsIGvUlBsqDLx1PD9c5w4BLtn+qhL63PM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c4c83f-53af-4af4-69d0-08d967aa80c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 09:27:05.3629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abJe1p231GvhEtZ74/oGOLC65bY2mzQXexLFdFut8hWCd8HEB2IJ5ssXa32UEiCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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

Am 25.08.21 um 11:14 schrieb Yifan Zhang:
> amdgpu_bo_get_preferred_pin_domain is used for page tables
> creation, which is not involved with page pinning. And it is used in
> more cases than display scanout, modify its documentation as well.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 2 +-
>   4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 9f952b7fc197..85b292ed5c43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -903,7 +903,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>   					 DIV_ROUND_UP(args->bpp, 8), 0);
>   	args->size = (u64)args->pitch * args->height;
>   	args->size = ALIGN(args->size, PAGE_SIZE);
> -	domain = amdgpu_bo_get_preferred_pin_domain(adev,
> +	domain = amdgpu_bo_get_preferred_domain(adev,
>   				amdgpu_display_supported_domains(adev, flags));
>   	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
>   				     ttm_bo_type_device, NULL, &gobj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 22a1344082d3..65a9b23f0a46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -947,7 +947,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   	/* This assumes only APU display buffers are pinned with (VRAM|GTT).
>   	 * See function amdgpu_display_supported_domains()
>   	 */
> -	domain = amdgpu_bo_get_preferred_pin_domain(adev, domain);
> +	domain = amdgpu_bo_get_preferred_domain(adev, domain);
>   
>   	if (bo->tbo.base.import_attach)
>   		dma_buf_pin(bo->tbo.base.import_attach);
> @@ -1518,14 +1518,14 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
>   }
>   
>   /**
> - * amdgpu_bo_get_preferred_pin_domain - get preferred domain for scanout
> + * amdgpu_bo_get_preferred_domain - get preferred domain
>    * @adev: amdgpu device object
>    * @domain: allowed :ref:`memory domains <amdgpu_memory_domains>`
>    *
>    * Returns:
> - * Which of the allowed domains is preferred for pinning the BO for scanout.
> + * Which of the allowed domains is preferred for allocating the BO.
>    */
> -uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
> +uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>   					    uint32_t domain)
>   {
>   	if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 38c834d0f930..5d746007b317 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -334,7 +334,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
>   void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
>   int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
>   			     struct dma_fence **fence);
> -uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
> +uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>   					    uint32_t domain);
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0b893aa21ffe..6b15cad78de9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -926,7 +926,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   	bp.size = amdgpu_vm_bo_size(adev, level);
>   	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
>   	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> -	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
> +	bp.domain = amdgpu_bo_get_preferred_domain(adev, bp.domain);
>   	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>   		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>   


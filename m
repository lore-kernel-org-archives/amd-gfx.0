Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918B0C433E1
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 21:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65ED620792
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 21:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LYY6pQrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65ED620792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123D66E067;
	Tue,  4 Aug 2020 21:19:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B936E067
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 21:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHujaib1+GJ01RSA6fqxrPdxafj+jHOfkWX3JD8K2HHC3J+YrSlSdl/S1ULsewzflIsAs6Q3xrvqT4SBVsp+H1qz2vf2YVTy2Uo0cJTMLJwyjDfBD4NlViTXCWEyd5Po3kPDqCAiOLIwwHxKmDJ2fxz3PjrAf0fg89jkPrbw5nPAv5/0kLIk0k64hwclnJZxSaNHzWPlCRprklqOxzjTWM2wxOHnzYzYATgeSNvn6vBykOffrxyUDxqTdhP+6CY28qByivFMQ3JaBG7t9LVBfkOMSEy8ZteYRckc4oy9sv7s7UiS5gGl1At5XnZZim7mZw+0xsM2mK1Ys82aD6X4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ejzxvvabwjjjlOVvQMzBvOjEOmPovtZV8nH7pUBj8Y=;
 b=D2ivz+YwB3d4+f1N4KwdVv6ED6Ch6CgLfcdGg9IcqB3TNDB0WuRNOJvANjuqUW45FMydqcGGXeFVF6EoTso6rJIDXEC/nzSt4vr9tPIBfrYbceqhX2W2JhR9YgTfb1FiirtlXRgyzGq+arQEaYAlvUsJSahdci0sf1jtI7m1aGQUXlbuz/wMpx87T8uib3i146B0kmTSDMRHNT3VRy5HIjgr/m0o10WG4JkONyHvfFNxzhjn7Nut+fi6itGACJtHh5pcdurTIAo+jFfTFwpTNLXv5D+nJY0AM82vGWM/6LqFO2Ct5GUrt2uSWph+hKoUVciK2tXSNIhE8g7aO2J6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ejzxvvabwjjjlOVvQMzBvOjEOmPovtZV8nH7pUBj8Y=;
 b=LYY6pQrldIMh6b2LXy9+QJUpKje2CVAMHNTqcyM3+y0HxVwpZEK11BJ2cDJX99494nHt8P8x4Og6nL1mwcb7MjbtAiiLt5QvehIIDpNMm5QIliRGa9IH3es0JsIyRd2hAnPuzhpFE+K95EDJcALdMMsSXsgiRxMsG2AbbpyHJvA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Tue, 4 Aug
 2020 21:19:01 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9%7]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 21:19:01 +0000
Subject: Re: [PATCH v2] drm/amdkfd: option to disable system mem limit
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200804204237.26231-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <377d09e5-0022-e36c-2e77-620d91c13c3a@amd.com>
Date: Tue, 4 Aug 2020 17:18:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200804204237.26231-1-Philip.Yang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::40) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YQBPR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.18 via Frontend Transport; Tue, 4 Aug 2020 21:19:00 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 064384db-3510-43a2-bc46-08d838bc01bb
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382CEA9FF3A003303FFEC03924A0@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JomjsLtcbZ9ytxGsJ/rZiz9RXYWDAC/k3NJIV2cdNkeGYssA+llficTxLe7P7srZMnPpprtQ+yV+Ihs6Lf0xa9ahOJ9EwrgHZiFAScjtDf9VTd+R/DO95OoyKh2LisWM89DovFzndCsFFfTolnQgy7Hu+aWIIy9AncT3wgqcaAEaXK4RGe44bDGsLGnAjERZFxPRDD5VAHcCZ13BFz9lmgDECh06pCgy+MEbDpE9HqhVQ+/4OHxrDpN/sGwKFC1jaiPKMkvRmx6zEy2T9kv4MVDs0MguS1bUBrbRsk/CK3p/7Rf2jUoU3WtuTqyUnCblBn5isuyXSuUiCIcjtD+t7ix70zHZfvjSM1Zw5i+wE/gZKHuojqsCjg15zYyjIwIU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(316002)(16576012)(8676002)(2906002)(6486002)(16526019)(52116002)(26005)(186003)(478600001)(8936002)(83380400001)(31686004)(956004)(5660300002)(2616005)(66946007)(44832011)(36756003)(66476007)(66556008)(31696002)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YNx9H2/JIfppfMm/cMaE4DVB/wgz6hN2+Bpq0QWxj4hZ/h77KgW/iFppFXGCFuhp82l/8o9CZysOFJ6QU8lxx+MqMwBjheQpPnqd0KWAZ/w8dgcrfPb1k8hvCTapGb+brAxtrgHwpWzRaRhBcNMsdd6a3sGHjCBwFlKJM/0duLgmv1C5DefqA2tKdFNi6t3fzel9OueN3dqzsivC6Z0AoLE0WenSQgXkD3UTLY5jSlQP/H0005mA9Gy+hOmvx9GBq27wgaja9zIlRSl10NHmfIntVZZQBDo0CRzMFIU4LrdS7cx7QPZvpbvSWqhmbwXtBfbILQEC/0uUjyl9g3ymFrqM7mLyvmkxutRvZGayyJL8T9WTRGwvtMHKp9/KISPQnGNGGR2rDnhsZBb4pbbMF/zP851xqFfpd2ATkaSTinrxoWRyEszCVUofGZHABehBWqI+i87a+P53Nd8lJiADH8QOcaPJPA0+yiI5tJqwhlCv2hTX8Xqj5L2d3TsIozgLa77w2Pds3fxTBD5yWcvUC1r/tnF+OVyzRWI7ML90YAAzeYpmhePylv4Ye/yyczNlUoQq5UUlb4aT6t5Ch7RL1uT1lYVn3TuntAkvFAT0CAR3TDl6o+3Tl7ieg9dKeAAnZ6w23mTwshU8wuqjFPKkkQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064384db-3510-43a2-bc46-08d838bc01bb
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 21:19:00.9691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QXiHnE4xnqZGCw6G+lh09+AMI1w+eMOu1FyHPrv3EJiz3uag1DP0j4TSjEzf+AGp6ZRwGIyiefVK9LAIGs9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2020-08-04 um 4:42 p.m. schrieb Philip Yang:
> If multiple process share system memory through /dev/shm, KFD allocate
> memory should not fail if it reaches the system memory limit because
> one copy of physical system memory are shared by multiple process.
>
> Add module parameter no_system_mem_limit to provide user option to
> disable system memory limit check at runtime using sysfs or during
> driver module init using kernel boot argument. By default the system
> memory limit is on.
>
> Print out debug message to warn user if KFD allocate memory failed
> because system memory reaches limit.
>
> v2: support change setting at runtime using sysfs
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          |  9 +++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4e8622854e61..0459e53f5917 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -188,9 +188,11 @@ extern int amdgpu_force_asic_type;
>  #ifdef CONFIG_HSA_AMD
>  extern int sched_policy;
>  extern bool debug_evictions;
> +extern bool no_system_mem_limit;
>  #else
>  static const int sched_policy = KFD_SCHED_POLICY_HWS;
>  static const bool debug_evictions; /* = false */
> +static const bool no_system_mem_limit;
>  #endif
>  
>  extern int amdgpu_tmz;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 8703aa1fe4a5..be29b1e8606d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -136,7 +136,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>  		ttm_mem_needed = acc_size + size;
>  	} else if (domain == AMDGPU_GEM_DOMAIN_CPU && !sg) {
>  		/* Userptr */
> -		system_mem_needed = acc_size + size;
> +		if (no_system_mem_limit)
> +			system_mem_needed = 0;
> +		else
> +			system_mem_needed = acc_size + size;

This will give incorrect results if the user changes the setting at
runtime. It would be better to do all the accounting correctly but let
the module parameter only affect the condition that checks whether the
reservation is OK.

E.g.

        if ((kfd_mem_limit.system_mem_used + system_mem_needed >
             kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
	/*                                      ^--------- */
            (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
             kfd_mem_limit.max_ttm_mem_limit) ||
            (adev->kfd.vram_used + vram_needed >
             adev->gmc.real_vram_size - reserved_for_pt)) {
                ret = -ENOMEM;
	} ...


>  		ttm_mem_needed = acc_size;
>  	} else {
>  		/* VRAM and SG */
> @@ -148,6 +151,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>  
>  	spin_lock(&kfd_mem_limit.mem_limit_lock);
>  
> +	if (kfd_mem_limit.system_mem_used + system_mem_needed >
> +	    kfd_mem_limit.max_system_mem_limit)
> +		pr_debug("Set no_system_mem_limit=1 if using shared memory\n");
> +
>  	if ((kfd_mem_limit.system_mem_used + system_mem_needed >
>  	     kfd_mem_limit.max_system_mem_limit) ||
>  	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
> @@ -204,6 +211,9 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
>  	bool sg = (bo->preferred_domains == AMDGPU_GEM_DOMAIN_CPU);
>  
>  	if (bo->flags & AMDGPU_AMDKFD_USERPTR_BO) {
> +		if (no_system_mem_limit)
> +			return;
> +

Same as above. This results in incorrect accounting when the user
changes the setting at runtime.


>  		domain = AMDGPU_GEM_DOMAIN_CPU;
>  		sg = false;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index a252450734f6..d3bd7a7da174 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -717,6 +717,15 @@ MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1
>  bool debug_evictions;
>  module_param(debug_evictions, bool, 0644);
>  MODULE_PARM_DESC(debug_evictions, "enable eviction debug messages (false = default)");
> +
> +/**
> + * DOC: no_system_mem_limit(bool)
> + * Disable system memory limit, to support multiple process shared memory
> + */
> +bool no_system_mem_limit;
> +module_param(no_system_mem_limit, bool, 0644);
> +MODULE_PARM_DESC(no_system_mem_limit, "disable system memory limit (false = default)");
> +
>  #endif
>  
>  /**
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

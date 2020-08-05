Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF7EC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 00:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9010720738
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 00:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j/cSDPOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9010720738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 438D489DE6;
	Wed,  5 Aug 2020 00:55:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E2589DE6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 00:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkqHYT6z41oGn6NDFxXzrbnFaczq/rLsYCkpAZt6/8y07XJEh3EuUrCAOtl5NGcKSgV5hOtITFBGxtW98y30byEQEyn9GTkdiqGoLtsLdTE7QVSl9WG6MnM1CToDyybqVsMgAxDLPwoP6rH3XWLf+3J2GZzfGLwYpNQiTPVfenb3Bjk42NfHS6bSDqjobaUNPyvzC3qZuh45MQzggFYcUz5kXJEh2WKY53TYOWVgcs1o3S9HHlM/US9GErlKv6yuaeyUYL4DhxMt3KSLXXAKFEhaUMwIKmR41myIuYCtO1cKS92UDej0P8JWif5AsWA8HIdIPp/B7eh2mgf0lBC+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DikJZMMdlzRdoynalK25bpeQtOStoacvZeajNc5mwAA=;
 b=CUUc1jcI1mCrk/4Bw6yy9sosF8X6bCLYBiyVJR484YkGPnkV0P336Z/hCSav2JmucrRfzVLWsWnRlznW2IaJ125QYPRymG218CdTagdhGTaGQBpSfuFYnuCL33pJS6q8U05mTx0EIT9/3QvhHu9GI8ZuFcEHRenaT9xOzniYIxbgT23n+YewZp1imCrWO3bD/HHSjQXHu/mOucBejk0RBH0SvK82nlFCx/9SfsptKokmHi/3qvr1Pq4VQjAEZf1LU965n66v3jcHYHV6VosIIo2l6TZuMedc4dvhRQ2xJNRKcsm5mr8E/OUz+KAO/ActUjskKKUVPWmu1w2LCGOB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DikJZMMdlzRdoynalK25bpeQtOStoacvZeajNc5mwAA=;
 b=j/cSDPOlsSKXG4Eg+TaNx0kcdmafile4lk7FcsQaC9g0Unn1XrYf5kZT4aURw+qaLufu+bnuanSIyroLUSUnq8VAT4uCDrhBDHPzlIbDY1wnd5rYZmGH9GEkrJFmatVuUZ94Xx0iErrWvTShGEiNkPErKDVdxc6S9TxhzFlL4BA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 5 Aug
 2020 00:55:17 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9%7]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 00:55:16 +0000
Subject: Re: [PATCH v3] drm/amdkfd: option to disable system mem limit
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200805004338.18090-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <0e9fab32-6203-e143-e57c-fb79356c45d4@amd.com>
Date: Tue, 4 Aug 2020 20:55:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200805004338.18090-1-Philip.Yang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Wed, 5 Aug 2020 00:55:16 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aaa96ce6-425a-4ef0-c47f-08d838da37f9
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27190DB974625273CAD495E2924B0@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZF+fyShTgHLFR2Sgh9ktJzL37xgphLXnTuI0ZNbTDOEq9dLjD2UWZulDyhVlUee8eFPDsUYhikUyA242nd8mJyBuEUM8Q0O/6WF0BW2APvluE2pk3r9euszEhoyD584TGXLt8xfAujHekzUIpWzGrrTlFP7Ek11JH5Qj/oOJBtHAYOjVN4qFhAzQqFnWmrj6WSboWGltk7Q7rMGvOojJ00yACTraZvs4uLwW7wVaDV27agixf4fgFYKdXpfRrPJiueQpSX6tE+Msh3nriZTjmhJHGJUHDoJgftGSKRPmNa5ct2uA5CIX7KDOZit30vhHZcv+58XIczLaihv53kG/tNMidl2UKpu6mSMmTfZQX9CEc6IkdIF+HruLYb00BuU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(478600001)(956004)(5660300002)(2906002)(31696002)(26005)(36756003)(44832011)(86362001)(8936002)(31686004)(6486002)(8676002)(2616005)(52116002)(66476007)(16576012)(16526019)(66946007)(66556008)(186003)(83380400001)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TvE0eAtUPfFU3vYNb8JP0JeTRGjZtlJah0YZSQkx1LH/aaADqNiDQyGvcY4jra1ENw590Oe/PHJ+e3pMzcXRIW0nDLp/9LwGsuwhWwRioYxQvOIoto/VoOaEzO7dCpTKfzhomFd8wZa4uPLT2evgSmVBpcKzRzOcaN8FLj8EcEubdef83sU5/1A32tL6KzGPB1VsVrmCoFd/2/RUl7sdCAcRuYVCTH5TwXsHTWHUms/BMwW6/wAGrPNkX5+6+1DDH2G3jJfbBFqMoLhXyF8Ox/BEHLAD/MWolgfEHaI5paz5RLi6fDm+SVYbZUF7R5j55kwvvOAF9WBCupqbgTIwgE0/QxmkELtFFF/jaMgJTxSU/WdbklJkdS7mJT8iQUysyiieWYBs00xVZR6nvmVIPA9zlM0PUvDx6MhSa7SFv4EpaqzOB2nUuEq7ZsEROEOMJqzj5w4EsVAVNJexYfLeiRDcL3+IRTVxAYtZrBE46/Gg9qMm9xLdBiG64+ry/0G3R3/10NYptv/Fm8wokFt1Qr05iFRiI/ECkooXAxT/PI26q5LaeH+IkZqy9oN67LMXuZ/RKso4a/a6lPpf7+ozyYrEQGE5BENu+eG/6n96oRPn7GuSXkahMFV0Pd4+I+p+EI1hQ6jKpjK/tySPoB7TMQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa96ce6-425a-4ef0-c47f-08d838da37f9
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 00:55:16.7745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rruUdf+jOpcrppVrY6vA+bT6Q7yyMLhZkgVsfGVcoapBxiEKx5H8ricXoJXOYTNnwloFRY5M/MPMnYD5Bl8+kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
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

Am 2020-08-04 um 8:43 p.m. schrieb Philip Yang:
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
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          | 9 +++++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
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
> index 8703aa1fe4a5..0d75726bd228 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -148,8 +148,12 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>  
>  	spin_lock(&kfd_mem_limit.mem_limit_lock);
>  
> +	if (kfd_mem_limit.system_mem_used + system_mem_needed >
> +	    kfd_mem_limit.max_system_mem_limit)
> +		pr_debug("Set no_system_mem_limit=1 if using shared memory\n");
> +
>  	if ((kfd_mem_limit.system_mem_used + system_mem_needed >
> -	     kfd_mem_limit.max_system_mem_limit) ||
> +	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
>  	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>  	     kfd_mem_limit.max_ttm_mem_limit) ||
>  	    (adev->kfd.vram_used + vram_needed >
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

Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F398C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 16:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5415A207FC
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 16:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IKj7sfSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5415A207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4216E492;
	Tue,  4 Aug 2020 16:57:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19AD6E492
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 16:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/02Mw758yeA/4uQkEDlHQX2B0EY2h4C/qAaJu4v4ajqgO7AIeZzntL4CfVQOY8eNLOKkINIPL6RIUfAOsUJQT8Ig3Wqc2aAOeqSJxqIEJef5fIWzfWkb389klFbYWr1S677LoKcW1i8IK7LlxLobfovE9073tdygfz15QFLRVsbTz2eZni+wQ/eAS+LaFs5brneVLVhBURUzLtioatBj7tnrsiWcX+FUyleG0s2Tce+1A994mSqvyKw7B7X7SRspvoFCUo9c8DpINgcmvCR52jlKgGoFk7tHdFyEjlbdQXO1ac/2eqSs3V8jUwNW9RhwGeU5UYndm1ljuFxW1NJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUgufHhTHih5Jo2JLYzJq9jkkF98c5yhOVyRBH9QrA4=;
 b=hRFsmA02NAhRSKwmZWtHNnkqz3SwZh3rjMJ/0273KOZzohWteRYaXisZYLU3z4jmJm5t8PrtyIXpzK3aCmxkN4sY7oDvK4YIAG6YDb6qltRgXh0bKgrCC8RsvIVpRq8Ob6a6ZH6seKvX3sEKxkhEbUJp0MGE83JpWyWWjqxeDBexu6dX+3qbeLkgRR2HbFIF1zzkqlnJu1zm7d+qTbDoAnkrhoVkG40XdCAxAVMvGipfsFlgHc8yMEeeqbjllCSrjv43B4qSvfqMwxLcVYc1zlwc2wdb15hOei9NG6cvfXCVFj2Oer94GIWHW+el4r6yYxohEwJ/xLM0Xg5BtnuHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUgufHhTHih5Jo2JLYzJq9jkkF98c5yhOVyRBH9QrA4=;
 b=IKj7sfSjaCmp0ONEA7a4O6v878T6vwy/Nd6T05YlH7ifz2bLn9g+0K24kuNvz8AfkBvT7m4v0BoFiHKbF9bNags3pP31q/1KQu2sS493njgg1WLXyTS86uxg71EXh6iBYRd8j360mAKYCax0zK9LoFQF5Lt28jPHaaQQtiNpX+o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Tue, 4 Aug 2020 16:57:34 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd%5]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 16:57:34 +0000
Subject: Re: [PATCH] drm/amdkfd: option to disable system mem limit
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200727132455.26657-1-Philip.Yang@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <bb8b6659-6afe-01b7-0981-b5ebef676e68@amd.com>
Date: Tue, 4 Aug 2020 12:57:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727132455.26657-1-Philip.Yang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::47) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTOPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Tue, 4 Aug 2020 16:57:33 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9031c543-c1f9-4420-617f-08d838977b88
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3115C0B550D5D40B89AEEA54E64A0@DM6PR12MB3115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6qqhakC8UHiwJim6BB93uCCY2z8NHAXEOjZZSZZqM8Dx1ssIMlL4e40iP6tHQT7d3sw1CLE2CkofEiIDtO/X6i3pKYqGkrDGgzrRNDbGTBR8PsKAykh4h4ELyvwzwjSNPl656R9y8bMwRGl4d6vbsh3d5NKRxTLPhecBCQKQ1EZT/hC6gEimXDwQILCLWG7I8G1ffGuhAnjtN+pOSSSNolxT75TPezAmw71jTnCYlVBrcDrrHw8M7Bk/CkBCqdF/xoG6OvrD5vS5+w0qPuzusOsXU32e1XE9QI/AHCuKuF07SoUxSzU75dGWttLKBHEWVmzdQAqEI2yV2JsjBCwCjKFQn4gyCqg+O0IO+atP/+ITAIPXSrVYWbANglEGWND
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(31696002)(956004)(2616005)(186003)(16526019)(66946007)(66476007)(31686004)(26005)(53546011)(66556008)(316002)(8676002)(6486002)(16576012)(8936002)(5660300002)(478600001)(52116002)(36756003)(2906002)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OzvR1ejI7ZBqIX8zZE252UYsE4SmtpgkhfjarINtdic+3bvf7TN3nfmoBvVYthN3Lj9oVkVnfDan57/KZ/671esnWK4UZ8163pOBLvOIc4jUyQdfnUZi+Gpm8INS61O4sz3uKcRYSRZU3N7D+VtwSp+iE8HmywRiVIe0qgAcsfLLJNrQP2TRENLqfXKv+JBpzEe4XzaFM6g8y+8BaLK6QM3MwbjtoDOWOCTv0g102w5p3R19M7aBHes055P7/OT2V2+IP2uIt2XchFlUHsxOZXnEVuEfmJTEcbf8ywOgHBtr5Lw+nBSXvvoql4iIi6yppNXxyrAT42YVym8QASyPBT195p1Mp/876l4h1x6pMWSCnu7ZE9qPgD6yKFaA3la3+d/Iq4telwGRSKDD2PTzvhHcpN20UplQqrKoZnXfH3fejZA7lCNpzX9aXQzPo80JVJ7Dg3Qy8+cbCBRYXe3aNHHD8U+Bl7rQJp+z0mEoerXVeticuxDX9TtYGsf7UAIX/q7Cb2gLIdApA5dP29dw+bVLEWa2E7JZSRyW2XxY2BveWK0phjNmhN2guzuOyR9VJ0S90W5GqEAlumIzjsKyZd7up82BTHoDunXj6BDiHvxIbJURyC2R3uiItLfwuHHX8/b7758cIljUJNh6IbVSkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9031c543-c1f9-4420-617f-08d838977b88
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 16:57:33.8406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWZJjjLfRPj7SahAsqe9Xa1awU9SmGjlAI3WEm+7hzlo/cCjYbduSwI9W2b+WkNW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
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

Ping.

On 2020-07-27 9:24 a.m., Philip Yang wrote:
> If multiple process share system memory through /dev/shm, KFD allocate
> memory should not fail if it reachs the system memory limit because
> one copy of physical system memory are shared by multiple process.
>
> Add module parameter to provide user option to disable system memory
> limit check, to run multiple process share memory application. By
> default the system memory limit is on.
>
> Print out debug message to warn user if KFD allocate memory failed
> because of system memory limit.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          | 9 +++++++++
>   3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e97c088d03b3..3c0d5ecfe0d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -187,9 +187,11 @@ extern int amdgpu_force_asic_type;
>   #ifdef CONFIG_HSA_AMD
>   extern int sched_policy;
>   extern bool debug_evictions;
> +extern bool no_system_mem_limit;
>   #else
>   static const int sched_policy = KFD_SCHED_POLICY_HWS;
>   static const bool debug_evictions; /* = false */
> +static const bool no_system_mem_limit;
>   #endif
>   
>   extern int amdgpu_tmz;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 8703aa1fe4a5..502e8204c012 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -99,7 +99,10 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>   	mem *= si.mem_unit;
>   
>   	spin_lock_init(&kfd_mem_limit.mem_limit_lock);
> -	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
> +	if (no_system_mem_limit)
> +		kfd_mem_limit.max_system_mem_limit = U64_MAX;
> +	else
> +		kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
>   	kfd_mem_limit.max_ttm_mem_limit = (mem >> 1) - (mem >> 3);
>   	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>   		(kfd_mem_limit.max_system_mem_limit >> 20),
> @@ -148,6 +151,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
>   
> +	if (kfd_mem_limit.system_mem_used + system_mem_needed >
> +	    kfd_mem_limit.max_system_mem_limit)
> +		pr_debug("Set no_system_mem_limit if using shared memory\n");
> +
>   	if ((kfd_mem_limit.system_mem_used + system_mem_needed >
>   	     kfd_mem_limit.max_system_mem_limit) ||
>   	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6291f5f0d223..e9acd0a9f327 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -715,6 +715,15 @@ MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1
>   bool debug_evictions;
>   module_param(debug_evictions, bool, 0644);
>   MODULE_PARM_DESC(debug_evictions, "enable eviction debug messages (false = default)");
> +
> +/**
> + * DOC: no_system_mem_limit(bool)
> + * Disable system memory limit, to support multiple process shared memory
> + */
> +bool no_system_mem_limit;
> +module_param(no_system_mem_limit, bool, 0644);
> +MODULE_PARM_DESC(no_system_mem_limit, "disable system memory limit (false = default)");
> +
>   #endif
>   
>   /**
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

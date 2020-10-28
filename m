Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2B1C55178
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104E424694
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PcN2pW8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104E424694
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38906E563;
	Wed, 28 Oct 2020 15:12:26 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760075.outbound.protection.outlook.com [40.107.76.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8956E563
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 15:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LV51wuBG5+BljsahNzNmXp26Y4UwEKdHi1hG19zjn3r4cht7FP+i1gT3YRBaePv05NWw6zBvxi4TpY+uZF1ZHkTdEELHoxjLjA9koDc++xgLV1CIYto38R3A0AmQaxVkHIiord7wBXWWkWPNT6u/pKF4BppkrGqWDuIkgb8vQByxm4PNaITt7wnVOX/0MBV+kVZ7y2U2HcDn8tfWIpCSQIe1LQZmn3Q0+yxUZZ8/cHVBJPboVodsYyKjpsCZrE2SatEvPfWe+nWqzPW6k1s6PQmHzO4dQ6OWAq6LP+24AMIkmOc0knnZeRwhOhbz+VLV2xzI40QgAgJXb1HAqrjjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15UAnO3Sul7q/augx0c2Kv7madwbQqf7XpkSJs2nJZY=;
 b=fWDFhHprhNscfbNMikr0eWDmJAlKkXYpQlzCn/1Iux+zolpTlJUxYXH5XXo6bVYN1Yyu2o5Sk0+Ye9s0g7fultvKj4ZnbdHAq3FUEHcy9uLJNsUC+/ktK3xrF6MRo93CQ7dAfH918vzNQaLw6yjZbZCNha8r5SbJOYoPXHxX8blMTPgpZvOeNUxPKI5JgJVpkbZ0kAysaCy7d4/VqCnXo+sY8tgyECl2v02MvPw1Pd2kvDtCSovRbmBjNEQK0bOFEqo1k6Jh9pgyb9mmuUgG1MNKXh+fVErXFBnNdF1xv6hT7+tipzrUoy8qJRNicGhRDyvngoUEuWEjRbtynevdmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15UAnO3Sul7q/augx0c2Kv7madwbQqf7XpkSJs2nJZY=;
 b=PcN2pW8pxWy/RfBpl1mvNjRmykdJT4dBHkAUCjUknPh8siXOkYK1pAZbbTwH4E/W4XLoxa+Ico12ydREbVs9aakbRyxXjRm1JDmFpLUT+ghhO72DA9cYP3QgamXl7P2cLkho5+lGMoudQKyh5wFYXdKfrWcAGF4rjoNxyqEKhX4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 28 Oct
 2020 15:12:24 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3477.029; Wed, 28 Oct 2020
 15:12:24 +0000
Subject: Re: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201028145502.2703-1-alex.sierra@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <514739e3-1fcf-6dbb-0dd1-3ea91a54c838@amd.com>
Date: Wed, 28 Oct 2020 11:12:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201028145502.2703-1-alex.sierra@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 15:12:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7695f95a-4540-458b-b97f-08d87b53dfce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45300820CEA24659DDF649B299170@DM6PR12MB4530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/y5l+W/iV+4YvW7h5xJEZ2gQfgLZaAy9C/tyC6vktiSXCCPgrnjWIjVZOj/kBi0hC+nNjRanrauKELjfoDDh8LEfUZyxOkIUPA5EVso3GdDCx72kARu2wboIApexYmTqZ64Kt4HnuZgnJP99sizZlk0Lj8rzOrdE4BBpgN3AH/jrbasveFn6q/on6wuBfQ5ZwXi0yaCo3RQZG/+7w+EvFeydZ1FX6TIQ0Vpvo+hUwwPvY5WVKZiBs/M9mo0gKzgCau9te/dndR/5cKa6RviWrfoZdhQuecw4toIYC8gg9K7AgVkVmG1pRvJ61B8+BkXYX48gXX7IrW1+8YmPnkdmzkx7an/4VkAcFo3vfS6hzBJy8SArkNue60xPeWzixwk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(316002)(16576012)(31686004)(36756003)(4001150100001)(16526019)(83380400001)(186003)(31696002)(86362001)(6666004)(2616005)(956004)(2906002)(26005)(478600001)(6486002)(44832011)(66556008)(66946007)(52116002)(66476007)(8676002)(53546011)(8936002)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kZqrfx/3/r9BgCzpmbDFtEyHuI/EPh4IZ/2c8iG3zXiuOFpqBU/IrIFsgx2EqU/gcTpXMvEVPCq47TVe5lR0fY8vUJaJ697g+xxbbd/NF3ozyFLRY4u4DbTIXcmEt+pxOIOFedKVEVkcgohHYJhs9mIo4ThHdbqVRhNfq0R8t+9tmSb/pnQzO0WkgjizxSWIW6dXzjzJ6tygf6s2OTqht5I7FJjl5dH6rxpZUdAH3biaZ7H3bIbShaxvGRmNnO73fASU3poOhE4CUL9LV8RQHCY/5aACb3byzXfleLlOBpulvT3Pm+uoptmyqGV4ZImlj2v7IavX/aaCmFQMLXb7GAHl84WhOAeswm01IIcjJ1KgnWa3cdbwtRg7Wcdlt+mBYc0jxutEF5ImNk72s+osPPNVWrtRXtJq5rVZp0vegCCbPmXNCtavBgRMzasnKiahm4yyw/kE20SbkoU2BGrGMTW49jTSIBQCFqs+KuKx7fqEZ668X0e/l4OHXOFePp0MfsiN/i+/8vcpahYNWHhSYTINVwLQTfkd+yI/Gsz2wV1CQFdxXcVI4555J1DJOkFP1ZdcSsVWF5+cZ1IueUa18X9VM+vcsPzM9VCaqH9NhGoeFXHHVD2HkPJGgB34TVXl0zuygfPgMzKs+HkC79060A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7695f95a-4540-458b-b97f-08d87b53dfce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 15:12:24.1483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGKiknXeEK8QPlzByZ1zj1J7ne5d2aSiL9pJG5Pc7ZIzv+ycM7OW7l89/sxCLpfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
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

On 2020-10-28 10:55, Alex Sierra wrote:
> By enabling this parameter, the system will be forced to use pcie
> interface only for p2p transactions.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 9 +++++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ba65d4f2ab67..3645f00e9f61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -188,6 +188,7 @@ extern int amdgpu_discovery;
>  extern int amdgpu_mes;
>  extern int amdgpu_noretry;
>  extern int amdgpu_force_asic_type;
> +extern int amdgpu_force_no_xgmi;
>  #ifdef CONFIG_HSA_AMD
>  extern int sched_policy;
>  extern bool debug_evictions;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1fe850e0a94d..0a5d97a84017 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2257,7 +2257,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  	if (r)
>  		goto init_failed;
>  
> -	if (adev->gmc.xgmi.num_physical_nodes > 1)
> +	if (!amdgpu_force_no_xgmi && adev->gmc.xgmi.num_physical_nodes > 1)
>  		amdgpu_xgmi_add_device(adev);
>  	amdgpu_amdkfd_device_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4b78ecfd35f7..22485067cf31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -160,6 +160,7 @@ int amdgpu_force_asic_type = -1;
>  int amdgpu_tmz = 0;
>  int amdgpu_reset_method = -1; /* auto */
>  int amdgpu_num_kcq = -1;
> +int amdgpu_force_no_xgmi = 0;
>  
>  struct amdgpu_mgpu_info mgpu_info = {
>  	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> @@ -522,6 +523,14 @@ module_param_named(ras_enable, amdgpu_ras_enable, int, 0444);
>  MODULE_PARM_DESC(ras_mask, "Mask of RAS features to enable (default 0xffffffff), only valid when ras_enable == 1");
>  module_param_named(ras_mask, amdgpu_ras_mask, uint, 0444);
>  
> +/**
> + * DOC: force_no_xgmi (uint)
> + * Forces not to use xgmi interface (0 = disable, 1 = enable).

How about using human English here? Perhaps something like,

"Forces not to use" ==> "Disables the use of the XGMI interface ..."

Or, if you use the suggestion Christian posted, you could say something like,

"Enable XGMI for P2P transactions."

Regards,
Luben

> + * Default is 0 (disabled).
> + */
> +MODULE_PARM_DESC(force_no_xgmi, "Force not to use xgmi interface");
> +module_param_named(force_no_xgmi, amdgpu_force_no_xgmi, int, 0600);
> +
>  /**
>   * DOC: si_support (int)
>   * Set SI support driver. This parameter works after set config CONFIG_DRM_AMDGPU_SI. For SI asic, when radeon driver is enabled,
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB15C4363D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 14:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71C5206FB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 14:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gjqGweVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71C5206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19FB86E9C9;
	Wed, 23 Sep 2020 14:48:05 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760082.outbound.protection.outlook.com [40.107.76.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9226E9C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 14:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGkgxgb8F2xFwXCk7glY+oyl6+XVzrl5htiox7P3Q5G/oFLjmsHs0VpIN7mRJhA1Qspg5lu/qUZXSPic2lcSwmUhssXMQvAE50qOCKz0qqjESZU5sJiuf6K7urEK9J/6gknQSVWZtgfX2lEqZ2I6zAm3UE3cH6j2t1MQrvrDRQUc9fzieYBDT+/UqX2v5/4YMacpjrBJ8e5MSh0o+n3WNQuorUIqtDVge3nrCcJZtT5xg7ckeSYpJID1BLHYor/Isj0FqE/Uq5WE1dL80BxwB24JGGKCpWwIMv/KWP/c/Q0nBhJ+lE6zOUlhx5TOEYj4wQrbvJqSmCmZZ6SNYEas1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPp91BOqkrixHRVNaxqDNpICKY2HacbV+zQp+6SG6Cg=;
 b=RJX0/gngt7a6hk371EERKbhseQbdn9rhk6iNfZZaAw32p9iLYmlg50n34aLxo4MKFAnorcVNerfNBee9YhuPYYX2kNyVbrP8zn1ZEb6RoUhMBthFigCEdc6VkJyzOmQ2TkbuoGRt7+BfqpcKGhUu76U/MUzR6e+gI8JXyS6Nut96s+xpiC4mzKZew97Ot54T5LoNNKGY0BCH0tURUKd4Raxs6H6EZuX/6yg3XbLwBsSVyoM4sG/mMd2+lwCjAw10zxdFzAO6j0yunsN7yTejc7ytsBa0tbQu//z1/VK9+LJwE964HR5eAFzdopUspqj4MfgDIkkmx9hMjrnbfQZnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPp91BOqkrixHRVNaxqDNpICKY2HacbV+zQp+6SG6Cg=;
 b=gjqGweVwKYtIjhsSLxdtsAq2VwvSdBgAW72HMSjsr9nLdxfpj7EDmC8SD36u6orQZbO0zTWWwX5iZHO30kOyVNyMG9dFzoK3N13KMjrtQNvuBmiRTSMXMp364zj+1aQUOf4qKL7rLoJ8b7H8orkrfCc8crGSqMOVXXixh6cIkKM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3769.namprd12.prod.outlook.com (2603:10b6:5:14a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 14:48:02 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3391.025; Wed, 23 Sep 2020
 14:48:02 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: add an auto setting to the noretry
 parameter
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200923140858.1193427-1-alexander.deucher@amd.com>
 <20200923140858.1193427-2-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <3ec1aff1-9ca9-6a71-7871-5359d004566f@amd.com>
Date: Wed, 23 Sep 2020 10:48:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200923140858.1193427-2-alexander.deucher@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 23 Sep 2020 14:48:01 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 169b4a5e-0a8a-4b8f-7e04-08d85fcfac10
X-MS-TrafficTypeDiagnostic: DM6PR12MB3769:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3769154AE55F09AA84E6D9F599380@DM6PR12MB3769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDvm35k+AEMFiJlVZ7WEsY1o8Oi6p1J2cSCAETnBBb6jaHpRJ6Je0QV3vyANadMafH001dwR6YgIYWl0HiShrgvB00bGaTR59xHhtd+ZbV7sgqi6TbfxwRuazFGi4pPaZDNPr6UKAy6C6KHsu5hyVUsRr9rA+A/0jjHNfmwa6Bv/QzFhDcATZUoErFricE4XLWuJ886zWuD4AArmNUJwFWKmibA8CHdCBq83CzYMLqnG3l4LSR/KhMsWYzJgu/INu3WTDLhI2B2MWRCDyGoczVd04a8t0SCiiZbiLJP91kS3mBZ0JstFB2XcmNXbR/AJqV25/eqZvyrIEJUQMaS/ujqQ0KxZKksmATh/+DxssJIUpPWm78o7WLKGbUQSzdMc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(8936002)(16576012)(316002)(956004)(2616005)(8676002)(66476007)(6486002)(66556008)(44832011)(36756003)(31686004)(478600001)(52116002)(31696002)(66946007)(86362001)(2906002)(5660300002)(16526019)(53546011)(4326008)(83380400001)(186003)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qH3jng3k56dcAk9J3w7uvChmKUsNDvcwe0r8NDZQUdHhzm7vWfxkhGWqz/sGodDZaLAs125CgmASo4ffxZpYmHmb0octtNlgzgP+inW8oJEQbcq+T5YnMDovMK5gFWsmUz8L6z1l6YAgb76arLFFA2E6YHRH0t5eLQljehBUzoRnmryrHu+UFaHm360wbyezsjhuPrD+TFcMQ+nQVeJHkRHautlC8Pl2g9Ge2tcvPqFrEz4DISE9cbtIQVpDhIMPqlYx7i9M7kPlT5qW0s48iDp6cVNexMv+EiVg/MSCsRJTPsp5259M4O9NH5InUPTiiTcwjeFCFiTEI51mx1oC4Z1gYLyZYFkwnEkJPZro8qgffVxs3Eod0vmwIbOixPS5dNTN0Y6zHknSravEMYYxQx+bTmC/IFamhqKn/7w0Z2+X2eY05zccJrQjXn4mtmRmJYdCQKP5vuj5qB4Tle7rWB33vUA9xkJRqkORlt1L1KgGdB4Y1bm3LqV8JqsxafS8Zz/thUIjiH9e7UZ9QLYwGqR3oro+GnaGR7pi51rdW2IwIsfxEfX1yPtC1P9jOhiHyWEAFfnaG8zZyIEoTShP5HfPIEfayem0Tfb/GLzXvVmBTpyMObbQ+rvOnyw8wkuYSUhxkxyj5McfiY761iPxEw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169b4a5e-0a8a-4b8f-7e04-08d85fcfac10
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 14:48:02.4325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Su9ClcautQ/kPs8kcAKZoddiFUhfJX4/c4EH9IxEv+x1pUimjGflH/Zl2/hoZ17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3769
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

This is a good change!

Regards,
Luben

On 2020-09-23 10:08, Alex Deucher wrote:
> This allows us to set different defaults on a per asic basis.  This
> way we can enable noretry on dGPUs where it can increase performance
> in certain cases and disable it on chips where it can be problematic.
> 
> For now the default is 0 for all asics, but we may want to try and
> enable it again for newer dGPUs.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 26 ++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index a4b518211b1f..f3e2fbcfadfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -147,7 +147,7 @@ int amdgpu_async_gfx_ring = 1;
>  int amdgpu_mcbp = 0;
>  int amdgpu_discovery = -1;
>  int amdgpu_mes = 0;
> -int amdgpu_noretry;
> +int amdgpu_noretry = -1;
>  int amdgpu_force_asic_type = -1;
>  int amdgpu_tmz = 0;
>  int amdgpu_reset_method = -1; /* auto */
> @@ -596,8 +596,13 @@ MODULE_PARM_DESC(mes,
>  	"Enable Micro Engine Scheduler (0 = disabled (default), 1 = enabled)");
>  module_param_named(mes, amdgpu_mes, int, 0444);
>  
> +/**
> + * DOC: noretry (int)
> + * Disable retry faults in the GPU memory controller.
> + * (0 = retry enabled, 1 = retry disabled, -1 auto (default))
> + */
>  MODULE_PARM_DESC(noretry,
> -	"Disable retry faults (0 = retry enabled (default), 1 = retry disabled)");
> +	"Disable retry faults (0 = retry enabled, 1 = retry disabled, -1 auto (default))");
>  module_param_named(noretry, amdgpu_noretry, int, 0644);
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 3572629fef0a..36604d751d62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -424,7 +424,31 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_gmc *gmc = &adev->gmc;
>  
> -	gmc->noretry = amdgpu_noretry;
> +	switch (adev->asic_type) {
> +	case CHIP_RAVEN:
> +		/* Raven currently has issues with noretry
> +		 * regardless of what we decide for other
> +		 * asics, we should leave raven with
> +		 * noretry = 0 until we root cause the
> +		 * issues.
> +		 */
> +		if (amdgpu_noretry == -1)
> +			gmc->noretry = 0;
> +		else
> +			gmc->noretry = amdgpu_noretry;
> +		break;
> +	default:
> +		/* default this to 0 for now, but we may want
> +		 * to change this in the future for certain
> +		 * GPUs as it can increase performance in
> +		 * certain cases.
> +		 */
> +		if (amdgpu_noretry == -1)
> +			gmc->noretry = 0;
> +		else
> +			gmc->noretry = amdgpu_noretry;
> +		break;
> +	}
>  }
>  
>  void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

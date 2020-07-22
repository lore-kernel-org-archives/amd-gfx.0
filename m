Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE34C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 08:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1EC205CB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 08:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jgfXRQHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1EC205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A564F6E20F;
	Wed, 22 Jul 2020 08:45:50 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760053.outbound.protection.outlook.com [40.107.76.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514E36E20F
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 08:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYV+pHNTiYHs28afh9JsVGnFeUPW2BATk0l+c9qbxLZee6c0Vm1l9/gGGVWanBLnDHXrMpTE0Ts5K4ovGtyxSHMnsyRnQjOsOW5Qk4mJ3fD5ukuRRHNUMycxMGnQdurenH8/6TBtXV2+6tFEFXWcF6z3uZf07j9LwX3k1ZuwOyCm8jlq5OuV/tPC7RDXP1yqAN2H2ob67xsvle5btpOAlBGf87hB7k872RQD61ZwiEhDrcIoPNuNeet6FLnt6kz4uTA7TtKHA3toXdUFUlHfg5ITu8pSo/h/neskOPb3yVrBP6maGaAzU2ZQo4pistOSuHtfGci9zFOgkukQoy5dGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c2CbySjiPpH6a2u6KY0Ivi7H5o9aQps4lc6s5azRpM=;
 b=PRo9fiDxrWXWK7u9WKQbW6Y9YZIgDMAlfTdPNkmbM50ieXnqUrQScvvzzkB70umDy/qeseGK5MCSo3B2GEkPmPVhs6+WaVSVjYGv5DdozQ2n73H/Wl+ks8XvGsOzyQG5WlYxr920dQt28fh8SjqJofAGA7EZtK8QE4+PlcYDWW4JT9lx1E09WYIKwf6RbdNlkcW5ECaly66D8rDcJswNJinYxdF0V4A4jNKZALZxCaQBXHPAuXg6Qfg3BVNjVaJdzKdGouAbV3fFlgnSjdPe4123wiQ08DfxZ/30jgBso4BFBGV26rJOEq6zLQpALb65dtSjAR4HGMqvrhX9j88adQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c2CbySjiPpH6a2u6KY0Ivi7H5o9aQps4lc6s5azRpM=;
 b=jgfXRQHBuz1KGJkr+U3echPD/pZQUbSGBQvbpdKurJp+6eFo+qVdFCSE0DcDN4MMmVi7gjVMED6QHTe7rpAbCzROrAAThQynuB60pMj1NMIX8wK0TTWGzR/zR+A0+ba3N0Ct6REvyU8C1yLVWwNBnfwh53hAfW+dxjEc4JXwY2Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by BL0PR12MB2420.namprd12.prod.outlook.com (2603:10b6:207:4c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Wed, 22 Jul
 2020 08:45:45 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3216.020; Wed, 22 Jul 2020
 08:45:45 +0000
Date: Wed, 22 Jul 2020 16:45:37 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/powerplay: drop unnecessary message
 support check"
Message-ID: <20200722084537.GB1032920@hr-amd>
References: <20200722080045.4178-1-changfeng.zhu@amd.com>
Content-Disposition: inline
In-Reply-To: <20200722080045.4178-1-changfeng.zhu@amd.com>
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR02CA0175.apcprd02.prod.outlook.com (2603:1096:201:21::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Wed, 22 Jul 2020 08:45:44 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d43d901-928c-475c-c6f4-08d82e1b9ffb
X-MS-TrafficTypeDiagnostic: BL0PR12MB2420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB242037808E44A3135C6C2471EC790@BL0PR12MB2420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvH+M+p2jZVdf/UOAPXLohKj7kbcwh0lMgy1h2uiL6ZQgeWXJe2gKy9bWSJxliUspBrcONOdY1xlw9C/qOpgRsCO2jsoXeRdgikWgm5SX6B7d9DTX1b403/LydxTGlLkfmzg3ocnDscHloldiv40FiAr6DNf1Bp6/ZAWN1FG6Vs0mRSEhP63iFJnzdZ1Vp5JhVt7H0KxA7pZ1FmFk4lql9jhxKcBaYZlVqElFyGopDSS5zQdF8PFnvA5RxnKER7VDVfiDC8BcDOEdvFgGQ9bvHlbyQ+/IRiu2PPbTUvAgUqZ1zRlsqZyXg0x+JoXc715IeGMN+A+bsKCwp/dpYuIpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(54906003)(66946007)(2906002)(8936002)(52116002)(6496006)(15650500001)(8676002)(66556008)(9686003)(16526019)(19627235002)(66476007)(186003)(4326008)(316002)(33716001)(26005)(6666004)(956004)(33656002)(1076003)(5660300002)(6636002)(83380400001)(478600001)(6862004)(86362001)(55016002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: e+Q/aT5x6U8PhAieqeej8dqVtWixgYjjHLsj0KC5/lBmUg+F3gl4Llsnq4e9DqQUJfRCb5q12tlJv6pLiysbMDc0OlGI/FWMFELrjZ98qhOmTt+sS5RKT+VKpAyZnWX+2QIkihTX/0uW0z3D1tPv+s0fPGQQqTXizQd1xIYMSI2kyPc2Lwf5Fmjqgg8RWCUUNLMGeMsXeEbGCdC/hGsnSEGDflMY0+KrozvBmBA3kbc0PYvF1u+HC8n0kFgujaJtYRiR+XGhgffIi4+L11sAAnavElGY+3GZhQB84bO2SCcT4aKSofwnuL14Y7XytzsNUj+5k1QoEj/3Gkj2ZyAKWxNwUUSY7VTlNR4yQXGU8tXMWEu2Kdq+WK8dcBBBpScTDStj9S9/NcPQu4ZhUfJ3n/0x/zVcqMJP8hr7ePMpCOLD8u04O/A3xUa+IOGNdZjA6VZH6scrTccELf4Cg5i0FqcSirQeQyUgI84GWlbw1mRWQAj/voFeWheITw2G1t+B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d43d901-928c-475c-c6f4-08d82e1b9ffb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 08:45:45.7696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8x3Ccuc5V4guPDJ51RqNLuSqTCcJk2VAhAdHcxsG49F0E7upLsBlz3ktu2hhoZzvWGL89kGDR/KaOYrLyEIVOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2420
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 22, 2020 at 04:00:45PM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> From: Changfeng <Changfeng.Zhu@amd.com>
> 
> The below 3 messages are not supported on Renoir
> SMU_MSG_PrepareMp1ForShutdown
> SMU_MSG_PrepareMp1ForUnload
> SMU_MSG_PrepareMp1ForReset
> 
> It needs to revert patch:
> drm/amd/powerplay: drop unnecessary message support check
> to avoid set mp1 state fail during gpu reset on renoir.
> 
> Change-Id: Ib34d17ab88e1c88173827cca962d8154ad883ab7
> Signed-off-by: changfeng <Changfeng.Zhu@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 9 +++++++++
>  drivers/gpu/drm/amd/powerplay/smu_cmn.h    | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 838a369c9ec3..f778b00e49eb 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -34,6 +34,7 @@
>  #include "sienna_cichlid_ppt.h"
>  #include "renoir_ppt.h"
>  #include "amd_pcie.h"
> +#include "smu_cmn.h"
>  
>  /*
>   * DO NOT use these for err/warn/info/debug messages.
> @@ -1589,6 +1590,14 @@ int smu_set_mp1_state(struct smu_context *smu,
>  		return 0;
>  	}
>  
> +	/* some asics may not support those messages */
> +	if (smu_cmn_to_asic_specific_index(smu,
> +					   CMN2ASIC_MAPPING_MSG,
> +					   msg) < 0) {
> +		mutex_unlock(&smu->mutex);
> +		return 0;
> +	}
> +
>  	ret = smu_send_smc_msg(smu, msg, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n");
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
> index 98face8c5fd6..f9e63f18b157 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
> @@ -25,7 +25,7 @@
>  
>  #include "amdgpu_smu.h"
>  
> -#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
> +#if defined(SWSMU_CODE_LAYER_L1) || defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>  				    enum smu_message_type msg,
>  				    uint32_t param,
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

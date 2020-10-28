Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF780C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 11:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDBE246CB
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 11:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AtWbGzdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDBE246CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60ADE6E500;
	Wed, 28 Oct 2020 11:48:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58E76E500
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 11:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAUSvGwUOr7jg5+nZNPB5WFZtx+y8WzLXlGrIna0FR8zNcZQhIVDum/chyB4zeAZzNfubOJ0du/pNXA/8sD2c9eacpxlnxhxnb8km8I3BnUAlVJIRS+rAVCGj6my0P7aL+KscnmFaw9UCpexEo96gVu8xoxVcB8sqvbhOJ0W2o/nr+nSCtaoUtHeb++TesJ2oJeKrY3jyJF4+9jcpMxVsgn2dGBqWjs0qHvcufBUEcQjpOUArvFy9mnAfuxoukETU6li1dax5dckwSiqBpji9iiM6X0OH5uvmxGDdCuWV5DsI1Cy7u3WoMmqdiUvBXiIDQKoDLOC5anaMkLfSuVvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkV3MjHaBay7Ru1aUrl223QxcqSrBIoScJzFq9g1zBM=;
 b=KcYCy59eX6Fq6+xpC0P5ip0gZGF/pFEeRHCeblHhOjRRf/7SUq0kxyCqhiJRzpJZJKcT7tsz72IOu1Kl/wZSz1SKQzsq0rmqGb268QtlhYoT50LaJfDgQvD96jHQeQHsPcOMz8Fbd8+cAYIZ3X9yALqT/O+A4XC4xngbixxY2xYDkvwZ+VlYaIYoltBuZ21z3iVZw/KmMC/BfP3Mjz/Zqy/IRnjxNZEJ3Y0R0pIk1DB5ae64wol6WIS7O2X5mPCnuQ+w8l9gldO5fXreSbLhm+zLismN6rpbfbRe2HsSJxLjvIAs0Q0RTxRgKyew+JUWw5gT2KExU52d71FKO+TWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkV3MjHaBay7Ru1aUrl223QxcqSrBIoScJzFq9g1zBM=;
 b=AtWbGzdh/xwpzGmQCM1IQo4rIPipa1nhn9pGLSsrZ1zugRJqm6vFkjB0ifmJVnsCkcoCbtD5+L0AtYFaVsyOBYSA/XvPyDnPrv+ISellaI4EHGnYwvGPMtGnw9eKxKGEoOzNSeSGwo79WXXKI6YjNDpYehjfUCyY92e2XKAAaWE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0048.namprd12.prod.outlook.com (2603:10b6:301:59::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Wed, 28 Oct
 2020 11:48:51 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3499.018; Wed, 28 Oct
 2020 11:48:51 +0000
Date: Wed, 28 Oct 2020 19:49:05 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] amdgpu: Add GFX MGCG and MGLS for vangogh
Message-ID: <20201028114905.GB1767271@hr-amd>
References: <20201028095945.2627-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20201028095945.2627-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR04CA0056.apcprd04.prod.outlook.com
 (2603:1096:202:14::24) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR04CA0056.apcprd04.prod.outlook.com (2603:1096:202:14::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 11:48:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce6c98e8-0785-4796-41ed-08d87b376ffc
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00488A78D5CA9C3F1FC05FEAEC170@MWHPR1201MB0048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bj6v5tP87BKi8N5KsShs89g02ICNu/sDdsVuQ4xBNSMgLRD3Z5SL/jLUT1UU5lCYgG2Wqoq450pJaPxst2ATua+EPNu9fpNGBWiqbl5ZB+giXAefXPoFrgkCRSG02okFgw3u68rP0UVvqRV0uYBpH5WBEh+Gpgr76VrPDfx0Hj1qfbtCSQTAA+QTzq6+arc/vufV8gv0T/74kJQrw52IqMjLsAZB3msM2fstHFpj2xx3z8keU10Vlal1FwJN73KdDrRZL29UK/UO3ld4sWv1ckVXyhBU8sf0SM3qwpnVNTgIeAEWO0v4z2Fk5mivhEt0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(66946007)(66556008)(33716001)(8936002)(66476007)(478600001)(8676002)(9686003)(5660300002)(1076003)(33656002)(4326008)(316002)(2906002)(83380400001)(186003)(6666004)(6862004)(86362001)(6636002)(6496006)(956004)(26005)(55016002)(16526019)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uD41YiuKfIOuxYhHEKsjwpDlUgoMoxAwq9XQmJkNjryYc+zGyZ1Y+V+QLho49WtvSG0H3BcVtcGgIdbT4c7WeU6EntHaFb+e08aYhcRrfS19bkYNMEUIrTauC07OjUkGCBQnM8yQO0RmR3ffjhLNYaypn/TeDisbcRc7WVSK4JL9tnzxkxBoUNgdIrWgLcQ+QW7VE1htYVY4aEpFIDit+6Vqvopg6yo/wqp+hAVhW7+Kzqk0rkjjrDy+AlY5WHzY02s3VMsEpTzAGOEDQSqk837gIbAOMFsJ6yr+d4uP6/IEMOx5NQOcPjjVuOegTui1bCHO7p8wzUC4rLFdfXp4QrkaYdbD5hrcUO+X4sZfPxAV4YwMXhR62w97wnwg9CGH7PCj7kog3QiKwm2sXkzRAMUyDb8MwIu5nG5I8jkB/Dz7sZsH3qFoKKSuKm5rLgdyj1XEyTnPCzmJRvQSN5B6q8rkqCma/viVtxkqkzqRdRtV6Hlk66TC8Sd7llf+ScaeBoDYOCYEXreudwkdfHKtukmYmULonBLXZnI20QkesrzDb59cRWa+QTZSbwZEnNZd2FaIkrlADG0YB2GB2jXgnA1CSUtLRiZcfvyywmHyyfka2Hy08FwF27O/MlkHNDiRp/WzXjRBky8Af6lczMVSZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6c98e8-0785-4796-41ed-08d87b376ffc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 11:48:50.8804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVZ5LxSdctL5dXsL/rVFMgpZNoOg8+QmxlKRSfZESjW+5NMsff1qq08BpGKCoufXUQeZ6GNUKvAyXBnWlV21hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0048
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 28, 2020 at 05:59:45PM +0800, Su, Jinzhou (Joe) wrote:
> add GFX Medium Grain Light Sleep support for vangogh
> 
> add AMD_CG_SUPPORT_GFX_CP_LS and AMD_CG_SUPPORT_GFX_RLC_LS
> 
> v2:
>   add GFX Medium Grain Clock Gating
> 
> Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
> Change-Id: I38f4e36a896915f39fd7c2673e0041244006d1b8
> ---

Reviewed-by: Huang Rui <ray.huang@amd.com>

>  drivers/gpu/drm/amd/amdgpu/nv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index c65b4462bf5e..026e0a8fd526 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -943,7 +943,11 @@ static int nv_common_early_init(void *handle)
>  
>  	case CHIP_VANGOGH:
>  		adev->apu_flags |= AMD_APU_IS_VANGOGH;
> -		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
> +		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +			AMD_CG_SUPPORT_GFX_MGLS |
> +			AMD_CG_SUPPORT_GFX_CP_LS |
> +			AMD_CG_SUPPORT_GFX_RLC_LS |
> +			AMD_CG_SUPPORT_GFX_CGCG |
>  			AMD_CG_SUPPORT_GFX_CGLS |
>  			AMD_CG_SUPPORT_GFX_3D_CGCG |
>  			AMD_CG_SUPPORT_GFX_3D_CGLS |
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E02C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 14:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F253F23121
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 14:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F253F23121
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5F789E86;
	Tue, 19 Jan 2021 14:08:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D70E89C29
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 14:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQO9VVipGTZbNOROmFH1bFfMCbEORZMeb2TWh5NNrsmPHQg4SKXxNwFeB2G5yrTueNBqNeU+Mbwx3sWXG6Ya5guFtN5atxmHaqQj7xQrbp/XNMA6drhwGD9B1A8hNsVnUy0bq11UpUs2QoAFqmFGb6GuEoPGaFUdlKoQIC0/EJPvNtDQ6PWtoQg+X+xIKE0ycZMr+DZmoRsP3Yyxtd6aAsXLgrBXJ12XSvGrpEHyjTSa82LxunNE96/D5zMykihcdKMadjnJA+Qs4182QknZaWW5izeyGQZmtpu9oaxu2mR2MY4nPUlRdK5pTYsgOeVsycwlAPnfEHTUAr0OT+h8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v4Bz4gBYZ7MMXvuCYyCrsXgBAowuXpHLwkrezVwP3E=;
 b=M2vrdUUk752p+zT0LrSBA0pqrVcFmLLwr0vAX8DK1NR+jjSQQX6yBbZNWFc2k6JsnSSSuo3dtP9V9xdmocUttdGA1h/anzSgsBu5tngCxmTArimDRcjN24Yu+sEnUnF9zUDNvxHR0YOqA+J+eTG22pZZfEiiAUsawuibLTO5N2OEp234uJHvkuuPMiN7w26HBCY4tHnHQGF90BxUBUmoYl+9KuqFvZi/qNGnewrIt3MRaMrSi2tpQlNn8fVJQ5z8JSLu7TElilVs5NqUQq0pEBq0pN48xUqg5YMOToAknP8LrWhvYu7wqNoZv6x8SBwghiIThxjP0D+KZp7MvFAnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v4Bz4gBYZ7MMXvuCYyCrsXgBAowuXpHLwkrezVwP3E=;
 b=kWEpyyJaXEKRAcumyXNEr4K8yyzXnb10gO753cBmTguashItFBl5ccBaokN3THS749yaVJVyp8vo1+xGTGBYX8+CkihgITWI2au6SIu4BV4ah+eQgAMtbxawtn30i7htjsHflGd8cRuq9yTmLT5QCKn5EjkwXl45vop+QktqKEQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Tue, 19 Jan
 2021 14:08:52 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 14:08:52 +0000
Date: Tue, 19 Jan 2021 22:08:42 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add RLC_PG_DELAY_3 for Vangogh
Message-ID: <20210119140842.GB34485@hr-amd>
References: <20210119104854.24380-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20210119104854.24380-1-Jinzhou.Su@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:202:16::16) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:202:16::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11 via Frontend Transport; Tue, 19 Jan 2021 14:08:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d0eb624-d49c-453a-a9c1-08d8bc83c00c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1661:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB16617479CCBDEF35D2EFB700ECA30@MWHPR12MB1661.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: But8gDAWG1acFrq0I9j7NHqYk+km8uEeVjzfw1198uKXtMvQ6Y5yhPcrGfwYHOGLwUPXX91iPe1tcK+FVpbsle9g2aq4VXA0S7/Nn2K36cw/a5APjhtrpcf9C3uSGKz+zkSWmM1Jl7z5adVoztAxsibAmHGZbai+WPpmo2k/kQFF0ZzyMRJ7jIzhDMUbZFlNw3yja5JqRXDLAald9/Rv6IuvKXxtjkpG7QIeopk7U0A2gcvvTYNnniOMEFBLG6QZ/Pj5W1e1KLe4hg/JDhLQTbuOa6XFx6fGwmAqpThabGscGamMvx/W+lnX6o8vk9Y9Jmpby8DKqOUrU/ILLVGea1i+yQv0iXz4ITea//PN6XcyQFNd6Y53fQcHq0LCyih6qO4iQC2T8P4AJ+oZunhUAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(66946007)(6496006)(66476007)(956004)(66556008)(2906002)(316002)(52116002)(6666004)(9686003)(33716001)(186003)(16526019)(55016002)(86362001)(8676002)(5660300002)(26005)(6862004)(8936002)(1076003)(478600001)(6636002)(4326008)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rObgRYC1qQJTT1MsTXyXD0ZJWleGnGP3ICNew3nLjJ4UIXqzSL054EPAm+c/?=
 =?us-ascii?Q?q3ZVdgWfB3AwYL7lQlKunZPLv3fTKBtM99mEbRdfxzRbD7aB1+Qs9tzY6J8z?=
 =?us-ascii?Q?nPm6O+bJQ8KqNxa7LtPsDuk0kOuc1TLJnrfNkZBPvr6WqdeSYwjm5cvERr3i?=
 =?us-ascii?Q?tTJBqlQkOaWhVnJVoWLhFeCQN1fqF583opup+YzKPIg76oNfzF3B/73PSGr7?=
 =?us-ascii?Q?fZw5jkSq/xuJf62cxOc+BOheJ9e9Fx7ocy61HPstiD7SFtDVAxycz0+cp+xy?=
 =?us-ascii?Q?jrY9/T9Trsf8mMPPDGVunnBROQb5rQrm3KQKhSuAW2bXjEFOf219dPJ0jQq7?=
 =?us-ascii?Q?gj8SAM+c9L8zsxshD50zdeVMFimntrvuwFmHAG2SjgvENeQa4R/k4BbUxpzi?=
 =?us-ascii?Q?regN16Jsbmizxqb2PiEQGD7suKDiazNXTWadA4eodm6QFVFfle7u1RjowcxF?=
 =?us-ascii?Q?SBo/6TfdVOPI8/iplg2ewOktXyaMbxHkcwwBjmVXmNKwhDxBJmQh+41hIIwl?=
 =?us-ascii?Q?xBQOfeVKm5X+/5NQ6/TBFdVHabnLqw+DTjo90kZA7MZjbx7iOnuJY5HGz+UQ?=
 =?us-ascii?Q?xrxCy76ur7ziKRMbu5nnmxRcNUZVq17s2A7DWC8lJVSTquMFVLPendLGChmS?=
 =?us-ascii?Q?jhwJN7gUNrmekqhCCu+LD8q3ABUuLofcKbSbMY+m6lSUlOJebmGIlza4F5Mi?=
 =?us-ascii?Q?9wduyjTiUJELPZgsnWpFvVIgwDDr4XFyjsN3zO0DBCMtI8l/LjbAqMtcZijF?=
 =?us-ascii?Q?CKF0P2QRf2eFQWN2hXp8/P9C+y2fweMYMvzZiVaZjQFv2yztIsU6aElkUTK4?=
 =?us-ascii?Q?ax1rgBjBTVQaBL0VqOT12nmBKgEQ6OV/AvAvD1+EEZq3Wj6fqr/sYd38muSE?=
 =?us-ascii?Q?kv+zrlyeUydtmy/82OGpL3C98OE3OHDnvj6DvgVT8IeNblxux7LQ1QxW6SbV?=
 =?us-ascii?Q?a4Mn+yFkzBpneKdFyJd26sqZY+SOYS8Oe/wd5CCz9Aqx2aYK9WM78c8Vu75T?=
 =?us-ascii?Q?m+ro?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0eb624-d49c-453a-a9c1-08d8bc83c00c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 14:08:52.4636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YC6nSlUKz5EIQDhjF+G19FXFYMuu2Tvy7mU6ir6s0lca46pdycR1+yIur5oyvZ0XjorzVQJMm6rSMxmCPk3Hug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
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

On Tue, Jan 19, 2021 at 06:48:54PM +0800, Su, Jinzhou (Joe) wrote:
> Copy from RLC MAS:

Remove this line.

> 
> Driver should enable the CGPG feature for RLC while it is in
> safe mode to prevent any misalignment or conflict while it is
> in middle of any power feature entry/exit sequence. This can
> be achieved by setting RLC_PG_CNTL.GFX_POWER_GATING_ENABLE = 0x1,
> and RLC_PG_DELAY_3.CGCG_ACTIVE_BEFORE_CGPG to the desired CGPG
> hysteresis value in refclk count.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index c4314e25f560..23a11ec40c33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -120,6 +120,7 @@
>  #define mmSPI_CONFIG_CNTL_Vangogh_BASE_IDX       1
>  #define mmGCR_GENERAL_CNTL_Vangogh               0x1580
>  #define mmGCR_GENERAL_CNTL_Vangogh_BASE_IDX      0
> +#define RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh   0x0000FFFFL
>  
>  #define mmCP_HYP_PFP_UCODE_ADDR			0x5814
>  #define mmCP_HYP_PFP_UCODE_ADDR_BASE_IDX	1
> @@ -7829,6 +7830,17 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
>  		data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
>  
>  	WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
> +
> +	/*
> +	 * CGPG enablement required and the register to program the hysteresis value
> +	 * RLC_PG_DELAY_3.CGCG_ACTIVE_BEFORE_CGPG to the desired CGPG hysteresis value
> +	 * in refclk count. Note that RLC FW is modified to take 16 bits from
> +	 * RLC_PG_DELAY_3[15:0] as the hysteresis instead of just 8 bits.
> +	 */
> +	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG) && adev->asic_type == CHIP_VANGOGH) {
> +		data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;

How can you get the "0x4E20" here?

Thanks,
Ray

> +		WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
> +	}
>  }
>  
>  static void gfx_v10_cntl_pg(struct amdgpu_device *adev, bool enable)
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

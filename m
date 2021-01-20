Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D9FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 03:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAF42310B
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 03:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAF42310B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C929A89F6B;
	Wed, 20 Jan 2021 03:14:19 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690067.outbound.protection.outlook.com [40.107.69.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE6889F6B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 03:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnObHntkzwIC4cm1nTy1csgBzpL2G84oJfq2ojADHzgTgvXXdpe2ujXPTROOY+QkNkDHxPjQ6S0THbKZKjOfTy0RKqatCcyUZEMKFG9/Vo5IBbP3cY8Yg3O7yc9Focwhz5158ZgsW5F6xCANcq8FVbS0J1mkOc6vzfWy87paPXrZp82k+R1DuWusA0WFBcg2J/1Vm53E2eeZ/zEr759BUgyCvfXDhL6SWjJfSrxo59qaDzad41l/A55rv5rVsOcfp5jBg0JgI0wkgpSsYArst5xOnJ7Z13zYRTsoDWsXNviQVDKOBOE1ndHJDneacXzps/qnN4eRyibHPo/19DZZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh8pZuMKlPLJmWiH9qkK5YA3vUc+q+S9Smbv6fcYNIk=;
 b=CA/OWVpY19PLBLN3ObFcaRZwCDiMuQafyFVh5OUWtz4K5QP0chfLmuZ/9supA8oY9cchvE7EgOn2+xGCP8cIlsV5eIo5Rnw1NO9Rb4mvo9TMWNyC3sLaZXB5U1ZJM+k3rYCYOGCnQI+i7ntvVw54S1/U9/fZ5MZdmtVSpevzaOhKXnZl4qrdd40ZVpZs0yXigfIK/2GhOweTnebzAvtwAahc/Cmtjw8++qpIlel9a1LjbPBkmQpEo781SX3T5lPFprjGp1jmksneWNZfCNpUAZ8YsnhJXd+6XKLCO9T0kRuoOPqPKGAHS3hT9HQjT/UUk/Xl4y1EkV7mqT1iG7EISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh8pZuMKlPLJmWiH9qkK5YA3vUc+q+S9Smbv6fcYNIk=;
 b=rAFqI3VO7FGEWIsW3lG/dBSFLw3+Yu5hbkTDuCcxJYsGKD9v05FpvNZdIDY5oP/IS9oH86Fz60gTIpfhr10+qpTYT+DkB07PWy+DgupLT12XM4CeofFt5s9YyYtjrnohvr2QrAkvq966UtctfscBJVCDrsGc1QIoMDQwUHFHYyk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0175.namprd12.prod.outlook.com (2603:10b6:301:50::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 03:14:18 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 03:14:18 +0000
Date: Wed, 20 Jan 2021 11:14:09 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add RLC_PG_DELAY_3 for Vangogh
Message-ID: <20210120031409.GB611756@hr-amd>
References: <20210120030911.32646-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20210120030911.32646-1-Jinzhou.Su@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0080.apcprd04.prod.outlook.com
 (2603:1096:202:15::24) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR04CA0080.apcprd04.prod.outlook.com (2603:1096:202:15::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 03:14:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a3ae857-a342-4b12-1327-08d8bcf17934
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB017520B1CFCEB15D3C313795ECA20@MWHPR1201MB0175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PD74burDVMup9n1/lDMiMiKPicNjFB4ZVt3SLdUnyEUCdgzPEjIjzvovrgGVh95KWk5NN2QCQ/SfvOPU8zgWJiBRnAoPNb7DogE2ucDuQXbWE7PHnSHU8Du1/ga6Y6wS9gEMox2HQ6cZAiT6uSBp884aSpIolFEt/FI1q3CJ/Nr95S3SLgmrMM0SXti5Ib1EBawsn9863/F/+gKR5VJQkUXtpBF1SR0m/HbmwXp1nT0mlu6P+IoE8QSaV1i5yLi/FWRJ7WaQKZWmK5mMwHoWfL79YQICyNRz3+Dx0v7WSsiYbUwAa8HG6qjs5ckuiQTn5eZZvassT556DYaBjkI4+wBOK3NkqCU01nwMJ2Se7aYaDFbnO3hr7aRYiB/B3Pv5QkIGenoyzzqJyab8nSoCmv0MJ0jpCu4ERWsGQArztdgaxbVPzjeo9Zj8BvyriyfvxBlvBFnPfROXTIfjlV7e8KtQ12bVXvo3yxbPLm5WelV3e2bm9UccxnfwNDu59UpvnTx1XLJj6PJggX1lW37ygQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(6862004)(16526019)(33656002)(33716001)(86362001)(66556008)(66946007)(6496006)(66476007)(478600001)(55016002)(5660300002)(52116002)(6636002)(8936002)(8676002)(6666004)(2906002)(956004)(186003)(316002)(26005)(9686003)(4326008)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Zk3oIUAY0J2KPWhppciTQGxa9NO9NGGeTz9k5i0UJeZsLjyyLKBVMBTvcyxI?=
 =?us-ascii?Q?W8VRLwQ1CpRT6G2vV7xcFYuaYvatZDvutccTqFAjsel+rkN9DtGeT5VpNNjd?=
 =?us-ascii?Q?sOtpHQ3cUoxOkJwiKITbSoXsB77Y7X7pu5hmqrZuARZ8GCfaNPwrZrklD0KC?=
 =?us-ascii?Q?Our2VtGpaDdqEswg5V1FPCQGXxGCsYX+oMgt56DQJHDH0svGBooNRIHTEGZS?=
 =?us-ascii?Q?T4xdYK+efzaexKcsDkunEUvRaujEYbXVfHrptJ5uyCHPRsjWhIepvrJkhDDz?=
 =?us-ascii?Q?d+H26wtHJjD4DYJWo9m0Hnug51accywYKBhcMXtMIcxz9Ll0v7i9wb/6PcAJ?=
 =?us-ascii?Q?WUeMiKfznfJZTNWY2kv9dX8MHk5j4cSQCHA8+vHkSta2RkIrqEsW+mvpYpc8?=
 =?us-ascii?Q?U62atNEbz6HtQYQ31FWchf/EXLktCeOFngQnoH0oj8M58aoXE3wzQAsBerfo?=
 =?us-ascii?Q?tNtMsG25ZqBc+He/ULqK93oUixzuvZvpH0GZxHDcEaSuVyVBO9zMaaFq22eR?=
 =?us-ascii?Q?7PD3hkJ9rYeXLl9eBWU2nkFghKxIVF5HKU25HT9+zwEuYgjoTAGgzkxcEa5s?=
 =?us-ascii?Q?7IiTLD2MpCifeBYtiFfrJTAL9PcSWwVrb3qFjQfq3tiTbH+RhSmHvXU9qI2m?=
 =?us-ascii?Q?6+EQrMeXKo/6hlPk/CUzo5e1e/N3Zwz7Kdlaie+W8ylg55HdFlr/nZm6NVR7?=
 =?us-ascii?Q?NZbT5GtqaN5XDEGRztV+R0K8VpdBWWRrufJ3MxgosEgLGw9SpfaKUGSMjLD9?=
 =?us-ascii?Q?Q5BnzEdkGfiKkh2HLJkzTkTc8PTCa0Pd16FSJHfK0G7X8Q3AwiFsavIGdPyC?=
 =?us-ascii?Q?nybtU3nDs3OHCvBXiCBoczkbKMZLiw9zKAhBt3ySrUe2RbzMLn0knGaq1YMt?=
 =?us-ascii?Q?Uhdou9oYv69p8vfwsj7qRfBq0KYre/0bbUGBvmPzzEJ64pQMPEiYcQp5R/qt?=
 =?us-ascii?Q?e7FPTC9Q1wtjadSusEgfQKte0r6zLoMNLFKIhSm/lWV539W2pw0Wvt6gv9Dv?=
 =?us-ascii?Q?C3eB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3ae857-a342-4b12-1327-08d8bcf17934
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 03:14:18.1830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zp0HNpBmxSBGQAhaVyqgM4GVDpiIXa6VHJZW3erbGNKQg0UUdYvaoVEaT40lGbhxOEsSZJDgSPY/jcQ9Qz5YQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0175
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

On Wed, Jan 20, 2021 at 11:09:11AM +0800, Su, Jinzhou (Joe) wrote:
> Driver should enable the CGPG feature for RLC in safe mode to
> prevent any misalignment or conflict in middle of any power
> feature entry/exit sequence.
> Achieved by setting RLC_PG_CNTL.GFX_POWER_GATING_ENABLE = 0x1,
> and RLC_PG_DELAY_3.CGCG_ACTIVE_BEFORE_CGPG to the desired CGPG
> hysteresis value in refclk count.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index c4314e25f560..dd102cc2516a 100644
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
> @@ -7829,6 +7830,20 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
>  		data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
>  
>  	WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
> +
> +	/*
> +	 * CGPG enablement required and the register to program the hysteresis value
> +	 * RLC_PG_DELAY_3.CGCG_ACTIVE_BEFORE_CGPG to the desired CGPG hysteresis value
> +	 * in refclk count. Note that RLC FW is modified to take 16 bits from
> +	 * RLC_PG_DELAY_3[15:0] as the hysteresis instead of just 8 bits.
> +	 *
> +	 * The recommendation from RLC team is setting RLC_PG_DELAY_3 to 200us(0x4E20)
> +	 * as part of CGPG enablement starting point.
> +	 */
> +	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG) && adev->asic_type == CHIP_VANGOGH) {
> +		data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
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

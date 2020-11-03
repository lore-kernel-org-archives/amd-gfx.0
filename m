Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC38BC00A89
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 02:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFCC22265
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 02:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LRwubjYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFCC22265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E6689824;
	Tue,  3 Nov 2020 02:49:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3456E88065
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 02:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je1AJP8UL5ahUO4/Mm1pBXABOWCjQ5Q1U89gz2Q0j4a8w+nuAdFZeGNddaTiesAi62zhQvyO6YWGvuT9/LpOS0V6FVeACcpSmuCOn7Weys+OB8ryzNY3IEFmuqzElsY/UmEdAIxKS2BQDbF8GWNxGunXiuqDrD5U/PxEO6NFqgMxiB7Hb3HIrKIhxD7tQHxHkw5FqzaOG3bg8o7Xqh4LmEMDaZl1BqIKhlGdNWBKeUgHzydrceOD5p/k1r8VQ0fhy9mNa5TBXHXWiGuqTsYD9yHp7MCs9BfiCuqAGptAUoQT116A+I7+BuD+0KmCPvyxllEZis9P1FklE5A2IctFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QZ1GMSLyQZ4keupeS0rCOLYGOU+yxtvTlwjEK817lE=;
 b=H7YuWa5SekIVCJ7Bz2kK1GHQklbQnjHeqFNs+yZmHiUO8oYd6VYXZAqXa3VNzmUNJKl63A1tDcfir/i5LL6r99+HEtRpIx+aZS6TegQQyd8NdGb/6axL8IuWSSnZZsCNbM8hHsFUDJE6agLCXbSEFpB8DAUU08vu/vVa8cMQEx5VFR5Agsl7a3XxAbw39xkbOcBZ7W7jnda20PkLsOPeVERjEOxvu/SN2FdMSYllJdBDngP0hwQO7iCofoSjZ3IWUxNAuDoggzvGNKvbz28o72uyrsh1XSmzjzac99t1volOj7qIyTKKhsXUgUo05iOMmxxt3oP3/1BdnxWEZENPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QZ1GMSLyQZ4keupeS0rCOLYGOU+yxtvTlwjEK817lE=;
 b=LRwubjYB4PkKeYo1iQQZcE4elOiPfy+1c/6FXiDWWEg6uPIIn8J+C5Mw5eKQXswbxNQ6EyiD+q47eoj6kaLi39EMDhbYcTLsjNGxg9xO2ojnmKSHwl30eOF2VReNo7bucxJmIRnTz/G3I79iOMKmufLS3keT2PpKQy1YtG+kodE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0176.namprd12.prod.outlook.com (2603:10b6:301:59::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:49:14 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:49:14 +0000
Date: Tue, 3 Nov 2020 10:49:03 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add Fine Grain Clock Gating
Message-ID: <20201103024903.GA2958662@hr-amd>
References: <20201103021401.7554-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20201103021401.7554-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Tue, 3 Nov 2020 02:49:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97b0950d-e9cb-4572-208a-08d87fa30cc5
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0176AE0056009A5036F8D1F4EC110@MWHPR1201MB0176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZTHpISBPm55TQOVZSzElCMdoOIUz3aeziosMg4uZNcy3ecCD3JuJbDr7gm4TQAz7jS7kvS25oGPo4X5EzGS5U/+Ssh1DCh6K6sgUGAN+j8j+4+6K/Ujo+4cjfd58SCAZrpQ90EePI05pJ1Evhcdo58xeuCV4ugjqSZLIhyUTRs+77pViYAFAUSbyp+AuGqkCnlynHfciKW8r/OCz3HxBG5jTb27qGMB4Q8P4yr2ivZjM7HqBJWGW7n09xj4mHSlJLAribO1ILadtuJb5heQbSAKGfHmjCQ/8DSO61Riq+6rOonGuOR2LcWpat47NX8eeA+XuKbYoFAzRAX2DjEwWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(4326008)(55016002)(83380400001)(33656002)(6862004)(1076003)(9686003)(316002)(26005)(8676002)(86362001)(186003)(16526019)(5660300002)(66556008)(66476007)(6666004)(52116002)(6496006)(66946007)(33716001)(2906002)(956004)(478600001)(6636002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 12KaCfbvdlWzBt/Zo9VkOrZAiMU8Gy5f4B1oYDMye/yi71LxG+3A8VaUy3UzFqoOTwBI63Ca488+ZWEMaZtZpwm7P7JuKwgGMQqT0w9NS64jZxVdchGvV9psZBFGXnacX6R+8a0Z/JQ7aBlBvwEi9tgqDLPykWm7eBjxN8WrUzyDOfT2ihripT0pIFyxJAjSXbldy6EwO8iqfR+GjC5KYsANNRilmcOeqzQUQIfog81KASsndz7Du+2dH0wtz9+uqv09R7vu1QyysXKdXNHx0rrKBZ6TTQsvn+vub3CiF8qSRpl4mGUcnI0vFOMLIPhj4TXws47MJucWH38STPRbGXbcQ/iBudkPB4RbfXKI4qdsjzOM2e6BQxEGaNNLXSE2Oi43d0c8jtW5AQGFLc5vR73O+F4F0BiXNQy50Etz8gUJXRmfjQGNJAxs7n9eXWf45r1Sme9vCPJGNrTqXxV4DYBymFP3Q4Qau5qjXCCXqAuWQRbahaydkuPSP4NYta+MHTDbfXSTSvXQ4oKvA4szuLthQIUgZOylhA9IV4erBV6n2O4nfuR+i1B5XPNxAkpkX5+BS/0Sz8IOPC0sQqsF4c+xY8qI+R3Q/rH+lBIbULKK8bL01p5MOasQu2aqHVP0ZUkra8HsuXvs2X9PfQ206w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b0950d-e9cb-4572-208a-08d87fa30cc5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:49:14.7135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMIN2v3HcJJ6sd6GTb4q4gOMVA+SHFJzayJBYMjEq7qxw2nhfWVK58tE4vSfZuYHopr96moBUlhn6zpDy803DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0176
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

On Tue, Nov 03, 2020 at 10:14:01AM +0800, Su, Jinzhou (Joe) wrote:
> 1.Enable Fine Grain Clock Gating - SRAM(SW control) for Vangogh
> 2.Add FGCG flags on amdgpu_pm_info debugfs
> 
> Change-Id: I839a623fcc1a444c880d644035531435c0b0eeb6
> Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 45 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/nv.c          |  1 +
>  drivers/gpu/drm/amd/include/amd_shared.h |  1 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c       |  1 +
>  4 files changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index e4c69125805d..1ef738c35b4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7657,12 +7657,50 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
>  	}
>  }
>  
> +static void gfx_v10_0_update_fine_grain_clock_gating(struct amdgpu_device *adev,
> +						      bool enable)
> +{
> +	uint32_t def, data;
> +
> +	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_FGCG)) {
> +		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
> +		/* unset FGCG override */
> +		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
> +		/* update FGCG override bits */
> +		if (def != data)
> +			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
> +
> +		def = data = RREG32_SOC15(GC, 0, mmRLC_CLK_CNTL);
> +		/* unset RLC SRAM CLK GATER override */
> +		data &= ~RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
> +		/* update RLC SRAM CLK GATER override bits */
> +		if (def != data)
> +			WREG32_SOC15(GC, 0, mmRLC_CLK_CNTL, data);
> +	} else {
> +		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
> +		/* reset FGCG bits */
> +		data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
> +		/* disable FGCG*/
> +		if (def != data)
> +			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
> +
> +		def = data = RREG32_SOC15(GC, 0, mmRLC_CLK_CNTL);
> +		/* reset RLC SRAM CLK GATER bits */
> +		data |= RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
> +		/* disable RLC SRAM CLK*/
> +		if (def != data)
> +			WREG32_SOC15(GC, 0, mmRLC_CLK_CNTL, data);
> +	}
> +}
> +
>  static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  					    bool enable)
>  {
>  	amdgpu_gfx_rlc_enter_safe_mode(adev);
>  
>  	if (enable) {
> +		/* enable FGCG firstly*/
> +		gfx_v10_0_update_fine_grain_clock_gating(adev, enable);
>  		/* CGCG/CGLS should be enabled after MGCG/MGLS
>  		 * ===  MGCG + MGLS ===
>  		 */
> @@ -7680,6 +7718,8 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  		gfx_v10_0_update_3d_clock_gating(adev, enable);
>  		/* ===  MGCG + MGLS === */
>  		gfx_v10_0_update_medium_grain_clock_gating(adev, enable);
> +		/* disable fgcg at last*/
> +		gfx_v10_0_update_fine_grain_clock_gating(adev, enable);
>  	}
>  
>  	if (adev->cg_flags &
> @@ -7848,6 +7888,11 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  	int data;
>  
> +	/* AMD_CG_SUPPORT_GFX_FGCG */
> +	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
> +	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK))
> +		*flags |= AMD_CG_SUPPORT_GFX_FGCG;
> +
>  	/* AMD_CG_SUPPORT_GFX_MGCG */
>  	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
>  	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))

The whole implementation can be slipped at 3 patches:

The FGCG programming can be put at the 2nd patch.

> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 1f8659a1a4cf..e33d8022cc32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -953,6 +953,7 @@ static int nv_common_early_init(void *handle)
>  			AMD_CG_SUPPORT_GFX_3D_CGLS |
>  			AMD_CG_SUPPORT_MC_MGCG |
>  			AMD_CG_SUPPORT_MC_LS |
> +			AMD_CG_SUPPORT_GFX_FGCG |
>  			AMD_CG_SUPPORT_VCN_MGCG |
>  			AMD_CG_SUPPORT_JPEG_MGCG;
>  		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |

The FGCG feature enabling for VanGogh can be put at the 3rd patch.

> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 412602d84f71..e59501bde5d2 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -144,6 +144,7 @@ enum amd_powergating_state {
>  #define AMD_CG_SUPPORT_ATHUB_LS			(1 << 28)
>  #define AMD_CG_SUPPORT_ATHUB_MGCG		(1 << 29)
>  #define AMD_CG_SUPPORT_JPEG_MGCG		(1 << 30)
> +#define AMD_CG_SUPPORT_GFX_FGCG         (1 << 31)
>  /* PG flags */
>  #define AMD_PG_SUPPORT_GFX_PG			(1 << 0)
>  #define AMD_PG_SUPPORT_GFX_SMG			(1 << 1)

For introducing a new flag, we would better use a separate patch at first.
If more asic uses this feature in future, that's able to avoid git-bisect
issue.

> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 080af05724ed..e57153d1fa24 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -39,6 +39,7 @@
>  #include "hwmgr.h"
>  
>  static const struct cg_flag_name clocks[] = {
> +	{AMD_CG_SUPPORT_GFX_FGCG, "Graphics Fine Grain Clock Gating"},
>  	{AMD_CG_SUPPORT_GFX_MGCG, "Graphics Medium Grain Clock Gating"},
>  	{AMD_CG_SUPPORT_GFX_MGLS, "Graphics Medium Grain memory Light Sleep"},
>  	{AMD_CG_SUPPORT_GFX_CGCG, "Graphics Coarse Grain Clock Gating"},

This part can be with AMD_CG_SUPPORT_GFX_FGCG definition on the first
patch.

Others look good for me.

Thanks,
Ray

> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

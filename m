Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D39C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 06:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB04206A1
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 06:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FeBUAiMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB04206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF93A6E3D6;
	Thu,  9 Jul 2020 06:10:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998736E03D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 06:10:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdGA0MIQiapHH8C30g29S4G3q0SLXGO8GF4CTHCkAACfyyW2SjVEHP/4h+U3MJ0rzxelfy6H7g9cpsr7Gx/SdmKs7umAHeoJFxjDJOhu/ZYERKBOjYUdv4nFO7nzqSqFSH4KvufDD4Q4lhIxYxUDGABa9ubzP9vkxSWZPh3KEqeOz0x1N6MqJUlt2nBdwAR/hB7OMiun3+YQBgVfIrRsxRbdcDxRcCIU+XYJjhVxiCItRN8Ji5KRSMc1n/KPape58e6llOlV5hMsRCvdYKQ499WGkaYOAG/EWj9vRYeC1eFRFlCTQmxCJWJROWhiX8ytsbym9VeWjgiE8xdCDT0lMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHH0qUyZw2bSCKUYgSBvLMJoceVh1liA17tStKQT5aI=;
 b=DktuRnQ8e+fQIVA433lZVLrkl97+QH8+t7ErLucsF6QPui3alQy+PV7rA5xDR/lOvi2UF5sux1dM6kI1TAlvO1F0lX/r4x74Qg00QBOeLjpLKgvGo7OjH6R4ayjQjBhIz2QRv1ihWttPgdWWgFLnEcf0qLHpyE6eFNgv3qsVCGS/QxFS0nuqDHqc6INuRWGML2GRFnZZBoX77aPtVbxUdkDbf1dwvB4jTiSVNgkbph1nv0YuqLgW6xRo6cFdvlcEiYkfxglO0Ge5XdPQoVNOXHuDFFkMnPfO3xQ7g2CY3gV65YNtCXw/D0G8BFjyCZHkwvuoObFhI4XuuTaCgCVDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHH0qUyZw2bSCKUYgSBvLMJoceVh1liA17tStKQT5aI=;
 b=FeBUAiMdQA2jDlUoiMRIH/RRx9U1lNuf4nCPycUVv/lifv855XZ9RALKCysEhxy/BB2u3Ydx6TsSgk+bv4jTdYyq0hocNy2zcj1iVYQf+F1dzuY8Cxgz0/EJuJUBae5R5lpuxrD5hvqnNO3v8CNw8cCLaAEQm7CSqDs8jytfCKA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 06:10:06 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3174.022; Thu, 9 Jul 2020
 06:10:06 +0000
Date: Thu, 9 Jul 2020 14:09:57 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/display: add mechanism to skip DCN init"
Message-ID: <20200709060957.GA3530712@hr-amd>
References: <20200709053253.24653-1-changfeng.zhu@amd.com>
Content-Disposition: inline
In-Reply-To: <20200709053253.24653-1-changfeng.zhu@amd.com>
X-ClientProxiedBy: HK2PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:202:17::25) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR03CA0055.apcprd03.prod.outlook.com (2603:1096:202:17::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Thu, 9 Jul 2020 06:10:04 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c3d6e308-0015-4c41-0346-08d823ceb9a1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4191B845869EBE26AD3E8B79EC640@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3Oo0h5md7UlNFTXHyWaGs4Fh0p+BORkxRcsyUgoAXuY9qriNDAdukS5Lly+UXGE7ZQq19NvffFqknD8rW0+5dWgnKTE2JE3uXUBrxv6fvGPythDxegH9NQRQB7jiCRHCLKEQDbNaHOgBxzphEWZ2NEyDQJRctOF0NLJmz4v4Fp4I+I/Q/O5hBFTFWmT/ZOlL4XcVBYoLBzzid1drXaGjut1gobsf25bMVLfwHIF00rm10nFo/rGjJ/IDE93jWs2rG6PMdwvH7rwPGLUmkLAiH2YErKP275JX4bqhQoTAA/6yruxSlSWGPhrqLrp6QXOFPCk7p7vIaGDPi2AnhD+qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(478600001)(26005)(4326008)(86362001)(52116002)(6636002)(956004)(16526019)(2906002)(186003)(83380400001)(33716001)(30864003)(8936002)(8676002)(5660300002)(6496006)(6666004)(316002)(66946007)(66476007)(6862004)(66556008)(33656002)(9686003)(55016002)(54906003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AKpvqfsT4BfmH5+9j/uD/d/TdR5s6yE/d8xGDYEAgOZjUmV8TLye6FZDOiLhDeuvcBwlqS/uElFbgIwS3G3kyO7LeWYBibcTBOt/UpV8IUiZW3aAl405I1BsXoDwLs2pTjEbWdp7QPos/fx5LFRl2cJXvjLdHcEDYygviszbm0sYyV1MvYCurKA4h38qxAkx4tbu16bglYayPG37ku/JnIGJGcji89wR/nuMeam4YtKRyzBkDnmehhozwhcnOisqnngb3FlY3Hykqy59GoQoVe5Xz23X1oHET4BBDULA1cn/I/VkEXoVrhevQ3VzGYt3r7XtW+yOeMp/cliGrahOS54LPzndEjjO/08G7SbHOS0Zi3v0Yjv82GtGR7iAdYBIdY6b2PpXQYCtUB3WH5y4haTblruGqplfh5HCFK0R356X00jUnIs3keoGy0nTNASSU6UAENjk02Y4waf+hC1QuQRNwf5iplQeDkxX9FNBWFvycuA1Y2eB+tpRanLgy7+2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d6e308-0015-4c41-0346-08d823ceb9a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 06:10:06.2084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6x88N3rcRmKdG/tdXD+CDd6DT/Knb05Ef9XdMaJu0HTMxHVQyaNkAXkLyWq/LGZlHN7iv5ZRw0tZHJYAiCq/SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Yang,
 Eric" <Eric.Yang2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 09, 2020 at 01:32:53PM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> From: Changfeng <Changfeng.Zhu@amd.com>
> 
> To avoid s3 faild at the first cycle on renoir platform, it
> needs to revert this patch:
> drm/amd/display: add mechanism to skip DCN init
> 
> Change-Id: Idca8933d728531fb68ea2ff00c6c8d77d2a3cdca
> Signed-off-by: changfeng <Changfeng.Zhu@amd.com>

Ackedy-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 28 +++++++++----
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  2 -
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  4 +-
>  drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  5 +--
>  .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 15 -------
>  .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  4 --
>  .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c | 10 +++++
>  .../gpu/drm/amd/display/dmub/src/dmub_dcn21.h |  6 +++
>  .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 40 ++++++++++++++-----
>  10 files changed, 72 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 67402d75e67e..db5feb89d4af 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2681,7 +2681,6 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
>  	dal_irq_service_ack(dc->res_pool->irqs, src);
>  }
>  
> -
>  void dc_set_power_state(
>  	struct dc *dc,
>  	enum dc_acpi_cm_power_state power_state)
> @@ -2693,6 +2692,9 @@ void dc_set_power_state(
>  	case DC_ACPI_CM_POWER_STATE_D0:
>  		dc_resource_state_construct(dc, dc->current_state);
>  
> +		if (dc->ctx->dmub_srv)
> +			dc_dmub_srv_wait_phy_init(dc->ctx->dmub_srv);
> +
>  		dc->hwss.init_hw(dc);
>  
>  		if (dc->hwss.init_sys_ctx != NULL &&
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index 96532f7ba480..eea2429ac67d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -106,17 +106,29 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
>  		DC_ERROR("Error waiting for DMUB idle: status=%d\n", status);
>  }
>  
> -bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
> +void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv)
>  {
> -	struct dmub_srv *dmub;
> -	union dmub_fw_boot_status status;
> +	struct dmub_srv *dmub = dc_dmub_srv->dmub;
> +	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
> +	enum dmub_status status;
>  
> -	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
> -		return false;
> +	for (;;) {
> +		/* Wait up to a second for PHY init. */
> +		status = dmub_srv_wait_for_phy_init(dmub, 1000000);
> +		if (status == DMUB_STATUS_OK)
> +			/* Initialization OK */
> +			break;
>  
> -	dmub = dc_dmub_srv->dmub;
> +		DC_ERROR("DMCUB PHY init failed: status=%d\n", status);
> +		ASSERT(0);
>  
> -	status = dmub->hw_funcs.get_fw_status(dmub);
> +		if (status != DMUB_STATUS_TIMEOUT)
> +			/*
> +			 * Server likely initialized or we don't have
> +			 * DMCUB HW support - this won't end.
> +			 */
> +			break;
>  
> -	return status.bits.optimized_init_done;
> +		/* Continue spinning so we don't hang the ASIC. */
> +	}
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
> index 8bd20d0d7689..a3a09ccb6d26 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
> @@ -56,6 +56,4 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
>  
>  void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv);
>  
> -bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv);
> -
>  #endif /* _DMUB_DC_SRV_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index cb45f05a0319..abb160b5c395 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -1288,9 +1288,7 @@ void dcn10_init_hw(struct dc *dc)
>  	if (!dcb->funcs->is_accelerated_mode(dcb))
>  		hws->funcs.disable_vga(dc->hwseq);
>  
> -	if (!dc_dmub_srv_optimized_init_done(dc->ctx->dmub_srv))
> -		hws->funcs.bios_golden_init(dc);
> -
> +	hws->funcs.bios_golden_init(dc);
>  	if (dc->ctx->dc_bios->fw_info_valid) {
>  		res_pool->ref_clocks.xtalin_clock_inKhz =
>  				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
> diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> index 3cac170312fc..c6a8d6c54621 100644
> --- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> +++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> @@ -264,10 +264,9 @@ struct dmub_srv_hw_funcs {
>  
>  	bool (*is_hw_init)(struct dmub_srv *dmub);
>  
> -	void (*enable_dmub_boot_options)(struct dmub_srv *dmub);
> -
> -	union dmub_fw_boot_status (*get_fw_status)(struct dmub_srv *dmub);
> +	bool (*is_phy_init)(struct dmub_srv *dmub);
>  
> +	bool (*is_auto_load_done)(struct dmub_srv *dmub);
>  
>  	void (*set_gpint)(struct dmub_srv *dmub,
>  			  union dmub_gpint_data_register reg);
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
> index 0cd78e745e7e..2c4a2fe9311d 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
> @@ -312,18 +312,3 @@ uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub)
>  {
>  	return REG_READ(DMCUB_SCRATCH7);
>  }
> -
> -union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub)
> -{
> -	union dmub_fw_boot_status status;
> -
> -	status.all = REG_READ(DMCUB_SCRATCH0);
> -	return status;
> -}
> -
> -void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub)
> -{
> -	union dmub_fw_boot_options boot_options = {0};
> -
> -	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
> -}
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
> index a27b509cd6fd..a316f260f6ac 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
> @@ -192,8 +192,4 @@ bool dmub_dcn20_is_gpint_acked(struct dmub_srv *dmub,
>  
>  uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub);
>  
> -void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub);
> -
> -union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub);
> -
>  #endif /* _DMUB_DCN20_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
> index a6047673c3f5..e8f488232e34 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
> @@ -51,4 +51,14 @@ const struct dmub_srv_common_regs dmub_srv_dcn21_regs = {
>  #undef DMUB_SF
>  };
>  
> +/* Shared functions. */
>  
> +bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub)
> +{
> +	return (REG_READ(DMCUB_SCRATCH0) == 3);
> +}
> +
> +bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub)
> +{
> +	return REG_READ(DMCUB_SCRATCH10) == 0;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
> index 8c4033ae4007..2bbea237137b 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
> @@ -32,4 +32,10 @@
>  
>  extern const struct dmub_srv_common_regs dmub_srv_dcn21_regs;
>  
> +/* Hardware functions. */
> +
> +bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub);
> +
> +bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub);
> +
>  #endif /* _DMUB_DCN21_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> index aa41dfa23020..08da423b24a1 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> @@ -153,16 +153,18 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
>  		funcs->set_gpint = dmub_dcn20_set_gpint;
>  		funcs->is_gpint_acked = dmub_dcn20_is_gpint_acked;
>  		funcs->get_gpint_response = dmub_dcn20_get_gpint_response;
> -		funcs->get_fw_status = dmub_dcn20_get_fw_boot_status;
> -		funcs->enable_dmub_boot_options = dmub_dcn20_enable_dmub_boot_options;
>  
> -		if (asic == DMUB_ASIC_DCN21)
> +		if (asic == DMUB_ASIC_DCN21) {
>  			dmub->regs = &dmub_srv_dcn21_regs;
>  
> +			funcs->is_auto_load_done = dmub_dcn21_is_auto_load_done;
> +			funcs->is_phy_init = dmub_dcn21_is_phy_init;
> +		}
>  #ifdef CONFIG_DRM_AMD_DC_DCN3_0
>  		if (asic == DMUB_ASIC_DCN30) {
>  			dmub->regs = &dmub_srv_dcn30_regs;
>  
> +			funcs->is_auto_load_done = dmub_dcn30_is_auto_load_done;
>  			funcs->backdoor_load = dmub_dcn30_backdoor_load;
>  			funcs->setup_windows = dmub_dcn30_setup_windows;
>  		}
> @@ -462,10 +464,6 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
>  		dmub_rb_init(&dmub->inbox1_rb, &rb_params);
>  	}
>  
> -	/* Report to DMUB what features are supported by current driver */
> -	if (dmub->hw_funcs.enable_dmub_boot_options)
> -		dmub->hw_funcs.enable_dmub_boot_options(dmub);
> -
>  	if (dmub->hw_funcs.reset_release)
>  		dmub->hw_funcs.reset_release(dmub);
>  
> @@ -526,10 +524,11 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
>  	if (!dmub->hw_init)
>  		return DMUB_STATUS_INVALID;
>  
> -	for (i = 0; i <= timeout_us; i += 100) {
> -		union dmub_fw_boot_status status = dmub->hw_funcs.get_fw_status(dmub);
> +	if (!dmub->hw_funcs.is_auto_load_done)
> +		return DMUB_STATUS_OK;
>  
> -		if (status.bits.dal_fw && status.bits.mailbox_rdy)
> +	for (i = 0; i <= timeout_us; i += 100) {
> +		if (dmub->hw_funcs.is_auto_load_done(dmub))
>  			return DMUB_STATUS_OK;
>  
>  		udelay(100);
> @@ -538,6 +537,27 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
>  	return DMUB_STATUS_TIMEOUT;
>  }
>  
> +enum dmub_status dmub_srv_wait_for_phy_init(struct dmub_srv *dmub,
> +					    uint32_t timeout_us)
> +{
> +	uint32_t i = 0;
> +
> +	if (!dmub->hw_init)
> +		return DMUB_STATUS_INVALID;
> +
> +	if (!dmub->hw_funcs.is_phy_init)
> +		return DMUB_STATUS_OK;
> +
> +	for (i = 0; i <= timeout_us; i += 10) {
> +		if (dmub->hw_funcs.is_phy_init(dmub))
> +			return DMUB_STATUS_OK;
> +
> +		udelay(10);
> +	}
> +
> +	return DMUB_STATUS_TIMEOUT;
> +}
> +
>  enum dmub_status dmub_srv_wait_for_idle(struct dmub_srv *dmub,
>  					uint32_t timeout_us)
>  {
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B78C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 14:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9988D2072A
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 14:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="miQhCEG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9988D2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2EC6E180;
	Wed,  4 Mar 2020 14:14:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9656E180
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 14:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjEPpxA54NIfclnI/+FfhiCWMwJRU4UVRUhad4q9/m8XOU5/KP9hPTWpsijayDOb+uhSSbwuPqbqLw6qJAzvbUn+uE/uGTcvUVaeMW9f5d55zcBrIxWd3MvvY80CL2K2pnt9aba31CI1UKk717pa8ho0KXVLnbGSToUzGJJ4Db2GVpM75nQ5YlyvwSwuBM0bjr4O3uuiDKrKF04iejjRuhpaeOzGwbQoeuqC34gf604ZC7JjBz/AiLl8sezupgoiP09qlLr1TTp0kw3KMQGmHsd/2/vuoxoK+9NHwg1EXlOsckFdF1eapAusMDHc+2pKlQkU31N7P6om2BpJABESuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfBGPWxIvvKaWOpOWu7eytqxTBKUp1zZtDeoR34F3do=;
 b=MwiAiUfGLrDJ0RCVG9XzA977oWV5mk/62E9l1H4G2erpMa1is07sIB2p2DwOzfIpgG7nADbtx1Mt/IFZBr56LbM9lyDTF/GU2wxQomiccHz5m2iQWrgrm1TUOMY6Fdtd6u3k/ZSp0VPxEiqTSobBl+TiyZL8W8H5CnhtQ60T1Rk1R1ERImU+EU1Pj+XGNRXi3RdQw//uY5iLPi7qe3emoHqOtGIUL5FXvyxs60lAoivcfg2AoiA8hpuDzR3ZbT34Y7NJWinQjfLvIIrSH1tfzM9ym0BiLml6OWXX5F/3cr47BtymGS5s9siY4sIa8ZgbfYo2/0PvfvfQ/26hPtmCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfBGPWxIvvKaWOpOWu7eytqxTBKUp1zZtDeoR34F3do=;
 b=miQhCEG6/0qeNbTlkgDEPE5ltWVFPG3vueEUcLOrt+/O+mbn3UHhTc/0aHthQbM13zCXqeUxdj1OSs8WjbdjAQ2t4aP7TR2CGfatDUBV3EYh2EMf9d8yB4oIHfD2Gcw1nh0ndQfXZqFDExENTsgcOdWh+qxhAJ2XAsfqubMvYYM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Wed, 4 Mar
 2020 14:14:15 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d%5]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 14:14:15 +0000
Subject: Re: [PATCH 01/12] drm/amd/display: update soc bb for nv14
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
 <20200303232718.351364-2-Rodrigo.Siqueira@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <b74dbb45-4373-f7c7-b108-52974e40c113@amd.com>
Date: Wed, 4 Mar 2020 09:14:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200303232718.351364-2-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::28) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.1.94] (165.204.55.250) by
 YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 14:14:14 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1f9075d-0c1c-41a9-68b9-08d7c046520c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:|BYAPR12MB2806:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB280617AF3B13A25D64D0BD86ECE50@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(31686004)(8936002)(31696002)(6486002)(4326008)(478600001)(36756003)(81166006)(2906002)(8676002)(81156014)(2616005)(26005)(956004)(52116002)(53546011)(86362001)(16526019)(186003)(5660300002)(316002)(66476007)(66556008)(16576012)(54906003)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2806;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JimQBuSyZftyTrsH9EP+ulHMX3MjH3/6qzZmNYETR1XhPUZA3lANBwoFyHvxC2u7zi+yH2CZdWIMJTho0Ng4/LJYArssH/wlSTUb2qbl6uE4o7q+1hsqZERWY1a1iNkbd41Zzf/gsNRrT0yMcswBWaBOdzti7PEdaeTvEgL4dR5xlE9P/hybh91lHs2xyi4/pLDrSl9/rgHrfO/en3yhHlEx0hTb1p5ZHkXR6ky0yVlxsNZd6jpONwYD2cGGtLgqq6fMZlXp+08jT6EcT1DDsW5t158+w2JDwOip6c7qnfIVdW+xGBwuDXnbWYqnPg6cPpuNnVNhODOvbPWiR4WhnNiL/r85EWdq+70l5J0kBh/F8Qdsr5hDvD7mc4u8FGZCHWdQSANIVNjhNaAU6C+3BjFY6Np+COWk+ujH7HqICt82W2mPnkUEgU1BTPJLlBaz
X-MS-Exchange-AntiSpam-MessageData: OUuoABfymx3E3www0XRh5W7liDz4WtqfNKS3joE7yTyesoT98K3eO2XErv6p1u7ZmYtws7ysZW0GIieFhdqN5qWXNBudN+elIp954ZtmrFLNsjDyIzavfFlxA7tcB50C4vKvPca0+hKNuSGbt+YmtQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f9075d-0c1c-41a9-68b9-08d7c046520c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 14:14:15.5751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqUqwhmbLyGvsyjOqPqG+36/LxGoLolmcay+lYHd3Q2+8suo3yyL9K+E8TrhQaNct85Qpz3aUxnjWtKfl2C0pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Harry.Wentland@amd.com, Martin Leung <martin.leung@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-03 6:27 p.m., Rodrigo Siqueira wrote:
> From: Martin Leung <martin.leung@amd.com>
> 
> [why]
> nv14 previously inherited soc bb from generic dcn 2, did not match
> watermark values according to memory team
> 
> [how]
> add nv14 specific soc bb: copy nv2 generic that it was
> using from before, but changed num channels to 8
> 
> Signed-off-by: Martin Leung <martin.leung@amd.com>
> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   .../drm/amd/display/dc/dcn20/dcn20_resource.c | 113 +++++++++++++++++-
>   1 file changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index c629a7b45f56..c8b85f62ae95 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -337,6 +337,117 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_0_soc = {
>   	.use_urgent_burst_bw = 0
>   };
>   
> +struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv14_soc = {
> +	.clock_limits = {
> +			{
> +				.state = 0,
> +				.dcfclk_mhz = 560.0,
> +				.fabricclk_mhz = 560.0,
> +				.dispclk_mhz = 513.0,
> +				.dppclk_mhz = 513.0,
> +				.phyclk_mhz = 540.0,
> +				.socclk_mhz = 560.0,
> +				.dscclk_mhz = 171.0,
> +				.dram_speed_mts = 8960.0,
> +			},
> +			{
> +				.state = 1,
> +				.dcfclk_mhz = 694.0,
> +				.fabricclk_mhz = 694.0,
> +				.dispclk_mhz = 642.0,
> +				.dppclk_mhz = 642.0,
> +				.phyclk_mhz = 600.0,
> +				.socclk_mhz = 694.0,
> +				.dscclk_mhz = 214.0,
> +				.dram_speed_mts = 11104.0,
> +			},
> +			{
> +				.state = 2,
> +				.dcfclk_mhz = 875.0,
> +				.fabricclk_mhz = 875.0,
> +				.dispclk_mhz = 734.0,
> +				.dppclk_mhz = 734.0,
> +				.phyclk_mhz = 810.0,
> +				.socclk_mhz = 875.0,
> +				.dscclk_mhz = 245.0,
> +				.dram_speed_mts = 14000.0,
> +			},
> +			{
> +				.state = 3,
> +				.dcfclk_mhz = 1000.0,
> +				.fabricclk_mhz = 1000.0,
> +				.dispclk_mhz = 1100.0,
> +				.dppclk_mhz = 1100.0,
> +				.phyclk_mhz = 810.0,
> +				.socclk_mhz = 1000.0,
> +				.dscclk_mhz = 367.0,
> +				.dram_speed_mts = 16000.0,
> +			},
> +			{
> +				.state = 4,
> +				.dcfclk_mhz = 1200.0,
> +				.fabricclk_mhz = 1200.0,
> +				.dispclk_mhz = 1284.0,
> +				.dppclk_mhz = 1284.0,
> +				.phyclk_mhz = 810.0,
> +				.socclk_mhz = 1200.0,
> +				.dscclk_mhz = 428.0,
> +				.dram_speed_mts = 16000.0,
> +			},
> +			/*Extra state, no dispclk ramping*/
> +			{
> +				.state = 5,
> +				.dcfclk_mhz = 1200.0,
> +				.fabricclk_mhz = 1200.0,
> +				.dispclk_mhz = 1284.0,
> +				.dppclk_mhz = 1284.0,
> +				.phyclk_mhz = 810.0,
> +				.socclk_mhz = 1200.0,
> +				.dscclk_mhz = 428.0,
> +				.dram_speed_mts = 16000.0,
> +			},
> +		},
> +	.num_states = 5,
> +	.sr_exit_time_us = 8.6,
> +	.sr_enter_plus_exit_time_us = 10.9,
> +	.urgent_latency_us = 4.0,
> +	.urgent_latency_pixel_data_only_us = 4.0,
> +	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
> +	.urgent_latency_vm_data_only_us = 4.0,
> +	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
> +	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
> +	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
> +	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 40.0,
> +	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 40.0,
> +	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 40.0,
> +	.max_avg_sdp_bw_use_normal_percent = 40.0,
> +	.max_avg_dram_bw_use_normal_percent = 40.0,
> +	.writeback_latency_us = 12.0,
> +	.ideal_dram_bw_after_urgent_percent = 40.0,
> +	.max_request_size_bytes = 256,
> +	.dram_channel_width_bytes = 2,
> +	.fabric_datapath_to_dcn_data_return_bytes = 64,
> +	.dcn_downspread_percent = 0.5,
> +	.downspread_percent = 0.38,
> +	.dram_page_open_time_ns = 50.0,
> +	.dram_rw_turnaround_time_ns = 17.5,
> +	.dram_return_buffer_per_channel_bytes = 8192,
> +	.round_trip_ping_latency_dcfclk_cycles = 131,
> +	.urgent_out_of_order_return_per_channel_bytes = 256,
> +	.channel_interleave_bytes = 256,
> +	.num_banks = 8,
> +	.num_chans = 8,
> +	.vmm_page_size_bytes = 4096,
> +	.dram_clock_change_latency_us = 404.0,
> +	.dummy_pstate_latency_us = 5.0,
> +	.writeback_dram_clock_change_latency_us = 23.0,
> +	.return_bus_width_bytes = 64,
> +	.dispclk_dppclk_vco_speed_mhz = 3850,
> +	.xfc_bus_transport_time_us = 20,
> +	.xfc_xbuf_latency_tolerance_us = 4,
> +	.use_urgent_burst_bw = 0
> +};
> +
>   struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = { 0 };
>   
>   #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
> @@ -3298,7 +3409,7 @@ static struct _vcs_dpi_soc_bounding_box_st *get_asic_rev_soc_bb(
>   	uint32_t hw_internal_rev)
>   {
>   	if (ASICREV_IS_NAVI12_P(hw_internal_rev))
> -		return &dcn2_0_nv12_soc;
> +		return &dcn2_0_nv14_soc;

Are you sure this is correct? Shouldn't be checking that the ASICREV is 
Navi14 here, not Navi12?

Nicholas Kazlauskas

>   
>   	return &dcn2_0_soc;
>   }
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

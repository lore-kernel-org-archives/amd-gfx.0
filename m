Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D615C2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFEB5206B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zMMG4GCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEB5206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6576E0E0;
	Mon,  6 Apr 2020 18:58:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5A66E0E0
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 18:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiwH9sd/f3Xo0DgxCQR2BOdODUfXI3akCs8fuyMORTmVRLyyBYMpS8GNR3+MTcHj/LHcap0A4HlbadbqPKQSxitjjmdze6ct6f8DFTHkbBciOzsjD/2QB2E+IIaHRn2eJ4+OzvkKoqgNoQFGoquUkEWUTVEqZADDrq1YBXO2Eo7ZZKiFfTKFvGdKb05BIeulgXEBb3sSWplcGg4xgShGosgrp+EKOO96I3M5JmyYUEtGQX7CBqgxCrAsQplRjQOWpi2OVnOYO4SROzGYL03VxGaw6bgCyAyA1hegFKpFybwt/7dd2l9TtC3wtY211u4BVwj9qQHCMC34Q/lIQOiPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSZS9qkmry+2uIFFMXaPwVRZU9QBjYNowfExInBOXho=;
 b=Qeg1UkPPjsOj+MZg+Flc/L7gkrRuA0iCwFPFcvk+K4P79fFNZFf+5poFx06VxEoeZARTHkOqDkH9qX6oBGIrSzE8AkXyvtnco00T40JWkRK5qOT9VGZr9DTBV4NWJHWvRCC5pcH3y3ywq7uJNxO04v/KgCXl/gRLivvpjVhZLzx+W5vQbVTaD1HG0bBp+KVnFTOT9d8mgkwWozInOUlnwnnDhk94tp62Drbmbebk/ofVsq+T2tjDXsrqoF1r2SLuJdgScOLR4vRzP0CJzkEW9LcYic/gKncxhJ4iRGwmK/oL5kmhWG5oMS8sR2tNdPLNdNIsUN+5BCBuN2rxL4dWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSZS9qkmry+2uIFFMXaPwVRZU9QBjYNowfExInBOXho=;
 b=zMMG4GCFfBeoemH1CEcrPAueXlZ5+VLG8D2KZqHW4Hzlc/bTM8hJ1uDuiwPgN86WqGFgtYCsD0rgxPNxko2PjLZfe5e7zrSJMbI+GQpnJ/bI0Cz26U+sNEeVS8uD7RKMCX0fp41sCcn4AyQSGf70tX1M0PHm0x4fwc2y72f5EEw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mikita.Lipski@amd.com; 
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 18:58:28 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::cd57:c685:c45c:8c07]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::cd57:c685:c45c:8c07%6]) with mapi id 15.20.2878.014; Mon, 6 Apr 2020
 18:58:28 +0000
Subject: Re: [PATCH 1/2] drm/amd/display: query hdcp capability during link
 detect
To: amd-gfx@lists.freedesktop.org, Bhawanpreet.Lakha@amd.com
References: <20200401210031.23220-1-Bhawanpreet.Lakha@amd.com>
From: Mikita Lipski <mlipski@amd.com>
Message-ID: <526ccd37-d3b2-5e0f-63a3-9cdc3418618b@amd.com>
Date: Mon, 6 Apr 2020 14:58:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200401210031.23220-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::31) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:56a0:7ef:6175:9498:17a5:c58f]
 (2607:fea8:56a0:7ef:6175:9498:17a5:c58f) by
 YTOPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Mon, 6 Apr 2020 18:58:27 +0000
X-Originating-IP: [2607:fea8:56a0:7ef:6175:9498:17a5:c58f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9161a805-b9b1-4ac0-007f-08d7da5c7dde
X-MS-TrafficTypeDiagnostic: DM6PR12MB4220:|DM6PR12MB4220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42205B36F193E9395BAAB57EE4C20@DM6PR12MB4220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2906.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(5660300002)(31696002)(66556008)(81156014)(81166006)(8936002)(36756003)(8676002)(478600001)(66476007)(316002)(52116002)(16526019)(186003)(2616005)(31686004)(2906002)(53546011)(6636002)(6486002)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEtT0x2Q6uR1tE5hdCtk5U+K0OSTe+0NE9zGLo7SVeJeEfiblAwBuivqt3SOEYlHTagrvVpv4RhkCPYjZvlUOP/4C+SuYq7IgoyIAQhdEXfSW1ZcRGZDcebKRaPaSo+WwKKOGlL9Ta1r6eApNwv4PC7vPd20ul2StwT2uC1YsGuSZRo/QOfBVTxsyfoc5pKS2hta0gotcS4YgKrc6devjao8Lq8WOo5+qc+duEEx2dvVVtcruBCxU5EnSxlulUHkcYnzsm1N8s+IfNYzH+kUFc7HoE9EzSFD0NSeeDhwZDrAIsy/qDWLRpwDxSFoXOEA1YEzHcs1JD4qBLBxp1eYqeyHtMWpHIbo+12whQ9KA80WoDkkdkn1/hIgpe9r7AnETzObzxa4yTp6XfF3T1SMus0uv8VHqJ8asRkOog4sjdEY9BNvRMFUmY9VhLn1+BSP
X-MS-Exchange-AntiSpam-MessageData: OXx/KWJYrX41NRllKPQqAj6rc2BnVNdAIyCf45iUFlY6na4vlr36EWMEg70XTU/ZoolzbhPvEvIIC4hlRAgnGkcFLkrpZlfECDA3pfFSNfMfjGKnDYyWgI+ph9p9axsdCwOEEacy18K+84pTWL9mDboDkR+Mxi+6elS2F6VPXSJpjbtLYTqCTVvfBlENNaKW/ypT07AxgducxzLNNn//AA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9161a805-b9b1-4ac0-007f-08d7da5c7dde
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 18:58:28.2020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOelTfyp8qfIVCMnQFSyWaSlPBzpVziT6oNIbFMEBpin29dsc7BPi7LsgsSYxs81
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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

Both patches look good to me.

The series is Reviewed-by: Mikita Lipski <mikita.lipski@amd.com>

Thanks,
Mikita

On 2020-04-01 5:00 p.m., Bhawanpreet Lakha wrote:
> [Why]
> Query the hdcp caps of a link, it is useful and can be reported to the user
> 
> [How]
> Create a query function and call it during link detect
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 56 ++++++++++++
>   drivers/gpu/drm/amd/display/dc/dc.h           | 41 +++++++++
>   drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +
>   .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    | 89 +++++++++++++++++++
>   .../gpu/drm/amd/display/include/hdcp_types.h  |  7 ++
>   5 files changed, 196 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index a93997ff0419..49c63e27dfe9 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -514,6 +514,50 @@ static void link_disconnect_remap(struct dc_sink *prev_sink, struct dc_link *lin
>   	link->local_sink = prev_sink;
>   }
>   
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
> +{
> +	struct hdcp_protection_message msg22;
> +	struct hdcp_protection_message msg14;
> +
> +	memset(&msg22, 0, sizeof(struct hdcp_protection_message));
> +	memset(&msg14, 0, sizeof(struct hdcp_protection_message));
> +	memset(link->hdcp_caps.rx_caps.raw, 0,
> +		sizeof(link->hdcp_caps.rx_caps.raw));
> +
> +	if ((link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
> +			link->ddc->transaction_type ==
> +			DDC_TRANSACTION_TYPE_I2C_OVER_AUX) ||
> +			link->connector_signal == SIGNAL_TYPE_EDP) {
> +		msg22.data = link->hdcp_caps.rx_caps.raw;
> +		msg22.length = sizeof(link->hdcp_caps.rx_caps.raw);
> +		msg22.msg_id = HDCP_MESSAGE_ID_RX_CAPS;
> +	} else {
> +		msg22.data = &link->hdcp_caps.rx_caps.fields.version;
> +		msg22.length = sizeof(link->hdcp_caps.rx_caps.fields.version);
> +		msg22.msg_id = HDCP_MESSAGE_ID_HDCP2VERSION;
> +	}
> +	msg22.version = HDCP_VERSION_22;
> +	msg22.link = HDCP_LINK_PRIMARY;
> +	msg22.max_retries = 5;
> +	dc_process_hdcp_msg(signal, link, &msg22);
> +
> +	if (signal == SIGNAL_TYPE_DISPLAY_PORT || signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
> +		enum hdcp_message_status status = HDCP_MESSAGE_UNSUPPORTED;
> +
> +		msg14.data = &link->hdcp_caps.bcaps.raw;
> +		msg14.length = sizeof(link->hdcp_caps.bcaps.raw);
> +		msg14.msg_id = HDCP_MESSAGE_ID_READ_BCAPS;
> +		msg14.version = HDCP_VERSION_14;
> +		msg14.link = HDCP_LINK_PRIMARY;
> +		msg14.max_retries = 5;
> +
> +		status = dc_process_hdcp_msg(signal, link, &msg14);
> +	}
> +
> +}
> +#endif
> +
>   static void read_current_link_settings_on_detect(struct dc_link *link)
>   {
>   	union lane_count_set lane_count_set = { {0} };
> @@ -606,6 +650,12 @@ static bool detect_dp(struct dc_link *link,
>   			dal_ddc_service_set_transaction_type(link->ddc,
>   							     sink_caps->transaction_type);
>   
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +			/* In case of fallback to SST when topology discovery below fails
> +			 * HDCP caps will be querried again later by the upper layer (caller
> +			 * of this function). */
> +			query_hdcp_capability(SIGNAL_TYPE_DISPLAY_PORT_MST, link);
> +#endif
>   			/*
>   			 * This call will initiate MST topology discovery. Which
>   			 * will detect MST ports and add new DRM connector DRM
> @@ -975,6 +1025,9 @@ static bool dc_link_detect_helper(struct dc_link *link,
>   			 * TODO debug why Dell 2413 doesn't like
>   			 *  two link trainings
>   			 */
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +			query_hdcp_capability(sink->sink_signal, link);
> +#endif
>   
>   			// verify link cap for SST non-seamless boot
>   			if (!perform_dp_seamless_boot)
> @@ -988,6 +1041,9 @@ static bool dc_link_detect_helper(struct dc_link *link,
>   				sink = prev_sink;
>   				prev_sink = NULL;
>   			}
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +			query_hdcp_capability(sink->sink_signal, link);
> +#endif
>   		}
>   
>   		/* HDMI-DVI Dongle */
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 92123b0d1196..9235d04c32dc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -29,6 +29,9 @@
>   #include "dc_types.h"
>   #include "grph_object_defs.h"
>   #include "logger_types.h"
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +#include "hdcp_types.h"
> +#endif
>   #include "gpio_types.h"
>   #include "link_service_types.h"
>   #include "grph_object_ctrl_defs.h"
> @@ -1004,6 +1007,35 @@ union dpcd_sink_ext_caps {
>   	uint8_t raw;
>   };
>   
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +union hdcp_rx_caps {
> +	struct {
> +		uint8_t version;
> +		uint8_t reserved;
> +		struct {
> +			uint8_t repeater	: 1;
> +			uint8_t hdcp_capable	: 1;
> +			uint8_t reserved	: 6;
> +		} byte0;
> +	} fields;
> +	uint8_t raw[3];
> +};
> +
> +union hdcp_bcaps {
> +	struct {
> +		uint8_t HDCP_CAPABLE:1;
> +		uint8_t REPEATER:1;
> +		uint8_t RESERVED:6;
> +	} bits;
> +	uint8_t raw;
> +};
> +
> +struct hdcp_caps {
> +	union hdcp_rx_caps rx_caps;
> +	union hdcp_bcaps bcaps;
> +};
> +#endif
> +
>   #include "dc_link.h"
>   
>   /*******************************************************************************
> @@ -1107,6 +1139,15 @@ void dc_resume(struct dc *dc);
>   unsigned int dc_get_current_backlight_pwm(struct dc *dc);
>   unsigned int dc_get_target_backlight_pwm(struct dc *dc);
>   
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +/*
> + * HDCP Interfaces
> + */
> +enum hdcp_message_status dc_process_hdcp_msg(
> +		enum signal_type signal,
> +		struct dc_link *link,
> +		struct hdcp_protection_message *message_info);
> +#endif
>   bool dc_is_dmcu_initialized(struct dc *dc);
>   
>   enum dc_status dc_set_clock(struct dc *dc, enum dc_clock_type clock_type, uint32_t clk_khz, uint32_t stepping);
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
> index 00ff5e98278c..0077f9dcd07c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_link.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
> @@ -126,6 +126,9 @@ struct dc_link {
>   	uint32_t dongle_max_pix_clk;
>   	unsigned short chip_caps;
>   	unsigned int dpcd_sink_count;
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +	struct hdcp_caps hdcp_caps;
> +#endif
>   	enum edp_revision edp_revision;
>   	bool psr_feature_enabled;
>   	bool psr_allow_active;
> diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
> index 6f730b5bfe42..5e384a8a83dc 100644
> --- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
> +++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
> @@ -322,3 +322,92 @@ static const struct protection_properties dp_11_protection = {
>   	.process_transaction = dp_11_process_transaction
>   };
>   
> +static const struct protection_properties *get_protection_properties_by_signal(
> +	struct dc_link *link,
> +	enum signal_type st,
> +	enum hdcp_version version)
> +{
> +	switch (version) {
> +	case HDCP_VERSION_14:
> +		switch (st) {
> +		case SIGNAL_TYPE_DVI_SINGLE_LINK:
> +		case SIGNAL_TYPE_DVI_DUAL_LINK:
> +		case SIGNAL_TYPE_HDMI_TYPE_A:
> +			return &hdmi_14_protection;
> +		case SIGNAL_TYPE_DISPLAY_PORT:
> +			if (link &&
> +				(link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_VGA_CONVERTER ||
> +				link->dpcd_caps.dongle_caps.dongle_type == DISPLAY_DONGLE_DP_VGA_CONVERTER)) {
> +				return &non_supported_protection;
> +			}
> +			return &dp_11_protection;
> +		case SIGNAL_TYPE_DISPLAY_PORT_MST:
> +		case SIGNAL_TYPE_EDP:
> +			return &dp_11_protection;
> +		default:
> +			return &non_supported_protection;
> +		}
> +		break;
> +	case HDCP_VERSION_22:
> +		switch (st) {
> +		case SIGNAL_TYPE_DVI_SINGLE_LINK:
> +		case SIGNAL_TYPE_DVI_DUAL_LINK:
> +		case SIGNAL_TYPE_HDMI_TYPE_A:
> +			return &hdmi_14_protection; //todo version2.2
> +		case SIGNAL_TYPE_DISPLAY_PORT:
> +		case SIGNAL_TYPE_DISPLAY_PORT_MST:
> +		case SIGNAL_TYPE_EDP:
> +			return &dp_11_protection;  //todo version2.2
> +		default:
> +			return &non_supported_protection;
> +		}
> +		break;
> +	default:
> +		return &non_supported_protection;
> +	}
> +}
> +
> +enum hdcp_message_status dc_process_hdcp_msg(
> +	enum signal_type signal,
> +	struct dc_link *link,
> +	struct hdcp_protection_message *message_info)
> +{
> +	enum hdcp_message_status status = HDCP_MESSAGE_FAILURE;
> +	uint32_t i = 0;
> +
> +	const struct protection_properties *protection_props;
> +
> +	if (!message_info)
> +		return HDCP_MESSAGE_UNSUPPORTED;
> +
> +	if (message_info->msg_id < HDCP_MESSAGE_ID_READ_BKSV ||
> +		message_info->msg_id >= HDCP_MESSAGE_ID_MAX)
> +		return HDCP_MESSAGE_UNSUPPORTED;
> +
> +	protection_props =
> +		get_protection_properties_by_signal(
> +			link,
> +			signal,
> +			message_info->version);
> +
> +	if (!protection_props->supported)
> +		return HDCP_MESSAGE_UNSUPPORTED;
> +
> +	if (protection_props->process_transaction(
> +		link,
> +		message_info)) {
> +		status = HDCP_MESSAGE_SUCCESS;
> +	} else {
> +		for (i = 0; i < message_info->max_retries; i++) {
> +			if (protection_props->process_transaction(
> +						link,
> +						message_info)) {
> +				status = HDCP_MESSAGE_SUCCESS;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return status;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/display/include/hdcp_types.h b/drivers/gpu/drm/amd/display/include/hdcp_types.h
> index f31e6befc8d6..42229b4effdc 100644
> --- a/drivers/gpu/drm/amd/display/include/hdcp_types.h
> +++ b/drivers/gpu/drm/amd/display/include/hdcp_types.h
> @@ -83,6 +83,12 @@ enum hdcp_link {
>   	HDCP_LINK_SECONDARY
>   };
>   
> +enum hdcp_message_status {
> +	HDCP_MESSAGE_SUCCESS,
> +	HDCP_MESSAGE_FAILURE,
> +	HDCP_MESSAGE_UNSUPPORTED
> +};
> +
>   struct hdcp_protection_message {
>   	enum hdcp_version version;
>   	/* relevant only for DVI */
> @@ -91,6 +97,7 @@ struct hdcp_protection_message {
>   	uint32_t length;
>   	uint8_t max_retries;
>   	uint8_t *data;
> +	enum hdcp_message_status status;
>   };
>   
>   #endif
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

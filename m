Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C982BCCA47B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 14:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7C910E1BC;
	Fri,  8 Jul 2022 14:39:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F9410E196
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 14:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTf0YTofXfWnIVdVL4NGGtvmN6yslK1ZomyjVfJfOagEZJIyE4I8rsH1sXO/3yeo+WZdFwElG6pABbEgr5K4jW9ajjnkJUpNgSVAGsZPqxiXbD5xI7dk37mwdgBOvR8mcSx7tT4oppbFg0f1XWa7i/jWFSZKODDe5xNLBfyafQDBoM3EvMxJ0d4gMMq05Y0zAUq0OOxOtaH41cD6Eb3T3TZALE/xLiesnTvaBtixjGrdcWz2qoeIvGKjCkiArrR35NAmBdEVqsaLp9l2eq4isEeMjmBUUdCwJuJ4GKvbnhged1DvVjwOz/lmI4TYXf6187b+wO+qdp5ABs6R4Vnqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hurjhe4Elj6Aoba/mGcWfRKcbZgYZ3JK5fN2IzKfM0k=;
 b=mP+O4io6ODbXckZa+zpsjEaEUX6mY5Vcj4x0s97JPKRiqzWBWg0I8j+6jqbl7vXjhdsNcnn/2RdL/kRh219r6GcTaCT+JN6gXyOow/+UyujLjXC9zMPERXDQc/GUshfU1b9A4FoIWh/1vhiVS98Yk8REDNghBCgjk0eKtAfLgMWWRSU7PMLmlmfUdUmZd8VR4yA6aOr2juc+ob/5EVyngMMMFqjHntYMYMxqiP8noH24h6ip1mev3hz4YO/JQjI9ztti6SLvhclB50CgxZebAFw0kGNdf3oaXa3UW42mZfu289FIKusdiioBbtKvhNcSBsa9SpqsJxn+MTbcFEeXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hurjhe4Elj6Aoba/mGcWfRKcbZgYZ3JK5fN2IzKfM0k=;
 b=iwnGfQ1R3S93NyaAAwNVrrkK6u//kxFzweAT00svYXi9IUvIxY1s0nuRS1kwiekQOlrjrZ3uI+s2rWC4aybOAdyZ3FbBsW378D7G8J8I8QKQHZjs5HtLIq2XTfW3JwuFMdWycxglwq38WgE0oWMksYDetD3LEeWb8RFFo/Zrm84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH2PR12MB4808.namprd12.prod.outlook.com (2603:10b6:610:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 14:39:25 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%7]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 14:39:25 +0000
Message-ID: <e30ebd73-3fd7-7dd8-4a17-57b5d23acd6b@amd.com>
Date: Fri, 8 Jul 2022 10:39:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: fix 32 bit compilation errors in
 dc_dmub_srv.c
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220708052650.1029150-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220708052650.1029150-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::33) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5456270-6bb7-4ebf-ebab-08da60efa779
X-MS-TrafficTypeDiagnostic: CH2PR12MB4808:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNDAvnkmO6Jw3uAEodOiQhs6beaaV4Vv8e3TWoMU7njntmorCTCgkz9Jp05rBUiiMrS5Uo8tLeL6eimgDhcv6xxNhYJX2du6S+HfTAzyvm8QYlqtg7HroGHKTCE/Nx4kyaINscBeGWCtrGQzsTT/CnNhSu7BQIUdeKJID+z+Nou/SO5THBiVJN7MqbuswLzj3GsJwhszYAgxGFimyxkW0zRiaWMijh3YXUTOHYsVBuyi21MUK4QpjGnp1mx1IYLDOluHjcIbWpaMJ/IFKMGE86/euPiyO3L8U5P7csgwLv0cy2uTtrZPRbxFmrZ3nHpdYL7vSf5I6fcWN8KB+TlaHUNuNxd7NN03k+pWy6Sz87mnixwLeWbaz56DH2lxdU/JeBOBKKEq5vllPbwCI978C2Ubi5aySqIv0CJmWwkandHjVlECq6yJJU3kMx/TkCTf561w2tY0xTSkZ64C8+3mdbv3L7KodIGjilWjEXfcxniLLnfdiAetc7Hzs46J0/GZ0qLlPCd6B1dbOzA0v5b+1CuYuzky41brG/iVG5GKsFO9lpSrdPd3MnY9dDwoeFPFauV42Ey9L39bETXlB0uZsWh8Dn4xa7YR2XJyDQW34o9QMkze/tld+xYL239xXgCLL0hsXlWn9E4U2eUCVeGDtiIyLfyAcb7T7+nqlfHCRXrXZARAVvxokiT9XV4cDOY7xzwQZz1d5gSDgdTWp9txlcC80xUMyW7XJqYcBP30uGmZ+EZObmWHCPTtaKSb+zbv6z1rfyxnyzwXSQ/xWtk7VBPn76gDYEgv+uDqkk+LMlRe0WkkqGIGDNWcRrgshLyhkWLgFsmoWLx8rVR5AVKD2ZhS+9pgokcvE9QwMO2CX7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(6486002)(36756003)(478600001)(186003)(31686004)(2616005)(6666004)(41300700001)(6506007)(6512007)(26005)(86362001)(38100700002)(2906002)(66946007)(8676002)(66556008)(66476007)(83380400001)(316002)(44832011)(8936002)(5660300002)(53546011)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXpZYkJJeGgweDN3cEpPOTZiL3lVdzU5cFBGK2VHaFJibUhpRjlnY2tsZVhK?=
 =?utf-8?B?T2ltUTVjR1RQY01tMnFWKzN4Rms0emJQZEpiOUhqVkl1dFd5UTFoSlhNclNv?=
 =?utf-8?B?SXZPb1RUSk1icjRFem9OMXBId3g4UjFCOGc1UUNXT0xZRzRCZlhMS05rOFU3?=
 =?utf-8?B?ZzBheDVpdG1HOC9mbXBrdU05NFNtSXBoNC9SYk9jMnBwTXFxNHhaOWYwTE1I?=
 =?utf-8?B?L3o2ZUEvYXViV3hOY3NDMHlWekxSdzBOQUg1UnNhS3VaU2JBM3NrNlF2S2U3?=
 =?utf-8?B?ZFZGMDBEc0dRNWlQNXYwZ3JGdWF3c24xVE0rck1LSTRIcTVUK2szYmUxR244?=
 =?utf-8?B?c3BWeHRGREF1bStlZkJ4ZmgyZ3hVNTVDdzdrZ0phcmkyaldYVmtiS1hLMXIz?=
 =?utf-8?B?U2Ewck5sSDJNTXZJM0RGWHpnWlA0SjR2b0dtbHBXQkxHUFlPVkdIYzdWaUNP?=
 =?utf-8?B?c2V3MGphdFVUeVNVNWpWUjRhRWVJbWFWbTVERUM0VVJxNmM1S3JWMitZWFov?=
 =?utf-8?B?NXJBY1RuWU5ZWTVKazVNb21KL2VLOUkzRkpndWdnQUtEZXNibGN4clZjVktX?=
 =?utf-8?B?cStUeXhxdWhyc2t5SUxNT2tnN2k1RXhOZW4vWTJkVGo0WVJlVTlxZ2RHczV5?=
 =?utf-8?B?b2VnNG5LbWsvOHNyN2tOR25UQ0x3dURmaWJsVlBFaDlkOFdBckpaQkI0Z0RY?=
 =?utf-8?B?STNLdEEyZ1pPd1RTU29FWGxBS25OR3ZvQzVoOGdtVmN5WERzTlR1VzNMMDJv?=
 =?utf-8?B?WGcvZE9jVUZEcG02Zm9mTUk3V2F1aHEyTytIT1FTU0ZWTGwvdDdmdEdiMTQv?=
 =?utf-8?B?a1cyamZhTmNza0xSTW5zdGp0bEtyQVdDWWN1bkptUVVFcnJubVhhSlByMG4z?=
 =?utf-8?B?Zklvc2lQTVlZNTJhVWNIMU11SG0wM0ZIRVJUajJFNFpFU3J2MXpvNGVaTHJl?=
 =?utf-8?B?YUZzbURmVVg0WGJzYms0Vk5MYTNIOTh2K0tZK2lJcUZ0OFIySTVrRnZkR2Q1?=
 =?utf-8?B?eG5TaVc5U0NUaXBZS29PZDRzSFIvNzJSUXJjR0tIcytTN3hEc2N2MGhWV0d4?=
 =?utf-8?B?YmFsdW1sMWdmbGppS0w4dHZRR3AwYkR2VUgySlZGUVhwb2pwL0tEOXhrUDdU?=
 =?utf-8?B?eCsxMTVhMlJKQk5pOHNwem5FZkRnRlVOSWhIMDBiZ0t3MjhwSHNIazl2bVBs?=
 =?utf-8?B?Q2JHS2VTL1BST2lSckw0YUlub1hJVlZIcVV5cit6LzF0VkZITGRwRDVwYUYy?=
 =?utf-8?B?VS9Mb0hLbWJBQWtqS2RjSC9VQXE0aFg2bEt4MVh3aldjQWQxeCsxVzFvSGta?=
 =?utf-8?B?OWFjUWZySHBvYzZqUTcvRE5MTVZQZVVwdXBQbGFoYmxmWkNxeHpOVmF5YzRj?=
 =?utf-8?B?WjIzR3c0dXd1ekZHWFg0Z0hTa3NXcWJmR3Y0bTVVR05qbUkxcWZBUzVEWkh1?=
 =?utf-8?B?SndNV2hIMUowaW9KejRnUmJoOHFSOGtTL24vWnFMVE5RU3RQTWFJa2YyeXpz?=
 =?utf-8?B?Mk5DV0VvNjRxZUFzd2h0ZTVNeEorTlJnd3N5Yk92Z2l0L2NCQjBSNnFORE5V?=
 =?utf-8?B?cW9JUVBLM0NtSk15SXNFZUpIeDNxNHdHbGtsUTFBT3cxbDhSWi9TdVhrei9M?=
 =?utf-8?B?SUtZa2JKS09yK1NVRXEzOVpyL2dWQmwxWURxY1NQOE1WbmtwMGxyNE5GanZQ?=
 =?utf-8?B?WXJjVi8rNnJReHNjVkNDdkZ4dGNZcmhCcG5KeXFEOXFqUXZqZG9aZkN4eVRR?=
 =?utf-8?B?QVpnM2RWY3BMbUJ6a0lrOHY3ZUQ3aFloMktTdVl5YmkvYll0em1pZEJmYWFI?=
 =?utf-8?B?eEtVczRZc2NUU1hPMHdFSUcyWGw1Wnd3V1pvY1dDa2VlYk5raFBaWG5WOTZV?=
 =?utf-8?B?WWFncTFNZGl3cWFlL0RqZ0xvN1BUMC9xOWw4SlpXVTRFNzRvc3FTRVZDWnZq?=
 =?utf-8?B?Z3BLejZqaGJxd1VNdFpBSVlXYkNRVjVzcGl5SHBYbkttYlNDU1ZMSVAvWXAz?=
 =?utf-8?B?QkhPWFFPUTNnaDE1N0hlaTE2QmlOZDl6d0c2Ykhlb2FFZnp2NFRhR3ZldkI3?=
 =?utf-8?B?R2o3SXMzK01OOUJyUkxET0Z6dXZjalNQejR6TTRrMUpRUm5EbFhlNkQ4STFk?=
 =?utf-8?Q?6zOFvvbnlcJ6p9lnEzRUFh99Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5456270-6bb7-4ebf-ebab-08da60efa779
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 14:39:25.1769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoB343ZsMMTo8GNNOtz+mKnYSyRcZI4zSF71M5fc+sDmedArGBoBTwEnYynykVm29FcqdanLh2iZ5j3Drn2spw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4808
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-07-08 01:26, Alex Deucher wrote:
> There are several things wrong here.  First, none of these
> numbers are FP, so there is no need to cast to double.  Next
> make sure to use proper 64 bit division helpers.
> 
> Fixes: 85f4bc0c333c ("drm/amd/display: Add SubVP required code")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/Makefile      | 26 --------
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 67 ++++++++++----------
>  2 files changed, 34 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
> index dfe82bcdd17d..64f40b10c163 100644
> --- a/drivers/gpu/drm/amd/display/dc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
> @@ -22,31 +22,6 @@
>  #
>  # Makefile for Display Core (dc) component.
>  
> -ifdef CONFIG_X86
> -dmub_ccflags := -mhard-float -msse
> -endif
> -
> -ifdef CONFIG_PPC64
> -dmub_ccflags := -mhard-float -maltivec
> -endif
> -
> -ifdef CONFIG_CC_IS_GCC
> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> -IS_OLD_GCC = 1
> -endif
> -endif
> -
> -ifdef CONFIG_X86
> -ifdef IS_OLD_GCC
> -# Stack alignment mismatch, proceed with caution.
> -# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> -# (8B stack alignment).
> -dmub_ccflags += -mpreferred-stack-boundary=4
> -else
> -dmub_ccflags += -msse2
> -endif
> -endif
> -
>  DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual
>  
>  ifdef CONFIG_DRM_AMD_DC_DCN
> @@ -99,7 +74,6 @@ AMD_DISPLAY_FILES += $(AMD_DISPLAY_CORE)
>  AMD_DISPLAY_FILES += $(AMD_DM_REG_UPDATE)
>  
>  DC_DMUB += dc_dmub_srv.o
> -CFLAGS_$(AMDDALPATH)/dc/dc_dmub_srv.o := $(dmub_ccflags)
>  DC_EDID += dc_edid_parser.o
>  AMD_DISPLAY_DMUB = $(addprefix $(AMDDALPATH)/dc/,$(DC_DMUB))
>  AMD_DISPLAY_EDID = $(addprefix $(AMDDALPATH)/dc/,$(DC_EDID))
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index 6b446ae9e91f..832f7a4deb03 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -416,27 +416,28 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
>  	pipe_data->pipe_config.vblank_data.drr_info.use_ramping = false; // for now don't use ramping
>  	pipe_data->pipe_config.vblank_data.drr_info.drr_window_size_ms = 4; // hardcode 4ms DRR window for now
>  
> -	drr_frame_us = drr_timing->v_total * drr_timing->h_total /
> -			(double)(drr_timing->pix_clk_100hz * 100) * 1000000;
> +	drr_frame_us = div64_s64(drr_timing->v_total * drr_timing->h_total,
> +				 (int64_t)(drr_timing->pix_clk_100hz * 100) * 1000000);
>  	// P-State allow width and FW delays already included phantom_timing->v_addressable
> -	mall_region_us = phantom_timing->v_addressable * phantom_timing->h_total /
> -			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000;
> +	mall_region_us = div64_s64(phantom_timing->v_addressable * phantom_timing->h_total,
> +				   (int64_t)(phantom_timing->pix_clk_100hz * 100) * 1000000);
>  	min_drr_supported_us = drr_frame_us + mall_region_us + SUBVP_DRR_MARGIN_US;
> -	min_vtotal_supported = drr_timing->pix_clk_100hz * 100 * ((double)min_drr_supported_us / 1000000) /
> -			(double)drr_timing->h_total;
> -
> -	prefetch_us = (phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
> -			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
> -			dc->caps.subvp_prefetch_end_to_mall_start_us;
> -	subvp_active_us = main_timing->v_addressable * main_timing->h_total /
> -			(double)(main_timing->pix_clk_100hz * 100) * 1000000;
> -	drr_active_us = drr_timing->v_addressable * drr_timing->h_total /
> -			(double)(drr_timing->pix_clk_100hz * 100) * 1000000;
> -	max_drr_vblank_us = (double)(subvp_active_us - prefetch_us - drr_active_us) / 2 + drr_active_us;
> +	min_vtotal_supported = div64_s64(drr_timing->pix_clk_100hz * 100 *
> +					 (div64_s64((int64_t)min_drr_supported_us, 1000000)),
> +					 (int64_t)drr_timing->h_total);
> +
> +	prefetch_us = div64_s64((phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total,
> +				(int64_t)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
> +				dc->caps.subvp_prefetch_end_to_mall_start_us);
> +	subvp_active_us = div64_s64(main_timing->v_addressable * main_timing->h_total,
> +				    (int64_t)(main_timing->pix_clk_100hz * 100) * 1000000);
> +	drr_active_us = div64_s64(drr_timing->v_addressable * drr_timing->h_total,
> +				  (int64_t)(drr_timing->pix_clk_100hz * 100) * 1000000);
> +	max_drr_vblank_us = div64_s64((int64_t)(subvp_active_us - prefetch_us - drr_active_us), 2) + drr_active_us;
>  	max_drr_mallregion_us = subvp_active_us - prefetch_us - mall_region_us;
>  	max_drr_supported_us = max_drr_vblank_us > max_drr_mallregion_us ? max_drr_vblank_us : max_drr_mallregion_us;
> -	max_vtotal_supported = drr_timing->pix_clk_100hz * 100 * ((double)max_drr_supported_us / 1000000) /
> -			(double)drr_timing->h_total;
> +	max_vtotal_supported = div64_s64(drr_timing->pix_clk_100hz * 100 * (div64_s64((int64_t)max_drr_supported_us, 1000000)),
> +					 (int64_t)drr_timing->h_total);
>  
>  	pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported = min_vtotal_supported;
>  	pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported = max_vtotal_supported;
> @@ -530,10 +531,10 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
>  	struct dc_crtc_timing *phantom_timing1 = &subvp_pipes[1]->stream->mall_stream_config.paired_stream->timing;
>  	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data = NULL;
>  
> -	subvp0_prefetch_us = (phantom_timing0->v_total - phantom_timing0->v_front_porch) * phantom_timing0->h_total /
> -				(double)(phantom_timing0->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us;
> -	subvp1_prefetch_us = (phantom_timing1->v_total - phantom_timing1->v_front_porch) * phantom_timing1->h_total /
> -					(double)(phantom_timing1->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us;
> +	subvp0_prefetch_us = div64_s64((phantom_timing0->v_total - phantom_timing0->v_front_porch) * phantom_timing0->h_total,
> +				       (int64_t)(phantom_timing0->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us);
> +	subvp1_prefetch_us = div64_s64((phantom_timing1->v_total - phantom_timing1->v_front_porch) * phantom_timing1->h_total,
> +				       (int64_t)(phantom_timing1->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us);
>  
>  	// Whichever SubVP PIPE has the smaller prefetch (including the prefetch end to mall start time)
>  	// should increase it's prefetch time to match the other
> @@ -541,16 +542,16 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
>  		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[1];
>  		prefetch_delta_us = subvp0_prefetch_us - subvp1_prefetch_us;
>  		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
> -					(((double)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) / 1000000) *
> -					(phantom_timing1->pix_clk_100hz * 100) + phantom_timing1->h_total - 1) /
> -					(double)phantom_timing1->h_total;
> +			div64_s64(((div64_s64((int64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us), 1000000)) *
> +				   (phantom_timing1->pix_clk_100hz * 100) + phantom_timing1->h_total - 1),
> +				  (int64_t)phantom_timing1->h_total);
>  	} else if (subvp1_prefetch_us >  subvp0_prefetch_us) {
>  		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[0];
>  		prefetch_delta_us = subvp1_prefetch_us - subvp0_prefetch_us;
>  		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
> -					(((double)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) / 1000000) *
> -					(phantom_timing0->pix_clk_100hz * 100) + phantom_timing0->h_total - 1) /
> -					(double)phantom_timing0->h_total;
> +			div64_s64(((div64_s64((int64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us), 1000000)) *
> +				   (phantom_timing0->pix_clk_100hz * 100) + phantom_timing0->h_total - 1),
> +				  (int64_t)phantom_timing0->h_total);
>  	}
>  }
>  
> @@ -601,13 +602,13 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
>  
>  	// Round up
>  	pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
> -			(((double)dc->caps.subvp_prefetch_end_to_mall_start_us / 1000000) *
> -			(phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
> -			(double)phantom_timing->h_total;
> +		div64_s64(((div64_s64((int64_t)dc->caps.subvp_prefetch_end_to_mall_start_us, 1000000)) *
> +			   (phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1),
> +			  (int64_t)phantom_timing->h_total);
>  	pipe_data->pipe_config.subvp_data.processing_delay_lines =
> -			(((double)dc->caps.subvp_fw_processing_delay_us / 1000000) *
> -			(phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
> -			(double)phantom_timing->h_total;
> +		div64_s64(((div64_s64((int64_t)dc->caps.subvp_fw_processing_delay_us, 1000000)) *
> +			   (phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1),
> +			  (int64_t)phantom_timing->h_total);
>  	// Find phantom pipe index based on phantom stream
>  	for (j = 0; j < dc->res_pool->pipe_count; j++) {
>  		struct pipe_ctx *phantom_pipe = &context->res_ctx.pipe_ctx[j];


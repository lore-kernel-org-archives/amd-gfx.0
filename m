Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD01C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 17:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91903610C7
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 17:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91903610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBB16E433;
	Tue,  5 Oct 2021 17:11:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 734066E433
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 17:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7ygTf/bg+jW6oLT8hEGlf1QfRBBa4GFfpNNPugGJ0vsb7a1cenxaDOvhZHgoUq05etxIb2QTOmGvJUxOy/X3Xy9b0wtzEMzGaRdM4haDAhJcojxdwUhZ6gEQNxAf8IfyEw8N2PzcnI2IYjN3ZJ+rvk46oA8ZRiq0T5MxS0N1d/RF1vdEtN2cuETLh9o0wFxyghRhtHZr0377STqPguQbwD+qTQB4gRxCqp3i7qOr9l5iKOjgL+CX8gkv5bwosLDJOwq7hAd9SAilQ0hPILPdHZ+urrwZ/YGpem1FZoxRt30B8Lsupmn6x1M42TyKs5THYUQiWNEF09FeLxiNNHN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAMnE4i9Am5WrmWV3VD7mXYG1joW66kG1FsbweUhPLo=;
 b=DNzVXl5zxy4+Pi2n8GBufBzyi1iKuNBb7Cg0QLdFMpiBVcU0slA/yhGF7UjS1cuYuQtHXonhcv1ak56aiRXQrXmiIHyByKzxuUBQYQ/+P2U61LeT8T6VEcGHpgr0l0fvLRWF6hnyeMThcKdWnwjKkxscRciFgvcPjNpBwOmU+LIEmaX4FMX4YrFfsrDUTWuaRAOO+KqogjokUg6jRReOW07EKPaaRsl3uFy4oD3KZE3HKCggOMxeY/+eQB00Ja8TgQJbOUtqNESvx6+g9sOI7zpsxlDHAd1xmlQwL9rmxIkBLUB8wIg3uHUnFLn6X+mJ9z9044rf2VwSlordXU1PdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAMnE4i9Am5WrmWV3VD7mXYG1joW66kG1FsbweUhPLo=;
 b=ZdGyKgu2EivkV9ixxypECD1I5gmLIpSagh+li5CRDbSMqtuchhAl1SXerhfBqun4AqheAhPJAxG2lj/Dlw0DVJZkjfpa1BzUWD3M2rAD6E6Hoyivop5fnyvfY7TWEjB7XcPab34s2suSpec/Nvwp/Mm3xVjCU7Q8XNjfZzothRU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 17:11:05 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 17:11:05 +0000
Message-ID: <33774abc-c31d-e3d6-43ec-b80bc7e946c5@amd.com>
Date: Tue, 5 Oct 2021 13:10:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 19/23] drm/amd/display: Add debug flags for USB4 DP
 link training
Content-Language: en-US
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com,
 Rodrigo.Siqueira@amd.com, stylon.wang@amd.com, jude.shih@amd.com,
 jimmy.kizito@amd.com, meenakshikumar.somasundaram@amd.com,
 Jun Lei <Jun.Lei@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-20-Wayne.Lin@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211005075205.3467938-20-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:408:4c::36) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.46.98] (165.204.84.11) by
 BN8PR16CA0023.namprd16.prod.outlook.com (2603:10b6:408:4c::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19 via Frontend Transport; Tue, 5 Oct 2021 17:11:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f10bed68-d97b-4675-f2af-08d988231dc3
X-MS-TrafficTypeDiagnostic: CO6PR12MB5460:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5460E01879084CC9DA676D5F8CAF9@CO6PR12MB5460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNi4Msmucc2vssQSuImyU1ZdHB1pqo3tx9l0ZVm3uv4tiRD0+oQgepJwQsr7FbKOCoTucUxJaDnthczhxTZj37LZyE9wfK97YUVZ9TIkgWDHQLM5YnYAozxrTSy2qxOrlR4+K9bS1IKlSV6m/g37mpJ9TAEDq8mZjTVuPsoYOX3uGIAOh8CtWv6/6TJaURS6YvPSKBGBtAYFC0K5HxFNSdX009/GFj/fKuF7TYbMVZnTW0WHW3DwW3BecTYOOZ94W5HnHLE2ZSleMqgLqEVyHn0vvWnfX/AzqfpV4XXrlv3jcuc7qvRVRNna1lqoT48YPg4BHKDwAUuO0Fi/NmFvZbHqP2XLQqjd4WzsLUANSppvZl6yiIJ02zB6preX7q4PvJ76fB7h7CaK2lr2z4gBVCH2v7qtezrtVSvuDhs74Kj+8WdWri4SM7XoxhRVZMD+8SeXc1YlExSzlxDWBI8YcIp15o/fjdoezxvi5NF38K4kWtNmyMDQhqy/db46/7ztMOMFxXmGeRw1wybLjALXB9x4ydQ+FjBUmKn4ykQ3A5KVSxcahu6erjquwZOImMFL3k5FmjJSTNMVYVEC9TerER/D/0OSnPgoLFh0I2iGGfcGXPXVZgyI3IPOOadtaSIyPnLSlcv/NxflsZIXSr9rqFKPFcFb7OdSY5jJGYmdjUzCQi6AH/Y+8Ho478Mjq8VGWMgIr9B5PJzgyLoUJdxoDIacnnedm79t3rkshudMGC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(31696002)(956004)(36756003)(508600001)(2616005)(38100700002)(31686004)(5660300002)(44832011)(83380400001)(6666004)(8676002)(53546011)(26005)(16576012)(86362001)(316002)(4326008)(8936002)(66946007)(66556008)(66476007)(186003)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lGQyt5aXFNODlLczFNY1FkY01sbWxwSHlhRVYraGJJZ1Iza1Q5M0VUZmpm?=
 =?utf-8?B?VEx0VVdmdFM3Vks5dE5BZndXRlRUbWh2VVhJVkhYWmxRMzlFMVZFV3d2Yzk5?=
 =?utf-8?B?aDRQby9LUnYxMDRra2FiMXN6L3hGT2NpTTFUeVpMb3RQMnA2TXl5TmRXYVVw?=
 =?utf-8?B?RW1aRUZ3Rk03K2llN0pQMGlpMTlxLzh6MmtLeGhGc0ZjN09pL3RQSE5yMkhh?=
 =?utf-8?B?SGEvNXEyem81VEx0ektocituWlBteVhIYTlOWkI2a3ZaS2lGWXJtb1dvbmRF?=
 =?utf-8?B?eTYwMHYvVk9lb0taRklMS2NSU1dIamtweEJLWWpYeHNTWXlLWlVIMDFHcENC?=
 =?utf-8?B?T2FNQ09DQlA2d1RrbENxbS9OUE44c0YwMHFTWE4rdzZmOENiOStscCtwZUFt?=
 =?utf-8?B?eHpBWG9ZWW1PUU9kN1J1YlJVVTNsazA5eFZ4WFpSVnc0N2txVWtxbzAxK0Yz?=
 =?utf-8?B?emlzd3ZwYUpBb1U3ZXJ2U0xTK1ROTER2Qk1QTWwvUzR2NmtmdFptUlkyRDBz?=
 =?utf-8?B?aDZtOXlxWDA5V2V1eXJ1bnYxK0ZCbDFOaE9CMkRNL2VCM21tLzlDM1UycUpY?=
 =?utf-8?B?aE9XUU5BUnlzK3BGMzg5b09QOXdkdDNZUy8zNHBwdUppajJHdncyZThuMVJz?=
 =?utf-8?B?NVBpMDVBd0lhMStaQks3Z0pmbTljbmRLSm8zL0RnWWpKcUZsTWVLUUJsUGR4?=
 =?utf-8?B?OUZhand6ZkdacitBaEgrQldkTE5jN2cyaTdCa2VaOE1xWFBoMTlML1dPeGZh?=
 =?utf-8?B?Z1dRR3lENzJyMzZxRGNEYkJGdnVER3dQZXQwcy9vb0VlTElhajVmdlZKTXpJ?=
 =?utf-8?B?WVpibDBZTngzUjc0WUhVWkowS2dRditpbHQ5UHFYNFIwT2ZlVVJaZzVGSEhp?=
 =?utf-8?B?dzFNdUl5S25FV0EyTDZ1alBkemM4NzhCSTlFRk1oVmdROUNBREtQeEVObFlN?=
 =?utf-8?B?RzlLWVlzaXYzcFF0R3NhcXQ5djVWL0JDemYxdmphaHIxN29LZllkNnlsR0FW?=
 =?utf-8?B?UnFzaDlJNDYyd1I0MW51RmpIMGk3ZnBPWUczelBVUTZ6czVIVHVQVkRPY3VL?=
 =?utf-8?B?NU1WTTZ3S2Y4a0ExZkZYWUhNdHFoQm04ZnpqVmFZTG15UWJpSUdTK2tPbDBr?=
 =?utf-8?B?cE1xTEhJOWpBa0xYSUpwdFhQYkFWTFA0eDc2ZGJoR1VxaWtLWnlsQk9GYUxm?=
 =?utf-8?B?R05oRGZCL2VDSVBBQlVXTUkyV0t5cDJpd2svSk4vcy8xVFh6RzhvSVJqOXZG?=
 =?utf-8?B?d2R3WWlHK04yK1prRm1aaUxBd250dTBjVTZtWEJNVjREYmZuM2Z0a0t6VENr?=
 =?utf-8?B?bnAwVXlXcEtwKzJybEFEbjFOSDBsVHh0MlBGeGZKQU9NaGFZekpieGFNV0ls?=
 =?utf-8?B?Y0gyOHZNbC9QVE10eG5OSmJJc1BFV1VoSkVMeklmYUltazQ3Rkc1NzJWeXlE?=
 =?utf-8?B?SnNsU2JUUlAxN3VYWmhUdE1qQ00vYjBsdzJPRXNacExQSUNkcnFBKzBjUG5H?=
 =?utf-8?B?N3ErdHVWNDM0TlVZcEV2V2tJS1ZwTU45SFVnVWNKWk44ajg3V09oTG1nR1Iw?=
 =?utf-8?B?U2s1cjZ3Ujc4RjhMSGNXclRPZlRldEloZWRlTWcxeUhoUVBEZFBWai9WNUto?=
 =?utf-8?B?bTl0V080S0lqZ1RERkFoQW9NZ3I2UFU1ZkN6ZTZ1OWlDOW9Ea3BmVzM5WWlQ?=
 =?utf-8?B?bHFpMkdObklOMC9WM1RQTXNORFhoZU1oQk8rakRHbmlYWXBpYk53anRqcm4w?=
 =?utf-8?Q?EE3gh0VkdInGykxnFRQR1oTXQ2JJGS14eOJYEIu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10bed68-d97b-4675-f2af-08d988231dc3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 17:11:05.6629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ReScOa0ev5ZslZRCS/1eHIxW9vl61XNiinhCrXXIunERDCgib5RQkSWVlDbavGEvN3yxGVE32hQbfx7buyXaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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



On 2021-10-05 03:52, Wayne Lin wrote:
> From: Jimmy Kizito <Jimmy.Kizito@amd.com>
> 
> [Why & How]
> Additional debug flags that can be useful for testing USB4 DP
> link training.
> 
> Add flags:
> - 0x2 : Forces USB4 DP link to non-LTTPR mode
> - 0x4 : Extends status read intervals to about 60s.
> 
> Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Wayne Lin <Wayne.Lin@amd.com>
> Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 6 ++++++
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c | 6 ++++++
>  drivers/gpu/drm/amd/display/dc/dc.h                | 4 +++-
>  drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h  | 3 +++
>  4 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index bfba1d2c6a18..423fbd2b9b39 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4528,6 +4528,12 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
>  		else
>  			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
>  	}
> +#if defined(CONFIG_DRM_AMD_DC_DCN)

Why is this guarded with DC_DCN when all other DPIA code isn't?
It looks like it might be unnecessary.

> +	/* Check DP tunnel LTTPR mode debug option. */
> +	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
> +	    link->dc->debug.dpia_debug.bits.force_non_lttpr)
> +		link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
> +#endif
>  
>  	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT || link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
>  		/* By reading LTTPR capability, RX assumes that we will enable
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> index 7407c755a73e..ce15a38c2aea 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> @@ -528,6 +528,12 @@ static uint32_t dpia_get_eq_aux_rd_interval(const struct dc_link *link,
>  				dp_translate_training_aux_read_interval(
>  					link->dpcd_caps.lttpr_caps.aux_rd_interval[hop - 1]);
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)

Same here. Please drop this guard if we don't need it.

Harry

> +	/* Check debug option for extending aux read interval. */
> +	if (link->dc->debug.dpia_debug.bits.extend_aux_rd_interval)
> +		wait_time_microsec = DPIA_DEBUG_EXTENDED_AUX_RD_INTERVAL_US;
> +#endif
> +
>  	return wait_time_microsec;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index e3f884942e04..86fa94a2ef48 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -499,7 +499,9 @@ union root_clock_optimization_options {
>  union dpia_debug_options {
>  	struct {
>  		uint32_t disable_dpia:1;
> -		uint32_t reserved:31;
> +		uint32_t force_non_lttpr:1;
> +		uint32_t extend_aux_rd_interval:1;
> +		uint32_t reserved:29;
>  	} bits;
>  	uint32_t raw;
>  };
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
> index 790b904e37e1..e3dfe4c89ce0 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
> @@ -34,6 +34,9 @@ struct dc_link_settings;
>  /* The approximate time (us) it takes to transmit 9 USB4 DP clock sync packets. */
>  #define DPIA_CLK_SYNC_DELAY 16000
>  
> +/* Extend interval between training status checks for manual testing. */
> +#define DPIA_DEBUG_EXTENDED_AUX_RD_INTERVAL_US 60000000
> +
>  /** @note Can remove once DP tunneling registers in upstream include/drm/drm_dp_helper.h */
>  /* DPCD DP Tunneling over USB4 */
>  #define DP_TUNNELING_CAPABILITIES_SUPPORT 0xe000d
> 


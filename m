Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE1C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B1B6101D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8B1B6101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 628EB6E999;
	Tue, 12 Oct 2021 14:18:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCFA16E999
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 14:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3gKtZEG4m+7h48Bv94mzRAIfKTXxFEGxOe4a/SYMou7iHyalOzWKUtUBb+DBoKcNo7v8m1BUcxryH7fBjD+Wq2usMODpPJutw25nkfmP/lquDfQ5ivBvCMVquHdnTJQP6L0xif7nOhy4ZEtIawsUHBtL3nuq7NN4ben+awWtqgVxz2x8Ih8dhGUGb3B3A6YLXJgAJXaE+rvwym935poNH3t06t4gpN5rdwyxOdFjnofKgyJzuABHKieBXdNajiy6rBV9iC5+fJj0fh3qB/iRBG3DpqEtK2SJFciaJWcuZPyrVIAxne40Z4uM8yc8E1WPu55y4u7oyvAxObjNfxMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUEimGbfIVKkvmIo3Ka/2b1jqWoWSiBqhvjYOwrcZ70=;
 b=kUg2ztnduOkAzkd5LfxyI33Crle0qFU3XWcAelvlQV8AU0RX8bawYRd9o6CgSyekyOqLv/+8zhnck2SkUnnmwbN9Ln1lwdZ8TbLgFsmhluw/j8J6IJzHOMXhGoJ/Gew7xikGaI2wznDRmbPYGOJyQmnK0D3VjBnbnal4Dn6Hlxy2XGE2qsMsJuCsfS5bFGCaehb2SIbuQV8KHMfxjmPfwhS7lM431F3UUGIZemAAujxIdsYi+0CfdutSyfYGYU1CUdiy0El4HLltT35efjlpUazipkeJg881mAxO6k3xEAFzs2GxH87nrrB9K0lEs9HA1YihTHSZWZO75bgDKEvKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUEimGbfIVKkvmIo3Ka/2b1jqWoWSiBqhvjYOwrcZ70=;
 b=bomWOLeP6pUO+J54mJ41iom+GaoZuBigX7VS4+eUZCnx0H6Fy25yoVrBZ7zbqPyV7B1qDxXIm64DEfS+S9lWSbWbY3+Jp0I/AXDUwH8X01uQMjDBobLLUtuC6OC2GIblYRHT1graobEkwgVV/j9TEnxFpmAxRDQLZUDwK/U1Jm8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 14:18:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 14:18:42 +0000
Message-ID: <52a5b39b-28bc-59ce-364b-02dbc009e0b8@amd.com>
Date: Tue, 12 Oct 2021 10:18:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] drm/amd/display: Enable PSR by default on DCN3.1
Content-Language: en-US
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Roman Li <roman.li@amd.com>
References: <20211008161415.4296-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211008161415.4296-1-nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR01CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Tue, 12 Oct 2021 14:18:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c64c6d2-2bb8-482b-7b30-08d98d8b3167
X-MS-TrafficTypeDiagnostic: CO6PR12MB5393:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB53935A42974AA219C92DC63F8CB69@CO6PR12MB5393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZG49DERMBLIdZb/qOX97pualM4vLg8X6xLQIgKdKmNwU8esiZ1QoP9a9V99SvKgn0j8dLCg1NCAaW5VqdsU30ew9WRSoHK7usqwNLtJR7+gVg3vQEoS8v4eIfQXx/TFYC1wLQlNop93+b5CJljg47r3w7vk3FmZMSnIWcaEOjlvTcSIOV14YmVBm09DRzbLjNU8NnalAfORlvnZ1EyPzKs2YOUlRA9ujeg2B0x/UvXMgnufiHB+Tsi3yeLBelT6Sp1tnhn9GdwWGAb7SMwl6+wxuCganOG2K6jgG0hKGIkYWqqM9h6nm/ACPs96rQwnceASUmTGkwZckA0EdYxeFYXI3QYVIOgiHRHhisMNInx2S/9g96eNXWnjkVED6f+7pyfqYETCdArEK2rScSXmd/IlIj1u5+ESU3zcdvDqbITcfiEkEvQW4nVolGWAPQMU/N4Kd/LOU4yjeaxW12kawULIiUoXgTt90oU/+1YHgSlsVTLtcWFAgVSx8t3AzuvyChEfde3GA6yTk6FIDnCH16BiKSxMZbv0O9zEfmM9/z+P9Nr3c70exMNyV6K7oARG9runN6v3nZzrFsWI3+hERj2gLeO6ujGxtS5oWuVB49aeiMIJbGoPy86ucSV6YRXI6iqOBbUnpjm3UPZ1HgXuTrfi14cqzwTvuhFY7e+TPmBeC8P45oQcbD3eUVV9zq+sub3TUuRbyWobiFajtrbdaqE8WPQJd/ZOOZAQDo/fMtA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(508600001)(86362001)(2906002)(6666004)(83380400001)(38100700002)(31686004)(4326008)(31696002)(44832011)(2616005)(26005)(66946007)(186003)(66476007)(316002)(16576012)(5660300002)(36756003)(6486002)(66556008)(956004)(53546011)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzdySU1JVUJXSWt6bWF3L3NXOGZjdlBuZGdNQ0xPaXBqbkw5eDBMUXg0aHFU?=
 =?utf-8?B?N3c3ek5EME80ZC9sWGFLSkJCTUhtS1pNcGM2eGd0VXhyamRjS25VQkxFYXFW?=
 =?utf-8?B?TXZPNHdYdnlyVGFZNEwxSmczcDJsNEsveU9ZbkNRRnQ5WE04bEsrY0xPTEZK?=
 =?utf-8?B?OUJLVE04aisvbDMwcVBZaUdpcDVmQU5PMlp0NUxlVGhGRTVqemJUeEVQNE44?=
 =?utf-8?B?djZxaFJTNXVDbHFzNk1aT1lrc1BqZjc5dEZwNzcwZVpNd2hkb2E1dHk5elpP?=
 =?utf-8?B?VW4wbHEyRVJONEpsdDRQcDdPbUFaQ0l2ZWhzT0tQYkpnY1hhYUhGWkFoQk9j?=
 =?utf-8?B?OFE2TzlEb0ZzMlRqWTV1VXdnK09pdXJmVFU3WEpuemcwMmxhcjJ1TURwYmE3?=
 =?utf-8?B?cUxGOWZwc1Y0N091cDlFcjZnL3EyeXVFRVAveDk5UTQxUUs4eDR4NEc0ZEhO?=
 =?utf-8?B?MFkyQTdBREw0Q0ZacGJtNEFldVN5YjdvWHRsTnMxdHFmMHFDVmoxejlLMmI2?=
 =?utf-8?B?bWxNRk8rTkhQSkR1NEsxa2FHbUxYUHNIZE9RWERPYUtxeGpCcDYvSnR2c3V4?=
 =?utf-8?B?RDFKR0hVd0xKYWFwMUJRMFdraTV1NFJWaUFLK1QxUElQU0RVcTBUajhyOVl0?=
 =?utf-8?B?Ylg2Q2tZQVVpbzRVNkpHNGpXVUZhQUFmVWdXNGUvOEhWaW40cFVRQ3cxVWxj?=
 =?utf-8?B?T3Jiam9GR3VPbCtRelY5bmx2OTRxOFJFTDJUV29BYkJnZGVqeVdTUTA5VEVk?=
 =?utf-8?B?WXd5OTdZb0VnaVV1Q09Wa3NteXh3UnBIMmZNZGkwcEF0dUh5QnhhRC9SK1o5?=
 =?utf-8?B?ZS9IUGxFMWJ5SG0zSlNidGxTa0Njdi9SVmVkalFTdXdXUkYvUXNMNk16ZGVz?=
 =?utf-8?B?SVl4bjhIT2lXOGhwSGt2TlVReGc1OEVTRVlYQktKTjYxTlNZZlNvWUo1NDk1?=
 =?utf-8?B?QjU0VTRPaEsrZlh3NzZwejRuUHJ5ZWdlckFOWkJGNGdjbFEwMzZoMkhEcU1q?=
 =?utf-8?B?M0VLdlpJZmdpVUFzeVRuZk1idEl2NU9sM1VXWkZhSXlJWExwSWJpNFQzQi96?=
 =?utf-8?B?SXlsTXgvRWwzZEl0dkN3eWlONVFHbnZKYVNhTTh0aUc2c2N2ZzBVR0haeW44?=
 =?utf-8?B?b0V4ZVNFTHFpQXhoYlh2b3phejV3eUlhNHR6ZXJvMTd0YStsQi83YkhzWjA3?=
 =?utf-8?B?bkhueTE2cml4M1AvV1Zhamg4dnZHTHFqNWJXVmRSam4xVmY0eXB3NlVYdnFi?=
 =?utf-8?B?bTNJV1lrTFdMKzRRcGF3QnhkZW90OTdSVDhxQUpkbk9aMDVoeWpIRGF3aWJh?=
 =?utf-8?B?UEc1VTd2eWovVjJFZkVSQmlKOTBSanB4TS9ESWdXWEIrRmlGcUt5czN5V2Vi?=
 =?utf-8?B?VXU4alVUZDJzeXpJY3ZJcmxJT0Uxckhla0E3TmdITEVTcEt5alU4SnQvckxH?=
 =?utf-8?B?QmJHYmZ4R0gxQ1ZmMTNxYTRnY0tPeFU1NXhzMUVrY1dRZ3Q5K1lSbXFIcUhZ?=
 =?utf-8?B?NnlhV1NLcDNWR3gyVFZSVC80NGRqS0FjODkxUms2R2YzSjB0Snkxc2Y4Wng3?=
 =?utf-8?B?SThRKzlsWk0xWDZ6OHJhMVhGTWl1K3lEZDBnM2FwUWZsMHY1ZzhYenJ6Yk9U?=
 =?utf-8?B?aUVSbzBtY2o3SmZIbHM2dWpKcVBFVmVERjBsekdjREpVYStpdjVyRmQrd2hh?=
 =?utf-8?B?cFF3VnR6WGc1S0tORHhNd1I5clVkV3grbTdsRXM1WXhOd24xWHN6bWJndkVW?=
 =?utf-8?Q?wTRRMjs8eX6xlQ8RrA0W/hUWiYW8kFh/dNvTFH9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c64c6d2-2bb8-482b-7b30-08d98d8b3167
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 14:18:42.0781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPy6xBF+Ybp701yYK9ICjhZK0JRJeuc0sRSnyKD2L8mszrDgKSRJuhRUosAlywaK3ljpCRgtKqfVxDsfowI47g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
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

On 2021-10-08 12:14, Nicholas Kazlauskas wrote:
> [Why]
> New idle optimizations for DCN3.1 require PSR for optimal power savings
> on panels that support it.
> 
> This was previously left disabled by default because of issues with
> compositors that do not pageflip and scan out directly to the
> frontbuffer.
> 
> For these compositors we now have detection methods that wait for x
> number of pageflips after a full update - triggered by a buffer or
> format change typically.
> 
> This may introduce bugs or new cases not tested by users so this is
> only currently targeting DCN31.
> 
> [How]
> Add code in DM to set PSR state by default for DCN3.1 while falling
> back to the feature mask for older DCN.
> 
> Add a global debug flag that can be set to disable it for either.
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 ++++++++++++++++-
>  drivers/gpu/drm/amd/include/amd_shared.h        |  5 +++--
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dc595ecec595..ff545503a6ed 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4031,6 +4031,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  	int32_t primary_planes;
>  	enum dc_connection_type new_connection_type = dc_connection_none;
>  	const struct dc_plane_cap *plane;
> +	bool psr_feature_enabled = false;
>  
>  	dm->display_indexes_num = dm->dc->caps.max_streams;
>  	/* Update the actual used number of crtc */
> @@ -4113,6 +4114,19 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  		DRM_DEBUG_KMS("Unsupported DCN IP version for outbox: 0x%X\n",
>  			      adev->ip_versions[DCE_HWIP][0]);
>  	}
> +
> +	/* Determine whether to enable PSR support by default. */
> +	if (!(amdgpu_dc_debug_mask & DC_DISABLE_PSR)) {
> +		switch (adev->ip_versions[DCE_HWIP][0]) {
> +		case IP_VERSION(3, 1, 2):
> +		case IP_VERSION(3, 1, 3):
> +			psr_feature_enabled = true;
> +			break;
> +		default:
> +			psr_feature_enabled = amdgpu_dc_feature_mask & DC_PSR_MASK;
> +			break;
> +		}
> +	}
>  #endif
>  
>  	/* loops over all connectors on the board */
> @@ -4156,7 +4170,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  		} else if (dc_link_detect(link, DETECT_REASON_BOOT)) {
>  			amdgpu_dm_update_connector_after_detect(aconnector);
>  			register_backlight_device(dm, link);
> -			if (amdgpu_dc_feature_mask & DC_PSR_MASK)
> +
> +			if (psr_feature_enabled)
>  				amdgpu_dm_set_psr_caps(link);
>  		}
>  
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 257f280d3d53..f1a46d16f7ea 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -228,7 +228,7 @@ enum DC_FEATURE_MASK {
>  	DC_FBC_MASK = (1 << 0), //0x1, disabled by default
>  	DC_MULTI_MON_PP_MCLK_SWITCH_MASK = (1 << 1), //0x2, enabled by default
>  	DC_DISABLE_FRACTIONAL_PWM_MASK = (1 << 2), //0x4, disabled by default
> -	DC_PSR_MASK = (1 << 3), //0x8, disabled by default
> +	DC_PSR_MASK = (1 << 3), //0x8, disabled by default for dcn < 3.1
>  	DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
>  };
>  
> @@ -236,7 +236,8 @@ enum DC_DEBUG_MASK {
>  	DC_DISABLE_PIPE_SPLIT = 0x1,
>  	DC_DISABLE_STUTTER = 0x2,
>  	DC_DISABLE_DSC = 0x4,
> -	DC_DISABLE_CLOCK_GATING = 0x8
> +	DC_DISABLE_CLOCK_GATING = 0x8,
> +	DC_DISABLE_PSR = 0x10,
>  };
>  
>  enum amd_dpm_forced_level;
> 


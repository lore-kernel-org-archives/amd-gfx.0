Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C092C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 14:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B079B6F472;
	Fri, 26 Nov 2021 14:21:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0F06F472
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 14:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4XddzjIuU8KAR2Xn2yKxCRn4+qroy9UvRUyabz1G3JPSOuDBb2c+/p+Uu6g/LjVpVsUwE9H+kyJBM7dRvFTFedFtIP7dawRHjPgrEsxrUiz1ISaWY27MGXjTOaBjKCEz+f9sZYjYFnB5e2I1xT8sCxeJ/nE/klteXp2M4vErZeGMrvXPNdYU1ztlcUEHRy/z6nmyWYx+Y6RaJhvNBJ8vzM4UZE3Z3SqWBgQC53cNi9PFxvHa6Kbb6hXBfsLxrWIA6/7L0+sY4UGDpMskx6lutFA2NCALumyywRWiVHh9cddhep9TjwBPsbFBF/5x1N81dRJko45rl2UwA8eHiF4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSWSOzrLPySS39j1HBlsIH9QrxtjIlv1Tv/1mViaD6Y=;
 b=eP0UsNTbKAXofQJXsq0OrbXjCEv99BRvT1gy1WlNcPM/A41ICPmTPT+yOyvxvX+tj4+thv5UsJTZonRJ2KJD//YlspdGudIvhgtEgNSjnDqGhs2J6FNc/6liyz1TEQYZ3cOm5OI1SPasFJXUf9Elv/vu9Mwg9Yj2e9Dk1UpK756NuibnLpQkuLu0I7AaDNE5/F5F926Nkzf2OHPLJtugmFKdi/y+ELjzzBfAwVgLGjXTQSQEW+sOQHI3E7McZh40BtBAta44gNLhT2OHskilr73gKN7mpBYjruFvh48HSSp8l4zdMTt/LoAnMik1xZ3xPPBj3lnQLNldhSiMil8UiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSWSOzrLPySS39j1HBlsIH9QrxtjIlv1Tv/1mViaD6Y=;
 b=kv1EZoWJgJaVa2dL+1Kx8OMpr1McNf6KVw1Q/iMEVLsHPvpDDuPb95CXRodyKNpRDOzrext0+Grx/AcC+LDDQRvUKaG9sI2U8zlIBkiJMt7zDxS9B5gz2xo0aTjmrXnBntZQuxbsrsaNVtlZdnx7Wl06ppOqWm2XQJLCuyRwBdg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW4PR12MB5584.namprd12.prod.outlook.com (2603:10b6:303:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 26 Nov
 2021 14:21:18 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%7]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 14:21:18 +0000
Message-ID: <a420e33e-88ca-098b-c40d-e9c0702aa53d@amd.com>
Date: Fri, 26 Nov 2021 09:21:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1] drm/amd/display: Add DP-HDMI PCON Support in DC
Content-Language: en-US
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com
References: <20211125212241.131221-1-Jerry.Zuo@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211125212241.131221-1-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::43) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Fri, 26 Nov 2021 14:21:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99ad3a38-f356-47b1-3ae5-08d9b0e802c2
X-MS-TrafficTypeDiagnostic: MW4PR12MB5584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR12MB5584010844012FD93CCFE5C98C639@MW4PR12MB5584.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25mBRm5HXA2lwUEwqia0htdAs/jlqf1/mjX2G6x/2hqDQWR+cUk27cU03yI60obTiXsLJREmXjwYOUtuy+8WwKtgVHc3NkQP0qr4SAGddR1lvAgk9ByeS/yvf2u+Fryjw1WSHA51xAsahOzNjrEoHcOw8nIMdBa7Yp2ANESzih9zG5Vez1W1xPQPRIf2rKKz5MtU74uUEdEuVOVmnaQV5dwHAbgF/VJWJolwITAXNhSDPa0THdBNm5JXazzPVYbuku36M8XvJHzhWYCW+RY/QXMLEBbB9Yy99IQS/PzuYApOnkQzGq23Y9eAA6YIc1MShfaSmqUfiF+X4vuMyur69CPdhNtUaLDXCOd6f+1Bax7ISVx1mTSbRF4fCFdokCXCvYJv9FJgy21VlnvBXanT8BIxl0NVo+VormqMdReGoKRy7Isj69xoCRO9W52Tr74CFUypJmRvOXBN7vAz8DSK5M3CcFf6RtqUgpobddQdgGGOagX+R1GiQB1IhylxHuwCx/sZdWM0gCCFbPUpiccxnQb149SbVq5sgdDJ1QHQTcrsUdZ3eSB6WKWH0iE8z1vTBGiEwbQQQd9TGTQLveTG1vi04pUM3gVfdpgQtO82sYUdLNfqJkDGHCoXDEztxPryvsyfQ/bB+v6ZMN2jv4aAx4vyF7ZeEgUCvVJPtFnpcWRwJAU1W3a6QMjCbeia2ZbxIMTnZuZUgQ5kyIyO4XiOgY1pv7kOBwePLHcCV/MrQDxgQwXy5jCf6MM7kzW2SCgd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(44832011)(5660300002)(53546011)(2906002)(30864003)(8676002)(6486002)(38100700002)(31696002)(26005)(2616005)(6636002)(86362001)(36756003)(4001150100001)(186003)(8936002)(31686004)(66946007)(66476007)(16576012)(316002)(66556008)(83380400001)(4326008)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXpYZG9EUVo1czZqTFZYNjRGaFZITVo3Q2p6YTFkMlV2VUJ6WkNsODV1MEhY?=
 =?utf-8?B?UnkrSHE3TlNIazhJSnpkTjFDUGtZMjFENm5BZlRLbmdyaVlheGxHMGNReTZ3?=
 =?utf-8?B?U0lqY0I2RDNFZjdkVGZHekdrQjNuYjlSODVQY2p0WFpKdVJML0xQdmFtTzBG?=
 =?utf-8?B?QlBwbW85a1UxMjAxTHVWRzYxSllGZDRyc1hHUHkvVWxPQnFGT2J6TTl0OTZp?=
 =?utf-8?B?NHR4dFNEUFVZQVplazBZeVJiWHdXeTdEQ2VyeSswcHh6NENrOHlFbHBhVm5M?=
 =?utf-8?B?TmJuc0F4NnZYb0RPWjBqZ2VOUFVvSVVSWFUzT2FEU2VzRkF6TUNEaUROUDg1?=
 =?utf-8?B?c3ozNTF0YmlqeU9NOXBPcHoyVFFQeEpLUis4azlDNlB1YWJKWDhCSVdoN1R6?=
 =?utf-8?B?bHQ0ZTBVYkRDQ3dwNHowaU5DdHZBQlNteVVac1BuQ29OdHZOcUxOcnBNbTVX?=
 =?utf-8?B?LzZoM0c2SWwySElDbW5saXRqT2VNRnlXVXRHbjdTajVVY2ZLcm8vSEZWUmcy?=
 =?utf-8?B?Ykc5VVBsak42SHVlaTdZcG1xSmVxdm9KQThKMklybXNzS2tTQmpPajMyYnV2?=
 =?utf-8?B?dXQycEgwSVlHR1cvQ09kMHl1TjcxMi9teXJuYmIvQVlyRGVoWWRSam5RVGNl?=
 =?utf-8?B?eStRV0NyR0U1SGl5T2FuT2hNMVowVzFEZFlKK1lvbVY0dFliakRqb0Yzanlw?=
 =?utf-8?B?ajd2NEFSQkZyNG9RUzd0R3AyT05SYUsvSFl5RjdsVVp2S2tqVjF4ZG05RERu?=
 =?utf-8?B?elVNWGI5c3pZd1BhQnR3Rys0aW4yMmxkelNnTVZIZ2ltVWVSWVptVXJVNHZy?=
 =?utf-8?B?bjFEMmp1MFZmL1NUVzFJcmk0UGxTVlNVbmVTVGI5V1FrU0VmVXRBM09NNE9E?=
 =?utf-8?B?b3ZZVDlPNHJBTkFKMHZkQ1BsUklHQXJCczJrbmNuNGNTYzJReWdhdXBOSjBF?=
 =?utf-8?B?MmF1RkRtNkovNUNvbDM4TnVQZjN1dDlaWlVzYU1pb3lxTklkb1dRZGMvL3J4?=
 =?utf-8?B?Nk9td0FtRlpQblNodmIwMjBvcFhlM0RjeDU0M3h0OWhxd2hzVkhnUTdLbUw0?=
 =?utf-8?B?NndlYnU5K0tUTmdVOE9GYy94c213NmYyaGFrMkljeitvTW9DRlhjV1Q1L1Qv?=
 =?utf-8?B?d0creU9mRU5zbWJhbkRCSXovMHpURG0wQkxQKzcvREpHV1l1WHVNVVN0UmZE?=
 =?utf-8?B?YXVGWXMwVUhWb0QyUENHQzJuNzF5MjZtUzBtM1M4WG40WXFwYzRmQlN6SDNs?=
 =?utf-8?B?c3RRcnF5TExXWlVORVZ6UHkvOXNpdkJGNGk5c1hRTUtXd3hNTWpENElqMmNw?=
 =?utf-8?B?azYxSFZkS0c0WXNXYU9peUs5RzVFV0JGb0pBZU9MRWFOeE1RYVhJWGEwZ0N6?=
 =?utf-8?B?VktQYWlPWXJhYzN6elRpNWJYODcwUjF3ZUx0ZEx5S1BqTXlZMTFrZ3k5U3o4?=
 =?utf-8?B?Tk1VakFLR0Q4eFpwam1TVFV6WkRqd1BBZmRUVlRnWmx5SlMvWDkwT2YrNi93?=
 =?utf-8?B?R2hvUU9wZHl2MDBoblYzUk1qWVVRN3lMSnZrS1IzRlFUSXZLQ3RnWWJSbDFN?=
 =?utf-8?B?ekVTTlZKcDJZRVBSaUV6bVNLbW5ndU41QVdidWY2OTFIV0VBYlEwaUJBMDhv?=
 =?utf-8?B?eFFOcjBUa0k5Sk0wamdBbEdiNy9PMVBqckJwbU05S2lITG55VWxROVd6QnpR?=
 =?utf-8?B?VVNsYko5WEFFNEZWRDluaWJRTzAzaU9JeldPOVhCcDVCeXJ2ZENncldYWE4r?=
 =?utf-8?Q?WNiFnWm5iZj7Ujd0JYcef57pLcFagoJdCEJyFJ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ad3a38-f356-47b1-3ae5-08d9b0e802c2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 14:21:17.9201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MS0JQ9rKzzAnU4wmbsdN2r8o0kcwZeFIwIJXSXCKmsL90JNo1A+JPKIvf/Xxofc9DKKQJF8tqm53kpNrjv8zhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5584
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
Cc: wayne.lin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

How does this differ or interact with the 
"Add DP-HDMI PCON SST Support" patch?

A short description of what this patch does would
be helpful.

Harry

On 2021-11-25 16:22, Fangzhi Zuo wrote:
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 15 ++++
>  .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 71 +++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/dc.h           |  6 ++
>  drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 31 ++++++++
>  drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  3 +
>  drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
>  .../drm/amd/display/dc/dcn20/dcn20_resource.c |  2 +
>  .../drm/amd/display/dc/dcn21/dcn21_resource.c |  2 +
>  .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +
>  .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 +
>  11 files changed, 135 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 3d08f8eba402..dad7a4fdc427 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -2750,8 +2750,23 @@ static bool dp_active_dongle_validate_timing(
>  		return false;
>  	}
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	if (dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps > 0) { // DP to HDMI FRL converter
> +		struct dc_crtc_timing outputTiming = *timing;
> +
> +		if (timing->flags.DSC && !timing->dsc_cfg.is_frl)
> +			/* DP input has DSC, HDMI FRL output doesn't have DSC, remove DSC from output timing */
> +			outputTiming.flags.DSC = 0;
> +		if (dc_bandwidth_in_kbps_from_timing(&outputTiming) > dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps)
> +			return false;
> +	} else { // DP to HDMI TMDS converter
> +		if (get_timing_pixel_clock_100hz(timing) > (dongle_caps->dp_hdmi_max_pixel_clk_in_khz * 10))
> +			return false;
> +	}
> +#else
>  	if (get_timing_pixel_clock_100hz(timing) > (dongle_caps->dp_hdmi_max_pixel_clk_in_khz * 10))
>  		return false;
> +#endif
>  
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  	}
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 84f3545c3032..da1532356c07 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4313,6 +4313,56 @@ static int translate_dpcd_max_bpc(enum dpcd_downstream_port_max_bpc bpc)
>  	return -1;
>  }
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw)
> +{
> +	switch (bw) {
> +	case 0b001:
> +		return 9000000;
> +	case 0b010:
> +		return 18000000;
> +	case 0b011:
> +		return 24000000;
> +	case 0b100:
> +		return 32000000;
> +	case 0b101:
> +		return 40000000;
> +	case 0b110:
> +		return 48000000;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * Return PCON's post FRL link training supported BW if its non-zero, otherwise return max_supported_frl_bw.
> + */
> +static uint32_t intersect_frl_link_bw_support(
> +	const uint32_t max_supported_frl_bw_in_kbps,
> +	const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
> +{
> +	uint32_t supported_bw_in_kbps = max_supported_frl_bw_in_kbps;
> +
> +	// HDMI_ENCODED_LINK_BW bits are only valid if HDMI Link Configuration bit is 1 (FRL mode)
> +	if (hdmi_encoded_link_bw.bits.FRL_MODE) {
> +		if (hdmi_encoded_link_bw.bits.BW_48Gbps)
> +			supported_bw_in_kbps = 48000000;
> +		else if (hdmi_encoded_link_bw.bits.BW_40Gbps)
> +			supported_bw_in_kbps = 40000000;
> +		else if (hdmi_encoded_link_bw.bits.BW_32Gbps)
> +			supported_bw_in_kbps = 32000000;
> +		else if (hdmi_encoded_link_bw.bits.BW_24Gbps)
> +			supported_bw_in_kbps = 24000000;
> +		else if (hdmi_encoded_link_bw.bits.BW_18Gbps)
> +			supported_bw_in_kbps = 18000000;
> +		else if (hdmi_encoded_link_bw.bits.BW_9Gbps)
> +			supported_bw_in_kbps = 9000000;
> +	}
> +
> +	return supported_bw_in_kbps;
> +}
> +#endif
> +
>  static void read_dp_device_vendor_id(struct dc_link *link)
>  {
>  	struct dp_device_vendor_id dp_id;
> @@ -4424,6 +4474,27 @@ static void get_active_converter_info(
>  						translate_dpcd_max_bpc(
>  							hdmi_color_caps.bits.MAX_BITS_PER_COLOR_COMPONENT);
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +					if (link->dc->caps.hdmi_frl_pcon_support) {
> +						link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps =
> +								dc_link_bw_kbps_from_raw_frl_link_rate_data(
> +										hdmi_color_caps.bits.MAX_ENCODED_LINK_BW_SUPPORT);
> +
> +						union hdmi_encoded_link_bw hdmi_encoded_link_bw;
> +
> +						// Intersect reported max link bw support with the supported link rate post FRL link training
> +						if (core_link_read_dpcd(link, DP_PCON_HDMI_POST_FRL_STATUS,
> +								&hdmi_encoded_link_bw.raw, sizeof(hdmi_encoded_link_bw)) == DC_OK) {
> +							link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps = intersect_frl_link_bw_support(
> +									link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps,
> +									hdmi_encoded_link_bw);
> +						}
> +
> +						if (link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps > 0)
> +							link->dpcd_caps.dongle_caps.extendedCapValid = true;
> +					}
> +#endif
> +
>  					if (link->dpcd_caps.dongle_caps.dp_hdmi_max_pixel_clk_in_khz != 0)
>  						link->dpcd_caps.dongle_caps.extendedCapValid = true;
>  				}
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index c14e7db3f69d..2d001de42117 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -187,6 +187,7 @@ struct dc_caps {
>  	struct dc_color_caps color;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  	bool dp_hpo;
> +	bool hdmi_frl_pcon_support;
>  #endif
>  	bool edp_dsc_support;
>  	bool vbios_lttpr_aware;
> @@ -1294,6 +1295,11 @@ struct dc_sink_dsc_caps {
>  	// 'true' if these are virtual DPCD's DSC caps (immediately upstream of sink in MST topology),
>  	// 'false' if they are sink's DSC caps
>  	bool is_virtual_dpcd_dsc;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	// 'true' if MST topology supports DSC passthrough for sink
> +	// 'false' if MST topology does not support DSC passthrough
> +	bool is_dsc_passthrough_supported;
> +#endif
>  	struct dsc_dec_dpcd_caps dsc_dec_caps;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> index e68e9a86a4d9..99d26fb31566 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> @@ -378,7 +378,14 @@ enum dpcd_downstream_port_detailed_type {
>  union dwnstream_port_caps_byte2 {
>  	struct {
>  		uint8_t MAX_BITS_PER_COLOR_COMPONENT:2;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +		uint8_t MAX_ENCODED_LINK_BW_SUPPORT:3;
> +		uint8_t SOURCE_CONTROL_MODE_SUPPORT:1;
> +		uint8_t CONCURRENT_LINK_BRING_UP_SEQ_SUPPORT:1;
> +		uint8_t RESERVED:1;
> +#else
>  		uint8_t RESERVED:6;
> +#endif
>  	} bits;
>  	uint8_t raw;
>  };
> @@ -416,6 +423,30 @@ union dwnstream_port_caps_byte3_hdmi {
>  	uint8_t raw;
>  };
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +union hdmi_sink_encoded_link_bw_support {
> +	struct {
> +		uint8_t HDMI_SINK_ENCODED_LINK_BW_SUPPORT:3;
> +		uint8_t RESERVED:5;
> +	} bits;
> +	uint8_t raw;
> +};
> +
> +union hdmi_encoded_link_bw {
> +	struct {
> +		uint8_t FRL_MODE:1; // Bit 0
> +		uint8_t BW_9Gbps:1;
> +		uint8_t BW_18Gbps:1;
> +		uint8_t BW_24Gbps:1;
> +		uint8_t BW_32Gbps:1;
> +		uint8_t BW_40Gbps:1;
> +		uint8_t BW_48Gbps:1;
> +		uint8_t RESERVED:1; // Bit 7
> +	} bits;
> +	uint8_t raw;
> +};
> +#endif
> +
>  /*4-byte structure for detailed capabilities of a down-stream port
>  (DP-to-TMDS converter).*/
>  union dwnstream_portxcaps {
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> index 52355fe6994c..eac34f591a3f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> @@ -741,6 +741,9 @@ struct dc_dsc_config {
>  	uint32_t version_minor; /* DSC minor version. Full version is formed as 1.version_minor. */
>  	bool ycbcr422_simple; /* Tell DSC engine to convert YCbCr 4:2:2 to 'YCbCr 4:2:2 simple'. */
>  	int32_t rc_buffer_size; /* DSC RC buffer block size in bytes */
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	bool is_frl; /* indicate if DSC is applied based on HDMI FRL sink's capability */
> +#endif
>  	bool is_dp; /* indicate if DSC is applied based on DP's capability */
>  };
>  struct dc_crtc_timing {
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
> index d449e72a4e2a..d5887d976ef6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_link.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
> @@ -443,6 +443,7 @@ bool dc_link_is_fec_supported(const struct dc_link *link);
>  bool dc_link_should_enable_fec(const struct dc_link *link);
>  
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> +uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw);
>  enum dp_link_encoding dc_link_dp_mst_decide_link_encoding_format(const struct dc_link *link);
>  #endif
>  #endif /* DC_LINK_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
> index 388457ffc0a8..cb26ff8a54c5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
> @@ -430,6 +430,7 @@ struct dc_dongle_caps {
>  	uint32_t dp_hdmi_max_bpc;
>  	uint32_t dp_hdmi_max_pixel_clk_in_khz;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> +	uint32_t dp_hdmi_frl_max_link_bw_in_kbps;
>  	struct dc_dongle_dfp_cap_ext dfp_cap_ext;
>  #endif
>  };
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 3883f918b3bb..40b122a708ef 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -3796,6 +3796,8 @@ static bool dcn20_resource_construct(
>  	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
>  	dc->caps.color.mpc.ocsc = 1;
>  
> +	dc->caps.hdmi_frl_pcon_support = true;
> +
>  	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV) {
>  		dc->debug = debug_defaults_drv;
>  	} else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index d452a0d1777e..da6031cef244 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -2028,6 +2028,8 @@ static bool dcn21_resource_construct(
>  	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
>  	dc->caps.color.mpc.ocsc = 1;
>  
> +	dc->caps.hdmi_frl_pcon_support = true;
> +
>  	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
>  		dc->debug = debug_defaults_drv;
>  	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index 79a66e0c4303..77331a45a749 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -2639,6 +2639,8 @@ static bool dcn30_resource_construct(
>  	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
>  	dc->caps.color.mpc.ocsc = 1;
>  
> +	dc->caps.hdmi_frl_pcon_support = true;
> +
>  	/* read VBIOS LTTPR caps */
>  	{
>  		if (ctx->dc_bios->funcs->get_lttpr_caps) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index 6460fab496f6..673e080e1982 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -2193,6 +2193,7 @@ static bool dcn31_resource_construct(
>  	dc->caps.post_blend_color_processing = true;
>  	dc->caps.force_dp_tps4_for_cp2520 = true;
>  	dc->caps.dp_hpo = true;
> +	dc->caps.hdmi_frl_pcon_support = true;
>  	dc->caps.edp_dsc_support = true;
>  	dc->caps.extended_aux_timeout_support = true;
>  	dc->caps.dmcub_support = true;
> 


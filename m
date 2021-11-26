Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24FAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 16:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E366ECC3;
	Fri, 26 Nov 2021 16:03:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FBE6E128
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 16:03:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAoi64phjcja1sxsHsHMqTFzSJYAJBNqheqfCtea0ZFo8h0s1e3PyjO/aFhzfqJOEcadFk9dKJ1EEk7fL2Ua/ZUVMFU652P0FdWrbHe8fvcrd/f3+dBBLADJvxQVA/g2WCgphdQKo6U659N81Eh86+jnqVR5XaZXZNtcyOyQb/ERlgvyCSCwI7J3LhzNJbodd2n3em5IGfv8zL/SFMRzw2UpKo0ppePHbj/8Wvxa4HGh8kwrV45uynIIe8WcYuCLuv3+w6whuLqa1+Joh0ufI3yXKTzwQxs221GkKDN0Lw4SQc1ghUXXyGTESJ2IdjhGK2sKvRz60YLftADW5OteyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7am8jS25mUpQ2NY8KjWpiqFzz+WuO50QfW/6TrzV0A=;
 b=Byk0RO0xe/X/QIYr+OawxpXC/AotcNg7xOagoe1n4FXhh0EWgsgSELicsk1g2q4OHYgl/UWoEwXPs0rxQCQ2+J2pr75Hee8ShtlZEK0/NM4qrmnqR/PNb7Gsah7VkFSIQn4B31xRTlDv03KlT1/4vI7zy32OySdYXK6s10D1+UzFiBAxNW2tBeMbOXY0HWQRm1r6fMjSQ+76pgmM5c4vQ73Z9EzGZ9BC7jpu5h5+nxbqxD5HTMyACdDmbDAIfYUN0O5auGATH8quA5OC9XquVKg2sgvwTlo12/1weVhW4F9h372h5L3Sa8YWjNMNKeJfhd5cBf86tgD/kSscreaJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7am8jS25mUpQ2NY8KjWpiqFzz+WuO50QfW/6TrzV0A=;
 b=hnAxWZWEY8xUMv6sxhsMQbkEC6t6bJ2XGRTPW5Hw56P/+D62QVEXcYRCnvZ/pI3+PtGLdT5KXUeW21mpGUlQ+d38xy9EF7mQ8i2Gu78SwWcdKWKtblmfMj3dQLwCVBJP9+WzkssNXRCn4qDdghl4gKAbss3vcG+3BjOMVHy2Rvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 26 Nov
 2021 16:03:45 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3%5]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 16:03:44 +0000
Message-ID: <f718ed44-ed2b-0296-6089-9f02bf2abc4b@amd.com>
Date: Fri, 26 Nov 2021 11:03:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amd/display: Add DP-HDMI FRL PCON Support in DC
Content-Language: en-US
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com
References: <20211126143224.134823-1-Jerry.Zuo@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <20211126143224.134823-1-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0010.prod.exchangelabs.com (2603:10b6:208:10c::23)
 To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 MN2PR01CA0010.prod.exchangelabs.com (2603:10b6:208:10c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Fri, 26 Nov 2021 16:03:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b15977a5-220f-4631-fcb6-08d9b0f6529a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5295:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5295A064127B8CC8C22E0A18EC639@DM4PR12MB5295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ToQXGy/s9tyt7LxFY6re0aevAIeERdtC7zMF7PBL03zyvAqOqtBFowwhr2VtHbpxQHC5bJQSxEjO6MMgWMRygRgayBAHMUfeC7R+AzS6qxuepU5LLWiwEY+FAHL3u4l6QGovgPokccvV4y/AP6tAJvHB39wahyawpUmFLsqAEVYPBG+OW4MuDxldw97indXjSsV9ll28o4Ai8pDSL9D1wsa/py90/3ZryG/cWs5DuZuwbVdQkdCc6j2rfL3XxUcwwxZR3v0FtVE+7UfxVAVlE45/+MgMscpugUHiIMZD1mudDJp9fvvmq5Z++ErOEM2orRp16yXH7onTitdRnH+yXS+u6oGR0Yr7QAclzvgGHzXK6IpDSSFCXwjBIJpp/orkWxvneb18gHYjwWipSw2wOFHKRSkoQbyD01f2Vh5HjxBE+OrS6JVfiD4WL3z7BBqQvfOi7g0lHV5b4NNvWdCLJbtnyqvX9OZPnRYdAZgbJ3baHNuzegBJB8y+za0oTOEdmziR9PFzwX6GhRWlcmeRtxNq3V413GJwCWQv2V8GAKFWlGvCQld0aLGXT6ShZ1JcapfHxapJeLa0owEyrhByws/JVhCjWv2WCQlBhol9Ur4I9fSXasHJcprY+pmYnHn/8HMMZtoYUIb31sg8SEGyyjiXcnWeK0w2QSTeTRnArH2qZ1ZZUL4w+3ZacYz8P5Vna8a1DogrEsCOYzTvTF5SfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(508600001)(86362001)(2906002)(8936002)(6666004)(38100700002)(53546011)(83380400001)(5660300002)(31686004)(6636002)(2616005)(8676002)(316002)(956004)(4326008)(26005)(4001150100001)(31696002)(66476007)(66556008)(66946007)(6486002)(16576012)(30864003)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDJYdmVCYTNxM0phSEY2V1NLRU1OQVdZVkhiditzaVFUNmFtQ3dpVHB2STNq?=
 =?utf-8?B?WGdPY0puQ2tLWjVNMFdzMGxuUDRUd0tlQ3J0L3I4eG5RQ2ZiVEZ1VUNOQmpu?=
 =?utf-8?B?UVk4WkFuMWNDWStNRHhqOWR5UXBLOEhTcDQ4RVNrWVR3OHlBVXNFd3Y3a3k4?=
 =?utf-8?B?anlxWXdleHZzVzBKN2E3ajBnNjNsZWpwcVhqSmgwOFBpRjh6ak9UOVJuYllO?=
 =?utf-8?B?eE5LVXVmQUVJeEFySXVnZTBXMWVQeWtlQy96a3RMMDFBdFduUXRjMm9FMVlM?=
 =?utf-8?B?Y2ZFbTZNanJYZ3pQUlBIT2hJMCtQSWUrcWkrTU10dW00YzYzZkpRUkYwa243?=
 =?utf-8?B?c0l3SE5hdld0TW5Vc3RiekRzb21LcXBiQ0pJU01LMG8wWVUrSDUwZVc2NFNk?=
 =?utf-8?B?M1VsaFU2UTJkRi81bUllTjZJNzhHNkc3MENiMVVMamFzVFZUUUxJMmZqbTkr?=
 =?utf-8?B?QnY0YkxZMG9SQlJ4NzFEZE9xREZLbFBxRXJyT2N3YUo1MkIrdGZiRGttS0w5?=
 =?utf-8?B?MzlZbWJTMFI5dFBPZG9DVnJlcDEweGVCd3BrNks4OC9scTdiRXZ4Ui9Ba1VO?=
 =?utf-8?B?UHl0U3Bub3h2aHk1MGcyeHdhRkZVaEVjWDJ1cFVYc1JmRWRPSjM1TVcyN3pi?=
 =?utf-8?B?RG8xWXZjbU9HVEtjeVVOZHlmZmlHbzl3aUx5ZTRnMGRUS2xhYTZGSURweGxM?=
 =?utf-8?B?WnVtMVJQdkxxSVhQK1dYa0xqa1hCNm8wUUt5dHRkSmV4K29IS1lzT3lGODc3?=
 =?utf-8?B?SlJ4NXVQWWtEdmJtVjM5MCtqaTBJUzRNbUlZbWtjNk5wMTk3Y0tZTUhOZVJy?=
 =?utf-8?B?a1pIc042U2cya3o4WDArVUZXdzlYVFpjNmdlT1B2akZTaVdkY3BMd296VnVs?=
 =?utf-8?B?T2pVaU1VSVpOTHlxMkRoY3BoWW55ZUhaV0dRdGdMMU9sNktVN1F6TlpFYlZD?=
 =?utf-8?B?NVNFQUNSSkFudXhBdmMzRkEvY1RmMkZTUzFGelVIZXVpYWVCckdsOXliNU9Y?=
 =?utf-8?B?QkVic2xsdDBrdlZDWm84OG1LNFpzSGt5b0h2N0FkVkU0eVlzM25iZzBxZW5x?=
 =?utf-8?B?RElIWXhBRUFKblFNMTN3dUMrRit6SDF4Tk9XamtsTExqNTBvV21aclJPNTVm?=
 =?utf-8?B?a3k3MVZnanA0SlFHL3ZtUytZQythd0dvNVV0eXI3NjgxL2tvNFRnOFpuSCtq?=
 =?utf-8?B?enM1Q0RGaVFYZUhLbEM3Sjd0eGxpSERvTytiYVJOWk9uODQ0Q1BBMEZ6V3pB?=
 =?utf-8?B?Wld4dlRwNkFhMkIxYU5rYTRpVXNqcHk3bURPOW9RbGFRNTF6RUxBQnhSZ1J4?=
 =?utf-8?B?MDZEUWNlQXBGNFVTaTVvSURSV2x5QUliSUR4S0YrZ055K3Rab0daaEgvcmVs?=
 =?utf-8?B?TlBrSm9wQ21zVVNaYjFxWStGaTFKU0JqRTNVbDVZUTlraEhxcnlnK2pubENm?=
 =?utf-8?B?YVVqTW55L2xVa3d5UUpsQU5KcmZVOUpPQzhtZkVSZnB1SFhoT0g5Q1hEUTly?=
 =?utf-8?B?YzN0b1I0MnRBaEljSjZoaEdZdHl3aU1QQllhU2VzZmVRL2M4ZWRhblVuUlZv?=
 =?utf-8?B?V1c1Z2Y0bnlyais0UVZJL3gzamc4V3dEcmU5MXpkbS8reVg0YUxvd2VGd0Nu?=
 =?utf-8?B?SzNMeXhWMlBYajdFem1zTGRnSWVxMnpOT1BwY1R6RFUraGJINHdpMEpzdzNp?=
 =?utf-8?B?NjQ5dHpMMjdHeUdwQjk3bFBiTGdPMkdxMmk1TEs0R3VpeDlURGZxMm9XZnhY?=
 =?utf-8?B?ajZhUUdhYXlZU0lYaFVsRWpBZVo1aW1tdkRiaGhlTHIwNHR0emtNR25qRjQr?=
 =?utf-8?B?WndwZDhMVFJCbW91R0JZL0xrUXVGWW1UeEd5Z1dEZ1BuYVdtN2I3OFdQSURG?=
 =?utf-8?B?NlV3VHNJd2ZTY1UvQXg5bXhMS095VE81eWRuUFA4dmprckt1QUNQdDVDOFN3?=
 =?utf-8?B?YWtSRjVKYTFTdzRMbk0xckJBRFdxV2ZoVUJXYlVjYjFzLzJJQUR2TFFrcEJj?=
 =?utf-8?B?MDN2cEh0ZHlHSmVXWUk2SUpSNU5UV1Q3Z0VaU1VTUUFQVTBkaDBPU0dzcncw?=
 =?utf-8?B?QWdvTHZnTDlHVlIxTXJMTnp6cDdCU0VGVEw3d1BwelJLdWgxRktlOGVUcWJN?=
 =?utf-8?B?Rzc4NldibSt6R3NpR1BIdzJVclV4V09qSk9UdXZSK3prQkhtdm5yU1c2KzlD?=
 =?utf-8?Q?dDYWsQId71vLWa6f4PulVYs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15977a5-220f-4631-fcb6-08d9b0f6529a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 16:03:44.5481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsZ351j1FtvA93HB74L1v4FYYv9npzfKLrYhBUG+R3BEdQwAZWsnyGEnPjJPXDSspzPR4Ul53yTcoS6vnWd+Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
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

On 2021-11-26 9:32 a.m., Fangzhi Zuo wrote:
> Change since v1: add brief description
> 1. Add hdmi frl pcon support to existing asic family.
> 2. Determine pcon frl capability based on pcon dpcd.
> 3. pcon frl is taken into consideration into mode validation.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

I think we probably should be using the DP DPCD defines directly instead 
our own unions, though. Maybe as a cleanup later.

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 15 ++++
>   .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 71 +++++++++++++++++++
>   drivers/gpu/drm/amd/display/dc/dc.h           |  6 ++
>   drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 31 ++++++++
>   drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  3 +
>   drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
>   drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
>   .../drm/amd/display/dc/dcn20/dcn20_resource.c |  2 +
>   .../drm/amd/display/dc/dcn21/dcn21_resource.c |  2 +
>   .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +
>   .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 +
>   11 files changed, 135 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 3d08f8eba402..dad7a4fdc427 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -2750,8 +2750,23 @@ static bool dp_active_dongle_validate_timing(
>   		return false;
>   	}
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
>   	if (get_timing_pixel_clock_100hz(timing) > (dongle_caps->dp_hdmi_max_pixel_clk_in_khz * 10))
>   		return false;
> +#endif
>   
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>   	}
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 84f3545c3032..da1532356c07 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4313,6 +4313,56 @@ static int translate_dpcd_max_bpc(enum dpcd_downstream_port_max_bpc bpc)
>   	return -1;
>   }
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
>   static void read_dp_device_vendor_id(struct dc_link *link)
>   {
>   	struct dp_device_vendor_id dp_id;
> @@ -4424,6 +4474,27 @@ static void get_active_converter_info(
>   						translate_dpcd_max_bpc(
>   							hdmi_color_caps.bits.MAX_BITS_PER_COLOR_COMPONENT);
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
>   					if (link->dpcd_caps.dongle_caps.dp_hdmi_max_pixel_clk_in_khz != 0)
>   						link->dpcd_caps.dongle_caps.extendedCapValid = true;
>   				}
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index c14e7db3f69d..2d001de42117 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -187,6 +187,7 @@ struct dc_caps {
>   	struct dc_color_caps color;
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>   	bool dp_hpo;
> +	bool hdmi_frl_pcon_support;
>   #endif
>   	bool edp_dsc_support;
>   	bool vbios_lttpr_aware;
> @@ -1294,6 +1295,11 @@ struct dc_sink_dsc_caps {
>   	// 'true' if these are virtual DPCD's DSC caps (immediately upstream of sink in MST topology),
>   	// 'false' if they are sink's DSC caps
>   	bool is_virtual_dpcd_dsc;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	// 'true' if MST topology supports DSC passthrough for sink
> +	// 'false' if MST topology does not support DSC passthrough
> +	bool is_dsc_passthrough_supported;
> +#endif
>   	struct dsc_dec_dpcd_caps dsc_dec_caps;
>   };
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> index e68e9a86a4d9..99d26fb31566 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> @@ -378,7 +378,14 @@ enum dpcd_downstream_port_detailed_type {
>   union dwnstream_port_caps_byte2 {
>   	struct {
>   		uint8_t MAX_BITS_PER_COLOR_COMPONENT:2;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +		uint8_t MAX_ENCODED_LINK_BW_SUPPORT:3;
> +		uint8_t SOURCE_CONTROL_MODE_SUPPORT:1;
> +		uint8_t CONCURRENT_LINK_BRING_UP_SEQ_SUPPORT:1;
> +		uint8_t RESERVED:1;
> +#else
>   		uint8_t RESERVED:6;
> +#endif
>   	} bits;
>   	uint8_t raw;
>   };
> @@ -416,6 +423,30 @@ union dwnstream_port_caps_byte3_hdmi {
>   	uint8_t raw;
>   };
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
>   /*4-byte structure for detailed capabilities of a down-stream port
>   (DP-to-TMDS converter).*/
>   union dwnstream_portxcaps {
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> index 52355fe6994c..eac34f591a3f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> @@ -741,6 +741,9 @@ struct dc_dsc_config {
>   	uint32_t version_minor; /* DSC minor version. Full version is formed as 1.version_minor. */
>   	bool ycbcr422_simple; /* Tell DSC engine to convert YCbCr 4:2:2 to 'YCbCr 4:2:2 simple'. */
>   	int32_t rc_buffer_size; /* DSC RC buffer block size in bytes */
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	bool is_frl; /* indicate if DSC is applied based on HDMI FRL sink's capability */
> +#endif
>   	bool is_dp; /* indicate if DSC is applied based on DP's capability */
>   };
>   struct dc_crtc_timing {
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
> index d449e72a4e2a..d5887d976ef6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_link.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
> @@ -443,6 +443,7 @@ bool dc_link_is_fec_supported(const struct dc_link *link);
>   bool dc_link_should_enable_fec(const struct dc_link *link);
>   
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
> +uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw);
>   enum dp_link_encoding dc_link_dp_mst_decide_link_encoding_format(const struct dc_link *link);
>   #endif
>   #endif /* DC_LINK_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
> index 388457ffc0a8..cb26ff8a54c5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
> @@ -430,6 +430,7 @@ struct dc_dongle_caps {
>   	uint32_t dp_hdmi_max_bpc;
>   	uint32_t dp_hdmi_max_pixel_clk_in_khz;
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
> +	uint32_t dp_hdmi_frl_max_link_bw_in_kbps;
>   	struct dc_dongle_dfp_cap_ext dfp_cap_ext;
>   #endif
>   };
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 3883f918b3bb..40b122a708ef 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -3796,6 +3796,8 @@ static bool dcn20_resource_construct(
>   	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
>   	dc->caps.color.mpc.ocsc = 1;
>   
> +	dc->caps.hdmi_frl_pcon_support = true;
> +
>   	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV) {
>   		dc->debug = debug_defaults_drv;
>   	} else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index d452a0d1777e..da6031cef244 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -2028,6 +2028,8 @@ static bool dcn21_resource_construct(
>   	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
>   	dc->caps.color.mpc.ocsc = 1;
>   
> +	dc->caps.hdmi_frl_pcon_support = true;
> +
>   	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
>   		dc->debug = debug_defaults_drv;
>   	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index 79a66e0c4303..77331a45a749 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -2639,6 +2639,8 @@ static bool dcn30_resource_construct(
>   	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
>   	dc->caps.color.mpc.ocsc = 1;
>   
> +	dc->caps.hdmi_frl_pcon_support = true;
> +
>   	/* read VBIOS LTTPR caps */
>   	{
>   		if (ctx->dc_bios->funcs->get_lttpr_caps) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index 6460fab496f6..673e080e1982 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -2193,6 +2193,7 @@ static bool dcn31_resource_construct(
>   	dc->caps.post_blend_color_processing = true;
>   	dc->caps.force_dp_tps4_for_cp2520 = true;
>   	dc->caps.dp_hpo = true;
> +	dc->caps.hdmi_frl_pcon_support = true;
>   	dc->caps.edp_dsc_support = true;
>   	dc->caps.extended_aux_timeout_support = true;
>   	dc->caps.dmcub_support = true;
> 


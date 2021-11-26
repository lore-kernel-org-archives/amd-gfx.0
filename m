Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A1CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 15:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A1B96F630;
	Fri, 26 Nov 2021 15:15:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100546F630
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 15:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyR8iJ/V/kqWCV69bFpeBr3XbuPWCgVLXyKjBFfRiFvkta0oCvcSsl/NXuHUzAU8PWUx+7JbsQSoX3vFjHclDrzm81TewELbZdZpSHHBKznb7q9jd+RtzCBodS+4xVXt+wxhIkbJIF1ZTl+tezFFpyh2ijkdwYyJOK4nPTO6mMZVPJNUk+R+sCEoOlh0XRL3VnWUzI3OAj8dNOTF6j+9KXITc8QvjMkG7f1LEpW2RswAUKdHRIPHB2VCXilg0XhFwWkwAIIo5RLyKdSkjaqEVSjgkWzhrU4GOviD5SC+fISXtEvB9bvWbvIjopKlG6Duf0tbKK0Uchzp0A9hzpvZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn2gWuItkV88sy7zbnvJLwWKCMK7C90s2g70geo33Cg=;
 b=F9UGFv6Xp2/BVovK0rZYjYQPzfRCCrFLWWWWUHkh+Z7hT8qwAeqWx8VpkfJoJUSaJ2VTjhFyIEdUJu3zbOuZ6GalWXWXACuuBZoyGGcCPHl0Mtkdsfq/hNVOhWCfuNpYPQ9tN5q3A3+EhNa8SeJpJQTWyBsmaQN6ehLVPCMxgu5GYPKt95iZe00XLG0TtwazZNxleAStl/vfF2zY4u44bzp209noTyceRUxYWHv8lxVpti9MJRGZTwEYiu0ffz3A+tmuSuTu/j4re95urbg/PLTWfVhXmxiMSEC1bG75nzJCbg4Kij/fxVa76oWltMpVtkUWRz2R4F4yunaEmt1nSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn2gWuItkV88sy7zbnvJLwWKCMK7C90s2g70geo33Cg=;
 b=O0UdiL2pJQEy+YfN0wvNge0P8nUIaMluEslQBxjIYy9FOEH3w88NNDOoVOfXGtGhTaLCsabMWvdRU4lphcrKeEl55/aXLKrpdn/jYwQvIhEe/A7s5+h9JUqOglUjVie1PjiaxeayAid7/zABikrV3x8sB1mojIub/iZymDxKBPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 26 Nov
 2021 15:15:17 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%7]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 15:15:17 +0000
Message-ID: <69559b73-3b56-a4ca-2bcf-e81b94c420ad@amd.com>
Date: Fri, 26 Nov 2021 10:15:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amd/display: Add DP-HDMI FRL PCON Support in DC
Content-Language: en-US
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com
References: <20211126143224.134823-1-Jerry.Zuo@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211126143224.134823-1-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::40) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR01CA0104.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21 via Frontend Transport; Fri, 26 Nov 2021 15:15:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1d62283-5362-48c0-c2fc-08d9b0ef8d7c
X-MS-TrafficTypeDiagnostic: CO6PR12MB5426:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5426FBAC8837E83E911818218C639@CO6PR12MB5426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: heRy0fx16sYFCQc/uRh2Bc4pqrFxZWuaYD8T0e/H80cu0/26BQN9cbXskTIMyZP/p75kHHwFa+AAniMidWozbCkmjtNYwqW73HWDJXGXjXsYocdXanno5Tk0ET28IoZMYO3pK4Uk8Od6qHwESBTXeFv3Tur/WsyIJnpmTipm6mHpyFbWyoGiH+y6eNhF+jbXZ4ZZpdG144flXIP1Aqahs15GYd965hnDxF122geN/9uXG3S+PDEJ2tLsocOdTOKKhCvqstHOSIrF+R1gLfWO1rA1BLrVA95M8gILmWQbDmiJ/pW7IDPbyPiMKuTy2dOuv4uQqU/0ZJnuUPMPjsA1dROGgybylkbHbYrW79hhjHn838Cvw7UzkdmU1kJ/u4zsVBMI/1Zj2Aogqw3o3T9ojY0j+L/F8kgtbRr+ogbghm3CiAyN7vYthtZO1n+4ZBK+/xYTOkBeBMevMrD7yTzSRmjaC+MwgqE2P4igkPBR7gMR0yLo9/VZE/1gokpTxwU2iFkoX8mx0MXE0Dhvc0t+lOnUd5YHH/kmC3HGJhOPwoPds7eIz5JG42R9UzNDh/n3z8zZHbCaz9dLT1XFjK/+lekp2HB4aIMKQJK5r01/HdVGTXVT1eOUBKENPzWKX/vwqU73yAFExm+rQ9uMo3/73+arAZumYda+fbiPqXPtDIMOE2SR1JZ2OPpsqpY97aeQknvOYdeF96pD7ZhzlUfgjdE033v3wUuHdFXgdvgzZQUXcJ5MeLwGarYPb8xUzTCN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(508600001)(86362001)(44832011)(2906002)(8936002)(6666004)(38100700002)(83380400001)(31686004)(5660300002)(53546011)(6636002)(2616005)(8676002)(316002)(956004)(4326008)(4001150100001)(66476007)(66946007)(66556008)(6486002)(16576012)(31696002)(30864003)(26005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFAyV2oyRkZicXN3Vlg2WVJOMllncFJNS2RvVFJpWHFVQk9VaGdzV0NidCsv?=
 =?utf-8?B?QWsxUUdJZDF5TmN0Z1ZRQUdzbUZrV0dKZTM5eHF2NzU1SXFSR0grMmxPR1BG?=
 =?utf-8?B?eFRrYi9rRHdmbzBUSHBrSTdwdXBLUGdMM2pDOXRUUUtNaHY5M0tjWUczam5o?=
 =?utf-8?B?S08ySUl3RXk2S0lmMkNYZXR4bFZOeEo4UzZCdG0xVU4waHlrc3Z5cmZKdG5o?=
 =?utf-8?B?bW80R0JIYlZRMUdsV3F0TXc3WCtCRTBHZkR6ZUQxTGY2Y3dtOXJrWnY4c2R1?=
 =?utf-8?B?c0RPaFBBdFBLNDAxT3IvY1hDdnB0dGc1eWRmaE9MRzVwdytHM0xUcC9OQmZ2?=
 =?utf-8?B?ZXdYWTZJaTFwVDJQNmdCbzJxN21TQnZJNkV4czkxK3RNekxGQzFYaC9GV1lW?=
 =?utf-8?B?bmd2cSsrQWZCKzkwallWVE1ad1dRN2Vad2prdnhRL05WMm1UQUhleGpRMXpB?=
 =?utf-8?B?OGZuQzVpMitwTXBOYXo3YUVvK3VkbDlaZmV0QVRlWk4wY09nRjBxQlAzaUZO?=
 =?utf-8?B?YmVMSWhhcjB6Tk04VUozZFJtZkVSQ2RNMDQ1c1J2dWNPdDFlWERibjBYb1Uz?=
 =?utf-8?B?c0Z6cGxIRXloNjhHVnRKSXRXU1J1Ty9KQnlSeGE0UjFqVjdrZTUxajdnM2hq?=
 =?utf-8?B?TVJ2elo0RzMrOU8zKzhxSE5nY2V0NlR4M2ZNK0ZXTUFGWkpZbUcreUtYZ2RU?=
 =?utf-8?B?aUdJVnJXTzhGd3R5ZGN6MkRQaGVwNEM4NjBNMk4wMWpCdnFIby9Cd250alZ0?=
 =?utf-8?B?RkwzM3ZVUVp2YmJoTWE0d2taSlBWOWt3eFp0UmdlL0ptWTJxbVppL3lEYWlM?=
 =?utf-8?B?dTVhSjd2K3hWTEVWTmcrQWZ1VzRWUkZITkNrZmNiWUhnb1lhNjZpNXVmdmdj?=
 =?utf-8?B?S0ovRk0rWFRSUTY3RmNOMlVpdmMzSHVvc1liZUxReEZnVG9GRFF1V09oUjZU?=
 =?utf-8?B?Nk1nRXBJYVg2N281amE0cmZkdjBTWFR4VFJRM2pkdEtMa2JxRDlBU2YwVlEx?=
 =?utf-8?B?TUhaZjJ5ZFJzcU1mYkVDK1J0RUM1UjQxRVNvNkJQdmJLSE5nOXRrT2lQc0dT?=
 =?utf-8?B?ZE9KUTNJdXliZnBDVkNpZENPRm5DdUhjUEpJMCtCQ0krRWhTZXBFSXpQcWhS?=
 =?utf-8?B?WWNxQXFlZlp5cjE5WkZDelRjZVdYR1VUdG53MHkwUU5FZW81NVFWNWFnVEJM?=
 =?utf-8?B?T1U0SUZwQWFWRCs2cXJHZWJ2UkdqR0FkOXV3bitFTk9kdnJsREFJb1lJNGNK?=
 =?utf-8?B?VDVra2ZTL1J3WVlLeVlGNmtoTnh0TzJPWFlDZjRGNVhpOXJQVDk1cmQ5RnlN?=
 =?utf-8?B?bGV6Sk5QVE9HS09QamxKTGN6Y3VGdW14WWJyMWpTQXNscThNTEV2dmE0akdr?=
 =?utf-8?B?VDgzcUxDUm9yR21OMjZNNkFzNTlQMVFuYVQ2d21SUm53ajlLdUNWRzRVcWxD?=
 =?utf-8?B?V21mSmlFZ3E3VFh4cEF6SlBOL25IUkJOLzliaEtZU3h4TGVOdGVBYzFjM1Bp?=
 =?utf-8?B?QURRTGQvSUNUdDUyQVZ4bzBpS3gxcWkwMmtXamgycDk2cGgxeTU1ZXQyK3FM?=
 =?utf-8?B?TE5xTXZiOWVZNzRsYU9pWjhoTHFxTlpWNWwwR090R1dCYWZsVWp1UHJ6RnRR?=
 =?utf-8?B?MWgya1JSbTN6VHhCbGE4VzNpc29ER3VPMFE1UExNSG1VaW1zbEJ5OStTUnBS?=
 =?utf-8?B?OXNJbzNTaHA5VEpveGlsREdEM09HZmFYYWRjZEFVOTBrYnc4Wkk4SmNua2Zw?=
 =?utf-8?B?N1Q4VHdQbG5ZWkZxSzFFNk5ybTFXdlc5bGE0L3BZT3hFbGNFSnZrWEV5cVZ4?=
 =?utf-8?B?K0FNNE5vbGVrdENBZTZLQktSY1lsaHpvaXZNelc3Z00weWp5dXJNQlB4SDdP?=
 =?utf-8?B?KzBtQzlTbFFubXMwK2xxZGd6dHM4ZndPek1LQzJPUWN0VVNxM3JqMUFIeklW?=
 =?utf-8?B?YzlTTHVrcUFhNG12RDdpS1NYQnpnbHNpb2RDUmN6eXVnbS9TV1dBb0Q5U1hK?=
 =?utf-8?B?TWprY2ZhVmxUTUdBdTV6R1BrNlZRanZUaWdiS3Rob3Q2bU9uNGt6U0kreTBn?=
 =?utf-8?B?OFdoSlJIUU1FM0l6ZVJKTG9JTVRFa3ZIMHFSWmEyNVdJSDBKR1BrVFdoUXUw?=
 =?utf-8?B?cTFadTFLemt5TnArK2doc1ZDYWhKSUphaCtyYmhFZzJ3VG9TUkEyR0Z4UU1I?=
 =?utf-8?Q?2fg+Tqt/9hMK6eFmu4C3Kh8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d62283-5362-48c0-c2fc-08d9b0ef8d7c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 15:15:16.9819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUnhqTROFtjl+fLd24+2xTF3IvNg5g3Oj9Cpo2qkb8uGw4PbxgYQxY59XjGyhuwMgRJq41QvQoyZhx8hFqLYKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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

On 2021-11-26 09:32, Fangzhi Zuo wrote:
> Change since v1: add brief description
> 1. Add hdmi frl pcon support to existing asic family.
> 2. Determine pcon frl capability based on pcon dpcd.
> 3. pcon frl is taken into consideration into mode validation.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

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


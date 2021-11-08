Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E1AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AFB61207
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79AFB61207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102ED6E04B;
	Mon,  8 Nov 2021 14:46:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E4F89CF4
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 14:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I45nARFOAbMZ1t7KiMVgyHaoMxlK7PYibSlU5QMNSZc2g0tPRNnolhU3XPiGxCo9NNpLWckliAlmHpJGQ6/oM96LLY9+eVyI1LifIMw/PQse9XR5MsFBOpNjao9EOU6wo/xQQ6o57NPmI7MAR4EeuGg+UcuPmfzuwmcLinRoKhjzXgqAfuaBnsE10kMSBtHgz2z+xtSSJkMbKPYRpjYwyO3KzckDxrzyBtHtEwlO5I2qOdOH7T2BVvM6przjghjL/pwrFyZN6mUsT6EGy1ukRGOWqWWVocBaIqBknYFqmOrX0o4YjDiFrdxvYqIsy912sOOSfnj/k+VQEPPb8K077A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0v14AZ6GjAMTYOii1SeuSyikT1tGj3b/9T6Dj3hLxnw=;
 b=keC07vNzs1jYDAR608I5bi5S2RmFcXkKcLidy/CpVZuCBG0HhmHvVAXkHVfc6sl/8uYFKqS82cmBPN2TwddqDFm2cX92qezuk+P6pyqi+DShHX2bfMWL47SPoKVbdHlOa832yRs7+BhPf/mYENmqE0eeI5UqP5CK76rZSJHsH5T/rg60mzx3zVPitq3Fuw1zBlHu0zUQOhistuSiW7qWtT/UCYXVs7445J1xRwuWwCw/RHfCiES7tVOvQQSmAp4K1c2m/rMwT4M0KvC2ukonfucNDWoh+bgUE74HCshLWc1g3W9QLKH5XPvOKIN5grATtbFVqDiTPHMPfZrgkg2gpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0v14AZ6GjAMTYOii1SeuSyikT1tGj3b/9T6Dj3hLxnw=;
 b=fGKlAo5jChYEJFN/tgt29FulMrHThZZXzP252iF46VH6mQS9M3WC49TQvBcAQdC/4rxMTcB3o3WwJynehPjFi5UOO5xPy4+d9ISIDiB1KtahPd+TB3GmVIZDx1cjaQdynHCAVIUeJSeudtYPgy+Wr2Kk/nBWSsHnGK3+qq6cU2A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Mon, 8 Nov
 2021 14:46:15 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975%3]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 14:46:15 +0000
Message-ID: <a5c236ad-c2d9-a165-9cab-d281aa8f7a02@amd.com>
Date: Mon, 8 Nov 2021 09:46:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: reject both non-zero src_x and src_y
 only for DCN1x
Content-Language: en-US
To: Shirish S <shirish.s@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20211108081514.9925-1-shirish.s@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211108081514.9925-1-shirish.s@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::23) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Mon, 8 Nov 2021 14:46:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31799fc0-4bfb-4a68-6d2c-08d9a2c68399
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5490047A827C4877947428C38C919@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mt7G7xTF+EZyEGH0llHPnGed8VmOuCEL+vjpiFG+UeiJO8wpgEGAc0cMwoFzzCLXEJafP3lhWBv5ty3On92QSbboOsHzfj77Oba944T6G+82XBJ607XHWYc5S3+nNR6NcG0KcKa94YQXEj2HGasFWAFKtfWu4+DzVxmVIpKfFRmWCIMltWNAfLAZS+SPzpJ5MhpzGTUwJnu49wh0bKiupWq2zDQ4+CYcs93v7OMARZVTvIdO8gx8JsnSGefLNipxtgs36+qF4o32svTYTy/8WqO4FiMXOYndpnzM2xlIAvSlIKt1vDpFdyU3tq/bprLwJgW0s+YwwlQSi7FJ1diJaYbxD52OYH7dpRjqoD4oLtjncgk85Hd24ZmahgxFtMqzZlwahiRHdUF4M7y9G5G+XtRO6gRhRhOHjBlQh8fVUpFfSWCtKw1KEmSon68wmx1Lzj+G1r921foD20w/mT/Ux9k63n/kkoRSwDffCp3aueTAerMUY78JbxS2QDmiSUwaaWZY46Xnp2uqeXxgXUTWCvgjt6xGFPwyhL2xjCdFJv4+37b0fzUGaxsMzOj1QNOk8MrlhCIvoQLQbyn90Y4MJrZX2N+8wn/Vm9p5cfdO7dtuLjJf5dun++H5A/UHhiTc0hCuDI3EtV1zVn5xiiD0WaSnGR9qT+qoHF8OCZdOEDwo9ShXoCCt3sWH5hEG0QHwDIdZzN2D50FFkm0OzRtyHj8gtG2doUeF3QlA3OLUF3TATTSbWVM7rPdg1aWd2a7M3udy1/Te4N4XUNkvb7anvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(5660300002)(8936002)(53546011)(26005)(956004)(4326008)(2616005)(36756003)(8676002)(508600001)(38100700002)(6636002)(6486002)(66946007)(31686004)(83380400001)(316002)(66556008)(2906002)(16576012)(86362001)(66476007)(110136005)(31696002)(44832011)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkdXdUtOc0ZrK3hNWkZQRGFlRFRXMTBjU3pnckJaS1FTQ1VNK3M1Tlp5Q1ZU?=
 =?utf-8?B?TEFBM29uc3pKTmFOcDZGV2lieFRGWi9LTWZOSHdEdnZqOFZrVzNBZ2FyU01P?=
 =?utf-8?B?SUpTVWg4SFJlZXhGbjZhTnR2MWwwbDU5OUlBc1BOWW5iaFl2dmNwRHBIOUxu?=
 =?utf-8?B?Q3QyOW9JMkk4RHZFRFk4OTVOUzhBTFNUNDdOUUo5czVrM09zZWZZOXFPOWh4?=
 =?utf-8?B?NDRvY3pEWmNqRGVxOG9xa0hEOFFDWCtXRExON0dSVEZsaTNrOGI5NXZja21y?=
 =?utf-8?B?MDE5RUw0T2F0eDN1Y0lmS0NHdEVvZXJRUnQrTkhzeWphUndHa1pjODRpcXpK?=
 =?utf-8?B?aWFPdE96THVoeGNCZldqdmVESVRVVzRiMDhlQnpKZWcvS3RvbW9TU3NzSFRM?=
 =?utf-8?B?RWE5MzNoakdnaFV1VGZXV0xyOTJHbGtVbTkrNTBqeS9YdjFJQTd4a2hmN1Zu?=
 =?utf-8?B?dEVjRnRKZGpkbmxjZ3FJNkFkaTVMRkdCbXg3RzBFOXllczd2SmZ4Y3NqOVZC?=
 =?utf-8?B?S3VFMHZYbUNIR3lJUkliUkZlYjN3c084WC82YWdXb2R0Wm9kb1orU2dLaWFy?=
 =?utf-8?B?NUZJbGVjU2Mvdno5T2EyU0NZZmhyVlphVUpJWmVGSFArN0l0RHdwd2pCcG5Y?=
 =?utf-8?B?SDJxaU04WFU5STFBZTNSNEpRTERIZmd5emNUVW9HbGhROUord3lBeFYzUXZT?=
 =?utf-8?B?Q1FZMWQ5ZW9xc0FNSzFMTmtySlpMZWFwajkrL2x0ODROTXRrRjRWYzVYVitX?=
 =?utf-8?B?dUdwT21Jb2ZBWlFwTVViMDBOSlp4a0J5NGptZkZRL3dwd0xRNjI1WUFIYmNt?=
 =?utf-8?B?Y0JlazRNbUZvaUUwclJ4cmE5c1N3c0plbzdhaVFCbHUxdllVc1liU2JsS1hJ?=
 =?utf-8?B?aUV1TitXdXFhNnV3ZG1wenpMbGt3c1BOWm50RFlWMVZLV0JaODJGSVhrNE1z?=
 =?utf-8?B?bjRnTFZNLzZRa29PT2F3M0M5aWZ2MnlFM0syei9IM0ltZ1ZtRkdLY3RBWUR3?=
 =?utf-8?B?MHIzODNUMVZMTkcxclFwRmJqZVRhcFdyais4ampQU2hzN2FVaXkrQjJoWVdZ?=
 =?utf-8?B?MnE3V1diVlgvS0MvNEF4MHRMUG5OUUo3UCtQY1k0MWNIN0t1VFJ4OE5GZUZn?=
 =?utf-8?B?MUl1Y2RTYU5DT0lDTnN6K1hCdE95dE5TWFZrOE9FM2lmVmw3cVJ4R3ZKQ0VS?=
 =?utf-8?B?L3cyMFVkcnpMTEQ1azJCcFVnbk02R2NiUThNK1Iwb0RKUDlrUmR4OXZ2ZjZy?=
 =?utf-8?B?a3pVaXpDSytUN09LZ2JBc1JDWllzV3FGcVIzVXRNbFJpQnlubnkvbEhzM0Ev?=
 =?utf-8?B?WXMxRHREWXlJVlR0d01HN1ZEYUdsZzJqZlBDRlNSQXo2dHZaaWtvOU9rNGxj?=
 =?utf-8?B?ek5kalkwaG42VGdLQVR4OHdKMUNFb0lqM2s4RFlNdXZocXpoTjdwckdSUkdr?=
 =?utf-8?B?RVl6TjYyK3J4b0VoRXlBc29rbG14emNWdXJDWXNvK3pEbU1xUFJyV091S0ls?=
 =?utf-8?B?WkV6blU3UHY0VFBjTmhicVZXdHB0ZHpGem1JQjhWZFB6Rmx4U0xWUnkwRDll?=
 =?utf-8?B?a1UwYm5LZWQ0ZkwrK3JaQVJobEkvcE9NWVFxN2ZySmY4NUNrMmkxT09jWEd5?=
 =?utf-8?B?eVM3T2REME4rTlZEKzc0T0RsUW51WEFMbUpBRUVIOExsZUdwUUNLV0NvWS8r?=
 =?utf-8?B?OXVZSHhUN2NWRW1FMnFLeGJwcjc4MTBpVW43eC9wSkFZM0Q1QzM0M2JWQTd0?=
 =?utf-8?B?NVFheVo1aHRhNTkweFlHM0FyYlE5dFVzWXo5QWtuemJlUjI0dGlRZFV4cTZq?=
 =?utf-8?B?Uld4SXFHTHpqc3VkZFowbnJpVmpRaTk5a1JnUk5XaVg0azFBR2k1em1LWVB2?=
 =?utf-8?B?QVdSdEt5dlJvT2VkRDQ1R2xXNS9NaUFuUHN2NDNDLzcyZHloNU1mOEttcjJP?=
 =?utf-8?B?c0IrcVpZNUdXNlVTakVFRWZJd1ovUGw0UUpiQWVVb0lZZWpXZ0M0WU82cFRX?=
 =?utf-8?B?SmdjOUFSRHJRUERTQ29IRlBuS2VIMDRkaUxJKzQxLzNlR0hmUU9heGQ4N0dO?=
 =?utf-8?B?MFJXeHd2TTlqSkh6Mit4alhtbFVyVVphTzZwWEFoK3ZKbXlDNzhOUHZhTGdI?=
 =?utf-8?B?S2toNnUrSitmWFRPWDB2cy9jQ3ZLNWxKS3g0cjNlOU5GdE1WaUU4bFUweHA3?=
 =?utf-8?Q?j0mhOLZ4nmtFOp9cJ+0+OI0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31799fc0-4bfb-4a68-6d2c-08d9a2c68399
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:46:14.7289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLLSoi8hQiZ+kh6WVD9eI/U7PnEELCR6VQo2df8rLL3dBm13YaYy+ESYek+GW8oJijTHv7knchww5SO9TFDQ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-11-08 03:15, Shirish S wrote:
> limit the MPO rejection only for DCN1x as its not required on later
> versions.
> 
> Fixes: d89f6048bdcb ("drm/amd/display: Reject non-zero src_y and src_x for video planes")
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>

With Paul's suggestions addressed (mainly the mention of what you tested, e.g. "gesturing full-screen in Youtube Android app on DCN2.x") this patch is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1e26d9be8993..26b29d561919 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4572,7 +4572,8 @@ static void get_min_max_dc_plane_scaling(struct drm_device *dev,
>  }
>  
>  
> -static int fill_dc_scaling_info(const struct drm_plane_state *state,
> +static int fill_dc_scaling_info(struct amdgpu_device *adev,
> +				const struct drm_plane_state *state,
>  				struct dc_scaling_info *scaling_info)
>  {
>  	int scale_w, scale_h, min_downscale, max_upscale;
> @@ -4586,7 +4587,8 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
>  	/*
>  	 * For reasons we don't (yet) fully understand a non-zero
>  	 * src_y coordinate into an NV12 buffer can cause a
> -	 * system hang. To avoid hangs (and maybe be overly cautious)
> +	 * system hang on DCN1x.
> +	 * To avoid hangs (and maybe be overly cautious)
>  	 * let's reject both non-zero src_x and src_y.
>  	 *
>  	 * We currently know of only one use-case to reproduce a
> @@ -4594,10 +4596,10 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
>  	 * is to gesture the YouTube Android app into full screen
>  	 * on ChromeOS.
>  	 */
> -	if (state->fb &&
> -	    state->fb->format->format == DRM_FORMAT_NV12 &&
> -	    (scaling_info->src_rect.x != 0 ||
> -	     scaling_info->src_rect.y != 0))
> +	if (((adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 0)) ||
> +	    (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 1))) &&
> +	    (state->fb && state->fb->format->format == DRM_FORMAT_NV12 &&
> +	    (scaling_info->src_rect.x != 0 || scaling_info->src_rect.y != 0)))
>  		return -EINVAL;
>  
>  	scaling_info->src_rect.width = state->src_w >> 16;
> @@ -5503,7 +5505,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>  	int ret;
>  	bool force_disable_dcc = false;
>  
> -	ret = fill_dc_scaling_info(plane_state, &scaling_info);
> +	ret = fill_dc_scaling_info(adev, plane_state, &scaling_info);
>  	if (ret)
>  		return ret;
>  
> @@ -7566,7 +7568,7 @@ static int dm_plane_atomic_check(struct drm_plane *plane,
>  	if (ret)
>  		return ret;
>  
> -	ret = fill_dc_scaling_info(new_plane_state, &scaling_info);
> +	ret = fill_dc_scaling_info(adev, new_plane_state, &scaling_info);
>  	if (ret)
>  		return ret;
>  
> @@ -9014,7 +9016,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>  			bundle->surface_updates[planes_count].gamut_remap_matrix = &dc_plane->gamut_remap_matrix;
>  		}
>  
> -		fill_dc_scaling_info(new_plane_state,
> +		fill_dc_scaling_info(dm->adev, new_plane_state,
>  				     &bundle->scaling_infos[planes_count]);
>  
>  		bundle->surface_updates[planes_count].scaling_info =
> 


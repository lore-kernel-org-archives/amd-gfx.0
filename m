Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB41C001DE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 13:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E3810E15B;
	Mon, 24 Jul 2023 13:51:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BE810E15B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 13:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQiAHX2mqmC9DpUzhekkoLhG+rbkg2WQWVBiwnPymO3S5oUWnnL/kGKQWggIpYJgIPCWGl4hMYyIbcIYY//ekehiEb69RrHQRJr5tgJuIF4oqXQYCa8LOXxBbinh/3+xTgV/fHs0zviwSp65CqI7TkGtN+O2y0Favj3+QYVqtwlMkcWIv4BBRuVQW/ix6SqfLq8nJkTyjmhgMwYwn4RfP89ggPpp+sJsPpnk+DusD36OlEuK3xlPP0DHd+5xlUZlCFoeJtLmpI2rerFG+tjN6Y5JZFGF6w3UYBNEKUMut3468hSCDYJuuIZMJXbicsDM6MG0r8yG38luwEkmfXs8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63CQc882S+6sDa+ig02/EZsNJuRgf/W/i3r9TjaaMAg=;
 b=e2Rra8zM1MVwUkjm+0xRJj/lFh+5NEa6QSms0SUtrdpAJXcyhgM3h+yitMQspBUR0/iqWBtqfUV7DPPguD8sS1uy/du5JkLkwWOhnWavEA8+xaVxno11P6g/4OuV4gVaR1snmXDDryMuoQhFFxrOF3bGfvxxs05+EhtqZmHumcuvVlA68u4B+sqz2k+VCi2WjFSFZStq8QSMBfpZ2amYV/2aNF/Ef7K6IgCMhL5gbgFOkCEzaT0SH5RMCjtdsouzzLRCLcf/6ftPZ8Gs+A38TxRD8whF2/3Hv20VJM44BkQQLy+htzoiuQVLsRf+QnoJH11jeCrxq/Kktr6wVUp3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63CQc882S+6sDa+ig02/EZsNJuRgf/W/i3r9TjaaMAg=;
 b=Tsn4eqZl2QuTfxuTpjOX21xSELgM4vbaOo5oyCrzEm7b/I0Qp7mNaQq9PxCo7efE9yIl2e9lt/BeyWBI77+weDVeaFMSoAvIHrgqomDmdsY7qyhE2L9x6hwdWxeuT2GIGi5xP1fbgyqsnZr2OckHeVBbvZJMJuxHHCBurOV+YDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 13:51:52 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9fd8:53b3:2a30:5d93]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9fd8:53b3:2a30:5d93%5]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 13:51:52 +0000
Message-ID: <76379126-6f45-b4bd-5f92-94304503a1ab@amd.com>
Date: Mon, 24 Jul 2023 09:55:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Remove else after return in
 'dm_vblank_get_counter' & 'amdgpu_dm_backlight_get_level'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20230723093158.2052531-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230723093158.2052531-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CP5P284CA0112.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:228::17) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|SA0PR12MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 68edfe1a-4305-4396-23d1-08db8c4d223e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muVdtGoebphpAn8qGVSlPT1jxjyveHWJ9i4QdPe1sviXYtelcg2MLTMkrjeHB4qwE0iCmcGSPzG3iOnNl/xyELcPdfmlAP6NK26Rbe5aNI/ev4ltnIyM8zbyaYYvjQroO24w56UN7vd2HQjAsvYBWAaeu4gfXOUk4c+385aZW2XD74jUX4pNcbEYyvL6V/CXt8/LOfPjypIOn7nJLX1K5rtXGPpo6x8LlTn1TkhOAS9Hm/IJqEjfljzWP5fKWnky9xKbaYNH0q/XsEEOrAR705R9H8PB3RkRyXV23q20xRsHZPea5et/CI6bloR1kYDqE0viqEGHh5e5I/lYx+F4Kc5vQH8g3NoXpBT9xUN8zmoJFBA07qYkHDhvTOuNd9Ak0FMkOj2fXC+wDrDA84L3OajYRIt+U4/yS0SGP9F3taPZcBLY8xPhWZ6kFATowZOq2BdLUUGl1J36Vva1YyMSwOK6fNRE5bOMntScs1pgxx+R4grfVekG7o+5woXhvf5lvL9FYMvOn6Tjeq7NKvC2pWT/e2AKXu7iUWeiDkoypwrSwnVzrO44EW4aohMuLPOvlTbrc1nK5aH89mLGHxYhhRrqJtMyiz5qiXmbmsPlL35DEaQikIkWx4Xwoohj7zIMR2eqZxIS9zAQH3ovzceorA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(31686004)(38100700002)(31696002)(86362001)(36756003)(83380400001)(37006003)(478600001)(2616005)(53546011)(6506007)(26005)(186003)(6636002)(4326008)(66476007)(66556008)(6862004)(66946007)(316002)(41300700001)(8936002)(8676002)(5660300002)(6512007)(6486002)(6666004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N250cDVCNHFtdWRPODB3TG5kZThpRzNiSVYxcS9BdGtmdTRIdjE2clkxZHh4?=
 =?utf-8?B?cHhhSTJVcnZNRmxJbjM0VGFTbFlvNy9tbzJxNDluN0lFVm14ZG5OU0FITHJV?=
 =?utf-8?B?d2VVZHQ0L1pmOTlBU3B5Z1p1aDh2dGhMckV2Kys0TkxpU0k0ZTNPc3AzWmMr?=
 =?utf-8?B?WXNqRG9ZbCtmT3gzNVlydFZoMjU3Ym9QbmdXcStXTzF1emgrdnB1Rzd0bkpm?=
 =?utf-8?B?cE1haDNUU2tVM2oycFE3Y3IzVUdyQnJVK1ArUE1zQW1WanEzdSsrVjNLeHRV?=
 =?utf-8?B?Tms4eFJWMHhudkdzQ0RJZVNtNVJudU43eU5GY3BZN3pmWXliUVUyWno5ekpX?=
 =?utf-8?B?akk1UHpFaGh2OWJEUWQxWE5jempiMmovcXlIK0RZQ051NkY1d25qMFlmUXBz?=
 =?utf-8?B?eFkyRXhKM0VWM09LTEc0M2s2K2NBZ3Z3SUJycE5abU5POXRENE1SZk9NNXh0?=
 =?utf-8?B?WjlKSUYvK05zMEdaQUFVQjM1d2NYQnNiekM4dHRBZnBNcDA3MkNmNUpINGNT?=
 =?utf-8?B?RWxBM051S1k5MG51bSswRTFCZlZmbk56MStIZWFEMXk4NWhGQjVicGg2bW1I?=
 =?utf-8?B?bkl5aTFHQWdyNk96dkIzUmEwdDlBRkRrRVBaWWtTdVZxcmYzbmFWWnJERGc1?=
 =?utf-8?B?MEsrbVl4UlVaZWpUOWVqSERKYWZBZW1MK3F1UHFWeFpSNS9Oa2hDNGJhcWpF?=
 =?utf-8?B?MG1TMURkSWdQUkxoZm1FWExjdm4vUzZZMlhaelgzVWtQLzh4LzBjODkxcDI1?=
 =?utf-8?B?TzhIa1A4am5FVDU0ajdodGZsY0w1MkxYMVVsdFRUSmF0SmpSRjRWejU5ZHp4?=
 =?utf-8?B?MDI0YXlaMnhlREh5K3VIOUVMWGlkZ3FJeHIzMGpnNklIV3BkNTZOSzdtckMy?=
 =?utf-8?B?YnN2MmlIOS9reGRXWmEyWUpQRnRDN0FXTDVYOGU3U1MvdEF0eFBJRlBqdURt?=
 =?utf-8?B?N09xbi9tdTJKVzNFSXZoNnkxTGZlejY2aVZ3TnZCYjZyUy82citWTDJJZU9s?=
 =?utf-8?B?c2VkYlB2b2NLMlZzWlZjaHJzZnpmTEhaaUZ6cjEwYittS3lBSkVzbjhOTXhI?=
 =?utf-8?B?ZUVFeDlKSFZoclc4MXplYWdYK2p6bWJIQUo4SlYvcGxtSmVWeDhHM2RZQWpX?=
 =?utf-8?B?dks1VjBoTmRmUWhjZUtmYnJHKyszelNSVFQrcU1ZTjdzWU5XNDlRb0lNWEk3?=
 =?utf-8?B?eFluajhablRaYndseU1xLzVRMTVsK2xtLzlra0JaUStXOHBsc2NMNzJhS21P?=
 =?utf-8?B?dkoxelVNOVlOcnh4bmJMYkJhTWEyMlZYSUh6U25HeUd2M05NUkpLTWw1NWFQ?=
 =?utf-8?B?YTY2QkZQQ2Yzb1kyNkVpaUYyWkkwUlpOS1pJcHV3d0hwRU15VThWNjZHa3lR?=
 =?utf-8?B?ZU11Wnk4bzl4bkluTzZTSnZCSDY5U0VtZUVPRFZVVjZ1bGhPajhsMjkxd1pE?=
 =?utf-8?B?aWFrNXhodVZxbnFDWkVWY0xlRVBFaUVqZW45bklSekhFM0hKTDZtSXQ3TTUv?=
 =?utf-8?B?YTdjbXpLSnF5SElpajJTYThNY0ZadzBJbXJKdmU5S3JFa1F3TmVhN0RYMW9x?=
 =?utf-8?B?OG1LMGp1MU5jSWMvN3BSU0N1b3pmRS9WOHBTdmhLd1dReUd6b0hmb09aNmM5?=
 =?utf-8?B?SHhOVkNmbFpmWWQ0WjdWQlphTGJ2a01qMTI4OGVjRWh3UFBqQXNPaWtTN2x1?=
 =?utf-8?B?QlNnQlBCYVp6SlVBS3pvOHkvZWdnT3B3NGRta0lEakh2VUNVYmxDWGpDbTFY?=
 =?utf-8?B?dDZ6KzE4ZFNhMXoydG5uNGorbDZOdS8yS3lLUG5tYzIwY2tzc01taVBJTnQ3?=
 =?utf-8?B?dVZLVXluSFVZczhxbU41NGF1cFpYQ3JGTmh3NnUrUFVFVGNpUUJKRDJHNjZj?=
 =?utf-8?B?SmFwajR6NS91ejJ2WGZXUWxMQjM4SllUSGNVaHcxb0pPWnRUNEZqYWRvTTZV?=
 =?utf-8?B?cyszdHpoU3RtejVGTmVhTTI0czhTUndEL0kxcVpmZGJLNTFLN0JTMnZ5Wlkr?=
 =?utf-8?B?RTlRcEZSMXJiT2wreGpMeEtLS0ZKY2JPOVZudERFOFI2WnlOdlFSaklXcUFJ?=
 =?utf-8?B?RHpPNWxOQ2RaQmRMNWR4bzhZclZSdkNpeUs2bWMvRlhlWVBlbUowN3ZFeDds?=
 =?utf-8?Q?1tOUMiR3IROwICvF5Z3+9HZrU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68edfe1a-4305-4396-23d1-08db8c4d223e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:51:52.0880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7IxR1t7xrpH9G0Bd2CPxBXWp+XHKGnh9QIf9AqQpKZZ6LcHKDd2oSTdKDubOZf0sy+iCfsjkfI5UlEF/Eq0vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
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
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/23/23 05:31, Srinivasan Shanmugam wrote:
> Expressions under 'else' branch in function 'dm_vblank_get_counter' &
> 'amdgpu_dm_backlight_get_level' are executed whenever the expression in
> 'if' is False. Otherwise, return from case occurs. Therefore, there is
> no need in 'else', and it has been removed.
> 
> Fixes the following:
> 
> WARNING: else is not generally useful after a break or return
> +               return 0;
> +       else {
> 
> WARNING: else is not generally useful after a break or return
> +               return convert_brightness_to_user(&caps, avg);
> +       } else {
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 ++++++++++---------
>   1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1e1a38014475..77d970a2ee69 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -245,19 +245,20 @@ is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
>    */
>   static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
>   {
> +	struct amdgpu_crtc *acrtc = NULL;
> +
>   	if (crtc >= adev->mode_info.num_crtc)
>   		return 0;
> -	else {
> -		struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc];
>   
> -		if (acrtc->dm_irq_params.stream == NULL) {
> -			DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
> -				  crtc);
> -			return 0;
> -		}
> +	acrtc = adev->mode_info.crtcs[crtc];
>   
> -		return dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream);
> +	if (!acrtc->dm_irq_params.stream) {
> +		DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
> +			  crtc);
> +		return 0;
>   	}
> +
> +	return dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream);
>   }
>   
>   static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
> @@ -4091,6 +4092,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>   static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
>   					 int bl_idx)
>   {
> +	int ret;
>   	struct amdgpu_dm_backlight_caps caps;
>   	struct dc_link *link = (struct dc_link *)dm->backlight_link[bl_idx];
>   
> @@ -4105,13 +4107,14 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
>   		if (!rc)
>   			return dm->brightness[bl_idx];
>   		return convert_brightness_to_user(&caps, avg);
> -	} else {
> -		int ret = dc_link_get_backlight_level(link);
> -
> -		if (ret == DC_ERROR_UNEXPECTED)
> -			return dm->brightness[bl_idx];
> -		return convert_brightness_to_user(&caps, ret);
>   	}
> +
> +	ret = dc_link_get_backlight_level(link);
> +
> +	if (ret == DC_ERROR_UNEXPECTED)
> +		return dm->brightness[bl_idx];
> +
> +	return convert_brightness_to_user(&caps, ret);
>   }
>   
>   static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

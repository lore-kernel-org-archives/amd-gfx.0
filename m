Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157C3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 15:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7EA6F4F7;
	Thu,  2 Dec 2021 15:37:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE70D6F4F7
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 15:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW1FmZ+wvQ/bEdd4qBtN7AqzrABZJuZeJBo6julgrXfsz0qh/I1mHq6wlMQc1+DIvyFc7wbifjdKn54HMuJFwFPtUgzGIW1LyHbZb33PmbKry+N4qAU2H3N2duxQLCzkkGzqf+rAXkQZYv7ultXmlkjp43n44kTxnlNIDfUToumsqwAeosPHXllmJ8KmhDxBbqRspSSG8WyH/cLEuTIP+A44PdTzgAXQPcY+dawT0zaBTLvH9aDcGt+xOrUoE5U9u++c80ONaCgyH3+7KQhkJTZbpBkHIqbkrarZQMtfHtHz1gFV1iOpRq+BgP7aUMoKVW7bYa5xV/qcn9P9jjXNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hItl33m/BmtSK/W4JJJviyio3gz03p2A3TeIuwMsyeE=;
 b=Ag2gVOrGpcQpg5XZmdBfxoY585hyARsrUBDjF28yg7Ys+cVhj6z2W1c3ziHe9f1Nja8yL+axk/+m76ob9UHFW26YB2wYGZkgnKRP57k1CN5DQ4BFN6ZE9CucnoGBnlFffTc0sG4vMzXXFWtCXIcMI6V10hVjI7jN1Qf9LBm7KcMbvPnx5vSekCAWmuXO0QNLqdUl+i0Vcc87XxD/swzEQjfNGkbO25pGk5Cicq0mI7O18zlpTyk1/1hRhlepjkpyr4KVRZmA+tern3JSPhS/BWCrtjbwvQsaGTRjXuGKb7pPWC+cm73JS8NHq0fRwnIbd8xCGKIwrUaUzqiR2Lgktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hItl33m/BmtSK/W4JJJviyio3gz03p2A3TeIuwMsyeE=;
 b=KTkBZbO1rvPfHTnof+intWkLu4NzG9yDsJ5D8s/ps6PVwKna9YLPFU6aK/OqCrJI4TDpVrhAuNQFrbCgVsqimu8vl+i4oKtdDeDAnNgir7AzvAV94EfAMlCkaoLS7SFwl92jyM/fLP3OKFRla5d8EbHjVJ+Odj5b0RatarjR8Zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1756.namprd12.prod.outlook.com (2603:10b6:3:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 15:37:52 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 15:37:52 +0000
Message-ID: <b632c5a0-a0cf-a0eb-c878-d2b540493e01@amd.com>
Date: Thu, 2 Dec 2021 21:07:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 16/17] drm/amd/pm: revise the performance level setting
 APIs
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211202030930.1681278-1-evan.quan@amd.com>
 <20211202030930.1681278-17-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211202030930.1681278-17-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::19) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:18::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Thu, 2 Dec 2021 15:37:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 590c9cb3-1104-430a-4501-08d9b5a9b368
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1756DB38C1D05A19D724F8BE97699@DM5PR12MB1756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvQCvDdZKVQg9lfEkQxPMahdO5x//ep5iHB6tp0TpW4pnpjrYBEe2+3bn7sJU4UymjIErdR8E0sfrcHqSsh2V27eq19nuoiHs4h32jRQNly2dW5fBICLLcsUrHXKLEvWLlngcngUCzgQ9ravhC5ywoSFFTaYyON7GOEsTr08fE8sHwtmAhPuvBPl5xw3uIRXQ3wlP9IbZQG3KTwbZXQcPjBYvseXEmyQ2lxUVTLq7t7L0MwKNkhQaZ8vbBBNfzHzpksLTlKmhCTuEhHSgnSksn6W0v37oMWQq9Eyd585LXn5BIl/6avypd0yA0kYPZ8mx+DAKRTXiUlHZUgTtM0BMJTj9LEdzcg+jaHFq866YuDe+kHcjGPuE+acBCR9/ea8g/xwwXWHYS/LI7uhnrSRAlVEf3AyxAdh48xRilea4hI9WXZF3nB0uFPGHelKGBUhq0m7HxDFldKR7/efHZ8IpFqQua86eDOs0+ql0yaK77Ie3WmgYunKGjk1IIInsU3Pz0kWIEAdgc55FJjGbVOTr9IT/0wgp1LfEnTT1Am6CMdrWlL1dl/gIjwxbLyJr0KynbBznS2MP4YSgwhStrvkZ63KuBoQQawQDITO+Crczjg8ChuUOyhSFdCjVzm8IP0I30edv2KAe1swRaKzHpXmvCNf34A2oow6B18fL0itmtS6DiIcgqOJoM69uz33bQH8dUWXL/Fu6pCLwTyDUldK9UjPmORDh6iLuinni5D3Y88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(5660300002)(2616005)(66476007)(83380400001)(38100700002)(316002)(6486002)(86362001)(2906002)(8936002)(26005)(36756003)(6666004)(31696002)(4326008)(66556008)(16576012)(53546011)(8676002)(186003)(66946007)(508600001)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnRrQUZtRlpoWFlOcFhWSFhiOER4b1ZyM1diZmNtVVB5VktRTDJtY1ZsRGlS?=
 =?utf-8?B?K0dUbTRrQ3ZERDZiN0lTRkV0VGRScHFwNWwxMjFhUFh1aThuTkdpMUY5QW1w?=
 =?utf-8?B?d3FtRFJyYnJnMEhFY3NYVmhFaWJVZkVTSExFaW1wRmNGWUhzcStBVWI3c1cv?=
 =?utf-8?B?d21hQWtpYnU1Rlo2UXAyN3BETjhFOWZlcDh4a2tEUEhhRm50ZnJBamIra3Vn?=
 =?utf-8?B?WWQ0V2k1QzJuNEVpUVhOb2RLdEZGU0pRR1FMZHIwSjZFRjhjZmpCNGo5amxk?=
 =?utf-8?B?MXFLVTRVbTl0K2EzaTdlTElObmNSMkVqRDFDNldENDB4ZTczd0htYWp0NW8x?=
 =?utf-8?B?R1U2bm9TVmNQZVVMS2FheHcxQmxvY0QzMFVwUGdzVjRvQUgrMG9WYkJWbXNX?=
 =?utf-8?B?YnFRaHlOSjV1OVpqUzhqN0RiWXh0YVl5akN2YjlncjhCNWdLVEVLdzJDU082?=
 =?utf-8?B?aXNEQmo5cFZKcUNUQkxKUzVOWVdWTWQwVE1VRng0a2pZMURHWE9mOExabUov?=
 =?utf-8?B?Qk1LN2FIQ2V6ZHNYRS8vUE1jeE9sang5Qkp3OHVVaFlyN28vZlRJQys5bE1C?=
 =?utf-8?B?YkR3R1BrZTVOamtrTFZQMkRJcW5YZHdkUGdybFFUQTk1VDhIeEpKckpwYTB4?=
 =?utf-8?B?aUNXU293UGtweitUbWdXWDNjWTFheE5raHMxRC9KK0J4OTlKdHkvUWNHMVVN?=
 =?utf-8?B?Ym5OcWNjR2s2QWgzMTI2S2w3dTNZbjNTb0xDU0RIQnQxcG5hVmV0Y2RwdFhk?=
 =?utf-8?B?VXR6aEVoNTJ4OXBVN0JjTGlKS0Z1UWZHbmRUaFNOb2d4OVY5bmVaVEJkMFkx?=
 =?utf-8?B?cThWMVlNbFRLZ0kzTkE1ZGJuRUhMcmtFTlVWY2tSRjlKanNOQ2VLYnpPSXpL?=
 =?utf-8?B?QWdGd0VoZ1ZteTlQcG5paDltVFU2aUN3YlRhWXJoV2hJSmE3ajhSREEyaUg1?=
 =?utf-8?B?RjE5aG9ZUkxJMXV6VnJGOVBHSUJGSmFkRnFvUitaVEhCTnovaC8xU1d1S0JQ?=
 =?utf-8?B?OXl5TENXSDNBcGxWTkJxMUtUSXQwUjFSL3doTStjNVphMldQUUdiUm8xQWc5?=
 =?utf-8?B?OFVsbHpkUmF6Nm1HRHJHelJlUHRzSE5VUU9pOWhmWlBiVG9BZGVmSnN3SjE5?=
 =?utf-8?B?ajNVQS90QUU4bkdCR2d4czFpa3kzREx3YytrTElVK1N3dnlLbURySGRKTG04?=
 =?utf-8?B?NVZhZUo1SG1INGF4K2ZKUXArMjBMMDFuKzlPYVhyRThTU3BSYlVuNU1VdWNj?=
 =?utf-8?B?dGhxTmE2ejhyaExGMFk3amxlMnM1YUJsd2oyTWI0T216OUliYTdiUDRvbS9Q?=
 =?utf-8?B?Sm5vaDRrVEZJeUFyeVBUVXRHZ1p1cTFXcmFPZ1BYc3ExMVdoSFBadExTaDJF?=
 =?utf-8?B?aDNvM0tBdStyQ2J6YTYrSFVFblJBODlJZ2gxTWJBVGVYZGJlWGNkK0Nzdmph?=
 =?utf-8?B?emNhSmc2d2wvN2VZekxHTlY2SU5yTHhKc0xZOG5yRTdPN3lNLzAzOG5VTVNl?=
 =?utf-8?B?M1QxOU9ORlE5bXhkNFk1cG9rM29HUkhPZStlbTlmZmxuK05iTm1VOFZBQWxm?=
 =?utf-8?B?UTFIaUJORk82Ti90NXlpZ3pxOXJOTVBkT2g4WUt6cjF5anQwQzFHOXlnSGRV?=
 =?utf-8?B?T1FxVUtSVEU0Nk9uWkpQeXllN2tadXpzc25LK0VoZVMvK3lVbmdnYjFrblA4?=
 =?utf-8?B?NklIaVRoRDdQZEFLSmN2VVdkNU80bDFKTkgwMXMzV1h6eHFQeGdIRW5wZGdp?=
 =?utf-8?B?Qjk4NHZ4OW9ySUU4Nk43WFhnUk5EQ3ZMUG1aWjVCY3pYQjJXc1EyK2c4ZmpZ?=
 =?utf-8?B?TXF3NlNWa2srbWxycXFtMmR2bUdINzdaUzNaRmtEd2FFbTc2bDNURTd5cTVh?=
 =?utf-8?B?aS9hWTI0RkZKK2FEQ3kzaExPdlMwV1VYK3BiUFB0c1BOWFVoZVcvVVdZUWU2?=
 =?utf-8?B?cWpKYkRGdkRzOEo3UDA4WmxyeUdUdHZ6RFhFU2pHczZyVTlDbkRNVjBmVmlM?=
 =?utf-8?B?RVhLQTZYb3B4US91Um5SUHVRbm1GYlR1K2pUOFk0QnFNeTB0WnpoNzd6YlNJ?=
 =?utf-8?B?RlRleWdvVzdwNzRkYk40NWl0UUcrL3V2Y1Y3cWZEVXphM3BYc0V3N1ZmR1Zz?=
 =?utf-8?Q?pg/Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590c9cb3-1104-430a-4501-08d9b5a9b368
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 15:37:51.9887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMPp5xP7JSeou/BMtsghlrButwVioLlnPkuSD7TxwQoU6zbNmCjkyxsD+oIgBRQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/2/2021 8:39 AM, Evan Quan wrote:
> Avoid cross callings which make lock protection enforcement
> on amdgpu_dpm_force_performance_level() impossible.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Ie658140f40ab906ce2ec47576a086062b61076a6
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 29 ++++++++++++++++---
>   .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 17 ++++++-----
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 12 --------
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 --------
>   4 files changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index f5c0ae032954..5e5006af6b75 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -305,6 +305,10 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   	enum amd_dpm_forced_level level;
>   	enum amd_dpm_forced_level current_level;
>   	int ret = 0;
> +	uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
> +					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
> +					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
> +					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> @@ -358,10 +362,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   	}
>   
>   	/* profile_exit setting is valid only when current mode is in profile mode */
> -	if (!(current_level & (AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
> -	    AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
> -	    AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
> -	    AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)) &&
> +	if (!(current_level & profile_mode_mask) &&
>   	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)) {
>   		pr_err("Currently not in any profile mode!\n");
>   		pm_runtime_mark_last_busy(ddev->dev);
> @@ -369,6 +370,26 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   		return -EINVAL;
>   	}
>   
> +	if (!(current_level & profile_mode_mask) &&
> +	      (level & profile_mode_mask)) {
> +		/* enter UMD Pstate */
> +		amdgpu_device_ip_set_powergating_state(adev,
> +						       AMD_IP_BLOCK_TYPE_GFX,
> +						       AMD_PG_STATE_UNGATE);
> +		amdgpu_device_ip_set_clockgating_state(adev,
> +						       AMD_IP_BLOCK_TYPE_GFX,
> +						       AMD_CG_STATE_UNGATE);
> +	} else if ((current_level & profile_mode_mask) &&
> +		    !(level & profile_mode_mask)) {
> +		/* exit UMD Pstate */
> +		amdgpu_device_ip_set_clockgating_state(adev,
> +						       AMD_IP_BLOCK_TYPE_GFX,
> +						       AMD_CG_STATE_GATE);
> +		amdgpu_device_ip_set_powergating_state(adev,
> +						       AMD_IP_BLOCK_TYPE_GFX,
> +						       AMD_PG_STATE_GATE);
> +	}
> +
>   	if (amdgpu_dpm_force_performance_level(adev, level)) {
>   		pm_runtime_mark_last_busy(ddev->dev);
>   		pm_runtime_put_autosuspend(ddev->dev);
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index 3c6ee493e410..9613c6181c17 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -953,6 +953,7 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
>   
>   static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>   {
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	struct amdgpu_ps *ps;
>   	enum amd_pm_state_type dpm_state;
>   	int ret;
> @@ -976,7 +977,7 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>   	else
>   		return -EINVAL;
>   
> -	if (amdgpu_dpm == 1 && adev->powerplay.pp_funcs->print_power_state) {
> +	if (amdgpu_dpm == 1 && pp_funcs->print_power_state) {
>   		printk("switching from power state:\n");
>   		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
>   		printk("switching to power state:\n");
> @@ -985,14 +986,14 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>   
>   	/* update whether vce is active */
>   	ps->vce_active = adev->pm.dpm.vce_active;
> -	if (adev->powerplay.pp_funcs->display_configuration_changed)
> +	if (pp_funcs->display_configuration_changed)
>   		amdgpu_dpm_display_configuration_changed(adev);
>   
>   	ret = amdgpu_dpm_pre_set_power_state(adev);
>   	if (ret)
>   		return ret;
>   
> -	if (adev->powerplay.pp_funcs->check_state_equal) {
> +	if (pp_funcs->check_state_equal) {
>   		if (0 != amdgpu_dpm_check_state_equal(adev, adev->pm.dpm.current_ps, adev->pm.dpm.requested_ps, &equal))
>   			equal = false;
>   	}
> @@ -1000,24 +1001,24 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>   	if (equal)
>   		return 0;
>   
> -	if (adev->powerplay.pp_funcs->set_power_state)
> -		adev->powerplay.pp_funcs->set_power_state(adev->powerplay.pp_handle);
> +	if (pp_funcs->set_power_state)
> +		pp_funcs->set_power_state(adev->powerplay.pp_handle);
>   
>   	amdgpu_dpm_post_set_power_state(adev);
>   
>   	adev->pm.dpm.current_active_crtcs = adev->pm.dpm.new_active_crtcs;
>   	adev->pm.dpm.current_active_crtc_count = adev->pm.dpm.new_active_crtc_count;
>   
> -	if (adev->powerplay.pp_funcs->force_performance_level) {
> +	if (pp_funcs->force_performance_level) {
>   		if (adev->pm.dpm.thermal_active) {
>   			enum amd_dpm_forced_level level = adev->pm.dpm.forced_level;
>   			/* force low perf level for thermal */
> -			amdgpu_dpm_force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
> +			pp_funcs->force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
>   			/* save the user's level */
>   			adev->pm.dpm.forced_level = level;
>   		} else {
>   			/* otherwise, user selected level */
> -			amdgpu_dpm_force_performance_level(adev, adev->pm.dpm.forced_level);
> +			pp_funcs->force_performance_level(adev, adev->pm.dpm.forced_level);
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index d57d5c28c013..5a14ddd3ef05 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -323,12 +323,6 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
>   		if (*level & profile_mode_mask) {
>   			hwmgr->saved_dpm_level = hwmgr->dpm_level;
>   			hwmgr->en_umd_pstate = true;
> -			amdgpu_device_ip_set_powergating_state(hwmgr->adev,
> -					AMD_IP_BLOCK_TYPE_GFX,
> -					AMD_PG_STATE_UNGATE);
> -			amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> -						AMD_IP_BLOCK_TYPE_GFX,
> -						AMD_CG_STATE_UNGATE);
>   		}
>   	} else {
>   		/* exit umd pstate, restore level, enable gfx cg*/
> @@ -336,12 +330,6 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
>   			if (*level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
>   				*level = hwmgr->saved_dpm_level;
>   			hwmgr->en_umd_pstate = false;
> -			amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> -					AMD_IP_BLOCK_TYPE_GFX,
> -					AMD_CG_STATE_GATE);
> -			amdgpu_device_ip_set_powergating_state(hwmgr->adev,
> -					AMD_IP_BLOCK_TYPE_GFX,
> -					AMD_PG_STATE_GATE);
>   		}
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 1edc71dde3e4..e25b3b6fd22d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1681,12 +1681,6 @@ static int smu_enable_umd_pstate(void *handle,
>   			smu_dpm_ctx->saved_dpm_level = smu_dpm_ctx->dpm_level;
>   			smu_dpm_ctx->enable_umd_pstate = true;
>   			smu_gpo_control(smu, false);
> -			amdgpu_device_ip_set_powergating_state(smu->adev,
> -							       AMD_IP_BLOCK_TYPE_GFX,
> -							       AMD_PG_STATE_UNGATE);
> -			amdgpu_device_ip_set_clockgating_state(smu->adev,
> -							       AMD_IP_BLOCK_TYPE_GFX,
> -							       AMD_CG_STATE_UNGATE);

Now that this entry point is not expected to be used as standalone, you 
can also remove the enable_umd_pstate callback in IP block.

Thanks,
Lijo

>   			smu_gfx_ulv_control(smu, false);
>   			smu_deep_sleep_control(smu, false);
>   			amdgpu_asic_update_umd_stable_pstate(smu->adev, true);
> @@ -1700,12 +1694,6 @@ static int smu_enable_umd_pstate(void *handle,
>   			amdgpu_asic_update_umd_stable_pstate(smu->adev, false);
>   			smu_deep_sleep_control(smu, true);
>   			smu_gfx_ulv_control(smu, true);
> -			amdgpu_device_ip_set_clockgating_state(smu->adev,
> -							       AMD_IP_BLOCK_TYPE_GFX,
> -							       AMD_CG_STATE_GATE);
> -			amdgpu_device_ip_set_powergating_state(smu->adev,
> -							       AMD_IP_BLOCK_TYPE_GFX,
> -							       AMD_PG_STATE_GATE);
>   			smu_gpo_control(smu, true);
>   		}
>   	}
> 

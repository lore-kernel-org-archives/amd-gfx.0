Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314B9C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 13:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC68910EB36;
	Thu, 25 Jan 2024 13:11:34 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B7310EB36
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 13:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqYwA4ShYw1zokYVrAp7Qv/eU3RM4jxLicIlyElatABuGgQd4k3z7epLev654DfNiiXuSmZ03wZxAQUS15XhHHBGas1SJzCPcaIiHPi7NPnuJdiKGGW2vf2adRkXlIS1ElkDlaO9Lx0Z4bTSjbijp+xhQ8qymOVD9UBi83TcQ7Bhl2Q1U5O5u331BNXVbVfEi488n4zGg3Lm4WoQRH3hSbUQUIz/+LGBdV2u82M/txisak6nf6zHp49LVd8w8NgOfC3vuXpqJhbhIBWQ8pIN9CF1LucLhWq03Ls36Q8B4BBPO0qsm29Vn1Rae66a6DsWjO/Y+mleoghJlds3n8l2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJVhzYL4YwU/BvXdM9CWYuX/mngx5X4wCeblsavKrlU=;
 b=ccz8jjHQCFqa2BBllb0idk9GQ+XOG7YFvF9EcXLVgn4ZnyxsEcvAyBNI0+2n6Jl3oc6IYXumHHC5VKB/TXLAi1i2JC+g+h+fiTjNHKugIz0D7AsbQLVpKqMxL8NArEnvSOax8nQpL8r6JzuqWmgMETDg86V2dyuBzWrWxKkqcAVP21n8r7g3anytlTGsH54RgbHRZP2JZ/TFTPFSL2ySK34vKSMzEExtqbUe4zJJTvtCT0UG+y3vpu93aTI7TrYhz4w5VDVAuEGlHS7IQpb/REf/kc+E5fceqT+JPVUL1tL6mDST5qOu0uXouW+n0qgCu2UzIkY0WtQ8aXMWZKo71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJVhzYL4YwU/BvXdM9CWYuX/mngx5X4wCeblsavKrlU=;
 b=AJR/AN8rmJ970Ani9jMjb/Pd+PSEZKEmibYLvHCXRekwmc8a+Th8H1EK68kj+HrSNF2wegX+w8fvE2l/Pzr6oak0Gecv6aFK3Z518zYKe7jUPPx5LDvT9JgbFNC22kZ8ytycKKHNCeyGXU4dO4xMsXcdyiHMkBrewCGkYfzP2Vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Thu, 25 Jan
 2024 13:11:27 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Thu, 25 Jan 2024
 13:11:26 +0000
Message-ID: <6faf2c64-fe90-484a-902a-66a59e9c3849@amd.com>
Date: Thu, 25 Jan 2024 18:41:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Content-Language: en-US
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240125032255.898308-1-Prike.Liang@amd.com>
 <20240125032255.898308-2-Prike.Liang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240125032255.898308-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::13) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 56db41b8-0727-40cf-0525-08dc1da722b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gekAWg1PTyTmkrVkiaq0BvjwcFnUfC94MUO+d+86M6uLQi56CacroAo5kzTzxBGez7kM2m4bwkXtS+Us857CKQkOtOJxluR9rSJ1adT0OvTxAUlTNUfgGhMlYYyuc+DigmLJizzoyIV/AC1PlfpdhPZo2xSckAHNdohjI/6nxMCCEEJ4A5goAk+aw/0vVzH0A7FAPDQGM3uxTuDsogjv2GsllN4F4CMiWMOx5WLY0j+YSFdfeFznfXkJXmujXBP+P62pyexXI8r3vjh0nP63aCWEEQK4/n0In4S7fr4MNI+pKgWNw0e1yi3gBO3ZrqV+1R5reTELvKK6o9jMcH0vT8HboWUHxm9AsCEb37KPAyeIImSwlPPnKhWoq5MJ2Ze2SpodgXTxPERcHfPHbrtgEiqaPsOZKLl3HUYX7O6KmbtEwNUBFl2XBS8xASeOWjXDfF7FkttW2t9hadl255Ua0OqWe2uKL3J9LExxt+XqJWjhCzsMmOsx42ZcgyO0sJDgQmCQ0ALppyIXlDEG027e99T6Zn9LoMIytFJ4QnXA0WQw3Yk3Mm/jI2OkK2wJclZmMW9vF33xkoN+i2Bw7qTDwmJ0KIFecbcmpZslG6zde+oePHMburSGF9NUQsDQkc1LTSLtYmnrTqC7pZTfH939Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(2906002)(4326008)(5660300002)(36756003)(41300700001)(38100700002)(6486002)(478600001)(6666004)(26005)(86362001)(2616005)(31696002)(66946007)(66556008)(66476007)(316002)(6512007)(8936002)(8676002)(53546011)(6506007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2xxNlpuUVkvbEJMVWZQVlhuZklBeC9qQnRIMWZOcHFCMFUvVVhXOXdIZjVh?=
 =?utf-8?B?OVlYNnR5bXhVVWJTRFJwTmE2SzNZWFFxN2d4UW5SRkF1SDlNV0xRSXhjRHRm?=
 =?utf-8?B?bUFzV2lSbCttazFwaHE5dERVaWdmdUZnNEl6RGM3M3Y0ZFYzVThJTzlWUWR3?=
 =?utf-8?B?bkJkUXF6R3lmbW9naTlka1hiQ3liamZZMllYRStPVy9LRm8xbUhOYWlZb2d2?=
 =?utf-8?B?QTdqcjVXQW1KT24wbVI2KzVUVmlRTlpwamt0NHhrZGlSS1hjRkIwTHhsWitK?=
 =?utf-8?B?a1hzUThvYlZhelhaMElvb2F1dVpHbmI0eTVtNTBSNUc2eU13STBjVGVHaGNm?=
 =?utf-8?B?a1FmaE5PY29idzJWRGVIY2pmSFlPUnR3Yit3MlRHcGZuTTQ1MUJiSkZMaFhE?=
 =?utf-8?B?cHhEVHVKMVNVa1BxdHlraEcwT2t6Zys0T3hlNVQ4L0lRWWFBWWVtcGFmdnVC?=
 =?utf-8?B?ZEl0VkxHQXJTcS9NK01Od2ErL012SDlQVVBNS3piUXZVYk85dWNQSi91Kzhi?=
 =?utf-8?B?Tk5yNjJsVDdxeGxiM21HbXNCcGpWWWUxVlk5WXRSOUx6K0ZqNE1XZWhSeXhz?=
 =?utf-8?B?ZGxpWTNBQ1pYTGM0azdxWUdma1JxY0Q5eEtGVlp2WmROQVZFZ0JKdU5VelBR?=
 =?utf-8?B?bkRYbzk2cGFsS21DdTQ1c1RMdVh4WDBRVnJxak9JaDZqZ3MzbjJsd0tJQVRi?=
 =?utf-8?B?cmM5UHF0TnFaWVlqaU1mcldCTFlQQkdHT29VbFU3MUpvb1E5eUVqNU9VdG5u?=
 =?utf-8?B?UUNrbXFZZDYzY3g2eGpzK3grOUFSa2hsREJyTklJWnhmcFRhb3hnLzN1b1Bv?=
 =?utf-8?B?VW9MUE5SallBK3ltQUhPanBkQ1JER2JNbmx0ejNHZlk1Q25TcnhzVHkxRlNq?=
 =?utf-8?B?aTdhQjZjV0hlSWVzQ2tldUJVYURFdis3dW5uUFJiYkkyYUhLWVhtNHNKTlZW?=
 =?utf-8?B?U2kzY1B2UmVWdVFicm1CNTNsN3pNZmdYTWZCcDgySVdXVnI2am1IQlhFeXM2?=
 =?utf-8?B?RUlSWXlIQi9iRUVFaUJxNERmZWg5ZWQzMDdCTGdXVGQ1d0J2QTRhODcwQVVp?=
 =?utf-8?B?Q0t2R1N1bllBRXNGQkFvTTM5QUtFZzZqQ1BCMEE1R2NWYytQYkdtZ1A0YzZr?=
 =?utf-8?B?RmZTL01odjNoYWF0N1lMUmtPeTF2dGMvQzdTejQ3eGhBcEF2UnBpTk5pVVlk?=
 =?utf-8?B?K0VicW55Rk9xYVlET3NvZTlsa1l0ekZGUjRQbDFob1RUNlBXRzFFUnc5dkh6?=
 =?utf-8?B?QzFmT3M4bENmNXVYdjJsZENyWWtodEd3bGpoVEtlRXFCZG9FWjYrUTI2czJW?=
 =?utf-8?B?QUs4aXIveGNzMHF2enhtYThqZ0NjMVRDMCttWlVBdHhOQklEZVZZY2tRMWdW?=
 =?utf-8?B?dEhMYXpZcTNVcWtMMzJzanh5YzFkUm9WZktuZWIwYXdKWTV4SGlKRFZZQlNw?=
 =?utf-8?B?RkVLNW5OVGZGODVkdUlQNjBLbS9BOVZiL3BYeGJFY1FGZTlINE9GanJBZExa?=
 =?utf-8?B?ckl3ZWQrWTRQb2hBTUpxdytPMENxKzFoZzBSbFMwQ1U4MTgxbzc1cGhYVVlv?=
 =?utf-8?B?K2VWYVdsWDcrTW84dzk0U0J4NmFrZHJzZVhYQWJVSzc0andPTWpZSmUzK3N0?=
 =?utf-8?B?Kzg5SEZEVVc1MXMxSEhrVkFBM2crRWt4WmVZcG9KTExIeloyelJJQXNwQlB3?=
 =?utf-8?B?NlA2SG9ablNYcWpqVHljNXpBUjlkaVVaVTZwRUxxVFdUUkRFaDVHUW1oc1F5?=
 =?utf-8?B?czY5dlh4cFhwN01IVURWZFNZbG90aWNpVCtGNTVNa21zNXhEQ3dkaDFVK0Mv?=
 =?utf-8?B?cXg1dHFaVWs3WHhRdDJlSHRpbjEyOEF4MCtoZnIrdlZuOHh2M2ZRMUczQkJ3?=
 =?utf-8?B?dGdnTzltU01yYzdvL2RoQ0hFbVNUY0hCMUdadVY4UXdnQ1pFejVtVG5mNGRP?=
 =?utf-8?B?ajc1eCtrK1RnRDNqTERkNkxiVVNValVNTjY5aHdYNmJIbWk0MlZITTh3Q256?=
 =?utf-8?B?WEVYS1F3ZE9RYXBzWk1weDcxY2xmYXlmenhDSGJieUNUTmtIek81Tk1NaDk3?=
 =?utf-8?B?aU8yeVQ1QmQranRUWVF4WW1XRitqWUx1R3ppR0h5SklRRlBoSUlLMll4VGVL?=
 =?utf-8?Q?Hfhv5ObAmtiEmXdbIyEV6jYzG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56db41b8-0727-40cf-0525-08dc1da722b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 13:11:26.2511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2lyxUmbM7hQrMfs9yKPNtaGZJKRDRavDVyQu54j6BuP676ZjIax4XDRlP4wFRjY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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
Cc: Alexander.Deucher@amd.com, Deepak.Sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/25/2024 8:52 AM, Prike Liang wrote:
> In the pm abort case the gfx power rail not turn off from FCH side and
> this will lead to the gfx reinitialized failed base on the unknown gfx
> HW status, so let's reset the gpu to a known good power state.
> 

From the description, this an APU only problem (or this patch could only
resolve APU abort sequence). However, there is no check for APU in the
patch below.


> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/soc15.c         | 8 +++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 56d9dfa61290..4c40ffaaa5c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4627,6 +4627,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>  			return r;
>  	}
>  
> +	if(amdgpu_asic_need_reset_on_init(adev)) {
> +		DRM_INFO("PM abort case and let's reset asic \n");
> +		amdgpu_asic_reset(adev);
> +	}
> +

suspend_noirq is specific for suspend scenarios and not valid for
freeze/thaw. I guess this could trigger reset for successful restore on
APUs.

>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>  		return 0;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 15033efec2ba..9329a00b6abc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -804,9 +804,16 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
>  	if (adev->asic_type == CHIP_RENOIR)
>  		return true;
>  
> +	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> +
>  	/* Just return false for soc15 GPUs.  Reset does not seem to
>  	 * be necessary.
>  	 */

The comment now doesn't make sense.

Thanks,
Lijo

> +	if (adev->in_suspend && !adev->in_s0ix &&
> +			!adev->pm_complete &&
> +			sol_reg)
> +		return true;
> +
>  	if (!amdgpu_passthrough(adev))
>  		return false;
>  
> @@ -816,7 +823,6 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
>  	/* Check sOS sign of life register to confirm sys driver and sOS
>  	 * are already been loaded.
>  	 */
> -	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
>  	if (sol_reg)
>  		return true;
>  

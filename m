Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C11C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 10:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63F110F295;
	Mon, 11 Apr 2022 10:06:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95D610F295
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 10:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1KvaUQMFsT4iPaEedDDIErBxhq/BndGay3x8cgU9f4oCeD8FNrQqaZ8pArB0Uvf+O8Qe0ymXY+BPQbL5pqIYVl8jbD31KbDQpM1zgZ/clLjbrfYARA6fKcKQrFYan8345fF6d2XbdXRR8NtCeHoRK4qqhQ6m0u4dh1iyM/Psb4Cf4dvy74XWPTNluVVruwu20u8IywmjK+SAfDq2EnEcGzdCCGalm2++Qx/Of38kuxDjODJj1J4hy4YNg/bC17bNxvioQs4MdqK+REyF/UywhN/2OBcJpcYz4lztkBXP7lODqOvBIEhtwkWuY5rXlP6KyxnfA/TV47uhoebORSFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuFEtv3NQ24iHt6T8kVRF0tfWZzQqKAi5WDSVY5KJxE=;
 b=SWUepH3zybLxPOsHzPKPvAupnC7F0sdvzaQxEiiphQhRn/c8N65cTVqGGKeBiCWyy+Wge/ieZjag5myoql+2CS+o4CHnE5JdhloTY4z/BcG7JZ3JyW1HyqnNgt4Kr8Ni//sQI6tmTH6lVGZKLQhjuoa20Jz/3LupgbvPHAjLNfUh/Vy3yof4/SxPm3j1Vs7UGC6GTOQQ8rMnxHjw+cqLZsdGtmdZtEf4zrOkGjLLmp7EwJyGXWZnm/O9NFZwJ5462ejJBn5dfj2CU1Z9+dFjmnuilDo4shk1zoNOoVjMPZLy5lhFm5emS/m+pQ6AQdEcqGLZu6duLLwP+i6qUJwN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuFEtv3NQ24iHt6T8kVRF0tfWZzQqKAi5WDSVY5KJxE=;
 b=jdHLQ2fr9cpGMQVRgoQRia4iHH2yioAdM4Xn+M1GOwmkUSlepQbTMzoNUghSRZGvFl7QU3FFjgYCeiFSHNNmVsCPE/+mCSHyE0oV082ihSW7k7gclkVIvxZfKcsmaVpirEqe8yx4FOPgk0qBl0AMdt/+QIP9GkQA4MINd7bVf38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:06:39 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 10:06:39 +0000
Message-ID: <371afc58-5ee7-8171-90c2-05bb163e40ea@amd.com>
Date: Mon, 11 Apr 2022 15:36:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] drm/amd/pm: fix the deadlock issue observed on SI
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220411085453.38063-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220411085453.38063-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fb0e162-c80c-48b3-c362-08da1ba2f813
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128B574032569E81C4513E197EA9@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOxJtY4Ql+peIjRLbLz2ZfhZqpmDDctPvE6CzXW1k0WqA+JnFcS9cHgnRZ4t467hvfyhnOTZErKY37kEJk+Y36eIGon/9XJNPvAUD7zYMwbzvEkm04Pet6hwcH2mtk99nVjWXqIqxYa09kzQztqO4bcNjspfFE5gWesLnCjfCktlI1wc9dLDd/QcUlZypXd0W8A7HRAbRNeqhjmYz7tsaEOBM5H+64gB9J+gmK/DS5yI9ufqvdbqloAEJab0xbvSYk31JXylVa01llj7pwHatV6bAyW6amwM2DslrSo7lSx3ue2cQCdnvGcxjtRi5FrGUROqsTgCx9G89RH1nIxMsPGBQ79VmXdAV5b3V8tURYw99nZRxN7KF3+Id6KbnwgF0PoeRD60UubZc4fgbu/JJ+OV4A0K3HIGO6Q+lft1TcwY2SQf1135NtmX38nPeqCth9Kgp0rgpVw4JgS8g/gOObB0ZRukGwlo9QNx7lyXtCsRUYMqDhiwDVjbErjWCKDgZB5TLT0zwFtiFYn92dHWH25ZDiCXX+5G5tlYy79s8pu09esz/9CdbEeykPJVf+uipUHAlHGKv2fY3SRwDptvgwFF6YFfjsWkCubHXHWxmAY7SRZJdO4GkWCAYUv23yS4eTkdIKtVzg1/rU6MH5rpe8fs+h0D6vTEaPHW6Ff1Jws2ZphrIGmcheaVhd2jlUlr/iWBTwEBrKhEJvxwBpNOa0O2iGA7wE4TMuOW3uhGJa7G3xwAW9lxWCimySAvhgGP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(83380400001)(508600001)(2906002)(36756003)(316002)(31696002)(8676002)(4326008)(66556008)(66946007)(6486002)(66476007)(5660300002)(8936002)(53546011)(26005)(6506007)(186003)(6666004)(31686004)(2616005)(6512007)(38100700002)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDh3cmhwUGxoUVhzcytqenlRZkM2Ny9JNUkzaS9QRC9XYlVsQUxEMnlPTncr?=
 =?utf-8?B?WTk4MzNHUjhIc2JzaithczFQMWtXL0lmNHJyOEo2WjN5M0V6NllGM2NUUEJZ?=
 =?utf-8?B?MEdUQ0RWYjhZL1E3SlRjZklYTWZMK2tiVUNOQWJJVVdVZ3ozdE9GRzlZLzFh?=
 =?utf-8?B?Ti9SVm5Wa2ZOR3BqRHA0SlZsZmZZREsvNWJrN0FtOUtBR2I3cUhVcGhocFhz?=
 =?utf-8?B?c1BNS3RLYmZrakloWldZTVVYN3hTU0xTNDhRTWpWaDZJQzhEZXhRelBGb2t5?=
 =?utf-8?B?RTJCSmxCelhQamZVWnhJTjhER1R5d0xpZ1NLWnpXaWUvUFcvMW0xWVYxNXRX?=
 =?utf-8?B?dVVOUkRObG11MWt6V2ovVzJ3Vm9OMWFGamx3U3NrWERGU0laaTFZNDdzcnRn?=
 =?utf-8?B?b3ZiL2ZiUnV3Nyt5MnJuV1NUdWdWREs3RHhEbndTeVpGWmhvaUMyNXJNNWw5?=
 =?utf-8?B?Rnc5QWwrdElGYThhUUxieitldnpQWENwZGl0VkZWTjdKVHdUTkNnYmhGTVdh?=
 =?utf-8?B?czU0T0p6TnpMREdhVGZkdWVGWHRzcnpFWTFZSGpRN2llQXVsRG1kTlEyck1q?=
 =?utf-8?B?dC8yVFhFMkFIVElFQjU2bG44dmVhZGY4aGovV1UrRU1EYnAwa0F5Z1p0VGY4?=
 =?utf-8?B?T2ZMMlRqQUd5cDZUaDJvZUo4N2FqTm52QVhOS2M3N0w1TzVkRnBOQTVqY2Yv?=
 =?utf-8?B?bXd4VG1MUStlMWIweFpxSGgxK0thVzhtcFNQdlp4NXJWYmJva2w5L3NNYTdq?=
 =?utf-8?B?U3AyajVCV0E1Z2FqdXhCSEpUL3BYam43THFiUFM5QmQvSm43enlGZHhjRm80?=
 =?utf-8?B?VlNGYmlVdFgrNVdKanNJODYzd3hpRXRYYVhCQ1lVQ1hRTE5Xd1oxMGg3UWdQ?=
 =?utf-8?B?NGEzVUE0NitVY3MreGY1V1pzSFZvQy9XajRqTlc2dFhSc2tYaWVBeG1qK3FY?=
 =?utf-8?B?VSt0OXJlYTA5eW5kb0R1NGlkTjRQNmdiSEFISHhXT3p0cUFxVk5CZmdjN204?=
 =?utf-8?B?bGxqRngvQUJjR042S3Y4TUx0cm53V01PazY2Tmt2STZ2U0hoMFhoOEhpRUhJ?=
 =?utf-8?B?ZXJjaURBZXNYK1EzRlZtZmFtZk9IOSsyRGJwUzNBVVYvcllLcE8vd2loWUts?=
 =?utf-8?B?aWtxcG9oYlBJMDV6OVZGYmRFQ21MSUhLWEtBbm5jVU9XWDM3U1JuSDhUb1pn?=
 =?utf-8?B?ZXR6T1Q2K2I3WEVlWk9vWGg3UmxCYnpBM014OEw4Rk5QOW85TWhKWXRnQytt?=
 =?utf-8?B?a01qempsYXN1TkJ0SjdwVGdzNGpPVENZYkp6YVUzS2lZVGVtMmNGNWpoSWY5?=
 =?utf-8?B?R0lkNUdhakYvelRkUVM0cFVLM3NUY2NSNzVpaFdjdENYd0xHSkYrdEUwV0RW?=
 =?utf-8?B?Z1VKanFscEl3RDE5VVQwNDVQL3Z6ZktQOElzRkdOR2dta01SVjlMeFJ6c0NP?=
 =?utf-8?B?d29JZDg4Y2EwbnNCMkwxek9FZ0J5eWZmVE4xNmFwVGhDMTVpZjArNUxpTkhJ?=
 =?utf-8?B?VGFaL1YxTGNQZk1UNEs1QzRENUJITHlJbEg4bStvVERNU2hKQmN1UE9QVWt6?=
 =?utf-8?B?eHUvV0pWQVBlKy8yc2RnT05RcUJVMm16VTE4OW1BT2NqZWVRYmhodFRxQnBH?=
 =?utf-8?B?b1dLeFRFUGRBWk9PT1NmRHdEMEtzQ0htZkFiemVpVWZNWDMvcTRKS1VQRUlr?=
 =?utf-8?B?WkJDQ2pIc0tJL3RQSHVuT1ZFNktraWFqYyt6VVpJYkRmVlpYejYrbXROSitG?=
 =?utf-8?B?dGdBOWt6a0J2cXVENUZNd2s1TVM2V2g2WVh2QnArSlJ1bHM0RVFCL1JHWHNO?=
 =?utf-8?B?SEhQSnVkYk1DYWhYa2dpUUR6VWVjZCtKT3UxZUZ5U1NQc3lYcjcrTUNTRzg4?=
 =?utf-8?B?UUl5L0hqYVpMSC9UQ1Vrc1lqNjJJUUQ0OGsyOEZTbXlaZWRDL25xNS9aSTJU?=
 =?utf-8?B?SHg3MUE1Zks2QWRESXdmblB5RW5wMlJQODQ3T1hKRHhLRWhROE84Ull4NWU1?=
 =?utf-8?B?Y05NYUpEcGhscXIwVTFwR045eEtFK2ZaVnBJWXByRUQxSStremtBOFE3R3cz?=
 =?utf-8?B?dFhITHNCeHY1U25yUmcvbWsvR0ludHp2eXhad3JxcVJ5ck42Qi8yMFpPU3Jr?=
 =?utf-8?B?TDVWbFpWL0k1MW9XanRLK3o3TkNBZ1BZTkhuTTlYQ2Vwek1IOUJGeFQwV05G?=
 =?utf-8?B?bUNDdzlJdlRZd1R0R3JXcWRHaTRLZThIdTJibUtFUU5heDhtMGxUQVpUL0VP?=
 =?utf-8?B?ZVBvR25KdnZJMlNvS2lZQXBRWm4xSDJYbndRaWk1TkIxblB6bXN6bjErU2FN?=
 =?utf-8?B?ZWw4K1RucFRyVW1RMHFNRVg2TDJyS3pQMUZzaVJGczVHRm84WndRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb0e162-c80c-48b3-c362-08da1ba2f813
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 10:06:39.0636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN+tjLQ7t9My+DkH3bHlPwgTxCioBYyVxIPfPod6s2Q/1LlIEsTmSc5TI7ynaWf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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
Cc: Alexander.Deucher@amd.com, pmenzel@molgen.mpg.de,
 arthur.marsh@internode.on.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/11/2022 2:24 PM, Evan Quan wrote:
> The adev->pm.mutx is already held at the beginning of
> amdgpu_dpm_compute_clocks/amdgpu_dpm_enable_uvd/amdgpu_dpm_enable_vce.
> But on their calling path, amdgpu_display_bandwidth_update will be
> called and thus its sub functions amdgpu_dpm_get_sclk/mclk. They
> will then try to acquire the same adev->pm.mutex and deadlock will
> occur.
> 

What about using locked versions of get_sclk/mclk and leave the rest as 
they are?

Thanks,
Lijo

> By placing amdgpu_display_bandwidth_update outside of adev->pm.mutex
> protection(considering logically they do not need such protection) and
> restructuring the call flow accordingly, we can eliminate the deadlock
> issue. This comes with no real logics change.
> 
> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
> Link: https: //lore.kernel.org/all/9e689fea-6c69-f4b0-8dee-32c4cf7d8f9c@molgen.mpg.de/
> BugLink: https: //gitlab.freedesktop.org/drm/amd/-/issues/1957
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v1->v2:
>    - rich the commit messages(Paul)
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39 +++++++++++++++++++
>   .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 10 -----
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 35 -----------------
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 -----
>   4 files changed, 39 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 5504d81c77b7..72e7b5d40af6 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -427,6 +427,7 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
>   void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int i;
>   
>   	if (!adev->pm.dpm_enabled)
>   		return;
> @@ -434,6 +435,15 @@ void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>   	if (!pp_funcs->pm_compute_clocks)
>   		return;
>   
> +	if (adev->mode_info.num_crtc)
> +		amdgpu_display_bandwidth_update(adev);
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +		if (ring && ring->sched.ready)
> +			amdgpu_fence_wait_empty(ring);
> +	}
> +
>   	mutex_lock(&adev->pm.mutex);
>   	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
>   	mutex_unlock(&adev->pm.mutex);
> @@ -443,6 +453,20 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>   {
>   	int ret = 0;
>   
> +	if (adev->family == AMDGPU_FAMILY_SI) {
> +		mutex_lock(&adev->pm.mutex);
> +		if (enable) {
> +			adev->pm.dpm.uvd_active = true;
> +			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> +		} else {
> +			adev->pm.dpm.uvd_active = false;
> +		}
> +		mutex_unlock(&adev->pm.mutex);
> +
> +		amdgpu_dpm_compute_clocks(adev);
> +		return;
> +	}
> +
>   	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
>   	if (ret)
>   		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> @@ -453,6 +477,21 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>   {
>   	int ret = 0;
>   
> +	if (adev->family == AMDGPU_FAMILY_SI) {
> +		mutex_lock(&adev->pm.mutex);
> +		if (enable) {
> +			adev->pm.dpm.vce_active = true;
> +			/* XXX select vce level based on ring/task */
> +			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> +		} else {
> +			adev->pm.dpm.vce_active = false;
> +		}
> +		mutex_unlock(&adev->pm.mutex);
> +
> +		amdgpu_dpm_compute_clocks(adev);
> +		return;
> +	}
> +
>   	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
>   	if (ret)
>   		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index 9613c6181c17..d3fe149d8476 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -1028,16 +1028,6 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>   void amdgpu_legacy_dpm_compute_clocks(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	int i = 0;
> -
> -	if (adev->mode_info.num_crtc)
> -		amdgpu_display_bandwidth_update(adev);
> -
> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> -		struct amdgpu_ring *ring = adev->rings[i];
> -		if (ring && ring->sched.ready)
> -			amdgpu_fence_wait_empty(ring);
> -	}
>   
>   	amdgpu_dpm_get_active_displays(adev);
>   
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index caae54487f9c..633dab14f51c 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -3892,40 +3892,6 @@ static int si_set_boot_state(struct amdgpu_device *adev)
>   }
>   #endif
>   
> -static int si_set_powergating_by_smu(void *handle,
> -				     uint32_t block_type,
> -				     bool gate)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	switch (block_type) {
> -	case AMD_IP_BLOCK_TYPE_UVD:
> -		if (!gate) {
> -			adev->pm.dpm.uvd_active = true;
> -			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> -		} else {
> -			adev->pm.dpm.uvd_active = false;
> -		}
> -
> -		amdgpu_legacy_dpm_compute_clocks(handle);
> -		break;
> -	case AMD_IP_BLOCK_TYPE_VCE:
> -		if (!gate) {
> -			adev->pm.dpm.vce_active = true;
> -			/* XXX select vce level based on ring/task */
> -			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> -		} else {
> -			adev->pm.dpm.vce_active = false;
> -		}
> -
> -		amdgpu_legacy_dpm_compute_clocks(handle);
> -		break;
> -	default:
> -		break;
> -	}
> -	return 0;
> -}
> -
>   static int si_set_sw_state(struct amdgpu_device *adev)
>   {
>   	return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_SwitchToSwState) == PPSMC_Result_OK) ?
> @@ -8125,7 +8091,6 @@ static const struct amd_pm_funcs si_dpm_funcs = {
>   	.print_power_state = &si_dpm_print_power_state,
>   	.debugfs_print_current_performance_level = &si_dpm_debugfs_print_current_performance_level,
>   	.force_performance_level = &si_dpm_force_performance_level,
> -	.set_powergating_by_smu = &si_set_powergating_by_smu,
>   	.vblank_too_short = &si_dpm_vblank_too_short,
>   	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
>   	.get_fan_control_mode = &si_dpm_get_fan_control_mode,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index dbed72c1e0c6..1eb4e613b27a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1503,16 +1503,6 @@ static void pp_pm_compute_clocks(void *handle)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
>   	struct amdgpu_device *adev = hwmgr->adev;
> -	int i = 0;
> -
> -	if (adev->mode_info.num_crtc)
> -		amdgpu_display_bandwidth_update(adev);
> -
> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> -		struct amdgpu_ring *ring = adev->rings[i];
> -		if (ring && ring->sched.ready)
> -			amdgpu_fence_wait_empty(ring);
> -	}
>   
>   	if (!amdgpu_device_has_dc_support(adev)) {
>   		amdgpu_dpm_get_active_displays(adev);
> 

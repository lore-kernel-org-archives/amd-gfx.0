Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C4BC54F54
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 04:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649B110E1C7;
	Fri, 31 Jul 2026 04:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZdrgRaCG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F047F10E1C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 04:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kesnfkaYOE6pUSrpQMYh52dEQJNALuoBhIjvZ3xNWncq8aWdN/i9VGERDou3kWvUZHaQeAvYrs+IyODPkPzToA8H8mwWQHZ/dgbJT+7qu9Q7LVGZd4Ep/LI2/QsC7QUvSmImnkZgLjqEvc6jnlt8CSNdu4e+ON3Oei43E13xBlyGhkDkMzmoQrovG9fd93maeSMNS7QzL6av7z9Abs+XW881292A3vS25E6ye2FCg6idsN7Ma8HzkDgXfi+c1RBXUz8p9T/Hwqye6043/zAwo3fJ7eOWQDnu6FbJTxqD4VrDwztk9m3XWFvxbqNRQrnZp9ZC3Ca2q2fJNDW9m467aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXkuM/y3cLECvmJ79zhau6GA3oN20Vis/iLAB9PcTzQ=;
 b=QT0zOUbBGM3g0OdLR1LP7pSP5GRhatyJ3eEZavzyJHEnERfTpJ80pL/JLqw6x/oIEE+P+28dv47R7lWYzSa5ZduJYTSNXQauG7rlM4qnGSfbgn1GMfdbEhHPJKdFkffk1hhx9jyJm9Qv3BG2zKYZquDMvTnGUaWhQoo5Pt1YIpHzRc+9GA2EjcMTSRUAc5I3shWU8cLb5elJOB+O/R0hJHIlL8q8NrrUp1lBmJPZNELbHcRgI2XO0XkER7bM0b61Kla2uxSBO4Nn3WKzp7JESsqZCoGUYVqd8W/Ksww9VW6Yh+YrrvcIPspeCjU7/TOv9/qd00kqSrfCLGvL5XIPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXkuM/y3cLECvmJ79zhau6GA3oN20Vis/iLAB9PcTzQ=;
 b=ZdrgRaCGtZ0H/NkGDBMPduSn1cNTSCQWFDuLkWQjaxY4tf/oKhmFkzRY/opq17PL9pHmlcv28hSWFoEMXxAk1ygZ59odyYUOW98p+b4PWMpHYgKcksxTG8EduHKa34oM4LF29GMYuzJQW/6VTj7eKtucPrn3IPbxgomcNdqKZfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 04:57:32 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 04:57:32 +0000
Message-ID: <c4cd5c4c-00e5-41cb-b049-8e668270bbcf@amd.com>
Date: Fri, 31 Jul 2026 10:27:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amd/pm: refactor user PPT policy save and restore
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <cover.1785467079.git.kevinyang.wang@amd.com>
 <2a1bf8c187a6b6a67169fda0e6551a062af56c77.1785467079.git.kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <2a1bf8c187a6b6a67169fda0e6551a062af56c77.1785467079.git.kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::8) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: c13ac081-ba6e-46e1-e76b-08deeec03a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|56012099006|4143699003|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5h30W0PhPySvUfrRAWGy+CUa0kje6wToLhfEz01+pYlNlYOyb0IIMdNclXN0NdccNJ2wdaAs1VQkZdzl0uSeoPk53Euzly9jgFexeSeNSRikb0izNj7/xIjrOaJMbYCYAxC1D7z6aKVvQjZZq751nktWDTRMsMi9bkIhCTSsPazqMwGaixikBEy4VftvTgpuEQM76gr0rkKZ2Dj/675Fqs27iPK+x0hYpt9VCo+gMR+J6BCFS4068QRI+t4I0a2va8zGKWIJgR21zzejQz4naRLOERgB9cvrcOw9OMkNMFB3XQ7eDdD86akionixYKh7HpOy7c9YAoHanTuYBCSfuLbUZZsGYlyw4IGrF1Q884kXakCwnHB6GJs6NscrDoWv8b2oiNlvDg8xJ15ZOndzXcjiNDUZT0Uc2sOWIeEbZRnOq4a87zWkupPtS5NNLb/6lqJwdT05uJgBOKts5PuBCpqtP0yCnRtYIAzRlon/1xq3MvGrDJC+gCabCpaztCA/a5s+qb6V+Pjkt2UUa6UIbEPikth4HCBsTkCS9DH5ZFdGGJqf8SGTW09SnQEH+kGvWEuhBJPJlML461+fu3F+a+fKd7yWTjC9Vg9EXcY31f0vtEhUsRnHNJa/q1X3G0uB/O3hBrvBf7PxbIn89HVcRLTyYo9t+p/vf/dhp90ViCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi8zeVlhSmpiNGNXSXBUcVJndExWbzllMUhnd00vL2hXdG5WemJqUGtNTFdo?=
 =?utf-8?B?cFk1cUZsdkUyempGbFNXZFBCNjdKRTlLbWRMZlFWRU9rd2xVTEZMQVEwY2ZV?=
 =?utf-8?B?N0s0TXFMaFJsRGZmMDduMFNxRTB6S3ErYy90S2Nxc0FBckdjV1l5QTJpd2E4?=
 =?utf-8?B?TjdoamVqdU1oUUdoNy9lUWt5Mm9aN1JsaUZKMlpaVXhZS3o2b3F2VjZKNXBR?=
 =?utf-8?B?SEc3bWxINmZQU3lqdHRVTFAwRGoya2FTaGlSWm4vb3pTLzh3VEplbDBCek80?=
 =?utf-8?B?YUgvR0h3MXZMcUZudDBlRkVMS0haT01sc3Q1MThVcThQenc5ZzlvWnFDeEk0?=
 =?utf-8?B?NUQ2MHFDM0ZRMnFEMys2K3lXaGwvTXhkZURzRTJJQlRNYzg2U0Jhb3ByTm1i?=
 =?utf-8?B?NWQvMFF5N3M0UFNXL2VjMDM2RmF3UDJMNlE3RUtFQm5CZHpNdHJaODE5Unov?=
 =?utf-8?B?WFJWTjRsYTJmNHp5MEx5My9kWnoxY0Z1NHFhSUZ5dWN0SG5zWFpWOU4yZ1NX?=
 =?utf-8?B?WmdsbVk5K3M2cklRbWFKeCswb2tjZjVHZm9jMVhXWUVubkpWWUlxUzk4eVNY?=
 =?utf-8?B?ajdsMmM4d2hmSkE2Wk9kMTU5TWtta1FOMGdib1M3dDZ3L0FMNXFFbEp4QnNk?=
 =?utf-8?B?VFFkQm96T2wvdFVRNndGVnJUMTRJUDgwMWtNcU5ydGZkY1VQenRvbEZKNmtp?=
 =?utf-8?B?OGl1STF6QzlSRkduKzRKRmU4SjJIY0gxWHNwQ29GdmUxK3ZTWGlJS3dpMVZi?=
 =?utf-8?B?d1pMdXZ4ZWZaMVBqVGwwbXNLaUpNbGFFZjh1aVIxTTNncFI4K0ZtYXRzbi90?=
 =?utf-8?B?RlN6WmptUk5sMzlmeE40WnFueHVZd3o5cnY1R08yclRuWGdXNDhsSEJBYXo4?=
 =?utf-8?B?WFRyYUNhb1RET2VWVVMrWEF3WjQrODliZWV3SlZMbXh5UFlHS2FESDh2WlRJ?=
 =?utf-8?B?aEp5cjZMR21oRkRlbS95S21ucmRxSElpMzg3N0hrYnl1MzQ4YkNYckZvUnBw?=
 =?utf-8?B?SVlyKzhsVS9Qa2VITFpWNG1WVklxM3Q0ZEw0R2g2MVo0WEQyRnkyZ0xVbEU1?=
 =?utf-8?B?Zkx6UUI5L0dmUW0yRWljWjl0eFl1cERObWRMOXpGNkQrb0tzYVVDNHFrUzdD?=
 =?utf-8?B?N1hzYjMxOVFmdDNITkhYQVBFS1JPdTgwcmJiSjgwTGlicjUvSkVnUUdjNmpQ?=
 =?utf-8?B?d0ltU3FaNjBCeEkzK0lEbUhXN2xDNk9hbGE5dGFma0dYMFZIMVVKTklSS1FE?=
 =?utf-8?B?SEgyTDRhZjJNaVllNkpYQlB2OG9BUGhGMmV5dTBFWmF3QWpPTFZuR3RhMmNC?=
 =?utf-8?B?SHhNY2VHRHBhamZRU2U1YkFnbjV0T3Q2MU5QV2o5Vk0xdmRJeXhVSGFISDZi?=
 =?utf-8?B?Wm5yTkFLVXF1M1U0UlpWeWxKSU0yYkpUN0lTbmtBdTE0S3owZGpxOUhzbEo3?=
 =?utf-8?B?UXNVelZ0bVZraEZWTHNKL21lcWFqSzVBN1RmRXFQbWtScEVxMUNzTExmMmQ5?=
 =?utf-8?B?WXdUS0dJbTg3WThTbUNEODVLSktsczZJZklWakx4c1o0dWJXb0xpWW1RWldz?=
 =?utf-8?B?ZHdhd3NOYXBYTDJSSmZjVFFwaXlWQVZuN1MyeGVvT1RYN1dHUWdmR0J5WHk4?=
 =?utf-8?B?aXRlamNqcmZ4ZzRXQk0zUElXNmVjQXQxYUUvY0VSTmREWWNmQ0I4TjdkMnls?=
 =?utf-8?B?b2p1eFdLZWZQZ2xDSTQzM09yZGNlbDFOVHZNTkxlaklraHhheUxxWnEzWmhl?=
 =?utf-8?B?ZGdWZm1ORDVhSjY5OTJROUlUdDlrOXhHTUpNYkdiTHAvcXpmaXFzd1o1blFs?=
 =?utf-8?B?NWNybG1IdkdYcnNmOVNZRHd6MlkxWm1rczRxSnBEYU15eW5Ybk5BejhUNklZ?=
 =?utf-8?B?QzhQZFNtY0cxbW9xQS92aWptWG1vYlI1ejJNZHNqdUpOMnpnSWFWWW5HZkxM?=
 =?utf-8?B?VWMzWlBpRWUyNDN5TnJVM2UzQkZVTGlJdXpTa1lpT3lVZ2pFZ2xPRk1KMDNY?=
 =?utf-8?B?Qis2NHRkVk8zS1lQaHFRb3dYSFE4Yk51RjFtN0tjUTVxSGJyZ2pIdHN2VTN0?=
 =?utf-8?B?UHZiUWJzWms1eGZSQXlSd29iaUtCZ0drTFo4SlhTVExPeXBXbzk4Vi8vZUdk?=
 =?utf-8?B?U2hFTHlEaHFaMEFwdURNWUl6WG53OEdZdFNSblpaSFpEMGVUbDFnNDVTdjVR?=
 =?utf-8?B?STVMdUpvL28yYVJkSitBVUJ1Q1J2SGMwWE1rWG1OYktkd2k3UlZjT04vOHBH?=
 =?utf-8?B?MmZEU0R0T01BeUlPUkZOQmg5MkU1cWFBcUdydEFSSjlCL0tEYUl4dUx5ajBB?=
 =?utf-8?B?VUJuWVpNR3hVYm1LRHZxQzhaUUNrbm4xb3lvMTB6R25aVC8zalFIZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13ac081-ba6e-46e1-e76b-08deeec03a1a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 04:57:31.9440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdAKppkXLcwP4K1osB9zARjZOt5x2xcew67gz+mJ5gGl1/w7Ah26Jc6CWZwR/NDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
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



On 31-Jul-26 8:40 AM, Yang Wang wrote:
> The existing user policy representation has three ambiguities:
> 
> - A numeric value cannot distinguish explicit zero from an unset policy.
> - One value per controller cannot preserve independent AC and DC requests.
> - Suspend-only restore misses runtime resume, GPU reset, and table reload.
> 
> Refactor policy storage and restore as follows:
> 
> - Store values and validity masks by power source and PPT controller.
> - Save writes against the active source.
> - Restore the active source after default SMU setup.
> - Reapply the target policy after live AC/DC transitions.
> - Use the target source default when no explicit request exists.
> 
> The late-init path now covers system resume, runtime resume, GPU reset,
> and custom PPTable reload. Common code owns persistent policy; PMFW
> continues to own effective current limits.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  2 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 89 +++++++++++++------
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +-
>   3 files changed, 68 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index c3688b3b12cc..ce526db4d24a 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -508,7 +508,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
>   			amdgpu_dpm_notify_ac_dc(adev);
>   
>   		if (is_support_sw_smu(adev))
> -			smu_set_ac_dc(adev->powerplay.pp_handle);
> +			smu_set_ac_dc(adev->powerplay.pp_handle, true);
>   
>   		mutex_unlock(&adev->pm.mutex);
>   	}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 99d42446cfc8..43d5dd7dce7e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -488,12 +488,52 @@ static void smu_set_user_clk_dependencies(struct smu_context *smu, enum smu_clk_
>   		return;
>   }
>   
> +static void smu_restore_ppt_limits(struct smu_context *smu,
> +				   bool restore_defaults)
> +{
> +	enum smu_power_src_type power_source;
> +	struct smu_ppt_limit_range *range;
> +	uint32_t restore_mask;
> +	uint32_t limit;
> +	int i, ret;
> +
> +	power_source = smu->adev->pm.ac_power ?
> +		SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
> +	restore_mask = smu->user_dpm_profile.ppt_limit_user_mask[power_source] &
> +		smu->ppt_limits.supported_mask;
> +	if (!restore_mask && !restore_defaults)
> +		return;
> +
> +	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
> +
> +	for (i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
> +		if (!(smu->ppt_limits.supported_mask & BIT(i)))
> +			continue;
> +
> +		if (restore_mask & BIT(i)) {
> +			limit = smu->user_dpm_profile.ppt_limits[power_source][i];
> +		} else if (restore_defaults) {
> +			range = &smu->ppt_limits.range[power_source][i];
> +			limit = range->default_value;

This should be restore the current limit before a suspend/reset and not 
the default limit. The current limit could be set through out of band 
also, user profile values won't reflect that.

Thanks,
Lijo

> +		} else {
> +			continue;
> +		}
> +
> +		ret = smu_set_ppt_limit(smu, i, limit);
> +		if (ret)
> +			dev_err(smu->adev->dev,
> +				"Failed to restore PPT%d limit: %d\n", i, ret);
> +	}
> +
> +	smu->user_dpm_profile.flags &= ~SMU_DPM_USER_PROFILE_RESTORE;
> +}
> +
>   /**
>    * smu_restore_dpm_user_profile - reinstate user dpm profile
>    *
>    * @smu:	smu_context pointer
>    *
> - * Restore saved user power limits, clock frequencies and fan settings.
> + * Restore saved user clock frequencies and fan settings.
>    */
>   static void smu_restore_dpm_user_profile(struct smu_context *smu)
>   {
> @@ -509,17 +549,6 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
>   	/* Enable restore flag */
>   	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
>   
> -	/* set the user dpm power limits */
> -	for (int i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
> -		if (!smu->user_dpm_profile.ppt_limits[i])
> -			continue;
> -		ret = smu_set_ppt_limit(smu, i,
> -					    smu->user_dpm_profile.ppt_limits[i]);
> -		if (ret)
> -			dev_err(smu->adev->dev,
> -				"Failed to set %d PPT limit value\n", i);
> -	}
> -
>   	/* set the user dpm clock configurations */
>   	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
>   		enum smu_clk_type clk_type;
> @@ -932,7 +961,7 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
>   	 * is unnecessary.
>   	 */
>   	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> -	smu_set_ac_dc(smu);
> +	smu_set_ac_dc(smu, false);
>   
>   	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
>   	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
> @@ -967,6 +996,8 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
>   		return ret;
>   	}
>   
> +	if (adev->in_suspend)
> +		smu_restore_ppt_limits(smu, false);
>   	smu_restore_dpm_user_profile(smu);
>   
>   	return 0;
> @@ -2746,7 +2777,7 @@ static int smu_set_watermarks_for_clock_ranges(void *handle,
>   	return smu_set_watermarks_table(smu, clock_ranges);
>   }
>   
> -int smu_set_ac_dc(struct smu_context *smu)
> +int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
>   {
>   	int ret = 0;
>   
> @@ -2754,17 +2785,22 @@ int smu_set_ac_dc(struct smu_context *smu)
>   		return -EOPNOTSUPP;
>   
>   	/* controlled by firmware */
> -	if (smu->dc_controlled_by_gpio)
> -		return 0;
> +	if (!smu->dc_controlled_by_gpio) {
> +		ret = smu_set_power_source(smu,
> +					   smu->adev->pm.ac_power ?
> +					   SMU_POWER_SOURCE_AC :
> +					   SMU_POWER_SOURCE_DC);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "Failed to switch to %s mode!\n",
> +				smu->adev->pm.ac_power ? "AC" : "DC");
> +			return ret;
> +		}
> +	}
>   
> -	ret = smu_set_power_source(smu,
> -				   smu->adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
> -				   SMU_POWER_SOURCE_DC);
> -	if (ret)
> -		dev_err(smu->adev->dev, "Failed to switch to %s mode!\n",
> -		       smu->adev->pm.ac_power ? "AC" : "DC");
> +	if (restore_ppt_policy)
> +		smu_restore_ppt_limits(smu, true);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   const struct amd_ip_funcs smu_ip_funcs = {
> @@ -3020,8 +3056,11 @@ static int smu_set_ppt_limit(void *handle, uint32_t limit_type, uint32_t limit)
>   	ret = smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
>   	if (ret)
>   		return ret;
> -	if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
> -		smu->user_dpm_profile.ppt_limits[limit_type] = limit;
> +	if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> +		smu->user_dpm_profile.ppt_limits[power_source][limit_type] = limit;
> +		smu->user_dpm_profile.ppt_limit_user_mask[power_source] |=
> +			BIT(limit_type);
> +	}
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 3d32ee723b8e..698197a285e3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -251,7 +251,8 @@ enum smu_memory_pool_size {
>   
>   struct smu_user_dpm_profile {
>   	uint32_t fan_mode;
> -	uint32_t ppt_limits[SMU_LIMIT_TYPE_COUNT];
> +	uint32_t ppt_limits[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
> +	uint32_t ppt_limit_user_mask[SMU_POWER_SOURCE_COUNT];
>   	uint32_t fan_speed_pwm;
>   	uint32_t fan_speed_rpm;
>   	uint32_t flags;
> @@ -1953,7 +1954,7 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum pp_clock_type clk_type
>   
>   int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
>   
> -int smu_set_ac_dc(struct smu_context *smu);
> +int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy);
>   
>   int smu_set_xgmi_plpd_mode(struct smu_context *smu,
>   			   enum pp_xgmi_plpd_mode mode);


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9417CD6E4A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 07:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B5E113C46;
	Wed,  3 Jun 2026 07:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hgzwHQvW";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EFEB113C46
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 07:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dk8bFRbjEUHJNaarzQMbLTDM27IPBX4FLlwlxpygJ7Gq2dcYtlyb72sMJQWFJvgP0Ov61KEffvOSAYaHRDKqjqKjQvhRov2YqGy3E1oBjnEyLJEKuJRDWjUAE3elLIDGmty6GfyJTagx680YgOezA0wtTLcIa7OtcJKcLLsjzH3Gbq0ixXQwd/jVXU9JdNHl86vcAtcoVqtFlD2iOO+QKzxFmD9uhE4BMq5HAdShYj6Eq80blYLHaT+FzRyIHCMMozx1c29449OXhJCKX/kwwQrbbROtE7b28/K1hfhOwrFQezWZWaIjhfi1Y4+JgfHyiJ5OTNqcKnbRp9CwxdkYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bt2zSo3bGl0YP3Q9FIszazEYRJ2cRi8gHpaJ3F223MM=;
 b=temaNScfCqenik8SNJ46Y44oONEYzZ6Tc860mUhz1SXg8+FfV5aslpC2AVmR7e292CyI0ZaoXNC/yvKnYzCqWkyNSZSLQEcliW6h84DAaRsbqnScgxlaLxiZmsw+wzBPog7YIWuZIGwymv7qk+gT1jNhP/4zFfSx5NzkCRLTNQpoemLkOYoiHjgCrOQHif6rp6fdGWViU9S4axo5vOZ2MnXNYHuP+Q2sW8H0HFB0brAmTSB/0eBFphjmghyw5OJljmugP1vQdGYdlU1OsCO/lr0uw4/NR8PS+bSa6L2bqGLkEN30x1nzrQ7EU+E0ban3ED1pauvdshiNV1GUsnp1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt2zSo3bGl0YP3Q9FIszazEYRJ2cRi8gHpaJ3F223MM=;
 b=hgzwHQvWPzp/IETyG2XuTDpGBgXVIiGW+ZocItU5teQzTlg5NQbN4EFuCamkDpSIYtmewW9Jj27rJFvuLJYP4uOnw4nDKdPMWCeQDrlT8m0ECKLux9B2Q7BCNZ5Culjrpa5kM1siItJp6bD1tbMRj1pgD4czWuXBFY24krAheP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:25:15 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:25:15 +0000
Message-ID: <bea8eec7-192a-4d79-9ed1-245b33dc785f@amd.com>
Date: Wed, 3 Jun 2026 12:55:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260603071607.874791-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260603071607.874791-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0253.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfb6ff9-09e6-4c87-b119-08dec141418b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: uVuo3FvNx82VQZ2ZkIxoKRTgm0gTSPCMShZxWHWRqfy3hAaCUI13UsDreGU1mSd1OGY6RQWE2i0bnFEPgdDzXESNUgnuO1pUdOOKUc0Wsj9LLZm63RiFTGs4zPs26BXpgSaCvrnyCumUvtpKeJTTbYfu9F8f6iSd4g2dmHK+xUyy8ZJ4fWKfqaZ1TvtSxCEKZZawaCWlL5AFZQc8eEwS+pbyZe4mAnPePcvaAnBCfcNzMFwi4ahYsJzEQuBNMY72UNNdhbQMcXTIY5qZnjty+iAn0S+/RpumoooJ/gwhhABzA5qOx2fiOFOZNF1EMAOsxsOKznj6J++vNWoiRyVjZ+hAPwvPH8I5JpuFAMnsAYcOJGYRsdtBSrF5m+fQlZTChA4xUO3WWW+G+9hnct817oy2efTUO+S7q4UXmWKt5+LhjHM2KiPVP2Aa1Gf37Gd+mq2hCjS7hGk7aaVRndi5WEwIQ9InzrIQJjvKzvl3do4Opa/yoCHJRGiWNRG23hvzizbWNl3vKkJrv9+rEGtX/kPjpKjGqPuIdYFUTrJX0RXgRRh/IbL2gCNdSZzxxfZAuegmxrh31/Gt0HIdtcEjv8R8vNkrbAtM98QyeIM2zE6WvBNLGP2D74JcPEiEakaR40UdMJ4tZbkui78rCWhBucXXllhfr2qagFJIvqSQwMnj9sGAZDs/NRx9xnwm1inl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBRNTlheWlRM1R2eThNSXlISUVpV1ZsTnAzOGZ6K0I3MXNOVEIzbXU3UGEw?=
 =?utf-8?B?RS85TXJEb0ROTUpaOVhKUG5ncEpuYzFyeU9CK2hmN1Fyb2N5MmZPdkpvYVdU?=
 =?utf-8?B?WXNlUkErM0FsU0hQRUFRUGl4aXRNbXNYNzIrMDVvQWJiUktQTzVsMG9Hdkcr?=
 =?utf-8?B?d1JNN0tRajVpTlZKMnZRY1VzeG1DMzNpUjlXTEZlTUhtRmN4VjVPQUFSMFdu?=
 =?utf-8?B?bFI3bFV3aGZtM1NVQjVocitVUU5DSHFkUHBxMndNNTJCQkNPbW8yQTJYWHdE?=
 =?utf-8?B?eCs2VWZ1ajRYRTZmZmo4aU1YU1hmRlpFVmJiQmFtK0dqTGhBUHNDRmg2M3V0?=
 =?utf-8?B?Z0ljclN6Unhoc1ZNMHp0VmhvU1VsTU1qRDU5WmQ2NjkxRGw3R0xBWk5FbFdz?=
 =?utf-8?B?ZXBmcW10bmRvUzREbjdudmRNVjA4ek5ja2ZNOHVNdXZCSDR6blJmWmw5RjZZ?=
 =?utf-8?B?Z1JtM2xkUEhWOVV0dXNUb0Z5QVNwZFJEOXp6TWEyL2lNVEZQVlhoZzhqSzU0?=
 =?utf-8?B?VG5LbHJ6UmI0Qk1hVEQ2YlE0ekJKQnIwU1ZnTG5JOFNGRnJ1UVRjUktMdnly?=
 =?utf-8?B?VHd5bHJGajN3SG5Ka0FKYit0OUFxdFlCenVWNXBWdC90MFFNaDF1UEZOY256?=
 =?utf-8?B?MUpDbDVpRDdhQXNzSGppS3BFK1dUZUQwM282ZEpLNno2UkRBaXFmcDg4bEpl?=
 =?utf-8?B?Y2FaVVZSNmttRGt0clBtbFU3MGxHYzV0Z05FOFlqVjJLUXg4VmNXNzBuUzNB?=
 =?utf-8?B?djd0TmszVUxsUEZIckJxTnZxM0dEYnE1RkNBNGNhdXlRb2ZreWIrMG5NaFVt?=
 =?utf-8?B?ekpjRzJRbmZTTzlWalpUMUhaenY2UElCV3ByNWY5TC80OTlXZEE2RnpFR3Rk?=
 =?utf-8?B?RklhNU1XWno2RlIvMEFRRE1pLzQ1eW5rck1GaFczQk9RUFJpNmZudTRodUxE?=
 =?utf-8?B?Zm1NMWZhaU5oajdObklaNk1yMEUyakJCTUliZ3B4VGEyY1VTU0wvZGV2RGNu?=
 =?utf-8?B?T3dQVW9aSjE4bHM3ZDZkUkRFTW5DK3lhcTZKUU82Y2t2WE1FMkhlV05YTUU5?=
 =?utf-8?B?M3JKNmJxM05jU0xuemtMSTFmQ0dYNjBzK2JTV0lmL2pLeGJzZ2trbGpIdG1h?=
 =?utf-8?B?S0ZYcXNRekdXMkZ2ajg4cXBkU3RXZzFZSGZITnVMSitydXRud0Nka05aOS9u?=
 =?utf-8?B?Z0FDR3lKcXY5bDkxL2FMT1lWcmttN2c3ZEtzNTZaeVJDNDJRaHNtQjdidHJp?=
 =?utf-8?B?NHNQc0Q3SitFOTRleE1JUE02ejhNMHpiYVRYZ2RuU0t6WHVZbnhLVUl4Tk50?=
 =?utf-8?B?TUhyczhXcWtIdGFvdGZZZDQrc0p2VklKNkZMdjlaNllaMml3dXUwUzluS09u?=
 =?utf-8?B?dDV2TC9EYTQxUXVFUXZ1OExjRktpeFdud0Q2WEZCb0VPREprckRIeVpiZDYw?=
 =?utf-8?B?YVhIc0ZsNzI5aUZXNzZEN3NZd3NvVHZoMWMyeG5CL2hRNFZYcEFsZlpNV3JG?=
 =?utf-8?B?NjFSbkhjUUJEdmI3cGVQRHM0ckhZUXMzQVVTK3NZTHlKWlI5N0hiSVlPeWlo?=
 =?utf-8?B?TmptMFIwb0JCL3VNc0JEM2JaaGUzcENnUWs1RGdzU2I0NExCd3VDQW1NWmt5?=
 =?utf-8?B?Mk1EYW8wdkp3WUxFOG40T0tLOWVkUDRDd0wrQ3IxL0Q5U3dHUmFGMTlWb2sy?=
 =?utf-8?B?cENMRVo5eVQ0elNYNnJOdTE1Wkw5RFJobC90emJ1QVBMMHJVdFpPd0FxeGc5?=
 =?utf-8?B?YzNpZXhpVUcxK3ZxVTZEbnJlQXVFc0JpdGxNZVJRNlVGM2pPNFROc2RLQWJW?=
 =?utf-8?B?MEJkMWxzaUFzY3BCQzZwYzZvRENQWXAvUmRmd214ZHZpM1VFUFdEbFdUWGF4?=
 =?utf-8?B?eUJIVlVtNDRseWxjYkQ1Wm1LeGRvb2paaXRWQVIwVStVRFJlejFNZTllTk9B?=
 =?utf-8?B?enpQcE5WaXdGaUhqRDFhYjErbkxrWVZJU3RmdEh2V3JVZnZ4UW54Yml6SVZq?=
 =?utf-8?B?RHcrS296bnJIWHJqM3ZXUjZLemdYa0ptbCtMd3FFaDM5ZmFOZ2NlVG15WHly?=
 =?utf-8?B?MDc5VFplRnVBblI3eW8xZHV4Y0Z3d0F2VUFjMkRYZGRvdHYrQ3RFbTczN01X?=
 =?utf-8?B?c1hudVI4aWc0UkVUemF4M1RDbzdxZDAzeitUb0tnK21STy9LR0duS0xyanU4?=
 =?utf-8?B?ckNJV0FYbEMvVEtXTUUwOHhoWHYrZC9za29EL1ZzVFlXTDAvWTc4NzBEYTdu?=
 =?utf-8?B?a0FPOWE4ZDhTQkNmcGtqcm1ncmxTdWhsNEdtbkJWTlI5YUJLYlh3NytPVy82?=
 =?utf-8?B?ckVJb0d2RHdNOW5zQ1I1c0ZLMVdPbkRlSGIwcFd4cEhPRHYzdUgrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfb6ff9-09e6-4c87-b119-08dec141418b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:25:15.1994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WjYR/y5Pg5JQryfEhevtxicJRXYc1eKJ2lJnm07m5e2WFR6Cuzibi7+s2vt94rl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
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



On 03-Jun-26 12:46 PM, Asad Kamal wrote:
> Stop appending OD sections in amdgpu_get_pp_od_clk_voltage()
> once the sysfs page is full, instead of checking every sysfs_emit_at()
> in SMU helpers. This is purely defensive hardening.
> 
> v2: Drop the prior series that checked sysfs_emit_at()
> return values in every SMU *_emit_clk_levels() helper and
> smu_cmn_print_*().(Kevin)
> 
> v3: Update description, remove all clamping
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 1e590db80221..85bef52887d2 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -874,6 +874,8 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>   
>   	for (clk_index = 0 ; clk_index < ARRAY_SIZE(od_clocks) ; clk_index++) {
>   		amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
> +		if (unlikely(size >= (PAGE_SIZE - 1)))
> +			break;
>   	}
>   
>   	if (size == 0)


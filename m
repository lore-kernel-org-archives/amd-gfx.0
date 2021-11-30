Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2633C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 08:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9676E99C;
	Tue, 30 Nov 2021 08:09:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C13D6E99C
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 08:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSKPvimFP7KCyRykLbZg6hkw26FVTu+t03jSy7Yqexqoq3EckfUBPgVLt2TMlFJpaWMXDV9aZJCDAGMuiR4VhB1GgJFEebsFR7UNinsxVfvyBLLZcjLyF1ddyVNWXBmRkJCkBMTub4k9rwT4bz2K597qTHhmJPviN+4KXp6eMwnDeQJXPmgVOjw99g8GECFOz62U9EHNTA5MVZuTkFr9RK2IufERKx0yZMF8ee2KtrXJO3r+M3+48w7uzQkLvpFWhZ56sK3wpot6tQgbT8Lwvjy9zEEGzLONlpGOx6gFlW+eHn7/SOnC8XyrlLBiWy2IW/BnOedQcTOnXgahKKGsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2QVPyjCki+Z3HVby2H94ABsEy4yC9fwowx9BOGhhis=;
 b=Q5sE+mcQpa6E/3pVB27R25YCGl4JAIiDxXp/ywymN3BG8ZxzGha+YmfSbRPIbNzPkofjQzuZD0eywIDFBJENu5VB7aTEHTI7wwtnXFYhCEkgITQ6bgyjyto2Im1IGTwsCvSlEItd2TD+BYwBXNordudiiJFxeK1oBItJY840UVvrZuAZ9qiigxatOkicG6Ux7ag6JGyaD7Q2MIW8NBISicnA4sIYDWHwIBL30FF0NgC5hT0fFgKCPlYLYDo9+gttqYMsOoV9Ck9TOnkW7a1SnbUnnVAzN2Iv7lcC4jRES0+2+8up2oQoCkXqqr5L+tRYlBHuXKjvSw2oj61XHPXbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2QVPyjCki+Z3HVby2H94ABsEy4yC9fwowx9BOGhhis=;
 b=d7g4sZwDkwkQayjRz0zpO9Lc98MRwX902zHpcLbWP2DRuel6p+/1VLJsGXfMTq8LlI5LamnjMh2ocVW+L5X4/l41tXRAN9ZVlJVUt26rx1F4Xjxi7RR65tdVd2s0TW4qK08xBEGHn3Dkw1JQi9OzkcmGvVAC2rdofJU8dgrBs9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 08:09:53 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 08:09:53 +0000
Message-ID: <e0c706ef-7531-d4c2-a360-2771b36aa584@amd.com>
Date: Tue, 30 Nov 2021 13:39:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V2 01/17] drm/amd/pm: do not expose implementation details
 to other blocks out of power
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211130074259.1271965-1-evan.quan@amd.com>
 <20211130074259.1271965-2-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211130074259.1271965-2-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::9) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0139.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:bf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21 via Frontend Transport; Tue, 30 Nov 2021 08:09:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89833ce2-6b61-4e89-6282-08d9b3d8c9a7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:
X-Microsoft-Antispam-PRVS: <DM5PR12MB124199D9E581AE8F38090C0397679@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+d4i4kF8kOPxKYyvGDA9VUFmOq7FSbv7+JGmahcr7a00WVDnc4DFQvqpPmKjILwD77aNlf94l+BZNeif8xb2leXf1k1QX5t1fiJJMSYTcU5vS7NDyu+EToKjXHRpntfpf2aZ394mg2+q5CC58w4qL9uZUIm+wFgtbIR5bFsVUmZcLhohL8aCUCT99uWLbLJaa17pvZB8AntY0XJFVLWodieFfevLYqZX3JuBkrvuL2a6d4gu5YuetxXr3ftTgQdZKjcTGsfOSJHleXvKv+mfx6c0zzilhbM64pB152p1MjHG70LZZUyMLpiu1SPPF5wCvWUel22+gl6asj++g4uGspJOYXkWSM379tV5HvLHVXUhGrLeaW3G4T6WFgUaAabmYUoegLLFHsfr24Y0+r/dk8xgp7LmIZydDcBNT3NTo5hsy9KNATcjI1gD/mkWcqhv9f6bBUlmPdKe9eonYtQEbtVi9UGmK0iCVcM2+IoFuWeRe+v2R1cHack6JWFphKnH9AKyYgFMJTWrOUEp4m9wFcVpS/u3fjvyecrL/3/jEmzZNRaZ/uoAJo/Xz/InA/IHZLz5q+RcgrAR1kgcpdOeMeSW+/IS1Ad7APt9No6GBNCgfvv6jnKVt/rRZNLeSEiWtKx7wwZXkl8tWdYkjfQj3oPyfzUHdgvAZUEfvp2l9iraEofPxjwPEVli86XJghHLnK5BMyRbnLTd9HL0ywdoZxjeTR2yABsWrpmjJc+0qY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(8936002)(66946007)(86362001)(2616005)(16576012)(19627235002)(83380400001)(26005)(316002)(956004)(30864003)(6486002)(6666004)(36756003)(38100700002)(2906002)(31696002)(8676002)(186003)(4326008)(5660300002)(508600001)(31686004)(53546011)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHVQblh5RENYOWdwc2RNSGYwanVCQUJzWm5VYTJGemh3Mmt1Tjhncy9hNy9C?=
 =?utf-8?B?eExHV0JZZU1LbzVTdzlHeTZ5RzI3WTRWVFRaZE9yR3dmVlV1TWVQL3E4eXgx?=
 =?utf-8?B?c2JtLzYyZ1h4ekNuMjNTUnBGSGt3b2dFUGhnZmtBNFJHbmdyM1MxM1BkT2ts?=
 =?utf-8?B?RjZLT0tPYkdDRVNpZ3RuZ1BndUEzL0g3bmUvVjFISXo3emNscFRRczNPUXVU?=
 =?utf-8?B?OG01Mm1WUlhBZ01lUldsQVkvcHFXL0ZZcStjcUZMWXpaSldBdXpVbjNkZ1Nw?=
 =?utf-8?B?YmlJbzZ5Z0lhTmsrRW5XZllhN3dweWd4aU0wbDh5RzF3aWtJcDRBS1NybTRO?=
 =?utf-8?B?ajNybDFocmJQMDBJNGdqOUwvaTBESjF3akZFYVRrMGpEcCsxNFJsNjlSUUls?=
 =?utf-8?B?QzMrR1BzOU9mU0ZPcTdIVzZpOTZFZDE0TkFnVk14QTBqQ3RXR3VzMmNxNEo5?=
 =?utf-8?B?TDdlQ1Y1N3djWlhHWENabVdwUkg3SHUzWjM0Uks5NzNvTDlyZDcyVDhhaGlS?=
 =?utf-8?B?dSt3R0lKM0RpdkhhWEFXbytQM1gvS2Z2V040OFBTUzlNMUpxa1hUL21ZdGty?=
 =?utf-8?B?d2NZamFvOUJUZEtIb3FDVXYyYWgyNmtpcmtOK1gzQWtmWEc2dGpCd0tPOHZo?=
 =?utf-8?B?Z1VPVEZXWk1KUndwWXUvRCswUTBNVHZEdEltR0NPRmdabmxsK2hnSHZBV05M?=
 =?utf-8?B?L1dVd2NzSWE3akljRFZrREQ4V1ppcU42WGxrTVZkYkZOaGJFT1hoMWM3OSt1?=
 =?utf-8?B?dGtJYnJDRlZ3QStId25GdVkyS2k0MzNIUThER0pIUjMwaEsvQ0lCYitSVzZM?=
 =?utf-8?B?NU9NdnY0bFNYcXFvV2MrRUdHdFZza2xoQlBxQytUdkZKdDNObHU4Z0NTREsr?=
 =?utf-8?B?UFNlTjlyUW4rdmZiOVVuSStxdnA1TmNUaW1IUVdUQTFaYnVrdUUyUnNtSk9U?=
 =?utf-8?B?SXdybllYRDlJckk3M3ZtUGRnazZYRFl5eHlqcnNiWXZVUm9CWTVBK01TOUJ6?=
 =?utf-8?B?NVFBTnJidkdiR1FKaHZjaHNsd2hGUDdCL2gxTWgrRHI1Y1FhM2FLV0p3U096?=
 =?utf-8?B?cEhDeUE4cGVPU09zQWNqemdVKzNaMXFxd0Y2ZXNxUy92blNxZi8wN2NFampB?=
 =?utf-8?B?T3RISy83M3F1OCtTM3piU2o4bVRscnNWSlh3U0tQMHdkSklVQnlvWlMvMXdJ?=
 =?utf-8?B?Q01jbUJjUmRjdm1TVTBscVNqZ1llcEtkUVZaeW5qMko1RmJWQmF3MnA4Umla?=
 =?utf-8?B?WFF4OWExNzRBT0U0NzlERDVFSDAvTEdNd3Y5RzBnNGNjNGdKT3RhY09HQytJ?=
 =?utf-8?B?YnhJMDBxWW9Gcks3UnJDZnE2T3ZYRHg0ZnR3YjRjUnF3M3dla2ZHdlJiZCtj?=
 =?utf-8?B?bG5jZngrdy83R1pUTUtKNDdvY2MrUXZRbUZEYnFSUlBOTWFnQTQzSXJLb2dI?=
 =?utf-8?B?N001dlBvUEhFcFFNQkFHR1NSWXpwL2hoUTRJNHJMWE5UWHZ6dGFibDM1WWJX?=
 =?utf-8?B?UTBOYVRVQklZUFRnNjFaTmMwbW9La1pZZ0ptWm1LSDVzMzB5bkE2TUxpQ0ll?=
 =?utf-8?B?U0pvZTZ6WnR4QUtxWVJ6bFZkQnlqeHFZMS8rczVHTE4zd2YzenBCRTRPVk53?=
 =?utf-8?B?UWFRcDJ2bnhWWVJMb1ltOVB0cWU5MkFVUzlrOUVKQStNUDVIK204QTFqd1Jn?=
 =?utf-8?B?bTdJMlQ3MFhpMmlBYXB5dVRGQWk3MkZUMzFPRUt6dGZhUXBqRE9rQjBqZUNs?=
 =?utf-8?B?c01LeG9iNGF1RG52Y3hESHU2di9zY3hHWVJ4RmtBWVMwanllV2F4cEtqcndo?=
 =?utf-8?B?TGxQNmVLK1J3ZGgzc21ybVpkR25aNUNBVWlRTlVrdDJpWGlsNFE2RjRkSGNv?=
 =?utf-8?B?VmQ5dHppaWNTRld4WVMyWGgvSWRISDBITFhZcjRjQmJsNDhQMlFmR1EzWDF1?=
 =?utf-8?B?dXc1ckxiNHZiRHNpcEtFY2lUaHJWei9QS0tIaWQ2NEFyOWdUUzJRR0hNYkxK?=
 =?utf-8?B?R3IyZUY5VGhxY3IwaXh4RFYyVWkzZ2hRcFc5c0tTc0dzbU5ZY2YxbG9adXRO?=
 =?utf-8?B?clgvRWZ4Q3JQc1psRUYvZU5USTVlUVJ4V2ZWRk03VkpycE50LzhlY2ZPeHRC?=
 =?utf-8?Q?jO3s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89833ce2-6b61-4e89-6282-08d9b3d8c9a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:09:53.2330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2qjKIFZ9iK3t4y3zAhwWRLbYMyFzNq0rd4EGoIR2OfC0GykPilz8Z226X+e7BZt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
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



On 11/30/2021 1:12 PM, Evan Quan wrote:
> Those implementation details(whether swsmu supported, some ppt_funcs supported,
> accessing internal statistics ...)should be kept internally. It's not a good
> practice and even error prone to expose implementation details.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Ibca3462ceaa26a27a9145282b60c6ce5deca7752
> ---
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 25 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 18 +---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  7 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  2 +-
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  4 +
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 95 +++++++++++++++++++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       | 25 ++++-
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  9 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 ++--
>   13 files changed, 155 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index bcfdb63b1d42..a545df4efce1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -260,7 +260,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
>   	adev->gfx.rlc.funcs->resume(adev);
>   
>   	/* Wait for FW reset event complete */
> -	r = smu_wait_for_event(adev, SMU_EVENT_RESET_COMPLETE, 0);
> +	r = amdgpu_dpm_wait_for_event(adev, SMU_EVENT_RESET_COMPLETE, 0);
>   	if (r) {
>   		dev_err(adev->dev,
>   			"Failed to get response from firmware after reset\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..0d1f00b24aae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1585,22 +1585,25 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
>   		return ret;
>   	}
>   
> -	if (is_support_sw_smu(adev)) {
> -		ret = smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, &min_freq, &max_freq);
> -		if (ret || val > max_freq || val < min_freq)
> -			return -EINVAL;
> -		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val);
> -	} else {
> -		return 0;
> +	ret = amdgpu_dpm_get_dpm_freq_range(adev, PP_SCLK, &min_freq, &max_freq);
> +	if (ret == -EOPNOTSUPP) {
> +		ret = 0;
> +		goto out;
>   	}
> +	if (ret || val > max_freq || val < min_freq) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = amdgpu_dpm_set_soft_freq_range(adev, PP_SCLK, (uint32_t)val, (uint32_t)val);
> +	if (ret)
> +		ret = -EINVAL;
>   
> +out:
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   
> -	if (ret)
> -		return -EINVAL;
> -
> -	return 0;
> +	return ret;
>   }
>   
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1989f9e9379e..41cc1ffb5809 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2617,7 +2617,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
>   	if (adev->asic_type == CHIP_ARCTURUS &&
>   	    amdgpu_passthrough(adev) &&
>   	    adev->gmc.xgmi.num_physical_nodes > 1)
> -		smu_set_light_sbr(&adev->smu, true);
> +		amdgpu_dpm_set_light_sbr(adev, true);
>   
>   	if (adev->gmc.xgmi.num_physical_nodes > 1) {
>   		mutex_lock(&mgpu_info.mutex);
> @@ -2857,7 +2857,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>   	int i, r;
>   
>   	if (adev->in_s0ix)
> -		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
> +		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D3Entry);
>   
>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>   		if (!adev->ip_blocks[i].status.valid)
> @@ -3982,7 +3982,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   		return 0;
>   
>   	if (adev->in_s0ix)
> -		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
> +		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D0Entry);
>   
>   	/* post card */
>   	if (amdgpu_device_need_post(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 1916ec84dd71..3d8f82dc8c97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -615,7 +615,7 @@ int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)
>   
>   	mutex_lock(&adev->gfx.gfx_off_mutex);
>   
> -	r = smu_get_status_gfxoff(adev, value);
> +	r = amdgpu_dpm_get_status_gfxoff(adev, value);
>   
>   	mutex_unlock(&adev->gfx.gfx_off_mutex);
>   
> @@ -852,19 +852,3 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
>   	}
>   	return amdgpu_num_kcq;
>   }
> -
> -/* amdgpu_gfx_state_change_set - Handle gfx power state change set
> - * @adev: amdgpu_device pointer
> - * @state: gfx power state(1 -sGpuChangeState_D0Entry and 2 -sGpuChangeState_D3Entry)
> - *
> - */
> -
> -void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)
> -{
> -	mutex_lock(&adev->pm.mutex);
> -	if (adev->powerplay.pp_funcs &&
> -	    adev->powerplay.pp_funcs->gfx_state_change_set)
> -		((adev)->powerplay.pp_funcs->gfx_state_change_set(
> -			(adev)->powerplay.pp_handle, state));
> -	mutex_unlock(&adev->pm.mutex);
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f851196c83a5..776c886fd94a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -47,12 +47,6 @@ enum amdgpu_gfx_pipe_priority {
>   	AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2
>   };
>   
> -/* Argument for PPSMC_MSG_GpuChangeState */
> -enum gfx_change_state {
> -	sGpuChangeState_D0Entry = 1,
> -	sGpuChangeState_D3Entry,
> -};
> -
>   #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
>   #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
>   
> @@ -410,5 +404,4 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
>   void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
>   int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
> -void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 3c623e589b79..35c4aec04a7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -901,7 +901,7 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_d
>   	 * choosing right query method according to
>   	 * whether smu support query error information
>   	 */
> -	ret = smu_get_ecc_info(&adev->smu, (void *)&(ras->umc_ecc));
> +	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(ras->umc_ecc));
>   	if (ret == -EOPNOTSUPP) {
>   		if (adev->umc.ras_funcs &&
>   			adev->umc.ras_funcs->query_ras_error_count)
> @@ -2132,8 +2132,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>   		if (ret)
>   			goto free;
>   
> -		if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->send_hbm_bad_pages_num)
> -			adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
> +		amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
>   	}
>   
>   #ifdef CONFIG_X86_MCE_AMD
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 6e4bea012ea4..5fed26c8db44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -97,7 +97,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
>   	int ret = 0;
>   
>   	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> -	ret = smu_get_ecc_info(&adev->smu, (void *)&(con->umc_ecc));
> +	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
>   	if (ret == -EOPNOTSUPP) {
>   		if (adev->umc.ras_funcs &&
>   		    adev->umc.ras_funcs->query_ras_error_count)
> @@ -160,8 +160,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
>   						err_data->err_addr_cnt);
>   			amdgpu_ras_save_bad_pages(adev);
>   
> -			if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->send_hbm_bad_pages_num)
> -				adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
> +			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
>   		}
>   
>   		amdgpu_ras_reset_gpu(adev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index deae12dc777d..329a4c89f1e6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -222,7 +222,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>   
>   	len = snprintf(fifo_in, sizeof(fifo_in), "%x %llx:%llx\n",
>   		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
> -		       atomic64_read(&dev->adev->smu.throttle_int_counter));
> +		       amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
>   
>   	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,	fifo_in, len);
>   }
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 5c0867ebcfce..2e295facd086 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -26,6 +26,10 @@
>   
>   extern const struct amdgpu_ip_block_version pp_smu_ip_block;
>   
> +enum smu_event_type {
> +	SMU_EVENT_RESET_COMPLETE = 0,
> +};
> +
>   struct amd_vce_state {
>   	/* vce clocks */
>   	u32 evclk;
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 08362d506534..9b332c8a0079 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1614,3 +1614,98 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
>   
>   	return 0;
>   }
> +
> +int amdgpu_dpm_set_light_sbr(struct amdgpu_device *adev, bool enable)
> +{
> +	return smu_set_light_sbr(&adev->smu, enable);
> +}
> +
> +int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
> +{
> +	int ret = 0;
> +
> +	if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->send_hbm_bad_pages_num)
> +		ret = adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, size);
> +
> +	return ret;
> +}
> +
> +int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
> +				  enum pp_clock_type type,
> +				  uint32_t *min,
> +				  uint32_t *max)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	switch (type) {
> +	case PP_SCLK:
> +		return smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, min, max);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
> +				   enum pp_clock_type type,
> +				   uint32_t min,
> +				   uint32_t max)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	switch (type) {
> +	case PP_SCLK:
> +		return smu_set_soft_freq_range(&adev->smu, SMU_SCLK, min, max);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
> +			      enum smu_event_type event,
> +			      uint64_t event_arg)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	return smu_wait_for_event(&adev->smu, event, event_arg);
> +}
> +
> +int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	return smu_get_status_gfxoff(&adev->smu, value);
> +}
> +
> +uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev)
> +{
> +	return atomic64_read(&adev->smu.throttle_int_counter);
> +}
> +
> +/* amdgpu_dpm_gfx_state_change - Handle gfx power state change set
> + * @adev: amdgpu_device pointer
> + * @state: gfx power state(1 -sGpuChangeState_D0Entry and 2 -sGpuChangeState_D3Entry)
> + *
> + */
> +void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
> +				 enum gfx_change_state state)
> +{
> +	mutex_lock(&adev->pm.mutex);
> +	if (adev->powerplay.pp_funcs &&
> +	    adev->powerplay.pp_funcs->gfx_state_change_set)
> +		((adev)->powerplay.pp_funcs->gfx_state_change_set(
> +			(adev)->powerplay.pp_handle, state));
> +	mutex_unlock(&adev->pm.mutex);
> +}
> +
> +int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
> +			    void *umc_ecc)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +

In general, I don't think we need to keep this check everywhere to make 
amdgpu_dpm_* backwards compatible.  The usage is also inconsistent. For 
ex: amdgpu_dpm_get_thermal_throttling_counter doesn't have any 
is_support_sw_smu check whereas amdgpu_dpm_get_ecc_info() has it. There 
is no reason to keep adding is_support_sw_smu() check for every new 
public API. For sure, they are not going to work with powerplay subsystem.

I would rather prefer to leave old things and create amdgpu_smu_* for 
anything which is supported only in smu subsystem. It's easier to read 
from code perspective also - separate the ones which is supported by smu 
component and not supported in older powerplay components.

Only for the common ones that are supported in powerplay and smu, keep 
amdgpu_dpm_*, for others preference would be to keep amdgpu_smu_*.

Thanks,
Lijo

> +	return smu_get_ecc_info(&adev->smu, umc_ecc);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 16e3f72d31b9..7289d379a9fb 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -23,6 +23,12 @@
>   #ifndef __AMDGPU_DPM_H__
>   #define __AMDGPU_DPM_H__
>   
> +/* Argument for PPSMC_MSG_GpuChangeState */
> +enum gfx_change_state {
> +	sGpuChangeState_D0Entry = 1,
> +	sGpuChangeState_D3Entry,
> +};
> +
>   enum amdgpu_int_thermal_type {
>   	THERMAL_TYPE_NONE,
>   	THERMAL_TYPE_EXTERNAL,
> @@ -574,5 +580,22 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
>   void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
>   void amdgpu_pm_print_power_states(struct amdgpu_device *adev);
>   int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version);
> -
> +int amdgpu_dpm_set_light_sbr(struct amdgpu_device *adev, bool enable);
> +int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size);
> +int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
> +				       enum pp_clock_type type,
> +				       uint32_t *min,
> +				       uint32_t *max);
> +int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
> +				        enum pp_clock_type type,
> +				        uint32_t min,
> +				        uint32_t max);
> +int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
> +		       uint64_t event_arg);
> +int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
> +uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev);
> +void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
> +				 enum gfx_change_state state);
> +int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
> +			    void *umc_ecc);
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index f738f7dc20c9..29791bb21fba 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -241,11 +241,6 @@ struct smu_user_dpm_profile {
>   	uint32_t clk_dependency;
>   };
>   
> -enum smu_event_type {
> -
> -	SMU_EVENT_RESET_COMPLETE = 0,
> -};
> -
>   #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
>   	do {						\
>   		tables[table_id].size = s;		\
> @@ -1412,11 +1407,11 @@ int smu_set_ac_dc(struct smu_context *smu);
>   
>   int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
>   
> -int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
> +int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value);
>   
>   int smu_set_light_sbr(struct smu_context *smu, bool enable);
>   
> -int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
> +int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
>   		       uint64_t event_arg);
>   int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
>   int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 5839918cb574..ef7d0e377965 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -100,17 +100,14 @@ static int smu_sys_set_pp_feature_mask(void *handle,
>   	return ret;
>   }
>   
> -int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
> +int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value)
>   {
> -	int ret = 0;
> -	struct smu_context *smu = &adev->smu;
> +	if (!smu->ppt_funcs->get_gfx_off_status)
> +		return -EINVAL;
>   
> -	if (is_support_sw_smu(adev) && smu->ppt_funcs->get_gfx_off_status)
> -		*value = smu_get_gfx_off_status(smu);
> -	else
> -		ret = -EINVAL;
> +	*value = smu_get_gfx_off_status(smu);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   int smu_set_soft_freq_range(struct smu_context *smu,
> @@ -3167,11 +3164,10 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
>   };
>   
> -int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
> +int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
>   		       uint64_t event_arg)
>   {
>   	int ret = -EINVAL;
> -	struct smu_context *smu = &adev->smu;
>   
>   	if (smu->ppt_funcs->wait_for_event) {
>   		mutex_lock(&smu->mutex);
> 

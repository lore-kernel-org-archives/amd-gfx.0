Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AE606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 06:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oyoezxVe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0740F10E223;
	Thu,  5 Nov 2026 06:01:07 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D35B10E223
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 06:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiqkAhqLOde7oaqgRBCWap6+8DqnoBTe/ORfMF0cLI9mU0zMRWrNZOiF4LvSh+A1SywvsfgqKvpzrzX/X3ATPl9LuQ4zud4XRvXSrSrruBifL6EjrRuDaBGGGJRWv0CCXOX8iyHYa06oUHWsTkpkQdaqdQjv3ybcrvtt2ASKiZL4gUGolhVOD3Zbobk/u2wy0r9wWQhxzwKjwXtidJM2nyST+a1uY3FEsnqNiWK1kskB7ayK0OXmi6fXv8q/9fW2apQH25oMiidR+yGBo+jUtqYTSEmEAxYWvX2t/CmTukjXQrKze0XwyfNuzzkxDZRuYrNwUJ5xxRMWgtPCRg7icA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZPFYmIJd126r6yQqzm99Z7gynaEkIaPu4SuAGvk3bI=;
 b=dakMnbkXiRIGD7RplAbgtN2TRxUAwHaejNmuIbdiOIYsviJRMK3G0Z9FjirQtz17P0WXa4CrY5xSGQxJmwtC8NdEiu3Wt6n9X6t9holY5x9VaYLXuRLLPHssUyl2S0GwKkSXzId8H8lSP0LWVQIjf4Gho49Bk2CbLUOWVM+mv7f6yNDjajnnRtNQ3JzvOUM4WPA2yJsH4S6R6/IVL+yeGDdUTUdRWOaYoZOJ5P8dbetS3eHffwuAa9RE7UdznvTDDTkL59HMexVpip2GatTkn8KUcOKhJ5BB4DM0uQ04nfKXsVYGWbIpLBb40GWgZkNRjU+BPFXdx5rhCgj2k/wDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZPFYmIJd126r6yQqzm99Z7gynaEkIaPu4SuAGvk3bI=;
 b=oyoezxVe7S48vqdyxTQes0nkKzjE0pi+aav4eLD2jvst/1MK+ReH0UZ7qbcr8g/YEPdnKMSl9hsI3uwU/tVon9XHuscbv8AMJoGAKAPwUCQd+vgmpmg4im+ak+ZNRtXnWPWzJMCRqTnv4+ngab++EVr+DnZyLLxX16cxPDZdYak=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 06:00:55 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 06:00:54 +0000
Message-ID: <c2f078b9-0b5e-4592-b53c-9644307397ab@amd.com>
Date: Thu, 5 Nov 2026 11:30:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] drm/amd/pm: restore the forced performance level
 after a reset
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Kevin.Wang@amd.com, Christian.Koenig@amd.com, Felix.Kuehling@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <cover.1793787406.git.Priya.Hosur@amd.com>
 <abbf127cdaa05bc133605a961ef912dd773dab29.1793787406.git.Priya.Hosur@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <abbf127cdaa05bc133605a961ef912dd773dab29.1793787406.git.Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 80983b57-8fa9-49a2-623e-08df3b022718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|56012099006|4143699003|11063799006|261026121527099003|261028144727099003|261022075727099003|261021123027099003|261009223027099003|261026140227099003|261102123227099003|261021121427099003|261022105027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: dnhS6VKXr1Ni1zv1Rqvhlz+sHJBnWVU/5kUvdf3aZYuLv2ifHmPTtDa6h+P8YNGztLY7aWtQr556hf4xq9c8Fm+ziOyw/m93bz8G6m1pXYngOvtgOqK+Or+WAy1ruw219rzj8qNXPfqj3Lg+CUrDxCp+DUqXlkzV0q+C3erLdJJ0rtV4QLyOhLBfnMaUBzxkd9q52aLFdyRXRLY0SVJdIP40xwXVf3RIW6cJ+tykGhYRcv/CwYUhX4D6qIiJp582f/Stc/tLO9XyDuokfr4NTE3ULdayou6ogKVzeR0Pu9HSYKWxn8o+92cmu1eE47AisHQCBy0UMUqbqdCAP8Mr03CvkW/1zr8PG2/cJOU5Xa5GfhIgNFLTQLo2na0eFaXD1RDUKqU2GIa/WejAhHNKy+Y6RFUJlWNTys9P87pr2sCxo50KYlsibXWseFpIIofJ+Z679qMIKEOAo4Xkk4CZyOj+d+npTJ2D/bm7FOLjlIJxI1IaHipcuozkgra+wWD6NuNBtzTdtu4pn2nL2k1xy8Qw7Kx0k0V9CS7kxxdzdCKVY3+kiiDxeko7uvw7clmVmstfaPPc5lRVLtE+ErUhln7Omb2MgJlm4bwYMUOn9NpqqnBk+mZ+LfhDun7Cb8PSF5a3Vihctor5FjWLZ8G54vmukE1s/QM2YoD+mbw6qS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261028144727099003)(261022075727099003)(261021123027099003)(261009223027099003)(261026140227099003)(261102123227099003)(261021121427099003)(261022105027099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVFbEY5cVVwSDFSR0NudGcxS0NwMFFwODhQdUxySEx3NEl0ZHc5d2o1R05L?=
 =?utf-8?B?b0pPeTc5WUNpRDIvNVJEdFV3YVJXYVpZUUdVS2oyN3lHbjJHY0licm4zZXRT?=
 =?utf-8?B?WWhyVkxIcHNSck1nSnhkUDdzWDdIcG5SdUtnS0w1S0liSzFaMUQ2WVJKQkVK?=
 =?utf-8?B?RW93eGptUUNLeUZxSEo0MlF6cktYek1udStycU5BS0VKTDdyK1kzR1BCZFMv?=
 =?utf-8?B?MllJeVpYdG9uR3hiQWNSWTdQRVNHWCs1cU9ZZkNYdU9mU3VwNWRGUlkrUHA3?=
 =?utf-8?B?V2tKM09DTnNuOHpjT0k2R2RmS1ZVSFl1VzJ4SWppT1hoRDFTdlAvZ0FhT2VW?=
 =?utf-8?B?T2xsdWFRM3paYkJaMDFIY2NSWmpCRkoxYXNYRWNicUxBS3VDR2FubnNBOXUy?=
 =?utf-8?B?TTFKb3d1cnpqanZ0WUlGZWMwV1hpaG14RGhMSklhanFnOU9hcDRUVHlyNHhn?=
 =?utf-8?B?NjJGZ2FiVzJtM1N0dHJFSVVoVGRjSmZQdXBSUUxibGh0RXFxZlp1Q2Z3aDdj?=
 =?utf-8?B?dzVZREpXcnZLcUo4aU0wY01HTHJOMzlVaUt3OTBpUjRiL01LVWl0d3I0SGRG?=
 =?utf-8?B?MEloRGZvZVk4ME1UaWIvNjlhUVpNcU5yRU1NUE00QUgvakxzblVQMTg3MXFY?=
 =?utf-8?B?L1dCam1qRzlnWjBWbXp5dUg4OTNuN2hUSDFpNnA5Si9zMzZtcVhHYTV3d093?=
 =?utf-8?B?ZHZxU0FsM3JvdngwVk5KQmljcWJNY1Z1NllBZFZyN0lMMnRDajJaaEh1WEJm?=
 =?utf-8?B?cUZKUVA0OVdzT0VvVU44TldyVGo3bXhEMWZBUkp1Q002T3ZvRnBpTzdpK1dr?=
 =?utf-8?B?UVJib1pMa0dyclJ3Yk1aclhpdU9RRHpvVWM2SVkzNjF1SkkzRUVReFc4M043?=
 =?utf-8?B?cWgrcG1EUklueGFJQ0l6aCt6L1RldlprODdlbUlra1ZSRktJNU4xT3FRRitv?=
 =?utf-8?B?WGZJZE80SkVvWlZZV3ZSTkwxcnlZcnhkNGZua01odFhLdjJVZHhFSS91Nm10?=
 =?utf-8?B?SmcybThORnRKNGNDdkdzd2J4bCt6VTdyMVVmZlBtOTRFTkM3NXVWaXdTOHNB?=
 =?utf-8?B?b1dIQ1cxeStnd29hN3JKd2lPeFJXT2Z4YzJUdFdpYXd0a0hwL0hUUVhIMFpT?=
 =?utf-8?B?Z1RFUTZsTXBWZjB5RGNHOWhoR1NQenJrR1I5aW5jNThITnlrYnVqNmUycHpB?=
 =?utf-8?B?TGZ3VEhnYnZ1MEthbC9tTU5yWXNIc3F1bERZNitBY0JXQzhqaWZTOVF1c0ty?=
 =?utf-8?B?Mm91Qk52Zm8xcU1RMndTS1UyZUhiNldMclhPc3RNTlk0b2RSeFUyVWNFemNq?=
 =?utf-8?B?a1FUVFpLUTBuR1YrQzh1cmVEOUdJOTFHRkIvQzJ2SVp1MUZWSTQ3RnEzaWlS?=
 =?utf-8?B?L1Y5MWl2SmUzOXlyMFVzOTJmV1RJWW4rdTNTckVMWVdNM2xvbmpIVURLZmdh?=
 =?utf-8?B?eFk4WVQ2L28yQmRGNFQrbXREVWtYbTRmSGVob2J2d0dWakRVb3ZaaTBIa3VV?=
 =?utf-8?B?OHNaTWtoY0VuUWtnR0FzblJyWGpmc05QN1NlKzE0MkpmM3plSCtQMERCT3pv?=
 =?utf-8?B?SG5aTUNmcG1YRTRNSnZqUTdFZ0hIU1k5K1QrWG1nWjlNSFFYQ2t2RWtBUUVD?=
 =?utf-8?B?K0R1UXBCVnlxaXlxcnF0Z3p2SzZGRWIrWUNRRjBvR0JYSWhDZENlSXpheXRI?=
 =?utf-8?B?UjJ1bGRvUklsNS9ieDlqWlUxcGhXVTVDT21Pa2tjMGtzbC8xMGxLNmhsZzdl?=
 =?utf-8?B?dzgvMTZSVVpUWWVGYmtuT3BRRGZ4eWoxdk1XUWdCSXR3aG8zeTlteXhSQ2hH?=
 =?utf-8?B?ZUQ3NFFFeFU1a2M2NWs4eGsxN0RPTWtyTkhDOUFoRGRXZ0ZxOUhCSjJXU0pX?=
 =?utf-8?B?bkd1clNZTThlbzh5c2xEcTNPOXV0ZW9SeHg4TW9MN0RxQVN0SzNDMjRDenNw?=
 =?utf-8?B?KytRSGp4U3kwS2hjbXNsMVpTVlVobTk4VGpwQUU2OTZFbmdhN0xvcCtvbFNE?=
 =?utf-8?B?ckpyVmhFeG1MaGpxT3JDZzlKOUI2OXRmUVQ4Z3RRRXpLZ1FBejVpUGlHeFVv?=
 =?utf-8?B?R01mV3psWm9zUDVZWnA3RTgwL3kzdFdTYWc0Z3ViWUcyR0x1aWhHMzNtdjBW?=
 =?utf-8?B?ZHlTQlNsUXZMaG5BTXdDTENqdlFwdHNCci82d0NnOGVFMmpHNEcrZENCbWNV?=
 =?utf-8?B?TTZlcGc1aVVuUjFJbU1ScjU5UUMzdVFRdXJ0c0l6NjZ5SjBkUmd3RXdKdE40?=
 =?utf-8?B?WHRnandBUE13TFU2cjFsc2tRa0lYcjErUEgweDFtMklsbXh3YkYxOEExSzBt?=
 =?utf-8?Q?xuBeBt8Gu78DDMvRqi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80983b57-8fa9-49a2-623e-08df3b022718
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:00:54.5269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqNR1t1bjW6srkQ2j1WAjDd/gV3JgRFGsbyYISktaoNBJaZ0kcRwRr1XthU4ya6l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 04-Nov-26 3:52 PM, Priya Hosur wrote:
> After a GPU reset PMFW is reinitialised and comes back on its default
> curve, while smu_dpm.dpm_level still holds the level the user forced. On
> an SMU 14.0.1 APU with the level set to high, gfxclk drops from 2.8GHz to
> 600MHz while sysfs still reports high. Writing the same level again does
> not help, as amdgpu_dpm_force_performance_level() returns early when the
> requested level matches the cached one.
> 
> smu_late_init() does not re-program the level either, as the
> AMD_PP_TASK_COMPLETE_INIT path compares the cached level against itself.
> 
> amdgpu_dpm_reapply_umd_profile() replays the retained level after reset
> and resume, but only for the PROFILE_* levels, and returns early for any
> other level.
> 
> Restore every level through this common path and rename it to
> amdgpu_dpm_reapply_performance_level(). The PROFILE_* levels keep their
> UMD pstate handling, other levels only replay the level itself. auto is
> skipped, as PMFW comes back in auto, as it does at probe. If replaying a
> non-profile level fails, the failure is logged and the level the user
> asked for is kept.
> 
> smu_reapply_power_state_dynamic() duplicates
> smu_adjust_power_state_dynamic() with the display settings skipped and
> the level forced, so call that instead.
> 
> v2: restore the forced level instead of reporting the default after the
>      reset (Lijo).
> 
> v3: use the force_performance_level argument of
>      smu_adjust_power_state_dynamic() instead of switching the cached level
>      to auto first.
> 
> v4: restore the level through the common reapply path instead of
>      smu_handle_task(), rename amdgpu_dpm_reapply_umd_profile() to
>      amdgpu_dpm_reapply_performance_level(), replay non-profile levels
>      directly and replace the body of smu_reapply_power_state_dynamic()
>      (Lijo). Add the Fixes tag (Kevin).
> 
> Fixes: 580ad7cbd4b7 ("drm/amdgpu/swsmu: Only force workload setup on init")
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +--
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 21 +++++++++---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  2 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 39 ++++------------------
>   4 files changed, 26 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5069042b5279..2f7ef4bb2a65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2774,9 +2774,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
>   	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
>   
> -	r = amdgpu_dpm_reapply_umd_profile(adev);
> +	r = amdgpu_dpm_reapply_performance_level(adev);
>   	if (r) {
> -		dev_err(adev->dev, "Failed to restore UMD profile state: %d\n", r);
> +		dev_err(adev->dev, "Failed to restore performance level: %d\n", r);
>   		return r;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 75d8bb4868e8..ea698fe48e07 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1083,14 +1083,16 @@ static void amdgpu_dpm_exit_umd_state(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * amdgpu_dpm_reapply_umd_profile - Restore the active UMD profile
> + * amdgpu_dpm_reapply_performance_level - Restore the retained DPM level
>    * @adev: amdgpu device
>    *
>    * Resume and reset retain the selected DPM level in software, but the
> - * underlying GFX and PMFW state is lost. Reapply a retained UMD profile
> - * after the common resume path has restored its default CG and PG state.
> + * underlying GFX and PMFW state is lost. Reapply the retained level after
> + * the common resume path has restored its default CG and PG state. UMD
> + * profile levels also restore their GFX state, other levels only replay
> + * the level itself.
>    */
> -int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev)
> +int amdgpu_dpm_reapply_performance_level(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	enum amd_dpm_forced_level level;
> @@ -1120,7 +1122,18 @@ int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev)
>   	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
>   	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
>   		break;
> +	case AMD_DPM_FORCED_LEVEL_AUTO:
> +		/* PMFW comes back in auto, as it does at probe. */
> +		ret = 0;
> +		goto unlock;
>   	default:
> +		/* No UMD pstate state to restore, only the level itself. */
> +		ret = pp_funcs->reapply_performance_level(adev->powerplay.pp_handle,
> +							     level);
> +		if (ret)
> +			dev_warn(adev->dev,
> +				 "Failed to restore performance level %d: %d\n",
> +				 level, ret);
>   		ret = 0;
>   		goto unlock;
>   	}
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index ba8624d28f28..8ae3fcc016f8 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -484,7 +484,7 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
>   enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev);
>   int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
>   				       enum amd_dpm_forced_level level);
> -int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev);
> +int amdgpu_dpm_reapply_performance_level(struct amdgpu_device *adev);
>   int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
>   				 struct pp_states_info *states);
>   int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index a901f8535598..e45aeb2c565b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2507,33 +2507,7 @@ static int
>   smu_reapply_power_state_dynamic(struct smu_context *smu,
>   				enum amd_dpm_forced_level level)
>   {
> -	struct smu_dpm_context *smu_dpm_ctx = &smu->smu_dpm;
> -	int ret;
> -
> -	ret = smu_apply_clocks_adjust_rules(smu);
> -	if (ret) {
> -		dev_err(smu->adev->dev, "Failed to apply clocks adjust rules!");
> -		return ret;
> -	}
> -
> -	ret = smu_asic_set_performance_level(smu, level);
> -	if (ret) {
> -		if (ret == -EOPNOTSUPP)
> -			dev_info(smu->adev->dev, "set performance level %d not supported",
> -				 level);
> -		else
> -			dev_err(smu->adev->dev, "Failed to set performance level %d",
> -				level);
> -		return ret;
> -	}
> -
> -	smu_dpm_ctx->dpm_level = level;
> -
> -	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL ||
> -	    smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> -		return 0;
> -
> -	return smu_bump_power_profile_mode(smu, NULL, 0);
> +	return smu_adjust_power_state_dynamic(smu, level, true, true);
>   }
>   
>   static int smu_handle_task(struct smu_context *smu,
> @@ -2698,21 +2672,20 @@ smu_reapply_performance_level(void *handle,
>   	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
>   		return -EINVAL;
>   
> +	if (smu_dpm_ctx->dpm_level != level)
> +		return -EINVAL;
> +
>   	switch (level) {
>   	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
>   	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
>   	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
>   	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> +		smu_enter_umd_pstate(smu);
>   		break;
>   	default:
> -		return -EINVAL;
> +		break;
>   	}
>   
> -	if (smu_dpm_ctx->dpm_level != level)
> -		return -EINVAL;
> -
> -	smu_enter_umd_pstate(smu);
> -
>   	return smu_reapply_power_state_dynamic(smu, level);
>   }
>   


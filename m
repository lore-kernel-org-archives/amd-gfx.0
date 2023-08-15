Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457CBC001B0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 14:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE9210E198;
	Tue, 15 Aug 2023 14:35:35 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4935010E198
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 14:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIHVyfgdb8dL1owF1bjJMOU7xbd6n4XiaHpgrtkXinjgVdPrk3sv65ZfOkskT43xa8/VsNHsgLA30Rq6euREaT6BA/4HFXfZczgU126RQxYK9FFyVD1jY0SxDUvwhBlxNSl6FE7q0UPGFVc3kL4jHDkbImjYaY5AClqCwq6GV2lEGvOoo7nNKsK0Yho46BAXTjRfUUYaOhHHiWagNyW1mhqxvyOPPpWbvKxOUNuGkO7LAf/LQSdPY3vkZobKD7zkhYHlz3PLW/Z18NWRs0VyETJlPGijy1Wa3OLzZx7FX5VjFRZtgfWOQuwqY0GDQKfuhCmh+Rinoj9Atb6K8mmUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxGWuU6XQouzsaekUNhb7YKrAYu8j98/5TIh2emv0o0=;
 b=Vntkkqhp0I3Ucp//d3JppQX/1Uw2ATb7rkgu8gaEjSrUYkMdFPf6HzKHHmqzaopb98N9W/YEy8oCuzLHTgV1AINBCzgwhCvwFZlqtYiEpAoUYqFWF7ifD83+8uht20axF/Zl+oLWOxCtMhbkOKnmFK8QX7DV2eW8l7f4y0gOtwbjKS17oVteZfew2sEUFJgb9PbCunCd4cT0zlMnj+jlTKQ+xfdVlChunyawFzgfWcNTIFx23noOhT1yVOimJEX0rRsV9law0AgxWofZQEm7u0DHRZ0HlE44wfHfPdFMhiuWtoi8o4M7jxwwcEkP4oVaeydStT7eSmWq1/CeA8OVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxGWuU6XQouzsaekUNhb7YKrAYu8j98/5TIh2emv0o0=;
 b=LiWacNI2vYyH9KhepG4NklYGvIqeeaDGHBFpexGUc3jsEGcaxtBhy3exCZmjnP+vXMXR1D3gnqmmr16MGRCJQTDTihgfDXA/0+WC+wWT0LHo+wWggrtd1UwhagJdTosm1xMvjwqOyjlagSzSa9F7fJU4uEOf6cdbGsVsew+uXHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 14:35:29 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::4196:c9c9:dfe9:8079]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::4196:c9c9:dfe9:8079%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 14:35:29 +0000
Message-ID: <b737e90e-10f2-4ef4-b49a-2eba5f83afef@amd.com>
Date: Tue, 15 Aug 2023 10:35:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Add notification function for no DC support
To: Bokun Zhang <bokun.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230815142907.196429-1-bokun.zhang@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230815142907.196429-1-bokun.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::31) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e77e5b-8968-4afb-bf1a-08db9d9cdf74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deb38f87qNVgd0soPx/UC9L7wIOyTL31ntSog+VUSBpBaNI9y30EHrfm+FvcY1R1EZa+MOL0RgfSyxYIroZFfGO4a6nnI1T+o3RlSNIb3G6kOjH4Hjoy0UvY9t/cgkDSJZT9SGEspAj3V2XQamqwlCAIg1pJkN4bTjzEhXxyBBBsvbHPjtv3yf+rvICYw+VK4wMe9BFAliBINU9NgD5LnQsvm7LbBr6Zd9eGuV56mUuVo13MPwOgagQ+SwTlaUBCOdf+5yYDjydCYLLLyhbaU7xokA8/phxiSdW2vZFe0oqfy4Zqr4fj2j2sjC2quYZZUoOlXhhBzYo6xVHlsGBDjxzHfM5JOZudLq6+CIWGYT6Ti2VXN9U6FRRwuqRhvqswZqD1rr8mJ5H+Lq0I6RecPBZt/5SVnYku96QRKTyJzEcogHx+9rMhyInMPOZLKcMU0wnJJ0voKhr23onELPVd+ZWNwqFeTDXs7VIhJpc/AJLdhi8lwdgPVfnTwB53p2kUCEV9fMSYFxAAZb+wg8MEwQ/MG6FCeevDzCo1QYL4NnJ/EF80NojmpOtULKAR8g4i/1tmblfBvpknlOa1ptvK42vfTxeVsyX60KiXRkNPELUyTqEuf/WYYLOush3qSxrxrEzt4LRJKomf1v/q9rbnGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199024)(1800799009)(186009)(26005)(31686004)(6486002)(6666004)(38100700002)(53546011)(6506007)(316002)(66946007)(5660300002)(31696002)(86362001)(36756003)(44832011)(478600001)(8676002)(4326008)(8936002)(83380400001)(41300700001)(15650500001)(66476007)(66556008)(2906002)(6512007)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTZmU083dnBjWUZnVTVyNG5MQmoyU3BJclNIS1hoTUVrM2V1UW1DNVZnSnZE?=
 =?utf-8?B?SnlsTXNDODVvSUd3WE1kL2dkYzEyOUpmVkdYRXVsaklkL1QxVlhUM2wraXBT?=
 =?utf-8?B?eUlETVBBcjg2aG91T25vU0RNNkhuNVVLcDVvWlJGMnoxVTlSeW5hSjRvMHh2?=
 =?utf-8?B?VjVXb2liT21CV2JueVJZLy9zd3FSM3ZWeXluanY1b09aK2N4L1lyaDJjRGNa?=
 =?utf-8?B?bnFsMnZMaXgzaHF1T0t5dW52aU9vVEhxTzhRS0VFenJFWEg2SS9WQmN0cXIy?=
 =?utf-8?B?VER5WkxKTGV0N1lYTXZKcGp5Yk5WR3plUEJmQTA2NWhsdkhUQ1FZNmkyU05v?=
 =?utf-8?B?MUJneVZmT056UWV0bUsyYjNCNEFNaVVrWmV3eCtjNTFKeVNabjBoSGc1dnAx?=
 =?utf-8?B?MzIvejNmb1BEVDkwTTVaeW96VkJkUzd0T3EveWdVQTYrTFBaNnExeW12YlZM?=
 =?utf-8?B?SUxKZjh4dmVvNlJHZTF6c0ZqR3NsUTdVWXliMHFuVUJualg2YUxQbHdYdWlR?=
 =?utf-8?B?MFZJV3ptY0M5UW44OUZFUVVwZmJ2bkNHSjl3ZGRoYTZVcjEycWw3VUhNWkJK?=
 =?utf-8?B?SDdFbU5OWTNjVkcrOVNvOEdoMG5na21Ed3k4ekxHMHY5UzBOeWhwdFBvR08w?=
 =?utf-8?B?bWc2UmtpSTU1WU1uaHFZY3RxR2kyK3B2YnRKYnVLQXZDUE83bEJERWlPQStF?=
 =?utf-8?B?Q3gyUDZBUHE0SkNPZFk2YVpOVGxGSzZUTnlWd2w4RjFhYjdVWE5zTTZOVlRp?=
 =?utf-8?B?TnBRYlpMQmlOU3kwcnhMa3Rhc0pPNWpmc3J1dWhaL1VHZTVhNzdCdUlQQ0c0?=
 =?utf-8?B?empIczJ6MDdLN1dka1dlVXF6K3dIOEF4SkJLcjdySFZjMy9mSndORlExMVZV?=
 =?utf-8?B?WE1raGg3dldqTE1lRFFGY3RCMWhRaXJ5eXE2Qkl1aWJVd0RVQVdOYW0zVUNN?=
 =?utf-8?B?emljaTYwU3c5YlFvVWUwaGhtdUlLbEVjSURJWGRORWp1SzROSmFMNlFzeFE3?=
 =?utf-8?B?OGlhY0pIeWlHK3ZpbUlIamZZQlhjdHZ2MXhHaTl2N1lrNng0VTFzQmlDNWxx?=
 =?utf-8?B?SFJKN2JMTXpRdUVGOGJNb3V4ZVNnMlNsM24ydUxtczI2dG1QNHc5d1o5MXV6?=
 =?utf-8?B?YWFURXBOdGJjeUJpdGtNa0VRMm9YZjBqb2tvK1B5b2k2NkNnMXhWM0syY0F1?=
 =?utf-8?B?K2Q0b29hQ0ErVS8wWnZ1NUs2SUNHVTdLSmlXOWJnZ0lpV1lGdjZVMnRCQXN0?=
 =?utf-8?B?THdKZDdQaldQb0t0Rk5QRG1NMENHUUVEU3EwSU9LdlBreTBxNFM5VmhiNTh1?=
 =?utf-8?B?eEc5YU9IbjBCSk53TCtjb2I4b2lTU3BBcFg4bDNUZzdxck5rb2dNeWV5NkQ3?=
 =?utf-8?B?NmJxZ0dNd2F2NmV4NXJaby9udzBoT3VmTThSbVNPMjhLY0RqcUtLR2ZEajhs?=
 =?utf-8?B?cmRiZndvZThUYmdCeEgxQ1ZhRHFNMktOS0pPcVVpOWpyRzljWmhiQytlNkl3?=
 =?utf-8?B?Y1U1Y2puQWNSUFpiVklkN3pvY05tK1pQMXFXa1NNNUEwSnFqRU9qcGljRERX?=
 =?utf-8?B?ZFovYW9VTmlzdFpZeGs4RTZFdDNwU0lEMDc1VmNWZTZUYUZEcnBhSnVxQXlk?=
 =?utf-8?B?Vmo0SUFMb2RvcVZBUXlBTlV3bTlPVDdQeUxXcGhwRG4za0R5RFBKMUF1NFUy?=
 =?utf-8?B?bFkraGt2c3BMWUJZN2dLVkcyYVVzWFhWbnplM2h0ZFFibjJuc0g5TWFzbjNC?=
 =?utf-8?B?SUJrMXFNU1hXWUtmbTdndk44QVVyRnlJSFdmb2VCVmliaDcrVGJKME5GMmVx?=
 =?utf-8?B?N0Jjbmx2b0lRNDJOMkNyU1dXaUZEQW1mR3pkdVgzMGMwdGsxMEhETncwbnMx?=
 =?utf-8?B?SmJubmVodEs5UloycXZkQk5RdEtFdTJtVzdPdFpkV3NTV0ZGRU02VmEwaFNs?=
 =?utf-8?B?OHdlaWhsa0Irc2dPQUxZSGErVVY2TUVCd2krSGdWUmpKZko1aUlFcElISU1a?=
 =?utf-8?B?QVByU1RqRExSeTg0RldOb3hMZFJmcFJ4ZVdhcm40R21wSFFWVE9YUWQ3WE1Q?=
 =?utf-8?B?ck1TQWNaSEhySElsbEpDSDhBK0RPQk1xaFkzeWdZOWlFdk13OWlDQmc2WktF?=
 =?utf-8?Q?BBnDJUf63WP/EVjuPuwhEIh/A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e77e5b-8968-4afb-bf1a-08db9d9cdf74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 14:35:29.3828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZckzaaKuNahSnSb/WDpwg67fSX7YleIXdSR4rlx4+497B5cFZL9X9tgXx7Z+ICHQP4e338Cp20+mI70gd3rMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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
Cc: Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Bokun,

On 8/15/23 10:29, Bokun Zhang wrote:
> - There is a DPM issue where if DC is not present,
>    FCLK will stay at low level.
>    We need to send a SMU message to configure the DPM
> 
> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                  | 6 ++++++
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h              | 5 +++++
>   .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h   | 5 ++++-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h               | 3 ++-
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c       | 7 +++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_internal.h                | 1 +
>   6 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f005a90c35af..274c6ba534b3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1410,6 +1410,12 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>   		return ret;
>   	}
>   
> +	if (!amdgpu_device_has_dc_support(adev)) {
> +		ret = smu_notify_no_dc(smu);
> +		if (ret)
> +			dev_warn(adev->dev, "Failed to notify no dal support, driver may not reach best performance\n");

Can you replace all instances of dal with DC (i.e. s/dal/DC and s/DAL/DC)?

> +	}
> +
>   	/*
>   	 * Set min deep sleep dce fclk with bootup value from vbios via
>   	 * SetMinDeepSleepDcefclk MSG.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 6e2069dcb6b9..c8fdc3d0aa25 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1356,6 +1356,11 @@ struct pptable_funcs {
>   	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
>   	 */
>   	int (*init_pptable_microcode)(struct smu_context *smu);
> +
> +	/**
> +	 * @notify_no_dal: Notify SMU that there is no display and SMU should control DPM
> +	 */
> +	int (*notify_no_dc)(struct smu_context *smu);
>   };
>   
>   typedef enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> index 10cff75b44d5..e2ee855c7748 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> @@ -138,7 +138,10 @@
>   #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
>   #define PPSMC_MSG_SetPriorityDeltaGain           0x4B
>   #define PPSMC_MSG_AllowIHHostInterrupt           0x4C
> -#define PPSMC_Message_Count                      0x4D
> +
> +#define PPSMC_MSG_DALNotPresent                  0x4E
> +
> +#define PPSMC_Message_Count                      0x4F
>   
>   //Debug Dump Message
>   #define DEBUGSMC_MSG_TestMessage                    0x1
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 297b70b9388f..f71fc99447f2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -245,7 +245,8 @@
>   	__SMU_DUMMY_MAP(AllowGpo),	\
>   	__SMU_DUMMY_MAP(Mode2Reset),	\
>   	__SMU_DUMMY_MAP(RequestI2cTransaction), \
> -	__SMU_DUMMY_MAP(GetMetricsTable),
> +	__SMU_DUMMY_MAP(GetMetricsTable), \
> +	__SMU_DUMMY_MAP(DALNotPresent),
>   
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 48b03524a52d..41412cf891a7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -160,6 +160,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
>   	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
>   	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
>   	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
> +	MSG_MAP(DALNotPresent,		PPSMC_MSG_DALNotPresent,       0),
>   };
>   
>   static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
> @@ -2601,6 +2602,11 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static int smu_v13_0_0_notify_no_dc(struct smu_context *smu)
> +{
> +	return smu_cmn_send_smc_msg(smu, SMU_MSG_DALNotPresent, NULL);
> +}
> +
>   static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>   	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
>   	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
> @@ -2680,6 +2686,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>   	.send_hbm_bad_channel_flag = smu_v13_0_0_send_bad_mem_channel_flag,
>   	.gpo_control = smu_v13_0_gpo_control,
>   	.get_ecc_info = smu_v13_0_0_get_ecc_info,
> +	.notify_no_dc = smu_v13_0_0_notify_no_dc,
>   };
>   
>   void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> index bcc42abfc768..9b9a13fdcef8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -97,6 +97,7 @@
>   #define smu_get_default_config_table_settings(smu, config_table)	smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_table)
>   #define smu_set_config_table(smu, config_table)				smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
>   #define smu_init_pptable_microcode(smu)					smu_ppt_funcs(init_pptable_microcode, 0, smu)
> +#define smu_notify_no_dc(smu)						smu_ppt_funcs(notify_no_dc, 0, smu)
>   
>   #endif
>   #endif
-- 
Hamza


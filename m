Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A294C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 07:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0974510E4F3;
	Thu, 27 Jul 2023 07:33:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E88AC10E4F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 07:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7vrtiXZLuozASON+zmLCiH2HkRpxbppTjNRDgcszb8sdj7F4MGYPMGocekqgK+DGOteK0aa4F2VOSX86LhYnvt5OQ1aiYIcn8hNl1n9cN8RRHv7eqe9JGHPKrM/1zP0C8xHQFcPigccdHmW8E2hrage9O/SPQUf6HtHrZUHYMJSPX2CBPDDLjl7Vxp7yygJT9ZB8UHujjA2bMq6ULlw2edhSACgJcAumKtatp6i70bCvsVW7TyrIVRPnWalWd1qmmmPAkTLBHTyX+27+X+glKon4n6osNSbJVDPr1FmKHm39hdaFYOXwNxztA89IPcYTz6tk5f5FGr5w7ymf6LKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tfkdMWnjShioD3Agf1AmWslZvzXWKu7Vl+wHRcHn5o=;
 b=WgfhhUIkN7HXbWLVG5Bj4bw8vIgCjrrQuNpeykaKG6NhE2EyW5DlkmVnuHUS/H4i/wmxnUoCZUj95z6frvtIX3GsjPC2T1kjPleTzI8r9OH+V9VTCBdefu1BSbjINc8N8oWliGyrlS2B2zdfIb6Dhsj8S3mWXVGDX5NqDiCwsH8McJM4D9gT5LIfGumsAI+o7KuIFz6RoGFpSTD3a3TtAKCexTHRSbduICGdo+r6oiq6EUo15wZzpTU1QVJC/S/a9KkHjfiJgvZb3eyAkpvUyNhjIY5C4NVHcBBErxzBtp4vQP9esB1JNUpExulsWmInbu6r660kMl6Ca0Yb0528QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tfkdMWnjShioD3Agf1AmWslZvzXWKu7Vl+wHRcHn5o=;
 b=dwb6wpi7JOi3+neq6J78kAQ0EWWROXDP+6rTq778qIVrMNMIe8dC6PIkLgPtzF9WAHPhopnY/L1axg7K7vw8ogDYwTBmLx2OO3JRjPFW/q+MSccv+xcnIIbtUEqsQuK6/C7DIvK0ObM+wBafnAmnn7N4xC3QQ3VUb1f6cIunIJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:33:09 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:33:09 +0000
Message-ID: <98b569a4-0547-bb09-cecb-ef715b426b4d@amd.com>
Date: Thu, 27 Jul 2023 09:33:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/amdgpu: Move externs to amdgpu.h file from
 amdgpu_drv.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230725044143.2246047-1-srinivasan.shanmugam@amd.com>
 <20230725045159.2246417-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230725045159.2246417-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 264c39af-3af7-46bc-843c-08db8e73b9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqWY7CG0VpGb6JqqBMputW24FKbryL5Xrq06GTfBTxwIDdIK5DgTO8amWss/EDZzLhd378OESaEWBgoayBp0PIg+UhcW27yQJdv+e+LpThDvf2NtRcvvNO0iaki4ByPBaBkhjBd4xldug8wbkVwuZQ2o2YMMm+/ZGuIiN6SH/rztA6NGz5005Yyaz2Cd9YfXf/68BX0BPuAi9pmY88CPePo0bRKsxj+UDkUmRfvf6NK0evv7JQqhwv7CsCNHtDkdC8DfOqUE3lGPSROrUAQocrmRo9GoObYIqHag6wfR0DZ1aowCbGvvhm+YrPyDPeN4EBMHu/UoTqvbWqVg6lB/gwJUW9EcwF0tCrHVe1AZmmAnKrSVbunRsqsFE7xoj3gSkXfzdZtDs+uIqYLDJE3RMnvYC/hy4UgmUsQ7VJrkIlGbbQBNF11xEFALLfLzdZ3dRqRBQAtYoZngjf52msqIOoWRm5q43xU1ny5mOkUZxy4cgU+gFK8GzFAEbc7Ab96gDdGssC8aoQhGoGe/HoQIobP7zqyV7QslMSGuA8BB7R6wZQ465QqqCIKVlHib1x8L3a1QqG/qISlOzPXseeT46lTCj2qLNHLQ3dcU/h3YOChCsHy417zcb+xFppJK3oPKAMQGylqwa+/XSx4iSHuPuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(86362001)(31696002)(36756003)(31686004)(2906002)(478600001)(110136005)(38100700002)(6506007)(66574015)(186003)(2616005)(5660300002)(6666004)(8676002)(6512007)(83380400001)(6486002)(41300700001)(66476007)(316002)(6636002)(8936002)(4326008)(66946007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjRuSkJHZlpWODRTQk9MZXoxMU5WOE9VM3Nyb2FVcXl3TjkrN3pUWGgyM3VJ?=
 =?utf-8?B?d2VRcVdJN0ZUZ3dKa1dzMVpBOHpvM21xa2U2aWhxMnVmZlp6TmY4ak9HRjYv?=
 =?utf-8?B?NVY1TkEzT2h5Nnd6bVc0U2E5N21aZFo2OVpsV0ZmaWEvajkyMkYwd2RscFZy?=
 =?utf-8?B?ZkQwUGhaRE5KREl4cGI3clk0UVFFZGFhdkYrYzBlWG1qamVBb3BIVFZ2ZGRV?=
 =?utf-8?B?U1hKVWNPSnJSbTFkZHhqQUthNUlwUVprRjAyQmpNdE9Zb2VPd1Q5VlNxV2Jw?=
 =?utf-8?B?aWVuY1NPNXJsb1VUUFMzcnI4MyttNHNmMTZTbkZMQ25VekE1WU5XT2hxNXZ3?=
 =?utf-8?B?dTdBY25kVEpySjR2TEdWM2l2aUJKanhnbzFpZ0UrWFlVK24vSXNVcnE5L0E3?=
 =?utf-8?B?YmlUYlk2Y1ZsZTk3TWhlZGRRUTNEaDVIREFlV3p4YTBaNXRhZHdlRmFLN3hC?=
 =?utf-8?B?SXpzK2tBT1pCYnZjcXZIWXUveUY1cWZNR2xmWFl6d0FMWHFyQUFjNGN5ZFR5?=
 =?utf-8?B?amduaW8ybHJXVEFnZXROaTJLMWlxc0I0S2EvRXk1bUx2dmdhZVNITm80RG0w?=
 =?utf-8?B?S1dVSTZ5QUQyYjJhcC9NQ3NlVTlrR1d3bVVPSWdZLzVyREw2enNBQWkyNWtD?=
 =?utf-8?B?UXIzM0pncTYwa2lGc1RBdjNpZk80RHpOR3AxYXZHN0pMVlhxNWR6UzN3dXlv?=
 =?utf-8?B?NmphM3Nyd3VURXhLNXB5aGhPVTJGaHFSd0N6bmdvQ0NvODFJTUdkdDRXN2Ix?=
 =?utf-8?B?Tmk2b3ZNc0xLamJCenRoSTFLYWpnckI1WlI5M3I4YkRZZ0lwVFZueXR2dUUr?=
 =?utf-8?B?QkJLVmxNR21NRXBqdVVHREhBcndOZWx0c1FWN21FQXMyN1ZYSXlUaU1kV3lF?=
 =?utf-8?B?VENEVjNmZVNiaytwT0Q1WjZqL2dyaTBFVUhBam1NS294NkpvWU94UC9BUTZn?=
 =?utf-8?B?SDNsbTZGelJYdldrdE1PTEwrY1V3NUVuMzZCR0hKdnRvVnRSQkQ1MnNrRk0x?=
 =?utf-8?B?bHpiZDJ4cTVObTIwVGNsdUVGMWdIN0V4R3lEeCtrOVBCRzl4QUVyR1dUbWZl?=
 =?utf-8?B?c1huSHU0L3lZZkxDbEh3di9yN0Z1RGZrQVRsTk9jd0RWY3A2NXhxMGFZVkpB?=
 =?utf-8?B?Rm93R3lZVnBLUk53RFJZU0hIcGw2Z0cxRGlIdVRCeGZZZk4xWkxBNHdKcXha?=
 =?utf-8?B?TForcjN4M2xIbytDYWpwckkwVTlZUWdyTjhSNGo3VFdXQUZPL1V4TVc5cGZk?=
 =?utf-8?B?a0p0S1Y1Y002Vk02MXhRQTlBMVh1TmFxM1ZiNFFjdEN6eTN5aWlVWEphdkow?=
 =?utf-8?B?VTRVU2hrL0dlbkV5UUxydTQvRUd3SHl0aStHWDlGb3FzZ1pnTldPdmhwNG42?=
 =?utf-8?B?alRTdTc0WVhZM3VVenpnaVVBOWRuK3IrOGRNczVFRkhreXU1SDNRSkdrQWVV?=
 =?utf-8?B?ekprTUVqdTk2aEcxcUdmb2JvQUN4VmNKUkpkZzdRaUZNbHRmYThlNmlQUVE2?=
 =?utf-8?B?SW5VTmhJOXpQN2NNbEFOOVR0ODdhZ0djM2F3TExGcEgxT05aQkxHRUtoRGJt?=
 =?utf-8?B?MXdLb3VKSW5nS1VidS9UZnl1c2xFSjAxKzY3WmFFSnBYcXhWV3QyT0U3cDgy?=
 =?utf-8?B?S3VZemhFZXUyZ2hDQmk5aXh5OWU1cGhIQnZEY2o1b1JNNnBmK3JSYlFXSHVV?=
 =?utf-8?B?M3kyaGtrQXVCdGJmLzJqNlVyODJqVFRnR2pqYmx1SVFMWlZQMG5KL0V0RlJ4?=
 =?utf-8?B?aTJxcllpV3REaDZ3OEJXQlVuSXJzazhrY3VyMm40Rlh6RHlVTytsVVVSbG90?=
 =?utf-8?B?dGFuWUh3K21MWXVldEkvS0FRSGx5bTh3eEk1TVBRTzRzMk1zQml4YnJFWTBY?=
 =?utf-8?B?UDlQVHlDUXZkSVh0TzBOMWNQNWRWeHo5TnhNUERGY1NDM3VrREVvdjhZWDBx?=
 =?utf-8?B?b2U2NlJLNGg0Mk52LzZ6UFh1bS9WTnpoMUFFamxkdHJHSmZqbmhyZ010UXc1?=
 =?utf-8?B?MjlrQm12Qm54ZGZYRjJoM1RNNjdpSDhVdEtVanRPV2dIWlY0RmZ6S01VVGtm?=
 =?utf-8?B?bXRzYm1MYWhSVDVBVWwweGZMazFLUGpWd3phR2VUa1IwbDRNTm5IRTRaQ1Nm?=
 =?utf-8?B?c3BEVWoyWDYwd0hnZVlyNHhhd0luc0FyaDdsVjhEMTNIZnArM1Rxa2szcFpo?=
 =?utf-8?Q?4MZ//MGgxubgNJAisWrJpKFWAp1c+c5TGf9osVgqqYOq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264c39af-3af7-46bc-843c-08db8e73b9e0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:33:09.5556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ag/12MiDUD5VdgyQe35Vd+OLqjODtk1Hod2Ebo63yVoRzHI/dJeG0mWlkZcLN+L9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178
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

Am 25.07.23 um 06:51 schrieb Srinivasan Shanmugam:
> Fixes the following:
>
> WARNING: externs should be avoided in .c files
> +extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>
> WARNING: externs should be avoided in .c files
> +extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
>
> WARNING: externs should be avoided in .c files
> +extern const struct attribute_group amdgpu_flash_attr_group;
>
> And other style fixes:
>
> ERROR: do not initialise globals to 0
> WARNING: Block comments should align the * on each line
> WARNING: void function return statements are not generally useful
> WARNING: braces {} are not necessary for single statement blocks

In general good idea, but we want to slowly decompose amdgpu.h and not 
add new stuff.

Please move the vram and gtt defines into amdgpu_ttm.h and take a look 
where the flash extern can be moved instead.

Thanks,
Christian.

>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>
> v2:
>   - Updated commit message - Added "ERROR: do not initialise globals to
>     0"
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 28 +++++++++----------------
>   2 files changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a046160b6a0e..93d0f4c7b560 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1524,4 +1524,8 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
>   
>   int amdgpu_in_reset(struct amdgpu_device *adev);
>   
> +extern const struct attribute_group amdgpu_vram_mgr_attr_group;
> +extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
> +extern const struct attribute_group amdgpu_flash_attr_group;
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index c315fe390e71..84446bbc3509 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -313,9 +313,7 @@ module_param_named(msi, amdgpu_msi, int, 0444);
>    * jobs is 10000. The timeout for compute is 60000.
>    */
>   MODULE_PARM_DESC(lockup_timeout, "GPU lockup timeout in ms (default: for bare metal 10000 for non-compute jobs and 60000 for compute jobs; "
> -		"for passthrough or sriov, 10000 for all jobs."
> -		" 0: keep default value. negative: infinity timeout), "
> -		"format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
> +		"for passthrough or sriov, 10000 for all jobs. 0: keep default value. negative: infinity timeout), format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
>   		"for passthrough or sriov [all jobs] or [GFX,Compute,SDMA,Video].");
>   module_param_string(lockup_timeout, amdgpu_lockup_timeout, sizeof(amdgpu_lockup_timeout), 0444);
>   
> @@ -585,7 +583,7 @@ module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
>   #ifdef CONFIG_DRM_AMDGPU_SI
>   
>   #if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE)
> -int amdgpu_si_support = 0;
> +int amdgpu_si_support;
>   MODULE_PARM_DESC(si_support, "SI support (1 = enabled, 0 = disabled (default))");
>   #else
>   int amdgpu_si_support = 1;
> @@ -604,7 +602,7 @@ module_param_named(si_support, amdgpu_si_support, int, 0444);
>   #ifdef CONFIG_DRM_AMDGPU_CIK
>   
>   #if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE)
> -int amdgpu_cik_support = 0;
> +int amdgpu_cik_support;
>   MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled, 0 = disabled (default))");
>   #else
>   int amdgpu_cik_support = 1;
> @@ -620,8 +618,7 @@ module_param_named(cik_support, amdgpu_cik_support, int, 0444);
>    * E.g. 0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte. The default is 0 (disabled).
>    */
>   MODULE_PARM_DESC(smu_memory_pool_size,
> -	"reserve gtt for smu debug usage, 0 = disable,"
> -		"0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte");
> +	"reserve gtt for smu debug usage, 0 = disable,0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte");
>   module_param_named(smu_memory_pool_size, amdgpu_smu_memory_pool_size, uint, 0444);
>   
>   /**
> @@ -791,9 +788,9 @@ module_param(hws_gws_support, bool, 0444);
>   MODULE_PARM_DESC(hws_gws_support, "Assume MEC2 FW supports GWS barriers (false = rely on FW version check (Default), true = force supported)");
>   
>   /**
> -  * DOC: queue_preemption_timeout_ms (int)
> -  * queue preemption timeout in ms (1 = Minimum, 9000 = default)
> -  */
> + * DOC: queue_preemption_timeout_ms (int)
> + * queue preemption timeout in ms (1 = Minimum, 9000 = default)
> + */
>   int queue_preemption_timeout_ms = 9000;
>   module_param(queue_preemption_timeout_ms, int, 0644);
>   MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1 = Minimum, 9000 = default)");
> @@ -2417,7 +2414,6 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
>   			amdgpu_amdkfd_device_init(adev);
>   		amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   	}
> -	return;
>   }
>   
>   static int amdgpu_pmops_prepare(struct device *dev)
> @@ -2614,6 +2610,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   	/* wait for all rings to drain before suspending */
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> +
>   		if (ring && ring->sched.ready) {
>   			ret = amdgpu_fence_wait_empty(ring);
>   			if (ret)
> @@ -2738,6 +2735,7 @@ long amdgpu_drm_ioctl(struct file *filp,
>   	struct drm_file *file_priv = filp->private_data;
>   	struct drm_device *dev;
>   	long ret;
> +
>   	dev = file_priv->minor->dev;
>   	ret = pm_runtime_get_sync(dev->dev);
>   	if (ret < 0)
> @@ -2802,9 +2800,8 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
>   	if (!filp)
>   		return -EINVAL;
>   
> -	if (filp->f_op != &amdgpu_driver_kms_fops) {
> +	if (filp->f_op != &amdgpu_driver_kms_fops)
>   		return -EINVAL;
> -	}
>   
>   	file = filp->private_data;
>   	*fpriv = file->driver_priv;
> @@ -2894,10 +2891,6 @@ static struct pci_error_handlers amdgpu_pci_err_handler = {
>   	.resume		= amdgpu_pci_resume,
>   };
>   
> -extern const struct attribute_group amdgpu_vram_mgr_attr_group;
> -extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
> -extern const struct attribute_group amdgpu_flash_attr_group;
> -
>   static const struct attribute_group *amdgpu_sysfs_groups[] = {
>   	&amdgpu_vram_mgr_attr_group,
>   	&amdgpu_gtt_mgr_attr_group,
> @@ -2905,7 +2898,6 @@ static const struct attribute_group *amdgpu_sysfs_groups[] = {
>   	NULL,
>   };
>   
> -
>   static struct pci_driver amdgpu_kms_pci_driver = {
>   	.name = DRIVER_NAME,
>   	.id_table = pciidlist,


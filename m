Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E689CCD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 11:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7890510F283;
	Thu, 18 Jun 2026 11:21:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mEpI4rNl";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A392110F283
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 11:21:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUJ4t+RGihxCumCIMTP5G/vCnS3sRw6XPRuD0/XlK65LASeCBVebf2PUcAN2O/AVhD5BrHgia8zyGnvOECrW4m/kE7vLDL8aGcedxXbmVAt8x8enqnKMNmzvVwsu90ek3fwM0I9Pq9Gg6/TIztelk1BqVl6ZJ1Ss6D5Nh82tzf++8dGNxYb1NWlt9GZ6TLQk/pC7ZQpUIL5HF+DIH8r+VspoIpTPVUCGBWCbyychuqLdi6iStIW+MA02pn7YDYtwLEDAOsLhYrZBE1s/rxPChICBQpYUtZHKe0V08lWbuoSJWwtgyhz3W+PUft3742SC9nHrgqTUf1vKpBJyJYMWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB9t8fMhKj6JvNtiK2+wLZo3ySlbfS4DdT5RPYGCg7U=;
 b=L/61Egu1XOiEJU78ygFhcK6hKOhnX84AoQ7DergTjtYNdMSHVpp5d+oX6APGlZL6QdOfSJ7D9yBACaETjoWeGhAbZ3FhbVWz8E/OrGx3/FW4iJUAWJs6QFBXhd4dCF3m9hr5gTdmfPlRdkIM6tjfouBwe5y/9Pu24XeZW/V5rGNdNpEwOwG/PKpPVAzf8Lu2jlPa8Ll+3lhVUJUj4x6xLu/e88SGGDQEzOIkqPCyag1V4u9cves849iKRTccWex8CL9Umj+B+Euvpb0F+l7LXrNxPRFNt/G8UUjklGkoJlfr5+ByT5tcI6PKRBxQssZ3UUD+cCxT8ttGkyrKd1+IKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB9t8fMhKj6JvNtiK2+wLZo3ySlbfS4DdT5RPYGCg7U=;
 b=mEpI4rNlbWbjweyUUexx+eqrkA5K6KIGzl5SsN4wiFNWkcE01k6e/IR+Ggt/KswfMEfi29YgfeaYVvvC+bsc4bbYsl0Tjf8i2btZq7igq3LQ6rtHwXPkrq2LZe/G5AER6bzQkOjTJvWnwHfBs8KxwUxpccbkrIj3P3acpeRkD48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 11:21:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 11:21:47 +0000
Message-ID: <bc9a4cd4-749a-4696-8348-a7bc206752b9@amd.com>
Date: Thu, 18 Jun 2026 13:21:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] drm/amdgpu: Clarify name of soft recovery to avoid
 confusion
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOh?=
 =?UTF-8?Q?k?= <maraeo@gmail.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Lazar Lijo <lijo.lazar@amd.com>,
 Martin Roukala <martin.roukala@mupuf.org>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
 <20260617191428.1784083-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617191428.1784083-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea3f68f-1095-4a13-b614-08decd2bc930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|11063799006|56012099006|18002099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: roGDaKh9HTQQmL31RoHillv2TtgAj3QdfQFRRKayI92NN3r4/csCgAQGpZ4IMtcbSHBH+pcnIQwbUhCEUjCLvzpXJf0ActoZytaa9DRyauLmtTVuYS2XHRNEFxow4OGOdNjkT1yhOYkP9Sh+tAAk+2sZ1mXFFW0kG4u395QA314gt5QeAQnroWymD+wib+UBKihY5cC4apygfJHQTFtgZkyT1o3+bXKeddNHPuidVHzU4LFBvssGTEmX6uhv5t2aGKnX+efgr1NJUW5KRb5+94e1F+MvLvIo3Q910r/j+C5fP0i7AtijqayVgZ7oGRE3DrVn1zxfZymbrRTq0cIVpIjSY5slz2aZmiVwLk7QgTCAsEtMpT8cYdf7LRjncR8TCr7CusTzcpjE5vUnFhjG1V9BN7uNALX8kXHlzBBoFTpmBWv7tJySu8Ou4dng9aT/CGTdMrH5916r6DOazQgyEMHr6YoFZYEj1vnZ4KM+bSYbPpah0Tgq0uVqzUDonRGBeY1UYDA8UWkMJSZ9nJi203wv2DX9S+5Bz5aH2CqzdIdO/xlOU6u+gYzKKpsrfkRGqVUPl+DC0lAtLg+gR/pJj1/bL2zRN0O+GtpcUwuIE0SnjHOBYptd/DUM+ZeHYo4HIuXkzJycAkThwZ3CKKcNYP9CsSB7SG5FHJzPu7HC8O6jckOYsKXMzi/r6Isodsfm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(11063799006)(56012099006)(18002099003)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk1pOUVqTHFUc0cwRGZoUzIyRlM3MkhxaWc0TEVPcU9KK2hNbDdKaWVOS0dz?=
 =?utf-8?B?RXprZEVjNDBNNW16UlI1VWJLUVZQSDFaLzJML0I1YnJxRm9DT2RObytjUHZI?=
 =?utf-8?B?N3UrU3dDa2FaT3lnQzluM2RxRGZBMWc3aS84SVlrUDE0VDcxdk5GMmkraTRp?=
 =?utf-8?B?S1k2aVRiZEhZbFdLaysrWDZsdkgwZ1NVc0JRanZKUitkSWRkMFNySW1GUlEv?=
 =?utf-8?B?UEltcnVkKy92d3NybVU1eGFxNXJObGNIaHJoS0k2djVEbWlKbjNQdzJnYVhJ?=
 =?utf-8?B?UzZpYXByQUErZC9RNjBvZE45SWRNT1N1K2RCTElvUFRLTDVHWUlEeHc0V0ha?=
 =?utf-8?B?T1dBYUhCZm53ZXM0eDRPU2FLNWJnZ3hKTmR3N2ZLUURENzNkMnhrVXluY1NI?=
 =?utf-8?B?Qk9VamM1TmtnQ0Q3Y0M4WVJtWFlJKzUwaUwzRHEvN1d1ekN1NHNBbjJKYkZN?=
 =?utf-8?B?UUpWSnBKdHVmTlRBODZKUm5GdWwyUWZCWDZlek5HelFvYy94eHkwMXR4WVRy?=
 =?utf-8?B?TFRGdkl6Qk54azVVZHBEM1pHb1h1eTlYOStMMDdqTU5VUVlqMk9TL1lzNDZH?=
 =?utf-8?B?aXhPV1l0VW1qcy9YeVhlSGZUdUtmSUYyYTZZMkpYWXluUVdBM0VtVC9zZ1Jq?=
 =?utf-8?B?eFp1WXdpejBiNUUyVHBoaGgyRExjbTV2MlN3L1pIY2doR3lPNWc3blIzRFpO?=
 =?utf-8?B?cXd1aFZXM2RXZkRPOW5ucnN4bjdaeDdrQUFFbEVQVVN6WEpIRENENW90NldL?=
 =?utf-8?B?RDVKbjFaN2M5U3MxZUpjZXc3OTkrcEgxK2VOY1dRVmQ1cW1SSHM2em13SFJR?=
 =?utf-8?B?cGwzOERPazNiTUZuL1c5NlVxU1dnY1poVUJQSXlUcXFZV0lDeTkzbEJLcWJh?=
 =?utf-8?B?NmgrQ2VoYTJGWlZzeVlyMWd1aSszRTlYRXBxcGNYaXJzZTBKWFhpYm5UUHNS?=
 =?utf-8?B?RklFNS9ZSnhtYnBQL0dPWmtGV2MrbkdEbFo1d25oczA5S3Vtc3MrL1lsMWdw?=
 =?utf-8?B?K3JyY1RSaEg4elAzUmw3cGRPT0c3V0haZVUxU09obmFwY1c0cG9KYmhZQnRN?=
 =?utf-8?B?QTBaOC9YQnQrT1lENFR3c2owNGl3MTZTdVJrdHB0NWw4dGpNL3M2bzUydktP?=
 =?utf-8?B?dWRYUUxxM1F5dnNvUWV0d3U0bUtRZjBwREpDeWNETmJXWVZwK3UxVmk1K3hp?=
 =?utf-8?B?SzFKT2RMUnBZMU5sSTJCbjllcjJWMUpKU2ZCZDlhMWdEYjZNTXMxd0JnYllm?=
 =?utf-8?B?ZmEwS1lQd0hJQjdhdzhoRERBbGRXZlZhb0dWRnVheDNkUG45Q1pHM2Fpd0R3?=
 =?utf-8?B?TC9NUGliUnBkZlBtUFFTZFVzSlhkd1pCQ3dsU2sydUM1Q29yNU9aQTJQeEhP?=
 =?utf-8?B?UU56RXdrYzZxZW9LaXVBWVh1QlI4OGxkMjRFeW5lWHBRVXAyT01NRThMdXd1?=
 =?utf-8?B?TVpWc2RxRVhUVWJKL2dKanN6V3FRSmQ2VU1OR1grUkR0MEJJOFVXWVJBdkFR?=
 =?utf-8?B?c2h6T2pTc3RwWG5ScE5FQmtXaHFtRzkxdk1uUEoxbERIYUJCSC9GbGNXQit6?=
 =?utf-8?B?aXdGeHhMVUhNdVZraS9kMFN3M1hnS1Z6aksrZk8xZ04rdmRyUjZjNEFFem9U?=
 =?utf-8?B?UVFBaFlwU3ROOTVSK3pWVjdSbkwxWXZiWHlVa1JueGtiQ1pTb2F6emo1eGdY?=
 =?utf-8?B?MTdlVERWdk5rWXZQT3lVTkNTeGpQWEVKZzZWS3E1UkY5SWovUzJPT0Y3SGRI?=
 =?utf-8?B?MGdPQlFkSjlJMUxqclRsV2Jmazd5T0Mydll4NE9wQVJpUGNiS3lvMHk3Uysx?=
 =?utf-8?B?SEtyN3pFRndQSDRPRGFmTW8zdkpTbHdUdDJreHFMRFV2U1A2MElOTnA5Z1I0?=
 =?utf-8?B?bUZNNnJZa0FmblZWbzdadkhrcnpac0lyUTI3TlppSFlxbjlGVi9vSnIzUm15?=
 =?utf-8?B?aENERmhrQ0ROVTJkNk4zSGVLeWVWUnVZSGM1YmtEOTJSd2dGV3dtTEcwSXBx?=
 =?utf-8?B?R2ZqL2VVZ2E4dzFjVElKWm9jSktXMlV1bkFkVnpVcTBZUjlZNzZOWWFaL3FX?=
 =?utf-8?B?QlF0bytzeEN0OEgwOFMvaG5sM2hNY0ROKzZVeEdiMnVOcWFlbDhhOXFYTi9r?=
 =?utf-8?B?blZWVDZ6MnFkeWU4YXh4eW82MGxKL3dYU1JUK2ZiRDF3WUZGZnZlTXBoVFd2?=
 =?utf-8?B?Qk9LN1luektoNW1DYXpEaTJGbE8yeExidEUzMmxaZ0JNY09MaFFuUHBkMEt1?=
 =?utf-8?B?QnBaN2lmcGdudW81WTRjc2haMXpSTTdlTTNrZldkYU9SWHFCYloyOGhRa1JI?=
 =?utf-8?Q?WJ6k7PLK93QJ5mJDvJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea3f68f-1095-4a13-b614-08decd2bc930
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 11:21:47.8138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSBtSk9GNaqEqN4nsz6k3geUMlP9zP97Grb8Kf6SW9lR0znw1lAQ6qIg8G0/tDpm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362
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

On 6/17/26 21:14, Timur Kristóf wrote:
> Soft recovery is not the same as soft reset:
> 
> * Soft recovery attempts to resolve a GPU hang by sending a
>   command to terminate shaders.
> * Soft reset completely re-initializes an entire device IP block,
>   which may affect multiple rings and jobs at the same time.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5d7bfa59424a..cb4fa9c111eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -304,7 +304,7 @@ extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
>  
>  /* reset mask */
>  #define AMDGPU_RESET_TYPE_FULL (1 << 0) /* full adapter reset, mode1/mode2/BACO/etc. */
> -#define AMDGPU_RESET_TYPE_SOFT_RESET (1 << 1) /* IP level soft reset */
> +#define AMDGPU_RESET_TYPE_SOFT_RECOVERY (1 << 1) /* soft recovery, eg. kill shaders */
>  #define AMDGPU_RESET_TYPE_PER_QUEUE (1 << 2) /* per queue */
>  #define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per pipe */
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ccbe6c885cf..71a6b18ccf23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6884,7 +6884,7 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring)
>  
>  	if (unlikely(!ring->adev->debug_disable_soft_recovery) &&
>  	    !amdgpu_sriov_vf(ring->adev) && ring->funcs->soft_recovery)
> -		size |= AMDGPU_RESET_TYPE_SOFT_RESET;
> +		size |= AMDGPU_RESET_TYPE_SOFT_RECOVERY;
>  
>  	return size;
>  }
> @@ -6900,8 +6900,8 @@ ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
>  
>  	}
>  
> -	if (supported_reset & AMDGPU_RESET_TYPE_SOFT_RESET)
> -		size += sysfs_emit_at(buf, size, "soft ");
> +	if (supported_reset & AMDGPU_RESET_TYPE_SOFT_RECOVERY)
> +		size += sysfs_emit_at(buf, size, "soft_recovery ");
>  
>  	if (supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
>  		size += sysfs_emit_at(buf, size, "queue ");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1781c0c3d010..53aa2d438da5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2250,7 +2250,7 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
>  	}
>  
>  	if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY) {
> -		pr_info("debug: soft reset for GPU recovery disabled\n");
> +		pr_info("debug: soft recovery disabled\n");
>  		adev->debug_disable_soft_recovery = true;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 55172c2dcc35..ce3c209a6ba7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -112,7 +112,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		amdgpu_job_core_dump(adev, job);
>  
>  	if (amdgpu_gpu_recovery &&
> -	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_SOFT_RESET) &&
> +	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_SOFT_RECOVERY) &&
>  	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
>  		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
>  			s_job->sched->name);


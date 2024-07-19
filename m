Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA011C3DA5D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 18:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1176910EC93;
	Fri, 19 Jul 2024 18:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dx5fVcdR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DEA10EC93
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 18:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrgjmWkFiMo6FKW8Kd4UH2ZiPRTzypow70G48wP4Z01VMHM6H1uL7eYwPsfdLlNfJDQkPRvHCIq9GEeWsOy1CxWvYf2Rjecpl6t+uZBNcF7YigNP55IEuOG3JU+dPhXIq+b1cGc3T38PKfSiHrQT2QfTU9zoxTSX29BIcFlC6qDJDegVTgqADFZsgzvMeQe2MHK4zpV7TrgiBhJCwhPsVyU6a25jz8qayjRZQM0rk8xrEfIU3mVupdFJQcequxauKbnOXxWeQFK/N0DJV1ajV7CusIp00n59ojry/0hKoOEUI8wGa0PyXb7+9dWExcGHcrAmpTPNsM/c6/8aPKJfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEvxR7gWURMV/q/EyBNp3Xz0x+ZyRQZ3JuLN3uXS45U=;
 b=AXuG5z48RHE1Rp+lc0O3l30kw/B7Vc3yYv2/CxOULWRWQd7qgSsFXHAjsXPeF6SZB7cL+hfnzIBwaGNkVx8P2PWJOgyyw3jk1cHOjSWpwop37Y3538MmJETbN68VIigtJ4n5RQ0hzATbqvYcAIHfh/Qs2SkB7u7Og7KpV5Qc3RSGQjOFWvIAre0i3ryHmmsLIJskNt6nEGeH0LTV5JVUNnL+fiINs79b60LPadGC5No37614HhSrtdwLMC2v7YUwNJ3wyZTjVPgORNvZ069J+ykLybXJf8L1vkf3agmSe/yXICchYyqHOoWcpThBoB9MqvBetlpV7zSdejsWbLYVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEvxR7gWURMV/q/EyBNp3Xz0x+ZyRQZ3JuLN3uXS45U=;
 b=Dx5fVcdRvzAozOOSVMIGhiSwtivkghA6zp4VMWZmBSrnf1VkcDvWTAR552pPF92oBZwXoIcMVL9cX7VL6bCTdQfio/+1o0PQiHZQTMtJHNAE8rKA/EHrF4Hso9WcVEEiVGd3jQaNOxi16VYg6wCQ52C+BYv7Ww2kogVDAqsevzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 18:33:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 18:33:58 +0000
Message-ID: <c317a6f6-3ee0-479c-a69e-8e6492d314b3@amd.com>
Date: Fri, 19 Jul 2024 14:33:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: allow users to target recommended SDMA engines
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240718230505.1025287-1-Jonathan.Kim@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240718230505.1025287-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aacce9b-0d92-421d-75e4-08dca8215a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THNmQmVsWHVJa1RiNVJZNzYrQ2crWXB4bkNvYmVueWRiTHVnSXZUWHZya3JG?=
 =?utf-8?B?b1lWMGhDREcwbm1EdE10NW9WK3FmZHZjN0daYUNoUWM1dDFwQXVFNEhjaUQ0?=
 =?utf-8?B?WVRjTGZ0dlMyVWRuTzVZbnU1OUNiNXVMVkFwR1NlNTI4aWwxWnBUSmtyYWl3?=
 =?utf-8?B?eTM4R3VXYlMyUG8xdUZTUmdqS2dTZFhJRHpXTmpvaUFBcGFvR2Y4K1RjZUJ4?=
 =?utf-8?B?amxzT1dsYTRDVGxWbEJBOFNLcitwejB0SWhiQUVOQzhxNjcrNUVRcGtUWmZR?=
 =?utf-8?B?U2JOVnQ2MnllQzRhUHlWVE1ERHBRY2NnaFNnT01FR2RHa2ZmZkphMkJVWlpF?=
 =?utf-8?B?S204ckpGNHd1YlZBVTY1OWQrdkFIa0NhNTZvRWljcHlLaDBtZk5wVVNWTmo1?=
 =?utf-8?B?VmltMGk3NERCL1Fzc3FHVUhWNHdoczlUZllxMFk0b3lnMzZvZDBxQ2xoS25q?=
 =?utf-8?B?ajVkbENsVWdSN3hWd3M0Z1R4MUZyREZjT0c0Uks0NFhuelRGYzFGOTNJbHZS?=
 =?utf-8?B?ZHA1clR5MG9Zd2lnYjlwSjVOVmlJTWs4US9sRzlWb3QxeGJzd1VrRjM5d0o1?=
 =?utf-8?B?aytyMTBvKzdrQWh4Snh3QnVFRmNXYXV3bmFhTFBPNmlicU1WVVptUHVFQkY5?=
 =?utf-8?B?UTJ2UTgxWFV4djg4K3B6VlBmcXJ1alRHOEllR2l4Z1J1TmVETkx5U2dsb0ZR?=
 =?utf-8?B?U1Z3VzNRdlRNcnk0YnhIVHhlbWU0eEgvZFNWSkFnWDFOZWc2aFZidlRZQUl5?=
 =?utf-8?B?VkwyRXl2eUZFbUJoU3pwaUVjTytnWUppalVNSEpydmszRWl5T3Y3eFQxaVhI?=
 =?utf-8?B?elZJZVYyTTNsNHJ2ZFlBWm5pRFBaMWthSW9walB5b1VzTmkrT01ZVCt5aEY4?=
 =?utf-8?B?MloyRjFyWjcwakY2bGlHWkZ2bTFvUS80NnQ1eTUzWmxCU1U1QUJ1NE1LZ1Rs?=
 =?utf-8?B?MGJjM0N2NUJoS0RLMUJ2aTBlcWg3SzAxZXJrSWhmRDlwMkdRRS9VS3M2SWJV?=
 =?utf-8?B?QzFlOHpHRy8zUk9WT0dzQ21GRndZQmJBUmh5SHJXcG11elkrQ1VoWkorUUZv?=
 =?utf-8?B?d3FLMVIrRnR2aGY4dzNKVWFkWUprbTBYbHcyWVpJcnZXNnVJNWNIZVVndURr?=
 =?utf-8?B?TURhNndVaEw4VVJPMGNpWTlQLzlILzE2WnEzR1djcXhDZTFzd28xdDNLRmFw?=
 =?utf-8?B?Vzh0MzhxQ0dvb0ZUaUgrWlVXeHFwYisya1I0VWRETkJ1b2grTjZRc1VkMXIy?=
 =?utf-8?B?UExGWVE3aWo4N2RzOFFXQ0NsUm1KVXJzZzdXS2JUMm0yNCsxWmJadEk0YnMr?=
 =?utf-8?B?WUFzTm4rS3ptMkFjUkkvc25uanB4TEg4cVEzQnRTMXEwdFkreGNSa09wYURr?=
 =?utf-8?B?bFhRR3RpQWxJTG5saU9ReisrMC80UHJzNG1HTjJKclpmSzBlaGptS1hRUDd0?=
 =?utf-8?B?aWRhdUZQRXd3RjBFLzg4TGZNbkp6Vm9vWUg1aUxQendkQlN6QStkYVluYzJX?=
 =?utf-8?B?RWlxcklQbW1VaXAyTEdXRUpKTFZFdlVlaVByTHg5MjBmTFZva3J3QXZ0YVpp?=
 =?utf-8?B?MFU0TE5rSHlaR1lwMEl0ams3c211UzBNZ1VLQk54em9iZmVuNGZQclZkU2ZM?=
 =?utf-8?B?eUxPNTdFdXFMZjE1TXZzMHR5djFXcWMwek5HVnlUR1VTRGYzdnozbG9wR1ZM?=
 =?utf-8?B?UW13RGhGS2FjZEJibkNNWi9BQlJ5amJ6TjVjamhsNW9CUUxjU2lkNk1XbU42?=
 =?utf-8?B?QzRYVFRMTlhnVFVWWWRkOFJ4V1BnTWlUT1pvcmV5SnlZZlNuczZmcXJLL04v?=
 =?utf-8?B?YzJzNnF0TzVtY3N4c1hRUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0VBb200Q0ZtWnRLT0VpZkhSOFBZNklGdDJzbzlIZlBlMlhPQ1p2b1BQVEc2?=
 =?utf-8?B?bWlZbGlBSnBBWXNXSWw0NzE3bVd3bHBUMC9hQld2eVNxN05nRE1sUnEzWXZP?=
 =?utf-8?B?OFNJWjVSRHNVYVZtWWh4dHd6b2FzMW5MZVpWL282UDJaczMxMitsYmJQcG84?=
 =?utf-8?B?NERRTCtuTEgwREZRYUl3SjRMZTZYWEtCK1NTT1BqcHg1S3kvQThjSCt1bFQz?=
 =?utf-8?B?ZjBaNlQ1Rk1LbUFmRkxKcmc1VFYwWlhGVzlvenMvQTdNbnd0ZlNEQUlWSiti?=
 =?utf-8?B?U3JPMXgvYkl2SEhSVEhjUHpyOXJCbnJzcWZUODZzdzJGOTlqOGFzTkhneVBl?=
 =?utf-8?B?QjhYWEltS1pqS0c0eGh6WkdGR1F6VytuL3M5cnpaN3hwZkhkWk9FNFF6VEdT?=
 =?utf-8?B?b2JNZFZxRXQwRVdya2Zkemg2cSt4YzZ6anV4WGdWQkFOcTUxUTBUTDd6c3py?=
 =?utf-8?B?akRTVEhpMlF3QmZOOUxtc0tMV0xvYVYzNitrR1VOT2hsM1VtTUJhcGJIaWV3?=
 =?utf-8?B?M1Q3bUZLRHovK2NpMFdWNURTSU5FUUVNNDdaYmtNTFE0aHhiMzR4QnFnWHdz?=
 =?utf-8?B?M0x4VHJ6MmpVQVZuand6Y1FLZUZKM295cXBLeEloVFI5ZzVJQkh0N0dHUlpp?=
 =?utf-8?B?ckM1eWQrVWxlT3BrdVpPY0ZXdEZacEZDMVJWMWxtZWNTWjNMeWc5U3p1NUZa?=
 =?utf-8?B?cTlYaFJxTzAvbm1acU1YK0U4VExHU01RWHJnck9LckNNcXVLTTVLVWJTcHpR?=
 =?utf-8?B?RE56d3pYMjdSeHNaallTUkkrTFh6dTJEM0cyZThpdkF3SFFNcUV4TGdCZnJV?=
 =?utf-8?B?dDNrZzBTK3pwRitIWjEydUhuWHZDS0JGRWc3WGFWRDlsWWRpWGMwdFYzN09a?=
 =?utf-8?B?cHdoWnlKSmw2YnBtVDFoZXF4MS9ROWVYT251Rmdjcnphb2h4a2tiVWFEQnJW?=
 =?utf-8?B?WEhSSnEyWlFtZkp6UVBRUUwwUWRRN09keUlpOEpvQ01GSVU0MytaMW9yblUv?=
 =?utf-8?B?QnFLVnhOMElmc2JVNDY5YzIzZHVOVU5YR05Xa25uc2JGcGtFelJUZWNHUEFI?=
 =?utf-8?B?SW9WNFB0MG9FV0lIZk1CVEVpTVl5bm53K0NJOGk3VGVYSVp3VzFqVlo0Mkpx?=
 =?utf-8?B?S1B0azBIVVY1N1pHZjZhY3RwZlViYWpNNFp5REVuUnM0TmZjSWdzWlQyQUpv?=
 =?utf-8?B?TnVIc0FTZEVyOXcxTHRWQVEwVUZPUFpQVFM3Z2ZMUUJkc1hNN1NBZWduNEtl?=
 =?utf-8?B?bXBpZ3FkU2VGSGtXU3NMeUVheTRkdFQyRDVrd1RPcFhBenBmakhid1owanZS?=
 =?utf-8?B?T2hjUno1M0hTdmhNUlA3NWh2MnN1c1NQOU1ZVHRveENYcnlOYngwOUlwWTVr?=
 =?utf-8?B?RVpJMGJudUZqSFF1NEk5amJRREphaGVLeVoydk5IWUVpZWUycE1sZjVWZFdY?=
 =?utf-8?B?RU4xbkRCMFZ0ME5Qbmw1amh1c3FwYlN4SnI4WVNFaXlkRmZHZFdRaW1hNVlQ?=
 =?utf-8?B?d2JsTzMzZWNmdytYMitGM0lwN1BmRE14Q0xtTmdYRkNjWldHc1RmR1paeG4v?=
 =?utf-8?B?SWh2MUFYWFNkVTVxNXB5Z0xtUmtSWjNEUzI2a3dITFdVRWdIMDNRREtJbXFn?=
 =?utf-8?B?M2QyNURsWmZyVDJBMG1sVk5VbmMrTjFkVkFValJjSTZSMmdEU01EQlk3RkFY?=
 =?utf-8?B?MW1EcEVrRm9jbGVmUFA4OTY0WllmTElYMnA5MlhQUWk0Kzlrb2dGL0ozSHBT?=
 =?utf-8?B?UFRrQ2JSZmNnY0N2RUtRcy8wdWJhaVBzR0FVaGdTeW83WE5NYktyQTNqWGdy?=
 =?utf-8?B?bktranpTU01HR2VDT3RHb0NPY1pmek90ZU5TVWRxc3duc2ZmZFRIMUxaNGNN?=
 =?utf-8?B?eU41Um1pVGVGM0NQeEY2aTQweHpZc0E5ZGhmK3VlN1BmZVN2MTJ6S2kvM3ly?=
 =?utf-8?B?QW9jQUx1ZWVpekF2L2ZuRmx1Unh2NHlFcmVoT0wxaXRMaGZnMEdvbWxRVkg3?=
 =?utf-8?B?WGw0eUFXRmFOWDZOQkNGbmpCbE9NZTlvcVNodm9IaUF4cTZPNGtieFFmNXIy?=
 =?utf-8?B?WmIwT3FqUVJ1cjRYcVpCUDNLWEdjV2UrUlFrcTg4dk5rb2NFeWQyNit2bCtC?=
 =?utf-8?Q?cs6NTAlwju1dLdGgU6cjVcaUS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aacce9b-0d92-421d-75e4-08dca8215a00
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 18:33:57.8763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+XRwVVU1YpjcViAmpAZAJFI13PwF+oeH4bwjHd3v2YT5tWdLBxhb6nnJVi49ulqBwodx5fHk4lHjNVPYdfEjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

On 2024-07-18 19:05, Jonathan Kim wrote:
> Certain GPUs have better copy performance over xGMI on specific
> SDMA engines depending on the source and destination GPU.
> Allow users to create SDMA queues on these recommended engines.
> Close to 2x overall performance has been observed with this
> optimization.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 16 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h         |  3 +-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 39 +++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +-
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 52 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |  1 +
>   include/uapi/linux/kfd_ioctl.h                |  6 ++-
>   8 files changed, 119 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 32e5db509560..9610cb90a47e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -255,6 +255,7 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>   			args->ctx_save_restore_address;
>   	q_properties->ctx_save_restore_area_size = args->ctx_save_restore_size;
>   	q_properties->ctl_stack_size = args->ctl_stack_size;
> +	q_properties->sdma_engine_id = args->sdma_engine_id;
>   	if (args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE ||
>   		args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE_AQL)
>   		q_properties->type = KFD_QUEUE_TYPE_COMPUTE;
> @@ -262,6 +263,8 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>   		q_properties->type = KFD_QUEUE_TYPE_SDMA;
>   	else if (args->queue_type == KFD_IOC_QUEUE_TYPE_SDMA_XGMI)
>   		q_properties->type = KFD_QUEUE_TYPE_SDMA_XGMI;
> +	else if (args->queue_type == KFD_IOC_QUEUE_TYPE_SDMA_BY_ENG_ID)
> +		q_properties->type = KFD_QUEUE_TYPE_SDMA_BY_ENG_ID;
>   	else
>   		return -ENOTSUPP;
>   
> @@ -334,6 +337,18 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		goto err_bind_process;
>   	}
>   
> +	if (q_properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
> +		int max_sdma_eng_id = kfd_get_num_sdma_engines(dev) +
> +				      kfd_get_num_xgmi_sdma_engines(dev) - 1;
> +
> +		if (q_properties.sdma_engine_id > max_sdma_eng_id) {
> +			err = -EINVAL;
> +			pr_err("sdma_engine_id %i exceeds maximum id of %i\n",
> +			       q_properties.sdma_engine_id, max_sdma_eng_id);
> +			goto err_sdma_engine_id;
> +		}
> +	}
> +
>   	if (!pdd->qpd.proc_doorbells) {
>   		err = kfd_alloc_process_doorbells(dev->kfd, pdd);
>   		if (err) {
> @@ -425,6 +440,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	if (wptr_bo)
>   		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>   err_wptr_map_gart:
> +err_sdma_engine_id:
>   err_bind_process:
>   err_pdd:
>   	mutex_unlock(&p->mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> index a8ca7ecb6d27..e880a71837bc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> @@ -259,7 +259,7 @@ struct crat_subtype_ccompute {
>   #define CRAT_IOLINK_TYPE_OTHER		16
>   #define CRAT_IOLINK_TYPE_MAX		255
>   
> -#define CRAT_IOLINK_RESERVED_LENGTH	24
> +#define CRAT_IOLINK_RESERVED_LENGTH	20
>   
>   struct crat_subtype_iolink {
>   	uint8_t		type;
> @@ -276,6 +276,7 @@ struct crat_subtype_iolink {
>   	uint32_t	minimum_bandwidth_mbs;
>   	uint32_t	maximum_bandwidth_mbs;
>   	uint32_t	recommended_transfer_size;
> +	uint32_t	recommended_sdma_eng_id_mask;

This seems completely unnecessary because your code in kfd_topology 
doesn't depend on this info being in the CRAT table.


>   	uint8_t		reserved2[CRAT_IOLINK_RESERVED_LENGTH - 1];
>   	uint8_t		weight_xgmi;
>   };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4f48507418d2..58d7710ebb30 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1534,6 +1534,42 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   			q->sdma_id % kfd_get_num_xgmi_sdma_engines(dqm->dev);
>   		q->properties.sdma_queue_id = q->sdma_id /
>   			kfd_get_num_xgmi_sdma_engines(dqm->dev);
> +	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
> +		int i, num_queues, num_engines, eng_offset = 0;
> +		bool free_bit_found = false, is_xgmi = false;
> +
> +		if (q->properties.sdma_engine_id < kfd_get_num_sdma_engines(dqm->dev)) {
> +			num_queues = get_num_sdma_queues(dqm);
> +			num_engines = kfd_get_num_sdma_engines(dqm->dev);
> +			q->properties.type = KFD_QUEUE_TYPE_SDMA;
> +		} else {
> +			num_queues = get_num_xgmi_sdma_queues(dqm);
> +			num_engines = kfd_get_num_xgmi_sdma_engines(dqm->dev);
> +			eng_offset = kfd_get_num_sdma_engines(dqm->dev);
> +			q->properties.type = KFD_QUEUE_TYPE_SDMA_XGMI;
> +			is_xgmi = true;
> +		}
> +
> +		/* Scan available bit based on target engine ID. */
> +		for (i = 0; i < num_queues; i++) {
> +			int tmp_eng_id = eng_offset + i % num_engines;

This could be more efficient:

	for (i = q->properties.sdma_engine_id - eng_offset; i < num_queues; i += num_engines) {
		if (test_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap))
			continue;
		...
	}

> +
> +			if (!(q->properties.sdma_engine_id == tmp_eng_id &&
> +			    test_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap)))
> +				continue;
> +
> +			clear_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap);
> +			q->sdma_id = i;
> +			q->properties.sdma_queue_id = q->sdma_id / num_engines;
> +			free_bit_found = true;
> +			break;
> +		}
> +
> +		if (!free_bit_found) {
> +			dev_err(dev, "No more SDMA queue to allocate for target ID %i\n",
> +				q->properties.sdma_engine_id);
> +			return -ENOMEM;
> +		}
>   	}
>   
>   	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
> @@ -1786,7 +1822,8 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>   	}
>   
>   	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
> -		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> +		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI ||
> +		q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
>   		dqm_lock(dqm);
>   		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
>   		dqm_unlock(dqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2b3ec92981e8..7d26e71dfd04 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -414,13 +414,16 @@ enum kfd_unmap_queues_filter {
>    * @KFD_QUEUE_TYPE_DIQ: DIQ queue type.
>    *
>    * @KFD_QUEUE_TYPE_SDMA_XGMI: Special SDMA queue for XGMI interface.
> + *
> + * @KFD_QUEUE_TYPE_SDMA_BY_ENG_ID:  SDMA user mode queue with target SDMA engine ID.
>    */
>   enum kfd_queue_type  {
>   	KFD_QUEUE_TYPE_COMPUTE,
>   	KFD_QUEUE_TYPE_SDMA,
>   	KFD_QUEUE_TYPE_HIQ,
>   	KFD_QUEUE_TYPE_DIQ,
> -	KFD_QUEUE_TYPE_SDMA_XGMI
> +	KFD_QUEUE_TYPE_SDMA_XGMI,
> +	KFD_QUEUE_TYPE_SDMA_BY_ENG_ID
>   };
>   
>   enum kfd_queue_format {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 21f5a1fb3bf8..8adf20760e67 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -345,6 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   	switch (type) {
>   	case KFD_QUEUE_TYPE_SDMA:
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
> +	case KFD_QUEUE_TYPE_SDMA_BY_ENG_ID:
>   		/* SDMA queues are always allocated statically no matter
>   		 * which scheduler mode is used. We also do not need to
>   		 * check whether a SDMA queue can be allocated here, because
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 6f89b06f89d3..f6effaabd4b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -292,6 +292,8 @@ static ssize_t iolink_show(struct kobject *kobj, struct attribute *attr,
>   			      iolink->max_bandwidth);
>   	sysfs_show_32bit_prop(buffer, offs, "recommended_transfer_size",
>   			      iolink->rec_transfer_size);
> +	sysfs_show_32bit_prop(buffer, offs, "recommended_sdma_engine_id_mask",
> +			      iolink->rec_sdma_eng_id_mask);
>   	sysfs_show_32bit_prop(buffer, offs, "flags", iolink->flags);
>   
>   	return offs;
> @@ -1265,6 +1267,55 @@ static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
>   	}
>   }
>   
> +#define REC_SDMA_NUM_GPU	8
> +static const int rec_sdma_eng_map[REC_SDMA_NUM_GPU][REC_SDMA_NUM_GPU] = {
> +							{ -1, 14, 12, 2, 4, 8, 10, 6 },
> +							{ 14, -1, 2, 10, 8, 4, 6, 12 },
> +							{ 10, 2, -1, 12, 14, 6, 4, 8 },
> +							{ 2, 12, 10, -1, 6, 14, 8, 4 },
> +							{ 4, 8, 14, 6, -1, 10, 12, 2 },
> +							{ 8, 4, 6, 14, 12, -1, 2, 10 },
> +							{ 10, 6, 4, 8, 12, 2, -1, 14 },
> +							{ 6, 12, 8, 4, 2, 10, 14, -1 }};
This matrix is mostly symmetrical, but not quite. Is that a mistake or 
intentional?

It seems it's only using even-numbered engines. An application that 
follows these recommendations can only use half the SDMA engines. Is 
that intentional? See below.


> +
> +static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
> +					     struct kfd_iolink_properties *outbound_link,
> +					     struct kfd_iolink_properties *inbound_link)
> +{
> +	struct kfd_node *gpu = outbound_link->gpu;
> +	struct amdgpu_device *adev = gpu->adev;
> +	int num_xgmi_nodes = adev->gmc.xgmi.num_physical_nodes;
> +	bool support_rec_eng = !amdgpu_sriov_vf(adev) && to_dev->gpu &&
> +		adev->aid_mask && num_xgmi_nodes &&
> +		(amdgpu_xcp_query_partition_mode(adev->xcp_mgr, AMDGPU_XCP_FL_NONE) ==
> +		      AMDGPU_SPX_PARTITION_MODE) &&
> +		(!(adev->flags & AMD_IS_APU) && num_xgmi_nodes == 8);
> +
> +	if (support_rec_eng) {
> +		int src_socket_id = adev->gmc.xgmi.physical_node_id;
> +		int dst_socket_id = to_dev->gpu->adev->gmc.xgmi.physical_node_id;
> +
> +		outbound_link->rec_sdma_eng_id_mask =
> +			1 << rec_sdma_eng_map[src_socket_id][dst_socket_id];
> +		inbound_link->rec_sdma_eng_id_mask =
> +			1 << rec_sdma_eng_map[dst_socket_id][src_socket_id];

Was the intention to set two different bits for the inbound and outbound 
links, so an application can get full-duplex bandwidth?

I also find it strange that the outbound link on GPU A uses the same 
engine as the inbound link on GPU B. That means the wiring of each XGMI 
link has the same SDMA engine affinity on both ends of the link?

Regards,
   Felix


> +	} else {
> +		int num_sdma_eng = kfd_get_num_sdma_engines(gpu);
> +		int i, eng_offset = 0;
> +
> +		if (outbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
> +		    kfd_get_num_xgmi_sdma_engines(gpu) && to_dev->gpu) {
> +			eng_offset = num_sdma_eng;
> +			num_sdma_eng = kfd_get_num_xgmi_sdma_engines(gpu);
> +		}
> +
> +		for (i = 0; i < num_sdma_eng; i++) {
> +			outbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
> +			inbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
> +		}
> +	}
> +}
> +
>   static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
>   {
>   	struct kfd_iolink_properties *link, *inbound_link;
> @@ -1303,6 +1354,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
>   			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
>   			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
>   			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
> +			kfd_set_recommended_sdma_engines(peer_dev, link, inbound_link);
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 2d1c9d771bef..43ba67890f2c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -121,6 +121,7 @@ struct kfd_iolink_properties {
>   	uint32_t		min_bandwidth;
>   	uint32_t		max_bandwidth;
>   	uint32_t		rec_transfer_size;
> +	uint32_t		rec_sdma_eng_id_mask;
>   	uint32_t		flags;
>   	struct kfd_node		*gpu;
>   	struct kobject		*kobj;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 285a36601dc9..71a7ce5f2d4c 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -42,9 +42,10 @@
>    * - 1.14 - Update kfd_event_data
>    * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
>    * - 1.16 - Add contiguous VRAM allocation flag
> + * - 1.17 - Add SDMA queue creation with target SDMA engine ID
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 16
> +#define KFD_IOCTL_MINOR_VERSION 17
>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
> @@ -56,6 +57,7 @@ struct kfd_ioctl_get_version_args {
>   #define KFD_IOC_QUEUE_TYPE_SDMA			0x1
>   #define KFD_IOC_QUEUE_TYPE_COMPUTE_AQL		0x2
>   #define KFD_IOC_QUEUE_TYPE_SDMA_XGMI		0x3
> +#define KFD_IOC_QUEUE_TYPE_SDMA_BY_ENG_ID	0x4
>   
>   #define KFD_MAX_QUEUE_PERCENTAGE	100
>   #define KFD_MAX_QUEUE_PRIORITY		15
> @@ -78,6 +80,8 @@ struct kfd_ioctl_create_queue_args {
>   	__u64 ctx_save_restore_address; /* to KFD */
>   	__u32 ctx_save_restore_size;	/* to KFD */
>   	__u32 ctl_stack_size;		/* to KFD */
> +	__u32 sdma_engine_id;		/* to KFD */
> +	__u32 pad;
>   };
>   
>   struct kfd_ioctl_destroy_queue_args {

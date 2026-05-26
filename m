Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AD9CD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 21:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E0B10E544;
	Tue, 26 May 2026 21:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NJwEP5ST";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010013.outbound.protection.outlook.com
 [40.93.198.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 807C110E544
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 21:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZK1Q33TeZ3LMlHBLmURakethCCQlpbcCyPl2qPZBxio0+wJn1HM8M3SiODS+Q2D9KN567bCsjvjEqdfJX4vZ/cDHqtVjsglF4Gmciqfi9D4LoMGRvoY7zoGq8Vttz1/l1/jA6UKQRCOu+cZgIEdDJR300gKwujpOYW9jXsq4PCSuM/us/fe1XIa3+FoEDUraEencazmGGQdH0iCaFF7f09bYqWph4rb8hKOeWwTZL8XjBW7tjxz0G1S0/LnPwiZKs5u0Fc+nsPx/DluBAbK895BNBTimGjxe7dbWi+Tz47W0vJAt73abZYTG/+FV+6ehPJWDcOY2Sp5VRfWYOOJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlvpwgP8XOQWrNHnbeSKsi63WbiXy3Pw32BxjImcU90=;
 b=XDr3p3Hntl4NJG4WdDSoPs8tUhZe8azVeV7MO83UKJtG3kZNvXmF/iIcM0TlQ8IBIv2zzT6a6YMLILdLwY8/X6Cr3wqY9Pszbf/7eHyCbKPE4YAGrM8LpTFfQ3teBnXhOM1bKBdoAXIhJpgcFxQ0GkH4mh2o3fj2s8oLWkvidMn7x7RqgswP2zUCwBOKtnQ9d1xU2V6G85nLC70YKghaxcp+Bkfdd+nFy88esaxjYQEhsgfBpPsQp0mxkqz+iis/3cHBJwABjlXypd5tF4BlprRQ6RFfnGoT7sOCQElGApojkTCWZ5WomUeUC5gNi5QIaX+yYt2Ztdeuxb5KeIswGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlvpwgP8XOQWrNHnbeSKsi63WbiXy3Pw32BxjImcU90=;
 b=NJwEP5STN4GesD5HnDsXFggF2GBbhxQQ8Btk16BADGdoPyjs7yNTXC+FliJPQKMhvuHQwEopS2BETa1OE8MF7sq7WC3EcVEcrv8+qz7lQU9oHPPaYFCPnO8WfLC3yhLqxvc7amIv8pDX8gEQT6Uiv2xYa2Ezk7ZDRzMftt4wxqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 21:02:00 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 21:02:00 +0000
Message-ID: <2616fd7c-8496-4dc4-a09b-fea1277e9af6@amd.com>
Date: Tue, 26 May 2026 17:01:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/42] drm/amdkfd: plumb a helper to reset a KFD user queue
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sunil.khatri@amd.com, Jesse.Zhang@amd.com,
 Shaoyun.Liu@amd.com
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-36-alexander.deucher@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20260522002048.98506-36-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::21) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9687f996-3712-42a6-5c7b-08debb6a07aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|22082099003|18002099003|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: WB/qJfYtTljuOron1rpbwpitOS2PBPX00XW/tdv4QDvY2YrSZsIYaiazGMW9cc/qRxPSKRwmKRZHAWMVWgDsp+tsE41jOgwWLTXEeeyW0s82tpzD6sTL6NpDt7lj51EwqewTbdRiQagDMEfzLf7pT0q7BOpEUhtK/7M3LZUxOBK2/7y19xVx2yZWyAHPXLp94mRwydQxgXN8mFustcqmfS6K+kSTidFBFkO9CxJkZpV+kWHvrSTkvO0tvaOqqQkVPZB7SArqynDjkg1AYtCaiwxhF7Jsk+kOrvcFOWvjaWqjyb/EKWBYD3S/AbgAeQtRlNG6NAF4KQIAQKYQOzP/nyD2uVAODte8gzTIVtSQFPZokLN4YTRRPS+1r8GtudSCJKP+COP8eVzZllLLQLHLFpBmVYcURzvTnQ5AJOT7zqB8WGqR3inX0yHFr0mL05kRXzVW/l8fVrbf19lklwSNlk6SqKuec13ig9rk8pdVppqnfWfg9LvMejs3HmLyFXbQXlNSfacd7/axxa2DuWaEdI8HET4YzfiNtfCYF93WSF49JcBwJ8H97pCdmcy2FrJT8vJXLjaeR891eHZitSAo2oM3FtS/Fdgq+1cXtBJm52T9tcse3Z5sv6qW3o7UH8sS1VwjDzS5xuZHfmHEouoh5YAjj8SjUKmXrnTFNiS9qXwnesqyFKlfFmoZdNxsLwWS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHFZUXNCdEVsajdKbVFDbi8vTmtDSWV2cDBFczIvSjRDeFBRZ1QyTXkwNVNv?=
 =?utf-8?B?d0J0bUlkQlhsd2kzcXIxaEY4TDFXOCtVVUhvc0wycXBXeDd6cm11MUU2QmMv?=
 =?utf-8?B?TlhRQjZBdm1nUGNGZU9JdlV5bnZuSnU0eTIxV3JyQkVITlFaYUFrYlBYSC85?=
 =?utf-8?B?bFhwRmVOalhrMFcxMVI4dlE2VEpZT2d0bWNWR2xBWnpzdmdTQ2pCWVlaTGRX?=
 =?utf-8?B?L09qNVYvTWFhU2w3bUtVRk95ekwwcG1XandiN2wzampPVDVvVGVXWHpVTm1X?=
 =?utf-8?B?cXFQNlJlcS9BODJqLzYzK3hGdktiWWluZThpZHBJTU1QUFp2ZXZOWlZPWmUv?=
 =?utf-8?B?bkJpRVpvQmloODYrY0l5dzhOMWRGQ2U5YU5wOVVpMTBvY2ovUWRWVzZUT29v?=
 =?utf-8?B?dFpsOHUxT0hCNjBFb1l4UjJwaWdKMUtrcDVoS3RCNC9FT2l2N2lMNHhLNStq?=
 =?utf-8?B?bUYvRXB5VGFJRHl4R1FLZFlzTWJxc3JOY1Y4a3NILzc0QUJmVnUvVFRRd0Rk?=
 =?utf-8?B?a21DcW15d29JNEUrMU9IRVBJbmZ1elc0dXVNY3BRMFRUVG0rMnptU0tqYW5F?=
 =?utf-8?B?Mk41UEdDMkpwRkVtc2tIZTYvUVRBZFE2N2Y0N0JtZzhXa0txa3JJRGpZUDlh?=
 =?utf-8?B?OU5zcDRyRGhkdzZJTzZqZmlBb1c0dTQwc2tYdnBNWVpjSkp6RU92MVFQTXNB?=
 =?utf-8?B?NjIyMDJCK1RZbklZdzRBR0xpWGoxOU1meGgwL1g5ODZ5SWlmR25CbzFKTUxG?=
 =?utf-8?B?OFFkN3Evc3RUazZTVFhONUlIZTVpQitGS3hNM3Y2VFhpOGtWK0lQZ3dtZTlt?=
 =?utf-8?B?ejlIQ01YaXZCeW9DNklVT045SmFFUjBHSWttSzMwVkFBYW45d0RiblUxWG95?=
 =?utf-8?B?WGloQjhDL1R3T2JpTGJIRnA5STNCQVVyWFp6elNvb0NCaFhyaUNCdXRmWjFr?=
 =?utf-8?B?WmZSNGt0aTliSTBOc0NIcWpkTDdqOCt1ZkU2OEFqZndnRTNIaXZtK3Bsb2dH?=
 =?utf-8?B?UEtScGVxL0hkTGNhTVlyS3g3SHl5ckNiMDdRRzFPdzVEZkI3U0YvSFR3ekJK?=
 =?utf-8?B?YkhuaThSWVNiVllJUEdpaVhSd1ZlN2RUbXdHY0x0U29PdWZJWklZUVV2NDlK?=
 =?utf-8?B?TWJaa1ZSeVJTMlpvNnBXRnBzYjEvRFB6N1FkMzdqdkRoWTVoNVNhQzg2RnFD?=
 =?utf-8?B?eG9NR1VSNllNU1k0eTJUcFgyYjNLVW1aNUZVWVJDTGxubFM4dmNybmR6ZCs1?=
 =?utf-8?B?YVhjOHFKd01iYUY3OUZ3R2xXcmtMd3NUK01RN3RBY2ZsNmxWQzBsR1NIb2Za?=
 =?utf-8?B?WTBqbnJFYVl1NXQrK3o1WmY5Z0xuQklCSjhYRE5KVXhJbXZ3N241MGEvTXpP?=
 =?utf-8?B?bnVpT1NUc1VvL3BoeWRVWGhWVHJsNjhBTWwzVkJTaDlxYzBGRTRicUFIZG0y?=
 =?utf-8?B?V1ZvVFp0MXhsMnVSazZ2MWczTTU4aVF6cnhyZlBSd3plVWJ6UzhTa0dTL3FP?=
 =?utf-8?B?NHRUUDVRRjFTeUZycHM2Y1g4T09rSzQ1NXVYbXpYNWlzNVZkckk0Z0pJU1BI?=
 =?utf-8?B?MmxxOURRb0FqTDgyU3lVSUpIRUk0Rlo1Znl2Zk54UDUzT09NRFg0MjlBZWJv?=
 =?utf-8?B?Nndrd1A0RHZGTWVuSWF4VkJEUCtDVzNBNXdaTUl4L2FzcitYMXEvUkQ5UlBP?=
 =?utf-8?B?UGcraWt3Qi9uMkxiTE9sTVNWeFd5VHZVQjY4VTdIRmlrVm94TklFTzlueDBN?=
 =?utf-8?B?REhTZklIVmo3MjJyaDZpVUFUVmFHSFBGTjFGcU1JTjhZalZsMHpGdjk5cFR2?=
 =?utf-8?B?OTZ1N1BTcHNvQnZDMHcrMVEzRjd4ZmZQUGhTcXNyOVBvSDU4SjZiQnJNd0hT?=
 =?utf-8?B?akMrSVJpcytDbnZhei9vZUpFcUFRWWx4YjVYM0s0eGVaWGpwcWwzczFRR0NR?=
 =?utf-8?B?ZFpNR2RXUW9raHMwNS9yZlFkWjk5OTExbnJmaCsvMnl1TVJ4UGxCZzV5K0hy?=
 =?utf-8?B?cnVNQjE0R1VRdG85NUF5MTJoZDVTSFBodDJpY2x6NVR4S3JDZjlDTlN4MGlS?=
 =?utf-8?B?MFlsbnhTcDkwUlJhVFpIK05sMXlTVDRJcWV3NjZnTzRqNTFaMDhTN2tXMXBS?=
 =?utf-8?B?c2llNVo4ZzNTeW43QWU3bmRJKzJIaXZmcU1vRkNHR0tzWTlLNHBmaDBaZFBq?=
 =?utf-8?B?cHk0RDJRbHBrS2t0RTllRFZZSW5yWkdLSXpDdVZvSGgzWmF0VmhiS051dEVz?=
 =?utf-8?B?Z0JGMC9IOWtWM1ZJeEFvdGs2YzU1Y3JWRmNDWS9IVE4vQVBlamVkZll1alhW?=
 =?utf-8?Q?pgmMuO4cAAtFUVxMg5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9687f996-3712-42a6-5c7b-08debb6a07aa
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:02:00.4523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9YwLI7BAVhNqzaiLt9HalLcr+F0vHswHvNX5SDVMgsKHWemYhVckDlx/o49xdZ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
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

Reviewed-by: Amber Lin <Amber.Lin@amd.com>

On 5/21/26 20:20, Alex Deucher wrote:
> Can be called from KGD.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 14 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 16 ++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 24 +++++++++++++++++++
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++++++
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 ++
>   5 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 0017d502d1692..ffd059089c56e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -942,3 +942,17 @@ int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
>   
>   	return r;
>   }
> +
> +/* Reset an MES queue */
> +int amdgpu_amdkfd_reset_mes_queue(struct amdgpu_device *adev,
> +				  uint32_t node_id,
> +				  int queue_type,
> +				  int pipe, int queue,
> +				  unsigned int db)
> +{
> +	if (!adev->kfd.init_complete)
> +		return 0;
> +
> +	return kgd2kfd_reset_mes_queue(adev->kfd.dev, node_id, queue_type,
> +				       pipe, queue, db);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 5333e052d56db..d403af5fb5526 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -275,7 +275,11 @@ int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
>   int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
>   	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
>   bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
> -
> +int amdgpu_amdkfd_reset_mes_queue(struct amdgpu_device *adev,
> +				  uint32_t node_id,
> +				  int queue_type,
> +				  int pipe, int queue,
> +				  unsigned int db);
>   
>   /* Read user wptr from a specified user address space with page fault
>    * disabled. The memory must be pinned and mapped to the hardware when
> @@ -446,6 +450,9 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
>   			       bool retry_fault);
>   void kgd2kfd_lock_kfd(void);
>   void kgd2kfd_teardown_processes(struct amdgpu_device *adev);
> +int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,
> +			    int queue_type, int pipe, int queue,
> +			    unsigned int db);
>   
>   #else
>   static inline int kgd2kfd_init(void)
> @@ -576,5 +583,12 @@ static inline void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
>   {
>   }
>   
> +static inline int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,
> +					  int queue_type, int pipe, int queue,
> +					  unsigned int db)
> +{
> +	return 0;
> +}
> +
>   #endif
>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9e77c4a842ef7..e87e1b78ca421 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1793,6 +1793,30 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
>   		cond_resched();
>   }
>   
> +int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,
> +			    int queue_type, int pipe, int queue,
> +			    unsigned int db)
> +{
> +	struct kfd_node *node;
> +	int ret;
> +
> +	if (!kfd->init_complete)
> +		return 0;
> +
> +	if (node_id >= kfd->num_nodes) {
> +		dev_warn(kfd->adev->dev, "Invalid node ID: %u exceeds %u\n",
> +			 node_id, kfd->num_nodes - 1);
> +		return -EINVAL;
> +	}
> +	node = kfd->nodes[node_id];
> +
> +	ret = kfd_reset_queue_mes(node->dqm, queue_type, pipe, queue, db);
> +	if (ret)
> +		dev_err(kfd_device, "Error resetting queue\n");
> +
> +	return ret;
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   /* This function will send a package to HIQ to hang the HWS
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0a59a79ee28be..babf53b7b1bb2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -433,6 +433,17 @@ static int reset_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	return 0;
>   }
>   
> +int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
> +			int pipe, int queue, unsigned int db)
> +{
> +	struct queue *q;
> +
> +	q = find_queue_by_doorbell_offset(dqm, db);
> +	if (!q)
> +		return 0;
> +	return reset_queue_mes(dqm, q, queue_type, pipe, queue, db);
> +}
> +
>   static int reset_queues_mes(struct device_queue_manager *dqm)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index e0b6a47e7722b..2229f8b2f4462 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -333,6 +333,8 @@ int debug_refresh_runlist(struct device_queue_manager *dqm);
>   bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
>   				 struct qcm_process_device *qpd,
>   				 int doorbell_off, u32 *queue_format);
> +int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
> +			int pipe, int queue, unsigned int db);
>   
>   static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
>   {

-- 
Regards,
Amber


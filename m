Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C9CCA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 08:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C89110E765;
	Thu,  8 Oct 2026 08:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yq+dzs7H";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3676510E765
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 08:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWJJ978WCPHsMn3gJ0idNIbtDAO1C38rp1DHDgDUQGeJPEksYQGlAe/D1FNvf70vlffHePtNcoqRTNEc02jDPJmFuW0A/MbM5ahdeRAPkoB6sYnYNFM3stbivrRDADV3yL87LaQqWTxZ+E2WhvAqd75yMy7VRG8rIwB2gpA5+LBoM7yjdHybSa+9JbIXyRisXj6DUhjsVmvgHiSH8XT6qWTmcfQAlFibQK7VjuOlV4oaNJN95GP8tnV+69wR4XN6sEqodHiTxBKDXyIMh45o2W9ELE+cZrrIxPa5DeJghzF+ZrNZzdh5EgyKpct6rBe76rLNaBdcqN9Sh0OA485dVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp7Xkr39u6D0Yj3Gp9zLX0Gmq4epSOW/X+/5kQcp6/0=;
 b=w6Bkq+wVSo1AnWVTJGO3kbDkrOTnmvR2sSOr3tdKP90rktpzfBrqJu/trooUp4gCDn1vFtCRKy/3o2UGFHIxw7NQZf2beA496YEt4abBrEt7VaB1fjHCKelFPD9XcykTw0xydjoy6aUdGrfuRCgASCpnDK1JklZt3eMGC5rApAi+jchnqz9fBDRAmqKvQ8EYZw3IQKZ3YYncIjJ8WDsCHa0TnoPkbPgPkxnc32RUay+GVHx2hArzf5x2UFfylMtFDQmGZoqmrj8rzCAje+3n1e6NY7jPxua0M9J1N7cnrA9gbaPCNxx7PvaESBd/kJLZvuxMlxQogHGzjCJeG5e2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp7Xkr39u6D0Yj3Gp9zLX0Gmq4epSOW/X+/5kQcp6/0=;
 b=Yq+dzs7HdxNwxU83LddXeuj6oeJO/Y3POQJIH1W3DBpCNqB0yT4kG5T0fGmh/75DOqVRSuuRe47cIwnmgYxuH4XLcr/9hcgtYuOJJIyIO4OSdV3hABNw0UMrgHAD4L9QlRPSme0BAGd9VNdAdgfFKbx3Pxr+A/sPjW41T8Nnwd8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 08:36:39 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Thu, 8 Oct 2026
 08:36:39 +0000
Message-ID: <993eb2ce-b57d-456e-a18d-462d44b31ed6@amd.com>
Date: Thu, 8 Oct 2026 14:06:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Allow cancelling a requested NPS mode
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
References: <20261007120321.3516957-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20261007120321.3516957-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a226d1c-a003-48dc-f040-08df251745a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: pI44YRjU7lbtYrkTz+ruI/yWfKkIjLHM+jFhlyLfO+JMOLwNOU6fgOcQFXW2xNicO3hGoxTmTCSH3Ukwqw/RktywGgADWL5Lpr+MjTE/A+B/CZG3xA4q1bAb4SFHtrsmscDTw+mE/3bql14a/H/idjbNWIwTBHxIdxzbpEeUmwiC77sWQjBJk/EcSy3DsStwvsPZXf4d+BUkqP4p+RQDvg3SOUmh3BasGDqC0oq4pYVdXnVk1U9fFnIAeJnABIsxqcz2dNII/ANvHGW9H7nTJuK9Z5WSTgHoOKoA6LnKJ1J3lgBRaAwNPkhlRLE3UOkhPVScB+XpJQb5yc3HyEtkGU6LbuzBwaz9DnW8/lIKdMoWLiF30ic+imCB98/Nt9ZSTSI7LhwH2fVoVKVWm3Enn12vF3YAS51pG2Zpqa6yBm3DUnCLEKPGJb5a8GzPH9SbXhxDipwy1HK9ZBnQuBgtIHNkqXCI+iEQFH0rvf4b+kmgw8nq5oDYLJZ4lTdjc4nPbcYEqdmOWtjxwEQdWRcJnirnlNNz+XdlpomNNMdz3vi3cYOOs9jzTvbn22tnULD5Ts5Q7jKktxjbobOgqjZ0x0Q1ct6guCrn3R2lBE8P4NxQbwWQ9MuO5QX0e6EXk7Lfti84kASzkssFq9BMvd/vBfko63iMX6Ml8aTKyKAfVw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXY5U0QzOHJDN1hIUUZJUnlKbW1WWnNFbW5iS1JZcU82Z2hnNHlrY0xBek9m?=
 =?utf-8?B?aUlkMDQwd2U0bDdSclhSRm9uczJCTzFkU3RvNHhkMmQ5SkIxb1JkZmxPL1BX?=
 =?utf-8?B?NmpLcGJuSjF6ODhBZFphVWpPdGgxc05UM3FCNnJkR1kySXB4dTBhdzNSa2FZ?=
 =?utf-8?B?ZHVYVGs3WmYyMkhRVlN6R0Q1azFLY2FCSXkyejk3enRSZitvWlhZRzFaR3VD?=
 =?utf-8?B?RGRVU1lQWE9jVE5DcEY3bmlqMEI0aTFlUTR3RDZCTlpDZVdTWnNYTmlXcHBi?=
 =?utf-8?B?NFhVN3djRU1RRmZRTVpheG1zSDhzZTdoV04wTXUxY1Vma0ptQThwNnQxRUJj?=
 =?utf-8?B?Q2grRnIweGRmU0RjQ1pyR3V1VGdGNUhOeXJsUmR0Y0FZZVY3WmdyempLRDVR?=
 =?utf-8?B?ZjRwU1FPK2JqQlB5NzdLT1hULzIwNWxrbHBwbVh1WTIvMGZaVGVuS3U2NHhp?=
 =?utf-8?B?QlBjU1FVSWVJQUNEZlhiNlNCd0lsN09nVjhpWGRuWlR3Ry9BUW8zOHB6cG1B?=
 =?utf-8?B?aTUydHAzbU84NGJHZzVjMDl3cFhYdXpjSGRoT2JMOFdtR3RWTjFNRElmUnMy?=
 =?utf-8?B?bmJUQnVUTlhCRXVMaDBVc0hWTE9hSVp3eUQxVGFxY1hxeGt5Q0I2Y0lQa1dw?=
 =?utf-8?B?Z3hxM0lrSzZtMzkwcjZaaVFEU0diSnlPMkhHN05Gb05WdGw3aEZMZTU1Y0Zk?=
 =?utf-8?B?a1oyWEpuUUp2K2wxdlA5ZlpQSlRUdmdwVEY3TmJLalNuSUdUdE03U2VXRzl4?=
 =?utf-8?B?L3BwdTllNTV5T2xKYU9VVytFa1pHdndsYU80YXNGUmNnaDJUZ2xENkxFY3ZX?=
 =?utf-8?B?Uk5kRWhpSDhzMmNma1lEbWxMdTJjNUlnUFZweXhCcDFGSDdNdGJuRlYyWjhE?=
 =?utf-8?B?Z3RBaDZ5Mi9sT2pvK1F4QWh0Rys0OTNWL2RQSWhCZ2d6MFpJU2tOUm5DakFN?=
 =?utf-8?B?aDd2N1NCUm0wOThzNEo4aU9DS1IrMmRyanZBTFBWR25CQU5mQWt3T2tTaXJx?=
 =?utf-8?B?emp5UlZ0M2FCK0djZVcxSi9pQjM2S1BUQlNiclJTbE15UUU5S0xRSmdQSjR2?=
 =?utf-8?B?TTRJMmx2bVB6YWpTaE1YS3duWkxNb3h2QXdST0t0Z0pnRXBVUk8ycXZieW5z?=
 =?utf-8?B?Ri90UDRMdWw1RWRFTGJoTmlpRFRNaSs2VnRMMHJTYjc4OVQweHRPSTUzYnBw?=
 =?utf-8?B?T2hBMEM3czM1bXBGMnQycDUxeWNRTDJqSWR6Umw2cWJUdWZxUWRvWGVaaE9Y?=
 =?utf-8?B?MWVQU1NWVnd3dWVReXZRUldpelZWdG1MdzJ1UGlUbE80L3RyemlBZEtRRE83?=
 =?utf-8?B?Q0loM2RZS3BITDNRY1FjOVVUWjVvUzV5N1VwbUd4Z0hMRE1SSEdSWis2Nmlw?=
 =?utf-8?B?ayt3U2EwK1VBVERCc2tCcEp3NmN0OWpZSjF1U2tRNG5mOExXV0dhRitaZzVi?=
 =?utf-8?B?UDl4a1ZKSkF4RzNDSGxqcmM0TWRuZjdNTUFXNzl0Y2RFbGFWenhsR0Rhcy9a?=
 =?utf-8?B?UmsrVC93Kzgwbm1jamkxenVHSTVjbXhhenZtdlZJTyt5MHVvRFdyZi90eWww?=
 =?utf-8?B?UVJ5RFZiazNlK0QrWG5aMStUOUJ3YVNBSkhhYTh1c1p0b0hxbmdpcGM3SGpv?=
 =?utf-8?B?aUFsWTZoVDRWYnBzZGxUcjBqSkJGcWFNVGk2UVh6NWZMWjJSVWx5Z3J1ejBF?=
 =?utf-8?B?bkJMM3lCT3NiaVNUWkZrRmNsUitQR3VNaUxGZXFSRnY1VGJPQXVOYjRaNTlx?=
 =?utf-8?B?V0twTkoxdU9GSjRIZzlEeEtDeE14RE1xMmJJcDVRcVhINU4zcmNiVHd2Qm94?=
 =?utf-8?B?NGdYUmhINEJIb1g4RUVoOEdJUjNpWDhLUHprWGRIV3ZlSjFDVDlFOVlIVmJx?=
 =?utf-8?B?cHpIc0RqYmRCcVhCQlJnTGsyZHIzQnNIQ1BNU2EydXdmTFptTnp5N2I0QVVa?=
 =?utf-8?B?RktpSDhDMWpkdXJLSWtFK0JHVVhSVGlzdXp4eDByYndQS1ZEalptU3F0Y1dJ?=
 =?utf-8?B?SU5oK0JYL3NneGxQc21BZlZaNGM3dXB4a3BXVmlEbEo4eWRrWEs2TlE1dU9x?=
 =?utf-8?B?Tyt3akIrUllvbWRCdmFpbVF2YjBWNXZsK1NGMkpZNS9oRW5mRzM2L3ZrVWZl?=
 =?utf-8?B?Q3hJZjI1MUxHTDlJa2JkYVpZVnFWUXNuMXZ6U3czRnZIbFRWanpsZ3p1SHhD?=
 =?utf-8?B?L0c3UHNkWFdqZ0ZtODREL0J2dGlBZDlGVERvdm9DMzlvTGVxblQwR1dGc3BT?=
 =?utf-8?B?YklOWHZJVVQ5djIrU0tTMWpHQnp4ZzRScUIzMC91cHRZbGtoZy94TG1JaVcw?=
 =?utf-8?Q?Y27EQxjiW/W2PjK875?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a226d1c-a003-48dc-f040-08df251745a6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 08:36:39.4754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW65tbOBS28ReTtIIhKYaT/Mhqc9tV6G5sr2Ax4SV08bABExqK8ae2vkawqLbpfX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158
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

<ping>

On 07-Oct-26 5:33 PM, Lijo Lazar wrote:
> NPS mode change request doesn't allow to request the current mode. This
> causes an issue where a user stores a request and later wants to cancel
> the request by writing the current mode back. Th pending request stays
> the same as before.
> 
> Allow user to change the mode by comparing against the cached request.
> Writing the current mode back clears the pending request without asking
> for a reload.
> 
> Fixes: 012be6f22c01 ("drm/amdgpu: Add sysfs interfaces for NPS mode")
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 52 ++++++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  4 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 13 +++++++
>   3 files changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d25ca903e21b..87d78fd34e23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1398,6 +1398,40 @@ static ssize_t available_memory_partition_show(struct device *dev,
>   	return size;
>   }
>   
> +void amdgpu_gmc_set_requested_nps_mode(struct amdgpu_device *adev,
> +				       enum amdgpu_memory_partition mode)
> +{
> +	struct amdgpu_hive_info *hive;
> +
> +	/* If device is part of hive, all devices in the hive should request the
> +	 * same mode. Hence store the requested mode in hive.
> +	 */
> +	hive = amdgpu_get_xgmi_hive(adev);
> +	if (hive) {
> +		atomic_set(&hive->requested_nps_mode, mode);
> +		amdgpu_put_xgmi_hive(hive);
> +	} else {
> +		adev->gmc.requested_nps_mode = mode;
> +	}
> +}
> +
> +enum amdgpu_memory_partition
> +amdgpu_gmc_get_requested_nps_mode(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_hive_info *hive;
> +	enum amdgpu_memory_partition mode;
> +
> +	hive = amdgpu_get_xgmi_hive(adev);
> +	if (hive) {
> +		mode = atomic_read(&hive->requested_nps_mode);
> +		amdgpu_put_xgmi_hive(hive);
> +	} else {
> +		mode = adev->gmc.requested_nps_mode;
> +	}
> +
> +	return mode;
> +}
> +
>   static ssize_t current_memory_partition_store(struct device *dev,
>   					      struct device_attribute *attr,
>   					      const char *buf, size_t count)
> @@ -1405,7 +1439,6 @@ static ssize_t current_memory_partition_store(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	enum amdgpu_memory_partition mode;
> -	struct amdgpu_hive_info *hive;
>   	int i;
>   
>   	mode = UNKNOWN_MEMORY_PARTITION_MODE;
> @@ -1419,23 +1452,16 @@ static ssize_t current_memory_partition_store(struct device *dev,
>   	if (mode == UNKNOWN_MEMORY_PARTITION_MODE)
>   		return -EINVAL;
>   
> -	if (mode == adev->gmc.gmc_funcs->query_mem_partition_mode(adev)) {
> +	if (mode == amdgpu_gmc_get_requested_nps_mode(adev)) {
>   		dev_info(
>   			adev->dev,
> -			"requested NPS mode is same as current NPS mode, skipping\n");
> +			"requested NPS mode is same as current/already requested NPS mode, skipping\n");
>   		return count;
>   	}
>   
> -	/* If device is part of hive, all devices in the hive should request the
> -	 * same mode. Hence store the requested mode in hive.
> -	 */
> -	hive = amdgpu_get_xgmi_hive(adev);
> -	if (hive) {
> -		atomic_set(&hive->requested_nps_mode, mode);
> -		amdgpu_put_xgmi_hive(hive);
> -	} else {
> -		adev->gmc.requested_nps_mode = mode;
> -	}
> +	amdgpu_gmc_set_requested_nps_mode(adev, mode);
> +	if (mode == amdgpu_gmc_query_memory_partition(adev))
> +		return count;
>   
>   	dev_info(
>   		adev->dev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 76e6f1f96913..89f1ee829eea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -484,6 +484,10 @@ enum amdgpu_memory_partition
>   amdgpu_gmc_get_memory_partition(struct amdgpu_device *adev, u32 *supp_modes);
>   enum amdgpu_memory_partition
>   amdgpu_gmc_query_memory_partition(struct amdgpu_device *adev);
> +void amdgpu_gmc_set_requested_nps_mode(struct amdgpu_device *adev,
> +				       enum amdgpu_memory_partition mode);
> +enum amdgpu_memory_partition
> +amdgpu_gmc_get_requested_nps_mode(struct amdgpu_device *adev);
>   int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev);
>   void amdgpu_gmc_init_sw_mem_ranges(struct amdgpu_device *adev,
>   				   struct amdgpu_mem_partition_info *mem_ranges);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 85ba228f002d..5c233acba084 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1617,6 +1617,7 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
>   static int gmc_v9_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	bool nps_switch_support;
>   	int r;
>   
>   	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
> @@ -1641,6 +1642,18 @@ static int gmc_v9_0_late_init(struct amdgpu_ip_block *ip_block)
>   		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__HDP);
>   	}
>   
> +	nps_switch_support = !adev->gmc.xgmi.connected_to_cpu &&
> +			     (hweight32(adev->gmc.supported_nps_modes &
> +					AMDGPU_ALL_NPS_MASK) > 1);
> +	/* Initialize requested NPS mode to be the same as current mode */
> +	if (nps_switch_support) {
> +		enum amdgpu_memory_partition mode =
> +			amdgpu_gmc_get_requested_nps_mode(adev);
> +		if (mode == UNKNOWN_MEMORY_PARTITION_MODE)
> +			amdgpu_gmc_set_requested_nps_mode(
> +				adev, amdgpu_gmc_query_memory_partition(adev));
> +	}
> +
>   	return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
>   }
>   


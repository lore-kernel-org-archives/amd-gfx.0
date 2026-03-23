Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D4FF483F8
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 20:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166F310E45F;
	Mon, 23 Mar 2026 20:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MwYVinGa";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F59010E45F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 20:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do+QK+M6Surz/6PuwRGWQaQDysm2XXs/LXMZ7DeRq5gyPNvMYKJF9QcVJQLAWcHk+usSxFciSUzUu1Eqs8TicuM2Ldt3nUK6Pf8ipioW7exiuSiyXjDWCuZYZwA3mjtF+W6Ze/K/MG7GvuAf5gaSaH+C3GUV62Ho0LglENScjFWEawlBnfx1I2QWlo3RD4MQzS6OCcZV2v+bin5JnFHp8Gh6gR/apJ/oXyo0jHLwdZIcxQ1lyDmKZPFyXzcaeHjYELr1OzaPcN+OL5fjeWTzZIo7A0L3qf84ImZvvSSIVn9Sfl9Z3vArQB9TvqOvotHqkwdTzNYDZu2m/nIMZ70rfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0SuPAzPrziFpVdupgVi7SiSElt6R9Zw5xOLVezcftY=;
 b=rrDbccH2ji9sBnKXD5uDTQP5CQzfTp35zuV6kZ97VsAh4Uds57O8w2/dw3A4libdQdLOpnJSzhu6Ai2eIctEEL/QF8rgEQ/hGMqWHhYDvdDoowZ/VSpoQHfzHDvuMzpsWNMaOf5V+R97lUpwXLNtzRZ+F4FMzs5v3Q2tSrNf24972RGQzB6CiBPJxhmgMgkmciRwvUdmbMZa2BI3xIvX9qKve6jDOEazFir4V1S8ZH9LoteEe8bPKjFrbnr8Gc90bwG/hqTmykkOu3WesAe74LzQ3M0GI+EAXm7JfxBUAjbwoX8QT+JGpNfCQpt7XW395FAS0KczXZGeJmBhk8ofvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0SuPAzPrziFpVdupgVi7SiSElt6R9Zw5xOLVezcftY=;
 b=MwYVinGaQcSKZFNmRlruVEVOFraN/TsnNzdAxr/DEjhI8dV8sibPqaLoC4+xJhsUcUcM0NhvD8aZ4TqbNEBqWiqb0jHyeRpDLTEfwPEkUo6qbEkAWcP6NnX/N/+zRpZHdD4Yi7lsOTns821TRUKcZCXR8/r+s7Izt3t+mBk/CHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS5PPF922753E5F.namprd12.prod.outlook.com (2603:10b6:f:fc00::65a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 23 Mar
 2026 20:53:13 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 20:53:12 +0000
Content-Type: multipart/alternative;
 boundary="------------0rTJvb09yAhA61WmtTuT2ku2"
Message-ID: <3997c793-edca-42ae-bbd5-b35192946e9d@amd.com>
Date: Mon, 23 Mar 2026 16:53:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add an option to allow gpu partition
 allocate all available memory
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260313223735.3391865-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260313223735.3391865-1-xiaogang.chen@amd.com>
X-ClientProxiedBy: YT4PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS5PPF922753E5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 330bb5dd-8da5-491f-3116-08de891e32af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: kujNDgECAv+dxvOO8Rj4j5me2FjHKaALL6fu53oelSiCnS7ES8REui7l1PA28wEmlKgdCYSQAJLwpzlJk2BpJv332djk1VvKiG9l86nIqFYk1wO6LJiRcQ1uLcQjjqSP4saDrHryqPW6fRVwsWCuwGbwmSi0ku2rcIW4GYNsKk5Nnpi3dU7RN9RlrDkNkANiX35KIWcJz2Wj2WMJLtkPnJdIiVCXGDQY+lPfAWM7QjHAahd3Lc6s2C1sFzDm+uQhnAMYLPc5JRlDF7Jxgc6/fAmeYtzJ6ViN90dzxgOThScFjtKAwV5FTPiEKjXe0u2D0UMPSrN4ZbZDNalRM0fYXbhIBAI+lGpwkVK26ZjuE5QjSm6DupBaytCdjDqDCh5VK0IOAbT72jvTHjmLqIgj0YxKaLI/pLZUWMBma8pRtUNkgtH9+xcU4ofj3PcWwxB8fCGq9rp9Rfgi1wg9siK1RW/4nb8zJASg0EgDHtVRLvJw25Snw1flf3j0TfAmChWpBsRAg7k12jo5kzc52pNG04Bt/G2Y6XdqCqDoCX4vsDkpK6ecOeClVAde1BDb2dCcEBeOnhtZB3p3wCMg46N7y6tvLPufqix3dYRpH4PgfsA3P8oDBPenH2HkMK72zK5TLGES/8eJtWAfBAmQ6zTT3CHO/pUbgQJFAD7EC0q1m2SOOThSxYvuFx05cmf7l7QcIsMx1xSHSIMZVSWvZIlRJfXT9PrJVmNFq5/JxGzvvNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2pJa05aSWdMaGJLZ1BkOGdxYU1sd0FPSzRvT3NXMkJ3NHF5YzBVdDZ3aUtR?=
 =?utf-8?B?L2V0WTVERkgxS0NxV0ptQ0gyWHlYNzV5K0ZvS0F5UXk4UkZqOUE5d05pNFps?=
 =?utf-8?B?RFUzWXdOd3k2STdySURsMGdhcit6dVRaNEFJTjV6aDBVZzBneUpvUGpmeWZY?=
 =?utf-8?B?cmxBVGFUWmFERGN2QzdTNTJlb0hYdUZ3VHQ3dnFDTjA1TFMwdmoxTlJ5b0l5?=
 =?utf-8?B?YzFQMndZZkN0Qm5zNUpVT2FHYlBIL2VzaE02bkVYU2J3OGcyaTZaUE5nckN3?=
 =?utf-8?B?VXR3VWlMVWdPeHlZZm4vSFFHK3VQa0xOOStQc1kvcFovTjNzUE1LYTl4MlRF?=
 =?utf-8?B?MXFKbHVuM0ZoSGNFdkloaURsQVdSZTFQQUNjYVBWU1BXUGNHeDJuYkVjUzM4?=
 =?utf-8?B?TnFOY2ttT2Y3c1grQjB4RXZyRjhuMmczeW5kK0c1aUsybGMrMlJwMG4rYlA4?=
 =?utf-8?B?bUxub2M3d256YVlqU1ByYTJScUZQRngxM1ZubEx3TCsxSWttTGwrcXptT0Ev?=
 =?utf-8?B?VlBrdXdiUDJYcXB5OEFyTnFabDdTRTlNUHk4VURNZmN6Ni83Y21BTEVqNkh0?=
 =?utf-8?B?djdCbTAwUkU3TzMyVmswTktFWHF6LytyaU12ZFJpZ0NpL2J6cUMwdVFMRHVS?=
 =?utf-8?B?dlZvV0xkZVZTNnhUVkU5MFZ4WSs5Z3h6Uk1veG5wUG1Vc0tCMVlEZmMyZVZL?=
 =?utf-8?B?Z3lyQkpVQm9tV2ZWZDhoMVdZNzdFQWsvdmxRTmFmakJmMzN3SW9TNEt5SU5v?=
 =?utf-8?B?Wjh0cWUwWmxIaDZEUTd0SFpHOU43UTlVa3l5eTB0VkFuaVNUdWR5bVBpY2NH?=
 =?utf-8?B?cW1zK0xNSTk4V2lrMnRFcHVxMkEvaDRBcXRNMnRWTlNYVzIzU3cvODBoSVM2?=
 =?utf-8?B?bFBURXNmVHJDdk9MVS80RHNYc05jc2VyaWtTNzZBL2dnQkZYVjZyeFZWOVVt?=
 =?utf-8?B?UUVmSWVpdThGekNkSVZhNHd3d0k2SGRLT1VsT2w2cWtMdXdMUXdPV0E3ekFC?=
 =?utf-8?B?UUoyLzh2WVptSk82dEdVQXk5WE9rakpXeWkvVVk4ZEM3V3MycVlzWExrRkZU?=
 =?utf-8?B?NXFZZTRaMGMxK1Y3VCtzZFNWSTdyeENCZVNqRTNmeUcyQ1pGS2JGc3hZcWdC?=
 =?utf-8?B?OFM3cDJjeTF4Mnp5WDRqVnZlcDFrVGNaMDZHR3hwSHVBU0oxQkJQS2tqand5?=
 =?utf-8?B?RnZlZmFXUFN0cXNtSkx2bDVmZ2tGakNnUEJXbWlMUkF5VG9VTWJJSk4zRHN6?=
 =?utf-8?B?c1gxVitUZ0doY0FpRENwQUVnWDRILzBtcDlBV0k5OWVOdWhiZnhNSFR4dExn?=
 =?utf-8?B?NW1LYVUxTFZYYkpqSEpidUtOQVlGekhCTm44UHF4WkRmYnVzdXNEdHNxR0Vl?=
 =?utf-8?B?VUxGbitzVjlyQUR5YWRqZ2FGckpUSER2dnQ1M0VqR0ZNdnB1b29Ya2tSZkd3?=
 =?utf-8?B?dFBVQjFGSUw5TFF5REc0VjI4cHRiRlVrU1pUcTl4R2RBU09VYUhqQkNuQ1hR?=
 =?utf-8?B?RnlqRTNQbktMeUgvMjZKNjFGQU5GZFJNM2tRajF2NllBUURjeEsvQW9zUVFi?=
 =?utf-8?B?MHBaVDZaYy9HNUV6RGM0VDJ0L0xzK2JwSGRGb3hUZk14dDVML05VRUsyaWt2?=
 =?utf-8?B?YlpVazlXWFI0R0NtRHdyQ0duUG9SVlYrTVlJMzR2MHlCWFU1RzlUS0JRM0lY?=
 =?utf-8?B?bTFxRFN0S0sxRTQvckJ2OXRlUHpacUtnUTlxRmpycmU2SnUvVEFYdStPVDBH?=
 =?utf-8?B?MXhUTE9lYXA0SGZqQTI0ZkgxNk16dlk0NXZtd0lINkJwTnhTTXhwc2h2Z1Rv?=
 =?utf-8?B?aVNaZDJFK2EzQzI1U0VPZHRLaFZFK3FGZ3pWWWlnZjdabzdrTFJwY2p5bzF1?=
 =?utf-8?B?MnJ3OFp6WUtWN2JIMlRuZzZ3eUEvRWMzazRCU1lmL2I0S3R4eitlQmljN3Ru?=
 =?utf-8?B?bkdoZm90UU5pWnlVQ0pmaDJJT3A5ZnZTUWZhZmVveFVkNkd6RFZ5SzNRaC96?=
 =?utf-8?B?YWVtdUtrM0NGcmdkUmFMaW56NVVIRkJpN1BvVGZaeXA1ajlOWVJjTkM4b3pK?=
 =?utf-8?B?c3NmYm1ES1FrREMvajM4MFR2T2ZvanVtNUpDMHFMaE9KWGVweDg3Zk1BQnhx?=
 =?utf-8?B?Y2V5Si9PWnZpZDNESnlIZ2RFaGd1YTA4RW9UQ2FFUnZrNitTblFKQnlBMllw?=
 =?utf-8?B?QWl3TFc4RVVvM3ZwRHl0SEZ3VmJxTkZBWmduQ3orNXRMS015R1pBWmtUcnpw?=
 =?utf-8?B?Vnp2d2VVQ3licmIyV292UE5WcEc0ZG8zSkIvZnNrcW9Qc0ppVXBLNU9OQjVp?=
 =?utf-8?Q?pj2yiUUtFbdlrsfWhI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330bb5dd-8da5-491f-3116-08de891e32af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:53:12.6819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dwdcg92hWatkyv1TlHd90j36bNgalv7IsSzi8MK6yEezIWFdc7Ofa616YaU9ixVz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF922753E5F
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

--------------0rTJvb09yAhA61WmtTuT2ku2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-03-13 18:37, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> Current driver reports and limits memory allocation for each partition equally
> among partitions using same memory partition. Application may not be able to
> use all available memory when run on a partitioned gpu though system still has
> enough free memory.
>
> Add an option that app can use to have gpu partition allocate all available
> memory.
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 43 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 17 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  2 +
>   5 files changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 3bfd79c89df3..fc6613058af8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -805,7 +805,10 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
>   		} else {
>   			tmp = adev->gmc.mem_partitions[mem_id].size;
>   		}
> -		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
> +
> +		if (adev->xcp_mgr->mem_alloc_mode == AMDGPU_PARTITION_MEM_CAPPING_EVEN)
> +			do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
> +
>   		return ALIGN_DOWN(tmp, PAGE_SIZE);
>   	} else if (adev->apu_prefer_gtt) {
>   		return (ttm_tt_pages_limit() << PAGE_SHIFT);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index cab3196a87fb..e202ba1eadce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1580,6 +1580,40 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
>   	return count;
>   }
>   
> +static ssize_t amdgpu_gfx_get_compute_partition_mem_alloc_mode(
> +						struct device *dev, struct device_attribute *addr,
> +						char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	int mode = adev->xcp_mgr->mem_alloc_mode;
> +
> +	/* Only minimal precaution taken to reject requests while in reset.*/
> +	if (amdgpu_in_reset(adev))
> +		return -EPERM;
> +
amdgpu_in_reset check is not required for this get and set sysfs 
interface because this only change the
  memory alloc limit and available memory size, with this removed, this 
patch is

Reviewed-by: Philip Yang <philip.yang@amd.com>
> +	return sysfs_emit(buf, "%s\n",
> +			  amdgpu_gfx_compute_mem_alloc_mode_desc(mode));
> +}
> +
> +
> +static ssize_t amdgpu_gfx_set_compute_partition_mem_alloc_mode(
> +						struct device *dev, struct device_attribute *addr,
> +						const char *buf, size_t count)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	if (!strncasecmp("CAPPING", buf, strlen("CAPPING")))
> +		adev->xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_CAPPING_EVEN;
> +	else if (!strncasecmp("ALL", buf, strlen("ALL")))
> +		adev->xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_ALL;
> +	else
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
>   static const char *xcp_desc[] = {
>   	[AMDGPU_SPX_PARTITION_MODE] = "SPX",
>   	[AMDGPU_DPX_PARTITION_MODE] = "DPX",
> @@ -1935,6 +1969,10 @@ static DEVICE_ATTR(gfx_reset_mask, 0444,
>   static DEVICE_ATTR(compute_reset_mask, 0444,
>   		   amdgpu_gfx_get_compute_reset_mask, NULL);
>   
> +static DEVICE_ATTR(compute_partition_mem_alloc_mode, 0644,
> +		   amdgpu_gfx_get_compute_partition_mem_alloc_mode,
> +		   amdgpu_gfx_set_compute_partition_mem_alloc_mode);
> +
>   static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
> @@ -1955,6 +1993,11 @@ static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> +	r = device_create_file(adev->dev,
> +			       &dev_attr_compute_partition_mem_alloc_mode);
> +	if (r)
> +		return r;
> +
>   	if (xcp_switch_supported)
>   		r = device_create_file(adev->dev,
>   				       &dev_attr_available_compute_partition);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 720ed3a2c78c..afcc98d26f45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -71,6 +71,11 @@ enum amdgpu_gfx_partition {
>   	AMDGPU_AUTO_COMPUTE_PARTITION_MODE = -2,
>   };
>   
> +enum amdgpu_gfx_partition_mem_alloc_mode {
> +	AMDGPU_PARTITION_MEM_CAPPING_EVEN = 0,
> +	AMDGPU_PARTITION_MEM_ALLOC_ALL  = 1,
> +};
> +
>   #define NUM_XCC(x) hweight16(x)
>   
>   enum amdgpu_gfx_ras_mem_id_type {
> @@ -676,4 +681,16 @@ static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
>   	}
>   }
>   
> +static inline const char *amdgpu_gfx_compute_mem_alloc_mode_desc(int mode)
> +{
> +	switch (mode) {
> +	case AMDGPU_PARTITION_MEM_CAPPING_EVEN:
> +		return "CAPPING";
> +	case AMDGPU_PARTITION_MEM_ALLOC_ALL:
> +		return "ALL";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 73250ab45f20..389f69c7d5c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -181,6 +181,7 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
>   	}
>   
>   	xcp_mgr->num_xcps = num_xcps;
> +	xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_CAPPING_EVEN;
>   	amdgpu_xcp_update_partition_sched_list(adev);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index 8058e8f35d41..878c1c422893 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -132,6 +132,8 @@ struct amdgpu_xcp_mgr {
>   	struct amdgpu_xcp_cfg *xcp_cfg;
>   	uint32_t supp_xcp_modes;
>   	uint32_t avail_xcp_modes;
> +	/* used to determin KFD memory alloc mode for each partition */
> +	uint32_t mem_alloc_mode;
>   };
>   
>   struct amdgpu_xcp_mgr_funcs {

--------------0rTJvb09yAhA61WmtTuT2ku2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-03-13 18:37, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260313223735.3391865-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

Current driver reports and limits memory allocation for each partition equally
among partitions using same memory partition. Application may not be able to
use all available memory when run on a partitioned gpu though system still has
enough free memory.

Add an option that app can use to have gpu partition allocate all available
memory.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 43 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 17 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  2 +
 5 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3bfd79c89df3..fc6613058af8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -805,7 +805,10 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 		} else {
 			tmp = adev-&gt;gmc.mem_partitions[mem_id].size;
 		}
-		do_div(tmp, adev-&gt;xcp_mgr-&gt;num_xcp_per_mem_partition);
+
+		if (adev-&gt;xcp_mgr-&gt;mem_alloc_mode == AMDGPU_PARTITION_MEM_CAPPING_EVEN)
+			do_div(tmp, adev-&gt;xcp_mgr-&gt;num_xcp_per_mem_partition);
+
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
 	} else if (adev-&gt;apu_prefer_gtt) {
 		return (ttm_tt_pages_limit() &lt;&lt; PAGE_SHIFT);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index cab3196a87fb..e202ba1eadce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1580,6 +1580,40 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 	return count;
 }
 
+static ssize_t amdgpu_gfx_get_compute_partition_mem_alloc_mode(
+						struct device *dev, struct device_attribute *addr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int mode = adev-&gt;xcp_mgr-&gt;mem_alloc_mode;
+
+	/* Only minimal precaution taken to reject requests while in reset.*/
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+</pre>
    </blockquote>
    amdgpu_in_reset check is not required for this get and set sysfs
    interface because this only change the<br>
    &nbsp;memory alloc limit and available memory size, with this removed,
    this patch is <br>
    <br>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20260313223735.3391865-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	return sysfs_emit(buf, &quot;%s\n&quot;,
+			  amdgpu_gfx_compute_mem_alloc_mode_desc(mode));
+}
+
+
+static ssize_t amdgpu_gfx_set_compute_partition_mem_alloc_mode(
+						struct device *dev, struct device_attribute *addr,
+						const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!strncasecmp(&quot;CAPPING&quot;, buf, strlen(&quot;CAPPING&quot;)))
+		adev-&gt;xcp_mgr-&gt;mem_alloc_mode = AMDGPU_PARTITION_MEM_CAPPING_EVEN;
+	else if (!strncasecmp(&quot;ALL&quot;, buf, strlen(&quot;ALL&quot;)))
+		adev-&gt;xcp_mgr-&gt;mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_ALL;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
 static const char *xcp_desc[] = {
 	[AMDGPU_SPX_PARTITION_MODE] = &quot;SPX&quot;,
 	[AMDGPU_DPX_PARTITION_MODE] = &quot;DPX&quot;,
@@ -1935,6 +1969,10 @@ static DEVICE_ATTR(gfx_reset_mask, 0444,
 static DEVICE_ATTR(compute_reset_mask, 0444,
 		   amdgpu_gfx_get_compute_reset_mask, NULL);
 
+static DEVICE_ATTR(compute_partition_mem_alloc_mode, 0644,
+		   amdgpu_gfx_get_compute_partition_mem_alloc_mode,
+		   amdgpu_gfx_set_compute_partition_mem_alloc_mode);
+
 static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev-&gt;xcp_mgr;
@@ -1955,6 +1993,11 @@ static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = device_create_file(adev-&gt;dev,
+			       &amp;dev_attr_compute_partition_mem_alloc_mode);
+	if (r)
+		return r;
+
 	if (xcp_switch_supported)
 		r = device_create_file(adev-&gt;dev,
 				       &amp;dev_attr_available_compute_partition);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 720ed3a2c78c..afcc98d26f45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -71,6 +71,11 @@ enum amdgpu_gfx_partition {
 	AMDGPU_AUTO_COMPUTE_PARTITION_MODE = -2,
 };
 
+enum amdgpu_gfx_partition_mem_alloc_mode {
+	AMDGPU_PARTITION_MEM_CAPPING_EVEN = 0,
+	AMDGPU_PARTITION_MEM_ALLOC_ALL  = 1,
+};
+
 #define NUM_XCC(x) hweight16(x)
 
 enum amdgpu_gfx_ras_mem_id_type {
@@ -676,4 +681,16 @@ static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 	}
 }
 
+static inline const char *amdgpu_gfx_compute_mem_alloc_mode_desc(int mode)
+{
+	switch (mode) {
+	case AMDGPU_PARTITION_MEM_CAPPING_EVEN:
+		return &quot;CAPPING&quot;;
+	case AMDGPU_PARTITION_MEM_ALLOC_ALL:
+		return &quot;ALL&quot;;
+	default:
+		return &quot;UNKNOWN&quot;;
+	}
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 73250ab45f20..389f69c7d5c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -181,6 +181,7 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 	}
 
 	xcp_mgr-&gt;num_xcps = num_xcps;
+	xcp_mgr-&gt;mem_alloc_mode = AMDGPU_PARTITION_MEM_CAPPING_EVEN;
 	amdgpu_xcp_update_partition_sched_list(adev);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 8058e8f35d41..878c1c422893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -132,6 +132,8 @@ struct amdgpu_xcp_mgr {
 	struct amdgpu_xcp_cfg *xcp_cfg;
 	uint32_t supp_xcp_modes;
 	uint32_t avail_xcp_modes;
+	/* used to determin KFD memory alloc mode for each partition */
+	uint32_t mem_alloc_mode;
 };
 
 struct amdgpu_xcp_mgr_funcs {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------0rTJvb09yAhA61WmtTuT2ku2--

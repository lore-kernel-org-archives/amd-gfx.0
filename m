Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14404FF8875
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5EE210F24A;
	Thu, 30 Apr 2026 07:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F0ikFd2k";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C9710F274
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 07:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayFKgVUyqPzabZZveRYPCGAekBPoWFAQot97OJjg7apq+vQwa52JW46ebDXMahuq3mJiAoEdn2EUEfqUcn+n+DTjDjYaTuPxoeLb1GGPel8/PdmhcieVKcdofTpnk/3bRQR0DfQZlrdRXEdFKUuTgsc5oXgkr+GMfN2AeX2aHh5CZTi2EaBNa2qODrWHWvQ5GvhAcsdi8oBSUl7G62g/wqjliFVwu5n9pdRiqaKpyl8xrQseTnRE03HU2QYG1uNE07/QNkHIf1IqWGuMf3gqjodn7PCsG/8WHNF8mZYV0TeBWJJiHtVZ+ULGxwgdmb1nE6aJPu4BBr/Q9MAHp99giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXtMvW9JS2qtW5YpVU6uN9DIC/ijKT06qPNT51EvjmM=;
 b=Sxoxnig+nhsGNPhQKDhVKD4Ci1aZGFhIpB5Rh9LTbK+CFAleTBK1vqJFwnF3e7EtZlVkrasYsBIFbB2YZdxWjhrPZHdhOczCtYLAQHm5pI5UyLebcz/4XHdbq+R32tgmJGb1OvRNWlK6qVhLFsaeKgXhJhZMBwbYmV+ZBP38Ob38qp6MTRQNyC84RuTcsZv/GxByEwLiRol7jTEF9Z9T35icfsD9Ze+mWIoRX0uvg+coldx46spLjdU3i5Lu/E57OPxcEbZYiSG86NXM5MM4onY1i3YCv/K3o9TMJESTOirM/SeHZDt8K09i/NA3xBMacCrIwXuktsvGBGcUhVQ0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXtMvW9JS2qtW5YpVU6uN9DIC/ijKT06qPNT51EvjmM=;
 b=F0ikFd2kLI0eNV0m7RBm5Ga22vyl5l9uQQs20Eoa6xWw8Oh3LipO8GROAUA7RurOwi0xModjAphWqsYTtNIFnAKS+tCXOp3ZNgLLJyfPrWvKuJYPf8YtD4dwqDIsm40cfh2FjyeOZdSZqRWBGDp9ZibyKFHILsY4e9dUMzSZGVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 07:38:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 07:38:20 +0000
Message-ID: <3635373c-7ace-4b8d-ac7a-c478607bd99d@amd.com>
Date: Thu, 30 Apr 2026 09:38:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Use helper to set gart size
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
References: <20260430055527.4026042-1-lijo.lazar@amd.com>
 <20260430055527.4026042-2-lijo.lazar@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260430055527.4026042-2-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d944cc3-a94b-4b7f-2416-08dea68b7381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 62RPmqsDySFOYJHXzOkalyU3908UJ7Dh+gphHyum0eRAIuL6iYKRBA7fp/34XmX/tTMcvO8V00P7U6il97KJqVm+fvtLkLAUjfx7WKMwa/wHlleefW+R/cTjEJVbHtvD2Pg1sPU0v75pHFY5hRCSsazMcCxjs9q9FmB02KOHKrk+dcFP6s41l6bKWt+2y1jybQ+w/4aUj/A9j//Vh7QMXfn/C0aGi+EHyliGHG9Lm1uTu1KoDjH9VAqgtSglrreEFH4Cuxl+UPyubgLzc2GK1aFKhFqTTDdzSCNN99kEdVD/W3GK0p1q+OyvACzl4q6rqVxI24MPEZF04u+0hfahlfwgsVXgV+uD4o1NHOVgz1/w0NGtlTJPfZNHsVUZb5Wq0yzePqmQ1S8zVnrfNE7l1PRi+UfSOuPRVbaF7jg+2fHUKITHEtgQJstvZu96xAM8apcqCxPOe7kIX7nC5NKhlggxh6xz4mSZz0EMHztORYtT0UCPGZNnVCJbN3+fLav39hItIjfCZTbUpqkApMrDFHbDvGRHaZYYwbSQ0geDLfAvMuocEwdZUKAjJw1T5Ov5E4bAuegK+6UAv8jt50NuIjhwopPvoeNFK0vBUpWjxwjHmksn92C8nQSGYP9jHOnRr+3/xPAlbjSucpWsYJPLB5SwayByU3JiQEukmEcUy4FdAbirLrcibMjW68ESQF1MC7MtNuXGr4OBftS28r7rNMOU95GSqu2nHyqLvsCCYDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHY3ckxSc2RUeHE3VVgzc1d2MFVpRTJ6ck9VUk9VZHJzT0phMFYwTXNLOFFS?=
 =?utf-8?B?Yk44aEU5NGwzMllSL2twOUI4c01PN0pERnY2ZVh2R09kRUlxWllwU0VjUDhK?=
 =?utf-8?B?YVFSYWFzQ2xvUStCaWZrWm5oNUxFanNRQnhZb3V0OWtoNnhRMXpFTjdrd0RL?=
 =?utf-8?B?NWpFQkF4bUhZOHFMZmxMd080NjY5RXZYODZVUSt1NW9yTkFJQ0J2TENvd055?=
 =?utf-8?B?SFI0VWlTNlhhUGdKMkZkcVZIcmtFckZhd2kxd1A1VUFWZ2M2ZTFyZEtyaTdv?=
 =?utf-8?B?czczSkhncDh1cDRzbjk4dDlpejRlczBNQ3ZFUzBpd2JrcURNeXkyNXE1bk9l?=
 =?utf-8?B?WFJVeUJLa202ZEd5dEM1aWhsVVUza0ZBb1p2cUVITU9OWFlGeTUyM0RJSFdO?=
 =?utf-8?B?QU13ejdxWEdDLzdHdUJ2LzNFQ2lKbk42RXoyTU43dkgrM2YvTnZ6WkFnM3V1?=
 =?utf-8?B?OHJqR0F0bUducU01Zkg2aVFIM0YxdEduRnNMc0NTYU9ZSngreTNXb3BOWUYz?=
 =?utf-8?B?TDVabGVrbmV6YXRaaWROVndyNjAxQTczWEQ5YVZYTkhISnVuSXJwa0NDUU9O?=
 =?utf-8?B?ekpkbXFPSzA2bksvQmVOeDRDOXJyamlqRUV3bWZjN1lDbURIN1JvSnM0U2ZR?=
 =?utf-8?B?WTUyZWFCajI0aTlEa3dINVNVUk0xUk8yNzhta1cyNUNMcmFhbzVaQXJRZEla?=
 =?utf-8?B?Vi9icUZ1SjhXMnBLNm9lcHZtdUNRbVlKK0pYODdiNy9aVnB6ODhLZWgxMUR4?=
 =?utf-8?B?L1R0cTg2SGI5OHhEZmcvYSsrWDBmdGRkcHdEZ0orYWxJRkV5ZU4xeHV5eU1r?=
 =?utf-8?B?d013QzVrdXc0WTNjcFhIUUh3RGFMdDQwYVBWNTNCc1JOWksrcUJsaGRuS1ha?=
 =?utf-8?B?S0U1T0lOdCtJZS9wa0lGZjljTHlDQmFDMTZrZlhtZXRWS0tPWm14UXkweDlJ?=
 =?utf-8?B?b2ZJVEgxY09mSFc5OEdzdUtMQUkzaEtQWEN2RVlhQzJyZ3hMMlUyR3lIQkw0?=
 =?utf-8?B?RVczQzFncTdkeFBCQUtrM0E0ckdZOGEzVW5lLy9NL3Q4aFJoSWZMWGJGNlFT?=
 =?utf-8?B?ZHcrOWRhTkRjNkIycmZGanJMMDdNQlIwZnVWZmtmemVXZGdRcmpYeXFlWUFN?=
 =?utf-8?B?KzkxN2MycDVIWmY4bS92N2w3cllpMHJPNWtnMDVVazU5MVRqbzJWdGhLZXpq?=
 =?utf-8?B?VDJ4WE5Qei9kSVZRVmUzeEovQTRIeVZsOTh4TS9tUDJrd1A4Uk9TQTRwUytk?=
 =?utf-8?B?TjNCWFg2UDlyWDFldXhjd0VWM2J6RDV0RnlGS1JjWUdWTTc5VVB4SWI2VXpp?=
 =?utf-8?B?TThiekNKWW1TQ2xsSm1VQ25SelRjWnBHU1RQZW1EalhYVUpTdW1LNGZLUGJO?=
 =?utf-8?B?YWdNL3BJRzlITVFOaDNVcytna3ppMVlWR2h3OFlYemJzc0lRa2dkUGlxaFk5?=
 =?utf-8?B?UDlLeGlSNDhBVmNjM05HY1BXSExwZlRmYTkyZmlsdEd1L1FNN0FyaUM3UTBn?=
 =?utf-8?B?Wmx4YzdCcjArdlNIWW8xZThOV3JZRklkbEk4WTlGVmF6R3JxWVAvL05uT25U?=
 =?utf-8?B?QitzOGM5dkFIUWFKN1hOeUwrMU9yUW9zRTlZa29ubHArOFI0OUlZTVVQSEEv?=
 =?utf-8?B?MmlRVTJ4T2FVYWltR0ZWRGsrTE42SVE5Wm1hN2p2S3loeWZaYUs3blo1dVpY?=
 =?utf-8?B?aEZMMERpdTIyazNRYytwblNwNUhteHozUmVCVmt5YjRtcXl6cnFqR3h0WWRU?=
 =?utf-8?B?emhJdmZ5eVFLY2t0a0dJY2J4VFVhK2FUSm03VUVSOFhHK21ZY250ckMrdUFP?=
 =?utf-8?B?MUVvV1dnQ1U5K3NXSTM3VERmYnBjQUZqZUVhbHhZL3lUY2hFbnJqQk9ZWWtB?=
 =?utf-8?B?cUdnTm94cE1rMXNsNEFJMGE0RE9FN2pLMlBkUWZ6WWc3MlRGTll4ZUNGUktS?=
 =?utf-8?B?MFBtYmhYT2VNQVVnV0NhT2Qrei9UN3oyTUd4dFY0eXUrN2tZYWx5VDdZU3la?=
 =?utf-8?B?QTdsclJRY3ZReHRSbHdqb2dNQ1JqMVRZSm9XSTFObEJMa3lzQk1oOVhUaEtI?=
 =?utf-8?B?cXlqakdRNXBEeGdFTFgrbmJqeEZ1emhGcjYyUjFTUDh0Z2swbTlGU0R0Sk1r?=
 =?utf-8?B?V1ZVWks2TFFCY0d0ZkF2Y2VuS2tQc0VuRVoza1N6QnUyOFVaU2M1QmJPNUZY?=
 =?utf-8?B?emlWbWM5Wi9hdE1WRWs1a0drNmRhcmRZbXYwRmdOUjQvV1hGZGtvVnlvZ1pt?=
 =?utf-8?B?K2gzczd5VXJVOWJmdm9uNFhHM0dEZ1luNGdnYnEweVlGdXZyaWRvZjRDNzFR?=
 =?utf-8?Q?P+9W7q6vb98hYqq+j+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d944cc3-a94b-4b7f-2416-08dea68b7381
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:38:20.3498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYtBpzdyuGAK/Y9pQ4yZ3+NhxiLFaEdZcqGesm0lmpj5IGWbZBN7QZ7mEpMM+8Vc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080
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

On 4/30/26 07:55, Lijo Lazar wrote:
> Find the default size required and use the helper funcction to set gart size.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

I'm fine with how it is but could be that Alex says that we should split that into separate patches for each gmc file.

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire series.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 24 +++++++---------
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  5 +---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c |  5 +---
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  | 28 +++++++-----------
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 30 ++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 34 +++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 40 +++++++++++---------------
>  7 files changed, 66 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index e1ace7d44ffd..8523833a74fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -707,20 +707,16 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>  	adev->gmc.visible_vram_size = adev->gmc.aper_size;
>  
>  	/* set the gart size */
> -	if (amdgpu_gart_size == -1) {
> -		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> -		default:
> -			adev->gmc.gart_size = 512ULL << 20;
> -			break;
> -		case IP_VERSION(10, 3, 1):   /* DCE SG support */
> -		case IP_VERSION(10, 3, 3):   /* DCE SG support */
> -		case IP_VERSION(10, 3, 6):   /* DCE SG support */
> -		case IP_VERSION(10, 3, 7):   /* DCE SG support */
> -			adev->gmc.gart_size = 1024ULL << 20;
> -			break;
> -		}
> -	} else {
> -		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(10, 3, 1):   /* DCE SG support */
> +	case IP_VERSION(10, 3, 3):   /* DCE SG support */
> +	case IP_VERSION(10, 3, 6):   /* DCE SG support */
> +	case IP_VERSION(10, 3, 7):   /* DCE SG support */
> +		amdgpu_gmc_set_gart_size(adev, SZ_1G);
> +		break;
> +	default:
> +		amdgpu_gmc_set_gart_size(adev, SZ_512M);
> +		break;
>  	}
>  
>  	gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 94d6631ce0bc..16388e3caea3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -709,10 +709,7 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>  		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>  
>  	/* set the gart size */
> -	if (amdgpu_gart_size == -1)
> -		adev->gmc.gart_size = 512ULL << 20;
> -	else
> -		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
> +	amdgpu_gmc_set_gart_size(adev, SZ_512M);
>  
>  	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 5bdd4b9b7893..586703ec0dfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -765,10 +765,7 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
>  		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>  
>  	/* set the gart size */
> -	if (amdgpu_gart_size == -1) {
> -		adev->gmc.gart_size = 512ULL << 20;
> -	} else
> -		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
> +	amdgpu_gmc_set_gart_size(adev, SZ_512M);
>  
>  	gmc_v12_0_vram_gtt_location(adev, &adev->gmc);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index cc272a96fcef..af6944d2d330 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -328,24 +328,18 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
>  	adev->gmc.visible_vram_size = adev->gmc.aper_size;
>  
>  	/* set the gart size */
> -	if (amdgpu_gart_size == -1) {
> -		switch (adev->asic_type) {
> -		case CHIP_HAINAN:    /* no MM engines */
> -		default:
> -			adev->gmc.gart_size = 256ULL << 20;
> -			break;
> -		case CHIP_VERDE:    /* UVD, VCE do not support GPUVM */
> -		case CHIP_TAHITI:   /* UVD, VCE do not support GPUVM */
> -		case CHIP_PITCAIRN: /* UVD, VCE do not support GPUVM */
> -		case CHIP_OLAND:    /* UVD, VCE do not support GPUVM */
> -			adev->gmc.gart_size = 1024ULL << 20;
> -			break;
> -		}
> -	} else {
> -		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
> +	switch (adev->asic_type) {
> +	case CHIP_VERDE:    /* UVD, VCE do not support GPUVM */
> +	case CHIP_TAHITI:   /* UVD, VCE do not support GPUVM */
> +	case CHIP_PITCAIRN: /* UVD, VCE do not support GPUVM */
> +	case CHIP_OLAND:    /* UVD, VCE do not support GPUVM */
> +		amdgpu_gmc_set_gart_size(adev, SZ_1G);
> +		break;
> +	case CHIP_HAINAN:    /* no MM engines */
> +	default:
> +		amdgpu_gmc_set_gart_size(adev, SZ_256M);
> +		break;
>  	}
> -
> -	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>  	gmc_v6_0_vram_gtt_location(adev, &adev->gmc);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index fb5e33c8a5ee..93cf283191fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -394,27 +394,21 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
>  	adev->gmc.visible_vram_size = adev->gmc.aper_size;
>  
>  	/* set the gart size */
> -	if (amdgpu_gart_size == -1) {
> -		switch (adev->asic_type) {
> -		case CHIP_TOPAZ:     /* no MM engines */
> -		default:
> -			adev->gmc.gart_size = 256ULL << 20;
> -			break;
> +	switch (adev->asic_type) {
>  #ifdef CONFIG_DRM_AMDGPU_CIK
> -		case CHIP_BONAIRE: /* UVD, VCE do not support GPUVM */
> -		case CHIP_HAWAII:  /* UVD, VCE do not support GPUVM */
> -		case CHIP_KAVERI:  /* UVD, VCE do not support GPUVM */
> -		case CHIP_KABINI:  /* UVD, VCE do not support GPUVM */
> -		case CHIP_MULLINS: /* UVD, VCE do not support GPUVM */
> -			adev->gmc.gart_size = 1024ULL << 20;
> -			break;
> +	case CHIP_BONAIRE: /* UVD, VCE do not support GPUVM */
> +	case CHIP_HAWAII:  /* UVD, VCE do not support GPUVM */
> +	case CHIP_KAVERI:  /* UVD, VCE do not support GPUVM */
> +	case CHIP_KABINI:  /* UVD, VCE do not support GPUVM */
> +	case CHIP_MULLINS: /* UVD, VCE do not support GPUVM */
> +		amdgpu_gmc_set_gart_size(adev, SZ_1G);
> +		break;
>  #endif
> -		}
> -	} else {
> -		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
> +	case CHIP_TOPAZ:     /* no MM engines */
> +	default:
> +		amdgpu_gmc_set_gart_size(adev, SZ_256M);
> +		break;
>  	}
> -
> -	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>  	gmc_v7_0_vram_gtt_location(adev, &adev->gmc);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 963d5b0fa87b..1d3ddffd5a11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -585,27 +585,21 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
>  	adev->gmc.visible_vram_size = adev->gmc.aper_size;
>  
>  	/* set the gart size */
> -	if (amdgpu_gart_size == -1) {
> -		switch (adev->asic_type) {
> -		case CHIP_POLARIS10: /* all engines support GPUVM */
> -		case CHIP_POLARIS11: /* all engines support GPUVM */
> -		case CHIP_POLARIS12: /* all engines support GPUVM */
> -		case CHIP_VEGAM:     /* all engines support GPUVM */
> -		default:
> -			adev->gmc.gart_size = 256ULL << 20;
> -			break;
> -		case CHIP_TONGA:   /* UVD, VCE do not support GPUVM */
> -		case CHIP_FIJI:    /* UVD, VCE do not support GPUVM */
> -		case CHIP_CARRIZO: /* UVD, VCE do not support GPUVM, DCE SG support */
> -		case CHIP_STONEY:  /* UVD does not support GPUVM, DCE SG support */
> -			adev->gmc.gart_size = 1024ULL << 20;
> -			break;
> -		}
> -	} else {
> -		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
> +	switch (adev->asic_type) {
> +	case CHIP_TONGA:   /* UVD, VCE do not support GPUVM */
> +	case CHIP_FIJI:    /* UVD, VCE do not support GPUVM */
> +	case CHIP_CARRIZO: /* UVD, VCE do not support GPUVM, DCE SG support */
> +	case CHIP_STONEY:  /* UVD does not support GPUVM, DCE SG support */
> +		amdgpu_gmc_set_gart_size(adev, SZ_1G);
> +		break;
> +	case CHIP_POLARIS10: /* all engines support GPUVM */
> +	case CHIP_POLARIS11: /* all engines support GPUVM */
> +	case CHIP_POLARIS12: /* all engines support GPUVM */
> +	case CHIP_VEGAM:     /* all engines support GPUVM */
> +	default:
> +		amdgpu_gmc_set_gart_size(adev, SZ_256M);
> +		break;
>  	}
> -
> -	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>  	gmc_v8_0_vram_gtt_location(adev, &adev->gmc);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index aca7841173f3..ced0f3941863 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1731,31 +1731,25 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>  	adev->gmc.visible_vram_size = adev->gmc.aper_size;
>  
>  	/* set the gart size */
> -	if (amdgpu_gart_size == -1) {
> -		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> -		case IP_VERSION(9, 0, 1):  /* all engines support GPUVM */
> -		case IP_VERSION(9, 2, 1):  /* all engines support GPUVM */
> -		case IP_VERSION(9, 4, 0):
> -		case IP_VERSION(9, 4, 1):
> -		case IP_VERSION(9, 4, 2):
> -		case IP_VERSION(9, 4, 3):
> -		case IP_VERSION(9, 4, 4):
> -		case IP_VERSION(9, 5, 0):
> -		default:
> -			adev->gmc.gart_size = 512ULL << 20;
> -			break;
> -		case IP_VERSION(9, 1, 0):   /* DCE SG support */
> -		case IP_VERSION(9, 2, 2):   /* DCE SG support */
> -		case IP_VERSION(9, 3, 0):
> -			adev->gmc.gart_size = 1024ULL << 20;
> -			break;
> -		}
> -	} else {
> -		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(9, 1, 0):   /* DCE SG support */
> +	case IP_VERSION(9, 2, 2):   /* DCE SG support */
> +	case IP_VERSION(9, 3, 0):
> +		amdgpu_gmc_set_gart_size(adev, SZ_1G);
> +		break;
> +	case IP_VERSION(9, 0, 1):  /* all engines support GPUVM */
> +	case IP_VERSION(9, 2, 1):  /* all engines support GPUVM */
> +	case IP_VERSION(9, 4, 0):
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +	case IP_VERSION(9, 4, 3):
> +	case IP_VERSION(9, 4, 4):
> +	case IP_VERSION(9, 5, 0):
> +	default:
> +		amdgpu_gmc_set_gart_size(adev, SZ_512M);
> +		break;
>  	}
>  
> -	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
> -
>  	gmc_v9_0_vram_gtt_location(adev, &adev->gmc);
>  
>  	return 0;


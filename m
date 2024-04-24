Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D4FC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ABE51138DB;
	Wed, 24 Apr 2024 08:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j3K70v66";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D961138DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKTebAEKYcKtI8kNSyNzHTk97BeXWk4M4IfVPBEj7kEodEtiVj5gmwoLLsNZFmkPb3lgb4NJmixKhXy1YK8UoSZupwgsIAGmjf/1YYNJKpWTFzEt51kDJVPpIKZf4w4dLXiM/Nx7O+kMymbCSilWydY/Oq25kn8ysrkGc2Lxg5lvVLgUiPem/1KDBCttzeX3gfl0ptmUkxVp3aNSRH2CSs6iOv34UXzr4l9+Fpza20ivPDMqEJ7imO20wrjXrT80TFdAcype85lTxUv61rXajKGDctqOsz18lKKcN6Mh8fya+AEv1jqMbkH+4tPDO3yXFzdzc1Fwtg3L7St7HSAJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0oaU3LJCzUH2sDkBIcOGuhGd7zHlY8PftPIRtC1yMk=;
 b=IpCvralZN/fygxpJFf35fuN0UEGjLtF+pn/NC/T8pc7acha6a8hcjHpjNpzgdKAHdrkraWk1I2q/ULnLilzYp3mDoJ1n/evq7zrkhfjp+/WgAFD+EfwmzT5Op32EUwRQYZ9CT71/fMptBRge/InulMD/gQxMgxPvrH6LYLVuG1YT8TdQjvEG5egSUnZhDC6nSb04tgKyn6ZHTH12Qpy5wcfdT6tWvEUbjH1MpefJc4c7SDHwwin6UijRACte+9PP9jlICtQh/+sOx/QjuNGjUPQadgFakjq5+3KOCo55EqZtAQ1wKaqCwql4CFsaVrBy1hNEnvVWcZ3xk/mnAYaYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0oaU3LJCzUH2sDkBIcOGuhGd7zHlY8PftPIRtC1yMk=;
 b=j3K70v66XRTNAdptin29BK101ap+gE9zN7hBlUQ9p7isNXKlE7LYboOM4sE1oKGUY3ZzYxUOdWvRPg8ojjMcYwGiv+RkXlNg48cxWIK2yUb4R2ISPFd22/YG5V+QBfFPfuQDnKX2sRabAPooKsu6vifapbM0QR89//fceLgZ7GU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:06:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 08:06:25 +0000
Message-ID: <b1b54cfc-7924-4df7-aa2d-e0ae7e6b0773@amd.com>
Date: Wed, 24 Apr 2024 10:06:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix some uninitialized variables
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com
References: <20240424011940.723906-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240424011940.723906-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ecc87f-29e8-44d7-9bf8-08dc64356fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVRYSEYrR25PcnFIcndNV29zUVNIdjF0R3VqcnZocCtBUFpXRk8yZkZEREdz?=
 =?utf-8?B?WURCZ0hwRzZ3L0oyOU5Ca2xlWjZvb0VlY1RlZTdOdEp5c1dLRUoxSk90Um9O?=
 =?utf-8?B?SHEwOUFQN1BGczgvdDVPVHFWNEI1Y3YwR012ZUZHWG1tU3ZmSWRvWG1YTDY0?=
 =?utf-8?B?NHQ4NDNBcjVwWTdOK0xEbmxIeDJiK1FYa3pRVlFacWtBZ0k4RXRjTXlCTjRu?=
 =?utf-8?B?d3NpUzZIUWR3UUZONEwzRnhDTys5am9NbnN1WDZRdWVPaVBaeW9DRGtmQ1dy?=
 =?utf-8?B?V1BqQ3AxcXp2eU1qQ01jdkVXVmUwNGd3WEE3UElvU09vT3doMlNXaXBpL3NY?=
 =?utf-8?B?ZFdDVzJTVk9PVU1xOE1KZ0FwUHJpSlo4VkZRTXVyUnhESnlnMlVvUGJJWUN3?=
 =?utf-8?B?bGRwM29kbkh0MWRieUdpK01sSEdjYmpUcjRJeGdBK3ZWQjJFeXZhb1FKMHNl?=
 =?utf-8?B?V2g2Qmw3VUk3cGwrNUpOY240UUQvV3JEckVzNFdKejAvbnMxemNSWTZoTVV0?=
 =?utf-8?B?Y2p3R1ZzNVpYaFdXVmdBSUFmc2U0WlVPdXhWZG91VmtkcVIwSEhKMUdFWUMr?=
 =?utf-8?B?WUcvRW90Z2lMWncvRURiOTdvb1pPeFhsendHL0xITnZmNk0yOStFZEtOWHF3?=
 =?utf-8?B?THdOc0Z2cDIrektJMkpZdnluWjBWeDJ3RGgrZVFOK0syaCtPY2g3WjRQaUhy?=
 =?utf-8?B?d2tleUhKdTFZOXFMRG9lRVBsQXRuclcrQkZYQnVNbGJrdWpuamd4ZlN0a2ZY?=
 =?utf-8?B?bnVEMVhuT2k5eGZ6THRweTd0MSthMGJHcytoSkRkYXdISGhzZVh4WDk4RFNF?=
 =?utf-8?B?bUxCcVcvUkJBUGZ4ZkhqOTNuWEdnZkpBOVJiNVVQNWpqajNGSDR1RVRtak5w?=
 =?utf-8?B?d0UwZ255R0xyY3RhY2lkaHF1dkkybDRpTFdYVUtIRDYwcEp2NkEwQjhINyt0?=
 =?utf-8?B?bEFkUDF4OGdMY1FjaTZMbldiak4yNlVGeVRRc0pBdm5YcFBDbmlwdG1wUHlh?=
 =?utf-8?B?QUNFWXRyWWVEemx6VUN5TFBXS2pIeHp3MzY1aFN2OWpKbFZ1V0RrRGkvbHRh?=
 =?utf-8?B?T25lMWdrMUhkT0xiZWNsNDRGYzFzbXRaYTdzcWw0QnlrVTRrWi9tWk4xMHZO?=
 =?utf-8?B?bUU5RFc0VHpTSFlhcXZzSE42MnA1am5tb1hrKzZRL2NoUEJBNlY4ZytyOUdZ?=
 =?utf-8?B?UTBaaXZ5SEtOeUNtWUcxcXlQUEJnUndWYnV4c0NRUDZVRHZtTFpBblNkZzBr?=
 =?utf-8?B?U25vYjEvaXovYlhVWm11WDRBUUhoZXlDbTBKdko1SFI3U1crY2ZadHc5UDVQ?=
 =?utf-8?B?Ym5NNkxDR1p6NEl0NUliSHpHNWZ2ZW03U3ZNM1NMUjJyekdNWlpmcjJ6Lys4?=
 =?utf-8?B?Qkx3U1NnUmN6U282YVdaRmwxMTJ1Vy8wbGI1ai8wbmVWRmRxOEhDTk01ZkZ4?=
 =?utf-8?B?cHg4U0FyczdjVVNTdE95OTBNUmRBTURSMTc2YTZiZmJJeXBNNmxtNzlvT29l?=
 =?utf-8?B?TlR5WDcxUktZTE55Z3F5R0pnSDlyMEJaS0EwZmRpblFuNjhwM1U3WEZFcS92?=
 =?utf-8?B?S3RsR2R3VTZ4V2FIem1NdFErdG1Fd2tFbkp1UThhK29NRHllU0dmWlNGQlYr?=
 =?utf-8?B?RHN0ZWhYbDlvMW42MXNGeC9KcERDbXIrcjdTbjVMRXJ3aWlKMU9CYkZmUVB2?=
 =?utf-8?B?YisxV3cxVFJQamlRUFJJd2VzZmFCaThrTnMrOGIzRjNxVjE1NEVLN1ZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVpIT0lMaFlpeWNVNWxWOStRd1NLb3RIT3BGajZuUEU1V3pLOVJBSThWMzVq?=
 =?utf-8?B?eVZoWlliSDMzT1I0TDc0c1czY1lSdU5BMWlxZFJ1cVhVWURYVm5qM1FxTjZ2?=
 =?utf-8?B?YUF4MDF6ZDdEVHJmNGs4cTFpaUZlRUlRZTNKdlNpcndMYStVVmlMUmMvWklT?=
 =?utf-8?B?dlFSakRVU0Q0enNHSGtWSS94WWxabkwvMGtjVmdXYVFiN0pWUjZLWHlhUnhj?=
 =?utf-8?B?em1oU05rR0t5SUwyMU8vNXRNNDBJZVJWckVnNXRyNStzRnR3UU0wYWViaXQ5?=
 =?utf-8?B?Z3pSUEJKOUtMeGxwc1k0SDZTUitIdE43K2dmektEUERwckVLOTY2N0VhYVFF?=
 =?utf-8?B?MXRUdUwwNzBWb0dvZzdMa0ZIaVZCdEJ4VnZlcS9aTFYySTFPSWhZZmVuYkdF?=
 =?utf-8?B?TUtrUHViZktwaTI2Tkplcng5eDZPWmZHZXpjQTRTckVuakFhSFhrOEV6MUJM?=
 =?utf-8?B?WHdjZHgyd011MkJNd1EvNTRNRVNibFluZW14L0tocER1Ylhka2VHeFpBNzR4?=
 =?utf-8?B?SlFPbEYrMGVyMG1kY082aFJ0MU50bWRmQlNLTXlJNm5zLzliVDhsVUt6VXRS?=
 =?utf-8?B?NWttSHBla3JmTG5sM1FZVDJ6S3ZLZmNwcWxnTkovS3RTWmVtYVVBb0t3eDZi?=
 =?utf-8?B?eDhmakFaVU45dHZGV1hXQldCY0JHT2RqZDBsY3dJK0JLeXhCMWxJYlBTYmxI?=
 =?utf-8?B?TmE0RFU4ZzgyenFoNzlrdnJKOURDTWRIY0xUc1dmY29GUitUKzY5U3RBdmhF?=
 =?utf-8?B?Nm5SWVcybDRyNmNKQ2FhRDk0MlFhSERZME85VFA5UEpUNmcxWW5YMm81TjZn?=
 =?utf-8?B?SjNnM2hYeWV2MlRVNjFHdWViZDVPTUh3TG40NmttV0h0YTFLa1ltTzdvUFN1?=
 =?utf-8?B?QXppenZIVXkwcWR3bE14Q2c0Z01XZGVBUVBYeDJlb0tMSUx2Tlc3d0NDTDFS?=
 =?utf-8?B?VUFhOW4vK1kxM3ZrSnVCVFBNdzd3WndKSjFpSGFGS2pXSWJpSHU5OXdoRW9W?=
 =?utf-8?B?UHFKR2NtbHVqb01JVHlLUEN2cXc3MDlSYnhaU0NLQzN4eDBub3Y0Y2J4aDBr?=
 =?utf-8?B?V1JkZGpuaDBEaWk4Q3VQUkVLMnZFTzhveEhHWHV3Q0hua21YejMrc2NmQnJx?=
 =?utf-8?B?YS9oYUVtRmZPWUlhWEtQUHQ3eFNuQldGeUlRdThDMk5MWkZzL2ZqK2wvR0dh?=
 =?utf-8?B?dW5NMU1jMjVFbG4vOXdmTjlVbFNsN1lBVmMzdzVYUHI0WEVac0xFU3pkMldV?=
 =?utf-8?B?R3A3Wk9JL28ydWowcVRSMXVIVXRmc0EvYjkwNzdNY0hGYm9oZTRJZnJOSmlS?=
 =?utf-8?B?dFhiaFYwWTQ2YlZIcUhzS0crYU53eU52WXZyNVZHM3FNYWxtYkU1RE44cS9S?=
 =?utf-8?B?YUwva0Z5VUlHUm4wZzJ1M2NmTmpQdU5udFZtek1KTlRsZ25VUXRYSXBHa2dC?=
 =?utf-8?B?QnRlZHBTcnEveFlJRGtFMnFVV2hubUo3cWRyVXhqTmgyOG5DRzFXWFIxSFho?=
 =?utf-8?B?ZXZmb3RObnplZngrcU5nalRnVFlabDU4STFPQzluaGMvQUhicU1iTzZYb0ZH?=
 =?utf-8?B?OWtlT0JreXNDSFJJV1N5d0VXNDRZOVU1SWJzWDNldFlIc09sWHZrcU9FZUdh?=
 =?utf-8?B?NHZPZCtGRmhXY0dUaXp4L2JkaXBheHRmWkxOcXc0Um9qUGx6cFB6bDhtUFJy?=
 =?utf-8?B?TUdVV2wyZVo5Q3RBUHU4WHNRWExLSHd0bkxoWHFZaDhVaEN3eGtDQm84dkFV?=
 =?utf-8?B?ZjhvTHRDbklqV1o5Mko0c1NXR1hVTHRxeTEyU09IbFIxajB0M2xFQUVvYjFI?=
 =?utf-8?B?RjRDMC96cndSWlNkd21ta21JaTN3RWRxeVAxTVBLeWZKK1Z2Vnl1TURRWnp6?=
 =?utf-8?B?bWE1ckQvd2tLUk5QNWovTW5JM3A3QjdxQTRFQlp4Q0srbWliaEVoTUwxcjlv?=
 =?utf-8?B?cjN5amVEU29GUlgzNmtEUXBwNGZJdE9zTXF4Q2FYT0RWYW4vYzdBQTVQMmF2?=
 =?utf-8?B?WU5rWk9XN1UxSXUxMjlLWmVkY0NiaGo5YjZQMkFydDYwV3R4WmZSMERyZ0Fl?=
 =?utf-8?B?L2c5RW1hamQ0Q3Nvc0V5d1RkWWFKNVl5Zks0OGl0WUZCcVVnTUgvNDJRKytE?=
 =?utf-8?Q?XWJGPMk8R1pJTlfr6zbJQiqXy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ecc87f-29e8-44d7-9bf8-08dc64356fcb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:06:25.4726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEFw79KHH2U2ksOodQwjORSWKg4EiuiFzs0lTso+AiMNRLth/wOVi3X3wHA9FedA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
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

Am 24.04.24 um 03:19 schrieb Jesse Zhang:
> Fix some variables not initialized before use.
> Scan them out using Synopsys tools.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++++
>   drivers/gpu/drm/amd/amdgpu/atom.c       | 1 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c  | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c  | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c  | 3 ++-
>   6 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 59acf424a078..60d97cd14855 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -742,7 +742,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
>   	uint32_t destroyed = 0;
>   	uint32_t created = 0;
>   	uint32_t allocated = 0;
> -	uint32_t tmp, handle = 0;
> +	uint32_t tmp = 0, handle = 0;

As far as I can see that isn't correct. tmp isn't used before it is written.

Is the tool maybe broken?

Regards,
Christian.

>   	uint32_t *size = &tmp;
>   	unsigned int idx;
>   	int i, r = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 677eb141554e..13125ddd5e86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -410,6 +410,11 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   			else
>   				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   
> +			if (amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec))
> +				new_state.jpeg = VCN_DPG_STATE__PAUSE;
> +			else
> +				new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
> +
>   			adev->vcn.pause_dpg_mode(adev, j, &new_state);
>   		}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 72362df352f6..d552e013354c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1243,6 +1243,7 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
>   	ectx.ps_size = params_size;
>   	ectx.abort = false;
>   	ectx.last_jump = 0;
> +	ectx.last_jump_jiffies = 0;
>   	if (ws) {
>   		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
>   		ectx.ws_size = ws;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 45a2d0a5a2d7..b7d33d78bce0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -999,7 +999,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
>   	r = amdgpu_ring_alloc(ring, 20);
>   	if (r) {
>   		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
> -		amdgpu_device_wb_free(adev, index);
> +		if (!ring->is_mes_queue)
> +			amdgpu_device_wb_free(adev, index);
>   		return r;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 43e64b2da575..cc9e961f0078 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -839,7 +839,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
>   	r = amdgpu_ring_alloc(ring, 20);
>   	if (r) {
>   		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
> -		amdgpu_device_wb_free(adev, index);
> +		if (!ring->is_mes_queue)
> +			amdgpu_device_wb_free(adev, index);
>   		return r;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 1f4877195213..c833b6b8373b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -861,7 +861,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>   	r = amdgpu_ring_alloc(ring, 5);
>   	if (r) {
>   		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
> -		amdgpu_device_wb_free(adev, index);
> +		if (!ring->is_mes_queue)
> +			amdgpu_device_wb_free(adev, index);
>   		return r;
>   	}
>   


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879A2E99059
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 09:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152E610E8F5;
	Fri, 10 Apr 2026 09:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DkS3F6S/";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD0710E8F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 09:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkAq0AWEtf8C/MTggOfOHpSwQp51nbUQL0HlfXcQ6sAARCMg5wqYuueqC4bzL1HyGdfF4OPpHqRw8l4IceVsyuo0xet6tM17sYlCO+keKHpTDca5eRIqGOEAQ3iNi0pFUqTUB5YR3o6tv1PGSyR5FmcXpCUCvgANGpbJ6rIyWIp/3C5T25j+LmeCMtYKyCW7MmLP+eNgrE27JX5sE5NqmetmSONxYwqCUrtZTpLnTes+COCtRts+ewsBrn5WOWQFX50q/TyEnyN/wyWtB/5n1n1IEGymw6ImxLX1Nl34uJX+xHzMw9Sx/3LL81UjF8KeXWS+W9mHiKdp1397NhJdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRMzScdxBgvxaQ+aha7RPdr0KOk+X7qR6YZg97wS6iE=;
 b=H3injQSMU21Ia35Q4CVfSi+ZGwHk15IwhD5wdlS3UufT2e/wIA4sBBZt8S5R8y4WNMQvqIBG1qvvrc2fxgCrtuTQ1FbGTwdXyyAUY1ItSYjzEwG3+9X4ronR96cZn+Av8VeWrjZLAjJ14ikxuosnWx8hmqE0Ld7qAdOfekUSnsIn11mpTAsI7MLr551zVEeefDWkb4m5szciYjxLdVgHM3aJSMf8NJAm3JjU1hArcKRIyNCJm+jw5BivA9Jrj5DpoOzl7pOVMfsBu3h4sIMHTzAi7lHqVntKRy1oG+e6EvgLSy4cZQq/d4NFm+sJZ1SiZ/mlciulqoCQfqt7VN9+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRMzScdxBgvxaQ+aha7RPdr0KOk+X7qR6YZg97wS6iE=;
 b=DkS3F6S/wTLgHjMygblvNhjF4qm64FPV2kTycqKZ/NF+MQEHgEP3BXdee0ezRQewPvU/0Tw/LPoWJTlQ2D+/FjnhWIMFkL03kJYMNRC2bz8Q1vVoyOE8rIMwdEctsnSV4z0SaOVtOkH+eaiUY9qPGIOhZvhG+qJv+TyCWM6RxgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 09:06:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 09:06:11 +0000
Message-ID: <7882f117-1217-4e93-8889-d40ef651798c@amd.com>
Date: Fri, 10 Apr 2026 11:06:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Clear VRAM on allocation to prevent stale
 data exposure
To: Amir Shetaia <Amir.Shetaia@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, harish.kasiviswanathan@amd.com
References: <20260409141918.1317087-1-Amir.Shetaia@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260409141918.1317087-1-Amir.Shetaia@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5f04cf-0e03-447f-b32d-08de96e068f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: I+N5f+ZrDP6c387MSmSoO9JFveI+eYKyjHdrQ9X+w5Mp+ZYptvs1RdrI5tcMNnf44NL8awn0EP+SIeJ/nZTZRvn0qbFqCMLn+1UToQ6l70Ndxd8np76Avr5SLjIP2kO4s1sdaeKTI0YD94zsqpW6YUdouE4Yt57WzkJYuMAK0QIOC4bGRn7GEEZDpyWOY8ZH9MtYGnG4VlOHgXuHgS/2V+WJX4gtRKv0WpcJtTJHn32MFP+hWOz6GFrr0CwbLzeR+8VdWsUEaQLU0VEanu+KVlTX71UxKyYdKp/gSZIrgSYu9HZHxcdymbPFKdSejzpTXASKJ2eDJJTLPbqNXw5YjPkse4FLh1VC5whqg0/RPLuyE2BEkGymz2Yc2qLsy6qynd3yqHd42eiLsh9vl40vRUkrWmjF62a2wz9z9myUVBNFzcQdG+aUTn67DYzEMzplsqG+1bG5gDpY6c7AUCnLlO4Bzsu1G+KJ/gbXVFZWwXBTQHMRKY2r2Hh26z/wp4uDt4FSr4oDT2eo5SO4Kpb1Np+98xMIzu8O6tTkltBOOdHIlH8USBUhX7cmrnGr+XO+YLOxoC+cS0xJvhu8U2ffAzUc/ZsWVUAK9EkfpVgqLFxN2rPISjXLxVXR8dez38DIwWhTyNLlGc4ZJhZ5m0fxy/Ry4PdgDlDx4fOCs1ypRj+7zAzqxcfXMTHqDcGAbT/xmK/nyAYuothIF40m+86vaYSdMTHfjPw1kJ4EQ7JQl+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkdyMFZKOVAxVHFRZi9uSHBoY3REYXNuT2Fud0Z1dFREN3JOV0U3REJkWEtv?=
 =?utf-8?B?bms3S2ZXRlpxaFZEckNURVZ4ckNjU1JtSUcvV2NtM0hkbkE5bXhlVWh3MTdM?=
 =?utf-8?B?ZlNUQ1QwbWlaY3lydkJwRkhCYURkNDVIK0h1Tm1GZExWOEhJcTdVZ21aNFpT?=
 =?utf-8?B?VTZJcGVKeFdwNzdsb2YycjBBN1BwRGNZeThYdnA0WmlmZnBXdENMbzZ2T0JM?=
 =?utf-8?B?NG5ESlJOWm1UL1RKWFJZczA5czFKbXc2eWRzUmwrMDU5NUhNWUpabG1LTFNG?=
 =?utf-8?B?S1ppRS90NnBFZ0RtVjlzeGlBejZnWmZqVXFIVzhyQnBHNjNkT2VVU0VGUnJI?=
 =?utf-8?B?b0ZycVZSMVU1U2xlL1FOTm43Z3U1RXZFSUxnZVFBS0ExWitFOU1aREdQTE1o?=
 =?utf-8?B?SUhyN2xJWkcyTE4vQkJMTjdUaDBNdEgzc0JKUmF1YklNMXl1cTlweGhkT0hs?=
 =?utf-8?B?VmV6aVU4TTBjR1Q2VXdTa0NZUnFmVlc3RDJjbUdheDdheXdtSEN6bHd0ZVhD?=
 =?utf-8?B?cmtTZ1ppeWJ2V2xSV1c3UHI3VzdhUENlLzZjd2svVS9Mb0Z0MnFTbXpqZVRB?=
 =?utf-8?B?clU1MEU3K1poRzVWVklONjA3ak1hRFJVUk1zTm1BaW5VK1QwV1lpWHVHYkhP?=
 =?utf-8?B?cm05c2EwcStKTjVFVGNmaWc0UjhyZno3NGhiaGt1ZlVtZUo2aVR6Y0habDRz?=
 =?utf-8?B?cXBPUVlVM3RLV2hkZGRZOTJwMHRvQnltUGlOaHdMYUpTN1ZiWHg5RjBTRXVk?=
 =?utf-8?B?Wlp3K2VmRXFPdVRHdTU0SW1EWTIrNzJoRUpIbllIOXAxazJjWDFId0NwQ1d5?=
 =?utf-8?B?RnZSR3RSWGQ0eHdYTVVLWU9GL1JLNWlxS1pUa1BocVM3VVEvd0ZHNDVhemR0?=
 =?utf-8?B?cXc4cG51d2pHWnFaSUlITG9xY1VLOHVXS1lBbUlPeHJjRXZUMnUyMklCUjNC?=
 =?utf-8?B?SFE1VlRnL2pmdEdkY0hQUkQ1L0gvMkNmQjdiRFZTSlBBUloxRUk5elhjMm1q?=
 =?utf-8?B?ZEZScTJYcHlybTRMWFRRR01xeFF6OW82UnAva1VpTzhEd0IzSWJxZjN2dEVX?=
 =?utf-8?B?Skd6d2ZycVNoRVRGdWh4cW5TdWF6akhLZzMvVmgxUG4vcUtLNDV3UWs1UGFF?=
 =?utf-8?B?d1J2QmRkSHYzeWN2VGJxbTlnRW91MjI1aVBRMEViNDc2MHlZZ3VOQXNDclkr?=
 =?utf-8?B?bGtxc3FDRDQzUEtFaXpBVjZIL3RsS2lUTFJibVl3QXc2QmV5a3dBdktEOGp4?=
 =?utf-8?B?YVROU1hibERvbWl6RlFETFF3V05abVA0V3RnZklzRitFbUNBYi9LN1RHOFpN?=
 =?utf-8?B?RUVBaWVNb1VSS1pwd0dwTHdKL3FpTUIxOHByK2loQng0a3VxTkQxRWNCeG1X?=
 =?utf-8?B?ZWd2MzBTdW94S1FUSlhaODlucDB2Q3Uwc1FFc2dzTjI2ejFpMkxxODBNYkZN?=
 =?utf-8?B?dFZ5OWI4a2w0bi9zdEJuWU1DRWFrMnBLWUlkUndGUUFVaFBsT2lwWGNYLzNm?=
 =?utf-8?B?L0Zkc05WYSt5OGZ3aGpLS1FuS1lPVThFQjd1NEIvYzUzUGpXNU0xdmtmempT?=
 =?utf-8?B?Yzk4bFB0ckV0b2ZrczFrd1o3anFERnVBbFJTeUxDYmFHa2VwZERKOGRmaHZB?=
 =?utf-8?B?TVlCbTMzVmV0Nzhld3BUc3NnYzdlRVlIQXZoS0tWR0tWWUI1YTZUNmczamxh?=
 =?utf-8?B?djhVOU9sbjVyYlUrdkg4dVJHdE9vdTRVOG9xWVd5a1ZlUnJlOE5IMERxWHlD?=
 =?utf-8?B?SW1FNkFVOFd3WTd1cTFYdFkyVVFKUzM3U1lsYzZQS3h3M3l5d3NnTUhUclhS?=
 =?utf-8?B?TldjMFVpVmdSdGc3VittMWdSSUJhbGdQdG1SL3JXQnlCTC9mMEhXV2lrVmIv?=
 =?utf-8?B?cERaTDFhRWFycFpaME9mU1JmaGlJVmlsdFZSWHREUjdvRmU0Rk9jVW1TWHZB?=
 =?utf-8?B?SFJKTTB0anBUUWg3Um9HRlJDcG5ReEhVeWR2R3cwcWl4YnJCQjI5VVB2Um8y?=
 =?utf-8?B?NStFM3UvekJRS1NHVmdJZytCandkNWF6VkF4TERkcDhPeTNsUmwxUnBxOEhJ?=
 =?utf-8?B?dzhSNkpxcG1tOFpMQmJ5N2lvQnI1cWVITUp1b1RuUHRnMWNVVTB6TXhjWTBE?=
 =?utf-8?B?Mjd6bnRaL2dDaVhmRk12TGY1bTlYbXFNME1BaERTd0VCYnhVcGhDR3FqTTRE?=
 =?utf-8?B?cUV2RFVGaEpaZE5Va3JlQWFYUXNNNGdpMTdoVnpDT1ZsejI3ejEyeTBNajFZ?=
 =?utf-8?B?aHErT3NZbnZMUG96dTVZdkFXVFk3WDhqWXYrdks4V0QvdktHN1dFU2Zsem9l?=
 =?utf-8?Q?7xYlUq7fBQ9b9IVJIM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5f04cf-0e03-447f-b32d-08de96e068f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 09:06:11.2540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4taLIFIW4pQnZgjJoHhAJManjdriiTgpoGWP3GK5/wzhAeBOjBKBhHGuDzcxGPfB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
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

On 4/9/26 16:19, Amir Shetaia wrote:
> KFD VRAM allocations only set AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE
> (clear on free) but not AMDGPU_GEM_CREATE_VRAM_CLEARED (clear on
> create). This means freshly allocated VRAM BOs contain stale data
> from prior use, which is observable by GPU compute kernels.
> 
> The GEM ioctl path unconditionally sets VRAM_CLEARED, but the KFD
> path was missing this flag.
> 
> This causes data corruption in applications that depend on
> VMM-allocated memory being zero-initialized, such as RCCL P2P
> transport where stale data in ptrExchange/head/tail fields leads
> to HSA_STATUS_ERROR_MEMORY_FAULT crashes.
> 
> Signed-off-by: Amir Shetaia <Amir.Shetaia@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 8a869fe41acd..7c01492e69dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1735,7 +1735,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>  			alloc_flags = 0;
>  		} else {
> -			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
> +			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE |
> +				AMDGPU_GEM_CREATE_VRAM_CLEARED;
>  			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
>  			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
>  


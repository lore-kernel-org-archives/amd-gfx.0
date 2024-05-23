Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E408FC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 13:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5841310E0E3;
	Thu, 23 May 2024 13:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b9qnfTwo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E461110E0E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 13:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To5FSCHEvF55mG8/ZcBrZh2+GWP7a3/eX357qFIV6kew5kPPY+dWQbB9cUiJUObLwkFd10YqCVHFD1l73Vi9Ofl8tJEL5dIvw9qNHyTIRvPW3c2BAsVT5sRU+Hm/1gp2IIKlHmfM3qzvd4ePFQTUCVocw2ZokF2rfWeRCgvp0D4QTwumEh8ETpzKBfa7UsuYZ8bxf4DQigaong6uhAFlyBJxEW0RRczztAMxl6GtFyknbu3ggVYqH9mGDMZaYHCgn/qLpkGpkc6kyURDP4GdPOSJY0X6/mCFDm01UU5uUrQXaRDomxM4mOfOtMVQXN9trHqjWzc4weShnySD5Ao+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXv0/mLcMQhIeJPnpCDW5NqkGAEr+eZ4XziDyP7Ehbw=;
 b=cDAXLNrayacYVqms3U2cESCTPoE0MW0kqLTFI1/uO8fPtlUU3weUDpysOFl6UKstFOZi1ldK1sKQbbW6ca9KliT/pSc/1XcknZJaz/OdNqUyv4ASaZxbHQ2x2UuhuSGBey6sW4QjjsIMaPI9ORoeinVzAYrrs9gryZVb77fZetUyniloEiX9neYsrzYsPOyPVN/KbEfAT2PUyQ4ONs1EYDv/rfFcoaa71uMUrzpuM92+JGLIfAFv3KpvmSCPjxmkQWDpetcMm64n7f8dSSsSWRpHOHcZXxfQ/DmXzrsX9AKSU0psRGcVdU61vpzg5VEZ3VaYf30nk7pmlmIXSF4Y+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXv0/mLcMQhIeJPnpCDW5NqkGAEr+eZ4XziDyP7Ehbw=;
 b=b9qnfTwospBds9ILN73PnvdfWsRvpvMhDVWZlFK3uyCZ7ztjgX/2aQ2+yxKfs1w7N+YxtmbmL+kbRlw+1kjjT8NPyd41i02BaaoqTp59dFR7LMSmFNXl+mhfPACK8v17ROSrsVCK5FX4qnann7ES5ZohVasbG6uUzwk/Pn3Vu2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 13:41:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7587.037; Thu, 23 May 2024
 13:41:35 +0000
Message-ID: <e9c9bdce-1462-44ab-a60b-16f235ff0159@amd.com>
Date: Thu, 23 May 2024 15:41:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: fix dereference null return value for the
 function amdgpu_vm_pt_parent
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com
References: <20240523091651.1425735-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240523091651.1425735-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: e74b8483-863f-4077-683e-08dc7b2e0fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3JHV1UxLytuVmMydFpLVmVIWWNuZ05hcFcxYXJ0SERQUzdhMTJEVk91c2U1?=
 =?utf-8?B?Q283eklRVU5sdXdWcnArWXBaQ05oUkFLUmFCWnFOQkdGUCs2NzFOUnorOVJ6?=
 =?utf-8?B?UEMvZTZYYTF2dkxSSzk0MnVWeEc1RkZ1TjdZZlB3UGlmbS91WHlWVE8wV2Nx?=
 =?utf-8?B?K1hvUjRsV0tJb2tDdTNMVlA5S3JYQnZNdWQ3VW1iVjFrRW5mSngrblBNS0pH?=
 =?utf-8?B?T05DN3JHYU5kTGhsZ3Y0U05PQW1qYk56bmsxb1REWTUwSHlJbHBlODdRMXpD?=
 =?utf-8?B?T1hXNWNyczRXaHRaSGZnQU4yRmVHMncxenBvb2dPM2ZHdjRzZVdKQStJNkxG?=
 =?utf-8?B?aW02cWdjR1poSnZHOWhYT1BLbHFqODZCQ1BuWnk4ODRYdTkrbStRU2laWWRh?=
 =?utf-8?B?OFNVQTNnZEJrOTFVUWFHMllCNzF2bjhUSzhMZ0N0STB3TWh4eU9qVDRDOHFT?=
 =?utf-8?B?bGFWS0ZoMkRtTjRMRS9vSFZIYlNDRTBENGZ1bU9tSG1OK0MxMEM3Z2lSaGRo?=
 =?utf-8?B?RXpCRVhtWDRqMGZJWUx0VEhYUnFyM2VoalZmN1l3SVc4UzFQQUR1QmE1b01w?=
 =?utf-8?B?dmlCSXViYnVWSUdVNGtHREFRSU1JOWJrMXN5UFpRdnlaUmw1eXpBZ21kb0F2?=
 =?utf-8?B?TDNILzlUZTVsTnNqQzA0dnpSSkl5Qk50b2tiMCs2T0J0Tk9SSkYxbC9NUHRQ?=
 =?utf-8?B?WWN2RWRHM1Mvb3h5aWxzN1k3TWZ0RkVkQk5Xd1dCOVo5Yk5saVd5U09BRzcx?=
 =?utf-8?B?anRvOW9FYUx5amQzUThxa2x0NHJDSkxhRkFqTDF5aTZ6c3l4VWV1YnlZdlll?=
 =?utf-8?B?MGt5V25rVDlLQmVnbTdUTXVYZDdSWXY2UEdTTUxDSkl0ejNZM1FGZVlHT3Vk?=
 =?utf-8?B?Z0hHbnhZSENSWkQwdFBrdlE0azhFRkJ4Rlh4YVlLV1JaTU5RbHhqTnhHYWc5?=
 =?utf-8?B?RVYvZ1hUcXVoaU5wVS9UMzdqSlNsWVI5bFMzNVcvd1dUeFFVdlRuZGswNjF4?=
 =?utf-8?B?VTAzSnJIWVNUSlFQU2VscEhULzVwTnI3T2VuSWFSSitYTHNCaGVBVGlBVDM1?=
 =?utf-8?B?VS9Lci9sZ3o0UHk0UkNhbWhBOWJUVjZ0QWtNeDA2QWk0UXVseFRBbGdhWGRJ?=
 =?utf-8?B?RjJIaEIyd1ZzSmZRbXZmamVHNjNMejhZaTZ4M3cvdm9Cbkl4Z0RPRWVHb0JZ?=
 =?utf-8?B?clRaOUZFUTAvVzl2R0UyYzJGbyt2dHExS1B4QWU4MHNta1JmMFJieTQvUDRr?=
 =?utf-8?B?UVAyQk1QOUxZU3pOcUp0aC9md1NJbnVGRHRkRnhPUm90U1dyMDBCUTRTYXBB?=
 =?utf-8?B?UXFDOUVFSzhaK1phdWtLNHgvcXVsSzY2a3Q4VG1WSDVWLy8rUDN1RUJ5TVg3?=
 =?utf-8?B?a3BlQUh1TFFvc0dTRldwY1d6cW9CZVUxOFpTdm5qREwzRkEvRjJ4ellPcSt5?=
 =?utf-8?B?ZHlKTGN4QVRVbTdFWkdjNzZRYlB5SklYWlM5emR1ZDNlWjQvMWFkOWJCMHF3?=
 =?utf-8?B?c3FVb3NxTkQ4ODYrNGs3dFE0Y2pHZHBhWVFRaG1vVjVmRGNlN085TWJLbCtv?=
 =?utf-8?B?aXNiM3c0NWlnVjJSd0VIaitLdEo0TU9wc2ZwN3E4NmZSUGQ2NFExR2sxcExl?=
 =?utf-8?B?Z21WVC9PSFd4MW5jZXBHYk4xOTQ2dVkvS1R2dUtnY21iQ3lrRll4aXZ0cEJw?=
 =?utf-8?B?TndJdllEQTcwQnNRVnNuSTlMNlM2ZXRha3dVV0x3UTVmekdGYmZhMmZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhGYnl5bnZESHVoa3Z1S3krUk9tMXF2YUloZUU4ZWltQUNESEZVWXNhN1Y2?=
 =?utf-8?B?Q1JjNXdzQ2lGMFVzNVFhVEd3bm5aS3MyckcrclQ4bXIrNVdQakNiSnhWNTVV?=
 =?utf-8?B?TGpLbG1HMDdsajRDK205UU5RWjZQSERoZ3RvVDkzVHRJSjdLQTNndzBpa0Jq?=
 =?utf-8?B?Q2VTTkkrcE1neDIzNTkyL3FsdlNBWURyMy9HM0pIdlhFYUF5WWQ5MzhEUmNF?=
 =?utf-8?B?QXdsWUVnci95clFTQXdtV1pEbzJMQXFFcVVFYmNzV1lwUVcwcHBqdnZKNC9x?=
 =?utf-8?B?UkNSWFBnZWhSL0Zkdmp6eFFIV04yRkFmdkhDczZIeVovaWx2ZGgrdEIzL1g3?=
 =?utf-8?B?SU1FbEw2ejVoVk5YL3Z1c0FvNHBtSmJ0RC91VERvQ3hjWWcxbWZQSHgybnlu?=
 =?utf-8?B?U3o3dGVoL0pmd2FkVzRlRk5iSkVPK090VmdCYlJUdGR0Uk1oVy9HNXhlTnMy?=
 =?utf-8?B?WS9DWkdOMm5pUXlDTFdhQjE2V0o1d3N4NG1kV21DS3lkSW5qd1pUbFFnWEor?=
 =?utf-8?B?c25ndXFBU2UvVGl5YU5jQTNHY1ZGNEFzbXpJY3kydkpTL0NUWTZ3V1NXWTFn?=
 =?utf-8?B?c3dmSUIxZ2RXdGk4SjJuLzV2NjZHTWZEL25kc2hYekkxK1M5cEdMc0VOZ2I1?=
 =?utf-8?B?NlA3LzV0aUxnQjN1LytJcjhzSlBFVHpkL3V0c2MzVGFpcmZKTXBMMHpLUHVs?=
 =?utf-8?B?NDE0clhmZHpvMXlXQ3VxZkpVSTNGWXFCUnJRVzhFVUhlS1FMa285YUhjcjJp?=
 =?utf-8?B?eTErZ0FaY2Yrd1RkdGNieTdKRDF2Q3UxRlQvNTB5cnFHaTJZbHBKdDl0SGRM?=
 =?utf-8?B?QmNsWFdtdkpxQThjd0tmbUs0c21NSDY4a3dsY2E4ckNyUXBVVjN6UFJRSzR2?=
 =?utf-8?B?TTJMRU5ZbGNVQkp1TmpVdURZV1JkSTZqR1lQOXMzd08yc25HVEtUNkJOSDls?=
 =?utf-8?B?aE1qSEdkc2kzUVcxM2YwWlVlc1NuUk5QcGNBT3ZNc3BDOHNJSHlYdnpFYUpt?=
 =?utf-8?B?M3pCTFo5K3JleDV5Y2JnUElVdkVKT0g5dGdHaUc3Vk1KQlpGSjVhY3l6UENy?=
 =?utf-8?B?bVVCRndCUFJ0MW1OYm1hSjc5M3RvNXJlRkkrUUthb1RaMWlsSzlJMUs2OWt3?=
 =?utf-8?B?WFZSbEp1VFpRbWduY3IwV241T3U4cTFZcEdiRkRuUnRJL1FHQU1CSlBKcEJs?=
 =?utf-8?B?TVQ4SWk2bVQ4a1d3ZGUwdjJlaXZ6R0E2ejM0bnVEdzUzclRQRWl1WVVxVzBw?=
 =?utf-8?B?RzNrNUxib1JDTDhCcm1yQXFBclNobllnbFIvOGVSS1JtVFJ1ekV5MDRyWmRl?=
 =?utf-8?B?bmJuMHdobmF0UXV5dVJ2dTRaME5kL0VOejB6R3B4bFE3ZnZxWGoyT0UxcUYz?=
 =?utf-8?B?TkZ1OGNlR0VVaXBEdko0UkxTVHpITnVYMTkyUHZGYTB2LzYwcnJWeThrRTlO?=
 =?utf-8?B?aUJ0VzlobExzQlN5QWJUak1qTmdjcG0xUTJ1YVEyZ2Q0ajZHYWpaaGxFMnQ2?=
 =?utf-8?B?RnFXRVFwcFBEWmxmU09QZ2FSYk5xa3FNUElDenR6ZE1UWTNubzdRMVZvYkV1?=
 =?utf-8?B?STJKaVUxOW4wR0srZGNKODhhVUhQVnU1TlU5S2tTN1pTR1NzYlVpSU91V1lR?=
 =?utf-8?B?WlBvak95NXlDZkxXWitWc2owbW84Z2xGVDFXdnNZSGFwdTVsMkNqM202dU1i?=
 =?utf-8?B?Mm5qeEtJMnh1ZncxbzI0OW5mTEk4bjE1dDdnYUQveEg0NDhkVzhDUTNFdlNK?=
 =?utf-8?B?dGNLL0Q2QnErYUR4N01JeVhDM1BVK1lWR3BHdXpyUmZSQ0NiV2JTZ1RrTGVJ?=
 =?utf-8?B?OGRsZVB2cThmOE8vZEltL0o2U3VoTW5sSDM4SVdNZ1NYTjIydkNjU21kMFg4?=
 =?utf-8?B?UzMrY2M1RlppbnBjWWczOSthaE12Qk1IRXFkN25wRUFVMzZwRVN1NmtVQTBr?=
 =?utf-8?B?Y3cyRm1aTmxvQmJranFzMmRhYzBwZzhUSURocFo3dzVmV284dGlPVTF1NHFK?=
 =?utf-8?B?bGNaUnphQ01aRVNVYytmbmVNR0EwMDFnSUdCd25VZ081bktNVVdSSlNsYTNN?=
 =?utf-8?B?aEZ0WW1zQXZNYTdTM3NQRTRlQUQ0THZjREkzai96Uk00NU5HVzBYWk9ZQ2Mr?=
 =?utf-8?Q?o7ZzMVSJ2qhfGqzNKyE+1D69i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74b8483-863f-4077-683e-08dc7b2e0fff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 13:41:34.9790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVOXsUDmNzBgXTMVD5Mf3V7tmER0D3lVwhbnNUPDqMz8NAkpJGsh/Dgu03c5+oC/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108
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

Am 23.05.24 um 11:16 schrieb Jesse Zhang:
> The pointer parent may be NULLed by the function amdgpu_vm_pt_parent.
> To make the code more robust, check the pointer parent.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 0763382d305a..e39d6e7643bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -706,11 +706,15 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   			 struct amdgpu_vm_bo_base *entry)
>   {
>   	struct amdgpu_vm_bo_base *parent = amdgpu_vm_pt_parent(entry);
> -	struct amdgpu_bo *bo = parent->bo, *pbo;
> +	struct amdgpu_bo *bo, *pbo;
>   	struct amdgpu_vm *vm = params->vm;
>   	uint64_t pde, pt, flags;
>   	unsigned int level;
>   
> +	if (WARN_ON(!parent))
> +		return -EINVAL;
> +
> +	bo = parent->bo;
>   	for (level = 0, pbo = bo->parent; pbo; ++level)
>   		pbo = pbo->parent;
>   


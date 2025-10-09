Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5BBCCD185
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 12:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A7C10EA13;
	Thu,  9 Oct 2025 12:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dWny6INO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8695810EA13
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 12:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMgI+ND0HkAfrfOoJnB2ffOuRuDeYYepGuPYXsBN4+7xQ7eYlEEi5grkXZ50X0pRYpEUk9Jwm4fppnHPqErw99VBFW9FY6U1xsjZoUEtxTf+EmoXoXFh/3+P1Atmb+s8BDvlaZ3fnPuHobOZlVCNjDd9/7gcx6qd4q3S/ispgyXqk40EvtNtTFiMXBuuZthCNQP9ET1ujZGeLyfGrXJWyG3vITcuTamUWi5GlMpOyypQR9SuwHplTLVT/SYhM2Y/kcm5llIbWFYkxJ/oCJxrXIeDXu0uuBZu4HQbFptrbLKhxNRYsasCl6pZYliEUAYOjwkLn9VrxIbacHSQft+lAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFN8ob9KuvveWuKmVf9Spi1M9DkHP9NYAlT7Ubv7f38=;
 b=jYAUzpyd7z8S8xXqYaMKZ/7ePHtmC5BBeu3lumlZTD19dydGmxvOhTUAOrgtvjnb3C6VzW2cpe43XeWFAiW0axitc1Zyqb2lrocarc3AE/RtWD5VeSmfP6fL71YJ6O8izB/SOEB3/ssCFb73HhkKT+UZh+9K5F4h/q0+7edAMjrwjZQj8zGaxjr+bWAN1LNH7i61G61a/eooqI+kw9rYouNLjtJwVC47FwMnJquyEgrzrn4Y45DJepMTdEfx5zPNHW6aa3ZS9yEHnr4ihlzZI18DVoYqxQUmNkMGsit9NjszRPlNXMGGDgs2gA86AHO9/YQMA45TbnmRNULKHQ8vNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFN8ob9KuvveWuKmVf9Spi1M9DkHP9NYAlT7Ubv7f38=;
 b=dWny6INOG9GBFAna7Qzr0tsNHMvfbrnnzlaMoV4BI5CB/dyohUZzzUKURSOSlP8wj2Gbq1TG8/sSQZZ03e5fFtHx04Cv9gmDaO4W4IJZ0W6GNVM4K1kSb1qoNdpVO0jD43OkCX1CRuRBmtqKuGBfmAxg7FpzMFYILoCofMgxbLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 12:32:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 12:32:01 +0000
Message-ID: <1fa7760d-913f-4826-869d-818b60fc74ad@amd.com>
Date: Thu, 9 Oct 2025 14:31:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init
 from dynamic crit_region offsets
To: Ellen Pan <yunru.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Shravankumar.Gande@amd.com
References: <20251009033106.25022-1-yunru.pan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251009033106.25022-1-yunru.pan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:408:141::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a52cfb-c647-4c08-b9a0-08de072fd85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1YxYXhSRzV2L2dERmplaHZPcTlYaFRxaVpRa2JGNWVFanJUYlFTcU0wOXVn?=
 =?utf-8?B?NU9EM01OVUE5bVRLQjczK3VKTWNEU0Jybk5tZTlzeGFrMFJXMzNVa2k1cEdm?=
 =?utf-8?B?NDJtTS9KNkxrVnlOTnBheW13NU5xandtZ0FrTE9PcTJkNGd0cC9jNjdrQmRT?=
 =?utf-8?B?R21aZGhwZkczOWZpdHlOeXVKZ2U4UzRDY1E5ZzZLSlNvbVNHSFJrZ3JxTWgr?=
 =?utf-8?B?RVk0Z1A1d1hPYTBmSXMxeE91dUtjNzJPVWZDUk5zcTZxd2srREFja2YyUjEx?=
 =?utf-8?B?cllTMWVrWGlzSXQ1QVl4ME90dm1keVJIbHpZUE4xZmxEUDVXZ05rN3JxSVFt?=
 =?utf-8?B?VjVOZlJpeWxZU1dseFJlWE9IdjFUVGoxNEFKYitoeWg2ODNxTjZOaFU4UVM4?=
 =?utf-8?B?M1h6a0hyN3cvSVRIY2pJNnZ5cTBmTlU3UUpKMG8yRTB6L3c3WVdGbXB6Slp1?=
 =?utf-8?B?M2FnaFJCWUdSeFl2eElwdmR6NS9Lb1VVYmRRbVFVeDU2c0RnV0VrWXVBU05m?=
 =?utf-8?B?em1wbzkrREkzWmNTM2tIeTNGSjRTUmNpYUtFK1lPNlZIV096REo5QUVpMTB5?=
 =?utf-8?B?Z1V6ZVd3aDdmVkdUcURrMnpRck4vY2gyL3FMUUpRK0hCYmdGdzRCaml4bkFo?=
 =?utf-8?B?S1ZPOVlxcEFieWJxWmpZQU9DRHl0THkxdnhtaXZPMjRNL3JXMkd4UXlPT0Q4?=
 =?utf-8?B?a3pUU3c3NlAvZENkV3JZcVZUQWdWbjRraDVhYVVGMzRMVS9VSGMrUXVTbGNF?=
 =?utf-8?B?RCsxcjk3U3JKRWxwY3VWejhNcHAyNFEwUFZxS1FMWXpiM3Ixak11OG1WR0NV?=
 =?utf-8?B?M203WEw0aTcwOWhUUlhrZHljUGhDTlg3L1pLZ29ObkFnR1pNZkZhM0NZTUQw?=
 =?utf-8?B?ZXpjS0s3cVZMaWMwU1NYaThUdmZiSi8vRTN2aUtQb0FObzV2eStuQ3pkSWpD?=
 =?utf-8?B?Wld3ZFhneFh2dFRSOU9yck5QNVhKQnhTdTBjYThUU2hNUWpocWZPb2xlc3VJ?=
 =?utf-8?B?Y2p3ZXZ2WExrdTk3M1RwR05uT3RLNm1QUEp0aUVFWXMvR1RHczB2SXJRQjVq?=
 =?utf-8?B?V2J2aU93eERYRTJPbEM1WTd3ZExJM1JYd3NQdExzT2Y3dVBFNWFNOTdGOU5I?=
 =?utf-8?B?T253MkZIckNpaFJKTmcycEJTUW9mV0ZRdnA0L0pZYkxkL1h6WE83WHlUR01D?=
 =?utf-8?B?eHcrZC8xTFhSejFPeEx4TXJaZ2g5eVFocUEyOG56Q0d1bGVqejRob2ZCZ1hy?=
 =?utf-8?B?eWR3R2FIM2lYWndMOFdtd3laQUo1cHIwWXZRV2QrY1QyKzFQWUtxN2o3VE8y?=
 =?utf-8?B?NThPQmhORU1VR0NDNjlVNG1peHBnQ2hneHpDZzVST3ZUMkdxejdEV0RvWVFN?=
 =?utf-8?B?TDVlOU9KWWx3bzY3d0xHbmRUV3VRVkZUOTRKajhzOTh0SktFMzNmbW45dTJY?=
 =?utf-8?B?aXBKY203cmlZL09XN0Exd2F0b3ZUcEo0OUQ0NVFPeXlqOE5CdTBUeStpb0tL?=
 =?utf-8?B?a1RyYjFtTkJiSW1BZnhianJiaVJsUFRGaDFNQWlOUkJETlhsQVR2ME12NzJF?=
 =?utf-8?B?dDJ5bE1pSjhYYUNyVTdQTkpyVWZjL2xkNVJaUGVJY1czYVhDN3krT1pGV0Fo?=
 =?utf-8?B?Yis2bEdQWHg2djVpZ3BkOWZSOWJMSDJmUk4wRUtqUVdqaHRDRElpYWpGUk5N?=
 =?utf-8?B?MFgwbjBTUldlblpFV2lEQTZ3VE5kNWh6bjRxQWRKZFRUM1hpYTQ3NDdGTkpu?=
 =?utf-8?B?Ulh4VnhKeHozRlRnZVdpOTNJckJBVDFUT3IxbzN1VjJKRi84TWw4Z0dRMDRQ?=
 =?utf-8?B?WWhGdjh0L0lsdmp2OXNlVmVyQk5PTUtHOGVXbFBTRUtISDZqQjBXalpBa1Ex?=
 =?utf-8?B?UHdFNXhWYnAvZkIzV2c2eUNkajNOWnNzZTZ2K2VPeDd0VGJIMVRwY05aUmFW?=
 =?utf-8?Q?dTjSgBCRhxgkcN2HPn2p+XRixbIQK+Yf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnU1WGhvRjROZU5CVWo0Ym9XVy80QkdLdWVxZTdJeEMvNVIxU2JRWG1OSEQ4?=
 =?utf-8?B?VFpjUk0rS0R3ZnJnVjU2MWY2QW5NQUo0ekJRQ0x6YkI1bzRTUTJSQkhDejRx?=
 =?utf-8?B?SzlRYnVmTW1oeG9JS3o2eWs2MnkrYSthaFVIdjM2K2Roc29HSFR0MTl6NnZY?=
 =?utf-8?B?cUc2T01vTVlFcGhEd09EQzVYUFljQWMwa2pQZXR5ZjVucjJwcnNVempYZVNJ?=
 =?utf-8?B?V3d0TXBVRXNYQmF5eEpaTEgrOHlCZzlFd1ViSUlxZEZmNVQrRUJ1REpBd0d4?=
 =?utf-8?B?eUVITmF4NXNlU3I2d2FrdE0rKytGOTZsTG9mVHduakNjTStNSGNGMm1YWUNz?=
 =?utf-8?B?UlpmVWdGWHVTSzFycEw2ZGFFeU81dVk0WDJHNlY5Uk42VUxXZEZPUWJvdkhs?=
 =?utf-8?B?SlgwNUpsMHVlYUlFWnlmU0UrNDhabEpKZVlQQUhvLzFydUo4YzFIalVYS0Rz?=
 =?utf-8?B?OXpyUXFMbndrQS9HOXV5K2ZmYk04SVVvSlhXZHJNbmhVbnJYRHVEczh5NjVW?=
 =?utf-8?B?N1lVRDR4cEYxSnJXc3M4L0lyYlhqaUNrZVo1Zkd6YTlteXlIUDVVd1JoRGQ0?=
 =?utf-8?B?OElhK2FCNlM5ejlDMGszRGZHVThNUnBDWldNOE5CUXZ5V2R1K3VMSGo1KzhU?=
 =?utf-8?B?V2ZPa2I3cWxnOHpmTHZveWZCWXF0QWNMcjV2LzdFMkpJUnZJV01NMXBmcFVu?=
 =?utf-8?B?bzVDbGNKS08vTjh5SVVTRzY5QXU5TTRPZEJnZGV0aGRoVTl0S3VmMmRpR0Ex?=
 =?utf-8?B?ZnRhR3RtVzhhRU5PZDBIME0vVzFTUGF5ekszNWNpT1NsZ095ZitGUGNWY2t1?=
 =?utf-8?B?MWxjcTY1SVF5bnk2OTFlK3UrVXVObitNZGorR0IxaExhOUhmSFZKS2laYzk4?=
 =?utf-8?B?dmpscGRXVGxJZHhwQU5SM0VmZkxoQ1htUnBDbGVodFVsdEMxRnVUek54NVVE?=
 =?utf-8?B?UjM2Mmo5VVVKTTEwMlViZVBReFZTWVFza256cXZSQUxLR3VuZWFTNHJWelJR?=
 =?utf-8?B?UDZ5THFpUXY1clNkdnM0QjBMQ3dEUnIyTG1RTCttV1M5S3ZubC9aSUJkVUNZ?=
 =?utf-8?B?Mm9VU0dlUEUybGpJeVZ0MjB2UGVKS2lnNGFiWnlra3dsNUhZM1FlS2JtOTk3?=
 =?utf-8?B?Qms5Q1dWNFY0a0JlRy9DTVczQlFKREo2MzRwRmhCdmgxd2hKTk0yZytOQU44?=
 =?utf-8?B?YXpERlNWZ1VVUlQrOHdjZElORDNnaFl4ZzVxd1FyV2lIcHo5cllodFNwVFpF?=
 =?utf-8?B?REF2bzg3UjlKY29LRTNZQWtiUkx1TjVLVjhxbGsyRStONUdWcyt3QjB0U0tD?=
 =?utf-8?B?YzVJaHYzVTJOSEhyeVBhVHBkV0VkS2IvemozV1U4SHc3YUUrZ21BYy9WSkF5?=
 =?utf-8?B?WVU2eWVzU2s2azR6UjE5WWxxL0Uvb3ZXTmhVVzA4Z3kwMm9vaWhyZlcwcll2?=
 =?utf-8?B?b0dkRHh5bnZXMUZEcE1yMHRzYVZYK3pJTVpmSCt5Nm1QcnRyNXg1Ym53dVkw?=
 =?utf-8?B?UnRPNlNTbFVFUmtXRlZtSGxLeHRKeTNCdlVJcGlnRjk1akF3NjhyNFJaWmxW?=
 =?utf-8?B?L2lPVGhHdlNvaVlKS0xaUGMrVHlEVHBwUW5pdFVoamc5TStGOFhjdEpsanBn?=
 =?utf-8?B?OW1vR2tWSUtqbEFJcGYxcmVOODlpQzZMcCtQUnNTeEswMTg5Q0R0Ym9Pb0Jp?=
 =?utf-8?B?b25CYkhHdERpc3YxbGtQZkNUN2ppQ3pyMDJzV2FvWlBaejd5dFVXTkk5clZY?=
 =?utf-8?B?dGtTWWZ3N1ZGMC9qT3dMOU1aYUZJbTAzU1FPTDJmdDRZUDlJblFqMHdGOUZB?=
 =?utf-8?B?aHBLRFE5Unh3OFV0VVFyUXVKK3Q4aC9OK0lyYzhtM1FGdWdtYlpWK3BodDJj?=
 =?utf-8?B?bUMxZ3lTMUEyVFRwdTdVR2txaEc3NG95eWRpVDZnNnRhTGc2OU1BRVVrelIw?=
 =?utf-8?B?Y2pEVFgrSGlkcWRIdmRKdkI2Ky9rTnNPMHNsbEdXSzk4a0w1aTNFSk4zVWh3?=
 =?utf-8?B?QjdFN1dGTksvdkdlUW1vZlFoUEt4Y2YzUnBqL1kwa3VWVGpBT0lyaTNyMDlY?=
 =?utf-8?B?M3g2WUdVZHppNnNaSjJvWkFQZGhmL3hlUTJDMzQvbFdBSjQwUFRHR0UzOE5k?=
 =?utf-8?Q?nO1ROR9wJlZMl3sMR2h78qSLh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a52cfb-c647-4c08-b9a0-08de072fd85b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 12:32:00.9890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbMiwAGk+5bH5yrlV67dfPpV3HV2ur0wMY+JTkpATEXhR0l/KCwQCQXQoT1+1faE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
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



On 09.10.25 05:31, Ellen Pan wrote:
> 1. Added VF logic to init IP discovery using the offsets from dynamic(v2) critical regions;
> 2. Added VF logic to init bios image using the offsets from dynamic(v2) critical regions;
> 
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 12 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 47 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  3 ++
>  4 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 00e96419fcda..2cbb24ede86e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -114,7 +114,17 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>  
>  	adev->bios = NULL;
>  	vram_base = pci_resource_start(adev->pdev, 0);
> -	bios = ioremap_wc(vram_base, size);
> +
> +	if (amdgpu_sriov_vf(adev) && adev->virt.init_data_done) {
> +		resource_size_t bios_offset;
> +
> +		if (amdgpu_virt_get_bios_info(adev, &bios_offset, &size))
> +			return false;
> +
> +		bios = ioremap_wc(vram_base + bios_offset, size);
> +	} else
> +		bios = ioremap_wc(vram_base, size);
> +

It would probably better to give offset as parameter to amdgpu_read_bios_from_vram().

There is already a comment saying "this is required for SR-IOV" where that code would make perfect sense.

>  	if (!bios)
>  		return false;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 73401f0aeb34..0dd9ff576cdc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -292,6 +292,11 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>  		}
>  	}
>  
> +	if ((adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) && adev->virt.init_data_done) {
> +		ret = amdgpu_virt_init_ip_discovery(adev, binary);
> +		return ret;
> +	}
> +

It is probably better to rework the code here and put all the SRIOV handling into the calling function.

And then call either amdgpu_discovery_read_binary_from_mem() or amdgpu_virt_init_ip_discovery() and not delegate the call to another function after calling the first one.

>  	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
>  	if (!vram_size || vram_size == U32_MAX)
>  		sz_valid = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index e9dbab53cb06..9181acef4e9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -954,6 +954,53 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
>  	return r;
>  }
>  
> +int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t *binary)
> +{
> +	uint32_t ip_discovery_offset =
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID];
> +	uint32_t ip_discovery_size =
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID] << 10;
> +	uint64_t pos = 0;
> +
> +	dev_info(adev->dev, "use ip discovery information copied from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n", ip_discovery_offset, ip_discovery_size);

That line is to long, please use checkpatch.pl.

> +
> +	if (!IS_ALIGNED(ip_discovery_offset, 4) || !IS_ALIGNED(ip_discovery_size, 4)) {
> +		DRM_ERROR("IP discovery data not aligned to 4 bytes\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ip_discovery_size > DISCOVERY_TMR_SIZE) {
> +		DRM_ERROR("Invalid IP discovery size: 0x%x\n", ip_discovery_size);
> +		return -EINVAL;
> +	}
> +
> +	pos = (uint64_t)ip_discovery_offset;
> +	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
> +					  ip_discovery_size, false);
> +
> +	return 0;
> +}
> +
> +int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
> +		resource_size_t *bios_offset, resource_size_t *bios_size)
> +{
> +	uint32_t vbios_offset = adev->virt.crit_region_offsets[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID];
> +	uint32_t vbios_size =
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] << 10;
> +
> +	dev_info(adev->dev, "use bios information copied from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n", vbios_offset, vbios_size);

Same here.

Regards,
Christian.

> +
> +	if (vbios_size > *bios_size) {
> +		DRM_ERROR("Invalid vbios size: 0x%x\n", vbios_size);
> +		return -EINVAL;
> +	}
> +
> +	*bios_offset = vbios_offset;
> +	*bios_size = vbios_size;
> +
> +	return 0;
> +}
> +
>  void amdgpu_virt_init(struct amdgpu_device *adev)
>  {
>  	bool is_sriov = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 5f6014b2f349..d122347ff666 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -434,6 +434,9 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
>  void amdgpu_virt_init(struct amdgpu_device *adev);
>  
>  int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
> +int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t *binary);
> +int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
> +					  resource_size_t *bios_offset, resource_size_t *bios_size);
>  
>  bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>  int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);


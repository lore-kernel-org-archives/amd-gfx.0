Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985AAC54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 07:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37B6B10E66C;
	Wed, 21 May 2025 07:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UuBAvntO";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9145C10E642
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 07:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMWnQAJvF36zBs8NEXAV8hTSqqqrmFq9nBufIRWpvZ6gs2I+VdMwKIPm0kPgvuWnweXBknIalEfOdNzWr5hLqUMu1XZTIViU2ysaIGwEF+MqaRYrRMjxPXjf5gAydby7EfGU9c7SsLzwryKGzd96bxkSq1+vQ6YtchlbpiEs1ehItix5Wx7Udli04AN2tcIKjuCbXRBnSAk4noXsNnQnQH0sW6UKgRU5V9mPuXayDhl2DPgy1D699FOOl9ZUOCxDQpUJswEOySaiGK80d+sHCukTrr8DTTb/VwFTUEPhnzhk8ln6POE8vl68uaju9zx7HvszehaNSgzn4/ORa9dtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW62plhOsdX5o67QE0EIpfeZWTghHb9ySh8NagX6+o4=;
 b=R5aEOR2ZoFVJzbLmswTuoGCy5fBqGkWvTZjKG+QLCT+5muTpJlI+PBs3vZE23t+20Y+H/1F1bF0jYOHFjO+UmQGO3tdUgq1qK1zBt74SIGRJb8XEi18G3SXJRYaPAfwthcmKaIvH8Fmsp1Jg6wJFZ4HsRLEFUqJidrqGCJtuazUTXNm0Pn4xPs6+E+sjHFZN6CiaHbZqKDLzw5dg50MTi2bF60mQdX1whZnyK+LCC4XB72icW1Labs7RbLWp58IhLMCVEQjix8owOVLXCl5BgpLnoHOpP3dMObqWe/U7/E3mRPZ5eBDlPNBZVyarZ44EvJmhpg0ekbvNtkzJhfuzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW62plhOsdX5o67QE0EIpfeZWTghHb9ySh8NagX6+o4=;
 b=UuBAvntOv8JbTS59Jvh9TLDnDfcW3jG9XST0BtK3jfM994pPPdfsvm2kF94CYpyS8ChhrxjKZnc7Db5iDvLKGuv7NzY6zR/RPQ4XisicaV0pTdm6QbmpCXOjUgBKwKfYYQD4sInVT/KOeTnNwPeJ6YvzytvwLa/LcOUTH5fSirw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 07:06:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 07:06:24 +0000
Message-ID: <479867e3-370f-4539-adee-7427c04dfdeb@amd.com>
Date: Wed, 21 May 2025 09:06:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: seq64 memory unmap uses uninterruptible
 lock
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
References: <20250514171004.4259-1-Philip.Yang@amd.com>
 <20250514171004.4259-2-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250514171004.4259-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a83f9d-0aac-4118-0234-08dd9835ff19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Skh0bUxuY1ZFUlNSSmNnMi9hakhIdSttbG95Y1pPYUlXUms5dW5rcjBmUlRJ?=
 =?utf-8?B?T2d6YkhmUEhyMmY5UG15ckk2djVuTzJYSnQ0K0c1dys0YmNGSVJoc3VkOG5X?=
 =?utf-8?B?OXNpVlAxSlM2Y000KzVVTlNHWEN2cnhEMk1UL0ZwT2lEbDZaeDY3UG9NYjI1?=
 =?utf-8?B?R3NkLy8vMjJlY1lpQzcxYUNYK0hYRGpwVDl1ZUg0Y0djVGkyRDlneGJsL3Uw?=
 =?utf-8?B?eFpaNGtNTFpsQisrR1lKemlzbU04OUpSS25mTEg4aFN3N2MvT0ZuZTR5dWVB?=
 =?utf-8?B?bXhNUDNTQkhEbGJMZEE4WlBYWE15Yk5nc254ZXI4aHRYYlo4TVhTdEZPb1ZL?=
 =?utf-8?B?aVM0Mk9FTGtvREVGSlhKRDhkUWNnaEVRNSs2b2MzL0JBU0hlSTh3NHFLZTVJ?=
 =?utf-8?B?em9JSkc5a2oxNHdYNjFSY21xd2RLYm1yRFI3SjdyWE9TaGM3ZmJDYWd3eGpW?=
 =?utf-8?B?ZlliT05YekNuQXNwSVpyOFpBREk1Vld1Q0NaeE9ZenoxM0JmclFpVzh3ZnN3?=
 =?utf-8?B?S3UrZEVEVDhML0Q4V3dZU29COVpXYWZtRHRFOXVrNTk0V2kzNEJ0WGFvbStk?=
 =?utf-8?B?RVF1MGNGRWNYaFJMM0lXcVgzTlNJSkNFK0lwS2d2WTBSNUxGemMwLzR2cktj?=
 =?utf-8?B?VEVFUEoxdlhQL0pMaGt1OG9ad0xjUXVWS0xWWlNjejFad0o2eG0xdUthQ1Jj?=
 =?utf-8?B?N25oK3p6SGFHK0V2dC8zODA1bHI2NWJ2aFFCbzZhUVJTdXRucHd5NlRNcE5x?=
 =?utf-8?B?OEF1YndwNW02KzVaYS8zS3N3QVdLbUpwQ0xuUHRCKzZ3Z3l1b3dTTjVIQjk1?=
 =?utf-8?B?WkFmdFVNcmdrdkc5dFBFRTk3WDRIcEYzTmtweTBvYmJhRm8yM0xnVmJSRHlX?=
 =?utf-8?B?UGRIcWZJcmZHbStEbldFaFZjVmRvMGRiaXFaVnJuelhOWUdMem1HZ3g5Y0lk?=
 =?utf-8?B?cFV3WDMxZU1iYXE3K0VZY0s4RWFRUU9UeGthcWtMb2NqS3VXSGhYTWJ3RE1Z?=
 =?utf-8?B?K3BLMHVtWUNBdlNPUTcrUHZjZmgxQlFDVXhWM2FpRERNUlVKU0VEMW1HSnRW?=
 =?utf-8?B?WTFEcTh2UjIrY3RoMHVMTHBETXZyQVAvNCtJeVZ5SVlyc21pTHdrRTJTR2hp?=
 =?utf-8?B?R3NYSlRlcGd3OWRIVHpXRG9JeUlVUk9mdXlGV2IwNVcxSXhUSEV4UDNCRjln?=
 =?utf-8?B?U2lXd2VpRzlHKzY1VldrMFAvUzdIN1lnbDNkYmE2L3diZExGL1dNNzNyRFIw?=
 =?utf-8?B?MzVYMFZqTDhPZnJSclRMMVZheXhveHhjMkU2TEs3NmcxNTJidjQwcmliL2Q3?=
 =?utf-8?B?aDdwU3VZenhHS1A2TkVRdm1Sanp3dnBVUmZ5NWZLS2pUcGRBUU11M1paYktr?=
 =?utf-8?B?ZXduUElCZVZtRnNDMzdsNjF6V2ZiY2hMeFNGSThvMzJwaGRWQU5kZUlaMndJ?=
 =?utf-8?B?VXJUeE5kVzdwOXhRa3pFUXpOODhvbWRiM2lpSTRpd0VRRkV4V1ZNZ2hiVkxp?=
 =?utf-8?B?NUZ2MGg4dXZ4OVovY2tMUFVQc1dlV3crT3VRTGZweGl2Qk45UG1WR3FYSmto?=
 =?utf-8?B?Ym9SN1c2M0w1bHZHeGVCR0lwSmlYTGNiZ1dSRVBKVUpmNjRtOVZaZ0lFMHZV?=
 =?utf-8?B?L0NMT3lRTDREVk9ycDRycjdmSVpxK1RuZVVveWtXbVJyTWhoYUxraEJVREtP?=
 =?utf-8?B?TzlKTlZ5dmh3YVNLQ0NHQmpwQjh0S2FHMDA4dnVnaG8rdFVNNTZ1Z2t1OE4r?=
 =?utf-8?B?YUdnMmJuUmg3VTdqZndUVk1YQ1VqK1Z6c2NQTG5RYUVkaHNyNmtVRnMyd0cx?=
 =?utf-8?B?SWhuQnB4d0RPVWlkdEpKZFRFY3ZOR2FWM3pjbktFOWZYRVhkaklabWZ1U3Jl?=
 =?utf-8?B?cm9NdGxNYmlwdERtYTlmTHIrcFdQeTZGYmZTQXRNTXpuVHc4Z0NVd2J2eDd5?=
 =?utf-8?Q?16PVcges7kM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU5XRit6L3ZsN1hqaWVVdG9BaWNySGRtekplRTkyQkIvc1NrQ2RmZ3gxY2pZ?=
 =?utf-8?B?R2xWTzUvWlVnUC93eTFYRm9LbEpreEMwdkpLU1MxNEdxOE1NQkVRaDE2cUl0?=
 =?utf-8?B?VWlSVVFBZXF1eU5aNHljSnlMY1ZuV0RLNkprZlNxd1hNS0RGOXorWjlGamhx?=
 =?utf-8?B?Mi81KzB6N1BFUmpXSDV4ODNMT3l0S04vWEdDZE1UTkhxUXgxMG9xaXNVREM4?=
 =?utf-8?B?VkxEN2dyenloQStWWW1VWnlheXh4ZWhHbDFXWlpjR3NMR21SNkZxUEp0RW5z?=
 =?utf-8?B?eHVMU0wwemg1dUsya1JrSTFPQjE5Yk9qaXZITktsMmhUM2NSeFQwa1FONDdh?=
 =?utf-8?B?OHZ5bWtHamJ1TmljRkswQ1hwcEt1cC9oSmpNN2hzeVMwZWc5UTdkWFJ1czZX?=
 =?utf-8?B?S2JhTHRJdWd5RDlZSkFQN3VPaFQ4TTVSV05OVUMvd3U2QkdkSVBZZzB3SE5h?=
 =?utf-8?B?RzFaYllhMkl4eWZCT0Z5TDV3ZjFUMkMzeWtwblM5b3o1Z0dZa3o5TzNVSStr?=
 =?utf-8?B?eFoyOWdkSU1XZ1MySjhrN3RiM0FVRytYdFpubFRxRWxUd05WNkxMQ2Z6bDZQ?=
 =?utf-8?B?cGd2aE8vREcrUzBEcGp4SGpaYlNlRDFCVGhrRmpDWVQxMkVLY1RkNGZDcVM4?=
 =?utf-8?B?MzVZSmxpS1p2Z1crYnU3Tkt2TGYzdkdlZWN3QUo5aU5lN1FOandFUFJHQng2?=
 =?utf-8?B?SGc3TC9FOG8rZU10eTlpUXRydFh3NnhySnhUV1k5eHZBUVpCWGhDcUdUc2k2?=
 =?utf-8?B?T1VmMTkxaS9Za3V1aFptYlozaTIydTFYRmRrYndYdkU1bEd0RytGOUhFRk5D?=
 =?utf-8?B?a2toVTAxcG5JS0QzVzNURmVvL0VQTm1TWWFOTEJXZVF6MG9VRWt5MFdGajV5?=
 =?utf-8?B?bm5EUFgxTWpvL0lIN0ZsZXVtRGYvbFYvbHdDZ2lpM0lzc3dBT2ZwR3ZzVGRB?=
 =?utf-8?B?VCtPMkhnT05hME44T2lEUmx2M1ZwTmhVaTlESFJiQ01scEhtYy9ieTNvYkcx?=
 =?utf-8?B?NXN5djBsUjNMSGZHWldxaG1FcjZmanNIOVVxUGl2VUdNYlMzTzVvUzgyb0Js?=
 =?utf-8?B?UTYwN1BwR0kySlY0NDFxeWdaOHJHS3NrR1hNUkpSbEh2WjRDallIZStJZU12?=
 =?utf-8?B?Rk1JTVJVYWFlSHpFR0xTNE9rVWEwdmF0S0Y2SFR2UlhKK0tialF6WThqVHlo?=
 =?utf-8?B?dkdOQmlrYjFLUDRwY08xM1doSEpXb3FBMkpYUFRreE0yekFVSXEybmYvWkZv?=
 =?utf-8?B?L0cxVDdLaG01dzFUa0JNTWlOQlRJcmVYaURuMnI0OUp2SVA5UkxMV1BaeWg5?=
 =?utf-8?B?M29vcTE2UEVHSGdaeGN2ZTZIbFZwWkduemVTanBVSGFvUkRubEt2QVF1WSts?=
 =?utf-8?B?dlhyRDUxeHo0QXVJSVZhb2MwU3BiSGVWUGwwb3NtVTVNNmt2NTNpRjQ3OFMr?=
 =?utf-8?B?NHA5RWp2Vzc2ei9Sa2lvYTVEaWpncTFoem1OQVlxZTB2VHNUQm56ODEyYXZw?=
 =?utf-8?B?S2Rua3dDUTNaSHRSd0RtQWdwemdsWmIwbnJQdUVjenpNV3dqK0tXMnFaYnZw?=
 =?utf-8?B?SDFkYVRRV0t4R0FIekkwUktUcXNkQ3F6ZkRvV2hEeGsyZ21IZHdaYldWZkpl?=
 =?utf-8?B?ZlhXMjJVWDF2MTVZa3JOdzlZcFJZY3l3NStBV1lvTUpGUFo2RHF2S1VVKzdu?=
 =?utf-8?B?VjROSkZsSytIanVRNHZSMURhRU1HQklZOTR3WnNHSlhKdHRvUTNiTjZlQitt?=
 =?utf-8?B?cDllOXVGVm9MS09LZFBzUlVzWEtpY0E4UnlnK01PM2lIMlFNaWJUb1FhcU9Q?=
 =?utf-8?B?cmttOWhKRUI4eTJLRjN1LzVoV3BwTXgwcDN0Y2I2VWFYMm05V1RkWUtVUnNT?=
 =?utf-8?B?eFIrTnM3UWloYnVhOWlnSUlhM1hDREpqQVpwS1FKamE2UDk2LzZZRW9VTDFW?=
 =?utf-8?B?UEZaZU9wZ3dRd2RKNXlhd3UveGVNWXdldm1CTU9VZUlBT2E3aVNxT1g1TVY2?=
 =?utf-8?B?bDh3QXBhTGRIODVYcGIyVWV3Sm5rMkp1OHFlZ2xseWVhYVhOdUwxZWg1S2Ur?=
 =?utf-8?B?Q09nTDJXSktMemxzOWxqdVMvQVUxM1FLTUptYzZjY0NxYU9iQ0l1azhlTnVY?=
 =?utf-8?Q?j+nY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a83f9d-0aac-4118-0234-08dd9835ff19
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 07:06:24.0259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ts/KKWvN5xxqcWqypXQadswHJkcVFSvIf0QCEGyFkv8ftwsYvEyQH1UGQkBOdG/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
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



On 5/14/25 19:10, Philip Yang wrote:
> To unmap and free seq64 memory when drm node close to free vm, if there
> is signal accepted, then taking vm lock failed and leaking seq64 va
> mapping, and then dmesg has error log "still active bo inside vm".
> 
> Change to use uninterruptible lock fix the mapping leaking and no dmesg
> error log.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

I'm not 100% sure but I think I've seen the same patch from Arun before. So don't be surprised if that is already fixed on amd-stangin-drm-next.

Anyway feel free to add Reviewed-by: Christian König <christian.koenig@amd.com> and push to amd-staging-drm-next since that change is certainly correct.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 3939761be31c..d45ebfb642ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -139,7 +139,7 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
>  
>  	vm = &fpriv->vm;
>  
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_init(&exec, 0, 0);
>  	drm_exec_until_all_locked(&exec) {
>  		r = amdgpu_vm_lock_pd(vm, &exec, 0);
>  		if (likely(!r))


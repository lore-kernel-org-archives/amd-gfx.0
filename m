Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F126C61DC4
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 19:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B0B010F17B;
	Thu, 27 Aug 2026 19:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RNSxlEQH";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3675C10F17B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 19:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBANepvwGN3lPamnRHJ8YuZ995hHmsHOr2zm6zCOQa5mmNJfM0gAY5rS0teA/WEgEJiE5BPUfKoIxNBxV2EGC1pNoNfpT9GS0axDxyKiOCJOE9SKhP08Opq+rXoWxSvSXhNilhNAQrFEEe7nUe0z0x7flL7pOvfF1T3FyY7ziD1+Yj6josI8nRqswpuntEwUMgkewfvVnfimoKVekRpGm9fKs1glb74LSQx2uw8wMZpe/gPFq2kTauzEIVoNojW7qDt8rj6lla4Hu6t+ncpLNHwTVTgNHLA/Ea8k9Cjn7q6ISp1bRY1leVhcWtxMSa5lDuNt7jJReWflfAxylPKsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKRC5x/vzQwk4B3hoitH/6dd3cw3ys+UqfNkSOboWRM=;
 b=meoX9PdnS958nVwNjFjjS3ih3JK5OrXFXaaUI3pcITz6FcnxgFIUrl7bXu6MTZDVoUXMaf/yD4YQjN5HxoVQnsTKYMR8B24K3/rQz1mI33W2AzrTaYJoIleIYNUq2FFMqI7+2+nT42cGINaytKBarQVpGmcgRCqTiCEZEav1mWrLHioB7nY6ojmKhnxsh2aplxTsT2tmVkcq97hO/KGtvriT/FdBRAxFK4BFLvbjCITKfwtV0SrX/hQSU1ihM1noDH7Gzr+q92pzBQj0UKWH3EWMeZcwQhf6njw9VcAiiUi0fskeTj47x8PBMwtdsDt5YM/ptTFTk7n/KDDL06uqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKRC5x/vzQwk4B3hoitH/6dd3cw3ys+UqfNkSOboWRM=;
 b=RNSxlEQHAIO+fqTm6A22eY7nKR84slEM7hL4V9ldhO0aJPBii3qIAjCP6P3xrSVRTrZPbVmRLlDZe/YJk3ZKg4x+LzZxh5Y1284/Le5Rv56mYgeruqZ7+1t6Rlp2oU+08cy7OnufhPm2KjJE91KlCxaWvYhvtO+EhgSMEBjpIbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DS2PR12MB9824.namprd12.prod.outlook.com (2603:10b6:8:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 19:12:11 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 19:12:11 +0000
Message-ID: <19698530-316e-486e-9568-ebd0575e1eae@amd.com>
Date: Thu, 27 Aug 2026 15:12:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Enable HDMI FRL by default
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260827155409.1426730-1-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260827155409.1426730-1-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0454.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::19) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DS2PR12MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: 486f6375-dd0a-4183-e654-08df046f188c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|18002099003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: N5s/XueoRPGs5yYYc9fI5JreEPSpjwlgCzeYxUJhK7SMcJjLYODhL6m0au2GDYQV0YR8jtrCv3HCgs1UPVn1apbWFqeALkkNfYMmrrFkLSmPiYs/5EKuQdt0RrRYum/6Fd7/Fr10j+sRJKuBB/1icZ3d6c1N/7aIqHpFMbligaEB8iyc/hprQgC0SRCl2YvRPdNvr70bDkAK8YnyIahmkJ6yuobW62WkjLWyRueczaQ1OESCnSZs6B4byfXARjBelyObqt/UdT7mBQTF/lMQZvO+9A6sT3vfOtHTeDRbGUuc8IPHHwX30lAGt2nkn/hG0s9zLHnzU1v21FkJUKvr7DpHS16DGOKgbylJ6av29pYyY3guSJdBd+5Dzn1G/MAxN2HcvG8LmT61VR8+A1AgaecEzqkk5ejEmppJpmWkGTNnniB5tBtqBzTvfhPPzNDybRQjxvQm8Ax6b7DQiK9LefC876XRa/AjJv1Ge6cJ5BMWBUYX/wlb/eR17DK4XYWJjxqGMqNw4qQpJXk1tDf5YwogRztmy2gq1iA3zJHEiwd+Fb/wcDycHy+d3paAK17yV65q207lPYFVs8c08WB4Qq374A9KY/OHOtsGMmuMKBalcFcldC1HLne9dtRW5UWypAUhOhnl8gWgaJpV+GW4ChoerhQPUyKk0kYEEt7Us4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjlHdHpMdXNoTDVKeEJITWZlU2lPVG5KNTdWRUlXdFBZTXZGUmFKNGlBd2Ey?=
 =?utf-8?B?NklEeGZMQlNiMnNrN3M0RjllSFBaK1RHYVRDYW02R1g1a3IwUFN6QVdGUk82?=
 =?utf-8?B?cS96UUdQWStrTTNSS05jK3R3a0gxWHB4dXVLZUo2a0lqRXRDWDhEemtHcWhP?=
 =?utf-8?B?WUdUMUpLWWxxWGJOa3BaZCttWUtKZ2phTGtRZU5FZWllcExKUGV4WXV1WENN?=
 =?utf-8?B?UVJIZWpCQVl5QURVcFZweXN3WHN6UE5FeThtelJXcXJoUXF5dC9DRHp0U1JU?=
 =?utf-8?B?VHErY2hTS3RQSElpejhvRnVtRkJJLytUTjNEV1NJZkI5eDA4MHFVZFlRcndx?=
 =?utf-8?B?a2FzV0xGWGRldXVUUWRYMlNWNWpKdTBmYU5pT2RzQ3lSYmxyL1dWdG8zR0JQ?=
 =?utf-8?B?ZnljRXBvZVdEM0I1K0p0a25GWFpBZ3RvZnBEME9YSUlJTnJJTWlZalpzMk9q?=
 =?utf-8?B?WGJ4bkJFL213Sk1uT1hEQmpWMmhaeDJiQkMzK1VsKzBsbTdCaGw2eVQrUGVK?=
 =?utf-8?B?dlJCMjFhck1vTWRpMzdBcUZYWTRYZlBDYngxV2NUWGJ1dXl1bFZNZmU3Vmtr?=
 =?utf-8?B?UGh5VE5nL1VMZHdlNzBaT2hzMkJ2eDRXVzRWVEZEMVh3N25ZL2JyUHIxR05w?=
 =?utf-8?B?L1FPZUcrUEJEODBEb1Q2QnhIVmEvVXhaQ3JxWG8wdWk5YTVSWkYvc05ka0o2?=
 =?utf-8?B?ZHBOS2tYUnBEZUx6VWI3MG81alVNWHBGemdGbVoyNFlMOXlrdDBDSm9kVldX?=
 =?utf-8?B?N3krci9ESlNNenZrTEJzRE1LaHBraDBGanpzQk5tNEJWOVVwSVRxY0tqWGxQ?=
 =?utf-8?B?K2VLcExqT3B4QjVkQzRpdkljMm1pRTFzckpMcW1pR3VtZnRtNldyaXR6dzNw?=
 =?utf-8?B?MUQ3RTQ3d1Z6NzU5THovU1RvNkNDTlE3TVRWbmR5Wm41eVFMejMwZmRndmR5?=
 =?utf-8?B?S0ZCaE8vVUo3aDB3S2htWHFqdk55aXRKcHFnN3E1QTlNOEc2WjA4Y0pIWHhx?=
 =?utf-8?B?TldkSnVqNzZtc2JLSktVUWQ3L0Q1UExCMG5DMmhRZ3lqM1haZ1hhQ2FLNG5R?=
 =?utf-8?B?RVdtcGpWQlF4MWtSQ1c2V1l4Yjd5REdJMnd1MmkvNE1zdXFMZEQ3b2ExRFVV?=
 =?utf-8?B?dEdlTEo4TTk0UGYyYjF3UHBMNEU5OXpabU43MzVpNHFRNFloY21tajJacTZR?=
 =?utf-8?B?MGExcGtFdzZPd1BvNlRRTkR2VmZ2V1d6MTNiUTRtdmYvWHgxLzNOL2lSTTQ5?=
 =?utf-8?B?OVpxa2t0d2ZBcFpGbTNGYmZ1R0lJR3RHcHMvVEZDYVFFMkx5aGVzKy9wa3VP?=
 =?utf-8?B?VEJvVUdqaVRiY1lMV0lMNTczUmVDem9Cb1pFNmRvRk5qZFRabm5TMC9GQy9Q?=
 =?utf-8?B?OVNyN0lQSVRYeW5LZHArWU9rYzVnVzZaVm9aVjJ2YSsvRlJhRzVxRVY1SFdz?=
 =?utf-8?B?S2g2Q2RBdDZETHdZc0V1a0tsbkhZWGNGTDF0dFVFZCsxQlpnY0haYUVFeE5r?=
 =?utf-8?B?ckYxMDBXbXozV1hvbW45c3I1MTNvUDVCeXJuTlBJdVd6anVoemdSY3hHRVNK?=
 =?utf-8?B?ZkZIaDZxaDJJYkl2VDlXUDJzS08zaVVZTnJKVUs0RXR3RE5GQURVKzl4U0Js?=
 =?utf-8?B?K0JUS05nZXp2UVVST0dJVkxKQWdxRlBZZmNOc3ljdEFhNmlXWXFCSE5ubitm?=
 =?utf-8?B?d1RXOWdUSUV2empldFFVSjBlbGtvL2JFYVVvMnpJUkJpZFFHSmptNnFwRkJl?=
 =?utf-8?B?aUw5c3MyK3phREIxbFgzb0s0Q2VzNW4rWGpTVVJXME9aMFVFUmZkdUFnQ0NK?=
 =?utf-8?B?c0NWMVZWQUUrbW4rWEdXVUJpdFVTcEZSdWVmRmdGdHYvM0JQZXZUUEJ0dHcx?=
 =?utf-8?B?eW1JbnJUOVFrWDNBQmczVHhYTlFHY2ZPUXNhRDRrZ3hZRG1xcG9CZWdYbFZS?=
 =?utf-8?B?WFVnK0kvN2lkR09wSnV4R2NXaGtMZHBmeHBiOGl2SmhxOEpLby96K3d5Wm5Y?=
 =?utf-8?B?Smdad05XSFJ2OGtQcEdNb1F2WUZXckpjbXg1a0hUTnF6RCs3VHZwSjI1M0hJ?=
 =?utf-8?B?ODB6cEdzcys2S25JdUM5RWJDekpFVDRBbGNsemdYdCs0dStrbXdCMUh3Q3kw?=
 =?utf-8?B?bVdBZFFKbjYrYzJGNnFZMGM2VXhCMVRLQW4rUHFtcUw4SjZLRVZaREVQbXVQ?=
 =?utf-8?B?cmRlMEhnVmI1cUlKeUNvNENHdkVOdEVyV0lVdU1wRkhUUitSYnNrRDN0YThD?=
 =?utf-8?B?UFFhMEQ5ZUkyb1BPK2xFOTd0RWdyUnhZSDAxUWYwRndhVHFIMkplSGk2RGxE?=
 =?utf-8?B?R1pSR3JSc3hmL0l2OCtOZmVMNUxKbzVZVTBXZjVLOStoYzZiTTgrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486f6375-dd0a-4183-e654-08df046f188c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 19:12:11.1470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Opj6qfGOl27S4rjKFyD6u0oKtVkmlhiROaNMUFx67cOFciivh//2Hd5zvvHVqxnUZtYVjlbePrWbZx4Z/sX99A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9824
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



On 2026-08-27 11:54, Fangzhi Zuo wrote:
> FRL (Fixed Rate Link) is required to drive HDMI 2.1 high-bandwidth
> modes and is broadly supported on capable sinks, but it was left
> disabled unless a user explicitly opted in via the
> amdgpu.dcfeaturemask module parameter.
> 
> Enable it by default by adding DC_FRL_MASK to the default
> amdgpu_dc_feature_mask value, keeping the mask semantics unchanged.
> 
> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 3 ++-
>  drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 53738b40c97f..9c2ff3e147d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -218,8 +218,9 @@ int amdgpu_smu_pptable_id = -1;
>   * DISABLE_FRACTIONAL_PWM (bit 2) disabled by default
>   * PSR (bit 3) disabled by default
>   * EDP NO POWER SEQUENCING (bit 4) disabled by default
> + * FRL (bit 10) enabled by default
>   */
> -uint amdgpu_dc_feature_mask = 2;
> +uint amdgpu_dc_feature_mask = DC_MULTI_MON_PP_MCLK_SWITCH_MASK | DC_FRL_MASK;
>  uint amdgpu_dc_debug_mask;
>  uint amdgpu_dc_visual_confirm;
>  int amdgpu_async_gfx_ring = 1;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index e3baef809cd1..7e29fe312ac6 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -287,7 +287,7 @@ enum DC_FEATURE_MASK {
>  	 */
>  	DC_REPLAY_MASK = (1 << 9),
>  	/**
> -	 * @DC_FRL_MASK: (0x400) disabled by default
> +	 * @DC_FRL_MASK: (0x400) enabled by default
>  	 */
>  	DC_FRL_MASK = (1 << 10),
>  };


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F50C83F09
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jul 2025 08:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC8510E768;
	Wed,  9 Jul 2025 08:40:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MGoCcbB3";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8552010E766
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jul 2025 08:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVVb/YTMiwzEsL1MuIFNMrF7xKIxJre5GlObEW/pCItCPsW+QX6LhinLGdnldvJ+Fhe412fcwBclNwPNFsYxav4piOlWJ/iHFiOMtWyCTRT+ji6LldO+FvRzyuqD9ts8kINHr6PLb49nTuFTrjt1iv6/AgGapBrETLVvUdEN5drLC0yOgHkP8NmykJVpeerakPB7H3agimVI9mK5iRftTR1+/V3Z6Ca073UiwHQjTQiW2SQSFYHst41lZIQTzMcVpS6xm8nHwnZrL4GGmPHCc6y6RMAKVSTDpRjwZaqiGjXF8gazIHV4ZPwRiFmaANV+cUXnmm6oyCy7j0V9ff0TvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtBkY5ihtb+tvzc1EgNhCE/PwaE6QhyXJXuHzcbaxB8=;
 b=nHN09ThyByreRZG8w1VD3y931FKbw4+104fJXFi77otfZI9xdhZkya+ssR+OWY2dA/AivjEtzukPexxZ7L/cOevXKiFiYIaZAUICRQ8CjqQWtHhiYQX4nk32hLAZTMdCbebr16GGZbaBULjXn086rpjuYB/P2JcmnHklaWK36E55HCBz3+4DW/emJ9kRjmms9CHh4dSLXWh7cvgN0IVvdNk0IrU8RZyz1kVoQBEGjxVBFTigNgEFh9MmGUvE2edKeCVY5hvCu8b2qeFuugz3Q7TgK9W/lJ3rL5+IhvTq+3EShh7RF29LIeooSbe4Ih5J3/6pyezpH+mIW0616VDOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtBkY5ihtb+tvzc1EgNhCE/PwaE6QhyXJXuHzcbaxB8=;
 b=MGoCcbB3fDkwJgjtojvkUETDoQ2IGe4N0qWSU1CgzH8N4aq/cKgaFEErsAGJDhbBPiKlZ2arxN6EnqWcfQNm5+wOBXqNSswoqk9Gg3krWaaK8HvYw2QlWkx8tfOmbFwHFvJRzxIVWmeTs8z1neX3uxZlpq+7gNljrZ+lK1GwEdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 08:40:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Wed, 9 Jul 2025
 08:40:12 +0000
Message-ID: <057716a5-9817-4115-8852-53122500dcf0@amd.com>
Date: Wed, 9 Jul 2025 14:10:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: refine eeprom data check
To: ganglxie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tao.zhou1@amd.com
References: <20250709082915.18904-1-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250709082915.18904-1-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e91c16-8f1f-4df9-003f-08ddbec437d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K25hRXMyM2ltSnVtVUEzTkRVdkI5WENXRFoydklQSFdudzUwenFVeVlLWHQ2?=
 =?utf-8?B?d2dVOENKZTVSSDRETm83S1lkalR0Qk5sM1Z0djdFcWNQU2JTaEVGKzdRVlBq?=
 =?utf-8?B?YWp3dThldXpsNjVzQjMyY250ZFh1cGFKNnhWSERaRFQzQUp1bm9vbTFVZzMy?=
 =?utf-8?B?cnFnWXFtQm1xSmhZYVk1RWFySzlzYkNUQk96NjdqLy9nVGhtSWszNm9KWm1j?=
 =?utf-8?B?MzFuRXcvMllFalU5eTcrdnBQeWdLVGhldDlGN0RWRms2RWd3WkNsam43aFV3?=
 =?utf-8?B?dzBaaG4xajR1NDhQNU1MZmZsOHJaZXcxaFFGeEJBbWpueTdLRUVuRDRhQ2Iy?=
 =?utf-8?B?NkpzQ1M4UFdOZUZCVWEzc21KNDR3RFJKRlVza1NDQTMwSFJqRnB6clMzZEhs?=
 =?utf-8?B?MlU3d0FWUHhjZjl2RU9iR0dRRHMrUzBLT2tvTHRKcGlBWFRpU1d5ZUtSNHU5?=
 =?utf-8?B?cUhINDBDUlVBZUlaaVBNVDRzaDViTzJaLzd6SUtIUXBlVlpnVjNhRktmSHNC?=
 =?utf-8?B?MVZ5UWtsTGtkOW5QVThnV3BieU9FeE5qdFZMaEkxYSt6d25IMDY1SGdvRTl3?=
 =?utf-8?B?V0E5M01TRVlNMGlSeWc5aW4rK3gxMldCaWRURjY1bXoraHNmc0FzZDYwSWJW?=
 =?utf-8?B?REdyZW1OVm12b0VtS0MxenhPQk0zTXoxa0w3OWkyZjVXSVd5YktnYmhsaWdM?=
 =?utf-8?B?TVhPVDVTUjFiZ1VBNWtLaEFWQ1QxRVF1NDVxSFpBVkRhckxYT3RCQWRLNkdC?=
 =?utf-8?B?aVJ4UUxpU0hQNGlmcmxiVkU3MnJIdE9ZOWlUMERYSWhCb2NjY3U4akpxL1pE?=
 =?utf-8?B?Qi9UZHBRSEJBNVdLR05UZCt2ZmVQTWthTzA4OFBNN0xmYTF3TXRjclNpY0sr?=
 =?utf-8?B?MDR5S2pMWHJydG5GSUUvakhSVTlFWXkwMGlNTnJRd2p2RWE5QWNveGJQU3Z4?=
 =?utf-8?B?aHNhVkJaT29mZFkvK2lHZzFwRkY2ejhheGlkM2RidlRINGlPeSt5MmhReTNv?=
 =?utf-8?B?amwvQnQzcUJYOTZiQVByMVlNZDZpdGREeUZyS3hUQkphK3ZseDRmZEpLdjZQ?=
 =?utf-8?B?N2JTNHM0ODd1bjZyS3h6V2FoOGFhbHFBcFZFRFl5dk1YcEdSREE4azFoNW1D?=
 =?utf-8?B?ZWFRNmI2bmxtc0lUakhrb2tyeE91UUlkWkdsbk5DeS9hK3dyTkMzVS9tZ05x?=
 =?utf-8?B?SDNRcVVHVE81M0hZekV0dEN5d09DdExucStiNkFsdFE3VmRLWllBeUVYNTJr?=
 =?utf-8?B?MmRrZ3AxV2tZNXc2dlZTQ3gvWGpEZVdLa01tY1kvSGZnU0dkT2s2VGlsSmJp?=
 =?utf-8?B?VEQyQjAxOUZZaEFzWmJPeU1COXJxbExQay9Ia2JMK0dKeGM4bDdZMS9mVlpl?=
 =?utf-8?B?dVNZL1ZCSzdDaVhYV1hwVzV6V25Xb0ZvdUM5TGROY1dHNzM0dVRRNzRwYTl0?=
 =?utf-8?B?NXdnbE8yMEpsQUJURHMxUWFDa0psSEl6VmUrdTJTMGNkbm94bTI5bHQvdlVr?=
 =?utf-8?B?OXQ5c2Q2azVXbWxlT1RHN3g2RnpJbTlJNm9sRU5NelMvcHFlczBrenVUWGh5?=
 =?utf-8?B?QWlJTXlaT3JEZVc4L0IyVnNzQnpJV2NwNkZDL0xCSjJzT3dJVmVoNnVtTGp3?=
 =?utf-8?B?VEE2TDlQeUVmWG5YYzEyc242aHc4NFN6VEhWMkE3Vy9QeHJaOVkxY0R6dWdh?=
 =?utf-8?B?ZnhmWjhNbGxKcWQvZ0h6QUxGZ25pMFpLVGN5SEhYNU5XMlZ4TWNHUE9hQ0FH?=
 =?utf-8?B?cUpRT3BtZDVtbVVmdy80MFIxQUpkdnBNRDhQNnJuenQwc3AvekdqVGcxLzF0?=
 =?utf-8?B?QndwSEhsWHg5YXFpQ0lHN2ZacjRnVGxlZTR2dlU1RUx5YUZIS0ZkV1BZQVRY?=
 =?utf-8?B?R3VtUzM1cUxkUjc3RmFhV2tyd05UWm8rYThHeGorRkNoZ1B5NVBWY0x5TkRH?=
 =?utf-8?Q?d6NV+x8w010=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1FNZ281ZjFhVVFLTktIYkloN3NNTTJyYjJwVFZvWmZ0RHoyYmk3WDB6REpV?=
 =?utf-8?B?ZVlyWmRhMzl0N3duNHp1azZsMDZuMm5tUTFyMWZLNUUxa2x2b0E1UWFYKzNo?=
 =?utf-8?B?eFdGd1VmSEN0RjZ1bnk2TzZOZC9EYUtOQjFTM1Ixa21HSkFvT0pzNnU4STFz?=
 =?utf-8?B?Nyt4VG9jRmY5OWFIUWNJeUxDUjVtS2ltaHdvZUFkRmwyZ0RHNzZQakRqNzFL?=
 =?utf-8?B?Mjhzb1FwM1ZQei8yOUVrM3AvVllzNExIYWloVlNDdHhDeExDcEtGSWxqU3Bl?=
 =?utf-8?B?K3dlZFBQWDFUdzRLeFNjbGtqVHR3RTI3M1FUWVowUnJ1ei9yWVNwQjhmTlJW?=
 =?utf-8?B?bi9hUUt1YjJ6OXEyNi9DRlBzYWZFc3ZTeEs4TG00eHh0dkx6OU4rUnhYQ3lS?=
 =?utf-8?B?RUtsNWNtbUU4VkxxRnhxUmR5UFlITXBtMlhlUVVoMDBiVWRIa1Z3R2FPTkRv?=
 =?utf-8?B?UUNQaDJFMnBFaXZIb2NlMjZpYWZzdHh2STZjczExN2pIZHVIVzdjckdaUWJ3?=
 =?utf-8?B?TVBlcmF2anJNMHNHZDU4MzNSVWd6aXdFQzdRWmtsd2RpZXo5Um5idjZBZnBE?=
 =?utf-8?B?YjFBVlJ6YU84L0czVmd3a3VQVWJQTmFrT2J2Qkg1Ky9ZTnFFUzkvY2JDam0v?=
 =?utf-8?B?UExBaEp3aGZGL2orT1ZYOTJydFArbzBhZ2xNa3ZJR2RZaEg0N3NuQlJkSE9l?=
 =?utf-8?B?SDF3Q3U0eWt4ZFVoMXU0Rktaa3dGS3QyU3ZSL2hXUDRtVGd1SlZ6R284cEFD?=
 =?utf-8?B?bDBNM3lrUS9palJDT0JEY3BudGpjRitYcnRZVDlYRjlXR0tuc0RQWDRJRVAr?=
 =?utf-8?B?bXROOEh5eXVyS1dadDB3SkRnbk9NV2YweXJ6b281eG5wYkNpeUZpU3ZCa2pz?=
 =?utf-8?B?NmdxL1M0Y0MycnUvN1NHdUZpMlJ6dnYyaGtKTUJFN0RyekFONmdZZ2Z4T1RF?=
 =?utf-8?B?WGt6UDdQdWlydk4zWHBiMFljZ0tnU2M5WDRaaXNDRHdrN2czbXR1dnNhblY5?=
 =?utf-8?B?b0NWbEd1YTEyMG1kVDlmZE9GdG13dm15UzN1ckRLa3dRYVhFVk1aNFJudkdF?=
 =?utf-8?B?U0pWQ1AyQnlyYkJ5YVRzZGRqTlcya245OWdtYW1YbndGTzRoOFdvOTFqOWQ0?=
 =?utf-8?B?T2UzeUJYSDhSOFR4UlJxQ3p2YmlHTnhTV0JBOTJpdEFJMkdIY0FIcys5TjhE?=
 =?utf-8?B?UXJ6TkM0Tjg1WWFPVVF6UmpENEdlUEMzNjFHSTVWMEhzWWE0MXFmYlZTU2Z3?=
 =?utf-8?B?Q3ZZUFRzK3JENEl3c04xcnZvUVpoR3JUdWowa01EUUNaZnBXQWFJKzR6T3ZI?=
 =?utf-8?B?RFJ5bjcxWVRUVDB5U2l3STQwQkVYUy9kUnJDWUFmREkyeXJLcFNTVnNPeUcw?=
 =?utf-8?B?dVIzYkFoRUYwSTEwMUhaVllDSDVvbDBLandNUExxZTJmNjBMQis0NGlOOG1u?=
 =?utf-8?B?ZWp6dTZTSUc2NFNEUDF0MTR3dnB4aURPR1l5QUkrRHRYNmw4OUY1dXdOYUtp?=
 =?utf-8?B?TSs5TzBFR2tXUnFZUDR4clJmSDIzN1llM3lQZFRGTW9tY0dFRXlGV2tLcm9u?=
 =?utf-8?B?V1hsMUd6RUxDRGsvQ3pKZ1FjWFY5NnpZVHZ0OW9ZRUFPSWxEcFQ1QXlOcTFN?=
 =?utf-8?B?Q1lqcm9zbDRlemFjdS9ScjM1TjdlT2hnZVRQSTlSYnRNZEhHTzBPZWtrb1hk?=
 =?utf-8?B?UnFLQVRkUC82b2ZGQWtHUjdsUGRhVHVTT2d5SkRueFIyN1JuTWpkS0tSNVEy?=
 =?utf-8?B?YW9UeThHS3Noa3F3bVdGWnRNVllacXgxY3MrTmdUOW5HWXlyMXBrRk45Z0li?=
 =?utf-8?B?QjF1bjI5bHl3V0V5WTM2eVc0N1JRcTJIQ2w4NWpVZ1F5VHVOKzRYaFErYm9H?=
 =?utf-8?B?NnNIdXNhOVk0c1JTeEFCZDM5NGtkVXdsV2lVWlhuOXRhdDBXQ1dOc1R1L05Q?=
 =?utf-8?B?dDNSUXlMRVBLYnpoR2IyNHU1SkFhSTVCV2J3dXhBYlNZYWQrK0RtQXpFN2Vh?=
 =?utf-8?B?VmZsUXdkR1ZHY0NkWTZjcTJWSmNVQjk0QVMza2JlWEp1YVZmWVhHUlYvM04y?=
 =?utf-8?B?OVdFODRUWHA2aDVhNkJLN2U3T09iSjNWZEdYTXRuSlplNVkveXJsSXhxeGRO?=
 =?utf-8?Q?3JV+yo+oHxGsIkA2qBfh4SXKt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e91c16-8f1f-4df9-003f-08ddbec437d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 08:40:12.1676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKmj4zlyKIE4VvbIa2YE1BSHlGxWgImbo68dAQXUyOQ5nVg5ANblwJzlt/ZaGM/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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



On 7/9/2025 1:59 PM, ganglxie wrote:
> add eeprom data checksum check after data writing, after gpu
> reset, and before driver unload. reset eeprom and save correct
> data to eeprom when check failed
> 
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 13 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++++-
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  1 +
>  6 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 84fcaf84fead..2503f2300472 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6410,6 +6410,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	struct amdgpu_hive_info *hive = NULL;
>  	int r = 0;
>  	bool need_emergency_restart = false;
> +	enum amd_reset_method tmp_reset_method;
>  
>  	if (amdgpu_reset_domain_in_drain_mode(adev->reset_domain))
>  		return 0;
> @@ -6506,6 +6507,18 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	if (!r)
>  		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
>  
> +	if (reset_context->method == AMD_RESET_METHOD_MODE1 ||
> +	    reset_context->method == AMD_RESET_METHOD_MODE2) {
> +		amdgpu_ras_eeprom_check_and_recover(adev);
> +	} else {
> +		if (reset_context->method == AMD_RESET_METHOD_NONE) {
> +			tmp_reset_method = adev->asic_funcs->reset_method(adev);
> +			if (tmp_reset_method == AMD_RESET_METHOD_MODE1 ||
> +			    tmp_reset_method == AMD_RESET_METHOD_MODE2)
> +				amdgpu_ras_eeprom_check_and_recover(adev);
> +		}
> +	}
> +

It's not required to do this for every reset. You may check reset
context source as RAS and then do a recheck.

>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 571b70da4562..1009b60f6ae4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2560,6 +2560,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  
> +	amdgpu_ras_eeprom_check_and_recover(adev);
>  	amdgpu_xcp_dev_unplug(adev);
>  	amdgpu_gmc_prepare_nps_mode_change(adev);
>  	drm_dev_unplug(dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index f8a8c8502013..e03550be45b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -196,6 +196,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
>  		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>  					 err_data.err_addr_cnt, false);
>  		amdgpu_ras_save_bad_pages(adev, NULL);
> +		amdgpu_ras_eeprom_check_and_recover(adev);

As mentioned earlier also, there should be some way to identify when
this is really required. We had plenty of issues in the past with
delayed resets during RAS errors. Introducing more handshakes/I2C
transactions with PMFW is strictly discouraged.

Thanks,
Lijo

>  	}
>  
>  	amdgpu_ras_error_data_fini(&err_data);
> @@ -3539,9 +3540,13 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
>  		/* The format action is only applied to new ASICs */
>  		if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) >= 12 &&
>  		    control->tbl_hdr.version < RAS_TABLE_VER_V3)
> -			if (!amdgpu_ras_eeprom_reset_table(control))
> +			if (!amdgpu_ras_eeprom_reset_table(control)) {
>  				if (amdgpu_ras_save_bad_pages(adev, NULL))
>  					dev_warn(adev->dev, "Failed to format RAS EEPROM data in V3 version!\n");
> +				else
> +					amdgpu_ras_eeprom_check_and_recover(adev);
> +			}
> +
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2af14c369bb9..2458c67526c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1522,3 +1522,28 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
>  
>  	return res < 0 ? res : 0;
>  }
> +
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +	struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
> +	int res = 0;
> +
> +	if (!control->is_eeprom_valid)
> +		return;
> +	res = __verify_ras_table_checksum(control);
> +	if (res) {
> +		dev_warn(adev->dev,
> +			"RAS table incorrect checksum or error:%d, try to recover\n",
> +			res);
> +		if (!amdgpu_ras_eeprom_reset_table(control))
> +			if (!amdgpu_ras_save_bad_pages(adev, NULL))
> +				if (!__verify_ras_table_checksum(control)) {
> +					dev_info(adev->dev, "RAS table recovery succeed\n");
> +					return;
> +				}
> +		dev_err(adev->dev, "RAS table recovery failed\n");
> +		control->is_eeprom_valid = false;
> +	}
> +	return;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 35c69ac3dbeb..ebfca4cb5688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -161,6 +161,8 @@ void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
>  
>  int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
>  
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
> +
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index bfc86f1e84e5..081f7fd29394 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -80,6 +80,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
>  		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>  						err_data.err_addr_cnt, false);
>  		amdgpu_ras_save_bad_pages(adev, NULL);
> +		amdgpu_ras_eeprom_check_and_recover(adev);
>  	}
>  
>  out_free_err_addr:


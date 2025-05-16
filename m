Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C79DC3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 10:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A7110EA38;
	Fri, 16 May 2025 10:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v+s5NvEu";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3EB10EA38
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 10:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnzzddfIwDD12e/ZxQhhWYRDChWM/2m1Mhf+pRu26KOtPv5C+PpagWHjb5+76oouNfK4hYMQVWyKlk4Ax3KasnZ3joe6S2E7rh0U0/EhjeugeYi6g34t2OvBNwxht37wn968qFpE/XDkvsktsPVVxJQrjzBqsAu+1eiJw2KLdIK3NdvxDtOrg2rK8WhgNhqfGU31YLkHcQnmA26rsrc4X3nJs+dbCzDiN7bxNObi2oA7CXl6m1v0vLCVRvITZcn3PVb0QDQWqFEYUIx7dfwb399ZYm0DrnCplX2qPitrghivqY6P+z2DX5BMFyR8krq29xZeDFfPPq2AwGvKV+Z83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncPq9z6Sv0PTZiKbLZPLk0NnCgRToneOXvSDrlQhNCY=;
 b=Bi5WhGwM22VcSRxIqQS8wBvT8Q3U0AAF4b+HTWduIOgre8z9NCyRpwDpW7CCf9eRoJF7PqYH0zHKTSHfndY5qlaTPsq0g3/m0kknpzmmKnydkJYY0FtmmQXlhuyLfgIVxZO9tZ8AJBgQHjiwWC0KUOExVA+N4UB6DfUXIutHucUZHXIVpH9coDAUtox6Lvg0UKEwuLWk0xx6Mpm4phmBUDCiNKFCM0dxjgRk6T9e2JZpNaTZjrgbgzr08uFZ2ih/LMrQIkjuetHJ5kBoUriEsSKt6xawNTjxuHvzrejm3/D2PCjjNmgX17e4OmJMEMt1/Sn8l47aaqTjtt2bHXT6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncPq9z6Sv0PTZiKbLZPLk0NnCgRToneOXvSDrlQhNCY=;
 b=v+s5NvEuxg8yuQI6IIiDFRKDC1dmxrvcJbHsm+se6u39fwp5ye7BPrpezRXq+E0a43qQgZYMLvnIhQdxRuefcBdNITaVq+wajeur+ItJue6mOSSEQlwlrlGuJiLc1ZsXXYKuJABYHnHYEwD/FHqHaiFnhqFmG08rbaOehNRY1Jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 10:22:20 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 10:22:20 +0000
Message-ID: <72e81b07-c4d6-41c1-9739-56cea731a240@amd.com>
Date: Fri, 16 May 2025 15:52:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] drm/amdgpu: fix fence fallback timer expired error
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com
References: <20250512064141.387079-1-guoqing.zhang@amd.com>
 <20250512064141.387079-5-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250512064141.387079-5-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 699af587-2c83-4954-682c-08dd94638a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHUvODBLem0xU093T1JDcWV6a2FqZ0NTYjh0djU3OVB4OUlRT3EyZy9KaU1P?=
 =?utf-8?B?NFdoV2psZnFBWUJoZyt1WkVHRWY4VWhkbzRXcGhOdy9wSGJTZUdmMmRucmlw?=
 =?utf-8?B?cEdkWUFza0Q0VVE2SzZ0WnFZQmhOTkJ2ajdFNytRRk1Wdkc3dlZMa2NBa1Ra?=
 =?utf-8?B?YkppZTdsOVZOdDhic1hUUWFrSCtTOHZreURSMytLY1RmVE5FNkZhWHdCQ0Jt?=
 =?utf-8?B?MGZISldpU0c4dmZsMTBKUlBUakNWb0FhRGRETVo5aFFwVnNadDZDMm5hSUZ5?=
 =?utf-8?B?R2ZRa1lWMHhNNFo0YXRRak9JZFZGMG9CR0lYSWtJMFpVR3ROc2ZTNU5YUXRt?=
 =?utf-8?B?NFpmSW9haXRmQ05RZTlPOEpGeFk2RkNiSmd4dmJmVzNla3VCTmJoVTNPbEtl?=
 =?utf-8?B?Q204MjJqNlRLYUVLdElOQmhCQkVReldnK3h1M0cyMEFQYUZxeCszdTMySlM5?=
 =?utf-8?B?Sy9sSmo2UmtkZVlDSlo5WVhiQ1pIRTFXM05BWDRkZGloc2E0YU8yL3FIQ1Ny?=
 =?utf-8?B?MnlwbVZEdFkrcUg4bGVKb0N2anZZK0lxMCtyZHNzakxjemY0c0haeXFMaVRQ?=
 =?utf-8?B?VUpjaFpCVzRiTFZjb0E1NkliN2NOUStucisrcjhUZGRHcHhIaDUrWHN6Zy9M?=
 =?utf-8?B?dHhCck5IUjl5V2d5bzJ1WlAxVHZ6UkJBQklpTlBIdjlSR082cy8wTytDaWx1?=
 =?utf-8?B?ZkVqaXlqeHZWOVZtL0IxdHJhcUcwMFUrQkFMdTVad0JJblcydnFyaTEyMDVZ?=
 =?utf-8?B?MHVlcG9GOXU5L0YwVnBMY3RhRXN3UUNFZ0NVTDRvenVYTFpQa0MzWXVFREhI?=
 =?utf-8?B?QXRKOWhmSVlDRkdUUGJmQ05CbUM4Q09FVjU1VW9xWnE1REYrWkZjazM5cVY5?=
 =?utf-8?B?aGl4NFlmOTJlalJpZlZCQU01R24vWHB2L2RuNHIxN3lmNGlBVHJGOEpJbEN4?=
 =?utf-8?B?MXJldTY4NVRuRUljRC9TM0tuNjF1T0JVamViVUZMeXJwbVZNaUMrT1BUdk1m?=
 =?utf-8?B?blc2STJXazFXQzFBYlk0b0xRbUdPaUJRSEhIR0JBbmtza0VqT2g0T04zczA4?=
 =?utf-8?B?RWgrNDN4MVJZMDhvSFhSMHdUNHVWMVNtK0FpRnFUb2VxU2orS2tnanNHeGsv?=
 =?utf-8?B?VmNZNjlkNnBRbFU5bWNqMk9hc2drNFM1dUh5c1U1aTdPYzJJTkVkKy83YUhp?=
 =?utf-8?B?UzJwaWF5SWlxVUdjNEo0bkxDRmQyVUt2eFZ0eitiVkkrUTl6OGdTb1BTamdq?=
 =?utf-8?B?MUJnYjJCWTIzeGExcXVlc0hEUndRL1pqVHM4M3NBaWRoRlR0Z1R4ampoY3ZG?=
 =?utf-8?B?bFJQcEVLRS81YWVZRVJ6alJabTJmbCtCSUxvT0kvTVVCMlY2VkVyd05CeG1J?=
 =?utf-8?B?aC91OWNqMm94TTBjQXEzMFBoNGtPWU90d1d2cmRJNzRVQlhoMS81MTNBZVNx?=
 =?utf-8?B?SlJIYm1CYTlscWFjTG0reUtCS3pBSnhiOUlVbmNyUnB2ZFN5Y0hvamRkZUND?=
 =?utf-8?B?NGJUSE9wWUYzZHhCMlVodW95azgwOGZmNWNIK2RvWDVPbDAyOG9uSWEyRzZM?=
 =?utf-8?B?bit0dzhWa2VDNWlsQ1FKUGQvZzFWQXhUQkVjOWdRNUNaTCtPRnEzY1RveVcv?=
 =?utf-8?B?N2RlS0RkNkNBYXB4RGgvMlA2dGFva2ZGcnpEcU1vT2owQlN1RzhXdTI4eFls?=
 =?utf-8?B?OW0ranJCSm5qdkJ0ZHVja3ZKRG56akZ4SHBxUXM1b1FMczlEYWxVdElrNHJ3?=
 =?utf-8?B?QVRBZlFrWHRpV0NCUnBOOVVSeHNOV3FvMVNrVTdpdnNpU2FyQ2tvenNIU1VG?=
 =?utf-8?B?QTAyUnZYYkR2ZVpIZXExT0d2NXQwMzJNY3NLTWtyZ0l1S3VLcDhNVWVOZDUz?=
 =?utf-8?B?Zk95c3R3bWFuaVVZc28vdTFxZ1FnTEp3VFJTNk0zRGc5UGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDE5cy96RzBza0F1bnoyb2x2bXJOSk5DeWtmZjZnS0N2eXF1Vi9ZbUlqeFAr?=
 =?utf-8?B?aEtHaldFR0ZEeGx1N1pNUWxnL2VSeTRhUlZwOERmVHZobXdkSzlJTythTmxa?=
 =?utf-8?B?OGRNMXBsRHVOQm1XREJqRG0xM0YwUnM3cTkyTzlXd2tNVWszRW9CSEJENVNt?=
 =?utf-8?B?Ti9CK3ltdnNLM1JWMzdneThBcW9ycGVzelpCMVhrTTlJZXlsSWxmMS9jVjFJ?=
 =?utf-8?B?K3NybFUxVXNVVnJVVS9IOHRHZkpSSnppaW1SOWJTSUZ6c0ZVSHVucEhHT0Zn?=
 =?utf-8?B?TjdEYThrSk93akx5Z2ZsT0V0d09wSHl5a3Bwb0NJK2pSVkh6WFMyTzlnMkpP?=
 =?utf-8?B?L3h0K1ZBK0J6dFI4bzBjaFZNbkJsMGZKRDRJcG0zU1FHRkJzR250V3ovM0pJ?=
 =?utf-8?B?RFZvWkU4RUZia2pieXllSE9hSTdmSGtkL3dUUzlhOWsvZVYzcGRFZ2VOZ3RM?=
 =?utf-8?B?V1p0SnhFLzdLT1dlZW1UQTlNQ09zcmxjUldmYm1ScFJvSTl5VW94UFFmZlRt?=
 =?utf-8?B?eHduWUcwYXNFazlFWGZqVlVNaWZOdGM5TGdDaEgrcXdVL2VFNmV2UXJuWWE4?=
 =?utf-8?B?d3VNWUk3N0o3T2NmV04ybTJZRXdmTDNKcitYY0hIcmpKQVB0ajVDYnQrelg0?=
 =?utf-8?B?NGFvWjd5SzlnaFlrNEU0eWFqZFZDbzVaaU5TRHphTk01dUNKUzBkR0I5V0hl?=
 =?utf-8?B?dWhRdFZwNXNKbHd1bVJKRTUvdEd6dGVxc3JHTlN4UVhRdXp4MUNXOXFTWVVS?=
 =?utf-8?B?TVhMbUVUYWhNb2F0OWFYR3ZiamlXYlB5a3NqZWJ0SU94angyWWFlWk55Tldm?=
 =?utf-8?B?YnpOQmg0SGh5Q3BabDlvR0RjZDhFRzVjdVd0YWw3NHBkcVg4YSt3YndBc09s?=
 =?utf-8?B?K3lnQ2x3MzhDYzFqYUpWcHJZdVgxT0JMOXN2cE5YMGVKQjFCYncrdk1HU3Er?=
 =?utf-8?B?emlFaEttUmdxSk1ZemoyYisrMm1welNtK1JqdVI4TFZHeHV4Y0tBZ0orWU9E?=
 =?utf-8?B?TnZZbXN0WHVxbmRaNXZWMTJmcDhOb0wxVXQ5Z3hEZVpFTXZuQUdTYjdGL3Jx?=
 =?utf-8?B?UGxVTkNFMmt0Q2JkM3JHQmpQSzRBWFpSemRtUzZZSFNGdE14dk9Lb0xyU0Rq?=
 =?utf-8?B?dDFsL2t1dHFYeGRPSzJ1Y2JjOGMxd0gwMlp5MWtzdVRQZ29KRU9IbzZsckdl?=
 =?utf-8?B?bTgyWjYyS0V6YjRqUFNjdDZOa2NsMDJwNnQ4WHF2YTVLTUJlWk85WnhHQ2xy?=
 =?utf-8?B?Y2s2aFhtakI4STRDeWxtVHZvOTJsQ1MrN0FQYVV5Y3JxNTV5S21pMUJHVzRp?=
 =?utf-8?B?bFJuNUYxMFl3b0FwaElJNUoyRHZUaFZjUDJ0TTdPRStWSVk2dmFwU1o1ZGd5?=
 =?utf-8?B?dHhCVGtDVk4xU0QvVVo5OXozY0V3WDZnMExnSk16VUVBWTJLY05KQ3o5bmRH?=
 =?utf-8?B?ZG5nZXUwYi9FdUpRVFNVWUtCcFlzd3h2eHlmWDBYNEcyUmVtcEt4TFN2dnhY?=
 =?utf-8?B?b1MwTEVFRjJzRVJpWW0zNi9zdlFOYm4xZGx5QWpkellqNmdYYWcyT0JFY0N4?=
 =?utf-8?B?UlVJL0paWTNnbEcwOXdLZG9MUllpaVFycThDdzhIY3V5UXFrcVBrRUFFYm5G?=
 =?utf-8?B?b2Rna2lmSVIycWRiWkRadFpvN0RnSDc1Z004L3BYc2dEZWwvK3J1VVJiV3E1?=
 =?utf-8?B?UmlzU1pWZ3NtalFJRU9peTBSZlQzcUxvYzBNYWlZLytrL2RPYnNlUkJBOWtl?=
 =?utf-8?B?cEFtN25YRWJtYS9VejhOeHRXR3FPaUVpSHh2KzdpOUVhaFBmOVBob0lnRTZR?=
 =?utf-8?B?RkxROGFNejdJd0JLUGovcTRBSlVNbGgvOEp2TEVsRUVLZVMxNm9kTTk3Mm9y?=
 =?utf-8?B?RTlFVS8ybHBlS1lDQTJmUEZxYkhzOGxPQjN4Wk5RcUwrT2VISXJiQm5lZGtM?=
 =?utf-8?B?UGZkL2t6cmh1Wkp4REkzalZVWmFtaStUckFzYkdDazZRK0E4cEpLWFZuaXFK?=
 =?utf-8?B?OGU4a3RLNWsrSGFDNWc5QkdPQ3VZRkUweGFia2xHL2xtTE5KOHZWb3pWUnFx?=
 =?utf-8?B?VkhPS1hwYzBSTEJKbUo2bGd4VytINFlTWUtqZ0hHbUg2SHp5Vkx4MmUvaW04?=
 =?utf-8?Q?oCHXi0u8OgV5VASsePRYxSDI0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699af587-2c83-4954-682c-08dd94638a34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 10:22:20.1743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6n+hyfHazO90vD9JJOem6nAwWiVTZaiRGHOpWmcsJMCP5JHux39LEHfam6SFYFlZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
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



On 5/12/2025 12:11 PM, Samuel Zhang wrote:
> IH is not working after switching a new gpu index for the first time.
> 
> The msix table in virtual machine is faked. The real msix table will be
> programmed by QEMU when guest enable/disable msix interrupt. But QEMU
> accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked
> by nBIF protection if the VF isn't in exclusive access at that time.
> 
> call amdgpu_restore_msix on resume to restore msix table.
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 4 ++++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 0e890f2785b1..f080354efec8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
>  	return true;
>  }
>  
> -static void amdgpu_restore_msix(struct amdgpu_device *adev)
> +void amdgpu_restore_msix(struct amdgpu_device *adev)
>  {
>  	u16 ctrl;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index aef5c216b191..f52bd7e6d988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev);
>  int amdgpu_irq_add_domain(struct amdgpu_device *adev);
>  void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
>  unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id);
> +void amdgpu_restore_msix(struct amdgpu_device *adev);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index faa0dd75dd6d..53c253102449 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -648,6 +648,10 @@ static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)
>  
>  static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
>  {
> +	struct amdgpu_device *adev = ip_block->adev;
> +
> +	if (amdgpu_sriov_vf(adev))
> +		amdgpu_restore_msix(adev);

You may consider consolidating these under amdgpu_device_resume() ->
amdgpu_virt_resume_after_migration()

amdgpu_virt_resume_after_migration()
{
	virt_update_xgmi_info
	virt_vram_offset_update
	restore_msix
}

Thanks,
Lijo

>  	return vega20_ih_hw_init(ip_block);
>  }
>  


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AE4C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 09:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A3B10E5D4;
	Tue, 25 Feb 2025 09:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y7GOXokm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E6B610E5D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 09:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hm/0Z6V9oPjretB6/HQaxn95it92YBdOY4X2E4mWuZgt9QcdYy6e+rDSgA7l3lWhCyZ0xBFypYFw0WnI7NIjp7w1FENLy/5bFylwzz93kx7SEVO/dLD/pKZJlE3/xKFvVH9B5PI4Y/YOFdRoRTLWZWMgV43jyoLHVvieJ8jwBfCJXlZP17sbX9A1QhKospmSTbz8+5SvZb33415ElWrgXfPwRn4CX8XBvyZ/l92/AcMh2pImwOQHhx3+8fyKJ3ZWPW8M1Nx3zojiPOXdqPKArhnQDR+yOb2llDV7JLGJD/yhj9RoKXU4fRIulO8yYO+CaoECoKhVxJsCQr7ZN5KBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G99qdMVIFW2K9F3SXhjrn8aw0gF6CCDW8vulEaCwyZ4=;
 b=onMLZ+vsYR82dJRnt/PBRBKAK5IDs9uCWIk7zCArIMUV6aoG1a6f9Bmx5T+BEY/yPf79QbdZEjE9dn0MiXKQyMUhT+wPqojXto3nzQzh62MGNuxZaOaBdyxzklvnC5UhLAC1EroLmp2YcJ6arp/5DGf78Dr5BAcQzoulVxnTXOMREOiiRHaQ1GRW5eA0faavaWrYshNNYR8cG6DkQmAebCzxIRW/CIJ1abhRcQ3NVwCdR+n+Bzp0X7m1E+MVcdV5JyUmls4eSUO4rnUShhhoPrC9IgJoFNp/vt/O0FEsT4YSkryg/iGLLPDflsKrWIqITZnVo8RAntzwaVDRinAalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G99qdMVIFW2K9F3SXhjrn8aw0gF6CCDW8vulEaCwyZ4=;
 b=Y7GOXokmN96U5IAZh0EXR8Si291YhAklDgCPCQjXhvNAbX2PWFdSA1x1f7YBceewP7djd/gF3mX2MomlZaDma9wwTWzPd8x/pW4i/X56XhjB8iBIC/YYFq9jdQiT+ZQnJzmDZGWxCD2srN39AlUu2msxKwVBYwTzx060p+FVy+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 09:14:50 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 09:14:49 +0000
Message-ID: <7e6a3d2f-c03a-44b7-a444-52f437bb5603@amd.com>
Date: Tue, 25 Feb 2025 14:44:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush
 implementation for SDMA
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250225084315.40087-1-jesse.zhang@amd.com>
 <20250225084315.40087-3-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250225084315.40087-3-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 79714931-66b5-4c38-1e34-08dd557cdabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2NGNndyUHBOVEloRTJCOEhWYm5xTERSQmhSeUdRYWphUHZCYi9JYXNqNFA4?=
 =?utf-8?B?ZzJENmMxNzZNb2VxMmE1a2ZnL3NCVGUxTGVMcU5SVTB2QlV3R0lnSVZEM2FJ?=
 =?utf-8?B?MDA1L3RPVXZqSUkycEFlTThiWGtJMnB3SFByNllFaEI0MjZSQWJvaUMrZ3NN?=
 =?utf-8?B?bXRibm4vNGRKeDNlcENkYmNjZlg0ZVJkR3dUREN5anptYTNiWFltVjd1eDgz?=
 =?utf-8?B?WElqSHhNbG41c1BRaEZIaEhlYWEvYkZ0SkFpTW1vQ3NRa3hiM3c5Q29HZ2o4?=
 =?utf-8?B?QWFmMU9vTDVDVmRkSTBGRTBIWTZnOFluU1NicnFNMDlUNGhTeHR1ZzE3Q01N?=
 =?utf-8?B?VzE1VjM0NTh0cHlEazhnY1FFWGNPUmp1RThCRXZoM2lseGtHZTNKSXphbTMr?=
 =?utf-8?B?SGM3aitjYTJDWHBlaVBMaTVPeVQrLzEzV1dqdm1rdml0Vm45NzZkM1EvSWQr?=
 =?utf-8?B?R3kyVzZYV3Rwa0gyWERiVG1nQk5iSUlFTW1GblRrUjRLQ1BndExPQytncVQ2?=
 =?utf-8?B?ckpHcVRqa1d1VWVaYzNHVmpyQXV6ckp6YU5zVXRmeEs2TTFWUnlDWW5UVzRu?=
 =?utf-8?B?b2VQeXlYTk9nckpoNllyTlpvZ3RsR1FFSmQxcHhxV214RjlIS2dCNWJhQWc3?=
 =?utf-8?B?Tlpzb1RVQjZReFJWY1VNeHNFM2tSaTgwcE0vZkNFWmxOdGpPODZDaFQwcWU1?=
 =?utf-8?B?NGdSMitPcGVEdWtXakNkYWdwdXVtaFdXRlBlbW5mNFRRYnJrSHVFNFhIZXhu?=
 =?utf-8?B?OHVMSElCbjAvSGN3WmlCb3hUU0c5YjMvTUFBdjIwQzVYamxCUzg0ZWd0T3Y2?=
 =?utf-8?B?NkVLeVNhTjlEUGtIbS8yM3JxTEpXTUo2Vjh6M3Q2UFRqR0NOdC9Ec09pZVRM?=
 =?utf-8?B?bzRuYmZVNlMyK1pVQlU1ZUt4VVlEOTRvQUdUd2tZRm5WNHl6RXlUaXpxKzVs?=
 =?utf-8?B?S2tQV2lick9GQUFLbDVCOUVway9NTjVURWIyVGVmekRVNVRNQ3c4N04yL1Vu?=
 =?utf-8?B?R2JJaXVWYTJtM2VSZ1VkRk5tV0RpZlg1NytpaFRBV1NMVGZYaFhyNTFTdklK?=
 =?utf-8?B?TWI0WGdzdGdmUmUzV1U2M1pGZGxrU3JWNStFbWVsaGVEV1FHa2tuZjAxMENh?=
 =?utf-8?B?UE5SOU1IdGhrUHVKSTdxbzJpL0JuR3NTZ1Znbi9qbzlnZ2NiU2ZyeUx4QU12?=
 =?utf-8?B?bmZ1SHFXZVVqcCtGYjEwQ09CVjVQT1owS0xTTStab0VEMk03bk53TElnN1Ni?=
 =?utf-8?B?QkJpNVRITEFLRHdzM1lBV1dOVmZwK3lQUFVNLzhZUVMzOFlHZ2lhWjdJbE9a?=
 =?utf-8?B?TGluYlRxajBpRUdqR0lxbXljWGwxVEFra3ZkUDd3S3NNdHFZaVBYYnd5Qkdn?=
 =?utf-8?B?dTZkQThJUEg1bzVObWlYTTROZ2pnUWoxMkFydGNKQkszQ0NsRTAzWjdRTlFz?=
 =?utf-8?B?N1gwcUkrNVREdXc3cnRSVjdFRkRVVVlObW52cDlZeXJHaWVRc3lxSUh5SkpK?=
 =?utf-8?B?MGc1cjFOL3E5cmhUVHNyR1FqNTNyOHh5RzI0a21MekZITkxSd3VvdUZYaFhp?=
 =?utf-8?B?L21XKzNiZWFmZ2F6eTFSSVlGcVh2RGJoMnBsT2ZIR1BEeGdnU3hMMGZPQ0hP?=
 =?utf-8?B?eklSbzVPT1ZnQWdGN1V1S3U3QjdmdEpBL0Z6SldwL2UwN1BHMEtqa0FWV0JS?=
 =?utf-8?B?ZnlmYWpOQnFNTnNJRzlkZDcrLzRuTmpBVkR3TFBkcVBsZmVTTG1HZEdUYlJi?=
 =?utf-8?B?aktldFJ1M2xScGdlQVRrbHg4Tnkyay8xaW1UTm5IMlJETHVrcExPNVBkNWh5?=
 =?utf-8?B?dFk2eWpIa0tSejMzQVNncmNDZ3gyelRQTGFKKzJmMEhkMU5EM0ZLTFRxNldH?=
 =?utf-8?Q?09vlOcoOdNiOz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZhNUwrMFo2cmNCWG9ESzdxWlNqUXJzQzhMSXdBSFFOQ3ZpcWw5cDZLV0dM?=
 =?utf-8?B?L2d5MWtVSll1RHdPRWxIV2g3dXdCdjJDa3B4NldrOEMzd0kzVE0yQzdVbFlv?=
 =?utf-8?B?eTlqcGc4anUwSlVzVE84NFVYdlFXcVQ3bTltK05rbzFaaE4wRE5QTmZsUTRL?=
 =?utf-8?B?TklQZEZveG9qUVA5ZjlIdVhkN0cvV2xleE92WjAxZTI0VnI2VlFtNkVtWGt0?=
 =?utf-8?B?TFlnSVlidWFaeU1TNEhCcVJQeGVlaWRWaWpWOXFUU0YwL3dQbmtMMCtLKzhI?=
 =?utf-8?B?Qnd1TlZRbC9vQVVuQWtMSVU2V3UrL2srRzdOMnBvbmw2MmZkRWhvbjBOejB2?=
 =?utf-8?B?OFBKZVlVbVVGcTlQR0YvcG5OMllld2s0aGZ5OFpZTzNHWWFQdWxKbXBDWVhr?=
 =?utf-8?B?LzNBS1RpMEU3RzZKeWhEMk1PbHZmL2hYK0hERjVaaDVEZXRUTUREaU5OTTVy?=
 =?utf-8?B?KzNJRXNRSEVpcHBZS29SbGRSbjM5aDlTa28xVkZKbUJKSjFMTW5wTGFRWkhQ?=
 =?utf-8?B?dk9JdUZocWxGWHc2UTl5WWQ5a1Q0RUJGNUhPUzRtVnBmenBRYkoxcHl6c1lY?=
 =?utf-8?B?R0t1WEQ4a0dQUWhZaGZaY1NxVC9zbGRxMkhBdHpvTmN0VmYzeGM1RTdHam1R?=
 =?utf-8?B?R0NtTStVUlBxQk9CUllyYUdtZ1lTdXJDSXprbGI5c2kxTXp5ck4wRzlRcUZk?=
 =?utf-8?B?SUV4UTkrYXR5QUYxeFpZMjRrbjRkMmpzbGc2S3dJM2ozMzNxV3ZXNkhVVDJC?=
 =?utf-8?B?VGlFNmdhemdyc3RrZ29LVkd3OWM0RXV3ZVNlSjl4Z0c3QWgybllzUDh5VUFk?=
 =?utf-8?B?RkxmUURIUXA2c0lWaFFhcnpPN25OWEdRMHBHUUV2WFBUN2UzV01PSVZkZUlC?=
 =?utf-8?B?ellGbDZiTkdzNGM0OHhtdUZqTFpFRnBHS2JFazBiamlmaVo5RkFuOHlSZXB2?=
 =?utf-8?B?emxFby9xd2huZkpEdTFGSWhNbEVuR3ZaVHppSlIvWXFtTnBsV2paV2tkZFhm?=
 =?utf-8?B?eDJQeFBqNE9KS09QMklDV3kvNVhzRDMvUGdxK0d5K2U3cm5DMm9xQ05oVW9a?=
 =?utf-8?B?UWszS0E2SzZGaHhKdnJobG9NcXNEa1lVeTk1SE9sSFNmYStSWkVlTmdHOElO?=
 =?utf-8?B?VmhmNmtpRlNtRXBGNk9qK2ZYSmFXeER1RFM4bnJ2dkNKL21yS3RhSGRVSG5z?=
 =?utf-8?B?OVNTYzF4ZVdRZllLT2FuaFkrbXF2bTNJZjFxUUVJWGlPMm5mYlhWQk1zN081?=
 =?utf-8?B?VUFYYU5SR0xkRWRPWXFVWVNFL1V5OEpCdHlDUXpiL0N3QzJZMGtJSUYvdmxR?=
 =?utf-8?B?ZElTU1pKN1pVYVo0UnpNcDhtN2wwSlFoUTVoakpCNHdDenljNS9xdjMvSG5I?=
 =?utf-8?B?bERIR24rZE0yZ2NPTGx6SHphamRTZkRUcU1iaWpxU1JWdnNDa25ZTjA1M1Bq?=
 =?utf-8?B?SjAvbzlJZmtBU1RtZ0dMck5CZnZJK0VNWjlLcDN2R1d0TzFvR1BoUEtUcHNq?=
 =?utf-8?B?ZC8zQzhYNVJjUXBhV2tlbWlQZXMwYXBlbzFlNGxPeTJOWGEwbXVoRm5UMWVJ?=
 =?utf-8?B?Mk1GTGY2bG9xdGJzUmxEcXUzN1Y4VEs5QStRelFzU214TG1GbGY2RnFLSVl6?=
 =?utf-8?B?UWNvRkNIZDdEK3EyZGpNMzRteDlBWEFYRlVMaHE3ZEJ6Sk9rMUl3NjVlTkJs?=
 =?utf-8?B?cU1Db3FMMDJ5U0VJS01lK3JRMHNZNmxCTVdmbURiMlRCdFN1LzQyNllIeWNF?=
 =?utf-8?B?eWhSN3JtMmdtMHB3Vmp4azU2WXdHWHVpRS9MNTQzVmVCRVNDbXlBY0hlQjg1?=
 =?utf-8?B?N2hUeFh2U2w2RHRZQWFJcnFaZHM5UllBUURIMkhzY3JoOVk2UVR1aGpIeFRh?=
 =?utf-8?B?SFdmWHBSTjM0enVacUtneWh3c0xLSHNBbmlVZTFPWE5Zd2hLTWF2UER1V0pp?=
 =?utf-8?B?RjdUSzc5NW9JbHdvMHhRZU5NRFRoT215OVJPUU4vdUQwTncvOGFiV2Q4bUVI?=
 =?utf-8?B?QkNUazd1MlJUc29qTVBtSnA4NVIwb0V1VWVjQnZ2eXBFT2lXeE9KSHo4OUJ2?=
 =?utf-8?B?c2ZiR2lzdjVmcENTL0YrMmtOdGQ3azN1MGlEdVlZaGVpYUlXR3A2bEhOb25G?=
 =?utf-8?Q?8cXq/9N0cw5DeZ/fTed93/DkE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79714931-66b5-4c38-1e34-08dd557cdabd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:14:49.4503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LkRnYvKJqbzrHEdu3IyMN2a6FmlR/TN26euwcz1u63hAqUvmb9OSbAm0fEUo/He
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
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



On 2/25/2025 2:13 PM, Jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> This commit updates the VM flush implementation for the SDMA engine.
> 
> - Added a new function `sdma_v4_4_2_get_invalidate_req` to construct the VM_INVALIDATE_ENG0_REQ
>   register value for the specified VMID and flush type. This function ensures that all relevant
>   page table cache levels (L1 PTEs, L2 PTEs, and L2 PDEs) are invalidated.
> 
> - Modified the `sdma_v4_4_2_ring_emit_vm_flush` function to use the new `sdma_v4_4_2_get_invalidate_req`
>   function. The updated function emits the necessary register writes and waits to perform a VM flush
>   for the specified VMID. It updates the PTB address registers and issues a VM invalidation request
>   using the specified VM invalidation engine.
> 
> - Included the necessary header file `gc/gc_9_0_sh_mask.h` to provide access to the required register
>   definitions.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 66 ++++++++++++++++++++----
>  1 file changed, 57 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index ba43c8f46f45..f9cec50ce54e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -31,6 +31,7 @@
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_reset.h"
> +#include "gc/gc_9_0_sh_mask.h"
>  
>  #include "sdma/sdma_4_4_2_offset.h"
>  #include "sdma/sdma_4_4_2_sh_mask.h"
> @@ -1292,21 +1293,68 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>  			       seq, 0xffffffff, 4);
>  }
>  
> -
> -/**
> - * sdma_v4_4_2_ring_emit_vm_flush - vm flush using sDMA
> +/*
> + * sdma_v4_4_2_get_invalidate_req - Construct the VM_INVALIDATE_ENG0_REQ register value
> + * @vmid: The VMID to invalidate
> + * @flush_type: The type of flush (0 = legacy, 1 = lightweight, 2 = heavyweight)
>   *
> - * @ring: amdgpu_ring pointer
> - * @vmid: vmid number to use
> - * @pd_addr: address
> + * This function constructs the VM_INVALIDATE_ENG0_REQ register value for the specified VMID
> + * and flush type. It ensures that all relevant page table cache levels (L1 PTEs, L2 PTEs, and
> + * L2 PDEs) are invalidated.
> + */
> +static uint32_t sdma_v4_4_2_get_invalidate_req(unsigned int vmid,
> +					uint32_t flush_type)
> +{
> +	u32 req = 0;
> +
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
> +			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
> +			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
> +
> +	return req;
> +}
> +
> +/*
> + * sdma_v4_4_2_ring_emit_vm_flush - Emit VM flush commands for SDMA
> + * @ring: The SDMA ring
> + * @vmid: The VMID to flush
> + * @pd_addr: The page directory address
>   *
> - * Update the page table base and flush the VM TLB
> - * using sDMA.
> + * This function emits the necessary register writes and waits to perform a VM flush for the
> + * specified VMID. It updates the PTB address registers and issues a VM invalidation request
> + * using the specified VM invalidation engine.
>   */
>  static void sdma_v4_4_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
>  					 unsigned vmid, uint64_t pd_addr)
>  {
> -	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
> +	uint32_t req = sdma_v4_4_2_get_invalidate_req(vmid, 0);
> +	unsigned int eng = ring->vm_inv_eng;
> +
> +	/* Update the PTB address for the specified VMID */
> +	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
> +			      (hub->ctx_addr_distance * vmid),
> +			      lower_32_bits(pd_addr));
> +
> +	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
> +			      (hub->ctx_addr_distance * vmid),
> +			      upper_32_bits(pd_addr));
> +
> +	/* Issue the VM invalidation request and wait for acknowledgment */
> +	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
> +					    hub->eng_distance * eng,
> +					    hub->vm_inv_eng0_ack +
> +					    hub->eng_distance * eng,
> +					    req, 1 << vmid);

Sorry, this is not how it is. VM_INVALIDATE a totally different packet.
Instead of wreg/reg_wait, it will be using something like
emit_invalidate(). The packet needs to be filled with invalidate engine
details. You may refer the packet spec for more details.

Thanks,
Lijo

> +
>  }
>  
>  static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring,


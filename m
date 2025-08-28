Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0744CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 12:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 683FE10E335;
	Thu, 28 Aug 2025 12:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vDhp5lPx";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00B310E335
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 12:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm1HDWMMrFDxYwdiPS/VuVZqHLCQwMgUL/xNVCOBTAP7ax6KyEuvSnSCTIQY/rXEC9HK5g2X2YX21s3ZD3fCaQcnuZkS0uh/lnszksKOgKG66+dCkLb5vdwOEZx7EHFjcE75nzcVLngt8bqvPEaIpzGoOV6B8SpfXZoQ3bf0C10ngflUhWmGDuMwgqflikwYmZ04jt9prL5juNaa1vy6tppZeK24aC7Ss1jHbCDUU4CPWE+ME6johx8Y67n7NGk3RJmOAoQSRxZMnl+txgV1CKMtZ6Up6/SobslU+8o0XBxCFZeqrt1j0bSMjsBBd7QMJNAeMKFmelU3PquV0ZVNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toDD2et9oUowfXDbw4mjk8dJLumhbdcT8ZuLwXROlhc=;
 b=DdXprlBIWwmEUq1j5E7aYY+LO3a4w7gsp33ZF1mxYEvfQ9NQ48wwf+zrxRztFbWgAk4VCYKrP5KfNHsxQ29CAUsZ7LImUOA8gCegA4V4WNSGySxNx4Nx5d99WomKXl43Lz0xryCPDOu+4p4XtVjOQLOZmyG0dyyQ5L4/hiIPpvxpJw+igFZoYJaxpgFr3OIPKsy6uAwTxzIhwNfSqTPOuFWKqABURBRsjl3uoky7krYJE5LiM3h/WcnA6mqdfM9FOh4IbYPG7WtOyv4i+/rh7Gbqgijbpliu4eoAZbvwWKP3m9xQ5ZSXQoyv9GhJPBy1o/6BksohO2NLoBjaAxyZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toDD2et9oUowfXDbw4mjk8dJLumhbdcT8ZuLwXROlhc=;
 b=vDhp5lPx6E/4N2pAW0UF60JzAk4TSXv2o3+AD0AV0FlVm2FVaZ3U8vAHO9UEqwF1BOiIoWL2EgkfmUIdcFHLTRyVWr+ukrE4u6Mmz/5EYGnaUjGCgxfPvDoP/jgAzSJRiEuFE8HxOEMvMYwywC9y/wRlVXCZsh4+/6emsCROaDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 12:29:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 12:29:10 +0000
Message-ID: <a1618791-d083-412a-8164-d07e300571c5@amd.com>
Date: Thu, 28 Aug 2025 14:29:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for
 AMDGPU_PL_MMIO_REMAP)
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
 <20250828071335.3948819-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250828071335.3948819-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: ef750eb6-d580-4923-46e0-08dde62e7d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y256VlNuVEVOVGFjeDF4QTgxQ2tOVjRlV1JxYWZXMlA4UTQ3SEVBUkppR1F3?=
 =?utf-8?B?V1ltdWNENCs2c2NxcnRrTXlLTE5kcmU5ZnZIOHE3V2d0QWNRL0MralkrajRq?=
 =?utf-8?B?Snl0ZlBRVFNRdlErR1Z2Y0R1aDFCV3RjUlJkNTZTdXVsNnhBZGNIcTRVWTA1?=
 =?utf-8?B?bGpGbFUyN3doTy9yWmR1QWVnOS9RZGk1cUF5dUdJUkZoSGg4UzJ5S1VMWkVD?=
 =?utf-8?B?MUFDQzduL0FybDZ5cjhQVEJYajJENzVyaW5KU3Y1TmxUM0FNKzFkd2hVMEQ0?=
 =?utf-8?B?SjFEVmIwZUdBdXRsNW1RYVpCengvNnBWVXBRV240UFBGTTRveDdYMFFoeTlu?=
 =?utf-8?B?Tm41dmpoclJ5Vk5kZ2NSZVlQTkc0Ti9ldUkvYlN1QkEybG1pTlA0WHJIQkFB?=
 =?utf-8?B?MDVsWWV2UGlaTXJCTUt6NXpqaFlSbDlJOHFDeW5taHlKOFN2ckxQWXhGcU1F?=
 =?utf-8?B?QjFuekhucWFJVEhtUytNengvV0hLQlBlcnhxdDZPbzBTeDd3UE1tbDVUK21Q?=
 =?utf-8?B?MW9jRzJCak54OUduZSt3eFBPeWs2c3Avbm1nSXZqdDEyNStTNDh0M3RhSG5E?=
 =?utf-8?B?c2xoK3RNbFlvaWVLNTI2ZVcvOVViM3Voc0tSR1h3Y2NIVVo5b0V5aFdTTVZp?=
 =?utf-8?B?aytZNjMrUDE3NmRwVVo0NDhZMXhOOTFvbkYxaTZtOERmdGZlekJpNXRRVE0x?=
 =?utf-8?B?M01jVCtMN0VuL3pEN2FscWVNVUdrSTlTblFaQzBBY1hCRTRtL0IvSjNoYjBH?=
 =?utf-8?B?ZEF1eFg2LzlSYmVBSjRvNFVpSnR5L0FLcTdybEJBd2hMZWVOQjI4WlVqWERs?=
 =?utf-8?B?MnRqU0svc0k3ejcvQjZTQnRldzBtZ0NraHRzazVDeDdiWnlCWitnUy9SYnVz?=
 =?utf-8?B?VVlLNGpEbTZGN3M3OUdrYnlzZ09Da3YxalpWMmRKdjdvZWllRm5jaDhtdDJD?=
 =?utf-8?B?dExMQXU4OHlmNnBMNFluMDkycTNRVjN6ankvdmt2b1pkWGhqTkhJQzl3QURq?=
 =?utf-8?B?Z2NOK3dGLzgrVXFSc21iYkVCcnlFWjhrZUxjNEpWYVZUejE0OFRrMGNFbkxE?=
 =?utf-8?B?YmpvNXVLc082TW0xTFZ4b0w1WVNhN1RIZ3pua2srUitERzc0anhWaENkOEt5?=
 =?utf-8?B?RjFzY1l1SmZIUU5uSWJKY1k0VGk2UFp2WjQ1RFFYZHJnbGhQTE1rZldxejR3?=
 =?utf-8?B?RWgxNHFjR1JTazRHemFiYUNJa2hLd2U3VTVseEFqbHdIRTUwNEtrZnI4Y3lI?=
 =?utf-8?B?dHRYeEtqMXVxeWJBd0Y3VjVhK29oNkNRNkxZY0Ywb0tSSWhhNVpwQ3dHdllU?=
 =?utf-8?B?bWFza3Q2YlNpVmhJcU0vTEtMZThLK29SU0Z3aUNNMHdQenJMR0ZsSk4wZFg0?=
 =?utf-8?B?dlZmV0E1akNjNHA0LzVxZHR5WGZEK0xxVFMyOUVrQ2RlMmZyMVlYWmJnUFZN?=
 =?utf-8?B?VktSV2U2N0VYT0JVSXZOLzhicHZuYTZWa2xDTzZtRkU4UXU4UG8yK0xaMW40?=
 =?utf-8?B?ZmZPK01WbmdKLzJRRlQ3NGErUEtMVVhScGl0UGdtREpLdlBGUXRLY0ZWcDVm?=
 =?utf-8?B?VVlSbmFFaVJac0dMbEg2bWtNRmxHaHM5dkxCWFFQMzJyS2JTYlk4Q2hzRnRU?=
 =?utf-8?B?MU9UUUlaN2VZU3gxOVNNMi9DeHNpOG42dDBBUURFZHN1c2lValZnem11eGhs?=
 =?utf-8?B?VGtqSDZpaWpXU0NpTmZxWFdCdDdxNlNJbGJmeVA4OXNyWXk2UkIxd3l1cFVH?=
 =?utf-8?B?Ty9zU0lkWktidm9iREhESURqMjFVTC9pcjQzUWlOczQvanBJYlpTOGFoZjZF?=
 =?utf-8?B?WDN3Q0ZBeVByTWtsckIzMkdSVEljbTEzT1VSN3hnMldvZ2JnMXhOS29DelVG?=
 =?utf-8?B?c1FaSnZSSlQ4elpvSCtxYzVtSmFOckZMRlRSdDJ2alF3ejNYaEVaY3JZZ0Uv?=
 =?utf-8?Q?ZcooyID+7zU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEJtaGdvTWgyYWswcnN4amxjU3lOVG1OQi9PTCtDN2gwUGxoUTd1KzMzSGE3?=
 =?utf-8?B?aXVyWitQL1Z0UTdkQnVEazZGbStvUUFKaDNobVBzSTFLT2FIUVFON0hkTHFF?=
 =?utf-8?B?d24ycm1CMHBqZ3RpY3RueVJEV09MampqeGw0T3NNYnlFSUMrbCtoOGtMNXF2?=
 =?utf-8?B?R0JwdmI1eUdhRmxZbXBwVzQ3aHdpMHpPZUJIVVRCeUVCbUtKRWtWbkxZUitJ?=
 =?utf-8?B?dyt6V244ejNoUloyaFFrUXQ0QU4vamJuY09lZ2t5ek5HMFhpVTRUaGdDTlhW?=
 =?utf-8?B?amxPQ2tFMGw0bjRqRjZqeFlKQXVjc1B5cTl2eWdrWkw4S2ZIVzBzeHp2a2F4?=
 =?utf-8?B?dVZ2c0ViRFUxNC9ucGY3WXFuKzljQzNGa2lwZE81WExKL0drYUs1MThZbm14?=
 =?utf-8?B?YXNOTGwwU0Y0cGxpcmpUazVjV2xEYVJmNCtQdHJBQ3NuMTlWbmozRCtLMytQ?=
 =?utf-8?B?alM0Nk5Qb0Z6RTRsbVo1OEVOUEU1NU1zS01ZSElTVE5xL2hlOXFscWszYTVl?=
 =?utf-8?B?K0RseEtRckV4MGc4N0JXRWtsaUNiZ3BvdUNYaHBaRmhUSndPNlRjN1JDYzN5?=
 =?utf-8?B?cDJBV1dLNk1JaDgyNW1pZ3gwYkE1T3krZ2s2cVU2NFU0UmVVL3pvZmZjamJE?=
 =?utf-8?B?bUxuUjhuL0xhZWI5RzRPN1VSSmt0S3RjT2RSaTVYejcvcXRVdXlxb2oyNi9p?=
 =?utf-8?B?N295SVo3UnNFQnM0eFJjRzZEMGZkWnZ5d0NWcHYzNWdiRWdmNTV5MCs0eVMy?=
 =?utf-8?B?bHRqSkx3eTMyZ1RSQVZoREp6VkRESXdZQVM5OVlJVUFuVzd3TTk0MlVZTG04?=
 =?utf-8?B?eldMdVhKTG9leWZTenB3QlcyMjBVM0NLQjVWMTNYajNLaURRektaV3AzTkJP?=
 =?utf-8?B?ZlNvVEJlaUtBRWVDWjIybEdyV1hSWWw1SGYxakJxYU5ianU3TTJFZy8rTENq?=
 =?utf-8?B?K2YxUk9DeUpvRGM3OXZVU0hQR2w3SG5kckJDMVUvQWdYaTNLRTFEMDcwWjNv?=
 =?utf-8?B?OHRZMkVPK2xadGZySUp0TjVCM2tmQkVqMHBTUnhvSS85ZEU0MVJiUVdMWUVr?=
 =?utf-8?B?dkJibjE1WndOOEZnUU05eGlHV1hEaE55QXIrK21sU3o4YWxRcFlRMzJUVVcw?=
 =?utf-8?B?Ui9ZNlpzZzZwQXN0aHllR2hzYjloWGhZc095c0JoZENweDBTeDRFdEU5aFpC?=
 =?utf-8?B?SUxLbFZIaG1MWTFWZm52b1FJd2xab3ZrSEtjWUFGU2xJOFA3d3dNc2MzZjhN?=
 =?utf-8?B?TkJvVVhrZXZhZWxaMGNjcFhXTlQ3VU91Z0NVRTd6R0szcThUYXpNL212L093?=
 =?utf-8?B?Y2toWnM2M2Q2NHBRQVNNeVdEUkVES29CWHNCa1lOWEFWUm1Pc0dwMTNpNndU?=
 =?utf-8?B?RS9uYzB2YWJBdlNRMHJQZEU5VGJ6QVl1QVVpK3BLeUkxSkhnRkVWeklFRllM?=
 =?utf-8?B?S2c5SWNSaDMyNENoSkMwdkNyNHlSQkhPcTBscTdlcmZYYnBSYWo2dDRia2x1?=
 =?utf-8?B?WVpqN09UZy81NVg1MGJ4SjV5ZGxGN3crSStEMzNqZUxtbWhySEM3MXVmT0Ju?=
 =?utf-8?B?bnBxL0l0djB6VUFKWGpQVXhnSytSa2VJajJFMUpmWmJWWWdHMm9Fd280SjdF?=
 =?utf-8?B?MUZKVjFCQ1A3ajV3b0tMSktFUiszYklST2hOeVc0Q05rTHNVQTB1MVZ0Rmpu?=
 =?utf-8?B?cUsraGJzbXphMkdWK3pTTnVqRDZwK09BamtwUEVjcTNaam55MmFHeWk0L0JO?=
 =?utf-8?B?TVlkUzBhbys5YmhhNWdjc0M3UytmVjBMZ0tyTFJZeG5GVkYvWXluRHFuVllI?=
 =?utf-8?B?dzJTY201VzdJUTU4bE9wSW1Xcm02cFpFTTAxaEFsd2JlSzN6VTlVZThNUDlw?=
 =?utf-8?B?eHh1ZHAzWU8reDNZczBETU0yOWk1R3NzcHZBZ09scjh5ZmZqVXR6U3AzOHFJ?=
 =?utf-8?B?REl2S2tCREV1Ylc5Nm9TYWpPTGhDaUh4ZGJpR2IzcEFhbkNiYnBHUTNyMTVn?=
 =?utf-8?B?eDBkRUpsczlFM2VBazVsRXJNbm5YQzRENHJlV0IzWnh3dDl0UUs5b0xDQmhv?=
 =?utf-8?B?N29NWGxSa3dhQnFCUTBRTXlKRDdqODkvaTJRSTRJZkNBRmZFQUpzRi9nTnZI?=
 =?utf-8?Q?BourgMqs5l53MN5CvezTNNHMd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef750eb6-d580-4923-46e0-08dde62e7d0e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:29:10.6893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpFXi7vF+CeVIJKa0jSX4tfiv1So4PC4DSyc88UX710mt7veok+TKTgRmO2297sa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156
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

On 28.08.25 09:13, Srinivasan Shanmugam wrote:
> Increase TTM_NUM_MEM_TYPES from 8 to 9 to accommodate the upcoming
> AMDGPU_PL_MMIO_REMAP placement.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Please make that the first patch in the series.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  include/drm/ttm/ttm_resource.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index e52bba15012f..f49daa504c36 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -36,7 +36,7 @@
>  #include <drm/ttm/ttm_kmap_iter.h>
>  
>  #define TTM_MAX_BO_PRIORITY	4U
> -#define TTM_NUM_MEM_TYPES 8
> +#define TTM_NUM_MEM_TYPES 9
>  
>  struct dmem_cgroup_device;
>  struct ttm_device;


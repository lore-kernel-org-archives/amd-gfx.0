Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0E8C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 13:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C189A10E53C;
	Mon, 10 Feb 2025 13:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W0YyNInW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064DC10E53C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 13:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpqpcRenlOn568fDubQjghETYuymaO3iD0scnSry5tFGxqDkryxrHkgQjpCPQ/SS+ypoB9an1Ik/cuChQy8VjGOxeRkuvAFT+sYTf6wvmNiGYckoeN36+2lO9MtxD5gNvCuzjhnjDGfonxCJOOQRCUdmGHJNgpl59yhmVs8GOw+ECh05way1AcuCUPYTX5cFyocAPO4fftGlLFQtd7oqjEcgTxI6sB+h6k2O9Sl4x3i0PmWvHOEfn3L4Cmky0CTKKftBJmnIwuvPTDX9ETFjr0lUgmR1rMqrg/nh6DtW0Ct3VsKGrW03kHdn8r+yXzkfMC7cGWcYpwhvn1bQERMHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beX64SuEGXZ5/SeDfivgPdUWQSUAk+c9iwhU7CB9aLk=;
 b=xMreMIY+96PKqHRtIy4wnrlgu+U2qrIGKVYziGxAR8p58LHQL7xzi/IRLdVLgZy0tQj75MsfYsZOBY2Ow5ZQDVgrlaI2Xc7SgA5LLHqmepWq93oDeKr68mWEWE4tJJ80k8+wnwA06XejpJYPy3rbrd/GQPMZe2I6sjtYQ1xFiwdGmFEkl6glogT77zSUHOoJr6Z1Bm3kmLXLDHbBpMh3C7+mlwv1fdlT/VO7rBNPw2+QD0Vqgv7iSP8VuHzuncnsIOfmxrXp6uHL6eCPhz1Di25rc6VeCvgi2zHlaz/8/Agqe20hXxDll5AqUNBSiIOZfio+j/KNkPauearWOSnB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beX64SuEGXZ5/SeDfivgPdUWQSUAk+c9iwhU7CB9aLk=;
 b=W0YyNInW52hLJyLYdUiQVtWRRWX160pf3AYaor/AAtR61EXJaXj3S/lA+l4/DgTkP5zjGXkxIVweuVtyxSPJcAQ1pvoARalRLWFqYLMw424BjVE81SW7ulZqPda0kAp285Iaw9Tbhl0jNbOIlWfaDOL8StWeB09S/9tMmYBnuhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.16; Mon, 10 Feb 2025 13:33:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 13:33:15 +0000
Message-ID: <75279a9f-525d-4659-b521-463edf48acdf@amd.com>
Date: Mon, 10 Feb 2025 19:03:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/kfd: Add shared SDMA reset functionality
 with callback support
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com,
 Jonathan Kim <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250210073145.2681082-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250210073145.2681082-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0248.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: f7742758-b27b-4f12-a279-08dd49d778ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEpuWUsxK0VaTjVoMEpROW9tRm1kamJPNWMzQXMzaVJ5ZkI2bjg0WlhFazNp?=
 =?utf-8?B?QTlaQTF0V0EzVjFtSTA0TXIrbnAwVmNLUDhwRXlnQVdRUG5NWnFQKy9ablBw?=
 =?utf-8?B?RDZmM2FIN2R4NTZUU0NvMmhBOEx0R2lzQnVvazNyZE5ER3AreFJZZ2I5eFZL?=
 =?utf-8?B?Q0NLcjdTSEdndUl3Um1ITFRoNkZzTDN5a2dVa3VUM01aUzFJbys1b1NBR2Nq?=
 =?utf-8?B?MVNPNUFMME5VV0kwS3ZybzNRbG1YRWZCbWNQZHYram9RNXNqZnNBWnVGVklN?=
 =?utf-8?B?K3ZmSDhMRE9tVGVGVCtyRFlPeTgraFI5KysyOU5nb2ozb0JyNW9tT3dZN3M5?=
 =?utf-8?B?S08vbU5NL0dtRWY0VnI1clpnOHFobnd2STBibE1FdDVJMzdML0czQkhqR0RD?=
 =?utf-8?B?a3VIRFJiTjd3bkp0Tm1xSWZYY1dDQ2tNbUg1em56eDBza29TV29KTFhSZDBW?=
 =?utf-8?B?ekhvTmtxVlRqdllDR1hlTWRPRFFKbkhWNm5IQ3NEaFdmbVhKV3Y0Y29CUE5h?=
 =?utf-8?B?T3dvdlVNKzJjWG1JTVNXZFVEWTNyTUhJczdUSjVPM01ybVRHa010SVZCS2Yx?=
 =?utf-8?B?M3BWVTRFTUpsVGNITFpwQWFpaGo2ek5yOWRWWndBMTd5ajB1RnBOZ0NjaWM2?=
 =?utf-8?B?MFErNHlEcXN5aFVVZnJyZWtkbnRKTk9lN2Nid242VW1pNERxRUl1VnZneERR?=
 =?utf-8?B?UU9RdzhZaEhoVHkvUGw4YTc0TlpuV2Y2OGFaTXF4TGdDMFd1Nit5UU5KWVZF?=
 =?utf-8?B?OCs5RiszeDE4bFdUeGdqVmFnT3dQUkg2KzBCeW1RT2dlL1RGM3NTSmgrVXpV?=
 =?utf-8?B?aHNqRGRUTnpNRGphandCU0pwMmlRQ2djblBhWFpmRld3Q09tQU8zMURUTFF4?=
 =?utf-8?B?ZERIU2VLZ2drMTlZek5iMHhBc2pCUWFQdVhwaHJ1ZUJ4OFc5R1Fma3pSaEpm?=
 =?utf-8?B?dTRmdnIyaEpZMkVZVGpnV1FGeUE0Q3pKNk42ejRpSHU2azVJdFROd05tNUQy?=
 =?utf-8?B?V1lISC9xSVV0Q2haTGU0WUx4ZTZIdUlqTUN2SGNEYXoxaWl0bWlpRHZkYXBp?=
 =?utf-8?B?UXZVZjUvMkxiM2d0NCtaZTkxOHJGY0xXeTlQTjY5YkFRNWVGSERzT0xOSzk5?=
 =?utf-8?B?eGRrVWhLZHc5ZmRLbFRPemRTaWNsZzNxZC9ucW5VbU9XTXgybXlJaUlWTS9E?=
 =?utf-8?B?eGJwekgxbWNMSE05aGlwbjhZaVNDRnFQL3FjRmpjYzh4a0JEaVJCcyt0UEc1?=
 =?utf-8?B?N3ViZWlzTVRoVFF6OFFJUW1oVmRVSWxRZ3IyTUI4Mms2LzhMRGlwN1VtQnlj?=
 =?utf-8?B?YUpUa0lWZjRPR3RzS0x3QUdSdXVxVjFiYjRSUEFWLzhHWG9kS3BqRU90dzdT?=
 =?utf-8?B?bG42YzVuZ01ndnVubFQ5Zi9FcFNnNEMzQktnbS8yemY1RnUyRFVVR0ZNbUNB?=
 =?utf-8?B?WVRZcEtNUGFlRVc0UXE3SEkveUZlZVpzaEpIZ2NGY01lMHh5T1J2c2tXdnFY?=
 =?utf-8?B?clZsRURuaXo1RmplWGduZkYvRlErYVhqUjZnT1BNU3NKWFJ0S0hnRHAxeUVt?=
 =?utf-8?B?WE56S25aNWxJM2VFUU8xa1AyaFBabmRDTXJTOE1MeVpENTRpSS9xekhDSCtE?=
 =?utf-8?B?VHZackJCMHdCMEJhWW0vNUJOUXQ1eTZxWUg2Q2k4RWpjWkV0dmdNMGw5eVdG?=
 =?utf-8?B?b3lFY1ZZRHJLbTJ3c1ViQ1pzNldHdk1oK2kzaHpJdHlwNHMzb0ZscVJxUEJ2?=
 =?utf-8?B?WVM0cnAvNTBTL2hGTWdKbE96ZXNiT2JETEpxTlVyQ1d1NC9ZMitmMVdLYlZk?=
 =?utf-8?B?SGpqMUptcUQ5RGFmSjdaRWdGNG9ydWlzREx4ZWxpaU55d1I0SUpnSmxEWnpv?=
 =?utf-8?Q?FOi5G+vfJH0B/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1BvQzlyRmV4MTBMMWpHN20vQ09KaU11UU9FTTlTUzdmb3M0aHJhRGdlZXFo?=
 =?utf-8?B?QUx2aFJMMGhCY1FrbGl6WHJXbWkzdkxhL0UyL3g4eHQvaE13djdoYVQ2R2s4?=
 =?utf-8?B?NnFJdWRkWlFvS3JUczdzeGRZdXRKN0VCdVdZTUhpRkp1K3pPN1A2WUZQNEdv?=
 =?utf-8?B?YVlHZFV6NjFUNE4vUkRYSjJ6Y1ZVajZhbXBjMmNiSFNSZXJheThINWIxdmUr?=
 =?utf-8?B?eU56YkRrSG9EVDBuNlFZejhkMXhTYlpYaEN3N0pPWjJNQVJUVFFDVFF5cnU1?=
 =?utf-8?B?alM3blFCUm5TQkFENFQremZVQ0RwT2xBamZzL3RhMkV0YktJQlB6OHhyYjRD?=
 =?utf-8?B?T05wbHdLVTI5aENwTUE5Q1FMemhZTitsdHVhUEt3YTlVbGEvMHBqd1M4NDVP?=
 =?utf-8?B?MldkNlJUeGJTMTR6M3Z5ZlFWbk8rZTA3bjRJKzRaSU1iRDExbFd5dUNhK2t0?=
 =?utf-8?B?ckVCY3MvbW9NTmQvcmVRUnRRYVUvTUwvODdTS3pkdURManFPM05Lek1OaWwr?=
 =?utf-8?B?YjVnRWVvMFNJcEVCc3hReDJXTGtEMzZxZmQrM2loRzVWTFhFcEJ2M0pTdUNk?=
 =?utf-8?B?RmNUMDYyTUtmS3pRSXlRc2xJajBLanM3MFhIVHFwdEgvSFRYd2EyRkRVRHN6?=
 =?utf-8?B?bGNkUEptWXR3NmFZdk1RNVR0NVI1WktJZzZpVG9wZ0o2akFBTnVoWVFDOXRt?=
 =?utf-8?B?M01wckx4azVsZUxMZkF5SWNiSHFHdGhRZ3VBcHUwMWk2Q09pLzMyU0M1UXMr?=
 =?utf-8?B?MDk0Mm5wc2ZRdEMrQ05QMmRaSktWSnJiNElSRk14SXVjSm1DSmI0WjNnZWRR?=
 =?utf-8?B?VjNGbjgxSnFrNFdubjRWUHB1cGtyaXcwUHhucjIvb0tUMmZRQ3RsQ3YxMjJz?=
 =?utf-8?B?dk5kWGhObmZBY2tqU0N6RFFtdUFBT0tsbXRjbVY1ZkxTMk5LMVBOSlBRaTlv?=
 =?utf-8?B?cDFjbG1ENk9XbkhwVUF4QWRMdGl5MkZlRlpWS0tiemhYUnc3Q09IUWpwV21j?=
 =?utf-8?B?K0V5OUF4SDdSNTlTYi9TSFJzNlBhdy9LMDlWZVFMRi8vZkx0VTdvYzliaGxW?=
 =?utf-8?B?a3FvcVUveEpITEU0bFpjeFpRSkp6WUFSU0pTZW8reG83c3RmMDZqejE4b0NY?=
 =?utf-8?B?QVpod0p0dFVCOVAvT09JUGV5WmF0dlorWDRhbW9lbHRMOUdoa04vU2JKMklE?=
 =?utf-8?B?VDYrOC9xREVNd0g3ZFkrRVN4QkhKalE3aXNxL3Y3TXUvK280YnZvMDNFeDlN?=
 =?utf-8?B?UTRxMmFKbEhkNlVzbjJZR0swbm1SRjlxTWFYVnVCSmlrSXE3VW02ZEZwUGpD?=
 =?utf-8?B?TGJ2YjZrcnlYZG5HQytEZ09lRElGWFJ3NkU0R0YzUjZxVXo3NFhwcVRveEVM?=
 =?utf-8?B?QmpndHRUT0Rja1QzSHgwMzhGTENMVHlpb3o5ZERRQ2RBNUJoRDlXaStNY0xX?=
 =?utf-8?B?ZUtxdkJmZHBNbzlOckpNOEFrZGpqVk9VVGRkREM5WVYzalBaTXBQMEoxZmsz?=
 =?utf-8?B?ZmlVenZlM3N6bktoaXpOL3Q2L3J6NHlremdCMlVJWkltTXB4cDhxa0ZBUVZv?=
 =?utf-8?B?YVRSdWlTdkxUU3JTeENnbDVmQTcxZHVmbDBYSkMwZTV2TzgwTzRQY2ptaHc0?=
 =?utf-8?B?bUQ2eHR3cTlyMEN3bWd5QTU1SElBUTkzTEtLVEpEaTdOa1JzZXE3Vll0K0hV?=
 =?utf-8?B?V2NiMkoxbENCYThqOTQxaEZKYmxMRWl1ekZEeEJoTXR6QzRaMjZhQ0dpb0tJ?=
 =?utf-8?B?TkdWbjd3cFAzb1Y2Qng1aVdnRWZLTHlqR1ZzV1hsZGdNZ051SU92ZzNkQzVm?=
 =?utf-8?B?RHFXSUxOMGJHWDRtamh3dkg1bFQ4emZFR3FUWFp1OXgwRmtOVnh2Qy9WRHJ0?=
 =?utf-8?B?WnFibWZ2RHZkc00wM2xtMVFIT0xSdjlud0IvalpBS1VabUdhSzlXcmd3SkpB?=
 =?utf-8?B?a0E0bktTbDBnTUlkTDA4U3VNQXl0TlBUaWdLcDlidWN4cm9QUCtXOE5ORnI0?=
 =?utf-8?B?aksza3NTQUErV1V0cHN0Y0tWTmRLb2wwWGIxQm42UStEUVp6bjU3L3Bhd09z?=
 =?utf-8?B?WlJ3Y2lFNVovR3ZNNUxveEN2T1ZmdkF0dmp2YnhCcmU3dFBuRGNsclczWWhC?=
 =?utf-8?Q?GrwNQbmcXLEnsnQxwRuigBDw+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7742758-b27b-4f12-a279-08dd49d778ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 13:33:15.4149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozL1YCzxDgGp3WesvLqPQIXYZfMrujQtks3d6TTYitRueAitYOgQNWBqFnrTflmZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348
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



On 2/10/2025 1:01 PM, Jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> This patch introduces shared SDMA reset functionality between AMDGPU and KFD.
> The implementation includes the following key changes:
> 
> 1. Added `amdgpu_sdma_reset_queue`:
>    - Resets a specific SDMA queue by instance ID.
>    - Invokes registered pre-reset and post-reset callbacks to allow KFD and AMDGPU
>      to save/restore their state during the reset process.
> 
> 2. Added `amdgpu_set_on_reset_callbacks`:
>    - Allows KFD and AMDGPU to register callback functions for pre-reset and
>      post-reset operations.
>    - Callbacks are stored in a global linked list and invoked in the correct order
>      during SDMA reset.
> 
> This patch ensures that both AMDGPU and KFD can handle SDMA reset events
> gracefully, with proper state saving and restoration. It also provides a flexible
> callback mechanism for future extensions.
> 
> v2: fix CamelCase and put the SDMA helper into amdgpu_sdma.c (Alex)
> v3: rename the `amdgpu_register_on_reset_callbacks` function to
>       `amdgpu_sdma_register_on_reset_callbacks`
>     move global reset_callback_list to struct amdgpu_sdma (Alex)
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 72 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 11 ++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 +-
>  3 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 174badca27e7..19c8be7d72e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -460,3 +460,75 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  			device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
>  	}
>  }
> +
> +/**
> + * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
> + * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
> + *
> + * This function allows KFD and AMDGPU to register their own callbacks for handling
> + * pre-reset and post-reset operations. The callbacks are added to a global list.
> + */
> +void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs)

Maybe simpler to keep it sdma_register_reset_callbacks?
> +{
> +	if (!funcs)
> +		return;
> +
> +	/* Initialize the list node in the callback structure */
> +	INIT_LIST_HEAD(&funcs->list);
> +
> +	/* Add the callback structure to the global list */
> +	list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
> +}
> +
> +/**
> + * amdgpu_sdma_reset_instance - Reset a specific SDMA instance
> + * @adev: Pointer to the AMDGPU device
> + * @instance_id: ID of the SDMA engine instance to reset
> + *
> + * This function performs the following steps:
> + * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
> + * 2. Resets the specified SDMA engine instance.
> + * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU to restore their state.
> + *
> + * Returns: 0 on success, or a negative error code on failure.
> + */
> +int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id)
> +{
> +	struct sdma_on_reset_funcs *funcs;
> +	int ret;
> +
> +	/* Invoke all registered pre_reset callbacks */
> +	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> +		if (funcs->pre_reset) {
> +			ret = funcs->pre_reset(adev, instance_id);
> +			if (ret) {
> +				dev_err(adev->dev,
> +				"beforeReset callback failed for instance %u: %d\n",
> +					instance_id, ret);

Please add more context like "SDMA pre-reset failed" etc. ('SDMA' needs
to be there). Same for the message down also.

Thanks,
Lijo

> +				return ret;
> +			}
> +		}
> +	}
> +
> +	/* Perform the SDMA reset for the specified instance */
> +	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
> +		return ret;
> +	}
> +
> +	/* Invoke all registered post_reset callbacks */
> +	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> +		if (funcs->post_reset) {
> +			ret = funcs->post_reset(adev, instance_id);
> +			if (ret) {
> +				dev_err(adev->dev,
> +				"afterReset callback failed for instance %u: %d\n",
> +					instance_id, ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 5f60736051d1..fbb8b04ef2cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -98,6 +98,13 @@ struct amdgpu_sdma_ras {
>  	struct amdgpu_ras_block_object ras_block;
>  };
>  
> +struct sdma_on_reset_funcs {
> +	int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
> +	int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id);
> +	/* Linked list node to store this structure in a list; */
> +	struct list_head list;
> +};
> +
>  struct amdgpu_sdma {
>  	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
>  	struct amdgpu_irq_src	trap_irq;
> @@ -118,6 +125,7 @@ struct amdgpu_sdma {
>  	struct amdgpu_sdma_ras	*ras;
>  	uint32_t		*ip_dump;
>  	uint32_t 		supported_reset;
> +	struct list_head	reset_callback_list;
>  };
>  
>  /*
> @@ -157,6 +165,9 @@ struct amdgpu_buffer_funcs {
>  				 uint32_t byte_count);
>  };
>  
> +void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
> +int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id);
> +
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 5e0066cd6c51..64c163dd708f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1477,7 +1477,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
>  	if (r)
>  		return r;
> -
> +	INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
>  	return r;
>  }
>  


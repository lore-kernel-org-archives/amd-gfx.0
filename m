Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3381EC87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 20:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2EDB10E48E;
	Thu,  7 Aug 2025 20:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l4xaZFat";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FFD210E48E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 20:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4wygEvUGaRxDYqXaQ9nDJoTdGTvtt4EEO5ND2+s1Oklh4vtWRYkQRavK1P3DxstI4E/7d3n46Sb2o4ih+fd0zdb8Gl8F7Z8bXLsrl5WE+mQrjirPoScbueDvlrCdbbKAPrgiccQ+Yt7ikCjkroDhQF7cFFvD4A2mpGzFeDcxraRjs/7QDxeBAbqEuCR20pVlkDnXAJiyZ+97rcXFWgVcntBHm3Q1FJ1/xziIa/T4upQRmqRdJ0c63aGi2UxVC19mI89pSsk0/qVDGf53tnn4Ym6sNH1vQNxgVa3iZtCEGw0n2Z+wGxIQ82Eein+tv19Scs0IpiGnIjtMQQxtZ4ccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RiMwAXRjMVFRkD79jufeBfTGJwhvArnk13C8KuuIgU=;
 b=y5DavOTbXdtcT7Fhoxh/uAD66sBF8vKQ5NAFWi0nx5MJtt4jukat2R7xLUkyVxIbkb8/di/QIEnoUAmKvqSlS4SuLMkxhgkdNkAw9E3G1zQrx9tt215F2V0+9zwvrxD0Z0PRW6uqCAvQ1WDKfFtNywny9Q4M5GdpNZGaSy62qJiSrT6LCyv/LiKYR3Z8gnVfETiip6t95qjWXMvyKhDDrApbC0b/k7/8wHiSRPXWwD8vRGX06186SIqYJoZS2qDEyIE4z5NQoWdnGMJIYLFoxblNKF4JsrXtYh3R4lac4DNOM9iC48V+iqyyq/PEKadi5IQb2UhDlszFY6GtxLvloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RiMwAXRjMVFRkD79jufeBfTGJwhvArnk13C8KuuIgU=;
 b=l4xaZFatOkGPTMEzORTuLFYh6MeJA06SoW5rbxR1B9z7euJD2NipNh6ZmTtwG1TYPYjm0eyZTO1ALT8rlJBxOA3k1DCIP82AjKYL88SwmeC1iRqv/mAnsYIgxXeYoQE+JEtUBgnOAFTEfiLRJ0IXwuYHgvJ6N8lAFUuuD5HEztg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 20:55:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8989.020; Thu, 7 Aug 2025
 20:55:19 +0000
Message-ID: <c8b04e72-9085-47ab-bdb1-6f0f3bbc4752@amd.com>
Date: Thu, 7 Aug 2025 16:55:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/13] amdkfd: process pointer of a HIQ should be set
 to NULL
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
 <20250804110550.261311-11-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250804110550.261311-11-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0195.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 964609e3-1f53-487e-4127-08ddd5f4b812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDlBWU1MTHVkL09WaUsxWXBLMGRwMmx1TEdnVlpxSXYwWUhpRTFZaHEwcGtm?=
 =?utf-8?B?Rm1CWUVuZ2UvSUtKQjZtYW9zSTh2YlJmVC9xYk5ZQ0FnbTQ0bWxGc3B1ZWd3?=
 =?utf-8?B?TkZBS0RCUUdXT1IwejlhU3kxUWlPNDhCTmcwbUlvR0V0eEVkWlMyK2s4NG5r?=
 =?utf-8?B?ZzJ2Z3plTkV3NEVTTTJZNWJOdEp5ZGRHeXVoUzRuZTJKcE14eG1sNUFKQ05j?=
 =?utf-8?B?YkJieURKdnRrZkd4eVFKZzYyaEg1NVExUkpqWEhNaDdRVUtOMU1TZjY2QXI5?=
 =?utf-8?B?dWlmMDRFakhjMlExSUxKamhia0dnSXJFMlVucE9QMTk1K2g4RHZBelJrRHRH?=
 =?utf-8?B?M3VCMWMrR1MwcnVnOWpYQXF6SVFWSjZyNjdMaUs5aUxaYVVxcTdnNVdlaDIv?=
 =?utf-8?B?c1Jma2RVTVBBRXl2aktmeUlQdjBiRDBQcWNpOC9kR3FLQ0tQUWUvcWxEK2p3?=
 =?utf-8?B?TzFyeFR2QytramhBd2s3MHF4TjFKaFpHYmMxUHhzTFdxV1VacXRsbTNGTUhE?=
 =?utf-8?B?ZnlDYjI4QnFiRjdrR09ia0o2R1Fpa01JWm9yNERaRGd1dVZVKytQaUI4M0Js?=
 =?utf-8?B?SndpQ1YvcS9UQ2xWdWpQaDFrMFJ4WjdYZ3NMMUNaNHdtbzI0bE91c1AzZDZB?=
 =?utf-8?B?djJLT0UrQXZ6NTRWcEIwbUZDcG5oQ0FVV0RGQjJ1KzdoUXIxS3d0NDJnbUUv?=
 =?utf-8?B?ZSswNjN0eldkT3NoMStSbjQxRldHNUt1RFhXaUYxRVRCcTVGNlVpT2lNbkl1?=
 =?utf-8?B?MklESnFiWm9QTnE1L2V2WGF5aVpHMlVkMmdZVTlVVUxWSEtTUUlvWWFwa2NF?=
 =?utf-8?B?NGowK3haQnVESWkwczZwczNmNVdOTThGY01sNzFNUTB0MzR5MGw4L2ZTSjBL?=
 =?utf-8?B?bnNCUWVhVHo3VkcrbVhTRmhvUVFqQzdBNHIxMkZnWkZiNkUwUEhYa1lOZGtH?=
 =?utf-8?B?WlNRSzJucjEvWlBCVDY0WnByN1l6T2pHMzZlTGRiOFVZL2x1YmRFMlcvZ1VJ?=
 =?utf-8?B?YnZFdFFzdTFmWEthZDNRYXBtaGJjeTFkZ0g4Mnc1WUltNHJ5SnhZa0E1eWcx?=
 =?utf-8?B?Y2dqL2tNbEhNT1p3elU5L0ZUU3RoTklDUEdXYWVkYWhia1JGNTRwVUNoWVBr?=
 =?utf-8?B?dkhETGI5SkJ5cUdGSjA4ZHFjU3JucFQvNVFDUW84VHUvUnVzQ0JGd2F3M21a?=
 =?utf-8?B?dlgweHJudVZuSkxnbjZGTG81VkdTS1dnQ01EeXA1aHhrMUwwbVlXbnhxTHA0?=
 =?utf-8?B?Rll5dW9NSXVqSWlRTTQrRWJLYUNhaVVxSzJnV0tzaFV2aHFWOUNyUE9GS3Uz?=
 =?utf-8?B?TStEZTdwL09BN0I1RFdld1ZVNFNXWElDQnV2cVF1TFp0eXphenFGL3IyV1E3?=
 =?utf-8?B?Q3BvYXJhRTdYR3M3VGFlcW5qU3hLWWpod0MwOXk2czBUM1J5ZEI5VmdxNWR2?=
 =?utf-8?B?SmZZUERvKzFybWdEbGFrcFBxeUJIMnNhRXZQT05RT01jOGUvWVR5bnVlZ3Bv?=
 =?utf-8?B?YWhHUkQ3VjRrajBMeS9NUVV2bWl3SkZDZmw3WEx0NU9WRGQreWRiaUVKek9p?=
 =?utf-8?B?WWRYekcwODhCSEp5aU5tQlFQQURPQzJLeVVnTXllanltbkdldmNqSVBkRGdH?=
 =?utf-8?B?QlZ1WC92bXhLckpaazlIdXF4d05Ebnhzcnc4VDI3QitJQmFmVFZUN01pMjRS?=
 =?utf-8?B?dzRpR1pMOWlzMzJ6TURISHYyTHZQSTIxeTJwNnl1cFBJZTd4RExRNzVOVGo0?=
 =?utf-8?B?dk83UXdYTzhLaldUSitaVk5VVE1pUVpRM1JWdHFLZTJiTWxCeVNQbWJvb280?=
 =?utf-8?B?UlNGV2h6OTY4Z092UkFpOXV1NldpdWFSV2huOHJVN3NwUTlNV3pVWUphKzhN?=
 =?utf-8?B?aHpobVBSYk9oS3lkbDdGVlA3Q2t4MlFaSmxIV2pnQnpDYmlzLyt5QTJCemp1?=
 =?utf-8?Q?eE0qZ7qWEEI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDNHYjVobVpmTE96dEw0T0ZwbmQ0NFhBNW8yZWVEU1R0MGp2T3hEbmtIUlhX?=
 =?utf-8?B?c2wxd3R2dVFTRDljNzA1eTk5MDFlckNtcjNTbmhwMmVMc3VsRkx1c3ZxWXEr?=
 =?utf-8?B?T2Jya0hBdjdBUStDSXU2OGtaN1JlS210dGR1TExvNDBCV25EeHBsRDI4T1dV?=
 =?utf-8?B?UVBKVUFhUHpKTG1PbmMyNmkzMVhhemNFWDFJcVU5djAwd096SEFaV0JYNFhY?=
 =?utf-8?B?M0JsemRia1ZxZFpCaTRqZm1oSmExclBBdW04Z2MrYnU2QzVKSmc4Y0tjS01F?=
 =?utf-8?B?NG1ERDYrbUJKVW1qQ050ZGZ6cWFZdWVOTm1jMXhTTHFYZTArNXVHWGV6RWhL?=
 =?utf-8?B?dWU0YlUvNFRqaXhNZzcyMWV2SFo3QThXU1dQSE83ZUN2RWZRRGJiV0oyQ3BX?=
 =?utf-8?B?TlYwOEtkTGRMNmo5U2syOHk5ZGdWR2h6ZUhGN002VTZvbTZBNjBoTWV0aEth?=
 =?utf-8?B?em1NSVYxUnBOUGVhaUVjTmVhdFBrSVB2Z0JJN2QvdFM2dEpwZFh6c3oyeWJB?=
 =?utf-8?B?MGt1MWFzZjlEdlZMYm1aVWdHbGVjMG9ScUFXMmZGb28wLzdjeWJVS0NtSzVR?=
 =?utf-8?B?MmQ0ZGVGcVR0ZmJkSWhoUFQ1QkhoRDBRM1A1UU5YTzVzRWFZQ2hURkgxZ3JC?=
 =?utf-8?B?ZVZpNEhpcGx3c3JmTmV1ZTV6TDE0UTV5bUdxR0pxdnF6b3lhSlBBMEdHMjQ5?=
 =?utf-8?B?TGE5UVlqaVp0aWdiMnpXdUVVQWZiN3dxN1RUY3Y3SXptMncyVFJCcHFYR2tE?=
 =?utf-8?B?azVrb3pySXBpUUtCMkJJNDNEMDJWMnMyT2dBVkFkOEd2QjVEV3ZVbmFjZFdr?=
 =?utf-8?B?SzBIeHozbzVRRU9yNHpQZ2tKcU5tMDJrcDh6bmFoN3lnZFFFMjNjMmlqY3o3?=
 =?utf-8?B?eWdTTkNKUTVkTWFwclBZQllBbnNlMWJpZ2NUZEN3R0t0RFNTMU01d3pSWFMv?=
 =?utf-8?B?d0tTM081eFBSRVNjb3ZNbWhzOHZWWSs3TjZTMXZxZ0t2b255emRWaWpKS0V0?=
 =?utf-8?B?U1QyN3ltYUJEVXBSeEkwUWNGbzRkbEFZTW40dHQ4UzZyU3RnUmhlbXVPYXFQ?=
 =?utf-8?B?M0hhbXpabVNmSURhaXRWN1VuZnN4ODRKVkVvUUxPYTBkTWtWeExzTGo5eGFU?=
 =?utf-8?B?SmFoYU96cVhIS1ZTckx5OC8rSUROcjJBWGxkK0dFUzRKYWpZeWVtSitrTTFN?=
 =?utf-8?B?NnJIK0NHM2xpekN0dHZkcm0vSVZqWWpKVG5zWlBIU0VyWXpYcExnb284US9T?=
 =?utf-8?B?Y0E4RHh2TFM1TWkzU0hoa255ckh6QlUwMERCdENSWkRtSmFTQjJaN0cvbEdl?=
 =?utf-8?B?a1lPYkVkeDByelk4WEZ2QlVpaEE3SkpsWlFsNEFtUHZEUXpnZU9PWjF4cmRN?=
 =?utf-8?B?WkFSNWlKYTRQMFdDay9leUxobkFSaGUxM2hGZVBzc01aR1BYaDhDVkZtU3dH?=
 =?utf-8?B?YXorY3FFQVNkU1lGcGwzbzJlMDVKTEZJTWZkZHA3TnhrUnhwYjc3Wk9pMWEv?=
 =?utf-8?B?b0JOa2srMGNyT25FWW53U0RYa3p5cEZVM3JFN2RLc3pTbysyZzd2dDNuUzhI?=
 =?utf-8?B?T0N5Zll1aFBLR2lINDNmWUVQZGJNelo4blk1d1Z4Y05jdHRyUThpRHQ2QVhU?=
 =?utf-8?B?L3llK3hsUzB2UlBvekdaTE80dFN2cjVLVHRYT3QrSTlmekh2SkkzRWoyR0Nh?=
 =?utf-8?B?bFdoaEp1dFN3MlZGelViYm9OZGtGWVQ3a3A1NTNkNXBEeXFLMVV0d2tmQVhR?=
 =?utf-8?B?akR2Uy94Z3M0bjFUU1BwcjJ0KythVHNXYUZLL2hMT1dDcEM4S0dnZE9WdFVR?=
 =?utf-8?B?N2JxRDhOVzcrWmh2ZlN4NVpMaldzY2syRGIrZTBpWWZVMnZKQklTOE9SQUNx?=
 =?utf-8?B?bmtzMEZCMmhReXNXWnp2Z0hxMjRvSzhqeHcvRFcwZDMyYVVmeWZLN2hsbTZF?=
 =?utf-8?B?VlhpWTkzOU0vNXFWOU4yTk5BN1F6Mkd2c1FRS0NaVFVsWjBjR3F1L1g5RTRZ?=
 =?utf-8?B?VzNzUVVXdXlJOFJMeC9sREFaSDlqTUpKVDNJeWJLWWVMY3BRUVdVc01EZG90?=
 =?utf-8?B?ZUhJSC9veXYyTjhEMWFsakpObVJKdWttd0t3dzNEcFp0MVdOQ2FWaTFLTmRl?=
 =?utf-8?Q?zKVYnPgMRkDBXM4DQPI2FDpJW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964609e3-1f53-487e-4127-08ddd5f4b812
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:55:19.5190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/2vn7ocmfn6238BA4nQpf9Z0njAlj4qkFgPUucgbLvfRFRb2X0nIHphrbyPr+SeJDk0ZLOz5oH4hYf3+TzmlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394
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


On 2025-08-04 7:05, Zhu Lingshan wrote:
> In kq_initialize, queue->process of a HIQ should
> be set to NULL because it does not belong to any kfd_process.
>
> This commit decommisions the function kfd_get_process() because
> it can not locate a specific kfd_process among multiple
> contexts and not any code path calls it after this commit.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------------------
>  3 files changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 2b0a830f5b29..ebee37937783 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -144,7 +144,8 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>  		goto err_init_queue;
>  
>  	kq->queue->device = dev;
> -	kq->queue->process = kfd_get_process(current);
> +	if (type == KFD_QUEUE_TYPE_HIQ)
> +		kq->queue->process = NULL;

I think this should either unconditionally set the process to NULL for kernel queues, or not touch it at all, because it's probably 0-initialized at allocation time.

Either way, this commit should come after the one that removes the DIQ type, because DIQ did belong to a process.

Regards,
  Felix


>  
>  	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr->dev,
>  					&kq->queue->properties);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d140463e221b..25534473c28f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1050,7 +1050,6 @@ void kfd_process_destroy_wq(void);
>  void kfd_cleanup_processes(void);
>  struct kfd_process *kfd_create_process(struct task_struct *thread);
>  int kfd_create_process_sysfs(struct kfd_process *process);
> -struct kfd_process *kfd_get_process(const struct task_struct *task);
>  struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
>  						 struct kfd_process_device **pdd);
>  struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 8e498fd35b8c..0c3f0cc16bf4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -989,24 +989,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>  	return process;
>  }
>  
> -struct kfd_process *kfd_get_process(const struct task_struct *thread)
> -{
> -	struct kfd_process *process;
> -
> -	if (!thread->mm)
> -		return ERR_PTR(-EINVAL);
> -
> -	/* Only the pthreads threading model is supported. */
> -	if (thread->group_leader->mm != thread->mm)
> -		return ERR_PTR(-EINVAL);
> -
> -	process = find_process(thread, false);
> -	if (!process)
> -		return ERR_PTR(-EINVAL);
> -
> -	return process;
> -}
> -
>  static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
>  {
>  	struct kfd_process *process;

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B79C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 07:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 580D710E13C;
	Wed, 19 Mar 2025 07:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GQxOPlo4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C742B10E13C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 07:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaV5sYBguHbp51c6Sv6WivaPJeJ7e2b9xXWkKFzhzRhdkAggmjBoCxQj07NnG42QLnfPlZm5x2X8/XlP0lCwx8ZJv6aQQGU2/mC7j1S7Jc4ytHYJKVzNLGpl/EH4qksI2RHzuKEi1k74Axg6zID5pzcSYLJShUzzMsEuGWhRnQFA69NAtFnoXiPuJzlatRIdeK/K922VIjw+BvrjxbzhnuvhLXvNGIdYc5Ur7rbPiH77fYlS+9djTO7HLqjTmnRI9F6Y/UTapFOzXJpPT/wOqSbgwgFjyGC84HtvhOVEZnzKnW7FxnzqR8LNZfIEvMwfG3DOrfZqcegA0Tnnw80ITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OjHSNawvAU+JxKa61afyqYC5BC13mNH4ekyi77kfcs=;
 b=bSdzzTonymaC2InbZt7+YUYbLb7JvbPdnQHSpYIym5x0P9vsPiLPSzLfDu6KW4JbXc9XcJ1H30w56I0CBY62gUQJ3RnYUUV/x5hiuo4scEr3XZyrjHlKm1p4cNHoqKjiQg2HoE2UHJh79VbJXMdZWJwzxIi6DYir1ZvvZa/X6XhXyYVfhTU4+u+P+31s8RIQPOicHXk869DajxXvI6DvFffU24OS0/cEOC5hk9eL1QFkSoQDjtPNTJmPGYMm6l17t1LWpPsg8nCkIr5I170cdhwrR2Y/MHtBQtebtMo9jhAm2Xn9R6WAYSr/O3IKzmciZDdORg/dh/NtNULDCjxe2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OjHSNawvAU+JxKa61afyqYC5BC13mNH4ekyi77kfcs=;
 b=GQxOPlo4FYQI5cD7Mhz4sWmqGVvscYooY+9VHzusSDFB1QYjcH7O1PLAugGeWKMYhD+TNluNE9lFC0S3mrA9E6oWW8wAT8KmbgmdigIIY44bKFNths4Uznv2K3WWlhdvxObxQHUT0B+DTySEE32osh/0NSWQ9NDG/zME8Bkv1d4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 07:19:36 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 07:19:36 +0000
Message-ID: <bf70db36-141b-4d06-adeb-f71c0bd2f463@amd.com>
Date: Wed, 19 Mar 2025 12:49:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 V8] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20250319050727.4099266-1-jesse.zhang@amd.com>
 <20250319050727.4099266-2-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250319050727.4099266-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af13836-ceb1-49c6-65f0-08dd66b6674d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG0zbGpkUnNQek9BeGNCa1htSzJ3YXFqY1lQZmlGWWQyVzljNnpwenpLNVZ6?=
 =?utf-8?B?OS91NSs5NzRsWDFHYlQ5QmM5bjBrdFFmMEc0dC9sOFdUWDJtUkNMR0c1VFR1?=
 =?utf-8?B?akJrSFJ2bVBqQmoyN0o0NXJBOHp5R1BKY1A5ckR2N1hFbFpKcXQyTHZUdTkr?=
 =?utf-8?B?WGZ5bFoyUUFUNmxYZlRjT2Jra25YTllPWTgyUzk3ZS9uak9lcmQzNXpKOFpw?=
 =?utf-8?B?YUhhM0M1OWgzN1ZWbCs2ZFFIaFdrZmlNajRJYXRLSlI4UzZjQ05UdWpFQ1hu?=
 =?utf-8?B?UlhCRkZQaGwxNzcySmdsL0p1MFRKQ2FoNm5Ka0NqeGtjRzhXaTM2SUpKcWRn?=
 =?utf-8?B?T0U4dDZKVTZVdzVNUkFRV1NEcjhXaEtsUVF0b28vbERJNWFSaFluN0xSdGoy?=
 =?utf-8?B?K2NVTTBweVBWQkFVZXg4djEya2NOUGZZemExOTlTbjJQM0QrNUMvTTdMODdr?=
 =?utf-8?B?bEwxdWdvOGhiZzFTem1JVklwWUpuL2hMR2E3L2t0bnBtWUJ3TnkxM2dVSmF0?=
 =?utf-8?B?RDNsQk9zL01VMUgrd3NmK0xVVVBwNWgvRy8wTlN0UFdCNEFVL2laZkNUZWFX?=
 =?utf-8?B?U1R4OXFiTXBGdG9mbWZOMW1HSTNacUk4TlZ6SlFhQTV6RFladzhFRU9CNmcr?=
 =?utf-8?B?cXFrWGcyZG1uNUpkbmlDcEwrNGd0WWlvODl6Ly93TkJpLzFrRlZRRFhwUmdW?=
 =?utf-8?B?STN0VVRKdGZDT2lYMUhTVTNiOXVSQkJISmJIQnBUYUhTOEcweC91TGFJYTkv?=
 =?utf-8?B?T2RpR3hZUzV2c2Zyc2tjT2pVclZGS3V1cHpqOFBaQk55Mk9MSXdZaXMrazRS?=
 =?utf-8?B?Y3F2MGljSVpDY1lqL2xBVDhHODVPKzlHZTZmOEYzOGEyTGE4YW5WR2dmdnAw?=
 =?utf-8?B?L2JyejZlZGx5aWZOOHY2cXpLT0dGaTFVcnQ4SDJGOU5jQzVvOUpqSmd6Z2xY?=
 =?utf-8?B?clJuNDhUemJkdjNidUhsOXhrQm9qeW1BK25BMEY4SGZscWYrY2M1Ylp3YVl2?=
 =?utf-8?B?WVcyZEQ4bGl0VmUwMlNZeUtEYWV1OWUzVW1jSFlRUkNSUjArbG94aTdjRWNQ?=
 =?utf-8?B?NUE5QXRtSE82VE5xNmx2MHlhYWlRNUZCQzlEWG9kTHI2ZWY3dlhNb1hPeGFX?=
 =?utf-8?B?OGo0R2RaRThTcHFwbmRkRHZieUJmTUlSMTFpeEp6aEdmNWJabWJWcnBwbTZC?=
 =?utf-8?B?MmRadEdYek9vWGJ0dzY3SUdYMWhnUWlQYWFJd0RXQjdKcGxzZlhPSkVVRi9W?=
 =?utf-8?B?MlJmTG1QSVpuS1VSSk5xTFZTalRzSFpvaFBEK0wvZmJhd3J2RmJwSHJGeXRU?=
 =?utf-8?B?ZFpEM2d2Rmp1NEpqV0pYdW9GK2dsT1FMUmhzbkhBY0wyR2dobWMycW12MHFR?=
 =?utf-8?B?VlZ1VnQ3bGc3QzVzT3o3NHJRTUtROWRPUWtWZHVBcE1HOXNlOGZWZEZZVjBq?=
 =?utf-8?B?cGJESUJGSWdpVVl5Ymd0UG9Lb09zSGIwVGl1UlZxcWxvVHNmbUd0QXZvZm4r?=
 =?utf-8?B?NC8yaURHVEQwcGNFRzl0Tk54ZkRkekYxUU9LemliRGV6dlZObWx3ZjlGL08w?=
 =?utf-8?B?VUl5UlFkMkc5U2o2MG9PMzgxUkNad3h2djhvYlpMQXNhN3ZZb1R1dVVwVHFk?=
 =?utf-8?B?bjBNOGFXNlppSldja29WMmdsaDgvMnRySnB1NDFscjN5NkNkeTJscm5TN2Z4?=
 =?utf-8?B?ZGhHbVN2VlMrUTU2SnNXVWJJVEtUU3h1K2RDOVY0Z1hMMHVzczVNWHRvZ3du?=
 =?utf-8?B?cDArTDQwZEluQkVSNlcxb0NtTXhLY1pSWUlSRzVPQjAvVkNtdmZRNUVoNCsw?=
 =?utf-8?B?SjBteXZQTnVqa3pLMVljQnRwYnJWeWVGNE93ZEg4TWtQTG41Zmh5M3dIYm11?=
 =?utf-8?Q?CxCB4MQ6DIfmv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnpEVTRjOUs2RTVTUEk0VXdqMFhlZTJqbWpXbFBOZ3BaNFF4T2VyZWpubDl1?=
 =?utf-8?B?Nnp1eGprdFdDTWk2Z3l3cGxyVHB6RjFRdlpqSmkvZmtvZU5HZEhGajZhcXRa?=
 =?utf-8?B?blI4YWlzb3UrUTA3UEd4WFIxZ3YrUW9ubG10R0l2am5lRWpaTzJXcVFGbmR6?=
 =?utf-8?B?aWVsZjkrQzdaeU1kTVh2U2d6ei8zc3FNbXVtYnoyTVBFNkpjUlBhZkRpdFVO?=
 =?utf-8?B?UzBrbmIyRXp5bytUVkcxbzhSb1Y2TitrcDRpMm82RzFWQTRBQWZzcGYydnBu?=
 =?utf-8?B?QVNNQzh1YTRXOW0reVZ3OEorVGJjMXVoYzVXWkhhL3lrRkpxVThPOGh5dk5o?=
 =?utf-8?B?cWQvcDdtbEROdWZtTGtDc1A0VW9FWXhlM2orWE5mS3dZYnJrZWpXaXFyb09W?=
 =?utf-8?B?QVcrSmNaNy9pMG1uRSthcHFad3V5eFpRTVdEaW56QU0rMW8vem1zb3orR3Rr?=
 =?utf-8?B?TWYvQ09sN1hOVjhCNkNGcTEwUG9mbjZ6aHN2d29ZVHRqODNQUXhvSlQzUW5w?=
 =?utf-8?B?K2l0akZzLzFyREhFK0dMNTh2MlNJYnovTmpxcHNjS205bmhwQk0va1F2cE1a?=
 =?utf-8?B?QWdqRE1XMnRlYmtSWnU1MWVoY1ZxY2ZOY2E5THdKNkNIWUJ1b1NFKzZMWVNp?=
 =?utf-8?B?cnlUQk1kZC9kVk1UbHpoQys4Rk1jbytENnBSOVJoUmpVWEJJVkRrL0ZqNktt?=
 =?utf-8?B?RmN5WlRhYitOQ0lRR1VKYS9QWWU5UmFrRFNyRmt0V2NWSWxZQnhoaUJWRm1O?=
 =?utf-8?B?WnVycStNb28ybzlyZ1FqdS8wbk5CVEZlWDRSV2x4bTM1L1J5UEpudCs2N2J4?=
 =?utf-8?B?bEFwZG15NlB6dnVrQkZ2b1o1Z2czNEZTNU1JRERaVG5PRzNNMGhlalVTWjk1?=
 =?utf-8?B?bngrbzJ4ai9CU0J6MEQ3M2JSTjRoRFhrS1hIZW50eGxNbHZNZzlTTFFMMXli?=
 =?utf-8?B?SGVyYmdDVVYrRnkxMzNlbzdTVkh5VEhJR2dlNExPSmR3VWJGeFFBZHR6WnlW?=
 =?utf-8?B?R3F4TUF0RVB1THlYZEt1eHVwdmxSSkNmMVRNWEMyRlkrUEoyM0doUWQ4NFky?=
 =?utf-8?B?U0NwNys4TFozakhBT2NvWGFPYktVWjI2cnZ1TUQ0QkUwVjI3MU40aFNlUVpq?=
 =?utf-8?B?Nk5ncFhFaXlQT1E5OGhxUnBTNlAyVDVtQjBQSmd2TTlvMU0vQTE2ak5HVEQw?=
 =?utf-8?B?aUlkZjg1ZytPR3Bib3dVbllNQVJpb3pnYnJIc3ViZUdzdDF2ekxwRWFBT3hs?=
 =?utf-8?B?Zk1jOXRLVElBZ1ZCMEg1Vk9obnJaV3dvRFRpWUg0bGdjbEtEa1FUUzI3RkdP?=
 =?utf-8?B?Z1hjT0MxYnd2RTJvUzVDRWRqSVZPeVRrS0lUYmlFU2tvdVBja056UG1ZcUxJ?=
 =?utf-8?B?Q284WjZHUVhGQmhJZS8vV1YydnZ0eThHbS9YMGpOL2RVdm1ydFhzRnhFOWxq?=
 =?utf-8?B?YU5tMDBNUStDdllqRi9pWXM3UTRiVXhIK0dxdktvT2R6MEJnL0J2Nmtob0dV?=
 =?utf-8?B?ZXJIb2hZZlhPeDl2ME1PTlZzcTRPT3FacElUd241NVVUYU14VFlGVm43cktD?=
 =?utf-8?B?MUkwOE9paFAxb3FON3d5MmszdDBXVmxPRnVpcWIwbWI3cjlYNzFNd25nWGNY?=
 =?utf-8?B?QkpFdHkxcGZmMHpKdEpWTFJSNkgzQkxxbVBoMjIyQjhZRTlGY3ZqRm9PNmsz?=
 =?utf-8?B?SGlOUVRMVTFmYjMrWjNWS1d1empVRkRMZHo0bzV2VzZvOFAzY2xtUGxBcVB2?=
 =?utf-8?B?NFk0YVc1Y2oxMXFORFp6WGJDYnhlR2pCTjFVOGQzUGRoNXJINk80WlhXV3FZ?=
 =?utf-8?B?eXc1Q3BYaXo1UVo0Qzl1Z1pOd0MwUExLYkRxVFhUY0UwOHAyNXVvQTZJZ2Fy?=
 =?utf-8?B?OXR3RkRQcnRKUS9xWkhFb3NKek51UnBiTE9YVnoxNUo4TEdHOGN4a1dNSUow?=
 =?utf-8?B?dnRqUEQ4ME41bThXSmN2NFVUTCtsNk0xdzFwSXRQbVprMzduS0Vpb1Fxazhr?=
 =?utf-8?B?N1R6NXlwc0xhdncxQ0RkaDFraW15L2FqTlZVRHBGSGZiNGhCRlUwWXpMd0VP?=
 =?utf-8?B?Y294Z1VXREZydHRPc1lDM2NYRnNBbEdLUGN2bUNDajB0eU9nQ05YM2Mzdzdp?=
 =?utf-8?Q?eo2sY9ujarE6RDpfRm3hMWhQk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af13836-ceb1-49c6-65f0-08dd66b6674d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 07:19:36.2817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cvo7d9sTvamkZr3GBWCuIPg6EXPPkZ4QmQk83L7QF7m/I8ywK0l+48dbvI5/7acM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
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



On 3/19/2025 10:37 AM, jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> - Modify the VM invalidation engine allocation logic to handle SDMA page rings.
>   SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
>   allocating a separate engine. This change ensures efficient resource management and
>   avoids the issue of insufficient VM invalidation engines.
> 
> - Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
>   Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
>   during TLB flush operations. This improves the stability and reliability of the driver,
>   especially in multi-threaded environments.
> 
>  v2: replace the sdma ring check with a function `amdgpu_sdma_is_page_queue`
>  to check if a ring is an SDMA page queue.(Lijo)
> 
>  v3: Add GC version check, only enabled on GC9.4.3/9.4.4/9.5.0
>  v4: Fix code style and add more detailed description (Christian)
>  v5: Remove dependency on vm_inv_eng loop order, explicitly lookup shared inv_eng(Christian/Lijo)
>  v6: Added search shared ring function amdgpu_sdma_get_shared_ring (Lijo)
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 19 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 33 +++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +++
>  3 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 4eefa17fa39b..26a90576792c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -573,6 +573,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] = {0};
>  	unsigned i;
>  	unsigned vmhub, inv_eng;
> +	struct amdgpu_ring *shared_ring;
>  
>  	/* init the vm inv eng for all vmhubs */
>  	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
> @@ -602,6 +603,24 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  			return -EINVAL;
>  		}
>  
> +		/* SDMA has a special packet which allows it to use the same
> +		 * invalidation engine for all the rings in one instance.
> +		 * Therefore, we do not allocate a separate VM invalidation engine
> +		 * for SDMA page rings. Instead, they share the VM invalidation
> +		 * engine with the SDMA gfx ring. This change ensures efficient
> +		 * resource management and avoids the issue of insufficient VM
> +		 * invalidation engines.
> +		 */
> +		 if (amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
> +			shared_ring = amdgpu_sdma_get_shared_ring(adev, ring);
> +			if (shared_ring) {
> +				ring->vm_inv_eng = shared_ring->vm_inv_eng;

This also has an implicit assumption that the shared_ring is already
assigned inv engine.

Ideally, it's better if a ring and its shared ring(s) are assigned the
engine in one-go.

// Skip assigning individually if it's a shared ring.
if (is_shared_ring(ring))
	continue;

// Assign engine to ring
ring->vm_inv_eng = inv_eng - 1;

// Assign ring (or rings) that share the same engine
shared_ring = get_shared_ring(ring);
if (shared_ring)
	shared_ring->vm_inv_eng = ring->vm_inv_eng;


Thanks,
Lijo

> +				dev_info(adev->dev, "ring %s shares VM invalidation engine %u with ring %s on hub %u\n",
> +						ring->name, ring->vm_inv_eng, shared_ring->name, ring->vm_hub);
> +				continue;
> +			}
> +		}
> +
>  		ring->vm_inv_eng = inv_eng - 1;
>  		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 39669f8788a7..6287159dab62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -504,6 +504,37 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  	}
>  }
>  
> +struct amdgpu_ring *amdgpu_sdma_get_shared_ring(struct amdgpu_device *adev, struct amdgpu_ring *ring)
> +{
> +	if (adev->sdma.has_page_queue && ring == &adev->sdma.instance[ring->me].page)
> +		return &adev->sdma.instance[ring->me].ring;
> +	else
> +		return NULL;
> +}
> +
> +/**
> +* amdgpu_sdma_is_shared_inv_eng - Check if a ring is an SDMA ring that shares a VM invalidation engine
> +* @adev: Pointer to the AMDGPU device structure
> +* @ring: Pointer to the ring structure to check
> +*
> +* This function checks if the given ring is an SDMA ring that shares a VM invalidation engine.
> +* It returns true if the ring is such an SDMA ring, false otherwise.
> +*/
> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring)
> +{
> +	int i = ring->me;
> +
> +	if (!adev->sdma.has_page_queue || i >= adev->sdma.num_instances)
> +		return false;
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> +		return (ring == &adev->sdma.instance[i].page);
> +	else
> +		return false;
> +}
> +
>  /**
>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
>   * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
> @@ -545,7 +576,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
>  {
>  	struct sdma_on_reset_funcs *funcs;
>  	int ret = 0;
> -	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
> +	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
>  	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
>  	struct amdgpu_ring *page_ring = &sdma_instance->page;
>  	bool gfx_sched_stopped = false, page_sched_stopped = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 965169320065..77288bfb4e76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -194,4 +194,7 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
>  int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
>  void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring);
> +struct amdgpu_ring *amdgpu_sdma_get_shared_ring(struct amdgpu_device *adev,
> +	struct amdgpu_ring *ring);
>  #endif


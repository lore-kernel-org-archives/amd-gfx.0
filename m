Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE63FCCD1BC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 06:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 751BE10E888;
	Thu, 23 Oct 2025 06:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EK807r8J";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4977D10E888
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 06:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KO6Yf6eW1g/eB0HOpwpbrXEYhvuypifEVxTWTRc3vbJbI1sHyvJaBxMPCP/nwRYsM6GX4Yoij2xMke84+tGl0oZRq/lmuIKs4k/mw4zwT8NElkpvb1viq8PS7MjN2s3LdiNDMrC1Acnz9m5Abv8V8wtZ6OXMyxKXfzD5GS49FedbyaOTDYUB3H9QSlidYvjAl2bdyVVfMw5675DPTHkMO0So8ml/GNnIX5hsL3KPiPnPqga0PCB/Xn2Ha0qpZuRh2AlWORm95JPF0TscKNdn+v4tqIIli/YZBrNThimrDDLjeoTyRRwTOnONc2qBeZvBCOjQWZwsYbTfvmd7WsALeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdo9hIW4hiFxaA9lOa4MRTrtwlyeYFU+87+hJ9SPeXk=;
 b=WyrG3AjNOy2gkbmV4i+bQbW5ka2e2qWiUg/hT2iYyRBW0U/D/tbf1KMp0oshR6hJJnvHg/r824jxlxhepsItD9V83P12A9BHsmqcRK6tu/KloXt6fIswH1O5A8PkeT7fCZlvAVIUoD4eSnpn+K62aCblWkDNdpIp2H84udfKYSIYrggMEw9MOpDjzjdyqnfb/7lK5bcCXMttzZ2JEHK4V2gpf2i8Z9NegL7ov2/2YSWzD0R52kcI4L5xlWio/lqRSEZp7AzZyqCrpJmPUtEYWXDxFlebn8fZ30jQ7mOGluI7p2SAgxDRPr/2MHkHCD7iHQehXODmNl68Ru4rsVVcxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdo9hIW4hiFxaA9lOa4MRTrtwlyeYFU+87+hJ9SPeXk=;
 b=EK807r8JzD+OkbKpVKyQySkZnV1ZZ4mwKBW6IuBO1QQyk1nqDKTzzueOcWEdPuwGF6jLBoN9Tb2Uvp1iuv1ffG9IdIBe2ScYJJRJrSZ+f5CA4W1a82/Gjlod7ZwgzLpXURBA0yQNcz8hsYTXF5ISa/NQFZgxlTHBoE2ksJ11Q+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 23 Oct 2025 06:23:41 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:23:41 +0000
Message-ID: <460373be-e40a-497a-be46-bacfeb3cd60e@amd.com>
Date: Thu, 23 Oct 2025 11:53:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix pointer casts when reading dynamic
 region sizes
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Ellen Pan <yunru.pan@amd.com>
References: <20251022133425.245953-1-srinivasan.shanmugam@amd.com>
 <20251023053536.265550-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251023053536.265550-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e020a0f-5d79-4d8d-b508-08de11fcb5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXRYb0tMb0xSakJNd3hWY3NBeEZVTDZ2b2xzNHA5V0FwNDVadm9sSmVUdkQy?=
 =?utf-8?B?bU1uUko3VExYUm5waTNBOFVENEVMaTR2QVFwalYwMTdmN2JNMVFBSkxkUGh1?=
 =?utf-8?B?eDRaSE1oR0FBZU9scG1Ta08yTVRsemVRRzJqUk9icWM4UlFCSElmU3JCRXdR?=
 =?utf-8?B?ekkrUXNGdUYyNkQrUDFwVzJSTjlkK3FYbWtDRzBQT2wrWXRxQ3Jwc2hqanpG?=
 =?utf-8?B?WFRkazh4WGVjQ1l3aEEzekZBQ1pTcVI3bG9LRGN1RjQ0NjUwQmw2VGpzK2F0?=
 =?utf-8?B?ZWI4UXVnQTI3ZzQ4MnZ3S2dxMVdQTDBNMHFneUtiV1ZIYWEyaUUvM0dHZGov?=
 =?utf-8?B?aVVONXFMem9QQmtzMXRFTlJybDhSTllwaGZVekRQbmFTSldwSDgzSDJOTE81?=
 =?utf-8?B?ZDRoK2xmeFlOeW1SVmZvNmF5TzJWd0FFNnlVeEh2bEU1R3lpTkMwYXM0R1Z4?=
 =?utf-8?B?ZUxka1NTQ2xiY25TeEpwNndOVDJFQWJxbzFIdmpOSFNRRkRKYXg5SzNEeHVS?=
 =?utf-8?B?RXg5SWg4ZXNEa2VVRFprUnE2eEwyTjFsaURvMVRKbkNiVVdkbXVIRFFCc1Nk?=
 =?utf-8?B?QW5NSnFXSUNOYnRmdkVDTUJlRStNTHM1NFpTbHJpQ3NBbkZFOGViS2RkWGZl?=
 =?utf-8?B?THZzK1E0OXRraUN2RzBVRFMrUzRrZWxsWUdmMGVRMDE1SGNxRzk4bHM5UDNQ?=
 =?utf-8?B?bzU2bmQ1ekFtU25rK2NEbG1EUWc5bC9FWGpFZU8wRU9YRm5sSUozSGQxbGJ4?=
 =?utf-8?B?VUJ1WUI2S2NPbzJQazFqWlpER05zWUErb25IUUlhSU9QYXB2Z3FXTy8zVmdk?=
 =?utf-8?B?MkxmUC9JMUtnd0xqeHloTENmSWJNYldZTUF3dHhrdXV0aWFOQkkrWjg5cHRo?=
 =?utf-8?B?dVIrUG52WnpjYmdYeWw4YnFpWjB2Q2xoS05uMUE1SCs5TERaaHI2TkNGTkI3?=
 =?utf-8?B?NThSSkZsNjR3bUVRY1cwUi94Rm1jdHBvWnVoMklNY0RLSk5ZRkppSnMzemRo?=
 =?utf-8?B?cDRJNEpvV1EyYmswOHJyUk94TkdkV0oxaWZSMkRNMERpU3AyR0dtS2puMXJH?=
 =?utf-8?B?alNHR21BTCtwRVF0clA3TWZ1VzJXYkZOQzdFQ3JuSVhxUXJnbTdwODNRTVNw?=
 =?utf-8?B?SHVPWnZEbzhoY2NIT1hBaTJTVzJrZjBQdi9zbUE4N2RqMXpiUkNBNy93NjNw?=
 =?utf-8?B?dHRuem8yb1lrVi9QUW41S0N5bXpnQllmZjlwcTNKbW52a2JqN0JLZ3pqNGtO?=
 =?utf-8?B?NTY1ZkEzV1VocFFUZHZmamltYjN6QnJYVTZYMHlHV3JVTjYyUlJDSW9VdDNs?=
 =?utf-8?B?MTRzUVM5M2ZIUThaUmdnRlQzUUdCY0cwU1dnL0ZmSGU2ZFhSR0ZnaUFmZGtU?=
 =?utf-8?B?bXBUczQ2cjhrUmgzZEkrRUJzc21DazNER0FDeXIvaVBhVnRWZTM4Q2dwYlVS?=
 =?utf-8?B?bEJaQjFnR1J1THZ0OXRnR25wU29abTdEUFZNZHh5YUlrNzZVV2F3ZmphSXlF?=
 =?utf-8?B?aW5jZ2owRzZzaWNkSTBGdEtVNlA1aHRySjVSRlZRQWg4L2JvditkT2tQYkRk?=
 =?utf-8?B?V3crKzQweXhKWjB2K0QzWHhrQzZHQnZpSUN5eC9KSExSK2VPb1NIemhJM2RN?=
 =?utf-8?B?NjN2MFdsVG41K1lydFpNRk1ZazhuK3pwMU15ZHNkUXl6b3YwdGJXZGtjQUJq?=
 =?utf-8?B?VFlyY2lCSGdpUjJwSWllZUNvZCtxQWhvWThtdVpKcDJxMkVqQmxzQnFzM2g4?=
 =?utf-8?B?SG9TeWdkMHovZS84dDhOc1VaK1J1Z21DTkRPNThDZGR6c0FPemwxdklXK21T?=
 =?utf-8?B?dklQZmxYL2NveWF2R3FXZTl3RHRsU3VhQ1hZUUp2QWVJU29WZktqc0ViV0xm?=
 =?utf-8?B?ZlZNSzN6clNIS1RwQjJpSFpVRld0QThzTUNLeXFkdEVpbnliZGtURHBuWU1w?=
 =?utf-8?Q?BHTxQ6OcGw7UYavFK84M0pVrwML+Ec/B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJVM1VZUGJla2ZTUlBkMXpab3BUVGpOajQ5djhORXEra0drL1NZaUZoY09E?=
 =?utf-8?B?RllKMGV1SDBBUTNvK0p5dzZIZ3pWNUcrMCt4azBHUkVFdWdVdDQ3bG1sMXlz?=
 =?utf-8?B?UjQvcTVLQTA4YVNtRlA0YmlycldFU1VxN2s2NzZIaG9ZRE1pZmJpTzBiSmlY?=
 =?utf-8?B?TWFEQ2Y5cWtuNTc3cVlaYzRDeEpUMXVyanNkS2pOaHlpcW1NNFN6cnUxU1V4?=
 =?utf-8?B?QVpFTm9nYzduZnZrNEFYYlBtMkR1cjV2NVByR1VrbjRVTmRXYWYxa0Y4MjZv?=
 =?utf-8?B?UWRzbXk0UUo4OS96S01EWFRyazh0S0FNcG5aY2hoT3BKSTRDbFFhMURldEhk?=
 =?utf-8?B?QXk1VVRoakUrZElXVVhoWUhLN2NKNjE0dTkzR0hsM0pxcktrRVhrcGkrZzZF?=
 =?utf-8?B?S1RHK2NJWDNIaE5kYURkc00wd2F0NWpUakhxWEpPV2xDVHhNMklWMGxNS0Jh?=
 =?utf-8?B?ZXJWUlZ5ZUlpVmYrc0pHYTNaSTRKM1p6L3M3WVNKUG9GTjJTeXhUNGYzUDhs?=
 =?utf-8?B?K0Y1UFc3a2pTTnBQYkhaakk4SWdJVUpYcVdvRDh5c05KQmFCTUtlY2JlcE40?=
 =?utf-8?B?NXE1dmpLYm5ZYmF5L0x4WmQ5b29SNGdCbklGWDFZdERyR2ZrT3lzZ3liUSti?=
 =?utf-8?B?WG5YdmVMNjR6Z1ZrZFlDTE1XRElPWWZSdzIyTWdNWXV2Z204NTBTODA2VUJp?=
 =?utf-8?B?Zitwa3k1QzdCSXdWRmpPelZKNytOekthamw1TEJFcHJSeUk4UlR6dHlvWGc0?=
 =?utf-8?B?QTVIWE5vcEgyeGRDcXFLN1JyNVhBU1NJcitYMWRkRDc0Zzh4b2U5RUd0TzZl?=
 =?utf-8?B?LzFhZjVkMDNTajg3UklBbGQ1RVJ1SWFQazVRdno5QmVJZUFVNlE1VEJiTUFN?=
 =?utf-8?B?bHM5YUgrelcxelhWcEhRT0oyREtERE8xcm9vL0w1Zmd3OVBsajZiVFZCN2Zp?=
 =?utf-8?B?VkdXYi9IeENSQXdaVi9WSDAyTEJwUC9FM1J3Vk5sRzUrOFRSRGtqQ1JzQTlP?=
 =?utf-8?B?Y2tsNGJWbXlWcFZoUHVXb1lzWHlOOEZuS2JJSURIa0kzOG85YlIrOXRvYlRE?=
 =?utf-8?B?ZjVzM3JlUVRxeGE3MEhZNWtEaXBpaUZhbUNHSnFKN3Bpc1JZdGc0QXVscmVV?=
 =?utf-8?B?Wjk1dlJlNXp0WmlBQ2ZHVUFGaGJPU3d6NnV0ZWM3d05SYVNEU0ZzZklDVEZ0?=
 =?utf-8?B?MGVsTWtZdWMvRFNTT3lnK3BkZDk5aW5peHdjUnpBcEdKUWQ3UTFJNU9vRXpV?=
 =?utf-8?B?SHFCVm1lRDlod3o0V1hiNWdWMlJrdm1SS1VQZXJEb2NrcW15R3hwMXlNRjNK?=
 =?utf-8?B?N0grazI3cUExT0pKelFIZ01MS0wrUUhxbXY1V1BSbS9YTTQ1RGl3YVdNRkRa?=
 =?utf-8?B?Ui9PeENPZ2JCNytXckU5Nld0d29USWN1YU9vVXI4QW5yVUNvSEc0TUpJbGNG?=
 =?utf-8?B?T0Yra2J2UXNJZUgxL05Bd0RGNDNRZVhnOWJSUG15cDloS3dBMVBCbDhDWC81?=
 =?utf-8?B?a3hUVmRqeDBBM2E4Y3R5Y0lKMjE2cEVFcExkQkRSdUxNK3hJc2tLVnFuWVov?=
 =?utf-8?B?Qmdhd1QrZTBPYWJJUUFLckxRU1lNblUrVUFyTE81WmJ6Zk9IdWJDNHJBWitS?=
 =?utf-8?B?a2tGaWsrRGxkcG1HKzBaSHlRYWxhcWM1cysxMjJzUll6MnAwdEtQc01tNDls?=
 =?utf-8?B?c2xzaG9Pa0gwdy9WQjFCY1JhUEU2QVA1NEJtQVkwVDZUOE9VL0JnU1FVNGQv?=
 =?utf-8?B?WGFOQXkrelpoVmZBdEt3aUN1UDRadW9NVVNOZElKbjFFTEltUjQzWFlUKzRD?=
 =?utf-8?B?VjNONGYyYmpOcC9Zd2NxRnpaVWcycUxRYnByQ2hINmlpTGwycDBERHdVVVQy?=
 =?utf-8?B?cHVEZWNXaUFvWXYxVHlob1gzWTJQd1lNUHFaYnlIbmxWUFVtOXNsYStzcnIz?=
 =?utf-8?B?UU4vMVZrM1V1R3JoOENIaWtwN0g2Mlk1UTk1MERUcFRHbm90emo3V2tFdVNR?=
 =?utf-8?B?MkhNTnRDVE9MbEJuemI2cURLVnJrMG1HT1FQNStaNHJQZmxPQS85VTU5YnBM?=
 =?utf-8?B?UmlUNjdEbW9Sb2lldS9XM1o1TjBjWFFMS2M2anpkVllkalhnZVB6WmNuSTFB?=
 =?utf-8?Q?t2ZyU2l6OO6PUSn5VcYjxkOlw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e020a0f-5d79-4d8d-b508-08de11fcb5b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:23:41.4768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83M1WIPd1SiMbaZ9E6NcJTzvP+FnNIMJiRo5foaApIbgB1lWb4/GoMyl+321426K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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



On 10/23/2025 11:05 AM, Srinivasan Shanmugam wrote:
> The function amdgpu_virt_get_dynamic_data_info() writes a 64-bit size
> value.  In two places (amdgpu_bios.c and amdgpu_discovery.c), the code
> passed the address of a smaller variable by casting it to u64 *, which
> is unsafe.
> 
> This could make the function write more bytes than the smaller variable
> can hold, possibly overwriting nearby memory. Reported by static
> analysis tools.
> 
> v2: Dynamic region size comes from the host (SR-IOV setup) and is always
> fixed to 5 MB. (Lijo/Ellen)
> 
> 5 MB easily fits inside a 32-bit value, so using a 64-bit type is not
> needed. It also avoids extra type casts
> 
> Fixes: ae92010fb321 ("drm/amdgpu: Add logic for VF ipd and VF bios to init from dynamic crit_region offsets")
> Reported by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Ellen Pan <yunru.pan@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index db705bf723f1..35d04e69aec0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -103,7 +103,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>   {
>   	uint8_t __iomem *bios = NULL;
>   	resource_size_t vram_base;
> -	resource_size_t size = 256 * 1024; /* ??? */
> +	u32 size = 256U * 1024U; /* ??? */
>   
>   	if (!(adev->flags & AMD_IS_APU))
>   		if (amdgpu_device_need_post(adev))
> @@ -126,7 +126,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>   	 */
>   	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
>   		if (amdgpu_virt_get_dynamic_data_info(adev,
> -				AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, (uint64_t *)&size)) {
> +				AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, &size)) {
>   			amdgpu_bios_release(adev);
>   			return false;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index a7cb4665f485..fa2a22dfa048 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -311,7 +311,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>   			 */
>   			if (amdgpu_virt_get_dynamic_data_info(adev,
>   						AMD_SRIOV_MSG_IPD_TABLE_ID, binary,
> -						(uint64_t *)&adev->discovery.size)) {
> +						&adev->discovery.size)) {
>   				dev_err(adev->dev,
>   						"failed to read discovery info from dynamic critical region.");
>   				ret = -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 66e9cd103597..38cc446500d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1101,7 +1101,7 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
>   }
>   
>   int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
> -	int data_id, uint8_t *binary, uint64_t *size)
> +	int data_id, uint8_t *binary, u32 *size)
>   {
>   	uint32_t data_offset = 0;
>   	uint32_t data_size = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 2a13cc892a13..14d864be5800 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -443,7 +443,7 @@ void amdgpu_virt_init(struct amdgpu_device *adev);
>   
>   int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
>   int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
> -	int data_id, uint8_t *binary, uint64_t *size);
> +	int data_id, uint8_t *binary, u32 *size);
>   
>   bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>   int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);


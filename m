Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6D3CAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 13:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4A810E373;
	Thu, 11 Sep 2025 13:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y0d2oqkU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D412810E373
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 13:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=My5hDjed26LQ/P9m6vI2ZF1FGaDT+3d9P6i77mVfyqOObBisJnPddUbBgjrcIf5w0VJyv1g4qxpFJDwT87h4xig8up/D3HPUf/8RTXYiFuXnmItSgxhJdyLV78dOByjDOwWAjBAdsAi2by/ND+xp++GfWBw/STlZp8iC/piBEtDxzSbLyfaQhxKAdWUDM+OIu8KuR56EmHQvFsNi2OXNW3NhiTzcsPqfW3SK32kp6Hn5/rfPjdxydx9MmI/GIoY39La2G11E2S4NQCOtxqA1LjbtahG0oGAPImUmwI7z5ENd+zxSkgRIWv9EJQgLLTjVeMDOzwzgTkK+Nc77eY4q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cds81OSVYZAgP4wGAvi8z/Zl0scZ1xECULbzQqr3v34=;
 b=prEZGOmzTUIxlRxM+5qNqg3DINTmn7ENYuXs2HoLtgAG6ab3PJHLoMuBrF5VSreOGYXRBoZkklVm8yihi1aPo1gtE9mUYepqqAHLVexRCzEouAHhMhuok9684ey5+2kM3AHBZ5seiFwCcrQMLjIlPJUcf6jVtd7AumNvSX8L1Yt9QDlIfj7Q2pEhLesDdkD6pycyoeXlMW4YVfBoVy/JW9J/t8HI1lz62gL7VWuwybzRT3ia5PlJhFLJYYbf5JbaQNqzskYLdPT3UC741JQPYkBYvuiEpa9dtcYoeoP9zibJ7Wdt98U/ecsMo/Og6dAMkbY59InUV6V6rXWHHD/m+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cds81OSVYZAgP4wGAvi8z/Zl0scZ1xECULbzQqr3v34=;
 b=Y0d2oqkUEjEYl8NppS5Q8JUyKG/VmSvGsrIJo5N1LKj+WgAqj2AitIuAS4vc5uEzjDH+QYfz3rMmLNHXNPPM1nWgdbHvhF2N+NTf6PjPTXeQnQseXjzLnBdOkyKJotWxVVnRXP7L9kPdB6t2XweWamwb+TaJ+duPNCwp5dFHR/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 13:47:46 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 13:47:46 +0000
Message-ID: <9a130bee-5605-4c8d-8995-c4bbdf7feb05@amd.com>
Date: Thu, 11 Sep 2025 19:17:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: revert to old status lock handling v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexdeucher@gmail.com, Sunil.Khatri@amd.com, Philip.Yang@amd.com,
 Prike.Liang@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250911120950.3343-1-christian.koenig@amd.com>
 <20250911120950.3343-4-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250911120950.3343-4-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH3PR12MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8daa70-7748-4870-7bc1-08ddf139c9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qk9ibWxRSEVGVm1YUzFtNkJrS29ySWpOUVJOTUxCQmI0VWZzSEl5SS9jMWo2?=
 =?utf-8?B?VlJtR1pFMWoxeUt5M1VVTks2c2NYS2dadXR4QktpdnBOZXgvQTB4bnhxM2tl?=
 =?utf-8?B?bDZPSFA2SnRqdllwc0dvdjFFQTlidnBuSXdNNHQ3SEkrOXM2b1B3NW1uSHhk?=
 =?utf-8?B?VFVQYVJiVENFUWZkOG9NRXhiSGFSWE1PNllUL1Q4cUUrUVdUM3NyaURjTTMv?=
 =?utf-8?B?RlVPSlBSaVJ6Q0JLVGVITHF6U3FPeWtmNTNiaXQzNjMvTXdvUlFZS3Zxd290?=
 =?utf-8?B?VG9WN29sTDV3MEdVZ1ZzVTB2bGloVStEaUxTUnNtOGhYY3BTcVhzNTAzaEcw?=
 =?utf-8?B?VkxQaVlWZmZzQU9pd1VMN05Dd2MzMFcvQjRPOVdLdE1LNnBJUEFQNGJqcGRY?=
 =?utf-8?B?ZFFNdFB6REMxTk03OFhta01MOUVYQTJQQjFwY0xDUlE4NE1XTWhHTk1zYUhq?=
 =?utf-8?B?RysyVlNURkdwZ2VKYldscHNIdWl6bFVibnlwMHlMNmh3c2h2cnRmOThMbUsr?=
 =?utf-8?B?T2k1R3pEcTBiUDdIU2FkdTZGZUs4V2dScnU1Q3c1K0dlajg5bWVVUDZzbXdG?=
 =?utf-8?B?QmJWak82WDJwSDNTVm5iMTJVb3pVZ0dQdlBlUGVvbXRuU0hNODVtd3UwUkJj?=
 =?utf-8?B?eHJmMVcveDBTUG1Sa3VZaSs5Slc1NytvSDAzT1JRV3hWbFhpRVlSWjVFdWFY?=
 =?utf-8?B?blBEZ3dwaSsxNnRVcy9Od2dNRVo0amozb0Iwbm9xQnRvVzFDOFcvWFMraWhw?=
 =?utf-8?B?NWZQYmlSeGc0NkJvbm90Y2ZIMFlQeSt2QzBzRHJDZkY1NEVmNGhVM0VxTitR?=
 =?utf-8?B?bzQzOSsxdEFnWjZQYzQ4dEVaVlpxeEU5bGFwWDF4TFhZNlcvb1RqVGduTk52?=
 =?utf-8?B?OFFNTFVvd3hKNlQvRU00RFdWWkhML2xBZ2JGZEw1dnBuS0trdmxiWENTZm5O?=
 =?utf-8?B?SHhySHBibXpZand5TVBEaHoyemlwZ3ZJanUyVFNBT1lyZ09qUzdqeXVUdDEz?=
 =?utf-8?B?Yk9nWjc3UlJHWGN0a0srRnYvZUNxK2k1UFJYaHdPNVAxUGU2QjNFMitDOXFv?=
 =?utf-8?B?LzhpQ2pyR0VOdHlBQ20yUk1OSCtZSW1xaUJEQy9aS3YzSWU1cGxRcFJYUGsx?=
 =?utf-8?B?S0p2cTU3dnB4WUIwZnhTek5FaVVuRlZmOG1KSUhiV3U1dE9sd05OZkQrdHJM?=
 =?utf-8?B?NHcvaElZWEFLbFdqWEQvRFpYR01kS1UwWXVXMlZFaU5vMzl3RUUxbVhyMUFy?=
 =?utf-8?B?aDdjeXVXVTBTSDZiNElNSGt4Z3lVTWFqUmZrMzBxcmNqNDY2dWh3elI4dzU2?=
 =?utf-8?B?SmZ4a2h4RGhJZEl2Qms0ZXU2dFR5bktTVEw3VDN2RC9nVFNJUTBPaWhqRmxS?=
 =?utf-8?B?OXlZSzVXVjFTYnBtc0l4cVJqTnpIWm9oTnhDeXRPRC8rSEpGeVl0cXFYMG5X?=
 =?utf-8?B?bk8ranBaUUR0MEpkc3kxbzM5ZFMzOGYrY1FrWnlhVXhDemppWFV0VTZBZXNC?=
 =?utf-8?B?dURFRk5ESnp4OHkrczE5ZGQ5cXJOS3hGRTRMbGUzSnJlakxoWkdnUmNxUkJW?=
 =?utf-8?B?Z2JHZ3ZvNkxTUlpuTER6dXVXVnV5Rm5OQmJRaTFCRE5zZUtlQUJwLzlhb05I?=
 =?utf-8?B?N0ZqK3N0UDZZWWJ6eTJiTU0vZ0FXVklpTTNCcEkvOXRqb1RWSjN3L0FNaWkx?=
 =?utf-8?B?dUl3VWsySmU2cG5RKzJEN2N0MXluY3YwK242c0hNT3VlRE5OT0V4NlF3bXJz?=
 =?utf-8?B?RHhHR0lZeUVPUEk3OGw0Tk14cTFnVXFRTTBkaWR6aW1zMVAwQ2dVeENFY0po?=
 =?utf-8?B?TSs0c0grRVptTFFJWW5nRFBJSWkwd1RkVmV6eU5yaG9idHhDQmg4ZlV5MGI2?=
 =?utf-8?B?a2Y4Q2FiRnAveE5kWWxrMTNrNGtTUkxMbjdrUm5WclZISVRKYm5qOElyZk1B?=
 =?utf-8?Q?4L5oiPrsr6I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFE5bEJDVDZURzFqWTJad0laRVIzQTdoOC9mRGtWZ0Z6QTc3UU1lTTZldzNv?=
 =?utf-8?B?blBLNGt3Y294a2R1WHhVUm93NkNuZ2hLSDZZa1owOTIxZmdZa25VdVdlSnBC?=
 =?utf-8?B?WUdrUnkydTZ6eS91RUVZYzNLeDAxek13QVI1WTVtTTljemdMQlRRMFZBNTFL?=
 =?utf-8?B?NEUvbWdubjZ6WmtYUWRjdmJZREkySlMvaGs2K0NVb2x2dDhaWU5haGNwVG9k?=
 =?utf-8?B?MTVXK21MRDI0YnFDSlNEOEx6MUZNZnlNdk9NWEU0bnN0SXc1UVhGNWsvTzJ6?=
 =?utf-8?B?SXNrNkNlV0tjckdsb2FMUnFHc2JuRlZ3YitNWmV4bllFNVdJL2hXb1E4M0VQ?=
 =?utf-8?B?NzZMZ0tXOUp0K3pLWTRsd1hBeHV6NjZDL0JyVFBESjlzWGlzWTdqRTdQem9z?=
 =?utf-8?B?SkhwVVdndUpsaWovMmdrNW1UVlpQamIvSzZJdjRkeUwrdTRwOXVrVjVHZHRk?=
 =?utf-8?B?czAxTzZDd2J1a1JSY0dhdWYyTjFDaVYxRmJORGQrd0NhMUx6M1g2TzdGeVNU?=
 =?utf-8?B?aTNnNDBCazZwYTJ2OXp2cWZlWXQybE5Xb0cvZEtYQXlnVDdOekdITnQzM3NG?=
 =?utf-8?B?eG91c2daVmp1anFaWFlydkU2OEpraC81Tm5NTGtLVXZBSUpKV1JZRjBxRjdS?=
 =?utf-8?B?bjVIeW1tSWVGUC9uNXRsV1VlRE5RVXFrVTFzY2RTUDNGVmxTN1ZNd1hYR2J5?=
 =?utf-8?B?Nk5vYXRQV3d2VnZsMUNVWFJhajZ4UjRIZjhuS3I5ZG9vQlZVVVBBSEpVeHVy?=
 =?utf-8?B?T3R6dytxQXBJcVhjRVNhTkNhWVdzVnhBeGk1ak5CWU1ENkxKanM3Q25pVDdv?=
 =?utf-8?B?a1NpSEtlenhLTFRaNUIyaVJpTXFTQWdWNFUxU2JZVEhpT0hoYlRFL05RYlFF?=
 =?utf-8?B?Z3I5UDk1WDV3S1hleFhHKzNDbnJYVWVzK3FoY1VIUG1EcW41dng0TWIrWFdx?=
 =?utf-8?B?OXRKNS9ZUUJybGVqTHdvYXhYMWt5VnFYU3czdjVtenI0TlM2bEdPTG53YUpX?=
 =?utf-8?B?RURvQ0hBM1Q0SG1GOFZMaitPS0x0Y28yT3VHUkdhZGx3RTM3c015NW5TUDZP?=
 =?utf-8?B?UGg4TE9SUy9HYi9RTFZsMFJ2SFBBTnc1ODF6QmxHQXBCL1UvVmpuNGZyamRU?=
 =?utf-8?B?bFpTQlBZUGkyTDBCZm14SkQzK0VGL2JWV3BTRnJ6dEw5MVl2cGVWTHVFczZs?=
 =?utf-8?B?ekJoVHVGbm9Zc1ZXbndoYnVlb0twK1B3RFB6OXZJZlFlU3hIWWJkV0JnanZm?=
 =?utf-8?B?TWxKb0tHQy8vNERsRW9XZmoySmNaaHpNYWNSUE5LcVNWd3dYMW5sYlpvNldG?=
 =?utf-8?B?dkFGQS9qY0RsSDl2OCsydFNmQkhqZXN1Mk5EU0hzQ1R2RXMvVHI2RmNNcWQ5?=
 =?utf-8?B?YzllaUZpbDFHZE10YnhkRDNFcnNGSG44SVpqRDNtTndmRWRRejlsNEdSb0gr?=
 =?utf-8?B?M3ZzbjczcUxpMEI2Y0c5WUlJcXB2bWZzK08vT21MekpZclRNOHNSWjFQVW5a?=
 =?utf-8?B?ekNoTGUrOVM1dU80dW5sYjl0azgvbEg0cnhQZFhQLzBHV2VvVldYdTc5RUI2?=
 =?utf-8?B?emJ4dEVzUGE2SDgwRXY4d0VpZm4rRUg4c2RRVFV0Y2QvakRXeGpsUHIzRyt0?=
 =?utf-8?B?ZTJCeWRxa25BaFQrNEs2S2h1TWlwVDM1TE91eE1jSldoaHdTS2lCQWVIOTht?=
 =?utf-8?B?VGppckFqUTd1cTRVWkwyZThtRVByaEdwU1N3aENQdUZDVTdGU1dhc3pIK202?=
 =?utf-8?B?RWZ4Z3F0eWIrVU1lVmptcHBIMlkwVS81RG9acTh5bDNOeFlkYVNHUURqa2xt?=
 =?utf-8?B?N0dna1hkWHZVbHBSTGhXN1RwcTk4ODhjL1k2bmRZTGtYRGpTN3hIRXZkRzFF?=
 =?utf-8?B?RHVPR2xKL1RSRmRXenNFeGZpanMwNE1UZ3RWNDNUYWVEN3NxUC9LQ2xFQXlV?=
 =?utf-8?B?WlJLMElaZWN2L1pkUGExL3QvbDBkQTRJYS93U3ArVnViK01Xa24zaXdhTEdu?=
 =?utf-8?B?THZEMmhtaUViUUEzVnhCNGtzakJoY0NWVUtoQ0tpa01yWkk1dlBqZlJLVGRx?=
 =?utf-8?B?dmFBcm1nTmdsbEtGelgyL1d0NnBjNzluSzZabXRDTkl6Q01Ba1d5ekVFcG5r?=
 =?utf-8?Q?q2UwIicYamRkoeLvOD9K+BKI0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8daa70-7748-4870-7bc1-08ddf139c9ad
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 13:47:46.0257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afqZ7TF32ze6lY97uXn1ojJAA6Zcq2VB4VH8YDvnGJTP6hw1vrLqPKzZUAREBH1LRCpCAHK3+lDzK+zYfCqRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401
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

Acked-by: Sunil Khatri <sunil.khatri@amd.com>

On 9/11/2025 5:39 PM, Christian König wrote:
> It turned out that protecting the status of each bo_va with a
> spinlock was just hiding problems instead of solving them.
>
> Revert the whole approach, add a separate stats_lock and lockdep
> assertions that the correct reservation lock is held all over the place.
>
> This not only allows for better checks if a state transition is properly
> protected by a lock, but also switching back to using list macros to
> iterate over the state of lists protected by the dma_resv lock of the
> root PD.
>
> v2: re-add missing check
> v3: split into two patches
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 168 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  15 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>   4 files changed, 93 insertions(+), 102 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0ccbd3c5d88d..428f5e8f1cfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -679,12 +679,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	while (!list_empty(&vm->invalidated)) {
>   		bo_va = list_first_entry(&vm->invalidated,
>   					 struct amdgpu_bo_va,
>   					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->invalidated_lock);
>   
>   		bo = bo_va->base.bo;
>   		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> @@ -701,9 +701,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   		if (ret)
>   			return ret;
>   
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->invalidated_lock);
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index d0c95fb0ef81..fc36d61567d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -127,6 +127,17 @@ struct amdgpu_vm_tlb_seq_struct {
>   	struct dma_fence_cb cb;
>   };
>   
> +/**
> + * amdgpu_vm_assert_locked - check if VM is correctly locked
> + * @vm: the VM which schould be tested
> + *
> + * Asserts that the VM root PD is locked.
> + */
> +static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
> +{
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +}
> +
>   /**
>    * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
>    *
> @@ -143,6 +154,8 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   {
>   	int r;
>   
> +	amdgpu_vm_assert_locked(vm);
> +
>   	if (vm->pasid == pasid)
>   		return 0;
>   
> @@ -181,12 +194,11 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>   	struct amdgpu_bo *bo = vm_bo->bo;
>   
>   	vm_bo->moved = true;
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm);
>   	if (bo->tbo.type == ttm_bo_type_kernel)
>   		list_move(&vm_bo->vm_status, &vm->evicted);
>   	else
>   		list_move_tail(&vm_bo->vm_status, &vm->evicted);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   /**
>    * amdgpu_vm_bo_moved - vm_bo is moved
> @@ -198,9 +210,8 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -213,9 +224,8 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   	vm_bo->moved = false;
>   }
>   
> @@ -229,9 +239,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	spin_lock(&vm_bo->vm->invalidated_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -	spin_unlock(&vm_bo->vm->status_lock);
> +	spin_unlock(&vm_bo->vm->invalidated_lock);
>   }
>   
>   /**
> @@ -244,10 +254,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>   {
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>   	vm_bo->moved = true;
> -	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -260,13 +269,11 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	if (vm_bo->bo->parent) {
> -		spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
> +	if (vm_bo->bo->parent)
>   		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -		spin_unlock(&vm_bo->vm->status_lock);
> -	} else {
> +	else
>   		amdgpu_vm_bo_idle(vm_bo);
> -	}
>   }
>   
>   /**
> @@ -279,9 +286,8 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -295,10 +301,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   {
>   	struct amdgpu_vm_bo_base *vm_bo, *tmp;
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	list_splice_init(&vm->done, &vm->invalidated);
>   	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
>   		vm_bo->moved = true;
> +	spin_unlock(&vm->invalidated_lock);
> +
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>   	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>   		struct amdgpu_bo *bo = vm_bo->bo;
>   
> @@ -308,14 +317,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   		else if (bo->parent)
>   			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
>   	}
> -	spin_unlock(&vm->status_lock);
>   }
>   
>   /**
>    * amdgpu_vm_update_shared - helper to update shared memory stat
>    * @base: base structure for tracking BO usage in a VM
>    *
> - * Takes the vm status_lock and updates the shared memory stat. If the basic
> + * Takes the vm stats_lock and updates the shared memory stat. If the basic
>    * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be called
>    * as well.
>    */
> @@ -327,7 +335,8 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>   	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
>   	bool shared;
>   
> -	spin_lock(&vm->status_lock);
> +	dma_resv_assert_held(bo->tbo.base.resv);
> +	spin_lock(&vm->stats_lock);
>   	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>   	if (base->shared != shared) {
>   		base->shared = shared;
> @@ -339,7 +348,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>   			vm->stats[bo_memtype].drm.private += size;
>   		}
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   }
>   
>   /**
> @@ -364,11 +373,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
>    *        be bo->tbo.resource
>    * @sign: if we should add (+1) or subtract (-1) from the stat
>    *
> - * Caller need to have the vm status_lock held. Useful for when multiple update
> + * Caller need to have the vm stats_lock held. Useful for when multiple update
>    * need to happen at the same time.
>    */
>   static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
> -			    struct ttm_resource *res, int sign)
> +					  struct ttm_resource *res, int sign)
>   {
>   	struct amdgpu_vm *vm = base->vm;
>   	struct amdgpu_bo *bo = base->bo;
> @@ -392,7 +401,8 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
>   		 */
>   		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>   			vm->stats[res_memtype].drm.purgeable += size;
> -		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
> +		if (!(bo->preferred_domains &
> +		      amdgpu_mem_type_to_domain(res_memtype)))
>   			vm->stats[bo_memtype].evicted += size;
>   	}
>   }
> @@ -411,9 +421,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
>   {
>   	struct amdgpu_vm *vm = base->vm;
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	amdgpu_vm_update_stats_locked(base, res, sign);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   }
>   
>   /**
> @@ -439,10 +449,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	base->next = bo->vm_bo;
>   	bo->vm_bo = base;
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>   	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   
>   	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>   		return;
> @@ -500,10 +510,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
>   	int ret;
>   
>   	/* We can only trust prev->next while holding the lock */
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	while (!list_is_head(prev->next, &vm->done)) {
>   		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->invalidated_lock);
>   
>   		bo = bo_va->base.bo;
>   		if (bo) {
> @@ -511,10 +521,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
>   			if (unlikely(ret))
>   				return ret;
>   		}
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->invalidated_lock);
>   		prev = prev->next;
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	return 0;
>   }
> @@ -610,7 +620,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       void *param)
>   {
>   	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
> -	struct amdgpu_vm_bo_base *bo_base;
> +	struct amdgpu_vm_bo_base *bo_base, *tmp;
>   	struct amdgpu_bo *bo;
>   	int r;
>   
> @@ -623,13 +633,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			return r;
>   	}
>   
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->evicted)) {
> -		bo_base = list_first_entry(&vm->evicted,
> -					   struct amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
> -
> +	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
>   		bo = bo_base->bo;
>   
>   		r = validate(param, bo);
> @@ -642,26 +646,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
>   			amdgpu_vm_bo_relocated(bo_base);
>   		}
> -		spin_lock(&vm->status_lock);
>   	}
> -	while (ticket && !list_empty(&vm->evicted_user)) {
> -		bo_base = list_first_entry(&vm->evicted_user,
> -					   struct amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
>   
> -		bo = bo_base->bo;
> -		dma_resv_assert_held(bo->tbo.base.resv);
> -
> -		r = validate(param, bo);
> -		if (r)
> -			return r;
> +	if (ticket) {
> +		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
> +					 vm_status) {
> +			bo = bo_base->bo;
> +			dma_resv_assert_held(bo->tbo.base.resv);
>   
> -		amdgpu_vm_bo_invalidated(bo_base);
> +			r = validate(param, bo);
> +			if (r)
> +				return r;
>   
> -		spin_lock(&vm->status_lock);
> +			amdgpu_vm_bo_invalidated(bo_base);
> +		}
>   	}
> -	spin_unlock(&vm->status_lock);
>   
>   	amdgpu_vm_eviction_lock(vm);
>   	vm->evicting = false;
> @@ -684,13 +683,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   {
>   	bool ret;
>   
> +	amdgpu_vm_assert_locked(vm);
> +
>   	amdgpu_vm_eviction_lock(vm);
>   	ret = !vm->evicting;
>   	amdgpu_vm_eviction_unlock(vm);
>   
> -	spin_lock(&vm->status_lock);
>   	ret &= list_empty(&vm->evicted);
> -	spin_unlock(&vm->status_lock);
>   
>   	spin_lock(&vm->immediate.lock);
>   	ret &= !vm->immediate.stopped;
> @@ -981,16 +980,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate)
>   {
>   	struct amdgpu_vm_update_params params;
> -	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_vm_bo_base *entry, *tmp;
>   	bool flush_tlb_needed = false;
> -	LIST_HEAD(relocated);
>   	int r, idx;
>   
> -	spin_lock(&vm->status_lock);
> -	list_splice_init(&vm->relocated, &relocated);
> -	spin_unlock(&vm->status_lock);
> +	amdgpu_vm_assert_locked(vm);
>   
> -	if (list_empty(&relocated))
> +	if (list_empty(&vm->relocated))
>   		return 0;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -1005,7 +1001,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	list_for_each_entry(entry, &relocated, vm_status) {
> +	list_for_each_entry(entry, &vm->relocated, vm_status) {
>   		/* vm_flush_needed after updating moved PDEs */
>   		flush_tlb_needed |= entry->moved;
>   
> @@ -1021,9 +1017,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (flush_tlb_needed)
>   		atomic64_inc(&vm->tlb_seq);
>   
> -	while (!list_empty(&relocated)) {
> -		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
> -					 vm_status);
> +	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
>   		amdgpu_vm_bo_idle(entry);
>   	}
>   
> @@ -1249,9 +1243,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>   {
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   }
>   
>   /**
> @@ -1618,29 +1612,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   			   struct amdgpu_vm *vm,
>   			   struct ww_acquire_ctx *ticket)
>   {
> -	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo_va *bo_va, *tmp;
>   	struct dma_resv *resv;
>   	bool clear, unlock;
>   	int r;
>   
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->moved)) {
> -		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
> -					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> -
> +	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
>   		/* Per VM BOs never need to bo cleared in the page tables */
>   		r = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (r)
>   			return r;
> -		spin_lock(&vm->status_lock);
>   	}
>   
> +	spin_lock(&vm->invalidated_lock);
>   	while (!list_empty(&vm->invalidated)) {
>   		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
>   					 base.vm_status);
>   		resv = bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->invalidated_lock);
>   
>   		/* Try to reserve the BO to avoid clearing its ptes */
>   		if (!adev->debug_vm && dma_resv_trylock(resv)) {
> @@ -1672,9 +1661,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>   			amdgpu_vm_bo_evicted_user(&bo_va->base);
>   
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->invalidated_lock);
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	return 0;
>   }
> @@ -2203,9 +2192,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	list_del(&bo_va->base.vm_status);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>   		list_del(&mapping->list);
> @@ -2313,10 +2302,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>   		struct amdgpu_vm *vm = bo_base->vm;
>   
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->stats_lock);
>   		amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
>   		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->stats_lock);
>   	}
>   
>   	amdgpu_vm_bo_invalidate(bo, evicted);
> @@ -2583,11 +2572,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	INIT_LIST_HEAD(&vm->relocated);
>   	INIT_LIST_HEAD(&vm->moved);
>   	INIT_LIST_HEAD(&vm->idle);
> +	spin_lock_init(&vm->invalidated_lock);
>   	INIT_LIST_HEAD(&vm->invalidated);
> -	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
>   	INIT_KFIFO(vm->faults);
> +	spin_lock_init(&vm->stats_lock);
>   
>   	r = amdgpu_vm_init_entities(adev, vm);
>   	if (r)
> @@ -3052,7 +3042,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   	unsigned int total_done_objs = 0;
>   	unsigned int id = 0;
>   
> -	spin_lock(&vm->status_lock);
> +	amdgpu_vm_assert_locked(vm);
> +
>   	seq_puts(m, "\tIdle BOs:\n");
>   	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>   		if (!bo_va->base.bo)
> @@ -3090,11 +3081,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   	id = 0;
>   
>   	seq_puts(m, "\tInvalidated BOs:\n");
> +	spin_lock(&vm->invalidated_lock);
>   	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
>   		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
>   	}
> +	spin_unlock(&vm->invalidated_lock);
>   	total_invalidated_objs = id;
>   	id = 0;
>   
> @@ -3104,7 +3097,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   			continue;
>   		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>   	}
> -	spin_unlock(&vm->status_lock);
>   	total_done_objs = id;
>   
>   	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 74e61e45778e..829b400cb8c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
>   	/* protected by bo being reserved */
>   	struct amdgpu_vm_bo_base	*next;
>   
> -	/* protected by vm status_lock */
> +	/* protected by vm reservation and invalidated_lock */
>   	struct list_head		vm_status;
>   
>   	/* if the bo is counted as shared in mem stats
> -	 * protected by vm status_lock */
> +	 * protected by vm BO being reserved */
>   	bool				shared;
>   
>   	/* protected by the BO being reserved */
> @@ -343,10 +343,8 @@ struct amdgpu_vm {
>   	bool			evicting;
>   	unsigned int		saved_flags;
>   
> -	/* Lock to protect vm_bo add/del/move on all lists of vm */
> -	spinlock_t		status_lock;
> -
> -	/* Memory statistics for this vm, protected by status_lock */
> +	/* Memory statistics for this vm, protected by stats_lock */
> +	spinlock_t		stats_lock;
>   	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>   
>   	/*
> @@ -354,6 +352,8 @@ struct amdgpu_vm {
>   	 * PDs, PTs or per VM BOs. The state transits are:
>   	 *
>   	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
> +	 *
> +	 * Lists are protected by the root PD dma_resv lock.
>   	 */
>   
>   	/* Per-VM and PT BOs who needs a validation */
> @@ -374,7 +374,10 @@ struct amdgpu_vm {
>   	 * state transits are:
>   	 *
>   	 * evicted_user or invalidated -> done
> +	 *
> +	 * Lists are protected by the invalidated_lock.
>   	 */
> +	spinlock_t		invalidated_lock;
>   
>   	/* BOs for user mode queues that need a validation */
>   	struct list_head	evicted_user;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 30022123b0bf..f57c48b74274 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -541,9 +541,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	entry->bo->vm_bo = NULL;
>   	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>   
> -	spin_lock(&entry->vm->status_lock);
>   	list_del(&entry->vm_status);
> -	spin_unlock(&entry->vm->status_lock);
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> @@ -587,7 +585,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>   	struct amdgpu_vm_pt_cursor seek;
>   	struct amdgpu_vm_bo_base *entry;
>   
> -	spin_lock(&params->vm->status_lock);
>   	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
>   		if (entry && entry->bo)
>   			list_move(&entry->vm_status, &params->tlb_flush_waitlist);
> @@ -595,7 +592,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>   
>   	/* enter start node now */
>   	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
> -	spin_unlock(&params->vm->status_lock);
>   }
>   
>   /**

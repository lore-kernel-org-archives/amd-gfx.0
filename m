Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BF2C3ABBC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 12:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD1110E27E;
	Fri,  9 May 2025 12:25:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JwyMqpbH";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD94710E120
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 12:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToBQoWOm+gSeS3O/+ZYOr7oLwZOKMom/+47tH280zUJZaPPLW+ZJsc6JTQiSAdo/Laix6kNB0f7s7Gvhp3se2pPmK8N7Wx4TRbvK9UQoSqsYnKz2ZHGclyOTkfkuhzz8dktxclaoWMNSlxlQjJLilE71jDRFDaFSlrV9wQ8iBFSeN6i4AVqDPVZnUJNIgnPYFrD7IALAQU7R+s5UgXJ0agyMz+5dMJcbcsfKPBHHuzvlMSvBcPg6Dw0uImeUH2hJVGMfItnuMJcrbxzmP59wQa/PZXAWZbwi1Q/V5pRjLLApfDaw9xMGPZMwVEzCe4cbCO6Z9mVRuXGhPMggI/isTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz0oZCALh0cLgOAadutNCtuPrVHwO7XAa9stu5R6t58=;
 b=XCIdJ5Ksbu7xWJKT6YogBtYog3IqypvFwAi1Lt6ChB1PH5YUuhmC4edyWYOMApkQql9+EStwZghaql2XYawAFtEXdD9eEvCD+E7ApyTCXILFKbZsUoTuYGAxKoBzROlRsgOIMK5MaxbUfHkBcWsjvwkVe9Lo0+sPyK+jp3EMCDKL8oglHoVKUQ4kFJUzwtJogsH0z7ttNfJWHJ5Gd+QxGDnL9ODdpzIJaDLLibW/tl1S+kov91TSrYn5bTNDliXUpOhn4KQ5KfLvNtvqi0C81pHSzLiudixd5vS+VKr1SyYzoze6d42YSFVPd3ga3OwZf/yw7mVi9+uoVjKg9vwKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz0oZCALh0cLgOAadutNCtuPrVHwO7XAa9stu5R6t58=;
 b=JwyMqpbHuOtUQSw79VQYvJxEJ1O3n5ImUu1RJhNtHTlBOp9OUD9od2/f3KDzeV+GtC2pjFKPJWwnibwv47+Kcgc6q5+PSfOdOATp+I30h5piEcwFRFY77KUzBV9J8t6wTFZcvfAAegpA+0ytSR9amc+ZGFTG4KzZ4EPLFrvHZIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 9 May
 2025 12:25:34 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%5]) with mapi id 15.20.8699.026; Fri, 9 May 2025
 12:25:34 +0000
Content-Type: multipart/alternative;
 boundary="------------QqfowkRukRAdoXOJf438EclV"
Message-ID: <ccf98d44-512a-448b-bda6-78a444c4c93b@amd.com>
Date: Fri, 9 May 2025 08:25:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: improve performance with XNACK enable
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
References: <20250508144651.16745-1-James.Zhu@amd.com>
 <e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com>
 <cf8cb7d6-44a1-4732-a411-1caa7206b4f8@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <cf8cb7d6-44a1-4732-a411-1caa7206b4f8@amd.com>
X-ClientProxiedBy: YQBPR0101CA0322.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::24) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: eaec5f31-a6d1-4181-1fd2-08dd8ef498aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0RBUitBeWNHZkxPdHFSTG51SEt1MGJnWHc0T0FsV01BdXdzNmhlTmVFK1p0?=
 =?utf-8?B?RkE3MzBibWRyK3BqNEYvS2VhMkM3NExobDNEV1VaQ1Z5bER0SkhleXowUVAy?=
 =?utf-8?B?Z2RiZkZOK3o3UzVRN2FoWUV4enZjTVJXR2ZnUCs0cUdSa3lER1dCaVFzZTF1?=
 =?utf-8?B?NGpTSUZzbVdkbk5jZmk4akt6UXVxT3Znd252U0RQZXdqUG80M1F0bWxrWGU0?=
 =?utf-8?B?MzVGSE1VM29Ld3QrZTlqeDZiUTY1S1Q1bGlJQi9iZTJsSVhQbUlOQ3lrVVRB?=
 =?utf-8?B?RUdpM0NMbmp1RE5nelZsTWVhQ2U5dkF5T3ZRdWcwaE5tbjYrREc1Rzl5NGJZ?=
 =?utf-8?B?Wi93bHZaSkdBVmczQjZDZ2JLdG83OVFpTURTR3BueVNpUmpTWGNxNHFycTNR?=
 =?utf-8?B?L0p6MEh4UHR1d0t3YmVBKzlGdXErRXFYRUtmK0lWb3h0d0hqUmM4anJTUzRy?=
 =?utf-8?B?YTJTYXJ0RmpEc1gxRUI0U0p2TTNQcVFaTUJMaC85MXl0Y3hPNHdHZnNNNzkw?=
 =?utf-8?B?RGJrMVVXZVBqbTNYN0pqeDNsRWRPeTJ5TnRxblcrV0dGaXdvZExWQjRRbTZr?=
 =?utf-8?B?dFFPYlpOZVNzL1ZHS25sSG5WVW5IVGwwcHdUU0F1aWtZd3VvR2FFNGhyc2Fi?=
 =?utf-8?B?b2Y4ZWQrUGtTYWhhVXNqMGlTbmNjd0YxbDUxdzQyME54T2RTQUw1NnM1N25K?=
 =?utf-8?B?RklGdkNDN3UzQlVuM0YyWUhobktMYUZCRlhUNXRLZjh0dG5RV2R2emcwelhY?=
 =?utf-8?B?ZHQ1Wjk3dXBtU3h2bVRhYnRidjZ5VVpCekdzTW9oR01QZ0J1ZHI2d0VNREZW?=
 =?utf-8?B?R3RFZ3lsSm8zc3gwOXhNN3FjQ3ptQlZiZCsvK0I1OVFNZzNXK0w3anArc3dN?=
 =?utf-8?B?MlU5NlcyOXJoMDZMOGpaT3l5NDhoYjBhbUZnRVkxRktYTHN5UHhEYUpHTUQ5?=
 =?utf-8?B?eExaQmlrWlFhRzhSMUZISU13MGJYMXRtTG1mZUl4bHp4MFlzVGoyU0h6eVNz?=
 =?utf-8?B?OFp4OEwvc08ySHExemxZcUhacjU2R0U2M1NjSWEzSXRBaEFTRXhFcXpyTzRo?=
 =?utf-8?B?UHdHL05RcldscXFJaEtYSTJIQkMxc3c2TDJOOVBKN0ZiK0R0UEpEdmpUbUFo?=
 =?utf-8?B?ZHV4RWRBNzZGQ2ZnTWwrS1o2S1E5VEo3ZDhXWkMyeHN2Y1g1MEhzbWdEQVF1?=
 =?utf-8?B?cjFyV0ZTNFQzWUErL2ZRNlpXS2ZzRDB2SWR5ZnhpRWEzVzBjbXJMRVBZem5w?=
 =?utf-8?B?Mld6dktoc3JlSjVZVVFKaksrRm5ObVRYSkNObFQrNzVkVzZzTm80WVoydmtG?=
 =?utf-8?B?S3BRRjRZNncyRUx0ZHAwWkpzSlBvWHYxcTFWWXBXTzFmZjdPTkNoNFprNHdZ?=
 =?utf-8?B?SDd0Q0dsRGV0UnhLeFlCcUxsK3RoMnRubTRJaUxzY3FJaDhYcVBxUnUyeGg0?=
 =?utf-8?B?bGpqNWdBV0xrRjY3bVhWMVRBL0FobitzMWl5WTVRVnNLamNLU3Q0U1lER0hE?=
 =?utf-8?B?SHQ4WlczdmlNV0Faa205eTl2OXlReE9PdjA5QVFrY3dYdWMvQUZuSkFGN1Vh?=
 =?utf-8?B?VXYzQlF6RHBNcnZUMnJIWUxiYVIyWlRZUEZaYU5lNXA0dWhvcm55dEF3aDVI?=
 =?utf-8?B?RXZ0djRQMkx1YlNrMnlubjRDKzdFN1FXcGVwcU9ZZmZWQXhuL1NpRDBac05Z?=
 =?utf-8?B?NG5kWmk3WElTakFTczYrZHdBZFMveFArcEdzZHAzTi9NQ0svTW1yUVZSZ1Rh?=
 =?utf-8?B?ZzRaUnFibjJFTG4rODNCa21BdE5EMGNDUkZKWkp0cEJqSFBZY29Vd3pxc2dD?=
 =?utf-8?B?TTExVWYyZGNZYzhSdUo4MkJ5a09WZGlLYk9rMGROT0E0K2doRHlvMXZZeFpQ?=
 =?utf-8?B?QktYcmdjR0UrWG1QYnVuakd5b2RlWjZVenJPWERieWFsb0pHekVNUmVoRFU0?=
 =?utf-8?Q?KFkTzhSomAE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVhaEJTRjd2ZUVtSkpsb05mejlBT2NYUXEzc293KzVBczhJUjRMdzFtUGpw?=
 =?utf-8?B?WEFESVhoYUUraHlwNDBLK1R5NGR2NHIzNFphQmVoaVNvaTlRVWZ4R2x2eXJ6?=
 =?utf-8?B?YU14UTFrWFZLRHBPRTZPaFh1ZjhoSDFwODlpSWxyeHhWVGNyYjNnbUtvNkVa?=
 =?utf-8?B?ZXNjNTRieEV1dmFxMDdwYnB6b0diMjBQVThPQm5PUzJVQWcyV3BQLzdpNnZy?=
 =?utf-8?B?citTQlEyT3NUd0NIRzAraVRhNUlWNDJQaTl5TGg5Ly9CSFhhR3ZQdWlkRGhU?=
 =?utf-8?B?VmdSYXJobUtyUHVqL21LZ2R4eEhUNWNCV0xVcDBEZmJhc3h2bFRXYllJK3FE?=
 =?utf-8?B?bWpCME9PNzJDcHduN1YycmlhbTZOUDN4cGNSckVuZmorSHhGVHFpWDZlWTdU?=
 =?utf-8?B?UjY0Ym1jb1p5MVlGcFN6L210NEF5SVUwRTJpUklOdEJrMDBhOG42ZlFPQlVu?=
 =?utf-8?B?OHRZWjEwTlRWWE5JM3I1NDNQSmxyYnNneWdibzkvKzRFRlo3UWJFdnYvVFFX?=
 =?utf-8?B?VzExZ2dHTTNyNEVuTncrNFVCM25EelhNTU1qaW16bWxRVUJyc1YyWVl4YkJC?=
 =?utf-8?B?VHdDWlZuNFZHdVZsMWFRWS9tWFN3U0pIUG5FMkpFZUw2NDROZDczSzVwVmZJ?=
 =?utf-8?B?RFVvci9MdjJrRUgzdStJS2dvQk5DWk1QZ29Rd2tqL0s2cUI3SVZTUVBEKzZE?=
 =?utf-8?B?bk1LVkxaRFNBcEQ1U0VzSHh5MjQxNldpWnJveUp0S0Y2SGliT1NhU1V2bXR4?=
 =?utf-8?B?RzVFb2p3KzNjcDA0a3Y3U2hLSUtXQ0NkeDcyL0tEOG14M2I0UjNKYUNnUVFK?=
 =?utf-8?B?YXYzelEwRTZtTm1iR3lzcDNmY0V2MUYzQlJXaFdmQVdhY0Z1WE9CNUxPOHdS?=
 =?utf-8?B?cW03cTJYK1YzaVdhTmdkZVhiOUdjK0Nhc2hZaU1XT2F4aXoyakFML2lPVUFO?=
 =?utf-8?B?Si9Tcld5TjRacVQ3bWJrQmtXV2pNelU5WFI0RVQySlJUUms0TUowU0w4OU4y?=
 =?utf-8?B?ZEZMUkNGOTE4aFU1RDF1WXdUUzN3cFpoMUdhTFV2bS8zeldUUGpiUlNUOGNm?=
 =?utf-8?B?SitUejJLRUpCVnRWbWo0c2Z3WHVuVzQwakVMUk9UVlJTNG9uNXd0ZlY5M0xR?=
 =?utf-8?B?SGtiRGJOQVV1TG5pZ1N3alRDVDVpQmlObU9NdFI4L0xtS3BPTWpubDFVMHFQ?=
 =?utf-8?B?NElaNnBCMEJxUVRyNlRvVS9pUnplMlRta1ZQYlNGa0EybisvUUlWWURSTi9D?=
 =?utf-8?B?Q2I4emlTS3V1REVZOHBOWUNjODFVYmdENmxoczVvc2xzYTdKc29TZ3J1YzFa?=
 =?utf-8?B?QkRPZmlZeXdqd0h6OUlQcnhOazVNK3hQUkF0OWdUbUJIK2ZpNmdFbWZvaXZ4?=
 =?utf-8?B?dkNWd05QZmFVbTBrRVpRWlh1Tk9NQ1VoWDhYRHMwMUkrSjZOZThNM3RtMlVJ?=
 =?utf-8?B?eFFEZUJPakdEWFpwNTdjNy9HcDEybFZYMVJwdHhkVjFzOUdVcEJySjlMV0wy?=
 =?utf-8?B?NXNMUTNGUUFJdVc4b3NUR1lWOFdZK24vdTR0Wm00a29mR3NRSUtzait2K1px?=
 =?utf-8?B?dWhweDc4UTQzNEt1VjF3RjF3V3VuRHpCQjN1RE9IeFlqbzNlOGVQYlNmbkxz?=
 =?utf-8?B?NGwyU3pidU5mRXFkdCtYRzI5dE1DemZGU1ZvSkF3SDF5L09sRW9RcXRNVFZl?=
 =?utf-8?B?dkFoMTRwdk9xakZ0aG50T1BNTFZlNHhCMldSNUhJeE5SdHdrNHd5VkJ2UXBG?=
 =?utf-8?B?Qmw0cjJDUDJxdUFVMFhUdUNLRTYrZWxlRndoVk9PQWw3eUFKRE15aHEwOWEz?=
 =?utf-8?B?WldZeXJpaTYweGNvLzBqNnF4b2ZHYkFJdVVsMjVVRUI0TFZxY25CekdWQkh0?=
 =?utf-8?B?RktlQStlbis5dFJMSEd4N3VLaS9vdFJESmwwRm43Mnprc0lXYjFvWi9vTTM5?=
 =?utf-8?B?RWN0WUxJY1dYUjdCSHVQZ2cwSEl5NTVUSDFSaG5lZHF1MUEzSWlBRklEdGFk?=
 =?utf-8?B?YS94ZWFiVzBRWHcrTW5XY09vOU5UaURlSHdUTEc1dUk1cCtHaHRsUysyczhJ?=
 =?utf-8?B?SmpKYXVTWFZjOVpGNnZqbXluUmZTL1BGTU9VRGJwa0YxM21KWEY2ekdlUGdu?=
 =?utf-8?Q?ZtTe3SOrRV6rfqxSVI/XVngVr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaec5f31-a6d1-4181-1fd2-08dd8ef498aa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 12:25:34.3967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aLT0q89EJ6wN5CvcG9p+PcFM6AyoA5hCUNOwrHAuvv0ykW/3gc85dri6/ScluWU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
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

--------------QqfowkRukRAdoXOJf438EclV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-05-08 17:54, Felix Kuehling wrote:
> On 2025-05-08 10:50, Christian König wrote:
>> On 5/8/25 16:46, James Zhu wrote:
>>> When XNACK on, hang or low performance is observed with some test cases.
>>> The restoring page process has unexpected stuck during evicting/restoring
>>> if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
>>> 1. when xnack on, retry pagefault will invoke restoring pages process
>>> 2. A. if there is enough VRAM space, simply migrating pages from ram to vram
>>>     B. if there is no enough VRAM space left, searching resource LRU list, and
>>>        scheduling a new eviction work queue to evict LRU bo from vram to ram
>>>        first, then resume restoring pages process, or waiting for eviction
>>>        timeout and try to schedule evicting next LRU bo
>>> 3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
>>>     queue eviction will be triggered.So restoring work queue will be scheduled.
>>> 4. step 1, restoring pages process will hold one mm->mmap_lock's read until
>>>     restoring pages is completed
>>>     step 2B, evictiion work queue process will hold one mm->mmap_lock's read
>>>     until evicting bo is completed
>>>     step 3, restoring work queue process is trying to acquire one mm->mmap_lock's
>>>     write after the above two mm->mmap_lock's read are released, and in the
>>>     meantime which will block all following mm->mmap_lock's read request.
>>> 5. in step 2, if the first eviction bo's size is big enough for step 1
>>>     restoring pages request, everything is fine. if not, which means that the
>>>     mm->mmap_lock's read step 1 won't be release right the way. In step 3, first
>>>     eviction bo's restoring work queue will compete for mm->mmap_lock's write,
>>>     the second and following LRU bo's evictiion work queue will be blocked by
>>>     tring to acquire mm->mmap_lock's read until timeout. All restoring pages
>>>     process will be stuck here.
>>> Using down_write_trylock to replace mmap_write_lock will help not block the
>>> second and following evictiion work queue process.
>>>
>>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 72be6e152e88..5f6ed70559b7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
>>>   {
>>>   retry_flush_work:
>>>   	flush_work(&svms->deferred_list_work);
>>> -	mmap_write_lock(mm);
>>> +        while (true) {
>>> +                if (down_write_trylock(&(mm->mmap_lock)))
>>> +                        break;
>>> +                schedule();
>>> +        }
>> Oh, stuff like that is usually an absolutely clear NAK from upstream.
>>
>> As far as I know that is not something we can do so easily.
>>
>> Would it be possible to wait for progress instead of calling schedule() here?
>
> I could think of a few other higher level mitigations to avoid getting 
> into this situation in the first place.
>
>  1. Give BOs allocated with KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED a
>     higher LRU priority, to make them less likely to be evicted
>
[JZ] Less likely means still exist. we still see hang with this 
mmap_lock when VRAM under pressure.
>
>  1. If that doesn't help, set bp.no_wait_gpu in
>     svm_range_vram_node_new. This should avoid causing evictions when
>     trying to migrate data to VRAM in the page fault handler. In this
>     case, migration should fail and the page fault should map data in
>     system memory
>
[JZ] IIUC, It will sacrifice the performance in GPU computing stage.
>
> 1.
>
>
> Regards,
>   Felix
>
>
>> Regards,
>> Christian.
>>
>>>   
>>>   	if (list_empty(&svms->deferred_range_list))
>>>   		return;
--------------QqfowkRukRAdoXOJf438EclV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-05-08 17:54, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:cf8cb7d6-44a1-4732-a411-1caa7206b4f8@amd.com">
      
      On 2025-05-08 10:50, Christian König wrote:<br>
      <blockquote type="cite" cite="mid:e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com">
        <pre class="moz-quote-pre" wrap="">On 5/8/25 16:46, James Zhu wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">When XNACK on, hang or low performance is observed with some test cases.
The restoring page process has unexpected stuck during evicting/restoring
if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
1. when xnack on, retry pagefault will invoke restoring pages process
2. A. if there is enough VRAM space, simply migrating pages from ram to vram
   B. if there is no enough VRAM space left, searching resource LRU list, and
      scheduling a new eviction work queue to evict LRU bo from vram to ram
      first, then resume restoring pages process, or waiting for eviction
      timeout and try to schedule evicting next LRU bo
3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
   queue eviction will be triggered.So restoring work queue will be scheduled.
4. step 1, restoring pages process will hold one mm-&gt;mmap_lock's read until
   restoring pages is completed
   step 2B, evictiion work queue process will hold one mm-&gt;mmap_lock's read
   until evicting bo is completed
   step 3, restoring work queue process is trying to acquire one mm-&gt;mmap_lock's
   write after the above two mm-&gt;mmap_lock's read are released, and in the
   meantime which will block all following mm-&gt;mmap_lock's read request.
5. in step 2, if the first eviction bo's size is big enough for step 1
   restoring pages request, everything is fine. if not, which means that the
   mm-&gt;mmap_lock's read step 1 won't be release right the way. In step 3, first
   eviction bo's restoring work queue will compete for mm-&gt;mmap_lock's write,
   the second and following LRU bo's evictiion work queue will be blocked by
   tring to acquire mm-&gt;mmap_lock's read until timeout. All restoring pages
   process will be stuck here.
Using down_write_trylock to replace mmap_write_lock will help not block the
second and following evictiion work queue process.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 72be6e152e88..5f6ed70559b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
 {
 retry_flush_work:
 	flush_work(&amp;svms-&gt;deferred_list_work);
-	mmap_write_lock(mm);
+        while (true) {
+                if (down_write_trylock(&amp;(mm-&gt;mmap_lock)))
+                        break;
+                schedule();
+        }
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Oh, stuff like that is usually an absolutely clear NAK from upstream.

As far as I know that is not something we can do so easily.

Would it be possible to wait for progress instead of calling schedule() here?</pre>
      </blockquote>
      <p>I could think of a few other higher level mitigations to avoid
        getting into this situation in the first place.</p>
      <ol>
        <li>Give BOs allocated with KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED
          a higher LRU priority, to make them less likely to be evicted</li>
      </ol>
    </blockquote>
    [JZ] Less likely means still exist. we still see hang with this
    mmap_lock when VRAM under pressure.<br>
    <blockquote type="cite" cite="mid:cf8cb7d6-44a1-4732-a411-1caa7206b4f8@amd.com">
      <ol>
        <li>If that doesn't help, set bp.no_wait_gpu in
          svm_range_vram_node_new. This should avoid causing evictions
          when trying to migrate data to VRAM in the page fault handler.
          In this case, migration should fail and the page fault should
          map data in system memory<br>
        </li>
      </ol>
    </blockquote>
    [JZ] IIUC, It will sacrifice the performance in GPU computing stage.<br>
    <blockquote type="cite" cite="mid:cf8cb7d6-44a1-4732-a411-1caa7206b4f8@amd.com">
      <ol>
        <li> <br>
        </li>
      </ol>
      <p>Regards,<br>
        &nbsp; Felix</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com">
        <pre class="moz-quote-pre" wrap="">Regards,
Christian.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap=""> 
 	if (list_empty(&amp;svms-&gt;deferred_range_list))
 		return;
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------QqfowkRukRAdoXOJf438EclV--

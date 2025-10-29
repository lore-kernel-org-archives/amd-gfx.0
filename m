Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FFECCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 09:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35FB910E768;
	Wed, 29 Oct 2025 09:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YRg9pVw/";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5B610E75B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 09:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5pUp17iW6+YIbCtdLdEA2BhSoDe+av5dAE49UKlGyDJjYiTvxSHQ1bkntfKWtnmuvUWtqGdC/D5s3lVdBKMKYGS8HKkKUNKB9kMbC9AhCkJieSwpMPpw+VG9uzKb8iJ7/S8/uhfs1pXoO1kM1tT30od8RxAR4api0WYUt0qw9FUH7341qFrhe164n4Dn7u7GTf9PbLzl06FxvihaxILYmh7iXeI6l5IvbB66FQoo/J+e7hTXY+unMe+I6Cs4m5QvpWTBZFWnv+UK74EiW2d8/bp8acm8ULJzH85llUAV463Tf89qaj3p1q2saBCHy2sHk76fGq3QEaocnofv1QkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHMGsWiA8HZElRwm5KCABmEWs+G4j4FyW30gHJcxymc=;
 b=wo7egiF/UlnQdEQPalSXeNUP5pgQ/66boOIq05PZvwwCfBOP0uClJ+ItTVV0ayM8yHvN/9YZa7HUK6EIUW+LP+lb27BjcWYHNa3J/puZTh7BXjAUcOULMg0HBK/jqc4ruvvGbbQNBAtS0hbZp5HsI0cmd6ER9ksbiTuMPwccsbzH14q5Yj3U2cGUVzGUi0uS/K6LqgQC6ysgEtyveQsA4R4on9JJijLmBA+1L8ZxSR4Y7PZmQezQXwlCfENFuFJyhhkTVlbr5FDvZX0FM9cbg+gROBV9uAT1ka9fXR0McMirdVWq8tiObVoab4n2RxZTAU6slyEtOvdfMRkCP1PqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHMGsWiA8HZElRwm5KCABmEWs+G4j4FyW30gHJcxymc=;
 b=YRg9pVw/OtwJCgLEaSMmeiEqLrVih67JwlCm+Y/G5XJTbKn6A1n9cbcg8pq/AVezaxTbL2RfWwjaVdkaOoCL+OAzffV/2fH8wGQ1AcppUwIDfvbyNwYsutHPyQKB9a3JC1m6j+efNALGIsGC5M81oADRgcV3XHuLzkUpNUyxbdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7206.namprd12.prod.outlook.com (2603:10b6:510:226::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Wed, 29 Oct
 2025 09:28:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 09:28:46 +0000
Message-ID: <99c5eb34-e223-41db-9283-1ca85a1923f2@amd.com>
Date: Wed, 29 Oct 2025 10:28:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove invalidate and flush hdp macros
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com
References: <20251028141328.3302820-1-asad.kamal@amd.com>
 <b7799043-efa7-4392-a7a5-941580820d42@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b7799043-efa7-4392-a7a5-941580820d42@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f09080-4dcf-4114-16e0-08de16cd8f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2U0MmNUVkY4Z2JHUC9LZDVnTjVNVFV2Mjl4N2hXcnl6QnNJZHViS2xKZVJQ?=
 =?utf-8?B?ZCtwMFlCWTllMkIrSWdObXRSdW14aGNtS3JkVGxPQVpsRks0STFMdGxjMVF5?=
 =?utf-8?B?Q2hjSkVhczFTRUdnZWRKUnY3cW84Kzh2eS96bHVlOUJ3TDVYZUdERjNMaGpN?=
 =?utf-8?B?cXZ0dnZrcFMwcGtHaG8wdXlML1lzeUJkSUR5TnJtdTZuNFJDNkJmYXRwN3M3?=
 =?utf-8?B?RUdKcDU0NWFRcFIxVjlQTHhRclNiUklsR2FqUmRXN2dkckVFZGErT2Jtd3FY?=
 =?utf-8?B?VjFMQ0JmUHJSOFc2NEpiNzByUlY0VU80bWY2YkFqRFY2cEQvak15b1dXZWkr?=
 =?utf-8?B?KzNHQ25ndExRd2YrTDBYQ1hHMERjQVljY1ZPdzhsTWFFdDZRSHFIVzNvU2Fu?=
 =?utf-8?B?MGp3WFUzOWlkMlNKMWVvTGU0RXJWWHJiWVI5bzI5dnZTaUJVZnNHSEdTek1v?=
 =?utf-8?B?QzZ2RVgxN2MxejBXYjJrUWh4U1FHM1Jyd2paOTlRMDI4VzZxNFhwZ0JEb3l0?=
 =?utf-8?B?K0JVZnJHL2EwUURKdnpkSWx6YkI5aktYY0gwRU9nSEg5TEpNamFtYXNEK3Zo?=
 =?utf-8?B?QWF5NXgrTGpGQnN1WmNCWXdDT1JrZmQ0Mmh5YTNtY0V1MGhFNkZPOUNDbFhF?=
 =?utf-8?B?SzIvK25NYVpzTGpmQnJmOTE5QzExRHIyR3hZby8yL0FpVG5DWmFmSEVjT081?=
 =?utf-8?B?S2lyMG9OdkQwUTlON2FOeFZRUEM2RldPYnplV2tGM3Q2M1FhdzhHdDh1MzRs?=
 =?utf-8?B?MkQwSUxSQlhyeFFGZG80TjU0dUFuSW50emttN0ZFeE8rUVAzWWhLN3daT29y?=
 =?utf-8?B?SWxKTEpPaGVJL1g4TW1FVUsxWDlQMXNPdkhTbVd5bUl5Z3J4VU5wdXBsakx5?=
 =?utf-8?B?aktkZW5sOXRZb2lJb2xJU3JscENrYVZ2NE1lSWdCOHpPWmJKeTBBVDF1NDZ3?=
 =?utf-8?B?QzdlNHlRVWhKZjFHZkp5d1JhdldXSDFhNjlIS2lHV2EzOFZKZFhWYUJ2bWhW?=
 =?utf-8?B?RDhRNmhhdHZLWjltWnRjOXdTc0d2YXhSL2dXdXhYREF1Wi9jcmhLNWt0NXJz?=
 =?utf-8?B?R0wwWDJ2aXJOMFFlak5BUmlXMGlVbG9rc1dRenhKbVdnVU4rMzc5d0JGbFg4?=
 =?utf-8?B?NUdZMC9nT0NMc1Q3SDhITzZLZmlyS21FamJ3VlpEaytoV2p1Mm12NEt3QTB3?=
 =?utf-8?B?T08wUnAwMFlxVTZJQkZENkNEMXBkSisyVzRrbWxnVVI4M2duOFVDMXZyVE01?=
 =?utf-8?B?WStHZXpjTXRrWTYrTGt3a2xuWDltblJybWQ1RTZKdnFDQTNvb0hGWW5zemV0?=
 =?utf-8?B?dVRmV0F3bXkvQkJzNlNPblZmaVZkUm5TN1dxQkdmdFh2cnFGWTRUV3dPci9i?=
 =?utf-8?B?T2pTRnRWZHlDUzRJV0RVZDJhKzJWc3RnU21KaUc4QWlLT3VOcE1CZkhpT0xX?=
 =?utf-8?B?NXl4YmdmbmJDYnhwTUlINk1GS3F1TlZ4TENnWlp6cnFOemFkeVJDQUpDWlRT?=
 =?utf-8?B?bnZYNnhZWFJybDlHNzlxUTBJa1BsWjdueUhveGREUmg1KzJ1VUlFdlZ6aVk4?=
 =?utf-8?B?bmhHMmhVQldSRTBrOWF0YmZ5QTQ4QVJFZW1GSVFXZC9LbUg3R0o5VEM2RHJ4?=
 =?utf-8?B?U0tLUW5Eakp3S3JhSnhuWEZLRWl6OXNmR3BSVlczcXBCL2FLMG1uVEs4RkZy?=
 =?utf-8?B?MjZpQ3hoVU5nc2VtOWNBVkJxSlUzQjgwVjAvQnVCODc4YzBOcVBZZTIxVTN1?=
 =?utf-8?B?djl3Sk1hWDI2Ky9iNHJYU2Z3aU9GS2tWSUYra1l4eCtPSytDVmxTWnBVUDFP?=
 =?utf-8?B?UWo0eTZvb0cwa0JsQmF6YVV1S3pwaGt4dGlYOWNTRE9UTWRrdzEyY2lxaTRy?=
 =?utf-8?B?TjkzQlJRdEg4TnJmUG94MnpVZXlTOXg1Vk9RalpnVGpLRXRFMGNtVWRWUnhB?=
 =?utf-8?Q?Mgob+KFxYJGpLPM8tQdVoky7BAO9k++R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkcveEJmbDRneWlpNHJsK3o1K1dzNUd6eXBsVkViOCtCZEx5eno0ZnhkRVlz?=
 =?utf-8?B?UTBvQVdVcmh6SndFUjFzUXpOekFTaHZCMkUyZ0UrcUxObndGT3RlOG1tbDhQ?=
 =?utf-8?B?Q3Y1aE5SK3ZXYzA3eFQ0S2J1Q1JtVm1iek1sS1hMVnNkVlF6cTNyK2p3dUJ0?=
 =?utf-8?B?aGw1NHVDUHBXZFh2S3JHaFhhTE93TzFqSDVORy9XenAxSFJnUXRtNGMyQ3p4?=
 =?utf-8?B?WWlZd2Vya3YxV2RkOWsyTEtHY3RQZXpucWhOUGFydEdybkFydy9OK3ZjQjVx?=
 =?utf-8?B?K0dNcEdpVytoMXdrWVhDY0JLbkJPUUVPQ2s1Y2p3cEErdXNpN3dzaEhHV1Fq?=
 =?utf-8?B?SStFRXhLMnJtL1BiRTJqQ2JuRnFxYmQwSGFvRVcvQmtyS29tNEp1YnM2SmJU?=
 =?utf-8?B?eE42dlZ3UGdGNmhqb2NWNFo5MTlwWEg0YnNmUHdHcHl5RFpsUEZ4aElXV25y?=
 =?utf-8?B?NGVRbFEyS0d4M2Q4TUJsZEllU1ZLb2szOWpwYVVOT0R6UUV2T3lKcGRWaGNV?=
 =?utf-8?B?TXp6WWJRWmsvSzRLNldZV0RpSHFrdU1xdDZrQUhaRi9BaUtiRmpHa3V3QlVs?=
 =?utf-8?B?ZnN4M0NxL0lSdmxrdk1FVkY3R3o3SDNMMlhaemtjK1A1emdBa3ZoRktrS1Nk?=
 =?utf-8?B?WW9ySlI1Uk1pSHNQQjVVTFdpTkN6V0o4NjhzNGRHaGlTRUtsMFZOUlBqclBJ?=
 =?utf-8?B?T3V2b2IyZU5NMEdIYnZZTnVHRUg4aE1wZEkrdnI1VldNRGlYTFhKNWdRbTB0?=
 =?utf-8?B?K0cydFd0Um9KSUhpVkkwZTY5VG80UnVxNUNWOFVjM0owdFkvRzAvanlNcE5E?=
 =?utf-8?B?QmtGQjkyMUJYa2tObm5JS25NdVlBK2s3bDF3RmlzNHQvbjlIUlczbUpjZGQ1?=
 =?utf-8?B?R21sbUhaK3RpUDdCa0ZSdGZMdXhnMThHWGpIL1NqakhHMm9XL1UydGd2M0s4?=
 =?utf-8?B?MUNKWnl2Mmx3U1Z6SlZZcTVEa2lyQ1RnQTdoaHhMcC9ZQ1ZBN2NvZ3A2bVpa?=
 =?utf-8?B?WXRRNVMwUlM2aGhLWmxmSzNjMG5MYkdRNTNjQmIxNm85bEs2KzdxM0I2bGlT?=
 =?utf-8?B?OFZPcGp1QmNWY1RrNDRVUlFRc2ZTRVlRaWxpU2F6OFpUS0grVWNUMVFoN0dv?=
 =?utf-8?B?R2RmMnhzazFzYmVLV1l1dWZtK3lqWnNnQXJ0UEFpN3VicmwydjhnQWRLVCtU?=
 =?utf-8?B?SElyN3d0TWthOUM3amgyaURSUk9UYU9oL3d1UFJ6N3ZnT3c0WWlTT2Y5RUN1?=
 =?utf-8?B?eFZMTnNkb1hJVXdaSVVOK3RJRHRHM3o5QmdMRHNyMEk2YWlsa2xQblJkT2du?=
 =?utf-8?B?TzNQOFFmaGxlUE9pZHlNQ1d0WGV1YzVNeUtNL1h4Nk5IbU1vRkNqREsySXBw?=
 =?utf-8?B?d2hNV256U3FaaVlkeFJ5aVZEWFBWZ3E1bTJHOXJnbUpFNjJZd3hpMFRjN1J1?=
 =?utf-8?B?N1AxWUVPUVNnWG5Pam5PSkJLTUdjUGJTMjRDNlRwZkoxWmFibGtvYVB2UTRX?=
 =?utf-8?B?WTlTak1ndU9pY3NhckZ0YzJFTEMrbWU4RzhmWk13QVF6SzZmYnRiK0g2Z01P?=
 =?utf-8?B?STZpOW44MzlDWjc2clQ4aUJhRndlaU9pTU54eEM5Y1JJVkFnaysyOWkzV29I?=
 =?utf-8?B?bUU5MnBxYUkwNGVBTitkell1ZzI2Mng4NXZ0WHcxb2pkNm54c3B4RVJFcitL?=
 =?utf-8?B?ZTY2YmlTOENqa011Z29xU1B5STZUOTlRYXJRb3diY2M5QkUvUlYyelVWSGZj?=
 =?utf-8?B?S2QrZzdIdTM4Rkx5N3RkZjR2UTc2d3ZYKzNqNERKZmNTZTNwZno3alVPTERh?=
 =?utf-8?B?bUI0bTIvQzRXeURxR0VxbXFLM1I4YzJVSEFPeEJQTTJXMEw3Zkp3WGlwbGZv?=
 =?utf-8?B?SjgzNWN5T2x2U0lnT1hwSWQ1MVBSc0N6WFJadkFJd3NNZkh2bS94QngwU2JJ?=
 =?utf-8?B?WTR4S20xRGlkV1dUU242QUFRRlcxbEFrY2hIUEE4dzdzNWFUQkdJUnFla09O?=
 =?utf-8?B?M3V1cDZGNm5kenBCV3B5MGw5aXV5aWpQMjVmb2pGVHpYZTVUK3luMm9Rekwr?=
 =?utf-8?B?bUZtN3NndUlKc0JDRjBVTS9mRmNwcWFlNUU3RUxhb2tYZVNBa1pWRFVpTkQv?=
 =?utf-8?Q?W4Y3ik8KVT+TOxz7YrVXIzE+8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f09080-4dcf-4114-16e0-08de16cd8f87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:28:46.7558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5cDNF65masP50KPsMjZe9gVAoLEf8VJgvlIde3RZ9Y/qahenmOuLi5cEsLI9hOq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7206
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

On 10/28/25 15:57, Lazar, Lijo wrote:
> 
> 
> On 10/28/2025 7:43 PM, Asad Kamal wrote:
>> Remove amdgpu_asic_flush_hdp & amdgpu_asic_invalidate_hdp functions and
>> directly use the mapped ones
>>
>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> 
> Two patches (invalidate/flush) would have been ideal.
> 
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> 
> Thanks,
> Lijo
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h                     | 2 --
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c              | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                  | 2 +-
>>   drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c  | 4 ++--
>>   drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 4 ++--
>>   drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c | 4 ++--
>>   drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c | 8 ++++----
>>   drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
>>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c   | 2 +-
>>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 6 +++---
>>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 4 ++--
>>   11 files changed, 20 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d1137d8beca7..bcfed46eedaf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1539,8 +1539,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>>   #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
>>   #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
>>   #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
>> -#define amdgpu_asic_flush_hdp(adev, r) amdgpu_hdp_flush(adev, r)
>> -#define amdgpu_asic_invalidate_hdp(adev, r) amdgpu_hdp_invalidate(adev, r)
>>   #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
>>   #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
>>   #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b92234d63562..962380af4ee9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -7327,7 +7327,7 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
>>               return;
>>       }
>>   -    amdgpu_asic_flush_hdp(adev, ring);
>> +    amdgpu_hdp_flush(adev, ring);
>>   }
>>     void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>> @@ -7340,7 +7340,7 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>>       if (adev->gmc.xgmi.connected_to_cpu)
>>           return;
>>   -    amdgpu_asic_invalidate_hdp(adev, ring);
>> +    amdgpu_hdp_invalidate(adev, ring);
>>   }
>>     int amdgpu_in_reset(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> index 3bd44c24f692..de7a1e168a76 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -342,7 +342,7 @@ static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>       const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>>         if (ring->me > 1) {
>> -        amdgpu_asic_flush_hdp(adev, ring);
>> +        amdgpu_hdp_flush(adev, ring);
>>       } else {
>>           ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
>>   diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
>> index ac9ec8257f82..38e19e5cad4d 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
>> @@ -139,7 +139,7 @@ static int smu10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
>>               priv->smu_tables.entry[table_id].table_id,
>>               NULL);
>>   -    amdgpu_asic_invalidate_hdp(adev, NULL);
>> +    amdgpu_hdp_invalidate(adev, NULL);
>>         memcpy(table, (uint8_t *)priv->smu_tables.entry[table_id].table,
>>               priv->smu_tables.entry[table_id].size);
>> @@ -164,7 +164,7 @@ static int smu10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>>       memcpy(priv->smu_tables.entry[table_id].table, table,
>>               priv->smu_tables.entry[table_id].size);
>>   -    amdgpu_asic_flush_hdp(adev, NULL);
>> +    amdgpu_hdp_flush(adev, NULL);
>>         smum_send_msg_to_smc_with_parameter(hwmgr,
>>               PPSMC_MSG_SetDriverDramAddrHigh,
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
>> index f9c0f117725d..0bf1bf5528c2 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
>> @@ -60,7 +60,7 @@ static int vega10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
>>               priv->smu_tables.entry[table_id].table_id,
>>               NULL);
>>   -    amdgpu_asic_invalidate_hdp(adev, NULL);
>> +    amdgpu_hdp_invalidate(adev, NULL);
>>         memcpy(table, priv->smu_tables.entry[table_id].table,
>>               priv->smu_tables.entry[table_id].size);
>> @@ -90,7 +90,7 @@ static int vega10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>>       memcpy(priv->smu_tables.entry[table_id].table, table,
>>               priv->smu_tables.entry[table_id].size);
>>   -    amdgpu_asic_flush_hdp(adev, NULL);
>> +    amdgpu_hdp_flush(adev, NULL);
>>         smum_send_msg_to_smc_with_parameter(hwmgr,
>>               PPSMC_MSG_SetDriverDramAddrHigh,
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
>> index d3ff6a831ed5..e2ba593faa5d 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
>> @@ -68,7 +68,7 @@ static int vega12_copy_table_from_smc(struct pp_hwmgr *hwmgr,
>>               "[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
>>               return -EINVAL);
>>   -    amdgpu_asic_invalidate_hdp(adev, NULL);
>> +    amdgpu_hdp_invalidate(adev, NULL);
>>         memcpy(table, priv->smu_tables.entry[table_id].table,
>>               priv->smu_tables.entry[table_id].size);
>> @@ -98,7 +98,7 @@ static int vega12_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>>       memcpy(priv->smu_tables.entry[table_id].table, table,
>>               priv->smu_tables.entry[table_id].size);
>>   -    amdgpu_asic_flush_hdp(adev, NULL);
>> +    amdgpu_hdp_flush(adev, NULL);
>>         PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
>>               PPSMC_MSG_SetDriverDramAddrHigh,
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
>> index a5c95b180672..e3515156d26f 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
>> @@ -192,7 +192,7 @@ static int vega20_copy_table_from_smc(struct pp_hwmgr *hwmgr,
>>               "[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
>>               return ret);
>>   -    amdgpu_asic_invalidate_hdp(adev, NULL);
>> +    amdgpu_hdp_invalidate(adev, NULL);
>>         memcpy(table, priv->smu_tables.entry[table_id].table,
>>               priv->smu_tables.entry[table_id].size);
>> @@ -223,7 +223,7 @@ static int vega20_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>>       memcpy(priv->smu_tables.entry[table_id].table, table,
>>               priv->smu_tables.entry[table_id].size);
>>   -    amdgpu_asic_flush_hdp(adev, NULL);
>> +    amdgpu_hdp_flush(adev, NULL);
>>         PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
>>               PPSMC_MSG_SetDriverDramAddrHigh,
>> @@ -256,7 +256,7 @@ int vega20_set_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
>>       memcpy(priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table, table,
>>               priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
>>   -    amdgpu_asic_flush_hdp(adev, NULL);
>> +    amdgpu_hdp_flush(adev, NULL);
>>         PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
>>               PPSMC_MSG_SetDriverDramAddrHigh,
>> @@ -306,7 +306,7 @@ int vega20_get_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
>>               "[GetActivityMonitor] Attempt to Transfer Table From SMU Failed!",
>>               return ret);
>>   -    amdgpu_asic_invalidate_hdp(adev, NULL);
>> +    amdgpu_hdp_invalidate(adev, NULL);
>>         memcpy(table, priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table,
>>               priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> index bbf09aec9152..7c9f77124ab2 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> @@ -2889,7 +2889,7 @@ static int navi10_set_dummy_pstates_table_location(struct smu_context *smu)
>>           dummy_table += 0x1000;
>>       }
>>   -    amdgpu_asic_flush_hdp(smu->adev, NULL);
>> +    amdgpu_hdp_flush(smu->adev, NULL);
>>         ret = smu_cmn_send_smc_msg_with_param(smu,
>>                             SMU_MSG_SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_HIGH,
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
>> index cb3fea9e8cf3..a0c844bf852c 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
>> @@ -449,7 +449,7 @@ static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu)
>>           return ret;
>>       }
>>   -    amdgpu_asic_invalidate_hdp(smu->adev, NULL);
>> +    amdgpu_hdp_invalidate(smu->adev, NULL);
>>       smu_table_cache_update_time(sys_table, jiffies);
>>       memcpy(sys_table->cache.buffer, table->cpu_addr,
>>              smu_v13_0_12_get_system_metrics_size());
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 0a7d2cea7dc6..e1f9aa5d6c20 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -766,7 +766,7 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
>>               return ret;
>>           }
>>   -        amdgpu_asic_invalidate_hdp(smu->adev, NULL);
>> +        amdgpu_hdp_invalidate(smu->adev, NULL);
>>           memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
>>             smu_table->metrics_time = jiffies;
>> @@ -845,7 +845,7 @@ int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
>>           return ret;
>>       }
>>   -    amdgpu_asic_invalidate_hdp(smu->adev, NULL);
>> +    amdgpu_hdp_invalidate(smu->adev, NULL);
>>       memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
>>         return 0;
>> @@ -2385,7 +2385,7 @@ static int smu_v13_0_6_request_i2c_xfer(struct smu_context *smu,
>>         memcpy(table->cpu_addr, table_data, table_size);
>>       /* Flush hdp cache */
>> -    amdgpu_asic_flush_hdp(adev, NULL);
>> +    amdgpu_hdp_flush(adev, NULL);
>>       ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RequestI2cTransaction,
>>                         NULL);
>>   diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> index a8961a8f5c42..3b98065dac1d 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> @@ -980,7 +980,7 @@ int smu_cmn_update_table(struct smu_context *smu,
>>            * Flush hdp cache: to guard the content seen by
>>            * GPU is consitent with CPU.
>>            */
>> -        amdgpu_asic_flush_hdp(adev, NULL);
>> +        amdgpu_hdp_flush(adev, NULL);
>>       }
>>         ret = smu_cmn_send_smc_msg_with_param(smu, drv2smu ?
>> @@ -992,7 +992,7 @@ int smu_cmn_update_table(struct smu_context *smu,
>>           return ret;
>>         if (!drv2smu) {
>> -        amdgpu_asic_invalidate_hdp(adev, NULL);
>> +        amdgpu_hdp_invalidate(adev, NULL);
>>           memcpy(table_data, table->cpu_addr, table_size);
>>       }
>>   
> 


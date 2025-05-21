Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248A9C54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 11:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9C311AF40;
	Wed, 21 May 2025 11:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vO/Ad0zS";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2BCA10F017
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 11:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmfizu0d2rD7RKFd+VzhJrWI1/Nb0qBKhwCUY09iYsQ9GjR51hzCwX9ohcgMhpjeLU8L7tLi3W1P1aj+/Pf+Q0dv1xKJmv0+cuZWTbh4dPHPDpHz2ffVK+noa7CsfcyKiSv0WNn4mlnYF42SgapMTJDNHISao4MfQfvQNfacet9bQs9JN5ITaARojXEvbYnyEYQpHUgMcQ1NGnxvt5neofG5SG06nqBrsIpCnPJaIu7AwDRKuIPAh8LHWVmL8BLXpU/RDYDYd7ZgjrAOxKHLnU3y6tRaSCpJ/YOsitma9zKZfAboqa4Jg8TZk8ZbAfwuH3ZdJrbUSYCI/07dARdbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RpKKF09doRLmmqQCXtaJd9efzD5v5tfV4Rr09uVs44=;
 b=Pmr8dNvL3BGBM5R7a1joMTnLAIwLraumRBh9PktSiSv6si1beXpkSBUhJgwmKsGdDnEWiKXbNpRjIJfiuD2MjrQw8uyJTAyJ3PfzyULef45xf767XanaUjrJlYxpr+cO4EOALPNFW680fO7vTUkvVa/Owgc4Hls7txC0h7NH2mL9zjdXl/YTGddx1LoC4lw+wNfHYLfJGAo9JWfb+bE839iUe2zZglxmXqSPl4zrz40sB6bHXt5DDkoTvJrHxzRrUpkCXpPkAWn+fDGYmeXEnNVS4d2OucyYwNMcJMCVwTJen6W7Mq647ub+jzAac2hNN1dhQC691rvdwxcHdfvMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RpKKF09doRLmmqQCXtaJd9efzD5v5tfV4Rr09uVs44=;
 b=vO/Ad0zSEHwYYCrxG89laZu7M7UcBuj0KtMpvC/vlPQ2B8G8adkVFbgf0fgtu/zWQRvv8B71xap/mndJu0BnWK6ZgAEooKiMlkdW9uiWutgYyBj3xxp2Nxm1BzC99czuQfGiy4ONrsxk2MLvQtYqzHWT/g+RbvWcJqpYNJrBB8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 11:48:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 11:48:09 +0000
Message-ID: <242bebfb-cd9f-418f-963b-3d9606f2fcf8@amd.com>
Date: Wed, 21 May 2025 13:48:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] drm/amdgpu: port some debugfs function to
 drm_printer
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
 <20250521094912.6714-5-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250521094912.6714-5-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0054.prod.exchangelabs.com
 (2603:10b6:208:25::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8cd1cf-08cc-463f-ff06-08dd985d5ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGt4dzYxVUhOKys4cmY3N3hTL3dSbGtWV3V0eEFYT05aSEhpWTZpNnpqY2U5?=
 =?utf-8?B?K0ZRYk9aOHZ3VTNnVllkK1RFN080b0VUa0VtTE0vcHh5dXU2MU03R3NZZ0RE?=
 =?utf-8?B?TkxXR0t5RG5Xai80ck1xNEtrZFpLMTJuSjhSNjhVc0MzY1h0c0pkUytobVht?=
 =?utf-8?B?cDQ1MDE1aDFaa0ZHVXUxR1oxK1dPbnZPS3VrU2hZOE1RNG5oRnloUExMWkNO?=
 =?utf-8?B?Q3BBLzhYNFFSQ1UzZldyZE83d3IxdTVRVTJUaGZaWWpjc2F4QlZjWEJFR1lN?=
 =?utf-8?B?Y0VmQzB3MzNqRkw4dDUrQ25QMFRjekZGTzZVcjNpMTJKcmVIU0tFYTBOT3RS?=
 =?utf-8?B?OHZuYUcvZWFzalZmYmRsTisyRHhhL3ZKNFFqb2h6MlJ1S3hxZHZ6NlBmdVl1?=
 =?utf-8?B?R094MnRYSnJnYkNrM0tQeFk3b1BMQjBCSUFIcEl6TUMxT1Jvak5HQzdhWmwr?=
 =?utf-8?B?b1NmRk9zQkwxbVhWM0xMbEdHRXM1MmhRYVlobXg2NlpuckZGeFMxU29NZ1Zu?=
 =?utf-8?B?aWlrWWRIWWNwekRnRTJmMEVUdENGbGpwVnF4R3ZGWXVTWkM2dE9yUGhHdm9i?=
 =?utf-8?B?TUh5R2hlUFhGL04vK3ZUWmhJMmlWeWRMeEpIOTNLVThTSUE4V0JEU0lXMVRj?=
 =?utf-8?B?Q3ZnY0gzQVZDZnp6RndpSEpIYUN1WkMweVpsMHBmUk1sYm5EMVRiYjU3eGYv?=
 =?utf-8?B?Rnc2c3A1Z21iSHREQi84R2xnb1lRTHptOGZWRmZ2S0szdFNLNXd0cTloNVh1?=
 =?utf-8?B?NU5uUFlXc2VublE2MU1TZHR3UXhTTXhzbitaZjFyZVhpcDFGMUt3NW41aU42?=
 =?utf-8?B?YzJQY1Y4alBydHFLZlB6T3ZkcG1jZzB6TVQyME0wazNiM1FOV3MvWmEvMHdO?=
 =?utf-8?B?Z1AvSkRHNGphblR6TDhFOSs4WGdwK0t2WHBOT2M4M0lGVUowaXFFcFNQeVl6?=
 =?utf-8?B?RkZOSnp4cWRqaXlQV25CbTZFT3RkYlRYZFB2VFM0cTltajJKRXo4L2RqRmlt?=
 =?utf-8?B?MzcxRWhTdktXZDRSS0RNdEVjTjVKSVM5clc3NTlLNksyckFKMXRRZ2FFYytU?=
 =?utf-8?B?ZTh6UjJ2MVp0QXVFWTFkd0M0ZzdrK01QTStsUWNLcXJ3Qm9TVjFZQU9XbHI1?=
 =?utf-8?B?Mk40RWxiWGJLVlBhM1kxZEkvaVFJNTRoYzZzbTJmWEg3T2VVMC9SbmFBNXdv?=
 =?utf-8?B?WUhTVUxnRmR0YTR5RlErN3FoSno1WkpWZndhSkFYSHB3bXhsZmY1LzAzMzVm?=
 =?utf-8?B?dm85MnBpdVRZUUtLSWFETm1JSloyN2xXeloxZVNoUnVhQXM3NFF2aVRlUlNn?=
 =?utf-8?B?VHliQnBaV0Z2U3NJWmYrZTZRKy9tK3RRU3pnOTROcTdEcHdla1IwcWNkbVdQ?=
 =?utf-8?B?a1NRcGRxQTI0MnZkWlkyNm1kRkM2bDRtNHBBbmk5cWV4c2ZOZXlwS0UrRWtW?=
 =?utf-8?B?emVNR0VQOEc3WDZPa2ZyNnV3a2RSUW1PTDBnczlUV3REZjhZWXpZZW1JY0wy?=
 =?utf-8?B?NFpQWTFxbzgxeXV0cXNxa1VYN2tDVFk0VmtQYkFtNlBqTXVITUpOMGZBcmVL?=
 =?utf-8?B?MDJPS2g1NmtSUVFhdXNDNjVUQ1BuQWVaaUcvNnprcE5sejc2dU1aa2JlY0R4?=
 =?utf-8?B?aGFCS2hEcWZTZFdwVVZoT2hiaThqL0JOdzR4N1BPTE9HeG9lRTErOXpoWUFZ?=
 =?utf-8?B?dFh3bVhpeVhQZXpFUmdyTm5YemNrQk5qZEMzZWpFa1h6cFlNUzFlVEgvUGUx?=
 =?utf-8?B?bkM2Qk9xK0FoYmptK1JVbUhUQ1VuWk9DbXhva1B6UHVqUlcxRlFGazczdC9G?=
 =?utf-8?B?dXJmUVhFZ003SFF2Qk1pYk5nTFBlL0pHVDY2VnNvaUE4VmdoS3k4aCtRYXU4?=
 =?utf-8?B?Z05UZFBMVHU3Qm9LNGdsVWU2c0dsU3ZPU2dJS3lOaDI0UUl5c2VZaGhBNUFI?=
 =?utf-8?Q?ZWIZ8PioC7Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0FxdStScGhLWStUZER5a0VqcjJRcHB6Y1FzeWJDaXlwcStDRW12QzZXMWJ0?=
 =?utf-8?B?ZkEzbjVmYUtqN1FKSFFJSTA3eFUxbHVxVTVtTS9EaVZ3bGc4MU5EYjBxMnA5?=
 =?utf-8?B?Y3hkTWRTVm0wUXZoWVFmVENKa1dHTzJuaC8wYm5KV1hpZ3Q4Q0l2V0xpb3Ex?=
 =?utf-8?B?N21yNVFPUDJDRlBqcktMM3hnN01qOXpDc2dOUktQT25aM1cvc1RRN3pRb21F?=
 =?utf-8?B?dlV2Qllhd1R1ak1MbDE0a3VnbkMycXdaTHVzOGFBKytNUjlJemRSdEQzLytw?=
 =?utf-8?B?cjJ1SnpmUzNiYWRqNE1zMFZnYVViSmpZZjc3RmJwclJVcHNsakthVVlnY01U?=
 =?utf-8?B?cFNPVmw4UUQzNXZQWnlmQTFFZTAvVGVXdE8wZEw3RGdWdTBNbitZbVNXVmVk?=
 =?utf-8?B?UHdoRVVTNUV3K0VldVc3SWpJQlIyQ3ZCbGN4UHVjTzQxOWt2N2pwMHlVUTBy?=
 =?utf-8?B?andoZ2tiRndQTklkZHVSQmhodUlnVkxTL0Z6djh5TThvUVUvbHVneUp0QVlX?=
 =?utf-8?B?dm4vSnBaWHhMUVhmOUNhM2pKdi9GczZMbUlQdE5RMnFjWkdEOEJSc1FZcHI2?=
 =?utf-8?B?M3lqRDUrNmlWN0JiTmJ6alpldGRtRzhWOGNRcERLbi85aU9kOFRGeHhQWVZj?=
 =?utf-8?B?WU9ZU1JMTDRMRkl5KzlzMHM4akZBV2J0NzFCWWl0aDdtTnU1VnFMci9idFpM?=
 =?utf-8?B?L09ZODJHOGRWYi95S21WQnk1d096M2ZnRTZUSFV1ellvTHNxWmpqOHlhZlFn?=
 =?utf-8?B?MHhTRUdOak4zRGVBZjZiTjFzYVd3NE4vRkY0b2Q5cVBEdHhJZnRuZ2VaKzcr?=
 =?utf-8?B?ZzJxbkxPK1BIVGlteG1nZEpMdm9mU1JIMkdyL29mME9zaHoxcGUrYWNjN0t2?=
 =?utf-8?B?amcwbU1zdWNZblBudE96WisrejNPbk92UEp4eG1wRll4QnZNdk9DVHJ1WERr?=
 =?utf-8?B?SUIxcnVJcklybVI1bTZkRzZ4ODVTWGREMUJKMU5RSjYzT3Ezam42L2JjU0hv?=
 =?utf-8?B?ZDhRR1VXVlpEeVIrUFIreHFOSFlTRGpTMGM3WWpkcENWS1M1b2loSlg1Vml4?=
 =?utf-8?B?bjJjVWFyKzY3VE5pdGJKQ3ZDQjk0M2VPWUVMcEdpTytpMEVqSEtUZitraGNZ?=
 =?utf-8?B?NkQ4RnlEZ0R2WVBLeXBRMHZha2IyaEJneGpqTFIrd3pYcm16QW9yK0dnM29N?=
 =?utf-8?B?K1V2MHNvZWtKZmlxbGdKcnBJTElYdnBQbk8rL09IbHltQXVzendpQmtZdFdT?=
 =?utf-8?B?UW5ZOUtyMmVnTFVLclBMbklVcWlPNGZFZ0MxemsyWXJMM21HVnNZcWhTREds?=
 =?utf-8?B?TG1paFIvRDY3SDY5MFJ6TFdndTYxWGdsZThFS2J5NHNsSmJzbzI0ZlY0WU9H?=
 =?utf-8?B?RnAwZmVmcEhNbmdnZzFOQjlWanNUbXlqZURwWDc4NGFCeGhaYzE0UUl0TWVz?=
 =?utf-8?B?TlJ4N0hEbDRaNmlmNFRydjF5OEpoZXQvQTF2YWpwSjF4L2lzNC9YRS9DbjVW?=
 =?utf-8?B?N0pzTGY1Y3A4Z3ZrQWpsSjVIQWhaWlVTdEFDRXRCeWtUK2RLVDBhVHIwM3I2?=
 =?utf-8?B?QTJXZThqQVRsNGdNTXMxeE16LzhuZFhDQlYrOTh6dUZJbWVGSWZMaVhrVitK?=
 =?utf-8?B?LytXMWxMNnNKa2VGc0FQTjFiU05lN1RDRElwUHdSTXQvWGdrdGJOcVFLWkpN?=
 =?utf-8?B?U0VzN0VybTVUOHVRTGxuZ2VQTFNTbFBmYi9YV2JmZWZZL0E4TEtORldlaDZa?=
 =?utf-8?B?UHZpTWpwejAydVFQNThWSmR3bFo2OFg0YkZJSFFrdTFMUkpyejlMWFdWQm1n?=
 =?utf-8?B?TU9JRExRYjBtRkpSUWR5MTFIR2NCQjI3RHFneHNwRVRCZEFFZ0lUK1NFdGti?=
 =?utf-8?B?TXEyRjd0MTlqeW90VWhyVFFSK1NTbk5qOVppMjVkTU53TndVZzFTL2g2eFNK?=
 =?utf-8?B?RW52ZEJXVHN5V1N4bTVIZDJrU3BVSEtJTjZ0R2hqMS9yUVZKbW9wa28xVGJo?=
 =?utf-8?B?V0lHaVhQZHhUUDM5Um5XSVNxM2RYeHVrdEFUdlhORmYxQmcrMEh6eEdOdXQ4?=
 =?utf-8?B?YUdUeUsvaUJEaVJyY0liQWhIOThkSEdBWHgxWGkvclQwM2U0VWlqQTBFMVcv?=
 =?utf-8?Q?Ctb+E5WzwofKcEtHWgn3v5t5u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8cd1cf-08cc-463f-ff06-08dd985d5ba4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 11:48:09.4596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lbMQ+FCIetykEtL6Sp9Ky1Hb4cFquf3ZOdzC8k0Av7yptSdWNFP/1YaYBMNb6+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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

On 5/21/25 11:49, Pierre-Eric Pelloux-Prayer wrote:
> Using the drm_printer interface will allow us to use these functions
> when generating the coredump.


This change in general is harmless, but you must be extremely careful to not grab locks in the core dump which somebody could hold while waiting for a reset to complete.

For example any BO lock is an absolute no-go.

Regards,
Christian.

> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 38 +++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 42 ++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  5 +--
>  6 files changed, 52 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 8e626f50b362..15ccb0eeb78e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1773,12 +1773,15 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>  	struct amdgpu_device *adev = m->private;
>  	struct drm_device *dev = adev_to_drm(adev);
>  	struct drm_file *file;
> +	struct drm_printer p;
>  	int r;
>  
>  	r = mutex_lock_interruptible(&dev->filelist_mutex);
>  	if (r)
>  		return r;
>  
> +	p = drm_seq_file_printer(m);
> +
>  	list_for_each_entry(file, &dev->filelist, lhead) {
>  		struct amdgpu_fpriv *fpriv = file->driver_priv;
>  		struct amdgpu_vm *vm = &fpriv->vm;
> @@ -1793,7 +1796,7 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>  		r = amdgpu_bo_reserve(vm->root.bo, true);
>  		if (r)
>  			break;
> -		amdgpu_debugfs_vm_bo_info(vm, m);
> +		amdgpu_debugfs_vm_bo_info(vm, &p);
>  		amdgpu_bo_unreserve(vm->root.bo);
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 2c68118fe9fd..35457f44a089 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1141,12 +1141,15 @@ static int amdgpu_debugfs_gem_info_show(struct seq_file *m, void *unused)
>  	struct amdgpu_device *adev = m->private;
>  	struct drm_device *dev = adev_to_drm(adev);
>  	struct drm_file *file;
> +	struct drm_printer p;
>  	int r;
>  
>  	r = mutex_lock_interruptible(&dev->filelist_mutex);
>  	if (r)
>  		return r;
>  
> +	p = drm_seq_file_printer(m);
> +
>  	list_for_each_entry(file, &dev->filelist, lhead) {
>  		struct task_struct *task;
>  		struct drm_gem_object *gobj;
> @@ -1170,7 +1173,7 @@ static int amdgpu_debugfs_gem_info_show(struct seq_file *m, void *unused)
>  		idr_for_each_entry(&file->object_idr, gobj, id) {
>  			struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
>  
> -			amdgpu_bo_print_info(id, bo, m);
> +			amdgpu_bo_print_info(id, bo, &p);
>  		}
>  		spin_unlock(&file->table_lock);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 3339703f40b7..568c2cd95703 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1553,27 +1553,26 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>  	return domain;
>  }
>  
> -#if defined(CONFIG_DEBUG_FS)
> -#define amdgpu_bo_print_flag(m, bo, flag)		        \
> +#define amdgpu_bo_print_flag(p, bo, flag)		        \
>  	do {							\
>  		if (bo->flags & (AMDGPU_GEM_CREATE_ ## flag)) {	\
> -			seq_printf((m), " " #flag);		\
> +			drm_printf((p), " " #flag);		\
>  		}						\
>  	} while (0)
>  
>  /**
> - * amdgpu_bo_print_info - print BO info in debugfs file
> + * amdgpu_bo_print_info - print BO info in printer
>   *
>   * @id: Index or Id of the BO
>   * @bo: Requested BO for printing info
> - * @m: debugfs file
> + * @p: drm_printer to use
>   *
>   * Print BO information in debugfs file
>   *
>   * Returns:
>   * Size of the BO in bytes.
>   */
> -u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
> +u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct drm_printer *p)
>  {
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct dma_buf_attachment *attachment;
> @@ -1623,31 +1622,30 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>  	}
>  
>  	size = amdgpu_bo_size(bo);
> -	seq_printf(m, "\t\t0x%08x: %12lld byte %s",
> -			id, size, placement);
> +	drm_printf(p, "\t\t0x%08x: %12lld byte %s",
> +		   id, size, placement);
>  
>  	pin_count = READ_ONCE(bo->tbo.pin_count);
>  	if (pin_count)
> -		seq_printf(m, " pin count %d", pin_count);
> +		drm_printf(p, " pin count %d", pin_count);
>  
>  	dma_buf = READ_ONCE(bo->tbo.base.dma_buf);
>  	attachment = READ_ONCE(bo->tbo.base.import_attach);
>  
>  	if (attachment)
> -		seq_printf(m, " imported from ino:%lu", file_inode(dma_buf->file)->i_ino);
> +		drm_printf(p, " imported from ino:%lu", file_inode(dma_buf->file)->i_ino);
>  	else if (dma_buf)
> -		seq_printf(m, " exported as ino:%lu", file_inode(dma_buf->file)->i_ino);
> +		drm_printf(p, " exported as ino:%lu", file_inode(dma_buf->file)->i_ino);
>  
> -	amdgpu_bo_print_flag(m, bo, CPU_ACCESS_REQUIRED);
> -	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);
> -	amdgpu_bo_print_flag(m, bo, CPU_GTT_USWC);
> -	amdgpu_bo_print_flag(m, bo, VRAM_CLEARED);
> -	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
> -	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
> -	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
> +	amdgpu_bo_print_flag(p, bo, CPU_ACCESS_REQUIRED);
> +	amdgpu_bo_print_flag(p, bo, NO_CPU_ACCESS);
> +	amdgpu_bo_print_flag(p, bo, CPU_GTT_USWC);
> +	amdgpu_bo_print_flag(p, bo, VRAM_CLEARED);
> +	amdgpu_bo_print_flag(p, bo, VRAM_CONTIGUOUS);
> +	amdgpu_bo_print_flag(p, bo, VM_ALWAYS_VALID);
> +	amdgpu_bo_print_flag(p, bo, EXPLICIT_SYNC);
>  
> -	seq_puts(m, "\n");
> +	drm_puts(p, "\n");
>  
>  	return size;
>  }
> -#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 375448627f7b..f411a8c3199c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -139,6 +139,8 @@ struct amdgpu_bo_vm {
>  	struct amdgpu_vm_bo_base        entries[];
>  };
>  
> +struct drm_printer;
> +
>  static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
>  {
>  	return container_of(tbo, struct amdgpu_bo, tbo);
> @@ -345,8 +347,9 @@ void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
>  #if defined(CONFIG_DEBUG_FS)
>  void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
>  					 struct seq_file *m);
> -u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m);
>  #endif
> +u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct drm_printer *p);
> +
>  void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
>  
>  bool amdgpu_bo_support_uswc(u64 bo_flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3911c78f8282..327ce9e883cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2990,16 +2990,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  	return false;
>  }
>  
> -#if defined(CONFIG_DEBUG_FS)
>  /**
>   * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
>   *
>   * @vm: Requested VM for printing BO info
> - * @m: debugfs file
> + * @p: the drm_printer to use
>   *
>   * Print BO information in debugfs file for the VM
>   */
> -void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
> +void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct drm_printer *p)
>  {
>  	struct amdgpu_bo_va *bo_va, *tmp;
>  	u64 total_idle = 0;
> @@ -3017,74 +3016,73 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>  	unsigned int id = 0;
>  
>  	spin_lock(&vm->status_lock);
> -	seq_puts(m, "\tIdle BOs:\n");
> +	drm_puts(p, "\tIdle BOs:\n");
>  	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>  		if (!bo_va->base.bo)
>  			continue;
> -		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
>  	}
>  	total_idle_objs = id;
>  	id = 0;
>  
> -	seq_puts(m, "\tEvicted BOs:\n");
> +	drm_puts(p, "\tEvicted BOs:\n");
>  	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
>  		if (!bo_va->base.bo)
>  			continue;
> -		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
>  	}
>  	total_evicted_objs = id;
>  	id = 0;
>  
> -	seq_puts(m, "\tRelocated BOs:\n");
> +	drm_puts(p, "\tRelocated BOs:\n");
>  	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
>  		if (!bo_va->base.bo)
>  			continue;
> -		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
>  	}
>  	total_relocated_objs = id;
>  	id = 0;
>  
> -	seq_puts(m, "\tMoved BOs:\n");
> +	drm_puts(p, "\tMoved BOs:\n");
>  	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
>  		if (!bo_va->base.bo)
>  			continue;
> -		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
>  	}
>  	total_moved_objs = id;
>  	id = 0;
>  
> -	seq_puts(m, "\tInvalidated BOs:\n");
> +	drm_puts(p, "\tInvalidated BOs:\n");
>  	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>  		if (!bo_va->base.bo)
>  			continue;
> -		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
> +		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, p);
>  	}
>  	total_invalidated_objs = id;
>  	id = 0;
>  
> -	seq_puts(m, "\tDone BOs:\n");
> +	drm_puts(p, "\tDone BOs:\n");
>  	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
>  		if (!bo_va->base.bo)
>  			continue;
> -		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
>  	}
>  	spin_unlock(&vm->status_lock);
>  	total_done_objs = id;
>  
> -	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
> +	drm_printf(p, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
>  		   total_idle_objs);
> -	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
> +	drm_printf(p, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
>  		   total_evicted_objs);
> -	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
> +	drm_printf(p, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
>  		   total_relocated_objs);
> -	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
> +	drm_printf(p, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
>  		   total_moved_objs);
> -	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
> +	drm_printf(p, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
>  		   total_invalidated_objs);
> -	seq_printf(m, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_done,
> +	drm_printf(p, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_done,
>  		   total_done_objs);
>  }
> -#endif
>  
>  /**
>   * amdgpu_vm_update_fault_cache - update cached fault into.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f3ad687125ad..0bf9ea018eb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>  struct amdgpu_job;
>  struct amdgpu_bo_list_entry;
>  struct amdgpu_bo_vm;
> +struct drm_printer;
>  
>  /*
>   * GPUVM handling
> @@ -598,9 +599,7 @@ void amdgpu_vm_pt_free_work(struct work_struct *work);
>  void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>  			    struct amdgpu_vm_update_params *params);
>  
> -#if defined(CONFIG_DEBUG_FS)
> -void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
> -#endif
> +void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct drm_printer *p);
>  
>  int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  


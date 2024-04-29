Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E12C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0673610E363;
	Mon, 29 Apr 2024 14:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E4rN8wxF";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5632C10E363
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFaoY6e+WGvT+MxXs4SshsGKrt/HJk39r0Kz71YEdUgNgj382XE5T8ESFGiyZIuraB2G/QfU3pvE7w43mZCUW7u1FYEiOf6wCJS6mAwIg+WX7WDERwIkchlcrdjsZfNQAVy/IN+pC5uWkYH3I0pauWx1N53nu3oW17kXb4GG29Fa9Q4NQ2TasPqfIwvDZ03c6mRzGZO8RAWZ9hP8G8nHuT97mv+m28pLT7UmxUvZX31L0hC1l2c8JghvaZ6+oOx+f1V3IOOJlBu0X9KIpWs3M2+pO/qZOTt0MdHn3msVRDJmct3s5sTo7NpL8+yQYn+bTFM6EqLjJdmK0+pDlcICnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41Biv/LlKdfhLGqVRO9scd59lfXjR4NV7QTOSr3En/U=;
 b=PS14SDrHtNAORz0Wzfx7eAJOvZiB9pjIrDnrdelcX7okNgFYVEGe58BicE3wJAlZqvGJne293CzS0kyB9SC9QwRQ4TjGpxf3hKqfyinFaox7fE5h38X4Qu05oaKVj9w91bhJjzripr7dqMVVJE2mvaGYwp4y+9XmDE5R/eDPXm8K/UUeP1yl3HJUhZLKpL7jTh4Jqj4m91t+5uorsOAGZmHwvmYQzhtnBRWICQ2eqYlMtJcyD904FvMw7TXX9WonwLQKNhdaKN31+OJy5XgeVk2g4suhKHC/ltvxOkIm0BKLZ0Dz7M8HhDfEuFth89xf5Zk+YSZs88HfhPNOwL0hCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41Biv/LlKdfhLGqVRO9scd59lfXjR4NV7QTOSr3En/U=;
 b=E4rN8wxFNPsJhTRMeU47ogdrbBrI6HFlgB7WSJstGAzku9oaZJC6Awmiss656OWBBrTOLzynlVzea2MQymG7ZPl8y+4Gj7uD7drH10MFzVIWrZQ5lLfM/CUpouLgobQAA4kMzPLGGFOUiI1yBf7P1KQjudLtydkQw5nnWtHqXmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Mon, 29 Apr
 2024 14:43:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:43:07 +0000
Message-ID: <fa1f5d0f-700c-42cc-81bb-69702abb5b91@amd.com>
Date: Mon, 29 Apr 2024 10:43:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix pinned GART area accounting and
 fdinfo reporting
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com
References: <20240426164355.1563-1-tursulin@igalia.com>
 <20240426164355.1563-4-tursulin@igalia.com>
 <a60dede1-8e81-4c79-8058-257391930621@amd.com>
 <fe80a8db-3ece-4818-8b23-2ccf5293a6c2@igalia.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <fe80a8db-3ece-4818-8b23-2ccf5293a6c2@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0033.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f36a1f6-3ea6-47e4-3f2c-08dc685aaf08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1NuVWVZT2drQ0dVdTFVVndyeVZvVGVZZ21kMncyVmpxVW5Xb1hmcmc0TURD?=
 =?utf-8?B?bWhvcTBkSFpwdjlpR3B0c1o2MTFic1RCamRXeFNYcnNPSE82UCsrbHhKOTVk?=
 =?utf-8?B?TTZrTkJMSjN4eE45SXJSYWxuRGhBR2xlL1Z3dk1UZ3h5K0VldWh5Yjdpbi9v?=
 =?utf-8?B?UnA4ZmtOcVRMeko4bWx6RzArUjd5VG5PY2ovZkdzZ1lCZHFWMXYyTy9kb1pl?=
 =?utf-8?B?YTVMUklMNDV4aXVwSnczbnR6K0l6WS8rdUNyamh6OUIxQ1ZVZGhNZk5QQk5r?=
 =?utf-8?B?bWZLY2I3WmlwelAyaFNKa0NTZllSTnMvelh3VUZwT3FsdTZjWis1bjRDOXhD?=
 =?utf-8?B?c1pqSlNzMHBqazdDd0M1b09EOGoyT3BlUTVZS3krek9aWThlVTAzM3dIQjBC?=
 =?utf-8?B?aTlhMTZCQW9rdjBiakx6WnFjRDBxRHpGQlFqck5XT09jQ3BWQmdHR293ampQ?=
 =?utf-8?B?cmQyRkxFaGg2eUVHUm5tcWI3UHUzRUpOVi9PL0Y4c0picERxM1VFZmt2SVNR?=
 =?utf-8?B?SzFYRlIvNVpZeUE1dEJkN3MyRDkrTXJDM2RuTjVwYVNKQWY5eHNWWXBwRnNK?=
 =?utf-8?B?N3ZNREx6bllHWlFFTEd5VHRMQ0RBQXRORlpMMGdsMWRYM0FpbUJZOUQvVkdO?=
 =?utf-8?B?WlZjN21QdDRlcWsvTVFIc0hJdUpZQ1pGY0dORlo4OXh4RnA3d1FZRytDeVVn?=
 =?utf-8?B?U292eWJiWjBmNW45UzZseFc2R3pwYkc1VDFEYlB5cWZmaUJDeG9VNER2eXlw?=
 =?utf-8?B?c3o2Y3h0Vk13NVlKNEZMQWVRQVdjNTZUQ3FseHpSRVhGQkJ5anFobVJQMC9H?=
 =?utf-8?B?anE2aTBlM05pSW9jL09pWHJUNVFMZm5hczM4WEROSTNZc2lzbTFMVVRaSGxU?=
 =?utf-8?B?aW43R1pPZWJiOEFnSFg1WGxtNXNjR1N5ZllsMEsvWEllQUVrdVhQMEZJdzZB?=
 =?utf-8?B?UWRZUzFFUEpVcUkwcmRMMzc3ZWdUd3ZsdlpGaHFxalRXUzhWbFdqZVhYVGh4?=
 =?utf-8?B?Q1J6SlVRYUkxNFA1YmlvakxNeTU3alZMWDRxZU5GTERVUE96Z2E3VG0vaTZG?=
 =?utf-8?B?S1MrdTE1SjNGYUs0SkxMUTgzNjVWbU9tcGovRGRadG9TSk5jaHNjQ2NaWjFs?=
 =?utf-8?B?U3kvN3IxcjByYTVRREwveXpXZFBYVFhyL09JUXFCeTVWQWM5cDYzN3Z0cTdF?=
 =?utf-8?B?c3R2aFlJZ1A2eStDQVRBa0plSVZJOHNpVHo1MVdBQ1cydnVnUTB6R2RKK2tt?=
 =?utf-8?B?NEY5am1OZlNZckRaaHhVNnF1RG9HYmFtSUhjWXdKL1FzOWtxK1lqZDY1RUFh?=
 =?utf-8?B?ZzN0YmRjWFlVcEh2bWQwbFpLZDRBVk9Ia0xpZk9hRUluQ29zZTcwN0ovZHpu?=
 =?utf-8?B?cVBiTDdZVzRoWngwZmRqckpKUmtZRkNmdjBWWTFyMXVqLzZXRDZLNmZwbDNP?=
 =?utf-8?B?SmxvUmNQa3d2azlTV1lqTTZ5SnIvZVlWcHhpTUJkQ08xdEFSZGdneW40bXha?=
 =?utf-8?B?L3E2eEUvRzkyajNkQjh4NWlkRE5XWEZ5cVp4TkloZzlFMjR0VncwbHdKT1li?=
 =?utf-8?B?RXYzWVRxUUpNQ1JlcGNkQ3NwdXI4eTZxS25YUWZrZFFXZExUYTlrRXNQUS84?=
 =?utf-8?B?NUJValNBeEJadHlzUXVDZG45c1VhUHE1NTRFanVUU09kM3h2N0NRbGc1eFYw?=
 =?utf-8?B?TzF6TFpQczM1QUs2M2RvSTV4RWNIMmZCRGJjVVNJdUNGWHg5dGRIV0hBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVhxTGZoMUFMMVJsZVBWTjE0eTFFZ2QrQXgzUUFwUm5IaytMRzNrbjZrV1Bw?=
 =?utf-8?B?ckZlekdRcmRSSlJhbFllSU1sakkwL3o3ZHROaytOR2RrMHJMU1dhaW0zVm5t?=
 =?utf-8?B?UGs5dTV0a3dSeDZ3U1J3MTF2SllsNGwxM3REaFR0TEdYd3B0WE5sSDU2bE1W?=
 =?utf-8?B?NHVLVE1ZUkVDQjk1eFp6WWRLVGxNdGlpRWYvQ0JndThsd2hsY1ZHZ0UzT3c1?=
 =?utf-8?B?MWRlQ1BUdXBWNEQwT2p3anJJOGhHVzFSSldHdVZXNHBPZUp5L0gvQzRyQXNR?=
 =?utf-8?B?eVRBZ21FMUszLzZaNHRMLzd4VWJYekllcW14UG5NejdrV21hT3ZwUWV2Nis1?=
 =?utf-8?B?L1h6ZEdPM2JiNC9vejFyZm1WUVU1S1JVck1CY01EcGkzeWlTOWNQeXJtNDU4?=
 =?utf-8?B?cmx4Zm1SL3ZKT3JreUlNZVczVUFTUmt4UDRtWE5QRkFFV0lQbHpOY2FSVHJv?=
 =?utf-8?B?S20wNjVDNGNtK1VSY3JvdHRkVExhU3ErRXFJYlZqTTA0czYxY25HYjk2WThk?=
 =?utf-8?B?Uytjd0dPZEd4QldpZGJSb1ZsN2RhSk0yWDNMRzhSSmVzTTJxdkQzZWVqc0lS?=
 =?utf-8?B?K3ZwbllNdmM0RUl1clVkVHhyWDZ5UFMzM0FOTUw1MTduSTNHcGdVVnV5dUY1?=
 =?utf-8?B?U240b2lUelQwZ1hha2ZpRDRZWVdEOFBibzk4M0dsVXlMSmRjK2NEKzV0WU9U?=
 =?utf-8?B?WTk5c0VMdzZEbFU1UWd5TFhQV0dPbzdBQ0UwaXNkampYLzRRQnZJNTg1QzRx?=
 =?utf-8?B?REVkVkFnY2lGdmdpb0dtRVNCVG5IbkVOWjUwVTZaQnQzRElTbUU4L0xnVkY4?=
 =?utf-8?B?WWFVZzNmRExFMHBjYXBOMktKM3NTZ2VmYzRzeG84OG83Q3QyWGpMK1JnWTNC?=
 =?utf-8?B?RXpJYXQyRWFFM3VjMzE2Q2k1MmVZdG5XajlVMTZEWkd6Q0VhUXhOTXZBZHJL?=
 =?utf-8?B?SkFZbEZ1b1NVT1RHcHFJclB0M2tDdVRRYksxVW5PSzVIQStwRWRFQjl3NEQr?=
 =?utf-8?B?b0M3TlVXMnhqWmcyVnZvUy9IVzNCNmU0RU9lZHJkc1h0aUNBYVhJNkphUUF4?=
 =?utf-8?B?bmI5ejUxTkQxcTJGZS9HN2liNFUwYXhoZHo2VjYvVFVEQTlOT2lDdWMzb2Qx?=
 =?utf-8?B?cDhaVlpNT2lYZUpkQUtBbFRWK0hjTHBINzYyZURaUEFENTRRQVVPbTdVYnRY?=
 =?utf-8?B?WTRZeXYwUGpoMEdnWmVFc0l1T05JOXVxZU80WjUwSnRBV1hGZWhPRjFnR1lQ?=
 =?utf-8?B?Umt3Q0swT0JJZ2didmlCYzVQb0ltRC83MGNiYXl5YkZSSytBM1oyTmpwUS9o?=
 =?utf-8?B?eWY4TENDaFJ4V2ZpN1QrekU4dzdFenhUY1RYSzlPMVR0ZzVjakN5Z0lCMVZR?=
 =?utf-8?B?Q2xDNjB5RG9ETjJ0eXpoK2FEVzUzcll5YkVYdGtxM1grd1VIOEVFRTMzN2ps?=
 =?utf-8?B?eStHVFN3OXhkdjZkZTNGK1hRZVh0cGJ6TVBQNUtkUWxYMGtHazFGeWNvK0hs?=
 =?utf-8?B?TWdIam03Unc0N2YwRmp0RjBDMTNUL21HcXJKb0V6cmR6L3I0NUQ0eS9rdk5Z?=
 =?utf-8?B?MU5ocEtLWVFQd0xmWmRZUzdoelBYV1NYRjZ1UXRKOWdSeHl3Rjd0dWdlS1E0?=
 =?utf-8?B?TTMwYU1ldTJ0eUlNT1dTZEVsbVUrRzBZUVZrc0d3R1FxSFNWMVJlZDJzT1VO?=
 =?utf-8?B?UjFWOGN0bkFBNTVlaHN4Ti9YdkZpekxlVElvYjdrV1dEL0lnWngxS1Nzamp2?=
 =?utf-8?B?NDlrUW5ZSmhmbjduRjcvVWovaXlzWXQwUmloei9GMVAvaGZsVTViTmdNYjZE?=
 =?utf-8?B?N25ZcXhvaU9IZEVuNDkrRTBKMHgwN1pPdll5SjVqSi9NbW5NNU9zWExPN3lH?=
 =?utf-8?B?amdCWmRSVkJRZ0E0MncybHNtd2xDTDU2MnpOWld0N24wdStMT0JLc3ExcDVQ?=
 =?utf-8?B?VVhSU0dEUlcwRTAzejd1S2k4TmlmeTNmK3ZZNHRScWdXb1hXYVhvWGhTQTU2?=
 =?utf-8?B?dGxPWExKUnRoZFAwTnVYZFBzeVRmSDJMNHZhSlNKd3YwOHZ6N0NBWDFYT2tN?=
 =?utf-8?B?T0xPdmRTN0tLU29PTUFvazh4SUpUTmZDYnFUYnhwL3ZTVkhZNURORDFOaUhp?=
 =?utf-8?Q?cLaN7kpCISVCQf6IVceqiiTdW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f36a1f6-3ea6-47e4-3f2c-08dc685aaf08
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:43:07.4086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eD4UEKPmzytuQVgDNqP2wjkdzoPPcLKmcoinntmF4O5ywIck7gOOJZBybSiI5QGVXVHZUW7D2Uqqu/3rnhzqOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
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

On 2024-04-29 5:43, Tvrtko Ursulin wrote:
> 
> On 26/04/2024 23:24, Felix Kuehling wrote:
>>
>> On 2024-04-26 12:43, Tvrtko Ursulin wrote:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>> When commit b453e42a6e8b ("drm/amdgpu: Add new placement for preemptible
>>> SG BOs") added a new TTM region it missed to notice the conceptual
>>> imbalance in GART pin size accounting as done in amdgpu_bo_pin/unpin.
>>>
>>> That imbalance leads to such objects getting accounted against the
>>> resource, but are not un-accounted when unpinned.
>>
>> AMDGPU_PL_PREEMPT is mostly used for userptr BOs, which cannot be 
>> pinned. In any case you should make sure that the accounting is 
>> consistent between amdgpu_bo_pin_restricted and amdgpu_bo_unpin. This 
>> patch breaks that consistency.
> 
> You mean amdgpu_bo_pin(_restricted) and amdgpu_bo_unpin do not run for 
> such objects, or something else?

Right. amdgpu_bo_pin_restricted will return an error for userptr BOs:

         if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
                 return -EPERM;


> 
> If they run, then at the end of pin there is:
> 
>      domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> ...
>      } else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
>          atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);

You changed that in your patch 2:

-	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
+	} else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
+		   bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
  		atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
  	}

I was suggesting you just change this in patch 2 like this, so it 
matches what's done on unpin:

-	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
+	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
  		atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
  	}


> 
> And unpin has no handling for AMDGPU_PL_PREEMPT.
> 
> Ah I see.. does it rely on amdgpu_mem_type_to_domain returning 0 for 
> AMDGPU_PL_PREEMPT? My confusion was I misread the pinning check as 
> checking the domain as stored in the bo at creation time.
> 
> Although I am still confused by the statement userptr BOs are not 
> pinned. It is not needed to map them via GART on AMD hardware for GPU to 
> be able to access them?
>>> Fix by extending the accounting criteria in amdgpu_bo_unpin.
>>>
>>> What also aappears needs fixing is not reporting their size from the
>>> amdgpu_bo_get_memory, which is used to implement fdinfo stats, so 
>>> they are
>>> not mixed with the regular userspace created and driver owned objects.
>>
>> I think that's true. It's a very fine distinction. AMDGPU_PL_PREEMPT 
>> does use system memory and it is GPU accessible, just like GTT. The 
>> only difference is, that it's not subject to the GTT limits because 
>> their eviction is handled by callbacks other than TTM evictions and 
>> doesn't need to wait for fences.
> 
> As in you think those two hunks of the patch are correct?

Yes. It seems, Christian agrees but wants to show preemptible memory 
separately in debugfs instead of not showing it at all.

Regards,
   Felix


> 
> Regards,
> 
> Tvrtko
> 
> 
>> Regards,
>>    Felix
>>
>>
>>>
>>> And also amdgpu_bo_print_info for debugfs reporting.
>>>
>>> Note that the patch depends on the previous one which broke down the
>>> relevant checks from the domain based to placement based.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Fixes: b453e42a6e8b ("drm/amdgpu: Add new placement for preemptible 
>>> SG BOs")
>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index fb984669fc3a..5a2bbc793953 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -1032,7 +1032,8 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
>>>           atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
>>>                    &adev->visible_pin_size);
>>> -    } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>> +    } else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
>>> +           bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>       }
>>> @@ -1298,7 +1299,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>>               stats->vram_shared += size;
>>>           break;
>>>       case TTM_PL_TT:
>>> -    case AMDGPU_PL_PREEMPT:
>>>           stats->gtt += size;
>>>           if (shared)
>>>               stats->gtt_shared += size;
>>> @@ -1599,7 +1599,6 @@ u64 amdgpu_bo_print_info(int id, struct 
>>> amdgpu_bo *bo, struct seq_file *m)
>>>                   placement = "VRAM";
>>>               break;
>>>           case TTM_PL_TT:
>>> -        case AMDGPU_PL_PREEMPT:
>>>               placement = "GTT";
>>>               break;
>>>           case TTM_PL_SYSTEM:

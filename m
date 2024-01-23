Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BDEC47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 09:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2DD689FD4;
	Tue, 23 Jan 2024 09:36:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF3889FD4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 09:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODmd1p00cupllJEagy7qmGEIS1DyyCLAFeW0gepLrJcWaAT/+kpgGLVoKMPzFw9oHh6i8Nse09+PCkh/yKUArF1FVja+lKqYaAiqG9o1zi5rk40Ni3s6CkRsDrs+9/XWQ1kaEUSSEL7n+SezuO3SVYskCRc3qwakl63Ky/Zb0XkT7MxXrLrsgfQR4iKOngtryF8L6QQh6L/HhqKxZOHY5T/xlMLH/CHK3TtKiV+S+LWCvd9KffXfP4eXXHoPZIw6/jt7VdLlUB7wmtoaYoaAUWGNeWkjUyj4Bjx/OPQwKTAy57Qz8/nI/JE0ODGujl1PAWdE1ft8EII2De/et+AMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW2vOUJ1kahPtKpbZEeCVSMTOPmmac2O4SQ8WJw3QdM=;
 b=JBeLhRsn9zb1Rvwa8Zz/8/+/21pPsXCU1Skd+AZfUHtnIsn0A1cR7JHIJcKtMmNf/Yqtoyv63MIOHnZWl/vlNAHRY3O94msm4Zk6Wc0NZq6CXH4OKbddmrC7EWYXOPT3hdIy55D/ivkZ50N/cjl/hOXHzVcHT/9YJk68pv0bbyL+AGI1/8Q1gOEL3bFyRqKHa7aCBHrHK95K94OqYShmL3/tScwMIbsYvLel+3H3AQkiZTy0dXnNRdO7+uSfGKDIoLIZqV3QXKxQzoHN1SMgVHeDBW8s7UoARHjMg7wCQKuayNE7DiW4sE+OXMO6xtRc1LGjUaYBaKb56AXRrPpR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW2vOUJ1kahPtKpbZEeCVSMTOPmmac2O4SQ8WJw3QdM=;
 b=R3/xA6psbLm/lPry2XaD5HH3I0WaCIYQHwbC9K3iSiQ/7H1n9x/atvqtQ40huP6DUyW4UFYpkQnScwlZ2ZLXautJITnUYLIjSCN1EVm4/NjePr4AeCC0yJgRwy4FFnpbIHio5h14pHS32Qxo9JlnrdFNSymrdIopQUw5MYGpzDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 09:36:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 09:36:45 +0000
Message-ID: <2906c98e-47fe-4a39-b32d-9d060d571076@amd.com>
Date: Tue, 23 Jan 2024 10:36:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, Friedrich Vock <friedrich.vock@gmx.de>, 
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
 <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
 <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
 <CADnq5_Nb=ruoA2j-mHrQbxHY=yzwGm2kKjDiQ+ajk3urKKLing@mail.gmail.com>
 <42af4788-10bb-4107-bd1a-05f15dc9c1fa@gmx.de>
 <4d3e3c70-3307-4068-9416-613a19f587d4@gmail.com>
 <6590bae2-406d-4f45-a3e9-5dc6653925cf@amd.com>
 <0db29a99-f434-4886-9204-54eafaefa31a@amd.com>
 <60efdecd-0957-4e06-9f1e-7343dff87a8a@gmx.de>
 <098e975b-2271-4f11-9549-40bc2c444a28@gmx.de>
 <d45b23d1-ab1d-4285-8b18-a0eebaa2d871@amd.com>
 <dc8506c4-9114-473e-bfdc-8a24f2264392@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <dc8506c4-9114-473e-bfdc-8a24f2264392@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 97730291-0da9-4d78-ea66-08dc1bf6d02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOjfSSuFxXNavldlQjXMJXgLi5tETCQvJ0eWHY6/+DqFILiGnQPnQeImYguzSPpRnByYVjnYDB/p7Ojhemh2OJHpR9haA2AflHKn8V1fDuQwqig9CPb22jGNw8qXImBu7Hwdr+6/g3nhoM3qnEr19//qfUZQi9wK3zdYVqhXBq4E4ynJUG2YF39CiGZhM5EF8niwpXYPkaEA+LyMIaVpVaiwhtNqBD/Ckef6H896pRH0z/PhA2N/smDgFfdj9lsKEEmRTiHLl3rHfA0FVCvfBqfns1Fv2RkCcMGiBLHfrnAKn/q/gVlbqjgEKoK/mG9oN82Wzt4Lv99miLoxDMUAA0irf4bhbfaGSWT5CTldEkuy9QFUmsdXcYN62DJxV+I+6SXIsPxPjt/hNds3PHbzzub0uL95qM5Sb/JcwRAwg0k8zTc2K8u0dQfNFS79xb64OtlaXq3LbkD0gA49y/2RCLHYtgodbPCjLTT1YAU2Izltka/G7XZG3Jb5FDybUL+RO+uQMTBZEXW23Fc2aHiZucjk0WN3bmKfYN5v8XNkahnspHb0nBHHPJRt7TVIKcxG7JD4If0VW6PodcKibz5Xwi/YV8hys2QnQbWGSyeOJSbjpZyQ7V42jAE4KnhcPMef5dVgdjrnoroC2gCwUKTwlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(316002)(478600001)(8936002)(4326008)(8676002)(26005)(36756003)(6486002)(6636002)(83380400001)(6506007)(6666004)(2616005)(6512007)(31686004)(41300700001)(5660300002)(2906002)(38100700002)(66946007)(66476007)(66556008)(31696002)(110136005)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YldXOWV5SGx4Y2JlaXNCeTBjUTEzVHFseXNGMDFKRkxlWHNMVWRzd1FWWWF5?=
 =?utf-8?B?b1IxYnJ6SnlIRzd1NmRKZXJ2V2V4MnZlUjN1NFJWdXBjQzFZZ05ieVNHeGE4?=
 =?utf-8?B?WG5QZFhGUUc0NjJYbzdydndjTiswV3hDWFBzNGVocXQ4alZQSVNmQkU5bmZK?=
 =?utf-8?B?QUFoZm4vL0E5OGpFLzhaT2pPR2VQSnNOZk1YVFEyL2M0UDYrbjVuazdDMVlK?=
 =?utf-8?B?SDgyY01GU0Z6cEFucHdPN210RVBSMUl5aThTc2U5bXhkaGpVbVYwRGQyemFq?=
 =?utf-8?B?ZXpVclNtZVo2MGowcWJ4eGJiOWMrVHBLb2g2aUViV3pDYm01RmVvOWVlRWJz?=
 =?utf-8?B?N3ZRYzUyY1p4d3pOTy9SU0tQYmhvNGFqWkpwWEMzQVB5M296c1ROemppNWE4?=
 =?utf-8?B?Y2M3YmwxTTlZQ0tnRWcwREs4ejhoZ2wxZ3R5OFNZSm82c3FoOGVpRHNMNVdD?=
 =?utf-8?B?Nkk5dFdETjhOaEJkdmlSY0VFWFg5Y1RTa2JSSG5iUTlRVXRRNFBPMDBlVzYw?=
 =?utf-8?B?TFRIQmp3dHFFSHpmaE1NQ1ZLT0FNa0VuTzBWS2hBd2ZJN3pBUXdoZkM1dnJ5?=
 =?utf-8?B?TUVRcFFQL1pSMUcxRldEYXJ4akhVenVqeUU3QXF2KzRQQzlFbGlyYU14T3ZD?=
 =?utf-8?B?WEJVdHZVTW5Mb2JpZmpabEx1VU5wV3JaZ1VQT3BqeEtqdnBVR2VPQzJ3WkNC?=
 =?utf-8?B?MVZCK1F4cGtPTVd0R2ZYMzIzc21IUVo1cE9ZSkx6RWt2UGZlZ1BxdXFqRW1L?=
 =?utf-8?B?b3I1d2tTU3NlNVE5SFhvdzFhQ290UW1KdW1aNWR5K2xaMUJLY0Z4ZlZodDVN?=
 =?utf-8?B?eHNvSUQ5N2NnSWozY3BGV1lmQ1RyT3kxRmJpYytZejQwMVNQb1lVdTJSbldK?=
 =?utf-8?B?SmV4bzBsTlVhTVVtdkdIVHpEQk9MVElWbWZNZm1rcGlpekZwU1lNOTlhbm1G?=
 =?utf-8?B?ckRqYnhPMmo5R3pNUi9ZZEpmOXJuQTAzRXplNHc3RXRXRHhRdWNpcmZDcXZH?=
 =?utf-8?B?Sytoa3BMMVBBR1UvekFrOCtJOXIvNVNVTVlxMXl4M2pySmttcEdHN3pCQ3Nq?=
 =?utf-8?B?YnJDZXFYbVVyZ2pvK25wMHlqbjZDNFdPUU5CWExpMHVmR0JwSE0vV1R5bHM0?=
 =?utf-8?B?aWdVNk5ETG5TdU9BY084K3R0TjJiWmFHdmlnQmlTeEpNcnlGbHRJSjRYbzIz?=
 =?utf-8?B?ZERtL0o4R3ZPYStlUVZGVUhDSVFJWjE0WUV5THhDbnJTNnNHWENhTUZmTTAz?=
 =?utf-8?B?UjBmTHVuVDRrNHZYY0lGbE56SSs2QWYxdm13QnRXRW1uUW02MUJMbVMwNlk3?=
 =?utf-8?B?SWc0TCtERnVkclJGNW1LUWZCR1pKS2F5TGFlWnhLQnhmNm9ZaHRMQnZCQTVC?=
 =?utf-8?B?WUVRd1h3OTNqdU1sMEFJZXpsaCtIRmpFUlRFZCtrRUdyOHBOelEzbFVTdFB0?=
 =?utf-8?B?aXlaYzlrQ3dyRjB4eHdLd2tsTy9tVkZkejd4bUdsTFZ5Tk10cGRFWVNHRGJa?=
 =?utf-8?B?ckx2dkw5V1p3OU5TRWVqY2xMcjJ3UVA1NVAzVllZR0lPV2g4U2NuMXprd0hD?=
 =?utf-8?B?Q2lKdUF5QVhzbnNuY3YxcWtTbEdzOC9YcERqODNTeDV4M2lYT2dDVnpSMGdk?=
 =?utf-8?B?Qm9YclUxT095bHBEY1BPUG1iUm43VUNjT1NVZlh3ZG9oandpcGJ6M1dmV2ll?=
 =?utf-8?B?ejBXK3lRbUE5WGE0TmZ4N1B3ekM2S1psV2pSMC9WVWNERDg4N0hOclJ3MnRQ?=
 =?utf-8?B?ZUR6Y3lLSUVUZmZXMTA2a3dHZmI1aThVNVVLOEZPNG1ITGkyQUNmT21YK0FS?=
 =?utf-8?B?Q0JLNzR1RGlxVndZd2ZHVkNkK2E0aloyRUxWdmRqaTZjMS91blBVbVBmMFpQ?=
 =?utf-8?B?OFVwYVVZMVYwaFFVcnJQbnp1TFNmMUdyL0VQMEFpaVNnUjFlbE4rLzg1a3Fa?=
 =?utf-8?B?dHRPUmlvQlJxazBlNE5LK3J1K25CKzJBT1h3SHV3UWI4QW42OWRCNkJ1RVli?=
 =?utf-8?B?cXlCanRRSUtib1JXQlNsa1BTZGpHSEhaZHIwR3p4OHptNndSNE5iU0JobGZT?=
 =?utf-8?B?WDduSEc2R1M2R3RDU3cwYWZ6R1Z5aWgxTUtiZXR4cGpLazJycVdkYnJ6ZENC?=
 =?utf-8?Q?cbDjTZIRRctOdGJ44rFHQyMG4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97730291-0da9-4d78-ea66-08dc1bf6d02e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 09:36:45.0955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RlApWpoVGQgHG5rbI7UdgTmI6j92fcN92vyrsgN1ejhCBjLOY2KV+IaYc1jvVB2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 22.01.24 um 23:39 schrieb Joshua Ashton:
> [SNIP]
>>>
>>> Most work submissions in practice submit more waves than the number of
>>> wave slots the GPU has.
>>> As far as I understand soft recovery, the only thing it does is kill 
>>> all
>>> active waves. This frees up the CUs so more waves are launched, which
>>> can fault again, and that leads to potentially lots of faults for a
>>> single wave slot in the end.
>>
>> Exactly that, but killing each wave takes a moment since we do that 
>> in a loop with a bit delay in there.
>>
>> So the interrupt handler should at least in theory have time to catch 
>> up.
>
> I don't think there is any delay in that loop is there?

Mhm, looks like I remember that incorrectly.

>
>     while (!dma_fence_is_signaled(fence) &&
>            ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>         ring->funcs->soft_recovery(ring, vmid);
>
> (soft_recovery function does not have a delay/sleep/whatever either)
>
> FWIW, two other changes we did in SteamOS to make recovery more 
> reliable on VANGOGH was:
>
> 1) Move the timeout determination after the spinlock setting the fence 
> error.

Well that should not really have any effect.

>
> 2) Raise the timeout from 0.1s to 1s.

Well that's not necessarily a good idea. If the SQ isn't able to respond 
in 100ms then I would really go into a hard reset.

Waiting one extra second is way to long here.

Regards,
Christian.

>
> - Joshie 🐸✨
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>> Friedrich
>


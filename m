Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D3ACA5FE5
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 21:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EE310E053;
	Fri,  2 Oct 2026 21:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZa0d6ED";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E384710E053
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 21:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCkra4/K8Vax9hdu6EkpgS6nvM1Q12kpaHQFwD/a/4s3jtvAwT3NIHPqKBcLhuqqMPCYQz1RSIUTXfMeicAmeAEE/TdGqVH4xIpkhylALmpeJTZFH1UsZiCRHCoBnq9z4kMIcHl+0wqpRnKOdPQVw6dJlRabN6fPbXET5Xp21lp7V7CYPxCjleHzJ+ZdGVO3PL2weOOBvVSQMAcdKtui/TJIdGR5R156QK3SYWHJ5oyml9a3gb78kFtNMaYHye9F7XB0EAxu0e8jq77y08TAhpqCE7zEF593gxpggjaBSblVbiiQWHM0hCN0HZBdz3DiGzA34r2vQfEOqNCA8Ktm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKXfvKD6UrEWNKhDXrT3b3ddBx0Lozk2mjsvnqZRJWU=;
 b=zMio8/tQHezwJUJveo4A7B07mtsP61a7BVYO+CNNthIogehzqq8qYVeXF235UZAEgv9lvpQG+K5ubszGi68ql7h7PqyldDISWfsy90qqWROQ9qyMTOvdX7AyAiiTWk5TRAzo+0At0UOs7ghheXAnI5/M8Go8xYZYWKokN8J5lzwjoRx0JyhpLDFFZ5+TTg1zuyT4rujblq3Vf/+4IKsx+84be3TlomqlHevSrF0CXdy34w40hZcNe6ud5DLVVcDNCC8JegNY/4WbCHUrsDeCm7Q/KB+4JF3DnZjQgupMOU2JWDQIEssUEd0xoXihkRzWf+5yvXATYM6I/aNFd3p5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKXfvKD6UrEWNKhDXrT3b3ddBx0Lozk2mjsvnqZRJWU=;
 b=JZa0d6EDkptxqwoT/nDhGWn2ZMDTlK975xCH4//Z323py2vCkwdsTM5jf5yXjvTkbzai4TcRbix3qXz5dWH+GWcFd67giIoAVSiUfZVpv5A5W77bBnA8nJyl1MJ1YsOb3PQr4Bgd5803G4je3So2kglibDRbMsHYZVFF+nGsIxg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by LV1PR12MB999327.namprd12.prod.outlook.com
 (2603:10b6:408:3f8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 21:14:22 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 21:14:22 +0000
Message-ID: <36781a5b-b357-4bfb-b589-881bf22a6da7@amd.com>
Date: Fri, 2 Oct 2026 17:14:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/amdgpu: Fix topology device creation and
 proximity domain mappings for sparse and CPU-less NUMA systems
To: Dhruv Bhogaonkar <dhruv.b@linux.ibm.com>,
 Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <cover.1785833981.git.donettom@linux.ibm.com>
 <16887553-76eb-4af9-8769-f77f4fb9fb68@amd.com>
 <b492ee69-86fa-47a2-aecc-e470568d7204@linux.ibm.com>
 <2bde809f-d2d9-4b94-88e3-f8e2ae2cc7b0@amd.com>
 <6b7e68a3-8308-496d-a183-f23be992448e@linux.ibm.com>
 <a7404568-5d4b-4588-950c-28a5225f77d3@amd.com>
 <8e5fccd6-6907-498c-b1a9-39fe15525ee2@linux.ibm.com>
 <00a10239-1e09-470b-8970-db00814af486@amd.com>
 <cafaaba4-7d45-46ef-b0bf-67fe8cfa70ac@linux.ibm.com>
 <067237bd-64b5-4515-a5ba-e3643dd0b9e7@linux.ibm.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <067237bd-64b5-4515-a5ba-e3643dd0b9e7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0270.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::20) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|LV1PR12MB999327:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f5e52e-ee1a-4627-003a-08df20ca20f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9MrNYnyfAaeTK3iFk1nhYFP4MMYgH387hr0ETlhz2nOpffduYBJP+CHnars9jwYlj6go4vATKLpnBEhy3kBmUnteH8KfdS7aTth9sTDzJJjwbQxA0s9+S8HRnRPhezxM56Ji5F+x9SgqUK4B0Ocy7jW4NcGj/RWQQtHi5Q+SGhSFVXIBaFaowroOuSB/bN5Kr8+tQJnYXoOeiApvqc/J2gViXuFcFCQvNZ/2UbJBpWU00Mgi/rd53TvvIy1WNvsbVrFczTGqc3XJ1DcGJpuEAKRhT1yVT1keD8eDVoNQ1+E8g80qDwWZVBcdDE11tg9d0vPITFmI+1acC51CZEhPqqt8nABEWEPWVqkF8++MuRFRQ+gaJ1BTT+4zJKtJHc9aAoVhBiXB/iBtjjo7za37lQG0TSUq2phryRzS7yEDIwkv6rYPnagp4YCJD3OAOlYJ0dgEmuA7ErLLBZxLTItXR+kKeDVe8knKlbzMehov9AvLKibFIVtNp6P1QsmI3Kg8WoDWcP+ymSdtaOAajEK1InYAEVakK+FkQz//6EdEd5SkU5yIvkwfPBCqw6H+frn3w7vxJDgDJi5LxbUGEeOXzKQwDWrJkGCnOtd7ZqEscKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NvQVlnVnNOSThYMFY1Wml4ZGR2akFnY00zZldVa2FKbnRJZkVmY1ZZb3RQ?=
 =?utf-8?B?alhkeFdYUkRiR1VzNllHU05oTkRFMjFNd2pESUprZm1YMXRrY2F4YUg3UE1D?=
 =?utf-8?B?YURCcVQ4djVHYUR3NVZHaUdvczdScFM2Y1pBdmp1SlNjbU9sbUxRSDU0RitF?=
 =?utf-8?B?MnVMZUpCbmpVZWtPWjh3R1hsSGoyR2k1R29yaytTNFFoTlcrYnNNbmZ5MDNV?=
 =?utf-8?B?MjZPQ2VXa01BQWVyWXBUNFYrMjdkMHVDdnExc3FjZWJOOFB5YmozeDBQMlh5?=
 =?utf-8?B?cTVSdnNWMkhkMGtwUDJMTHVlR09xS2dnakdVazd2Z09QZmZGL0Z2T0VTdUNN?=
 =?utf-8?B?cFZtcmVZS2w3Q0hLekFORUl2a0FRbnk5ek5zTHpsSE9tYVoybnhPdjdRbTht?=
 =?utf-8?B?aDl3TW1NaTdjUFZidDd4VjFNMmR1WEQzdTAvcWgyU3Z0WDFxd3hJYkFPc3hC?=
 =?utf-8?B?TFBWN1g3WUJjc3hUNms2S1JZTmZkTkhwSzV6N0d1Mk5xam10QjYzdE5ITW0r?=
 =?utf-8?B?NEEycGxmM21XMFRVL2lFcmNsY2tYQ2RuNmUrQmRQQkpscGZ5d1RkVlZ2NE5p?=
 =?utf-8?B?U0xvdzMxS3ZKbmN1MXpiMld6dWlOaFBpeVVrQUtaUTY4UVlqNDQ1dEhVc2wx?=
 =?utf-8?B?VXBUTmtISXNuaUN0a2haYUphNFI1MnJXU002cTRsWG03YWIxRjJobU45NThr?=
 =?utf-8?B?MUNONFVnVlc0M2owWW9idEEyU2VwODdzR3RWMW5hWHN1anlkTndEdHNVOVp0?=
 =?utf-8?B?Q21PVzArS1ZHN1FUMFJ6ZzJ0R0plN3JnOXB6QTV1UVBCZWR1VEFCdVd0VXRu?=
 =?utf-8?B?UUFncTJYV3hlNWNIMENOOXhDOU53N1VDeGdzci9DV082SGFJbHBGWHhCUUFz?=
 =?utf-8?B?a3A5QlZ3ZjcrOVNoYnpJWS9Vall2bUlvU0ZFMjRYSHp2R2dUQlhkOEd0K2Zs?=
 =?utf-8?B?cFpTV1NGREswUXNNbzM3V28rbWE4b0RTK3JQYTBEUDVhRXF5MkFjSGxqNi9i?=
 =?utf-8?B?QW56ODQ0Q3hNMVllZWZGaU9WTVQrNWFnZktMQXJ2UE9ON3luUXNrTllic09n?=
 =?utf-8?B?bHJHbC9UMldGM0J4TXNTMzVtV0NDVms2dzBhekhmTEQrOGNCcHU2RTF0T08z?=
 =?utf-8?B?bTRrODN5VVFaYm5tcVVTbFIvL3BTRWkxK1lMNnlESHRrZW00REpiU21NZlZk?=
 =?utf-8?B?OTBpL3gwNDc2a0U5K290N2UxUHR4bnFWSGZlS1BLZGVBVi9UU2FyT0pKUlZ3?=
 =?utf-8?B?MkRQdHVNOEhOQlFCQzNFYUxaTmovK0FtM0dDQys2UjREanJ6bjJ5OEg4NUhh?=
 =?utf-8?B?ZGJveXg3MjZIcnFXSGhrQXlGbjkydmdFaXIzNDZpQk1Gckcvc3hVQVJvWHpR?=
 =?utf-8?B?aTJyU0JXMU9sRDBubnc1bHJnODFCOWNmS3M0Q1pkYTllN3ppaUovTEsrVDI4?=
 =?utf-8?B?dWpvdVJackNvYWEzQkFTQnIrQWpVQU8rUmNPaER5YmRiZTlNbWZXc1FvdHRV?=
 =?utf-8?B?cjVHaU1sZW1QTlFaa2tZaWlGNHFkdEtkZmQrVnFNNm5ZUnBvbDJJUkhjVHlr?=
 =?utf-8?B?YkhtcllaUUJnb3NrdzRld01GeVYrZHYvNk9QbGpOdFVuR3BMWm5vd0VaQ0x4?=
 =?utf-8?B?dTRtVTZ1eEVpRkk5U0R3UVBIMXpwclF2ZGprL2ZsR0xZblZ0bUlPUHBtemlU?=
 =?utf-8?B?djdiOS9sT280SkJISytGaVVUU3BGZy9Jb05iajl0dzBZNFAwcVJhbGZDK2xr?=
 =?utf-8?B?VHFFVGE4aFkybkRQSHN5YzIvelJpMHZFdFE3aVh2aXJRSDdpaWd2WUJWQzVG?=
 =?utf-8?B?Zml0bGdoSjBJcmZYcU1yVGppdWNCTE1FUEVxWDZHYkw1MEhOa0lheDNxT1Nn?=
 =?utf-8?B?S3U0NTBtMThuZWRoRXBEdFZjNXBaaG5pcEl3dUEzOTRkSldOWmZsdWJoODdB?=
 =?utf-8?B?TFRLTS8vKy9TTlFGRXM4K1VPckc5VjJrVFhJRnFTajVxdmJqaUkwZWEvaFQ5?=
 =?utf-8?B?Uk9PUzJsWU14VVo1RVBjTFBZM05qWkFlR1BtMXV0czFhb2V3R2RRODBYNGVl?=
 =?utf-8?B?cExqUVUwcTg2citHYXlOREk0OE1sN09INEZsVUF2cVBZbGxDczhsclV4Yjdn?=
 =?utf-8?B?eHZZTjIySEJHelZUd1BUbE82anBQWDNqcnZkQkNlM0ZsRzA3NWxheWxOdjAv?=
 =?utf-8?B?Z0NZVWFJSExWU1o1cFJFckRkbFZHMlNVejZTMWdvZGpCWEdYRkhJYktQZ2dH?=
 =?utf-8?B?amFkMnFKVGlCWWxqUmRRbS9nRDZWRkFlUlRsNHREaU9BR3JVaEFQaTNha0lh?=
 =?utf-8?B?S050cFpRaFhkZmJHQUhUc0JlK3lrRjY2WkVrNFJJaHRLLys2WnA2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f5e52e-ee1a-4627-003a-08df20ca20f2
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 21:14:22.1060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEfIhXylJfuFKSZeyBx4z3AKq2P+Vc4rZa8VygP0Mj2G4V+3IJWducgs8mZ6BeouieWEaWK8U2pVpWSzP2BzIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999327
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

On 2026-09-25 10:13, Dhruv Bhogaonkar wrote:
>
> On 23/09/26 11:28, Dhruv Bhogaonkar wrote:
>>
>> On 23/09/26 04:19, Felix Kuehling wrote:
>>> On 2026-09-22 12:59, Dhruv Bhogaonkar wrote:
>>>>
>>>> On 21/09/26 22:35, Kuehling, Felix wrote:
>>>>> On 2026-09-21 00:56, Dhruv Bhogaonkar wrote:
>>>>>> On 05/08/26 21:46, Kuehling, Felix wrote:
>>>>>>>
>>>>>>> On 2026-08-05 03:09, Donet Tom wrote:
>>>>>>>>
>>>>>>>> On 8/5/26 3:57 AM, Felix Kuehling wrote:
>>>>>>>>>
>>>>>>>>> On 2026-08-04 05:52, Donet Tom wrote:
>>>>>>>>>> This series fixes topology device creation and proximity domain
>>>>>>>>>> mappings in
>>>>>>>>>> AMDKFD when a system does not provide a CRAT table and the 
>>>>>>>>>> driver
>>>>>>>>>> generates a
>>>>>>>>>> Virtual CRAT (VCRAT).
>>>>>>>>>>
>>>>>>>>>> The current implementation assumes that CPU NUMA node IDs are
>>>>>>>>>> contiguous and
>>>>>>>>>> that every NUMA node contains CPUs. During VCRAT generation, CPU
>>>>>>>>>> topology
>>>>>>>>>> entries and proximity domains are created only for NUMA nodes 
>>>>>>>>>> that
>>>>>>>>>> have CPUs.
>>>>>>>>>> GPU proximity domains are then allocated immediately after 
>>>>>>>>>> the CPU
>>>>>>>>>> proximity
>>>>>>>>>> domains, and the GPU I/O link (proximity_domain_to) is 
>>>>>>>>>> initialized
>>>>>>>>>> using the
>>>>>>>>>> NUMA node ID to which the GPU is attached, implicitly 
>>>>>>>>>> assuming that
>>>>>>>>>> NUMA node
>>>>>>>>>> IDs and proximity domains have a one-to-one mapping.
>>>>>>>>>>
>>>>>>>>>> These assumptions break on systems with:
>>>>>>>>>>
>>>>>>>>>> Sparse (non-contiguous) NUMA node IDs
>>>>>>>>>> CPU-less NUMA nodes
>>>>>>>>>> CPU-less and memory-less NUMA nodes
>>>>>>>>>>
>>>>>>>>>> For example:
>>>>>>>>>>
>>>>>>>>>> available: 3 nodes (0,2-3)
>>>>>>>>>>
>>>>>>>>>> node 0: CPUs present
>>>>>>>>>> node 2: CPU-less
>>>>>>>>>> node 3: CPU-less
>>>>>>>>>>
>>>>>>>>>> In this case, the driver creates a CPU topology device only for
>>>>>>>>>> node 0 and
>>>>>>>>>> assigns a single CPU proximity domain (0). However, the GPU 
>>>>>>>>>> VCRAT
>>>>>>>>>> still
>>>>>>>>>> references the NUMA node ID to which the GPU is attached (for
>>>>>>>>>> example, node 3)
>>>>>>>>>> in the proximity_domain_to field. Since no corresponding CPU
>>>>>>>>>> proximity domain
>>>>>>>>>> exists for node 3, the parser cannot find a matching proximity
>>>>>>>>>> domain during
>>>>>>>>>> VCRAT parsing, causing topology initialization to fail.
>>>>>>>>>
>>>>>>>>> Hi Tom,
>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Felix,
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thank you for the explanation and the patch series. I may have 
>>>>>>>>> some
>>>>>>>>> gaps in my understanding that I would like to clarify. In my 
>>>>>>>>> mind, I
>>>>>>>>> was using "proximity domain" and "NUMA node" interchangeably. 
>>>>>>>>> You're
>>>>>>>>> demonstrating that they are not the same thing. Is that just a
>>>>>>>>> different way of labeling the same thing, or are NUMA nodes and
>>>>>>>>> proximity domains fundamentally different concepts.
>>>>>>>>>
>>>>>>>>> Your code in patch 5 (kfd_proximity_domain_to_numa_node and
>>>>>>>>> kfd_numa_node_to_proximity_domain) seems to imply that there 
>>>>>>>>> is, in
>>>>>>>>> fact, a 1:1 mapping, as it assumes that there is a unique
>>>>>>>>> translation in both directions. Am I missing something?
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks for the comment.
>>>>>>>>
>>>>>>>> IIUC, NUMA node IDs and proximity domains are different numbering
>>>>>>>> schemes. We have proximity domains for both CPU and GPU 
>>>>>>>> devices. CPU
>>>>>>>> proximity domains start from 0, and GPU proximity domains start 
>>>>>>>> after
>>>>>>>> the last CPU proximity domain.
>>>>>>>>
>>>>>>>> If the NUMA node IDs are contiguous, the CPU proximity domains 
>>>>>>>> happen
>>>>>>>> to match the NUMA node IDs. However, if the NUMA node IDs are
>>>>>>>> discontiguous, the CPU proximity domains and NUMA node IDs no 
>>>>>>>> longer
>>>>>>>> have a one-to-one mapping.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> If they are just different numbering systems, do we really 
>>>>>>>>> need to
>>>>>>>>> keep track of both proximity domains and NUMA nodes in the KFD
>>>>>>>>> topology? Or would it be sufficient to only track NUMA nodes, if
>>>>>>>>> that's what we really care about in the uAPI (KFD sysfs)?
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks for the suggestion. I also think we don't need to keep 
>>>>>>>> track
>>>>>>>> of both the proximity domains and the NUMA node IDs in KFD. Do you
>>>>>>>> think the approach below would be reasonable?
>>>>>>>>
>>>>>>>> Just to make sure I understand correctly, for CPU devices the
>>>>>>>> proximity domain will be the same as the NUMA node ID, and the GPU
>>>>>>>> proximity domains will start after the last CPU proximity domain.
>>>>>>>>
>>>>>>>> In that case, the CPU proximity domains and NUMA node IDs will 
>>>>>>>> always
>>>>>>>> have a one-to-one mapping, and the GPU proximity domains will 
>>>>>>>> follow
>>>>>>>> after them.
>>>>>>>>
>>>>>>>> For example, if a system has three NUMA nodes and two GPUs:
>>>>>>>>
>>>>>>>> NUMA node IDs:            0   2   3
>>>>>>>> CPU proximity domains:    0   2   3
>>>>>>>> GPU proximity domains:    4   5
>>>>>>>>
>>>>>>>> Would it be okay to proceed with this approach?
>>>>>>>
>>>>>>> Yes, this looks good to me.
>>>>>>
>>>>>>
>>>>>> Hi Felix,
>>>>>>
>>>>>> I have been looking into this issue along with Donet.
>>>>>>
>>>>>> From my understanding, there are three related but distinct concepts
>>>>>> involved here:
>>>>>>
>>>>>> * NUMA node: A system can have sparse NUMA node IDs. For example,
>>>>>>   online nodes can be 0, 2, and 3, with node 1 absent.
>>>>>>
>>>>>> * Proximity domain: The proximity domain is the identifier
>>>>>>   associated with a KFD topology device. In the current 
>>>>>> implementation,
>>>>>>   proximity domains for CPU topology devices are assigned using a
>>>>>>   sequential counter, and GPU proximity domains are allocated 
>>>>>> after the
>>>>>>   CPU proximity domains.
>>>>>>
>>>>>> * KFD sysfs topology node: KFD exposes each topology device through
>>>>>>   a node under its sysfs topology interface. Userspace reads 
>>>>>> these sysfs
>>>>>>   nodes to discover the CPU/GPU topology and their relationships. 
>>>>>> In the
>>>>>>   current implementation, the sysfs node numbering corresponds to 
>>>>>> the
>>>>>>   proximity domain numbering.
>>>>>>
>>>>>> IIUC, the proximity-domain numbering and KFD sysfs topology-node
>>>>>> numbering are expected to correspond, while the Linux NUMA node 
>>>>>> ID can
>>>>>> be a separate identifier that is mapped to the corresponding 
>>>>>> topology
>>>>>> or proximity domain.
>>>>>>
>>>>>> As discussed in the thread, we implemented the
>>>>>> 'NUMA node ==Proximity Domain' approach. However, after implementing
>>>>>> this for sparse nodes, we found that the userspace libraries 
>>>>>> using the
>>>>>> KFD sysfs nodes have an assumption that the topology devices are
>>>>>> contiguous.
>>>>>>
>>>>>> With this approach, discontiguous NUMA nodes result in discontiguous
>>>>>> proximity-domain and sysfs node numbers. This would break userspace
>>>>>> libraries that assume the topology devices are contiguous.
>>>>>>
>>>>>> To support this approach, we would need to make corresponding 
>>>>>> changes
>>>>>> in the userspace libraries, which would break applications using the
>>>>>> existing userspace and introduce backward-compatibility concerns.
>>>>>>
>>>>>> With this in mind, we think the current RFC v1 approach would be the
>>>>>> better way to proceed, keeping the NUMA node IDs separate from the
>>>>>> proximity-domain/sysfs numbering.
>>>>>
>>>>> I'm not sure about this. We have code in user mode that uses the KFD
>>>>> proximity domains as CPU NUMA nodes, e.g. in calls to mbind. E.g.
>>>>> https://github.com/ROCm/rocm-systems/blob/f437a7135fa67b96b48da4baeb72d5f75c406052/projects/rocr-runtime/libhsakmt/src/fmm.c#L2058 
>>>>>
>>>>>
>>>>> So if you change the KFD CPU proximity domain numbers to something
>>>>> contiguous, you're probably breaking user mode either way.
>>>>
>>>>
>>>> Hi Felix,
>>>>
>>>> Thanks for pointing this out.
>>>>
>>>> I think the approach you originally suggested seems to be the 
>>>> better one:
>>>> keeping the CPU proximity domain numbers aligned with the NUMA node 
>>>> IDs,
>>>> including sparse NUMA node IDs.
>>>>
>>>> This will require corresponding userspace changes to support
>>>> non-contiguous NUMA node IDs, but I don't expect this to break any
>>>> existing applications or introduce backward compatibility issues. For
>>>> systems with contiguous NUMA node IDs, the existing behavior will work
>>>> as is, while systems with non-contiguous NUMA node IDs will work after
>>>> the userspace changes.
>>>>
>>>> For example, one of the areas that will need to be updated is here:
>>>>
>>>> https://github.com/ROCm/rocm-systems/blob/2d743306cb341b5973cb0d6af7b549569d127724/ 
>>>>
>>>> projects/rocr-runtime/libhsakmt/src/topology.c#L831
>>>
>>> The code here is already designed to handle sysfs nodes that are not 
>>> accessible because GPUs are not available in the process' cgroup. 
>>> Maybe we need additional fixes here to handle the case where a 
>>> directory is completely missing in sysfs. The biggest problem is 
>>> probably, that user mode tries to remap the node-IDs into a 
>>> contiguous range here: 
>>> https://github.com/ROCm/rocm-systems/blob/2d743306cb341b5973cb0d6af7b549569d127724/projects/rocr-runtime/libhsakmt/src/topology.c#L836. 
>>> We'd need to avoid that for CPU nodes so that we preserve the 
>>> identity mapping from node IDs to NUMA node IDs. Maybe we can create 
>>> dummy nodes with no CPU cores and no memory as place-holders.
>
>
> Hi Felix,
>
> As we discussed, I tried an approach where dummy topology devices
> and corresponding sysfs entries are created for absent NUMA nodes.
> With this approach, the KFD sysfs entries remain contiguous even when
> the underlying NUMA node IDs are discontiguous. Therefore, no
> userspace changes are required.
>
> The core change is:
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index a1087c13f241..80b0242844cf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1879,7 +1879,7 @@ static int kfd_create_vcrat_image_cpu(
>         acpi_status status;
>         struct crat_subtype_generic *sub_type_hdr;
>         int avail_size = *size;
> -       int numa_node_id;
> +       int numa_node_id, last_node;
>  #ifdef CONFIG_X86_64
>         uint32_t entries = 0;
>  #endif
> @@ -1916,8 +1916,14 @@ static int kfd_create_vcrat_image_cpu(
>         sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
> -       for_each_online_node(numa_node_id) {
> -               if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
> +       /*
> +        * Iterate 0..last_online_node so proximity_domain == NUMA 
> node ID.
> +        * Absent (gap) node IDs get a domain slot but no subtypes.
> +        */
> +       last_node = find_last_bit(node_online_map.bits, MAX_NUMNODES);
> +       for (numa_node_id = 0; numa_node_id <= last_node; 
> numa_node_id++) {
> +               crat_table->num_domains++;
> +
> +               if (!node_online(numa_node_id))
>                         continue;
>
> Here, VCRAT entries were not previously created for NUMA nodes that
> did not have CPUs. I made changes to also support CPU-less, memory-less,
> and CPU-less/memory-less NUMA nodes.
>
> For missing NUMA node IDs, we reserve a proximity-domain slot without
> creating any CPU or memory subtypes. Similarly, for online nodes
> without CPUs or memory, the domain slot is still reserved. This
> results in a placeholder topology device while keeping the NUMA node
> IDs and KFD proximity domains aligned.
>
> For example, if we have online NUMA nodes {0, 2, 3}, we reserve:
>
>     proximity domain    sysfs ID
>            0                 0
>            1                 1 (dummy)
>            2                 2
>            3                 3
>
> This allows the existing kernel and userspace code to handle the
> topology without remapping the actual NUMA node IDs.
>
> I implemented this with only kernel-side changes; no userspace changes
> were required. With these changes, the driver loads successfully on
> our system, and all RCCL unit tests are passing.
>
> Could you please share your guidance on whether this approach looks
> reasonable? If so, I can prepare and post a proper patch as soon as
> possible.

Thanks, this looks good. Sorry for the late response, I'm catching up 
with a backlog after I was out for a few days.

I'd be happy to review the patch that implements this idea.

Regards,
   Felix


>
> Thanks,
> Dhruv B
>>>
>>>
>>>>
>>>>
>>>> If you have any pointers or suggestions regarding this approach,
>>>> especially for the userspace changes, I would really appreciate your
>>>> feedback.
>>>>
>>>>
>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Can you point out what specific problems you run into with
>>>>> non-contiguous NUMA nodes topologies?
>>>>
>>>>
>>>> The issue we see on a system with discontiguous NUMA nodes is that the
>>>> GPU VCRAT parsing fails when we load the GPU driver, resulting in the
>>>> following errors in dmesg:
>>>>
>>>>     amdgpu: Virtual CRAT table created for GPU
>>>>     amdgpu: Error parsing VCRAT
>>>>     kfd: amdgpu: Error adding device to topology
>>>>     kfd: amdgpu: Error initializing KFD node
>>>>
>>>> On our system, we have 3 NUMA nodes: 0, 2, and 3, with 2 GPUs attached
>>>> to NUMA node 3.
>>>
>>> OK, that's all stuff that would need to be addressed with kernel 
>>> mode driver patches. I'm hoping it would be a simplified version of 
>>> the patches that Donet already proposed.
>>>
>>> Regards,
>>>   Felix
>>
>>
>> Hi Felix,
>>
>> Thanks for your suggestions.
>>
>> I'll start working in this direction and post a patch once
>> it's ready.
>>
>> Thanks,
>> Dhruv B
>>>
>>>
>>>>
>>>> With the current upstream implementation, CPU proximity domains are
>>>> assigned sequentially. Thus, NUMA nodes 0, 2, and 3 get CPU proximity
>>>> domains 0, 1, and 2 respectively. The two GPUs then get proximity
>>>> domains 3 and 4.
>>>>
>>>> However, when generating the GPU VCRAT, `proximity_domain_to` is
>>>> populated directly with the NUMA node ID. Since both GPUs are attached
>>>> to NUMA node 3, the VCRAT contains:
>>>>
>>>>     GPU0 -> proximity_domain_to = 3
>>>>     GPU1 -> proximity_domain_to = 3
>>>>
>>>> https://elixir.bootlin.com/linux/v7.1/source/drivers/gpu/drm/amd/amdkfd/kfd_crat.c#L2175 
>>>>
>>>>
>>>> Here, the CPU proximity domain corresponding to NUMA node 3 is 
>>>> actually
>>>> 2, while proximity domain 3 belongs to GPU0.
>>>>
>>>> During VCRAT parsing, the I/O link parser looks up this `id_to`
>>>> proximity domain, which is 3, and returns `-ENODEV` because there 
>>>> is no
>>>> CPU topology device with proximity domain 3:
>>>>
>>>> https://elixir.bootlin.com/linux/v7.1/source/drivers/gpu/drm/amd/amdkfd/kfd_crat.c#L1284 
>>>>
>>>>
>>>> Thus, the GPU I/O link is referencing the NUMA node ID as if it were
>>>> the CPU proximity domain, which causes the VCRAT parsing to fail.
>>>>
>>>> Since the parsing fails, the driver does not get loaded.
>>>>
>>>> Thanks,
>>>> Dhruv B
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>>
>>>>>> Would you agree with this approach? If so, I can rebase the RFC v1
>>>>>> series onto the latest kernel and post a new version for review.
>>>>>>
>>>>>> Thanks,
>>>>>> Dhruv B
>>>>>>>
>>>>>>> Regards,
>>>>>>>   Felix
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> I think this approach should also resolve the driver loading 
>>>>>>>> issue.
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>> Donet Tom
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>   Felix
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The failure is observed as:
>>>>>>>>>>
>>>>>>>>>> amdgpu: Virtual CRAT table created for GPU
>>>>>>>>>> amdgpu: Error parsing VCRAT
>>>>>>>>>> kfd: amdgpu: Error adding device to topology
>>>>>>>>>> kfd: amdgpu: Error initializing KFD node
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Since every online NUMA node is a valid topology object and can
>>>>>>>>>> contain
>>>>>>>>>> CPUs, memory, I/O links, or any combination of these, topology
>>>>>>>>>> devices
>>>>>>>>>> and proximity domains should be created for every online NUMA 
>>>>>>>>>> node
>>>>>>>>>> rather than only for NUMA nodes that contain CPUs.
>>>>>>>>>>
>>>>>>>>>> To address this, this series introduces a new VCRAT subtype that
>>>>>>>>>> records the mapping between the NUMA node ID and the 
>>>>>>>>>> generated VCRAT
>>>>>>>>>> proximity domain. When topology devices are created, this
>>>>>>>>>> information
>>>>>>>>>> is stored in the corresponding topology device, allowing the
>>>>>>>>>> driver to
>>>>>>>>>> translate a NUMA node ID into its associated proximity domain
>>>>>>>>>> whenever
>>>>>>>>>> required.
>>>>>>>>>>
>>>>>>>>>> Returning to the previous example, the system contains three 
>>>>>>>>>> online
>>>>>>>>>> NUMA nodes, so three CPU topology devices and three proximity
>>>>>>>>>> domains
>>>>>>>>>> are created, even though only one NUMA node contains CPUs. 
>>>>>>>>>> The NUMA
>>>>>>>>>> node ID is stored in each topology device together with its
>>>>>>>>>> generated
>>>>>>>>>> proximity domain.
>>>>>>>>>>
>>>>>>>>>> Later, when the GPU VCRAT is generated, the driver only knows 
>>>>>>>>>> the
>>>>>>>>>> NUMA
>>>>>>>>>> node ID to which the GPU is attached (for example, node 3).
>>>>>>>>>> Instead of
>>>>>>>>>> assuming that the NUMA node ID is equal to the proximity 
>>>>>>>>>> domain, the
>>>>>>>>>> driver walks the existing topology devices to locate the
>>>>>>>>>> corresponding
>>>>>>>>>> NUMA node and retrieves its generated proximity domain. In this
>>>>>>>>>> example, NUMA node 3 maps to proximity domain 2, so
>>>>>>>>>> proximity_domain_to is populated with the correct value.
>>>>>>>>>>
>>>>>>>>>> Since the GPU I/O link now references a valid proximity domain,
>>>>>>>>>> VCRAT
>>>>>>>>>> parsing completes successfully and topology initialization 
>>>>>>>>>> proceeds
>>>>>>>>>> without errors on systems with sparse NUMA node IDs, CPU-less 
>>>>>>>>>> NUMA
>>>>>>>>>> nodes, and CPU-less/memory-less NUMA nodes.
>>>>>>>>>>
>>>>>>>>>> This series consists of the following patches:
>>>>>>>>>>
>>>>>>>>>> Patch 1 removes an unused argument from
>>>>>>>>>> kfd_create_crat_image_virtual() as a preparatory cleanup.
>>>>>>>>>>
>>>>>>>>>> Patch 2 introduces a new VCRAT NUMA affinity subtype that 
>>>>>>>>>> stores the
>>>>>>>>>> NUMA node ID and its corresponding proximity domain.
>>>>>>>>>>
>>>>>>>>>> Patch 3 populates the NUMA affinity entries during VCRAT 
>>>>>>>>>> generation
>>>>>>>>>> for every online NUMA node.
>>>>>>>>>>
>>>>>>>>>> Patch 4 parses the NUMA affinity entries from the VCRAT and
>>>>>>>>>> stores the
>>>>>>>>>> NUMA node ID and proximity domain in the corresponding topology
>>>>>>>>>> device.
>>>>>>>>>>
>>>>>>>>>> Patch 5 fixes GPU VCRAT proximity domain mappings by 
>>>>>>>>>> translating the
>>>>>>>>>> GPU's NUMA node ID to the corresponding CPU proximity domain 
>>>>>>>>>> before
>>>>>>>>>> programming proximity_domain_to.
>>>>>>>>>>
>>>>>>>>>> Patch 6 creates proximity domains and VCRAT entries for all 
>>>>>>>>>> online
>>>>>>>>>> NUMA nodes, including CPU-less and memory-less nodes.
>>>>>>>>>>
>>>>>>>>>> Patch 7 adds a numa_node sysfs attribute for CPU and GPU 
>>>>>>>>>> topology
>>>>>>>>>> devices, exposing the associated NUMA node through the topology
>>>>>>>>>> sysfs
>>>>>>>>>> interface.
>>>>>>>>>>
>>>>>>>>>> Please note that the changes in this series are on a best effort
>>>>>>>>>> basis from our
>>>>>>>>>> end. Therefore, requesting the amd-gfx community (who have 
>>>>>>>>>> deeper
>>>>>>>>>> knowledge of the
>>>>>>>>>> HW & SW stack) to kindly help with the review and provide 
>>>>>>>>>> feedback
>>>>>>>>>> / comments on
>>>>>>>>>> these patches
>>>>>>>>>>
>>>>>>>>>> Donet Tom (7):
>>>>>>>>>>    drm/amdgpu: Remove unused argument from
>>>>>>>>>> kfd_create_crat_image_virtual
>>>>>>>>>>    drm/amdgpu: Add VCRAT NUMA affinity entry
>>>>>>>>>>    drm/amdgpu: Populate NUMA affinity entries in VCRAT
>>>>>>>>>>    drm/amdgpu: Parse NUMA affinity entries from VCRAT
>>>>>>>>>>    drm/amdgpu: Fix VCRAT proximity domain mappings for GPU nodes
>>>>>>>>>>    drm/amdgpu: Create proximity domains and VCRAT entries for
>>>>>>>>>> CPU-less
>>>>>>>>>>      and memory-less NUMA nodes
>>>>>>>>>>    drm/amdgpu: Add numa_node in cpu/gpu topology device sysfs 
>>>>>>>>>> entry
>>>>>>>>>>
>>>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 152
>>>>>>>>>> +++++++++++++++-------
>>>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     | 19 ++-
>>>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 49 +++++--
>>>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 4 +
>>>>>>>>>>   4 files changed, 168 insertions(+), 56 deletions(-)
>>>>>>>>>>

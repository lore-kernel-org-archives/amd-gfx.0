Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D70C982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 17:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC3510E2B6;
	Mon, 21 Sep 2026 17:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U8KacKVG";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF5910E2B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 17:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxrNxOtuGbIWNc+LNPdPcmL+3rFXoykp5PvgIZAHywWCB1rzZiU+jPUTxKhfdXM7tGo3tQoAG7a8Yoo6nTrrmM1MqD+hrlkysb0Q0zcru4/k09UnTXy4iwSiuXBqAda/fssnvaHzcIdLxZPp+uaKzPVNBwvt5GNMKEiS/ZkCNGU/jGcgghplCXF0lqN2ydyJT7MwvGufCzhbqNFwLfqtbjBMvs5ZJASgw3U1/rQNNnVlz3ygciDdcnH0/eGHMyvl88x+4jajGjxYJkHVzhEC6CCi/acuoxtZmbLdgchuKY8KcE0rKnjUb/TR//N2fwybsxEjnBwV46ehnEGkm3hFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1ONUqKGvL6xtcc6QrgIyylPLh6EmnsUsWbsUniCk1c=;
 b=tA9zAwGZq1q5rjnMO5tg7wzJbrz28apCTHMwUpMquEqxyn1P6+NcVpgnXjG2dnhslx+GzPSA8yab6760VSr2XX5PK0eQSO5vidcoHpTyQUJeaUUBclJSs8641tqQjtHd2twe6GEhZFxSaioDY1eRWbMBHV0ERj1X7BaDRxO0iO8jRToZNq/aud+1nmwOYYPKBBMyhSWcs4EGykRNWTC0x+MnBWsidOb6d8JsdaXpuXhZTCPfbzPARJUq5NHFzYDvm75CgnlydjMsTzuk/4NHT8vEmaIm1UGcz6PhX42XbSte9SE10fQVmBOhALw9FlhrArpVEhQHyurT9u95riq5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1ONUqKGvL6xtcc6QrgIyylPLh6EmnsUsWbsUniCk1c=;
 b=U8KacKVGVuYg3r2bhE2Cy7/NP9Jc0w1MOnvoFo2SlwmAP0NlFdhm0J6zB7idBJzsWwa4eW8Owe+PSXT25yjk29VFMiPyRKf3V9fH3BHnTfOQT/TConObCzfC71iliPmuQXAlxzgcIzVeT16wVeuSSgShk8/z+2XbXR96/DV6gEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA1PR12MB8310.namprd12.prod.outlook.com
 (2603:10b6:208:3ff::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:06:01 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 17:06:01 +0000
Message-ID: <a7404568-5d4b-4588-950c-28a5225f77d3@amd.com>
Date: Mon, 21 Sep 2026 13:05:58 -0400
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
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <6b7e68a3-8308-496d-a183-f23be992448e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0489.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::8) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: b12447ed-cd5d-4d09-3878-08df18029c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CmaWGxv3HsXTuw7kFoLd0eV17TH2TQPAL+Snn3V5GcmzTjpl1pKo2XIwCZfl0UlXp7NkXpFLXwrXc90xFkMmkL5GV41xGKU2z8aYPlc4aua6s4DXSXsd9/ioSlXtNDCZZ+xzllRipJtD8OQwj+jGk2y/s+Y/ZLiVydoMkRtiGd5cIOLWBxXUU+oba62own3U00NR3PJc1Zi5Z6csm9WnK5taHa9ilredUNAojDE5lvmci7c0NIlMRNIiRXiI4CqndwNgDoC/BqiMzJIJqeH/7eeCnhJCRc9vTClsJJyyAdjTtJH9Omrk0oBDtlChb+UFgK48KESrGbt+DTs3ed4ReQDbz72blROXPeS/IjWTsZqAVVRjC8r6mZ6ZSWqGuIWlvXz1O7oLKelIAqAOnQ2p8VADSd1LQqw/ERceAZN/eGSPWZQW+vhlgslgeGHU1wEIxEeuHyGcXnRM4U32BBfdi2kIKd/loWhurCk6F8byU8KB5ekT7MztFiIBuAvymd4JAjYIPb9psVeshU3k6cqUmB/yv5ZMV3/NjgyetgyDi64vsD+ZXHR5yEXpjO5kxNFiO3QdpwGErB589Rwh+U8kR4Ht2sJr3OKk6PUJjYzZfPD4Vx90MC9sNd+HrR6HIay8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cytGbG95U2JwTXVnRDRGdzNOVFRXUEpVanRwcXIxN0lidkxaWU8xTmM5b01x?=
 =?utf-8?B?WDdJTHZrY1RXWHFmemNVUzh3d0hEK1Z6TXgzMHNGaGpKOTJQWHlwaFUyY0gz?=
 =?utf-8?B?WkY2SDk1dzJLcm42WUY1WTNaV00vQ1RpMkduSG5LMFpJUzZGbVpBeVFDbU9R?=
 =?utf-8?B?STY5WWF4N0s3QzM4S3NFaUszT2cwSGxkVnhIejRlRVZvdzI1ZkM1RDJaSmIw?=
 =?utf-8?B?ZkFBbUlkR3JYbjlKQzdoOWVma3VlVWlWK0IzR2tUN2hVdjJ3aG05aDhRYmJr?=
 =?utf-8?B?N3c2bm4vSlRuUHRpNVF0YjlEQ0VucnZhNHpvNFJvUFZINHM4L2lESDNRSFdW?=
 =?utf-8?B?THFFNkNodVVETG9NaWdJV09iQlFyMzVici9YSVpVZDh2MzZpeHBWM0JuVHVz?=
 =?utf-8?B?aTQ0bm1SMWNiWG95WjZtNWxGenRaVFFrdnJqaDRyUm9TdlBHeHdjU2lZa0xJ?=
 =?utf-8?B?bjdNR2RJbngycWJuTVBNODhLSGJmNVdzdnZoN24wcHgwZmNsdXpzUHppNHZT?=
 =?utf-8?B?QUduVjdXU2pTSGw1dWFHQjFpL2Y1eHRKV1VNS1VYNStXU1pRWjBsZmxrd3J0?=
 =?utf-8?B?SExjUnJselBUc0xRTEJ1OFYxT00zWFc2bzRpN3RTQUVNTG1wZXZVVXVSem1E?=
 =?utf-8?B?NEVzOEgrTFRPWkgzeC84cmF4cTVkbjZRaWc0Rm9qSWNuMlROckxJRDF0UnBB?=
 =?utf-8?B?Q0Z5RDZYOFhRZU94dU9vSTliMm1JeEZhUHVVTEo5UUN5Nk5yR0hjR0pFQ2dX?=
 =?utf-8?B?a3ZXRVVYZE9WZHBVU21xUWpsMjVQZVpzMmI4NUxOWnR6N3J4VWE3akJjbXR4?=
 =?utf-8?B?WS9hRXRCWW1EVm5odUZ3LzU4aTQwc0hpMTh6bDdlOW5ISzZGQjVTdUR4dk9W?=
 =?utf-8?B?SkxrMW1FV2o0YzNtcFFsUUNxUk5lb3FVNzBPODBJMFdNK2Y0Q1A5akRvZGs0?=
 =?utf-8?B?UEpIOTVSWXVrK0Rla2VsU0xuMXBmSHk0R1dSNjhMMGFSRFBLeG9VV3kxM1R6?=
 =?utf-8?B?STZLdndoU2xwVEx0cUxpMGo2b3JkSzZKK0c1VURwbU9paGplRE9wNXhjSmhZ?=
 =?utf-8?B?N0RsRllRQ3JZelJtRWZ0aFM2K1hzbzVKU1FIMkdGRWdVQkZpYTFUSVRVZEln?=
 =?utf-8?B?TlBzV2MwOWV3SUVpaTdta1NxNWN0ekNDS1paWnlRWFZOU3hZZGd4VkhYVEV0?=
 =?utf-8?B?T3RkR2ZQYzR6MUtDSjRMWTArQURueXNnM245aTg0azB1MyswcWd0OXROZEoz?=
 =?utf-8?B?Zm1KY1dDalJNTkNTQ09iN1liRExrL0JXVnhLWHhyOTl0ZTZmZXJpcmxTWmhT?=
 =?utf-8?B?M0RSZStWYXE5ZlNqSU95WisvL2ZzLy9ncFFMeTIzbW9pMTBNT2g1ejIrRjVK?=
 =?utf-8?B?ei80Q2hkVG01dXBIS0lsWHhaNjc3QXJwRUxBMDZ4OFRoVkdvYWdObDdHdjJ0?=
 =?utf-8?B?ZVVVVGMxNHRseGZDUEVPMk5kd1ZDMXd1RW83Y2wwWXNjUllteGh5RURKVzl2?=
 =?utf-8?B?TDFndjZ4SWlHT0hzWXlKcnhKL3FJVlIvcW1qa0ZEVkhUOFh4T3pUL29Zd0x3?=
 =?utf-8?B?Z29LdEpLVjlUb0hCSVk3QVhSeFJLY3pCSHFBWDNVTlJlWUNPK2tUZjFHVnl1?=
 =?utf-8?B?dk45dVdPSmdISEdKMExnVEFRZVlYM3dYMEErUFlrY2xRZUZoUnY4MGNjTUdU?=
 =?utf-8?B?VzZpK2ZTa2R0aENxeVNlZUV0dU1oeDU0bnE2eTZvTnZtcmNrRHA3ZkMzREhV?=
 =?utf-8?B?MFhKL1Z3VWZvZEVzNERUL1VaNXJzd25samxuem1NQ2RMZ1pzYm53UmFXUUZr?=
 =?utf-8?B?U1V2eHpZclJmM1FML0E4L0twZUdLUUR5ZFRSVHRxTXdUb2U3bnN3c2EyT0Zh?=
 =?utf-8?B?VHQvcFpyRjc1ZGpYenVLandxQW5aTnNWU0YrNUNUZ1I0YWdiMk5zekJ5UGY2?=
 =?utf-8?B?NzZUcHN4eTNyak5pZUlWYWV1VHdzU3dPak5vUm8wRFR4NGx6RGtnZk1FcFdZ?=
 =?utf-8?B?YWJlQkVYTndQKzdSZ1FGZFM0bmFadVBHSnZOaE9UL1FFaWlGRXd3QWNXRUJV?=
 =?utf-8?B?dy9ENjlPOE83WVYwWlQ2TDFKSCtOSHJLSTJXODgrUGg0WkYzSVFIbGlMWnhp?=
 =?utf-8?B?LzVWclAzZWw1aGFrYlZFNlM0Rm8zWndORGcwMWNoTVZjbTlsTDRWV3JlTG41?=
 =?utf-8?B?VG5uMEZMRHUyV1ZhTlZCbTRBYkdYYlRaRkVISkFhZ0tud3dGMWdvbXBKUDhN?=
 =?utf-8?B?MFFTTjgzVVc2RnRvY2ZNT0N3UkpJS1hqM0pNSjU3ZmNJVDlQcnl5VVVEMjNa?=
 =?utf-8?Q?3w1g3W9AI1SsQKkGGp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12447ed-cd5d-4d09-3878-08df18029c12
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:06:00.0442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noKlkRFsrvGpchYrMkKRsYWS/YvSNrCsDwblYQyTELiR9eusEvoo3nWZq3KcQ/zjrAQWBMHGD3GRVWH204Xc4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
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

On 2026-09-21 00:56, Dhruv Bhogaonkar wrote:
> [Some people who received this message don't often get email from 
> dhruv.b@linux.ibm.com. Learn why this is important at 
> https://aka.ms/LearnAboutSenderIdentification ]
>
> On 05/08/26 21:46, Kuehling, Felix wrote:
>>
>> On 2026-08-05 03:09, Donet Tom wrote:
>>>
>>> On 8/5/26 3:57 AM, Felix Kuehling wrote:
>>>>
>>>> On 2026-08-04 05:52, Donet Tom wrote:
>>>>> This series fixes topology device creation and proximity domain
>>>>> mappings in
>>>>> AMDKFD when a system does not provide a CRAT table and the driver
>>>>> generates a
>>>>> Virtual CRAT (VCRAT).
>>>>>
>>>>> The current implementation assumes that CPU NUMA node IDs are
>>>>> contiguous and
>>>>> that every NUMA node contains CPUs. During VCRAT generation, CPU
>>>>> topology
>>>>> entries and proximity domains are created only for NUMA nodes that
>>>>> have CPUs.
>>>>> GPU proximity domains are then allocated immediately after the CPU
>>>>> proximity
>>>>> domains, and the GPU I/O link (proximity_domain_to) is initialized
>>>>> using the
>>>>> NUMA node ID to which the GPU is attached, implicitly assuming that
>>>>> NUMA node
>>>>> IDs and proximity domains have a one-to-one mapping.
>>>>>
>>>>> These assumptions break on systems with:
>>>>>
>>>>> Sparse (non-contiguous) NUMA node IDs
>>>>> CPU-less NUMA nodes
>>>>> CPU-less and memory-less NUMA nodes
>>>>>
>>>>> For example:
>>>>>
>>>>> available: 3 nodes (0,2-3)
>>>>>
>>>>> node 0: CPUs present
>>>>> node 2: CPU-less
>>>>> node 3: CPU-less
>>>>>
>>>>> In this case, the driver creates a CPU topology device only for
>>>>> node 0 and
>>>>> assigns a single CPU proximity domain (0). However, the GPU VCRAT
>>>>> still
>>>>> references the NUMA node ID to which the GPU is attached (for
>>>>> example, node 3)
>>>>> in the proximity_domain_to field. Since no corresponding CPU
>>>>> proximity domain
>>>>> exists for node 3, the parser cannot find a matching proximity
>>>>> domain during
>>>>> VCRAT parsing, causing topology initialization to fail.
>>>>
>>>> Hi Tom,
>>>
>>>
>>> Hi Felix,
>>>
>>>
>>>>
>>>> Thank you for the explanation and the patch series. I may have some
>>>> gaps in my understanding that I would like to clarify. In my mind, I
>>>> was using "proximity domain" and "NUMA node" interchangeably. You're
>>>> demonstrating that they are not the same thing. Is that just a
>>>> different way of labeling the same thing, or are NUMA nodes and
>>>> proximity domains fundamentally different concepts.
>>>>
>>>> Your code in patch 5 (kfd_proximity_domain_to_numa_node and
>>>> kfd_numa_node_to_proximity_domain) seems to imply that there is, in
>>>> fact, a 1:1 mapping, as it assumes that there is a unique
>>>> translation in both directions. Am I missing something?
>>>
>>>
>>>
>>> Thanks for the comment.
>>>
>>> IIUC, NUMA node IDs and proximity domains are different numbering
>>> schemes. We have proximity domains for both CPU and GPU devices. CPU
>>> proximity domains start from 0, and GPU proximity domains start after
>>> the last CPU proximity domain.
>>>
>>> If the NUMA node IDs are contiguous, the CPU proximity domains happen
>>> to match the NUMA node IDs. However, if the NUMA node IDs are
>>> discontiguous, the CPU proximity domains and NUMA node IDs no longer
>>> have a one-to-one mapping.
>>>
>>>>
>>>> If they are just different numbering systems, do we really need to
>>>> keep track of both proximity domains and NUMA nodes in the KFD
>>>> topology? Or would it be sufficient to only track NUMA nodes, if
>>>> that's what we really care about in the uAPI (KFD sysfs)?
>>>
>>>
>>>
>>> Thanks for the suggestion. I also think we don't need to keep track
>>> of both the proximity domains and the NUMA node IDs in KFD. Do you
>>> think the approach below would be reasonable?
>>>
>>> Just to make sure I understand correctly, for CPU devices the
>>> proximity domain will be the same as the NUMA node ID, and the GPU
>>> proximity domains will start after the last CPU proximity domain.
>>>
>>> In that case, the CPU proximity domains and NUMA node IDs will always
>>> have a one-to-one mapping, and the GPU proximity domains will follow
>>> after them.
>>>
>>> For example, if a system has three NUMA nodes and two GPUs:
>>>
>>> NUMA node IDs:            0   2   3
>>> CPU proximity domains:    0   2   3
>>> GPU proximity domains:    4   5
>>>
>>> Would it be okay to proceed with this approach?
>>
>> Yes, this looks good to me.
>
>
> Hi Felix,
>
> I have been looking into this issue along with Donet.
>
> From my understanding, there are three related but distinct concepts
> involved here:
>
> * NUMA node: A system can have sparse NUMA node IDs. For example,
>   online nodes can be 0, 2, and 3, with node 1 absent.
>
> * Proximity domain: The proximity domain is the identifier
>   associated with a KFD topology device. In the current implementation,
>   proximity domains for CPU topology devices are assigned using a
>   sequential counter, and GPU proximity domains are allocated after the
>   CPU proximity domains.
>
> * KFD sysfs topology node: KFD exposes each topology device through
>   a node under its sysfs topology interface. Userspace reads these sysfs
>   nodes to discover the CPU/GPU topology and their relationships. In the
>   current implementation, the sysfs node numbering corresponds to the
>   proximity domain numbering.
>
> IIUC, the proximity-domain numbering and KFD sysfs topology-node
> numbering are expected to correspond, while the Linux NUMA node ID can
> be a separate identifier that is mapped to the corresponding topology
> or proximity domain.
>
> As discussed in the thread, we implemented the
> 'NUMA node ==Proximity Domain' approach. However, after implementing
> this for sparse nodes, we found that the userspace libraries using the
> KFD sysfs nodes have an assumption that the topology devices are 
> contiguous.
>
> With this approach, discontiguous NUMA nodes result in discontiguous
> proximity-domain and sysfs node numbers. This would break userspace
> libraries that assume the topology devices are contiguous.
>
> To support this approach, we would need to make corresponding changes
> in the userspace libraries, which would break applications using the
> existing userspace and introduce backward-compatibility concerns.
>
> With this in mind, we think the current RFC v1 approach would be the
> better way to proceed, keeping the NUMA node IDs separate from the
> proximity-domain/sysfs numbering.

I'm not sure about this. We have code in user mode that uses the KFD 
proximity domains as CPU NUMA nodes, e.g. in calls to mbind. E.g. 
https://github.com/ROCm/rocm-systems/blob/f437a7135fa67b96b48da4baeb72d5f75c406052/projects/rocr-runtime/libhsakmt/src/fmm.c#L2058

So if you change the KFD CPU proximity domain numbers to something 
contiguous, you're probably breaking user mode either way.

Can you point out what specific problems you run into with 
non-contiguous NUMA nodes topologies?

Regards,
   Felix


>
> Would you agree with this approach? If so, I can rebase the RFC v1
> series onto the latest kernel and post a new version for review.
>
> Thanks,
> Dhruv B
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> I think this approach should also resolve the driver loading issue.
>>>
>>>
>>> Thanks
>>> Donet Tom
>>>
>>>
>>>>
>>>> Thanks,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> The failure is observed as:
>>>>>
>>>>> amdgpu: Virtual CRAT table created for GPU
>>>>> amdgpu: Error parsing VCRAT
>>>>> kfd: amdgpu: Error adding device to topology
>>>>> kfd: amdgpu: Error initializing KFD node
>>>>>
>>>>>
>>>>> Since every online NUMA node is a valid topology object and can
>>>>> contain
>>>>> CPUs, memory, I/O links, or any combination of these, topology 
>>>>> devices
>>>>> and proximity domains should be created for every online NUMA node
>>>>> rather than only for NUMA nodes that contain CPUs.
>>>>>
>>>>> To address this, this series introduces a new VCRAT subtype that
>>>>> records the mapping between the NUMA node ID and the generated VCRAT
>>>>> proximity domain. When topology devices are created, this information
>>>>> is stored in the corresponding topology device, allowing the 
>>>>> driver to
>>>>> translate a NUMA node ID into its associated proximity domain 
>>>>> whenever
>>>>> required.
>>>>>
>>>>> Returning to the previous example, the system contains three online
>>>>> NUMA nodes, so three CPU topology devices and three proximity domains
>>>>> are created, even though only one NUMA node contains CPUs. The NUMA
>>>>> node ID is stored in each topology device together with its generated
>>>>> proximity domain.
>>>>>
>>>>> Later, when the GPU VCRAT is generated, the driver only knows the 
>>>>> NUMA
>>>>> node ID to which the GPU is attached (for example, node 3). 
>>>>> Instead of
>>>>> assuming that the NUMA node ID is equal to the proximity domain, the
>>>>> driver walks the existing topology devices to locate the 
>>>>> corresponding
>>>>> NUMA node and retrieves its generated proximity domain. In this
>>>>> example, NUMA node 3 maps to proximity domain 2, so
>>>>> proximity_domain_to is populated with the correct value.
>>>>>
>>>>> Since the GPU I/O link now references a valid proximity domain, VCRAT
>>>>> parsing completes successfully and topology initialization proceeds
>>>>> without errors on systems with sparse NUMA node IDs, CPU-less NUMA
>>>>> nodes, and CPU-less/memory-less NUMA nodes.
>>>>>
>>>>> This series consists of the following patches:
>>>>>
>>>>> Patch 1 removes an unused argument from
>>>>> kfd_create_crat_image_virtual() as a preparatory cleanup.
>>>>>
>>>>> Patch 2 introduces a new VCRAT NUMA affinity subtype that stores the
>>>>> NUMA node ID and its corresponding proximity domain.
>>>>>
>>>>> Patch 3 populates the NUMA affinity entries during VCRAT generation
>>>>> for every online NUMA node.
>>>>>
>>>>> Patch 4 parses the NUMA affinity entries from the VCRAT and stores 
>>>>> the
>>>>> NUMA node ID and proximity domain in the corresponding topology
>>>>> device.
>>>>>
>>>>> Patch 5 fixes GPU VCRAT proximity domain mappings by translating the
>>>>> GPU's NUMA node ID to the corresponding CPU proximity domain before
>>>>> programming proximity_domain_to.
>>>>>
>>>>> Patch 6 creates proximity domains and VCRAT entries for all online
>>>>> NUMA nodes, including CPU-less and memory-less nodes.
>>>>>
>>>>> Patch 7 adds a numa_node sysfs attribute for CPU and GPU topology
>>>>> devices, exposing the associated NUMA node through the topology sysfs
>>>>> interface.
>>>>>
>>>>> Please note that the changes in this series are on a best effort
>>>>> basis from our
>>>>> end. Therefore, requesting the amd-gfx community (who have deeper
>>>>> knowledge of the
>>>>> HW & SW stack) to kindly help with the review and provide feedback
>>>>> / comments on
>>>>> these patches
>>>>>
>>>>> Donet Tom (7):
>>>>>    drm/amdgpu: Remove unused argument from
>>>>> kfd_create_crat_image_virtual
>>>>>    drm/amdgpu: Add VCRAT NUMA affinity entry
>>>>>    drm/amdgpu: Populate NUMA affinity entries in VCRAT
>>>>>    drm/amdgpu: Parse NUMA affinity entries from VCRAT
>>>>>    drm/amdgpu: Fix VCRAT proximity domain mappings for GPU nodes
>>>>>    drm/amdgpu: Create proximity domains and VCRAT entries for 
>>>>> CPU-less
>>>>>      and memory-less NUMA nodes
>>>>>    drm/amdgpu: Add numa_node in cpu/gpu topology device sysfs entry
>>>>>
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 152
>>>>> +++++++++++++++-------
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  19 ++-
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  49 +++++--
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   4 +
>>>>>   4 files changed, 168 insertions(+), 56 deletions(-)
>>>>>

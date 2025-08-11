Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1BFCA0EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 08:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3563010E2E5;
	Mon, 11 Aug 2025 08:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ovmI0TJf";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CE310E2E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 08:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQcNOXHvC6pknhcvGNDRSyF7y1vySpFhMrVvtOMJ17BlbcuKCNx3Q2rcIVa7bFRx1uGR9FYzryKS/az7SE5X9x7p6y7Od9wALKuHfyMyoZqAMlaHieOpHcssA9bz+umagTrXbbchPX4qz0z7pwZBUPVdmim3iI7BLXHtVCqJXvHI6Rd8jhnWqgdNS0NoMQ4fzPTBmj6xyO1J27PVMFzdDtbBUPw+68dmlbvn65cGfT9pdITd0/cerbed6A+DPrTGnE69hiQsEG5YJW8//chB2gPlIZCY07930zSDSy1WUixYgG8rcLS2cOe23LcfYNAlnMh30wQdhRRFdFNOa4itPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/uJAqMqYYrhxcHkcB/OxTjmg8+gZ8c3MSO2vBOE5kk=;
 b=xUOfXvugM+SmCCSfTJs+Kcy/PrAxgZAaVKjO6EDO9Lj60UG6SH0BSDd4Vu5VKuyfARUYQcVVDHGk9qaedrM5WzaoDmFLlNLBrICoMHLKT2XLL/gKoUoxwDVMNDJbBKjr1nQgsdpXb23xE7l6qmqrw5/p7sBN9T2FNDnosRWPEsDhqWEEjnSaAwDwp1UJUKuiYg05YcXUvHaE9iVWpNvQ9eUcVqBMlYwazhI7P0mzBmPXAPJ4h0ZyJns+hNBEvEVvmLRGNZYd1zw5qQMeUPUmUw4+Sl191U5ar0eOuJLkK9Z/XanhH1yp0oAVKupRVPSOeV0zzelBhS9+rfhcqSRN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/uJAqMqYYrhxcHkcB/OxTjmg8+gZ8c3MSO2vBOE5kk=;
 b=ovmI0TJfzWFeySPylUZRvVW6SxiwRUsiCb7y11BLG36hjpW+i003vEdPm4l8lhSpIdvy4uoHkdKe9/mvsxtxhHyCIj+RZN4DPh9rz+yLhZBwtdOfNUCwewi3ATfJ7QZ33K4msjSFOua39FLyoSfh9Zl7YZjnktXzztc2yjZQdAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 08:34:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 08:34:12 +0000
Message-ID: <504644d8-d7cc-4857-bc5a-6fff87bfa753@amd.com>
Date: Mon, 11 Aug 2025 10:34:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved
To: Felix Kuehling <felix.kuehling@amd.com>, Heng Zhou <Heng.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, Philipp Stanner <phasta@kernel.org>
Cc: Lijo.Lazar@amd.com, Emily.Deng@amd.com, Victor.Zhao@amd.com
References: <20250808031427.3131402-1-Heng.Zhou@amd.com>
 <de752482-b57a-42c8-9ab2-6d60ba7c9498@amd.com>
 <6f5e0a35-3a45-4762-943e-e342d06fde12@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6f5e0a35-3a45-4762-943e-e342d06fde12@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0383.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: 74921889-2039-46f4-bd12-08ddd8b1d94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0J6dTljanMxZ3lNYUhpSkVXMzFLcnBzdklhREdqQkxLZXNJUVIrMUhyQUN2?=
 =?utf-8?B?SXpCdEVxczhpWWdkWmdySkpZMHJlYXlzV1B3eVJualdOSnduaWVBdGJqZUtU?=
 =?utf-8?B?dExmVGRYTElYS3htT3UrRGFta2tiT1hQSFZGcGU3amI5TVRrUmVqOE0xRTkz?=
 =?utf-8?B?cWxDV1JaVWxBZ2xaTFlVeXMxWW5sK2t4K3BKeld5QWJrL0d0YlJSZ2tzdm1K?=
 =?utf-8?B?SDM2WnJOTHlHWkNabHF6UklGK3d0ZlJBVkpWM0dwclN6QTJRY1FnUXhpZ3h4?=
 =?utf-8?B?T3FieGhBeDFiaDhDWCtRTS9qWTl3VGJVYWFLYjQwT3BWZUxBOEtZNFMrZXBS?=
 =?utf-8?B?WFJtRmZqMWtCKytJZGFoNHAyTXFlcUdmazMrTnBFUFFtbnMvL1JTeVhrWmxE?=
 =?utf-8?B?N0ZKYmNKN1lqTWpsWWRoOXpLRHNzbE9mRzZHdFdpUVpoNjR4VlJndU1MZTJX?=
 =?utf-8?B?eXBYaGczdjg4YlR2WCtIWFU3U0dwM0ZXaW9ZOUoxRTZLNGk3Sis4TXZmdTY1?=
 =?utf-8?B?NDBUWmJkaG82Y0JSeGV4UjNZWFpUOS9jMDYzM0Fza1hmR1VwWG9MdEQyaGNN?=
 =?utf-8?B?ZWdBaWVncmFva2VZTm1pZ3NUSW01OTZ2SnJrRHU4d1hnbVJDS25aZVpkMlo2?=
 =?utf-8?B?bmlKSXFUUG95UmdON09XaE9oREtLN3FEd2M1aFY1ZFZHQkVZUHZpM0hLeW80?=
 =?utf-8?B?MWNETUxRYVhia0R2VlNndEg5Rmt0c2p5RUFsZmNOWUppVjAwUnZCNk9EY3hE?=
 =?utf-8?B?bjNUY3VyZ0pEVnhiTFc4ZmlYcHhWbXlsZHJPMVJtRkxjaU9lNE5aZGtaUXJM?=
 =?utf-8?B?cVhnTU5kL3RTVkNyZ3Q5bEErdzZXVWQ3emtjcVN6QkYwUGZaYVhPQ0ducjVU?=
 =?utf-8?B?ZzBSTUFTT3RubGM0M09TaFl3aHJxZHZ5eXh1TXljSmFaMUFxUGhoS1YrOCtM?=
 =?utf-8?B?Z01ackNKMmM5NmpnNUdncE5MdzdvZmJOY3NBWXUyY3JZUjU4MEs1SEZxUys0?=
 =?utf-8?B?TEo0ZXU2SUZsd0hYL25BVVJ4eFlqYXFvOURKcUY1MDhhRmJEUXFUdE5Fb1NZ?=
 =?utf-8?B?bEpvZHNYNEFYbnR4bEpMR2NEaG5GNCtMd3lWOFNCWEZrWW40WE1KdjNxNXpT?=
 =?utf-8?B?SFBSMlJLL2g5NmhYN3JsSmJYd3NmalZhOXA4YW1pbU1mekdKL0VOcitDLzVS?=
 =?utf-8?B?TS96Si9QWjhLWllUQ1EwRUcyQW1CYVQ0VXVHdGEwVGxCMnFzeFpEOGtCQ0RF?=
 =?utf-8?B?bzM2RTZXeUxqNU9RMjNhZmtTNWhyQWdGSGlCYU5FbnhSM0ZWOHE3b3hyeU90?=
 =?utf-8?B?NXNDa3B5UTkvYTBLbUVyL2hQUTh4cXRVOUR3Rmk1VFJXZVRrSjJjV0xPbzNv?=
 =?utf-8?B?Z2ozamo3d04vSHV5RHdPQy9XN0tCVmtBVHJyRkJDSXYzclV3UnovOUtRZVB6?=
 =?utf-8?B?V2NoSmJSeHZTU2Vab2RGeVBsZzdralNidlFVQkszdTRDQjBXZ2hIa0V2VkFU?=
 =?utf-8?B?UkZtRDVXNXYxKzhrazV4Q293bGxHZDkvL3J1QVVVVTNnVlZod0dOWkx3WUJx?=
 =?utf-8?B?Y2RicUR5SmZvbS84ZGZMM1B5MnRwamUyakowMmE2TEpkUFZFT1FoYU9EUHZU?=
 =?utf-8?B?SXZOZW9BT0ErR3VvWmVwUzdmdnhOeFQ3bTRadVZ2dG5yVkR2UXNIQjQ5T0dU?=
 =?utf-8?B?ejJLYjczdnl1Sk5DMzMwSzg2bUFSUFVWMFBBYnFiZDQxM3lrcmZKL1dZWFkz?=
 =?utf-8?B?R21oL0pCNlM2NDFNUk5pMmdhR0RZVndmTlcvSTExeE1QV3E3M1dGT3dQUHpN?=
 =?utf-8?B?SnlLdTBLR1JPVjVNS0xjZ2h1WmczNnZFT1F0SjlhckR5ZE1rQzFFYlZpeUZB?=
 =?utf-8?B?U2MvQm5MQUxzMVFjTVJaNURrK1J3aWpKNXVvT3NETXU2QnhWcVJEYjVkL3Y0?=
 =?utf-8?Q?xCwDg+leO9M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWE5V0ZkRU93eG40L2tyaWVZRUhFb2Nsb1RqUVdVYUFhYjFMeU1YWjMxTFhZ?=
 =?utf-8?B?cTVZUUVDZTNqemlCMWF4MGNYN2cyK3dKMHJFZVhNYW5NNDZYUDBvZms0aU9B?=
 =?utf-8?B?RmVPd1dLNU1VaGh6ekloMEFoZ25MTWlSOE1jNjJ3ZmVrRG0rU3dZcVJBemo5?=
 =?utf-8?B?QUMyQkFBWm9MWWgxWDROV2lEcTR3M0hlSGV4dS83bVhSVVNITGJ5cGdNNVNp?=
 =?utf-8?B?S3VLRnFaRnhoZkVNTTlXMlFqS2NJVkFZd3R3TitZdWxxOVhoVkVzRUlCZWYy?=
 =?utf-8?B?S0dUSmliclNKSzVoV2hXYUE0YnlsZytzQ0haeDhLMHhPeGU3M0d1djJmd0xC?=
 =?utf-8?B?QW0zT0hvdisra01XSTZlZWhKNUJzZS8wOVpta25EWXBoZjc2cnJYK0p1WXgv?=
 =?utf-8?B?OUc2Zld1Qm9ac05DclQ4emhyM041SnNJWVFTVkQ5ZjJYVWVBNkhVQWN2aWkv?=
 =?utf-8?B?UTFZSHp1YVhmYTcvdXR4MElVekljTHZwREZKVXNlNjVzSnB5VUxPSEFTSEsz?=
 =?utf-8?B?Uy9ZUnJsNWtYMzUveEF4QUlWY2JZdVNVeXF2Y041Kzk1U3B0OUdpQ1NjSzVC?=
 =?utf-8?B?a1M1aGpqbHVtWERNaEJ1ZjF0ZWNiOWZGTWVzWXlYcUkwbjc3eCthRUN1QjMw?=
 =?utf-8?B?V0tSN2pOR2NQWFcrT3djc2lWZTNVdVJocWtBMEgzUkUxVzBHaHc0Q1V4cDVD?=
 =?utf-8?B?Y2R3SXZzNU1ibU5DYldiQVpseHR6UUJEVysyYXhhMjVnOHBKN1htYm4ydjFs?=
 =?utf-8?B?OUEwVzRselVSSnRkWkFncHpEd0IvM3lFRExkWXdBMTgxT0Z1S1NsMWJidjlX?=
 =?utf-8?B?MTFSdjNsUGNXbVVPejBMc3NQT0NDUWRlOWZ2RWZmd2E1YU9TYjkrZjMxclVC?=
 =?utf-8?B?OHc4VVpuTjBOWFZnZGtoRnpiZmsrWkZuTGg5THNPUXRKTU1GZHFNT1k2Ykdh?=
 =?utf-8?B?TXpSMnJkWE9HVXRDRUJpTFp1VTc0WUMwTG5LMk8xaTZkLzV1ekd0RnVrdjBM?=
 =?utf-8?B?ZWJqNDJmc0JlbDc3YzdFQmFGQy82aE8yczdPKzhkUHUxdDgwMnBsRTE5akt0?=
 =?utf-8?B?ZXg2YkhXQzd6dDZ1Zjh4L2pjT0RmYk5NL3ZCNGRkWFA0S25hMUt6Z1hhaThB?=
 =?utf-8?B?MGd5UG05a1ZjYmtFZUpLNlMxMzVwemQxbG1ZdFJ6SCtkUEdPUHRNS3ZoL1Rl?=
 =?utf-8?B?cHBvNmFDdmJ2MXkyQi9Pd0hCaXJRTm43V3FwNWxZNXFoVlEyT1AycGtGTlV6?=
 =?utf-8?B?K3d6QnFWL09MUlBEZFZTOU8yc3VKVU1EbGh4dUlnd1RBL1hHYThOZ3NIazZW?=
 =?utf-8?B?dEZ2MTVHZWZQdFhzbVNIMjRjRjJLUWpQZ2V2S2VHWkEyWEJvUVIzK2FxM3pu?=
 =?utf-8?B?b3JSZWRTSUNYb2U2WWFOZEpqU0doOWU2RXltZDd2WTFhTXhBQWxTcHBiS2Ux?=
 =?utf-8?B?Z2JQS2IvSlh5RG5MNTkvcWFCMjBTVVdQWVVtaG1PVTdyT0h6dXoxTmN0L2Jv?=
 =?utf-8?B?aEZVZUt0T2RCWHlhZjY1bVhyY25jNGF1Rjh0MmYzUGVIOFQ3REtWL1dIdjFQ?=
 =?utf-8?B?ejNrOUg3M01zMC9NV0RZcDBmUjB1R3pUVXJyMEo5YzJURS9MTGc2WHFodFNU?=
 =?utf-8?B?eVFHS00vZzFGMktXeDVxTkpSSU9wdG9ZYmJrbE5vY3JBakZkam1FNnJZMUwv?=
 =?utf-8?B?aDJDRjVtSXRSMk9iZllNSnQ1TGpiZm00bjQzL2NYNGlTM2VHV3VWaVBJSE9W?=
 =?utf-8?B?LzlKdzR4LzdpeTB2bzFFeGNtQTRGRHJXVDdkMFNPbEd0K2tsVnJuaTA1T0l3?=
 =?utf-8?B?clNhSU0vQWh4c1lQK05pZWlNVDdTdi8zRU8xRHM2RHllcDhlWWVyQmpVNWg2?=
 =?utf-8?B?TnRsK1BrWlFmUktCMnNwZ2duY3RjWHUyWTc5RFREeWVMQWJIb3pZdWNDaVhp?=
 =?utf-8?B?TUo0bXdXUmlsbXhTcERrOXZyd3B1ZFVjRFZsMkUxN3Yvemt2eUg4dW5QNnRU?=
 =?utf-8?B?bVRjNElxVlIvaWZ0S2ViMVpabmcvM0RXN1ptallqR25aOWxNcXFIVWZmejFt?=
 =?utf-8?B?UnFLZCtYMkRrdk1PUW9qZ0MwT3NxMVJpVHArenZwcTUvM21iUFptcU4wQmpk?=
 =?utf-8?Q?RKr+p49dEwurhNznnRUxw1o3H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74921889-2039-46f4-bd12-08ddd8b1d94c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:34:12.5229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsU/p0eG3+98H8mPFgdQ28vQAllr96d7wmCNGy6ZjOS6zFZZ7VdgEpNXK14oPOna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609
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

On 08.08.25 16:13, Felix Kuehling wrote:
> 
> On 2025-08-08 5:21, Christian König wrote:
>>
>> On 08.08.25 05:14, Heng Zhou wrote:
>>> If a amdgpu_bo_va is fpriv->prt_va, the bo of this one is always NULL.
>>> So, such kind of amdgpu_bo_va should be updated separately before
>>> amdgpu_vm_handle_moved.
>>>
>>> Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 8 ++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 1 +
>>>  3 files changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 37d8a7034a7e..e795b2970620 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -2970,6 +2970,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>>>  		struct amdgpu_device *adev = amdgpu_ttm_adev(
>>>  			peer_vm->root.bo->tbo.bdev);
>>>  
>>> +		ret = amdgpu_vm_handle_prt_moved(adev,peer_vm);
>>> +		if (ret) {
>>> +			pr_debug("Memory eviction: handle PRT moved failed. Try again\n");
>>> +			goto validate_map_fail;
>>> +		}
>>> +
>>>  		ret = amdgpu_vm_handle_moved(adev, peer_vm, &exec.ticket);
>>>  		if (ret) {
>>>  			pr_debug("Memory eviction: handle moved failed. Try again\n");
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 283dd44f04b0..2c2a93f22ba0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1569,6 +1569,14 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>>  
>>>  }
>>>  
>>> +int amdgpu_vm_handle_prt_moved(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>> +{
>>> +	struct amdgpu_fpriv *fpriv;
>>> +
>>> +	fpriv = container_of(vm, struct amdgpu_fpriv, vm);
>> That's an absolute no-go from inside the VM code.
>>
>> You could maybe do that in the KFD code, but Felix and Philip need to decide that.
> 
> We're calling amdgpu_vm_handle_moved in amdgpu_amdkfd_gpuvm_restore_process_bos to update mappings of BOs that are not managed by KFD. I don't think we care about PRT BOs, though. They are not useful for compute work.
> 
> What is the problem you're trying to fix here? Is amdgpu_vm_handle_moved crashing because of the PRT BO? In that case I'd try to make amdgpu_vm_handle_moved more robust to handle that situation gracefully (i.e. ignoring PRT BOs).

The issue is that amdgpu_vm_handle_moved() only takes care of moved BOs, but not PRT mappings since they can never "move" because they don't have an associated BO.

But after a GPU reset the all mappings are marked invalid to re-create the page tables, so the PRT mappings ended up on the "moved" list as well and that is not handled by amdgpu_vm_handle_moved() so you end up in a crash.

But the real question is how we end up in this situation in the first place? A GPU reset should kill the KFD process, so there should never be a restore attempted.

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>>
>> Regards,
>> Christian.
>>
>>> +	return amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
>>> +}
>>> +
>>>  /**
>>>   * amdgpu_vm_handle_moved - handle moved BOs in the PT
>>>   *
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index f9549f6b3d1f..853a66f9fd2e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -504,6 +504,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>>  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>>  			  struct amdgpu_vm *vm,
>>>  			  struct dma_fence **fence);
>>> +int amdgpu_vm_handle_prt_moved(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>>  int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>>>  			   struct amdgpu_vm *vm,
>>>  			   struct ww_acquire_ctx *ticket);


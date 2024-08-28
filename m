Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8282C7114C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 22:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165B110E0C5;
	Wed, 28 Aug 2024 22:41:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qjtr/r0T";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEADF10E0C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 22:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAWqTsfn+Mds448z0CisO0ufyFIbeBflCKhRBvRQ+uIcc50H/Kg0VwmBbcUuYimB1LKWiZgMpFD1rQlbBRUgwP2ErEMEO9PCGpDeA5At1KBC9oNDcXAeM33xYUcJl/4R3R8Jok8pXaQBe4ST0QOm1c8Q2PmYv/CVqNR1aYK6vicNzmAiih8o3rMFTsFda73P9r2I+kvOU9HFySGPmUQNU2Yk9g65Sjkd2TVyRyTgc9fGyUpUlqdSFvGgfskmnQNxA3Dn3Wwu/nQOId5xqTaujA6fS37jidwbGnG4/vJ01XdiBYDxBI9s0M2i3Tsd94jiqI70OfJ4XsZ9Tl98dawdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2U6FyOiwpEaMn6mDXudRh4y372eMo3BeJndVXylF7o=;
 b=N16x4RBCdfede5GxUn55tG0i/7MyQ6c5ixa99vKQTuEuTSVRnNF1V4ZOUTjr0zxedDXKAzorMG600xe/QM8z1TZkI+Ad+KR/pyc3Z/82S3txivkVq4YO1R5Yt13JsMUnOJHuEAhZHZWxXCHnkeVD4PUyZL4DfE6A+5hknQqWWLg9ffmYjPmV50QhhnTH3gqL/z+Bg2fBO1g9YnoNU+6AmabCdilvBBbuUhoekcZCqzYhdmW2BeCwvpbWFncd/NhUa/dmXnUjBh8HEtxu/iBsxxfeLHWIjfN+KS8i6eRH7u18hYsZQZ9XoDuV1H+1RhvYEt6Qf7ySDfAAc9ZzrsYFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2U6FyOiwpEaMn6mDXudRh4y372eMo3BeJndVXylF7o=;
 b=Qjtr/r0TKczTEaHPj3f/EKNwH3AtsqbuyEVQnhLSJiPVgKOIOd40SCItTp+IXfDGKzEIc/JglrV/CoRrcjNEIdsjyI3sxsWeUFLCUmMikwrOsiDwpA5GauWarz/xf7NaxMgad3mdAT9DlqAGIsXebqw1xVtonxIto5pJuMhL5R4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 22:41:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 22:41:01 +0000
Message-ID: <dea2c696-9944-47d3-9348-b12a52f42892@amd.com>
Date: Wed, 28 Aug 2024 18:40:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: sync to KFD fences before clearing PTEs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 friedrich.vock@gmx.de, bas@basnieuwenhuizen.nl, ishitatsuyuki@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240821120324.4583-1-christian.koenig@amd.com>
 <20240821120324.4583-2-christian.koenig@amd.com>
 <a511a28c-13d7-452f-96bd-911148c4d175@amd.com>
 <4968a387-d82a-404c-8ff9-7e4406ef33d2@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <4968a387-d82a-404c-8ff9-7e4406ef33d2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 4350e977-54f3-4d89-6a8f-08dcc7b27e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXBCR3lpY1hyeXFRQjkyWDJENzF0TFhrUEhhUVpsVkw5L0VLVU9IV2pWVmhi?=
 =?utf-8?B?QjF2UjFiZ0ZSMW5sRS9xMU5oVkNrM21yd3Zsbko1SmR3dWNKL1lvcjBiQU9x?=
 =?utf-8?B?VjdyZlJwM2VjR2U1eG8yOUtGaWFZN3lIUEl3OXlwTFhsRmRwblN4NnVHVzBG?=
 =?utf-8?B?NDZxaytIMGQyWGZGVFloMmg2a1VESkcyby9lL1c2S1FlS09SZzN2ZEJWcWUy?=
 =?utf-8?B?TTduVFRqeElvNFRnaGhGZ2RSb2VxSk1RWlJ3R2p4SkhOVVJCNEhHQ2ZRSUhv?=
 =?utf-8?B?V2tFQjRoL3hVcWloVmNVbC9PMThuMWtWWUtTcDk4QUppay9saExoVGxlNjhB?=
 =?utf-8?B?b21TRnRxZXpIeGRDb1dKZ0huWkdXcjE4eFAyYUR6ejU3em5DbWJxMUNvdFo5?=
 =?utf-8?B?RjZzSHg3TFpoQWNHejhhazFjOGNHYVBIWmNjWmZCQmtFblg5SjNHUHk5Q0xD?=
 =?utf-8?B?bkxob0FFWUFrV29yU2p2WHZxajV6by83Umo5dEJqYzZCM0E4MkNxK0QwWE43?=
 =?utf-8?B?UzIxMUJpeTk1Y3ZGWVlBUUkrak1pblVYdm5ydUkrT1FpQjlJZHN6eHlBb3VK?=
 =?utf-8?B?QmdmelZCYytvWjRxYjgxWFo3dzFDT3ExdllFdHBPK29lYXV3UWVhYkJLVjJD?=
 =?utf-8?B?SGxYejhMZ0JTN2JiNWxEWVA0SWVpSXFtcjkrcTZDM0UwMDVBdElhcm1OQVlM?=
 =?utf-8?B?cjU5U1o5dk1SM0lISW1TRm40eXZlYzFuTmZNSXVCczB1QVFWM3Bkb3I1Q1Jp?=
 =?utf-8?B?RVhUZ2R3WHpMUXN6QlZxdDkveStKZUZndit1QmpNRjA1UmhnVmd2cWdqZnRu?=
 =?utf-8?B?Y3NhWThxbjN6aWdPZlVnZ3M4ajZVZWZ6VTFhTllXUFFidTc5VWMwZGl4b1dV?=
 =?utf-8?B?WEJ6b0wwbEo4QVMxbGZJVWdiM3RRRDBrRytUZHl5OWhYcmZwT3BidmRsWmxk?=
 =?utf-8?B?UloyRnVUbmpXd1pHS1ltRG44MDFVclNWM1NlcFpwZGpqYWtjSnA2WERSejhO?=
 =?utf-8?B?Um9nTWUzVk1hWGl4NzNaR0dVVkJOZThHTk9lTjFJTUQxMzV2dWtJOG5WdVhX?=
 =?utf-8?B?bndMT1RZWUtXbEkrU3R4WlpsMlVEMzREMjlmMXNBNitVQUFweVd6a0ZDYVJq?=
 =?utf-8?B?U0dXSlMzaDVHNjhHamM4VVFueGZTNTE0eDZ6UDUzRWlGK2JWK2RFeGV0aGl0?=
 =?utf-8?B?aHBTV1FrQ0JrUFBwOXQzUkFBV3czYWMyTUVMdFN1cmRJZ2JPL0hUSitGaXBk?=
 =?utf-8?B?UGtFM3k4S3FmQUJpRUZnclZCRXNqc1BOazJSR3pZOWMrU1ZPenJvdlRJTGNu?=
 =?utf-8?B?NTVpMzZSUklVbnFYMzJCa1k1dm1neTVqRS9GV084YUNqcmtTTHNWaDhlVXVJ?=
 =?utf-8?B?Y045KzZNQmxPRFpuQVZRbERxWVQxZ3A3MFJ4cGFreTNIQ0EvV2ROV1MwSnQz?=
 =?utf-8?B?bjZtZW1namJLazMzcENPWjd1SWYvelorMXFZdU40L3RWbWNLT3ZwNGNMdHNF?=
 =?utf-8?B?d3pCRFAwN2RsV3d3N1hKV3NYRUNYS3Zndi83SkpXVG9hTEJpK3ExWDRUamhS?=
 =?utf-8?B?WGk4YmJWaE9JZFdyQVJ6ckFkMWc2U2orTGZ3bXJoMzIwTFpWcEZmeGMzNTVP?=
 =?utf-8?B?Z0tyZWRlVkFxcm1RRE5sT0VVYU9hcDdZY0tqT0pUcDR2R3B5TnpPVnc4TW0v?=
 =?utf-8?B?S1ZTYk1NNkh3a2NiSytrNXpkM2xSTEkxL1FvK2p5RnJBTzUxRVNYVHBFejJw?=
 =?utf-8?B?ZGZyaWR2a040dGMwYXUzUHV1ODZ3akhNVmoyd2Z1L3VOSTkrZHQ5WXVvbFlJ?=
 =?utf-8?B?YVZEellqRnRNZEl2VmdaUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjA3ZndTL2ZZY2hkUWZRcjFuaitlMjRPaEFZZ3dJWVJuTWdOZFdSL3RDQW4r?=
 =?utf-8?B?VDZ6ZkU1UTdPNTllU1JqWlRyR2J0TEFsVHI0Mmtla0wzbXo2Mjc1RXVMTDht?=
 =?utf-8?B?MDRGY29LNzdjNFZ4ZEtGYVhsMHNpaDZ4Y0RHM1NYK3h5cEh1Y2ttdHpOVlV4?=
 =?utf-8?B?cjJ4ZVVpd0gyOEQydGdpczVtVm8wdjZHYmE4a2FJVzB4dWtCdjJ5U2lQdFhN?=
 =?utf-8?B?aFNUNTYwRkMxWklxaWNDY1duQzJiVlNYWGZrTllqYlFiMmtPdzZsU2h6SnpR?=
 =?utf-8?B?VnhqOUR3NzdPdVNOTW13S3YyQ3cyd2lkWXVJS2RmaU9nZ2prU1NpWExUQmdx?=
 =?utf-8?B?TEZKbitBdWsweGVpTHUwZEFkR0hmQm9ZVVVXamZoOG0rclY2Rm5Wbm9nTGJR?=
 =?utf-8?B?NGpONGppZSs5b05CTFBoamV3emUwakFUV1FNVURWT2dKQjdDdjdwa0hhNzAx?=
 =?utf-8?B?SzJJMXdpMWkrd3pRQnFMN0FSaUhhWlU1RVBSMlVsbXU1UjF0RFE1TTBMNzIz?=
 =?utf-8?B?OW1GcFlhVHl4ZzAzdDBBVnRDcmMzV1F2enRrZWo0Sm9VWnBBWmNQbXE1TXRG?=
 =?utf-8?B?ZnFtLzVxRUdFOFZUMnQzWXJkQ1FheERlUU9tOTMzbHJUV3BUL3ZPWWkvQjJL?=
 =?utf-8?B?UzNPSjl4dEE2a2NISEtBakRRU1JkM01SK0Z5d2hYRCtRSnRQOFB4UkExSUht?=
 =?utf-8?B?UHJYMWdsYWZJWmNxdXJkMHVQYWQwZDhEeWw3YTJRMG52a1I5REFteTByT05M?=
 =?utf-8?B?aWFsVjh4dnBWZHdJRzhMNUw1REgwcGVRRGExN2FINFZBbTQwOFdDVUUrV2pw?=
 =?utf-8?B?ZmlyRkZRd0lpU0JxNXNtYzVzVTRsVHNHNkhPTVdtRU4zNkNsdlZVSEN5SEhi?=
 =?utf-8?B?bS9lb0xSMFZvTGxiVHJIT2lkOEozWW9BV0ZMRjBTV29YM1FObjBjVDNzZlJD?=
 =?utf-8?B?dDRydEw0VFJ4dXFIZ1RSTkVjWmd2RXAzc05IZXo4dURxb3JaMFFUdWdCNWJk?=
 =?utf-8?B?RFVTUDlaM0JoYVg3Q0pUYnoxd0xWMHcyM3FPbVNkZ2ZsTTlqYjZXcjhnZnJF?=
 =?utf-8?B?VnpRUVd1Z291L0poMDdFcUhFVi9NVzZUT1h3MmxKRTRuMDdvQzc5WE04cTUv?=
 =?utf-8?B?Zm9mc3dRMFpBSExDanlreG5KUkJVUXl4Y3NMQXQ2b05rT2JaSjQza0h5amdQ?=
 =?utf-8?B?VDFJOEVRWVNqbHpiK3MrTVNrWDNMcUFkM0kzZlRoTDltZjFpYUlhZUZSVi93?=
 =?utf-8?B?UDRKbG5CZ2NZZysxK2MrUWpVcDEyVERlRlpMeWtkT3hwT0VuWHFhRDJ3SDZH?=
 =?utf-8?B?QjBwVkFLTUMwVXRyOTNCTWtwOGZQaWpUZ2pia2FSc25XamZlU0xQc3p4Sm9r?=
 =?utf-8?B?TVdmOStzOGlVVEdiTjdaKzc3amFUMHhJN0MvUUJsNVp2UWg4YWFDRzRMN2M2?=
 =?utf-8?B?VVNZVnJIT2tQQ1BUM3lQUm5PcjVzTmRhdWVmSDhSU1NUdjlqK2xZQzM2bGdk?=
 =?utf-8?B?bi80KzZxbUwyaGpMM1E2cmhoeW5BOUpaenJhS25XLzdRSXdocWpBV2twYzQy?=
 =?utf-8?B?STI1ZkhDdmd1SjFHQ2NWYlBqNWlKQUNzMml2MWFvN2tuc3Yrd1dsSDh6c1N0?=
 =?utf-8?B?dHNLUENacXhLMzhnN0t2ZHkyMmpiVzFLaEx5ZFE0UkpVeFR4ZytRSFV6NHA5?=
 =?utf-8?B?Vy9rcVBrbkhYbmhiV0FvS1VVODZzRVRISGxEcFI3NFJ4ZGhhV2Z2NVJyYXFD?=
 =?utf-8?B?dXVYOUZLWUpkSEg0L0xwdHREUXZXRkpHK21Zd1I5Rlp4dmxROVpkNFA3VC9J?=
 =?utf-8?B?ek9CN090bVJOTXh5TnpHTmVlaU80aEIwUDIzdXdiTExjdHA0Tm13eDdoczV0?=
 =?utf-8?B?WFhaRmVKdWxXYTZZWjR3WTI1cUk1TjVZYjh5M255ZnpKU2xRK0dWZm5qUjZS?=
 =?utf-8?B?UHZHTjYrQjNZSkdsWFlXU1pQZW9qZkx4cHNOWk9iSkV0QU5kbWlabUVRR3Nk?=
 =?utf-8?B?dkV6QXFlTktPUnFrQlZpSmJNTlJNa1k0UHNZRUxvQ1g1VVBIaHZpdXZ1aXI0?=
 =?utf-8?B?UkVuQUxIbnEvdjNWNnU5OVAxdGFwMjU3WFR5Q1ZaTm4xMmdqZzlWdUtSLzB2?=
 =?utf-8?Q?nMuNOYkVIJ2U305ayM6zALPX4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4350e977-54f3-4d89-6a8f-08dcc7b27e03
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:41:01.3028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zgq2fmgNhj1Wm3tHOz9fUjSPy/+tv/9bFEWhVgrL3Qlga3LF5ZsWaKAn/uB50L3m4nssDpT/EcVQv7yWkBCt1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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


On 2024-08-22 05:07, Christian König wrote:
> Am 21.08.24 um 22:01 schrieb Felix Kuehling:
>> On 2024-08-21 08:03, Christian König wrote:
>>> This patch tries to solve the basic problem we also need to sync to
>>> the KFD fences of the BO because otherwise it can be that we clear
>>> PTEs while the KFD queues are still running.
>>
>> This is going to trigger a lot of phantom KFD evictions and will tank 
>> performance. It's probably not what you intended.
>
> I tried to avoid that by only waiting for the KFD fence only in the 
> particular situation that we can't lock the cleared BO because of 
> contention.

OK. It's hard to make out where you're adding that call with the small 
context in the patch. As far as I can tell it's in the "if (clear || 
!bo)" branch. The "clear" case is as you mention, only used when the BO 
cannot be locked. The !bo case is PRT?

Contention would happen, if this runs concurrently with a 
restore-from-eviction, in which case we're already on a slow path and 
another eviction doesn't matter (as long as we're not getting into a 
live-lock situation). Or if a KFD BO is in the middle of being mapped or 
unmapped by another thread, which should be unlikely. So maybe this 
won't have a huge impact in practice. It's worth a try.

The patch is

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


>
> The only short term alternative I can see is to lock all BOs during CS 
> and that is a) a really large rework and b) will most likely hurt 
> performance.
>
> Then there is the alternative to lock the VM during BO eviction, but 
> that means we need to wait on using the drm_exec object inside TTM as 
> well. So that won't get this fixed in the next halve year or so.
>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 30 
>>> ++++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  6 +++++
>>>   3 files changed, 37 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>> index bdf1ef825d89..c586ab4c911b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>> @@ -260,6 +260,36 @@ int amdgpu_sync_resv(struct amdgpu_device 
>>> *adev, struct amdgpu_sync *sync,
>>>       return 0;
>>>   }
>>>   +/**
>>> + * amdgpu_sync_kfd - sync to KFD fences
>>> + *
>>> + * @sync: sync object to add KFD fences to
>>> + * @resv: reservation object with KFD fences
>>> + *
>>> + * Extract all KFD fences and add them to the sync object.
>>> + */
>>> +int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv)
>>> +{
>>> +    struct dma_resv_iter cursor;
>>> +    struct dma_fence *f;
>>> +    int r = 0;
>>> +
>>> +    dma_resv_iter_begin(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP);
>>> +    dma_resv_for_each_fence_unlocked(&cursor, f) {
>>> +        void *fence_owner = amdgpu_sync_get_owner(f);
>>> +
>>> +        if (fence_owner != AMDGPU_FENCE_OWNER_KFD)
>>> +            continue;
>>> +
>>> +        r = amdgpu_sync_fence(sync, f);
>>> +        if (r)
>>> +            break;
>>> +    }
>>> +    dma_resv_iter_end(&cursor);
>>> +
>>> +    return r;
>>> +}
>>> +
>>>   /* Free the entry back to the slab */
>>>   static void amdgpu_sync_entry_free(struct amdgpu_sync_entry *e)
>>>   {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>> index cf1e9e858efd..e3272dce798d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>> @@ -51,6 +51,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, 
>>> struct dma_fence *f);
>>>   int amdgpu_sync_resv(struct amdgpu_device *adev, struct 
>>> amdgpu_sync *sync,
>>>                struct dma_resv *resv, enum amdgpu_sync_mode mode,
>>>                void *owner);
>>> +int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv);
>>>   struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
>>>                        struct amdgpu_ring *ring);
>>>   struct dma_fence *amdgpu_sync_get_fence(struct amdgpu_sync *sync);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index ba99d428610a..13d429b91327 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1168,6 +1168,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>                        AMDGPU_SYNC_EQ_OWNER, vm);
>>>           if (r)
>>>               goto error_free;
>>> +        if (bo) {
>>> +            r = amdgpu_sync_kfd(&sync, bo->tbo.base.resv);
>>> +            if (r)
>>> +                goto error_free;
>>> +        }
>>> +
>>>       } else {
>>>           struct drm_gem_object *obj = &bo->tbo.base;
>

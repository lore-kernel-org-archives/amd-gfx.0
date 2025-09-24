Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD50CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 17:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B3910E78A;
	Wed, 24 Sep 2025 17:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RhyeC+Ie";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE97010E78A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 17:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldccrrrmajIJDuVgDT7Fg6GWio6EeE2B+X8BPEfF2mPeR+E9EPhPJ5rkYocBjeGRGztx3PBfB4hfdTkY+5krk2NTUCYwImb39FPIUw9we1qdjn2kjvo8yn07YzCeaK6q7O3fsnY/hL4gFPnKu0uxAqm6HE/LQw5FZU6fu5z/OdffOWhNgXY1xl/O7icZvGctSN9GhPvx9an1cQhCSesat567GmGOpbER+h6/C+x7huXFq1+knbbT05Qoo0ziS859kPv1iwRD9CoGCr7fCtdufuMCGzp+gE9WmlPgHPeU3WDO724EeZ3REtZJz0W/MuYOYveMCmo57+MVHRxDkI1BYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+s6fhRZwxWqS9JrYyLAmPZ90tHlpAEHScTuTd1b93hg=;
 b=mDE2BbGF9XQ+U9YUUNzRv+Z3JXoHhsxfjnAxZIRxTgWmLB3/YpVVlI8IFInE6sWbGaFE/i2qwR3w8/fmYbPmUYwdIRG8OLoL6p8ypMD2XKO89n1UYD90IDp0WFlnDQV95tHJzybLF04kiOF4T5rmYn5NRXEW//gImpbqAQERol8NkfSs9OMsCUxsRynDM/GIis/tj1p/RpEztcVB6HPAb56w8VTjJsxX0ZUOXtS1OktlVCJHyLWivZK0Qsh1pICDwYtVpeh6uWlsTcfG0ozCx7IbXW9ltDOYdU/jfFiciEnjTf/gGwxKT814ckOObkZ62QktZo8UUhmy+IFyfI46lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+s6fhRZwxWqS9JrYyLAmPZ90tHlpAEHScTuTd1b93hg=;
 b=RhyeC+Ie3KfGxR/WGEE+eoYE2nrR+qFH76rQwxH25wZQHnY3bRl/7D9lXCTUc0L0ysaRGrRrDFmBAk7ktfgcjzYHvFSDwq/7RgwNflJ32W5nmxHpPvscN9XZSKSTsgtjMbC1oldwZOrLRerwI7lCv4e7V9Wn0mlBMfo5/OMPJls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 17:21:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 17:21:56 +0000
Message-ID: <cc2094c5-3cc2-476e-8d6f-72fc61ebab90@amd.com>
Date: Wed, 24 Sep 2025 12:21:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Adjustments to common mode behavior
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, "Wentland, Harry" <Harry.Wentland@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <29cbab3f-083a-41a8-81a1-b0234f36152f@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <29cbab3f-083a-41a8-81a1-b0234f36152f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a02ea7e-2df1-468f-f8fc-08ddfb8edc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnIvMC9ZZmFrd0RrSWZmYjZCNWtESVpkVGlFV1o5QTY1b2NkSmlhRjBjRGZz?=
 =?utf-8?B?amVMVm9QdExPOTZDOHg2c1UyN2NGMkdLNFJyNVhpaTVGSXJJTUovSW1RK3J0?=
 =?utf-8?B?SkVIeWVzdytWazF3SE5mUXRQeHFkTnhNZW03QXdKZmxHZ09wdlY5NHR4VVRG?=
 =?utf-8?B?ZW5qNjlDVmtRUWxlRlluSEVpZm5wakJNRVozWGJ2dWJqeGVoZDM5UVJ6Q0hN?=
 =?utf-8?B?MjVZNlpRT1V5dS9RLytmWmdxK1ZkU25KM09sT25oRkJUU0d2dnF2S3grd1Jt?=
 =?utf-8?B?dkhzeGFheks2c2dSdUFCWFpkRFdCRXMvUlhEQkxNaWNncit0NURtVGw4OVhT?=
 =?utf-8?B?UjAyc1cvUEladWxWYktXZklBRU1NRGtBSjRHM1dZK1NjK0xWdUZ5bHQxMHpP?=
 =?utf-8?B?eUVob21UK2JPRzJVT1R0ZGM4b2JvWlhnZ05BUDgrNlJwMTlzQS95VWtYcTg1?=
 =?utf-8?B?TkJIVkhqTkZLdUt3eU1TMVRPSUYybG1qNExYNkkzNEt5TW42T1p6aVBGN0Ja?=
 =?utf-8?B?ME5VNU5qN2FhR3JqdFgwZ3J0ZG1Eck9raHl4Vm4xYzA4SE1oYkYvMUZFTWZv?=
 =?utf-8?B?WHZneFYvT2RVUG1oQjd2WXdWckVETFpLdWtiY2IvWXdHWXVTcmNlN2R4WC93?=
 =?utf-8?B?UkIyU2hGMmtUTTY4TU4ySEMwWCtvK2xRUmhiVisxbVgxaHMrYWRhckVxMVJK?=
 =?utf-8?B?SFRyTnZQajRSRFJ1OTZKN2V5OHVqajdtQXNWYmRHSXpzZVdYM2JRTWpiN0Yv?=
 =?utf-8?B?cW5ZMjZPZGpQNERoZGdreHRqQzhiSGxNZW4zTWtDTHZPY0ZNT3NuanpDMEpx?=
 =?utf-8?B?OGMrRUFBRGVKT3E3dHdpUUpCdHdCT2JNTXhEckRCcVRRMHUxNjFwOTVjNjRQ?=
 =?utf-8?B?cWZVL2djNmNVSXBrc2NQM3JBdXh4WFJIMG5QU2xyUFAzbVRma1MwQy9mbThr?=
 =?utf-8?B?RkVWd1h3bC9QcnpkSHBXQjB6ZE52REhvRkVQV2lmV0RUQ1lDb1k1MFUwYUVH?=
 =?utf-8?B?cklBUXpncUxWeXVhQnA5Qlo5QURxR0pBK2JIbWFmNzM4dW9NekFEMWROY28r?=
 =?utf-8?B?MnVCbTE3SGY2RDlWUW84UnZiei9aQnhhOVltK2lKa1gvQUtuay9VcnJrVVE4?=
 =?utf-8?B?dmlSWGtFdjRESUtXT3pFeWxNbGV0ajk5SWhZUE5qVG5ZOVg4aTNNSEVPaVo1?=
 =?utf-8?B?RVZPVkdvaW9iWGs5czJ1OHczNkMwTTBkb1JidUtvODVtU1FjMHhDNzZOV0Z2?=
 =?utf-8?B?eVRTNzhEYlVuSURVRCtvc0ZONStlNEo3MWtLdEtKMDNDTjR0TkdhYzlWM1ND?=
 =?utf-8?B?allwSmJVeFpEeTFMVFdiOWNoT2xPWDJobmtXUmRNYXUwQ1FqSlRibEJtMWpV?=
 =?utf-8?B?ZkxhOS9uMFhaUmVvRUZiL0lMQ0xiV1dlM3dGdEZ3Z3NYRGVUcUhTcVdFMm12?=
 =?utf-8?B?V0ZNcDIrT05OV0ZkN0hOM2RiQjgxekhNSEVBVGs2bWFYdFBVNmZaVkdPQ0p2?=
 =?utf-8?B?OE5Ic2NwbGhMUS9JdWZuVWVtWVd2ZEl4RVFxeUdNNDdpaXU1dE5udzdEeFkv?=
 =?utf-8?B?ZjJVQlJxLzkzdklHaEpLbGFPTEVpOEtFNE01WTgzR05UeE5yelVzdktkV3hY?=
 =?utf-8?B?dU5ubHJKVWV3TXZDMmFmemMrdk9EV0NCc1ZSRGtja0NPdVB0eFAzQUs0UzdX?=
 =?utf-8?B?T3BwRFVxM3o5T3QrbVNHU0FyWk13QStKUzVqSThvaGlOaTZKRDE3djBPZlNu?=
 =?utf-8?B?bHpQUzVWeE9BRHlGb1VqSnpVYVUvczZuMUZVYmdFUG5kQ1gzajlFZnBNSzd2?=
 =?utf-8?B?a2l4Y2RRWU1iVmVHOGFJa3ZnVS9nRHpITll1ZmNQSDJYZHhPY0JHU1l3a2Y3?=
 =?utf-8?B?VGdGSWNjWkZDWDNxWmJYdVFBYmdqWk1WRDJBTkdKcXNvMjV2WFFtYWNnck1y?=
 =?utf-8?Q?n8S5xFS0UkE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yld4UUNxUitmUXhhV1dNTWtwaXlCRTZtSzl6K0tLSWZLaENJS29tV24xTmhQ?=
 =?utf-8?B?dVNnVEtGTHlZeGdMeTZXdE91T0w4OWQzSyttV0JneU96aFlZbEFlRnNXblBC?=
 =?utf-8?B?MHdvRXFoaTZaR3RVakErL2FWcVlac0lJTVZiZW41R2FJaEh3Ukpjb2ZuNGpy?=
 =?utf-8?B?WlFTMmcwV283OXNMb1VVSE9IRitPT3ZxVVNtYTBFenczejZzZWx5STdBS0Zq?=
 =?utf-8?B?L3dhL0dTSEQ2UUhkYmoxc0FwenZpRGp3RW9SY2o2MERJM1NKak9NaFlhbUc2?=
 =?utf-8?B?S2kzcUU5WFJHQktTS3BwRGxCdVkxTm82SHhQWlpUZENMc2xVMHB6SFRYVDRJ?=
 =?utf-8?B?WC90bTZSTjFqMU8rdFRyL2w2ZVBKT1VuVlY2ZkxGYVI0bW5EZVpEWmZEVDMz?=
 =?utf-8?B?MnZJVkFaZlR3R0lvVnhpYXRrWXppUTY3aFJaVFN5Nlpwbmw4SDQ1N0JMS2JH?=
 =?utf-8?B?Ly9qb0Qyemx3VlZiWVJ3RS9SVlF4aG1FZGdjUXNPZFNYTDVWQjY3WGQ3VmM2?=
 =?utf-8?B?aXlERXloL25oWHp3VDlkN0lEeXdlb3V1cWFLSFJRUzRUcWs4YWlpZTNIS2cx?=
 =?utf-8?B?ZjNVWCs0TkxRL0lXNEpTVUk1eC9DbjAwZzQxcllmNHViMlhpdy96R3BNMkYz?=
 =?utf-8?B?V1pkdXRSR3B1Sy9tWDBXdEtRN3FPUE5NRExHaHpZQUluZ0JxNml1Q1J4eUNJ?=
 =?utf-8?B?KzI4R0hxaUZodHpGQnhvRHJpeHVtNzhtSU51WWxEYWFJL3NGQnMzWU1GN3pV?=
 =?utf-8?B?MTVqdkYyd3JPVTQ3QnZQODRZdjhiZ29GY2gwTjB2dTJjc2xYNHBXOGRjYXJ2?=
 =?utf-8?B?UWNHbXNkODd0Y3NVc2NieHpETVAxMmhCUDA4Q2N3WTFkWkZSNHVpdGdVeVZG?=
 =?utf-8?B?SytaV2RUU2I5ZVhkTkZhNHFlOVBvQ2xZUkIvVXlMK1FudDlBb2x2TWRUNStC?=
 =?utf-8?B?eVVwVDJwOUNNWnVreU5Qd1YrNEhmNDlLdEh6bnhIS1pyS2pMeGxwNEZLTVBQ?=
 =?utf-8?B?SGMxbzd1ZmlCV3hLdWJ6NGV5d3VhNFc2anV4TDZmTXkyVmhKTHJBZnlLMTZD?=
 =?utf-8?B?dmZJUmU0M0wvRzRTMGxGeGdUdUYwUVN1UUFzUjQ2dk96VlBrdFdianBZdXdO?=
 =?utf-8?B?MWpHUmxhY0RGczNHbXQ2RHhYTmpYdHJVUkVSK2s1SHBOYnVmVmd5dUtWelRD?=
 =?utf-8?B?ZzQvaEFHQkowaG5JaDdtaWk3NTYveXZVVlBOMEhtMmR1MThnQmJiT2Q5RnJ3?=
 =?utf-8?B?VEFuRFdDRnlISkZvWTJ6S0NqZmQ4azFUU0RMZHhLZzZ4MUl3TE5qUkhIWURI?=
 =?utf-8?B?Zk11clRaZUxxK3puUWtZZHJPSk9DWkRrYm1MSGpSQ1pqbERwN1JSK0g4MFY2?=
 =?utf-8?B?WWttOHRDaTl1K0JKcXV5Z3V6TEl3V3BFdkQ4RXMrbDNZNE5ESUxNVVB0VlZj?=
 =?utf-8?B?RVpOOXY1ekZSWTVMMEpIM2FRcllLcXFFa01QWG1IbHYzRmUrUGF6eFkyU0oy?=
 =?utf-8?B?TFNuVzkvakRZZ1diNzhpbzBzSWlCaDMxZks0TXdzdUMvZ1crQmZreE90NWF3?=
 =?utf-8?B?Yit3MjlsN2RERlErcW5tL01LMURXZC9FeUlZY1lucmFpQy9XY1N0c2xJanVw?=
 =?utf-8?B?M2F4ZVR1TDcxQjRtVDNONGQ0VlcyZVBkVWx3SU1jdFR5ZlN4bGpTNkhlSVl4?=
 =?utf-8?B?VnFuSGVTUnVEbjY2NFVvYllQMnI5cDNFUU1OY1d0bVNpNTUvRFN0VWlYUFlB?=
 =?utf-8?B?aHhEWDJIb3RFNG9sNk5HOStwdGJndUEvVHJRNVZ6cnlIZTZ5Q3ZyRFFTMWFl?=
 =?utf-8?B?emdHU2NpTlpkWmx3ekVzMDc0WXRzSVphZjEvT043anBiMXNscXU1dWxjSU1E?=
 =?utf-8?B?dFI2WFhlU2RqNVFqUjlCUnoxck93VExYSlRMb0c1ZUt6aHJ1REtLaERLaXNE?=
 =?utf-8?B?OFZkK1JQZkJsT1A3MkVtYXNsemgySHRPTFpzNHIwQno0WUlIT1dEbHhpQWVS?=
 =?utf-8?B?VXJYbllWa1RKM1cyNnVzc0djSkVKekRva3J5cGlBdG9maEdSb2cySUJxNENI?=
 =?utf-8?B?eWVKdFE3Y3p0MEJtbTFPQUIxdlJOSjdZVEdjU3d2QWw3SXhONjZFSEdGWDln?=
 =?utf-8?Q?ShAhJqAXPI/kSS2PFUXIZC54z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a02ea7e-2df1-468f-f8fc-08ddfb8edc6a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 17:21:56.0854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9Tae9i9Pv5j9vITg5tKfKBpb7LapHgZLjut7i354gQFQGifyn29hoklWJlSY7AadSxWXWgOwl0CySHSpki8VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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


On 9/24/25 12:13 PM, Timur Kristóf wrote:
> 
> 
> On 9/24/25 18:16, Mario Limonciello wrote:
>> As part of enablement for SI and CIK in DC Timur pointed out some
>> differences in behavior for common mode handling for DC vs non DC
>> code paths. This series lines up the behavior between the two
>> implementations.
>>
> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> 
> Thank you Mario, this series makes good sense to me.
> My only worry is this: is it possible that removing the common modes 
> from connectors like DP, HDMI, etc. will regress somebody's setup?

Possibly.  We're not going to know until we try.  I generally prefer not 
to add common modes (hence why I tried to drop them before until we hit 
the Xorg bug report).

If someone complains about this then I see two other directions we can go.

1) to make both DC and non-DC paths apply common modes to eDP,LVDS, DP, 
HDMI.  Make them not apply common modes to VGA and DVI.

2) Enabling common modes /across the board/ but anything not in the EDID 
gets the GPU scalar turned on.

> 
> Two possible cases come to mind:
> 1. When we are unable to read the EDID for some reason
> 2. When the EDID is buggy and/or doesn't contain any modes
> Are these issues real or am I overthinking it?
> 
> Thanks & best regards,
> Timur

Failing to read EDID has happened in the past, but I think with the 
deferred aux message handling that should be cleared up now.

I don't think it's a bug if a monitor doesn't advertise support for 
certain modes.  Honestly I think we've gotten quite lucky that eDP that 
panels worked with non-native resolutions not in the EDID in the first 
place.

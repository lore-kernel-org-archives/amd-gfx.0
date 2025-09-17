Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8809DCA0EE8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 10:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D1210E71F;
	Wed, 17 Sep 2025 10:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3dYYHE7v";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012047.outbound.protection.outlook.com
 [40.107.200.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030EF10E71F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 10:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwYAIQrf24ZEnTukw0afG167Ya+i3ds30k2ZQPfVn2T/1I+tLjcP6BTmUzswjILRutSHe0hnngg8M0ZbBv8KCV9xgmVyqMYHgZ6YqBVWFjRKBtTYZCAmzkR2QSr5xlZzqVm2y0vznS1YC9MDQ5POhE0LiAUtsCuMOm4LsuPznc0rDsZ8uGit3PxSaYx3MwJ4sdwmJHP9nmxLGPKoXJPUnqUEVC6xK9omZjz+Q8u7sZapWCjggzKyClkniYqxEiTpXQFVx1qLgHuO/xAkXuBMwoYwaildbRcmCUto8eZOJONgkF0QLYxuYicEy1Cs4Qkm3DoWDX4WzdqBpqJAfAzujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkeEe+FGGC6O6c/GfZ17Mo9F4JSIwc5S6v8F1peLpeM=;
 b=FxBt07JYtYNuf9TXFSUaljzT729OahdvkoKMs3RUg3BZckctXn5lKGeB0Lj47avbzgpbOJBehvbfiJYuRnDcSWJADarXLB+5Ak4QmXyDRChtSPGw3tG762w63QwXS8C8dIA73wHTib/pDyjYfLvghGUktGr8Bksj10sLoxDHYguEF13aFDA7kYpjjwND4GiF+9YOkZA8oui341kjlwvcqLHTX4otEpu2oG8hTmMLQAFkfRSVILephGER6jpmd01eUTyW23gPeVMxv4HAOhloPvLuFz8+U9JafYWV+ycVVxuyJ6er7w1Xh3yXn0y72O+5NTX4nxWS4luXMW7qYw7q6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkeEe+FGGC6O6c/GfZ17Mo9F4JSIwc5S6v8F1peLpeM=;
 b=3dYYHE7vkGcGjrKw/9dRfRn9L8UQdfkPQTlA7Sx3h1x/S2Qt45aTBIrLb1pHy+QCsFfCZYwuwyCJAUtADEPtEqt5WtQEjVFrSTLXHh+oEfMVJaVgprykf3Q/bRTsrBlvHEjFTdAHP7gIB+1eUW2B0+hkPJqb1aDac31UQVUEyOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 10:54:42 +0000
Received: from PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c]) by PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c%3]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 10:54:42 +0000
Message-ID: <74ed415e-2938-4b3c-ab68-4b074d35e4ba@amd.com>
Date: Wed, 17 Sep 2025 12:54:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix pipelining jobs with timeline syncobj
 dependencies
To: Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org
References: <20250917095939.41615-2-david.rosca@amd.com>
 <c1f6d69f-7f71-4d6d-b475-fe22f5316ca3@ursulin.net>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <c1f6d69f-7f71-4d6d-b475-fe22f5316ca3@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::39) To PH8PR12MB6770.namprd12.prod.outlook.com
 (2603:10b6:510:1c5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6770:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acb74a8-3ef7-4877-3f1f-08ddf5d89b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDJaejRlWVhnKzJMYXBkNWRRczZPYUd4c0JvUDJtUUlMUnNDVUJJUUlHZWRS?=
 =?utf-8?B?emJyc052KzVoemczZWtVODd4ajlnTFNPOW9SMTJXK0JsbElOY001UmxON1g2?=
 =?utf-8?B?cDA1NkxMVGVMalMxUjRRemhib2tNajU2WnFpTU03aGgwU3M1YU8xNlZLa1VT?=
 =?utf-8?B?K09JeVZEMkxWN096bEt2NzEvN1BvT0duVFM4WllEb0Y1UlU5Z2NXQmppRGdL?=
 =?utf-8?B?S1lDRm0xem5tYTFZNXoyems4SFk3QVpPRVQrdzd2TFVkS1NQM01Hb29vREUx?=
 =?utf-8?B?a1Z4TmNjek1ZRTFsOEdQL2Znd3plYlo0RmFJNGgva0ZUNHdNQWF6RXIzNG8v?=
 =?utf-8?B?S2Y3RlVyZXEvWWZDbFdHcFJPMWFTUzdrcS9ZYlhqSWE3eXBDZVBlQlNOZFN3?=
 =?utf-8?B?Rk5SSGpVSkEva1U5YUxiYnN4WTRBNitTUVhwNEFURHJ1OUNoaVI0NkVxdVlI?=
 =?utf-8?B?T1NGYlU0am5tQ0ZPWmkzSDlZMlFlWjVxK1dmVGV0REh3NnVUM3Q1K0NPb3dl?=
 =?utf-8?B?eVlBWDNMRG1sdnZWUURxUXE4YmJyanhWR3hwMXFXdzNPWGxpaUtPaEc1YzdX?=
 =?utf-8?B?K3p6SGRteWZCMEoxUDNIWEdlWDk3SGFxNUVuQWJwT29CWTFQd3ZmMmxoVm5K?=
 =?utf-8?B?dGFkMEZVYXcvYXFVdzhJVVpMQmtYN2xHcW5oOE5IUnBvR2Q1d0w0QklYcVl0?=
 =?utf-8?B?d3ZGZzJodHJ2L2pxR2tYNUR4alU1bFVuZFMwOEt1K1FKdjFlVlBzVHE0L1po?=
 =?utf-8?B?TEFhTG5FMlJDbmFMa0NzamUxVlU2dm9DWXVRVWllSDNydFhTa2VDblhSRDZT?=
 =?utf-8?B?VU1Ic3Bkb1ZvODhPbG1kOGt3Tzd6dU4wVWxTTzNLZzZMT0hwRXNJb0N2azBI?=
 =?utf-8?B?VERoYWltQ0V3RHFnU0FqSEhNRHA3UkNvd0JweTBxd2kxRVZJekQzSTNvS3Y5?=
 =?utf-8?B?T1JjZ1lBS1pPckEzdEM5QnEzM3dpb1BZeHFVSTdmaUZ3dkRQenFnNkVuY0FP?=
 =?utf-8?B?dk5aVXlXcTBGN3NjNS94bHVvRkdSdnJ4YTVtN2ppaTllTTNUNWJpNmI3aDZN?=
 =?utf-8?B?TjFzTVMzaFZZWGdEOHl4UEV0WURoM1cxSDM3TGZJRHFiT1kvWEVDazh0d1Fo?=
 =?utf-8?B?N1VGVnJwRnBpSlVSSWZJZXFHNS8zb2VMKzdncVRXYnJLZzVsTWZCczdHTHpT?=
 =?utf-8?B?NWlaZitlZFZqcFhmd0ZZNXZxQmtwRUUwVEV5SHRTOGtkdkwwZStTVUJoY1No?=
 =?utf-8?B?RmVleU1LRDRiZkNoOEFxR1BmMWVJU213NTBEZjFlOWF6RGYzYUp2OUtMZzRo?=
 =?utf-8?B?V0NBUUpVYjc1Q1VNMlBTd2VUMG10QU5xU3RSVVBQZW4xWUtzVDVvbHlGNTQ1?=
 =?utf-8?B?alBZaG13VkNDS3J5YktRMUkvcXNXdytwbjNhUE02YjJ6WWJaYkJuem00cFFR?=
 =?utf-8?B?QW9zWUhITHpId0NRVUZHNWxyRkVKYStGVXRTc1VXVTFLRWNiQm1YL1ByalQw?=
 =?utf-8?B?TXAvV01ZdnErZWpibVV4ckpzNHRpYklLN216N0ZJWk0yRFpybi96VzhUZUVW?=
 =?utf-8?B?VFhzYmhEWXdnc29HVkxvak9SNDB3UVFMODhDV1F2Y2xjTXYzTGNRdjZuSlFP?=
 =?utf-8?B?eDhSSjBpcHNFekV1T0ZGMHh3UHd0cytnVUZpdTZHa3lKK1RQbUxycXFwVHFi?=
 =?utf-8?B?QlJkSzQvOG15a1VJSFBNa0twQzB5ZE1kcHVGZ3F5dDlUdThtVUxvc2VXTjZ6?=
 =?utf-8?B?SnY0b3FOM1crSWV3dThRTlZzRzhubHpINGhRaFM3ZGRvNjM4Vk9qSUgwSHZW?=
 =?utf-8?B?MVB6ay85WU4rZWhVc1lQZ2pKZGhKRlRXdDlLWEZrS2FFTWRRb1FXWmR5UUMx?=
 =?utf-8?B?N1pvOS85alhiS255TXJLUFdGa0tLYlA5YmZ0dWhXN1NRZ2RDSDZtdGFCR2FL?=
 =?utf-8?Q?c9mTlzb6+tk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlhoWGhCWlJTbzNNRVlKTDV2a1ByMm0xOHlaRTNPWVdET3M2QkdCRzEvcVJI?=
 =?utf-8?B?UzZBZ2t2bTdrVWtkSHpFcEV6V3NGVGtmKytvYnl6MnpwWHRyRUxRcGdYVlpE?=
 =?utf-8?B?cEtudWlYcXE1d1NNRHg5VGtjRVYwSzNDaFl3d3Blbm5XaDMzZUtKL0liMkQ1?=
 =?utf-8?B?dmNHY0o2YlVlTDRhSDgxS1dZTzFEVVozNkVLNVQ0VTJCZGJMeWtYSWROWmJX?=
 =?utf-8?B?K1ZWbUFGNXBEWEhzazNGM1ZOcTJjWTUyRnRRSEZITkErYUZiMjlIcjJFVjdx?=
 =?utf-8?B?V0ZkZUNyUm5VUEV3UXBIY2pycXd2aVY3WnNIRG9EanJxdm9zYkFhTHZaOGh1?=
 =?utf-8?B?UUxtU0tTT2ZnY1FUUHI3RnpHKzlLTys5ZzFHakhiMGs2MFh5K2tMMnQzUWEw?=
 =?utf-8?B?UTkzY0NoTkozL0ZxcUxRenVYMVpBakc0c25BbnVHME5xNVRCUGdEOTVVTGpn?=
 =?utf-8?B?bGRURFplRU5mZC8zSnB6Z2VQU3VvUGNDckkreGZwU1p2Nm84Y1E1c0NXWjln?=
 =?utf-8?B?WHpDbW9zQWpVZHg3cUltMmNzT1lwNThyV3p3aGFRMWVSdjF6RU9yT0lKMVly?=
 =?utf-8?B?ckZFVGtQSzJCN0hCWGRTeHlmL3hUSjE4SmNRT0F2OCtQK1dkbXYyQzBDeXN3?=
 =?utf-8?B?bTZCbEIxRWVEWnFmbUtZSjZtdVVIMUxvUEhqVlpKTk9RSHg1V0dHT1BPUDIv?=
 =?utf-8?B?eFZ5a090SFg1STFDQ3dacVpBV2IrbjBMNnVrMzN2VTU5MEhoZ0pIelluN3lZ?=
 =?utf-8?B?T0l0STFkWW53aDJGWHR6eWJaUzdKR2d0U29PdE85OGUzQndNcjBTUDlxdytK?=
 =?utf-8?B?VEdpTmY4VlNzRUcrYUVMQUlzaXZOUWxMMXA2VDd1K0RKSyt2L2VUZWZhR1h0?=
 =?utf-8?B?VEk4anBvUWtrdW44ZG0rTXp4R1NwRFIwU3lXMkkvMUl6Y2VnV0pqdzBwVjZk?=
 =?utf-8?B?OFQraUhFOHdrV0tEZUFrd2x4NlNGdzJTdmNnR0svWmYzY0lsVk9JRXFKWVF4?=
 =?utf-8?B?cUk3c2ZtZjhEMzVaSUp5SjJKcmFvRGp0MnhTdFVuWVBqYnlWdTBSV1BXSTh2?=
 =?utf-8?B?dGwyRVRhYVdRbjVtNnF3OUduS0lmeWFBUW1RNGZaallMbjQvVkZYa0lDSzJD?=
 =?utf-8?B?eHpXZmRLd3JxeGlwZ0pObmxseWV5OTBhQ243TUlidU14U1V2bEpoNStEdWtw?=
 =?utf-8?B?WHROaVRuTEJpMlIySXd2bE84ZEVFZlFCUVptOEs3SElpTkkxUXN6bDZiLzVL?=
 =?utf-8?B?bmRZaXIzODVkb3BNaDBETVJnZnN4aXlIeTNVbncraXhBOVZuZjdlb1FPRkdo?=
 =?utf-8?B?TzlNSlRBRnpnZUtvUUFhbDgxc0o5bFNONUVXbk1nM0diQ2VGajM0Ukl3Wi81?=
 =?utf-8?B?SldTZ1ZpV1hDRW1NYThDR0h5WWZuWlZyYnNCUi9wWjZUMkQrSzlaMHFxWTdO?=
 =?utf-8?B?U2ZuUHpRa3U4OVJUQjRWNHRjbERWYTBOc2UwR2JsWkNJd1Z4c1FzcTZ4MDV2?=
 =?utf-8?B?K2NEN3o3K093NEFtNFErOWx0YnpEWjAzQmJINVVYZ285MlRIaDY3NmVtVEpo?=
 =?utf-8?B?YVNjOHRtSmZBRlV4TndLMzFYVXR2WERwc0l5bUl2NnkvN3NTSGJPR2ZJdG5Z?=
 =?utf-8?B?NlJSc3JyZFJ1aVM0Z2hMZytzMDh1UW9vMm9wcWQwOHdiQmZ3bW5BUHB5Umsr?=
 =?utf-8?B?Q3d5ZExlOG5YNWJmRlFWd25jRzhCSm5aSlZOQ1E5U1JLbUJsWlNpcGx2aU4w?=
 =?utf-8?B?dHlEVkZqWksxWmJCQlhQa0JrbDE0Qkl2bVQ3YnN3UFg4RG9ubThPbFdLMHpM?=
 =?utf-8?B?N3lFMEplRStrdThNa2lZRzNWQ01FRWI0SlE1TjFBZmphRmVZTWFEVS8zSEFi?=
 =?utf-8?B?ZmhJZ2VlRzNQWlAzTTBYRmNYdzF2RFVSRk84Yk11MUtiVVpzNUVqbklYZndv?=
 =?utf-8?B?Z1hYSmsvbU9veTNuT1Y3R3R1TnR1d21xY2k0QjNKdGdMbnZ2bVQvYnlqYXUz?=
 =?utf-8?B?VFZLeGo1czlaZWpXYkRHQmlQNXBXOXlTMFlnTXhZSERDaTZjL3RuRXU4MnU1?=
 =?utf-8?B?UG4vS3o3VVdTY0w4N0IwR2dIWUNOV3RIV3ZmVThwRnZpWjVxVDJsVUlwc0dx?=
 =?utf-8?Q?mtcib0+gbXC7KBLeBc9bOT7ZA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acb74a8-3ef7-4877-3f1f-08ddf5d89b16
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 10:54:42.2170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7OAHaRyTSjEmjYEoTZSY4zf656xWoxpoWY//ViED5rIw2VsvREH7k57ES3enj8bOgYCMyZY9/rQCWXCESictQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
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

Hi,

On 17. 09. 25 12:15, Tvrtko Ursulin wrote:
>
> Hi,
>
> On 17/09/2025 10:59, David Rosca wrote:
>> drm_syncobj_find_fence returns fence chain for timeline syncobjs.
>> Scheduler expects normal fences as job dependencies to be able to
>> determine whether the fences come from the same entity or sched
>> and skip waiting on them.
>> With fence chain as job dependency, the fence will always be
>> waited on forcing CPU round-trip before starting the job.
>
> Interesting! I was sending patches to fix this differently last year 
> or so, by making the scheduler use dma_fence_array for tracking 
> dependencies and relying on dma_fence_unwrap_merge to unwrap, coalesce 
> contexts and only keep the latest fence for each. But I did not have a 
> good story to show for which use cases it helped. So I am curious if 
> you could share which scenario you found gets an improvement from your 
> patch?

The scenario I am trying to fix is very simple to reproduce with Vulkan 
when using timeline semaphore to sync submissions on the same queue (eg. 
each submit waiting on value signaled by previous submit). I have 
noticed this issue with FFmpeg Vulkan video code, but it will happen 
with any Vulkan app using this pattern.

Regards,
David

>
> Regards,
>
> Tvrtko
>
>> Signed-off-by: David Rosca <david.rosca@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 2e93d570153c..779c11227a53 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/pagemap.h>
>>   #include <linux/sync_file.h>
>>   #include <linux/dma-buf.h>
>> +#include <linux/dma-fence-unwrap.h>
>>     #include <drm/amdgpu_drm.h>
>>   #include <drm/drm_syncobj.h>
>> @@ -450,7 +451,8 @@ static int amdgpu_syncobj_lookup_and_add(struct 
>> amdgpu_cs_parser *p,
>>                        uint32_t handle, u64 point,
>>                        u64 flags)
>>   {
>> -    struct dma_fence *fence;
>> +    struct dma_fence *fence, *f;
>> +    struct dma_fence_unwrap iter;
>>       int r;
>>         r = drm_syncobj_find_fence(p->filp, handle, point, flags, 
>> &fence);
>> @@ -460,7 +462,11 @@ static int amdgpu_syncobj_lookup_and_add(struct 
>> amdgpu_cs_parser *p,
>>           return r;
>>       }
>>   -    r = amdgpu_sync_fence(&p->sync, fence, GFP_KERNEL);
>> +    dma_fence_unwrap_for_each(f, &iter, fence) {
>> +        if (!r)
>> +            r = amdgpu_sync_fence(&p->sync, f, GFP_KERNEL);
>> +    }
>> +
>>       dma_fence_put(fence);
>>       return r;
>>   }
>

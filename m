Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50B8FF885A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 08:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 718C810E318;
	Tue, 28 Apr 2026 08:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mUstBiHP";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90AC610E318
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 08:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKPOQhLE6L+1nNKAowENxWdZS4jLzBXl53jpwWKJsuFGtglhQbcD1XFIgnvIPWUPtIfbB7YtjuuLlWZvtVRwoiaIv4sMRkeogKgp88uUHWD8V6GrhJdJRlIMW9ySHtD9ML4gx4n/bW0XdHRpXguGGvUVT9Km3DTFTVPD0FI3FlmgoyED4iJBvXyuU7VpGOqfEmxZIncKtvUBO/BDCtSxC1hw9Y9kLxT9HwpF0Xy64M9nSN79zwJGFE7jFqCzayBII4G66zOZClARzn3kmwzP6OSWI4yE0YY7ZJZP/JGW9du8l0k+Za1AwLzuTsLxDnGzofS19qbCBeIFhCNUDWdVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW+dgyl/nV/FvnRKhYumBaNGg8FTK0JWPNex6Mut7zM=;
 b=EO47VVOXM9bQvTKPzN1il5RZgFvP8gK6Q2f2PnAknQFEBmF2glTdoK9bE8LKTMD9u+o1/HZ3H5jURBn9CCWJJ8bPRa9F87j90WSsGc/Qq0dZGrlabFPMH/BCxfjsf0uwdI31UuGePg154ju4OLSTqM5liAiD1k54x7Zfj9kj/NnDqGzgB5rzsgUSXAHXtT+KJjTiC/RIik1XKwk3hOHbzK3i3X0/7NPUnbFd2212SCN62FJABUsL6KkPk6QqVTw1HOusGh8jSkMyQUiCDyuz1822ck+vX2XS9q9pGGBdKL1ryzVzby6QlOefD90faX0wMjO8gjtWlST1x2FiuopePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW+dgyl/nV/FvnRKhYumBaNGg8FTK0JWPNex6Mut7zM=;
 b=mUstBiHPZB+vZHdHaPsEtQbOS/oJL3a+Q0PdMgsi0EZ1sm8IzdPcYWafGrHm86KT9dabPFNESCP588G4/W8ZOqzJiqBci4w9iFtdDlJGEjaqnWEF4NrdjJ89rRac6ISByIKPdouI8hNNqtGcJectC/3YqIWkUUqXvNbJztEVsxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 08:06:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 08:06:47 +0000
Message-ID: <1fbf0c4a-a36e-47de-93d3-b2507dbf62af@amd.com>
Date: Tue, 28 Apr 2026 10:06:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu: nuke amdgpu_userq_fence_slab
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <DS7PR12MB60051578D8ACE86D1FC4B13BFB372@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60051578D8ACE86D1FC4B13BFB372@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:208:239::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f90e807-2292-4a9d-60df-08dea4fd185f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: LvrD6zItpwlZEoknrcvwcYb8UYng8W1207crjo3YzpKa/wnjfZH0KMghOaUgrn8i8YbohdKlpjjmvuDuOILX94oYuZtSF9SIBjyxQK2AzI7lKrYDdyp0cdi3T9Q9PaGFQwi/Wi+K0Xt8FQPYWZ8OB8VarANejPM3zZRWGlaLWKspUpkQ8mVGZxRm3XcWZBI1KOJHG4HjSCbXCieKk37m9QG/bUC6Gx6DTSO82Chd+kRt7/KjMdqFUyj8id7iMxSa3jr4IiMPdrd883OtnR2eT+y9xoF5BhGta54X37P+qczLyT/4mg11YBh/GDZxmMroohaGb4O8MaKSV4R4wZ//mmUoj7Cjg9lbQ+9oiyaPE/F/GMpOwFglZ0YKilDO4hDqJIEgIRtEgkGAastyKPpFUAebW5F0boAWWBGzJv/qpjE3v3weyCrlfPpw7uvN7VU5s2fi2N846X6NX9H776XuZgD9tisTFevL1TGgHgswPjupH7YE0564xigeTvI9LA3TrPoR4hLjOTulZilpbeo9a4TmdgbbBO+53JiADxSidmwOoMpel97su00ThYfx5OEqWntQ64MG+cJpDi8yZjqi1Ej2ZO8yCTrbGWkBibzH73ip1HKbu4HtcxeAakezfP8q0WwLNfa80cLKIJVfhVrQ4v14Y6NjYyn5BRtJ53Z9swMeEP35N8ocHpkW0ZMtTaFL9G3dLuxegrLj+BPjCjU8OjrOOvKalp7HgbKXe6FIZtc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDNaYUYwQ2FGMGx2VUI2cFpLby83MVplYlNzdWJKZWp1VU1YdXIrcThFbzdD?=
 =?utf-8?B?b2Y2YWs5SnJlMmhOZnhZTldIbGtVTUpVVzRXUHBhaEp2Y0lrRWwzdCtsbjhZ?=
 =?utf-8?B?VXE5TXJwSmYxOGV5WjlaT1d2OXpQbXQ4TitHVDYvVDdCb2NPL2lWYzY0NU9n?=
 =?utf-8?B?aGExaFpiZ1pPT3Z1UGkyOXBtc0lXWE1lclhFbkhZTUlkUG8wbEgza2gyUWVH?=
 =?utf-8?B?WVlkMHVBa25Tb0NveDhSV3dnbkh0TzZPNHp1WDJpOGxZeHJaT1VrZlI5VWZT?=
 =?utf-8?B?Vks4ZGtPdmNremQyRll1MzEwbnlpMkxoUW83SWZESTJYZllaSWpoRlFIQWE2?=
 =?utf-8?B?cEN1SC9zMS9XejJtRURRM3cwNVkzUVJTU01JYk9mQWlNT2lWVnkvSUs5VmNa?=
 =?utf-8?B?N0pDUE44dGphZVdCUFIrSHpoMWg1UW55aEZlNndXeFpoNWszV2l2cUMySXVh?=
 =?utf-8?B?ZWpCUElFbjJLQkY2SW1TOE8ybzdRdW9ydENKbG5HNThwT1F1S1ZkNWJlTTJM?=
 =?utf-8?B?aytFOTVoV3NYUW9lcTdseXVLWlF1aVJRa2kxUEVxYWoxT3BQTldBYmJKSmlK?=
 =?utf-8?B?QXRUeFBqY3pBK2ZLb2JUTHA3MFhMMUtQUnlTTWxzdWNLbnVnYWoxRjVOeDJh?=
 =?utf-8?B?a01tVnBKekM4NTRUOEs0WDJFQ2VLR0Z2SnAwV1cwd3BqNkl6VzhRSThCeEJB?=
 =?utf-8?B?aGNwTTZydzYyWlA3NlhETm9xK1hiR2lYek93REpmcWJveEVxalhQbVV2Y0Uw?=
 =?utf-8?B?RUxXSVQ0Uld3Y0NLT0Z5ek5vVWcwSTZuTk1GRXVJcGFxMWliSzZReVlhMkpz?=
 =?utf-8?B?cnNrVVJZUTNpRkthOGNQYTNnNDUwaG04WWdRODc5b2RWZzFrOFE4VEI5djNC?=
 =?utf-8?B?c0RyODZqSTh3MzZMa1M0MUNlWjFhM2ZRbWtlL2pPcEljWVRIbTRISXkyd0RW?=
 =?utf-8?B?cllVYkJrZ0pTMHFvQlFYNzZlUXlNNm8zakFseHgxdzNYL0VkZWFyajZhL0RJ?=
 =?utf-8?B?RTFLWG9RQVNPN2krbUlyUHJzWnBTdlFPRmJoRzBSdWZ1cjFnVUUyL0xNbmJG?=
 =?utf-8?B?V2tnUkVLSG8xRFcvcTl1U0dTcytML21PRXdNZGtvYjRGa1lFc3JyNWJOM1pF?=
 =?utf-8?B?QVplNHh1MERhTFlPUlFMbmZEOUFBUERFeGV1dzQwVnZ1OW1kMUJKVmo4UGov?=
 =?utf-8?B?RDhxTVFXeFBDVS8xSTZwMXFpczFNd1I3QnRvQ2JPY25qRGJDYXJQYnhzNkZ1?=
 =?utf-8?B?NHNMRzdJSGVlOFExODM3ZEV1aFFRN2dWQ3dISHViNXE1blJLWHBVODRaYUhH?=
 =?utf-8?B?ckRmVUFGOUZzZld2QWd0VDBSV1A2R2UxTHpuL1FxZlg3R0RaRnJwc1ZDVndV?=
 =?utf-8?B?UEJmVHFtM2tod040cXo4RVBaZDk4bWYwR0EwRHVhREt2Um5rWU80cVRTUCt3?=
 =?utf-8?B?WjFrbVNaTVBNTy9LNWxiUER4djcvYnRvbWNDVXEzTldHeFF0dWxEZzJlRGFG?=
 =?utf-8?B?R0IzKytkVWRPbktEZzdRRlB1QWxyWjlreXhuWG80OUw3OUs4NVkwZWJ4M3l3?=
 =?utf-8?B?Qk9zd25UcHJhQzVUUVlPK0dPaGQ2eHhpMWk4dVU5NC9YeHR5bUk2aXN1NEgr?=
 =?utf-8?B?RCtCRmc5YjBqQ3VxTlZVYzIxL1B4enBZUmF3aWRzMFd0bUhOYjVjQTZvSkdR?=
 =?utf-8?B?cU5qU0QxdXRsYkkyckVsTmxSbFRnRk4zZEZnbnhKY3BzaEQ4Q09Sc1V5c1FH?=
 =?utf-8?B?a2pnbytmK3djL3VPWWVSVGNnQ0pyNDdIbjBBb0NDSlF1bWJDdG5hbTBYRU5R?=
 =?utf-8?B?QUdWQ2JZZTNiRHRUaHlvck5jYjVSRjFka0xGL3ROa3ZhK0xuaFpvOUlNRnRp?=
 =?utf-8?B?N3dTQ1owYkd2M1Ardk8zVkhERkFHNFVGZ3JDY2t0UEtUWUR6ajErSENJNHB6?=
 =?utf-8?B?ODlGR3A0VzIydndpY1NFU0dLVmFpMmh0M0VuWjQxUkV3TkFmbVJnaCtJdFRp?=
 =?utf-8?B?L2JLYlQvUkFvMkJCZm5La2V5RzNxMUFjRXkxUGQrZTJMTVVYdElWRWlhQXdt?=
 =?utf-8?B?THR6TDkrb28vNHhTSlU0UEI3UGVOaktPTDhGeEk2c1dMRTY5aURBMTZEa0Ez?=
 =?utf-8?B?L1VLZjlOWG1Ud0hrMTNaaldDRUw4d1Q1bnhoUi9DWGh3cnZQeVJidE5RQnp0?=
 =?utf-8?B?RUZuODNXM2VLZ2N5SHAraXRpK3dFYXU5bm8wd2tLbFhvbHA1VW53QnplcWxQ?=
 =?utf-8?B?aUdQcXpNUm82eDBVcGV3TVVSdUJWS2Z2R0FXVTVVbHRoVlRZTEo3RGFEdG53?=
 =?utf-8?Q?EnCwaUU2EDzmNyaNyL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f90e807-2292-4a9d-60df-08dea4fd185f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:06:47.8260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbwvffETCDCW+8zuaUICZ71uSQIzaW1MQdqtRsG4EbXKzId1kGwakRHoKgEJ7BJQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
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



On 4/28/26 08:15, Liang, Prike wrote:
...
>>
>>  static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)  {
>> -     *userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab,
>> GFP_ATOMIC);
>> +     *userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
> 
> We might need the GFP_KERNEL allocation?

Ah, yes good point. I just incorrectly copy&pasted that here.

> 
> Since the userq fence is a small, fixed-size object, this change may not have a significant performance impact. However, fence object allocation and deallocation should be profiled in scenarios where userq fences are emitted frequently, as a follow-up to confirm.
> But now, the patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Thanks,
Christian.

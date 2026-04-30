Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BF3FF8875
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 13:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9B010F336;
	Thu, 30 Apr 2026 13:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ddq8UQGm";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE7710F336
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 13:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNqCgwdjkHaGJcZRYVYVyGcXrvWDfGOZ2RqZEFBW9bJu1c0fA9Usg9hxDbmrfgKRCexNpvooAPg5xKFGRP8tRrmAGXpBuKQzrLlxb8xMuchPSpKgNAiltrrW9u5fx7TCl2iXD9lQ6MC7OZJIXy1cD1tm7r3CRlmaZ/tBHNlYWRGg19t5rq5TfC2P/gMSCqrXh6qxS/ikvF9VHsF2K7xB+Dj11f9hlQW8lSQ+STvwKwa+sZyzGpkpo1IlKS5eBZ15Z0HfS5QAuEa4xjrl7wFD7t9i8G0cji6o/Ukk0Hh1AzPTee6iF1C13S13j1LR8X2GXCmfqSWJgH4oZ7BoCr800g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kRIUaasvca+hp2PQQ475OjuMRUn7n5M8zCPcdGwiXA=;
 b=wKz21ig7UinB1+OJwOwO0lJFzf9lamiixNRMrvTvLzuSFBz9xzP6de+VSwgW5+eSwGui1nNzOILVCAGxG5svY9QY/O2w0hHRRtRppIEla8xIl8eErF0q26i6UtO54zQl3jPb9G3IIZsNjk92Soc2XqKfUAAZ6IiObPQ5MEvYuySrHW5qRrXXRi6OuKvoTVaGRfb0COyrRyjvLvmVZCVptz8q6PNQfOr2ibb7WIQqNYa/SyIvePA6YDd+uWekgkcSN+RcQFpLxfhdoHwIKl5C9ZmWCZqz5VCEXzpdyveEmp1On2p8TpFlidnc8/g8xczMz65v8cIMSe3lFnEgja7LiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kRIUaasvca+hp2PQQ475OjuMRUn7n5M8zCPcdGwiXA=;
 b=Ddq8UQGmBdGTcUBtLSoAIomvauBqA+qb6XkgnD0xyzbBTHeTzadbTixYp1D9LnT3wHw3v0rJMa0m/S3jemfHqpXWbjXD1kiCWSCnfwoDKuGBVPxmqPXKFsZ/hu62BkDOevClOnG2hA6BeH5UEyenFCBfhoD6uNfoItFEoCdk0Xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 13:22:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:22:32 +0000
Message-ID: <acb467cf-0b2d-4733-8df2-23f1ed18b4fd@amd.com>
Date: Thu, 30 Apr 2026 15:22:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx: extract compute wptr doorbell helpers to
 amdgpu_gfx.c
To: John Moore <jbmoore61@gmail.com>
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20260429202042.21718-1-jbmoore61@gmail.com>
 <6266086d-15d4-476d-a992-503509032dd7@amd.com>
 <CAPUYzBf8EBynRij60SR+EFg1Kn22cyykSOOPxo709bq0xhjpLw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAPUYzBf8EBynRij60SR+EFg1Kn22cyykSOOPxo709bq0xhjpLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f71312-3934-4fe5-24d4-08dea6bb88be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: sM9774ccu1xZCY1Mt4sJRb2gU834CMoNCQdXJiVjkQw67qTJwS+ICw0UijFm3dCdzoaimhmMhxBmTLcd7iScPgHmhK7Pg+V8+S3AlOehkMrkW21l/adFtZt8+IHhdl7YMlWa8V5p1oeAhK+90DXlmZn/BjoUZcT2npQMJQt5529tkGlwawq9j+/X8DfbZb45TuGMDWHcNO7xM5H2vtzxLyALlP3Cw8asVub0Z+8FAOqAXCOsVrrvWB/pE8Umc0aB11NPCjzgoz2a6qKYdH/xCKD3Bsk1yDm8J1c0LSUuElEI4YfOMQy1GgrMRFYsQzKZoePXQF0GiBI9SWwFInNKeNAqHeeDXMNt9aH/PUq2B1QXRTM78/ZRGRGT5wslZ10KugbxWEp7+umfPMASN8q4XGUFvdcoAXeMegKG8JNOhLACi6go6LacAlkLENCizKmI5pSSxIrrXgC8YYGkbayV4yFox2KEsoxlPdozDmrr3nZuXk1AdXvuXhfm9KPAyJoLBl0ma6E9agbEcKapqoQTKsDoF6nYchXeEVODem1H+4tBOuZ/U4xPQaEK+SR6l22HL60fMkcczH0RxHZNw2QORUob2c4nCfCYjkOEIjz0ZKW7Wtvn+WGbKDsiKzDemKDEWyTNr0vpN7nM5K/iwb9R28FoBT1ezGmb+iODWeKb2tb3ZqKn5vZ8Rf+um4zl3rSogOBG7fQ1eC0Iro2Ruujek/rH9oY4ed81nnf5jPmv11w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1FZMHRTZ0ZnSWx3bUhVRTJUV2ZtWTB2OENLMzBTYnpwUEsxL0MrOEhLdnRD?=
 =?utf-8?B?VlJhMUhhUUNOMllsUGdNblBSaXhmUUE0ekFyOGpFOWR0U2xWMVdwRm5qZmI3?=
 =?utf-8?B?NUdBeEQ2Rko0bytpOFowbERlbzdjbVVxcDhySXg3U0xVWVpZOWJmZVNIdFZt?=
 =?utf-8?B?MVhCakc4K0hJOVFNcStSQzdZa1ZZdnFuV3NBZDVMekJBbDZxNXJ6b21kWit3?=
 =?utf-8?B?WjRoZnNQYmFQS0ozTXNLRHhDQkpQdU9VZE1tdVBKNjdnd1psSnJyNHVPQ3Nl?=
 =?utf-8?B?dnQ1eGxvbFY5eTdnVGtUcUJIVUNSRkdQTHVwQkFSL1BtYjFXTWFUQ2JaTDR0?=
 =?utf-8?B?d2ZEbnhtNGRCT2ZOT1UvT21hL25nMSthR21NV1pDWWNOTkViV0hsVDBaU2Uz?=
 =?utf-8?B?Q1hVaG1OQUdDNDBqWXN1UldiS0hzMEVIcy9SV1JKVCs1OWYxd1A0UUZnZ3hP?=
 =?utf-8?B?ZjMzYmtzSlk2RUs1cWhuSXdCL3BQNk9qdE0zN3diMHhBTG1pdlk4UDNaSUVE?=
 =?utf-8?B?bVpuWUMrWmRmSjEyN1ZCVkc0NTJWdTR4SWcwRTNQdlNFZ0tDd3ZXRVpDOUpk?=
 =?utf-8?B?N0dSU2JtMmZUWXR6TzI3dFllQWRDcXE1TnZFWWhqZStBczRGM1R3ZnVEYnVN?=
 =?utf-8?B?MVhlTVZnZ1h0a0liSzJZejNpZzRCZzJ1QmJVVzU5alBiYUtDb1BCNXBOU1NW?=
 =?utf-8?B?SURNSTRVV0twZ0lYck5WSHFWbFpVd2dJVFJ2SWt3cERKdTVVN3A4M3FEOXZs?=
 =?utf-8?B?KzgwenJpZU1aSGtxRWd3SnpkbDc4MTBQbHQ2OGswQ3pieDZ2OERyVnd5aC9U?=
 =?utf-8?B?TXJmZE9MTkl6Z2tCRWFlSHVkZWxwMWhobjlaeXdwWjF6Nm9JRndnRVhZUFJR?=
 =?utf-8?B?S0FONFJDUzdNQmU1LzVoQkRmSTV3QVZYSHN2aDFRK29lTStTd3Rjd0hRRDdn?=
 =?utf-8?B?Wk13aUJ6bWhDNk1FeHpTMmlvOXZINXB1YnVSVlFMTENpc0lRaER1b1V3NmlH?=
 =?utf-8?B?OGpxbFRxSE5XSlROM2RLMUY0cE1ZeUhOekpmRFZFcHB1ZUgySjFiM1BKa0Vq?=
 =?utf-8?B?b05wZ1NkUTQyZERSWDVqLzFUSnNncVUrQ1dYdERabXo2SUVJd0JPek04NUFW?=
 =?utf-8?B?ZFg4QU56NmdmV2lZM3djQmJTY1dTVjlSQ21jeGRYaWdHY25Zck95bmR4WGg1?=
 =?utf-8?B?SzByTm91K3k0eVpqSWxuOGQxc2VuM3JGRHJMSHc4MnVLL25wenR6bWcvbWd6?=
 =?utf-8?B?VjQ1c251ZVBnRlQzNDQ0RVJlQzh5c25xeEh4NU5EY3R6UFRlSm1xOWV0dFZ3?=
 =?utf-8?B?OGhPNEt4emVFNlk0OUt2Y2t2ZTl2MTdXU3lRUlZBOVZseWNVdGtTMGU0SjJX?=
 =?utf-8?B?S1VidWVhQVNkQXptc1pQbktGMVFITlpXOHRNZVZ2WUFZMk8yY29nVlJxREtH?=
 =?utf-8?B?REE3My80T1dsVFFJRHNXcm9zSTNiN1JKL2oyUk41KzlYVzZzWWpoK1FWUUJY?=
 =?utf-8?B?M0EwTWtKcFFmNUI1WEFNUnV0aVBmWVdJTU8zdjhlSmpNbWJodWluMEd6Ty96?=
 =?utf-8?B?K0FwNnAzZkk1RVFrVDM4N3gzQkw1UnNhQ1JEb0pwRlFZbFJSOWxRSFhUaVJH?=
 =?utf-8?B?MkJiSHg3ejBmT0pHVm12RmhJTHlFdFlsUTl5djd2QmFlejV6OW9IdWc5eW9M?=
 =?utf-8?B?UTdqVFNrODBPMkNUdlA4anN3SkJRZTRGQzN4WnpVdmZsOVNCNm1TNFAwYm4r?=
 =?utf-8?B?dkExN2FESS9uRXNTdlJjTk5QTE1QUG5NZFF2OGowRitVQnVhdUFzUWFYSjN5?=
 =?utf-8?B?Z1VxQWdhNFYrOVZ0RS9LSlkyUlZhYVQwK3JpMWhjSktqWkluTzZqVFVWRlR5?=
 =?utf-8?B?c1lic25jTUNGcTZjTTlRaWV1TUxqT2pJN05XU0ZjcFVab0RjRlJLaHFDVVNV?=
 =?utf-8?B?eXBPK1JyOHFSUEJ3Y081TmVFaGlpM1JlNXBPMWg1ZVBidFdoVndHMnBaTndX?=
 =?utf-8?B?ZHFPY1pXdE1NTHlBTGtTcUVCaGhVV2pzVTFGNWtPQVN4Q2UxVk1hMDR5Smcx?=
 =?utf-8?B?UC9keThidmtWNzBxUzVTdFNmZHBJOE5tbUViUlBxUkYvcXZKL1FseFoveTRI?=
 =?utf-8?B?RWtsU3pYWXRLaERyRXBab0dJNGhUQjdpUWdHOHRVVTNhSWJnVVRIT2Exa3BG?=
 =?utf-8?B?bTdkdEduZkc4QWhxSE9WRjBnOEErQTBORUNOOGVZNHE5OXY2c3h6aFR4MXkx?=
 =?utf-8?B?ZWt1RGYwdTJuRHNZbElTYnZ1VzVrUXdSejNTMWttd3BlWkpoN01oMXFXNFVC?=
 =?utf-8?Q?jPGpeQHbyDA/OitsR1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f71312-3934-4fe5-24d4-08dea6bb88be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 13:22:31.9377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDykd/TAuao9Bl8nu7LQtvy8UfVkhIOf/kjl/lIs3k+/PBDnLqchNfGdc6/xn7AS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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

Hi John,

On 4/30/26 14:32, John Moore wrote:
> Hi Christian,
> 
> Thanks for the review. All points addressed below.
> 
>> That should probably be readq() instead of this horrible and not
>> portable cast to atomic64_t.
>>
>> Alternatively we could just normally read the pointer with a memory
>> barrier since this is just system memory.
> 
> I went with the second option — this is system memory (writeback via
> GTT), not MMIO, so readq() felt semantically wrong. The v2 uses:
> 
>   get:  wptr = READ_ONCE(*(u64 *)ring->wptr_cpu_addr);
>         smp_rmb();

This needs to be rmb() and not smp_rmb(); smp_rmb() is only for CPU<->CPU synchronization but here we need CPU<->device synchronization.

And it needs to come *before* the read!

> 
>   set:  WRITE_ONCE(*(u64 *)ring->wptr_cpu_addr, ring->wptr);
>         smp_wmb();

Same here, but this time least the barrier ordering is correct.

>         WDOORBELL64(ring->doorbell_index, ring->wptr);
> 
> The alignment is safe — amdgpu_device_wb_get() returns offsets in
> multiples of 8 dwords (32 bytes), so the u64* cast always lands on
> a naturally-aligned address.
> 
> One question: READ_ONCE on a u64 is not atomic on 32-bit
> architectures (unlike atomic64_read which uses cmpxchg8b). DRM_AMDGPU
> has no formal CONFIG_64BIT dependency in Kconfig, though in practice
> nobody runs it on 32-bit.

We still have some people trying to use it on 32bit kernels. We should maybe consider to drop the 32bit support.

> Is READ_ONCE acceptable here, or would you
> prefer readq() to keep the atomicity guarantee?

Yeah good question I don't really know what to do here.

On the one hand you are right, writeq()/readq() are not correct because this isn't MMIO but system memory.

On the other hand I don't think Linux has an architecture independent way to guarantee that a write to system memory is done as an atomic 64bit write.

What we need to guarantee is that the device never sees an incomplete value because the write is done as two 32bit writes.  That is probably the reason why we used the atomic64_t hack in the first place.

Regards,
Christian.

> 
>> Pre-requisite/error checking first please.
>> Make that a if (WARN_ON(!ring->use_doorbell)) return.
> 
> Done. Both functions now have the guard at the top:
> 
>   if (WARN_ON(!ring->use_doorbell))
>       return 0;  /* or return; for set_wptr */
> 
>> And please don't use WARN_ON_ONCE() that is just to reduce the
>> amount of warnings printed into the logs on real HW errors.
>>
>> On functional coding errors like this one here it doesn't make sense
>> and is often overlooked.
> 
> Understood — changed to WARN_ON.
> 
>> Same here the case to atomic64_t is extremely questionable.
> 
> Fixed in set_wptr as well, same READ_ONCE/WRITE_ONCE approach.
> 
> v2 incoming once I hear back on the readq vs READ_ONCE question.
> 
> Thanks,
> John
> 
> "I will not be pushed, filed, stamped, indexed, briefed, debriefed, or numbered."
> ~ The Prisoner
> 
> 
> 
> 
> On Thu, Apr 30, 2026 at 2:19 AM Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
> 
>     On 4/29/26 22:20, John B. Moore wrote:
>     > Move the duplicated doorbell-based get_wptr/set_wptr functions from
>     > gfx_v9_0.c, gfx_v10_0.c, gfx_v11_0.c, and gfx_v12_0.c into common
>     > helpers amdgpu_gfx_get_wptr_compute() and amdgpu_gfx_set_wptr_compute()
>     > in amdgpu_gfx.c.
>     >
>     > These functions are not HW generation dependent -- the doorbell path is
>     > identical across all four GFX versions:
>     >
>     >   get: atomic64_read(ring->wptr_cpu_addr)
>     >   set: atomic64_set(ring->wptr_cpu_addr) + WDOORBELL64()
>     >
>     > The non-doorbell fallback is replaced with WARN_ON_ONCE instead of BUG()
>     > since doorbell is the only supported method on gfx9+ compute rings.
>     >
>     > Not touched: gfx_v7_0, gfx_v8_0, gfx_v9_4_3 -- these have different
>     > wptr access patterns (MMIO registers or wb.wb[] offsets).
>     >
>     > Suggested-by: Alex Deucher <alexander.deucher@amd.com <mailto:alexander.deucher@amd.com>>
>     > Signed-off-by: John Moore <jbmoore61@gmail.com <mailto:jbmoore61@gmail.com>>
>     > ---
>     >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++++++++
>     >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
>     >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 33 +++------------------
>     >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 34 +++------------------
>     >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 34 +++------------------
>     >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 39 +++----------------------
>     >  6 files changed, 58 insertions(+), 124 deletions(-)
>     >
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>     > index 77578ecc6..9e9c5cb81 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>     > @@ -2596,3 +2596,42 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
>     >  #endif
>     >  }
>     > 
>     > +/**
>     > + * amdgpu_gfx_get_wptr_compute - common get_wptr for compute rings using doorbells
>     > + * @ring: amdgpu_ring pointer
>     > + *
>     > + * Read the write pointer from the doorbell-mapped writeback address.
>     > + * This is HW-agnostic and shared across GFX generations that use
>     > + * doorbell-based compute queue management.
>     > + */
>     > +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring)
>     > +{
>     > +     /* XXX check if swapping is necessary on BE */
>     > +     if (ring->use_doorbell)
>     > +             return atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
> 
>     That should probably be readq() instead of this horrible and not portable cast to atomic64_t.
> 
>     Alternatively we could just normally read the pointer with a memory barrier since this is just system memory.
> 
>     > +
>     > +     WARN_ON_ONCE(1);
> 
>     Pre-requisite/error checking first please.
> 
>     Make that a if (WARN_ON(!ring->use_doorbell)) return.
> 
>     And please don't use WARN_ON_ONCE() that is just to reduce the amount of warnings printed into the logs on real HW errors.
> 
>     On functional coding errors like this one here it doesn't make sense and is often overlooked.
> 
>     > +     return 0;
>     > +}
>     > +
>     > +/**
>     > + * amdgpu_gfx_set_wptr_compute - common set_wptr for compute rings using doorbells
>     > + * @ring: amdgpu_ring pointer
>     > + *
>     > + * Write the write pointer to the doorbell-mapped writeback address and
>     > + * ring the doorbell.  This is HW-agnostic and shared across GFX
>     > + * generations that use doorbell-based compute queue management.
>     > + */
>     > +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring)
>     > +{
>     > +     struct amdgpu_device *adev = ring->adev;
>     > +
>     > +     /* XXX check if swapping is necessary on BE */
>     > +     if (ring->use_doorbell) {
>     > +             atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
> 
>     Same here the case to atomic64_t is extremely questionable.
> 
>     Regards,
>     Christian.
> 
>     > +             WDOORBELL64(ring->doorbell_index, ring->wptr);
>     > +     } else {
>     > +             WARN_ON_ONCE(1);
>     > +     }
>     > +}
>     > +
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>     > index 585cc8e81..27f6beafb 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>     > @@ -653,6 +653,9 @@ u32 amdgpu_gfx_csb_preamble_start(u32 *buffer);
>     >  u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32 *buffer, u32 count);
>     >  void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
>     > 
>     > +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring);
>     > +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring);
>     > +
>     >  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>     >  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>     > 
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>     > index 1893ceeeb..4c0272cba 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>     > @@ -8586,31 +8586,6 @@ static u64 gfx_v10_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>     >       return *(uint32_t *)ring->rptr_cpu_addr;
>     >  }
>     > 
>     > -static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
>     > -{
>     > -     u64 wptr;
>     > -
>     > -     /* XXX check if swapping is necessary on BE */
>     > -     if (ring->use_doorbell)
>     > -             wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
>     > -     else
>     > -             BUG();
>     > -     return wptr;
>     > -}
>     > -
>     > -static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>     > -{
>     > -     struct amdgpu_device *adev = ring->adev;
>     > -
>     > -     if (ring->use_doorbell) {
>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>     > -                          ring->wptr);
>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
>     > -     } else {
>     > -             BUG(); /* only DOORBELL method supported on gfx10 now */
>     > -     }
>     > -}
>     > -
>     >  static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>     >  {
>     >       struct amdgpu_device *adev = ring->adev;
>     > @@ -9881,8 +9856,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>     >       .support_64bit_ptrs = true,
>     >       .get_rptr = gfx_v10_0_ring_get_rptr_compute,
>     > -     .get_wptr = gfx_v10_0_ring_get_wptr_compute,
>     > -     .set_wptr = gfx_v10_0_ring_set_wptr_compute,
>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>     >       .emit_frame_size =
>     >               20 + /* gfx_v10_0_ring_emit_gds_switch */
>     >               7 + /* gfx_v10_0_ring_emit_hdp_flush */
>     > @@ -9921,8 +9896,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>     >       .support_64bit_ptrs = true,
>     >       .get_rptr = gfx_v10_0_ring_get_rptr_compute,
>     > -     .get_wptr = gfx_v10_0_ring_get_wptr_compute,
>     > -     .set_wptr = gfx_v10_0_ring_set_wptr_compute,
>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>     >       .emit_frame_size =
>     >               20 + /* gfx_v10_0_ring_emit_gds_switch */
>     >               7 + /* gfx_v10_0_ring_emit_hdp_flush */
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>     > index 427975b5a..404604f2d 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>     > @@ -5818,32 +5818,6 @@ static u64 gfx_v11_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>     >       return *(uint32_t *)ring->rptr_cpu_addr;
>     >  }
>     > 
>     > -static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
>     > -{
>     > -     u64 wptr;
>     > -
>     > -     /* XXX check if swapping is necessary on BE */
>     > -     if (ring->use_doorbell)
>     > -             wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
>     > -     else
>     > -             BUG();
>     > -     return wptr;
>     > -}
>     > -
>     > -static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>     > -{
>     > -     struct amdgpu_device *adev = ring->adev;
>     > -
>     > -     /* XXX check if swapping is necessary on BE */
>     > -     if (ring->use_doorbell) {
>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>     > -                          ring->wptr);
>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
>     > -     } else {
>     > -             BUG(); /* only DOORBELL method supported on gfx11 now */
>     > -     }
>     > -}
>     > -
>     >  static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>     >  {
>     >       struct amdgpu_device *adev = ring->adev;
>     > @@ -7266,8 +7240,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>     >       .support_64bit_ptrs = true,
>     >       .get_rptr = gfx_v11_0_ring_get_rptr_compute,
>     > -     .get_wptr = gfx_v11_0_ring_get_wptr_compute,
>     > -     .set_wptr = gfx_v11_0_ring_set_wptr_compute,
>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>     >       .emit_frame_size =
>     >               5 + /* update_spm_vmid */
>     >               20 + /* gfx_v11_0_ring_emit_gds_switch */
>     > @@ -7307,8 +7281,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>     >       .support_64bit_ptrs = true,
>     >       .get_rptr = gfx_v11_0_ring_get_rptr_compute,
>     > -     .get_wptr = gfx_v11_0_ring_get_wptr_compute,
>     > -     .set_wptr = gfx_v11_0_ring_set_wptr_compute,
>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>     >       .emit_frame_size =
>     >               20 + /* gfx_v11_0_ring_emit_gds_switch */
>     >               7 + /* gfx_v11_0_ring_emit_hdp_flush */
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>     > index 79ea1af36..7ba436444 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>     > @@ -4363,32 +4363,6 @@ static u64 gfx_v12_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>     >       return *(uint32_t *)ring->rptr_cpu_addr;
>     >  }
>     > 
>     > -static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
>     > -{
>     > -     u64 wptr;
>     > -
>     > -     /* XXX check if swapping is necessary on BE */
>     > -     if (ring->use_doorbell)
>     > -             wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
>     > -     else
>     > -             BUG();
>     > -     return wptr;
>     > -}
>     > -
>     > -static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>     > -{
>     > -     struct amdgpu_device *adev = ring->adev;
>     > -
>     > -     /* XXX check if swapping is necessary on BE */
>     > -     if (ring->use_doorbell) {
>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>     > -                          ring->wptr);
>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
>     > -     } else {
>     > -             BUG(); /* only DOORBELL method supported on gfx12 now */
>     > -     }
>     > -}
>     > -
>     >  static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>     >  {
>     >       struct amdgpu_device *adev = ring->adev;
>     > @@ -5523,8 +5497,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>     >       .support_64bit_ptrs = true,
>     >       .get_rptr = gfx_v12_0_ring_get_rptr_compute,
>     > -     .get_wptr = gfx_v12_0_ring_get_wptr_compute,
>     > -     .set_wptr = gfx_v12_0_ring_set_wptr_compute,
>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>     >       .emit_frame_size =
>     >               7 + /* gfx_v12_0_ring_emit_hdp_flush */
>     >               5 + /* hdp invalidate */
>     > @@ -5561,8 +5535,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>     >       .support_64bit_ptrs = true,
>     >       .get_rptr = gfx_v12_0_ring_get_rptr_compute,
>     > -     .get_wptr = gfx_v12_0_ring_get_wptr_compute,
>     > -     .set_wptr = gfx_v12_0_ring_set_wptr_compute,
>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>     >       .emit_frame_size =
>     >               7 + /* gfx_v12_0_ring_emit_hdp_flush */
>     >               5 + /*hdp invalidate */
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>     > index 8249135d7..798f94bca 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>     > @@ -5640,37 +5640,6 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>     >       return *ring->rptr_cpu_addr; /* gfx9 hardware is 32bit rptr */
>     >  }
>     > 
>     > -static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
>     > -{
>     > -     u64 wptr;
>     > -
>     > -     /* XXX check if swapping is necessary on BE */
>     > -     if (ring->use_doorbell) {
>     > -             wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
>     > -     } else {
>     > -             WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr read on ring %s, "
>     > -                       "only doorbell method supported on gfx9\n",
>     > -                       ring->name);
>     > -             wptr = 0;
>     > -     }
>     > -     return wptr;
>     > -}
>     > -
>     > -static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>     > -{
>     > -     struct amdgpu_device *adev = ring->adev;
>     > -
>     > -     /* XXX check if swapping is necessary on BE */
>     > -     if (ring->use_doorbell) {
>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
>     > -     } else {
>     > -             WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr write on ring %s, "
>     > -                       "only doorbell method supported on gfx9\n",
>     > -                       ring->name);
>     > -     }
>     > -}
>     > -
>     >  static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
>     >                                        u64 seq, unsigned int flags)
>     >  {
>     > @@ -7627,8 +7596,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>     >       .support_64bit_ptrs = true,
>     >       .get_rptr = gfx_v9_0_ring_get_rptr_compute,
>     > -     .get_wptr = gfx_v9_0_ring_get_wptr_compute,
>     > -     .set_wptr = gfx_v9_0_ring_set_wptr_compute,
>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>     >       .emit_frame_size =
>     >               20 + /* gfx_v9_0_ring_emit_gds_switch */
>     >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
>     > @@ -7669,8 +7638,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>     >       .support_64bit_ptrs = true,
>     >       .get_rptr = gfx_v9_0_ring_get_rptr_compute,
>     > -     .get_wptr = gfx_v9_0_ring_get_wptr_compute,
>     > -     .set_wptr = gfx_v9_0_ring_set_wptr_compute,
>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>     >       .emit_frame_size =
>     >               20 + /* gfx_v9_0_ring_emit_gds_switch */
>     >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> 


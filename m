Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEF2FF8873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 13:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A0788EFE;
	Thu, 30 Apr 2026 13:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bWLl6QT0";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D81910E05F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 13:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUsYOMJu4smo1mI0ouVW9HY/ONT5VYcVag7p8v9ys5LTxA4zBbxiLls4OqsDZFUYNSQ5Ceq56BPksxVfnaoZ3l1A4tpuvRYyxwEVjbEe2bjEeWFGjrkWLRlR/nLvhDNrK5M2nkdOVKKJHPn8Geuz8uCi3pKBnWJm6nfaCP8+yQz9znPQeckGNW7HzRfmEJ2bybV0EL8XdFgxv7AhBPhbjJxj/M3YotaxdnAfeV5Ehf1wN6IbNAvu917whPCA0hpH70+Hp3mf9uf0rSv+WFfOPqOtdtt1YeIGaJMxDUQGg8G0FmvUNPIlH/7gctxi9GLbd95ZgWEC0BFWw+IhOCOIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LzElgPrlnLXXzO3fNGY5Qx1WRg/VxJK4HW0IMQ54eE=;
 b=qM/3C1uwNyxSAxNbuwHynCFUN128RFsB1FGcg11GdyLVdbbc0QsLCAJdJtL5bsHJAQRl7bOl/osIvBWSzcQ2av4Fgt97OWO7SxU+irs2/UcUMqVc/vf/wYEg5nhvYZs9fjDrE4M/UvP7KOcur+altxsEKN0fonbH67aDdrcDywCtluRK3Ojw3GqncZJv0BRSGXmaDrl1e/guhch14qSMbdOkkQB808Esqm0FD+O85jgCVN2VU+tCY0eqs/8ilJkXg/NOpMl9eWqZgZyoNkLHJj33HmPJyFWUAGTNG78HDQDgTLfWqO2ZidHUFWxJUsp7X+MzhYUUMrWXJNaDESbTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LzElgPrlnLXXzO3fNGY5Qx1WRg/VxJK4HW0IMQ54eE=;
 b=bWLl6QT0XpGHtHDEqoDlfVin90KHeP6Y/SXm5R9x7BtYStqSdKXy33ZFZyE+DcaYyJ9MH+wCWZftBr76F8bT2k5D+IvbLaYY+pHO9hgITYK/DuPlGJNhlCaM9wHzCdMar1Qqq0rQH8ug1RFmJpOwCec1UmJidzSFZx/SKoqIqCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 13:49:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:49:15 +0000
Message-ID: <dfc8935f-99c7-4666-bb34-0d01ad3bb8a8@amd.com>
Date: Thu, 30 Apr 2026 15:49:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx: extract compute wptr doorbell helpers to
 amdgpu_gfx.c
To: Alex Deucher <alexdeucher@gmail.com>
Cc: John Moore <jbmoore61@gmail.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20260429202042.21718-1-jbmoore61@gmail.com>
 <6266086d-15d4-476d-a992-503509032dd7@amd.com>
 <CAPUYzBf8EBynRij60SR+EFg1Kn22cyykSOOPxo709bq0xhjpLw@mail.gmail.com>
 <acb467cf-0b2d-4733-8df2-23f1ed18b4fd@amd.com>
 <CADnq5_O=Yt+NZLYykwmHSC6Q7p7G86hpDaFKm5TzRFxd_jndpA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_O=Yt+NZLYykwmHSC6Q7p7G86hpDaFKm5TzRFxd_jndpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e523e30-f39a-4863-42f2-08dea6bf444a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: VNX4ceMuLtRS/iD4zrTA9lLdNbfM9bhm8NhVjPEHWVNBrhYBAsqSXsxPuiYwhThqWJEJ+4P07OekQkjCppnET7nt5hI2Z1q2u8ROSiEtHUsdTqEpGs1/f0Vx2mPwkAb7I6zfJgHWkClJFavRsqXC+64pQ2+uFDXCGRDKp3ZWMo8/erK7nI391jagMRP7sD2PDMg94FS22d15Fl+csCcL9i8O0pqhNiwUVYtOrdB6AcesOo2nQ4rMVctRHJGnU7MfLqtcM+xP8xkq4aR9CPUCfJTaaq7wVjD2yPH4IcCzP6W7/qUH1NlwGvbkFU2o4fiFOeGiudHv8884mzInloUlH3DEZ+7XHgs53RsdUFRM+oUR20dHgyL2hqsB0K9AjRk8QhRVYYi9OWQAX0b1nTg4KOPtJetABQjGMywWfKhgJFmk+PS28t/xn44VUZNb2XZipt2F+xvgQCDPrRiFbDNz5Ya6bC9jlJ/lMaE7dNCB76tWSq8ob8zu8FMiP7FsE2GpByUl9PoyP15uO9Gt60eAoq5JAQlhKd/3ODr0kZuUJjZlv7PlH6GFF8iiEYUAiOpEeTXo1/EerNGLGYckjQ3KdQCfHnT8r/Ly+/WU7r5pbCX4dBXAyL8G30TMOPjlPXvR3Sa8aF8AtBhvU7LXW2tEBeettwGd5/m5RBK8/fNf+Qpc43wqCJujL8cyjmCDyamIVknVQfwIWOb1arWX956hS60WgqpNLz35aLuI9tbFX98=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnhzTXlFa2hDazl3VWtMV3hBcWNjNDduVEJUWkV5TUsxR2FSRXpSdjdjc1lk?=
 =?utf-8?B?YjZOTHpJT01mdCszbFIxVjUzdmJvUlZQMHFVVTdBSVZXVi9DaGZ4eXZua2Fu?=
 =?utf-8?B?VGFlRnhBeFZPYXZwOGptQW1HcjN1cksrTW9Hd2Zhazk2T2wwRWZHVktwWUJQ?=
 =?utf-8?B?ZEJSYXpuVXhVM2xWcURnZFBhN2c2M0NZaDI4TlUrUXhWNTVQUXh3MlNnZXRQ?=
 =?utf-8?B?M0JzQ0lpYkE0aWNvYVRyc1lyYk5IQWJacTl2NzhLc0xJREJjU0kvRHVwOWpC?=
 =?utf-8?B?NDdQTmllUG9TM29XNkZOM2NmM3IvKzJONERPeWF4am54TnZRMVZjK0VFeTlN?=
 =?utf-8?B?NUpSc0YzakhOMnhiOTRoODN0c3VEQ1NVaXVGNTRnZVYyUkNzbDk2d05nRW9s?=
 =?utf-8?B?UzlobzhCaGpzd3FIaFNaamlrZHVMT3BqL0JpSy95eGVMeFJxTGFpZ0FRbStG?=
 =?utf-8?B?SWRsUkhqYjFHQzJGd0hpeGIzZXB5eFU0RkpmVGJlUThmaVZpdFR1Z0d1ZTlE?=
 =?utf-8?B?OEM1S25OQWxRUFlMQUwrVmx1aEFlTU5zRURHellWa3JVWitxRnZMd0N3bWVK?=
 =?utf-8?B?TWJJNDhVUzY1VTBxbjUvaXNOTGNOUWNZSm1odUY1TnpzOVVzZFRZbnhNLzVQ?=
 =?utf-8?B?bnB3T01zVk9ZZmlHeis2RWxLU0xDcVZyV2V1T1ROWHVNMnNRcGF0YWd6aUZO?=
 =?utf-8?B?RENMeVZhMlVHalNCVElhNUl3VENmN000dHN4QUliS21DMm5nUnZNdkFyMjNW?=
 =?utf-8?B?bmh6c2hScXpicHljbDJWRWJNc3hZVDY2emVtT2ZPUmtnam8vUThiMmlKWFZk?=
 =?utf-8?B?VTVOTllKeGtzajB2d3BFa3NacU5tRnk5bmdOOHlNWXNnYkdrWmQ1bHJQVVF2?=
 =?utf-8?B?dVdjV1BrTUFNb1JsaE1UMlFvSDAwTTY0aTgwbTZxODNKb1R6YktyYi9BdENy?=
 =?utf-8?B?cTNVVGcwbHIzcEFpK1lnbkp6RVNLNHJWYUgraWtEeXdWTnFPWDZYNXZYMWZF?=
 =?utf-8?B?Zk10cE1RTmRKMTNPQUNNSTd1M3ViZzcxRzRNL3QzTXUxVEhLODM3RjF3a3E1?=
 =?utf-8?B?dTlSS1IzaGw1bXdFdzZBNlNqV05oVjd2a1UwT3dNQXhxRzh3U0RqT2ROZ2Rr?=
 =?utf-8?B?cytwbW5UaEN2K0U5NFlyWThaYU9QcUNPYlFjcUtsejVrTGc4UE1EdW9FeERo?=
 =?utf-8?B?QktrVkdjKzRiRUlNcCtaV2cyTVIxeXRndnc1SCtWQTVmWUgrWmFZL2RJanhQ?=
 =?utf-8?B?Zkk2VElocWxkRzFvTytzQjhJWTc1MjQ5RlplZ291S3F1dVFwN1RVK1VialBa?=
 =?utf-8?B?NUR5OVRGdWM4RjFvbnJwN1VKRG1Bd3F2YmdkRFNUdGZ3cGNyYnkrV0NzY1J5?=
 =?utf-8?B?SVRlNytBRWdOalN3REltQ1c0SU1XYlhNUmZpMWxHbWpyR1hZNE9jQ3czSzhr?=
 =?utf-8?B?cnZ3RWFMcHFldXUvNUJja0ZMUWQwSXd1bktsQ2VhaXJtanZTRjlXcys5WlhT?=
 =?utf-8?B?Vlg4K0NQKzh6d0REQTZRK2t5S1JBTE1zR2dnU2NtZHdpWFlQLzdERSt5NmpI?=
 =?utf-8?B?UlpQQXZab1VHZi85NDVxRzdZTE5YSzdqTnBuWjhTRmFjZWxqTU53YmFIRmpr?=
 =?utf-8?B?UlRWMCtYTm9mQkJvN0kyVlBNa2dNcTZ1QVl5R1RtUGc5RUErMzJ2UWdvMFI5?=
 =?utf-8?B?c25ZRjdNenR6SGF5YzhLTVc0ck9kcE9NRzNkd2Fpc05Vc3E3ZlFvYVl3TkVp?=
 =?utf-8?B?a21ZMFdXV1BsZUdIbXIzOTR1bXhiSlo3L0dUR1JGRUsvazJPQ3NsOWhVdjR6?=
 =?utf-8?B?bm5yTEZKVDdabFRRQWlpTFRoYWdPWmE1UFc3R1gwQ0hkNmkzRkdiRFQwb3VT?=
 =?utf-8?B?NUQ4VEg1bk1pVnlHaVpoaEdWTnJLa1Vtc1VYZU0xK0krUVg2OW80bk5ueVhK?=
 =?utf-8?B?NDh4dnNMTCtQWU5odU1yRzNsRzdyY2I3cFpRS3ZLUmhyYkh1NnlYTm82TFlB?=
 =?utf-8?B?MHhobTNoaGlLdWpWTEpmanNpaHFZZEpSUThwS0lUUllIUWptanlpWVYxMkJ6?=
 =?utf-8?B?TFdkbmVNZk1vS3NSaEdGcDIyTk5kU3cwTzVDS3FwQW9yeXprNzkxcHB0MzVm?=
 =?utf-8?B?T0MvdkU2NUZ6SmNBLytzUHVkUUNieXdoayt5TzBlait6MHVXbURPNlRLcTRn?=
 =?utf-8?B?SG1LdURHY1VualZ0UFpMVjNnam5sWURFSWZhbnljL0h5NXBQTndmeVFzelQx?=
 =?utf-8?B?a3o0algzVHNiSlpjNWcwRWE4eExzeG1HdWJ1QWlIQXRBUE5jT0dsQWJJL0lP?=
 =?utf-8?Q?So1x8p39D4xW9SXPxj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e523e30-f39a-4863-42f2-08dea6bf444a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 13:49:15.3911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMaOFPMzSZfgshAx+F2N7qNGBMg5M9yiSb11NAl0TqXI9JykgKNg6VmyIWv/KVGv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

On 4/30/26 15:26, Alex Deucher wrote:
> On Thu, Apr 30, 2026 at 9:22 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> Hi John,
>>
>> On 4/30/26 14:32, John Moore wrote:
>>> Hi Christian,
>>>
>>> Thanks for the review. All points addressed below.
>>>
>>>> That should probably be readq() instead of this horrible and not
>>>> portable cast to atomic64_t.
>>>>
>>>> Alternatively we could just normally read the pointer with a memory
>>>> barrier since this is just system memory.
>>>
>>> I went with the second option — this is system memory (writeback via
>>> GTT), not MMIO, so readq() felt semantically wrong. The v2 uses:
>>>
>>>   get:  wptr = READ_ONCE(*(u64 *)ring->wptr_cpu_addr);
>>>         smp_rmb();
>>
>> This needs to be rmb() and not smp_rmb(); smp_rmb() is only for CPU<->CPU synchronization but here we need CPU<->device synchronization.
>>
>> And it needs to come *before* the read!
>>
>>>
>>>   set:  WRITE_ONCE(*(u64 *)ring->wptr_cpu_addr, ring->wptr);
>>>         smp_wmb();
>>
>> Same here, but this time least the barrier ordering is correct.
>>
>>>         WDOORBELL64(ring->doorbell_index, ring->wptr);
>>>
>>> The alignment is safe — amdgpu_device_wb_get() returns offsets in
>>> multiples of 8 dwords (32 bytes), so the u64* cast always lands on
>>> a naturally-aligned address.
>>>
>>> One question: READ_ONCE on a u64 is not atomic on 32-bit
>>> architectures (unlike atomic64_read which uses cmpxchg8b). DRM_AMDGPU
>>> has no formal CONFIG_64BIT dependency in Kconfig, though in practice
>>> nobody runs it on 32-bit.
>>
>> We still have some people trying to use it on 32bit kernels. We should maybe consider to drop the 32bit support.
> 
> 32 bit support is the reason we used the atomic stuff in the first place.

Yeah the problem is that is just and extremely ugly hack.

IIRC there are architecture who can't do 64bit writes at all, on those systems an atomic_64 is implemented by using a lock.

On the other hand I don't think anybody would be able to use HW AMDGPU supports on a SPARC, Alpha or +20 year old MIPS system because of the lack of PCIe bus.

My educated guess is that the correct answer is to have a config dependency to prevent AMDGPU from even compiling on such architectures and then using a WRITE_ONCE()/READ_ONCE() with appropriate memory barriers.

But of hand I don't know how that stuff is abstracted on the architecture side and which config option to depend on.

Regards,
Christian.

> 
> Alex
> 
>>
>>> Is READ_ONCE acceptable here, or would you
>>> prefer readq() to keep the atomicity guarantee?
>>
>> Yeah good question I don't really know what to do here.
>>
>> On the one hand you are right, writeq()/readq() are not correct because this isn't MMIO but system memory.
>>
>> On the other hand I don't think Linux has an architecture independent way to guarantee that a write to system memory is done as an atomic 64bit write.
>>
>> What we need to guarantee is that the device never sees an incomplete value because the write is done as two 32bit writes.  That is probably the reason why we used the atomic64_t hack in the first place.
>>
>> Regards,
>> Christian.
>>
>>>
>>>> Pre-requisite/error checking first please.
>>>> Make that a if (WARN_ON(!ring->use_doorbell)) return.
>>>
>>> Done. Both functions now have the guard at the top:
>>>
>>>   if (WARN_ON(!ring->use_doorbell))
>>>       return 0;  /* or return; for set_wptr */
>>>
>>>> And please don't use WARN_ON_ONCE() that is just to reduce the
>>>> amount of warnings printed into the logs on real HW errors.
>>>>
>>>> On functional coding errors like this one here it doesn't make sense
>>>> and is often overlooked.
>>>
>>> Understood — changed to WARN_ON.
>>>
>>>> Same here the case to atomic64_t is extremely questionable.
>>>
>>> Fixed in set_wptr as well, same READ_ONCE/WRITE_ONCE approach.
>>>
>>> v2 incoming once I hear back on the readq vs READ_ONCE question.
>>>
>>> Thanks,
>>> John
>>>
>>> "I will not be pushed, filed, stamped, indexed, briefed, debriefed, or numbered."
>>> ~ The Prisoner
>>>
>>>
>>>
>>>
>>> On Thu, Apr 30, 2026 at 2:19 AM Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>>>
>>>     On 4/29/26 22:20, John B. Moore wrote:
>>>     > Move the duplicated doorbell-based get_wptr/set_wptr functions from
>>>     > gfx_v9_0.c, gfx_v10_0.c, gfx_v11_0.c, and gfx_v12_0.c into common
>>>     > helpers amdgpu_gfx_get_wptr_compute() and amdgpu_gfx_set_wptr_compute()
>>>     > in amdgpu_gfx.c.
>>>     >
>>>     > These functions are not HW generation dependent -- the doorbell path is
>>>     > identical across all four GFX versions:
>>>     >
>>>     >   get: atomic64_read(ring->wptr_cpu_addr)
>>>     >   set: atomic64_set(ring->wptr_cpu_addr) + WDOORBELL64()
>>>     >
>>>     > The non-doorbell fallback is replaced with WARN_ON_ONCE instead of BUG()
>>>     > since doorbell is the only supported method on gfx9+ compute rings.
>>>     >
>>>     > Not touched: gfx_v7_0, gfx_v8_0, gfx_v9_4_3 -- these have different
>>>     > wptr access patterns (MMIO registers or wb.wb[] offsets).
>>>     >
>>>     > Suggested-by: Alex Deucher <alexander.deucher@amd.com <mailto:alexander.deucher@amd.com>>
>>>     > Signed-off-by: John Moore <jbmoore61@gmail.com <mailto:jbmoore61@gmail.com>>
>>>     > ---
>>>     >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++++++++
>>>     >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
>>>     >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 33 +++------------------
>>>     >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 34 +++------------------
>>>     >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 34 +++------------------
>>>     >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 39 +++----------------------
>>>     >  6 files changed, 58 insertions(+), 124 deletions(-)
>>>     >
>>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>     > index 77578ecc6..9e9c5cb81 100644
>>>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>     > @@ -2596,3 +2596,42 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
>>>     >  #endif
>>>     >  }
>>>     >
>>>     > +/**
>>>     > + * amdgpu_gfx_get_wptr_compute - common get_wptr for compute rings using doorbells
>>>     > + * @ring: amdgpu_ring pointer
>>>     > + *
>>>     > + * Read the write pointer from the doorbell-mapped writeback address.
>>>     > + * This is HW-agnostic and shared across GFX generations that use
>>>     > + * doorbell-based compute queue management.
>>>     > + */
>>>     > +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring)
>>>     > +{
>>>     > +     /* XXX check if swapping is necessary on BE */
>>>     > +     if (ring->use_doorbell)
>>>     > +             return atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
>>>
>>>     That should probably be readq() instead of this horrible and not portable cast to atomic64_t.
>>>
>>>     Alternatively we could just normally read the pointer with a memory barrier since this is just system memory.
>>>
>>>     > +
>>>     > +     WARN_ON_ONCE(1);
>>>
>>>     Pre-requisite/error checking first please.
>>>
>>>     Make that a if (WARN_ON(!ring->use_doorbell)) return.
>>>
>>>     And please don't use WARN_ON_ONCE() that is just to reduce the amount of warnings printed into the logs on real HW errors.
>>>
>>>     On functional coding errors like this one here it doesn't make sense and is often overlooked.
>>>
>>>     > +     return 0;
>>>     > +}
>>>     > +
>>>     > +/**
>>>     > + * amdgpu_gfx_set_wptr_compute - common set_wptr for compute rings using doorbells
>>>     > + * @ring: amdgpu_ring pointer
>>>     > + *
>>>     > + * Write the write pointer to the doorbell-mapped writeback address and
>>>     > + * ring the doorbell.  This is HW-agnostic and shared across GFX
>>>     > + * generations that use doorbell-based compute queue management.
>>>     > + */
>>>     > +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring)
>>>     > +{
>>>     > +     struct amdgpu_device *adev = ring->adev;
>>>     > +
>>>     > +     /* XXX check if swapping is necessary on BE */
>>>     > +     if (ring->use_doorbell) {
>>>     > +             atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
>>>
>>>     Same here the case to atomic64_t is extremely questionable.
>>>
>>>     Regards,
>>>     Christian.
>>>
>>>     > +             WDOORBELL64(ring->doorbell_index, ring->wptr);
>>>     > +     } else {
>>>     > +             WARN_ON_ONCE(1);
>>>     > +     }
>>>     > +}
>>>     > +
>>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>     > index 585cc8e81..27f6beafb 100644
>>>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>     > @@ -653,6 +653,9 @@ u32 amdgpu_gfx_csb_preamble_start(u32 *buffer);
>>>     >  u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32 *buffer, u32 count);
>>>     >  void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
>>>     >
>>>     > +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring);
>>>     > +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring);
>>>     > +
>>>     >  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>>>     >  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>>>     >
>>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>     > index 1893ceeeb..4c0272cba 100644
>>>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>     > @@ -8586,31 +8586,6 @@ static u64 gfx_v10_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>>>     >       return *(uint32_t *)ring->rptr_cpu_addr;
>>>     >  }
>>>     >
>>>     > -static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
>>>     > -{
>>>     > -     u64 wptr;
>>>     > -
>>>     > -     /* XXX check if swapping is necessary on BE */
>>>     > -     if (ring->use_doorbell)
>>>     > -             wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
>>>     > -     else
>>>     > -             BUG();
>>>     > -     return wptr;
>>>     > -}
>>>     > -
>>>     > -static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>>     > -{
>>>     > -     struct amdgpu_device *adev = ring->adev;
>>>     > -
>>>     > -     if (ring->use_doorbell) {
>>>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>>>     > -                          ring->wptr);
>>>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
>>>     > -     } else {
>>>     > -             BUG(); /* only DOORBELL method supported on gfx10 now */
>>>     > -     }
>>>     > -}
>>>     > -
>>>     >  static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>     >  {
>>>     >       struct amdgpu_device *adev = ring->adev;
>>>     > @@ -9881,8 +9856,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
>>>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>>>     >       .support_64bit_ptrs = true,
>>>     >       .get_rptr = gfx_v10_0_ring_get_rptr_compute,
>>>     > -     .get_wptr = gfx_v10_0_ring_get_wptr_compute,
>>>     > -     .set_wptr = gfx_v10_0_ring_set_wptr_compute,
>>>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>>>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>>>     >       .emit_frame_size =
>>>     >               20 + /* gfx_v10_0_ring_emit_gds_switch */
>>>     >               7 + /* gfx_v10_0_ring_emit_hdp_flush */
>>>     > @@ -9921,8 +9896,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
>>>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>>>     >       .support_64bit_ptrs = true,
>>>     >       .get_rptr = gfx_v10_0_ring_get_rptr_compute,
>>>     > -     .get_wptr = gfx_v10_0_ring_get_wptr_compute,
>>>     > -     .set_wptr = gfx_v10_0_ring_set_wptr_compute,
>>>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>>>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>>>     >       .emit_frame_size =
>>>     >               20 + /* gfx_v10_0_ring_emit_gds_switch */
>>>     >               7 + /* gfx_v10_0_ring_emit_hdp_flush */
>>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>     > index 427975b5a..404604f2d 100644
>>>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>     > @@ -5818,32 +5818,6 @@ static u64 gfx_v11_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>>>     >       return *(uint32_t *)ring->rptr_cpu_addr;
>>>     >  }
>>>     >
>>>     > -static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
>>>     > -{
>>>     > -     u64 wptr;
>>>     > -
>>>     > -     /* XXX check if swapping is necessary on BE */
>>>     > -     if (ring->use_doorbell)
>>>     > -             wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
>>>     > -     else
>>>     > -             BUG();
>>>     > -     return wptr;
>>>     > -}
>>>     > -
>>>     > -static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>>     > -{
>>>     > -     struct amdgpu_device *adev = ring->adev;
>>>     > -
>>>     > -     /* XXX check if swapping is necessary on BE */
>>>     > -     if (ring->use_doorbell) {
>>>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>>>     > -                          ring->wptr);
>>>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
>>>     > -     } else {
>>>     > -             BUG(); /* only DOORBELL method supported on gfx11 now */
>>>     > -     }
>>>     > -}
>>>     > -
>>>     >  static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>     >  {
>>>     >       struct amdgpu_device *adev = ring->adev;
>>>     > @@ -7266,8 +7240,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
>>>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>>>     >       .support_64bit_ptrs = true,
>>>     >       .get_rptr = gfx_v11_0_ring_get_rptr_compute,
>>>     > -     .get_wptr = gfx_v11_0_ring_get_wptr_compute,
>>>     > -     .set_wptr = gfx_v11_0_ring_set_wptr_compute,
>>>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>>>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>>>     >       .emit_frame_size =
>>>     >               5 + /* update_spm_vmid */
>>>     >               20 + /* gfx_v11_0_ring_emit_gds_switch */
>>>     > @@ -7307,8 +7281,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
>>>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>>>     >       .support_64bit_ptrs = true,
>>>     >       .get_rptr = gfx_v11_0_ring_get_rptr_compute,
>>>     > -     .get_wptr = gfx_v11_0_ring_get_wptr_compute,
>>>     > -     .set_wptr = gfx_v11_0_ring_set_wptr_compute,
>>>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>>>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>>>     >       .emit_frame_size =
>>>     >               20 + /* gfx_v11_0_ring_emit_gds_switch */
>>>     >               7 + /* gfx_v11_0_ring_emit_hdp_flush */
>>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>     > index 79ea1af36..7ba436444 100644
>>>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>     > @@ -4363,32 +4363,6 @@ static u64 gfx_v12_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>>>     >       return *(uint32_t *)ring->rptr_cpu_addr;
>>>     >  }
>>>     >
>>>     > -static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
>>>     > -{
>>>     > -     u64 wptr;
>>>     > -
>>>     > -     /* XXX check if swapping is necessary on BE */
>>>     > -     if (ring->use_doorbell)
>>>     > -             wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
>>>     > -     else
>>>     > -             BUG();
>>>     > -     return wptr;
>>>     > -}
>>>     > -
>>>     > -static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>>     > -{
>>>     > -     struct amdgpu_device *adev = ring->adev;
>>>     > -
>>>     > -     /* XXX check if swapping is necessary on BE */
>>>     > -     if (ring->use_doorbell) {
>>>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>>>     > -                          ring->wptr);
>>>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
>>>     > -     } else {
>>>     > -             BUG(); /* only DOORBELL method supported on gfx12 now */
>>>     > -     }
>>>     > -}
>>>     > -
>>>     >  static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>     >  {
>>>     >       struct amdgpu_device *adev = ring->adev;
>>>     > @@ -5523,8 +5497,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
>>>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>>>     >       .support_64bit_ptrs = true,
>>>     >       .get_rptr = gfx_v12_0_ring_get_rptr_compute,
>>>     > -     .get_wptr = gfx_v12_0_ring_get_wptr_compute,
>>>     > -     .set_wptr = gfx_v12_0_ring_set_wptr_compute,
>>>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>>>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>>>     >       .emit_frame_size =
>>>     >               7 + /* gfx_v12_0_ring_emit_hdp_flush */
>>>     >               5 + /* hdp invalidate */
>>>     > @@ -5561,8 +5535,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
>>>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>>>     >       .support_64bit_ptrs = true,
>>>     >       .get_rptr = gfx_v12_0_ring_get_rptr_compute,
>>>     > -     .get_wptr = gfx_v12_0_ring_get_wptr_compute,
>>>     > -     .set_wptr = gfx_v12_0_ring_set_wptr_compute,
>>>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>>>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>>>     >       .emit_frame_size =
>>>     >               7 + /* gfx_v12_0_ring_emit_hdp_flush */
>>>     >               5 + /*hdp invalidate */
>>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>     > index 8249135d7..798f94bca 100644
>>>     > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>     > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>     > @@ -5640,37 +5640,6 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>>>     >       return *ring->rptr_cpu_addr; /* gfx9 hardware is 32bit rptr */
>>>     >  }
>>>     >
>>>     > -static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
>>>     > -{
>>>     > -     u64 wptr;
>>>     > -
>>>     > -     /* XXX check if swapping is necessary on BE */
>>>     > -     if (ring->use_doorbell) {
>>>     > -             wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
>>>     > -     } else {
>>>     > -             WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr read on ring %s, "
>>>     > -                       "only doorbell method supported on gfx9\n",
>>>     > -                       ring->name);
>>>     > -             wptr = 0;
>>>     > -     }
>>>     > -     return wptr;
>>>     > -}
>>>     > -
>>>     > -static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>>     > -{
>>>     > -     struct amdgpu_device *adev = ring->adev;
>>>     > -
>>>     > -     /* XXX check if swapping is necessary on BE */
>>>     > -     if (ring->use_doorbell) {
>>>     > -             atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
>>>     > -             WDOORBELL64(ring->doorbell_index, ring->wptr);
>>>     > -     } else {
>>>     > -             WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr write on ring %s, "
>>>     > -                       "only doorbell method supported on gfx9\n",
>>>     > -                       ring->name);
>>>     > -     }
>>>     > -}
>>>     > -
>>>     >  static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
>>>     >                                        u64 seq, unsigned int flags)
>>>     >  {
>>>     > @@ -7627,8 +7596,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>>>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>>>     >       .support_64bit_ptrs = true,
>>>     >       .get_rptr = gfx_v9_0_ring_get_rptr_compute,
>>>     > -     .get_wptr = gfx_v9_0_ring_get_wptr_compute,
>>>     > -     .set_wptr = gfx_v9_0_ring_set_wptr_compute,
>>>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>>>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>>>     >       .emit_frame_size =
>>>     >               20 + /* gfx_v9_0_ring_emit_gds_switch */
>>>     >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
>>>     > @@ -7669,8 +7638,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
>>>     >       .nop = PACKET3(PACKET3_NOP, 0x3FFF),
>>>     >       .support_64bit_ptrs = true,
>>>     >       .get_rptr = gfx_v9_0_ring_get_rptr_compute,
>>>     > -     .get_wptr = gfx_v9_0_ring_get_wptr_compute,
>>>     > -     .set_wptr = gfx_v9_0_ring_set_wptr_compute,
>>>     > +     .get_wptr = amdgpu_gfx_get_wptr_compute,
>>>     > +     .set_wptr = amdgpu_gfx_set_wptr_compute,
>>>     >       .emit_frame_size =
>>>     >               20 + /* gfx_v9_0_ring_emit_gds_switch */
>>>     >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
>>>
>>


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114B6CA5FCB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 14:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED9210F6BD;
	Thu,  1 Oct 2026 14:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oZEtopU0";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E7510F6BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 14:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdezS+v/h1igaCa7v2DDmSl7+kIslyXszOLhIkmqeFrnGQA+oUgziKQet0ETyIV95affrFLwzP7DJH9Dabj70LQzROxGP7uITZjltgOXj7JDx85EJSgMU4YJttojT33HPHuDFk8dVOuyIlIWIqTzelSJj9PSgVd9eJZCElQeb5JnhW4lQ/NB3NmmGabKyfSJzFNZt8xkCfKkz9ahI7PzPoAMu7d7KsciZ3AoxmHhYyPhx7frafc+b3pHL4kJ6QD0QUMRlKlHDGB0PQt5smapgnrZeAQkDHfM3SW0qbjH4M678pu52z1ePjJlI3D2Kf8WCQ5f1u1/mpGxZoAe9wMTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mzKgWAyYbOQtrBQowAD7bDqnMigZwzzez0TjunTDy0=;
 b=HeEsJM2FEupwLD+uP9FGDAHlt1vsNMNJXN0+rUOn3Gt/LqB0WnCfR3u8MeYBcViqfuTGXbEkMgbdvYp3NvzlWNeGvybOqr61IwqM3Bg2Camw3uL3659S+MZNirQg3sKU0xoPaaO2qT67DFD6H2fmf7A7KknHTSBfwZfH98wvrmTlI0TGLh6U5DQOm+YSS230erQ2YSwSPUGxX32apUuDIwIJVh9laGDfEJx+gF2NyHY0YkhS8+eAMu4BtipcBYPSqhyw7EbqPvNhQv1MYMayV5XjBX8f2c9iGhWSG9kSSk79t3x2dQg5yP8SqYrgfnycxPSq41eVJGC8XYbPxLCD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mzKgWAyYbOQtrBQowAD7bDqnMigZwzzez0TjunTDy0=;
 b=oZEtopU0QTeQUcsMtdy+TIIq8S7SPkCKi2347G6Q3rcEoYsIMc8Us2HzenJhlpFx//HNzL6NkmL7vw3pqTjIcct6yRt40tjuskYzYK+oI4XzReEe/a6DioQ87FKioxXhd8kkPkOgpu7YRwnqn3qvZjOUpBLHMLS4RfIu448t2TQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by SJ5PPF2CD49510F.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 14:00:21 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 14:00:21 +0000
Message-ID: <48abb339-31a7-4083-8775-722fa010f34b@amd.com>
Date: Thu, 1 Oct 2026 10:00:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, vitaly.prosyak@amd.com, tom.stdenis@amd.com
References: <20260930154934.27981-1-mikhail.v.gavrilov@gmail.com>
 <957a0ec9-a772-400a-b633-ecf41d16a2b7@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <957a0ec9-a772-400a-b633-ecf41d16a2b7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::18) To IA1PR12MB8190.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8190:EE_|SJ5PPF2CD49510F:EE_
X-MS-Office365-Filtering-Correlation-Id: 638d16e8-f824-455a-a3c5-08df1fc45525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|10067099003|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /E8A60xUtsDz/fO3uXD+Ixzc2vKQmEe74YC4U5FL+tutD9EE76KkXCOzHUJ5bYFoRomDUFHhun7+JAeFFtgoMoy63kS8SeI7Re/O25SoRlA7t63fbOZCam28TwBQD0n819HSB2j4ChAG9N7dqHgPOfE3MyzMojPJ++66+ejPiZ/K+mUbHS5nggEsiYD1RxEk4le9YDA8X3oIGn0Y5zAB4kcRaTS5p2a3TDplnT5XJZnQlyMvtaDhKVN5sz3gXYNBlUQBPUqw2RRHkCpBzmhmbGSit8ZW4Dv6bv4TUOt/sNF16yOeWF8bGpP5Oj6LM45Uj2tHOkvF2vmXJymvshPYHPbsU4ON6rrArssrcGMJpzi9rI9zn3OkThJDBcG3vZX2Xp0VkmyMPyWpDVAVrNBNmkGNDE6ItoqAvkkiit5vNt0n17rMgIrYV8CZazgjCyKEd1EUQuseS3RfgNJUHB10B6tj97GGtaYPMsbka+803Yjlw6fCIk9BdH85qaon4Q6RULJ58qRvTwvJKS4D62kiBFrlSPGqEPwDYVl3+OkoxfdO2kglr8rwaZRSjug6Dt4Dj3Hlp5BVmHLt4OuWKtX2/0D7I1Es6EKXE2cAZlP5lSrQbr5QU/KWjqSl8AvaOgZbBA1R1urdtzAa2FwJr+ufrrlKJzD2Tsy+L43GEgCY3Hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0lzSVhoMlZFQlVJNjRnYyt2LzZHdG1NcllBemt2NlQvdVlIaUMxQ1cwc1lI?=
 =?utf-8?B?QUl0aGxrR1U1Uml0dDEyVmVtdStBMjNLYTlJV2NCS29sNEVhVzlrR1ByV1VU?=
 =?utf-8?B?MGVSZFo4cEVLZEtVVnduWldhRzREaTViOHBudzR2NjFpa1lrNmduQ2FxbEdx?=
 =?utf-8?B?WVl1SHdkSmdpbUxMS2pncm9DdWZaOEdNcjRnMWxrMUU5UUVwYWZNREFqWS9x?=
 =?utf-8?B?Y21SeDNqSzNLbWU0MUdnMmZoMUh0SEZjWWl3eDF2NXdtYWdGeXVRZjk2eFFp?=
 =?utf-8?B?RFk3UDN6bFpEUzhkZDBlRkJacG94SmFrdk43TUZuVTN1U2JwSzdCZHRLcHp6?=
 =?utf-8?B?ZEhzZVUvU29QTzdSeTRRQVVmOWZMVzNnamtQY1c4eVh6SjhZM081MG5DZnJR?=
 =?utf-8?B?eWJXMy9Ra3duMXlhSWkveEg0WndtU1FxcFMxemtBTlVRakhkNW94SEsyNjRQ?=
 =?utf-8?B?cXc5V05LeG9GWHpjNCt0cW9JOHR2Rm85UjlVUFo5S05ydE5mbUZQbTdkQ0Zo?=
 =?utf-8?B?YzFKUmY4YmlTZHpkdC9UYWROYk9pY3E0V0J6cGpvNFhZZVpmSE5vWkRVWDBW?=
 =?utf-8?B?cXp5THVZVHFpTjhwZlh5U1lkYU5ZV0VQMmhpTWttYmdPMmNpVnhKQ1kvbVdv?=
 =?utf-8?B?UXN1TzlVbi9LSnZYbWNDeWpscTZoc2dVOW1ETnowUkhsc1NQU2Q5enc4aFNF?=
 =?utf-8?B?SnU2enRQMmhJQTgwUmRuYmtxUlNiZjBhK2liUHhnbXF2SXRmemRIbVdycEhq?=
 =?utf-8?B?ejlqOS93eGZsZ1BnY2VFVzRvNnRHQ0ZjRkNGaU1sOXo3U3oxMjk4eGVndkpQ?=
 =?utf-8?B?SEs5YXdJM3RFejgwQWF0L3ZtM09tOGtUUTQwT2d0OUQ1TERITkpTaU1WcFlG?=
 =?utf-8?B?cmpHdmxNaUZsZzg5SXowTG05YXliU0NXc3FuVkpjOXNSRWh6OWN2L0ZyT3M1?=
 =?utf-8?B?RVJoZDd4cUJWZTdLRS9vck03bm9HbGJRY1JSZjVKVWlHUzIwQlMvOWFLdWM4?=
 =?utf-8?B?czN4czRXaW5PNys2UCtPZm11SkpMMEZMaUU3UnhxdU1KeGsxZlZQWDZOSHQ2?=
 =?utf-8?B?cjRQTVR1QUl0WFREN0NmQ3VYU0RJYVVpSlk2dUg0T3V0TENNL2pBQmZId3ls?=
 =?utf-8?B?TzJNQ3VsYUYwMU54YTNyd3o4STYreElOOTlLWEh0U0VyZUY1L0RiQlkzYXB6?=
 =?utf-8?B?M3gza1d3Y0R4RFpQYVhYYWFkV1NlYmlKN3RKNno0bGM3dVJnRnh1aHgrNUFV?=
 =?utf-8?B?N0ZvQ1lQQ3hTWnlvSzNraEZkT05jaXRhdlRlQ1RFVzllcEtySy9JSXA4d2FS?=
 =?utf-8?B?alNHZEZLYldTV3ltc2Y4Nk0yZi9USEV4b296ZWs0RWNGZXBYRUY2b1lRMCtn?=
 =?utf-8?B?dHBUaTB0dlVDd1JVcklRLzBUWFMyd2dpdlM4SmgvOVh3ajdjQ0ZFeURvSUhj?=
 =?utf-8?B?UXQ0Nm10a0p2TTgxTi9UK216REtzWHdvMXV6UFNFbWs2aGpuYys0OHVrNG9V?=
 =?utf-8?B?dHVzMTVSWEcvdWhKSEE2NTY5WTlhTkpyZENKTDltUzJOLzlqRnRRR2V0bGpy?=
 =?utf-8?B?cnFjYUpHQ05sbTdNeXV3NXU5THlKMWtiZlYvMmpkVVE2N0FWaGwzeFVuRERQ?=
 =?utf-8?B?aHNidDNuYzJkbGNRb0pjL3dGN01PbGYvcE5oQ0JLVVR2R3RXMWxpUlpWRXVT?=
 =?utf-8?B?LzJHYVVrcmhYU005RnJKdnE0YzlmWDhKdHRGVUNWdnNQVmlsN3NZTFdDNEVm?=
 =?utf-8?B?V08wTlFhWlFFK1FBMjhSNzRaQXBsdGVYanEwOVFGaUp5MVF3QmtDTHlGZVRM?=
 =?utf-8?B?d2ZhMG85bU11YUJWMkhrZ3hsU1huV3NQYWV5akJaQWNFejNUdVQrK0xnRHNO?=
 =?utf-8?B?YStOLzIvZEQzVzBSMjh2VUZCem5yamhsZ0c2a2VNSmMvZmdvREtHTUt4K2VU?=
 =?utf-8?B?SEhGZXRXY01ZSDFFZUFQdW9ITUNGNHdYdnJZd0NhTTZscVBGcnhwNmNyTDRI?=
 =?utf-8?B?VUJwSmp6a2hoQmlpMVdkNWxXWS9PT0NQTWpTWXM5aXRTZFhqRHBNTmRpWEs2?=
 =?utf-8?B?NmNPZEVxUTFwTVEvbnAyTjJPVXFQclRZcHM5RlE5dGpHeFp6ZmdROWUzc0hm?=
 =?utf-8?B?N2dvMUYrQlk3bTViUytLOHh2dlNlaVdrTkFmNEhmYWc1VndMcHI5eGN6NmhK?=
 =?utf-8?B?VThxajJSdTY5Z3gvZkZvNWFabWM2THVPOGlsNHV2NVpXTnlyYlN1ZzdPbm5S?=
 =?utf-8?B?YTRRVTBqL3Y5VXUrejl4MVM2NTRoME9lNGxCS21nRHhqS1RxMUQ1YmN2dTZB?=
 =?utf-8?B?NFdXazcyZ2k2Sml0aEk3WEN3bDQ1THBHem5MTG1XQ3hzNzNJbEpRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638d16e8-f824-455a-a3c5-08df1fc45525
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:00:21.5797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHlUpKKIsEVcLyXdWKGNvC/Q+EORPr2q4YiRTOwp5K225btwr5lQiSTYf16FAc4rrHVOZWRqVeG3cNFj4LUrcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F
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

Mikhail's proposed kvmalloc(size, GFP_KERNEL) correctly stages user data outside the GRBM/SRBM locks, avoiding a potential page fault while holding those locks.
However, since size is derived directly from a userspace read or write request, we must validate it before allocating memory in both amdgpu_debugfs_process_reg_op() and amdgpu_debugfs_regs2_op().

Tom, do you agree with this? Will adding a restriction here break any UMR  requests?
Please add a bounds check in each handler after the existing alignment/offset validation and immediately before kvmalloc():

if (size > PAGE_SIZE)
    return -EINVAL;

data = kvmalloc(size, GFP_KERNEL);
if (!data)
    return -ENOMEM;

With that input validation addressed:
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>


On 2026-10-01 02:12, Christian König wrote:
> On 9/30/26 17:49, Mikhail Gavrilov wrote:
>> Reading or writing a register through the amdgpu_regs2 debugfs file
>> with GRBM bank selection, which umr does for every banked access (a
>> single "umr -b x x x -r <reg>" is enough, as is the wave dump with
>> "-O halt_waves"), makes lockdep report a circular locking dependency,
>> after which lockdep stays off until reboot:
>>
>>   WARNING: possible circular locking dependency detected
>>   umr/63306 is trying to acquire lock:
>>   ffff8882cf4b8350 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x9b/0x140
>>   but task is already holding lock:
>>   ffff8881aec010d0 (&amdgpu_grbm_lock_key){+.+.}-{4:4}, at: amdgpu_debugfs_regs2_op.isra.0+0x20d/0xd00 [amdgpu]
>>   ...
>>   Chain exists of:
>>     &mm->mmap_lock --> &amdgpu_srbm_lock_key --> &amdgpu_grbm_lock_key
>>   ...
>>    __might_fault+0xc5/0x140
>>    amdgpu_debugfs_regs2_op.isra.0+0x441/0xd00 [amdgpu]
>>    full_proxy_write+0x10e/0x1d0
>>    vfs_write+0x1d0/0xf50
>>    ksys_write+0x116/0x250
>>
>> amdgpu_debugfs_regs2_op() and amdgpu_debugfs_process_reg_op() call
>> get_user()/put_user() for every dword while holding grbm_idx_mutex or
>> srbm_mutex, and pm.mutex if requested, so a fault there takes mmap_lock
>> inside those locks. The lock hierarchy declared in amdgpu_lockdep.c since
>> commit 1d0f5838b126
>> ("drm/amdgpu: Add lockdep annotations for lock ordering validation") puts
>> srbm_mutex and grbm_idx_mutex below notifier_lock, which
>> amdgpu_cs_submit() takes with the BO reservations held, and
>> dma_resv_lockdep() orders the reservations inside mmap_lock. So
>> mmap_lock is outside grbm_idx_mutex and srbm_mutex, and these two
>> debugfs paths nest it the other way round.
>>
>> Copy the user buffer in before any of the locks is taken and the result
>> out after all of them are dropped, as amdgpu_debugfs_wave_read(),
>> amdgpu_debugfs_gpr_read() and amdgpu_debugfs_gprwave_read() already do.
>> A fault on the user buffer of a write now fails with -EFAULT before any
>> register is written, instead of after a partial write.
>>
>> Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
> Well that's not really correct since that patch only makes the problem visible and not introduce it :)
>
> But apart from that rather good catch, Vitalies work to add lockdep annotations pays of.
>
>> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> I don't have time to review this in detail. Vitaly and Tom please take a look at this.
>
> But feel free to add Acked-by: Christian König <christian.koenig@amd.com>
>
> Thanks in advance,
> Christian.
>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 71 ++++++++++++---------
>>  1 file changed, 40 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index aca1a8045afa..5618bd3e2610 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -121,6 +121,17 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>>  
>>  	*pos &= (1UL << 22) - 1;
>>  
>> +	/*
>> +	 * Access the user buffer only while none of the locks below are held:
>> +	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
>> +	 * inside it.
>> +	 */
>> +	u32 *data __free(kvfree) = kvmalloc(size, GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +	if (!read && copy_from_user(data, buf, size))
>> +		return -EFAULT;
>> +
>>  	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>  	if (r < 0) {
>>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> @@ -152,28 +163,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>>  		mutex_lock(&adev->pm.mutex);
>>  
>>  	while (size) {
>> -		uint32_t value;
>> -
>> -		if (read) {
>> -			value = RREG32(*pos >> 2);
>> -			r = put_user(value, (uint32_t *)buf);
>> -		} else {
>> -			r = get_user(value, (uint32_t *)buf);
>> -			if (!r)
>> -				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value, 0);
>> -		}
>> -		if (r) {
>> -			result = r;
>> -			goto end;
>> -		}
>> +		if (read)
>> +			data[result >> 2] = RREG32(*pos >> 2);
>> +		else
>> +			amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, data[result >> 2], 0);
>>  
>>  		result += 4;
>> -		buf += 4;
>>  		*pos += 4;
>>  		size -= 4;
>>  	}
>>  
>> -end:
>>  	if (use_bank) {
>>  		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>  		mutex_unlock(&adev->grbm_idx_mutex);
>> @@ -188,6 +187,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>  
>>  	amdgpu_virt_disable_access_debugfs(adev);
>> +
>> +	if (read && copy_to_user(buf, data, result))
>> +		return -EFAULT;
>> +
>>  	return result;
>>  }
>>  
>> @@ -238,11 +241,21 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>>  	struct amdgpu_device *adev = rd->adev;
>>  	ssize_t result = 0;
>>  	int r;
>> -	uint32_t value;
>>  
>>  	if (size & 0x3 || offset & 0x3)
>>  		return -EINVAL;
>>  
>> +	/*
>> +	 * Access the user buffer only while none of the locks below are held:
>> +	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
>> +	 * inside it.
>> +	 */
>> +	u32 *data __free(kvfree) = kvmalloc(size, GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +	if (write_en && copy_from_user(data, buf, size))
>> +		return -EFAULT;
>> +
>>  	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>  	if (r < 0) {
>>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> @@ -281,24 +294,16 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>>  		mutex_lock(&adev->pm.mutex);
>>  
>>  	while (size) {
>> -		if (!write_en) {
>> -			value = RREG32(offset >> 2);
>> -			r = put_user(value, (uint32_t *)buf);
>> -		} else {
>> -			r = get_user(value, (uint32_t *)buf);
>> -			if (!r)
>> -				amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value, rd->id.xcc_id);
>> -		}
>> -		if (r) {
>> -			result = r;
>> -			goto end;
>> -		}
>> +		if (!write_en)
>> +			data[result >> 2] = RREG32(offset >> 2);
>> +		else
>> +			amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, data[result >> 2],
>> +						rd->id.xcc_id);
>>  		offset += 4;
>>  		size -= 4;
>>  		result += 4;
>> -		buf += 4;
>>  	}
>> -end:
>> +
>>  	if (rd->id.use_grbm) {
>>  		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, rd->id.xcc_id);
>>  		mutex_unlock(&adev->grbm_idx_mutex);
>> @@ -317,6 +322,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>  
>>  	amdgpu_virt_disable_access_debugfs(adev);
>> +
>> +	if (!write_en && copy_to_user(buf, data, result))
>> +		return -EFAULT;
>> +
>>  	return result;
>>  }
>>  

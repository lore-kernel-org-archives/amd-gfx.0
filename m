Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A82C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 14:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C0A1112CCC;
	Tue, 16 Apr 2024 14:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ruj0pchN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E89112CCD
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 14:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxjrWCV1kTO31pqqiSExpVnDJbmisQb4vTAIy6d3Zx3d4kKjFI3AS83jPsnyzISdszgSYU8Mvk5dMwVEh1TCKg7jHN3qtRUY1/tve4Us3WgGSUwJW9HcKW7ktw1GPzN+8O7diN6rnp5hUc8TW6v1qcgXiD8hR/yKThLBku8/wRwBX75s0hZqBAbyNqbVvUTgm8MhQ0p2rWo4RxoIfHb2KNiwq+ucdJo6EQEKfftuRLJqiaIgi22Hz7eZU4wXFKaQ6ykTpj9GAWghwMZdChEqw+j2E8ddlHk90GIgHD0cmy5cWjzlfFWRwbtFABh+SdXhfjc7Yq1p7AAoc34PumPp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxeZuJ67HVLikuvLfVlJtoh+0/Ejc8IH2WG0qDpAAR0=;
 b=iSKWla/iwRV/tJfOaUkZfHabu4rpT9lsG+FwvJJP22UTMEVyykJNzWtasfjqP012ucnXCSImsv8rMN5PA4JEfZmypegHdsp9aHIlGpZFyM+77734NYiDWsP6UjXhMUht89Ea9zXItY21tTs36FzV+sRj4rqCol1OXUsJaUT4b4cyBQBhUHZQ8RcsIqCsBqk9Wohjuld0knRakAputVA6f0dbDl+kHLSNK5PgpH9F1HAnCd+20kXIoLT5HS4DOYgQigVGUySA54tzGh9GK3kDuVWgJ/Iix8Ub7mI03B4G7JSgirA4C3Rc6Qaae47U1JSi/euvFW43mAbfDA3U60YZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxeZuJ67HVLikuvLfVlJtoh+0/Ejc8IH2WG0qDpAAR0=;
 b=Ruj0pchN3AMy/hLKT06eedqlcSQ+5jyZ7zsNdfDyA6MVO1tnIZYlzrl7PUPJtQgXKPl0jWSQiTZkojhqepIgV3fz5jOQ5fcw4Cq3QrABdTQhCLz11YBp0Jblrhj14QFb9vx9tM5+KdCPA1nNE+g8zpP0uWMRD4f1sVZmUYaQl1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:00:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:00:55 +0000
Message-ID: <526b2e61-006e-4bc7-abaf-afa3f6a0af81@amd.com>
Date: Tue, 16 Apr 2024 16:00:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/amdgpu: add support of gfx10 register dump
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240416120804.607272-1-sunil.khatri@amd.com>
 <20240416120804.607272-3-sunil.khatri@amd.com>
 <CADnq5_M3_4pjstwxsfiLAmDXLUHMVVeTHyOm-2gKTzaXZ7QFKQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_M3_4pjstwxsfiLAmDXLUHMVVeTHyOm-2gKTzaXZ7QFKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0047.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: f038d8d7-886f-4e81-cdc5-08dc5e1da285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBBw5GRPV1da3pvNeP9y/hf+4oR5qnBcITZPo1hhoYYtb+Z59CEZsQfhfTX6e+mV/bLJVRUT8J680XmykYghn+y7sockghlcoCSX6cpJm11eR1nRQEFh5+GR/WcLHJUbg4aIhBlqk0vAtcU4Enr0ifzqdA93e76/7iJUoFO6Pg/oIbHLGUI2IijY0j/euV0gK745UnVQWhac3D14Gqhof7MIvfxCexCqxlu3t+LGTbYpHZRXJfPu7RLh8YPbbgYl9EgKXhB/fQvhSFBjvvzb6hFSmVXDPyCgfUnDAZhSGuDyHpyniCBRP38E5YUtnrxx9IWSWEjHbjsbXbXgyItJEXbLGYGyLC53dPf9B+0S6Aj9eJkm7mFVJ/bHJUxHit0JLh1fK8ECHUq2ailoeHJFcj1Yp0SHE084/4S61zKObquelmdlCjZBh7fOiwTCcvaMkovJKpg7dUyr1pdsgFQhHP3L6yi0DArHh24W9Q1DmFaYBYPHEkas7m/UNKfKvUUxwAyluP3R3WQirv0T0QqHhz4I07Rer2YCRQLwoQge80a0eOOqZC30wUwQ594JMU89q7ZVxQMMkZcIHhCrVs/9Vl+JlOccth7giFRor/NvOX/T9sj5z9dM53LFvfC5dPPLuJTdrvfrFRCEqIs58TrRZOg3kgb79nxwY2p+ge6yP8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFgxcmwxbWdJOEFadU5OV2wxd3VLMjlxZUliVStpMHRaNjZscU1Ja0lZUHkr?=
 =?utf-8?B?M3YrbXJQNDUzVHBoU01sbGZ4MGVsMmdwUElwN1NMRU83eUZiK3JhaUtjSmZO?=
 =?utf-8?B?eDB5THV2TWlRbjBibnBlS0V4R3NYM1hVZUkrY0tFd2ZjcDBUd013VU1EZnFM?=
 =?utf-8?B?WkUrWnhPZlFsTnFKb0IzYVZUWGZadmJMWHZIRE0zRStYRGxtQitGWXQ1dml0?=
 =?utf-8?B?VVZmZFEwMFpDSlZOUkNlOHhUUlN1UkllamdFMXg0MzNmWUV0ejF2UGc4UzBz?=
 =?utf-8?B?LzF6QnVVUGNac3d5bnBFcW9MTmdFeEtBWTZSMithT3RjdGxvWHJpRTB6QTR3?=
 =?utf-8?B?WU51S0lNcTJQWDM0Uy9ISE1SaHF2bEd4WTRta01jWW03Z01KMDU5K29ncmRS?=
 =?utf-8?B?OTNiR05rZU5ubkVxU1JjS3hCNFA5MXFTQkw4bitsSzJrQ2ZhdDI4Y21VQUds?=
 =?utf-8?B?V1lVTWRxbktmZUIrdnNqT2FKODdvSDFwNFdWeTYvSHlucUFyQ2Urc0xSSmhu?=
 =?utf-8?B?bkdNRGZzNGZWMHFYWkZSSCtTSnQ4Y1didTFvSmc2eU5QbFhQNW5uU2Z0TGhO?=
 =?utf-8?B?Ukg3b1VNUTc1WjNqV3hRdDVNait4RWhiNlVMZVBlV0xKMVNaeDBPWE1VVFR6?=
 =?utf-8?B?VmgzR3BxdXFoQXB6M1ROZGE5TDA2cEtxUWYvZ0RWTVZXeElsNUc4aENRa2NZ?=
 =?utf-8?B?a0tWcURPSG5VYTRZMHl2eXU4a0xHOHJNYm1xb3d2SVNsSE5jSHUwaVFPN3lj?=
 =?utf-8?B?Wkxya3NIY0F3Mnlwa0oxSFpzODkveEJnT3h5K1VuTXV0TGZlSzV0aWluOWg4?=
 =?utf-8?B?QkQraWd1MGZhTzZ3TW50NmZhejlOdEtQbW9HdTdoK3cyL0lkWlZOZ1h4NVpM?=
 =?utf-8?B?ZVMxUHozQVZ0WEI5QXlCdGdpRDRSUDZaN2dxdTlXaHlCRWhpMVNhK3VWM1Ri?=
 =?utf-8?B?amQ4SGRaR29Ra3F0cklvTmdsdzFnazhKQlRDbVFTL1RQVHB4UWlOdWY0V1VV?=
 =?utf-8?B?YjhoT2FpbFZKVERDN0R3SFBoMWJqOWYrQnNra0c0ck1CSHNUS0xESjVZa1FJ?=
 =?utf-8?B?ZGlBRWZwdmk2QWFQck1Yd0ROM1JJMnViTTRFaUdaYm8zNkNjNFFmZnovUmR2?=
 =?utf-8?B?dThqcE1FekEvVGJaVjdOM3cyRlA3cDBNaWJCSWtuWCtiYXBXQTlHbmxHUXlq?=
 =?utf-8?B?M1hyL3hoeE5pcUkrcnlvUHFCZUczVFYzd0lNVHFuMU5pVkxaNmFUbWMrWExK?=
 =?utf-8?B?UE9WUzdJRGNya1diZlFmNkgxWGNtUURFWmYya0lYbmpXSmVYUzlYUzN6U094?=
 =?utf-8?B?MGxHYWtNMldObVVrYTRPZWtwSlRkaFBHYi83M2M5dzNscm53L3hEYUM3ZXk0?=
 =?utf-8?B?RkMxZGQySzFPL0Qza2M0RUZXU1J1Nk9VeVVZelYwWjhSeGFicW42SjU3dVFB?=
 =?utf-8?B?RGFFUE1jL2hVRjlJVWpmVHBYWmQ5Uzc1YTFYRGZZRi9rM0RHY21pTnVZRUFw?=
 =?utf-8?B?M3k2WjNtVjlhV1h6RmU1dlQ4YVFQeFlPWVBoMHkvdEVRaUtubkJUaDdGMUxM?=
 =?utf-8?B?Um1NbDVDRHRJOWxkeVI5RFpqWVFEaTRHNWZ6ZENPWm92ekNBa1htaFNjc2Uw?=
 =?utf-8?B?UTBDcUFwY0lkcVZqUjFjNjJnQmgxN1p5cGozWCtYUkltMzVES3cvYnJCVXRG?=
 =?utf-8?B?Qjd5MGVudjRGaEZydUVIRVJQQUJFU1lOSVZxMHl4V2JYTHdNbkpSWTd1NTFE?=
 =?utf-8?B?V2JVZkkvUHg1QWIvS3J6OFpwRDNVa28yckF3SWQzYkZNYmR0MUNxcWw3MDBL?=
 =?utf-8?B?bWp2eXI2TTFtckNHWW04b2hwN3FMdEhyTUZoY3J4Uk91K25McngrRGtGNk9y?=
 =?utf-8?B?OFRCM21iNlIwMEptMlQ2RUQyemRFaHNObDVFS0xZOEo5YWtOMzMrMGlpQ3RE?=
 =?utf-8?B?YXRRbCtBeklSNjhZNkErNXZXUmhzbmRPNjNGZWpZZDBvNWJKQUdUSzBwOGpC?=
 =?utf-8?B?bzRZMks4eTlLY0hwb0NlUFhzTlE5Z0xSS08zTGM4V0p5R2RJRHhTYmx3cm5q?=
 =?utf-8?B?VU9DQTRTSmxyWm90WDlPcExtNEI1ajVDR042N1J1YlpuZ1g5dW43N0hyV25N?=
 =?utf-8?Q?YdTEKW128UYGrfurZlUDK7Cmk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f038d8d7-886f-4e81-cdc5-08dc5e1da285
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:00:55.6355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uCr7JG717sjjHp8O1kfoHEKsGl6wMgj+vbVrbip0agSyVkZifVPrK1EIFKcENaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
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

Am 16.04.24 um 15:55 schrieb Alex Deucher:
> On Tue, Apr 16, 2024 at 8:08 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> Adding gfx10 gc registers to be used for register
>> dump via devcoredump during a gpu reset.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  12 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 131 +++++++++++++++++-
>>   .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
>>   4 files changed, 158 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index e0d7f4ee7e16..e016ac33629d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -139,6 +139,18 @@ enum amdgpu_ss {
>>          AMDGPU_SS_DRV_UNLOAD
>>   };
>>
>> +struct hwip_reg_entry {
>> +       u32     hwip;
>> +       u32     inst;
>> +       u32     seg;
>> +       u32     reg_offset;
>> +};
>> +
>> +struct reg_pair {
>> +       u32     offset;
>> +       u32     value;
>> +};
>> +
>>   struct amdgpu_watchdog_timer {
>>          bool timeout_fatal_disable;
>>          uint32_t period; /* maxCycles = (1 << period), the number of cycles before a timeout */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index 04a86dff71e6..295a2c8d2e48 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -433,6 +433,10 @@ struct amdgpu_gfx {
>>          uint32_t                        num_xcc_per_xcp;
>>          struct mutex                    partition_mutex;
>>          bool                            mcbp; /* mid command buffer preemption */
>> +
>> +       /* IP reg dump */
>> +       struct reg_pair                 *ip_dump;
>> +       uint32_t                        reg_count;
>>   };
>>
>>   struct amdgpu_gfx_ras_reg_entry {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index a0bc4196ff8b..46e136609ff1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
>>
>> +static const struct hwip_reg_entry gc_reg_list_10_1[] = {
>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS3) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT1) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STALLED_STAT1) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_BUSY_STAT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_ERROR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_HPD_STATUS0) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_BASE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_RPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_WPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_BASE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_RPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_WPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_BASE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_RPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_WPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_BASE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_CMD_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_CMD_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_CMD_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_CMD_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_LO) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_HI) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_LO) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_HI) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_LO) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_HI) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_LO) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_HI) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCPF_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCPC_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCPG_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGDS_PROTECTION_FAULT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGDS_VM_PROTECTION_FAULT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS_2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmPA_CL_CNTL_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRMI_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmSQC_DCACHE_UTCL0_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmSQC_ICACHE_UTCL0_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmSQG_UTCL0_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmTCP_UTCL0_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmWD_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_DEBUG) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC_CNTL) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_CNTL) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC1_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC2_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_ME_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_PFP_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_STAT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_COMMAND) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_MESSAGE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_1) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_3) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_4) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmSMU_RLC_RESPONSE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SAFE_MODE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_SAFE_MODE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_GPM_STAT_2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SPP_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_INT_STAT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_GENERAL_6) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_A) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_B) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) }
>> +};
> Might want to add the string name for the register as well.

I think we could hack up the SOC15_REG_ENTRY() macro for that. E.g. have 
a const pointer to the stringified last parameter in the hwip_reg_entry.

And btw please name that amdgpu_hwip_reg_entry.

Regards,
Christian.

>    It would
> be nice to print the register name rather than the offset in the
> devcoredump.
>
> E.g.,
>
>
>> +
>>   static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>          SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
>>          SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
>> @@ -4490,6 +4583,23 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>>                               hw_prio, NULL);
>>   }
>>
>> +static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
>> +{
>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>> +       struct reg_pair *ptr;
>> +
>> +       ptr = kcalloc(reg_count, sizeof(struct reg_pair), GFP_KERNEL);
> I think you only need to allocate enough memory to store the register
> values.  We already have the offsets in the array above.
> { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS), "mmGRBM_STATUS" },
>
>> +       if (ptr == NULL) {
>> +               DRM_ERROR("Failed to allocate memory for IP Dump\n");
>> +               adev->gfx.ip_dump = NULL;
>> +               adev->gfx.reg_count = 0;
>> +       }
>> +       else {
>> +               adev->gfx.ip_dump = ptr;
>> +               adev->gfx.reg_count = reg_count;
>> +       }
>> +}
>> +
>>   static int gfx_v10_0_sw_init(void *handle)
>>   {
>>          int i, j, k, r, ring_id = 0;
>> @@ -4642,6 +4752,8 @@ static int gfx_v10_0_sw_init(void *handle)
>>
>>          gfx_v10_0_gpu_early_init(adev);
>>
>> +       gfx_v10_0_alloc_dump_mem(adev);
>> +
>>          return 0;
>>   }
>>
>> @@ -4694,6 +4806,8 @@ static int gfx_v10_0_sw_fini(void *handle)
>>
>>          gfx_v10_0_free_microcode(adev);
>>
>> +       kfree(adev->gfx.ip_dump);
>> +
>>          return 0;
>>   }
>>
>> @@ -9154,6 +9268,21 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>>          amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>   }
>>
>> +static void gfx_v10_ip_dump(void *handle)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +       uint32_t i;
>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>> +
>> +       if (!adev->gfx.ip_dump)
>> +               return;
>> +
> Need turn disallow gfxoff before reading the gfx registers:
>
> amdgpu_gfx_off_ctrl(adev, false);
>
>> +       for (i = 0; i < reg_count; i++) {
>> +               adev->gfx.ip_dump[i].offset = gc_reg_list_10_1[i].reg_offset;
> No need to store the offset.  We already have it in the static array above.
>
>> +               adev->gfx.ip_dump[i].value = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
>> +       }
> And then allow it again:
>
> amdgpu_gfx_off_ctrl(adev, true);
>
>> +}
>> +
>>   static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>          .name = "gfx_v10_0",
>>          .early_init = gfx_v10_0_early_init,
>> @@ -9170,7 +9299,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>          .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>>          .set_powergating_state = gfx_v10_0_set_powergating_state,
>>          .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>> -       .dump_ip_state = NULL,
>> +       .dump_ip_state = gfx_v10_ip_dump,
>>   };
>>
>>   static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> index 4908044f7409..4c8e7fdb6976 100644
>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> @@ -4830,6 +4830,8 @@
>>   #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                                                        0
>>   #define mmGB_EDC_MODE                                                                                  0x1e1e
>>   #define mmGB_EDC_MODE_BASE_IDX                                                                         0
>> +#define mmCP_DEBUG                                                                                     0x1e1f
>> +#define mmCP_DEBUG_BASE_IDX                                                                            0
>>   #define mmCP_FETCHER_SOURCE                                                                            0x1e22
>>   #define mmCP_FETCHER_SOURCE_BASE_IDX                                                                   0
>>   #define mmCP_PQ_WPTR_POLL_CNTL                                                                         0x1e23
>> @@ -7778,6 +7780,8 @@
>>   #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                                                            1
>>   #define mmCP_MES_DOORBELL_CONTROL6                                                                     0x2841
>>   #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                                                            1
>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                            0x2842
>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                   1
>>   #define mmCP_MES_GP0_LO                                                                                0x2843
>>   #define mmCP_MES_GP0_LO_BASE_IDX                                                                       1
>>   #define mmCP_MES_GP0_HI                                                                                0x2844
>> @@ -9332,10 +9336,16 @@
>>   #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                                                                  1
>>   #define mmRLC_LB_CNTR_1                                                                                0x4c1c
>>   #define mmRLC_LB_CNTR_1_BASE_IDX                                                                       1
>> +#define mmRLC_GPM_DEBUG_INST_ADDR                                                                      0x4c1d
>> +#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                                                             1
>>   #define mmRLC_JUMP_TABLE_RESTORE                                                                       0x4c1e
>>   #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                                                              1
>>   #define mmRLC_PG_DELAY_2                                                                               0x4c1f
>>   #define mmRLC_PG_DELAY_2_BASE_IDX                                                                      1
>> +#define mmRLC_GPM_DEBUG_INST_A                                                                         0x4c22
>> +#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                                                                1
>> +#define mmRLC_GPM_DEBUG_INST_B                                                                         0x4c23
>> +#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                                                                1
>>   #define mmRLC_GPU_CLOCK_COUNT_LSB                                                                      0x4c24
>>   #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                                                             1
>>   #define mmRLC_GPU_CLOCK_COUNT_MSB                                                                      0x4c25
>> @@ -9720,6 +9730,8 @@
>>   #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                                                           1
>>   #define mmRLC_LB_CNTR_2                                                                                0x4de7
>>   #define mmRLC_LB_CNTR_2_BASE_IDX                                                                       1
>> +#define mmRLC_LX6_CORE_PDEBUG_INST                                                                     0x4deb
>> +#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                                                            1
>>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL                                                                  0x4df1
>>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                                                         1
>>   #define mmRLC_CPAXI_DOORBELL_MON_STAT                                                                  0x4df2
>> --
>> 2.34.1
>>


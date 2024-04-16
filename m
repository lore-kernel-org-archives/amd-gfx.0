Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91FEC04FF6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 17:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1579A8926F;
	Tue, 16 Apr 2024 17:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tXPuRprf";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3268926F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 17:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6hvBvLf7FQc8hSbKL3oKE+OBmPQh0Fa3nDQ8Xj9gQ1t2u56iTeVuU3TEfaKH6NXBsykWl/dqyXw7erusoIex2sAFiBNvdud/HBAFDfasNrmKTJy0/scMlbZZf/uewH/5fmWz1XeENBfsLgWZnMVgPQLFRhVPpzoIdC60nC1Fq0xM/4VWrzhzJjDc9jBbowGtWRQcT9eBG1/0MwBtvDU4rhsrIuPG8WTaSM/PuIbLh/NJ3URW/O6zUF8sH7fb0rXf8C3cIBpzcRRgYIMXlCU2z0co7BKt1+Ok3yVlGepRQNYha5tseFRIeYSC+2ya5KGyZr1ZjWT/TrIHSKq4NVnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8EGPczksYbipN92fJFQOJdiGqrWGHVvsJS2Sb7SLsM=;
 b=e8k61s+n+VGUujfE4gzzY31vtPRDbN8nNg81p41iwBX6yqw3Q/7TCd2Ziu1JQ9m9OkCnoEZv+2QOq2FH9pehh4vSoE2O+4OOdv5r8f1qLJK/rAYD+GhKa/7ozOW7Fnq7iXXoHf7FDu/rsTDlcQUZu1M4Wx68DC+mrCMQb7clVR9Zl2aszdipxuPalLh43F9Dd4GR41pGuhNPOiCrZZGjvBTo34kqT0hR3xSEb1+oKiacRkkhLqET6QnEBmrFm66ydCgilVmCZDg3vMql5kd0h4zh4DEXS/brYo4FvBGjTiS+O8QR30ERwIELV/YkJ8mPBOny5LF8A4urmUPg2vYa9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8EGPczksYbipN92fJFQOJdiGqrWGHVvsJS2Sb7SLsM=;
 b=tXPuRprfkdJF9iEl5qwWfURwZxUjGebGkQvh4F//bSjZ5qeCjyiHDmCEjzlHb2fGBKn42mgbTwNF6smZJPuNgc5PHYJRdV1sxlH5BYLoxuQBxPtsq+MVdZbFAW4yG+P2GifdvzjUBhw6QEqWgyVLJAsaoYfPvcwI0MlCTv+ejpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 17:32:41 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 17:32:41 +0000
Content-Type: multipart/alternative;
 boundary="------------Irbr4BEc0iVvTVbqe7P36wyY"
Message-ID: <b9ade1d5-8d44-4a05-bc36-35e09c2bad0c@amd.com>
Date: Tue, 16 Apr 2024 23:02:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/amdgpu: add support of gfx10 register dump
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240416120804.607272-1-sunil.khatri@amd.com>
 <20240416120804.607272-3-sunil.khatri@amd.com>
 <CADnq5_M3_4pjstwxsfiLAmDXLUHMVVeTHyOm-2gKTzaXZ7QFKQ@mail.gmail.com>
 <526b2e61-006e-4bc7-abaf-afa3f6a0af81@amd.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <526b2e61-006e-4bc7-abaf-afa3f6a0af81@amd.com>
X-ClientProxiedBy: PN3PEPF00000189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::54) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c19ebb3-c441-4c7b-4e63-08dc5e3b3772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAAQhwgygdnIyDGVJYq8AFPb5BDK5CGXJtAhZCU40OragXv83U/EHzN91E4gDoasFGIJQqtyNKindcOsTuXhyGMJ/K/ajEPCaEMxLY4tEztXmgyADoyhnC4s6sW2Rv1VpNgMn8ji2mDxjlYO7NV6qF3UjR4SBw/LJuytz0B6ACSB0kREHB6DH+KxIHq89TQdetOeMfr56WB6AHJgEZi/X+jnM38i+SZwFilDtkK6YcMZNo4ZjtXdGGfhWhcmNrwqJ7krSj9sFxBwnXirWMbGSbL0Mb8qZgQBsHVriRHhOy+9rz/Q1gBRlPmsx4BRqapbrLDmKdBa0DRl4RkUO9ySj8dNjKPNhqylH4P/37BV4W39UA0eMRis2iSxTgYJuRXVoRNkvkobYY85+NRgz+l99KYNvTuazMUyW5bZAuPuuDRxJWMoQW7zhYOhFqn1x/omJXKcR4GokQzwWEQABLiCrACY3RSefPmV2spDQrkxIlA6Q8NNYh9Jib9e0gASSJJ18msuOE4mAhp1u7VQOBHXcT4GHkcizItnHOOrkWsGFkIR8mSjmgnFSCG9YjXQErS7YjKQqJ58GPVmh5EtAlytOnxeJEdW3ZJ0rS6OLLwTof4SH2DF5XM6UPEMsQJivhcgVIm1QunSjYsRdP6xvtWSM2HjipQI/GOSuzEFvfDkVoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0NVbHpIVnU4cFNiNTB1UFZGOVFVZ3R6VHY5d1U0dHo1SEhJM0lrdU9Eako1?=
 =?utf-8?B?eE9kbEZDVEYreGtQc0VJQmZtSHhBWnhhVlBOTnNSaml3QnFmNCszckNEQnVG?=
 =?utf-8?B?SDI4aktIdTFYYUhnd3NaTmlBS3lMZEQ3TnlkS0w0V2xvNEd0aEcybCs4ZUNV?=
 =?utf-8?B?ZVY4YVQvUlVaZzVYVE5hRW44c09iY1pncmFqSTdxOUxNajkrekFzUGNMOHhm?=
 =?utf-8?B?UkpmTENyQmhIRlJDTExCa2RJY3htSUEyZTBIaVJxaWE0TmFSdTBHTUlhY0tL?=
 =?utf-8?B?M05hM1E4WXFmTGNMeVZvT2ozMEVPNXBNYUw0RnlzUFIzZlNsZzMycWJ3R3gv?=
 =?utf-8?B?TWpKYzkvTDVuRUN5M0YxaytpYlo4cS9tQzNOVDlubTFvOFI3bjB5VExjL0ZV?=
 =?utf-8?B?VUZNeWs5cUM2NnlBaUpWYVBUNXpWYXBJWXFDa00vbEhRaFNqdDFsMEEwYkNy?=
 =?utf-8?B?S3prQjRUbjA3QUlhQUtyQjBxcTRZLy9HbTJ3cURDcitEdFo2RnkvOFBIUUdR?=
 =?utf-8?B?cVYrdFNYU2RFZlIyOGxzOWh5U3dXQkRBSmpLK09IZGhuejgzY3BSd1dwWmZw?=
 =?utf-8?B?dzZSY2FTcUF1ajZHSlpUR3BFTk9zVlNxU3MwWWgxUHhEdVFGYVRJaTZWZkov?=
 =?utf-8?B?Q3RpRzdZc2cwS1lxU0xWR3d6K3hUMnQ4eEVFeE14OURNb01HaTg1TW5Eb0Jr?=
 =?utf-8?B?dDhlZzdUQ0EwNVc4eXZyblVhL2NkbUt6UTkrNnM2Mm5VZEFYOVhHVVI5N0hm?=
 =?utf-8?B?dEhRWXJ4VlRTbHVZdHR6MExwRWR1Mm0xZS9tWmZSMG9VKzB6WFo3UElMbzc1?=
 =?utf-8?B?OUcxbmlOS1Q2QWluOFdWVmYzQVFzSUZlMHdCSHp0d29kYUoxMDluOURITFZX?=
 =?utf-8?B?UmlpVmY5WTBVSDFOYk5Bd2UxRjBmR0p0UEthdEhLSVl2bHFvTmsxTnBNWVRB?=
 =?utf-8?B?QktSc25pTlNybnJRL290c2hIOEtzVkdEUGx6WjMxQXRhcUY2SmdxZmhpWEN5?=
 =?utf-8?B?UVZ0bHJnbUVZQmoxd0J4NWE4Z2Nad1BYcmx5YWNlekcxYzVhVzFRUEJCdFNJ?=
 =?utf-8?B?UTFWendaM29EMDJpK05WbFFrc1MwZ24rZEp1b2UxcllBdjZ4Tkd2TzRWN3NB?=
 =?utf-8?B?S1A5by9DZ0dzSTJHQy8zVW5XbFNjWE5qQ2pHY0wrdmtiSTFVZzhWVW5UY1Y5?=
 =?utf-8?B?R1B0MjNZR0ZHY2lkRmJUc3d2a3F2UzFoOFQzQ0loYnM2ajdpTHQ3Sis4ZWFx?=
 =?utf-8?B?WmREMHMvNzFQVzNOanlxVWk1N3VMYmFqMno5TDZKZ3NVZy9GUDFxendDN1Zv?=
 =?utf-8?B?R2lDcVJWSlVGdEJnMUU3Z0ltdGFsNTdTZGdxRCtXTEFuRUw0VFp3N1N2dy9V?=
 =?utf-8?B?UVVXQm1vam41OFpKYnFsLzNCS3NqMHI3NHFpTmlGbVNmanhkSS9nOVN5ZzhE?=
 =?utf-8?B?RmVhdkNtZll4WEI3T1IyempuaTdBc0ZRQ2hLNmNucnZKSjBMZVIza0VLc1Vj?=
 =?utf-8?B?S1BHS2ZBZ00wYWtVa3NBOWp2UUNmQVdYcDVHL1dHU1VwaUdPemR6MldBZjht?=
 =?utf-8?B?T3prcnVieVJ2bDhnOGxhQmRLVzlzeE55WDdJMTlSRFhTSy9JVTBiSExzWWhV?=
 =?utf-8?B?V3dZV0M5amkyWFZVcWlySTZxODRrcXhaL0FvRTk5YXNObmJaNTY0eFhyTTl3?=
 =?utf-8?B?SnpMcVhENXNNeHRKaFBpSjlXWGxZRElVbUZ6aHkxZmhqYlljeUNZaDE0ZmdO?=
 =?utf-8?B?aGJZWDJRU1M0U1hKYkNSeHYrejd2Y3BUa0Z3elBML2w1U2cyd0Z5WEVtbzFl?=
 =?utf-8?B?ekE4Z2drU2xWUnZqUHV0WUtBK3hqN0o5U056SG9kUkZBRGJEQ2RsMUZ3YU1Z?=
 =?utf-8?B?RUNheTJYQkpiR0JabzdqellIS3E5Si9lU29MVXJiQVo3alhXRUZFNDErWStB?=
 =?utf-8?B?THJyZHk2c0p5bkRiMm43Ui8rYmZ6SVVjZmtiV2VmaE5VR0UxL0E4cUE0Uk1z?=
 =?utf-8?B?Q0NJM2o1UDJSdDhjQzI2ckxZMGpLZm00NmxkZmRVcUtvTmJnNkxGYnBUWXYr?=
 =?utf-8?B?OFpkQmRFNFZIRUNObGw4dWE2amVCMFNROTVCVEFWc294cVFUQ0x3blo2Vk9T?=
 =?utf-8?Q?DcFWPcPPEwWU31B/h3VZMb0yw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c19ebb3-c441-4c7b-4e63-08dc5e3b3772
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 17:32:40.9994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZ9LlfFVi2iVPMWbG9wQrS/jwOk1CW2NYd1VfFAzR472ISky9nEJZ+m0Rfgo1n3NlMnEFEIMK5Xbmj38DaDZMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
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

--------------Irbr4BEc0iVvTVbqe7P36wyY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/16/2024 7:30 PM, Christian König wrote:
> Am 16.04.24 um 15:55 schrieb Alex Deucher:
>> On Tue, Apr 16, 2024 at 8:08 AM Sunil Khatri <sunil.khatri@amd.com> 
>> wrote:
>>> Adding gfx10 gc registers to be used for register
>>> dump via devcoredump during a gpu reset.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  12 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 131 
>>> +++++++++++++++++-
>>>   .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
>>>   4 files changed, 158 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index e0d7f4ee7e16..e016ac33629d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -139,6 +139,18 @@ enum amdgpu_ss {
>>>          AMDGPU_SS_DRV_UNLOAD
>>>   };
>>>
>>> +struct hwip_reg_entry {
>>> +       u32     hwip;
>>> +       u32     inst;
>>> +       u32     seg;
>>> +       u32     reg_offset;
>>> +};
>>> +
>>> +struct reg_pair {
>>> +       u32     offset;
>>> +       u32     value;
>>> +};
>>> +
>>>   struct amdgpu_watchdog_timer {
>>>          bool timeout_fatal_disable;
>>>          uint32_t period; /* maxCycles = (1 << period), the number 
>>> of cycles before a timeout */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> index 04a86dff71e6..295a2c8d2e48 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> @@ -433,6 +433,10 @@ struct amdgpu_gfx {
>>>          uint32_t                        num_xcc_per_xcp;
>>>          struct mutex                    partition_mutex;
>>>          bool                            mcbp; /* mid command buffer 
>>> preemption */
>>> +
>>> +       /* IP reg dump */
>>> +       struct reg_pair                 *ip_dump;
>>> +       uint32_t                        reg_count;
>>>   };
>>>
>>>   struct amdgpu_gfx_ras_reg_entry {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index a0bc4196ff8b..46e136609ff1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
>>>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
>>>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
>>>
>>> +static const struct hwip_reg_entry gc_reg_list_10_1[] = {
>>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS3) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT1) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT2) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STALLED_STAT1) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_BUSY_STAT) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT2) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT2) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_ERROR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_HPD_STATUS0) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_BASE) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_RPTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_WPTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_BASE) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_RPTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_WPTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_BASE) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_RPTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_WPTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_BASE) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_CMD_BUFSZ) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_CMD_BUFSZ) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_CMD_BUFSZ) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_CMD_BUFSZ) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_LO) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_HI) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BUFSZ) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_LO) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_HI) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BUFSZ) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_LO) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_HI) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BUFSZ) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_LO) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_HI) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BUFSZ) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCPF_UTCL1_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCPC_UTCL1_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCPG_UTCL1_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmGDS_PROTECTION_FAULT) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmGDS_VM_PROTECTION_FAULT) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS_2) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmPA_CL_CNTL_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_UTCL1_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRMI_UTCL1_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmSQC_DCACHE_UTCL0_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmSQC_ICACHE_UTCL0_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmSQG_UTCL0_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmTCP_UTCL0_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmWD_UTCL1_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_DEBUG) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC_CNTL) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_CNTL) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_INSTR_PNTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC1_INSTR_PNTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC2_INSTR_PNTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, 
>>> mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_INSTR_PNTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_ME_INSTR_PNTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_PFP_INSTR_PNTR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_STAT) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_COMMAND) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_MESSAGE) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_1) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_2) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_3) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_4) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmSMU_RLC_RESPONSE) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SAFE_MODE) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_SAFE_MODE) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_GPM_STAT_2) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SPP_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_INT_STAT) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_GENERAL_6) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_A) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_B) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR) },
>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) }
>>> +};
>> Might want to add the string name for the register as well.
>
> I think we could hack up the SOC15_REG_ENTRY() macro for that. E.g. 
> have a const pointer to the stringified last parameter in the 
> hwip_reg_entry.


How does this sound ?
structamdgpu_hwip_reg_entry{
         u32 hwip;
         u32 inst;
         u32 seg;
         u32 reg_offset;
charreg_name[50];
};

#defineSOC15_REG_ENTRY_STR(ip, inst, reg)  ip##_HWIP, inst, 
reg##_BASE_IDX, reg, #reg
staticconststructamdgpu_hwip_reg_entrygc_reg_list_10_1[]={
         { SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS) },
}


>
> And btw please name that amdgpu_hwip_reg_entry.
Noted
>
> Regards,
> Christian.
>
>>    It would
>> be nice to print the register name rather than the offset in the
>> devcoredump.
>>
>> E.g.,
>>
>>
>>> +
>>>   static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>>          SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 
>>> 0xffffffff, 0x00400014),
>>>          SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 
>>> 0xfcff8fff, 0xf8000100),
>>> @@ -4490,6 +4583,23 @@ static int gfx_v10_0_compute_ring_init(struct 
>>> amdgpu_device *adev, int ring_id,
>>>                               hw_prio, NULL);
>>>   }
>>>
>>> +static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
>>> +{
>>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>> +       struct reg_pair *ptr;
>>> +
>>> +       ptr = kcalloc(reg_count, sizeof(struct reg_pair), GFP_KERNEL);
>> I think you only need to allocate enough memory to store the register
>> values.  We already have the offsets in the array above.
>> { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS), "mmGRBM_STATUS" },
>>
>>> +       if (ptr == NULL) {
>>> +               DRM_ERROR("Failed to allocate memory for IP Dump\n");
>>> +               adev->gfx.ip_dump = NULL;
>>> +               adev->gfx.reg_count = 0;
>>> +       }
>>> +       else {
>>> +               adev->gfx.ip_dump = ptr;
>>> +               adev->gfx.reg_count = reg_count;
>>> +       }
>>> +}
>>> +
>>>   static int gfx_v10_0_sw_init(void *handle)
>>>   {
>>>          int i, j, k, r, ring_id = 0;
>>> @@ -4642,6 +4752,8 @@ static int gfx_v10_0_sw_init(void *handle)
>>>
>>>          gfx_v10_0_gpu_early_init(adev);
>>>
>>> +       gfx_v10_0_alloc_dump_mem(adev);
>>> +
>>>          return 0;
>>>   }
>>>
>>> @@ -4694,6 +4806,8 @@ static int gfx_v10_0_sw_fini(void *handle)
>>>
>>>          gfx_v10_0_free_microcode(adev);
>>>
>>> +       kfree(adev->gfx.ip_dump);
>>> +
>>>          return 0;
>>>   }
>>>
>>> @@ -9154,6 +9268,21 @@ static void gfx_v10_0_emit_mem_sync(struct 
>>> amdgpu_ring *ring)
>>>          amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>>   }
>>>
>>> +static void gfx_v10_ip_dump(void *handle)
>>> +{
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +       uint32_t i;
>>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>> +
>>> +       if (!adev->gfx.ip_dump)
>>> +               return;
>>> +
>> Need turn disallow gfxoff before reading the gfx registers:
>>
>> amdgpu_gfx_off_ctrl(adev, false);
>>
>>> +       for (i = 0; i < reg_count; i++) {
>>> +               adev->gfx.ip_dump[i].offset = 
>>> gc_reg_list_10_1[i].reg_offset;
>> No need to store the offset.  We already have it in the static array 
>> above.
>>
>>> + adev->gfx.ip_dump[i].value = 
>>> RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
>>> +       }
>> And then allow it again:
>>
>> amdgpu_gfx_off_ctrl(adev, true);
>>
>>> +}
>>> +
>>>   static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>>          .name = "gfx_v10_0",
>>>          .early_init = gfx_v10_0_early_init,
>>> @@ -9170,7 +9299,7 @@ static const struct amd_ip_funcs 
>>> gfx_v10_0_ip_funcs = {
>>>          .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>>>          .set_powergating_state = gfx_v10_0_set_powergating_state,
>>>          .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>>> -       .dump_ip_state = NULL,
>>> +       .dump_ip_state = gfx_v10_ip_dump,
>>>   };
>>>
>>>   static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>>> diff --git 
>>> a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h 
>>> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>> index 4908044f7409..4c8e7fdb6976 100644
>>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>> @@ -4830,6 +4830,8 @@
>>>   #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX 0
>>>   #define mmGB_EDC_MODE 0x1e1e
>>>   #define mmGB_EDC_MODE_BASE_IDX 0
>>> +#define mmCP_DEBUG 0x1e1f
>>> +#define mmCP_DEBUG_BASE_IDX 0
>>>   #define mmCP_FETCHER_SOURCE 0x1e22
>>>   #define mmCP_FETCHER_SOURCE_BASE_IDX 0
>>>   #define mmCP_PQ_WPTR_POLL_CNTL 0x1e23
>>> @@ -7778,6 +7780,8 @@
>>>   #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX 1
>>>   #define mmCP_MES_DOORBELL_CONTROL6 0x2841
>>>   #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX 1
>>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR 0x2842
>>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX 1
>>>   #define mmCP_MES_GP0_LO 0x2843
>>>   #define mmCP_MES_GP0_LO_BASE_IDX 1
>>>   #define mmCP_MES_GP0_HI 0x2844
>>> @@ -9332,10 +9336,16 @@
>>>   #define mmRLC_LB_CNTR_INIT_1_BASE_IDX 1
>>>   #define mmRLC_LB_CNTR_1 0x4c1c
>>>   #define mmRLC_LB_CNTR_1_BASE_IDX 1
>>> +#define mmRLC_GPM_DEBUG_INST_ADDR 0x4c1d
>>> +#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX 1
>>>   #define mmRLC_JUMP_TABLE_RESTORE 0x4c1e
>>>   #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX 1
>>>   #define mmRLC_PG_DELAY_2 0x4c1f
>>>   #define mmRLC_PG_DELAY_2_BASE_IDX 1
>>> +#define mmRLC_GPM_DEBUG_INST_A 0x4c22
>>> +#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX 1
>>> +#define mmRLC_GPM_DEBUG_INST_B 0x4c23
>>> +#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX 1
>>>   #define mmRLC_GPU_CLOCK_COUNT_LSB 0x4c24
>>>   #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX 1
>>>   #define mmRLC_GPU_CLOCK_COUNT_MSB 0x4c25
>>> @@ -9720,6 +9730,8 @@
>>>   #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX 1
>>>   #define mmRLC_LB_CNTR_2 0x4de7
>>>   #define mmRLC_LB_CNTR_2_BASE_IDX 1
>>> +#define mmRLC_LX6_CORE_PDEBUG_INST 0x4deb
>>> +#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX 1
>>>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL 0x4df1
>>>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX 1
>>>   #define mmRLC_CPAXI_DOORBELL_MON_STAT 0x4df2
>>> -- 
>>> 2.34.1
>>>
>
--------------Irbr4BEc0iVvTVbqe7P36wyY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/16/2024 7:30 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:526b2e61-006e-4bc7-abaf-afa3f6a0af81@amd.com">Am
      16.04.24 um 15:55 schrieb Alex Deucher:
      <br>
      <blockquote type="cite">On Tue, Apr 16, 2024 at 8:08 AM Sunil
        Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a> wrote:
        <br>
        <blockquote type="cite">Adding gfx10 gc registers to be used for
          register
          <br>
          dump via devcoredump during a gpu reset.
          <br>
          <br>
          Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 12 ++
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 131
          +++++++++++++++++-
          <br>
          &nbsp; .../include/asic_reg/gc/gc_10_1_0_offset.h&nbsp;&nbsp;&nbsp; |&nbsp; 12 ++
          <br>
          &nbsp; 4 files changed, 158 insertions(+), 1 deletion(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          index e0d7f4ee7e16..e016ac33629d 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          @@ -139,6 +139,18 @@ enum amdgpu_ss {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_SS_DRV_UNLOAD
          <br>
          &nbsp; };
          <br>
          <br>
          +struct hwip_reg_entry {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; hwip;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; inst;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; seg;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; reg_offset;
          <br>
          +};
          <br>
          +
          <br>
          +struct reg_pair {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; offset;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; value;
          <br>
          +};
          <br>
          +
          <br>
          &nbsp; struct amdgpu_watchdog_timer {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool timeout_fatal_disable;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t period; /* maxCycles = (1 &lt;&lt; period),
          the number of cycles before a timeout */
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
          <br>
          index 04a86dff71e6..295a2c8d2e48 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
          <br>
          @@ -433,6 +433,10 @@ struct amdgpu_gfx {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc_per_xcp;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; partition_mutex;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mcbp; /* mid command
          buffer preemption */
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IP reg dump */
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct reg_pair&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ip_dump;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_count;
          <br>
          &nbsp; };
          <br>
          <br>
          &nbsp; struct amdgpu_gfx_ras_reg_entry {
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
          b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
          <br>
          index a0bc4196ff8b..46e136609ff1 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
          <br>
          @@ -276,6 +276,99 @@
          MODULE_FIRMWARE(&quot;amdgpu/gc_10_3_7_mec.bin&quot;);
          <br>
          &nbsp; MODULE_FIRMWARE(&quot;amdgpu/gc_10_3_7_mec2.bin&quot;);
          <br>
          &nbsp; MODULE_FIRMWARE(&quot;amdgpu/gc_10_3_7_rlc.bin&quot;);
          <br>
          <br>
          +static const struct hwip_reg_entry gc_reg_list_10_1[] = {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS3) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT1) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT2) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STALLED_STAT1) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_BUSY_STAT) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT2) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT2) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_ERROR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_HPD_STATUS0) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB_BASE) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB_RPTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB_WPTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_BASE) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_RPTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_WPTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_BASE) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_RPTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_WPTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_BASE) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_CMD_BUFSZ) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_CMD_BUFSZ) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_CMD_BUFSZ) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_CMD_BUFSZ) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_LO) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_HI) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BUFSZ) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_LO) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_HI) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BUFSZ) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_LO) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_HI) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BUFSZ) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_LO) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_HI) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BUFSZ) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCPF_UTCL1_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCPC_UTCL1_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCPG_UTCL1_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmGDS_PROTECTION_FAULT) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmGDS_VM_PROTECTION_FAULT) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS_2) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmPA_CL_CNTL_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_UTCL1_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRMI_UTCL1_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmSQC_DCACHE_UTCL0_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmSQC_ICACHE_UTCL0_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmSQG_UTCL0_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmTCP_UTCL0_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmWD_UTCL1_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0,
          mmGCVM_L2_PROTECTION_FAULT_CNTL) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0,
          mmGCVM_L2_PROTECTION_FAULT_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_DEBUG) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_MEC_CNTL) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_MES_CNTL) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CE_INSTR_PNTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_MEC1_INSTR_PNTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_MEC2_INSTR_PNTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0,
          mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_MES_INSTR_PNTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_ME_INSTR_PNTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_PFP_INSTR_PNTR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_STAT) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_COMMAND) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_MESSAGE) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_1) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_2) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_3) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_4) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmSMU_RLC_RESPONSE) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_SAFE_MODE) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_SAFE_MODE) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_GPM_STAT_2) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_SPP_STATUS) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS)
          },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_INT_STAT) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_GENERAL_6) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_A) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_B) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR) },
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) }
          <br>
          +};
          <br>
        </blockquote>
        Might want to add the string name for the register as well.
        <br>
      </blockquote>
      <br>
      I think we could hack up the SOC15_REG_ENTRY() macro for that.
      E.g. have a const pointer to the stringified last parameter in the
      hwip_reg_entry.
      <br>
    </blockquote>
    <p><br>
    </p>
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #569cd6;">How does this sound ?
</span></div><div><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_hwip_reg_entry</span><span style="color: #cccccc;"> {</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; u32 &nbsp; &nbsp; </span><span style="color: #9cdcfe;">hwip</span><span style="color: #cccccc;">;</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; u32 &nbsp; &nbsp; </span><span style="color: #9cdcfe;">inst</span><span style="color: #cccccc;">;</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; u32 &nbsp; &nbsp; </span><span style="color: #9cdcfe;">seg</span><span style="color: #cccccc;">;</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; u32 &nbsp; &nbsp; </span><span style="color: #9cdcfe;">reg_offset</span><span style="color: #cccccc;">;</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;"
 >char</span><span style="color: #cccccc;"> &nbsp; &nbsp;</span><span style="color: #9cdcfe;">reg_name</span><span style="color: #cccccc;">[</span><span style="color: #b5cea8;">50</span><span style="color: #cccccc;">];</span></div><div><span style="color: #cccccc;">};</span></div></div>
    <p></p>
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #c586c0;">#define</span><span style="color: #569cd6;"> </span><span style="color: #569cd6;">SOC15_REG_ENTRY</span><span style="color: #569cd6;">_STR(</span><span style="color: #9cdcfe;">ip</span><span style="color: #569cd6;">, </span><span style="color: #9cdcfe;">inst</span><span style="color: #569cd6;">, </span><span style="color: #9cdcfe;">reg</span><span style="color: #569cd6;">) &nbsp;ip##_HWIP, inst, reg##_BASE_IDX, reg, #reg</span></div><div><div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #569cd6;">static</span><span style="color: #cccccc;"> </span><span style="color: #569cd6;">const</span><span style="color: #cccccc;"> </span><sp
 an style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_hwip_reg_entry</span><span style="color: #cccccc;"> </span><span style="color: #9cdcfe;">gc_reg_list_10_1</span><span style="color: #569cd6;">[]</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">=</span><span style="color: #cccccc;"> {</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; { </span><span style="color: #569cd6;">SOC15_REG_ENTRY_STR</span><span style="color: #cccccc;">(GC, </span><span style="color: #b5cea8;">0</span><span style="color: #cccccc;">, </span><span style="color: #569cd6;">mmGRBM_STATUS</span><span style="color: #cccccc;">) },</span></div><div><span style="color: #cccccc;">}
</span></div></div></div></div>
    <br>
    <br>
    <blockquote type="cite" cite="mid:526b2e61-006e-4bc7-abaf-afa3f6a0af81@amd.com">
      <br>
      And btw please name that amdgpu_hwip_reg_entry.
      <br>
    </blockquote>
    Noted<br>
    <blockquote type="cite" cite="mid:526b2e61-006e-4bc7-abaf-afa3f6a0af81@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp; It would
        <br>
        be nice to print the register name rather than the offset in the
        <br>
        devcoredump.
        <br>
        <br>
        E.g.,
        <br>
        <br>
        <br>
        <blockquote type="cite">+
          <br>
          &nbsp; static const struct soc15_reg_golden
          golden_settings_gc_10_1[] = {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4,
          0xffffffff, 0x00400014),
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL,
          0xfcff8fff, 0xf8000100),
          <br>
          @@ -4490,6 +4583,23 @@ static int
          gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int
          ring_id,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_prio, NULL);
          <br>
          &nbsp; }
          <br>
          <br>
          +static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device
          *adev)
          <br>
          +{
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct reg_pair *ptr;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr = kcalloc(reg_count, sizeof(struct reg_pair),
          GFP_KERNEL);
          <br>
        </blockquote>
        I think you only need to allocate enough memory to store the
        register
        <br>
        values.&nbsp; We already have the offsets in the array above.
        <br>
        { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS), &quot;mmGRBM_STATUS&quot; },
        <br>
        <br>
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ptr == NULL) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to allocate memory for IP
          Dump\n&quot;);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ip_dump = NULL;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.reg_count = 0;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ip_dump = ptr;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.reg_count = reg_count;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          +}
          <br>
          +
          <br>
          &nbsp; static int gfx_v10_0_sw_init(void *handle)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k, r, ring_id = 0;
          <br>
          @@ -4642,6 +4752,8 @@ static int gfx_v10_0_sw_init(void
          *handle)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_gpu_early_init(adev);
          <br>
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_alloc_dump_mem(adev);
          <br>
          +
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
          <br>
          &nbsp; }
          <br>
          <br>
          @@ -4694,6 +4806,8 @@ static int gfx_v10_0_sw_fini(void
          *handle)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_free_microcode(adev);
          <br>
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;gfx.ip_dump);
          <br>
          +
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
          <br>
          &nbsp; }
          <br>
          <br>
          @@ -9154,6 +9268,21 @@ static void
          gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
          <br>
          &nbsp; }
          <br>
          <br>
          +static void gfx_v10_ip_dump(void *handle)
          <br>
          +{
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct amdgpu_device
          *)handle;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gfx.ip_dump)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
          <br>
          +
          <br>
        </blockquote>
        Need turn disallow gfxoff before reading the gfx registers:
        <br>
        <br>
        amdgpu_gfx_off_ctrl(adev, false);
        <br>
        <br>
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; reg_count;
          i++) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ip_dump[i].offset =
          gc_reg_list_10_1[i].reg_offset;
          <br>
        </blockquote>
        No need to store the offset.&nbsp; We already have it in the static
        array above.
        <br>
        <br>
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          adev-&gt;gfx.ip_dump[i].value =
          RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
        </blockquote>
        And then allow it again:
        <br>
        <br>
        amdgpu_gfx_off_ctrl(adev, true);
        <br>
        <br>
        <blockquote type="cite">+}
          <br>
          +
          <br>
          &nbsp; static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name = &quot;gfx_v10_0&quot;,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init = gfx_v10_0_early_init,
          <br>
          @@ -9170,7 +9299,7 @@ static const struct amd_ip_funcs
          gfx_v10_0_ip_funcs = {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_clockgating_state =
          gfx_v10_0_set_clockgating_state,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_powergating_state =
          gfx_v10_0_set_powergating_state,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clockgating_state =
          gfx_v10_0_get_clockgating_state,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dump_ip_state = NULL,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dump_ip_state = gfx_v10_ip_dump,
          <br>
          &nbsp; };
          <br>
          <br>
          &nbsp; static const struct amdgpu_ring_funcs
          gfx_v10_0_ring_funcs_gfx = {
          <br>
          diff --git
          a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
          b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
          <br>
          index 4908044f7409..4c8e7fdb6976 100644
          <br>
          ---
          a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
          <br>
          +++
          b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
          <br>
          @@ -4830,6 +4830,8 @@
          <br>
          &nbsp; #define
mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0
          <br>
          &nbsp; #define
mmGB_EDC_MODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x1e1e
          <br>
          &nbsp; #define
mmGB_EDC_MODE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0
          <br>
          +#define
mmCP_DEBUG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x1e1f
          <br>
          +#define
mmCP_DEBUG_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0
          <br>
          &nbsp; #define
mmCP_FETCHER_SOURCE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x1e22
          <br>
          &nbsp; #define
mmCP_FETCHER_SOURCE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0
          <br>
          &nbsp; #define
mmCP_PQ_WPTR_POLL_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x1e23
          <br>
          @@ -7778,6 +7780,8 @@
          <br>
          &nbsp; #define
mmCP_MES_DOORBELL_CONTROL5_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          &nbsp; #define
mmCP_MES_DOORBELL_CONTROL6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x2841
          <br>
          &nbsp; #define
mmCP_MES_DOORBELL_CONTROL6_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          +#define
mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x2842
          <br>
          +#define
mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          &nbsp; #define
mmCP_MES_GP0_LO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x2843
          <br>
          &nbsp; #define
mmCP_MES_GP0_LO_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          &nbsp; #define
mmCP_MES_GP0_HI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x2844
          <br>
          @@ -9332,10 +9336,16 @@
          <br>
          &nbsp; #define
mmRLC_LB_CNTR_INIT_1_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          &nbsp; #define
mmRLC_LB_CNTR_1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4c1c
          <br>
          &nbsp; #define
mmRLC_LB_CNTR_1_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          +#define
mmRLC_GPM_DEBUG_INST_ADDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4c1d
          <br>
          +#define
mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          &nbsp; #define
mmRLC_JUMP_TABLE_RESTORE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4c1e
          <br>
          &nbsp; #define
mmRLC_JUMP_TABLE_RESTORE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          &nbsp; #define
mmRLC_PG_DELAY_2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4c1f
          <br>
          &nbsp; #define
mmRLC_PG_DELAY_2_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          +#define
mmRLC_GPM_DEBUG_INST_A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4c22
          <br>
          +#define
mmRLC_GPM_DEBUG_INST_A_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          +#define
mmRLC_GPM_DEBUG_INST_B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4c23
          <br>
          +#define
mmRLC_GPM_DEBUG_INST_B_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          &nbsp; #define
mmRLC_GPU_CLOCK_COUNT_LSB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4c24
          <br>
          &nbsp; #define
mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          &nbsp; #define
mmRLC_GPU_CLOCK_COUNT_MSB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4c25
          <br>
          @@ -9720,6 +9730,8 @@
          <br>
          &nbsp; #define
mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          &nbsp; #define
mmRLC_LB_CNTR_2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4de7
          <br>
          &nbsp; #define
mmRLC_LB_CNTR_2_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          +#define
mmRLC_LX6_CORE_PDEBUG_INST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4deb
          <br>
          +#define
mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          &nbsp; #define
mmRLC_CPAXI_DOORBELL_MON_CTRL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4df1
          <br>
          &nbsp; #define
mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          1
          <br>
          &nbsp; #define
mmRLC_CPAXI_DOORBELL_MON_STAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          0x4df2
          <br>
          --
          <br>
          2.34.1
          <br>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------Irbr4BEc0iVvTVbqe7P36wyY--

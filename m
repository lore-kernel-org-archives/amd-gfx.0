Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8082FC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 17:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE05410F224;
	Tue, 16 Apr 2024 17:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2HR+/0hG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04CF710F222
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 17:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu2RevZ5HA8qw6mMBbiqFI2/i7uzEF/6iQKXoTocJlbfh13pS1tHE5nbCoATkm0+3LNNnCsXAoimg9hV36oRs2SIQQ3a0WpoLQPq16VFktKSbOp95eVPY3840I5avspxV2rAiAre90mYpxsVzWD/m6GbidmyTl3wNLHlwazW88420IeBA8AmaG8I3qCzrThnEvFo2FK8baGGsCiYSSMrpX41qoIupJoHaezWD3bQId2UwnTPfwMKIGBcgO95LL7hRE0jgAIUfNzSfzDqFdTojUIKVXsfx4uiK21AeXWf8l92J3yrH7BE5HeLBiBNbQeHad1Mbx9D1P7YjSgMJv2mCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vDlMVYeTop9ljjVcPSdkZLD7ILEUoCn8Y9R8WCpIYI=;
 b=T+60kzxafVEG8OQW/IjRjBl1QEGge6tisEvda3CLRbELo9sTCPu4YRD8UbpIqn3fM4dgOSyw0Xe4lipcPU16SlLS4UCjSn9q4mmQiLG2ceT5BhJMIdC4dL5QwBsdBCDHc2pp1aO0pfdoHoD6w/NX9gR5iqremxXd0b19c9ijxArWcPn7gac7f9kLl30YwMYDeplpr95NHS8+B+RMJ0H9kP3AEvmuA+DVhRyokMRdEFiZ4K8ZkNa9F6sGsbLxqpSFMg8YS+22DM0Ddv9kyMmCDnQyacaVZAPwX/qV+PyguumEniHi2upcPmO37CLwmOGb8k/6e4763MELBS5f2uKY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vDlMVYeTop9ljjVcPSdkZLD7ILEUoCn8Y9R8WCpIYI=;
 b=2HR+/0hGkborZ7EMZfdTLUsVANXY3Z+e8oSbelKGqeBYyuauFacHBCWn+14JW9tFWvP+obeadvj1K3Y/78jQo7yTSUG2OJiL50VqQPJfR9JU84wVqhfsJfd/9+nMPCvPYRMVE3h6oOGM4HxQBQ+fZ2vuv4/HXTUUPhfnuOFrX0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 17:08:47 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 17:08:46 +0000
Content-Type: multipart/alternative;
 boundary="------------UH7MJu0sivrOxaNx470AV0Qy"
Message-ID: <44b83416-dab4-42c4-90a5-4831be8c464d@amd.com>
Date: Tue, 16 Apr 2024 22:38:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/amdgpu: add support of gfx10 register dump
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240416120804.607272-1-sunil.khatri@amd.com>
 <20240416120804.607272-3-sunil.khatri@amd.com>
 <CADnq5_M3_4pjstwxsfiLAmDXLUHMVVeTHyOm-2gKTzaXZ7QFKQ@mail.gmail.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_M3_4pjstwxsfiLAmDXLUHMVVeTHyOm-2gKTzaXZ7QFKQ@mail.gmail.com>
X-ClientProxiedBy: PN0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::7) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: d76bc970-ce46-4c29-2a01-08dc5e37e0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGyfP8t0+YbfhqY7TwTBm41R4TMvRCjJMwwlzoUg5JmO1JRfPT1O16nZU9VS70o4Xy4toOcbDEmmQve99G/wx8lLyKRzunpivgM1dyVMgC0mhjxLszoKQqqI1PpmAnjfEWNU3C4/VkD7gqSG3ilZ1/HhorZh6OVN4T6/giMZ/VG6jz29/YC5xNZBsgDQNr0r6w+Darl4sOLaHQVQzKS4B5pNSYvUkLCZGUjbv1icnDdO/0HCDiLgvE/gmJnlPREveLYHW+YOiZQGl+KUGv4ckx+xgzN7xcT1unnV+ZC8/gFO4ndm51nuYTk3FiOb2QVS9Tsox6Wv1RjcXvXmnjN2eNl/upP8x/F27Xel8p2ERUiJxz/pqmaiYX+26aKfJYuiOfoXem5kErFdXhcnfnPvd5Y8wa5XOzH/tvbHWCRf2KdAjcelaB9JapG6qi9AIYtV+iTgjC4jHeydAL/zrAJbo2WwlVS//nsx3pvVElLH1egLzuKlpbnC7dVjDvoOQlb0BdIphKqQNNac5ZoEVJPcXm73PSpy1jTUSkYycA4VkMaKIWQoVW74gRg2uSaies06sWPGsNWh2wmM4m4BuCcGob0RyBOT51pqdoc2ACKzlUti4/4/O2MlHYmjPt68SBrJ4pqef5SeP5OgsakWpytxXFwbCm2cCuyzNW9enQltjwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L04yNVFYYmVtbG8ySU1FakMyVSs0UWI2azRqd1V0NWhDUm4rVFRXU0dNWmor?=
 =?utf-8?B?NExyelo0Yy90a292cExRdHVMeXl5WW01Unp4aWw3ZGtlNFpFVFdlSzg2aUVS?=
 =?utf-8?B?YnJESEZTRUVsWElTdUNaSnRwN010SXZvaktLZFFkNk1jUmVwa0tWaTJ6RkJX?=
 =?utf-8?B?ODVJY0JtNWpwZVBRRzZjWUNKYU5EZGlkOUdRL0Q5Zm1KNXd4M1hpQW9TOVN4?=
 =?utf-8?B?SlJrck41NStzTnhkK1lJZlVYZ3d0eFRBblBma3M0S0plaGhjMEgwYTV0UXBx?=
 =?utf-8?B?S3lIZlJoMWFndDhLOEhVdTZXQy9saVVhVWVFdlVEV2RtZnlJRmpYZHRXVHZI?=
 =?utf-8?B?Q2dUQVhJY0g0a3Roek9zVTJUN1Y0d3BlUXJ4WUhnY1VNYlFKbjlPVGtJSTVr?=
 =?utf-8?B?cm5udVIwbWd0b2V5bGpOL3FhTk54ZFBSeERCSENqc1FEcVNYazM1dXBTdGgz?=
 =?utf-8?B?WlhUNmEvcDBJMW5GNnFFZ1VtdThRdmxOb05DVTRvc2RaL042blpIY2o2Wm5S?=
 =?utf-8?B?dWdiWS82SDRyWmtKQ0QvZnVvS2krLzEwQ2VjczE4RDZ5Q3JTRDRKT2RIbFgr?=
 =?utf-8?B?SVNwZHAwT1hudVFmanBSZ3lpR3ZRS2lzNW1JNTZGbktKYTJuTnV1b0JuQUgr?=
 =?utf-8?B?UXlJbDBLcjJoY2F6bTVMU3RRRFJGUzlVVTd6ay90NlVoRFVIMU04RU1RMjNH?=
 =?utf-8?B?SjYrTk03S3VtN1p5Ulh4UDB1UnhwVkJWc3YyTktjTXdnMithZGFwUkx5MWFF?=
 =?utf-8?B?Rm1NNWl0VGNLV1BRWWpsVTNKTWdNVjdoRWxoWWVLRWNRN0dMYWFCN2pleld3?=
 =?utf-8?B?TnNzbHpKTFZDYmNaSERhQWdFNXVYZEdWMzR1WXl3ZitZTWppM2p3RE5NaDZs?=
 =?utf-8?B?VjFwTU1NTXROSmdPU3FETUw3YUNpUEZoK2FXRjhDZDZyT2tNN1loaUhVdjBZ?=
 =?utf-8?B?K2NGcDJuVko1Z1BLSWIyMnhTS2ZwRWo2SmNLSEZLNGtxYVJWWXdQdElnT3lN?=
 =?utf-8?B?WDFqY0ZQKzlJOWk2K0p4ekRUMUZKUFZpZTcxOVRNYlpKSHVpVCtzZUdiWVJR?=
 =?utf-8?B?TjhheGRwT1kzOHZ6WWlKWmhGdmp6ckxVZWZPVzVRMW5RYmRnblBvNUwxdi90?=
 =?utf-8?B?WGtWd0pPbDAzMjZjSFZvZkRLc3BsZjFJTnRkQUlaTUthT2c2d2lBa2V1U0ZJ?=
 =?utf-8?B?K1V5R2toL1p0aHZra3pZL3RDL0hYKzA4WGxOek9GWGp0RVJHM0REVDBXd3lK?=
 =?utf-8?B?MjM0dDRYeXB1bHNYYU1kTEJ0NUgwM1RmcTdkeUhVai9mS2NxWjFPOVo0SEQx?=
 =?utf-8?B?L1pMR1Z4OUx5QXZRcGEyY0tYN3FrVUlUZUFTQXhZZWlISjlzVmpJU0c1V3Zp?=
 =?utf-8?B?QnhjOXYrMWNNYkFZcDlLTyt0ZVk5SFhwQm8zQjc2elRCWFhORXJoaytJUjYz?=
 =?utf-8?B?TWRkT0x6V1ZhMU1ScDd4VzJSLzRPcHhhdjZCajV0dXNRb25Nd0FVOXRiRFpk?=
 =?utf-8?B?ZEdaYUhmeW5WYTQvakFscGJ6ODdzdGtMMm05eExZbFkwUWFVM3hTVVhJcE1u?=
 =?utf-8?B?S0xNM0lycksrS1dUazhBWmtEOUNVaHg0a3QvaWxzNXV4WTdObDVmZUJpcFhy?=
 =?utf-8?B?WHZlTHdNMm54NW1sNXBkaG1RN0lLWXp0ZDNZK0ROQnprRVdZZDB1dzhHUUtm?=
 =?utf-8?B?eitzbG1vYjlNdlVkUlRkU1FtSzJ1VzRCSUF5R0VUL0N6VWl4RXhLWUFVNWVl?=
 =?utf-8?B?SUllU3hmQkp5QnN5RDdYYjZiaENCYk1TOUhBYk1qaWErb0c3aUp6RTF4TTlW?=
 =?utf-8?B?OHB5a2lHa3hXMmNxS29vRXcyRm1yN3VyVTIrTG5wQzZZdXJhS1JvZXpvUW9o?=
 =?utf-8?B?dlpvZzVCNjd3KzRjL0w5M2xoOUxFTlJycTJGbVQrRWdKR1pzUmtCU2RjK2Ex?=
 =?utf-8?B?UVlSZUdWSUh5bEpsZ2ZiQU5uWmd1ZURnVFcrNkVqaDg0OXZhY3ZsdzVnaFBj?=
 =?utf-8?B?ZXJtUEJqVzlUMFU1Wm5WbFloYk4vTnBYdEhzbElPNEdyNXlqMTMzK25FU1hZ?=
 =?utf-8?B?VGdGTlVxMXR5RTBYalk1WCtzVENWMHA2ekd1RmdFaEpSeGwxRS9TLzE1QXlC?=
 =?utf-8?Q?RavtLclcHU2Jr+S/ZwVBdCjHo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76bc970-ce46-4c29-2a01-08dc5e37e0a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 17:08:46.8508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4RhakhU+Mkdnsf6tnlsOoxtfB0vxtczKXpbSm39o429Dp75iG/J2bT/0JLhIoTwOag5a69P7pMKbDPylJ+k5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965
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

--------------UH7MJu0sivrOxaNx470AV0Qy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/16/2024 7:25 PM, Alex Deucher wrote:
> On Tue, Apr 16, 2024 at 8:08 AM Sunil Khatri<sunil.khatri@amd.com>  wrote:
>> Adding gfx10 gc registers to be used for register
>> dump via devcoredump during a gpu reset.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
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
> Might want to add the string name for the register as well.  It would
> be nice to print the register name rather than the offset in the
> devcoredump.
Sure let me update that in next version.
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
Noted
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
Noted.
>> +       for (i = 0; i < reg_count; i++) {
>> +               adev->gfx.ip_dump[i].offset = gc_reg_list_10_1[i].reg_offset;
> No need to store the offset.  We already have it in the static array above.
Noted
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
--------------UH7MJu0sivrOxaNx470AV0Qy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/16/2024 7:25 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_M3_4pjstwxsfiLAmDXLUHMVVeTHyOm-2gKTzaXZ7QFKQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Apr 16, 2024 at 8:08 AM Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Adding gfx10 gc registers to be used for register
dump via devcoredump during a gpu reset.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  12 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 131 +++++++++++++++++-
 .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
 4 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e0d7f4ee7e16..e016ac33629d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -139,6 +139,18 @@ enum amdgpu_ss {
        AMDGPU_SS_DRV_UNLOAD
 };

+struct hwip_reg_entry {
+       u32     hwip;
+       u32     inst;
+       u32     seg;
+       u32     reg_offset;
+};
+
+struct reg_pair {
+       u32     offset;
+       u32     value;
+};
+
 struct amdgpu_watchdog_timer {
        bool timeout_fatal_disable;
        uint32_t period; /* maxCycles = (1 &lt;&lt; period), the number of cycles before a timeout */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 04a86dff71e6..295a2c8d2e48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -433,6 +433,10 @@ struct amdgpu_gfx {
        uint32_t                        num_xcc_per_xcp;
        struct mutex                    partition_mutex;
        bool                            mcbp; /* mid command buffer preemption */
+
+       /* IP reg dump */
+       struct reg_pair                 *ip_dump;
+       uint32_t                        reg_count;
 };

 struct amdgpu_gfx_ras_reg_entry {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a0bc4196ff8b..46e136609ff1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -276,6 +276,99 @@ MODULE_FIRMWARE(&quot;amdgpu/gc_10_3_7_mec.bin&quot;);
 MODULE_FIRMWARE(&quot;amdgpu/gc_10_3_7_mec2.bin&quot;);
 MODULE_FIRMWARE(&quot;amdgpu/gc_10_3_7_rlc.bin&quot;);

+static const struct hwip_reg_entry gc_reg_list_10_1[] = {
+       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2) },
+       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS3) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT1) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT2) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STALLED_STAT1) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_BUSY_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT2) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT2) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_ERROR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_HPD_STATUS0) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_RPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_RPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_RPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCPF_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCPC_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCPG_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmGDS_PROTECTION_FAULT) },
+       { SOC15_REG_ENTRY(GC, 0, mmGDS_VM_PROTECTION_FAULT) },
+       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS_2) },
+       { SOC15_REG_ENTRY(GC, 0, mmPA_CL_CNTL_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRMI_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmSQC_DCACHE_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmSQC_ICACHE_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmSQG_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmTCP_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmWD_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL) },
+       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_DEBUG) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC_CNTL) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_CNTL) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC1_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC2_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_ME_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_PFP_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_COMMAND) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_MESSAGE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_1) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_2) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_3) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_4) },
+       { SOC15_REG_ENTRY(GC, 0, mmSMU_RLC_RESPONSE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SAFE_MODE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_SAFE_MODE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_GPM_STAT_2) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SPP_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_INT_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_GENERAL_6) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_A) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_B) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) }
+};
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Might want to add the string name for the register as well.  It would
be nice to print the register name rather than the offset in the
devcoredump.
</pre>
    </blockquote>
    Sure let me update that in next version.<br>
    <blockquote type="cite" cite="mid:CADnq5_M3_4pjstwxsfiLAmDXLUHMVVeTHyOm-2gKTzaXZ7QFKQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
E.g.,


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
 static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
        SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
        SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
@@ -4490,6 +4583,23 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
                             hw_prio, NULL);
 }

+static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
+{
+       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
+       struct reg_pair *ptr;
+
+       ptr = kcalloc(reg_count, sizeof(struct reg_pair), GFP_KERNEL);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think you only need to allocate enough memory to store the register
values.  We already have the offsets in the array above.
{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS), &quot;mmGRBM_STATUS&quot; },</pre>
    </blockquote>
    Noted<br>
    <blockquote type="cite" cite="mid:CADnq5_M3_4pjstwxsfiLAmDXLUHMVVeTHyOm-2gKTzaXZ7QFKQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+       if (ptr == NULL) {
+               DRM_ERROR(&quot;Failed to allocate memory for IP Dump\n&quot;);
+               adev-&gt;gfx.ip_dump = NULL;
+               adev-&gt;gfx.reg_count = 0;
+       }
+       else {
+               adev-&gt;gfx.ip_dump = ptr;
+               adev-&gt;gfx.reg_count = reg_count;
+       }
+}
+
 static int gfx_v10_0_sw_init(void *handle)
 {
        int i, j, k, r, ring_id = 0;
@@ -4642,6 +4752,8 @@ static int gfx_v10_0_sw_init(void *handle)

        gfx_v10_0_gpu_early_init(adev);

+       gfx_v10_0_alloc_dump_mem(adev);
+
        return 0;
 }

@@ -4694,6 +4806,8 @@ static int gfx_v10_0_sw_fini(void *handle)

        gfx_v10_0_free_microcode(adev);

+       kfree(adev-&gt;gfx.ip_dump);
+
        return 0;
 }

@@ -9154,6 +9268,21 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
        amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }

+static void gfx_v10_ip_dump(void *handle)
+{
+       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+       uint32_t i;
+       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
+
+       if (!adev-&gt;gfx.ip_dump)
+               return;
+
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Need turn disallow gfxoff before reading the gfx registers:

amdgpu_gfx_off_ctrl(adev, false);</pre>
    </blockquote>
    Noted.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:CADnq5_M3_4pjstwxsfiLAmDXLUHMVVeTHyOm-2gKTzaXZ7QFKQ@mail.gmail.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+       for (i = 0; i &lt; reg_count; i++) {
+               adev-&gt;gfx.ip_dump[i].offset = gc_reg_list_10_1[i].reg_offset;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
No need to store the offset.  We already have it in the static array above.</pre>
    </blockquote>
    Noted<br>
    <blockquote type="cite" cite="mid:CADnq5_M3_4pjstwxsfiLAmDXLUHMVVeTHyOm-2gKTzaXZ7QFKQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+               adev-&gt;gfx.ip_dump[i].value = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
+       }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
And then allow it again:

amdgpu_gfx_off_ctrl(adev, true);

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+}
+
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
        .name = &quot;gfx_v10_0&quot;,
        .early_init = gfx_v10_0_early_init,
@@ -9170,7 +9299,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
        .set_clockgating_state = gfx_v10_0_set_clockgating_state,
        .set_powergating_state = gfx_v10_0_set_powergating_state,
        .get_clockgating_state = gfx_v10_0_get_clockgating_state,
-       .dump_ip_state = NULL,
+       .dump_ip_state = gfx_v10_ip_dump,
 };

 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index 4908044f7409..4c8e7fdb6976 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -4830,6 +4830,8 @@
 #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                                                        0
 #define mmGB_EDC_MODE                                                                                  0x1e1e
 #define mmGB_EDC_MODE_BASE_IDX                                                                         0
+#define mmCP_DEBUG                                                                                     0x1e1f
+#define mmCP_DEBUG_BASE_IDX                                                                            0
 #define mmCP_FETCHER_SOURCE                                                                            0x1e22
 #define mmCP_FETCHER_SOURCE_BASE_IDX                                                                   0
 #define mmCP_PQ_WPTR_POLL_CNTL                                                                         0x1e23
@@ -7778,6 +7780,8 @@
 #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                                                            1
 #define mmCP_MES_DOORBELL_CONTROL6                                                                     0x2841
 #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                                                            1
+#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                            0x2842
+#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                   1
 #define mmCP_MES_GP0_LO                                                                                0x2843
 #define mmCP_MES_GP0_LO_BASE_IDX                                                                       1
 #define mmCP_MES_GP0_HI                                                                                0x2844
@@ -9332,10 +9336,16 @@
 #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                                                                  1
 #define mmRLC_LB_CNTR_1                                                                                0x4c1c
 #define mmRLC_LB_CNTR_1_BASE_IDX                                                                       1
+#define mmRLC_GPM_DEBUG_INST_ADDR                                                                      0x4c1d
+#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                                                             1
 #define mmRLC_JUMP_TABLE_RESTORE                                                                       0x4c1e
 #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                                                              1
 #define mmRLC_PG_DELAY_2                                                                               0x4c1f
 #define mmRLC_PG_DELAY_2_BASE_IDX                                                                      1
+#define mmRLC_GPM_DEBUG_INST_A                                                                         0x4c22
+#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                                                                1
+#define mmRLC_GPM_DEBUG_INST_B                                                                         0x4c23
+#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                                                                1
 #define mmRLC_GPU_CLOCK_COUNT_LSB                                                                      0x4c24
 #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                                                             1
 #define mmRLC_GPU_CLOCK_COUNT_MSB                                                                      0x4c25
@@ -9720,6 +9730,8 @@
 #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                                                           1
 #define mmRLC_LB_CNTR_2                                                                                0x4de7
 #define mmRLC_LB_CNTR_2_BASE_IDX                                                                       1
+#define mmRLC_LX6_CORE_PDEBUG_INST                                                                     0x4deb
+#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                                                            1
 #define mmRLC_CPAXI_DOORBELL_MON_CTRL                                                                  0x4df1
 #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                                                         1
 #define mmRLC_CPAXI_DOORBELL_MON_STAT                                                                  0x4df2
--
2.34.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------UH7MJu0sivrOxaNx470AV0Qy--

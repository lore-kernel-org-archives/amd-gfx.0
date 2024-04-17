Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBB6C04FF9
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 09:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2802C10F368;
	Wed, 17 Apr 2024 09:29:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="keRSNb87";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5FD010F28C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 09:28:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8J+d8ksOcuLDKu8frww5MI2WPkgrnbpUG8b/cfMGhNjolwI7gt9nkddX8k3Y04g9832qKuTWJHTVfsg0FrOZvuhRRDxCfKv8bREB5W0ORbdB9DzQcgeZ5Q0gl41VFx654ITWToRRBvQICfg7QMqX3e5Vd8/aOtm0krQtGxzUzqu9O65OfYTT5NdJyLfOhR4QZDf98D4fKzADICd2bR58RixRoOr14jA3TCVeCYMEWvYJGhH/2fch60aot/eSllHh7hpGy/rY7C6zkTQAv7f8YI4zxyJriHIocWuHUEThoI71hCJOZi2wjQnDSDAE3HNcvwEltXqgLjSh1FnCFPPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGHE2E+IRzdgiSE6AhiH2DABmBuDW2FS4KGTkk1/q/o=;
 b=ne3KQEairIYt2QDgTTnwy1CWEHTpTxiayklNacBc5zjZloaGSVXNo4xftVjyrqU/rh0sQfjcRtvmWhAP+EI5hT86AjpGc2s8Va/G5hjWvv91RxDywap4pR9ZfQSgCxbn6kIcIgR7JiLcvHivnJnvANEt7/EGZwF8fGJf6p6gbD1B1Ncrqi1duIBnwSk9IfX6PrANbt1rSzXzQH0MIw3DtJtRaIVUOeoafZiyM/fEYHnfEJBSj3m9y20FjYov78I9+J4BpaYGgI+mmJXQ3M06S9+6/aPVfGnD3OHGjc4uQiY+oam+bd/+hFFFgNq8wMLRrw+AWB0L2EtvM9KJqsC4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGHE2E+IRzdgiSE6AhiH2DABmBuDW2FS4KGTkk1/q/o=;
 b=keRSNb879oS2SPge4VQAgI5vUzpoMr2UhfASruzpDFbUtH2ZvS/DWwRJrsMh75ZmHC/Y3pZL4XxqU7npkrjrJ7yQ/0e6gdjp1x4i8UyPuYeBppD3x/ZI6m3J8VFLlrfY3nMgUAwZAm7RMeZPZpDb/gn52xL32/xNIOO2cTqIT2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 09:28:56 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:28:56 +0000
Message-ID: <4256da78-51ec-4a6a-8a05-b33abfd3c670@amd.com>
Date: Wed, 17 Apr 2024 14:58:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] drm/amdgpu: add support of gfx10 register dump
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240417081844.111259-1-sunil.khatri@amd.com>
 <20240417081844.111259-2-sunil.khatri@amd.com>
 <75237de6-635f-4a08-96e5-492882b2eb33@amd.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <75237de6-635f-4a08-96e5-492882b2eb33@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::23) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: afb5bb83-ad5b-4bcd-48e0-08dc5ec0cd96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rljnFkU1ot5YtDvw7tIWXFRutmD8kh2SwcGMKf0WvYUoUJ5c+zHrACcEQOSap22dhkFjzVedZX91OudCHryEkVtKqf+900xOVhDW40OlXbBpiSrolYAPrq7C8g9SUYMtfYScCSgIuer4xIMsWZdN+c8/W0PhXRdxZ7DxaqL4PHzbpf+5X4ZIug9Esw1S5XEf4mqucJiCY00e1fW6bS1xPa5kOpMg/xdDvoRIz7s/bTrUZM7p6W2hc2mCRY1LqtM/3IMKRQQQxkU6nVlo14Pw4ByYBUBsMwPgfF8cxbQUS3uiZBLkD+q0thxbeH+XbLHpdrACk+7El6fdH1eqlBABtlQhieQ7Z5SW+8R4iXK3rTdSKltAs8gHqYt0ouhZueAoHSHgIAEZhgZG7pJg83NNg8GhyUKX6FVV4WqcEWoRy27Mlv0HtwO9sQfuCgWEp8z+IgzoEcmALcTSliukkBnSStQZfTPRCyBZlRM3uHYQtJDZfTLwUzUOCaw9XnZxnx9uKGFjMeOowfYXK2YbN5Rsg1qrc6Nwly8SWvC+ST9ragaSYHoLe8Y0M4IfU/5J0+03C7OTrZ7B805oDIQXrYiMB0PvxhumDLkFKnzD1+9Lv15ubrfXg2vpSjpiVTJRdxcEn1NHgWxkZ+rzyURN9+DjtdHw8HTjY0N1NOfoVPWli8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2kyQkZvSU1pcWp0RHQ3Zkt6K3hVc1p4MEVZdzVlOGVOOWphaWtBeDdFRExE?=
 =?utf-8?B?c29GSm4yZnJIY2dGYVVBcDlWSzY1NTJDSkhSUTJiUGdMYXJMWll0NjZLSHFv?=
 =?utf-8?B?TkZWWlM5MWRGZlFEOFIrZ2VPbS8zaVlyMS9NUXcybVZla3BzVzNoc2lJc1BE?=
 =?utf-8?B?WUJMWVErVmxreDIrQTZZS2VEMW5ocHhRZlhvOTk1dUIyZXZoZDN4dE5aaURo?=
 =?utf-8?B?YnhvSVpySkJ2bzdwcDRHZzhrY1lhUk05VXJsMDIrRmxsWWl2bzhPdWpWQmtH?=
 =?utf-8?B?R3hINjd4M1g2dFMydzZSakRyUkZsR2wwWjBRNkp4cFU5ZEZRd050R1ZPUmVC?=
 =?utf-8?B?a3d1eklxc01xSDJNNkU3cTVOcHJzS1JTOXd4alRmMGEvUzVBVmFFMjdhUTJi?=
 =?utf-8?B?RmJmY0FnNVcwUTFNSUlteldLb3RiMmJBVWdaeHFlUFBoRHlkT2VnNGVBVmRt?=
 =?utf-8?B?M3FOaWdiOGN4TCtKZzBxd3J6TkJCcmNkZkh0dFJuZkx5TjhVckFCTHN5aGlS?=
 =?utf-8?B?bkd5T3llWCs0S0hEWkdla1lqSlFybXlzWW41eTFLc0JLRVBzK1J6Qi9hR1dU?=
 =?utf-8?B?czhrMk1YSWdDNHhXVjhQRCt4b296am9HMDBPOXp2clhhUXB0SzZ1RDBrRUZT?=
 =?utf-8?B?aHJiOXVDa0lGOVFKcVEwblJNeWlqNThVL1NoU2ZPMVIxT2JITXdVRytYNmRB?=
 =?utf-8?B?b0JMRVExRGdDK0dLdFU5M3NBMTN2WHl3ZGl0ZUdwbWtSNm9pamtCSG1OWk55?=
 =?utf-8?B?eGNLemgrSTV3NmtmR1M4dkFJWlJleEliYk85SUQvM3p6YzM1N1VkSE5Uc3pm?=
 =?utf-8?B?cWJVV2RhZzVxSWF2TjRaWmhMOXkwVkRDYVRHMXpQUkVlNlRZOGMwZmV4dHp3?=
 =?utf-8?B?dWZ1akpRMmFHK0RsVUlncU8vV0w2TzZXakFLcG8zSEtXQ2F0R1pUVGwyS0sv?=
 =?utf-8?B?OHFROEZyeUFLZktrVms4SDVyelM1Q0tNcWZQUWZCVlJiOCtKRzF1M2NVSytD?=
 =?utf-8?B?SGc2UkhMQUNYTS9UdzVxWjcraG5iakwvYklyR3gyQnA1cGRVeUN1ZVFITFY3?=
 =?utf-8?B?MVY0c2d4ZkxpbzRwRlJPZTFZMDgzUFZRVTFMRXlKTXQ3WkZEYmR4WnlHSnls?=
 =?utf-8?B?NDRuanFuTVBPMmFGbGJHNmxpYXVsbkhLaVpkYyt0Nnkzc1NHQ1JoNkxlU3NW?=
 =?utf-8?B?b3UvUHFkaFBGcUZBYU5VZkZ3bUN3QThPL2RNRnYxaC9rcTZBUTZqMlpRQ1U1?=
 =?utf-8?B?WnRaaW5QWmlpYXJQaGFFTldUaXlHN3YyLzFGZnRkcnlkeEtFZjI1a2RBY1pa?=
 =?utf-8?B?UHZaNi9VNEhsKzRrOWtxMlVBbjZnTTlDd2FaaVV0ZVRzb3g1ZkRrOWFETDk1?=
 =?utf-8?B?SGpFNFZ4cDV6RlU1Vldqd3RMVTNmZzdrSE8ramo2alJZWmx6dHo3TDRXclpx?=
 =?utf-8?B?bkJDV1FEcEcraWJZSENhd2tydFNMUDlIQWxlSkFzY2VEQmhaRWxEV1NWbGo1?=
 =?utf-8?B?MnQreEZWdFZQcFFkQ3A4VXAvYlpjNXRXZ1RRZHZTOGZQUnhOTldNdG14bWlo?=
 =?utf-8?B?QnQyMGpzN2EvYVZnMzZheU1OTy9ZUTUzRjJWellFZjZ4R2hENTlOQTZxM0FP?=
 =?utf-8?B?TGJSWDNIRWNmTk1ySDBPd3g4WE5IL3NZY3dyU1FQZEhSeDRFOXo3STFNTUlV?=
 =?utf-8?B?NWpTNWczK3VjRzFPM3c1Z3Rhb2VydGUyS3V1eU02SWhseE1hWmVKdTVhakxm?=
 =?utf-8?B?ckFmcDFKVUpZNnhtSU50WDM4VUFRSFJ6b2JhYVBDTG01NTErY1ZCZWcxa2FZ?=
 =?utf-8?B?TWE5ZENhOUx6NTV4ZGRycnlTd3JlRFlqVkJQVEtpVUFQMWwzdWFCSi9uWnpH?=
 =?utf-8?B?T21SbUV3TEFCb2FHUmhxQ211eGNmVDRDUnRTdnZxcFJ6ejRmaS9WeE01ZUxY?=
 =?utf-8?B?YzlCUEhieUpxQ1JlbU1UVWJ2NktPdFk4ZGU2UmFVbFl3MGwxN0Fac2MrYThV?=
 =?utf-8?B?S0phVWdWbktaN3B6c2ZYemlZZG1ZN0NqOVVUVW1uNXFqR013UGQ0TEJFbTVX?=
 =?utf-8?B?VU9qckVtYzU4OUsvdkxaK25JZXQ2VUtMYWdCZ3I4dWZtU2tNZHI3VVhUVWc0?=
 =?utf-8?Q?80e0S7oVBTWD8i/TK2b+R+Vfg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb5bb83-ad5b-4bcd-48e0-08dc5ec0cd96
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 09:28:55.9363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOjgkofoFcfpRqREEWOOFibob9l0A5ektwH7iac+pVDaJvc39iW6dGriG2Qs9kAnU2Zb7H5cZ0ssA8Tm6igAJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200
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


On 4/17/2024 2:15 PM, Christian König wrote:
>
>
> Am 17.04.24 um 10:18 schrieb Sunil Khatri:
>> Adding gfx10 gc registers to be used for register
>> dump via devcoredump during a gpu reset.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 130 +++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/soc15.h            |   2 +
>>   .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
>>   5 files changed, 155 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index e0d7f4ee7e16..210af65a744c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -139,6 +139,14 @@ enum amdgpu_ss {
>>       AMDGPU_SS_DRV_UNLOAD
>>   };
>>   +struct amdgpu_hwip_reg_entry {
>> +    u32    hwip;
>> +    u32    inst;
>> +    u32    seg;
>> +    u32    reg_offset;
>
>> +    char    reg_name[50];
>
> Make that a const char *. Otherwise it bloats up the final binary 
> because the compiler has to add zeros at the end.
Noted.
>
>> +};
>> +
>>   struct amdgpu_watchdog_timer {
>>       bool timeout_fatal_disable;
>>       uint32_t period; /* maxCycles = (1 << period), the number of 
>> cycles before a timeout */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index 04a86dff71e6..64f197bbc866 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -433,6 +433,10 @@ struct amdgpu_gfx {
>>       uint32_t            num_xcc_per_xcp;
>>       struct mutex            partition_mutex;
>>       bool                mcbp; /* mid command buffer preemption */
>> +
>> +    /* IP reg dump */
>> +    uint32_t            *ip_dump;
>> +    uint32_t            reg_count;
>>   };
>>     struct amdgpu_gfx_ras_reg_entry {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index a0bc4196ff8b..4a54161f4837 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
>>   +static const struct amdgpu_hwip_reg_entry gc_reg_list_10_1[] = {
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS2),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS3),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT1),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT2),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STALLED_STAT1),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STALLED_STAT1),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_BUSY_STAT),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT2),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT2),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_ERROR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HPD_STATUS0),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_BASE),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_RPTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_BASE),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_RPTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_WPTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_BASE),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_RPTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_WPTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_BASE),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_CMD_BUFSZ),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_CMD_BUFSZ),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_CMD_BUFSZ),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_CMD_BUFSZ),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_LO),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_HI),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BUFSZ),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_LO),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_HI),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BUFSZ),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_LO),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_HI),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BUFSZ),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_LO),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_HI),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BUFSZ),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCPF_UTCL1_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCPC_UTCL1_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCPG_UTCL1_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmGDS_PROTECTION_FAULT),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmGDS_VM_PROTECTION_FAULT),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS_2),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmPA_CL_CNTL_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_UTCL1_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRMI_UTCL1_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmSQC_DCACHE_UTCL0_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmSQC_ICACHE_UTCL0_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmSQG_UTCL0_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmTCP_UTCL0_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmWD_UTCL1_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_DEBUG),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_CNTL),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_CNTL),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_INSTR_PNTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC1_INSTR_PNTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC2_INSTR_PNTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_INSTR_PNTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_INSTR_PNTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_INSTR_PNTR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_STAT),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_COMMAND),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_MESSAGE),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_1),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_2),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_3),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_4),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmSMU_RLC_RESPONSE),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SAFE_MODE),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_GPM_STAT_2),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SPP_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_A),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_B),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR),
>> +    SOC15_REG_ENTRY_STR(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST)
>> +};
>> +
>>   static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 
>> 0x00400014),
>>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 
>> 0xf8000100),
>> @@ -4490,6 +4583,22 @@ static int gfx_v10_0_compute_ring_init(struct 
>> amdgpu_device *adev, int ring_id,
>>                    hw_prio, NULL);
>>   }
>>   +static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
>> +{
>> +    uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>> +    uint32_t *ptr;
>> +
>> +    ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
>> +    if (ptr == NULL) {
>> +        DRM_ERROR("Failed to allocate memory for IP Dump\n");
>> +        adev->gfx.ip_dump = NULL;
>> +        adev->gfx.reg_count = 0;
>> +    } else {
>> +        adev->gfx.ip_dump = ptr;
>> +        adev->gfx.reg_count = reg_count;
>> +    }
>> +}
>> +
>>   static int gfx_v10_0_sw_init(void *handle)
>>   {
>>       int i, j, k, r, ring_id = 0;
>> @@ -4642,6 +4751,8 @@ static int gfx_v10_0_sw_init(void *handle)
>>         gfx_v10_0_gpu_early_init(adev);
>>   +    gfx_v10_0_alloc_dump_mem(adev);
>> +
>>       return 0;
>>   }
>>   @@ -4694,6 +4805,8 @@ static int gfx_v10_0_sw_fini(void *handle)
>>         gfx_v10_0_free_microcode(adev);
>>   +    kfree(adev->gfx.ip_dump);
>> +
>>       return 0;
>>   }
>>   @@ -9154,6 +9267,21 @@ static void gfx_v10_0_emit_mem_sync(struct 
>> amdgpu_ring *ring)
>>       amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>   }
>>   +static void gfx_v10_ip_dump(void *handle)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    uint32_t i;
>> +    uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>> +
>> +    if (!adev->gfx.ip_dump)
>> +        return;
>> +
>> +    amdgpu_gfx_off_ctrl(adev, false);
>> +    for (i = 0; i < reg_count; i++)
>> +        adev->gfx.ip_dump[i] = 
>> RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
>> +    amdgpu_gfx_off_ctrl(adev, true);
>> +}
>> +
>>   static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>       .name = "gfx_v10_0",
>>       .early_init = gfx_v10_0_early_init,
>> @@ -9170,7 +9298,7 @@ static const struct amd_ip_funcs 
>> gfx_v10_0_ip_funcs = {
>>       .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>>       .set_powergating_state = gfx_v10_0_set_powergating_state,
>>       .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>> -    .dump_ip_state = NULL,
>> +    .dump_ip_state = gfx_v10_ip_dump,
>>   };
>>     static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h 
>> b/drivers/gpu/drm/amd/amdgpu/soc15.h
>> index 1444b7765e4b..282584a48be0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
>> @@ -88,6 +88,8 @@ struct soc15_ras_field_entry {
>>   };
>>     #define SOC15_REG_ENTRY(ip, inst, reg)    ip##_HWIP, inst, 
>> reg##_BASE_IDX, reg
>> +#define SOC15_REG_ENTRY_STR(ip, inst, reg) \
>> +    { ip##_HWIP, inst, reg##_BASE_IDX, reg, #reg }
>
> Mhm, do you still get the warning that we should use ()?
>
> In general named initializers would be better. E.g. something like this
>
> {
>     .hwip = (ip##_HWIP),
>     .inst = (inst),
> ...
> }
>
> But you need to give the parameters unique names for that. "inst" for 
> example won't work like this.
> The issue is fixed now. Checkpatch is also reporting 0 error and 
> warning now.


I will push making the changes in v5

Regards
Sunil Khatri

> Apart from this looks good to me,
> Christian.
>
>>     #define SOC15_REG_ENTRY_OFFSET(entry) 
>> (adev->reg_offset[entry.hwip][entry.inst][entry.seg] + entry.reg_offset)
>>   diff --git 
>> a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h 
>> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> index 4908044f7409..4c8e7fdb6976 100644
>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> @@ -4830,6 +4830,8 @@
>>   #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX 0
>>   #define mmGB_EDC_MODE 0x1e1e
>>   #define mmGB_EDC_MODE_BASE_IDX 0
>> +#define mmCP_DEBUG 0x1e1f
>> +#define mmCP_DEBUG_BASE_IDX 0
>>   #define mmCP_FETCHER_SOURCE 0x1e22
>>   #define mmCP_FETCHER_SOURCE_BASE_IDX 0
>>   #define mmCP_PQ_WPTR_POLL_CNTL 0x1e23
>> @@ -7778,6 +7780,8 @@
>>   #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX 1
>>   #define mmCP_MES_DOORBELL_CONTROL6 0x2841
>>   #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX 1
>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR 0x2842
>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX 1
>>   #define mmCP_MES_GP0_LO 0x2843
>>   #define mmCP_MES_GP0_LO_BASE_IDX 1
>>   #define mmCP_MES_GP0_HI 0x2844
>> @@ -9332,10 +9336,16 @@
>>   #define mmRLC_LB_CNTR_INIT_1_BASE_IDX 1
>>   #define mmRLC_LB_CNTR_1 0x4c1c
>>   #define mmRLC_LB_CNTR_1_BASE_IDX 1
>> +#define mmRLC_GPM_DEBUG_INST_ADDR 0x4c1d
>> +#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX 1
>>   #define mmRLC_JUMP_TABLE_RESTORE 0x4c1e
>>   #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX 1
>>   #define mmRLC_PG_DELAY_2 0x4c1f
>>   #define mmRLC_PG_DELAY_2_BASE_IDX 1
>> +#define mmRLC_GPM_DEBUG_INST_A 0x4c22
>> +#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX 1
>> +#define mmRLC_GPM_DEBUG_INST_B 0x4c23
>> +#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX 1
>>   #define mmRLC_GPU_CLOCK_COUNT_LSB 0x4c24
>>   #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX 1
>>   #define mmRLC_GPU_CLOCK_COUNT_MSB 0x4c25
>> @@ -9720,6 +9730,8 @@
>>   #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX 1
>>   #define mmRLC_LB_CNTR_2 0x4de7
>>   #define mmRLC_LB_CNTR_2_BASE_IDX 1
>> +#define mmRLC_LX6_CORE_PDEBUG_INST 0x4deb
>> +#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX 1
>>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL 0x4df1
>>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX 1
>>   #define mmRLC_CPAXI_DOORBELL_MON_STAT 0x4df2
>

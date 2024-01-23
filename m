Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DE2C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 02:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C3A10E066;
	Tue, 23 Jan 2024 02:17:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9901010E066
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 02:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzXTQZTvq9jo3Irw6qIwUpBAWWN41RI9cQNsyM2Rre4VNP2+APHdrUs+bhu33lXt6TAbdGDXK5MTste5hSsZbjp7Or8bZY50rSNrDSqstlCvDtVJZaucFHflauvaph7+qW+fewCpQa3u+mjxemjf0UxBY5j1hhA5pe3dujNeOcKrxGpY7B1xc30LNcrXk3KAH+GElRD/xNcJtxAI958MWZBEAVnhycyYAjNuQmvGLUQ7g2OsiR0HCgA/rFXJye0d0JUPe0kDJJdiswKpGxSG0Cpi8gAx81Ai4Bdw9Wjmx580R9uAiZNMPhLL0n8ii0Rhkg6YWCYEjzO2op+QjmGVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKQ7QQHSnwhfrmgBeAs99jGYdWyR6f486y1lI+39egc=;
 b=G++T7KYTQPBDt1YXT10ZnkvQSjFEUkKz6UfoWMsV7ogg3xJm9C6BRBC5uYez/B/kGs4zAu5OmgBVkBfKzl6T3LxKs96CAngzP8rZmNYLmuVkPL1dxALHhUXXWHsbj4M0c8NnwFxGm4BRemFrokz+c6PSxZZ7qxq/7pZDl4ijtaGtSe1stDhgsWQnQynSB+YW8tQMRIusJR55ZexdUgK4QTcOLhY3k3zAqbk1g+BitevCH2r3zHOBp7JVbpMSQNn469/E4wtY31FXXXZlWQUSfRscQw8+AcMtFLFsOC++9pZNfR2Z+VGqkk/BoUM36besOoZuHg/mDr8PEyj+tFYy4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKQ7QQHSnwhfrmgBeAs99jGYdWyR6f486y1lI+39egc=;
 b=RAX2fsA8LjMl5q84T/mOBdRXseDr1sPgjbEnPHfr78UAsBv/MUHDKJNb60NprUBvArahJ3pUWbnRKV0AnM9gwykV8zBq8Ccx2T4BHwP3V4UWRIlx5JSy6NGZdS+DFp/Stb3R5fV/XSOEEH2658WP20pINFwudw/brG9B9tUoaJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Tue, 23 Jan
 2024 02:17:13 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 02:17:12 +0000
Message-ID: <a8237115-b88b-4a54-9acc-f012390d81f5@amd.com>
Date: Tue, 23 Jan 2024 10:17:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/pm: Use macro definitions in the smu IH
 process function
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240122084240.1053190-1-Jun.Ma2@amd.com>
 <20240122084240.1053190-2-Jun.Ma2@amd.com>
 <bd6cb136-4e4d-433e-bb26-ed5b5cc80c22@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <bd6cb136-4e4d-433e-bb26-ed5b5cc80c22@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e7dca0-0a0a-453c-d1f3-08dc1bb968f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4AZqn5orNyKDmZrCYK5k2zmvusn6aFDl0CLVE32P32MxIaCgxDB5APjqKWDAwKVDAdIduUwpWdy8sYzx3ifTiGLD+T2Z+76hgvjQlcMlTgNwocvf+l5GPC7vJzvgJBOi/BaMemV2aS6nalPLhk5YIni0FC0KXND5vAsgh2GffxZUZxlJb1RHrFEQBAJxj4U24BQDT/Tr5aW5n4I2j8hgOlgTJnWwvv5XgEclmz0CqZpPkQeHLX9+SI6i7WcIAyI2CYRo1xcbWBWGWFGHSoGP3AuRHr3aQ/O07ZHSjCBS9ykjvBx4RINmijVD8822oOlYcxZZSzA5iaOErmHKGn7RcMZDb89e7ycY6nnRxQEDyowIDvl54HFZ0clx0hCxpWSMLPQKpe3si1H+44nbxr4ghWesLuZofVgkv3TplPzrtv0vR/xTydH9qYxyRBuufefusnGlrQH3UQkMZ3iN42c2KkiSf0av4XaSEkd+uzOt6yle1gameJtFlfsceOVSxMduoGqi2tXtI41qC8ZECmcz9/DNkDHaKDmulA1Cc1hv379CuBSSffFzV9iPJwHBIM94M7+EiIFMVlaHYgsL4MqYsIKKnD+wKcd4xjbAnqReiur/Ib7FAaGSabKMpV8dCAvkxoxIC/gemXfgl7PBWSnSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(478600001)(6666004)(6486002)(41300700001)(26005)(38100700002)(83380400001)(36756003)(31696002)(2616005)(53546011)(6506007)(6512007)(5660300002)(8936002)(8676002)(4326008)(31686004)(2906002)(66946007)(316002)(110136005)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXhveW9KZ1k2SFRva1A3dkJzYk1QVURYWS9ZL093aC9kVEd6RnpuZi9ERmpq?=
 =?utf-8?B?YnNrazVBdGNOcGZCckIvVUJGSmNxWUQ5dnVVVS9DVlZpNEQ4dFlCd24vSzhH?=
 =?utf-8?B?VTd1VDRtdVN5SnJ0YmN0MGVRNFpndzVySzdRREZPWElha3lqdXpTV3JFRnN0?=
 =?utf-8?B?bU5GaXMyQW5ldXQ4WUlJRkRQYWo1bGJIUXlCcXlYREhzamtoRTN5a3JqMkdp?=
 =?utf-8?B?bWxZOTlORnhwd3Bzc2hlbE5RVGFvalh4bTZQalFERHdoOWtZMUNqdXE1WEhw?=
 =?utf-8?B?dUtrdjhRQ29WZ0I5QkhONlo3eTdkMEVIVnBaeGhmTGl6ZkxXUmhFclBwdEdX?=
 =?utf-8?B?UlArRllpSllHczN3VUluY2g2UXhsUUpJL0VtMXpadmZVN0dGd0JxRWJOMWRR?=
 =?utf-8?B?dUE4b3B1Mmh5ZytnRGVGeERSVkhGeTE3SGRzb2tWVnZMNE9iZ0dlWVNDTEZR?=
 =?utf-8?B?MFBGMmFyOHQram9Iak56bUM2TXMxeGljYitJeEg0OW1DRXpHR3RVVTVQWHVW?=
 =?utf-8?B?cnZ6RjdSUDRmQkpPMmN3anJOZ2N3VzZJRjRHQ1g2YnF6cHk3SHVkcUZyOXhj?=
 =?utf-8?B?TmprN2VaNm1zZWYyU0RMMU81cUtnTnJUTFY4M2VwV2JzdTNUeUw1b2Z1SElC?=
 =?utf-8?B?SDM3NFJEVGpheGdwY1I3MXR2T2NTaTJOOTRRajhyVHEyZVBPNjduL1M1RHJC?=
 =?utf-8?B?aWEvRm9qb1RuYldEUzVoc2R1c3FBOUoyN3NRSEZROW16VFI3RTVIdTlBVUdh?=
 =?utf-8?B?M1JHRXlwR0w5bmxzaCs1YTJWN3lycWVRRU15aVNlZVBPbFZhVy9rV3dLUEZw?=
 =?utf-8?B?L3FiRkRHR2gxK09SSi9pOXR0SHlQWXUwSm9nVE0xcnBCeGs0TWlvMUtDM3g1?=
 =?utf-8?B?azhyeFQ1VTBYTFh0VjFiL3g0SlNqRll5U2k0SnhOOUxSSjZGQkhkTnQrbHZL?=
 =?utf-8?B?MlBzdXlzUHdFOVEycUVxQjdYWTkxU1lVZXB2MjZIUWJRVkhHSGlRR0phc2Qz?=
 =?utf-8?B?QkRicmExeFlLTmVUY09LY1dOYU5HcjJpR1BsY0NsQ3FEN3Rtc0ErbjhjYVNl?=
 =?utf-8?B?WkJwSWZQVUtrNGJDcXplNGExOENuZGYwckpkRnpBZzhXSXlCdENiRXlmbFBG?=
 =?utf-8?B?WDFxK3lXdGU0K2tWM1JQYWYyc1pqN1VZMXZLeFBFbUk1WmlRRWtTMm8vOXBz?=
 =?utf-8?B?Q01SWVNZM0xqd1dGMTFOZEZ5eHJBMmJ0czRsZVpxNHd4SjExYy9wckhVV29D?=
 =?utf-8?B?QlJDODJ2N1plUUZjRUI3emt2ays4ckxHWjFPNGZ6cFJuV0ZVcDZUWTdCcW1y?=
 =?utf-8?B?citoL1J4aDJqTlMzTW5hb0kwQ2tmdm5ZU0F0dFhoTGU4MXB4ZXIxTGo3Kysz?=
 =?utf-8?B?Tm1hS3pRZUEzMFlOa2dvamRFU0gyTWxsK0Y2OG02blRUZmplczFzaUk2N0t5?=
 =?utf-8?B?R1Irai9Ja2JyNW81LzUyamdwVDJIQ1Z6VlpTTHUvV3orTUVZUnhRV1V4Y2ox?=
 =?utf-8?B?N3BxNkMxUHhVUXZ1YUlvcU5EVmc0SEVicHNjbVpVcytPNzB1NFpvOEprcWVu?=
 =?utf-8?B?UGlGSHBQMHNvWnNLdlZySVZLWmhBVFlhR1dFbm1vVURjYm95cTdxdUpWMmdM?=
 =?utf-8?B?VDc1WTFkQVpTZTNGU0Q3bU9GWmhtWjNBMVRDam9HbFl3STk1blY4ck5qNXlQ?=
 =?utf-8?B?S3VSTUpvckFCTXRBb1RlWXRtWkpQVkVQdnJueWMvaXVkbVkvWWxFbU5VTGZN?=
 =?utf-8?B?K2VLS2RXNEdrM0ZrMjVxSVREd0R4amNqczdOQzJRTVVlQzFwaWIyLzhmWnVB?=
 =?utf-8?B?WUdWQ3VacHBtWDJSak9GTkdNRkpENWkvZ3QrdmJmdzZldEJzREFKL0pjRExv?=
 =?utf-8?B?QlpsMWYyUktmVFRMTFFuNCtOVkhrWVVkOGg4WExPaVppZ3hpaGw5TngyWTVK?=
 =?utf-8?B?bDBjemwyQ0hSNlNXNlEvcjl0N2d5KzdmMUM0YVBWRkwvYXVJMzFPSUdTSDMy?=
 =?utf-8?B?cDJYeTNTbW5GR3hWQkpMWHNqN3VSVFR6aVIrbEIyMHJTSS8weCtLbExqdVRk?=
 =?utf-8?B?NHpOdWtLYmoyL3FVN1pXcUZkbmtCZk85dFA0K3QwWjFxZmpaRGRqc3FCVWUw?=
 =?utf-8?Q?fpqxSMIEReTLpmVajLzm5VExJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e7dca0-0a0a-453c-d1f3-08dc1bb968f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 02:17:12.7011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+CSSyHIGKP4IZH1plnWekiGjfEQqfA8p8UpgPdJ1jYtEAGEDoLfAKMVc+eiwoPA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/22/2024 8:44 PM, Lazar, Lijo wrote:
> 
> 
> On 1/22/2024 2:12 PM, Ma Jun wrote:
>> Replace the hard-coded numbers with macro definition
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h | 11 +----------
>>  .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h | 11 -----------
>>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h       |  5 +++++
>>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       | 10 ++++++++++
>>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h       |  2 ++
>>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 10 +++++-----
>>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 14 +++++++-------
>>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  2 +-
>>  8 files changed, 31 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
>> index b114d14fc053..c6b7f904e742 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
>> @@ -1618,15 +1618,6 @@ typedef struct {
>>  #define TABLE_WIFIBAND                12
>>  #define TABLE_COUNT                   13
>>  
>> -//IH Interupt ID
>> -#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
>> -#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
>> -#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
>> -#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
>> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
>> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
>> -#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
>> -#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
>> -#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
>> +
>>  
>>  #endif
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
>> index 8b1496f8ce58..33937c1d984f 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
>> @@ -1608,15 +1608,4 @@ typedef struct {
>>  #define TABLE_WIFIBAND                12
>>  #define TABLE_COUNT                   13
>>  
>> -//IH Interupt ID
>> -#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
>> -#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
>> -#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
>> -#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
>> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
>> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
>> -#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
>> -#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
>> -#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
>> -
>>  #endif
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
>> index a0e5ad0381d6..9fe26497e75e 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
>> @@ -63,6 +63,11 @@
>>  #define LINK_WIDTH_MAX			6
>>  #define LINK_SPEED_MAX			3
>>  
>> +#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
>> +#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
>> +#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
>> +#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
>> +
>>  static const __maybe_unused uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
>>  
>>  static const
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
>> index 46b972f36666..436705a18e99 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
>> @@ -59,6 +59,16 @@ extern const int pmfw_decoded_link_width[7];
>>  #define DECODE_GEN_SPEED(gen_speed_idx)		(pmfw_decoded_link_speed[gen_speed_idx])
>>  #define DECODE_LANE_WIDTH(lane_width_idx)	(pmfw_decoded_link_width[lane_width_idx])
>>  
>> +#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
>> +#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
>> +#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
>> +#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
>> +#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
>> +#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
>> +#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
>> +#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
>> +#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
>> +
> 
> Since the context_ids are unique across SOCs, these may be kept in
> smu_cmn.h.
> 
Thanks, will fix this in v2.

Regards,
Ma Jun
> Thanks,
> Lijo
> 
>>  struct smu_13_0_max_sustainable_clocks {
>>  	uint32_t display_clock;
>>  	uint32_t phy_clock;
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
>> index 3f7463c1c1a9..c92ad3f533c5 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
>> @@ -44,6 +44,8 @@
>>  #define MAX_DPM_LEVELS 16
>>  #define MAX_PCIE_CONF 3
>>  
>> +#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
>> +
>>  struct smu_14_0_max_sustainable_clocks {
>>  	uint32_t display_clock;
>>  	uint32_t phy_clock;
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> index d74343adaa5f..232e9b1ea006 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> @@ -1432,24 +1432,24 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>>  		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>>  		orderly_poweroff(true);
>>  	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
>> -		if (src_id == 0xfe) {
>> +		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
>>  			/* ACK SMUToHost interrupt */
>>  			data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
>>  			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
>>  			WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data);
>>  
>>  			switch (ctxid) {
>> -			case 0x3:
>> +			case IH_INTERRUPT_CONTEXT_ID_AC:
>>  				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>  				schedule_work(&smu->interrupt_work);
>>  				adev->pm.ac_power = true;
>>  				break;
>> -			case 0x4:
>> +			case IH_INTERRUPT_CONTEXT_ID_DC:
>>  				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>  				schedule_work(&smu->interrupt_work);
>>  				adev->pm.ac_power = false;
>>  				break;
>> -			case 0x7:
>> +			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
>>  				/*
>>  				 * Increment the throttle interrupt counter
>>  				 */
>> @@ -1508,7 +1508,7 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
>>  		return ret;
>>  
>>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
>> -				0xfe,
>> +				IH_INTERRUPT_ID_TO_DRIVER,
>>  				irq_src);
>>  	if (ret)
>>  		return ret;
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> index fc7c04e19b18..c8fc7eccab06 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> @@ -1368,24 +1368,24 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>>  		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>>  		orderly_poweroff(true);
>>  	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
>> -		if (src_id == 0xfe) {
>> +		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
>>  			/* ACK SMUToHost interrupt */
>>  			data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
>>  			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
>>  			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
>>  
>>  			switch (ctxid) {
>> -			case 0x3:
>> +			case IH_INTERRUPT_CONTEXT_ID_AC:
>>  				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>  				smu_v13_0_ack_ac_dc_interrupt(smu);
>>  				adev->pm.ac_power = true;
>>  				break;
>> -			case 0x4:
>> +			case IH_INTERRUPT_CONTEXT_ID_DC:
>>  				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>  				smu_v13_0_ack_ac_dc_interrupt(smu);
>>  				adev->pm.ac_power = false;
>>  				break;
>> -			case 0x7:
>> +			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
>>  				/*
>>  				 * Increment the throttle interrupt counter
>>  				 */
>> @@ -1398,7 +1398,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>>  					schedule_work(&smu->throttling_logging_work);
>>  
>>  				break;
>> -			case 0x8:
>> +			case IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
>>  				high = smu->thermal_range.software_shutdown_temp +
>>  					smu->thermal_range.software_shutdown_temp_offset;
>>  				high = min_t(typeof(high),
>> @@ -1415,7 +1415,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>>  				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
>>  				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
>>  				break;
>> -			case 0x9:
>> +			case IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
>>  				high = min_t(typeof(high),
>>  					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
>>  					     smu->thermal_range.software_shutdown_temp);
>> @@ -1476,7 +1476,7 @@ int smu_v13_0_register_irq_handler(struct smu_context *smu)
>>  		return ret;
>>  
>>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
>> -				0xfe,
>> +				IH_INTERRUPT_ID_TO_DRIVER,
>>  				irq_src);
>>  	if (ret)
>>  		return ret;
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> index 4894f7ee737b..9a8b7fd6995d 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> @@ -892,7 +892,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu)
>>  	// TODO: THM related
>>  
>>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
>> -				0xfe,
>> +				IH_INTERRUPT_ID_TO_DRIVER,
>>  				irq_src);
>>  	if (ret)
>>  		return ret;

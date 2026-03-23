Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2DCD58CC5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 03:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E2F10E35E;
	Mon, 23 Mar 2026 03:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v/kDcdx8";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6C610E35E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 03:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIkLdOlum+pbszkbesh54ji3XdjbI2uWAHXWqDU75qbGGpE6Kh6kT+9JUHWartYgW+rsC2xJtPKRcvaDpHpWeMaGsG2+9qyzg/KUeqUC4YeeMvddOKXt+NnG94wGcaFXqh9polPoFeO806HPJCbnfN+myQ/aXTDdmmlNZsU6W0BlKEHRmN9qieWxJGOAl0eDst0bkCShtiADZK31xd6PneSsoniyJoRcvKFh/cUyeH3ASljpJZp9xGOnpe1qtmahdZwT3WiAMNC/HG3fv9TU42FyiF3IUiHkzkt71JSZjp5kDMkD3Zd0Y79l64AbpJlni48eU3hvE7lU/XPTxlT3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Xm1tSBE9F2mBs0ri3LvaHsMPQycCSoXqT6OkiWoDL8=;
 b=hvaaYSGcLE2k1SxkaTPkJlHNzYwMoc6xUcCj0CYMkTdcPYnJHlHwjbRZnU13ps060isVBsdP/rrgDTz1Vhu//UY5f8rtYET0QxlKSimxllmNLffXjzlwbGCMCHdgnll5koLG1nUMlgT9jV1qTNt8QrKKHOnTDNAxISpVOomL/jAhihtfvM6Sr3ezRiyGj5ygX5NOJbn2aaL4WIDIVk5EXy/se6a3JG30AWACxKeW1UtqipJgfSauDCrhiB/hkHyjKRO/lgX6hXs+TaFVSukOymCNqIwTvWPW8ur3HErjiO9MrJK9g9w/h3TJPPl5deaEJCsJqfHfbDz1yxfok/B/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Xm1tSBE9F2mBs0ri3LvaHsMPQycCSoXqT6OkiWoDL8=;
 b=v/kDcdx80luFVjtewYh/lvfUPCkaH/MoKYNsukQmIZ2JeF3pWhVcIlrwQFQpbCBXQuvOS3ac5FXlbyjTFxgjnpFnb/gh1Wzk7rgGK9odaaxd5HcyUim/QPHNiWEPR5UutuQxiFnHL1AlzMpa64AZK9FXtz/outDNXFbRHPG8M7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 03:54:57 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 03:54:57 +0000
Message-ID: <d77c2f47-9e32-4b51-9fd7-c48d0af369e9@amd.com>
Date: Mon, 23 Mar 2026 09:24:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: add dedicated dram addr msg for smu v15
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com,
 asad.kamal@amd.com
References: <20260323015732.564251-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260323015732.564251-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 681a28fd-bff4-4367-9075-08de888ff2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 57d3mtMLSsiKx1mWbDivLHulbtGuBc6vQhJnLNLYFoOfZuPM5Sq5BpZhwpA6a9M8zjSB3jmbHrtC2kpQUfnKSmigSitmr/yFcMT3ZJJqI6Bqnm/adiYqX2fI8U05gfgyIeBh1nIy0QWftXmd0WttH0yI/vBjoRnqVPXkm+ZcEBbhdTCq4lxFe3EolfuSdDGec8uXawbMkkqAmF3VoHLWi7YSOhu5Rz/x0sUAMRZCxm92l3XIK9FWuEuL5Wzz181oD1E7vaaNOuZ/Jr73JdyABULRMw6/JoWeZwv3yjEgsfbhmTSnP21fnJRwpH7vP841jPSwsJR7fZq01RvUL0sKWSji0bzCn6PNfByos9ghPDH+ZBnTjDLqB+9yET4agKG9SdTTjHQKkz4BeRgL0WBvygifNiyUDFypUopXo1bkejiufa5ngEUescKuiZIfWTenXcDiI0Rp94yaQ9HcmA8OaJfQ4dHcQGRn9k42yedcR0qMZnxVG9rW21AkjEFTWpy3VtWQa/df9DLtBKlSJ4BW20JCoiZORYQDQyJtLoR4/TtwvgB6jPgvd0tnpfA1Qwen8NqQP9l2t7SdkNwf3JZm+5Js7DGHSojs/vq3AfnmWzGsCG65P9JwseinGvoZMV9K2SjAqQB5QUPE7XytlBUxMPAheJ0IhPDS/GJMJ27S5DtKKjajq+WMuAruvWQauMnCCzBVKNfyjSbumwoGYRMuy5Q8t9l4cDrLU/Vc3gzixsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R05wcGMxa05WM09OdmZ4Wk54MGxveUJtTExPRnBlQXVHQ25OOU96NFNNSnBI?=
 =?utf-8?B?V3BFVmRmSlg5M2V3UmduaEZoVzlXdGY0L3J2Wks3dmgxTVhGRW1iUExnK0d0?=
 =?utf-8?B?bUhzMGFKR2tJWnh4dURmQ2NYbG1rQUtZb1k5SDJYUk8wV2laSzYzMCs3dmdH?=
 =?utf-8?B?UnEvL2lmVm5KbDdLRXc4T01tTk1GanI1TXlxZWJodUYzQUc3VGxBby9HaS84?=
 =?utf-8?B?OSs2MFJIenVCR3ZuRTBVeHhBZTJlU1ZpNi9xU1RoN05Ld0pGUVQ1bXAwWDly?=
 =?utf-8?B?UkRSdjRBS0VteVNsVUM4WE9jYUZIMlJOSW9vRE9MSmxNZGZsak91ellXSDdC?=
 =?utf-8?B?L1NvajZvZ3lzOFVrZGF0VnlMQkhWVlhpSjVmKzlJSFpabTRVT0JGNnpXdWRL?=
 =?utf-8?B?K3Z1WmFiNnZCcWpWdEtTMmdvc0VMc3hrWGQ5RmVicmNURTl1cTFWUmRFcko5?=
 =?utf-8?B?VmZkQ3JXRFQ4eDZWaUQySEdMV1kvbzQyb0NwWWVnQ005Yi9IdG56TTlSaVU3?=
 =?utf-8?B?aGhNdElkSWZmWVZkMklmYVZEU0F4U0JwU2UrZEJPYS9XYnlQdUlzMjc5eFJh?=
 =?utf-8?B?WnJiQmNyNE85Tkx3cFMyWjR2eXBiYWFGNHJWT2NMaHVzQU9FYUxLSE5zNjB4?=
 =?utf-8?B?alNGQmNjQTlTWkRXam5YTVJIZHBPTFZBd3FjcklDczNLbmEvRkNsbU5HUWhw?=
 =?utf-8?B?enEwQnV5UGdLWFF1YUkrYlRJNnZ3MzJnUHVMQi9xK0x1SXRvdjRsUTZUbkJl?=
 =?utf-8?B?OFZKZmpNanVkcGQ3SHQzd1NWRFgyb3FYN0VrSDY5QmxQSlV5KzFGMHFGY2tD?=
 =?utf-8?B?SHVaU1VjQ3VUbUZmMzJTNGN0QlBybVRtY1IzaEZTT1RZdDhybXhlK1IyZC9N?=
 =?utf-8?B?WXBoblNJOW1IOE5xajZZYjZpRlJhQnAwYlQ1RDd6ODBmbFdzdWV4L3VZR01t?=
 =?utf-8?B?UWtUL3c2bk5zREQrRmtvQlVjVVRpNyt4Z2M3czJaNWNTQ2xRdTdYMCtkUDlD?=
 =?utf-8?B?a1lUQThMT2ZqVHBPRWdYdlR6c0hWejc3SHcxNDNGOUpqdlNNL3EvYWhBWVpY?=
 =?utf-8?B?RThMc0hXb3FKcmhyNFJ4d2JOdUJ6dGk2Vi93blFkMHpTWmhCd0JtU1JrMklt?=
 =?utf-8?B?a2U0K25BdEtHaWpFb2ZkazF6WUVJTHFkWTlNekdrZXh3WTA4Q3BQQld6TUNt?=
 =?utf-8?B?MjhDdXJBeE9JYzh1bzlTNzlWaVk5ZzFFSnNQeHpyM2M0ZDRQZkFmTnRyazFa?=
 =?utf-8?B?LytPeEZKUllwZkFEUDNYZElUQ2hqUWt4VkRJZERHN0swTFpoUUNCMnlvaEkw?=
 =?utf-8?B?UExqN0g2NCtUMmFudFJ4VTBMcnMrMlFLcjNWMWdITHBkQ2h0WFFXMWtMNzB0?=
 =?utf-8?B?SHJHSElXdU1CZjVFV0Rxajh0RGZGVWtDUzFyQ2QxeWQ4YkkxTXk5Y01Lb29t?=
 =?utf-8?B?TjhlU0dMcElqRXhRNDBqWFhWN05UdW1vY1JaL2IwRGtXOTZibjRkRFBJTDAx?=
 =?utf-8?B?eUxTNmUzdkNEdkplSmZoVnEzUmZBZnZoalpDRlI3eWUrUGhIaklZRCtxazZX?=
 =?utf-8?B?UXRoM3VHNmNDbWU2NlZhUDBNWFRaL015M2tIdWhrSzdBSmJXN3o2MUxpbUNT?=
 =?utf-8?B?WFB4NVR3ZWF2RVVSVEV4ZGxHSDE5dmtrVEQ0NDg3RThYV0tieURVTHczaExv?=
 =?utf-8?B?OE1GUGUvblNBOTJ5NE1kajI5VEVHVFlTM3Zjc1ZuL2hKNUkwQXZRUFRJVWxP?=
 =?utf-8?B?QUxDdVJQbnFYUDc3cXhnTWhXZ25TeUl2YVk4K3ZYNThDbUtpdkpJTkZ4MUIw?=
 =?utf-8?B?WlYyUGxTaU1LeWFlMnZzWGc2bGtRajZRQ2lsdFVkdmc4WWtFdjB1TEd1UGQ4?=
 =?utf-8?B?eXVSNW1rSlViTSswZWcrcitoVnh4MDFmTDkwcGtKNFhoYjUyRUZ2SkwrUjF2?=
 =?utf-8?B?eFNaMG02ajdlUXlWNXBNMU1yM1A3Q0g0YTVHb0dZdE52Ulo2SkQ3ZWxXNUY4?=
 =?utf-8?B?c28xUmQwVDduRWdXWHRmTlhQVHowS084ZmNKSzQzb21EUlFOTGlQdUxDZ1hh?=
 =?utf-8?B?QXpvMlRkTzUwM3RNVGVrbllRajBlOGVUKzg2S3dabEllUWlVVlhqTzYrUnBK?=
 =?utf-8?B?YnNiWjMxNXFKRHZjR3lLOCtLY3I0UVU3RklFVWo4Q0p4S0hFc0Yvb2RBS3pF?=
 =?utf-8?B?MW9OQzliMTFYV293T3FBaTM2S0xHdzBWMlo2Q1JkM0k5VUdOYW9vbTdTZzdr?=
 =?utf-8?B?Wkk4bGV6Sml5Tkc0RGNFSUtTcUF5MFB2Nkg5aVFac09BcGRRZm9DamNqT0VR?=
 =?utf-8?B?Y2dwTVBtT1NpUXk3QTF2QzRVTDVMWlp3dTQyZTJJb0RBZW9VQ1NPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681a28fd-bff4-4367-9075-08de888ff2b4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:54:57.0100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrPjDXfspF/EiEp+7/724Z1BgJ3zONIjgomgDiO3iliiNJSUdh/cKQ9ec8xpwoxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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



On 23-Mar-26 7:27 AM, Yang Wang wrote:
> Add dedicated SMU Dram MSG mapping to avoid conflicts
> in SMU IP v15 common code for upcoming ASICs.
> 
> add new smu msg:
> - SMU_MSG_SetDriverDramAddr
> - SMU_MSG_SetToolsDramAddr
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h         | 2 ++
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c       | 4 ++--
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 4 ++--
>   3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index fc31cc5e97c8..636ff90923d9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -42,8 +42,10 @@
>          __SMU_DUMMY_MAP(SetPptLimit),                  \
>          __SMU_DUMMY_MAP(SetDriverDramAddrHigh),        \
>          __SMU_DUMMY_MAP(SetDriverDramAddrLow),         \
> +       __SMU_DUMMY_MAP(SetDriverDramAddr),            \
>          __SMU_DUMMY_MAP(SetToolsDramAddrHigh),         \
>          __SMU_DUMMY_MAP(SetToolsDramAddrLow),          \
> +       __SMU_DUMMY_MAP(SetToolsDramAddr),             \
>          __SMU_DUMMY_MAP(TransferTableSmu2Dram),        \
>          __SMU_DUMMY_MAP(TransferTableDram2Smu),        \
>          __SMU_DUMMY_MAP(UseDefaultPPTable),            \
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index 966fa0238ad0..8e95a62e186c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -611,7 +611,7 @@ int smu_v15_0_set_driver_table_location(struct smu_context *smu)
>   {
>   	struct smu_table *driver_table = &smu->smu_table.driver_table;
>   	struct smu_msg_args args = {
> -		.msg = SMU_MSG_SetDriverDramAddrHigh,
> +		.msg = SMU_MSG_SetDriverDramAddr,
>   		.num_args = 2,
>   		.num_out_args = 0,
>   	};
> @@ -626,7 +626,7 @@ int smu_v15_0_set_tool_table_location(struct smu_context *smu)
>   {
>   	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
>   	struct smu_msg_args args = {
> -		.msg = SMU_MSG_SetToolsDramAddrHigh,
> +		.msg = SMU_MSG_SetToolsDramAddr,
>   		.num_args = 2,
>   		.num_out_args = 0,
>   	};
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index 5938e88726d2..89a44b456e8a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -87,8 +87,8 @@ static const struct cmn2asic_msg_mapping smu_v15_0_8_message_map[SMU_MSG_MAX_COU
>   	MSG_MAP(GetMetricsVersion,		     PPSMC_MSG_GetMetricsVersion,		1),
>   	MSG_MAP(GetMetricsTable,		     PPSMC_MSG_GetMetricsTable,			1),
>   	MSG_MAP(GetEnabledSmuFeatures,	     	     PPSMC_MSG_GetEnabledSmuFeatures,		1),
> -	MSG_MAP(SetDriverDramAddrHigh,		     PPSMC_MSG_SetDriverDramAddr,		1),
> -	MSG_MAP(SetToolsDramAddrHigh,		     PPSMC_MSG_SetToolsDramAddr,		0),
> +	MSG_MAP(SetDriverDramAddr,		     PPSMC_MSG_SetDriverDramAddr,		1),
> +	MSG_MAP(SetToolsDramAddr,		     PPSMC_MSG_SetToolsDramAddr,		0),
>   	MSG_MAP(SetSoftMaxByFreq,		     PPSMC_MSG_SetSoftMaxByFreq,		1),
>   	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
>   	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),


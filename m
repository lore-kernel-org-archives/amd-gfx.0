Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6449BCCD19F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 04:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCFF10E080;
	Tue, 21 Oct 2025 04:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Buuh5Lzk";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A6B810E080
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 04:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xix5DSc4GLZyijhV7zB45OnWf12wH5rTYxgOTrpmYQSRUQvAGrfAqhz2U9QmBVNAEB6PqvmbuLX6BucR3Pfygj3Tkz2jKS5NFX7nmMKZIed9/a5O8jsCnktjF2WzajZYQSHd9AVDky3y8ZbRgwh9d+klix00APmzaro5RQHIn+KU1TC4wf6akP2p+sqx697Ld2GvrCa+zYZ4VAkgtka9r3gsb2yuiMyu84P0zvApuHS5vHA0k2IxQVHJ8pgOmQM/ut5dkfPWhtFVt4tocnWfmzkC7N6/7V4p55fpikJZSbMTo9Swd9knbpuA7EhlUUcX10Hl4mAwyCRJGWLPHgUiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmY9mr+vQ6QwAGaBRJ846vICI+IwwAXk9LZilKBrshU=;
 b=rUHDLahTx5ymBOmDiPc3peXjZ9PKm8H2GMP1RYkvEcwGN1xlnjHJgOdesXM5jsgXUuWvpS5QHJYfYQDvUFxvVf/75U0lItRIpuEnS81hsC84RYk1qHrCqJkrgV7L9JHq0er2XhAHPIetl8wWHohatBWrk1veAujIA7iOpvyT5AYKQ/75/JFbgTlv558AOEud4YrOBViS3rGU+CVpGAz6/bq7lBwPxEVt4gNChsdFjSjPjpPL2YnUMP3K/3XEEZE9tflgFP23wRw4d07tVUQXe+YRvSsrHOA7UHZ1UzS1yMoDCVRuObRQ2J0dBKhIb5rcOT7WS6KrezkX7iszl1/yLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmY9mr+vQ6QwAGaBRJ846vICI+IwwAXk9LZilKBrshU=;
 b=Buuh5LzkIzIIa8s1PkWo+JkTggY0jOnkqd2XbSAskazEs8ooa6+h6LkAouyTgHrA9o9FpR7gj2fxiVfBIoLbYAY4Yy3/1fojupXcccwYuKg6ws543JjddP6W1Leu1wdDRdmo44yCcuM0a7+7mY+2xctR9rtV/HNtdwA0vqF3CuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Tue, 21 Oct 2025 04:46:44 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 04:46:44 +0000
Message-ID: <f25ae432-5196-45c8-aec9-36f0034032fe@amd.com>
Date: Tue, 21 Oct 2025 10:16:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: smu13: Enable VCN_RESET for pgm 7 with
 appropriate firmware version
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20251021020956.2384561-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251021020956.2384561-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 826696d5-1f80-455f-d216-08de105cd588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXVHVmRISDhiN3ZoWWtYVEpZNWhHWCsrdnU3NGZ6dUVPOGFsdEtQVmhIZlk3?=
 =?utf-8?B?c3E4RUNLcHFTU09VbEpoYWJDbzBNUzBFeklHQlNsLzBCbUIvV1gzdmRYdWdU?=
 =?utf-8?B?c3BEWG1TTHR0NGFUOUhwVFdXR3FFZEFjdDFmQlBJeTlqTDB4WDFnWWtzZngw?=
 =?utf-8?B?Ty9kZFhsd3V6VFZyZ3hBTmQ3d3Y4R2FGZTM1MGRWclQ5bTYrWVM4Z1Q2eEtN?=
 =?utf-8?B?N3kzbVdZOXZBK1hidTZFbDJzclgydzk2VlZLYTJidlcydWpET2hwc0o5dURN?=
 =?utf-8?B?VzhMa0NUL0lTMjZtbC8rVStyNXZpeUJIdmNYeUI5OTNwQzY2LzFLYVlGc3hw?=
 =?utf-8?B?RXg1ZEVMMExvVGZSNERIcHJVRHlRTXdHbTVYRmtJVk93dmJDMTVaYlRTQWRU?=
 =?utf-8?B?T3V5ZDJhYnRjeGd0Q3QyMmtFMStwYUQrUG9ZdDF4S0dOSlpnMk1aSGlEY2xn?=
 =?utf-8?B?SXJvTU1jM2xZakI1bEZ6M3FuTCtaUHZRTTg0NU1yYlptSTIyZVk2aVhDMzVE?=
 =?utf-8?B?cjFiU3lVc1BNbm1UY1lpNFlOeWx3Z2N0cG1GQUJ4K3hJcGJOTjN6NXp3N0lv?=
 =?utf-8?B?Q0k4aWFUZWd6Vmp3cGN4VGtTN0RuRHlVcUU4M043R2R5NGg5RGVsa1B0c0Yr?=
 =?utf-8?B?YjFZVjJIOHBiZ05yaXlQZkcvVlg4TTJReEcvVXBhRE9POVJyS1ZmbU5STHp1?=
 =?utf-8?B?MmZOSFZCRVBzYnlzaG1qeVlQb25jT3JEd2wxS0M5K1VTVjkxbnFMalZtZm9Z?=
 =?utf-8?B?NVdLSXRXVmFOV1VNcGZ5ZjlBTm94RDBsSEpINFNVdVhnQUsxNDJFY1c5eXBL?=
 =?utf-8?B?bVBnQlBhek9JOWREcndoQmhsTVZZWWpuZEJIZ3VPRTF4NVBNN2xLci9zNlpK?=
 =?utf-8?B?b2hRKzZPalIwdjhwZUdoczdZK0tLTFJRazBjYUlhbmdWbzlTQldFZ3Y5R3gr?=
 =?utf-8?B?RE1ia0ZqMytiRE1UWk11VW5BWjB3YVgvY1UxVEtCZnlOd3NnUlgrZTZhMmIr?=
 =?utf-8?B?WEN3My8rOEIwQ2luK0sxMWt6enhJUmFScnFuMzRQOW5DSEZEVXg0ajRDTlVo?=
 =?utf-8?B?c0EzV0NJMEJNSzB6T2czOFJCUHBUZ0ZpNktyV0NORVNCdjNsT3E5VVF1YjVq?=
 =?utf-8?B?NWNLSU9PL01uUmJhN1dRWmtVUjVGVVFrN0s5Yk9PUDR4aS9oaEMxRlZrbVpS?=
 =?utf-8?B?K0txSFgrUE40ZjhnN1ZIc09rZzRUM2l4NzFzU0tFdHd2R2tpL2ZCNnNTdEs2?=
 =?utf-8?B?ZDcwbkJwRWVzNEQ3cVdGTFpEamsrYWhLWkR6RE5SdjVGSjN6UWpxd3VyVWdD?=
 =?utf-8?B?YzAxblVUL201S09mWURxaHE0UnVHc2ZjSHZFVXFuS1lDSzNVZDJ3b010NjFV?=
 =?utf-8?B?dVYzZXlsR1Q5OSt3SkhycE4xRXFiN2xJcFhScVYrYXpjcWVDcjErWFVxK1Bx?=
 =?utf-8?B?ZWZuaFhFWjIzelRncGxNYU52ZC9qNElSa1ArQk5hc1JxR0cyTVl0dytHbVcv?=
 =?utf-8?B?cE9JWmJxUlZyYTlNZTJ0N3RNdEtYbHpFMHVaV0JNRFN4MVQ1b3VWcFhrRG13?=
 =?utf-8?B?S0VRTzZaUEhXM21NRzlLZzV4SGU0Z2ZCQzJrdHNIckZtZGVCWnd1U2VjRFI1?=
 =?utf-8?B?QmZwSWc3OE51ZTMwSDZDU0xqcm92U1gyZlJKZFRpNklSMWt5cTBwamRJcmha?=
 =?utf-8?B?N1FOM0kwOURLU014a0xrbDZkcVU1dmhOdXpZZXd1NGNwUzY4NXc3TGtTVnBI?=
 =?utf-8?B?M2VDSmpHWFB1MXJsYmY3ckpVWWdqWTdwZXlKUHFEeUl6SDZTd2dHVXBLeWZB?=
 =?utf-8?B?RVdPMUMrMjUvUjYwYnM4UHRuRFQ2VGNRei9iRUcyaHREdkpVcU1LZWtxckJq?=
 =?utf-8?B?aFJ0ZTh5UjZvNDJGakM0K0NZN1E1M3N2bmd6KzVhaWdpeGora3Vob0o1MVFO?=
 =?utf-8?Q?sS6WuHXJYb2WGYLxMx13XiY4j42iGEfc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG9rMmFSbU94WUJrQVVpN08wR1hoWXBmM0pDNlgycVM4VVpVQ0RZWURUUlll?=
 =?utf-8?B?di9QWnIzUlpFWEdCN3I5djR5dm9GL0w1czlESEYwMWk5b05BeWRMTkMvellU?=
 =?utf-8?B?WW02akFLY0lFblh3Uyt3NkJ4Uy8vbG5JVW5TcytFbURqWCtucG5wMXBJREpG?=
 =?utf-8?B?WkFGemk3ZXd5ZjhiS2s4VTFFbnVwcEcvdUp1bWlyTFlYVTJ0ZjdOb3Y2dFl1?=
 =?utf-8?B?VFFqckJGWWNIN0pzeEZkYnlGenE2c3RnYlNRWFVlTkkzeTU3OGRiWU9UN1dJ?=
 =?utf-8?B?ZVJxV0JMeUJLUWNWMmZvVXFmS1U4OFJlQmw2S0J4cmxBRTc2UUtpVHhRVWY1?=
 =?utf-8?B?cTQ4aWgyMVV5ZlZhMENxQnYzeHVySEd0cDBUeDg1M1lnNlpQL0owT1JPZ2ht?=
 =?utf-8?B?WE5VZExwNlB4VTRMUG1ub01sSXRhTVl0RVh4alpYNm50ZkYrSmtydCtOODc1?=
 =?utf-8?B?TjVRTUx2cGpiOW1aV3RRY2plNW0rbzBkRWVvQkpHVzlqakhBdi8wRGUyQUto?=
 =?utf-8?B?QmhPSnhLLzBrUVhYVUl3SjJsN044cG1lTnpjQVpWN2psNjVzcUh4a1Z3bHdR?=
 =?utf-8?B?RFUzalI0dGlFd2hhbXZsRzVjbFRxRjZPK1JqQjdNOXdsdzlHb0NKNDFXanB1?=
 =?utf-8?B?MnJpNzI1ZmZjNlRROXEzVWJjN3NEV2NxTER3U1ZDckVwcnhXL0xmUHYydEsx?=
 =?utf-8?B?dTRnMmI1a0xlaEZVdGFYQWozMUJUY2JKR1dSak1Sd0grVWhTdHFMMGh6M0ln?=
 =?utf-8?B?a0xsYytIWlRoUXhGeFR0b1JPMjBHaVV4dkowd3k2Zm5BVUE5YytyZzhnL1F1?=
 =?utf-8?B?TFR5MXI3SVBZaFpzUVNQN3A5UnpuaHhIZDcxb1V4VVdhOTZ4LzFod3dDZlly?=
 =?utf-8?B?T2xBZ3V4UHdJL3VsVy8wM29DbUlCK3Q3T3FxcGFlN2c5WmdQWFgrV0hKaklS?=
 =?utf-8?B?NDVjUHNxY096Q2xHU29tQ3pXVjBtVDZ5WTYyVUQybmJZd09CNlUwWDV3L3dW?=
 =?utf-8?B?Q0NkTXBSRG5xOVlpZTM2VE4rMmh3N3ZZa2pmcDIzWmplT2l2cnliUXY5d1hI?=
 =?utf-8?B?SmhNK083Y2loYUNKKzhncDJjQTd1cnc4cmZXcnNTT1RvZ2JJbXRhdDlaVjhB?=
 =?utf-8?B?OURPSTdIRlkySnRmczJXSTZKRDZzSG1VenBRZW9Cd29ld3V4UCtnYWgvVVRl?=
 =?utf-8?B?UURRNUJxdmduNy9haFJFeSs3QTFjMnVYOFU3dTV0b0hGL2N4N0tjR1oxTmEv?=
 =?utf-8?B?Y3Z5Q3I3bElpU1RKSXZEMFM5L0hlcjVhajJMLzlieXdOTWc0OWxYOVVnYitv?=
 =?utf-8?B?OG5JRjlKK0FxTnBmbW1VTG44UlVQcEtlaHFJcFpLZStUcGhkK0I0aVJnYm1U?=
 =?utf-8?B?MUZXS2JlcEs4Q0RpWjVTcUQ0WFZTWExjS2JTMm15dTNRejJXTlQwTDREa0Fz?=
 =?utf-8?B?aXdsNFlQU1lUVm9VVmFDNW5pQTRwc1VVRTBGdDhYTlFSZjFDVGZZM01jczdM?=
 =?utf-8?B?V0QyTWRuU1AvNGtpUTJLOVlNbGFVS0o4T2E5UlZtMGE2OUNqYUJkN0g2b000?=
 =?utf-8?B?b1IyRy95TWVFdm1CVVlmSGdwWGRTaVo1OUVEejZ5MUwyWUxuVW9nV3A2bElk?=
 =?utf-8?B?dU8xUlVJR2F3RGRvYVovYk1vSmJGK0dVd0k3MmZxT0IvYXBqL2tMY1UxWFJk?=
 =?utf-8?B?Wm1iYjFNVmZtL24rYjMzUUZOd0l6c0I5cTR4TzdBVmZDSExHVmthNlhHMnl4?=
 =?utf-8?B?WjJ4NVFTSGt0VUY3TWt6UkRpN3pEYUxIK1JRQTNmVnl5TlFmVXpwWXpYMFFh?=
 =?utf-8?B?SGZ6THdIOVF5Zjg3YXFKbzdINmpaU0JRaDl2RFJxWXBWNEplK1dCZXJvK01G?=
 =?utf-8?B?SnpPRmoxZDFhb0RmUi8rU21wemx1TUxkc09oc3JpMW5oeStFV3k5cEFuWkQ1?=
 =?utf-8?B?bGxWS3dvd2d1NW80eHhDVHdlRnhWNWxhRnYzbiszOEJseXFmZDN6SzFNQ3gw?=
 =?utf-8?B?aGNIdE1ZQW1Db3JnZHpPOCs4WW80V0Z1RkNpVFFFSXpaY0tSRnExb2UvYm9V?=
 =?utf-8?B?cGJtY1JaNXdPRXFWbzJDV3VWSmkrc1R4NWlaLzBLUWx1NDhlVU5yN2J6czIx?=
 =?utf-8?Q?vRx/HYfCCmkIzXQ6OcBXOJn2k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826696d5-1f80-455f-d216-08de105cd588
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 04:46:44.2798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUrnMUC6q15QvpVZBCHfCuyWJI3Znzfys6KWSJoG1NdYGBuWMK+CHqOciawmp1pd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122
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



On 10/21/2025 7:39 AM, Jesse.Zhang wrote:
> This patch extends the VCN_RESET capability check to include pgm 7 when the firmware version is 0x07551400 or newer.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index cc7a0e061ba1..0a7d2cea7dc6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -450,7 +450,8 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
>   	    ((pgm == 4) && (fw_ver >= 0x4557000)))
>   		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
>   
> -	if ((pgm == 0) && (fw_ver >= 0x00558200))
> +	if ((pgm == 0 && fw_ver >= 0x00558200) ||
> +	    (pgm == 7 && fw_ver >= 0x07551400))
>   		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>   }
>   


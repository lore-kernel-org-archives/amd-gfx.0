Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7222C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 07:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D6B310F883;
	Wed, 11 May 2022 07:44:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2543610F882
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 07:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTjmYH2ng06sldb4wX6r4aRB1XUIxdfRWvttAJ1pavp3t5Ap9RioDbzAgY5o+hH96fQbhsko/xf1GHv2s3oxF8+eWnLidKUMHHhJ+ojtLJMzfojcs9MHSBuZRWQVHcsTufrfsqpCzlR1msH98UW3XXXgdVRCsmQTAWg9j6ZgxzrUaLVRSjYvdZwFmgwM5EfMAeWKqhuTnYZAkRzr8FABM8TU+Jz+qfitO3SF0ZIYIVQfRJFUe+pKRDtlNnR6DMqB1vI8MCYggy4kDxPWI6VFioOFUbXVr+AyfmgHe/oVZIQLv4a9iSRIHjD79Bx92zmMQjMcVK72LhJ8AsXMQdP9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=991wVi8AZG9omU4/d2SI5+zgBVNi/0OOXiM4ICy1GrU=;
 b=DtaxACyBlWYUr9UmhlKyZoH1zQKF/YwV/q0eD6XNabp9owMudqRBIASDxPzEEAPSeysVPiSjjqI5vBYkYV3QzCvT2FkLE+9dSF8ESin2/mOrqvu1c+hu4VYla4Wlm9OD36WaqF/HVjoSF/BELyuGTGUG6UtvSejyRFxFUYjroZ10i3hq2XJo8uAWu2AObkUiIBf3SpL2SST6ubqKWk0THpm+4xex95VnegJfJdg5S9MfnjOTA9WZulQkR+RuKyD4sxpjaqs/HFlTsGX/2rGUfWZcL4FT9cMcE3MpRykoJBwv1+WGlZqUQ5NScsJ52TUABddFkuVHE3UBgEQocMa8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=991wVi8AZG9omU4/d2SI5+zgBVNi/0OOXiM4ICy1GrU=;
 b=nRlmySymoMGQlBPRRNxVOEUbr+C6UfoSKlvakGQKz4zxcMPS8vzpxCOksmPnv2zifz36awDBDfSMqJ4nxVszsyTgb4V87tJaxMPlcn29rxezCU7D6F59og6byhs+lzlztlA8bPnqd+5d9tX2nWpvOMar2UvQvkSLRJQjvGeABI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 07:44:16 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:44:15 +0000
Message-ID: <d96e2bca-891f-57e5-2b2a-91959590ee15@amd.com>
Date: Wed, 11 May 2022 13:14:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: support ss metrics read for smu11
Content-Language: en-US
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220511072150.1595528-1-sathishkumar.sundararaju@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220511072150.1595528-1-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::7) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 781c515e-afd2-48d9-b298-08da33220c28
X-MS-TrafficTypeDiagnostic: MN0PR12MB6079:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB607948E49C9F680A5C36D64297C89@MN0PR12MB6079.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAs9Gg2t8um28HHh8roxoYn/1FoOnq7BanfLc+32zXE862LGbROuxksFDldbP0LiorpD1e9GjcX5Ytqz4BWLI1wWUBk4NASYl5PEwUThLeftZrUxFkpZ4KSbckkY1mxN0TdtG6oerCfhhj3/qUwimQPCrs5MgrcsrpkyDA1zrLURU5fopRlqTXujeSSXu4vk+bFLC+ilAHsbwapnQ9CD5R+natKpFLNNTupKMNAFLJlgJBUMb6cRNefllJWECJw3tB4cgJrZD/97VdyvskpscSlFtT78f1G2T+VJ3FCFNPMcZLgY0a8mt39fo3fP+XJz0Srt9X+1E1gCUEeFxN7WhO89KM5/3UEEn/T5sQC/rJyHFkOZdnPoJNFD9L6dR/0DWLDqyM5ZiUbVRIQRqLTcGGfqaxsx0LR2G4T2bp98S2wTCsjdMSYPtBGZ5XZq8quseeJ4ZpKfFiQLiCSnkNsfeV72HWi1O7KmVagvgwqQFdRqmtFaGLhuomE+nd+xGznAo8mFc7prAnkRzinf6wiVhaPI+wK9iEm4xsTGGsieXDnnjyMqRj/CuxwyH+NzMeLPn574uws45mSbHwbGpAfA8rB0+gABcmR6PeUS+iaPOwcTXX/n3W8vCbOTCpeGttjKPHAJUM7OWUOvnjFKuJqOBowjscUJN6zcEfBbAUiIBlS9W9+KNo1JfRa4Ogx7tLQwtaWkohQgW9IVzvpt/BFODuX3lGQGpKJKRKbX0yLkUtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(86362001)(6506007)(31696002)(8936002)(6486002)(6666004)(2906002)(53546011)(83380400001)(6512007)(26005)(2616005)(38100700002)(186003)(66476007)(66946007)(316002)(66556008)(31686004)(36756003)(8676002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2dFdzBKUC9NbE1iWCtja29GcHVqYWxPYVJ4S0FSTHJDWHJ5YkwzMHVxb0U3?=
 =?utf-8?B?MThUOG9EUittYlBZdWJlZjc3QlpMRUp0Y05SK0x4cmhCSVJkQ1g0NVlGU1Z2?=
 =?utf-8?B?TXFnblNpSHJBV1c5WjRVOFNNODRHOGdMTFduTXlrNCs1YW8xYlpmakJaSlNn?=
 =?utf-8?B?bUhTdUs4QWZUU2xCZDRObGpSclUzNjExWEY5eXJ6Q0dKUDFWZDhML0FhRDVG?=
 =?utf-8?B?NXdRTjlkUlZNK0l0d3VCNlVIVEpmY1BWWDNjMW5RcUxFZWFmVzdmNFlyemRN?=
 =?utf-8?B?WDZxNnVlWUUveGxEdVdEdzJUVkpsWFBQSlQ2Q2VhaDZOcTdRbnVmOVpzQlRl?=
 =?utf-8?B?c0xMeitPNXZiRS90U2NuZnkxdzZ0NENyYjNnMWF6VjA4cndoMzArdEY5d1BO?=
 =?utf-8?B?bmVVQTBRcjdwN2RwWm55aXVQSm5nTVFTb2prWThqUm5wSUt4Vm52dGNla3l4?=
 =?utf-8?B?ZWZsZGp0QzJHWUl3UjNteFBMOVZFaDJkd1F5MEcvaEpHVnJZbFY4UTBHTVhW?=
 =?utf-8?B?Nis5U0Y5NWMwZkxSRjF6SlJVSk9DVU5PeU1MOXBBU0twa0hyMW94aUUza1Iw?=
 =?utf-8?B?dW5iZkZNTHhzUWRsa3BrbWlBMjNLQ09QeldxMHNEM1hLZkpWYTdET1pSSng3?=
 =?utf-8?B?MUoxY0RFU0JQdDdicjI5bTZ3T2pDaFVrd3VZUHZYeFJGVmtMVklCeEdNbzc2?=
 =?utf-8?B?alkyV295NWM2UlVhUU9yV0YyLzg4bVlUZmZMQTVEUENnZVBCNGdab2srcXBT?=
 =?utf-8?B?K3llZERhMzMzTEFzcFRHL09nTnF2S3JkWCtmdk5ZM1ZoazF2UWpHb2oxamRa?=
 =?utf-8?B?MjdTeWVnVjhhRHRBeVRnRFRlQTlaWlNGNDUzblZ5dXpsOTNibFUzd0JYMng1?=
 =?utf-8?B?Qm03S2swdC9CUlNPdm1zZ01OKzFRTkFBRWxudkJCYllHNmJ0Y0Q2ME1rWGZR?=
 =?utf-8?B?N3NVOFY3OW5rL0dFK1pSVXZ6ZCtDaFV5ZzNLR1hlc2NheGxkV3Z1RnE5UE5V?=
 =?utf-8?B?S25ZdzZqSHBGV0RDb3ZaRGdrT1czcmY4YS9QRWRrQ3R3N0VrazlxajZrQWZw?=
 =?utf-8?B?RGw3dC9DRXYzTm1CSXF4ZEpYN214NW9qSGJRdmV5WlhBOVYweDhQYk1RcVhD?=
 =?utf-8?B?VFlYQm1qbUlmeTBoeTlFREpJaG9LWk9zZUpVbjkvc3NLTURBbUdyZUxLOEZa?=
 =?utf-8?B?VHZLamx1S0xjS1VXcUtWU1VyalR4VVA5VHNRZXI5OGF6ZVVDMGdDNzJucGsy?=
 =?utf-8?B?Vk9DTklvckVnQ1dTbWUxL3dPZm0rYkhROWVUWi9CWU5nZEt3WUFULzhsRVF0?=
 =?utf-8?B?V0dMWm4vTXVUNk5JVnhLZWxoM0hDT2xOczh3ckwzS0p4Wlh4S05zWXc0QW0x?=
 =?utf-8?B?ZDdUVWlMYmJ0dHdQc1RtbllKMkdOWGt3TXh2UXZ3emNIUmo3WFRoWW5hTW1E?=
 =?utf-8?B?RmdHTkNTUC95SGs2NXhkUkhScEpwbXZWV09RUnlBOGdBUjlUN2MyL2g2RHJN?=
 =?utf-8?B?b2d5KzVyNmRwa3FVbnBuWGtOSXFWeVJYaU5uZUdvL08zdVZhSlV4MVZhZUtZ?=
 =?utf-8?B?UldFc0wzUXN5eG5udUhFRDU5OTdwcmRocUI0OG50anNKaWxXMkpycXRIbGxD?=
 =?utf-8?B?S2taU3RJanBaU29HSEFtdHhQcCtKeVFLc2MyS0NoQkEyWkx2Zk1HWFdiM2hs?=
 =?utf-8?B?Y1VFUlQ1MU93VEVLbWlkR0VCbk05akNsN09nYWhDZ3VzUUhoeEdkWkw5M3RE?=
 =?utf-8?B?Z0xwZVBlanBCbjFRTUFPaldhUVZXa1RUdWdmcGQxOGtHd0pJR1kzbUx1VHda?=
 =?utf-8?B?MUxIeHh0Y1dZeUhaSTZ4OGZsRjFjT2VrM0o4WXNkUFVYRjlubWJrWnVzM001?=
 =?utf-8?B?dk1oT21nUTlNQk5MZjJzb2ZEWEZWNlA3dkRjbDRVYm9HVjhvRWtEWFJKK2VZ?=
 =?utf-8?B?ajB1RVkva3UxS0pvSGJxVEYrVXZMRng4OG92VFZxNlBTT3NmV2VDV1FORVlY?=
 =?utf-8?B?Q0ovRERUSWVvSW1HL1owSG5QaDRyVUF5ekRPTGFGUENGU1k5clRldXBaR1pw?=
 =?utf-8?B?dUVIRFU4eGtjdnFHbDRqMFRqdjdKNGR0ZXNTSGFKeDhGMDIrajZxRXQ0SUJx?=
 =?utf-8?B?RHVLVGZBMzBRS2VBb0JsWlVqVlE5bVNNY2JmMGN5VkgrYUVZcS8vcnE3MUVJ?=
 =?utf-8?B?eEhzUGxwL2oyRDh1YmF4QUNEZEJ4TVc0Nm5vSDlrZGtmaFV3RkE2dXJ0T0g1?=
 =?utf-8?B?UnhvOCt0clNtZkl1U05QcGFnVjh1ak1NbW40NzdPbFUrNk5tRVFVZm9pdlhW?=
 =?utf-8?B?dXpOVXlSdWNMNFcwaWlpTzlrckRYS3NGQmF1OUJIUHJNMFZVcVhXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781c515e-afd2-48d9-b298-08da33220c28
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:44:15.6775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svL+moXFvV7f03uccKnDtOFU7YYdZ/cu2QtVAUwUPPgkh0TaOq6Eq8/Qjs9VWcnw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/11/2022 12:51 PM, Sathishkumar S wrote:
> support reading smartshift apu and dgpu power for smu11 based asic
> 
> v2: add new version of SmuMetrics and make calculation more readable (Lijo)
> v3: avoid calculations that result in -ve values and skip related checks
> v4: use the current power limit on dGPU and exclude smu 11_0_7 (Lijo)
> 
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../pmfw_if/smu11_driver_if_sienna_cichlid.h  |  63 +++++++
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 161 ++++++++++++++----
>   2 files changed, 187 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> index 08f0bb2af5d2..280d42778f28 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> @@ -1540,11 +1540,74 @@ typedef struct {
>   
>   } SmuMetrics_V3_t;
>   
> +typedef struct {
> +	uint32_t CurrClock[PPCLK_COUNT];
> +
> +	uint16_t AverageGfxclkFrequencyPreDs;
> +	uint16_t AverageGfxclkFrequencyPostDs;
> +	uint16_t AverageFclkFrequencyPreDs;
> +	uint16_t AverageFclkFrequencyPostDs;
> +	uint16_t AverageUclkFrequencyPreDs;
> +	uint16_t AverageUclkFrequencyPostDs;
> +
> +
> +	uint16_t AverageGfxActivity;
> +	uint16_t AverageUclkActivity;
> +	uint8_t  CurrSocVoltageOffset;
> +	uint8_t  CurrGfxVoltageOffset;
> +	uint8_t  CurrMemVidOffset;
> +	uint8_t  Padding8;
> +	uint16_t AverageSocketPower;
> +	uint16_t TemperatureEdge;
> +	uint16_t TemperatureHotspot;
> +	uint16_t TemperatureMem;
> +	uint16_t TemperatureVrGfx;
> +	uint16_t TemperatureVrMem0;
> +	uint16_t TemperatureVrMem1;
> +	uint16_t TemperatureVrSoc;
> +	uint16_t TemperatureLiquid0;
> +	uint16_t TemperatureLiquid1;
> +	uint16_t TemperaturePlx;
> +	uint16_t Padding16;
> +	uint32_t AccCnt;
> +	uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
> +
> +
> +	uint8_t  LinkDpmLevel;
> +	uint8_t  CurrFanPwm;
> +	uint16_t CurrFanSpeed;
> +
> +	//BACO metrics, PMFW-1721
> +	//metrics for D3hot entry/exit and driver ARM msgs
> +	uint8_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
> +	uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
> +	uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
> +
> +	//PMFW-4362
> +	uint32_t EnergyAccumulator;
> +	uint16_t AverageVclk0Frequency;
> +	uint16_t AverageDclk0Frequency;
> +	uint16_t AverageVclk1Frequency;
> +	uint16_t AverageDclk1Frequency;
> +	uint16_t VcnUsagePercentage0;
> +	uint16_t VcnUsagePercentage1;
> +	uint8_t  PcieRate;
> +	uint8_t  PcieWidth;
> +	uint16_t AverageGfxclkFrequencyTarget;
> +
> +	uint8_t  ApuSTAPMSmartShiftLimit;
> +	uint8_t  AverageApuSocketPower;
> +	uint8_t  ApuSTAPMLimit;
> +	uint8_t  Padding8_2;
> +
> +} SmuMetrics_V4_t;
> +
>   typedef struct {
>     union {
>       SmuMetrics_t SmuMetrics;
>       SmuMetrics_V2_t SmuMetrics_V2;
>       SmuMetrics_V3_t SmuMetrics_V3;
> +	SmuMetrics_V4_t SmuMetrics_V4;

I see some extra indentation here <Thunderbird>.

>     };
>     uint32_t Spare[1];
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 86ab276b6b0b..503439754f08 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -585,6 +585,102 @@ static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *s
>   	return throttler_status;
>   }
>   
> +static int sienna_cichlid_get_power_limit(struct smu_context *smu,
> +					  uint32_t *current_power_limit,
> +					  uint32_t *default_power_limit,
> +					  uint32_t *max_power_limit)
> +{
> +	struct smu_11_0_7_powerplay_table *powerplay_table =
> +		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
> +	uint32_t power_limit, od_percent;
> +	uint16_t *table_member;
> +
> +	GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
> +
> +	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
> +		power_limit =
> +			table_member[PPT_THROTTLER_PPT0];
> +	}
> +
> +	if (current_power_limit)
> +		*current_power_limit = power_limit;
> +	if (default_power_limit)
> +		*default_power_limit = power_limit;
> +
> +	if (max_power_limit) {
> +		if (smu->od_enabled) {
> +			od_percent =
> +				le32_to_cpu(powerplay_table->overdrive_table.max[
> +							SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> +
> +			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n",
> +					od_percent, power_limit);
> +
> +			power_limit *= (100 + od_percent);
> +			power_limit /= 100;
> +		}
> +		*max_power_limit = power_limit;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sienna_cichlid_get_smartshift_power_percentage(struct smu_context *smu,
> +					uint32_t *apu_percent,
> +					uint32_t *dgpu_percent)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	SmuMetrics_V4_t *metrics_v4 =
> +		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V4);
> +	uint16_t *table_member;
> +	uint16_t powerRatio = 0;
> +	uint16_t apu_power_limit = 0;
> +	uint16_t dgpu_power_limit = 0;
> +	uint32_t apu_boost = 0;
> +	uint32_t dgpu_boost = 0;
> +	uint32_t cur_power_limit;
> +
> +	sienna_cichlid_get_power_limit(smu, &cur_power_limit, NULL, NULL);
> +	if (metrics_v4->ApuSTAPMSmartShiftLimit != 0) {
> +		GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);

This is not required now.

> +		apu_power_limit = metrics_v4->ApuSTAPMLimit;
> +		dgpu_power_limit = cur_power_limit;
> +		powerRatio = (((apu_power_limit +
> +						  dgpu_power_limit) * 100) /
> +						  metrics_v4->ApuSTAPMSmartShiftLimit);
> +		if (powerRatio > 100) {
> +			apu_power_limit = (apu_power_limit * 100) /
> +									 powerRatio;
> +			dgpu_power_limit = (dgpu_power_limit * 100) /
> +									  powerRatio;
> +		}
> +		if (metrics_v4->AverageApuSocketPower > apu_power_limit &&
> +			 apu_power_limit != 0) {
> +			apu_boost = ((metrics_v4->AverageApuSocketPower -
> +							apu_power_limit) * 100) /
> +							apu_power_limit;
> +			if (apu_boost > 100)
> +				apu_boost = 100;
> +		}
> +
> +		if (metrics_v4->AverageSocketPower > dgpu_power_limit &&
> +			 dgpu_power_limit != 0) {
> +			dgpu_boost = ((metrics_v4->AverageSocketPower -
> +							 dgpu_power_limit) * 100) /
> +							 dgpu_power_limit;
> +			if (dgpu_boost > 100)
> +				dgpu_boost = 100;
> +		}
> +
> +		if (dgpu_boost >= apu_boost)
> +			apu_boost = 0;
> +		else
> +			dgpu_boost = 0;
> +	}
> +	*apu_percent = apu_boost;
> +	*dgpu_percent = dgpu_boost;
> +}
> +
>   static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>   					       MetricsMember_t member,
>   					       uint32_t *value)
> @@ -600,6 +696,8 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>   	bool use_metrics_v3 = false;
>   	uint16_t average_gfx_activity;
>   	int ret = 0;
> +	uint32_t apu_percent = 0;
> +	uint32_t dgpu_percent = 0;
>   
>   	if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
>   		(smu->smc_fw_version >= 0x3A4900))
> @@ -738,6 +836,15 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>   		/* Only supported in 0x3A5300+, metrics_v3 requires 0x3A4900+ */
>   		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumLower32 : 0;
>   		break;
> +	case METRICS_SS_APU_SHARE:
> +		sienna_cichlid_get_smartshift_power_percentage(smu, &apu_percent, &dgpu_percent);
> +		*value = apu_percent;
> +		break;
> +	case METRICS_SS_DGPU_SHARE:
> +		sienna_cichlid_get_smartshift_power_percentage(smu, &apu_percent, &dgpu_percent);
> +		*value = dgpu_percent;
> +		break;
> +
>   	default:
>   		*value = UINT_MAX;
>   		break;
> @@ -1728,6 +1835,7 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
>   {
>   	int ret = 0;
>   	uint16_t *temp;
> +	struct amdgpu_device *adev = smu->adev;
>   
>   	if(!data || !size)
>   		return -EINVAL;
> @@ -1788,6 +1896,22 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
>   		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
>   		*size = 4;
>   		break;
> +	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
> +		if (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7)) {
> +			ret = sienna_cichlid_get_smu_metrics_data(smu,
> +						METRICS_SS_APU_SHARE, (uint32_t *)data);
> +			*size = 4;
> +		} else
> +			ret = -EOPNOTSUPP;

Matching braces required here and in below else case.

With those changes:

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +		break;
> +	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
> +		if (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7)) {
> +			ret = sienna_cichlid_get_smu_metrics_data(smu,
> +						METRICS_SS_DGPU_SHARE, (uint32_t *)data);
> +			*size = 4;
> +		} else
> +			ret = -EOPNOTSUPP;
> +		break;
>   	default:
>   		ret = -EOPNOTSUPP;
>   		break;
> @@ -1907,43 +2031,6 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
>   	return ret;
>   }
>   
> -static int sienna_cichlid_get_power_limit(struct smu_context *smu,
> -					  uint32_t *current_power_limit,
> -					  uint32_t *default_power_limit,
> -					  uint32_t *max_power_limit)
> -{
> -	struct smu_11_0_7_powerplay_table *powerplay_table =
> -		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
> -	uint32_t power_limit, od_percent;
> -	uint16_t *table_member;
> -
> -	GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
> -
> -	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
> -		power_limit =
> -			table_member[PPT_THROTTLER_PPT0];
> -	}
> -
> -	if (current_power_limit)
> -		*current_power_limit = power_limit;
> -	if (default_power_limit)
> -		*default_power_limit = power_limit;
> -
> -	if (max_power_limit) {
> -		if (smu->od_enabled) {
> -			od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> -
> -			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
> -
> -			power_limit *= (100 + od_percent);
> -			power_limit /= 100;
> -		}
> -		*max_power_limit = power_limit;
> -	}
> -
> -	return 0;
> -}
> -
>   static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
>   					 uint32_t pcie_gen_cap,
>   					 uint32_t pcie_width_cap)
> 

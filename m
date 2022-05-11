Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CDFC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 08:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2FF910E8E1;
	Wed, 11 May 2022 08:14:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F4610E8E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 08:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5pd6wy04HzlT/Je5CEpqLYWr0futDZbQkFkpvQ9L2QtA9hXE+joSzeT4Nu0Tk9+EovwqyZ2retFHuzt8xjER482W6RXYpNqjq8bcZZ0s/odNQP7RoDLuDnAvB7WvC3SSJNEPmgQlfB3kvSrY5Yvh83f88IaNBXjBmy2IPMoczQUUPVI2tIhD/EpO0C1stbhqe2i9KMlUtxqK6pXH0sc+OkEwbepkkMfGUwcFF0d1oOzwb7XWBLe/XJAtnr4LaKY0XG0KLWMyeUiC1rMMjIPNsxCGu38EEIXpbnK0uvleUWZjF2XMmEWIV1FPus407U9XjkIL/JOMa5U3xBNzQGDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzXDFAO5ciI9fQkBPbkipsO2Tmwwixorcpngg+TA/EQ=;
 b=V/gFiWG2dvVlYvcjXgKEPhxffbAezvwZKw27FACKR1cgUS/xegSrXbbtX9gJY94We8Ef4zJxdRUuuLRWW29t2/q3ruNGP4LOgHG3HNGDl5MxvrAxCcYaMGQm9O+QPc05oyCUat0U56Yv3q+7CihKoabrfrxcr5ikMGypVvIlsWCBHz7+qJI2HyJHrwmCnXMc9QXjRIIXb77FwjF/luSqwNpn8Z5aVRPFOMuOxF/YnP9rgVLbq+08bFRHc4tv4fU8dLxLum8JuAvGkvKt0AaXQsXtVzsaMYoAzZKFlpI+hExcNQs1rT9HjiI+F+gm3Wk75XIdNQRbQHgnZpc3Wwo8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzXDFAO5ciI9fQkBPbkipsO2Tmwwixorcpngg+TA/EQ=;
 b=v/PjwRmql0EcSAcLiZ4k/4W+AwUSr7zFJnI6XYwtWD10PBt4qJZntEU8UjbwSeHPT9o0qXSfE3w4EdYrVynlEjlSwRBzemj1KcvlmT0uDn6cT5BgwPeYp1vt3ZyBAt8Zof17tchry4PxRrts6C9eevOSC8vhbf7uXSJvfOJFYkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7)
 by BN8PR12MB2851.namprd12.prod.outlook.com (2603:10b6:408:9f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 08:14:40 +0000
Received: from CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::bc8d:b8b1:ae83:788a]) by CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::bc8d:b8b1:ae83:788a%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 08:14:39 +0000
Message-ID: <d6d67602-bba4-c628-119b-2c6c8457ea00@amd.com>
Date: Wed, 11 May 2022 13:44:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amd/pm: support ss metrics read for smu11
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220511072150.1595528-1-sathishkumar.sundararaju@amd.com>
 <d96e2bca-891f-57e5-2b2a-91959590ee15@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <d96e2bca-891f-57e5-2b2a-91959590ee15@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::6) To CY4PR12MB1943.namprd12.prod.outlook.com
 (2603:10b6:903:11b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a6bdc58-180f-45b4-c305-08da33264ae9
X-MS-TrafficTypeDiagnostic: BN8PR12MB2851:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2851C7F54A4B1B5BAB76406C9DC89@BN8PR12MB2851.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RspmfR9YaSZP0jVn4NqSqwhm1ve/faPRe4/WUj1e8Qq/pJY+ZnyWI/TjCNHnZhyCppkloIqBvgKMP2EZnVFgaURk2yAr8HJNS4qb8bg1VpMpXndW+AySSOxIM3IhoW9KGq2wr/1A7gt+fCOotBj0LpGZLCWUSyAM3ejd7ojc7hn3p8F8rCH7se35vAqxAX5e8Sh3jbUWnAtAGCLqYYH7TJ8G4Weu+aBxhRwNAJxVNR0yrX4Flkv/53x2CDcPeP977JH4sa3hL2v2v4jmxJfAqH2RWpPbsj7YLck1nAYN85sdI6RFcgtODo9OsSHx+2Gi6U3P5V1OL7rwKbfsZ++ACNJgcTHOzVNSPiTDyyaa3tqGE1TDI5B4l38kb1qsN9dUijgLnQ+Q+kGpKLHnseMqiEQjxDIemVvnuZemBaALbAyMOvn2X6ZkPuzLdgb6FyiUG78+AlLfGdqhjkaQUelFm+P+BjhRBfS3cwpHz6L9KviIoei1X5cBTTHLFrB8y3xqdHQn0+PyMiOOu52BJkEm7PMhlwjwSM4X7eDluWv8EXLWUQ2UZC97/Clx4IhSdfRGJwOOrIKJT+5253O6doYoBa4Rons2WY4Zh4VYEgEiO3yH8TgVwsrDVs/ptE+TOJFKgGJcT+8QIOJyGDuvXy8MiKLnpaw5pMwA46PbmnwAEj23zKmnAaOw/02qjFbXjtD2bizYQbpD7QrOJppuNr8CxY8RrmI9jaRFNXGfp/60Ak4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1943.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(30864003)(86362001)(66476007)(316002)(4326008)(66556008)(6512007)(31696002)(2616005)(8936002)(186003)(8676002)(26005)(5660300002)(83380400001)(508600001)(6486002)(38100700002)(2906002)(36756003)(31686004)(53546011)(6506007)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHU1cXZhUlVjMktOTDB1NEt0Y0VYbW1MWnl4aE5rbUNKdmdZVTdqNWdBaXVm?=
 =?utf-8?B?Wm5zNDc4WC9Xd2dPTVVrNjhzY05rWnU3Y1V1S1NRR0dtbkVaMEV3RG9yM2VV?=
 =?utf-8?B?eDJFVFhOdWZ0Y0tIcHFPV21aZDVqUjNILy9jYVBnVmRzbXRPc2o2eVNtYlhS?=
 =?utf-8?B?b0pQdlJHZE05TW42ZzFCeEFkcWpBajNsL3hOUUZmUmRKaXlyZkNpN3RHVk95?=
 =?utf-8?B?a1RITHhIY0lIcWI2QUFrYk40Z2x6a0tzaUtPblk4cHlVQ3o5Mno4QklnN3lm?=
 =?utf-8?B?cGNjUHJtaUhnQ2MzM09yekxOWTdlOVFnWG9DV2JsVXFiVEIzUkRQbWRnNk95?=
 =?utf-8?B?ak1rRnhyVUIxWERVMGFHUlowa21CSUhPZTRQV0RNb3BtV3RnMXlZUEdrc3Nv?=
 =?utf-8?B?aGlZODhJY0VlRjJBSGVnZ1lIQjBhQUNVcWo2aENXK0dXQ2hmUzc3eTJXT0ww?=
 =?utf-8?B?M2UwVng5WnFHR1FXdXd1NkpOWEN5M1pUSEZ2eGdVUWg5SjIzTFRwdzRmTGlV?=
 =?utf-8?B?bXB5VWlyV2hQa3cvUVZEdGJYSlpvQ2VSWlhscjlVV1p1ZmF3SGxFOTI1MS9h?=
 =?utf-8?B?bzdrcEhmRDEvTkZrUDhEeW9GN2JmaHYrejFiVUU0TVlaL0xSQ2NxcW9SOW83?=
 =?utf-8?B?WUZRYVd6U1c3aFFwZ1pVNkpUUVpTTUFVWGpqdCtKVkhUYktYMk5rTFZOb0Jr?=
 =?utf-8?B?cXQva2dBS0M1bThxcWtidzRJZGJBYkRjZFh1cFJRQ01Ka0ptZm9CN0EwRzR1?=
 =?utf-8?B?eXMrL2l6djM0emx0cEx1eHpPSkJjbXFuQkt0bXQyQnJubWpWK002aFdlOElW?=
 =?utf-8?B?L3pYOEhtUW9rRUJ2R3JoNFplVVZ6Vkx1TFdhMjB5N2ROdUVEOS9BZy9RUUNa?=
 =?utf-8?B?ZVVCZVFNaFFwMWgzN3lpK3BMcGEvS3ZOeTNwaThqOEdXU2pFMDZqaDd2M3lQ?=
 =?utf-8?B?eCtkRVdRT3lMZEt1bzRvN3RJdENqeDdiTUp6NXRsT210dWhXT21UcXc4MG1E?=
 =?utf-8?B?dG9MdDR5VE11N0RmWjdrUkhxK0JSdzBNUDM4Z2VNd2xtMGcwYmFGUUFiNi90?=
 =?utf-8?B?bFVmVXhDZzBML1lrOGpIc1JsNUNLOGxWWlJ4dkZ1d0xVell5K0w3WmtyaTQ3?=
 =?utf-8?B?eFNON0dJd3RSb1hNWmlLNlZZTENmdEp5L2F0QnVDMEd5eUJ0MEtSd0RrRkhK?=
 =?utf-8?B?cW5LczBrUVpnRDB1SmRocFZYUHhLNHEvNkNUcDlLL3B1bXhRdCt4VHBOTXlx?=
 =?utf-8?B?alZ6WmJaYzI4MkZaYjVoOExlRkV3WjlFRkVUbVdSSnRwcjA0eDl4N3owRE00?=
 =?utf-8?B?VWl2eHh4SU9qMnZKbGFhR244Tkp3UVRNeFlJU2ppL1hMQjJKN2JUMWUyRjlY?=
 =?utf-8?B?VWZUQ09ha0NDVWZaOW9rN0JPb21XM25jZVY0NXNRR0gxVlBMdWdsTzJYNGQz?=
 =?utf-8?B?WFBqdUE0ZWxuK2RvM0liVmk1Ti9USXNOZzBtREFpUEkrNzBSb3RUdE5NRFZa?=
 =?utf-8?B?YkJhdXZWdzg4QmFQMkFYTlFvaWd4ZTc3MUFiZEU5Rmo4RVpzVSttZU5MbXky?=
 =?utf-8?B?U3hzb0xJWURxM2ZZR0xZdHlXT3J5M20yM2xoZXVLRDFlVHZ6a002MS8rZEZ6?=
 =?utf-8?B?ZExOQ3VkYkJWdzNTQUg3UzRHOXVzb2QxbWJHdEZSYVZXeVhwamNsS1pkZkJm?=
 =?utf-8?B?WFFQbW9LZmdTMDFNTzFlM2FndnUxV0h0UTcxOHRGODJQS0xKN21NQkx6YWRv?=
 =?utf-8?B?T0dvUDJvWVgwSjZHTmNSbTdaeHR6NW8zRFFKNk85aEgzNTNxbFdmaDQ4Rml5?=
 =?utf-8?B?Tnhhc250RnpvSHo5OEd1cnpvKzhheVkwRmlsQmVDcWVjS1NrcXdwK0tSTDY5?=
 =?utf-8?B?R3MxU0hqZW5XOVJkbVkxM0Vtb1dKRUVCUnhzUklqemFUSW9BbHRLbU5uUDU3?=
 =?utf-8?B?azUrcURoajQxcUYvbzAzREEwejNqTjIrcnlhaW1lU2pCZ2lpNFkwMHhHcFhO?=
 =?utf-8?B?cHpOSHc1REFGOEVpZU9OeGQ4RXpTemtLUklFaUd2a2dTWnNpT2VhWTZCbmZD?=
 =?utf-8?B?eThteXZUTkdYK3k3SXpsRkpJTzJ6aUFtMEZNbXhrNUZ3RWdJTUZrenlMMHdh?=
 =?utf-8?B?aG1id0NsaWVJN1V1WDJnelF6M2RrRC9EK05Oc0ovUFJPWjNEV3ZGcS9hRU9B?=
 =?utf-8?B?aWtQNUpNRW1UR0FyTnlic1ZSeU1kQWppa1A5TWx3c0kyMHpBTWh6Mk5GZGVV?=
 =?utf-8?B?ZXdCL3dwNlFNVXoxT251VFVkd2wvZS91d2NYNXNOQVdKRnI2b1hPTWpqMmhk?=
 =?utf-8?B?L1VQeG16QVJhOEVhWGhPQ2krZjY3b0lSbjVzZkhGQUg1L2huNDVkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6bdc58-180f-45b4-c305-08da33264ae9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 08:14:38.9328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSbyoeORYSZCVTg69kO9oMAlnj1ffYEx68BczU+4cdWPvfjxrTB99GLAJm/DL2pCpVtP1LweFw21krF7QsVOQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2851
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


On 5/11/2022 1:14 PM, Lazar, Lijo wrote:
>
>
> On 5/11/2022 12:51 PM, Sathishkumar S wrote:
>> support reading smartshift apu and dgpu power for smu11 based asic
>>
>> v2: add new version of SmuMetrics and make calculation more readable 
>> (Lijo)
>> v3: avoid calculations that result in -ve values and skip related checks
>> v4: use the current power limit on dGPU and exclude smu 11_0_7 (Lijo)
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   .../pmfw_if/smu11_driver_if_sienna_cichlid.h  |  63 +++++++
>>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 161 ++++++++++++++----
>>   2 files changed, 187 insertions(+), 37 deletions(-)
>>
>> diff --git 
>> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h 
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h 
>>
>> index 08f0bb2af5d2..280d42778f28 100644
>> --- 
>> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
>> +++ 
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
>> @@ -1540,11 +1540,74 @@ typedef struct {
>>     } SmuMetrics_V3_t;
>>   +typedef struct {
>> +    uint32_t CurrClock[PPCLK_COUNT];
>> +
>> +    uint16_t AverageGfxclkFrequencyPreDs;
>> +    uint16_t AverageGfxclkFrequencyPostDs;
>> +    uint16_t AverageFclkFrequencyPreDs;
>> +    uint16_t AverageFclkFrequencyPostDs;
>> +    uint16_t AverageUclkFrequencyPreDs;
>> +    uint16_t AverageUclkFrequencyPostDs;
>> +
>> +
>> +    uint16_t AverageGfxActivity;
>> +    uint16_t AverageUclkActivity;
>> +    uint8_t  CurrSocVoltageOffset;
>> +    uint8_t  CurrGfxVoltageOffset;
>> +    uint8_t  CurrMemVidOffset;
>> +    uint8_t  Padding8;
>> +    uint16_t AverageSocketPower;
>> +    uint16_t TemperatureEdge;
>> +    uint16_t TemperatureHotspot;
>> +    uint16_t TemperatureMem;
>> +    uint16_t TemperatureVrGfx;
>> +    uint16_t TemperatureVrMem0;
>> +    uint16_t TemperatureVrMem1;
>> +    uint16_t TemperatureVrSoc;
>> +    uint16_t TemperatureLiquid0;
>> +    uint16_t TemperatureLiquid1;
>> +    uint16_t TemperaturePlx;
>> +    uint16_t Padding16;
>> +    uint32_t AccCnt;
>> +    uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
>> +
>> +
>> +    uint8_t  LinkDpmLevel;
>> +    uint8_t  CurrFanPwm;
>> +    uint16_t CurrFanSpeed;
>> +
>> +    //BACO metrics, PMFW-1721
>> +    //metrics for D3hot entry/exit and driver ARM msgs
>> +    uint8_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
>> +    uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
>> +    uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
>> +
>> +    //PMFW-4362
>> +    uint32_t EnergyAccumulator;
>> +    uint16_t AverageVclk0Frequency;
>> +    uint16_t AverageDclk0Frequency;
>> +    uint16_t AverageVclk1Frequency;
>> +    uint16_t AverageDclk1Frequency;
>> +    uint16_t VcnUsagePercentage0;
>> +    uint16_t VcnUsagePercentage1;
>> +    uint8_t  PcieRate;
>> +    uint8_t  PcieWidth;
>> +    uint16_t AverageGfxclkFrequencyTarget;
>> +
>> +    uint8_t  ApuSTAPMSmartShiftLimit;
>> +    uint8_t  AverageApuSocketPower;
>> +    uint8_t  ApuSTAPMLimit;
>> +    uint8_t  Padding8_2;
>> +
>> +} SmuMetrics_V4_t;
>> +
>>   typedef struct {
>>     union {
>>       SmuMetrics_t SmuMetrics;
>>       SmuMetrics_V2_t SmuMetrics_V2;
>>       SmuMetrics_V3_t SmuMetrics_V3;
>> +    SmuMetrics_V4_t SmuMetrics_V4;
>
> I see some extra indentation here <Thunderbird>.
I used tab and the current code here is using 4 spaces, will match it to 
existing code.
>
>>     };
>>     uint32_t Spare[1];
>>   diff --git 
>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> index 86ab276b6b0b..503439754f08 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> @@ -585,6 +585,102 @@ static uint32_t 
>> sienna_cichlid_get_throttler_status_locked(struct smu_context *s
>>       return throttler_status;
>>   }
>>   +static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>> +                      uint32_t *current_power_limit,
>> +                      uint32_t *default_power_limit,
>> +                      uint32_t *max_power_limit)
>> +{
>> +    struct smu_11_0_7_powerplay_table *powerplay_table =
>> +        (struct smu_11_0_7_powerplay_table 
>> *)smu->smu_table.power_play_table;
>> +    uint32_t power_limit, od_percent;
>> +    uint16_t *table_member;
>> +
>> +    GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
>> +
>> +    if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
>> +        power_limit =
>> +            table_member[PPT_THROTTLER_PPT0];
>> +    }
>> +
>> +    if (current_power_limit)
>> +        *current_power_limit = power_limit;
>> +    if (default_power_limit)
>> +        *default_power_limit = power_limit;
>> +
>> +    if (max_power_limit) {
>> +        if (smu->od_enabled) {
>> +            od_percent =
>> + le32_to_cpu(powerplay_table->overdrive_table.max[
>> + SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>> +
>> +            dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d 
>> (default: %d)\n",
>> +                    od_percent, power_limit);
>> +
>> +            power_limit *= (100 + od_percent);
>> +            power_limit /= 100;
>> +        }
>> +        *max_power_limit = power_limit;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void sienna_cichlid_get_smartshift_power_percentage(struct 
>> smu_context *smu,
>> +                    uint32_t *apu_percent,
>> +                    uint32_t *dgpu_percent)
>> +{
>> +    struct smu_table_context *smu_table = &smu->smu_table;
>> +    SmuMetrics_V4_t *metrics_v4 =
>> +        &(((SmuMetricsExternal_t 
>> *)(smu_table->metrics_table))->SmuMetrics_V4);
>> +    uint16_t *table_member;
>> +    uint16_t powerRatio = 0;
>> +    uint16_t apu_power_limit = 0;
>> +    uint16_t dgpu_power_limit = 0;
>> +    uint32_t apu_boost = 0;
>> +    uint32_t dgpu_boost = 0;
>> +    uint32_t cur_power_limit;
>> +
>> +    sienna_cichlid_get_power_limit(smu, &cur_power_limit, NULL, NULL);
>> +    if (metrics_v4->ApuSTAPMSmartShiftLimit != 0) {
>> +        GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
>
> This is not required now.
Missed to remove this, will remove it.
>
>> +        apu_power_limit = metrics_v4->ApuSTAPMLimit;
>> +        dgpu_power_limit = cur_power_limit;
>> +        powerRatio = (((apu_power_limit +
>> +                          dgpu_power_limit) * 100) /
>> + metrics_v4->ApuSTAPMSmartShiftLimit);
>> +        if (powerRatio > 100) {
>> +            apu_power_limit = (apu_power_limit * 100) /
>> +                                     powerRatio;
>> +            dgpu_power_limit = (dgpu_power_limit * 100) /
>> +                                      powerRatio;
>> +        }
>> +        if (metrics_v4->AverageApuSocketPower > apu_power_limit &&
>> +             apu_power_limit != 0) {
>> +            apu_boost = ((metrics_v4->AverageApuSocketPower -
>> +                            apu_power_limit) * 100) /
>> +                            apu_power_limit;
>> +            if (apu_boost > 100)
>> +                apu_boost = 100;
>> +        }
>> +
>> +        if (metrics_v4->AverageSocketPower > dgpu_power_limit &&
>> +             dgpu_power_limit != 0) {
>> +            dgpu_boost = ((metrics_v4->AverageSocketPower -
>> +                             dgpu_power_limit) * 100) /
>> +                             dgpu_power_limit;
>> +            if (dgpu_boost > 100)
>> +                dgpu_boost = 100;
>> +        }
>> +
>> +        if (dgpu_boost >= apu_boost)
>> +            apu_boost = 0;
>> +        else
>> +            dgpu_boost = 0;
>> +    }
>> +    *apu_percent = apu_boost;
>> +    *dgpu_percent = dgpu_boost;
>> +}
>> +
>>   static int sienna_cichlid_get_smu_metrics_data(struct smu_context 
>> *smu,
>>                              MetricsMember_t member,
>>                              uint32_t *value)
>> @@ -600,6 +696,8 @@ static int 
>> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>>       bool use_metrics_v3 = false;
>>       uint16_t average_gfx_activity;
>>       int ret = 0;
>> +    uint32_t apu_percent = 0;
>> +    uint32_t dgpu_percent = 0;
>>         if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 
>> 7)) &&
>>           (smu->smc_fw_version >= 0x3A4900))
>> @@ -738,6 +836,15 @@ static int 
>> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>>           /* Only supported in 0x3A5300+, metrics_v3 requires 
>> 0x3A4900+ */
>>           *value = use_metrics_v3 ? 
>> metrics_v3->PublicSerialNumLower32 : 0;
>>           break;
>> +    case METRICS_SS_APU_SHARE:
>> +        sienna_cichlid_get_smartshift_power_percentage(smu, 
>> &apu_percent, &dgpu_percent);
>> +        *value = apu_percent;
>> +        break;
>> +    case METRICS_SS_DGPU_SHARE:
>> +        sienna_cichlid_get_smartshift_power_percentage(smu, 
>> &apu_percent, &dgpu_percent);
>> +        *value = dgpu_percent;
>> +        break;
>> +
>>       default:
>>           *value = UINT_MAX;
>>           break;
>> @@ -1728,6 +1835,7 @@ static int sienna_cichlid_read_sensor(struct 
>> smu_context *smu,
>>   {
>>       int ret = 0;
>>       uint16_t *temp;
>> +    struct amdgpu_device *adev = smu->adev;
>>         if(!data || !size)
>>           return -EINVAL;
>> @@ -1788,6 +1896,22 @@ static int sienna_cichlid_read_sensor(struct 
>> smu_context *smu,
>>           ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
>>           *size = 4;
>>           break;
>> +    case AMDGPU_PP_SENSOR_SS_APU_SHARE:
>> +        if (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7)) {
>> +            ret = sienna_cichlid_get_smu_metrics_data(smu,
>> +                        METRICS_SS_APU_SHARE, (uint32_t *)data);
>> +            *size = 4;
>> +        } else
>> +            ret = -EOPNOTSUPP;
>
> Matching braces required here and in below else case.
Okay, will update it.
>
> With those changes:
>
>     Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Thank you, will fix the changes mentioned.
>
> Thanks,
> Lijo
>
>> +        break;
>> +    case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
>> +        if (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7)) {
>> +            ret = sienna_cichlid_get_smu_metrics_data(smu,
>> +                        METRICS_SS_DGPU_SHARE, (uint32_t *)data);
>> +            *size = 4;
>> +        } else
>> +            ret = -EOPNOTSUPP;
>> +        break;
>>       default:
>>           ret = -EOPNOTSUPP;
>>           break;
>> @@ -1907,43 +2031,6 @@ static int 
>> sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
>>       return ret;
>>   }
>>   -static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>> -                      uint32_t *current_power_limit,
>> -                      uint32_t *default_power_limit,
>> -                      uint32_t *max_power_limit)
>> -{
>> -    struct smu_11_0_7_powerplay_table *powerplay_table =
>> -        (struct smu_11_0_7_powerplay_table 
>> *)smu->smu_table.power_play_table;
>> -    uint32_t power_limit, od_percent;
>> -    uint16_t *table_member;
>> -
>> -    GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
>> -
>> -    if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
>> -        power_limit =
>> -            table_member[PPT_THROTTLER_PPT0];
>> -    }
>> -
>> -    if (current_power_limit)
>> -        *current_power_limit = power_limit;
>> -    if (default_power_limit)
>> -        *default_power_limit = power_limit;
>> -
>> -    if (max_power_limit) {
>> -        if (smu->od_enabled) {
>> -            od_percent = 
>> le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>> -
>> -            dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d 
>> (default: %d)\n", od_percent, power_limit);
>> -
>> -            power_limit *= (100 + od_percent);
>> -            power_limit /= 100;
>> -        }
>> -        *max_power_limit = power_limit;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>   static int sienna_cichlid_update_pcie_parameters(struct smu_context 
>> *smu,
>>                        uint32_t pcie_gen_cap,
>>                        uint32_t pcie_width_cap)
>>

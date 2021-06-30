Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885EEC11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 03:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E06E61D18
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 03:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E06E61D18
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99C66E921;
	Wed, 30 Jun 2021 03:52:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC736E921
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 03:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtpjNejhJ9bX3TRplpWTsfoP4HQ7YBtMHRVSrjcMEwBfoLcJ3uBEH+EZVkL/R7QDX3w07LDTpP7U4vT/Kck2q6Nb/YQOP+olwYrdswurQ28v3J0W9UL+G7Qq9DXmNEl0PEFWva68MOd/fGd244at9P8QlRwRseBo/RLAcI7jv9McIV/NVWU8wA5/VZOzkJt326izjKeUkU0W3xlwU31wW3PWMoyu080AAzRPSh0pNyp5ojMh5ixU46FB77VKY6qGUMP2Ka7lvDbwqyJRZPe3drmMKA0TIDh64GwAQag3RcYHKgNhJ6KA5GtE7BSlpusb3m1Mf4jm1hECogRJE2WJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDRofHBxVIqzuSTtBOrrzVO3RS3y33XMLIYLWsOvdvc=;
 b=b6ieYC04V9dCn7k2xNeEpmTSFeZ9Grp9ouvPCHk6FgdDX1TfdJPl4UU0yJeKe9dnq0U1nEiRVMmdawvZtCvt3mH0X2oOwmo5S/V1INBAarOp5CVbUl8v05rjQlYoreYKh9XbdQWDtLEe24h7QQNqMLezmmMBlnqVe9r1K3Nm5Z8WBChaz5Qlc73r7motJbh3Wyeb/Dcg+vKJf1HcUqWRQL07i6BOsVrjk8GmWpmsoQNsDJjeQiHLDBMTpUkbxpBdOpvIOqqC08/k4EPXUp6p3C8pjEaLBGl0TJNWzDEwclZIm3MK22lHPCXsxuzXMtwdZ7RqQ/W5ZGD907SyaY6MRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDRofHBxVIqzuSTtBOrrzVO3RS3y33XMLIYLWsOvdvc=;
 b=yPTZKNRAGWx65U1daFyIc3oxe3t0gUKdSE0S8SebaRAIePmv+MdhhCl3FUWbsXsOSTGfcIWnmEW4rnRXcmbP/00g8YMmpB1Dq+gFAKeb4Ybe1ZVQer8FgzCTukgLMpKLOY1lFP0OQYrdYi95kOzyPZnFeneiGYKSISE0x4c4NuI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Wed, 30 Jun
 2021 03:52:11 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%7]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 03:52:11 +0000
Subject: Re: [PATCH 1/2] drm/amd/pm: update the gpu metrics data retrieving
 for Sienna Cichlid
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210625081203.978006-1-evan.quan@amd.com>
 <bcef032d-507b-e04c-efa8-1f63e4a48707@amd.com>
 <DM6PR12MB2619CF378B8CDD0856459A29E4019@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <e1548530-f4be-d58d-e107-15c39935b812@amd.com>
Date: Wed, 30 Jun 2021 09:21:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <DM6PR12MB2619CF378B8CDD0856459A29E4019@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 03:52:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbf113c8-cbdf-4eae-9442-08d93b7a700a
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB52845C63C65534FF70AF900397019@CH0PR12MB5284.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhGwUtl8d+AmPY/bPbki+KAwslNmWyq9r/i73Uwww40Tw3NSoOx66sGTwIoxX4aQSYhrsSmpcBlD3H74pcRDQ4BhO2dQ88qpk4iX4afrlhu5TkRyHXOryiW0InxGVoL7Nx8nr90fWXjricha66VOSLCajC/5hJkTL1cMRZzXHWG+t7axOoJl8+qg1pjtKJ7BbTc7r4Mf+kFaV5PqGcW7m41xRpfgft7x2XVw1phR0wL+X8nsQBRFJtAQKh0A6hbUtlc2vv546xfeaRgDGb2qouJ/NsXZhGOV9ccjiDW0oe85lhh1cLp0cu5xjNcLgxobvnPeKO9U9CSSwkNkqkSm7gC8Rl0cXA+6JPvIXf8k5YZTqbEgiHAQ+xrKJlsAWbJqgMqqCsWRK0t/zRJmTLy7ZvbjQ8id9yH5cvchlbJMgNMlWd5pS3nif+I0qqSJRX/kE+gSDqzuuT6gDaw9kvAnhyL8fXWEakhEkfg9G8/xpvnZUzpFi2GtYZIdcHxA9H4UD3lC48ONWfHW+yRfePLF2AxNHZTSXqoCG7Sk9oOttFEIcj7MELI+IHkSFiWVetCpl0fEiSWlqt2hwFRtrOarF7tET3o3mqHQ0q1YWyO0Jyv64eHPCX+0bHc8OuEdFh9RexeD7jYZfF4L+vO4v7Xv8O+vT4UrK7dIRh3TNnV6AO+3w/Xdu/r/CijY28O5Q0jgDWqbdlZUCT7UyJ5wHaUoWRfFGVydsVwJndE0b7Z4IFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(30864003)(6486002)(31686004)(186003)(26005)(16526019)(110136005)(66556008)(66476007)(66946007)(16576012)(6666004)(53546011)(316002)(4326008)(86362001)(5660300002)(36756003)(15650500001)(19627235002)(83380400001)(478600001)(8676002)(31696002)(956004)(8936002)(2906002)(38100700002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHY2MTdOWHNZbjIrMzQyTno4WmsreUhUaVNnMGdwcDlmR1lKT0NFVDdPR0Jl?=
 =?utf-8?B?dGdYcDl2L1pCZUhkbi9WSWR3NTU1dHpHdVNNcHdTWGl0QThZaVp2RFRqQklk?=
 =?utf-8?B?VHNML2wvc3VTU3RVUHhpanlwekU0VXRPWkN5QVdBeXYzWWtPT2ZPcm9FUWhC?=
 =?utf-8?B?NzdqdnBmSjRpRTF2Z1o3ck5paURBUDVON0xpLzg0T2wxMVBPVnNtVHY5NTky?=
 =?utf-8?B?MXQrdkJxRXd1cmRhdUV2OG05VmQ3OTBTUzNUR2Erb0p6WTJCRHJSc1NPQk56?=
 =?utf-8?B?RUFmOTdLSXZqNWY0VnpjR2UwNHRxNExyVzk3aTJ2MlB1T1ZvMk8zVTdJM1lB?=
 =?utf-8?B?MVNUOUVWZWYxKzBTMlJzZ0NXaGxYV242NmxHcm53NUNvb3V3OXhweVBlWjZT?=
 =?utf-8?B?MDREOGZVSzVFaStSMlZPZ2dmSXY4QW5QMjlTV0lmQVdBSzhVQkkwclFRZ0N0?=
 =?utf-8?B?UFJ1bENUb2lPbkR3dE1EdkkzSzF1OWxYWjlOcHVkNUxJS3pVMFRSSXg0bCt4?=
 =?utf-8?B?aG1jUUwxaEx6RFZaaFdLYmI1UTlZL3BWeWo5YkJIdmVmcVpZQTdUMExSb1Fy?=
 =?utf-8?B?QWtmcUxHcHBTcURVTFFDYUNJZ3RERFNnTE1UYWxKZkJLbkphdTdvV3VrNDM2?=
 =?utf-8?B?dk1vcGhlRGdEYWFFRGI3MjFLOG00YXp0OGM0R09rcUQ1Rk9qTVM2d0xKY0hF?=
 =?utf-8?B?RXp0VW9lNkpsOVM3ZlIwV3JEalgvby8yZG9sRkZORmJmcHZ0VG1wVm5PUzQw?=
 =?utf-8?B?UHZDNjUwRXB2aEJTRCtuTncwTVhFVUNRY1BsM21lU3ZNQUZDajRQeU9vWU1y?=
 =?utf-8?B?RzU4clpNS1dVbmtEK1dnRTNtMGt0QTBITlV1Qi8xQkM5ckFaeEZUM3NMSDcy?=
 =?utf-8?B?UGhFNDI5TjFkRWZOOEJXTXZkc05CUjlzdld4R20wd3Y4MktlYXlCcVFremZp?=
 =?utf-8?B?bkNtazA2R3o1WTZPRWhBcnhlc1hXRS9vWHE0VUJ5T0xoNDJqckdEK0RodFRo?=
 =?utf-8?B?RjNJTHRrdERCZ0tlWHl0TGlOcmhJQi9ObXBtZFhuVW1xUzFySXpCQWE3UDZo?=
 =?utf-8?B?K1g0TlJHSm5PeVN6SU1tT3RiT0xJdDQrdjczTWMva1lBcXJmaXo5bVFYMjhS?=
 =?utf-8?B?V25jcEtXOGFmUXdHNXB2VXhjL05lVjhzOGpTMy9PL1BndlJGRVJWR1A2NjFE?=
 =?utf-8?B?aWlCWUhibVJZQ2FJSklYdzlicDdQajBMa0c3SEhmaHRNaEh4aFR5U2Q3SFd2?=
 =?utf-8?B?Y2ZkZXV3cm9xN1p1QlhzU0loQnRXZWZnNmVHaXQwUW9iN0hyb3p5djhEMjFI?=
 =?utf-8?B?bS8wQUFyVmtnZC83cDBIUkorM1QralZ6V0Z1T04zaWd6UncySkRvY3NoLzhu?=
 =?utf-8?B?MUN6KzVpMmRENDV3QXptK0FaMlRkREJ6cm1ZWmxsem9KWGtGSitpVFNIUjdQ?=
 =?utf-8?B?TWRJOVBlWlNDWm1RRnFLdHlqaFpVdkxNekJRYTRHWFBlMDJydGpKb1pKdDdJ?=
 =?utf-8?B?dHFJNHQycGRsMjRPYVNab2ZKc2R3UHVnbGpQWGlLZVc3RElqTFlhZEQxMGN0?=
 =?utf-8?B?ZlBQRldob29QUEplWWhySExWaUtleElacHFKVmJURzZkYjFNWTRhZmVNZjkv?=
 =?utf-8?B?WStLNEFpTXdHOEFDaEI3SWRuRHA0c0RIZ1B4cFdSeE03UFpVU0RUTlptQ0ha?=
 =?utf-8?B?c0hpb3RGUFo3RTdxcXZnMXJsckdGaFBmSVpNK0hFdDdBd3NCY1JObXhTMEkz?=
 =?utf-8?Q?yIEkjihiGRuPHHQ1OnYLYc7jr9/giV/dgWA8He/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf113c8-cbdf-4eae-9442-08d93b7a700a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 03:52:11.3333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEcujoU1yKEZE9KWnu/aH3LCnrboc+d5r4BgS82DO5HyHN3ECVOPjuIQeowBqFCX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/30/2021 8:56 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, June 29, 2021 9:38 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amd/pm: update the gpu metrics data
>> retrieving for Sienna Cichlid
>>
>>
>>
>> On 6/25/2021 1:42 PM, Evan Quan wrote:
>>> Due to the structure layout change: "uint32_t ThrottlerStatus" -> "
>>> uint8_t  ThrottlingPercentage[THROTTLER_COUNT]".
>>>
>>> Change-Id: Id5c148b0584d972ae73fb9d7347a312944cec13d
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> ---
>>>    .../pm/inc/smu11_driver_if_sienna_cichlid.h   |  63 ++++-
>>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 234 ++++++++++++---
>> ---
>>>    2 files changed, 222 insertions(+), 75 deletions(-)
>>>
>>> diff --git
>>> a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
>>> b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
>>> index 61c87c39be80..0b916a1933df 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
>>> @@ -211,6 +211,7 @@ typedef enum {
>>>    #define THROTTLER_FIT_BIT          17
>>>    #define THROTTLER_PPM_BIT          18
>>>    #define THROTTLER_APCC_BIT         19
>>> +#define THROTTLER_COUNT            20
>>>
>>>    // FW DState Features Control Bits
>>>    // FW DState Features Control Bits
>>> @@ -1406,7 +1407,67 @@ typedef struct {
>>>    } SmuMetrics_t;
>>>
>>>    typedef struct {
>>> -  SmuMetrics_t SmuMetrics;
>>> +  uint32_t CurrClock[PPCLK_COUNT];
>>> +
>>> +  uint16_t AverageGfxclkFrequencyPreDs;  uint16_t
>>> + AverageGfxclkFrequencyPostDs;  uint16_t AverageFclkFrequencyPreDs;
>>> + uint16_t AverageFclkFrequencyPostDs;  uint16_t
>>> + AverageUclkFrequencyPreDs  ;  uint16_t AverageUclkFrequencyPostDs  ;
>>> +
>>> +
>>> +  uint16_t AverageGfxActivity    ;
>>> +  uint16_t AverageUclkActivity   ;
>>> +  uint8_t  CurrSocVoltageOffset  ;
>>> +  uint8_t  CurrGfxVoltageOffset  ;
>>> +  uint8_t  CurrMemVidOffset      ;
>>> +  uint8_t  Padding8        ;
>>> +  uint16_t AverageSocketPower    ;
>>> +  uint16_t TemperatureEdge       ;
>>> +  uint16_t TemperatureHotspot    ;
>>> +  uint16_t TemperatureMem        ;
>>> +  uint16_t TemperatureVrGfx      ;
>>> +  uint16_t TemperatureVrMem0     ;
>>> +  uint16_t TemperatureVrMem1     ;
>>> +  uint16_t TemperatureVrSoc      ;
>>> +  uint16_t TemperatureLiquid0    ;
>>> +  uint16_t TemperatureLiquid1    ;
>>> +  uint16_t TemperaturePlx        ;
>>> +  uint16_t Padding16             ;
>>> +  uint32_t AccCnt                ;
>>> +  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
>>> +
>>> +
>>> +  uint8_t  LinkDpmLevel;
>>> +  uint8_t  CurrFanPwm;
>>> +  uint16_t CurrFanSpeed;
>>> +
>>> +  //BACO metrics, PMFW-1721
>>> +  //metrics for D3hot entry/exit and driver ARM msgs  uint8_t
>>> + D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
>>> +  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
>>> +  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
>>> +
>>> +  //PMFW-4362
>>> +  uint32_t EnergyAccumulator;
>>> +  uint16_t AverageVclk0Frequency  ;
>>> +  uint16_t AverageDclk0Frequency  ;
>>> +  uint16_t AverageVclk1Frequency  ;
>>> +  uint16_t AverageDclk1Frequency  ;
>>> +  uint16_t VcnActivityPercentage  ; //place holder, David N. to provide full
>> sequence
>>> +  uint8_t  PcieRate               ;
>>> +  uint8_t  PcieWidth              ;
>>> +  uint16_t AverageGfxclkFrequencyTarget;  uint16_t Padding16_2;
>>> +
>>> +} SmuMetrics_V2_t;
>>> +
>>> +typedef struct {
>>> +  union {
>>> +    SmuMetrics_t SmuMetrics;
>>> +    SmuMetrics_V2_t SmuMetrics_V2;
>>> +  };
>>>      uint32_t Spare[1];
>>>
>>>      // Padding - ignore
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> index 0c3407025eb2..f882c6756bf0 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> @@ -80,6 +80,13 @@
>>>    		(*member) = (smu->smu_table.driver_pptable +
>> offsetof(PPTable_t, field));\
>>>    } while(0)
>>>
>>> +#define GET_METRICS_MEMBER(field, member) do { \
>>> +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && (smu-
>>> smc_fw_version >= 0x3A4300)) \
>>> +		(*member) = ((void *)(&(((SmuMetricsExternal_t *)(smu-
>>> smu_table.metrics_table))->SmuMetrics_V2)) + offsetof(SmuMetrics_V2_t,
>> field)); \
>>> +	else \
>>> +		(*member) = ((void *)(&(((SmuMetricsExternal_t
>>> +*)(smu->smu_table.metrics_table))->SmuMetrics)) +
>>> +offsetof(SmuMetrics_t, field)); \ } while(0)
>>> +
>>>    static int get_table_size(struct smu_context *smu)
>>>    {
>>>    	if (smu->adev->asic_type == CHIP_BEIGE_GOBY) @@ -489,13
>> +496,33 @@
>>> static int sienna_cichlid_tables_init(struct smu_context *smu)
>>>    	return -ENOMEM;
>>>    }
>>>
>>> +static uint32_t sienna_cichlid_get_throttler_status_locked(struct
>>> +smu_context *smu) {
>>> +	struct smu_table_context *smu_table= &smu->smu_table;
>>> +	SmuMetricsExternal_t *metrics_ext =
>>> +		(SmuMetricsExternal_t *)(smu_table->metrics_table);
>>> +	uint32_t throttler_status = 0;
>>> +	int i;
>>> +
>>> +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) &&
>>> +	     (smu->smc_fw_version >= 0x3A4300)) {
>>> +		for (i = 0; i < THROTTLER_COUNT; i++) {
>>> +			if (metrics_ext-
>>> SmuMetrics_V2.ThrottlingPercentage[i])
>>> +				throttler_status |= 1U << i;
>>> +		}
>>> +	} else {
>>> +		throttler_status = metrics_ext->SmuMetrics.ThrottlerStatus;
>>> +	}
>>> +
>>> +	return throttler_status;
>>> +}
>>> +
>>>    static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>>>    					       MetricsMember_t member,
>>>    					       uint32_t *value)
>>>    {
>>> -	struct smu_table_context *smu_table= &smu->smu_table;
>>> -	SmuMetrics_t *metrics =
>>> -		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
>>> SmuMetrics);
>>> +	uint32_t *data_u32;
>>> +	uint16_t *data_u16;
>>>    	int ret = 0;
>>>
>>>    	mutex_lock(&smu->metrics_lock);
>>> @@ -510,78 +537,100 @@ static int
>>> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>>>
>>>    	switch (member) {
>>>    	case METRICS_CURR_GFXCLK:
>>> -		*value = metrics->CurrClock[PPCLK_GFXCLK];
>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>
>> One problem with this style is the need to track the datatype of each field.
>> Why not use the old style?
>>
>> metricsv1? metricsv1->field : metricsv2->field;
> [Quan, Evan] With that, there will be too many "if{}else{}".  Also I see there seems coming some new changes for the metrics table. I'm afraid the situation will be worse in the further.
> With this macro way, we can keep the code clean and tidy.

I was talking about something like this, not with if..else. v1 or v2 is 
assigned to be non-null based on FW version check.

*value = metricsv1? metricsv1->CurrClock[PPCLK_GFXCLK]: 
metricsv2->CurrClock[PPCLK_GFXCLK];

The number of condition checks are same with the macro as well (it only 
hides it and probably this one also may be hidden using a macro). The 
problem is if newer datastructure changes the datatype of a field, then 
the current macro won't be reliable. Anyway, if there are more changes 
expected in the metrics table, let's wait.

Thanks,
Lijo

> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> +		*value = data_u32[PPCLK_GFXCLK];
>>>    		break;
>>>    	case METRICS_CURR_SOCCLK:
>>> -		*value = metrics->CurrClock[PPCLK_SOCCLK];
>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>> +		*value = data_u32[PPCLK_SOCCLK];
>>>    		break;
>>>    	case METRICS_CURR_UCLK:
>>> -		*value = metrics->CurrClock[PPCLK_UCLK];
>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>> +		*value = data_u32[PPCLK_UCLK];
>>>    		break;
>>>    	case METRICS_CURR_VCLK:
>>> -		*value = metrics->CurrClock[PPCLK_VCLK_0];
>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>> +		*value = data_u32[PPCLK_VCLK_0];
>>>    		break;
>>>    	case METRICS_CURR_VCLK1:
>>> -		*value = metrics->CurrClock[PPCLK_VCLK_1];
>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>> +		*value = data_u32[PPCLK_VCLK_1];
>>>    		break;
>>>    	case METRICS_CURR_DCLK:
>>> -		*value = metrics->CurrClock[PPCLK_DCLK_0];
>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>> +		*value = data_u32[PPCLK_DCLK_0];
>>>    		break;
>>>    	case METRICS_CURR_DCLK1:
>>> -		*value = metrics->CurrClock[PPCLK_DCLK_1];
>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>> +		*value = data_u32[PPCLK_DCLK_1];
>>>    		break;
>>>    	case METRICS_CURR_DCEFCLK:
>>> -		*value = metrics->CurrClock[PPCLK_DCEFCLK];
>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>> +		*value = data_u32[PPCLK_DCEFCLK];
>>>    		break;
>>>    	case METRICS_CURR_FCLK:
>>> -		*value = metrics->CurrClock[PPCLK_FCLK];
>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>> +		*value = data_u32[PPCLK_FCLK];
>>>    		break;
>>>    	case METRICS_AVERAGE_GFXCLK:
>>> -		if (metrics->AverageGfxActivity <=
>> SMU_11_0_7_GFX_BUSY_THRESHOLD)
>>> -			*value = metrics->AverageGfxclkFrequencyPostDs;
>>> +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
>>> +		if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
>>> +
>> 	GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs,
>> &data_u16);
>>>    		else
>>> -			*value = metrics->AverageGfxclkFrequencyPreDs;
>>> +
>> 	GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs,
>> &data_u16);
>>> +		*value = *data_u16;
>>>    		break;
>>>    	case METRICS_AVERAGE_FCLK:
>>> -		*value = metrics->AverageFclkFrequencyPostDs;
>>> +		GET_METRICS_MEMBER(AverageFclkFrequencyPostDs,
>> &data_u16);
>>> +		*value = *data_u16;
>>>    		break;
>>>    	case METRICS_AVERAGE_UCLK:
>>> -		*value = metrics->AverageUclkFrequencyPostDs;
>>> +		GET_METRICS_MEMBER(AverageUclkFrequencyPostDs,
>> &data_u16);
>>> +		*value = *data_u16;
>>>    		break;
>>>    	case METRICS_AVERAGE_GFXACTIVITY:
>>> -		*value = metrics->AverageGfxActivity;
>>> +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
>>> +		*value = *data_u16;
>>>    		break;
>>>    	case METRICS_AVERAGE_MEMACTIVITY:
>>> -		*value = metrics->AverageUclkActivity;
>>> +		GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
>>> +		*value = *data_u16;
>>>    		break;
>>>    	case METRICS_AVERAGE_SOCKETPOWER:
>>> -		*value = metrics->AverageSocketPower << 8;
>>> +		GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
>>> +		*value = *data_u16 << 8;
>>>    		break;
>>>    	case METRICS_TEMPERATURE_EDGE:
>>> -		*value = metrics->TemperatureEdge *
>>> +		GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
>>> +		*value = *data_u16 *
>>>    			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>>>    		break;
>>>    	case METRICS_TEMPERATURE_HOTSPOT:
>>> -		*value = metrics->TemperatureHotspot *
>>> +		GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
>>> +		*value = *data_u16 *
>>>    			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>>>    		break;
>>>    	case METRICS_TEMPERATURE_MEM:
>>> -		*value = metrics->TemperatureMem *
>>> +		GET_METRICS_MEMBER(TemperatureMem, &data_u16);
>>> +		*value = *data_u16 *
>>>    			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>>>    		break;
>>>    	case METRICS_TEMPERATURE_VRGFX:
>>> -		*value = metrics->TemperatureVrGfx *
>>> +		GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
>>> +		*value = *data_u16 *
>>>    			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>>>    		break;
>>>    	case METRICS_TEMPERATURE_VRSOC:
>>> -		*value = metrics->TemperatureVrSoc *
>>> +		GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
>>> +		*value = *data_u16 *
>>>    			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>>>    		break;
>>>    	case METRICS_THROTTLER_STATUS:
>>> -		*value = metrics->ThrottlerStatus;
>>> +		*value = sienna_cichlid_get_throttler_status_locked(smu);
>>>    		break;
>>>    	case METRICS_CURR_FANSPEED:
>>> -		*value = metrics->CurrFanSpeed;
>>> +		GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
>>> +		*value = *data_u16;
>>>    		break;
>>>    	default:
>>>    		*value = UINT_MAX;
>>> @@ -3564,68 +3613,103 @@ static ssize_t
>> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>>>    	struct smu_table_context *smu_table = &smu->smu_table;
>>>    	struct gpu_metrics_v1_3 *gpu_metrics =
>>>    		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>>> -	SmuMetricsExternal_t metrics_external;
>>> -	SmuMetrics_t *metrics =
>>> -		&(metrics_external.SmuMetrics);
>>> -	struct amdgpu_device *adev = smu->adev;
>>> -	uint32_t smu_version;
>>> +	uint32_t *data_u32;
>>> +	uint16_t *data_u16;
>>> +	uint8_t *data_u8;
>>>    	int ret = 0;
>>>
>>> -	ret = smu_cmn_get_metrics_table(smu,
>>> -					&metrics_external,
>>> -					true);
>>> -	if (ret)
>>> +	mutex_lock(&smu->metrics_lock);
>>> +
>>> +	ret = smu_cmn_get_metrics_table_locked(smu,
>>> +					       NULL,
>>> +					       true);
>>> +	if (ret) {
>>> +		mutex_unlock(&smu->metrics_lock);
>>>    		return ret;
>>> +	}
>>>
>>>    	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>
>>> -	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
>>> -	gpu_metrics->temperature_hotspot = metrics-
>>> TemperatureHotspot;
>>> -	gpu_metrics->temperature_mem = metrics->TemperatureMem;
>>> -	gpu_metrics->temperature_vrgfx = metrics->TemperatureVrGfx;
>>> -	gpu_metrics->temperature_vrsoc = metrics->TemperatureVrSoc;
>>> -	gpu_metrics->temperature_vrmem = metrics-
>>> TemperatureVrMem0;
>>> +	GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
>>> +	gpu_metrics->temperature_edge = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
>>> +	gpu_metrics->temperature_hotspot = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(TemperatureMem, &data_u16);
>>> +	gpu_metrics->temperature_mem = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
>>> +	gpu_metrics->temperature_vrgfx = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
>>> +	gpu_metrics->temperature_vrsoc = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(TemperatureVrMem0, &data_u16);
>>> +	gpu_metrics->temperature_vrmem = *data_u16;
>>>
>>> -	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
>>> -	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
>>> -	gpu_metrics->average_mm_activity = metrics-
>>> VcnActivityPercentage;
>>> +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
>>> +	gpu_metrics->average_gfx_activity = *data_u16;
>>>
>>> -	gpu_metrics->average_socket_power = metrics-
>>> AverageSocketPower;
>>> -	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
>>> +	GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
>>> +	gpu_metrics->average_umc_activity = *data_u16;
>>>
>>> -	if (metrics->AverageGfxActivity <=
>> SMU_11_0_7_GFX_BUSY_THRESHOLD)
>>> -		gpu_metrics->average_gfxclk_frequency = metrics-
>>> AverageGfxclkFrequencyPostDs;
>>> +	GET_METRICS_MEMBER(VcnActivityPercentage, &data_u16);
>>> +	gpu_metrics->average_mm_activity = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
>>> +	gpu_metrics->average_socket_power = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(EnergyAccumulator, &data_u32);
>>> +	gpu_metrics->energy_accumulator = *data_u32;
>>> +
>>> +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
>>> +	if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
>>> +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs,
>> &data_u16);
>>>    	else
>>> -		gpu_metrics->average_gfxclk_frequency = metrics-
>>> AverageGfxclkFrequencyPreDs;
>>> -	gpu_metrics->average_uclk_frequency = metrics-
>>> AverageUclkFrequencyPostDs;
>>> -	gpu_metrics->average_vclk0_frequency = metrics-
>>> AverageVclk0Frequency;
>>> -	gpu_metrics->average_dclk0_frequency = metrics-
>>> AverageDclk0Frequency;
>>> -	gpu_metrics->average_vclk1_frequency = metrics-
>>> AverageVclk1Frequency;
>>> -	gpu_metrics->average_dclk1_frequency = metrics-
>>> AverageDclk1Frequency;
>>> -
>>> -	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
>>> -	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
>>> -	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
>>> -	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
>>> -	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
>>> -	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];
>>> -	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
>>> -
>>> -	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
>>> +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs,
>> &data_u16);
>>> +	gpu_metrics->average_gfxclk_frequency = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(AverageUclkFrequencyPostDs, &data_u16);
>>> +	gpu_metrics->average_uclk_frequency = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(AverageVclk0Frequency, &data_u16);
>>> +	gpu_metrics->average_vclk0_frequency = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(AverageDclk0Frequency, &data_u16);
>>> +	gpu_metrics->average_dclk0_frequency = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(AverageVclk1Frequency, &data_u16);
>>> +	gpu_metrics->average_vclk1_frequency = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(AverageDclk1Frequency, &data_u16);
>>> +	gpu_metrics->average_dclk1_frequency = *data_u16;
>>> +
>>> +	GET_METRICS_MEMBER(CurrClock, &data_u32);
>>> +	gpu_metrics->current_gfxclk = data_u32[PPCLK_GFXCLK];
>>> +	gpu_metrics->current_socclk = data_u32[PPCLK_SOCCLK];
>>> +	gpu_metrics->current_uclk = data_u32[PPCLK_UCLK];
>>> +	gpu_metrics->current_vclk0 = data_u32[PPCLK_VCLK_0];
>>> +	gpu_metrics->current_dclk0 = data_u32[PPCLK_DCLK_0];
>>> +	gpu_metrics->current_vclk1 = data_u32[PPCLK_VCLK_1];
>>> +	gpu_metrics->current_dclk1 = data_u32[PPCLK_DCLK_1];
>>> +
>>> +	gpu_metrics->throttle_status =
>>> +			sienna_cichlid_get_throttler_status_locked(smu);
>>>    	gpu_metrics->indep_throttle_status =
>>> -			smu_cmn_get_indep_throttler_status(metrics-
>>> ThrottlerStatus,
>>> +			smu_cmn_get_indep_throttler_status(gpu_metrics-
>>> throttle_status,
>>>
>> sienna_cichlid_throttler_map);
>>>
>>> -	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
>>> +	GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
>>> +	gpu_metrics->current_fan_speed = *data_u16;
>>>
>>> -	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
>>> -	if (ret)
>>> -		return ret;
>>> +	if (((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && smu-
>>> smc_fw_version > 0x003A1E00) ||
>>> +	      ((smu->adev->asic_type == CHIP_NAVY_FLOUNDER) && smu-
>>> smc_fw_version > 0x00410400)) {
>>> +		GET_METRICS_MEMBER(PcieWidth, &data_u8);
>>> +		gpu_metrics->pcie_link_width = *data_u8;
>>>
>>> -	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version >
>> 0x003A1E00) ||
>>> -	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version >
>> 0x00410400)) {
>>> -		gpu_metrics->pcie_link_width = metrics->PcieWidth;
>>> -		gpu_metrics->pcie_link_speed = link_speed[metrics-
>>> PcieRate];
>>> +		GET_METRICS_MEMBER(PcieRate, &data_u8);
>>> +		gpu_metrics->pcie_link_speed = link_speed[*data_u8];
>>>    	} else {
>>>    		gpu_metrics->pcie_link_width =
>>>
>> 	smu_v11_0_get_current_pcie_link_width(smu);
>>> @@ -3633,6 +3717,8 @@ static ssize_t
>> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>>>
>> 	smu_v11_0_get_current_pcie_link_speed(smu);
>>>    	}
>>>
>>> +	mutex_unlock(&smu->metrics_lock);
>>> +
>>>    	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>>>
>>>    	*table = (void *)gpu_metrics;
>>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

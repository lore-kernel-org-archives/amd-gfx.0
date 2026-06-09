Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E90CD8C92
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 12:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D437310E294;
	Tue,  9 Jun 2026 12:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2hUer9VE";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010007.outbound.protection.outlook.com
 [40.93.198.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF7310E294
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 12:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcFBEGAe+Z5ozKkdSro/lk3KJTntm/xMTZXzFjKrdNPSUbBggJ9FkW3TTmXu07H1VhyupZmDc3K+l7HPQzssuIQCd2Hd9yQ3tFfgnCSP1Y3PIrdgN+avojWEZjDe9eh1Nh2n1mWTqW+vGl5nh5Dw1/FJRVViCe02QddAgtF2YQxWS5ZrxW3Gs3RZINs1xHwMDEzhI7u8Nxem88p0zN4lr3FfHhYyOYpTol8onxHc7TS4sYFKLOXXXLFnDz73eg7SOBI7zoEHz8BXBlhMiklrHR1VINfldU7U7y44kIARQliM1ZDbLogrEKUz9vdebcRxB4MBEsm7vCqONIWyyFBnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MN4gCp91EXBja6tPy/YAqCmWdrBi2FZFlfvHUnluQnI=;
 b=vC5x73rBKHjNM7eTAXt1mx4jUbdFmoSKcXD2lLa22wXax2a03cD3TbCForKd2iRhW8AUq/mfXHDRmcN/hAiXs2uQ6dIRqbGfXbxchYELMD03dkxCc9/J9wLlIbtKM9l5APscbxqfeZQWsdNIPcfy55FQfOMSLzOOckj2NSQM4jgQwbnkUW/jsJcnc2GtZO/8YDEV0n7RJ3sPtRsTfbpZUI/31tI3mY3HjHB/SSokcLZW0z1ej61AiuEcIw1Rx/loBmDj4R3t4luwi+HB7BhtOWKL6v1pcqQI1V8lwUxaKOgQci4YHUWF9kxuEj9AaCX9vzLU48XJ+goBGecWkr4J4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN4gCp91EXBja6tPy/YAqCmWdrBi2FZFlfvHUnluQnI=;
 b=2hUer9VEhIf3HqiDH7bmvP90vFn+rIzlnoMYOVBd9MkelgZ+d6di1rgkgziQlS0yixTPCoe6gpFY+EE1TKeLRF9722u3epjg/2jS12ZLTHTDthiyuJSfVTKNqNYev4p+zxIpeBFg4bFr5oF3mA1u1dxgrkQLVb29pgyYsxK+scE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 12:20:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 12:20:36 +0000
Message-ID: <09795f1b-43c9-4aac-a652-01bff8b98d81@amd.com>
Date: Tue, 9 Jun 2026 17:50:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reporting
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Liu, Shuzhou (Bill)" <Shuzhou.Liu@amd.com>,
 "Arif, Maisam" <Maisam.Arif@amd.com>
References: <20260609065123.215816-1-kevinyang.wang@amd.com>
 <6cb5a3be-8cf1-4ce5-8ce9-a6fb363b12fa@amd.com>
 <DM6PR12MB29726384D65C1D1B41A04415821D2@DM6PR12MB2972.namprd12.prod.outlook.com>
 <e3c720a6-497d-43aa-bf7a-0835fc0d799a@amd.com>
 <DM6PR12MB2972ECD8FDD8874557E8EFE3821D2@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2972ECD8FDD8874557E8EFE3821D2@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0145.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: b83100c9-77f9-4f89-8f02-08dec621828b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|56012099006|4143699003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 00zgeGOn3Yifvooyx+c4xA4AE7C3JRG6loaESs3IQgHVm3y920QTa/edEAXtXJQ6Fka5aejPKoNZMPABCW+heGITGomgEofD0Mu931TfI195jVmaDuwmIiG2JBOucXSAjq+CxyueDjqcfis3GvP5h6reUiEwBrTZPvsS3e2pFqJYZTBoMb2Uqt2Bn7QzmPoE3NFFGYkHlQCTPmZldj6h2Xm+SvKBpP9FlgAYxO7Ff/wx4ZJV91H69Tc0cECPmaqJ5ngEhtBtU4ginYDDHk6svvNmI0B5oAy+J9WHgYf+DKPMwDzM6pVzZSIbcbCyHn6N67W20gEe6DTnF9td6uKh5tN1BSJwX6JN3GH4eFAUYkkPdLE4A07+NC5ye+o3mmU6VcvY8wqtg2mlsJTSm6QHd3ZRYsKPfjPCTp3QTnoJuN3jfIxQh0zRIlNLffhFoy8/avTVySfI7ljy5ExCjWG11HcMGo2Sruqgb5OXAMntB6euYNsSM7RV5uLgtB70slUUHZmPUUyoSEJRmvYwuuBB4gVYjTYMjWBuCGsQMmMotnVkBELSxVCb1ttV7/f98WiUZYhGIwcxxzrDgIBKGoN5IsxEHlsm3twVgLsTmQrQOdt8O81PDgEVGstMCWuC91rYHp0gTgHghKUV6x/5qslICWu2u8wmyc4PRJPTVtw8yWNdDDkwu0xEy0tV9fdkPpu3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZ1N0JieVUxeU1VM0RvOFFJYU1qNy9vdmNTcmpOYWRyUzExTFdpUys0MkNo?=
 =?utf-8?B?SHdaOHp3WUVVYkg5Ykd6RURlVEptNnRWRUhyaFZBODk2UUVENUVYNVlDTzRh?=
 =?utf-8?B?STljRGVZWUZZNExiZURVMGNvZ1ZiMjlFYTF1NzN6MUZSVTR3VEJ6UW1xS21Y?=
 =?utf-8?B?bENxeEJnb0Y4RFdiZTl1MmFZa09oa01oZDVxekFnUHR0MTZncW1LTUtqSEVW?=
 =?utf-8?B?N0lINmJjYmFkU3h2c3QrQVNOam5WajVXNGZNNllOZkE5M29hL0Z1WWJsU2Fs?=
 =?utf-8?B?L3UyeUF6SFV1SXJFSTFwdUhjN2lFcEVhRWwrZis0VFdwQkxMSzFRU0dOOUpW?=
 =?utf-8?B?Y1VwZ3ZLdDdBeWVFZVhuc3VXNGhvZlJ4QjM5a3gzaTlNZFRXcWFhbVlTZXdq?=
 =?utf-8?B?Nm4wbVllTTh2akYzcjVsUDBUeU5Demdpc0wxNmM5YkRHSjhVTy80VUJwZlNt?=
 =?utf-8?B?MGRSRGRseXpHYjBrYjMrcXpJbGVFMk1CVGp1VGFBWlpPTGJwdWJqSi96a0dr?=
 =?utf-8?B?VnFPZ1llM3dTYlBRejhwemFXbXQ0aEt1SGExbHpMbHRwcUNpVDdWYkp4c1Vy?=
 =?utf-8?B?ckhod2ZLNFA1ZytHaVMvcUVkeEt3VlFzVERRWXNYampTc1RWTjQ1eDE4Y3BD?=
 =?utf-8?B?WXkzTXBJK0Z1VXovR1RLTG9wbXRqWm9RMVdnLzBUVVRMTDJlUTQ5eWJsSFRX?=
 =?utf-8?B?WEdKZnFhTDFpdGNRN0ZuNFZlZ05aSGNGYndieGlaU1AzOGRYMDhFQzJTMit5?=
 =?utf-8?B?NndGRzd2M21tQy9GRkFCZUFuQmZvZzh5d3ZST0JKMXFlcU8rVEpESmh5Wm82?=
 =?utf-8?B?Vk9Wc1hVemJ0bEdnVUpUbEpibVR1Sm9waHlYVzhiU0pwNFNCZU1lc28zUFpT?=
 =?utf-8?B?clR3RUxoTDAxVDdZN0xvUy9pOVkxN1Q4aGVoWUFlZkZHVkJ1QmdVNFRxWWQ5?=
 =?utf-8?B?QldhbUJRcDlQTk9HQVo3YXlSVWFnZE9ZbWY3d2dDcldVMHZKTG5PcTBVNm9S?=
 =?utf-8?B?WFdqdUI3T3pyM3NSTUhuU283SU9UVXJsUGtQbDVzTDYxNjNHeXhuWXZpeEdx?=
 =?utf-8?B?VEVKU0VsU0s0cVROWngwS0JuYlYxREsrSG9IODZGTElVdytWUWZ3U1FQamJO?=
 =?utf-8?B?MVg0aVk3SU1LckhocEI3dG0rSGZIZkU4WXFleW1JMy9pNjJQczRqT1pwT3Jz?=
 =?utf-8?B?djAxbGVOSlhTaHlSV1RGOGRTWGFSZDZkaWR5NVArMXdNcGxpT2U3R0tjVC9i?=
 =?utf-8?B?eERXT0MrMlBORm9kM0xqcEdyZUpONGJPTWpTM3NFLzNvWEJnd2lMa3gzMUVi?=
 =?utf-8?B?V2F0UHdHS1FHQU95S25BUmFFMjByUnluQU5TdU03QitkRXNqUFpXelZPUjF2?=
 =?utf-8?B?K1RiRTVobDlLODJTNlhnSWRYM0NSOGpZZkhEaVdFeWhGZ0dLSjlsUDI5UjFH?=
 =?utf-8?B?bi9VNk9rU0ttUDdWZ3UxWFVNN2JyZ1VCN3NydUZOR0htZk9BYjFTa2RRamZT?=
 =?utf-8?B?aCs1NlhEZjhscVJsM3lzT20rbXkrMkVMeFp2ZG0zbHlIRXBUYzVKRGUydDJo?=
 =?utf-8?B?QXQ1RmZJa0ViMHp1NkwwMFZSVnhLdGRjNVIvbWs1SzZBWXQ2b0xMd29Ha1FO?=
 =?utf-8?B?NDZVTnJ2V3FlNU15Z1pzSk43emFsQTBvMHRaMjM5TUY5aUdna2tNZ0VpZ0Zi?=
 =?utf-8?B?TDViQzBvUzVud2ZyOVduV2NLYit5K0NhTTZnREJpejZwVE5LVUtEd2hMZnpy?=
 =?utf-8?B?aDZVbGtNdGVnYXl3VExVdFBLUmRUblNSM2tsbElGZlQzQU9RY3F1N0dxbkRo?=
 =?utf-8?B?cGQ0Q2FNL2lPRkFRUjhUL0RNQTVlNDZkOGRiQWJpZ280dUJ1OVNrb2JPOUxl?=
 =?utf-8?B?UlJ5TzlRS0lIU28vVXg5M1VMSzhyN2J5YlJnRE5HNUZOK0Uvek93NFBUNEI2?=
 =?utf-8?B?N3lUVTJLbU1EbGRyY2N2c3ExQmF4K1o3NStRQWNvRklybW5mSjBNTHZBOG1y?=
 =?utf-8?B?SEpPYzFJaWtlbExJRjNCWGRoenpIWXU2OURyR3E0MktnK2hBbEZnUmNrWmdp?=
 =?utf-8?B?eVF2cVhIUjUxMEpLU1VkQyt4N1RIdVc4YWNiZFQ4bkxBRTBPT1dOVS83b3JB?=
 =?utf-8?B?LzYrdnpwUWxudjg3Q0NrNWpOYUFLZDJLZmd0TFBvTUVpTXA2bWFreGJscXpv?=
 =?utf-8?B?UlkvN3d1RnhVbnE3UU5ubWV1dTAxTW5DVkVWTUJ3QmNCcXp2WmtKTW9ia2RB?=
 =?utf-8?B?UTRvWmlabWxYS2pOc3NBOU1LWWZsbHNVbEZyRm9QSkNSd1RTd3Bka0o5eUdl?=
 =?utf-8?B?Z0FEaU5CQmtmUG14VFVMMDZmWXZwaThXdGNIb1RHUWlSWjJkeW96QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83100c9-77f9-4f89-8f02-08dec621828b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 12:20:36.4275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKdfWtyd0MWPiIFYCZTAwcMKAB27bDKei0bDZpeCgOSFa/wC64dReuOm09PEnnIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411
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



On 09-Jun-26 5:35 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, June 9, 2026 7:12 PM
>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
>> Liu, Shuzhou (Bill) <Shuzhou.Liu@amd.com>; Arif, Maisam
>> <Maisam.Arif@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reporting
>>
>>
>>
>> On 09-Jun-26 3:49 PM, Wang, Yang(Kevin) wrote:
>>> AMD General
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Tuesday, June 9, 2026 4:11 PM
>>>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>>>> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
>>>> Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reporting
>>>>
>>>>
>>>>
>>>> On 09-Jun-26 12:21 PM, Yang Wang wrote:
>>>>> Refactor smu_cmn_print_dpm_clk_levels() to build clock entries
>>>>> before emitting sysfs output.
>>>>>
>>>>> For discrete DPM tables, mark the level closest to the reported
>>>>> current clock. This avoids losing the active '*' marker when the
>>>>> SMU-reported clock does not fall within the previous fixed tolerance.
>>>>>
>>>>> Keep fine-grained output explicit by reporting the current clock on
>>>>> an 'F' line, and keep deep sleep represented by the 'S' line without
>>>>> marking a discrete level.
>>>>>
>>>>> Active marker placement:
>>>>>
>>>>> | Mode         | '*' marker location       | Reason                    |
>>>>> | ------------ | ------------------------- | ------------------------- |
>>>>> | discrete     | closest/current DPM level | entries are real levels   |
>>>>> | fine-grained | 'F:' current clock line   | min/max are range bounds  |
>>>>> | deep sleep   | 'S:' line                 | outside normal DPM range  |
>>>>>
>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5295
>>>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 148
>> +++++++++++++++++--
>>>> ------
>>>>>     1 file changed, 101 insertions(+), 47 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> index d365f06ac1ac..872c0328f290 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> @@ -1376,77 +1376,131 @@ void smu_cmn_reset_custom_level(struct
>>>> smu_context *smu)
>>>>>       pstate_table->uclk_pstate.custom.max = 0;
>>>>>     }
>>>>>
>>>>> -static inline bool smu_cmn_freqs_match(uint32_t freq1, uint32_t
>>>>> freq2)
>>>>> +struct smu_clk_print_entry {
>>>>> +   uint32_t freq;
>>>>> +   bool selected;
>>>>> +};
>>>>> +
>>>>> +static inline uint32_t smu_cmn_freq_distance(uint32_t freq1,
>>>>> +uint32_t
>>>>> +freq2) {
>>>>> +   return freq1 > freq2 ? freq1 - freq2 : freq2 - freq1; }
>>>>> +
>>>>> +static inline uint32_t smu_cmn_get_dpm_level_count(struct
>>>>> +smu_dpm_table *dpm_table) {
>>>>> +   return min_t(uint32_t, dpm_table->count,
>>>> SMU_MAX_DPM_LEVELS); }
>>>>> +
>>>>> +static uint32_t smu_cmn_get_closest_clk_level(struct smu_dpm_table
>>>>> +*dpm_table, uint32_t cur_clk) {
>>>>> +   uint32_t min_distance, distance;
>>>>> +   uint32_t closest_level = 0;
>>>>> +   uint32_t count;
>>>>> +   uint32_t i;
>>>>> +
>>>>> +   count = smu_cmn_get_dpm_level_count(dpm_table);
>>>>> +   if (!count)
>>>>> +           return SMU_MAX_DPM_LEVELS;
>>>>> +
>>>>> +   min_distance = smu_cmn_freq_distance(cur_clk, dpm_table-
>>>>> dpm_levels[0].value);
>>>>> +   for (i = 1; i < count; i++) {
>>>>> +           distance = smu_cmn_freq_distance(cur_clk, dpm_table-
>>>>> dpm_levels[i].value);
>>>>> +           if (distance < min_distance) {
>>>>> +                   min_distance = distance;
>>>>> +                   closest_level = i;
>>>>> +           }
>>>>> +   }
>>>>> +
>>>>> +   return closest_level;
>>>>> +}
>>>>> +
>>>>> +static inline int smu_cmn_emit_clk_line(char *buf, int size,
>>>>> +                                   int level_index, uint32_t freq,
>>>>> +bool
>>>> selected) {
>>>>> +   return sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
>>>>> +                        level_index, freq, selected ? "*" : ""); }
>>>>> +
>>>>> +static void smu_cmn_build_fine_grained_levels(uint32_t min_clk,
>>>>> +uint32_t
>>>> max_clk,
>>>>> +                                         struct smu_clk_print_entry
>>>> *entries,
>>>>> +                                         uint32_t *entry_count) {
>>>>> +   *entry_count = 2;
>>>>> +   entries[0].freq = min_clk;
>>>>> +   entries[0].selected = false;
>>>>> +   entries[1].freq = max_clk;
>>>>> +   entries[1].selected = false;
>>>>> +}
>>>>> +
>>>>> +static void smu_cmn_build_discrete_levels(struct smu_dpm_table
>>>> *dpm_table,
>>>>> +                                     uint32_t selected_level,
>>>>> +                                     struct smu_clk_print_entry *entries,
>>>>> +                                     uint32_t *entry_count) {
>>>>> +   uint32_t i;
>>>>> +
>>>>> +   *entry_count = smu_cmn_get_dpm_level_count(dpm_table);
>>>>> +
>>>>> +   for (i = 0; i < *entry_count; i++) {
>>>>> +           entries[i].freq = dpm_table->dpm_levels[i].value;
>>>>> +           entries[i].selected = (i == selected_level);
>>>>> +   }
>>>>> +}
>>>>> +
>>>>> +static int smu_cmn_emit_clk_prefix(char *buf, int size,
>>>>> +                              bool is_fine_grained, bool is_deep_sleep,
>>>>> +                              uint32_t cur_clk)
>>>>>     {
>>>>> -   /* Frequencies within 25 MHz are considered equal */
>>>>> -   return (abs((int)freq1 - (int)freq2) <= 25);
>>>>> +   if (is_deep_sleep)
>>>>> +           size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
>>>>> +   else if (is_fine_grained)
>>>>> +           size += sysfs_emit_at(buf, size, "F: %uMhz *\n",
>>>>> + cur_clk);
>>>>
>>>> What about keeping the else part as C: <cur_clk> in all cases -
>>>> instead of just fine grained? * indicates the closest level matched
>>>> and cur_clk will give the exact frequency.
>>>>
>>>> Thanks,
>>>> Lijo
>>>
>>> This is a good idea. However, for now I'd like to retain the existing logic to
>> stay compatible with current parsing tools and prevent potential regressions.
>>> Also, note that "F" and "S" are optional labels, which are only shown for
>> unmatched DPM LEVEL entries.
>>>
>>
>> +Bill/Maisam
>>
>> What about the case when current clock matches min/max in fine grained
>> scenario? In the new logic, F is the label for current clock always for fine
>> grained clocks which is a deviation from the old logic. Is that to always show 3
>> levels in fine grained?
>>
>> Thanks,
>> Lijo
> 
>>> Is that to always show 3 levels in fine grained?
> yes, this part indeed works differently from the prior logic.
> 
> The major problem with the current fine-grained implementation is that when the current clock does not hit min/max, the current clock is shown current clock at position "1" (total 3 lines output)
> This tends to confuse users, who may wonder whether to use position 1 or 2 to set the maximum value, but 1 is expected value by driver.
> Therefore, this is one of the issues addressed by this patch.
> 
> Back to your question: Either adopting a fixed 3-level display or retaining the old logic is reasonable ( which one is your prefer ?)
> The label "F" stands for both fine-grained and frequency.
> 

I prefer the new approach to separate out current clock from the levels.

For ex: user space sees F label, uses the value as current clock. Rest 
of them used for level information. If it doesn't see F, try to parse 
the legacy way.

Alex, do you have any comments?

As a minimal representation of user space -
	Bill/Arif, is it possible to have this changed in amd-smi?

Thanks,
Lijo

> Best Regards,
> Kevin
>>
>>> Best Regards,
>>> Kevin
>>>>
>>>>> +
>>>>> +   return size;
>>>>>     }
>>>>>
>>>>>     int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
>>>>>                                struct smu_dpm_table *dpm_table,
>>>>>                                uint32_t cur_clk, char *buf, int *offset)
>>>>>     {
>>>>> -   uint32_t min_clk, max_clk, level_index, count;
>>>>> -   uint32_t freq_values[3];
>>>>> -   int size, lvl, i;
>>>>> +   struct smu_clk_print_entry entries[SMU_MAX_DPM_LEVELS];
>>>>> +   uint32_t min_clk, max_clk, count, entry_count = 0;
>>>>> +   uint32_t selected_level = SMU_MAX_DPM_LEVELS;
>>>>> +   int size, i;
>>>>>       bool is_fine_grained;
>>>>>       bool is_deep_sleep;
>>>>> -   bool freq_match;
>>>>>
>>>>>       if (!dpm_table || !buf)
>>>>>               return -EINVAL;
>>>>>
>>>>> -   level_index = 0;
>>>>>       size = *offset;
>>>>> -   count = dpm_table->count;
>>>>>       is_fine_grained = dpm_table->flags &
>>>> SMU_DPM_TABLE_FINE_GRAINED;
>>>>> -   min_clk = SMU_DPM_TABLE_MIN(dpm_table);
>>>>> -   max_clk = SMU_DPM_TABLE_MAX(dpm_table);
>>>>> +   count = smu_cmn_get_dpm_level_count(dpm_table);
>>>>> +   min_clk = count ? dpm_table->dpm_levels[0].value : 0;
>>>>> +   max_clk = count ? dpm_table->dpm_levels[count - 1].value : 0;
>>>>>
>>>>>       /* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0
>>>>> as
>>>> GFXOFF */
>>>>>       is_deep_sleep = cur_clk < min_clk / 2;
>>>>> -   if (is_deep_sleep) {
>>>>> -           size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
>>>>> -           level_index = 1;
>>>>> -   }
>>>>>
>>>>>       if (!is_fine_grained || count == 1) {
>>>>> -           for (i = 0; i < count; i++) {
>>>>> -                   freq_match = !is_deep_sleep &&
>>>>> -                                smu_cmn_freqs_match(
>>>>> -                                        cur_clk,
>>>>> -                                        dpm_table->dpm_levels[i].value);
>>>>> -                   size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
>>>>> -                                         level_index + i,
>>>>> -                                         dpm_table->dpm_levels[i].value,
>>>>> -                                         freq_match ? "*" : "");
>>>>> +           if (!is_deep_sleep) {
>>>>> +                   selected_level =
>>>>> +                           smu_cmn_get_closest_clk_level(dpm_table,
>>>> cur_clk);
>>>>>               }
>>>>> +           smu_cmn_build_discrete_levels(dpm_table, selected_level,
>>>>> +                                                 entries,
>>>>> + &entry_count);
>>>>>       } else {
>>>>> -           count = 2;
>>>>> -           freq_values[0] = min_clk;
>>>>> -           freq_values[1] = max_clk;
>>>>> +           smu_cmn_build_fine_grained_levels(min_clk, max_clk,
>>>>> +                                             entries, &entry_count);
>>>>> +   }
>>>>>
>>>>> -           if (!is_deep_sleep) {
>>>>> -                   if (smu_cmn_freqs_match(cur_clk, min_clk)) {
>>>>> -                           lvl = 0;
>>>>> -                   } else if (smu_cmn_freqs_match(cur_clk, max_clk)) {
>>>>> -                           lvl = 1;
>>>>> -                   } else {
>>>>> -                           /* NOTE: use index '1' to show current clock
>>>> value */
>>>>> -                           lvl = 1;
>>>>> -                           count = 3;
>>>>> -                           freq_values[1] = cur_clk;
>>>>> -                           freq_values[2] = max_clk;
>>>>> -                   }
>>>>> -           }
>>>>> +   size = smu_cmn_emit_clk_prefix(buf, size, is_fine_grained,
>>>>> +                                  is_deep_sleep, cur_clk);
>>>>>
>>>>> -           for (i = 0; i < count; i++) {
>>>>> -                   size += sysfs_emit_at(
>>>>> -                           buf, size, "%d: %uMhz %s\n", level_index + i,
>>>>> -                           freq_values[i],
>>>>> -                           (!is_deep_sleep && i == lvl) ? "*" : "");
>>>>> -           }
>>>>> -   }
>>>>> +   for (i = 0; i < entry_count; i++)
>>>>> +           size += smu_cmn_emit_clk_line(buf, size, i,
>>>>> +                                        entries[i].freq,
>>>>> +                                        entries[i].selected);
>>>>>
>>>>>       *offset = size;
>>>>>
>>>
> 


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A301C55167
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 08:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891EF10F1D6;
	Fri, 31 Jul 2026 08:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IrKKQe4d";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090DC10E1D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 08:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3t75jykJQ/idP2wNbQhh7paGXFptrPfsmiknEUVxTBiYC0ZuJmoUoFVZRbpNM+urau8vLee8GSF9AYS/l9gRyOnI1LCRIIkDm1yypm48XDdXmwYs0AldV4+UO0uEWuBymYrLvIM9L4rQJXKCk2CxWsDbzjEQScLVcS8aFYJxBuBCurxhdQ8okLCfMlSGo0Na1V/0bYopJEi3GEBwnUXP2bYlwOlQf24UKn46E4qqjF8NxrpAG4vF5ZvS4HixKWmemDDH286tgPHFBpQgsVfuFiQ1a5YQddEYIdHockXpeMkGoFwpjrMfJv6YFHT5bOCYNH6WmVOR0YeWSVFKp+JuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/6RWspgoUtViJviI7BjUtgcHJqmkIR7G1s/bX7rSC8=;
 b=wWUaYmWuh5yDxcbVy4hCwme4+N9sjeOZaTvyDAvm1WlSNkKdmmYN1vhCkH4dVYXgD+czIW9SF7UmiXnCvs3z9gdStyKEorzAR9rZlXn8L+ZwY4RrHJWIfsc5z0psA71e5atyo1MpzwjG8s5JpN0xy0sgGf0wv0pRxUfOHygwLFssujUBxyHxRX/4OK1KH2xKzU+CxbsoY8ZuQBME817m41M9hhODpTrZzZAEg4AUHAkwiflSAvkl5khRZlD4wyNa6IChnyZjnqu8sgRTViYberXu0qxD9dPpk32v8/DMeUZzmzlmKra2m7NKqjaTdMEOU8wAHDuzKJSMl2/e7VIxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/6RWspgoUtViJviI7BjUtgcHJqmkIR7G1s/bX7rSC8=;
 b=IrKKQe4dnlTcioemfzM5wIiNM0qa5zh2KXnaHeER3QUbCv5IwU5wlJ8rr79/QK2w7QVu8SX9U8pGrkyU9Plxb7y/p99ovkJvduEYJORaIYTGnDYJgzX3WH32KUd02DMbQW/T0tluOBOHusg3mq/j0wkWGe2AOnbH2QBkbs4nXMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 08:25:39 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 08:25:39 +0000
Message-ID: <53ee5e9b-0149-4e43-99c1-f5f87bb63ee3@amd.com>
Date: Fri, 31 Jul 2026 13:55:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amd/pm: refactor user PPT policy save and restore
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <cover.1785467079.git.kevinyang.wang@amd.com>
 <2a1bf8c187a6b6a67169fda0e6551a062af56c77.1785467079.git.kevinyang.wang@amd.com>
 <c4cd5c4c-00e5-41cb-b049-8e668270bbcf@amd.com>
 <BN9PR12MB5211E9C9924BF1CCD56ACF5A82C82@BN9PR12MB5211.namprd12.prod.outlook.com>
 <64d8e874-9b20-4ef7-8b61-9b1fa08a1278@amd.com>
 <BN9PR12MB52114F26DFDDB7845449E15482C82@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN9PR12MB52114F26DFDDB7845449E15482C82@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 3755f1ad-d879-43c0-c32a-08deeedd4dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|5023799004|4143699003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: BWcvAEzC0PjM8/isJwWGPbc/4HN0cN+mvZEjhnEPdyhaZGDUm6p0vHH+WnK4qPBcEcE/iTD+k05egTpgjSNmGt8JCRv4bTNAfZAglb6lu34A8nHBJniQL7BwiJk+UTI478zz3eXt+RReCn4n6DERLFEKWsCoMBNkXV+QQJHQLbCIp7Ie+2tQmRmeISakkVjrR+bDvd7qebRZXwqBe7f6y7cjKcFyDY4M4b5kyPDFc5tJ4TpjkL7Y5naZ2wtEZB8MD0GT+8pU1iea3IwxwDEG8pooq7CHR2K2lQRA86W/Qg54DYIyE3EnEtgllme3amqhgLivcuV40ecmFuHPJtTs0MmRc5wB+d4V/FqiKyDOOn1f8CydN2braif72m0pZqs/+KJ2Xw1XrqUODEB7CmH9KbgJlqE0F3er9+qeYTKnVYA/dzuSx1BFve3W4gW/5cwXJUm4bJOdcuBLGEjWVV5ha5sdz6Oe8SPsuWoVduUI+gt6Wu9Ocd3mpyRONGM3CP9A3SvTI7XWmwCRSLq4U6wu4794RamzbJldRD/b5VLPVtHhHdW4h9T14X915um28GZMoTHMrO6GK4QN/8fLbPaJF5YwwmfCSM1dPBaeNbAsOZTH0rOPgVTqo4/lIJpIDSl6nkk+ZEaoa5f+17AN+uH7I4cCub3P7dWfhqaRP0RnKqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(5023799004)(4143699003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1JWbTlUckkyc3MrRk1TVzA3YXRSZno1dHVERmJMdXpCelVWNjJyN1c2NVZK?=
 =?utf-8?B?WFlmdFlFbFBEaERDZ1M2eHlEYnpnQ3VmSGNNdVVjTnIwcUQ5dTNCYU01cHRk?=
 =?utf-8?B?Q0U5dVkydGtRSktKVVQ1Q3VIbzM0OWY4WEhXTU9NS1dibWd3RUtFRjN2RWZ3?=
 =?utf-8?B?N3B3OTFXakVGdWpRK2NTd3l0dGYzVy90dGNhSXpnbVhJdzg1VXkwREVNSE04?=
 =?utf-8?B?ZUpmQ2JHakJTZndmWGx0MFZpQW5ZUmdQdTA1Y2ZUYlhIVkgxVjRuK0Q0Q3M3?=
 =?utf-8?B?WFZtbVNuTzFTLy9LRjgwWHdMZ0xFdjYycCtxQnBCRlQ3ZklhenR5Y1VyeHFz?=
 =?utf-8?B?MExCV3BlWlBDeUJhUHVkc21mbHE3MEF1aUR5UVordHQyYXFFSXlyem5GOCtG?=
 =?utf-8?B?SjdqZzFvc1g2cTVib0szTHBPcWJnR1pJS2FsaDN5Rk9BdUxFSGg0OXBQWkFZ?=
 =?utf-8?B?U3U0UVBxVjg2eU9FSGNxWXVqMXBjWUQrSEduOW90cy9LWnRNa1J6ajRhenJT?=
 =?utf-8?B?enVnYWhsQ2tLOFA4dFUzSis1U3FMaHZFL2o5ZzNZcEN2VDc2OG9TSnZzRHFw?=
 =?utf-8?B?OHdkZ2daU0tzWmRCOUhiUmRuOHZIQldCRytOWkUwaCtFOElaOTkzeW9IYW9Z?=
 =?utf-8?B?YTJ1L2REYWtSMDdtQ0FZR3ZONTdpRHRGb1ZiYWh2amtTdzdwM2R3aEVrUVh5?=
 =?utf-8?B?b09UYjZla092SEZGMllNY0xBdVp5Z1cwTUFOU08rb2xLcy9uN3doVWN4VW9w?=
 =?utf-8?B?eFdGVnVXS0x1TUQ3NEJpUy8xRFA5RjJMZTA1UmF2MWhzOFo3cERkU2V5TzF1?=
 =?utf-8?B?cmp2VjRpcXZld3pXUENRVkowU2hrTHlxRWw5VXhtWWVraHI4OWgvcmVxQW0z?=
 =?utf-8?B?VUlDZVhPOXpmeE5Ob0RYaGZ5ZVJTZ0xuaWhUMldoU09tY2FOYkJ0ZDdZSDJr?=
 =?utf-8?B?UTYyaFE4MHVZZXpKM1pTV3FJR1ZFY2hXaEtuTm5ydEdlWlMrNG8rMjQxTEJE?=
 =?utf-8?B?QksrOWd5WWh3SkFNVEJ5dzQ4aDI1clRhMHA3RWJtQWt2U1JKaDY0M3lMSGZo?=
 =?utf-8?B?OXF1K0pDaUxMd1lLRlBHcFdlVjhqY3plR3lXWktNZjc1cWU2Nk54T1hraHJD?=
 =?utf-8?B?TEsyZDFITklOWlVIcW42cGZoVHlPVFRrOWNuNk9nMGtjMko4K09UWDZSSGZ3?=
 =?utf-8?B?K2NEZksxSWZmMURzVXBMd2w2Zzd5aFdjK2FCcW43WHVVdVBSZWh6K3ZXSGVy?=
 =?utf-8?B?ZmJzb0FpVU1XSDVmeXpXVjhTRnJOdFRXS21ORDFVZ2pablVFTHUxNGtWaU5t?=
 =?utf-8?B?N0haaWVRRytsZTlxVUlERUJqcUNGNTdRU29FQndodmx4NGpZMVZiRytla0h1?=
 =?utf-8?B?TzVMSi9LMmZMSjE4bDJnOFU0Wk1RMXRxVkY3MHVETHdlblFpanNJOXYreS9i?=
 =?utf-8?B?WFhCRGo3eGN2L3htTExWbjBPb3BHMzB3NHd3LzNabDlxc2t6QnZwUVM2WGxj?=
 =?utf-8?B?cVY0RmpQRDV1cHdGQytUcVNnSG9PdFF0ZHRxOXZyT3IrdEtWVTBpdDZ0dGNx?=
 =?utf-8?B?Nms5SDl4UmFOcEE0TTJsRGFhUVdSNlhabWVDNXJmV2Z1ZWRFalJ2WTNoUkRI?=
 =?utf-8?B?REo0eWUwKzR5bmhpeHp2eUVNMzArNmovN1c1TTB6ZzNBdkwxNkpyWlUvK3lH?=
 =?utf-8?B?T3dnN2hOOUdFMThuQ2dPL1NpOXF0d2l0MGlWZ09wWGRCTEJUNVF4TzUzdFZ1?=
 =?utf-8?B?eW0vejFCV29kUEIzcnljbDlRRU1NUlN1TGl3Yk45M3BsYUFZWllocFZFT2ZE?=
 =?utf-8?B?R29pTHA3R2R3enJBSHcwQnhSa3hZajhCUm9nVWd2cStmWURJdHNnZkVsODh3?=
 =?utf-8?B?Yy9mMFlFRmZGMWtyUC91b3Y3UUozb2lweURsYXI5SEMrdVRSeFQ2dkhxSEcv?=
 =?utf-8?B?M1J5THg2NEFHOGFuWC9pbUVFL1RZRkZLcVBFemtROXNwOTR5b3JsdnowdmdW?=
 =?utf-8?B?NC85QkcrRllTck5MdmViTXRXRTc3U3JDSUVFOEdIRjdKelBtT2FqSWdWeWJY?=
 =?utf-8?B?WFB0bXQ1ejRXbWlDZ3EwQS9lN25FQ2JzcE9CckNsbVlKQlJGUmFYU0dYWjIw?=
 =?utf-8?B?N01walBDRklJOEd0TGlHNlZJR21WK2VLOXJNZU9oVTJVNDhVcjdEOTdZcGlx?=
 =?utf-8?B?K05pdFJKVFBxNHVKNzRxeGN5VlV5MGo5a3R6S29aQisrY0tLa0RZY1dCbEJW?=
 =?utf-8?B?Y0VHaHVSdzF0RTRONEVXNUQ1d2dDYWFCVFdUSHdHMHJ2eWsxNVZUaDU1eGxD?=
 =?utf-8?Q?BljeyGUE07xhZ1CUs1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3755f1ad-d879-43c0-c32a-08deeedd4dd9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 08:25:39.6102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tz1Nvk70ldMngzK10Me4AucFyViwl6aaEB1wxdxtpLJlBjUNtw7I7eszXQDMl4bA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
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



On 31-Jul-26 1:35 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, July 31, 2026 3:45 PM
>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
>> Subject: Re: [PATCH 3/4] drm/amd/pm: refactor user PPT policy save and
>> restore
>>
>>
>>
>> On 31-Jul-26 12:21 PM, Wang, Yang(Kevin) wrote:
>>> AMD General
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Friday, July 31, 2026 12:57 PM
>>>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>>>> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
>>>> Subject: Re: [PATCH 3/4] drm/amd/pm: refactor user PPT policy save
>>>> and restore
>>>>
>>>>
>>>>
>>>> On 31-Jul-26 8:40 AM, Yang Wang wrote:
>>>>> The existing user policy representation has three ambiguities:
>>>>>
>>>>> - A numeric value cannot distinguish explicit zero from an unset policy.
>>>>> - One value per controller cannot preserve independent AC and DC
>>>> requests.
>>>>> - Suspend-only restore misses runtime resume, GPU reset, and table
>> reload.
>>>>>
>>>>> Refactor policy storage and restore as follows:
>>>>>
>>>>> - Store values and validity masks by power source and PPT controller.
>>>>> - Save writes against the active source.
>>>>> - Restore the active source after default SMU setup.
>>>>> - Reapply the target policy after live AC/DC transitions.
>>>>> - Use the target source default when no explicit request exists.
>>>>>
>>>>> The late-init path now covers system resume, runtime resume, GPU
>>>>> reset, and custom PPTable reload. Common code owns persistent
>>>>> policy; PMFW continues to own effective current limits.
>>>>>
>>>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  2 +-
>>>>>     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 89
>> +++++++++++++-
>>>> -----
>>>>>     drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +-
>>>>>     3 files changed, 68 insertions(+), 28 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> index c3688b3b12cc..ce526db4d24a 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> @@ -508,7 +508,7 @@ void amdgpu_pm_acpi_event_handler(struct
>>>> amdgpu_device *adev)
>>>>>                       amdgpu_dpm_notify_ac_dc(adev);
>>>>>
>>>>>               if (is_support_sw_smu(adev))
>>>>> -                   smu_set_ac_dc(adev->powerplay.pp_handle);
>>>>> +                   smu_set_ac_dc(adev->powerplay.pp_handle, true);
>>>>>
>>>>>               mutex_unlock(&adev->pm.mutex);
>>>>>       }
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> index 99d42446cfc8..43d5dd7dce7e 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> @@ -488,12 +488,52 @@ static void
>>>> smu_set_user_clk_dependencies(struct smu_context *smu, enum
>> smu_clk_
>>>>>               return;
>>>>>     }
>>>>>
>>>>> +static void smu_restore_ppt_limits(struct smu_context *smu,
>>>>> +                              bool restore_defaults) {
>>>>> +   enum smu_power_src_type power_source;
>>>>> +   struct smu_ppt_limit_range *range;
>>>>> +   uint32_t restore_mask;
>>>>> +   uint32_t limit;
>>>>> +   int i, ret;
>>>>> +
>>>>> +   power_source = smu->adev->pm.ac_power ?
>>>>> +           SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
>>>>> +   restore_mask = smu-
>>>>> user_dpm_profile.ppt_limit_user_mask[power_source] &
>>>>> +           smu->ppt_limits.supported_mask;
>>>>> +   if (!restore_mask && !restore_defaults)
>>>>> +           return;
>>>>> +
>>>>> +   smu->user_dpm_profile.flags |=
>>>> SMU_DPM_USER_PROFILE_RESTORE;
>>>>> +
>>>>> +   for (i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
>>>>> +           if (!(smu->ppt_limits.supported_mask & BIT(i)))
>>>>> +                   continue;
>>>>> +
>>>>> +           if (restore_mask & BIT(i)) {
>>>>> +                   limit = smu-
>>>>> user_dpm_profile.ppt_limits[power_source][i];
>>>>> +           } else if (restore_defaults) {
>>>>> +                   range = &smu->ppt_limits.range[power_source][i];
>>>>> +                   limit = range->default_value;
>>>>
>>>> This should be restore the current limit before a suspend/reset and
>>>> not the default limit. The current limit could be set through out of
>>>> band also, user profile values won't reflect that.
>>>
>>> Please check the call sites.
>>>
>>> The quoted default path is an opt-in fallback for AC/DC policy restore, and it
>> is not used for suspend or GPU reset.
>>> Suspend and reset invoke smu_restore_ppt_limits(smu, false), which replays
>> only limits recorded in user_dpm_profile.
>>>
>>
>> Yes, I'm specifically talking about late_init path. It gets called after a suspend
>> or reset. It's about a case where user dpm limit is not present.
>>
>>> The profile intentionally does not represent out-of-band state, and
>>> the amdgpu driver has no ownership or synchronization contract for PMFW
>> limits changed outside the driver.
>>> Supporting that use case requires separate policy and should be addressed
>> in a separate change.
>>>
>>
>> This only requires restoring the current limit after a suspend or reset when
>> called from smu late init if a user specified limit is not found.
>> It doesn't need to revert to default limit.
> 
> Yes, the restore function takes no action if no custom limits are set by the user.
> And the logic has been verified on the target system, including suspend, reset and default cases.
> 

That's right. Currently it doesn't do any action.

What I was asking is -

restore_default => if user explicitly wants to restore default values
restore_user => restore user specified limits
auto => if user specified limit is present, restore_user, else restore 
current limit of the power source mode.

During late init with suspend or reset, restore the limit.

if (suspend or reset)
  restore_limit(auto)

refresh_current_limit()

Thanks,
Lijo


> Best Regards,
> Kevin
>>
>> Thanks,
>> Lijo
>>
>>> Best Regards,
>>> Kevin
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> +           } else {
>>>>> +                   continue;
>>>>> +           }
>>>>> +
>>>>> +           ret = smu_set_ppt_limit(smu, i, limit);
>>>>> +           if (ret)
>>>>> +                   dev_err(smu->adev->dev,
>>>>> +                           "Failed to restore PPT%d limit: %d\n", i, ret);
>>>>> +   }
>>>>> +
>>>>> +   smu->user_dpm_profile.flags &=
>>>> ~SMU_DPM_USER_PROFILE_RESTORE; }
>>>>> +
>>>>>     /**
>>>>>      * smu_restore_dpm_user_profile - reinstate user dpm profile
>>>>>      *
>>>>>      * @smu:  smu_context pointer
>>>>>      *
>>>>> - * Restore saved user power limits, clock frequencies and fan settings.
>>>>> + * Restore saved user clock frequencies and fan settings.
>>>>>      */
>>>>>     static void smu_restore_dpm_user_profile(struct smu_context *smu)
>>>>>     {
>>>>> @@ -509,17 +549,6 @@ static void smu_restore_dpm_user_profile(struct
>>>> smu_context *smu)
>>>>>       /* Enable restore flag */
>>>>>       smu->user_dpm_profile.flags |=
>>>> SMU_DPM_USER_PROFILE_RESTORE;
>>>>>
>>>>> -   /* set the user dpm power limits */
>>>>> -   for (int i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
>>>>> -           if (!smu->user_dpm_profile.ppt_limits[i])
>>>>> -                   continue;
>>>>> -           ret = smu_set_ppt_limit(smu, i,
>>>>> -                                       smu-
>>>>> user_dpm_profile.ppt_limits[i]);
>>>>> -           if (ret)
>>>>> -                   dev_err(smu->adev->dev,
>>>>> -                           "Failed to set %d PPT limit value\n", i);
>>>>> -   }
>>>>> -
>>>>>       /* set the user dpm clock configurations */
>>>>>       if (smu_dpm_ctx->dpm_level ==
>>>> AMD_DPM_FORCED_LEVEL_MANUAL) {
>>>>>               enum smu_clk_type clk_type; @@ -932,7 +961,7 @@ static
>>>>> int smu_late_init(struct amdgpu_ip_block
>>>> *ip_block)
>>>>>        * is unnecessary.
>>>>>        */
>>>>>       adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>>>>> -   smu_set_ac_dc(smu);
>>>>> +   smu_set_ac_dc(smu, false);
>>>>>
>>>>>       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0,
>>>>> 1))
>>>> ||
>>>>>           (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0,
>>>>> 3))) @@ -967,6 +996,8 @@ static int smu_late_init(struct
>>>>> amdgpu_ip_block
>>>> *ip_block)
>>>>>               return ret;
>>>>>       }
>>>>>
>>>>> +   if (adev->in_suspend)
>>>>> +           smu_restore_ppt_limits(smu, false);
>>>>>       smu_restore_dpm_user_profile(smu);
>>>>>
>>>>>       return 0;
>>>>> @@ -2746,7 +2777,7 @@ static int
>>>> smu_set_watermarks_for_clock_ranges(void *handle,
>>>>>       return smu_set_watermarks_table(smu, clock_ranges);
>>>>>     }
>>>>>
>>>>> -int smu_set_ac_dc(struct smu_context *smu)
>>>>> +int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
>>>>>     {
>>>>>       int ret = 0;
>>>>>
>>>>> @@ -2754,17 +2785,22 @@ int smu_set_ac_dc(struct smu_context
>> *smu)
>>>>>               return -EOPNOTSUPP;
>>>>>
>>>>>       /* controlled by firmware */
>>>>> -   if (smu->dc_controlled_by_gpio)
>>>>> -           return 0;
>>>>> +   if (!smu->dc_controlled_by_gpio) {
>>>>> +           ret = smu_set_power_source(smu,
>>>>> +                                      smu->adev->pm.ac_power ?
>>>>> +                                      SMU_POWER_SOURCE_AC :
>>>>> +                                      SMU_POWER_SOURCE_DC);
>>>>> +           if (ret) {
>>>>> +                   dev_err(smu->adev->dev, "Failed to switch to %s
>>>> mode!\n",
>>>>> +                           smu->adev->pm.ac_power ? "AC" : "DC");
>>>>> +                   return ret;
>>>>> +           }
>>>>> +   }
>>>>>
>>>>> -   ret = smu_set_power_source(smu,
>>>>> -                              smu->adev->pm.ac_power ?
>>>> SMU_POWER_SOURCE_AC :
>>>>> -                              SMU_POWER_SOURCE_DC);
>>>>> -   if (ret)
>>>>> -           dev_err(smu->adev->dev, "Failed to switch to %s mode!\n",
>>>>> -                  smu->adev->pm.ac_power ? "AC" : "DC");
>>>>> +   if (restore_ppt_policy)
>>>>> +           smu_restore_ppt_limits(smu, true);
>>>>>
>>>>> -   return ret;
>>>>> +   return 0;
>>>>>     }
>>>>>
>>>>>     const struct amd_ip_funcs smu_ip_funcs = { @@ -3020,8 +3056,11 @@
>>>>> static int smu_set_ppt_limit(void *handle, uint32_t limit_type,
>>>>> uint32_t
>>>> limit)
>>>>>       ret = smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
>>>>>       if (ret)
>>>>>               return ret;
>>>>> -   if (!(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE))
>>>>> -           smu->user_dpm_profile.ppt_limits[limit_type] = limit;
>>>>> +   if (!(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>> +           smu-
>>>>> user_dpm_profile.ppt_limits[power_source][limit_type] = limit;
>>>>> +           smu->user_dpm_profile.ppt_limit_user_mask[power_source]
>>>> |=
>>>>> +                   BIT(limit_type);
>>>>> +   }
>>>>>
>>>>>       return 0;
>>>>>     }
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> index 3d32ee723b8e..698197a285e3 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> @@ -251,7 +251,8 @@ enum smu_memory_pool_size {
>>>>>
>>>>>     struct smu_user_dpm_profile {
>>>>>       uint32_t fan_mode;
>>>>> -   uint32_t ppt_limits[SMU_LIMIT_TYPE_COUNT];
>>>>> +   uint32_t
>>>> ppt_limits[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
>>>>> +   uint32_t ppt_limit_user_mask[SMU_POWER_SOURCE_COUNT];
>>>>>       uint32_t fan_speed_pwm;
>>>>>       uint32_t fan_speed_rpm;
>>>>>       uint32_t flags;
>>>>> @@ -1953,7 +1954,7 @@ int smu_set_soft_freq_range(struct
>> smu_context
>>>>> *smu, enum pp_clock_type clk_type
>>>>>
>>>>>     int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
>>>>>
>>>>> -int smu_set_ac_dc(struct smu_context *smu);
>>>>> +int smu_set_ac_dc(struct smu_context *smu, bool
>>>>> +restore_ppt_policy);
>>>>>
>>>>>     int smu_set_xgmi_plpd_mode(struct smu_context *smu,
>>>>>                          enum pp_xgmi_plpd_mode mode);
>>>
> 


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C85C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 12:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B37C10E298;
	Mon, 31 Aug 2026 12:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RVHj+aXw";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9153F10E365
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 12:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yg5PUmEZ4VGalVz2XbrFC3cf+29XnSmEmf2N7v76iHJp+r/8PCH52ddGNa4qY9axixZQycuCliukl1Bea4BQUI2UtGApB7sA6HTzBApQw7tY4MZWLkOADAo/41ITLZxsjpkU6SnDZ+/WFBy0Htu0IRgSZ1n8ERbYNDIrRHCS6BhczCMC8WREHH2kQ234HpU9nhPjQCpk1rvgMNFs+AfWGfMVg+jykqDHA82l/nRKGx85zMT4vjQSe2L1Fm3GMeDVjxkizrzlcSRR83z40JJWxLvg8TPtFnCXKK5HFilg9U76sguRjy7MpcjhBW1M/iNdW67FC1DSM7fJjo93CewuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHNSdrNq82JFermsOuUrhVziIZU1YtpPuvtWS0CmziE=;
 b=OlFDf5o9u079z2hpsJD1pZo/7nTRju/BivwSIb/Q6pHI3x0OuvLyHaCubJu7QvSx69DWocqkLeuP0zUgxaWb8ksz5UxPAqrlj1ghvtSrdcVGlAMxdWhSNARHtJOCpzu1pWpxxCFKZoS1SbKQdAtdMpeCQuHteeenSKVPM4SCbMHpPV0WJGt2fHSloqcWVKhi2UCU1SnqjMNLZUBA5Wpe1TtKh/22OSWmBF2D4jMpeBHK+IEEInHLlNqtHs2zpsaifeLdvcfsBuJghp/sarzaay0UQhIwydb+EQO6GO+mhIsFcevJHY7eXz+PahQOnWhXGGcBubPXJablVIBu+nn9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHNSdrNq82JFermsOuUrhVziIZU1YtpPuvtWS0CmziE=;
 b=RVHj+aXw0gZYaCvWa7zr47UpscBR1xsPC+0fsF5vbXqZnzj1WSt4bqczfXwt6rI71MgyyRZamwnQtj9QPixAfm+7DCc2uk5gBHvwdkDUQBxMXmN55BTpapU+XraQZhEHfNMar0IFaVON6RSXkbqMtGByYp2INaU1soI98KmgTq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:21:42 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:21:42 +0000
Message-ID: <0a3293bd-317c-4bf8-8fca-395f7a1435cb@amd.com>
Date: Mon, 31 Aug 2026 17:51:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
To: "Wang, Kevin" <Kevin.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
 <6041b95a-ac8c-4410-97cb-8eca51d20d50@amd.com>
 <0e34543c-4802-4023-befa-480b5452d92b@amd.com>
 <BN9PR12MB5211F46FDD421E130B99248793A92@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN9PR12MB5211F46FDD421E130B99248793A92@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: d46a9f82-c855-4ce6-dbf8-08df075a6a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /nwpZFJibCyph4lmmvpd7PDQrnJkIpoy8dQ1iylS8nXpkWsXFZV+FJjSbkZMdExE+5ub6EIdVrstvwLSgZZyYJrSS1tbUahD0MwUv3/Mof3v3qPfy9BxXnixLmR9qymt496JV0GsdtjzxifHkbyOomAmXI5PNnDE3NxuGQg3K/CWbCx0p5N/KPhe1O10yNgYge1Oxj5O+3YmEYjPtoRXYWs4ZBGobf3WqhkLemil3J3lLsQqTyCSyAeKVaIhajtzvTkYyJH5qy8pya6eac+L9valKgx+qJXCSxLl+GK6gt+hX4zO3WO8qd+tM9Km71Kdw4mg3mDsbgpa8rKVCzaBBXn3Kbb8nr/mfuEbYZ4EHH9tlzbvVeJQxfwVyZIOKUtAwAFZ4B2W3H8W+HcPpfVTklQgWLAK8ooW7OIZ3OReJg2/zeW1kd270vOVYabctl6MeymrH2bcQtacGV1GLEGCNXcMjv/9mhKKUciHzRlg55TIAVZIH8iCRL9JwSjJVbTQ+7lFgEoQ/D6wFPjb1nIHfe7CHyEjPVj+wwsZ9q7ij3soN38DQxFXHuHuni8lCE7ASUz2mAEIJlyftBF8OKEiZvw5RsSIIOtoGiKseWGvMsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEZWcHpPVDdGVkVMMDIrNkQ2S2tvZjNoZ014aE5DWjVYL2ZrcXpCMEt2a2o3?=
 =?utf-8?B?eHFOMWMvZ0xMbnREbU52SkcwakZhUHpWVnZUZmVFVWJyeFdOZ0p1TnIvQ0p6?=
 =?utf-8?B?L0VIZUxWQ005aHJyeW9FdFJ4OVZCdERtZE5FcktPYmNJdDRKclQyNWhrWndC?=
 =?utf-8?B?V1dTNTdjVjdNU0doWlZqT21hcjZabjkrSHV5SUtoRFF1T2hRaEYzd0dRSk11?=
 =?utf-8?B?Nkc3VndZZUQvUEJiK3ZjdmJnZElOTFZNUHB1eld1dzB6Rjc4VVhQRnlSSXRM?=
 =?utf-8?B?eDk0blhlVXBNa1B3TUNlbmZlYk9Keko3dXMrSVA4QTNvMEdHZkNyaU5hNXJB?=
 =?utf-8?B?S3Y5RjgvZDByK1Z6QytqVUpiWi9JOVJmb0IydzRsdUpWTjh3bjJhUGJGZWFx?=
 =?utf-8?B?a1pJbXhlSW80UWxLNllwUFM1eUlOR2FNSWlQY3BlR3JoRU41dkhrSFMwQmNi?=
 =?utf-8?B?VGwray9Ibmd0SE5zYWJ0Tm11eCtEdTNsdUtlSFJpWWN2Q0Z0My9jVTZNcmxV?=
 =?utf-8?B?WGY5Y09obWhOL2ZhRXN1RUdZZnhucWxoQ3JzeS9rVjZGajhVSDQ4ZXVxYnhi?=
 =?utf-8?B?Nk5KSWp3bXA5L21ZYXdpa3pZQ3FCYTBCTjNReERFVVdDZVhuemRvWkJXVk01?=
 =?utf-8?B?Wm5SZThWd0Y2MVQ3dUdrVWJmNzdBVXUvd2l4RnFycGNmNDZzZTdxNndGSUJv?=
 =?utf-8?B?Vlk0N3g3TDc3TWRQVXZlbXhHSEFmbGtQRFAwQmE2WTZlbkFyVklvYVBIRjJP?=
 =?utf-8?B?MG5pVFhPalV5Znl5MXBXdWhhSTRDQXlkcWttZmdOTzRCUlNQcGZBb25IVnRr?=
 =?utf-8?B?dnljZFozOFZ2Wk1kYjRKWjZDalc5c2dRMlBVdjhNYXl5alhFcFBtWm15aW10?=
 =?utf-8?B?aW5wQ0s4QVlpNk0wTlpQTTYzck9qNDYwU0xCQmJQRGlURXRJN0sveEFYMTdx?=
 =?utf-8?B?QVhsMDdpdFR6SkhiY0UrYkJDc2Z3bm1xWGFkTmRNVC9pbk4xWjBMR01aUWMv?=
 =?utf-8?B?K3RWaGxzVTZWNnR2ckdyM0htbGNkY2duSyt5dWpiS3pGMnpic09TQXhsOGdO?=
 =?utf-8?B?QlhqU0F6WnFzd25Pdk1sdFozVWMwZE00YmtZYWtpY1ZjSlFOWVd1c2NNVlZs?=
 =?utf-8?B?RWFvR1lRZXR4YUpHalkvcU9NOXpFSTFsWkp2SHFSNDdZN0ZIZ1dxSDZTUE56?=
 =?utf-8?B?ajliZHNJbWFjWTVXRmlsWXN2QVlzRm02cThmM2NlaGF6aUxZL0tBbDl4bDJp?=
 =?utf-8?B?VHZtRWUwV3djYUU3eUVCUjd3ZCtJSEs0QXp2Qm9zdlNTS0NXY0U0c1BSaWtP?=
 =?utf-8?B?MnlaYlBnMmYyQU1qT0JMVDVIa252eFRBY1VmM3oxQ0xXSm44RTM2N2NpRVZR?=
 =?utf-8?B?aVBGcEo3dUxNeXlSZmdkTU1BN3ZRdjMvQ3RLZGlQZ1pCVkwxVzNKQldLSXRM?=
 =?utf-8?B?Y2xjQS9aSU41RWJpcnV1MmZrZC9NeFllbzQ2MloyNitXS1dMODg2ZTVIY25y?=
 =?utf-8?B?T0NqN2lCYkU0QTU5Y2RLRTNUaGt3L0g3NnZ0YlJjZGJQSW9QQ2hXSDNrQytl?=
 =?utf-8?B?V09wZmNEYnd4cW9TTjM0em5uWTdaUHh0VVVGNnA1ejRIYUljckZIOTlWcDlM?=
 =?utf-8?B?Z2JlNStiRmhzS1lzdFBrcEFHSng5WXRBQTJPTTdHc3E5SklqSjk0WTBMQWdp?=
 =?utf-8?B?Q2tmdE83ZHNkRzdOMnVTbXh4THlyS2lYcGpzR3hPNjJSemd6a2x4UXZ6L25y?=
 =?utf-8?B?cUxRQ0dxWmE3eUlQT2w2TEptejhlNXN6QlErTFY4dnBrQ0JGelA1OHB1ejJX?=
 =?utf-8?B?bncwWlBmZVNCTHBidnBjLzNIbXJuV0hSNG04R0pWOFZ1SU9kZmMvNnBSeHJH?=
 =?utf-8?B?S2pzdnVCK2xPYjNibUpxaVBTZjVlUWZTSm5IQS9HOEd6QWRDRFl0NnNmOSt0?=
 =?utf-8?B?WUUzWHpTYWF2eEFrR1lXZ2FpYm9VY0ZYSlJ2cnpEZ1Vkc1lWbHYrUVo0NnQz?=
 =?utf-8?B?U3ZuZzZoMnVOQlFuZDA2bjdYY1d6WlJKd3hqT1NGOWtMbHZUSzliSWZzY0Vj?=
 =?utf-8?B?OWp1WDdNelFQOHhyMXdXNHBQSVJwQVQ2L1dHY05IYnI1T3cvNFBWaGprVjBr?=
 =?utf-8?B?eFFScGVpWmYxUlNsdGU2SEYxMzdyOHVvRjBrcjZYaWI4ZmExSFNHbjBnTGha?=
 =?utf-8?B?cElmdHJ0Ly8yTUlPYnlSTGExNFlMa3UrUjZsaGpid0FrNlRvNm5ibjdoLzEy?=
 =?utf-8?B?TGdDK2R6YmRTd3VXWit3cGxvaFlUK3hOcGZzY2dqc1lwUzFJWitDRVlOeG1p?=
 =?utf-8?Q?v/j2OKzoLKOeeFULLI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46a9f82-c855-4ce6-dbf8-08df075a6a22
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 12:21:42.1293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQEe+ipNhwOkTmYpMUD+FvsAXV+y0jHD2tf/aloVKf9Xm2xTujAh2Eos8u4sTjcR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
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



On 31-Aug-26 5:36 PM, Wang, Kevin wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, August 31, 2026 7:06 PM
>> To: Wang, Kevin <Kevin.Wang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
>> Subject: Re: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
>>
>>
>>
>> On 31-Aug-26 4:25 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 31-Aug-26 10:05 AM, Kevin Wang wrote:
>>>> [Some people who received this message don't often get email from
>>>> kevin.wang@amd.com. Learn why this is important at https://aka.ms/
>>>> LearnAboutSenderIdentification ]
>>>>
>>>> The pp_od_clk_voltage interface exposes a staged OverDrive workflow:
>>>> users edit clock, voltage, and power settings, then write "c" to
>>>> commit them to the SMU.
>>>>
>>>> However, PP_OD_RESTORE_DEFAULT_TABLE does not follow this workflow
>> on
>>>> every SMU version. Some backends restore their cached settings and
>>>> wait for "c", while others upload the reset table or send
>>>> frequency-limit commands directly from "r". As a result, the same
>>>> userspace sequence has different hardware effects across ASICs.
>>>>
>>>> For example:
>>>>
>>>> - SMU 14.0.0 and SMU 13.0.5 stage reset limits until "c".
>>>> - SMU 14.0.2 and SMU 13.0.6 apply reset values immediately.
>>>> - Navi10 stages the boot OD table, while Vega20 reads the current SMU
>>>>     table instead of restoring the saved defaults.
>>>>
>>>> This series makes "r" restore default values only in driver-side
>>>> staging state. "c" remains the sole operation that uploads an OD
>>>> table or sends frequency-limit commands to PMFW.
>>>>
>>>> This gives pp_od_clk_voltage one consistent transaction model:
>>>>
>>>>     edit/reset -> staged driver state -> commit
>>>
>>> Reset should be reset to defaults and shouldn't require extra commit.
>>> This breaks existing userspace for SMU 13.0.6.
>>>
>>
>> I see that this breaks existing userspace for almost all of it. SMU
>> 13.0.2 also resets to the default clocks immediately, while others use a
>> fallthrough logic to commit the changes immediately.applied.
>>
>> This behavior needs to be kept as it is.
> 
> This behavior change is intentional, and these patch‑series introduces a unified transactional model for pp_od_clk_voltage:
> - `r` restores defaults within driver cache.
> - only `c` commits settings to PMFW.
> The existing immediate‑reset paths are ASIC‑specific inconsistencies.
> SMU 13.0.2 pushes default clock limits directly, whereas other backends achieve equivalent results via the commit path.
> This series unifies both under PowerPlay’s staged‑reset model.
> Btw, user space desiring immediate reset shall issue `"r"` followed by `"c"`.
> 

This is what breaks existing userspace.

Only SMU 14.0.0/13.0.5/Navi10 are not resetting to default clocks with 
'r' operation. The documentation also gives the impression that 'r' 
doesn't require a commit.

"If you want to reset to the default power levels, write “r” (reset) to 
the file to reset them"

The patch should be to correct the non-conforming ones rather than 
enforcing a 'c' operation to reset.

Thanks,
Lijo
> Best Regards,
> Kevin
> 
>>
>> Thanks,
>> Lijo
>>
>>
>>> Thanks,
>>> Lijo
>>>
>>>>
>>
>>>> It also permits userspace to reset a staged configuration, adjust one
>>>> or more settings, and submit the final configuration with one commit,
>> without temporarily applying an intermediate default configuration.
>>>>
>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5690
>>>>
>>>> Kevin Wang (7):
>>>>     drm/amd/pm: stage od reset for smu 11.0.7
>>>>     drm/amd/pm: stage od reset for smu 13.0.2
>>>>     drm/amd/pm: stage od reset for smu 13.0.0/13.0.7
>>>>     drm/amd/pm: stage od reset for smu 13.0.6
>>>>     drm/amd/pm: stage od reset for smu 14.0.2
>>>>     drm/amd/pm: stage od reset for smu 15.0.8
>>>>     drm/amd/pm: stage od reset for smu vega20
>>>>
>>>>    .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 75
>> ++++++++++++++--
>>>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
>>>>    .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +---
>>>>    .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 +-
>>>>    .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 85
>>>> ++++++++++---------
>>>>    .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 +-
>>>>    .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  2 +-
>>>>    .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 50 ++++++-----
>>>>    8 files changed, 145 insertions(+), 88 deletions(-)
>>>>
>>>> --
>>>> 2.55.0
>>>>
>>>
> 


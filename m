Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D991DC44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 14:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E71D10ED69;
	Tue, 14 Jul 2026 14:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VxP21uuf";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9192910ED69
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 14:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrejlNquTgf/rVqiFWeh8xkQWfUvFtYchOYmlNp8ynNvk+NI+7+Yv+7nqa3dQJOkv33Q85p0DwAKE4jGysjR4FDKUZP4XjnFLl6dsgth+42qFMymZLVkx4jdeyQbV4tgJ+T/kB8eMKQQkqTsKqUqBpNkVs7EpyP5NyS76ljd5+cMsS8/eGevCITiahrbLf/8YjkJQHmHvHumoOjxmgo6OwyOvI66+Y089woLkHSNnqc4WJOFbspPA57IAvo2I/ueEoD71DnHnKQSMZqyLmxQuz9RdAZ99DNMpOiUIOjax2RhKm2XVHQEg00QUGEqObVBGLuN6m3rdV9toijjYs5txw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMnUwnpwYzhjdUHHdh2t2DAWdf8hVz5cjGfS/RB4+wg=;
 b=ehC/HUGupruW9IEIos83X0yddQTogi1WPDmim/mrdCOnMXCQ18IWiL9woOBoWneKJGltb9O912OOOmLzubnis1/yBD6HjG/ZrvIK1rfkB1yr5nXbajjUDN5S2xrDq1bpmAWigypHdK4fndghV4prddY3fDQmvPJye/XRPA1KWvui4Hx6hBUVz7actN4KXKsRIdwapS2zcnFoMyAGm6Mk68dAP3BeBoW/wmsoCA1mGy4fpgkGU85sb5k/jaQmDyA4JfgWgf46OgcuvBg4bedYqqh7WqXIOCE48EHIFCPwQj/H1teEbKAkcXscI7dzicMekEp3kRJwBmhSu8IZN7Pt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMnUwnpwYzhjdUHHdh2t2DAWdf8hVz5cjGfS/RB4+wg=;
 b=VxP21uufidKxAk4O3Cr5KtQ3JG2njtAlKUwFF3CjYk/BPI9Oe7wi24Ocifn8FoAEfZnXzzm/RWw1DaElhpmaNnuV4QVGK+sDdmV0mLPsYqez0PdLfGjeOc0AJprUeVxDEdcZx5u15ADSw1iG7RV8Zxn5LeW3cr0z4ZqVEn+bJJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 14:14:58 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 14:14:58 +0000
Message-ID: <decc51ae-83fd-48f7-9a31-7aa02e2d0e3f@amd.com>
Date: Tue, 14 Jul 2026 19:44:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
To: Alex Deucher <alexdeucher@gmail.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <IA0PR12MB820888C41AF05BAA5C2CA57090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <3656074a-1a01-49f6-8f7c-129ab379f129@amd.com>
 <IA0PR12MB8208F00938342B8FD8377E0090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <9d575350-c3a2-4e9c-b842-b2a68678914e@amd.com>
 <IA0PR12MB8208EB469D4C2403243D321C90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <CADnq5_PbxvfpjCDQKyeySp1fipA12YduN2t7XzgE7iacc1v-Rg@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_PbxvfpjCDQKyeySp1fipA12YduN2t7XzgE7iacc1v-Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: f20f8b39-b3fd-4675-c64c-08dee1b24909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: GmdH342e5x44hfwVdNJvVu7elj/+XSMI9/iPL/sBiU6YABfF6WeuJxLA/c+CoSO6YzQ/wKLM3Zd5RiUOZNFGVrHAf5wQ33eET4uigcCgh1gpLop7CaFxj0fD5quiS+XfXli3H4fULDFaijrn/CUNmM5tWGaB2AA1xkvE6SqaE38L3xfyz1Hv8aSS5LR+BbdJTgl6GfupPztjxcXsnaBaWe89S0svSx6MoPtb0eL8nvgWy+q1muMXQkI7xgIEDt/K2ppCxOT8oC+q7LvUDdaGW8z+YuEQ/BGapzBMTlIZEwieiiTHr+LoTGG8IFY7ESd/575s4jaXhfn1rVtt+RQ4QVBUu1CRgw2oUvluOYYm/iVUoFLF/1cFtOaKxeMpuCQHLgopoaotbYyHOy87EXp5RwuXZlJxFnQiVuTu0ro8IEifDqCtv5Da7JOM0uygwiH2cwslwy+Mo/myLnpseRl9QSE9raDC7F9S/jKWmp6PPQ71ejco/1M6PJxLmZsx3rGKyqW7p3p7DoPj0zzEFM0hZ+KZbyB4ktMwGvBNTGE9DlkEs3z1FXOsE6/EADWbS90UyHf2F4x7ZeCEzA660iq8rsF2+tynw+27aIehLDDOntQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cksyYUhtemd6TDM1YXZLU3RDaXkwdyt5bEVVY0YrZHFRQzFRKzU3bnRyd0w0?=
 =?utf-8?B?TDRXSnNpaTJ4V2thSEVTaml2SS91RWxnNUtjM0xoVEhpRDhNZG10K05xb3pJ?=
 =?utf-8?B?Z3Y1NXBzT2ZDam1ENjg5OTZLYXc5UUJRR2tHS0dORnFjbnRvMlZ3YTZHWUxF?=
 =?utf-8?B?VHlQWGJpa1NZdDV1cytYK0FQNkFobWtpbXd6Q3V2SC9YSW1VeG0yUTJGeHdX?=
 =?utf-8?B?WklsWHVXT1ZSV281c1h6TEUxRkdDK1JHdnZ6cSszaUExWW54NDF0MVh6QURL?=
 =?utf-8?B?aUZIWXNqVlEvSHcwaTNGWUozaUFOck1qQ28rL3pPRkhHQUVBYVVMNzVES3Zs?=
 =?utf-8?B?OStSM2R5RisrQ0l6K0NDT0cxYUt2OE9wMHUrRnhZZlBvb3BybDNWR3RLY21W?=
 =?utf-8?B?a2hEMzc1TXUyYVc4Z0xjYy9TRFlHbCtSRFVwMEZDM3l1SlExS0x4MUxhU3cz?=
 =?utf-8?B?cHV5WllINXEzVWJORG1jS3NGbGNBdmx0SUNTeGNxR2lEMVc5RVRvbUorbnhy?=
 =?utf-8?B?MEZPQW05MnY0SW9FcHlzZ2RYOStMYW5wdmxJTkZld1NNbkRsTENvQmtvQXIz?=
 =?utf-8?B?bFJrTXBlVnpJZnNlUkZPU1Bld3VZbk9aUkY2VHpSYU13Z1VqeDFqNEVEVWdQ?=
 =?utf-8?B?ZE0zTUcyOXN4OXQwRk45MklwcXNUcTBMQXR1TGJmUUJmTHJPR1ZHNE1ZSzhy?=
 =?utf-8?B?L3M2RDB1VEU1SmI5aFU5VUQ2SDFoaWt1TXF5ZENTU0ZYNmJkZnhYNXN6VWRM?=
 =?utf-8?B?akh1RkdKSk5UTFYyazd3Q0RIV1E5UEtRTHh4Wk5scEdTZWh5dXF3aFhmMWhV?=
 =?utf-8?B?N1JKY2lOV210VXVNTzV4R1A4Nll6UGgraGZGMXloTmJTQUJzYkZFNVRDbU96?=
 =?utf-8?B?RjVlQTk3YU13WUlvUE1IQXpiTTkxVE5DUjdDM2gyaGVjSUNuYmRIODg2eDAv?=
 =?utf-8?B?ZUM0R05FWnZDL3dvc0lIbGtIMnl1c1crUUZNMm5td2tFRHhCVXdQQk5DUU40?=
 =?utf-8?B?bVFKbmNVTk0rL1NEeHFKSHpiMmVIM0xiSGQ0LzI0MDhxRlcyeWxjMC9MS0tq?=
 =?utf-8?B?NEl6UzRRdFN3aHZ6SXZJV3dGaDJDMHNMREtBV1FqM0NsbW1KVG9zdEEvU1Nw?=
 =?utf-8?B?MU1jOFdwZEhWWEkxM1hqUUR3NmhqMkNQZGpVVCtTRzVQZW1ucmZVSUZwV0s2?=
 =?utf-8?B?SE4yTXhMRjk0OGxORWZ0RHltbDZtaUdsMC8rZUZpaGo1VXh5SlNoRGl0Nit4?=
 =?utf-8?B?OHZteksyQVhaUk9ETHR2aUlhdE5tU0hrUk9YR2ZuSDlCLzBEbjBJWnY2NlJ2?=
 =?utf-8?B?MzZoT01tSFZxOXFvTEczcTF6bTM1WHBoOCtudDlHTGExOTRnNUR0RDZUK3kx?=
 =?utf-8?B?Y3pzZml2RmkyeXRWM2hvWUJrdXRQV3RSakk5b2RSNGlGVTFwVCtBbWJ2ejR2?=
 =?utf-8?B?L0FIR2JrcjBHNnJFR3RhRjJTeWJWcGx0U1Ywa3NScTRNRmlmTnNJRGcxK0JJ?=
 =?utf-8?B?UjlBcUlMVzVqK3NNSGd0SzZ0eVhaZ3JzdDIrdzliRnhBUXh1NnVzUFVuREwr?=
 =?utf-8?B?b2d2YzRPNU5EUThNUUlVWnJPQXhGZFFhWGRVNTh3bDREYjY5WVFyZkRreDlC?=
 =?utf-8?B?U2RpZWJqWDRiQlU0a25hZElYSktSMUwyMlFlTVpCNmIzYWJTSEh3Tm51MmlZ?=
 =?utf-8?B?VVA1Y2lEa1RQenVIL2htdDdkaS9LRmo1VzUzem5YQXF4R2ZCdzdRcXczWWNw?=
 =?utf-8?B?SDMxcU5GU3lxbkx6K20vQktVcFdhRmUvTGh3cHN2a1B2TXV1ZE1TNG5MQ3VJ?=
 =?utf-8?B?RWo3VzRTSk9sRWtYcTdTR1IxT2VWcjZobzZYZGhOdktCM2xlYWdDUkIzOHlO?=
 =?utf-8?B?L2VFbXEwNElGVHNTcHd2UndSYm0yUGh3NE1OVS83Q0pEdkRkcFM3b0JSY2xm?=
 =?utf-8?B?SXA2RnpaMEhUQlNQSC9ZTTY4TzRMNDN6VjFVakkzTlZ6eFo4UGk2Ti9ET3Mw?=
 =?utf-8?B?ZFZZcW1vT2JJN1BZUUtzc0x1cHVTZTJVeDFqVlVDWXBJbVVncVZKRFBiUUF0?=
 =?utf-8?B?UjJkK2NKdy90cnNIcGF1UTd4VndGV3Vucmp5b0daYzQ0V1RiVGtBcWZxbTB0?=
 =?utf-8?B?dGh0WFVpQy94KzF1N2trUHdHYmk0M3NCTkFCWjFUTlhpVTBjTVhyMitqWmFk?=
 =?utf-8?B?b01QTGkyZmtHTEN6WG9mdldPRXNQK2tiTWd2Rm16NjU4bDZUbzdFWThtRG1h?=
 =?utf-8?B?OEZFYTQwYzVzSm5CQkZVbXRUSTRsejRFUGxoOTQ5MXUrdzJsTm9NLzR5dnAy?=
 =?utf-8?B?VnROLzhTWDZ3VG1RWWxocEYwR2o1N0FTMmVjS2NIcmZnbW5PNUsrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20f8b39-b3fd-4675-c64c-08dee1b24909
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 14:14:58.0756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N49b6VUtLHAkhCGwyEnjnu2IVholkh+MnPKcuUeCOz0ihvJizESyaqANUKqim3Ed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509
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



On 14-Jul-26 7:25 PM, Alex Deucher wrote:
> On Tue, Jul 14, 2026 at 9:49 AM SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com> wrote:
>>
>> AMD General
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Tuesday, July 14, 2026 4:02 PM
>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>> Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>>> gfx@lists.freedesktop.org
>>> Cc: Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
>>>
>>>
>>>
>>> On 14-Jul-26 3:57 PM, SHANMUGAM, SRINIVASAN wrote:
>>>> AMD General
>>>>
>>>>
>>>>
>>>>
>>>> Get Outlook for Android <https://aka.ms/AAb9ysg>
>>>>
>>>> ----------------------------------------------------------------------
>>>> --
>>>> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> *Sent:* Tuesday, July 14, 2026 3:14:34 PM
>>>> *To:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>> Deucher,
>>>> Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>>>> <amd-gfx@lists.freedesktop.org>
>>>> *Cc:* Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil
>>>> <Sunil.Khatri@amd.com>
>>>> *Subject:* Re: [PATCH] drm/amdgpu/userq: properly account for resets
>>>>
>>>>
>>>>
>>>> On 14-Jul-26 10:16 AM, SHANMUGAM, SRINIVASAN wrote:
>>>>   > AMD General
>>>>   >
>>>>   >> -----Original Message-----
>>>>   >> From: Alex Deucher <alexander.deucher@amd.com>  >> Sent: Tuesday,
>>>> July 14, 2026 2:09 AM  >> To: amd-gfx@lists.freedesktop.org  >> Cc:
>>>> Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,  >>
>>>> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike  >>
>>>> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>  >>
>>>> Subject: [PATCH] drm/amdgpu/userq: properly account for resets  >>  >>
>>>> We need to increment the reset counter, force fence completion, and
>>>> set the  >> wedged event when a user queue is reset.
>>>>   >>
>>>>   >> mes_userq_reset_queue() handles this for collateral damage, but
>>>> the caller needs  >> to handle this directly for the original guilty
>>>> queue.
>>>>   >>
>>>>   >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>  >> Cc:
>>>> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>  >> Cc: Prike
>>>> Liang <Prike.Liang@amd.com>  >> Cc: Sunil Khatri
>>>> <sunil.khatri@amd.com>  >> ---  >>
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-  >>   1 file
>>>> changed, 6 insertions(+), 1 deletion(-)  >>  >> diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>   >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>   >> index 6aa75da27f912..5e1262636e1e9 100644  >> ---
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>   >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>   >> @@ -146,8 +146,13 @@ static void
>>>> amdgpu_userq_hang_detect_work(struct
>>>>   >> work_struct *work)
>>>>   >>                                                         queue,
>>>> NULL, NULL);  >>                else  >>                        r =
>>>> userq_funcs->reset(queue);  >> -             if (r)  >> +
>>>> if (r) {  >>                        gpu_reset = true;  >> +
>>>> } else {  >> +
>>>> atomic_inc(&adev->gpu_reset_counter);
>>>>   >> +
>>>> amdgpu_userq_fence_driver_force_completion(queue);
>>>>   >> +                     drm_dev_wedged_event(adev_to_drm(adev),
>>>>   >> DRM_WEDGE_RECOVERY_NONE, NULL);
>>>>   >> +             }
>>>>   >>        } else {
>>>>   >>                gpu_reset = true;
>>>>   >>        }
>>>>   >
>>>>   > After the original queue was reset successfully, it did not update
>>>> gpu_reset_counter, complete its pending fences, or send the wedged event.
>>>>   > mes_userq_reset_queue() already updates gpu_reset_counter,
>>>> completes the pending fences, and sends the wedged event for the other
>>>> affected queues,  > but skips the original queue because it has
>>>> already been reset.
>>>>
>>>> What is the rationale of sending multiple device wedged events on a
>>>> per queue basis?
>>>>
>>>> The question of whether drm_dev_wedged_event() should be emitted once
>>>> per queue or once per overall recovery seems like a broader design
>>>> discussion.
>>>>
>>>
>>> Along with that, also need to consider if device reset_counter needs to be
>>> incremented on a per queue basis or based on reset event recovery. It could get
>>> incremented multiple times inside this - mes_userq_reset_queue.
>>
>> Looking at the current flow, both gpu_reset_counter and drm_dev_wedged_event() are updated once for each successfully reset queue. It would be helpful to clarify whether they are intended to be updated per affected queue or once per overall recovery.
>>
> 
> What are the semantics around the reset counter and wedged events?
> Presumably each should be incremented for each queue that is reset? If
> a hang affects multiple queues shouldn't each be a separate "reset"?
> In the most common case, there should just be one since queue reset
> should be able to reset just the guilty queue.
> 

Device wedged event is a udev event. It's not good to send  multiple 
events when multiple queues are recovered as part of single recovery 
process. Otherwise userspace monitoring the device will see back to back 
events. There is no context associated so it doesn't have any clue of 
what sort of reset happened.

I think the same goes with device. I believe it's to indicate a recovery 
event associated with device and not as a per queue event.

Thanks,
Lijo

> Alex
> 
>> Thanks,
>> Srini
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Thanks,
>>>> Srini
>>>>
>>>>
>>>>
>>


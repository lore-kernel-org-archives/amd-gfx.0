Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E494E7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 16:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8BC310E2A1;
	Wed,  4 Dec 2024 16:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tg+X4gQ/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F39910E2A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 16:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyIypBXBymfOoQkiTs+/rXl1GKRIB3ya4GAutIjm4S4YYBmXIsqXJx0O8CbnVjTwYnPURnLZsMYVCS54QT8PgavULAf9+S72pr653+378W8SDHd27yh1RShlMxKLYHs90OIWFERkxQVCyGIv4ZQ7IGUuqJm+9odSWRQ+RESBp/KNxaNeHayOHEyrITUY3rBGz2yrzqke6b8Sln71EYiMV7fL5PLRAPahIXAaTvcGyCl/zgkRy5qNatrHoDi+oWSEniKmWcY1tgx+s4rKV34dzj1vrpUmfMcm6mcHSdRrm6TMigKCL0FFk6hWHL78oecKLZxlzzOEkVFowlOAKNIbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z1zUuCeyR6zGDvHrdfUG3z8lqap9iqChqFq7cOOqiY=;
 b=gv6TaQDfaIInnjvh4cRuGS4N36YLcxihh46RecLFxIj7/BB1hfCjUSL5B5ZHL8n1wbBn9sCFO/wLh7aInuuGRvHLCEfLozMO6QrvhMKaMWtncovPZCz0aRQ5AJvgnurDXQ64d5vnYxsLOJbVafcitfMJymhy8iaqDibk3hQtiCuSJeBdMJbCHKWNMEP0ebuvDh8hjzvnFjHxFMJZgNPeAiGde8lM10Ee6XaO34vT8oXg8eNhHVTZSTfwHSqdlY5pDD5wRb+kyN9/ZCb+Lqzaj/8bNiBV4lX2Kw6cjmrL3EJeK7aa4tu2wWJqfR+KK/YbfjdskFNKGbTzOry4+L3T2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z1zUuCeyR6zGDvHrdfUG3z8lqap9iqChqFq7cOOqiY=;
 b=Tg+X4gQ/ztZ0iN4+Ir5/nqcNt+JRTF121nRTMBMIZnk6YGjjDUrE3W2zCvCfOMHX2kfuWEm+Tj8jCYQSOPcqs2WM88zq4sd++zSCFZw6XRrNrGmNbAWFXJ08NkPueDGePVenmDIhLsjJH0rWL2gjLWyX1BhaHMyUxF1uowXqO9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 16:02:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 16:02:56 +0000
Message-ID: <e1e26094-f106-431e-8442-5b067bf58830@amd.com>
Date: Wed, 4 Dec 2024 10:02:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
 <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
 <20d00e76-7ce4-42d0-a968-d7adae616984@amd.com>
 <CADnq5_MPEZA2CYfFnG3u--bDeD3eQyZO6igCQQqHEp-BJNwy-g@mail.gmail.com>
 <2062652c-16f6-4e06-b3d7-73ef6a684aaa@amd.com>
 <CADnq5_MD0wexpOc+mGoXkHMHDv5BxybR+tyowedwxg7vvp6mQg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_MD0wexpOc+mGoXkHMHDv5BxybR+tyowedwxg7vvp6mQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:806:f2::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b07a6b5-6195-4942-6e80-08dd147d1daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkJHTVhOKy82WWlGbHpOUlMreitoWU9JMVIxN3JUZTRUVnRHV3NRMERMTGVo?=
 =?utf-8?B?QWk4eGVNQkVKN0FyY0QrRXBzK2ltcEt3NUtVbTZaUXZlSGxuVkVCVm15aDlo?=
 =?utf-8?B?d0Qva2pKK1pyQmtLVGE2U2w0OXh4a0RIWjhlS0gxeDBKc0hvTml1UGhWQlU5?=
 =?utf-8?B?TCtWYnVPTUxmS0FHaVZZejJzbUdJRXJwTUVxckRUMGdyOXF4T2dYSjhYTlZY?=
 =?utf-8?B?YmNJT1VldTJwdXpCVXcvOVBGc3BqbWxYQ0EvRndnQ1pVTHNFQjgwRWxBa2tG?=
 =?utf-8?B?TmtFTzJXZTY3WC9Jb0x0bWpUeGEvUmZGaFdOOWJTaElvYnJkT1pEVFplQ3FQ?=
 =?utf-8?B?UjBPRVUzTzRnY003NEEyajEzYXZpWS85R1N6ZEVBUnprVFc4bVJKczN4RHNW?=
 =?utf-8?B?dzlmZzRJU3RIL21wL1hBZ1N0VHZ5eEVsblhQMk5xaW9tRHhHbzRhekk2YXBz?=
 =?utf-8?B?a29lVEN0Nkxoc1l3MmJDK3FqWWdvalJmS3dOeXdieVJFRzR5Z2xkcEE4QkVQ?=
 =?utf-8?B?b05kMmQ0MGtHb01hRnZIckRFSGZZalNmTG5pTUpFaFErVXBUamdIY25ZQjNm?=
 =?utf-8?B?c3dIb21VU1VWQUY2LzdWTnB2aGtNV3Vzb0xvRHgzeEE5bXlLZ05DOEMwaXVL?=
 =?utf-8?B?RjU1QjVlQUQ3VGpEc2xsUEpUM3RqcU9XZm1WNVNyV1Fra0JZQXVUSEMzTVlJ?=
 =?utf-8?B?TE42U05WaDZuOHYveDdndUszUmNwN2tBVjVtaHpoNmJycTQzYVhodHJ5cmU4?=
 =?utf-8?B?QUdoU2FXKzhSMG9rT2FHUG1BVzduK3NaMFJUUk1ybmgremF1YlBGU1R0dFda?=
 =?utf-8?B?dldZc25RU3BQeVJFa0pHd3RpTDFnRDIxT1FuWWFuL3o1amNtSVF6ZEtyUEVw?=
 =?utf-8?B?N0NrWWZFNzhzQzFHdHRad0NOcWIzUlhQczU5UUtrd3R3NTVGUlVmYWxZZUV6?=
 =?utf-8?B?MnBXUVB3M1ZIbXdDa05MYnZtNnZoRCtuR0JXdTk0ZkhrNGtMaXFWZzhyeWlP?=
 =?utf-8?B?eDlCNTlKL0tiTDVuUlZFL0pRUno0dkd4dExBa1I5cjJScUg2VzluN3kxdmR5?=
 =?utf-8?B?cE1tWXkvN2ErVk1ZemZTeWJkWVBvYUsrZTZmVlhMZXVZZ2lockFyRXRFdkhq?=
 =?utf-8?B?UUw1bjdFbENzalRWZ3IzdWRJTitSYmE4TWhrSFBGNWNVMXBmekV1bkQxcWZw?=
 =?utf-8?B?SGFoQVh2Sm9VMStrblVJeXhSSnN5bGtuZWNSbzRnTllzYWhMYnJQV2I3VnI4?=
 =?utf-8?B?ZFRBNWR1YnJQRmRaNEY1TGpsL1REa202L0d6d1NtRUE0dWdtZmZzL2lycGxi?=
 =?utf-8?B?dlFlbCtsRThHVzhSU1EwaEEyclE3ZHd5TzBJdlZNdjl4eldGd2QyTFBWMTRl?=
 =?utf-8?B?dzJFMEQ1K1haS1BCbEFRamJuZTA2RWVEV1FKcFloTTM0V1NPeGFBN21QdTVk?=
 =?utf-8?B?bXZiVUFPcXZ1akxPLzdtM3dTYzVEUHdKcTZBWXl2NVVCN3kxR2YwUmxXZmFH?=
 =?utf-8?B?ZVNTTUMvbThIZTdZb0I4cUptZ3UzK2xZNFExQXBPanlhK0YycDFRZkE5MnR2?=
 =?utf-8?B?WDd5QkF5VTExMnFDdk9LTzJ0ZjFwenVQYVRXb1pNMkFMaFRYLzJsdmVUOFVx?=
 =?utf-8?B?NllhNVVoWEdkTlFuWmpzZ2MxWmRmS25SSW51MDF3RmxSNjVXRDJmNm5RLzdv?=
 =?utf-8?B?Y2tRMmQrV2JWYml0THM4UEU1Zm84UHE0b005NDhEZlVpQWd5S1Y4eU1BZDBT?=
 =?utf-8?B?SnloQ2hiamNVT2Q0OGd1NHJaeFZtOGNsYmNWSDlTTi9tWE04bGN3cU9haGRk?=
 =?utf-8?B?RWNTeFR5bVJWdVFwS2xnQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmhDTzBFQWR3andEZjhnZXQyZnNTWVZuQS9ER08wVVc2cXllRnFCV2IxQnlB?=
 =?utf-8?B?ZkI1SGUwbnZsVjdtSnIvS3h5dEpyUHNSdExMOHYrWkU5UmphVnlaYmdZZ2Nh?=
 =?utf-8?B?SlZsYkdhMk1mMVErdGxlOWpjSkhPUGlCbFZmcWRQSGJ2cnNwTENpb1ZHS2Ra?=
 =?utf-8?B?dEY2VDBpRVhrbnJHbDFWTXpJMWpkLzIzN21sUlRnNVRDQzRpUzhFTFgraC9v?=
 =?utf-8?B?OXpqU2dIT1NRSm9hTDlObUhRQ0QzOE14T3RPeWQva2I5b21uUTlUSXdCVFFx?=
 =?utf-8?B?UU9XRkRZK292cFVwTGV6MFM1dytRczU3UmtQNHd0bXI0Uyt4ek9WTDNMQWJU?=
 =?utf-8?B?amxuN0RiQkdzVjRFTEJ2N1lZdmtsRjlGY1NVcG04S212bmdBWjcyR3VHNUdZ?=
 =?utf-8?B?YTBoOENTdlVPWWRlYjhENFY2MEFCd3RTYW5vQ29XVjFwNUJ5UW04VzI4Rk84?=
 =?utf-8?B?SVA0c285dEFnZHpxSVNjR3dJSHdBeDFTUVhWQWZYMlBHakRxTjZ1MktRMDlM?=
 =?utf-8?B?WU14d1pJekZqMmY0NDg4czBpdlBmcnhqY3ZMYnFLS3B0UFpFNU1xbytMQVF2?=
 =?utf-8?B?UUdXeC9uUVd0a2tDTkJWa1V1ank2bjBOd0o2L1loTUwrWEY5M05lYzlqR2Zy?=
 =?utf-8?B?dHZ2YWxrbkFZSElTQVM1SENuRHF3TFF5UElMNHczQm10OTFtS3NEWnFLU0R1?=
 =?utf-8?B?QWpGbjdLWUh6YzNpL0JTYnIyVnhncEVjY1J3LytRajdGTGlSWXpQMXo5bVdt?=
 =?utf-8?B?MWVsR0FTNXBMMHgvQUg3TDIwd0FOeTllNGZJdUhETFpOa3BxV2wxR09IL3kw?=
 =?utf-8?B?bThLS3p5cEpQSnRyYisrcDdDd0pHM1dGazZ4ZkFuZTJJM0tQRkNucnd2aUt1?=
 =?utf-8?B?bjNteEg5S29TdDErekVEU1NyUHRMT0ZJQUZHK1lpOVY0bnRHMU5jbXVNRUIx?=
 =?utf-8?B?dUlBRzBkakJ0Nm5oRktHQmUvUXNJYlduWFdkWVZ0Q2ZvRUpIallEVmNkMVo4?=
 =?utf-8?B?bEFKTUc4VERTeWZ2SkJqOGFIQlFUUXdxMGo5UmhYU3ZPeEtnK3QwUC84UFJ5?=
 =?utf-8?B?MThjaC9LWGFJbzYzZUNnU1RhcVdudXlobXkzL2lRSW51NU10NG4rWFlZVDda?=
 =?utf-8?B?YktxU2tNcDNqaGI2Q21ZTjhKM0FoSXJNb1UrTzEzVkhtaXZ6TjRKSDMyVURR?=
 =?utf-8?B?eld0cHVheFg2RUEvVWJIRFlwUUtpWHZkcENUaTF5aHh0UzFhRU82RytuSzlk?=
 =?utf-8?B?VG9jbHhXNEZ3NWVlclR6bUVmS3ZhcVJ2N25KWnNmMC9zenNtN2lFUnRnV0Vp?=
 =?utf-8?B?UGtGbVFPUkQwSHYwU3VtVjVERytGc29JeWdONkpZRlJrb09Ba21ZSDQvVmlp?=
 =?utf-8?B?SnBUR3hHUHRvcWlxNlkvS0VMRklYcUx3RFpqTlZQMkg0RE56TEZrNHZuZ1V4?=
 =?utf-8?B?N0Nvd05iQ3RMQ2xEbDIxenk1dDduUE1xSkJlZ3dBOWl2MEE1Wnk4aUlISnJG?=
 =?utf-8?B?Rk9nWUFIbHRnUm5IMjNOK2Rza0RTVi9PSUd3YldYZ2xIL2lSeUhzZC9tNUlu?=
 =?utf-8?B?NFpGM3RxN0ZTODdZa2Q1cnpCN01WL1FCNUFaUHNOWC9QdDJlakVqL3krME96?=
 =?utf-8?B?VEpmeTcvTmxvMU5tOVdNMDFQcldpamRTR21oUXYvSVI0WVphelJwN0FkYmZH?=
 =?utf-8?B?N3RSWkhMcjNDemNScWdVcERDRGd3RDJNcXQ0NmxwQnNpUEorVlFHM0l0Sm11?=
 =?utf-8?B?YkZXVzlQNDhES2pPRkZqbmlFQWluRUZXN0RudGQrc2FQOGtFOE0yV3pEb05C?=
 =?utf-8?B?UzYrSGFXWTZaMHBpbVl5NWlLaWl6cEhQZ1NOYmVNdHJMMU83SlZJSTIwc0to?=
 =?utf-8?B?cVVnZGVHekpuZzl1NzBuMW1DTXVWTU51Q2pHZ0szVks0REhGN0lhSG1oMjBH?=
 =?utf-8?B?R3FHRmlJWkNkT0tndjFMdEJKN2RjWUJSVlVCNmRHeEY5c3l4cTgraXg3ZlFQ?=
 =?utf-8?B?Qm1FdWo4dUxpZ3RYREh4cEVaUVVCUHFmUHQzY1BWbm01cE1xajYySXU5c2du?=
 =?utf-8?B?YnlSYmY3eHBxeG1pdGFMY3NaR1FTL3FYTWxqTThVNEFXM0M1NHp4cEtsaEFh?=
 =?utf-8?Q?tDytgP0pnoD+1ww1yFT49ovIl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b07a6b5-6195-4942-6e80-08dd147d1daf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:02:56.0057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPWyQig3DbQSzANTBp1vkLLteH+BC4wg6T/bjXFLo7Ha25hLYMAAohfinx15O9sipyiGwJs7QATbSPN5kOzCJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
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

On 12/4/2024 10:00, Alex Deucher wrote:
> On Wed, Dec 4, 2024 at 10:56 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 12/4/2024 7:51 PM, Alex Deucher wrote:
>>> On Wed, Dec 4, 2024 at 12:47 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/4/2024 10:44 AM, Mario Limonciello wrote:
>>>>>
>>>>>>> +enum amdgpu_ucode_required {
>>>>>>> +    AMDGPU_UCODE_NOT_REQUIRED,
>>>>>>> +    AMDGPU_UCODE_REQUIRED,
>>>>>>
>>>>>> Couldn't this be handled in another API instead of having to flag every
>>>>>> load? By default, every ucode is required and if optional may be skipped
>>>>>> with amdgpu_ucode_request_optional() API?
>>>>>>
>>>>>
>>>>> I guess this would be a smaller patch, but 6 eggs one hand, half dozen
>>>>> in the other?
>>>>>
>>>>
>>>> I thought only ISP and gpu_info (no longer there for newer SOCs) fall
>>>> into the optional ones so far. The usage is rare, similar to the
>>>> nowarn() API usage.
>>>>
>>>> Also, as far as I know, the cap microcode is a must whenever used. That
>>>> is not optional.
>>>>
>>>
>>> The cap firmware is definitely optional.  Some customers use it, some don't.
>>>
>>
>> I thought optional is something that can be ignored even if FW is not
>> found and then driver load proceeds.
>>
>> What is the expected driver action if we classify cap firmware as
>> optional and then it fails on a customer system that expects it?
> 
> I guess if the customer expects it, they can make sure it's there.
> I'm not sure how you can have both without it being optional.  For
> customers that don't use it, requiring it would break them if it
> wasn't present.
> 

Besides those, there were a few others I marked as optional too.  We 
have a few cases that we do a "fallback" firmware.  If that one isn't 
found try to get another filename.

I marked the first one as optional and the fallback one as required.
So effectively if both are missing they'll get exactly one message in 
the logs about missing firmware.

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>
>>> Alex
>>>
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Alex - what's your take?
>>>>
>>


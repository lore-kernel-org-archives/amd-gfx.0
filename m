Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC50C5B559
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 09:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DCB10E348;
	Fri,  6 Jun 2025 09:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HLGXONzp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A4110E348
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 09:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmsTC+mJ4YLyAi+/RaWcX1ewxQ8sxe/MnnOY4r9DBvRLWK1R+FeH+YDWM9U4q57gcdxj0jAVUJ//kcLQZ23iws9B/BNADHEz228LIJMVcRLDpaCK1yYb3wdkO+WET7A1IVlUs1ls5REwVWOxw4NKihRW69aoJ4kPIO+85H/4YgfoCQ8fAQ4X2arOfSt+F8IvnoROzQxJImJ8A9paEk0re4fnd5e/Og+kb7faO0GuWqIR93YQF3ztH9TiilV+7X+vkI18aDFuG81ikTFdi7cMXDZTfDuuwrbxSH9IN0p7q6xDRIx29Z2iIWb04wBvtRyy3FpUvk5c1HQs8cmWlXGoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHsT0UruZNZJNHBji70V9SrsxLhlaUtZkqdJoR50iuA=;
 b=BzDkpcp3LrzXNCssT0tjI4S2tGUZkgNFJXZ4U5Y9gm33zxSRa7OEKCxnSbEMTdAVcjNxtqOahzkli5108q6ikEWLeyCy1C9mqZGmdly1ZiHjOCb3ZBLU90oV+FGRfUqVhHHFdrUY0Q3Ly6fBxw8KUOrB54TSKmzjJiAmvGJV5JKLPXBJtbVV2wgDpuKen4glN5Hu+hqDb4Z2EL1uImFj4PTdfioqZ3AXSWd9C0+F0DMfUqM7ItuesgSoPA68WVj7XhJ9XucwrPuxXuFrRMeU+hDCOkYMoffZkFua6DrXMie9FASXIPiuI3yDHtO0HeqR3XcUdTHyVwv/bAVNN0QU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHsT0UruZNZJNHBji70V9SrsxLhlaUtZkqdJoR50iuA=;
 b=HLGXONzpPCwtFb90zsN1rAcZbwXAjFQr8d5Vgqwhz7XhZ6dfZngu6P+nHrDNQd7jQPEI0qyI6Z9VC9I0puzde77B1PBtfUI7X8B4B4VEmmmnUufeuePM56JQmEVyv8FmjznOqguq/llkmoA+sX1eErgTVsHEUzbB+saJG9Q0lfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 09:34:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Fri, 6 Jun 2025
 09:34:38 +0000
Message-ID: <cd7586ca-5643-4b54-9634-6c589a708747@amd.com>
Date: Fri, 6 Jun 2025 11:34:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
 destroying
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-3-Prike.Liang@amd.com>
 <ba16b7a2-130b-433c-a305-fa756bead449@amd.com>
 <DS7PR12MB600514C513A65F0C3298D02EFB6FA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <d0359d3e-0096-4d95-968e-b1fc0b344604@amd.com>
 <DS7PR12MB600595715ABC3F9888DD0ABFFB6EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB600595715ABC3F9888DD0ABFFB6EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:208:23c::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9053e3-1b1b-4b63-cc23-08dda4dd5b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDdBSlg3YllIa2tGZ3hPVTZZdHBES0FvRmxFcEIzcG9PRzdhYXljMGk1bmZT?=
 =?utf-8?B?WVVNZHhiN1dKUVBVZGUvQWtxNTY3clBkRG80cW4xbnZqNERRbHJrcTFFNStU?=
 =?utf-8?B?TXNhZUhBb3ljYTJkdk1xTDM2Ykp2Y000bFJMVUtoaXpJMmx0aEVXSGEyZnV3?=
 =?utf-8?B?SldlK1B6QUF5MkVuUk5EUHhWZUIrOWViSnNsWTVGUDl6SFBRZ2x3Tk9tdUNT?=
 =?utf-8?B?eDhVSzhzaW95d1BQQktDV0FpWFNsU1BLZnBiSkNqT1ZJZnJPMjNiTDdWSm80?=
 =?utf-8?B?cURYaTV6TE8rVGVvMUIwM0RjZFM2Vmw4ajJYVjhhNkFFeVJIUzJxc282enNF?=
 =?utf-8?B?WnpTdEcwVVhmUXNOR29HMFZ2QWFSdlptQ3NlRzZNcEg2VTZ1WUVmWmhmbUhi?=
 =?utf-8?B?N1lpV2hOT2hEblMxbythS2pFZjlVSWIwajBSN3l6UWhLSFZjTHFWSnFOc2xk?=
 =?utf-8?B?UUFseUlnMTcyN1RoT3Q5RTZ0cGhaS2haTzE4UEI0dXBTZ0VXTURScGtKR2M1?=
 =?utf-8?B?ZlgzWVJ4alFxZWtQTzV5RXBMRTFraXNKd3lWUlpRd2JiSzVCNTJ1Tm8zdEw5?=
 =?utf-8?B?VmhMTEhWZk9RcDBRajlPOWZjSVVwS2Q5Ni9Sd29hRDcwZ3lmU3RCMHNYNWZF?=
 =?utf-8?B?dlY1YVZwb3ZFblR0bzZNczRPeXdVT0Z6Szc4Sk5kMFFldE9qeExsNW51dUhY?=
 =?utf-8?B?UmJnbytJN0E1bW1QWStBT2o4THNaMEZHRDliYUtyM3VMbFROSkJWQTl6SnNE?=
 =?utf-8?B?OXpJa1RGV0gzTVhTZEduSWYxc0tBVnordUVWcGlzV0x3MHhOUUkzSkJLSHpP?=
 =?utf-8?B?Ull2Mk1tUFVQZFhaUnFjQjVMVDgwVkRscXlrSW9oZWlqek53dEZRZjU2NXUr?=
 =?utf-8?B?Wm1rUDRhU1BHaERGcDZFcXE1bEt5YmM1Y3pxSnREUGs2akM2UFpyQlp2K3Zo?=
 =?utf-8?B?a01uVzhqbHZqazdjWWMxelpHMHljdDFqSzU1ZnpFcStHTVYyYktrczJORCtV?=
 =?utf-8?B?UkwzV1FmbThYbnJFOVdJN1VDaFR0WjVERUx0ZzNsZzZRQWlqK0EvUnZLYktK?=
 =?utf-8?B?U28rYnA0cU9rVFc4TTFFRkR6NnBTNjdwMnhCMmdzdXBYOFBibVllQW5iamlE?=
 =?utf-8?B?MG1zL090emw1TkN3d041czRYSFdUUENTUGZyaGZ0V21WMkkvZUNpaHdYNmNx?=
 =?utf-8?B?S3JjaXNWMlFUdXZDVGtNQ2tmTk0yRlBCbmpkU2xOTlBhUUdQT1h0TU5BZDNI?=
 =?utf-8?B?eG5ldW9XeldyWFdRRHF2NnNsRTJYVHp2YjRodUp5VittMUhWenpCeTVLRlVL?=
 =?utf-8?B?b05hZmFoVS9oSXZzcy9OMGxoQlZ5NTNnUGorZGZIdk1kZVpGekFqZkJBbDl4?=
 =?utf-8?B?M0ZPdjhLRzRaRXoyZkJ5ZENNVmpWVzdONnNVcUQyWEZnSFdUQXJ2Ymd3eGxk?=
 =?utf-8?B?T0VKbCt3bUFaTWIrQnhMSkF3N3BCOGYxZ0RybWtVQUxDNzI2NnlqRTRyaGUz?=
 =?utf-8?B?VVdxNlJQb2ZLZDVBWjB5UFN0SkR0WDdBYTEycTNlNzBTamdiOTZhZVladVlP?=
 =?utf-8?B?V2VwRjVST2tjMzlUZk9Gb1l0MThDVEZJVWF5VXgzRytlYzVZYUVWN3orZFZj?=
 =?utf-8?B?QTFzT2FkTGw5VHpQb01MSEtYU0s0WlJqM0Q1VE93R2xwakEwRmtnWXlJTzND?=
 =?utf-8?B?b1NRbjBFNEVkR3pmd1ZWZ0xqQSsrMEdPTVo4Zk1NY2pxdnpFVHBjYy82SVVy?=
 =?utf-8?B?ZTFtZVNCT1VaMUhWdW5ZSExzSDRBbmprYVZ1dXZZT2QyaG1mV0tIZkZ1amJH?=
 =?utf-8?B?RlIyMXhUekxPT2pnVko1bzdBRjg1c2ZreWtIL1RCSkljZVpqeUJxZUkxY0NG?=
 =?utf-8?B?QUdBYVJzdVByVkdhcnprUHlQWmtKUmNjVVJHcFh6QXVGNThkdHBrQ0tOcTZJ?=
 =?utf-8?Q?62UjuhrdzN4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEpFOXJxZFpqZWZudmp2bEl2L1JyN1NrUVVVVDhSVDhqa1dRM1FVZ3hPa0lG?=
 =?utf-8?B?NEh6Mkc1c1lGTzJJMWE0U0F6aW1EVkJWWlE4cDd1SEFWVFlLUDhqQWtSMXBi?=
 =?utf-8?B?Qi8rSWRxaXR1cnpDUjJCTFAwTG4wVUZrenhCcHdBZkcyWGg4LzByV0h4YVk2?=
 =?utf-8?B?cGs3bkhENGhzSi80YVFoZEhmOThJWDFTTVNFNXM5QW40SXZmWkZHaE1JQTRW?=
 =?utf-8?B?K3pPUWlTUnV5TnVRN1ZnMjNvWFVqcmlmRm5hdWlTeitHTEFVbUxpZnkzM0xl?=
 =?utf-8?B?U1RqK3ZGRnh2bnVkd2NJdEhvU202TlBnRlBIY2pqc1BDSnJuSkZBWFFhdlRZ?=
 =?utf-8?B?Um5rWGRrc0pkYm5wd1V2dm51MGF2ejNrcG44MXlzbWV6YU9RYS9ITE9qL29O?=
 =?utf-8?B?MWE1bWcxUllETjJCUEtvdUpnQytQYnQyUlpmQmNmdnI4UDBIWml2QjhnQ0p2?=
 =?utf-8?B?bGFndm5UQitQeEdIZ1JpbkZxb01EWFRFZTVyY213aE9tTmljbTg5WjN4dUNo?=
 =?utf-8?B?WWxBekpqTU1VbERPR0VMN1ZmUy9YYngvTWJudzhLWTk5LzhQN051aUtoa3dX?=
 =?utf-8?B?TnZaU2RoMjYwbHVJY3A3WHVCOUdtOEFRSmRnVGdRcGFtMlR3REhrazFSS3Ur?=
 =?utf-8?B?VFdnVmdiMlpkWTBHbVAwZXpHMU5wY3ZsYWJycm9wMm81bS9iamNZdHZIbll2?=
 =?utf-8?B?VHVoT1puUS91OFRsY0RyWmtjbzVONmpDVS90cis0Z3kzdEllVHlmNmI1TjZ5?=
 =?utf-8?B?aEJFbEdWWHQ0NVNBbE5ZSjRYZG1PUDFWaEJpUy9xU1BreG41TFdsOFVyczNx?=
 =?utf-8?B?MGFidW81a0FBV2Ywc2U4MjR6UzdhSUlXOVFBTHRDNWNxZzEzcFpIRlRUbmM0?=
 =?utf-8?B?VGhMdVNpMkRZZllaTE52Y3NCVnhGS3hFcUwveitVN3hKdVkwVW4wWFozeERJ?=
 =?utf-8?B?MnJlYWN2UUpzVngxcHBmN1FyR1FwZkdRTjU2dlg0L01iakdmZlgzL3Q2bGxv?=
 =?utf-8?B?ei9kQjVZR0VyUjVCYWlpR1dNRmVYMGpVcEV5U0RDQjlvUVZiLyt2NGtCNDkx?=
 =?utf-8?B?K2EwRWQ4dFJUWS9RUFRPRldETU9oRHJIb3Zia0V4V2hDSkxmTlZPZ1YvTElV?=
 =?utf-8?B?YmhQRGlCM25DRnprcE1IU0tZRjJGQU5uVVJ0dE1BTytycHBvemJkSEtmczhk?=
 =?utf-8?B?b0NMNVlXSjZ6NXRIczBGV1hJNzFQMGw0dWVlTWlnRFZiaXNwRzhSRmtFVlg0?=
 =?utf-8?B?Mk9DdDRJR0pHdmdjZzMxY1hJOEpyVVF0d3dVMFRvQVVqREQwajhjZG5EZldN?=
 =?utf-8?B?VlQ2RGhVZU5RVTJTWHRkSm1BdmFIcXBpR2NtckNKdDQvZi85MXdwZERrV1dw?=
 =?utf-8?B?RjQyYi9GUDd4dlgvT3BMUkR2QW9jL1NidXVFNWxNVThnbnBDWk5NUFRSd2sw?=
 =?utf-8?B?TkJNbmJDRGhyeGZhaDdYL2VqS21VUkhSQ2RLcmlYb2d3RExTaFhSNFRvWDh3?=
 =?utf-8?B?Wm5xVG5pYXR5TmJCaWNvd1d5UTJ0aE4yYmE3elI1RkxqL3RoRmJVREJOOU1x?=
 =?utf-8?B?cWQ0V3pubG5LcHFCdkdkaDZFM0JSUHFyemNUci92UVdCL3cxS09iVWJ1a1dt?=
 =?utf-8?B?SmpHRTh4ZzN2M2xocmF1QlVQVlROSVVBZFByT0loUDA4YVBJc1U3T1dkR1Y3?=
 =?utf-8?B?T1NwdEdXck1lQjZ4UGxUdlNPT3VXLy9qRElueHNQcVFnbDFub3RTYmFYOVVw?=
 =?utf-8?B?a3l1Yjd4amx1VWdZemcwSnBzT0x2bDBpU1BIZFkvSHpob0djZkcrdWE3RUlj?=
 =?utf-8?B?bEJibHMyaVQ3UlpOUXpLK2Ztalp5Tk1sQmRySjRLSGRZUktMM3FXbHlGQk91?=
 =?utf-8?B?WFFiQ0x6ODNVenRDY0lGQzhPZ0ZHaGNpYmpjdjZ5eGwvdUgvRURscGF5bFUy?=
 =?utf-8?B?K1FqSHFScm5HTERsVW9BVi9aMWFZbVZtUkd2T1RIZ0hlQlloRGZwYmtMY2hy?=
 =?utf-8?B?b1JzdE5MUTRoRkhIMFJmOW1venBXVHVYdm5pUjdRcVhlMzVHNENCdnFKL0ZX?=
 =?utf-8?B?eFpjaURUZWFEYWRZbG8rdXJNS3ZMdnlTUDZ5NVBzS0pyaXJaTzNacVAxR0F2?=
 =?utf-8?Q?sUwZsGph3EAsN6mJXVNbe6CDJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9053e3-1b1b-4b63-cc23-08dda4dd5b87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 09:34:38.8581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfCOGcOGJ2+sIPOhlM0BkjbxjJbYU61b9J877xGuXUP9wbYsLmRW2T154Fi1DGqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9484
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

On 6/6/25 09:19, Liang, Prike wrote:
> [Public]
> 
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, June 5, 2025 9:38 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>
>> Subject: Re: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
>> destroying
>>
>> On 6/5/25 15:15, Liang, Prike wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Monday, June 2, 2025 7:05 PM
>>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>>>> <Lijo.Lazar@amd.com>
>>>> Subject: Re: [PATCH 3/9] drm/amdgpu: wait for the user objects done
>>>> before destroying
>>>>
>>>> On 5/30/25 09:54, Prike Liang wrote:
>>>>> The userq buffer should complete its attached work before being
>>>>> destroyed.
>>>>
>>>> That doesn't make sense at all. We should wait for the requested
>>>> signal fences, but apart from that it is the responsibility for
>>>> userspace to make sure that queues are only destroyed after they are idle.
>>>>
>>>> If the kernel does this it should *never* wait for anything ongoing,
>>>> it should only forcefully unmap the queue and destroy it.
>>> [Prike] Yeah, generally, the userq destroy IOCTL request should be performed after
>> Mesa tears the window context down by executing amdgpu_winsys_destroy().
>>> But if there's an improper case where kernel tries to destroy the userq BOs
>> attached fences somehow haven't signaled, then it's safe to force destroy the userq
>> buffer object with ongoing work?
>>
>> What do you mean with attached fences? We need to wait for the userq fence before
>> destroying the queue, but apart from that it shouldn't matter what fences are attached
>> where.
> [Prike] The userq destroy function already waits for its last fence using amdgpu_userq_wait_for_last_fence().
> I mean, is it necessary to also wait for the reservation fences of the userq's MQD, doorbell, and WPTR buffer
> objects to be signaled by using amdgpu_bo_sync_wait() before destroying such BOs?

No absolutely not.

Regards,
Christian.

> 
>> Regards,
>> Christian.
>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 3 ++-
>>>>> drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 +++
>>>>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> index 8eea0e1e1b6a..f45585bd5872 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> @@ -217,6 +217,8 @@ int amdgpu_userq_create_object(struct
>>>>> amdgpu_userq_mgr *uq_mgr,  void amdgpu_userq_destroy_object(struct
>>>> amdgpu_userq_mgr *uq_mgr,
>>>>>                              struct amdgpu_userq_obj *userq_obj)  {
>>>>> +   amdgpu_bo_sync_wait(userq_obj->obj,
>>>> AMDGPU_FENCE_OWNER_UNDEFINED,
>>>>> +                   false);
>>>>>     amdgpu_bo_kunmap(userq_obj->obj);
>>>>>     amdgpu_bo_unref(&userq_obj->obj);  } @@ -317,7 +319,6 @@
>>>>> amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>>>>>             amdgpu_bo_unpin(queue->db_obj.obj);
>>>>>             amdgpu_bo_unreserve(queue->db_obj.obj);
>>>>>     }
>>>>> -   amdgpu_bo_unref(&queue->db_obj.obj);
>>>>>     r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>>>>>     if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
>>>>>             drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Can't unmap
>>>>> the
>>>> queue
>>>>> for destroying.\n"); diff --git
>>>>> a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>> index 1457fb49a794..b46e67b179fc 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>> @@ -336,6 +336,9 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr
>>>> *uq_mgr,
>>>>>                   struct amdgpu_usermode_queue *queue)  {
>>>>>     amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
>>>>> +   if (queue->db_obj.obj->tbo.pin_count)
>>>>> +           amdgpu_bo_unpin(queue->db_obj.obj);
>>>>> +   amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
>>>>>     kfree(queue->userq_prop);
>>>>>     amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);  }
>>>
> 


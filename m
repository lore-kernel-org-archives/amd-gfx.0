Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18808C3ABC3
	for <amd-gfx@archiver.kernel.org>; Sun, 11 May 2025 20:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC0410E089;
	Sun, 11 May 2025 20:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d26kfmGV";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A2A10E0B4
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 May 2025 20:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+CltTWTO2rAldJcAoAu9HpQUFZKBkZ5e77YJeAhd8hYjczM+impkkL+DmLrK3xSY6TgfjF96kUHeMhUb8vr6TJoWe3CmJN9vTdtiNXzJhHy5YVfUuSsvUZtdjbSak8DjTmr5v85toAVIYjGDouTu3QXClPQjtYF93p1uHMOdYiBCkF7w7hXOrazNtByWxBZtHE9YoW5q7DSydz6W6EWScMItgefSPClafcic2jAcq4qYEv5deYNVbrjebtxCKWUaFIhCeYTCcUaNL3uNvo/ynlFv9b5JKgmla3uYjpHZTq8RR/o0a7kptuH4e3hfIOl2VtGgesnMZmyD4GbsTuAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAfx2hCOE/YyKJ4xi/XVERXwNbOAnZgEYEN7mfIWDaU=;
 b=OCR1a20FUJr/OwAcbrgnIGlV1qkn72iqGR1gbHt9nDGvU+Uo9SUBMZecwqTVNcFeDqclh+fNdGBV1jWrNuEHnNzcz1io6SXmxw7XN8pTHSO3bhlPy2w8NdtrDv0ZmoKT5O3t8qqKb5jLLmEMFYzUiFMLwEPMPczckv3TRRES1lFOmXLtnyyNaAMOxXufueYPrIj1iZHBbCJTEB8cNPu8Y+rFNXh0HJz9MidAFvdmuWpt7mAEYYxzd6qkc7V+ZeOLUx9569siP2FkGUmVyD7XO5o6NyB+z5wYxkMKJ/NonrJL+NMkfoJ9CQFWIfr2VVwP8owoqcd8RYDW/qjhiMpJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAfx2hCOE/YyKJ4xi/XVERXwNbOAnZgEYEN7mfIWDaU=;
 b=d26kfmGVeNi5dUZ1MsRY5GKv8Sd7p5DLw69Pz6gHN9H5Ag/5J1hmqXk/TGhhTOqyNj+y+N6Y7jLxtL1EvGpvBI7y+/xh29RVK2jWQH3+NRF+RN05AE9ZUcEo2EdeNPEJF+r6CgrrQ5wiWKcra7evRfYjbDaJ9ejLPzpH6RoAs1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 11 May
 2025 20:37:26 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.8722.027; Sun, 11 May 2025
 20:37:26 +0000
Content-Type: multipart/alternative;
 boundary="------------NO1wBLSksrPPey6koxO4knJW"
Message-ID: <cb73b496-1008-4338-83f4-a1ddcb81be46@amd.com>
Date: Mon, 12 May 2025 02:07:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
To: John Olender <john.olender@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-2-john.olender@gmail.com>
 <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
 <2150d713-d9bf-400e-b51b-aee835431991@amd.com>
 <474bf7c1-f42a-4738-8ce0-24fced3b051c@gmail.com>
 <70f66e11-7baa-4aed-ac88-f823305001e3@amd.com>
 <fbf53dc5-01f0-496c-88b0-86eada7c5a91@amd.com>
Content-Language: en-US
In-Reply-To: <fbf53dc5-01f0-496c-88b0-86eada7c5a91@amd.com>
X-ClientProxiedBy: PN3PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::22) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 19388cda-7ad7-4cdc-9b4f-08dd90cba3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDZMMnpoZzlHZGVlUDdOaDVNUzFPZDBUNGVtVTVWRFBsNUJvQTNHZlpxeXpq?=
 =?utf-8?B?Z0hhRCtaeUhKYXNKV3hSU1ZJTlJjd0hEQmh2Znh5UE5ZMC9PK3I3cm9IeDlP?=
 =?utf-8?B?K1B3czcvV1JkZW1TUDBzNjJjdmRmRysyQjZuVzBNUXdaZjVJb1VITE9vRFkx?=
 =?utf-8?B?QklZUlBNQU5nRHN1RmY1a283a041dTlkR3pKWXJUMlpwdDl2Mm9FSVJ4VU9C?=
 =?utf-8?B?MHNuQ2FBcjJySzc5dGlZTkRaTHBlSGVLSklmVWE4YWl3b0E1Vkd2bnN1Tzdl?=
 =?utf-8?B?UUNuNWpsQVVNQ01wLzlxN3BNdEp0ZFV4MWF6WVZpMXhaVG8vb3diQ2xNdkta?=
 =?utf-8?B?eHJiVG5xZnVLcVVvMUVZN3pNcmRmZ2RBK0Q1Wk1EZERaODJZMHFDSWZVclZv?=
 =?utf-8?B?bzRBZ3c3KzJuZ2hxTGIwMkRvY1FTek5uaWgxOUVXTHZEMlZlKzJ5RjB1UU9B?=
 =?utf-8?B?aTFPVVhrR3dpZlpwQ1BKRkQ2TWtjc21PQmJOR2ExNWtYTWV5WWVDSWNGaWoy?=
 =?utf-8?B?c1FHK3NuTXBHampYQ3dZOXVSblZIc0hmcDlrTmtTaDZuMU5peUphLzUyQnl5?=
 =?utf-8?B?TDhSbFdRVER4TCtZa3dyRzhUckVwaDdRQkpYK3J5ZjhEd1VvYVA1aXlQMmc4?=
 =?utf-8?B?Yy9LTmd4WXlVdG1COGRDcXFpZ1pyNEN3S3lNVFovd1JlZC9sVHllYmdudzlB?=
 =?utf-8?B?TndEaGtvcmMvL0tvajFhS3I3UGx2L3k1M3dlY0xhWjJ0Umt0NCthTVo5bHY5?=
 =?utf-8?B?ZTl1Y3g2d3lGdWZ0UjVvOXR5KzBEQWI4aVgvRE9FNTVFc2xnT3E2MWQyYnRF?=
 =?utf-8?B?Qjl4RloxMFU1ZGxwdHZacVBvUG9HNFJvNHVFMk5iSUZLbnh0OGgrMWRaTnAx?=
 =?utf-8?B?anpkWXVzUlRnTHV0Zlp0Y2tIYmk5VlREQUUzcVJPcHJuOFhSRzc4NkhrbTN3?=
 =?utf-8?B?TE9TeXg4ZTNzVFM5VCtUTEo1WkhXaWVhaWJIaWxuT3FycGp3YnE1d3R3ektK?=
 =?utf-8?B?TFo3d0hXMjk2VmdFV2hKUHRRRm1DS1lFLyt1Zm13M1FXMUpkbmZLcDh0YU5j?=
 =?utf-8?B?MFMwMHRFQVRXZXNudUthSUlHSHVMQldjSm5WUVZnZVZlU1F6MGtLOC9oTVFT?=
 =?utf-8?B?a2JHbjBqQXZMYU5pSGI4S1dHUUNtSlQxTXpJdjB2VzZKOFB2MWNEb25zdng1?=
 =?utf-8?B?Y3UveHlNZ2VhY3FKM3hQMk1iMC9IVXdONDlDRUtwVnZwWGVrS2Ywb1hRUEhY?=
 =?utf-8?B?ZlVXNVp0VHdJaVZ1RDFCWGpiRVZJd1J5NlFDQ3lPbE9HVituVDlxdlhTd1Rq?=
 =?utf-8?B?citueWlPdERXTHN2M3ZPOXg1RHcrd1lvVVhiYU1tV0hYTnJxcFpyaER4WXJz?=
 =?utf-8?B?c3FkSjBOcjZLZjlaa2dKd0VsYjJhR2t6NlBvWTVxSWlRL0FCWi9LTjU1NnlE?=
 =?utf-8?B?MDB3VlNsdFU0UFR3K0ppSXBJZlZhR0p3UHhlTWVrYW42TTNZcnBrWU00YUtm?=
 =?utf-8?B?dDYzY2p0dThZWTg2S3Vzc0lkb1ZKUWFsRElyVFMwUzd6ZE5KNkRES0NtQkR3?=
 =?utf-8?B?QnlYS090Q3V2bjRoYm1ySnRydmt3eDZPUzFENjhZNkhvM3hPUS9FVDQ3bWNU?=
 =?utf-8?B?ZmtDLzRoOWIzeEVSdlVWVFZQaWRhTWlKY2dnaWc0M3YxekNIbGNvOWxFVU84?=
 =?utf-8?B?aC9DRzQvcU9YTGtVSXR3S2pJb1pzcUYrSHpuZjhSVnZqdDNZOERBbVdzeUk5?=
 =?utf-8?B?RzhkdndML2NwQWRjOUw2SXRKbk1iYU44b0NsekxFR2xCNDB6UGh0cGhEME5F?=
 =?utf-8?Q?gyKwmf1V5VU80nn0IDjeq/7AcvkEyT5/kdo1A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRiM2V4Y0VJM2FHeXNCN05GdzFYZ2VBK2QvdHN0YUJUcytNQW5yaXczVmhl?=
 =?utf-8?B?dTJ1V0QwU2QwZnBDNW0yTUlsaDYveWNzdUthYWZHZVZpcW1DSkcxKzZJWmRT?=
 =?utf-8?B?WDBCTjJNT0huWHh1SkxGMVNvTk9EVFViV0hraVdqYy9GVTJTSXMzZ200NUV4?=
 =?utf-8?B?K1JsUDIrcFY4aUNwQXBuUElTdVR3MjArSG9nb1Znalg5OWtyUFBrcStsSXZu?=
 =?utf-8?B?OWppZG52eFpjKzRTM3hVQmQ3c05pTWo5eVA1TlVyRExKNE9hL2kwTmtsMk9p?=
 =?utf-8?B?Qm55WEV1UFJtYlhBQW53Yk14ajRrek0xWGxXbXhISmcwVzFlamFON3dRSnVX?=
 =?utf-8?B?dExTZkxVYk5BWDFTVk8wQlBKcDZURThzZFp2MDh4WlZ2K05sWk1POUh3eDhx?=
 =?utf-8?B?UXk4R29XK1ZSWTFUdWw0eCtqWGM0Smp1QUVNS0FDdDhFRkpXOWlxSHErajkv?=
 =?utf-8?B?RFJnZDRsQVhnSkVVdkdJSTVEYnpVbHpITE14NmlJVkV1YUhWZEl5R3pRK1Er?=
 =?utf-8?B?d2VIL1JyWGh3eS81NFpPalBzTjhMZ2tTSkNzdTBRQzYzZHplZVJYZ3J6MjlI?=
 =?utf-8?B?MXBoeHdPZ1hmMWxSdWRRTEV4T1p4ZXJJbkw5MWQyTThWbEhRdkx2UGhOWEdE?=
 =?utf-8?B?UDZVc2lESXZ3eU4xQ3NGOTJIckFoRVdkZTVDT0w3bTg5ZFg3TDE2ZmFXWDB4?=
 =?utf-8?B?MWd6M09ndFNxT2ZxekF5cFE2NVViVDFEaFc4MEc0YmdQMFVva1J2NWgzejFy?=
 =?utf-8?B?TFQ5bTJUZlNmeDcvcXl2enNIYUFLV2I1anE3TXRZVksyNmpzQ3VmbVBUc2s3?=
 =?utf-8?B?U1ZkQyttOGErelpZQlJiOW91ZlVKN0ZWck9Udi93VUY0VG01dEsySEEwT0pU?=
 =?utf-8?B?U253RUNtVXI3dnMyU1JnS0RnRE0vMW9JOGd1a29vRUlSbUZGeFRxZVZnTXNK?=
 =?utf-8?B?UG9mQ3BGR1A1dFgrRytSYStFQUNYRVJiQ2llWlB3TmYxWkt4VndKS0w0OXNS?=
 =?utf-8?B?SVhTUTRtZFNPUVpOdUNpa0FxNWJXbG1iTGpzQlZkZ05tVXlMQnlNNEw1Tk1F?=
 =?utf-8?B?NE12R2RhWFA5SFpheUZ2ZUlkQmg3eTFNZGJSQUo0WnVGdkVGYTg0Mk1ydnZy?=
 =?utf-8?B?Uk1tbnFuK3JxZjBkdlNUWStobGtLL2lMVEdhY3dsSnBkOURhZkF2YVVTZlN0?=
 =?utf-8?B?d3dTS3RWeXBVdmFqL21hZnBjUmJYMlRGWUZMK0Vrc0MwZVE0MVIwdCtnN3dP?=
 =?utf-8?B?QTIxZTloU01oQkZsZUdsbUlDU04zcmdWTTFmbFc1aG1vQi91S2NZeU9tSUkw?=
 =?utf-8?B?VE1uTDRvKzl6OVh0cWdEMTJ6eFQ0UGhkakJCeFBEUXFOdTBqUlVFR0diTTdE?=
 =?utf-8?B?UzFsSHpqbTNWNWUzUWh3QVRuakZ4QTVnc0tLdVpqb2NDMUYycTlxZW1WbDJ2?=
 =?utf-8?B?Z011ZnhpVVhzNUYvOWJIK21qdDhPbEZUOFBOVy82cTZZYTQ3UklwcCtJdGRE?=
 =?utf-8?B?SFVtZWoyOHRNYXRMdjZYQytOTjRwaXNmK0dFLzVaTUs1M2NZZm82cXh1blZ2?=
 =?utf-8?B?MVB4aFRYNngrNDJFNXhYRkpXMkthOVoyZDR5dUVPZjFzVnhCNmIzQ09zY294?=
 =?utf-8?B?RUN4bUdBTzlIOWJvMUhvSkZJbXlnZlhVSDNQajhvbnVLc3RsMFd4djIwRitr?=
 =?utf-8?B?cDZ4Z05FUXA0ZFI2T0V0KytETDZ0a0xJVzUxS0Q3dm9RS09kT3NxMVlTMFNG?=
 =?utf-8?B?aVZkZFFSVm5XZ0REWDJZaStXK0JFbi9NWXM2MzJUSDZubE8yYStNWGRhL2hl?=
 =?utf-8?B?WGlCS3hOcHUvMlp6U21XdGJWbE5VZStiSUVkV0Z5Zk1NQVJCQmNuVTgxOXFx?=
 =?utf-8?B?Q05USjdaZElNMlVLSmZFRzNjRjA0ZmtrbWR4V3BZNDdqZWdxQi8zOXFFUU9N?=
 =?utf-8?B?a21nY2I2TUhZREljQmhXT1ZWNSs2VHRWU2VzWkRFclpqS21ucVpyd1Z2WTBH?=
 =?utf-8?B?YTdvdVRkVGphd0Vhc0ZldDQwd1ZRZHlwV2JRSmswb1AzNUVoUXJ2WW52THgv?=
 =?utf-8?B?YTBkb3AxNTJpc0czVzRsK3FJZ2x5bG1MT0lpbjdsMDJ6K2thc2w1WC8xSW5L?=
 =?utf-8?Q?K3t3u6QusL/Ckixl0Ye4T418I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19388cda-7ad7-4cdc-9b4f-08dd90cba3e7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 20:37:26.2612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bTz8s/d8gITs4/CJcLicISVvdu1HaLXD9kEbykLe9b3eJ9fCn2kI2xu6XJNbfrCvmLZIwYI4715xB4RUULtVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
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

--------------NO1wBLSksrPPey6koxO4knJW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/12/2025 2:03 AM, Paneer Selvam, Arunpravin wrote:
>
>
> On 5/3/2025 5:53 PM, Paneer Selvam, Arunpravin wrote:
>>
>>
>> On 5/2/2025 9:02 PM, John Olender wrote:
>>> On 4/30/25 5:44 PM, Paneer Selvam, Arunpravin wrote:
>>>>
>>>> On 5/1/2025 2:50 AM, Alex Deucher wrote:
>>>>> + Christian
>>>>>
>>>>> On Tue, Apr 29, 2025 at 7:24 AM John Olender <john.olender@gmail.com>
>>>>> wrote:
>>>>>> The drm_mm allocator tolerated being passed end > mm->size, but the
>>>>>> drm_buddy allocator does not.
>>>>>>
>>>>>> Restore the pre-buddy-allocator behavior of allowing such 
>>>>>> placements.
>>>>>>
>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
>>>>>> Signed-off-by: John Olender <john.olender@gmail.com>
>>>>> This looks correct to me.
>>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>> I was thinking that we should return an error when lpfn > man->size.
>>>>
>>>> Regards,
>>>> Arun.
>>> This patch restores the previous behavior in the spirit of "Do not 
>>> crash
>>> the kernel".  The existing uvd placements are pretty clear in their
>>> intent and were accepted until the switch to drm_buddy.  I think it's
>>> fair to consider their style as expected.
>>>
>>> With that in mind, I'm not sure amdgpu_vram_mgr is the place this 
>>> change
>>> really belongs.  That is, I think it's worth asking:
>>>
>>> 1) Why does drm_mm accept end > mm->size without complaint?
>>> 2) Why doesn't drm_buddy do the same?
>>
>> I remember that during the development of DRM buddy , we had a 
>> discussion with Intel folks and decided to
>> return an error in DRM buddy when end > mm->size. This was done to 
>> ensure that, at the driver level,  lpfn
>> has the correct value.
>>
>> I will modify this at drm_buddy to match with drm_mm and send the patch.
> After giving it some thought, I think it is more effective to 
> implement this tolerance at the VRAM manager level
> and allow the DRM buddy manager to perform a strict validation, as 
> this is necessary for other graphics drivers
> (e.g., i915).

Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> Regards,
> Arun.
>>
>> Regards,
>> Arun.
>>>
>>> Thanks,
>>> John
>>>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/
>>>>>> gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>> index 2d7f82e98df9..abdc52b0895a 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>> @@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct
>>>>>> ttm_resource_manager *man,
>>>>>>           int r;
>>>>>>
>>>>>>           lpfn = (u64)place->lpfn << PAGE_SHIFT;
>>>>>> -       if (!lpfn)
>>>>>> +       if (!lpfn || lpfn > man->size)
>>>>>>                   lpfn = man->size;
>>>>>>
>>>>>>           fpfn = (u64)place->fpfn << PAGE_SHIFT;
>>>>>> -- 
>>>>>> 2.47.2
>>>>>>
>>
>

--------------NO1wBLSksrPPey6koxO4knJW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 5/12/2025 2:03 AM, Paneer Selvam,
      Arunpravin wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:fbf53dc5-01f0-496c-88b0-86eada7c5a91@amd.com">
      <br>
      <br>
      On 5/3/2025 5:53 PM, Paneer Selvam, Arunpravin wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 5/2/2025 9:02 PM, John Olender wrote:
        <br>
        <blockquote type="cite">On 4/30/25 5:44 PM, Paneer Selvam,
          Arunpravin wrote:
          <br>
          <blockquote type="cite">
            <br>
            On 5/1/2025 2:50 AM, Alex Deucher wrote:
            <br>
            <blockquote type="cite">+ Christian
              <br>
              <br>
              On Tue, Apr 29, 2025 at 7:24 AM John Olender
              <a class="moz-txt-link-rfc2396E" href="mailto:john.olender@gmail.com">&lt;john.olender@gmail.com&gt;</a>
              <br>
              wrote:
              <br>
              <blockquote type="cite">The drm_mm allocator tolerated
                being passed end &gt; mm-&gt;size, but the
                <br>
                drm_buddy allocator does not.
                <br>
                <br>
                Restore the pre-buddy-allocator behavior of allowing
                such placements.
                <br>
                <br>
                Closes:
                <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/3448">https://gitlab.freedesktop.org/drm/amd/-/issues/3448</a>
                <br>
                Signed-off-by: John Olender
                <a class="moz-txt-link-rfc2396E" href="mailto:john.olender@gmail.com">&lt;john.olender@gmail.com&gt;</a>
                <br>
              </blockquote>
              This looks correct to me.
              <br>
              Reviewed-by: Alex Deucher
              <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
              <br>
            </blockquote>
            I was thinking that we should return an error when lpfn &gt;
            man-&gt;size.
            <br>
            <br>
            Regards,
            <br>
            Arun.
            <br>
          </blockquote>
          This patch restores the previous behavior in the spirit of &quot;Do
          not crash
          <br>
          the kernel&quot;.&nbsp; The existing uvd placements are pretty clear in
          their
          <br>
          intent and were accepted until the switch to drm_buddy.&nbsp; I
          think it's
          <br>
          fair to consider their style as expected.
          <br>
          <br>
          With that in mind, I'm not sure amdgpu_vram_mgr is the place
          this change
          <br>
          really belongs.&nbsp; That is, I think it's worth asking:
          <br>
          <br>
          1) Why does drm_mm accept end &gt; mm-&gt;size without
          complaint?
          <br>
          2) Why doesn't drm_buddy do the same?
          <br>
        </blockquote>
        <br>
        I remember that during the development of DRM buddy , we had a
        discussion with Intel folks and decided to
        <br>
        return an error in DRM buddy when end &gt; mm-&gt;size. This was
        done to ensure that, at the driver level,&nbsp; lpfn
        <br>
        has the correct value.
        <br>
        <br>
        I will modify this at drm_buddy to match with drm_mm and send
        the patch.
        <br>
      </blockquote>
      After giving it some thought, I think it is more effective to
      implement this tolerance at the VRAM manager level
      <br>
      and allow the DRM buddy manager to perform a strict validation, as
      this is necessary for other graphics drivers
      <br>
      (e.g., i915).
      <br>
    </blockquote>
    <br>
    Reviewed-by:
    Arunpravin Paneer Selvam &lt;<a href="mailto:Arunpravin.PaneerSelvam@amd.com" class="moz-txt-link-freetext">Arunpravin.PaneerSelvam@amd.com</a>&gt;
    <blockquote type="cite" cite="mid:fbf53dc5-01f0-496c-88b0-86eada7c5a91@amd.com">
      <br>
      Regards,
      <br>
      Arun.
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        Arun.
        <br>
        <blockquote type="cite">
          <br>
          Thanks,
          <br>
          John
          <br>
          <br>
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">---
                <br>
                &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
                <br>
                &nbsp;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)
                <br>
                <br>
                diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
                b/drivers/
                <br>
                gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
                <br>
                index 2d7f82e98df9..abdc52b0895a 100644
                <br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
                <br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
                <br>
                @@ -463,7 +463,7 @@ static int
                amdgpu_vram_mgr_new(struct
                <br>
                ttm_resource_manager *man,
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
                <br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lpfn = (u64)place-&gt;lpfn &lt;&lt;
                PAGE_SHIFT;
                <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!lpfn)
                <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!lpfn || lpfn &gt; man-&gt;size)
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lpfn = man-&gt;size;
                <br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fpfn = (u64)place-&gt;fpfn &lt;&lt;
                PAGE_SHIFT;
                <br>
                --&nbsp;<br>
                2.47.2
                <br>
                <br>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------NO1wBLSksrPPey6koxO4knJW--

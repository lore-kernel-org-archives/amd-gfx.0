Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE8EC02194
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 17:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCB810E1F4;
	Fri, 31 Jan 2025 17:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yjfi0yIz";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3915910E1F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 17:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVtPOteiVSFs+dWxRO3qeEdqGVQwR/p3nDfbD+HJvSWqZ5J6AeDXkhpKvbfmSYz7Hzl+1B1xyVEvsdXuGtqoC6YVrpZQARdBzgzHWYbbVYyB5KlmpkcoJEro0JhLwT/njXQ70B3ByWbhhwSdIR+m8PpLAAYwoPWLaY/NsUed7JbGgYMzElCImuAGU1B+Bv1G8ZL5Nh1iDrWXVhnSEIzD3OUoUWjCa9/iELziz4TdIA94BnG0YO0Ts/7IdE6660jVWuPkeP3Fak7jdRA2dxqYpxi/Pk1OrEmfRkHF5CImdoD3lX73C+CIHhFxhiLqhEn+/ICswal81d7AoE9ApB8Sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njbrZGvQ4xTwZFSYe0xHYxdO77hajhBWenZf1EArako=;
 b=n5mzns8Q/f1ktH1Z7g1qlUlab18NP2UBjKGlYt9ewAFvJqd9ydo9A3uDPLsT6dsa6qGla1yNqKOTN8Qov6u773lWwaeSunweQeYZXSJdnyAcc/jhA/hx0owBvB1oQPMJkp61O6C3AgAl8x/+ejY/imIiZbWRekfRruhyABihH6TrAo3EKO1LbFNxfhd/F6Q/wM4cNUvPxAb8AVZJei8l6hewUgvLrmz3TFtvSaMsVEP/feHyvltMZwEslWuZWWfZPB+YwOXCHQxp6440iVJgHoqRTdo84/lBT/M0IqgR/dTtSWO2Ksgncdq2Fm47chFSDLVif3mdyg7e5hiAFe2RYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njbrZGvQ4xTwZFSYe0xHYxdO77hajhBWenZf1EArako=;
 b=Yjfi0yIz1j7uUJcKSFg0tEnNAsT/L+BLxvs76hIiQrzbACA1M0QPlRx453ulX2sq4ZaKOIvpa1HdCAhAsthrWk/qZ3QVhvisGl+S+OKVVrOPQ+VE4GMWvQ9ShgArfnn2LCkBekjZ1rY3Pqx7NEtTnhq7UCH/TF7SYDL5elaXMno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 17:05:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 17:05:28 +0000
Message-ID: <fb4969e5-90ab-425d-a43d-f78002dd805e@amd.com>
Date: Fri, 31 Jan 2025 18:05:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
 <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
 <8371968e-e270-490e-9454-b521edceef37@amd.com>
 <8b9995da-269c-4a96-b374-09e40e0df605@amd.com>
 <8a8f4581-0185-4180-89e6-aa4d01260cae@amd.com>
 <d4bcf2db-bd16-4282-b086-27969225f27c@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d4bcf2db-bd16-4282-b086-27969225f27c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 139cabf8-58db-4773-db79-08dd4219764e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEhiMHR6S0tTMzFuRW1MOUR3cUNYZDlvNi8zUDV1a2I5VDNhWTZLdS9udVh2?=
 =?utf-8?B?dkwrM0pKaFU5dGM0VTcvK1lzZUpnc0VqakZsUnZoWTJ6VlhMaUdsUFhSK20y?=
 =?utf-8?B?eUdJSjBjNENwTGJBZzRnWUFhQjdQVDg0TmtYZ1IyVkVPWnlaZmM0eHhNTlB2?=
 =?utf-8?B?ZmdLMmFrVEhSOFMzYXBTVzZFZUhPVTNlSm8xdkR0VlhGV3FqT0xLbStJK0Ju?=
 =?utf-8?B?N0dQUUEzMVNRcDJKcTI5SytQK3ZZdjY5VE9Jb0tjaDR2YVdVY3p5eVZTRjVw?=
 =?utf-8?B?TDE1MkFwL1J5WDRaNnpvcXhEUThaQlczZVREL0ZWM0l2RG85REJCTG8yaUdH?=
 =?utf-8?B?TTVBQmpsc01mSnFmUlhvNTUzT3ZuZXUyaHg3UExEM1dnWk11YW4yYXZDRUht?=
 =?utf-8?B?YU9Rb0d3MTJGRmJaanltTTh6UHVoOCtmSkxSSkNuU2d6ZkhMWUo5b1RHYWZN?=
 =?utf-8?B?dEtwWURBQzNDeGoyYktnb3FjRGY5SVdCL3hRUE43MzI0amMxWTNISlNrKy8r?=
 =?utf-8?B?TmZqUHprZjhoUG9DQzl4MldnejRUS3VBZVIvRTBZdmE0M3R5d1ZObzlLOXNr?=
 =?utf-8?B?SDhibWMyNTRRTHpLNWtHcnU1Tmx4aEFhMDlFdmR2SVdET1hXUUdsU3R6eXNZ?=
 =?utf-8?B?Q2d4dVUwK1d2WUhCajFxdWU0UXJQT2FQTHRlanQ0dHYvSytJakwvQjF2L1Fw?=
 =?utf-8?B?cVBjY09lbUdOOEVwc0VUUzNpRi9BNHhrS2c5TjIwcmNxVDFPWVkraStERkNp?=
 =?utf-8?B?OVl2NWZsNVVycmREL3VjTXB5MXlzWFZJeVBROTBxb1ExOFVrZkUzb3llZDNa?=
 =?utf-8?B?N0ZQSEUvU3RGbmdOU2sxTUt3OVFrQTVFSnBaSnNqMUFpRFJXSVZnU3h3b1ZG?=
 =?utf-8?B?Y1d4R2YxWTFHeVBuUm54aXhiN2YvdEZpdWJURWlFdlBjbFoyYndpckJIUGhx?=
 =?utf-8?B?NDJzbmFCQ1dlWks3ODVlcytSMUhvQ1ZGU3RCSm1seEdKZlAzQlNOL1ZZY3RT?=
 =?utf-8?B?K1VrQXg4M1o0RFNHQnRFQ3l0b21oblBwbk83cXlFR0NRcDUzM0hiQU1KTW0r?=
 =?utf-8?B?RkEwNEk5VHZCWlEvUEdNNXZ5SnNWRzdDWk1zQ3RTQXFXWHVZNGVIWEowK1hH?=
 =?utf-8?B?RWJ0MWhLanI0ditwRDNURGFXcFVFMjZ1UjJZcU4vWElBa0FPWElwUUhncExN?=
 =?utf-8?B?UVNaZE8zNjg0alh4UW5xUW96MUVWM0tFRmxCc1BkNWZ2cGJ1WWF3eE1wQk1Y?=
 =?utf-8?B?N0IzZUlyY3pRWUdXT0x1UzhhenhRamNKZjJHckZMbEt1S05oNlh4aGdTREZq?=
 =?utf-8?B?cmJGd1RXS0lSenR5UkxuTW5yRXBiVlhPckVWRmxVN2NhVytMYnRtKy9qWlVu?=
 =?utf-8?B?VHM4djJsV2I4dGZ1MEdaTWNKVkFhYVRud0tMVURRUFRtTjFoOGRUai9pdW13?=
 =?utf-8?B?M0lyOGhHWGxlZjAzM05KUkVRME5WK0ZHbzJGMTRZTlVqN0tlaXBPNG9xeUd2?=
 =?utf-8?B?cTYybGErVUNhWkkyWWR0V28rY3ZHU0RtTXZhd05lbFQreG1sMXRtVHg0alNt?=
 =?utf-8?B?Z0NJS005M0Ewb1JEWGo4bDAwbGRQZGViZDl1d2tzWU5nMEVpazhGanhtOFFr?=
 =?utf-8?B?T3Rlc2o1bFZIenNDU05mRmxVWXhqTFAzSWliOEN2UUIwRHdLTE1RQXhhSUpx?=
 =?utf-8?B?eGF0Nm4zRnlidU5sTDVGd2Vqakt4M0EzR0ZNUTBKRDlQNHhiaEY1akw1SDc3?=
 =?utf-8?B?QVhwVUhvbVU2YnU2T1RrMk8rTGF4TWM3RHg5Smd2TXptZmJXQmtRNEZGYWZR?=
 =?utf-8?B?NWYzQis3azhWbDd4UG80WTdBUGRFckpFS2xHZmFVUXNFeHB1L1JWeFNoMXpV?=
 =?utf-8?Q?MrXn+kBoEORnr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmNHaFFub24zOXFvdURsM2JwTnM5cW8yYXZHc1pLcHB0NGxTTDA2c0l5bkhr?=
 =?utf-8?B?Ym9LeTBTOVgwb1o1QnhjY29LM3BybUY0RHFrTkhsL0ZpZWZyTnJDcmpydEJY?=
 =?utf-8?B?Z3lQb2U5OW5XVlBLL2dDV2tTSjFUU2lMTjlUT2hXcUdpWjdNN2FrWmZhakZC?=
 =?utf-8?B?a3d2TWE5Wm5EblpwbnhxNmJjK3QwaGo5YjlTZkVjU1phRzN6eXNnYlQyYktL?=
 =?utf-8?B?cGluVkp2YlZpVmhLMEpjUDM4L2hRaWpWYS9pNEo0S0t5MzdGTmVUT2drNldP?=
 =?utf-8?B?YTFhVkFQRDBHNkRWUjQ2ektVVmJiblIzdkV6M1NGYkE0d1JXeHMxQnpKTFNs?=
 =?utf-8?B?NFdHQmdodHcwb0lOc0tSNXlLRGJpdytiWnZUaTF6b0xMaXIvU0cwT3NVYUo3?=
 =?utf-8?B?aVVMZUg3RXUwU0c2RHhBSmEwSFB5VVhGdEd4NUs3R09QUnJQZ3VWK05DRUNV?=
 =?utf-8?B?L3htYnB0WVgvRis4K3grWmxRcUtaWHZ1SXNadHRra0k0UHZpVDVacDBlZ1VE?=
 =?utf-8?B?b1VpWEhqcjFNdGxRdG9sdkkzcTNaTmUzbGpibkIrNXpXc3NkVVJMLzJic0xw?=
 =?utf-8?B?ODF1MFlnV0xhaDlQbFMwZWNjTGN4amFVTjNTQXBzMXp1ZUhxUkpScEE1ZHl3?=
 =?utf-8?B?RGovL0NEN2lIYkJzTStZdmdBUmlXckE2Z21qcCttSXE4WkVhY2ZBeVBCd2M2?=
 =?utf-8?B?dWJvVmp4cHBmN0h6elg2S25Fb3dFY0FuSDJGaHVacEZBL25YMGd1ZTFBemRo?=
 =?utf-8?B?Y3hBQUlPYUJHaUo1dGg5RTBSTEpvOXpBNFMxY1dNaTVnUExXNkVuaXVOZXI1?=
 =?utf-8?B?d3BuQzFsaXRGbVRKdXBySXZGM1F5UHRaNmNiNjBrL2tOUmFKak9nZW9CaGtG?=
 =?utf-8?B?cVhKay9iQzFGNExmekpWU0xCaWxRS3RsLzJoOGVSUzFxQVhsUFdjcU5YOGpx?=
 =?utf-8?B?SllVbEJqSzdGQzdlR3ZPRmlQbWRmdzZ2QjZDT2xOa0pHRjB2b01GSVNIQmxC?=
 =?utf-8?B?WUJteEpGMzNPOGwxZXVlVjhLd3VUdjJ5aWRqdFk0aWVWQjYxMlpQKzNTQSsx?=
 =?utf-8?B?NGdpNnUwWTNNMHRGTVZidUtwdkpkM2R5b2V3UEsxMjdHcXJDaURvZTZ2Wm93?=
 =?utf-8?B?cTg3WmhSQTY4UWh0eTM4dW9sd3J2ZUI2NGJUSktpVnpySU9WKzlxYVN1aTBl?=
 =?utf-8?B?bWxMMCtlanVJaE9FelNTQmw2ZWVIbVM4WmJCYlBXQTJXeDNuK3ZXa24wK3hD?=
 =?utf-8?B?SUR5b1JRRFEzS3gyQVlDWnlkczd6eFRtNkRjZmphMVZaY2RhMFVHdFlQWGwx?=
 =?utf-8?B?d2M1Q3FmdDQ0d0pXbGZxM2UvVFd1Y1V0czRWTE1id3N3OS9lcGV4aEhWaGhm?=
 =?utf-8?B?eTRGRlIxMUZwMVZTL1gyZVRHTUFXZHBGTFY5SDE0dDRrMjJOcE1jdVY0TVFr?=
 =?utf-8?B?dkJ1by84ZFlieHk5S1ZVZFpFVTl2K1NyOGwrRWQwWUhMKzIxelZjUGhodXkr?=
 =?utf-8?B?azZOWm9HcFVmajE2eEdIT0dwdzE1ZUdvL1ZZbDh2ZDNyU0puVm9uR0VDa1BM?=
 =?utf-8?B?QW5Ba3QxaVZITHJtU3JnREpnSncvYXJScUlDeDNGZWlqREx3alM0eVhxMy9B?=
 =?utf-8?B?eFI4NTlxK1FUazVWbk43MXEyV1E3dkdnTmZ3RExPUFRQZGFMQTRTSUdZeStD?=
 =?utf-8?B?OG1PTkR0dDgrQklsMTVOMjl6ZGFqcC84VlpRZG5jNElMZnNQQ3hqOUwxVC80?=
 =?utf-8?B?ZGp2MFRONTNnb05TQ2xiU0huVFVONmg5SHJ2MmtIMVhDT0dGMnFhR0tYZUZM?=
 =?utf-8?B?T0doQmZVMUREWkFSSWRRTFBKSXdmZ0E1TTRXbVUyTGJDM052d3g2S0pqUFhK?=
 =?utf-8?B?bU1NbkYvZDRxY0htZmZGa1ZXZmZrY1ZSalROM1RpSzRkL3dLOG1YQjBwdFVN?=
 =?utf-8?B?UjBYOVZsRWhPbVk4NE54d0tSYzlYRTFnM2VZZzNuS20rWitDTU13SWdHMWI4?=
 =?utf-8?B?UUJtQm5oaG80Wm8vMjlPREwvM29vVGZBd3pvM09vTzJWRnZseE5SV1k1OXZj?=
 =?utf-8?B?cERxVkRiKzloclFXMXJXNHRPbll0TzdJZjlzOVVxTm1TdFZlSkJ0Qm1lbWZ4?=
 =?utf-8?Q?WRLoDaNEFC3O7gSndUyLvk4BM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139cabf8-58db-4773-db79-08dd4219764e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 17:05:28.4599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dbqi1K2Kvv0m9/SnLx9QUuMGOU+A/pjkxoE+uedF3kpWooZHPiJCJPDCtt5t/i31
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896
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

Am 31.01.25 um 17:55 schrieb Sundararaju, Sathishkumar:
> On 1/31/2025 10:19 PM, Christian König wrote:
>> Am 31.01.25 um 17:40 schrieb Sundararaju, Sathishkumar:
>>> Hi Christian,
>>>
>>>
>>> On 1/31/2025 9:56 PM, Christian König wrote:
>>>> Am 31.01.25 um 17:23 schrieb Sathishkumar S:
>>>>> Add ring reset function callback for JPEG4_0_3 to
>>>>> recover from job timeouts without a full gpu reset.
>>>>>
>>>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 
>>>>> ++++++++++++++++++++++--
>>>>>   1 file changed, 57 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>> index be0b3b4c8690..62d8628dccc5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>> @@ -204,9 +204,7 @@ static int jpeg_v4_0_3_sw_init(struct 
>>>>> amdgpu_ip_block *ip_block)
>>>>>       if (r)
>>>>>           return r;
>>>>>   -    /* TODO: Add queue reset mask when FW fully supports it */
>>>>> -    adev->jpeg.supported_reset =
>>>>> - amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>>>>> +    adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
>>>>>       r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>>>>>       if (r)
>>>>>           return r;
>>>>> @@ -231,6 +229,7 @@ static int jpeg_v4_0_3_sw_fini(struct 
>>>>> amdgpu_ip_block *ip_block)
>>>>>           return r;
>>>>>         amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>>>>> +
>>>>>       r = amdgpu_jpeg_sw_fini(adev);
>>>>>         return r;
>>>>> @@ -1099,6 +1098,60 @@ static int 
>>>>> jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>>>>>       return 0;
>>>>>   }
>>>>>   +static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring 
>>>>> *ring)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>> +    struct amdgpu_ring *r;
>>>>> +    int ret, j;
>>>>> +
>>>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>>>> +        r->sched.ready = false;
>>>>> +    }
>>>>> +    /* publish update */
>>>>> +    smp_rmb();
>>>>
>>>> Using smp_rmb() to publish the update is 100% incorrect.
>>>>
>>>> What exactly are you trying to do?
>>> On JPEG4_0_3, there are possibly multiple contexts submitting jobs 
>>> to all cores on the affected instance,
>>> so I am changing sched_ready to false and using smp_rmb() to publish 
>>> to other cores which are trying to
>>> submit on this instance , for them to read the updated change 
>>> immediately and stop submission before
>>> I wait for idle on this instance, which makes sure other good 
>>> contexts of jpeg get a chance to be migrated
>>> out to any available instance before reset starts, that way good 
>>> jpeg contexts get a chance to continue
>>> without issues while this instance is being reset and made ready to 
>>> continue decoding after reset.
>>
>> Ok, completely NAK to this approach!
>>
>> First of all setting r->sched.ready to false is a completely no-go. I 
>> can't remember how often I had to remove that nonsense.
>>
>> With the exception of the KIQ the back-ends should *never* touch that 
>> stuff!
>>
>> Then the Linux kernel requires that ever use of smp_rmb() requires to 
>> document the matching write memory barrier.
>>
>> Over all please completely remove that code all together. The wait 
>> for idle function is *only* supposed to wait for the HW to become 
>> idle and nothing else.
>
> Okay Christian, Thank you for explaining , I will remove this.

Thanks! I just have one question: Why do you got the impression that you 
need to do this?

The problem here is that the higher level takes care of stopping 
submissions and when the backends starts to mess with that state 
(sched.ready for example) it causes tons of problems at other places.

So I had to remove code like this literally between twenty or thirty 
times already and I really need to find a way to better document that 
this is the wrong approach to stop people from coding that in the first 
place.

Thanks,
Christian.

>
> Regards,
> Sathish
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>> Sathish
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>
>>>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>>>> +        if (r->pipe == j)
>>>>> +            continue;
>>>>> +        ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, 
>>>>> ring->me),
>>>>> +                        regUVD_JRBC0_UVD_JRBC_STATUS,
>>>>> +                        jpeg_v4_0_3_core_reg_offset(j),
>>>>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
>>>>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>>>>> +        if (ret)
>>>>> +            return ret;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, 
>>>>> unsigned int vmid)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>> +    struct amdgpu_ring *r;
>>>>> +    int ret, j;
>>>>> +
>>>>> +    if (amdgpu_sriov_vf(adev))
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    jpeg_v4_0_3_wait_for_idle_on_inst(ring);
>>>>> +    jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
>>>>> +    jpeg_v4_0_3_start_inst(ring->adev, ring->me);
>>>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>>>> +        jpeg_v4_0_3_start_jrbc(r);
>>>>> +        ret = amdgpu_ring_test_helper(r);
>>>>> +        if (ret)
>>>>> +            return ret;
>>>>> +        r->sched.ready = true;
>>>>> +    }
>>>>> +    /* publish update */
>>>>> +    smp_rmb();
>>>>> +    dev_info(adev->dev, "Reset on %s succeeded\n", 
>>>>> ring->sched.name);
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>>>>>       .name = "jpeg_v4_0_3",
>>>>>       .early_init = jpeg_v4_0_3_early_init,
>>>>> @@ -1145,6 +1198,7 @@ static const struct amdgpu_ring_funcs 
>>>>> jpeg_v4_0_3_dec_ring_vm_funcs = {
>>>>>       .emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>>>>>       .emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>>>>>       .emit_reg_write_reg_wait = 
>>>>> amdgpu_ring_emit_reg_write_reg_wait_helper,
>>>>> +    .reset = jpeg_v4_0_3_ring_reset,
>>>>>   };
>>>>>     static void jpeg_v4_0_3_set_dec_ring_funcs(struct 
>>>>> amdgpu_device *adev)
>>>>
>>>
>>
>


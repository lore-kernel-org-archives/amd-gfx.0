Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A56BCEACFF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 20:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D66710E11A;
	Tue,  1 Oct 2024 20:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eEWoVmpr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9B210E11A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 20:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjEm+KvImdyuiXKSnwn4+zmCZUMHRdsqHRVnid1l6VISplxTocgAI7TFjjED6WY0w+KgRjhVReOLy30FMcXOhJh7T71ig700ErIvB23/PASaMgk03tFYQHUMsQITMqMmRRw7dx6vwwPG0R2EevqzeTunWDKna0OLb95ephMGvYq3O8rlhtpP9KBU1T9j5akrG7HG39E8bdOtcp1m2bB3bf8QFbaGRAaLdl4vjbzp5pE68PdQa3uFzJgr2lCdZaYmS3CrE/ew797gPfzcziW6xh6p4UjFurdwL56riUCBFgnN0zIxBGmCumOlyPEMfzaX9T2vbAhFX02MTuT2qZSSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WN0ubAhFwIgiY8haboOqiSeTDnDVfz3KDO4s/pBaCU=;
 b=JtNeXi3x8jA9lqYWOQEOQaSVqZO3tJ+sgye7D5JdJNWL6wsFE0qSrHrRBerLdKKvBbEEy3PlgW29iN0bNabr1Uoj/0gcKBhYIGYs5jMV/VHEdW4yJNItu/IuP9Dv4zsRERUQPHmqaQWuzQvKjU8QeJMUXG5WprE1O/Y5ZgSdWB3nQEuP/ijk+vG0gvWcBDBsUizTj9s+jr/h49mf+KFxIo5Jht9bnZZEKPitPgW/J+Bgug0S0jjRez6zhSeV1KHDh6Di4dHpXcQ7VP4emNoFzhyPhbEVHulbzpY1dWn7qfTsvRZgSeUq4HOCyLpnJgw0D82fykO/wJupsup+vkg4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WN0ubAhFwIgiY8haboOqiSeTDnDVfz3KDO4s/pBaCU=;
 b=eEWoVmpr7EN/hbrsW+9Zr133LXk5pemwDWuuK+LSSepXbWehkA9hYQ9dIl2xV9SOYLQ+7j6pVVPqCJwq6I7np0rwlkqwbV+PBohNChIRPZzBgDF9fYpecg8Drd9R2DVB9Bkjs45+NR17Vjc5FuoisKf4xs7vIac/wD7bklGM89g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 20:16:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 20:16:45 +0000
Message-ID: <9c562132-64a0-41f5-80ad-8492d1039692@amd.com>
Date: Tue, 1 Oct 2024 15:16:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance
To: Leo Li <sunpeng.li@amd.com>, John Rowley <lkml@johnrowley.me>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 regressions@lists.linux.dev
References: <9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me>
 <925cd47c-8f1e-4b74-aeff-6d13ae5f0753@johnrowley.me>
 <95c575a3-100c-4808-b451-b92f14598188@amd.com>
 <836c2c82-4dfe-40f4-8d50-5e7bff04c38c@johnrowley.me>
 <7ed81635-3872-463c-94e5-e4972da9d014@amd.com>
 <bcc97e4e-ffe0-47a7-bd29-c993e5404a33@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <bcc97e4e-ffe0-47a7-bd29-c993e5404a33@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:806:27::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: e2930431-6944-4a51-364b-08dce255f8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXdaaThCcnVoZE00WExJKzRLM3laWG0zaDVJZ0VaTGcvVUpIN3lzN053Y0ta?=
 =?utf-8?B?blBJczl2d2VnR0tTN0tEaXdTeHhUQm9uUlNmWlhOM1ViTDQ4ZUpaaCtENzdq?=
 =?utf-8?B?akdST0Z2NWtPOUdYTUVZUkVYaHB2VXNLb2NTK2V2R2kzQkxOdk5UZkx3Nis5?=
 =?utf-8?B?UFJXUWFQYk9rd3FkSHU0ZGQ1bUJ4T0RXNTJmbDJwOFJhSHJrVjdRZHdKTG04?=
 =?utf-8?B?NmtZZTF6VytxdFYvTW1GT21BNmF1SHB0QzZFMzhRMWlzVVhISXZWZzc3a2ln?=
 =?utf-8?B?N09KNUtpZWxMVU8xTmxTektCa20wVkh2Zm9LckVxUThkdE4yVzVkNExtbjZp?=
 =?utf-8?B?KzlmQUJtT0NaemxDbEJ6QmFHSThEbThTRE5WTTAvNU9kN2ZZdDN3b01zY1Nw?=
 =?utf-8?B?b09ubWRjRHN3dGpZNnNGaXV2aDVKbk9HNG10WE1yYkpNRG40ZlhqL0RlS3RM?=
 =?utf-8?B?aUY2eDNhaW1BaUplVzlGQmhja0JjSm5GMVhJM3RtZE50dFcrbGhxaEFseURU?=
 =?utf-8?B?ODR4K201aTA5cEJoUEhDZGpEWFBlb2RuZG1pQnFaYnprT01VWmFsdHJ5Mzc3?=
 =?utf-8?B?bzRtQVdRVFRCZ05Qbm95VEpwVXRKUXhaRDJ6MER2MFhHU0U3ZGZjOC80S0w2?=
 =?utf-8?B?czMwbGV6NmVTc0s5TTM1NWZ0K2REVU9zSGNPbFpZNGZZMGJ2YzlmYnBFOWZm?=
 =?utf-8?B?RjFaWWluV3hpMVpJeFVnWmJQbDNzMTJ0amJjNDlLUWVWczBaY1hsMWh3SXdS?=
 =?utf-8?B?QVJYYVRWc05UZmRlR0R1elg1V2xMSFljTnlhU0Jtd09PQmFvY05VNzNZTUZP?=
 =?utf-8?B?TkJhTllub1d6dHZtRENXdDVGNXY1SUdXb0M0OFozbVZUcjRCZDlJVllwd2lT?=
 =?utf-8?B?YjFNSVo5WU5SUTQ3Z0xEVUYwMlBWMWNoZDFCcWt5eG9wVE1OcTF0b09aaEZy?=
 =?utf-8?B?OENjQ0tISWhhaDgyU253cFIxSlcrQ1VtS1ZxQ1cwUEtjU2NEWkV5aXU1aGN5?=
 =?utf-8?B?V0hMeVZ5VTZJTDYwcHBmSmYrUkt0bnN6c3lHRWZGTEtDZkxEOTRlb3lLbHRa?=
 =?utf-8?B?a3pJeHJqRWJTaEtpOVV3c1QyUVg1azFuVWpVeUEvUkFZUGZwK0l1ZXRzV2dJ?=
 =?utf-8?B?d2g1ZHRsOFhxV0E3cE1pcnkrVWF3WUIwbE5rU0drd3VyVVlZUkJGOWk4N2xE?=
 =?utf-8?B?clB1dWY3REhSWWI2K1pRLzhiQXdRQXkvVHVXUW5YMXlDdGEyQ3dnNEhIYU8y?=
 =?utf-8?B?TWNjdmNvYzBmS29vUEdhNUNlZzNMQWRIR3E2cWt3ZDY3Nm1ES25ROGpxaHNr?=
 =?utf-8?B?MWZjL1VjSzFNOE96NHY0TmY5V0JtNTdhc2I5Y25SRitseGN2TEhyRDMzREJF?=
 =?utf-8?B?d2l5cEtWNjAxcnpQd1plMDB3WVJVN2JHOVpjOUsxU0RtRXowYWRBNkR4VFdl?=
 =?utf-8?B?Z0E1ZngrbmpMWHVMUllFOVh0bWJUZVFnbTZOTTNaRG5SRnNSYjdnYlNRaUVu?=
 =?utf-8?B?UkxWZWJJZFlLQ0hSWkhlUlFBTnM3Qi85V1N3ZE5WbExxRWtocmRXZTA0K2pK?=
 =?utf-8?B?VFpReEdvRVZUdFhsT2lJbnNlVWFHK3BLR0xtSXFScmFOZTZ6L2ZacThhaTdC?=
 =?utf-8?B?YTRSWktUV0sxZGE4VkpiUWRGVitNTHBTU21TVURreU5zNkV5VWNsMEJ5b0hz?=
 =?utf-8?B?NUZyZUt3ZVFLN0lFaTRmb3BDYVlTOGlaZXRxVlBzY3EzYXhRbTBySmZDekY5?=
 =?utf-8?B?L0x1ZWlocERtQ3FnSC9IMVlWOVVJNXJiRXFNTjgzVVFrSllkdUhWMTZ4cXht?=
 =?utf-8?B?OWk4T2VnRlpHSmxJencrUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEU5TTRwSXlOMUYyL3hRY01oQkdKd3U0SHFmUFZmMGF0MzJ0b0Z3QjcxVFpZ?=
 =?utf-8?B?VEc3cUlRcitTWVRIUFhvQW5iSjIrV250dmNzZFpsamdGUXAvWUNZOEs0cVRX?=
 =?utf-8?B?Tzg0ZXJTbytDc29XTDhRNFVRZkxjNzl2Q3lEaS9UTWlqanoxOUl6VmlRMHl3?=
 =?utf-8?B?aTV4TUo5US9wY1ZNVTJyZ0d1ZVNmN1hrN3JGWDlOSlBONllNQXFhUUd3N0M4?=
 =?utf-8?B?OTUxMHZ1dW82eDdxVFV2VFBPNlpwTGgvMk5aRGRVd1A2V1JvcGxJWUdLZzBM?=
 =?utf-8?B?Z09RbzlsLzJ5c0p6cXFqVm5TN1hPNzdEd3VzbmMyMWpzeDhoWFdDVkRtMWxV?=
 =?utf-8?B?SVcvREQ4L29PbFVOV2ZLeUgyWUdWN3RhMkRmTDhqdjFydzRrZ3VYOEh1TWlH?=
 =?utf-8?B?djJrWUl1c0RiQmZnQzdleXJNQTdHVnZJd3Njb21IaVp3ZXIxdWF2TVVKWjU1?=
 =?utf-8?B?QTZXSVgydFJPWWdaRHZHZWc5MFd3NktxMGR0NUJwcDg0SjlMS1dMcXBkYWsy?=
 =?utf-8?B?c0lEbjJGb2R2T0dtcTRJdWpic0d3MExXNkgzV0lpV21aMXlwMDBaV0ppYjZZ?=
 =?utf-8?B?OE05b1h0Tkkwc1pBRmR0NTBPQnV1d1o4ZUVWNmxicGVYVURRZWlsdHVMdlV6?=
 =?utf-8?B?c0p6bmFoNndvSzVBbWhIUlhKQzNuNEZrbnJKYmt3VE5WcFJpQ1NRQytOazdm?=
 =?utf-8?B?NmpMTWNNbFhvdmMza3NtaHdXdmhPNU5ucmJGMmRCcXdDTGZEb2wreFpubTJx?=
 =?utf-8?B?SUlxMDUvUFlhdXpDZWRZWHNmVkJkak45TkwrK1JTQkVablRKODVUZW9kYndx?=
 =?utf-8?B?VXUyOHNISk4rQjN6bXFCZTZGVHNFSDZZSS9Od2hNcUtlcm5qQnBqWmZjM2R5?=
 =?utf-8?B?RkIweWZiMkVpSHZlN2J6S2l4VE5ZQUlFWXRBVkt2bkhtVUFmbVBKTU9UMFNI?=
 =?utf-8?B?aGdJTVRkNnkrZUlXeEMxNExaR3VVWkV5QkF6NGprdHhjdXI2M2dFT1RQYm5C?=
 =?utf-8?B?b2lJREFvcDB3WnRtTTRSZWFQRzk4Y1dVSWdqbWo4VU1kZGNlS0ZQNW42a1V6?=
 =?utf-8?B?T3RpSkord3VJWDNlR3BzbFU4T0x0aHlyQ1FjQWYrQlFuSlE4QU5ZSkhyazBT?=
 =?utf-8?B?WmU0V3IwbHJ6SXI4bEdsSitTRWlNZFdhWEJrYVBlejBLc2lJVXMyNTg0WXRB?=
 =?utf-8?B?aTk4RnhkM0Q0OTBzWnhrandMWnI4K0tqOFJUUXlPTjB0c01WWEswTm50bkJI?=
 =?utf-8?B?TVZCRVlNTTZ0YzhKOERIYlNhSktJdmthakUrQTlvV3ZzdnNmeVQzVEk0cDAx?=
 =?utf-8?B?WmZNT0U1ZDhicmFmY2FTQ2pDQ0Z4ajlzNGpQSkFSQXVibmZEQlQ1TDcrdkJW?=
 =?utf-8?B?VzNBWUZyNTBOYjB6aU5BSS9uY3dTK3g4NkNvMEp2dVVaNTc0UUlmZnlTNHJZ?=
 =?utf-8?B?eUJYbDZ5dFNacmZ5MzlOTGFDeDR3OGhUYXpNRDlRS3JhZEhaL3ZBaUY4SjJM?=
 =?utf-8?B?R3dwNTIwQittRlI2SVBWelJhQnd5TE0rc0haTTRPczBFdUNTKzIweGxybEhw?=
 =?utf-8?B?RWxPL2NpN1NrRlJ4RkV4eG1pYmhsZkNkL2YzdDZYeDMxUURhUXRhUHpKSGZS?=
 =?utf-8?B?SmhwZ09mS0IzaE5ibWNhRXBpcVdBSytxTXJJRTFxV1A4UzlxWmpwRmRmSWsz?=
 =?utf-8?B?VjhueWhCb1MzSlI1cVBWZ0wrVUduR1ozUUpnUVYraGpaV1pDR0NoS2U2ZzBX?=
 =?utf-8?B?UVNSR3NxdG9SdXhEZE9rTzBMTW80OTRoOWhRU2Y3MjFWUzJKOCsxODJNVEps?=
 =?utf-8?B?NEJ1a3Fud09UWWhIK2FSYTRtMHNuRW5sTFU1U3ZVK25QZWEvRXRHY0JEWDNp?=
 =?utf-8?B?bVJDUkdIamxjSklaNmpCeEU5a0VseldxUGNYWUFjRktvTWRBUjRka3ZZRGF6?=
 =?utf-8?B?akJtL3ZnVW9rdmdPbDBzdnNJaThqOFM3VlFHNFJRcWI3Z2psUHBqcktNTEVE?=
 =?utf-8?B?alFRMUlHSjlpbjlsQkxLSFhMK3RBSERMY1NWVDZSOGtPMDhnNStKdkpQYnFj?=
 =?utf-8?B?bitMWElNNElBSmRwanNsdWU0L2Y2b3NYUHlQZ2hhbnhRTWdVWTdVM0RhRjgz?=
 =?utf-8?Q?u/qZAF5MrC3UpbTFW3AG0R46f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2930431-6944-4a51-364b-08dce255f8b1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:16:45.4042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IQ4shYx9uhYsjTZwuLaUwV1EI++5VOAbve678iHXHaO0LaAEUCKNIRu8B+czgARaMdeeV8maxLsT6mbLWbqQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

On 10/1/2024 15:07, Leo Li wrote:
> 
> 
> 
> On 2024-10-01 15:10, Mario Limonciello wrote:
>> On 10/1/2024 14:09, John Rowley wrote:
>>> I was using power-profiles-daemon version 0.23 in balanced mode.
>>>
>>> I also tested TLP, and vanilla kernel without any power daemons 
>>> running. Without any daemons I use the following:
>>>
>>>      energy_performance_preference: balance_power
>>>
>>>      scaling_driver: amd-pstate-epp
>>>
>>>      scaling_governor: powersave
>>>
>>
>> Thanks as long as it can reproduce in 'balanced' mode that should 
>> exclude PPD from being the cause and it most likely a pure kernel bug.
>>
> 
> I'm curious if you have a PSR supported panel. Does setting
> amdgpu.dcdebugmask=0x10 on your kernel cmdline help? This force disables 
> PSR.
> 
> Another flag to try is amdgpu.dcdebugmask=0x800, which allows PSR but 
> disables
> idle power optimizations. I wonder if that may be causing extra latency.
> 
> - Leo

Do you have the "new" 2.8k high res panel on your Framework 13?  If so; 
can you please check your logs to see if PSR is even getting enabled?

IE it might be enabling panel replay which is new to enable again in 
6.12-rc1, and if so; this could be where the issue is too.

The lower res display shouldn't support it.

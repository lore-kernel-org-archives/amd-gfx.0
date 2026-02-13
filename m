Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB57EEA853
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Feb 2026 00:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3107610E6CC;
	Fri, 13 Feb 2026 00:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CYBxThJe";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012026.outbound.protection.outlook.com
 [40.107.200.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49F810E6CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Feb 2026 00:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4ZYdS0R4jRzH51TgYSgzxYJslr3gMHIgDQvDOT0TcmABSHZHh5AsSmCD8sx2S3L7IBeZUf5H6lSZ3tNCcqiI46Zf7lFETOEEETV51A9vsKE/thvU6hQnNPhI0ysabgltQk76cSZvN+Yophr9mP8xhC1DoZaIz8Kp4e5CVdFWo/R4Cd2Twri+m0tqu9u5hkd7xpn9xXZXnALl7/+M8jF9VZ65RoYs1wQFKiJ0Dc2InIv0TWTdF/wWXbDHJ9xIbguMoTkxt1916XKYsMr7g/6yGM02+UZCFe7TOaAjZaYzawyIa591rKy8bwnlTTWewofcpagT8M3RjmurQWQEGp1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1NqYAbqI3zZaBj0lDlj+tLP9ytfhAOtJKBKAuUm2I4=;
 b=AMoGemOl/QPjuQppjwtB1LUpUsOxkQBdkOwKCbdvSOjkXG9DfaAsp+2pSap+nMr27b9Z1N00VhYgqB6Q4EsQXg8Vakl6MCMZMfi4W/WboZzhlchMM9wl8y+m7DDLEc8z0aoTss6XPEPgiCzlpEb+5uuiN7QkChksfOzhqSqpzoW4s+IZJGweLIR1bB8xzeQyTaKVVG3HjP1q4SqOfp/m3zNpIMfbeCxr3W79jUE5OOmNKZ+pBYTSLyC0B8nzTYsNJ5svA9vqiUaYteuMw+DXkxzfAj8DDy40K7PcZdDZjL6YSOyn0btYoG+DNPrVr4HC8l9LsJNz+2xPslw8hOtjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1NqYAbqI3zZaBj0lDlj+tLP9ytfhAOtJKBKAuUm2I4=;
 b=CYBxThJe06GeJZ2NIMu6PiLhfeNXs+OOV+ZktCIx23YoEQk3qInEWJioTReowI9aukcm8XEcGGxStbuGnciA9daE21UyYthqsZpXn11kTuG/HqTh1gzY6dKkOQDJxwojzA9KXP99+V8jOkQ2E/uMbkZMmbKgz5ZPmQbMKbhescc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Fri, 13 Feb
 2026 00:22:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 00:22:55 +0000
Message-ID: <654369dd-e5b5-45f6-b8ef-82b1bfe72141@amd.com>
Date: Thu, 12 Feb 2026 18:22:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] amdkfd: Add GPU family name property to KFD topology
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Stella.Laurenzo@amd.com,
 Slobodan.Josic@amd.com, Filip.Jankovic@amd.com
References: <20260211221336.1443070-1-mario.limonciello@amd.com>
 <CADnq5_Ok927jfPuPw0OUg97Q2pa2uymQfeWFVrvuBfiMDCGXpA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_Ok927jfPuPw0OUg97Q2pa2uymQfeWFVrvuBfiMDCGXpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 954b0ffa-e734-45ff-cbbd-08de6a96082c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzEraXVjQnh3dUlMbkpqTTBDNW51SUx4U3lTS1orbllsNXVHRXdJTEpHN0ZP?=
 =?utf-8?B?MUNkcWdtL1Fsc2Ewa2dOTXdNQmFJU2hQSktLOVFhYVZISDRoamNOMmYyL1Mw?=
 =?utf-8?B?N1hnOGpIbFFuTGVyc0tjYTdzRjlHallEUXhsY3B2S3NPOHlUK3RseWNLRTJi?=
 =?utf-8?B?dzJWQXREaVBGd1dCb1VnNWNjaHB4UDc3cjB6bEoyMU4xOWFwbjVtdmg2Snpu?=
 =?utf-8?B?bFNxOFNsdDJkVGNKTE45anRRWDdNNEZWT1pHWXc0QzU0Q2p5ckE4WHN0ejMw?=
 =?utf-8?B?S1I5Y05GWHhiNy9BN3hDUUVFZTBIQkR1SEhrYlJLZ2FjcnBGRVNNaGhuYTJ2?=
 =?utf-8?B?bURRUXRycUwrYmFQU0NYYjZ2SEM4czZXRkUwV1VMczdxOG9LaE9iRXFBS2VZ?=
 =?utf-8?B?bkdXNWRJa0UvcnZ2TkdZMzdZTmgvMzVpNDd5K0ZPb2hrUy9WSGhmK0o0V3BJ?=
 =?utf-8?B?bHhJRktMWFYvRi8xVmQ5U05OSkg3dnJCOFhTTTZSczlzOFJEc0xNbGtHQnBL?=
 =?utf-8?B?L3RDUHp6MGhYUUcxWE9haXpDdDQrSXV1OUVsSm8wbG1DMEZQTDBRQVE1enRu?=
 =?utf-8?B?V2pzYTJnRlhHOFBhR05LZ1JhNFcvNGlKdnk5MUFNMW5jS1hTNEZVUXZMN0VW?=
 =?utf-8?B?QVBjSkQzZW1IOC96bURTS3lTRnV6bFg2NXU2cFJxdmMxcnpDbTVkb3lWanJN?=
 =?utf-8?B?SWJGN0UxWFYyek4xVEVTbVgxblhFOGlNWHEya0tVU1lEUDFMRFVWaUcwNkFY?=
 =?utf-8?B?Ny9BdXQ3V3hKdlkxK1F3WmZFa1JuR3hiYXc5aStFNzdPOWtWeURyQm1ML2lj?=
 =?utf-8?B?RXE5UTRKY2Z0NFJjY0tqZ2d1ekpKYUt6MlpwM25DdHIrd0c4THI0SUdOQ21a?=
 =?utf-8?B?Z0FMUEFGMGFueXlyV09lTzVjMVJHMHdFRGt4SVNlaHI5R1FXc1NLd2FwTHl6?=
 =?utf-8?B?RHZiakdYM2NyS215bG5uM1BVMFExc0Q3dk9yVkRNbTNTWFVzU3gyQjRiWURS?=
 =?utf-8?B?TEl4ZllDQ01SZkNCTUM5akVSY0JKbnd5MlNoSkZCS2NMYUtYWDl2WGpKWEh2?=
 =?utf-8?B?eld2cWpSamV1R2FzYXFCaWtnbmx0NEdOZ2NNcnV5bUlpaFFWbUVwUVlGS1Vl?=
 =?utf-8?B?MERoL1FJRzgvMGVGaHc0aFRONDRLazlZZEV0WEo0dmZ3ZUJpTjlvZFdta1Bj?=
 =?utf-8?B?QmFMclF0TDB4QzkzbnNzbnhxeVVsNmZPS1hlMUIzSm03ZTN1V09qQzNZQXdZ?=
 =?utf-8?B?Vis1WHVpcEM4WTFMMlBhRy9mbHc3Um4zQUlaWVRiKzRaOUg1K0pjc1JTbHRZ?=
 =?utf-8?B?V2ZKdEVFM3llOWVZQjMwZ0FnWVArSnZMZmJrNXg2TGZ4M0lNZC9STXdOUjJ6?=
 =?utf-8?B?MXBlSmhrRkh0V0FRR0hOSVJxUkRHb2hucy84RFd4aXZ1dmZjM25oeFlZWmcr?=
 =?utf-8?B?bUUzMk82eVJWamVJeWdGeWpObVhwYmF4SXR0UW56RzN1OWpNSkd5VHA4OHFQ?=
 =?utf-8?B?RTQxaXJycFpMc0RGTzFscUx6N0RiMmhtZ3pmVGVUNzQvUXVSODlZVlhZWmdt?=
 =?utf-8?B?em5CS2VVeTViY2VaV3J1M1hYL2VKR00rV2MwMzBUcVZBUVc5TjZlUFo0b3Jy?=
 =?utf-8?B?VnhONGRjd2RBVW1HWGdmNEVJRmpKampFeEFPaGl1Q2lLWU4xdVJBT3k2emRS?=
 =?utf-8?B?ZDQ5Mm10ZEh2cnN6NVA4b1QvM2dHMGYwZUxGZWNxemlqNnZEV0VNem00RlpG?=
 =?utf-8?B?Qk1IZXh2dEEvV05UTkNyYzNEdHgvVVA5L05LR25KbHJuaXE4RHpSK2ZTc3Ew?=
 =?utf-8?B?Nldtb20xVk04ei9jVnNMckFaVHlyR0I1NGM4UndLWWlxckpUQlV0MW5SVlR3?=
 =?utf-8?B?Qk15TlpRMkpqcEVpd1Y3aWJTVFJlTEgvdVMwSzg2TXJlZmxiaGZjRnhuN0M4?=
 =?utf-8?B?bkJ1WmZlakJpanh6WmZHUFFhTG51RjRZRk9CeVlYREl5N003VWV0c3NJMTkr?=
 =?utf-8?B?TzA0U1EvS0tjOG5RZTh6dWE2Yy84UkhmdE1SN3hNUmJmT2VzZjVZSnR6T1JM?=
 =?utf-8?B?VHdlRkRTcnFMVURPNnJZNmxjZklLMGhlODAxSWxYcGM1V1VuUjZ6VU9KaU9R?=
 =?utf-8?Q?Spp8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2cxUjZYdkt4bjJTRG1RL2VVWWhqYXd4U1J2NU5xMlcxQUgrR09aTm54ZjBH?=
 =?utf-8?B?T1Bvbk91bWpkZVJ5aVJ5N1YxN3d6UGJic1FHWDQ5Zm1CaGFWd1QxR0VzWlFJ?=
 =?utf-8?B?SnZxU28xVU5jcURvTEJYOHdQcW5KSWJSWm15TFV6M0ZJb3dZdllFTjNsWlpj?=
 =?utf-8?B?RWFDVml5ZjhqRUdCbUJGREJJNlFqVjRNSEgzZ1lOQlQ0c0JPbnFkbDA2cDIy?=
 =?utf-8?B?Wi9qaHFpTDBKR1k2ZVpTNHgyQm4xOGZkTmMzV2QxdW0vaFJ3L0doaDg3WHNV?=
 =?utf-8?B?cHY0VHFQcEZsMlNhQSthMmlscTZxdmxKOHdhQ1B2aDJjcEpJR1ZhZHp3ay9w?=
 =?utf-8?B?QzlQSFY3dnQ0YldlT0ozVGJSWE5laWtCUHVVZlZqQ3dJUG5QcitQRUdPN2k5?=
 =?utf-8?B?d3NYblJCNDBPSFdKQVV3aDZ1M2tTdGtpZEkyZVFEVXc1dVZzZVdISVIvQ0g1?=
 =?utf-8?B?VnNmS2VVdGtpdmZweWVxYkJtT0ZoNWY3cTl5YkJEemFUTlpQYjhlSGRIZEl4?=
 =?utf-8?B?YnJ4Vm1CMlFsQjlrdW5GSUhNMlljdnRuZWFvb0RxdU1sQnUvMHlrWTY1VWIr?=
 =?utf-8?B?Tkx3K2FwZjJBYk1iU3pwbDREZlFmTk9KY0p0WjFZZnhEN3VGZUE4eUwwcnpK?=
 =?utf-8?B?bjhweXE1OG44aFMwTStVS1ppSk1RdHZJSE8yWkxvMkVuOG9FWWFXZkRIUysx?=
 =?utf-8?B?Vm5rRWtrUEYybFFWYldueWk4TTdpaENPcWJzV05UcWFvb1g2RXJ3YmVYeTNH?=
 =?utf-8?B?TnhVa0NLSWtla0JKWlZoZTVEY2pJZTdZa3FOblJWcGMvRm9nZkV6TVRUaWR1?=
 =?utf-8?B?bTRZd1BCMWJzbkVoSFROdXl0dTl2ZmlaU2MrcGN2OGZNbit2elBtcTFTZTNP?=
 =?utf-8?B?N2dpaFdxcEV2ZDF6T05QWGxKbVUzak16Uk1jazhWZ2NleTJIYmlYTGNrQmdM?=
 =?utf-8?B?Z2VsRGVWb1dWMHRleFlHK29Kb1JXWTlENlhYbzVNeWw4SStXN29ueWlxZVdm?=
 =?utf-8?B?Z0RTbTM4N1JsTnJWQUhybjlic29YZ2RJU3BGb09pdUZ5WFVMQkpJRzRENWhx?=
 =?utf-8?B?OWZrMzlVbkEwd0I5T0FTWkRFaGtVTEFtQjVEQU5RYU0vc1N3a0xQa1JONkRT?=
 =?utf-8?B?WUd2YmlPZXFnZ2FCUzNOb2JrWUY1Y0M4REpUczA5bTZ1Y2oyUmxvUXZUY0pq?=
 =?utf-8?B?VFQ5WUdaTzhLeTRoZmdFUzVBbEk1L1pWUW9ST3JiM0xyODFFajBJc0FxR3Jk?=
 =?utf-8?B?Tk9pdlRHelRKOTVKRHVIcEhkOW13d1k3V1FEZ3RRQ1UyTncxaFBNd25LdlBx?=
 =?utf-8?B?Yjh4VlhSenVoNnBnRzNGS1paV1lZaWF1UkZWMk9zR3hyc2JPM3hzTnNabGlU?=
 =?utf-8?B?VUFrTitYK0lUdEhjT0FYQldDSVFXcmh1TU9yUC91QWJrZVV6c08vd3hSOERV?=
 =?utf-8?B?U2daRmhKVkxqQTJyQ3RGb1VlSEN5SkZVajhWdTNHeUp4U2RHUDdrUWxnTitj?=
 =?utf-8?B?M2NSdnR6SDhrNVZXQkxIR2V4NmNUYnVNSENHaDVTY2o4TDFJSGNzSTRwdTJ3?=
 =?utf-8?B?eUdqRmpxcFJrSXRrL1N1K1IwbHFnTkRZNEwwVm05aGVKZHJRV005enNnQzF6?=
 =?utf-8?B?OFJpSEZzbWd1bzZYUGxoMmE3UzlmOW16aVNXd05IRGlGUmNDMUJVK1c4VjZM?=
 =?utf-8?B?UUlUbFFPOUZwd1BZWU9sYW94SmY2NmJBbkVFdFIyUXo5emZ5TGk2VEFGTlFk?=
 =?utf-8?B?Q1dFdTVndVh6N3FNVndCRENwcURnTGxiUVl0TzQ0cWVNNkZpdmF5Y2tHZkhv?=
 =?utf-8?B?a1hrcCs3QmVwOU5MZkFlNDAxdlBJWDJLSjZFTFNrcUhpdS92azhvTlczWEww?=
 =?utf-8?B?VXFNcGlKMGtMMXlkY2FzdHBBOGxzUkFtd1RWeHBGb2p6a3REdm5pUXlQL3hL?=
 =?utf-8?B?U09WZ0x1ZS9TdGRyMjJhUHdhOXFxWGgzdkM2VE9oZWw3Y2NRZFR3VlhyUVFG?=
 =?utf-8?B?RzlVdURjRWdyc0x0SDZMSzh2SXd0T2d2TFloU3NJTzZXV1FEbmpqSlhldGhy?=
 =?utf-8?B?bmVqZm9oWkdUbXBVV054T2lCMTl6ZDl3WXJSVVdZSGprOG0vMFMvYzJlc0hY?=
 =?utf-8?B?bWw2TmNQaVI0SDhqNGlaVFE1SnBKUmdBQW1iMG1QYVRxczZlTmdLRmxZUHJk?=
 =?utf-8?B?NklDcDhueTBVV2h0R2hnQi9nOEpHVWVlRUpLM3IrTWxaVVpmZkdneU9iRG5x?=
 =?utf-8?B?and6alNUalNTY29tMEMwUHI4T241RFhxRU5QT0tadHI1WnB4d29scDNWZlZ3?=
 =?utf-8?B?VFZORjd6a1FEdzB0UmhibCtyOEtBNXJFREFkbGFselAwTk0rVjJaQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954b0ffa-e734-45ff-cbbd-08de6a96082c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 00:22:54.9531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IX0p5fiQs5DxnA+WGos9gFrTB23347kY7EOF9oNId7ls6Roobz494GV/wesiZAv4OJCu8TMJTDhj2rsJ/7+m3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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



On 2/11/2026 4:25 PM, Alex Deucher wrote:
> On Wed, Feb 11, 2026 at 5:14 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Add a new 'gpu_family' property to the KFD topology sysfs interface that
>> exposes the GPU family name in ROCm TheRock format (e.g., gfx110X, gfx90X).
>>
>> The property is algorithmically derived from gfx_target_version, which
>> encodes the version as MMMNNRR (major.minor.revision). The family name
>> follows the pattern "gfx{major}{minor}X", making it easy for users and
>> tools to identify which ROCm compiler target to use.
>>
>> The property only appears for GFX9 and newer GPUs, as older generations
>> predate TheRock targets. Unknown or unsupported GPUs will not display
>> the property.
>>
>> Example usage:
>>    $ cat /sys/class/kfd/kfd/topology/nodes/1/properties | grep gpu_family
>>    gpu_family gfx115X
> 
> I would call this isa_version or isa_family.  gfx_target_version is
> the ISA version of a chip (i.e., the compiler target).  It's not the
> same as the GC IP version or the chip family.  That should help
> differentiate it and avoid confusion.
> 
> Alex
> 

Thanks, I guess of those options I would say based on how things are 
named in TheRock isa_family feels more logical.

But now I'm not sure if directionally this property will really be 
useful or not.  I noticed that the apt packages and wheels aren't 
actually split
up this way anymore.

>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> The idea is that this can help a user figure out which wheels they need
>> for their hardware.
>>
>> Cc: Stella.Laurenzo@amd.com
>> Cc: Slobodan.Josic@amd.com
>> Cc: Filip.Jankovic@amd.com
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 37 +++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  1 +
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 08c63b4cc9a5f..ab029d87eb9ea 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -471,6 +471,9 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>>                                dev->node_props.max_slots_scratch_cu);
>>          sysfs_show_32bit_prop(buffer, offs, "gfx_target_version",
>>                                dev->node_props.gfx_target_version);
>> +       if (dev->node_props.gpu_family[0])
>> +               sysfs_show_gen_prop(buffer, offs, "gpu_family %s\n",
>> +                                   dev->node_props.gpu_family);
>>          sysfs_show_32bit_prop(buffer, offs, "vendor_id",
>>                                dev->node_props.vendor_id);
>>          sysfs_show_32bit_prop(buffer, offs, "device_id",
>> @@ -2048,6 +2051,37 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
>>          kfd_topology_set_dbg_firmware_support(dev);
>>   }
>>
>> +/**
>> + * kfd_get_gpu_family_name - Get GPU family name from gfx_target_version
>> + * @gfx_target_version: Numeric GPU target version
>> + * @family_name: Output buffer for family name
>> + * @size: Size of output buffer
>> + *
>> + * Converts gfx_target_version to TheRock family format (e.g., "gfx110X").
>> + * The gfx_target_version encodes version as MMMNNRR where:
>> + *   MMM = major version
>> + *   NN  = minor version
>> + *   RR  = revision
>> + * Family format is "gfx{major}{minor}X", e.g., 110501 (11.5.01) -> "gfx115X"
>> + * If the version is not recognized, family_name is set to empty string.
>> + */
>> +static void kfd_get_gpu_family_name(uint32_t gfx_target_version,
>> +                                   char *family_name, size_t size)
>> +{
>> +       int major, minor;
>> +
>> +       /* Only support TheRock GPU families (GFX9 and newer) */
>> +       if (gfx_target_version < 90000) {
>> +               family_name[0] = '\0';
>> +               return;
>> +       }
>> +
>> +       major = gfx_target_version / 10000;
>> +       minor = (gfx_target_version / 100) % 100;
>> +
>> +       snprintf(family_name, size, "gfx%d%dX", major, minor);
>> +}
>> +
>>   int kfd_topology_add_device(struct kfd_node *gpu)
>>   {
>>          uint32_t gpu_id;
>> @@ -2105,6 +2139,9 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>>
>>          dev->node_props.gfx_target_version =
>>                                  gpu->kfd->device_info.gfx_target_version;
>> +       kfd_get_gpu_family_name(dev->node_props.gfx_target_version,
>> +                               dev->node_props.gpu_family,
>> +                               sizeof(dev->node_props.gpu_family));
>>          dev->node_props.vendor_id = gpu->adev->pdev->vendor;
>>          dev->node_props.device_id = gpu->adev->pdev->device;
>>          dev->node_props.capability |=
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> index 3de8ec0043bb4..8e52dd59b53dd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> @@ -81,6 +81,7 @@ struct kfd_node_properties {
>>          uint32_t eop_buffer_size;
>>          uint32_t debug_memory_size;
>>          char name[KFD_TOPOLOGY_PUBLIC_NAME_SIZE];
>> +       char gpu_family[8];  /* GPU family name in TheRock format (e.g., gfx110X) */
>>   };
>>
>>   struct kfd_mem_properties {
>> --
>> 2.53.0
>>


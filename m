Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB07D3C525
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 03:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3728610E240;
	Wed, 10 Dec 2025 03:28:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="erp1M3NL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010013.outbound.protection.outlook.com
 [40.93.198.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A709610E240
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 03:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V50sVb+Anz3K0zU1xGPOgDjjFW1gmRggLDu6Gw9ErA0c+9kAzs/p/nCdiqmyuwok3+YN1M+ZPgKDnj9vKekc/wQwR87PnSWZGKytPf8fyamfChC3hHut9yd9Itl0k/gZnAnsgI3Bch/sjkMJuXh8w+W5tPokAhD2nPpAcxH8yU8JWuvVlQFnQXcRXWDZDnBX3OqLYOZSezUVhOQ1qXbJ2KdOH2iJ2ACHfsN5LR3kLEH4IlUmsR2rhz90C0VsI5VypBShyav6pH7m4+KK+1dSXQZTcGcvcDiGTA/Mv/zvQhvVVq4GzRSec2Z/sG+Tg+85UeKfvCe8h2/e5/ObqaxTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhVy3DHrqpPpU2NFJ0NBH1RnSMq7Q1T6E+Z1DxR6cqs=;
 b=WVMpkh5gJ5fstWNf8/t1u9sUHt06DhKv2cX1bKbuEr5gU6PjwffM/M4pRJXUPQ64gz+fwHppEMIWUaAV3ACFP/YYvP8acVyfrZD00uyUzflwohjrR58EY9Lecaso7NyePIUljfIabAX24N7G67/eLwE9nkdVf9ZiIhHAEXzleJZlmIH01KZxjTzVcKd/7/6rh803FCyFk/V0Dv5eL1+BFnxMHb3VW087e+4FmUvf8z5ydjnGr8j0q3TLuC/wWD3WbVxYxnj6t9cRnlJvcHjBYurxSJZMc3zTPf1QzW1w44A8AptedAZ6jLk7GC3W/oEtrsUkiy0ydZENH2g9Zntj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhVy3DHrqpPpU2NFJ0NBH1RnSMq7Q1T6E+Z1DxR6cqs=;
 b=erp1M3NL1OCBYwfXyKwIQJgWatizRYn4V4dRwyfv2FIYb0tRs8rutqc7BMbvpCv8hFMW4mOA2lq8wq1A/MCmyV+PGQ+JQLA56ST4GTNFKobP5QxgjUrSlcTHn3qrZY9DSIfdUdC2r8R9euqOIAmL4SFGnHm/1BpYu2A4oyhJQ1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 03:28:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9388.013; Wed, 10 Dec 2025
 03:28:39 +0000
Message-ID: <db479aed-d96d-414c-88f2-a699accf24f8@amd.com>
Date: Tue, 9 Dec 2025 21:28:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Fix SMU warning during isp suspend-resume
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com,
 Gjorgji Rosikopulos <grosikop@amd.com>
References: <20251210015140.568540-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251210015140.568540-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:20::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d751750-39d9-4f4f-af98-08de379c35b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjIrSHJ3amNLSjAzUFhNNFVPQmRjZFg4V0t4dFVkTnZhZURSd1dWNDdaNFQ1?=
 =?utf-8?B?bzN4ZDJRRXcxUlJva2dheUYrZVNNc2FhSXVON1FNdnVTNFYxK1RwQzhxaFRB?=
 =?utf-8?B?RHBtR3M3Z3AvdEFYRi9xUnNmdS9iWS92U09YeHFXNkVmcU9HZ0dTZ2FMUGNk?=
 =?utf-8?B?cGVpM3JIQ1YvM2hEa1o2N01nUXpCNWRkSUJWeEVIdVVFQkFzdk4vZjZ5ZUZk?=
 =?utf-8?B?ZDZNR1h5QXdvZjNIMWlYUDlTK3E3YnpLdlBOMlBaTitrVkVBMGwzN1FLVE9v?=
 =?utf-8?B?bFZUSTlSVHFGaTBZY3dUK1k4L3BWL3JMRzBQN2FNTzA4cTh4RTkvSzM5NnBN?=
 =?utf-8?B?K2RZTW1VcU95QzF2Kzg4OXdiVjh5UTNkUVdJdWdNSUlpMnEvRlNibUtRVVZ0?=
 =?utf-8?B?aS93MVN6RjVMM3M3NWNBNlI5NXczelkwRWxZT2Q3YWUxUWxZZlFITjhyYVVm?=
 =?utf-8?B?cjlhUTkxLzNXQXkwU3ZmSXJsU2luZWU2SGtpY2J3N1NCOXN5R0NiendMZ0hS?=
 =?utf-8?B?VHBRRTEvSGFxK1g0TG1ZTkdMVklIT0VLOVYrRk5idE1CODJXdUdiL2NWdEJT?=
 =?utf-8?B?Y3RJK0lJeDdzaHVyOW9sSVlMYXdpMHhHYWJGZU92djJKWkExWjQzOVYwUFZ5?=
 =?utf-8?B?VWtyQVE5SW9Cd25nRUFJOXZ4eHJoczVJbmtRTzRaLzZUWmcvOFIxelpGaVN6?=
 =?utf-8?B?aTRKWFFXbUo1NFhtV2JEN3VuTldaOGgzOEdjV3hqcG03aXRNVWxTZ2RxYjJq?=
 =?utf-8?B?NmF2V1IvNjhsdmtNTjlxa2c1OFEzVzR0TENuRjZ6YktpVi9aTW9aRzM3bFFI?=
 =?utf-8?B?cDdmZVJTcmQyakx3dHRWYzM0emRoczF1MnJ6NE1MeFI0NElJOWRQTHFuc1kz?=
 =?utf-8?B?b1FwZmVVU0hRbUN0bjJHU3AyV1gwbXBrWkViK1hoVDRBN0RaM3VSc001Z20r?=
 =?utf-8?B?UGI2MkZUMkZqdDIrME9CbVpCS0xRQ2hQRFp6ckw1aG1KR0RuQ0VZSmpLc2xH?=
 =?utf-8?B?UFBJSERqSm5KUVVVdWgwTW1mWFZLTGtLTGJUOVVtc2hSbzg2NzQ3M0ZWcVVr?=
 =?utf-8?B?OG1wUC93WFlMM1p1VWJucjI5NHJMa1BLWU8yNWtkOEVaZWJrQkwrN3c5TUNO?=
 =?utf-8?B?UGVvT2ptL2ZGa1c0Qmc0VHVPSm1hVXNJOWt4Q0R3aGxBUFVUd3lWSzRHVGk3?=
 =?utf-8?B?aXhUT2J3SitCM0xXYmswMTdReGEwYytkUnY4c29yaE1oaXdIU3BUdEoydUZH?=
 =?utf-8?B?ZW5ha2dYaXZpRmkrZGEramFaZlBpeE1JdXFnMUVDTDBHZEFuQkRFN3JGSHJ6?=
 =?utf-8?B?K05sVHdKcU9iby9pRVgra0REZ2UvL3ZMUzFkdGdNRC80dDlNWkV4Y2RkcjUx?=
 =?utf-8?B?cnlqSHI4OWVKQnU1SVl4YTVSKzFLZ0FaVnYxNFpiSG9NMDYzck1nVFJndFBK?=
 =?utf-8?B?N2YzSDVqa1dKYVJNL2xPaHBJb3RjV09Rc21hRkg0VisyRExlMHl6dFlCeS8z?=
 =?utf-8?B?OExOcGxUeFd3a3N4REJnS2JIckhNSk95Uno3Uk1ZRFZTdk5tWW1NN2g3bjMr?=
 =?utf-8?B?cGU2dDdpc3Z6NS9YVTRTRVhjSmFxQjF4QmZFeFN0dTZzQU5mU3hGUzAwWTgz?=
 =?utf-8?B?YVVHNWpWV0JFWHdlKzV0WGZkSFFWR05kdlNjekxadXRKUThabkgvTmh1WnpE?=
 =?utf-8?B?YjJjMlBhVHQ5TmdqYTdva1JoYnV3bWVKUnFQeWpCQm56Z2I5c3VhNFdRNUY2?=
 =?utf-8?B?Y3FGbENVTGJQNzl1V2d3bkRsWnZnYyttR2lkMFAvUHp0WlA2bjRCRk1qa0h6?=
 =?utf-8?B?WDJvRE9RRElkK21OOGYwZUhaYnhLd0xoVm9GcTEwV3M5aFJFb0VPNWdBcTY2?=
 =?utf-8?B?cE1MZVNHMFhNdlhYRHdIeTNLWjN5dDhFVFROd3dQbGRVWE82amlhVVkvVjk2?=
 =?utf-8?Q?yVys3niIw+UcFYEwPGn0bfMwBZuYj0Ir?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTQvYWxjTW5WczhIWmZuSG9VV0ZDcGJGckVuekJ3K2w1b3ltZDNhb0x1V0dk?=
 =?utf-8?B?MDM2bU0yRGxTYnlBcU8vZndSd1NGYUdjem5TRDhwckdDZ0JsRThTTitwMjNq?=
 =?utf-8?B?L2lOQWJiTTRxNG5jZFkwdnNXU051K0ZHNXVZQ2ZtU3QxUVVmZFM2ajAvNGo4?=
 =?utf-8?B?VE5NTVpyK08rNzJDbkxkZW53YUI2NElxMlJaekNkNXhSVEw3Y1J4WHcrRkZx?=
 =?utf-8?B?U055bHVyVi9UODM2R2lzTk9PTGxHQ3ZoaE1LeU1LQndyZlJXOWwzY1cyVXho?=
 =?utf-8?B?UFYyd3hVM0RkSDRuQ09yOGhXcTlYV2RXWmc3YnNIVVhPZFRmNXdXdGVVdWRC?=
 =?utf-8?B?U1lyOXc1Q1IwQVFyWDM2RnFCTXlRZ1Z6SEtaR3d6K1A2MTdqQ0RLR3FnSm5n?=
 =?utf-8?B?OXpFSDk5ZmZ0aHJFd0kwcnBsMHZwQjFDVTNQeTBLMUpxeFZ5MHJXK3NnejZ1?=
 =?utf-8?B?dEUrd2w2MjhqaEdQejdUVjFRa1prejlPSmsrWk5vdHdzeFh5MFRmWmZVOUxI?=
 =?utf-8?B?MENLVWhNNmdBdU1KRkJpZmxxQ01hYTNpVE91SjdsV0kwdWY4cXJDVVA4bHMr?=
 =?utf-8?B?ZUhZVm53NkQzT2NHK1BOWWtacjhGMkpBK1NVOEdvYVZHMjhXWDB6N1BWUWpD?=
 =?utf-8?B?L3QvRHFMUUR3VEZkUjVhOTdiRldSd0VFL1NtZkpXUG9lQnp2T0puUnZlN2VZ?=
 =?utf-8?B?V25IVTA3d1J3VWVJYUsxbXJrc2RHNU40azN4WjFBVlZ1UzRnajd0a1lzZUpB?=
 =?utf-8?B?ajZqVFR1M2dtVGovRnpRR0V3eTRnZWIvQ2FaOUowQW9peWZacUxWMENvQzBB?=
 =?utf-8?B?QTZLTzB5bkI0YzVWT3RsOU54bHNzOEJYc0k0RGxrSFFZUGhVV2JRdGg2cGMz?=
 =?utf-8?B?SE9LWjRLUTBxQ3NBTVZTQk8wb1hFSWorSXNJRWVTZWR4Vi9NancyUXVzdzcw?=
 =?utf-8?B?Sy9SUWtIRkI4S1Q5NFl6eHhtdEJRVEQ3eXpUYk5KT0VLaWdYeUFNV2tzYk9R?=
 =?utf-8?B?aXdCZ1hUa0tGbEYreC9PODhVYWprWnV1bFBJSnQyZXNYVTVGVitwQVQycUdo?=
 =?utf-8?B?eXNJTEZIc2xPMTc0d2dUdDZ6Mm9vaFpyVTZsSWo2UkhuczR0STNKbGRzZ0ky?=
 =?utf-8?B?NWNjNkNsa1E5a3dLZS91cWJmRmNsTW96WndHcFBDdjR1Y3hGS09xM25wT1BW?=
 =?utf-8?B?MDFwK0xkY1llZTQyb2FjSVNDY05JVE5uL0dhWDhIOGtGd3p0aFVzbE91ak5p?=
 =?utf-8?B?T2NxREFSZU05blgzcjY1dG94NS9uV1V6VUZvR3ZIa3lPQldDTmIxWUZ5VWxv?=
 =?utf-8?B?a05ZM3phSWhlQ3RWTWlSOTNZM21OMHZDSXpFWWRqL3ZJZHlLa0tPdXpOSDNL?=
 =?utf-8?B?ejBMZ0k0NlB6S3RnVGI4cjJLbTgyV0EycGFSTmdvaWgzcWc3Q1hWY2VUU3Nw?=
 =?utf-8?B?bFNqVGpzZVVRLzZkbHlDQ0hVOXVRdlF3RjMyR0FXbGhxZjkvVDRhNEtpekZK?=
 =?utf-8?B?TExUdHprYVpTWTk0c25RUnI2Mm1TNXBlVVVwNVNNNWVHemJ4b3Rva3VUNXlZ?=
 =?utf-8?B?TVgwSTkxdXRJWE9Ea3lmbWhtM0EwTGpRekVveFcxQ1hIVXZxU3pqRjk3SktQ?=
 =?utf-8?B?dk1xL3ZSaC9Rb3k4WFUwZW41aHh3NmhNbUlFL2xVbmlwdkg2WjBJVTIwVkd3?=
 =?utf-8?B?T0NCTnpGYmtpdmlhUG41VFZKend2STMyNTZLemlWQVEyWXN1dnBVTnBUTkd2?=
 =?utf-8?B?RUdLT1p1Nm0yakxSc0kyb3Y4ZWdvaXlCYUg5bEhvZVJaV2tNV3M3YTJicXFn?=
 =?utf-8?B?VTdVZFl2azRROWwvZGNpRXN1V3l5SGFyUG1FNWlmeW5vaElOOWNDVm1wdjRS?=
 =?utf-8?B?VWFNRHU1cGh1VndtYlE1RjJmTEtobWhadStZSG1XVGFjQ2ZuaVpnendRSEdB?=
 =?utf-8?B?SHBrU0tycWdnelhHV1UrRmdVMENRWjBaTXV2dU1EaUphcWRSVmNKMklrdU5F?=
 =?utf-8?B?UmFnRFBmWlJOZk1rVWJOTG1GcGpGSFV5UlFCbE1lT3l4QzNCZmluQjBySnkr?=
 =?utf-8?B?Zk1jTWlOd1F3cjZxaEx0MlJQZ09GaVZZaTIvN2NzQWFXc1ZBMU1GVUlxSWRN?=
 =?utf-8?Q?tA3AoVVMzH5XcKxBoRe3OIlsl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d751750-39d9-4f4f-af98-08de379c35b4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 03:28:39.0499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QASyeDWP0eo6U0ygT31lTS2ZWRb6xM6mPNadQ0cAT/eVWPd4IaNf834ACLBWMF3XTbpYiRAIgAb8ZS/ojjxWbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582
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



On 12/9/2025 7:50 PM, Pratap Nirujogi wrote:
> ISP mfd child devices are using genpd and the system suspend-resume
> operations between genpd and amdgpu parent device which uses only
> runtime suspend-resume are not in sync.
> 
> Linux power manager during suspend-resume resuming the genpd devices
> earlier than the amdgpu parent device. This is resulting in the below
> warning as SMU is in suspended state when genpd attempts to resume ISP.
> 
> WARNING: CPU: 13 PID: 5435 at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:398 smu_dpm_set_power_gate+0x36f/0x380 [amdgpu]
> 
> To fix this warning isp suspend-resume is handled as part of amdgpu
> parent device suspend-resume instead of genpd sequence. Each ISP MFD
> child device is marked as dev_pm_syscore_device to skip genpd
> suspend-resume and use pm_runtime_force api's to suspend-resume
> the devices when callbacks from amdgpu are received.
> 
> Signed-off-by: Gjorgji Rosikopulos <grosikop@amd.com>
> Signed-off-by: Bin Du <bin.du@amd.com>
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

Who is the patch author?  If you guys worked together, there should be 
Co-developed-by tags to represent it.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 24 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 +
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 59 +++++++++++++++++++++++++
>   3 files changed, 85 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index 37270c4dab8d..532f83d783d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -318,12 +318,36 @@ void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr)
>   }
>   EXPORT_SYMBOL(isp_kernel_buffer_free);
>   
> +static int isp_resume(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_isp *isp = &adev->isp;
> +
> +	if (isp->funcs->hw_resume)
> +		return isp->funcs->hw_resume(isp);
> +
> +	return -ENODEV;
> +}
> +
> +static int isp_suspend(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_isp *isp = &adev->isp;
> +
> +	if (isp->funcs->hw_suspend)
> +		return isp->funcs->hw_suspend(isp);
> +
> +	return -ENODEV;
> +}
> +
>   static const struct amd_ip_funcs isp_ip_funcs = {
>   	.name = "isp_ip",
>   	.early_init = isp_early_init,
>   	.hw_init = isp_hw_init,
>   	.hw_fini = isp_hw_fini,
>   	.is_idle = isp_is_idle,
> +	.suspend = isp_suspend,
> +	.resume = isp_resume,
>   	.set_clockgating_state = isp_set_clockgating_state,
>   	.set_powergating_state = isp_set_powergating_state,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> index d6f4ffa4c97c..9a5d2b1dff9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> @@ -38,6 +38,8 @@ struct amdgpu_isp;
>   struct isp_funcs {
>   	int (*hw_init)(struct amdgpu_isp *isp);
>   	int (*hw_fini)(struct amdgpu_isp *isp);
> +	int (*hw_suspend)(struct amdgpu_isp *isp);
> +	int (*hw_resume)(struct amdgpu_isp *isp);
>   };
>   
>   struct amdgpu_isp {
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index 4258d3e0b706..560c398e14fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -26,6 +26,7 @@
>    */
>   
>   #include <linux/gpio/machine.h>
> +#include <linux/pm_runtime.h>
>   #include "amdgpu.h"
>   #include "isp_v4_1_1.h"
>   
> @@ -145,6 +146,9 @@ static int isp_genpd_add_device(struct device *dev, void *data)
>   		return -ENODEV;
>   	}
>   
> +	/* The devcies will be managed by the pm ops from the parent */

devices

> +	dev_pm_syscore_device(dev, true);
> +
>   exit:
>   	/* Continue to add */
>   	return 0;
> @@ -177,12 +181,65 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
>   		drm_err(&adev->ddev, "Failed to remove dev from genpd %d\n", ret);
>   		return -ENODEV;
>   	}
> +	dev_pm_syscore_device(dev, false);
>   
>   exit:
>   	/* Continue to remove */
>   	return 0;
>   }
>   
> +static int isp_suspend_device(struct device *dev, void *data)
> +{
> +	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
> +
> +	if (!dev->type || !dev->type->name)
> +		return 0;
> +	if (strncmp(dev->type->name, "mfd_device", 10))
> +		return 0;
> +	if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
> +		return 0;

Could we store the mfd_cell pointer instead and just compare the pointers?

> +
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +static int isp_resume_device(struct device *dev, void *data)
> +{
> +	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
> +
> +	if (!dev->type || !dev->type->name)
> +		return 0;
> +	if (strncmp(dev->type->name, "mfd_device", 10))
> +		return 0;
> +	if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
> +		return 0;

same comment as above

> +
> +	return pm_runtime_force_resume(dev);
> +}
> +
> +static int isp_v4_1_1_hw_suspend(struct amdgpu_isp *isp)
> +{
> +	int r;
> +
> +	r = device_for_each_child(isp->parent, NULL,
> +				  isp_suspend_device);
> +	if (r)
> +		dev_err(isp->parent, "failed to suspend hw devices (%d)\n", r);
> +
> +	return 0;

Shouldn't you return r?

> +}
> +
> +static int isp_v4_1_1_hw_resume(struct amdgpu_isp *isp)
> +{
> +	int r;
> +
> +	r = device_for_each_child(isp->parent, NULL,
> +				  isp_resume_device);
> +	if (r)
> +		dev_err(isp->parent, "failed to resume hw device (%d)\n", r);
> +
> +	return 0;

Shouldn't you return r?

> +}
> +
>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   {
>   	const struct software_node *amd_camera_node, *isp4_node;
> @@ -369,6 +426,8 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp *isp)
>   static const struct isp_funcs isp_v4_1_1_funcs = {
>   	.hw_init = isp_v4_1_1_hw_init,
>   	.hw_fini = isp_v4_1_1_hw_fini,
> +	.hw_suspend = isp_v4_1_1_hw_suspend,
> +	.hw_resume = isp_v4_1_1_hw_resume,
>   };
>   
>   void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)


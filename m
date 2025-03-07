Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EBCC19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32ED910EBDE;
	Fri,  7 Mar 2025 15:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lpC8AiK8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D2A10EBDC
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1ESy/XMia54APVYKlqIEG2PzZ/0qMl5t+PtbK1nFCQzz6Ym3Gl7gVXl1DnUZhAby4LqR4VAteGc4dI6Wb/5VzGgLesbulSCeYwO587S5bBI48WVrSGGTK1iNQELZu69pvf83QNFXnof0SLvzT2KSyj7GTFuFQoOUZGVkYNXHEonpuoS8v9C1ll++J7crx7uHaKve3f1b0YHCDaCVYyRUUmCiPg6oFg/CcADh7g69hiuqAYXsUEajUb2B94vlLz+QZhLuETG7KXz9CZgBppwbH0J8XH4qg1sYEaMaWjlQAFe+cA18CxTZqEk8sztCkXe0VPYhBLg0DVodX3NGru2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryCYEnIIKEJc0egVkuAmcNrn2N46rr9VSdoZX3tw1qM=;
 b=xH2lEp7gSIRRaoNY4np1/PyC+s0eiTrzBJnAZFxQ4rcly9OOQ0Shm6fez1mA2sJjGlc8Qm2tV115fMEcXLpd3buq5sVyZ5EjYhi2aHccpiYZqoR/rqlhThL5USYAaPatZ4EpAjVEysUK8xh8xPgnORs+S3/0+rq7ptwHQJrSv79ASLiy04IWZgHUSZO0+wjX1SppifdcQ/UGv8IuGgMOiLMff6+raCqNkO+WLZg+x1l6fMAV06I+gFoP4uRNsdk/SvD9YFkmxgZOHkMORAiWulF3nbUVNZQwIvK7osKC1PVyyL+NFBR1gBIyiWfsSMtncAUQo4Ii4MYd25ipsoOgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryCYEnIIKEJc0egVkuAmcNrn2N46rr9VSdoZX3tw1qM=;
 b=lpC8AiK8KoWZHhJqvXYHpYn4K2dwyNzjq3CHTrvScgImea188O+Y+uh6fpRTwaQu+Oxkl8HM6z6h0/x/5n+uT6MwU2wxUiKYfkXfiNlQ7HCVvEKcXAGSxVxufl1/cz+OSVnSFPL4LjqOh+uo7H1eb2HJbbqrOD685jdkF/RKFRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:30:48 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.8489.028; Fri, 7 Mar 2025
 15:30:48 +0000
Message-ID: <6299383a-ecd4-4800-b261-e46dd75353df@amd.com>
Date: Fri, 7 Mar 2025 10:30:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: reset the workload type when using MALL
To: Alex Deucher <alexdeucher@gmail.com>, Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kevinyang.wang@amd.com,
 alexander.deucher@amd.com
References: <20250307034457.595790-1-kenneth.feng@amd.com>
 <CADnq5_OH7iumFq2MJ_LjpAwYzf34G60dUh_rug6HWBrkq=8Xxg@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_OH7iumFq2MJ_LjpAwYzf34G60dUh_rug6HWBrkq=8Xxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e43911-441a-4bbd-14fd-08dd5d8d093a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VENtT3dXbWV1M255dG8ra0tTM3VnbktwZUl2UFZlYTZVZjBvdU12Tk9oRjhi?=
 =?utf-8?B?dzYxUFB2ejFVdDhLaFYzZERvdFZrUGFDTDdwdlF6UzZMVFJUUFoyRDlWZEU3?=
 =?utf-8?B?eVRhK056M3dqNHhCbC8yR1FHbjR2RlFuRFd5WURJd3MrWlRuaCt2UWtDa1hE?=
 =?utf-8?B?dENFZEJ1cVVsM0QrS2FkU2NHNFRhSmIxQmhZWmsrOEtwbG91WS93VW1WYmhn?=
 =?utf-8?B?V3k1ZVNuWjVUbTdxRW1KM0xNUmZVNElwdlByU0x1dDNXVWw1UDl3dVNiUlor?=
 =?utf-8?B?ZzJlbEpZeHQyb0xWWW5ZSmtaRHJkcU5nRVFpT2RTbWx1NnlEUzY3ZGhUK1Mw?=
 =?utf-8?B?NW1FOWdRTFZjYjIrSEdaUy9VcmErV1ZMejU4Q2hISi9CUFpPdDA3RVdVeVlp?=
 =?utf-8?B?TUs1RWwrOCs4Tk9QU05WY1N0U09wdjRUTzdiS3g3TXJQUm0wYkdYL2xlTFQv?=
 =?utf-8?B?NVlCUU53SDVFRWtHYkhUR1FoZDJmYWVFa3NSNXIzRnRXVmlZT3I5ZGF5Q09P?=
 =?utf-8?B?U1kyNU9YVzNvV1RsWWtGRGloVVErNHZJaVZ5MW1VMnBxVUF0UUg0dzlKNnI5?=
 =?utf-8?B?YXBrSEFXMm1xa1FCNXNhRUdLTENVK1Ywa0dQOGVQUElMeDhwcXpHRmhQTlJB?=
 =?utf-8?B?NCswVGdhenMzNW5OZlNUMzdDVkRnbUxlTk8xV0YyaWJIbm44MDJVZU1RSzh3?=
 =?utf-8?B?UFVoSEFReWVZYlRNaUdjL284blMzRFFLb3c2b1Fmek1DWU9tVSs0cTdzNFdZ?=
 =?utf-8?B?UmRLTDlVajJVT1FjZEJzL2JPSXV5QzRqajFCMWFVeUpud3Q2OTRRajUvWFZs?=
 =?utf-8?B?VGJTVlcxZmtlY2RuYkFGRHgxTTM3TnlSL0I2NFdMSktMdXNSZlhrTFpHVXFV?=
 =?utf-8?B?NGl2ei9WQnp0WkdzaEIrVVVhKzk4QWFvb2VTeEhMSFFQdHFxempMZGZKQ2VK?=
 =?utf-8?B?VHZ2Rjk2ekV3bjFRcHRKZm9tNU82bVBtNEREUEVJMjRnVlcyMzRXRnUrWi9U?=
 =?utf-8?B?OUhhOTFtUGdTdnVmRUVuL2VlUUhYYWtyQnBCc2VxWlBEYlNVR005TmY2bnk1?=
 =?utf-8?B?ZnNoY25wbEszOEpWeHEwYkkrZEFMYmlKT3drb05qbGtSWGh5R3MyRld1L29K?=
 =?utf-8?B?ME5EOWpmREJHSUxYS2pZS2RMZmdaQTlxSEFSWnhqNS9CM0prV1hNZW9sSldt?=
 =?utf-8?B?TFZQVTNBZWgzKzdjRnpMbVRKSHBHNnRYaXhJaVR1V3pwbW5BRXhsK05YM2sr?=
 =?utf-8?B?OWh0ZmNmVEpwRHVwQ0lXUHlkZTZTaTBVSTZ2QnFXcENFY0xtMHp1RXd2SzQ1?=
 =?utf-8?B?UEd4Vlh1d1YrcE84emdlT0M4OW5heUJmWUEyOUpPQmwxVlJRanFMbit6Lzkz?=
 =?utf-8?B?OEtsSW1RM09TRGdRRG8zeXNoeG1Ha1NGY3p2R01kUWl1UWQyNUU0TWlHenVQ?=
 =?utf-8?B?SFVSalJwbG1ud2RPNWZneWNQNDEwbExIRW15MmZsem9qNzJmS1lOMmZDWDdl?=
 =?utf-8?B?OEgvdGoycXdRWnNnWlJGT1J6ZmJHSEs3OUtzR3JBY0N0SWZZbHArMTg2RDhz?=
 =?utf-8?B?bEtkcWNtVStWUDR3bTQ1enRUbnowNXUrWmE0KzhJdmQvNTVuVUJQVkNUOXBa?=
 =?utf-8?B?Z0hGQTFsWG9MN0ZwR0hlTVVuQlVoOU0zN2ZXY3h3OTRnakZxTXA2LzQ2SFNk?=
 =?utf-8?B?UThHTjVLZUFiZW5JUnVtUVNxQ1ZLS3BjcG5VdFUyNkZqZis2ZTJQQmxxOEVt?=
 =?utf-8?B?WlZUYy9ydDQ2U0srWDRJQWlZTC9ndWZXcG9vWlBBU0g4YjFFcUNuTTAwaFp6?=
 =?utf-8?B?WGFLYjhXZThUTGM4Y3RWZ29wVHVEWXU0Ull0QzFtODE2T1ZESXpzUjhuMTJk?=
 =?utf-8?Q?X8TzDbtnWQhtm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjZIcTZhS0JTeHF1UnRwSmlFVjBNSDVPdUNScms3Wi9FcDRCZTVHSFQxVEcz?=
 =?utf-8?B?b0pPS1lFMkF0MktPVFFnT0xvdGFiMHE2YUh5Wm8wSy9GSldXamNZTGNBaDhC?=
 =?utf-8?B?eG9wMDV3SUpySFg2Y28ybm5uK09TOFcza3VqV0QvZTJoWW1ac1diWlllMkpk?=
 =?utf-8?B?ME8yVlZXRFZPTFFiRFQzcXRrY255T2dqWEhVM0ZLZlZjL2M1LzhSQ0xsZ2hY?=
 =?utf-8?B?R1lvRkRTSU9Wd01FNlJ6SnR5ZVVIb3pwK1p0NlVLOHZkckNqYVNETG5tRFZU?=
 =?utf-8?B?Q3N5U2w5R21YV1Y1TnJ6SVV0azZhb0NCMGhhT014cDVQUWVTYzdlVy85U05t?=
 =?utf-8?B?OEpPcDJsa0xOc25oSFp1eWY5ZEtGdUY5aytNS2NvM2c1dnJvaFBDUkpVUzdW?=
 =?utf-8?B?Rk5BT3B6TUpQRytTcDlUTDliSUZkYWRXdE1LRUczdS9XVFRsdm9XWnFVS1kx?=
 =?utf-8?B?YWZIMlo3MVhMdUM4ZmhSYXJtaFNKSktoeUFTVE85T2xFZXF0eXpWMXZnK2lk?=
 =?utf-8?B?ZkdKQ3hZMHMzN0ppZ1ZXMlFEYXd5ZjBSVkxYRG03V2xWK1Q5WExELzhHYTNn?=
 =?utf-8?B?LzU1dEdpLzhRQzVHL2twUGVZYmU4TG5BenJGRXhLOHE0aW84dFowcG5kRjFX?=
 =?utf-8?B?ZmlXZnRpazFiOVloQVF4VnhiN0pUd201L3hvLzI0STRPUlpUZFl5Q3F2bHhn?=
 =?utf-8?B?ZHpwZGZLVkFuSFRKU3IyOW5zU1hJNHo4U3k5ZS83K0dPQ1llSmRqUnQxaXhW?=
 =?utf-8?B?UXN1MnR3OStkVXcwUXEyZDR4eUJPSEtIRGE4d0hSbjdSVExoa3FEdHBtWWhj?=
 =?utf-8?B?ZWlLNUE5Q3VuSXI5ZWVpS09udnV2Sm9wQ0h5aWFScm4wTVVmZjlKU0ZjWG81?=
 =?utf-8?B?Y3VRYVRtT1JJSFRIUk14cEpLMUpwMFE2bGFZOHY4OTA1Skxad3A3NjFUcDgv?=
 =?utf-8?B?NE5YN1ZMSExWZkNJemRMNjVnSENQVnlqcFdtQncwa056ZFNrdVZmVkxpMmJ0?=
 =?utf-8?B?aFIxRDNKWC93SFhwMmRzU00rbi96cjgxdDc2S1RNZ3N3VVlObnIvMkJJTFBO?=
 =?utf-8?B?WGg1Qk5WU291VFNhaVVmSkZYNWhBbE5EOTBBM01kT0Q5cytCSmE5VWQ3eWhq?=
 =?utf-8?B?TThTVDc2bDZDWlJTcjRIb3diaUEwZGc0K1VzZUpqbjF0b2xNZ0ZHQzlCTnFw?=
 =?utf-8?B?ZTZFV01NTnBUMTZ2RWpveVBHTjlHMm9XUFRDV2JBZnUzd3hmajlPcENMUjhl?=
 =?utf-8?B?bHE5Z2tzbVVheGYxWDUxNWFyRlgzb2NDRFBKRWV4RHRFQW0wa2xXd3FYWm04?=
 =?utf-8?B?L0NaNU1kRVV1Rjg4WklTTTFBZnZ3eUVuUk0xWFlLRWhpcFhqeCtqOFNuMndU?=
 =?utf-8?B?OFBqTGRDblZlRHQzZzEyTFhTRzBtanQrQklGcnNPdUlaRE9TZFhrSjk0NlRt?=
 =?utf-8?B?RGFqSmpaRkd1cGJRRkI1QktZR1hVWFlOTmFBa0JZVkQ5MmRaSFpIL3JSRlpE?=
 =?utf-8?B?VUpZVnl5MUFycHlKZUdNR2RUTGY4c3hYazViSWNnQUZUZHpxSit2RHJURm5I?=
 =?utf-8?B?WU42ZDBxMG1waUhJSGxia0tFTVREbjV4N2F4OEJLQldmdHFpZmt3SDR2TjNS?=
 =?utf-8?B?elB4R1llMEZkZ0p5emV4V2VKLzRNY3VGNnZ0VmJTSWpOWkpYQWdNSlRpVGYr?=
 =?utf-8?B?Y2Vxb3NsU1FUQmUyOVFhOHJVd0VKVVE0Y25WWEdwdTJwdFBzSE9FUm8yWDBi?=
 =?utf-8?B?TnZabGRsWFJXejF5RGRPNER4M2V3VXRYV21PMkdLRDFENmxwcUlTVGVGZ1ZT?=
 =?utf-8?B?L1VBUWdXYVBIUzljbGUxdnd1RU1Sd2lzMmgzejk0d1JQb3EzZ1JlUis0cWRD?=
 =?utf-8?B?QVlhcTgvZk04VFRsaHdrMmg1aFl3UDlNU1RuQjZiNXBwZ09BYVE0dlBCbTdP?=
 =?utf-8?B?NnByRUc3MlRzMDc2VndFTHBJY0taYlhvdXdHOXd3SjlHRzdNV1NzbDdBVmts?=
 =?utf-8?B?V1pOVGNUZ3VrRGdMMlRiRDhNVWtJcW4zSG94MmlpRCsxSEpHaXhHYnBUYVVF?=
 =?utf-8?B?MkFGcGk2c1VlMU93Y29IZTRHdE5VeTU1NW50N0M0MWV4aHZVaGNtMVZWcXRO?=
 =?utf-8?Q?xFJWrdIGOZ6l2Xi0S7YSY67co?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e43911-441a-4bbd-14fd-08dd5d8d093a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:30:48.4603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H82TRVB/H4C6oZJKI0INwUEiQP8o4gd28NfN5m0d7os3Rf90GVbh7K47czpibamdO6VPAtgF8EhSIoFwAvsBRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
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



On 2025-03-07 09:48, Alex Deucher wrote:
> On Thu, Mar 6, 2025 at 10:45 PM Kenneth Feng <kenneth.feng@amd.com> wrote:
>>
>> Reset the workload type when using MALL.
>> When there is no activity on the screen, dal requestes dmcub
>> to use MALL. However, gfx ring is not empty at the same time.
>> Currrently the workload type is set to 3D fullscreen when gfx
>> ring has jobs. No activity on the screen and the gfx ring empty
>> state can not be synchronized to each other. By removing the
>> 3D fullscreen workload when there is no activity on screen, the
>> event can be passed down to dmcub->pmfw, since pmfw only allows
>> MALL when the workload type setting is bootup default, then MALL
>> can be really used. And this does not impact the thread to detect
>> the ring jobs and can set back to the 3D fullscreen later.
>>
>> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> index 36a830a7440f..154936166896 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> @@ -244,6 +244,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
>>         struct vblank_control_work *vblank_work =
>>                 container_of(work, struct vblank_control_work, work);
>>         struct amdgpu_display_manager *dm = vblank_work->dm;
>> +       int r;
>> +       struct amdgpu_device *adev = drm_to_adev(dm->ddev);
>>
>>         mutex_lock(&dm->dc_lock);
>>
>> @@ -271,8 +273,14 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
>>                         vblank_work->acrtc->dm_irq_params.allow_sr_entry);
>>         }
>>
>> -       if (dm->active_vblank_irq_count == 0)
>> +       if (dm->active_vblank_irq_count == 0) {
>> +               r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_FULLSCREEN3D, false);
> 
> To keep this balanced, you should get a reference when we disable the
> optimizations.  Also if ROCm applications are running, the compute
> profile will be active so that should be decremented too or if VCN
> jobs are running the video profile may be active as well.  On the
> other hand, if users have apps running when the display is off, maybe
> they don't want the idle optimizations in the first place.
> Alternatively, we could have a suspend/resume workload profile
> function that sets a flag in sw_smu which sets the default workload
> profile and skips all updates to the workload profile while that flag
> is set.  The swsmu will still track the ref counts and then when we
> resume the workload profile handling, we can restore all of the
> workloads profiles based on the ref counts.
> 

I don't think it's a good idea for DM to explicitly switch
power profiles.

Generally the display driver interacts with PM in
two ways:
- indicate min clocks that are needed for real-time operation
  of DCN
- allow various state switches when the driver knows they
  won't impact real-time operation of DCN

Harry

> Alex
> 
> 
>> +               if (r)
>> +            dev_warn(adev->dev, "(%d) failed to disable fullscreen 3D  power profile mode\n",
>> +                                        r);
>> +
>>                 dc_allow_idle_optimizations(dm->dc, true);
>> +       }
>>
>>         mutex_unlock(&dm->dc_lock);
>>
>> --
>> 2.34.1
>>


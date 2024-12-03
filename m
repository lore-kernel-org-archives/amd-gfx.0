Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D25E74ADD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5365C10E71C;
	Tue,  3 Dec 2024 21:38:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zBv5atzb";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED9A10E71C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktgLdcf5TV2HYYho1KRkzS6SYon5S0l6hvrhpx1mmtCS/lSHrO2S59irtL37/bO52AEb1w+bE7TIgtOxMKsfm1XMLywqaHOh50nH6pZqgfy4odA/O5jV6SeVofgYnd7D9CJvc1kqPOIjUdpnbtedyBp+kGnnxstOcWSECOCx/mDDI5YxnF1d4wQ/1G2FttBFLBWRZ28CaDv9ofHDW6+rznd7Ke4KyKtdyZcEfmRYQjoUIDFG0fqgT4yXMS13nBbWuwM9iMFxJn0VXldrKVmJSD33o4qvy+o1q6MuTcxHW4ifSKalOGgYL1lYwTHIx0XCEwnobs7/Omp9Hu5U7qaAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAn4HOP/vMWZrLzYxHyLan6w8c/AYQzVEicEwo8fH3o=;
 b=JhhiNjUrbVZiM3BIa4yOaT9k/15HT8SsHDkap5vNV9E/+rdwnRnrsxw5K3ZpZqdpIT0hxVOYSxMeSvPjSVEBESKFX5hbMEMnJMfUQw11OKKA/07ejGB85+bTK+BfZf9ztEmg0f49PPDmKFwEyu6XTR5mG2jBrKQDxyn8PjjDKo8Njp4sxRCxqsbkvH+KBj+O9wLfO8QWm4BxiZV1trT5Utkad0FqIx5V4kcloUvk4jEnhgP/JpgxC1Apy032nuOYX9Yg6NoFmS5FxiIvyGKz92bN7PQVASRIRf7Yph/Oo3jEWfdzwFdbduYA3TUy0bSvEuz0ZAOquf42KajJo14lYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAn4HOP/vMWZrLzYxHyLan6w8c/AYQzVEicEwo8fH3o=;
 b=zBv5atzbyybQDFrdQ5FQIo9uFGVooquKEY4xesTmAENWEpndOqLgZsIGcsgk/mM2Wj9VYVsM+qhrKkdPijjUOp3AsyORLoZLw8u6E6AHIB7ygllS8HgxKLs4AjSABzOxjk1kgpAgImk6zWYgeEZ/0Lch9HP7NWDs1LqVumvqz3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Tue, 3 Dec
 2024 21:38:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 21:38:51 +0000
Message-ID: <df71d375-7abd-4b32-97ce-15e57846eed8@amd.com>
Date: Tue, 3 Dec 2024 15:38:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <CADnq5_MfGC=f-+=eT4g0hMQtqjJxX-GuHDOPLV9Z3KsUFg98rA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_MfGC=f-+=eT4g0hMQtqjJxX-GuHDOPLV9Z3KsUFg98rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:806:27::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2cce60-8fb5-4faf-b7fd-08dd13e2e10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cllOT1QyOFpuTFB3SEJoc0YycXRvS3gyM0hxcXFpN0w0dmp6bjRDeWNqNFFa?=
 =?utf-8?B?c0RrRm80TThwdS9TUDJXVExUV0RMWnpURis4RGJZYVlTQ2dtVkh5bjNzRGg5?=
 =?utf-8?B?V05ERGV3MitaRXlCVXNvdEQ3c203MnlCMWxET0JSTEw1ZzhtOUhDeFVjRWlN?=
 =?utf-8?B?SUdvbFZQbnd2WFNzWXZPdjFDSWhzMzFJZ1FnMWlSdUxrZGxuUzUzdjNld2FR?=
 =?utf-8?B?empVdnNDK0d1cUo0MmlDUFhyNHZhYnYwTTRTUnRVWHVkMWhjWXhwSWVkNWp4?=
 =?utf-8?B?TW11UitKR2lSb2dCd2Nyb0lSVHF2eHlVYWdrUnNDSy91VmNpdVV4aThrSSsr?=
 =?utf-8?B?TEpiaFRGMy9DamFRaWViU3BSQmZ4Qm05NnJySFMrcm1TOEtGS1VhOW03Nk9a?=
 =?utf-8?B?LzUvQmlkRCtYRlpuaHdOejg1dDd5VnlRZXc4ZFVjNDJlRWQxV1c5c2lkbEY4?=
 =?utf-8?B?cDRFRUx0cDRuVTNvOFV4Wm5mWllkWkw1U1JqalZLOFdNN1B5SllYVzNSR2pD?=
 =?utf-8?B?M0NYazllZmQyNVA1VTQwMDlHLy9NdnNJd00ycXNWT09weFJnN3NZZlBFTVAx?=
 =?utf-8?B?YWFpTFVDQ1BEMFB2dVhOZGR0UlFQN1VNZFN1UjBITUhvVlYvOXN2Vys3eDBX?=
 =?utf-8?B?YjJPUThPZ09lYnZVdysxK1B4bWI3MjZUTlJQRlVYaTRma0k1ZHhuRFREZFND?=
 =?utf-8?B?eVVIbGhrQ3NQN21vQVdYWGpkdWx1NzRKUTAwYTVGaTloMU0rNjM4eFpERlcw?=
 =?utf-8?B?N0pweWFGZmk0Y2FCZ0VHWDhLYUNabXZlbzJodTBPdTRNcVlyaXl6ai9TeXpJ?=
 =?utf-8?B?NXV6dzl4OTVwRWV0VElQbS9TV3JlWFFOMnRma2puV1dkUWNkdWRyQ3dURzgv?=
 =?utf-8?B?NTVjVmpFQnQ3ZGRreTZseGFTTEVIWVhIcjN5cm8wVy9lTXVRd1VsSGltRzVw?=
 =?utf-8?B?TkxZRXQwRExTZlNJMG5pb3lldFgrUDlFNm9LZW8wUktiZ1dielM3clZTVDkz?=
 =?utf-8?B?UG1NN2U1RkNlYmFjSDhWWGd1SyswZGRDd2dmOGVKWFhEejJZQ3hyMFZtc0dR?=
 =?utf-8?B?VVk1dFZpVEsxamlnUE9qUGUrWHhwSkM3Z2Y1TGNaRWlZZzl5ZGw1dnp6Vmo3?=
 =?utf-8?B?M05RcmdjV1JtbmFZRitjMTdTeVlQVm8zbWFndFlLTXhudFE1T1FwZ1VRWlZy?=
 =?utf-8?B?emhteE5OZDJpdU9FeTdSN1NSYjdqdFhKMHNzRGRPU3lDKzh6QitjS2dCZVZy?=
 =?utf-8?B?eVNFV2NwU1owZFY2aEwzc2lUa1pmVGpvaEY1bTJBSFRlL0IvaXVzQ2NpWDRB?=
 =?utf-8?B?ZW8vYlk1WXN5YXRqNjN0cFRwbDFqOEYwMk5mc0twb1FkK2xUOXBVRG1jTm55?=
 =?utf-8?B?YlhzcWRjRG5YR0FVNVlQakVyUENTdGkvL0cyeEdKU0Ewa2ZYWmNhN2E0VVZ4?=
 =?utf-8?B?RlpHVUtoZUhtRnliL2JaeTVyU1hhbkgzUFFJSlNCVGRobEpnTkhmbENTNVUw?=
 =?utf-8?B?ZkdHcVl6bkhNUjBueTBwVVJoNTAvaXExd3FCc01pOEorTVJ4NmIvWFlWK0wz?=
 =?utf-8?B?ME8xSlhFMU5hK3NvdTVpTk5FQzdKS01veWFQOUlML2VRMlhQM1dNU1lwM3BC?=
 =?utf-8?B?VU15Q0NXN1VqSXFPRFNtMmVIb3dGZ0ViUlhEYjFoSUU5a1ZNK2IxenVpL20y?=
 =?utf-8?B?a25YVStIMUlDRFNuclpvODFvZ3BiK2FwRFNqRHN6NmI5RzUvQytSNEltaWdV?=
 =?utf-8?B?NHNwZ25oc3lhMi9ObWV1a3JaMEVhNDhsRzJKNmtwaG5IVEU5OHFCUis5NWJW?=
 =?utf-8?B?eHZVMmVjeERCNnZEZ3k2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU02NmpEM0JYOEVRZnVMRmk4Mk0xQ2tmaDUzS0ZvMXBOQXZvM3VLRWY4WVYz?=
 =?utf-8?B?dE13WERsOUh0N3pzZnphcE1rVlVWak5nTGZaUWdtWXVtblluWm5vb0VPT203?=
 =?utf-8?B?T1dKQzVkdE1Gell6MnI4eGtPT0V5V2NkcWhROVp4S0hJbkNuY2I5UDRSWFpm?=
 =?utf-8?B?ODBpM09OdHRwSnFMRFJGdzAvOXIzVE1UbndBOGRPeVF6TllpS09xZ2k2K2cy?=
 =?utf-8?B?R1ZSZzJlaU9mWmNWOG85c0NJOGthazVpRHJkWlB6WWlMNEc0dnhIc1hOOTV0?=
 =?utf-8?B?U1d6bVkxZ1podnkvN2w5dDlISFNpQ284VXBuNFlmYnF6cUlsdGFxb21jNm1B?=
 =?utf-8?B?bVVyTU01VG9FMDRhQXhwMVBIR2tSRG5MdDFsekZCdVdvR3RGYjYwbkhjMzA0?=
 =?utf-8?B?dzdZQUNVcC82aHkxZ0tndWR0Y0psVFliVS8xUkxZOFFjWFVRdE1ZTUZSVkJZ?=
 =?utf-8?B?cGxmb1FMVTZLdm8wVWYxRG53SGJWOWFaY0NMQ0k2TUZ2YnpzdHdtTHZWSTBm?=
 =?utf-8?B?S0dCNkJYVHJYekM5ZCs1c1k0eHN6VXM4UjRHUS90aEQ0YlNIdTJyWGY3Uk9x?=
 =?utf-8?B?V0xhOVEwRDFGYlhCaU02NjlwNE1tbk1JUHB4QUptd1MwL0pyNW0wdGtpU0Fm?=
 =?utf-8?B?NjJhNWl2QldPSERUZk1oVGlsQ1lCSHMvVnNGcHB3NnZOc2RKQmhKSGs2QUFS?=
 =?utf-8?B?dS9wSFNyWUZxbmh5TDdFbjJaTEM2MHAwWUY3a1RSSU5JOCtBbFYvM3NqcWRB?=
 =?utf-8?B?T0F1MVpmSjdzby9taExPakRDVjBuZmJ1M2ZIa2JyamNOaC93UXEwNmFpR21q?=
 =?utf-8?B?SytaVytRV1pIUkVuZElNL1laQ0NnbGhBMnRkSnB3OFlNSFZjVUlUZTR0OE5z?=
 =?utf-8?B?Q0JhdWdYRXpWZmpqTVBGNGluSmFtUXpwWXZESzRzZXdiT3RtMC90RWtid0pm?=
 =?utf-8?B?dklIRk5VY2Vycm02WFN1clRCYmVyTmZweEtXOFYxelZEOVI5M2hnTmppQkg2?=
 =?utf-8?B?TUxLVERQVk4yenNQNXprdjV4ZXlNbjNHTGNCMDlTTndSVGNJcWpHSm16eDV4?=
 =?utf-8?B?ZENLSC9oMUtKN1hUd0VMTFQ5aS9zZHp0OW5ySnRZc1hvNHBDdktZSktLblFp?=
 =?utf-8?B?RWlFRjcyeEVKby81Z2VkaXUycEFZM0NtanZCWkxXeXJCdnVlT1ZFNlFEY3Fh?=
 =?utf-8?B?MnVZUlZCR0xWc0NqZ09ZTzRiQ2kwU1BLOWF3WUdwelFOODVnL3VYTmxVZDY3?=
 =?utf-8?B?L3ZpS1h2Z1E3VDBjTk1lSStXekJmNCtZMjVZZnFNZEdyNHhMVlp0YmtSTWpj?=
 =?utf-8?B?N0dJS3NyNWZEQ1JzZCtOVHErL3dlVW5TQzNqenB5SzlBUVlKRlAxZVhraGlp?=
 =?utf-8?B?dkVLRXlBbzJIT3hUT2Q5ZERuMmh4VVhqVElnQ3BRV3ZsUnVGRE5McVFpc3RJ?=
 =?utf-8?B?MytZOStVQWV3ZkRjNERPcEJFZFdhTUVvUkt2bkRZcFdPWDBxR1FyS2FFUHdG?=
 =?utf-8?B?VlEwV1U4TDU2WVFGOVlDUlBHVG5QYUJtZUIwYVp6Q29xTHRUZFlqY3daVHhH?=
 =?utf-8?B?UmZrR3FpWTJ2SVFhck5EcFVJQUtqKzRRekFLR2g2QXpEZVJ4c3NWcEtxSTJR?=
 =?utf-8?B?Y2gzellNTVJPdHNLZDJDSGlhNWtNK0xKTGx1MWdhY3JlZnpzNWVEYlFwUzZ0?=
 =?utf-8?B?ekhNV2RmUTREelE0UEJlb0M0MVNhTUpER2JCZktRUDJnVkorVzF0ZTd1SlU1?=
 =?utf-8?B?NjBHeVYyejU0VHpaSU9FZlZOK2tLNlpJekswYTBWSUQ4NmtUU01CVmIzbFVC?=
 =?utf-8?B?R1hhdlJLTXp2ZDBkeTh2WFFKam94SmZLajVuNEg3cVhDRmYrL0VHK2RwbGxV?=
 =?utf-8?B?LzM4Mk9QZjJlM2VvWThoZk1SYk5ZSXVISFpGL2JEbEtxRkN0NDJQQXV6czBk?=
 =?utf-8?B?dHAvZi95QlluaEx5MkhOSy8zN2Y2YzNFc0VtakFjZVNobmdET1NxS0p5M3kw?=
 =?utf-8?B?SktZQkdvUG1lZkMrdUtXM3ExbHByVTlObXR1YVE2VnpHM3M4c0thbUNPZlE5?=
 =?utf-8?B?Zzl2d1R0SFhFQnQ3K2t2YmQ0N3ZrZklGV3cya2U4UTl2RFlIQ1pvSlNYR1Uz?=
 =?utf-8?Q?dmBuQfuLzKK+rQnpKrm/wFTXl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2cce60-8fb5-4faf-b7fd-08dd13e2e10a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:38:51.8057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+xnyuKwb/SbgiPX1u3QKqBsd9koP6E410NMHn0lzA+0tkGdSw1iboVHoDAMQnWPreYvyS/a57vnRIO+pkbyzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
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

On 12/3/2024 15:34, Alex Deucher wrote:
> On Tue, Dec 3, 2024 at 1:14 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Some of the firmware that is loaded by amdgpu is not actually required.
>> For example the ISP firmware on some SoCs is optional, and if it's not
>> present the ISP IP block just won't be initialized.
>>
>> The firmware loader core however will show a warning when this happens
>> like this:
>> ```
>> Direct firmware load for amdgpu/isp_4_1_0.bin failed with error -2
>> ```
>>
>> To avoid confusion for non-required firmware, adjust the amd-ucode helper
>> to take an extra argument indicating if the firmware is required or not.
>>
>> On non-required firmware use firmware_request_nowarn() instead of
>> request_firmware() to avoid the warnings.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c        |  4 +++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c        |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c        |  4 +++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c        | 18 ++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c       |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c      |  8 ++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h      |  9 +++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c   |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c        |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c        |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c        |  8 ++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c        |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c          |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         |  5 +++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  6 ++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         |  5 +++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c          |  4 ++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c          |  6 ++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c          | 16 ++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          | 12 +++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c        |  7 +++++--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c          |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c          |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c          |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c         |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/imu_v12_0.c         |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c         |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c         |  2 ++
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  6 ++++--
>>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c     |  3 ++-
>>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  3 ++-
>>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |  3 ++-
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  3 ++-
>>   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c |  3 ++-
>>   35 files changed, 136 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
>> index 16153d275d7a..68bce6a6d09d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
>> @@ -414,7 +414,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
>>                                  return -EINVAL;
>>                          }
>>
>> -                       err = amdgpu_ucode_request(adev, &adev->pm.fw, "%s", fw_name);
>> +                       err = amdgpu_ucode_request(adev, &adev->pm.fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>> +                                                  "%s", fw_name);
>>                          if (err) {
>>                                  DRM_ERROR("Failed to load firmware \"%s\"", fw_name);
>>                                  amdgpu_ucode_release(&adev->pm.fw);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 16b9b3c4190c..83f0de30317e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2483,6 +2483,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>>          }
>>
>>          err = amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw,
>> +                                  AMDGPU_UCODE_NOT_REQUIRED,
>>                                     "amdgpu/%s_gpu_info.bin", chip_name);
>>          if (err) {
>>                  dev_err(adev->dev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> index d52f18393970..56cc179fca26 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> @@ -77,7 +77,8 @@ static int isp_load_fw_by_psp(struct amdgpu_device *adev)
>>                                         sizeof(ucode_prefix));
>>
>>          /* read isp fw */
>> -       r = amdgpu_ucode_request(adev, &adev->isp.fw, "amdgpu/%s.bin", ucode_prefix);
>> +       r = amdgpu_ucode_request(adev, &adev->isp.fw, AMDGPU_UCODE_NOT_REQUIRED,
>> +                               "amdgpu/%s.bin", ucode_prefix);
>>          if (r) {
>>                  amdgpu_ucode_release(&adev->isp.fw);
>>                  return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index a67e6a52347f..bb946fa1e912 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -1438,10 +1438,12 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
>>                           pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
>>          }
>>
>> -       r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], "%s", fw_name);
>> +       r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], AMDGPU_UCODE_REQUIRED,
>> +                                "%s", fw_name);
>>          if (r && need_retry && pipe == AMDGPU_MES_SCHED_PIPE) {
>>                  dev_info(adev->dev, "try to fall back to %s_mes.bin\n", ucode_prefix);
>>                  r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
>> +                                        AMDGPU_UCODE_REQUIRED,
>>                                           "amdgpu/%s_mes.bin", ucode_prefix);
>>          }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 12832fd834fb..3043ec5d3a31 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -3290,7 +3290,8 @@ int psp_init_asd_microcode(struct psp_context *psp, const char *chip_name)
>>          const struct psp_firmware_header_v1_0 *asd_hdr;
>>          int err = 0;
>>
>> -       err = amdgpu_ucode_request(adev, &adev->psp.asd_fw, "amdgpu/%s_asd.bin", chip_name);
>> +       err = amdgpu_ucode_request(adev, &adev->psp.asd_fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s_asd.bin", chip_name);
>>          if (err)
>>                  goto out;
>>
>> @@ -3312,7 +3313,8 @@ int psp_init_toc_microcode(struct psp_context *psp, const char *chip_name)
>>          const struct psp_firmware_header_v1_0 *toc_hdr;
>>          int err = 0;
>>
>> -       err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, "amdgpu/%s_toc.bin", chip_name);
>> +       err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s_toc.bin", chip_name);
>>          if (err)
>>                  goto out;
>>
>> @@ -3475,7 +3477,8 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
>>          uint8_t *ucode_array_start_addr;
>>          int err = 0;
>>
>> -       err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, "amdgpu/%s_sos.bin", chip_name);
>> +       err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s_sos.bin", chip_name);
>>          if (err)
>>                  goto out;
>>
>> @@ -3751,7 +3754,8 @@ int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
>>          struct amdgpu_device *adev = psp->adev;
>>          int err;
>>
>> -       err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, "amdgpu/%s_ta.bin", chip_name);
>> +       err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s_ta.bin", chip_name);
>>          if (err)
>>                  return err;
>>
>> @@ -3786,7 +3790,8 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
>>                  return -EINVAL;
>>          }
>>
>> -       err = amdgpu_ucode_request(adev, &adev->psp.cap_fw, "amdgpu/%s_cap.bin", chip_name);
>> +       err = amdgpu_ucode_request(adev, &adev->psp.cap_fw, AMDGPU_UCODE_NOT_REQUIRED,
>> +                                  "amdgpu/%s_cap.bin", chip_name);
>>          if (err) {
>>                  if (err == -ENODEV) {
>>                          dev_warn(adev->dev, "cap microcode does not exist, skip\n");
>> @@ -3909,7 +3914,8 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>>          if (!drm_dev_enter(ddev, &idx))
>>                  return -ENODEV;
>>
>> -       ret = amdgpu_ucode_request(adev, &usbc_pd_fw, "amdgpu/%s", buf);
>> +       ret = amdgpu_ucode_request(adev, &usbc_pd_fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s", buf);
>>          if (ret)
>>                  goto fail;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> index 113f0d242618..b3c032f249f5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> @@ -219,9 +219,11 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
>>          amdgpu_ucode_ip_version_decode(adev, SDMA0_HWIP, ucode_prefix, sizeof(ucode_prefix));
>>          if (instance == 0)
>>                  err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s.bin", ucode_prefix);
>>          else
>>                  err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s%d.bin", ucode_prefix, instance);
>>          if (err)
>>                  goto out;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> index d3cd76c6dab3..ffbb3377e0f6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> @@ -1434,6 +1434,7 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>>    *
>>    * @adev: amdgpu device
>>    * @fw: pointer to load firmware to
>> + * @required: whether the firmware is required
>>    * @fmt: firmware name format string
>>    * @...: variable arguments
>>    *
>> @@ -1442,7 +1443,7 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>>    * the error code to -ENODEV, so that early_init functions will fail to load.
>>    */
>>   int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>> -                        const char *fmt, ...)
>> +                        enum amdgpu_ucode_required required, const char *fmt, ...)
>>   {
>>          char fname[AMDGPU_UCODE_NAME_MAX];
>>          va_list ap;
>> @@ -1456,7 +1457,10 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>>                  return -EOVERFLOW;
>>          }
>>
>> -       r = request_firmware(fw, fname, adev->dev);
>> +       if (required == AMDGPU_UCODE_REQUIRED)
>> +               r = request_firmware(fw, fname, adev->dev);
>> +       else
>> +               r = firmware_request_nowarn(fw, fname, adev->dev);
>>          if (r)
>>                  return -ENODEV;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>> index 4150ec0aa10d..827d75185d83 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>> @@ -551,6 +551,11 @@ enum amdgpu_firmware_load_type {
>>          AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
>>   };
>>
>> +enum amdgpu_ucode_required {
>> +       AMDGPU_UCODE_NOT_REQUIRED,
> 
> Maybe:
> AMDGPU_UCODE_OPTIONAL instead?  Either way.

I like OPTIONAL better too, thanks!  I'll adjust it.

> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> +       AMDGPU_UCODE_REQUIRED,
>> +};
>> +
>>   /* conform to smu_ucode_xfer_cz.h */
>>   #define AMDGPU_SDMA0_UCODE_LOADED      0x00000001
>>   #define AMDGPU_SDMA1_UCODE_LOADED      0x00000002
>> @@ -604,9 +609,9 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr);
>>   void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
>>   void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
>>   void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
>> -__printf(3, 4)
>> +__printf(4, 5)
>>   int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>> -                        const char *fmt, ...);
>> +                        enum amdgpu_ucode_required required, const char *fmt, ...);
>>   void amdgpu_ucode_release(const struct firmware **fw);
>>   bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
>>                                  uint16_t hdr_major, uint16_t hdr_minor);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
>> index bd2d3863c3ed..dde15c6a96e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
>> @@ -587,7 +587,8 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
>>                  break;
>>          }
>>
>> -       r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, "%s", fw_name);
>> +       r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, AMDGPU_UCODE_REQUIRED,
>> +                                "%s", fw_name);
>>          if (r) {
>>                  release_firmware(adev->umsch_mm.fw);
>>                  adev->umsch_mm.fw = NULL;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> index 31fd30dcd593..30e9869a0584 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> @@ -260,7 +260,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>                  return -EINVAL;
>>          }
>>
>> -       r = amdgpu_ucode_request(adev, &adev->uvd.fw, "%s", fw_name);
>> +       r = amdgpu_ucode_request(adev, &adev->uvd.fw, AMDGPU_UCODE_REQUIRED, "%s", fw_name);
>>          if (r) {
>>                  dev_err(adev->dev, "amdgpu_uvd: Can't validate firmware \"%s\"\n",
>>                          fw_name);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> index 599d3ca4e0ef..65387f6943b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> @@ -158,7 +158,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>>                  return -EINVAL;
>>          }
>>
>> -       r = amdgpu_ucode_request(adev, &adev->vce.fw, "%s", fw_name);
>> +       r = amdgpu_ucode_request(adev, &adev->vce.fw, AMDGPU_UCODE_REQUIRED, "%s", fw_name);
>>          if (r) {
>>                  dev_err(adev->dev, "amdgpu_vce: Can't validate firmware \"%s\"\n",
>>                          fw_name);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 05f01f50194b..2455cc126e59 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -99,9 +99,13 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>>          amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
>>          for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>>                  if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
>> -                       r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s_%d.bin", ucode_prefix, i);
>> +                       r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
>> +                                                AMDGPU_UCODE_REQUIRED,
>> +                                                "amdgpu/%s_%d.bin", ucode_prefix, i);
>>                  else
>> -                       r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s.bin", ucode_prefix);
>> +                       r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
>> +                                                AMDGPU_UCODE_REQUIRED,
>> +                                                "amdgpu/%s.bin", ucode_prefix);
>>                  if (r) {
>>                          amdgpu_ucode_release(&adev->vcn.inst[i].fw);
>>                          return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> index 83cb9f565fe5..2c12840ea444 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> @@ -236,7 +236,8 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
>>          int ret;
>>
>>          amdgpu_ucode_ip_version_decode(adev, VPE_HWIP, fw_prefix, sizeof(fw_prefix));
>> -       ret = amdgpu_ucode_request(adev, &adev->vpe.fw, "amdgpu/%s.bin", fw_prefix);
>> +       ret = amdgpu_ucode_request(adev, &adev->vpe.fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s.bin", fw_prefix);
>>          if (ret)
>>                  goto out;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> index 1563e35da0fe..a5cd950c94be 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> @@ -133,9 +133,11 @@ static int cik_sdma_init_microcode(struct amdgpu_device *adev)
>>          for (i = 0; i < adev->sdma.num_instances; i++) {
>>                  if (i == 0)
>>                          err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_sdma.bin", chip_name);
>>                  else
>>                          err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_sdma1.bin", chip_name);
>>                  if (err)
>>                          goto out;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index f1b35b4a73ff..c4e15418e187 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -4138,18 +4138,21 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>>          amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
>>          if (err)
>>                  goto out;
>>          amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_me%s.bin", ucode_prefix, wks);
>>          if (err)
>>                  goto out;
>>          amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
>>          if (err)
>>                  goto out;
>> @@ -4173,6 +4176,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>>          }
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
>>          if (err)
>>                  goto out;
>> @@ -4180,6 +4184,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>>          amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
>>          if (!err) {
>>                  amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index f63a06661f86..67cd42031571 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -641,6 +641,7 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
>>          int err = 0;
>>
>>          err = amdgpu_ucode_request(adev, &adev->psp.toc_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_toc.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>> @@ -690,6 +691,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>>
>>          amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
>>          err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_pfp.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>> @@ -707,6 +709,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>>          }
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_me.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>> @@ -722,9 +725,11 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>>                  if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 0) &&
>>                      adev->pdev->revision == 0xCE)
>>                          err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/gc_11_0_0_rlc_1.bin");
>>                  else
>>                          err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_rlc.bin", ucode_prefix);
>>                  if (err)
>>                          goto out;
>> @@ -737,6 +742,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>>          }
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_mec.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index ebb09c363803..d0697b0869e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -539,6 +539,7 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu_device *adev, const char *
>>          int err = 0;
>>
>>          err = amdgpu_ucode_request(adev, &adev->psp.toc_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_toc.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>> @@ -568,6 +569,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
>>          amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_pfp.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>> @@ -575,6 +577,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
>>          amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK);
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_me.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>> @@ -583,6 +586,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
>>
>>          if (!amdgpu_sriov_vf(adev)) {
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s_rlc.bin", ucode_prefix);
>>                  if (err)
>>                          goto out;
>> @@ -595,6 +599,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
>>          }
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_mec.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> index 81c185a8b3a0..1b4c0dcee7e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> @@ -337,6 +337,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>>          }
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_pfp.bin", chip_name);
>>          if (err)
>>                  goto out;
>> @@ -345,6 +346,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>>          adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_me.bin", chip_name);
>>          if (err)
>>                  goto out;
>> @@ -353,6 +355,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>>          adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_ce.bin", chip_name);
>>          if (err)
>>                  goto out;
>> @@ -361,6 +364,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>>          adev->gfx.ce_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_rlc.bin", chip_name);
>>          if (err)
>>                  goto out;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index 60931396f76b..17a07e1adffa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -934,33 +934,39 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
>>          }
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_pfp.bin", chip_name);
>>          if (err)
>>                  goto out;
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_me.bin", chip_name);
>>          if (err)
>>                  goto out;
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_ce.bin", chip_name);
>>          if (err)
>>                  goto out;
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_mec.bin", chip_name);
>>          if (err)
>>                  goto out;
>>
>>          if (adev->asic_type == CHIP_KAVERI) {
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s_mec2.bin", chip_name);
>>                  if (err)
>>                          goto out;
>>          }
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_rlc.bin", chip_name);
>>   out:
>>          if (err) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index f15beb217b48..a2a45be68c24 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -982,13 +982,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>>
>>          if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
>> +                                          AMDGPU_UCODE_NOT_REQUIRED,
>>                                             "amdgpu/%s_pfp_2.bin", chip_name);
>>                  if (err == -ENODEV) {
>>                          err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_pfp.bin", chip_name);
>>                  }
>>          } else {
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s_pfp.bin", chip_name);
>>          }
>>          if (err)
>> @@ -999,13 +1002,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>>
>>          if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
>> +                                          AMDGPU_UCODE_NOT_REQUIRED,
>>                                             "amdgpu/%s_me_2.bin", chip_name);
>>                  if (err == -ENODEV) {
>>                          err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_me.bin", chip_name);
>>                  }
>>          } else {
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s_me.bin", chip_name);
>>          }
>>          if (err)
>> @@ -1017,13 +1023,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>>
>>          if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
>> +                                          AMDGPU_UCODE_NOT_REQUIRED,
>>                                             "amdgpu/%s_ce_2.bin", chip_name);
>>                  if (err == -ENODEV) {
>>                          err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_ce.bin", chip_name);
>>                  }
>>          } else {
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s_ce.bin", chip_name);
>>          }
>>          if (err)
>> @@ -1044,6 +1053,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>>                  adev->virt.chained_ib_support = false;
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_rlc.bin", chip_name);
>>          if (err)
>>                  goto out;
>> @@ -1093,13 +1103,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>>
>>          if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>> +                                          AMDGPU_UCODE_NOT_REQUIRED,
>>                                             "amdgpu/%s_mec_2.bin", chip_name);
>>                  if (err == -ENODEV) {
>>                          err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_mec.bin", chip_name);
>>                  }
>>          } else {
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s_mec.bin", chip_name);
>>          }
>>          if (err)
>> @@ -1112,13 +1125,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>>              (adev->asic_type != CHIP_TOPAZ)) {
>>                  if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>>                          err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
>> +                                                  AMDGPU_UCODE_NOT_REQUIRED,
>>                                                     "amdgpu/%s_mec2_2.bin", chip_name);
>>                          if (err == -ENODEV) {
>>                                  err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
>> +                                                          AMDGPU_UCODE_REQUIRED,
>>                                                             "amdgpu/%s_mec2.bin", chip_name);
>>                          }
>>                  } else {
>>                          err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_mec2.bin", chip_name);
>>                  }
>>                  if (!err) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 4e27528b7e57..30d9b6dacb6e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -1429,18 +1429,21 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
>>          int err;
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_pfp.bin", chip_name);
>>          if (err)
>>                  goto out;
>>          amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_me.bin", chip_name);
>>          if (err)
>>                  goto out;
>>          amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_ce.bin", chip_name);
>>          if (err)
>>                  goto out;
>> @@ -1476,6 +1479,7 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
>>                  (((adev->pdev->revision >= 0xC8) && (adev->pdev->revision <= 0xCF)) ||
>>                  ((adev->pdev->revision >= 0xD8) && (adev->pdev->revision <= 0xDF))))
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s_rlc_am4.bin", chip_name);
>>          else if (!strcmp(chip_name, "raven") && (amdgpu_pm_load_smu_firmware(adev, &smu_version) == 0) &&
>>                  (smu_version >= 0x41e2b))
>> @@ -1483,9 +1487,11 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
>>                  *SMC is loaded by SBIOS on APU and it's able to get the SMU version directly.
>>                  */
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s_kicker_rlc.bin", chip_name);
>>          else
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s_rlc.bin", chip_name);
>>          if (err)
>>                  goto out;
>> @@ -1518,9 +1524,11 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
>>
>>          if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>> -                                          "amdgpu/%s_sjt_mec.bin", chip_name);
>> +                                  AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s_sjt_mec.bin", chip_name);
>>          else
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>> +                                          AMDGPU_UCODE_REQUIRED,
>>                                             "amdgpu/%s_mec.bin", chip_name);
>>          if (err)
>>                  goto out;
>> @@ -1531,9 +1539,11 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
>>          if (gfx_v9_0_load_mec2_fw_bin_support(adev)) {
>>                  if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
>>                          err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_sjt_mec2.bin", chip_name);
>>                  else
>>                          err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_mec2.bin", chip_name);
>>                  if (!err) {
>>                          amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 8eccb080d56f..9c146e37c55e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -545,6 +545,7 @@ static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu_device *adev,
>>
>>
>>          err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
>> +                                  AMDGPU_UCODE_REQUIRED,
>>                                     "amdgpu/%s_rlc.bin", chip_name);
>>          if (err)
>>                  goto out;
>> @@ -578,10 +579,12 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
>>
>>          if (amdgpu_sriov_vf(adev))
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>> -                               "amdgpu/%s_sjt_mec.bin", chip_name);
>> +                                          AMDGPU_UCODE_REQUIRED,
>> +                                          "amdgpu/%s_sjt_mec.bin", chip_name);
>>          else
>>                  err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>> -                               "amdgpu/%s_mec.bin", chip_name);
>> +                                          AMDGPU_UCODE_REQUIRED,
>> +                                          "amdgpu/%s_mec.bin", chip_name);
>>          if (err)
>>                  goto out;
>>          amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index 8e878ab44e76..2245dda92021 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -131,7 +131,8 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
>>          if (((RREG32(mmMC_SEQ_MISC0) & 0xff000000) >> 24) == 0x58)
>>                  chip_name = "si58";
>>
>> -       err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
>> +       err = amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s_mc.bin", chip_name);
>>          if (err) {
>>                  dev_err(adev->dev,
>>                         "si_mc: Failed to load firmware \"%s_mc.bin\"\n",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index 347bccd92696..9aac4b1101e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -157,7 +157,8 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
>>                  return -EINVAL;
>>          }
>>
>> -       err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
>> +       err = amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s_mc.bin", chip_name);
>>          if (err) {
>>                  pr_err("cik_mc: Failed to load firmware \"%s_mc.bin\"\n", chip_name);
>>                  amdgpu_ucode_release(&adev->gmc.fw);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 29ce36038b3f..d06585207c33 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -259,7 +259,8 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
>>                  return -EINVAL;
>>          }
>>
>> -       err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
>> +       err = amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s_mc.bin", chip_name);
>>          if (err) {
>>                  pr_err("mc: Failed to load firmware \"%s_mc.bin\"\n", chip_name);
>>                  amdgpu_ucode_release(&adev->gmc.fw);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> index d4f72e47ae9e..aeca5c08ea2f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> @@ -50,7 +50,8 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>>          DRM_DEBUG("\n");
>>
>>          amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
>> -       err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu.bin", ucode_prefix);
>> +       err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s_imu.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
>> index 1341f0292031..df898dbb746e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
>> @@ -47,7 +47,8 @@ static int imu_v12_0_init_microcode(struct amdgpu_device *adev)
>>          DRM_DEBUG("\n");
>>
>>          amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
>> -       err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu.bin", ucode_prefix);
>> +       err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s_imu.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> index c6af318908e4..269bf1e3337b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> @@ -145,9 +145,11 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
>>          for (i = 0; i < adev->sdma.num_instances; i++) {
>>                  if (i == 0)
>>                          err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_sdma.bin", chip_name);
>>                  else
>>                          err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_sdma1.bin", chip_name);
>>                  if (err)
>>                          goto out;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> index d438f2f7a408..c9ad9ec48688 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> @@ -305,9 +305,11 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
>>          for (i = 0; i < adev->sdma.num_instances; i++) {
>>                  if (i == 0)
>>                          err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_sdma.bin", chip_name);
>>                  else
>>                          err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
>> +                                                  AMDGPU_UCODE_REQUIRED,
>>                                                     "amdgpu/%s_sdma1.bin", chip_name);
>>                  if (err)
>>                          goto out;
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 85f21db6ef24..fff5a1cdf474 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -2338,7 +2338,8 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>>                  return 0;
>>          }
>>
>> -       r = amdgpu_ucode_request(adev, &adev->dm.fw_dmcu, "%s", fw_name_dmcu);
>> +       r = amdgpu_ucode_request(adev, &adev->dm.fw_dmcu, AMDGPU_UCODE_REQUIRED,
>> +                                "%s", fw_name_dmcu);
>>          if (r == -ENODEV) {
>>                  /* DMCU firmware is not necessary, so don't raise a fuss if it's missing */
>>                  DRM_DEBUG_KMS("dm: DMCU firmware not found\n");
>> @@ -5306,7 +5307,8 @@ static int dm_init_microcode(struct amdgpu_device *adev)
>>                  /* ASIC doesn't support DMUB. */
>>                  return 0;
>>          }
>> -       r = amdgpu_ucode_request(adev, &adev->dm.dmub_fw, "%s", fw_name_dmub);
>> +       r = amdgpu_ucode_request(adev, &adev->dm.dmub_fw, AMDGPU_UCODE_REQUIRED,
>> +                                "%s", fw_name_dmub);
>>          return r;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> index 2bed85ba835e..a87dcf0974bc 100644
>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> @@ -7709,7 +7709,8 @@ static int si_dpm_init_microcode(struct amdgpu_device *adev)
>>          default: BUG();
>>          }
>>
>> -       err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s_smc.bin", chip_name);
>> +       err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s_smc.bin", chip_name);
>>          if (err) {
>>                  DRM_ERROR("si_smc: Failed to load firmware. err = %d\"%s_smc.bin\"\n",
>>                            err, chip_name);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> index 480cf3cb204d..189c6a32b6bd 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> @@ -105,7 +105,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
>>                  return 0;
>>
>>          amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
>> -       err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
>> +       err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> index bb506d15d787..7bb45ff6d5c8 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> @@ -103,7 +103,8 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
>>                  return 0;
>>
>>          amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
>> -       err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
>> +       err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 8344f54e6674..5b86df0c8536 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -305,7 +305,8 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
>>
>>          amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix,
>>                                         sizeof(ucode_prefix));
>> -       ret  = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
>> +       ret  = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
>> +                                   "amdgpu/%s.bin", ucode_prefix);
>>          if (ret)
>>                  goto out;
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> index 4d083f7f772e..9b2f4fe1578b 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> @@ -79,7 +79,8 @@ int smu_v14_0_init_microcode(struct smu_context *smu)
>>                  return 0;
>>
>>          amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
>> -       err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
>> +       err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
>> +                                  "amdgpu/%s.bin", ucode_prefix);
>>          if (err)
>>                  goto out;
>>
>> --
>> 2.34.1
>>


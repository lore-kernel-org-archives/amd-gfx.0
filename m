Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A142CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 17:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3631910E39B;
	Tue, 26 Aug 2025 17:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D13Lbn7X";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D55F510E39B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 17:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3DqRLE7Coehp877zIfyhYx8MyOOo94CqlSnk8ND7QIw+dFt4loX2KjPWGUUCVPrWqXfvdtRbLGJ+PR7F5QXgXKr4dUrihVTSB04YOTQ/8YJSIZ+38sVsZOTtkK/d8a7Z4q8cJHbSYa0ao8p2ZU2Cccig3iR0B6dPY1h/PZL0CYadd/Vl2Tf1RabfS/FrYTorwS+OfAygAZJsMAJifkgWRqReOeS7hdDxPhZ9t7T05WzGWb2OU4NJk//4ANnorlJvAZEhYlIscaCvdh84IIS4nbbkdZXIqR0lZfvDQY+G+DlNmnWLWnXKMqiW3JeGLwMX7lRyOQo+2q2UfnskeAhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKqr35qSaQzJRQV7MzZ6MPMk9Sxll/4wm//KIdN8OZ0=;
 b=PAyRqNAxeDP1Xed+GWMl0aUn2w0oRIct17IoT7vtfnb1r7Bvx1LuPybPLP2oT0FEsRKj56xi9rZgcn7juu3TeA/rIjcH70idWxXS6+O/ROZQpMeIRl/fkGc7Go+SorGK2+gzgLb5clzfWNSqJzjRCsIGC7mPifPsB6TYEYivfTFJuNdDC0jYwOp6h7zyl3UAHngsxdsykKceQ2/lCe/qxYV5vJCmHK2zUCtmSP8K/qgMgVQRiV3QHjFXJoVQyfhapKJIEi+2RKRfNK4yCqLaQaBHjToM3I9Si+FHsXTtBtuwb6rf232TSfCbZOTUgop05lkh/fzQ3wbvdS+Ts2rdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKqr35qSaQzJRQV7MzZ6MPMk9Sxll/4wm//KIdN8OZ0=;
 b=D13Lbn7XT9PagT5+7f0YN3EaorytWm28Ay0mwLkQZ/Z2X6ZIXEUTJnnAgvPm4M4xG0jXgl9DvOXIPOjaGpoBB2oVQwfxHnU5VhaYNUSP61LoJjyX8JDlJWxqmZKCR6jZf8Neoq0hYpWKihO0g+HuwUER1QsvqsbNA0ARFChBCh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Tue, 26 Aug 2025 17:29:22 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:29:22 +0000
Message-ID: <64d029c5-09ec-42a7-aa82-c935adfc5d7e@amd.com>
Date: Tue, 26 Aug 2025 13:29:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vpe: cancel delayed work in hw_fini
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250825133742.1494754-1-alexander.deucher@amd.com>
 <CADnq5_MkPtrrVeAZr-8HfP1EAYsc8kTB0+pohgmAe3ABFC8qyQ@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_MkPtrrVeAZr-8HfP1EAYsc8kTB0+pohgmAe3ABFC8qyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0041.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::16) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cf52c8-ba8e-4daa-e0ed-08dde4c6186b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEZTK2FvNHE3Z2lqQUJwczBtc1pvUnZwNnVmVEprWndPM3RyVmhBOUxGRXVu?=
 =?utf-8?B?WXJmZHNXL0xJSnYySDFkdWQ5NmNTb3pUK21Ia21VdnNWbUE1SkNURExjdjAz?=
 =?utf-8?B?MFl3bnJ2UkFWaEZNUFExcWU5SjhzOUw0ckdObmpJQ1lYWVRnODBFTmJXaHd4?=
 =?utf-8?B?VC9XMGdmb0poMm1nc0w2bWI2K2c5bnd2K0FXUWluZXBNR2R0U0xSWTE3RWo5?=
 =?utf-8?B?VWFvTzFPUDNmejVwYkE5a2ttYTc3a2QxcFJmMGhIMHM3VkpER1hWcURDelNr?=
 =?utf-8?B?SnZFbjc0czZFQlRBbDRyRHlSdytyRTh1aGw3QTFNMkRBdnVLNFZYb3hxdUFk?=
 =?utf-8?B?aXlCYXZXWE02dnM2TW1vMEZTSDNFeHJyQmhoZzhtaHlBT2x6QURoby9zVTM2?=
 =?utf-8?B?Vzhta0FHajZYVWNUN3dPS1ozdnNWdUQ5ajZWZEhPV2ljSUdMWmJUc21WZ0Ri?=
 =?utf-8?B?a2RIK3duc2VvTlp5akpWN3QzcmZMQjlFdjFrbHVHQ2ZMTFBkTlIySWhaRUh6?=
 =?utf-8?B?Mk1OQTVDT3hHQXo4RG5JbXZ0VmFpbE0rbDFNR2NWSHRvK1E0SDgxczJzL0Fx?=
 =?utf-8?B?c1FjS3prdTByL2RuS3o1RFdPa1FiRnRiRy9mcDI1cFFTNTJNdys1b25lQzFU?=
 =?utf-8?B?OFdMbjRhWW9mWmM2RDdUY0xhUEhPMHAwbXI5MnVNN0RKZXRGaVpDNGZSdTc4?=
 =?utf-8?B?bFVJa3VlVDFYcG5wYkV5SDFxL2tDSktYaFdSSWNXdFNRZ21DQVdWbnllbFJL?=
 =?utf-8?B?UVJIUmlOZ2g0M25sZlNWa2tyUGI5ODlmd0IzRDlWdzhZcks1Q0FtNGhDdVk2?=
 =?utf-8?B?bXBLMGwxVWl6MEl1VzMweWgyMm16ZFZIcU1JRlRSVjBaOEY1U2Yrb0JOc0w3?=
 =?utf-8?B?T05RMW1tQUNRRE4ramY2YVNDekh2RDR6dk5hUWcwaWtKbVRFUEVzTXRWVnJR?=
 =?utf-8?B?S1VzRlFKZHJXQ2xjcnlGcVZBYmcwMGZMeTlra09NOWVHMWhudng0Tk1wTUY2?=
 =?utf-8?B?UnFpNnc1YUhMK1Q0ajM4cWVqd1cwcTV4WWxneW1aNnFEdjBkM3pOZmFicXNI?=
 =?utf-8?B?bzFtQXJOR0N5RllzNHB3cW9Vc2ZQeEpQZUhLM29iVU55Y1E1YWVUbHNpaCtN?=
 =?utf-8?B?bUtKdzE0TE9GWUdBOURUbTNmUUhYRjd6UUllbWR3amRqT0l1Q3lWWTV3NWlE?=
 =?utf-8?B?ZVhnRTZicjJhRnhxQXFvWlU4OVpURXZ0QVB2ZTBSOHA0b3p2b25uOU16Zmox?=
 =?utf-8?B?T1ZrQmdvWk5DVGs1U0ZFcGVKQTQ3NDNSeTEvRXFEVTdMQlljZitBTnhNcUFa?=
 =?utf-8?B?UURrOThDLzI2b1JJT1ZJRlZUQkNMM1h5M1pTQVJEeE5YVW1TTjhjRHlhZG5M?=
 =?utf-8?B?TEt4cVR2L1djNHNHM0ZhM1FIRWkvcE8wblFPUVZ1ZnRYWW9aSUR3TFpXSW9J?=
 =?utf-8?B?Sm5KektKMHVTaFB0cGtPandvQzU2RmdiQzJrL1NOUFN1T0ZQd2h4M09YL0lQ?=
 =?utf-8?B?dzlsTDVSU013NmdGS3hkU2RGNkRCM2JqckdyWGROVEJveXFneWxsZGlKYlov?=
 =?utf-8?B?Vm1yZTdZZHNCUlhCSmtaT3FJSnoxUHlBZG9yRW5RMTFwL1Y5c2JkTCt2ZWNQ?=
 =?utf-8?B?end0Unc1UDZjSEtnVU5JOGQvbEIwdVp6elJOeFQxZmlJb0p0eW5TZExlVkU3?=
 =?utf-8?B?S1VZWStaWnpuSzlMUVhOMk5DSXdlekQzZkQvRGhGbGhBVCt2WllGd1d0RGlO?=
 =?utf-8?B?TVdPb1FXaU5id1QxZUg1eHJldE1IV0xuZkp3V0hBR09wM0xBS1JOTzhUdlhm?=
 =?utf-8?B?aUwzWFBsZGlqZkV5Z1IxQ2x4QURyN1ZFTEg0Z0NmZ1RSajVkOWUrbFA0SVJI?=
 =?utf-8?B?TGVoaUVRekJWcGZmZm5sSlZUa2Z0bE4vVENNUkU5Q2FxWWYrelcxemhTS25K?=
 =?utf-8?Q?EMkg4p5Djko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUNDZzNGa0NFeUhqUUg5UnJUUTJTN0FGTlF1L1hBRitNL3JaWURva2NxR2JY?=
 =?utf-8?B?RzVDK21NSUN1VytXOXVKVWQ4V3dIb0l0OGRRcTkySTM3Y0xTek5ZbENDaTB6?=
 =?utf-8?B?SUlkU3UzaVVLMkZUaGJIbTJMWUZOMEpDSnYwMDJNZzcxM3c4Q09oQmxpWDNP?=
 =?utf-8?B?Yk10M0tzcDZ2Q1R1RTdmemlIVEh2RVM1dUw4aDc5NlQ4SFNWUFpPT3QwejVK?=
 =?utf-8?B?S3lWTyt5VW5HdzY0akF1K3lVeis3bzNza2dISW5zWUswV0dPc1JiVFZJWW1Y?=
 =?utf-8?B?TjBpbzBtZEhWWFNsWXhWYXFaelVtY05ISllUOTB6RWRNQXJQcmdLYUR3azVG?=
 =?utf-8?B?NmV0dWJmQ3hjRGZaNUo4ajZaTmpIUUFlOXFLRGU1S1dndXhiOTI3d2RyUmFB?=
 =?utf-8?B?OWxESmMwQ3BkWXVyc3pCZy9nMmk0UEs4ZEJvTDZHSlZzVXR5d25XbG9xNWNB?=
 =?utf-8?B?cDBYeVpRUldRdW9RcFRUWHF1MEhTMlRHLzZxN2NOYWw5L1BIYVBZTmpIOEZ3?=
 =?utf-8?B?WGFEOUN0ZHE3S2RqMlFvNlFvMVUvS3VZZUpxbEJNVE5lcHBPNUhYOUNtUGhL?=
 =?utf-8?B?T3k2UTZ4NXpYZk9tbTB1OUZJbVpsMC94bEVMYmgvTXE4akU4L09RRXVhYjhm?=
 =?utf-8?B?cG1JcEd1RUoySU9lME8xak1vZmRobTJkTnlmTFVJSEpueXB5M1gwRFp2TnQ0?=
 =?utf-8?B?Z0xLeGVvVG1qZWVMSDFCNm5LUFh0QndWZjY5Q2d2SjFJemxyWTN2NzJGRHpQ?=
 =?utf-8?B?bDdKZGZjcGdiNzhxQk4vZytXelYyckVkelFYWGwxczRQbVRqRzdibzhjUnRQ?=
 =?utf-8?B?NnQrVFRGRUc2M2N3SHB4TDZBT1Ezd01DVjlhSXFiZWlzanZOb2FmVEoxcjdI?=
 =?utf-8?B?a1FLdUg2Zmt4Tk9HSlB6L3d5bTFEWUZVUGVmY3pYbjExYmYxZDRvSlovQlBz?=
 =?utf-8?B?dEphZEdnK3lpTjA4VUFXbVhrbTB3S1MxV1J6c2ViWGpudFJnRUxYSGNoeEox?=
 =?utf-8?B?cWdnejhpYXk1TU1TR0owTTZkN1B2SlVUWUl5MkRENTc5cGQ2SVZCRUovaVVq?=
 =?utf-8?B?M055cTE0M2IvMUV2bk02RWxXTml1blc4a1lYZVR2KzFocVFEeUdXRzl5aWFu?=
 =?utf-8?B?Rzlma3VRdUFsbFJuYXRhTXlRdGxNbXlqTnFneGpaL012NGRONGNiSFI1WEtN?=
 =?utf-8?B?a2NJanByQUNQL3Q5WFk1a0JTVWtISlV2WVdQOUpxeHpPMC9hVDVNalk5Wkor?=
 =?utf-8?B?dTZOM3g2QnJ2TVRVbkVKNzRkVXptdllzMGd4R3NiUk5KZTFyY0RTdTVVNldV?=
 =?utf-8?B?Nitkdy9jS0VzdHRNN3pTek4xWW0xUUt4SzlKSXV3c3hBdEEvZmNHK0RLMG9x?=
 =?utf-8?B?eklXSUh5RVQ4Q0puTi96dUNUaFFtRGxCY0NDd3c4Tzgyamx3V3VsNjU0TmE2?=
 =?utf-8?B?QTRnaUN3V2Z6WWVtOXVTRHU1S0tPcDZhTFRocjkrclg0dXB0NUc0SDZNWDhW?=
 =?utf-8?B?VGQ5VnZUZlVlSDF4YVRtYWV1MWlwU0hUV0V5LzQyTGxwNXBtR3drZGJqbmI5?=
 =?utf-8?B?b2p4dThDSnpSQXlwMVplNEFwaXpSelR4SlFuckExaGYvM3FHek5hWGFCMzNk?=
 =?utf-8?B?REhtNE1qM2FlNGF2MjJlMDY5cllaejFsRHBNTGVvVUF3M1BUT1cyWko0OFlD?=
 =?utf-8?B?R09jclJsWWN6OWw0a1h1TDE3MlJpWHhZWEpGRHJubExhVU1UR09MMTk5REJU?=
 =?utf-8?B?d0ZiUVlhSnJ1bDZ3eVdTZFdVOHdBNmdJRUZiZFEwZnVKc1Vaa2IwbHlZVFNJ?=
 =?utf-8?B?aHFramVEUDdCUG1RN1h5eU45WVdDWnlTdFkvcG5sQThsdlZtSHFwOUxSNGZG?=
 =?utf-8?B?Z040RzRNemxxYlJOYkIxUkNDT21abFVkMWxPK1JFdzQzSG9OcldDSmZXbkxS?=
 =?utf-8?B?SkFiUGo3MG96YmRZM0RpMlRvTDhoRlRMZzNPbWYwSGhUa2YyRVpvVGZMM2Vl?=
 =?utf-8?B?aU9UNkF4a1h5VkJTRk52NzdON1ZFU3dPM3U5M3J6Y21qMXk3WERJQ1VhdUhp?=
 =?utf-8?B?K1dRY2QxWHIydGdBeFRodU5SaHM2Z3JGbGc0ZUV2RUFnVjkrSzFWV2xzYWli?=
 =?utf-8?Q?Y9DPT3X8lnOYknRaA9OBW3kb+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cf52c8-ba8e-4daa-e0ed-08dde4c6186b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:29:22.2847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFbsDZt/zYhH+mhrz0qSzPoBPcP1P8qh/wWAmLURgVzt+kEaIYkP6Ob4xDtOizggYGsEUIxOsWBIegpyGZOXBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
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

Looks good to me - thanks!
Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

On 2025-08-26 12:29, Alex Deucher wrote:
> ping?
>
> On Mon, Aug 25, 2025 at 9:48 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>> We need to cancel any outstanding work at both suspend
>> and driver teardown. Move the cancel to hw_fini which
>> gets called in both cases.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> index 86573c8d9b91e..474bfe36c0c2f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> @@ -436,6 +436,8 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_block)
>>          struct amdgpu_device *adev = ip_block->adev;
>>          struct amdgpu_vpe *vpe = &adev->vpe;
>>
>> +       cancel_delayed_work_sync(&adev->vpe.idle_work);
>> +
>>          vpe_ring_stop(vpe);
>>
>>          /* Power off VPE */
>> @@ -446,10 +448,6 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_block)
>>
>>   static int vpe_suspend(struct amdgpu_ip_block *ip_block)
>>   {
>> -       struct amdgpu_device *adev = ip_block->adev;
>> -
>> -       cancel_delayed_work_sync(&adev->vpe.idle_work);
>> -
>>          return vpe_hw_fini(ip_block);
>>   }
>>
>> --
>> 2.51.0
>>

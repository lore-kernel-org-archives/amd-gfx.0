Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CD6C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB1610E2BC;
	Mon, 17 Mar 2025 14:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kPFH+jNG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD1F10E2BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1Sch6/FCmv2jOgJsXiGCFrmtQmauRFPqcwt5fc+PUXiI4ZA98yB09d1wW7KsmtV6C26CjWBAns0zyyjPPv2eHzqiD9Tm4PIE1GFESw4h6War4HL58ftME3IotFb10lPnbEWS9wxEkAsk12xb/nWFdxu3o6UH4fT0fKOOPPTuzKTH3pNITKd5OQkSZOJtmf3Zw0t3gc16fXVvE2vWRw3hqJHD8yeYZl/spICj8ddRGTmBW5Pl4iHyX0hiszt7gh8IsK+9lMTHKB4FDsBslWmtzwv3znW4N3jc1oMJwFZBOvx8XNShzTzyXY5ZZdl5bUFvs2QZOGOmk9E2WGtQW6F/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eICgcOmmfgv0M4+YqMtSthv85eDWTuNTfvR26+jJuhc=;
 b=JMQVUPmU5chrgV+vB32WiqQb3/Nt7QvfxB0wHi+e5KkE+pREVFamhDiNy6hTF1/1f2sliHc+zSDG9D3LJfLQZdj4xT6u2GLKBNpuuIwx0EyaixZtkKhHfTDltKOizNj/PLRQoGt6qwYSxnhV81w4Y3Fux0lHymvhzdZNauwWIixzwpdA8aSOakkilH2g71+W9NRDoWmBl1kbnIKhespW5wxJgXuDL57fmDkK9GAPFPc9Xt84tidVkTltW91f7BQO7h7dEo/ops3qHXM8shp2/jPdfQVgAPR/afj6MNFynMH93Md5oCfLmKFId1Kwd1qGJizfZLisD3TmAe0H8j9V6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eICgcOmmfgv0M4+YqMtSthv85eDWTuNTfvR26+jJuhc=;
 b=kPFH+jNGNkDJfY5NB5evIM407NpFudfA816igizl9uvccNjHMLAg4W/xGbJqms5nDVKdWpk/YSfMappbvmdySfITFhxUmygoupSW/aL4mhxhYkBLgE2ZTkqICCT5XI6J9cARkJnkZ5N2N3ko7drwS5j7ljVuIgnfTBH3dcWgQx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 14:34:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 14:34:13 +0000
Message-ID: <193a6fa0-de96-4b51-a90d-92960ea544a2@amd.com>
Date: Mon, 17 Mar 2025 20:04:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/sdma: guilty tracking is per instance
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250317134710.764906-1-alexander.deucher@amd.com>
 <20250317134710.764906-2-alexander.deucher@amd.com>
 <fe300995-19cd-4b60-ac63-31778ca28028@amd.com>
 <BL1PR12MB51441DF52D9DD1DF26BD6456F7DF2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB51441DF52D9DD1DF26BD6456F7DF2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::35) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: c5dcbf56-b5fb-4313-d8e1-08dd6560c983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW1WYksrdzNYenZVbXduZ2tPaXZoaTJwOXdNalhvR29scUhES2xOMXpEOE0y?=
 =?utf-8?B?cUVLb203dldyUjJ3d2NIWjlEVThhMDdtcEhUSlJpZFJnTWJBREM0aUh3VXd1?=
 =?utf-8?B?aWdKdkJzczJiaGhtcEFJYmZHVUtyTTdOR1dhTkRMUXBsRS9xL0pVS0NtWWx3?=
 =?utf-8?B?NXFDcFU5QklUQmJwbWRRaHk5OEtwZVh6WHhldjFCSEUxVHNtQUdHeFZKTVhs?=
 =?utf-8?B?WUwxcCs5SzlPSlFqdzRoZHVqaGZzb0k1RmtEQ2hYY0xlUndjbERKNlhWRlcy?=
 =?utf-8?B?RzRVZTltbXNLRW5YU1VPU3YwUDY3b0ZNMzZkVzN6NHJFMFRURGRHVmFzV2lr?=
 =?utf-8?B?QnBmWm9GWVA3Z1IrUGlWLzMySW1QUjV1bzZ1MkhuVDhidTM4aUVIK3IxNXZV?=
 =?utf-8?B?NTlYMTBDMFJmcUUrelRQZlZsbDdUUjRQd0d5THk2dlRkSUhlNHpNL29abnR1?=
 =?utf-8?B?d1Jmb1dFOEJTNXVOVURYQnhTVDAvamNTcWZlQkxBUjRlOTltWFBwSkRlemZ3?=
 =?utf-8?B?b2NTaVJFSU9BSi9DRkVCNFZtVm5uK1dtdlBabnQyczFZVjdEU29rNzhoUXV4?=
 =?utf-8?B?VFo2MWtCU0xBMWJBSzlKb2NNSGYzR2hMeDl4d1JqRitGdnFJdzQwYTdEM1Br?=
 =?utf-8?B?YnI4Y1hUcHJtMW5sNUJvS2JZZk1vaHdrMDRQeFhQbDFzU1JFcHhpQ2h1RmNO?=
 =?utf-8?B?TVBKVWVrZi9NMmNjY1pFMjhpeklKcllac3FMVDRyUU1NSnFWUk02Rzd3Ymxv?=
 =?utf-8?B?TEFvQ2c1ckd6UFNVRVowaEhWUWE1R2c0ZEdrYk5qQTFXbnV4ak5Sa1lCTUl2?=
 =?utf-8?B?Zld0RDV5T09uSmVUVjF4NGtSUGM2cFArQ2o3V0NYV1VTS1RKbkNKcklremwr?=
 =?utf-8?B?S2VvYUo2VVByNkpaUkNvNHlqTERVemx0M3pwL3JGNldRQXFzeXpYTDN4TlJE?=
 =?utf-8?B?NzNkaE5uOVBTQmJ5RVFWRVNwWXgyVzc1d21CbDNiWklhWXZDeHAxazdmMTdH?=
 =?utf-8?B?ZmYwRjI4SlpOZklvL2VIcGlNc2NjRzRTYUpwaTBZY1h3NjlzODhhLzUrbFY2?=
 =?utf-8?B?TG1vaUpqMStFNng4UkI4TW05ZTVzUWJIKy95MUJZR0NPaHVqVVRVa29hM2RX?=
 =?utf-8?B?dXpqUm1KYmx4R1RjNFhSenJzUlJoUHcxaE1LTGdveW5uTDNpaUVUQUwxOVkr?=
 =?utf-8?B?WWNHU1dnN1U3Sk5hVzJXQmc3alJYYnNaOXNSeHJpOUVNSGNIanlZN2FmS3Vl?=
 =?utf-8?B?N1dZNVMvd2EwVGt3YWFHNFJnOHRodU5vWnpwc1FnN0FrTUhETkZCNm80b0pB?=
 =?utf-8?B?bHRRSDF0WktwMGlhZWlwNUsxWlpoYzNjdXEzY29jdU43Nlh0Y1RoYjBkV2F2?=
 =?utf-8?B?ZlpQR3gySHFxUHRoOU9GZi93V0xxem5PTE5GTzVIVCt1OVFWSnZsMjZhRlhF?=
 =?utf-8?B?Z1h1bXVlMTFuOHlZVmd4eFA1OVVPbHZkbGtXNzZQdExuU21PWkJ6MmxzbDhx?=
 =?utf-8?B?Ynp3L3VwRUkrZEdTMnBzYW9oL1pBOTMzRnZVK3VPN1JFVlZtRDdaMGYreVYy?=
 =?utf-8?B?elhNaTdqRjRIV3NKYm05RWh2WEM3TGVMWmQ2STVXNlBob2xVZFdSbElnR0k0?=
 =?utf-8?B?eVpaQmJEL2RhK1NxT0hlYk1sdjArYlBJTjYxQlJqM0JhWEh0aWRvaGc3bGxV?=
 =?utf-8?B?ZjFkZFQ0MmxVem0wODlQZTZLUzVXUTVkS3pyOW5TaTgyUkxTRnBUV2JuUGtw?=
 =?utf-8?B?Ny9aQmFYYXBmakZyWHhGRWZGT1I1YWIzd3l3dG82VHVrbGVjMnhUSUNkTTQw?=
 =?utf-8?B?Z2hpWXVQUlFua3RQNGRCb1ZxcWNoVTBsV0swUk10QnNCUllzWEQ2OS83R1NZ?=
 =?utf-8?Q?aMtG4xhZOoncA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGg5eGlTZlROTzFVQVRDVHJDRWtQM1NSeEVvZHl1ckFKZ3IwbkVZNTJTMUZN?=
 =?utf-8?B?SFVUOGM1SFdYamdLVVRRUUpaNFloTXNQRmd0VW9vZHUxM1pXcWs1ZXJBQTBE?=
 =?utf-8?B?N2FaYU5tdlVYNFFhZi9IVTFGMzFYaWtLcHMyR1ZIRDZkYUo3MUVtMEpWZHo4?=
 =?utf-8?B?QjBwWjFJdW1yeENNNjdhUEdTRVNGVEw4SE1QUE5VdyszY2Q1T0pvRThmZmEx?=
 =?utf-8?B?RlJQTkQwOFc4dE1SdWkxYk5HOCt6U0Z2aUprOENGNVdsdnRsazJJVllOSkxO?=
 =?utf-8?B?ZGZBZVFSWmI4WGZtdVNwZXo5ejdkQm1qUHlWSVBZcTh0VWJWZ2J5b2Q3Sjkv?=
 =?utf-8?B?S1U5VHFiUkhqL0ZwUVVFNm9YWWYvN1NmRFl3NEdqZDZBOGR2K3JSd1JEUHJ0?=
 =?utf-8?B?dm9WWG5tNTE5MHA0Z1FyckgrWGNlMU5UZENoTjVWYi81UkdVQU43VlhoRXhs?=
 =?utf-8?B?K2xqTU8vNGE1MUgxYi90RGQ5VGIvTzhEMWk1RDhGUUFKdGdQUkFnRnUwWUN4?=
 =?utf-8?B?WGJsUEhsSHdXOE8xQmVIbDJtS0owVVMyM0JUbWRycmsvOUxsWTEweHFROERC?=
 =?utf-8?B?SHRlNmlGRGw3QTJUQnhlVTZCZnZST09VWHhSc1U2MGdtajFGdERYS2QvU2xX?=
 =?utf-8?B?Z2g3RDludGdQQjBFSDFicjV1Q1NCQks5akVOYnBiOHBqVS9OYWdwaFFDT0dQ?=
 =?utf-8?B?RTIya1F0Y0c0VXNpKzk1TFdDYy8vODE1K2ZzbjkyZktyZFJHUFhNRVNxUExt?=
 =?utf-8?B?Q3FkYjZBZXNTMFJzU1o5blg3Snhqd0dKQ2tVZFdKa3VJYUhyMWRwVGR6SGdZ?=
 =?utf-8?B?Q1h2OS8xMlY5dGl4M3AxTTJvSmZxMm1ZVEk0ZFJSWmxTbHdYN3h1b3UrRnZU?=
 =?utf-8?B?Vm5pWTc5dnFXdUtrU0FzQWFmUTc4RVA3U0xNamVrM2VoY3ZFcjRUMWRKNHkr?=
 =?utf-8?B?L3ArdVBrUjRmdzhibVBveG9URW9CZll1VHhzSlhHMkVJUFJ1WWJvZTlmWmJq?=
 =?utf-8?B?cVNFOVFub3h6bldyNEpzOVFrdVE2WG5jSWNJUTVpSEFtbVlXV1lEMkd6MU9i?=
 =?utf-8?B?MDFoN1FaV2lGWURqaTFsamNBMUgyWjdYbU04bWtNemVrM21DSXVJTmJ6OHNU?=
 =?utf-8?B?ZXc0TEw2ank2S1c4UzdhbW1FemlYUHhoVnZkK095aHlFeUNVUEdNY0grRGlM?=
 =?utf-8?B?T1BmbE5oQUl1T2MyVkE2UUNjeEUvWlAwd3FFckZKdHBCUXRETVYwL0JvQi9v?=
 =?utf-8?B?M202SWtoY1B2OVpLckNWdW05TEt2b2xpWXJkQkJaNlA0bjNIYWNXVlJwTEp5?=
 =?utf-8?B?YUlqdXgwTndySk5oOVA5R3E1ajkzSFh6b1oyTkFTank3Z0NrRCtpWGdyTzV2?=
 =?utf-8?B?UUErU1lpbzhnWXUrazFXZ1h3SVpHdm5hWHZFcDl2L01Yc28xa0xqb3lqTmRv?=
 =?utf-8?B?cDZITFJPTUhSY1Jqc1BJR01uY3BTZzVRY0E4V0RXM1o5b3VuNUtzWTBwekJ5?=
 =?utf-8?B?R0ZGMEpMb1pneU5QWEtrcHpuekNlYzUxck9rMjhUVlNRdld6MXhFM2loZXdK?=
 =?utf-8?B?aVNHRmNSL3ZJTEhlMUE2dU5DZ1JyeVp0bW1YVElNNU8wZ0NCQlZrZnJuaDdV?=
 =?utf-8?B?K3I0N1N1dk5DdEZUYVBnczdGRzBuVTVERWZiVW5OVmFsaWhROVUxaXlvdnFn?=
 =?utf-8?B?dkdIajErZjJ5di81SEZGdWphczdCUWtFMXdxQkpwTU1XOEQ0UnVvaTRuWks1?=
 =?utf-8?B?VFZpMDBocVd4REs1TmRvaUgxZG9WajdPN0xPbmdUMEZyL1NoV0lxZndLblRB?=
 =?utf-8?B?SWlRWUtTVG5JclQybWRZSzk4K3lPT3hUcnlReGtORDVPWTRmM0xqdG93eUo2?=
 =?utf-8?B?QzZyNmVyQWFkWkFxSmZ1RTJaN0wxeXg1VXBhRHpvSFR5VTVIM3c5NjVEOStO?=
 =?utf-8?B?anFnOWFaOG83Y1N6ZzZIUHd0dkhVQ3M5OUFYdHpsZnFueGJ3bWgxV2NDM0h2?=
 =?utf-8?B?d2lRQnZXYkNibGdGUHlNbWdNSkkxRFIxZjQ2aE5mUHI4VjFZN0ZFQmtmUjJ6?=
 =?utf-8?B?WmtkckdzOG1kZUR3RWZiMmcxYkl3djdiN3lOYUQ2bStIMFlsb3JCbmJuMUxv?=
 =?utf-8?Q?GGDxBUggc/xY5g7lfNd2Z/X3Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dcbf56-b5fb-4313-d8e1-08dd6560c983
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:34:12.9810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NB0MCnuaDenCxa00vpCFvlqYTSTt9OmQ1XDb79uoByK7+ZGcM8sxm4kr3zZB9sI6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233
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



On 3/17/2025 7:59 PM, Deucher, Alexander wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, March 17, 2025 10:19 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 2/2] drm/amdgpu/sdma: guilty tracking is per instance
>>
>>
>>
>> On 3/17/2025 7:17 PM, Alex Deucher wrote:
>>> The gfx and page queues are per instance, so track them per instance.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  7 ++++---
>>> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 18 +++++++++++-------
>>>  2 files changed, 15 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> index 8e7e794ff136f..dc1a81c2f9af7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> @@ -65,6 +65,10 @@ struct amdgpu_sdma_instance {
>>>     uint64_t                sdma_fw_gpu_addr;
>>>     uint32_t                *sdma_fw_ptr;
>>>     struct mutex            engine_reset_mutex;
>>> +   /* track guilty state of GFX and PAGE queues */
>>> +   bool                    gfx_guilty;
>>> +   bool                    page_guilty;
>>> +
>>>  };
>>>
>>>  enum amdgpu_sdma_ras_memory_id {
>>> @@ -127,9 +131,6 @@ struct amdgpu_sdma {
>>>     uint32_t                *ip_dump;
>>>     uint32_t                supported_reset;
>>>     struct list_head        reset_callback_list;
>>> -   /* track guilty state of GFX and PAGE queues */
>>> -   bool gfx_guilty;
>>> -   bool page_guilty;
>>>  };
>>>
>>>  /*
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index 927db7a080f0a..c485b582a20f6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -989,9 +989,10 @@ static int sdma_v4_4_2_inst_start(struct
>> amdgpu_device *adev,
>>>             uint32_t temp;
>>>
>>>             WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
>>> -           sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.gfx_guilty);
>>> +           sdma_v4_4_2_gfx_resume(adev, i, restore,
>>> +adev->sdma.instance[i].gfx_guilty);
>>>             if (adev->sdma.has_page_queue)
>>> -                   sdma_v4_4_2_page_resume(adev, i, restore, adev-
>>> sdma.page_guilty);
>>> +                   sdma_v4_4_2_page_resume(adev, i, restore,
>>> +                                           adev->sdma.instance[i].page_guilty);
>>
>> I think passing the flag is no longer be required as the instance id is passed already.
> 
> We still need to determine which queue needs to be reset and restored vs.just reset.
> 

What I meant is it can be checked from within the function -
adev->sdma.instance[i].page_guilty. Second param identifies the instance.

Thanks,
Lijo

> Alex
> 
> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>>             /* set utc l1 enable flag always to 1 */
>>>             temp = RREG32_SDMA(i, regSDMA_CNTL); @@ -1446,6
>> +1447,10 @@ static
>>> int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>>>
>>>     for (i = 0; i < adev->sdma.num_instances; i++) {
>>>             mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
>>> +           /* Initialize guilty flags for GFX and PAGE queues */
>>> +           adev->sdma.instance[i].gfx_guilty = false;
>>> +           adev->sdma.instance[i].page_guilty = false;
>>> +
>>>             ring = &adev->sdma.instance[i].ring;
>>>             ring->ring_obj = NULL;
>>>             ring->use_doorbell = true;
>>> @@ -1507,9 +1512,6 @@ static int sdma_v4_4_2_sw_init(struct
>> amdgpu_ip_block *ip_block)
>>>     r = amdgpu_sdma_sysfs_reset_mask_init(adev);
>>>     if (r)
>>>             return r;
>>> -   /* Initialize guilty flags for GFX and PAGE queues */
>>> -   adev->sdma.gfx_guilty = false;
>>> -   adev->sdma.page_guilty = false;
>>>
>>>     return r;
>>>  }
>>> @@ -1686,9 +1688,11 @@ static int sdma_v4_4_2_stop_queue(struct
>> amdgpu_device *adev, uint32_t instance_
>>>             return -EINVAL;
>>>
>>>     /* Check if this queue is the guilty one */
>>> -   adev->sdma.gfx_guilty = sdma_v4_4_2_is_queue_selected(adev,
>> instance_id, false);
>>> +   adev->sdma.instance[instance_id].gfx_guilty =
>>> +           sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
>>>     if (adev->sdma.has_page_queue)
>>> -           adev->sdma.page_guilty = sdma_v4_4_2_is_queue_selected(adev,
>> instance_id, true);
>>> +           adev->sdma.instance[instance_id].page_guilty =
>>> +                   sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
>>>
>>>     /* Cache the rptr before reset, after the reset,
>>>     * all of the registers will be reset to 0
> 


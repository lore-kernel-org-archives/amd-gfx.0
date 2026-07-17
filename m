Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439C1C4451C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 12:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D523210E468;
	Fri, 17 Jul 2026 12:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZyjwiE0E";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3C510F533
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 12:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1mEQ+osm3tnOJMQZ369Kz16cidkd4iSVB2DXeqgw7kagfPvZ6DG9ErMPjwGXrwN7XKNqjEXDs90JKb0UE1KzuZEIfqwU8nWq+1tJ+mcfTFAAZQtaGmG4zDJT81geQfuZB/RnVXGHs+SBIzDra+DZTFKxU5z3YBy300oEFnZ5/WO5Dh3RUHIvfz029duWuZhEq604kOVgWBz9DX8V50By3/QXf1nkNJAIM8PnpCMIO1PQAYo6AB64VpEpCAVzfHpiY+NTm+byRkAyAMvmOqlq3a/PIv3Xds/I+nkbU/r1UoQPD8ie0ts5FE4y70C3HUbvk3DKooDDEVOA/T5TX/xhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7XND+Nd5sEU/SG8RXh08EzdIwlvNG3py9jdKmQhwVc=;
 b=aqx48/YT3pLczoMoCFllbeZoPHagkGkU+oCDxPgFry17Fv8xkblK/yv1iBTwmXszHzxZ9flEs1gkCz/8NlDSFZz/eHkt9bfyFR5/buDl8lPFWM7N5mVEjEkptIyWH8gZbxW8iOG7IXWGzJlk2XQsVPtBBzexpQX+ILBkJnAD3jbLGrQTHjqPSt7ABSQxFCHXH3hDPJxmHRVts/XYG4iUki+7teJL/XU4TynXTbwmCzHxgucdmLyrkBoKgNOqpyfv5gdPR2+2XinYz4ebGTllB8MVtMXoHrsFDv8sZsnMoKGi3Rna50TyiPI5v8oACo1yd5iedBudpXQpGIdI7KIeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7XND+Nd5sEU/SG8RXh08EzdIwlvNG3py9jdKmQhwVc=;
 b=ZyjwiE0EgzdnoLS7GtY733PbeWDWWrzYGt+amO4oeOpkSbOLrgfPrwoCISwGglEh/mJDZIE/yCfUjeqszCU0dcCJZypVul8pL90nCMkxyxnqAJOBrLFMjAW+KtttmmZ6ADPrnGyj58VGW+34vrY9dNlLy3ZC3bg940tP+2XBpug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::994) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 12:06:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 12:06:08 +0000
Message-ID: <04c9f424-e672-4073-a112-8bd23b55db10@amd.com>
Date: Fri, 17 Jul 2026 14:06:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] drm/amdgpu/gfxhub: Enable retry fault interrupts
 when needed
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <2821958.vuYhMxLoTh@timur-max> <d03ddb99-56fa-4b33-b2a5-61a9af4e4e6d@amd.com>
 <e8giIPlBQ5SK8N3AZK-a1g@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e8giIPlBQ5SK8N3AZK-a1g@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: dbafdf28-e75f-462a-dc5a-08dee3fbc8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|6133799003|4143699003|921020|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: ygolTKFcDff760cxpoI13Iuu9/+4FI+n0T1q6gWlLQZIGADKJTAc6MlLl3LckJ7xbjKYokZ/3iInRYk1VOqB0zbtVZsTlnoTh97ViSsNz+/go8so+BZtg8u5/4EZT6R32cX2htjhkWvhn858bTLYszo+52q4sz7JgAtLIGo+UFN/AfN6lFFDuLLi83+CbMA+CgkCeP/bCECN8UpCwG7i7D1BeXMkOfwGztQ6Cc8YbNILxtGcTNZ8UAWeEW/O3T8e1IEzHpmkiuCVBwhzzWu/PJYVpyXcA85mcfqPrzp2HVJp2GswxmoZK6hdeFyJd+r5/mgU8Aq5foqjVsxEaqrgscznLbWgA2GjI49WqjDYXoz7SjCHvriLyPj9/8RtTrsIEDEhxE5zyLkWEmeAp3SGCMvTQKuqdx4+/CKRcVqPJlJ40fGwEIsBgCjw+ZoogeI/aAEqSX9H3XUFyyp/a4+SO0UElMyahZqtt5wfWhMdjx5gdyGXzGu0mbSKDPtlkdCA7IgcHOA6F5jSV6+ZjKZFX/RLDmmRJhhTgnTnccNXixOnDNIpqns6mspWkkJKdEtcKt61X/NZYQh8WrdWb5Mk5mRRFFYTdUvtbJMZxt+5XdEP9avCu0DZcIKZrctRCbbZRTCUQzTzTBiTGsP9K8y8BdClUth2XsHR0DcMdIr4HH1UxarJAbNkhXl7QoJ7Uii5ip3/Ydr43atGXifnlSf90A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(6133799003)(4143699003)(921020)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lFSUUzWGRYMXZ0VFQ5bGNEeWc1R3JsNVZoMDZaTHRkYkxYUzVSMFJ6aUNL?=
 =?utf-8?B?ajF1Y0xtZTRtQXkzeGpmZmdCdFBBZFRkRkd3QjBVc1ArL3A4eElQUjhtQmR2?=
 =?utf-8?B?bVNvMHBDZFNlQW91bHNjbThndXJlUXAxbzc0cENFUnY5UXFmMGY3NHZ0Znh2?=
 =?utf-8?B?MkptS05XVXZsVUw2UFVMWWZPZWhScWgxRXZJbmdHNllMdW5QR3FrMEdPelV1?=
 =?utf-8?B?VTRHeUNsOE9uaFFMZzI0ZlNxTWZmaGJVWG9MYnpwaXhWWUFiVWVYOEZFQUl2?=
 =?utf-8?B?bERPSjZOU1NGakFGN2V4aStpdXBWTnlVUExjWG5NSXR1LzVqeExtd2JHUzd5?=
 =?utf-8?B?QlpRYUVXakRxNzNFb0ZHYTVHUi94RFVGUUtFNjNPcTkxZmgvWWFrVUZzZEJK?=
 =?utf-8?B?elc2a3dXWGZhcnV1Sk8ydkJHSFV5WUZXUG1VZitEd3BJalRRdTM3YWJtZ1Bv?=
 =?utf-8?B?RXc4c0RGOEh4eFVzciszVkNXWUJNU2JMT3BTSjUrQTZwM0gveXVqR0RZVVMx?=
 =?utf-8?B?R0RjYzdDNnpUejgxNzFjTkllR0xzRUlBeDVhY0JNcjZ3bkU1a1JHY2xQZEk0?=
 =?utf-8?B?cnMrcXZjekJYbzBZMWg1ajQyR2pxeVRvM3ZqOFAvVGhwRExlQ3BGREpyL2NW?=
 =?utf-8?B?ODFCU2hIY2VmeXQ4bWVvRUw4Zkdtc1E0S1ZhcksvSXYrREl3M0ZkUG50eXUx?=
 =?utf-8?B?YTJGazluZUJoTW53a2JJbHREcXBjWkpSSXl5UTJXSnRsU0RqOGtFYzdsaFR5?=
 =?utf-8?B?TjNaclhjQ0Ftd1E2YkV6WGxWaGowTHRiVzAwR1JwM24ySmExaVBtcCt0b2VI?=
 =?utf-8?B?YkUwVnBkQ1JXMkgvR3o2ZFg0QlQ5YU5Icmg4RTBzdDNXSllaSHp4VU81UzMv?=
 =?utf-8?B?a3VvaWdGcmpWc2NCYW5GdldVMmU4YTNiTHY2TCs3VkF6b1ZLYmtQTklxRkli?=
 =?utf-8?B?RHlxbDRsQWR4dVdPbzZSc2V5bWd2c2RMcnNlU0h5SmVDY0ZrUmg0QVdHTitQ?=
 =?utf-8?B?VjJxSWFkZ0JBSXhTc3BMOXZtNUoyaE0wSjM2TUJVL1hEY1VyN2x4cWRUWk5B?=
 =?utf-8?B?WVJSSVpCZWxMNGJQTkVzVlBYWFBxWFlVakhTaHo3Q1dnUlJoTUk5Q3hVMFc3?=
 =?utf-8?B?WEFBUHF4VjFpQlRSQ1ZQbGRObE1WeTJlMDVjcmR6ZFM5SjNGU1VmNU9aT3dI?=
 =?utf-8?B?QVFZU2Rsd2d2YnZpVDAvdkxqOUFQNDJndEdkVGlZbFRPZjYvSlhuOWNxaHlh?=
 =?utf-8?B?aVNZaFRBSUh6Z3FHMWdLSlhVREI5WnphNkhBUjFHS3JVWTZRdHErV3RDTFk1?=
 =?utf-8?B?WTdJdVdGRmlvYWZlVTFYemV1NjhDckdYTHdvbjQxR1RIR2dicEhFSUNLcHAy?=
 =?utf-8?B?bnQ1Y2kxUXFRUHB2M1VSRVkvV2tIZzZoaVBWUjFidC9vN1JGejJQSFNFNnhQ?=
 =?utf-8?B?K2RheWNtRzlxZUhBYjFmaWw0b3kwN1RQdHNuMFA1cmdBL0FlV2d1MnV4V2o2?=
 =?utf-8?B?MnRpMnFLSW14bEVaVk84UTFMeENUQXplR2lDWVJBaEFDdHR6YjNOU3dQNVcw?=
 =?utf-8?B?WW9tUCs1bGtNemhDUXNtbjA2cVIxTEFLVXJqdE1uUENnR2NuanpVUUJQakxZ?=
 =?utf-8?B?Y0ppQ1Z0c3ZkYkdIN1FoM1BFdGZjWjN0ZjRDL3VDendpNk1SN0VZcGF3MjN4?=
 =?utf-8?B?N1JsUHNPVjRqdlpNRTBra2xpT2ZXNWpNc1c1dHVxRU9TcVFETTBqbk9CK2dP?=
 =?utf-8?B?K2xWbFAzUklzYUlsdkVrdGpkRFZzL3BZRnZ1VzgraTJzcU92Vjg5V1FPTE1s?=
 =?utf-8?B?elRyd2xFSVdZZUozWkRLcFNLTkVzZzd3RTk0am1vbnVSWU1mTStFNG9PUExL?=
 =?utf-8?B?cUQvYmwzVzg1ZnIwZjY3bkM2cXViRkVFRWRrcU16K3Y1V0VQeFRYVE5pcGhL?=
 =?utf-8?B?cHlMTFJUVVB4MyttV2V5bXIwQTRvd2s1OUtGempNdUkxUnlLQ3pWWmRYQzhB?=
 =?utf-8?B?RHVsNXlmWEdxSjFyeG1PMGh2K0VwbzR1d21hOFJScWZwcitBaHc4UVhnY0FY?=
 =?utf-8?B?TVlTdVdENmVCNGFWeXF5a1hHUEt4K1diTEFkQ1ZMNDBoN2tROTh0YWswNEhS?=
 =?utf-8?B?V3l2YlI0TklBRW1lVEc2YVB6aVFYTzU0QjJrV2RLbzgwYXd6cTAwQVdKWU5y?=
 =?utf-8?B?SlU2UmZuam96QUtNR25SVmNTeXJVK3h4RjI1V0ZMeEVNNmFVTjlDazQyYkZD?=
 =?utf-8?B?cGk4STQvL3BxanA2a00xd3dlQkVCWXlWcG1YY0Erd1lSdUFmWGtES2dsakVC?=
 =?utf-8?Q?x1hhdzVr5nwfay06vs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbafdf28-e75f-462a-dc5a-08dee3fbc8ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 12:06:08.1784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6Pb78Gb7zhIAG25GrnWKkOFEs2Ibyzpv+G+TEjJ4eawaQIVf5v93HzXB74G+xWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D
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

On 7/16/26 00:51, Timur Kristóf wrote:
> On Thursday, July 2, 2026 2:02:50 PM Central European Summer Time Christian 
> König wrote:
>> On 7/2/26 11:14, Timur Kristóf wrote:
>>> On 2026. július 2., csütörtök 10:10:10 közép-európai nyári idő Christian
>>> König> 
>>> wrote:
>>>> On 7/1/26 18:17, Timur Kristóf wrote:
>>>>> Enable retry fault interrupts when initializing the GFXHUB
>>>>> system aperture registers according to whether retrying
>>>>> page faults is enabled in amdgpu (ie. amdgpu.noretry=0).
>>>>>
>>>>> Needs to be done for each GFXHUB version at once,
>>>>> because none of them actually enabled this interrupt.
>>>>
>>>> Thinking more about it we are clearly missing something here. The retry
>>>> fault interrupt itself should be enabled all the time.
>>>
>>> Why would it be enabled all the time?
>>> I haven't seen any retry faults on neither Navi 3 nor Navi 4 without
>>> enabling the ENABLE_RETRY_FAULT_INTERRUPT bit.
>>
>> As far as I understand it the GCVM_L2_PROTECTION_FAULT_CNTL2 is actually a
>> debug register for the fault behavior of the GC block.
> 
> After our last conversation I tested this again and I can confirm that I do NOT 
> get any retry fault interrupts on Navi 3 if I remove the code that enables 
> this bit. That makes me think this is not enabled by default.
> 
>> According to the register spec for Navi 44 the ENABLE_RETRY_FAULT_INTERRUPT
>> should be default 1 and always be set under normal cricumstances.
> 
> This is definitely not the case on Navi 31 and also on Strix Halo.
> I haven't checked on Navi 4x but judging by the fact that the gfxhub_v12_1 
> code has to enable this bit explicitly, I doubt it would be enabled on Navi 4x 
> either.

My guess is that this is either some bug in the golden register settings or the VBIOS so that isn't correctly initialized by default, or that this bit is controlled by FW to enable/disable the functionality depending on which queue is currently processing.

I need to double check that when I'm back from vacation.

>>>> IIRC only the RETRY_PERMISSION_OR_INVALID_PAGE_FAULT bit in the
>>>> VM_CONTEXT0_CNTL register should be set or cleared by the kernel driver
>>>> or
>>>> firmware to control if the HW retries the access or not.
>>>
>>> That is clearly not the case on GFX12.1 and I haven't seen any indication
>>> that it would be different on GFX11.x and 12.0 either.
>>
>> Mhm, then either the FW or golden register settings for that register is not
>> correct.
>>
>> That we set ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY to one is rather strange as
>> well since we don't use that feature in the Linux driver.
>>
>> My suggestion is to always set the ENABLE_RETRY_FAULT_INTERRUPT in
>> GCVM_L2_PROTECTION_FAULT_CNTL2 no matter what the noretry flag says, but
>> I'm going to ask Alex and our ROCm people about that again when I have
>> time.
> 
> I don't see why we should enable this bit when we don't want to enable retry 
> faults.

Because according to the HW documentation it should always be on and never disabled. I'm pretty sure we shouldn't touch it from the kernel driver.

For now just always set it to one during initialization, if the retry fault interrupt is enabled or not is gated through the bit in the VM_CONTEXT1_CNTL register for the kernel driver.

Regards,
Christian.

> 
> Thanks & best regards,
> Timur
> 
> 
> 
> 


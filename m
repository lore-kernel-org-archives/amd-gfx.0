Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89539C3ABC5
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 08:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 318B710E01F;
	Wed,  7 May 2025 08:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5UgqG3Ti";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 767F610E01F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 08:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkFZADzzhqWK1LBneCb1Ls72YKWOp3FN3A5hwasepUPJktGz+JxTFfDyKyh82eKN532jn22BUQ9BG0l8AACe9CjrVuAA5HOf3pN8H1P7N/nvJFUZQIfZkHZdU7CQi21cpO2csswV2wz7yInVsz/8OMt9HngASt9upNFIJc2mC2F3mmPsJk3jhEk1JNCCyz+mSL7rFsISnPTNAkwTIrZKmHnVeTqj9QriOmtE/7+wlWIgF1tDG3SBxwkH/nu8uVrS23flYAP2C2qu0F2gROMuYOgkaFXQ1iM9a0RRjH3ldGbF4FWja6Blv4e6kqmljBta8lKSvzB2LQBUHGZdR1c2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwDvW58sl+28r3OVMxis00DRza8Y84yj5dOinFs/UKg=;
 b=umb8MN3UsHEvBmSZbnqtY9zgqiOUn9UHVaxSrE2S3rKMMfCuw7YHycObH1ULsriFaABsJ0Qj8sy+fkgMLh0YZoy3KA91BD+/xeERFJVS9yLRygK/GrEZVlEx3BNf90+sx287VWvATb+yAGsk0a8kETogbqhiiEk7y5iqlia8GK4OU15I0XTrBPzal0q5ZR9naTwO3L47eueiV4/1LIW83YaG5ECRkhirLSRXPwpgjdVOKn75iNZkeYx2MZpsPZMdg1967y6tZRBtfjSouIpaN6slrs+/NMBMBGtK9OrNidUQlCZ5WgaqlwG6SqrBiP6ibVV+5/if0D5OByueBBjlWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwDvW58sl+28r3OVMxis00DRza8Y84yj5dOinFs/UKg=;
 b=5UgqG3TiGjnSrghSUFMb1csNJYHstq7NQQkwpVX+A1HopcO64UCz3dcoe5+agWq+1TU3ZawL/uBTEXy2epF1hP7R2w6lAC+h7ttnYQC1YHln+urPAttV/DsrILCg8WSsmiF0/pd14raol3KLkgrrQlZT45hoOwDL+xlKeYrhJsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 08:35:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 7 May 2025
 08:35:49 +0000
Message-ID: <d399c75f-be3d-415c-bd2f-de9ee92751c5@amd.com>
Date: Wed, 7 May 2025 10:35:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250428062853.4057900-1-Prike.Liang@amd.com>
 <20250428062853.4057900-2-Prike.Liang@amd.com>
 <DS7PR12MB6005F7AA06172FDF96E96F59FB832@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB600557F4E08F81716AAD4D69FB89A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <72c1df20-46a5-459b-9c4b-5775a55bbae6@amd.com>
 <DS7PR12MB60059FF6EC19EC5485240D89FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60059FF6EC19EC5485240D89FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:208:530::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e0d91d-68f7-415e-b4c8-08dd8d422b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zjhlbm1HL1BnVEVnTEhnSXJlelpVSk50YnBSczlFL0JSOWQyNnUzczh2aTJW?=
 =?utf-8?B?VFRKV2s2YWxVZWpkeE8rS2hxNzdiWHVCMzJFaklMWkkyZzNsM1J6MmVqK3lo?=
 =?utf-8?B?YlZsWUFoRlNuS3hiMGc2Q2dpeW92VW51emVNbDhuTE0xdGlkR0NtMXZxRmI3?=
 =?utf-8?B?WklNSXluSE53Vld3SGdJdTVJNkIzQ3JucHJpSmJYdXlkeC9vamk4RDhQMkdH?=
 =?utf-8?B?OGVjeEFZY3Z1Ui9PWVA2VGptR0RyYmpwWUl4d3l6dENlTjE3aW5OcW9hYUJU?=
 =?utf-8?B?RlpmemJHbGpIQTBRS3Q0NmJyZWl2VVBxWkVBR0o3K2VjdGRlbVRwVW9XcnNV?=
 =?utf-8?B?d1JKQTRuZmxUcEhqSkFtSnJFS3RNSk02dWhNaG1HSElUS25ZZk9Hdm1BRGc5?=
 =?utf-8?B?bk5mUTN6c2k5SDhlcEh6UitQYSs5QWx4c3BLUWcwRTBxWXdvTHBXVEo5M0RW?=
 =?utf-8?B?bWtDY3E4NUxFT0JXMmNxTXZoUjdTVEM1WmNCajd1ZkNEL21seFluKzNzeHRY?=
 =?utf-8?B?UGhubktkTUN5WmxvMEJJUkw5cHJ2S0NUdm9mMFl3YThZWCswQ3c4RUFwbHlt?=
 =?utf-8?B?THdvbkpMSDUxT1BlSHJmbWNwZERqQUV6U21HOWllcGpXUTNlRm9WaHlvSy96?=
 =?utf-8?B?ZDJIYXF3N01IOW1iczUxeGtWanlJaGVrWjllUmhCbzNFZGxBdjRVUDRENHpG?=
 =?utf-8?B?NFEwbVc4YTlGUEhROWt0R2lGc05CVmowTTBCbGNMU1F5dVFzdmtaWld0aWQv?=
 =?utf-8?B?eXpyWDJMeUV0VnNjQnFZT25jNUFhNERFbFJDUHhsM3ZQRFpyZ3cwbjQ2L09m?=
 =?utf-8?B?OE4rNmNLZzNFK0JkancwTVl4T054V2ZKTUtUUFNqWGFuV1RwQi94cTVPWGFV?=
 =?utf-8?B?S2F2ckNuaU15cEY2bmovMkFCWFlmTFgvN05Oa1ErQXRlZ3hMd1JQcXlYemZO?=
 =?utf-8?B?WXhwQjRVVlAra2dlQjBwRjdBUHgxN3ZhT3Y3RDYxTy9vQWI2RnNUNTNwU2ZQ?=
 =?utf-8?B?ZldGRk9kOGJYeVFQNXY0ajFYKzlMVW5pdG1xdXByN0xuc3R1L2x6dlJ6bEhy?=
 =?utf-8?B?aUpZU2dwdlY4YmJnR094dU5DWVp1WmFZeHdtZ29ZZGFJUkhFbjF4V3krc2ZM?=
 =?utf-8?B?Vnp2SkI5MEgzR1dpWlVlVy9DSnlaTFBTQ3p2QXB0S0JmY2JXOEd5bDloTlNM?=
 =?utf-8?B?ZFBlVTJxZ3QwSDl0VVRnNlF5ZHJPY21PdUhOb1kwNGYvU202bmpzbG9kOW5y?=
 =?utf-8?B?OWlEdVoxNHpiL29vY0RrSk4ycnM5NVE4RHgzbndPQ1NuRk03Z1o5OEJWS1Jm?=
 =?utf-8?B?bi8veUF2SGJDNW1aMlc1RFN0TVNnOFdyVTVUUDc5UDlvWEx0NWFraUtEb3ln?=
 =?utf-8?B?aVJLNXg3MytjTWUyWWRxM281MHZQK2NRbEpuSVVTai9kSVFKdkxrS3kwdVd0?=
 =?utf-8?B?bkc3SE1CYTN1K1UvbFR4RnBNZUtnZDRIZ2dzamY0MkFzRXdsbnBQZlRlR2Ez?=
 =?utf-8?B?eVNqcGVlRWdJTkZVREtaeVdDaXk5LzJCekpJOUdFS2dDV1h5UmZqS0JOMDYx?=
 =?utf-8?B?czRra1p1dkZVandRYkRxOEtnSXdXR1Y1OHl1NWVtM0l4QU82MjA4bGNqdFp4?=
 =?utf-8?B?alNZU2J5bVBXbVRSVUkyL0xoS3U3elVybTl4MjczQ2hUY1BkQVdkaTlHTkhu?=
 =?utf-8?B?QVJqZmxrYkJRODMwSGR1K0xIdkhON0lQKzBTcTZNZDQ5SlFhSDRQVERZLy84?=
 =?utf-8?B?WUVsdkFpdmFJc1hJcVZhY1pNNE5Xa0xMY0lUYUxkZHhITzgvVUVBVmtYZ0NE?=
 =?utf-8?Q?6hOB84kle5Jo0YYPhLlhb4o/mO4hxAqUIJAEA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0Y3bUNhbFFXVjN2a0NnREtxZkxxaW1odXI3N3lPOWRoN1BvMFkzYXZBYi9h?=
 =?utf-8?B?N3FuU3gwd21KS3Q5aTNkc1k3VUdSMEt5Ykx1L1hpQXFjWUlnYjJkMkRPYTFO?=
 =?utf-8?B?NU5FVXBzNHdUbXZ6aHRrN2t3NWw5VCsyNVRtZ2JkZHFGKzZ0ZTNwQ0hHTEls?=
 =?utf-8?B?czBCdm1MeWdTZFJyUGQ3dDdGdEZYbCtuUmFYUTRDU3l1SzhZL3lnelNtS0Zq?=
 =?utf-8?B?N2sxbUZoZmF0OEtQd0RDUHdoSVBnNnpOY2NOd0JJQkYycGx6ZngyUHQrbjd3?=
 =?utf-8?B?NSt3KytOKzhZbFRiM0NYUEVCWEFDQnBZcXpQZytVRmFhUFVyWFU0L3pIMVNZ?=
 =?utf-8?B?emZlWnVWcnBTMXJtaUlsVDVpc1hpL3dmcjREZDZRN2w2V1FrcFVpMUlwUG5q?=
 =?utf-8?B?REJ3YW5Zc1RBQnllenlCRStVS0ErVWpDaVdSRDd6MmxmQmF2bGk0ZVJ1L2dq?=
 =?utf-8?B?S1ZJNUtJVHpIVGdneWovOG1TQTVMOXlNNGFZeU1YNERVemdSc2poSWZPdE5H?=
 =?utf-8?B?ZlVYWFVsWThLaVdZVDhJamlUb3g3bURqdFFiMm1SR3BUWFByWXJVQi8wbDBm?=
 =?utf-8?B?L0tFVXpLaktmV3NJT09ya1I2K1dxTVprMVlOM3ZyRUcrV2NVUEdhblBodzJk?=
 =?utf-8?B?ZUYxbjNpUGVoOCtiMDl6dWZ0NENTdk1WenB0SGMyclZIS1NoUWh2WWZPTVQx?=
 =?utf-8?B?WEpSS2d0cVVVbUpTaUc4OEFTeWkrSTBjZlpGWXZnS2JaeUROajdZbytIVjdU?=
 =?utf-8?B?bFNKT0ovMnhoeGpETnlSMVFZbFBCcVp5cUNoamFCa2Rwb2xqZTlBbTBxYkk3?=
 =?utf-8?B?akdTVitNVVJmNGxPaXZlYnFCRHFkUVM1ZmswVzI3VUlKd0d5WklJTGhWQjJl?=
 =?utf-8?B?aTBEeFdGSU84R2pac2kyaG54V0xBT21WZVVPUG54bFB5ZEtpNmh1d0NuM3pw?=
 =?utf-8?B?dVNoekZ1dzFUa3pHTXdYd0ZTRmRmQWZQQXRKbVZLTlhhVm1Sb0JNY1NiZzF2?=
 =?utf-8?B?b0Vka3hzRk1teXFCbCtTVFZiSFhHWUxXY2h5TVBuWHFNL1oveUhzUlowUkRQ?=
 =?utf-8?B?R1JwN1BFRHRZL1M3TlZXS2M2QUhmeXczVHFRWmlKKzFhd3lPSTBLeDVKWVFJ?=
 =?utf-8?B?STFCeThNTDVzWitzQWhoZ00zWDhhUGdzSFlwMXpIL3pPNVZYNE4vMVpNRDJ3?=
 =?utf-8?B?czRoY3pNSWdYNFFFVVdES3UyRWsremFOQ25DMklsdk0wVHZOclFHdGoyK016?=
 =?utf-8?B?ZXNrTDJGSnR0MUE0SnNqenp0M3orMk1oem5sYzQxNDQzV09PQ1k0c29RQXRr?=
 =?utf-8?B?blQ5elY0SVRTR2tNNG5UL1dZclZ4NzJ0QVJidUxYcjl5STE4WFhNbjBmMm5n?=
 =?utf-8?B?NTFvaE1sN2hUa254UHptaWVWamZnNU84NSt6MXBsbkpXdTB1Mk81ZThka05h?=
 =?utf-8?B?Y3p5eGdaL0JxNWlDZ3ZmT25WU0V5T3MrcmloOTdPTTNEUE5SY3dLUklBOXpj?=
 =?utf-8?B?TlpPQ3p2bWEydStBci96TVQ5VDRLZWJTVnpEakNyVWROQlZyd2tybmV1QUdu?=
 =?utf-8?B?QzIvZnpWRFAySzlUL0pWNXNIalJZN3EvZTZEK0U4OVMvakJrNWFET29tQTJN?=
 =?utf-8?B?UFFJNUw3TWxrckt1RFRSdmhWVDlQN1h0WjlvOHQvdkR5Q0lyenoyblF5RFVj?=
 =?utf-8?B?dkZZVDdtbzNTVEYzYzlJaWlSV0NTUWJock01RGFTTStGWEtpblNFVUdZeVNk?=
 =?utf-8?B?Q1cydzBzMjF2MXlnRTByOXlIVlJSdWh4YXlxeWlXQUtVSXZaRTI2WldsL3pa?=
 =?utf-8?B?QWp6bHdsMllWUDV5UkptYzdrU2Q1L3A1M2JBS0NZZm9nZ05XUTBVaGpLcnZX?=
 =?utf-8?B?YitsY1NrY2FIRXJJVGZkM0ZZbVFYNVA1WXlrMEY5K25vQkQvV08rYm9SYllk?=
 =?utf-8?B?cUw1U2VuRXdIZ2MybFJLNTRJMTA0aGVXbGRrUWZhSUhVbDM1MVREdWlLdS9Y?=
 =?utf-8?B?VlBpbVdiMXV1VE9YSDB4K21TUmY0Z3BMQXBueVAxaVU0Rkh1R1V1ZC9WL0RQ?=
 =?utf-8?B?T3hHZ1hQdndqQ1NMNUVlUjhTRlVQb3ZvTWpGaGhyU2szM21JdzVDWmpyRDht?=
 =?utf-8?Q?eJJx4+5DTIxPteTsL0nIjM22d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e0d91d-68f7-415e-b4c8-08dd8d422b52
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 08:35:49.2163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+07Xdcir1ErZhL9zkGkt8ZHcRxVJhkx3jfMfqwGQWKPkpZqs6fOKeIqZw2E42IC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457
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

On 5/7/25 09:05, Liang, Prike wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, May 6, 2025 10:09 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
>>
>> On 5/6/25 15:34, Liang, Prike wrote:
>>> [Public]
>>>
>>> Any feedback?
>>
>>
>> Sorry totally missed that. We already have a trace point for all page table updates.
>>
>> If you want to only see the PRT updates you can potentially enable that as a filter.
>>
>> I can try to come up with the necessary commands for that if you want.
> Yes, we can check the PRT mappings by checking the trace point at amdgpu_vm_set_ptes() or amdgpu_vm_update_ptes(), but it requires further parsing the PTE flag and PTE update owner.
> Anyway, it's ok to confirm the user queue PRT mapping by checking the trace point, and I will drop the patch sets.

The trace points have build in filter functionality and you can also use the RMV tool to visualize what is going on in the address space: https://gpuopen.com/rmv/

Regards,
Christian.

> 
> Thanks,
> Prike
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>       Prike
>>>
>>>> -----Original Message-----
>>>> From: Liang, Prike
>>>> Sent: Wednesday, April 30, 2025 10:51 AM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>
>>>> Subject: RE: [PATCH 2/2] drm/amdgpu: log the user queue object PRT
>>>> mapping
>>>>
>>>> Soft ping for this series.
>>>>
>>>> Regards,
>>>>       Prike
>>>>
>>>>> -----Original Message-----
>>>>> From: Liang, Prike <Prike.Liang@amd.com>
>>>>> Sent: Monday, April 28, 2025 2:29 PM
>>>>> To: amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
>>>>> Christian <Christian.Koenig@amd.com>; Liang, Prike
>>>>> <Prike.Liang@amd.com>
>>>>> Subject: [PATCH 2/2] drm/amdgpu: log the user queue object PRT
>>>>> mapping
>>>>>
>>>>> This patch will log the user queue buffer PRT mapping, and this will
>>>>> help on checking the user queue PRT functional status.
>>>>>
>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> index 30022123b0bf..7992a97f8745 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> @@ -903,6 +903,10 @@ int amdgpu_vm_ptes_update(struct
>>>>> amdgpu_vm_update_params *params,
>>>>>                                                 upd_flags,
>>>>>                                                 vm->task_info ?
>>>>> vm->task_info-
>>>>>> tgid : 0,
>>>>>
>>>>> vm->immediate.fence_context);
>>>>> +                   if (upd_flags | AMDGPU_PTE_PRT_FLAG(adev)) {
>>>>> +                           if (params->vm->is_userq_context)
>>>>> +                                   dev_dbg_ratelimited(adev->dev,
>>>>> + "The kgd
>>>>> user queue PRT map is functional\n");
>>>>> +                   }
>>>>>                     amdgpu_vm_pte_update_flags(params,
>>>>> to_amdgpu_bo_vm(pt),
>>>>>                                                cursor.level, pe_start, dst,
>>>>>                                                nptes, incr,
>>>>> upd_flags);
>>>>> --
>>>>> 2.34.1
>>>
> 


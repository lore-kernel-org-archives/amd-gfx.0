Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6A7C3ABBF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 14:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491E810E34E;
	Tue,  6 May 2025 14:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tFzDp+d3";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE11710E34E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 14:09:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/N9pJlk137uG5W4+4IeyJ7e0SFLCQKjN0H24BJ2Zy00gnp0z8lTWhN320nujA4T+2KXhVltMERhq0wayNhYXFhapMkfEP+2QJsGtCwhhlRk5pz5b4vDPH/wpsd8Ppvq13SvkGObnBFkMN/4rK+lZD+abMMaiaSIGoeFYiwMdfuGda1TfWm/s/R9+XmbH/xCHv8M5toPFX8nUnvDQLO8tOsXVqThZLs+m6v6fNpcxYji8J19XoWRXK49PiGSyXkkTrPoI4z6Mq993VlIvgkjf2rB5UF99csNDaMGigH5UJsVW0u6wr5wtRZqFZwT51j9JJgffN/3VlGmiKo0oFgsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2bGD5myJs9l+t3BECBfIXiV+hVqUrhw3fNjmQvDqUQ=;
 b=A74q6RXcGXlN8ej1SUW+IxFdTrQxGwp5+6eE97tmv9ixOkaNStwb2n7Qung4fAonY12fG+DSmDL6C3fNHd6MPY0PkDARAATYgbeDjjaWbOondPwAzo/xEZKqzuDVjDBWVTl0fvXfo7+sHXZmqvb4lY+34LDdx7ida61fV8ueTxp747aSi2LsRLQYsigri5DCjiXUsu+R7gmKPaj53Lvk0wltmfmJdcZRUj506kG2TqfSaF0fIxkFGJdv39fpgpScdtUGAhSiirDDKixCmqIpwP2pTLQJwWgNQntUIxLw4i6F3UbTZTPXgVTdFini/kLTaYc/Uk7DAF05yXcIpX8xaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2bGD5myJs9l+t3BECBfIXiV+hVqUrhw3fNjmQvDqUQ=;
 b=tFzDp+d3M92GHkMtUIHo7l++RTShPwwA5rNbjJcdzf9haCg15HNWUnWCtkAGJlnjI+4oF69GcvWqSVH5Nwruu5gR/4OgxVtnTxMilq7ncROTDXaXQ7Mi1N5fxBwRypKRbfB99sRBRN478jj5IxAp3r6SWybnYDTFNZyQDrxJEU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 14:09:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 14:09:16 +0000
Message-ID: <72c1df20-46a5-459b-9c4b-5775a55bbae6@amd.com>
Date: Tue, 6 May 2025 16:09:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250428062853.4057900-1-Prike.Liang@amd.com>
 <20250428062853.4057900-2-Prike.Liang@amd.com>
 <DS7PR12MB6005F7AA06172FDF96E96F59FB832@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB600557F4E08F81716AAD4D69FB89A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB600557F4E08F81716AAD4D69FB89A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:208:236::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 53be6023-fa7e-4a86-e3b6-08dd8ca7964a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejA1aVlNUU80Q2FKSHBIUHIyemVLOUgzS0NuSnNZdFB3SmhKU092OUVaWWFx?=
 =?utf-8?B?VzlabG5OUnhDalJDTEhaY1BiVzRaMzc2OFhHaFdqRytMeDN3RUR0T0JGMlJM?=
 =?utf-8?B?QVVQSEhTVWpOeDJack45NGQ4cnV0aUZnaEYvSFdyQ1FCaGNiSzRXWkwwenZi?=
 =?utf-8?B?NWw3OW13Sm1zMWhhU2VuTkpxanQyRW9wYzdZQ2JGN3F1cCtWajk4c096RnpH?=
 =?utf-8?B?V3ZHeHZCYWFMb3o4R3RGSVcrN1ZYdEFqaDQxWVBIWU9oRnpQRGFFaWpIUWtV?=
 =?utf-8?B?WmZuUWhwNDZ3Uk9nckFheXNKanMwdkN6bmVSVXAwRXZKWHhZUFROWkdXbmRq?=
 =?utf-8?B?RjlVQ0N6UzNraFA2WDMyckFqeW5HVWxxbWVCRFNxUisvSk5zUTNFMnRiTGNm?=
 =?utf-8?B?ZXcxZldCU2dYdDRoL2xCcDgyR2RVamdmK3B0UEwyaUFWUmtmQjRRUUxlVm5R?=
 =?utf-8?B?VmxYanZ5YVNmZUJKM2ZGUWx4ZkVEK0s3YXFTOHFTcWV4L0YvUDFyQW81NzNi?=
 =?utf-8?B?NFhhOXkrZHJ5aXdiMlp2NnlNQ21CVU9Da2dYa092dUtjZG9WS0M1YWhaUnd5?=
 =?utf-8?B?aTNPaHZRU1cyYUpEWEtnS0I1ZjBlUFZPcFltTzZRdDFnSHM1TStaOTNyOEpx?=
 =?utf-8?B?U0ZHWGZzRTNwVE9Day9EYjNqUEFOdXJqVkJPa0pWajEyL2J3MW5tRFNSQVhz?=
 =?utf-8?B?R3FLNXc0cmJrbUdwZTBZQ1kvOS9DL0lBK0Q3V2tVaFYyZERyMWJUUFpGZjZK?=
 =?utf-8?B?ZlArN3FqZ2s3SUVIdXpmLzFrZDRJcHc4SHFjUHVVUWpMRHc4eGFUZ1pkZ0RO?=
 =?utf-8?B?VGVHbWplZlpvZzU5ckU1aWJRUHhQV0xPQTFBUDVJbU9wNFQra3ZYL2JPcEFQ?=
 =?utf-8?B?VkZGSGJoczJVb2ZvVURRVllXQ0tlS0V1UkM3cTVzK1V0WFhhYjd5SEQyQWd0?=
 =?utf-8?B?NGFldVB0ZGhPaE1qMENQaEsyMUVTblNweVVKSzFtNmQ4Ly9JTzZhcjl3Y0dI?=
 =?utf-8?B?dC9BZ3ZWVUFvZ1NrZUR6ZklZRVBEcUpTdGtXK2hDMERoNzRSVXlDUTFXNGhm?=
 =?utf-8?B?NnZXZW9oSmo3TFBycXEzckxRUS9ZZVNaN2RUd1diM3pRSUNJVHJQcTVsOWVC?=
 =?utf-8?B?c2Z2MG5TS3J3ZENjdDdYZnQxbzA3bWt5QnFCTm1oRC8rbnpiUDdyVzF4V3FE?=
 =?utf-8?B?a0xDTUpOVjlhY2ZMd3JBajIvZlJlRTl2Y1E5R1ZpdXE2RnNzRlNMOXREWXZ2?=
 =?utf-8?B?TU8vRGVQcDdlVGVzUHVpRTUyM3NMRUtzR0UvUW5LTTZRZnpEakw1djUxYmZI?=
 =?utf-8?B?bEx2bFFrN3BDNjJ6TytrcGgvUVRCb3g1M2NhNTdKMlBtVEpMU0ttNmJUdWVy?=
 =?utf-8?B?ZmpuaTN2VFZSMjRwR0w4QVlBZXNTNUVna3EvTWxNTzIwTEE0Y1BhQ2tjME1Y?=
 =?utf-8?B?Rk9ielVSdXRhVVlRUVVZTG1tWmtLNzNvOHhOUHhkTVFTSnh1eUs5VGlRd3J3?=
 =?utf-8?B?QTMyZWhFaTQ0VGtuclduNG0rRjJnbVI2WXUvUFRHUVhqdFJaMktob2c3V3BO?=
 =?utf-8?B?UHk5djE3NXFmeGhtT251Y0drZU9SN1h1MWZNdDZqOXFrbm5lc2t5MVl1ZW1w?=
 =?utf-8?B?R3BNN05uSWpFbkdJK0JabW1vVmlIcHNMbndVQXM1elBlbUU2WlJxUVFwZjJo?=
 =?utf-8?B?Nlk4VDVKOXNQNEc0KzNaNk8za050dTFEdkRGN2N2UE5mMklYOTJDRzF2VFQ5?=
 =?utf-8?B?QjJPZy9JZHlGL3FmTHEycjY3WTh3eWIvaWprMHRUbkZNM3N6NTN1bDdKVEcz?=
 =?utf-8?B?N3cyU1E2cXE5SmRlbEMwZi9ZNEtMN3FLMjVha2RoL3NlQllyaU1EMVBmQnNj?=
 =?utf-8?B?WG0rei8wVnZUUG8yV3d3VUhsYzJaWm9JYkdtTGI5eThQbzl4STNFblRIQjFl?=
 =?utf-8?Q?uq0nT/sYVXU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDRQZ2FlOGZ1UlVvdFA3RncyVVBvUDRCSWFZWTJaQ2FFV0c3V3ZMcWxaOTNP?=
 =?utf-8?B?RUxwcUY5S0xERVROUGtqRUhPMFF3OWhJM1pKaWhNei8vaklmUEpkdEVFSmcz?=
 =?utf-8?B?UGJGeWpZWWlZSzVZNG5PbW5tcG92ak80L1BMdFFoMEZyemFsSE9panp3Y21w?=
 =?utf-8?B?dkMwMGRFOTVRNTZHQng0TFZVcHdtaGNZSkpKck5seWtzSGhNTmJJV0dyaEtv?=
 =?utf-8?B?RVRYZ1ZVYk9Id3J5MThjQmZ3R1FGNmhhaExvNmgrMHM2SE1KM1BtaTdROFYx?=
 =?utf-8?B?aDN3dUNtWFVaK1llZE9CYnZSYlNhcEd5UVhXS213bXBTaGpkblA1dHRwOEJh?=
 =?utf-8?B?c29HbWxiYjFRRWJpNE05cGpVTTV6STZ3a24zK040SGwwTWkzRHpJcDZwaDR6?=
 =?utf-8?B?YkJjWHVuYmRMWVJ1WHl5UmpDOEYxcUVkQjZvSEtRZHBWT0lqcHo5cUV6Tkhw?=
 =?utf-8?B?MURodzlwS0NKWkdqeG41M2s5elNYTmZMV0FTaVZYaTJXajRXNHkzZlo1NENQ?=
 =?utf-8?B?bHc3bi9xYlJPQ1JDd0xNYU5jM1NoQmJKRzdjNW9vWjh2RGNqREFUcWhRNFVV?=
 =?utf-8?B?d0JrUXZEZlZxV3QwdDBDS0VlUS9GQ2pZVUpQaEZWZUVFV1JCY0EvY0hwd2xU?=
 =?utf-8?B?T012SlJIZkorN1R6c3NnYk5tMHNJZlZPOE5ZWmZwWVowQ29MOU5CWGJsN0NU?=
 =?utf-8?B?UWRndENubWpaclJxN3E1eUhQeTJOQ3BIS1haRXdKenoyYk52UTNib0Rwc3Z1?=
 =?utf-8?B?TXM3NEtsNWVCZW9nYnlGazF0a2xuRDNjNktQeW9pS21lZXhFR05FOGsrZko2?=
 =?utf-8?B?R0FYTkc5cUxlK3M3M0xoVCtOV005d3ZOblF2WlludkN6VWhlVEJla09hdzQ5?=
 =?utf-8?B?SDFEM1BrTVI3OUhJVVM2NzFmOEdkRWxvUVdvYllBRVVGK0R3U2xxemRtZlcx?=
 =?utf-8?B?Z3ZjSXhnREE4VkswWi8vT0c2REJZWTJyVTJHb1ZqNDNrZzRyWUliMHlUSWFm?=
 =?utf-8?B?YVhQNk1oT2M2ejdrdkFOZ1EwWCtMekRnNFUvOWRUZnM2LzJJNXZRdTh1cGtG?=
 =?utf-8?B?cWdGUGF1dUswZDhQdXVDYmphQzZkcjNWOXdoakpndzA1SFgvQVdENTJReFpU?=
 =?utf-8?B?UmlRTjkyNmZORk95d2VjbnVJRGt6em1td3o2MjdvNG1lVjNqSlh0dm1EcWZu?=
 =?utf-8?B?cGtHZWYrbXJvVjVleEdjaytNaWlmR1NGdXVxQW1VaHI3dlEySzhKaExWWXFE?=
 =?utf-8?B?czFCQVpxU3BRRzdCVFNrMTE1VHlJck1PUGplcTRHcUZyYkpwNnFtN1JZVU5B?=
 =?utf-8?B?VUNoaUthZThXM3k3cU9GOWl0cmpndGs5dmxkU3E0dTFtc2crdTdYUmVSRHpZ?=
 =?utf-8?B?LzNzTGxQSms4amprQXBYSTZGZjlWWnNBRU9VaUtmcWpqd3ZVNm1QazR5YTdq?=
 =?utf-8?B?SXhzS3JuTHZiZzJqVVFKQnA3cXFPaU5pUnlzUGtWdVdKWjJ3NTIzRWl4Ykxn?=
 =?utf-8?B?TjhhOWRrQXk4cFJkYnJPak9idWh1WEpsYVZDSWxobFNuc1EvSUFCVWVVbGhY?=
 =?utf-8?B?RzNrUWNZc0hZNitOVm9Edy9XYWpob2MvL2tOSGZwQTFDTmUrMDUycjJOSjNB?=
 =?utf-8?B?OS8xMm5nSU80NFNCUVdRTHU5ZVlhRlRQcVlyTkxZZ1dOWUJiTlB2VFNLdzBT?=
 =?utf-8?B?ZTZjaXFQY01GYVlKTzl2dmpLZ2FobklKWUlUY09WN0JuNzJybGZWV2dMV0tN?=
 =?utf-8?B?WDUrMHFWQSsyNGRocE0yMVBRZGE4K3BiNjN6NnFnUHpnZnZnU1BEMXNIaFRp?=
 =?utf-8?B?RmJXZjY4QnpsdkptaTRHZWFTZVpzKzZ4eWRjQWhGS1B2ei9TaHhQaFNqSU9D?=
 =?utf-8?B?a2RpbElCWkpnSmorV0FPVHo0YkttM1UxYzJTRlBtUUVzTmZTVFh4UW56b3hV?=
 =?utf-8?B?NENmS0FEOHVnQlR1bEZQcFhzcnZodHIvaTE3dnZFN2lpSDUwQ2xtT1dXcVlw?=
 =?utf-8?B?bG4rSzZnTzhGMXY5M284OUdDMk5QaEtERFh0Z05SZzF5RlhHNmxvMklyNC8x?=
 =?utf-8?B?NllUNUQrSFBDaUJqWmF3S1FkazRXWFBaTEh4RlZhMTZwOUZ2TWJtMEJIWFI2?=
 =?utf-8?Q?MTG94Cbbv+djK2xauvJgE/sA5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53be6023-fa7e-4a86-e3b6-08dd8ca7964a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:09:16.7654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/jFCZBfvvpB3al7J+/bEMfmnz6BBSIz37JagvPZnhwkGQqHx1+6y/eIeHQ0b2zW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744
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

On 5/6/25 15:34, Liang, Prike wrote:
> [Public]
> 
> Any feedback?


Sorry totally missed that. We already have a trace point for all page table updates.

If you want to only see the PRT updates you can potentially enable that as a filter.

I can try to come up with the necessary commands for that if you want.

Regards,
Christian.

> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Liang, Prike
>> Sent: Wednesday, April 30, 2025 10:51 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: RE: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
>>
>> Soft ping for this series.
>>
>> Regards,
>>       Prike
>>
>>> -----Original Message-----
>>> From: Liang, Prike <Prike.Liang@amd.com>
>>> Sent: Monday, April 28, 2025 2:29 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
>>> Subject: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
>>>
>>> This patch will log the user queue buffer PRT mapping, and this will
>>> help on checking the user queue PRT functional status.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index 30022123b0bf..7992a97f8745 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -903,6 +903,10 @@ int amdgpu_vm_ptes_update(struct
>>> amdgpu_vm_update_params *params,
>>>                                                 upd_flags,
>>>                                                 vm->task_info ? vm->task_info-
>>>> tgid : 0,
>>>                                                 vm->immediate.fence_context);
>>> +                   if (upd_flags | AMDGPU_PTE_PRT_FLAG(adev)) {
>>> +                           if (params->vm->is_userq_context)
>>> +                                   dev_dbg_ratelimited(adev->dev, "The kgd
>>> user queue PRT map is functional\n");
>>> +                   }
>>>                     amdgpu_vm_pte_update_flags(params,
>>> to_amdgpu_bo_vm(pt),
>>>                                                cursor.level, pe_start, dst,
>>>                                                nptes, incr, upd_flags);
>>> --
>>> 2.34.1
> 


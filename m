Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9B5EC01A4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 08:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD7910E42E;
	Mon, 23 Mar 2026 08:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TQJ72WqM";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A2E10E42E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 08:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSHY7zWiKzhGQpT8bxCT0TeU2rSKl6JaJxSwUJ2wU/9UFRh9KcuS/RRSD/knwnA/OpMw/U/ilaH67xZZfC8gu97608pYxtzxu7VrvsJXOMH5CdW5LLC7PPR3ezpgSIaYV6nuvkEHPpX2B3VfhE3t5CIh2ZkaeogN9kFRnmS4Dii3KMuvqCoJ688INaEJuq9RkMtz3vyaXrvJoTp+tTeGt8VydFbg/AAuVD63HRxCc6GDrScsvY2Ul/Y3wMrIC+sPe8I4YTCEB369J53LDuR86wp0+LoKJV60hxkPuZ33anbJREJnVwFAsoOjdVNoMpFpdiFMrbvL7UzQ7nhal8B+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYwnl89t4SVI3eroDngF7q3+i0iRJKBipY5bAQckvzI=;
 b=VlBxuaVEkXPbXLq72YVnBbFFaruLA5JUqr4aRxhJX71QZ+UNXZBfIEEmwqrXz12lf8k11aT5wyA0dj5QoFhTN40dHF7h7Femvc4xfan3bQm1wFiPFeW6rxAbikOe08Qfw1vch8uPreHHp5bRwQmXl4s6HTiy/PEeOANLljq2UlFqXwg1xR+yDr76QRglmXQV8Rjq9/Euhc+wYhYf25ZnCCjnE8bo2x6JBVT9Vrmq0BUw9msUc8iIxOCQ7wH5wiIz62G8TSKmpu+tPANHPO6faUZHepxjIHmvZVy5NS2AxylnqVrh/lhNXYOW1w5EDvCnErwPO1gr607Ryi9GM6IJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYwnl89t4SVI3eroDngF7q3+i0iRJKBipY5bAQckvzI=;
 b=TQJ72WqMRmTzPyeN+1aWQ2CGhXKAN4gXmGR4zV6qQUjmY5cOvSzjEHDwwNRlr3pJIx6PkUHZ2rpjV1/E8KdqR1w3H46sYx9AhzWBPdNRo8y8AD/iyf0hbvbwBPN2xFMKCmB9mGO7PvYO1YdvsI+K7I1apcRZkyh+1zkzhEN2JOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 08:43:01 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 08:43:00 +0000
Message-ID: <2449d96b-2235-4a3c-bd04-2173b01b1e78@amd.com>
Date: Mon, 23 Mar 2026 14:12:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: guard atom_context in devcoredump VBIOS
 dump
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260323065621.554621-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260323065621.554621-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::31) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 631f4477-e867-4900-458c-08de88b83083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: PkLan7fCrotbNfIjWIByBqs1jRjoewtE8aJcqxuV2pnFrpZVUipjrSdHv2vhwOvxy1PoTzPkaUcYe87hZDmpEMDF3kWU1Akeu/K/qFj+jUZ43/87TmY+6KUgicxDNmnWTMMJ/i/2VvMVs0TqQQoX8MyB8U/hKN8kGHkoG0DWBr9FjzxUZ05qNKQOE1+i/nR34a+jdqZsYmdiRcBP5nxkc2a0RrEGlFKkHfQkM0Jl+gu0XBaI+80vCZ7hEje+3w8EUufQix37bV5Kh+C+DaXr0sBYyHwqFPYREPqEmSivJuk+DLmiUKLuC4ucDs+zRZt5S5H6xUALEMD2nYd+ioCh09ktQgrAiL9KyfE2nI/nE0ORPAp3JPezmiwdIhAXIbCbDOof9i5YBP75797/ZYhblpQzkminr57KbsZsdgvoJRRDcBp+ovzWXLDDOXNAPxW09i7nAlZLyrE2jo/GxnvpTpxBAVhSvNKHXBOBLhR7fnkYPnRN8nA55gi3tvJRKW/gT/8XfCrws82fH60PtMsxT/Urj62k+1l9bzeSuYRVkt+elaM3njYrjMrhtK6Fxhv5F7dHGg/FQEC3FQQwgj4vgzxElOUfuFr+w+t4il1gAZKG+hDe5JR0F+MikBIBTRK7CPWiLKoRfGIn7zZ58hwXSth78oQUKMgfntVThXRUAeAGdO1Hb2df05LLIUZ7JnRmaLY8mg5YcwEwdh21GUCgm27CyPusznmAlKRSvEhuozk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmozRHhZK1YrK3o1dzNzMkppTk51LzVZS2pVZWdXU1A2TEdyLzFhYUorM1Fl?=
 =?utf-8?B?YVNxdzZDdXhEU0tuMWVMa2xUUEFHZ3d5TFR5T3RGdmVGanVOTHJtVzNuNDlV?=
 =?utf-8?B?NkQ2Y1laYjViVVFsQkVsT3M4cUVteElCTVB1cklBQU95ZVlkdXA1S2ZtNXVW?=
 =?utf-8?B?QlNVck9BUElYZ3Z5cDVVN1JXV0prOU1lQ0F6enVLUDdYekRINlJDb3dlYXpN?=
 =?utf-8?B?a3l4TGpzb1BWckRvRTJER1d1QTdqbzlUa3RXdmZXMWFKWnprbFQ3UCtHL0NG?=
 =?utf-8?B?eWpleHY4bmxLaDNHeERlZnBHZnVzQkQ2TEk1TlRaTTFvdi9lZHA0c3RUbXJx?=
 =?utf-8?B?bSt4dnM1b1ZmNWx0SDN6Q2JwdFVjNEM1TWJmNGF0amVBRjdndmtmNlZ2ZVVs?=
 =?utf-8?B?NC91b0dsZjFneHZjSDVFVFE4QUxnZ2tjcFNnODFSWlVYelF0b2E2MzJiTXU5?=
 =?utf-8?B?a0NxS3RWSUlrN0NUdFZKSGlVcTBlamxvOEdzZnZ6bG1XLy94MGZzRnF5bDlp?=
 =?utf-8?B?UEdFenFTMG5kTWtHV0h3MVdWYXltM2NJTXZsbi9MRXhQL2xSU3NLMTdTdHIz?=
 =?utf-8?B?dmJ5bWVEL0c3TFliNGRoZmNsS3QzODJ0UHRpSnJZOGlteWo4UWt0RUZCc1lo?=
 =?utf-8?B?b2QyYk1ESmJuT2h3aTlyQXRhVURISXMyWUd2MjdGRjJUQ0N4dlFCbFgyNm9F?=
 =?utf-8?B?RXQ2K0YvMDl1L2x0cERCNlZjRXhJbXVKSGY0U1RTUVQrYk4rbDZLeCtBYTI3?=
 =?utf-8?B?bWZ6RmJxZyt1SG03MmhGMFhTRldyYlJzT2dmeU9QVHVkNERIS2MwT29QdlVn?=
 =?utf-8?B?U2Zwc2ZyQnBsS2ROY1lkR2ZmNUpoUloyNHJHQjFUaWp2R3lURC9NQ0MzejNU?=
 =?utf-8?B?VHRpeTdqSkF5YVZxU3EvK1J3em01OUIwdmFGODVKYWlkS0FMUUdNVzdUSHlo?=
 =?utf-8?B?S1ZjdzBNN2dmWG9YVm1YVC8wSnlGVUl6Q3VYdng2ZU1ndGNEd3QxSE5WVno1?=
 =?utf-8?B?eSt0MldrczN1UUJBWmpLQkFZbGVITUY0ckxGcW9FVlRia1hjZ3NFazF6STIv?=
 =?utf-8?B?enFNay8rQmduTUplQ0N6aSt1N0c3NU52NWRSOGF4N201UWp4eXVmdjdvZk8r?=
 =?utf-8?B?eloyS0tnQlZYNzM2TW1GSXlneEV3bldIc2FmZjBUTlY1eHlzL0g0eU1LM0sv?=
 =?utf-8?B?Rm44aFdUVG5pUG9uWURYVTF0RTJDTVl6aXpOUzRFN1grY29lTFBJa3pBZG1k?=
 =?utf-8?B?Nll2bUpXZzdsVFBwVmtMWVBjbDV2djF0WkZ1eE9KdWR6aEM0NFJFQWg3ZGlo?=
 =?utf-8?B?c3J0TnRHVDdIM3MzVVZMU0t4MS81S3pCZDIxK0lZYTVaQis1Q2ZxYUozYUxt?=
 =?utf-8?B?Y0NhTDZCbWFoVnUvTml6SUM5dThOZEN4Um12M1E1TGJVcnZYN0xIb1MxNXV6?=
 =?utf-8?B?T1V1aHg0THRaTWhoMUhEaWgxY05YWCtwNVJsaEhhbEZZTTFUSHkyWlhZQndP?=
 =?utf-8?B?YmpFRmpWZEpPcnpVSzZ4N3hwOFJuamIrMC81R2FSZGpmVER2cTVnT0VPaE5C?=
 =?utf-8?B?ei9qVHJpeGdSeE1BcGFEVCtSN3JuOVIrV0ZLL1Q4a3lyU1NJV2dpcjhMTTZv?=
 =?utf-8?B?alVIN1pFakRVMUp1MC9TT2kxSEFOZUVBUE1Eb0ZnVHViaWRjU3pqZFVCMHFT?=
 =?utf-8?B?YUlCaUk5UEtJalNUMjVuTnNUb1MrRjgyRHhKRm94dkJpS2ZkZVlXUHRZZHJV?=
 =?utf-8?B?Z1d6R0NDMmFRTis2TFZsQXA4Nit5ZG1UNmxKdzJ1Rkx3OFJySUYvUHlLaDEy?=
 =?utf-8?B?TG10eFhvM2l5aFlwUFFBcUdyb1JlRGt0RmRvZWhIUlRZT2FDem5GUC96UDh2?=
 =?utf-8?B?UWdvRDFXMVY4SUhqY2h0Y3FMa0s2b0pBUlhucUtQbXFLQ0xrc1E2bVN2Q29V?=
 =?utf-8?B?Y1RPSmJDSk4xS3JpM2tNdGQ0NHJMekpGNHdUQ0ZRSEY0ek9ySGs5OENRNGpo?=
 =?utf-8?B?c21kRzdsSXd1OEtDcmlGTFo1ejVvNkhSZmV0dytPZDRXYU56azhuMkprRDl0?=
 =?utf-8?B?Ty92NFBOU202RSsyWXVsWnV2NVNLZUI0cTVlV2pwd2p4anIwOGRPSnEzOW1M?=
 =?utf-8?B?aUo3VTdNSDd3SEF5OExWbjQ4SVo5TERVRFZ0b1BUdlprb01XNGY5aGJxNkhP?=
 =?utf-8?B?eWpGR1EwY2E0U21PbEVySHVFSyt0NU1CeHIwTVZRZHFaS2IvaE1UbVk3YUdt?=
 =?utf-8?B?RWJENkRJVExva3IwNWRQdWpPUnAzeWlySERTUjJFY0lhVlV1WXR6dFBpRnFZ?=
 =?utf-8?B?Q1liQzc5K2I0dUtyTFpVOEtSVUUzTWJ6aUluMFl4QitTTnZkZDVmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631f4477-e867-4900-458c-08de88b83083
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:43:00.6471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NKnr5cHn4/GDoD9x8tB1mfYt8jILnDBpGy4YjAaaKmHIuz4v6HpzrCQ10VDlgXQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511
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



On 23-Mar-26 12:26 PM, Jesse.Zhang wrote:
> During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
> dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
> paths this pointer can be NULL, causing a kernel page fault from the deferred
> coredump workqueue.
> 
> Fix by checking ctx before printing VBIOS fields:
> 
> if ctx is valid, print full VBIOS information as before;
> otherwise print a fallback line:
> vbios info       : unavailable (atom_context is NULL).
> This prevents NULL-dereference crashes while preserving coredump output.
> 
> Observed page fault log:
> [  667.933329] RIP: 0010:amdgpu_devcoredump_format+0x780/0xc00 [amdgpu]
> [  667.941517] amdgpu 0002:01:00.0: Dumping IP State
> [  667.949660] Code: 8d 57 74 48 c7 c6 01 65 9f c2 48 8d 7d 98 e8 97 96 7a ff 49 8d 97 b4 00 00 00 48 c7 c6 18 65 9f c2 48 8d 7d 98 e8 80 96 7a ff <41> 8b 97 f4 00 00 00 48 c7 c6 2f 65 9f c2 48 8d 7d 98 e8 69 96 7a
> [  667.949666] RSP: 0018:ffffc9002302bd50 EFLAGS: 00010246
> [  667.949673] RAX: 0000000000000000 RBX: ffff888110600000 RCX: 0000000000000000
> [  667.949676] RDX: 000000000000a9b5 RSI: 0000000000000405 RDI: 000000000000a999
> [  667.949680] RBP: ffffc9002302be00 R08: ffffffffc09c3084 R09: ffffffffc09c3085
> [  667.949684] R10: 0000000000000000 R11: 0000000000000004 R12: 00000000000048e0
> [  667.993908] amdgpu 0002:01:00.0: Dumping IP State Completed
> [  667.994229] R13: 0000000000000025 R14: 000000000000000c R15: 0000000000000000
> [  667.994233] FS:  0000000000000000(0000) GS:ffff88c44c2c9000(0000) knlGS:0000000000000000
> [  668.000076] amdgpu 0002:01:00.0: [drm] AMDGPU device coredump file has been created
> [  668.008025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  668.008030] CR2: 00000000000000f4 CR3: 000000011195f001 CR4: 0000000000770ef0
> [  668.008035] PKRU: 55555554
> [  668.008040] Call Trace:
> [  668.008045]  <TASK>
> [  668.016010] amdgpu 0002:01:00.0: [drm] Check your /sys/class/drm/card16/device/devcoredump/data
> [  668.023967]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  668.023988]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
> [  668.031950] amdgpu 0003:01:00.0: Dumping IP State
> [  668.038159]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
> [  668.083017] amdgpu 0003:01:00.0: Dumping IP State Completed
> [  668.083824]  amdgpu_devcoredump_deferred_work+0x26/0xc0 [amdgpu]
> [  668.086163] amdgpu 0003:01:00.0: [drm] AMDGPU device coredump file has been created
> [  668.095863]  process_scheduled_works+0xa6/0x420
> [  668.095880]  worker_thread+0x12a/0x270
> [  668.101223] amdgpu 0003:01:00.0: [drm] Check your /sys/class/drm/card24/device/devcoredump/data
> [  668.107441]  kthread+0x10d/0x230
> [  668.107451]  ? __pfx_worker_thread+0x10/0x10
> [  668.107458]  ? __pfx_kthread+0x10/0x10
> [  668.112709] amdgpu 0000:01:00.0: ring vcn_unified_1 timeout, signaled seq=9, emitted seq=10
> [  668.118630]  ret_from_fork+0x17c/0x1f0
> [  668.118640]  ? __pfx_kthread+0x10/0x10
> [  668.118647]  ret_from_fork_asm+0x1a/0x30
> 
> v2: add check !adev->bios and chang the log  (Lijo)
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index bbb5afd67b49..29078c08f264 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
>   	drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
>   		   adev->vpe.feature_version, adev->vpe.fw_version);
>   
> -	drm_printf(p, "\nVBIOS Information\n");
> -	drm_printf(p, "vbios name       : %s\n", ctx->name);
> -	drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
> -	drm_printf(p, "vbios version    : %d\n", ctx->version);
> -	drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
> -	drm_printf(p, "vbios date       : %s\n", ctx->date);
> +	if (ctx) {
> +		drm_printf(p, "\nVBIOS Information\n");
> +		drm_printf(p, "vbios name       : %s\n", ctx->name);
> +		drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
> +		drm_printf(p, "vbios version    : %d\n", ctx->version);
> +		drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
> +		drm_printf(p, "vbios date       : %s\n", ctx->date);
> +	} else if (adev->bios) {

In that case, we only need
	if (adev->bios) {
		// print vbios info - ctxt expected to be present always in this case.
	} else {
	}

Thanks,
Lijo
> +		drm_printf(p, "\nVBIOS Information: NA\n");
> +	}
>   }
>   
>   static ssize_t


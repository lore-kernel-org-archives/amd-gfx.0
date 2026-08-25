Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EC3C61DB6
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 07:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF24D10E908;
	Tue, 25 Aug 2026 07:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pmt4wLdO";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F367110E933
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 07:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csbVs8WHkKunAhTAIr/K5GYiOfvL+kMCrAfc/2x8qcz7ensMOxdrqRidF81dHXQTqFVnkxtJ6yxmHSTVXD9GKNrfLyWd0pn0/kAg36FrhKW0ajxqunMpFkJQxeKf5PPpGcOO4AcVn8Vx8T1ddgZRG9dcptxzrgFCPB3SP8/RkYtJIcDo5hWOC5hp9KEQSo4NzuzjbtOD0x8JkiG82KCptWk11akOVqTLnXig0/xHOPrIM+JwmVm54Zl4hS+u76eGvcVaN7YCDXTwgE0LBYtbrtzG2oZBEmEyVEUxMPqIe2x7iJcidKZ/2dy9IFFmSUrWaxPgEXfbU3PeT7Q6V6NXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDzhIZawGkcRfw86FKyLl/fw5zBmb8owXJiWUUegCXM=;
 b=SginNTOo3V4snX683qAF6NyRHTCuV+EkiYi85EUzb/9SAXEEmd7Cr+3HVRqtNHLsOR2Y8tU1RzFUhYidLs70h3zC1SUCKFOt0M1Yw8lxEYyfoD4P5sTIH9AmB8WtT85M6m7x9rh1FdS/r4sDMnOCTYkSlAg4FjHGe3E3uLLNxBvyeFGanDfLinWDMs9yTtRXN2bzVGNLrDYpugKNU2HdAvuyFuo+RnrBiNXfmkhV5l6Td4iPA0Gsf3oOf/5963qrTC85kUi8CeaReuBx0yO6kWbpdXGNQYOQSrHahasv4cmsBq+eJTRs3TQH5b5bH1UaDj8uSOX2w+Ymq84P7VQ0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDzhIZawGkcRfw86FKyLl/fw5zBmb8owXJiWUUegCXM=;
 b=Pmt4wLdO0/m5YbKYJLQk1e2iTDXvhehDd+b2BPc/dEXPq1ILdBshYtAa1lg6TdHQcS/LpehE/ApdIxFL6QT/dm61hV/f87VUs1MCVbsXTLs2NIkbgWx0zP1+fVsLnona+VWJOdKwj+x8+192uvNqmOsVjIZkWuNpge2HAwUsmCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:34:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 25 Aug 2026
 07:34:15 +0000
Message-ID: <44857ea2-7f39-4088-9209-ce21ddaf8987@amd.com>
Date: Tue, 25 Aug 2026 09:34:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] drm/amdgpu/uapi: Add second-level trap handler
 ops to VM ioctl
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 Natalie Vock <nat@pixelcluster.dev>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Six, Lancelot" <Lancelot.Six@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <hakzsam@gmail.com>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
 <20260820070143.3916329-2-srinivasan.shanmugam@amd.com>
 <6dcd3e9a-b308-44c6-a9cb-4bca149a2fde@pixelcluster.dev>
 <IA0PR12MB82080BCDF88122DD4E767E1390AF2@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB82080BCDF88122DD4E767E1390AF2@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e99b08f-32f0-4d4e-8419-08df027b43de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|6133799003|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aw4mf8jbigXLOLg25tOxshA4WSiqFKUR0yB3Tnvfkoj6+lbSswCljG6KTnDjhSglaTVO3WPMk8Ztr86qs96vj5r50Ew7uaZWEFIIwIVjQPWLhHknx+ftS9tG6gnRGO56s4sYah+amQyCe9bxMgufTyYTKRyEb88jNlqd0LRIuXx9utY5BYw45EYCYiMfYigoxSTAegnefUaOyZ0dBMRPHvMm56us/8FSefn2/J2Pr538SoQlMGTNb6vxgIy9F9apKvP0mO8O0059SlThmSRPouLqOqJUzyQ1sNzP/biOmSCH1NgKOVS9hx17e1WchqBK81zKuo416ohmu2Av1Q5JFSJpqUKa/BLU45DCPq2ArSSul0GxJ9vh7eQMg3lhP6XNxdzowrM9ircIWoIrqRJhKLqCm30W3hSZ7ueeGMEU8/q0axGGP+HpBFWe+L1Ccfdu61IMW1YUFRbygvFAqG+MP0F4j1A3srhfvCpnHkLQC+AeU/d/z1eq/zvCRCjUf3xMTKpegLRkdAAaHWQQO783nyPC9SotCPvyoG43pWelLPVcm9EQVdiJ4TCA1VSR008NrijraxIao2IzRxiC9xycqV8Jt3ttgXkLuNnD5139xmfSjp4e6rkIhbucWkud5D7jXgXBSGb/Mz1fRo98L5OnRbcMd7N42MXY67J5HThCaMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(6133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YSsySHR3QjdXd2h1MWFPSWpjbkN6eTlPNWxqdERDWjRFOTl4ZXFtQ0krbjMr?=
 =?utf-8?B?TWpJcENBZmp4MVJ6RGxWNXBQcTU4bVlhUUQwcTFoT3ZSSVV4YUsyejdKc28w?=
 =?utf-8?B?VWlYc2lhUG1ZbW1DOTFOaHdLTk5xVjNNSS9vRVlBaDRBNXpFR0hkZXVNK2Ew?=
 =?utf-8?B?U3A0b05HSU5WK2RUc3pRV3hDTnJEN3kvd3RpTVhJLzEwcHlkMVNjajFLbk5o?=
 =?utf-8?B?NDV5ZHE2WFAzZHpXbFZVNmlMM3R1WWxYbHdST0Nkdjg5R2NhMEVkSEJ3OXBM?=
 =?utf-8?B?S3dWR2NRYUR6UHJWWGZYcmRWNHVYUHRoczNNNkx6bWNKKzVMbElxYWhMTDIx?=
 =?utf-8?B?OTJxMlRwalVqdDRCNlE4MC84RVpKZVpZRktYSFBCMHZGUkVqYmZYUHJFbC9J?=
 =?utf-8?B?dENKL21HaUY3dkVMME9nSzhMZnVWdjZTbzl0YTdHbDRNVzlTVWZNTXFJT1Ra?=
 =?utf-8?B?Z29teS95VmdDdW1sTmxTL2dGNVVxRytuamMvRUlDYnhFYUlsTTQ2N0ZrRXZ4?=
 =?utf-8?B?ZzNXNlIrbEd4V0JKWUJhUGgyWFNwWFl1R3R3a201bVRoUjhLT0dxNEVFV1VC?=
 =?utf-8?B?Zi9BQzNwMEVxTmFhdVFCTmFKZ1VvdjYyMmZiT2gvQlMwQzk1UFF2REhXcS9m?=
 =?utf-8?B?TE4xdlZYRDZnMnpwam5kakFWeG5zbGVNSngzQ3JjRnF4SU00THI1TkF2UXov?=
 =?utf-8?B?R2JFa2hKN3JMbW5zNmlZSk54am1QYXlDMGZUMElxUkRORUM3ZFNodThpVGhW?=
 =?utf-8?B?aUJVRTZIYkZ3RHV0S2xRQStzdml0d0t3M3JJWVdsR1VrUGx1MklIQnlCa2E1?=
 =?utf-8?B?Q25zOUZnNC9iUURBb2IyZFNCczVIRE9xeFJLeXp6bHd5bHQvblNsQUNxMEd1?=
 =?utf-8?B?Sk9JcGJSV1dKaUgwSitoQW9SNUxVLzZkUXNBNWVLbDJHa1RlcERQUndIQTg4?=
 =?utf-8?B?UDJGYk1xRjZDR0NBeSt4dnp6YTBiMHVjUWxnZTFGSHpmK2I1NWlGS015YU9h?=
 =?utf-8?B?cUZSMHdHSkxHMU9JaERGT2dVVGs5dzVQbXZTUHQ5SXB6MmtodUVaekYwTkc0?=
 =?utf-8?B?U1d0dHdYeGNsQWxxemlVVm4xVVJFYU5tVjhJSkRRZmdKYzNoZmdMTWw4K0JC?=
 =?utf-8?B?RHJVZ1Rua1FuZm9IOHZEMzJybXBhY3o5Z2xxbzhudkFBanpzaHBKK3NjblJq?=
 =?utf-8?B?T1FpM25ta2t5eXBYNFdzVVdKeE9PVzI0blhHOWlzWGM3ZUJGYWhlVnlqU1pE?=
 =?utf-8?B?YzRqM0Q5N0RZWld0eGpBT2YzbWZzc0hEOER3eWVJNC9qVUh2YnFMeTdmZXdC?=
 =?utf-8?B?RXR0MjU2Z240TS93QlVsYVp1S2E0NW8xSkM2cmJsbWpBaHdXTllBY2pyUElo?=
 =?utf-8?B?Z1NOdnlwaHBOQWF3UXZqR3d5SzE2czVldWVoTXdSNmVPSUVlV3dmTnV4Y3RR?=
 =?utf-8?B?U3ArTlJVazJ1NHBqTFREbzBuZ0FkRGs2ZXFNUVpPZnZ5cXhhaE1mZlBtRmV5?=
 =?utf-8?B?RkxhZ29WcTNuL2ZITzNDb3N3dW9xKy9ra3hIRjc1a3BRSGZQVmYwN2xrYU92?=
 =?utf-8?B?Z1lWdUVhU3B0R2w4ZEVkeWtpdEg4emJXMFRwbWVmU2xWVnUxU2JFRUhtS3F4?=
 =?utf-8?B?Vi9IcXpkdXdRektTWU9xTWszRTdIZFA1VXFmSmRYSlludFI5K0JjZUJSL3BH?=
 =?utf-8?B?a2RaeWQzNi9FeGJrSksrS09jMHlzK2VjUldVT0dOVHlseExVdDB5QlpwaXJl?=
 =?utf-8?B?Z1g4eWszUWFFRGlnb3U2OWVlb0JzOEE0SU4wSWVMWGhCZHBrSS9OQTQxRndH?=
 =?utf-8?B?bVRBUzRrbVlqTmpieDlWVkVFNHU4YlZSbDVWZzNDZ085QXJHanBrWVR6SUdz?=
 =?utf-8?B?ZmU4RUtGbmtyQVhXdSs5cnZVdncwcUdlTFVhUWZxeVcyNUZtZjl4VisyU1hL?=
 =?utf-8?B?UmJTb2pSOWUxNmZtVytzaUtMYVZ2L1VlYlBXUk5uNEo3d3BOUzVRVm9XaWMv?=
 =?utf-8?B?OXc3cyt6YTZxa0lReTc0NlJXRzFGQTBvU1Y3UjlOQklIR3duMEVPKzd0Tkd0?=
 =?utf-8?B?bVpzN1FndVF3MEV2b0MybjNCVXkxa0s1V0tsTHl6bzVBZkZIODBMZk5hcGZt?=
 =?utf-8?B?SnkvTWJMR25nb1k0WEtVQzJjUTdBOFdIeGhlMlY5L1kya0pBdDMxNVJlKytO?=
 =?utf-8?B?MmVYMVg5SUFVLzVVaDRpY3BIM3B4bTNrbVU3MFZ4blZGQU1jNTBzcmk3VGhj?=
 =?utf-8?B?c0hEYVo0VWM2d2phRENYLzZLVzdzVlpVWmJDekNyVzVabVpNNk9aVktyWlFa?=
 =?utf-8?Q?UFotfFIfAnde4iLWFR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e99b08f-32f0-4d4e-8419-08df027b43de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:34:15.4999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6BagU7bFXc9mtPh1OR+C0Rlu4cU1mLcr5bAIgCvJoRs5wg/fTFEq4457MeyvdDT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144
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

On 8/25/26 07:05, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Natalie Vock <nat@pixelcluster.dev>
>> Sent: Thursday, August 20, 2026 3:29 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>;
>> Zhu, James <James.Zhu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Six,
>> Lancelot <Lancelot.Six@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-
>> eric.Pelloux-prayer@amd.com>; Timur Kristóf <timur.kristof@gmail.com>; Samuel
>> Pitoiset <hakzsam@gmail.com>
>> Subject: Re: [RFC PATCH 1/3] drm/amdgpu/uapi: Add second-level trap handler
>> ops to VM ioctl
>>
>> Hi,
>>
>> first of all: Thanks for working on this! It's great seeing trap handler support come
>> together.
>>
>> On 8/20/26 09:01, Srinivasan Shanmugam wrote:
>>> When a GPU shader hits an exception, memory fault, or debug
>>> breakpoint, the hardware jumps to the first-level trap handler. The
>>> first-level handler (managed by the kernel via CWSR) checks the TMA
>>> buffer for a second-level handler address. If one is installed, it
>>> forwards the trap to that userspace handler, allowing the runtime or
>>> debugger to handle shader exceptions without modifying the kernel trap handler.
>>>
>>> KFD already supports this for compute workloads. Render-node user
>>> queues had no equivalent mechanism. Add it.
>>>
>>> The second-level handler is a per-VM setting — it applies to all
>>> shader waves executing under that VMID regardless of queue type. GFX
>>> and compute queues from the same process share the same VMID, so one
>>> SET_L2_TRAP call covers all queue types for that process. This
>>> configuration is not CWSR-specific; CWSR is only the first-level
>>> handler mechanism. The correct home for this setting is the VM ioctl
>>> (DRM_AMDGPU_VM), following the same pattern as
>>> AMDGPU_VM_OP_RESERVE_VMID.
>>>
>>> Add two new VM ioctl operations:
>>>    AMDGPU_VM_OP_SET_L2_TRAP   (op = 3) — install second-level handler
>>>    AMDGPU_VM_OP_CLEAR_L2_TRAP (op = 4) — remove second-level
>> handler
>>>
>>> Extend drm_amdgpu_vm_in with a 32-byte union for op-specific data. The
>>> l2trap member carries the GPU virtual addresses and sizes of the TBA
>>> (handler code) and TMA (handler scratch memory).
>>
>> This should be a BO handle and offset+size, instead. The BOs associated with the
>> TBA/TMA must be tracked as used by every submission from the VM that has this
>> trap handler installed, otherwise you introduce a ton of race conditions. Off the top
>> of my head, here are a few:
>> 1. The GEM VA ioctl can spuriously fail to actually update page tables.
>>     This is okay and intentional, and BOs with outdated page tables will
>>     be updated on the next submit if they're used by the submission. If
>>     the TBA/TMA BOs aren't marked in the set of used buffers, the PTs may
>>     end up never being updated and subsequent accesses will fault.
>> 2. The TBA/TMA may be evicted/moved around concurrently with executing
>>     submissions if these submissions didn't add their fences to the
>>     TBA/TMA resv, which would likely randomly corrupt things or hang.
>>
>> A simpler solution could be requiring the TBA/TMA buffers to be
>> VM_ALWAYS_VALID, in which case synchronization to all submissions in the VM
>> is taken care of automagically. This prevents exporting the TBA/TMA to an fd, but I
>> don't expect anyone would want to do this.
> 
> Hi Natalie,
> 
> Thanks for the feedback.
> 
> We will update the UAPI in v2 to pass BO handles alongside
> the GPU VA for TBA/TMA. This ensures the kernel can properly
> track and pin the buffers.

Please don't. It is the responsibility of userspace to make sure that the BOs are either in the used list or valid per VM.

Regards,
Christian.

> 
> Thanks,
> Srini
> 
>>
>> Regards,
>> Natalie


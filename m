Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A4CC79FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 09:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E544610F3DA;
	Thu, 10 Sep 2026 09:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VAZL0yzP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63AAB10F3D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 09:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD6pOw1twNUEG/5seew6if9gp5NYiE4+sqCq81/l49/BinivI/w6OIrkOkeBGjnEihfLAuR8okObVz5C1VgCJE6POey48VU65x/SAdMyDCEwcKAo/rJTRx7U0ozgdfPuiUBvatLl+q7jGYQI+AxBFlrN6jIsUPC/6oDU/Pw1lbd/BxCi4cM1dDq661SxZlteLTKDL3Wq47q2X92OTnljrvbzIqmhBZCQyNgNTnQjsdKEG3ELSk5lSoJWMyQRYYm0TGrBv49gLD8Pg9G91WhmXfDKZzY1NOePq1eiY0jQQ7vgqokei4BDse/1Sg3BR9C58/gF048UjvRDGnPdUD1zKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpbh+J5IdtWqffa0C8qvAtb00cLL5qaDAQRzcGrrkc8=;
 b=QwyEFpCllgjUN7++siQ2/Utd5OK6/+P0vqsw9GZvJRr/XtFYa1UMrteNeRQzIjsCl32n1pYoLkkC7rNHcovm8XTkGfqCZw3lr6GlP9zdQZf3byexYcDDl2Y8LDIL5uBuqaE6/IZZuLhMo8pehpetG8Ew4AXCscGeLJRxduyv8Stq68gUXXfbfbh3lkJMYMIqZJm03s8F3IY31wMzZmzS0cegF5hsQxMDp06jqmbYRTWtxaeO3+0vOPXsCbS9stulkaleR2CeIcOoLh2vwO901tfalkzMu2eqYjjcX+3+sclm2swOe4i2LfmJpqGcHX37V+oU2BaJS5GcRE207WPZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpbh+J5IdtWqffa0C8qvAtb00cLL5qaDAQRzcGrrkc8=;
 b=VAZL0yzPHoZeTEjrPnykshNTUZDWS+pAGL2jLxTNa+adX0BEpBmMm7P0rYvoQaf+qxW5vkvzYnDWQEBdcloi+hMK/IdYupKLzWFoPvARZGOSiQxf+3V73H6+gJFbIQQVRlab18pKMAqib4Y9MSOBhMzOSKjMMzm53p7gKXbTCJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Thu, 10 Sep
 2026 09:43:17 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 09:43:17 +0000
Message-ID: <43c8cce9-c6f8-4070-812a-a7ee63e3d958@amd.com>
Date: Thu, 10 Sep 2026 15:13:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <CADnq5_PHEQzUVTqJYzO3mALs9LfK9cAUMQtgi0JEzGvFSZk7Eg@mail.gmail.com>
 <CADnq5_M+tLHSrfXQCxX2+LFq-x8OO1=BG+ou=qq2_Y0VS+b8AA@mail.gmail.com>
 <8573edf1-9af4-423d-8af8-08ac38f33ab2@amd.com>
 <61caf661-a844-47b6-87b5-e7b71c3cd6b3@amd.com>
 <3aeba017-08b7-4554-9c71-e031c42e8a21@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <3aeba017-08b7-4554-9c71-e031c42e8a21@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0296.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b11f7e6-1794-4a70-2479-08df0f1ff11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|6133799003|3023799007|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +SLEG/w32yNc/5ZEf1Vaxk3JFyhxWfyJf93fFwujpiQEniGHx7eeZqrvgfI7GzdKbIsRhKCBrtGQvqH5lsi5tOTIvVd6BT0B1WnwL5J/bgr5gbAhQu7aro/n8u2TFNvzRbEhRT2wA9NtNBVbYUMEXoGpGzTswDUffPznsNIRYeoyTyEcnivgiCLkDJ3hZy3aIbAS7qqtcvGTPM8QkSGWJA8NjFeXew6glEsFhLBY4g70k3YYPp3eI9WpJAK4V2Gk7OjN0aAfk+dZgPIhm+3UyVLSbX7qao6b9z1fcrB9jqhPrVvvFrFD8H6ujrKUT5nRjN6n0Mwyoai0Fs6vv64kI9fbn4/v10iX+a2+3PnexHmL7A+fFfDls5rWpchnGbcrI1zCwE0yr+bkoPVQptRvq2aR+1gsdv5SkUN/rok6jfc1qkyg8VCVXiAXGahKW4vdCPiNRN2KbtMWtL+OMF2jjJFlCJlmJvoR8aCknjKWpNDjiOqMECiSTuJyGLmEZeIYNNK9y6G//xpEngqk4usDYiwwy3fz6rMPxMWY7Qo9mDyo3Rn+cx2KXGczoLnvpQIgQ2ao2MO7wB8x5yz54FmHwt7CnSud5DYXJqpeyAo3gIHp1yIpXYZWLAT+7IjgpEVTyu7RkobaYY0T3GFwMYMytOUIvDrDNiKAI2RbDSRVKIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NytOeUY0Y3MxMElRZC8vWkVtU1draWtVQVYyUnZKMEpjaWNiNktXQTA3V2xn?=
 =?utf-8?B?dE1NdllDT0xVcmY5NURPVXZiOWJhT1ozTEFNdHpNNXcyYjBMMTF6Y3NkT3Er?=
 =?utf-8?B?d1BwZlpwc3VMMklmRXh1WTErb3VjZUlPUXlaNlJWSndFRU9naFQxcVowdXF1?=
 =?utf-8?B?WTRLbTlkV1gzdVdYQ0dFSmI1MEVPQ09rVEsyWmYvb3hiTGhncGsxOGQzTjdT?=
 =?utf-8?B?RzNCQ0xwVnFjc2FhQms0aHc4aXlIeEVIcG5EU0p2NXpjY2RWYUV5cFZmemdM?=
 =?utf-8?B?MWtOV2lvcXpmL1ZUUWc3OXBsOXNKS0thOXBIREVnTkNqcUpxSVE0SDRLL3JX?=
 =?utf-8?B?Tjc3ZVU5QlM0RGVqc0FjcjVsQVpIWUdNS01MeEFYSUxlb3lZSlRYTGRiazBB?=
 =?utf-8?B?NW5aaktYT1VVeGtuTkU3NDNJM3NybCt4STMvUEplQXFTSnZTWFNFUVBuTU9z?=
 =?utf-8?B?VWg2ekxvVzZDaGE3b0p5VVkwYjlDMWw1eGZwdlpkVlRFaFI1Nms5YjdTVnI5?=
 =?utf-8?B?MkMwdnNiRW1RS21USmhFUUplTFJFSXYzKzhKL2RJWkk0V1RGWlpRaHUzUGh3?=
 =?utf-8?B?NGJDRE9YcW1INUpPR01PUW5yaWpaUjFSc1pwZWw5akhvM3NMOG8wMFB5aE9n?=
 =?utf-8?B?Qzk4ODJMZnZIUk1qNHlRUWI4enVlYk5sN3RpNERMc2ZKYktMQ0hUaU9iMExL?=
 =?utf-8?B?RnNkYXAvNVNad3NwV0ZrU2JEaFViS1pSMFAwYVdpcEdnSTNxYmJkNFJFbGIy?=
 =?utf-8?B?TmpQRi9qMDJpeW5zbHFNbVkzSC9hVHl1VG1KRHFMc3B0S3JXR1BjcTJOaTJr?=
 =?utf-8?B?MXFxNDNzU25YVytOM3VYOERnSDVjRVNIbXJsWUVQWDRlNU4zKzJVajRYUHhE?=
 =?utf-8?B?clhJQ0VEb1BYUGUwRDNUVHdrc3VnNzRwc3VmTVVDOGh2dGtVZWd4V2xyaVZQ?=
 =?utf-8?B?cDhQYzBaeXd1MllpRld1dnN4VVZRRUQvQmxxTXptU2lQanFiL05hTkw2Q2pr?=
 =?utf-8?B?US9oUWVTY21ZUUxhVnpQVlhPdzVGbzNsN3hLcmFpWHR5dDR2bHkvL2F1VmlG?=
 =?utf-8?B?ckZZN2JyeHZtbG5JcUF2d1FvUmNrRzFuaGplK2UxT1Z2OEE2Q25XUEhoa2xs?=
 =?utf-8?B?L1ZEakFYK2N5Umx5V3dBcjFoYWFsRkJ0WGYvbDc2bjdlcE5VTU52SW9wRzkx?=
 =?utf-8?B?a3lWUFBNU0ROVW5GSUZCQjV5dk1mem1zUEswcllHMFFpR21zUmN4TWczay8x?=
 =?utf-8?B?OWhBZXJtOU1OcDN6TUVyV0ptMlFnM3lSWVdLdXJmMnNEaEtQMG5GN2w1ai9s?=
 =?utf-8?B?a1VWWUZNWS96MDZxeXRTenovWG84c2dkRm9ZY3p1Vi9FTnpiSElrZTBmWG1R?=
 =?utf-8?B?b0d0OFBvUzZsSFhCRGd2ekhsWGZLWUV4TER1a2FUV2R6MGRPak92bWt5clN6?=
 =?utf-8?B?M3NSL2F3ajNPRHlJYXBYNFJuVzJXWmMzM09ZRjN3TGJOcnIxa1l5WGdTYTll?=
 =?utf-8?B?VDN0cmhrZGJTQ1hFZDdMb1dDNFphbkRIb2k5TUxMN1hJK2dmL1k4dHcxVGNV?=
 =?utf-8?B?SEo4a2hyeDFvTHRJYk9rcVAwampXTTMyY2pYVmVLbm9yWER3NlBRcmpobnlP?=
 =?utf-8?B?Q2thL2d5djdadThFT24zbGdUWHNBcVB5N0ZDaVQrZU0yWkZPdXN6VlpBdUhQ?=
 =?utf-8?B?WTkwSmozb1dyK3A4NnBnZ1JjSUU5MyttSkkvWkdYbmt4LzdhMlFxRzhDZkZF?=
 =?utf-8?B?NmZsSm1TUElNRVhsNXZhT0hXTXFPaE5vYmZoKzZDMndGdmY4bUh0cmloVnRM?=
 =?utf-8?B?YVFWQ3ZuS3FxempHTi9VZ1gwQXpQMDVpRkxZejBRbUtyOXo1c2ZibURwTGZ4?=
 =?utf-8?B?QS9zcU1MYzNjUEo4OUhRQm9UZzA0Nnp0RWVSL20zd0hxSmxUbWlXaGFHb1ky?=
 =?utf-8?B?cjdLLzlldzRUUXZjMitUcnVCSTEzRGd0MHl0QTYxTW9aZFR1YmtFMjQrVkRG?=
 =?utf-8?B?ZU03SHdMUWUrNXNsUE9ZZjBCTnRNVEFGN3I0U05QNHJmUSsyZVpWQi85V0JC?=
 =?utf-8?B?eHE0cGxpNHRzVVZxYlNRdU5CRC82OHMxUUVzQTh2TmJNYkttd2VJZlJzMFYr?=
 =?utf-8?B?a3JPR2xWYWF1RFVRUUp3MVR5b2ROSlVCbnZTdFJrUzRBTVR5RHc4RCtPY2kw?=
 =?utf-8?B?R3ZYRWdKcEZoeWhRcXRBajZlbjBLM3FOc3o3KzdrN3l2RjJoSm5lQ2k1L0d4?=
 =?utf-8?B?VFZUbkhzQWxkVnBWWkVJaUxkY21CWTlrdW9IeTdmSlpCeXB2ckhpM0l4NlFH?=
 =?utf-8?B?Y2MyTzJIbE1VSUtjRmM3b05uWkFDd1hhLzN6OGIwSVlpVjAvNjcxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b11f7e6-1794-4a70-2479-08df0f1ff11e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 09:43:17.5600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fca05ri8gnwLH4522fALeOFggSZQq/2ASYelLqgcOH4sBW1jWT9opnzIc+NE7C4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494
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



On 10-Sep-26 1:55 PM, SRINIVASAN SHANMUGAM wrote:
> 
> On 9/10/2026 12:27 PM, Lazar, Lijo wrote:
>>
>>
>> On 10-Sep-26 11:43 AM, SRINIVASAN SHANMUGAM wrote:
>>>
>>> On 9/10/2026 2:20 AM, Alex Deucher wrote:
>>>> On Wed, Sep 9, 2026 at 4:42 PM Alex Deucher<alexdeucher@gmail.com> 
>>>> wrote:
>>>>> On Sat, Sep 5, 2026 at 4:55 AM Srinivasan Shanmugam
>>>>> <srinivasan.shanmugam@amd.com> wrote:
>>>>>> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not 
>>>>>> program
>>>>>> SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
>>>>>> via ADD_QUEUE with map_legacy_kq=1 but does not set trap handler 
>>>>>> state.
>>>>>> On GFX10 and earlier HWS-based hardware, the driver programs trap
>>>>>> registers via SRBM select for KFD queues but no equivalent exists for
>>>>>> driver-managed kernel queue VMIDs.
>>>>>>
>>>>>> Add a vmhub callback program_kernel_trap_vmids() so each gfxhub 
>>>>>> version
>>>>>> can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
>>>>>> device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
>>>>>> address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its own 
>>>>>> kq_tma_bo
>>>>>> there, so per-VM isolation is handled entirely by page tables without
>>>>>> needing to reprogram the register per job or per submission.
>>>>>>
>>>>>> The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
>>>>>> (parallel to page table allocation) and mapped read-only into the 
>>>>>> GPU VM
>>>>>> at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the 
>>>>>> second-level
>>>>>> handler address into it via kq_tma_map when userspace calls 
>>>>>> SET_L2_TRAP.
>>>>>> The first-level CWSR handler reads this address to chain to the
>>>>>> second-level handler when a shader exception fires.
>>>>>>
>>>>>> This design is:
>>>>>>    - Per-VM BO (not device-level) — same model as page tables
>>>>>>    - Fixed VA in each VM's address space — same VA, different 
>>>>>> physical BO
>>>>>>    - Read-only from GPU — kernel CPU updates it via CPU mapping
>>>>>>    - Treat allocation/free lifecycle identical to page tables
>>>>>>
>>>>>> Suggested-by: Christian König<christian.koenig@amd.com>
>>>>>> Suggested-by: Alexander Deucher<alexander.deucher@amd.com>
>>>>>> Cc: Lijo Lazar<lijo.lazar@amd.com>
>>>>>> Cc: Timur Kristóf<timur.kristof@gmail.com>
>>>>>> Cc: Samuel Pitoiset<hakzsam@gmail.com>
>>>>>> Cc: Natalie Vock<natalie.vock@gmx.de>
>>>>>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>>>>>> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++ 
>>>>>> ++++++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
>>>>>>   5 files changed, 110 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/ 
>>>>>> gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>>> index 3ca187f5ade8..5624a5ab5c62 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>>> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>>>>>>          void (*print_l2_protection_fault_status)(struct 
>>>>>> amdgpu_device *adev,
>>>>>>                                                   uint32_t status);
>>>>>>          uint32_t (*get_invalidate_req)(unsigned int vmid, 
>>>>>> uint32_t flush_type);
>>>>>> +       void (*program_kernel_trap_vmids)(struct amdgpu_device 
>>>>>> *adev);
>>>>>>   };
>>>>>>
>>>>>>   struct amdgpu_vmhub {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/ 
>>>>>> gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>>>> index 623cac6781be..e913488ca3fa 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>>>> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>>>>>>
>>>>>>          amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>>>>>>          adev->trap_info = no_free_ptr(trap_info);
>>>>>> +       amdgpu_trap_program_kernel_vmids(adev);
>>>>>>
>>>>>>          return 0;
>>>>>>   }
>>>>>> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device 
>>>>>> *adev)
>>>>>>          adev->trap_info = NULL;
>>>>>>   }
>>>>>>
>>>>>> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
>>>>>> +{
>>>>>> +       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>>>>>> +
>>>>>> +       if (!amdgpu_trap_is_enabled(adev))
>>>>>> +               return;
>>>>>> +       if (!hub->vmhub_funcs || !hub->vmhub_funcs- 
>>>>>> >program_kernel_trap_vmids)
>>>>>> +               return;
>>>>>> +
>>>>>> + hub->vmhub_funcs->program_kernel_trap_vmids(adev);
>>>>>> +}
>>>>>> +
>>>>>> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
>>>>>> +                               struct amdgpu_vm *vm)
>>>>>> +{
>>>>>> +       void *cpu_addr;
>>>>>> +       uint64_t va;
>>>>>> +       int r;
>>>>>> +
>>>>>> + dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>>> +
>>>>>> +       r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, 
>>>>>> PAGE_SIZE,
>>>>>> +                                   AMDGPU_GEM_DOMAIN_GTT, &vm- 
>>>>>> >kq_tma_bo,
>>>>>> +                                   NULL, &cpu_addr);
>>>>>> +       if (r)
>>>>>> +               return r;
>>>>>> +
>>>>>> +       if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>>>>>> + iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
>>>>>> +                                         (void __iomem *)cpu_addr);
>>>>>> +       else
>>>>>> + iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
>>>>>> +
>>>>>> +       vm->kq_tma_va = amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
>>>>>> +       if (!vm->kq_tma_va) {
>>>>>> +               r = -ENOMEM;
>>>>>> +               goto err_free_bo;
>>>>>> +       }
>>>>>> +
>>>>>> +       va = AMDGPU_VA_RESERVED_TRAP_START(adev) & 
>>>>>> AMDGPU_GMC_HOLE_MASK;
>>>>>> +       r = amdgpu_vm_bo_map(adev, vm->kq_tma_va, va, 0,
>>>>>> +                            AMDGPU_GPU_PAGE_SIZE,
>>>>>> +                            AMDGPU_VM_PAGE_READABLE);
>>>>>> +       if (r)
>>>>>> +               goto err_del_va;
>>>>>> +
>>>>>> +       r = amdgpu_vm_bo_update(adev, vm->kq_tma_va, false);
>>>>>> +       if (r)
>>>>>> +               goto err_del_va;
>>>>>> +
>>>>>> +       return 0;
>>>>>> +
>>>>>> +err_del_va:
>>>>>> +       amdgpu_vm_bo_del(adev, vm->kq_tma_va);
>>>>>> +       vm->kq_tma_va = NULL;
>>>>>> +err_free_bo:
>>>>>> +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
>>>>>> +       return r;
>>>>>> +}
>>>>>> +
>>>>>> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
>>>>>> +                               struct amdgpu_vm *vm)
>>>>>> +{
>>>>>> +       uint64_t va;
>>>>>> +
>>>>>> +       if (!vm->kq_tma_bo)
>>>>>> +               return;
>>>>>> +
>>>>>> + dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>>> +
>>>>>> +       if (vm->kq_tma_va) {
>>>>>> +               va = AMDGPU_VA_RESERVED_TRAP_START(adev) & 
>>>>>> AMDGPU_GMC_HOLE_MASK;
>>>>>> +               amdgpu_vm_bo_unmap(adev, vm->kq_tma_va, va);
>>>>>> +               amdgpu_vm_bo_del(adev, vm->kq_tma_va);
>>>>>> +               vm->kq_tma_va = NULL;
>>>>>> +       }
>>>>>> +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
>>>>>> +}
>>>>>> +
>>>>>>   static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>>>>>>                                    struct amdgpu_vm *vm,
>>>>>>                                    struct amdgpu_trap_obj *cwsr,
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/ 
>>>>>> gpu/drm/amd/amdgpu/amdgpu_trap.h
>>>>>> index 7f83174a4742..9be5035abd1c 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>>>>> @@ -155,4 +155,11 @@ int amdgpu_trap_set_trap_debug_flag(struct 
>>>>>> amdgpu_device *adev,
>>>>>>                                      struct amdgpu_trap_obj 
>>>>>> *cwsr_obj,
>>>>>>                                      bool enabled);
>>>>>>
>>>>>> +/* Kernel queue trap handler — per-VM TMA and register 
>>>>>> programming */
>>>>>> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
>>>>>> +int  amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
>>>>>> +                                struct amdgpu_vm *vm);
>>>>>> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
>>>>>> +                               struct amdgpu_vm *vm);
>>>>>> +
>>>>>>   #endif
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/ 
>>>>>> drm/amd/amdgpu/amdgpu_vm.c
>>>>>> index de3ef9ce2234..f5e228d4bfb5 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> @@ -2640,6 +2640,12 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>>>> *adev, struct amdgpu_vm *vm,
>>>>>>          if (r)
>>>>>>                  goto error_free_root;
>>>>>>
>>>>>> +       if (amdgpu_trap_is_enabled(adev)) {
>>>>>> +               r = amdgpu_trap_vm_kq_tma_alloc(adev, vm);
>>>>>> +               if (r)
>>>>>> +                       goto error_free_root;
>>>>>> +       }
>>>>>> +
>>>>>>          r = amdgpu_vm_create_task_info(vm);
>>>>>>          if (r)
>>>>>>                  dev_dbg(adev->dev, "Failed to create task info 
>>>>>> for VM\n");
>>>>>> @@ -2774,6 +2780,9 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>>>>> *adev, struct amdgpu_vm *vm)
>>>>>>                  amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>>>>>>          }
>>>>>>
>>>>>> +       if (vm->kq_tma_bo)
>>>>>> +               amdgpu_trap_vm_kq_tma_free(adev, vm);
>>>>>> +
>>>>>>          amdgpu_vm_pt_free_root(adev, vm);
>>>>>>          amdgpu_bo_unreserve(root);
>>>>>>          amdgpu_bo_unref(&root);
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/ 
>>>>>> drm/amd/amdgpu/amdgpu_vm.h
>>>>>> index dd825e179979..064f95a83790 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>> @@ -25,6 +25,7 @@
>>>>>>   #define __AMDGPU_VM_H__
>>>>>>
>>>>>>   #include <linux/idr.h>
>>>>>> +#include <linux/iosys-map.h>
>>>>>>   #include <linux/kfifo.h>
>>>>>>   #include <linux/rbtree.h>
>>>>>>   #include <drm/gpu_scheduler.h>
>>>>>> @@ -488,6 +489,18 @@ struct amdgpu_vm {
>>>>>>
>>>>>>          /* cached fault info */
>>>>>>          struct amdgpu_vm_fault_info fault_info;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * Per-VM kernel queue first-level TMA BO.
>>>>>> +        * Allocated at VM init, freed at VM fini — same lifecycle 
>>>>>> as page tables.
>>>>>> +        * Mapped read-only at AMDGPU_VA_RESERVED_TRAP_START in 
>>>>>> the GPU VM.
>>>>>> +        * SQ_SHADER_TMA for all kernel VMIDs points to this fixed 
>>>>>> VA; per-VM
>>>>>> +        * isolation is via page tables mapping different physical 
>>>>>> BOs there.
>>>>>> +        * CPU kernel writes second-level handler address via 
>>>>>> kq_tma_map.
>>>>>> +        */
>>>>>> +       struct amdgpu_bo        *kq_tma_bo;
>>>>>> +       struct amdgpu_bo_va     *kq_tma_va;
>>>>>> +       struct iosys_map         kq_tma_map;
>>>>> These should be the same for both user and kernel queues. The only
>>>>> difference is who manages the vmids (driver vs MES).  They are per
>>>>> vmid so it doesn't matter whether it's a kernel queue or user queue.
>>>>>
>>>> I would merge these patch sets.  The trap handling is the same for
>>>> both kernel queues and user queues.  The only difference for kernel
>>>> queues is that the driver has to set the TBA/TMA registers while
>>>> MES/KIQ handles it for user queues.  At vm_init time, allocate the
>>>> memory for the trap handler, copy the trap handler to the memory and
>>>> add the mapping to the GPUVM address space.  Then in gfxhub init,
>>>> program the TBA/TMA registers for the kernel managed vmids. Finally,
>>>> add the IOCTL to set/clear the second level trap handler and validate
>>>> the user supplied GPU VA.
>>>
>>> Hi Alex,
>>>
>>> Thank you for the review. I have few questions before proceeding with 
>>> the implementation.
>>>
>>> I looked at how KFD handles this today in |kfd_process.c|:
>>>
>>> /* KFD writes second-level TBA/TMA into first-level TMA */
>>> iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
>>>               uint64_t, tba_addr);
>>> iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
>>>               uint64_t, tma_addr);
>>>
>>> Where |KFD_CWSR_TMA_OFFSET = AMDGPU_GPU_PAGE_SIZE + 2048 = 0x1800|. 
>>> KFD uses physical GPU addresses for TBA/TMA registers, not VM virtual 
>>> addresses.
>>>
>>
>> KFD doesn't use physical adddress, it uses the below fixed virtual 
>> address.
>>
>> pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(pdd->dev->adev)
>>
>> KFD mechanism is to allocate one BO which is mapped to the above 
>> virtual address. That BO accounts for both TMA and TBA size. TMA is 
>> located at KFD_CWSR_TMA_OFFSET within that BO.
>>
>> TBA region carries the first level handler code. It's not allowed to 
>> be overridden by user. Hence when we moved to new design, TBA is kept 
>> common for all user VMs.
>>
>> TMA BO is the place through where user's second level TMA/TBA 
>> addresses are passed and also the place where stack is saved.
>>
>>                 iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
>>                              uint64_t, tba_addr);
>>                 iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + 
>> sizeof(uint64_t),
>>                              uint64_t, tma_addr);
>>
>> What this code does is to write the second level handler tba/tma 
>> addresses in the TMA, which is located at KFD_CWSR_TMA_OFFSET within 
>> the BO.
>>
>>
>> TMA region is the only variable thing per VM. First level handler code 
>> executed is the same for all VMs. So in the new design, we have a 
>> first level TBA BO that is shared by all VMs, and that carries first 
>> level trap handler code. The second level TBA is allocated per VM.
>>
>> I see Alex is saying the same thing which I asked through a different 
>> thread. There is no need to allocate separate BOs for kernel queues. 
>> All you need to do is program the fixed TBA/TMA first level virtual 
>> addresses for non-KFD VMs during init.
>>
>> Regarding kernel queue draining - my understanding is that the 
>> condition is no work having that VMID is in progress during the 
>> change. So, it may not be required to entirely drain kernel queue.
>>
>> Thanks,
>> Lijo
>>
> I would like to take a moment to summarize what has been agreed upon and 
> share my thoughts on the remaining open points, to ensure we are all 
> aligned.
> 
> *What is agreed:*
> 
>  1. Fixed VA = |AMDGPU_VA_RESERVED_TRAP_START| — same as KFD
>  2. TMA starts at offset |0x1800| from BO start — matching |
>     KFD_CWSR_TMA_OFFSET|
>  3. |SQ_SHADER_TBA/TMA| registers programmed in gfxhub init — kernel
>     VMIDs only
>  4. UQ and KQ series merged into one — no separate |kq_tba_bo|/|kq_tma_bo|
>  5. |SET_L2_TRAP|: evict user queues, ensure no VMID work in progress,
>     write TMA, flush TL
> 
> *Open Point 1 — Shared TBA or per-VM TBA copy?*
> 
> Alex said: /"copy the trap handler to the memory at vm_init"/ → sounds 
> like per-VM copy.
> Lijo said: /"TBA is kept common for all user VMs"/ → sounds like one 
> shared BO.
> 
> IMO: The first-level handler code (ISA binary) is identical across all 
> VMs for the same hardware. Based on this, one option is to keep a single 
> shared device-level TBA BO (|adev->trap_info->isa_bo|) mapped into each 
> VM at |AMDGPU_VA_RESERVED_TRAP_START|, and allocate only the TMA BO per- 
> VM at |vm_init|. This avoids duplicating the same ISA binary N times in 
> memory. Please let me know if a per-VM TBA copy is preferred instead.

For clarififcation, this is the existing implementation in amdgpu_cwsr.

Thanks,
Lijo

> 
> *Open Point 2 — What happens to |AMDGPU_VA_RESERVED_TRAP_UQ_START|?*
> 
> After merging, |AMDGPU_VA_RESERVED_TRAP_START| covers both UQ and KQ in 
> one buffer.
> 
> IMO*:* Remove |AMDGPU_VA_RESERVED_TRAP_UQ_START| from the reserved VA 
> space entirely since it is no longer needed.
> 
> *Open Point 3 — When to set |TRAP_EN|?*
> 
> IMO*:* Set |TRAP_EN| at gfxhub init time. Since the per-VM TMA BO is 
> always allocated at |vm_init| before any work is submitted, | 
> AMDGPU_VA_RESERVED_TRAP_START| is always valid when any shader executes. 
> No need to defer.
> 
> *Open Point 4 — How to ensure no VMID work is in progress?*
> 
> When |SET_L2_TRAP| is called, the TMA slots must be written only when no 
> GPU work is actively executing under that VMID. One option is to use | 
> amdgpu_vm_wait_idle()| before writing the TMA slots, which waits for all 
> pending GPU work in the VM to complete. This is already used in the 
> existing trap handler code for the same purpose. Please confirm if this 
> is sufficient or if a different mechanism is needed.
> 
> Please confirm or correct any of the above
> 
> I would greatly appreciate it if anyone has a different perspective on 
> any of the above or anything missing to be included or added  — so that 
> the design is aligned with everyone.
> 
> Regards,
> 
> Srini
> 
>>> Question 1 — Which fixed GPU virtual address for the merged buffer?
>>>
>>> KFD uses physical addresses for the TBA/TMA registers. Our design 
>>> maps the buffer into each VM at a fixed virtual address for page 
>>> table isolation. Should the merged per-VM buffer use | 
>>> AMDGPU_VA_RESERVED_TRAP_UQ_START| as the fixed VA? Or a different 
>>> address?
>>>
>>> Question 2 — TMA offset inside the merged buffer — 0x1800 or 0x2000?
>>>
>>> KFD places the TMA section at offset |0x1800| from the TBA start (| 
>>> KFD_CWSR_TMA_OFFSET|). The current UQ design uses offset |0x2000| (| 
>>> AMDGPU_TRAP_TBA_MAX_SIZE|). After merging into one per-VM buffer, 
>>> should TMA start at |0x1800| to match KFD's layout?
>>>
>>> Question 3 — When should TRAP_EN be set?
>>>
>>> When programming |SQ_SHADER_TBA_HI| for kernel VMIDs, should | 
>>> TRAP_EN| be set only after the per-VM buffer is fully mapped? Or is 
>>> it safe to set it at boot time since TMA slots start zeroed (meaning 
>>> no second- level handler installed yet)?
>>>
>>> Question 4 — Drain kernel queues before writing second-level handler?
>>>
>>> When |SET_L2_TRAP| is called, user queues are evicted and TLB is 
>>> flushed before writing. After the merge, kernel queue VMIDs also read 
>>> from the same TMA. Should kernel queue work be drained as well before 
>>> writing the second-level handler addresses?
>>>
>>> Thanks,
>>> Srini
>>>
>>


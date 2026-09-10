Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9731BC79FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 06:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0415A10E25E;
	Thu, 10 Sep 2026 06:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wXw9xhXM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011070.outbound.protection.outlook.com
 [40.93.194.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F15A10E25E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 06:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUkm4mlEKCz8Vsy1crvEwpjXvIdqU8cncRKYeprfwdidVBLmUouSfWM+CQycmAMTDWuEnGS2QAH3SMqOAqcPPCoNsOa2Eza7hHKI4mkcXcjiGhbao1HowAUP2dGQbMQVc4DXDqdW27BGZvQI+SbYMrr42saIEias2qIzZqoFh7tIxcxGr233NAQT4jgHae8FCZMamRXitYmHyEpEa2tUi2HLF4Nvv04YBvN46uyn41JegAanIgCZyytcQB4WQLBJ8nlFGOiAcXz75w1+caKmQ66Tx/7MG8fSTEhDGxVlCp2I7dvmFSsoLzEEQOFR+1pRRn64Qobj6Ux7wktFZDjSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4QiAF5ea+GTOgQhhzfAFf4jCHHDwkxfUB5LRbMHxcc=;
 b=qfB7Wb3keb+VYpFuXDOn99IK49oUuUharJNtaI3Re+Be0iTPnFpbPCUMSSIXrYFNvhqxqcrrmM5Q5XBpFUj0dJKmZXQD1EmFTExS1/V9FZZdV97vmNr925cp6qD5ip9B9ubZnevFyCXxUaOlj2EGWRH+/FFIwjPStqvlRvkA9rG55JLdgMHhFQU/pePjJWqxze1WPHTXbjM6keopo14MjDUlV3SoF6XrCGiI/iuR1N3sl5lFi8xFfBW609Sgbkl+QuExsYtb61rQ+pNEa+SmtD9RdfHVXSJFgpUny5Fhy3eCY4cP/FNL7hDZ5bqDqw4jjRsSy3G47yZcgGYdknMx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4QiAF5ea+GTOgQhhzfAFf4jCHHDwkxfUB5LRbMHxcc=;
 b=wXw9xhXMIkmO17HmNCP6EB9HXlab9vzLkhSd6L4/SOroOt7PJnkY2NtFfcAH5TJSXvc7EZ7h7XHsYMLXqnjDjVjW/IfqY8eaFpvKVVLBwlWDcMYuoC87uh7PMNyFs77tMlGfqZHvUS3RQ3wF3uSO3uRWkYAslmAb/p5CV1ZEbK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 06:13:58 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 06:13:58 +0000
Content-Type: multipart/alternative;
 boundary="------------ftkqg99Te2xu6XJnNUgjDTFp"
Message-ID: <8573edf1-9af4-423d-8af8-08ac38f33ab2@amd.com>
Date: Thu, 10 Sep 2026 11:43:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Lijo Lazar <lijo.lazar@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <hakzsam@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <CADnq5_PHEQzUVTqJYzO3mALs9LfK9cAUMQtgi0JEzGvFSZk7Eg@mail.gmail.com>
 <CADnq5_M+tLHSrfXQCxX2+LFq-x8OO1=BG+ou=qq2_Y0VS+b8AA@mail.gmail.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <CADnq5_M+tLHSrfXQCxX2+LFq-x8OO1=BG+ou=qq2_Y0VS+b8AA@mail.gmail.com>
X-ClientProxiedBy: MA5PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::15) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 4257e9ea-86df-4910-6f05-08df0f02b326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|11063799006|56012099006|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QBL2lgemWBEjwJItstm3/dpCZE0DP/ruVT5dqsd1BeE2xMXOPvEADLD2WUU+6Fdy4fdd1m00tpbZtjloOEsTYURuSzIHkrhz6RNkLHEiZ2XN4OTgX9ofzuSuy1xzKwWe37IQLsGIR4lsjGnyla66YORYyTZJHiipa5JSfywzrgUl27e4NyjEgNMq8irUmp7hzkcUNVsYaBcUkpoPIQcmGdli8QAQF9Hb+g0B6uGEyiyy6+MKVNGh4nACABpFgyT1LO9wC7rhUcgiC1irXI4vL0ELTFJZC8MJ+Ugtlvzz0y3mllQwviBJkh4qp8NDqYSgRC182MpKsPv3ifeW3pP/Jopy6Dqrk8/MWXkM9BRMCRf3FoLv09y+iOUtkprhZM9vzUgoDwqqt70+S4yH9QBhdv24udv6yIBrRm6QK86zztxzxOtUpl+8HvKCW0D9INQ7K6+KIjsBUxlI3zAX44aRWQFHhJ0FiIFyasLkQM02IXJcRzwGovstGybh/YY+BZgU+RCQVzgUwdqZTcMbufuqbPKwgrMJgRITyW7PP12lm6VU+sjXBMqis0UuhZYKRUHh/OTwC7Vwzo6fel2EdcvytQzzSv59JOGX363IMy+oYZlh58XlD4ER+Ozohg6XuexnouzQ01DTT9vhlf201JglAFecrmBjVNV5kGZROtY3X44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3dZYkR5RURoZmozdGlreGRhNDY2VDNRWWFnRlR1NzErVUV2Sy9pbHlrcVNp?=
 =?utf-8?B?MXBzWjZocnlZYnAyVGw3bVFPUVg1aDloRzB3SnJWNGE3TGF0M3NnWXpSZGty?=
 =?utf-8?B?alF4T1lhaDduTmJ4UGgzb0VPTUJFTGdtYUo4bHdPTW1RZFpid3ZPS3FaK3ZT?=
 =?utf-8?B?VWZtZlNBMm02Tm9oc09wbVRWbGF2TUhuMGNDaWFEZWZaVEdpcUhuSkUrNnFD?=
 =?utf-8?B?UXVmSk1mTjlxanNXV08ydUZDWlFIR1ZBejBWOUtGeGc2MlBWSThuTVd0ZG9R?=
 =?utf-8?B?cEJXWXRVVzV0ZWVvN08xTndRT2NKZ1VNSzg2VlNNYkE1cno0ZnNRMU9RUDUr?=
 =?utf-8?B?dmVBeUFBNHlzSUhPc3VFTEtzSnBwZHY1ckkrTlpiRXpJZHhXc29uTUR1Uzda?=
 =?utf-8?B?R0ttNUJZWTh2T25jcTR0V1ZjVnBiM3QvdnJ5WlJVZHU3UUZ0L0grYzdkT3ls?=
 =?utf-8?B?bVdlRTN0ckFJNkhodEVWSTdrK2lLSHFtYUhac2RVNDU0ckFCWHMwQ1NCYzJx?=
 =?utf-8?B?SHFvY25LeTIzOW83R2dzRlJUbURERzJscGhLbEthVUZmTVhtdHhnYlF3eW9O?=
 =?utf-8?B?QklnNkVTVVpibVJodkpOMVM1SzhITGxqaDRaWHlzM1B1NVI5SzM1SVNpcVhO?=
 =?utf-8?B?SHFuaUtSZU91bXIrYjlVOGtZTkhqSG1XSWNaaThydHNCQ2szMjFKZUhQcG5T?=
 =?utf-8?B?Y3JoWUF2RGNQcEdhTDdsdHZ0SlcrYmVJeUl1NHRKMjVuOWlJR0o4K3FwMlE0?=
 =?utf-8?B?QnAxNFdTcDJUYWNyL0RlREJQRjBYUkdLQjFDTWxUUmtRc0tFQzJzNi8zcUY3?=
 =?utf-8?B?RlcwVW4xSGNreTJLNUtMQXJLK0VtZWt2eDkyRGlhUjhPbHlaZmZ5Vm0xQjRY?=
 =?utf-8?B?aE9jRG9jZDRabE5HdHFyZldlRmVjSlkxVkw5RnNGZlNwUXMzU1UxVXJ1aUZk?=
 =?utf-8?B?WVdyeDQ4ZlBJRjJxWjBDRGsxQ1paN2lSVGpvTnN5NmRMWVdKQW1TR2lzaFlW?=
 =?utf-8?B?Z29oSEF3Y3FnUHVCRGJSbUw1MkltQ1NoNkJTWm5MNXN5ZzZSM0dISUpBS2Jx?=
 =?utf-8?B?dkRTQ2NzWllEMnJXMlk0ZXRhckJOT3NUQzU3dStmZ29MYlZxZFdWaVhLNXRN?=
 =?utf-8?B?Rlg4UXVKSXdkK20wbkg2NXBnSUUyeXh2eXpxaEo3ZjN6RDd3d1BVNWlPckNh?=
 =?utf-8?B?dTNraHRpNjloWFB1emR2UDZoNEI4dlFmTjd6ZkRDRzNGdUpKU29TSU9pQ3pM?=
 =?utf-8?B?bGJOZEY5RDZhK1pBWEF6L2R4S3lsOWwvZ2c1T2g4OFdRMVRVZWhsS0ttSkVI?=
 =?utf-8?B?OEY0QkpScnRrQ2dLR1VOUzU3MXJESjhLN05YbnhGMnU0cHRPM0d5RHdkNHNV?=
 =?utf-8?B?bXkrSHNWQTdvVmZXakwzbDFkT0tmcU1ySkxqckQ3aDYvTlBHc0ZJSDBUM2F3?=
 =?utf-8?B?angyc0JtRmhCTUNJR0o2azV0aXJEOHBGRHo3NXNsQkpId3pXQ0RIa1A5S3Fi?=
 =?utf-8?B?S21pZ3h4ZWI0Q1lFaXVORTNvN2RWazJPT0FEdGllWXVNcHhoQ1htUmRERDBS?=
 =?utf-8?B?ZFByZHF4R3Q1bmlNOWdJRUF2ZUFnalNPV21HOEEwSjJEZi9YLzBFTEN0VDhZ?=
 =?utf-8?B?TkhUVWF5T1BRbGErZ0RQbnc2bVF0VVFWOXhKUEMxRjlCb2E5Y3RWdzdLK2FJ?=
 =?utf-8?B?WlFDcklaV1A1Q0wwclREZjd6cEFGR2tPd3dJUmhKMWFlK05JUDFYbDdyT2JG?=
 =?utf-8?B?eXRyUU1XaEQvZGZWTHFOb2VNT1lVZ01ncUpxM0F4alRLQlc5djl0bFIzREpE?=
 =?utf-8?B?NHFhd0N5cmQxYTZxQi9UeTV3UTdWWWZjT1pNMzd0emU4QkNIaEUxcE1SaTVR?=
 =?utf-8?B?bkFYVk9aNENJNW5Gd1EwRzhUTVQxUUMrSndjSGZLbEFiN2lWb2x6VVN4S2tt?=
 =?utf-8?B?alZVb1VuSTFDZklQWVoyQlRrQlQvNTNIWXl3YTc0SzRBT3dWUlJMR2c0Zzg5?=
 =?utf-8?B?QzJNa3V3OFRhZzVKMFlFSm5neks1MWtuZFZWRDJ5L2N4ZU1lR0JrODMvYk1F?=
 =?utf-8?B?WU4wK0FDbUwrTlh1MFdXUW43NHUvUW5Oc3Yvd2RxVzVVdCtTdkk5MUY4bEE5?=
 =?utf-8?B?Smxja0p3V1UvakQxSjN1bWphT3dMbmV2cEpkSWFwTjlLd3lKeXUxYU9yM3dS?=
 =?utf-8?B?Qm1vemhZQmV3RjJSWUVMUFh5NUZXM3hZUllpZnZ2QVZ5eTI1QnplL0VjR0cv?=
 =?utf-8?B?NEZNWnhldllHeWlldVRVVWpibnBzeWlvWkVURG1xeWZFdGlHMWtMcWlqYkJs?=
 =?utf-8?Q?hbmmhXh36SK+l1vafz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4257e9ea-86df-4910-6f05-08df0f02b326
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 06:13:58.4067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECZvdvHdGsIbQ8cDVsHzjL6yRT+cO/KbOovm02HcdpyCKU1wfJGh5RrO97oRU1O4w7xUo811Lc8PYGqo8sd3BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
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

--------------ftkqg99Te2xu6XJnNUgjDTFp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/10/2026 2:20 AM, Alex Deucher wrote:
> On Wed, Sep 9, 2026 at 4:42 PM Alex Deucher<alexdeucher@gmail.com> wrote:
>> On Sat, Sep 5, 2026 at 4:55 AM Srinivasan Shanmugam
>> <srinivasan.shanmugam@amd.com> wrote:
>>> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
>>> SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
>>> via ADD_QUEUE with map_legacy_kq=1 but does not set trap handler state.
>>> On GFX10 and earlier HWS-based hardware, the driver programs trap
>>> registers via SRBM select for KFD queues but no equivalent exists for
>>> driver-managed kernel queue VMIDs.
>>>
>>> Add a vmhub callback program_kernel_trap_vmids() so each gfxhub version
>>> can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
>>> device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
>>> address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its own kq_tma_bo
>>> there, so per-VM isolation is handled entirely by page tables without
>>> needing to reprogram the register per job or per submission.
>>>
>>> The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
>>> (parallel to page table allocation) and mapped read-only into the GPU VM
>>> at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-level
>>> handler address into it via kq_tma_map when userspace calls SET_L2_TRAP.
>>> The first-level CWSR handler reads this address to chain to the
>>> second-level handler when a shader exception fires.
>>>
>>> This design is:
>>>    - Per-VM BO (not device-level) — same model as page tables
>>>    - Fixed VA in each VM's address space — same VA, different physical BO
>>>    - Read-only from GPU — kernel CPU updates it via CPU mapping
>>>    - Treat allocation/free lifecycle identical to page tables
>>>
>>> Suggested-by: Christian König<christian.koenig@amd.com>
>>> Suggested-by: Alexander Deucher<alexander.deucher@amd.com>
>>> Cc: Lijo Lazar<lijo.lazar@amd.com>
>>> Cc: Timur Kristóf<timur.kristof@gmail.com>
>>> Cc: Samuel Pitoiset<hakzsam@gmail.com>
>>> Cc: Natalie Vock<natalie.vock@gmx.de>
>>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>>> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
>>>   5 files changed, 110 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> index 3ca187f5ade8..5624a5ab5c62 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>>>          void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
>>>                                                   uint32_t status);
>>>          uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_type);
>>> +       void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>>>   };
>>>
>>>   struct amdgpu_vmhub {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> index 623cac6781be..e913488ca3fa 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>>>
>>>          amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>>>          adev->trap_info = no_free_ptr(trap_info);
>>> +       amdgpu_trap_program_kernel_vmids(adev);
>>>
>>>          return 0;
>>>   }
>>> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
>>>          adev->trap_info = NULL;
>>>   }
>>>
>>> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
>>> +{
>>> +       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>>> +
>>> +       if (!amdgpu_trap_is_enabled(adev))
>>> +               return;
>>> +       if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap_vmids)
>>> +               return;
>>> +
>>> +       hub->vmhub_funcs->program_kernel_trap_vmids(adev);
>>> +}
>>> +
>>> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
>>> +                               struct amdgpu_vm *vm)
>>> +{
>>> +       void *cpu_addr;
>>> +       uint64_t va;
>>> +       int r;
>>> +
>>> +       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>> +
>>> +       r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
>>> +                                   AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_bo,
>>> +                                   NULL, &cpu_addr);
>>> +       if (r)
>>> +               return r;
>>> +
>>> +       if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>>> +               iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
>>> +                                         (void __iomem *)cpu_addr);
>>> +       else
>>> +               iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
>>> +
>>> +       vm->kq_tma_va = amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
>>> +       if (!vm->kq_tma_va) {
>>> +               r = -ENOMEM;
>>> +               goto err_free_bo;
>>> +       }
>>> +
>>> +       va = AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;
>>> +       r = amdgpu_vm_bo_map(adev, vm->kq_tma_va, va, 0,
>>> +                            AMDGPU_GPU_PAGE_SIZE,
>>> +                            AMDGPU_VM_PAGE_READABLE);
>>> +       if (r)
>>> +               goto err_del_va;
>>> +
>>> +       r = amdgpu_vm_bo_update(adev, vm->kq_tma_va, false);
>>> +       if (r)
>>> +               goto err_del_va;
>>> +
>>> +       return 0;
>>> +
>>> +err_del_va:
>>> +       amdgpu_vm_bo_del(adev, vm->kq_tma_va);
>>> +       vm->kq_tma_va = NULL;
>>> +err_free_bo:
>>> +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
>>> +       return r;
>>> +}
>>> +
>>> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
>>> +                               struct amdgpu_vm *vm)
>>> +{
>>> +       uint64_t va;
>>> +
>>> +       if (!vm->kq_tma_bo)
>>> +               return;
>>> +
>>> +       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>> +
>>> +       if (vm->kq_tma_va) {
>>> +               va = AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;
>>> +               amdgpu_vm_bo_unmap(adev, vm->kq_tma_va, va);
>>> +               amdgpu_vm_bo_del(adev, vm->kq_tma_va);
>>> +               vm->kq_tma_va = NULL;
>>> +       }
>>> +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
>>> +}
>>> +
>>>   static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>>>                                    struct amdgpu_vm *vm,
>>>                                    struct amdgpu_trap_obj *cwsr,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>> index 7f83174a4742..9be5035abd1c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>> @@ -155,4 +155,11 @@ int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
>>>                                      struct amdgpu_trap_obj *cwsr_obj,
>>>                                      bool enabled);
>>>
>>> +/* Kernel queue trap handler — per-VM TMA and register programming */
>>> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
>>> +int  amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
>>> +                                struct amdgpu_vm *vm);
>>> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
>>> +                               struct amdgpu_vm *vm);
>>> +
>>>   #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index de3ef9ce2234..f5e228d4bfb5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2640,6 +2640,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>          if (r)
>>>                  goto error_free_root;
>>>
>>> +       if (amdgpu_trap_is_enabled(adev)) {
>>> +               r = amdgpu_trap_vm_kq_tma_alloc(adev, vm);
>>> +               if (r)
>>> +                       goto error_free_root;
>>> +       }
>>> +
>>>          r = amdgpu_vm_create_task_info(vm);
>>>          if (r)
>>>                  dev_dbg(adev->dev, "Failed to create task info for VM\n");
>>> @@ -2774,6 +2780,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>                  amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>>>          }
>>>
>>> +       if (vm->kq_tma_bo)
>>> +               amdgpu_trap_vm_kq_tma_free(adev, vm);
>>> +
>>>          amdgpu_vm_pt_free_root(adev, vm);
>>>          amdgpu_bo_unreserve(root);
>>>          amdgpu_bo_unref(&root);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index dd825e179979..064f95a83790 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -25,6 +25,7 @@
>>>   #define __AMDGPU_VM_H__
>>>
>>>   #include <linux/idr.h>
>>> +#include <linux/iosys-map.h>
>>>   #include <linux/kfifo.h>
>>>   #include <linux/rbtree.h>
>>>   #include <drm/gpu_scheduler.h>
>>> @@ -488,6 +489,18 @@ struct amdgpu_vm {
>>>
>>>          /* cached fault info */
>>>          struct amdgpu_vm_fault_info fault_info;
>>> +
>>> +       /*
>>> +        * Per-VM kernel queue first-level TMA BO.
>>> +        * Allocated at VM init, freed at VM fini — same lifecycle as page tables.
>>> +        * Mapped read-only at AMDGPU_VA_RESERVED_TRAP_START in the GPU VM.
>>> +        * SQ_SHADER_TMA for all kernel VMIDs points to this fixed VA; per-VM
>>> +        * isolation is via page tables mapping different physical BOs there.
>>> +        * CPU kernel writes second-level handler address via kq_tma_map.
>>> +        */
>>> +       struct amdgpu_bo        *kq_tma_bo;
>>> +       struct amdgpu_bo_va     *kq_tma_va;
>>> +       struct iosys_map         kq_tma_map;
>> These should be the same for both user and kernel queues.  The only
>> difference is who manages the vmids (driver vs MES).  They are per
>> vmid so it doesn't matter whether it's a kernel queue or user queue.
>>
> I would merge these patch sets.  The trap handling is the same for
> both kernel queues and user queues.  The only difference for kernel
> queues is that the driver has to set the TBA/TMA registers while
> MES/KIQ handles it for user queues.  At vm_init time, allocate the
> memory for the trap handler, copy the trap handler to the memory and
> add the mapping to the GPUVM address space.  Then in gfxhub init,
> program the TBA/TMA registers for the kernel managed vmids.  Finally,
> add the IOCTL to set/clear the second level trap handler and validate
> the user supplied GPU VA.

Hi Alex,

Thank you for the review. I have few questions before proceeding with 
the implementation.

I looked at how KFD handles this today in |kfd_process.c|:

/* KFD writes second-level TBA/TMA into first-level TMA */
iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
              uint64_t, tba_addr);
iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
              uint64_t, tma_addr);

Where |KFD_CWSR_TMA_OFFSET = AMDGPU_GPU_PAGE_SIZE + 2048 = 0x1800|. KFD 
uses physical GPU addresses for TBA/TMA registers, not VM virtual addresses.

Question 1 — Which fixed GPU virtual address for the merged buffer?

KFD uses physical addresses for the TBA/TMA registers. Our design maps 
the buffer into each VM at a fixed virtual address for page table 
isolation. Should the merged per-VM buffer use 
|AMDGPU_VA_RESERVED_TRAP_UQ_START| as the fixed VA? Or a different address?

Question 2 — TMA offset inside the merged buffer — 0x1800 or 0x2000?

KFD places the TMA section at offset |0x1800| from the TBA start 
(|KFD_CWSR_TMA_OFFSET|). The current UQ design uses offset |0x2000| 
(|AMDGPU_TRAP_TBA_MAX_SIZE|). After merging into one per-VM buffer, 
should TMA start at |0x1800| to match KFD's layout?

Question 3 — When should TRAP_EN be set?

When programming |SQ_SHADER_TBA_HI| for kernel VMIDs, should |TRAP_EN| 
be set only after the per-VM buffer is fully mapped? Or is it safe to 
set it at boot time since TMA slots start zeroed (meaning no 
second-level handler installed yet)?

Question 4 — Drain kernel queues before writing second-level handler?

When |SET_L2_TRAP| is called, user queues are evicted and TLB is flushed 
before writing. After the merge, kernel queue VMIDs also read from the 
same TMA. Should kernel queue work be drained as well before writing the 
second-level handler addresses?

Thanks,
Srini

--------------ftkqg99Te2xu6XJnNUgjDTFp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/10/2026 2:20 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_M+tLHSrfXQCxX2+LFq-x8OO1=BG+ou=qq2_Y0VS+b8AA@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Wed, Sep 9, 2026 at 4:42 PM Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On Sat, Sep 5, 2026 at 4:55 AM Srinivasan Shanmugam
<a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
via ADD_QUEUE with map_legacy_kq=1 but does not set trap handler state.
On GFX10 and earlier HWS-based hardware, the driver programs trap
registers via SRBM select for KFD queues but no equivalent exists for
driver-managed kernel queue VMIDs.

Add a vmhub callback program_kernel_trap_vmids() so each gfxhub version
can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its own kq_tma_bo
there, so per-VM isolation is handled entirely by page tables without
needing to reprogram the register per job or per submission.

The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
(parallel to page table allocation) and mapped read-only into the GPU VM
at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-level
handler address into it via kq_tma_map when userspace calls SET_L2_TRAP.
The first-level CWSR handler reads this address to chain to the
second-level handler when a shader exception fires.

This design is:
  - Per-VM BO (not device-level) — same model as page tables
  - Fixed VA in each VM's address space — same VA, different physical BO
  - Read-only from GPU — kernel CPU updates it via CPU mapping
  - Treat allocation/free lifecycle identical to page tables

Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Suggested-by: Alexander Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>
Cc: Timur Kristóf <a class="moz-txt-link-rfc2396E" href="mailto:timur.kristof@gmail.com">&lt;timur.kristof@gmail.com&gt;</a>
Cc: Samuel Pitoiset <a class="moz-txt-link-rfc2396E" href="mailto:hakzsam@gmail.com">&lt;hakzsam@gmail.com&gt;</a>
Cc: Natalie Vock <a class="moz-txt-link-rfc2396E" href="mailto:natalie.vock@gmx.de">&lt;natalie.vock@gmx.de&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
 5 files changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 3ca187f5ade8..5624a5ab5c62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
        void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
                                                 uint32_t status);
        uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_type);
+       void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
 };

 struct amdgpu_vmhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 623cac6781be..e913488ca3fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)

        amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
        adev-&gt;trap_info = no_free_ptr(trap_info);
+       amdgpu_trap_program_kernel_vmids(adev);

        return 0;
 }
@@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
        adev-&gt;trap_info = NULL;
 }

+void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
+{
+       struct amdgpu_vmhub *hub = &amp;adev-&gt;vmhub[AMDGPU_GFXHUB(0)];
+
+       if (!amdgpu_trap_is_enabled(adev))
+               return;
+       if (!hub-&gt;vmhub_funcs || !hub-&gt;vmhub_funcs-&gt;program_kernel_trap_vmids)
+               return;
+
+       hub-&gt;vmhub_funcs-&gt;program_kernel_trap_vmids(adev);
+}
+
+int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
+                               struct amdgpu_vm *vm)
+{
+       void *cpu_addr;
+       uint64_t va;
+       int r;
+
+       dma_resv_assert_held(vm-&gt;root.bo-&gt;tbo.base.resv);
+
+       r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
+                                   AMDGPU_GEM_DOMAIN_GTT, &amp;vm-&gt;kq_tma_bo,
+                                   NULL, &amp;cpu_addr);
+       if (r)
+               return r;
+
+       if (vm-&gt;kq_tma_bo-&gt;kmap.bo_kmap_type &amp; TTM_BO_MAP_IOMEM_MASK)
+               iosys_map_set_vaddr_iomem(&amp;vm-&gt;kq_tma_map,
+                                         (void __iomem *)cpu_addr);
+       else
+               iosys_map_set_vaddr(&amp;vm-&gt;kq_tma_map, cpu_addr);
+
+       vm-&gt;kq_tma_va = amdgpu_vm_bo_add(adev, vm, vm-&gt;kq_tma_bo);
+       if (!vm-&gt;kq_tma_va) {
+               r = -ENOMEM;
+               goto err_free_bo;
+       }
+
+       va = AMDGPU_VA_RESERVED_TRAP_START(adev) &amp; AMDGPU_GMC_HOLE_MASK;
+       r = amdgpu_vm_bo_map(adev, vm-&gt;kq_tma_va, va, 0,
+                            AMDGPU_GPU_PAGE_SIZE,
+                            AMDGPU_VM_PAGE_READABLE);
+       if (r)
+               goto err_del_va;
+
+       r = amdgpu_vm_bo_update(adev, vm-&gt;kq_tma_va, false);
+       if (r)
+               goto err_del_va;
+
+       return 0;
+
+err_del_va:
+       amdgpu_vm_bo_del(adev, vm-&gt;kq_tma_va);
+       vm-&gt;kq_tma_va = NULL;
+err_free_bo:
+       amdgpu_bo_free_kernel(&amp;vm-&gt;kq_tma_bo, NULL, NULL);
+       return r;
+}
+
+void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
+                               struct amdgpu_vm *vm)
+{
+       uint64_t va;
+
+       if (!vm-&gt;kq_tma_bo)
+               return;
+
+       dma_resv_assert_held(vm-&gt;root.bo-&gt;tbo.base.resv);
+
+       if (vm-&gt;kq_tma_va) {
+               va = AMDGPU_VA_RESERVED_TRAP_START(adev) &amp; AMDGPU_GMC_HOLE_MASK;
+               amdgpu_vm_bo_unmap(adev, vm-&gt;kq_tma_va, va);
+               amdgpu_vm_bo_del(adev, vm-&gt;kq_tma_va);
+               vm-&gt;kq_tma_va = NULL;
+       }
+       amdgpu_bo_free_kernel(&amp;vm-&gt;kq_tma_bo, NULL, NULL);
+}
+
 static int amdgpu_trap_map_region(struct amdgpu_device *adev,
                                  struct amdgpu_vm *vm,
                                  struct amdgpu_trap_obj *cwsr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 7f83174a4742..9be5035abd1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -155,4 +155,11 @@ int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
                                    struct amdgpu_trap_obj *cwsr_obj,
                                    bool enabled);

+/* Kernel queue trap handler — per-VM TMA and register programming */
+void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
+int  amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
+                                struct amdgpu_vm *vm);
+void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
+                               struct amdgpu_vm *vm);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index de3ef9ce2234..f5e228d4bfb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2640,6 +2640,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
        if (r)
                goto error_free_root;

+       if (amdgpu_trap_is_enabled(adev)) {
+               r = amdgpu_trap_vm_kq_tma_alloc(adev, vm);
+               if (r)
+                       goto error_free_root;
+       }
+
        r = amdgpu_vm_create_task_info(vm);
        if (r)
                dev_dbg(adev-&gt;dev, &quot;Failed to create task info for VM\n&quot;);
@@ -2774,6 +2780,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
                amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
        }

+       if (vm-&gt;kq_tma_bo)
+               amdgpu_trap_vm_kq_tma_free(adev, vm);
+
        amdgpu_vm_pt_free_root(adev, vm);
        amdgpu_bo_unreserve(root);
        amdgpu_bo_unref(&amp;root);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index dd825e179979..064f95a83790 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -25,6 +25,7 @@
 #define __AMDGPU_VM_H__

 #include &lt;linux/idr.h&gt;
+#include &lt;linux/iosys-map.h&gt;
 #include &lt;linux/kfifo.h&gt;
 #include &lt;linux/rbtree.h&gt;
 #include &lt;drm/gpu_scheduler.h&gt;
@@ -488,6 +489,18 @@ struct amdgpu_vm {

        /* cached fault info */
        struct amdgpu_vm_fault_info fault_info;
+
+       /*
+        * Per-VM kernel queue first-level TMA BO.
+        * Allocated at VM init, freed at VM fini — same lifecycle as page tables.
+        * Mapped read-only at AMDGPU_VA_RESERVED_TRAP_START in the GPU VM.
+        * SQ_SHADER_TMA for all kernel VMIDs points to this fixed VA; per-VM
+        * isolation is via page tables mapping different physical BOs there.
+        * CPU kernel writes second-level handler address via kq_tma_map.
+        */
+       struct amdgpu_bo        *kq_tma_bo;
+       struct amdgpu_bo_va     *kq_tma_va;
+       struct iosys_map         kq_tma_map;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
These should be the same for both user and kernel queues.  The only
difference is who manages the vmids (driver vs MES).  They are per
vmid so it doesn't matter whether it's a kernel queue or user queue.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I would merge these patch sets.  The trap handling is the same for
both kernel queues and user queues.  The only difference for kernel
queues is that the driver has to set the TBA/TMA registers while
MES/KIQ handles it for user queues.  At vm_init time, allocate the
memory for the trap handler, copy the trap handler to the memory and
add the mapping to the GPUVM address space.  Then in gfxhub init,
program the TBA/TMA registers for the kernel managed vmids.  Finally,
add the IOCTL to set/clear the second level trap handler and validate
the user supplied GPU VA.</pre>
    </blockquote>
    <p dir="ltr">Hi Alex,</p>
    <p dir="ltr">Thank you for the review. I have few questions before
      proceeding with the implementation.</p>
    <p dir="ltr">I looked at how KFD handles this today in <code>kfd_process.c</code>:</p>
    <div>
      <div style="">
        <div>
          <div style="">
            <pre>/* KFD writes second-level TBA/TMA into first-level TMA */
iosys_map_wr(&amp;qpd-&gt;cwsr_map, KFD_CWSR_TMA_OFFSET,
             uint64_t, tba_addr);
iosys_map_wr(&amp;qpd-&gt;cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
             uint64_t, tma_addr);</pre>
          </div>
          <div>
            <div></div>
          </div>
        </div>
      </div>
    </div>
    <p dir="ltr">Where <code>KFD_CWSR_TMA_OFFSET = AMDGPU_GPU_PAGE_SIZE
        + 2048 = 0x1800</code>. KFD uses physical GPU addresses for
      TBA/TMA registers, not VM virtual addresses.</p>
    <p dir="ltr">Question 1 — Which fixed GPU virtual address for the
      merged buffer?</p>
    <p dir="ltr">KFD uses physical addresses for the TBA/TMA registers.
      Our design maps the buffer into each VM at a fixed virtual address
      for page table isolation. Should the merged per-VM buffer use <code>AMDGPU_VA_RESERVED_TRAP_UQ_START</code>
      as the fixed VA? Or a different address?</p>
    <p dir="ltr">Question 2 — TMA offset inside the merged buffer —
      0x1800 or 0x2000?</p>
    <p dir="ltr">KFD places the TMA section at offset <code>0x1800</code>
      from the TBA start (<code>KFD_CWSR_TMA_OFFSET</code>). The current
      UQ design uses offset <code>0x2000</code> (<code>AMDGPU_TRAP_TBA_MAX_SIZE</code>).
      After merging into one per-VM buffer, should TMA start at <code>0x1800</code>
      to match KFD's layout?</p>
    <p dir="ltr">Question 3 — When should TRAP_EN be set?</p>
    <p dir="ltr">When programming <code>SQ_SHADER_TBA_HI</code> for
      kernel VMIDs, should <code>TRAP_EN</code> be set only after the
      per-VM buffer is fully mapped? Or is it safe to set it at boot
      time since TMA slots start zeroed (meaning no second-level handler
      installed yet)?</p>
    <p dir="ltr">Question 4 — Drain kernel queues before writing
      second-level handler?</p>
    <p dir="ltr">When <code>SET_L2_TRAP</code> is called, user queues
      are evicted and TLB is flushed before writing. After the merge,
      kernel queue VMIDs also read from the same TMA. Should kernel
      queue work be drained as well before writing the second-level
      handler addresses?</p>
    <p dir="ltr">Thanks,<br>
      Srini</p>
    <blockquote type="cite" cite="mid:CADnq5_M+tLHSrfXQCxX2+LFq-x8OO1=BG+ou=qq2_Y0VS+b8AA@mail.gmail.com">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------ftkqg99Te2xu6XJnNUgjDTFp--

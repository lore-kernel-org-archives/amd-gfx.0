Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EA0C79F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 09:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFAF10F3D5;
	Thu, 10 Sep 2026 09:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GlxRqBl4";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD4E10F3D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 09:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdH+5IecSK6W98x+wloCulklEc415GIPA2OtIG3Qwn1orGY9kJi4yGnxLYClDDrchejt7E6AUgoMrrb2X6/1obPkdPJ0w+BbifHlDLWEhpwbBxAzfxXvjEs4L1Ly10CbQYoepFyscGWbzEn6o/3URcf4WouTOumECHb8b+7bPUmbtQmx6ZKrRyiRx/ePLqgJNSYJGz6VqXlxdR4gCZ9FM99T1Ilc4SXmnQEcwTGgGDDgIDWDSpTQNK4HXab+luHE0ylqrBMora6SXR7VxF9QoHWEIMYpHYQ13t9avh7zRO+EsyRMgkU5TI0pq5MeXBuMvLNgI+qa1io5xdkG/oxr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wdotylg0zmi9F9LMkM0FJDo/zEgdeCEtGTYqp291agE=;
 b=jWq+E+cWhTtuzSFY60tRTWZr9wbtIBmdkNjxtr7K/udThjkiG6OxI7zqnP1bK0kmQVN6CRnvSedQLEjL5/S7J1Lbwz1Y/TRxqSPy77y7ui6PbBXNz6sSUrF3GNW4hAW5h4k2PI0TW0kHNkCczQz3dV3kKR5qi34GnaOdFSUgloq/zpKN/cu2rAiKEy5Kevaa1lb64Cx1AHeWyC6pWoJHjJTsRNQvYTVEBdU0CAWi9F0dAS6YY4A9O9ktItoTHrddakfWmnq75SNCTYFnNyes66jIkIuLCnsmpAT0qrFp6eJDRnUL5VTVY3ujXXucLs946fdc+ZKI8vEIMaKV3qKSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wdotylg0zmi9F9LMkM0FJDo/zEgdeCEtGTYqp291agE=;
 b=GlxRqBl43xFjI1p8Nd5KuejfwA0+aK4lV6sL5FVYFQH42EKWkauFOwuDpGVjlZvTkWfzSK+VbMTXtWazoc5sBl6pEvODIXHq0DO1d4iByqKRxA0+HB+3H3qwpk8b5Qja2VZ6UiBWyOqgloq33M0Nu5TQA4x7PDJe1Nrsw2/2AGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Thu, 10 Sep
 2026 09:43:31 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 09:43:31 +0000
Message-ID: <c2c68c1b-32af-4f67-bb73-a283619aca16@amd.com>
Date: Thu, 10 Sep 2026 15:13:25 +0530
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
X-ClientProxiedBy: MA5P287CA0301.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5a751b-7836-407e-b67d-08df0f1ff979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|6133799003|3023799007|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0TOHSYfLn843jbz5QaNbX6QtTMJXPtBy8ufmEJIuE3Z2S7urSw5O5beawWTTy9xAJxULJc0dVIf/qODlPkEa9rHJ4CsG0UEeD2rnmFVdjApDyInkvxi7V+5bZYsaSSfEEYN98MXU5zaykIQvXPmqu/dfe/p+dSiNNythZ3DPLNcbXa3jWf2YHFNzNtYJSARbmwqy/WHYXZhUhBZqzMoz0pWtPwp5um/zCjLBDyfqNLB8K9I4noyAg/a75UAjh1Mve8uUHsdegijDLEP2uNz3YsXpjL1t7tVOF3DRRuYu9y4y99z7H+xP7O3Yv8l4uhsYZT74mkf5hOPeKaFkF7xfYfguu0n2bLqZ8dX2YmtGTPpTjnWI6jiPOihpWTwQTsZzcM4gt6O8Lc8yN3G6LOR5qN/YBOEwthxbl/3UEnhneyd2LmTsomzREy2iP2hxDNTX6XZzB2krdflVC2REaQxwvCrL+NcodXjAoLCp5toeJm6xgsqft4XJLIwswgNAOBr8B+XmHlmLSSw6oOoKj4zHMZAr5wM6c6/1WP9DO5gCSR/v9jJ0XEZJ4Gp9iZpFIk/i8b3iPuMAiKaEYbfsljz1M5fQeiU4i8+uboawnoWFLN0aDnt+DEi1rlNY57alqpsHeA9nUS9zJfiq9RF8vlk5WyeeVvG5RBmkep1Gy75MqPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzMrMmJrZ2pMM1dMMGZZRFlobWNCUUs2VEY3YTQwZktXVThBWnVnOHgrQTFw?=
 =?utf-8?B?c2M4UUNLeTJaMEt2NDNkT2swZ2h1RDFsb2E3ZW42SlJjdHoxSm4xVFF0VDl5?=
 =?utf-8?B?dW8xWE40eVN0dWE2YjVqaTR2Uk1MSDdyWUt0ZnZnRVBHWWhFMGc0dExqaC9Q?=
 =?utf-8?B?OHRNZGI2RUwvRGdpODloU1hwKzBFZ09nYU1jSjdad2JzYzJpcy9YY0pNSWpJ?=
 =?utf-8?B?eUFqN1RkK1U4NnIvQVZIY3VYMkJZM2hwSHBsQUVoaERkVzJvVDBMSlpxQmZD?=
 =?utf-8?B?M1R0ZEZyUlhUaldKQzFCY3FHTVRUZUx0NWtqeFByWWtQNmtlc08xR2gxL3Z3?=
 =?utf-8?B?bVBiMi9yOG5hSzBKS3I2QXhJL3AxVkVqZWVHajV5SU1CQTNPQWdhU2J4azZZ?=
 =?utf-8?B?SEhrUmIyaFVTMlh5RkRlVFVXcEJrdTlMUGNuOVZJdHNFV05EelI1ak1LSWlF?=
 =?utf-8?B?ekxUOU4yd1B6ODdqZzVvUVJKOUsyU05vTldGeERxN0hPZkZQb1RMZEhoa3Q0?=
 =?utf-8?B?NGFndmJpLzhIVkFudFZmL3pGU3FUd3ppcXMwRElSWCtWWUZHL2EzQVlGakZr?=
 =?utf-8?B?eXB4MXRhVUlkazBteDZ2SG9HVjR0NTVKSkV0d0VXZU8wTnd2YzhsZ2VwYUh0?=
 =?utf-8?B?OXdDTkowdVFSakQ5aXIwNnRuMWNwdDdWd21VcFUwOUp5OVV5Zm1sSGpwL0Z2?=
 =?utf-8?B?OE40MUxheG8yTWNuZEZRdzJZMFp6ZHVRS25EckFEcUtPYzBpa08xSDF3Ykpx?=
 =?utf-8?B?QVZNTWVmeTZ6aFJFY2xTejJ4WXJjNG9NUktPbHRHc2tkaDdDWUtBZ1A5aU1Y?=
 =?utf-8?B?Zkg5YU1FUEJWbjViU3lqb1RDTzNPdFo1L1VFSGNLZmNjbWZxbFlHK1lDTHZI?=
 =?utf-8?B?eGtMNkxPTmVpNDd0NElqZU15STlseXZ5alU1NUpZeWtzQkFXQlV0T1B6bFVR?=
 =?utf-8?B?djVOSm9meE5nanUxeG5walZ1VlVXYzlSS1FtQm1kdmVPQVZkc1FucEJyU28w?=
 =?utf-8?B?MHluWXd3UFR1b3h2TkxQUjg3LytPaHdTZHZIUGNUeWkrVWFHQVlnYTU2L0VH?=
 =?utf-8?B?ektaOXFJb0JTczNXelNwa2JjRWwwdWVrakZ5WGJoSzJMQ3dJdk1aOUNPaURs?=
 =?utf-8?B?bnB3d2xVZmFYOG85S3krcmswdC9ZS1ZwM0JhK24xK280SnpWTWdnYkgrMEMy?=
 =?utf-8?B?ZGVqbkJFeGNzWEpPZm9ic1BYdS92QmF1SUVveU50Vy9NdFFWaUh2d0QrUUIr?=
 =?utf-8?B?SlV5d1RTN0xnck5hU3h0K2Y1ZTI1WmU2QjJHVWVNV3dnMnJ3Z1dsSStUNlo2?=
 =?utf-8?B?SE9jQlJmK1oxY2E3R0FKY1BjaUh2SHpYdG1rQlREcWo5NWhsdDZaejhEUkMx?=
 =?utf-8?B?eUROakkvNlhmT2Y4VkYzZGcxTFY1WHEwL3pDMFBac0c2MjRFa3RFbHVLLzBu?=
 =?utf-8?B?RzB4RFgwb21BUXNpQXo5RGxTK1VNcnRucnpFS1ZpUCtIcHZqUEZPN01jUU5W?=
 =?utf-8?B?NEJheFozc2crU1E1N1NOcmt4UUVTZVBMZG80a2xzVXFnaGZTWjl1cGFsaGtw?=
 =?utf-8?B?MnFSSy83OUJBaHNIOGFiV0xUeGYxcHB2Y1l4ZFV0QlhPYTQxaHJYRHRTWXJJ?=
 =?utf-8?B?T3NsZlZWRE9iRm1mRXE3OTliNXkxMmdlMENTblVLUnhOVlRuVlFHaGJQcm9j?=
 =?utf-8?B?NTdaNXFVWkVhV2pSbmJQQlVNL09ES0c4cWw0MzF2RkZhZzZsYk5ILzU5bkgz?=
 =?utf-8?B?RHNsTnp0SVhTS3AvTGUzaUV3bVVoK3dLd3AyVS94TzBkVS9LMnh6alVFYkNF?=
 =?utf-8?B?ZExpaWNWN1ZjYUhRSmx0WVlxVjA0M2dlbWRXVDdVdkZuSHAvcEY5b2lwSFR0?=
 =?utf-8?B?Q3VjL0RpTm9ETVE3bWl5Y1M1QUNSNlRwcXhyZGxRaWV6YTVUME5FYzVucG92?=
 =?utf-8?B?Mm9kTHJieGFmQ0luRkdQSDl3Y3BseGo2ajh1NUFkQTJTR0h2bTJvQnNvSlBr?=
 =?utf-8?B?azVTT1loZUtMaUZDMjZzMmowSDc1bndBVnFxSDNVZ1Fxa0tMdWtZYnlYcHNE?=
 =?utf-8?B?ZEVibE5MU1lEZWdlODVMMDNWN2svUldjSEpvczUvUVhiUmxlL29SeDk1OXp0?=
 =?utf-8?B?SlRzdTAzSWQ5RTNwUnlQTE5Hb3JBWnpFQm1CRFk2NUsveG85ZkhnZTgwWHVG?=
 =?utf-8?B?N28xR0VRcm1YdkxFYU5kT044L21rWFRqSmI4TVNOYmxSUXN5bUM4WVJlNC9T?=
 =?utf-8?B?d2JuTnpubUtVTHFUMzNPdUZ6cWhtcWlwQ0Ezam5OVFlKd3BuU0V2Sk1INGxX?=
 =?utf-8?B?RWVMeVhHTE95WGJpKzVVenhSZFBsL05sMHRFbzc4RlV4eXZsQ1ZIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5a751b-7836-407e-b67d-08df0f1ff979
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 09:43:31.5042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCxNoCsHxwtKAakKBMuhwQ+4QBN3cqbbZtGLIUinhyEgaWreVAkdkMpvdWtM2tzo
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

For clarification, this is the existing implementation in amdgpu_cwsr.

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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A64C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 06:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B4C10E2C4;
	Tue, 24 May 2022 06:42:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C1E10E2C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 06:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjekGHMAFiR8d6iRF9MBksaox0zfBS/bZEtOclGpX9wz9/2nt4zuzWihoAvU4CuQZV6mDOfBL9sAuziC8b9S54btg0z38yEZfxgI4npGDrzIhs3cTYYo78Zyy6bLIoICA7D/utQrm7QPLWa6N1RVmIa687Ck24xolYTzM9MLYKextLQLuMrjVT5oMcPghlZw4Jcv46mqhysLHUY4oDuayvrod+6O9r2h95p4D8YpPjOBxo2F/aAPogmBhj6pjv5Ak+x1KtX21MeKcpPbvJqyePuSP9jPZJ6TAJQ047m8YAXNAJv+V6RHKWZi7BaiDZCKn6o3EFNlESFnPge4QuyF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rN3S/C9bdzw2dUmfoVW2sRqtw6l0OChm2z8MurLG/c=;
 b=ATZ/vZm+YszsXJ8uhziM9ZUI/cUEkcyiUgP1kX2/9iqEkI+bKcOGbq4bGm4Z3TgmRfmb53OoI1CZRUUZOsWA/ZFZvmJ2c7gN/wso1CxM8Ex1Laf6PHAyK8w6OqXcn7NnmM4nuT6ZtLydUpn9ykyIjtQkHVQGwcIC4FTqYxw2EkfLJhSx28E9TjNsj0Bdp28RLqbTYMQbpsp18ayg8tXdfps5oW9a7KTkcvI9onBsvRyRzIYBjkvuXrzQAFIZJjQgsN1n4o4iOE8sk0cjttKVX8tX5cjXDKImdFR8VgiMbhYM4jdf9S0HpkiYtxioAtnH1AWw8UPdwb7mcyFv9qLHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rN3S/C9bdzw2dUmfoVW2sRqtw6l0OChm2z8MurLG/c=;
 b=XWKgRbYP1Pqm86K+gRXDfXYmworHLQMKNtxdl2SDJMnCRp5uqyHPLORm7lGu1w+W2ipQNBZ68w3H3A5F8H9oOnO/9qaocl9r4UOQhnsRll0PSSFnDXnIdyJf8kFk0hb4ySiHErpegyn19+oczp36kPX4ZS4eLu86R1XpAYmbcd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.22; Tue, 24 May 2022 06:42:35 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 06:42:34 +0000
Content-Type: multipart/alternative;
 boundary="------------Lm1f2HpysicSST4z1KdPQGkk"
Message-ID: <18da952a-25d7-1d52-5d1b-016432066211@amd.com>
Date: Tue, 24 May 2022 12:12:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 2/2] drm/amdgpu: adding device coredump support
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <20220520134909.92781-2-Amaranath.Somalapuram@amd.com>
 <588a0599-7d0c-0041-9877-4429b416e7ed@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <588a0599-7d0c-0041-9877-4429b416e7ed@amd.com>
X-ClientProxiedBy: BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::23) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9805e1e2-dadf-4d1f-b960-08da3d5095c6
X-MS-TrafficTypeDiagnostic: DS0PR12MB6632:EE_
X-Microsoft-Antispam-PRVS: <DS0PR12MB6632166003C97159ACDD647FF8D79@DS0PR12MB6632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5h8KCt8OOwVkxdIt0LnHQDfiBeoPnM9Z78l+Y1X0r8miIZPoI/lF8nVsEaKWbJz5RVKRcfuUWfRGsPGywN4eAIRqfBOipVDGsruWxn+1lMFO4fphsGR95I1iXEjFvk9bI9keFqnznZh5kvPpvfv5XruX511CQ2xGix/nchSslfa+zHdxw7Mo6kJ0SO+3gsS508dEYMEPJmT3huK7aqa3NsvAYoHaIdXBL5y1B67yYBbo8fplhby7kVVPTprgJS3JBCbmuIZT+9sz/aqclRJZ6sty5ts5d4GKoXTaqkDZYWqdj8VQahPbIxA80Xd2dRR2VG4f8LVntCpoVQLtVoPbfuZlCtyl5NBV6rXJ4KV0uyXD9a2qCk+X/gu8fyTOdH2j4IQufZq2gqLMKHvkPzEeYwN0+PI8XORn20dnC5G9FHjLK9nA2rSskPO9E33yWPEiw0J4OcqiVBEJDFPXtgb0wJqtFjfW7x77iop1inT3sMSx3aymFB90DIEXaiXDM69GDYZELmIGg5R75CY1NpfbdaKzIQXzftIvRwye5yQOAyuogKwo+VzmHZPV6X84hL+zP5eqj8qXaZw6ufxZJNi4LNpG+K+9y9WKgzQq3mWGOoM4zpDB+DaWMj1YFoB2N2euRP03SDp9+ppgGJhuO/qNQ4D3z+bRQsZVtCR/pMOUpHKNIl+CfupQ/JEnB2KW+OP/cODZnCjNSInre72V/1BpiuiA0CGQokpUasHFuoJDiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(8936002)(31686004)(33964004)(26005)(316002)(6506007)(4326008)(31696002)(66556008)(66946007)(66476007)(2906002)(36756003)(110136005)(6666004)(2616005)(186003)(6486002)(508600001)(53546011)(5660300002)(38100700002)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUpvdkxPT29ENUZBVUJhUnBWWVZoWUJ5ZHhFNmpaZGtPemVzTVRyaVhXVFNW?=
 =?utf-8?B?RTNReDBVek1sMFlzZ0k2YzJGNmlXc1YrYlEzcFRrQzNhU2JHSXI4QW94UWRF?=
 =?utf-8?B?RmVkcUErZXBjc3o0VEVGWnhHT3laZ0RkVm0wdzFnemVJTmNNUmkrNXR6dHpU?=
 =?utf-8?B?Mlk1bUdGanpiRkcxTWlWUWdjZlo4U2ViR3htTDFieTY2ek5KTk42RnVNTVR2?=
 =?utf-8?B?M0VaMEVnV0VaN3lRQ2NGV29mQnNCVndSQjV0MnhIU1ZQaXdzU0hCZUZUTTRp?=
 =?utf-8?B?WHZTc0JtVGxkbHFXMzBOSVI2NDdSZnFPa2E4alBDYUpwU1ZGZ3phcGxLSm5x?=
 =?utf-8?B?VDZMQlUxcVBZdmNpVlRxTm85SWxsWjliUkUrV3o4cjE3SUl2bjJnTHFEUmZ4?=
 =?utf-8?B?Q2x4eDVMWU90d25PVFEwOE5wVDFaVXlOVGlFQ3RpVVBQajFKZDl2M2xCVHdr?=
 =?utf-8?B?VlBxeHAxOGRhVzNoSVRVMWZ1RlVqVlprSC9yTEN4VitDWmhOcjF0c3RUYzRn?=
 =?utf-8?B?SVFlMThFMFRnYlZkSmhQWnJianYzbEltaldSOFljSnlQUHllL1dxaGdEZDRO?=
 =?utf-8?B?bFowQ3pKaytua3FzTUxMU2NKY3dpaTlUWEUwdjhBMFl6K0ZTci9TMFRuQjFL?=
 =?utf-8?B?cHRPNkVNZk81M0lMSU1sdm4yMlc1U2hSaEJvdFJuY2U4dllOa0o5OERtQnNK?=
 =?utf-8?B?SlBLNWdsZzhveEllWmNlcXY3TzdRb0hGS1ZoaUFyUkZuOXJrSGdWMFk2eFZU?=
 =?utf-8?B?MkZSNW9uMjRHUlk4dnRKaDI4dCs3NTBaeGJsbUVoYnc3SHphNkFkR1JpNTl1?=
 =?utf-8?B?SlhRaG5SSW54a0RORUJCbnEwamZncXROWm1GcVFhSGpRbXhuVkttQ0d2OFFj?=
 =?utf-8?B?VFR2YUlxOElUcXFZYjJ4LyttcEUzeC9PTkpTdjdhbk5RYnAyb21VSlJwb1VL?=
 =?utf-8?B?aVp2bTNMQ1Fnay9YVElhMGRYcm5YUm95NUh2MzV1aS9GRFRZcHZldi9sWHFj?=
 =?utf-8?B?SEpucVNTU0xpMTU2ZnBrRklrZlAwUTZveHpjeTJxZTRVTHU5UVk4NUdUMVBu?=
 =?utf-8?B?ejR0VlpCRnZOTFNrd01hZ253YmZCWTBqTWd5Q1MvaGZjTVNNRXRDWHBWdFp1?=
 =?utf-8?B?TEdxRjlUbnR5NGp4OXZpZnZ6VlNQcWlKdVNQVnhBWXRrUlk2QUcyZWVtSE1q?=
 =?utf-8?B?OUsrcUJreEZ2K0d6dDlOZzdzeFFtTGo3K3dsN2MyVnR3bFJOSnN5T1NhQk5T?=
 =?utf-8?B?Mnk0M2VCV0sveTcxOEdQYmpQWnFIeUlvemhwSTdEbWE0b0JZWnhaaTF0blJh?=
 =?utf-8?B?S25ma09ERFJJR1RxSUtpRWpqRWpNS2NTeXE1K0RZWlVRKzNVaVp1eEhIV2RE?=
 =?utf-8?B?RVJGWkZsckFGRHljaTJ3ajNwU1pmWEVnRDdIbGhtYkwzdGlaZ2FIQ3o3bG90?=
 =?utf-8?B?elpIYThKaWNmdVRSc2hKbFdxdkZqQ3hUOGplRVRJZFZVWjIvSDBGWnY4elFK?=
 =?utf-8?B?SVFkYnUwdk9LUVVIWkx0RFE1SDlRYjFXOHhYdjZWOWpZaEhJQWN4T2E4T3RV?=
 =?utf-8?B?VzRMNVlFdUlYdUd0dHVBQmRlVG1YanBvcDFtYmNoMDhoUHNJYS9ZSDY3dVV4?=
 =?utf-8?B?OEhRbzY1WUoxYm5sbDBzRVk0RlBVWVZkcU9HVUhCeEtmdHYwdW1tVE44RGlT?=
 =?utf-8?B?czZvajlyd25RSlU4WnJRRTBxYkRZMGNWZXNZdmNOZVQ1TE1zanlpQzNraUpC?=
 =?utf-8?B?ZlJteUZhckVqSFR0UkNlTnZaNHFhS0lkNnJJVDlLK1hPQzBnb0FZSjc4WkJX?=
 =?utf-8?B?MmZSYStXQitCM0hXYjcrVW1lbFZuQXE5QlV6VURQYXRidXFjYmRIQzNnT2hV?=
 =?utf-8?B?REM3NFI0Yks2R0kzWDNDaEptdCs3QmhmVzNmZU82NGMxZHNNeXRpZWZieVhQ?=
 =?utf-8?B?c3BaSFNaNXI1R3hkTE9CM1VDU3NwY09PQ1Q1L2YySWdRRGxOVFlNTmZhV3pF?=
 =?utf-8?B?L0VTYktsS0dpMWdDN1dvNkIybjFINXppaDBWbzBNTGpWVWFQSmsyV2d4cVlK?=
 =?utf-8?B?Uytka21SdFZ5eVlFWjZzdFVjcDBlbU9kRVhwVmpwV21lL0pvenVIQXZXRzJG?=
 =?utf-8?B?WS91Z3dDTjErZVZtN3YwaHlaRFlPb3FKVnBoUFhsUXZaUVMwRVpyMHdVUnN4?=
 =?utf-8?B?V0o1eFJXVlpuSFRzeDNZVmJWcWp3NmZxU0JCZXoxb1oreXlFYUg3WlY4Nnln?=
 =?utf-8?B?dnF2ekZ5a0JOTTJEQWgzTjVnL0VWWHBEZ0VhVDZDRi9lS3crMFN3bUNWN0pO?=
 =?utf-8?B?SHZ0ckMrNm4reDBmdFpCMzZCQzhIcGpsYmdEL2dwajQreFZQM0d5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9805e1e2-dadf-4d1f-b960-08da3d5095c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 06:42:34.9134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdYrTfbx4vQAc64vrr/GWwExjCdhBD9P+y9LUue/UMXMUSfWI+WPeiskYBED1Lt6AMkMR6DwZfkn7529prHUzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------Lm1f2HpysicSST4z1KdPQGkk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/20/2022 7:52 PM, Sharma, Shashank wrote:
>
>
> On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
>> Added device coredump information:
>> - Kernel version
>> - Module
>> - Time
>> - VRAM status
>> - Guilty process name and PID
>> - GPU register dumps
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59 ++++++++++++++++++++++
>>   2 files changed, 62 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index c79d9992b113..f28d9c563f74 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1044,6 +1044,9 @@ struct amdgpu_device {
>>       uint32_t                        *reset_dump_reg_list;
>>       uint32_t            *reset_dump_reg_value;
>>       int                             num_regs;
>> +    struct amdgpu_task_info         reset_context_task_info;
>> +    bool                            reset_context_vram_lost;
>
> How about drop the 'context' from name and just reset_task_info and 
> reset_vram_lost ?
OK.
>
>> +    struct timespec64 reset_time;
>>         struct amdgpu_reset_domain    *reset_domain;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 963c897a76e6..f9b710e741a7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -32,6 +32,8 @@
>>   #include <linux/slab.h>
>>   #include <linux/iommu.h>
>>   #include <linux/pci.h>
>> +#include <linux/devcoredump.h>
>> +#include <generated/utsrelease.h>
>>     #include <drm/drm_atomic_helper.h>
>>   #include <drm/drm_probe_helper.h>
>> @@ -4733,6 +4735,55 @@ static int amdgpu_reset_reg_dumps(struct 
>> amdgpu_device *adev)
>>       return 0;
>>   }
>>   +#ifdef CONFIG_DEV_COREDUMP
>> +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
>> +        size_t count, void *data, size_t datalen)
>> +{
>> +    struct drm_printer p;
>> +    struct amdgpu_device *adev = data;
>> +    struct drm_print_iterator iter;
>> +    int i;
>> +
>
> A NULL check for 'buffer' here could prevent a segfault later.
>
Agreed.
>> +    iter.data = buffer;
>> +    iter.offset = 0;
>> +    iter.start = offset;
>> +    iter.remain = count;
>> +
>> +    p = drm_coredump_printer(&iter);
>> +
>> +    drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
>> +    drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>> +    drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>> +    drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, 
>> adev->reset_time.tv_nsec);
>> +    if (adev->reset_context_task_info.pid)
>> +        drm_printf(&p, "process_name: %s PID: %d\n",
>> + adev->reset_context_task_info.process_name,
>> + adev->reset_context_task_info.pid);
> Please fix the alignment of print variables.
>
I will cross check this.
>> +
>> +    if (adev->reset_context_vram_lost)
>> +        drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>> +    if (adev->num_regs) {
>> +        drm_printf(&p, "AMDGPU register dumps:\nOffset: Value:\n");
>> +
>> +        for (i = 0; i < adev->num_regs; i++)
>> +            drm_printf(&p, "0x%08x: 0x%08x\n",
>> +                    adev->reset_dump_reg_list[i],
>> +                    adev->reset_dump_reg_value[i]);
>> +    }
>> +
>> +    return count - iter.remain;
>> +}
>> +
>> +static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
>> +{
>> +    struct drm_device *dev = adev_to_drm(adev);
>> +
>> +    ktime_get_ts64(&adev->reset_time);
>> +    dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
>> +            amdgpu_devcoredump_read, NULL);
> instead of registering NULL as free function, I would prefer you to 
> have a dummy no_op free function registered, which we can consume if 
> something changes.
you mean something like this (function without any code):
staticvoidamdgpu_devcoredump_free(void*data)
{
}
>> +}
>> +#endif
>> +
>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>                struct amdgpu_reset_context *reset_context)
>>   {
>> @@ -4817,6 +4868,14 @@ int amdgpu_do_asic_reset(struct list_head 
>> *device_list_handle,
>>                       goto out;
>>                     vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>> +#ifdef CONFIG_DEV_COREDUMP
>> +                tmp_adev->reset_context_vram_lost = vram_lost;
>> +                tmp_adev->reset_context_task_info.pid = 0;
> why is the PID hardcoded to 0 ?
in case of reset context reset_context->job->vm  is null (possibility 
that reset can be non VM related).
If we don't set tmp_adev->reset_context_task_info.pid = 0, it will show 
previous reset valid PID.


Regards,
S.Amarnath
>> +                if (reset_context->job && reset_context->job->vm)
>> +                    tmp_adev->reset_context_task_info =
>> + reset_context->job->vm->task_info;
>> +                amdgpu_reset_capture_coredumpm(tmp_adev);
>> +#endif
>>                   if (vram_lost) {
>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>>
> - Shashank
>                      amdgpu_inc_vram_lost(tmp_adev);
--------------Lm1f2HpysicSST4z1KdPQGkk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/20/2022 7:52 PM, Sharma, Shashank
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:588a0599-7d0c-0041-9877-4429b416e7ed@amd.com">
      <br>
      <br>
      On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
      <br>
      <blockquote type="cite">Added device coredump information:
        <br>
        - Kernel version
        <br>
        - Module
        <br>
        - Time
        <br>
        - VRAM status
        <br>
        - Guilty process name and PID
        <br>
        - GPU register dumps
        <br>
        <br>
        Signed-off-by: Somalapuram Amaranath
        <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59
        ++++++++++++++++++++++
        <br>
        &nbsp; 2 files changed, 62 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        index c79d9992b113..f28d9c563f74 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        @@ -1044,6 +1044,9 @@ struct amdgpu_device {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_dump_reg_list;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_dump_reg_value;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_regs;
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_task_info&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context_task_info;
        <br>
        +&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context_vram_lost;
        <br>
      </blockquote>
      <br>
      How about drop the 'context' from name and just reset_task_info
      and reset_vram_lost ?
      <br>
    </blockquote>
    OK.<br>
    <blockquote type="cite" cite="mid:588a0599-7d0c-0041-9877-4429b416e7ed@amd.com">
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; struct timespec64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        reset_time;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_domain&nbsp;&nbsp;&nbsp; *reset_domain;
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        <br>
        index 963c897a76e6..f9b710e741a7 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        <br>
        @@ -32,6 +32,8 @@
        <br>
        &nbsp; #include &lt;linux/slab.h&gt;
        <br>
        &nbsp; #include &lt;linux/iommu.h&gt;
        <br>
        &nbsp; #include &lt;linux/pci.h&gt;
        <br>
        +#include &lt;linux/devcoredump.h&gt;
        <br>
        +#include &lt;generated/utsrelease.h&gt;
        <br>
        &nbsp; &nbsp; #include &lt;drm/drm_atomic_helper.h&gt;
        <br>
        &nbsp; #include &lt;drm/drm_probe_helper.h&gt;
        <br>
        @@ -4733,6 +4735,55 @@ static int amdgpu_reset_reg_dumps(struct
        amdgpu_device *adev)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; +#ifdef CONFIG_DEV_COREDUMP
        <br>
        +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t
        offset,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count, void *data, size_t datalen)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct drm_printer p;
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = data;
        <br>
        +&nbsp;&nbsp;&nbsp; struct drm_print_iterator iter;
        <br>
        +&nbsp;&nbsp;&nbsp; int i;
        <br>
        +
        <br>
      </blockquote>
      <br>
      A NULL check for 'buffer' here could prevent a segfault later.
      <br>
      <br>
    </blockquote>
    Agreed.<br>
    <blockquote type="cite" cite="mid:588a0599-7d0c-0041-9877-4429b416e7ed@amd.com">
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; iter.data = buffer;
        <br>
        +&nbsp;&nbsp;&nbsp; iter.offset = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; iter.start = offset;
        <br>
        +&nbsp;&nbsp;&nbsp; iter.remain = count;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; p = drm_coredump_printer(&amp;iter);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;**** AMDGPU Device Coredump ****\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;kernel: &quot; UTS_RELEASE &quot;\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;module: &quot; KBUILD_MODNAME &quot;\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;time: %lld.%09ld\n&quot;,
        adev-&gt;reset_time.tv_sec, adev-&gt;reset_time.tv_nsec);
        <br>
        +&nbsp;&nbsp;&nbsp; if (adev-&gt;reset_context_task_info.pid)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;process_name: %s PID: %d\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        adev-&gt;reset_context_task_info.process_name,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        adev-&gt;reset_context_task_info.pid);
        <br>
      </blockquote>
      Please fix the alignment of print variables.
      <br>
      <br>
    </blockquote>
    I will cross check this.<br>
    <blockquote type="cite" cite="mid:588a0599-7d0c-0041-9877-4429b416e7ed@amd.com">
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp; if (adev-&gt;reset_context_vram_lost)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;VRAM is lost due to GPU reset!\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp; if (adev-&gt;num_regs) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;AMDGPU register dumps:\nOffset:&nbsp;&nbsp;&nbsp;&nbsp;
        Value:\n&quot;);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;num_regs; i++)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;0x%08x: 0x%08x\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_list[i],
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_value[i]);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return count - iter.remain;
        <br>
        +}
        <br>
        +
        <br>
        +static void amdgpu_reset_capture_coredumpm(struct amdgpu_device
        *adev)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct drm_device *dev = adev_to_drm(adev);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; ktime_get_ts64(&amp;adev-&gt;reset_time);
        <br>
        +&nbsp;&nbsp;&nbsp; dev_coredumpm(dev-&gt;dev, THIS_MODULE, adev, 0,
        GFP_KERNEL,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_devcoredump_read, NULL);
        <br>
      </blockquote>
      instead of registering NULL as free function, I would prefer you
      to have a dummy no_op free function registered, which we can
      consume if something changes.
      <br>
    </blockquote>
    you mean something like this (function without any code):<br>
    <div style="color: #000000;background-color: #ffffff;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #0000ff;">static</span><span style="color: #000000;"> </span><span style="color: #0000ff;">void</span><span style="color: #000000;"> amdgpu_devcoredump_free(</span><span style="color: #0000ff;">void</span><span style="color: #000000;"> *data)</span></div></div>
    <div style="color: #000000;background-color: #ffffff;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #000000;">{</span></div><div><span style="color: #000000;">}</span></div>
</div>
    <blockquote type="cite" cite="mid:588a0599-7d0c-0041-9877-4429b416e7ed@amd.com">
      <blockquote type="cite">+}
        <br>
        +#endif
        <br>
        +
        <br>
        &nbsp; int amdgpu_do_asic_reset(struct list_head *device_list_handle,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context *reset_context)
        <br>
        &nbsp; {
        <br>
        @@ -4817,6 +4868,14 @@ int amdgpu_do_asic_reset(struct list_head
        *device_list_handle,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_lost =
        amdgpu_device_check_vram_lost(tmp_adev);
        <br>
        +#ifdef CONFIG_DEV_COREDUMP
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;reset_context_vram_lost =
        vram_lost;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;reset_context_task_info.pid = 0;
        <br>
      </blockquote>
      why is the PID hardcoded to 0 ?
      <br>
    </blockquote>
    in case of reset context reset_context-&gt;job-&gt;vm&nbsp; is null
    (possibility that reset can be non VM related). <br>
    If we don't set tmp_adev-&gt;reset_context_task_info.pid = 0, it
    will show previous reset valid PID.
    <p><br>
    </p>
    Regards,<br>
    S.Amarnath<br>
    <blockquote type="cite" cite="mid:588a0599-7d0c-0041-9877-4429b416e7ed@amd.com">
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset_context-&gt;job
        &amp;&amp; reset_context-&gt;job-&gt;vm)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;reset_context_task_info =
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        reset_context-&gt;job-&gt;vm-&gt;task_info;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_capture_coredumpm(tmp_adev);
        <br>
        +#endif
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vram_lost) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;VRAM is lost due to GPU
        reset!\n&quot;);
        <br>
        &nbsp;
        <br>
      </blockquote>
      - Shashank
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_inc_vram_lost(tmp_adev);
      <br>
    </blockquote>
  </body>
</html>

--------------Lm1f2HpysicSST4z1KdPQGkk--

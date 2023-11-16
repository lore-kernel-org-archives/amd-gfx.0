Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FA0C197A0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 22:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0466E10E70B;
	Thu, 16 Nov 2023 22:38:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F158510E70B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 22:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm0WwyGKqRrtjZgoyWAlWGFVn1qwB738HuwJSQ9w1HxMGUhebfwfRVfbgXFdHFEcJH8PtD6MtW/EfxRNyT2sezWRGiVKka4egD9XDvy0pwo7jTaSogvw3WgYwG7wLBFsWNtqZGRyX5zetm0Tz2zzBPWMkrbn8oB9KLvJvRPD/d2NMyOZR3d+LRUuR/8UeAjk4PV+jAAWppH89Gn1MCboqwVRindjyyOfTlJIBAHYHQcKSPeNv9jeY45SZtnemNVS7TfjE0HvAlXTFG8Ijyak5ikcjOg77XGHo94YCoqpLF5QSxzZdAUKmC2XvBfIffMvIAkOM4BafDyTLZEaPWwf5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq7j8UlrJVoGDWEgLvNnjaIXSRdViXw2z6NtV0YItPg=;
 b=TfihtKlfBde2XwReGww7wTFB+kdmw7/kGcfvfuAZenUqRZJ41ngkXDLXqMnU2Dff2lPYpCE/8kaWKjxCYmemC6qzRg+1/ZG1Tqx54jmYOV/SBLQEcF2LeDelyt8UfzHpAvswwg7pu5FXO9LFFp6mwsD0f47+zxFrVhPRBtY5o5GEOUdBKH0uXl1lIhvgPrbFcXz68dMxqDyhwbCnw87Kp0FsNGM/GgYqbZZfslxHLtYXmpYaSJi7wZ95R/9r+YPX1rpe8ARkcOgcyiOPddDEV8Mw6qI0Da3VcIFf0ZPvFC42oS0KM36jb5h8QGgocMAA9QLQ7310TwDhf2na+uRhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq7j8UlrJVoGDWEgLvNnjaIXSRdViXw2z6NtV0YItPg=;
 b=FxdNf/uRT7cwV0h4sk1dNha8fmSyxnkP5Khq/pcrlCuIZdWRkrUoQDbijH6oCtEA2fJFdMnKHyDgjgzfHJjy4GadQP9jp+TccOqkjXf7hmOnrnoYuFfaGCfN0V4Ta2Nm+gzAxeMvpmCjC6gFoGejZNFbzTj/I9MtU5m8AMybtJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 22:38:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 22:38:02 +0000
Message-ID: <554afc65-8851-41da-89c7-3a03fef2ab86@amd.com>
Date: Thu, 16 Nov 2023 17:38:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Enable checkpoint and restore of VRAM Bos with
 no VA
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231116024705.591555-1-Ramesh.Errabolu@amd.com>
 <f1b877d8-d446-4a50-9a0e-1f0c99c164ed@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <f1b877d8-d446-4a50-9a0e-1f0c99c164ed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0158.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 1133b773-32c4-45fc-c071-08dbe6f4b14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzpDHJvX1QqbwWPsE8lAop58qAumyNrsCplKMkRdFLqlGSZLYV2sNL8tzrknljLws/njl6jks9dBQTLyT9vI2TebFBds4BEbVFO24uB0NWRqnGivVJJmC2RIoBqV2emF5yk7ar60x+iRjmL9freDraYh9laX/iFsCwnfHLJZmaicNTBGcsuD41kDKkGAuBZ/v6XDNRhx+vrch9jX6L0IY6rxxkvYmutd/70Dr24uLjywGbxkrLmex4EpUK2Y+LtD3aVx2cPIRwz6h9MtxtOyX1UgPykrUbtnA/CczTG4Q7iu10mDP3ChgqfBb8HrnzPAAAJhwnmR5HeiO9RtDvFDPekpmLst95Tyl1o0TggmIvpLG4xGHOoom0y8tQq/siHaRwCv03hrCv7ADU5WMhPqPCqEXikoMWqBhsitr2q06oZby0hz2+bLcV6OvgCKP8yAYsjt0ESX757L/y5qHWA6E8SyuqnxdHoaqWNomjKWfEAaiqQxA3INyKDw8pYfqQRRYAzO2vBYGd4vSausn4G34o3ujdgiq/oUVBbogZgF+OI0K+Zejna9mqP+R9dRwDF0enoKTFhmXu+bg/e0LPtV6xU8Qmjqkd3zwJdUki/aKMcWoI8BRTXch55zfm3a1HNNfVbP4C9EoFur6XyAqoZZOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(30864003)(2906002)(41300700001)(4001150100001)(316002)(66476007)(66556008)(36756003)(8936002)(8676002)(110136005)(66946007)(38100700002)(478600001)(5660300002)(44832011)(86362001)(31696002)(31686004)(6486002)(83380400001)(66574015)(26005)(6512007)(2616005)(66899024)(6506007)(53546011)(36916002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2wzVDQxcVRYeXVqWWN0OUc0aG00T0pISlNEUExUN3VJWjEvenlHVklLYXVQ?=
 =?utf-8?B?YVpkRzA3UlltMXdMc2krRUpOUTFnT05SOTd2QzFpamVINE4xVnJ0dURNeDhB?=
 =?utf-8?B?bC8rbjZ2UFd2ZG9VczcvWDBxL1A1VysvdHUrcUNEamlBbnJXaUNsYWFrOGtl?=
 =?utf-8?B?S1RLVFFONHhta1VQMi9QQTN6MjNTbXBRZkdmc1dtamovcTQrTVk5YmlIeG91?=
 =?utf-8?B?SDg4bFJSNFhjMGNKWC9RQkh6UTlmTHI2ZkdCRUlGdVB3bC9RU3Y0NlFhUmN4?=
 =?utf-8?B?ci8ybldRdU01OVlmN3FBNjNpZE5sQ2xDQ0xrMDh0RVVnbWlvZTFPTk03a3pj?=
 =?utf-8?B?MnJqYUFiOXZpYURtT2srV1hVMXIwUmwxVnhxTUwyZnJDakdGN21RWjZYVGVC?=
 =?utf-8?B?Q2t4akIrdi9scUs5OFNDSEtFeUVnZjhETWwyWXNiVitYelFab3pEZVdwY0ZF?=
 =?utf-8?B?N2cxb1FQUVQxR3ZxVEsrTHJ3bGtvKzJTaXlETUw0c21kZGNuSDRFSk01UjYv?=
 =?utf-8?B?OTh6MUlQSXJPT0tVZEhLa3E0RGFGa3YxWU9IRUx6aExIbmtUUnRqeXRhUVgr?=
 =?utf-8?B?VmN6SFh3aXFjVjZWcUo1M3JidDBpanhHVU5lOVRGd3p2K3RZV3ZZNnUzV2dN?=
 =?utf-8?B?Zi9NN0c5bXBqclBQSjBzZDB4c2VsYm9wK1h4cDh0TEcxKzRxZHRld3BIVFhW?=
 =?utf-8?B?VVZ1RnpZMzQrQVRtcDZpY3NNL1g5TFRaMktXeS9LU0VhdVRQRzdCeFduaito?=
 =?utf-8?B?V1g1ZXN3eDhTcE1WYmJWaVpBWFVEWDRSYnJ6UDlVWDg4VkhTWnpJNFluZVBk?=
 =?utf-8?B?ZW1ZemsySTJQQzJLemFSQndWdEVxNXUvZ0xKM1Ayd2haMm4xMDgzYnEvYVZL?=
 =?utf-8?B?bDJNTTNabWtXYkY5dFJISzR0RlJJNFliQ2FyY254NThsQkRCczZiU0E1RWNB?=
 =?utf-8?B?WHRCcG9EbWdRaFVGWSt3cjV5UTJvbmNIWVp0UlZZYlN4cW1mYW1vZmErbGFJ?=
 =?utf-8?B?VllmQXpIR0JQZ2NhbFdLMnYvSkhEM1VFZVZwMCtQTElRNHZmZ3Z2Q0MvNXh2?=
 =?utf-8?B?RGx4RWtFSENBNVgrUzVlNFo5YXhwRk51RkZVcTlYL3RLakRNbUloVEgyWC9B?=
 =?utf-8?B?czJnNHJhSlE3TDFSazQzU0FFc1FPeTljVm9XdVpDd0NTZjg2VXBjd0pKT0J3?=
 =?utf-8?B?dFlVakhlQVJ4dGhvbDhUZ2o4eW9JRy9KTHd6TWJHM3I2SWM1b0xKTTJrZzQx?=
 =?utf-8?B?b1RxUWh3OEZIZE45TWpQT3RXYzhYQkp5VFlFdTRNTndqVlk5Ri9WTkprdkdG?=
 =?utf-8?B?UnErZllLS2pUVjBlS25iTkdKakdTaTI3dXROWFN5d3B5NHA1aTNFOG5XOW9h?=
 =?utf-8?B?KzdrTkRlR3hOV1owK0o3YlRpc29qSHA5cGJpZFJnTkVCNTJnRElFcTJJTm9x?=
 =?utf-8?B?M2J1dVVNeG96TXZDa0J6SWh4OVZTOUtlcmpQQUdXTmZvanZZNkJ1RlNaZzk3?=
 =?utf-8?B?WHVzOTI0a3ZXRThuL2Y2NEFic3NDN05hRlA0NlVHdnhoVEVwUVFGYklOZWJV?=
 =?utf-8?B?WnZWVWVSOEFmZHRQN1BIdjNxR0hDZi9vaGV2bnc2TFBtUzFvbDZKSW5ydHJU?=
 =?utf-8?B?RjhzS3NpSnk4NzFBNTVON2V0TE5jYnVQemdQbm5BUDNGZnFKcGJhWkFldUxQ?=
 =?utf-8?B?ZVRsa2xRRmNNRDE3T0s1MVpVeFR2Y0xYMzFjQzdQam5NcDVQUExDZ0JOWTZC?=
 =?utf-8?B?L0hNanI1cjR5Wlpsa0c4R21hYkZTU29jcWsrbXFWZE03bDAwdmYxMmVxbFdS?=
 =?utf-8?B?WU9SRy93Y2E2OVIrS0pWT0FteW96OVprWlFpYmpqNktrWkxkTUY0c1Vra0Ex?=
 =?utf-8?B?SjlBcmJqdTZ2VFVGOE14THpmQjlKcnpEcHFjUytLMm5iWEd1TUh4cHhtZFda?=
 =?utf-8?B?bFQwNWlOTlIrbUx3Um5XZm5CVHQxdE0wLzZYRTl1cThuY05ybWxMZVBycGtP?=
 =?utf-8?B?NVplOHpXYXovRjVsVTFnblgrbXJpcThsVENHRjNydkZ0NTkxNjBNQTN1VFF6?=
 =?utf-8?B?NUtMenVDM2E2ay9tZTdNTU96amQvYlBVUFIvS25jM0RxMTV2OVFnTDgwSW1M?=
 =?utf-8?Q?VFKHk9wAVqklRlmdbUsswgU+Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1133b773-32c4-45fc-c071-08dbe6f4b14d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:38:02.6057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMOLEUtF7UMGC0sJg6mBfMd/7fqF6Gjs/bzJNCuxTE6KZAPO1bm1Wp9W7+I4VI42T4XxODXmSf0LdWKlO+JQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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


On 2023-11-16 06:11, Christian König wrote:
>
>
> Am 16.11.23 um 03:47 schrieb Ramesh Errabolu:
>> Tag VRAM BOs that do not have a VA with a unique Id, a 128-bit
>> UUID. This unique Id is used to distinguish BOs that might
>> otherwise be of same size. Checkpoint and restore assumes
>> that these BOs are not imported into a DRM device that is
>> accessible either from current process or its parent or
>> child process
>>
>> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  29 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c      | 190 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h      | 103 ++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  17 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  30 ++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
>>   9 files changed, 370 insertions(+), 10 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 260e32ef7bae..851e2c4db372 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -270,7 +270,8 @@ amdgpu-y += \
>>       amdgpu_amdkfd_gc_9_4_3.o \
>>       amdgpu_amdkfd_gfx_v10.o \
>>       amdgpu_amdkfd_gfx_v10_3.o \
>> -    amdgpu_amdkfd_gfx_v11.o
>> +    amdgpu_amdkfd_gfx_v11.o \
>> +    amdgpu_criu.o
>>     ifneq ($(CONFIG_DRM_AMDGPU_CIK),)
>>   amdgpu-y += amdgpu_amdkfd_gfx_v7.o
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index fcf8a98ad15e..6c0d7e6a66cd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -289,7 +289,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct 
>> amdgpu_device *adev,
>>   int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>           struct amdgpu_device *adev, uint64_t va, uint64_t size,
>>           void *drm_priv, struct kgd_mem **mem,
>> -        uint64_t *offset, uint32_t flags, bool criu_resume);
>> +        uint64_t *offset, uint32_t flags,
>> +        bool criu_resume, uuid_t *uuid);
>>   int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>           struct amdgpu_device *adev, struct kgd_mem *mem, void 
>> *drm_priv,
>>           uint64_t *size);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 2e302956a279..b139ffd519e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/pagemap.h>
>>   #include <linux/sched/mm.h>
>>   #include <linux/sched/task.h>
>> +#include <linux/uuid.h>
>>   #include <drm/ttm/ttm_tt.h>
>>     #include "amdgpu_object.h"
>> @@ -35,6 +36,7 @@
>>   #include "amdgpu_dma_buf.h"
>>   #include <uapi/linux/kfd_ioctl.h>
>>   #include "amdgpu_xgmi.h"
>> +#include "amdgpu_criu.h"
>>   #include "kfd_priv.h"
>>   #include "kfd_smi_events.h"
>>   @@ -1718,7 +1720,8 @@ size_t 
>> amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
>>   int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>           struct amdgpu_device *adev, uint64_t va, uint64_t size,
>>           void *drm_priv, struct kgd_mem **mem,
>> -        uint64_t *offset, uint32_t flags, bool criu_resume)
>> +        uint64_t *offset, uint32_t flags,
>> +        bool criu_resume, uuid_t *uuid)
>>   {
>>       struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
>>       struct amdgpu_fpriv *fpriv = container_of(avm, struct 
>> amdgpu_fpriv, vm);
>> @@ -1814,13 +1817,23 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>            va, (*mem)->aql_queue ? size << 1 : size,
>>            domain_string(alloc_domain), xcp_id);
>>   -    ret = amdgpu_gem_object_create(adev, aligned_size, 1, 
>> alloc_domain, alloc_flags,
>> -                       bo_type, NULL, &gobj, xcp_id + 1);
>> +    /* Construction of VRAM BO one with no VA, during CRIU Restore
>> +     * should consult BO table. Will return either a previously
>> +     * constructed BO or will construct a BO anew
>> +     */
>> +    if (criu_resume && (va == 0) && (flags & 
>> KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
>> +        ret = restore_vram_bo(adev, aligned_size, 1, alloc_flags, uuid,
>> +                &gobj, xcp_id + 1);
>> +    else
>> +        ret = amdgpu_gem_object_create(adev, aligned_size, 1, 
>> alloc_domain,
>> +                alloc_flags, bo_type, NULL, &gobj, xcp_id + 1);
>> +
>>       if (ret) {
>>           pr_debug("Failed to create BO on domain %s. ret %d\n",
>>                domain_string(alloc_domain), ret);
>>           goto err_bo_create;
>>       }
>> +
>>       ret = drm_vma_node_allow(&gobj->vma_node, drm_priv);
>>       if (ret) {
>>           pr_debug("Failed to allow vma node access. ret %d\n", ret);
>> @@ -1843,6 +1856,16 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>         add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, user_addr);
>>   +    /* Initialize the UUID field of a BO that:
>> +     *     - Represents a VRAM BO
>> +     *     - Does not have a VA bound
>> +     *     - Is allocated outside CRIU Resume procedure
>> +     */
>> +    if (!criu_resume && (va == 0) && (flags & 
>> KFD_IOC_ALLOC_MEM_FLAGS_VRAM)) {
>> +        if (uuid_is_null(&bo->uuid))
>> +            uuid_gen(&bo->uuid);
>> +    }
>> +
>>       if (user_addr) {
>>           pr_debug("creating userptr BO for user_addr = %llx\n", 
>> user_addr);
>>           ret = init_user_pages(*mem, user_addr, criu_resume);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
>> new file mode 100644
>> index 000000000000..4b43a3df6913
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
>> @@ -0,0 +1,190 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu_criu.h"
>> +
>> +/*
>> + * Hash table to host BOs that have their unique IDs initialized
>> + * The table comes into play during CRIU Restore procedure
>> + *
>> + * @note: Currently these BOs encapsulate device memory i.e. are
>> + * VRAM BOs
>> + */
>> +DECLARE_HASHTABLE(criu_bo_table, CRIU_BO_TABLE_SIZE);
>> +static DEFINE_MUTEX(criu_mutex);
>> +
>> +/* Global counter to track life of Hash table */
>> +atomic_t criu_bo_counter = ATOMIC_INIT(0);
>> +
>> +void print_uuid(uuid_t *uuid)
>
> All non-static function should have an amdgpu_ prefix.
>
>
>
>> +{
>> +    pr_err("\n");
>> +    for (int idx = 0; idx < 16; idx++)
>> +        pr_err("Idx[%d] %d\n", idx, uuid->b[idx]);
>> +    pr_err("\n");
>> +}
>> +
>> +void print_uuid_compare(uuid_t *uuid1, uuid_t *uuid2)
>> +{
>> +    pr_err("\n");
>> +    for (int idx = 0; idx < 16; idx++)
>> +        pr_err("Idx[%d] %d,  %d\n", idx, uuid1->b[idx], uuid2->b[idx]);
>> +    pr_err("\n");
>> +}
>> +
>> +void inc_table_counter(uint32_t cntr)
>> +{
>> +    int init;
>> +
>> +    mutex_lock(&criu_mutex);
>> +    init = atomic_read(&criu_bo_counter);
>> +    if (init == 0x00) {
>> +        pr_debug("%s(), Invoking hash_init api\n", __func__);
>> +        hash_init(criu_bo_table);
>> +    }
>> +
>> +    atomic_add(cntr, &criu_bo_counter);
>> +    init = atomic_read(&criu_bo_counter);
>> +    mutex_unlock(&criu_mutex);
>> +}
>> +
>> +static void free_bo_table(void)
>> +{
>> +    struct criu_bo_uuid *bo_uuid = NULL;
>> +    uint32_t bkt;
>> +
>> +    hash_for_each_rcu(criu_bo_table, bkt, bo_uuid, node)
>> +        hash_del_rcu(&bo_uuid->node);
>> +}
>> +
>> +void dec_table_counter(uint32_t cntr)
>> +{
>> +    uint32_t deinit;
>> +
>> +    mutex_lock(&criu_mutex);
>> +    atomic_sub(cntr, &criu_bo_counter);
>> +    deinit = atomic_read(&criu_bo_counter);
>> +    if (deinit == 0x00) {
>> +        pr_debug("%s(), Invoking free_bo_table api\n", __func__);
>> +        free_bo_table();
>> +    }
>> +
>> +    if (deinit < 0)
>> +        pr_err("%s(), BO Table counter is inconsistent: %d\n", 
>> __func__, deinit);
>> +
>> +    mutex_unlock(&criu_mutex);
>> +}
>> +
>> +uint32_t query_table_counter(void)
>> +{
>> +    uint32_t cntr;
>> +
>> +    mutex_lock(&criu_mutex);
>> +    cntr = atomic_read(&criu_bo_counter);
>> +    mutex_unlock(&criu_mutex);
>> +    return cntr;
>> +}
>> +
>> +/* Determine if BO is present in Hash table */
>> +static void add_bo_uuid(struct criu_bo_uuid *bo_uuid)
>> +{
>> +    mutex_lock(&criu_mutex);
>> +    hash_add_rcu(criu_bo_table, &bo_uuid->node, 
>> (uintptr_t)bo_uuid->uuid);
>> +    mutex_unlock(&criu_mutex);
>> +}
>> +
>> +/* Determine if BO is present in Hash table
>> + *
>> + * @note: Does the look up object based on value of key
>> + * and not just its integer value
>> + */
>> +static struct criu_bo_uuid *get_bo_uuid(uuid_t *uuid)
>> +{
>> +    struct criu_bo_uuid *bo_uuid = NULL;
>> +    uint32_t bkt;
>> +
>> +    mutex_lock(&criu_mutex);
>> +    hash_for_each_rcu(criu_bo_table, bkt, bo_uuid, node)
>> +        if (uuid_equal(uuid, bo_uuid->uuid))
>> +            goto ret_abo;
>> +
>> +ret_abo:
>> +    mutex_unlock(&criu_mutex);
>> +    return bo_uuid;
>> +}
>> +
>> +int restore_vram_bo(struct amdgpu_device *adev,
>> +            unsigned long size, int align, u64 flags,
>> +            uuid_t *uuid, struct drm_gem_object **gobj, int8_t 
>> xcp_id_plus1)
>> +{
>> +    enum ttm_bo_type bo_type = ttm_bo_type_device;
>> +    u32 domain = AMDGPU_GEM_DOMAIN_VRAM;
>> +    struct criu_bo_uuid *bo_uuid;
>> +    struct amdgpu_bo *abo;
>> +    int ret;
>> +
>> +    /* Determine if VRAM was built originally for exporting it
>> +     * to peers. Currently the only VRAM BOs that are exportable
>> +     * are those that do not have a VA attached
>> +     */
>> +    if (unlikely(uuid == NULL)) {
>> +        pr_err("A NULL UUID is Illegal for VRAM BOs without a VA\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Determine if BO is already present in hash table */
>> +    bo_uuid = get_bo_uuid(uuid);
>> +
>> +    /* Return the BO present in table */
>> +    if (bo_uuid != NULL) {
>> +        abo = bo_uuid->abo;
>> +        *gobj = &(abo->tbo.base);
>> +        return 0;
>> +    }
>> +
>> +    /* Build the BO and add it to table before returning it */
>> +    ret = amdgpu_gem_object_create(adev, size, align,
>> +            domain, flags, bo_type, NULL, gobj, xcp_id_plus1);
>> +    if (ret) {
>> +        pr_err("Failed to Restore VRAM BO, Retval: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    /* Re-init uuid of BO that identifies it uniquely and
>> +     * add the BO into the table
>> +     */
>> +    abo = gem_to_amdgpu_bo(*gobj);
>> +    uuid_copy(&(abo->uuid), uuid);
>> +    bo_uuid = kzalloc(sizeof(*bo_uuid), GFP_KERNEL);
>> +    if (bo_uuid == NULL)
>> +        return -EINVAL;
>> +    bo_uuid->abo = abo;
>> +    bo_uuid->uuid = uuid;
>> +    add_bo_uuid(bo_uuid);
>> +
>> +    /* Return the BO that was built */
>> +    *gobj = &(abo->tbo.base);
>> +    return 0;
>> +}
>> +
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
>> new file mode 100644
>> index 000000000000..b895c698a2e0
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
>> @@ -0,0 +1,103 @@
>> +/* SPDX-License-Identifier: MIT
>> + *
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#ifndef AMDGPU_CRIU_H_INCLUDED
>> +#define AMDGPU_CRIU_H_INCLUDED
>> +
>> +#include <linux/list.h>
>> +#include <linux/atomic.h>
>> +#include <linux/pagemap.h>
>> +#include <linux/dma-buf.h>
>> +#include <linux/sched/mm.h>
>> +#include <linux/hashtable.h>
>> +#include <linux/sched/task.h>
>> +#include <uapi/linux/kfd_ioctl.h>
>> +
>> +#include "amdgpu_object.h"
>> +#include "amdgpu_gem.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_amdkfd.h"
>> +#include "amdgpu_dma_buf.h"
>> +
>> +/* Specify Hash table and its size to host VRAM BOs that have their
>> + * unique IDs iniialized. These BOs which can be exported as Dmabuf
>> + * allows user space to bind different virtual addresses on different
>> + * DRM devices.
>> + *
>> + * @note: Currently these BOs encapsulate device memory i.e. are 
>> VRAM BOs
>> + */
>> +#define CRIU_BO_TABLE_SIZE        8
>> +extern DECLARE_HASHTABLE(criu_bo_table, CRIU_BO_TABLE_SIZE);
>> +
>> +struct criu_bo_uuid {
>> +
>> +    /* Unique ID of BO, serves the role of KEY */
>> +    uuid_t *uuid;
>> +
>> +    /* Handle of BO, serves the role of VALUE */
>> +    struct amdgpu_bo *abo;
>> +
>> +    /* Allows chaining of BO being managed by table */
>> +    struct hlist_node node;
>> +};
>> +
>> +
>> +/* Global counter to track life of Hash table */
>> +extern atomic_t criu_bo_counter;
>> +
>> +/**
>> + * restore_vram_bo() - Returns handle of a GEM object either by look up
>> + * or by construction. Look up a Global BO table to determine if the BO
>> + * of concern has already been constructed. By construction if the look
>> + * up fails to find the BO in the global BO table
>> + *
>> + * NOTE: Following two conditions must be held TRUE when invoking 
>> this method
>> + *  - This method deals with VRAM BOs only. Invoking this method to 
>> handle
>> + *    BOs of other kinds is invalid.
>> + *  - This method is invoked during a CRIU Restore procedure. An 
>> Invocation
>> + *    outside of this scneario is invalid
>> + *
>> + * @adev: Handle of device to use in construction
>> + * @size: BO's memory size in bytes
>> + * @align: Alignment requirements, if any, in allocating memory
>> + * @flags: Flags to apply in allocating memory
>> + * @uuid: Handle of UUID object to be restored
>> + * @gobj: Output parameter updated with handle of GEM object
>> + * @xcp_id_plus1: ID of the XCD on which BO is to be created
>> + *
>> + * Return: ZERO if successful, a negative value in case of error
>> + */
>> +int restore_vram_bo(struct amdgpu_device *adev,
>> +            unsigned long size, int align, u64 flags,
>> +            uuid_t *uuid, struct drm_gem_object **gobj,
>> +            int8_t xcp_id_plus1);
>> +
>> +void print_uuid(uuid_t *uuid);
>> +void print_uuid_compare(uuid_t *uuid1, uuid_t *uuid2);
>> +
>> +uint32_t query_table_counter(void);
>> +void inc_table_counter(uint32_t cntr);
>> +void dec_table_counter(uint32_t cntr);
>> +
>> +#endif    /* AMDGPU_CRIU_H_INCLUDED */
>> +
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index d28e21baef16..dc61b252fe49 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -117,6 +117,23 @@ struct amdgpu_bo {
>>        * for memory accounting.
>>        */
>>       int8_t                xcp_id;
>> +
>> +    /*
>> +     * @uuid: Unique ID of a BO that is being exported. The 128-bit 
>> ID is
>> +     * considered to be unique across processes and time. One use of 
>> this
>> +     * ID is to support CRIU operations of Checkpointing & Restore.
>> +     *
>> +     * ID is a byte array of length UUID_SIZE. This is to 
>> accommodate UUID,
>> +     * a 128-bit number defined by RFC 4122. Hex string form of UUID is
>> +     * defined as a sequence of 32 hexadecimal digits, divided into 
>> five
>> +     * groups that are delimited by hyphens "-". The sequence of groups
>> +     * from length perspective is: 8-4-4-4-12.
>> +     *
>> +     * The default value of this field is set ZEROS. It is 
>> initialized to a
>> +     * NON-ZERO value when a BO is exported using GEM Prime Apis. 
>> Currently
>> +     * the only BOs that can be exported are GTT and VRAM BOs.
>> +     */
>> +    uuid_t uuid;
>
> Clear NAK to add this to the amdgpu_bo structure.
>
> This is not related to general BO handling but a specialized use case.
>
> What exactly are you trying to do here in the first place?

It's probably not needed in this patch. Eventually we need some way to 
figure out when the same BO is shared between different KFD and DRM 
render node devices, even across processes. When a CRIU checkpoint is 
restored, we need to restore the memory sharing relationships, so we 
need a way to uniquely identify shared BOs when different handles in 
different device files refer to the same BO.

The only way to get the UUID out of the driver is through the private 
data of a CRIU checkpoint. And the only way to get it back in is through 
the privileged CRIU restore ioctl.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>   };
>>     struct amdgpu_bo_user {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 06988cf1db51..310a48b627ef 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -38,6 +38,7 @@
>>   #include <linux/dma-buf.h>
>>   #include <linux/fdtable.h>
>>   #include <linux/processor.h>
>> +#include <linux/uuid.h>
>>   #include "kfd_priv.h"
>>   #include "kfd_device_queue_manager.h"
>>   #include "kfd_svm.h"
>> @@ -45,6 +46,7 @@
>>   #include "kfd_smi_events.h"
>>   #include "amdgpu_dma_buf.h"
>>   #include "kfd_debug.h"
>> +#include "amdgpu_criu.h"
>>     static long kfd_ioctl(struct file *, unsigned int, unsigned long);
>>   static int kfd_open(struct inode *, struct file *);
>> @@ -1147,7 +1149,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct 
>> file *filep,
>>       err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>           dev->adev, args->va_addr, args->size,
>>           pdd->drm_priv, (struct kgd_mem **) &mem, &offset,
>> -        flags, false);
>> +        flags, false, NULL);
>>         if (err)
>>           goto err_unlock;
>> @@ -1848,6 +1850,12 @@ static uint32_t get_process_num_bos(struct 
>> kfd_process *p)
>>           idr_for_each_entry(&pdd->alloc_idr, mem, id) {
>>               struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
>>   +            /* Count BOs whose VA is either zero or is equal
>> +             * to or exceed GPUVMs base address
>> +             *
>> +             * @note: BOs whose VA is below GPUVM base are
>> +             * used internally, e.g. Trap handler buffer
>> +             */
>>               if (!kgd_mem->va || kgd_mem->va > pdd->gpuvm_base)
>>                   num_of_bos++;
>>           }
>> @@ -1936,6 +1944,12 @@ static int criu_checkpoint_bos(struct 
>> kfd_process *p,
>>               bo_bucket->alloc_flags = (uint32_t)kgd_mem->alloc_flags;
>>               bo_priv->idr_handle = id;
>>   +            /* Copy uuid of BO that identifies it uniquely
>> +             * Currently this is true for only VRAM BOs that
>> +             * have been exported
>> +             */
>> +            uuid_copy((uuid_t *)bo_priv->uuid, &kgd_mem->bo->uuid);
>> +
>>               if (bo_bucket->alloc_flags & 
>> KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>                   ret = amdgpu_ttm_tt_get_userptr(&dumper_bo->tbo,
>>                                   &bo_priv->user_addr);
>> @@ -2295,6 +2309,7 @@ static int criu_restore_memory_of_gpu(struct 
>> kfd_process_device *pdd,
>>       int ret;
>>       const bool criu_resume = true;
>>       u64 offset;
>> +    uuid_t *uuid;
>>         if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) {
>>           if (bo_bucket->size !=
>> @@ -2318,10 +2333,17 @@ static int criu_restore_memory_of_gpu(struct 
>> kfd_process_device *pdd,
>>       } else if (bo_bucket->alloc_flags & 
>> KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>           offset = bo_priv->user_addr;
>>       }
>> -    /* Create the BO */
>> +
>> +    /* Acquire handle of UUID of BO if need be */
>> +    uuid = NULL;
>> +    if ((bo_bucket->addr == 0) &&
>> +        (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
>> +        uuid = (uuid_t *)bo_priv->uuid;
>> +
>>       ret = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(pdd->dev->adev, 
>> bo_bucket->addr,
>>                                 bo_bucket->size, pdd->drm_priv, kgd_mem,
>> -                              &offset, bo_bucket->alloc_flags, 
>> criu_resume);
>> +                              &offset, bo_bucket->alloc_flags,
>> +                              criu_resume, uuid);
>>       if (ret) {
>>           pr_err("Could not create the BO\n");
>>           return ret;
>> @@ -2728,10 +2750,12 @@ static int kfd_ioctl_criu(struct file *filep, 
>> struct kfd_process *p, void *data)
>>           ret = criu_unpause(filep, p, args);
>>           break;
>>       case KFD_CRIU_OP_RESTORE:
>> +        inc_table_counter(p->n_pdds);
>>           ret = criu_restore(filep, p, args);
>>           break;
>>       case KFD_CRIU_OP_RESUME:
>>           ret = criu_resume(filep, p, args);
>> +        dec_table_counter(p->n_pdds);
>>           break;
>>       default:
>>           dev_dbg(kfd_device, "Unsupported CRIU operation:%d\n", 
>> args->op);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index a40f8cfc6aa5..320408239896 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1178,7 +1178,7 @@ int kfd_process_init_cwsr_apu(struct 
>> kfd_process *process, struct file *filep);
>>    * kfd_criu_svm_range_priv_data
>>    */
>>   -#define KFD_CRIU_PRIV_VERSION 1
>> +#define KFD_CRIU_PRIV_VERSION 2
>>     struct kfd_criu_process_priv_data {
>>       uint32_t version;
>> @@ -1193,6 +1193,7 @@ struct kfd_criu_device_priv_data {
>>   struct kfd_criu_bo_priv_data {
>>       uint64_t user_addr;
>>       uint32_t idr_handle;
>> +    uint8_t uuid[16];    /* Unique Id of BO whose size is UUID_SIZE */
>>       uint32_t mapped_gpuids[MAX_GPU_INSTANCE];
>>   };
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index c10d050e1a61..1969eb9375c2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -716,7 +716,7 @@ static int kfd_process_alloc_gpuvm(struct 
>> kfd_process_device *pdd,
>>         err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->adev, 
>> gpu_va, size,
>>                            pdd->drm_priv, mem, NULL,
>> -                         flags, false);
>> +                         flags, false, NULL);
>>       if (err)
>>           goto err_alloc_mem;
>

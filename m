Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78071CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 13:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9BAE1133A7;
	Mon,  1 Jun 2026 13:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FAtYtfD5";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BEDC1133A7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 13:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPsIjr8Pp4xNARoWdBpUty38MrJqgXGUVzt5c6Bjt5B6ghX1ybHnXLouzXHwR53rVAmmDQ/Orrp4oI15MO/AugpR5gTVUB1FXeZ4gflD4643Y+3RGpYNe+8Qo+ArgJUcZTbaLhGxA58kPigE6Ce7s8yjofF8+Fk3qkoWGZ7GFi86iJw2KwDQf7mia/INGafWwwkE3NUWryiJ5FISycbmHM9qe5lgY4SYRcpukeiLZRgMNUOcVrrx/EJDyASJbTDYNplA8+ZnZZOjXByL9WqoQUSb99LYgWvrTQPI7KvKlTL37fgJKBpd6KaJoPL4FpUNHkNVtW38WLn9QWnX884qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8DzV+XzEw3z4lJKKYhLhDGcpQc3XEQiylMjeM9oPE8=;
 b=XTAgmtY6mErJ1ce3dKlgmWws13xoDhVdIjIsPJ0M9LNtdPnfAq0Zpwf4gmF1UpiUVwXBEcgASOqiaONYdchxUG3492UwGYHdUr5xpjMo3lMq/IKy4ZFoCfHuNmQaCqBkMJmk8k3sL6ZDC0BgVwu6cLi/nIIj4NGDf05433P9vwIMgy+UiI2MqRrrb2morY+ndusHxSkZRQdLb+NjZeGlGVrPy+JqStk5TZn45jNulzH70He4asfew35jKMJrEzKib6wQjnLAMC78vg5ilyY4PHlSx2x0UqVQ+ZPqwsBLmWXKxCCv7dqXuBbH3F4PJDgm9j1ml07IEvM1kXBvW1knCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8DzV+XzEw3z4lJKKYhLhDGcpQc3XEQiylMjeM9oPE8=;
 b=FAtYtfD56oLwfzX6M4R0LE6kSeAs65tHix9RamroNiYxt2SjnBdG5RmuQoBCO9U4lWWu6v9waXEOIHCs6M5J1koWKoP3xrMl3acdXayOtDuLjDQvhH906KX08vV9aEfg0JoK64vWUHUXY3Kxa2edRw9tOKD4OmhAszew3QS6Zhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 13:58:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:58:32 +0000
Message-ID: <49eacb04-0a99-4d5b-9f1e-d89843b689b5@amd.com>
Date: Mon, 1 Jun 2026 15:58:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] drm/amdgpu: split amdgpu_vm_update_range
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>, natalie.vock@gmx.de,
 honghuan@amd.com, Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-9-christian.koenig@amd.com>
 <e6f789e6-d5cb-485f-a8b9-8c087708f4f5@damsy.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e6f789e6-d5cb-485f-a8b9-8c087708f4f5@damsy.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cad155d-2e7b-4fc1-a4fd-08debfe5dda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|4143699003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /wZIw2GvYSU6cud9dR1KeiAGjbtf0wH3XdhciEYNurDKQpanGWgg30ee6/czmR4GcQUKICsr7kP9yOPH7+L/i2eqDePCb2ZS3DHvKQuvD6lPH0A7maYgqjRJIiRVMAC3QQeqFdUvwZRsovAuNlx7XNGSVq4VGT4peeZLm4JUYvrk8rkCWcFYrUpBOB+LcE8cOkkX3MoOgVYZIQj67DP3NhjERagXnqbLhzBMZLXCpDJ2p+YG4CWGf/iZbbWhMvAYJDOY8nMHKv1MxZqEOcuwIzIdMeJTNJu7gdtOwtdNnkZEpkGJhKvylXRHgN+JYzFxMHBGtMhEWLv2+tbOBuOOA2nZ3BGkpuVOkSFOLCndQ9fH8BAlwEI6J+6Wm63DOIHYEqA8LF7SvUozZ0tKO1DY3ij0sarj1t3mdo6HjxyNxyxhrlbKBkvc+HTs/d3iSCZ9Otjd9xwJzsMZZE7ASZ/SK1j+YGzzI9NvV4bnikko8d8smWmuIhqZUkiC4Ul+tjzJgwA3gVx2dnzUK8yXB+jVd1zIy7Tj7W4ItGzFf6aFrUU0EeRaUVkQRZbiuMIZbmHAnntuGU4GznIIlMj2dPo9q+HkkO1srGVcxg+Tx5vRbGMdGnBhU4VPDVqrzUWo4jeBV5pXOAPmc2jAI9dpl1XNboIUInLV1rUeM9em7GRvq1JIncmrt/VnHMGnVHHY1txq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(6133799003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak92KzljaU84WThwaVYwMERHVy94aHowalhxeEtvajk2OHRvek5pWGJXekl3?=
 =?utf-8?B?cTlsbUZEdVVqN3FkY2gzaEhpSXhOSDFjRDIxTDhMK1ozc1hqZjVEVnVJaFhr?=
 =?utf-8?B?cm52RFlzQ0pGR1E1ZkJpZm40S2NETDBYcmxwdEdoMWgyTUYvMnpYK21JTTJE?=
 =?utf-8?B?K3llNVhzdVBrWW9JU3d6aXNyMzlWZ0xzVU51cXJSaVJWKzBmbThWTS9wclZN?=
 =?utf-8?B?Rm5RODJYMGpWSmJlcitrOU91WjVsUjArWk1kUFJldE5TQ3ZDbjRJU09DU05E?=
 =?utf-8?B?ZWQwdnF4cXBaSzg2RDhYL0lXVG1RekZ6RU1rYUViTDlQOVBCNmVyWldRT2tO?=
 =?utf-8?B?MDNFRHluWnNuV29wN3RSY2dQNlNKUC9MQWt3VCsvV0U2c0dvMGxjcm5iZjdZ?=
 =?utf-8?B?SG9YNXEwajNjMVV5YzdpV0pGVlNVTldVNUk2Y3pRNDZKSjlDRXdrWHFFc1lq?=
 =?utf-8?B?K3FYVlZVTVAwQUtSeWp1dGEyQUd3YWhrVStuU3dUak1hZ1F4ZUxHdy9GOG4v?=
 =?utf-8?B?Uzk0ckc4QjU5U093ZUJ4dEJOSzNIcEc2WTNWOHlYRmUvMnJNU3NqakV1T0h3?=
 =?utf-8?B?T05rWTIwSjBkKzNqNlN1NS9zZWRHSVVFWk9zbUgvZXNyUG5PWlE1dU9vRU0y?=
 =?utf-8?B?cmEvdVVXUzlQVFJGRE04MFRDbUJxOThjWHpRY3U3TTV3Vk5xSzJxYmxrbWsv?=
 =?utf-8?B?RG0vVnlLcWVDeHRNd2hRRWU3UlRDQ3RvSFpjMThBT2ppaytFMXRyQ0FsRDEw?=
 =?utf-8?B?Z0hWTFlxM0dXSzVpeGZ6eHdtajY0MmZVUkgwL2VsWE5VR25ONXBaaHJ2cklC?=
 =?utf-8?B?Vk13ajZsWU9oNWJST2wwVjVWS1F3M0tZTndPTjQ3TXlXN0pxUlBxY1FONGpX?=
 =?utf-8?B?UjZyN2xiTGhLWEJnNEIzN09lRy8ybU9ENCtrcVhUU1B2a3RQUkR6VUpkUXdN?=
 =?utf-8?B?a1JPRTByUXByYUh2aXcyVlIySFBrMVlTL1hIY2UxNGd1R3F6L2czdCtIUmZa?=
 =?utf-8?B?NTJPa1g5VWtLWm9UU290ZkJpYko2MUF3RVNKSVF6d0JmTlp0RHJON3dSTHVl?=
 =?utf-8?B?a3IwRlRLcC82OXFOeWNnak1PVVl1OHRiREh6dkpmUU81SEFnVGNWWGUzR1lq?=
 =?utf-8?B?UWhJblJmWU1WMU56ZUg2TEM4aU1lOWVtdzlPczRHZjNhZzRZVmVVaXlvVC81?=
 =?utf-8?B?eUQ0WHR5TWJtTFBOQUxwQmVtcHRmNlNFQWhGejU0ckV3YW9XeDI4alFhaWxH?=
 =?utf-8?B?aFBnSTJ4c0NOcGZGM2J3WlN2TmN1TUVRbWQzeXBYTzV3ZWFIaDJ4N3hDY1VW?=
 =?utf-8?B?SEx2d0xoMnNTTXNDcjNKU3dsbnR6M1NDenk2Q0lnbUhvWDNnalJ5WmJ5eDRj?=
 =?utf-8?B?cmpvVHRNZkk0MW1OQzFIT0JOZXJ2T1V6dXN2S0RFU2pDdjBITUhUKzlobnMz?=
 =?utf-8?B?aXhBa0dZbE83aFZDQlVDZnhGTG9Fd2xzWWlBNEE4bm9aMkFFa0JGWndBWGxy?=
 =?utf-8?B?MitJMUcrSzZ0RDJOS25zU1VvMzBLc0w3d3plSUhDdW5NKzAyK285YzliYTRi?=
 =?utf-8?B?cXJLejRHQ0gvNVYxUVMyK0lOeUtRbmFBNmlrRUZTZnJqNi9kOVlyVFZhNGEr?=
 =?utf-8?B?TWpFTklIbGpkU0pmblFYSGIyaXpzMDNaTXB6MXB5bWhRQ1NnS3hSb1l0bW1U?=
 =?utf-8?B?YWVVQzF0eGtGQTRzMHNFd29uT3F5S2IvNUVRbW1zU1ZYdVZzSDB3UzBMN2Vn?=
 =?utf-8?B?cXg1KytKd1l6UnFCczU3dzhxZWFUbFUyaVk0WDJXNWMxVWRxL1N1cTJIcDU2?=
 =?utf-8?B?V05XN0FyNGoyNDhqNWtMdlB3WEllSE41L0FlZVBPNllRbnRXaVE5OTF5VU9Z?=
 =?utf-8?B?WTdlUGJwN0s5M2ZvSlhVeWdlRHZuSW1zWlhORFJicGRGeVE3andNUjE1YkJu?=
 =?utf-8?B?TkttbFFFODBKVXpsdG9IK2EzVEl0WHB1eVQ2VnU4dWZOR3B2bUVYQjJNUE9Q?=
 =?utf-8?B?NWJRL3FSdDd3TWZ3c3RZc1BxeHBVWWJMRVdTWnVCZjlOTzZiMGdtbXNmVm5h?=
 =?utf-8?B?ZVVoeEIvOWF0U05aYkRjNlNBYmFCcGNxRmVkbzRQMzI4UjVjZ2FjdFlvWUU1?=
 =?utf-8?B?cE1YQU4wUEpOVWlOd3Y1L3M4cE9FTHYrWHREN2l4T1kvcXU4cmlSbEVzcXFq?=
 =?utf-8?B?cy9mR2pYd1JocW1FREZWSU5uL2l1ZTBWNVdlaXpDOHVFTG9EaGVLY3BFTXJG?=
 =?utf-8?B?OWJkU0tTSjQxc2F3UG5WM2U2eXkyR2NPV0xaRERiVVJMaHh1a2ZId3lUNEZY?=
 =?utf-8?Q?dOjXQVfS8j4WLCtpWZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cad155d-2e7b-4fc1-a4fd-08debfe5dda6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:58:32.2174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TaFwyiaFoIswzz1VPVZFI/CZxmeE0F5Ns8vSEt3V/z79Gw7Z6eyrzZSR7D5uF5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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

On 6/1/26 15:51, Pierre-Eric Pelloux-Prayer wrote:
> 
> 
> Le 29/05/2026 à 13:24, Christian König a écrit :
>> Split amdgpu_vm_update_range into two functions.
>>
>> amdgpu_vm_map_range() is for mapping PTEs into a range and updates
>> which can be done while holding the VM lock.
>>
>> amdgpu_vm_unmap_range() is for unmapping PTEs without holding the VM
>> lock in MMU notifiers.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 112 ++++++++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  14 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  35 ++-----
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  16 ++--
>>   5 files changed, 120 insertions(+), 60 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> index 44fe40f9e8df..653ffa9ca0f3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> @@ -47,7 +47,7 @@ enum amdgpu_ib_pool_type;
>>   /* Internal kernel job ids. (decreasing values, starting from U64_MAX). */
>>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (18446744073709551615ULL)
>>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (18446744073709551614ULL)
>> -#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (18446744073709551613ULL)
>> +#define AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE           (18446744073709551613ULL)
> 
> Not reusing the same ID would make it easier for umr, but it's not a blocker so you can keep the code as is if you prefer.

The update_range is replaced by the map_range in almost all cases. Only the unmap_range from an MMU notifier is specially handled now.

The term "map_range" is also kind of misleading since we also use it for unmapping during regular BO free, but I couldn't come up with a better name.

Maybe just keep the name update_range like it is and add unmap_range as special case? Idk.

Christian.

> 
> Pierre-Eric
> 
>>   #define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (18446744073709551612ULL)
>>   #define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
>>   #define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (18446744073709551610ULL)
>> @@ -63,6 +63,7 @@ enum amdgpu_ib_pool_type;
>>   #define AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST         (18446744073709551600ULL)
>>   #define AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST          (18446744073709551599ULL)
>>   #define AMDGPU_KERNEL_JOB_ID_RUN_SHADER             (18446744073709551598ULL)
>> +#define AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE         (18446744073709551597ULL)
>>     struct amdgpu_job {
>>       struct drm_sched_job    base;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index edc8b1ca2d3e..b5adfcacc55a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1080,11 +1080,10 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>   }
>>     /**
>> - * amdgpu_vm_update_range - update a range in the vm page table
>> + * amdgpu_vm_map_range - map something to a range in the vm page tables
>>    *
>>    * @adev: amdgpu_device pointer to use for commands
>>    * @vm: the VM to update the range
>> - * @unlocked: unlocked invalidation during MM callback
>>    * @flush_tlb: trigger tlb invalidation after update completed
>>    * @allow_override: change MTYPE for local NUMA nodes
>>    * @sync: fences we need to sync to
>> @@ -1097,23 +1096,26 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>    * @pages_addr: DMA addresses to use for mapping
>>    * @fence: optional resulting fence
>>    *
>> - * Fill in the page table entries between @start and @last.
>> + * Fill in the page table entries between @start and @last. Allocate and free
>> + * new page tables as needed. Can only be called while holding the VM lock.
>>    *
>>    * Returns:
>>    * 0 for success, negative erro code for failure.
>>    */
>> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> -               bool unlocked, bool flush_tlb, bool allow_override,
>> -               struct amdgpu_sync *sync, uint64_t start,
>> -               uint64_t last, uint64_t flags, uint64_t offset,
>> -               uint64_t vram_base, struct ttm_resource *res,
>> -               dma_addr_t *pages_addr, struct dma_fence **fence)
>> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +            bool flush_tlb, bool allow_override,
>> +            struct amdgpu_sync *sync, uint64_t start,
>> +            uint64_t last, uint64_t flags, uint64_t offset,
>> +            uint64_t vram_base, struct ttm_resource *res,
>> +            dma_addr_t *pages_addr, struct dma_fence **fence)
>>   {
>>       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>>       struct amdgpu_vm_update_params params;
>>       struct amdgpu_res_cursor cursor;
>>       int r, idx;
>>   +    amdgpu_vm_assert_locked(vm);
>> +
>>       if (!drm_dev_enter(adev_to_drm(adev), &idx))
>>           return -ENODEV;
>>   @@ -1138,7 +1140,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>       params.adev = adev;
>>       params.vm = vm;
>>       params.pages_addr = pages_addr;
>> -    params.unlocked = unlocked;
>>       params.needs_flush = flush_tlb;
>>       params.override_pte = allow_override && adev->gmc.override_pte;
>>       INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>> @@ -1149,7 +1150,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>           goto error_free;
>>       }
>>   -    if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>> +    if (!dma_fence_is_signaled(vm->last_unlocked)) {
>>           struct dma_fence *tmp = dma_fence_get_stub();
>>             amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
>> @@ -1158,7 +1159,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>       }
>>         r = vm->update_funcs->prepare(&params, sync,
>> -                      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
>> +                      AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE);
>>       if (r)
>>           goto error_free;
>>   @@ -1234,6 +1235,77 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>       return r;
>>   }
>>   +/**
>> + * amdgpu_vm_unmap_range - clear leave PTEs to unmap something
>> + *
>> + * @adev: amdgpu_device pointer to use for commands
>> + * @vm: the VM to update the range
>> + * @sync: fences we need to sync to
>> + * @start: start of unmapped range
>> + * @last: last unmapped entry
>> + * @flags: flags for the entries
>> + * @fence: optional resulting fence
>> + *
>> + * Fill in the page table entries between @start and @last with a fixed flags
>> + * value without allocating or freeing page tables. Can be used without locking
>> + * the VM.
>> + *
>> + * Returns:
>> + * 0 for success, negative erro code for failure.
>> + */
>> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +               struct amdgpu_sync *sync, uint64_t start,
>> +               uint64_t last, uint64_t flags,
>> +               struct dma_fence **fence)
>> +{
>> +    struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>> +    struct amdgpu_vm_update_params params;
>> +    int r, idx;
>> +
>> +    if (!drm_dev_enter(adev_to_drm(adev), &idx))
>> +        return -ENODEV;
>> +
>> +    tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
>> +    if (!tlb_cb) {
>> +        drm_dev_exit(idx);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    memset(&params, 0, sizeof(params));
>> +    params.adev = adev;
>> +    params.vm = vm;
>> +    params.needs_flush = true;
>> +    params.unlocked = true;
>> +    INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>> +
>> +    amdgpu_vm_eviction_lock(vm);
>> +    if (vm->evicting) {
>> +        r = -EBUSY;
>> +        goto error_free;
>> +    }
>> +
>> +    r = vm->update_funcs->prepare(&params, sync,
>> +                      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
>> +    if (r)
>> +        goto error_free;
>> +
>> +    amdgpu_vm_update_leaves(&params, start, last, 0, flags);
>> +
>> +    r = vm->update_funcs->commit(&params, fence);
>> +    if (r)
>> +        goto error_free;
>> +
>> +    amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
>> +    amdgpu_vm_pt_free_list(adev, &params);
>> +    tlb_cb = NULL;
>> +
>> +error_free:
>> +    kfree(tlb_cb);
>> +    amdgpu_vm_eviction_unlock(vm);
>> +    drm_dev_exit(idx);
>> +    return r;
>> +}
>> +
>>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>                 struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>>   {
>> @@ -1362,11 +1434,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>             trace_amdgpu_vm_bo_update(mapping);
>>   -        r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
>> -                       !uncached, &sync, mapping->start,
>> -                       mapping->last, update_flags,
>> -                       mapping->offset, vram_base, mem,
>> -                       pages_addr, last_update);
>> +        r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
>> +                    mapping->start, mapping->last,
>> +                    update_flags, mapping->offset,
>> +                    vram_base, mem, pages_addr,
>> +                    last_update);
>>           if (r)
>>               goto error_free;
>>       }
>> @@ -1565,9 +1637,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>               struct amdgpu_bo_va_mapping, list);
>>           list_del(&mapping->list);
>>   -        r = amdgpu_vm_update_range(adev, vm, false, true, false,
>> -                       &sync, mapping->start, mapping->last,
>> -                       0, 0, 0, NULL, NULL, &f);
>> +        r = amdgpu_vm_map_range(adev, vm, true, false,
>> +                    &sync, mapping->start, mapping->last,
>> +                    0, 0, 0, NULL, NULL, &f);
>>           amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>           if (r) {
>>               dma_fence_put(f);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 3e86a2a470f0..561f2873d2ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -529,12 +529,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>>                   uint32_t xcc_mask);
>>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>                   struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> -               bool unlocked, bool flush_tlb, bool allow_override,
>> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +            bool flush_tlb, bool allow_override,
>> +            struct amdgpu_sync *sync, uint64_t start,
>> +            uint64_t last, uint64_t flags, uint64_t offset,
>> +            uint64_t vram_base, struct ttm_resource *res,
>> +            dma_addr_t *pages_addr, struct dma_fence **fence);
>> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                  struct amdgpu_sync *sync, uint64_t start,
>> -               uint64_t last, uint64_t flags, uint64_t offset,
>> -               uint64_t vram_base, struct ttm_resource *res,
>> -               dma_addr_t *pages_addr, struct dma_fence **fence);
>> +               uint64_t last, uint64_t flags,
>> +               struct dma_fence **fence);
>>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>               struct amdgpu_bo_va *bo_va,
>>               bool clear);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 6f5415d5a1bc..ac3f3e31e2e2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -553,7 +553,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>>                   struct amdgpu_vm_update_params *params)
>>   {
>>       struct amdgpu_vm_bo_base *entry, *next;
>> -    bool unlocked = params->unlocked;
>>         if (list_empty(&params->tlb_flush_waitlist))
>>           return;
>> @@ -561,7 +560,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>>       /*
>>        * unlocked unmap clear page table leaves, warning to free the page entry.
>>        */
>> -    WARN_ON(unlocked);
>> +    WARN_ON(params->unlocked);
>>         list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
>>           amdgpu_vm_pt_free(entry);
>> @@ -801,24 +800,17 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>           uint64_t incr, entry_end, pe_start;
>>           struct amdgpu_bo *pt;
>>   -        if (!params->unlocked) {
>> -            /* make sure that the page tables covering the
>> -             * address range are actually allocated
>> -             */
>> -            r = amdgpu_vm_pt_alloc(params->adev, params->vm,
>> -                           &cursor);
>> -            if (r)
>> -                return r;
>> -        }
>> +        /* make sure that the page tables covering the
>> +         * address range are actually allocated
>> +         */
>> +        r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
>> +        if (r)
>> +            return r;
>>             shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
>>           parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
>> -        if (params->unlocked) {
>> -            /* Unlocked updates are only allowed on the leaves */
>> -            if (amdgpu_vm_pt_descendant(adev, &cursor))
>> -                continue;
>> -        } else if (adev->asic_type < CHIP_VEGA10 &&
>> -               (flags & AMDGPU_PTE_VALID)) {
>> +        if (adev->asic_type < CHIP_VEGA10 &&
>> +            (flags & AMDGPU_PTE_VALID)) {
>>               /* No huge page support before GMC v9 */
>>               if (cursor.level != AMDGPU_VM_PTB) {
>>                   if (!amdgpu_vm_pt_descendant(adev, &cursor))
>> @@ -864,14 +856,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>           mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>>           pe_start = ((cursor.pfn >> shift) & mask) * 8;
>>   -        if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
>> -            /*
>> -             * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
>> -             * only clear one entry. Next entry search again for PDE or PTE leave.
>> -             */
>> -            entry_end = 1ULL << shift;
>> -        else
>> -            entry_end = ((uint64_t)mask + 1) << shift;
>> +        entry_end = ((uint64_t)mask + 1) << shift;
>>           entry_end += cursor.pfn & ~(entry_end - 1);
>>           entry_end = min(entry_end, end);
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 37b5166e9a14..d0ea20dea3e1 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1372,9 +1372,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>           return -EINVAL;
>>       }
>>   -    return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
>> -                      gpu_end, init_pte_value, 0, 0, NULL, NULL,
>> -                      fence);
>> +    return amdgpu_vm_unmap_range(adev, vm, NULL, gpu_start, gpu_end,
>> +                     init_pte_value, fence);
>>   }
>>     static int
>> @@ -1489,12 +1488,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>>                (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>>                pte_flags);
>>   -        r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
>> -                       NULL, gpu_start, gpu_end,
>> -                       pte_flags,
>> -                       (last_start - prange->start) << PAGE_SHIFT,
>> -                       bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
>> -                       NULL, dma_addr, &vm->last_update);
>> +        r = amdgpu_vm_map_range(adev, vm, flush_tlb, true, NULL,
>> +                    gpu_start, gpu_end, pte_flags,
>> +                    (last_start - prange->start) << PAGE_SHIFT,
>> +                    bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
>> +                    NULL, dma_addr, &vm->last_update);
>>             for (j = last_start - prange->start; j <= i; j++)
>>               dma_addr[j] |= last_domain;


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63B1C6FA82
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 19:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259D310E17C;
	Mon, 12 Sep 2022 19:00:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D5610E17A
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 18:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvLp/kkz5AlAw6cEFoOvXwy5PrUtxXPFcAZ3QlIGhUuAuqd9RCmGNxvqBFHRMl3WGQ6zF3XN3PrspoweZBm1Jokbq0Stb5F7ydRx+LtazbjyUYURKAYTTsqN0//vBQwbT5hgKmt3TXbZGUc4ae2W6uIGbW2AsHv1mhgMYfhb+l50YdkhWD2djrNk13mUJKdGoVp9236Y16rRyAbEOeQLw2g9biR3I9ev2uTugC65s1lYrHh6Nk3tz1jzLyoB14smZtJ4hjC0f4zvQCeDdQ1ShizcVPX0iQh3P4LSPFFGz04OG9KgJrgxhxOoI4fPJy5bgmTsC4T6NdeHw+c9p8k7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8JFuFFZW9RjTzubwGfbu4YeIZggjv2Kslfa/Zogdao=;
 b=Z7MPR3xuERZPPhtQ2m1TeWSH2Uj7ljtoDrpg5xGKD3BWzKJf6vkG43soYbFYma13Mn5JB4riDJfmvQvSGFLcn5zjF/a0hWmFo/vnKRYfxHAZNIFUDCHrQ9/vnI5IWr0bFTcQlefv3MF87YRbn2m5KN7p5SmaQg3kN34bYywSxupI2qyTOGEjaRsF2VWz8/E7kAcMewoCFySgUNw2ScX2/ihTG8Z8DReo0IpD14xsQjdmq/975PdiTUFKG8yeZsfi5bcHGfvb1neeq9tg8EBkO81AjXGffvMUIjrHVwkYXhIY8DK5pWf4BNa3IK1Aha/FSwJFj3pt8yDWG/HCMIC9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8JFuFFZW9RjTzubwGfbu4YeIZggjv2Kslfa/Zogdao=;
 b=JdA6jh56hRgWw6DiduPrS0QlngFVwg7E/kTC4/NlNwL7TeSsAorWDXXiviyjN4gh7wLqP4nzkhz3NbVguVNlUlNrfbc40w6dOX/9J0ujHl7v7J8+NqanENc1sj9uG7vT6UvqZlXqi/jbXcQSHxcabwIo7AsPq/5ukYdtYuVxE7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5250.namprd12.prod.outlook.com (2603:10b6:610:d1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 18:59:54 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 18:59:53 +0000
Message-ID: <4b34d62a-b34d-1ab9-a3cb-032a1b6e580e@amd.com>
Date: Mon, 12 Sep 2022 20:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220912175817.17985-1-Philip.Yang@amd.com>
 <6e223900-7b8a-8ec6-e08d-aee0697a1aa0@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <6e223900-7b8a-8ec6-e08d-aee0697a1aa0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH0PR12MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5fc104-62b2-4bea-6c9f-08da94f0f9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mSqCkcZ63qm/CljLIQ4f+b16Sf00cr8FPY9aQ5TWjMykznpkGNhXkMekeCiqBBAycGoR7fR2apGweTtodzTX+UxQsBYq6Oz6+ofYhid6N0Wq3DuSgr/ILcNexA7GHpdwXhCEu7jaRJHWKt+fi0o7OO05bwz4msDS4cXZ/FyErZXud3iE64JnrstCe+pGPkyfKPkuUSumanaoPW26sZvOQo/b+3ouWv0cLjSkS4kSDwlSI2UfnNjmp6Vk9PO0O5z9xvtnEmHAYDBernBRh6iUlMnhANgHclUAZ69ys4OSeOF4OlAgqf88TiP8n0Hj8nheLfwP9DQMzmgtF/PkpVOpv+P3RAehBjAgsjCwLOtUIdA5S3WaItjk0RnIeKeSBWYofxDo17IL9r03GmG8Hrd4kr9Vke8aj/udjG1yb3kF7BcTlMOUcXpYmtmkb9KT3yihHqvLYBFYieK4LguKwjwwYCxyrTr5ELs6xVUgLCWhTdTQXDrFbivP4lQ39d9ZGwIvpd2Srd5Crm8SLXZ+LmuTBwY/GUCwvVl5s1PZ0NBzLQiqdauMF/UOwC/Vx8SCAS+C/gPeGFNuLqwntSyy5UBAn9gXr+lLYPvuxwTzDvOXCWC59nvtr9rE1Eclv9Go+aHefCIsoLdZeSigXZSPYGXfuYoX7fJVq1oXUC/g9R7kZzYdAF9YIVnA3R5IzZ7X3CxppsklAjAX1VGrWREBfw+Nq2JWkaWfSUYk/iMs5pRpPSvnUBfpsFmGojPkKNO6h5epU2GDBLvH0EYnAUnxQoTkWaARzNXmfIY/vubMpHOJns=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199015)(186003)(110136005)(31696002)(6666004)(86362001)(2616005)(41300700001)(6512007)(38100700002)(478600001)(6486002)(6506007)(31686004)(8676002)(2906002)(66946007)(5660300002)(83380400001)(316002)(8936002)(66556008)(66476007)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0Z5TGNUd2tDUkxRdWkwQ3QvdU5wU2ZObEJJdEhhUjM0ZC9QMWpCb0tocUpn?=
 =?utf-8?B?OEZQM1k1VWpEczYxU0ttQ0tQbEpOK0NhMERPTWZrc1JGc3BDM1Fjbkt0dGVp?=
 =?utf-8?B?UGRoU0lTdkpiNTJKQWtkbFpOMWxLSlhzYThyM01FRDVaSUJFdHNzRW5jSWtl?=
 =?utf-8?B?KzBjQnBBUzdQSUJnTnNJb3ZOem9wYnJzQWg3R3dWUUwxNlQwNVk2R2FRZlBI?=
 =?utf-8?B?dEpXRTlIdmxycms1QUttTWVxaW0vY1prRFlFNmZQYk9hVDYzcDhhZWxpYTlI?=
 =?utf-8?B?ckpzODhOcEdTQ1pERU9sV0YrWWM5SS8vcFhOOWswalZac0RnKzFpL1VyOTJV?=
 =?utf-8?B?WW8ra1pGVEEwUDV1RGVXNlM0b1BmSUR5Z09nTUxZek9XcndUS25SelJ5V0Iz?=
 =?utf-8?B?N2hjNXRvSDBxUzJNbWcxZmZqamQ0Z2dLTytxc2tWK2JVRzV5WFpOaUdiU25D?=
 =?utf-8?B?ZG9RUHdrVXNwZy82RnZnRFVzZ25qSGVZWElBYmFPWW5wby9tVWNtZVFhNDBr?=
 =?utf-8?B?YkRvUks0emlNT2QyTUM3ZWRFTzdsK25WNUJJVmo4ck9zU1Uzais4d0RhUjVn?=
 =?utf-8?B?eE1rNSsva3AwSGcvLzRMUEFnWU0xcVJJQkhlVVFrRW9MSGxJMG5EYUc5Wks0?=
 =?utf-8?B?TS9qRk44WUsyRUVGSGJvSkM2Z3JxT2txeU5nRjhqZHNBMmYrdkIxaEw0c0s0?=
 =?utf-8?B?cm9rUVdKcWFMemt6ZHQ4RExzamJUYStHakQrU2F5eFpYN1lhQWtMdzhzNEJM?=
 =?utf-8?B?Z2JVZzAvYXRSQy90c01hRmVJeTF5OFRza0ZVZlNRQW1ERXkxZkVHM3Y4UnIr?=
 =?utf-8?B?M2MvbXAxRHZ0aFR4SDNqNWN2ck5ZZnJWS25pMC9tODFsQUNjVW9qR1RvSEVR?=
 =?utf-8?B?M1NVNUhJVTc3aUFPNlVqd2FXVzlkQnRTUlQwcTQ3M0JmNnd4dDBISzJ5Tmd3?=
 =?utf-8?B?cFF2QStLakxFMFhmOE5NUmtzUG1Pc0t3RlkycEtKSXF3L2lpL1QrZ3lpQ2NV?=
 =?utf-8?B?Slc2UWNzSUQ2TXc3UmdEQ0JRMWM3cnJ6NzdCVVFsYVhqN1V5RjJyU2txVlJM?=
 =?utf-8?B?ZEQ2NVhTeVRYMld5TFpQWHBCOFk2eGZZdkRJemkzSVpBWktWNmJ0d0diNHRF?=
 =?utf-8?B?dzE3T0x0K2c2RWg2bXZPemlHMjVEcXcrUldKbXhJOEpHWEhEZm1hcnVWUmcx?=
 =?utf-8?B?NW8wRGNORk1aa0QvVnN6cmRlUHdPZm9ZeURENi9qQzVsVkZneGJzUjkyQTQx?=
 =?utf-8?B?QXVVT3drMEtjc2xlWDV3Z2NBd2pnVTl4VHpoTGF3OHlMVDl4ZFJ5eU1YaStM?=
 =?utf-8?B?VTJacFJ0cVRUT3BkaUlmZnJxWW1sbEIxQzQwTHVPVE1peTZHUm4rdmlUUzVp?=
 =?utf-8?B?VE9TTS83VGZFbWlqUkVQWFB5QjlMb3I5WHc2dDFkSEpQMlp0T2JLWkxmVGMz?=
 =?utf-8?B?eXcxT0MxOFlTRm1PajJaSklzY3Y4ek15SXpHdzlhYWlXU21keEM0cU45b2pn?=
 =?utf-8?B?UDFJZnRVWHo4bEdPZk5vUDRENHh2NG9oME95QXRmbkFjcWFPZE93Q2pOYTYy?=
 =?utf-8?B?OXNMdGx5NkUxSnJxWmE1SGZqdXVJSjdaSy83bzBLbXNzejdRNFMvcHFnWmEz?=
 =?utf-8?B?WStaK3VFUzU0UDVUbXNia1RmZXpBRHV6SVcvQXJoUXhrU2thdFIrWGRhcDFa?=
 =?utf-8?B?MXQ3OFZhWXZqMkIxVElNbWNacXlZVzk4OG96KzJGMTN5d241SnV4ZE45MUpZ?=
 =?utf-8?B?REZXN2pGMG8zbmxHeXo2Q3RGNHg4ZWY0V3g0RytURmRpVUtka2txK2trMWVL?=
 =?utf-8?B?c3puS05mdnNiTE9ZRjFLODBtQUh2c0FocXcxNldMYXcrenFPMWdDOS9raWVl?=
 =?utf-8?B?U3IyVmY3b3lCNGw2OURDS2lxVnllWmNwTXNUNyswaGdiZzVFUW04NS9JRFJq?=
 =?utf-8?B?L2M1cHhCRVBrcmErRzFYTVVkdjVuSGc1UEQ3cmtIZmR6NFNjb3pDM2JQbGZ1?=
 =?utf-8?B?UXhPVUJ6bEV0M08vMWIydzB4N1F2VFg1YUN6UHQ5KzJJLzNzT2JyRC9BKytI?=
 =?utf-8?B?NDBSZ1hmb0RFd3hSZTNUallVMHFtODBQRnNqcFBoQllYODVLUHZ3ZlNBOVU0?=
 =?utf-8?B?d1ZnSkhhMlZ4Q1ZKdFM4dnZ2dzJDUzRVdWs1WFA3SDhuK2FnRENSQ29TTFVV?=
 =?utf-8?Q?eboh48f8GTDlABiau7p36loo4nWqzqRGSn9aFCqF+P7W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5fc104-62b2-4bea-6c9f-08da94f0f9f1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 18:59:53.5569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wV3GMi4Bwki4gDMrPmHFIbvaZ7zVtCCjEyCnmYe4YjcQfjEP7oFyRaJxB/QXlptM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5250
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



Am 12.09.22 um 20:48 schrieb Felix Kuehling:
> Am 2022-09-12 um 13:58 schrieb Philip Yang:
>> Free page table BO from vm resv unlocked context generate below
>> warnings.
>>
>> Add a free_bo_work in vm to free page able BO from vm->bo_freed list.
>> pass vm resv unlock status from page table update caller, and add vm_bo
>> entry to vm->bo_freed_list and schedule the work if calling with vm resv
>> unlocked.
>>
>> WARNING: CPU: 12 PID: 3238 at
>> drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
>> Call Trace:
>>   amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>>   amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>>   amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>>   amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>>   svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>>   svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>>   unmap_vmas+0x9d/0x140
>>   unmap_region+0xa8/0x110
>>
>> WARNING: CPU: 0 PID: 1475 at
>> drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
>> Call Trace:
>>   dma_resv_iter_first+0x43/0xa0
>>   amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
>>   amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
>>   amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
>>   svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
>>   svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
>>   __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>   unmap_vmas+0x140/0x150
>>   unmap_region+0xa8/0x110
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 51 ++++++++++++++++++++---
>>   3 files changed, 55 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 59cac347baa3..add3b08ffde9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2022,6 +2022,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>       spin_lock_init(&vm->invalidated_lock);
>>       INIT_LIST_HEAD(&vm->freed);
>>       INIT_LIST_HEAD(&vm->done);
>> +    INIT_LIST_HEAD(&vm->bo_freed);
>> +    INIT_WORK(&vm->bo_free_work, amdgpu_vm_pt_free_work);
>> +    spin_lock_init(&vm->bo_free_lock);
>>         /* create scheduler entities for page table updates */
>>       r = drm_sched_entity_init(&vm->immediate, 
>> DRM_SCHED_PRIORITY_NORMAL,
>> @@ -2244,6 +2247,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>           amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>>       }
>>   +    cancel_work_sync(&vm->bo_free_work);
>>       amdgpu_vm_pt_free_root(adev, vm);
>>       amdgpu_bo_unreserve(root);
>>       amdgpu_bo_unref(&root);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 9ecb7f663e19..c8c59c66ca2f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -276,6 +276,11 @@ struct amdgpu_vm {
>>       /* BOs which are invalidated, has been updated in the PTs */
>>       struct list_head        done;
>>   +    /* PT BOs scheduled to free and fill with zero if vm_resv is 
>> not hold */
>> +    struct list_head    bo_freed;
>> +    struct work_struct    bo_free_work;
>> +    spinlock_t        bo_free_lock;
>> +
>>       /* contains the page directory */
>>       struct amdgpu_vm_bo_base     root;
>>       struct dma_fence    *last_update;
>> @@ -471,6 +476,7 @@ int amdgpu_vm_pde_update(struct 
>> amdgpu_vm_update_params *params,
>>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>                 uint64_t start, uint64_t end,
>>                 uint64_t dst, uint64_t flags);
>> +void amdgpu_vm_pt_free_work(struct work_struct *work);
>>     #if defined(CONFIG_DEBUG_FS)
>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct 
>> seq_file *m);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 88de9f0d4728..12471ef126a9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -624,12 +624,22 @@ static int amdgpu_vm_pt_alloc(struct 
>> amdgpu_device *adev,
>>    *
>>    * @entry: PDE to free
>>    */
>> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>> +static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry, bool 
>> unlocked)
>>   {
>>       struct amdgpu_bo *shadow;
>>         if (!entry->bo)
>>           return;
>> +
>> +    if (unlocked) {
>> +        spin_lock(&entry->vm->bo_free_lock);
>> +        list_move(&entry->vm_status, &entry->vm->bo_freed);
>> +        spin_unlock(&entry->vm->bo_free_lock);
>> +
>> +        schedule_work(&entry->vm->bo_free_work);
>> +        return;
>> +    }
>> +
>>       shadow = amdgpu_bo_shadowed(entry->bo);
>>       if (shadow) {
>>           ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>> @@ -641,6 +651,33 @@ static void amdgpu_vm_pt_free(struct 
>> amdgpu_vm_bo_base *entry)
>>       amdgpu_bo_unref(&entry->bo);
>>   }
>>   +void amdgpu_vm_pt_free_work(struct work_struct *work)
>> +{
>> +    struct amdgpu_vm_bo_base *entry;
>> +    struct amdgpu_vm *vm;
>> +    struct amdgpu_bo *root;
>> +
>> +    vm = container_of(work, struct amdgpu_vm, bo_free_work);
>> +
>> +    root = amdgpu_bo_ref(vm->root.bo);
>> +    amdgpu_bo_reserve(root, true);
>> +
>> +    spin_lock(&vm->bo_free_lock);
>> +    while (!list_empty(&vm->bo_freed)) {
>> +        entry = list_first_entry(&vm->bo_freed, struct 
>> amdgpu_vm_bo_base,
>> +                     vm_status);
>
> I don't see where you're removing the entry from the list. You need a 
> list_del_init here.
>
> If you're relying on the list_del call in amdgpu_vm_pt_free, that's 
> not safe because it's outside the spinlock. This could end up 
> corrupting the list if another thread is concurrently adding to the 
> same list.

It's much easier to use list_splice() to move the list to a local head 
and then traverse it with list_for_each_entry_safe() and free up everything.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>> + spin_unlock(&vm->bo_free_lock);
>> +
>> +        amdgpu_vm_pt_free(entry, false);
>> +
>> +        spin_lock(&vm->bo_free_lock);
>> +    }
>> +    spin_unlock(&vm->bo_free_lock);
>> +
>> +    amdgpu_bo_unreserve(root);
>> +    amdgpu_bo_unref(&root);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>>    *
>> @@ -652,16 +689,17 @@ static void amdgpu_vm_pt_free(struct 
>> amdgpu_vm_bo_base *entry)
>>    */
>>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>                     struct amdgpu_vm *vm,
>> -                  struct amdgpu_vm_pt_cursor *start)
>> +                  struct amdgpu_vm_pt_cursor *start,
>> +                  bool unlocked)
>>   {
>>       struct amdgpu_vm_pt_cursor cursor;
>>       struct amdgpu_vm_bo_base *entry;
>>         for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>> -        amdgpu_vm_pt_free(entry);
>> +        amdgpu_vm_pt_free(entry, unlocked);
>>         if (start)
>> -        amdgpu_vm_pt_free(start->entry);
>> +        amdgpu_vm_pt_free(start->entry, unlocked);
>>   }
>>     /**
>> @@ -673,7 +711,7 @@ static void amdgpu_vm_pt_free_dfs(struct 
>> amdgpu_device *adev,
>>    */
>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm)
>>   {
>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL);
>> +    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>   }
>>     /**
>> @@ -966,7 +1004,8 @@ int amdgpu_vm_ptes_update(struct 
>> amdgpu_vm_update_params *params,
>>                   if (cursor.entry->bo) {
>>                       params->table_freed = true;
>>                       amdgpu_vm_pt_free_dfs(adev, params->vm,
>> -                                  &cursor);
>> +                                  &cursor,
>> +                                  params->unlocked);
>>                   }
>>                   amdgpu_vm_pt_next(adev, &cursor);
>>               }


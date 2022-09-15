Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CE2ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 06:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E047B10EA86;
	Thu, 15 Sep 2022 06:21:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABDD10EA86
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 06:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8IMnAcdmC0igXUnc4ZD2bhDg+mv07UscOU4lNpTFyHp2dJyruz5UR4jxcCDMy9t/gudfwlbyhWLyEEKY8h4mQ7WYlqQzBdCzNtyoY9MbWPsdmaMlvNphkO0auKJZXb+KZZcqwroOKBjvnmV0ciY7o3B8LQcYnnTJKlU7MSHyZ2KSji3UAT5pl5AeN3gzSPmmjYgdtuVTaZJMO2g4X1e5L35f6pHdCM62p2KxKhpdGgO+gwrpG5/5WPFOFbtBt3D/cwvyQUcOhw2h6W3rFnRqo0rPQOBdeGmwaiKsgQo69XsxRWUbF+WkqGqumj09OiaTziAykmpOFF7PcrVmxcqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCGtxwW6ZUbF1STv5Vxuudo6Ebg/yepnFdl8tpoE/vQ=;
 b=MiwgIRI+MCsNt+w568sIhQD8jVNfbsNj6NzcVzl4Q2GtBbPrs7Qb4FLt6tg0p8TSsL5YstEq5cSzaK/+8kYmC7cFd+Ub5K4beSJkWeMtyHDf1QyECJgp+YQMxaozshqc6u6MUOlduhC5C6xl4mQ4c/I3MBFMxbXluKFCZZuufltNdZyDc24PUe4wz4FvVifp2yVUTwin8GPVCZ6rdXktb12FEOOe7h9rZWll8dTRctwd11w0/TdmWlXWQAS5Cf5yPuKDj+X4R0LhdxYdhSnC8X44OoDIGfgdoFuRvIqKszBpnckAX8FpIaZT9Ru8NSBxyl4qubk1v7WJqhitScrktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCGtxwW6ZUbF1STv5Vxuudo6Ebg/yepnFdl8tpoE/vQ=;
 b=kXWORKou6R2XjONYy+AECCybAakWFZ1Srj7bJrHVS7ADdofcY5zHvNn6+cOeGxVTbLzVYftp5MohHJ96XiR5M40M2pxHAeBhkaEKql0GOIUBY7Hq1HWr1veDMGpite+PQTOHXrvWzFTmFYNvXbAd557RgSj3326mzP508mDELV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 06:21:41 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 06:21:41 +0000
Message-ID: <de2064d2-1a30-4b88-855e-0207bb68aefc@amd.com>
Date: Thu, 15 Sep 2022 08:21:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/1] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220914160842.9610-1-Philip.Yang@amd.com>
 <e95c37e7-d8c8-3802-63a1-92b5f6b579ef@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <e95c37e7-d8c8-3802-63a1-92b5f6b579ef@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P195CA0079.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: fd50a7a2-3141-4ba2-082f-08da96e28dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69j6ITObERwzFfOzO+KFnull9m8GRTiEdByg7VbzavIom7cCv6G9MS81vsFcR7fvIJOKaVkZDSYNCYRctqNbNgE5jpQs2b39IKT1yRRiXUBWrfi4KALLtpQJ9nJ3JPs7b6+tBjDq6e9Xyw34CuSxJsJ7jurK7T7h959nZ4/FeIwZ7D/vpAkvvZegQeJt+f+iiRzgxDSD1PyZdKsmkccoOiJ2xhc1z4c/OdNbSvnBhFH5+YJcNvAq8BoQZcTuGoQ40ycvlC2qEmrmWRyehDiFV8ZGcaC4+9Wt9jhTGCBl18H5VlWMY0zBrwXAyaQgWjDmyYZfyRiBehQYQunEqwEYKVbNXZ9PgZ1B5Jqri1LplPc/+nFEzDlB8PcJ1QJ7+JDaql7xUTeJV+5D7d6x4jjURT7otJ+OL22zLhNnLpJRgGRsbRcBSCfHNtGmYeIIEwg6cSPlWphwLyyZsVp8d8bSWsXzRs0KZVdKYUGn6Ee5xwP8dv+lG0+HTEwiYlsNtxGpptKveDftinruV+mm1YUW579kBdSYaYEOlAZRlq6H1/0XabCPRqcuEx50CI8M5rnyqyylaOfHxvulylCsg9bqEVZBUCRhuMFgc/jWjbzJoduHO7oUx7oxBVBvQ1gcxzuRpHmJbLq+grssT+fPisjwe0pi6jAqIPScVA3MPAgmCXFQVAegh1xVo1XQOd/waQMid+Tid8SOkImq/no59XI44tm3/EdbHvXHoGpqTttbtIWc+Mc9E6dymQ0qfjJgmmBOP2ZRbItHFzJDUtvtY6aUWA/9Ek6ovn/3riStd3sl2oI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(6666004)(38100700002)(5660300002)(36756003)(110136005)(6506007)(86362001)(8676002)(66556008)(8936002)(83380400001)(66476007)(2616005)(31696002)(6486002)(316002)(6512007)(41300700001)(186003)(26005)(2906002)(31686004)(66946007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFNvZG1vTGp3SzRiMU5IbHo4NWU3dmJYUjJmVEVGdnZWSXlvRTZkQmZkdFNn?=
 =?utf-8?B?UFJxM1RweHVOYU1ydm5XSDljMmVPRkxpUmJGQkNQNWtSVGdYMjFUY1M3Umt6?=
 =?utf-8?B?czZRTjFpWmhveDgzZTdRSXZ6ejdnMFdJUUZFVlJiT2xMcGQ5MW5sVkU2eG9q?=
 =?utf-8?B?K2FRUXpObkFCanNmd1hmQzhJSlZ6UjkwWjVRNFgwcitaUC9BUTk2NWVUQUkz?=
 =?utf-8?B?YVpGOCtHKzBtZ0ppUkowWW5UUytQM0wrUmgyekFTMDZYZ1pjdDgvV0pCWWFx?=
 =?utf-8?B?OU9YTXVPTFpVVFhhNFVXMXlJdmhGUmd2NXN3QnVuaFhjM1p5VjM2a1B3eDFI?=
 =?utf-8?B?VjRWaVoydVZqU21FNFNCdUV2OW9LVHRjRzcxUDFtbjhuSXg3TVhWVGluZTRQ?=
 =?utf-8?B?dUdzM0hnVENVb09rWUUrK01XbTBpRk95ZTJjRk5QdTQ2dzJTYVh0TGF2bllj?=
 =?utf-8?B?U0tKR1ZDaUVxSHZGdlhheU9tVnl1RGZQQzBzYTVQTzAyZ2FtWU4rR0pRaWNL?=
 =?utf-8?B?V3ZpbkwrajJUVEpnNTJNNGFneWxjeFdyRmQ2NFVqVE9ZSU1mU1o0MVVnNnY3?=
 =?utf-8?B?eHNzbWxUZGhlREJ1c01kN3BKa1hwYi9EblNVeEZ5YUplS1l1ODlGbXRCTzNO?=
 =?utf-8?B?Y3B4WG9QWXpDNFBHRFN4ZW9nOHdqVmtmY1pUS3daeXkzYjdSRXRpT0MvemFC?=
 =?utf-8?B?d2pyMGt6eWIvQ2J4akd4M0RUM05jUElkM3J0Nng2a2x6K0orUERGQnUrd2hM?=
 =?utf-8?B?akJGM0VLMERWK3VjbXEzVXZlNzRpQUVORU5Ua0huNU1tRko5Zi9Obmw5cmc0?=
 =?utf-8?B?Z3lKdTVEb1lFSkNwa09SSjV5VVM4MzgxVDZQVzlWYXgvNXhkM1NlQ0VSeHEy?=
 =?utf-8?B?SWFBc0VMUUZVRDdndTAyeFY4L3UxcDlrOHQ1cmN5ajlHYnIyQ1g2T2c1WExP?=
 =?utf-8?B?dVVGeHNlRk5mWWRlRlpubUk5bEduZmh0dWNTZG9KOUdKYTQ0cXVKM0RDRjlP?=
 =?utf-8?B?VDZIOE91eXZOb25rLytiZDZWZlhiUUI5U2pwbkFLWnNrSUc4YVNydlB1dkI0?=
 =?utf-8?B?TlRJRGlYK0Uva0dzeFJYMW9jR1NRTUZMZTNhUTRBb0hJaDlKb1B3STZKYTVq?=
 =?utf-8?B?ZExxd0M3aGhEVHZsMmhRVmRTTzlaYUZWWmEySWhlV2MyWDIxbkVsYTcyMEE5?=
 =?utf-8?B?a281ZXdlSExJRjc1dm1pSloranhibkhiR3R2TDlkUUlWbEN4bjgzMUJycE5i?=
 =?utf-8?B?R0xzbDVVSWJiVStWek9sOW93MFdpRU5VMXVGU0NEZUczb3JyOUxWM3BVSjln?=
 =?utf-8?B?RWIrTSttM214aExYWDFOSjY3VWlZcEo1RGFGWXZ1blEzMk5WMERDOHlKQWRG?=
 =?utf-8?B?VnRDWkJ4Wkt6MmdNV0VlbXJET2p1YURKdElwZ1BxNlFENHJQaGxuamovbWQz?=
 =?utf-8?B?TGhQQnZXaWxtMDRFZWZCeEdJVjlJMTZVcE1pS01jd3RmSXp6ZldMSVl6bjhn?=
 =?utf-8?B?WjRuYVNYZThvV2loRWVjRVJtTnN6TGtLS0d0akx5dGhxKzUvbGsxWEpRVjVI?=
 =?utf-8?B?ampqS2VYb3NNNHlWODBJUEZWQVpDc3o1Zkl6MUgwc05YdkNtVDQ5aWlpb1l4?=
 =?utf-8?B?N25acnhLcnhRczdWQno2WW4vdFpJZlMwbVhFRUVQdndBMEVqK0tXcVY5RStD?=
 =?utf-8?B?UDc4UDFobU9tRG9YOTRLTm8wS21pVXVzOUc2dDFTMHBlR3lZaWhCZnN0SEFW?=
 =?utf-8?B?RU1ZZm1UK3o4VmN6czRDdEMyUFNrNG8wWEx3SGV1NHNsN0Z0d1VxTjZCU1g0?=
 =?utf-8?B?bi9VQUpZaGNwbGFUNm1Xd01yYlhyQnc0RFpyZmpKU2JyY0ZsbGRRcUZlOWxh?=
 =?utf-8?B?Ti9IOUVkaVJSSnJqRENHMkRWTXJzeGN4VDBEUkRtcXcyRFhHa3M3Vm83bHVa?=
 =?utf-8?B?SDRPZWxOeTNETkErUElOUmxlRjdWQjlaNUlPM2JwdjV2VGY3M0R0Ykt3TnJQ?=
 =?utf-8?B?a2w3VFVXYlRTOHNGdzgvNWx5NmRQNUFjSnY4WW1Gb3NQWVBtS1pvVEk4emF0?=
 =?utf-8?B?aUJlQUl1T1JMWFpWWVMwM01IRXhVemp0U0VCdzF0TlVJSGxoRFprTXJhT212?=
 =?utf-8?Q?tnxWzJFSyIaiMCCbPCYaQNtpi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd50a7a2-3141-4ba2-082f-08da96e28dc6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 06:21:41.3093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYgvO09s5WrYCUDKWu07seHg2DuJyzfgqWe+yypecfFj8ivM1uKy9YYQxQntpYNQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
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

Am 14.09.22 um 19:45 schrieb Felix Kuehling:
> Am 2022-09-14 um 12:08 schrieb Philip Yang:
>> Free page table BO from vm resv unlocked context generate below
>> warnings.
>>
>> Add a pt_free_work in vm to free page table BO from vm->pt_freed list.
>> pass vm resv unlock status from page table update caller, and add vm_bo
>> entry to vm->pt_freed list and schedule the pt_free_work if calling with
>> vm resv unlocked.
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
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 ++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 41 +++++++++++++++++++++--
>>   3 files changed, 49 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 59cac347baa3..20cfc8c9635b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2022,6 +2022,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>       spin_lock_init(&vm->invalidated_lock);
>>       INIT_LIST_HEAD(&vm->freed);
>>       INIT_LIST_HEAD(&vm->done);
>> +    INIT_LIST_HEAD(&vm->pt_freed);
>> +    INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>> +    spin_lock_init(&vm->pt_free_lock);
>>         /* create scheduler entities for page table updates */
>>       r = drm_sched_entity_init(&vm->immediate, 
>> DRM_SCHED_PRIORITY_NORMAL,
>> @@ -2223,6 +2226,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>         amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>>   +    flush_work(&vm->pt_free_work);
>> +
>>       root = amdgpu_bo_ref(vm->root.bo);
>>       amdgpu_bo_reserve(root, true);
>>       amdgpu_vm_set_pasid(adev, vm, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 9ecb7f663e19..b77fe838c327 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -276,6 +276,11 @@ struct amdgpu_vm {
>>       /* BOs which are invalidated, has been updated in the PTs */
>>       struct list_head        done;
>>   +    /* PT BOs scheduled to free and fill with zero if vm_resv is 
>> not hold */
>> +    struct list_head    pt_freed;
>> +    struct work_struct    pt_free_work;
>> +    spinlock_t        pt_free_lock;
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
>> index 88de9f0d4728..c16579471f22 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -641,6 +641,27 @@ static void amdgpu_vm_pt_free(struct 
>> amdgpu_vm_bo_base *entry)
>>       amdgpu_bo_unref(&entry->bo);
>>   }
>>   +void amdgpu_vm_pt_free_work(struct work_struct *work)
>> +{
>> +    struct amdgpu_vm_bo_base *entry, *next;
>> +    struct amdgpu_vm *vm;
>> +    LIST_HEAD(pt_freed);
>> +
>> +    vm = container_of(work, struct amdgpu_vm, pt_free_work);
>> +
>> +    spin_lock(&vm->pt_free_lock);
>> +    list_splice_init(&vm->pt_freed, &pt_freed);
>> +    spin_unlock(&vm->pt_free_lock);
>> +
>> +    // flush_work in amdgpu_vm_fini ensure vm->root.bo is valid
>> +    amdgpu_bo_reserve(vm->root.bo, true);
>> +
>> +    list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
>> +        amdgpu_vm_pt_free(entry);
>> +
>> +    amdgpu_bo_unreserve(vm->root.bo);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>>    *
>> @@ -652,11 +673,24 @@ static void amdgpu_vm_pt_free(struct 
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
>>   +    if (unlocked) {
>> +        spin_lock(&vm->pt_free_lock);
>> +        for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>> +            list_move(&entry->vm_status, &vm->pt_freed);
>> +
>> +        if (start)
>> +            list_move(&start->entry->vm_status, &vm->pt_freed);
>> +        spin_unlock(&vm->pt_free_lock);
>
> Question for Christian: list_move will take the entry off another 
> vm_status list (evicted, idle, invalidated, relocated). I don't think 
> this is safe without holding a reservation lock in most cases. Since 
> the point here is to maintain a list of PTs to be freed without 
> locking a reservation, is the vm_status really the right way to do this?

Oh, good point. This means we need to protect the whole state machine 
with a spinlock or use a separate deleted list.

I don't see how we can easily use a separate list here, but we already 
have the invalidated_lock, maybe we need to rename this one to status 
lock and use it for all cases.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>> + schedule_work(&vm->pt_free_work);
>> +        return;
>> +    }
>> +
>>       for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>>           amdgpu_vm_pt_free(entry);
>>   @@ -673,7 +707,7 @@ static void amdgpu_vm_pt_free_dfs(struct 
>> amdgpu_device *adev,
>>    */
>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm)
>>   {
>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL);
>> +    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>   }
>>     /**
>> @@ -966,7 +1000,8 @@ int amdgpu_vm_ptes_update(struct 
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


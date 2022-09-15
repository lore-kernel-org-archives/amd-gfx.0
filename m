Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A726ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 14:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD5BA10E1E1;
	Thu, 15 Sep 2022 14:39:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894CB10E1E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 14:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY56FgCyAbY+6d8+mScupkMpM0jiWzvaexrrBLUa6KR8sNy+QGah/T53lTCFneKYyTgl+pXVJ09ivdr0XRgJRkid1to4tpY1SjPlG4WcK5eOMkiIO5lyp133/MQxT0RX26j9sYSuPtQ3lutcSrQw3YElla9xhU0MnsKngWSqJo3ZkOKSP9AVu+L02L9nmd6wsZ7hT8D68f50hO/2kLgUBM4nBI4MVYoLNwaHC3VjRzjE4yNEaP/IBIXkFhOMye13fbwXeTgWipvR2lStoFvWW7aj0rOcsWAqIxGBRvaYQhOQHlZo+rk8rlGFX+ddRodNl/pdwMr22UWX6UGzEFeyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQWklesCB4XZo8DfPhlL8Nue082+mjoJ3UC48tGG3nU=;
 b=lD0OhEqhzxPpXaKw/65f4XGkPiKPWpKxQOIg+8A5NQarfTMVUAvKW9f0+r48+svXDN8OAJd+DVpTkGkG0JZF00bmv9DDv6gonqZmpyHTdaT+Bov3QZIAoSkBwav6HsY+yxpbcpvLnQSiaVyFf7Auh1l3ABSFFHT7XmHjs6Iu27mxb0JbkqxiEzMFc0xiMxZTmn3qyBrXeai8rWjTHwv7ZCoxFZOKL8xzYRyysaNgobCS949Cthm8qvUBhMHL7QHBLTXi2SNuLO141fssL5iBQQO3NBDa10HAqG0LF6k2N1PQ1r/kF9ATL+g2CmHVOVWPhxe5E9n8lf2CeLRRKmP6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQWklesCB4XZo8DfPhlL8Nue082+mjoJ3UC48tGG3nU=;
 b=J+zoKIapHL/pynBGQ4AeFY4jZOyMdx9E6wDOsem9MwO1dzzG2jCx/HpBFwJTf0Wbe4EG7VhDBQoooXYZFKnrO4H5M83jqC0YvrO42vSHe+QrG8bldusAa/vMc/0J2GrAUKGfKFk7+6jA7M/ieBfOF2ayMmaq5sccBYrU9GYd5P4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:39:17 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb%2]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 14:39:17 +0000
Message-ID: <cc5097f3-687b-ca13-4117-7d207facd4c1@amd.com>
Date: Thu, 15 Sep 2022 10:39:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/1] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220914160842.9610-1-Philip.Yang@amd.com>
 <e95c37e7-d8c8-3802-63a1-92b5f6b579ef@amd.com>
 <de2064d2-1a30-4b88-855e-0207bb68aefc@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <de2064d2-1a30-4b88-855e-0207bb68aefc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0049.namprd20.prod.outlook.com
 (2603:10b6:208:235::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f0f503-7438-44c7-1947-08da9728111d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TE9Wz+eEaWTqoJFcUIYXgEm2AI1y1+M+MmuoWcCf+nmVV6icelYZcjRA4mJiaVCSxCM/wOs065AWhRWpzj8vW5WcY1w9rU2b2KfclNrypAepzIfq9nNli0TGllJG0SUo16RJXeLW0BY8T1Xa8XAQhrKIoHsiPB2N2hXHI3hw02WT9LWllf/8fPqpL6eBjR1QrOK31t7ZgT6TqySLy7AP1byxVNZznnsTFwa0fORZ+p+sSL/f6++kfveCvyuJFU60Nzslu8vnsybufCy25wiX3xqjYZL9A0MIG4jyXDvnB9iTtjLVkM5o2L8sGqEe45KdK1UCVzDAqRBCtAjNOe7tzXwCLVf9K3elsX6f5L4YhZXTMLT7GRyeFNw4kPIlI2QDaBa9dQCeyeP9IiWKaO3fu8RJ8URcHA5umqa+x97WHBeBng8YPLkI7PC0+5d2iSdviRX8P6q/Hk1LX7UiIcUy2XJiUG8ixL2QFnINLuYV9efvlx/IiwmqfDeB/d5Cezu657zZ9OZ6k9W2nnN8bIpGCBjzOyPl22hzJ4cSZ+Wy0ZaE3gDy44zCWtOtaRVSV/vnW/Qq1NJcWvJsjfTZDtH9BFKPNr/ZUPw0kh0JZ1zrtSInGr/qjTbJFfF3pRno69obaNaboo355Aoa+Ne+tY5uXheeUJyizYUCd/X/7ywp2dMTIvhO+hm6YgCXw5G7iZvvwCHGXSk6F/j4QyCL2aYBLShDFlTZX8rFOqkA8sjMYyau4fA8PZDv0nw8865w0uld2BqnfE/JRzW3GTS1Ht+vOu2IjsUuW6UqMbympcEvU1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(8676002)(36756003)(66574015)(83380400001)(31686004)(38100700002)(31696002)(2906002)(53546011)(26005)(478600001)(8936002)(41300700001)(5660300002)(66556008)(66476007)(66946007)(186003)(6512007)(6506007)(6486002)(2616005)(110136005)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFAvZTBmUFVmYzNGWnYyS3NsNzZrN1R0NTUwZGloT3JSUEFlenJ1NjIrTTh3?=
 =?utf-8?B?M0IxYlBjSEQ0b2hISjhlOEliMGZZVDRuUWhhVXVsaUh2U1g5bmxyelZWV0xi?=
 =?utf-8?B?ODJwb2o0dTRKVmVVc3NmT3Vzc2Vjd05ybi84U3B1d3JDOTRYcHNLS2QzelRt?=
 =?utf-8?B?bThHandjc1ZudTJ2YU9XbjlMeW9tT0MrUm42bGJTeUdObHVFclJocEZtUFRa?=
 =?utf-8?B?a2Q3dnY1M3p5bklmSk5uQVFJUU5XUTVjUmxESDNBMlZEUk1peUtRWFk2VXpl?=
 =?utf-8?B?dmZENCtVUFdrQTdEajlvUk5oZjIrZ1VUeXVXZmZlVlRjMlJqVmdqVjdNeFI0?=
 =?utf-8?B?TnhTRE5SWmFYVHJHejlPNlY1VVVmUTlPV1VnM1ZNZWI1dGRZdkFEL0pTTnVy?=
 =?utf-8?B?TFNlTlNMZnlqS1Rjcjg2ZmsyN295OThMK0tUNWxlNk8yL3pGVSs5WktoNk9v?=
 =?utf-8?B?Qk9yLzZ5anYxUGRSNHlyOXVxckwrQXZqZGxybFNXWjhEdWRnYVhtWCtnNFdZ?=
 =?utf-8?B?QURHQXdTMVFqMlp6Ti9tSVpvZjM4Y3RRYlcwVGw4VElUZ0pKdEtjbW92WC9X?=
 =?utf-8?B?a0lqMklWandBRXo3cDYyMVpFV2sxMUlKZmZUZE9RMHY0cjJ3cGRtSzhIZFBT?=
 =?utf-8?B?dGdFOWJkTmhSd0ZFaEJ5RmFIeExoT0N0NHlTNDNnSENTR0dmNm04MHpsQ3hw?=
 =?utf-8?B?OUx3S3JyV3RSRnVOR2RnZmc0RW05dTBWUE9LTzBBNUJ4NkVvaEsyanNjWm1Y?=
 =?utf-8?B?WkhQcVVobFFQVVp1eHhQTGpjK3hUaWZ6Y2E3MG5XalNTbVFRWEJDbm12RUEz?=
 =?utf-8?B?VkJseUhRNGZlb2pMdzVqNW8vWTJnejRnVEM5NXVrWmZtK21Sdk9qT25JQzlX?=
 =?utf-8?B?L2dvR2ZpZVZCYmJWcjVNSG01VzdvMkZIOTMxK3dlQS96K21EditFUVdFWHJr?=
 =?utf-8?B?NUpyQlNqMkFydXNjenV1bmlpQW03VXNGZURSWFNDQkRWdGdTcDR2allEN1dk?=
 =?utf-8?B?MzB4ZGhVVzlPaG4xdUhVdE5CWi8vbThxL1k1TjFvajdGbmNsbE01MnZyRXNx?=
 =?utf-8?B?TmVndit0bUsrUUVjNUo0Nkt3NDZEU041K3M4UmloNEZVdi9OSHNXemZTazBm?=
 =?utf-8?B?cGNram53VTMwT0VoZ1V6dnBrQ2VuWmxlZDF1QUxXUHM0SEowQ1hxTXhhZU50?=
 =?utf-8?B?cHRSaTIyNmlCRmVmWURyd2ZBMG8ybXB1Q1N6a1RxdUZQVldab3o0Mys4TTUy?=
 =?utf-8?B?cXRCU2w1Y3RkVjZRTGR0QlFTVVo1V0RiYVpyRDIxNjFWMEs4RWdQcjh0TU1u?=
 =?utf-8?B?VWRNcWw3M1ZENjc5eVp1ZWlEMml6NVVxZ1liQVJaRVNpMUVBdnpFeXlsZkRU?=
 =?utf-8?B?UVlpMVdBNmQvNnJJQVZiWFVuQ29XWFlPZHA4RVpKTVhQNUFjcnh5ZktOclRz?=
 =?utf-8?B?eGNzQm0xN1BZL2JKSk40Q1FhWE5hOS9Pb2tEVWJrd0h5WUszOWJPSnQwK3d3?=
 =?utf-8?B?bU1YUXp2aTVVcjVSRTRiMGxSKy8xS2ZIbTI5dlRYdCtJWEI0aERReHVNalVa?=
 =?utf-8?B?VVhoOE4zZnl0R2c1dGQ4NC9MZ0RSdVBXUGFrTGRUdkZCSWZiNEFkaW01a1pR?=
 =?utf-8?B?L0ZiTHNNWE1Qa2xKVjRVdW9XdDgvbVRmTThWL2VzMGR0NDJSQi9FRmxJRWc0?=
 =?utf-8?B?U1l1Mi9DZ21rV1ZTQzd5bUhDOGZLczBYSUlRY2hrYVlCZWpHSVE2eXQ1T29R?=
 =?utf-8?B?d284V1FUczlVWFgwMmZOZTBLZVdraWRNcURXaDBhUlZnTmRTWmorQ0c0SCt4?=
 =?utf-8?B?ay8yQXpRM3V5Q0xGSkVtTVdyQ29Eam00clRveXIzMVlvWDh5QUpOT1VMYTFR?=
 =?utf-8?B?d3NrN0w5Q0lka2dXTGZQczFqZ3ZyUTFJUStDMC84dE1DTVlJQnB6MFJkSEdC?=
 =?utf-8?B?amhPK3VTK2VXeGpnMlpKMWlzNjQ0cWxTeTMxZEd1SkUvSWYxcHhPYmhQbzhW?=
 =?utf-8?B?VmF4eTdqUXREeFZtMktPdkJyWGgycjdxTnNhUzRGTjFiQXlOcE5HT2ZkM0dZ?=
 =?utf-8?B?OUNaYUhvamtGWHhwOWcrM1N1MW9ydjFlRkZJZU55QnNPbXpZZ0t3bkxzOEZ4?=
 =?utf-8?Q?Bl5I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f0f503-7438-44c7-1947-08da9728111d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 14:39:16.9514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OcPEjmTkRTWRqwNruga/eKbSwk2OIPfkugy7OYnWzckokeDgKS72Z5MJAbsMJO/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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


On 2022-09-15 02:21, Christian König wrote:
> Am 14.09.22 um 19:45 schrieb Felix Kuehling:
>> Am 2022-09-14 um 12:08 schrieb Philip Yang:
>>> Free page table BO from vm resv unlocked context generate below
>>> warnings.
>>>
>>> Add a pt_free_work in vm to free page table BO from vm->pt_freed list.
>>> pass vm resv unlock status from page table update caller, and add vm_bo
>>> entry to vm->pt_freed list and schedule the pt_free_work if calling 
>>> with
>>> vm resv unlocked.
>>>
>>> WARNING: CPU: 12 PID: 3238 at
>>> drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
>>> Call Trace:
>>>   amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>>>   amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>>>   amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>>>   amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>>>   svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>>>   svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>>>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>>>   unmap_vmas+0x9d/0x140
>>>   unmap_region+0xa8/0x110
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 ++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 41 
>>> +++++++++++++++++++++--
>>>   3 files changed, 49 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 59cac347baa3..20cfc8c9635b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2022,6 +2022,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>>> struct amdgpu_vm *vm)
>>>       spin_lock_init(&vm->invalidated_lock);
>>>       INIT_LIST_HEAD(&vm->freed);
>>>       INIT_LIST_HEAD(&vm->done);
>>> +    INIT_LIST_HEAD(&vm->pt_freed);
>>> +    INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>>> +    spin_lock_init(&vm->pt_free_lock);
>>>         /* create scheduler entities for page table updates */
>>>       r = drm_sched_entity_init(&vm->immediate, 
>>> DRM_SCHED_PRIORITY_NORMAL,
>>> @@ -2223,6 +2226,8 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm)
>>>         amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>>>   +    flush_work(&vm->pt_free_work);
>>> +
>>>       root = amdgpu_bo_ref(vm->root.bo);
>>>       amdgpu_bo_reserve(root, true);
>>>       amdgpu_vm_set_pasid(adev, vm, 0);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 9ecb7f663e19..b77fe838c327 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -276,6 +276,11 @@ struct amdgpu_vm {
>>>       /* BOs which are invalidated, has been updated in the PTs */
>>>       struct list_head        done;
>>>   +    /* PT BOs scheduled to free and fill with zero if vm_resv is 
>>> not hold */
>>> +    struct list_head    pt_freed;
>>> +    struct work_struct    pt_free_work;
>>> +    spinlock_t        pt_free_lock;
>>> +
>>>       /* contains the page directory */
>>>       struct amdgpu_vm_bo_base     root;
>>>       struct dma_fence    *last_update;
>>> @@ -471,6 +476,7 @@ int amdgpu_vm_pde_update(struct 
>>> amdgpu_vm_update_params *params,
>>>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>>                 uint64_t start, uint64_t end,
>>>                 uint64_t dst, uint64_t flags);
>>> +void amdgpu_vm_pt_free_work(struct work_struct *work);
>>>     #if defined(CONFIG_DEBUG_FS)
>>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct 
>>> seq_file *m);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index 88de9f0d4728..c16579471f22 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -641,6 +641,27 @@ static void amdgpu_vm_pt_free(struct 
>>> amdgpu_vm_bo_base *entry)
>>>       amdgpu_bo_unref(&entry->bo);
>>>   }
>>>   +void amdgpu_vm_pt_free_work(struct work_struct *work)
>>> +{
>>> +    struct amdgpu_vm_bo_base *entry, *next;
>>> +    struct amdgpu_vm *vm;
>>> +    LIST_HEAD(pt_freed);
>>> +
>>> +    vm = container_of(work, struct amdgpu_vm, pt_free_work);
>>> +
>>> +    spin_lock(&vm->pt_free_lock);
>>> +    list_splice_init(&vm->pt_freed, &pt_freed);
>>> +    spin_unlock(&vm->pt_free_lock);
>>> +
>>> +    // flush_work in amdgpu_vm_fini ensure vm->root.bo is valid
>>> +    amdgpu_bo_reserve(vm->root.bo, true);
>>> +
>>> +    list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
>>> +        amdgpu_vm_pt_free(entry);
>>> +
>>> +    amdgpu_bo_unreserve(vm->root.bo);
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>>>    *
>>> @@ -652,11 +673,24 @@ static void amdgpu_vm_pt_free(struct 
>>> amdgpu_vm_bo_base *entry)
>>>    */
>>>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>>                     struct amdgpu_vm *vm,
>>> -                  struct amdgpu_vm_pt_cursor *start)
>>> +                  struct amdgpu_vm_pt_cursor *start,
>>> +                  bool unlocked)
>>>   {
>>>       struct amdgpu_vm_pt_cursor cursor;
>>>       struct amdgpu_vm_bo_base *entry;
>>>   +    if (unlocked) {
>>> +        spin_lock(&vm->pt_free_lock);
>>> +        for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>>> +            list_move(&entry->vm_status, &vm->pt_freed);
>>> +
>>> +        if (start)
>>> +            list_move(&start->entry->vm_status, &vm->pt_freed);
>>> +        spin_unlock(&vm->pt_free_lock);
>>
>> Question for Christian: list_move will take the entry off another 
>> vm_status list (evicted, idle, invalidated, relocated). I don't think 
>> this is safe without holding a reservation lock in most cases. Since 
>> the point here is to maintain a list of PTs to be freed without 
>> locking a reservation, is the vm_status really the right way to do this?
>
> Oh, good point. This means we need to protect the whole state machine 
> with a spinlock or use a separate deleted list.
>
> I don't see how we can easily use a separate list here, but we already 
> have the invalidated_lock, maybe we need to rename this one to status 
> lock and use it for all cases.

Rename invalidate_lock to status_lock, then we can use it for 
vm->pt_freed list, don't need another vm->pt_free_lock, this is good.

invalidate_lock is used to protect list vm->invalidate and vm->done 
right now, other vm list evicted/relocated/moved/idle/freed are 
protected by reservation lock. Do we need protect all vm lists 
operations with status_lock as well to ensure it is safe to take entry 
from vm_status lists for unlocked context?

Regards,

Philip

>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>> + schedule_work(&vm->pt_free_work);
>>> +        return;
>>> +    }
>>> +
>>>       for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>>>           amdgpu_vm_pt_free(entry);
>>>   @@ -673,7 +707,7 @@ static void amdgpu_vm_pt_free_dfs(struct 
>>> amdgpu_device *adev,
>>>    */
>>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm)
>>>   {
>>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL);
>>> +    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>>   }
>>>     /**
>>> @@ -966,7 +1000,8 @@ int amdgpu_vm_ptes_update(struct 
>>> amdgpu_vm_update_params *params,
>>>                   if (cursor.entry->bo) {
>>>                       params->table_freed = true;
>>>                       amdgpu_vm_pt_free_dfs(adev, params->vm,
>>> -                                  &cursor);
>>> +                                  &cursor,
>>> +                                  params->unlocked);
>>>                   }
>>>                   amdgpu_vm_pt_next(adev, &cursor);
>>>               }
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815B5C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 22:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D9AA10E7D8;
	Wed,  1 Nov 2023 22:00:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6166410E7D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 22:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOstnbhVyOaDd+Wf2GfiYYP4GtxCv9LAezzH1mp3GG1vkio3+hsb+R+YhM0WKSmycPBGZ1asrCpYWQMZc4qYTujLaE6oYu3PUDNEInqjwSH3kOqhQi3AV2IV2sXERC1vgVLgJAr2Xi3tg4eN97LXFMI6WLnZT00mJv3DA3nU2ew3MT/3jSD5PQeova9Kl25elQbxrp+exyrF2MMYLu101UCSw7cKXVm61SYbMzlQKUpKElFYGDMwjR3bKYtOq5KtywXJ7fxz8TiEJO9BxonHJi7hh3ZskKRE9s22iSdKqqwB2nW5As3DdO/Ra0eBsCOepN+Q3sP/j/Ht7VUSY2SOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VukIOkvYPZjxoUd2PX+qXa3esM3wxDM2Jop7jhyezb4=;
 b=e9zLvurY+yqFnQULiq3P4nQLiAVboakK4pRPLwddLsHT0V/7D/LEVtz0cMKSdDkNoYzumP8J6DerxrFiTRyH/8VCxokcdMymlVs82u+Eh8NHEwn5gIc51N/7lvmmgj52c/VihUsLUQt7hkCqpBCugUSb43PwzbYdSivcd6Mp3nFnNeifdXJJXx3K06VAknYHBk62cfP3zEvfqiBjwPJJLEqJG+cHL8ykITZcC71fvGu6aInUo9ZtYfEXL4CsEIRpT0ZWMuwq660BMaC/7nWh9DW1QtiAXOjxBwKYa3IwIyHNOatVcyfNgILIDxtG9ylWvzx/Dw1/vh+rLKRWEGM72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VukIOkvYPZjxoUd2PX+qXa3esM3wxDM2Jop7jhyezb4=;
 b=0Yoj1/glmk3J/9VIyJQAUmdyE7DnOEwUfbt24IbtPgv5myQv4vSOraboe6WNnXUBGrWGVXgCrZzmBKhMUdpp5npnqkTJghj2l4u6P7jjlpYSIE/OahQKujsW2tG3LK7mRjn3F0o2BKkbA3HuPpI57SVc2mkeYC7Ud1sQ5YO7CpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 22:00:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa%3]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 22:00:46 +0000
Message-ID: <9622bd17-a526-48d2-b3c3-f5e7bbd82ecf@amd.com>
Date: Wed, 1 Nov 2023 18:00:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix error handling in amdgpu_vm_init
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20231031145534.2501-1-christian.koenig@amd.com>
 <CADnq5_N1St5NDG-uAtVnEcj1P+f0jt-Rp-3kND_XjTTbqmbbGw@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CADnq5_N1St5NDG-uAtVnEcj1P+f0jt-Rp-3kND_XjTTbqmbbGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0307.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: b15982f5-629b-4d92-36b0-08dbdb26005b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6OB9PpPML2/VVFvKRXR6iPPNNnNv9SZ1MVQAo4enL6ny9j+DR4MrWFVbKIf5zOpDNYyIvwsExhPcMl1uie6nhYc+xs3iM0S82ERMj9HmgNyWmRWdhWCaotNhbsboJLvQxGhAOdHO50VnCQTFndzQn9WSrZFIUHW5AEE011IXAaoiltQjVk/0vFQ4OGSfUP2YuVsEPwiCVL5T48LFXrUl8J8fWPOkmmRVHloNKgx2H3e+igzhk4vvONild1q+VJkG3dsmPnMe9KBA34Imtp20nB5xKMfStz5wnipGBw63BPTCx1wOyIev9wsjy1WtZnPlqg06c3tA/xIN93x7JDrr3z9OR6I8XGwvwsSBPeTIbew1adzDM6WMQWQeJGGu5kr6IfD2GA+j203LX7a6tOiwZ4Skfo2HSLxmn7GYhuDJxQPpr9IS95JUY+CLK6zsCbT4xQk/Xu+cf45jhp6YF1RAYurXCdxFABhj9yWT/rTAmQaBWfomXTXhYmYnfF9xJsjWNqUrGck1LLUCjKJuswU/g6G2BZdlpCSBryMNZ8wS7iZh0KYMze8VwqtEP5q8ZVAQVct0i98xsog70IqIksPkTpObFiVnhqJ1Jm/Z52Iu1K86fd4HRTLzg/4jobI//O8+RZ6a/myPXuQ/wr56+ARuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(4001150100001)(2616005)(26005)(6512007)(36916002)(4326008)(478600001)(66574015)(66476007)(83380400001)(6506007)(8676002)(44832011)(6486002)(66946007)(110136005)(41300700001)(66556008)(8936002)(316002)(53546011)(5660300002)(36756003)(31696002)(38100700002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVY2cnFWMk16dlBHRTFDUHozYU9YNGd0eGE3M2xpZVNPVmpjNU1XaGt5UGhz?=
 =?utf-8?B?dkN3RC9Jb0Flakdxa2J0OW5QM3VYc0RaejJwb0Y4TDJLOEo3djVhYTh1Z05J?=
 =?utf-8?B?elRWWVI0eGpVV2xVSVpJbTlnK0lPTDRzZ3NlOURUN2pkRlVLOURyb0ZnbU1u?=
 =?utf-8?B?Yk9NTUxHT2xGcDM3dTZCb0QxcElTbW5GVXFBbW5nci95M1B2MklwYXFrMTdN?=
 =?utf-8?B?V2tSQ2R5OHhTcVk2QldVaEd2YWZPMC9UNk94WTYwNTVJdm12cFBtOTlsRGl2?=
 =?utf-8?B?azhHTmhWR01sNVVsUWpqSDd1TjlOc0VueVQ2QXBNcU1jcmdrNWtVclRJN2tz?=
 =?utf-8?B?N1ZOZHRUa1JGSzJIQ3hJcXZucWxIUFA5VUF5SXhkOGpyZjhqUHNwUnBnbGZ1?=
 =?utf-8?B?MXlXaWdaUE5qVGNCd3QzeTN2YmZOYVd4ckFLMHY5L2JNdERvRVNpczVtOGx5?=
 =?utf-8?B?eFoxUzRvaU1IZTZzbnRveHAyOUZWZG4vbTdYbzNiVUVxT2paU1QzVzdKQnBl?=
 =?utf-8?B?R3hLWGJGcWlDL05BclZ1ZU45VkZMU2pWT0d5UFp3SVdxaWp5N2lpRGwzbm1V?=
 =?utf-8?B?RHU4SXJwaFJkcWJmYkhNbHdXSXY3MzZaREVHNFZnbmRiVWdLQS9sVlQxVHJB?=
 =?utf-8?B?K24rSEd5eCtoekU5cUIvYm1tMFZxdlZlTnZIbWVDdFNVMnQvUSthNVBKZG5x?=
 =?utf-8?B?cmhjdXJpdk5WbzVEOGdQQUc4aEVCUG5DRFQ5RlRZTFN2SlFZZUhza1JQRUd3?=
 =?utf-8?B?c3ZaM2x3K3V5YzZpaVNBdGN4dkVwaEg4TlhSNm91eENwdFczL3RwSzVzNXVT?=
 =?utf-8?B?ZXd6Y1djNnR0aE1XYkVjUUUrKzZJVGRkNmdscUxlYWg5UjlCRVduWC9za21J?=
 =?utf-8?B?MHB5TjQ4Qy9UclI3cTRlbEF0dDdnZUdnMFQ5YjFSejROa0NGWEI3N0tKdmF4?=
 =?utf-8?B?cVVhUjZ2R2tRZllnQWVkdHZpTEp0R1p2RUJiK2RoZUZ0VnhxMVprb09zNWFq?=
 =?utf-8?B?S3BXeTRZSFdNVzUrUy9rdEJLS2RNTS95OFdrZzA4VmhXc1kvcDFMMisxckhI?=
 =?utf-8?B?RHF6MmZWOUk2TUprcTdWUlpHamtDcE9KVUZ5aElqcUJSc0pJdTAvVnhpSWxQ?=
 =?utf-8?B?a0twaVBGdFR2KzBiMU4wenZoM1k2cHJEeDI5aUdKZkxEbkFyZWtzbWtWUm8r?=
 =?utf-8?B?RWpXK0Q2RWtqOVVKaGF4MHJYbWNwS1FXR0NkRnJpVWtESDNQaUx3Tm5Zdnd4?=
 =?utf-8?B?b284TElJcmIzQi9nS0pQbTVPU1V2K3hrR3BFRVlueXpIemhYUTlwZlNnc1hE?=
 =?utf-8?B?Wi9ZUnQwN00yZmNCZG9mbzl0WmZzejhHTVBDcmUwaUJBQ2NucHUrU1JMK2s5?=
 =?utf-8?B?ZzdaM3FRRGxvWXlyUW9WSDZHSVlWaWZKOUp0eXRHTTdGa0MyZUNzaU0xSURU?=
 =?utf-8?B?dmNxZzVEWmN4US8xSzJIeWpLbmlFU1h4RnRkTWJOSzJoOFl4elZJbmloTDIy?=
 =?utf-8?B?aDJ1clJtVDh1QzF0NEhnVnlXbXAzSWc5UkxoNmU4SSs2MHFTUU4vSGF3TTBM?=
 =?utf-8?B?bVBVb1czZTVFUWZ1a3g3bWFEcjdWeXZGWG5qdHBLb3dlTUVLU2o3aThGL1Rp?=
 =?utf-8?B?Mjc4WnJScDBqVU9pT0VYcUxGYmxFbWlVYUs3MjVISnBlbUpNMWZBUWlVTXMr?=
 =?utf-8?B?QVNveWZpUUN5Y3JMMWFzSUhhYTVxUDJ5TStEdXAwYi9WK01Rb2lZL0xHTnlx?=
 =?utf-8?B?bW1pbVl2ZVRiUlcwa2R5NEVpcEFucVlFbFZ2NTdIR1N1biszZGVmYk9PSmlU?=
 =?utf-8?B?QUtLbERzbVJsQTNDR1kzaDdxRW01VDVMdWZSVDdCNkVLSlQ2eGo2Z01rekVw?=
 =?utf-8?B?VzNvM3VRVTJBV0tSQ3JtSzAxblNZMTkwTUFrYnp1SVNEMU1xcEZVRGxJbTNS?=
 =?utf-8?B?RUV5RlA5andHMk95MytrcFpycUZDcUZNbFdGWlp2ajdtL2RjQ0w2d1BYY1BU?=
 =?utf-8?B?cjhjV3RmMm1lNEY2ckxCMnRYTExhcERHQVBDZHhPdFRoNDJ4YXZjVXgvNzVV?=
 =?utf-8?B?VFJFMnhrUklpbWIxV1lCTWVCZzdtVEFuZTJYTUZTdW1XSUxtMzdJU0FuSU9x?=
 =?utf-8?Q?8Q9yX2f+vSVfH8aL0dwBeowV/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15982f5-629b-4d92-36b0-08dbdb26005b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 22:00:46.5834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7zJpaaakALPF96ObziLWwAT5e10YvYDSbZvLUQD6PrkjuY8c1MLip9ZgUYcJFnMMiz+o4FPRJox97qfWULU5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
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
Cc: Alexander.Deucher@amd.com, Kenny.Ho@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-31 11:18, Alex Deucher wrote:
> On Tue, Oct 31, 2023 at 11:12 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> When clearing the root PD fails we need to properly release it again.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
Has this been submitted? I see some intermittent failures in the PSDB 
that may be related to this.

Regards,
   Felix



>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 31 +++++++++++++-------------
>>   1 file changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index d72daf15662f..5877f6e9b893 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2042,7 +2042,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>>    * Returns:
>>    * 0 for success, error for failure.
>>    */
>> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id)
>> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +                  int32_t xcp_id)
>>   {
>>          struct amdgpu_bo *root_bo;
>>          struct amdgpu_bo_vm *root;
>> @@ -2061,6 +2062,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp
>>          INIT_LIST_HEAD(&vm->done);
>>          INIT_LIST_HEAD(&vm->pt_freed);
>>          INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>> +       INIT_KFIFO(vm->faults);
>>
>>          /* create scheduler entities for page table updates */
>>          r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
>> @@ -2103,34 +2105,33 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp
>>                                  false, &root, xcp_id);
>>          if (r)
>>                  goto error_free_delayed;
>> -       root_bo = &root->bo;
>> +
>> +       root_bo = amdgpu_bo_ref(&root->bo);
>>          r = amdgpu_bo_reserve(root_bo, true);
>> -       if (r)
>> -               goto error_free_root;
>> +       if (r) {
>> +               amdgpu_bo_unref(&root->shadow);
>> +               amdgpu_bo_unref(&root_bo);
>> +               goto error_free_delayed;
>> +       }
>>
>> +       amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
>>          r = dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
>>          if (r)
>> -               goto error_unreserve;
>> -
>> -       amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
>> +               goto error_free_root;
>>
>>          r = amdgpu_vm_pt_clear(adev, vm, root, false);
>>          if (r)
>> -               goto error_unreserve;
>> +               goto error_free_root;
>>
>>          amdgpu_bo_unreserve(vm->root.bo);
>> -
>> -       INIT_KFIFO(vm->faults);
>> +       amdgpu_bo_unref(&root_bo);
>>
>>          return 0;
>>
>> -error_unreserve:
>> -       amdgpu_bo_unreserve(vm->root.bo);
>> -
>>   error_free_root:
>> -       amdgpu_bo_unref(&root->shadow);
>> +       amdgpu_vm_pt_free_root(adev, vm);
>> +       amdgpu_bo_unreserve(vm->root.bo);
>>          amdgpu_bo_unref(&root_bo);
>> -       vm->root.bo = NULL;
>>
>>   error_free_delayed:
>>          dma_fence_put(vm->last_tlb_flush);
>> --
>> 2.34.1
>>

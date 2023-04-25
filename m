Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FD1C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 15:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC0E10E2D6;
	Tue, 25 Apr 2023 15:33:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1392510E76E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 15:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUO3lhqJ7fs6Wn8/LJhgH1/fDCQCkZ4R4IL+KfnV2wtiMxfhcHsBaGIrDek6/kh/63SXc7mrZCq1Igkfr0N3mZS5VuFEsf9Lq69i97Pbf/gH2gVAmNvxy6WkVBcvDXvKwxeLOtKvEdku7/mpjySfstquRteYpQs3DwMyvimA6/YB/n5QWe7mOQtkjwnbBM3mJN3Xxj+qQV/f2p9/33rD7XvU0l2NWsRBTjlrxxagcc6PCeL3F0p5jNP+qbAqVDHmHseoC3OnDJL9C17no9vOyIxCp0K5frOl/Rr/oPAkZvlN2V8RjRpFAJ54LkWV5qZQPIITdzFK5BDKdUHz3ako6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bx4TUngRAUrDXL+clcNXLWjhPgHiVKyMLNa/UJVwzs=;
 b=Rh7gb+b6vKsB3ohB7i5AeVAJSyYv30KKOpLv9PbvZsiRWs7BrdpOmlmnPT51FYXV+7XuIjOj+1boGVyh+c9upd3Kui90QdXeVsrdRFzCvNRhurI8uZaPh/LP/XV4IcUph70XDp3uDgcXg+yMZM5/WVHFBPNSJ+ElWGYtURgTYbu6qmquReiYiRJ41R8Xvt7mmCpDRpC5TVkgx8NPJn52MjvcJnXgxLdeovpOh8CaXAzeHRKm/LnRyfZRwLSQtwURN+iNTUlv6Z/AYeuy8VTI+sNnN82zVjOK0iPuSPX6p4BshVQ7TPTePk9tHYBEBE5HwV774La8HlUj+kXrVnn9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bx4TUngRAUrDXL+clcNXLWjhPgHiVKyMLNa/UJVwzs=;
 b=b2yR2pzXHisEyAqmqFyO9zGyGC7TYqNyqWFNyKKweeOE6zqgTBzzRRPE/lWMx+Iv9vO5teRBUBYnNyEvij9giMtcXjJpwFmz1bUI+AjvkhGJN4NkpWWdjfeNj7l/aqg1vUO7rvxMGn8r3T+/HsLsrOxQ8IIS+gUIVA/KN/3ueNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.29; Tue, 25 Apr
 2023 15:33:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 15:33:30 +0000
Message-ID: <75d5e1ba-de55-683c-a852-cb5138fcf844@amd.com>
Date: Tue, 25 Apr 2023 17:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 07/10] drm/amdgpu: map usermode queue into MES
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-8-shashank.sharma@amd.com>
 <bd98e48e-652a-8649-d2e9-f3c90d710f0c@amd.com>
 <63fb9f84-04c2-64cf-764b-b30cd9b81558@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <63fb9f84-04c2-64cf-764b-b30cd9b81558@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afcae3a-aac0-4f4f-106b-08db45a26c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9A8J84Cb1Db3uKpiz203Xn5Gr63HRz/sTO5QEuoPwkLOQBIRngz7CenTrIZuib4vaxOug9gychI84JueudlmGhn96MjAEcmq0QTL2mS34t1RvO7FYxsrbwFsK2gGWeKnk5BjLdMGKlaqRALAyQKY0UmfQ1iELNvqGe4XRQaLnaP7aW+AIIBSn04G8HZjjb+h96NFZiiNWe0WVxdPvu3AlvhGCOSxIb1uJhXvW/ynPijUcHwfMcpnIoVXrUQ+ravbHC/D8okBdBVXsxhLDX1b+nxgDSWJnUraPUcv4+8TEyYs7MAQfDe8ics4EcSsrhxtGijjoGsm2Y+DEJJpj4Wq9R7a5QJPqcNnRBvCwrz6dvYuFApeZ8XpjgEIdNkDuzrGsKQIRY0firxekiFtqe6UUC37/87K1r0HtFd1ZLspZcwi1HejQXAyZ3oBfPL0CeMHJ+4i6ztfNyfh16nPxq66xiNvnh7poyG6+4TzLrAZwJDDOIy38o8wmcBCivTkBqPMY0UuDPg9gdMwWGd2LTMXGO9CkoKhQonOVoTycIIv8H28U4XrdGCLZZD4ZSAfVc/D2mPdUqVZ4Z6RLKUVA8RiiHCRadGZ3BidD+Djql1QAOaPnh7av3j2ZozyEi+MHh4izJk7NkJ9MbOh0VkmLAUsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(2616005)(2906002)(5660300002)(6512007)(6506007)(53546011)(41300700001)(83380400001)(66574015)(8936002)(8676002)(31686004)(38100700002)(316002)(66556008)(66476007)(66946007)(4326008)(186003)(36756003)(86362001)(6666004)(31696002)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QisvZTFvVG9ET0laSEZjNWlWWTc1RzlSNzVrWFJtRmV3ZldKK0hGN0pKeHE3?=
 =?utf-8?B?NHlFV3YwUDhtdWVLcmgrVXN2Z0gxWk5MV0ZCYUpWNEdXQ3ZiNFBEcndBVE1B?=
 =?utf-8?B?RUZ4bS9OYmttdmF2QVBsK0d6NWhXN3MxNzE0TlczUDBWMUZLZzBWYlhtTUFo?=
 =?utf-8?B?Sm1pRzFEbG9zdTNXeUtHK0xROXJjSDNkRGJXNGY1L1lwa2t0UW8xK3VBYnlB?=
 =?utf-8?B?QU45alZDdlgyOGFNNm93WkxrcDh1dThYYUpNRm0yWVJsZ0RzaVRzYnA1UHVY?=
 =?utf-8?B?c2FHY2dqVlhyd1c2aGV5SzMwQVJodjhVYUtHaEFNNEFRUDlpTDhhd2FrWWxW?=
 =?utf-8?B?MysxSW5CeXc3Z3ZaMGRTSGF1aytqdHJBMXBqQm5saDE0VVNreFBTN2k2b1Zi?=
 =?utf-8?B?U2taQldpZVRJOVdMTWFQU2hnZzNRNTMvV0hxQTVRU1laMGNJZDRjOHo1dFpH?=
 =?utf-8?B?a1IzVUk2bU9uOHRCYlpWaEtHaTNMeDM3OCtRbkJVNHM1bW41MDVzVm1iVnhj?=
 =?utf-8?B?b0tQOW9qTjNJTSttMzdkaEI0KzU0Yk1OYnFReFhzTGprR2JFaW5aWXplU0pN?=
 =?utf-8?B?dU81d3p5Y2dub3FxOVJVT3EzbElTWmpBUCtDbXNqQUZFbTFpc3lzdFc1V2Ny?=
 =?utf-8?B?WmFXYjR1MFhoT21BS0VqYU9pa2Q0eTc5YWxVeTgxTlZ0aUlSZC9nT3dLaXF3?=
 =?utf-8?B?MnVKVVdJVW1qSzNubzM3R3A4b3B1Y1g5c1UyTU9OZEZrT1dvZHI4U2F1aVNi?=
 =?utf-8?B?dlJ4OHk0MGxrUGVKL0tuQ0RqbGczcDNvZE9jZm5KaDdEelYzNWk3Q3djbDZF?=
 =?utf-8?B?d3poaDZYcVdTZFZYQThoUHpzVENjQkt6cCtqaFh0dGpOancvQUE0cFZWL1BU?=
 =?utf-8?B?WkxtVkVLVUhqZmRYWnFHempaU3Z3bUZBT2FPTllwSWI3OUtlUkxnWm5Xc1E2?=
 =?utf-8?B?bUJHZDhMUVVYbVI3V3R3S25RZTdybGc0MU1KU3Nma2lnV25Jb01QbnpWY3Z0?=
 =?utf-8?B?WlBHckxzTDFUdzVhV0VKUjRMVDE1V3M3Sm44NVVOSTVFNWhMZXZ4SG9BTW8y?=
 =?utf-8?B?OVZjRkFDNzY0Ym1yWjZ3N3VrZDZmd25vYlBYK0pobDZXVTdzSFFBVnZhLytH?=
 =?utf-8?B?bTlTdXQxY1FlL2V6YWhXTEIzRURDdUE5dngwd3U1TitxUVMvaFFQUlV5Y2ov?=
 =?utf-8?B?Mk0rY1dpcVg2bTZWWlBUTHR3b3dhZTFTVEIvdXQrbEZ5NXBSS2ZxY1o1Z2oy?=
 =?utf-8?B?bjh5RWhYb1hKS3B5bnFER0pwWjZpSTNpbmI0WmVxWHJ0OWhZYS9BNjRGN1RS?=
 =?utf-8?B?cFNhUE1GdzZqMW9tR2MyVWZ4ZCtTT1NvREtQRklrVnI1Qk41dmw3R3l1cDJM?=
 =?utf-8?B?YXNabXJET1cvMFFrNXpEb3lMSVJKNUd5TDZaTmV5S0dMaityN0Q4ZUIwT0RH?=
 =?utf-8?B?UUs5NDJiTTdueWs4TlNEd1ppSElBeExGREpUaVpZaUtNTUhVaTdVNnhFRWZU?=
 =?utf-8?B?aEExUkNHaVN4dmI4ajFaanJvZUdVRC94NWp3dm1KZHNaNU1hMkRuVHJFTUtG?=
 =?utf-8?B?VWVEaURaY0xTT3JNRldVSEp6N3Rjajg4Z3V2KzE3YnlxQjZOUzB4ejdUT29K?=
 =?utf-8?B?RkpXWWtIbkFzbXc5NTFOUk9DR2x3ZForMW5NU3ZZRE9NMlVwVmhVSkgzVVVo?=
 =?utf-8?B?YVNyR29pZFdJcWVjTFJaT2hlc3NMcFp3OXFydnROZ2NMYTlRMEVuL2NOWW1T?=
 =?utf-8?B?YktTTWtqbGJaZzJQbld2UFhjU0xWSzJsRGhsZksvWFByR1UzdlBROWQ5aFV5?=
 =?utf-8?B?YU43TXRIZjZXWVdWbXp6Q2RjQUtkSzRXMHVBMGp6QUQxbEdRa1o4WWRNM1hk?=
 =?utf-8?B?ZnZnVEsyeS94VnBzL2JTYWYyU0xqWTRVSnNNbjVncXBTTG03NjlVc3hyK1Q4?=
 =?utf-8?B?Q3RidGNRNzdjeWFVV1NTM25mRDZDY3kwc0dxZXJnYkJGSk8zSU8wRUJaWjNL?=
 =?utf-8?B?Wm8vQnBjcWdtVVVVM0RvSm5CRmpBNEFDSnYzZWJUQjJTS2xab3VoUUFMTWZV?=
 =?utf-8?B?c3IyNGxmT1Zjdk1PNGplekJ1MERCanZVcEQrWFlrSHU1Ym44RVVITDUwell3?=
 =?utf-8?B?d2U3REg4YW5yUmoybjBlZW03bnFYTWJrNGpIQ2lFOUdhVlJSUTZ0ckhZanZH?=
 =?utf-8?Q?scbtLIKSlEEUehCu93WHQ9FMjd46jj9f8S6BamjBDgIl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afcae3a-aac0-4f4f-106b-08db45a26c10
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 15:33:30.5148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3qHHh4rNQRQHz6Tje6JIZMmk1WBh5cA+AKmh12EQ/nB7S4rnc/5R8cHPmo8IWIe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.04.23 um 15:31 schrieb Shashank Sharma:
>
> On 25/04/2023 14:34, Christian König wrote:
>> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>>> This patch adds new functions to map/unmap a usermode queue into
>>> the FW, using the MES ring. As soon as this mapping is done, the
>>> queue would  be considered ready to accept the workload.
>>>
>>> V1: Addressed review comments from Alex on the RFC patch series
>>>      - Map/Unmap should be IP specific.
>>> V2:
>>>      Addressed review comments from Christian:
>>>      - Fix the wptr_mc_addr calculation (moved into another patch)
>>>      Addressed review comments from Alex:
>>>      - Do not add fptrs for map/unmap
>>>
>>> V3: Integration with doorbell manager
>>> V4: Rebase
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 67 
>>> ++++++++++++++++++++++++++
>>>   1 file changed, 67 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index 86de35292f69..7a45d68091ec 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -31,6 +31,7 @@
>>>   #include "amdgpu_smu.h"
>>>   #include "amdgpu_atomfirmware.h"
>>>   #include "amdgpu_userqueue.h"
>>> +#include "amdgpu_mes.h"
>>>   #include "imu_v11_0.h"
>>>   #include "soc21.h"
>>>   #include "nvd.h"
>>> @@ -6411,6 +6412,64 @@ const struct amdgpu_ip_block_version 
>>> gfx_v11_0_ip_block =
>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>   };
>>>   +static int gfx_v11_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>>> +                 struct amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    struct mes_add_queue_input queue_input;
>>> +    int r;
>>> +
>>> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>>> +
>>> +    queue_input.process_va_start = 0;
>>> +    queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << 
>>> AMDGPU_GPU_PAGE_SHIFT;
>>
>> Could be that this is wrong. What is that value used for?
>>
> Both start and end are required by MES FW for mapping the MQD. The 
> value here is generated same as in KFD userqueue.

Ok in this case then that's probably the values which will be written 
into the registers. So that's probably ok.

>>> +    queue_input.process_quantum = 100000; /* 10ms */
>>> +    queue_input.gang_quantum = 10000; /* 1ms */
>>> +    queue_input.paging = false;
>>> +
>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>> +    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>>> +    queue_input.inprocess_gang_priority = 
>>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>> +    queue_input.gang_global_priority_level = 
>>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>> +
>>> +    queue_input.process_id = queue->vm->pasid;
>>> +    queue_input.queue_type = queue->queue_type;
>>> +    queue_input.mqd_addr = queue->mqd.gpu_addr;
>>> +    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
>>> +    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>> +    queue_input.page_table_base_addr = 
>>> amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>
>> You need to implement some mechanism to keep those page tables and 
>> all resources in place.
>
> I don't get it, would you mind elaborating this please ?

We need something like the KFD eviction fence. Probably best if we have 
a call on that.

Christian.

>
> - Shashank
>
>>
>> Christian.
>>
>>> +
>>> +    amdgpu_mes_lock(&adev->mes);
>>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>> +    amdgpu_mes_unlock(&adev->mes);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>>> +        return r;
>>> +    }
>>> +
>>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", 
>>> queue->queue_id);
>>> +    return 0;
>>> +}
>>> +
>>> +static void gfx_v11_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>>> +                struct amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    struct mes_remove_queue_input queue_input;
>>> +    int r;
>>> +
>>> +    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>> +
>>> +    amdgpu_mes_lock(&adev->mes);
>>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>>> +    amdgpu_mes_unlock(&adev->mes);
>>> +    if (r)
>>> +        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>>> +}
>>> +
>>>   static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr 
>>> *uq_mgr,
>>>                       struct amdgpu_usermode_queue *queue)
>>>   {
>>> @@ -6507,6 +6566,13 @@ gfx_v11_userq_mqd_create(struct 
>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>>>         gfx_v11_userq_set_ctx_space(uq_mgr, queue);
>>>       amdgpu_bo_unreserve(mqd->obj);
>>> +
>>> +    /* Map the queue in HW using MES ring */
>>> +    r = gfx_v11_userq_map(uq_mgr, queue);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to map userqueue (%d)\n", r);
>>> +        goto free_ctx;
>>> +    }
>>>       DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>>       return 0;
>>>   @@ -6523,6 +6589,7 @@ gfx_v11_userq_mqd_destroy(struct 
>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermod
>>>   {
>>>       struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>>   +    gfx_v11_userq_unmap(uq_mgr, queue);
>>>       gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>>>       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>   }
>>


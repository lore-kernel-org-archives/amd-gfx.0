Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6E5C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 12:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C9110E1AA;
	Tue, 25 Apr 2023 12:21:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44ECB10E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqKTFtlM+uUVF/19MY/OK/eBXjta5iX29zQl8YeGmoo5pAZg5uLUujtwW3t9bZ+Iu7zEKGc4IHioS+BjQbYnrVJ5R/iz+CShZ+QSQDVHozsau+x6TROJMaiHuHPg2D8/J0nolh5LqTKrfe0qYyRc0Gse1QIdZwCVD+qGNJ9qWYfC5ofEFppaXb6yFY2QJani9WcQB2LxaIrIh1dtzKfBmRWWGyohpqhoarhbkQIJzHQiMhZxnlpDRtwAO21/yjKauXi0tx9i6IlQE7PRfzixYjPcdAQB9a+RgGAdMqNU8dJkvI85vtX2xn7b7V2bIRAMOURdwDRho5GRvVH0SxhIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFkrTGG5HTKjcMC3tkWjNRAm5kCvztE0sspbefQjFqA=;
 b=kZaFv0C0yVuj8eO3jPq2m/H/1I+WhejnyK42dMhdLSHMK+M/yS4ob+cIqmKchPpk6o4VwR7wZlpre1InTqjsFIzzOdyF7mlazo3xXd63E+IkSIYwyqKdgS/A33tcJpJ2b4bWMW5Wh5EY2PvTvJ6gScG61+QQ2X7YG5B5yd34WjMmEGVmO7sVgQ1QVY0wQb8NdTAWtBxxk9bTX3gAgcK0y92XVQDFDJWgbL43ZGJcAzcYiroY0xg+MQt3KygZZdw50zT+PecF0Rs2GdfPNSE5qIkbZkA+GWIYro9j6Xoo7051ivjAF1hYNCryo1iSL+hkF+w6mA++nqMnCRfTyJZ7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFkrTGG5HTKjcMC3tkWjNRAm5kCvztE0sspbefQjFqA=;
 b=vGtu861g1sN4UQwRi3uykh3IrrhWf2qLf72CxAZEOzKTyeoDB8jZFDBvMsfs1kBmsLokPGB/2U1Xqoo47BfeNZIqszKwdz0TIAmAiwFsiZpJga6s4zGTrPdk4+NrfwUBRrR2dF5wmD+9k4Gn/aWTURBScS8K4oXrV2dl2S5yEEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 12:21:11 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 12:21:11 +0000
Message-ID: <e87e2e7f-bab7-2d1c-5c72-bb6282b0cf17@amd.com>
Date: Tue, 25 Apr 2023 14:21:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 03/10] drm/amdgpu: add new IOCTL for usermode queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-4-shashank.sharma@amd.com>
 <c5b6ed37-7488-c693-0607-39fa16bcf32a@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <c5b6ed37-7488-c693-0607-39fa16bcf32a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca33fa0-01ef-4912-de98-08db45878e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aF7mhIcLOSePqPW9glNrq31hhorREb3kXBDeHxPvYMG4WAXq9mGp83Hzu8Oy1EtlYnSnuecqLA6HWx78/HNl/M8Gio7mRqRtgcyv9MvJELIlg53gu3z2PhLzLvPf3sPvBEzcBNCypOHA3sg4go/qkpQtQUBghtkAmTovoVzibZIRap0c1qm6cEpj9lgStCfLhMU/OtoHON3CJfZ9vz4nbKC7lnkesiDAZm+3DTGphkWc6pZIzo1ozse2MjbF3ohvwWlZntPzWVFzO3zuTGb8b4XEQZxdhB10LSg+Zxs5VGqoir0V6TzFRddaNivH9Q6QS87dN53gUxkAARpQJyCh0CtkEXHaDwow94o31m5T3lyYBuAgliNJEo7X+jL+xyul3oWl4GpEmQeZjXmpEKP41QyqHPUSZez/F5+00JlTCwNkwxMXbG/2s73/Rb6d5B4zzc6zGU2pLkvHtWyRQMduCG/SG4cqLsNtTi12kfg1OCUIfNA7DfDt6z4s/wL4DJZpODNFjrA4+rl48LqOHdnXibXbCePJlqTC8d8T/PNq8eDtDtRv/1NyP+Swner9fL8qZ2Q8ayfA1XXIo1vZYn4tECC79Gb0HI+E68ChszLTxoafZQxoTuSu3EQZ+AO1dtVTa765gWQPTtIi0qxDBtBl2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(53546011)(6506007)(26005)(6512007)(2616005)(36756003)(83380400001)(66574015)(186003)(38100700002)(66946007)(31696002)(86362001)(478600001)(66556008)(66476007)(31686004)(8676002)(8936002)(44832011)(5660300002)(6486002)(41300700001)(2906002)(4326008)(6666004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTNGS3hrNFFId1ZXei9vOGl6SzEramxFSzdCeDBjemY0dmJRb1pDQllxbVN6?=
 =?utf-8?B?bHI5Z3VCMTlTRDdYbS9hcmg4VDd4M3NOSks5ZFJ0a3Yrd0dLTUR1aXZxQ3dI?=
 =?utf-8?B?VU1NL1ZnV3BYZnNVelBjeFB0akJQVFc0bmszY1lKWm9EbVBKOE9SQXF5VHky?=
 =?utf-8?B?VjRnc3BBQmNGVUxlQXF2cU40eU9kaUIzdVNKWXJsSkVDNWtyUldpcis3SVhX?=
 =?utf-8?B?YWNJUysyamxldzFhaTN6REQxYzhncEc4a2czMERobDgwS2NCZ1B5YWdYK3o4?=
 =?utf-8?B?UWd6ZHk1WjAyOEJaLzI4WnVjYklQMGIwWWY3RURCSTRiQzgvdHpFL0RpcXF2?=
 =?utf-8?B?R3RMVTdybDFndC9sY05yTWtheGZEQnVjZVpXM2QwNlY1T0NMenNJb3ZFOTk1?=
 =?utf-8?B?d2U2Ri8zM1FmeDFkYkNBMlZOVTBSZnFXRDVTaHF0ZEs2bjRpSThIclg0Qmhi?=
 =?utf-8?B?aTBKVmgwQXQrT3F2QW54MkFKNzExek5xb0k1STFDLzhCVmhRQlh0bFdVT2Nv?=
 =?utf-8?B?NlhEc1ZtU29Wd3ZRNGgzQ21hbFZLMkZYR2FHTURkWTV6QklodUdsNWkwdDRZ?=
 =?utf-8?B?NThKUGx2UEFQWDU3dXVVcFAxUGVoQnZFd2VXb0hZb3g1RDFOTmFzRkREaFB3?=
 =?utf-8?B?YjhsZW84SkVrWnluVStYSjFQQ0FoeUdNWDJlTGxockZJMVJQY2hRd1ppL2sw?=
 =?utf-8?B?UUprVythNjFXM1JoZmdhbnBRNW5RQmY0bkFBcGJoR0g3aE8wenhSUzdWcG1X?=
 =?utf-8?B?NDJuTnRKTW5ONCtRTVJsQUIvNFBOaVRuZlZ6SzIvdUdCN3RaRXFSd0NmTmVq?=
 =?utf-8?B?cmRZa2NGTi9seGhJcnNRVE9TOCtuZ0hzTEh3NjJzcVB3L3pQRUtEK0VxTXlZ?=
 =?utf-8?B?OENSTTQvV2UxeXErcmYwYTJDL1lYbkJRZ1I1aEFtQlNlTytrOUVOVG9lc1cr?=
 =?utf-8?B?UlYwbDJSU2dURitZRWpQeFRBbTBwaUc3U3VublVPOEhMN0c1VDFaNnpVZDJn?=
 =?utf-8?B?M2IvMm9nN054ZUxGQnQwbTNkcldOekZKSmpJdHg4aW1FVnZyZXFtcXc5SUFE?=
 =?utf-8?B?QWlMUWRIKzNoSWpZSnVJdXhxWjQ3My8rYXdVQmpYTFhHTFpUbnl0VWsybHF3?=
 =?utf-8?B?MFF6emVCODR4SVoyNUhOY0w5MmgvbVhtYTdkVTk2RTRiSFFpL1dTamY5RGVV?=
 =?utf-8?B?RUwwVFNrM3VPTzY2TVZEdGV0YVN3SFYxTGlJTzlvZ2M4RHBNZFEwZjNvbzlm?=
 =?utf-8?B?UktCSU1oZmVXUXA4K3hwSTVuYnhBck84OGVhU3hpQlFVRzZRWWRuNUxUc1lv?=
 =?utf-8?B?ZHBCalpSazdFTGg0cW40eXlkYmVxWmdkL2I5czR4ZGUzTlJ2TTJzT0FjTTcx?=
 =?utf-8?B?akhBVFNvSlkwMmlHODhIUmxRaEFxTmw0R0pZWmFuOEJwdlhJTnI5Vnloc3Ey?=
 =?utf-8?B?d2w4ZmV0cHlISUxZME5yS3VaL3Qrd3BBbGlWeHFpWTdTVzJvSENJdHhTSERC?=
 =?utf-8?B?bzBZNnkvU0pNTmsxK1RPZ3BqUkFDYnNzYWV0TURQZVRYQ1JHRk1IMk9yNzNx?=
 =?utf-8?B?WlVVMCtFZXpQLzl5WXUyR1lBY0RDT0JUUkdhSUE3K2lYcUJHYU02aC81MktV?=
 =?utf-8?B?S2lEUlBvLzFPYjBaZ1VOOWJLa1hKcytyMjZYVytUY3BoRkY3ZW1IcDJnWE9V?=
 =?utf-8?B?ZVUvQloxdW1uRWNST1RlUjg1aHIvbERqZWJrUWM5TCtwWUdseFdnSVdnS05t?=
 =?utf-8?B?VHoyd3ArNnQzRFpuMHN5dVErdk8rcnhNMDlBV3FNMHg4RjduVEllNWFSZWQ0?=
 =?utf-8?B?d0N6ejY5enFrb3dLTnhZaDkzbW1xU0pScitCVzFpNDh4NnNyYmdhMjJBUXpl?=
 =?utf-8?B?d3VROFdKVWpqZ1FsRDVPTzM1NDVGc1BubVZuRGNKdlgxVlljUTNPMkN0Yzdt?=
 =?utf-8?B?R3d5TDA2T1VpZ1dvd1YvZzc0RVZldkFmaW9iY3ZMbHR4QzBrd3ZOajdJYU4w?=
 =?utf-8?B?VFFCbnhVWDY0UHhlVm1zN3IzWVlNblpjeURnMTIrR3FZTDZ0R1BkK0ttc2pW?=
 =?utf-8?B?azhOY3o2d2ZJTGg2S1lEN3hjb3gzTnNQc290and4QVliTURvRWJVY3N0bVhn?=
 =?utf-8?Q?02UtMf/y2KezVNGshNHXXigTV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca33fa0-01ef-4912-de98-08db45878e4c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 12:21:11.6482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nB0m0C2UJv08N432b4b/PqsvPIvpR9csDHzZZTDRtSdy+nEcfQrer+QHMOtD9xSw/fzNIV0PzUXugo3HV+jexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
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


On 25/04/2023 14:14, Christian König wrote:
> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>> This patch adds:
>> - A new IOCTL function to create and destroy
>> - A new structure to keep all the user queue data in one place.
>> - A function to generate unique index for the queue.
>>
>> V1: Worked on review comments from RFC patch series:
>>    - Alex: Keep a list of queues, instead of single queue per process.
>>    - Christian: Use the queue manager instead of global ptrs,
>>             Don't keep the queue structure in amdgpu_ctx
>>
>> V2: Worked on review comments:
>>   - Christian:
>>     - Formatting of text
>>     - There is no need for queuing of userqueues, with idr in place
>>   - Alex:
>>     - Remove use_doorbell, its unnecessary
>>     - Reuse amdgpu_mqd_props for saving mqd fields
>>
>>   - Code formatting and re-arrangement
>>
>> V3:
>>   - Integration with doorbell manager
>>
>> V4:
>>   - Accommodate MQD union related changes in UAPI (Alex)
>>   - Do not set the queue size twice (Bas)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 126 ++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>>   3 files changed, 129 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 2d6bcfd727c8..229976a2d0e7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2749,6 +2749,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] 
>> = {
>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, 
>> DRM_AUTH|DRM_RENDER_ALLOW),
>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, 
>> DRM_AUTH|DRM_RENDER_ALLOW),
>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, 
>> DRM_AUTH|DRM_RENDER_ALLOW),
>> +    DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, 
>> DRM_AUTH|DRM_RENDER_ALLOW),
>>   };
>>     static const struct drm_driver amdgpu_kms_driver = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index effc0c7c02cf..333f31efbe7b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -23,6 +23,132 @@
>>    */
>>     #include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_userqueue.h"
>> +
>> +static inline int
>> +amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>
> Maybe call that handle instead of index. And I don't think you 
> actually need those wrapper functions, see below.
>
>> +{
>> +    return idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ, 
>> GFP_KERNEL);
>> +}
>> +
>> +static inline void
>> +amdgpu_userqueue_free_index(struct amdgpu_userq_mgr *uq_mgr, int 
>> queue_id)
>> +{
>> +    idr_remove(&uq_mgr->userq_idr, queue_id);
>> +}
>> +
>> +static struct amdgpu_usermode_queue *
>> +amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>> +{
>> +    return idr_find(&uq_mgr->userq_idr, qid);
>> +}
>> +
>> +static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union 
>> drm_amdgpu_userq *args)
>> +{
>> +    struct amdgpu_usermode_queue *queue;
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +    struct drm_amdgpu_userq_mqd_gfx *mqd_in = &args->in.mqd.gfx;
>> +    int r;
>> +
>> +    /* Do we support usermode queues on this GFX IP ? */
>> +    if (!uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX]) {
>> +        DRM_ERROR("Usermode queue is not supported for this GFX IP\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>> +    if (!queue) {
>> +        DRM_ERROR("Failed to allocate memory for queue\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +    queue->userq_prop.wptr_gpu_addr = mqd_in->wptr_va;
>> +    queue->userq_prop.rptr_gpu_addr = mqd_in->rptr_va;
>> +    queue->userq_prop.queue_size = mqd_in->queue_size;
>> +    queue->userq_prop.hqd_base_gpu_addr = mqd_in->queue_va;
>> +
>> +    queue->doorbell_handle = mqd_in->doorbell_handle;
>> +    queue->queue_type = AMDGPU_HW_IP_GFX;
>> +    queue->flags = mqd_in->flags;
>> +    queue->vm = &fpriv->vm;
>> +    queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
>
> It is usually good practice to *not* store those handles inside the 
> object they refer to, background is that this always creates a circle 
> reference (handle->object, object->handle).
>
> Additional to that I would move registering the userspace handle out 
> of this function.
I guess idr should be good enough to get me the queue ptr, and I don't 
have to save the queue id in queue.
>
>> +    if (queue->queue_id < 0) {
>> +        DRM_ERROR("Failed to allocate a queue id\n");
>> +        r = queue->queue_id;
>> +        goto free_queue;
>> +    }
>> +
>> +    args->out.queue_id = queue->queue_id;
>> +    args->out.flags = 0;
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    return 0;
>> +
>> +free_queue:
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    kfree(queue);
>> +    return r;
>> +}
>> +
>> +static int amdgpu_userqueue_create(struct drm_file *filp, union 
>> drm_amdgpu_userq *args)
>> +{
>> +    u32 ip_type = args->in.ip_type;
>> +
>> +    switch (ip_type) {
>> +    case AMDGPU_HW_IP_GFX:
>> +        return amdgpu_userqueue_create_gfx(filp, args);
>> +    default:
>> +        DRM_ERROR("Usermode queue is not supported for this IP 
>> (%u)\n", ip_type);
>> +    }
>
> Instead insert the idr_alloc() or more generally handle alloc here.

Noted,

- Shashank

>
> Christian.
>
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static void amdgpu_userqueue_destroy(struct drm_file *filp, int 
>> queue_id)
>> +{
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +    struct amdgpu_usermode_queue *queue;
>> +
>> +    queue = amdgpu_userqueue_find(uq_mgr, queue_id);
>> +    if (!queue) {
>> +        DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
>> +        return;
>> +    }
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    kfree(queue);
>> +}
>> +
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>> +               struct drm_file *filp)
>> +{
>> +    union drm_amdgpu_userq *args = data;
>> +    int r = 0;
>> +
>> +    switch (args->in.op) {
>> +    case AMDGPU_USERQ_OP_CREATE:
>> +        r = amdgpu_userqueue_create(filp, args);
>> +        if (r)
>> +            DRM_ERROR("Failed to create usermode queue\n");
>> +        break;
>> +
>> +    case AMDGPU_USERQ_OP_FREE:
>> +        amdgpu_userqueue_destroy(filp, args->in.queue_id);
>> +        break;
>> +
>> +    default:
>> +        DRM_ERROR("Invalid user queue op specified: %d\n", 
>> args->in.op);
>> +        return -EINVAL;
>> +    }
>> +
>> +    return r;
>> +}
>> +
>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev)
>>   {
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 6fe5d8d73f37..8d8f6b3bcda5 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -43,6 +43,8 @@ struct amdgpu_userq_funcs {
>>       void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *uq);
>>   };
>>   +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct 
>> drm_file *filp);
>> +
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev);
>>     void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>

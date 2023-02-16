Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FA0C64EC4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 10:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3297310ED00;
	Thu, 16 Feb 2023 10:15:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D75FD10ECEC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 10:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hveo3ndF7pHjiXck0Cb+LIGo4eRqvdzKoJLvvJV1z6M69sCtH5ZTYL2eOAckiv0hjv+ryc0JmO2FPgoBL2lKgYY6Snol2rDk9jZ03GkiqPTaj8+mC2mT5vLNoPkvVm4QOhuY94ZTRizOG8XYeFodWC5VOxo6CLkR9z6xCvmeryhVBh0aRj5G24z3Pq3s9q7MKDL0oC29ZhfTjn1WF7y+fMJI7rLeos7crzztwtH+4p+HMGT77DZ+E/ex4R1DU+f2W6pmFHXT+w0LYB+9/iZtg2o6dZyD5t60SnbDqaPeW4HQIIreoOW+64ELMKmVkfCQwfspQSAfToS2ocZay7ZEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPFFcrYIod26FpUf9Zgv5M55cTFUvNOkdw3TNQvTNfk=;
 b=Th9F0b3W9BnwLFB4R+uWMlG0lu/mVq9FSKtIUh3QTfwcYWDWv0wdChJqN87Cw3auB52k/SyaGaM1b4gyzm2CKJy2aNW+2tR7NeElRodIkctfW9cKcIMr3tCxi7L5XR+QPbjVPN4HuGiph6E/Djm4qoj6LF56H+xflCPi0wwB5T4UQlSfO1VCyOPofxKIi61vt2gjmSYAjrdQRK+JBwijA37Ldw0lmAZn98thnTekyPdYRbqq0Id/m82oJhEST2i/Yi2LZ8FbNwXVKdoiUpu63fvScOUNRJg1uEvMbOQGe8RgzA2f4bSEmoK83/V8ba9KaAGRtKtN1UaM5TfswSS1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPFFcrYIod26FpUf9Zgv5M55cTFUvNOkdw3TNQvTNfk=;
 b=sHPt63+0eEBSu+D+ymUd82ZenrnRpZd3GYaDxhC27SHvBgLcULhHVMy74FUghTUr5qFse4absgAugRGr1SQaBjrbOJQr3gNXs9kuJBUAIHJFVZWqWbWHWnBzTZOGVgCPK5ml8HOFZzGbSNVKslLNxvkCaus57bAkYj25TCejYws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 10:15:41 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6c1f:b156:aec5:de5a]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6c1f:b156:aec5:de5a%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 10:15:40 +0000
Message-ID: <fff1423f-9e7c-1730-4d4b-18ca5b02ab7a@amd.com>
Date: Thu, 16 Feb 2023 11:15:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/9] drm/amdgpu: add new IOCTL for usermode queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230215184356.2205-1-shashank.sharma@amd.com>
 <20230215184356.2205-4-shashank.sharma@amd.com>
 <e4d4b06d-b51f-b78b-612c-870f9ec1f937@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <e4d4b06d-b51f-b78b-612c-870f9ec1f937@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6646de-5881-4c12-66dd-08db1006c155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bRc0Nt9EXnE1zv90PWtR5yFOQQMwyUhT892XrKQ6TcoceErXFDrCL74hYiNXq3PGxhqP7YDRVxYsO3meCwgKYVzwGJWnVUC0+nvKPvAQ4G6i5gBUnY1P/5yhyrDqchCktCu0XS47M/fTVDqg636wSWn9Y4cWYz4rKKv/z9G+PN3Bcuyojop6Foi8eqEtqsOSRNUk/fdHE4kzfDEkvbDpNb5coljfQYi2xmsZELXCrNeUWS4/+C8Ge3mVUrtwwogVuGhnoZZlvv7eEKNC0epPeMVte01n83knbYf12iswmNWlJPdBmQSwrqtanlX3zsot27nV0NOH59p8uAIVZpnEDWgktFdfuJZPnxVIefjh0CAYUT3ypmgsREvYHdhUIBS/BNU58LrA3C3/ron6RxuXahikRi9T99tmi2jogqulXCGQdawUYJOrDYyxKXLXFPSJCIRSeCKpi0ajffsQ4y/6Tt97PxaV+HeAtA0uzEWVWygk78dd/fJU3JRRkAFCzS3RO87L9HRLKn37Oxnrx8wpu4ErykrYrvJA95sUExeq2IRP0H9IOxrwcEU8FcxzKFhMiu3psPFcCbLw8uEiHHBXMpoMsEFp7ucbFgkBf02sGa+YlZh8s0xZuLt4MZLiwqfEyXbfSMGTdrIWbFGgovDTlTwd3IRcAnL7cGhUfyd5lGZpeHYQYreTZ3Fq5vJqCu524WyCtmPI9ZVIGRPOteooLYh4vLXYGqPEZ5UtKeOkNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199018)(31686004)(38100700002)(66574015)(2906002)(36756003)(6666004)(86362001)(2616005)(186003)(478600001)(26005)(6512007)(6506007)(53546011)(6486002)(31696002)(83380400001)(8936002)(44832011)(5660300002)(41300700001)(54906003)(66946007)(4326008)(66556008)(8676002)(66476007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWM4OGVObS9XcUtWTFJNNndPNjJLWHJzK244RDRJQlNpSHJ4VTNDQlUyeXU4?=
 =?utf-8?B?eEZSWkJmSXl3Umo0TTdjb2pma2l6Z3BSVmk3ZUVjWFRyQ0F1bklxbCtLNXhh?=
 =?utf-8?B?VDFtRWRHRWZhQXZJNVNUamcvenVGdXdvU0ZZK1Bnbmt0SXh5eGxQbXgzdjZL?=
 =?utf-8?B?QXlWb0dtdFE0aGhmZVUwZjlzL3NvQ3BaWHR1R0UzbkJmWWJnY3hGSDEyalJh?=
 =?utf-8?B?dlh2RTF4eWNzcW42M2p6VkRUb2hMckxROXVDeFV4c3ArNVhHS2pNNG9NdjRx?=
 =?utf-8?B?SWRjZ20zekxEZDNmZjZiLzlGd2Y3TWhVdVdDWFZ4M1p5dWw0K3gyM2lQS2pw?=
 =?utf-8?B?NWZZY2o0MitOR2k5YWpHWGc5a0QwMFcrb2dKOHhGOCtFZlR1UjNqVS96UHNw?=
 =?utf-8?B?eHhJY2ZxR2trVzRJQWdMS0NBK1NGMS9OQkRQV1gyVzQ0aVhucjloNHBpL040?=
 =?utf-8?B?QVNaLzAya3dUWndLQTE5TC9Lam9SaXFIQWNNWTZlaGNJKzhPUngwNG9LZjVU?=
 =?utf-8?B?aWVQSmdub05FOTdXbFR3Wk85d1QxbS96bGZHWXpHZ3pwRHlyRVBzTGcvdisv?=
 =?utf-8?B?NTJuTVFaSGpyM0pHaEpVOC9XVHV1bmRGYTNmaTZDWWJDUTVjeWE1V0VYS1h1?=
 =?utf-8?B?OGhXSDVUZHhVQU9adXh4eTdDaDlGbUJIWC9ZTVlRM01Da3haeHpVOU1TSVd1?=
 =?utf-8?B?UzdBMHRublBFTm1jc1pQUVVQY1B1OERzL29aeUFkRDBQQkxsY3pxZ2xzcUw3?=
 =?utf-8?B?TVJuOTRTeHRpNnEzOTU3cVIwZjFLTExoWXQ5ZGVQdzVqTGVOczNZdjAvUXow?=
 =?utf-8?B?ZGxyWTNYNHZKTVY1WGVSQ3lWbWVXTHFBWWNjRXZuTjlmNlM0aFhtYXB4Z1JG?=
 =?utf-8?B?UERIcEdqOTJiUkVvRHJrMGFyVkViZnAvMkQ5R1RUcSt1VkZWeGVtbVYxSWZx?=
 =?utf-8?B?ZDYxYTRUVWRCUFRnU3pMTjhKR0JLSlpBWXZJUE5wQUo1V0RBeEVRNDdRMWE1?=
 =?utf-8?B?aXl6clZwNEVoT1dmQ0NwU0NMNEtLSXdDZ1BxcU82UHh5cEx4L1dGYmtsQnk4?=
 =?utf-8?B?V2NjS2ZUZDBNVUFGa3VsSE1ySm80Z2hTNzVlSVJXZnVCVjBjblU5aW1XZ3o1?=
 =?utf-8?B?NEU3cDhQZlJXUEtWRHcwdSszSmhHczVoM3FFd1hRdW51WlhIMUFUNVUrcEhw?=
 =?utf-8?B?TkdzbmFQL0JHNWx4Q0VsVDNSc05uQTNzVU9oUVNndkt4V2lRbnVYQ2Z5WkZL?=
 =?utf-8?B?K3FVeDZ5aE1YcXBQNTU0SUdac0F4Q01qSGZkS0dmbWdNbzY2WTk1c3N0djl3?=
 =?utf-8?B?UnB0a1pnVVk2MFYvVGhLbCtnYjJoekxQYjFRQi9MdjkrdXQvcHF6a2xRUlZI?=
 =?utf-8?B?NTd1VHBzNkUwVHdKWkUyMEtTTTEraWhDT0huZFdKRllidjRYaEZDNk5vWHRz?=
 =?utf-8?B?MElyVEtsS2pDdms2a0tJaUxCa1JLdlFuVWhPRDB6amM3MGp5Kzh6TzFTa1pU?=
 =?utf-8?B?R09aa08xQTV0ZHFpeGJuRXhLZU1HdVRoYTlFVEwrSVJoWWtzcXhpa2liejdi?=
 =?utf-8?B?SENhb3VOSm5id0ZLYUx0dFhZQzVMVmpIN1J4ZkRVN2FpaG5CUlFNZ2VZUG05?=
 =?utf-8?B?SnlhbGxRZjVvZXpncVRrd21xQVRRVjZrR20yOXVOQ2hUN1ZUd1JqNXplYmRW?=
 =?utf-8?B?OGhFN2JwanJGNmVtekkweVFycXNhcmVPRjVIaCtjNFRrRDV1bW10QW1FV3Ev?=
 =?utf-8?B?Yk5vZWRCUHl5WnhiTmFieGM5czhXWWJRTXBuZGoyVTlWb0ZRSVlGNVZSR1M2?=
 =?utf-8?B?ZmdYZTRXWTdkRVNhNnhLMGpyeUpsMStPM01vaTF4QTFiakJSZ09YV3IxaVdT?=
 =?utf-8?B?UDRVQ1dFMGFiQ2FQdmNCSmI5NkpHU016eDMvUTV2VFppZGJWOC9sZk1NUjhK?=
 =?utf-8?B?WEZsZWZpNkt1SndxTGVraGpuM3ZrL3ArZ0ZBRFJkUjlWUGY1cm1VbmwxT1VE?=
 =?utf-8?B?Mnh2eWJzSVhNU2F3ZDJBdlNhcDBxNkpSWXpxME1FY0l5WFVJdkU5Y3hQYk4z?=
 =?utf-8?B?V2t2SFp6a2lzaVRwUk95ekVLUGZleTBkUDRnVlFCcEFiejZ3eGRYUXcrWWkw?=
 =?utf-8?Q?05x6iNVanSMwQuGzHhMT3rdEs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6646de-5881-4c12-66dd-08db1006c155
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 10:15:40.5941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUUmxa3HLrVyb3NX6VPnSiMbcT2pD5LGOl3/h68ZEGNCfm5ml6K297VVK3eP9Xlrv3+N3gtFI7o4rByYHTUPCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295
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
 Shashank Sharma <contactshashanksharma@gmail.com>, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Christian,

On 16/02/2023 08:23, Christian König wrote:
> Am 15.02.23 um 19:43 schrieb Shashank Sharma:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
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
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 114 ++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>>   3 files changed, 117 insertions(+)
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
>> index 13e1eebc1cb6..ecf31d86f3de 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -22,6 +22,120 @@
>>    */
>>     #include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_userqueue.h"
>> +
>> +static inline int
>> +amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
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
>> +static int amdgpu_userqueue_create(struct drm_file *filp, union 
>> drm_amdgpu_userq *args)
>> +{
>> +    struct amdgpu_usermode_queue *queue;
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>> +    int r;
>> +
>> +    /* Do we have support userqueues for this IP ? */
>> +    if (!uq_mgr->userq_funcs[mqd_in->ip_type]) {
>> +        DRM_ERROR("GFX User queues not supported for this IP: %d\n", 
>> mqd_in->ip_type);
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
>> +    queue->userq_prop.queue_size = mqd_in->queue_size;
>> +
>> +    queue->doorbell_handle = mqd_in->doorbell_handle;
>> +    queue->queue_type = mqd_in->ip_type;
>> +    queue->flags = mqd_in->flags;
>> +    queue->vm = &fpriv->vm;
>> +    queue->shadow_ctx_gpu_addr = mqd_in->shadow_va;
>
>> +    queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
>> +    if (queue->queue_id < 0) {
>> +        DRM_ERROR("Failed to allocate a queue id\n");
>> +        r = queue->queue_id;
>> +        goto free_queue;
>> +    }
>
> Don't keep the assigned id inside the queue structure. This is only 
> used as handle between userspace and kernel and not useful inside the 
> kernel otherwise.
>
> This prevents people from using it in hw communication.

Noted,

- Shashank

>
> Apart from that this looks good to me,
> Christian.
>
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
>> index 7eeb8c9e6575..7625a862b1fc 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -42,6 +42,8 @@ struct amdgpu_userq_funcs {
>>       void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *);
>>   };
>>   +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct 
>> drm_file *filp);
>> +
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev);
>>     void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>

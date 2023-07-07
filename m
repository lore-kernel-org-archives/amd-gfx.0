Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53C3EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 07:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C0D10E51F;
	Fri,  7 Jul 2023 07:39:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9EA310E51F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 07:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ejpzp194oGBf3QPKoMYFvEqpnvQLHcjvFJMcESfKaIsUormLP6tBet99BwHF8XuXW//63x6uyzDoZccCqmtSRJRyKVqmbAChZy/TNSrU/mQMvypvWN+G7Xb1M7VgDd89E9LY/XKMIsMXL4dXU14OH3F6yam0zoLxWypTGStz2A9m1O+vrWggn59n8N7Vok0Emy1pKLLxc7X3mgv2ZW3A7hpko7P0dnPLYVaX2haZwJxL05ehdtukbu6/lxIGxRsLtol9Bi9lLUeDl39sgTfUH7hLYfnbVFfQKbM+QwtQ4ILYX6I0T/7tzHyKnMTvL6hN3UM46bJLDqqKca1lziETzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qZRdxkOqLriXq7oAfevKieMR49ZR/OrsZ1CEZ5GxTQ=;
 b=mlWxsdCKPf/Tm557AqAEjmC8AALUQPFZykgmN5dbBb5GtmZjcf8TiOUbtSc+hIq5KwvYhW5ZIDpxh+g28aPqW8N6xqg82rFuAZ5feJIePW/gQNTClNrhFkwHqcgXtswk58eMKCNHuv7BU/UBsNnNhki9enEwnUjKaO95EAHAp1sOVDdN+E2FS+wUhYDILGKrRJEMH24zmEjZXmLDYdQD8/qrLawY0/ldmR5bgbF+cUHprkV1N2fMiZVDkeYBWvUhdIsBmcT3KBYIMuvd6ZTO46iVAGNKbGScGwg9WALKM3t4rB7i5LEoL5TIGFwuyr4C0tAk14lpwpVyRuIdJkc7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qZRdxkOqLriXq7oAfevKieMR49ZR/OrsZ1CEZ5GxTQ=;
 b=FM11guoqJ7KUrReAueMYRtT5IyGtsPxQXXpmZ4n2bYmJONw76vfwafgv+Onu7C9iYNmfN0fm2/NHrdez6Y9TCYxEThjNOpTYlWT67qoxemJfSEiKihW4XY4BVg72Z91wF7AHxcDPLA8Cze4P9Q51PXnxUR5r3Wd/u+QWN5XCESQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 07:39:39 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 07:39:39 +0000
Message-ID: <317c5dc2-ef39-d88c-d78e-5823daa5e92f@amd.com>
Date: Fri, 7 Jul 2023 09:39:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 08/10] drm/amdgpu: generate doorbell index for userqueue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-9-shashank.sharma@amd.com>
 <2834445d-8da2-e853-50c2-2fececdb86e2@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <2834445d-8da2-e853-50c2-2fececdb86e2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::9) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a64ef3a-79d7-49ef-b112-08db7ebd5194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UHk/t8sQ9HmlvMJ+DhTOCmZP9KqCzUOYStA+ZysJyEiIw7oRyyed7dU7NH0kBjdHUrlMSInpuGoMzoaIHaIbI+BIRGhm+aRcbyJLk1Jg0JFSlKAS77by2n1sTlqwCTsVGqaUrODjI6YrGFmU1v8zZYSDLjppm4WbEI4GNSYYnv44PtGIC+DB/7trvy4PaznavZ7jPysMids8wT/Q3Rk4KZ9teNY/zFKhdffWMpD9k9XHKrZIkSS02JHYlsm8vAJwv3nS15NM2e/dzKRi3iKlU3EjrBwfgS2fk2Bk95hGX5fEX/ttUJHHszHT3VZG76KH9557mbpX6fou1zT3IKJ8HTRG1VuW/V6KkfbpljvNntv6kcI8MOqujaR1RIbzgtaRGz/Qwz/r8H7OuSYiDTWQSnjodxvwoAhqazn8JfkSeq/raV1rWh3RDv5G/OrrZxjFtgx2cM0e53l+KozoFn1N5Zh+dfIIN95h403LqwvHIdPUFXqlonxZeZe3Z0B6NR48wdA0lc10T0QXDKc3lmExUGuFI0bsrDzxN/ueYu1ckVm82umGBS+7EhdyUEwtMWNe6ylmcm0lvQoAvNqpFR+bHclaP2aovsjp2ADLG0pq1zixwRIg0QJcZ/rWgi9bQ4/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(2616005)(6666004)(478600001)(6486002)(26005)(66946007)(186003)(966005)(6512007)(53546011)(2906002)(66556008)(66476007)(41300700001)(316002)(4326008)(44832011)(8936002)(8676002)(83380400001)(38100700002)(5660300002)(36756003)(31696002)(66574015)(86362001)(6506007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEMwTDU4SEJDMjFIQ2RQV0RSbXgwYjJqbkd1MkdRN0pvME5yYTdmblJwR0Qw?=
 =?utf-8?B?Smp3UnJwVnBzVjNhQzV4c2srUlJiTDh4M1VtM1R5RmNQaCtUTUpjamFIb2pW?=
 =?utf-8?B?Unlnd21XclJScmFNbUl1a2Vad0w3cG5YVTc4bThQd1YzT2Zud3I0SVMrWGpO?=
 =?utf-8?B?MWpBMUhqaGdrQXE4Zm82cEVoaDRJMXRCaTczY0lNQlNOOVNTYzZUSWlpeVhn?=
 =?utf-8?B?MU5pNXdMRVhKUHZHbHVDODU0Yk9lYmRIVStPUGxmMllESTFkbnNQVDc1VFRN?=
 =?utf-8?B?Q1RJbjRHeGQzcittRkcreVB6UTRUQmxaYjVWalFEUXUvV25rV0VmS1VEUFJU?=
 =?utf-8?B?MzZFaGRCc3lrUENwVkl3TjJVdWVKTEwzeHYyNVJnTmw2MFBPejVhOW1ReGpz?=
 =?utf-8?B?aUVYdVlaTkt3N3dNUUc3cjZZdU9BdmdKNGlWQzJacWk5cGY2Y2QvL29wVzht?=
 =?utf-8?B?TEtwRlcxZDFSU0lkSWp4R0dReEI2Yzdhc05TS0Jkc0hxbk9kdXRuYmxjbHY3?=
 =?utf-8?B?SlQ3RVFHQVVsVEErOVRDSFR2VGNoM0cvbmI4M3lDYkxHNGtzeFNXRkJ3VGpU?=
 =?utf-8?B?cExZOTh3YWJtUTk3c0xjNFkweElsLzZlMWFYeTQxWnl6SWZOUit1Uk1ydFIy?=
 =?utf-8?B?RmZBL1FOZVRweFV2ZkZvSXVrMU5valFoQjB2MXlJQmd0K2pkT3BBekdVZUtV?=
 =?utf-8?B?ZmtSTVY0My8yblVRYVhwTEh5Y3cwTm43QW1lbTlwR2F5aVhmVjEzd1plcHJE?=
 =?utf-8?B?c3ZpRUNHa05JbGR6VTZ0MTZRVVZFc2JGeVY5NlRaWDRuL1JqdGVnWW02aTNq?=
 =?utf-8?B?K1cxRDRWOXdCTjZDYm8wQXVoWUFiMU5IbXdSUEw4OHFHQmhKcHh5eVZLK2hv?=
 =?utf-8?B?UjFZeXY0bXB2QkpLcjV1WGF1ZWx6enlSSFd3aUxSZitqQ1kyZkM5ckkwVjNQ?=
 =?utf-8?B?dEV5azFraXQzeWVBOGVDZFVwWk9iSlBiVTRRUG9GVWlCL0xSSDZSWkcvK0RF?=
 =?utf-8?B?OXp6emRtekhwK29oRmI3WjBXSjlJSGY4d0E1T3NmaWlmYjdZeFQzZ2NqWjE2?=
 =?utf-8?B?V3lzYXNuQnVZVXN2ZXJhWkxHK0dOcW1LWE5pOTdkQ1ZpTkt2cVdDL3c5SkJD?=
 =?utf-8?B?bThQTi9GVWw3SEZZSVdmc3FrdEI2RGpWYXJmSHdmNVNUUEcrU25LeGs5dDlC?=
 =?utf-8?B?SjV1UlU4VmZLa041TXE0TlFKWlI0YTN3TEY4VTg3YjErRGk0bTJlVHlPajhQ?=
 =?utf-8?B?OHBjUlJndUpNaks2ellIRFJtRXdBU0NPd2NjcnZJZ1ZTOWdjK0ZrbHJYc2Fa?=
 =?utf-8?B?NlhOSVR6U3FjSk1raU1qcExpeFROZTFwNEpUandBNWE2ZG92UEhzSDRmV0VJ?=
 =?utf-8?B?aTd6bWVGcVg3QlR4WVpCc2RCMGQ4cVVReDV4YWNNSEN6NTZ5RUpXc2Z6aWF2?=
 =?utf-8?B?cXIxTzRqbVgyNzIvN2o1MEVsemJsOFRZOHV1eDRQNzFjRUhqM28yV2NHaVh3?=
 =?utf-8?B?aXZZUUd3RDByc0FkbW5FNVFPQ2M5WnJtVVFtTGFiRE9YdXF3a1kzeWNDQW1v?=
 =?utf-8?B?ZjFpRDZlaUFyMjNHNFkzQUZYekMyV0sxeVlvKysrQUVlOW9JV01rdmI5bzBt?=
 =?utf-8?B?TVl6T2ZHQndKeDBrNm84MW83U2RVSm9KaVhJTFFzVkpGU0FWNW5ML3FiSVU1?=
 =?utf-8?B?anhDQ0ozdnBUSTcza25FckFibk8xZ3VYcTA0QXRMWnFoZHZ2N21FQ3ZUZmpj?=
 =?utf-8?B?djRyNHhnSXdVb0d1R1BDL3NrMW43RW5uNUtTNlFRTkdTeFMvSWRrQU16UUZB?=
 =?utf-8?B?Yk1ZYjNYd09EUWF1Y0NLbWEwbDRPK2l2dTB4NnpsdzJoVDEyVGllVVRGWGZ4?=
 =?utf-8?B?RDhKM2tIY0pkamg0eHVuWGRPRStLdGJEZWJQdnhTaExmTEttQ0Q4R2VUN1My?=
 =?utf-8?B?bmZXYno0aTNKQ2VTSmFZR1FOUnNtTUc2Yk85TnR5cXRQOExnc0d1czM5Zjdj?=
 =?utf-8?B?RTBJaTVRSmowNi91cHh1ajlTZEFNaHV2U2VURmpzSkVkdm5YTGo5eitpWnl5?=
 =?utf-8?B?bWRqK2IrVlhsMjIyL3l3M1gzSHRGaHRLVXgrWUVZbjBJczFsUEZLY2VqYVVm?=
 =?utf-8?Q?joc/85GnKscVHgLoXa/2ziTKv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a64ef3a-79d7-49ef-b112-08db7ebd5194
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 07:39:38.8620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftQabTf/5U2RsLny4mnVU/h+lpKjdB425t6EEKMj23oN42f95EOnePV3H7aD5Qv4ulS2k2q69I6Zue8SPMMLSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/07/2023 09:15, Christian König wrote:
> Am 06.07.23 um 14:36 schrieb Shashank Sharma:
>> The userspace sends us the doorbell object and the relative doobell
>> index in the object to be used for the usermode queue, but the FW
>> expects the absolute doorbell index on the PCI BAR in the MQD. This
>> patch adds a function to convert this relative doorbell index to
>> absolute doorbell index.
>>
>> This patch is dependent on the doorbell manager series:
>> Link: https://patchwork.freedesktop.org/series/115802/
>>
>> V5: Fix the db object reference leak (Christian)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 34 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index bb774144c372..61064266c4f8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -32,6 +32,31 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr 
>> *uq_mgr, int qid)
>>       return idr_find(&uq_mgr->userq_idr, qid);
>>   }
>>   +static uint64_t
>> +amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>> +                     struct amdgpu_usermode_queue *queue,
>> +                     struct drm_file *filp,
>> +                     uint32_t doorbell_offset)
>> +{
>> +    struct drm_gem_object *gobj;
>> +    struct amdgpu_bo *db_bo;
>> +    uint64_t index;
>> +
>> +    gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
>> +    if (gobj == NULL) {
>> +        DRM_ERROR("Can't find GEM object for doorbell\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    db_bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
>> +    drm_gem_object_put(gobj);
>> +
>> +    index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_bo, 
>> doorbell_offset);
>
> This can only be done with the doorbell BO locked and as soon as you 
> unlock it the value becomes invalid unless you pin the BO.
>
Which means I need to use create_bo_kernel() for doorbell BO's or 
specifically pin it while creating it ?

- Shashank

> Regards,
> Christian.
>
>> +    amdgpu_bo_unref(&db_bo);
>> +    DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
>> +    return index;
>> +}
>> +
>>   static int
>>   amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>>   {
>> @@ -64,6 +89,7 @@ amdgpu_userqueue_create(struct drm_file *filp, 
>> union drm_amdgpu_userq *args)
>>       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>       const struct amdgpu_userq_funcs *uq_funcs;
>>       struct amdgpu_usermode_queue *queue;
>> +    uint64_t index;
>>       int qid, r = 0;
>>         mutex_lock(&uq_mgr->userq_mutex);
>> @@ -87,6 +113,14 @@ amdgpu_userqueue_create(struct drm_file *filp, 
>> union drm_amdgpu_userq *args)
>>       queue->flags = args->in.flags;
>>       queue->vm = &fpriv->vm;
>>   +    /* Convert relative doorbell offset into absolute doorbell 
>> index */
>> +    index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, 
>> args->in.doorbell_offset);
>> +    if (index == (uint64_t)-EINVAL) {
>> +        DRM_ERROR("Failed to get doorbell for queue\n");
>> +        goto unlock;
>> +    }
>> +    queue->doorbell_index = index;
>> +
>>       r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
>>       if (r) {
>>           DRM_ERROR("Failed to create Queue\n");
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index afaeecb9940a..8edb020683a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -6719,6 +6719,7 @@ static int gfx_v11_0_userq_mqd_create(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>       userq_props.queue_size = mqd_user.queue_size;
>>       userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>       userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>> +    userq_props.doorbell_index = queue->doorbell_index;
>>       userq_props.use_doorbell = true;
>>         r = mqd_gfx_generic->init_mqd(adev, (void 
>> *)queue->mqd.cpu_ptr, &userq_props);
>

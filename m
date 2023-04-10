Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C25C77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 14:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A64310E395;
	Mon, 10 Apr 2023 14:28:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA6C10E395
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 14:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpXARCfe/w7MqWpWJCHML0FMPPtaEb/NCuYzErp2gvkAxgWDUXWc8GRUtoCzbTS4J8w/KPpxnGzPIq1hxk/8i15cIQMFFN707jek5xqnywz61uhPnel28vTaaSiD7+T0Rlc6jhJbxnFFccSLYFqEQTTAeJeaG4xuoeGn+M6XGnfDPFD+fg0h+ad4pxyA2ywND3ZiHN8Wz8JldW58n39WfcQhQDGG/aMnfdqlQXxQTl2x42p5dbWCMlvZNFjMfCkcnujZtZxwyFR0CqGe+28DdAgm925ld8tSL6ZrN5ULBS1gcJbPAgxHsEdlR5iYS0ZKYaUSWCJWfaMHulE5+rp8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/7zpaZDOX2UvUOjeMlA3inCWybeGUlCMPUt30yp4Y4=;
 b=ahOBdOj0ycxwaiJi8IoakJpp8cEEOYC9wgy4J/pw7JV4oPzE7y3KQa8/lga56YyBsuLYDrtzUNvtXR6YtmkEVOgDTQ0VSLc2N7TOm1/UTlUDlmA1MBuqcJC3bKympkcHvczmpX/8m/RaV1ItsC1aTQkjPt2IXDioEWQIzvRMJeDb1wy7UTQ14WeD+n7FconhA4IlAYgei6cOrMfmVUcd8ZUpCX99aV0szKyRCPnBH5L5SpRz/KdDS0uRT0Sm769S8mco/4LJ54AVO8ChuQMk6gNfj6m+eflX1r8g+ZMLi9rNcGr9G6qHRIz4CGQhdZocQQq1Vd8D9FwZ+hXXWwOrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/7zpaZDOX2UvUOjeMlA3inCWybeGUlCMPUt30yp4Y4=;
 b=WxS2qZMbhLEZec5PsDqWvtrOa1P678ksC+hy/ar+kZBFCRwonIDPrGCDrt/uvQCfixrC5irSQ+yH1C8ukGPyQDUjja8P93bgHigiNXonozb//C4kJ6U99pg6UPM7cyj6LhQGHieydTVagV6hBGWZtMtlsg9hUsbwWsrlzelahog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Mon, 10 Apr
 2023 14:28:52 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 14:28:52 +0000
Message-ID: <90270ccb-a46a-7a09-fdf5-f77039fff8a6@amd.com>
Date: Mon, 10 Apr 2023 16:28:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/9] drm/amdgpu: add new IOCTL for usermode queue
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-4-shashank.sharma@amd.com>
 <CAP+8YyH7v0oOy5j8=9Y9f1hbLD0Nca6ZZGgo8nSup3qPiMfFLQ@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CAP+8YyH7v0oOy5j8=9Y9f1hbLD0Nca6ZZGgo8nSup3qPiMfFLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 792cd975-3012-434e-2c2d-08db39cfe85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ou/26NKqtpXBP4QHNgGBzaFWBki/sdHnegoitcKbuwrRwKARU0375dFxEL7w2IIluYaio4wpfl9dEavMPmcobiCyDXtk6lvDrf6bMKfu95zb+FoBeEt91uRRs51Y7pQ3rsoEPJyofdfVt890SgkIOjUKWb3ILh/4WTJqAtAnCeBFyCt0duIYu2vnsWWGlfuaarxmycun7ux6V3YS6Nr8EI/zUDWN2MlBN88JP7KUo+LCpl3K+rN0Gnwpb4bl557Zox13cy7YNugLve5NkpBhBp4uvqHBtuGMOP7WYitzxvtQSarmC6XjtgStRIGHlihaLTUJhtN02Lm6Lao6FMsy2+6dssgxgwkxUqdTJ085HN1m7gfrfc6ZhC+hu9Eud+RQcVKWNUmLof5L2WLrbX5h8kJjKei3sl84ByIOsrVeNw63XdcS/MvSEytElLZyLnubnjuCzk7g+dPLAjqh7m1oCU3CfnRfoB3YJI5PdlPa0ihi3DQlGm5wtr5vkB0/qSuzb6iOQJJ5LWXh1tWuuQBdMkbh8K/ptDvsQANz1SdR0FUdEWBSKcA5KQVz3fJNL9K+QMKOLpAHawD3LqCpe2UCKZu/JqOeSOh8rRr7rtFp9oXmBPqhgYidAszFZSLmqYiK+qSdW0H4hDIUQAeXZv0Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(31686004)(4326008)(38100700002)(36756003)(31696002)(5660300002)(44832011)(2906002)(8936002)(6916009)(86362001)(66556008)(66946007)(41300700001)(66476007)(8676002)(6486002)(83380400001)(2616005)(186003)(26005)(53546011)(54906003)(6512007)(6666004)(6506007)(478600001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNBWHVvd3RGNldWbHdQQitKYU51blR6RjRGY3dCdkNzNUllRllQQ29ZTGhQ?=
 =?utf-8?B?b1V0MXpvek1iV3ZiNFZ5N0U0T29PU3hISjYvSE5sTGVIQ1lIVGc0eWJ3SDlV?=
 =?utf-8?B?dTVVUTMxR2dMSkV0WUxrekJBKzhETCs5Y3QvTVV2eXc4VStjaFRJSlJJU2hU?=
 =?utf-8?B?RGNYVHVZTVJvVDc2cWZhS05UbTJ0QmJqRlNKbWFjc2hIWll0TTJGeTlQeU5v?=
 =?utf-8?B?enQ4VEFsN0NaSnVxYTJWaXpvc2JXTkVWbzJxWXMyeEhJeHg1cTZ4RFRDa01J?=
 =?utf-8?B?ZzhzWFJkbTBKTDY2VjJKYVZjK3hKVTFJM2l4VWloNFNORGY0YXQ1ekxna2o0?=
 =?utf-8?B?SGpIOGwzNGt2THNyN21Jc1JBZUYwMmE3SGZ2UFR4ekppVW1RdGlXVER0czBR?=
 =?utf-8?B?VzRKYS91dVh3b0tFSDBiV0hYZWNhOHZnOUVieHNiMkNZYlFiemVUWHZyNFli?=
 =?utf-8?B?RkpwQnY2WjZzUFlGMmJqZWtDcWRCQkR0V3ExVzJtUWloWGtsandCTnU1ZXR1?=
 =?utf-8?B?V215LzJWMkxqNGlFM3ZLaUNjOVJhMWwzWklROG5nblVRazFGUnlleDZaSStP?=
 =?utf-8?B?ZVh2Q2dwZktZSHdYdlVZV2E1R1VxbW9lWHA4enZ5MkFCZCtjNWh1U1FFWGRh?=
 =?utf-8?B?bnR4NU0rWTREQ1d3SmJzcENPRWJubEVFR2l4VzVla1FWeUpuZzR6RmxjcjRs?=
 =?utf-8?B?Z3lmalF3enhFMWhZV0p6b29ZUkEzT3VHTG5PQnNpc0FlalRQQk1kU3dNR284?=
 =?utf-8?B?TmVWSDgyYTg1UU04RlRhempEUERhZFdNdFRYV1MzNitzOStTNnllWlQzWVhM?=
 =?utf-8?B?bUtBSEZzc2Y0UFR3YzNyOXE0Nm56WGtYMEZTUG5XU1dtcllzVUJmcWpyQTBs?=
 =?utf-8?B?MjlLaXJxcmFHTVo1ck80eFFRL0V6eU1EakkwRXorZzQrcGhzamNrUTcycElV?=
 =?utf-8?B?M0dDNndHbnF6b2h2dWJ0djM3OG5rMDJnOEEyZ01hbDJodi8vMmJESjFSRDBn?=
 =?utf-8?B?eWswWHhFWE85TDJ0Qi9IMTJrbDQ3eFczSkJ2ck5wTFkybWJoR0U4MThqU3Jk?=
 =?utf-8?B?S1RmVVI5aHUrdkZyaSszK2s2K214TWNuVlJKZXpXeXF1bjdIaWZiTkRrcHFa?=
 =?utf-8?B?TlRjUWt6cFFmcnljaG5ULy9IQnl0OWRYWEtvRGdSMnNHRmlncFN6T1ppekpu?=
 =?utf-8?B?WWpOMm5JQ3RHcHdhOVhBTGk4TWZOeXJaVzRYL3lCUkZrSW45MEdXdDJiWnZh?=
 =?utf-8?B?L3VqZ0kyWDRuSHBJQUpIMDQySlpiV3NTR0FBeWJBQ1FXQ3RkUXU4VUU4dXRZ?=
 =?utf-8?B?U2YweFNxKytBRmZTa2VaUnltdHBMaE1vK05RUTBqOFo3QUI2NzhZMHlUUTlB?=
 =?utf-8?B?a1J1SEdKd2JzMkxkTytMZitmUllncmtIMXZmZmNESytOVkh4d3A4N05rNGt0?=
 =?utf-8?B?SEEyVFVJaGpPUDhxMWJ2WFhiUmlKelozeit5MkFRWUhCdEJrVTZYQWNVeVB6?=
 =?utf-8?B?aXVKRVFSVnNJbjIvNk9yVTc0azF3aTFyVU5qL3V4Kyt0WGlUbzZHSTQvOHZZ?=
 =?utf-8?B?eW1CWDBmR1FzUmtGK0I2dDNNTkYyY1pPZlpsTEdrcyt6MWU1cFJubTV4NGlI?=
 =?utf-8?B?UkVzQTJqN01jTmprSVN6NHpVWWtRZFhjWkFxMTE2V3ptSk94bUIwZHB1Tk5G?=
 =?utf-8?B?OWVLcUxadHdqOUJyNE41YmdqdkJVeHlhOHp5UDYzbWE4Q0c5aTByNW1xcURw?=
 =?utf-8?B?dUFlSmVRWWE0UVFhZExCZEtKeUw0eUkwUzh4OVVHK1Zlc2JCSk5pSU8zYmdR?=
 =?utf-8?B?ZzFnSmVqamFINHdpUzZKVU5pekQ2blhOcFR3MEpXdmVBcC82YnU4c3R5RVVM?=
 =?utf-8?B?Sm95RGJQVkJTSkJPZ0xGSG52OWlobXZIaUFmT0lNKzlCWlQ0Ri9iOTh1Wjg0?=
 =?utf-8?B?eEdiQUhjZVBMZisxT3NSdUV2VFFqNFIyK2lpUmtOeXdiUjQ3ZEw5Z1JwOXgy?=
 =?utf-8?B?elNTcEROOU9GcE1NcmhpbUJCb3liYmwyeHg1ZlAvYVlaVTJBekQxN2JaZ2JT?=
 =?utf-8?B?NGVoWS9aZEswV3loYnhZVmZtMGNRZHBJTHZrSUZOc0VNRXJrbW50T3ZrSTRM?=
 =?utf-8?Q?4s6W9gY2SnsXDCiyBcJOhLMGu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792cd975-3012-434e-2c2d-08db39cfe85f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 14:28:52.5884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPYPoP1gVqtYoLDBFOItq2BUtLE5C7/Av7YJDrckjv3Ix89O2gqnRIFFdUlNBAq9+kYUvWRPe0NV2QZHzJqvsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
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
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/04/2023 02:02, Bas Nieuwenhuizen wrote:
> On Wed, Mar 29, 2023 at 6:05 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch adds:
>> - A new IOCTL function to create and destroy
>> - A new structure to keep all the user queue data in one place.
>> - A function to generate unique index for the queue.
>>
>> V1: Worked on review comments from RFC patch series:
>>    - Alex: Keep a list of queues, instead of single queue per process.
>>    - Christian: Use the queue manager instead of global ptrs,
>>             Don't keep the queue structure in amdgpu_ctx
>>
>> V2: Worked on review comments:
>>   - Christian:
>>     - Formatting of text
>>     - There is no need for queuing of userqueues, with idr in place
>>   - Alex:
>>     - Remove use_doorbell, its unnecessary
>>     - Reuse amdgpu_mqd_props for saving mqd fields
>>
>>   - Code formatting and re-arrangement
>>
>> V3:
>>   - Integration with doorbell manager
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 113 ++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>>   3 files changed, 116 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 2d6bcfd727c8..229976a2d0e7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2749,6 +2749,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   };
>>
>>   static const struct drm_driver amdgpu_kms_driver = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 13e1eebc1cb6..353f57c5a772 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -22,6 +22,119 @@
>>    */
>>
>>   #include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_userqueue.h"
>> +
>> +static inline int
>> +amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>> +{
>> +    return idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ, GFP_KERNEL);
>> +}
>> +
>> +static inline void
>> +amdgpu_userqueue_free_index(struct amdgpu_userq_mgr *uq_mgr, int queue_id)
>> +{
>> +    idr_remove(&uq_mgr->userq_idr, queue_id);
>> +}
>> +
>> +static struct amdgpu_usermode_queue *
>> +amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>> +{
>> +    return idr_find(&uq_mgr->userq_idr, qid);
>> +}
>> +
>> +static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>> +{
>> +    struct amdgpu_usermode_queue *queue;
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>> +    int r;
>> +
>> +    /* Do we have support userqueues for this IP ? */
>> +    if (!uq_mgr->userq_funcs[mqd_in->ip_type]) {
>> +        DRM_ERROR("GFX User queues not supported for this IP: %d\n", mqd_in->ip_type);
>> +        return -EINVAL;
>> +    }
>> +
>> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>> +    if (!queue) {
>> +        DRM_ERROR("Failed to allocate memory for queue\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +    queue->userq_prop.wptr_gpu_addr = mqd_in->wptr_va;
>> +    queue->userq_prop.rptr_gpu_addr = mqd_in->rptr_va;
>> +    queue->userq_prop.queue_size = mqd_in->queue_size;
>> +    queue->userq_prop.hqd_base_gpu_addr = mqd_in->queue_va;
>> +    queue->userq_prop.queue_size = mqd_in->queue_size;
> This sets queue_size twice.

Noted,

- Shashank

>
>> +
>> +    queue->doorbell_handle = mqd_in->doorbell_handle;
>> +    queue->queue_type = mqd_in->ip_type;
>> +    queue->flags = mqd_in->flags;
>> +    queue->vm = &fpriv->vm;
>> +    queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
>> +    if (queue->queue_id < 0) {
>> +        DRM_ERROR("Failed to allocate a queue id\n");
>> +        r = queue->queue_id;
>> +        goto free_queue;
>> +    }
>> +
>> +    args->out.queue_id = queue->queue_id;
>> +    args->out.flags = 0;
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    return 0;
>> +
>> +free_queue:
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    kfree(queue);
>> +    return r;
>> +}
>> +
>> +static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>> +{
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +    struct amdgpu_usermode_queue *queue;
>> +
>> +    queue = amdgpu_userqueue_find(uq_mgr, queue_id);
>> +    if (!queue) {
>> +        DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
>> +        return;
>> +    }
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    kfree(queue);
>> +}
>> +
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>> +                      struct drm_file *filp)
>> +{
>> +    union drm_amdgpu_userq *args = data;
>> +    int r = 0;
>> +
>> +    switch (args->in.op) {
>> +    case AMDGPU_USERQ_OP_CREATE:
>> +        r = amdgpu_userqueue_create(filp, args);
>> +        if (r)
>> +            DRM_ERROR("Failed to create usermode queue\n");
>> +        break;
>> +
>> +    case AMDGPU_USERQ_OP_FREE:
>> +        amdgpu_userqueue_destroy(filp, args->in.queue_id);
>> +        break;
>> +
>> +    default:
>> +        DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
>> +        return -EINVAL;
>> +    }
>> +
>> +    return r;
>> +}
>> +
>>
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>>   {
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 7eeb8c9e6575..7625a862b1fc 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -42,6 +42,8 @@ struct amdgpu_userq_funcs {
>>          void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
>>   };
>>
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>> +
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
>>
>>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>> --
>> 2.40.0
>>
